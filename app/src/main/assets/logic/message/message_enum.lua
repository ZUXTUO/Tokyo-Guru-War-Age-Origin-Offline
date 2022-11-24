MsgEnum = {}
local ID_ERROR_CODE_START = 84206000
local function ID_ERROR_GEN()
	local curID = ID_ERROR_CODE_START;
	ID_ERROR_CODE_START = ID_ERROR_CODE_START + 1;
	return curID
end
MsgEnum.error_code =
{
	error_code_success = 0,
	error_code_fail = 84206000,						--随机概率失败
	error_code_repeat_player_name = 84206002,		--重复玩家名
	error_code_name_illegal = 84206003,				--含有非法字符
	error_code_not_find_player = 84206009,			--未找到玩家
	error_code_money_shortage = 84206013,			--金钱不足
	error_code_material_shortage = 84206015,		--材料不足
	error_code_level_low = 84206021,				--等级太低
	error_code_data = 84206029,						--数据错误
	error_code_player_displacement = 84206150,		--被挤下线
	error_code_3v3_exit_punish = 84206147,			--3v3退出惩罚
	error_code_3v3_match_punish = 84206310,			--3v3匹配惩罚
	error_code_max_level = 84206158,				--等级达到上限
	error_code_shop_item_sell_out = 84206214,		--物品已经售完
	error_code_forbid_chat = 84206223,				--禁言
	error_code_login_limit_today = 84206302,		--今日登录人数已达上限，明日再来
	error_code_hero_trial_enter_exception = 84206316,		--角色历练进入异常
}

MsgEnum.friend_msg_optype =
{
	--[[friend_op_send_bless = 0,			--给某个好友送祝福
	friend_op_send_ap = 1,				--送体力
	friend_op_get_bless = 2,			--获取某个队友送的祝福
	friend_op_get_ap = 3,				--获取体力
	friend_op_get_fight = 4,			--参战，这个客户端好友系统用不到，只是服务器用]]
	friend_op_del_friend = 0,
	friend_op_add_blacklist = 1,
	friend_op_remove_blacklist = 2,
	friend_op_add_friend_again = 3,
	friend_op_add_friend = 4,
	friend_op_accept = 5,
	friend_op_reject = 6,
};

MsgEnum.account_net_state =
{
	eAccountNetState_success = 0,				--返回成功
	eAccountNetState_failed = 1,				--密码错误
	eAccountNetState_noAccount = 2,				--账号不存在
	eAccountNetState_noGameServer = 3,			--当前没有游戏服
	eAccountNetState_registerRepeatName = 4,	--注册名字重复
	eAccountNetState_verificationFail = 5,      --验证失败
};

--杂项表枚举
MsgEnum.ediscrete_id =
{
	eDiscreteId_checkin7Freshtime = 83000000,			--七日签到刷新时间
	eDiscreteId_cityId = 83000001,						--主城模板对应表名
	eDiscreteId_checkinMonthLateCost = 83000002,		--月签到补签费用基数
	eDiscreteId_chechinMonthFreshtime = 83000003,		--月签到刷新时间
	eDiscreteId_hurdleToggle = 83000006,				--关卡页签
	eDiscreteId_fractionToAp = 83000007,				--刷体力分数对应体力（单位%）
	eDiscreteId_apMaxValue = 83000008,					--体力最大值
	eDiscreteId_playerMaxLevel = 83000009,				--玩家最大等级
	eDiscreteId_leadAperture = 83000010,				--当前主角光圈id
	eDiscreteId_attckAperture = 83000011,				--被主角普通攻击光圈特效id
	eDiscreteId_deadEffect1 = 83000012,					--死亡特效1
	eDiscreteId_deadEffect2 = 83000013,					--死亡特效1
	eDiscreteId_neidanMaxLevel = 83000014,				--内丹最大等级
	eDiscreteId_breakthroughMaxLevel = 83000015,		--突破最大等级
	eDiscreteId_breakthroughRule = 83000016,			--突破规则描述
	eDiscreteId_upgradeStarMaxLevel = 83000017,			--升星最大等级
	eDiscreteId_fettersOpenCondition = 83000018,		--无用
	eDiscreteId_equipCompositeCount = 83000019,			--装备合成需要个数
	eDiscreteId_racialsOpenStar = 83000020,				--种族技能开启星级
	eDiscreteId_changeTargetRadius = 83000021,			--切换目标可视范围的半径
	eDiscreteId_createGiveGold = 83000022,				--创建角色给予金币
	eDiscreteId_restrainAllReset = 83000023,			--属性克制全部重置折扣
	eDiscreteId_decomposeHero4 = 83000024,				--分解4星英雄对应通灵之魂
	eDiscreteId_decomposeHero5 = 83000025,				--分解5星英雄对应通灵之魂
	eDiscreteId_updateFriendshipInterval = 83000026,          -- 好友系统友情值刷新间隔
	eDiscreteId_perMinuteFriendshipValue = 83000027,         -- 每分钟产出友情值
	eDiscreteId_maxFriendshipValueOfFriend = 83000028,      -- 好友存储友情值上限
	eDiscreteId_addFriendListRefreshTime = 83000029,          -- 添加好友中备选列表刷新时间----小时
	eDiscreteId_inviteFriendGetCrystalNumber = 83000030,         -- 邀请好友成功后可获得奖励钻石数量
	eDiscreteId_friendShopRefreshTime = 83000031,      -- 神秘商店物品列表刷新时间---小时
	eDiscreteId_arenaPromoteData = 83000032,			--竞技场组别晋级规则（已废弃，具体参考arena_step配置表）
	eDiscreteId_maxBuyPowerCount = 83000033,			--基本的每日最大可购买体力次数
	eDiscreteId_guildEnableLevel = 83000034,			--开启公会所需玩家等级
	eDiscreteId_guildCreateCost = 83000035,				--创建一个公会消耗
	eDiscreteId_guildChangeNameCost = 83000036,			--公会改名消耗
	eDiscreteId_guildDissolveTime = 83000037,			--退出公会的冻结时间（小时）
	eDiscreteId_dlgAudioIntervalTime = 83000043,			--技能配音播放间隔时间（秒）
	eDiscreteId_relaxAudioIntervalTime = 83000044,			--休闲语音播放间隔时间（秒）
	eDiscreteId_oneBuyApCost = 83000045,				--一次购买体力消耗
	eDiscreteId_buyApCount = 83000046,					--体力购买基础次数
	eDiscreteId_apMax = 83000047,						--体力最大值
	eDiscreteId_marqueeMoveSpeed = 83000048,			--跑马灯移动速度
	eDiscreteId_guildActivityTodoNumber = 83000049,		--公会活动显示敬请期待的数量


	eDiscreteId_fuzionDayAwardCount = 83000058,		--大乱斗每日有奖励场次数
	eDiscreteId_timeAuto = 83000059,                    --一定时间后自动战斗

	eDiscreteId_arenaCdInterval = 83000061,                 --竞技场挑战冷却时间（秒）

	eDiscreteId_guideSkillFlag = 83000067,               --引导技能开启的标记id
	eDiscreteId_guideTaskId = 83000068,                  --需要引导的任务id
	eDiscreteId_exp_buy_top = 83000070,                  --经验药水一次购买上限
	eDiscreteId_reset_talent_gold_fate = 83000005,       --重置天赋返还金币百分比
	eDiscreteId_eqip_star_down_cost = 83000076,             --装备降星消耗
	eDiscreteId_equip_levelup_exp_cost_gold = 83000077,     --特殊装备升级经验消耗金币（1：x）
	eDiscreteId_spec_equip_box_show_item = 83000079,          --装备宝箱道具掉落显示用
	eDiscreteID_equip_max_level	= 83000080,             --装备最大等级
	eDiscreteID_equip_max_rarity= 83000081,             --装备最大品质
	eDiscreteID_skill_max_level = 83000083,             --最大技能等级
	eDiscreteID_mystery_shop_duration_time = 83000086,  --神秘商店持续时间
	eDiscreteID_get_friend_ap_times_each_day = 83000088,--每日可领取好友赠送体力次数
	eDiscreteID_get_friend_ap_each_time = 83000089,	--每次领取好友赠送体力点数

	eDiscreteID_talent_point_show_red_point = 83000092, --金币及天赋点分别达到xx时，天赋显示小红点
	eDiscreteID_talent_gold_show_red_point = 83000147,  --金币及天赋点分别达到xx时，天赋显示小红点

	eDiscreteID_guild_donate_gold = 83000093,--'社团金币捐献花费
	eDiscreteID_guild_donate_gold_add_exp = 83000094,--'社团金币捐献社团经验增加
	eDiscreteID_guild_donate_gold_add_gongxian = 83000095,--'社团金币捐献社团贡献增加
	eDiscreteID_guild_donate_jewel = 83000096,--'社团钻石捐献花费
	eDiscreteID_guild_donate_jewel_add_exp = 83000097,--'社团钻石捐献社团经验增加
	eDiscreteID_guild_donate_jewel_add_gongxian = 83000098,--'社团钻石捐献社团贡献增加
	eDiscreteID_guild_donate_day_times = 83000099,--'社团每日捐献次数

	eDiscreteID_guide_first_egg_hero_id = 83000100,--新手引导扭蛋客户端假表现-金木研

	eDiscreteID_breakthrough_scale = 83000107,		--突破界限使用的相关内容

	eDiscreteID_gold_niudan_fix_reward = 83000108,	--单次金币扭蛋固定奖励（10连乘10）
	eDiscreteID_crystal_niudan_fix_reward = 83000109,	--单次钻石扭蛋固定奖励（10连乘10）

	eDiscreteID_equip_level_up_helmet_unlock_player_level = 83000110,		--装备升级帽子解锁战队等级
	eDiscreteID_equip_level_up_accessories_unlock_player_level = 83000111,	--装备升级饰品解锁战队等级

	eDiscreteID_equip_star_up_helmet_unlock_player_level = 83000115,		--装备升星帽子解锁战队等级
	eDiscreteID_equip_star_up_accessories_unlock_player_level = 83000116,	--装备升星饰品解锁战队等级
	eDiscreteID_equip_star_up_unlock_player_level = 83000117,	--装备升星解锁战队等级
	eDiscreteID_normalHurdleFirstId = 83000121,					--普通关卡第一个关卡号
	eDiscreteID_eliteHurdleFirstId = 83000122,					--精英关卡第一个关卡号

	eDiscreteID_bossAlarmId = 83000126,					--boss出场警报id

	eDiscreteID_baoWeiCanChangMaxFraction = 83000134,					--高速狙击最大分数
	eDiscreteID_hurdleAutoFightOpenHurdleId = 83000140,					--关卡自动战斗开启条件关卡id
	eDiscreteID_hurdleSaodangThreeOpen = 83000141,						--关卡扫荡3次开启等级
	eDiscreteID_hurdleSaodangTenOpen = 83000142,						--关卡扫荡10次开启等级
	eDiscreteID_attackSkateFactor = 83000148,			--攻击滑动距离判断系数
	eDiscreteID_normalSkillResetTime = 83000149,
	eDiscreteID_normalSkillAddViewRadius = 83000150,	--普攻视野额外值

	eDiscreteID_guide_get_hero_hurdle_id = 83000152,  --首次直接给角色的关卡号（同下条对应）
	eDiscreteID_guide_hurdle_get_hero_id = 83000153,  --首次直接获得角色-笛口雏实（同上条对应）
	eDiscreteID_arena_win_drop_id = 83000157,  --竞技场胜利奖励dropsomething中ID
	eDiscreteID_arena_lose_drop_id = 83000158,  --竞技场失败奖励dropsomething中ID
	eDiscreteID_hurdleSaodangFiftyOpen = 83000159,						--关卡扫荡50次开启等级
	eDiscreteID_task_yijian_openLevel = 83000160,						--任务一键领取开启等级

	eDiscreteID_role_key_level_up_open_level = 83000163,				--角色一键升级开启等级
	eDiscreteID_equip_quick_level_up_open_level = 83000164,				--特殊装备快速升级开启等级
	eDiscreteID_max_ap_save = 83000165,				--体力存储上限

	eDiscreteID_raidsTenShow = 83000166,				--显示扫荡10次按钮所需等级
	eDiscreteID_raidsThreeShow = 83000167,				--显示扫荡3次按钮所需等级
	eDiscreteID_chat_open_level = 83000168,				--聊天开启等级
	eDiscreteID_get_ap_task = 83000169,				--体力补领需要的钻石
	eDiscreteID_line_task = 83000170,				--主线任务一键领取开启等级
	eDiscreteID_daily_task_open = 83000171,				--日常任务开启等级


	eDiscreteID_hurdleNormalRaids1BtnShowLevel = 83000172,			--普通关卡扫荡1次按钮显示等级
	eDiscreteID_hurdleNormalRaids10BtnShowLevel = 83000173,			--普通关卡扫荡10次按钮显示等级
	eDiscreteID_hurdleNormalRaids50BtnShowLevel = 83000174,			--普通关卡扫荡50次按钮显示等级
	eDiscreteID_hurdleEliteRaids1BtnShowLevel = 83000175,			--精英关卡扫荡1次按钮显示等级
	eDiscreteID_hurdleEliteRaids3BtnShowLevel = 83000176,			--精英关卡扫荡3次按钮显示等级
	eDiscreteID_hurdleNormalNo3StarRaidsVip = 83000177,		        --普通关卡未满3星可扫荡vip等级
	eDiscreteID_hurdleNormalNo3StarRaidsLevel = 83000178,			--普通关卡未满3星可扫荡战队等级
	eDiscreteID_hurdleEliteNo3StarRaidsVip = 83000179,		        --精英关卡未满3星可扫荡vip等级
	eDiscreteID_hurdleEliteNo3StarRaidsLevel = 83000180,			--精英关卡未满3星可扫荡战队等级
	eDiscreteID_hurdleNormalRaids1Vip = 83000181,		            --普通关卡可执行扫荡1次vip等级
	eDiscreteID_hurdleNormalRaids1Level = 83000182,		            --普通关卡可执行扫荡1次战队等级
	eDiscreteID_hurdleNormalRaids10Vip = 83000183,		            --普通关卡可执行扫荡10次vip等级
	eDiscreteID_hurdleNormalRaids10Level = 83000184,		        --普通关卡可执行扫荡10次战队等级
	eDiscreteID_hurdleNormalRaids50Vip = 83000185,		            --普通关卡可执行扫荡50次vip等级
	eDiscreteID_hurdleNormalRaids50Level = 83000186,		        --普通关卡可执行扫荡50次战队等级
	eDiscreteID_hurdleEliteRaids1Vip = 83000187,		            --精英关卡可执行扫荡1次vip等级
	eDiscreteID_hurdleEliteRaids1Level = 83000188,		            --精英关卡可执行扫荡1次战队等级
	eDiscreteID_hurdleEliteRaids3Vip = 83000189,		            --精英关卡可执行扫荡3次vip等级
	eDiscreteID_hurdleEliteRaids3Level = 83000190,		            --精英关卡可执行扫荡3次战队等级
	eDiscreteID_attackSkateFactorExcept = 83000194,			        --攻击滑动距离判断系数(不能击退的目标)

	eDiscreteID_vip_up_item = 83000198,								--vip升级需要的道具和每个首个的经验值
	eDiscreteID_vip_store_big_title = 83000199,						--充值广告大标题
	eDiscreteID_vip_store_title_info = 83000200,						--充值广告小说明
	eDiscreteID_1v1_request_count = 83000201,						--1v1被挑战人数上限
	eDiscreteID_1v1_my_request_count = 83000202,					--1v1主动挑战人数上限
	eDiscreteID_shop_show_vip_add = 83000203,						--vip商店可查看vip等级+n
	eDiscreteID_golden_egg_ticket_yuan = 83000206,					--砸金蛋1张券多少钱
	eDiscreteID_monsterGuideDiff = 83000210,						--怪物指示功能显示的距离
	eDiscreteID_monsterGuideCount = 83000211,						--怪物指示功能显示的小怪数量
};
--活动id配置
MsgEnum.eactivity_time =
{
	eActivityTime_MainCity = 60053000,	--主城
	eActivityTime_GuildWar = 60053001,	--社团战

	eActivityTime_tongLinZhiHunDuiHuan = 60054000,	--通灵之魂兑换
	eActivityTime_baoWeiCanChang = 60054001,		--保卫喰场
	eActivityTime_zhuangBeiKu = 60054002,			--装备库
	eActivityTime_levelUpRewardId = 60054003,		--升级奖励已经领取的最大等级
	eActivityTime_checkin7 = 60054004,				--7日签到
	eActivityTime_checkinMonth = 60054005,			--30日签到
	eActivityTime_gaoSuJuJi = 60054006,             --高速狙击
	eActivityTime_kuiKuLiYa = 60054010,				--奎库利亚
	eActivityTime_JiaoTangQiDao = 60054011,			--教堂祈祷
	eActivityTime_equipComposite = 60054012,		--装备合成
	eActivityTime_arena = 60054014,		            --竞技场
	eActivityTime_SLG = 60054015,                   --SLG
	eActivityTime_WorldBoss = 60054016,             --世界BOSS
	eActivityTime_GuildBoss = 60054017,				--社团BOSS
	eActivityTime_hurdleReward = 60054018,          --闯关奖励
	eActivityTime_loginReward = 60054019,           --登录奖励
	eActivityTime_fuzion = 60054020,          		--大乱斗
	eActivityTime_threeToThree = 60054021,			--3v3玩法
	eActivityTime_apBuyTimes = 60054022,			--购买体力次数
	eActivityTime_ClownPlan = 60054023,				--小丑计划
	eActivityTime_WorldTreasureBox = 60054024,		--世界宝箱
	eActivityTime_BossList = 60054025,              --boss列表
	eActivityTime_everydayRecharge = 60054026,		--每日充值
	eActivityTime_fuzion2 = 60054027,          		--(10人)大乱斗
	eActivityTime_CloneFight = 60054028,          	--克隆站
	eActivityTime_heroTrial = 60054029,             --角色历练
	eActivityTime_trial = 60054030,					--远征试炼
	eActivityTime_LevelActivity = 60054031,			--活动关卡
	eActivityTime_guide = 60054990,                 --新手引导
	eActivityTime_pvptest = 60054999,               --pvp测试
	eActivityTime_openWorld = 60055000,				--MMO地图
	eActivityTime_exchangeGold = 60055001,          --兑换金币
	--主界面
	eActivityTime_Adventure = 62000000,             --冒险
	eActivityTime_Playing = 62000001,               --玩法
	eActivityTime_Fight = 62000002,                 --对战
	eActivityTime_Battle = 62000003,				--战队
	eActivityTime_Hero = 62000004,                  --英雄
	eActivityTime_bag = 62000005,                   --背包
	eActivityTime_Arm = 62000006,                   --装备
	eActivityTime_Rank = 62000007,                  --排行榜
	eActivityTime_Mail = 62000008,                  --邮箱
	eActivityTime_Set = 62000009,                   --设置
	eActivityTime_Guild = 62000010,                 --社团
	eActivityTime_Forge = 62000011,                 --锻造
	eActivityTime_FirsetRecharge = 62000012,        --首充
	eActivityTime_Activity = 62000013,              --活动
	eActivityTime_Task = 62000014,                  --每日任务
	eActivityTime_Recruit = 62000015,               --招募
	eActivityTime_Friend = 62000016,                --好友
	eActivityTime_Recharge = 62000017,              --充值
	eActivityTime_GiftBag = 62000018,               --礼包
	eActivityTime_Sign_in = 62000019,				--7日乐
	eActivityTime_BuyAp = 62000020,				    --购买体力
	eActivityTime_BuyGold = 62000021,				--购买金币
	eActivityTime_Shop = 62000022,                  --商店
	eActivityTime_buy1 = 62000025, 					--一元购
	eActivityTime_Team = 62000023,					--阵容
	eActivityTime_LoginGift = 62000024,				--登录送礼
	eActivityTime_limit_buy = 62000026,				--限时礼包
	eActivityTime_vending_machine = 62000027,		--贩卖机
	eActivityTime_Mask = 62001008,             --登录送礼

	--玩家相关
	eActivityTime_TalentSystem = 62001000,			--天赋系统
	eActivityTime_RolePokedex = 62001001,			--角色图鉴
	eActivityTime_GraduateSchool = 62001002,		--研究所
	eActivityTime_MonthCard = 62001003,		        --月卡
	eActivityTime_EliteLevel = 62001004,		    --精英关卡
	eActivityTime_Trainning = 62001005,		        --训练场
	eActivityTime_Area = 62001006,					--区域系统
	eActivityTime_GuardHeart = 62001007,					--守护之心
	--角色相关
	eActivityTime_RoleUpgradeRarity = 62002001,		--角色升品
	eActivityTime_RoleUpgradeStar = 62002002,		--角色升星
	eActivityTime_RoleUpgradeSkill = 62002003,		--强化技能
	eActivityTime_RoleUpgradeLevel = 62002004,		--角色升级
	eActivityTime_Contact = 62002005,		        --连协
	eActivityTime_Restraint = 62002006,		        --属性克制
	eActivityTime_BreakThrouth = 62002007,		    --突破界限
	--装备相关
	eActivityTime_EquipLevel = 62003000,		    --装备升级
	eActivityTime_EquipStar = 62003001,		        --装备升星
	--商店相关
	eActivityTime_Equip = 62004000,                 --装备寶箱
	eActivityTime_ShopSundry = 62004001,			--杂货商店
	eActivityTime_ShopArena = 62004002,			    --竞技场商店
	eActivityTime_ThreeToThree = 62004003,			--3V3商店
	eActivityTime_ShopFuzion = 62004004,			--大乱斗商店
	eActivityTime_ShopKuikuliya = 62004005,			--极限挑战商店
	eActivityTime_ShopMystery = 62004006,			--神秘商店
	eActivityTime_ShopGuild = 62004007,			    --社团商店
	eActivityTime_ShopTrial = 62004008,			    --远征商店
	eActivityTime_ShopVip = 62004009,			    --好感商店

	--其他
	eActivityTime_FindLs = 62005001,		        --寻找LS
	eActivityTime_PowerRank = 62005002,				--战力排行
	eActivityTime_AutoFight = 62005003,				--自动战斗
	eActivityTime_Dailytask = 62005004,				--日常任务

	eActivityTime_ScoreHero = 62006000,				--积分英雄

	eActivityTime_GuardHeart = 62001007,			--守护之心

	eActivityTime_1v1 = 60055128,				    --1v1
	eActivityTime_Duel = 62006001,				    --对决
	eActivityTime_GoldenEgg = 62006002,				--砸金蛋
}

MsgEnum.mmo_content =
{
	[1] = MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox; 	-- 世界宝箱
}

--日常任务编号
MsgEnum.edailytask_index =
{
	eDailyTask_type_hurdle = 1,
	eDailyTask_type_saodang = 2,
	eDailyTask_type_equipUpgrade = 3,
	eDailyTask_type_equipCompound = 4,
	eDailyTask_type_niudan_role = 5,
	eDailyTask_type_niudan_equip = 6,
	eDailyTask_type_baoweicanchang = 7,
	eDailyTask_type_worldBoss = 8,
	eDailyTask_type_yingxionglilian = 9,
	eDailyTask_type_gaosujuji = 10,
	eDailyTask_type_church_pray = 11,
	eDailyTask_type_slg_building = 12,
	eDailyTask_type_slg_robbery = 13,
	eDailyTask_type_kuikuliya = 14,
	eDailyTask_type_daluandou = 15,
	eDailyTask_type_3v3 = 16,
	eDailyTask_type_store_card1 = 17,
	eDailyTask_type_store_card2 = 18,
}

MsgEnum.emarquee_msg_type =
{
	eRollMessage_type_GM = 0,               --后台GM公告
	eRollMessage_type_monthCard = 1,	    --parm1（玩家名）购买了parm2(卡片名)月卡，轻松领取每日钻石奖励
	eRollMessage_type_vip = 2,	            --parm1（玩家名）达到了VIP parm2（vip等级），享受游戏特权
	eRollMessage_type_niudan = 3,	        --parm1(玩家名)获得parm2(道具ID)
	eRollMessage_type_worldBoss = 4,        --parm1(玩家名)击杀了世界BOSS
	eRollMessage_type_guildBoss = 5,        --parm1(玩家名)击杀了公会BOSS
	eRollMessage_type_guildWar = 6,         --parm1(帮派名)赢得了公会战
	eRollMessage_type_hurdle = 7,	        --parm1(玩家名)闯过了parm2(章节名)
	eRollMessage_type_kuikuliya = 8,	    --parm1(玩家名)通过了奎库利亚parm2(章节名)层
	eRollMessage_type_hero_star_up = 9,	--parm1(玩家名)将parm2(英雄number)英雄升到了5星
	eRollMessage_type_baoweizhan = 10,	    --parm1(玩家名)在保卫战中很牛逼
	eRollMessage_type_equipCompound = 11,	--parm1(玩家名)合成了parm2(道具ID)
	eRollMessage_type_expedition = 12,	    --parm1(玩家名)在十一区讨伐战中战胜了所有对手
	eRollMessage_type_arena = 13,	        --parm1(玩家名)进入了钻石组
	eRollMessage_type_equipIntensify = 14,	--parm1(玩家名)将parm2(装备number)装备强化到5星
	eRollMessage_type_churchpray = 15,	    --parm1（玩家名）占领了parm2（星级）教堂主教位置
	eRollMessage_type_worldTreasureBoxSystemOpenCD = 16,--世界宝箱将于parm1（分钟数）分钟后开启，请大家前往夺取宝箱！
	eRollMessage_type_worldTreasureBoxSystemOpened = 17,--世界宝箱已经开启，请大家前往夺取宝箱！
	eRollMessage_type_worldTreasureMysteriousBoxFreeCD = 18, --神秘宝箱已经刷新，parm1（分钟数）分钟后可以开启
	eRollMessage_type_worldTreasureMysteriousBoxFreed = 19, --神秘宝箱已经可以开启
	eRollMessage_type_worldTreasureBoxSystemCloseCD = 20,	--世界宝箱将于parm1（分钟数）分钟后结束
	eRollMessage_type_map_boss_kill = 21,   --BOSSXXX被玩家XXXX击杀，获得击杀奖励【XXXX】
	eRollMessage_type_go_to_kill_boss = 22,   --BOSSXXX被玩家XXXX击杀，获得击杀奖励【XXXX】
	eRollMessage_type_hero_rarity = 23,	--parm1(玩家名)将parm2(英雄number)英雄升到了(品级)
	eRollMessage_type_worldTreasureMysteriousBoxOpened = 24,	--恭喜，神秘宝箱已被parm1(国家ID)·parm2(玩家ID)成功开启，所有parm1(国家ID)的玩家都将获得额外奖励
	eRollMessage_type_vipOnlineTips = 25,
	eRollmessage_type_power_rank = 26,      --恭喜玩家[%s·%s]在提升战力送杰森活动中获得战力排名第%s名！
	eRollmessage_type_lucky_cat = 27,       --恭喜玩家parm1(几区)parm2(玩家名)运气爆表,在老虎机活动中获得parm3(钻石)钻石
	eRollMessage_type_worldBossKilled = 28,		--经过一番激战，parm1杀死了世界BOSS parm2，获得击杀大奖！
	eRollMessage_type_goldenEgg = 29,		--恭喜玩家XX在鉴赏美酒的活动中获得XX倍暴击YY钻石！
}

MsgEnum.ERankingListType =
{
	ERankingListType_FightScore = 1,			--战斗力
	ERankingListType_Level = 2,					--等级
	ERankingListType_PassHurdle = 3,			--闯关
	ERankingListType_Guild = 4,					--帮派
	ERankingListType_KuiKuLiYa = 5,				--奎库利亚
	ERankingListType_SLG = 6,					--大学校园
	ERankingListType_DaLuanDou = 7,				--大乱斗
	ERankingListType_SLGIncludeRobot = 8,		--大学校园，包含机器人
	ERankingListType_GuildFightValue = 9,		--社团战斗力排行榜
	ERankingListType_RoleFightValue = 10,		--角色战斗力排行榜
	ERankingListType_ExpeditionTrial = 11,		--远征
	ERankingListType_Area_exploit = 12,			--功勋
	ERankingListType_Area_worship = 13,			--膜拜榜
	ERankingListType_GuildWarScore = 14,		--社团战积分排行榜
	ERankingListType_GuildWarWeekScore = 15, 	--社团战周积分排行榜
	ERankingListType_GuildWarJoinTimes = 16,	--社团战参与次数
	ERankingListType_HurdleStar = 18,			--副本星数排行榜
}
