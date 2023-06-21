--id	区间下限大于等于此项	区间上限小于等于此项	需要达到的战力	未达到战力的奖励	奖励
g_Config.t_rank_activity_award_key_ = {
	id=1,
	limit_lower=2,
	limit_upper=3,
	need_power=4,
	need_award=5,
	award=6,
}
g_Config.t_rank_activity_award = {
	[1] = "{1,1,1,20000,0,{{item_id = 30054300,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 6,is_line = 0,},{item_id = 20000112,item_num = 10,is_line = 0,},},}",
	[2] = "{2,2,2,20000,0,{{item_id = 30054200,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 6,is_line = 0,},{item_id = 20000112,item_num = 10,is_line = 0,},},}",
	[3] = "{3,3,3,20000,0,{{item_id = 30054100,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 6,is_line = 0,},{item_id = 20000112,item_num = 10,is_line = 0,},},}",
	[4] = "{4,4,4,20000,0,{{item_id = 30020300,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 5,is_line = 0,},{item_id = 20000112,item_num = 10,is_line = 0,},},}",
	[5] = "{5,5,5,20000,0,{{item_id = 30020200,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 5,is_line = 0,},{item_id = 20000024,item_num = 10,is_line = 0,},},}",
	[6] = "{6,6,6,20000,0,{{item_id = 30020100,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 5,is_line = 0,},{item_id = 20000024,item_num = 10,is_line = 0,},},}",
	[7] = "{7,7,7,20000,0,{{item_id = 24880024,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 4,is_line = 0,},{item_id = 20000024,item_num = 10,is_line = 0,},},}",
	[8] = "{8,8,8,20000,0,{{item_id = 24880024,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 3,is_line = 0,},{item_id = 20000024,item_num = 10,is_line = 0,},},}",
	[9] = "{9,9,9,20000,0,{{item_id = 24880024,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 2,is_line = 0,},{item_id = 20000024,item_num = 10,is_line = 0,},},}",
	[10] = "{10,10,10,20000,0,{{item_id = 24880024,item_num = 1,is_line = 1,},{item_id = 20000006,item_num = 1,is_line = 0,},{item_id = 20000024,item_num = 10,is_line = 0,},},}",
}
return {key = g_Config.t_rank_activity_award_key_, data = g_Config.t_rank_activity_award } 
 -- 