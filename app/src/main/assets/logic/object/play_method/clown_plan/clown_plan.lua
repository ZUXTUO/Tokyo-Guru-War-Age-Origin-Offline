ClownPlan = Class("ClownPlan", PlayMethodBase)


function ClownPlan.GetFightTimes()
	local totalTimes = ConfigManager.Get(EConfigIndex.t_activity_time, MsgEnum.eactivity_time.eActivityTime_ClownPlan).number_restriction.d or 2;

	local numberStr = g_dataCenter.player:GetFlagHelper():GetStringFlag(MsgEnum.eactivity_time.eActivityTime_ClownPlan);
	numberStr = numberStr or "d=0";
	local usedTimes = PublicFunc.GetActivityCont(numberStr, "d") or 0;

	totalTimes = totalTimes + g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_xiaochoujihua);
	return usedTimes, totalTimes
end

function ClownPlan:Init(data)
	PlayMethodBase.ClearData(self, data);
	self.difficultLevel = 1;
	self.boss_max_hp = 0
end
function ClownPlan:IsOpen()
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_ClownPlan) then
        return Gt_Enum_Wait_Notice.Player_Levelup;
    end
    local bOpen = Gt_Enum_Wait_Notice.Time;
    local usedTimes,totalTimes = ClownPlan.GetFightTimes()
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    local timeStr = flagHelper:GetStringFlag(MsgEnum.eactivity_time.eActivityTime_ClownPlan);
    if usedTimes < totalTimes then 
        ClownPlan.timeFlagNum = ClownPlan.timeFlagNum or 0;
        if ClownPlan.timeFlagNum <= system.time() then
            bOpen = Gt_Enum_Wait_Notice.Success;
        end
    end
    return bOpen;
end

function ClownPlan:SetDifficultyIndex(index)
	self.difficultyIndex = index
end

function ClownPlan:SetBossMaxHp(hp)
	self.boss_max_hp = hp
end

function ClownPlan:GetBossMaxHp()
	return  math.floor(self.boss_max_hp or 0)
end

function ClownPlan:GetIsAutoFight()
	return PublicFunc.GetIsAuto(self.hurdle_id)
end
  
function ClownPlan:EndGame()
	--app.log("ClownPlan:EndGame param=" .. table.tostring( { self.difficultLevel, ClownPlanFightManager.total_damage, self:GetBossMaxHp() }))
	local end_noti = function()
		local use_time = FightScene.GetFightManager():GetFightUseTime();
		msg_activity.cg_leave_activity(MsgEnum.eactivity_time.eActivityTime_ClownPlan, true, { self.difficultLevel, ClownPlanFightManager.total_damage, self:GetBossMaxHp(), tostring(use_time), self:GetIsAutoFight()});
	end
	if FightScene.GetFightManager():IsTimeUp() then
		UiClownPlanTimeOver.Show()
		timer.create(Utility.create_callback(end_noti), 1500, 1)
		timer.create(Utility.create_callback(UiClownPlanTimeOver.Destroy), 1600, 1)
	else
		end_noti()
	end

	-- OGM.Clear("assetbundles/prefabs/fx/prefab/fx_ui/fx_golds.assetbundle")

end

function ClownPlan:BeginGame(result, param)
	-- 设置难度等级
	self.difficultLevel = param[2]
	if tostring(self.hurdle_id) == tostring(param[1]) then
		PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
		SceneManager.PushScene(FightScene, self.fs);
	else
		app.log("存储关卡id(" .. tostring(self.hurdle_id) .. ")与当前关卡id(" .. tostring(hurdle_id) .. ")不符。");
	end
	app.log("ClownPlan:BeginGame" .. table.tostring(param))
end

 

function ClownPlan:ForceExit()
	self:EndGame(EPlayMethodLeaveType.exit)
end

function ClownPlan:GetChallengeNumber()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_ClownPlan;
	local flagHelper = g_dataCenter.player:GetFlagHelper();
	local flag = flagHelper:GetStringFlag(activity_id);
	if not flag or flag == "" then
		return 0;
	end
	local challengeNumber = PublicFunc.GetActivityCont(flag, "d");
	return challengeNumber;
end

-- level:1--D级 2--C级 3--B级 4--A级
function ClownPlan:SetDifficultLevel(level)
	self.difficultLevel = level;
end

function ClownPlan:GetDifficultLevel()
	if not self.difficultLevel then
		self.difficultLevel = 1;
	end
	return self.difficultLevel;
end

function ClownPlan:Tostring()
	local param = { };
	param[1] = tostring(self.hurdle_id);
	param[2] = self.difficultLevel;
	param[3] = self:GetIsAutoFight()
	return param;
end


function ClownPlan:GameResult(isWin, awards, param)
	local originAwards = awards
	awards = { }
	for k, v in ipairs(originAwards) do
		local isDup = false
		for ik, iv in ipairs(awards) do
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
	-- local gold = 0
	-- for k, v in pairs(awards) do
	-- 	if v.id == IdConfig.Gold then
	-- 		gold = v.count
	-- 		table.remove(awards, k)
	-- 		break
	-- 	end
	-- end
	-- app.log(string.format("ClownPlan:GameResult isWin=%s,awards=%s,param=%s", tostring(isWin), table.tostring(awards), table.tostring(param)))
	UiClownPlanFightResult.ShowAwardUi( { damage = param[2],boss_max_hp=self:GetBossMaxHp(), gold = gold, awards = awards })

end


function ClownPlan:SetGoldTargetPosition(x, y, z)
	self.targetPosition = { x = x, y = y, z = z }
end

function ClownPlan:GetGoldTargetPosition()
	return self.targetPosition
end

function ClownPlan:SetGoldParent(parent)
	self.targetParent = parent
end

function ClownPlan:GetGoldParent()
	return self.targetParent
end

function ClownPlan:Join()
	local diff_config = ConfigManager._GetConfigTable(EConfigIndex.t_clown_plan_hurdle)
	local diffData = {}
	local my_level = g_dataCenter.player.level;
	-- 难度大于1的要特殊判断
	for k,v in pairs(diff_config) do
		local preDiffPass = true;		--前一难度是否通关
		local curDiffPass = false;		--当前难度是否通关
		local flagHelper = g_dataCenter.player:GetFlagHelper();
		local flagInfo = nil;
		if flagHelper then  
			flagInfo = flagHelper:GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_ClownPlan);
		end 
		if k > 1 then
			preDiffPass = false;
			if flagHelper then
				-- 上一难度完成的话
				if flagInfo and PublicFunc.GetBitValue(flagInfo, k - 1) > 0 then
					preDiffPass = true;
				end
				if flagInfo and PublicFunc.GetBitValue(flagInfo, k) > 0 then 
					curDiffPass = true;
				end
			end
		else
			if flagHelper then
				if flagInfo and PublicFunc.GetBitValue(flagInfo, k) > 0 then 
					curDiffPass = true;
				end
			end
		end 
		diffData[k] = {}
		diffData[k].levelLimit = v.open_level
		diffData[k].pass = curDiffPass;			--当前难度是否通关
		if my_level >= v.open_level and preDiffPass then
			diffData[k].isOpen = true
		else
			diffData[k].isOpen = false
		end
	end
	return diffData
end

function ClownPlan:StartBattle(difficultLevel)
	
	
	local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan]
	fs:SetDifficultLevel(difficultLevel);
	
	local level = g_dataCenter.player.level;
	local hurdle_data = ConfigManager.Get(EConfigIndex.t_clown_plan_hurdle, self.difficultLevel)
	--local difficult_open_level = hurdle_data.open_level;
	-- TODO：临时注释
--[[	if not g_dataCenter.gmCheat:noPlayLimit() then
		if level < difficult_open_level then
			HintUI.SetAndShow(EHintUiType.zero, "等级不足");
			return;
		end
		if self.times_up then
			HintUI.SetAndShow(EHintUiType.zero, "今日参与次数已用完，请明天再来");
			return;
		end
	end--]]
	
	-- 玩法ID修改后需要注意
	
	fs:SetLevelIndex(hurdle_data.level)
	fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_ClownPlan);
	
	fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, g_dataCenter.player:GetTeam(self:GetTeamID()))
	
	
	msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_ClownPlan, fs:Tostring())
end
--小丑计划获取最大能扫荡的难度 add:刘相敬 2016-10-19
function ClownPlan:getMaxSweepDiff()
	local diffData = self:Join()
	local maxLevel = #diffData;
	local maxPass = 0;
	for i = 1,maxLevel do 
		if diffData[i].pass == false then 
			maxPass = i - 1;
			break;
		else
			maxPass = i;
		end
	end
	return maxPass;
end 
--小丑计划扫荡功能 add:刘相敬 2016-10-19
function ClownPlan:Sweep()
	app.log("ClownPlan:Sweep");
	app.log("maxDiff = "..tostring(self:getMaxSweepDiff()));
	msg_activity.cg_raids(MsgEnum.eactivity_time.eActivityTime_ClownPlan, {tostring(self:getMaxSweepDiff()),"0","0","0", "0"})
end 

function ClownPlan.GetRuleId()
	return ENUM.ERuleDesType.ClownPlan;
end

function ClownPlan.UpdateTime()
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    local timeStr = flagHelper:GetStringFlag(MsgEnum.eactivity_time.eActivityTime_ClownPlan);
    local timeFlagNum = 0;
    local cf = ConfigManager.Get(EConfigIndex.t_activity_time,MsgEnum.eactivity_time.eActivityTime_ClownPlan);
    if timeStr ~= nil and cf.relative ~= 0 then 
        timeFlagNum = tonumber(timeStr);
        if timeFlagNum == nil then 
            local a = string.split(timeStr,";");
            if a[2] ~= nil then 
                local b = string.split(a[2],"=");
                timeFlagNum = tonumber(b[2]);
            end 
        end 
        if timeFlagNum ~= nil then 
            timeFlagNum = timeFlagNum + cf.relative;
            if timeFlagNum > system.time() then
                TimerManager.Add(ClownPlan.UpdateTime, (timeFlagNum - system.time())*1000, 1);
            end
        end
    end
    ClownPlan.timeFlagNum = timeFlagNum;
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Time, Gt_Enum.EMain_Challenge_ActivityLevel_ClownPlanFighting);
end

function ClownPlan:GetTeamID()
    return ENUM.ETeamType.Clown_plan
end

function ClownPlan:GetHurdleID(diffIndex)
    return  ConfigManager.Get(EConfigIndex.t_clown_plan_hurdle, diffIndex).level
end