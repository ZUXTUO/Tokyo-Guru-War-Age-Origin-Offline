--ID	开服过后多少天开启活动	一个赛季几周	战斗开始星期几(0-6 表示星期日到星期六)	战斗结束星期几(0-6 表示星期日到星期六)	数据保存到星期几(0-6)	数据保存到当天的几点(0-23)	周积分转换为玩法积分系数	玩法积分重置数	攻击增加值	攻击buff图标	防御增加值	防御buff图标	暴击增加值	暴击buff图标	金币鼓励基础次数	金币鼓励单次花费	钻石鼓励基础次数	钻石鼓励单次花费
g_Config.t_guild_war_discrete_key_ = {
	id=1,
	openDeltaDay=2,
	weeksOfSeason=3,
	beginDayOfWeek=4,
	endDayOfWeek=5,
	keepDataDay=6,
	keepDataHour=7,
	scoreFactor=8,
	playerScoreResetNum=9,
	attack_value=10,
	attack_icon=11,
	defense_value=12,
	defense_icon=13,
	crit_value=14,
	crit_icon=15,
	gold_times=16,
	gold_cost=17,
	crystal_times=18,
	crystal_cost=19,
}
g_Config.t_guild_war_discrete = {
	[1] = "{1,5,5,1,6,0,12,1,1000,100,'yzsl_baoji',100,'yzsl_gedangshanghaitu',100,'yzsl_shengmingzhitu',2,1000,2,10,}",
}
return {key = g_Config.t_guild_war_discrete_key_, data = g_Config.t_guild_war_discrete } 
 -- 