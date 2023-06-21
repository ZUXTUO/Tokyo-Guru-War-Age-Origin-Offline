
--
function UiJiaoTangQiDaoMain:on_btn_enter()
    local enterStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetEnterJiaoTangIndex();
    local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero()
    if not heroid then
        heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1);
        if not heroid or heroid == "0" then
            HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_7"));
            return;
        end
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetTempChoseHero(heroid);
    end
    -- local teams = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
    -- for i=1,3 do
    --     if teams[i] == heroid then
    --         HintUI.SetAndShow(EHintUiType.zero,PublicFunc.GetWord("jiaotangqidao_8"));
    --         return
    --     end
    -- end
    

    --g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetEnterJiaoTangIndex(enterStar);
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetCurIndex(1);
    msg_activity.cg_churchpray_enter_church(heroid, enterStar);
    --self.btn_sure:set_enable(false);
end

function UiJiaoTangQiDaoMain:gc_btn_enter(enterStar, rolelist)
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single;
    local curStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(1);
    local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    local guaji_hero_id = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1);
    -- local tempHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    -- if not heroid then
    --     heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1);
    -- end
    local isPray = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(self.curIndex);
    local fs = FightStartUpInf:new()
    local hero = {heroid}
    local hurdle_id = ConfigManager.Get(EConfigIndex.t_jiao_tang_qi_dao_hurdle,enterStar).level;
    fs:SetLevelIndex(hurdle_id)
    local ex_data = {};

    --正在挂机
    if isPray then
        --换人了
        if heroid ~= guaji_hero_id then
            ex_data.isShow = false;
            ex_data.pos = -1;  --出现的位置
            fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, hero,ex_data)
        --没换
        else
            --挂机教堂==进入教堂
            if curStar == enterStar then
                local pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetChurchPosIndex(1);
                ex_data.isShow = true;
                if enterStar == 1 then
                    ex_data.pos = 0;
                else
                    ex_data.pos = pos;  --1星教堂永远站在0的位置
                end
                fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, hero,ex_data)
            --挂机教堂~=进入教堂
            else
                ex_data.isShow = false;
                ex_data.pos = -1;  --出现的位置
                fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, hero,ex_data)
            end
        end
    --没挂机
    else
        ex_data.isShow = false;
        ex_data.pos = -1;  --出现的位置
        fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, hero,ex_data)
    end

    local burchhero = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.burchhero)
    local length = #burchhero-2;
    if enterStar == 1 then
        for i=1, length do
            local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(enterStar,i);
            if enemy_player then
                local other_ex_data = {};
                local defTeam = enemy_player:GetDefTeam()
                local enemyID = defTeam[1];
                if enemyID == heroid then   --教堂中所有人中，有当前选择的人
                    --不添加
                    --app.log("教堂中有自己在祈祷");
                else
                    other_ex_data.isShow = true;
                    other_ex_data.pos = i;
                    fs:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, enemy_player, enemy_player.package, EFightPlayerType.human, defTeam, other_ex_data);
                end
            else
                --app.log("pos=="..i.."没有人");
            end
        end
    else
        for i=0, length do
            local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(enterStar,i);
            if enemy_player then
                --app.log("star=="..enterStar.."pos=="..i.."有人");
                local other_ex_data = {};
                local defTeam = enemy_player:GetDefTeam()
                local enemyID = defTeam[1];
                if enemyID == heroid then   --教堂中所有人中，有当前选择的人
                    --不添加
                else
                    other_ex_data.isShow = true;
                    other_ex_data.pos = i;
                    fs:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, enemy_player, enemy_player.package, EFightPlayerType.human, defTeam, other_ex_data);
                end
            else
                --app.log("pos=="..i.."没有人");
            end
        end
    end
    app.opt_enable_net_dispatch(false);
    --Socket.StopPingPong()
    SceneManager.PushScene(FightScene,fs);
    --assetMgr:DeleteAll();
end

-- function UiJiaoTangQiDaoMain:gc_btn_enter(enterStar, rolelist)
--     --enterStar = 1;
--     self.curIndex = 1;
--     PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single;
--     self.btn_sure:set_enable(true);
--     local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
--     if not heroid then
--         heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1);
--     end
--     local isPray = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(self.curIndex);
--     local fs = FightStartUpInf:new()
--     local hero = {heroid}
--     local hurdle_id = ConfigManager.Get(EConfigIndex.t_jiao_tang_qi_dao_hurdle,enterStar).level;
--     fs:SetLevelIndex(hurdle_id)
--     local ex_data = {};
--     local curStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(self.curIndex);
--     if isPray then
--         local pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetChurchPosIndex(self.curIndex);
--         if enterStar == curStar then
--             ex_data.isShow = true;
--             if enterStar == 1 then
--                 ex_data.pos = 0;
--             else
--                 ex_data.pos = pos;  --1星教堂永远站在0的位置
--             end
--             fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, hero,ex_data)
--         else
--             --正在其他教堂祈祷
--             ex_data.isShow = false;
--             ex_data.pos = -1;  --出现的位置
--             fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, hero,ex_data)
--         end
--     else
--         ex_data.isShow = true;
--         ex_data.pos = -1;
--         fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, hero,ex_data)
--     end

--     local burchhero = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.burchhero)
--     local length = #burchhero-2;
--     if enterStar == 1 then
--         for i=1, length do
--             local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(enterStar,i);
--             if enemy_player then
--                 local other_ex_data = {};
--                 local defTeam = enemy_player:GetDefTeam()
--                 local enemyID = defTeam[1];
--                 if enemyID == heroid then   --教堂中所有人中，有当前选择的人
--                     --不添加
--                     --app.log("教堂中有自己在祈祷");
--                 else
--                     other_ex_data.isShow = true;
--                     other_ex_data.pos = i;
--                     fs:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, enemy_player, enemy_player.package, EFightPlayerType.human, defTeam, other_ex_data);
--                 end
--             else
--                 --app.log("pos=="..i.."没有人");
--             end
--         end
--     else
--         for i=0, length do
--             local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(enterStar,i);
--             if enemy_player then
--                 --app.log("star=="..enterStar.."pos=="..i.."有人");
--                 local other_ex_data = {};
--                 local defTeam = enemy_player:GetDefTeam()
--                 local enemyID = defTeam[1];
--                 if enemyID == heroid then   --教堂中所有人中，有当前选择的人
--                     --不添加
--                 else
--                     other_ex_data.isShow = true;
--                     other_ex_data.pos = i;
--                     fs:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, enemy_player, enemy_player.package, EFightPlayerType.human, defTeam, other_ex_data);
--                 end
--             else
--                 --app.log("pos=="..i.."没有人");
--             end
--         end
--     end

--     SceneManager.PushScene(FightScene,fs);
--     assetMgr:DeleteAll();
-- end

function UiJiaoTangQiDaoMain:on_speed_up(t)
    -- local star = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(1);
    -- local cur_time = system.time();
    -- local pray_time = cur_time - self.begin_time;

    -- local left_time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetLeftTime(1);
    -- local real_left_time = left_time - pray_time;
    -- if real_left_time < 3600 then
    --     HintUI.SetAndShow(EHintUiType.two, "剩余时间不足1小时，是否继续花费"..tostring(ConfigManager.Get(EConfigIndex.t_church_pray_quick,star).cost).."钻石加速1小时",{str="确认",func=self.bindfunc["SpeedUp"]}, {str = "取消"});
    -- else
    --     HintUI.SetAndShow(EHintUiType.two, "是否花费"..tostring(ConfigManager.Get(EConfigIndex.t_church_pray_quick,star).cost).."钻石加速1小时",{str="确认",func=self.bindfunc["SpeedUp"]}, {str = "取消"});
    -- end
end

function UiJiaoTangQiDaoMain:SpeedUp()
    msg_activity.cg_churchpray_quick(1,1);
end

function UiJiaoTangQiDaoMain:gc_speed_up(result, index)
    self:UpdateUi();
    --HintUI.SetAndShow(EHintUiType.zero, "加速成功");
end

function UiJiaoTangQiDaoMain:on_get_reward(t)
    local index = 1;
    local cur_time = system.time();
    local pray_time = cur_time - self.begin_time;
    local old_pray_time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetPrayKeepTime(1);
    local exp = self:GetLocalTotalExp(pray_time+old_pray_time,index); 
    if exp >= ConfigManager.Get(EConfigIndex.t_item,20000021).exp then
        local strs = string.format(PublicFunc.GetWord("jiaotangqidao_9"), tonumber(exp));
        HintUI.SetAndShow(EHintUiType.two, strs,{str=PublicFunc.GetWord("public_1"),func=self.bindfunc["GetReward"]}, {str = PublicFunc.GetWord("public_2")});
    else
        HintUI.SetAndShow(EHintUiType.two, PublicFunc.GetWord("jiaotangqidao_10"),{str=PublicFunc.GetWord("public_1"),func=self.bindfunc["GetReward"]}, {str = PublicFunc.GetWord("public_2")});
    end
end
function UiJiaoTangQiDaoMain:GetReward()

    msg_activity.cg_churchpray_reward(1)
end

function UiJiaoTangQiDaoMain:gc_get_reward(result, expReward, index, vecReward)
    self:UpdateUi();
    if vecReward and type(vecReward) == "table" and #vecReward ~=0 then
        CommonAward.Start(vecReward, 1)
        CommonAward.SetFinishCallback(self.ChoseHero, self)
    else
        HintUI.SetAndShow(EHintUiType.one, PublicFunc.GetWord("jiaotangqidao_11"), {str = PublicFunc.GetWord("public_1"), func = self.bindfunc['ChoseHero']});
    end
end

function UiJiaoTangQiDaoMain:ChoseHero()
    uiManager:PushUi(EUI.UiJiaoTangQiDaoChoseHero);
end

function UiJiaoTangQiDaoMain:on_change_hero(t)
    self.is_show_dlg = true;
    if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(1) then
        -- self.panel_tips:set_active(true);
        local star = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(1);
        local str = string.format(PublicFunc.GetWord("jiaotangqidao_12"), tonumber(star));
        -- self.lab_panel_tips:set_text(str);
        local btn1 = { str="确定", func = self.bindfunc["on_sure"],};
        local btn2 = { str="取消", };
        HintUI.SetAndShow(2, str, btn1,btn2);
    else
        uiManager:PushUi(EUI.UiJiaoTangQiDaoChoseHero);
    end
    --uiManager:GetCurScene():SetData({curIndex = self.curIndex});
end

function UiJiaoTangQiDaoMain:on_change_equip(t)
    self.is_show_dlg = true;
    --uiManager:PushUi(EUI.BattleUI);
    local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero()
    if not heroid then
        heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1);
        if not heroid or heroid == "0" then
            uiManager:PushUi(EUI.UiJiaoTangQiDaoChoseHero);
            return
        end
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetTempChoseHero(heroid);
    end
    local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
    uiManager:PushUi(EUI.BattleUI);
    uiManager:GetCurScene():SetRoleNumber(cardinfo.number,true);
    --uiManager:GetCurScene():SetData({curIndex = self.curIndex});
end

function UiJiaoTangQiDaoMain:on_rule(t)
    UiRuleDes.Start(ENUM.ERuleDesType.JiaoTangGuaJi);
end

function UiJiaoTangQiDaoMain:on_show_dlg(t)
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetEnterJiaoTangIndex(t.float_value);
    --self.content_change_hero:set_active(true);
    self:on_btn_enter();
end

function UiJiaoTangQiDaoMain:on_hide_dlg()
    self.content_change_hero:set_active(false);
end

function UiJiaoTangQiDaoMain:on_sure()
    -- self.panel_tips:set_active(false);
    self:on_get_reward();
end

function UiJiaoTangQiDaoMain:on_cancel()
    self.panel_tips:set_active(false);
end
