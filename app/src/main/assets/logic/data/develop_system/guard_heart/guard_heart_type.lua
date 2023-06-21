--守护者编号	需求英雄类型(1防 2攻 3技 4男5女)	生命值	攻击力	防御力	开启等级	开启需要的英雄(资质|数量)	开启战力	开启钻石数量
g_Config.t_guard_heart_type_key_ = {
	id=1,
	type=2,
	max_hp=3,
	atk_power=4,
	def_power=5,
	open_level=6,
	open_hero_num=7,
	open_fight_vale=8,
	open_crystal=9,
}
g_Config.t_guard_heart_type = {
	[1] = "{1,2,0,0,45.66090475,37,0,1,0,}",
	[2] = "{2,3,3683.629054,0,0,55,0,120000,0,}",
	[3] = "{3,1,0,147.6767982,0,62,0,150000,0,}",
	[4] = "{4,4,0,0,45.66090475,68,0,180000,0,}",
	[5] = "{5,5,0,147.6767982,0,75,{6,1,},0,0,}",
}
return {key = g_Config.t_guard_heart_type_key_, data = g_Config.t_guard_heart_type } 
 -- 