-- 开始挑战
function UiBaoWeiCanChang:on_challenge(t)
    -- uiManager:PopUi();
    local index = t.float_value;
    self.difficultLevel = index;
    local level = g_dataCenter.player.level;
    local difficult_open_level = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi_difficult,self.difficultLevel).open_level;
    if not g_dataCenter.gmCheat:noPlayLimit() then
        if level < difficult_open_level then
            HintUI.SetAndShow(EHintUiType.zero, "等级不足");
            return;
        end
        if self.times_up then
            HintUI.SetAndShow(EHintUiType.zero, "今日参与次数已用完，请明天再来");
            return;
        end
    end

    local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]
    local defTeam = g_dataCenter.player:GetDefTeam()
    --玩法ID修改后需要注意
    fs:SetLevelIndex(60100000)
    fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang);
    fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
    fs:SetDifficultLevel(self.difficultLevel);
    
    --msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang, fs:Tostring())
end

-- 规则说明
function UiBaoWeiCanChang:on_rule()
    UiRuleDes.Start(ENUM.ERuleDesType.GaoSuZuJi)
end

function UiBaoWeiCanChang:on_have_chanllenged()
    -- HintUI.SetAndShow(EHintUiType.zero, "您在本时间段已参与过活动");
	HintUI.SetAndShow(EHintUiType.zero, "今日参与次数已用完，请明天再来");
end