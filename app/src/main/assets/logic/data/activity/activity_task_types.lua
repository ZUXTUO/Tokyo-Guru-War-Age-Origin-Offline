--任务类型ID	任务名称	按钮类型,任务未完状态下，领取按钮的显示方式（0-灰，1-前往,2-不显示）	系统进入方法id	任务描述
g_Config.t_activity_task_types_key_ = {
	id=1,
	task_name=2,
	button_type=3,
	system_enter_id=4,
	des=5,
}
g_Config.t_activity_task_types = {
	[1] = "{1,'累计登录',2,0,gs_activity.activitytask_1,}",
	[2] = "{2,'累计钻石消耗',0,0,gs_activity.activitytask_2,}",
	[3] = "{3,'累计充值',1,62000017,gs_activity.activitytask_3,}",
	[4] = "{4,'累计金币消耗',0,0,gs_activity.activitytask_4,}",
	[5] = "{5,'累计点金，购买金币',1,62000021,gs_activity.activitytask_5,}",
	[6] = "{6,'战队等级',0,0,gs_activity.activitytask_6,}",
	[7] = "{7,'英雄等级',1,62002004,gs_activity.activitytask_7,}",
	[8] = "{8,'英雄升品',1,62002001,gs_activity.activitytask_8,}",
	[9] = "{9,'英雄升星',1,62002002,gs_activity.activitytask_9,}",
	[10] = "{10,'装备升级',1,62003000,gs_activity.activitytask_10,}",
	[11] = "{11,'装备升星',1,62003001,gs_activity.activitytask_11,}",
	[12] = "{12,'装备升品',1,62003000,gs_activity.activitytask_12,}",
	[13] = "{13,'金币招募英雄',1,62000015,gs_activity.activitytask_13,}",
	[14] = "{14,'钻石招募英雄',1,62000015,gs_activity.activitytask_14,}",
	[15] = "{15,'累计购买装备宝箱',1,62004000,gs_activity.activitytask_15,}",
	[16] = "{16,'通关指定普通副本',1,62000000,gs_activity.activitytask_16,}",
	[17] = "{17,'通关任何普通副本次数',1,62000000,gs_activity.activitytask_17,}",
	[18] = "{18,'通关指定精英副本',1,62001004,gs_activity.activitytask_18,}",
	[19] = "{19,'通关任何精英副本次数',1,62001004,gs_activity.activitytask_19,}",
	[20] = "{20,'高速狙击',1,60054001,gs_activity.activitytask_20,}",
	[21] = "{21,'保卫战',1,60054006,gs_activity.activitytask_21,}",
	[22] = "{22,'竟计场',1,60054014,gs_activity.activitytask_22,}",
	[23] = "{23,'3v3胜利次数',1,60054021,gs_activity.activitytask_23,}",
	[24] = "{24,'3v3参与次数',1,60054021,gs_activity.activitytask_24,}",
	[25] = "{25,'大乱斗参与次数',1,60054027,gs_activity.activitytask_25,}",
	[26] = "{26,'购买体力',1,62000020,gs_activity.activitytask_26,}",
	[27] = "{27,'拥有指定星级英雄数量',0,0,gs_activity.activitytask_27,}",
	[28] = "{28,'拥用指定品质英雄数量',0,0,gs_activity.activitytask_28,}",
	[29] = "{29,'拥有指定职业英雄数量',0,0,gs_activity.activitytask_29,}",
	[30] = "{30,'通关极限挑战多少层',1,60054010,gs_activity.activitytask_30,}",
	[31] = "{31,'极限挑战开启N次',1,60054010,gs_activity.activitytask_31,}",
	[32] = "{32,'小丑计划N次',1,60054023,gs_activity.activitytask_32,}",
	[33] = "{33,'捕食场N次',1,60054030,gs_activity.activitytask_33,}",
	[34] = "{34,'竞技场排名前几名',1,60054014,gs_activity.activitytask_34,}",
	[35] = "{35,'拥有品质装备的个数',0,0,gs_activity.activitytask_35,}",
	[36] = "{36,'拥有多少星级装备的个数',0,0,gs_activity.activitytask_36,}",
	[37] = "{37,'捕食积分',1,60054030,gs_activity.activitytask_37,}",
	[38] = "{38,'技能升级次数',1,62002003,gs_activity.activitytask_38,}",
	[39] = "{39,'培养次数',1,62001002,gs_activity.activitytask_39,}",
	[40] = "{40,'社团捐献',1,62000010,gs_activity.activitytask_40,}",
}
return {key = g_Config.t_activity_task_types_key_, data = g_Config.t_activity_task_types } 
 -- 