--商城卡ID	持续天数	购买赠送id	购买赠送数量
g_Config.t_store_card_key_ = {
	id=1,
	last_days=2,
	item_id=3,
	item_num=4,
}
g_Config.t_store_card = {
	[1] = "{1,30,3,250,}",
	[2] = "{2,30,3,880,}",
}
return {key = g_Config.t_store_card_key_, data = g_Config.t_store_card } 
 -- 