--vip实际等级	vip等级	星级	标题	极限挑战每日免费重置次数	极限挑战每日付费重置次数	教堂挂机额外免费次数	可购买教堂祈祷挑战次数	额外可购买体力次数	体力额外上限	关卡次数可重置次数上限	关卡是否可关卡连续扫荡10次	竞技场额外免费挑战次数	竞技场额外可购买挑战次数	十一区讨伐战开启扫荡功能	十一区讨伐战开启额外重置次数	保卫战扫荡等级	保卫战收益倍数	通灵之魂每日兑换次数	中原宝箱奖励倍数	尊享礼包	金钱礼包	灵石礼包	装备礼包	slg额外免费次数	SLG可以额外购买次数	扭蛋折扣(1代表不折扣，0.8代表8折）	世界boss里伤害加成	世界BOSS鼓舞上限	金币兑换额外次数	每日免费传送到boss处次数	每日免费复活次数	技能点恢复CD(秒)	捕食场扫荡上限(只算怪物关卡）	世界宝箱免费复活次数	竟计场是否可直接跳过（0-不能，1-可以）	竟计场战败同样获得积分数	所有需要报名的玩法是否自动参与	关卡几星可扫荡	是否开启关卡50次扫荡功能	高速阻击金币产出增加，百分位（10）	高速狙击间隔冷却时间	开启教堂挂机第几个矿位	金币兑换暴击率	金币暴击提升至多少倍	金币兑换加成倍数	极限挑战是否开启宝箱10连开	极限挑战宝箱10连开折扣	招财猫活动次数	捕食试练积分加成	世界BOSS购买次数上限	通用商店最大刷新次数(顺序根据shop.txt：杂货店、竞技场、3v3、大乱斗、极限、神秘、社团、捕食）	世界BOSS增加属性	极限挑战攻击增加,在kuikuliya_buff_data中对应buff	升级需要经验	等级奖励	VIP特权描述（vip_describe.txt）	VIP礼包原价	VIP礼包折扣价	聊天角色名颜色	是否上线提示公告(1有 0没有)	保卫战替换奖励（0走原配置 ）	可购买精力次数	世界宝箱移动速度加成（%）	小丑计划奖励加成（%）	极限挑战自动战斗权限（0不能1能）	捕食场自动战斗权限（0不能1能）	贩卖机次数	每日奖励	模型	可解锁头像	头像外框
g_Config.t_vip_data_key_ = {
	vip=1,
	level=2,
	level_star=3,
	tittle=4,
	kuikuliya_free_times=5,
	kuikuliya_buy_times=6,
	churchpray_free_times=7,
	churchpray_buy_times=8,
	ex_can_buy_ap_times=9,
	max_ap=10,
	hurdle_reset_count=11,
	hurdle_sweep_10=12,
	arena_times=13,
	can_buy_arena_times=14,
	taofazhan_sweep=15,
	taofazhan_reset_times=16,
	gaosujuji_sweep=17,
	gaosujuji_multiple=18,
	tonglingzhihun_exchange_times=19,
	zhongyuan_multiple=20,
	enjoy_gifts=21,
	money_gifts=22,
	Lingshi_gifts=23,
	equip_gifts=24,
	ex_slg_free_times=25,
	ex_slg_buy_times=26,
	niudan_dis=27,
	world_boss_start_inspire=28,
	world_boss_inspire_limit=29,
	ex_exchange_gold_times=30,
	free_tranform_to_boss_num=31,
	free_relive_num=32,
	skill_point_cd=33,
	expedition_trial_sweep_level_limit=34,
	world_treasures_box_free_relive=35,
	arena_is_pass=36,
	arena_fail_get_scores=37,
	play_is_auto_signup=38,
	handle_sweep_by_star=39,
	hurdle_sweep_50=40,
	gsjj_add_money=41,
	gsjj_cool_time=42,
	churchpray_add_ore_num=43,
	y_add_ore_num=44,
	money_add_crit_num=45,
	money_add_reward_ex=46,
	open_kuikuliya_open_box_ten=47,
	kuikuliya_ten_discount=48,
	lucky_cat_times=49,
	expedition_trial_score=50,
	world_buy_times_limit=51,
	shop_refresh_times=52,
	world_boss_scale_property=53,
	jxtz_add_attack=54,
	need_exp=55,
	rewards=56,
	des=57,
	price=58,
	discount_price=59,
	chat_role_color=60,
	online_tips=61,
	battle_awards=62,
	can_buy_vigor_times=63,
	world_box_speed_add=64,
	clown_plan_award_add=65,
	kuikuliya_can_auto_fight=66,
	expedition_trial_can_auto_fight=67,
	vending_machine=68,
	every_day_reward=69,
	model_id=70,
	unlock_head=71,
	head_frame=72,
}
g_Config.t_vip_data = {
	[0] = "{0,0,0,gs_vip_describe.vip_tittle_0,1,0,0,0,2,0,0,0,5,20,0,0,0,1,90,1,0,0,0,0,5,3,1,0,10,2,1,5,0,0,1,0,1,0,3,0,0,600,2,0.3,2,1,0,0,5,0,5,{1,1,1,1,1,1,1,1,1,},{[30000004] = 0,},0,60,0,gs_vip_describe.vip_des_0,0,0,'0bbdf9',0,0,2,0,0,0,0,4,0,80008001,{1,2,},'txk_vip0',}",
	[1] = "{1,1,1,gs_vip_describe.vip_tittle_1,1,0,0,0,4,0,0,0,5,20,0,0,0,1,90,1,0,0,0,0,5,3,1,0,11,3,1,5,0,0,1,0,1,0,3,0,0,600,2,0.3,2,1,0,0,5,0,5,{2,2,2,2,2,2,2,2,2,},{[30000004] = 0,},0,100,{{id = 20000124,num = 5,},{id = 4,num = 120,},{id = 20000023,num = 30,},{id = 2,num = 100000,},},gs_vip_describe.vip_des_1,880,18,'0bbdf9',0,0,2,0,0,0,0,4,{{id = 2,num = 8000,},{id = 20000022,num = 2,},},80008002,{1,2,},'txk_vip1',}",
	[2] = "{2,2,1,gs_vip_describe.vip_tittle_2,1,0,0,0,6,0,1,0,5,20,0,0,0,1,90,1,0,0,0,0,5,3,1,0,11,4,1,5,0,0,1,0,1,0,3,0,0,600,2,0.3,2,1.03,0,0,5,0,5,{3,3,3,3,3,3,3,3,3,},{[30000004] = 0,},0,140,{{id = 20000133,num = 10,},{id = 20000006,num = 2,},{id = 20000023,num = 50,},{id = 2,num = 100000,},},gs_vip_describe.vip_des_2,1880,180,'0bbdf9',0,0,2,0,0,0,0,5,{{id = 2,num = 10000,},{id = 20000022,num = 4,},},80008003,{1,2,},'txk_vip2',}",
	[3] = "{3,2,2,gs_vip_describe.vip_tittle_2,1,0,0,0,6,0,1,0,5,20,0,0,0,1,90,1,0,0,0,0,5,3,1,0,11,5,1,5,0,0,1,0,1,0,3,0,0.03,600,2,0.3,2,1.03,0,0,5,0,5,{3,3,3,3,3,3,3,3,3,},{[30000004] = 0,},0,200,0,gs_vip_describe.vip_des_3,0,0,'0bbdf9',0,0,2,0,0,0,0,5,{{id = 2,num = 11000,},{id = 20000022,num = 6,},},80008003,{1,2,},'txk_vip2',}",
	[4] = "{4,3,1,gs_vip_describe.vip_tittle_3,1,0,0,0,8,0,1,0,5,20,0,0,0,1.03,90,1,0,0,0,0,5,3,1,0,11,6,1,5,0,0,1,0,1,0,3,0,0.03,600,2,0.3,2,1.03,0,0,5,0,5,{4,4,4,4,4,4,4,4,4,},{[30000004] = 0,},0,240,{{id = 20002016,num = 50,},{id = 20000006,num = 2,},{id = 20000024,num = 30,},{id = 2,num = 100000,},},gs_vip_describe.vip_des_4,4880,480,'0bbdf9',0,0,2,0,0,0,0,5,{{id = 2,num = 13000,},{id = 20000022,num = 8,},},80008004,{1,2,},'txk_vip3',}",
	[5] = "{5,3,2,gs_vip_describe.vip_tittle_3,1,0,0,0,8,0,1,1,5,20,0,0,0,1.03,90,1,0,0,0,0,5,3,1,0,12,7,1,5,0,0,1,0,1,0,3,0,0.03,600,2,0.3,2,1.03,0,0,6,0,5,{4,4,4,4,4,4,4,4,4,},{[30000004] = 0,},0,280,0,gs_vip_describe.vip_des_5,0,0,'0bbdf9',0,0,2,0,3,0,0,5,{{id = 2,num = 14000,},{id = 20000022,num = 10,},},80008004,{1,2,},'txk_vip3',}",
	[6] = "{6,3,3,gs_vip_describe.vip_tittle_3,1,0,0,0,8,0,1,1,5,20,0,0,0,1.03,90,1,0,0,0,0,5,3,1,0,12,8,1,5,0,0,1,0,1,0,3,0,0.03,600,2,0.3,2,1.05,0,0,6,0,5,{4,4,4,4,4,4,4,4,4,},{[30000004] = 0,},0,420,0,gs_vip_describe.vip_des_6,0,0,'0bbdf9',0,0,2,0,3,0,0,5,{{id = 2,num = 15000,},{id = 20000022,num = 12,},},80008004,{1,2,},'txk_vip3',}",
	[7] = "{7,4,1,gs_vip_describe.vip_tittle_4,1,0,0,0,10,0,1,1,5,20,0,0,0,1.03,90,1,0,0,0,0,5,3,1,0,12,9,1,5,0,0,1,0,1,0,3,0,0.05,600,2,0.3,2,1.05,0,0,6,0.05,5,{5,5,5,5,5,5,5,5,5,},{[30000004] = 0,},0,520,{{id = 20002016,num = 50,},{id = 20000133,num = 10,},{id = 20000024,num = 30,},{id = 2,num = 100000,},},gs_vip_describe.vip_des_7,8880,880,'0bbdf9',0,0,2,0,3,0,0,6,{{id = 2,num = 18000,},{id = 20000022,num = 12,},{id = 20000305,num = 2,},},80008005,{1,2,},'txk_vip4',}",
	[8] = "{8,4,2,gs_vip_describe.vip_tittle_4,1,0,0,0,10,0,2,1,5,20,0,0,0,1.05,90,1,0,0,0,0,5,3,1,0,13,10,1,5,0,0,1,0,1,0,3,0,0.05,600,2,0.3,2,1.05,0,0,6,0.05,5,{5,5,5,5,5,5,5,5,5,},{[30000004] = 0,},0,620,0,gs_vip_describe.vip_des_8,0,0,'0bbdf9',0,0,2,0,3,0,0,6,{{id = 2,num = 19000,},{id = 20000022,num = 12,},{id = 20000305,num = 2,},},80008005,{1,2,},'txk_vip4',}",
	[9] = "{9,4,3,gs_vip_describe.vip_tittle_4,1,0,0,0,10,0,2,1,5,20,0,0,0,1.05,90,1,0,0,0,0,5,3,1,0,13,11,1,5,0,0,1,0,1,0,3,0,0.05,600,2,0.3,2,1.05,0,0,6,0.05,5,{5,5,5,5,5,5,5,5,5,},{[30000004] = 0,},0,720,0,gs_vip_describe.vip_des_9,0,0,'0bbdf9',0,0,2,0,5,0,0,6,{{id = 2,num = 20000,},{id = 20000022,num = 12,},{id = 20000305,num = 2,},},80008005,{1,2,},'txk_vip4',}",
	[10] = "{10,4,4,gs_vip_describe.vip_tittle_4,1,0,0,0,10,0,2,1,5,20,0,0,0,1.05,90,1,0,0,0,0,5,3,1,0,13,12,1,5,0,0,1,0,1,0,3,0,0.05,600,2,0.3,2,1.08,0,0,6,0.05,5,{5,5,5,5,5,5,5,5,5,},{[30000004] = 0,},0,910,0,gs_vip_describe.vip_des_10,0,0,'0bbdf9',0,0,2,0,5,0,0,6,{{id = 2,num = 21000,},{id = 20000022,num = 12,},{id = 20000305,num = 2,},},80008005,{1,2,},'txk_vip4',}",
	[11] = "{11,5,1,gs_vip_describe.vip_tittle_5,1,0,0,0,12,0,2,1,5,20,0,0,0,1.05,90,1,0,0,0,0,5,3,1,0,14,13,1,5,0,0,1,0,1,0,3,0,0.08,600,2,0.3,2,1.08,0,0,6,0.05,5,{6,6,6,6,6,6,6,6,6,},{[30000004] = 0,},0,930,{{id = 20004016,num = 1,},{id = 20000006,num = 5,},{id = 20000112,num = 20,},{id = 2,num = 150000,},},gs_vip_describe.vip_des_11,12880,1280,'0bbdf9',0,0,2,0,5,0,0,6,{{id = 2,num = 24000,},{id = 20000023,num = 10,},{id = 20000305,num = 3,},{id = 20000309,num = 2,},},80008006,{1,2,},'txk_vip5',}",
	[12] = "{12,5,2,gs_vip_describe.vip_tittle_5,1,0,0,0,12,0,2,1,5,20,0,0,0,1.08,90,1,0,0,0,0,5,3,1,0,14,14,1,5,0,0,1,0,1,0,3,0,0.08,600,2,0.3,2,1.08,0,0,7,0.08,5,{6,6,6,6,6,6,6,6,6,},{[30000004] = 0,},0,950,0,gs_vip_describe.vip_des_12,0,0,'0bbdf9',0,0,2,0,5,0,0,6,{{id = 2,num = 25000,},{id = 20000023,num = 10,},{id = 20000305,num = 3,},{id = 20000309,num = 2,},},80008006,{1,2,},'txk_vip5',}",
	[13] = "{13,5,3,gs_vip_describe.vip_tittle_5,1,0,0,0,12,0,2,1,5,20,0,0,0,1.08,90,1,0,0,0,0,5,3,1,0,14,15,1,5,0,0,1,0,1,0,3,0,0.08,600,2,0.3,2,1.08,0,0,7,0.08,5,{6,6,6,6,6,6,6,6,6,},{[30000004] = 0,},0,970,0,gs_vip_describe.vip_des_13,0,0,'0bbdf9',0,0,2,0,8,0,0,6,{{id = 2,num = 26000,},{id = 20000023,num = 10,},{id = 20000305,num = 3,},{id = 20000309,num = 2,},},80008006,{1,2,},'txk_vip5',}",
	[14] = "{14,5,4,gs_vip_describe.vip_tittle_5,1,0,0,0,14,0,2,1,5,20,0,0,0,1.08,90,1,0,0,0,0,5,3,1,0,15,16,1,5,0,0,1,0,1,0,3,0,0.08,600,2,0.3,2,1.08,0,0,7,0.08,5,{6,6,6,6,6,6,6,6,6,},{[30000004] = 0,},0,990,0,gs_vip_describe.vip_des_14,0,0,'0bbdf9',0,0,2,0,8,0,1,6,{{id = 2,num = 27000,},{id = 20000023,num = 10,},{id = 20000305,num = 3,},{id = 20000309,num = 2,},},80008006,{1,2,},'txk_vip5',}",
	[15] = "{15,5,5,gs_vip_describe.vip_tittle_5,1,1,0,0,14,0,2,1,5,20,0,0,0,1.08,90,1,0,0,0,0,5,3,1,0,16,17,1,5,0,0,1,0,1,0,3,1,0.08,600,2,0.3,2,1.1,0,0,7,0.08,5,{6,6,6,6,6,6,6,6,6,},{[30000004] = 0,},0,1000,0,gs_vip_describe.vip_des_15,0,0,'0bbdf9',0,0,2,0,8,0,1,6,{{id = 2,num = 28000,},{id = 20000023,num = 10,},{id = 20000305,num = 3,},{id = 20000309,num = 2,},},80008006,{1,2,},'txk_vip5',}",
	[16] = "{16,6,1,gs_vip_describe.vip_tittle_6,1,1,0,0,16,0,2,1,5,20,0,0,0,1.08,90,1,0,0,0,0,5,3,1,0,17,18,1,5,0,1,1,0,1,0,3,1,0.08,600,2,0.3,2,1.1,0,0,7,0.1,5,{7,7,7,7,7,7,7,7,7,},{[30000004] = 0,},0,1010,{{id = 20002016,num = 50,},{id = 20001416,num = 1,},{id = 20000311,num = 40,},{id = 2,num = 150000,},},gs_vip_describe.vip_des_16,19880,1980,'0bbdf9',0,0,2,0,8,0,1,6,{{id = 2,num = 31000,},{id = 20000023,num = 15,},{id = 20000305,num = 5,},{id = 20000309,num = 4,},},80008007,{1,2,},'txk_vip6',}",
	[17] = "{17,6,2,gs_vip_describe.vip_tittle_6,1,1,0,0,16,0,2,1,5,20,0,0,0,1.08,90,1,0,0,0,0,5,3,1,0,18,20,1,5,0,2,1,0,1,0,3,1,0.1,600,2,0.3,2,1.1,0,0,7,0.1,5,{7,7,7,7,7,7,7,7,7,},{[30000004] = 0,},0,1020,0,gs_vip_describe.vip_des_17,0,0,'0bbdf9',0,0,2,0,8,1,1,6,{{id = 2,num = 32000,},{id = 20000023,num = 15,},{id = 20000305,num = 5,},{id = 20000309,num = 4,},},80008007,{1,2,},'txk_vip6',}",
	[18] = "{18,6,3,gs_vip_describe.vip_tittle_6,1,1,0,0,16,0,3,1,5,20,0,0,0,1.08,90,1,0,0,0,0,5,3,1,0,19,22,1,5,0,3,1,0,1,0,3,1,0.1,600,2,0.3,2,1.1,0,0,7,0.1,5,{7,7,7,7,7,7,7,7,7,},{[30000004] = 0,},0,1030,0,gs_vip_describe.vip_des_18,0,0,'0bbdf9',0,0,2,0,8,1,1,6,{{id = 2,num = 33000,},{id = 20000023,num = 15,},{id = 20000305,num = 5,},{id = 20000309,num = 4,},},80008007,{1,2,},'txk_vip6',}",
	[19] = "{19,6,4,gs_vip_describe.vip_tittle_6,1,1,0,0,18,0,3,1,5,20,0,0,0,1.1,90,1,0,0,0,0,5,3,1,0,20,24,1,5,0,4,1,0,1,0,3,1,0.1,600,2,0.3,2,1.1,0,0,7,0.1,5,{7,7,7,7,7,7,7,7,7,},{[30000004] = 0,},0,1040,0,gs_vip_describe.vip_des_19,0,0,'0bbdf9',0,0,2,0,8,1,1,6,{{id = 2,num = 34000,},{id = 20000023,num = 15,},{id = 20000305,num = 5,},{id = 20000309,num = 4,},},80008007,{1,2,},'txk_vip6',}",
	[20] = "{20,6,5,gs_vip_describe.vip_tittle_6,1,1,0,0,18,0,3,1,5,20,0,0,0,1.1,90,1,0,0,0,0,5,3,1,0,21,26,1,5,0,5,1,0,1,0,3,1,0.1,600,2,0.3,2,1.1,0,0,7,0.1,5,{7,7,7,7,7,7,7,7,7,},{[30000004] = 0,},0,1050,0,gs_vip_describe.vip_des_20,0,0,'0bbdf9',0,0,2,0,10,1,1,6,{{id = 2,num = 35000,},{id = 20000023,num = 15,},{id = 20000305,num = 5,},{id = 20000309,num = 4,},},80008007,{1,2,},'txk_vip6',}",
	[21] = "{21,6,6,gs_vip_describe.vip_tittle_6,1,1,0,0,18,0,3,1,5,20,0,0,0,1.1,90,1,0,0,0,0,5,3,1,0,22,28,1,5,0,6,1,0,1,0,3,1,0.1,600,2,0.3,2,1.1,0,0,7,0.13,5,{7,7,7,7,7,7,7,7,7,},{[30000004] = 0,},0,1870,0,gs_vip_describe.vip_des_21,0,0,'0bbdf9',0,0,2,0,10,1,1,6,{{id = 2,num = 36000,},{id = 20000023,num = 15,},{id = 20000305,num = 5,},{id = 20000309,num = 4,},},80008007,{1,2,},'txk_vip6',}",
	[22] = "{22,7,1,gs_vip_describe.vip_tittle_7,1,1,0,0,20,0,3,1,5,20,0,0,0,1.1,90,1,0,0,0,0,5,3,1,0,23,30,1,5,0,7,1,0,1,0,3,1,0.1,600,2,0.3,2,1.1,0,0,7,0.13,5,{8,8,8,8,8,8,8,8,8,},{[30000004] = 0,},0,2470,{{id = 20002016,num = 100,},{id = 20001407,num = 1,},{id = 20000311,num = 80,},{id = 2,num = 200000,},},gs_vip_describe.vip_des_22,29880,2980,'ff63fd',0,0,2,0,10,1,1,6,{{id = 2,num = 40000,},{id = 20000023,num = 20,},{id = 20000305,num = 8,},{id = 20000310,num = 2,},},80008008,{1,2,},'txk_vip7',}",
	[23] = "{23,7,2,gs_vip_describe.vip_tittle_7,1,1,0,0,20,0,3,1,5,20,0,0,0,1.1,90,1,0,0,0,0,5,3,1,0,24,32,1,5,0,8,1,0,1,0,3,1,0.1,600,2,0.3,2,1.13,0,0,8,0.13,5,{8,8,8,8,8,8,8,8,8,},{[30000004] = 0,},0,3070,0,gs_vip_describe.vip_des_23,0,0,'ff63fd',0,0,2,0,10,1,1,6,{{id = 2,num = 41000,},{id = 20000023,num = 20,},{id = 20000305,num = 8,},{id = 20000310,num = 2,},},80008008,{1,2,},'txk_vip7',}",
	[24] = "{24,7,3,gs_vip_describe.vip_tittle_7,1,1,0,0,20,0,3,1,5,20,0,0,0,1.1,90,1,0,0,0,0,5,3,1,0,25,34,1,5,0,9,1,0,1,0,3,1,0.13,600,2,0.3,2,1.13,0,0,8,0.13,5,{8,8,8,8,8,8,8,8,8,},{[30000004] = 0,},0,3670,0,gs_vip_describe.vip_des_24,0,0,'ff63fd',0,0,2,0,10,1,1,6,{{id = 2,num = 42000,},{id = 20000023,num = 20,},{id = 20000305,num = 8,},{id = 20000310,num = 2,},},80008008,{1,2,},'txk_vip7',}",
	[25] = "{25,7,4,gs_vip_describe.vip_tittle_7,1,1,0,0,22,0,3,1,5,20,0,0,0,1.1,90,1,0,0,0,0,5,3,1,0,26,36,1,5,0,10,1,0,1,0,3,1,0.13,600,2,0.3,2,1.13,0,0,8,0.13,6,{8,8,8,8,8,8,8,8,8,},{[30000004] = 0,},0,4270,0,gs_vip_describe.vip_des_25,0,0,'ff63fd',0,0,2,0,10,1,1,6,{{id = 2,num = 43000,},{id = 20000023,num = 20,},{id = 20000305,num = 8,},{id = 20000310,num = 2,},},80008008,{1,2,},'txk_vip7',}",
	[26] = "{26,7,5,gs_vip_describe.vip_tittle_7,1,1,0,0,22,0,3,1,5,20,0,0,0,1.13,90,1,0,0,0,0,5,3,1,0,27,40,1,5,0,11,1,0,1,0,3,1,0.13,600,2,0.3,2,1.13,0,0,8,0.13,6,{8,8,8,8,8,8,8,8,8,},{[30000004] = 0,},0,4870,0,gs_vip_describe.vip_des_26,0,0,'ff63fd',0,0,2,0,10,1,1,6,{{id = 2,num = 44000,},{id = 20000023,num = 20,},{id = 20000305,num = 8,},{id = 20000310,num = 2,},},80008008,{1,2,},'txk_vip7',}",
	[27] = "{27,7,6,gs_vip_describe.vip_tittle_7,1,1,0,0,24,0,3,1,5,20,0,0,0,1.13,90,1,0,0,0,0,5,3,1,0,28,42,1,5,0,12,1,0,1,0,3,1,0.13,600,2,0.3,2,1.13,0,0,8,0.13,6,{8,8,8,8,8,8,8,8,8,},{[30000004] = 0,},0,5470,0,gs_vip_describe.vip_des_27,0,0,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 45000,},{id = 20000023,num = 20,},{id = 20000305,num = 8,},{id = 20000310,num = 2,},},80008008,{1,2,},'txk_vip7',}",
	[28] = "{28,7,7,gs_vip_describe.vip_tittle_7,1,1,0,0,24,0,3,1,5,20,0,0,0,1.13,90,1,0,0,0,0,5,3,1,0,29,44,1,5,0,13,1,0,1,0,3,1,0.13,600,2,0.3,2,1.13,0,0,8,0.13,6,{8,8,8,8,8,8,8,8,8,},{[30000004] = 0,},0,5600,0,gs_vip_describe.vip_des_28,0,0,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 46000,},{id = 20000023,num = 20,},{id = 20000305,num = 8,},{id = 20000310,num = 2,},},80008008,{1,2,},'txk_vip7',}",
	[29] = "{29,8,1,gs_vip_describe.vip_tittle_8,1,1,0,0,26,0,3,1,5,20,0,0,0,1.13,90,1,0,0,0,0,5,3,1,0,30,46,1,5,0,14,1,0,1,0,3,1,0.13,600,2,0.3,2,1.13,0,0,8,0.15,6,{9,9,9,9,9,9,9,9,9,},{[30000004] = 0,},0,5700,{{id = 20002025,num = 100,},{id = 20000311,num = 100,},{id = 20000112,num = 30,},{id = 2,num = 300000,},},gs_vip_describe.vip_des_29,52880,4980,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 50000,},{id = 20000023,num = 25,},{id = 20000305,num = 10,},{id = 20000310,num = 4,},},80008009,{1,2,},'txk_vip8',}",
	[30] = "{30,8,2,gs_vip_describe.vip_tittle_8,1,1,0,0,26,0,3,1,5,20,0,0,0,1.13,90,1,0,0,0,0,5,3,1,0,31,48,1,5,0,15,1,0,1,0,3,1,0.13,600,2,0.3,2,1.15,0,0,9,0.15,6,{9,9,9,9,9,9,9,9,9,},{[30000004] = 0,},0,5800,0,gs_vip_describe.vip_des_30,0,0,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 52000,},{id = 20000023,num = 25,},{id = 20000305,num = 10,},{id = 20000310,num = 4,},},80008009,{1,2,},'txk_vip8',}",
	[31] = "{31,8,3,gs_vip_describe.vip_tittle_8,1,1,0,0,28,0,3,1,5,20,0,0,0,1.13,90,1,0,0,0,0,5,3,1,0,32,50,1,5,0,16,1,0,1,0,3,1,0.13,600,2,0.3,2,1.15,0,0,9,0.15,6,{9,9,9,9,9,9,9,9,9,},{[30000004] = 0,},0,5900,0,gs_vip_describe.vip_des_31,0,0,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 54000,},{id = 20000023,num = 25,},{id = 20000305,num = 10,},{id = 20000310,num = 4,},},80008009,{1,2,},'txk_vip8',}",
	[32] = "{32,8,4,gs_vip_describe.vip_tittle_8,1,1,0,0,28,0,3,1,5,20,0,0,0,1.13,90,1,0,0,0,0,5,3,1,0,33,52,1,5,0,17,1,0,1,0,3,1,0.15,600,2,0.3,2,1.15,0,0,9,0.18,6,{9,9,9,9,9,9,9,9,9,},{[30000004] = 0,},0,6000,0,gs_vip_describe.vip_des_32,0,0,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 56000,},{id = 20000023,num = 25,},{id = 20000305,num = 10,},{id = 20000310,num = 4,},},80008009,{1,2,},'txk_vip8',}",
	[33] = "{33,8,5,gs_vip_describe.vip_tittle_8,1,1,0,0,30,0,3,1,5,20,0,0,0,1.13,90,1,0,0,0,0,5,3,1,0,34,54,1,5,0,18,1,0,1,0,3,1,0.15,600,2,0.3,2,1.15,0,0,9,0.18,6,{9,9,9,9,9,9,9,9,9,},{[30000004] = 0,},0,6100,0,gs_vip_describe.vip_des_33,0,0,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 58000,},{id = 20000023,num = 25,},{id = 20000305,num = 10,},{id = 20000310,num = 4,},},80008009,{1,2,},'txk_vip8',}",
	[34] = "{34,8,6,gs_vip_describe.vip_tittle_8,1,1,0,0,30,0,3,1,5,20,0,0,0,1.15,90,1,0,0,0,0,5,3,1,0,35,56,1,5,0,19,1,0,1,0,3,1,0.15,600,2,0.3,2,1.15,0,0,9,0.18,6,{9,9,9,9,9,9,9,9,9,},{[30000004] = 0,},0,6200,0,gs_vip_describe.vip_des_34,0,0,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 60000,},{id = 20000023,num = 25,},{id = 20000305,num = 10,},{id = 20000310,num = 4,},},80008009,{1,2,},'txk_vip8',}",
	[35] = "{35,8,7,gs_vip_describe.vip_tittle_8,1,1,0,0,32,0,3,1,5,20,0,0,0,1.15,90,1,0,0,0,0,5,3,1,0,36,58,1,5,0,20,1,0,1,0,3,1,0.15,600,2,0.3,2,1.15,0,0,9,0.18,6,{9,9,9,9,9,9,9,9,9,},{[30000004] = 0,},0,6300,0,gs_vip_describe.vip_des_35,0,0,'ff63fd',0,0,2,0,13,1,1,6,{{id = 2,num = 62000,},{id = 20000023,num = 25,},{id = 20000305,num = 10,},{id = 20000310,num = 4,},},80008009,{1,2,},'txk_vip8',}",
	[36] = "{36,8,8,gs_vip_describe.vip_tittle_8,1,1,0,0,32,0,3,1,5,20,0,0,0,1.15,90,1,0,0,0,0,5,3,1,0,37,60,1,5,0,21,1,0,1,0,3,1,0.15,600,2,0.3,2,1.15,0,0,9,0.18,6,{9,9,9,9,9,9,9,9,9,},{[30000004] = 0,},0,7000,0,gs_vip_describe.vip_des_36,0,0,'ff63fd',0,0,2,0,15,1,1,6,{{id = 2,num = 64000,},{id = 20000023,num = 25,},{id = 20000305,num = 10,},{id = 20000310,num = 4,},},80008009,{1,2,},'txk_vip8',}",
	[37] = "{37,9,1,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.15,90,1,0,0,0,0,5,3,1,0,38,62,1,5,0,22,1,0,1,0,3,1,0.15,600,2,0.3,2,1.15,0,0,9,0.18,6,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,7100,{{id = 20002025,num = 150,},{id = 20001406,num = 1,},{id = 20000311,num = 150,},{id = 2,num = 300000,},},gs_vip_describe.vip_des_37,98880,8880,'ff63fd',1,0,2,0,15,1,1,6,{{id = 2,num = 70000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 1,},},80008010,{1,2,},'txk_vip9',}",
	[38] = "{38,9,2,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.15,90,1,0,0,0,0,5,3,1,0,39,64,1,5,0,23,1,0,1,0,3,1,0.15,600,2,0.3,2,1.15,0,0,9,0.2,6,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,7200,0,gs_vip_describe.vip_des_38,0,0,'ff63fd',1,0,2,0,15,1,1,6,{{id = 2,num = 72000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 1,},},80008010,{1,2,},'txk_vip9',}",
	[39] = "{39,9,3,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.15,90,1,0,0,0,0,5,3,1,0,40,66,1,5,0,24,1,0,1,0,3,1,0.15,600,2,0.3,2,1.2,0,0,9,0.2,6,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,7300,0,gs_vip_describe.vip_des_39,0,0,'ff63fd',1,0,2,0,15,1,1,6,{{id = 2,num = 74000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 1,},},80008010,{1,2,},'txk_vip9',}",
	[40] = "{40,9,4,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.15,90,1,0,0,0,0,5,3,1,0,41,68,1,5,0,25,1,0,1,0,3,1,0.2,600,2,0.3,2,1.2,0,0,9,0.2,6,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,7400,0,gs_vip_describe.vip_des_40,0,0,'ff63fd',1,0,2,0,15,1,1,6,{{id = 2,num = 76000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 1,},},80008010,{1,2,},'txk_vip9',}",
	[41] = "{41,9,5,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.15,90,1,0,0,0,0,5,3,1,0,42,70,1,5,0,26,1,0,1,0,3,1,0.2,600,2,0.3,2,1.2,0,0,9,0.2,6,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,7500,0,gs_vip_describe.vip_des_41,0,0,'ff63fd',1,0,2,0,15,1,1,6,{{id = 2,num = 78000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 1,},},80008010,{1,2,},'txk_vip9',}",
	[42] = "{42,9,6,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.2,90,1,0,0,0,0,5,3,1,0,43,72,1,5,0,27,1,0,1,0,3,1,0.2,600,2,0.3,2,1.2,0,0,9,0.22,6,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,7600,0,gs_vip_describe.vip_des_42,0,0,'ff63fd',1,0,2,0,15,1,1,6,{{id = 2,num = 80000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 1,},},80008010,{1,2,},'txk_vip9',}",
	[43] = "{43,9,7,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.2,90,1,0,0,0,0,5,3,1,0,44,74,1,5,0,28,1,0,1,0,3,1,0.2,600,2,0.3,2,1.2,0,0,9,0.22,6,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,7700,0,gs_vip_describe.vip_des_43,0,0,'ff63fd',1,0,2,0,20,1,1,6,{{id = 2,num = 82000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 1,},},80008010,{1,2,},'txk_vip9',}",
	[44] = "{44,9,8,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.2,90,1,0,0,0,0,5,3,1,0,45,76,1,5,0,29,1,0,1,0,3,1,0.2,600,2,0.3,2,1.2,0,0,9,0.22,6,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,7800,0,gs_vip_describe.vip_des_44,0,0,'ff63fd',1,0,2,0,20,1,1,6,{{id = 2,num = 85000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 2,},},80008010,{1,2,},'txk_vip9',}",
	[45] = "{45,9,9,gs_vip_describe.vip_tittle_9,1,1,0,0,34,0,3,1,5,20,0,0,0,1.2,90,1,0,0,0,0,5,3,1,0,46,78,1,5,0,30,1,0,1,0,3,1,0.2,600,2,0.3,2,1.2,0,0,9,0.25,7,{10,10,10,10,10,10,10,10,10,},{[30000004] = 0,},0,0,0,gs_vip_describe.vip_des_45,0,0,'ff63fd',1,0,2,0,20,1,1,6,{{id = 2,num = 90000,},{id = 20000024,num = 10,},{id = 20000305,num = 15,},{id = 20000329,num = 3,},},80008010,{1,2,},'txk_vip9',}",
}
return {key = g_Config.t_vip_data_key_, data = g_Config.t_vip_data } 
 -- 