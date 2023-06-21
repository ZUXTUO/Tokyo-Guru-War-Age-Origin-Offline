-- require 'Class'
-- require "ui.main_ui"
-- require "ui.zhenrong_ui"
-- require "ui.copy_ui"
-- require "ui.formation_ui"
-- require "ui.ui_3d"
-- require "ui.sell_ui"
-- require "ui.change_equip"
-- require "ui.change_card"
-- require "ui.copy_friend_ui"
-- require "ui.copy_team_ui"
 
UiManager = Class("UiManager",nil,nil);

EUI = {
    NavigationBar = "NavigationBar";
    MainUi     = 'MainUi';
    ZhenrongUi = 'ZhenrongUi';
    CopyUi     = 'CopyUi';
    PackageUi  = 'PackageUi';
    FormationUi = 'FormationUi';     --[[没有默认值，需要调用SetPlayerGID设置玩家id]]
    FormationUi2 = 'FormationUi2';   --[[默认显示为玩家自己]]
    FormationInfoUi = 'FormationInfoUi';
    FormationUiNoHomeBtn = 'FormationUiNoHomeBtn';
    ChangeEquip = 'ChangeEquip';
    ChangeCard  = 'ChangeCard';
    CopyChoiceUi   = 'CopyChoiceUi';
    CopyFriendUi   = 'CopyFriendUi';
    CopyTeamUi     = 'CopyTeamUi';
    CopyIntroduceUi= 'CopyIntroduceUi';
    BreakThroughPackageUi = 'BreakThroughPackageUi';
    EggEquipUi          = 'EggEquipUi';
    EggHeroUi          = 'EggHeroUi';
    EggAwardShowUI          = 'EggAwardShowUI';
    EggHeroShowUI          = 'EggHeroShowUI';
    EggHeroSubUiGold          = 'EggHeroSubUiGold';
    EggHeroSubUiCrystal          = 'EggHeroSubUiCrystal';
    EggHeroSubUiVip          = 'EggHeroSubUiVip';
    EggCartoonUi   = 'EggCartoonUi';
    FriendUi = 'FriendUi';
    FriendInfoUI = "FriendInfoUI";
    MailListUI = 'MailListUI';
    MailViewUI = 'MailViewUI';
    MailGiftViewUI = 'MailGiftViewUI';
    PlayUi = 'PlayUi';
    StrengthenPackage = 'StrengthenPackage';
    SevenSignUi = 'SevenSignUi';
    SevenSignUiSignin = 'SevenSignUiSignin';
    SevenSignMuBiao = 'SevenSignMuBiao';
    SevenSignBackUi = 'SevenSignBackUi';
    SevenSignMuBiaoBack = 'SevenSignMuBiaoBack';
    MonthSignUi = 'MonthSignUi';
    ActivityUI = 'ActivityUI';
    ActivityWelfareboxBoxShowUI = 'ActivityWelfareboxBoxShowUI';
    LevelActivity = 'LevelActivity';
    GetAward = 'GetAward';
    RankUI = 'RankUI';
    GuildBossRankUI = 'GuildBossRankUI';
    HeroPackageUI = 'HeroPackageUI';
    EquipPackageUI = 'EquipPackageUI';
    BattleUI = 'BattleUI';
    BattleRoleAttrInfoUI = 'BattleRoleAttrInfoUI';
    ScreenPlayChat = 'ScreenPlayChat';  -- 剧情对话面板
    ScreenPlayChatMMO = 'ScreenPlayChatMMO';  -- 剧情对话面板
    -- HeroChoseUI = 'HeroChoseUI';
    GhoulAssaultUI = 'GhoulAssaultUI';
    GhoulHeroUI = 'GhoulHeroUI';
    GaoSuJuJiUI = 'GaoSuJuJiUI';
    --EquipmentBaseUI = 'ZhuangBeiKuUI';
    UiBaoWeiCanChang = "UiBaoWeiCanChang";
    UiMendicity = "UiMendicity";
    HuiZhangUI = "HuiZhangUI";--[[徽章抢夺开始界面]]
    HuiZhangChallengeUI = "HuiZhangChallengeUI";--[[徽章抢夺队伍界面]]
    HuiZhangChallengeEndUI = "HuiZhangChallengeEndUI";--[[徽章抢夺完后界面]]
    UiEquipLevelUp = "UiEquipLevelUp";
    UiEquipStarUp = "UiEquipStarUp";
    UiGm = "UiGm";
    UiLevel = "UiLevel";                        --关卡
    UiLevelBox = "UiLevelBox";                  --关卡宝箱
    UiLevelAwards = "UiLevelAwards";            --关卡扫荡奖励结算
    UiLevelChallenge = "UiLevelChallenge";      --关卡挑战
    UiLevelNewGroup = "UiLevelNewGroup";        --关卡新章节开启
    UiJiaoTangQiDaoMain = "UiJiaoTangQiDaoMain";        --玩法：教堂祈祷
    KuiKuLiYaHurdleUI = "KuiKuLiYaHurdleUI";            -- 玩法：奎库利亚
    KuiKuLiYaHurdleInfoUI = "KuiKuLiYaHurdleInfoUI";            -- 玩法：奎库利亚
    KuiKuLiYaOpenBoxUI = "KuiKuLiYaOpenBoxUI";            -- 玩法：奎库利亚
    KuiKuLiYaAwardUI = "KuiKuLiYaAwardUI";            -- 玩法：奎库利亚
    KuiKuLiYaSweepUI= "KuiKuLiYaSweepUI";            -- 玩法：奎库利亚
    KuiKuLiYaRankUI= "KuiKuLiYaRankUI";            -- 玩法：奎库利亚
    -- CellEnhanceUI = "CellEnhanceUI";            -- 细胞强化
    BuildingInfoUI = "BuildingInfoUI";
    BuildingUpgradeUI = "BuildingUpgradeUI";
    SLGRanking = 'SLGRanking';
    BuildingRobberyFightReport = 'BuildingRobberyFightReport';
    SearchingRobberyTargetUI = 'SearchingRobberyTargetUI';
    TargetBuildingSceneUI = 'TargetBuildingSceneUI';
    BuildingEmbattleInfoUI = 'BuildingEmbattleInfoUI';
    TargetBuildingEmbattleInfoUI = 'TargetBuildingEmbattleInfoUI';
    BuildingEmbattleChoseHeroUI = 'BuildingEmbattleChoseHeroUI';
    AttackBuildingEmbattleChoseHeroUI = 'AttackBuildingEmbattleChoseHeroUI';
    MyBuildingSceneUI2 = 'MyBuildingSceneUI2';
    TargetBuildingSceneUI2 = 'TargetBuildingSceneUI2';
    BuildingTabPageUI = 'BuildingTabPageUI';
    --SLGSearchTargetCostUI = 'SLGSearchTargetCostUI';
    UiJiaoTangQiDaoChoseHero = "UiJiaoTangQiDaoChoseHero";            -- 教堂祈祷英雄选择界面
    FettersUI = "FettersUI";                    -- 羁绊界面
    EquipCompoundUI = "EquipCompoundUI";
    EquipCompoundResultUI = "EquipCompoundResultUI";
    QualitySelectUI = "QualitySelectUI";
    UiShiYiQuTaoFaZhan = "UiShiYiQuTaoFaZhan";    --十一区讨伐战
    EquipFilterUI = "EquipFilterUI";
    BreakThroughUI = "BreakThroughUI";          -- 突破界面
    BreakThroughPreviewUI = "BreakThroughPreviewUI"; --突破界限预览界面fy
    -- ArrangeBattleUI = "ArrangeBattleUI";
    -- GuildWarArrangeBattleUI = "GuildWarArrangeBattleUI";
    DayRewardUI = "DayRewardUI";
    UiSet = "UiSet";
    SetUiReName = "SetUiReName";
    UiDailyTask = "UiDailyTask";               --日常任务
    UiJiaoTangQiDaoReport = "UiJiaoTangQiDaoReport";               --教堂祈祷战报界面
    EggEquipExchangeUI = "EggEquipExchangeUI";               --扭蛋中的，装备兑换
    -- UiHeroStarUpEgg = "UiHeroStarUpEgg";              --扭蛋中的，英雄升星
    UiWorldBoss = "UiWorldBoss";                    --世界boss
    WorldBossReportUI = "WorldBossReportUI";                    --世界boss战报
    WorldBossBackupSystemUI = "WorldBossBackupSystemUI";                    --世界boss助阵系统
    UiWorldBossRank= "UiWorldBossRank";             --世界boss排行榜界面
    UiWorldBossReward = "UiWorldBossReward";        --世界boss奖励查看界面
    VipPrivilegeUI= "VipPrivilegeUI";             --VIP特权界面
    VipPackingUI= "VipPackingUI";             --VIP包装
    VipHintUI= "VipHintUI";             --VIP提示
    StoreUI= "StoreUI";             --商城界面
    ActivityStoreUI= "ActivityStoreUI";             --限时购商城界面
    SupportHeroUI= "SupportHeroUI";             --支援部队界面
    UiAnn = "UiAnn"; -- 公告界面
    WorldTreasureBoxUI = "WorldTreasureBoxUI";    --世界宝箱主界面
    WorldTreasureBoxResultUI = "WorldTreasureBoxResultUI";    --世界宝箱结算界面
    ArenaMainUI = "ArenaMainUI";    --竞技场主界面
    ArenaReportUI = "ArenaReportUI";    --竞技场战斗记录界面
    -- ArenaRankUI = "ArenaRankUI";    --竞技场排名提升界面
    ArenaPointAwardUI = "ArenaPointAwardUI";    --竞技场积分奖励界面
    ArenaTopRankAwardUI = "ArenaTopRankAwardUI";    --竞技场最高排名奖励界面
    ArenaAchieveRankFriendUI = "ArenaAchieveRankFriendUI";    --竞技场达到排名段的好友列表界面
    Fuzion2MainUI = "Fuzion2MainUI";  -- (10人)大乱斗主界面
    -- Funzion2MatchUI = "Funzion2MatchUI";  -- (10人)大乱斗主界面
    FuzionMainUI = "FuzionMainUI";  -- 大乱斗主界面
    FuzionHeroUI = "FuzionHeroUI";  -- 大乱斗英雄界面
    FuzionRankUI = "FuzionRankUI";  -- 大乱斗排行界面
    FuzionChoseHeroUI = "FuzionChoseHeroUI";  -- 大乱斗英雄选择界面
    GuildLookUI = "GuildLookUI";                        -- 社团浏览管理界面
    GuildCreateUI = "GuildCreateUI";                    -- 社团创建界面
    GuildHallUI = "GuildHallUI";                        -- 社团大厅管理界面
    GuildMemberInfoUI = "GuildMemberInfoUI";            -- 社员查看界面
    GuildMainUI = "GuildMainSceneUI";                   -- 社团主界面
    GuildSetMailUI = "GuildSetMailUI";                  -- 社团邮件编辑界面
    GuildSetIconUI = "GuildSetIconUI";                  -- 社团徽章列表界面
    GuildSetApprovalUI = "GuildSetApprovalUI";          -- 社团招募设置界面
    GuildSetDeclarationUI = "GuildSetDeclarationUI";    -- 社团公告设置界面
    GuildSetNameUI = "GuildSetNameUI";                  -- 社团改名界面
    GuildScienceSubitemUI = "GuildScienceSubitemUI";
    GuildScienceUI = "GuildScienceUI";
    GuildScienceDonateUI = "GuildScienceDonateUI";
    DuelEnterUI = "DuelEnterUI";                 --对决入口界面
    ChallengeEnterUI = "ChallengeEnterUI";       --挑战入口界面
    AthleticEnterUI = "AthleticEnterUI";        --竞技入口界面
    UiRuleDesNoNavBar = "UiRuleDesNoNavBar";--规则说明界面,没有导航条
    UiQuestWebView = "UiQuestWebView"; --问卷调查
    ShopUI = "ShopUI"; --二级商店
    HeroStarUp = "HeroStarUp";
    RoleUpexpUI = "RoleUpexpUI";
    -- Ui3v3Matching = "Ui3v3Matching";
    MobaMatchingUI = "MobaMatchingUI";
    MobaEnterTipsUI = "MobaEnterTipsUI";
    MobaReadyEnterUI = "MobaReadyEnterUI";
    QingTongJiDiRankUI = "QingTongJiDiRankUI";
    QingTongJiDiEnterUI = "QingTongJiDiEnterUI";
    QingTongJiDiRoomUI = "QingTongJiDiRoomUI";
    QingTongJiDiAwardUI = "QingTongJiDiAwardUI";
    QingTongJiDiHeroChoseUI = "QingTongJiDiHeroChoseUI";
    UiDevelopGuide = "UiDevelopGuide";
    UiEquipForge = "UiEquipForge";
    UiEquipForgeEquipList = "UiEquipForgeEquipList";
    UiEquipForgeChoseEquip = "UiEquipForgeChoseEquip";
    UiAreaMap = "UiAreaMap";
    UiMap = "UiMap";
    RestraintUi = "RestraintUi";
    RestraintTotalPlusUi = "RestraintTotalPlusUi";
    SkillUpgradeUI = "SkillUpgradeUI";
    LoginInGame = "LoginInGame";
    MMOMainUI = "MMOMainUI";
    MMOTaskListUI = "MMOTaskListUI",
    MMOTaskDialogUI = "MMOTaskDialogUI",
    MMOChoiceUI = "MMOChoiceUI";
    UiFirstRecharge = "UiFirstRecharge";
    GoldExchangeUI = "GoldExchangeUI";
    UiTitle  = "UiTitle";
    InstituteUI = "InstituteUI";
    CloneBattleUI = "CloneBattleUI";
    CloneBattleTeamUI= "CloneBattleTeamUI";
    CloneAreward = "CloneAreward";
    UiClownPlan = "UiClownPlan";    
    TrainningMain = "TrainningMain";
    TrainningInfo = "TrainningInfo";
    Trainningheroinfo = "Trainningheroinfo";
    Trainninguplv = "Trainninguplv";
    Trainningbattleup = "Trainningbattleup";
    Trainningbattleinfo = "Trainningbattleinfo";
    Trainningmaintip = "Trainningmaintip";
    Trainninginfotip = "Trainninginfotip";
    ExpeditionTrialMap = "ExpeditionTrialMap";
    CommonDead2 = "CommonDead2",
    -- BossListUI = "BossListUI",
    -- BossPopUpUI = "BossPopUpUI",
    UiRevive = "UiRevive",
    AwardPreviewUI = "AwardPreviewUI",
    TalentSystemUI = "TalentSystemUI",
    ClanUI = "ClanUI",
    HeroIllumstrationUI = "HeroIllumstrationUI",
    UiGuildBoss  = "UiGuildBoss",
    GuildBossFormationUI  = "GuildBossFormationUI",
    UiGuildBossRank = "UiGuildBossRank",
    GuildBossAwardUI = "GuildBossAwardUI",
    CommonFormationUI = "CommonFormationUI",
    GuildWarMapUI = "GuildWarMapUI",
    ChurchBotMainUi = "ChurchBotMainUi",
    ChurchBotMain = "ChurchBotMain",
    ChurchBotSelect = "ChurchBotSelect",
    ChurchBotLoad = "ChurchBotLoad",
    ChurchBotlineup = "ChurchBotlineup",
    ChurchBotRecord = "ChurchBotRecord",
    ChurchBotTip = "ChurchBotTip",
    ChurchBotBattleList = "ChurchBotBattleList",
    GuildFindLsUI = "GuildFindLsUI",
    GuildFindLsRe = "GuildFindLsRe",
    CommonGetHero = "CommonGetHero",
    EggGetHero = "EggGetHero",
    AreaMainUI = "AreaMainUI",
    LoginRewardUI = "LoginRewardUI",
    HeroShowUI = "HeroShowUI",
	ChangeAreaUi = "ChangeAreaUi",	
    PowerRankUI = "PowerRankUI",
    UiBuy1 = "UiBuy1",
    NewFightUiMinimap = "NewFightUiMinimap",
    CommonAward = "CommonAward",
    CommonAwardVip = "CommonAwardVip",
    AllSkillLevelUpUI = "AllSkillLevelUpUI",
    LuckyCatUI = "LuckyCatUI",
    VendingMachineUI = "VendingMachineUI",
    VendingMachineSuccessUI = "VendingMachineSuccessUI",
    VendingMachineCansUI = "VendingMachineCansUI",
    RewardPreviewShowUI = "RewardPreviewShowUI",
    EquipFragExchangeUI = "EquipFragExchangeUI",
	HeroIllumstrationDetailUI = "HeroIllumstrationDetailUI",
    SelectRoleUi = "SelectRoleUi",
    HeroIllumstrationMain = "HeroIllumstrationMain",
    ExchangeActivitySelectNumUi = "ExchangeActivitySelectNumUi",
    VIPGiftBagSelectNumUI = "VIPGiftBagSelectNumUI",
    EquipStarDownConfirmUI = "EquipStarDownConfirmUI",
    CommonActivitySuccUI = "CommonActivitySuccUI",    
    DifficultSelect = "DifficultSelect",
    BattleRoleInfoUI = "BattleRoleInfoUI",
    ExchangeRedCrystalUI = "ExchangeRedCrystalUI",
    ShareUIActivity = "ShareUIActivity",
    HpExchange = "HpExchange",
    ScoreHeroUI = "ScoreHeroUI",
    HeroTrialUI = "HeroTrialUI",
    HeroTrialFormationUI = "HeroTrialFormationUI",
    HeroTrialLevelAwardUI = "HeroTrialLevelAwardUI",
    HeroTrialFightBoxUI = "HeroTrialFightBoxUI",
    HeroTrialSignBoxUI = "HeroTrialSignBoxUI",
    EquipStarDownResultUi = "EquipStarDownResultUi",
    GuardHeartMainUi = "GuardHeartMainUi",
    GuardHeartSelectRoleUi = "GuardHeartSelectRoleUi",
    ChatFightMainUI = "ChatFightMainUI",
    ChatFightSelectBuffUI = "ChatFightSelectBuffUI",
    ChatFightSelectHeroUI = "ChatFightSelectHeroUI",
    ChatFightRequestUI = "ChatFightRequestUI",
    ChatFightAwardUI = "ChatFightAwardUI",
    GoldenEggUI = "GoldenEggUI",
    MaskMain = "MaskMain",
    MaskMainInfo = "MaskMainInfo",
    MaskRarityUpWnd = "MaskRarityUpWnd",
    MaskStarUpWnd = "MaskStarUpWnd",
}

local uiInformation = {};
uiInformation[EUI.MainUi]                    = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.PackageUi]                 = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.FormationUi]               = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.FormationInfoUi]           = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.FormationUi2]              = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.FormationUiNoHomeBtn]      = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.ChangeEquip]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.ChangeCard]                = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EggEquipUi]                = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EggHeroUi]                 = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EggAwardShowUI]            = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EggHeroShowUI]            = {btnBack = false,  background = false,  showLast = false,};
uiInformation[EUI.EggHeroSubUiGold]              = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EggHeroSubUiCrystal]              = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EggHeroSubUiVip]              = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.FriendUi]                  = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.FriendInfoUI]              = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MailListUI]                = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MailViewUI]                = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MailGiftViewUI]            = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.SevenSignUi]               = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.SevenSignUiSignin]         = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.SevenSignMuBiao]           = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.SevenSignBackUi]               = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.SevenSignMuBiaoBack]           = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MonthSignUi]               = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.ActivityUI]                = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.ActivityWelfareboxBoxShowUI]= {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.LevelActivity]             = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GetAward]                  = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.RankUI]                    = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GuildBossRankUI]           = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.ExpeditionTrialMap]        = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.HeroPackageUI]             = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EquipPackageUI]            = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.BattleUI]                  = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.BattleRoleAttrInfoUI]      = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.InstituteUI]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.CloneBattleUI]             = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.CloneBattleTeamUI]         = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.CloneAreward]              = {btnBack = false, background = true,  showLast = false,};
uiInformation[EUI.TrainningMain]             = {btnBack = true, background = false,  showLast = false,};
uiInformation[EUI.TrainningInfo]             = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.Trainningheroinfo]         = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.Trainninguplv]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.Trainningbattleup]         = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.Trainningmaintip]          = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.Trainninginfotip]          = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.Trainningbattleinfo]       = {btnBack = true,  background = false, showLast = true,};
-- uiInformation[EUI.HeroChoseUI]               = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.GhoulAssaultUI]            = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GhoulHeroUI]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GaoSuJuJiUI]               = {btnBack = true,  background = true,  showLast = false,};
--uiInformation[EUI.EquipmentBaseUI]           = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.UiBaoWeiCanChang]          = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.HuiZhangUI]                = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.HuiZhangChallengeUI]       = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.HuiZhangChallengeEndUI]    = {btnBack = false, background = true,  showLast = false,};
uiInformation[EUI.UiEquipLevelUp]            = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiEquipStarUp]             = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiGm]                      = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.UiLevel]                   = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.UiLevelBox]                = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiLevelAwards]             = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiLevelChallenge]          = {btnBack = true,  background = false,  showLast = true,};
uiInformation[EUI.UiLevelNewGroup]          = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiJiaoTangQiDaoMain]       = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.KuiKuLiYaHurdleUI]         = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.KuiKuLiYaHurdleInfoUI]     = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.KuiKuLiYaOpenBoxUI]        = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.KuiKuLiYaAwardUI]          = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.KuiKuLiYaSweepUI]          = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.KuiKuLiYaRankUI]           = {btnBack = true,  background = true,  showLast = false,};
-- uiInformation[EUI.CellEnhanceUI]             = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.BuildingInfoUI]            = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.BuildingUpgradeUI]         = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.SLGRanking]                = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.BuildingRobberyFightReport]= {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.SearchingRobberyTargetUI]  = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.BuildingEmbattleInfoUI]    = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.TargetBuildingEmbattleInfoUI]= {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.BuildingEmbattleChoseHeroUI]= {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.AttackBuildingEmbattleChoseHeroUI] = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.MyBuildingSceneUI2]        = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.TargetBuildingSceneUI2]    = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.BuildingTabPageUI]         = {btnBack = true,  background = false, showLast = false,};
--uiInformation[EUI.SLGSearchTargetCostUI]         = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.UiJiaoTangQiDaoChoseHero]  = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.FettersUI]                 = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.EquipCompoundUI]           = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EquipCompoundResultUI]     = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.UiShiYiQuTaoFaZhan]        = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.EquipFilterUI]             = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.BreakThroughUI]            = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.BreakThroughPreviewUI]     = {btnBack = true,  background = false, showLast = true,};
-- uiInformation[EUI.ArrangeBattleUI]           = {btnBack = true,  background = true,  showLast = true,};
-- uiInformation[EUI.GuildWarArrangeBattleUI]   = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.DayRewardUI]               = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiSet]                     = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.SetUiReName]               = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.UiDailyTask]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.EggEquipExchangeUI]        = {btnBack = true,  background = true,  showLast = false,};
-- uiInformation[EUI.UiHeroStarUpEgg]           = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.UiJiaoTangQiDaoReport]     = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiWorldBoss]               = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.WorldBossReportUI]         = {btnBack = true,  background = true, showLast = true,};
uiInformation[EUI.WorldBossBackupSystemUI]   = {btnBack = true,  background = true, showLast = false,};
uiInformation[EUI.UiWorldBossRank]           = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiWorldBossReward]         = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.VipPrivilegeUI]            = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.VipPackingUI]            = {btnBack = true,  background = false,  showLast = false,};
uiInformation[EUI.VipHintUI]            = {btnBack = true,  background = false,  showLast = true,};
uiInformation[EUI.StoreUI]                   = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.ActivityStoreUI]                   = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.SupportHeroUI]             = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.WorldTreasureBoxUI]        = {btnBack = true,  background = true, showLast = false,};
uiInformation[EUI.WorldTreasureBoxResultUI]  = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.ArenaMainUI]               = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.ArenaReportUI]             = {btnBack = true,  background = true,  showLast = true,};
-- uiInformation[EUI.ArenaRankUI]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.ArenaPointAwardUI]         = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.ArenaTopRankAwardUI]       = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.ArenaAchieveRankFriendUI]  = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.Fuzion2MainUI]             = {btnBack = true,  background = true, showLast = false,};
-- uiInformation[EUI.Funzion2MatchUI]              = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.FuzionMainUI]              = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.FuzionHeroUI]              = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.FuzionRankUI]              = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.FuzionChoseHeroUI]         = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.GuildLookUI]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GuildCreateUI]             = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.GuildHallUI]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GuildSetMailUI]            = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.GuildSetIconUI]            = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.GuildMemberInfoUI]         = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.GuildMainUI]               = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.GuildSetApprovalUI]        = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.GuildSetDeclarationUI]     = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.GuildSetNameUI]            = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.GuildScienceUI]            = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GuildScienceSubitemUI]     = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GuildScienceDonateUI]      = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.DuelEnterUI]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.ChallengeEnterUI]          = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.AthleticEnterUI]           = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.UiRuleDesNoNavBar]         = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.UiQuestWebView]            = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.ShopUI]                    = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.UiAnn]                     = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.HeroStarUp]                = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.RoleUpexpUI]               = {btnBack = true,  background = true,  showLast = true,};
-- uiInformation[EUI.Ui3v3Matching]             = {btnBack = false, background = true,  showLast = false,};
uiInformation[EUI.MobaMatchingUI]            = {btnBack = false, background = false,  showLast = true,};
uiInformation[EUI.MobaEnterTipsUI]           = {btnBack = false, background = false,  showLast = true,};
uiInformation[EUI.MobaReadyEnterUI]          = {btnBack = false, background = false,  showLast = true,};
uiInformation[EUI.QingTongJiDiRankUI]        = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.QingTongJiDiEnterUI]       = {btnBack = true,  background = false,  showLast = false,};
uiInformation[EUI.QingTongJiDiRoomUI]        = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.QingTongJiDiAwardUI]       = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.QingTongJiDiHeroChoseUI]   = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.UiDevelopGuide]            = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.UiEquipForge]              = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.UiEquipForgeEquipList]     = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.UiEquipForgeChoseEquip]    = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.UiAreaMap]                 = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.UiMap]                     = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.RestraintUi]               = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.RestraintTotalPlusUi]      = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.SkillUpgradeUI]            = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.MMOMainUI]                 = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MMOTaskListUI]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MMOTaskDialogUI]           = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MMOChoiceUI]               = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.UiFirstRecharge]           = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.GoldExchangeUI]            = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.UiTitle]                   = {btnBack = false, background = false, showLast = true,};

uiInformation[EUI.CommonDead2]               = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.LoginInGame]               = {btnBack = false, background = false, showLast = true,};
-- uiInformation[EUI.BossListUI]                = {btnBack = true,  background = true,  showLast = false,};
-- uiInformation[EUI.BossPopUpUI]               = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.UiRevive]                  = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.AwardPreviewUI]            = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.TalentSystemUI]            = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.ClanUI]                    = {btnBack = true,  background = true, showLast = false,};
uiInformation[EUI.HeroIllumstrationUI]       = {btnBack = true,  background = false,  showLast = false,};
uiInformation[EUI.UiClownPlan]               = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.UiGuildBoss]               = {btnBack = true,  background = true, showLast = false,};
uiInformation[EUI.GuildBossFormationUI]      = {btnBack = true,  background = true, showLast = false,};
uiInformation[EUI.UiGuildBossRank]           = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.GuildBossAwardUI]          = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.CommonFormationUI]         = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GuildWarMapUI]             = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.ChurchBotMainUi]           = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.ChurchBotMain]             = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.ChurchBotSelect]           = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.ChurchBotLoad]             = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.ChurchBotlineup]           = {btnBack = true, background = false, showLast = false,};
uiInformation[EUI.ChurchBotRecord]           = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.ChurchBotTip]              = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.ChurchBotBattleList]       = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.GuildFindLsUI]             = {btnBack = true,  background = true,  showLast = false,};
uiInformation[EUI.GuildFindLsRe]             = {btnBack = true,  background = false, showLast = true,};
uiInformation[EUI.AreaMainUI]                = {btnBack = true,  background = false, showLast = false,};
uiInformation[EUI.CommonGetHero]             = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.EggGetHero]             = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.LoginRewardUI]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.HeroShowUI]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.UiBuy1]                    = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.NewFightUiMinimap]         = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.CommonAward]               = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.CommonAwardVip]               = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.AllSkillLevelUpUI]               = {btnBack = false, background = true,  showLast = true,};
uiInformation[EUI.ChangeAreaUi]              = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.PowerRankUI]               = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.LuckyCatUI]                = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.VendingMachineUI]          = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.VendingMachineSuccessUI]   = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.VendingMachineCansUI]      = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.RewardPreviewShowUI]       = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.EquipFragExchangeUI]       = {btnBack = true,  background = true,  showLast = true,};
uiInformation[EUI.HeroIllumstrationDetailUI]       = {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.SelectRoleUi]       =     {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.HeroIllumstrationMain]       =     {btnBack = true,  background = false,  showLast = false,};
uiInformation[EUI.ExchangeActivitySelectNumUi]       =     {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.VIPGiftBagSelectNumUI]       =     {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.EquipStarDownConfirmUI]       =     {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.CommonActivitySuccUI]       =     {btnBack = false,  background = false,  showLast = false,};
uiInformation[EUI.DifficultSelect]       =     {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.BattleRoleInfoUI]       =     {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.ExchangeRedCrystalUI] = {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.HpExchange] = {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.ShareUIActivity] = {btnBack = false,  background = false,  showLast = true,};
uiInformation[EUI.ScoreHeroUI]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.HeroTrialUI]             = {btnBack = true, background = false, showLast = false,};
uiInformation[EUI.HeroTrialFormationUI]    = {btnBack = true, background = true, showLast = false,};
uiInformation[EUI.HeroTrialLevelAwardUI]   = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.HeroTrialFightBoxUI]      = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.HeroTrialSignBoxUI]      = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.EquipStarDownResultUi]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.GuardHeartMainUi]             = {btnBack = true, background = false, showLast = false,};
uiInformation[EUI.GuardHeartSelectRoleUi]             = {btnBack = true, background = false, showLast = true,};
uiInformation[EUI.ChatFightMainUI]                   = {btnBack = true, background = true, showLast = false,};
uiInformation[EUI.ChatFightSelectBuffUI]             = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.ChatFightSelectHeroUI]             = {btnBack = false, background = false, showLast = false,};
uiInformation[EUI.ChatFightRequestUI]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.ChatFightAwardUI]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.GoldenEggUI]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MaskMain]             = {btnBack = true, background = true, showLast = false,};
uiInformation[EUI.MaskMainInfo]             = {btnBack = true, background = true, showLast = false,};
uiInformation[EUI.MaskRarityUpWnd]             = {btnBack = false, background = false, showLast = true,};
uiInformation[EUI.MaskStarUpWnd]             = {btnBack = false, background = false, showLast = true,};
local eRule = ENUM.ERuleDesType
------------------------ 界面规则说明配置 ----------------------
uiInformation[EUI.EggEquipUi].ruleId        = eRule.ZhuangBeiKu;
uiInformation[EUI.EggHeroUi].ruleId         = eRule.ZhaoMuZhongXin;
uiInformation[EUI.GaoSuJuJiUI].ruleId       = eRule.BaoWeiZhan;
--uiInformation[EUI.EquipmentBaseUI].ruleId   = eRule.YingXiongLiLian;
uiInformation[EUI.UiBaoWeiCanChang].ruleId  = eRule.GaoSuZuJi;
uiInformation[EUI.UiEquipLevelUp].ruleId    = eRule.EquipLevelUp;
uiInformation[EUI.UiEquipStarUp].ruleId     = eRule.ZhuangBeiShengXin;
uiInformation[EUI.UiLevel].ruleId           = eRule.ChuangGuan;
uiInformation[EUI.UiJiaoTangQiDaoMain].ruleId = eRule.JiaoTangGuaJi;
uiInformation[EUI.KuiKuLiYaHurdleUI].ruleId = eRule.KuiKuLiYa;
uiInformation[EUI.SLGRanking].ruleId        = eRule.XiaoYuanJianShe;
uiInformation[EUI.TargetBuildingEmbattleInfoUI].ruleId = eRule.XiaoYuanJianSheLueDuo;
uiInformation[EUI.MyBuildingSceneUI2].ruleId = eRule.XiaoYuanJianShe;
uiInformation[EUI.TargetBuildingSceneUI2].ruleId = eRule.XiaoYuanJianSheLueDuo;
uiInformation[EUI.BuildingTabPageUI].ruleId = eRule.XiaoYuanJianShe;
uiInformation[EUI.FettersUI].ruleId         = eRule.LianXie;
uiInformation[EUI.EquipCompoundUI].ruleId   = eRule.ZhuangBeiHeCheng;
uiInformation[EUI.UiWorldBoss].ruleId       = eRule.ShiJieBoss;
uiInformation[EUI.WorldTreasureBoxUI].ruleId        = eRule.WorldBox;
uiInformation[EUI.ArenaMainUI].ruleId       = eRule.JingJiChang;
uiInformation[EUI.Fuzion2MainUI].ruleId      = eRule.DaLuanDou;
uiInformation[EUI.FuzionMainUI].ruleId      = eRule.DaLuanDou;
uiInformation[EUI.GuildLookUI].ruleId       = eRule.GongHui;
uiInformation[EUI.GuildMainUI].ruleId       = eRule.GongHui;
uiInformation[EUI.QingTongJiDiEnterUI].ruleId = eRule.QingTongJiDi;
uiInformation[EUI.UiEquipForge].ruleId      = eRule.EquipForge;
uiInformation[EUI.SkillUpgradeUI].ruleId    = eRule.SkillUpgrade;
uiInformation[EUI.TalentSystemUI].ruleId    = eRule.TianFu;
uiInformation[EUI.UiClownPlan].ruleId    	= eRule.ClownPlan;
uiInformation[EUI.CloneBattleUI].ruleId    	= eRule.CloneWar;
uiInformation[EUI.InstituteUI].ruleId    	= eRule.Institute;
uiInformation[EUI.ChurchBotMainUi].ruleId           = eRule.ChurchBotMain;
uiInformation[EUI.ChurchBotMain].ruleId         = eRule.ChurchBotMain;
uiInformation[EUI.GuildFindLsUI].ruleId         = eRule.GuildFindLsUI;
uiInformation[EUI.ExpeditionTrialMap].ruleId = eRule.ExpeditionTrial;
uiInformation[EUI.TrainningMain].ruleId     = eRule.TrainningMain;
uiInformation[EUI.EquipPackageUI].ruleId    = eRule.EquipLevelUp;
uiInformation[EUI.UiGuildBoss].ruleId       = eRule.GuildBoss;
uiInformation[EUI.GuildWarMapUI].ruleId     = eRule.GuildWar;
uiInformation[EUI.RestraintUi].ruleId       = eRule.Restraint;
uiInformation[EUI.HeroIllumstrationUI].ruleId = eRule.HeroIllumstrationUI;
uiInformation[EUI.HeroIllumstrationMain].ruleId = eRule.HeroIllumstrationUI;
uiInformation[EUI.HeroTrialUI].ruleId       = eRule.HeroTrial;
uiInformation[EUI.GuardHeartMainUi].ruleId = eRule.GuradHeart;
uiInformation[EUI.ChatFightMainUI].ruleId = eRule.ChatFight;
uiInformation[EUI.VipPackingUI].ruleId = eRule.VipPacking;
uiInformation[EUI.MaskMain].ruleId = eRule.MaskSystem;
uiInformation[EUI.MaskMainInfo].ruleId = eRule.MaskSystem;

------------------------ 导航条标题内容配置 ----------------------
uiInformation[EUI.StoreUI].title                = "充值";
uiInformation[EUI.ActivityStoreUI].title                = "商城";
uiInformation[EUI.VipPrivilegeUI].title         = "特权";
uiInformation[EUI.VipPackingUI].title         = "董香之屋";
uiInformation[EUI.ActivityUI].title             = "活动";
uiInformation[EUI.LevelActivity].title          = "活动关卡";
uiInformation[EUI.UiDailyTask].title            = "任务";
-- uiInformation[EUI.SevenSignUi].title            = "签到";       --功能已废
-- uiInformation[EUI.SevenSignUiSignin].title      = "7日签到";       --功能已废
-- uiInformation[EUI.SevenSignMuBiao].title        = "目标奖励";       --功能已废
uiInformation[EUI.FriendUi].title               = "好友";
uiInformation[EUI.DuelEnterUI].title            = "对决";
uiInformation[EUI.ChallengeEnterUI].title       = "挑战";
uiInformation[EUI.AthleticEnterUI].title        = "竞技";
uiInformation[EUI.UiLevel].title                = "闯关";
uiInformation[EUI.UiLevelChallenge].title       = "闯关";
uiInformation[EUI.RankUI].title                 = "排行榜";
uiInformation[EUI.GuildBossRankUI].title        = "排行榜";
uiInformation[EUI.UiFirstRecharge].title        = "首充";
uiInformation[EUI.ExpeditionTrialMap].title     = "捕食场";
uiInformation[EUI.PackageUi].title              = "背包";
uiInformation[EUI.ShopUI].title                 = "商店";
uiInformation[EUI.EggHeroUi].title              = "招募";
uiInformation[EUI.EggHeroSubUiGold].title           = "招募";
uiInformation[EUI.EggHeroSubUiCrystal].title           = "招募";
uiInformation[EUI.EggHeroSubUiVip].title           = "招募";
uiInformation[EUI.EggAwardShowUI].title      = "奖励预览";
uiInformation[EUI.EquipPackageUI].title         = "装备";
uiInformation[EUI.BattleUI].title               = "角色";
uiInformation[EUI.ClanUI].title                 = "战队";
uiInformation[EUI.HeroIllumstrationMain].title    = "档案馆";
uiInformation[EUI.HeroIllumstrationUI].title = "档案馆";
uiInformation[EUI.InstituteUI].title            = "研究所";
uiInformation[EUI.CloneBattleUI].title          = "克隆战";
uiInformation[EUI.CloneBattleTeamUI].title      = "克隆战";
--社团
uiInformation[EUI.GuildMainUI].title            = "社团";
uiInformation[EUI.GuildLookUI].title            = "社团";
uiInformation[EUI.GuildHallUI].title            = "社团大厅";
uiInformation[EUI.GuildScienceUI].title         = "社团科技";
uiInformation[EUI.GuildScienceSubitemUI].title  = "社团科技";
uiInformation[EUI.GuildScienceDonateUI].title   = "社团科技";
-- uiInformation[EUI.].title   = "社团战"; -- TODO

uiInformation[EUI.TrainningMain].title          = "实战训练";
uiInformation[EUI.TrainningInfo].title          = "实战训练";
--3v3
uiInformation[EUI.QingTongJiDiEnterUI].title    = "攻防3V3";
uiInformation[EUI.QingTongJiDiRoomUI].title     = "攻防3V3";
uiInformation[EUI.QingTongJiDiHeroChoseUI].title= "攻防3V3";
uiInformation[EUI.QingTongJiDiAwardUI].title    = "攻防3V3";
uiInformation[EUI.QingTongJiDiRankUI].title     = "排行榜";
--大乱斗
uiInformation[EUI.Fuzion2MainUI].title          = "大乱斗";
uiInformation[EUI.FuzionMainUI].title           = "大乱斗";
uiInformation[EUI.FuzionHeroUI].title           = "大乱斗";
uiInformation[EUI.FuzionChoseHeroUI].title      = "大乱斗";
uiInformation[EUI.FuzionRankUI].title           = "排行榜";
--竞技场
uiInformation[EUI.ArenaMainUI].title            = "竞技场";
uiInformation[EUI.ArenaReportUI].title          = "战报";
-- uiInformation[EUI.ArenaRankUI].title            = "排行榜";
uiInformation[EUI.ArenaTopRankAwardUI].title    = "奖励";

uiInformation[EUI.UiWorldBoss].title            = "世界首领";
uiInformation[EUI.WorldBossBackupSystemUI].title            = "助阵";
uiInformation[EUI.WorldTreasureBoxUI].title     = "世界宝箱";
uiInformation[EUI.KuiKuLiYaHurdleUI].title      = "极限挑战";
-- uiInformation[EUI.UiJiaoTangQiDaoMain].title    = "经验挂机";
-- uiInformation[EUI.MyBuildingSceneUI2].title     = "咖啡店";
uiInformation[EUI.TalentSystemUI].title         = "天赋";
uiInformation[EUI.RestraintUi].title            = "克制";

--阵容
uiInformation[EUI.HeroPackageUI].title          = "角色";
uiInformation[EUI.FormationUi].title            = "阵容";
uiInformation[EUI.FormationUi2].title           = "阵容";
uiInformation[EUI.FormationUiNoHomeBtn].title   = "阵容";
uiInformation[EUI.UiGuildBoss].title            = "社团首领";
uiInformation[EUI.CommonFormationUI].title      = "上阵";
uiInformation[EUI.GuildWarMapUI].title         = "社团战"
uiInformation[EUI.ChangeAreaUi].title      = "区域";
uiInformation[EUI.ChurchBotMainUi].title      = "区域占领";
uiInformation[EUI.ChurchBotMain].title      = "区域占领";
uiInformation[EUI.ChurchBotTip].title      = "区域占领";
uiInformation[EUI.ChurchBotlineup].title   = "区域占领";
uiInformation[EUI.GuildFindLsUI].title      = "寻找利世";
uiInformation[EUI.MaskMain].title      = "收藏屋";
uiInformation[EUI.MaskMainInfo].title      = "收藏屋";

--角色历练
uiInformation[EUI.HeroTrialUI].title            = "角色历练";
uiInformation[EUI.HeroTrialFormationUI].title   = "上阵";
uiInformation[EUI.ChatFightMainUI].title      = "喰场对决";

--守护者
uiInformation[EUI.GuardHeartMainUi].title = "守护之心";


------------------------ 导航条特殊资源显示开关配置 ----------------------
--竞技场       奖牌
uiInformation[EUI.ArenaMainUI].coin = {id=IdConfig.Medal, get_way=false}
--社团         社团贡献
uiInformation[EUI.GuildHallUI].coin = {id=IdConfig.GuildContribution, get_way=false}
--远征试炼      远征币
uiInformation[EUI.ExpeditionTrialMap].coin = {id=IdConfig.ExpeditionCoin, get_way=false}
--区域掠夺        精力
uiInformation[EUI.ChurchBotMainUi].coin = {id=IdConfig.ChurchBotCoin,get_way=true}
uiInformation[EUI.ChurchBotMain].coin = {id=IdConfig.ChurchBotCoin,get_way=true}
uiInformation[EUI.ChurchBotTip].coin = {id=IdConfig.ChurchBotCoin,get_way=true}
uiInformation[EUI.ChurchBotlineup].coin = {id=IdConfig.ChurchBotCoin,get_way=true}
uiInformation[EUI.EggHeroUi].coin = {id=IdConfig.RedCrystal,get_way=true}
uiInformation[EUI.ShopUI].coin = {id=IdConfig.RedCrystal,get_way=true}
uiInformation[EUI.PackageUi].coin = {id=IdConfig.RedCrystal,get_way=true}
uiInformation[EUI.ActivityUI].coin = {id=IdConfig.RedCrystal,get_way=true}
uiInformation[EUI.ActivityStoreUI].coin = {id=IdConfig.RedCrystal,get_way=true}


------------------------ 隐藏 导航条（默认0全部显示 1隐藏 2隐藏三个货币栏） ----------------------
-- uiInformation[EUI.Ui3v3Matching].showState = 1
uiInformation[EUI.CommonGetHero].showState = 1
uiInformation[EUI.EggGetHero].showState = 1
uiInformation[EUI.HeroIllumstrationMain].showState = 2
uiInformation[EUI.ChangeAreaUi].showState = 1
uiInformation[EUI.EggHeroShowUI].showState = 1
uiInformation[EUI.ChatFightSelectBuffUI].showState = 1
uiInformation[EUI.ChatFightSelectHeroUI].showState = 1


------------------------ 导航条公用底图（默认底图 ENUM.PublicBgImage.DLD 可不配置） ----------------------
-- uiInformation[EUI.ChallengeEnterUI].resBg = ENUM.PublicBgImage.DLD;
-- uiInformation[EUI.AthleticEnterUI].resBg = ENUM.PublicBgImage.DLD;
uiInformation[EUI.QingTongJiDiEnterUI].resBg = ENUM.PublicBgImage.DLD;
-- uiInformation[EUI.Ui3v3Matching].resBg = ENUM.PublicBgImage.DZ;
uiInformation[EUI.CloneBattleTeamUI].resBg = ENUM.PublicBgImage.KLZ;
uiInformation[EUI.Fuzion2MainUI].resBg = ENUM.PublicBgImage.DLDJS;
-- uiInformation[EUI.ClanUI].resBg = ENUM.PublicBgImage.DLD;
-- uiInformation[EUI.UiLevel].resBg = ENUM.PublicBgImage.GQ1;
-- uiInformation[EUI.UiLevel].resBg = ENUM.PublicBgImage.GQ2;
uiInformation[EUI.UiGuildBoss].resBg = ENUM.PublicBgImage.STBOSS;
uiInformation[EUI.UiWorldBoss].resBg = ENUM.PublicBgImage.DLD;
-- uiInformation[EUI.WorldBossBackupSystemUI].resBg = ENUM.PublicBgImage.SJBOSS;
uiInformation[EUI.WorldTreasureBoxUI].resBg = ENUM.PublicBgImage.SJBX;
uiInformation[EUI.ExpeditionTrialMap].resBg = ENUM.PublicBgImage.YZSL;
uiInformation[EUI.EggHeroUi].resBg = ENUM.PublicBgImage.ZM1;
uiInformation[EUI.HeroPackageUI].resBg = ENUM.PublicBgImage.DLD2;
uiInformation[EUI.LevelActivity].resBg = ENUM.PublicBgImage.DLD2;
uiInformation[EUI.GuildFindLsUI].resBg = ENUM.PublicBgImage.LS;
uiInformation[EUI.MaskMain].resBg = ENUM.PublicBgImage.MASK;
uiInformation[EUI.MaskMainInfo].resBg = ENUM.PublicBgImage.MASK2;

------------------------ ui界面的背景音乐，不配置的话就不改变 ----------------------
uiInformation[EUI.ExpeditionTrialMap].backAudioId = 81000060;
uiInformation[EUI.DuelEnterUI].backAudioId = ENUM.EUiAudioBGM.MainCityBgm;
uiInformation[EUI.ChallengeEnterUI].backAudioId = ENUM.EUiAudioBGM.MainCityBgm;
uiInformation[EUI.AthleticEnterUI].backAudioId = ENUM.EUiAudioBGM.MainCityBgm;
uiInformation[EUI.KuiKuLiYaHurdleUI].backAudioId = 81000067;
uiInformation[EUI.GuardHeartMainUi].backAudioId = 81000058;
uiInformation[EUI.ClanUI].backAudioId = ENUM.EUiAudioBGM.MainCityBgm;


UiManager.ClassList =
{
    [EUI.MainUi] = {MainUI},
    [EUI.FormationUi] = {FormationUi},
    [EUI.FormationInfoUi] = {FormationInfoUi},
    [EUI.FormationUi2] = {FormationUi,"fight_back"},
    [EUI.FormationUiNoHomeBtn] = {FormationUi},
    [EUI.ChangeEquip] = {ChangeEquip},
    [EUI.ChangeCard] = {ChangeCard},
    [EUI.PackageUi] = {PackageUI},
    [EUI.EggHeroUi] = {EggHeroUi},
    [EUI.EggAwardShowUI] = {EggAwardShowUI},
    [EUI.EggHeroShowUI] = {EggHeroShowUI},
    [EUI.EggHeroSubUiGold] = {EggHeroSubUi,{type=ENUM.NiuDanType.Gold}},
    [EUI.EggHeroSubUiCrystal] = {EggHeroSubUi,{type=ENUM.NiuDanType.Hero}},
    [EUI.EggHeroSubUiVip] = {EggHeroSubUi,{type=ENUM.NiuDanType.Vip}},
    [EUI.EggEquipUi] = {EggEquipUi},
    [EUI.FriendUi] = {FriendUI},
    [EUI.FriendInfoUI] = {FriendInfoUI},
    [EUI.MailListUI] = {MailListUI},
    [EUI.MailViewUI] = {MailViewUI},
    [EUI.MailGiftViewUI] = {MailGiftViewUI},
    [EUI.SevenSignUi] = {SevenSignUi},
    [EUI.SevenSignUiSignin] = {SevenSignUiSignin},
    [EUI.SevenSignMuBiao] = {SevenSignMuBiao},
    [EUI.SevenSignBackUi] = {SevenSignBackUi},
    [EUI.SevenSignMuBiaoBack] = {SevenSignMuBiaoBack},
    [EUI.MonthSignUi] = {MonthSignUi},
    [EUI.ActivityUI] = {ActivityUI},
    [EUI.ActivityWelfareboxBoxShowUI] = {ActivityWelfareboxBoxShowUI},
    [EUI.LevelActivity] = {LevelActivity},
    [EUI.GetAward] = {GetAward},
    [EUI.RankUI] = {RankUI},
    [EUI.GuildBossRankUI] = {GuildBossRankUI},
    [EUI.HeroPackageUI] = {HeroPackageUI},
    [EUI.EquipPackageUI] = {EquipPackageUI},
    [EUI.BattleUI] = {BattleUI},
    [EUI.BattleRoleAttrInfoUI] = {BattleRoleAttrInfoUI},
    -- [EUI.HeroChoseUI] = {HeroChoseUI},
    [EUI.GhoulAssaultUI] = {GhoulAssaultUI},
    [EUI.GhoulHeroUI] = {GhoulHeroUI},
    [EUI.GaoSuJuJiUI] = {GaoSuJuJiUI},
    --[EUI.EquipmentBaseUI] = {ZhuangBeiKuUI},
    [EUI.UiBaoWeiCanChang] = {UiBaoWeiCanChang},
    [EUI.HuiZhangUI] = {HuiZhangUI},
    [EUI.HuiZhangChallengeUI] = {HuiZhangChallengeUI},
    [EUI.HuiZhangChallengeEndUI] = {HuiZhangChallengeEndUI},
    [EUI.UiEquipLevelUp] = {UiEquipLevelUp},
    [EUI.UiEquipStarUp] = {UiEquipStarUp},
    [EUI.UiGm] = {UiGm},
    [EUI.UiLevel] = {UiLevel},
    [EUI.UiLevelBox] = {UiLevelBox},
    [EUI.UiLevelAwards] = {UiLevelAwards},
    [EUI.UiLevelChallenge] = {UiLevelChallenge},
    [EUI.UiLevelNewGroup] = {UiLevelNewGroup},
    [EUI.UiJiaoTangQiDaoMain] = {UiJiaoTangQiDaoMain},
    -- [EUI.CellEnhanceUI] = {CellEnhanceUI},
    [EUI.BuildingInfoUI] = {BuildingInfoUI},
    [EUI.BuildingUpgradeUI] = {BuildingUpgradeUI},
    [EUI.SLGRanking] = {SLGRanking},
    [EUI.BuildingRobberyFightReport] = {BuildingRobberyFightReport},
    [EUI.SearchingRobberyTargetUI] = {SearchingRobberyTargetUI},
    [EUI.BuildingEmbattleInfoUI] = {BuildingEmbattleInfoUI},
    [EUI.TargetBuildingEmbattleInfoUI] = {TargetBuildingEmbattleInfoUI},
    [EUI.BuildingEmbattleChoseHeroUI] = {BuildingEmbattleChoseHeroUI},
    [EUI.AttackBuildingEmbattleChoseHeroUI] = {AttackBuildingEmbattleChoseHeroUI},
    [EUI.MyBuildingSceneUI2] = {MyBuildingSceneUI2},
    [EUI.TargetBuildingSceneUI2] = {TargetBuildingSceneUI2},
    [EUI.BuildingTabPageUI] = {BuildingTabPageUI},
    --[EUI.SLGSearchTargetCostUI] = {SLGSearchTargetCostUI},
    [EUI.UiJiaoTangQiDaoChoseHero] = {UiJiaoTangQiDaoChoseHero},
    [EUI.FettersUI] = {FettersUI},
    [EUI.KuiKuLiYaHurdleUI] = {KuiKuLiYaHurdleUI},
    [EUI.KuiKuLiYaHurdleInfoUI] = {KuiKuLiYaHurdleInfoUI},
    [EUI.KuiKuLiYaOpenBoxUI] = {KuiKuLiYaOpenBoxUI},
    [EUI.KuiKuLiYaAwardUI] = {KuiKuLiYaAwardUI},
    [EUI.KuiKuLiYaSweepUI] = {KuiKuLiYaSweepUI},
    [EUI.KuiKuLiYaRankUI] = {KuiKuLiYaRankUI},
    [EUI.EquipCompoundUI] = {EquipCompoundUI},
    [EUI.EquipCompoundResultUI] = {EquipCompoundResultUI},
    [EUI.UiShiYiQuTaoFaZhan] = {UiShiYiQuTaoFaZhan},
    [EUI.EquipFilterUI] = {EquipFilterUI},
    [EUI.UiShiYiQuTaoFaZhan] = {UiShiYiQuTaoFaZhan},
    [EUI.BreakThroughUI] = {BreakThroughUI},
    [EUI.BreakThroughPreviewUI] = {BreakThroughPreviewUI},
    -- [EUI.ArrangeBattleUI] = {ArrangeBattleUI},
    -- [EUI.GuildWarArrangeBattleUI] = {GuildWarArrangeBattleUI},
    [EUI.DayRewardUI] = {DayRewardUI},
    [EUI.UiSet] = {UiSet},
    [EUI.SetUiReName] = {SetUiReName},
    [EUI.UiDailyTask] = {UiDailyTask},
    [EUI.EggEquipExchangeUI] = {EggEquipExchangeUI},
    -- [EUI.UiHeroStarUpEgg] = {UiHeroStarUpEgg},
    [EUI.UiJiaoTangQiDaoReport] = {UiJiaoTangQiDaoReport},
    [EUI.UiWorldBoss] = {UiWorldBoss},
    [EUI.WorldBossReportUI] = {WorldBossReportUI},
    [EUI.WorldBossBackupSystemUI] = {WorldBossBackupSystemUI},
    [EUI.UiWorldBossRank] = {UiWorldBossRank},
    [EUI.UiWorldBossReward] = {UiWorldBossReward},
    [EUI.SupportHeroUI] = {SupportHeroUI},
    [EUI.UiRuleDesNoNavBar] ={UiRuleDesNoNavBar},
    [EUI.UiQuestWebView]= {UiQuestWebView},
    [EUI.VipPrivilegeUI]= {VipPrivilegeUI},
    [EUI.VipPackingUI]= {VipPackingUI},
    [EUI.VipHintUI]= {VipHintUI},
    [EUI.StoreUI]= {StoreUI},
    [EUI.ActivityStoreUI]= {ActivityStoreUI},
    [EUI.ShopUI]= {ShopUI},
    [EUI.UiAnn] = {UiAnn},
    [EUI.InstituteUI] = {InstituteUI},
    [EUI.CloneBattleUI] = {CloneBattleUI},
    [EUI.CloneBattleTeamUI] = {CloneBattleTeamUI},
    [EUI.CloneAreward] = {CloneAreward},
    [EUI.TrainningMain] = {TrainningMain},
        [EUI.TrainningInfo] = {TrainningInfo},
        [EUI.Trainningheroinfo] = {Trainningheroinfo},
        [EUI.Trainninguplv] = {Trainninguplv},
        [EUI.Trainningbattleup] = {Trainningbattleup},
        [EUI.Trainningmaintip] = {Trainningmaintip},
        [EUI.Trainninginfotip] = {Trainninginfotip},
        [EUI.Trainningbattleinfo] = {Trainningbattleinfo},
    [EUI.WorldTreasureBoxUI] = {WorldTreasureBoxUI},
    [EUI.WorldTreasureBoxResultUI] = {WorldTreasureBoxResultUI},
    [EUI.ArenaMainUI] = {ArenaMainUI, "push"},
    [EUI.ArenaReportUI] = {ArenaReportUI, "push"},
    -- [EUI.ArenaRankUI] = {ArenaRankUI},
    [EUI.ArenaPointAwardUI] = {ArenaPointAwardUI},
    [EUI.ArenaTopRankAwardUI] = {ArenaTopRankAwardUI},
    [EUI.ArenaAchieveRankFriendUI] = {ArenaAchieveRankFriendUI},
    [EUI.Fuzion2MainUI] = {Fuzion2MainUI},
    -- [EUI.Funzion2MatchUI] = {Funzion2MatchUI},
    [EUI.FuzionMainUI] = {FuzionMainUI},
    [EUI.FuzionHeroUI] = {FuzionHeroUI},
    [EUI.FuzionRankUI] = {FuzionRankUI},
    [EUI.FuzionChoseHeroUI] = {FuzionChoseHeroUI},
    [EUI.GuildLookUI] = {GuildLookUI},
    [EUI.GuildCreateUI] = {GuildCreateUI},
    [EUI.GuildHallUI] = {GuildHallUI},
    [EUI.GuildSetMailUI] = {GuildSetMailUI},
    [EUI.GuildSetIconUI] = {GuildSetIconUI},
    [EUI.GuildMemberInfoUI] = {GuildMemberInfoUI},
    [EUI.GuildMainUI] = {GuildMainSceneUI},
    [EUI.GuildSetApprovalUI] = {GuildSetApprovalUI},
    [EUI.GuildSetDeclarationUI] = {GuildSetDeclarationUI},
    [EUI.GuildSetNameUI] = {GuildSetNameUI},
    [EUI.GuildScienceUI] = {GuildScienceUI},
    [EUI.GuildScienceSubitemUI] = {GuildScienceSubitemUI},
    [EUI.GuildScienceDonateUI] = {GuildScienceDonateUI},
    [EUI.DuelEnterUI] = {CommomPlayUI, 3},
    [EUI.ChallengeEnterUI] = {CommomPlayUI, 2},
    [EUI.AthleticEnterUI] = {CommomPlayUI, 1},
    [EUI.HeroStarUp] = {HeroStarUp},
    [EUI.RoleUpexpUI] = {RoleUpexpUI},
    -- [EUI.Ui3v3Matching] = {Ui3v3Matching},
    [EUI.MobaMatchingUI] = {MobaMatchingUI},
    [EUI.MobaEnterTipsUI] = {MobaEnterTipsUI},
    [EUI.MobaReadyEnterUI] = {MobaReadyEnterUI},
    [EUI.QingTongJiDiRankUI] = {QingTongJiDiRankUI},
    [EUI.QingTongJiDiEnterUI] = {QingTongJiDiEnterUI},
    [EUI.QingTongJiDiRoomUI] = {QingTongJiDiRoomUI},
    [EUI.QingTongJiDiAwardUI] = {QingTongJiDiAwardUI},
    [EUI.QingTongJiDiHeroChoseUI] = {QingTongJiDiHeroChoseUI},
    [EUI.UiDevelopGuide] = {UiDevelopGuide},
    [EUI.UiEquipForge] = {UiEquipForge},
    [EUI.UiEquipForgeEquipList] = {UiEquipForgeEquipList},
    [EUI.UiEquipForgeChoseEquip] = {UiEquipForgeChoseEquip},
    [EUI.UiAreaMap] = {UiAreaMap},
    [EUI.UiMap] = {UiMap},
    [EUI.RestraintUi] = {RestraintUi},
    [EUI.SkillUpgradeUI] = {SkillUpgradeUI},
    [EUI.RestraintTotalPlusUi] = {RestraintTotalPlusUi},
    [EUI.MMOMainUI] = {MMOMainUI},
    [EUI.MMOTaskListUI] = {MMOTaskListUI},
    [EUI.MMOTaskDialogUI] = {MMOTaskDialogUI},
    [EUI.MMOChoiceUI] = {MMOChoiceUI},
    [EUI.UiFirstRecharge] = {UiFirstRecharge},
    [EUI.GoldExchangeUI] = {GoldExchangeUI},
    [EUI.UiTitle] = {[1]=UiTitle},
    [EUI.UiClownPlan] = {UiClownPlan},

    [EUI.CommonDead2] = {CommonDead2},
    [EUI.LoginInGame] = {LoginInGame},
    -- [EUI.BossListUI] = {BossListUI},
    -- [EUI.BossPopUpUI] = {BossPopUpUI},
    [EUI.UiRevive] = {UiRevive},
    [EUI.AwardPreviewUI] = {AwardPreviewUI},
    [EUI.TalentSystemUI] = {TalentSystemUI},
    [EUI.ClanUI] = {ClanUI},
    [EUI.ExpeditionTrialMap] = {ExpeditionTrialMap},
    [EUI.HeroIllumstrationUI] = {HeroIllumstrationUI},
    [EUI.UiGuildBoss] = {UiGuildBoss},
    [EUI.GuildBossFormationUI] = {GuildBossFormationUI},
    [EUI.UiGuildBossRank] = {UiGuildBossRank},
    [EUI.GuildBossAwardUI] = {GuildBossAwardUI},
    [EUI.CommonFormationUI] = {CommonFormationUI},
    [EUI.GuildWarMapUI] = {GuildWarMapUI},
    [EUI.ChurchBotMainUi] = {ChurchBotMainUi},
    [EUI.ChurchBotMain] = {ChurchBotMain},
    [EUI.ChurchBotSelect] = {ChurchBotSelect},
    [EUI.ChurchBotLoad] = {ChurchBotLoad},
    [EUI.ChurchBotlineup] = {ChurchBotlineup},
    [EUI.ChurchBotRecord] = {ChurchBotRecord},
    [EUI.ChurchBotTip] = {ChurchBotTip},
    [EUI.ChurchBotBattleList] = {ChurchBotBattleList},
    [EUI.GuildFindLsUI] = {GuildFindLsUI},
    [EUI.GuildFindLsRe] = {GuildFindLsRe},
    [EUI.CommonGetHero] = {CommonGetHero},
    [EUI.EggGetHero] = {EggGetHero},
    [EUI.AreaMainUI] = {AreaMainUI},
    [EUI.LoginRewardUI] = {LoginRewardUI},
    [EUI.HeroShowUI] = {HeroShowUI},
    [EUI.UiBuy1] = {UiBuy1},
    [EUI.NewFightUiMinimap] = {NewFightUiMinimap},
    [EUI.CommonAward] = {CommonAward},
    [EUI.CommonAwardVip] = {CommonAwardVip},
    [EUI.AllSkillLevelUpUI] = {AllSkillLevelUpUI},
    [EUI.ChangeAreaUi] = {ChangeAreaUi},
    [EUI.PowerRankUI] = {PowerRankUI},
    [EUI.LuckyCatUI] = {LuckyCatUI},
    [EUI.VendingMachineUI] = {VendingMachineUI},
    [EUI.VendingMachineSuccessUI] = {VendingMachineSuccessUI},
    [EUI.VendingMachineCansUI] = {VendingMachineCansUI},
    [EUI.RewardPreviewShowUI] = {RewardPreviewShowUI},
    [EUI.EquipFragExchangeUI] = {EquipFragExchangeUI},
	[EUI.HeroIllumstrationDetailUI] = {HeroIllumstrationDetailUI},
    [EUI.SelectRoleUi] = {SelectRoleUi},
    [EUI.HeroIllumstrationMain] = {HeroIllumstrationMain},
    [EUI.ExchangeActivitySelectNumUi] = {ExchangeActivitySelectNumUi},
    [EUI.VIPGiftBagSelectNumUI] = {VIPGiftBagSelectNumUI},
    [EUI.EquipStarDownConfirmUI] = {EquipStarDownConfirmUI},
    [EUI.CommonActivitySuccUI] = {CommonActivitySuccUI},
    [EUI.DifficultSelect] = {DifficultSelect},
    [EUI.BattleRoleInfoUI] = {BattleRoleInfoUI},
    [EUI.ExchangeRedCrystalUI] = {ExchangeRedCrystalUI},
    [EUI.ShareUIActivity] = {ShareUIActivity},
    [EUI.HpExchange] = {HpExchange},
    [EUI.ScoreHeroUI] = {ScoreHeroUI},
    [EUI.HeroTrialUI] = {HeroTrialUI},
    [EUI.HeroTrialFormationUI] = {HeroTrialFormationUI},
    [EUI.HeroTrialLevelAwardUI] = {HeroTrialLevelAwardUI},
    [EUI.HeroTrialFightBoxUI] = {HeroTrialFightBoxUI},
    [EUI.HeroTrialSignBoxUI] = {HeroTrialSignBoxUI},
    [EUI.EquipStarDownResultUi] = {EquipStarDownResultUi},
    [EUI.GuardHeartMainUi] = {GuardHeartMainUi},
    [EUI.GuardHeartSelectRoleUi] = {GuardHeartSelectRoleUi},
    [EUI.ChatFightMainUI] = {ChatFightMainUI},
    [EUI.ChatFightSelectBuffUI] = {ChatFightSelectBuffUI},
    [EUI.ChatFightSelectHeroUI] = {ChatFightSelectHeroUI},
    [EUI.ChatFightRequestUI] = {ChatFightRequestUI},
    [EUI.ChatFightAwardUI] = {ChatFightAwardUI},
    [EUI.GoldenEggUI] = {GoldenEggUI},
    [EUI.MaskMain] = {MaskMain},
    [EUI.MaskMainInfo] = {MaskMainInfo},
    [EUI.MaskRarityUpWnd] = {MaskRarityUpWnd},
    [EUI.MaskStarUpWnd] = {MaskStarUpWnd},
}

function UiManager:InitData()
    self.ui_stack = {};
    self.scene_list = {};
    self.have_destroy = false; 
    self.curBackAudioId = 81000003;

    -- 把没有在ui_stack中的ui，放入global_uis中，在场景切换的时候统一销毁这些全局ui
    self.global_uis = {};
end

function UiManager:createUI(id, param)
    local new_info = uiInformation[id];
--    app.log("show UI:"..id)
    if self.scene_list[id] == nil then
        self.scene_list[id] = {};
        if self.ClassList[id] == nil  then
            app.log("UiManager:createUI id="..tostring(id))
        end
        if  self.ClassList[id][1] == nil then
            app.log("UiManager:createUI2 id="..tostring(id))
        end
        self.scene_list[id].scene = self.ClassList[id][1]:new(param);
    else
        if self.scene_list[id].scene then
            if self.scene_list[id].scene.Restart and not self.scene_list[id].scene.ui then
                self.scene_list[id].scene:Restart(param);
            else
                self.scene_list[id].scene:Show();
                -- self.scene_list[id].scene:MsgRegist();
                self.scene_list[id].scene:UpdateUi();
            end
        else
            app.log("#lhf#self.scene_list["..id.."].scene is nil. info:"..table.tostring(self.scene_list[id])..debug.traceback());
        end
    end
    self.scene_list[id].isShow = true;
    return self.scene_list[id],new_info;
end

function UiManager:Init()
    --app.log("UiManager Init=====================")
    self:InitData();
end

function UiManager:RemoveUi(push_uid)
    if self.ui_stack[#self.ui_stack] == push_uid then
        self:PopUi()
        return;
    end
    for index, uid in ipairs(self.ui_stack) do
        if uid == push_uid then
            local ui = self.scene_list[push_uid];
            if ui then
                ui.scene:DestroyUi(true);
            end
            self.scene_list[push_uid] = nil;
            table.remove(self.ui_stack, index);

            NoticeManager.Notice(ENUM.NoticeType.PopUi, push_uid)
            return
        end
    end
end

--[[
is_destroy 上级界面是否销毁，默认为true销毁
]]
function UiManager:PushUi(scene_id,param)
    local cur_scene_id = nil;
    if #self.ui_stack ~= 0 then
        cur_scene_id = self.ui_stack[#self.ui_stack];
    end
    --[[push相同ui时，栈顶与push的id相同时，直接跳过]]
    if cur_scene_id == scene_id then
        return self.scene_list[scene_id].scene;
    end
    self.ui_stack[#self.ui_stack+1] = scene_id;
--    app.log("PushUi "..tostring(scene_id));
    
    --如果管理器已经销毁，则只进行栈操作，不显示ui
    if self.have_destroy == true then
        --if cur_scene_id and self.scene_list[cur_scene_id] and self.scene_list[cur_scene_id].scene and self.scene_list[cur_scene_id].scene.ui == nil then
        if cur_scene_id and self.scene_list[cur_scene_id] and self.scene_list[cur_scene_id].scene then
            self:_HideLastUi(scene_id,true);
        end
        self.ClassList[scene_id].temp_param = param
        return;
    end
    --如果当前ui是主界面  push界面不是主界面  那么需要记录切换界面时间
    if cur_scene_id == EUI.MMOMainUI and scene_id ~= EUI.MMOMainUI then
        if GetMainUI() and GetMainUI().SetLeaveTime then
            GetMainUI():SetLeaveTime();
        end
    end

    --隐藏tips
    SkillTips.EnableSkillTips(false);
    GoodsTips.EnableGoodsTips(false);
    if GetMainUI() and GetMainUI():GetSkillInput() then
        GetMainUI():GetSkillInput():CancelSkillEffect();
    end

    local new_info = uiInformation[scene_id];
    -- 当上级要显示时，查找最近的一个navbarState配置情况
    if new_info.showLast then
        for i=#self.ui_stack-1,1,-1 do
            local id = self.ui_stack[i];
            new_info = uiInformation[id];
            new_scene = self.scene_list[id];
            if not new_info.showLast then
                break;
            end
        end
    end
    self:_HideLastUi(scene_id,false);
    -- self:SetNavbarState(new_info,nil,nil,false);
    if new_info.background then
        -- 如果有背景，则等背景加载完后，再隐藏上级界面
        self:SetNavbarState(new_info, nil, function ()
            -- 隐藏上级界面
            for k,id in pairs(self.ui_stack) do
                local scene_info = self.scene_list[id];
                if scene_info and scene_info.scene and not scene_info.isShow and scene_info.scene:IsShow() then
                    scene_info.scene:Hide();
                end
            end
        end)
    end


    -- 显示当前界面
    app.log("param==========="..tostring(param).." scene_id============="..tostring(scene_id))
    param = param or self.ClassList[scene_id][2];
    local new_scene = self:createUI(scene_id, param);
    local cur_scene = new_scene;

    NoticeManager.Notice(ENUM.NoticeType.PushUi, scene_id, new_scene)

    cur_scene.scene:SetLoadedCallback(
        function ()
            self:ChangeBackAudio(scene_id)
            GNoticeGuideTipUiUpdate(scene_id);
            if not new_info.background then
                self:SetNavbarState(new_info)
                for k,id in pairs(self.ui_stack) do
                    local scene_info = self.scene_list[id];
                    if scene_info and scene_info.scene and not scene_info.isShow and scene_info.scene:IsShow() then
                        scene_info.scene:Hide();
                    end
                end
            end
        end
    );

    PublicFunc.msg_dispatch(UiManager.PushUi, scene_id)

    return self.scene_list[scene_id].scene
end

function UiManager:PopUi(param, bOnlyStack)
    if self.isPoping then
        return ;
    end
    --隐藏tips
    SkillTips.EnableSkillTips(false);
    GoodsTips.EnableGoodsTips(false);
    if #self.ui_stack <= 1 then

    else
        local cur_scene_id = self.ui_stack[#self.ui_stack];
         app.log("PopUi ui:"..tostring(cur_scene_id));
        -- self.scene_list[cur_scene_id].isDestroy = true;
        self.ui_stack[#self.ui_stack] = nil;

        -- 显示后面的界面
        local scene_id = self.ui_stack[#self.ui_stack];
        local new_scene,new_info;
        for i=#self.ui_stack,1,-1 do
            local id = self.ui_stack[i];
            local cf = uiInformation[id];
            local scene_info = self.scene_list[id];
            if scene_info then
                if bOnlyStack then
                    scene_info.isShow = true;
                else
                    if scene_id == id then
                        new_scene,new_info = self:createUI(id,param);
                    else
                        new_scene,new_info = self:createUI(id);
                    end
                end
                if not cf.showLast then
                    break;
                end
            else
                break;
            end
        end
        if not bOnlyStack then
            self.isPoping = true;
            -- self:SetNavbarState(new_info, new_scene.scene,nil,false);
            if new_info.background then
                self:SetNavbarState(new_info, new_scene.scene,function ()
                    local cur_scene_info = self.scene_list[cur_scene_id];
                    self.isPoping = false;
                    if cur_scene_info then
                        if not bOnlyStack then
                            if cur_scene_info.scene then
                                -- 销毁当前界面
                                cur_scene_info.scene:DestroyUi(true);
                            else
                                app.log("#lhf#cur_scene_id:"..tostring(cur_scene_id).." info:"..table.tostring(cur_scene_info)..debug.traceback());
                            end
                        end
                    end
                end)
            end
            new_scene.scene:SetLoadedCallback(
                function ()
                    self:ChangeBackAudio(scene_id)
                    if not new_info.background then
                        self.isPoping = false;
                        self:SetNavbarState(new_info, new_scene.scene)
                        local cur_scene_info = self.scene_list[cur_scene_id];
                        if cur_scene_info then
                            if not bOnlyStack then
                                if cur_scene_info.scene then
                                    -- 销毁当前界面
                                    cur_scene_info.scene:DestroyUi(true);
                                else
                                    app.log("#lhf#cur_scene_id:"..tostring(cur_scene_id).." info:"..table.tostring(cur_scene_info)..debug.traceback());
                                end
                            end
                        end
                    end
                    GNoticeGuideTipUiUpdate(scene_id);
                end
                );
        end

        -- if GuideManager.IsGuideRuning() then
        --     GuideManager.CheckWaitFunc( "pop_ui", cur_scene_id )
        -- end
        NoticeManager.Notice(ENUM.NoticeType.PopUi, cur_scene_id)
        PublicFunc.msg_dispatch(UiManager.PopUi,self.ui_stack[#self.ui_stack]);

        -- 通知一下主界面显示
        if #self.ui_stack == 1 and self.ui_stack[1] == EUI.MMOMainUI then
            NoticeManager.Notice(ENUM.NoticeType.PushUi, EUI.MMOMainUI, new_scene)
        end
    end
end

--增加UI栈计数
function UiManager:PushUIStack(scene_id)
    self.ui_stack[#self.ui_stack+1] = scene_id
end

function UiManager:PopUIStack()
    self.ui_stack[#self.ui_stack] = nil;
end

function UiManager:GetUICount()
    return #self.ui_stack
end

function UiManager:ReplaceUi(scene_id,param)
    local cur_scene_id = nil;
    if #self.ui_stack ~= 0 then
        cur_scene_id = self.ui_stack[#self.ui_stack];
    else
        self:PushUi(scene_id,param);
        return;
    end
    self.ui_stack[#self.ui_stack] = scene_id;
    app.log("ReplaceUi "..tostring(cur_scene_id).." to "..tostring(scene_id));
    -- 销毁当前界面
    local cur_scene_info = self.scene_list[cur_scene_id];
    if cur_scene_info then
        cur_scene_info.scene:DestroyUi(true);
        cur_scene_info.isShow = false;
    end

    -- 显示后面的界面
    local new_scene,new_info;
    local cur_scene;
    -- for i=#self.ui_stack,1,-1 do
    --     local id = self.ui_stack[i];
    --     local cf = uiInformation[id];
    --     if scene_id == id then
    --         new_scene,new_info = self:createUI(id,param);
    --         cur_scene = new_scene;
    --     else
    --         new_scene,new_info = self:createUI(id);
    --     end
    --     local scene_info = self.scene_list[id];
    --     if scene_info then
    --         if not cf.showLast then
    --             break;
    --         end
    --     else
    --         break;
    --     end
    -- end

    local needShowIndex = {}
    local stackCount = #self.ui_stack
    for i=stackCount,1,-1 do
        local id = self.ui_stack[i];
        local cf = uiInformation[id];
        table.insert(needShowIndex, i)
        if not cf.showLast then
            break
        end
    end
    local needShowCount = #needShowIndex
    for i = needShowCount,1,-1 do
        local id = self.ui_stack[needShowIndex[i]];
        --app.log("repalceui " .. tostring(id))
        if scene_id == id then
            new_scene,new_info = self:createUI(id,param);
            cur_scene = new_scene;
        else
            new_scene,new_info = self:createUI(id);
        end
    end


    -- self:SetNavbarState(new_info, new_scene.scene,nil,false)
    cur_scene.scene:SetLoadedCallback(
        function ()
            self:ChangeBackAudio(scene_id)
            self:SetNavbarState(new_info, new_scene.scene)
            GNoticeGuideTipUiUpdate(scene_id);
            if not uiInformation[scene_id].showLast then
                for i=#self.ui_stack-1,1,-1 do
                    local id = self.ui_stack[i];
                    local scene_info = self.scene_list[id];
                    if scene_info and scene_info.scene and scene_info.scene:IsShow() then
                        scene_info.scene:Hide();
                        scene_info.isShow = false;
                    end
                end
            end
        end
    );
    return self.scene_list[scene_id].scene
    -- self:SetNavbarState(new_info, new_scene.scene)
end

function UiManager:ClearStack()
    local cur_scene_id = self.ui_stack[#self.ui_stack];
    if cur_scene_id == self.ui_stack[1] then
        self.ui_stack = {};
        self.ui_stack[1] = cur_scene_id;
    else
        local main_scene_id = self.ui_stack[1];
        self.ui_stack = {};
        self.ui_stack[1] = main_scene_id;
        self.ui_stack[2] = cur_scene_id;
    end

    for k,v in pairs(self.scene_list) do
        if k ~= self.ui_stack[1]
            and k ~= self.ui_stack[2]
            and k ~= EUI.NavigationBar
        then
            v.scene:DestroyUi(true);
            v.isShow = false
        end
    end
end

function UiManager:SetStackSize(size)
    self.isPoping = nil
    
    --隐藏tips
    SkillTips.EnableSkillTips(false);
    GoodsTips.EnableGoodsTips(false);
    CommonAward.Destroy();
    CommonAwardVip.Destroy();
    CommonRaids.Destroy();
    MysteryShopPopupUI.Destroy();

    if size < 1 or self:GetUICount() <= size then
        return
    end

    local oldStatck = self.ui_stack
    self.ui_stack = {}

    for i = 1, size do
        self.ui_stack[i] = oldStatck[i]
    end

    for k,v in pairs(self.scene_list) do
        local destroy = true
        for uik,uiv in pairs(self.ui_stack) do
            if k == uiv then
                destroy = false;
                break;
            end
        end

        if v.scene then
            if destroy == true and k ~= EUI.NavigationBar then
                v.scene:Hide()
                v.scene:DestroyUi(true)
                self.scene_list[k] = nil
            end
        else
            app.log("#lhf#k:"..tostring(k).." v:"..table.tostring(v).." "..debug.traceback());
        end

    end

    local sceneid = self.ui_stack[#self.ui_stack]
    local new_scene,new_info = self:createUI(sceneid);
    if new_info.showLast then
        for i=#self.ui_stack-1,1,-1 do
            local id = self.ui_stack[i];
            new_info = uiInformation[id];
            new_scene = self.scene_list[id];
            if not new_info.showLast then
                break;
            end
        end
    end

    self:SetNavbarState(new_info, new_scene.scene)
    if size == 1 then
        NoticeManager.Notice(ENUM.NoticeType.PushUi, EUI.MMOMainUI, new_scene)
    end
    PublicFunc.msg_dispatch(UiManager.SetStackSize,self.ui_stack[#self.ui_stack]);
end

function UiManager:GetNavLayerCnt()
    local count = 0
    for i, v in ipairs(self.ui_stack) do
        if not uiInformation[v].showLast then
            count = count + 1
        end
    end
    return count
end

function UiManager:SetNavbarState(scene_info, new_scene, tex_callback, set_BG)
    -- if new_scene == nil then
    --     return;
    -- end
    local callback = tex_callback;
    -- if tex_callback then
    --     local function delay()
    --         Utility.CallFunc(tex_callback);
    --     end
    --     callback = function ()
    --         timer.create(Utility.create_callback(delay),100,1);
    --     end
    -- end

    if self.scene_list[EUI.NavigationBar] ~= nil and self.scene_list[EUI.NavigationBar].scene ~= nil then
        self.scene_list[EUI.NavigationBar].scene:UpdateInfo(scene_info, new_scene, callback, set_BG);
    end
end

function UiManager:DestroyAll(delete_all)
    for k,v in pairs(self.scene_list) do
        if v.scene then
            v.scene:Hide();
            if v.scene.DestroyUi then
                -- local dont_destroy = true

                -- if v.scene.pathRes then
                --    dont_destroy =  ResourceManager.is_reserved_res(v.scene.pathRes)
                -- end
    --            app.log("UiManager:DestroyAll:"..tostring(v.scene.pathRes).."dont_destroy:"..tostring(dont_destroy).." id:"..tostring(k))
    --            if not dont_destroy then
                    v.scene:DestroyUi(false);
                    if delete_all then
                        self.scene_list[k] = nil;
                    end

    --            else
    --                 v.scene:Hide()
    --            end
            end
        else
            app.log("#lhf#k:"..tostring(k).." v:"..table.tostring(v)..debug.traceback());
        end
    end
    if self.sureBigDlg then
        self.sureBigDlg:DestroyUi();
        self.sureBigDlg = nil;
    end
    if self.cardLook then
        self.cardLook:DestroyUi();
        self.cardLook = nil;
    end
    if self.bigcard then
        self.bigcard:DestroyUi();
        self.bigcard = nil;
    end
    if self.alertDlg then
        self.alertDlg:DestroyUi();
        self.alertDlg = nil;
    end
    self.have_destroy = true;

    if self.global_uis then
        for k,v in pairs(self.global_uis) do
            k:DestroyUi()
        end
        self.global_uis = {}
    end
    self.curBackAudioId = nil;
    AudioManager.Stop(nil,true)
end

function UiManager:Restart()
    if #self.ui_stack == 0 then
        return
    end
    app.log("UiManager:Restart");
    self.have_destroy = false;
    local _loadingId = GLoading.Show(GLoading.EType.loading);

    if self.scene_list[EUI.NavigationBar].scene == nil then
        app.log("new navi bar...")
        self.scene_list[EUI.NavigationBar].scene = NavbarUI:new();
    else
        self.scene_list[EUI.NavigationBar].scene:Restart();
        app.log("navi bar restart...")
    end

    local scene_id = self.ui_stack[#self.ui_stack];
    local new_scene,new_info;
    local num = 0;
    local loadList = {};
    for i=#self.ui_stack ,1,-1 do
        local v = self.ui_stack[i]
        if self.scene_list[v] == nil or self.scene_list[v].isShow then
            new_scene,new_info = self:createUI(v,self.ClassList[v].temp_param or self.ClassList[v][2]);
            num = num + 1;
            loadList[#loadList+1] = new_scene.scene;
            self.ClassList[v].temp_param = nil
            --new_scene.scene:Show();
        end
    end
    self:SetNavbarState(new_info, new_scene.scene, nil, false)
    local function loadOkCallback()
        self:ChangeBackAudio(scene_id)
        num = num - 1;
        if num == 0 then
           self:SetNavbarState(new_info, new_scene.scene)
	       GNoticeGuideTipUiUpdate(scene_id);
           GLoading.Hide(GLoading.EType.loading, _loadingId);
        end
    end
    for k,v in pairs(loadList) do
        v:SetLoadedCallback(loadOkCallback);
    end
    -- self:UpdateUi(scene_id);

    local top_eui = self.ui_stack[#self.ui_stack];
    NoticeManager.Notice(ENUM.NoticeType.UiManagerRestart, top_eui)
end

function UiManager:GetNavigationBarUi()
    if self.scene_list and self.scene_list[EUI.NavigationBar] and self.scene_list[EUI.NavigationBar].scene then
        return self.scene_list[EUI.NavigationBar].scene;
    else
        return nil;
    end
end

function UiManager:GetCurScene()
    local cur_scene_id = self.ui_stack[#self.ui_stack];
    if self.scene_list[cur_scene_id] then
        return self.scene_list[cur_scene_id].scene;
    end
end

function UiManager:UpdateCurScene(info_type)
    local scene = self:GetCurScene();
    if scene and scene.UpdateSceneInfo then
        scene:UpdateSceneInfo(info_type);
    end
end

function UiManager:Begin()

--    app.log("UiManager:Begin");

    --self.ui_root = asset_game_object.find("ui_2d");
    self.scene_list[EUI.NavigationBar] = {};
    self.scene_list[EUI.NavigationBar].scene = NavbarUI:new();
    self.scene_list[EUI.NavigationBar].isShow = true;
    self.have_destroy = false;
end

function UiManager:getSureBigDlg()
    if(self.sureBigDlg == nil) then
        self.sureBigDlg = SureBigDlgUI:new();
    end
    return self.sureBigDlg;
end

function UiManager:getCheckinDlg()
    if(self.checkinDlg == nil) then
        self.checkinDlg = CheckinDlgUI:new();
    end
    return self.checkinDlg;
end

--[[世界聊天]]
function UiManager:getTalkWordUI()
    if(self.talkWordUI == nil) then
        self.talkWordUI = TalkWordUI:new();
    end
    return self.talkWordUI;
end

--[[私聊]]
function UiManager:getTalkWhisper()
    if(self.talkWhisperUI == nil) then
        self.talkWhisperUI = TalkWhisperUI:new();
    end
    return self.talkWhisperUI;
end

function UiManager:FindUI(sceneID)
    if self.scene_list[sceneID] then
        return self.scene_list[sceneID].scene;
    else
        return nil;
    end
end

--[[ 传递消息数据到UiManager保存的UI对象
uiName      定义的UI命名
funcName    调用的函数名
--]]
function UiManager:UpdateMsgData(uiName, funcName, ...)
    local ui = self:FindUI( uiName );
    if ui and ui[ funcName ] and ui.ui then
        ui[ funcName ]( ui, ... );
    end
end

--[[ 传递消息数据到UiManager保存的UI对象(该对象资源释放了也发送)
uiName      定义的UI命名
funcName    调用的函数名
--]]
function UiManager:UpdateMsgDataEx(uiName, funcName, ...)
    local ui = self:FindUI( uiName );
    if ui and ui[ funcName ] then
        ui[ funcName ]( ui, ... );
    end
end
--设置美术字
--参数:   num：要显示的数字
--        parent:所有美术字体sprite的父节点
function UiManager:SetArtFont(num,parent)
    if(num == nil or parent == nil)then
        app.log("设置美术字：传入参数不对");
        return;
    end

    local weishu = #tostring(num);
    local digit = 1;          --代表位数，1为个位，2为十位，3为百位，以此类推
    for i=1,weishu do
        local ArtSprite = ngui.find_sprite(parent,"sp_"..digit);
        digit = digit + 1;
        if(nil ~= ArtSprite)then
            local spName = ArtSprite:get_sprite_name();
            local n = string.sub(tostring(num),weishu-i+1,weishu-i+1)   --n为num的个位，十位，百位数字
            spName = string.gsub(spName,string.match(spName,'[%d]*$'),n)    --将spName的最后的数字替换为n
            ArtSprite:set_sprite_name(spName);
        else
            app.log("找不到名为sp_"..(digit-1).."的图片");
        end
    end

    local nn = 1;
    while(true)do
        local ArtSprite = ngui.find_sprite(parent,"sp_"..weishu+nn);
        if(ArtSprite ~= nil)then
            local spName = ArtSprite:get_sprite_name();
            spName = string.gsub(spName,string.match(spName,'[%d]*$'),999);
            ArtSprite:set_sprite_name(spName);
            nn = nn + 1;
        else
            break;
        end
    end
end

function UiManager:Update(dt)
    local size = #self.ui_stack
    for i=size,1,-1 do
        local sceneid = self.ui_stack[i];
        local sceneInfo = self.scene_list[sceneid]
        if sceneInfo and sceneInfo.scene and sceneInfo.scene:IsShow() and sceneInfo.scene.Update then
            sceneInfo.scene:Update(dt)
        else
            break
        end
    end

    for ui, needUpdate in pairs(self.global_uis) do
        if needUpdate and ui:IsShow() then
            ui:Update(dt)
        end
    end
end

function UiManager:GetCurSceneID()
    local len = #self.ui_stack
    if len == 0 then
        return nil
    else
        return self.ui_stack[len];
    end
end

function UiManager:OnPanelLoadOK(name)
    --g_ScreenLockUI.Hide()
end

function UiManager:_HideLastUi(new_scene_id,is_logic)
    local new_cf = uiInformation[new_scene_id];
    -- local needHideList = {};
    if not new_cf.showLast then
        for i=#self.ui_stack-1,1,-1 do
            local id = self.ui_stack[i];
            local cf = uiInformation[id];
            local scene_info = self.scene_list[id];
            if scene_info then
                -- if not is_logic then
                    --同时push两个界面，上个界面还未创建好(scene == nil)
                    -- if scene_info.scene then
                        -- scene_info.scene:Hide();
                        -- 存储需要隐藏的界面，在新界面显示后，再隐藏
                        -- table.insert(needHideList, id);
                    -- end
                    -- scene_info.scene:MsgUnRegist();
                -- end
                scene_info.isShow = false;
                if not cf.showLast then
                    break;
                end
            else
                break;
            end
        end
    end
    -- return needHideList;
end

function UiManager:Hide()
    for k,v in pairs(self.scene_list) do
        v.scene:Hide();
    end
end

function UiManager:Show()
    local new_scene,new_info;
    for k,v in pairs(self.ui_stack) do
        if self.scene_list[v] == nil or self.scene_list[v].isShow then
            new_scene,new_info = self:createUI(v,self.ClassList[v][2]);
        end
    end
    self:SetNavbarState(new_info, new_scene.scene)

    self.scene_list[EUI.NavigationBar].scene:Show()
end

function UiManager:SetRuleId(uiId, ruleId)
    uiInformation[uiId].ruleId = ruleId;
end

function UiManager:AddGlobalUi(ui, needUpdate)
    self.global_uis[ui] = needUpdate
end

function UiManager:DelGlobalUi(ui)
    if self.global_uis[ui] then
        self.global_uis[ui] = nil
    end
end

function UiManager:ChangeBackAudio(cur_ui_id)
    if uiInformation[cur_ui_id].backAudioId ~= nil then
        if self.curBackAudioId == nil or self.curBackAudioId ~= uiInformation[cur_ui_id].backAudioId then
            AudioManager.Stop(ENUM.EAudioType._2d, false)
            AudioManager.Play2dAudioList({[1]={id=uiInformation[cur_ui_id].backAudioId, loop=-1}});
            self.curBackAudioId = uiInformation[cur_ui_id].backAudioId;
        end
    end
end

function UiManager:GetBackAudioId(ui_id)
    if uiInformation[cur_ui_id] and uiInformation[cur_ui_id].backAudioId then
        return uiInformation[cur_ui_id].backAudioId
    end
    return nil;
end

return uiManager;
