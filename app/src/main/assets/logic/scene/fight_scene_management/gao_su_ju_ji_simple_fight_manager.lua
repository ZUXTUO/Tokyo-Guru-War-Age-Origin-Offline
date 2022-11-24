-- 玩法 保卫战

GaoSuJuJiSimpleFightManager = Class("GaoSuJuJiSimpleFightManager", FightManager)

function GaoSuJuJiSimpleFightManager:InitData()
	FightManager.InitData(self)
	--<region: member field >
	self.teamInfo = {}
	self.heroIndex = 1;
	self.curHeroNum = 0;
	self.bigWave = 0;
	self.smallWave = 0;
	self.boss_entity_name = nil;
	self.deadNum = 0;
	self.waitNum = 0;
	-- self.dataCenter = nil;
	--</region:member field>
end

function GaoSuJuJiSimpleFightManager.InitInstance()
	GaoSuJuJiSimpleFightManager._super.InitInstance(GaoSuJuJiSimpleFightManager)
	return GaoSuJuJiSimpleFightManager;
end


function GaoSuJuJiSimpleFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
	-- GaoSuJuJiFightUI.Destroy()
	---
end

function GaoSuJuJiSimpleFightManager:Start()
	--self:_OnStart()

    --self.followHeroUsedAI = self:GetFightScript().hero_id

	FightManager.Start(self)
end

function GaoSuJuJiSimpleFightManager:OnLoadMonster(entity)
	if not entity:IsEnemy() then
        self.diaoxiangEntityName = entity:GetName()
	end
end

function GaoSuJuJiSimpleFightManager:OnEvent_OnInjured(obj, attack,hp)
	FightManager.OnEvent_OnInjured(self, obj, attack,hp);
	if self.diaoxiangEntityName == obj:GetName() then
		GetMainUI():InitTips("笛口母女受到攻击", 1);
	end
end

function GaoSuJuJiSimpleFightManager:OnUiInitFinish()

	-- local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	-- local str = hurdle.tips_string;
	-- local time = hurdle.tips_last;

    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0;
    local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsShowStarTip = (cf.is_show_star_tip == 1)

    GetMainUI():InitWorldChat()
    GetMainUI():InitZouMaDeng()
    --GetMainUI():InitDescription(str, time)
    GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)
    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget)
    GetMainUI():InitProgressBar()
    GetMainUI():InitTeamCanChange(true, false)
	GetMainUI():InitTimer()
    GetMainUI():InitMMOFightUIClick();
	GetMainUI():InitShowFightWave();

    if self.diaoxiangEntityName then
        local obj = GetObj(self.diaoxiangEntityName)
		if obj then
			obj.ui_hp:SetName(true, "守护目标", 2)
		end
    end

	FightStartUI.Show({need_pause=true})
	FightStartUI.SetEndCallback(self.CallFightStart, self)
end

function GaoSuJuJiSimpleFightManager:OnBeginWave(cur_wave,max_wave)

	if GetMainUI() then
		GetMainUI():GetComponent(EMMOMainUICOM.MainUIShowFightWave):UpdateWave(cur_wave,max_wave)
	end
	
	local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi];
	fs:SetPlayerKillingWave(cur_wave,max_wave)
end

function GaoSuJuJiSimpleFightManager:OnKillWave(cur_wave,max_wave)
	--app.log("kill wave over:"..tostring(cur_wave).." max:"..tostring(max_wave))
    local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi];
    fs:SetPlayerKilledWave(cur_wave, max_wave)
    if cur_wave == max_wave then
        self:FightOver()
    end
end

-- function GaoSuJuJiSimpleFightManager:GetMainHeroAutoFightAI()
--     return 112
-- end

function GaoSuJuJiSimpleFightManager:OnLoadHero(entity)
	FightManager.OnLoadHero(self, entity);
	entity:SetHomePosition(entity:GetPosition(true, true))
end

function GaoSuJuJiSimpleFightManager:FightOver(is_set_exit, is_forced_exit)
    
    -- if is_set_exit or is_forced_exit then
    --      local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi];
    --      if fs then
    --         fs:ForceExit()
    --      end
    -- end
	if not is_set_exit and not is_forced_exit then
		local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi];
		self:SetConditionWinFlag(fs:GetKilledWave() > 0)
	end

    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end

function GaoSuJuJiSimpleFightManager:OnShowFightResultUI()
	local _PlayMethod = FightScene.GetStartUpEnv():GetPlayMethod();
	local star = FightRecord.GetStar();
	if _PlayMethod then
		-- if _PlayMethod == 60054009 then
		-- 	local data = {};
		-- 	if star > 0 then
		-- 		data.star = 3;
		-- 	else
		-- 		data.star = 0;
		-- 	end
		-- 	data.copyId = FightScene.GetCurHurdleID();
		-- 	data.callback = FightScene.ExitFightScene;
		-- 	FightResultUi.Init(data);
		-- 	return;
		-- end
		if g_dataCenter.activity[_PlayMethod] then
			if self.passCondition then 
				if self.passCondition.win then 
					g_dataCenter.activity[_PlayMethod]:EndGame(self.passCondition.win.flag);
				else 
					g_dataCenter.activity[_PlayMethod]:EndGame();
				end
			else 
				g_dataCenter.activity[_PlayMethod]:EndGame();
			end
		end	
	else
		--app.log("11..............."..tostring(star));
		local hurdleid = FightScene.GetCurHurdleID()
		local isAuto = PublicFunc.GetIsAuto(hurdleid)
		if star > 0 then
			local flags = {};
			table.insert(flags, FightRecord.IsWin() and 1 or 0);
			table.insert(flags, FightRecord.IsGood() and 1 or 0);
			table.insert(flags, FightRecord.IsPerfect() and 1 or 0);
			msg_hurdle.cg_hurdle_fight_result(hurdleid, self:GetFightUseTime(), isAuto, star, flags, self.openedBoxDropID);
		else
			msg_hurdle.cg_hurdle_fight_result(hurdleid, self:GetFightUseTime(), isAuto, 0 );
		end
	end
end