gd_fight_script_60001031 =
{
	name = "GaoSuJuJi",
	relive_rules = {},
	-- is_match_player_level = false,
	
	
	score = 
	{
		[33006301] = 30,--A怪
		[33006302] = 30,--B怪
		[33006303] = 30,--C怪
		[33006310] = 200,--精英
	},
limit_loader = -- 
	{
		{
			--A怪（血薄）
			top = 4, -- 上限
			down = 1, -- 下限
			delay = 0.01,  -- 延迟多久开始（s)
			monster_delay = 0.1,-- 默认刷怪间隔
			list =
			{
				{monster_id = 33006301,count = 28, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 100}, 
			},
		},
		{
			--B怪（中血）
			top = 4, -- 上限
			down = 1, -- 下限
			delay = 4,  -- 延迟多久开始（s)
			monster_delay = 0.1,-- 默认刷怪间隔
			list =
			{
				{monster_id = 33006302,count = 28, pos_alias = "sbp_2", way_point_alias = "swp_2",ai_id = 100}, 
			},
		},
		{
			--C怪（血厚）
			top = 4, -- 上限
			down = 1, -- 下限
			delay = 8,  -- 延迟多久开始（s)
			monster_delay = 0.1,-- 默认刷怪间隔
			list =
			{
				{monster_id = 33006303,count = 24, pos_alias = "sbp_3", way_point_alias = "swp_3",ai_id = 100}, 
			},
		},
		
		{
			--精英
			top = 1, -- 上限
			down = 1, -- 下限
			delay = 8,  -- 延迟多久开始（s)
			monster_delay = 6,-- 默认刷怪间隔
			list =
			{
				{monster_id = 33006310,count = 3, pos_alias = "sbp_2", way_point_alias = "swp_2",ai_id = 100}, 
			},
		},
	},
}