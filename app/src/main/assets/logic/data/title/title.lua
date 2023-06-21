--称号ID	称号名称	描述	解锁类型	解锁参数1	解锁参数2	解锁参数3	解锁参数4	解锁参数5	生命值	攻击力	防御力	暴击率(%)	免爆率(%)	暴击伤害(%)	破击率(%)	格挡几率	格挡伤害加成(%)
g_Config.t_title_key_ = {
	title_id=1,
	title_name=2,
	title_dis=3,
	unlock_ConditionType=4,
	unlock_param1=5,
	unlock_param2=6,
	unlock_param3=7,
	unlock_param4=8,
	unlock_param5=9,
	max_hp=10,
	atk_power=11,
	def_power=12,
	crit_rate=13,
	anti_crite=14,
	crit_hurt=15,
	broken_rate=16,
	parry_rate=17,
	parry_plus=18,
}
g_Config.t_title = {
	[10001] = "{10001,'新的一天','颜值突破天际',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}",
}
return {key = g_Config.t_title_key_, data = g_Config.t_title } 
 -- 