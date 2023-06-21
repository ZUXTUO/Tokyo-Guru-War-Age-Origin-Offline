
CloneFightFightManager = Class("CloneFightFightManager", FightManager)

function CloneFightFightManager.InitInstance()
	FightManager.InitInstance(CloneFightFightManager)
	return CloneFightFightManager;
end


function CloneFightFightManager:Start()

    self.followHeroUsedAI = 100
	FightManager.Start(self)
end

function CloneFightFightManager:SetHeroTeamAI()

	local capIndex = g_dataCenter.CloneBattle:GetCaptainIndex()
    g_dataCenter.player:ChangeCaptain(capIndex, nil, nil, true)

    local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
    for k, v in pairs(hero_list) do
        local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
        if teamIndex ~= capIndex then
            local obj = ObjectManager.GetObjectByName(v)
            obj:SetAiEnable(true)
        end
    end
end

function CloneFightFightManager:OnLoadHero(entity)
	FightManager.OnLoadHero(self, entity)
    entity:SetDontReborn(true)

    entity:SetConfig("view_radius", 1000)
    entity:SetConfig("act_radius", 2000)

end

function CloneFightFightManager:LoadMonster()
	local config = ConfigHelper.GetMapInf(FightScene.GetFightManager():GetFightMapInfoID(),EMapInfType.burchmonster)
	--app.log('CloneFightFightManager:LoadMonster ' .. table.tostring(config))
	if not config or #config < 1 then
		return
	end

	local monsters = g_dataCenter.CloneBattle:GetChallengeMonstersId()
	if not monsters or #monsters < 1 then
		return
	end
	local avgLevel = g_dataCenter.CloneBattle:GetMemberAverageLevel()

	local mosterid = monsters[1]
	local ml_v = table.copy(config[1])
    ml_v.id = mosterid
	local newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(ml_v, avgLevel)
	if newmonster then
		self:OnLoadMonster(newmonster);
	end
end


function CloneFightFightManager:OnFightOver()
    local use_time = self:GetFightUseTime()
	if self.passCondition.win.flag then
		msg_clone_fight.cg_end_fight(1,use_time)
	else
		msg_clone_fight.cg_end_fight(0,use_time)
	end
	g_dataCenter.CloneBattle:EndGame1(true)
end

function CloneFightFightManager:onForcedExit()
    --app.log("CloneFightFightManager:onForcedExit#############")
    g_dataCenter.CloneBattle:EndGame(true)
end

function CloneFightFightManager:OnUiInitFinish()
	local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	local str = hurdle.tips_string;
	local time = hurdle.tips_last;

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
    GetMainUI():InitTeamCanChange()
    GetMainUI():InitTimer()
    GetMainUI():InitMMOFightUIClick();
    
    FightStartUI.Show({need_pause=true})
    FightStartUI.SetEndCallback(self.CallFightStart, self)
end