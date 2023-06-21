--编号	等级下限	等级上限	掉落ID
g_Config.t_score_hero_rank_reward_key_ = {
	index=1,
	level_low=2,
	level_hight=3,
	reward=4,
}
g_Config.t_score_hero_rank_reward = {
	[1] = "{1,1,1,{{item_id = 3,item_num = 50,},{item_id = 20000006,item_num = 1,},{item_id = 30029300,item_num = 1,},},}",
	[2] = "{2,2,5,{{item_id = 3,item_num = 50,},{item_id = 20000006,item_num = 1,},{item_id = 30029200,item_num = 1,},},}",
	[3] = "{3,6,10,{{item_id = 3,item_num = 50,},{item_id = 20000006,item_num = 1,},{item_id = 30029100,item_num = 1,},},}",
	[4] = "{4,11,20,{{item_id = 3,item_num = 50,},{item_id = 20000006,item_num = 1,},{item_id = 20002029,item_num = 50,},},}",
	[5] = "{5,21,35,{{item_id = 3,item_num = 50,},{item_id = 20000006,item_num = 1,},{item_id = 20002029,item_num = 40,},},}",
	[6] = "{6,36,45,{{item_id = 3,item_num = 50,},{item_id = 20000006,item_num = 1,},{item_id = 20002029,item_num = 30,},},}",
	[7] = "{7,46,50,{{item_id = 3,item_num = 50,},{item_id = 20000006,item_num = 1,},{item_id = 20002029,item_num = 20,},},}",
}
return {key = g_Config.t_score_hero_rank_reward_key_, data = g_Config.t_score_hero_rank_reward } 
 -- 