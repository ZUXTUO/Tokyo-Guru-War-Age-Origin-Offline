
local _UIText = {
    [1] = "已取消录音",
    [2] = "录音时间太短",
}

local _MAX_RETRY_COUNT = 2

Im = {
    --当前聊天频道
    CurrentChannel = nil,    
    BackupChannel = nil,

    --是否正在录音
    StartRecording = false,
    --正在播放
    IsPlaying = false,

    --录音时长
    RecordTime = 0,
    --最长录音时间
    MaxRecordTime = 10.1,

    --true取消发送
    IsCancel = false,   
    -- 私聊对象
    WhisperData = { playerid = nil, name = nil, vip = 1, image = 0 },   
    --登录
    IsLogin = false,
    IsReLogin = false,
    RetryCount = 0,

    --声音文件数据
    VoiceData = {},
    --上一个播放的声音序号
    LastPlayIndex = nil,
    --声音序号
    IncrementIndex = 0,

    --登录公会
    FirstloginGuild = true,
    SyncGuildId = false,
}

--[[
   wildCard 22_1000_0
   平台标识(第一位2)服务器Id_通道标识_通配符
]]
Im.WildCardData = {
    --[PublicStruct.Chat.horn] = 1000,
    [PublicStruct.Chat.area] = 1001,
    [PublicStruct.Chat.guild] = 1002,
    --[PublicStruct.Chat.team] = 1003,
    [PublicStruct.Chat.whisper] = 1004,
    [PublicStruct.Chat.world] = 1005,
    [PublicStruct.Chat.fight] = 1006,
}


-- -- 暂时屏蔽IM
-- local __im_mt = {
--     __index = function(t, k)
--         return function() end
--     end
-- }


-- setmetatable(Im, __im_mt);
-- do return end;



 
function Im.SetCurrentChannel(value)
    Im.CurrentChannel = value
end

function Im.GetCurrentChannel()
    return Im.CurrentChannel;
end

--[[设置私聊对象]]
function Im.SetWhisper(playerId, name, vip, image)
    app.log(string.format("Im.SetWhisper:[playerId=%s,name=%s,vip=%s,image=%s]", playerId, name, vip, image))
    Im.WhisperData.playerid = playerId
    Im.WhisperData.name = name
    Im.WhisperData.vip = vip
    Im.WhisperData.image = image
end

--[[获取私聊对象]]
function Im.GetWhisper()
    return Im.WhisperData
end

--[[检查私聊对象]]
function Im.ValidWhisper()
    return Im.WhisperData and Im.WhisperData.playerid and Im.WhisperData.name
end

function Im.GetOsStr()
    if Root.get_os_type() == PublicStruct.App_OS_Type.IPhonePlayer then
        return "1"
    else
        return "2"
    end
end

--[[获取所有频道通配符]]
function Im.GetAllWildCardStr()
    local str = "";
    for i = 1, table.get_num(PublicStruct.Chat) do
        if Im.WildCardData[i] then
            str = str .. Im.GetWildCardStrByChannel(i) .. "|"
        end
    end
    return str
end

--[[指定类型频道的通配符]]
function Im.GetWildCardStrByChannel(channel, id)
    local ext1 = Im.WildCardData[channel];
    local ext2 = "0"
    if channel == PublicStruct.Chat.guild then    
        if id ~= nil and id ~= "0" then
             ext2 = id
        else
            -- 获取公会id
            local myGuildId = g_dataCenter.guild:GetMyGuildId()
            if myGuildId ~= nil then
                ext2 = myGuildId
            end
        end
    elseif channel == PublicStruct.Chat.area then
        ext2 = g_dataCenter.player:GetCountryId()
    end
    return Im.GetImGameServerId() .. "_" .. ext1 .. "_" .. ext2
end

function Im.GetImGameServerId()
    local os_str = Im.GetOsStr();
    return tonumber(os_str .. ServerListData.get_enter_server_id())
end

function Im.GetImUid()
    local gsid = Im.GetImGameServerId();
    local account_id = g_dataCenter.player:GetPlayerID()
    return tostring(gsid .. account_id)
end

function Im.GetImUidByPid(pid)
    return tostring(Im.GetImGameServerId() .. pid)
end

---------------------------------------------------- 语聊接口 ---------------------------------------------------

function Im.init_sdk(context, appid, isTest)
    --平台检查， pc不支持
    if Root.get_os_type() ~= PublicStruct.App_OS_Type.Android 
        and Root.get_os_type() ~= PublicStruct.App_OS_Type.IPhonePlayer then
        return
    end
    Im.IsLogin = false
    Im.IsReLogin = false
    Im.RetryCount = 0,
    im.init_sdk(context, appid, isTest, "Im.init_sdk_callback")
end 

function Im.update(dt)    
    --录音计时
    if Im.StartRecording then
        Im.RecordTime = Im.RecordTime + dt
        if Im.RecordTime >= Im.MaxRecordTime then
            Im.RecordTime = 0
            Im.stop_audio_record()
        end
    end
    --第一次登录公会
    if Im.IsLogin and Im.SyncGuildId then
        if Im.FirstloginGuild then
            Im.FirstloginGuild = false
            Im.login_channel(PublicStruct.Chat.guild)
        end
    end
end 

--[[开始录音]]
function Im.start_audio_record()
    --平台检查， pc不支持
    if Root.get_os_type() ~= PublicStruct.App_OS_Type.Android 
        and Root.get_os_type() ~= PublicStruct.App_OS_Type.IPhonePlayer then
        return
    end
    
    --登录失败检查
    if not Im.IsLogin then
        Im.login_check()
        return
    end

    if Im.StartRecording then
        return
    end
    app.log("Im.start_audio_record")
    --初始化
    Im.IsCancel = false
    Im.RecordTime = 0
    Im.StartRecording = true
    --游戏静音
    Im.ready_record_or_play()
    im.start_audio_record()
end

--[[停止录音]]
function Im.stop_audio_record()    
    if not Im.StartRecording then
        return
    end
    app.log("Im.stop_audio_record");
    VoiceInfoUI.HideUI()
    Im.StartRecording = false
    im.stop_audio_record("Im.stop_audio_record_callback")     
end

--[[显示音量大小]]
function Im.show_voice_info(volume)
    --app.log("Im.show_voice_info  volume=" .. tostring(volume))
    if Im.StartRecording then
        if Im.IsCancel then
            VoiceInfoUI.ShowUI(EVoiceInfoUIType.cancel)
        else 
            VoiceInfoUI.ShowUI(EVoiceInfoUIType.speak, volume/100)
        end
    end 
end

--[[设置取消状态]]
function Im.set_cancel_status(is_cancel)
    Im.IsCancel = is_cancel
end
   
--[[发送语音消息]]
function Im.send_common_message(voiceTime, filePath)
    app.log("Im.send_common_message")
    local voicePath = filePath
    local wildCard = Im.GetWildCardStrByChannel(Im.GetCurrentChannel())
    local text = ""
    local expand = Im.GetSendExpandStr()
    local flag = ""    
    im.send_common_message(voicePath, voiceTime, wildCard, text, "Im.send_common_message_callback", expand, flag);
end

--[[发送私聊信息]]
function Im.send_whisper_message(voiceTime, filePath)
    if not Im.ValidWhisper() then
        -- TODO:私聊对象错误
        return
    end
    local whisper = Im.GetWhisper()
    local gameUserId = Im.GetImUidByPid(whisper.playerid)
    local txt = "";
    local flag = "";
    local ext = Im.GetSendExpandStr(true)
    im.send_whisper_message(gameUserId, filePath, voiceTime, txt, "Im.send_whisper_message_callback", flag, ext)
end

--[[
    播放录音
    url	string	录音url
    filePath 	录音文件路径（可以不必两者都传 但至少要传入一个）
    ext	string	
]]
function Im.start_play_request(filePath, index, ext, func)
    app.log("Im.start_play_request")    
    Im.ready_record_or_play()
    local url = Im.get_voice_url(index)   
    im.start_play_request(filePath, url, ext, func)
    --已播放
    Im.set_voice_have_play(index, true)
end

--[[播放及录音的准备]]
function Im.ready_record_or_play()
    --游戏静音
    g_dataCenter.setting:SetMute(true)
    im.stop_play_request()
    --暂停自动播放
    ImAutoPlay.PauseUpate(true)
end

--[[播放及录音的恢复]]
function Im.resume_record_or_play()
    ImAutoPlay.PauseUpate(false)
    g_dataCenter.setting:SetMute(false)  
end

--[[封装消息]]
function Im.GetSendExpandStr(isWhisper)
    -- vip image name,playerid,
    local _vip = g_dataCenter.player:GetVip()
    local _image = g_dataCenter.player:GetImage()
    local _name = g_dataCenter.player:GetName()
    local _playerid = g_dataCenter.player:GetPlayerID()
    local _type = Im.GetCurrentChannel()
    local sender =
    -- 自己
    {
        vip = _vip,
        image = _image,
        name = _name,
        playerid = _playerid,
        type = _type,
    }
    local target = nil
    --私聊信息构造
    if isWhisper then
        if Im.ValidWhisper() then
            local whisperData = Im.GetWhisper()
            target =
            {
                vip = whisperData.vip,
                image = whisperData.image,
                name = whisperData.name,
                playerid = whisperData.playerid,
                type = _type,
            }
        else
            app.log("get whisper data error！！！")
        end
    end

    if target then
        local temp = { sender = sender, target = target }
        return pjson.encode(temp)
    else
        return pjson.encode(sender)
    end
end 

--[[登录频道(公会/队伍), 其它频道不需要，统一开始已登录]]
function Im.login_channel(channel, id)
    local wildCard = Im.GetWildCardStrByChannel(channel, id)
    app.log(string.format("Im.login_channel:[channel=%s, wildCard=%s, id=%s]", tostring(channel), tostring(wildCard), tostring(id)))
    im.login_channel(channel, wildCard, "Im.login_channel_callback")
end

--[[登出频道(公会/队伍)]]
function Im.logout_channel(channel, id)
    local wildCard = Im.GetWildCardStrByChannel(channel, id)
    app.log(string.format("Im.logout_channel:[channel=%s, wildCard=%s, id=%s]", tostring(channel), tostring(wildCard), tostring(id)))
    im.logout_channel(channel, wildCard, "Im.logout_channel_callback")
end

--[[登录登出公会]]
function Im.handle_voice_guild(oldGuildId, guildid)
    app.log("Im.handle_voice_guild --> " .. oldGuildId .. ' ' .. guildid .. ' ' .. tostring(Im.IsLogin))
    Im.SyncGuildId = true

    if not Im.IsLogin then
        return 
    end
    if oldGuildId ~= "0" then
        --Im.logout_channel(PublicStruct.Chat.guild, oldGuildId)
        --语音服务器的bug
        --解决：登录其它任意频道编号, 调用login channel
        Im.login_channel(PublicStruct.Chat.guild, "1000")        
    end
    if guildid ~= "0"then
        Im.login_channel(PublicStruct.Chat.guild, guildid)
    end
end

--[[登录区域]]
function Im.handle_voice_area()
    if not Im.IsLogin then
        return 
    end 
    Im.login_channel(PublicStruct.Chat.area)
end

---------------------------------- 接口callback -------------------------------------


--[[语音sdk初始化回调]]
function Im.init_sdk_callback(result)
    app.log("im init_sdk_callback 初始化结果：" .. tostring(result))
    Im.login()
end

function Im.login()
    local wild_card = Im.GetAllWildCardStr()
    local game_server_id = Im.GetImGameServerId()
    local uid = Im.GetImUid();
    local nick_name = g_dataCenter.player:GetName()
    app.log(string.format("Im.login:[game_server_id=%s, uid=%s, nick_name=%s, wild_card=%s]", tostring(game_server_id), tostring(uid), nick_name, wild_card));
    im.login(tostring(game_server_id), uid, nick_name, 0, "Im.login_callback", wild_card)
end
 
--[[登录回调]]
function Im.login_callback(loginRes)
    app.log("Im.login_callback:" .. table.tostring(loginRes))
    if loginRes.result == 0 then
        --登录标记
        Im.IsLogin = true
        --注册监听声音在大小
        im.register_volume_notify("Im.show_voice_info")
        --注册频道消息通知回调
        im.register_common_notify("Im.common_notify_callback")
        --注册私聊消息通知回调
        im.register_whisper_notify("Im.whisper_notify_callback")
        --注册自动播放
        ImAutoPlay.Start()      
    else
        app.log("im 登录失败:" .. loginRes.msg)
    end
    Im.login_check()
end 

--[[登录检查]]
function Im.login_check()
    if Im.IsLogin then
        if Im.IsReLogin then
            Im.IsReLogin = false
            TimerManager.Remove(Im.reLogin)
        end
    else
        --登录失败, 重试
        if not Im.IsReLogin then
            app.log('Im.login_check  --- > TimerManager.Add')
            Im.IsReLogin = true
            Im.RetryCount = 0            
            TimerManager.Add(Im.reLogin, 2000, _MAX_RETRY_COUNT)            
        end
        if Im.RetryCount == _MAX_RETRY_COUNT then
            Im.IsReLogin = false
        end
    end
end

function Im.reLogin()
    Im.RetryCount = Im.RetryCount + 1
    app.log('Im.reLogin  --- > count ' .. tostring(Im.RetryCount))
    Im.login()
end

--[[停止录音回调]]
function Im.stop_audio_record_callback(voiceTime, filePath)
    app.log("im.stop_audio_record_callback:voiceTime =" .. tostring(voiceTime) .. " filePath=" .. filePath .. " Im.IsCancel=" .. tostring(Im.IsCancel))
        
    Im.resume_record_or_play()  
    --已取消
    if Im.IsCancel then
        FloatTip.Float(_UIText[1])
        return
    end
    --录音时长判断
    if voiceTime < 1000 then
        FloatTip.Float(_UIText[2])
        return
    end
    app.log("开始发送")
    if Im.CurrentChannel == PublicStruct.Chat.whisper then
        -- 私聊
        Im.send_whisper_message(voiceTime, filePath)
    else
        Im.send_common_message(voiceTime, filePath)
    end    
end

--[[登录到频道回调]]
function Im.login_channel_callback(res)
    app.log("Im.login_channel_callback:" .. table.tostring(res))
    if res.result == 0 then
    else
        app.log("Im.login_channel_callback:" .. res.msg)
    end
end

--[[登出到频道回调]]
function Im.logout_channel_callback(res)
    app.log("Im.logout_channel_callback:" .. table.tostring(res))
    if res.result == 0 then
    else
        app.log("Im.logout_channel_callback:" .. res.msg)
    end
end

--[[发送频道语音回调函数]]
function Im.send_common_message_callback(msg)
    app.log("Im.send_common_message_callback:" .. table.tostring(msg))
    -- 返回结果0为成功，非0是失败,1004是被禁言
    if (msg.result == 0) then
        local expand = pjson.decode(msg.expand)
        app.log("Im.im_send_chanel_voice_message_callback:expand=" .. table.tostring(expand))
        local _sender =
        {
            vip = expand.vip,
            image = expand.image,
            name = expand.name,
            playerid = expand.playerid,
            type = expand.type,
        }
        -- 构造聊天数据
        local tmsg = {
            target =
            {
                vip = 0,
                image = 0,
                name = '',
                playerid = '',
            },
            type = expand.type,
            content = msg.textMsg,
            sender = _sender,            
        }
        local im_info = {
            url = msg.url,
            time = msg.voiceDurationTime,
        }
        Im.add_chat_voice(tmsg, im_info, msg)

    elseif msg.rsult == 1004 then
        app.log("账号被禁言")
    else
        app.log("未知错误")
    end

end

--[[发送私聊信息回调]]
function Im.send_whisper_message_callback(msg)
    app.log("Im.send_whisper_message_callback:" .. table.tostring(msg))
    if (msg.result == 0) then
        local expand = pjson.decode(msg.ext1)
        -- 发送者 必然是自己 也可以从本地取数据
        app.log("Im.send_whisper_message_callback:expand=" .. table.tostring(expand))
        local _sender = expand.sender

        -- 接收者
        local _target = expand.target

        -- 构造聊天数据
        local tmsg = {
            target = _target,
            type = _sender.type,
            content = msg.textMsg,
            sender = _sender,
        }
        local im_info = {
            url = msg.audiourl,
            time = msg.audiotime,
        }
        Im.add_chat_voice(tmsg, im_info, msg)

    elseif msg.rsult == 1004 then
        app.log("账号被禁言")
    else
        app.log("未知错误")
    end
end

--[[频道消息通知回调]]
function Im.common_notify_callback(msg)
    app.log("Im.common_notify_callback:" .. table.tostring(msg))

    local expand = pjson.decode(msg.ext1)
    local _sender =
    {
        vip = expand.vip,
        image = expand.image,
        name = expand.name,
        playerid = expand.playerid,
        type = expand.type
    }
    -- 构造聊天数据
    local tmsg = {
        target =
        {
            vip = 0,
            image = 0,
            name = '',
            playerid = '',
            type = expand.type,
        },
        type = expand.type,
        content = msg.textMsg,
        sender = _sender,        
    }
    local im_info = {
        url = msg.messageBody,
        time = msg.voiceDuration,
    }
    Im.add_chat_voice(tmsg, im_info, msg)
end

--[[私聊消息通知回调]]
function Im.whisper_notify_callback(msg)
    app.log("Im.whisper_notify_callback" .. table.tostring(msg))

    local expand = pjson.decode(msg.ext1)
    local _sender = expand.sender
    local _target = expand.target
    -- 构造聊天数据
    local tmsg = {
        target = _target,

        type = _target.type,       
        content = msg.textMsg,
        sender = _sender,        
    }
    local im_info = {
        url = msg.data,
        time = msg.audioTime,
    }
    Im.add_chat_voice(tmsg, im_info, msg)
end

--[[获取自动增长的index]]
function Im.get_increment_index()
    Im.IncrementIndex = Im.IncrementIndex + 1
    return Im.IncrementIndex
end

--[[添加语音]]
function Im.add_chat_voice(chat, im_info, msg)
    if chat.type == nil then
        app.log('Im.add_chat_voice msg = ' .. table.tostring(msg) .. '  ' .. debug.traceback())
        return
    end
    --语音编号
    chat.voice_index = Im.get_increment_index()

    chat.time = system.time()
    --语音类型
    chat.ctype = PublicStruct.Chat_Type.voice  

    --存储声音
    local data = Im.save_voice_data(chat, im_info)     
    g_dataCenter.chat:add_chat(chat)
    --服务器语音消息分发
    PublicFunc.msg_dispatch(msg_chat.gc_add_player_chat)

    --加入到自动播放  
    if not data.have_play then     
        ImAutoPlay.Push(chat)
    end
end

--[[存储声音数据]]
function Im.save_voice_data(chat, im_info)
    local temp_data = {}
    --已经播放标志
    temp_data.have_play = false
    if g_dataCenter.chat:my_send_message(chat) then
        temp_data.have_play = true
    end
    --是否播放
    temp_data.is_play = false

    temp_data.url = im_info.url
    temp_data.time = im_info.time 

    Im.VoiceData[chat.voice_index] = temp_data
    return temp_data
end

--[[清除数据]]
function Im.remove_voice_data(index)
    Im.VoiceData[index] = nil
end

--[[获取声音url]]
function Im.get_voice_url(index)    
    local data = Im.VoiceData[index]
    if data ~= nil then
        return data.url
    end
    return ""
end

--[[获取声音播放秒数]]
function Im.get_voice_time(index)    
    local data = Im.VoiceData[index]
    if data ~= nil then
        return tostring(math.floor(data.time / 1000))
    end
    return ""
end

--[[是否播放]]
function Im.check_voice_is_play(index)
    local data = Im.VoiceData[index]
    if data ~= nil then
        return data.is_play
    end
    return false
end

--[[设置播放状态]]
function Im.set_voice_is_play(index, v)    
    local data = Im.VoiceData[index]
    if data ~= nil then
        data.is_play = v
        Im.IsPlaying = v
    end
end

--[[已播放]]
function Im.check_voice_have_play(index)    
    local data = Im.VoiceData[index]
    if data ~= nil then
        return data.have_play
    end
    return false
end

--[[设置已播放]]
function Im.set_voice_have_play(index, v)    
    local data = Im.VoiceData[index]
    if data ~= nil then
        data.have_play = v
    end
end
