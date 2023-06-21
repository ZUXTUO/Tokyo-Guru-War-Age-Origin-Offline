--id	描述	可兑换次数	需要的道具	获得的道具
g_Config.t_exchange_item_key_ = {
	id=1,
	des=2,
	times=3,
	need_items=4,
	have_item=5,
}
g_Config.t_exchange_item = {
	[1] = "{1,gs_activity.recruit_1,3,{{item_id = 1,item_num = 10,is_line = 0,},{item_id = 2,item_num = 20,is_line = 1,},},{{item_id = 1,item_num = 10,is_line = 0,},},}",
	[2] = "{2,gs_activity.recruit_1,4,{{item_id = 1,item_num = 10,is_line = 0,},{item_id = 2,item_num = 20,is_line = 1,},},{{item_id = 1,item_num = 10,is_line = 0,},},}",
	[3] = "{3,gs_activity.recruit_1,6,{{item_id = 1,item_num = 10,is_line = 0,},{item_id = 2,item_num = 20,is_line = 1,},},{{item_id = 1,item_num = 10,is_line = 0,},},}",
	[4] = "{4,gs_activity.recruit_1,7,{{item_id = 1,item_num = 10,is_line = 0,},{item_id = 2,item_num = 20,is_line = 1,},},{{item_id = 1,item_num = 10,is_line = 0,},},}",
	[5] = "{5,gs_activity.recruit_1,8,{{item_id = 1,item_num = 10,is_line = 0,},{item_id = 2,item_num = 20,is_line = 1,},},{{item_id = 1,item_num = 10,is_line = 0,},},}",
	[6] = "{6,gs_activity.recruit_1,9,{{item_id = 1,item_num = 10,is_line = 0,},{item_id = 2,item_num = 20,is_line = 1,},},{{item_id = 1,item_num = 10,is_line = 0,},},}",
	[7] = "{7,gs_activity.recruit_1,13,{{item_id = 1,item_num = 10,is_line = 0,},{item_id = 2,item_num = 20,is_line = 1,},},{{item_id = 1,item_num = 10,is_line = 0,},},}",
	[8] = "{8,gs_activity.recruit_1,16,{{item_id = 1,item_num = 10,is_line = 0,},{item_id = 2,item_num = 20,is_line = 1,},},{{item_id = 1,item_num = 10,is_line = 0,},},}",
}
return {key = g_Config.t_exchange_item_key_, data = g_Config.t_exchange_item } 
 -- 