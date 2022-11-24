msg_daluandou = msg_daluandou or {}

-- 临时变量, 是否使用本地数据
local isLocalData = true;


-- 请求我的大乱逗信息
function msg_daluandou.cg_request_my_daluandou_data()
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        g_fuzion_local.cg_request_my_daluandou_data()
    else
        --if not Socket.socketServer then return end
        nmsg_daluandou.cg_request_my_daluandou_data(Socket.socketServer)
    end
end
function msg_daluandou.gc_sync_my_daluandou_data(myPoint, myFightsoul, todayFightCnt, nCurSeason)
    if not g_dataCenter.fuzion.isInitMyData then
        GLoading.Hide(GLoading.EType.msg)
    end
    g_dataCenter.fuzion:SetMyData(
        {myPoint=myPoint, myFightsoul=myFightsoul, todayFightCnt=todayFightCnt, nCurSeason=nCurSeason})

    PublicFunc.msg_dispatch(msg_daluandou.gc_sync_my_daluandou_data)
end


-- 请求排行榜
function msg_daluandou.cg_request_top_rank()
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        g_fuzion_local.cg_request_top_rank()
    else
        --if not Socket.socketServer then return end
        nmsg_daluandou.cg_request_top_rank(Socket.socketServer)
    end
end
-- 返回排行榜
-- struct daluandou_rank_data
-- {
--     string playerid;        //玩家id
--     string name;
--     int point;
--     int heroIndex;
-- }
function msg_daluandou.gc_request_top_rank(vecRankData)
    GLoading.Hide(GLoading.EType.msg)

    local rankList = {}
    for i, v in ipairs(vecRankData) do
        v.rankIndex = i
        table.insert(rankList, FuzionRank:new(v))
    end
    g_dataCenter.fuzion:SetRankList(rankList)
    PublicFunc.msg_dispatch(msg_daluandou.gc_request_top_rank)
end


-- 请求历史冠军列表
function msg_daluandou.cg_request_champion_list()
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        g_fuzion_local.cg_request_champion_list()
    else
        --if not Socket.socketServer then return end
        nmsg_daluandou.cg_request_champion_list(Socket.socketServer)
    end
end
-- 返回历史冠军列表
-- struct daluandou_champion_data
-- {
--     string playerid;        //玩家id
--     string name;            //名字
--     int point;              //积分
--     int heroIndex;          //英雄
--     int seasonIndex;        //第几届
-- }
function msg_daluandou.gc_request_champion_list(vecChampionData)
    GLoading.Hide(GLoading.EType.msg)
    local championList = {}
    for i, v in ipairs(vecChampionData) do
        table.insert(championList, FuzionChampion:new(v))
    end

    g_dataCenter.fuzion:SetChampionList(championList)
    PublicFunc.msg_dispatch(msg_daluandou.gc_request_champion_list)
end


-- 开始匹配
function msg_daluandou.cg_start_match(cardid)
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        g_fuzion_local.cg_start_match()
    else
        --if not Socket.socketServer then return end
        nmsg_daluandou.cg_start_match(Socket.socketServer, cardid)
    end
end
function msg_daluandou.gc_start_match(result, leftTime)
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
    PublicFunc.msg_dispatch(msg_daluandou.gc_start_match)
end

-- 取消匹配
function msg_daluandou.cg_cancel_match(roomid)
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        g_fuzion_local.cg_cancel_match()
    else
        --if not Socket.socketServer then return end
        nmsg_daluandou.cg_cancel_match(Socket.socketServer, roomid)
    end
end
function msg_daluandou.gc_cancel_match(result)
    GLoading.Hide(GLoading.EType.msg)

    if PublicFunc.GetErrorString(result) then
        -- 退出匹配界面
        PublicFunc.msg_dispatch(msg_daluandou.gc_cancel_match)
    end
end


-- 匹配成功同步玩家0添加，1删除
-- struct daluandou_match_player_data
-- {
--     string playerid;        //玩家id
--     string name;            //名字
--     cardConfigID;           //英雄ID
-- }
function msg_daluandou.gc_update_match_player(ntype, matchPlayerData)
    if ntype == 0 then
        g_dataCenter.fuzion:InsertPlayer(matchPlayerData)
    elseif ntype == 1 then
        g_dataCenter.fuzion:RemovePlayer(matchPlayerData)
    end
end

-- 同步整个房间
-- struct daluandou_match_Room_data
-- {
--     string RoomGid;
--     string CreateTime;
--     string RoomOwnerId;
--     list<daluandou_match_player_data> vecRoomMember;
-- }
function msg_daluandou.gc_sync_match_room(roomData)
    if roomData then
        g_dataCenter.fuzion:SetRoomId(roomData.RoomGid)
        g_dataCenter.fuzion:SetRoomCreateTime(roomData.CreateTime)
        g_dataCenter.fuzion:SetPlayerData(roomData.vecRoomMember)
    end
end

-- 匹配结束，锁定匹配
function msg_daluandou.gc_match_finish()
    g_dataCenter.fuzion:PlayerSetReady()
    PublicFunc.msg_dispatch(msg_daluandou.gc_match_finish)
end

-- 通知全部玩家加载完毕
function msg_daluandou.gc_all_load_finish()
    PublicFunc.msg_dispatch(msg_daluandou.gc_all_load_finish)
end

-- 更新战斗过程数据
-- struct daluandou_kill_data
-- {
--     string playerid;
--     int fighter_gid;
--     int deadTimes;
--     int killPlayerCnt;
-- }
function msg_daluandou.gc_update_fighter_kill_data(vecKilldata)
    g_dataCenter.fuzion:UpdateFighterKillData(vecKilldata)
end

-- 通知战斗结束 list<net_summary_item> vecReward
function msg_daluandou.gc_fight_over(rankIndex, vecReward)
    g_dataCenter.fuzion:SetShowReward(vecReward)
    local fightManager = FightScene.GetFightManager()
    if fightManager then
        fightManager:FightOver()
    end
end
