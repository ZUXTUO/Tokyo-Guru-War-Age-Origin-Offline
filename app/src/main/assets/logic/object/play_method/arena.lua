
------------------------- 竞技场玩家对象 ---------------------------
ArenaPlayer = Class('ArenaPlayer')

function ArenaPlayer:Init(data)
	local _playerData = {};
	for i = 1, 21 do
		_playerData[i] = {};
		_playerData[i].playerGid = tostring(9990000 + i);
		_playerData[i].szPlayerName = "电脑" .. i;			-- 玩家名
		_playerData[i].fightPoint = 10000 - i * 100;	-- 战力		new
		_playerData[i].rankIndexID = i;						-- 排名		new
		
		if i > 10 then
			_playerData[i].rankIndexID = 2 * i;
		end
		_playerData[i].vecCardsRole = {}
		_playerData[i].vecCardsEquip = {}
		for j = 1, 3 do
			_playerData[i].vecCardsRole[j] = {
				dataid = "1000000" + j,
				number = 30001000 + 5 * (j - 1),
				level = 20,
			}
		end
	
		_playerData[i].teamInfo = {
			teamid=8,
			cards=_playerData[i].vecCardsRole,
			heroLineup={6,7,8},
			soldierLineup={2,3,4,11,12},
		}
	end
	data			= _playerData
	self.rank		= data.rankIndexID or 0
	self.leaderId	= data.LeaderNumber or 0
	self.fightPoint	= data.fightPoint or 0
	self.playerid 	= data.playerGid or 0
	self.name 		= data.szPlayerName or ""
	self.level 		= data.playerLevel or 1
	-- self.heroCards 	= data.vecCardsRole or {}
	-- self.equipCards	= data.vecCardsEquip or {}
	-- self.team		= data.teamInfo or {}

	self.receivedTopRewardFlag = nil -- 领取过的爬梯奖（保存起始值）

	return self
end

function ArenaPlayer:UpdateData(data)
	local _playerData = {};
	for i = 1, 21 do
		_playerData[i] = {};
		_playerData[i].playerGid = tostring(9990000 + i);
		_playerData[i].szPlayerName = "单机测试" .. i;			-- 玩家名
		_playerData[i].fightPoint = 10000 - i * 100;	-- 战力		new
		_playerData[i].rankIndexID = i;						-- 排名		new
		
		if i > 10 then
			_playerData[i].rankIndexID = 2 * i;
		end
		_playerData[i].vecCardsRole = {}
		_playerData[i].vecCardsEquip = {}
		for j = 1, 3 do
			_playerData[i].vecCardsRole[j] = {
				dataid = "1000000" + j,
				number = 30001000 + 5 * (j - 1),
				level = 20,
			}
		end
	
		_playerData[i].teamInfo = {
			teamid=8,
			cards=_playerData[i].vecCardsRole,
			heroLineup={6,7,8},
			soldierLineup={2,3,4,11,12},
		}
	end
	data			= _playerData
	if data.rankIndexID then 	self.rank = data.rankIndexID end
	if data.LeaderNumber then 	self.leaderId = data.LeaderNumber end
	if data.fightPoint then 	self.fightPoint = data.fightPoint end
	if data.playerGid then 		self.playerid = data.playerGid end
	if data.szPlayerName then 	self.name = data.szPlayerName end
	if data.playerLevel then 	self.level = data.playerLevel end
	-- if data.vecCardsRole then 	self.heroCards = data.vecCardsRole end
	-- if data.vecCardsEquip then 	self.equipCards = data.vecCardsEquip end
	if data.teamInfo then 		self.team = data.teamInfo end
end

------------------------- 竞技场对手数据 ---------------------------
ArenaFighter = Class('ArenaFighter')

function ArenaFighter:Init(data)
	local _playerData = {};
	for i = 1, 21 do
		_playerData[i] = {};
		_playerData[i].playerGid = tostring(9990000 + i);
		_playerData[i].szPlayerName = "单机测试" .. i;			-- 玩家名
		_playerData[i].fightPoint = 10000 - i * 100;	-- 战力		new
		_playerData[i].rankIndexID = i;						-- 排名		new
		
		if i > 10 then
			_playerData[i].rankIndexID = 2 * i;
		end
		_playerData[i].vecCardsRole = {}
		_playerData[i].vecCardsEquip = {}
		for j = 1, 3 do
			_playerData[i].vecCardsRole[j] = {
				dataid = "1000000" + j,
				number = 30001000 + 5 * (j - 1),
				level = 20,
			}
		end
	
		_playerData[i].teamInfo = {
			teamid=8,
			cards=_playerData[i].vecCardsRole,
			heroLineup={6,7,8},
			soldierLineup={2,3,4,11,12},
		}
	end
	data			= _playerData
	self.rank		= data.rankIndexID or 0
	self.fightPoint	= data.fightPoint or 0
	self.playerid 	= data.playerGid or 0

	--从ArenaPlayer里面更新
	self.name 		= ""
	self.level 		= 1	
	self.leaderId	= 0

	self.heroCards 	= data.vecCardsRole or {}
	self.equipCards	= data.vecCardsEquip or {}
	self.team		= data.teamInfo or {}

	return self
end

function ArenaFighter:UpdateOtherData(data)
	local _playerData = {};
	for i = 1, 21 do
		_playerData[i] = {};
		_playerData[i].playerGid = tostring(9990000 + i);
		_playerData[i].szPlayerName = "单机测试" .. i;			-- 玩家名
		_playerData[i].fightPoint = 10000 - i * 100;	-- 战力		new
		_playerData[i].rankIndexID = i;						-- 排名		new
		
		if i > 10 then
			_playerData[i].rankIndexID = 2 * i;
		end
		_playerData[i].vecCardsRole = {}
		_playerData[i].vecCardsEquip = {}
		for j = 1, 3 do
			_playerData[i].vecCardsRole[j] = {
				dataid = "1000000" + j,
				number = 30001000 + 5 * (j - 1),
				level = 20,
			}
		end
	
		_playerData[i].teamInfo = {
			teamid=8,
			cards=_playerData[i].vecCardsRole,
			heroLineup={6,7,8},
			soldierLineup={2,3,4,11,12},
		}
	end
	data			= _playerData
	if data == nil then
		app.log("没有挑战的竞技场对手数据")
		return;
	end
	if data.name then		self.name = data.name end
	if data.level then 		self.level = data.level end
	if data.leaderId then	self.leaderId = data.leaderId end
end

------------------------- 竞技场战报对象 ---------------------------
ArenaFightReport = Class('ArenaFightReport')

function ArenaFightReport:Init(data)
	local _playerData = {};
	for i = 1, 21 do
		_playerData[i] = {};
		_playerData[i].playerGid = tostring(9990000 + i);
		_playerData[i].szPlayerName = "单机测试" .. i;			-- 玩家名
		_playerData[i].fightPoint = 10000 - i * 100;	-- 战力		new
		_playerData[i].rankIndexID = i;						-- 排名		new
		
		if i > 10 then
			_playerData[i].rankIndexID = 2 * i;
		end
		_playerData[i].vecCardsRole = {}
		_playerData[i].vecCardsEquip = {}
		for j = 1, 3 do
			_playerData[i].vecCardsRole[j] = {
				dataid = "1000000" + j,
				number = 30001000 + 5 * (j - 1),
				level = 20,
			}
		end
	
		_playerData[i].teamInfo = {
			teamid=8,
			cards=_playerData[i].vecCardsRole,
			heroLineup={6,7,8},
			soldierLineup={2,3,4,11,12},
		}
	end
	data			= _playerData
	self.rankChange		= data.rankIndexChange or 0
	self.curRank		= data.curRankIndex or 0
	self.oldRank		= data.oldRankIndex or 0
	self.fightPoint		= data.fightValue or 0
	self.fightReplay	= data.fightReplayGID or ""
	self.fightTime	= tonumber(data.happenTime) or 0
	self.attackPlayerid = data.playerGid or 0
	self.leaderId	= data.nImage or 0
	self.playerid	= data.enemyPlayerID or 0
	self.level		= data.enemyPlayerLevel or 1
	self.name 		= data.szPlayerName or ""
	self.isNew		= data.byNew == 1	-- 己方发起挑战的战报服务端默认记为0
	self.isWin 		= data.byWin == 1	-- 0失败 1胜利
	self.heroCards 	= data.vecCardsRole or {}
	self.equipCards	= data.vecCardsEquip or {}

	return self
end

------------------------- 竞技场数据中心 ---------------------------
Arena = Class("Arena", PlayMethodBase)

-- 初始化
function Arena:Init(data)
	local _playerData = {};
	for i = 1, 21 do
		_playerData[i] = {};
		_playerData[i].playerGid = tostring(9990000 + i);
		_playerData[i].szPlayerName = "单机测试" .. i;			-- 玩家名
		_playerData[i].fightPoint = 10000 - i * 100;	-- 战力		new
		_playerData[i].rankIndexID = i;						-- 排名		new
		
		if i > 10 then
			_playerData[i].rankIndexID = 2 * i;
		end
		_playerData[i].vecCardsRole = {}
		_playerData[i].vecCardsEquip = {}
		for j = 1, 3 do
			_playerData[i].vecCardsRole[j] = {
				dataid = "1000000" + j,
				number = 30001000 + 5 * (j - 1),
				level = 20,
			}
		end
	
		_playerData[i].teamInfo = {
			teamid=8,
			cards=_playerData[i].vecCardsRole,
			heroLineup={6,7,8},
			soldierLineup={2,3,4,11,12},
		}
	end
	data			= _playerData
	PlayMethodBase.Init(self, data)
	
	self.msgEnumId = MsgEnum.eactivity_time.eActivityTime_arena;
	self.times = ConfigManager.Get(EConfigIndex.t_activity_time,self.msgEnumId).number_restriction.d;
	self.rank = 0;	-- 竞技场排名
	self.finishTimes = 0;
	self.buyTimes = 0;
	self.cleanCDtimes = 0;
	self.thirdTimes = 0;
	self.refreshTimes = 0
	self.coldTime = 0	-- 冷却结束时间点
	self.historyTopRank = 0
	self.fightResult = nil  -- 临时保存的挑战结果
	self.newReport = false	-- 是否有新战报（主动挑战的不算）
    self.newTopReward = false;
    self.newPointReward = false;
end

function Arena:Finalize()
	TimerManager.Remove()
end

function Arena:ResetFightCdTime()
	self.isColding = false
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Arena_ChallengeTimes)
	TimerManager.Remove(self.ResetFightCdTime)
end

function Arena:IsInColding()
	return self.isColding
end

function Arena:GetVipTimes()
	local vipBuyTimes, vipFreeTimes = 0, 0
	if g_dataCenter.player and g_dataCenter.player.vip then
		local vip_config = g_dataCenter.player:GetVipData();
		if vip_config then
			vipBuyTimes = vip_config.can_buy_arena_times or 0;
			vipFreeTimes = vip_config.arena_times or 0;
		end
		-- vipBuyTimes = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip).can_buy_arena_times or 0;
		-- vipFreeTimes = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip).arena_times;
	end
	return vipBuyTimes, vipFreeTimes
end

function Arena:ClearData(data)
	local _playerData = {};
	for i = 1, 21 do
		_playerData[i] = {};
		_playerData[i].playerGid = tostring(9990000 + i);
		_playerData[i].szPlayerName = "单机测试" .. i;			-- 玩家名
		_playerData[i].fightPoint = 10000 - i * 100;	-- 战力		new
		_playerData[i].rankIndexID = i;						-- 排名		new
		
		if i > 10 then
			_playerData[i].rankIndexID = 2 * i;
		end
		_playerData[i].vecCardsRole = {}
		_playerData[i].vecCardsEquip = {}
		for j = 1, 3 do
			_playerData[i].vecCardsRole[j] = {
				dataid = "1000000" + j,
				number = 30001000 + 5 * (j - 1),
				level = 20,
			}
		end
	
		_playerData[i].teamInfo = {
			teamid=8,
			cards=_playerData[i].vecCardsRole,
			heroLineup={6,7,8},
			soldierLineup={2,3,4,11,12},
		}
	end
	data			= _playerData
	PlayMethodBase.ClearData(self, data);

	self.fightResult = nil
    --玩法ID修改后需要注意
	self.hurdle_id = 60109000
end

function Arena:_GameResult(isWin, awards,  param)
	local data = PlayMethodBase._GameResult(self, isWin, awards,  param);

	local battle = {};
	battle.players = {};
	local left_cards = {};
	local left_card_data = g_dataCenter.player:GetTeam(ENUM.ETeamType.arena)
	local right_cards = {};
	local right_cards_data = self.arenaFighter.heroCards
	local right_player = Player:new();
	local player_info = {}
	player_info.name = self.arenaFighter.name
	player_info.level = self.arenaFighter.level
	player_info.image = self.arenaFighter.leaderId
	right_player:UpdateData(player_info)
	for i=1, 3 do
		if left_card_data[i] then
			left_cards[i] = g_dataCenter.package:find_card(1, left_card_data[i]);
		end
		if right_cards_data[i] then
			right_cards[i] = CardHuman:new(right_cards_data[i]);
		end
	end
	battle.players.left = {player=g_dataCenter.player,cards=left_cards};
	battle.players.right = {player=right_player,cards=right_cards};
	local friend_num = FightRecord.GetKillBossNum(2);
	local enemy_num = FightRecord.GetKillBossNum(1);

    --名次及历史上升最高
    --------------------------------------------------------
    local _arenaInfo = {}
    if isWin == EPlayMethodLeaveType.success then
        if self.topRankResult then
            _arenaInfo.upTopRank = self.topRankResult.upTopRank
            self.topRankResult = nil
        end
    end
    if self.fightResult then
        _arenaInfo.rankChange = self.fightResult.rankChange
        _arenaInfo.myRank = self.fightResult.curRank
        _arenaInfo.enemyRank = self.fightResult.oldRank
    end

	--结算奖励
    --------------------------------------------------------
	local _awards = {}
	local _award_drop_id = nil
	if isWin == EPlayMethodLeaveType.success then
		_award_drop_id = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_arena_win_drop_id).data
	else
		_award_drop_id = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_arena_lose_drop_id).data
	end
	if _award_drop_id then
		local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something, _award_drop_id);
		for i, v in pairs(drop_list) do
			if v.goods_show_number > 0 then
				table.insert(_awards, {id=v.goods_show_number, num=v.goods_number})
			end
		end
	end

	battle.fightResult = {
        isWin = isWin, leftCount = friend_num, rightCount = enemy_num,
        arenaInfo = _arenaInfo,
		awards = _awards
    };
	battle.battleName = "竞技场";
	data.battle = battle;

	data.jump = nil		--不显示跳转界面
	data.awards = nil 	--不显示奖励界面
	
	return data;
end

function Arena:GameResult(isWin, awards,  param)
	if self.isForce then
		FightScene.ExitFightScene()
	else
		local funcGameResult = function()
            PlayMethodBase.GameResult(self, isWin, awards,  param);  
        end

		if isWin == 0 then
			CommonKuikuliyaWinUI.Start();
			CommonKuikuliyaWinUI.SetEndCallback(funcGameResult);
		-- 延迟退出
		else
			TimerManager.Add(funcGameResult, 1500, 1)
		end
	end
end
-- 有新战报
function Arena:HaveNewReport()
	return self.newReport
end

-- 是否有红点显示（外部接口）
function Arena:IsShowRedPoint()
	-- 1新战报
	if self:HaveNewReport() then
		return true
	-- 2有挑战次数
	elseif self:GetTimes() > 0 then
		return true
    elseif  self.newTopReward then
        return true
    elseif  self.newPointReward then
        return true
	end

	return false
end

-----------------消息-----------
function Arena:SetNewReport(flag)
	self.newReport = Utility.to_bool(flag) or false

	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Arena_Report)
end

function Arena:SetTopRankResult(upTopRank, awards)
	self.topRankResult = {}
	self.topRankResult.awards = awards;
	self.topRankResult.upTopRank = upTopRank;
end

function Arena:SetWinFightResult(reportData)
	local report = ArenaFightReport:new(reportData)
	-- 更新新战报标记
	if report.isNew then
		self.newReport = true
	end
	-- 记录刚刚挑战的战报结果
	if self.arenaFighter and report.name == self.arenaFighter.name then
		self.fightResult = ArenaFightReport:new(reportData)
	end

	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Arena_Report)
end

function Arena:SetMyData(myRank, buyTimes, thirdTimes, coldTime, refreshTimes, points, pointRewardInfo, isFirstPass, maskRank, cleanCDtimes, historyRankIndex)
	local oldHistoryTopRank = self.historyTopRank
	self.rank = myRank;
	self.buyTimes = buyTimes;
	self.thirdTimes = thirdTimes;
	self.refreshTimes = refreshTimes;
	self.points = points; -- 当前拥有积分
	self.pointRewardInfo = {} -- 每日积分奖领取情况
	self.isFirstPass = isFirstPass
	self.maskRank = maskRank or 0
	self.cleanCDtimes = cleanCDtimes or 0
	self.historyTopRank = historyRankIndex or 0
	if not pointRewardInfo == nil then
		for i, v in ipairs(pointRewardInfo) do
			table.insert(self.pointRewardInfo, Utility.to_bool(v))
		end
	end
    local pointrewardconfig = ConfigManager._GetConfigTable(EConfigIndex.t_arena_day_point_reward)
    self.newPointReward = false
    if self.points > 0 then
        local index = 0
        for i, v in ipairs(pointrewardconfig) do
            if self.points >= v.need_point and not self:IsReceivePointReward(i) then
                self.newPointReward = true
                break;
            end
        end
    end

	local coldTime = tonumber(coldTime) or 0
	if coldTime > 0 then
		self.coldTime = coldTime + 
			ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_arenaCdInterval).data;
		local sec = self.coldTime - system.time()
		if sec > 0 then
			TimerManager.Add(self.ResetFightCdTime, sec * 1000, 1, self)
			self.isColding = true
		end
	else
		self.coldTime = 0
	end
	
    self:UpdateNewTopRankChange(oldHistoryTopRank, self.historyTopRank)

    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Arena_ScoreAward)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Arena_ChallengeTimes)
end

function Arena:GetChallengeCost()
	local costMaxNum = ConfigManager.GetDataCount(EConfigIndex.t_arena_cost)
	local costIndex = math.min(self.buyTimes+1, costMaxNum)
	return ConfigManager.Get(EConfigIndex.t_arena_cost,costIndex).challenge_cost
end

function Arena:GetCleanCdCost()
	local costMaxNum = ConfigManager.GetDataCount(EConfigIndex.t_arena_cost)
	local costIndex = math.min(self.cleanCDtimes+1, costMaxNum)
	return ConfigManager.Get(EConfigIndex.t_arena_cost,costIndex).clean_cd_cost
end

function Arena:GetRefreshCost()
	local costMaxNum = ConfigManager.GetDataCount(EConfigIndex.t_arena_cost)
	local costIndex = math.min(self.refreshTimes+1, costMaxNum)
	return ConfigManager.Get(EConfigIndex.t_arena_cost,costIndex).refresh_cost
end

function Arena:Tostring(isEnter)
	local param = {};
	param[1] = tostring(self.hurdle_id);
	param[2] = tostring(self.arenaPlayer.playerid);
	param[3] = tostring(self.arenaPlayer.rank)

	if isEnter then
		local cardIdArrayStr = ""
		-- for i, v in ipairs(self.arenaPlayer.heroCards) do
		-- 	cardIdArrayStr = cardIdArrayStr .. tostring(v.dataid) .. ";"
		-- end
		param[4] = cardIdArrayStr

		param[5] = tostring(self.rank)
	end

	return param;
end

function Arena:EndGame(is_force)
	self.isForce = is_force
	local star = FightRecord.GetStar();
	local isWin = 1;
	if star > 0 then
		isWin = 0;
	end
    local param = self:Tostring()
    param[4] = tostring(FightScene.GetFightManager():GetFightUseTime())
    param[5] = tostring(self.isFirstPass or 0)
	msg_activity.cg_leave_activity(self.play_method_id,isWin,param);
end

function Arena:BeginGame(result, cf)
	AudioManager.Stop(nil, true);
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight);

	self:SetBattleFighter()

	self._super.BeginGame(self,result, cf);
end

function Arena:SetArenaFighter(fight_data)
	local arenaFighter = ArenaFighter:new(fight_data)
	arenaFighter:UpdateOtherData(self.arenaPlayer)

	self.arenaFighter = arenaFighter
end

function Arena:StartBattle(arenaPlayer)
	if arenaPlayer == nil then return end

	self.arenaPlayer = arenaPlayer

	--对手数据在进入活动消息回来前才下发
	self:SetLevelIndex(self.hurdle_id);
	self:SetPlayMethod(self.msgEnumId);
	msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_arena, self:Tostring(true))
end

------------------ui------------
function Arena:GetTimes()
	local number = g_dataCenter.player:GetFlagHelper():GetStringFlag(self.msgEnumId);
	number = number or "d=0";
	self.finishTimes = PublicFunc.GetActivityCont(number,"d");

	local vipBuyTimes, vipFreeTimes = self:GetVipTimes()

	-- 玩法限制作弊 (最大开启次数)
	-- if g_dataCenter.gmCheat:noPlayLimit() then
	--     return self.times+vipFreeTimes+self.thirdTimes
	-- end

	local result = 0;
	if self.finishTimes <= vipFreeTimes + self.times then
		result = self.thirdTimes+self.times+vipFreeTimes-self.finishTimes;
	else
		result = self.thirdTimes;
	end
	return result;
end

function Arena:GetRemainBuyTimes()
	local vipBuyTimes = self:GetVipTimes()
	return vipBuyTimes-self.buyTimes;
end

function Arena:GetMyRank()
	return self.rank;
end

function Arena:GetMyHistoryTopRank()
	return self.historyTopRank;
end

function Arena:GetNewTopReward()
	return self.newTopReward
end

function Arena:SetNewTopReward(value)
	self.newTopReward = Utility.get_value(value, false)
end

function Arena:GetNewPointReward() 
	return self.newPointReward
end

function Arena:UpdateReceivedTopReward(index)
	self.receivedTopRewardFlag[index] = true
	self:UpdateNewTopReward()
end

function Arena:UpdateNewTopRankChange(oldHistoryTopRank, nowHistoryTopRank)
	if oldHistoryTopRank <= nowHistoryTopRank or self.newTopReward then return end

	local climb_reward = ConfigManager._GetConfigTable(EConfigIndex.t_arena_climb_reward)
	local oldClimbRewardRank = 0
	local nowClimbRewardRank = 0
	for i, v in pairs_key(climb_reward) do
		if oldClimbRewardRank == 0 and oldHistoryTopRank <= v.rank_index then
			oldClimbRewardRank = v.rank_index
		end
		if nowClimbRewardRank == 0 and nowHistoryTopRank <= v.rank_index then
			nowClimbRewardRank = v.rank_index
		end
	end

	if oldClimbRewardRank > nowClimbRewardRank then
		self:SetNewTopReward(true)
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Arena_RankAward)
	end
end

function Arena:UpdateNewTopReward()
	self:SetNewTopReward(false)
	local climb_reward = ConfigManager._GetConfigTable(EConfigIndex.t_arena_climb_reward)
	local historyTopRank = self:GetMyHistoryTopRank()
	local flag = self:GetReceivedTopRewardFlag()
	if historyTopRank > 0 then
		local index = 0
		for i, v in pairs(climb_reward) do
			if historyTopRank <= v.rank_index and not flag[v.rank_index] then
				self:SetNewTopReward(true)
				break
			end
		end
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Arena_RankAward)
end

function Arena:SetReceivedTopRewardFlag(receiveList)
	self.receivedTopRewardFlag = {}
	for i, k in pairs(receiveList) do
		self.receivedTopRewardFlag[k] = true
	end
	local climb_reward = ConfigManager._GetConfigTable(EConfigIndex.t_arena_climb_reward)
	self:SetNewTopReward(false)
	local historyTopRank = self:GetMyHistoryTopRank()
	local flag = self:GetReceivedTopRewardFlag()
	if historyTopRank > 0 then
		for i, v in pairs(climb_reward) do
			if historyTopRank <= v.rank_index and flag[v.rank_index] == nil then
				self:SetNewTopReward(true)
				break
			end
		end
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_Arena_RankAward)
end

function Arena:GetReceivedTopRewardFlag()
	return self.receivedTopRewardFlag or {}
end

function Arena:GetPoints()
	return self.points or 0
end

function Arena:IsReceivePointReward(index)
	return self.pointRewardInfo[index]
end

function Arena:SetBattleFighter()
	if self.arenaFighter == nil then return end

	self:ClearFightPlayer()

	local temp_player = Player:new();
	local player_info = {};
	player_info.playerid = self.arenaFighter.playerid;
	player_info.name = self.arenaFighter.name;
	player_info.level = self.arenaFighter.level;
	player_info.image = self.arenaFighter.leaderId;
	temp_player:UpdateData(player_info);
	local temp_package = Package:new();
	for i, hero in pairs(self.arenaFighter.heroCards) do
		temp_package:AddCard(ENUM.EPackageType.Hero, hero);
	end
	temp_player:SetPackage(temp_package);
	-- 使用服务器的队伍战斗力
	temp_player.fight_value = self.arenaFighter.fightPoint

	local team = self.arenaFighter.team;
	local team_info = {};
	local defTeam = {}
	-- 服务端未给出默认阵型的临时处理
	if next(team.cards) == nil then
		for k, v in pairs_key(self.arenaFighter.heroCards) do
	        team_info[k] = {};
	        team_info[k].index = v.dataid;
	        team_info[k].pos = k;
	        defTeam[k] = v.dataid;
	    end
	else
		for k, v in pairs_key(team.cards) do
			if tonumber(v) ~= 0 then
				team_info[k] = {};
				team_info[k].index = v;
				team_info[k].pos = k;
				defTeam[k] = v;
			end
	    end
	end
	
	self:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, temp_player, temp_package, EFightPlayerType.human, defTeam, {teamPos=team_info})

	-- 添加玩家自己
	local myArenaTeam = self:UpdateTeam()
    local team_info = {};
    for k, v in pairs(myArenaTeam) do
		if tonumber(v) ~= 0 then
			team_info[k] = {};
			team_info[k].index = v;
			team_info[k].pos = k;
		end
    end

	self:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, myArenaTeam,{teamPos=team_info})
end

function Arena:UpdateTeam()
	app.log("重新配备队伍");
	local player = g_dataCenter.player;
    local teamid = ENUM.ETeamType.arena;

	local result = player:GetTeam(teamid)
    if Utility.isEmpty(result) then
		--local heroList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
		local heroList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
		table.sort(heroList, function (a,b)
			if a:GetFightValue() > b:GetFightValue() then
				return true;
			end
			return false;
		end)

		local teamData = {}
		app.log("Arena:UpdateTeam 英雄列表："..tostring(heroList));
		for k, v in pairs(heroList) do
			teamData[k] = v.index
		end
		--取战斗力最强的三个
		local team = PublicFunc.CreateSendTeamData(teamid, teamData)
		result = team.cards

		msg_team.cg_update_team_info(team)
    end

	return result;
end

function Arena:IsOpen()
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_arena) then
		return false
	end
	return self:HaveNewReport() or self.newTopReward or self.newPointReward;
end

--返回炫耀一下的竞技场排名
function Arena:GetShowRank()
	--[[
	local result = self.rank

    -- 特殊规则说明：20000以后都显示假排名
    if result > 20000 then
        result = self.maskRank
    end
    return result
	]]
	return 1
end

--返回炫耀一下的竞技场战斗力
function Arena:GetShowTeamFightValue()
	--[[
	local result = 0

	local myArenaTeam = self:UpdateTeam()
	for i, v in pairs(myArenaTeam) do
		if tonumber(v) ~= 0 then
			local cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, v)
			result = result + cardInfo:GetFightValue()
		end
	end

	return result
	]]
	return 9999999
end
