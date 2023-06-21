
ENUM = {};
--玩家状态
ENUM.EOnlineState =
{
	online = 0,				--在线
	disconnection = 1,		--断线（只是断线，但还在服务器内存中）
	offline = 2,			--2离线（不在服务器内存了）
}
--当前英雄最大星级
ENUM.RoleMaxStarLevel = 7;
--装备位置
ENUM.EEquipPosition =
{
	Empty = 0,				--空
	Helmet = 1,				--头盔(帽子)
	Armor = 2,				--铠甲(衣服)
	Trouser = 3,			--裤子
	Boots = 4,				--鞋子
	Accessories = 5,		--饰品
	weapon = 6,		        --武器
	Max = 6,
}
--装备类型
ENUM.EEquipType =
{
	Empty = 0,				--空
	Helmet = 1,				--头盔(帽子)
	Armor = 2,				--铠甲(衣服)
	Trouser = 3,		    --裤子
	Boots = 4,				--鞋子
	Accessories = 5,		--饰品
    weapon  = 6,            --武器
	Max = 6,
}

--性别
ENUM.ESex =
{
	Boy = 1, 	--男
	Girl = 2,	--女
}

--职业类型
ENUM.EProType =
{
	All = 0,		--所有
	Fang = 1, 		--防
	Gong = 2,	    --攻
	Ji = 3,		    --技
}

--表示英雄装备偏好,用于推荐装备
EHeroPreferenceType =
{
    EHeroPreferenceTypeMin = 1,

    EEnergyAttack = 1,  --能量攻击
    EEnergyTank = 2,    --能量肉盾
    EPhysicsAttack = 3, --物理攻击
    EPhysicsTank = 4,   --物理肉盾

    EHeroPreferenceTypeMax = 4,
}
--普通攻击类型
ENUM.EAttackType =
{
	Melee = 1,		--近战
	Remote = 2,		--远程
}

EMapEntityType = 
{
    
    EMy = 1,

    EBoss = 5,
	ESuper = 6,			--精英
	ESoldier = 7,		--小怪

    EGreenBase = 10,
    ERedBase = 11,

    EGreenHero = 13,
    EGRedHero = 14,

    EGreenTower = 15,
    ERedTower = 16,

    EAddHPBuff = 20,
    EBuff = 21,

    ETranslationPoint = 22,
}

--拥有技能
ENUM.EOwnSkill =
{
	Attack1 = 1,	--普攻1段
	Attack2 = 2,	--普攻2段
	Attack3 = 3,	--普攻3段
	Skill1 = 4,		--技能1
	Skill2 = 5,		--技能2
	Skill3 = 6,		--技能3
	Max = 6,
}
--克制属性
ENUM.ERestraint = {
	Empty = 0,			--空
	Edge = 1,			--锐
	Solid = 2,			--坚
	Fast = 3,			--疾
	Unusual = 4,		--特
	MaxValue = 5, 		--最大值
}
--羁绊
ENUM.EJiBan =
{
	JiBan1 = 1,			--羁绊1
	JiBan2 = 2,			--羁绊2
	JiBan3 = 3,			--羁绊3
	JiBan4 = 4,			--羁绊4
	JiBan5 = 5,			--羁绊5
	JiBan6 = 6,			--羁绊6
	Max = 6,
}
--英雄或者怪物属性
ENUM.min_property_id = 30000000;
ENUM.max_property_id = 30000999;
ENUM.EHeroAttribute =
{
	cur_hp                      = ENUM.min_property_id + 1,	--当前生命值
    max_hp                      = ENUM.min_property_id + 2,	--最大生命值
    atk_power                   = ENUM.min_property_id + 3,	--攻击力
    def_power                   = ENUM.min_property_id + 4,	--防御力
    crit_rate                   = ENUM.min_property_id + 5,	--暴击率
    anti_crite                  = ENUM.min_property_id + 6,	--免爆率
    crit_hurt                   = ENUM.min_property_id + 7,	--暴击伤害加成
    broken_rate                 = ENUM.min_property_id + 8, --破击率
    parry_rate                  = ENUM.min_property_id + 9, --格挡率
    parry_plus                  = ENUM.min_property_id + 10,--格挡伤害加成
    move_speed                  = ENUM.min_property_id + 11,--移动速度
    move_speed_plus             = ENUM.min_property_id + 12,--移动速度加成
    bloodsuck_rate              = ENUM.min_property_id + 13,--吸血率
    rally_rate                  = ENUM.min_property_id + 14,--反弹率
    attack_speed                = ENUM.min_property_id + 15,--攻击速度加成
    dodge_rate                  = ENUM.min_property_id + 16,--闪避率
    res_hp                      = ENUM.min_property_id + 17,--生命恢复率
    cool_down_dec               = ENUM.min_property_id + 18,--技能冷却缩减
    treat_plus                  = ENUM.min_property_id + 19,--治疗效果加成
    restraint1_damage_plus      = ENUM.min_property_id + 20,--对锐属性英雄伤害加成
	restraint2_damage_plus      = ENUM.min_property_id + 21,--对坚属性英雄伤害加成
	restraint3_damage_plus      = ENUM.min_property_id + 22,--对疾属性英雄伤害加成
	restraint4_damage_plus      = ENUM.min_property_id + 23,--对特属性英雄伤害加成
    restraint_all_damage_plus   = ENUM.min_property_id + 24,--对全属性英雄伤害加成
    restraint1_damage_reduct    = ENUM.min_property_id + 25,--对锐属性英雄伤害减免
	restraint2_damage_reduct    = ENUM.min_property_id + 26,--对坚属性英雄伤害减免
	restraint3_damage_reduct    = ENUM.min_property_id + 27,--对疾属性英雄伤害减免
	restraint4_damage_reduct    = ENUM.min_property_id + 28,--对特属性英雄伤害减免
    restraint_all_damage_reduct = ENUM.min_property_id + 29,--对全属性英雄伤害减免
    normal_attack_1             = ENUM.min_property_id + 30,--普通攻击1段
    normal_attack_2             = ENUM.min_property_id + 31,--普通攻击2段
    normal_attack_3             = ENUM.min_property_id + 32,--普通攻击3段
    quan_neng					= ENUM.min_property_id + 33,--全能
    normal_attack_4             = ENUM.min_property_id + 34,--普通攻击4段
    normal_attack_5             = ENUM.min_property_id + 35,--普通攻击5段
}

ENUM.EHeroAttributeKey = {}
for k, v in pairs(ENUM.EHeroAttribute) do
	ENUM.EHeroAttributeKey[v] = k
end
-- 属性值类型（1数值 2百分比）
ENUM.EAttributeValueType =
{
	[30000001] = 1,	--[[当前生命值				cur_hp						四舍五入取整                   ]]
	[30000002] = 1,	--[[最大生命值				max_hp						四舍五入取整                   ]]
	[30000003] = 1,	--[[攻击力					atk_power					四舍五入取整                   ]]
	[30000004] = 1,	--[[防御力					def_power					四舍五入取整                   ]]
	[30000005] = 1,	--[[暴击率					crit_rate					四舍五入取整                   ]]
	[30000006] = 1,	--[[免爆率					anti_crite					四舍五入取整                   ]]
	[30000007] = 1,	--[[暴击伤害加成			crit_hurt					四舍五入取整                   ]]
	[30000008] = 1,	--[[破击率					broken_rate					四舍五入取整                   ]]
	[30000009] = 1,	--[[格挡率					parry_rate					四舍五入取整                   ]]
	[30000010] = 1,	--[[格挡伤害加成			parry_plus					四舍五入取整                   ]]
	[30000011] = 2,	--[[移动速度				move_speed					四舍五入，保留2位小数          ]]
	[30000012] = 3,	--[[移动速度加成			move_speed_plus				百分比，百分位四舍五入取整     ]]
	[30000013] = 1,	--[[吸血率					bloodsuck_rate				四舍五入取整                   ]]
	[30000014] = 1,	--[[反弹率					rally_rate					四舍五入取整                   ]]
	[30000015] = 1,	--[[攻击速度加成			attack_speed				四舍五入取整                   ]]
	[30000016] = 1,	--[[闪避率					dodge_rate					四舍五入取整                   ]]
	[30000017] = 1,	--[[生命恢复率				res_hp						四舍五入取整                   ]]
	[30000018] = 1,	--[[冷却冷却缩减			cool_down_dec				四舍五入取整                   ]]
	[30000019] = 1,	--[[治疗效果加成			treat_plus					四舍五入取整                   ]]
	[30000020] = 1,	--[[对锐属性英雄伤害加成	restraint1_damage_plus		四舍五入取整                   ]]
	[30000021] = 1,	--[[对坚属性英雄伤害加成	restraint2_damage_plus		四舍五入取整                   ]]
	[30000022] = 1,	--[[对疾属性英雄伤害加成	restraint3_damage_plus		四舍五入取整                   ]]
	[30000023] = 1,	--[[对特属性英雄伤害加成	restraint4_damage_plus		四舍五入取整                   ]]
	[30000024] = 1,	--[[对全属性英雄伤害加成	restraint_all_damage_plus	四舍五入取整                   ]]
	[30000025] = 1,	--[[对锐属性英雄伤害减免	restraint1_damage_reduct	四舍五入取整                   ]]
	[30000026] = 1,	--[[对坚属性英雄伤害减免	restraint2_damage_reduct	四舍五入取整                   ]]
	[30000027] = 1,	--[[对疾属性英雄伤害减免	restraint3_damage_reduct	四舍五入取整                   ]]
	[30000028] = 1,	--[[对特属性英雄伤害减免	restraint4_damage_reduct	四舍五入取整                   ]]
	[30000029] = 1,	--[[对全属性英雄伤害减免	restraint_all_damage_reduct	四舍五入取整                   ]]
	[30000030] = 1,	--[[普通攻击1段				normal_attack_1				四舍五入取整                   ]]
	[30000031] = 1,	--[[普通攻击2段				normal_attack_2				四舍五入取整                   ]]
	[30000032] = 1,	--[[普通攻击3段				normal_attack_3				四舍五入取整                   ]]
	[30000033] = 1,	--[[全能					quan_neng					四舍五入取整                   ]]
	[30000034] = 1,	--[[普通攻击4段				normal_attack_4				四舍五入取整                   ]]
	[30000035] = 1,	--[[普通攻击5段				normal_attack_5				四舍五入取整                   ]]
}

--怪物兵种
ENUM.EMonsterType =
{
	Empty = 0,				-- 无类型
	SoldierClose = 1,		-- 近战小兵
	SoldierRnage = 2,		-- 远程小兵
	Basis = 4,				-- 基地
	Boss = 8,				-- boss
    CloseSuper = 16,        -- 近战精英
    FarSuper = 32,          -- 远程精英
    Hero = 64,              -- 英雄
    WorldBoss = 128,        -- 世界BOSS
    Patrol = 256,           -- 巡逻怪
    Tower  = 512,           -- 塔
	BloodPool = 1024,		-- 血池
	SceneItem = 2048,		-- 场景物品
    NotRemoveItem = 4096,	-- 不删除物品
}

--最大静态地图数量
ENUM.MAX_STATIC_WORLD_ID = 10


-- 更新UI数据
ENUM.EUPDATEINFO = {
    role = 1,  --人物卡牌
    equip = 2, --装备卡牌
    item = 3,  --道具卡牌
    team = 4,  --队伍信息
    activity = 5, -- 活动信息
    activity_team = 6, -- 活动队伍信息
}

-- 触发器的枚举也攒过来了。
ENUM.E_TRIGGER_TYPE =
{
	TriggerEnter = 1,				--进入触发
	TriggerStay = 2,				--在范围内一直触发
	TriggerExit = 3,				--离开触发
	TriggerEnterHurdleFight = 4,	--进入战斗
	TriggerHurdleFightOver = 5,		--战斗结束
	TriggerMyHeroPropertyChange = 6,--任意一个我方英雄属性发生改变
	TriggerMonsterEnterFight = 7,	--entity进入战斗(目前只支持怪物)
	TriggerMonsterDead = 8,			--怪物死亡
	TriggerCutsceneEnd = 9,			--过场动画或剧情结束
	TriggerPlayerUseItem = 10,		--玩家使用道具
    TriggerEnterTimer = 11,		    --进入触发后启动定时器
    TriggerEnterAreaRandomItem = 12,    --进入触发后区域随机Item
	TriggerThreeToThreeFightOver = 13,	--3v3战斗结束
	MonsterLoaderTrigger = 14,	--
	AddBuffTrigger = 15, -- 添加buff时触发
	FinishClearingTrigger = 16, -- 弹完结算界面后触发
}

-- 关卡状态
ENUM.ELevelState =
{
	Success = 0,				-- 成功
	WinAllReady = 1,			-- 已经打过了，
	CanFight = 2,				-- 可以挑战，但是以前没打过
	NothingToDo = 3,			-- 什么都不能做，只能看看
	ApNot = 4,					-- 体力不足
	LevelNot = 5,				-- 等级不够
	CountNot = 6,				-- 次数不够
	NormalGroupNot = 7,			-- 普通章节未通
}

--Loading类型
ENUM.ELoadingType =
{
	Single = 1,			--单一
	FullScreen = 2,		--全屏
}

--Loading大小
ENUM.ELoadingScale =
{
	Small = 1,			--小
	Middle = 2,			--中
	Big = 3,			--大
}

--音乐播放模式
ENUM.EAudioPlayMode =
{
	Order = 1,      --顺序播放
	Loop = -1,		--列表循环
	Random = -2,    --随机播放
}

--音乐类型
ENUM.EAudioType =
{
	_2d = 1,
	_3d = 2,
	UI = 3,
}

--背景音乐播放器
ENUM.EAudioPlayer =
{
	p1 = 1,
	p2 = 2,
}

ENUM.EPackageType =
{
	Empty = 0,				--无类型
	Hero = 1,				--[[英雄]]
	Equipment = 2,			--[[装备]]
	Item = 3,				--[[道具]]
	Skill = 4,				--[[技能]]
	Other = 5,				--[[杂项]]
}


ENUM.EShowHeroType =
{
    All = "全部英雄",
    Have = "已拥有",
    DontHave = "未拥有",
}

ENUM.EHeroCcgType =
{
    CCG = 1,
    SSG = 2,
}

--[[装备品级]]
ENUM.EEquipRarity =
{
	White = 0,
    Green = 1,
	Green1 = 2,
    Green2 = 3,
	Blue = 4,
    Blue1 = 5,
    Blue2 = 6,
    Blue3 = 7,
	Purple = 8,
    Purple1 = 9,
    Purple2 = 10,
    Purple3 = 11,
    Purple4 = 12,    
	Orange = 13,
    Orange1 = 14,
    Orange2 = 15,
    Orange3 = 16,
    Orange4 = 17,
    Orange5 = 18,
    Red = 19,
    Red1 = 20,
}

--[[装备达人]]
ENUM.EquipExpertType = {
	Level = 1,
	Star = 2,
	SpecLevel = 3,
	SpecStar = 4,
}

--商店Item的两种类型
ENUM.EStoreCardType =
{

	CrystalItem = 1,		--道具（钻石）
	CrystalOneYuan = 3,		--一元购
}

--商店Item的六种标记
ENUM.EStoreCardMark =
{
	Null = 0,				--没有
	Recommend = 1,			--推荐
	Abate = 2,				--打折
	Hot = 3,				--热销
	Quota = 4,				--限购
	Interval = 5,			--限时
}
--道具所属类别
ENUM.EItemCategory =
{
	Empty = 0,				--空
	Drug = 1,				--药品
	TwoMoney = 2,			--二级货币
	Formula = 3,			--配方
	Badge = 4,				--徽章
	Forging = 5,			--锻造材料
	HeroDebris = 6,			--英雄碎片
    Helmet = 7,			    --帽子材料
    Accessories = 8,		--饰品材料
}
--道具所属系统
ENUM.EItemCategorySystem =
{
	Empty = 0,				--无
	RoleStar = 1,			--角色升星
	Talent = 2,				--天赋
	Restraint = 3,			--克制
	EquipBox = 4,			--装备宝箱
	Trainning = 5,			--训练场
	RoleRarity = 6,			--角色升品
	EquipRarity = 7,		--装备升品
	EquipLevelUp = 8,		--装备升级
	EquipStar = 9,			--装备升星
	RoleLevelUp = 10,		--角色升级
	Maskinfo = 11,          --面具
}


--道具品质
ENUM.EItemRarity = 
{
	White = 1,			--白色
	Green = 2,			--绿色
	Blue = 3,			--蓝色
	Purple = 4,			--紫色
	Orange = 5,			--橙色
	Red = 6,			--红色	
}

--道具所属标签类型
ENUM.EPackageItemCategory = {
	All = 0,  --所有
	Comsumables= 1,          --消耗品
	Martiral = 2, 		    --材料
	Debris = 3,		--碎片
	Euipment = 4,  --装备
}


ENUM.EColor =
{
	[1] = {r=255,g=255,b=255},  --白
	[2] = {r=9,g=255,b=0},	  --绿
	[3] = {r=0,g=23,b=255},	  --蓝
	[4] = {r=220,g=0,b=255},   --紫
	[5] = {r=251,g=255,b=0},     --金
	[6] = {r=255,g=0,b=0},        --红
	White = {r=255,g=255,b=255},  --纯白
	Black = {r=0,g=0,b=0},        --纯黑
	Red   = {r=255,g=0,b=0},      --纯红
	Green = {r=0,g=255,b=0},      --纯绿
	Blue  = {r=0,g=0,b=255},      --纯蓝
	Purple= {r=240,g=0,b=255},    --纯紫
	Orange= {r=255,g=153,b=0},    --纯橙
}

--uisprite翻转模式
ENUM.EFlipMode =
{
	Nothing = 0,				--不翻转
	Horizontally = 1,			--水平翻转
	Vertically = 2,				--垂直翻转
	Both = 3,					--都翻转
}
--[[战斗回合判断类型]]
ENUM.ERoundType = {
	PeopleAllKill = 1;--[[一方全死]]
	TowerDown = 2;--[[一方塔倒]]
};
--对象删除原因
ENUM.EDeleteObjReason = {
	dead, --死亡
	event,	--事件
}

ENUM.EFightSyncType = {
    Single = 0,     --单机
    StateSync = 1,  --状态同步
    FrameSync = 2,  --帧同步
}

ENUM.EVideoMode =
{
	CancelOnInput = 1,		--播放点击关闭
	Full = 2,				--播放时，点击可以调出暂停接口 全屏
	Hidden = 3,				--没有任何控制
	Minimal = 4,			--播放时，点击可以调出进度条控制
}

ENUM.ELockType =
{
	jiao_tang_qi_dao_1 = 1,  --该英雄正在教堂祈祷中，其他玩法不能使用
	jiao_tang_qi_dao_2 = 2,
}

ENUM.EFriendPaneID =
{
	FriendList = 1,		    -- 好友列表
	Blacklist = 2,			-- 黑名单
	AddFriend = 3,			-- 添加好友
	FriendRequest = 4,		-- 好友申请
    InventFriend = 5,		-- 邀请好友
    SearchFriend = 6,		-- 搜索好友
}

ENUM.EFriendType =
{
	Friend = 1,		        -- 好友
	Blacklist = 2,			-- 黑名单
    Add = 3,			    -- 要添加的好友
	Request = 4,		    -- 好友的申请
    Search = 5,		        -- 搜索好友
}

ENUM.ETeamType = 
{
	unknow = -1,						--无队伍
	normal = 0,							--普通
	kuikuliya = 1,						--奎库利亚活动
	-- city_building_teaching_build = 2,	--教学楼编队
	-- city_building_dining_room = 3,		--餐厅编队
	-- city_building_library = 4,			--图书库编队
	churchpray1_1 = 2,					--//教堂挂机1-1
	churchpray1_2 = 3,					--//教堂挂机1-2
	churchpray2_1 = 4,					--//教堂挂机2-1
	churchpray2_2 = 5,					--//教堂挂机2_2
	churchpray3_1 = 6,					--//教堂挂机3_1
	churchpray3_2 = 7,					--//教堂挂机3_2
	churchpray4_1 = 8,					--//教堂挂机4_1
	churchpray4_2 = 9,					--//教堂挂机4_2
	-- fuzion = 13,							--大乱斗
	threeToThree = 10,					--3v3
	arena = 11,							--竞技场
	world_treasure_box = 12,				--世界宝箱
	clone_fight = 13,					--克隆战
	trial = 14,							--远征试炼
	fuzion2 = 15,						--大乱斗2
	world_boss = 16,					--世界BOSS
	guild_boss1 = 17,					--社团BOSS阵容1
    guild_war = 18,					    --社团战/帮战队伍1
    guild_war2 = 19,					    --社团战/帮战队伍2
    guild_war3 = 20,					    --社团战/帮战队伍3
    guild_gaosujuji = 21,					--//高速狙击
	guild_Defend_war = 22,					--//保卫战
	Clown_plan = 23,						--//小丑计划
	guild_boss2 = 24,					--社团BOSS阵容2
};

ENUM.ELeaveType =
{
	Leave = 0,				--直接离开
	Relive = 1,				--复活
	PlayerLevelUp = 2,		--玩家升级 到关卡
	EquipLevelUp = 3,		--装备升级 到阵容
	--EquipComposite = 4,	--装备合成 到装备合成
    HeroEgg = 5,            --招募
}

ENUM.EAI =
{
    MainHero = 114,               -- 主英雄
    PVPMainHero = 114,              --实现了击飞击退等效果的主英雄，主要用于pvp
    MainHeroAutoFight = 109,        --主英雄自动战斗
    FollowHero = 106,               --跟随英雄
    Towner = 110,                   --塔

    SLG_DianZhang = 116,             --slg店长
    ThreeVThreeAutoFight = 142,      --3v3自动自动战斗ai
	ThreeVThreeRobot = 141,		     --3v3机器人ai
    DaLuanDouAutoFight = 117,        --大乱斗自动战斗

    StandAndCanBeAttack = 104,       --站立不攻击但是可以被攻击
	TrialBossFriendHero = 152,		--远征抢boss己方英雄AI
	TrialBossEnemyHero = 153,		--远征抢boss敌方英雄AI
}


--公会职位类型
ENUM.EGuildJob =
{
	None = 0,				-- 未定义
	President = 1,			-- 社长（1个）
	VicePresident = 2,		-- 副社长（最多1个）
	Minister = 3,			-- 精英（最多3个）
	Member = 4,				-- 社员（多个）
}

--公会
ENUM.EGuildActivityID =
{
	Boss = 1,
	Technology = 2,
	Territory = 3,
}

ENUM.EUiAudioType =
{
	MainBtn = 81200000,        --主要按键音1
	BackBtn = 81200001,        --返回按钮
	CutIn = 81200002,          --菜单划入1
	CutOut = 81200003,         --菜单划出1
	DlgOut = 81200004,         --对话框弹出音效
	ChangeRole = 81200005,     --切换角色按键
	Flag = 81200006,           --标签点击
	SkillComplete = 81200007,  --技能完成时
	BeginFight = 81200008,     --作战开始
	GetReward = 81200009,      --扭蛋得到东西
	GetHero = 81200115,        --扭蛋得到大英雄
	VicStar = 81200114,        --关卡胜利，弹出星星
	ComReward  = 81200012,     --通用获得奖励界面音效
	ExpLoop = 81200013,        --经验增加音效loop
	ExpEnd = 81200014,         --经验增加音效end
	LvUp = 81200015,		   --升级时的音效
	Start = 81200016,          --点击开始游戏时
	SlgHello = 81200017,       --slg欢迎光临
	ShopMoney = 81200020,      --商店音效
	LvUpHero = 81200025,       --英雄升级
	LvUpTeam = 81200026,       --战队升级
	LvUpEquip = 81200027,      --装备升级
	LvUpNormal = 81200028,     --通用升级
	StarUpHero = 81200029,     --英雄升星
	RewardGetHero = 81200030,  --获得英雄
	RewardGacha = 81200031,    --扭蛋获得道具
	RewardProperty = 81200032, --获得道具
	Heartbeat = 81000034,      --心跳
	Thunder = 81000036,        --打雷声音
	ChatNormal = 81200047,     --聊天界面通用声音
	MainUiDown = 81200048,     --主界面下面一排按钮
	MainUiRight = 81200049,     --主界面下面一排按钮
	InsertTeam = 81200050,     --阵容调整中的角色上阵提示音效
	Chapter = 81200051,        --章节界面中的章节选择和关卡选择音效
	Bell = 81200053,		   --钟响
	ZjmJmy = 81200054,         --主界面金木研跳下
	ZjmAjnb1 = 81200055,       --主界面安久奈白跳下
	ZjmAjnb2 = 81200056,       --主界面安久奈白跳走
	RestraintNormal = 81200085,--克制属性解锁或升级
	BreakThrough = 81200086,   --突破界限音效
	VsEnterChoseHero = 81200087,--3v3进入选人Ui音效
	Select3v3HeroSure = 81200088,  --3v3选人确定
	Begin3v3Fight = 81200089,  --竞技-3V3攻防战-进入游戏的音效
	DonationSuccess = 81200091,--社团科技捐献成功
	DragMenu = 81200092,       --拖动按钮音效
	ExpLvup = 81200093,        --结算界面经验值后的卡片升级特效
	DaZhaoSlide = 81000008,        --播放大招时,ui界面弹出时的声音
	GuideSlide = 81200111,        --新手引导划入特效对应音效
	FightCountDown = 81200112,        --战斗开始倒计时音效
	FIndLsFaPai = 81200102,      --寻找LS 发牌
	OpenEquipBox = 81200104,      --打开装备宝箱
}

ENUM.EUiAudioBGM =
{
	MainCityBgm = 81000003,		--主城BGM
	VsWaitingBgm = 81000055,	--PVP等待BGM
}

ENUM.ERuleDesType=
{
      NiuDan=  1,               --扭蛋
      GaoSuZuJi =  2,	        --高速阻击
      BaoWeiZhan =  3	,       --保卫战
      YingXiongLiLian= 4	   ,--英雄历练
      KuiKuLiYa =  5	,       --奎库利亚
      TuPoJieXian =  6	,       --突破界限
      ZhuangBeiHeCheng = 7   ,  --装备合成
      ShiJieBoss = 8   ,        --世界BOSS
      ShangJinRenWu = 9	,       --赏金任务
      ChurchBotMain = 10	,   --教堂挂机
      XiaoYuanJianShe = 11	  , --校园建设
      ChuangGuan = 12	,       --闯关
      TianFu = 14  ,            --天赋
      ZhuangBeiShengXin = 15  , --装备升星
      GongHui = 16  ,           --公会
      JingJiChang = 17	,       --竞技场
      ZhaoMuZhongXin = 18	,   --招募中心
      ZhuangBeiKu = 19	,       --装备库
      XiaoYuanJianSheLueDuo = 20,    -- 校园建设掠夺
      DaLuanDou = 21,			--大乱斗
      QingTongJiDi = 22,		--青铜基地
      LianXie = 23,				--连协
      EquipForge = 24,			--打造
      SkillUpgrade = 25,		--技能升级
      EquipLevelUp = 26,		--装备升级
      WorldBox = 27,			--世界宝箱
	  HeroIllumstrationUI = 29, --角色图鉴
	  Institute =  30,    		--研究所
	  CloneWar = 33,   			--克隆战
      LevelFund = 32, 			--等级基金
	  ClownPlan = 35, 			--小丑计划
	  ExpeditionTrial = 34,		--远征试炼
	  TrainningMain = 36,       --训练场
	  GuildBoss = 38,
	  LuckyCat = 39,			--招财猫
	  Restraint = 40,			--克制	
	  GuildWar = 41,			--社团战
	  GuildFindLsUI= 42,                         --寻找LS
	  HeroTrial= 44,        	--角色历练
	  GuradHeart = 45,			--守护之心
	  GoldenEgg = 46,        	--砸金蛋
	  ChatFight = 47,			--聊天约战
	  MaskSystem = 48,          --收藏
	  VipPacking = 49,			--董香之屋
      ScoreHero = 50,			--积分英雄
}
-- 本地通知类型
ENUM.NoticeType =
{
	InitPlayerInfoFinish= 1, 		-- 初始化游戏玩家数据完成

	GuideCameraChange	= 2,		-- 引导的相机打开状态改变（参数：value true/false）
	GuideCareMsgSend	= 3,		-- 引导关心的协议消息发送
	GuideCareMsgReceive	= 4,		-- 引导关心的协议消息接收

	PlayerLevelUp		= 1000,		-- 玩家等级提升
	NiuDanSuccess		= 1001,		-- 扭蛋成功（参数：type 0英雄/1装备, bTen false/true）
	ChangeEquipSuccess	= 1002,		-- 英雄换装成功
	ChangeTeamSuccess	= 1003,		-- 改变队伍成功（参数：teamid）
	VipDataChange		= 1004,		-- VIP数据改变
	CardItemChange		= 1005,		-- 道具数据改变（参数：配置id）
	GetCommonAddExpBack		= 1006,		-- 获得物品展示返回（新手引导专用）
	GetCommonAwardBack		= 1007,		-- 获得物品展示返回（新手引导专用）
	GetCommonHurdleBack		= 1008,		-- 关卡结算展示返回（新手引导专用）
	GetHeroStarupShowBack	= 1009,		-- 英雄升星展示返回（新手引导专用）
	GetHeroQuaUpShowBack	= 1010,		-- 英雄升品成功界面返回（新手引导专用）
	GetHurdleRaidsShowBack	= 1011,		-- 关卡扫荡结果界面返回（新手引导专用）
	GetFloatTipsShowBack	= 1012,		-- 战斗UI悬浮气泡退出显示（新手引导专用）
	ChangeAutoFightMode	= 1013,		-- 改变自动战斗状态（新手引导专用）
	PlayerNameChange	= 1014,		-- 玩家名字发生改变
	UiManagerRestart	= 1015,		-- ui栈恢复（参数：eui）
	PlayerLevelupUiFinish= 1016,	-- 战队升级界面退出
	FightStartEnd 		= 1017,		-- 战斗开场321界面退出
	GetBattleShowBack	= 1018,		-- 通用战斗结算退出通知（参数：0/1 失败/胜利）
	GetContactActiveShowBack	= 1019,	-- 连协激活界面退出
	GetNewHeroShowBack	= 1020,		-- 新英雄展示界面退出
	ChangeAreaSuccess	= 1021,		-- 选区成功
	BackToUiDailyTask	= 1022,		-- 关闭奖励界面/升级界面 回到每日任务界面
	RegionSelectRivalOK	= 1023,		-- 区域占领选对手结果成功
	MainSceneBtnClick	= 1024,		-- 触发了主场景上按钮点击事件（参数：功能id）
	UpdatePlayerCrystal	= 1025,		-- 更新玩家钻石数量（参数：oldCrystal, nowCrystal）
	GuidePlayGuideUiBack= 1026,		-- 新手引导通用玩法引导图ui退出
	FarTrialChooseDiff  = 1027,		-- 新手引导通知打开远征难度选择
	FarTrialChooseRole  = 1028,		-- 新手引导通知打开远征对手选择

	TriggerShowInstance	= 1050,		-- 触发对象显示效果
	TriggerCreateMonster= 1051,		-- 触发创建怪物效果
	TriggerPlayVideoAction= 1052,	-- 动作触发播放视频

	CreateWorldItem		= 1090,		-- 创建world item
	DeleteWorldObject	= 1091,		-- 删除world object（不区分类型，目前是一个协议）
	ReliveWorldFighter  = 1092, 	-- 复活world对象

	TriggerEffect		= 1099,		-- 触发效果通知（触发器id）
	ScreenPlayBegin		= 1100,		-- 剧情播放开始（参数：剧情id）
	ScreenPlayOver		= 1101,		-- 剧情播放结束（参数：剧情id, 是否跳过）
	FightOverBegin		= 1102,		-- 战斗退出开始（参数：关卡id）
	FightStartBegin		= 1103,		-- 战斗进入开始（参数：关卡id）
	FightUiLoadComplete	= 1104,		-- 战斗UI加载完成（参数：关卡id）
	SceneChangeEnter	= 1105,		-- 战斗UI加载完成（参数：关卡id）
	TaskAcceptOK		= 1106,		-- 任务接受完成（参数：任务id）
	TaskSubmitOK		= 1107,		-- 任务提交完成（参数：任务id）
	TaskStateUpdate		= 1108,		-- 任务状态改变（参数：任务id）
	PushUi				= 1109,		-- 从ui_manager压入ui（参数：ui枚举）
	PopUi				= 1110,		-- 从ui_manager移除ui（参数：ui枚举）
	UpdatePlayerFlag	= 1111,		-- 更新玩家Flag
	FuzionFighterData	= 2001,		-- 大乱斗战斗里英雄数据有更新
	GcPlayScreenplay	= 2002,		-- world_msg.gc_play_screenplay消息
	GcShowTaskDeTailInfo= 2003,		-- world_msg.gc_show_task_detail_info消息
	GuildDataChange		= 2004,		-- 公会数据发生变更
	AdvFuncEffectBegin	= 2005,		-- 功能预告开启效果展示开始
	AdvFuncEffectEnd	= 2006,		-- 功能预告开启效果展示完成
	AdvFuncAutoOpen		= 2007,		-- 功能开启时自动打开预告面板
	PlayerUseItem		= 2008,		-- 玩家使用道具
	CreateBufferItem	= 2009,		-- 创建一个场景buff对象
	DeleteBufferItem	= 2010,		-- 删除一个场景buff对象

    MonsterEnterFight   = 3001,     -- 怪物进入战斗 
    EntityDead          = 3002,     -- entity死亡
	EntityBeginMove		= 3003,		-- entity开始移动
	HeroEntityReborn    = 3004,     -- entity英雄复活
	EntityUseSkill  	= 3005,     -- entity使用技能攻击
	EntityHitted 	 	= 3006,     -- entity被击

	ActivityTimeUpdate	= 4002,	    -- 活动开启时间更新

}
-- 本地通知优先级定义
ENUM.NoticePriority	= {
	UNIMPORTANCE= 0,	-- 不重要
	LOWER		= 10,	-- 更低级
	LOW			= 20,	-- 低级
	NORMAL 		= 30,	-- 一般
	HIGH 		= 40,	-- 高级
	HIGHER		= 50,	-- 更高
	URGENCY 	= 60,	-- 紧急
}

-- 商店编号
ENUM.ShopID	= {
    EquipBox = 0,
    SUNDRY = 1,         --杂货商店
    ARENA = 2,          --竞技场-奖牌商店
    ThreeToThree = 3,   --3v3攻防战-青铜硬币商店
	FUZION = 4,         --大乱斗-战魂商店
    KKLY = 5,           --奎库利亚-挑战币商店
    MYSTERY = 6,        --神秘商店
    Guild = 7,          --公会商店
    Trial = 8,          --远征商店
	VIP = 9,            --好感商店
    MAX = 9,
}

-- 商店限制类型
ENUM.ShopLimit = {
    Level = 2,
} 

ENUM.ETypeFirstRecharge =
{
    noRecharge = 1,   --没充过值
    noGet = 2,        --充过，没领取奖励
    haveGet = 3,      --已经领取过奖励
}

ENUM.WorldFightRestirctType =
{
	Peace   = 0, --和平模式
	Country = 1,--国家模式
	Camp    = 2,--阵营模式
}


ENUM.AbilityChangeFrom =
{
    Self = 1,
    Enemy = 2,
    Friend = 3,
}

ENUM.BossStatus =
{
    CanKill = 1,
    Killed = 2,
}

 ENUM.AreaRel =
{
    Self = 1,
    Enemy = 2,
    Friend = 3,
}

--[[英雄品级]]
ENUM.EHeroRarity =
{
	White = 1,
    Green = 2,
	Green1 = 3,
    Green2 = 4,
	Blue = 5,
    Blue1 = 6,
    Blue2 = 7,
    Blue3 = 8,
	Purple = 9,
    Purple1 = 10,
    Purple2 = 11,
    Purple3 = 12,
    Purple4 = 13,    
	Orange = 14,
    Orange1 = 15,
    Orange2 = 16,
    Orange3 = 17,
    Orange4 = 18,
    Orange5 = 19,
    Red = 20,
    Red1 = 21,
}

ENUM.EffectType =
{
    Fixed = 0,--固定特效
    Emitter = 1,--弹道特效
    Transform = 2,--形变特效
    EmitterCollision = 3,--碰撞弹道特效
}

ENUM.SkillEffectType = 
{
    other = 0,
    AddHP = 1,
}

--[[天赋树id]]
ENUM.TalentTreeID =
{
    Comprehend = 40001000,      --领悟
    DeepRepair = 40002000,      --深修
    Master = 40003000,          --精通
}

--[[天赋状态]]
ENUM.TalentStatus =
{
    Lock = 1,           --未解锁
    Unlocked = 2,       --已解锁
    LevelUp = 3,        --升级
    TopLevel = 4,       --升到顶级
}

--[[扭蛋类型]]
ENUM.NiuDanType =
{
    Hero = 0,           --英雄
    Equip = 1,           --装备
    Gold = 2,           --金币
    Vip = 3, 			-- 魂匣活动
	Score = 4,          --积分英雄
}

ENUM.VolScaleType =
{
	MyCaptain = 1,   --自己操作英雄
	MyHero = 2,      --我方随从英雄
	EnemyHero = 3,   --敌方英雄
	Soldier = 4,     --小兵(近小兵,远小兵,精英近,精英远,巡逻怪)
	BOSS = 5,        --boss(boss,世界boss)
	Tower = 6,       --塔(基地,塔,血池)
	MonsterHero = 7, --怪物英雄
}

--[[战斗力类型]]
ENUM.FightingType =
{
	Team = 1,
	Role = 2,
}

ENUM.FriendOperState =
{
	Give	= 1,	--是否赠送
	BeGive 	= 2,	--是否被赠送
	Get		= 4,	--是否领取
}

--[[连协类型]]
ENUM.ContactType =
{
	Hero = 1,	        --获得英雄
	EquipProp = 2,	    --装备升星加属性
	EquipSkill = 3,	    --装备升星改技能
}


--[[邀请玩法名]]
ENUM.InvitePlayName = 
{
    CloneWar = 1,
    ThreeToThree = 2,
    GuildInvite = 3,
	ChatFight = 4,
}

--[[邀请类型]]
ENUM.InviteSource = 
{
    World = 1,
    Area = 2,
    Friend = 3,
    Guild = 4,      --社团邀请    
    JoinGuild = 5,  --招募社员
}

--[[活动类型]]

ENUM.Activity = 
{
	activityType_recruit = 1, 					--//招募英雄送礼
	activityType_level_fund = 2, 				--//等级基金
	activityType_play_target = 3, 				--//玩法目标
	activityType_everyday_recharge_total = 4, 			--//每日小额累计充值
	activityType_lucky_cat = 5, 				--//招财猫
	activityType_month_sign_in = 6, 			--//月签到
	activityType_double_defend = 7, 			--//保卫战，双倍
	activityType_double_gold_exchange = 8, 		--//金币兑换，双倍
	activityType_double_buy_ap = 9, 			--//体力购买， 双倍
	activityType_double_church_hook = 10, 		--//教堂挂机，双倍
	activityType_double_hight_sniper = 11, 		--//高速狙击，双倍
	activityType_double_kuikuliya = 12, 		--//奎库利亚, 双倍
	activityType_double_hurdle_normal = 13, 	--//普通关卡，双倍
	activityType_double_hurdle_elite = 14, 		--//精英关卡，双倍
	activityType_sign_in_7 = 15, 				--//七天乐
	activityType_consume_total = 16, 			--//累计消费
	activityType_recharge_total = 17,			--累计充值
	activityType_give_role_ship = 18, 			--//角色碎片大放送
	activityType_month_card = 19, 				--//大小月卡
	activityType_up_level_award = 20, 			--//升级奖励
	activityType_hurdle_award = 21, 			--//闯关奖励
	activityType_login_award = 22, 				--//登录送礼
	activityType_gift_exchange = 23, 			--//礼包兑换
	activityType_accout_binding = 24,			--//帐号绑定
	activityType_power_rank = 25,				--//战力排行
	activityType_play_target_2 = 26, 			--//玩法目标预留2
	activityType_play_target_3 = 27, 			--//玩法目标预留3
	activityType_play_target_4 = 28, 			--//玩法目标预留4
	activityType_play_target_5 = 29, 			--//玩法目标预留5
	activityType_extra_times_hight_sniper = 30,	--//高速狙击额外次数
	activityType_extra_times_baoweizhang = 31,	--//保卫战额外次数
	activityType_extra_times_xiaochoujihua = 32,	--//小丑计划额外次数
	activityType_sign_in_7_holiday = 33,			--//节日七天乐
	activityType_everyday_recharge_total_back_time = 34, --//每日充值送礼,后台设置时间
	activityType_login_award_back_time = 35,				--//登录送礼，后台设置时间
	activityType_niudan_hunxia = 36,						--//魂匣
	activityType_double_xiaochoujihua = 37,				--//小丑计划，双倍
	activityType_get_ap_reward = 38,					--//领取体力
	activityType_all_buy = 39,							--//全服抢购
	activityType_exchange_item = 40, 					--//兑换活动
	activityType_exchange_item_1 = 41, 					--//兑换活动
	activityType_exchange_item_2 = 42, 					--//兑换活动
	activityType_hurdle_extra_produce = 43,				--//关卡额外产出
	activityType_vip_buy = 44,							--//vip购买
	activityType_niudan_discount = 45,					--//扭蛋折扣
	activityType_yuanzheng_box_discount = 46,			--//远征宝箱折扣
	activityType_equip_box_discount = 47,				--//装备宝箱折扣
	activityType_discount_buy = 48,						--//折扣购买
	activityType_play_target_6 = 49, 			--//玩法目标预留6
	activityType_play_target_7 = 50, 			--//玩法目标预留7
	activityType_play_target_8 = 51, 			--//玩法目标预留8
	activityType_play_target_9 = 52, 			--//玩法目标预留9
	activityType_play_target_10 = 53, 			--//玩法目标预留10
	activityType_share_activity = 54,			--//分享活动
	activityType_score_hero = 55,				--//积分英雄
	activityType_limit_buy = 56,				--//限时购
	activityType_welfare_box = 57,			 	--//福利宝箱小
	activityType_golden_egg = 58,			 	--//砸金蛋
	activityType_vending_machine = 59,			 	--//贩卖机
	activityType_subscribe = 60,			 	--//订阅
	
}

ENUM.Double = 
{
	defend = 1,			--保卫战，双倍
	gold_exchange = 2,	--金币兑换，双倍
	buy_ap = 3,			--体力购买， 双倍
	church_hook = 4,	--教堂挂机，双倍
	hight_sniper = 5,	--高速狙击，双倍
	kuikuliya = 6,		--奎库利亚, 双倍 --极限挑战
	hurdle_normal = 7,	--普通关卡，双倍
	hurdle_elite = 8,	--精英关卡，双倍
	xiaochoujihu = 9, 	--小丑计划, 双倍
}

ENUM.RoleCardPlayMethodHPType = 
{
	ExpeditionTrial = 1, --远征试炼
	MMO 			= 2, --MMO
	GuildWar 		= 3, --社团战
}

ENUM.GuildWarPhase = 
{
    Normal = 1,    --布防前及进攻后
	Defence = 2,   --布防
    Interval = 3,  --布防后间隔
    Attack = 4,    --进攻
    Max = 4
}

--公用UI底图资源
ENUM.PublicBgImage = 
{
	DLD = "assetbundles/prefabs/ui/image/backgroud/da_luan_dou/dld_beijing.assetbundle",
	DLD2 = "assetbundles/prefabs/ui/image/backgroud/da_luan_dou/dld_beijing2.assetbundle",
	DLDJS = "assetbundles/prefabs/ui/image/backgroud/da_luan_dou/dld_juese.assetbundle",
	JJ = "assetbundles/prefabs/ui/image/backgroud/game_play/jj_beijing.assetbundle",
	GQ1 = "assetbundles/prefabs/ui/image/backgroud/guan_ka/gq_beijing1.assetbundle",
	GQ2 = "assetbundles/prefabs/ui/image/backgroud/guan_ka/gq_beijing2.assetbundle",
	STBOSS = "assetbundles/prefabs/ui/image/backgroud/guild_boss/stboss_beijing.assetbundle",
	ND  = "assetbundles/prefabs/ui/image/backgroud/egg/nd_beijing.assetbundle",
	ZR  = "assetbundles/prefabs/ui/image/backgroud/zhen_rong/zr_beijing.assetbundle",
	TVT = "assetbundles/prefabs/ui/image/backgroud/3v3/3v3_beijing1.assetbundle",
	DZ = "assetbundles/prefabs/ui/image/backgroud/vs/dz_beijing.assetbundle",
	DZ2 = "assetbundles/prefabs/ui/image/backgroud/vs/dz_beijing2.assetbundle",
	KLZ = "assetbundles/prefabs/ui/image/backgroud/ke_long_zhan/klz_beijing.assetbundle",
	SJBOSS = "assetbundles/prefabs/ui/image/backgroud/world_boss/sjboss_beijing.assetbundle",
	SJBX = "assetbundles/prefabs/ui/image/backgroud/world_box/sjbaoxiang_beijing.assetbundle",
	YZSL = "assetbundles/prefabs/ui/image/backgroud/yuan_zheng/yzsl_beijing.assetbundle",
	ZM1 = "assetbundles/prefabs/ui/image/backgroud/zhao_mu/zhaomu_beijing1.assetbundle",
	JJC = "assetbundles/prefabs/ui/image/backgroud/jjc/jjc_beijing.assetbundle",
	-- DH  = "assetbundles/prefabs/ui/image/backgroud/dao_hang_tiao/dh_beijing.assetbundle", -- 废弃
	LS = "assetbundles/prefabs/ui/image/backgroud/xunzhao_lishi/xzls_beijing.assetbundle",
	MASK = "assetbundles/prefabs/ui/image/backgroud/mian_ju_dian/mjd_beijing.assetbundle",
	MASK2 = "assetbundles/prefabs/ui/image/backgroud/mian_ju_dian/mjd_beijing2.assetbundle",
}

ENUM.FightKeyFrameType = 
{
	FightBegin = 0,
	--战斗开始 int 随机种子;玩法类型;关卡ID
	CreateHero = 1,
	--创建英雄 int 英雄ID;英雄等级;英雄GID;x坐标;z坐标;阵营
	UseSkill = 2,
	--使用技能 int 技能ID;施放者x坐标;施放者z坐标;施放者gid;CD类型
	CreateMonster = 3,
	--创建怪物 int 怪物ID;怪物等级;怪物GID;x坐标;z坐标;阵营
	MakeDamage = 4,
	--制造伤害 int 目标GID;目标x坐标;目标z坐标;施放者GID;施放者x坐标;施放者z坐标;技能ID;buffid;bufflv;触发器序号;效果序号;伤害值
	Translate = 5,
	--位移 int 移动者GID;移动者x坐标;移动者z坐标;是否开始;
	FightOver = 6,
	--战斗结束 int 是否胜利;星数
	ChangeAbsoluteAbility = 7,
	--改变属性绝对值 int 制造方GID;制造方x坐标;制造方z坐标;改变方GID;改变方x坐标;改变方z坐标;生效状态;技能ID;buffid;bufflv;触发器序号;效果序号;
	--				 float 改变值
	TimerStart = 8,
	--开始战斗计时
	FightPause = 9,
	--战斗暂停
	FightResume = 10,
	--战斗恢复
	ScaleAbilityMultiply = 11,
	--缩放属性乘法 int 制造方GID;制造方x坐标;制造方z坐标;改变方GID;改变方x坐标;改变方z坐标;生效状态;技能ID;buffid;bufflv;触发器序号;效果序号;
	--			   float 改变值
	ScaleAbilityAddition = 12,
	--缩放属性累加 nt 制造方GID;制造方x坐标;制造方z坐标;改变方GID;改变方x坐标;改变方z坐标;生效状态;技能ID;buffid;bufflv;触发器序号;效果序号;
	--			   float 改变值
}

ENUM.SyncObjType = 
{
	OnlyShow = 1,
	SyncMove = 2,
	FullSync = 3,
}

ENUM.ViewAngleEffectID = 
{
	angle90 = 17034,
	angle120 = 17033,
	angle360 = 17032,
}

ENUM.SkillType = 
{
	active = 0,		--主动技能
	passive = 1,	--被动技能
	halo = 2,		--光环技能
}

ENUM.EffectID = 
{
	towerAttackLock = 17039,
	towerAreaGreen = 17038,
	towerAreaYellow = 17037,
	towerAreaRed = 17036,
}

ENUM.ScoreBoxStatus =
{
	NotGet = 1,
	CanGet = 2,
	Geted = 3,
}

ENUM.ChatFightPlayerType =
{
	All = 1,		--全部
	Friend = 2,		--好友
	Guild = 3,		--同社团
	Stranger  = 4,	--陌生人
}

ENUM.ChatFightSelectState =
{
	FirstOne = 2,
	SecondTwo = 3,
	FirstTwo = 4,
	SecondOne = 5,
	Buff = 6,
}

ENUM.ChatFightAward =
{
	Fight = 0,
	Win = 1,
}

ENUM.ChatFightResult =
{
	Success = 1,
	Fail = 2,
	Draw = 3
}


