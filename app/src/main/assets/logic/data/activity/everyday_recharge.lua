--礼包id	开启礼包充值的钱数	礼包内容	额外奖励	开始时间(s)	持续时间(s)
g_Config.t_everyday_recharge_key_ = {
	id=1,
	recharge_crystal=2,
	gift_bag=3,
	ext_award=4,
	start_time=5,
	continue_time=6,
}
g_Config.t_everyday_recharge = {
	[1] = "{1,60,{[20002019] = 5,[2] = 5000,[20000023] = 10,},0,0,0,}",
	[2] = "{2,60,{[20002019] = 5,[2] = 5000,[20000023] = 10,},0,0,0,}",
	[3] = "{3,60,{[20002019] = 10,[2] = 8000,[20000024] = 10,},0,0,0,}",
	[4] = "{4,60,{[20002019] = 10,[2] = 8000,[20000024] = 10,},0,0,0,}",
	[5] = "{5,60,{[20002019] = 10,[2] = 10000,[20000024] = 10,},{[20004019] = 1,},{y = 2016,m = 5,md = 11,h = 0,i = 0,s = 0,},864000,}",
}
return {key = g_Config.t_everyday_recharge_key_, data = g_Config.t_everyday_recharge } 
 -- 