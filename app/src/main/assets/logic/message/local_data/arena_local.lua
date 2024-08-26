--玩家单机数据

local _timerId = nil
local _playerData = {};
local _promote_player = nil;

for i = 1, 21 do
	_playerData[i] = {};
	_playerData[i].playerGid = tostring(9990000 + i);
	_playerData[i].szPlayerName = "单机测试" .. i;			-- 玩家名
	_playerData[i].fightPoint = 10000 - i * 100;	-- 战力		new
	_playerData[i].rankIndexID = i;						-- 排名		new
	
	if i > 10 then
		_playerData[i].rankIndexID = 2 * i;
	end
	_playerData[i].vecCardsRole = {}
	_playerData[i].vecCardsEquip = {}
	for j = 1, 3 do
		_playerData[i].vecCardsRole[j] = {
			dataid = "1000000" + j,
			number = 30001000 + 5 * (j - 1),
			level = 20,
		}
		-- _playerData[i].vecCardsEquip[j] = {
		-- 	dataid = "2000000" + j,
		-- 	number = 10021000,
		-- 	level = 20,
		-- 	roleid = "1000000" + j;
		-- }
	end

	_playerData[i].teamInfo = {
		teamid=8,
		cards=_playerData[i].vecCardsRole,
		heroLineup={6,7,8},
		soldierLineup={2,3,4,11,12},
	}
end

-- 获取本地玩家数据
local function _SetLocalPlayerData()
	local player = g_dataCenter.player;
	_playerData[15].playerGid = player.playerid;
	_playerData[15].szPlayerName = player.name;
	_playerData[15].teamInfo.cards=player:GetDefTeam()
	local heroLineup = {}
	for i, v in ipairs(_playerData[15].teamInfo.cards) do
		table.insert(heroLineup, 5+i)
	end

	-- 构造1个晋级战对手
	_promote_player = {
		playerGid = tostring(9990100);
		szPlayerName = "晋级测试对手";			-- 玩家名
		fightPoint = 10100;				-- 战力		new
		rankIndexID = 100;						-- 排名		new
		vecCardsRole = {};
		vecCardsEquip = {};
	}
	for j = 1, 3 do
		_promote_player.vecCardsRole[j] = {
			dataid = "1000000" + j,
			number = 30001000 + 5 * (j - 1),
			level = 20,
		}
		_promote_player.vecCardsEquip[j] = {
			dataid = "2000000" + j,
			number = 10000000 + j,
			level = 20,
			roleid = "1000000" + j;
		}
	end
end

function GetPromotePlayer()
	_SetLocalPlayerData()
	return _playerData[15]
end

g_msg_arena_local = {};

-- 请求本段位竞技场列表
function g_msg_arena_local.cg_arena_request_player_list()
	_SetLocalPlayerData(); -- 设置测试数据到数据中心
	_timerId = timer.create("g_msg_arena_local.gc_arena_sync_player_list", 5, 1);
end

-- 同步本段位竞技场玩家列表
function g_msg_arena_local.gc_arena_sync_player_list()
	local topPlayerData = {};
	local curlayerData = {};
	for i = 1, 10 do
		table.insert(topPlayerData, _playerData[i])
	end
	for i = 11, 15 do
		table.insert(curlayerData, _playerData[i])
	end
	msg_activity.gc_arena_sync_player_list(0, topPlayerData);
	msg_activity.gc_arena_sync_player_list(1, curlayerData);
	-- msg_activity.gc_arena_sync_player_list(_playerData);
	timer.stop(_timerId);
end

-- 请求战斗记录
function g_msg_arena_local.cg_arena_request_fight_report()
	_timerId = timer.create("g_msg_arena_local.gc_arena_request_fight_report", 5, 1);
end

-- 请求战斗记录返回
function g_msg_arena_local.gc_arena_request_fight_report()
	-- TODO
	msg_activity.gc_arena_request_fight_report(  );
	timer.stop(_timerId)
end

-- 请求自己的竞技场数据
function g_msg_arena_local.cg_arena_request_myslef_info()
	_timerId = timer.create("g_msg_arena_local.gc_arena_sync_myself_info", 5, 1);
end

-- 同步自己竞技场数据
function g_msg_arena_local.gc_arena_sync_myself_info()
	-- TODO
	msg_activity.gc_arena_sync_myself_info(1, 15, 1, 1, system.time() + 50, 0);
	timer.stop(_timerId)
end
