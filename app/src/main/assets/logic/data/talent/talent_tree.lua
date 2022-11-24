--id	策划注释	天赋树名称	天赋树描述	开启所需战队等级	上一条天赋树id	所需上条天赋树投入点	树根节点（此天赋树下第一个节点）
g_Config.t_talent_tree_key_ = {
	id=1,
	name=2,
	des=3,
	level=4,
	last_id=5,
	last_add=6,
	root_talent_id=7,
}
g_Config.t_talent_tree = {
	[40001000] = "{40001000,gs_string_name.talent1,gs_string_role_describe.talent1,31,0,0,40001000,}",
	[40002000] = "{40002000,gs_string_name.talent2,gs_string_role_describe.talent2,50,40001000,250,40002000,}",
	[40003000] = "{40003000,gs_string_name.talent3,gs_string_role_describe.talent3,70,40002000,350,40003000,}",
}
return {key = g_Config.t_talent_tree_key_, data = g_Config.t_talent_tree } 
 -- 