
msg_1v1 = {};

local _UIText = {
    [1] = "%s拒绝了你的对决申请！",
    [2] = "约战成功！"
}

--[[发布约战公告]]
--[[function msg_1v1.cg_send_notice(content)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_1v1.cg_send_notice(Socket.socketServer, content);
end]]

--[[挑战指定玩家]]
function msg_1v1.cg_challenge_player(playerid)
	--if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_1v1.cg_challenge_player(Socket.socketServer, playerid);
end

function msg_1v1.cg_set_1v1_function_state(bshield)
    --if not Socket.socketServer then return end
    nmsg_1v1.cg_set_1v1_function_state(Socket.socketServer, bshield)
end

--[[请求]]
function msg_1v1.cg_answer_challenge(bAgree, playerid)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_1v1.cg_answer_challenge(Socket.socketServer, bAgree, playerid)
end

--[[取消我的申请]]
function msg_1v1.cg_cancel_challenge(playerid)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_1v1.cg_cancel_challenge(Socket.socketServer, playerid)
end

--[[随机匹配对象1v1]]
function msg_1v1.cg_random_match()
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_1v1.cg_random_match(Socket.socketServer);
end

--[[取消匹配]]
function msg_1v1.cg_cancel_match()
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_1v1.cg_cancel_match(Socket.socketServer);
end

--[[退出确认倒计时]]
function msg_1v1.cg_cancel_fight_count_down(roomid)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_1v1.cg_cancel_fight_count_down(Socket.socketServer, roomid);
end

--[[选择操作,2-4,(参数为英雄位置编号)，5,(前三个参数为英雄出场的编号顺序，第4个参数为选择BUFF英雄编号，5为BUFF编号)]]
function msg_1v1.cg_select_choose(roomid, nstate, vecParam, bfinally)
    --if not Socket.socketServer then return end
    nmsg_1v1.cg_select_choose(Socket.socketServer, roomid, nstate, vecParam, bfinally);
end

--[[ntype,0战斗次数奖励，1胜利次数奖励]]
function msg_1v1.cg_get_week_reward(ntype, times)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_1v1.cg_get_week_reward(Socket.socketServer, ntype, times)
end

-----------------------------服务器返回-----------------------------------------------

--[[function msg_1v1.gc_send_notice(result)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    PublicFunc.msg_dispatch(msg_1v1.gc_send_notice)
end]]

function msg_1v1.gc_challenge_player(result, playerid)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    FloatTip.Float(_UIText[2])
end

function msg_1v1.gc_sync_my_1v1_data(week, bshield, lastNoticTime, fightTimes, winTimes, vecfightRewardRecord, vecWinRewardRecord)
    local _fightRecord = {}
    for _, v in pairs(vecfightRewardRecord) do
        _fightRecord[v] = true
    end
    local _winRecord = {}
    for _, v in pairs(vecWinRewardRecord) do
        _winRecord[v] = true
    end
    local rewardInfo = {
        fightTimes = fightTimes,
        winTimes = winTimes,
        fightRecord = _fightRecord,
        winRecord = _winRecord
    }
    g_dataCenter.chatFight:SyncData(week, bshield, lastNoticTime, rewardInfo)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Chat_Fight_Award)
    PublicFunc.msg_dispatch(msg_1v1.gc_sync_my_1v1_data)
end

-------------------------被挑战者 --> 挑战者--------------------------------
function msg_1v1.gc_answer_challenge(result, bAgree, playerid)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    g_dataCenter.chatFight:RemoveRequestByPlayerId(true, playerid)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Chat_Fight_Request)
    PublicFunc.msg_dispatch("msg_1v1.update_request")
end

--[[通知挑战者被拒绝]]
function msg_1v1.gc_refuse_challenge(challengeTargetId)
    if challengeTargetId == 0 then
        app.log('challengeTargetId == 0' .. debug.traceback())
        return
    end
    local pName = g_dataCenter.chatFight:RemoveRequestByPlayerId(false, challengeTargetId)
    FloatTip.Float(string.format(_UIText[1], pName))
    PublicFunc.msg_dispatch("msg_1v1.update_my_request")
end

--[[通知挑战者对方接受]]
function msg_1v1.gc_agree_challenge(challengeTargetId)
    g_dataCenter.chatFight:RemoveRequestByPlayerId(false, challengeTargetId)
    PublicFunc.msg_dispatch("msg_1v1.update_my_request")
end

------------------------挑战者 --> 被挑战者--------------------------------

--[[取消我的申请]]
function msg_1v1.gc_cancel_challenge(result, playerid)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    g_dataCenter.chatFight:RemoveRequestByPlayerId(false, playerid)
    PublicFunc.msg_dispatch("msg_1v1.update_my_request")
end

--[[挑战者取消了，通知被挑战者从列表中删除挑战者]]
function msg_1v1.gc_delete_challenger(playerid)
    g_dataCenter.chatFight:RemoveRequestByPlayerId(true, playerid)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Chat_Fight_Request)
    PublicFunc.msg_dispatch("msg_1v1.update_request")
end

------------------------------------------------------------------------


--//ntype,0,添加
function msg_1v1.gc_update_challenger_list(ntype,  vecData)
    if ntype == 0 then
        g_dataCenter.chatFight:AddRequestList(true, vecData)
    end
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Chat_Fight_Request)
    PublicFunc.msg_dispatch("msg_1v1.update_request")
end

--[[我的请求]]
function msg_1v1.gc_update_challenge_target_list(ntype,  vecData)
    if ntype == 0 then
        g_dataCenter.chatFight:AddRequestList(false, vecData)
    end
    PublicFunc.msg_dispatch("msg_1v1.update_my_request")
end

function msg_1v1.gc_random_match(result)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    PublicFunc.msg_dispatch(msg_1v1.gc_random_match)
end

function msg_1v1.gc_cancel_match(result)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    PublicFunc.msg_dispatch(msg_1v1.gc_cancel_match)
end

--[[退出确认倒计时（一人退出两人都会收到）]]
function msg_1v1.gc_cancel_fight_count_down(result)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    PublicFunc.msg_dispatch(msg_1v1.gc_cancel_fight_count_down)
end

--[[双方进入最后倒计时确认，先把数据发过去吧]]
function msg_1v1.gc_start_fight_count_down(roomid, vecPlayerData, vecRoleData, vecBuff)
    g_dataCenter.chatFight:SetStartFightData(roomid, vecPlayerData, vecRoleData, vecBuff)

    --隐藏玩家信息
    OtherPlayerPanel.End()
    --战斗结算
    ChatFightResultUI.End()

    if ChatFightMatchingUI.Instance() then
        ChatFightMatchingUI.End()
    else
        --EUI.ChatFightRequestUI
        if uiManager:GetCurSceneID() == EUI.ChatFightRequestUI then
            uiManager:PopUi()
        end
    end
    ChatFightCountDownUI.Start()
end

--[[2,先手选一个，3后手选2个，4先手选两个，5选BUFF以及出场顺序]]
function msg_1v1.gc_sync_select_state(nstate)
    g_dataCenter.chatFight:SetSyncState(nstate)
    if nstate == ENUM.ChatFightSelectState.FirstOne then

    elseif nstate == ENUM.ChatFightSelectState.SecondTwo
        or nstate == ENUM.ChatFightSelectState.FirstTwo
        or nstate == ENUM.ChatFightSelectState.SecondOne then
        PublicFunc.msg_dispatch(msg_1v1.gc_sync_select_state)

    elseif nstate == ENUM.ChatFightSelectState.Buff then
        uiManager:PushUi(EUI.ChatFightSelectBuffUI)

    end
end

--[[角色的选择状态改变]]
function msg_1v1.gc_update_select_role_data(vecdata)
    local upData = g_dataCenter.chatFight:UpdateRoleData(vecdata)
    PublicFunc.msg_dispatch(msg_1v1.gc_update_select_role_data, upData)
end

--[[选择完毕后同步一次双方出战顺序以及BUFF选择情况]]
function msg_1v1.gc_sync_role_fight_sequence(vecdata)
    g_dataCenter.chatFight:SyncFightSeq(vecdata)
end

--[[ntype,0战斗次数奖励，1胜利次数奖励]]
function msg_1v1.gc_get_week_reward(result, ntype, times, vecreward)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    CommonAward.Start(vecreward)
    PublicFunc.msg_dispatch(msg_1v1.gc_get_week_reward)
end

function msg_1v1.gc_fight_over(winerid, vecFightResult)
    if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_1v1 then
        return
    end
    local function delay()
        ChatFightResultUI.Start()
    end
    timer.create(Utility.create_callback(delay), 2000, 1)
end

function msg_1v1.gc_sync_room_data_info(roomid, vecPlayerData, vecRoleData, vecBuff, vecdata)
    g_dataCenter.chatFight:SetStartFightData(roomid, vecPlayerData, vecRoleData, vecBuff)
    g_dataCenter.chatFight:SyncFightSeq(vecdata)
end