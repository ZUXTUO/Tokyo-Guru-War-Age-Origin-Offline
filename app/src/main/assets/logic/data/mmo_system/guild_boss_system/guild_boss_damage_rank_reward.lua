--id	排名起始	排名结束	排行奖励
g_Config.t_guild_boss_damage_rank_reward_key_ = {
	id=1,
	rank_begin=2,
	rank_end=3,
	rank_reward=4,
}
g_Config.t_guild_boss_damage_rank_reward = {
	[1] = "{1,1,1,{{id = 20000125,num = 500,},},}",
	[2] = "{2,2,2,{{id = 20000125,num = 480,},},}",
	[3] = "{3,3,3,{{id = 20000125,num = 450,},},}",
	[4] = "{4,4,4,{{id = 20000125,num = 400,},},}",
	[5] = "{5,5,5,{{id = 20000125,num = 350,},},}",
	[6] = "{6,6,6,{{id = 20000125,num = 300,},},}",
	[7] = "{7,7,7,{{id = 20000125,num = 250,},},}",
	[8] = "{8,8,8,{{id = 20000125,num = 200,},},}",
	[9] = "{9,9,9,{{id = 20000125,num = 180,},},}",
	[10] = "{10,10,10,{{id = 20000125,num = 150,},},}",
	[11] = "{11,11,9999,{{id = 20000125,num = 100,},},}",
}
return {key = g_Config.t_guild_boss_damage_rank_reward_key_, data = g_Config.t_guild_boss_damage_rank_reward } 
 -- 