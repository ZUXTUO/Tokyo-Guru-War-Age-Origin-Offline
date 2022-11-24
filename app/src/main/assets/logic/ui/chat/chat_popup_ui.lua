
ChatPopupUI = Class("ChatPopupUI", UiBaseClass)

local _UIText = {
    [28] = "区域频道",
    [29] = "社团频道",
    [30] = "队伍频道",
    [31] = "私聊频道",
}

--[[预留，初始化]]
function ChatPopupUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/chat/ui_502_chat.assetbundle"
	UiBaseClass.Init(self, data)
end

function ChatPopupUI:InitData(data)
    --自动语音设置
    self.autoPlaySetting = {
        [1] = {type = PublicStruct.Chat.area, s_name = _UIText[28], toggle = nil},
        [2] = {type = PublicStruct.Chat.guild , s_name = _UIText[29], toggle = nil},
        [3] = {type = PublicStruct.Chat.team, s_name = _UIText[30], toggle = nil},
        [4] = {type = PublicStruct.Chat.whisper, s_name = _UIText[31], toggle = nil},
    }
	UiBaseClass.InitData(self, data)    
end

function ChatPopupUI:DestroyUi()
	UiBaseClass.DestroyUi(self)    
end

function ChatPopupUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["btn_close"] = Utility.bind_callback(self, self.btn_close)	
    self.bindfunc["on_auto_play_voice_change"] = Utility.bind_callback(self, self.on_auto_play_voice_change)
    self.bindfunc["on_wifi_setting_change"] = Utility.bind_callback(self, self.on_wifi_setting_change)
end

function ChatPopupUI:btn_close()
    self:Hide()
end

--[[初始化界面]]
function ChatPopupUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_502_chat")

    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "content_di_754_458/btn_cha")
    btnClose:set_on_click(self.bindfunc["btn_close"], "MyButton.BackBtn")

    --发送语音设置面板
    for k, v in ipairs(self.autoPlaySetting) do
        v.toggle = ngui.find_toggle(self.ui, path .."cont_set/sp_bk1/cont_yeka" .. k .. "/sp")
        v.toggle:set_name(tostring(v.type))
        v.toggle:set_on_change(self.bindfunc['on_auto_play_voice_change'])
        local lblName = ngui.find_label(self.ui, path .. "cont_set/sp_bk1/cont_yeka" .. k .. "/txt")
        lblName:set_text(v.s_name)
    end
    self.toggleWifi = ngui.find_toggle(self.ui, path .. "cont_set/sp_bk2/animation/sp_lv")
    self.toggleWifi:set_on_change(self.bindfunc['on_wifi_setting_change'])    	
    
    self:SetInfo()
end

function ChatPopupUI:SetInfo()
    for k, v in ipairs(self.autoPlaySetting) do
        v.toggle:set_value(ImAutoPlay.IsOpen(v.type))
    end
    self.toggleWifi:set_value(ImAutoPlay.IsWifiAutoPlay())
end

---------------------------------语音设置------------------------------------

--[[自动播放语音设置]]
function ChatPopupUI:on_auto_play_voice_change(value, type) 
    app.log("ChatPopupUI:on_auto_play_voice_change"..tostring(value).."#"..tostring(type))
    if not self.isSecond1 then
        self.isSecond1 = true
    else
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.ChatNormal)
    end
    if value ~= ImAutoPlay.getAutoPlayVoice(tonumber(type)) then
        ImAutoPlay.SetAutoPlayVoice(tonumber(type), value)
    end    
end

--[[仅wifi下自动播放语音]]
function ChatPopupUI:on_wifi_setting_change(value, name)
    app.log("ChatPopupUI:on_wifi_setting_change"..tostring(value))
    if not self.isSecond2 then
        self.isSecond2 = true
    else
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.ChatNormal)
    end
    if value ~= ImAutoPlay.IsWifiAutoPlay() then
        ImAutoPlay.SetWifiAutoPlay(value)
    end
end