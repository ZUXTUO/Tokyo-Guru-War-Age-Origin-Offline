--装备当前品质	合成后品质	成功奖励装备编号(参考掉落表)	消耗金币	返还1件概率(%，总体随机）	返还2件概率(%，总体随机）	返还3件概率(%，总体随机）	返还4件概率(%，总体随机）	返还5件概率(%，总体随机）
g_Config.t_equip_composite_key_ = {
	rarity=1,
	next_rarity=2,
	success_equip_id=3,
	gold=4,
	return_equip_1=5,
	return_equip_2=6,
	return_equip_3=7,
	return_equip_4=8,
	return_equip_5=9,
}
g_Config.t_equip_composite = {
	[1] = "{1,2,3000,1000,80,18,2,0,0,}",
	[2] = "{2,3,3001,2000,80,18,2,0,0,}",
	[3] = "{3,4,3002,20000,80,18,2,0,0,}",
	[4] = "{4,5,3003,50000,80,18,2,0,0,}",
}
return {key = g_Config.t_equip_composite_key_, data = g_Config.t_equip_composite } 
 -- 