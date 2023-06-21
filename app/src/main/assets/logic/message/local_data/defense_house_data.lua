--玩法单机数据

local _timerId = nil
local _defenseHouseData = nil;

_playerData =
{
    
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



g_defense_house_local = {};

function g_defense_house_local.cg_complete()
 	_timerId = timer.create("g_defense_house_local.gc_complete", 1000, 1);
end 

function g_defense_house_local.gc_complete()
	msg_defense_house.gc_complete(true);
	timer.stop(_timerId)
end