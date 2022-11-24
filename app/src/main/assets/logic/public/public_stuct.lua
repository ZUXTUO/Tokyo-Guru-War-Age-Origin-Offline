--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/6
-- Time: 16:33
-- To change this template use File | Settings | File Templates.
--

PublicStruct = {};

--[[常用常量]]
PublicStruct.Const = {
	HERO_MAX_STAR = 7,--英雄最大星级
	HERO_QH_LEVEL = 5,--潜能强化等级
	EQUIP_MAX_QULITY_LEVEL = 5,--装备最高品质等级
	EQUIP_MAX_STAR = 5,--装备最高星级
	PACKAGE_MAX_USE = 100,--背包中最大使用数量
	MAX_COUNTRY_CNT = 3;--国家总数
	ATTACK_VIEW_RADIUS = 10,
	SHOW_MONSTER_HP_RADIUS = 10,
	--LOADING_ASSETBUNDLE = "assetbundles/prefabs/ui/loading/ui_loading_vs.assetbundle", --通用加载界面
	HERO_SCALE = 1.2,
	MONSTER_SCALE = 1.1,
	BOSS_SCALE = 1.2,
	SEARCH_OBJ_RADIUS_OFFSET = 1,
	ATTRIBUTE_VERIFY_RATE = 10000,
	MAX_CARD_LEVEL = 100,
	APERTURE_ADD_RADIUS = 0.88,
	APERTURE_ADD_RADIUS_EX = 1.48,
	MAX_NORMAL_ATTACK_INDEX = 5,
	SPECIAL_HURDLE_SKILL = 9,
	RANDOM_SCALE = 1000,
	UI_CLOSE_DELAY = 0.2,
}
--[[数据类型]]
PublicStruct.type_list = {
	[1] = "nil";
	[2] = "number";
	[3] = "string";
	[4] = "table";
	[5] = "function";
};

--[[层次]]
PublicStruct.UnityLayer = {
	Default = 0,
	TransparentFx = 1,
	IgnoreRatcast = 2,
	player = 8,--[[角色]]
	npc = 9,--[[NPC]]
	monster = 10,--[[怪]]

	weapon = 12,--[[武器]]
	shadow = 14, --[[影子]]
	terrain = 15,--[[地形]]
	building = 16,--[[美术用场景建筑层]]
	building_item = 17,--[[美术用场景物件层]]
	ground = 18,--[[美术用地表层]]
	reflection = 19, --[[反射层]]
	ground_item = 20, -- 地面的道具

    camera_wall = 21, --镜头墙

	pick = 22,--[[角色点击操作钢体]]

	camera = 24,--[[像机]]
	s3d = 26,--[[3DUI]]
	ngui = 27,--[[ngui界面]]
	guide = 28, --[[新手引导]]
	ui3d = 29, --[[血条]]

	water=4,
}

--[导航网格层级]
PublicStruct.NavigationAreas = 
{
	walkable = 0,
	not_walk_able = 1,
	jump = 2,
	monster_only = 3,
}

--[[系统版本OS]]
PublicStruct.App_OS_Type = {
	OSXEditor = 0,
	OSXPlayer = 1,
	WindowsPlayer = 2,
	OSXWebPlayer = 3,
	OSXDashboardPlayer = 4,
	WindowsWebPlayer = 5,
	WindowsEditor = 7,
	IPhonePlayer = 8,
	Android = 11,
};

--[[系统网络版本]]
PublicStruct.App_NetWork_TYpe = {
	NotReachable = 0;--[[0无网]]
	ReachableViaCarrierDataNetwork = 1;--[[1移动]]
	ReachableViaLocalAreaNetwork = 2;--[[2WIFI]]
};

--[[聊天]]
PublicStruct.Chat = {
	all = 1,        --全部
    horn = 2,       --喇叭
	area = 3,       --区域
    guild = 4,      --公会
    team = 5,       --队伍
    whisper = 6,    --私聊
    world = 7,      --世界	
	system = 8,     --系统
	fight = 9,		--聊天约战
}

--[[聊天类型]]
PublicStruct.Chat_Type = {
	text = 1,       --文本
    voice = 2       --语音
}

--开启英雄跟随AI
PublicStruct.Open_Follow = true
--动画帧率
PublicStruct.Anim_Frame_Rate = 30
PublicStruct.MS_Each_Anim_Frame = 1000/30
--战斗同步方式
PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
--[[帧同步相关]]
--当前逻辑帧数,帧率
PublicStruct.Cur_Logic_Frame = 1
PublicStruct.Logic_Frame_Rate = 30
PublicStruct.MS_Each_Frame = 1000/PublicStruct.Logic_Frame_Rate
PublicStruct.S_Each_Frame = 1/PublicStruct.Logic_Frame_Rate
PublicStruct.Start_RecordScript_Time = 0
PublicStruct.Role_Cards_Index = 1
--当前是否PVP
PublicStruct.PVP_MODE = 1
--智能施法
PublicStruct.Intelligent_Skill = true
--替代模型
PublicStruct.Temp_Model_File = "assetbundles/prefabs/character/ch_base/ch_base_fbx.assetbundle"
--坐标缩放
PublicStruct.Coordinate_Scale = 10
PublicStruct.Coordinate_Scale_Decimal = 0.1
--恢复技能ID
PublicStruct.Recover_Skill_ID = 118
PublicStruct.Buff_GID_Creator = 1
PublicStruct.MMO_LEAVE_FIGHT_STATE_TIME = 10000
--是否是数值测试
PublicStruct.ShuZhiCeShi = false;
--每日重置时间点
PublicStruct.DayResetTime = 5;

Const =  PublicStruct.Const



