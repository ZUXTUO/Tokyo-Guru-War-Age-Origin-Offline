HurdleFuzionTenFightManager = Class("HurdleFuzionTenFightManager", FightManager);

local relive_time = 5;

function HurdleFuzionTenFightManager.InitInstance()
	FightManager.InitInstance(HurdleFuzionTenFightManager)
	return HurdleFuzionTenFightManager;
end

function HurdleFuzionTenFightManager:InitData()
	FightManager.InitData(self);
	self.exclude_pos = {};
	self.heroSeqIndex = {};
	self.timeid = {};
	self.killNum = 0;
	self.usingName = {};
	self.loadMonsterList = {};
	self.loadHeroList = {};
	self.rank = 10;
	self.heroList = {};
end

function HurdleFuzionTenFightManager:RegistFunc()
	FightManager.RegistFunc(self)
	self.bindfunc['DeleteBufferItem'] = Utility.bind_callback(self, self.DeleteBufferItem);
	self.bindfunc['CreateBufferItem'] = Utility.bind_callback(self, self.CreateBufferItem);

	NoticeManager.BeginListen(ENUM.NoticeType.DeleteBufferItem, self.bindfunc['DeleteBufferItem'])
	NoticeManager.BeginListen(ENUM.NoticeType.CreateBufferItem, self.bindfunc['CreateBufferItem'])
end

function HurdleFuzionTenFightManager:UnRegistFunc()
	NoticeManager.EndListen(ENUM.NoticeType.DeleteBufferItem, self.bindfunc['DeleteBufferItem'])
	NoticeManager.EndListen(ENUM.NoticeType.CreateBufferItem, self.bindfunc['CreateBufferItem'])
	FightManager.UnRegistFunc(self)
end

function HurdleFuzionTenFightManager:FightOver(is_set_exit, is_forced_exit)
	NewFightUiCount.Destroy();
	FightManager.FightOver(self,is_set_exit, is_forced_exit);
end

function HurdleFuzionTenFightManager:GetNPCAssetFileList(out_file_list)
	local monster_id_list = {}
	local fuzionHurdle = ConfigManager.Get(EConfigIndex.t_hurdle_fuzion,FightScene.GetCurHurdleID());
    if fuzionHurdle == nil then
        return
    end

    for k,list in pairs(fuzionHurdle) do
    	monster_id_list[list.hero1] = 1;
    	monster_id_list[list.hero2] = 1;
    	monster_id_list[list.hero3] = 1;
    end

	for k, v in pairs(monster_id_list) do
		local filePath = ObjectManager.GetMonsterModelFile(k)
		out_file_list[filePath] = filePath
	end
end

function HurdleFuzionTenFightManager:LoadHero()
	local env = FightScene.GetStartUpEnv()

	for camp_flag, team in pairs(env.fightTeamInfo) do
		for player_id, player_info in pairs(team.players) do
			local list = player_info.hero_card_list;
			local pos = self:_GetPos(self.exclude_pos);
			local entity = self:LoadSingleHero(1, player_id, player_info.package_source, list[1], pos);
			self.exclude_pos[pos.obj_name] = pos;
			self.heroSeqIndex[1] =
			{
				dead=0,
				HeroList={},
				surviveTime=0,
				name=player_info.obj:GetName(),
				playerid=player_info.obj:GetGID(),
				kill = 0,
				herogid = 1;
			};
			for i=1,3 do
				local v = list[i];
				if v ~= 0 then
					table.insert(self.heroSeqIndex[1].HeroList,v);
				end
			end
			entity.ui_hp:SetName(true, player_info.obj:GetName());
			table.insert(self.heroList,entity);
			self.usingName[player_info.obj:GetName()] = 1;
		end
	end
	return true;
end

function HurdleFuzionTenFightManager:OnLoadHero(entity)
	FightManager.OnLoadHero(self, entity)
	entity:SetDontReborn(true);
	if GetMainUI() and GetMainUI():GetMinimap() then
		GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
	else
		table.insert(self.loadHeroList, entity);
	end
end

function HurdleFuzionTenFightManager:OnLoadItem(entity)
    -- local spName = {
    --     [EFuzionBuffIds.EKnown] = 'zd_buff_zengyi',
    --     [EFuzionBuffIds.EUnknown] = 'zd_buff_weizhi'}

    -- local configId = entity:GetConfig('config_id')
    -- local item_data = ConfigManager.Get(EConfigIndex.t_world_item, configId)
    -- if item_data then
    --     local param = {spriteName = spName[item_data.buff_id]}
    --     GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EBuff, nil , param)
    -- end
end

function HurdleFuzionTenFightManager:DeleteBufferItem(name)
	local entity = ObjectManager.GetObjectByName(name)
	--移除buff
	if entity then
		GetMainUI():GetMinimap():DeletePeople(entity)
	end
end

function HurdleFuzionTenFightManager:CreateBufferItem(entity)
	local spName = {
        [EFuzionBuffIds.EKnown] = 'zd_buff_zengyi',
        [EFuzionBuffIds.EUnknown] = 'zd_buff_weizhi'}

    local item_data = ConfigManager.Get(EConfigIndex.t_world_item, entity:GetConfigId())
    if item_data then
        local param = {spriteName = spName[item_data.buff_id]}
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EBuff, nil , param)
    end
end

function HurdleFuzionTenFightManager:LoadMonster()
	local fuzionHurdle = ConfigManager.Get(EConfigIndex.t_hurdle_fuzion,FightScene.GetCurHurdleID());
    if fuzionHurdle == nil then
        return
    end

    local list_num = #fuzionHurdle;
    for k,list in pairs(fuzionHurdle) do
    	local pos = self:_GetPos(self.exclude_pos);
    	if pos then
    		local heroList = {};
    		for i=1,3 do
    			if list and list["hero"..i] ~= 0 then
    				table.insert(heroList,list["hero"..i]);
    			end
    		end
    		local newmonster = FightScene.CreateMonsterAsync(nil, list.hero1, k+1, nil, nil, pos.group_name)
    		if newmonster then
    			newmonster:SetPosition(pos.px,0,pos.pz)
    			newmonster:SetRotation(pos.rx,pos.ry,pos.rz)
    			PublicFunc.UnifiedScale(newmonster, pos.sx, pos.sy, pos.sz)
    			newmonster:SetInstanceName(pos.obj_name);
    			newmonster:SetHomePosition(newmonster:GetPosition(true, true))
    			self.exclude_pos[pos.obj_name] = pos;
    			local name = PublicFunc.GetRandomName(self.usingName);
    			self.usingName[name] = 1;
    			self.heroSeqIndex[k+1] =
    			{
	    			dead=0,
	    			surviveTime=0,
	    			HeroList=heroList,
	    			name=name,
	    			kill=0
	    		};
    			newmonster.ui_hp:SetName(true, name);
    		end
    		if GetMainUI() and GetMainUI():GetMinimap() then
    			GetMainUI():GetMinimap():AddPeople(newmonster, EMapEntityType.EGRedHero);
    		else
    			table.insert(self.loadMonsterList, newmonster);
    		end
    	end
    end
end

function HurdleFuzionTenFightManager:OnEvent_ObjDead(killer, target)
	GetMainUI():GetMinimap():DeletePeople(target);
	if killer and killer:IsMyControl() then
		self.killNum = self.killNum + 1;
	end
	if killer then
		local killer_camp = killer:GetCampFlag();
		self.heroSeqIndex[killer_camp].kill = self.heroSeqIndex[killer_camp].kill + 1
	end
	local target_camp = target:GetCampFlag();
	self.heroSeqIndex[target_camp].dead = self.heroSeqIndex[target_camp].dead + 1
	if target:IsHero() or target:IsMonster() then
		local camp = target_camp;
		if self.heroSeqIndex[camp].dead+1 > #self.heroSeqIndex[camp].HeroList then
			self.heroSeqIndex[camp].surviveTime = self:GetHurdleTime();
			self:_UpdateUI();
			return;
		end
		if camp == 1 then
			local player_id = g_dataCenter.player:GetGID();
			local pos = self:_GetPos();
			local env = FightScene.GetStartUpEnv()
			local team = env.fightTeamInfo[camp];
			local player_info = team.players[player_id];
			local list = self.heroSeqIndex[camp].HeroList;
			local index = list[self.heroSeqIndex[camp].dead+1];
			if index then
				local function delay()
					self.timeid[camp] = nil;
					FightScene.DeleteObj(target:GetName(),-1);
					local entity = self:LoadSingleHero(camp, player_id, player_info.package_source, index, pos)
					entity.ui_hp:SetName(true, self.heroSeqIndex[camp].name);
					g_dataCenter.player:ChangeCaptain(1);
					GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
					table.insert(self.heroList,entity);
				end
				NewFightUiCount.Start({need_pause=false});
				self.timeid[camp] = timer.create(Utility.create_callback(delay),relive_time*1000,1);
			else
				self.heroSeqIndex[camp].surviveTime = self:GetHurdleTime();
			end
		else
			local fuzionHurdle = ConfigManager.Get(EConfigIndex.t_hurdle_fuzion,FightScene.GetCurHurdleID());
			if fuzionHurdle == nil then
				return;
			end
			local list = self.heroSeqIndex[camp].HeroList;
			local seq_index = self.heroSeqIndex[camp].dead+1;
			local index = list[seq_index];
			if index ~= 0 then
				local function delay()
					self.timeid[camp] = nil;
					local pos = self:_GetPos();
					local newmonster = FightScene.CreateMonsterAsync(nil, index, camp, nil, nil, pos.group_name)
					if newmonster then
						newmonster:SetPosition(pos.px,0,pos.pz)
						newmonster:SetRotation(pos.rx,pos.ry,pos.rz)
						PublicFunc.UnifiedScale(newmonster, pos.sx, pos.sy, pos.sz)
						newmonster:SetInstanceName(pos.obj_name);
						newmonster:SetHomePosition(newmonster:GetPosition(true, true))
						newmonster.ui_hp:SetName(true, self.heroSeqIndex[camp].name);
						GetMainUI():GetMinimap():AddPeople(newmonster, EMapEntityType.EGRedHero);
					end
				end
				self.timeid[camp] = timer.create(Utility.create_callback(delay),relive_time*1000,1);
			else
				self.heroSeqIndex[camp].surviveTime = self:GetHurdleTime();
			end
		end
	end

	FightManager.OnEvent_ObjDead(self, killer, target)
	self:_UpdateUI();
end

function HurdleFuzionTenFightManager:_UpdateUI()
	GetMainUI():GetFightFuzionRank():SetKillNum(self.killNum);
	GetMainUI():GetFightFuzionRank():SetDeadNum(self.heroSeqIndex[1].dead);
	GetMainUI():GetTeamFuzion2():UpdateHeadData();
	local curPersonNum = 0;
	for k,v in pairs(self.heroSeqIndex) do
		if v.surviveTime == 0 then
			curPersonNum = curPersonNum + 1;
		end
	end
	GetMainUI():GetFightFuzionRank():SetSurviveNum(curPersonNum,#self.heroSeqIndex);

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

function HurdleFuzionTenFightManager:OnUiInitFinish()
	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsShowStarTip = (cf.is_show_star_tip == 1)
	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)
	GetMainUI():InitProgressBar()
	GetMainUI():InitTriggerOperator()
	GetMainUI():InitMMOFightUIClick();
    local pmi = FightScene.GetStartUpEnv():GetPlayMethod();
	local canReborn = true
	if pmi == nil and not FightScene.IsMobaHurdle() then
		canReborn = false
	end
    -- GetMainUI():InitTeamCanChange(true,canReborn)
    GetMainUI():InitTeamFuzion2();
    GetMainUI():GetTeamFuzion2():SetPlayerList({});
    GetMainUI():GetTeamFuzion2():SetCurHeroInfo(self.heroSeqIndex[1]);
	GetMainUI():InitTimer()

    self:CallFightStart()

	-- GetMainUI():InitFightFuzionTop()
    GetMainUI():InitFightFuzionRank();
    local mapParam =
    {
        uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_daluandou.assetbundle",
        uiMapBkTex = 'Texture',
        iconsParam =
        {
            [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 180, entity_list = self.loadHeroList},
            [EMapEntityType.EGRedHero] = {nodeName = 'sp_red', entity_list = self.loadMonsterList},
            [EMapEntityType.EBuff] = {nodeName = 'sp'},
        },
        adjustAngle = 180,

        sceneMapSizeName = 'scene_minimap',

        bigMapParam = {
            uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_map_daluandou.assetbundle",
            uiMapBkTex = 'Texture',
            iconsParam =
            {
                [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 180, entity_list = self.loadHeroList},
                [EMapEntityType.EGRedHero] = {nodeName = 'sp_red', entity_list = self.loadMonsterList},
                [EMapEntityType.EBuff] = {nodeName = 'sp'},
            },
            adjustAngle = 180,

            sceneMapSizeName = 'scene_minimap'
        }
    }
    GetMainUI():InitMinimap(mapParam);
	self:_UpdateUI();
end

function HurdleFuzionTenFightManager:Destroy()
	for k,v in pairs(self.timeid) do
		timer.stop(v);
		self.timeid[k] = nil;
	end
	self.heroList = {};
	FightManager.Destroy(self);
end

function HurdleFuzionTenFightManager:_GetPos(exclude_pos)
	local list = ConfigHelper.GetMapInf(tostring(self:GetFightMapInfoID()),EMapInfType.burchhero);
	local available_list = {};

	for k,v in pairs(list) do
		if (exclude_pos == nil or not exclude_pos[v.obj_name]) and string.find(v.obj_name, "hbp_") then
			available_list[#available_list+1] = v;
		end
	end

	local pos_id = math.random(#available_list);
	return available_list[pos_id];
end

function HurdleFuzionTenFightManager:AllHeroDead()
	return self.heroSeqIndex[1].surviveTime ~= 0;
end

function HurdleFuzionTenFightManager:IsClearOtherEnemy()
	local isClear = true;
	for k,v in pairs(self.heroSeqIndex) do
		if k~=1 then
			if v.surviveTime == 0 then
				isClear = false;
			end
		end
	end
	return isClear;
end

function HurdleFuzionTenFightManager:GetKillNum()
	return self.killNum;
end

function HurdleFuzionTenFightManager:GetRank()
	return self.rank or 10;
end

function HurdleFuzionTenFightManager:GetMainHeroAutoFightViewAndActRadius()
	return 50,1000;
end

function HurdleFuzionTenFightManager:GetMainHeroAutoFightAI()
	return 117;
end

function HurdleFuzionTenFightManager:GetDeadNum()
	return self.heroSeqIndex[1].dead or 0;
end
