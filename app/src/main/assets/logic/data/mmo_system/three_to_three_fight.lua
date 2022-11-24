--序号	策划注释	左边NPC信息(type，1=1塔，2=2塔，3=基地，0=血池）	左边玩家刷新坐标	右边NPC信息(type，1=1塔，2=2塔，3=基地）	右边玩家刷新坐标	道具刷新坐标	3v3最大挑战奖励次数	3v3匹配时间	3v3准备时间	3v3准备退出惩罚时间	3v3最大加载时间	3v3选择英雄时间	3v3周免英雄最大数量	3v3复活时间(rs时间下限 re时间上限 t复活时间）	左边小怪信息(val魂值)	左边刷怪坐标	右边小怪信息(val魂值)	右边刷怪坐标	单个小怪刷新间隔	开场刷新延迟时间	小怪大波刷新间隔时间	英雄魂值点
g_Config.t_three_to_three_fight_key_ = {
	id=1,
	left_boss_info=2,
	left_player_born_pos=3,
	right_boss_info=4,
	right_player_born_pos=5,
	item_pos=6,
	max_challenge_count=7,
	match_time=8,
	ready_time=9,
	ready_exit_time=10,
	max_load_time=11,
	select_role_time=12,
	week_role_max=13,
	relive_time=14,
	left_monster_info=15,
	left_monster_position=16,
	right_monster_info=17,
	right_monster_position=18,
	monster_single_refresh=19,
	monster_open_delay=20,
	monster_wave_refresh=21,
	hero_soul=22,
}
g_Config.t_three_to_three_fight = {
	[1] = "{1,{{id = 31600100,x = 21.27,y = -10.03,type = 1,rotation = 0,val = 60,},{id = 31600110,x = 21.14,y = -20.35,type = 2,rotation = 0,val = 80,},{id = 31600000,x = 21.08,y = -28.27,type = 3,rotation = 0,val = 0,},{id = 31600140,x = 21.05,y = -36.51,type = 0,rotation = 0,val = 0,},},{{x = 21.03,y = -35.76,rotation = 0,},{x = 20.24,y = -37.12,rotation = 0,},{x = 21.92,y = -37.12,rotation = 0,},},{{id = 31600120,x = 20.98,y = 14.89,type = 1,rotation = 180,val = 60,},{id = 31600130,x = 20.91,y = 25.12,type = 2,rotation = 180,val = 80,},{id = 31600010,x = 21.01,y = 33.27,type = 3,rotation = 180,val = 0,},{id = 31600140,x = 21.1,y = 40.5,type = 0,rotation = 0,val = 0,},},{{x = 21.13,y = 40.21,rotation = 180,},{x = 20.22,y = 41.63,rotation = 180,},{x = 21.91,y = 41.63,rotation = 180,},},{{id = 1,x = 25,y = -14.9,},{id = 1,x = 16.569,y = 19.118,},},6,20,30,60,120,30,6,{{rs = 0,re = 60,t = 10,},{rs = 61,re = 120,t = 12,},{rs = 121,re = 180,t = 15,},{rs = 181,re = 240,t = 18,},{rs = 241,re = 300,t = 20,},{rs = 301,re = 360,t = 22,},{rs = 361,re = 420,t = 24,},{rs = 421,re = 480,t = 26,},{rs = 481,re = 540,t = 28,},{rs = 541,re = 9999,t = 30,},},{{id = 31600150,rotation = 0,val = 5,},{id = 31600150,rotation = 0,val = 5,},{id = 31600150,rotation = 0,val = 5,},{id = 31600151,rotation = 0,val = 5,},},{x = 21.03,y = -25.88,end_x = 21.06,end_y = 33.26,},{{id = 31600160,rotation = 0,val = 5,},{id = 31600160,rotation = 0,val = 5,},{id = 31600160,rotation = 0,val = 5,},{id = 31600161,rotation = 0,val = 5,},},{x = 21.27,y = 30.82,end_x = 21.06,end_y = -28.26,},0.5,3,30,40,}",
}
return {key = g_Config.t_three_to_three_fight_key_, data = g_Config.t_three_to_three_fight } 
 -- 