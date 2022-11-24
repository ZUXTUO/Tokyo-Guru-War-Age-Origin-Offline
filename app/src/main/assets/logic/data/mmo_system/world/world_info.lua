--地图或玩法id	出生点	连接点	地图战斗限制(0:和平模式 1:国家模式 2:阵营模式	地图名字	地图所属国家id	小地图	策划备注
g_Config.t_world_info_key_ = {
	world_id=1,
	born_pos=2,
	link=3,
	fight_restirct=4,
	name=5,
	country_id=6,
	area_map_path=7,
}
g_Config.t_world_info = {
	[1] = "{1,{{x = -47.4,y = -33.7,country_id = 1,},{x = 46.8,y = 32.9,country_id = 2,},{x = -47.4,y = 20.3,country_id = 3,},},0,1,gs_organization_describe.des_10001,0,'assetbundles/prefabs/ui/image/backgroud/map/dt_zhongyuanditu774x548.assetbundle',}",
	[60120003] = "{60120003,{{x = -47.4,y = -33.7,country_id = 1,},{x = 46.8,y = 32.9,country_id = 2,},{x = -47.4,y = 20.3,country_id = 3,},},0,1,gs_organization_describe.des_10001,0,'assetbundles/prefabs/ui/image/backgroud/map/dt_zhongyuanditu774x548.assetbundle',}",
	[60105000] = "{60105000,{{x = -47.4,y = -33.7,country_id = 1,},{x = 46.8,y = 32.9,country_id = 2,},{x = -47.4,y = 20.3,country_id = 3,},},0,0,gs_organization_describe.des_10001,0,'assetbundles/prefabs/ui/image/backgroud/map/dt_zhongyuanditu774x548.assetbundle',}",
}
return {key = g_Config.t_world_info_key_, data = g_Config.t_world_info } 
 -- 