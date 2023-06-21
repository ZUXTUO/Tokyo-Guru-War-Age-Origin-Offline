FightBossShowUI = Class("FightBossShowUI", UiBaseClass);

local instace = nil;

function FightBossShowUI.Show(boss_id, talk)
	if instace == nil then
		instace = FightBossShowUI:new();
	end
	instace:SetBossId(boss_id, talk);
	-- instace:Play();
end

function FightBossShowUI.SetEndCallback(func, param)
	if instace then
		instace:SetCallback(func,param);
	end
end

function FightBossShowUI.EndCallback()
	instace:DestroyUi();
	instace = nil;
end

function FightBossShowUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/panel_boss_show.assetbundle";
    UiBaseClass.Init(self, data);
end

function FightBossShowUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function FightBossShowUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
end

function FightBossShowUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("panel_boss_show");

    self.labName = ngui.find_label(self.ui,"lab_name");
    self.labDes = ngui.find_label(self.ui,"lab_describe");
    self.labCv = ngui.find_label(self.ui,"lab_cv");
    self.labTalk = ngui.find_label(self.ui,"animation/left_other/sp_effect/lab");

    if self.boss_id then
    	self:UpdateUi();
    end
end

function FightBossShowUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local cfg = ConfigManager.Get(EConfigIndex.t_monster_property, self.boss_id);
    if cfg then
    	-- PublicFunc.SetSinkText(cfg.name, self.labName1, self.labName2);
        local _cvName = PublicFunc.GetShengyouName(cfg.model_id);
        if _cvName == '' then
            self.labCv:set_active(false);
        else
            self.labCv:set_active(true);
            self.labCv:set_text(_cvName);
        end
        self.labName:set_text(cfg.name);
    	if cfg.boss_show_des and cfg.boss_show_des ~= 0 then
    		self.labDes:set_text(cfg.boss_show_des);
    	else
    		self.labDes:set_text("");
    	end
        if self.talk then
            self.labTalk:set_text(tostring(self.talk));
        else
            self.labTalk:set_text("");
        end
    end
end

function FightBossShowUI:SetBossId(boss_id, talk)
	self.boss_id = boss_id;
    self.talk = talk;
	self:UpdateUi();
end

function FightBossShowUI:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function FightBossShowUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.boss_id = nil;
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end
end