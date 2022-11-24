--基金id	标题	描述	需达到的等级	道具ID	领取钻石个数	是否有特效
g_Config.t_level_fund_key_ = {
	id=1,
	level_tittle=2,
	level_dec=3,
	need_level=4,
	item_id=5,
	num=6,
	is_line=7,
}
g_Config.t_level_fund = {
	[1] = "{1,gs_activity.rebatetitle_1,gs_activity.rebatedec_1,15,21000203,300,0,}",
	[2] = "{2,gs_activity.rebatetitle_2,gs_activity.rebatedec_2,20,21000203,300,0,}",
	[3] = "{3,gs_activity.rebatetitle_3,gs_activity.rebatedec_3,25,21000203,400,0,}",
	[4] = "{4,gs_activity.rebatetitle_4,gs_activity.rebatedec_4,30,21000203,500,0,}",
	[5] = "{5,gs_activity.rebatetitle_5,gs_activity.rebatedec_5,35,21000203,500,0,}",
	[6] = "{6,gs_activity.rebatetitle_6,gs_activity.rebatedec_6,40,21000204,600,0,}",
	[7] = "{7,gs_activity.rebatetitle_7,gs_activity.rebatedec_7,45,21000204,700,0,}",
	[8] = "{8,gs_activity.rebatetitle_8,gs_activity.rebatedec_8,50,21000204,800,0,}",
	[9] = "{9,gs_activity.rebatetitle_9,gs_activity.rebatedec_9,55,21000204,900,0,}",
	[10] = "{10,gs_activity.rebatetitle_10,gs_activity.rebatedec_10,60,21000205,1000,0,}",
	[11] = "{11,gs_activity.rebatetitle_11,gs_activity.rebatedec_11,65,21000205,1000,0,}",
	[12] = "{12,gs_activity.rebatetitle_12,gs_activity.rebatedec_12,70,21000205,1000,0,}",
}
return {key = g_Config.t_level_fund_key_, data = g_Config.t_level_fund } 
 -- 