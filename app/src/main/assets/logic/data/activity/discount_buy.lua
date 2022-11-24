--id	道具id	道具个数	可购买次数	原价	打折价
g_Config.t_discount_buy_key_ = {
	id=1,
	item_id=2,
	item_num=3,
	buy_times=4,
	price=5,
	dis_price=6,
}
g_Config.t_discount_buy = {
	[1] = "{1,24880025,1,10,100,60,}",
	[2] = "{2,24880026,10,10,1000,550,}",
	[3] = "{3,24880027,30,10,3000,1500,}",
}
return {key = g_Config.t_discount_buy_key_, data = g_Config.t_discount_buy } 
 -- 