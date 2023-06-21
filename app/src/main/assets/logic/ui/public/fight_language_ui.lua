FightLanguageUI = Class("FightLanguageUI", UiBaseClass);

local instance = nil;
local EAnimName = 
{
	[1] = "fight_language",
}
function FightLanguageUI.Start(type, text)
	if not instance then
		instance = FightLanguageUI:new();
	else
		instance:Hide();
	end
	instance:Show(type, text);
end

function FightLanguageUI.SetEndCallback(func, param)
	if instance then
		instance:SetCallback(func,param);
	end
end

function FightLanguageUI.EndCallback()
	if instance then
		instance:DestroyUi();
		instance = nil;
	end
end

function FightLanguageUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/panel_fight_language.assetbundle";
    UiBaseClass.Init(self, data);
end

function FightLanguageUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.dataText = "";
    self.animType = 1;
end

function FightLanguageUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("FightLanguageUI");

    self.lab = ngui.find_label(self.ui,"animation/lab");
    self.objAnim = self.ui:get_child_by_name("animation");

    self:UpdateUi();
end

function FightLanguageUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    self.lab:set_text(tostring(self.dataText));
    self.objAnim:animator_play(EAnimName[self.animType])
end

function FightLanguageUI:Show(animType, text)
	self.dataText = text;
	self.animType = animType or 1;
	if UiBaseClass.Show(self) then
		self:UpdateUi();
	end
end

function FightLanguageUI:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function FightLanguageUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end
end