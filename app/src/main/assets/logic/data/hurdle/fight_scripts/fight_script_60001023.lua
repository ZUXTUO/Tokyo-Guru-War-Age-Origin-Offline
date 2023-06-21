gd_fight_script_60001023 =
{
	relive_rules = {hero_relive_on_dead = false},
	
	buff_group = {
        [1]={
            begin_time = 10,                       --* 游戏开始后多少秒开始刷
            point_list = {"buff_1",},     		--* 刷出位置map_info中
            refresh_time = 30,                      --* 每多少秒刷新一次
            {
                {buff_id=43, probability = 1},
            }
        },
        [2]={
            begin_time = 10,                       --* 游戏开始后多少秒开始刷
            point_list = {"buff_2",},    			--* 刷出位置map_info中
            refresh_time = 30,                      --* 每多少秒刷新一次
            {
                {buff_id=43, probability = 1},
            }
        },
	},
}
