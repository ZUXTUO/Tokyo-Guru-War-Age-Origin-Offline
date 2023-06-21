--id	循环次数	循环间隔时间(毫秒)	气泡的持续时间(毫秒)	内容
g_Config.t_speak_bubble_key_ = {
	id=1,
	loop=2,
	loop_time=3,
	duration=4,
	speak=5,
}
g_Config.t_speak_bubble = {
	[1] = "{1,1,2000,2000,{'gs_hurdle_describe.qipao_1',},}",
	[2] = "{2,1,2000,2000,{'gs_hurdle_describe.qipao_2',},}",
	[3] = "{3,1,2000,2000,{'gs_hurdle_describe.qipao_3',},}",
	[4] = "{4,1,2000,2000,{'gs_hurdle_describe.qipao_4',},}",
	[5] = "{5,1,2000,2000,{'gs_hurdle_describe.qipao_5',},}",
	[6] = "{6,1,2000,2000,{'gs_hurdle_describe.qipao_2','gs_hurdle_describe.qipao_3','gs_hurdle_describe.qipao_4',},}",
	[7] = "{7,1,2000,2000,{'gs_hurdle_describe.xcjh_1','gs_hurdle_describe.xcjh_2','gs_hurdle_describe.xcjh_3','gs_hurdle_describe.xcjh_4',},}",
	[8] = "{8,1,2000,2000,{'gs_hurdle_describe.qipao_6',},}",
	[9] = "{9,1,2000,2000,{'gs_hurdle_describe.qipao_7',},}",
	[10] = "{10,1,2000,2000,{'gs_hurdle_describe.qipao_8',},}",
	[11] = "{11,1,5000,2000,{'gs_hurdle_describe.qipao_9','gs_hurdle_describe.qipao_10',},}",
	[12] = "{12,1,2000,2000,{'gs_hurdle_describe.qipao_11',},}",
	[13] = "{13,1,2000,2000,{'gs_hurdle_describe.qipao_12',},}",
	[14] = "{14,1,2000,2000,{'gs_hurdle_describe.qipao_13',},}",
}
return {key = g_Config.t_speak_bubble_key_, data = g_Config.t_speak_bubble } 
 -- 