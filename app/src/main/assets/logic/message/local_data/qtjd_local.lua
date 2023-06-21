--玩家单机数据

local _timerId = nil
local _awardId = nil
local _roleid = 0
local _roomId = 0
local _ntype = 0
local _playerid = 0

local _ThreeToThree = {
	integral = 0,
	challenge_times = 0,
	rank = 1000,
	winCount = 0,
	killCount = 0,
	cur_state = 0,
	cur_time = 0,
	open_role = {30410000,30410010,30410020,30410030,30410040,30410050},
	integral_awards = {},
	curSeason = 0,
}


local _get_ThreeToThreePlayerInfo = function ()
	return 
	{
		roleId = 30001000,
		leader = true,
		playerid = g_dataCenter.player.playerid,
		name = g_dataCenter.player.name,
	}
end

local _get_list_ThreeToThreePlayerInfo = function ()
	local list = {
		{
			roleId = 30001000,
			leader = true,
			playerid = g_dataCenter.player.playerid,
			name = g_dataCenter.player.name,
		},
		{
			roleId = 30001000,
			leader = false,
			playerid = "123123123",
			name = "测试",
		},
	}
	return list
end


local _get_list_invite_ThreeToThreePlayerInfo = function ()
	local list = {
		{
			roleId = 30001000,
			leader = true,
			playerid = g_dataCenter.player.playerid,
			name = g_dataCenter.player.name,
		},
		{
			roleId = 30001000,
			leader = false,
			playerid = "123123123",
			name = "测试",
		},
		{
			roleId = 30001000,
			leader = false,
			playerid = "123456789",
			name = "被邀请",
		},
	}
	return list
end


local _get_playerid = function ()
	return g_dataCenter.player.playerid
end

local _get_ThreeToThreeVsInfo = function (isSure)
	return 
	{
		playerid = g_dataCenter.player.playerid,
		name = g_dataCenter.player.name,
		roleId = _roleid,
		state = isSure and 1 or 0,
	}
end

local _get_list_ThreeToThreeVsInfo = function ()
	return
	{
		{
			playerid = "99999",
			name = "测试玩家1",
			roleId = 0,
			image = 30005000,
			state = 0,
		},
		{
			playerid = "99998",
			name = "测试玩家2",
			roleId = 0,
			image = 30005000,
			state = 0,
		},
		{
			playerid = g_dataCenter.player.playerid,
			name = g_dataCenter.player.name,
			roleId = 0,
			image = 30005000,
			state = 0,
		},
	}
end

local _get_list_ThreeToThreeMatchInfo = function ()
	return 
	{
		{	
			playerid = "99999",
			name = "测试玩家1",
			image = 30005000,
			robot = true,
			enterState = 0,
		},
		{	
			playerid = "99998",
			name = "测试玩家2",
			image = 30005000,
			robot = true,
			enterState = 0,
		},
		{	
			playerid = g_dataCenter.player.playerid,
			name = g_dataCenter.player.name,
			image = 30005000,
			robot = false,
			enterState = 0,
		},
		{	
			playerid = "99997",
			name = "测试玩家3",
			image = 30005000,
			robot = true,
			enterState = 0,
		},
		{	
			playerid = "99996",
			name = "测试玩家4",
			image = 30005000,
			robot = true,
			enterState = 0,
		},
		{	
			playerid = "99995",
			name = "测试玩家5",
			image = 30005000,
			robot = true,
			enterState = 0,
		},
	}
end

--3V3玩法 单机数据
msg_qtjd_local = {};

function msg_qtjd_local.cg_three_to_three_state()
 	_timerId = timer.create("msg_qtjd_local.gc_three_to_three_state", 1000, 1);
end

function msg_qtjd_local.gc_three_to_three_state()
	timer.stop(_timerId)
	msg_three_to_three.gc_three_to_three_state(0, _ThreeToThree)
end

function msg_qtjd_local.cg_del_from_room(playerid)
	_playerid = playerid
 	_timerId = timer.create("msg_qtjd_local.gc_del_from_room", 1000, 1);
end

function msg_qtjd_local.gc_del_from_room()
	timer.stop(_timerId)
 	msg_three_to_three.gc_update_room_state(1, _get_list_ThreeToThreePlayerInfo())
 	msg_three_to_three.gc_del_from_room(0, _playerid)
end

function msg_qtjd_local.cg_team_room(ntype)
	_ntype = ntype
	_roleid = roleid
 	_timerId = timer.create("msg_qtjd_local.gc_team_room", 1000, 1);
end

function msg_qtjd_local.gc_team_room()
	timer.stop(_timerId)
 	msg_three_to_three.gc_update_room_state(1, _get_list_invite_ThreeToThreePlayerInfo())
 	msg_three_to_three.gc_team_room(0, _ntype, 0)
end

function msg_qtjd_local.cg_select_role(roomId, roleid)
	_roleid = roleid
 	_timerId = timer.create("msg_qtjd_local.gc_select_role", 1000, 1);
end

function msg_qtjd_local.gc_select_role()
	timer.stop(_timerId)
 	msg_three_to_three.gc_update_select_role(_get_ThreeToThreeVsInfo(false))
 	msg_three_to_three.gc_select_role(0, _roomId, _roleid)
end

function msg_qtjd_local.cg_sure_select_role(roomId, roleid)
	_roleid = roleid
 	_timerId = timer.create("msg_qtjd_local.gc_sure_select_role", 1000, 1);
end

function msg_qtjd_local.gc_sure_select_role()
	timer.stop(_timerId)
 	msg_three_to_three.gc_update_select_role(_get_ThreeToThreeVsInfo(true))
 	msg_three_to_three.gc_sure_select_role(0, _roomId, _roleid)
end

function msg_qtjd_local.cg_start_match()
 	_timerId = timer.create("msg_qtjd_local.gc_start_match", 1000, 1);
end

function msg_qtjd_local.gc_start_match()
	timer.stop(_timerId)
 	msg_three_to_three.gc_start_match(0, 0)

	msg_qtjd_local.cg_ready_finish()
end

function msg_qtjd_local.cg_match_finish()
	_timerId = timer.create("msg_qtjd_local.gc_match_finish", 3000, 1);
end

function msg_qtjd_local.gc_match_finish()
	msg_three_to_three.gc_match_finish(_get_list_ThreeToThreeVsInfo(), system.time(), 0)
end

function msg_qtjd_local.cg_cancel_match()
 	_timerId = timer.create("msg_qtjd_local.gc_cancel_match", 1000, 1);
end

function msg_qtjd_local.gc_cancel_match()
	timer.stop(_timerId)
 	msg_three_to_three.gc_cancel_match(0, _get_playerid())
end

function msg_qtjd_local.cg_ready_finish()
	_timerId = timer.create("msg_qtjd_local.gc_ready_finish", 5000, 1);
end

function msg_qtjd_local.gc_ready_finish()
	msg_three_to_three.gc_ready_finish(_get_list_ThreeToThreeMatchInfo())

	-- gc_enter_three_to_three
	msg_qtjd_local._gen_other_enter_msg()
end

function msg_qtjd_local.cg_enter_three_to_three()
	_enter_player_id = g_dataCenter.player.playerid
	_timerId = timer.create("msg_qtjd_local.gc_enter_three_to_three", 1000, 1);
end

function msg_qtjd_local._gen_other_enter_msg()
	_enter_ok_index = 0
	_enter_player_id = nil
	for i, v in ipairs(_get_list_ThreeToThreeMatchInfo()) do
		timer.create("msg_qtjd_local.gc_enter_three_to_three", 1000 * i, 1);
	end
end

function msg_qtjd_local.gc_enter_three_to_three()
	local enterPlayerId = 0
	if _enter_player_id then
		enterPlayerId = _enter_player_id
	elseif _enter_ok_index then
		_enter_ok_index = _enter_ok_index + 1
		local data = _get_list_ThreeToThreeMatchInfo()[_enter_ok_index]
		if data then
			enterPlayerId = data.playerid
		end
	end

	msg_three_to_three.gc_enter_three_to_three(0, enterPlayerId)

	-- gc_match_finish
	if enterPlayerId == g_dataCenter.player.playerid then
		msg_qtjd_local.cg_match_finish()
	end
end

function msg_qtjd_local.cg_get_integral_award(awardId)
	_awardId = awardId
	_timerId = timer.create("msg_qtjd_local.gc_get_integral_award", 1000, 1)
end

function msg_qtjd_local.gc_get_integral_award()
	timer.stop(_timerId)
	local awards = {
		{
			dataid = 0,
			id = 2,
			count = 100,
		},
		{
			dataid = 0,
			id = 3,
			count = 200,
		}
	}
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree].integralAwards[_awardId] = true
 	msg_three_to_three.gc_get_integral_award(0, _awardId, awards)
end

