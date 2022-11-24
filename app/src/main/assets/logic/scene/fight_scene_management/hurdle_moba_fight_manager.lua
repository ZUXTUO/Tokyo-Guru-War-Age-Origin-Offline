HurdleMobaFightManager = Class("HurdleMobaFightManager", FightManager);

function HurdleMobaFightManager.InitInstance()
	FightManager.InitInstance(HurdleMobaFightManager)
	return HurdleMobaFightManager;
end

function HurdleMobaFightManager:ClearUpInstance()
	if self.reliveTimerId then
		timer.stop(self.reliveTimerId)
		self.reliveTimerId = nil
	end
	self.reliveTimerCount = 0

	FightManager.ClearUpInstance(self)
end

function HurdleMobaFightManager:InitData()
	FightManager.InitData(self);
	
	-- 英雄状态
	-- killHero=
	-- {
	-- 	{index=目标英雄序号, time=达成时间},
	-- 	...
	-- }
	-- killTower=
	-- {
	-- 	{type=1精英2守卫3基地, time=达成时间}
	-- 	...
	-- }
	-- killContinue=
	-- {
	-- 	[最大连杀数2] = {count=完成计数, fastTime=最快达成时间}
	-- 	...
	-- }
	-- currentContinueKillCount=当前连杀计数
	-- isDead=死亡状态
	self.heroInfo = {{}, {}}
	--团队状态（teamDeadCnt团灭次数,killHeroCnt击杀对方英雄数量）
	self.teamInfo = {{teamDeadCnt=0, killHeroCnt=0}, {teamDeadCnt=0, killHeroCnt=0}}
	--双方塔怪状态
	self.towerInfo = {{}, {}}
	self.heroBpInfo = {{}, {}}			--英雄出生点
	self.tipsData = {}
	self.delayOverTimer = nil

	self.fightBeginTime = 0
	self.myKillHeroCnt = 0				--亲手杀死的敌方英雄数量

	self.maxVal = ConfigManager.GetDataCount(EConfigIndex.t_soul_value_property)
	self.mobaHurdle = self:GetHurdleConfig()
	--队伍当前魂值数据
	self.teamSoulDataList = {}
	self.teamSoulDataList[EFightInfoFlag.flag_a] = {soulValue=0, entity_group={}}
    self.teamSoulDataList[EFightInfoFlag.flag_b] = {soulValue=0, entity_group={}}
	self.monsterGenSouls = {}
	for i, data in pairs(self.mobaHurdle.monster_soul) do
		self.monsterGenSouls[data.id] = data.val or 0
	end
	self.heroGenSoul = self.mobaHurdle.hero_soul or 0

	self.add2MapEntityCache = {}
	self.entityCache = {}

	self.reliveTimeCfg = self.mobaHurdle.relive_time or {{rs=0,re=60,t=1}}
	self.reliveTimerCount = 0	--定时器计数
	self.reBornTime = 1

	--覆盖父类变量
	self.followHeroUsedAI = ENUM.EAI.ThreeVThreeRobot			--跟随AI
	
	self.heroAutoFightAI = ENUM.EAI.ThreeVThreeAutoFight

	--默认开启塔的依次搜索
	self.enableSearchOrder = true
end

function HurdleMobaFightManager:GetHurdleConfig()
	return ConfigManager.Get(EConfigIndex.t_hurdle_moba,FightScene.GetCurHurdleID())
end

function HurdleMobaFightManager:RegistFunc()
	FightManager.RegistFunc(self)
	self.bindfunc['TipsTimerCallback'] = Utility.bind_callback(self, self.TipsTimerCallback);
	self.bindfunc['ReliveTimerStart'] = Utility.bind_callback(self, self.ReliveTimerStart);
	self.bindfunc['DeleteBufferItem'] = Utility.bind_callback(self, self.DeleteBufferItem);
	self.bindfunc['CreateBufferItem'] = Utility.bind_callback(self, self.CreateBufferItem);
	self.bindfunc['EntityUseSkill'] = Utility.bind_callback(self, self.EntityUseSkill);
	self.bindfunc['CreateTowerAreaEffect'] = Utility.bind_callback(self, self.CreateTowerAreaEffect);

	NoticeManager.BeginListen(ENUM.NoticeType.DeleteBufferItem, self.bindfunc['DeleteBufferItem'])
	NoticeManager.BeginListen(ENUM.NoticeType.CreateBufferItem, self.bindfunc['CreateBufferItem'])
	NoticeManager.BeginListen(ENUM.NoticeType.EntityUseSkill, self.bindfunc['EntityUseSkill'])
end

function HurdleMobaFightManager:UnRegistFunc()
	NoticeManager.EndListen(ENUM.NoticeType.DeleteBufferItem, self.bindfunc['DeleteBufferItem'])
	NoticeManager.EndListen(ENUM.NoticeType.CreateBufferItem, self.bindfunc['CreateBufferItem'])
	NoticeManager.EndListen(ENUM.NoticeType.EntityUseSkill, self.bindfunc['EntityUseSkill'])
	FightManager.UnRegistFunc(self)
end

function HurdleMobaFightManager:LoadSceneObject()
	local mapInfo = ConfigHelper.GetMapInf(tostring(self:GetFightMapInfoID()), EMapInfType.burchhero);
	for k, v in pairs(mapInfo) do
		if string.find(v.obj_name, "hbp_") then
			local index = tonumber(string.sub(v.obj_name, 4 - #v.obj_name))
			if index then
				table.insert(self.heroBpInfo[v.flag], v)
			end
		end
	end
	
    FightManager.LoadSceneObject(self)
end

function HurdleMobaFightManager:GetNPCAssetFileList(out_file_list)
    for k, v in pairs(self.mobaHurdle.right_hero or {}) do
		ObjectManager.GetMonterPreloadList(v, out_file_list)
    end
    for i, data in pairs(self.mobaHurdle.left_npc_info) do
		ObjectManager.GetMonterPreloadList(data.id, out_file_list)
    end
    for i, data in pairs(self.mobaHurdle.right_npc_info) do
        ObjectManager.GetMonterPreloadList(data.id, out_file_list)
    end
	self.monsterLoader:GetNPCAssetFileList(out_file_list);
end

--type 0基地 1第一排塔 2第二排塔 以此类推
--camp 代表是左边还是有右边 entity:GetCampFlag()
function HurdleMobaFightManager:GetNpcPos(type, camp)
    local pos = {}
	for i, data in ipairs(self.towerInfo[camp]) do
		if data.type == type then
			table.insert(pos, {x = data.pos.x, y = data.pos.z, z = 0})
			break;
		end
	end
    return pos;
end

function HurdleMobaFightManager:LoadHero()
	local env = FightScene.GetStartUpEnv()
	local autoFightPath1, pathName1 = LevelMapConfigHelper.GetWayPoint('hwp_1', true)
	local autoFightPath2, pathName2 = LevelMapConfigHelper.GetWayPoint('hwp_2', true)

	local camp = EFightInfoFlag.flag_a
	for player_id, player_info in pairs(env.fightTeamInfo[camp].players) do
		for i, hero_id in ipairs(player_info.hero_card_list) do
			local pos = self.heroBpInfo[camp][i]
			local newhero = self:LoadSingleHero(camp, player_id, player_info.package_source, hero_id, pos);
			if newhero then
				local heroInfo = {killHero={}, killTower={}, killContinue={}, currentContinueKillCount=0, gid=newhero:GetGID(), isDead=false}
				table.insert(self.heroInfo[camp], heroInfo)	
				
				newhero._heroIndex = i
				newhero:SetInstanceName(i);
				newhero:SetBornPoint(pos.px, pos.py, pos.pz)
				newhero:SetRebornTime(self.reBornTime)
				--主控英雄默认手动战斗
				if i > 1 then
					newhero:SetAI(self.heroAutoFightAI)
				end
				newhero:SetPatrolMovePath(autoFightPath1)

				table.insert(self.entityCache, {entity=newhero, ishero=true})

				self:SaveHeroSoulProperty(newhero)
			end
		end
	end

	local camp = EFightInfoFlag.flag_b
	for i, monster_id in ipairs(self.mobaHurdle.right_hero or {}) do
		local pos = self.heroBpInfo[camp][i]
		local newmonster = FightScene.CreateMonsterAsync(nil, monster_id, camp, nil, nil, nil)
		if newmonster then
			local heroInfo = {killHero={}, killTower={}, killContinue={}, currentContinueKillCount=0, gid=newmonster:GetGID(), isDead=false}
			table.insert(self.heroInfo[camp], heroInfo)

			newmonster._heroIndex = i
			newmonster:SetPosition(pos.px,0,pos.pz)
			newmonster:SetRotation(pos.rx,pos.ry,pos.rz)
			PublicFunc.UnifiedScale(newmonster, pos.sx, pos.sy, pos.sz)
			newmonster:SetInstanceName(i);
			newmonster:SetBornPoint(pos.px, pos.py, pos.pz)
			newmonster:SetRebornTime(self.reBornTime)
			newmonster:SetAI(self.heroAutoFightAI)
			newmonster:SetPatrolMovePath(autoFightPath2)

			table.insert(self.entityCache, {entity=newmonster, ishero=true})

			self:SaveHeroSoulProperty(newmonster)
		end
	end

	return true;
end

function HurdleMobaFightManager:GetMainHeroAutoFightAI()
    return self.heroAutoFightAI
end

-- function HurdleMobaFightManager:OnLoadHero(entity)
-- end

function HurdleMobaFightManager:LoadMonster()
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.monster)
	local newmonster = nil
	if not config then
		return
	end

	local tower = {{},{}}
	for i, v in ipairs(self.mobaHurdle.left_npc_info or {}) do
		tower[EFightInfoFlag.flag_a][v.obj_name] = v
	end
	for i, v in ipairs(self.mobaHurdle.right_npc_info or {}) do
		tower[EFightInfoFlag.flag_b][v.obj_name] = v
	end

	for k, v in pairs(config) do
		if v.id ~= nil then
			if tower[v.flag] and tower[v.flag][v.obj_name] then
				local copy_v = table.copy(v)
				copy_v.id = tower[v.flag][v.obj_name].id
				newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(copy_v)
			else
				newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(v)
			end
			if newmonster then
				if tower[v.flag] and tower[v.flag][v.obj_name] then
					newmonster._towerType = tower[v.flag][v.obj_name].type

					local distance = 0
					if newmonster:IsTower() then
						distance = newmonster:GetSkill(1):GetDistance()
					end
					table.insert(self.towerInfo[v.flag], 
						{type=newmonster._towerType, name=newmonster:GetName(), dead=false, search=false, gid=newmonster:GetGID(), dis=distance, pos={x=v.px,y=v.py,z=v.pz}})
					
					if self.enableSearchOrder then
						newmonster:SetCanSearch(false)
						newmonster:HideHP(true)
					end
				end
				self:OnLoadMonster(newmonster);
				newmonster:SetDontReborn(true);

				self:AddToMiniMap(entity, true)
			end
		end
	end

	self:UpdateCanSearchFlag(EFightInfoFlag.flag_a)
	self:UpdateCanSearchFlag(EFightInfoFlag.flag_b)
end

function HurdleMobaFightManager:UpdateCanSearchFlag(camp)
	if not self.enableSearchOrder then return end

	local isAnyDead = false
	--1塔阵亡
	for i, data in pairs(self.towerInfo[camp]) do
		if data.type == 1 then
			if data.dead then
				isAnyDead = true
			end
			if data.search == false then
				data.search = true
				local monster = ObjectManager.GetObjectByName(data.name)
				if monster then
					monster:SetCanSearch(true)
					monster:HideHP(false)
				end
			end
		end
	end
	if isAnyDead == false then return end

	isAnyDead = false
	--2塔阵亡
	for i, data in pairs(self.towerInfo[camp]) do
		if data.type == 2 then
			if data.dead then
				isAnyDead = true
			end
			if data.search == false then
				data.search = true
				local monster = ObjectManager.GetObjectByName(data.name)
				if monster then
					monster:SetCanSearch(true)
					monster:HideHP(false)
				end
			end
		end
	end
	if isAnyDead == false then return end

	for i, data in pairs(self.towerInfo[camp]) do
		if data.type == 3 then
			if data.search == false then
				data.search = true
				local monster = ObjectManager.GetObjectByName(data.name)
				if monster then
					monster:SetCanSearch(true)
					monster:HideHP(false)
				end
			end
		end
	end
end

function HurdleMobaFightManager:Update(deltaTime)
    FightManager.Update(self,deltaTime);

	if self.update_seq then
		self.update_seq = self.update_seq + 1
	else
		self.update_seq = 1
	end

	if self.update_seq % 2 == 1 then
		return
	end
    
    local captain = g_dataCenter.fight_info:GetCaptain()
	if captain == nil then return end

	local tower = nil
	local target = nil
    local pos = nil
    local real_dis = nil
	local is_enemy = nil
    local into_value = 0    --0/1/2 预警区外/预警区中/攻击区中
    for camp, info in pairs(self.towerInfo) do
		is_enemy = captain:GetCampFlag() ~= camp
        for i, v in pairs(info) do
            tower = ObjectManager.GetObjectByGID(v.gid)
            if tower and tower:IsTower() then
                --检查主控英雄是否进入预警范围(攻击范围+1)
                if is_enemy then
                    pos = captain:GetPosition()
                    real_dis = algorthm.GetDistance(v.pos.x, v.pos.z, pos.x, pos.z)
                    into_value = 0
                    if v.dis > real_dis - 2 and not captain:IsDead() then
                        if v.dis < real_dis then
                            into_value = 1
                        else
                            into_value = 2
                        end
                    end
                    tower:IntoTowerShowArea(captain, into_value)
                end

                --检查受击对象是否脱离攻击范围
				target = tower:GetTowerAttackTarget()
                if target and not target:IsDead() then
                    pos = target:GetPosition()
                    real_dis = algorthm.GetDistance(v.pos.x, v.pos.z, pos.x, pos.z)
                    if v.dis > real_dis then
                        tower:ShowTowerLockTarget(target, true)
                    else
                        tower:ShowTowerLockTarget(target, false)
                    end
                end
            end
        end
    end
end

function HurdleMobaFightManager:OnLoadMonster(entity)
	if entity:IsTower() or entity:IsBasis() then
		self:AddToMiniMap(entity, false)
	end

	if entity:IsBasis() then
		entity.ui_hp:SetName(true, "[EA0256FF]领主[-]", 2)
	elseif entity:IsTower() then
		if entity._towerType == 1 then
			entity.ui_hp:SetName(true, "[E1B741FF]守卫[-]", 2)
		elseif entity._towerType == 2 then
			entity.ui_hp:SetName(true, "[E95F3BFF]精英[-]", 2)
		end
	end
end

function HurdleMobaFightManager:OnLoadItem(entity)
	if entity:GetConfigId() then
		table.insert(self.entityCache, {entity=entity, isbuff=true})
	end
end

function HurdleMobaFightManager:FightOver(is_set_exit, is_forced_exit)
	if self:IsFightOver() then
		return
	end

	if is_set_exit or is_forced_exit then
		FightManager.FightOver(self, is_set_exit, is_forced_exit)
	-- add delay time
	elseif not self.delayOverTimer then
		ObjectManager.EnableAllAi(false)

		self.delayOverTimer = true
		TimerManager.Add(HurdleMobaFightManager.DelayOverTimerCallback, 1500, 1, self)

		-- FightManager.FightOver(self)
	end
end

function HurdleMobaFightManager:DelayOverTimerCallback()
	self.delayOverTimer = nil
	FightManager.FightOver(self)
end

function HurdleMobaFightManager:IsAutoSetPath()
    return false;
end

function HurdleMobaFightManager:AddToMiniMap(entity, isHero)

    if not entity then return end

    local captain = g_dataCenter.fight_info:GetCaptain()
    if captain then

        if #self.add2MapEntityCache > 0 then
            for k,v in pairs(self.add2MapEntityCache) do
                self:_AddToMiniMap(captain, v.entity, v.isHero)
            end

            self.add2MapEntityCache = {}
        end

        self:_AddToMiniMap(captain, entity, isHero)
    else
        table.insert(self.add2MapEntityCache, {entity = entity, isHero = isHero})
    end
end

function HurdleMobaFightManager:_AddToMiniMap(captain, entity, isHero)

    if isHero then

        if entity:GetName() == captain:GetName() then
            GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
        else
            if captain:GetCampFlag() == entity:GetCampFlag() then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGreenHero)
            else
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGRedHero)
            end
        end
    else
        if captain:GetCampFlag() == entity:GetCampFlag() then
            if entity:GetType() == ENUM.EMonsterType.Tower then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGreenTower)
            elseif entity:GetType() == ENUM.EMonsterType.Basis then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGreenBase)
            end
        else
            if entity:GetType() == ENUM.EMonsterType.Tower then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.ERedTower)
            elseif entity:GetType() == ENUM.EMonsterType.Basis then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.ERedBase)
            end
        end
    end
end

function HurdleMobaFightManager:EntityReborn(entity)
    FightManager.EntityReborn(self, entity)
    if GetMainUI():GetMinimap() and (entity:IsHero() or (entity:IsMonster() and entity:GetType() == ENUM.EMonsterType.Hero))  then
        self:AddToMiniMap(entity, true)
    end
end

function HurdleMobaFightManager:OnEvent_ObjDead(killer, target)
	if killer == nil then
		app.log("死亡数据异常")
		return
	end
	--更新英雄战斗数据
	local killerCamp = killer:GetCampFlag()
	local targetCamp = target:GetCampFlag()
	
	local newContinueKillCount = 0
	local towerKilledType = nil
	
	if killer._heroIndex ~= nil then
		--掉落魂值
		local dropSoulValue = nil
		local heroInfo = self.heroInfo[killerCamp][killer._heroIndex]
		--击杀英雄
		if target._heroIndex ~= nil and killer ~= target then
			table.insert(heroInfo.killHero, {index=target._heroIndex, time=system.time()})

			--终止目标的连续击杀计数
			local targetInfo = self.heroInfo[targetCamp][target._heroIndex]
			targetInfo.currentContinueKillCount = 0

			--更新击杀者的连续击杀数据
			newContinueKillCount = heroInfo.currentContinueKillCount + 1
			heroInfo.currentContinueKillCount = newContinueKillCount
			if heroInfo.killContinue[newContinueKillCount] == nil then
				heroInfo.killContinue[newContinueKillCount] = {count=1, fastTime=system.time()}
			else
				heroInfo.killContinue[newContinueKillCount].count = heroInfo.killContinue[newContinueKillCount].count + 1
			end

			if g_dataCenter.fight_info:GetCaptain() == killer then
				self.myKillHeroCnt = self.myKillHeroCnt + 1
			end

			dropSoulValue = self.heroGenSoul
		else
			--击杀塔怪
			if target._towerType ~= nil then
				towerKilledType = target._towerType
				table.insert(heroInfo.killTower, {type=target._towerType, time=system.time()})
				for i, data in pairs(self.towerInfo[targetCamp]) do
					if data.name == target:GetName() then
						data.dead = true
						break;
					end
				end
				self:UpdateCanSearchFlag(targetCamp)
			end

			local id = target:GetConfigNumber()
			dropSoulValue = self.monsterGenSouls[id]
		end

		if dropSoulValue and dropSoulValue > 0 then
			self:AddTeamHeroSoulProperty(killerCamp, dropSoulValue, target)
		else
			app.log("配置掉落魂值为0：id="..tostring(target:GetConfigNumber()))
		end

	--击杀者是小兵或者塔
	else
		--击杀英雄
		if target._heroIndex ~= nil then
			--终止目标的连续击杀计数
			local targetInfo = self.heroInfo[targetCamp][target._heroIndex]
			targetInfo.currentContinueKillCount = 0

		--击杀塔怪
		elseif target._towerType ~= nil then
			towerKilledType = target._towerType
			for i, data in pairs(self.towerInfo[targetCamp]) do
				if data.name == target:GetName() then
					data.dead = true
					break;
				end
			end
			self:UpdateCanSearchFlag(targetCamp)
		end
	end
	
	--团灭状态更新
	local teamDead = false
	if target._heroIndex ~= nil then
		teamDead = true
		for i, targetInfo in pairs(self.heroInfo[targetCamp]) do
			local heroEntity = ObjectManager.GetObjectByGID(targetInfo.gid)
			if heroEntity and not heroEntity:IsDead() then
				teamDead = false
				break
			end
		end
		if teamDead then
			self.teamInfo[targetCamp].teamDeadCnt = self.teamInfo[targetCamp].teamDeadCnt + 1
		end
		self.teamInfo[killerCamp].killHeroCnt = self.teamInfo[killerCamp].killHeroCnt + 1
	end

	FightManager.OnEvent_ObjDead(self, killer, target)

	if target._heroIndex ~= nil then
		local killCnt = self.teamInfo[EFightInfoFlag.flag_a].killHeroCnt
		local deadCnt = self.teamInfo[EFightInfoFlag.flag_b].killHeroCnt

		if GetMainUI() and GetMainUI():GetThreeToThree() then
			GetMainUI():GetThreeToThree():UpdateScoreData(killCnt, deadCnt)
		end
	end
	
	if newContinueKillCount > 0 then
		local data = {type=1, left_rid=killer:GetConfigNumber(), right_rid=target:GetConfigNumber(), camp=killerCamp, kill_count=newContinueKillCount, killer_gid=killer:GetGID()}
		table.insert(self.tipsData, data)
	elseif towerKilledType then
		local data = {type=2, camp=killerCamp, tower_type=towerKilledType, left_rid=killer:GetConfigNumber(), right_rid=target:GetConfigNumber()}
		table.insert(self.tipsData, data)
	end

	if teamDead then
		local data = {type=2, camp=killerCamp}
		table.insert(self.tipsData, data)
	end

	if #self.tipsData > 0 then
		TimerManager.Add(self.TipsTimerCallback, 1, 1, self)
	end
end

function HurdleMobaFightManager:OnDead(entity)
	FightManager.OnDead(self, entity)

	if GetMainUI():GetMinimap() and (entity:IsMonster() or entity:IsHero()) then
        GetMainUI():GetMinimap():DeletePeople(entity);
    end

	if entity:GetDontReborn() ~= true and entity:IsHero() or (entity:IsMonster() and entity:GetType() == ENUM.EMonsterType.Hero) then
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

function HurdleMobaFightManager:TipsTimerCallback()
	if self:IsFightOver() then return end

	local mergeIndex = {}
	--合并击杀数据, 连杀时不单独显示单杀
	local killer_gid = nil
	for i=#self.tipsData, 1, -1 do
		local data = self.tipsData[i]
		if data.killer_gid == nil then
			killer_gid = nil
		elseif data.killer_gid == killer_gid then
			table.insert(mergeIndex, i)
		else
			killer_gid = data.killer_gid
		end
	end

	for i, removeIndex in ipairs(mergeIndex) do
		table.remove(self.tipsData, removeIndex)
	end

	for i, data in ipairs(self.tipsData) do
		GetMainUI():GetMobaFightTips():AddMsg( PublicFunc.GetMobaKillMsgData(data, true) )
	end

	self.tipsData = {}
end

function HurdleMobaFightManager:GetKill_N_Cnt(n)
	local result = 0
	local heroList = self.heroInfo[EFightInfoFlag.flag_a]
	if heroList then
		for i, heroInfo in pairs(heroList) do
			for kill_num, data in pairs(heroInfo.killContinue) do
				if kill_num == n then
					result = result + data.count
				end
			end
		end
	end
	return result
end

function HurdleMobaFightManager:IsNoEliteKilled(camp)
	local enemyCamp = nil
	if camp == EFightInfoFlag.flag_a then
		enemyCamp = EFightInfoFlag.flag_b
	elseif camp == EFightInfoFlag.flag_b then
		enemyCamp = EFightInfoFlag.flag_a
	end

	if enemyCamp then
		return self:GetKillEliteTowerCnt(enemyCamp) == 0
	else
		return false
	end
end

function HurdleMobaFightManager:GetKillEliteTowerCnt(camp)
	local result = 0
	local heroList = self.heroInfo[camp]
	if heroList then
		for i, heroInfo in pairs(heroList) do
			for j, tower in pairs(heroInfo.killTower) do
				if tower.type == 1 then
					result = result + 1
				end
			end
		end
	end
	return result
end

function HurdleMobaFightManager:GetKillGuardTowerCnt(camp)
	local result = 0
	local heroList = self.heroInfo[camp]
	if heroList then
		for i, heroInfo in pairs(heroList) do
			for j, tower in pairs(heroInfo.killTower) do
				if tower.type == 2 then
					result = result + 1
				end
			end
		end
	end
	return result
end

function HurdleMobaFightManager:GetEliteTowerDeadCnt(camp)
	local result = 0
	local towerList = self.towerInfo[camp]
	if towerList then
		for i, towerInfo in pairs(towerList) do
			if towerInfo.type == 1 and towerInfo.dead then
				result = result + 1
			end
		end
	end
	return result
end

function HurdleMobaFightManager:GetGuardTowerDeadCnt(camp)
	local result = 0
	local towerList = self.towerInfo[camp]
	if towerList then
		for i, towerInfo in pairs(towerList) do
			if towerInfo.type == 2 and towerInfo.dead then
				result = result + 1
			end
		end
	end
	return result
end

function HurdleMobaFightManager:IsKillEliteTowerInTime(time)
	local heroList = self.heroInfo[EFightInfoFlag.flag_a]
	if heroList then
		for i, heroInfo in pairs(heroList) do
			for j, tower in pairs(heroInfo.killTower) do
				if tower.type == 1 then
					if tower.time - self.fightBeginTime <= time then
						return true
					end
				end
			end
		end
	end
	return false
end

function HurdleMobaFightManager:IsKillEnemyHero(count, byMyself)
	byMyself = Utility.get_value(byMyself, true)
	if byMyself then
		return self.myKillHeroCnt >= math.max(count, 1)
	else
		local totalCount = 0
		local heroList = self.heroInfo[EFightInfoFlag.flag_a]
		if heroList then
			for i, heroInfo in pairs(heroList) do
				totalCount = totalCount + #heroInfo.killHero
			end
		end
		return totalCount >= math.max(count, 1)
	end
end

function HurdleMobaFightManager:IsEnemyTeamDead(count)
	local teamDeadCnt = self.teamInfo[EFightInfoFlag.flag_b].teamDeadCnt
	return teamDeadCnt >= math.max(count, 1)
end

function HurdleMobaFightManager:GetUIAssetFileList(out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetMinimapRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetThreeToThreeRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetMobaFightTipsRes(), out_file_list)
end

function HurdleMobaFightManager:OnUiInitFinish()
	FightManager.OnUiInitFinish(self)

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
	GetMainUI():InitThreeToThree()
	GetMainUI():InitMobaFightTips()
	GetMainUI():TeamHeroAutoReborn()
	GetMainUI():InitCaptainRebornTip()


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

function HurdleMobaFightManager:CreateTowerAreaEffect()
	local monsterList = g_dataCenter.fight_info:GetMonsterList(EFightInfoFlag.flag_b)
	if monsterList then
		for k, v in pairs(monsterList) do
			local monster = ObjectManager.GetObjectByName(k)
			if monster and monster:IsTower() then
				monster:InitTowerAreaEffect()
			end
		end
	end
end

function HurdleMobaFightManager:ReliveTimerStart()
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
				if obj and obj._heroIndex then
					obj:SetRebornTime(self.reBornTime)
				end
			end
		end

		local monsterList = g_dataCenter.fight_info:GetMonsterList(EFightInfoFlag.flag_b)
		if monsterList then
			for k,v in pairs(monsterList) do
				local obj = ObjectManager.GetObjectByName(v)
				if obj and obj._heroIndex then
					obj:SetRebornTime(self.reBornTime)
				end
			end
		end
	else
		self.reliveTimerId = nil
	end
end

function HurdleMobaFightManager:DeleteBufferItem(name)
	local entity = ObjectManager.GetObjectByName(name)
	--移除buff
	if entity and GetMainUI():GetMinimap() then
		GetMainUI():GetMinimap():DeletePeople(entity)
	end
end

function HurdleMobaFightManager:CreateBufferItem(entity)
	GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EAddHPBuff)
end

function HurdleMobaFightManager:EntityUseSkill(entity, skillId, targetGID)
    if entity:IsTower() then
        local target = ObjectManager.GetObjectByGID(targetGID)
        if target then
            entity:ShowTowerLockTarget(target, true)
        else
            --app.log("防御塔没有找到target: "..tostring(targetGID))
        end
    end
end

function HurdleMobaFightManager:SaveHeroSoulProperty(entity)
    local campFlag = entity:GetCampFlag()
	
    if not self.teamSoulDataList[campFlag] then
        self.teamSoulDataList[campFlag] = {soulValue=0, entity_group={}}
    end
    self.teamSoulDataList[campFlag].entity_group[entity:GetName()] = entity:GetName()
end

function HurdleMobaFightManager:AddTeamHeroSoulProperty(campFlag, value, target)
    local teamSoulData = self.teamSoulDataList[campFlag]
    if teamSoulData then
    	local old = teamSoulData.soulValue
        teamSoulData.soulValue = math.min(teamSoulData.soulValue + value, self.maxVal)
        if old ~= teamSoulData.soulValue then
        	local config = ConfigManager.Get(EConfigIndex.t_soul_value_property, teamSoulData.soulValue)
	        for name, data in pairs(teamSoulData.entity_group)  do
	            local obj = ObjectManager.GetObjectByName(name)
	            if obj then
	                for k, v in pairs(ENUM.EHeroAttribute) do
	                	if config[k] and config[k] ~= 0 then
	                		obj:SetPlayMethodAbilityScaleMultiply(k, 1+config[k])
	                	end
	                end
	            end
	        end
        end
        

		-- 表现魂值获取效果
        if GetMainUI() and GetMainUI():GetThreeToThree() then
			OGM.GetGameObject("assetbundles/prefabs/fx/prefab/fx_ui/fx_hunzhi.assetbundle", function(gObject)
				local go = gObject:GetGameObject()
				local obj_Id = gObject:GetId()
				if not target.object then
					OGM.UnUse(obj_Id)
					return
				end

                go:set_active(true)

				local x, y, z = target.object:get_position()
				local fight_camera = CameraManager.GetSceneCamera();
				local ui_camera = Root.get_ui_camera();
				local view_x, view_y, view_z = fight_camera:world_to_screen_point(x, y, z);
				view_z = 0;
				local ui_x, ui_y, ui_z = ui_camera:screen_to_world_point(view_x, view_y, view_z);
				go:set_position(ui_x, ui_y, ui_z)
				local fm_x,fm_y,fm_z = go:get_local_position()
				local t_x,t_y,t_z = GetMainUI():GetThreeToThree():GetProbarPos(campFlag)
				local tween = ngui.find_tween_position(go, go:get_name())
				tween:set_bezier(true,fm_x-math.random(30,100),fm_y+math.random(30,100),0,t_x+math.random(30,100),t_y-math.random(30,100),0)
				tween:set_from_postion(fm_x,fm_y,fm_z)
				tween:set_to_postion(t_x,t_y,t_z)
				tween:reset_to_begining()
				tween:play_foward()
				tween:clear_on_finished()
				
				tween:set_on_finished(Utility.create_callback( function()
					OGM.UnUse(obj_Id)
					if GetMainUI() and GetMainUI():GetThreeToThree() then
						local getSoul = self.teamSoulDataList[EFightInfoFlag.flag_a].soulValue
						local loseSoul = self.teamSoulDataList[EFightInfoFlag.flag_b].soulValue
						GetMainUI():GetThreeToThree():UpdateSoulData(getSoul, loseSoul)
					end
				end ))
			end)
		end
    end
end
