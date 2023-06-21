--当前品质	策划说明	装备生成概率	是否伪随机	失败次数	伪随机生成概率
g_Config.t_equip_composite_rate_sub_key_ = {
	rarity=1,
	b=2,
	equip_rate=3,
	is_pseudorandom=4,
	fail_number=5,
	pseudorandom_rate=6,
}
g_Config.t_equip_composite_rate = {
	[1] = "{{1,'白合绿',80,0,0,80,},}",
	[2] = "{{2,'绿合蓝',60,0,0,60,},}",
	[3] = "{{3,'蓝合紫',40,0,0,40,},}",
	[4] = "{{4,'紫合金',10,0,0,10,},}",
}
return {sub_key = g_Config.t_equip_composite_rate_sub_key_, data = g_Config.t_equip_composite_rate } 
 -- 