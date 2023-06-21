HurdleTrialBossFightManager = Class("HurdleTrialBossFightManager", FightManager);

function HurdleTrialBossFightManager.InitInstance()
	FightManager.InitInstance(HurdleTrialBossFightManager)
	return HurdleTrialBossFightManager;
end

function HurdleTrialBossFightManager:ClearUpInstance()
	if self.reliveTimerId then
		timer.stop(self.reliveTimerId)
		self.reliveTimerId = nil
	end
	self.reliveTimerCount = 0
	TimerManager.Remove(HurdleTrialBossFightManager.CreateBoss)
	FightManager.ClearUpInstance(self)
end

function HurdleTrialBossFightManager:InitData()
	FightManager.InitData(self);

	self.bossHurdle = self:GetHurdleConfig()

	self.killBossFlag = nil
	--覆盖父类变量
	self.followHeroUsedAI = ENUM.EAI.TrialBossFriendHero			--跟随AI

	self.enemyTeam = g_dataCenter.trial:get_enemyTeam()

	self.reliveTimeCfg = self.bossHurdle.relive_time or {{rs=0,re=60,t=1}}
	self.reliveTimerCount = 0	--定时器计数
	self.reBornTime = 1
end

function HurdleTrialBossFightManager:GetHurdleConfig()
	return ConfigManager.Get(EConfigIndex.t_hurdle_trial_boss,FightScene.GetCurHurdleID())
end

function HurdleTrialBossFightManager:RegistFunc()
	FightManager.RegistFunc(self)
	self.bindfunc['ReliveTimerStart'] = Utility.bind_callback(self, self.ReliveTimerStart);
end

function HurdleTrialBossFightManager:GetHeroAssetFileList(out_file_list)
	FightManager.GetHeroAssetFileList(self, out_file_list)

	for k, v in pairs(self.enemyTeam) do
		ObjectManager.GetHeroPreloadList(v.number, out_file_list)
	end
end

function HurdleTrialBossFightManager:GetNPCAssetFileList(out_file_list)
	FightManager.GetNPCAssetFileList(self, out_file_list)

	local id = self.bossHurdle.boss_info.id
	ObjectManager.GetMonterPreloadList(id, out_file_list)
end

function HurdleTrialBossFightManager:LoadHero()
	--获取英雄随机出生点信息（相对的2个点）
	local hero_pos_config = {{},{}}
	local born_pos_count = #self.bossHurdle.hero_born_pos
	local camp_a_index = math.random(1, born_pos_count)
	local camp_b_index = ( camp_a_index + math.floor(born_pos_count / 2) - 1 ) % born_pos_count + 1
	local camp_a_names = {}
	local camp_b_names = {}
	for i, obj_name in ipairs(self.bossHurdle.hero_born_pos[camp_a_index]) do
		camp_a_names[obj_name] = 1
	end
	for i, obj_name in ipairs(self.bossHurdle.hero_born_pos[camp_b_index]) do
		camp_b_names[obj_name] = 2
	end
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.burchhero)
	for k, v in pairs(config) do
		if camp_a_names[v.obj_name] then
			table.insert(hero_pos_config[1], table.copy(v))
		elseif camp_b_names[v.obj_name] then
			table.insert(hero_pos_config[2], table.copy(v))
		end
	end
	
	local env = FightScene.GetStartUpEnv()
	--己方英雄
	for camp_flag, team in pairs(env.fightTeamInfo) do
		for player_id, player_info in pairs(team.players) do
			for i, hero_id in ipairs(player_info.hero_card_list) do
				local pos = hero_pos_config[camp_flag][i]
				local newhero = self:LoadSingleHero(camp_flag, player_id, player_info.package_source, hero_id, pos);
				if newhero then
					newhero:SetInstanceName(i);
					newhero:SetBornPoint(pos.px, pos.py, pos.pz)
					newhero:SetRebornTime(self.reBornTime)
					--主控英雄默认手动战斗
					if newhero:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
						newhero:SetAI(ENUM.EAI.TrialBossFriendHero)
					end

					--计算buff加成属性
					newhero:SetPlayMethodAcitvityTimeEnum(MsgEnum.eactivity_time.eActivityTime_trial)
					newhero:CalPlayMethodProperty()

					newhero:SetConfig("view_radius", 1000)
    				newhero:SetConfig("act_radius", 2000)
				end
			end
		end
	end

	-- 敌方英雄
	local enemy_playerid = math.random(10000, 99999)
	local camp_flag = EFightInfoFlag.flag_b
	for i=1, 3 do
		if self.enemyTeam[i] then
			local pos = hero_pos_config[camp_flag][i]
			local newhero = self:LoadSingleHeroByCardData(camp_flag, enemy_playerid, self.enemyTeam[i], pos);
			if newhero then
				newhero:SetInstanceName(i);
				newhero:SetBornPoint(pos.px, pos.py, pos.pz)
				newhero:SetRebornTime(self.reBornTime)
				newhero:SetAI(ENUM.EAI.TrialBossEnemyHero)

				newhero:SetConfig("view_radius", 1000)
    			newhero:SetConfig("act_radius", 2000)
			end
		end
	end

	return true;
end

function HurdleTrialBossFightManager:CreateBoss()
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.burchmonster)
	if not config then return end

	for k, v in pairs(config) do
		if v.obj_name == self.bossHurdle.boss_info.obj_name then
			local copy_v = table.copy(v)
			copy_v.id = self.bossHurdle.boss_info.id
			copy_v.flag = 3
			local newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(copy_v)
			self:OnLoadMonster(newmonster);
			break;
		end
	end
end

function HurdleTrialBossFightManager:OnLoadMonster(entity)
	if g_dataCenter.trial:SetMonsterCard(entity:GetCardInfo()) then
		entity:UpdateProperty(true)
	end
end

function HurdleTrialBossFightManager:OnEvent_ObjDead(killer, target)
	if target:IsBoss() then
		self.killBossFlag = killer:GetCampFlag()
	end
end

function HurdleTrialBossFightManager:OnDead(entity)
	FightManager.OnDead(self, entity)

	if entity:IsHero() and entity:GetDontReborn() ~= true then
		local rebornFunc = function()
			if self:IsFightOver() then return end
			if entity and entity:IsDead() and self:GetAutoReborn() then
				local maxHp = entity:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
		        entity:SetProperty(ENUM.EHeroAttribute.cur_hp, maxHp);
		        local pos = entity:GetBornPoint() or entity:GetPosition()
				entity:Reborn(pos.x, pos.y, pos.z)
			end

			-- 己方复活，如果当前队长是死的，立即切换队长
			if entity:GetCampFlag() == 1 then
				local captain = g_dataCenter.fight_info:GetCaptain()
				if captain == nil or captain:IsDead() then
					local index = g_dataCenter.fight_info:GetAliveCaptaion()
					if index ~= nil then
						g_dataCenter.player:ChangeCaptain(index, true)
					end
				end
			end
		end

		-- 队长死亡切换到下一个存活队员
		local captain = g_dataCenter.fight_info:GetCaptain()
		if captain == entity then
			local index = g_dataCenter.fight_info:GetAliveCaptaion()
			if index ~= nil then
				g_dataCenter.player:ChangeCaptain(index, true)
			end
		end
		
		if entity:GetRebornTime() > 0 then
			TimerManager.Add(rebornFunc, 1000 * entity:GetRebornTime())
		end
	end
end

function HurdleTrialBossFightManager:OnUiInitFinish()
	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	-- local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsShowStarTip = (cf.is_show_star_tip == 1)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)

	local configIsAuto = g_dataCenter.player:GetVipData().expedition_trial_can_auto_fight;
	configIsAuto = (configIsAuto == 1) and true or false
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)

	GetMainUI():InitWorldChat()
    GetMainUI():InitZouMaDeng()
    GetMainUI():InitMMOFightUIClick();
    GetMainUI():InitTeamCanChange(true, true, true)
    GetMainUI():InitTimer()

	self:ReliveTimerStart()

	self:CallFightStart()
end

function HurdleTrialBossFightManager:CallFightStart()
	FightManager.CallFightStart(self)
	TimerManager.Add(HurdleTrialBossFightManager.CreateBoss, 1000*self.bossHurdle.boss_enter_time, 1, self)
end

function HurdleTrialBossFightManager:GetCampFlagKillBoss(camp_flag)
	return self.killBossFlag == camp_flag
end

function HurdleTrialBossFightManager:ReliveTimerStart()
	self.reliveTimerCount = self.reliveTimerCount + 1
	local cfg = self.reliveTimeCfg[self.reliveTimerCount]
	if cfg then
		self.reliveTimerId = timer.create(self.bindfunc["ReliveTimerStart"], (cfg.re - cfg.rs - 1) * 1000, 1)
		self.reBornTime = cfg.t
		-- 更新英雄复活时间
		local heroList = g_dataCenter.fight_info:GetHeroList(EFightInfoFlag.flag_a)
		if heroList then
			for k,v in pairs(heroList) do
				local obj = ObjectManager.GetObjectByName(v)
				if obj then
					obj:SetRebornTime(self.reBornTime)
				end
			end
		end

		heroList = g_dataCenter.fight_info:GetHeroList(EFightInfoFlag.flag_b)
		if heroList then
			for k,v in pairs(heroList) do
				local obj = ObjectManager.GetObjectByName(v)
				if obj then
					obj:SetRebornTime(self.reBornTime)
				end
			end
		end
	else
		self.reliveTimerId = nil
	end
end
