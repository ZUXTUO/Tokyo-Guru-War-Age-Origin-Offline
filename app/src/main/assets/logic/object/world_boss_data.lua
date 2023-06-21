WorldBossData = Class("WorldBossData")

function WorldBossData:Init(data)
	self.demage = 0;
	self.insprireTimes = 0;
	self.curBossConfigID = 0;
	self.curPosX = 0;
	self.curPosY = 0;
	self.cfgId = 1;
	self.bossLv = 1;
	self.bossHp = 0;
	self.lastTime = 0;
	self.systemState = 1;
	self.killerName = "";
	self.nChallengeTimes = 0;
end

function WorldBossData:Reset()
	self.demage = 0;
	self.insprireTimes = 0;
	self.rankInfo = nil;
	self.killInfo = nil;
	self.cfgId = 1;
	self.bossLv = 1;
	self.bossHp = 0;
	self.lastTime = 0;
	self.systemState = 1;
	self.killerName = "";
	self.nChallengeTimes = 0;
end

function WorldBossData:IsOpen()
	local info = ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_WorldBoss);
	if not info then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	if g_dataCenter.player.level < info.open_level then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	if self:GetChallengeTimes() ~= 0 then
		return Gt_Enum_Wait_Notice.Success;
	end
	return Gt_Enum_Wait_Notice.Forced;
end

function WorldBossData:SetBossSyncInfo( gid, boss_id, x, y, state )
    if state ~= 1 then
        if self.curBossConfigID == 0 then
            self.curBossConfigID = boss_id;
        end
        if self.curBossConfigID > 0 and self.curBossConfigID == boss_id then
            self.curPosX = x;
            self.curPosY = y;
        end
    else
        self.curBossConfigID = 0;
    end
    
    if self.curBossConfigID > 0 and g_dataCenter.player:CaptionIsAutoFight() then
        local entity =  FightManager.GetMyCaptain();
        entity:SetPatrolMovePath({{x=self.curPosX,y=0,z=self.curPosY}, });
        entity:SetAI(ENUM.EAI.MainHeroAutoFight);
    end
end

function WorldBossData:EndGame()
    
end

-- function WorldBossData:CheckBattle()
-- 	local showType = ENUM.EShowHeroType.Have;
-- 	local teamId = ENUM.ETeamType.world_boss;
-- 	local team = g_dataCenter.player:GetTeam(teamId);
-- 	local listAllHero = PublicFunc.GetAllHero(showType, nil, team);
-- 	local _backupTeam = g_dataCenter.player:GetBackupTeam(teamId);
-- 	local level = g_dataCenter.player.level;
-- 	local backupCfg = ConfigManager._GetConfigTable(EConfigIndex.t_world_boss_backup);
-- 	local _flg = {};
-- 	local sort_func = function (a,b)
--         if a.realRarity > b.realRarity then
--             return true;
--         elseif a.realRarity < b.realRarity then
--             return false;
--         end
-- 		if a:GetFightValue() > b:GetFightValue() then
--             return true;
--         elseif a:GetFightValue() < b:GetFightValue() then
--             return false;
--         end
--         if a.number < b.number then
--             return true;
--         elseif a.number > b.number then
--             return false;
--         end
--         if a.team_pos < 4 and b.team_pos == 4 then
--             return false;
--         elseif b.team_pos < 4 and a.team_pos == 4 then
--             return true;
--         end
--         return false;
-- 	end
--     table.sort(listAllHero, sort_func);
--     -- 打标记
--     for k,v in pairs(team) do
--     	_flg[v] = 1;
--     end
--     for k,v in pairs(_backupTeam) do
--     	_flg[v] = 1;
--     end
--     -- 查询
--     local index = 1;
--     for i=6,1,-1 do
--     	if backupCfg[i].open_level <= level
--     		and listAllHero[index].realRarity >= backupCfg[i].min_rarity
--     		and _flg[listAllHero[index].index]
--     	then
--     		return true;
--     	end
--     end
--     return false;
-- end
-----------------------------------------------------------------------

function WorldBossData:SetBossInfo(info)
	self.cfgId = info.weekday;
	self.bossLv = info.boss_level;
	self.bossHp = info.cur_hp;
	self.lastTime = info.last_time;
	self.systemState = info.system_state;
	self.killerName = info.killer_name;
end
function WorldBossData:GetBossInfo()
	return self.cfgId, self.bossLv, self.bossHp;
end
function WorldBossData:GetKillerName()
	return self.killerName
end
function WorldBossData:GetState()
	return self.systemState;
end
function WorldBossData:GetLastTime()
	return self.lastTime;
end

function WorldBossData:SetChallengeTimes(times)
	self.nChallengeTimes = times
end
function WorldBossData:GetChallengeTimes()
	return self.nChallengeTimes;
end

function WorldBossData:SaveRankInfo(info)
	self.rankInfo = info;
	if GetMainUI() and GetMainUI():GetWorldBossRank() then
		GetMainUI():GetWorldBossRank():UpdateRank(self.rankInfo, self.demage, self:IsHaveOwn(), self.singleDamage);
	end
end

function WorldBossData:SetDemage(demage, singleDamage)
	self.demage = demage;
	self.singleDamage = singleDamage;
	if GetMainUI() and GetMainUI():GetWorldBossRank() then
		GetMainUI():GetWorldBossRank():UpdateRank(self.rankInfo, self.demage, self:IsHaveOwn(), self.singleDamage);
	end
end

function WorldBossData:IsHaveOwn()
	local player = g_dataCenter.player;
	if self.rankInfo then
		for k, v in pairs(self.rankInfo) do
			if v.player_name == player.name then
				return k;
			end
		end
	end
	return 0;
end

function WorldBossData:SetInsprireTimes(spr)
	self.insprireTimes = spr;
	if GetMainUI() and GetMainUI():GetWorldBoss() then
		GetMainUI():GetWorldBoss():UpdateEncourage();
	end
end

function WorldBossData:SetRewardFlag(flag1, flag2)
	self.flag = {flag1,fla2};
end
function WorldBossData:GetRewardFlag(index)
	if not self.flag then return false; end;
	if index < 32 then
		return bit.bit_and(self.flag[1], bit.bit_lshift(1, index-1)) > 0;
	else
		return bit.bit_and(self.flag[2], bit.bit_lshift(1, index-32)) > 0;
	end
end

function WorldBossData:SetBuyTimes(times)
	self.bugTimes = times;
end
function WorldBossData:GetBuyTimes()
	return self.bugTimes;
end
function WorldBossData:GetMaxBuyTimes()
	local vipCfg = g_dataCenter.player:GetVipData();
	if vipCfg then
		return vipCfg.world_buy_times_limit;
	else
		return 1;
	end
end

function WorldBossData:GetDamageLv(lv, damage)
    local cfg = ConfigManager.Get(EConfigIndex.t_world_boss_system, self.cfgId);
	local boss_id = cfg.boss_info.id;
	local cfgList = ConfigManager.Get(EConfigIndex.t_world_boss_damage_reward,boss_id);
	local info;
	for k,cfg in pairs(cfgList) do
		if cfg.player_level == lv then
			info = cfg;
			break;
		end
	end
	if info == nil then
		app.log("找不到伤害配置(world_boss_damage_reward)。".. " boss_id:"..tostring(boss_id))
		return 3,{};
	end
	if damage > info.s_damage then
		return 1,info.s_reward;
	elseif damage > info.a_damage then 
		return 2,info.a_reward;
	else
		return 3,info.b_reward;
	end
end

