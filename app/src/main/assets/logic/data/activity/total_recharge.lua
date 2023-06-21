--id	累计充值金额	奖励
g_Config.t_total_recharge_key_ = {
	id=1,
	need=2,
	award=3,
}
g_Config.t_total_recharge = {
	[1] = "{1,300,{{item_id = 20000000,item_num = 1,is_line = 1,},{item_id = 20000065,item_num = 10,is_line = 0,},{item_id = 20000126,item_num = 20,is_line = 0,},},}",
	[2] = "{2,600,{{item_id = 20000000,item_num = 1,is_line = 1,},{item_id = 20000065,item_num = 15,is_line = 0,},{item_id = 20000126,item_num = 30,is_line = 0,},},}",
	[3] = "{3,980,{{item_id = 20000000,item_num = 1,is_line = 1,},{item_id = 20000065,item_num = 20,is_line = 0,},{item_id = 20000126,item_num = 40,is_line = 0,},},}",
	[4] = "{4,1980,{{item_id = 20000000,item_num = 2,is_line = 1,},{item_id = 20000065,item_num = 25,is_line = 0,},{item_id = 20000126,item_num = 50,is_line = 0,},},}",
	[5] = "{5,3280,{{item_id = 20000000,item_num = 2,is_line = 1,},{item_id = 20000065,item_num = 30,is_line = 0,},{item_id = 20000126,item_num = 60,is_line = 0,},},}",
}
return {key = g_Config.t_total_recharge_key_, data = g_Config.t_total_recharge } 
 -- 