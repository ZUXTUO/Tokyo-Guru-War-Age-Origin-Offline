gd_fight_script_60001027 =
{
	relive_rules = {hero_relive_on_dead = false},
	
	
	buff_group = {
        [1]={
            begin_time = 0.01,                       --* 游戏开始后多少秒开始刷
            point_list = {"buff1","buff2","buff3","buff4","buff5","buff6","buff7","buff8","buff9","buff10","buff11","buff12","buff13","buff14","buff15","buff16","buff17","buff18","buff19","buff20",},  --* 刷出位置map_info中
            refresh_time = 5,                      --* 每多少秒刷新一次
			max_cont = 5,                           -- 最大存在数量，不填则把所有位置刷满为止
			cont = 5,                               -- 每次刷多少个，可不填，默认为1
			clear_refresh_time = 5,                 -- 刷满后清除一个后间隔多少秒刷新下一个，不填为取消该规则
            {
                {buff_id=400, probability = 1},
            }
        },
	},
	
	monster_wave = {
			{	
				delta_time_s = 5,  
				monsters = 
				{--第1波
					 {monster_id = 33005600,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=0},
					 {monster_id = 33005600,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=0.2},
				} 
			},
			{
				monsters = 
				{--第2波
					 {monster_id = 33005601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=6},
					 {monster_id = 33005602,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=6},
					 {monster_id = 33005601,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=6},
				} 
			},
			{
				monsters = 
				{--第3波
					 {monster_id = 33005601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8},
					 {monster_id = 33005602,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8},
					 {monster_id = 33005602,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8.2},
				} 
			},
			{
				monsters = 
				{--第4波
					 {monster_id = 33005601,count = 1, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8},
					 {monster_id = 33005602,count = 1, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8},
					 {monster_id = 33005601,count = 1, pos_alias = "sbp_3", way_point_alias = "swp_1",ai_id = 102,delta_time_s=8},
				} 
			},

	}
}