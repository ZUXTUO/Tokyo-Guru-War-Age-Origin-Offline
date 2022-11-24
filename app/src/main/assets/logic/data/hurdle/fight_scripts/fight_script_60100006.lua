gd_fight_script_60100006 =
{
	name = "BaoWeiCanChang",
	relive_rules = {},
	-- is_match_player_level = false,
	
	score = 
	{
		[31595600] = 30,--A怪（血薄）
		[31595601] = 30,--B怪（中血）
		[31595602] = 30,--C怪（血厚）
		[31595603] = 200,--精英
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
				{monster_id = 31595600,count = 28, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 100}, 
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
				{monster_id = 31595601,count = 28, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 100}, 
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
				{monster_id = 31595602,count = 24, pos_alias = "sbp_1", way_point_alias = "swp_1",ai_id = 100}, 
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
				{monster_id = 31595603,count = 3, pos_alias = "sbp_2", way_point_alias = "swp_2",ai_id = 100}, 
			},
		},
	},
	
}