

--[[录音]]
function ChatUI:on_press_call(name, state, x, y, go_obj ) 
    --开始录音
    if state then   
        --检查发送限制
        if not self:send_limit_check() then
            return
        end
        if not Im.StartRecording then 
            --可能有录音正在播放
            self:resume_play_voice_status(Im.LastPlayIndex)            
            Im.start_audio_record()
        end
    --停止录音
    else
        Im.stop_audio_record()  
    end
end

--[[拖拽]]
function ChatUI:on_drag_call(name, x, y, go_obj)
    Im.set_cancel_status(y > self.voice_button_y)
end

--[[播放语音]]
function ChatUI:on_voice_item_click(data)
    app.log("ChatUI:on_voice_item_click" .. data.string_value)
    local index = data.float_value
    --是否正在播放
    if Im.check_voice_is_play(index) then
        return 
    end

    --恢复上一个播放状态 
    self:resume_play_voice_status(Im.LastPlayIndex)   
    Im.LastPlayIndex = index

    --显示喇叭
    local go = data.game_object   
    local sp_horn = ngui.find_sprite(go, "sp_la_ba") 
    sp_horn:set_active(true)  
    self.play_horn[index] = sp_horn    
    --隐藏小红点
    local sp_ti_shi = ngui.find_sprite(go, "sp_ti_shi")
    sp_ti_shi:set_active(false)     

    --播放语音 
    Im.start_play_request("", index, tostring(index), self.bindfunc["on_voice_item_click_callback"])
    --正在播放
    Im.set_voice_is_play(index, true)
end

function ChatUI:on_voice_item_click_callback(data)
    local index = tonumber(data.ext)
    self:resume_play_voice_status(index)
end

function ChatUI:resume_play_voice_status(index)
    if index == nil then
        return
    end
    app.log("ChatUI:resume_play_voice_status " .. tostring(index))
     
    --隐藏喇叭
    local sp_horn = self.play_horn[index]
    if sp_horn then 
        sp_horn:set_active(false)
        self.play_horn[index] = nil
    end 
    self:hidden_play_horn()

    if Im.check_voice_is_play(index) then  
        --设置未播放
        Im.set_voice_is_play(index, false) 
        --恢复游戏音效
        Im.resume_record_or_play()
    end
end

--[[其它频道 <==> 全部频道 / 综合面板 <==> 聊天面板 切换]]
function ChatUI:hidden_play_horn()
    if self.init_play_horn then
        self.init_play_horn:set_active(false)
        self.init_play_horn = nil
    end
end

--[[显示]]
function ChatUI:on_voice_setting_show()   
    if self.clsPopupUi == nil then
        self.clsPopupUi = ChatPopupUI:new()
    else
        self.clsPopupUi:SetInfo()
    end 
    self.clsPopupUi:Show()
end

function ChatUI:hidden_voice_tip(__data)
    if not self:IsShow() then
        return
    end

    for _, item in pairs(self.wrapContentItem) do
        if item.__voideIndex and item.__voideIndex == __data.voice_index then 
            if item.spHint then
                item.spHint:set_active(false)
                break
            end
        end
    end

    --此频道都已播放完
    --隐蔽频道小红点
    local allPlayed = true
    local allData = self.chatData:get_chat_data(__data.type)
    for _, v in pairs(allData) do
        if v.ctype == PublicStruct.Chat_Type.voice then
            if not Im.check_voice_have_play(v.voice_index) then
                allPlayed = false
                break
            end
        end
    end 
    
    if allPlayed then
        self.chatData:set_unread_data(__data.type, false) 
        for _, v in pairs(self.local_data.yeka_list) do
            if v.type ==  __data.type then
                v.sp_tip:set_active(false)
                break
            end
	    end  
    end
end