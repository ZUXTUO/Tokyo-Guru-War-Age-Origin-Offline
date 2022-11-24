--奖励id	什么时间以后才能领取	需达到的分值	奖励
g_Config.t_sign_in_total_award_back_key_ = {
	id=1,
	get_time=2,
	finish_scores=3,
	award_items=4,
}
g_Config.t_sign_in_total_award_back = {
	[1] = "{1,7,10,{{item_id = 20002011,item_num = 10,},},}",
	[2] = "{2,7,20,{{item_id = 20002011,item_num = 20,},},}",
	[3] = "{3,7,30,{{item_id = 20002011,item_num = 30,},},}",
	[4] = "{4,7,40,{{item_id = 20002011,item_num = 40,},},}",
	[5] = "{5,7,50,{{item_id = 20002011,item_num = 50,},},}",
	[6] = "{6,7,60,{{item_id = 20002011,item_num = 60,},},}",
	[7] = "{7,7,70,{{item_id = 20002011,item_num = 70,},},}",
	[8] = "{8,7,80,{{item_id = 20002011,item_num = 80,},},}",
	[9] = "{9,7,90,{{item_id = 20002011,item_num = 90,},},}",
	[10] = "{10,7,100,{{item_id = 20002011,item_num = 100,},},}",
}
return {key = g_Config.t_sign_in_total_award_back_key_, data = g_Config.t_sign_in_total_award_back } 
 -- 