gd_fight_script_60001124 =
{
	name = "BaoWeiCanChang",
	relive_rules = {},
	-- is_match_player_level = false,
	
	score = 
	{
		[31001240] = 50,--A怪（血厚慢速）
		[31001241] = 50,--B怪（血薄快速）
		[31001242] = 50,--C怪（中血中速眩晕）
	},

	monster_wave = {
		{	
			delta_time_s = 0.01, 
			count = 1,
			monsters = 
			{
				 {monster_id = 31001240,count = 2, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 105}, 
				 {monster_id = 31001241,count = 2, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 105}, 
				 {monster_id = 31001242,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102}, 
			},
		},
		{	
			delta_time_s = 10, 
			count = 1,
			monsters = 
			{
				 {monster_id = 31001240,count = 4, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 105}, 
				 {monster_id = 31001241,count = 4, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 105}, 
				 {monster_id = 31001242,count = 2, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102}, 
			},
		},
		{	
			delta_time_s = 20, 
			count = 3,
			monsters = 
			{
				 {monster_id = 31001240,count = 4, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 105}, 
				 {monster_id = 31001241,count = 4, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 105}, 
				 {monster_id = 31001242,count = 2, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102}, 
			},
		},
	}
}