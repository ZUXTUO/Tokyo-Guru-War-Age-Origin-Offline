SystemEnterFunc = {};
SystemEnterFunc.callback = {}
SystemEnterFunc.unregist_msg = {};

local _UIText = {
	["not_open"] = "[FF9800]%s[-]功能未开启",
}

function SystemEnterFunc.UnregistAllCallback()
	for k,v in pairs(SystemEnterFunc.unregist_msg) do
		v();
	end
end

script.run("logic/message/message_enum.lua");
local clear = false;
function SystemEnterFunc.SetClearStack(is_clear)
	clear = is_clear;
end

function SystemEnterFunc.CheckSystemId(systemid)
	local isOpen = true

	-- local cfg = ConfigManager.Get(EConfigIndex.t_develop_guide_data, systemid)
	-- if cfg and cfg.function_id and cfg.function_id ~= 0 then
	-- 	isOpen = 
	-- end
	isOpen = SystemEnterFunc.IsOpenFunc(systemid);

    return isOpen;
end

function SystemEnterFunc.IsOpenFunc(functionId)
	local isOpen = false
	-- 玩法限制作弊 (校园建设/保卫战/英雄历练/教堂挂机/奎库利亚/世界boss)
    local funcName = ""
    if g_dataCenter.gmCheat:noPlayLimit() then
        isOpen = true
    end

    local functionid = 0
    if isOpen == false then
    	local cfg = ConfigManager.Get(EConfigIndex.t_play_vs_data, functionId);
		if cfg then 
			funcName = cfg.name
			if g_dataCenter.player.level >= cfg.open_level then
				isOpen = true;
			end
		end
    end

    --功能未开启
    if isOpen == false then
		-- FloatTip.Float(string.format(_UIText["not_open"], funcName))
    end

    return isOpen;
end

function EnterSystemFunction(systemid)
	--app.log("......"..tostring(systemid))
	if not SystemEnterFunc.CheckSystemId(systemid) then
		return
	end
    if SystemEnterFunc[systemid] then
        SystemEnterFunc[systemid]()
    else
        app.log('system func id errror')
    end
end

------------------------高速狙击-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang] = function()
	-- PublicFunc.msg_regist(msg_activity.gc_activity_config,SystemEnterFunc.callback[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]);
 --    msg_activity.cg_activity_config(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang);
 	uiManager:PushUi(EUI.LevelActivity, 1)
end

SystemEnterFunc.unregist_msg[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang] = function()
	PublicFunc.msg_unregist(msg_activity.gc_activity_config,SystemEnterFunc.callback[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]);

end

SystemEnterFunc.callback[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang] = function()
	SystemEnterFunc.unregist_msg[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]();
	uiManager:PushUi(EUI.UiBaoWeiCanChang);
	if clear then
		uiManager:ClearStack();
	end
end

------------------------教堂祈祷-------------------------------------------
--SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao] = function()
--	PublicFunc.msg_regist(msg_activity.gc_churchpray_sync_myself_info,SystemEnterFunc.callback[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]);
--	msg_activity.cg_churchpray_request_myslef_info()
--end
--
--SystemEnterFunc.unregist_msg[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao] = function()
--	PublicFunc.msg_unregist(msg_activity.gc_churchpray_sync_myself_info,SystemEnterFunc.callback[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]);
--end
--
--SystemEnterFunc.callback[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao] = function()
--	SystemEnterFunc.unregist_msg[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]();
--	uiManager:PushUi(EUI.UiJiaoTangQiDaoMain);
--	if clear then
--		uiManager:ClearStack();
--	end
--end

------------------------保卫战-----------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi] = function()
	-- uiManager:PushUi(EUI.GaoSuJuJiUI);
	uiManager:PushUi(EUI.LevelActivity, 2)
	if clear then
		uiManager:ClearStack();
	end
end

---------------------------奎库利亚-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa] = function()
	uiManager:PushUi(EUI.KuiKuLiYaHurdleUI);
	if clear then
		uiManager:ClearStack();
	end
end

------------------------城建系统-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_SLG] = function()
    GLoading.Show(GLoading.EType.msg)
    msg_city_building.cg_player_enter_slg()
end

------------------------英雄历练-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu] = function()
	--uiManager:PushUi(EUI.EquipmentBaseUI);
	--if clear then
	--	uiManager:ClearStack();
	--end
end

------------------------世界boss-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_WorldBoss] = function()
	uiManager:PushUi(EUI.UiWorldBoss);
	if clear then
		uiManager:ClearStack();
	end
end

------------------------克隆战-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_CloneFight] = function()
	msg_clone_fight.cg_get_challenge_hero()
    msg_clone_fight.cg_get_team_info()
	if clear then
		uiManager:ClearStack();
	end
end

------------------------教堂挂机-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao] = function()
	uiManager:PushUi(EUI.ChurchBotMainUi);
	--if clear then
	--	uiManager:ClearStack();
	--end
end

------------------------自由PK-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_pvptest] = function()
	world_msg.cg_test_enter_world(1);
end

------------------------大乱斗10人-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_fuzion2] = function()
	--world_msg.cg_test_enter_world(1);
	uiManager:PushUi(EUI.Fuzion2MainUI);
end
------------------------大乱斗-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_fuzion] = function()
	--world_msg.cg_test_enter_world(1);
	uiManager:PushUi(EUI.FuzionMainUI);
end


------------------------竞技场-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_arena] = function()
	uiManager:PushUi(EUI.ArenaMainUI);
	if clear then
		uiManager:ClearStack();
	end
    -- world_msg.cg_test_enter_world(1);
end

------------------------青铜基地-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_threeToThree] = function()
	uiManager:PushUi(EUI.QingTongJiDiEnterUI);
	-- FloatTip.Float("此功能此包暂未开放");
end

------------------------关卡冒险-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Adventure] = function()
	uiManager:PushUi(EUI.UiLevel);
	if clear then
		uiManager:ClearStack();
	end
end

------------------------日常任务-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Task] = function()
	uiManager:PushUi(EUI.UiDailyTask);
	if clear then
		uiManager:ClearStack();
	end
end

------------------------扭蛋英雄-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Recruit] = function()
	local result = uiManager:PushUi(EUI.EggHeroUi);
	if clear then
		uiManager:ClearStack();
	end
end

------------------------队长吃经验药水-----------------------------------------
-- SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_RoleUpgradeLevel] = function()
-- 	uiManager:PushUi(EUI.BattleUI);
-- 	local team = g_dataCenter.player:GetDefTeam();
-- 	local heroid = team[1];
-- 	local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
-- 	uiManager:GetCurScene():SetRoleNumber(cardinfo.number,true);
-- 	--uiManager:PushUi(EUI.RoleUpexpUI,{info=cardinfo});
-- 	-- if clear then
-- 	-- 	uiManager:ClearStack();
-- 	-- end
-- end

------------------------队长升星-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_RoleUpgradeStar] = function()
	uiManager:PushUi(EUI.BattleUI);
	local team = g_dataCenter.player:GetDefTeam();
	local heroid = team[1];
	local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
	uiManager:GetCurScene():SetRoleNumber(cardinfo.number,true);
	--uiManager:PushUi(EUI.HeroStarUp,{info=cardinfo});
end

------------------------队长潜能强化-------------------------------------------
-- SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_RoleUpgradeStar] = function()
-- 	uiManager:PushUi(EUI.BattleUI);
-- 	local team = g_dataCenter.player:GetDefTeam();
-- 	local heroid = team[1];
-- 	local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
-- 	uiManager:GetCurScene():SetRoleNumber(cardinfo.number,true);
-- end

------------------------队长连协-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Contact] = function()
	uiManager:PushUi(EUI.BattleUI);
	local team = g_dataCenter.player:GetDefTeam();
	local heroid = team[1];
	local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
	uiManager:GetCurScene():SetRoleNumber(cardinfo.number,true);
end

------------------------扭蛋武器-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Equip] = function()
	--local result = uiManager:PushUi(EUI.EggEquipUi);
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.EquipBox);
	if clear then
		uiManager:ClearStack();
	end
end

------------------------装备合成-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_equipComposite] = function()
	uiManager:PushUi(EUI.EquipCompoundUI);
	if clear then
		uiManager:ClearStack();
	end
end

-----------------------月签到----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_checkinMonth] = function()
	uiManager:PushUi(EUI.ActivityUI);
	if clear then
		uiManager:ClearStack();
	end
end

-----------------------充值----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Recharge] = function()
	uiManager:PushUi(EUI.StoreUI);
end

-----------------------七日签到----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_checkin7] = function()
	uiManager:PushUi(EUI.SevenSignUi);
	if clear then
		uiManager:ClearStack();
	end
end

-----------------------vip功能----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_GiftBag] = function()
 	--HintUI.SetAndShow(EHintUiType.zero, "vip未开启");
	uiManager:PushUi(EUI.VipPackingUI);
	if clear then
		uiManager:ClearStack();
	end
end

-----------------------装备升级----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_EquipLevel] = function()
	uiManager:PushUi(EUI.EquipPackageUI);
	if clear then
		uiManager:ClearStack();
	end
end

-----------------------装备升星----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_EquipStar] = function()
	uiManager:PushUi(EUI.EquipPackageUI, {eType = 2});
	if clear then
		uiManager:ClearStack();
	end
end

-----------------------英雄升星----------------------------
-- SystemEnterFunc[ENUM.SystemID.HeroStarUp] = function()
-- 	uiManager:PushUi(EUI.UiHeroStarUpEgg);
-- 	if clear then
-- 		uiManager:ClearStack();
-- 	end
-- end

-----------------------月卡----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_MonthCard] = function()
	uiManager:PushUi(EUI.ActivityUI, {activity_id = ENUM.Activity.activityType_month_card});
	if clear then
		uiManager:ClearStack();
	end
end

-----------------------尊享卡----------------------------
-- SystemEnterFunc[ENUM.SystemID.VipCard] = function()
-- 	uiManager:PushUi(EUI.ActivityUI, {defPageName = ActivityPageMap.MonthCardUI.name});
-- 	if clear then
-- 		uiManager:ClearStack();
-- 	end
-- end

-----------------------挑战界面----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Playing] = function()
	-- CommomPlayUI.SetIndex(2)
    uiManager:PushUi(EUI.ChallengeEnterUI);
    if clear then
		uiManager:ClearStack();
	end
end

-----------------------竞技界面----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Fight] = function()
	-- CommomPlayUI.SetIndex(1)
    uiManager:PushUi(EUI.AthleticEnterUI);
    if clear then
		uiManager:ClearStack();
	end
end

-----------------------对决界面----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Duel] = function()
	uiManager:PushUi(EUI.DuelEnterUI);
	if clear then
		uiManager:ClearStack();
	end
end

-----------------------公会界面----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Guild] = function()
	-- 等级开启条件
    if PublicFunc.IsOpenRealFunction(MsgEnum.eactivity_time.eActivityTime_Guild) then
        -- 打开我的公会
        if g_dataCenter.guild:IsJoinedGuild() then
            uiManager:PushUi(EUI.GuildMainUI);
        -- 打开公会申请
        else
            -- 先清除老的公会列表数据
            g_dataCenter.guild.simpleList = nil
			-- 检查是否弹出选区界面（与新手引导流程一致）
			local check = function()
				AdvFuncButton.CheckChangeArea();
			end
            -- 打开公会浏览列表
            uiManager:PushUi(EUI.GuildLookUI, check);
        end
        if clear then
	        uiManager:ClearStack();
	    end
    end
end

---------------------世界宝箱----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox] = function()
	uiManager:PushUi(EUI.WorldTreasureBoxUI);
	if clear then
		uiManager:ClearStack();
	end
	--msg_world_treasure_box.cg_enter_world_treasure_box()
end

---------------------社团boss----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_GuildBoss] = function()
	uiManager:PushUi(EUI.UiGuildBoss);
	if clear then
		uiManager:ClearStack();
	end
end

-- 进入MMO世界
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_openWorld] = function()
    world_msg.cg_enter_open_world(1)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Mask] = function()
	uiManager:PushUi(EUI.MaskMain);
end

-----------------------天赋界面----------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_TalentSystem] = function()
	uiManager:PushUi(EUI.TalentSystemUI);
	app.log("进入天赋界面")
end

---------------------角色图鉴界面--------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_RolePokedex] = function()
	app.log("进入角色图鉴界面")
        --uiManager:PushUi( EUI.HeroIllumstrationUI );
        uiManager:PushUi( EUI.HeroIllumstrationMain );
end

----------------------研究所界面---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_GraduateSchool] = function()
	app.log("进入研究所界面")
	uiManager:PushUi(EUI.InstituteUI);
end

----------------------训练场界面---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Trainning] = function()
	app.log("进入训练场界面")
	uiManager:PushUi(EUI.TrainningMain);
end

----------------------守护之心--------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_GuardHeart] = function()
	app.log("进入守护之心界面")
	uiManager:PushUi(EUI.GuardHeartMainUi);
end

----------------------角色升级---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_RoleUpgradeLevel] = function()
	local team = g_dataCenter.player:GetDefTeam();
	local heroid = team[1];
	local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
	uiManager:PushUi(EUI.BattleUI, {defToggle = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeLevel,cardInfo=cardinfo,is_player=true});			
end

----------------------角色升星---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_RoleUpgradeStar] = function()
	local team = g_dataCenter.player:GetDefTeam();
	local heroid = team[1];
	local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
	uiManager:PushUi(EUI.BattleUI, {defToggle = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeStar,cardInfo=cardinfo,is_player=true});
end

----------------------角色升品---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_RoleUpgradeRarity] = function()
	local team = g_dataCenter.player:GetDefTeam();
	local heroid = team[1];
	local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
	uiManager:PushUi(EUI.BattleUI, {defToggle = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeRarity,cardInfo=cardinfo,is_player=true});
end

----------------------技能升级---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_RoleUpgradeSkill] = function()
	local team = g_dataCenter.player:GetDefTeam();
	local heroid = team[1];
	local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
	uiManager:PushUi(EUI.BattleUI, {defToggle = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeSkill,cardInfo=cardinfo,is_player=true});	 
end

----------------------购买金币---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_BuyGold] = function()
		uiManager:PushUi(EUI.GoldExchangeUI);
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_exchangeGold] = function()
		uiManager:PushUi(EUI.GoldExchangeUI);
end

----------------------购买体力---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_BuyAp] = function()
	-- Player.ShowBuyAp();
	HpExchange.popPanel();
end

----------------------进入精英关卡---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_EliteLevel] = function()
    if g_dataCenter.hurdle:IsEliteOpen() then
		uiManager:PushUi(EUI.UiLevel, {goSelectTab = EHurdleType.eHurdleType_elite});
	end
end


SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ClownPlan] = function()
	uiManager:PushUi(EUI.LevelActivity, 3)
--	    local fs = FightStartUpInf:new()
--        fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_ClownPlan)  
--        fs:SetLevelIndex(60122000)	
--		local defTeam = g_dataCenter.player:GetDefTeam()
--        fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam )
--        SceneManager.PushScene(FightScene,fs)
--        uiManager:ClearStack()
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_FindLs] = function()
	if g_dataCenter.guild:IsJoinedGuild() then
		uiManager:PushUi(EUI.GuildFindLsUI)	
	else
		FloatTip.Float("你还没有加入任何社团！")
	end
end

------------------------角色历练-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_heroTrial] = function()
	uiManager:PushUi(EUI.HeroTrialUI);
end

------------------------聊天对决-------------------------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_1v1] = function()
	uiManager:PushUi(EUI.ChatFightMainUI);
end

----------------------进入商店---------------------------
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Shop] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.SUNDRY)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_Equip] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.EquipBox)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopSundry] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.SUNDRY)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopArena] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.ARENA)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ThreeToThree] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.ThreeToThree)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopFuzion] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.FUZION)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopKuikuliya] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.KKLY)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopMystery] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.MYSTERY)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopGuild] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.Guild)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopTrial] = function()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.Trial)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopVip] = function()
    g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.VIP)
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_trial] = function()
	if g_dataCenter.trial:CanEnter() then 
		uiManager:PushUi(EUI.ExpeditionTrialMap);
	else 
		FloatTip.Float("远征试炼还未开放");
	end
end

SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_LevelActivity] = function()
	uiManager:PushUi(EUI.LevelActivity);
end

--首充
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_FirsetRecharge] = function()
	local firstRechargeType = g_dataCenter.player:GetFirstRechargeType();

	if firstRechargeType and firstRechargeType == ENUM.ETypeFirstRecharge.haveGet then
		FloatTip.Float("已参加过首充活动！");
	else
		uiManager:PushUi(EUI.UiFirstRecharge);
	end
end

--战力排行榜活动
SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_PowerRank] = function()
	local is_active = g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_power_rank) and SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_PowerRank);
	if is_active then	
		uiManager:PushUi(EUI.PowerRankUI)
	else
		FloatTip.Float("战力排行榜活动已结束！");
	end
end

function SystemEnterFunc.AcquireEntry(system_id)
	app.log("SystemEnterFunc..system_id......."..tostring(system_id))
	SystemEnterFunc[system_id]()
	if system_id == MsgEnum.eactivity_time.eActivityTime_arena then
		uiManager:PushUi(EUI.ArenaPointAwardUI)
	end
end

function SystemEnterFunc.ActivityEnter(system_id)
	app.log("SystemEnterFunc..system_id......."..tostring(system_id))

	if system_id == 60055001 then
		SystemEnterFunc[system_id]()
		do return; end
	end

	if SystemEnterFunc.IsOpenFunc(system_id) then
		SystemEnterFunc[system_id]()
	else
		FloatTip.Float("暂未开放");
	end
end