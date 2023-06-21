--角色历练关卡击杀数
HeroTrialFightKillUI = Class('HeroTrialFightKillUI', UiBaseClass);

local _UIText = {
	[1] = "%s/%s",
}
local res = 'assetbundles/prefabs/ui/new_fight/new_fight_ui_jueselilian.assetbundle';

-----------------外部接口---------------------------------
--显示保卫喰场战斗界面
function HeroTrialFightKillUI.Start()
	if not HeroTrialFightKillUI.cls then
		HeroTrialFightKillUI.cls = HeroTrialFightKillUI:new();
	else
		HeroTrialFightKillUI.cls:Show();
	end
end

function HeroTrialFightKillUI.SetData(data)
	if HeroTrialFightKillUI.cls then
		HeroTrialFightKillUI.cls.kill = data

		HeroTrialFightKillUI.cls:UpdateUi()
	end
end

function HeroTrialFightKillUI.Destroy()
	if HeroTrialFightKillUI.cls then
		HeroTrialFightKillUI.cls:DestroyUi();
		HeroTrialFightKillUI.cls = nil;
	end
end

function HeroTrialFightKillUI.GetResList()
	return {res}
end

-----------------内部接口---------------------------------
function HeroTrialFightKillUI:Init(data)
	self.pathRes = res
    UiBaseClass.Init(self, data);
end

function HeroTrialFightKillUI:InitData(data)
	UiBaseClass.InitData(self, data);
	self.max = 0
	self.kill = 0

	local config = ConfigManager.Get(EConfigIndex.t_hero_trial_hurdle_info, FightScene.GetCurHurdleID())
	if config then
		self.max = config.show_max
	end
end

function HeroTrialFightKillUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_parent(Root.get_root_ui_2d_fight());
	self.ui:set_name("hero_trial_fight_kill_ui");
	
	self.labScore = ngui.find_label(self.ui,"lab_kill");
	
	self:UpdateUi();
end

function HeroTrialFightKillUI:UpdateUi()
	if not self.ui then return end
	self.labScore:set_text(string.format(_UIText[1], self.kill, self.max))
end
