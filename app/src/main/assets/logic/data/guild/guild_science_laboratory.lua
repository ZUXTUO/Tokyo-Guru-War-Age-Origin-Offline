--顺序id	b	名字	开启等级	文字描述	图标	捐献配置	系统id(与guild_tech_donate中type对应）
g_Config.t_guild_science_laboratory_key_ = {
	index=1,
	name=2,
	guild_level=3,
	des=4,
	icon=5,
	cfg=6,
	system_id=7,
}
g_Config.t_guild_science_laboratory = {
	[1] = "{1,gs_string_name.guild1,3,gs_string_name.guild101,'st_tb_shetuanrenshu','guild_lab_num_add_level',1,}",
	[2] = "{2,gs_string_name.guild2,4,gs_string_name.guild102,'st_tb_jingyingrenshu','guild_lab_elite_num_add_level',2,}",
}
return {key = g_Config.t_guild_science_laboratory_key_, data = g_Config.t_guild_science_laboratory } 
 -- 