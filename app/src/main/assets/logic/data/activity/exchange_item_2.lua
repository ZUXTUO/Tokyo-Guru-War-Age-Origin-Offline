--id	描述	可兑换次数	需要的道具	获得的道具
g_Config.t_exchange_item_2_key_ = {
	id=1,
	des=2,
	times=3,
	need_items=4,
	have_item=5,
}
g_Config.t_exchange_item_2 = {
	[1] = "{1,gs_activity.recruit_1,1,{{item_id = 20000039,item_num = 1,is_line = 0,},},{{item_id = 20000126,item_num = 1,is_line = 0,},},}",
	[2] = "{2,gs_activity.recruit_1,1,{{item_id = 20000039,item_num = 5,is_line = 0,},},{{item_id = 20000006,item_num = 1,is_line = 1,},},}",
	[3] = "{3,gs_activity.recruit_1,1,{{item_id = 20000039,item_num = 10,is_line = 0,},},{{item_id = 20002016,item_num = 1,is_line = 1,},},}",
	[4] = "{4,gs_activity.recruit_1,1,{{item_id = 20000039,item_num = 15,is_line = 0,},},{{item_id = 20000321,item_num = 1,is_line = 1,},},}",
	[5] = "{5,gs_activity.recruit_1,1,{{item_id = 20000039,item_num = 20,is_line = 0,},},{{item_id = 20000124,item_num = 1,is_line = 1,},},}",
	[6] = "{6,gs_activity.recruit_1,1,{{item_id = 20000039,item_num = 25,is_line = 0,},},{{item_id = 20000000,item_num = 1,is_line = 1,},},}",
}
return {key = g_Config.t_exchange_item_2_key_, data = g_Config.t_exchange_item_2 } 
 -- 