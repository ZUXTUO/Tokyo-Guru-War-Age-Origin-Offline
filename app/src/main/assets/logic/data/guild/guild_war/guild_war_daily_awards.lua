--社团战名次	策划备注	排行奖励	额外参与奖励
g_Config.t_guild_war_daily_awards_key_ = {
	id=1,
	awards=2,
	awards_ex=3,
}
g_Config.t_guild_war_daily_awards = {
	[1] = "{1,{{id = 2,count = 50000,},{id = 20000125,count = 500,},{id = 20000023,count = 15,},},{id = 20000323,count = 15,},}",
	[2] = "{2,{{id = 2,count = 30000,},{id = 20000125,count = 400,},{id = 20000023,count = 10,},},{id = 20000323,count = 10,},}",
	[3] = "{3,{{id = 2,count = 10000,},{id = 20000125,count = 300,},{id = 20000023,count = 5,},},{id = 20000323,count = 5,},}",
}
return {key = g_Config.t_guild_war_daily_awards_key_, data = g_Config.t_guild_war_daily_awards } 
 -- 