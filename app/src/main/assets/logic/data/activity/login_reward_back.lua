--id	登录次数	奖励
g_Config.t_login_reward_back_key_ = {
	id=1,
	times=2,
	award=3,
}
g_Config.t_login_reward_back = {
	[1] = "{1,1,{{item_id = 20002025,item_num = 1,is_line = 1,},{item_id = 2,item_num = 50000,is_line = 0,},{item_id = 20000065,item_num = 10,is_line = 0,},{item_id = 20000023,item_num = 10,is_line = 0,},},}",
	[2] = "{2,2,{{item_id = 20002025,item_num = 1,is_line = 1,},{item_id = 2,item_num = 80000,is_line = 0,},{item_id = 20000065,item_num = 10,is_line = 0,},{item_id = 20000023,item_num = 10,is_line = 0,},},}",
	[3] = "{3,3,{{item_id = 20002025,item_num = 2,is_line = 1,},{item_id = 2,item_num = 100000,is_line = 0,},{item_id = 20000065,item_num = 10,is_line = 0,},{item_id = 20000023,item_num = 10,is_line = 0,},},}",
}
return {key = g_Config.t_login_reward_back_key_, data = g_Config.t_login_reward_back } 
 -- 