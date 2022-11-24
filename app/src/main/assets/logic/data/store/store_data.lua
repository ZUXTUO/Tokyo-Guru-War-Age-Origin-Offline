--商品索引	渠道对应ID	商品名字	商品类型(1道具 2商城卡 3 一元购)	商品内容	商品数量	商品价格（以分为单位）	商品价格折扣(1-100)	商品icon	商品描述	小标签(1推荐2打折3热销(hot)4限购5限时)	购买次数	是否上架	增加的VIP经验	奖励
g_Config.t_store_data_key_ = {
	id=1,
	channel_id=2,
	name=3,
	type=4,
	content=5,
	num=6,
	price=7,
	discount=8,
	icon=9,
	describe=10,
	tag=11,
	buy_times_limit=12,
	is_sell=13,
	vip_exp=14,
	reward=15,
}
g_Config.t_store_data = {
	[1] = "{1,{{channel = 10018,id = 150019,},},49,1,3,6480,64800,100,'cz_hongshuijing6',50,1,0,1,6480,{{id = 20000137,num = 648,},{id = 20000137,num = 162,},},}",
	[2] = "{2,{{channel = 10018,id = 150020,},},47,1,3,3280,32800,100,'cz_hongshuijing5',48,1,0,1,3280,{{id = 20000137,num = 328,},{id = 20000137,num = 66,},},}",
	[3] = "{3,{{channel = 10018,id = 150021,},},45,1,3,1980,19800,100,'cz_hongshuijing4',46,1,0,1,1980,{{id = 20000137,num = 198,},{id = 20000137,num = 30,},},}",
	[4] = "{4,{{channel = 10018,id = 150022,},},43,1,3,980,9800,100,'cz_hongshuijing3',44,1,0,1,980,{{id = 20000137,num = 98,},{id = 20000137,num = 10,},},}",
	[5] = "{5,{{channel = 10018,id = 150023,},},41,1,3,300,3000,100,'cz_hongshuijing2',42,1,0,1,300,{{id = 20000137,num = 30,},{id = 20000137,num = 2,},},}",
	[6] = "{6,{{channel = 10018,id = 150024,},},39,1,3,60,600,100,'cz_hongshuijing1',40,1,0,1,60,{{id = 20000137,num = 6,},},}",
	[7] = "{7,{{channel = 10018,id = 150034,},},81,3,1,10,100,100,0,82,1,0,1,10,{{id = 20000137,num = 1,},},}",
}
return {key = g_Config.t_store_data_key_, data = g_Config.t_store_data } 
 -- 