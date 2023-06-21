
ChatData = Class('ChatData');


local _UIText = {
    [1] = "内容包含敏感词汇",
    [2] = "您说得太快了，喝杯茶休息一下吧！",
    [3] = "操作过于频繁，请稍候再试",
    [4] = "1天前",
    [5] = "1周前",

    [6] = "[%s]自己:[-]",
    [7] = "你对[%s]%s[-]说:",
    [8] = "[%s]%s[-]对你说:",
    [9] = "[%s]%s:[-]",

    [10] = "[%s][自己]:[-]",
    [11] = "你对[%s][%s][-]说:",
    [12] = "[%s][%s][-]对你说:",
    [13] = "[%s][%s]:[-]",
}

function ChatData:Init()    
    self.chatData = {}
    for k,v in pairs(PublicStruct.Chat) do
        self.chatData[v] = { haveUnreadData = false, data = {} }
    end
    
    --频道条数
    self.maxChannelCnt = 150
    self.timeNow = 0

    --小红点(主界面小窗口)
    self.showMainUiPoint = false 
end

function ChatData:SetShowMainUiPoint(v) 
    self.showMainUiPoint = v 
end

function ChatData:IsShowMainUiPoint() 
    return self.showMainUiPoint
end

--[[得到聊天记录]]
function ChatData:get_chat_data(type)
    if type == nil or type < PublicStruct.Chat.all or type > PublicStruct.Chat.fight then
        app.log('type = ' .. tostring(type) .. ' '.. debug.traceback())
        return
    end
    return self.chatData[type].data
end

--[[得到所有聊天记录]]
function ChatData:get_all_chat_data()
    return self:get_chat_data(PublicStruct.Chat.all)
end

--[[通过下标获得数据]]
function ChatData:get_chat_data_by_index(type, index)
    return self.chatData[type].data[index]
end

--[[得到具体类型的数量]]
function ChatData:get_chat_count(type)
	return #(self.chatData[type].data)
end

--[[是否有未读的数据]]
function ChatData:have_unread_data(type)
	return self.chatData[type].haveUnreadData
end

--[[设置未读的数据]]
function ChatData:set_unread_data(type, value)
    self.chatData[type].haveUnreadData = value
end

--[[储存聊天信息]]
function ChatData:add_chat(chat)    
    --检查是否已屏蔽此玩家
    if g_dataCenter.friend:GetBlacklistByPlayerGID(chat.sender.playerid) then
        return
    end
    --全部
	table.insert(self:get_all_chat_data(), chat)    
    -- 具体类型
    table.insert(self:get_chat_data(chat.type), chat)
    -- 小红点提示
    if not self:my_send_message(chat) then
        --系统不显示
        if chat.type ~= PublicStruct.Chat.system then
            self:set_unread_data(chat.type, true)
        end
        if chat.type == PublicStruct.Chat.whisper then
            self:SetShowMainUiPoint(true)
        end
    end

    self:RemoveInviteData(chat)
    self:remove_chat(chat) 
end

--[[删除聊天信息]]
function ChatData:remove_chat(chat) 
    if self:get_chat_count(PublicStruct.Chat.all) > self.maxChannelCnt then        
        table.remove(self:get_all_chat_data(), 1)
    end
    if self:get_chat_count(chat.type) > self.maxChannelCnt then    
        --删除声音数据 
        local chat_data = self:get_chat_data_by_index(chat.type, 1)          
        if chat_data.voice_index ~= nil then
            app.log("--->remove voice_index=" .. chat_data.voice_index)
            Im.remove_voice_data(chat_data.voice_index)
        end
        table.remove(self:get_chat_data(chat.type), 1)
    end
end

function ChatData:RemoveInviteData(chat) 
    for i = self:get_chat_count(chat.type), 1, -1 do
        local chat = self:get_chat_data_by_index(chat.type, i) 
        if self:IsExpiredInviteData(chat) then
            table.remove(self:get_chat_data(chat.type), i)
        end
    end
end

function ChatData:IsExpiredInviteData(chat) 
    if chat.inviteInfo == nil or chat.inviteInfo.invite_fail_time == '' then
        return false
    end
    if system.time() > tonumber(chat.inviteInfo.invite_fail_time) then
        return true
    end
    return false
end

--[[我发送的信息]]
function ChatData:my_send_message(data) 
    return data.sender.playerid == g_dataCenter.player:GetPlayerID()
end

--[[通过ID得到玩家信息]]
function ChatData:get_info_by_playerid(playerid)
    for k, v in pairs(self:get_all_chat_data()) do
        if tostring(v.sender.playerid) == tostring(playerid) then
            return v;
        end
    end
    return nil
end

local _channelSpriteName = {
    [PublicStruct.Chat.all] = "lt_quanbu",	
    [PublicStruct.Chat.horn] = "",		
	[PublicStruct.Chat.area] = "lt_quyu",
    [PublicStruct.Chat.guild] = "lt_shetuan",
    [PublicStruct.Chat.team] = "lt_duiwu",
    [PublicStruct.Chat.whisper] = "lt_siliao",
    [PublicStruct.Chat.world] = "lt_quanbu",
    [PublicStruct.Chat.system] = "lt_xitong",
    [PublicStruct.Chat.fight] = "lt_duijue",
}
function ChatData:GetSpriteName(type)
    if _channelSpriteName[type] then
        return _channelSpriteName[type]
    else
        app.log('sprite name 配置出错')
    end
end

--[[角色相关]]
function ChatData:GetRoleString(temp_data, withBracket)
    if temp_data.type == PublicStruct.Chat.system then
        return ""
    end
    local offset = 0
    if withBracket then
        offset = 4
    end
    local roleColor = self:GetRoleColorByVipLvl(temp_data.sender.vip)
    if not self:my_send_message(temp_data) then
        if temp_data.type == PublicStruct.Chat.whisper then	
            return string.format(_UIText[8 + offset], roleColor, temp_data.sender.name)       
        else
            return string.format(_UIText[9 + offset], roleColor, temp_data.sender.name)
        end
    else
        if temp_data.type == PublicStruct.Chat.whisper and temp_data.target then
            roleColor = self:GetRoleColorByVipLvl(temp_data.target.vip)
            return string.format(_UIText[7 + offset], roleColor, temp_data.target.name)       
        else
            return string.format(_UIText[6 + offset], roleColor)
        end
    end
end

function ChatData:GetRoleColorByVipLvl(vipLvl)
    local cur_color = '0bbdf9';    
    if vipLvl ~= nil then
        local vip_data = g_dataCenter.player:GetVipDataByLevel(vipLvl, 1);
        if vip_data then
            cur_color = vip_data.chat_role_color;
        end
    end
    return cur_color;
end

local _dayTime = 24 * 3600
local _weekTime = 7 * 24 * 3600

function ChatData:GetTimeStr(time)
    if time == nil or time == '' then 
        return '' 
    end
    local _diffTime = system.time() - tonumber(time)
    if _diffTime < 0 then
        return ""
    end

    if _diffTime >= _weekTime then
        return _UIText[5]
    elseif  _diffTime >= _dayTime then
        return _UIText[4]
    else
        local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(tonumber(time))
        return string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec) 
    end
    return ""
end

function ChatData:SendTextMessage(chatType, msg, playerId)
    if chatType == PublicStruct.Chat.whisper then
        if playerId == nil or playerId == ""  then
            app.log('player id error! ')
            return false
        end
    end
    --统一处理([全部]发送内容到[世界])
    if chatType == PublicStruct.Chat.all then
        chatType = PublicStruct.Chat.world
    end
	local valid, str = self:CheckMessage(msg) 
    if valid then
        msg_chat.cg_player_chat(chatType, str, playerId, 0)
        return true
    end	
    return false
end

function ChatData:CheckMessage(msg)
    local str = msg
    --敏感词提示
	local illStr = PublicFunc.Check_illegal(str)
	--[[if illStr ~= "" then
		FloatTip.Float(_UIText[1])
		return false, ""
	end]]
    --处理敏感词为*
	str = PublicFunc.SetIllegal(str)
    return true, str
end

local _intervalDefault = 1

function ChatData:CheckSendInterval()
    local appTime = app.get_time()
    if appTime - self.timeNow <= _intervalDefault then        
        FloatTip.Float(_UIText[2])
		return true
	end
	self.timeNow = appTime
    return false
end

-----------------加入冷却---------------------

local _coolingTimeDefault = 3    --冷却3秒
local _addIntervalDefault = 0.8  --间隔小于0.8秒触发冷却

function ChatData:IsAddCooling(data)
    if data.coolingTime ~= nil then
        if app.get_time() - data.coolingTime <= _coolingTimeDefault then
            FloatTip.Float(_UIText[3])
            return true
        else
            data.collingTime = nil
        end
    end 
    return false
end

function ChatData:UpdateAddInterval(data)
    local __appTime = app.get_time()
    --点击时间
    if data.lastClickTime == nil then
        data.lastClickTime = 0
    end   
    if __appTime - data.lastClickTime < _addIntervalDefault then
        --冷却开始
        FloatTip.Float(_UIText[3])
        data.coolingTime = __appTime
		return true
	end
	data.lastClickTime = __appTime
    return false
end

----------------------------------------------