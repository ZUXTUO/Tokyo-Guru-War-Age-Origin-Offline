
NewFightUIWorldChat = Class('NewFightUIWorldChat', UiBaseClass)

local resPath = 'assetbundles/prefabs/ui/new_fight/new_fight_ui_chat.assetbundle'
local AREA_CHAT = "area_chat"
local WORLD_CHAT = "world_chat"
local GUILD_CHAT = "guild_chat"

local _UIText = {
    [12] = "您还没有加入公会！",
}

function NewFightUIWorldChat.GetResList()
    return {resPath}
end

function NewFightUIWorldChat:Init(data)
    self.pathRes = resPath;
    UiBaseClass.Init(self, data);
end

function NewFightUIWorldChat:DestroyUi()
    UiBaseClass.DestroyUi(self)
    ChatUI.Destroy()
    self.pos = nil;
end

function NewFightUIWorldChat:Restart(data)
    self.wrapContentItem = {} 
    UiBaseClass.Restart(self, data)
end

function NewFightUIWorldChat:InitData(data)
	UiBaseClass.InitData(self, data)
    self.chatData = g_dataCenter.chat 
end

function NewFightUIWorldChat:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['OnClickChatBtn'] = Utility.bind_callback(self, self.OnClickChatBtn);
    self.bindfunc['ReciveChatMsg'] = Utility.bind_callback(self, self.ReciveChatMsg);
    self.bindfunc["init_chat_item"] =  Utility.bind_callback(self, self.init_chat_item)    
    self.bindfunc["handle_btn"] =  Utility.bind_callback(self, self.handle_btn) 

    --语音相关
    self.bindfunc["on_press_call"] = Utility.bind_callback(self, self.on_press_call)
    self.bindfunc["on_drag_call"] = Utility.bind_callback(self, self.on_drag_call)
    self.bindfunc["on_voice_item_click"] = Utility.bind_callback(self, self.on_voice_item_click)
    self.bindfunc["on_voice_item_click_callback"] = Utility.bind_callback(self, self.on_voice_item_click_callback)
end

function NewFightUIWorldChat:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);    
    self.ui:set_name("new_fight_ui_chat")    

    if self.parent then
        self.ui:set_parent(self.parent);
    end

    --self.spDi1 = ngui.find_sprite(self.ui, 'animation/cont/sp_di')
    --self.spDi2 = ngui.find_sprite(self.ui, 'animation/cont/sp_di2')
    self.objScrollView = self.ui:get_child_by_name('animation/cont/scroll_view')

    --打开聊天窗口
    local btn_message = ngui.find_button(self.ui, 'animation/cont/scroll_view/sp_mark')
    btn_message:set_on_click(self.bindfunc['OnClickChatBtn'])

    self.spAreaChat = ngui.find_sprite(self.ui, 'animation/cont/btn1/sp')
    --录音按钮
    self.btnAreaChat = ngui.find_button(self.ui, 'animation/cont/btn1')
    self.btnAreaChat:set_name(AREA_CHAT)
    self.btnAreaChat:set_on_ngui_press(self.bindfunc["on_press_call"])
    self.btnAreaChat:set_on_ngui_drag_move(self.bindfunc["on_drag_call"])    
    
    self.btnGuildChat = ngui.find_button(self.ui, 'animation/cont/btn2')
    self.btnGuildChat:set_name(GUILD_CHAT)
    self.btnGuildChat:set_on_ngui_press(self.bindfunc["on_press_call"])
    self.btnGuildChat:set_on_ngui_drag_move(self.bindfunc["on_drag_call"]) 
       
    self:handle_btn()

    self.ui_wrap_list = ngui.find_wrap_list(self.ui, "animation/cont/scroll_view/panel_list/wrap_list")
    self.ui_wrap_list:set_on_initialize_item(self.bindfunc["init_chat_item"])
   
    self:SetSendPosition()
    self:ReciveChatMsg()
    self:Show();
end

function NewFightUIWorldChat:SetSendPosition()
    --获取发送按钮的屏幕y值
    local isSuc,rx,ry,rz = PublicFunc.SceneWorldPosToUIScreenPos(self.btnAreaChat:get_game_object():get_position())
    local width, height = self.spAreaChat:get_size()
    self.voice_y = ry + height / 2
end

function NewFightUIWorldChat:MsgRegist()
    PublicFunc.msg_regist(msg_chat.gc_add_player_chat, self.bindfunc['ReciveChatMsg'])
    PublicFunc.msg_regist(msg_guild.gc_sync_my_guild, self.bindfunc["handle_btn"])
    PublicFunc.msg_regist(player.gc_select_country, self.bindfunc['handle_btn'])
end

function NewFightUIWorldChat:MsgUnRegist()
    PublicFunc.msg_unregist(msg_chat.gc_add_player_chat, self.bindfunc['ReciveChatMsg'])
    PublicFunc.msg_unregist(msg_guild.gc_sync_my_guild, self.bindfunc["handle_btn"])
    PublicFunc.msg_unregist(player.gc_select_country, self.bindfunc['handle_btn'])
end

function NewFightUIWorldChat:OnClickChatBtn()
    ChatUI.SetAndShow()
end

function NewFightUIWorldChat:handle_btn()
    --self.spDi1:set_active(false)
    --self.spDi2:set_active(false)
    local x, y, z = self.objScrollView:get_local_position();

    --关卡不显示
--    if FightScene.GetPlayMethodType() == nil then
--        self.spDi2:set_active(true)
--        self.objScrollView:set_local_position(28, y, z)

--        self.btnGuildChat:set_active(false)
--        self.btnAreaChat:set_active(false)
--    else
        --self.spDi1:set_active(true)
        self.objScrollView:set_local_position(-117, y, z)

        local isJoin = g_dataCenter.guild:IsJoinedGuild()
        self.btnGuildChat:set_active(isJoin)

        local haveArea = tonumber(g_dataCenter.player.country_id) ~= 0
        self.btnAreaChat:set_active(haveArea)
--    end
end

function NewFightUIWorldChat:Update(dt)
    if self.ui == nil then return end
    --录音计时
    Im.update(dt)
end

function NewFightUIWorldChat:init_chat_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1   

    local temp_data = self.chatData:get_chat_data_by_index(PublicStruct.Chat.all, index)
	if temp_data == nil then		
        return 
    end	
    
    if self.wrapContentItem[row] == nil then 
        local item = {}
        item.cont1 = obj:get_child_by_name("cont1")
        item.cont2 = obj:get_child_by_name("cont2")

        item.spChannelText = ngui.find_sprite(obj, "cont2/sp")  
        item.spChannelVoice = ngui.find_sprite(obj, "cont1/sp") 

        item.lblText = ngui.find_label(obj, "cont2/lab") 
        item.labVoice = ngui.find_label(obj, "cont1/lab")

        item.btn_horn = ngui.find_button(obj, "cont1/sp_horn")
        --时长        
        item.lbl_num = ngui.find_label(obj, "cont1/lab_num")

        self.wrapContentItem[row] = item
    end
    local item = self.wrapContentItem[row]


    item.cont1:set_active(false)
    item.cont2:set_active(false)

    local roleStr = self.chatData:GetRoleString(temp_data)
    local spChannel = nil

    if temp_data.ctype == PublicStruct.Chat_Type.text then
        spChannel = item.spChannelText
        
        item.lblText:set_text('　　　' .. roleStr .. temp_data.content)             
        item.cont2:set_active(true)  
           
    elseif temp_data.ctype == PublicStruct.Chat_Type.voice then
        spChannel = item.spChannelVoice

        --频道及vip/玩家名及说
        item.labVoice:set_text('　　　' .. roleStr)

        --播放语音
        item.btn_horn:reset_on_click()
        item.btn_horn:set_on_click(self.bindfunc["on_voice_item_click"])       
        item.btn_horn:set_event_value("", temp_data.voice_index)        
        --时长  
        local time_txt = "(" .. Im.get_voice_time(temp_data.voice_index) .. "')"
        item.lbl_num:set_text(time_txt)
        item.cont1:set_active(true)
    end
    local _name = self.chatData:GetSpriteName(temp_data.type)
    spChannel:set_sprite_name(_name)
end


function NewFightUIWorldChat:ReciveChatMsg()
    if not self:IsShow() then
		return
	end
    if not self.ui:get_active_inhierarchy() then
        return
    end
    if self.ui_wrap_list == nil then return end
    self.ui_wrap_list:set_min_index(0)
    self.ui_wrap_list:set_max_index(self.chatData:get_chat_count(PublicStruct.Chat.all) - 1)
    self.ui_wrap_list:move_at_last()
    self.ui_wrap_list:reset()
end

function NewFightUIWorldChat:OnShow()
    self:ReciveChatMsg()
end

--[[录音]]
function NewFightUIWorldChat:on_press_call(name, state, x, y, go_obj ) 
    --开始录音
    if state then   
        --检查发送限制
        if not self:send_limit_check(name) then
            return
        end
        --保存之前通道
        if Im.BackupChannel == nil then
            Im.BackupChannel = Im.GetCurrentChannel()
        end
        --设置语音聊天通道
        if name == AREA_CHAT then
            Im.SetCurrentChannel(PublicStruct.Chat.area)
        --elseif name == WORLD_CHAT then
        --    Im.SetCurrentChannel(PublicStruct.Chat.world)
        elseif name == GUILD_CHAT then
            Im.SetCurrentChannel(PublicStruct.Chat.guild)
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
function NewFightUIWorldChat:on_drag_call(name, x, y, go_obj)
    Im.set_cancel_status(y > self.voice_y)
end

--[[发送检查]]
function NewFightUIWorldChat:send_limit_check(name) 
    if name == GUILD_CHAT then
        --判断有没有公会
		if not g_dataCenter.guild:IsJoinedGuild() then
			FloatTip.Float(_UIText[12])
			return false
		end
    end 
	if self.chatData:CheckSendInterval() then
		 return false
	end
    return true
end

function NewFightUIWorldChat:on_voice_item_click(data)   
    local index = tonumber(data.float_value)
    --是否正在播放
    if Im.check_voice_is_play(index) then
        return 
    end
    --恢复上一个播放状态 
    self:resume_play_voice_status(Im.LastPlayIndex) 
    Im.LastPlayIndex = index

    --播放语音 
    Im.start_play_request("", index, tostring(index), self.bindfunc["on_voice_item_click_callback"])
    --正在播放
    Im.set_voice_is_play(index, true)  
end

function NewFightUIWorldChat:on_voice_item_click_callback(data)
    local index = tonumber(data.ext)    
    self:resume_play_voice_status(index)    
end

--[[设置播放状态, 恢复游戏音效]]
function NewFightUIWorldChat:resume_play_voice_status(index)
    if index == nil then
        return
    end
    if Im.check_voice_is_play(index) then  
        --设置未播放
        Im.set_voice_is_play(index, false) 
        --恢复游戏音效
        Im.resume_record_or_play()
    end
    --主聊天窗口(隐藏喇叭)
    local chatUi = ChatUI.GetInstance()
    if chatUi and chatUi:IsShow() then
        chatUi:hidden_play_horn()
    end
end

function NewFightUIWorldChat:SetParent(parent)
    self.parent = parent;
    if not self.ui or not parent then return end;

    self.ui:set_parent(parent);
end