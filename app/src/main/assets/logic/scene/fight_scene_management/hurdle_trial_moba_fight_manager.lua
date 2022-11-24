HurdleTrialMobaFightManager = Class("HurdleTrialMobaFightManager", HurdleMobaFightManager);

function HurdleTrialMobaFightManager.InitInstance()
	FightManager.InitInstance(HurdleTrialMobaFightManager)
	return HurdleTrialMobaFightManager;
end

function HurdleTrialMobaFightManager:ClearUpInstance()
	HurdleMobaFightManager.ClearUpInstance(self)
end

function HurdleTrialMobaFightManager:InitData()
	HurdleMobaFightManager.InitData(self);
	--默认关闭塔的依次搜索
	self.enableSearchOrder = false
	self.enemyTeam = g_dataCenter.trial:get_enemyTeam()
	self.enemy_playerid = math.random(10000, 99999) -- 生成一个随机id
end

function HurdleTrialMobaFightManager:GetHurdleConfig()
	return ConfigManager.Get(EConfigIndex.t_hurdle_trial_moba,FightScene.GetCurHurdleID())
end

function HurdleTrialMobaFightManager:GetNPCAssetFileList(out_file_list)
	local filepath = nil
    for i, data in pairs(self.mobaHurdle.left_npc_info) do
		filepath = ObjectManager.GetMonsterModelFile(data.id)
        if filepath then
			out_file_list[filepath] = filepath
		end
    end
    for i, data in pairs(self.mobaHurdle.right_npc_info) do
        filepath = ObjectManager.GetMonsterModelFile(data.id)
        if filepath then
			out_file_list[filepath] = filepath
		end
    end
end

function HurdleTrialMobaFightManager:LoadHero()
	local env = FightScene.GetStartUpEnv()
	local autoFightPath1, pathName1 = LevelMapConfigHelper.GetWayPoint('hwp_1', true)
	local autoFightPath2, pathName2 = LevelMapConfigHelper.GetWayPoint('hwp_2', true)

	--己方英雄
	for camp_flag, team in pairs(env.fightTeamInfo) do
		for player_id, player_info in pairs(team.players) do
			for i, hero_id in ipairs(player_info.hero_card_list) do
				local pos = self.heroBpInfo[camp_flag][i]
				local newhero = self:LoadSingleHero(camp_flag, player_id, player_info.package_source, hero_id, pos);
				if newhero then
					local heroInfo = {killHero={}, killTower={}, killContinue={}, currentContinueKillCount=0, gid=newhero:GetGID(), isDead=false}
					table.insert(self.heroInfo[camp_flag], heroInfo)	
					
					newhero._heroIndex = i
					newhero:SetInstanceName(i);
					newhero:SetBornPoint(pos.px, pos.py, pos.pz)
					newhero:SetRebornTime(self.reBornTime)
					--主控英雄默认手动战斗
					if camp_flag ~= EFightInfoFlag.flag_a or i > 1 then
						newhero:SetAI(self.heroAutoFightAI)
					end
					newhero:SetPatrolMovePath(autoFightPath1)

					table.insert(self.entityCache, {entity=newhero, ishero=true})

					self:SaveHeroSoulProperty(newhero)

					--计算buff加成属性
					newhero:SetPlayMethodAcitvityTimeEnum(MsgEnum.eactivity_time.eActivityTime_trial)
					newhero:CalPlayMethodProperty()
				end
			end
		end
	end

	-- 敌方英雄
	local camp_flag = EFightInfoFlag.flag_b
	for i=1, 3 do
		if self.enemyTeam[i] then
			local pos = self.heroBpInfo[camp_flag][i]
			local newhero = self:LoadSingleHeroByCardData(camp_flag, self.enemy_playerid, self.enemyTeam[i], pos);
			if newhero then
				local heroInfo = {killHero={}, killTower={}, killContinue={}, currentContinueKillCount=0, gid=newhero:GetGID(), isDead=false}
				table.insert(self.heroInfo[camp_flag], heroInfo)	
				
				newhero._heroIndex = i
				newhero:SetInstanceName(i);
				newhero:SetBornPoint(pos.px, pos.py, pos.pz)
				newhero:SetRebornTime(self.reBornTime)
				newhero:SetAI(self.heroAutoFightAI)
				newhero:SetPatrolMovePath(autoFightPath2)

				table.insert(self.entityCache, {entity=newhero, ishero=true})

				self:SaveHeroSoulProperty(newhero)
			end
		end
	end

	return true;
end

function HurdleTrialMobaFightManager:OnLoadMonster(entity)
	--修复泉水不加血bug，给泉水设置gid
	local camp_flag = entity:GetCampFlag()
	if camp_flag == 1 then
		entity:SetOwnerPlayerGID(g_dataCenter.player.playerid)
	end
	if camp_flag == 2 then
		entity:SetOwnerPlayerGID(self.enemy_playerid)
	end
	if g_dataCenter.trial:SetMonsterCard(entity:GetCardInfo()) then
		entity:UpdateProperty(true)
	end

	if entity:IsTower() or entity:IsBasis() then
		self:AddToMiniMap(entity, false)
	end
end

function HurdleTrialMobaFightManager:OnUiInitFinish()

	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	-- local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsShowStarTip = (cf.is_show_star_tip == 1)
	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)
	GetMainUI():InitProgressBar()
	local configIsAuto = g_dataCenter.player:GetVipData().expedition_trial_can_auto_fight;
	configIsAuto = (configIsAuto == 1) and true or false
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)

	GetMainUI():InitTeamCanChange(true, true)
    GetMainUI():InitTimer()

	GetMainUI():InitThreeToThree()
	GetMainUI():InitMobaFightTips()
	GetMainUI():TeamHeroAutoReborn()
	GetMainUI():InitCaptainRebornTip()

	self:CallFightStart()

	local mapParam = 
    {
        uiPath = self.mobaHurdle.mini_map,
        uiMapBkTex = 'Texture',
        iconsParam = 
        {
            [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = self.mobaHurdle.main_hero_adjust_angle},
            [EMapEntityType.EGreenBase] = {nodeName = 'sp_huangguan1'},
            [EMapEntityType.ERedBase] = {nodeName = 'sp_huangguan2'},
            [EMapEntityType.EGreenHero] = {nodeName = 'sp_green'},
            [EMapEntityType.EGRedHero] = {nodeName = 'sp_red'},
            [EMapEntityType.EAddHPBuff] = {nodeName = 'sp_add'},
            [EMapEntityType.EGreenTower] = {nodeName = 'sp_green_buff'},
            [EMapEntityType.ERedTower] = {nodeName = 'sp_red_buff'},
        },
        adjustAngle = self.mobaHurdle.map_adjust_angle,        

        sceneMapSizeName = 'scene_minimap',

        bigMapParam = {
            uiPath = self.mobaHurdle.big_map,
            uiMapBkTex = 'Texture',
            iconsParam = 
            {
                [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = self.mobaHurdle.main_hero_adjust_angle},
                [EMapEntityType.EGreenBase] = {nodeName = 'sp_huangguan1'},
                [EMapEntityType.ERedBase] = {nodeName = 'sp_huangguan2'},
                [EMapEntityType.EGreenHero] = {nodeName = 'sp_green'},
                [EMapEntityType.EGRedHero] = {nodeName = 'sp_red'},
                [EMapEntityType.EAddHPBuff] = {nodeName = 'sp_add'},
                [EMapEntityType.EGreenTower] = {nodeName = 'sp_green_buff'},
                [EMapEntityType.ERedTower] = {nodeName = 'sp_red_buff'},
            },
            adjustAngle = self.mobaHurdle.map_adjust_angle,        

            sceneMapSizeName = 'scene_minimap'
        }
    }
    GetMainUI():InitMinimap(mapParam)


	for i, data in pairs(self.entityCache) do
		if data.entity then
			if data.isbuff then
				GetMainUI():GetMinimap():AddPeople(data.entity, EMapEntityType.EAddHPBuff)
			elseif data.ishero then
				self:AddToMiniMap(data.entity, data.ishero)
			end
		end
	end

	self.fightBeginTime = system.time()

	self:ReliveTimerStart()

	timer.create(self.bindfunc["CreateTowerAreaEffect"], 1000, 1)
end

function HurdleTrialMobaFightManager:ReliveTimerStart()
	self.reliveTimerCount = self.reliveTimerCount + 1
	local cfg = self.reliveTimeCfg[self.reliveTimerCount]
	if cfg then
		self.reliveTimerId = timer.create(self.bindfunc["ReliveTimerStart"], (cfg.re - cfg.rs - 1) * 1000, 1)
		self.reBornTime = cfg.t
		-- 更新英雄复活时间
		for camp_flag=1, 2 do
			local heroList = g_dataCenter.fight_info:GetHeroList(camp_flag)
			if heroList then
				for k,v in pairs(heroList) do
					local obj = ObjectManager.GetObjectByName(v)
					if obj then
						obj:SetRebornTime(self.reBornTime)
					end
				end
			end
		end
	else
		self.reliveTimerId = nil
	end
end
