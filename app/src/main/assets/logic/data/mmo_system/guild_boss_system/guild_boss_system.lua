--序号	BOSS刷新坐标	玩家刷新坐标	buff金币消耗	buff钻石消耗	玩家单场游戏时间(秒)	buff金币双倍概率(0-10000)	buff钻石双倍概率(0-10000)	触发伤害BUFF的人数	触发伤害BUFF的缩放	参与奖励	玩家单日参加次数
g_Config.t_guild_boss_system_key_ = {
	id=1,
	boss_born_pos=2,
	player_born_pos=3,
	buff_gold_cost=4,
	buff_crystal_cost=5,
	player_time_limit=6,
	buff_gold_double_odds=7,
	buff_crystal_double_odds=8,
	active_damage_scale_player_cnt=9,
	damage_buff_scale=10,
	play_reward=11,
	every_day_times=12,
}
g_Config.t_guild_boss_system = {
	[1] = "{1,{x = 22.1,y = -56.23,},{x = 22.1,y = -17.6,},10000,10,600,5000,5000,5,1.5,{{id = 20000125,num = 300,},{id = 2,num = 20000,},{id = 20000023,num = 20,},},3,}",
}
return {key = g_Config.t_guild_boss_system_key_, data = g_Config.t_guild_boss_system } 
 -- 