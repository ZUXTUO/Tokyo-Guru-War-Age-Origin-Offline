WorldTreasureBox = Class("WorldTreasureBox")

function WorldTreasureBox:Init()
	self.rank_info = {}
	self.next_step_box_born_cd = nil
	self.next_step_box_born_cd_start = nil
	self.mysterious_treasure_box_info = nil
	self.my_report = nil
	self.fight_result = nil
	self.small_treasure_box_cnt = 0
	self.big_treasure_box_cnt = 0
	self.system_state = nil
	self.open_mysterious_box_country = 0
	self.reliveTimes = 0;
end

local Points_Rank_Sort = function(a, b)
	return a.points > b.points
end

function WorldTreasureBox:SetPointRankInfo(rank_info, open_mysterious_box_country)
	self.rank_info = {}
	for i=1, PublicStruct.Const.MAX_COUNTRY_CNT do
		self.rank_info[i] = {}
		self.rank_info[i].country_id = i
		self.rank_info[i].points = rank_info[i]
	end
	table.sort(self.rank_info, Points_Rank_Sort)
	self.open_mysterious_box_country = open_mysterious_box_country
end

function WorldTreasureBox:SetNextStepBoxBornCD(seconds)
	self.next_step_box_born_cd = seconds
	self.next_step_box_born_cd_start = PublicFunc.QueryCurTime()
end

function WorldTreasureBox:SetMyteriousTreasureBoxInfo(seconds, x, y)
	self.mysterious_treasure_box_info = {}
	self.mysterious_treasure_box_info.cd = seconds
	self.mysterious_treasure_box_info.cd_start = PublicFunc.QueryCurTime()
	self.mysterious_treasure_box_info.x = x
	self.mysterious_treasure_box_info.y = y
end

function WorldTreasureBox:SetPlayerInfo(openSmallBoxCnt, openBigBoxCnt, killEnemyCnt, points, reliveTimes)
	self.my_report = {}
	self.my_report.open_small_box_cnt = openSmallBoxCnt
	self.my_report.open_big_box_cnt = openBigBoxCnt
	self.my_report.kill_enemy_cnt = killEnemyCnt
	self.my_report.points = points
	self.reliveTimes = reliveTimes
end

function WorldTreasureBox:SetFightResult(mysterious_box_info, rank_info, mysterious_country_reward)
	self.fight_result = {}
	self.fight_result.mysterious_box_info = {}
	self.fight_result.mysterious_box_info.name = mysterious_box_info.name
	self.fight_result.mysterious_box_info.country_id = mysterious_box_info.country_id
	self.fight_result.mysterious_box_info.image = mysterious_box_info.image
	self.fight_result.rank_info = {}
	for i=1, PublicStruct.Const.MAX_COUNTRY_CNT do
		self.fight_result.rank_info[i] = {}
		self.fight_result.rank_info[i].country_id = rank_info[i].country_id
		self.fight_result.rank_info[i].points = rank_info[i].points
	end
	self.fight_result.round_index = self.system_state.round_index
	self.fight_result.mysterious_country_reward = mysterious_country_reward
end

function WorldTreasureBox:SetTreasureBoxNum(smalBoxCnt, bigBoxCnt)
	self.small_treasure_box_cnt = smalBoxCnt
	self.big_treasure_box_cnt = bigBoxCnt
end

function WorldTreasureBox:GetTreasureBoxNum()
	return self.small_treasure_box_cnt, self.big_treasure_box_cnt
end

function WorldTreasureBox:SetSystemState(state, left_time, round_index)
	self.system_state = {}
	self.system_state.state = state
	self.system_state.left_time = left_time
	self.system_state.left_time_start = PublicFunc.QueryCurTime()
	if round_index == 0 then
		self.system_state.round_index = 1
	else
		self.system_state.round_index = round_index
	end
	if state == 0 then
		self.next_step_box_born_cd = nil
		self.next_step_box_born_cd_start = nil
		self.mysterious_treasure_box_info = nil
		self.my_report = nil
		self.fight_result = nil
		self.small_treasure_box_cnt = 0
		self.big_treasure_box_cnt = 0
		self.open_mysterious_box_country = 0
		self.reliveTimes = 0
	end
	app.log_warning("g_dataCenter.worldTreasureBox system_state="..tostring(self.system_state))

	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_WorldBox);
end

function WorldTreasureBox:IsOpen()
	local info = ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox);
	if not info then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	if g_dataCenter.player.level < info.open_level then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	if self.system_state and self.system_state.state == 0 then
		return Gt_Enum_Wait_Notice.Success;
	end
	return Gt_Enum_Wait_Notice.Forced;
end

function WorldTreasureBox:CheckInMap()
	return 
end

function WorldTreasureBox:GetNPCID()
	app.log_warning("g_dataCenter.worldTreasureBox[GetNPCID] self="..tostring(self).." system_state="..tostring(self.system_state))
	if self.system_state then
		app.log_warning("state="..tostring(self.system_state.state).." round_index="..tostring(self.system_state.round_index))
	end
	
	local world_treasure_cfg = ConfigManager.Get(EConfigIndex.t_world_treasure_box, self.system_state.round_index)
	if world_treasure_cfg then
		return world_treasure_cfg.born_pos[g_dataCenter.player:GetCountryId()].npc
	end
	return 0
end

function WorldTreasureBox:OpenTreasureBoxRelivePanel(seconds, killer_type, killer_param1, killer_param2)
	local world_treasure_cfg = ConfigManager.Get(EConfigIndex.t_world_treasure_box, self.system_state.round_index)
	local relive_cost = world_treasure_cfg.perfect_relive_crystal
	local vipData = g_dataCenter.player:GetVipData();
	if self.reliveTimes < vipData.world_treasures_box_free_relive then
		relive_cost = 0
	end
	local relive_title = nil
	if killer_type == 1 then
		local name = ConfigManager.Get(EConfigIndex.t_country_info, killer_param1).name;
		relive_title = "你已经被[ffa127]"..name..killer_param2.."[-]击杀！"
	elseif killer_type == 2 then
		local cfg = ConfigManager.Get(EConfigIndex.t_monster_property, killer_param1)
       	if cfg and cfg.name then
			relive_title = "你已经被[ffa127]"..cfg.name.."[-]击杀！"
		end
	end

	local info = 
	{
		reliveTime = seconds,
		relive = relive_cost,
		title = relive_title,
		leaveConfirm = false,
	};
	FightSetUI.Hide()
	CommonDead.Start(info);
	CommonDead.SetRelive(msg_world_treasure_box.cg_world_treasure_box_hero_relive_immediately, self);
	CommonDead.SetLeave(WorldTreasureBox.OnLeave, self);
	app.log_warning("world_treasure_box open relive panel ")
end

function WorldTreasureBox:OnLeave()
	FightScene.GetFightManager():FightOver(true);
end

function WorldTreasureBox:EndGame()
    
end

function WorldTreasureBox:CheckBattle()
	--local showType = ENUM.EShowHeroType.Have;
	local showType = ENUM.EShowHeroType.All;
	local teamId = ENUM.ETeamType.world_treasure_box;
	local team = g_dataCenter.player:GetTeam(teamId);
	local listAllHero = PublicFunc.GetAllHero(showType, nil, team);
	local _backupTeam = g_dataCenter.player:GetBackupTeam(teamId);
	local level = g_dataCenter.player.level;
	local backupCfg = ConfigManager._GetConfigTable(EConfigIndex.t_world_treasure_box_backup);
	local _flg = {};
	local sort_func = function (a,b)
        if a.realRarity > b.realRarity then
            return true;
        elseif a.realRarity < b.realRarity then
            return false;
        end
		if a:GetFightValue() > b:GetFightValue() then
            return true;
        elseif a:GetFightValue() < b:GetFightValue() then
            return false;
        end
        if a.number < b.number then
            return true;
        elseif a.number > b.number then
            return false;
        end
        if a.team_pos < 4 and b.team_pos == 4 then
            return false;
        elseif b.team_pos < 4 and a.team_pos == 4 then
            return true;
        end
        return false;
	end
    table.sort(listAllHero, sort_func);
    -- 打标记
    for k,v in pairs(team) do
    	_flg[v] = 1;
    end
    for k,v in pairs(_backupTeam) do
    	_flg[v] = 1;
    end
    -- 查询
    local index = 1;
    for i=6,1,-1 do
    	if backupCfg[i].open_level <= level
    		and listAllHero[index].realRarity >= backupCfg[i].min_rarity
    		and _flg[listAllHero[index].index]
    	then
    		return true;
    	end
    end
    return false;
end