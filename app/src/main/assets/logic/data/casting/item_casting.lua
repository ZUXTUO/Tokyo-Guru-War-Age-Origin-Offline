--图样编号	重铸/锻造(1 重铸,2 锻造)	锻造成功的物品（奖池表读取奖池id）	消耗金币	预览物品id	是否是装备(1是，0不是)
g_Config.t_item_casting_key_ = {
	id=1,
	type=2,
	drop_id=3,
	gold=4,
	preview_id=5,
	is_equip=6,
}
g_Config.t_item_casting = {
	[20000042] = "{20000042,2,20000030,80000,20000030,1,}",
	[20000043] = "{20000043,2,20000051,80000,20000051,1,}",
	[20000044] = "{20000044,2,20000052,80000,20000052,1,}",
	[20000045] = "{20000045,2,20000053,80000,20000053,1,}",
	[20000046] = "{20000046,2,20000054,80000,20000054,1,}",
	[20000047] = "{20000047,2,20000055,80000,20000055,1,}",
	[20000048] = "{20000048,1,20000054,80000,20000054,1,}",
	[20000049] = "{20000049,1,20000055,80000,20000055,1,}",
	[20000050] = "{20000050,2,20000005,20000,20000005,0,}",
	[20000093] = "{20000093,2,20000031,120000,20000031,1,}",
	[20000094] = "{20000094,2,20000100,120000,20000100,1,}",
	[20000095] = "{20000095,2,20000101,120000,20000101,1,}",
	[20000096] = "{20000096,2,20000102,120000,20000102,1,}",
	[20000097] = "{20000097,2,20000103,120000,20000103,1,}",
	[20000098] = "{20000098,2,20000104,120000,20000104,1,}",
	[20000099] = "{20000099,2,20000006,30000,20000006,0,}",
}
return {key = g_Config.t_item_casting_key_, data = g_Config.t_item_casting } 
 -- 