--增长属性编号	策划备注(隐藏列)	挂载类型(1近小兵 2远小兵 3强小兵 4塔一 5塔二 6塔三 7基地)	移动速度(%)	暴击率(%)	暴击伤害(%)	冷却缩减(%)	物理穿透(%)	能量穿透(%)	生命回复(%)	物理吸血(%)	能量吸血(%)	物理反弹(%)	能量反弹(%)	免爆率(%)	物理普攻1段	物理普攻2段	物理普攻3段	能量普攻1段	能量普攻2段	能量普攻3段	物理攻击强度	能量攻击强度	物理防御强度	能量防御强度	最大生命值
g_Config.t_add_monster_property_key_ = {
	id=1,
	type=2,
	speed=3,
	crit_rate=4,
	crit_hurt=5,
	cool_down=6,
	physical_pene=7,
	spell_pene=8,
	res_hp=9,
	physical_vampire=10,
	spell_vampire=11,
	physical_rally=12,
	spell_rally=13,
	anti_crite=14,
	attack_physical_1=15,
	attack_physical_2=16,
	attack_physical_3=17,
	attack_spell_1=18,
	attack_spell_2=19,
	attack_spell_3=20,
	physical_attack_power=21,
	spell_attack_power=22,
	physical_defense_power=23,
	spell_defense_power=24,
	max_hp=25,
}
g_Config.t_add_monster_property = {
	[1] = "{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}",
}
return {key = g_Config.t_add_monster_property_key_, data = g_Config.t_add_monster_property } 
 -- 