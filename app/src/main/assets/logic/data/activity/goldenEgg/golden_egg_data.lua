--奖励编号	策划注释	奖励几倍	第一次的概率	第二次的概率	第三次的概率
g_Config.t_golden_egg_data_key_ = {
	id=1,
	dec=2,
	reward_multiple=3,
	odds_1=4,
	odds_2=5,
	odds_3=6,
}
g_Config.t_golden_egg_data = {
	[1] = "{1,'3倍',3,70,70,0,}",
	[2] = "{2,'6倍',6,20,70,0,}",
	[3] = "{3,'10倍',10,10,30,100,}",
}
return {key = g_Config.t_golden_egg_data_key_, data = g_Config.t_golden_egg_data } 
 -- 