------------------------- 亏库利亚玩家排行对象 ---------------------------
KklyRankPlayer = Class('KklyRankPlayer')

function KklyRankPlayer:Init(data)
	self.playerid	= data.playerid or 0
	self.playerName	= data.szName or 0
	self.point		= data.nPoint or 0
	self.ranking 	= data.nRankIndex or 0
	self.heroCards 	= data.vecCardsRole or {}
	self.equipCards = data.vecCardsEquip or {}
	self.playerLevel = data.playerLevel;
	self.guildName = data.guildName;
	self.vipLevel = data.vipLevel;
	self.image = data.image;
	return self
end

------------------------- 亏库利亚数据对象 ---------------------------
KuiKuLiYa = Class("KuiKuLiYa",PlayMethodBase)

function KuiKuLiYa:ClearData(data)
	self._super.ClearData(self,data);

	self.openFloor = 1;
	self.myRank = 0;
	local number = ConfigManager.Get(EConfigIndex.t_activity_time,MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa).number_restriction;
	self.times = number.d;
	self.finishNumber = 0;
	self.buyTimes = 0;
	self.maxFloor = #ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
	-- self.floorData = {};
	-- self.thirdTimes = 0;
end

function KuiKuLiYa:_GameResult(isWin, awards,  param)
	local data = self._super._GameResult(self,isWin, awards,  param);

	-- local battle = {};
	-- battle.players = {};
	-- local left_cards = {};
	-- local right_cards = {};
	-- local hurdle_info = ConfigManager.Get(EConfigIndex.t_kuikuliya_hurdle_info,self.challengeFloor);
	-- for i=1,3 do
	-- 	local monster = ConfigManager.Get(EConfigIndex.t_monster_property,hurdle_info["monster"..i]);
	-- 	left_cards[i] = g_dataCenter.package:find_card(1,self.HeroTeam[i]);
	-- 	if monster then
	-- 	right_cards[i] = CardHuman:new({number=monster.id,level=monster.level});
	-- end
	-- end
	-- battle.players.left = {player=g_dataCenter.player,cards=left_cards};
	-- battle.players.right = {player=nil,cards=right_cards};
	-- local friend_num = FightRecord.GetKillBossNum(2);
	-- local enemy_num = FightRecord.GetKillBossNum(1);
	-- battle.fightResult = {isWin = isWin,leftCount=friend_num,rightCount=enemy_num};
	-- battle.battleName = "奎库利亚";
	-- data.battle = battle;
	return data;
end

function KuiKuLiYa:GameResult(isWin, awards,  param)
	if isWin == 0 then
		CommonKuikuliyaWinUI.Start();
		CommonKuikuliyaWinUI.SetEndCallback(FightScene.ExitFightScene);
	else
		PlayMethodBase.GameResult(self, isWin, awards,  param);
	end
end
-----------------消息-----------
function KuiKuLiYa:SetCnt(myRank,myPoint,floor,buyTimes,thirdTimes,saodangStartTime)
	self.myRank = myRank;
	-- self.myPoint = myPoint;
	-- self.openFloor = floor+1;
	self.buyTimes = buyTimes;
	-- self.thirdTimes = thirdTimes;
	self.bgetDayReward = bgetDayReward;
	self.sweepStartTime = saodangStartTime;
	-- self.rewardfloor = rewardfloor;
--	app.log("SetCnt .. "..table.tostring({myRank,myPoint,floor,buyTimes,thirdTimes,saodangStartTime}))
end
function KuiKuLiYa:gc_sync_all_floor(vecfloorData)
	self._hasData = true;
	self.floorData = {};
	for k,v in pairs(vecfloorData) do
		self.floorData[v.floorIndex] = v;
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge_goods);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge_start);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge);
	-- app.log("#lhf kuikuliya#"..table.tostring(self.floorData));
end
function KuiKuLiYa:gc_update_floor_data(ntype, data)
	if not self.floorData then
		self.floorData = {};
	end
	self.floorData[data.floorIndex] = data;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge_goods);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge_start);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge);
end
function KuiKuLiYa:Tostring()
	local param = {};
	param[1] = tostring(self.hurdle_id);
	param[2] = tostring(self.challengeFloor);
	param[3] = self:GetIsAutoFight()
	return param;
end

function KuiKuLiYa:GetIsAutoFight()
	return PublicFunc.GetIsAuto(self.hurdle_id)
end

function KuiKuLiYa:EndGame()
	local star = FightRecord.GetStar();
	local isWin = 1;
	if star > 0 then
		isWin = 0;
	end
	local use_time = tostring(FightScene.GetFightManager():GetFightUseTime())
    local param = {self.hurdle_id,self.challengeFloor,use_time, self:GetIsAutoFight() }
	msg_activity.cg_leave_activity(self.play_method_id,isWin,param);
end
function KuiKuLiYa:BeginGame(result, cf)
    uiManager:PopUi(nil,true);
    AudioManager.Stop(nil, true);
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight);
	self._super.BeginGame(self,result, cf);
end

------------------ui------------
function KuiKuLiYa:GetSweepStartTime()
	return tonumber(self.sweepStartTime);
end
function KuiKuLiYa:GetTimes()
	local number = g_dataCenter.player:GetFlagHelper():GetStringFlag(MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa);
	number = number or "d=0";
	self.finishNumber = PublicFunc.GetActivityCont(number,"d");
    -- 玩法限制作弊 (奎库利亚 -- 最大开启次数)
    if g_dataCenter.gmCheat:noPlayLimit() then
        return self.times
    end

	return self.times-self.finishNumber+self:GetVipBuyTimes()+self:GetVipFreeTimes(),self.finishNumber;
end
function KuiKuLiYa:GetTotalTimes()
	return self.times+self:GetVipBuyTimes()+self:GetVipFreeTimes();
end
function KuiKuLiYa:GetCanBuyTimes()
	return self:GetTotalTimes()-self.finishNumber;
end
function KuiKuLiYa:GetVipBuyTimes()
	local vipTimes = 0;
	local vip_data = g_dataCenter.player:GetVipData();
	if vip_data then
		vipTimes = vip_data.kuikuliya_buy_times;
	end
	return vipTimes;
end
function KuiKuLiYa:GetBuyTimes()
	return self.buyTimes or 0;
end
function KuiKuLiYa:GetBuyTimesCost()
	local cfg = ConfigManager.Get(EConfigIndex.t_kuikuliya_buy_cost,self:GetBuyTimes()+1);
	return cfg.cost,cfg.buy_count;
end
function KuiKuLiYa:GetVipFreeTimes()
	local vipTimes = 0;
	local vip_data = g_dataCenter.player:GetVipData();
	if vip_data then
		vipTimes = vip_data.kuikuliya_free_times;
	end
	return vipTimes;
end

function KuiKuLiYa:GetOpenFloor()
	if self.floorData then
		local num = #self.floorData;
		if num == 0 then
			return 0;
		end
		if self.floorData[num].isGetBox then
			return num;
		else
			return num-1;
		end
	else
		return 0;
	end
end

function KuiKuLiYa:GetMyRank()
	return self.myRank
end

function KuiKuLiYa:GetFloorData(floor_id)
	if self.floorData then
		if floor_id <= self.maxFloor then
			return self.floorData[floor_id];
		else
			return self.floorData[#self.floorData];
		end
	else
		return {};
	end
end

function KuiKuLiYa:GetCurFloor()
	if self.floorData then
		for k,v in ipairs(self.floorData) do
			if not v.bPass or not v.isGetBox then
				return k,v;
			end
		end
		if #self.floorData+1 <= self.maxFloor then
			return #self.floorData+1,{};
		else
			return #self.floorData,self.floorData[#self.floorData];
		end
	else
		return 1,{};
	end
end

function KuiKuLiYa:IsExLimit(floor)
	local lvLimit = true;
	local cfg = ConfigManager.Get(EConfigIndex.t_kuikuliya_hurdle_info,floor);
	if cfg and (not cfg.level or cfg.level <= g_dataCenter.player:GetLevel()) then
	-- if cfg and (not cfg.level or cfg.level <= 1) then
		lvLimit = false;
	end
	return lvLimit;
end

function KuiKuLiYa:SetChallengeFloor(floor)
	self.challengeFloor = floor;
end

function KuiKuLiYa:GetRewardFloor()
	return self.rewardfloor;
end

function KuiKuLiYa:IsOpen()
	local open_lv = ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa).open_level;
	if open_lv > g_dataCenter.player.level then
		return Gt_Enum_Wait_Notice.Player_Levelup
	else
		return self:CheckState();
	end
end

function KuiKuLiYa:CheckState()
	if self:CheckGoodsState() == Gt_Enum_Wait_Notice.Success or self:CheckStartState() == Gt_Enum_Wait_Notice.Success or self:CanGetFloorReward() then
		return Gt_Enum_Wait_Notice.Success;
	end 
	return Gt_Enum_Wait_Notice.Forced;
end

function KuiKuLiYa:CheckGoodsState()
	if self._hasData then
		if self:CanGetClimbReward() then
			return Gt_Enum_Wait_Notice.Success;
		end
		return Gt_Enum_Wait_Notice.Forced;
	else
		if self._goodsRedPointState then
			return Gt_Enum_Wait_Notice.Success;
		else
			return Gt_Enum_Wait_Notice.Forced;
		end
	end
end

function KuiKuLiYa:CheckStartState()
	if self._hasData then
		if self:CanReset() or self:CanSweep() then
			return Gt_Enum_Wait_Notice.Success;
		end
		return Gt_Enum_Wait_Notice.Forced;
	else
		if self._startRedPointState then
			return Gt_Enum_Wait_Notice.Success;
		else
			return Gt_Enum_Wait_Notice.Forced;
		end
	end
end

function KuiKuLiYa:CanReset()
	local flg = false;
	if 0 < self:GetTimes() then
		flg = true;
	end
	return flg;
end
function KuiKuLiYa:CanFreeReset()
	local flg = false;
	if 0 < self:GetTimes()-self:GetVipBuyTimes() then
		flg = true;
	end
	return flg;
end

function KuiKuLiYa:CanSweep()
	local flg = false;
	if self._hasData then
		local curFloorData = self.floorData[#self.floorData];
		if self:GetOpenFloor() >= self:GetCurFloor() and not curFloorData.bPass then
			flg = true;
		end
	end
	return flg;
end

function KuiKuLiYa:CanGetClimbReward()
	local flg = false;
	if self.floorData then
		for k,v in pairs(self.floorData) do
			if v.isGetClimbReward == false then
				flg = true;
				break;
			end
		end
	end
	return flg;
end

function KuiKuLiYa:CanGetFloorReward()
	local flg = false;
	if self.floorData then
		local curFloorData = self.floorData[#self.floorData];
		if curFloorData and curFloorData.bPass and not curFloorData.isGetBox then
			flg = true;
		end
	end
	return flg;
end

function KuiKuLiYa:SetStartRedPoint(state)
	self._startRedPointState = state;
end

function KuiKuLiYa:SetGoodsRedPoint(state)
	self._goodsRedPointState = state;
end
