--系数ID	闪避系数	格挡系数	破击系数	暴击系数	免暴系数	格挡伤害系数	暴击伤害加成系数	克制属性加伤系数	克制属性免伤系数	治疗效果加成系数	吸血率系数	反弹率系数	生命回复率系数	技能CD缩减系数	攻击速度加成系数	全能系数
g_Config.t_property_ratio_key_ = {
	id=1,
	dodge_raio=2,
	parry_ratio=3,
	broken_ratio=4,
	crite_ratio=5,
	anti_crite_ratio=6,
	parry_plus_ratio=7,
	crit_hurt_ratio=8,
	restrain_plus_ratio=9,
	restrain_reduct_ratio=10,
	treat_plus_ratio=11,
	bloodsuck_rate_ratio=12,
	rally_rate_ratio=13,
	res_hp_ratio=14,
	cool_down_dec_ratio=15,
	attack_speed_ratio=16,
	quan_neng_ratio=17,
}
g_Config.t_property_ratio = {
	[1] = "{1,3333.333333,3333.333333,3333.333333,3333.333333,3333.333333,20000,5000,10000,10000,3333.333333,3333.333333,3333.333333,3333.333333,3333.333333,3333.333333,{{min = 1,max = 100000,ratio = 0.1,},},}",
}
return {key = g_Config.t_property_ratio_key_, data = g_Config.t_property_ratio } 
 -- 