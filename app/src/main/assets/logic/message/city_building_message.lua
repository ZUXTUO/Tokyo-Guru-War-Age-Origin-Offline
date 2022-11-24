
local isLocalData = true

msg_city_building = msg_city_building or {}

function msg_city_building.cg_get_robbery_state()
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_get_robbery_state(Socket.socketServer)
end

function msg_city_building.gc_get_robbery_state_ret(ret)
    PublicFunc.msg_dispatch(msg_city_building.gc_get_robbery_state_ret, ret)
end

function msg_city_building.RequestMyBuildingInfo(callback, obj)
    msg_city_building.obj = obj
    msg_city_building.calbak = callback
    if isLocalData then
        callback(obj, {
            {BuildingID=1000, level = 1, resource = 20, levelUpStartTime = 0},
            {BuildingID=2000, level = 1, resource = 20, levelUpStartTime = 0},
            {BuildingID=3000, level = 1, resource = 20, levelUpStartTime = 0},
            }, 50000)
    else
        --if not Socket.socketServer then return end
        nmsg_city_building.cg_request_my_building_info(Socket.socketServer)
        
    end
end

function msg_city_building.gc_response_my_building_info(ret, bhi, buildingInfo)
    --app.log('msg_city_building.gc_response_my_building_info')

    local bi = {}
    for k,v in ipairs(buildingInfo) do

        --for ik,iv in pairs(v) do
            --app.log(tostring(v.BuildingID) .. ' ' .. tostring(ik) .. ' ' .. tostring(iv))
        --end

        v.lastCalcResourceTime = tonumber(v.lastCalcResourceTime)
        v.lastGainTime = tonumber(v.lastGainTime)
        v.levelUpStartTime = tonumber(v.levelUpStartTime)
        table.insert(bi, v)
    end
    msg_city_building.calbak(msg_city_building.obj, ret, bi, bhi)

    msg_city_building.obj = nil
    msg_city_building.calbak = nil
end

function msg_city_building.gc_sync_source(newRes)
    local cbmgr = CityBuildingMgr.GetInst()
    cbmgr:SetPlayerResource(newRes)
end

function msg_city_building.gc_sync_building_info(bi)
    bi.lastCalcResourceTime = tonumber(bi.lastCalcResourceTime)
    bi.lastGainTime = tonumber(bi.lastGainTime)
    bi.levelUpStartTime = tonumber(bi.levelUpStartTime)

    local cbmgr = CityBuildingMgr.GetInst()
    cbmgr:SetBuildingInfo(bi)
end

function msg_city_building.gc_sync_used_robbery_count(usedCount)
    CityBuildingMgr.GetInst():SetUsedRobberyCount(usedCount)
end

function msg_city_building.gc_sync_buy_robbery_data(buyTimes, buyCount)
    CityBuildingMgr.GetInst():SetBuyRobberyCountData(buyTimes, buyCount)
end

function msg_city_building.cg_player_gain_resource(buildingid)
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_player_gain_resource(Socket.socketServer, buildingid)
end

function msg_city_building.gc_player_gain_resource_ret(ret, buildingid, gainItem)
    local cbmgr = CityBuildingMgr.GetInst()
    cbmgr:PlayerGainResourceResult(ret, buildingid, gainItem)
end

function msg_city_building.UpgradeBuilding(buildingID)
    if isLocalData then
        callback(obj, 0, {buildingID = buildingID})
    else
        --if not Socket.socketServer then return end
        nmsg_city_building.cg_upgrade_building(Socket.socketServer, buildingID)
    end
end

function msg_city_building.gc_upgrade_building_ret(ret, buildingid)
    local cbmgr = CityBuildingMgr.GetInst()
    cbmgr:RequestUpgradeResponse(ret, msgid, buildingid)
end

function msg_city_building.cg_cancel_upgrade(buildingid)
    if buildingid == nil then       
        app.log('buildingid == nil')
    end
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_cancel_upgrade(Socket.socketServer, buildingid);
end

function msg_city_building.gc_cancel_upgrade_ret(ret, buildingid, retResource)
    PublicFunc.msg_dispatch(msg_city_building.gc_cancel_upgrade_ret, ret, buildingid, retResource)
end

function msg_city_building.cg_upgrade_building_end(buildingid)
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_upgrade_building_end(Socket.socketServer, buildingid)
end

function msg_city_building.gc_upgrade_building_end_ret(ret, buildingid)
    local show,info = PublicFunc.GetErrorString(ret, false);
    if show ~= true then
        app.log(info .. ' ' .. tostring(ret) .. ' ' .. tostring(buildingid))
    end
end

function msg_city_building.cg_search_robbery_target(except_player_id, buildingid)
    --msg_city_building.search_robbery_target_callback_fun_name = callback_fun_name
    if type(except_player_id) ~= 'table' then
        except_player_id = {}
    end
    --if isLocalData then
        --msg_city_building.gc_search_robbery_target_ret(0, 0, 0)
    --else
        --if not Socket.socketServer then return end
        nmsg_city_building.cg_search_robbery_target(Socket.socketServer, except_player_id, buildingid)
    --end
end

function msg_city_building.cg_cancel_search_request(buildingid)
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_cancel_search_request(Socket.socketServer, buildingid)
end

function msg_city_building.gc_search_robbery_target_ret(ret, search_result)

    PublicFunc.msg_dispatch(msg_city_building.gc_search_robbery_target_ret, ret, search_result)
end

function msg_city_building.gc_set_building_guard_hero(buildingid, guard_hero)
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_set_building_guard_hero(Socket.socketServer, buildingid, guard_hero)
end

function msg_city_building.gc_set_building_guard_hero_ret(ret, buildingid)
    local cbmgr = CityBuildingMgr.GetInst()
    cbmgr:ReponseSetBuildingGuardHero(ret, buildingid)
end

function msg_city_building.cg_begin_robbery_fight(buildingid,hero, calbak)
    msg_city_building.beginFightCalbak = calbak
    if buildingid == nil then
        app.log('cg_begin_robbery_fight buildingid == nil')
        return
    end
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_begin_robbery_fight(Socket.socketServer, buildingid, hero)
end

function msg_city_building.gc_begin_robbery_fight_ret(ret, buildingid)
    if msg_city_building.beginFightCalbak ~= nil and type(_G[msg_city_building.beginFightCalbak]) == 'function' then
        _G[msg_city_building.beginFightCalbak](ret, buildingid)
    end
end

function msg_city_building.cg_end_robbery_fight(buildingid, mc, oc,mdh, calbak)
    msg_city_building.end_robbery_fight_calbak = calbak
    if buildingid == nil or mc == nil or oc == nil then
        app.log('cg_end_robbery_fight buildingid == nil or mc == nil or oc == nil')
        return
    end
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_end_robbery_fight(Socket.socketServer, buildingid, mc, oc, mdh)
end

function msg_city_building.gc_end_robbery_fight_ret(ret, sr)
    if msg_city_building.end_robbery_fight_calbak ~= nil and type(_G[msg_city_building.end_robbery_fight_calbak]) == 'function' then
        _G[msg_city_building.end_robbery_fight_calbak](ret, sr)
    end
end

function msg_city_building.gc_robbyer_time_out()
    --PublicFunc.msg_dispatch(msg_city_building.gc_robbyer_time_out)
    --CityRobberyMgr.GetInst():RobberyTimeOut()
end

function msg_city_building.cg_get_ranking_list()
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_get_ranking_list(Socket.socketServer)
end

function msg_city_building.gc_get_ranking_list_ret(ret, rankingList)
    PublicFunc.msg_dispatch(msg_city_building.gc_get_ranking_list_ret, ret, rankingList)
    --app.log('xx ' .. table.tostring(rankingList))
end


function msg_city_building.cg_robbery_target_not_guard(bid,hero, callback)
    msg_city_building._targetNotGuardCallback = callback
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_robbery_target_not_guard(Socket.socketServer, bid, hero)
end

function msg_city_building.gc_robbery_target_not_guard_ret(ret, sr)
    if msg_city_building._targetNotGuardCallback ~= nil and _G[msg_city_building._targetNotGuardCallback] ~= nil then     
        _G[msg_city_building._targetNotGuardCallback](ret, sr)
    end
end

function msg_city_building.cg_get_fight_report(isAttack, callback)
    msg_city_building._cg_get_fight_report_callback = callback
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_get_fight_report(Socket.socketServer, isAttack)
end

function msg_city_building.gc_get_fight_report_ret(ret,isAttack, retport)

    if msg_city_building._cg_get_fight_report_callback ~= nil and _G[msg_city_building._cg_get_fight_report_callback] ~= nil then 
        _G[msg_city_building._cg_get_fight_report_callback](ret, isAttack, retport)
    end

end

function msg_city_building.gc_notice_be_attack_end()
    local cbMgr = CityBuildingMgr.GetInst()

    cbMgr:SetIsBeAttack(0)
end

function msg_city_building.gc_sync_fight_score(newScore)
    local cbmgr = CityBuildingMgr.GetInst()
    cbmgr:SetFightScore(newScore)
end

function msg_city_building.abort_robbery()
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_player_abort_robbery(Socket.socketServer)
end

function msg_city_building.cg_buy_robbery_count()
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_buy_robbery_count(Socket.socketServer)
end

function msg_city_building.gc_buy_robbery_count_ret(ret)
    PublicFunc.msg_dispatch(msg_city_building.gc_buy_robbery_count_ret, ret)
end

function msg_city_building.cg_player_enter_slg()
    --if not Socket.socketServer then return end
    nmsg_city_building.cg_player_enter_slg(Socket.socketServer)
end

function msg_city_building.gc_player_enter_slg_ret(ret)
    GLoading.Hide(GLoading.EType.msg)
    if ret == 0 then
        local fs = FightStartUpInf:new()
        fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_SLG)
        --玩法ID修改后需要注意
        fs:SetLevelIndex(60106001)
        SceneManager.PushScene(FightScene,fs)
        uiManager:ClearStack()
    end
end

