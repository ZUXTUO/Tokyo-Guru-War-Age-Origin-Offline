--节点类型编号	策划注释	是否能进攻或防守	防守队伍上限	进攻队伍上限	占领积分
g_Config.t_guild_war_node_type_key_ = {
	id=1,
	b=2,
	can_attack_or_defense=3,
	defense_limit=4,
	attack_limit=5,
	occupy_score=6,
}
g_Config.t_guild_war_node_type = {
	[1] = "{1,'基地',0,0,0,5,}",
	[2] = "{2,'要塞',1,30,30,3,}",
	[3] = "{3,'堡垒',1,20,20,2,}",
	[4] = "{4,'据点',1,15,15,1,}",
}
return {key = g_Config.t_guild_war_node_type_key_, data = g_Config.t_guild_war_node_type } 
 -- 