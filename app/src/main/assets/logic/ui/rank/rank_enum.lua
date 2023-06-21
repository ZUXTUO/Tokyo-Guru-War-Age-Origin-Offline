--module("RankEnum", package.seeall)

RANK_TYPE = {};

RANK_TYPE.FIGHT = MsgEnum.ERankingListType.ERankingListType_FightScore    	--战力
RANK_TYPE.LEVEL = MsgEnum.ERankingListType.ERankingListType_Level	  		--等级
RANK_TYPE.GROUP = MsgEnum.ERankingListType.ERankingListType_GuildFightValue --社团
RANK_TYPE.ROLE = MsgEnum.ERankingListType.ERankingListType_RoleFightValue   --角色
RANK_TYPE.TRIAL = MsgEnum.ERankingListType.ERankingListType_ExpeditionTrial	--远征
RANK_TYPE.MILITARY = MsgEnum.ERankingListType.ERankingListType_Area_exploit --军衔
RANK_TYPE.WORSHIP = MsgEnum.ERankingListType.ERankingListType_Area_worship 	--膜拜
RANK_TYPE.VS3TO3 = 10001		--3V3	（临时ID，该功能排行榜未使用通用排行榜逻辑）
RANK_TYPE.GUILDBOSS = 10002		--社团BOSS	（临时ID，该功能排行榜未使用通用排行榜逻辑）
RANK_TYPE.KUIKULIYA = MsgEnum.ERankingListType.ERankingListType_KuiKuLiYa	--极限挑战
RANK_TYPE.ARENA = 10003 		--竞技场	（临时ID，该功能排行榜未使用通用排行榜逻辑）
RANK_TYPE.GOLD = 10004
RANK_TYPE.KILL = 10005
RANK_TYPE.WORLDBOSS = 90005
RANK_TYPE.HURDLESTAR = MsgEnum.ERankingListType.ERankingListType_HurdleStar	--副本星数

RANK_TYPE_NAME = {
	[RANK_TYPE.FIGHT] = "FIGHT";
	[RANK_TYPE.LEVEL] = "LEVEL";
	[RANK_TYPE.GROUP] = "GROUP";
	[RANK_TYPE.ROLE] = "ROLE";
	[RANK_TYPE.TRIAL] = "TRIAL";
	[RANK_TYPE.MILITARY] = "MILITARY";
	[RANK_TYPE.WORSHIP] = "WORSHIP";
	[RANK_TYPE.VS3TO3] = "VS3TO3";
	[RANK_TYPE.GUILDBOSS] = "GUILDBOSS";
	[RANK_TYPE.KUIKULIYA] = "KUIKULIYA";
	[RANK_TYPE.ARENA] = "ARENA";
	[RANK_TYPE.HURDLESTAR] = "HURDLESTAR";
	[RANK_TYPE.WORLDBOSS] = "WORLDBOSS";
}

RANK_NAME = {
	[RANK_TYPE.FIGHT] = "战力";
	[RANK_TYPE.LEVEL] = "等级";
	[RANK_TYPE.GROUP] = "社团";
	[RANK_TYPE.ROLE] = "最强角色";
	[RANK_TYPE.TRIAL] = "捕食场";
	[RANK_TYPE.MILITARY] = "军衔";
	[RANK_TYPE.WORSHIP] = "膜拜";
	[RANK_TYPE.VS3TO3] = "3V3攻防战";
	[RANK_TYPE.GUILDBOSS] = "社团首领";
	[RANK_TYPE.KUIKULIYA] = "极限挑战";
	[RANK_TYPE.ARENA] = "竞技场";
	[RANK_TYPE.HURDLESTAR] = "关卡星数";
	[RANK_TYPE.WORLDBOSS] = "世界首领";
}

--排行榜榜单开关
RANK_ACTIVE = 
{
	[RANK_TYPE.FIGHT] = true;
	[RANK_TYPE.LEVEL] = true;
	[RANK_TYPE.GROUP] = true;
	[RANK_TYPE.ROLE] = true;
	[RANK_TYPE.HURDLESTAR] = true;
	[RANK_TYPE.KILL] = false;
}
--消息句柄
RANK_MSG_TYPE = "RANK_MSG_TYPE";