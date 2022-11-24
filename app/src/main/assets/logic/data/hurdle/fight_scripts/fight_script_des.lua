-- 玩法脚本配置
-- *为必填内容
-- 选填内容若不用直接删掉或者填nil
--[[
gd_fight_script_玩法id =
{
	name = "GaoSuJuJi", --*玩法名字
	hero_id = 100,		--该玩法英雄ai
	is_match_player_level = false,  --怪物是否匹配玩家等级(覆盖怪物等级配置),默认为false

    buff_group = {
        [1]={
            begin_time = 100,                       --* 游戏开始后多少秒开始刷
            point_list = {"item_1", "item_2",},     --* 刷出位置map_info中
            refresh_time = 5,                       --* 每多少秒刷新一次
            cont = 1,                               -- 每次刷多少个，可不填，默认为1
            max_cont = 2,                           -- 最大存在数量，不填则把所有位置刷满为止

            ------------
            clear_refresh_time = 0,                 -- 刷满后清除一个后间隔多少秒刷新下一个，不填为取消该规则
            clear_old = 0,                          -- 到达最大时，再刷是否清除之前的。0为不清楚，1为删除最老的，2为随机清除
            -- ps:clear_refresh_time配有时间时，clear_old不可配为1或2
            ------------

            -- * 刷出buff列表
            {
                {buff_id=1, probability = 0.2},
                -- buff_id对应world_item.txt，probability概率
                ...
            }
        },
        ....
    },
	
	monster_wave_groud = {  --分大小波刷怪
		[1] = {				--第一大波怪
			{				--第一小波怪
				description = "",   		--描述注释

				--若不配时间，则为杀完场上怪后，再刷
				delta_time_s = 2,   		--等待多少秒开始这一波
				delta_time_range = {3,6}, 	--等待随机3~6内秒开始这一波（与前一个只能同时存在一个）

				count = 1,					--这一波刷几次
				monsters = 					--*这一波刷的怪（与前一个只能同时存在一个）
				{
				  --{*怪物id       ,怪物所属阵营(默认为2敌方)   ,怪物等级(默认为1),个数     ,随机个数	1~3		 ,*刷怪位置(范围内随机), 刷怪路径(范围内随机)	 ,怪物ai	 ,怪物攻击类型    ,等待0.1秒刷一个怪 ,出场动作,等待0.1~0.5秒刷一个怪	    , 	修改怪物模型大小		,怪物死亡后效果={{效果函数,触发概率},{效果函数,触发概率},}
					{monster_id = 1,flag = 2                    ,level = 1 		  ,count = 1,count_range = {1,3}, pos_alias = "sbp_1" , way_point_alias = "wp_1",ai_id = 103,target_type = 10, delta_time_s=0.1,  anim_id=30,delta_time_range={0.1,0.5}, scalex=1,scaley=1,scalez=1,on_dead_callback = {{"pub_obj_into_fridge",0.1},},}, 
					...
				} 
			},
			{				--第二小波怪
				...
			},
		},
		[2] = {				--第二大波怪
			{				--第一小波怪
				...
			},
			...
		},
		...
	},
	monster_wave = {  --简单刷怪
		{			--第一小波怪
			description = "",   		--描述注释
			delta_time_s = 2,   		--等待多少秒开始这一波
			delta_time_range = {3,6}, 	--等待随机范围内秒开始这一波（与前一个只能同时存在一个）
			count = 1,					--这一波刷几次
			monsters = 					--这一波刷的怪（与前一个只能同时存在一个）
			{
			  --{怪物id        ,怪物所属阵营(默认为2敌方)   ,怪物等级(默认为1),个数     ,随机个数			 , 刷怪位置(范围内随机), 刷怪路径(范围内随机)	 ,怪物ai	 ,怪物攻击类型    , 怪物死亡后效果={{效果函数,触发概率},{效果函数,触发概率},}
				{monster_id = 1,flag = 2                    ,level = 1 		  ,count = 1,count_range = {1,3}, pos_alias = "sbp_1" , way_point_alias = "wp_1",ai_id = 103,target_type = 10, on_dead_callback = {{"pub_obj_into_fridge",0.1},},}, 
				...
			} 
		},
		{			--第二小波怪
			...
		},
		...
	},
}
--]]
