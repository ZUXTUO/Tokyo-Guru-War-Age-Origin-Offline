msg_daluandou2 = msg_daluandou2 or {}

-- 临时变量, 是否使用本地数据
local isLocalData = true;


-- 请求我的大乱斗信息
function msg_daluandou2.cg_request_my_daluandou2_data()
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        g_fuzion_local.cg_request_my_daluandou_data()
    else
        --if not Socket.socketServer then return end
        nmsg_daluandou2.cg_request_my_daluandou2_data(Socket.socketServer)
    end
end
function msg_daluandou2.gc_sync_my_daluandou2_data(todayFightCnt,nLastFightStartTime)
    GLoading.Hide(GLoading.EType.msg)
    g_dataCenter.fuzion2:SetMyData(
        {
        todayFightCnt=todayFightCnt,
        nLastFightStartTime=nLastFightStartTime,
        }
    )

    PublicFunc.msg_dispatch(msg_daluandou2.gc_sync_my_daluandou2_data,todayFightCnt,nLastFightStartTime)
end

-- 开始匹配
function msg_daluandou2.cg_start_match()
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        g_fuzion_local.cg_start_match()
    else
        --if not Socket.socketServer then return end
        nmsg_daluandou2.cg_start_match(Socket.socketServer)
    end
end
function msg_daluandou2.gc_start_match(result, leftTime)
    GLoading.Hide(GLoading.EType.msg)

    if result ~= 0 then
        local retInfo = ConfigManager.Get(EConfigIndex.t_error_code_cn,result) or {};
        local str = retInfo.tip or ""
        leftTime = tonumber(leftTime) or 0
        if leftTime ~= 0 then
            HintUI.SetAndShow(EHintUiType.one, str, {str="", time=leftTime});
            -- HintUI.SetAndShow(EHintUiType.zero, str..", 剩余"..leftTime.."秒");
        else
            HintUI.SetAndShow(EHintUiType.zero, str);
        end
        return
    end

    -- 打开匹配界面
    PublicFunc.msg_dispatch(msg_daluandou2.gc_start_match)
end

-- 同步整个房间
-- struct daluandou_match_Room_data
-- {
--     string RoomGid;
--     string CreateTime;
--     string RoomOwnerId;
--     list<daluandou_match_player_data> vecRoomMember;
-- }
function msg_daluandou2.gc_sync_match_room(roomData)
    if roomData then
        g_dataCenter.fuzion2:SetRoomId(roomData.RoomGid)
        g_dataCenter.fuzion2:SetRoomCreateTime(roomData.CreateTime)
        g_dataCenter.fuzion2:SetPlayerData(roomData.vecRoomMember)
    end
end

function msg_daluandou2.cg_cancel_fight(roomid)
    --if not Socket.socketServer then return end
    nmsg_daluandou2.cg_cancel_fight(Socket.socketServer, roomid)
end

-- 取消匹配
function msg_daluandou2.cg_cancel_match(roomid)
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        g_fuzion_local.cg_cancel_match()
    else
        --if not Socket.socketServer then return end
        nmsg_daluandou2.cg_cancel_match(Socket.socketServer, roomid)
    end
end
function msg_daluandou2.gc_cancel_match(result)
    GLoading.Hide(GLoading.EType.msg)

    if PublicFunc.GetErrorString(result) then
        -- 退出匹配界面
        PublicFunc.msg_dispatch(msg_daluandou2.gc_cancel_match)
    end
end


-- 匹配成功同步玩家0添加，1删除
-- struct daluandou_match_player_data
-- {
--     string playerid;        //玩家id
--     string name;            //名字
--     cardConfigID;           //英雄ID
-- }
function msg_daluandou2.gc_update_match_player(ntype, matchPlayerData)
    if ntype == 0 then
        g_dataCenter.fuzion2:InsertPlayer(matchPlayerData)
    elseif ntype == 1 then
        g_dataCenter.fuzion2:RemovePlayer(matchPlayerData)
    end
end

-- 匹配结束，锁定匹配
function msg_daluandou2.gc_match_finish()
    g_dataCenter.fuzion2:PlayerSetReady()
    PublicFunc.msg_dispatch(msg_daluandou2.gc_match_finish)
end

-- 通知全部玩家加载完毕
function msg_daluandou2.gc_all_load_finish()
    PublicFunc.msg_dispatch(msg_daluandou2.gc_all_load_finish)
end

-- 更新战斗过程数据
-- struct daluandou_kill_data
-- {
	-- string playerid;
	-- uint fighter_gid;
	-- int deadTimes;
	-- int killPlayerCnt;
	-- int continuousKillPlayerCnt;
	-- int surviveTime;		//存活时间
-- }
function msg_daluandou2.gc_update_fighter_kill_data(vecKilldata)
    g_dataCenter.fuzion2:UpdateFighterKillData(vecKilldata)
end

-- 通知战斗结束 list<net_summary_item> vecReward
function msg_daluandou2.gc_fight_over(rankIndex, vecReward)
    g_dataCenter.fuzion2:SetShowReward(vecReward)
    local fightManager = FightScene.GetFightManager()
    if fightManager then
        fightManager:FightOver()
    end
end
