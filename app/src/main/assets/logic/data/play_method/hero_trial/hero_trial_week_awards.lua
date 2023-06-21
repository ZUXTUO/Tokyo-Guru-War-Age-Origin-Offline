--奖励档次	累计达到天数	奖励
g_Config.t_hero_trial_week_awards_key_ = {
	id=1,
	day=2,
	drop_awards=3,
}
g_Config.t_hero_trial_week_awards = {
	[1] = "{1,3,{{id = 11,num = 1,},{id = 2,num = 100000,},{id = 20000024,num = 10,},{id = 20000311,num = 10,},},}",
	[2] = "{2,7,{{id = 11,num = 1,},{id = 2,num = 200000,},{id = 20000024,num = 20,},{id = 20000311,num = 20,},},}",
}
return {key = g_Config.t_hero_trial_week_awards_key_, data = g_Config.t_hero_trial_week_awards } 
 -- 