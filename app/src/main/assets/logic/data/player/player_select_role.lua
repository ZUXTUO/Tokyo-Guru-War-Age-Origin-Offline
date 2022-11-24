--顺序编号	英雄id编号	关卡id	英雄描述	模型根节点命名	模型节点命名	英雄名字贴图命名	英雄属性侧重	英雄属性品级
g_Config.t_player_select_role_key_ = {
	id=1,
	role_id=2,
	hurdle_id=3,
	role_des=4,
	unity_name=5,
	role_name=6,
	texture_name=7,
	role_property=8,
	role_grade=9,
}
g_Config.t_player_select_role = {
	[1] = "{1,30006100,60121000,gs_string_name.rn36,'select_role_1','dizuo','xiweijin',{0.3,0.4,0.7,},{'C','B','A',},}",
	[2] = "{2,30010100,60121001,gs_string_name.rn37,'select_role_2','dizuo','pingzizhang',{0.7,0.3,0.4,},{'A','C','B',},}",
	[3] = "{3,30012100,60121002,gs_string_name.rn38,'select_role_3','dizuo','anjiunaibai',{0.4,0.7,0.3,},{'B','A','C',},}",
}
return {key = g_Config.t_player_select_role_key_, data = g_Config.t_player_select_role } 
 -- 