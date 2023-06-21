
MainUIChat = Class('MainUIChat', UiBaseClass)

--local resPath = 'assetbundles/prefabs/ui/new_fight/new_fight_ui_zjm_chat.assetbundle'

function MainUIChat.GetResList()
    return {resPath}
end

function MainUIChat:Init(data)
    --self.pathRes = resPath;
    self.isOpen = true
    UiBaseClass.Init(self, data);
end

function MainUIChat:DestroyUi()
    UiBaseClass.DestroyUi(self)
    ChatUI.Destroy()
    self.pos = nil;
end

function MainUIChat:Restart(data)
    self.wrapContentItem = {} 
    UiBaseClass.Restart(self, data)
end
function MainUIChat:InitData(data)
	UiBaseClass.InitData(self, data)
    self.chatData = g_dataCenter.chat 
end

function MainUIChat:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['OnClickChatBtn'] = Utility.bind_callback(self, self.OnClickChatBtn);
    self.bindfunc['ReciveChatMsg'] = Utility.bind_callback(self, self.ReciveChatMsg);
    self.bindfunc["on_play_animation"] =  Utility.bind_callback(self, self.on_play_animation);
    self.bindfunc["init_chat_item"] =  Utility.bind_callback(self, self.init_chat_item)  
    self.bindfunc['on_btn_chat'] = Utility.bind_callback(self, self.on_btn_chat);   

    --语音相关
    self.bindfunc["on_voice_item_click"] = Utility.bind_callback(self, self.on_voice_item_click)
    self.bindfunc["on_voice_item_click_callback"] = Utility.bind_callback(self, self.on_voice_item_click_callback)
end

function MainUIChat:on_play_animation()   
    if self.isOpen then--关闭
        self.animationNode:animated_play("right_other_animation_leftdown_out")
        --self.objArrow:set_rotation(0, 0, 0)
        AudioManager.PlayUiAudio(81200046)
        self.btnChat:set_active(true)


    else--打开
        self.animationNode:animated_play("right_other_animation_leftdown_in")
        --self.objArrow:set_rotation(0, 0, -180)
        AudioManager.PlayUiAudio(81200045)
        --隐藏小红点
        self.chatData:SetShowMainUiPoint(false)
        --self.spPoint:set_active(false)
        self.btnChat:set_active(false)

    end 
    self.isOpen = not self.isOpen    
end

--[[
function MainUIChat:SetAnimationStatus(open)    
    if open then
        self.animationNode:animator_play("cha_xin_main3")
        --self.spArrow:set_sprite_name("renwudiban4")
    else
        self.animationNode:animator_play("cha_xin_main4")
        --self.spArrow:set_sprite_name("renwudiban5")
    end
    self.isOpen = open
end]]

function MainUIChat:InitUIUseExistNode(asset_obj)
    UiBaseClass.InitUIUseExistNode(self)   
    --self.ui:set_name("main_ui_chat")    

    --[[if self.parent then
        self.ui:set_parent(self.parent);
    end]]

    local path = 'left_down/animation/'

    --打开聊天窗口
    local btn_message = ngui.find_button(self.ui, path .. 'cont/scroll_view/sp_mark')
    btn_message:set_on_click(self.bindfunc['OnClickChatBtn'])

    local btnAnimation = ngui.find_button(self.ui, path .. 'cont/btn_empty')
    btnAnimation:set_on_click(self.bindfunc['on_play_animation'], "MyButton.NoneAudio")

    self.objArrow = self.ui:get_child_by_name(path .. 'cont/sp_di/sp_arrows') 
    self.objArrow:set_rotation(0, 0, -180)

    self.ui_wrap_list = ngui.find_wrap_list(self.ui, path .. "cont/scroll_view/panel_list/wrap_list")
    self.ui_wrap_list:set_on_initialize_item(self.bindfunc["init_chat_item"])
    --self.spPoint = ngui.find_sprite(self.ui, 'left_down/cont/sp_point')

    self.animationNode = self.ui:get_child_by_name('left_down/animation')
    if self.pos then
        --self.animationNode:set_local_position(self.pos.x, self.pos.y, self.pos.z);
    end 
    --self:SetAnimationStatus(false)

    self.objChatCont = self.ui:get_child_by_name(path .. 'cont')
    self.btnChat = ngui.find_button(self.ui, path .. 'btn_chat')
    self.btnChat:set_on_click(self.bindfunc['on_btn_chat'])
    self.btnChat:set_active(false)

    --聊天小红点
    self.spPointChat = ngui.find_sprite(self.ui, path .. 'btn_chat/animation/sp_point')    
    
    self:ReciveChatMsg()
    self:Show();

    if not GetMainUI():GetFirstHideVerboseMenu() then
        self:Hide()
    end
end

function MainUIChat:MsgRegist()
    PublicFunc.msg_regist(msg_chat.gc_add_player_chat, self.bindfunc['ReciveChatMsg'])
end

function MainUIChat:MsgUnRegist()
    PublicFunc.msg_unregist(msg_chat.gc_add_player_chat, self.bindfunc['ReciveChatMsg'])
end

function MainUIChat:on_btn_chat()
    g_dataCenter.chat:SetShowMainUiPoint(false)
    self.spPointChat:set_active(false)

    self.isOpen = false
    self:on_play_animation()
end

function MainUIChat:OnClickChatBtn()
    ChatUI.SetAndShow()
end

function MainUIChat:Update(dt)
    if self.ui == nil then return end
    --录音计时
    Im.update(dt)
end

function MainUIChat:init_chat_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1   

    local temp_data = self.chatData:get_chat_data_by_index(PublicStruct.Chat.all, index)
	if temp_data == nil then		
        return 
    end	
    
    if self.wrapContentItem[row] == nil then 
        local item = {}
        item.spChannel = ngui.find_sprite(obj, "sp")  
        item.lblText = ngui.find_label(obj, "lab") 
        item.btn_horn = ngui.find_button(obj, "sp_horn")
        --时长        
        item.lbl_num = ngui.find_label(obj, "sp_horn/lab_num")
        self.wrapContentItem[row] = item
    end

    local item = self.wrapContentItem[row]
    local roleStr = self.chatData:GetRoleString(temp_data)

    if temp_data.ctype == PublicStruct.Chat_Type.text then        
        item.btn_horn:set_active(false)
        item.lblText:set_text(roleStr .. temp_data.content)
           
    elseif temp_data.ctype == PublicStruct.Chat_Type.voice then
        --频道及vip/玩家名及说
        item.lblText:set_text(roleStr)

        --播放语音
        item.btn_horn:set_active(true)
        item.btn_horn:reset_on_click()
        item.btn_horn:set_on_click(self.bindfunc["on_voice_item_click"])       
        item.btn_horn:set_event_value("", temp_data.voice_index)        
        --时长  
        local time_txt = "(" .. Im.get_voice_time(temp_data.voice_index) .. "')"
        item.lbl_num:set_text(time_txt)        
    end
    local _name = self.chatData:GetSpriteName(temp_data.type)
    item.spChannel:set_sprite_name(_name)
end

function MainUIChat:ReciveChatMsg()
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

    if self.spPointChat then
        local isShow = g_dataCenter.chat:IsShowMainUiPoint()
        self.spPointChat:set_active(isShow)
    end

    --未展开状态时，显示小红点
    --[[if self.spPoint == nil then return end
    local isShow = false
    if self.isOpen == true then
        self.chatData:SetShowMainUiPoint(false)
    else
        isShow = self.chatData:IsShowMainUiPoint()
    end
    self.spPoint:set_active(isShow)]]
end

function MainUIChat:OnShow()
    self:ReciveChatMsg()

    if GetMainUI():GetFirstHideVerboseMenu() and not self:IsShow() then
        self:Show()
    end
end

function MainUIChat:on_voice_item_click(data)   
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

function MainUIChat:on_voice_item_click_callback(data)
    local index = tonumber(data.ext)    
    self:resume_play_voice_status(index)    
end

--[[设置播放状态, 恢复游戏音效]]
function MainUIChat:resume_play_voice_status(index)
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

function MainUIChat:SetParent(parent)
    self.parent = parent;
    if not self.ui or not parent then return end;

    self.ui:set_parent(parent);
end

function MainUIChat:SetLocalPosition(x,y,z)
    --[[if self.animationNode then
        self.animationNode:set_local_position(x, y, z);
    else
        self.pos = {x=x,y=y,z=z};
    end]]
end