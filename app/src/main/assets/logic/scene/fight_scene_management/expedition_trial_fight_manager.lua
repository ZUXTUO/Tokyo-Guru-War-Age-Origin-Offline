TrialFightManager = Class('TrialFightManager',EmbattleFightManager);

ETrialBuffIds =
{
    EKnown = 1230,
    EUnknown = 1231,
    EInternal = 1232,
}

local fight_ai_id = 151

function TrialFightManager:InitData()
	FightManager.InitData(self)
    
    self.heroList = {}  -- UI界面统计血量用,使用gid做key值
	self.followHeroUsedAI = fight_ai_id
end

function TrialFightManager.InitInstance()
	FightManager.InitInstance(TrialFightManager)
	return TrialFightManager
end

function TrialFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function TrialFightManager:LoadUI()
	FightManager.LoadUI(self)
end

function TrialFightManager:OnStart()
    self.canRecoverInFight = true
	FightManager.OnStart(self)
end

function TrialFightManager:GetMainHeroAutoFightAI()
	return fight_ai_id
end

-- function TrialFightManager:LoadHero()
--     return true
-- end

--[[function PvPCommonFightManager:LoadMonster()
    return true
end]]

function TrialFightManager:LoadHero()
	self.trialHeroNameList = {};
	g_dataCenter.trial.hpData = {};
	EmbattleFightManager.LoadHero(self);
	
	local card1 = g_dataCenter.trial.battleRoleE1;
	local card2 = g_dataCenter.trial.battleRoleE2;
	local card3 = g_dataCenter.trial.battleRoleE3;
	local player = Player:new();
    local package = Package:new();
	local allTrialCards = {card1,card2,card3};
	local heroBPList = {}
    local heroBPPos_index = 1
    LevelMapConfigHelper.GetHeroBornPosList(g_dataCenter.fight_info.single_enemy_flag, heroBPList)
	--app.log("BPList:"..tostring(heroBPList));
	self.haveTouxiHero = false;
	self.touxiHeroCard = nil;
	for i = 1,3 do 
		if allTrialCards[i] ~= nil then
			local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
			local enemyTeam = g_dataCenter.trial:get_enemyTeam() 
			local hp;
			if allTrialCards[i].number == enemyTeam[1].number then 
				hp = challengeInfo.hero1_hp;
			elseif allTrialCards[i].number == enemyTeam[2].number then 
				hp = challengeInfo.hero2_hp;
			elseif allTrialCards[i].number == enemyTeam[3].number then 
				hp = challengeInfo.hero3_hp;
			end 
			--local hp = levelData[allTrialCards[i].number];
			if hp == nil or hp ~= -1 then 
				local heroBPPos_index = allTrialCards[i].trialPos;
				--app.log("heorBPPos_index:"..tostring(heroBPPos_index));
				local function loadSingleTrialHero(isTouxiHero)
					local hero = FightScene.CreateTrialHeroAsync(
						g_dataCenter.player:GetGID()+1, 
						allTrialCards[i], 
						g_dataCenter.fight_info.single_enemy_flag, 
						math.random(11111111111,99999999999)
						)
					hero:SetPosition(heroBPList[heroBPPos_index].px, heroBPList[heroBPPos_index].py, heroBPList[heroBPPos_index].pz)
					hero:SetBornPoint(heroBPList[heroBPPos_index].px, heroBPList[heroBPPos_index].py, heroBPList[heroBPPos_index].pz)
					hero:SetRotation(heroBPList[heroBPPos_index].rx, heroBPList[heroBPPos_index].ry, heroBPList[heroBPPos_index].rz)
					PublicFunc.UnifiedScale(hero)
					table.insert(self.trialHeroNameList,hero.name);
					self:OnLoadHero(hero);
					if isTouxiHero then 
						self.haveTouxiHero = false;
					end
				end 
				if heroBPPos_index == 0 then 
					self.haveTouxiHero = true;
					self.touxiHeroCard = allTrialCards[i];
					g_dataCenter.fight_info:AddDelayLoadHero(g_dataCenter.fight_info.single_enemy_flag, allTrialCards[i])
					timer.create(
						Utility.create_obj_callback(
							self,
							loadSingleTrialHero,
							1,true),
						3000,
						1
						);
				else 
					loadSingleTrialHero();
				end 
			end 
		end 
	end 
end 

function TrialFightManager:LoadSingleHero(camp_flag, player_id, package_source, cardHuman_id, pos_inf)

    if pos_inf == nil then
        app.log('xxx  ' .. debug.traceback())
    end

	if cardHuman_id ~= nil and 0 ~= cardHuman_id then
		-- local cardHuman = v.package_source:find_card(1, v)
		--TODO: (kevin) 背包。。。。。
		local hero_id = 0
		local hero_level = 1

		local cardHuman = package_source:find_card(ENUM.EPackageType.Hero, cardHuman_id)
		if lua_assert(cardHuman ~= nil, "TrialFightManager:_LoadHero nil hero.") then
			return false
		end
		if cardHuman == nil then return end;
		hero_id = cardHuman.number
		hero_level = cardHuman.level
		--hero是sceneEntity的一个对象
		local hero = FightScene.CreateHeroAsync(player_id, hero_id, camp_flag, 0, hero_level, cardHuman_id, package_source,nil,MsgEnum.eactivity_time.eActivityTime_trial)
	    hero:SetPosition(pos_inf.px, pos_inf.py, pos_inf.pz)
		hero:SetBornPoint(pos_inf.px, pos_inf.py, pos_inf.pz)
		hero:SetRotation(pos_inf.rx, pos_inf.ry, pos_inf.rz)
		PublicFunc.UnifiedScale(hero)
		table.insert(self.trialHeroNameList,hero.name);
		self:OnLoadHero(hero);
		if self.heroTimerId then
			if FightManager.GetMyCaptain() == nil then
				g_dataCenter.player:ChangeCaptain(1)
			end
		end	
		g_dataCenter.fight_info:DelDelayLoadHero(camp_flag, cardHuman_id)
	end
end

function TrialFightManager:OnLoadHero(entity)
	if entity.card.index == 0 then 	
		local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
		local enemyTeam = g_dataCenter.trial:get_enemyTeam() 
		local hp;
		if entity.card.number == enemyTeam[1].number then 
			hp = challengeInfo.hero1_hp;
		elseif entity.card.number == enemyTeam[2].number then 
			hp = challengeInfo.hero2_hp;
		elseif entity.card.number == enemyTeam[3].number then 
			hp = challengeInfo.hero3_hp;
		end 
		if hp ~= nil and hp ~= 0 and hp ~= -1 then 
			entity:SetHP(hp);
		end
	else 
		local hp = entity.card:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial);
		if hp ~= nil then 	
			local maxHp = entity.card:GetPropertyVal("max_hp")
			local curMaxHp = entity:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
			if curMaxHp/maxHp > 1.001 then 
				hp = hp * curMaxHp/maxHp;
			end
			entity:SetHP(hp);	
		end 
	end
	FightManager.OnLoadHero(self,entity);

	entity:SetConfig("view_radius", 1000);
	entity:SetConfig("act_radius", 2000);

	if entity:GetCampFlag() ~= g_dataCenter.fight_info.single_friend_flag then
		entity:SetAI(fight_ai_id)
	end
end 

function TrialFightManager:SetHeroTeamAI()
    if g_dataCenter.fight_info:GetControlHero(1) == nil then
        return
    end

    g_dataCenter.player:ChangeCaptain(1, nil, nil, true)

    local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
    for k, v in pairs(hero_list) do
        local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
        if teamIndex ~= 1 then
            local obj = ObjectManager.GetObjectByName(v)
            obj:SetAiEnable(true)
        end
    end
end

function TrialFightManager:OnLoadItem(entity)

    local spName = {
        [ETrialBuffIds.EKnown] = 'zd_buff_zengyi', 
        [ETrialBuffIds.EUnknown] = 'zd_buff_weizhi'}

    local configId = entity:GetConfig('config_id')
    local item_data = ConfigManager.Get(EConfigIndex.t_world_item, configId)
    if item_data then
        local param = {spriteName = spName[item_data.buff_id]}
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EBuff, nil , param)
    end

end

-- 预加载战斗UI的玩家英雄头像texture
function TrialFightManager:GetPreLoadTextureFileList(out_file_list)
    FightManager.GetPreLoadTextureFileList(self, out_file_list)

--     for i, v in ipairs(g_dataCenter.Trial.showFighter) do
--         local config = ConfigHelper.GetRole(v.hero_id)
--         if config and config.small_icon then
--             out_file_list[config.small_icon] = config.small_icon;
--         end
--     end
end

function TrialFightManager:GetHeroAssetFileList(out_file_list)
    for i = 1,3 do
		if g_dataCenter.trial["battleRoleE"..tostring(i)] then ObjectManager.GetHeroPreloadList(g_dataCenter.trial["battleRoleE"..tostring(i)].number, out_file_list) end 
		if g_dataCenter.trial["battleRoleM"..tostring(i)] then ObjectManager.GetHeroPreloadList(g_dataCenter.trial["battleRoleM"..tostring(i)].number, out_file_list) end 
        --ObjectManager.GetHeroPreloadList(v.hero_id, out_file_list)
    end
    out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function TrialFightManager:GetNPCAssetFileList(out_file_list)
end

function TrialFightManager:GetUIAssetFileList(out_file_list)
    FightManager.GetUIAssetFileList(self, out_file_list)
    -- -- 加载倒计时UI资源
    -- local file1 = "assetbundles/prefabs/ui/fight/new_fight_ui_timer.assetbundle";
    -- local file2 = "assetbundles/prefabs/ui/fight/new_fight_ui_count_down.assetbundle";
    -- out_file_list[file1] = file1;
    -- out_file_list[file2] = file2;
    -- 大乱斗UI
    -- GetMainUI():InitTrial();
    FightManager.AddPreLoadRes(MMOMainUI.GetTimerRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetWorldChatRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetDescriptionRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetOptionTipRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetJoystickRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetSkillInputRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetFuzionRes(), out_file_list);
    FightManager.AddPreLoadRes(NewFightUiCount.GetResList(), out_file_list);
    FightManager.AddPreLoadRes(ApertureManager.GetResList(), out_file_list);
end

--[[-- 重写战斗结束逻辑
function TrialFightManager:FightOver(is_forced_exit)
    --FightScene.StopAIAgentKeepAlive()
    -- nmsg_world_boss.cg_leave_world_boss(Socket.socketServer)
    --FightManager.FightOver(self, is_forced_exit)
    FightManager.FightOver(self, is_forced_exit)
end--]]

function TrialFightManager:FightOver(is_set_exit, is_forced_exit)
	if not is_set_exit then 
		local hpData = {};
		for i = 1,#self.trialHeroNameList do 
			local se = ObjectManager.GetObjectByName(self.trialHeroNameList[i]);
			local isTimeUp = (self:GetFightRemainTime() == 0);

			if se.card.index == 0 then 
				local hp = se:GetHP();
				if isTimeUp == false then 
					hpData[se.card.number] = hp
				else
					local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
					local enemyTeam = g_dataCenter.trial:get_enemyTeam()
					if se.card.number == enemyTeam[1].number then 
						hp = challengeInfo.hero1_hp;
					elseif se.card.number == enemyTeam[2].number then 
						hp = challengeInfo.hero2_hp;
					elseif se.card.number == enemyTeam[3].number then 
						hp = challengeInfo.hero3_hp;
					end 
					if hp ~= nil and hp ~= 0 then 
						hpData[se.card.number] = hp;
					else 
						hpData[se.card.number] = se:GetMaxHP();
					end
				end 
			else 
				local hp = se:GetHP();
				local maxHp = se.card:GetPropertyVal("max_hp")
				local curMaxHp = se:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
				if curMaxHp/maxHp > 1.001 then 
					hp = hp / curMaxHp * maxHp;
				end
				hpData[se.card.index] = hp
				local card = g_dataCenter.package:find_card(1,se.card.index)
				card:SetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial,hp);
				card.expedition_trial_hp = hpData[se.card.index];
			end 
		end
		g_dataCenter.trial:saveHeroHp(hpData);
	end 
	if is_set_exit then 
		local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
		if challengeInfo.hero1_hp == 0 and challengeInfo.hero1_hp == 0 and challengeInfo.hero1_hp == 0 then 
			local hpData = {};
			for i = 1,#self.trialHeroNameList do 
				local se = ObjectManager.GetObjectByName(self.trialHeroNameList[i]);
				if se.card.index == 0 then 
					local hp = se:GetMaxHP();
					hpData[se.card.number] = hp
				end 
			end 
			local enemyTeam = g_dataCenter.trial:get_enemyTeam();
			local info = {
				pass_stars = 0;
				enemy_hero1_hp = hpData[enemyTeam[1].number];
				enemy_hero2_hp = hpData[enemyTeam[2].number];
				enemy_hero3_hp = hpData[enemyTeam[3].number];
				is_force_exit = 1;
				use_time = self:GetFightRemainTime();
				is_auto_fight = g_dataCenter.trial:GetIsAutoFight();
			}
			--app.log("Send Fight Battle Result Info : "..table.tostring(info));
			msg_expedition_trial.cg_expedition_trial_challenge_result(info)
		end
	end 
	FightManager.FightOver(self,is_set_exit,is_forced_exit)
end 

function TrialFightManager:OnFightOver()
	if self.haveTouxiHero == true then 
		if self.touxiHeroCard ~= nil then 
			local hp = self.touxiHeroCard:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial);
			if hp == nil then
				hp = -1;
			end
			hpData[self.touxiHeroCard.index] = hp;
		end 
	end
    FightManager.OnFightOver(self);
end

function TrialFightManager:LoadSceneObject()
    FightManager.LoadSceneObject(self)
end

function TrialFightManager:OnLoadMonster(entity)
    local name = entity.card.name;
    entity.ui_hp:SetName(true, string.format("[FF0000]%s[-]", name));
    -- if FightUI.GetMinimap() then
    --     FightUI.GetMinimap():AddPeople(entity);
    -- end
end

function TrialFightManager:OnUiInitFinish()
    --FightManager.OnUiInitFinish(self);
    local camera = asset_game_object.find("fightCamera")
	AudioManager.SetAudioListenerFollowObj(true, camera)
	local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	local str = hurdle.tips_string;
	local time = hurdle.tips_last;

    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0
    local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsShowStarTip = (cf.is_show_star_tip == 1)
    GetMainUI():InitWorldChat()
    GetMainUI():InitZouMaDeng()
	GetMainUI():InitTeamCanChange(true, false, true)
    GetMainUI():InitTimer()
    --GetMainUI():InitDescription(str, time)
    local configIsAuto = g_dataCenter.player:GetVipData().expedition_trial_can_auto_fight;
	if configIsAuto and configIsAuto == 1 then
		configIsAuto = true;
	else
		configIsAuto = false;
	end
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)

    GetMainUI():InitMMOFightUIClick();
	
    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget)

	self:CallFightStart()
end