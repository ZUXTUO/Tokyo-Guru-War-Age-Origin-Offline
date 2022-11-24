--id	需要达到的战力	奖励
g_Config.t_rank_power_award_key_ = {
	id=1,
	need=2,
	award=3,
}
g_Config.t_rank_power_award = {
	[1] = "{1,25000,{{item_id = 3,item_num = 50,is_line = 0,},{item_id = 20000006,item_num = 1,is_line = 0,},{item_id = 20000325,item_num = 5,is_line = 0,},},}",
	[2] = "{2,40000,{{item_id = 20002005,item_num = 5,is_line = 0,},{item_id = 3,item_num = 50,is_line = 0,},{item_id = 20000006,item_num = 1,is_line = 0,},},}",
	[3] = "{3,55000,{{item_id = 20002005,item_num = 10,is_line = 0,},{item_id = 3,item_num = 100,is_line = 0,},{item_id = 20000006,item_num = 1,is_line = 0,},},}",
	[4] = "{4,70000,{{item_id = 20002005,item_num = 20,is_line = 0,},{item_id = 3,item_num = 100,is_line = 0,},{item_id = 20000006,item_num = 1,is_line = 0,},},}",
	[5] = "{5,85000,{{item_id = 20002021,item_num = 20,is_line = 0,},{item_id = 3,item_num = 200,is_line = 0,},{item_id = 20000006,item_num = 2,is_line = 0,},},}",
	[6] = "{6,100000,{{item_id = 20002021,item_num = 30,is_line = 0,},{item_id = 3,item_num = 200,is_line = 0,},{item_id = 20000006,item_num = 2,is_line = 0,},},}",
	[7] = "{7,120000,{{item_id = 20002021,item_num = 40,is_line = 0,},{item_id = 3,item_num = 400,is_line = 0,},{item_id = 20000006,item_num = 2,is_line = 0,},},}",
}
return {key = g_Config.t_rank_power_award_key_, data = g_Config.t_rank_power_award } 
 -- 