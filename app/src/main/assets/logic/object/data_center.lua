--script.run("logic/message/message_enum.lua")
--数据中心的单例对象
g_dataCenter = {};

--[[初始化]]
function g_dataCenter.init()
	g_dataCenter.fight_info = FightInfo:new()
	g_dataCenter.player = Player:new();--玩家模块<Player>
	g_dataCenter.package = Package:new();--背包模块<Pakcage>
	g_dataCenter.player:SetPackage(g_dataCenter.package)
	g_dataCenter.guild = Guild:new();--公会模块<GuildDetail>
	g_dataCenter.fuzion = Fuzion:new();-- 大乱斗模块
	g_dataCenter.fuzion2 = Fuzion2:new();-- (10人)大乱斗模块
	g_dataCenter.Institute = Institute:new(); --研究所模块
	g_dataCenter.CloneBattle = CloneBattle:new();
	g_dataCenter.trainning = trainning:new();
        g_dataCenter.ChurchBot = ChurchBot:new();
	g_dataCenter.time_flag = time_flag:new(); --计数器相关
        g_dataCenter.GuildFindLs = GuildFindLs:new();  --寻找LS
	g_dataCenter.store = Store:new(); --商城数据
	g_dataCenter.otherPlayers = OtherPlayers:new();-- 其他玩家数据模块<Player.Pakcage>，只要服务器发送了玩家信息，就需要存在这里
	g_dataCenter.mail = Mail:new();		--邮件模块<Mail>
	g_dataCenter.hurdle = Hurdle:new();-- 关卡模块<Hurdle>
	g_dataCenter.levelUpRewardData = LevelUpRewardData:new();--升级奖励数据
	g_dataCenter.cityBuildingData = CityBuildingData:new();
	g_dataCenter.activity = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan] = TongLinZhiHunDuiHuan:new();
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang] = JieLueWuZi:new();
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu] = ZhuangBeiKu:new();
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao] = JiaoTangQiDao:new();
	--g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiB] = GaoSuJuJi:new(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiB);
	--g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiA] = GaoSuJuJi:new(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiA);
	--g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiS] = GaoSuJuJi:new(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiS);
	--g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiSS] = GaoSuJuJi:new(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiSS);
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi] = GaoSuJuJiSimple:new();
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa] = KuiKuLiYa:new();
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree] = QingTongJiDi:new();
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_fuzion] = g_dataCenter.fuzion;
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_fuzion2] = g_dataCenter.fuzion2;
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena] = Arena:new();
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_SLG] = CityBuildingMgr.GetInst()
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan] = ClownPlan:new()
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_CloneFight] = g_dataCenter.CloneBattle    --克隆战
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_GraduateSchool] = g_dataCenter.Institute  --研究所
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_Trainning] = g_dataCenter.trainning   --训练场
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial] = HeroTrial:new()   --角色历练
    g_dataCenter.worldTreasureBox = WorldTreasureBox:new();
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox] = g_dataCenter.worldTreasureBox
	g_dataCenter.daily_task = DailyTask:new();    --日常活动
	g_dataCenter.task = MMOTask:new();    --任务系统
	g_dataCenter.chat = ChatData:new();--[[聊天]]
	g_dataCenter.chatFight = ChatFight:new();--[[聊天约战]]
	g_dataCenter.worldBoss = WorldBossData:new(); --世界boss数据
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_WorldBoss] = g_dataCenter.worldBoss;
	g_dataCenter.setting = SettingDataCenter:new();   --设置数据中心
	g_dataCenter.playMethodInfo = PlayMethodInfo:new();   --玩法信息数据中心
	g_dataCenter.activityReward = ActivityReward:new(); -- 运营活动奖励(登录奖励，闯关奖励)
	g_dataCenter.activityShare = ActivityShare:new();   --分享活动
	g_dataCenter.marquee = Marquee:new(); -- 跑马灯公告
	g_dataCenter.gmCheat = GmCheat:new();  -- 作弊
	g_dataCenter.egg = Egg:new();  --扭蛋
    g_dataCenter.shopInfo = ShopInfo:new();  -- 二级商店
    g_dataCenter.rankInfo = Rank:new();--排行榜
    g_dataCenter.autoPathFinding = AutoPathFinding:new();
    g_dataCenter.bossList = BossList:new(); --boss列表
    g_dataCenter.talentSystem = TalentSystem:new(); --天赋系统
    g_dataCenter.friend = Friend:new() --好友系统
    g_dataCenter.player_flag = {};
    g_dataCenter.signin = Signin:new();--七天乐活动
    g_dataCenter.invite = InviteInfo:new();--邀请
    g_dataCenter.guildBoss = GuildBossData:new();
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_GuildBoss] = g_dataCenter.guildBoss;
	g_dataCenter.trial = ExpeditionTrialData:new(); --远征试炼
	g_dataCenter.area = Area:new();
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_trial] = g_dataCenter.trial;
	g_dataCenter.levelActivity = LevelActivityData:new(); --活动关卡
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_LevelActivity] = g_dataCenter.levelActivity;
    g_dataCenter.guildWar = GuildWar:new();  --社团战
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_GuildWar] = g_dataCenter.guildWar;
    g_dataCenter.autoQualitySet = AutoQualitySet:new();
	g_dataCenter.guardHeart = GuardHeartData:new();
	g_dataCenter.maskitem = MaskItem:new();
end

--[[清除所有数据]]
function g_dataCenter.clear_all()
	delete(g_dataCenter.fight_info);
	delete(g_dataCenter.player);--玩家模块<Player>
	delete(g_dataCenter.package);--背包模块<Pakcage>
	delete(g_dataCenter.guild);--公会模块<GuildDetail>
	delete(g_dataCenter.fuzion);-- 大乱斗模块
	delete(g_dataCenter.fuzion2);-- (10人)大乱斗模块
	delete(g_dataCenter.otherPlayers);-- 其他玩家数据模块<Player.Pakcage>，只要服务器发送了玩家信息，就需要存在这里
	delete(g_dataCenter.mail);		--邮件模块<Mail>
	delete(g_dataCenter.hurdle);-- 关卡模块<Hurdle>
	delete(g_dataCenter.levelUpRewardData);--升级奖励数据
	delete(g_dataCenter.cityBuildingData);
	--delete(g_dataCenter.activity);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]);
--	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiB]);
--	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiA]);
--	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiS]);
--	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiSS]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial]);
	delete(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_trial]);
	delete(g_dataCenter.daily_task);--日常活动
	delete(g_dataCenter.task);--任务系统
	delete(g_dataCenter.chat);--[[聊天]]
	delete(g_dataCenter.chatFight);--[[聊天约战]]
	delete(g_dataCenter.worldBoss); --世界boss数据
	delete(g_dataCenter.setting); --设置数据中心
	delete(g_dataCenter.activityReward); -- 运营活动奖励(登录奖励，闯关奖励)
	delete(g_dataCenter.marquee); -- 跑马灯公告
	delete(g_dataCenter.gmCheat); -- 作弊
	delete(g_dataCenter.egg); -- 扭蛋
    delete(g_dataCenter.shopInfo); -- 二级商店
    delete(g_dataCenter.autoPathFinding);  --自动寻路
    delete(g_dataCenter.bossList);  --自动寻路
    delete(g_dataCenter.talentSystem); --天赋系统
    delete(g_dataCenter.time_flag); --计数器相关
    delete(g_dataCenter.store); --商城数据
    delete(g_dataCenter.Institute);-- ={}; --研究所模块
    delete(g_dataCenter.CloneBattle);
    delete(g_dataCenter.trainning);
    delete(g_dataCenter.ChurchBot);
    delete(g_dataCenter.GuildFindLs);
    delete(g_dataCenter.signin); -- 七天乐活动
    delete(g_dataCenter.invite); -- 邀请
    delete(g_dataCenter.guildWar); -- 社团战
    delete(g_dataCenter.levelActivity); --活动关卡
	g_dataCenter.fight_info = {};
	g_dataCenter.player = {};--玩家模块<Player>
	g_dataCenter.package = {};--背包模块<Pakcage>
	g_dataCenter.guild = {};--公会模块<GuildDetail>
	g_dataCenter.fuzion = {};-- 大乱斗模块
	g_dataCenter.fuzion2 = {};-- (10人)大乱斗模块
	g_dataCenter.otherPlayers = {};-- 其他玩家数据模块<Player.Pakcage>，只要服务器发送了玩家信息，就需要存在这里
	g_dataCenter.mail = {};		--邮件模块<Mail>
        g_dataCenter.GuildFindLs = {};
	g_dataCenter.hurdle = {};-- 关卡模块<Hurdle>
	g_dataCenter.levelUpRewardData = {};--升级奖励数据
	g_dataCenter.cityBuildingData = {};
	g_dataCenter.activity = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan] = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang] = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu] = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao] = {};
--	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiB] = {};
--	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiA] = {};
--	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiS] = {};
--	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiSS] = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi] = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa] = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree] = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena] = {};
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial] = {};
	g_dataCenter.daily_task = {};--日常活动
	g_dataCenter.task = {};--任务系统
	g_dataCenter.chat = {};--[[聊天]]
	g_dataCenter.chatFight = {};--[[聊天约战]]
	g_dataCenter.worldBoss = {}; --世界boss数据
	g_dataCenter.setting = {}; --设置数据中心
	g_dataCenter.activityReward = {}; -- 运营活动奖励(登录奖励，闯关奖励)
	g_dataCenter.marquee = {}; -- 跑马灯公告
	g_dataCenter.gmCheat = {}; -- 作弊
	g_dataCenter.egg = {}; -- 扭蛋
    g_dataCenter.shopInfo = {}; -- 二级商店
    g_dataCenter.rankInfo ={}
    g_dataCenter.autoPathFinding = {};
    g_dataCenter.bossList = {}
    g_dataCenter.talentSystem = {}
    g_dataCenter.guildWar = {}
    
    g_dataCenter.Institute = {};-- ={}; --研究所模块
    g_dataCenter.CloneBattle = {};
    g_dataCenter.trainning = {};
    g_dataCenter.ChurchBot = {};
    
	g_dataCenter.trial = {};
    -- 释放签到数据
    g_checkin.Destroy()

    g_dataCenter.player_flag = {};
    g_dataCenter.signin = {};
    g_dataCenter.invite = {}
    g_dataCenter.send_first_enter_game_complete = false
    delete(g_dataCenter.autoQualitySet);
	delete(g_dataCenter.guardHeart)
	g_dataCenter.guardHeart = nil
	delete(g_dataCenter.maskitem)
	g_dataCenter.maskitem = nil
end

--[[初始化]]
g_dataCenter.init();
dc = g_dataCenter
