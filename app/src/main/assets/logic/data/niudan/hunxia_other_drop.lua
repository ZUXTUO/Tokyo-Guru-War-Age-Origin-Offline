--轮次ID	VIP等级	第1位置掉落	第2位置掉落	第3位置掉落	第4位置掉落	第5位置掉落	第6位置掉落	主掉落英雄ID	副掉落英雄ID	主掉落英雄描述	主掉落英雄图片
g_Config.t_hunxia_other_drop_key_ = {
	index=1,
	vip_level=2,
	dropid_1=3,
	dropid_2=4,
	dropid_3=5,
	dropid_4=6,
	dropid_5=7,
	dropid_6=8,
	mian_hero=9,
	minor_hero=10,
	des=11,
	icon=12,
}
g_Config.t_hunxia_other_drop = {
	[1] = "{1,8,101000,101010,101000,101010,101000,101010,30020300,{30005200,30023200,30004200,},gs_activity.activityhunxia1,'assetbundles/prefabs/ui/image/backgroud/hun_xia/hd_xianshizhaomu_lw.assetbundle',}",
}
return {key = g_Config.t_hunxia_other_drop_key_, data = g_Config.t_hunxia_other_drop } 
 -- 