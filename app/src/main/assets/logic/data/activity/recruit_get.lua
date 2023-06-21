--id	说明	指定角色id,初始id	获取途径(1-首充，2-招募，3-vip特权，4-活动指定页签,5为登陆送礼,6-社团商店，7-竞计场商店，8-补给商店，9-神秘商店，10-杂货商店)	获取途径参数,默认0，例如vip特权，这里就填vip等级	奖励
g_Config.t_recruit_get_key_ = {
	id=1,
	info=2,
	role_default_id=3,
	get_type=4,
	get_type_parm=5,
	award=6,
}
g_Config.t_recruit_get = {
	[1] = "{1,gs_activity.recruit_1,30003200,6,0,{{item_id = 2,item_num = 20000,is_line = 0,},},}",
	[2] = "{2,gs_activity.recruit_2,30023200,7,0,{{item_id = 2,item_num = 20000,is_line = 0,},},}",
	[3] = "{3,gs_activity.recruit_3,30008200,8,0,{{item_id = 2,item_num = 20000,is_line = 0,},},}",
	[4] = "{4,gs_activity.recruit_4,30016200,1,0,{{item_id = 2,item_num = 50000,is_line = 0,},},}",
	[5] = "{5,gs_activity.recruit_5,30007200,9,0,{{item_id = 2,item_num = 50000,is_line = 0,},},}",
	[6] = "{6,gs_activity.recruit_6,30024200,9,0,{{item_id = 2,item_num = 50000,is_line = 0,},},}",
	[7] = "{7,gs_activity.recruit_7,30018200,9,0,{{item_id = 2,item_num = 50000,is_line = 0,},},}",
	[8] = "{8,gs_activity.recruit_8,30025300,3,12,{{item_id = 2,item_num = 100000,is_line = 0,},},}",
	[9] = "{9,gs_activity.recruit_9,30027300,2,0,{{item_id = 2,item_num = 100000,is_line = 0,},},}",
	[10] = "{10,gs_activity.recruit_10,30028300,2,0,{{item_id = 2,item_num = 100000,is_line = 0,},},}",
}
return {key = g_Config.t_recruit_get_key_, data = g_Config.t_recruit_get } 
 -- 