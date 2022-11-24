CommonZuozhanshibai = Class("CommonZuozhanshibai", UiBaseClass);

local instance = nil;

function CommonZuozhanshibai.Start()
	if not instance then
		instance = CommonZuozhanshibai:new();
	end
	instance:Show();
end

function CommonZuozhanshibai.SetEndCallback(func, param)
	if instance then
		instance:SetCallback(func,param);
	end
end

function CommonZuozhanshibai.EndCallback()
	if instance then
		instance:DestroyUi();
		instance = nil;
	end
end

function CommonZuozhanshibai:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/panel_zuozhan_shibai.assetbundle";
    UiBaseClass.Init(self, data);
end

function CommonZuozhanshibai:InitData(data)
    UiBaseClass.InitData(self, data);
end

function CommonZuozhanshibai:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("panel_zuozhan_shibai");

end

function CommonZuozhanshibai:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function CommonZuozhanshibai:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end
end
