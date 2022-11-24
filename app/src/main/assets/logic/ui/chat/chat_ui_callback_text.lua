
local _UIText = {
    [32] = "对你说:",
    [33] = "说:",
    [34] = "加入社团成功！",
    [35] = "按住说话",
    [36] = "点击输入内容",
    [37] = "您还没有加入公会！",
    [38] = "请选择玩家！",
    [39] = "此条邀请已失效！",
    [40] = "等级太低！",
    [41] = "请切换到其他频道发言",
    [42] = "战队等级达到[FFCC00]%s级[-]时开启聊天",
    [43] = "你已加入社团，不可重复加入",

    [44] = "[约战申请]",
    [45] = "[点击加入]",
    [46] = "约战成功",
}

--[[点击关闭]]
function ChatUI:on_close()
    --正在录音不能关闭
    if Im.StartRecording then
        return
    end
	if self.hideCallbackFunc then
		Utility.CallFunc(self.hideCallbackFunc)
	end
	--self:DestroyUi()
    self:Hide()
end

function ChatUI:get_yeka_data(type)
    for k, v in pairs(self.local_data.yeka_list) do
        if v.type == type then
            return v
        end
    end
    return nil
end

    --语音与文本输入切换
function ChatUI:on_switch_text_voice(t) 
    local curr_type = t.float_value
    local set_type = nil
    if curr_type == PublicStruct.Chat_Type.text then
        set_type = PublicStruct.Chat_Type.voice
    elseif curr_type == PublicStruct.Chat_Type.voice then
        set_type = PublicStruct.Chat_Type.text
    end   
    --更新类型 
    self:get_yeka_data(self.showType).chat_type = set_type
    self:show_send_ui() 
end

function ChatUI:show_current_pane(type) 
    if type ~= nil then 
        self.showType = type
    end
    -- 设置语音聊天当前频道
    if self.showType ~= PublicStruct.Chat.system then
        --统一处理([全部]发送内容到[世界])
        if self.showType == PublicStruct.Chat.all then
            Im.SetCurrentChannel(PublicStruct.Chat.world)
        else
            Im.SetCurrentChannel(self.showType)
        end        
    end

    for _, v in pairs(self.local_data.yeka_list) do
        v.toggle:set_value(self.showType == v.type) 
    end	

    --选中私聊
    if self.showType == PublicStruct.Chat.whisper then        
        --语聊
        if self.click_playerid ~= '' then
            local info = self.chatData:get_info_by_playerid(self.click_playerid)
            if info ~= nil then
                Im.SetWhisper(self.click_playerid, info.sender.name, info.sender.vip, info.sender.image)
            else    
                --外部接口调口传参
                if ChatUI.__extData then
                    Im.SetWhisper(ChatUI.__extData.playerId, ChatUI.__extData.playerName, 
                        ChatUI.__extData.vip, ChatUI.__extData.image)
                end
            end
        end
    end   
	self:updateTab()    
    --显示发送ui
    self:show_send_ui() 
end

--[[点击聊天页卡]]
function ChatUI:on_yeka_touch(value, name)
    if value then
	    if not self.isSecond then
            self.isSecond = true
        else
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.ChatNormal)
        end
        if self.showType ~= tonumber(name) then
            self:show_current_pane(tonumber(name))
        end
    end
end

--[[刷新页卡]]
function ChatUI:updateTab(isMoveLast)
    if not self:IsShow() then
		return
	end
    --更新提示
    self:show_tips()
    --更新数据
    self:update_chat_data(isMoveLast)
end

--[[显示小红点提示]]
function ChatUI:show_tips()
    --当前频道已读
    self.chatData:set_unread_data(self.showType, false)

    for _, v in pairs(self.local_data.yeka_list) do
        --有未读数据
        if v.sp_tip then
		    if self.chatData:have_unread_data(v.type) then
                v.sp_tip:set_active(true)
		    else
			    v.sp_tip:set_active(false)
		    end
        end
	end
end

--[[更新聊天数据]]
function ChatUI:update_chat_data(isMoveLast)
    if self.ui_wrap_list == nil then return end

    local isBottom = self.ui_wrap_list:is_bottom()
    self.ui_wrap_list:set_min_index(0)
    self.ui_wrap_list:set_max_index(self.chatData:get_chat_count(self.showType) - 1)

    local flag = false
    if isMoveLast == nil or isMoveLast == true then
        flag = true
    else
        if isBottom then
            flag = true
        end
    end
    if flag then
        self.ui_wrap_list:move_at_last()
        self.ui_wrap_list:reset()
    end
end

--[[聊天ITEM]]
function ChatUI:init_chat_item(obj, b, real_id)	
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1
    --app.log('----->' .. index .. '    ' .. row)

	local temp_data = self.chatData:get_chat_data_by_index(self.showType, index)
	if temp_data == nil then		
        return 
    end	

    if self.wrapContentItem[row] == nil then 
        local item = {}
        item.objLeft = obj:get_child_by_name("left")

        item.spChannelName = ngui.find_sprite(obj, "left/sp_category")
        item.objVip = obj:get_child_by_name("left/cont1") 
        item.objPlayerName = obj:get_child_by_name("left/cont2")  

        item.lblVip = ngui.find_label(obj, "left/cont1/sp_v")
        item.btnPlayerName = ngui.find_button(obj, "left/cont2/lab_name")
        item.lblPlayerName = ngui.find_label(obj, "left/cont2/lab_name")

        item.lblTxt = ngui.find_label(obj, "left/cont2/txt")              

        local _textPath = "left/container/"
        item.objContent =obj:get_child_by_name(_textPath) 
        item.lblContent = ngui.find_label(obj, _textPath .. "lab_content")    
        item.btnAdd = ngui.find_button(obj, _textPath .. "wd_container/btn1")
        item.lblBtnAdd = ngui.find_label(obj, _textPath .. "wd_container/btn1/animation/lab")

        item.lblTime = ngui.find_label(obj, "left/cont2/lab_time") 

        local _voicePath = "left/yu_yin_anniu/"
        item.objVoiceContent = obj:get_child_by_name(_voicePath) 
        item.btnVoiceContent = ngui.find_button(obj, _voicePath .. "sp_yu_yin") 

        item.spHint = ngui.find_sprite(obj, _voicePath .. "sp_yu_yin/sp_ti_shi")
        item.spHorn = ngui.find_sprite(obj, _voicePath .. "sp_yu_yin/sp_la_ba")        
        item.lblVoiceTime = ngui.find_label(obj,  _voicePath .. "sp_yu_yin/lab")
        self.wrapContentItem[row] = item
    end
    local item = self.wrapContentItem[row]
    --保存语音序号
    item.__voideIndex = nil

    --显示位置	
	item.objLeft:set_active(true)
    --VIP
    --[[local vVip = temp_data.sender.vip
    local _x, _y, _z = item.lblPlayerName:get_position()
    if vVip >= 1 then
        item.lblPlayerName:set_position(10, _y, _z)
    else
        item.lblPlayerName:set_position(-48, _y, _z)
    end
    PublicFunc.SetImageVipLevel(item.lblVip, vVip)]]

    local _x, _y, _z = item.lblPlayerName:get_position()
    item.lblPlayerName:set_position(-48, _y, _z)
    item.btnAdd:set_active(false)

    item.btnPlayerName:reset_on_click()
    if not self.chatData:my_send_message(temp_data) then
        --点击玩家       
        if temp_data.type ~= PublicStruct.Chat.system then	        
            if temp_data.sender.name == nil or temp_data.sender.name == "" then
                app.log("sender name = " .. tostring(temp_data.sender.name) .. '  temp_data = ' .. table.tostring(temp_data))
                temp_data.sender.name = ""
            end
            item.btnPlayerName:set_event_value(tostring(temp_data.sender.playerid .."|" .. temp_data.sender.name), temp_data.type)
	        item.btnPlayerName:set_on_click(self.bindfunc["on_item_click"])
        end  
        --加入        
        if temp_data.isInvite then
            item.btnAdd:set_active(true)
            item.btnAdd:reset_on_click()
            item.btnAdd:set_event_value("", index)
	        item.btnAdd:set_on_click(self.bindfunc["on_click_add"])

            if temp_data.inviteInfo.nType == ENUM.InvitePlayName.ChatFight then
                item.lblBtnAdd:set_text(_UIText[44])
            else
                item.lblBtnAdd:set_text(_UIText[45])
            end
        end
    else
        if temp_data.type == PublicStruct.Chat.whisper and temp_data.target then	
            if temp_data.type ~= PublicStruct.Chat.system then
                if temp_data.target.name == nil or temp_data.target.name == "" then
                    app.log("target name = " .. tostring(temp_data.target.name) .. '  temp_data = ' .. table.tostring(temp_data))
	                temp_data.target.name = ""
	            end	        
                item.btnPlayerName:set_event_value(tostring(temp_data.target.playerid .."|" .. temp_data.target.name), temp_data.type)
	            item.btnPlayerName:set_on_click(self.bindfunc["on_item_click"])
            end 
        end
    end  
    item.lblPlayerName:set_text(self.chatData:GetRoleString(temp_data, true))

    --系统频道(隐藏vip, 玩家名)
	if temp_data.type == PublicStruct.Chat.system then	
        if item.objVip then	    
            item.objVip:set_active(false)            
        end
        item.objPlayerName:set_active(false)
    else 
        if item.objVip then
            item.objVip:set_active(false)            
        end
        item.objPlayerName:set_active(true)
	end
    item.lblTxt:set_text("")
    
	--频道名
    local spName = self.chatData:GetSpriteName(temp_data.type)
    item.spChannelName:set_sprite_name(spName)	
    
    item.objContent:set_active(false)
    item.objVoiceContent:set_active(false)    

    if temp_data.ctype == PublicStruct.Chat_Type.text then
	    item.objContent:set_active(true)
	    item.lblContent:set_text(tostring(temp_data.content))

    elseif temp_data.ctype == PublicStruct.Chat_Type.voice then	
        item.objVoiceContent:set_active(true)

        item.btnVoiceContent:reset_on_click()
        item.btnVoiceContent:set_on_click(self.bindfunc["on_voice_item_click"])        
        item.btnVoiceContent:set_event_value("", temp_data.voice_index);        
        --播放喇叭
        local is_play = Im.check_voice_is_play(temp_data.voice_index)
        item.spHorn:set_active(is_play)
        if is_play then
            self.init_play_horn = item.spHorn
        end
        --小红点
        local have_play = Im.check_voice_have_play(temp_data.voice_index)
        item.spHint:set_active(not have_play)
        --语音时长        
        item.lblVoiceTime:set_text(Im.get_voice_time(temp_data.voice_index) .."秒")

        item.__voideIndex = temp_data.voice_index
    end	
    local timeStr = self.chatData:GetTimeStr(temp_data.time)
    if timeStr == '' then
        item.lblTime:set_active(false)
    else
        item.lblTime:set_active(true)
        item.lblTime:set_text(timeStr)
    end
end

function ChatUI:on_click_add(t)
    local data = self.chatData:get_chat_data_by_index(self.showType, t.float_value)
    --是否失效
    if self.chatData:IsExpiredInviteData(data) then
        FloatTip.Float(_UIText[39])
        return
    end
    --检查冷却
    if self.chatData:IsAddCooling(data) then
        return        
    end
    --更新间隔
    if self.chatData:UpdateAddInterval(data) then
        return
    end   

    if data.inviteInfo.nType == ENUM.InvitePlayName.CloneWar then
        if not g_dataCenter.CloneBattle:IsJoinThisGame() then
            FloatTip.Float(_UIText[40])
            return
        end
    elseif data.inviteInfo.nType == ENUM.InvitePlayName.GuildInvite then
        if g_dataCenter.guild:IsJoinedGuild() then
            FloatTip.Float(_UIText[43])
            return;
        end
    end
    player.cg_invite_state(0, data.inviteInfo)
end

function ChatUI:on_invite_state(result, state, info)
    if state ~= 0 then
        return
    end
    if info.nType == ENUM.InvitePlayName.ThreeToThree then
        --主动设置到组队阶段
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]:SetStage(1)
        --打开3V3房间UI（未打开3v3入口界面，这里要提前发送数据请求）
        msg_three_to_three.cg_three_to_three_state()
        uiManager:PushUi(EUI.QingTongJiDiRoomUI, info)

    elseif info.nType == ENUM.InvitePlayName.CloneWar then
        uiManager:PushUi(EUI.CloneBattleTeamUI)

    elseif info.nType == ENUM.InvitePlayName.GuildInvite then
        FloatTip.Float(_UIText[34])
    end

    if info.nType == ENUM.InvitePlayName.ChatFight then
        FloatTip.Float(_UIText[46])
    else
        self:on_close()
    end
end

--[[点击玩家头像]]
function ChatUI:on_item_click(t)
    local str_tab = Utility.lua_string_split(t.string_value, '|')
    self.click_playerid = str_tab[1]
    self.click_player_name = str_tab[2]
    OtherPlayerPanel.ShowPlayer(self.click_playerid, ENUM.ETeamType.normal,nil,true)
end

--[[显示相关的发送ui]]
function ChatUI:show_send_ui()
    --玩家等级检查
    local openLevel = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_chat_open_level).data
    if g_dataCenter.player:GetLevel() < openLevel and self.showType ~= PublicStruct.Chat.system then
        self.lblSendUILabel:set_text(string.format(_UIText[42], openLevel))
        for _, v in ipairs(self.local_data.send_ui_config) do
            if v.type == self.send_ui_type.switch then
                v.obj_ui:set_active(true)
            else 
                v.obj_ui:set_active(false)
            end
        end 
    else
        self.lblSendUILabel:set_text(_UIText[41])
        local curr_type = self:get_yeka_data(self.showType).chat_type
        if curr_type ~= nil and curr_type == PublicStruct.Chat_Type.voice then
            self:show_send_voice_ui()
        else
            self:show_send_text_ui() 
        end  
    end
end

--[[显示语音发送ui]]
function ChatUI:show_send_voice_ui()    
    local config = nil
    for _, v in ipairs(self.local_data.send_ui_config) do
        if v.type == self.send_ui_type.voice then
            v.obj_ui:set_active(true)
            config = v
        else 
            v.obj_ui:set_active(false)
        end
    end 
    local type = self:get_yeka_data(self.showType).send_ui_type
    if type == self.send_ui_type.common then
        if self.showType == PublicStruct.Chat.whisper then
            if self.click_playerid == '' then
                config.lblName:set_text("[938bff]To：[-]" .. _UIText[35])  
            else
                config.lblName:set_text("[938bff]To[" .. self.click_player_name .. "]：[-]" .. _UIText[35])
            end
        else
            config.lblName:set_text(_UIText[35])
        end
    end
end

--[[显示文本发送ui]]
function ChatUI:show_send_text_ui()
    local type = self:get_yeka_data(self.showType).send_ui_type
    local config = nil
    for _, v in ipairs(self.local_data.send_ui_config) do
        if v.type == type then
            v.obj_ui:set_active(true)
            config = v
        else 
            v.obj_ui:set_active(false)
        end
    end 
    if type == self.send_ui_type.common then
        --显示或隐藏喇叭
        --config.objHorn:set_active(false)
        config.objCommon:set_active(false)        
        if self.showType == PublicStruct.Chat.horn then
            --config.objHorn:set_active(true)
            --config.lblHornNum:set_text("x999")
        else 
            config.objCommon:set_active(true)            
        end
        --私聊玩家名
        if self.showType == PublicStruct.Chat.whisper then
            if self.click_playerid == '' then
                config.lblName:set_text("To：")  
            else
                config.lblName:set_text("To[" .. self.click_player_name .. "]：")
            end  
        else
             config.lblName:set_text("")  
        end      
        --
        if self.showType == PublicStruct.Chat.horn then           
            --self.ui_send_input = config.lbl_input_horn
        else
            self.ui_send_input = config.lbl_input
        end 
        self.ui_send_input:set_characterlimit(tostring(50))
	    self.ui_send_input:set_default_text(_UIText[36])
	    self.ui_send_input:set_value("")
    end   
end

--[[发送聊天]]
function ChatUI:on_send_message()
	local str = self.ui_send_input:get_value()

	if PublicFunc.trim(str) == "" then
		self.ui_send_input:set_default_text(_UIText[36])
		return
	end
    --检查限制
    if not self:send_limit_check() then
        return
    end

    --替换']', 处理如'[ff0000] ...'
    str = string.gsub(str, "]", "")

    --发送消息
    if self.chatData:SendTextMessage(self.showType, str, self.click_playerid) then
        self.ui_send_input:set_value("")
    end
end

--[[发送检查]]
function ChatUI:send_limit_check() 
    if self.showType == PublicStruct.Chat.guild then
        --判断有没有公会
		if not g_dataCenter.guild:IsJoinedGuild() then
			FloatTip.Float(_UIText[37])
			return false
		end
    elseif self.showType == PublicStruct.Chat.horn then
        --检查喇叭数

	elseif self.showType == PublicStruct.Chat.whisper then
		if self.click_playerid == "" then
			FloatTip.Float(_UIText[38])
			return false
		end
	end  
	if self.chatData:CheckSendInterval() then
		 return false
	end
    return true
end