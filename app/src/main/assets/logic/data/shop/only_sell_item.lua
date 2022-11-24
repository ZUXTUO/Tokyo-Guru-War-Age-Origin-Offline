--商品编号id	物品编号	价格物品id	价格物品数量	策划备注
g_Config.t_only_sell_item_key_ = {
	id=1,
	item_id=2,
	sell_price_item_id=3,
	sell_price_num=4,
	b=5,
}
g_Config.t_only_sell_item = {
	[1] = "{1,20003001,2,100,'玩具汽车',}",
	[2] = "{2,20003002,2,500,'地球仪',}",
	[3] = "{3,20003003,2,1000,'钢笔',}",
	[4] = "{4,20003004,2,5000,'钞票',}",
	[5] = "{5,20003005,2,10000,'金砖',}",
}
return {key = g_Config.t_only_sell_item_key_, data = g_Config.t_only_sell_item } 
 -- 