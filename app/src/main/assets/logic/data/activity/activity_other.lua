--id	介绍(对后面参数的介绍)	参数1	参数2	参数3	参数4	参数5	参数6	参数7	参数8	参数9
g_Config.t_activity_other_key_ = {
	id=1,
	desc=2,
	parm_1=3,
	parm_2=4,
	parm_3=5,
	parm_4=6,
	parm_5=7,
	parm_6=8,
	parm_7=9,
	parm_8=10,
	parm_9=11,
}
g_Config.t_activity_other = {
	[1] = "{1,'一元购(parm_1-奖励)',{{item_id = 1,item_num = 100,},{item_id = 2,item_num = 200,},},0,0,0,0,0,0,0,0,}",
	[2] = "{2,'大小月卡(parm_1-小月卡充值金额单位分--parm_2-大月卡充值金额单位分--parm_3-小月卡持续时间单位天--parm_4-大月卡持续时间单位天)',2500,8800,30,30,0,0,0,0,0,}",
	[3] = "{3,'战斗力排行-parm_9-规则说明-parm_2-角色初始id-parm3-生命百分比-parm_4-攻击百分比-parm_5-防预百分比-parm_6-生命值-parm_7-攻击值-parm_8-防御值',0,30054300,60,80,60,2880,216,43,gs_string_rule_des['rule_des_33'],}",
	[4] = "{4,'等级基金-parm_1-需要的vip等级parm_2-需要的钻石数量',3,998,0,0,0,0,0,0,0,}",
	[5] = "{5,'订阅-parm_1-持续天数',30,30,0,0,0,0,0,0,0,}",
}
return {key = g_Config.t_activity_other_key_, data = g_Config.t_activity_other } 
 -- 