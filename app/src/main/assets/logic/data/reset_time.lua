--id	策划备注	重置时间	是否是全局重置（程序配置，策划不修改）
g_Config.t_reset_time_key_ = {
	id=1,
	b=2,
	reset=3,
	is_global=4,
}
g_Config.t_reset_time = {
	[100000] = "{100000,'关卡单关限次重置时间',{h = 3,i = 0,s = 0,},0,}",
	[100001] = "{100001,'社团战段位奖励发送邮件时间',{wd = 6,h = 21,i = 0,s = 0,},1,}",
	[100002] = "{100002,'社团战每日奖励发送邮件时间',{h = 21,i = 0,s = 0,},1,}",
	[100003] = "{100003,'角色历练重置英雄每周使用次数',{wd = 1,h = 5,i = 0,s = 0,},0,}",
}
return {key = g_Config.t_reset_time_key_, data = g_Config.t_reset_time } 
 -- 