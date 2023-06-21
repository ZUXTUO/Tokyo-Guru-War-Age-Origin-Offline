gd_fight_script_60107014 =
{
	relive_rules = {hero_relive_on_dead = false},
	is_match_player_level = true,  --怪物是否匹配玩家等级（覆盖怪物等级配置），默认为false	
	
	limit_loader = -- 
	{
		{	
			top = 15, -- 上限
			down = 10, -- 下限
			delay = 0.01,  -- 延迟多久开始（s)
			monster_delay = 0.2,-- 默认刷怪间隔
			list =
			{--循环刷
				 {monster_id = 31611300,count = 100, pos_alias = "sbp_1",}, 
			} 
		},
	}
}
