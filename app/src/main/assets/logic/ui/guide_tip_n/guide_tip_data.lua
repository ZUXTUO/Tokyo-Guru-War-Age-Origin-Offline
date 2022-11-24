local guide_tip_data = { data = { }, failCondition={}}

--[[
    1、配置说明：
    [Gt_Enum.EMain_Athletic_Arena_Report]={                                               -- 文件 guide_tip_enum.lua 中的 Gt_Enum 。
        uiId = EUI.ArenaMainUI,                                                           -- 小红点所在的UIManager中的ID。
        uiNode = "top_other/animation/panel/buttons_grid/btn_zhanbao/animation/sp",       -- 以当前UI中的ui(GameObject)为父节点的路径。
        parent = Gt_Enum.EMain_Athletic,                                                  -- 父节点 Gt_Enum。 注意：有了此设置，将不能有funcs设置以及care_notice
        funcs = GuideTipFuncs.GetArenaReportTip                                           -- 实现逻辑，所有函数返回值必须是Gt_Enum_Wait_Notice枚举类型
        param = nil,                                                                      -- 实现逻辑参数
        fail_care_notice = {},                                                            -- 失败关心的事件监听  参见Gt_Enum_Wait_Notice
        },--	主界面-竞技-竞技场-战报 
    2、接口使用说明：
        ① GuideTipMgr.Init() --初始化小红点（注册事件监听，执行一次所有逻辑并缓存）  目前在player.get_other_info中执行
        ② GNoticeGuideTip(waitNotice, enumid)
            --通知小红点刷新
            --@param waitNotice 枚举类型参见Gt_Enum_Wait_Notice
            --@param enumid 默认是不传 只有在你确定只更新指定功能的时候才采用此id  参见Gt_Enum枚举
            --@return void
]]
--初始化时间time的玩法  
guide_tip_data.initTipsTime = 
{
    MsgEnum.eactivity_time.eActivityTime_threeToThree,
}

guide_tip_data.RedPointState = {};
guide_tip_data.RedPointState[Gt_Enum.EMain_Athletic_Arena_RankAward] = {funcs=g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena].SetNewTopReward, 
obj=g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena]};
guide_tip_data.RedPointState[Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge_start] = 
{
    funcs=g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa].SetStartRedPoint, 
    obj=g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]
};
guide_tip_data.RedPointState[Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge_goods] = 
{
    funcs=g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa].SetGoodsRedPoint, 
    obj=g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]
};

guide_tip_data.RedPointState[Gt_Enum.EMain_Challenge_QYZL_Repory] = {funcs = g_dataCenter.ChurchBot.SetNewBattle,obj =g_dataCenter.ChurchBot.SetNewBattle};


--主界面相关
----------------------------------------------------主界面----------------------------------

--主界面-活动
guide_tip_data.data[Gt_Enum.EMain_Activity] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_top/animation/grid/btn_activity/animation/sp_point",
    funcs = GuideTipFuncs.GetMainActivityRedPoint,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

--主界面-招募
guide_tip_data.data[Gt_Enum.EMain_Enlist] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "down/animation/grid/btn_zhaomu/animation/sp_point",
}

--主界面-招募-一级界面
guide_tip_data.data[Gt_Enum.EMain_Enlist_1_gold] =
{  
    uiId = EUI.EggHeroUi, 
    uiNode = "animation/cont/left_di/cont1/sp_di/content1/sp_point",
    parent=Gt_Enum.EMain_Enlist, 
}
guide_tip_data.data[Gt_Enum.EMain_Enlist_2_gold] =
{  
    uiId = EUI.EggHeroUi, 
    uiNode = "animation/cont/left_di/cont2/btn1/animation/sp_point",
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced,Gt_Enum_Wait_Notice.Time},
    parent=Gt_Enum.EMain_Enlist_1_gold, 
    funcs = GuideTipFuncs.CheckEggGold,
}
guide_tip_data.data[Gt_Enum.EMain_Enlist_1_crystal] =
{  
    uiId = EUI.EggHeroUi, 
    uiNode = "animation/cont/centre_di/cont1/sp_di/content1/sp_point",
    parent=Gt_Enum.EMain_Enlist, 
}
guide_tip_data.data[Gt_Enum.EMain_Enlist_2_crystal] =
{  
    uiId = EUI.EggHeroUi, 
    uiNode = "animation/cont/centre_di/cont2/btn1/animation/sp_point",
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced,Gt_Enum_Wait_Notice.Time},
    parent=Gt_Enum.EMain_Enlist_1_crystal, 
    funcs = GuideTipFuncs.CheckEggCrystal,
}

--主界面-任务
guide_tip_data.data[Gt_Enum.EMain_Task] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = {funcs = MainUIPlayerMenu.GetUiNode, param = MsgEnum.eactivity_time.eActivityTime_Task},
    funcs = GuideTipFuncs.GetMMoTask,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
-- 主界面-任务-主线任务标签
guide_tip_data.data[Gt_Enum.EMain_Task_MainTask] =
{ 
    uiId = EUI.UiDailyTask, 
    uiNode = "center_other/animation/yeka2/sp_point" ,
    parent=Gt_Enum.EMain_Task, 
    funcs = GuideTipFuncs.GetMainTasksTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--    主界面-任务-支线任务标签
guide_tip_data.data[Gt_Enum.EMain_Task_DailyTask] =
{ 
    uiId = EUI.UiDailyTask, 
    uiNode = "center_other/animation/yeka1/sp_point" ,
    parent=Gt_Enum.EMain_Task, 
    funcs = GuideTipFuncs.GetDailyTasksTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

--  主界面-30日签到
guide_tip_data.data[Gt_Enum.EMain_SignIn30 ] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_top/animation/grid/btn_sign/animation/sp_point",
    funcs = GuideTipFuncs.GetSignIn30Tip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--   主界面-登陆 
guide_tip_data.data[Gt_Enum.EMain_LoginAward] = { 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/animation/grid/btn_denglulibao/animation/sp_point",
    funcs = GuideTipFuncs.SevenLogin,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
-- 主界面-首冲
guide_tip_data.data[Gt_Enum.EMain_FirstRecharge] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/right_top/animation/grid/cont/btn_first/animation/sp_point",
    funcs = GuideTipFuncs.FirstRecharge,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
-- 主界面-VIP礼包
guide_tip_data.data[Gt_Enum.EMain_VipGiftPack] = 
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/animation/grid/btn_vip_libao/animation/sp_point",
    funcs = GuideTipFuncs.VipBag,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
-- 主界面-7天乐
guide_tip_data.data[Gt_Enum.EMain_SignIn7] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/animation/grid/btn_qitian/animation/sp_point",
    funcs = GuideTipFuncs.GetSignIn7Tip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
-- 主界面-节日7天乐
guide_tip_data.data[Gt_Enum.EMain_SignIn7_back] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/animation/grid2/btn_festival/animation/sp_point",
    funcs = GuideTipFuncs.GetSignIn7Tip_back,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--  主界面-招财猫
guide_tip_data.data[Gt_Enum.EMain_LuckyCat] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/animation/panel/grid/btn_zhaocaimao/animation/sp_point" ,
    funcs = GuideTipFuncs.LuckyCat,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--  主界面-贩卖机
guide_tip_data.data[Gt_Enum.EMain_Challenge_VendingMachine] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/animation/grid2/btn_fanmaiji/animation/sp_point",
    funcs = GuideTipFuncs.VendingMachineTips,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced, Gt_Enum_Wait_Notice.Crystal},
}
--  主界面-战力排行
guide_tip_data.data[Gt_Enum.EMain_PowerRank] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/animation/panel/grid/btn_zhanlipaihang/animation/sp_point" ,
    funcs = GuideTipFuncs.PowerRank,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--  主界面-商店
guide_tip_data.data[Gt_Enum.EMain_Shop] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = {funcs = MainUIPlayerMenu.GetUiNode, param = MsgEnum.eactivity_time.eActivityTime_Shop},
}
--  主界面-商店-开启一次按钮
guide_tip_data.data[Gt_Enum.EMain_Shop_OpenFirstBtn] =
{ 
    uiId = EUI.ShopUI, 
    uiNode = "equip_box_item/animation/right/left_cont/btn2/animation/sp_point",
    parent = Gt_Enum.EMain_Shop, 
    funcs = GuideTipFuncs.GetShopEquipBoxTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced, Gt_Enum_Wait_Notice.Item_EquipBoxKey},
}

--主界面-角色
guide_tip_data.data[Gt_Enum.EMain_Heros] =
{
    uiId = EUI.MMOMainUI,
    uiNode = "right_other_animation/down/animation/grid/btn_jiaose/animation/sp_point",
    funcs = GuideTipFuncs.GetHerosTip,
    fail_care_notice = {
        Gt_Enum_Wait_Notice.Gold, 
        Gt_Enum_Wait_Notice.Player_Levelup,
        Gt_Enum_Wait_Notice.Item_HeroDebris, 
        Gt_Enum_Wait_Notice.Item_Restraint, 
        Gt_Enum_Wait_Notice.Hero_StarUp,
        Gt_Enum_Wait_Notice.Item_RoleRarity,
        Gt_Enum_Wait_Notice.Item_EquipRarity,
        Gt_Enum_Wait_Notice.Item_EquipLevelUp,
        Gt_Enum_Wait_Notice.Item_EquipStar,
        Gt_Enum_Wait_Notice.Item_RoleLevelUp,
    },
}
--主界面-挑战
guide_tip_data.data[Gt_Enum.EMain_Challenge] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/down/animation/grid/btn_challenge/animation/sp_point" 
}
--主界面-对决
guide_tip_data.data[Gt_Enum.EMain_Duel] =
{
    uiId = EUI.MMOMainUI,
    uiNode = "right_other_animation/down/animation/grid/btn_duijue/animation/sp_point"
}
--主界面-竞技
guide_tip_data.data[Gt_Enum.EMain_Athletic] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/down/animation/grid/btn_pvp/animation/sp_point" 
}
--主界面-邮件
guide_tip_data.data[Gt_Enum.EMain_Mail] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/btn_message/animation/sp_point",
    parent = Gt_Enum.EMain_LeftCenterMenuButton,
    funcs = GuideTipFuncs.GetMailTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced},
}
--主界面-社团
guide_tip_data.data[Gt_Enum.EMain_Guild] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = {funcs = MainUIPlayerMenu.GetUiNode, param = MsgEnum.eactivity_time.eActivityTime_Guild},
}
--主界面-闯关
guide_tip_data.data[Gt_Enum.EMain_Hurdle] = 
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/down/animation/btn_chuangguan/animation/sp_point",
    funcs = GuideTipFuncs.GetHurdleTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Hurdle_GroupAwards, Gt_Enum_Wait_Notice.Hurdle_BoxAwards,},
}

--主界面-战队
guide_tip_data.data[Gt_Enum.EMain_BattleTeam] = 
{
    uiId = EUI.MMOMainUI,
    uiNode = "right_other_animation/down/animation/grid/btn_zhandui/animation/sp_point"
}
--主界面-好友
guide_tip_data.data[Gt_Enum.EMain_Friend] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/animation/right_top/btn_friend/animation/sp_point",
    parent = Gt_Enum.EMain_LeftCenterMenuButton,
}

--主界面-左边伸缩按钮 
guide_tip_data.data[Gt_Enum.EMain_LeftCenterMenuButton] =
{ 
    uiId = EUI.MMOMainUI, 
    uiNode = "right_other_animation/left_top/animation/btn/animation/sp_point",
}

--主界面-背包
guide_tip_data.data[Gt_Enum.EMain_Bag] = 
{
    uiId = EUI.MMOMainUI,
    uiNode = "down/animation/grid/btn_bag/animation/sp_point",
    funcs = GuideTipFuncs.BagHasCareOpenBox,
    fail_care_notice = {Gt_Enum_Wait_Notice.Item_ExchangeType,
                            Gt_Enum_Wait_Notice.Item_Add},
}
-----------------------------------------------------------社团界面--------------------------------
--主界面-社团-社团大厅
guide_tip_data.data[Gt_Enum.EMain_Guild_Hall] =
{ 
    uiId = EUI.GuildMainUI, 
    uiNode = "btn6/animation/sp_point",
    parent = Gt_Enum.EMain_Guild,
}
--主界面-社团-社团大厅-审核
guide_tip_data.data[Gt_Enum.EMain_Guild_Hall_Verify] =
{ 
    uiId = EUI.GuildHallUI, 
    uiNode = "center_other/animation/yeka/yeka2/sp_point",
    parent = Gt_Enum.EMain_Guild_Hall,
    funcs = GuideTipFuncs.GuildApplayDataTips,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced, Gt_Enum_Wait_Notice.Guild_JobChange, Gt_Enum_Wait_Notice.Guild_Wait_Exit, Gt_Enum_Wait_Notice.Guild_Wait_Enter},
}

--主界面--社团-寻找力士
guide_tip_data.data[Gt_Enum.EMain_Guild_Find_Ls] = 
{
    uiId = EUI.GuildMainUI, 
    uiNode = "btn8/animation/sp_point",
    parent = Gt_Enum.EMain_Guild,
    funcs = GuideTipFuncs.GuildCheckFindLsTips,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced,Gt_Enum_Wait_Notice.Guild_Wait_Exit, Gt_Enum_Wait_Notice.Guild_Wait_Enter},
}

--主界面-社团-社团科技
guide_tip_data.data[Gt_Enum.EMain_Guild_ST] =
{ 
    uiId = EUI.GuildMainUI, 
    uiNode = "btn4/animation/sp_point",
    parent = Gt_Enum.EMain_Guild,
}
--主界面-社团-社团科技-捐钱
guide_tip_data.data[Gt_Enum.EMain_Guild_ST_Donation] =
{ 
    uiId = EUI.GuildScienceUI, 
    uiNode = "center_other/animation/cont_top/btn1/animation/sp_point",
    funcs = GuideTipFuncs.CheckGuideSTDonation,
    param = 0;
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced, Gt_Enum_Wait_Notice.Gold, Gt_Enum_Wait_Notice.Guild_Wait_Exit, Gt_Enum_Wait_Notice.Guild_Wait_Enter},
    parent = Gt_Enum.EMain_Guild_ST,
}
guide_tip_data.data[Gt_Enum.EMain_Guild_ST_Donation1] =
{ 
    uiId = EUI.GuildScienceUI, 
    uiNode = {funcs=GuildScienceUI.GetUiNode, param=1},
    funcs = GuideTipFuncs.CheckGuideSTDonation,
    param = 1;
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced, Gt_Enum_Wait_Notice.Gold, Gt_Enum_Wait_Notice.Guild_Wait_Exit, Gt_Enum_Wait_Notice.Guild_Wait_Enter},
    parent = Gt_Enum.EMain_Guild_ST,
}
guide_tip_data.data[Gt_Enum.EMain_Guild_ST_Donation2] =
{ 
    uiId = EUI.GuildScienceUI, 
    uiNode = {funcs=GuildScienceUI.GetUiNode, param=2},
    funcs = GuideTipFuncs.CheckGuideSTDonation,
    param = 2;
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced, Gt_Enum_Wait_Notice.Gold, Gt_Enum_Wait_Notice.Guild_Wait_Exit, Gt_Enum_Wait_Notice.Guild_Wait_Enter},
    parent = Gt_Enum.EMain_Guild_ST,
}
--主界面-社团-社团Boss
guide_tip_data.data[Gt_Enum.EMain_Guild_Boss] =
{ 
    uiId = EUI.GuildMainUI, 
    uiNode = "btn7/animation/sp_point",
    parent = Gt_Enum.EMain_Guild,
}
-- --主界面-社团-社团Boss-奖励
-- guide_tip_data.data[Gt_Enum.EMain_Guild_Boss_Award] =
-- { 
--     uiId = EUI.UiGuildBoss, 
--     uiNode = "top_right_other/animation/btn_award/animation/sp",
--     parent = Gt_Enum.EMain_Guild_Boss,
--     funcs = GuideTipFuncs.GetGuildBossAward,
--     fail_care_notice = {Gt_Enum_Wait_Notice.Forced, Gt_Enum_Wait_Notice.Guild_Wait_Exit, Gt_Enum_Wait_Notice.Guild_Wait_Enter},
-- }
--主界面-社团-社团Boss-开始
guide_tip_data.data[Gt_Enum.EMain_Guild_Boss_Start] =
{ 
    uiId = EUI.UiGuildBoss, 
    uiNode = "down_other/animation/btn_fight/animation/sp_point",
    parent = Gt_Enum.EMain_Guild_Boss,
    funcs = GuideTipFuncs.GetGuildBossStart,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced, Gt_Enum_Wait_Notice.Guild_Wait_Exit, Gt_Enum_Wait_Notice.Guild_Wait_Enter},
}

-----------------------------------------------------------挑战界面-------------------------------
--主界面-挑战-活动关卡
guide_tip_data.data[Gt_Enum.EMain_Challenge_ActivityLevel] =
{ 
    uiId = EUI.ChallengeEnterUI, 
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_LevelActivity}, 
    parent = Gt_Enum.EMain_Challenge,
}
--主界面-挑战-极限挑战
guide_tip_data.data[Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge] =
{ 
    uiId = EUI.ChallengeEnterUI, 
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa}, 
    parent = Gt_Enum.EMain_Challenge,
    funcs  = GuideTipFuncs.GetKuikuliyaTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced,Gt_Enum_Wait_Notice.Player_Levelup},
}
--主界面-挑战-远征试炼
guide_tip_data.data[Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial] =
{ 
    uiId = EUI.ChallengeEnterUI,
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_trial}, 
    parent = Gt_Enum.EMain_Challenge,
    funcs = GuideTipFuncs.GetAthleticTip,
    param = MsgEnum.eactivity_time.eActivityTime_trial,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced,},
}
--主界面-挑战-区域占领
guide_tip_data.data[Gt_Enum.EMain_Challenge_QYZL] =
{ 
    uiId = EUI.ChallengeEnterUI,
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao}, 
    parent = Gt_Enum.EMain_Challenge,
    funcs = GuideTipFuncs.GetChurchTip,
    param = MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao,
    fail_care_notice = {Gt_Enum_Wait_Notice.Time, Gt_Enum_Wait_Notice.Forced,},
}

--主界面-挑战-区域占领-战报
guide_tip_data.data[Gt_Enum.EMain_Challenge_QYZL_Repory] = 
{
    uiId = EUI.ChurchBotMainUi, 
    uiNode = "centre_other/animation/btn_zhan_bao/sp_point",
    parent = Gt_Enum.EMain_Challenge, 
    funcs  = GuideTipFuncs.GetChurchBattleTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},

}

--主界面-挑战-角色历练
guide_tip_data.data[Gt_Enum.EMain_Challenge_HeroTrial] =
{ 
    uiId = EUI.ChallengeEnterUI, 
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_heroTrial},  
    parent = Gt_Enum.EMain_Challenge,
    funcs  = GuideTipFuncs.GetHeroTrialTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

-----------------------------------------------------------活动关卡界面-------------------------------
-- 主界面-挑战-活动关卡-高速阻击
guide_tip_data.data[Gt_Enum.EMain_Challenge_ActivityLevel_HighSpeedFighting] =
{ 
    uiId = EUI.LevelActivity, 
    uiNode = {funcs=LevelActivity.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang}, 
    parent = Gt_Enum.EMain_Challenge_ActivityLevel, 
    funcs = GuideTipFuncs.GetActivityLevelTip,
    param = MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Time},
}
--主界面-挑战-活动关卡-保卫战
guide_tip_data.data[Gt_Enum.EMain_Challenge_ActivityLevel_DefendFighting] =
{ 
    uiId = EUI.LevelActivity, 
    uiNode = {funcs=LevelActivity.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi}, 
    parent = Gt_Enum.EMain_Challenge_ActivityLevel, 
    funcs = GuideTipFuncs.GetActivityLevelTip,
    param = MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Time},
}
--主界面-挑战-活动关卡-小丑计划 
guide_tip_data.data[Gt_Enum.EMain_Challenge_ActivityLevel_ClownPlanFighting] =
{ 
    uiId = EUI.LevelActivity, 
    uiNode = {funcs=LevelActivity.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_ClownPlan}, 
    parent = Gt_Enum.EMain_Challenge_ActivityLevel, 
    funcs = GuideTipFuncs.GetActivityLevelTip,
    param = MsgEnum.eactivity_time.eActivityTime_ClownPlan,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Time},
}
-----------------------------------------------------------竞技界面-------------------------------
--主界面-竞技-世界BOSS
guide_tip_data.data[Gt_Enum.EMain_Athletic_WorldBoss] =
{ 
    uiId = EUI.AthleticEnterUI, 
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_WorldBoss}, 
    parent = Gt_Enum.EMain_Athletic,
}
--主界面-竞技-大乱斗
guide_tip_data.data[Gt_Enum.EMain_Athletic_Fuzion] =
{ 
    uiId = EUI.DuelEnterUI,
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_fuzion2}, 
    parent = Gt_Enum.EMain_Duel,
}
--主界面-竞技-3V3
guide_tip_data.data[Gt_Enum.EMain_Athletic_3V3] =
{ 
    uiId = EUI.DuelEnterUI,
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_threeToThree}, 
    parent = Gt_Enum.EMain_Duel,
    funcs = GuideTipFuncs.Get3V3Tip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Time, Gt_Enum_Wait_Notice.Forced}
}
--主界面-竞技-竞技场
guide_tip_data.data[Gt_Enum.EMain_Athletic_Arena] =
{ 
    uiId = EUI.AthleticEnterUI, 
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_arena}, 
    parent = Gt_Enum.EMain_Athletic, 
}
--主界面-竞技-世界宝箱
guide_tip_data.data[Gt_Enum.EMain_Athletic_WorldBox] =
{ 
    uiId = EUI.AthleticEnterUI, 
    uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox}, 
    parent = Gt_Enum.EMain_Athletic, 
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced,},
}


--------------------------------约战---------------------------------------
--主界面-对决-约战
guide_tip_data.data[Gt_Enum.EMain_Duel_Chat_Fight] =
{
    uiId = EUI.DuelEnterUI,
    uiNode = {funcs = CommomPlayUI.GetUiNode, param = MsgEnum.eactivity_time.eActivityTime_1v1},
    parent = Gt_Enum.EMain_Duel,
}

--主界面-对决-约战-请求
guide_tip_data.data[Gt_Enum.EMain_Duel_Chat_Fight_Request] =
{
    uiId = EUI.ChatFightMainUI,
    uiNode = "right_top_other/animation/btn_zhanbao/animation/sp_point",
    parent = Gt_Enum.EMain_Duel_Chat_Fight,
    funcs  = GuideTipFuncs.ChatFightHaveRequest,
    fail_care_notice = {Gt_Enum_Wait_Notice.Chat_Fight_Request},
}

--主界面-对决-约战-奖励
guide_tip_data.data[Gt_Enum.EMain_Duel_Chat_Fight_Award] =
{
    uiId = EUI.ChatFightMainUI,
    uiNode = "right_top_other/animation/btn_award/animation/sp_point",
    parent = Gt_Enum.EMain_Duel_Chat_Fight,
}

--主界面-对决-约战-奖励--约战
guide_tip_data.data[Gt_Enum.EMain_Duel_Chat_Fight_Award_Fight] =
{
    uiId = EUI.ChatFightAwardUI,
    uiNode = "centre_other/animation/yeka/yeka1/sp_point",
    parent = Gt_Enum.EMain_Duel_Chat_Fight_Award,
    funcs  = GuideTipFuncs.ChatFightAwardFightTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Chat_Fight_Award},
}

--主界面-对决-约战-奖励--胜利
guide_tip_data.data[Gt_Enum.EMain_Duel_Chat_Fight_Award_Win] =
{
    uiId = EUI.ChatFightAwardUI,
    uiNode = "centre_other/animation/yeka/yeka2/sp_point",
    parent = Gt_Enum.EMain_Duel_Chat_Fight_Award,
    funcs  = GuideTipFuncs.ChatFightAwardWinTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Chat_Fight_Award},
}

----------------------------------------------------------战队界面----------------------------------
--主界面-战队-天赋
guide_tip_data.data[Gt_Enum.EMain_BattleTeam_TalentSystem] =
{ 
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param = MsgEnum.eactivity_time.eActivityTime_TalentSystem},  
    parent = Gt_Enum.EMain_BattleTeam, 
}

--主界面-战队-研究所
guide_tip_data.data[Gt_Enum.Emain_BattleTeam_Institute] =
{ 
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_GraduateSchool},  
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs  = GuideTipFuncs.GetInstituteTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Institute_Unlock,},
}


--主界面-战队-训练馆
guide_tip_data.data[Gt_Enum.Emain_BattleTeam_trainning] =
{ 
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_Trainning},  
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs  = GuideTipFuncs.GetTrainningTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Item_Training_Hall},
}

--主界面-战队-训练馆-达人
guide_tip_data.data[Gt_Enum.Emain_BattleTeam_trainning_daren] =
{ 
    uiId = EUI.TrainningMain, 
    uiNode = "centre_other/animation/btn_paihang/animation/sp",
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs  = GuideTipFuncs.GetTrainningDaRenTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

--主界面-战队-训练馆人物界面-达人
guide_tip_data.data[Gt_Enum.Emain_BattleTeam_trainning_info_daren] =
{ 
    uiId = EUI.TrainningInfo, 
    uiNode = "animation/top_left_other/animation/btn_paihang/animation/sp",
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs  = GuideTipFuncs.GetTrainningDaRenTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

--主界面-战队-守护之心
guide_tip_data.data[Gt_Enum.EMain_BattleTeam_GuardHeart] =
{ 
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_GuardHeart},  
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs  = GuideTipFuncs.GuardHeart,
    fail_care_notice = {Gt_Enum_Wait_Notice.Hero_Add,
                        Gt_Enum_Wait_Notice.Player_Levelup,
                        Gt_Enum_Wait_Notice.Player_FightValue,

                        Gt_Enum_Wait_Notice.Hero_LevelUp,
                        Gt_Enum_Wait_Notice.Hero_StarUp,
                        Gt_Enum_Wait_Notice.Hero_RarityUp,
                        Gt_Enum_Wait_Notice.Item_EquipLevelUp,
                        Gt_Enum_Wait_Notice.Item_EquipStar,
                        Gt_Enum_Wait_Notice.Item_EquipRarity,
                        
                        Gt_Enum_Wait_Notice.guardHeart,
                            },
}

--主界面-战队-图鉴
guide_tip_data.data[Gt_Enum.EMain_BattleTeam_Illustrations] =
{ 
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_RolePokedex},
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs = GuideTipFuncs.GetIllumstrationTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

guide_tip_data.data[Gt_Enum.EMain_BattleTeam_Illustrations_Main] =
{ 
    uiId = EUI.HeroIllumstrationMain, 
    uiNode = "down_other/animation/panel/btn/animation/sp_point",
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs = GuideTipFuncs.GetIllumstrationTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

guide_tip_data.data[Gt_Enum.EMain_BattleTeam_Illustrations_CCG] =
{ 
    uiId = EUI.HeroIllumstrationUI, 
    uiNode = "centre_other/animation/right_content/yeka/yeka1/sp_point",
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs = GuideTipFuncs.GetIllumstrationTipToCCG,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

guide_tip_data.data[Gt_Enum.EMain_BattleTeam_Illustrations_SSG] =
{ 
    uiId = EUI.HeroIllumstrationUI, 
    uiNode = "centre_other/animation/right_content/yeka/yeka2/sp_point",
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs = GuideTipFuncs.GetIllumstrationTipToSSG,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

--面具系统 主界面
guide_tip_data.data[Gt_Enum.Emain_BattleTeam_MaskInfo] = 
{
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_Mask},  
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs  = GuideTipFuncs.GetMaskLvlUpTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Item_Mask},
}
----------------------------------------------------------好友界面---------------------
--主界面-好友-好友列表
guide_tip_data.data[Gt_Enum.EMain_Friend_List] =
{ 
    uiId = EUI.FriendUi, 
    uiNode = "center_other/animation/sp_di/cont_yeka/yeka1/sp_point",
    parent = Gt_Enum.EMain_Friend,
    funcs = GuideTipFuncs.GetFriendAPTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Friend_GetApTimesChange, Gt_Enum_Wait_Notice.Friend_GetApApplyChange},
}
--主界面-好友-申请列表
guide_tip_data.data[Gt_Enum.EMain_Friend_Verify] =
{ 
    uiId = EUI.FriendUi, 
    uiNode = "center_other/animation/sp_di/cont_yeka/yeka3/sp_point",
    parent = Gt_Enum.EMain_Friend,
    funcs = GuideTipFuncs.GetFriendApplyTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Friend_ApplyChange},
}
----------------------------------------------------------其他子按钮
--主界面-竞技-世界BOSS-开始按钮
guide_tip_data.data[Gt_Enum.EMain_Athletic_WorldBoss_Start] =
{ 
    uiId = EUI.UiWorldBoss, 
    uiNode = "animation/down_other/panel/animation/btn_fight/animation/sp_point", 
    parent = Gt_Enum.EMain_Athletic_WorldBoss, 
    funcs = GuideTipFuncs.GetAthleticTip,
    param = MsgEnum.eactivity_time.eActivityTime_WorldBoss,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced,}
}
--主界面-竞技-世界BOSS-奖励按钮
guide_tip_data.data[Gt_Enum.EMain_Athletic_WorldBoss_Award] =
{ 
    uiId = EUI.UiWorldBoss, 
    uiNode = "animation/right_top_other/animation/btn_award/animation/sp", 
    parent = Gt_Enum.EMain_Athletic_WorldBoss, 
    funcs = GuideTipFuncs.GetWorldBossAward,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced,}
}
-- --主界面-竞技-世界BOSS-助阵按钮
-- guide_tip_data.data[Gt_Enum.EMain_Athletic_WorldBoss_Backup] =
-- { 
--     uiId = EUI.UiWorldBoss, 
--     uiNode = "down_other/panel/animation/btn_zhuzhen/animation/sp_point", 
--     parent = Gt_Enum.EMain_Athletic_WorldBoss, 
--     funcs = GuideTipFuncs.GetWorldBossBackupTip,
--     fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced,Gt_Enum_Wait_Notice.Hero_RarityUp,Gt_Enum_Wait_Notice.Hero_Add,}
-- }
--主界面-竞技-世界宝箱--开始按钮
guide_tip_data.data[Gt_Enum.EMain_Athletic_WorldBox_Start] =
{ 
    uiId = EUI.WorldTreasureBoxUI, 
    uiNode = "down_other/animation/btn2/animation/sp_point", 
    parent = Gt_Enum.EMain_Athletic_WorldBox, 
    funcs = GuideTipFuncs.GetAthleticTip,
    param = MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced,},
}
--主界面-竞技-世界宝箱-助阵按钮
guide_tip_data.data[Gt_Enum.EMain_Athletic_WorldBox_Backup] =
{ 
    uiId = EUI.WorldTreasureBoxUI, 
    uiNode = "down_other/animation/btn_zhuzhen/animation/sp_point", 
    parent = Gt_Enum.EMain_Athletic_WorldBox, 
    funcs = GuideTipFuncs.GetWorldTreasureBackupTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Forced,Gt_Enum_Wait_Notice.Hero_RarityUp,Gt_Enum_Wait_Notice.Hero_Add,}
}

--主界面-竞技-大乱斗-开始按钮
guide_tip_data.data[Gt_Enum.EMain_Athletic_Fuzion_start] =
{ 
    uiId = EUI.Fuzion2MainUI, 
    uiNode = "down_other/panel/animation/btn/animation/sp_point", 
    parent = Gt_Enum.EMain_Athletic_Fuzion, 
    funcs = GuideTipFuncs.GetDaluandou,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup, Gt_Enum_Wait_Notice.Time,Gt_Enum_Wait_Notice.Forced}
}

--主界面-挑战-极限挑战开始按钮
guide_tip_data.data[Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge_start] =
{ 
    uiId = EUI.KuiKuLiYaHurdleUI, 
    uiNode = "down_other/animation/btn2/animation/sp_point", 
    funcs  = GuideTipFuncs.GetKuikuliyaStartTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--主界面-挑战-极限挑战奖励按钮
guide_tip_data.data[Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge_goods] =
{ 
    uiId = EUI.KuiKuLiYaHurdleUI, 
    uiNode = "down_other/animation/btn_award/animation/sp", 
    funcs  = GuideTipFuncs.GetKuikuliyaGoodsTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

--主界面-竞技-竞技场-战报按钮
guide_tip_data.data[Gt_Enum.EMain_Athletic_Arena_Report] =
{ 
    uiId = EUI.ArenaMainUI, 
    uiNode = "right_top_other/animation/btn_zhanbao/animation/sp_point", 
    parent = Gt_Enum.EMain_Athletic_Arena, 
    funcs  = GuideTipFuncs.GetArenaReportTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--主界面-竞技-竞技场-排名奖励按钮
guide_tip_data.data[Gt_Enum.EMain_Athletic_Arena_RankAward] =
{ 
    uiId = EUI.ArenaMainUI, 
    uiNode = "right_top_other/animation/btn_award/animation/sp_point", 
    parent = Gt_Enum.EMain_Athletic_Arena, 
    funcs  = GuideTipFuncs.GetArenaNewTopTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--主界面-竞技-竞技场-积分奖励按钮
guide_tip_data.data[Gt_Enum.EMain_Athletic_Arena_ScoreAward] =
{ 
    uiId = EUI.ArenaMainUI, 
    uiNode = "right_top_other/animation/btn_jifen/animation/sp_point", 
    parent = Gt_Enum.EMain_Athletic_Arena, 
    funcs  = GuideTipFuncs.GetArenaNewPointTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}
--主界面-竞技-竞技场-当日有可挑战次数
guide_tip_data.data[Gt_Enum.EMain_Athletic_Arena_ChallengeTimes] =
{ 
    uiId = EUI.ArenaMainUI, 
    uiNode = "", --挑战次数没有小红点
    parent = Gt_Enum.EMain_Athletic_Arena, 
    funcs  = GuideTipFuncs.GetArenaChallengeTimes,
    fail_care_notice = {Gt_Enum_Wait_Notice.Forced},
}

--主界面-战队-研究所
guide_tip_data.data[Gt_Enum.Emain_BattleTeam_Institute] =
{ 
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_GraduateSchool},  
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs  = GuideTipFuncs.GetInstituteTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Player_Levelup,
                        Gt_Enum_Wait_Notice.Hero_StarUp,
                        Gt_Enum_Wait_Notice.Hero_RarityUp,
                        Gt_Enum_Wait_Notice.Hurdle_StarChange,
                        Gt_Enum_Wait_Notice.Hurdle_Pass,
                        Gt_Enum_Wait_Notice.Hero_Add,
                        Gt_Enum_Wait_Notice.Institute_Unlock
                        },
}

--主界面-战队-训练馆
guide_tip_data.data[Gt_Enum.Emain_BattleTeam_trainning] =
{ 
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_Trainning},  
    parent = Gt_Enum.EMain_BattleTeam, 
    funcs  = GuideTipFuncs.GetTrainningTip,
    fail_care_notice = {Gt_Enum_Wait_Notice.Item_Training_Hall},
}

--主界面-战队-天赋
guide_tip_data.data[Gt_Enum.EMain_BattleTeam_TalentSystem] =
{ 
    uiId = EUI.ClanUI, 
    uiNode = {funcs=ClanUI.GetUiNode, param = MsgEnum.eactivity_time.eActivityTime_TalentSystem},  
    parent = Gt_Enum.EMain_BattleTeam, 
}

--主界面-战队-天赋-领悟
guide_tip_data.data[Gt_Enum.EMain_BattleTeam_TalentSystem_Comprehend] =
{ 
    uiId = EUI.TalentSystemUI, 
    uiNode = "centre_other/animation/yeka/40001000/sp_point",  
    parent = Gt_Enum.EMain_BattleTeam_TalentSystem, 
    funcs  = GuideTipFuncs.GetTalentySystemTip,
    param = ENUM.TalentTreeID.Comprehend,
    fail_care_notice = {
        Gt_Enum_Wait_Notice.Player_Levelup,
        Gt_Enum_Wait_Notice.Item_Talent,
        Gt_Enum_Wait_Notice.Gold,
        Gt_Enum_Wait_Notice.Forced,
    },
}

--主界面-战队-天赋-深修
guide_tip_data.data[Gt_Enum.EMain_BattleTeam_TalentSystem_DeepRepair] =
{ 
    uiId = EUI.TalentSystemUI, 
    uiNode = "centre_other/animation/yeka/40002000/sp_point",   
    parent = Gt_Enum.EMain_BattleTeam_TalentSystem, 
    funcs  = GuideTipFuncs.GetTalentySystemTip,
    param = ENUM.TalentTreeID.DeepRepair,
    fail_care_notice = {
        Gt_Enum_Wait_Notice.Player_Levelup,
        Gt_Enum_Wait_Notice.Item_Talent,
        Gt_Enum_Wait_Notice.Gold,
        Gt_Enum_Wait_Notice.Forced,
    },
}

--主界面-战队-天赋-精通
guide_tip_data.data[Gt_Enum.EMain_BattleTeam_TalentSystem_Master] =
{ 
    uiId = EUI.TalentSystemUI, 
    uiNode = "centre_other/animation/yeka/40003000/sp_point",   
    parent = Gt_Enum.EMain_BattleTeam_TalentSystem, 
    funcs  = GuideTipFuncs.GetTalentySystemTip,
    param = ENUM.TalentTreeID.Master,
    fail_care_notice = {
        Gt_Enum_Wait_Notice.Player_Levelup,
        Gt_Enum_Wait_Notice.Item_Talent,
        Gt_Enum_Wait_Notice.Gold,
        Gt_Enum_Wait_Notice.Forced,
    },
}

--[[
guide_tip_data.data = {
    -- [Gt_Enum.EMain_Activity	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/right_top/grid1/btn_activity/animation/sp",funcs = {  GuideTipFuncs.GetMainActivityRedPoint } },--	主界面-活动
    -- [Gt_Enum.EMain_SignIn30	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/right_top/grid1/btn_sign/animation/sp",funcs = { GuideTipFuncs.GetSignIn30Tip } },--	主界面-30日签到
    -- [Gt_Enum.EMain_SignIn7	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/right_top/grid2/btn_qitian/animation/sp",funcs = { GuideTipFuncs.GetSignIn7Tip } },--	主界面-7天乐
    -- [Gt_Enum.EMain_Task	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/right_top/grid1/btn_task/animation/sp" ,funcs = {GuideTipFuncs.GetMainTasksTip, GuideTipFuncs.GetDailyTasksTip} },--	主界面-任务
    -- [Gt_Enum.EMain_Task_MainTask	]={ uiId = EUI.UiDailyTask, uiNode = "center_other/animation/yeka2/sp_point" ,parent=Gt_Enum.EMain_Task, funcs = { GuideTipFuncs.GetMainTasksTip } },--	主界面-任务-主线任务标签
    -- [Gt_Enum.EMain_Task_DailyTask	]={ uiId = EUI.UiDailyTask, uiNode = "center_other/animation/yeka1/sp_point" ,parent=Gt_Enum.EMain_Task, funcs = { GuideTipFuncs.GetDailyTasksTip } },--	主界面-任务-支线任务标签
    -- [Gt_Enum.EMain_Mail	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/left_top/animation/grid2/btn_postbox/animation/sp" ,funcs = { GuideTipFuncs.GetMailTip } },--	主界面-邮件
    -- [Gt_Enum.EMain_Challenge	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/down/animation/grid/btn_challenge/animation/sp" },--	主界面-挑战
    -- [Gt_Enum.EMain_Challenge_ActivityLevel]={ uiId = EUI.ChallengeEnterUI, uiNode ={funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_LevelActivity}, parent=Gt_Enum.EMain_Challenge,},--	主界面-挑战-活动关卡
    -- [Gt_Enum.EMain_Challenge_ActivityLevel_HighSpeedFighting]={ uiId = EUI.LevelActivity, uiNode = {funcs=LevelActivity.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang}, parent=Gt_Enum.EMain_Challenge_ActivityLevel, funcs={GuideTipFuncs.GetActivityLevelTipHighSpeedFighting} },--	主界面-挑战-活动关卡-高速阻击
    -- [Gt_Enum.EMain_Challenge_ActivityLevel_DefendFighting	]={ uiId = EUI.LevelActivity, uiNode = {funcs=LevelActivity.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi}, parent=Gt_Enum.EMain_Challenge_ActivityLevel, funcs={GuideTipFuncs.GetActivityLevelTipDefendFighting} },--	主界面-挑战-活动关卡-保卫战
--    [Gt_Enum.EMain_Challenge_ActivityLevel_ClownPlanFighting	]={ uiId = EUI.MMOMainUI, uiNode = "" },--	主界面-挑战-活动关卡-小丑计划 
--    [Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge	]={ uiId = EUI.MMOMainUI, uiNode = "" },--	主界面-挑战-极限挑战
--    [Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial	]={ uiId = EUI.MMOMainUI, uiNode = "" },--	主界面-挑战-远征试炼
--    [Gt_Enum.EMain_Challenge_QYZL	]={ uiId = EUI.MMOMainUI, uiNode = "" },--	主界面-挑战-区域占领
    -- [Gt_Enum.EMain_Challenge_QYZL_Repory	]={ uiId = EUI.UiJiaoTangQiDaoMain, uiNode = "down_other/animation/btn_ranklist/animation/sp",funcs = {GuideTipFuncs.GetExpReportTip} },--	主界面-挑战-区域占领-战报按钮
--    [Gt_Enum.EMain_Challenge_CloneFighting	]={ uiId = EUI.MMOMainUI, uiNode = "" },--	主界面-挑战-克隆站
    -- [Gt_Enum.EMain_Athletic	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/down/animation/grid/btn_pvp/animation/sp" },--	主界面-竞技 
    -- [Gt_Enum.EMain_Athletic_Arena	]={ uiId = EUI.AthleticEnterUI, uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_arena}, parent=Gt_Enum.EMain_Athletic},--	主界面-竞技-竞技场 
    -- [Gt_Enum.EMain_Athletic_WorldBoss   ]={ uiId = EUI.AthleticEnterUI, uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_WorldBoss}, parent=Gt_Enum.EMain_Athletic, funcs={GuideTipFuncs.GetWorldBossTip}, msgIds = {msg_world_boss.gc_sync_world_boss_state}},-- 主界面-竞技-世界BOSS
    -- [Gt_Enum.EMain_Athletic_WorldBox  ]={ uiId = EUI.AthleticEnterUI, uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox}, parent=Gt_Enum.EMain_Athletic, funcs={GuideTipFuncs.GetWorldTreasureBox}, msgIds = {msg_world_treasure_box.gc_sync_world_treasure_box_state}},--  主界面-竞技-世界宝箱
    -- [Gt_Enum.EMain_Athletic_3V3   ]={ uiId = EUI.AthleticEnterUI, uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_threeToThree}, parent=Gt_Enum.EMain_Athletic, funcs={GuideTipFuncs.Get3V3Tip}},--  主界面-竞技-3V3
    -- [Gt_Enum.EMain_Athletic_Fuzion  ]={ uiId = EUI.AthleticEnterUI, uiNode = {funcs=CommomPlayUI.GetUiNode, param=MsgEnum.eactivity_time.eActivityTime_fuzion2}, parent=Gt_Enum.EMain_Athletic, funcs={GuideTipFuncs.GetDaluandou}},--  主界面-竞技-大乱斗
    -- [Gt_Enum.EMain_Athletic_Arena_Report	]={ uiId = EUI.ArenaMainUI, uiNode = "top_other/animation/panel/buttons_grid/btn_zhanbao/animation/sp", parent=Gt_Enum.EMain_Athletic_Arena, funcs={GuideTipFuncs.GetArenaReportTip}},--	主界面-竞技-竞技场-战报 
    -- [Gt_Enum.EMain_Athletic_Arena_RankAward	]={ uiId = EUI.ArenaMainUI, uiNode = "top_other/animation/panel/buttons_grid/btn_award/animation/sp", parent=Gt_Enum.EMain_Athletic_Arena, funcs={GuideTipFuncs.GetArenaNewTopTip}, msgIds = {msg_activity.gc_arena_request_climb_reward_data} },--	主界面-竞技-竞技场-排名奖励 
    -- [Gt_Enum.EMain_Athletic_Arena_ScoreAward	]={ uiId = EUI.ArenaMainUI, uiNode = "top_other/animation/panel/buttons_grid/btn_integral/animation/sp", parent=Gt_Enum.EMain_Athletic_Arena, funcs={GuideTipFuncs.GetArenaNewPointTip} },--	主界面-竞技-竞技场-积分奖励 


    -- [Gt_Enum.EMain_Hurdle]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/down/animation/btn_chuangguan/animation/sp",funcs = {GuideTipFuncs.GetHurdleTip}, msgIds={msg_hurdle.gc_hurdle_fight,msg_hurdle.gc_take_award,msg_hurdle.gc_hurlde_box} },--	主界面-闯关
    -- [Gt_Enum.EMain_BattleTeam	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/down/animation/grid/btn_zhandui/animation/sp",funcs = {GuideTipFuncs.GetBattleTeamTip} },--	主界面-战队
    -- [Gt_Enum.EMain_BattleTeam_Illustrations	]={ uiId = EUI.ClanUI, uiNode = "ClanUI/centre_other/animation/scroll_view/panel_list/wrap_content/child01/texture/btn/animation/sp_point",funcs={GuideTipFuncs.GetIllumstrationTip} },--	主界面-战队-图鉴
    -- [Gt_Enum.EMain_BattleTeam_TalentSystem	]={ uiId = EUI.ClanUI, uiNode = "ClanUI/centre_other/animation/scroll_view/panel_list/wrap_content/child02/texture/btn/animation/sp_point",funcs={GuideTipFuncs.GetTalentySystemTip} },--	主界面-战队-天赋
    -- [Gt_Enum.EMain_Heros] = { uiId = EUI.MMOMainUI, uiNode = "right_other_animation/down/animation/grid/btn_jiaose/animation/sp",funcs = {GuideTipFuncs.GetHerosTip} },--主界面-角色
    -- [Gt_Enum.EMain_Enlist	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/down/animation/grid/btn_zhaomu/animation/sp",funcs = { GuideTipFuncs.GetEnlistTip } },--	主界面-招募 
    -- [Gt_Enum.EMain_Shop	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/down/animation/grid/btn_shop/animation/sp" },--	主界面-商店
    -- [Gt_Enum.EMain_Guild	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/down/animation/grid/btn_guild/animation/sp",funcs = {GuideTipFuncs.GetGuildTip} },--	主界面-社团
    -- [Gt_Enum.EMain_Guild_ST	]={ uiId = EUI.GuildMainUI, uiNode = "ui_guild_main_scene/btn4/animation/sp_point",funcs={GuideTipFuncs.IsDonateRemain,} },--	主界面-社团-社团科技
--    [Gt_Enum.EMain_Guild_ST_Donation	]={ uiId = EUI.MMOMainUI, uiNode = "" },--	主界面-社团-社团科技-捐钱
    -- [Gt_Enum.EMain_Guild_Hall	]={ uiId = EUI.GuildMainUI, uiNode = "ui_guild_main_scene/btn6/animation/sp_point", parent=Gt_Enum.EMain_Guild },--	主界面-社团-社团大厅 
    -- [Gt_Enum.EMain_Guild_Hall_Verify	]={ uiId = EUI.GuildHallUI, uiNode = "center_other/animation/yeka/yeka2/sp_dot",funcs = {GuideTipFuncs.GuildApplayDataTips}, parent=Gt_Enum.EMain_Guild_Hall },--	主界面-社团-社团大厅-审核 
    -- [Gt_Enum.EMain_Guild_Boss	]={ uiId = EUI.GuildMainUI, uiNode = "ui_guild_main_scene/btn7/animation/sp_point",funcs={GuideTipFuncs.IsBossActive} },--	主界面-社团-Boss 
    -- [Gt_Enum.EMain_Friend	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/left_top/animation/grid2/btn_friend/animation/sp",funcs={ GuideTipFuncs.GetFriendAPTip,GuideTipFuncs.GetFriendApplyTip } },--	主界面-好友
    -- [Gt_Enum.EMain_Friend_List	]={ uiId = EUI.FriendUi, uiNode = "center_other/animation/sp_di/cont_yeka/yeka1/sp_new",parent = Gt_Enum.EMain_Friend,funcs = {GuideTipFuncs.GetFriendAPTip} },--	主界面-好友-好友列表
    -- [Gt_Enum.EMain_Friend_Verify	]={ uiId = EUI.FriendUi, uiNode = "center_other/animation/sp_di/cont_yeka/yeka3/sp_new",parent = Gt_Enum.EMain_Friend,funcs = {GuideTipFuncs.GetFriendApplyTip}},--	主界面-好友-申请列表
    -- [Gt_Enum.EMain_FirstRecharge	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/right_top/animaiton/grid1/cont/btn_first/animation/sp",funcs = {GuideTipFuncs.FirstRecharge} },--	主界面-首冲 
    -- [Gt_Enum.EMain_LoginAward	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/right_top/animaiton/grid2/btn_denglulibao/animation/sp",funcs = {GuideTipFuncs.SevenLogin} },--	主界面-登陆 
    -- [Gt_Enum.EMain_LuckyCat	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/right_top/animaiton/grid2/btn_zhaocaimao/animation/sp" ,funcs = {GuideTipFuncs.LuckyCat}},--	主界面-招财猫
    -- [Gt_Enum.EMain_LeftCenterMenuButton	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/left_top/animation/btn/animation/sp",funcs = {GuideTipFuncs.LeftCenterMenuBtnTip} },--	主界面-左边伸缩按钮 
    -- [Gt_Enum.EMain_VipGiftPack	]={ uiId = EUI.MMOMainUI, uiNode = "right_other_animation/right_top/animaiton/grid1/btn_vip_libao/animation/sp",funcs = {GuideTipFuncs.VipBag} },--	主界面-VIP礼包
    -- [Gt_Enum.EMain_Shop_OpenFirstBtn	]={ uiId = EUI.ShopUI, uiNode = "equip_box_item/animation/right/left_cont/btn2/animation/sp_point", parent=Gt_Enum.EMain_Shop, funcs = {GuideTipFuncs.GetShopEquipBoxTip}, msgIds = {msg_activity.gc_niudan_use,msg_activity.gc_niudan_sync_equip_info} },--	主界面-商店-开启一次按钮
    -- [Gt_Enum.EMain_Role_ChooseHeroStarToggle	]={ uiId = EUI.BattleUI, uiNode = "right_other/animation/scroll_view/panel/grid/yeka2/sp_point" },--	主界面-角色-强化按钮(角色养成界面-升星标签)
    -- [Gt_Enum.EMain_Role_ChooseHeroStarBtn	]={ uiId = EUI.BattleUI, uiNode = "ui_battle_star_up/centre_other/animation/content/sp_bk3/container2/btn2/animation/sprite_background/sp_point",parent = Gt_Enum.EMain_Role_ChooseHeroStarToggle, funcs = {GuideTipFuncs.GetHeroStarUpTip} , msgIds = { msg_cards.gc_update_role_cards,msg_cards.gc_update_item_cards,msg_cards.gc_delete_item_cards,msg_cards.gc_change_souls,msg_cards.gc_equip_star_up }  },--	主界面-角色-强化按钮(角色养成界面-升星按钮)
    -- [Gt_Enum.EMain_Role_ChooseHeroRarityToggle	]={ uiId = EUI.BattleUI, uiNode = "right_other/animation/scroll_view/panel/grid/yeka3/sp_point",funcs = {GuideTipFuncs.GetHeroRarityUpTip} },--	主界面-角色-强化按钮(角色养成界面-升品标签)
    -- [Gt_Enum.EMain_Role_ChooseHeroRarityBtn	]={ uiId = EUI.BattleUI, uiNode = "centre_other/animation/container/content2/btn/animation/sp_point",funcs = {GuideTipFuncs.GetHeroRarityUpTip} },--	主界面-角色-强化按钮(角色养成界面-升品按钮)
    -- [Gt_Enum.EMain_Role_ChooseHeroRestraintToggle	]={ uiId = EUI.BattleUI, uiNode = "right_other/animation/scroll_view/panel/grid/yeka5/sp_point",funcs = {GuideTipFuncs.GetHeroRestraintTip} },--	主界面-角色-强化按钮(角色养成界面-克制标签)
    -- [Gt_Enum.EMain_Role_ChooseHeroRestraintBtn	]={ uiId = EUI.BattleUI, uiNode = "centre_other/animation/right_content/btn1/animation/sp_point",funcs = {GuideTipFuncs.GetHeroRestraintTip} },--	主界面-角色-强化按钮(角色养成界面-克制按钮)
    -- [Gt_Enum.EMain_Role_ChooseHeroSkillToggle	]={ uiId = EUI.BattleUI, uiNode = "right_other/animation/scroll_view/panel/grid/yeka4/sp_point",funcs={GuideTipFuncs.GetHeroSkillLevel},msgIds = {msg_cards.gc_skill_level_up_rst} },--	主界面-角色-强化按钮(角色养成界面-技能)
    -- [Gt_Enum.EMain_Role_ChooseHeroEquipStrengthenToggle	]={ uiId = EUI.EquipPackageUI, uiNode = "ui_604_battle/centre_other/animation/right_content/yeka/yeka1/sp_point",funcs={GuideTipFuncs.GetEquipLevelUpTip,GuideTipFuncs.GetEquipRarityUpTip} },--	主界面-角色-装备按钮(角色装备养成界面-装备强化标签)
    -- [Gt_Enum.EMain_Role_ChooseHeroEquipRarityBtn	]={ uiId = EUI.EquipPackageUI, uiNode = "ui_604_battle/centre_other/animation/right_content/cont1/btn_advance/animation/sp_point",funcs ={GuideTipFuncs.GetEquipRarityUpTip} },--	主界面-角色-装备按钮(角色装备养成界面-装备升品按钮)
    -- [Gt_Enum.EMain_Role_ChooseHeroEquipStarToggle	]={ uiId = EUI.EquipPackageUI, uiNode = "ui_604_battle/centre_other/animation/right_content/yeka/yeka2/sp_point",funcs ={GuideTipFuncs.GetEquipStarUpTip} },--	主界面-角色-装备按钮(角色装备养成界面-装备升星标签)
    -- [Gt_Enum.EMain_Role_ChooseHeroEquipStarBtn	]={ uiId = EUI.EquipPackageUI, uiNode = "ui_604_battle/centre_other/animation/right_content/cont2/content/btn1/animation/sp_point",funcs ={GuideTipFuncs.GetEquipStarUpTip} },--	主界面-角色-装备按钮(角色装备养成界面-装备升星按钮)
    -- [Gt_Enum.EMain_Team_Detail_Equip	]={ uiId = EUI.FormationInfoUi, uiNode = "centre_other/animation/right_content/btn_1/animation/sp_point",funcs = {GuideTipFuncs.GetProcessEquipTip} },--	主界面-阵容-查看详情(阵容强化)-装备
    -- [Gt_Enum.EMain_Team_Detail_Streagthen	]={ uiId = EUI.FormationInfoUi, uiNode = "centre_other/animation/right_content/btn_2/animation/sp_point",funcs ={GuideTipFuncs.GetProcessHeroTip} },--	主界面-阵容-查看详情(阵容强化)-强化
}
]]

GuideTipData = { }

local categoryToNotice = {};
categoryToNotice[ENUM.EItemCategorySystem.RoleStar] = Gt_Enum_Wait_Notice.Item_HeroDebris;
categoryToNotice[ENUM.EItemCategorySystem.Talent] = Gt_Enum_Wait_Notice.Item_Talent;
categoryToNotice[ENUM.EItemCategorySystem.Restraint] = Gt_Enum_Wait_Notice.Item_Restraint;
categoryToNotice[ENUM.EItemCategorySystem.EquipBox] = Gt_Enum_Wait_Notice.Item_EquipBoxKey;
categoryToNotice[ENUM.EItemCategorySystem.Trainning] = Gt_Enum_Wait_Notice.Item_Training_Hall;
categoryToNotice[ENUM.EItemCategorySystem.RoleRarity] = Gt_Enum_Wait_Notice.Item_RoleRarity;
categoryToNotice[ENUM.EItemCategorySystem.EquipRarity] = Gt_Enum_Wait_Notice.Item_EquipRarity;
categoryToNotice[ENUM.EItemCategorySystem.EquipLevelUp] = Gt_Enum_Wait_Notice.Item_EquipLevelUp;
categoryToNotice[ENUM.EItemCategorySystem.EquipStar] = Gt_Enum_Wait_Notice.Item_EquipStar;
categoryToNotice[ENUM.EItemCategorySystem.RoleLevelUp] = Gt_Enum_Wait_Notice.Item_RoleLevelUp;
categoryToNotice[ENUM.EItemCategorySystem.Maskinfo] = Gt_Enum_Wait_Notice.Item_Mask;

function GuideTipData.OnItemChange(itemid)
    local cf = ConfigManager.Get(EConfigIndex.t_item, itemid);
    if not cf then
        return;
    end
    if type(cf.category_system) == "table" then
        for k, v in ipairs(cf.category_system) do
            if categoryToNotice[v] then
                GNoticeGuideTip(categoryToNotice[v]);
            end
        end
    elseif type(cf.category_system) == "number" then
        if categoryToNotice[cf.category_system] then
            GNoticeGuideTip(categoryToNotice[cf.category_system]);
        end
    end
    
end

function GuideTipData.GetData()
    return guide_tip_data.data
end

function GuideTipData.GetDataByDtEnum(gtEnum)
    if not gtEnum then return nil end
    return guide_tip_data.data[gtEnum]
end
function GuideTipData.GetInitTipsTime()
    return guide_tip_data.initTipsTime;
end
function GuideTipData.GetRedPointState()
    return guide_tip_data.RedPointState;
end

function GuideTipData.SetTempRef(gtEnum, result, refEnum, startEnum)
    local data = GuideTipData.GetDataByDtEnum(gtEnum)
    if not data then return end
    if data.uiId then
        if not data.temp_ref then
            data.temp_ref = { }
        end

        -- local oldTemp = table.get_num(data.temp_ref);
        if result == Gt_Enum_Wait_Notice.Success then
            data.temp_ref[refEnum or gtEnum] = Gt_Enum_Wait_Notice.Success
        else
            data.temp_ref[refEnum or gtEnum] = nil 
            
        end
        -- local newTemp = table.get_num(data.temp_ref);
        -- if gtEnum == Gt_Enum.EMain_Friend_List and newTemp ~= oldTemp then
        --     app.log(tostring(gtEnum).."...."..tostring(refEnum)..".."..tostring(startEnum)..".."..table.tostring(data.temp_ref));
        -- end

        if data.parent then
            local gcount = table.get_num(data.temp_ref);
            if gcount > 0 then
                gcount = Gt_Enum_Wait_Notice.Success;
            end
            GuideTipData.SetTempRef(data.parent, gcount, gtEnum, startEnum)
        end
        --当是具体功能的时候 需要将此功能的相关失败条件重新设置
        if data.funcs then
            if data.failCondition ~= nil then
                if type(data.failCondition) == "table" then
                    for k, v in pairs(data.failCondition) do
                        guide_tip_data.failCondition[k][gtEnum] = nil;
                    end
                else
                    guide_tip_data.failCondition[data.failCondition][gtEnum] = nil;
                end
            end
            if result ~= Gt_Enum_Wait_Notice.Success then
                data.failCondition = result;
                GuideTipData.RecordFailCondition(gtEnum, result);
            end
        end
    end
end

function GuideTipData.GetRedCount(gtEnum)
    local data = GuideTipData.GetDataByDtEnum(gtEnum)
    if data then       
        if data.temp_ref then
            return table.get_num(data.temp_ref)
        end
    end
    return 0
end

function GuideTipData.CheckFailCondition(waitNotice, enumid, funcs)
    local notice = guide_tip_data.failCondition[waitNotice];
    if notice and funcs then
        if enumid then
            if notice[enumid] then
                funcs(enumid);
            end
        else
            for k, v in pairs(notice) do
                funcs(k);
            end
        end
    end
end
 
 function GuideTipData.RecordFailCondition(enumid, result)
    if result == Gt_Enum_Wait_Notice.Success then
        return;
    end
    if type(result) == "table" then
        for k, v in pairs(result) do
            if not guide_tip_data.failCondition[k] then
                guide_tip_data.failCondition[k] = {};
            end
            guide_tip_data.failCondition[k][enumid] = 1;
        end
    else
        if not guide_tip_data.failCondition[result] then
            guide_tip_data.failCondition[result] = {};
        end
        guide_tip_data.failCondition[result][enumid] = 1;
    end
 end

function GuideTipData.GetFailCondition()
    return guide_tip_data.failCondition;
end