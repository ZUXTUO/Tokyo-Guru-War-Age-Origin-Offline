HurdleFuzionFourFightManager = Class("HurdleFuzionFourFightManager", FightManager);

function HurdleFuzionFourFightManager.InitInstance()
	FightManager.InitInstance(HurdleFuzionFourFightManager)
	return HurdleFuzionFourFightManager;
end

function HurdleFuzionFourFightManager:InitData()
	FightManager.InitData(self);
	self.heroSeqIndex = {};
	self.curPersonNum = 4;
	self.killNum = 0;
	self.deadNum = 0;
	self.timerid = {};
	self.usingName = {};
	self.loadMonsterList = {};
	self.loadHeroList = {};
	self.rank = 4;
end

function HurdleFuzionFourFightManager:LoadHero()
	local env = FightScene.GetStartUpEnv()
	for camp_flag, team in pairs(env.fightTeamInfo) do
		for player_id, player_info in pairs(team.players) do
			self.heroSeqIndex[1] =
			{
				dead=0,
				surviveTime=0,
				HeroList={1},
				name=player_info.obj:GetName(),
				playerid=player_info.obj:GetGID(),
				kill = 0,
			};
			self.usingName[player_info.obj:GetName()] = 1;
		end
	end
	FightManager.LoadHero(self);
	return true;
end

function HurdleFuzionFourFightManager:OnLoadHero(entity)
	FightManager.OnLoadHero(self, entity)
	entity.ui_hp:SetName(true, self.heroSeqIndex[1].name);
	if GetMainUI() and GetMainUI():GetMinimap() then
		GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
	else
		table.insert(self.loadHeroList, entity);
	end
end

function HurdleFuzionFourFightManager:LoadMonster()
	for i=2,4 do
		local name = PublicFunc.GetRandomName(self.usingName);
		self.usingName[name] = 1;
		self.heroSeqIndex[i] =
		{
			dead=0,
			surviveTime=0,
			HeroList={1},
			name=name,
			kill=0
		};
	end
	FightManager.LoadMonster(self);
end

function HurdleFuzionFourFightManager:OnLoadMonster(entity)
	FightManager.OnLoadMonster(self, entity)
	local camp = entity:GetCampFlag();
	if self.heroSeqIndex[camp] then
		entity.ui_hp:SetName(true, self.heroSeqIndex[camp].name);
		if GetMainUI() and GetMainUI():GetMinimap() then
			GetMainUI():GetMinimap():AddPeople(newmonster, EMapEntityType.EGRedHero);
		else
			table.insert(self.loadMonsterList, newmonster);
		end
	end
end

function HurdleFuzionFourFightManager:FightOver(is_set_exit, is_forced_exit)
	NewFightUiCount.Destroy();
	FightManager.FightOver(self,is_set_exit, is_forced_exit);
end

function HurdleFuzionFourFightManager:OnUiInitFinish()
	FightManager.OnUiInitFinish(self)
	-- GetMainUI():InitFightFuzionTop()
    GetMainUI():InitFightFuzionRank();
	self:_UpdateUI();
end

function HurdleFuzionFourFightManager:OnEvent_ObjDead(killer, target)
	FightManager.OnEvent_ObjDead(self, killer, target)

	if killer then
		local killer_camp = killer:GetCampFlag();
		self.heroSeqIndex[killer_camp].kill = self.heroSeqIndex[killer_camp].kill + 1
	end
	local target_camp = target:GetCampFlag();
	self.heroSeqIndex[target_camp].dead = self.heroSeqIndex[target_camp].dead + 1

	if killer:IsMyControl() then
		self.killNum = self.killNum + 1;
	end
	if target:IsMyControl() then
		self.deadNum = self.deadNum + 1;
		NewFightUiCount.Start({need_pause = false});
	end
	local function func()
		self.timerid[target] = nil;
		local pos = self:GetRebornPos()[math.random(1,4)];
		target:Reborn(pos.px, pos.py, pos.pz);
	end
	self.timerid[target] = timer.create(Utility.create_callback(func),5000,1);
	self:_UpdateUI();
end

function HurdleFuzionFourFightManager:CheckPassConditionImpl()
	-- TODO: (kevin) 冻结一切对象行为。
	if self:IsFightOver() then
		return 
	end
	self.passCondition.good.flag = self:__checkConditionAnd(self.passCondition.good.check)
	self.passCondition.perfect.flag = self:__checkConditionAnd(self.passCondition.perfect.check)
	self.passCondition.win.flag = self:__checkConditionAnd(self.passCondition.win.check)
	local flag = false
	if nil ~= self.passCondition.lose then
		flag = self:__checkConditionOr(self.passCondition.lose.check)
		--app.log("fail  "..tostring(flag).."  "..table.tostring(self.passCondition.lose.check));
		if flag then
			self.passCondition.lose.flag = true
			self:FightOver()
			return
		end	
	end

    local mainui = GetMainUI()
    if mainui then
        mainui:setTaskComplete(1, self.passCondition.win.flag);
        mainui:setTaskComplete(2, self.passCondition.good.flag);
        mainui:setTaskComplete(3, self.passCondition.perfect.flag);
    end
end

function HurdleFuzionFourFightManager:GetMainHeroAutoFightViewAndActRadius()
    return 50,1000
end

function HurdleFuzionFourFightManager:_UpdateUI()
	GetMainUI():GetFightFuzionRank():SetKillNum(self.killNum);
	GetMainUI():GetFightFuzionRank():SetDeadNum(self.deadNum);
	GetMainUI():GetFightFuzionRank():SetSurviveNum(self.curPersonNum,4);

	local fighter = self.heroSeqIndex[1];
    local playerList = self.heroSeqIndex;
    local surviveNum = 0;
    self.rank = 1;
    for k,v in pairs(playerList) do
        local heroList = v.HeroList;
        if #heroList ~= v.dead then
            surviveNum = surviveNum + 1;
        end

        local flg=false;
        repeat
            if fighter.surviveTime == 0 and v.surviveTime ~= 0 then
                flg = true;
                break;
            elseif fighter.surviveTime ~= 0 and v.surviveTime == 0 then
                flg = false;
                break;
            end
            if fighter.surviveTime > v.surviveTime then
                flg = true;
                break;
            elseif fighter.surviveTime < v.surviveTime then
                flg = false;
                break;
            end
            if fighter.kill > v.kill then
                flg = true;
                break;
            elseif fighter.kill < v.kill then
                flg = false;
                break;
            end
            if fighter.dead < v.dead then
                flg = true;
                break;
            elseif fighter.dead > v.dead then
                flg = false;
                break;
            end
        until true
        if not flg and fighter.playerid ~= v.playerid then
            self.rank = self.rank + 1;
        end
    end
    GetMainUI():GetFightFuzionRank():SetRank(self.rank);
    GetMainUI():GetFightFuzionRank():SetData(playerList);
end

function HurdleFuzionFourFightManager:IsClearOtherEnemy()
	local bClear = true;
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
    	local isClear = g_dataCenter.fight_info:IsHaveMonster(i);
    	if not isClear then
    		bClear = false;
    		break;
    	end
    end
	return bClear;
end

function HurdleFuzionFourFightManager:Destroy()
	FightManager.Destroy(self);
	if self.timerid then
		for k,v in pairs(self.timerid) do
			timer.stop(v);
		end
		self.timerid = nil;
	end
end

function HurdleFuzionFourFightManager:GetKillNum()
	return self.killNum;
end

function HurdleFuzionFourFightManager:GetMainHeroAutoFightAI()
	return 117;
end

function HurdleFuzionFourFightManager:GetRank()
	return self.rank or 4;
end

function HurdleFuzionFourFightManager:GetRebornPos()
	local posList = {};
	local mapinfo = ConfigHelper.GetMapInf(tostring(self:GetFightMapInfoID()),EMapInfType.monster);
	for k,v in pairs(mapinfo) do
		table.insert(posList,v);
	end
	mapinfo = ConfigHelper.GetMapInf(tostring(self:GetFightMapInfoID()),EMapInfType.burchhero);
	for k,v in pairs(mapinfo) do
		if v.obj_name == "hbp_1" then
			table.insert(posList,v);
		end
	end
	return posList;
end

function HurdleFuzionFourFightManager:GetDeadNum()
	return self.deadNum;
end
