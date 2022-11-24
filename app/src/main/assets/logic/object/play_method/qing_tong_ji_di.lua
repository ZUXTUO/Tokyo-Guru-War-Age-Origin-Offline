--------------------------- QTJDInvitePlayer ---------------------------
QTJDInvitePlayer = Class("QTJDInvitePlayer")

function QTJDInvitePlayer:Init(data)
	self.online = true
	self.roleId = data.roleId or 30001000
	self.playerid = data.playerid or 0
	self.name = data.name or "haoyou"
	self.invited = nil -- nil未接受 false拒绝 true已接受
end

--------------------------- QTJDRoomPlayer ---------------------------
QTJDRoomPlayer = Class("QTJDRoomPlayer")

function QTJDRoomPlayer:Init(data)
	self.roleId = data.roleId
	self.playerid = data.playerid
	self.name = data.name
	self.leader = data.leader
	self.vipLevel = data.vipLevel or 0
	self.integral = data.integral or 0
end

--------------------------- QTJDMatchPlayer ---------------------------
QTJDMatchPlayer = Class("QTJDMatchPlayer")

function QTJDMatchPlayer:Init(data)
	self.image = data.image or 0
	self.playerid = data.playerid
	self.name = data.name
	self.enterState = 0 --0未确定 1已确定
	self.robot = data.robot
end

--------------------------- QTJDVsPlayer ---------------------------
QTJDVsPlayer = Class("QTJDVsPlayer")

function QTJDVsPlayer:Init(data)
	self.image = data.image or 0
	self.roleId = data.roleId or 0
	self.playerid = data.playerid
	self.name = data.name
	self.state = data.state	--0未准备 1已准备
	self.robot = data.robot
end

--------------------------- QTJDRankInfo ---------------------------
QTJDRankInfo = Class("QTJDRankInfo")

function QTJDRankInfo:Init(data)
	self.playerid = data.playerid or 0
	self.integral = data.integral or 0
	self.level = data.level or 1;
	self.guildName = data.guildName or "";
	self.vip = data.vip or 0;
	self.rankNum = data.places or 0
	self.winNum = data.winCount or 0
	self.killNum = data.killCount or 0
	self.deadNum = data.deadCount or 0
	self.roleId = data.roleId or 0
	self.image = data.image
	self.name = data.name or ""
end

--------------------------- QTJDRankInfo ---------------------------
QTJDTopInfo = Class("QTJDTopInfo")

function QTJDTopInfo:Init(data)
	-- self.playerid = data.playerid or 0
	self.integral = data.integral or 0
	self.vip = data.vip or 0;
	self.image = data.image or 0
	self.name = data.name or ""

	local vip_config = ConfigManager.Get(EConfigIndex.t_vip_data, self.vip)
	if vip_config then
		self.vip = vip_config.level
	end
end

-- 开启下一次活动定时器
local _NextActivityUpdateTimer = function()
	local inTime, intervalTime = PublicFunc.InActivityTimeEx(MsgEnum.eactivity_time.eActivityTime_threeToThree)
	if intervalTime > 0 then
		NoticeManager.Notice(ENUM.NoticeType.ActivityTimeUpdate, not inTime)
		-- 到点通知下一次开启
		TimerManager.Add(_NextActivityUpdateTimer, intervalTime)
	end
end
-- 注册活动时间定时器
local _RegistActivityTimer = function()
	_NextActivityUpdateTimer()
	NoticeManager.BeginListen(ENUM.NoticeType.ActivityTimeUpdate, _ActivityStateUpdate)
end
-- 移除活动时间定时器
local _UnRigistActivityTimer = function()
	NoticeManager.EndListen(ENUM.NoticeType.ActivityTimeUpdate, _ActivityStateUpdate)
	TimerManager.Remove(_NextActivityUpdateTimer)
end
-- 活动小红点状态更新
local _ActivityStateUpdate = function()
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Time, Gt_Enum.EMain_Athletic_3V3)
    PublicFunc.msg_dispatch("_ActivityStateUpdate-->3V3")
end


--------------------------- QingTongJiDi ---------------------------
QingTongJiDi = Class("QingTongJiDi");

--数据准备完成 初始化玩法小红点计时器
function QingTongJiDi:InitTipsTime()
	_RegistActivityTimer()
end

function QingTongJiDi:Init()
	self:ClearData();
end

function QingTongJiDi:Finalize()
	_UnRigistActivityTimer()
end

function QingTongJiDi:ClearData()
	local cfg = ConfigManager.Get(EConfigIndex.t_three_to_three_fight, 1)
	self.MaxTimes = cfg.max_challenge_count or 15;
	self.MaxSoul = ConfigManager.GetDataCount(EConfigIndex.t_soul_value_property)
	self.integralAwards = {};
	self.integral = 0;
	self.curState = 0;
	self.curTimes = 0;
	self.curTime = 0;
	self.rankNum = 0;
	self.winNum = 0;
	self.killNum = 0;
	self.deadNum = 0;
	self.startTime = 0;	--选择英雄倒计时开始时间点
	self.curSeason = 0;
	-- self.openHero = nil;
	self.playerRoom = nil;
	self.playerVs = nil;
	self.playerMatch = nil;
	self.reliveTime = nil;
	self.fightResult = nil;
	self.teamSoulValue = {0,0};
	self.killInfoList = nil;
	self.roomId = 0;
	self.stage = 0;	-- 0初始 1匹配中 2准备确认 3选人 4战斗

	self.enterType = nil  --0单人匹配 1组队匹配
end

function QingTongJiDi:ClearPlayerRoom()
	self.playerRoom = nil;
	self:SetStage(0);
end

--赛季起始日期
function QingTongJiDi:GetSeasonDurationDate()
    local date = os.date('*t', system.time())
    local year = date.year
    local month = date.month + 1
    if month > 12 then
    	year = year + 1
    	month = 1
    end
    local nextBeginTime = os.time({year=year, month=month, day=1, hour=0, min=0, sec=0})
    local lastDate = os.date('*t', nextBeginTime - 60)

    local beginDateTable = {}
    table.insert(beginDateTable, date.year)
    table.insert(beginDateTable, date.month)
    table.insert(beginDateTable, 1)

    local endDateTable = {}
    table.insert(endDateTable, lastDate.year)
    table.insert(endDateTable, lastDate.month)
    table.insert(endDateTable, lastDate.day)
    
    return beginDateTable, endDateTable
end

--赛季剩余时间秒数（赛季按自然月计）
function QingTongJiDi:GetSeasonLeftSec()
	local time = system.time()
    local date = os.date('*t', time)
    local year = date.year
    local month = date.month + 1
    if month > 12 then
    	year = year + 1
    	month = 1
    end
    local nextBeginTime = os.time({year=year, month=month, day=1, hour=0, min=0, sec=0})
    return math.max( 0, nextBeginTime - time )
end

--当天活动剩余时间秒数
function QingTongJiDi:GetSingleLeftSec()
    local result = 0
    local config = ConfigManager.Get(EConfigIndex.t_activity_time,MsgEnum.eactivity_time.eActivityTime_threeToThree)
    if type(config.start_time) == "table" then
        local nowTime = system.time()
        local nowData = os.date('*t', nowTime)
        local duration = config.continue_time;
        for i, v in ipairs(config.start_time) do
            local beginTime = os.time({year=nowData.year, month=nowData.month, day=nowData.day, hour=v.h, min=v.i})
            local endTime = beginTime + duration
            if beginTime <= nowTime and endTime >= nowTime then
                result = endTime - nowTime
                break;
            end
        end
    end
    return result;
end

function QingTongJiDi:GetTimes()
	-- local _number = g_dataCenter.player:GetFlagHelper():GetStringFlag(self.systemId);
	-- _number = _number or "d=0";
	-- local _curTimes = PublicFunc.GetActivityCont(_number,"d") or 0;
	self.curTimes = self.curTimes or 0;
	local times = self.MaxTimes-self.curTimes;
	if times < 0 then
		times = 0;
	end
	return times,self.MaxTimes;
end

function QingTongJiDi:GetMaxSoul()
	return self.MaxSoul;
end

-- function QingTongJiDi:GetStar()
-- 	local star = 1;
-- 	for i=1,#gd_qing_tong_ji_di_rank do
-- 		local cfg = gd_qing_tong_ji_di_rank[i];
-- 		local leastWinPoint = cfg.win_point;
-- 		local leastRank = cfg.rank;
-- 		if leastRank == -1 or self.rankNum ~= 0 or self.rankNum <= leastRank then
-- 			if leastWinPoint <= self.winPoint then
-- 				star = i;
-- 			end
-- 		end
-- 	end
-- 	return star;
-- end

function QingTongJiDi:GetIntegral()
	return self.integral;
end

function QingTongJiDi:GetRankNum()
	return self.rankNum;
end

function QingTongJiDi:GetWinNum()
	return self.winNum;
end

function QingTongJiDi:GetKillNum()
	return self.killNum;
end

function QingTongJiDi:GetDeadNum()
	return self.deadNum;
end

function QingTongJiDi:GetCurTimes()
	return self.curTimes;
end

function QingTongJiDi:GetCurTime()
	return self.curTime;
end

-- function QingTongJiDi:GetOpenHero()
-- 	return self.openHero or {};
-- end

function QingTongJiDi:GetPlayerRoom()
	return self.playerRoom;
end

function QingTongJiDi:GetPlayerVs()
	return self.playerVs or {};
end

function QingTongJiDi:GetPlayerMatch()
	return self.playerMatch or {};
end

function QingTongJiDi:IsPlayerLeftSide()
	local leftSide = true;
	local playerName = g_dataCenter.player:GetName();
	for i, v in ipairs(self:GetShowFighter()) do
		if v.owner_name == playerName then
			leftSide = (i < 4);
			break
		end
	end
	return leftSide;
end

function QingTongJiDi:SetTeamSoulValue(campFlag, value)
	self.teamSoulValue[campFlag] = value
end

function QingTongJiDi:GetTeamSoulValue(campFlag)
	if campFlag then
		return self.teamSoulValue[campFlag]
	end
	return self.teamSoulValue[1], self.teamSoulValue[2];
end

function QingTongJiDi:GetKillInfoList()
	return self.killInfoList or {}
end

function QingTongJiDi:GetReliveTime()
	return self.reliveTime or {}
end

function QingTongJiDi:GetStartTime()
	return self.startTime;
end

function QingTongJiDi:GetCurState()
	return self.curState;
end

function QingTongJiDi:GetRoomId()
	return self.roomId;
end

function QingTongJiDi:GetTop3Player()
	-- test data
	-- local data = {}
	-- data[1] = {playerid="1",name="wanjia1",vip=5,integral=999,image=30002008}--30005011 jm 30053002 bfjm 30002008 tl 30010013 pzz
	-- data[2] = {playerid="2",name="wanjia1",vip=0,integral=849,image=30016002}
	-- data[3] = {playerid="3",name="wanjia1",vip=1,integral=681,image=30019510}
	-- return data

	return self.top3player or table.empty()
end

function QingTongJiDi:SetReliveTime(fightGid, reliveTime)
	if nil == self.reliveTime then
		self.reliveTime = {}
	end
	local time = tonumber(reliveTime) or 0 -- 单位毫秒
	self.reliveTime[fightGid] = math.floor(time / 1000)
	local obj = ObjectManager.GetObjectByGID(fightGid)
	if obj then
		PublicFunc.msg_dispatch(SceneEntity.CheckReborn, obj:GetName(), time/1000 - system.time() )
	end
end

function QingTongJiDi:SetIntegralAwards(id)
	self.integralAwards[id] = true;
end

function QingTongJiDi:SetTop3Player(topInfo)
	if topInfo then
		self.top3player = {}
		for i, v in ipairs(topInfo) do
			table.insert(self.top3player, QTJDTopInfo:new(v))
		end
	end
end

function QingTongJiDi:gc_three_to_three_state(result,ttt)
	self.integralAwards = {}
	for i, v in ipairs(ttt.integral_awards) do
		self.integralAwards[v] = true
	end
	self.integral = ttt.integral;
	self.curTimes = ttt.challenge_times;
	-- self.openHero = ttt.open_role;
	self.rankNum = ttt.rank or 0;
	self.winNum = ttt.winCount or 0;
	self.killNum = ttt.killCount or 0;
	self.deadNum = ttt.deadCount or 0;
	self.curState = ttt.cur_state;
	self.curTime = tonumber(ttt.cur_time);
	self.curSeason = ttt.curSeason or 0;

	self:SetTop3Player(ttt.topInfo)

	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_3V3)
end

function QingTongJiDi:gc_ready_finish(listMatchInfo)
	self.playerMatch = {}
	for i, v in pairs(listMatchInfo) do
		table.insert(self.playerMatch, QTJDMatchPlayer:new(v))
	end
	self:SetStage(2) --进入准备确认
end

function QingTongJiDi:gc_select_role(roomId, roleId)
	self.roomId = roomId
end

function QingTongJiDi:gc_sure_select_role(roomId, roleId)
	self.roomId = roomId
end

function QingTongJiDi:gc_update_select_role(vsInfo)
	if self.playerVs == nil then
		self.playerVs = {QTJDVsPlayer:new(vsInfo)}
	else
		for i, v in pairs(self.playerVs) do
			if v.playerid == vsInfo.playerid then
				self.playerVs[i] = QTJDVsPlayer:new(vsInfo);
				break;
			end
		end
	end

	if self:GetStage() == 3 and #self.playerVs > 0 then
		local allConfirm = true
		for i, v in pairs(self.playerVs) do
			if v.state ~= 1 then
				allConfirm = false
				break;
			end
		end
		if allConfirm then
			self:SetStage(4) -- 准备进入战斗
		end
	end
end

function QingTongJiDi:gc_update_room_state(roomId, listRoomInfo)
	self.roomId = roomId
	self.playerRoom = {}
	for i, v in pairs(listRoomInfo) do
		table.insert(self.playerRoom, QTJDRoomPlayer:new(v))
	end
end

-- function QingTongJiDi:gc_cancel_match(playerid)
-- 	for i, v in pairs(self.playerRoom or {}) do
-- 		if v.playerid == playerid then
-- 			return table.remove(self.playerRoom, i)
-- 		end
-- 	end
-- end

function QingTongJiDi:gc_match_finish(listVsInfo, startTime, roomId)
	self.roomId = roomId
	self.playerVs = {}
	for i, v in ipairs(listVsInfo) do
		table.insert(self.playerVs, QTJDVsPlayer:new(v))
	end
	self.startTime = startTime;
	self:SetStage(3)	--进入角色选取

	--清除匹配阶段数据
	self.playerMatch = nil

	--清除上一次战斗数据
	self.killInfo = {}
	self.reliveTime = {}
end

function QingTongJiDi:gc_enter_three_to_three(result, playerid)
	if result == 0 and self.playerMatch then
		local allEnter = true
		for k, v in pairs(self.playerMatch) do
			if v.playerid == playerid then
				v.enterState = 1
			end
			-- if allEnter and v.enterState == 0 then
			-- 	allEnter = false
			-- end
		end
		-- if allEnter then
		-- 	self:SetStage(3)
		-- end
	end
end

function QingTongJiDi:gc_exit_not_enter_game(playeridList, restartMatch)
	self.playerMatch = nil
end

function QingTongJiDi:gc_update_killinfo(info)
    if info == nil then return end
    self.killInfo = {}
    for k,v in pairs(info) do
        self.killInfo[v.gid] = v
    end
    
    if GetMainUI() and GetMainUI():GetThreeToThree() then
	    GetMainUI():GetThreeToThree():UpdateScoreData(self:GetScoreData())
    end
end

function QingTongJiDi:gc_team_room(result, ntype)
	if result == 0 then
		if ntype == 0 then
			self:SetStage(1)
		elseif ntype == 1 then
			self:SetStage(0)
		end
	end
end

function QingTongJiDi:gc_update_soul_value(leftValue, rightValue, killInfoList)
	self.teamSoulValue[1] = leftValue
	self.teamSoulValue[2] = rightValue
	self.killInfoList = killInfoList
end

function QingTongJiDi:SetStage(stage)
	self.stage = stage;
end

function QingTongJiDi:GetStage()
	return self.stage;
end

function QingTongJiDi:SetEnterType(ntype)
	self.enterType = ntype
end

function QingTongJiDi:GetEnterType()
	return self.enterType
end

function QingTongJiDi:GetKillInfo()
	return self.killInfo or {};
end

function QingTongJiDi:GetScoreData()
	local killCnt, deadCnt = 0, 0
    for k,v in pairs(self:GetKillInfo()) do
        killCnt = v.totalKill
        deadCnt = v.totalDead
        break;
    end
	return killCnt, deadCnt;
end

function QingTongJiDi:GetShowFighter()
	return self.members or {};
end

function QingTongJiDi:SetShowFighter(members)
	self.members = members or {};
end

function QingTongJiDi:SetFightResult(fightResult, awards)
	--app.log(table.tostring({fightResult, awards}));
	self.fightResult = fightResult;
	self.awards = awards;
end

function QingTongJiDi:EndGame()
	local fightResult = self.fightResult;
	if fightResult == nil then
		return;
	end
    local obj = g_dataCenter.fight_info:GetCaptain();
    if obj then

        local players = fightResult.players;
        --比分
        local left_score = fightResult.leftTotalKill or 0
        local right_score = fightResult.rightTotalKill or 0

        local left = {player = Player:new(), cards = {}}
        local right = {player = Player:new(), cards = {}}
        local player = {left = left, right = right};
        local show_pos_index = 0 
        local my_player_name = g_dataCenter.player:GetName()
        for i = 1, 3 do
        	left.player:UpdateData({name = players[i].name, level = players[i].level})
        	left.cards[i] = CardHuman:new({number = players[i].roleId, level = players[i].level});
            local temp = {
                name = players[i].name,
                kill_num = players[i].kill, 
                dead_num = players[i].dead,
                add_point = players[i].integral or 0,
            }
            left.cards[i].__extData = temp

        	left.soul = self.teamSoulValue[1] / self.MaxSoul--百分比魂值
        	-- left_score = left_score + players[i].kill

        	right.player:UpdateData({name = players[i+3].name, level = players[i+3].level})
            right.cards[i] = CardHuman:new({number = players[i+3].roleId, level = players[i+3].level});
            local temp = {
                name = players[i+3].name,
                kill_num = players[i+3].kill, 
                dead_num = players[i+3].dead,
                add_point = players[i+3].integral or 0,
            }
            right.cards[i].__extData = temp

        	right.soul = self.teamSoulValue[2] / self.MaxSoul--百分比魂值
            -- right_score = right_score + players[i+3].kill

            if my_player_name == players[i].name then
        		show_pos_index = i
        	elseif my_player_name == players[i+3].name then
        		show_pos_index = i + 3
        	end
        end

        --失败
        local flag = 1;
        --胜利
        if obj:GetCampFlag() == fightResult.winFlag then
            flag = 0;
        --平局
        elseif fightResult.winFlag == 0 then
            flag = 2;
        end

        local fightResult = {isWin = nil, leftCount = left_score, rightCount = right_score};
		if flag == 0 then
			fightResult.isWin = true;
			if show_pos_index > 3 then
				fightResult.isWin = false
			end
		elseif flag == 1 then
			fightResult.isWin = false;
			if show_pos_index > 3 then
				fightResult.isWin = true
			end
		end
		
		CommonBattle3v3.Start("3V3", player, fightResult, true)
		CommonBattle3v3.SetFinishCallback(QingTongJiDi.PlayAward, self);
    end
end

function QingTongJiDi:PlayAward()
	if self.awards and Utility.getTableEntityCnt(self.awards) > 0 then
		CommonAward.Start(self.awards);
		CommonAward.SetFinishCallback(QingTongJiDi.Exit, self);
	else
		self:Exit();
	end
end

function QingTongJiDi:Exit()
	local fightManager = FightScene.GetFightManager();
	if fightManager then
		fightManager:FightOver(true);
	end
end

function QingTongJiDi:IsHaveTimes()
	return self.MaxTimes > self.curTimes;
end

function QingTongJiDi:IsOpen()
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_threeToThree) then
		return false
	end
	if not PublicFunc.InActivityTime(MsgEnum.eactivity_time.eActivityTime_threeToThree) then
		return false
	end
	return self:IsHaveTimes();
end