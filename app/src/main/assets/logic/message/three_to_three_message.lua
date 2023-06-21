msg_three_to_three = msg_three_to_three or {};

local isLocalData = true

local function _3v3DataCenter()
	return g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree];
end

--请求3v3状态
function msg_three_to_three.cg_three_to_three_state()
	--if not Socket.socketServer then return end
	if isLocalData then
		msg_qtjd_local.cg_three_to_three_state()
	else
		nmsg_three_to_three.cg_three_to_three_state(Socket.socketServer);
	end
end
function msg_three_to_three.gc_three_to_three_state(result, ttt)
	-- app.log("===3v3=== gc_three_to_three_state : "..table.tostring(ttt))
	if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
	_3v3DataCenter():gc_three_to_three_state(result,ttt)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_three_to_three_state, result, ttt);
end

--选择英雄
function msg_three_to_three.cg_select_role(roomId, roleid)
	-- app.log("===3v3=== cg_select_role roomId:"..tostring(roomId).." roleid:"..tostring(roleid))
	--if not Socket.socketServer then return end
	if isLocalData then
		msg_qtjd_local.cg_select_role(roomId, roleid)
	else
		nmsg_three_to_three.cg_select_role(Socket.socketServer, roomId, roleid);
	end
end
function msg_three_to_three.gc_select_role(result, roomId, roleid)
	-- app.log("===3v3=== gc_select_role roleid:"..tostring(roleid))
	if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
	_3v3DataCenter():gc_select_role(roomId, roleid)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_select_role, result, roomId, roleid);
end
--同步玩家选择的英雄
function msg_three_to_three.gc_update_select_role(vsInfo)
	app.log("===3v3=== gc_update_select_role playerid:"..g_dataCenter.player.playerid.." vsInfo:"..table.tostring(vsInfo))
	_3v3DataCenter():gc_update_select_role(vsInfo)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_update_select_role);
end

--确认选择的英雄
function msg_three_to_three.cg_sure_select_role(roomId, roleid)
	if roomId == nil or roleid == nil then return end
	--if not Socket.socketServer then return end
	if isLocalData then
		msg_qtjd_local.cg_sure_select_role(roomId, roleid)
	else
		nmsg_three_to_three.cg_sure_select_role(Socket.socketServer, roomId, roleid);
	end
end
function msg_three_to_three.gc_sure_select_role(result, roomId, roleid)
	-- app.log("===3v3=== gc_sure_select_role roleid: "..tostring(roleid))
	if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
	_3v3DataCenter():gc_sure_select_role(roomId, roleid)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_sure_select_role, result, roomId, roleid);
end

--组队开房间 ntype 0开启 1退出
function msg_three_to_three.cg_team_room(ntype)
	--if not Socket.socketServer then return end
	if ntype == 0 then GLoading.Show(GLoading.EType.msg) end
	if isLocalData then
		if ntype == 0 then
			msg_qtjd_local.cg_team_room(ntype)
		end
	else
		nmsg_three_to_three.cg_team_room(Socket.socketServer, ntype);
	end
end
function msg_three_to_three.gc_team_room(result, ntype, param)
	-- app.log("===3v3=== gc_team_room  "..table.tostring({result, ntype, param}))
	if ntype == 0 then GLoading.Hide(GLoading.EType.msg) end
	if result ~= 0 then
		if result == MsgEnum.error_code.error_code_3v3_match_punish or 
			result == MsgEnum.error_code.error_code_3v3_exit_punish then
			uiManager:PushUi(EUI.MobaEnterTipsUI, {name = "punish_tip", time = param})
		else
			PublicFunc.GetErrorString(result);
		end
		return;
	end
    _3v3DataCenter():gc_team_room(result, ntype, param)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_team_room, result, ntype, param);
end

--开始匹配
function msg_three_to_three.cg_start_match(ntype)
	--if not Socket.socketServer then return end
	if isLocalData then
		if ntype == 0 then
			msg_qtjd_local.cg_start_match()
		end
	else
		nmsg_three_to_three.cg_start_match(Socket.socketServer, ntype);

		-- show loading right now
		GLoading.Show(GLoading.EType.msg) 
	end
end
function msg_three_to_three.gc_start_match(result, ntype, param)
	-- app.log("===3v3=== gc_start_match  "..tostring(ntype).." "..tostring(param))
	if result ~= 0 then
		if result == MsgEnum.error_code.error_code_3v3_match_punish or 
			result == MsgEnum.error_code.error_code_3v3_exit_punish then
			uiManager:PushUi(EUI.MobaEnterTipsUI, {name = "punish_tip", time = param})
		else
			PublicFunc.GetErrorString(result);
		end
		return;
	end
	_3v3DataCenter():SetEnterType(ntype)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_start_match, result, ntype, param);
end
function msg_three_to_three.gc_match_finish(listVsInfo, startTime, roomId)
	-- app.log("===3v3=== gc_match_finish  "..table.tostring({listVsInfo, startTime, roomId}))
	_3v3DataCenter():gc_match_finish(listVsInfo, startTime, roomId)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_match_finish, listVsInfo, startTime, roomId);
	-- 重连消息直接打开选人界面
	if not uiManager:FindUI(EUI.QingTongJiDiEnterUI) then
		uiManager:PushUi(EUI.QingTongJiDiHeroChoseUI)
	end
end

--进入确认准备阶段
function msg_three_to_three.gc_ready_finish(listMatchInfo)
	-- app.log("===3v3=== gc_ready_finish  "..table.tostring(listMatchInfo))
	_3v3DataCenter():gc_ready_finish(listMatchInfo)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_ready_finish, listMatchInfo);
end

--确认进入
function msg_three_to_three.cg_enter_three_to_three()
	--if not Socket.socketServer then return end
	if isLocalData then
		msg_qtjd_local.cg_enter_three_to_three()
	else
		nmsg_three_to_three.cg_enter_three_to_three(Socket.socketServer);
	end
end
function msg_three_to_three.gc_enter_three_to_three(result, playerid)
	-- app.log("===3v3=== gc_enter_three_to_three  "..table.tostring({result, playerid}))
	if result ~= 0 then
		PublicFunc.GetErrorString(result);
	end
	_3v3DataCenter():gc_enter_three_to_three(result, playerid)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_enter_three_to_three, result, playerid);
end
--restart match 0不重匹配  1需要重匹配
function msg_three_to_three.gc_exit_not_enter_game(playeridList, restartMatch)
	-- app.log("===3v3=== gc_exit_not_enter_game  "..table.tostring({playeridList, restartMatch}))
	if restartMatch == 0 then
		_3v3DataCenter():SetStage(0) --初始阶段
		FloatTip.Float("您已移除队列")
	elseif restartMatch == 1 then
		_3v3DataCenter():SetStage(1) --匹配阶段
		FloatTip.Float("有玩家未准备好，重新匹配")
	end
	_3v3DataCenter():gc_exit_not_enter_game(playeridList, restartMatch)
	PublicFunc.msg_dispatch(msg_three_to_three.gc_exit_not_enter_game, playeridList, restartMatch);
end

--取消匹配
function msg_three_to_three.cg_cancel_match()
	--if not Socket.socketServer then return end
	if isLocalData then
		msg_qtjd_local.cg_cancel_match()
	else
		nmsg_three_to_three.cg_cancel_match(Socket.socketServer);
	end
end
function msg_three_to_three.gc_cancel_match(result, playerid)
	-- app.log("===3v3=== gc_cancel_match  "..tostring(playerid))
	if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
    -- _3v3DataCenter():gc_cancel_match(playerid);
	PublicFunc.msg_dispatch(msg_three_to_three.gc_cancel_match, result, playerid);
end

--从房间里删除邀请好友
function msg_three_to_three.cg_del_from_room(playerid)
	--if not Socket.socketServer then return end
	if isLocalData then
		msg_qtjd_local.cg_del_from_room(playerid)
	else
		nmsg_three_to_three.cg_del_from_room(Socket.socketServer, playerid);
	end
end
--同步给房间所有玩家（客户端做表现）
function msg_three_to_three.gc_del_from_room(result, playerid)
	-- app.log("===3v3=== gc_del_from_room  "..tostring(playerid))
	if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
	PublicFunc.msg_dispatch(msg_three_to_three.gc_del_from_room, result, playerid);
end
--更新房间玩家状态
function msg_three_to_three.gc_update_room_state(roomId, listRoomInfo)
	-- app.log("===3v3=== gc_update_room_state  "..table.tostring(listRoomInfo))
	_3v3DataCenter():gc_update_room_state(roomId, listRoomInfo);
	PublicFunc.msg_dispatch(msg_three_to_three.gc_update_room_state);
end

--显示结算结果
function msg_three_to_three.gc_fight_result(fightResult, awards)
	-- app.log("===3v3=== gc_fight_result  " .. table.tostring({fightResult, awards}))
	-- fightResult = 
	-- {
	-- 	players = {
	-- 	{name='松开手优柔',roleId=30001002,kill=0,dead=0,},
	-- 	{name='触不到回忆',roleId=30001007,kill=0,dead=0,},
	-- 	{name='月狼超神了',roleId=30001007,kill=0,dead=0,},
	-- 	{name='SLG机器人18274',roleId=30001019,kill=0,dead=0,},
	-- 	{name='SLG机器人18275',roleId=30001009,kill=0,dead=0,},
	-- 	{name='冥乡筱',roleId=30001002,kill=0,dead=0,},
	-- 	}
	-- }
	--关闭所有ai
	ObjectManager.EnableAllAi(false);

	if GetMainUI() then
	    GetMainUI():OnFightOver()
	end

	_3v3DataCenter():SetFightResult(fightResult, awards);

	TimerManager.Add(msg_three_to_three.__dealy_show_result, 2000, 1, {fightResult, awards})

end

function msg_three_to_three.__dealy_show_result(data)
	local fightResult = data[1]
	local awards = data[2]

	--没有击杀基地的直接弹结算
	local base1 = g_dataCenter.fight_info:GetBase(1)
	local base2 = g_dataCenter.fight_info:GetBase(2)
	if base1 and base2 and not base1:IsDead() and not base2:IsDead() then
		_3v3DataCenter():EndGame();
	--胜利或者失败（基地被击杀时剧情表现）
	else
		--
	end
end

--请求排行榜数据
function msg_three_to_three.cg_get_top_rank()
	--if not Socket.socketServer then return end
	nmsg_three_to_three.cg_get_top_rank(Socket.socketServer);
end
function msg_three_to_three.gc_get_top_rank(list)
	-- app.log("===3v3=== gc_get_top_rank  "..table.tostring(list))
	PublicFunc.msg_dispatch(msg_three_to_three.gc_get_top_rank, list);
end

--领取积分奖励
function msg_three_to_three.cg_get_integral_award(id)
	--if not Socket.socketServer then return end
	if isLocalData then
		msg_qtjd_local.cg_get_integral_award(id)
	else
		nmsg_three_to_three.cg_get_integral_award(Socket.socketServer, id);
	end
end
function msg_three_to_three.gc_get_integral_award(result, id, awards)
	-- app.log("===3v3=== gc_get_integral_award  "..table.tostring({result, id, awards}))
	if result ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
    _3v3DataCenter():SetIntegralAwards(id);
	PublicFunc.msg_dispatch(msg_three_to_three.gc_get_integral_award, id, awards);
end