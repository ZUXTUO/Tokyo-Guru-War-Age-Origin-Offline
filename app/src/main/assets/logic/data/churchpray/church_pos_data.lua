--星级	人数上限	可祈祷的时间(秒)	可驻守英雄	挑战消耗精力	被挑战获得精力	产出资源1	产出资源1ICON	产出资源2	产出资源2ICON	产出资源3	产出资源3ICON	产出资源4	产出资源4ICON	产出资源5	产出资源5ICON	抢夺胜利掉落
g_Config.t_church_pos_data_key_ = {
	star=1,
	poscnt=2,
	canPrayTime=3,
	heroCnt=4,
	cos_vigor=5,
	defend_get_vigor=6,
	resource_num_1=7,
	resource_icon_1=8,
	resource_num_2=9,
	resource_icon_2=10,
	resource_num_3=11,
	resource_icon_3=12,
	resource_num_4=13,
	resource_icon_4=14,
	resource_num_5=15,
	resource_icon_5=16,
	dropid=17,
}
g_Config.t_church_pos_data = {
	[1] = "{1,2000,14400,3,10,0,2,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_jinbi.assetbundle',6,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_jingyan.assetbundle',20000126,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_yanjiudian.assetbundle',20000309,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/3v3baxiang.assetbundle',0,0,80001,}",
	[2] = "{2,500,21600,3,10,0,2,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_jinbi.assetbundle',6,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_jingyan.assetbundle',20000126,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_yanjiudian.assetbundle',20000309,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/3v3baxiang.assetbundle',0,0,80002,}",
	[3] = "{3,100,36000,6,10,0,2,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_jinbi.assetbundle',6,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_jingyan.assetbundle',20000126,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/ld_yanjiudian.assetbundle',20000309,'assetbundles/prefabs/ui/image/icon/equip_item/150_150/3v3baxiang.assetbundle',0,0,80003,}",
}
return {key = g_Config.t_church_pos_data_key_, data = g_Config.t_church_pos_data } 
 -- 