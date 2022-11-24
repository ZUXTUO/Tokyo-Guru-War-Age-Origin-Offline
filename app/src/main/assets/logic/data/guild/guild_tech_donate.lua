--id	捐献类型(0 社团捐献, 1 社团人数捐献， 2 社团实验室精英捐献,3 boss研究所购买鼓励次数, 4 boss研究所buff加成, 5 boss研究所额外复活次数， 6 boss研究所boss等级提升)	捐献物品	捐献数量	获得的贡献值	增加经验	标题图片名	背景图片名	开放等级
g_Config.t_guild_tech_donate_key_ = {
	id=1,
	type=2,
	item_id=3,
	item_num=4,
	contribution=5,
	exp=6,
	title_name=7,
	bg_name=8,
	open_level=9,
}
g_Config.t_guild_tech_donate = {
	[100] = "{100,0,2,10000,50,50,gs_string_name.guild209,'st_jinbijuanxian',1,}",
	[101] = "{101,0,3,50,100,80,gs_string_name.guild210,'st_shuijingjuanxina',1,}",
	[102] = "{102,0,3,200,200,100,gs_string_name.guild211,'st_zhizunjuanxian',1,}",
	[103] = "{103,1,2,10000,50,50,gs_string_name.guild209,'st_jinbijuanxian',3,}",
	[104] = "{104,1,3,50,100,80,gs_string_name.guild210,'st_shuijingjuanxina',3,}",
	[105] = "{105,1,3,200,200,100,gs_string_name.guild211,'st_zhizunjuanxian',3,}",
	[106] = "{106,2,2,10000,50,50,gs_string_name.guild209,'st_jinbijuanxian',4,}",
	[107] = "{107,2,3,50,100,80,gs_string_name.guild210,'st_shuijingjuanxina',4,}",
	[108] = "{108,2,3,200,200,100,gs_string_name.guild211,'st_zhizunjuanxian',4,}",
	[109] = "{109,3,2,10000,50,50,gs_string_name.guild209,'st_jinbijuanxian',2,}",
	[110] = "{110,3,3,50,100,80,gs_string_name.guild210,'st_shuijingjuanxina',2,}",
	[111] = "{111,3,3,200,200,100,gs_string_name.guild211,'st_zhizunjuanxian',2,}",
	[112] = "{112,4,2,10000,50,50,gs_string_name.guild209,'st_jinbijuanxian',3,}",
	[113] = "{113,4,3,50,100,80,gs_string_name.guild210,'st_shuijingjuanxina',3,}",
	[114] = "{114,4,3,200,200,100,gs_string_name.guild211,'st_zhizunjuanxian',3,}",
	[115] = "{115,5,2,10000,50,50,gs_string_name.guild209,'st_jinbijuanxian',4,}",
	[116] = "{116,5,3,50,100,80,gs_string_name.guild210,'st_shuijingjuanxina',4,}",
	[117] = "{117,5,3,200,200,100,gs_string_name.guild211,'st_zhizunjuanxian',4,}",
	[118] = "{118,6,2,10000,50,50,gs_string_name.guild209,'st_jinbijuanxian',5,}",
	[119] = "{119,6,3,50,100,80,gs_string_name.guild210,'st_shuijingjuanxina',5,}",
	[120] = "{120,6,3,200,200,100,gs_string_name.guild211,'st_zhizunjuanxian',5,}",
}
return {key = g_Config.t_guild_tech_donate_key_, data = g_Config.t_guild_tech_donate } 
 -- 