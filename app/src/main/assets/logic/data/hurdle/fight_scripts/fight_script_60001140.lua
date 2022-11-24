gd_fight_script_60001140 =
{
	relive_rules = {hero_relive_on_dead = false},
	
	buff_group = {
        [1]={
            begin_time = 10,                       --* 游戏开始后多少秒开始刷
            point_list = {"jiaxue_1",},     		--* 刷出位置map_info中
            refresh_time = 30,                      --* 每多少秒刷新一次
            {
                {buff_id=43, probability = 1},
            }
        },
        [2]={
            begin_time = 10,                       --* 游戏开始后多少秒开始刷
            point_list = {"jiaxue_2",},    			--* 刷出位置map_info中
            refresh_time = 30,                      --* 每多少秒刷新一次
            {
                {buff_id=43, probability = 1},
            }
        },
    },
		monster_wave = {
		{	
			delta_time_s = 3, 
			count = 1,
			monsters = 
			{--开场第一波
				 {monster_id = 31701400, flag = 1, count = 3, delta_time_s=0.5, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,}, --友方前3只近战小怪
				 {monster_id = 31701401, flag = 1, count = 1, delta_time_s=2, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,}, --友方第4只远程小怪
				 {monster_id = 31701400, flag = 1, count = 3, delta_time_s=0.5, pos_alias = "sbp_2", way_point_alias = "swp_2",ai_id = 102,}, --友方前3只近战小怪
				 {monster_id = 31701401, flag = 1, count = 1, delta_time_s=2, pos_alias = "sbp_2", way_point_alias = "swp_2",ai_id = 102,}, --友方第4只远程小怪
				 {monster_id = 31701405, flag = 2, count = 3, delta_time_s=0.5, pos_alias = "sbp_3", way_point_alias = "swp_3",ai_id = 102,}, --敌方前3只近战小怪
				 {monster_id = 31701406, flag = 2, count = 1, delta_time_s=2, pos_alias = "sbp_3", way_point_alias = "swp_3",ai_id = 102,}, --敌方第4只远程小怪
				 {monster_id = 31701405, flag = 2, count = 3, delta_time_s=0.5, pos_alias = "sbp_4", way_point_alias = "swp_4",ai_id = 102,}, --敌方前3只近战小怪
				 {monster_id = 31701406, flag = 2, count = 1, delta_time_s=2, pos_alias = "sbp_4", way_point_alias = "swp_4",ai_id = 102,}, --敌方第4只远程小怪
			} 
		},
		{	
			delta_time_s = 30, 
			count = -1,
			monsters = 
			{--无限刷
				 {monster_id = 31701400, flag = 1, count = 3, delta_time_s=0.5, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,}, --友方前3只近战小怪
				 {monster_id = 31701401, flag = 1, count = 1, delta_time_s=2, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,}, --友方第4只远程小怪
				 {monster_id = 31701400, flag = 1, count = 3, delta_time_s=0.5, pos_alias = "sbp_2", way_point_alias = "swp_2",ai_id = 102,}, --友方前3只近战小怪
				 {monster_id = 31701401, flag = 1, count = 1, delta_time_s=2, pos_alias = "sbp_2", way_point_alias = "swp_2",ai_id = 102,}, --友方第4只远程小怪
				 {monster_id = 31701405, flag = 2, count = 3, delta_time_s=0.5, pos_alias = "sbp_3", way_point_alias = "swp_3",ai_id = 102,}, --敌方前3只近战小怪
				 {monster_id = 31701406, flag = 2, count = 1, delta_time_s=2, pos_alias = "sbp_3", way_point_alias = "swp_3",ai_id = 102,}, --敌方第4只远程小怪
				 {monster_id = 31701405, flag = 2, count = 3, delta_time_s=0.5, pos_alias = "sbp_4", way_point_alias = "swp_4",ai_id = 102,}, --敌方前3只近战小怪
				 {monster_id = 31701406, flag = 2, count = 1, delta_time_s=2, pos_alias = "sbp_4", way_point_alias = "swp_4",ai_id = 102,}, --敌方第4只远程小怪
			} 
		},
	},
}
