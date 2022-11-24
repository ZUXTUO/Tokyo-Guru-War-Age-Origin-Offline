--玩家单机数据

local _timerId = nil
local _playerData = nil;

_playerData =
{
    playerid = 123,
	name = '单机测试',			--玩家名
	ap = 10,					--体力
	exp = 60,				--经验
	level = 1,				--等级
	vip = 1,					--vip等级
	gold = 100,				--金币
	crystal = 100,			--钻石(货币)
}

local _playerChatData = nil;
_playerChatData = 
{
	type = 1,
	content = "单机模式",
	srcplayername = "单机模式";
	viplevel = 1;
	rolecard_number = 1;
	date = "单机模式";
}



g_player_local = {};

function g_player_local.req_player()
 	_timerId = timer.create("g_player_local.res_player", 1000, 1);
end 

function g_player_local.res_player()
	player.res_player(_playerData);
	timer.stop(_timerId)
end

function g_player_local.cg_rand_name()
 	_timerId = timer.create("g_player_local.gc_rand_name", 1000, 1);
end 

function g_player_local.gc_rand_name()
	player.gc_rand_name(_playerData.name);
	timer.stop(_timerId)
end

function g_player_local.cg_set_name()
 	_timerId = timer.create("g_player_local.gc_set_name", 1000, 1);
end 

function g_player_local.gc_set_name()
	player.gc_set_name(MsgEnum.error_code.error_code_success);
	timer.stop(_timerId)
end

function g_player_local.cg_create_player_info()
	_timerId = timer.create("g_player_local.gc_create_player_info", 1000, 1);
end

function g_player_local.gc_create_player_info()
	player.gc_create_player_info(MsgEnum.error_code.error_code_success);
	timer.stop(_timerId)
end

function g_player_local.cg_player_chat()
	_timerId = timer.create("g_player_local.gc_player_chat", 1000, 1);
end

function g_player_local.gc_player_chat()
	player.gc_player_chat(_playerChatData.type, _playerChatData.content, 
						_playerChatData.srcplayername, _playerChatData.viplevel, 
						_playerChatData.rolecard_number, _playerChatData.date);
	timer.stop(_timerId)
end


























