ExpeditionTrialData = Class("ExpeditionTrialData",PlayMethodBase)

local rdText = {"哈","都","秒","明","杨","天","霞","风","力","亚","奴","酱","殇","古","偶","萌","美","佳","狂","星","红","痕","幕","邪","众","娥","爱","菲","米","娜","姬","雄","盖","宏","晴","明"}

function ExpeditionTrialData:Init(data)
	PlayMethodBase.Init(self);
	self.initState = false;
	self.demage = 0;
	self.insprireTimes = 0;
	self.reliveTime = nil;
	self.initReqRank = false;
	self.isJoined = false;
	self.hurdle_id = 60123005;
	self.allLevelData = {};
	self.allLevelConfig = {};
	self.callBackList = {};
	self.allChallengeLevel = {};
	self.allPosList = {};
end
 
function ExpeditionTrialData:Reset()
	self.demage = 0;
	self.insprireTimes = 0;
	self.reliveTime = nil;
	self.lastRankInfo = nil;
	self.rankInfo = nil;
	self.killInfo = nil;
	self.isJoined = false;
	self.allLevelData = {};
	self.allLevelConfig = {};
	self.callBackList = {};
	self.allChallengeLevel = {};
	self.allPosList = {};
	self.isCheckedServer = false;
	self.roleStatesList = nil;
	TrialScene.LastRolePos = nil;
	--local roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have, self.package, self:get_Team())
	local roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All, self.package, self:get_Team())
	for k,v in pairs(roleStatesList) do 
		v:SetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial,nil);
	end
	self.allInfo = nil;
	if g_dataCenter.trial:CanEnter() then 
		g_dataCenter.trial:initServerData();
	end 
end
--设置某一页关卡路径点位置
function ExpeditionTrialData:set_posList(posList,page)
	self.allPosList[page] = posList;
end 
--获取某一页关卡路径点位置
function ExpeditionTrialData:get_posList(page)
	return self.allPosList[page]
end 

function ExpeditionTrialData:CanEnter()
	local cf = ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_trial);
	if g_dataCenter.player.level < cf.open_level then 
		return false;
	else 
		return true;
	end
end 

function ExpeditionTrialData:initAllLevelConfig()
	local challengeIndex = 0;
	for i = 1,1000 do 
		local cf = ConfigManager.Get(EConfigIndex.t_expedition_trial_level,i);
		if cf == nil then 
			break;
		end
		self.allLevelData[cf.page] = self.allLevelData[cf.page] or {};
		self.allLevelData[cf.page][cf.id] = cf;
		cf.index = table.getall(self.allLevelData[cf.page]);
		--self.allLevelData[cf.page]["Index"..tonumber(cf.index)] = cf;
		cf.names = {
			rdText[math.random(1,#rdText)]..tostring(rdText[math.random(1,2*#rdText)] or "")..tostring(rdText[math.random(1,2*#rdText)] or "")..tostring(rdText[math.random(1,2*#rdText)] or ""),
			rdText[math.random(1,#rdText)]..tostring(rdText[math.random(1,2*#rdText)] or "")..tostring(rdText[math.random(1,2*#rdText)] or "")..tostring(rdText[math.random(1,2*#rdText)] or ""),
			rdText[math.random(1,#rdText)]..tostring(rdText[math.random(1,2*#rdText)] or "")..tostring(rdText[math.random(1,2*#rdText)] or "")..tostring(rdText[math.random(1,2*#rdText)] or ""),
		}
		self.allLevelConfig[cf.id] = cf;
		if cf.type == 1 then 
			challengeIndex = challengeIndex + 1;
			self.allChallengeLevel[cf.id] = cf;
			self.allChallengeLevel["Index"..tostring(challengeIndex)] = cf;
			cf.challengeIndex = challengeIndex;
			
		else 
			cf.challengeIndex = challengeIndex;
		end
	end
	for k,page in pairs(self.allLevelData) do 
		local tempPage = {};
		for s,lvd in pairs(page) do 
			tempPage["Index"..tostring(lvd.index)] = lvd;
			tempPage[s] = lvd;
		end
		self.allLevelData[k] = tempPage;
	end
end 

function ExpeditionTrialData:calAllBuffEffect()
	self.buffEffectData = {};
	for k,v in pairs(self.allInfo.buff_info) do 
		local id = v;
		local cf = ConfigManager.Get(EConfigIndex.t_expedition_trial_buff,id);
		if cf == nil then 
			app.log("找不到id = "..tostring(id).."的远征buff,是否修改了expedition_trial_buff表？");
		end
		local name = gs_string_property_name[cf.type];
		self.buffEffectData[cf.type] = self.buffEffectData[cf.type] or 0;
		self.buffEffectData[cf.type] = self.buffEffectData[cf.type] + cf.effect;
	end
end 

function ExpeditionTrialData:serverChangeCurLevel(levelId)
	--app.log("服务器更改当前关卡id : "..tostring(levelId));
	self.allInfo.cur_expedition_trial_level = levelId;
	PublicFunc.msg_dispatch("trial.set_all_expedition_trial_info");
end 

function ExpeditionTrialData:initServerData()
	if not self.isCheckedServer then 
		msg_expedition_trial.cg_request_expedition_trial_info();
	else 
		if self.allInfo ~= nil then 
			PublicFunc.msg_dispatch("trial.set_all_expedition_trial_info");
		end
	end
	self.isCheckedServer = true;
end 

function ExpeditionTrialData:get_index()
	if self.allInfo == nil then 
		app.log("no allInfo");
	end 
	local cf = self.allLevelConfig[self.allInfo.cur_expedition_trial_level]
	if cf == nil then 
		if self.allInfo.cur_expedition_trial_level > #self.allLevelConfig then 
			cf = self.allLevelConfig[#self.allLevelConfig];
		end
	end
	return cf.index 
end 

function ExpeditionTrialData:GetSavedEnterInfo()
	if file.exist("trial_"..tostring(g_dataCenter.player.playerid)) then 
		local fileobj = file.open("trial_"..tostring(g_dataCenter.player.playerid),3);
		self.LastEnterDate = fileobj:read_all_text();
		self.LastEnterDate = string.sub(self.LastEnterDate,1,8);
		fileobj:close();
	else 
		self.LastEnterDate = "";
	end
end 

function ExpeditionTrialData:SaveEnterInfo()
	local fileobj = file.open("trial_"..tostring(g_dataCenter.player.playerid),2);
	fileobj:write_string(os.date("%x"));
	fileobj:close();
end 

function ExpeditionTrialData:IsOpen()
	if ConfigManager.Get(EConfigIndex.t_play_vs_data, MsgEnum.eactivity_time.eActivityTime_trial).open_level > g_dataCenter.player.level then 
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end 
	if self.allInfo ~= nil then 
		if self.allInfo.cur_expedition_trial_level == 1 then 
			self:GetSavedEnterInfo();
			if self.LastEnterDate ~= os.date("%x") then
				return Gt_Enum_Wait_Notice.Success;
			end
		end 
		
		local pointAwardNum = TrialExchangeAward.GetMaxRewardNum();
		local canGetPointAward = Gt_Enum_Wait_Notice.Forced;
		if pointAwardNum > self.RewardGotNum then 
			canGetPointAward = Gt_Enum_Wait_Notice.Success;
		end 
		
		local cf = self.allLevelConfig[self.allInfo.cur_expedition_trial_level];
		if cf == nil then 
			app.log("self.allInfo = "..table.tostring(tostring(self.allInfo)));
			app.log("找不到cur_expedition_trial_level = "..tostring(self.allInfo.cur_expedition_trial_level).."的远征关卡配置");
			return Gt_Enum_Wait_Notice.Forced;
		else 
			if cf.type == 2 then 
				if not self.allInfo.finish then 
					return Gt_Enum_Wait_Notice.Success;
				else 
					return canGetPointAward;
				end
			else 
				return canGetPointAward;
			end
		end
	else 
		self:initServerData();
		return Gt_Enum_Wait_Notice.Forced;
	end
end 

function ExpeditionTrialData:serverBuffList(info)
	self.buffInfo = info;
	PublicFunc.msg_dispatch("trial.serverBuffList");
end 

function ExpeditionTrialData:serverPayBoxReward(info)
	self.payBoxReward = info;
end 

function ExpeditionTrialData:serverOpenPayBox()
	PublicFunc.msg_dispatch("trial.serverOpenPayBox");
end 

function ExpeditionTrialData:openAllPayBox(times)
	msg_expedition_trial.cg_batch_buy_expedition_trial_treasure_box(times)
end 

function ExpeditionTrialData:allBuyRst()
	PublicFunc.msg_dispatch("trial.allBuyRst");
end 

function ExpeditionTrialData:buy_buff(levelId,buffIndex,dataid)
	--app.log("buy Buff: levelId = "..tostring(levelId)..",buffIndex = "..tostring(buffIndex)..",dataid = "..tostring(dataid));
	msg_expedition_trial.cg_buy_expedition_trial_buff(levelId,buffIndex,dataid);
end 

function ExpeditionTrialData:set_all_expedition_trial_info(info)
	--app.log("获取allInfo");
	-- app.log("EXPEDITIONTRIALDATA"..table.tostring(info));
	if self.allInfo ~= nil and self.allInfo.cur_expedition_trial_level ~= info.cur_expedition_trial_level then 
		self:Reset();
		PublicFunc.msg_dispatch(msg_expedition_trial.gc_expedition_trial_reset);
		--app.log("新的一天开始了，远征试炼重置");
	end 
	if info.cur_expedition_trial_level == 0 then 
		app.log("远征数据错误："..table.tostring(info));
	end 
	self.scoreRate = ConfigManager.Get(EConfigIndex.t_discrete,83000195).data;
	self.allInfo = info;
	self:onPointsRewardFlagGet(self.allInfo.points_reward_flag1,self.allInfo.points_reward_flag2,self.allInfo.points_reward_flag3);
	if self.allLevelData == nil or #self.allLevelData == 0 then 
		self:initAllLevelConfig();
	end  
	self:calAllBuffEffect();
	local levelCanSweep = ConfigManager.Get(EConfigIndex.t_expedition_trial_level_sweep,g_dataCenter.player.level).level_can_sweep;
	-- local vipCanSweep = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip).expedition_trial_sweep_level_limit or 0;
	local sweepFunclevelLimit = ConfigManager.Get(EConfigIndex.t_expedition_trial_discrete,4).value;
	-- local vip_config = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip);
	local vip_config = g_dataCenter.player:GetVipData();
	if vip_config then
		vip_config = vip_config[g_dataCenter.player.vip_star];
	end
	local vipCanSweep = 0;
	if vip_config then
		vipCanSweep = vip_config.expedition_trial_sweep_level_limit or 0;
	end
	local lastCanSweep = 0;
	if vipCanSweep > 0 and g_dataCenter.player.level >= sweepFunclevelLimit then 
		if self.allInfo.max_pass_expedition_trial_level > 0 then 
			self.canSweepLevel = math.min(vipCanSweep,self.allLevelConfig[self.allInfo.max_pass_expedition_trial_level].challengeIndex);
		else
			self.canSweepLevel = 0;
		end 
	else 
		if self.allInfo.last_pass_expedition_trial_level > 0 then 
			local cfPercent = ConfigManager.Get(EConfigIndex.t_expedition_trial_discrete,1);
			self.canSweepLevel = math.floor(self.allLevelConfig[self.allInfo.last_pass_expedition_trial_level].challengeIndex * cfPercent.value/100);	
		else
			self.canSweepLevel = 0;
		end
	end
	
	PublicFunc.msg_dispatch("trial.set_all_expedition_trial_info");
	PublicFunc.msg_dispatch("trial.red_point_state")
end 

function ExpeditionTrialData:getPointReward(index)
	--app.log("去获取积分奖励：index= "..tostring(index));
	msg_expedition_trial.cg_get_expedition_trial_points_reward(index);
end 

local tb16to2 = {
["0"]={0,0,0,0},
["1"]={0,0,0,1},
["2"]={0,0,1,0},
["3"]={0,0,1,1},
["4"]={0,1,0,0},
["5"]={0,1,0,1},
["6"]={0,1,1,0},
["7"]={0,1,1,1},
["8"]={1,0,0,0},
["9"]={1,0,0,1},
a={1,0,1,0},
b={1,0,1,1},
c={1,1,0,0},
d={1,1,0,1},
e={1,1,1,0},
f={1,1,1,1},
A={1,0,1,0},
B={1,0,1,1},
C={1,1,0,0},
D={1,1,0,1},
E={1,1,1,0},
F={1,1,1,1}
}

function ExpeditionTrialData:onPointsRewardFlagGet(param1,param2,param3)
	app.log("收到服务器积分领取标志：param1 = "..param1..",param2 = "..param2..",param3 = "..param3);
	param1 = "0000000000000000"..param1;
	param2 = "0000000000000000"..param2;
	param3 = "0000000000000000"..param3;
	param1 = string.sub(param1,-16);
	param2 = string.sub(param2,-16);
	param3 = string.sub(param3,-16);
	local tbflag = {};
	local allParam = param1..param2..param3
	--[[容错处理，可能服务器发过来的标志没能成功转换成16进制字符串，这里容错处理一下让玩家不能领取奖励]]
	for i = 1,48 do 
		local b = string.sub(allParam,49-i,49-i);
		if tb16to2[b] == nil then 
			app.log("服务器发过来的远征积分奖励领取标志16进制字符串有错");
			param1 = "ffffffffffffffff";
			param2 = "ffffffffffffffff";
			param3 = "ffffffffffffffff";
			break;
		end
	end 
	for i = 1,16 do 
		local b = string.sub(param1,17-i,17-i);
		local offset = (i-1)*4
		tbflag[offset+1] = tb16to2[b][4];
		tbflag[offset+2] = tb16to2[b][3];
		tbflag[offset+3] = tb16to2[b][2];
		tbflag[offset+4] = tb16to2[b][1];
	end
	for i = 1,16 do 
		local b = string.sub(param2,17-i,17-i);
		local offset = (i-1)*4 + 63
		tbflag[offset+1] = tb16to2[b][4];
		tbflag[offset+2] = tb16to2[b][3];
		tbflag[offset+3] = tb16to2[b][2];
		tbflag[offset+4] = tb16to2[b][1];
	end
	for i = 1,16 do 
		local b = string.sub(param3,17-i,17-i);
		local offset = (i-1)*4 + 126
		tbflag[offset+1] = tb16to2[b][4];
		tbflag[offset+2] = tb16to2[b][3];
		tbflag[offset+3] = tb16to2[b][2];
		tbflag[offset+4] = tb16to2[b][1];
	end
	self.RewardGotNum = 0;
	for k,v in pairs(tbflag) do 
		if v == 1 then 
			self.RewardGotNum = self.RewardGotNum + 1;
		end
	end
	self.pointRewardFlags = tbflag;
	--PublicFunc.msg_dispatch("trial.serverGiveAward");
end 

function ExpeditionTrialData:serverRstPointsReward(reward)
	if reward and #reward > 0 then 
		CommonAward.Start(reward,1);
	end
end 

function ExpeditionTrialData:sweepTrial(isSweep)
	msg_expedition_trial.cg_decide_expedition_trial_sweep(isSweep);
end 

function ExpeditionTrialData:onServerSweepOver()
	app.log("服务器扫荡完成！");
	if self.isShowSweepAward == false then 
		if self.payBoxInfo ~= nil and #self.payBoxInfo > 0 then 
			TrialMultMysteryBox.popPanel(self.payBoxInfo);
		end
	end 
	self.allInfo.decide_expedition_trial_sweep = 1;
end 

function ExpeditionTrialData:set_battleData(roleE1,roleE2,roleE3,roleM1,roleM2,roleM3)
	self.battleRoleE1 = roleE1;
	self.battleRoleE2 = roleE2;
	self.battleRoleE3 = roleE3;
	self.battleRoleM1 = roleM1;
	self.battleRoleM2 = roleM2;
	self.battleRoleM3 = roleM3;
end 

function ExpeditionTrialData:get_todayScore()
	return self.allInfo.today_point;
end 

function ExpeditionTrialData:get_star()
	return self.allInfo.stars;
end 

function ExpeditionTrialData:set_StarNum(num)
	self.allInfo.stars = num;
	PublicFunc.msg_dispatch("trial.setStarNum");
end 

function ExpeditionTrialData:set_todayPoints(points)
	self.allInfo.today_point = points;
	PublicFunc.msg_dispatch("trial.setTodayPoints");
end 

function ExpeditionTrialData:set_diff(diff)
	self.allLevelConfig[self.allInfo.cur_expedition_trial_level].difficult = diff;
	self:getChangeInfoByLevelId(self.allInfo.cur_expedition_trial_level).select_difficulty = diff;
	PublicFunc.msg_dispatch("trial.updateChallengeInfo");
end 

function ExpeditionTrialData:GetIsAutoFight()
	local hurdle_id = self.allInfo.challenge_info[#self.allInfo.challenge_info].hurdle_id;
	return PublicFunc.GetIsAuto(hurdle_id)
end

function ExpeditionTrialData:get_levelData()
	if self.allInfo.cur_expedition_trial_level == 0 then 
		app.log("there is an error accour, expedition trial server rst an error trial level id: cur_expedition_trial_level -> 0,call lujian");
		return;
	end 
	local cf = self.allLevelConfig[self.allInfo.cur_expedition_trial_level]
	if self.allInfo.finish == true then 
		cf = self.allLevelConfig[#self.allLevelConfig];
	end
	return cf,self:getChangeInfoByLevelId(self.allInfo.cur_expedition_trial_level)
end 

function ExpeditionTrialData:getCurChallengeInfo()
	return self:getChangeInfoByIndex(self.allInfo.cur_expedition_trial_level);
end 

function ExpeditionTrialData:getLevelDataByIndex(index)
	return self:get_curPageData()["Index"..tostring(index)],self:getChangeInfoByIndex(index);
end 

function ExpeditionTrialData:initCurLevel(callBack)
	if self:checkHaveChangeInfo(self.allInfo.cur_expedition_trial_level) == false then 
		msg_expedition_trial.cg_trigger_expedition_trial_level(self.allInfo.cur_expedition_trial_level);
	end 
end 

function ExpeditionTrialData:SetMonsterCard(card)
	if card == nil or card.number == 0 then return false end

	local cf = ConfigManager.Get(EConfigIndex.t_expedition_trial_monster_property_scale, card.number);
	if cf == nil then
		app.log("远征 - 没有找到"..tostring(card.number).."的怪物属性缩放表，请检查配置")
		return false;
	end 
	
	local eteam = self:get_enemyTeam();
	local maxCard = {["property"] = {}};
	for kk,vv in pairs(eteam) do 
		for k,v in pairs(ENUM.EHeroAttribute) do 
			if vv.property[v] ~= nil then 
				if maxCard.property[v] == nil then 
					maxCard.property[v] = vv.property[v];
				else 
					if maxCard.property[v] < vv.property[v] then 
						maxCard.property[v] = vv.property[v];
					end
				end
			end 
		end 
	end 
	--计算属性缩放（非加成，仅缩放非0配置的属性）
	local scale_value = 0
	for k,v in pairs(ENUM.EHeroAttribute) do
		scale_value = cf[k] or 0
		if scale_value > 0 then
			local value = maxCard.property[v] or 0;
			card.property[v] = value * scale_value;
		end 
	end 
	card.isNotCalProperty = true
	card:CalNormalAttackProperty(card.property)

	return true
end 

function ExpeditionTrialData:serverRstTrialLevel(level)
	--[[if self.initLevelCall ~= nil then 
		self.initLevelCall();
	end
	self.initLevelCall = nil;--]]
	app.log("服务器返回奖励信息");
	local levelData = self.allLevelConfig[level];
	if levelData.type == 1 then 
		if levelData.use_cfg_diff ~= 0 then 
			local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
			if challengeInfo ~= nil then 
				self:set_diff(levelData.use_cfg_diff);
				TrialChooseRole.PopPanel(0,0);
			else 
				self:set_diff(levelData.use_cfg_diff)
				self.loadingId = GLoading.Show(GLoading.EType.ui);
				--msg_expedition_trial.get_challenge_info();
			end
		else 	
			TrialChooseDifficult.PopPanel();
		end 	
	elseif levelData.type == 2 then 
		if TrialScene.instance ~= nil then 
			Tween.pause(TrialScene.instance.modelPlayer);
		end 
		CommonAward.Start(self.normalReward,1);
		local function onRewardShowOver() 
			PublicFunc.msg_dispatch("trial.set_all_expedition_trial_info");
			if levelData.pay_treasure_box_drop_id ~= nil then 
				TrialSingleMysteryBox.popUp(level);
			else 
				if TrialScene.instance ~= nil then 
					Tween.continue(TrialScene.instance.modelPlayer);
				end 
			end 
		end
		CommonAward.SetFinishCallback(onRewardShowOver);
	elseif levelData.type == 3 then 
		TrialBuyBuff.PopPanel(self.buffInfo);
	end
	PublicFunc.msg_dispatch("trial.updateChallengeInfo");
end 

function ExpeditionTrialData:serverOpenNormalBox(reward)
	self.normalReward = reward;
end 

function ExpeditionTrialData:serverSweepOpenNormalBox(reward)
	app.log("服务器返回扫荡奖励信息");
	CommonAward.Start(reward,1);
	self.isShowSweepAward = true;
	local function onRewardShowOver() 
		self.isShowSweepAward = false;
		if self.payBoxInfo ~= nil and #self.payBoxInfo > 0 then 
			TrialMultMysteryBox.popPanel(self.payBoxInfo);
		end
	end
	CommonAward.SetFinishCallback(onRewardShowOver);
end 

function ExpeditionTrialData:openPayBox(level,times,callBack)
	self.openPayBoxCall = callBack
	msg_expedition_trial.cg_buy_expedition_trial_treasure_box(level,times)
end 

function ExpeditionTrialData:serverPayBoxInfo(discount,discountTimes,payBoxInfo)
	self.discount = discount;
	self.discountTimes = discountTimes;
	self.payBoxInfo = payBoxInfo;
end 

function ExpeditionTrialData:serverOpenPayBoxReward(reward)
	CommonAward.Start(reward,1);
	CommonAward.SetFinishCallback(nil);
end 

function ExpeditionTrialData:serverAddBuff(buffId)
	--app.log("服务器新增一条buff : "..tostring(buffId))
	table.insert(self.allInfo.buff_info,buffId);
	--app.log("当前allInfo数据："..table.tostring(self.allInfo));
	self:calAllBuffEffect();
end 

function ExpeditionTrialData:gotoNextLevel()
	if self.allLevelConfig[self.allInfo.cur_expedition_trial_level+1] ~= nil then 
		self.allInfo.cur_expedition_trial_level = self.allInfo.cur_expedition_trial_level + 1;
		--self:initCurLevel();
	end 
end 

function ExpeditionTrialData:checkHaveChangeInfo(levelId)
	for k,v in pairs(self.allInfo.challenge_info) do 
		if v.level_id == levelId then 
			do return true end;
		end
	end
	return false;
end 

function ExpeditionTrialData:updateChallengeInfo(info)
	--app.log("info = "..table.tostring(info));
	for k,v in pairs(self.allInfo.challenge_info) do 
		if info.level_id == v.level_id then 
			self.allInfo.challenge_info[k] = info;
			--app.log("allInfo = "..table.tostring(self.allInfo));
			PublicFunc.msg_dispatch("trial.updateChallengeInfo");
			do return end;
		end
	end
	table.insert(self.allInfo.challenge_info,info);
	--app.log("allInfo = "..table.tostring(self.allInfo));
	PublicFunc.msg_dispatch("trial.updateChallengeInfo");
end 

function ExpeditionTrialData:getChangeInfoByIndex(index)
	local id = self:get_curPageData()["Index"..tostring(index)].id;
	for k,v in pairs(self.allInfo.challenge_info) do 
		if v.level_id == id then 
			do return v end;
		end
	end
	return nil;
end 

function ExpeditionTrialData:getChangeInfoByLevelId(levelId)
	for k,v in pairs(self.allInfo.challenge_info) do 
		if v.level_id == levelId then 
			do return v end;
		end
	end
	return nil;
end 

function ExpeditionTrialData:onGetLevelChangeInfo()
	
end 

function ExpeditionTrialData:get_curPageData()
	local cf = self.allLevelConfig[self.allInfo.cur_expedition_trial_level]
	if self.allInfo.finish == true then 
		cf = self.allLevelConfig[#self.allLevelConfig];
	end
	return self.allLevelData[cf.page];
end 

function ExpeditionTrialData:set_Team(team,teamPos)
	self.teamInfo = team;
	--app.log("TeamPos : "..table.tostring(teamPos));
	self.teamPos = teamPos;
end 

function ExpeditionTrialData:get_Team()
	if self.teamInfo == nil then 
		self:initTeam();
	end
	
	if table.getall(self.teamInfo) == 0 then 
		self:initTeam();
	end
	return self.teamInfo;
end 

function ExpeditionTrialData:initTeam()
	local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.trial);
	self.teamPos = g_dataCenter.player:GetTeamPos(ENUM.ETeamType.trial);
	self.teamInfo = {};
	self.teamInfo.cards = {};
	if team and team.cards == nil then 
		self.teamInfo.cards = team;
	elseif team and team.cards ~= nil then 
		self.teamInfo = team;
	end
end 

function ExpeditionTrialData:saveHeroHp(hpData)
	self.hpData = hpData;
end 

function ExpeditionTrialData:get_roleStates()
	if self.roleStatesList == nil then 
		self:initRoleStates();
	end
	return self.roleStatesList;
end 

--[[function ExpeditionTrialData:saveHeroHp()
	local info = {
		pass_stars = 0;
		my_hero1_hp = 0;
		my_hero2_hp = 0;
		my_hero3_hp = 0;
		enemy_hero1_hp = 0;
		enemy_hero2_hp = 0;
		enemy_hero3_hp = 0;
	}
	msg_expedition_trial.cg_expedition_trial_challenge_result(info)
end --]]

function ExpeditionTrialData:initRoleStates()
	self.package = g_dataCenter.package;
	--self.roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have, self.package, self:get_Team())
	self.roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All, self.package, self:get_Team())
	local mx = #self.roleStatesList;
	for i = 1,mx do 
		local v = self.roleStatesList[i];
		self.roleStatesList[v.index] = v;
	end
end 

function ExpeditionTrialData:get_battleData()
	return self.battleRoleE1,self.battleRoleE2,self.battleRoleE3,self.battleRoleM1,self.battleRoleM2,self.battleRoleM3;
end 

function ExpeditionTrialData:get_enemyTeam()
	local levelData,challengeInfo = self:get_levelData();
	if challengeInfo == nil then 
		challengeInfo = self.allInfo.challenge_info[table.getall(self.allInfo.challenge_info)];
	end
	local hero1 = TrialChooseDifficult.createTrialCard(challengeInfo.player_info[challengeInfo.select_difficulty].hero_info[1]);
	local hero2 = TrialChooseDifficult.createTrialCard(challengeInfo.player_info[challengeInfo.select_difficulty].hero_info[2]);
	local hero3 = TrialChooseDifficult.createTrialCard(challengeInfo.player_info[challengeInfo.select_difficulty].hero_info[3]);
	local team = {hero1,hero2,hero3};
	return team;
end 

function ExpeditionTrialData:IsInitState()
	return self.initState;
end

function ExpeditionTrialData:UpdateState(state, left_time, isJoined, round_index)
	self.initState = true;
	self.curState = state;
	self.nextTime = os.time() + left_time;
	self.isJoined = isJoined;
	--self.cardId = card_id;
	if round_index == 0 then
		self.roundIndex = 1;
	else
		self.roundIndex = round_index;
	end	
end

function ExpeditionTrialData:EndGame()
	local star = FightRecord.GetStar();
	local isWin = 1;
	if star > 0 then
		isWin = 0;
	end
    local param = {FightRecord.GetLevelID(),}
	self:GameResult(isWin,{},param);
	--msg_activity.cg_leave_activity(self.play_method_id,isWin,param);
end

function ExpeditionTrialData:GameResult(isWin, awards,  param)
    local originAwards = awards
    awards = {}
    for k,v in ipairs(originAwards) do
        local isDup = false
        for ik,iv in ipairs(awards) do
            if v.id == iv.id then
                iv.count = iv.count + v.count
                isDup = true
                break
            end
        end
        if isDup == false then
            table.insert(awards, v)
        end
    end
    --app.log("isWin : "..tostring(isWin));
    if isWin == EPlayMethodLeaveType.success or isWin == EPlayMethodLeaveType.failed then
        local data = self:_GameResult(isWin, awards,  param);
		local levelData = self:get_levelData();
		if isWin == EPlayMethodLeaveType.success then  
			local cfHurlde = ConfigHelper.GetHurdleConfig(self.hurdle_id);
			--local defTeam = g_dataCenter.player:GetDefTeam();
			local isGood = FightRecord.IsGood();
			local isPerfect = FightRecord.IsPerfect();

			data.star = {
				star = FightRecord.GetStar(), 
				finishConditionInfex = {1, isGood, isPerfect}, 
				conditionDes = {cfHurlde.win_describe, cfHurlde.good_describe, cfHurlde.perfact_describe}, 
				showTitle = true, 
			}
			levelData.star = FightRecord.GetStar();
		end 
		enemyTeam = self:get_enemyTeam();
		if levelData.fight_type == 1 then
			local info = {
				pass_stars = levelData.star or 0;
				enemy_hero1_hp = self.hpData[enemyTeam[1].number];
				enemy_hero2_hp = self.hpData[enemyTeam[2].number];
				enemy_hero3_hp = self.hpData[enemyTeam[3].number];
				is_force_exit = 0;
				use_time = FightScene.GetFightManager():GetFightRemainTime();
				is_auto_fight = g_dataCenter.trial:GetIsAutoFight();
			}
			--app.log("Send Battle Result Info : "..table.tostring(info));
			msg_expedition_trial.cg_expedition_trial_challenge_result(info)
		else
			local info = {
				pass_stars = 3;
				enemy_hero1_hp = enemyTeam[1]:GetPropertyVal("max_hp");
				enemy_hero2_hp = enemyTeam[2]:GetPropertyVal("max_hp");
				enemy_hero3_hp = enemyTeam[3]:GetPropertyVal("max_hp");
				is_force_exit = 0;
				use_time = FightScene.GetFightManager():GetFightRemainTime();
				is_auto_fight = g_dataCenter.trial:GetIsAutoFight();
			}
			if isWin == EPlayMethodLeaveType.failed then
				info.pass_stars = 0;				
			end
			--app.log("Send Battle Result Info : "..table.tostring(info));
			msg_expedition_trial.cg_expedition_trial_challenge_result(info)
		end
		if isWin == EPlayMethodLeaveType.failed then
			CommonClearing.SetFinishCallback(FightScene.ExitFightScene);
			CommonClearing.Start(data);
		else 
			CommonKuikuliyaWinUI.Start();
			CommonKuikuliyaWinUI.SetEndCallback(FightScene.ExitFightScene);
		end 
    end
end

function ExpeditionTrialData:GetVipAddPointsAndRate(basePoints)
	local num = 0
	local rate = 0
	-- local vipCfg = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip);
	local vipCfg = g_dataCenter.player:GetVipData();
    if vipCfg then
		rate = vipCfg.expedition_trial_score
        num = basePoints * rate
    end
	return num, rate
end
