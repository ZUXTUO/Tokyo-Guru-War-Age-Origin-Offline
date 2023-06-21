CommonFightDrawUI = Class("CommonFightDrawUI", UiBaseClass);

local instance = nil;

function CommonFightDrawUI.Start()
	if not instance then
		instance = CommonFightDrawUI:new();
	end
	instance:Show();
	AudioManager.PlayUiAudio(81200233)
end

function CommonFightDrawUI.SetEndCallback(func, param)
	if instance then
		instance:SetCallback(func,param);
	end
end

function CommonFightDrawUI.EndCallback()
	if instance then
		instance:DestroyUi();
		instance = nil;
	end
end

function CommonFightDrawUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/panel_zuozhan_chenggong.assetbundle";
    UiBaseClass.Init(self, data);
end

function CommonFightDrawUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("panel_zuozhan_draw");

	local spFont = ngui.find_sprite(self.ui, "sp_art_font")
	spFont:set_sprite_name("gq_pingju")
end

function CommonFightDrawUI:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function CommonFightDrawUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end
end
