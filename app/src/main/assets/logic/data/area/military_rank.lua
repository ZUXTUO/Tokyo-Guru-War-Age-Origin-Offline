--军衔	军衔名	升级所需功勋	每日奖励群组	每日能获得最大功勋
g_Config.t_military_rank_key_ = {
	military_rank_index=1,
	military_rank_name=2,
	upgrade_need_exploit=3,
	day_reward_dropid=4,
	one_day_max_exploit=5,
}
g_Config.t_military_rank = {
	[1] = "{1,'士兵',100,1004,100,}",
	[2] = "{2,'士官',101,1005,101,}",
	[3] = "{3,'少尉',102,1006,102,}",
	[4] = "{4,'中尉',103,1007,103,}",
	[5] = "{5,'上尉',104,1008,104,}",
	[6] = "{6,'少校',105,1009,105,}",
	[7] = "{7,'中校',106,1010,106,}",
}
return {key = g_Config.t_military_rank_key_, data = g_Config.t_military_rank } 
 -- 