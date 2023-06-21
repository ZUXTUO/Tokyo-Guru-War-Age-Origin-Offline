--编号	描述	玩法类型（对应表activity_task_types.txt)的id	解锁方式，现在确认只会按等级，先预留,全填2就行	解锁参数1	解锁参数2	需要的次数	头像图片路径	玩法标题	奖励
g_Config.t_subscribe_key_ = {
	id=1,
	des=2,
	task_type=3,
	unlock_type=4,
	unlock_param1=5,
	unlock_param2=6,
	need_times=7,
	texture_path=8,
	title_name=9,
	awards=10,
}
g_Config.t_subscribe = {
	[1] = "{1,'',17,2,10,0,3,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_3v3gongfangzhan.assetbundle',gs_activity.name_1,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[2] = "{2,'',20,2,30,0,4,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_baoweizhan.assetbundle',gs_activity.name_2,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[3] = "{3,'',21,2,31,0,5,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_gaosuzuji.assetbundle',gs_activity.name_3,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[4] = "{4,'',22,2,40,0,6,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_jiaotangguaji.assetbundle',gs_activity.name_1,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[5] = "{5,'',23,2,41,0,7,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_jingjichang.assetbundle',gs_activity.name_2,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[6] = "{6,'',24,2,42,0,8,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_3v3gongfangzhan.assetbundle',gs_activity.name_3,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[7] = "{7,'',25,2,43,0,9,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_3v3gongfangzhan.assetbundle',gs_activity.name_1,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[8] = "{8,'',32,2,44,0,10,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_3v3gongfangzhan.assetbundle',gs_activity.name_1,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[9] = "{9,'',33,2,45,0,11,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_3v3gongfangzhan.assetbundle',gs_activity.name_1,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[10] = "{10,'',8,2,46,0,12,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_3v3gongfangzhan.assetbundle',gs_activity.name_1,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
	[11] = "{11,'',9,2,47,0,13,'assetbundles/prefabs/ui/image/backgroud/gong_neng_yugao/gnyg_3v3gongfangzhan.assetbundle',gs_activity.name_1,{{item_id = 1,item_num = 3,is_line = 1,},{item_id = 2,item_num = 10,is_line = 0,},},}",
}
return {key = g_Config.t_subscribe_key_, data = g_Config.t_subscribe } 
 -- 