
VoiceInfoUI = Class("VoiceInfoUI", UiBaseClass)

EVoiceInfoUIType = 
{
	speak = 1,
	cancel = 2
}

--[[data = {type = xx, vol = xx}]]
function VoiceInfoUI.ShowUI(type, vol)
    if VoiceInfoUI.instance == nil then
        VoiceInfoUI.instance = VoiceInfoUI:new({type = type, vol = vol})
    else
        VoiceInfoUI.instance:SetInfo(type, vol)
    end    
end

function VoiceInfoUI.HideUI()
    if VoiceInfoUI.instance then
        VoiceInfoUI.instance:Hide()
    end
end

function VoiceInfoUI.Destroy()
	if VoiceInfoUI.instance then
		VoiceInfoUI.instance:DestroyUi();
		VoiceInfoUI.instance = nil;
	end
end

-------------------------------------------------------------------

--[[预留，初始化]]
function VoiceInfoUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/chat/panel_send_voice_chat.assetbundle"
	UiBaseClass.Init(self, data)
end

function VoiceInfoUI:DestroyUi()
    UiBaseClass.DestroyUi(self)
    self.isInitUI = false
end

function VoiceInfoUI:InitData(data)
    self.data = data
    self.curr_type = nil
    self.curr_volume = nil
    self.isInitUI = false
	UiBaseClass.InitData(self, data)
end

--[[初始化界面]]
function VoiceInfoUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("panel_send_voice_chat")
    self.sp = ngui.find_sprite(self.ui, "sp1")
    self.pb_volume = ngui.find_sprite(self.ui, "sp2")
    self.lbl = ngui.find_label(self.ui, "lab")

    self.config_data = {
        [EVoiceInfoUIType.speak] = {sp_name = "lt_dahuatong", info = "手指上滑取消"},
        [EVoiceInfoUIType.cancel] = {sp_name = "lt_quxiao", info = "松开手指取消"}
    }
    self.isInitUI = true
    self:SetInfo(self.data.type, self.data.vol)
end

--[[设置图标文本]]
function VoiceInfoUI:SetIcon(type)  
    if type == self.curr_type then
        return
    end    
    self.curr_type = type  
    --self.sp:set_sprite_name(self.config_data[type].sp_name)
    self.lbl:set_text(self.config_data[type].info)
    self.pb_volume:set_active(false)
    self.sp:set_active(false)
    if type == EVoiceInfoUIType.speak then
        self.pb_volume:set_active(true)
    elseif type == EVoiceInfoUIType.cancel then
        self.sp:set_active(true)
    end
end

--[[设置音量]]
function VoiceInfoUI:SetVolume(vol)
    if vol == nil or vol == self.curr_volume then
        return
    end
    self.curr_volume = vol
    self.pb_volume:set_fill_amout(vol)
end

--[[设置信息]]
function VoiceInfoUI:SetInfo(type, vol)
    if not self.isInitUI then
        return
    end
    self:SetIcon(type)
    self:SetVolume(vol)
    self:Show()
end