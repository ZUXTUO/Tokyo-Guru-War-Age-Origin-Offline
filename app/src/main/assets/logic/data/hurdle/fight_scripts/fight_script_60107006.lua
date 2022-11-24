gd_fight_script_60107006 =
{
	relive_rules = {hero_relive_on_dead = false},
	is_match_player_level = true,  --怪物是否匹配玩家等级（覆盖怪物等级配置），默认为false	
	
	limit_loader = -- 
	{
		{	
			top = 1, -- 上限
			down = 1, -- 下限
			delay = 0.01,  -- 延迟多久开始（s)
			monster_delay = 5,-- 默认刷怪间隔
			list =
			{--循环刷
				 {monster_id = 31617100,count = 999, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 102,}, 
			} 
		},
		{	
			top = 1, -- 上限
			down = 1, -- 下限
			delay = 0.01,  -- 延迟多久开始（s)
			monster_delay = 3,-- 默认刷怪间隔
			list =
			{--循环刷
				 {monster_id = 31617101,count = 999, pos_alias = "sbp_2", way_point_alias = "swp_1",ai_id = 102,}, 
			} 
		},
	}
}
