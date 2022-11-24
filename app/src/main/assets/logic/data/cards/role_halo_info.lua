--星级	技能	技能名称	图标	描述	升级变化信息飘字	精简描述	技能等级（1无，2中级，3高级，4特级，5究极）
g_Config.t_role_halo_info_sub_key_ = {
	role_id=1,
	skill=2,
	name=3,
	small_icon=4,
	base_describe=5,
	levelup_info=6,
	simple_describe=7,
	rank=8,
}
g_Config.t_role_halo_info = {
	[30020300] = "{{30020300,5,'高级暴击综合强化','assetbundles/prefabs/ui/image/icon/bei_dong/90_90/beidongjineng_12.assetbundle',gs_skill_describe.hero_30020300_passive_5,gs_skill_levelup_info.hero_30020300_passive_5,gs_skill_simple_describe.hero_30020300_passive_5,3,},}",
	[30025300] = "{{30025300,5,'高级暴伤强化','assetbundles/prefabs/ui/image/icon/bei_dong/90_90/beidongjineng_15.assetbundle',gs_skill_describe.hero_30025300_passive_5,gs_skill_levelup_info.hero_30025300_passive_5,gs_skill_simple_describe.hero_30025300_passive_5,3,},}",
	[30029300] = "{{30029300,5,'特级暴伤格挡强化','assetbundles/prefabs/ui/image/icon/bei_dong/90_90/beidongjineng_12.assetbundle',gs_skill_describe.hero_30029300_passive_5,gs_skill_levelup_info.hero_30029300_passive_5,gs_skill_simple_describe.hero_30029300_passive_5,4,},}",
	[30054300] = "{{30054300,5,'特级暴击强化','assetbundles/prefabs/ui/image/icon/bei_dong/90_90/beidongjineng_14.assetbundle',gs_skill_describe.hero_30054300_passive_5,gs_skill_levelup_info.hero_30054300_passive_5,gs_skill_simple_describe.hero_30054300_passive_5,4,},}",
}
return {sub_key = g_Config.t_role_halo_info_sub_key_, data = g_Config.t_role_halo_info } 
 -- 