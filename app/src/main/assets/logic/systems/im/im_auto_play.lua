
ImAutoPlay = {
    --等待播放数据
    Data = { },    
    --是否正在播放
    IsPlaying = false, 
    Setting = {
        AutoPlayChannels =
        {
            [PublicStruct.Chat.area] = false,
            [PublicStruct.Chat.guild] = false,
            [PublicStruct.Chat.team] = false,
            [PublicStruct.Chat.whisper] = false,
        },
        WifiAutoPlay = true,
    },
    FILE_NAME = "ImAutoPlayFile",
    IsPause = false,

    Callback = nil,
}

function ImAutoPlay.Push(chat)
    if ImAutoPlay.IsOpen(chat.type) then
        --wifi下才自动播放
        if ImAutoPlay.IsWifiAutoPlay() then
            if ImAutoPlay.IsWifiEnv() then
                table.insert(ImAutoPlay.Data, chat)
                app.log("ImAutoPlay.Push: yes")
            end
        else 
            table.insert(ImAutoPlay.Data, chat)
            app.log("ImAutoPlay.Push: yes")
        end        
    end
end

--[[是否开启自动播放]]
function ImAutoPlay.IsOpen(type)
    return ImAutoPlay.Setting.AutoPlayChannels[type] ~= nil and ImAutoPlay.Setting.AutoPlayChannels[type]
end

--[[wifi]]
function ImAutoPlay.IsWifiEnv()
    return Root.get_network_type() == PublicStruct.App_NetWork_TYpe.ReachableViaLocalAreaNetwork
end

function ImAutoPlay.Pop()
    if next(ImAutoPlay.Data) then
        local k, v = next(ImAutoPlay.Data)
        table.remove(ImAutoPlay.Data, 1)
        return v
    end
    return nil
end

function ImAutoPlay.Start()
    --从文件中读取设置
    ImAutoPlay.LoadSetting()
    Root.AddUpdate(ImAutoPlay.Update)
end

function ImAutoPlay.Update()
    if ImAutoPlay.IsPause then
        return
    end
    if not ImAutoPlay.IsPlaying then
        local data = ImAutoPlay.Pop()
        if data then
            ImAutoPlay.IsPlaying = true
            Im.start_play_request("", data.voice_index, tostring(data.voice_index .. '|' .. data.type), "ImAutoPlay.PlayCallBack")
            app.log("ImAutoPlay.Update->Im.start_play_request")
        end
    end
end

function ImAutoPlay.SetCallback(func)
    ImAutoPlay.Callback = func
end

function ImAutoPlay.PauseUpate(v)
    ImAutoPlay.IsPause = v
end

-- 自动播放回调函数
function ImAutoPlay.PlayCallBack(data)
    ImAutoPlay.IsPlaying = false

    if ImAutoPlay.Callback then
        local __ext = Utility.lua_string_split(data.ext, '|')
        Utility.CallFunc(ImAutoPlay.Callback, {voice_index = tonumber(__ext[1]), type = tonumber(__ext[2])})
    end
    --正在播放，正在录音，则不恢复
    if Im.StartRecording or Im.IsPlaying then
        return
    end
    Im.resume_record_or_play()
end

--[[设置频道自动播放语音]]
function ImAutoPlay.SetAutoPlayVoice(type, value)
    ImAutoPlay.Setting.AutoPlayChannels[type] = value
    --取消播放
    if not value then
        --清空此频道的数据
        for i = #ImAutoPlay.Data, 1, -1 do 
            local chat = ImAutoPlay.Data[i]
            if chat and chat.type == type then
                table.remove(ImAutoPlay.Data, i)
            end
        end
    end
    --存本地文件
    ImAutoPlay.SaveSetting()
end  

--[[获取设置]]
function ImAutoPlay.getAutoPlayVoice(type)
    return ImAutoPlay.Setting.AutoPlayChannels[type] 
end

function ImAutoPlay.SetWifiAutoPlay(value)
    ImAutoPlay.Setting.WifiAutoPlay = value
    --存本地文件
    ImAutoPlay.SaveSetting()
end 

function ImAutoPlay.IsWifiAutoPlay()
    return ImAutoPlay.Setting.WifiAutoPlay
end 

--[[加载配置]]
function ImAutoPlay.LoadSetting()
    if file.exist(ImAutoPlay.FILE_NAME) == true then
		local fileHandle = file.open_read(ImAutoPlay.FILE_NAME)
		local content = fileHandle:read_all_text()
		fileHandle:close();
		if content then
			local temp_table = loadstring("return " ..content);
			if temp_table then
				ImAutoPlay.Setting = temp_table();
			end
		end
	end
end

--[[保存配置]]
function ImAutoPlay.SaveSetting()
	local fileHandle = file.open(ImAutoPlay.FILE_NAME, 2);
	fileHandle:write_string(table.toLuaString(ImAutoPlay.Setting));
	fileHandle:close();
end