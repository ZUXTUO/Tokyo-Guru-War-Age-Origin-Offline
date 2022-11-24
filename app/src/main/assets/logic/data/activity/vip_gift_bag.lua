--vip等级	礼包id	可购买次数	礼包内容	原价格	折扣价
g_Config.t_vip_gift_bag_key_ = {
	id=1,
	gift_bag_id=2,
	times=3,
	items=4,
	price=5,
	discount_price=6,
}
g_Config.t_vip_gift_bag = {
	[1] = "{1,24880042,1,{{item_id = 20000006,item_num = 1,},{item_id = 20000133,item_num = 1,},{item_id = 20000306,item_num = 1,},},999,666,}",
	[5] = "{5,24880042,3,{{item_id = 20000320,item_num = 1,},{item_id = 20000000,item_num = 1,},{item_id = 20000119,item_num = 1,},},1299,999,}",
	[7] = "{7,24880042,5,{{item_id = 20000000,item_num = 2,},{item_id = 20002025,item_num = 5,},{item_id = 20004016,item_num = 1,},},2999,2555,}",
}
return {key = g_Config.t_vip_gift_bag_key_, data = g_Config.t_vip_gift_bag } 
 -- 