--动作_id	动作名称	触发条件	该动作是否会导致角色倒地(0不会1会)	备注
g_Config.t_action_list_key_ = {
	id=1,
	name=2,
	fsm_trigger=3,
	fall=4,
	inf=5,
}
g_Config.t_action_list = {
	[1] = "{1,'attack01','t_attack01',0,'普攻01',}",
	[2] = "{2,'attack02','t_attack02',0,'普攻02',}",
	[3] = "{3,'attack03','t_attack03',0,'普攻03',}",
	[4] = "{4,'skill01','t_skill01',0,'技能01',}",
	[5] = "{5,'skill02','t_skill02',0,'技能02',}",
	[6] = "{6,'skill03','t_skill03',0,'技能03',}",
	[7] = "{7,'skill04','t_skill04',0,'技能04',}",
	[8] = "{8,'skill05','t_buff02',0,'技能05',}",
	[9] = "{9,'skill06','t_buff03',0,'技能06',}",
	[10] = "{10,'run','t_run',0,'跑步',}",
	[11] = "{11,'hit','t_hit',0,'受伤',}",
	[12] = "{12,'die','t_die',0,'死亡',}",
	[13] = "{13,'hit_L','t_hit_f',0,'左面受击',}",
	[14] = "{14,'hit_R','t_hit_b',0,'右面受击',}",
	[15] = "{15,'stun','t_stun',0,'眩晕状态',}",
	[16] = "{16,'up','t_up',0,'上升',}",
	[17] = "{17,'getup','t_getup',0,'起身',}",
	[18] = "{18,'down','t_down',0,'下降',}",
	[19] = "{19,'dangling','t_dangling',0,'悬空',}",
	[20] = "{20,'idle','t_idle',0,'休闲待机动作',}",
	[21] = "{21,'showstand','t_showstand',0,'界面展示待机',}",
	[22] = "{22,'show','t_show',0,'界面展示动画',}",
	[23] = "{23,'walk','t_walk',0,'走路',}",
	[24] = "{24,'stand','t_stand',0,'站立待机',}",
	[25] = "{25,'hit01','t_hit01',0,'技能受击1',}",
	[26] = "{26,'hit02','t_hit02',0,'技能受击2',}",
	[27] = "{27,'hit03','t_hit03',0,'技能受击3',}",
	[28] = "{28,'hit04','t_hit04',0,'技能受击4',}",
	[29] = "{29,'hit05','t_hit05',0,'技能受击5',}",
	[30] = "{30,'enter01','t_enter01',0,'出场01',}",
	[31] = "{31,'enter02','t_enter02',0,'出场02',}",
	[32] = "{32,'enter03','t_enter03',0,'出场03',}",
	[33] = "{33,'dead','t_dead',1,'已经死亡状态',}",
	[34] = "{34,'skill07','t_skill07',0,'技能07',}",
	[35] = "{35,'skill08','t_skill08',0,'技能08',}",
	[36] = "{36,'repel','t_repel',0,'击退动作',}",
	[37] = "{37,'skill09','t_skill09',0,'技能09',}",
	[38] = "{38,'attack04','t_attack04',0,'普攻04',}",
	[39] = "{39,'attack05','t_attack05',0,'普攻05',}",
	[40] = "{40,'attack06','t_attack06',0,'普攻06',}",
	[41] = "{41,'npcstand','t_npcstand',0,'NPC待机',}",
	[42] = "{42,'skill10','t_skill10',0,'技能10',}",
	[43] = "{43,'boss_show','t_boss_show',0,'boss出场展示',}",
	[44] = "{44,'win','t_win',0,'胜利展示',}",
	[45] = "{45,'lose','t_lose',0,'失败展示',}",
	[46] = "{46,'die01','t_die01',0,'死亡01',}",
	[47] = "{47,'dead01','t_dead01',1,'已经死亡状态01',}",
	[48] = "{48,'die02','t_die02',0,'死亡02',}",
	[49] = "{49,'dead02','t_dead02',1,'已经死亡状态02',}",
	[50] = "{50,'nd_show','t_nd_show',0,'扭蛋展示',}",
}
return {key = g_Config.t_action_list_key_, data = g_Config.t_action_list } 
 -- 