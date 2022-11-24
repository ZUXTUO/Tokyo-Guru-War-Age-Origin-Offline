
ChatUI = Class("ChatUI", UiBaseClass)

local _UIText = {
    [1] = "全部",  
    [2] = "[全]",     
    [3] = "喇叭", 
    [4] = "[喇]", 
    [5] = "区域", 
    [6] = "[区]", 
    [7] = "社团", 
    [8] = "[社]",
    [9] = "队伍", 
    [10] = "[队]", 
    [11] = "私聊", 
    [12] = "[私]",
    [13] = "世界", 
    [14] = "[世]", 
    [15] = "系统", 
    [16] = "[系统]", 

    [17] = "通用",
    [18] = "语音",
    [19] = "私聊",
    [20] = "切换其它",
    [21] = "约战(%sS)",
    [22] = "约战",

    [23] = "本周约战:%s场",
    [24] = "本周胜利:[FFE400]%s[-]场",
    [25] = "对决",
    [26] = "[对决]",
}

--[[data = {playerId = xx, playerName = xx, showType = xx, vip = xx, image = xx}]]
function ChatUI.SetAndShow(data, isChatFightUI)
    --默认值
    if data ~= nil then
        data.playerId = data.playerId or ""
        data.playerName = data.playerName or ""
        data.showType = data.showType or PublicStruct.Chat.fight
        ChatUI.__extData = data
    end

    ChatUI.isChatFightUI = isChatFightUI
    if ChatUI.instance == nil then
		ChatUI.instance = ChatUI:new(data)
	else
		ChatUI.instance:show_and_update(data)
	end
end

function ChatUI.HideUI()
    if ChatUI.instance then
        ChatUI.instance:Hide()
    end
end

function ChatUI.GetInstance()
	return ChatUI.instance
end

function ChatUI.Destroy()
	if ChatUI.instance then
		ChatUI.instance:DestroyUi();
		ChatUI.instance = nil;
	end
    VoiceInfoUI.Destroy()
end

--[[预留，初始化]]
function ChatUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/chat/ui_501_chat_left.assetbundle"
	UiBaseClass.Init(self, data)
end

function ChatUI:InitData(data)
	UiBaseClass.InitData(self, data)
    self.showLock = false
	self.showType = PublicStruct.Chat.all

	self.click_playerid = ""
    --私聊显示
    self.click_player_name = ""

    self.chatData = g_dataCenter.chat    
    self.init_play_horn = nil

    self.play_horn = {}

    --保存聊天item
    self.ui_chat_items = {}
    --发送界面
    self.send_ui_type = {
        common = 1,
        voice = 2,
        switch = 3
    }  
    --玩家操作
    self.player_oper_type = {
        detail_info = 1,
        whisper = 2,
        team = 3,
        invite_guild = 4,
        add_friend = 5,
        shield = 6,
    }
	self.local_data = {
		--页卡信息
		yeka_list = {
			[1] = {type = PublicStruct.Chat.all, s_name = _UIText[1], channel_name = _UIText[1], obj = nil, toggle = nil, sp_tip = nil,  send_ui_type = self.send_ui_type.common, chat_type = PublicStruct.Chat_Type.text},
			[2] = {type = PublicStruct.Chat.horn, s_name = _UIText[3], channel_name = _UIText[4], obj = nil, toggle = nil, sp_tip = nil, send_ui_type = self.send_ui_type.common, chat_type = PublicStruct.Chat_Type.text},
			[3] = {type = PublicStruct.Chat.area, s_name = _UIText[5], channel_name = _UIText[6], obj = nil, toggle = nil, sp_tip = nil, send_ui_type = self.send_ui_type.common, chat_type = PublicStruct.Chat_Type.text},
			[4] = {type = PublicStruct.Chat.guild, s_name = _UIText[7], channel_name = _UIText[8], obj = nil, toggle = nil, sp_tip = nil, send_ui_type = self.send_ui_type.common, chat_type = PublicStruct.Chat_Type.text},
			[5] = {type = PublicStruct.Chat.team, s_name = _UIText[9], channel_name = _UIText[10], obj = nil, toggle = nil, sp_tip = nil, send_ui_type = self.send_ui_type.common, chat_type = PublicStruct.Chat_Type.text},
            [6] = {type = PublicStruct.Chat.whisper, s_name = _UIText[11], channel_name = _UIText[12], obj = nil, toggle = nil, sp_tip = nil, send_ui_type = self.send_ui_type.common, chat_type = PublicStruct.Chat_Type.text},
            [7] = {type = PublicStruct.Chat.world, s_name = _UIText[13], channel_name = _UIText[14], obj = nil, toggle = nil, sp_tip = nil, send_ui_type = self.send_ui_type.common, chat_type = PublicStruct.Chat_Type.text},
            [8] = {type = PublicStruct.Chat.fight, s_name = _UIText[25], channel_name = _UIText[26], obj = nil, toggle = nil, sp_tip = nil, send_ui_type = self.send_ui_type.common, chat_type = PublicStruct.Chat_Type.text},
            [9] = {type = PublicStruct.Chat.system, s_name = _UIText[15], channel_name = _UIText[16], obj = nil, toggle = nil, sp_tip = nil, send_ui_type = self.send_ui_type.switch},
		},
        send_ui_config = {
            [1] = {
                type = self.send_ui_type.common, desc = _UIText[17], obj_ui = nil, lbl_input  = nil, lbl_input_horn = nil,
                lblName = nil, objHorn = nil, objCommon = nil           
            },
			[2] = {type = self.send_ui_type.voice, desc = _UIText[18], obj_ui = nil, lblName = nil},
			[3] = {type = self.send_ui_type.switch, desc = _UIText[20], obj_ui = nil},
        },
	}
	if data ~= nil then 
		self.click_playerid = data.playerId;
		self.click_player_name = data.playerName;
		self.showType = data.showType;
	end
    self.wrapContentItem = {} 
    self.clsPopupUi = nil
    self.load_ui_ok = false
    self.needRefreshTab = false 
end

--[[预留，进战斗后删除调用]]
function ChatUI:DestroyUi()
    if self.clsPopupUi then
        self.clsPopupUi:DestroyUi()
        self.clsPopupUi = nil
    end
    self.play_horn = {}
    --点击玩家ID
	self.click_playerid = ""
    self.click_player_name = ""
    ChatUI.__extData = nil

    self.load_ui_ok = false
    self.wrapContentItem = {}

    TimerManager.Remove(self.bindfunc["update_chat_fight_time"])
    ChatFightSendInfoUI.End()
    ChatFightMatchingUI.End()

    ImAutoPlay.SetCallback(nil)
    UiBaseClass.DestroyUi(self)
end

--[[隐藏该界面时回调]]
function ChatUI:SetHideCallback(callback)
	self.hideCallbackFunc = callback
end

function ChatUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
    --更新数据
	self.bindfunc["Updata"] = Utility.bind_callback(self, ChatUI.Updata)

    --关闭
	self.bindfunc["on_close"] = Utility.bind_callback(self, ChatUI.on_close)  
    --页卡点击
	self.bindfunc["on_yeka_touch"] = Utility.bind_callback(self, ChatUI.on_yeka_touch)    

    self.bindfunc["init_chat_item"] = Utility.bind_callback(self, ChatUI.init_chat_item) 

    --聊天头像点击
	self.bindfunc["on_item_click"] = Utility.bind_callback(self, ChatUI.on_item_click)
    --发送消息
	self.bindfunc["on_send_message"] = Utility.bind_callback(self, ChatUI.on_send_message)
    self.bindfunc["on_switch_text_voice"] = Utility.bind_callback(self, ChatUI.on_switch_text_voice)

    --语音相关
    self.bindfunc["on_press_call"] = Utility.bind_callback(self, ChatUI.on_press_call)
    self.bindfunc["on_drag_call"] = Utility.bind_callback(self, ChatUI.on_drag_call)
    self.bindfunc["on_voice_item_click"] = Utility.bind_callback(self, ChatUI.on_voice_item_click)
    self.bindfunc["on_voice_item_click_callback"] = Utility.bind_callback(self, ChatUI.on_voice_item_click_callback)
    --语音设置  
    self.bindfunc["on_voice_setting_show"] = Utility.bind_callback(self, ChatUI.on_voice_setting_show) 

    self.bindfunc["handle_tab"] =  Utility.bind_callback(self, self.handle_tab) 
    self.bindfunc["on_click_add"] =  Utility.bind_callback(self, self.on_click_add) 
    self.bindfunc["on_invite_state"] =  Utility.bind_callback(self, self.on_invite_state)
    self.bindfunc["gc_select_country"] =  Utility.bind_callback(self, self.gc_select_country)

    self.bindfunc["hidden_voice_tip"] =  Utility.bind_callback(self, self.hidden_voice_tip)
    self.bindfunc["on_btn_chat_fight"] =  Utility.bind_callback(self, self.on_btn_chat_fight)
    self.bindfunc["on_btn_match"] =  Utility.bind_callback(self, self.on_btn_match)
    self.bindfunc["gc_send_notice"] =  Utility.bind_callback(self, self.gc_send_notice)
    self.bindfunc["update_chat_fight_time"] =  Utility.bind_callback(self, self.update_chat_fight_time)
    self.bindfunc["gc_sync_my_1v1_data"] =  Utility.bind_callback(self, self.gc_sync_my_1v1_data)
end

function ChatUI:MsgRegist()
    --聊天信息
	PublicFunc.msg_regist(msg_chat.gc_add_player_chat, self.bindfunc['Updata'])	
    PublicFunc.msg_regist(msg_guild.gc_sync_my_guild, self.bindfunc["handle_tab"])
    PublicFunc.msg_regist(player.gc_invite_state, self.bindfunc['on_invite_state'])
    PublicFunc.msg_regist(player.gc_select_country, self.bindfunc['handle_tab'])

    PublicFunc.msg_regist(player.gc_invite_friend, self.bindfunc['gc_send_notice'])
    PublicFunc.msg_regist(msg_1v1.gc_sync_my_1v1_data, self.bindfunc["gc_sync_my_1v1_data"]);
end

function ChatUI:MsgUnRegist()
	PublicFunc.msg_unregist(msg_chat.gc_add_player_chat, self.bindfunc['Updata'])
    PublicFunc.msg_unregist(msg_guild.gc_sync_my_guild, self.bindfunc["handle_tab"])
    PublicFunc.msg_unregist(player.gc_select_country, self.bindfunc['handle_tab'])

    PublicFunc.msg_unregist(player.gc_invite_friend, self.bindfunc['gc_send_notice'])
    PublicFunc.msg_unregist(msg_1v1.gc_sync_my_1v1_data, self.bindfunc["gc_sync_my_1v1_data"]);
end

function ChatUI:handle_tab()
    self.needRefreshTab = true
    if self:get_yeka_data(PublicStruct.Chat.horn).obj == nil then
        return
    end

    --公会
    local isJoin = g_dataCenter.guild:IsJoinedGuild()
    self:get_yeka_data(PublicStruct.Chat.guild).obj:set_active(isJoin)
    if self.showType == PublicStruct.Chat.guild then
        --退出公会,切换到区域聊天
        if not isJoin then
            self:show_current_pane(PublicStruct.Chat.all)
            --正在录音
            Im.stop_audio_record()
        end
    end

    --区域
    local haveArea = tonumber(g_dataCenter.player.country_id) ~= 0
    self:get_yeka_data(PublicStruct.Chat.area).obj:set_active(haveArea)

    --对决
    local isOpen = SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_1v1)
    self:get_yeka_data(PublicStruct.Chat.fight).obj:set_active(isOpen)

    self.gridTab:reposition_now()
end

--[[初始化界面]]
function ChatUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_501_chat_left")

    --local butMark = ngui.find_button(self.ui, "sp_mark")
    --butMark:set_on_click(self.bindfunc["on_close"], "MyButton.BackBtn")

    local aniPath = "left_other/animation/"
    local downPath = "down_other/animation/"

    self.objChatFight = self.ui:get_child_by_name(downPath .. "cont")
    local btnChatFight = ngui.find_button(self.objChatFight, "btn_yuezhan")
    btnChatFight:set_on_click(self.bindfunc["on_btn_chat_fight"])

    self.spBtnChatFight = ngui.find_sprite(self.objChatFight, "btn_yuezhan/animation/sprite_background")
    self.lblBtnChatFight = ngui.find_label(self.objChatFight, "btn_yuezhan/animation/lab")

    self.lblChatFightTimes = ngui.find_label(self.objChatFight, "lab1")
    self.lblChatFightWinTimes = ngui.find_label(self.objChatFight, "lab_win")
    local btnMatch  = ngui.find_button(self.objChatFight, "btn_pipei")
    btnMatch:set_on_click(self.bindfunc["on_btn_match"])

    self.spRightEmpty = ngui.find_sprite(self.ui, "right_other/animation/sp_empty")
    self.spRightEmpty:set_on_ngui_click(self.bindfunc["on_close"])

	self.btnClose = ngui.find_button(self.ui, aniPath .. "btn_cha")
	self.btnClose:set_on_click(self.bindfunc["on_close"], "MyButton.BackBtn")
    local objClose = self.btnClose:get_game_object()
    objClose:set_local_rotation(0, 180, 0)

    --语音设置    
    self.btn_set = ngui.find_button(self.ui, downPath .. "btn_set")
	self.btn_set:reset_on_click()
	self.btn_set:set_on_click(self.bindfunc["on_voice_setting_show"], "MyButton.ChatNormal")

    local contPath = aniPath .. "cont/"
    --页卡列表
    self.gridTab = ngui.find_grid(self.ui, contPath .. "grid")
    local objGrid = self.gridTab:get_game_object()
    local cloneYeka = self.ui:get_child_by_name(contPath .. "grid/yeka1")
    cloneYeka:set_active(false)
	
	for k, v in ipairs(self.local_data.yeka_list) do        
        if v.obj == nil then
            v.obj  = cloneYeka:clone() 
            v.obj:set_parent(objGrid)     
            v.obj:set_name("chat_tab_" .. k)       
        end
        local objYeka = v.obj
        if v.type == PublicStruct.Chat.horn or v.type == PublicStruct.Chat.team or v.type == PublicStruct.Chat.world then
            objYeka:set_active(false)
        else
            objYeka:set_active(true)
        end

        --小红点提示
        v.sp_tip = ngui.find_sprite(objYeka,"sp_point")

        local lbl_name = ngui.find_label(objYeka, "lab")
		lbl_name:set_text(v.s_name)
        local lbl_name1 = ngui.find_label(objYeka, "lab1")
		lbl_name1:set_text(v.s_name)

        local toggleYeka = ngui.find_toggle(objYeka, objYeka:get_name()) 
        --toggleYeka:set_value(false)    
        toggleYeka:set_name(tostring(v.type))
		toggleYeka:set_on_change(self.bindfunc["on_yeka_touch"])
        v.toggle = toggleYeka
	end
    self:handle_tab()

    local lblOpen = ngui.find_label(self.ui, contPath .. "content/lab")
    lblOpen:set_active(false)
	--聊天框
    local chatViewPath = contPath .. "content/world_right/scrollview_world_right"
    --self.scrollView = ngui.find_scroll_view(self.ui, chatViewPath)
    self.ui_wrap_list = ngui.find_wrap_list(self.ui, chatViewPath .. "/wrap_list")
    self.ui_wrap_list:set_on_initialize_item(self.bindfunc["init_chat_item"])
    
    self.lblSendUILabel = ngui.find_label(self.ui, downPath .. "sp_bk/content3/lab_input")
    --发送面板
    for k, v in ipairs(self.local_data.send_ui_config) do
        local tempPath = downPath .. "sp_bk/content" .. k .. "/"
        v.obj_ui = self.ui:get_child_by_name(tempPath)
        if v.type == self.send_ui_type.common then
            --v.lbl_input_horn = ngui.find_input(self.ui, tempPath .. "cont/sp_input1")
            v.lbl_input = ngui.find_input(self.ui, tempPath .. "sp_input2")  

            --私聊玩家名
            v.lblName = ngui.find_label(self.ui, tempPath .. "sp_input2/lbl_haha") 
            --v.objHorn = self.ui:get_child_by_name(tempPath .. "cont")
            --v.lblHornNum = ngui.find_label(self.ui, tempPath .. "cont/sp_horn/lab") 
            v.objCommon = v.lbl_input

            local btn_send = ngui.find_button(self.ui, tempPath .. "btn_send")  
		    btn_send:reset_on_click()
		    btn_send:set_on_click(self.bindfunc["on_send_message"], "MyButton.ChatNormal")
            --切换为发送语音
            local sp_horn = ngui.find_sprite(self.ui, tempPath .. "btn_horn/sp") 
            PublicFunc.SetUISpriteGray(sp_horn)

            --local btn_horn = ngui.find_button(self.ui, tempPath .. "btn_horn")
		    --btn_horn:reset_on_click()
            --btn_horn:set_event_value("", PublicStruct.Chat_Type.text)
		    --btn_horn:set_on_click(self.bindfunc["on_switch_text_voice"], "MyButton.ChatNormal")

        elseif v.type == self.send_ui_type.voice then
            v.lblName = ngui.find_label(self.ui, tempPath .. "btn_send/animation/lab")  
            
            local spVoiceSend = ngui.find_sprite(self.ui, tempPath .. "btn_send/animation/sprite_background")            
            --发送语音
            local btn_voice_send = ngui.find_button(self.ui, tempPath .. "btn_send") 
            btn_voice_send:set_on_ngui_press(self.bindfunc["on_press_call"])
            btn_voice_send:set_on_ngui_drag_move(self.bindfunc["on_drag_call"])
            --获取发送按钮的屏幕y值
            local isSuc,rx,ry,rz = PublicFunc.SceneWorldPosToUIScreenPos(btn_voice_send:get_game_object():get_position())
            local width, height = spVoiceSend:get_size()
            self.voice_button_y = ry + height / 2

            --切换为发送文本
            local btn_horn = ngui.find_button(self.ui, tempPath .. "btn_voice")  
            btn_horn:reset_on_click()
		    btn_horn:set_event_value("", PublicStruct.Chat_Type.voice)
		    btn_horn:set_on_click(self.bindfunc["on_switch_text_voice"], "MyButton.ChatNormal")
        end       
        v.obj_ui:set_active(false)
    end	
    self.load_ui_ok = true
	self:show_current_pane()
    self:HandleChatFightUI()

    ImAutoPlay.SetCallback(self.bindfunc["hidden_voice_tip"])
end

--[[显示并刷新数据]]
function ChatUI:show_and_update(data)
    --资源可能未加载完
    if not self.load_ui_ok then
        return
    end
	if not self:IsShow() then
        self:Show()
        --[[if self.objSpMark == nil then
            self.objSpMark = self.ui:get_child_by_name("sp_mark")
        end
        self.objSpMark:set_local_scale(0,0,0);
        local tover = function()
            self.objSpMark:set_local_scale(1,1,1);
        end
        Tween.addTween(self.objSpMark,0.01, {},nil,0,nil,nil,tover);]]
    end
    if self.needRefreshTab then
        self.needRefreshTab = false
        self:handle_tab()
    end
    if data ~= nil then 
		self.click_playerid = data.playerId;
		self.click_player_name = data.playerName;
		self.showType = data.showType;
        self:show_current_pane()
	else
        self:updateTab()
        self:show_send_ui()
        --录音通道可能已变, 重新设置
        if Im.BackupChannel then
            Im.SetCurrentChannel(Im.BackupChannel)
            Im.BackupChannel = nil
        end
    end
    self:HandleChatFightUI()
end

--[[动态更新界面新加聊天界面]]
function ChatUI:Updata()
	if not self:IsShow() then
        return
    end
    self:updateTab(false)
end

function ChatUI:HandleChatFightUI()
    if not ChatUI.isChatFightUI then
        self.objChatFight:set_active(false)
        self.btnClose:set_active(true)
        self.spRightEmpty:set_active(true)
        return
    end
    self.objChatFight:set_active(true)
    self.btnClose:set_active(false)
    self.spRightEmpty:set_active(false)

    self:UpdateChatFightTimes()
    --检查发送倒计时
    self:CheckChatFightTime()
end

function ChatUI:UpdateChatFightTimes()
    local info = g_dataCenter.chatFight:GetAwardInfo()
    self.lblChatFightTimes:set_text(string.format(_UIText[23], info.fightTimes))
    self.lblChatFightWinTimes:set_text(string.format(_UIText[24], info.winTimes))
end

function ChatUI:CheckChatFightTime()
    if not ChatUI.isChatFightUI then
        return
    end
    if g_dataCenter.chatFight:IsSendInfoCD() then
        local diff = g_dataCenter.chatFight:GetSendTimeDiff()
        if diff > 0 then
            TimerManager.Add(self.bindfunc["update_chat_fight_time"], 1000, diff)
        end
    end
    self:update_chat_fight_time()
end

local _cdTime = 60

function ChatUI:update_chat_fight_time()
    local diff = g_dataCenter.chatFight:GetSendTimeDiff()
    local _mode = 1
    if diff > 0 and diff <= _cdTime then
        self.lblBtnChatFight:set_text(string.format(_UIText[21], diff))
        _mode = 3
    else
        self.lblBtnChatFight:set_text(_UIText[22])
    end
    local eData = PublicFunc.GetButtonShowData(_mode)
    self.spBtnChatFight:set_sprite_name(eData.nameSprite)
    self.lblBtnChatFight:set_color(eData.colorTxt[1]/255, eData.colorTxt[2]/255, eData.colorTxt[3]/255, 1)
end

function ChatUI:on_btn_chat_fight()
    ChatFightSendInfoUI.Start()
end

function ChatUI:on_btn_match()
    if g_dataCenter.chatFight:CheckMyRequest() then
        return
    end
    ChatFightMatchingUI.Start()
end

function ChatUI:gc_send_notice()
    self:CheckChatFightTime()
end

function ChatUI:gc_sync_my_1v1_data()
    self:UpdateChatFightTimes()
end