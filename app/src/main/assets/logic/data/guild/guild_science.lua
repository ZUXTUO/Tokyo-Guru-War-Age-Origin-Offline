--顺序id	策划说明	名字	名字图片	开启等级	未开启提示	图标	在子界面的图标	玩法说明	升级说明	子项配置
g_Config.t_guild_science_key_ = {
	index=1,
	name=2,
	name_icon=3,
	guild_level=4,
	tips=5,
	icon=6,
	small_icon=7,
	play_des=8,
	level_des=9,
	cfg=10,
}
g_Config.t_guild_science = {
	[1] = "{1,gs_string_name.guild201,'st_shiyanshi03',3,gs_string_name.guild202,'assetbundles/prefabs/ui/image/backgroud/guild/st_shiyanshi01.assetbundle','assetbundles/prefabs/ui/image/backgroud/guild/st_shiyanshi01.assetbundle',gs_string_name.guild203,gs_string_name.guild204,'guild_science_laboratory',}",
	[2] = "{2,gs_string_name.guild205,'st_bossyanjiu03',2,gs_string_name.guild206,'assetbundles/prefabs/ui/image/backgroud/guild/st_bossyanjiu01.assetbundle','assetbundles/prefabs/ui/image/backgroud/guild/st_bossyanjiu01.assetbundle',gs_string_name.guild207,gs_string_name.guild208,'guild_science_boss',}",
}
return {key = g_Config.t_guild_science_key_, data = g_Config.t_guild_science } 
 -- 