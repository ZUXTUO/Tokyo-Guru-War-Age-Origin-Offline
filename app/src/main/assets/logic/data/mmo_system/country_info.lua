--国家id	策划备注	国家名字	图标
g_Config.t_country_info_key_ = {
	id=1,
	b=2,
	name=3,
	icon=4,
}
g_Config.t_country_info = {
	[1] = "{1,'1区（国家1）',gs_organization_describe.des_1,1,}",
	[2] = "{2,'11区（国家2）',gs_organization_describe.des_2,2,}",
	[3] = "{3,'20区（国家3）',gs_organization_describe.des_3,3,}",
	[4] = "{4,'21区（弃）',gs_organization_describe.des_4,4,}",
	[5] = "{5,'22区（弃）',gs_organization_describe.des_5,5,}",
	[6] = "{6,'8区（弃）',gs_organization_describe.des_6,6,}",
	[7] = "{7,'新手村',gs_organization_describe.des_7,7,}",
	[8] = "{8,'中原',gs_organization_describe.des_8,8,}",
}
return {key = g_Config.t_country_info_key_, data = g_Config.t_country_info } 
 -- 