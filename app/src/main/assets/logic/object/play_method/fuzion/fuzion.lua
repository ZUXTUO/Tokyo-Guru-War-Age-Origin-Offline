Fuzion = Class('Fuzion', PlayMethodBase)

function Fuzion:Init(data)
	self.isInitMyData 	= false	-- 是否初始化过我的数据

	self.myData = {point=0, fightsoul=0, fightcnt=0, season=0, rank=0}

	self.playerList = {}	-- 匹配的玩家列表，按位置序号存储
	self.fighterList = {}	-- 战斗英雄数据
	self.showFighter = {}	-- 用于展示的fighter数据
	self.showReward = nil	-- 用于展示的战斗奖励
	self.rankList = nil		-- 临时存储赛季排行榜数据
	self.championList = nil	-- 临时存储历史冠军数据
	self.roomCreateTime = 0		-- 房间创建时间
	self.roomid = 0			-- 房间号

	self.totalCnt = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_fuzionDayAwardCount).data;

	return self
end

function Fuzion:ClearData()
	self.fighterList = {}
end

function Fuzion:EndGame()
    FuzionBattleInfoUI.Start()
    FuzionBattleInfoUI.SetFinishCallback(FightScene.ExitFightScene)
end

-------------------------------------接口-------------------------------------
-- 是否已初始化
function Fuzion:IsInitMyData()
	return self.isInitMyData
end

-- 设置我的信息
function Fuzion:SetMyData(data)
	self.myData.point = data.myPoint or 0
	self.myData.fightsoul = data.myFightsoul or 0
	self.myData.fightcnt = data.todayFightCnt or 0
	self.myData.season = data.nCurSeason or 0
	self.myData.rank = data.rank or 0 -- TODO 待服务器添加参数

	self.isInitMyData = true
end

function Fuzion:GetMyData()
	return self.myData
end

-- 剩余次数
function Fuzion:GetTimes()
	local curTimes = 0;
	if self.myData then
		curTimes = self.myData.fightcnt
	end
	return math.max(0, self.totalCnt - curTimes);
end

function Fuzion:SetFightCnt(cnt)
	self.myFightCnt = cnt
end

function Fuzion:SetFightSoul(fightsoul)
	self.myFightsoul = fightsoul
end

function Fuzion:SetPoint(point)
	self.myPoint = point
end

function Fuzion:SetRoomCreateTime(time)
	self.roomCreateTime = time
end

function Fuzion:SetRoomId(id)
	self.roomid = id
end

function Fuzion:GetPlayerNumber()
	local number = 0
	for _, _ in pairs(self.playerList) do
		number = number + 1
	end
	return number
end

function Fuzion:GetPlayerReadyNumber()
	local number = 0
	for i, v in pairs(self.playerList) do
		if v.ready then
			number = number + 1
		end
	end
	return number
end

function Fuzion:SetPlayerData(data)
	self.playerList = {}
	for i, v in pairs(data) do
		table.insert(self.playerList, FuzionPlayer:new(v))
	end
end

function Fuzion:GetSortPlayerList()
	local playerid = g_dataCenter.player.playerid
	if self.playerList[1].playerid ~= playerid then
		for i, v in pairs(self.playerList) do
			if v.playerid == playerid then
				local mydata = v;
				table.remove(self.playerList, i)
				table.insert(self.playerList, 1, mydata)
				break;
			end
		end
	end
	return self.playerList
end

function Fuzion:InsertPlayer(data)
	table.insert(self.playerList, FuzionPlayer:new(data))
end

function Fuzion:RemovePlayer(data)
	for i, v in pairs(self.playerList) do
		if v.playerid == data.playerid then
			table.remove(self.playerList, i)
			break;
		end
	end
end

function Fuzion:GetMyPlayerData()
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

function Fuzion:ResetPlayer()
	self.playerList = {}
end

-- struct world_map_member_info
-- {
-- 	int level;
-- 	int hero_id;
-- 	int fight_value;
-- 	string owner_name;
-- };
function Fuzion:SetShowFighter(data)
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
function Fuzion:UpdateFighter(data)
	local createMyFighter = false
	local fighter = self.fighterList[data.player_gid]
	if fighter == nil then
		self.fighterList[data.player_gid] = FuzionFighter:new(data)
		if data.owner_gid == g_dataCenter.player.playerid then
			createMyFighter = true
		end
	else
		fighter:SetBaseData(data)
	end
	NoticeManager.Notice(ENUM.NoticeType.FuzionFighterData)
	return createMyFighter
end
function Fuzion:UpdateFighterKillData(vecKillData)
	for i, v in pairs(vecKillData) do
		local fighter = self.fighterList[v.fighter_gid]
		if fighter then
			fighter:UpdateKillData(v)
		end
	end

	NoticeManager.Notice(ENUM.NoticeType.FuzionFighterData)
end
function Fuzion:SetFighterReliveTime(fightGid, reliveTime)
	local fighter = self.fighterList[fightGid]
	if fighter then
		fighter:SetReliveTime(reliveTime)
	end
end

function Fuzion:PlayerSetReady()
	for i, v in pairs(self.playerList) do
		v:SetReady(true)
	end
end

function Fuzion:PlayerLoadUpdate(playerid, percent)
	for i, v in pairs(self.playerList) do
		if v.playerid == playerid then
			v:SetLoadPercent(percent)
			break
		end
	end
end

function Fuzion:SetRankList(rankList)
	self.rankList = rankList
end

function Fuzion:SetChampionList(championList)
	self.championList = championList
end

function Fuzion:SetShowReward(data)
	self.showReward = data
end

function Fuzion:IsOpen()
	return (ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_fuzion).open_level <= g_dataCenter.player.level)
	 and (self.myData.fightcnt <= ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_fuzionDayAwardCount).data)
end
