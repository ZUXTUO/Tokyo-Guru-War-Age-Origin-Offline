--id	累计天数	奖励，格式（item_id=1;num=100|item_id=2;num=112|
g_Config.t_month_total_key_ = {
	id=1,
	total_days=2,
	award_items=3,
}
g_Config.t_month_total = {
	[1] = "{1,3,{{item_id = 3,num = 100,},{item_id = 2,num = 100000,},{item_id = 20000024,num = 3,},},}",
	[2] = "{2,6,{{item_id = 3,num = 100,},{item_id = 2,num = 100000,},{item_id = 20000024,num = 6,},},}",
	[3] = "{3,10,{{item_id = 3,num = 120,},{item_id = 2,num = 150000,},{item_id = 20000024,num = 10,},},}",
	[4] = "{4,15,{{item_id = 3,num = 120,},{item_id = 2,num = 150000,},{item_id = 20000024,num = 15,},},}",
	[5] = "{5,20,{{item_id = 3,num = 150,},{item_id = 2,num = 200000,},{item_id = 20000024,num = 20,},},}",
	[6] = "{6,30,{{item_id = 3,num = 200,},{item_id = 2,num = 250000,},{item_id = 20000024,num = 30,},},}",
	[7] = "{7,40,{{item_id = 3,num = 200,},{item_id = 2,num = 300000,},{item_id = 20000024,num = 30,},},}",
	[8] = "{8,50,{{item_id = 3,num = 200,},{item_id = 2,num = 350000,},{item_id = 20000024,num = 30,},},}",
	[9] = "{9,60,{{item_id = 3,num = 300,},{item_id = 2,num = 400000,},{item_id = 20000024,num = 30,},},}",
}
return {key = g_Config.t_month_total_key_, data = g_Config.t_month_total } 
 -- 