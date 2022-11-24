JieLueWuZi = Class("JieLueWuZi",PlayMethodBase)

function JieLueWuZi:Init(data)
	PlayMethodBase.ClearData(self,data);
	self.difficultLevel = 1;
end

function JieLueWuZi:GameResult(isWin,awards,param)
	local score = 0;
	--app.log("xxxxxxxxxxxxxxxx    "..table.tostring(awards));
	if awards and not Utility.isEmpty(awards) then
		score = tonumber(param[1]);
	end
	--UiBaoWeiCanChangAward.ShowAwardUi({score = score})

	if score == 0 then
		CommonLeave.Start({ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipLevelUp, ENUM.ELeaveType.HeroEgg})
        CommonLeave.SetFinishCallback(FightScene.ExitFightScene);
	else
		local max_fraction = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_baoWeiCanChangMaxFraction).data

		for k,v in ipairs(awards) do
			v.double_radio = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hight_sniper, v.id)
		end

        CommonActivitySuccUI.Start(awards, score/max_fraction,
		{
			name = "杀敌数量",
			content = self.killNum,
		})
        CommonActivitySuccUI.SetFinishCallback(FightScene.ExitFightScene);
	end

end

function JieLueWuZi:GetIsAutoFight()
	return PublicFunc.GetIsAuto(self.hurdle_id)
end

function JieLueWuZi:EndGame()
	local param = {[1]=tostring(FightScene.GetFightManager().score)};
	param[2] = tostring(self.difficultLevel);
	param[3] = tostring(FightScene.GetFightManager():GetFightUseTime());
	param[4] = self:GetIsAutoFight()
	self.killNum = tostring(FightScene.GetFightManager().count_dead_monster)
	local isWin = 0;
	local system_id = MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang;
	msg_activity.cg_leave_activity(system_id, isWin, param);
	--UiBaoWeiCanChangAward.ShowAwardUi({score = self.score})
end

function JieLueWuZi:BeginGame(result, param)
    local hurdle_id = param[1];
	if tostring(self.hurdle_id) == tostring(hurdle_id) then
        PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
        --uiManager:PopUi(nil,true);
        AudioManager.Stop(nil, true);
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight)
        SceneManager.PushScene(FightScene,self.fs);
    else
    	app.log("存储关卡id("..tostring(self.hurdle_id)..")与当前关卡id("..tostring(hurdle_id)..")不符。");
	end
end

--是否开启
function JieLueWuZi:IsOpen()

	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang) then
        return Gt_Enum_Wait_Notice.Player_Levelup;
    end
	
	local bOpen = Gt_Enum_Wait_Notice.Time;
    local usedTimes,totalTimes = self:GetFightTimes()
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    local timeStr = flagHelper:GetStringFlag(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang);
    if usedTimes < totalTimes then 
        JieLueWuZi.timeFlagNum = JieLueWuZi.timeFlagNum or 0;
        if JieLueWuZi.timeFlagNum <= system.time() then
            bOpen = Gt_Enum_Wait_Notice.Success;
        end
    end
    return bOpen;
end

function JieLueWuZi:GetChallengeNumber()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang;
	local flagHelper = g_dataCenter.player:GetFlagHelper();
	local flag = flagHelper:GetStringFlag(activity_id);
	if not flag or flag == "" then
		return 0;
	end
	local challengeNumber = PublicFunc.GetActivityCont(flag,"d");
	return challengeNumber;
end

--level:1--D级 2--C级 3--B级 4--A级
function JieLueWuZi:SetDifficultLevel(level)
	self.difficultLevel = level;
end

function JieLueWuZi:GetDifficultLevel()
	if not self.difficultLevel then
		self.difficultLevel = 1;
	end
	return self.difficultLevel;
end

function JieLueWuZi:Tostring()
	local param = {};
	param[1] = tostring(self.hurdle_id);
	param[2] = tostring(self.difficultLevel);
	--为了扫荡的保留位
	param[3] = "0";
	param[4] = self:GetIsAutoFight()
	return param;
end

function JieLueWuZi:GetFightTimes()
	local challengeNumber = self:GetChallengeNumber()
	local hurdle_id = MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang;
	local all_number = ConfigManager.Get(EConfigIndex.t_activity_time,hurdle_id).number_restriction;
	if not all_number then
		all_number = 0
	else
		all_number = all_number["d"]
	end
	all_number = all_number + g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_hight_sniper);
	local maxChallengeNumber = all_number
	return challengeNumber, all_number
end

function JieLueWuZi:Join()
	--[[local diff_config = ConfigManager._GetConfigTable(EConfigIndex.t_jie_lue_wu_zi_difficult)
	local diffData = {}
	local my_level = g_dataCenter.player.level;
	for k,v in pairs(diff_config) do
		diffData[k] = {}
		diffData[k].levelLimit = v.open_level
		if my_level >= v.open_level then
			diffData[k].isOpen = true
		else
			diffData[k].isOpen = false
		end
	end
	return diffData--]]
	local result = {}

    local diffCount = ConfigManager.GetDataCount(EConfigIndex.t_jie_lue_wu_zi_difficult)

    local playerLevel = g_dataCenter.player:GetLevel();
    for i=1,diffCount do
        local diffItem = {}

        local config = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi_difficult,i);
        local openLevel = 0;
        local hurdle = ConfigHelper.GetHurdleConfig(config.fight_script_id)
        if hurdle then
            openLevel = hurdle.need_level
        end
        local preDiffPass = true
		local curDiffPass = false;
        local flagHelper = g_dataCenter.player:GetFlagHelper();
        local flagInfo = nil;
		if flagHelper then  
			flagInfo = flagHelper:GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang);
		end 
        if i > 1 then
            preDiffPass = false;
            if flagHelper then
                --上一难度完成的话
                if flagInfo and PublicFunc.GetBitValue(flagInfo, i-1) > 0 then
                    preDiffPass = true;
                end
				if flagInfo and PublicFunc.GetBitValue(flagInfo, i) > 0 then
					curDiffPass = true;
				end
            end
		else 
			if flagInfo and PublicFunc.GetBitValue(flagInfo, i) > 0 then
                curDiffPass = true;
            end
		end 
        diffItem.isOpen = playerLevel >= openLevel and preDiffPass
        diffItem.levelLimit = openLevel
		diffItem.pass = curDiffPass;
        diffItem.reward = {}
        local award = config.win_award
		if award ~= nil then 
			for i=1,#award do
				table.insert( diffItem.reward, {id = award[i][1], num = nil} )
			end
		end 
		table.insert(result,diffItem);
    end
	return result;
end

function JieLueWuZi:StartBattle(level)
	app.log("StartBattle : 高速狙击 level = "..tostring(level));
	local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]
    local defTeam = g_dataCenter.player:GetTeam(self:GetTeamID())
    --玩法ID修改后需要注意
    local levelindex = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi_difficult,level).fight_script_id;
    fs:SetLevelIndex(levelindex)
    fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang);
    fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
    fs:SetDifficultLevel(level);
    
    msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang, fs:Tostring())	
end

--高速狙击获取最大能扫荡的难度 add:刘相敬 2016-10-19
function JieLueWuZi:getMaxSweepDiff()
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
--高速狙击扫荡功能 add:刘相敬 2016-10-19
function JieLueWuZi:Sweep()
	msg_activity.cg_raids(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang, {tostring(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_baoWeiCanChangMaxFraction).data),tostring(self:getMaxSweepDiff()), "0", "0"})
end 

function JieLueWuZi.GetRuleId()
	return ENUM.ERuleDesType.GaoSuZuJi;
end

function JieLueWuZi.UpdateTime()
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    local timeStr = flagHelper:GetStringFlag(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang);
    local timeFlagNum = 0;
    local cf = g_dataCenter.player:GetVipData();
    if timeStr ~= nil and cf and cf.gsjj_cool_time ~= 0 then 
        timeFlagNum = tonumber(timeStr);
        if timeFlagNum == nil then 
            local a = string.split(timeStr,";");
            if a[2] ~= nil then 
                local b = string.split(a[2],"=");
                timeFlagNum = tonumber(b[2]);
            end 
        end 
        if timeFlagNum ~= nil then 
            timeFlagNum = timeFlagNum + cf.gsjj_cool_time;
            if timeFlagNum > system.time() then
                TimerManager.Add(JieLueWuZi.UpdateTime, (timeFlagNum - system.time())*1000, 1);
            end
        end
    end
    JieLueWuZi.timeFlagNum = timeFlagNum;
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Time, Gt_Enum.EMain_Challenge_ActivityLevel_HighSpeedFighting);
end

function JieLueWuZi:GetTeamID()
    return ENUM.ETeamType.guild_gaosujuji
end

function JieLueWuZi:GetHurdleID(diffIndex)
    return ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi_difficult,diffIndex).fight_script_id
end

function JieLueWuZi:GetGoldProb()
	local goldBaseProp = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi,g_dataCenter.player.level).proportion[self:GetDifficultLevel()];
	local vipGoldProp = 0;
	local vip_data = g_dataCenter.player:GetVipData();
	if vip_data then
		local vipGoldProp = vip_data.gsjj_add_money;
	end

	return vipGoldProp + goldBaseProp
end