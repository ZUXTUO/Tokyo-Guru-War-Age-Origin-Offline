--编号id	开启等级	最低品质	基准战力	增加属性
g_Config.t_world_treasure_box_backup_key_ = {
	id=1,
	open_level=2,
	min_rarity=3,
	base_fight_value=4,
	add_property=5,
}
g_Config.t_world_treasure_box_backup = {
	[1] = "{1,10,1,1,{{id = 30000002,add = 200,ratio = 1.2,},{id = 30000003,add = 200,ratio = 1.2,},},}",
	[2] = "{2,20,2,2,{{id = 30000002,add = 200,ratio = 1.2,},{id = 30000003,add = 200,ratio = 1.2,},},}",
	[3] = "{3,30,3,3,{{id = 30000002,add = 200,ratio = 1.2,},{id = 30000003,add = 200,ratio = 1.2,},},}",
	[4] = "{4,40,4,4,{{id = 30000002,add = 200,ratio = 1.2,},{id = 30000003,add = 200,ratio = 1.2,},},}",
	[5] = "{5,50,5,5,{{id = 30000002,add = 200,ratio = 1.2,},{id = 30000003,add = 200,ratio = 1.2,},},}",
	[6] = "{6,60,6,6,{{id = 30000002,add = 200,ratio = 1.2,},{id = 30000003,add = 200,ratio = 1.2,},},}",
}
return {key = g_Config.t_world_treasure_box_backup_key_, data = g_Config.t_world_treasure_box_backup } 
 -- 