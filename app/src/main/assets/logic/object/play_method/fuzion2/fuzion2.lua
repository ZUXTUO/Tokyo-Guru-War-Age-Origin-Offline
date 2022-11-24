Fuzion2 = Class('Fuzion2', PlayMethodBase)

function Fuzion2:Init(data)
	self.isInitMyData 	= false	-- 是否初始化过我的数据

	self.myData = {point=0, fightsoul=0, fightcnt=0, season=0, rank=0}

	self.playerList = {}	-- 匹配的玩家列表，序号存储
	self.showFighter = {}	-- 用于展示的fighter数据 loading用
	self.showReward = nil	-- 用于展示的战斗奖励
	self.roomCreateTime = 0		-- 房间创建时间
	self.roomid = 0			-- 房间号

	self.totalCnt = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_fuzionDayAwardCount).data;

	return self
end

function Fuzion2:ClearData()
	self.playedBeginAnim = false;
end

function Fuzion2:EndGame()
    Fuzion2RankUI.Start(self.playerList)
    Fuzion2RankUI.SetFinishCallback(
		function ()
			Fuzion2RankUI.Destroy();
			local validcnt = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_fuzionDayAwardCount).data;
			if self.myData.fightcnt > validcnt then
				FightScene.ExitFightScene();
			else
				local award = self.showReward
				if award and #award > 0 then
					CommonAward.Start(award);
					CommonAward.SetFinishCallback(function()FightScene.ExitFightScene()end);
				else
					app.log_warning("Fuzion2 奖励为空");
					FightScene.ExitFightScene();
				end
			end
		end)
	self.fighterList = {}
end

-------------------------------------接口-------------------------------------
-- 是否已初始化
function Fuzion2:IsInitMyData()
	return self.isInitMyData
end

-- 设置我的信息
function Fuzion2:SetMyData(data)
	self.myData.point = data.myPoint or 0
	self.myData.fightsoul = data.myFightsoul or 0
	self.myData.fightcnt = data.todayFightCnt or 0
	self.myData.season = data.nCurSeason or 0
	self.myData.rank = data.rank or 0 -- TODO 待服务器添加参数
	self.myData.lastFightStartTime = data.nLastFightStartTime or 0;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Fuzion_start);

	self.isInitMyData = true
end

function Fuzion2:GetMyData()
	return self.myData
end

-- 剩余次数
function Fuzion2:GetTimes()
	local curTimes = 0;
	if self.myData then
		curTimes = self.myData.fightcnt
	end
	return math.max(0, self.totalCnt - curTimes);
end

function Fuzion2:SetFightCnt(cnt)
	self.myFightCnt = cnt
end

function Fuzion2:SetFightSoul(fightsoul)
	self.myFightsoul = fightsoul
end

function Fuzion2:SetPoint(point)
	self.myPoint = point
end

function Fuzion2:SetRoomCreateTime(time)
	self.roomCreateTime = time
end

function Fuzion2:SetRoomId(id)
	self.roomid = id
end

function Fuzion2:GetPlayerNumber()
	local number = 0
	for _, _ in pairs(self.playerList) do
		number = number + 1
	end
	return number
end

function Fuzion2:GetPlayerReadyNumber()
	local number = 0
	for i, v in pairs(self.playerList) do
		if v.ready then
			number = number + 1
		end
	end
	return number
end

function Fuzion2:SetPlayerData(data)
	self.playerList = {}
	for i, v in pairs(data) do
		table.insert(self.playerList , Fuzion2Player:new(v));
	end
end

function Fuzion2:InsertPlayer(data)
	-- self.playerList[data.playerid] = Fuzion2Player:new(data)
	table.insert(self.playerList , Fuzion2Player:new(data));
end

function Fuzion2:RemovePlayer(data)
	for i, v in pairs(self.playerList) do
		if v.playerid == data.playerid then
			table.remove(self.playerList, i)
			break;
		end
	end
end

function Fuzion2:FindPlayer(player_name)
	for i, v in pairs(self.playerList) do
		if v.name == player_name then
			return v;
		end
	end
end

function Fuzion2:FindPlayerByFightGid(fight_gid)
	for i, v in pairs(self.playerList) do
		if v.herogid == fight_gid then
			return v;
		end
	end
end
function Fuzion2:GetMyPlayerData()
	local player = nil
	local playerid = g_dataCenter.player.playerid
	for i, v in pairs(self.playerList) do
		if v.playerid == playerid then
			player = v
			break;
		end
	end
	return player
end

function Fuzion2:ResetPlayer()
	self.playerList = {}
end

-- struct world_map_member_info
-- {
-- 	int level;
-- 	int hero_id;
-- 	int fight_value;
-- 	string owner_name;
-- };
function Fuzion2:SetShowFighter(data)
	self.showFighter = data or {}
end

-- struct fight_base_data
-- {
-- 	string owner_gid;
-- 	string owner_name;
-- 	uint player_gid;
-- 	int config_id;
-- 	int max_hp;
-- 	int cur_hp;
-- 	short x;
-- 	short y;
-- 	float move_speed;
-- 	short des_x;
-- 	short des_y;
-- 	int8 camp_flag; //0友方 1敌方
-- };
function Fuzion2:UpdateFighter(data)
	local createMyFighter = false
	local fighter = self:FindPlayer(data.owner_name);
	if data.owner_gid == g_dataCenter.player.playerid then
		if not self.playedBeginAnim then
			createMyFighter = true
			self.playedBeginAnim = true;
		end
		NewFightUiCount.Destroy();
	end
	fighter:SetBaseData(data)
	NoticeManager.Notice(ENUM.NoticeType.FuzionFighterData)
	return createMyFighter
end

function Fuzion2:PlayerLoadUpdate(playerid, percent)
	local fighter = self:FindPlayerByFightGid(playerid);
	if fighter then
		fighter.percent = percent;
	end
end
-- 更新战斗过程数据
-- struct daluandou_kill_data
-- {
	-- string playerid;
	-- uint fighter_gid;
	-- int deadTimes;
	-- int killPlayerCnt;
	-- int continuousKillPlayerCnt;
	-- int surviveTime;		//存活时间
-- }
function Fuzion2:UpdateFighterKillData(vecKillData)
	for i, v in pairs(vecKillData) do
		local fighter = self:FindPlayerByFightGid(v.fighter_gid)
		if fighter then
			fighter:UpdateKillData(v)
		end
	end

	NoticeManager.Notice(ENUM.NoticeType.FuzionFighterData)
end
function Fuzion2:DelFighter(gid)
	-- self.playerList[gid] = nil;
	NoticeManager.Notice(ENUM.NoticeType.FuzionFighterData)
end
function Fuzion2:SetFighterReliveTime(fightGid, reliveTime)
	local fighter = self:FindPlayerByFightGid(fightGid)
	if fighter then
		fighter:SetReliveTime(reliveTime)
	end
end

function Fuzion2:PlayerSetReady()
	for i, v in pairs(self.playerList) do
		v:SetReady(true)
	end
end

function Fuzion2:SetShowReward(data)
	self.showReward = data
end

function Fuzion2:IsOpen()
    if (ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_fuzion2).open_level > g_dataCenter.player.level) then
    	return Gt_Enum_Wait_Notice.Player_Levelup;
    elseif self:CheckOpenTime() ~= Gt_Enum_Wait_Notice.Success then
    	return Gt_Enum_Wait_Notice.Time
    elseif (self.myData.fightcnt >= self.totalCnt) then
    	return Gt_Enum_Wait_Notice.Forced
    else
    	return Gt_Enum_Wait_Notice.Success
    end
end

function Fuzion2:CheckOpenTime()
	local result,time = PublicFunc.InActivityTimeEx(MsgEnum.eactivity_time.eActivityTime_fuzion2)
	if result then
		return Gt_Enum_Wait_Notice.Success;
	else
		TimerManager.Add(Fuzion2OpenTimeOver, time * 1000);
		return Gt_Enum_Wait_Notice.Time;
	end
end

function Fuzion2OpenTimeOver()
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Time, Gt_Enum.EMain_Athletic_Fuzion_start);
end
