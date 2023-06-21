gd_fight_script_60001133 =
{
	relive_rules = {hero_relive_on_dead = false},
	
	buff_group = {
        [1]={
            begin_time = 10,                       --* 游戏开始后多少秒开始刷
            point_list = {"buff_1",},     		--* 刷出位置map_info中
            refresh_time = 30,                      --* 每多少秒刷新一次
            {
                {buff_id=30, probability = 1},		--未知库 攻击buff
            }
        },
        [2]={
            begin_time = 10,                       --* 游戏开始后多少秒开始刷
            point_list = {"buff_2",},    			--* 刷出位置map_info中
            refresh_time = 30,                      --* 每多少秒刷新一次
            {
                {buff_id=32, probability = 1},		--未知库 恢复buff
            }
        },
        [3]={
            begin_time = 10,                       --* 游戏开始后多少秒开始刷
            point_list = {"buff_3",},    			--* 刷出位置map_info中
            refresh_time = 30,                      --* 每多少秒刷新一次
            {
                {buff_id=40, probability = 1},		--未知库 缓慢buff
            }
        },
        [4]={
            begin_time = 10,                       --* 游戏开始后多少秒开始刷
            point_list = {"buff_4",},    			--* 刷出位置map_info中
            refresh_time = 30,                      --* 每多少秒刷新一次
            {
                {buff_id=26, probability = 1},		--已知库 回复buff
            }
        },
    },
}
