--编号	文件路径	观察模式（0：free， 1：look@target）	观察点	绑定到被观察目标（0:no,1:yes）	备注	
g_Config.t_camera_animation_key_ = {
	id=1,
	file_name=2,
	mode=3,
	point=4,
	bind=5,
	inf=6,
	shotpos=7,
}
g_Config.t_camera_animation = {
	[1001] = "{1001,'s001_cameraeffect_buff',0,0,1,'金木buff（通用）',}",
	[1002] = "{1002,'s001_cameraeffect_die',0,0,0,'金木死亡（通用）',}",
	[1003] = "{1003,'s001_cameraeffect_erupt',1,1,1,'金木爆发（通用）',}",
	[1004] = "{1004,'s001_cameraeffect_fall',0,0,1,'金木抓人（通用）',}",
	[1005] = "{1005,'s001_cameraeffect_jump',1,1,1,'金木跳墙（通用）',}",
	[1006] = "{1006,'s001_cameraeffect_wall_u',0,0,0,'金木蹬墙（通用）',}",
	[1007] = "{1007,'s001_cameraeffect_wall_r',1,1,1,'金木墙上跑（通用）',}",
	[1008] = "{1008,'s001_cameraeffect_show',0,0,1,'金木开场UI（通用）',}",
	[1009] = "{1009,'s001_cameraeffect_start',0,0,1,'金木战斗开始（通用）',}",
	[1010] = "{1010,'s001_cameraeffect_win',1,1,1,'金木胜利（通用）',}",
	[1011] = "{1011,'s001_cameraeffect_end',0,0,0,'金木作战成功（通用）',}",
	[2001] = "{2001,'s001_cameraeffect_skill',0,0,1,'金木大招',}",
	[2002] = "{2002,'s002_cameraeffect_skill',0,0,1,'董香大招',}",
	[2003] = "{2003,'h001_cameraeffect_skill',1,3,1,'亚门大招',}",
	[2004] = "{2004,'h012_cameraeffect_skill',1,3,1,'真户晓大招',}",
	[3001] = "{3001,'s001_cameraeffect_show',1,3,1,'测试版上场人物特写',{{5.004,25.496,},{5.004,21.359,},},}",
}
return {key = g_Config.t_camera_animation_key_, data = g_Config.t_camera_animation } 
 -- 