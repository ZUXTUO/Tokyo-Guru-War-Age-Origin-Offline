--[[
	大乱斗单机数据
--]]
--声明timer, 延迟返回使用
local _timerId = nil

local _rank_list = {
	{
		playerid = "100001",
		name = "玩家1",
		point = 99999,
		heroIndex = 30001000,
	},
	{
		playerid = "100002",
		name = "玩家2",
		point = 99998,
		heroIndex = 30001005,
	},
	{
		playerid = "100003",
		name = "玩家3",
		point = 99997,
		heroIndex = 30001000,
	},
	{
		playerid = "100004",
		name = "玩家4",
		point = 99996,
		heroIndex = 30001005,
	},
	{
		playerid = "100005",
		name = "玩家5",
		point = 99995,
		heroIndex = 30001000,
	},
	{
		playerid = "100006",
		name = "玩家6",
		point = 99994,
		heroIndex = 30001005,
	},
	{
		playerid = "100007",
		name = "玩家7",
		point = 99993,
		heroIndex = 30001010,
	},
	{
		playerid = "100008",
		name = "玩家8",
		point = 99992,
		heroIndex = 30001010,
	},
	{
		playerid = "100009",
		name = "玩家9",
		point = 99991,
		heroIndex = 30001010,
	},
	{
		playerid = "100010",
		name = "玩家10",
		point = 99994,
		heroIndex = 30001010,
	},
}

local _champion_list = {
	{
		playerid = "100001",
		name = "玩家1",
		point = 99999,
		heroIndex = 30001000,
		seasonIndex = 1,
	},
	{
		playerid = "100002",
		name = "玩家2",
		point = 99998,
		heroIndex = 30001005,
		seasonIndex = 2,
	},
	{
		playerid = "100003",
		name = "玩家3",
		point = 99997,
		heroIndex = 30001000,
		seasonIndex = 3,
	},
	{
		playerid = "100004",
		name = "玩家4",
		point = 99996,
		heroIndex = 30001005,
		seasonIndex = 4,
	},
	{
		playerid = "100005",
		name = "玩家5",
		point = 99995,
		heroIndex = 30001000,
		seasonIndex = 5,
	},
	{
		playerid = "100006",
		name = "玩家6",
		point = 99994,
		heroIndex = 30001005,
		seasonIndex = 6,
	},
	{
		playerid = "100007",
		name = "玩家7",
		point = 99993,
		heroIndex = 30001010,
		seasonIndex = 7,
	},
	{
		playerid = "100008",
		name = "玩家8",
		point = 99992,
		heroIndex = 30001010,
		seasonIndex = 8,
	},
	{
		playerid = "100009",
		name = "玩家9",
		point = 99991,
		heroIndex = 30001010,
		seasonIndex = 9,
	},
	{
		playerid = "100010",
		name = "玩家10",
		point = 99994,
		heroIndex = 30001010,
		seasonIndex = 10,
	},

}

local _posIndex = 1

local _CreateRandomPlayer = function(playerid)
	local data = {}
	data.playerid = playerid
	data.name = "玩家" .. math.random(1, 10000)
	data.posIndex = _posIndex
	data.cardRole = {
		dataid = "0",
		number = 30001000,
		level = math.random(1, 30),
		hp_point = 10000,
		phy_at_point = 10000,
		energy_at_point = 10000,
		phy_def_point = 10000,
		energy_def_point = 10000,
		neidan_level = 0,
	}
	data.vecCardsEquip = {}

	_posIndex = _posIndex + 1

	return data
end

local _GetMatchPlayerData = function(playerid)
	if playerid == g_dataCenter.player.playerid then
		_posIndex = 1
	end
	return _CreateRandomPlayer(playerid)
end

local _index = 0
local _percent = 0
local _playeridList = {
	[1] = 100001,
	[2] = 100002,
	[3] = 100003,
	[4] = 100004,
}

-------------------------------------接口-------------------------------------

g_fuzion_local = {}


function g_fuzion_local.cg_request_my_daluandou_data()
	_timerId = timer.create("g_fuzion_local.gc_sync_my_daluandou_data", 1000, 1);
end
function g_fuzion_local.gc_sync_my_daluandou_data()
	timer.stop(_timerId)
	msg_daluandou.gc_sync_my_daluandou_data(0, 0, 0)
end


function g_fuzion_local.cg_request_top_rank()
	_timerId = timer.create("g_fuzion_local.gc_request_top_rank", 1000, 1);
end
function g_fuzion_local.gc_request_top_rank()
	timer.stop(_timerId)
	msg_daluandou.gc_request_top_rank(_rank_list)
end


function g_fuzion_local.cg_request_champion_list()
	_timerId = timer.create("g_fuzion_local.gc_request_champion_list", 1000, 1);
end
function g_fuzion_local.gc_request_champion_list()
	timer.stop(_timerId)
	msg_daluandou.gc_request_champion_list(_champion_list)
end


function g_fuzion_local.cg_start_match()
	_timerId = timer.create("g_fuzion_local.gc_start_match", 1000, 1);
end
function g_fuzion_local.gc_start_match()
	timer.stop(_timerId)
	local playerid = g_dataCenter.player.playerid
	g_fuzion_local._help_match_timer();
	msg_daluandou.gc_update_match_player(0, _GetMatchPlayerData(playerid));
	msg_daluandou.gc_start_match(0)
end
function g_fuzion_local._help_match_timer()
	_timerId = timer.create("g_fuzion_local._help_match_func", 2000, 1);
end
function g_fuzion_local._help_match_func()
	timer.stop(_timerId)
	local playerid = _playeridList[1]
	msg_daluandou.gc_update_match_player(0, _GetMatchPlayerData(playerid));
	playerid = _playeridList[2]
	msg_daluandou.gc_update_match_player(0, _GetMatchPlayerData(playerid));
	playerid = _playeridList[3]
	msg_daluandou.gc_update_match_player(0, _GetMatchPlayerData(playerid));

	-- 通知匹配锁定完成
	msg_daluandou.gc_match_finish()
end


function g_fuzion_local.cg_cancel_match()
	_timerId = timer.create("g_fuzion_local.gc_cancel_match", 1000, 1);
end
function g_fuzion_local.gc_cancel_match()
	timer.stop(_timerId)
	msg_daluandou.gc_cancel_match(0)
end


function g_fuzion_local.cg_load_state(percent)
	_percent = percent
	_timerId = timer.create("g_fuzion_local.gc_load_state", 1000, 1);
end
function g_fuzion_local.gc_load_state()
	timer.stop(_timerId)

	local playerid = g_dataCenter.player.playerid
	world_msg.gc_load_state(playerid, _percent)
	playerid = _playeridList[1]
	world_msg.gc_load_state(playerid, _percent)
	playerid = _playeridList[2]
	world_msg.gc_load_state(playerid, _percent)
	playerid = _playeridList[3]
	world_msg.gc_load_state(playerid, _percent)
end