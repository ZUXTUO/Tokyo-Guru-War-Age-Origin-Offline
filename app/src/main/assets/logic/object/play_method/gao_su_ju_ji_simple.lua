
GaoSuJuJiSimple = Class("GaoSuJuJiSimple", PlayMethodBase);

function GaoSuJuJiSimple.GetFightTimes()

    local totalTimes = ConfigManager.Get(EConfigIndex.t_activity_time,MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi).number_restriction.d or 2;

    local numberStr = g_dataCenter.player:GetFlagHelper():GetStringFlag(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi);
    numberStr = numberStr or "d=0";
    local usedTimes = PublicFunc.GetActivityCont(numberStr,"d") or 0;

    totalTimes = totalTimes + g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_baoweizhang);
    return usedTimes, totalTimes
end

function GaoSuJuJiSimple:IsOpen()
    if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi) then
        return Gt_Enum_Wait_Notice.Player_Levelup;
    end
    local bOpen = Gt_Enum_Wait_Notice.Time;
    local usedTimes,totalTimes = GaoSuJuJiSimple.GetFightTimes()
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    local timeStr = flagHelper:GetStringFlag(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi);
    if usedTimes < totalTimes then 
        GaoSuJuJiSimple.timeFlagNum = GaoSuJuJiSimple.timeFlagNum or 0;
        if GaoSuJuJiSimple.timeFlagNum <= system.time() then
            bOpen = Gt_Enum_Wait_Notice.Success;
        end
    end
    return bOpen;
end

function GaoSuJuJiSimple:SetDifficultyIndex(index)
    self.difficultyIndex = index
end

function GaoSuJuJiSimple:GetKilledWave()
    return self.killedWave or 0
end

function GaoSuJuJiSimple:SetPlayerKilledWave(wave, max_wave)
    self.killedWave = wave
    
    if max_wave ~= self.maxWave then
        app.log('bao wei zhan max wave exception!')
    end
end

function GaoSuJuJiSimple:SetPlayerKillingWave(wave, max_wave)
    self.killingWave = wave
    self.maxWave = max_wave
end

function GaoSuJuJiSimple:BeginGame(result, param)
    PlayMethodBase.BeginGame(self, result, param);
    self:SetDifficultyIndex(param[2]);
end

function GaoSuJuJiSimple:EndGame(isWin)
    self.killedWave = self.killedWave or 0;
    self.maxWave = self.maxWave or 0;

    if isWin ~= EPlayMethodLeaveType.exit then
        isWin =  self.killedWave > 0 and  self.killedWave == self.maxWave
        if isWin then
            isWin = EPlayMethodLeaveType.success
        else
            isWin = EPlayMethodLeaveType.failed
        end
    end
    --app.log('GaoSuJuJiSimple:EndGame ' .. tostring(self.killedWave))
    -- self.killedWave = 1
    -- self.killingWave = 2
    local use_time = FightScene.GetFightManager():GetFightUseTime();
    --app.log("GaoSuJuJiSimple:EndGame " .. tostring(isWin) .. ' ' .. tostring(self.killedWave))
    msg_activity.cg_leave_activity(self.play_method_id,isWin,{tostring(self.killedWave+1), tostring(self.difficultyIndex), tostring(use_time), self:GetIsAutoFight()});
    

    
end

function GaoSuJuJiSimple:GetIsAutoFight()
	return PublicFunc.GetIsAuto(self.hurdle_id)
end

-- function GaoSuJuJiSimple:ForceExit()
--     self:EndGame(EPlayMethodLeaveType.exit)
-- end

function GaoSuJuJiSimple:GameResult(isWin, awards,  param)
    -- if isWin == EPlayMethodLeaveType.failed and #awards > 0 then
    --     isWin = EPlayMethodLeaveType.success
    -- end
    
    -- PlayMethodBase.GameResult(self, isWin, awards, param)

    if isWin == EPlayMethodLeaveType.exit then return end
    -- 双倍
    for k,v in pairs(awards) do
        awards[k].double_radio = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.defend, v.id);
    end
    
    if isWin == EPlayMethodLeaveType.failed and self.killingWave == 1 then

        CommonLeave.Start({ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipLevelUp, ENUM.ELeaveType.HeroEgg})
        CommonLeave.SetFinishCallback(FightScene.ExitFightScene);

    else

        CommonActivitySuccUI.Start(awards, self.killedWave/self.maxWave,
		{
			name = "通关波数",
			content = string.format("%d/%d", self.killedWave, self.maxWave),
		})
        CommonActivitySuccUI.SetFinishCallback(FightScene.ExitFightScene);

    end
    self.killedWave = nil
    self.maxWave = nil
end

function GaoSuJuJiSimple:Join()

    local result = {}

    local diffCount = ConfigManager.GetDataCount(EConfigIndex.t_gao_su_ju_ji_hurdle)

    local playerLevel = g_dataCenter.player:GetLevel();
    for i=1,diffCount do
        local diffItem = {}

        local config = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,i);
        local openLevel = 1
        local hurdle = ConfigHelper.GetHurdleConfig(config.level)
        if hurdle then
            openLevel = hurdle.need_level
        end
        local preDiffPass = true
        local curDiffPass = false;
        local flagHelper = g_dataCenter.player:GetFlagHelper();
        local flagInfo = nil;
        if flagHelper then  
            flagInfo = flagHelper:GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi);
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

function GaoSuJuJiSimple:StartBattle(difficultLevel)
    local config = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,difficultLevel);
    if config then
        local hurdleid = config.level;
        local defTeam = g_dataCenter.player:GetTeam(self:GetTeamID())

        local playid = MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi
        local fs = g_dataCenter.activity[playid];
        fs:SetLevelIndex(hurdleid)
        fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
        fs:SetPlayMethod(playid)

        --{关卡id,难度}
        msg_activity.cg_enter_activity(playid , {tostring(hurdleid), tostring(difficultLevel), "0", self:GetIsAutoFight()})

    end
end

--保卫战获取最大能扫荡的难度 add:刘相敬 2016-10-19
function GaoSuJuJiSimple:getMaxSweepDiff()
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
--保卫战扫荡功能 add:刘相敬 2016-10-19
function GaoSuJuJiSimple:Sweep()
    local cf = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,self:getMaxSweepDiff());
    local max_wave = #cf.wave_award;
    --app.log("max_wave = "..tostring(max_wave).." sweepDiff = "..tostring(self:getMaxSweepDiff()));
    msg_activity.cg_raids(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi, {tostring(max_wave+1),tostring(self:getMaxSweepDiff()), "0", "0"})
end 

function GaoSuJuJiSimple:GetRuleId()
    return ENUM.ERuleDesType.BaoWeiZhan;
end

function GaoSuJuJiSimple.UpdateTime()
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    local timeStr = flagHelper:GetStringFlag(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi);
    local timeFlagNum = 0;
    local cf = ConfigManager.Get(EConfigIndex.t_activity_time,MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi);
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
                TimerManager.Add(GaoSuJuJiSimple.UpdateTime, (timeFlagNum - system.time())*1000, 1);
            end
        end
    end
    GaoSuJuJiSimple.timeFlagNum = timeFlagNum;
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Time, Gt_Enum.EMain_Challenge_ActivityLevel_DefendFighting);
end

function GaoSuJuJiSimple:GetTeamID()
    return ENUM.ETeamType.guild_Defend_war
end

function GaoSuJuJiSimple:GetHurdleID(diffIndex)
    return ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,diffIndex).level
end