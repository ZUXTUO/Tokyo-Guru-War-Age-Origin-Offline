
HeroTrial = Class("HeroTrial", PlayMethodBase)

function HeroTrial:Init(data)
    self.isLoadData = false

    self.msgEnumId = MsgEnum.eactivity_time.eActivityTime_heroTrial
    self.totalBoxDay = 0            --宝箱累计天数
    self.chanllengedCnt = 0         --当天挑战次数（临时）
    self.useFreeHeroList = nil      --免费试用英雄
    self.takenBoxList = nil          --已领取宝箱
    self.useHeroCountList = nil     --使用英雄次数
    self.fightBoxCount = 0          --结算时的战斗宝箱购买次数
    self.fightDay = 0

    self:ClearData();
end

function HeroTrial:ClearData(data)
    PlayMethodBase.ClearData(self, data);

    self.fightHero = nil
    self.difficult_level = nil
    self.hurdle_id = nil
    self.fightBoxCount = 0
    self.fightDay = 0
end

function HeroTrial:IsLoadInitData()
    return self.isLoadData
end

function HeroTrial:GetFightDay()
    return self.fightDay
end

function HeroTrial:GetTotalBoxDay()
    return self.totalBoxDay
end

function HeroTrial:GetChanllengeCnt()
    local number = g_dataCenter.player:GetFlagHelper():GetStringFlag(self.msgEnumId);
	number = number or "d=0";

    self.chanllengedCnt = PublicFunc.GetActivityCont(number,"d")
    return self.chanllengedCnt;
end

function HeroTrial:GetUseFreeHeroList()
    return self.useFreeHeroList or table.empty()
end

function HeroTrial:SetTakenBoxList(takenBoxList)
    self.takenBoxList = {}
    -- 转换为k,v表
    for i, v in pairs(takenBoxList) do
        self.takenBoxList[v] = true
    end
end

function HeroTrial:GetTakenBoxList()
    return self.takenBoxList or table.empty()
end

function HeroTrial:SetUseHeroCountList(useHeroCountList)
    self.useHeroCountList = {}
    for i, v in pairs(useHeroCountList) do
        self.useHeroCountList[v.dataid] = v.useCount
    end
end

function HeroTrial:GetUseHeroCountList()
    return self.useHeroCountList or table.empty()
end

function HeroTrial:GetUnusedChanllengeCnt()
    return math.max(0, self:GetMaxChanllengeCnt() - self:GetChanllengeCnt())
end

function HeroTrial:GetMaxChanllengeCnt()
    local totalCnt = ConfigManager.Get(EConfigIndex.t_activity_time,self.msgEnumId).number_restriction.d or 3;
    return totalCnt
end
--
function HeroTrial:GetRecommendPowerLevel(cardInfo)
    local result = 6
    local fightValue = cardInfo:GetFightValue()
    local config = ConfigManager.Get(EConfigIndex.t_hero_trial_power, g_dataCenter.player:GetLevel())
    if not config == nil then 
        for i=1, 6 do
            if fightValue >= config["diff_"..i.."_start"] and
                fightValue <= config["diff_"..i.."_end"] then
                result = i
                break;
            end
        end
    end

    return result
end

function HeroTrial:IsThereBoxUnTaken()
    local result = false
    local boxGetState = {} -- 2/1/0/ 已领取/未领取/不能领取
    local config = ConfigManager._GetConfigTable(EConfigIndex.t_hero_trial_week_awards)
    local takenList = self:GetTakenBoxList()
    if takenList then
        for k, v in pairs(config) do
            if self.totalBoxDay >= v.day and takenList[k] == nil then
                result = true
            end
            if self.totalBoxDay < v.day then
                boxGetState[k] = 0
            elseif takenList[k] == nil then
                boxGetState[k] = 1
            else
                boxGetState[k] = 2
            end
        end
    end
    return result, boxGetState
end

function HeroTrial:UpdateTakenBoxAwards(index)
    if self.takenBoxList then
        self.takenBoxList[index] = true

        local needReset = true
        local config = ConfigManager._GetConfigTable(EConfigIndex.t_hero_trial_week_awards)
        local takenList = self:GetTakenBoxList()
        for k, v in pairs(config) do
            if takenList[k] == nil then
                needReset = false
                break;
            end
        end
        --重置 1.宝箱累计天数进度 2.已领取宝箱列表
        if needReset then
            self.totalBoxDay = 0
            self.takenBoxList = {}
        end
    end
end

--更新英雄使用次数
function HeroTrial:UpdateHeroUseCount(dataid)
    if self.useHeroCountList then
        local count = self.useHeroCountList[dataid] or 0
        self.useHeroCountList[dataid] = math.min(3, count + 1)
    end
end

--更新宝箱累计天数进度（当前完成了一次成功挑战）
function HeroTrial:UpdateTotalBoxDay()
    self.totalBoxDay = math.min(7, self.totalBoxDay + 1)
end

function HeroTrial:UpdateFightBoxCount()
    self.fightBoxCount = self.fightBoxCount + 1
end

function HeroTrial:gc_hero_trial_get_init_info(info)
    self.isLoadData = true

	if info then
        self.totalBoxDay = info.totalDay
        self.useFreeHeroList = info.weekUse
        self:SetTakenBoxList(info.alreadyGet)
        -- self.takenBoxList = info.alreadyGet
        self:SetUseHeroCountList(info.trialCount)
        -- self.useHeroCountList = info.trialCount
    end
end

function HeroTrial:gc_enter_activity_error(result, system_id, cf)
    -- 异常情况处理，若是重置时间过了需要关闭上阵界面
    if result == MsgEnum.error_code.error_code_hero_trial_enter_exception then
        uiManager:UpdateMsgData(EUI.HeroTrialUI, "gc_enter_activity_error")
    end
end

function HeroTrial:GetFightType()
    local result = 0
    if self.fightDay > 0 then
        result = ConfigManager.Get(EConfigIndex.t_hero_trial_week_use, self.fightDay).ty or 0
    end
    return result
end

function HeroTrial:Tostring()
	local param = {}

    -- 4个参数 
    -- 第1个参数 对应关卡id
    -- 第2个参数是否是体验英雄1是 0否 
    -- 第3个参数 英雄唯一id或者体验英雄配置id 
    -- 第4个参数 难度1-6
    if self.fightHero then
        param[1] = tostring(self.hurdle_id)
        if self.fightHero.free_hero_mark then
            param[2] = tostring(1);
            param[3] = tostring(self.fightHero.free_hero_mark)
        else
            param[2] = tostring(0);
            param[3] = tostring(self.fightHero.index)
        end 
        param[4] = tostring(self.difficult_level)
    end
    return param
end

function HeroTrial:StartBattle(fightHero, difficult_level, hurdle_id, fightDay)
    self.fightHero = fightHero
    self.difficult_level = difficult_level
    self.hurdle_id = hurdle_id
    self.fightDay = fightDay

    self:ClearFightPlayer()

    self:SetLevelIndex(hurdle_id)
    self:SetPlayMethod(self.msgEnumId)
    local team_card_list = {}
    local player, package = nil, nil
    if self.fightHero.free_hero_mark then
        local temp_player = Player:new()
        local player_info = {}
        player_info.playerid = g_dataCenter.player.playerid
        player_info.name = g_dataCenter.player.name
        player_info.level = g_dataCenter.player.level
        temp_player:UpdateData(player_info);

        local temp_package = Package:new()
        temp_package:AddCardInst(ENUM.EPackageType.Hero, self.fightHero);
        temp_player:SetPackage(temp_package);

        player = temp_player
        package = temp_package
        table.insert(team_card_list, self.fightHero.index)
    else
        player = g_dataCenter.player
        package = g_dataCenter.package
        table.insert(team_card_list, self.fightHero.index)
    end

    self:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, player, package, EFightPlayerType.human, team_card_list)
    msg_activity.cg_enter_activity(self.msgEnumId, self:Tostring())
end

function HeroTrial:BeginGame(result, param)
    -- uiManager:RemoveUi(EUI.HeroTrialFormationUI)
    uiManager:PopUi(nil,true);
    AudioManager.Stop(nil, true);
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight);
    PlayMethodBase.BeginGame(self, result, param)
end

function HeroTrial:EndGame(is_force)
	self.isForce = is_force
	local star = FightRecord.GetStar();
	local isWin = 1;
	if star > 0 then
		isWin = 0;
	end
    local param = self:Tostring()
	msg_activity.cg_leave_activity(self.play_method_id,isWin,param);
end

function HeroTrial:GameResult(isWin, awards,  param)
    if self.isForce then
        FightScene.ExitFightScene()
    else
        local funcGameResult = function()
            PlayMethodBase.GameResult(self, isWin, table.empty(),  param);  
        end

        --胜利，分别处理结算界面
        if isWin == EPlayMethodLeaveType.success then
            --获取奖励从通用结算中取出来
            local funcFightBox = function()
                local ui = uiManager:PushUi(EUI.HeroTrialFightBoxUI, awards)
                ui:SetEndCallback(funcGameResult)
            end
            
            CommonKuikuliyaWinUI.Start();
			CommonKuikuliyaWinUI.SetEndCallback(funcFightBox);
        --失败，走通用逻辑
        else
            TimerManager.Add(funcGameResult, 1500, 1)
        end

        if isWin == EPlayMethodLeaveType.success then
            local chanllengedCnt = self.chanllengedCnt
            --当天完成了第一次挑战的更新进度天数
            if chanllengedCnt == 0 and self:GetChanllengeCnt() == 1 then
                self:UpdateTotalBoxDay()
            end
            --更新英雄使用次数
            if self.fightHero and self.fightHero.free_hero_mark == nil then
                self:UpdateHeroUseCount(self.fightHero.index)
            end
            GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_HeroTrial);
        end
    end
end
