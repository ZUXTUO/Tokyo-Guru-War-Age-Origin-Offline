--region input_confirm_ui.lua
--author : zzc
--date   : 2016/08/19

-- 输入确认弹窗基础界面（继承使用）
InputConfirmUI = Class('InputConfirmUI', UiBaseClass)

-------------------------------------类方法-------------------------------------
function InputConfirmUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2810_guild_tc.assetbundle";
	UiBaseClass.Init(self, data);
end

function InputConfirmUI:Restart(data)
	self.data = data or {}
	UiBaseClass.Restart(self, data)
end

function InputConfirmUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function InputConfirmUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_btn_ok"] = Utility.bind_callback(self, self.on_btn_ok)
	self.bindfunc["on_update_guild_config"] = Utility.bind_callback(self, self.on_update_guild_config)
end

function InputConfirmUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	
	------------------------------ 中部 -----------------------------
	local btnClose = ngui.find_button(self.ui, "btn_cha")
	local btnOk = ngui.find_button(self.ui, "btn_confirm")
	self.labTitle = ngui.find_label(self.ui, "lab_title") 
	self.labTitle2 = ngui.find_label(self.ui, "lab_title/lab_title2") 
	self.input = ngui.find_input(self.ui, "input_cont")
	self.labInputTips = ngui.find_label(self.ui, "input_cont/lab")

	btnClose:set_on_click(self.bindfunc["on_btn_close"])
	btnOk:set_on_click(self.bindfunc["on_btn_ok"])
end

function InputConfirmUI:DestroyUi()
	self.callback = nil
    UiBaseClass.DestroyUi(self);
end

function InputConfirmUI:SetOkCallback(callback)
	self.callback = callback
end

function InputConfirmUI:SetTitle(title)
    if self.labTitle then
		PublicFunc.SetSinkText(title, self.labTitle, self.labTitle2)
	end
end

function InputConfirmUI:SetCharLimit(length)
	if self.input then
    	self.input:set_characterlimit(length)
	end
end

function InputConfirmUI:SetInputTips(content)
    if self.labInputTips then
		self.labInputTips:set_text(content)
	end
end

function InputConfirmUI:on_btn_close()
	uiManager:PopUi()
end

function InputConfirmUI:on_btn_ok()
	if self.callback then
		Utility.CallFunc(self.callback)
	end
end

