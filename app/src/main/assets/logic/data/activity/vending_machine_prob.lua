--区间id	概率	区间最小概率	区间最大概率
g_Config.t_vending_machine_prob_key_ = {
	id=1,
	section_prob=2,
	min_prob=3,
	max_prob=4,
}
g_Config.t_vending_machine_prob = {
	[1] = "{1,0.1,0.2,0.5,}",
	[2] = "{2,0.1,0.5,0.7,}",
	[3] = "{3,0.5,0.6,0.8,}",
	[4] = "{4,0.3,0.7,1,}",
}
return {key = g_Config.t_vending_machine_prob_key_, data = g_Config.t_vending_machine_prob } 
 -- 