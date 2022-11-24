--id	描述	可兑换次数	需要的道具	获得的道具
g_Config.t_exchange_item_key_ = {
	id=1,
	des=2,
	times=3,
	need_items=4,
	have_item=5,
}
g_Config.t_exchange_item = {
	[1] = "{1,gs_activity.exchange_1,2,{{item_id = 3,item_num = 800,is_line = 0,},},{{item_id = 24880034,item_num = 1,is_line = 1,},},}",
	[2] = "{2,gs_activity.exchange_2,2,{{item_id = 3,item_num = 1200,is_line = 0,},},{{item_id = 24880035,item_num = 1,is_line = 1,},},}",
	[3] = "{3,gs_activity.exchange_3,2,{{item_id = 3,item_num = 1200,is_line = 0,},},{{item_id = 24880036,item_num = 1,is_line = 1,},},}",
	[4] = "{4,gs_activity.exchange_4,2,{{item_id = 3,item_num = 1200,is_line = 0,},},{{item_id = 24880037,item_num = 1,is_line = 1,},},}",
	[5] = "{5,gs_activity.exchange_5,2,{{item_id = 3,item_num = 1200,is_line = 0,},},{{item_id = 24880038,item_num = 1,is_line = 1,},},}",
	[6] = "{6,gs_activity.exchange_6,30,{{item_id = 3,item_num = 300,is_line = 0,},},{{item_id = 24880039,item_num = 1,is_line = 1,},},}",
	[7] = "{7,gs_activity.exchange_7,8,{{item_id = 3,item_num = 500,is_line = 0,},},{{item_id = 24880040,item_num = 1,is_line = 1,},},}",
	[8] = "{8,gs_activity.exchange_8,8,{{item_id = 3,item_num = 500,is_line = 0,},},{{item_id = 24880041,item_num = 1,is_line = 1,},},}",
	[9] = "{9,gs_activity.exchange_9,4,{{item_id = 3,item_num = 200,is_line = 0,},},{{item_id = 24880032,item_num = 1,is_line = 0,},},}",
	[10] = "{10,gs_activity.exchange_10,8,{{item_id = 3,item_num = 200,is_line = 0,},},{{item_id = 24880033,item_num = 1,is_line = 0,},},}",
	[11] = "{11,gs_activity.exchange_11,10,{{item_id = 3,item_num = 5,is_line = 0,},},{{item_id = 20003005,item_num = 10,is_line = 0,},},}",
	[12] = "{12,gs_activity.exchange_12,10,{{item_id = 3,item_num = 5,is_line = 0,},},{{item_id = 20000024,item_num = 10,is_line = 0,},},}",
}
return {key = g_Config.t_exchange_item_key_, data = g_Config.t_exchange_item } 
 -- 