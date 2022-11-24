CommonKuikuliyaWinUI = Class("CommonKuikuliyaWinUI", UiBaseClass);

local instance = nil;

function CommonKuikuliyaWinUI.Start()
	if not instance then
		instance = CommonKuikuliyaWinUI:new();
	end
	instance:Show();
	AudioManager.PlayUiAudio(81010002)
end

function CommonKuikuliyaWinUI.SetEndCallback(func, param)
	if instance then
		instance:SetCallback(func,param);
	end
end

function CommonKuikuliyaWinUI.EndCallback()
	if instance then
		instance:DestroyUi();
		instance = nil;
	end
	CommonFightDrawUI.EndCallback()
end

function CommonKuikuliyaWinUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/panel_zuozhan_chenggong.assetbundle";
    UiBaseClass.Init(self, data);
end

function CommonKuikuliyaWinUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("panel_zuozhan_chenggong");
end

function CommonKuikuliyaWinUI:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function CommonKuikuliyaWinUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end
end
