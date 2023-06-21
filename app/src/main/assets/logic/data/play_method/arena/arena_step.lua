--段位编号	段位总人数	获得晋级资格是前多少名	晋级赛匹配到该段位后多少名	段位名文本
g_Config.t_arena_step_key_ = {
	step_Index=1,
	step_count=2,
	promote_rankIndex=3,
	promote_match_rankIndex=4,
	step_name=5,
}
g_Config.t_arena_step = {
	[0] = "{0,50,0,20,gs_string_arena.step_name_0,}",
	[1] = "{1,200,20,60,gs_string_arena.step_name_1,}",
	[2] = "{2,600,60,100,gs_string_arena.step_name_2,}",
	[3] = "{3,1200,100,300,gs_string_arena.step_name_3,}",
	[4] = "{4,2400,300,500,gs_string_arena.step_name_4,}",
	[5] = "{5,0,500,0,gs_string_arena.step_name_5,}",
}
return {key = g_Config.t_arena_step_key_, data = g_Config.t_arena_step } 
 -- 