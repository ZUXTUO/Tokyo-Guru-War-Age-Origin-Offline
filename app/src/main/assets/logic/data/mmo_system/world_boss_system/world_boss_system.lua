--星期(1->7=星期一->天)	开启时间	持续时间(秒)	BOSS信息	玩家刷新坐标	鼓舞消耗	鼓舞增加	玩家单场游戏时间(秒)	大图标	boss类型图片
g_Config.t_world_boss_system_key_ = {
	weekday=1,
	begin_time=2,
	last_time=3,
	boss_info=4,
	player_country_born_pos=5,
	inspire_cost=6,
	inspire_add=7,
	player_time_limit=8,
	big_icon=9,
	boss_type_name=10,
}
g_Config.t_world_boss_system = {
	[1] = "{1,'10:00',50400,{id = 31590000,x = 0,y = 0,},{{x = -43.7,y = -24.9,},{x = 44.9,y = -24.8,},{x = -0.2,y = 51.3,},},{5,10,15,20,25,30,35,40,45,50,55,60,70,80,90,100,},10,600,'assetbundles/prefabs/ui/image/backgroud/world_boss/sjboss_beijing.assetbundle','sjboss_meishuzi1',}",
	[2] = "{2,'10:00',50400,{id = 31590001,x = 0,y = 0,},{{x = -43.7,y = -24.9,},{x = 44.9,y = -24.8,},{x = -0.2,y = 51.3,},},{5,10,15,20,25,30,35,40,45,50,55,60,70,80,90,100,},10,600,'assetbundles/prefabs/ui/image/backgroud/world_boss/sjboss_beijing2.assetbundle','sjboss_meishuzi2',}",
	[3] = "{3,'10:00',50400,{id = 31590000,x = 0,y = 0,},{{x = -43.7,y = -24.9,},{x = 44.9,y = -24.8,},{x = -0.2,y = 51.3,},},{5,10,15,20,25,30,35,40,45,50,55,60,70,80,90,100,},10,600,'assetbundles/prefabs/ui/image/backgroud/world_boss/sjboss_beijing.assetbundle','sjboss_meishuzi1',}",
	[4] = "{4,'10:00',50400,{id = 31590001,x = 0,y = 0,},{{x = -43.7,y = -24.9,},{x = 44.9,y = -24.8,},{x = -0.2,y = 51.3,},},{5,10,15,20,25,30,35,40,45,50,55,60,70,80,90,100,},10,600,'assetbundles/prefabs/ui/image/backgroud/world_boss/sjboss_beijing2.assetbundle','sjboss_meishuzi2',}",
	[5] = "{5,'10:00',50400,{id = 31590000,x = 0,y = 0,},{{x = -43.7,y = -24.9,},{x = 44.9,y = -24.8,},{x = -0.2,y = 51.3,},},{5,10,15,20,25,30,35,40,45,50,55,60,70,80,90,100,},10,600,'assetbundles/prefabs/ui/image/backgroud/world_boss/sjboss_beijing.assetbundle','sjboss_meishuzi1',}",
	[6] = "{6,'10:00',50400,{id = 31590001,x = 0,y = 0,},{{x = -43.7,y = -24.9,},{x = 44.9,y = -24.8,},{x = -0.2,y = 51.3,},},{5,10,15,20,25,30,35,40,45,50,55,60,70,80,90,100,},10,600,'assetbundles/prefabs/ui/image/backgroud/world_boss/sjboss_beijing2.assetbundle','sjboss_meishuzi2',}",
	[7] = "{7,'10:00',50400,{id = 31590001,x = 0,y = 0,},{{x = -43.7,y = -24.9,},{x = 44.9,y = -24.8,},{x = -0.2,y = 51.3,},},{5,10,15,20,25,30,35,40,45,50,55,60,70,80,90,100,},10,600,'assetbundles/prefabs/ui/image/backgroud/world_boss/sjboss_beijing.assetbundle','sjboss_meishuzi2',}",
}
return {key = g_Config.t_world_boss_system_key_, data = g_Config.t_world_boss_system } 
 -- 