gd_fight_script_60107038 =
{
	relive_rules = {hero_relive_on_dead = false},
	is_match_player_level = true,  --怪物是否匹配玩家等级（覆盖怪物等级配置），默认为false	
	
	monster_wave = {
		{	
			delta_time_s = 5,  
			monsters = 
			{--第1波
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=0.2,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=0.4,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=0.6,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=0.8,}, 
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=1,}, 
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=1.2,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=3,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=3.2,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=3.4,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=3.6,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=3.8,}, 
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4,}, 
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4.2,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8.2,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8.4,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8.6,}, 
				 {monster_id = 31614600,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8.8,}, 
			} 
		},
		{	
			monsters = 
			{--第2波
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4.2,}, 
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4.4,}, 
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4.6,},  
				 {monster_id = 31614610,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4.8,}, 
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=5,},  
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=5.2,},  
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=5.4,},  
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=5.6,},  
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=5.8,}, 
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=9,},  
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=9.2,},  
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=9.4,},  
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=9.6,},  
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=9.8,}, 
			} 
		},
		{	
			monsters = 
			{--第3波
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4,}, 
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4.2,}, 
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=4.4,}, 
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=7,}, 
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=7.2,}, 
				 {monster_id = 31614602,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=7.4,}, 
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=9,}, 
				 {monster_id = 31614620,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=9.2,}, 
				 {monster_id = 31614601,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=9.4,}, 
			} 
		},
	}
}
