--关卡id	英雄随机出生点	BOSS信息	BOSS出场时间（秒）	死亡复活时间(rs时间下限 re时间上限 t复活时间）
g_Config.t_hurdle_trial_boss_key_ = {
	hurdle=1,
	hero_born_pos=2,
	boss_info=3,
	boss_enter_time=4,
	relive_time=5,
}
g_Config.t_hurdle_trial_boss = {
	[60126003] = "{60126003,{{'hbp_1_1','hbp_1_2','hbp_1_3',},{'hbp_2_1','hbp_2_2','hbp_2_3',},},{id = 31620420,obj_name = 'boss',},2,{{rs = 0,re = 10,t = 3,},{rs = 11,re = 20,t = 5,},{rs = 21,re = 30,t = 7,},{rs = 31,re = 9999,t = 10,},},}",
	[60126007] = "{60126007,{{'hbp_1_1','hbp_1_2','hbp_1_3',},{'hbp_2_1','hbp_2_2','hbp_2_3',},},{id = 31620820,obj_name = 'boss',},2,{{rs = 0,re = 10,t = 3,},{rs = 11,re = 20,t = 5,},{rs = 21,re = 30,t = 7,},{rs = 31,re = 9999,t = 10,},},}",
	[60126011] = "{60126011,{{'hbp_1_1','hbp_1_2','hbp_1_3',},{'hbp_2_1','hbp_2_2','hbp_2_3',},},{id = 31621220,obj_name = 'boss',},2,{{rs = 0,re = 10,t = 3,},{rs = 11,re = 20,t = 5,},{rs = 21,re = 30,t = 7,},{rs = 31,re = 9999,t = 10,},},}",
	[60126015] = "{60126015,{{'hbp_1_1','hbp_1_2','hbp_1_3',},{'hbp_2_1','hbp_2_2','hbp_2_3',},},{id = 31621620,obj_name = 'boss',},2,{{rs = 0,re = 10,t = 3,},{rs = 11,re = 20,t = 5,},{rs = 21,re = 30,t = 7,},{rs = 31,re = 9999,t = 10,},},}",
	[60126019] = "{60126019,{{'hbp_1_1','hbp_1_2','hbp_1_3',},{'hbp_2_1','hbp_2_2','hbp_2_3',},},{id = 31622020,obj_name = 'boss',},2,{{rs = 0,re = 10,t = 3,},{rs = 11,re = 20,t = 5,},{rs = 21,re = 30,t = 7,},{rs = 31,re = 9999,t = 10,},},}",
	[60126023] = "{60126023,{{'hbp_1_1','hbp_1_2','hbp_1_3',},{'hbp_2_1','hbp_2_2','hbp_2_3',},},{id = 31622420,obj_name = 'boss',},2,{{rs = 0,re = 10,t = 3,},{rs = 11,re = 20,t = 5,},{rs = 21,re = 30,t = 7,},{rs = 31,re = 9999,t = 10,},},}",
	[60126027] = "{60126027,{{'hbp_1_1','hbp_1_2','hbp_1_3',},{'hbp_2_1','hbp_2_2','hbp_2_3',},},{id = 31622820,obj_name = 'boss',},2,{{rs = 0,re = 10,t = 3,},{rs = 11,re = 20,t = 5,},{rs = 21,re = 30,t = 7,},{rs = 31,re = 9999,t = 10,},},}",
}
return {key = g_Config.t_hurdle_trial_boss_key_, data = g_Config.t_hurdle_trial_boss } 
 -- 