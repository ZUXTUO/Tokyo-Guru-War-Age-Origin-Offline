--语言包（1中文）	单位值	单位文字	最小值
g_Config.t_number_to_str_sub_key_ = {
	type=1,
	unit_value=2,
	unit=3,
	min_number=4,
}
g_Config.t_number_to_str = {
	[1] = "{{1,1.00E+12,'%.0f万亿',1.00E+12,},{1,1.00E+08,'%.0f亿',1.00E+11,},{1,100000000,'%.1f亿',100000000,},{1,10000,'%.0f万',1000000,},}",
}
return {sub_key = g_Config.t_number_to_str_sub_key_, data = g_Config.t_number_to_str } 
 -- 