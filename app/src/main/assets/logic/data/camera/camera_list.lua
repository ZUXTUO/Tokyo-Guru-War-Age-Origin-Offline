--编号	说明	相机地址	X旋转	Y旋转	Z距离	FOV	相机拉高值	相机偏移值	Skybox = 1,SolidColor = 2,Depth = 3,Nothing = 4		near clip plane	far clip plane	血条y轴偏移值	泛光强度	泛光阈值	人物泛光	模糊距离	镜头类型(0-普通跟随,1-环形,鱼缸镜头)	镜头离中心点的最大距离
g_Config.t_camera_list_key_ = {
	id=1,
	camera_file=2,
	followX=3,
	followY=4,
	followZ=5,
	fov=6,
	camera_offsetY=7,
	target_offsetY=8,
	clear_flags=9,
	background_color=10,
	clip_plane_near=11,
	clip_plane_far=12,
	hp_offset=13,
	bloomIntensity=14,
	bloomThreshold=15,
	bloomFactor=16,
	blurSize=17,
	lens_type=18,
	distance=19,
}
g_Config.t_camera_list = {
	[84205000] = "{84205000,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',-45,-30,13,35,1,1,1,{114,203,255,255,},0.3,1000,-30,1.2,0.51,0.3,1.8,0,0,}",
	[84205001] = "{84205001,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-30,13,35,1,1,1,{117,138,189,255,},0.3,1000,-30,2,0.17,0.3,1.8,0,0,}",
	[84205002] = "{84205002,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-30,13,35,1,1,1,{61,198,253,255,},0.3,1000,-30,1.63,0.51,0.25,1.8,0,0,}",
	[84205003] = "{84205003,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',-45,-30,13,35,1,1,1,{122,222,255,255,},0.3,1000,-30,1.8,0.96,0.3,1.8,0,0,}",
	[84205004] = "{84205004,'assetbundles/prefabs/scenecamera/s009_scenecamera_01.assetbundle',-45,-30,13,35,1,1,1,{188,101,253,255,},0.3,1000,-30,1.8,0.99,0.22,1.8,0,0,}",
	[84205005] = "{84205005,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-30,13,35,1,1,1,{179,106,225,255,},0.3,1000,-30,1.94,0.33,0.1,1.8,0,0,}",
	[84205006] = "{84205006,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',45,-30,13,35,1,1,1,{62,83,103,255,},0.3,1000,-30,2,0.24,0.6,1.8,0,0,}",
	[84205007] = "{84205007,'assetbundles/prefabs/scenecamera/s009_scenecamera_01.assetbundle',0,-30,13,35,1,1,1,{107,117,167,255,},0.3,1000,-20,2,0.27,0.6,1.8,0,0,}",
	[84205008] = "{84205008,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,1,1,1,{40,54,83,255,},0.3,1000,-30,2,0.15,0.6,1.8,0,0,}",
	[84205009] = "{84205009,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',35,-30,13,35,1,1,1,{171,152,132,255,},0.3,1000,-30,1.8,0.42,0.3,1.16,0,0,}",
	[84205010] = "{84205010,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-35,-30,13,35,1,1,1,{130,169,208,255,},0.3,1000,-30,2,0.53,0.6,1.8,0,0,}",
	[84205011] = "{84205011,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-30,13,35,1,1,1,{98,107,133,255,},0.3,1000,-30,1.8,0.49,0.3,1.8,0,0,}",
	[84205012] = "{84205012,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',-60,-30,13,35,1,1,1,{187,229,249,255,},0.3,1000,-30,0.93,0.36,0.3,1.8,0,0,}",
	[84205013] = "{84205013,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-30,13,35,1,1,1,{65,105,144,255,},0.3,1000,-30,0.19,0.8,0.25,1.8,0,0,}",
	[84205014] = "{84205014,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-30,13,35,1,1,1,{42,118,195,255,},0.3,1000,-30,2.6,0.6,0.6,2,0,0,}",
	[84205015] = "{84205015,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',-80,-30,13,35,0,1,1,{42,48,107,255,},0.3,1000,-30,2,0.27,0.6,2.84,0,0,}",
	[84205016] = "{84205016,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-80,-30,13,35,0,1,1,{56,55,103,255,},0.3,1000,-30,1.8,0.5,0.6,2,0,0,}",
	[84205017] = "{84205017,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,0,1,1,{20,212,196,255,},0.3,1000,-30,0.8,0.27,0.3,1.6,0,0,}",
	[84205018] = "{84205018,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-30,13,35,0,1,1,{58,92,148,255,},0.3,1000,-30,0.6,0.14,0.5,1.6,0,0,}",
	[84205019] = "{84205019,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',45,-30,13,35,1,1,1,{182,254,255,255,},0.3,1000,-30,1,0.3,0.2,1,0,0,}",
	[84205020] = "{84205020,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',45,-30,13,35,1,1,1,{182,254,255,255,},0.3,1000,-30,1.6,0.24,0.6,1,0,0,}",
	[84205021] = "{84205021,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',90,-30,13,35,1,1,1,{14,5,21,255,},0.3,1000,-30,2,0.26,0.6,1.13,0,0,}",
	[84205022] = "{84205022,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',90,-30,17,35,1,1,1,{114,155,234,255,},0.3,1000,-30,2.8,0.29,0.6,1.5,0,0,}",
	[84205023] = "{84205023,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',180,-30,13,35,1,1,1,{50,74,107,255,},0.3,1000,-30,0.67,0.22,0.3,1.8,0,0,}",
	[84205024] = "{84205024,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',180,-30,13,35,1,1,1,{44,95,165,255,},0.3,1000,-30,0.99,0.31,0.3,1.5,0,0,}",
	[84205025] = "{84205025,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-25,13,35,1,1,1,{40,54,83,255,},0.3,1000,-30,2.9,0.28,0.3,1.8,0,0,}",
	[84205026] = "{84205026,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-25,13,35,1,1,1,{178,139,246,255,},0.3,1000,-30,1.73,0.23,0.6,2,0,0,}",
	[84205027] = "{84205027,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',-90,-30,13,60,0,0.5,1,{92,61,49,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205028] = "{84205028,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',180,-30,13,35,1,1,1,{54,23,60,255,},0.3,1000,-30,0.12,1.5,0.25,1,0,0,}",
	[84205029] = "{84205029,'assetbundles/prefabs/scenecamera/s002_scenecamera_02.assetbundle',-135,-30,17,35,1,1,1,{203,196,112,255,},0.3,1000,-30,0.8,0.3,0.1,0.8,0,0,}",
	[84205030] = "{84205030,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-30,13,35,1,1,1,{78,101,156,255,},0.3,1000,-30,0.8,0.4,0.5,1.6,0,0,}",
	[84205031] = "{84205031,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,1,1,1,{79,41,78,255,},0.3,1000,-30,1,0.13,0.3,1.5,0,0,}",
	[84205032] = "{84205032,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,1,1,1,{79,41,78,255,},0.3,1000,-30,1,0.13,0.3,1.5,0,0,}",
	[84205033] = "{84205033,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-20,13,35,1,1,1,{79,41,78,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205034] = "{84205034,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',90,-30,13,35,1,1,1,{12,56,99,255,},0.3,1000,-30,1.8,0.31,0.3,1.5,0,0,}",
	[84205035] = "{84205035,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,1,1,1,{105,224,255,255,},0.3,1000,-30,2.2,0.72,0.6,2.53,0,0,}",
	[84205036] = "{84205036,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',180,-30,13,35,1,1,1,{72,89,122,255,},0.3,1000,-30,2,0.37,0.3,1.5,0,0,}",
	[84205037] = "{84205037,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,1,1,1,{96,116,165,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205038] = "{84205038,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',6,-8,9,35,0,0.5,1,{114,203,255,255,},0.3,1000,-30,2.6,0.4,0.35,2.53,0,0,}",
	[84205039] = "{84205039,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-30,13,35,1,1,1,{66,23,84,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205040] = "{84205040,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',-45,-30,16,35,0,1,1,{66,23,84,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205041] = "{84205041,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-30,13,35,0,0.5,1,{98,107,133,255,},0.3,1000,-30,1.8,0.49,0.1,1.5,0,0,}",
	[84205042] = "{84205042,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,0,0.5,1,{96,116,165,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205043] = "{84205043,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-20,14,35,0,1.5,1,{178,139,246,255,},0.3,1000,-30,1,0.11,0.5,2.53,0,0,}",
	[84205044] = "{84205044,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-7,12,35,0,2.3,1,{178,139,246,255,},0.3,1000,-30,0,0,0,0,0,0,}",
	[84205045] = "{84205045,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,0.5,1,2,{178,139,246,255,},0.3,1000,-30,1.42,0.2,0.6,1.5,1,40,}",
	[84205046] = "{84205046,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-10,13,35,0.5,1,1,{178,139,246,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205047] = "{84205047,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-30,13,35,0.5,1,1,{178,139,246,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205048] = "{84205048,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',180,-30,13,35,1,1,1,{72,89,122,255,},0.3,1000,-30,1.59,0.6,0.3,1.5,0,0,}",
	[84205049] = "{84205049,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',90,-30,17,35,1,1,1,{114,155,234,255,},0.3,1000,-30,2.8,0.29,0.6,1.5,0,0,}",
	[84205050] = "{84205050,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',6,-8,9,35,0,0.5,1,{114,203,255,255,},0.3,1000,-30,1.4,0.4,0.45,1.27,0,0,}",
	[84205052] = "{84205052,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',6,-8,9,35,0,0.5,1,{114,203,255,255,},0.3,1000,-30,1.8,0.2,0.43,0.25,0,0,}",
	[84205053] = "{84205053,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',6,-8,9,35,0,0.5,1,{114,203,255,255,},0.3,1000,-30,1,0.4,0.8,1,0,0,}",
	[84205054] = "{84205054,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',6,-8,9,35,0,0.5,1,{114,203,255,255,},0.3,1000,-30,1.25,0.6,0.45,1,0,0,}",
	[84205055] = "{84205055,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-25,13,35,1,1,1,{178,139,246,255,},0.3,1000,-30,1.73,0.23,0.6,2,0,0,}",
	[84205056] = "{84205056,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,1,1,1,{105,224,255,255,},0.3,1000,-30,2.2,0.72,0.6,2.53,0,0,}",
	[84205057] = "{84205057,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',0,-30,13,35,1,1,1,{79,41,78,255,},0.3,1000,-30,1.4,0.13,0.4,1.5,0,0,}",
	[84205058] = "{84205058,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',-90,-25,13,35,1,1,1,{40,54,83,255,},0.3,1000,-30,2.9,0.28,0.3,2,0,0,}",
	[84205059] = "{84205059,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',0,-30,13,35,1,1,1,{78,101,156,255,},0.3,1000,-30,2.6,0.4,0.5,2.53,0,0,}",
	[84205060] = "{84205060,'assetbundles/prefabs/scenecamera/s009_scenecamera_01.assetbundle',0,-30,17,35,1,1,1,{107,117,167,255,},0.3,1000,-20,2,0.27,0.6,1.5,0,0,}",
	[84205061] = "{84205061,'assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle',45,-30,21,35,1,1,1,{182,254,255,255,},0.3,1000,-30,1.33,0.3,0.2,1.5,0,0,}",
	[84205062] = "{84205062,'assetbundles/prefabs/scenecamera/s001_scenecamera_02.assetbundle',45,-30,20,35,1,1,1,{182,254,255,255,},0.3,1000,-30,1.6,0.24,0.6,1,0,0,}",
}
return {key = g_Config.t_camera_list_key_, data = g_Config.t_camera_list } 
 -- 