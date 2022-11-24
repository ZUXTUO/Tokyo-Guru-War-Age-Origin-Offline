--玩家单机数据

local _timerId = nil
local _jiaotangInfo = nil;
local _heroDetailInfo = nil;

_jiaotangInfo =
{
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
}


local EHeroType = 
{
	none = 0,     --没人
	human = 1,    --玩家
	robot = 2,    --机器人
}

for i=1,20 do
	_jiaotangInfo[1][i] = 
	{
		player_info = 
		{
			playerid = 1,
			name = "教堂单机玩家1_"..i,
			image = 32000000,
			teams = {{10001},{},{},{},{},{},{},{},{},{}};
		},
		package_info =
		{
			hero = 
			{
				{
					dataid = 10001,
					number = 30001000,
					level = 1,
					equip = {},
				}
			}
		},
		other_data =
		{
			remain_time = 60*30,
			pos = i,
			hero_type = EHeroType.human,
		},
	}
end

_heroDetailInfo = 
{
	level = 1,
	number = 30001000,
	dataid = 77777777,
	equip = {},
}

--教堂祈祷单机数据
g_msg_jtqd_local = {};

function g_msg_jtqd_local.cg_get_all_pos_info(star_level)
	g_msg_jtqd_local.callback1 = Utility.create_callback(g_msg_jtqd_local.gc_get_all_pos_info, star_level, _jiaotangInfo[star_level]);
 	_timerId = timer.create(g_msg_jtqd_local.callback, 1000, 1);
end 

function g_msg_jtqd_local.gc_get_all_pos_info(star_level,info)
	Utility.del_callback(g_msg_jtqd_local.callback1);
	msg_jtqd.gc_get_all_pos_info(star_level,info);
	timer.stop(_timerId)
end

function g_msg_jtqd_local.cg_get_hero_info(star_level,pos)
	g_msg_jtqd_local.callback2 = Utility.create_callback(g_msg_jtqd_local.gc_get_hero_info, star_level,pos, _heroDetailInfo);
 	_timerId = timer.create(g_msg_jtqd_local.callback2, 1000, 1);
end

function g_msg_jtqd_local.gc_get_hero_info(star_level,pos,info)
	Utility.del_callback(g_msg_jtqd_local.callback2);
	msg_jtqd.gc_get_hero_info(star_level,pos,info)
	timer.stop(_timerId)
end