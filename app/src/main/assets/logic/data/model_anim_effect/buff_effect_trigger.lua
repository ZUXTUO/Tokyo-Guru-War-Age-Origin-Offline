--buffid	自己身上的成功触发特效	自己身上的触发失败特效（特效编号，绑定位置，持续时间）	对方身上的成功触发特效	对方身上的失败触发特效	备注	没有的就填0就可以了
g_Config.t_buff_effect_trigger_key_ = {
	buffid=1,
	success_effect=2,
	fail_effect=3,
	target_suc_eff=4,
	target_fail_eff=5,
}
g_Config.t_buff_effect_trigger = {
	[5] = "{5,{effect_id = 400010,pos = 3,autoRelaseTime = 0,},{effect_id = 400010,pos = 3,},0,{effect_id = 400013,pos = 3,autoRelaseTime = 1.5,},}",
	[6] = "{6,{effect_id = 400010,pos = 3,},{effect_id = 400010,pos = 3,},0,{effect_id = 400013,pos = 3,autoRelaseTime = 1.5,},}",
	[1] = "{1,{effect_id = 400002,pos = 3,},0,0,0,}",
	[2] = "{2,{{effect_id = 400002,pos = 3,},{effect_id = 300103,pos = 2,},},0,0,0,}",
	[3] = "{3,{effect_id = 400001,pos = 3,},0,0,0,}",
	[4] = "{4,{effect_id = 400001,pos = 3,},0,0,0,}",
}
return {key = g_Config.t_buff_effect_trigger_key_, data = g_Config.t_buff_effect_trigger } 
 -- 