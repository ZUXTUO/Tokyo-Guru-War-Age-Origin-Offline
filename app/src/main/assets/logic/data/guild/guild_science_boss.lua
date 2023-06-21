--顺序id	b	名字	开启等级	文字描述	图标	捐献配置	系统id(与guild_tech_donate中type对应）
g_Config.t_guild_science_boss_key_ = {
	index=1,
	name=2,
	guild_level=3,
	des=4,
	icon=5,
	cfg=6,
	system_id=7,
}
g_Config.t_guild_science_boss = {
	[1] = "{1,gs_string_name.guild3,2,gs_string_name.guild103,'st_tb_goumaicishu','guild_boss_buy_count',3,}",
	[2] = "{2,gs_string_name.guild4,3,gs_string_name.guild104,'st_tb_guwujiacheng','guild_boss_buff_add',4,}",
}
return {key = g_Config.t_guild_science_boss_key_, data = g_Config.t_guild_science_boss } 
 -- 