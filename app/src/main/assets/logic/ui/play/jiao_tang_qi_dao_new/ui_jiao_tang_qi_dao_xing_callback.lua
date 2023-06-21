--
--点击界面背景，如果点中人，则谈出挑战界面

--点击领取按钮后，1：不发生什么  2：挂机  3：挑战
local EAfterGetReward =
{
    none = 1,
    hook = 2,
    chanllenge = 3,
}
function UiJiaoTangQiDaoXing:on_rule()
    self.ruleUI = UiRuleDesWithoutUiMgr:new(ENUM.ERuleDesType.JiaoTangGuaJi);
end
function UiJiaoTangQiDaoXing:on_btn_back2()
    CameraManager.EnterTouchMoveMode(nil, self.btn_background, false, true)
end

function UiJiaoTangQiDaoXing:on_btn_back(btn_name,x,y,game_obj)
    --CameraManager.EnterTouchMoveMode(nil, self.btn_background, false, true)
    local layer_mask = PublicFunc.GetBitLShift({[1]=PublicStruct.UnityLayer.npc});
    local result, hitinfo = util.raycase_out_object(x,y,20,layer_mask);
    if result == true then
        if self.enterStar == 1 then
            --HintUI.SetAndShow(EHintUiType.zero, "一星教堂不能挑战");
            return
        end

        local name = hitinfo.game_object:get_name();
        self.challengeHeroInfo = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetInfoByName(name);
        local star,pos = self.challengeHeroInfo.star,self.challengeHeroInfo.pos;
        local touch_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(star,pos);
        if not touch_player then return end
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetCurChanllengePos(pos)

        local heroid = touch_player:GetDefTeam()[1];
        if heroid == g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1) then
            --点到自己，没反应
            return
        end
        --app.log("star=="..star.."  pos=="..pos.."  heroid=="..heroid);
        local cardhuman = touch_player.package:find_card(ENUM.EPackageType.Hero,heroid);
        self:SetContMatchShow()
    else
        --self:SetContMatchShow(false)
    end
end

function UiJiaoTangQiDaoXing:SetContMatchShow()
    self.after_get_reward = EAfterGetReward.chanllenge;
    if not self.ui_challenge then
        self.ui_challenge = UiJiaoTangQiDaoBeginFight:new();
    else
        self.ui_challenge:Show();
        self.ui_challenge:UpdateUi();
    end
end

function UiJiaoTangQiDaoXing:on_btn_challenge()
    self.immediateHook = false;
    local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(self.curIndex);
    local param = {};

    param[1] = tostring(heroid);
    param[2] = tostring(self.challengeHeroInfo.star);
    param[3] = tostring(self.challengeHeroInfo.pos);
    param[4] = tostring(1);
    msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, param);
end

function UiJiaoTangQiDaoXing:on_btn_speedup()
    -- local cur_time = system.time();
    -- local pray_time = cur_time - self.begin_time;

    -- local left_time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetLeftTime(1);
    -- local real_left_time = left_time - pray_time;
    -- if real_left_time < 3600 then
    --     HintUI.SetAndShow(EHintUiType.two, "剩余时间不足1小时，是否继续花费"..tostring(ConfigManager.Get(EConfigIndex.t_church_pray_quick,self.enterStar).cost).."钻石加速1小时",{str="确认",func=self.bindfunc["SpeedUp"]}, {str = "取消"});
    -- else
    --     HintUI.SetAndShow(EHintUiType.two, "是否花费"..tostring(ConfigManager.Get(EConfigIndex.t_church_pray_quick,self.enterStar).cost).."钻石加速1小时",{str="确认",func=self.bindfunc["SpeedUp"]}, {str = "取消"});
    -- end
end

function UiJiaoTangQiDaoXing:SpeedUp()
    msg_activity.cg_churchpray_quick(1, 1);
end

function UiJiaoTangQiDaoXing:gc_btn_speedup(result, index)
    --HintUI.SetAndShow(EHintUiType.zero, "加速成功");
    self:UpdateUi();
end

function UiJiaoTangQiDaoXing:on_btn_get()
    self.oldPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetChurchPosIndex(self.curIndex);
    local cur_time = system.time();
    local pray_time = cur_time - self.begin_time;
    local old_pray_time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetPrayKeepTime(1);
    local exp = self:GetLocalTotalExp(pray_time+old_pray_time,self.curIndex);
    --app.log("pray_time =="..tostring(pray_time).."  old_pray_time=="..tostring(old_pray_time));
    self.after_get_reward = EAfterGetReward.none;
    if exp >= ConfigManager.Get(EConfigIndex.t_item,20000021).exp then
        local strs = string.format(PublicFunc.GetWord("jiaotangqidao_9"), tonumber(exp));
        HintUI.SetAndShow(EHintUiType.two, strs,{str=PublicFunc.GetWord("public_1"),func=self.bindfunc["GetReward"]}, {str = PublicFunc.GetWord("public_2")});
    else
        HintUI.SetAndShow(EHintUiType.two, PublicFunc.GetWord("jiaotangqidao_10"),{str=PublicFunc.GetWord("public_1"),func=self.bindfunc["GetReward"]}, {str = PublicFunc.GetWord("public_2")});
    end
end

function UiJiaoTangQiDaoXing:GetReward()
    msg_activity.cg_churchpray_reward(self.curIndex)
    self.panel_tips:set_active(false);
    if self.enterStar == 1 then
        local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
        FightScene:GetFightManager():_DeleteHero(1, 0, heroid)
    end
end

function UiJiaoTangQiDaoXing:gc_btn_get(result, expReward, index, vecReward)
    if vecReward and type(vecReward) == "table" and #vecReward ~=0 then
        CommonAward.Start(vecReward, 1)
        if self.after_get_reward == EAfterGetReward.none then
        elseif self.after_get_reward == EAfterGetReward.hook then
            CommonAward.SetFinishCallback(self.after_get_hook, self)
        elseif self.after_get_reward == EAfterGetReward.chanllenge then
            CommonAward.SetFinishCallback(self.after_get_challenge, self)
        end
    else
        if self.after_get_reward == EAfterGetReward.none then
            HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_11"));
        elseif self.after_get_reward == EAfterGetReward.hook then
            HintUI.SetAndShow(EHintUiType.one, PublicFunc.GetWord("jiaotangqidao_11"),{str=PublicFunc.GetWord("public_1"), func = self.bindfunc["after_get_hook"]});
        elseif self.after_get_reward == EAfterGetReward.chanllenge then
            HintUI.SetAndShow(EHintUiType.one, PublicFunc.GetWord("jiaotangqidao_11"),{str=PublicFunc.GetWord("public_1"), func = self.bindfunc["after_get_challenge"]});
        end
    end

    self:UpdateUi();
end

function UiJiaoTangQiDaoXing:after_get_hook()
    local tempHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    --local bestPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:FindBestPosition(self.enterStar);
    local bestPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurChanllengePos();
    if not bestPos then return end
    local param = {};
    param[1] = tostring(tempHeroID);
    param[2] = tostring(self.enterStar);
    param[3] = tostring(bestPos);
    param[4] = tostring(0);
    msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, param)
end

function UiJiaoTangQiDaoXing:after_get_challenge()
    local tempHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    local pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurChanllengePos();
    if not pos then return end
    local param = {};
    param[1] = tostring(tempHeroID);
    param[2] = tostring(self.enterStar);
    param[3] = tostring(pos);
    param[4] = tostring(1);
    msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, param)
end

function UiJiaoTangQiDaoXing:on_btn_exit()
    self.exit = true;
    msg_activity.cg_churchpray_quit_church(self.enterStar)
    FightScene.GetFightManager():FightOver()
    SceneManager.PopScene(FightScene)
end

function UiJiaoTangQiDaoXing:on_btn_hook(t)
    local pos = t.float_value;
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetCurChanllengePos(pos)
    local isPray = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(self.curIndex);
    local tempHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    local guaji_heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1);
    local level = g_dataCenter.player.level;

    if self.enterStar ~= 1 then
        local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(self.enterStar, pos);
        if enemy_player then
            g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetCurChanllengePos(pos)
            self:SetContMatchShow()
            return
        end
    end

    --正在挂机
    if isPray then
        --换人了
        if tempHeroID ~= guaji_heroid then
            --寻找最好的位置
            --local bestPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:FindBestPosition(self.enterStar);
            local bestPos = pos;
            if not bestPos then return end
            local curExp;
            local enterExp;
            if bestPos == 0 then
                enterExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["boss_exp_reward"..tostring(self.enterStar)];
            else
                enterExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(self.enterStar)];
            end
            local curPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetChurchPosIndex(1);
            if self.curStar == 1 then
                curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(self.curStar)];
            else
                if curPos == 0 then
                    curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["boss_exp_reward"..tostring(self.curStar)];
                else
                    curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(self.curStar)];
                end
            end
            --判断是高级还是低级
            self.after_get_reward = EAfterGetReward.hook;
            if enterExp >= curExp then
                HintUI.SetAndShow(EHintUiType.two,PublicFunc.GetWord("jiaotangqidao_13"),{str=PublicFunc.GetWord("public_1"),func = self.bindfunc["GetReward"]},{str=PublicFunc.GetWord("public_2")});
            else
                HintUI.SetAndShow(EHintUiType.two,PublicFunc.GetWord("jiaotangqidao_14"),{str=PublicFunc.GetWord("public_1"),func = self.bindfunc["GetReward"]},{str=PublicFunc.GetWord("public_2")});
            end
        --没换
        else
            --还是原来挂机的教堂
            -- if self.enterStar == self.curStar then
            --     return;
            -- else
                --寻找最好的位置
                --local bestPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:FindBestPosition(self.enterStar);
                local bestPos = pos;
                if not bestPos then return end
                local curExp;
                local enterExp;
                if bestPos == 0 then
                    if self.enterStar == 1 then
                        enterExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(self.enterStar)];
                    else
                        enterExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["boss_exp_reward"..tostring(self.enterStar)];
                    end
                else
                    enterExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(self.enterStar)];
                end
                local curPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetChurchPosIndex(1);
                if self.curStar == 1 then
                    curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(self.curStar)];
                else
                    if curPos == 0 then
                        curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["boss_exp_reward"..tostring(self.curStar)];
                    else
                        curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(self.curStar)];
                    end
                end
                --判断是高级还是低级
                self.after_get_reward = EAfterGetReward.hook;
                if enterExp >= curExp then
                    self:ShowTips(true,false);
                    --HintUI.SetAndShow(EHintUiType.two,"是否确认挂机并领取现有的挂机经验",{str="确认",func = self.bindfunc["GetReward"]},{str="取消"});
                else
                    self:ShowTips(true,true);
                    --HintUI.SetAndShow(EHintUiType.two,"您挂机的位置经验获得速度低于现有位置，是否确认挂机并领取现有的挂机经验",{str="确认",func = self.bindfunc["GetReward"]},{str="取消"});
                end
            --end
        end
    --没挂机
    else
        --local bestPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:FindBestPosition(self.enterStar);
        local bestPos = pos;
        if not bestPos then return end
        local param = {};
        param[1] = tostring(tempHeroID);
        param[2] = tostring(self.enterStar);
        param[3] = tostring(bestPos);
        param[4] = tostring(0);
        msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, param)
    end
end

function UiJiaoTangQiDaoXing:on_btn_buy()
    local buyChallengeTimes = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetBuyChallengeTimes() + 1;   --今日已购买次数
    local crystal = ConfigManager.Get(EConfigIndex.t_church_pray_challenge_cost,buyChallengeTimes).cost;
    if crystal then
        local strs = string.format(PublicFunc.GetWord("jiaotangqidao_15"), tonumber(crystal));
        HintUI.SetAndShow(EHintUiType.two, strs,{str=PublicFunc.GetWord("public_1"),func = self.bindfunc["on_sure_buy"]},{str=PublicFunc.GetWord("public_2")});
    else
        app.log("挑战次数购买第"..buyChallengeTimes.."次，没有配置表");
    end
end

function UiJiaoTangQiDaoXing:on_sure_buy()
    local buyChallengeTimes = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetBuyChallengeTimes() + 1;   --今日已购买次数
    local crystal = ConfigManager.Get(EConfigIndex.t_church_pray_challenge_cost,buyChallengeTimes).cost;
    local have_crystal = g_dataCenter.player.crystal;
    --app.log("钻石数=="..have_crystal);
    if have_crystal < crystal then
        local strs = string.format(PublicFunc.GetWord("jiaotangqidao_16"), tonumber(have_crystal));
        HintUI.SetAndShow(EHintUiType.zero, strs);
    else
        msg_activity.cg_churchpray_times()
        self.btn_buy:set_enable(false);
    end
end

function UiJiaoTangQiDaoXing:gc_btn_buy()
    self.btn_buy:set_enable(true);
    HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_17"));
    self:UpdateUi();
end

function UiJiaoTangQiDaoXing:vip_too_low()
    HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_18"));
end

function UiJiaoTangQiDaoXing:buy_number_max()
    HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_18"));
end

function UiJiaoTangQiDaoXing:on_player_info()
    self.after_get_reward = EAfterGetReward.chanllenge;
    local tempHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    if not self.ui_info then
        self.ui_info = UiJiaoTangQiDaoInfo:new();
    else
        self.ui_info:Show();
        self.ui_info:UpdateUi();
    end
    --msg_activity.cg_churchpray_enter_church(tempHeroID, self.enterStar);
end

-- function UiJiaoTangQiDaoXing:gc_churchpray_enter_church(star, rolelist)
--     if not self.ui_info then
--         self.ui_info = UiJiaoTangQiDaoInfo:new();
--     else
--         self.ui_info:Show();
--         self.ui_info:UpdateUi();
--     end
-- end

function UiJiaoTangQiDaoXing:gc_churchpray_sync_myself_info(buyChallengeTimes, thirdPartChallengeTimes, myPoslist)
    self:UpdateUi();
end

function UiJiaoTangQiDaoXing:gc_leave_activity()
    self:UpdateUi();
end

function UiJiaoTangQiDaoXing:ShowTips(isShow, isLow)
    self.panel_tips:set_active(isShow);
    self.lab_red:set_active(isLow);
    local star = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(1);
    local strs = string.format(PublicFunc.GetWord("jiaotangqidao_12"), tonumber(star));
    self.lab_tips:set_text(strs);
end

function UiJiaoTangQiDaoXing:HideTips()
    self.panel_tips:set_active(false);
end
