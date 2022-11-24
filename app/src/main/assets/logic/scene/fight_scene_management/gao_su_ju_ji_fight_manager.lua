-- GaoSuJuJiFightManager = Class("GaoSuJuJiFightManager", FightManager)

-- function GaoSuJuJiFightManager:InitData()
-- 	FightManager.InitData(self)
-- 	--<region: member field >
-- 	self.teamInfo = {}
-- 	self.heroIndex = 1;
-- 	self.curHeroNum = 0;
-- 	self.bigWave = 0;
-- 	self.smallWave = 0;
-- 	self.boss_entity_name = nil;
-- 	self.deadNum = 0;
-- 	self.waitNum = 0;
-- 	-- self.dataCenter = nil;
-- 	--</region:member field>
-- end

-- function GaoSuJuJiFightManager.InitInstance()
-- 	GaoSuJuJiFightManager._super.InitInstance(GaoSuJuJiFightManager)
-- 	return GaoSuJuJiFightManager;
-- end


-- function GaoSuJuJiFightManager:ClearUpInstance()
-- 	FightManager.ClearUpInstance(self)
-- 	GaoSuJuJiFightUI.Destroy()
-- 	---
-- end

-- function GaoSuJuJiFightManager:Start()
-- 	self:_OnStart()
--     self.followHeroUsedAI = self:GetFightScript().hero_id

-- 	FightManager.Start(self)
-- end

-- function GaoSuJuJiFightManager:GetNPCAssetFileList(out_file_list)
-- 	FightManager.GetNPCAssetFileList(self, out_file_list)

-- 	if lua_assert(self.fightScript.name == "GaoSuJuJi", "GaoSuJuJi bad script name.") then
-- 		return
-- 	end

-- 	----------------load item.
-- end

-- function GaoSuJuJiFightManager:GetUIAssetFileList(out_file_list)
-- 	FightManager.GetUIAssetFileList(self, out_file_list)

-- 	FightManager.AddPreLoadRes(MMOMainUI.GetTaskRes(), out_file_list)
-- end

-- function GaoSuJuJiFightManager:Update()
-- 	FightManager.Update(self)
-- end

-- function GaoSuJuJiFightManager:LoadHero()
-- 	local env = FightScene.GetStartUpEnv()

-- 	for camp_flag, team in pairs(env.fightTeamInfo) do
-- 		--TODO: (kevin) 用闭包迭代器。。。。
-- 		local heroBPList = {}
-- 		local heroBPPos_index = 1
-- 		LevelMapConfigHelper.GetHeroBornPosList(camp_flag, heroBPList)
-- 		if #heroBPList ~= 0 then
-- 			for player_id, player_info in pairs(team.players) do
-- 				-- for k, v in ipairs(player_info.hero_card_list) do
-- 				for k, v in ipairs(self.teamInfo) do
-- 					if v.index ~= nil and 0 ~= v.index then
-- 						if not v.isDead then
-- 							if self.heroIndex > 3 then break end
-- 							self.heroIndex = self.heroIndex + 1;
-- 							self.curHeroNum = self.curHeroNum + 1;
-- 							self:LoadSingleHero(camp_flag, player_id, player_info.package_source, v.index, heroBPList[heroBPPos_index])
-- 							heroBPPos_index = Utility.getNextIndexLoop(heroBPPos_index, 1, #heroBPList, true)
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return true;
-- end

-- function GaoSuJuJiFightManager:LoadUI()
-- 	FightManager.LoadUI(self)

-- 	--TODO: @haofang 显示关卡内UI
-- 	-- GaoSuJuJiFightUI.Start();
-- end
-- ------------------------------------------------------------------------------
-- function GaoSuJuJiFightManager:OnEvent_TimeOut()
-- 	FightManager.OnEvent_TimeOut(self)

-- 	--------------------
-- end

-- function GaoSuJuJiFightManager:OnLoadMonster(entity)
-- 	if not entity:IsEnemy() then
--         self.diaoxiangEntityName = entity:GetName()
-- 		self.boss_entity_name = entity:GetName();
-- 		if self.dataCenter.bigWave ~= 0 and self.dataCenter:GetBossHP() ~= 0 then
-- 			entity:SetProperty('cur_hp',self.dataCenter:GetBossHP());
-- 		end
-- 	end
-- end

-- function GaoSuJuJiFightManager:OnLoadHero(entity)
-- 	FightManager.OnLoadHero(self, entity)
-- 	local index = entity.card.index
-- 	local hp = self.dataCenter:GetHeroHp(index);
-- 	if hp and hp > 0 then
-- 		entity:SetProperty('cur_hp',hp)
-- 	end
-- 	entity:SetDontReborn(true);
-- 	entity:SetAiEnable(true);
-- 	self.dataCenter:SetHero(index,entity:GetHP(),false);
-- 	self:UpdateHero();
-- end

-- function GaoSuJuJiFightManager:OnEvent_ObjDead(killer, target)
-- 	FightManager.OnEvent_ObjDead(self, killer, target)
-- 	if target:IsMyControl() and target:IsHero() then
-- 		local cardHuman = self.teamInfo[self.heroIndex];
-- 		local dead_hero_id = nil;
-- 		if target.card then
-- 			dead_hero_id = target.card.index;
-- 			self.curHeroNum = self.curHeroNum - 1;
-- 		else
-- 			app.log_warning("死亡对象(scene_entity)没有找到card属性");
-- 		end
-- 		for k,v in pairs(self.teamInfo) do
-- 			if v.index == dead_hero_id then
-- 				self.teamInfo[k].isDead = true;
-- 				self.teamInfo[k].hp = 0;
-- 			end
-- 		end
-- 		if cardHuman and not cardHuman.isDead then
-- 			local camp_flag = target:GetCampFlag();
-- 			local player_id = g_dataCenter.player:GetGID();
-- 			local point = target:GetPosition();
-- 			local pos_inf = {};
-- 			local package = g_dataCenter.package
-- 			pos_inf.px = point.x;
-- 			pos_inf.py = point.y;
-- 			pos_inf.pz = point.z;
-- 			self.heroIndex = self.heroIndex + 1;
-- 			self.curHeroNum = self.curHeroNum + 1;
-- 			timer.create("delay",1,1);
-- 			function delay()
-- 				FightScene.DeleteObj(target:GetName(),-1);
-- 				self:LoadSingleHero(camp_flag, player_id, package, cardHuman.index, pos_inf)
-- 				g_dataCenter.player:ChangeCaptain(g_dataCenter.fight_info:GetCaptainIndex());
-- 			end
-- 		else
-- 			timer.create("delay",1,1);
-- 			function delay()
-- 				FightScene.DeleteObj(target:GetName(),-1);
-- 				g_dataCenter.player:ChangeCaptain(g_dataCenter.fight_info:GetAliveCaptaion());
-- 			end
-- 		end
-- 	end
-- 	self:UpdateHero();
-- end

-- function GaoSuJuJiFightManager:OnBeginWave(cur_wave,max_wave)
-- 	self.smallWave = cur_wave;
-- 	self.dataCenter:UpdateWave(self.bigWave,self.smallWave);
-- 	if GetMainUI() and GetMainUI():GetTask() then
-- 		GetMainUI():GetTask():SetData({strWave = "第"..tostring(self.bigWave).." - "..tostring(self.smallWave).."波"})
-- 	end
-- end

-- function GaoSuJuJiFightManager:OnBeginGroud(cur_groud,max_groud)
-- 	if self.bigWave ~= cur_groud then
-- 		self.smallWave = 1;
-- 	end
-- 	self.bigWave = cur_groud;
-- 	self.dataCenter:UpdateWave(self.bigWave,self.smallWave);
-- 	if GetMainUI() and GetMainUI():GetTask() then
-- 		GetMainUI():GetTask():SetData({strWave = "第"..tostring(self.bigWave).." - "..tostring(self.smallWave).."波"})
-- 	end
-- end

-- function GaoSuJuJiFightManager:OnKillGroud(cur_groud,cur_wave,max_groud)
-- 	self.dataCenter.bigWave = self.dataCenter.bigWave + 1;
-- 	local fight_mgr = FightScene.GetFightManager();
-- 	local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
-- 	for k,v in pairs(hero_list) do
-- 		local se = ObjectManager.GetObjectByName(v);
-- 		self.dataCenter:SetHero(se.card.index,se:GetHP(),false);
-- 	end
-- 	local boss = ObjectManager.GetObjectByName(self.boss_entity_name);
-- 	self.dataCenter:SetBossHP(boss:GetHP());
-- 	self.dataCenter.fightResult = 2;
-- 	self:EndGroud(cur_groud,cur_wave,max_groud)
-- end

-- function GaoSuJuJiFightManager:EndGroud(cur_groud,cur_wave,max_groud)
--     local gaoSuJujiData = g_dataCenter.activity[FightScene.GetPlayMethodType()];
--     gaoSuJujiData:EndGroud(cur_groud,cur_wave,max_groud);
--     if cur_groud >= max_groud then
-- 		self.dataCenter.fightResult = 0;
--     end
--     msg_activity.cg_save_gaosujuji_struct(FightScene.GetPlayMethodType(),gaoSuJujiData:GetActivityStruct());
-- end

-- function GaoSuJuJiFightManager:OnShowFightResultUI()
-- 	local _PlayMethod = FightScene.GetStartUpEnv():GetPlayMethod();
-- 	local star = FightRecord.GetStar();
-- 	if self.dataCenter then
-- 		if star > 0 then
-- 			self.dataCenter.fightResult = 0;
-- 		else
-- 			self.dataCenter.fightResult = 1;
-- 		end
-- 		self.dataCenter:EndGame();
-- 	end
-- end

-- -----------------------------------------------------------------------------
-- function GaoSuJuJiFightManager:_OnStart( )
-- 	local env = FightScene.GetStartUpEnv();
-- 	self.teamInfo = env.ext_parm.team
-- 	self.monsterLoader.waveGroudIndex = env.ext_parm.wave_id+1;
-- 	self:UpdateHero();
-- end

-- function GaoSuJuJiFightManager:UpdateHero()
-- 	local deadNum = 0;
-- 	for k,v in pairs(self.teamInfo) do
-- 		if v.isDead == true then
-- 			deadNum = deadNum + 1;
-- 		end
-- 	end
-- 	local waitNum = #self.teamInfo-self.curHeroNum-deadNum;
-- 	self.deadNum = deadNum;
-- 	self.waitNum = waitNum;
-- 	if GetMainUI() and GetMainUI():GetTask() then
-- 		GetMainUI():GetTask():SetData(
-- 		{
-- 		content5 = {txt="阵亡", lab=tostring(deadNum)},
-- 		content6 = {txt="替补", lab=tostring(waitNum)},
-- 		});
-- 	end
-- end
-- function GaoSuJuJiFightManager:OnUiInitFinish()
--     FightManager.OnUiInitFinish(self);
--     local data = 
--     {
--     	strWave = "第"..tostring(self.bigWave).." - "..tostring(self.smallWave).."波",
--     	content5 = {lab=tostring(self.deadNum)},
-- 		content6 = {lab=tostring(self.waitNum)},
-- 	}
--     GetMainUI():InitTask(data);
--     GaoSuJuJiFightUI.Start();
--     -- if self.diaoxiangEntityName then
--     --     GetMainUI():InitBosshp(1, self.diaoxiangEntityName, true);
--     -- end
-- end