FightSetUI = 
{
	ui = nil,
    isShow = false,
};

local pathRes = "assetbundles/prefabs/ui/set_ui/ui_fight_set.assetbundle";
function FightSetUI.Start()
    FightSetUI.isShow = false;
	FightSetUI.LoadAsset();
end

function FightSetUI.LoadAsset()
    ResourceLoader.LoadAsset(pathRes, FightSetUI.OnLoaded);
end

function FightSetUI.OnLoaded(pid, filepath, asset_obj, error_info)
	if filepath == pathRes then
		FightSetUI.InitUI(asset_obj);
	end
end

function FightSetUI.GetResList()
	return pathRes;
end

function FightSetUI.InitUI(asset)
	FightSetUI.ui = asset_game_object.create(asset);
	FightSetUI.ui:set_name("fight_set");
	FightSetUI.ui:set_parent(Root.get_root_ui_2d());
    FightSetUI.ui:set_local_scale(Utility.SetUIAdaptation());
	FightSetUI.ui:set_local_position(0, 0, 0);
	FightSetUI.ui:set_active(FightSetUI.isShow);

    local path = "centre_other/animation/"

    local btn = ngui.find_button(FightSetUI.ui, path .. 'content_di_754_458/btn_cha')
    btn:set_on_click("FightSetUI.onClickBackBtn")
	
	--音乐开按钮
	FightSetUI.spMusicOpen = ngui.find_sprite(FightSetUI.ui, path .. "yeka/yeka_music/animation/sp_lv");
	FightSetUI.spMusicOpen:set_on_ngui_click("FightSetUI.onMusicOpen");
	FightSetUI.musicOpen = true;
	
	--音效开按钮
	FightSetUI.spSoundOpen = ngui.find_sprite(FightSetUI.ui, path .. "yeka/yeka_effect/animation/sp_lv");
	FightSetUI.spSoundOpen:set_on_ngui_click("FightSetUI.onSoundOpen");
	FightSetUI.soundOpen = true;

    --智能施法
    FightSetUI.spSmartOpen = ngui.find_sprite(FightSetUI.ui, path .. "yeka/yeka_smart/animation/sp_lv");
    FightSetUI.spSmartOpen:set_on_ngui_click("FightSetUI.onSmartOpen");
	FightSetUI.smartOpen = true;
	
	--抗锯齿
	FightSetUI.spAAOpen = ngui.find_sprite(FightSetUI.ui, path .. "yeka/yeka_juchi/animation/sp_lv");
	FightSetUI.spAAOpen:set_on_ngui_click("FightSetUI.onAAOpen");
	FightSetUI.screenAAOpen = true;

    --自动控制
    FightSetUI.spAutoControl = ngui.find_sprite(FightSetUI.ui, path .. "yeka/yeka_xxx/animation/sp_lv");
    FightSetUI.spAutoControl:set_on_ngui_click("FightSetUI.onAutoControl");
    FightSetUI.autoControlOpen = not g_dataCenter.setting:GetManualSet();
	
	FightSetUI.btnExit = ngui.find_button(FightSetUI.ui, path .. "btn");	-- 退出战斗

	FightSetUI.toggleMusic = ngui.find_toggle(FightSetUI.ui, path .. "yeka/yeka_music/animation/sp_lv");
	FightSetUI.toggleSound = ngui.find_toggle(FightSetUI.ui, path .. "yeka/yeka_effect/animation/sp_lv");
    FightSetUI.toggleSmart = ngui.find_toggle(FightSetUI.ui, path .. "yeka/yeka_smart/animation/sp_lv");    
	FightSetUI.toggleAA = ngui.find_toggle(FightSetUI.ui, path .. "yeka/yeka_juchi/animation/sp_lv");
    FightSetUI.toggleAutoControl = ngui.find_toggle(FightSetUI.ui, path .. "yeka/yeka_xxx/animation/sp_lv");

	FightSetUI.btnExit:set_on_click("FightSetUI.onExit");

    FightSetUI.isInitQuality = 3;
    FightSetUI.huazhi1 = ngui.find_toggle(FightSetUI.ui, path .. 'yeka_pinzhi/yeka/txt1')
    FightSetUI.huazhi1:set_on_change('FightSetUI.onHuaZhiChange')
    FightSetUI.huazhi2 = ngui.find_toggle(FightSetUI.ui, path .. 'yeka_pinzhi/yeka/txt2')
    FightSetUI.huazhi2:set_on_change('FightSetUI.onHuaZhiChange')
    FightSetUI.huazhi3 = ngui.find_toggle(FightSetUI.ui, path .. 'yeka_pinzhi/yeka/txt3')
    FightSetUI.huazhi3:set_on_change('FightSetUI.onHuaZhiChange')

    FightSetUI.renshu1 = ngui.find_toggle(FightSetUI.ui, path .. 'yeka_num_people/yeka/txt1')
    FightSetUI.renshu1:set_on_change('FightSetUI.onRenShuChange')
    FightSetUI.renshu2 = ngui.find_toggle(FightSetUI.ui, path .. 'yeka_num_people/yeka/txt2')
    FightSetUI.renshu2:set_on_change('FightSetUI.onRenShuChange')
    FightSetUI.renshu3 = ngui.find_toggle(FightSetUI.ui, path .. 'yeka_num_people/yeka/txt3')
    FightSetUI.renshu3:set_on_change('FightSetUI.onRenShuChange')

    FightSetUI.lblhuazhi1 = ngui.find_label(FightSetUI.ui, path .. 'yeka_pinzhi/yeka/txt1/lab')
    FightSetUI.lblhuazhi2 = ngui.find_label(FightSetUI.ui, path .. 'yeka_pinzhi/yeka/txt2/lab')
    FightSetUI.lblhuazhi3 = ngui.find_label(FightSetUI.ui, path .. 'yeka_pinzhi/yeka/txt3/lab')
    FightSetUI.lblrenshu1 = ngui.find_label(FightSetUI.ui, path .. 'yeka_num_people/yeka/txt1/lab')
    FightSetUI.lblrenshu2 = ngui.find_label(FightSetUI.ui, path .. 'yeka_num_people/yeka/txt2/lab')
    FightSetUI.lblrenshu3 = ngui.find_label(FightSetUI.ui, path .. 'yeka_num_people/yeka/txt3/lab')

	FightSetUI.UpdateUi();
end

function FightSetUI.UpdateUi()
	FightSetUI.musicOpen = g_dataCenter.setting:GetMusic();
	FightSetUI.soundOpen = g_dataCenter.setting:GetSound();
    FightSetUI.smartOpen = g_dataCenter.setting:Getintelligence();
	FightSetUI.screenAAOpen = g_dataCenter.setting:GetscreenAA();
	FightSetUI.toggleMusic:set_value(FightSetUI.musicOpen);
	FightSetUI.toggleSound:set_value(FightSetUI.soundOpen);
    FightSetUI.toggleSmart:set_value(FightSetUI.smartOpen);    
	FightSetUI.toggleAA:set_value(FightSetUI.screenAAOpen);
    FightSetUI.toggleAutoControl:set_value(FightSetUI.autoControlOpen);
    for i = 1, 3 do
        FightSetUI["huazhi"..i]:set_enable(not FightSetUI.autoControlOpen);
        FightSetUI["renshu"..i]:set_enable(not FightSetUI.autoControlOpen);
    end    
    FightSetUI.lblhuazhi1:set_color(1, 1, 1, 1)
    FightSetUI.lblhuazhi2:set_color(1, 1, 1, 1)
    FightSetUI.lblhuazhi3:set_color(1, 1, 1, 1)
    local value = tonumber(g_dataCenter.setting:GetHuazhiValue())
    
    for i = 1, 3 do
        FightSetUI["huazhi"..i]:set_value(value == i);
        if value == i then
            FightSetUI.SetYellowColor(FightSetUI["lblhuazhi"..i]);
        end
    end

    value = tonumber(g_dataCenter.setting:GetRenshuValue())
    for i = 1, 3 do
        FightSetUI["renshu"..i]:set_value(value == i);
    end

	-- g_dataCenter.setting:Update();
end

function FightSetUI.onSwitch()
	-- TODO
end

function FightSetUI.onService()
	-- TODO
    UiAnn.Start(UiAnn.Type.KeFu)
end

function FightSetUI.onExit()
	if GuideManager.IsGuideRuning() then
    	HintUI.SetAndShow(EHintUiType.zero, "引导进行中, 不能退出")
    	return
	end
	--类型
    local pmType = FightScene.GetPlayMethodType();
    
    
    --app.log("pmType #############"..tostring(pmType))
    
    --关卡需要发消息
    if pmType == nil then
    	local btn1Data = {str="确定", func=FightSetUI.OnSureExit};
    	local btn2Data = {str="取消"};
    	HintUI.SetAndShow(EHintUiType.two, "是否要退出战斗，退出战斗将不会获得任何奖励。", btn1Data, btn2Data);
    	return;
    elseif pmType == MsgEnum.eactivity_time.eActivityTime_CloneFight then
	    --app.log("###@@@@@@@@@@@@@@@@@@@@@@@@@@")
	    msg_clone_fight.cg_end_fight(-1,FightScene.GetFightManager():GetFightUseTime())
    elseif pmType == MsgEnum.eactivity_time.eActivityTime_WorldBoss then
    	--[[local npc = g_dataCenter.fight_info:GetNPCByNPCID(g_dataCenter.worldBoss:GetNPCID())
    	if g_dataCenter.player:CaptionIsAutoFight() then
    		GetMainUI():GetOptionTipUI():SetAutoBtn(false)
    		GetMainUI():GetOptionTipUI():ClickTrusteeship(false)
    		--ObjectManager.ChangeCaptainFightMode(false)
    		FightScene.GetFightManager().npc_wait_captain = npc
    	else
    		FightScene.GetFightManager():MoveCaptainToNpc(npc)
    	end
    	FightSetUI.onBack()
    	return]]
    elseif pmType == MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao then
		
	local HeroId = g_dataCenter.ChurchBot:getMyTeam1()--g_dataCenter.player:GetTeam(g_dataCenter.ChurchBot:getteamtype(g_dataCenter.ChurchBot:getmyprayIndex()))
   
        local HeroId2 = g_dataCenter.ChurchBot:getMyTeam2();--g_dataCenter.player:GetTeam(g_dataCenter.ChurchBot:getteam2type(g_dataCenter.ChurchBot:getmyprayIndex()))
        local tempHeroId = ""
        
        local nstar = g_dataCenter.ChurchBot:getnstar()
                
        for k,v in pairs(HeroId) do
            if tempHeroId == "" then
                tempHeroId = v
            else
                tempHeroId = tempHeroId..";"..v
            end
        end
        
        if #HeroId == 1 then
            tempHeroId = tempHeroId..";".."0;0"
        elseif #HeroId == 2 then
            tempHeroId = tempHeroId..";".."0"
        end
        
        if HeroId2 then
            
            for k,v in pairs(HeroId2) do
                tempHeroId = tempHeroId..";"..v
            end
            
        end
        
        local targetplayerinfo = g_dataCenter.ChurchBot:getFindRoleData()
        local posIndex = targetplayerinfo.posIndex
        local myprayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
        
        local param = {}
        param[1] = tempHeroId
        param[2] = tostring(targetplayerinfo.playerGid)
        param[3] = tostring(nstar)
        param[4] = tostring(posIndex)
        param[5] = myprayIndex
        param[6] = tostring(FightScene.GetFightManager():GetFightUseTime())
        param[7] = g_dataCenter.ChurchBot:GetIsAutoFight()
		--msg_activity.cg_leave_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, 2, param);
		
	elseif pmType == MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox then
		local npc = g_dataCenter.fight_info:GetNPCByNPCID(g_dataCenter.worldTreasureBox:GetNPCID())
		FightScene.GetFightManager():MoveCaptainToNpc(npc)
		FightSetUI.onBack();
		return
    --高速狙击
    elseif pmType == MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang then
        local param = {[1]=tostring(FightScene.GetFightManager().score)};
        param[2] = tostring(g_dataCenter.activity[pmType].difficultLevel);
        param[3] = tostring(FightScene.GetFightManager():GetFightUseTime());
        param[4] = g_dataCenter.activity[pmType]:GetIsAutoFight()
        local isWin = 2;
        msg_activity.cg_leave_activity(pmType, isWin, param);
    --保卫战
    elseif pmType == MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi then
        local killedWave = g_dataCenter.activity[pmType].killedWave or 0
        local maxWave = g_dataCenter.activity[pmType].maxWave or 0
        local difficultyIndex = g_dataCenter.activity[pmType].difficultyIndex or 1
        local param = {[1]=tostring(killedWave+1)};
        param[2] = tostring(difficultyIndex);
        param[3] = tostring(FightScene.GetFightManager():GetFightUseTime());
        param[4] = g_dataCenter.activity[pmType]:GetIsAutoFight()
        local isWin = 2;
        msg_activity.cg_leave_activity(pmType, isWin, param);
    --小丑计划
    elseif pmType == MsgEnum.eactivity_time.eActivityTime_ClownPlan then
        local param = {};
        param[1] = tostring(g_dataCenter.activity[pmType].difficultLevel);
        param[2] = tostring(ClownPlanFightManager.total_damage);
        param[3] = tostring(g_dataCenter.activity[pmType]:GetBossMaxHp());
        param[4] = tostring(FightScene.GetFightManager():GetFightUseTime());
        param[5] = g_dataCenter.activity[pmType]:GetIsAutoFight()
        --app.log("use_time==="..param[4]);
        local isWin = 2;
        msg_activity.cg_leave_activity(pmType, isWin, param);
    --极限挑战
    elseif pmType == MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa then
        local param = {};
        param[1] = tostring(g_dataCenter.activity[pmType].hurdle_id);
        param[2] = tostring(g_dataCenter.activity[pmType].challengeFloor);
        param[3] = tostring(FightScene.GetFightManager():GetFightUseTime());
        param[4] = g_dataCenter.activity[pmType]:GetIsAutoFight()
        local isWin = 2;
        msg_activity.cg_leave_activity(pmType, isWin, param);
    --竞技场
    elseif pmType == MsgEnum.eactivity_time.eActivityTime_arena then
        local param = {};
        param[1] = tostring(g_dataCenter.activity[pmType].hurdle_id);
        param[2] = tostring(g_dataCenter.activity[pmType].arenaPlayer.playerid);
        param[3] = tostring(g_dataCenter.activity[pmType].arenaPlayer.rank)
        param[4] = tostring(FightScene.GetFightManager():GetFightUseTime());
        local isWin = 2;
        msg_activity.cg_leave_activity(pmType, isWin, param);
    end
    
    if FightScene.GetFightManager() then
		FightScene.GetFightManager():FightOver(true);
	end
	FightSetUI.onBack();
end

function FightSetUI.OnSureExit()

    local hurdleid = FightScene.GetCurHurdleID()
    local isAuto = PublicFunc.GetIsAuto(hurdleid)

	msg_hurdle.cg_hurdle_fight_result(hurdleid, FightScene.GetFightManager():GetFightUseTime(), isAuto, -1);
	if FightScene.GetFightManager() then
		FightScene.GetFightManager():FightOver(true);
	end
	FightSetUI.onBack();
end

function FightSetUI.onClickBackBtn()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        AudioManager.ChangeBackAudioVol(1, 2000)
    end
    FightSetUI.onBack()
end

function FightSetUI.onBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        PublicFunc.UnityResume();
    end
	FightSetUI.Hide();
	g_dataCenter.setting:WriteFile();
end

function FightSetUI.logout()
	if GuideManager.IsGuideRuning() then
		FloatTip.Float("引导进行中, 不能登出")
    	return
	end
	FightSetUI.onBack();
	GameBegin.usercenter_logout_callback();
end

function FightSetUI.onMusicOpen()

    FightSetUI.musicOpen = not FightSetUI.musicOpen;
    g_dataCenter.setting:SetMusic(FightSetUI.musicOpen);
    g_dataCenter.setting:Update();
end

-- function FightSetUI.onMusicClose()
-- 	AudioManager.MuteAudio(true,ENUM.EAudioType._2d);
-- 	AudioManager.MuteAudio(true,ENUM.EAudioType.UI);
-- end

function FightSetUI.onSoundOpen()
	FightSetUI.soundOpen = not FightSetUI.soundOpen;
	g_dataCenter.setting:SetSound(FightSetUI.soundOpen);
	g_dataCenter.setting:Update();
end

function FightSetUI.onSmartOpen()
    FightSetUI.smartOpen = not FightSetUI.smartOpen;
    g_dataCenter.setting:Setintell(FightSetUI.smartOpen);
    g_dataCenter.setting:Update();

    --app.log('FightSetUI.onSmartOpen ' .. tostring(FightSetUI.smartOpen))
end

function FightSetUI.onAAOpen()
	FightSetUI.screenAAOpen = not FightSetUI.screenAAOpen;
    g_dataCenter.setting:SetscreenAA(FightSetUI.screenAAOpen);
    g_dataCenter.setting:Update();
end 

function FightSetUI.onAutoControl()
    FightSetUI.autoControlOpen = not FightSetUI.autoControlOpen;
    if FightSetUI.autoControlOpen then
        local systemId = FightScene.GetPlayMethodType();
        if systemId == nil then
            systemId = MsgEnum.eactivity_time.eActivityTime_Adventure;
        end
        if systemId ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
            g_dataCenter.setting:SetHuazhiValue(3);
            g_dataCenter.setting:SetQualitySettingIndex(2);
            g_dataCenter.setting:SetRenshuValueSystem(systemId, 1);
            g_dataCenter.setting:SetQualitySettingIndexSystem(systemId, 0);
            g_dataCenter.setting:SetAutoQualityDowning(systemId, false);
            FightSetUI.SetYellowColor(FightSetUI.lblhuazhi3);
            g_dataCenter.setting:SetRenshuValue(3);
            FightSetUI.SetYellowColor(FightSetUI.lblrenshu3);
        end
    end
    --设置手动自动必须放在最后
    g_dataCenter.setting:SetManualSet(not FightSetUI.autoControlOpen);
    g_dataCenter.setting:Update();
    FightSetUI.UpdateUi();
end

function FightSetUI.onHuaZhiChange()
    FightSetUI.isInitQuality = FightSetUI.isInitQuality - 1;
    if FightSetUI.isInitQuality >= 0 then
        return;
    end
    local value1 = FightSetUI.huazhi1:get_value()
    local value2 = FightSetUI.huazhi2:get_value()
    local value3 = FightSetUI.huazhi3:get_value()
    
    FightSetUI.lblhuazhi1:set_color(1, 1, 1, 1)
    FightSetUI.lblhuazhi2:set_color(1, 1, 1, 1)
    FightSetUI.lblhuazhi3:set_color(1, 1, 1, 1)

    if value1 then
        g_dataCenter.setting:SetHuazhiValue(1)
        g_dataCenter.setting:SetQualitySettingIndex(0)
        FightSetUI.SetYellowColor(FightSetUI.lblhuazhi1)
    elseif value2 then
        g_dataCenter.setting:SetHuazhiValue(2)
        g_dataCenter.setting:SetQualitySettingIndex(1)
        FightSetUI.SetYellowColor(FightSetUI.lblhuazhi2)
    elseif value3 then
        g_dataCenter.setting:SetHuazhiValue(3)
        g_dataCenter.setting:SetQualitySettingIndex(2)
        FightSetUI.SetYellowColor(FightSetUI.lblhuazhi3)
    end
	g_dataCenter.setting:Update();
end

function FightSetUI.onRenShuChange()
    local value1 = FightSetUI.renshu1:get_value()
    local value2 = FightSetUI.renshu2:get_value()
    local value3 = FightSetUI.renshu3:get_value()

    FightSetUI.lblrenshu1:set_color(1, 1, 1, 1)
    FightSetUI.lblrenshu2:set_color(1, 1, 1, 1)
    FightSetUI.lblrenshu3:set_color(1, 1, 1, 1)

    if value1 then
        g_dataCenter.setting:SetRenshuValue(1)
        FightSetUI.SetYellowColor(FightSetUI.lblrenshu1)
    elseif value2 then
        g_dataCenter.setting:SetRenshuValue(2)
        FightSetUI.SetYellowColor(FightSetUI.lblrenshu2)
    elseif value3 then
        g_dataCenter.setting:SetRenshuValue(3)
        FightSetUI.SetYellowColor(FightSetUI.lblrenshu3)
    end
end

function FightSetUI.SetYellowColor(lbl)
    if lbl then
        lbl:set_color(255/255, 161/255, 39/255, 1)
    end
end

-- function FightSetUI.onSoundClose()
-- 	AudioManager.MuteAudio(true,ENUM.EAudioType._3d);
-- end

function FightSetUI.Show()
	app.log("---------")
	if FightSetUI.ui then
		FightSetUI.ui:set_active(true);
		FightSetUI.isShow = true;

        FightSetUI.UpdateUi();

		local hurdle_config = FightScene.GetHurdleConfig(FightScene.GetCurHurdleID())
		if hurdle_config and hurdle_config.forbit_exit == 1 then
			FightSetUI.btnExit:set_active(false)
		else
			FightSetUI.btnExit:set_active(true)
		end
	end
end

function FightSetUI.Hide()
	if FightSetUI.ui then
		FightSetUI.ui:set_active(false);
		FightSetUI.isShow = false;
	end
end

function FightSetUI.IsShow()
	return FightSetUI.isShow
end