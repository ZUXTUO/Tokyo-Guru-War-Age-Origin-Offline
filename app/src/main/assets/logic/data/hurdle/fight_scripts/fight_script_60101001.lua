gd_fight_script_60101001 =
{
	name = "GaoSuJuJi",
	hero_id = 112;
	relive_rules = {hero_relive_on_dead = false},

	--A怪，31551000
	--B怪，31551001
	--C怪，31551002
	--精英，31551003
	--BOSS，31551004
	
	monster_wave_groud = {
		[1] = {
			{	
				delta_time_s = 3,
				monsters = 
				{--第1波（3秒时刻，每路10个A怪）
					 {monster_id = 31551001,count = 6,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551000,count = 4,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551000,count = 8,delta_time_s = 1,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 2,delta_time_s = 1,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551002,count = 6,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 4,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
				} 
			},
			{
				monsters = 
				{--第2波（30秒时刻，每路10个B怪）
					 {monster_id = 31551002,count = 5,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 1,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551002,count = 5,delta_time_s = 1,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551000,count = 5,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
				} 
			},
			{
				monsters = 
				{--第3波（60秒时刻，每路10个A怪，1个精英）
					 {monster_id = 31551000,count = 5,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551003,count = 1,delta_time_s = 10,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551000,count = 5,delta_time_s = 1,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 1,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551003,count = 1,delta_time_s = 10,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551000,count = 5,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551003,count = 1,delta_time_s = 10,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
				} 
			},
			{
				monsters = 
				{--第4波（90秒时刻，每路8个A怪，5个B怪）
					 {monster_id = 31551000,count = 8,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 2,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551000,count = 8,delta_time_s = 1,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 2,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551000,count = 8,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 5,delta_time_s = 2,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
				} 
			},
			{
				monsters = 
				{--第5波（120秒时刻，每路12个C怪，中路1个BOSS）
					 {monster_id = 31551002,count = 6,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 4,delta_time_s = 1,pos_alias = "sbp_1",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551002,count = 10,delta_time_s = 1,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551004,count = 1,delta_time_s = 10,pos_alias = "sbp_2",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551002,count = 6,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
					 {monster_id = 31551001,count = 6,delta_time_s = 1,pos_alias = "sbp_3",way_point_alias = "swp_1",ai_id = 102,target_type = 4},
				} 
			},
		},
	}
}