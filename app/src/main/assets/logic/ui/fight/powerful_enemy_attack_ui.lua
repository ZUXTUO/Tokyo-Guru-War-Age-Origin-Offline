PowerfulEnemyAttackUI = Class("PowerfulEnemyAttackUI", UiBaseClass);

local instance = nil;

function PowerfulEnemyAttackUI.Start()
	if not instance then
		instance = PowerfulEnemyAttackUI:new();
	end
	instance:Show();
	AudioManager.PlayUiAudio(81200229)
end

function PowerfulEnemyAttackUI.SetEndCallback(func, param)
	if instance then
		instance:SetCallback(func,param);
	end
end

function PowerfulEnemyAttackUI.EndCallback()
	if instance then
		instance:DestroyUi();
		instance = nil;
	end
end

function PowerfulEnemyAttackUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/panel_qiangdi_laixi.assetbundle";
    UiBaseClass.Init(self, data);
end

function PowerfulEnemyAttackUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("powerful_enemy_attack_ui");
end

function PowerfulEnemyAttackUI:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function PowerfulEnemyAttackUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end
end
