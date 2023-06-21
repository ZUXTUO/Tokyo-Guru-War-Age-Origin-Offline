local isLocalData = true

msg_activity = msg_activity or {}


function msg_activity.cg_get_level_up_reward_data(callbackFunName)
    --if not Socket.socketServer then return end
    msg_activity.getLevelUpRewardCalbak=callbackFunName
    --if isLocalData then
        --level_up_reward_fake_data.client_request()
    --else
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_get_level_up_reward_data(robot_s)")
    end
        nmsg_activity.cg_get_level_up_reward_data(Socket.socketServer)
    --end
end

----------------获取活动配置-----------------
function msg_activity.cg_activity_config(system_id)
    app.log("进入");
    if isLocalData then
        app.log("msg_activity.cg_activity_config暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_activity_config(Socket.socketServer, system_id);
    end
end

function msg_activity.gc_activity_config(result, system_id, cf)
    if tonumber(result) ~= 0 then
        GLoading.Hide(GLoading.EType.msg);
        PublicFunc.GetErrorString(result);
        return;
    end
    --app.log(table.tostring(cf));
    if g_dataCenter.activity[system_id] then
        if g_dataCenter.activity[system_id].SetData then
            g_dataCenter.activity[system_id]:SetData(cf);
        end
    end
    PublicFunc.msg_dispatch(msg_activity.gc_activity_config, result, system_id, cf);
    uiManager:UpdateCurScene(ENUM.EUPDATEINFO.activity);
end

----------------进入活动-----------------
function msg_activity.cg_enter_activity(system_id, param)
    if isLocalData then
        app.log("msg_activity.cg_enter_activity暂时没做单机模式");
        return;
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            local _param = "local param = {}\n"
            for i=1, #param do
                _param = _param.."param["..i.."] = "..tostring(param[i]).."\n"
            end
            PublicFunc.RecordingScript(_param.."nmsg_activity.cg_enter_activity(robot_s, "..tostring(system_id)..", param)")
        end
        nmsg_activity.cg_enter_activity(Socket.socketServer, system_id, param);
    end
end

function msg_activity.gc_enter_activity(result, system_id, cf)
    GLoading.Hide(GLoading.EType.msg)

    if tonumber(result) ~= 0 then
        -- app.log("result=="..result);
        PublicFunc.GetErrorString(result);
        local activityDataCenter = g_dataCenter.activity[system_id]
        if activityDataCenter and activityDataCenter.gc_enter_activity_error then
            activityDataCenter:gc_enter_activity_error(result, system_id, cf)
        end
        return;
    end
    if g_dataCenter.activity[system_id] then
        g_dataCenter.activity[system_id]:BeginGame(result, cf);
    end
    PublicFunc.msg_dispatch(msg_activity.gc_enter_activity, result, system_id, cf);
end

----------------退出活动-----------------
function msg_activity.cg_leave_activity(system_id, isWin, param)
    if isLocalData then
        app.log("msg_activity.cg_leave_activity暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            local _param = "local param = {}\n"
            for i=1, #param do
                _param = _param.."param["..i.."] = "..tostring(param[i]).."\n"
            end
            PublicFunc.RecordingScript(_param.."nmsg_activity.cg_leave_activity(robot_s, "..tostring(system_id)..","..tostring(isWin)..", param)")
        end
        nmsg_activity.cg_leave_activity(Socket.socketServer, system_id, isWin, param);
    end
end

function msg_activity.gc_leave_activity(result, system_id, isWin, awards,  param)
    
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        FightScene.GetFightManager():FightOver(true);
        return;
    end
    
    if g_dataCenter.activity[system_id] then
        g_dataCenter.activity[system_id]:GameResult(isWin,awards,param);
    end
    PublicFunc.msg_dispatch(msg_activity.gc_leave_activity, result, system_id, isWin, awards,  param);
    --app.log("#########################"..table.tostring(awards))
end

function msg_activity.cg_raids(system_id, param)
    --if not Socket.socketServer then return end
	app.log("cf_raids");
    nmsg_activity.cg_raids(Socket.socketServer,system_id, param);
end

function msg_activity.gc_raids(result, system_id, awards, param)
	app.log("gc_raids result = "..tostring(result)..",system_id = "..tostring(system_id)..",awards = "..table.tostring(awards))
	if result == 0 then 
		PublicFunc.msg_dispatch(msg_activity.gc_raids,system_id,awards,param)
	else 
		PublicFunc.GetErrorString(result);
	end
end 

-------------------高速狙击关卡----------------------------
--[[申请高速狙击关卡中当前的状态]]
function msg_activity.cg_gaosujuji_struct(system_id)
    if isLocalData then
        app.log("msg_activity.cg_gaosujuji_struct 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_gaosujuji_struct(Socket.socketServer,system_id);
    end
end

function msg_activity.gc_gaosujuji_struct(result,system_id,ag)
    if result ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    end
    if g_dataCenter.activity[system_id] then
        g_dataCenter.activity[system_id]:SetActivityStruct(ag);
    end
    uiManager:UpdateCurScene();
end
--[[存储高速狙击关卡状态]]
function msg_activity.cg_save_gaosujuji_struct(system_id, gaosu)
    if isLocalData then
        app.log("msg_activity.cg_save_gaosujuji_struct 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_save_gaosujuji_struct(Socket.socketServer,system_id,gaosu);
    end
end
function msg_activity.gc_save_gaosujuji_struct(result, system_id, awards)
    if result ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    end
    if g_dataCenter.activity[system_id] then
        g_dataCenter.activity[system_id]:SetAwards(awards);
    end
end
--[[领取高速狙击首次通关奖励]]
function msg_activity.cg_get_gaosujuji_firstpass(system_id)
    if isLocalData then
        app.log("msg_activity.cg_get_gaosujuji_firstpass 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_get_gaosujuji_firstpass(Socket.socketServer,system_id);
    end
end
function msg_activity.gc_get_gaosujuji_firstpass(result, system_id, awards)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    else
        CommonAward.Start(awards,1);
    end
    uiManager:UpdateCurScene();
end
--竞技场排行榜数据返回
function msg_activity.gc_arena_top_50(rankDatas,my_rank)
	local rdata = rankDatas;
	rdata.my_rank = my_rank;
	PublicFunc.msg_dispatch(msg_activity.gc_arena_top_50, rdata);
end 

----------------------奎库利亚------------------------------
function msg_activity.cg_request_kuikuliya_top_list(rankIndex)
    if isLocalData then
        app.log("msg_activity.cg_request_kuikuliya_top_list 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_request_kuikuliya_top_list(Socket.socketServer, rankIndex);
    end
end

function msg_activity.gc_sync_kuikuliya_top_list(result, rankIndex, vecKuikuliyaPlayer)
    PublicFunc.msg_dispatch(msg_activity.gc_sync_kuikuliya_top_list, result, rankIndex, vecKuikuliyaPlayer);
end

function msg_activity.cg_request_kuikuliya_friend_top_list(friendIndex)
    if isLocalData then
        app.log("msg_activity.cg_request_kuikuliya_friend_top_list 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_request_kuikuliya_friend_top_list(Socket.socketServer, friendIndex);
    end
end
--[[请求自己的奎库利亚信息]]
function msg_activity.cg_request_kuikuliya_myself_data()
    if isLocalData then
        app.log("msg_activity.cg_request_kuikuliya_myself_data 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_activity.cg_request_kuikuliya_myself_data(robot_s)")
        end
        nmsg_activity.cg_request_kuikuliya_myself_data(Socket.socketServer);
    end
end
function msg_activity.gc_sync_kuikuliya_data_myself(myRank,myPoint,floor,buyTimes,thirdTimes,saodangStartTime)
    if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa] then
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]:SetCnt(myRank,myPoint,floor,buyTimes,thirdTimes,saodangStartTime);
    end
    PublicFunc.msg_dispatch(msg_activity.gc_sync_kuikuliya_data_myself, myRank,myPoint,floor,buyTimes,thirdTimes,saodangStartTime);
    -- uiManager:PushUi(EUI.KuiKuLiYaHurdleUI);
end
--[[领取每日奖励]]
function msg_activity.cg_get_kuikuliya_day_reward()
    if isLocalData then
        app.log("msg_activity.cg_get_kuikuliya_day_reward 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_get_kuikuliya_day_reward(Socket.socketServer);
    end
end
function msg_activity.gc_get_kuikuliya_day_reward(result,awards)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    end
    CommonAward.Start(awards,1);
    msg_activity.cg_request_kuikuliya_myself_data();
    -- app.log(table.tostring(awards));
end
--[[购买奎库利亚次数]]
function msg_activity.cg_buy_kuikuliya_times()
    if isLocalData then
        app.log("msg_activity.cg_buy_kuikuliya_times 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_buy_kuikuliya_times(Socket.socketServer);
    end
end
function msg_activity.gc_buy_kuikuliya_times(result)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
    end
    HintUI.SetAndShow(0,"购买成功。");
end
--[[重置奎库利亚]]
function msg_activity.cg_reset_kuikuliya(ntype)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("msg_activity.cg_reset_kuikuliya(robot_s)")
    end
    nmsg_activity.cg_reset_kuikuliya(Socket.socketServer,ntype);
end
function msg_activity.gc_reset_kuikuliya(result)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    end
    PublicFunc.msg_dispatch(msg_activity.gc_reset_kuikuliya, result);
end
--[[开始扫荡奎库利亚]]
function msg_activity.cg_saodang_kuikuliya(bfase)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("msg_activity.cg_saodang_kuikuliya(robot_s, "..tostring(bfase)..")")
    end
    nmsg_activity.cg_saodang_kuikuliya(Socket.socketServer,bfase);
end
function msg_activity.gc_saodang_kuikuliya(result, bfast, vecReward)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    end
    PublicFunc.msg_dispatch(msg_activity.gc_saodang_kuikuliya, result, bfast, vecReward);
end
--[[领取奎库利亚宝箱]]
function msg_activity.cg_kuikuliya_get_box_reward(ntype,nfloor,openTimes)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_kuikuliya_get_box_reward(robot_s, "..tostring(ntype)..", "..tostring(nfloor)..", "..tostring(openTimes)..")")
    end
    nmsg_activity.cg_kuikuliya_get_box_reward(Socket.socketServer,ntype,nfloor,openTimes);
end
function msg_activity.gc_kuikuliya_get_box_reward(result, ntype, nfloor, openTimes, reward)
    if tonumber(result) ~= 0 then
        if tonumber(result) == 84206013 then
            local str = "钻石不足！是否前往充值界面？";
            local btn1 = {};
            btn1.str = "立即前往";
            btn1.func = function ()
                uiManager:PushUi(EUI.StoreUI);
            end
            local btn2 = {};
            btn2.str = "否";
            HintUI.SetAndShowHybrid(2, "", str, nil, btn1, btn2);
            return;
        end
        PublicFunc.GetErrorString(result)
        return;
    end
    PublicFunc.msg_dispatch(msg_activity.gc_kuikuliya_get_box_reward, result, ntype, nfloor, openTimes, reward);
end
--[[领取奎库利亚爬梯奖]]
function msg_activity.cg_kuikuliya_get_climb_reward(nfloor)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_kuikuliya_get_climb_reward(Socket.socketServer,nfloor);
end
function msg_activity.gc_kuikuliya_get_climb_reward(result, nfloor, vecreward)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    end
    PublicFunc.msg_dispatch(msg_activity.gc_kuikuliya_get_climb_reward, result, nfloor, vecreward);
end
--[[同步每层的数据]]
function msg_activity.gc_sync_all_floor(vecfloorData)
    if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa] then
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]:gc_sync_all_floor(vecfloorData);
    end
    PublicFunc.msg_dispatch(msg_activity.gc_sync_all_floor, vecfloorData);
end
--[[更新某层的数据]]
function msg_activity.gc_update_floor_data(ntype, data)
    if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa] then
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]:gc_update_floor_data(ntype, data);
    end
    PublicFunc.msg_dispatch(msg_activity.gc_update_floor_data, ntype, data);
end
--[[奎库利亚扫荡立即完成]]
function msg_activity.cg_kuikuliya_saodang_immediately()
    --if not Socket.socketServer then return end
    nmsg_activity.cg_kuikuliya_saodang_immediately(Socket.socketServer);
end
function msg_activity.gc_kuikuliya_saodang_immediately(result, vecreward)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    end
    PublicFunc.msg_dispatch(msg_activity.gc_kuikuliya_saodang_immediately, result, vecreward);
end
--[[奎库利亚领取扫荡奖励]]
function msg_activity.cg_kuikuliya_Get_saodang_reward()
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("msg_activity.cg_kuikuliya_Get_saodang_reward(robot_s)")
    end
    nmsg_activity.cg_kuikuliya_Get_saodang_reward(Socket.socketServer);
end
function msg_activity.gc_kuikuliya_Get_saodang_reward(result, vecreward)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    end
    PublicFunc.msg_dispatch(msg_activity.gc_kuikuliya_Get_saodang_reward, result, vecreward);
end
------------------------------------------------------------

function msg_activity.gc_get_level_up_reward_data_ret(beginAndEndTime, level, config)
    --app.log('gc_get_level_up_reward_data_ret ' .. beginAndEndTime)
    --app.log('gc_get_level_up_reward_data_ret level ' .. level)
    --for k,v in pairs(config) do
        --app.log('gc_get_level_up_reward_data_ret config level ' .. v.level)
        --for ik,iv in pairs(v.reward_items) do
            --app.log('gc_get_level_up_reward_data_ret config ' .. iv.id .. ' ' .. iv.num)
        --end
    --end
    local data = {}
    data.hasGetLevelStr = level or ""
    local splitIndex = string.find(beginAndEndTime,'-',1,true)
    local beginTime = string.sub(beginAndEndTime, 0, splitIndex - 1)
    local endTime = string.sub(beginAndEndTime, splitIndex + 1)
    data.beginTime = tonumber(beginTime)
    data.endTime = tonumber(endTime)
    data.config = config
    --msg_activity.request:OnDealServerResponseData(data)
    if msg_activity.getLevelUpRewardCalbak ~= nil and _G[msg_activity.getLevelUpRewardCalbak] ~=nil then
        _G[msg_activity.getLevelUpRewardCalbak](data)
    end
end

function msg_activity.server_response_data(data)

    --if isLocalData then
        --msg_activity.request:OnDealServerResponseData(data)
    --end
end

function msg_activity.client_get_level_reward(calbak,reward)
    msg_activity.getLevelRewardCalbak=calbak
    msg_activity.getLevelRewardReward=reward

    --if isLocalData then
        --msg_activity._timerId=timer.create("msg_activity.server_response_get_level_reward",1000,1);
    --else
    --if not Socket.socketServer then return end
        nmsg_activity.cg_player_get_level_reward(Socket.socketServer, reward.level)
    --end

end

function msg_activity.server_response_get_level_reward()
    --if isLocalData then
        --msg_activity.request:OnDealGetLevelRewardResponse(true,msg_activity.reward)
        --timer.stop(msg_activity._timerId)
    --end
end

function msg_activity.gc_player_get_level_reward_ret(resultid, msgid)
    if msg_activity.getLevelRewardCalbak == nil or _G[msg_activity.getLevelRewardCalbak] == nil then
        return
    end
    local calbakFun = _G[msg_activity.getLevelRewardCalbak]
    calbakFun(resultid, msgid, msg_activity.getLevelRewardReward);
end

--活动标记协议
function msg_activity.gc_set_flag_list(vec_data)
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    if flagHelper then
        flagHelper:SetList(vec_data);
    end
end
function msg_activity.gc_add_flag(data)
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    if flagHelper then
        flagHelper:AddFlag(data);
    end
end
function msg_activity.gc_update_flag(data)
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    if flagHelper then
        flagHelper:UpdateFlag(data);
    end
end
function msg_activity.gc_remove_flag(data)
    local flagHelper = g_dataCenter.player:GetFlagHelper();
    if flagHelper then
        flagHelper:RemoveFlag(data);
    end
end




---------------------------教堂祈祷专用消息--------------------------------
-------------客户端到服务器--------------
-- --设置第几个栏位的英雄
-- function msg_activity.cg_churchpray_set_card(cardGid, nIndex)
--     --app.log("设置第"..tostring(nIndex).."个栏位的英雄id==="..tostring(cardGid));
--     if isLocalData then
--         app.log("msg_activity.cg_churchpray_set_card 暂时没做单机模式");
--     else
--         nmsg_activity.cg_churchpray_set_card(Socket.socketServer,cardGid, nIndex);
--     end
-- end

--请求自己的教堂挂机数据
function msg_activity.cg_churchpray_request_myslef_info()
    app.log("请求自己的教堂挂机数据");
    if isLocalData then
        app.log("msg_activity.cg_churchpray_request_myslef_info 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_churchpray_request_myslef_info(Socket.socketServer);
    end
end

--进入教堂(角色ID，几星教堂)
function msg_activity.cg_churchpray_enter_church(cardGid, star)
    app.log("进入"..tostring(star).."星教堂，id=="..tostring(cardGid));
    if isLocalData then
        app.log("msg_activity.cg_churchpray_enter_church 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_churchpray_enter_church(Socket.socketServer,cardGid, star);
    end
end

--退出教堂(角色ID，几星教堂)
function msg_activity.cg_churchpray_quit_church(star)
    if isLocalData then
        app.log("msg_activity.cg_churchpray_quit_church 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_churchpray_quit_church(Socket.socketServer, star);
    end
end

--请求某个角色详细信息
function msg_activity.cg_churchpray_request_card_info(cardGid, star, posIndex)
    --app.log("请求"..tostring(star).."星教堂，第"..tostring(posIndex).."个位置的英雄的详细数据，id=="..tostring(cardGid));
    if isLocalData then
        app.log("msg_activity.cg_churchpray_request_card_info 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_churchpray_request_card_info(Socket.socketServer,cardGid, star, posIndex);
    end
end

--购买教堂挑战次数
function msg_activity.cg_churchpray_times()
    if isLocalData then
        app.log("msg_activity.cg_churchpray_times 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_churchpray_times(Socket.socketServer);
    end
end

--领取教堂祈祷奖励
function msg_activity.cg_get_churchpray_reward(index)
    if isLocalData then
        app.log("msg_activity.cg_churchpray_reward 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        app.log("msg_activity.cg_churchpray_reward")
        nmsg_activity.cg_get_churchpray_reward(Socket.socketServer, index);
    end
end

--加速祈祷
function msg_activity.cg_churchpray_quick(index, hours)
    if isLocalData then
        app.log("msg_activity.cg_churchpray_quick 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_churchpray_quick(Socket.socketServer, index, hours);
    end
end

--请求教堂挂机战报
function msg_activity.cg_request_church_fight_record()
    if isLocalData then
        app.log("msg_activity.cg_request_church_fight_record 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_request_church_fight_record(Socket.socketServer);
    end
end

--解锁
function msg_activity.cg_churchpray_unlock(index)
    if isLocalData then
        app.log("msg_activity.cg_churchpray_quick 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_churchpray_unlock(Socket.socketServer, index);
    end
end

--查找对手  nstar 星级
function msg_activity.cg_look_for_rival(nstar,myPrayIndex)  
    if isLocalData then
        app.log("msg_activity.cg_churchpray_quick 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_look_for_rival(Socket.socketServer,nstar,myPrayIndex);
    end
end


--请求所有教堂人数现状
function msg_activity.cg_request_all_church_pray_info()
    if isLocalData then
        app.log("msg_activity.cg_request_all_church_pray_info 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_request_all_church_pray_info(Socket.socketServer);
    end
end

function msg_activity.cg_get_fightRecord_vigor(dataid,byFast)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_fightRecord_vigor(Socket.socketServer,dataid,byFast);
end

function msg_activity.cg_buy_churchpray_vigor()
    --if not Socket.socketServer then return end
    nmsg_activity.cg_buy_churchpray_vigor(Socket.socketServer);
end

---------------------------竞技场消息--------------------------------
-- 开启竞技场单机调试
local isLocalArenaData = true;

-- 请求自己的竞技场数据
function msg_activity.cg_arena_request_myslef_info()
    -- GLoading.Show(GLoading.EType.msg)
    if isLocalArenaData then
        g_msg_arena_local.cg_arena_request_myslef_info();
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_activity.cg_arena_request_myslef_info(robot_s)")
        end
        nmsg_activity.cg_arena_request_myslef_info(Socket.socketServer);
    end
end
-- 同步自己的竞技场数据
function msg_activity.gc_arena_sync_myself_info(rankIndex, buyTimes, thridTimes, coldTime, refreshTimes, points, pointRewardList, isFirstPass, maskRank, cleanCDtimes, historyRankIndex)
    -- GLoading.Hide(GLoading.EType.msg)
    local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    arena:SetMyData(rankIndex, buyTimes, thridTimes, coldTime, refreshTimes, points, pointRewardList, isFirstPass, maskRank, cleanCDtimes, historyRankIndex)
    PublicFunc.msg_dispatch(msg_activity.gc_arena_sync_myself_info)
end

-- 请求本段位竞技场列表 0:top 10,1:和自己关联的10名,2:前50名,3:用于更新挑战对手数据刷新
function msg_activity.cg_arena_request_player_list(type)
    if type == 1 then GLoading.Show(GLoading.EType.msg) end
    if isLocalArenaData then
        app.log("[单机]请求本段位竞技场列表 0:top 10,1:和自己关联的10名,2:前50名,3:用于更新挑战对手数据刷新");
        g_msg_arena_local.cg_arena_request_player_list();
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_activity.cg_arena_request_player_list(robot_s, "..tostring(type)..")")
        end
        nmsg_activity.cg_arena_request_player_list(Socket.socketServer, type);
    end
end
-- 返回/同步 竞技场对手列表
function msg_activity.gc_arena_sync_player_list(type, playerlist)
    if type == 1 then GLoading.Hide(GLoading.EType.msg) end
    uiManager:UpdateMsgDataEx(EUI.ArenaMainUI, "on_gc_arena_sync_player_list", type, playerlist)
    PublicFunc.msg_dispatch(msg_activity.gc_arena_sync_player_list, type, playerlist)
end

-- 购买挑战次数
-- buyEnterFight 0-不进入战斗 1-立即进入战斗
function msg_activity.cg_arena_buy_challenge_times(buyEnterFight, times)
    GLoading.Show(GLoading.EType.msg)
    if isLocalArenaData then
        GLoading.Hide(GLoading.EType.msg)
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_arena_buy_challenge_times(Socket.socketServer, buyEnterFight, times);
    end
end
-- 返回购买结果
function msg_activity.gc_arena_buy_challenge_times(result, buyEnterFight)
    GLoading.Hide(GLoading.EType.msg)
    if PublicFunc.GetErrorString(result, true) then
        PublicFunc.msg_dispatch(msg_activity.gc_arena_buy_challenge_times, buyEnterFight)
    end
end

-- 请求刷新挑战对手
function msg_activity.cg_arena_refresh_challenge_list()
    GLoading.Show(GLoading.EType.msg)
    if isLocalArenaData then
        GLoading.Hide(GLoading.EType.msg)
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_arena_refresh_challenge_list(Socket.socketServer);
    end
end
-- 返回刷新结果
function msg_activity.gc_arena_refresh_challenge_list(result)
    GLoading.Hide(GLoading.EType.msg)
    if PublicFunc.GetErrorString(result, true) then
        PublicFunc.msg_dispatch(msg_activity.gc_arena_refresh_challenge_list)
    end
end

-- 请求战斗记录
function msg_activity.cg_arena_request_fight_report()
    GLoading.Show(GLoading.EType.msg)
    if isLocalArenaData then
        g_msg_arena_local.cg_arena_request_fight_report();
    else
        --if not Socket.socketServer then return end
        nmsg_activity.cg_arena_request_fight_report(Socket.socketServer);
    end
end
-- 返回战斗记录
function msg_activity.gc_arena_request_fight_report(reportList)
    GLoading.Hide(GLoading.EType.msg)
    local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    arena:SetNewReport(0) -- 清除本地新战报标记
    PublicFunc.msg_dispatch(msg_activity.gc_arena_request_fight_report, reportList)
end
-- 返回增加的战斗记录
function msg_activity.gc_arena_add_fight_report(reportData)
    local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    arena:SetWinFightResult(reportData)
    PublicFunc.msg_dispatch(msg_activity.gc_arena_add_fight_report, reportData)
end

-- 历史排名变化
function msg_activity.gc_arena_histrong_rank_change(upTopRank, awards)
    local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    arena:SetTopRankResult(upTopRank, awards)
end

-- 进游戏同步一次战报更新记录（byNeedUpdate: 0-战报无更新 1-战报有更新, bHaveClimpReward: true/false）
function msg_activity.gc_arena_sync_report_state(byNeedUpdate, bHaveClimpReward)
    local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    arena:SetNewReport(byNeedUpdate)
    arena:SetNewTopReward(bHaveClimpReward)
end

-- 请求爬梯奖励数据
function msg_activity.cg_arena_request_climb_reward_data()
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_arena_request_climb_reward_data(robot_s)")
    end
    nmsg_activity.cg_arena_request_climb_reward_data(Socket.socketServer);
end

-- 返回爬梯奖励数据
function msg_activity.gc_arena_request_climb_reward_data(receiveList)
    -- app.log("msg_activity.gc_arena_request_climb_reward_data")
    local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    arena:SetReceivedTopRewardFlag(receiveList)
    PublicFunc.msg_dispatch(msg_activity.gc_arena_request_climb_reward_data, receiveList)
end

-- 请求领取指定爬梯奖励
function msg_activity.cg_arena_get_climb_reward(index)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_arena_get_climb_reward(robot_s, "..tostring(index)..")")
    end
    nmsg_activity.cg_arena_get_climb_reward(Socket.socketServer, index);
end

-- 返回指定爬梯奖励领取结果
function msg_activity.gc_arena_get_climb_reward(result, index, rewardList)
    if PublicFunc.GetErrorString(result) then
        --客户端合并处理
        local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
        arena:UpdateReceivedTopReward(index)
        PublicFunc.msg_dispatch(msg_activity.gc_arena_get_climb_reward, index, rewardList)
    end
end

-- 请求领取每日积分奖励
function msg_activity.cg_arena_get_day_point_reward(index)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("msg_activity.cg_arena_get_day_point_reward(robot_s, "..tostring(index)..")")
    end
    nmsg_activity.cg_arena_get_day_point_reward(Socket.socketServer, index);
end

-- 返回每日积分奖励领取结果
function msg_activity.gc_arena_get_day_point_reward(result, index, rewardList)
    if PublicFunc.GetErrorString(result) then
        PublicFunc.msg_dispatch(msg_activity.gc_arena_get_day_point_reward, index, rewardList)
    end
end

-- 清除挑战cd
function msg_activity.cg_arena_clean_cd()
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_arena_clean_cd(robot_s)")
    end
    nmsg_activity.cg_arena_clean_cd(Socket.socketServer)
end
function msg_activity.gc_arena_clean_cd(result)
    if PublicFunc.GetErrorString(result) then
        -- 重置成功
        local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
        arena:ResetFightCdTime()
    end
end

function msg_activity.gc_arena_update_target_fight_data(fight_data)
    
    local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    arena:SetArenaFighter(fight_data)

end


-------------服务器到客户端--------------
-- --设置第几个栏位的英雄
-- function msg_activity.gc_churchpray_set_card(result, index)
--     app.log("gc_churchpray_set_card设置第"..tostring(index).."个栏位的英雄    成功"..tostring(result));
--     if PublicFunc.GetErrorString(result, true) then
--         PublicFunc.msg_dispatch(msg_activity.gc_churchpray_set_card, result, index);
--     end
-- end

--同步自己的教堂挂机数据
function msg_activity.gc_churchpray_sync_myself_info(RefreshTimes, buyVigorTimes,last_pre_churchpray_vigor_time,myPoslist)
    -- app.log("gc_churchpray_sync_myself_info"..table.tostring(myPoslist));
    -- app.log("gc_churchpray_sync_myself_RefreshTimes"..tostring(RefreshTimes));
    --g_dataCenter.ChurchBot:Init()
    g_dataCenter.ChurchBot:setMymyPoslist(myPoslist)
    g_dataCenter.ChurchBot:setfindnumber(RefreshTimes)
    g_dataCenter.ChurchBot:set_buy_vigor_number(buyVigorTimes)
    g_dataCenter.ChurchBot:set_last_vigor_time(last_pre_churchpray_vigor_time)
    --g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetBaseInfo(myPoslist);
    --g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetBuyChallengeTimes(buyChallengeTimes);
    --g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetThirdPartChallengeTimes(thirdPartChallengeTimes);
    PublicFunc.msg_dispatch(msg_activity.gc_churchpray_sync_myself_info);
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Time,Gt_Enum.EMain_Challenge_QYZL);
end

--进入教堂返回
function msg_activity.gc_churchpray_enter_church(star, rolelist)
    --app.log("进入"..tostring(star).."星教堂返回    玩家列表=="..table.tostring(rolelist));
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetAllPositionInfo(star,rolelist);
    PublicFunc.msg_dispatch(msg_activity.gc_churchpray_enter_church, star, rolelist);
end

--请求某个角色详细信息
function msg_activity.gc_churchpray_request_card_info(result, star, posIndex, roleData, vecCardsEquip)
    --app.log("请求"..tostring(star).."星教堂第"..tostring(posIndex).."个位置的角色详细信息=="..table.tostring(roleData));
    if PublicFunc.GetErrorString(result, true) then
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetHeroInfo(star, posIndex, roleData, vecCardsEquip);
        PublicFunc.msg_dispatch(msg_activity.gc_churchpray_request_card_info, result, star, posIndex, roleData, vecCardsEquip);
    end
end

--购买教堂挑战次数
function msg_activity.gc_churchpray_times(result)
    if PublicFunc.GetErrorString(result, true) then
        PublicFunc.msg_dispatch(msg_activity.gc_churchpray_times,result);
    end
end

--领取教堂祈祷奖励
function msg_activity.gc_get_churchpray_reward(result, index, vecReward)
    --app.log("领取教堂祈祷奖励exp=="..table.tostring(vecReward).."     index=="..tostring(index));
    if PublicFunc.GetErrorString(result, true) then
        g_dataCenter.ChurchBot:getAwardUIData(index)
        g_dataCenter.ChurchBot:setreward(vecReward)
        PublicFunc.msg_dispatch(msg_activity.gc_get_churchpray_reward,index,vecReward);
    end
end

--返回一条更新的数据
function msg_activity.gc_update_one_churchpray_data(myPoslist)
    app.log("gc_update_one_churchpray_data####"..table.tostring(myPoslist))
    g_dataCenter.ChurchBot:updataMyposlist(myPoslist)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Time,Gt_Enum.EMain_Challenge_QYZL);
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_QYZL);
end

--删除房间某个玩家(cardgid 第一房间以这个为删除依据)
function msg_activity.gc_churchpray_role_leave(nstar, posIndex, cardgid)
    --app.log("删除"..tostring(nstar).."星级教堂位置=="..tostring(posIndex).."的玩家id=="..cardgid);
    PublicFunc.msg_dispatch(msg_activity.gc_churchpray_role_leave, nstar, posIndex, cardgid);
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:DelHeroInfo(nstar, posIndex, cardgid);
end

--增加房间玩家()
function msg_activity.gc_churchpray_role_join(nstar, posIndex, roledata)
    --app.log("增加"..tostring(nstar).."星级教堂位置=="..tostring(posIndex).."的玩家数据=="..table.tostring(roledata));
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:AddHeroInfo(nstar, posIndex, roledata);
    PublicFunc.msg_dispatch(msg_activity.gc_churchpray_role_join, nstar, posIndex, roledata);
end

--加速祈祷
function msg_activity.gc_churchpray_quick(result, index)
    --app.log("加速成功index==="..tostring(index));
    if PublicFunc.GetErrorString(result, true) then
        PublicFunc.msg_dispatch(msg_activity.gc_churchpray_quick, result, index);
    end
end

--请求教堂挂机战报  list<churchpray_fight_record_data> vecFightRecordData
function msg_activity.gc_request_church_fight_record(vecFightRecordData)
    --app.log("战报消息vecFightRecordData=="..table.tostring(vecFightRecordData));
    --g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetFightReport(vecFightRecordData);
    
    g_dataCenter.ChurchBot:SetFightReport(vecFightRecordData)
    PublicFunc.msg_dispatch(msg_activity.gc_request_church_fight_record, vecFightRecordData);
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_QYZL_Repory);
end

--增加一条战报0添加，1删除int ntype,churchpray_fight_record_data FightRecordData
function msg_activity.gc_update_church_fight_record(ntype, FightRecordData)
    --app.log("更新战报ntype==="..tostring(ntype)..table.tostring(FightRecordData));
    g_dataCenter.ChurchBot:UpdataFightReport(ntype, FightRecordData);
    --PublicFunc.msg_dispatch(msg_activity.gc_update_church_fight_record, ntype, FightRecordData);
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_QYZL_Repory);
end


--返回所有教堂人数现状
function msg_activity.gc_request_all_church_pray_info(result, vecPrayCnt)
    if PublicFunc.GetErrorString(result, true) then
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetAllChurchInfo(vecPrayCnt);
        PublicFunc.msg_dispatch(msg_activity.gc_request_all_church_pray_info, result, vecPrayCnt);
    end
end

--被人踢出教堂
function msg_activity.gc_kick_out_church(playerName, nchurchStar)
    --app.log("playerName=="..tostring(playerName).."   nchurchStar=="..tostring(nchurchStar));
    PublicFunc.msg_dispatch(msg_activity.gc_kick_out_church, playerName, nchurchStar);
end

--跨天时间重置
function msg_activity.gc_next_day_church_reset()
    --app.log("跨天时间重置");
    PublicFunc.msg_dispatch(msg_activity.gc_next_day_church_reset);
end

--当天时间用完
function msg_activity.gc_church_time_over()
    PublicFunc.msg_dispatch(msg_activity.gc_church_time_over);
end

--更新某个玩家信息(暂时主要是为了同步战斗状态)
function msg_activity.gc_update_churchPray_player_data(churchpray_role_data)
    PublicFunc.msg_dispatch(msg_activity.gc_update_churchPray_player_data, churchpray_role_data);
end

--查找教堂祈祷数据
function msg_activity.gc_look_for_rival(result,nstar,myprayIndex,refreshTimes,rivalData)
    --app.log(tostring(result)..".......")
    --app.log("posIndex##########"..tostring(rivalData.posIndex));
    --app.log("rivalData##########"..table.tostring(rivalData));
    if PublicFunc.GetErrorString(result, true) then
        
        g_dataCenter.ChurchBot:setnstar(nstar)
        g_dataCenter.ChurchBot:setmyprayIndex(myprayIndex)
        g_dataCenter.ChurchBot:setfindnumber(refreshTimes)
        g_dataCenter.ChurchBot:setFindRoleData(rivalData)
        app.log("..........."..tostring(g_dataCenter.ChurchBot:getFinishUI()))
        if g_dataCenter.ChurchBot:getFinishUI() then
            --ChurchBotTip:on_setFindData()
            PublicFunc.msg_dispatch(msg_activity.gc_look_for_rival);
        else
            --uiManager:PushUi(EUI.ChurchBotTip,myprayIndex);
            PublicFunc.msg_dispatch(msg_activity.gc_look_for_rival,myprayIndex,rivalData);
        end
        --PublicFunc.msg_dispatch(msg_activity.gc_look_for_rival,rivalData);
        
    end
end

--解锁
function msg_activity.gc_churchpray_unlock(result,index)
    if PublicFunc.GetErrorString(result, true) then
        --app.log("gc_churchpray_unlock##########"..tostring(index));
        g_dataCenter.ChurchBot:setUnlockPoslistData(index)
        PublicFunc.msg_dispatch(msg_activity.gc_churchpray_unlock,index);
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_QYZL);
    end
end

function msg_activity.gc_get_fightRecord_vigor(result,getVigorCnt,dataid,byFast)
    if PublicFunc.GetErrorString(result, true) then
        --app.log("getVigorCnt##########"..tostring(getVigorCnt));
        --app.log("dataid##########"..tostring(dataid));
        g_dataCenter.ChurchBot:UpdataFightReportjl(dataid)
        PublicFunc.msg_dispatch(msg_activity.gc_get_fightRecord_vigor,getVigorCnt,dataid,byFast);
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_QYZL_Repory);
    end    
end

function msg_activity.gc_buy_churchpray_vigor(result,number)
    if PublicFunc.GetErrorString(result, true) then
        g_dataCenter.ChurchBot:set_buy_vigor_number(number)
        PublicFunc.msg_dispatch(msg_activity.gc_buy_churchpray_vigor,number);
    end
end
------------------------------------- 扭蛋 ---------------------------- 
--        //请求自己的英雄扭蛋数据
function msg_activity.cg_niudan_request_role_info()
    --if not Socket.socketServer then return end
    --if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_niudan_request_role_info(robot_s)")
    --end
    nmsg_activity.cg_niudan_request_role_info(Socket.socketServer);
end
function msg_activity.gc_niudan_sync_role_info(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes,todayDiscountTimes)
    -- app.log("   gc_niudan_sync_role_info     ".. table.tostring({1,byfreeTime,CDLeftTime,useOnceTimes,userTenTimes}))
    PublicFunc.msg_dispatch(msg_activity.gc_niudan_sync_role_info, byfreeTime, CDLeftTime,useOnceTimes,userTenTimes,todayDiscountTimes);
    g_dataCenter.egg:gc_hero_info(byfreeTime,CDLeftTime, useOnceTimes,userTenTimes,todayDiscountTimes);
end
function msg_activity.gc_sync_gold_niudan_role_info(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
    -- app.log("   gc_sync_gold_niudan_role_info    "..table.tostring({1,byfreeTime,CDLeftTime,useOnceTimes,userTenTimes}))
    PublicFunc.msg_dispatch(msg_activity.gc_sync_gold_niudan_role_info, byfreeTime, CDLeftTime,useOnceTimes,userTenTimes);
    g_dataCenter.egg:gc_hero_info_gold(byfreeTime,CDLeftTime, useOnceTimes,userTenTimes);
end
function msg_activity.gc_sync_hunxia_state(nIndex)
    PublicFunc.msg_dispatch(msg_activity.gc_sync_hunxia_state, nIndex);
    g_dataCenter.egg:gc_hunxia_state(nIndex);
end
--        //请求自己的装备扭蛋数据
function msg_activity.cg_niudan_request_equip_info()
    --if not Socket.socketServer then return end
    --if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_niudan_request_equip_info(robot_s)")
    --end
    nmsg_activity.cg_niudan_request_equip_info(Socket.socketServer);
end
function msg_activity.gc_niudan_sync_equip_info(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes,todayDiscountTimes,todayUseMoneyTenTimes)
    -- app.log(table.tostring({2,byfreeTime,CDLeftTime,useOnceTimes,userTenTimes,todayDiscountTimes,todayUseMoneyTenTimes}))
    PublicFunc.msg_dispatch(msg_activity.gc_niudan_sync_equip_info, byfreeTime, CDLeftTime,useOnceTimes,userTenTimes,todayDiscountTimes,todayUseMoneyTenTimes);
    g_dataCenter.egg:gc_equip_info(byfreeTime,CDLeftTime, useOnceTimes,userTenTimes,todayDiscountTimes,todayUseMoneyTenTimes);
end
--        //使用扭蛋机type 0英雄, 1装备, 2金币
function msg_activity.cg_niudan_use(type,bTen)
    local key = tostring(type)..tostring(bTen)
    if not PublicFunc.lock_send_msg(msg_activity.cg_niudan_use,key) then return end

    --if not Socket.socketServer then return end
    --if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_niudan_use(robot_s, "..tostring(type)..", "..tostring(bTen)..")")
    --end
    nmsg_activity.cg_niudan_use(Socket.socketServer,type,bTen);
    GLoading.Show(GLoading.EType.msg)
end
function msg_activity.gc_niudan_use(result, type, bTen, vecReward,vecRealReward)
    GLoading.Hide(GLoading.EType.msg)
    local key = tostring(type)..tostring(bTen)
    PublicFunc.unlock_send_msg(msg_activity.cg_niudan_use,key)
    --[[
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)     
        return;
    end
    ]]
    GWriteEgg(type, bTen, vecReward);
    app.log("gc_niudan_use1")
    -- 扭蛋结果通知
    NoticeManager.Notice(ENUM.NoticeType.NiuDanSuccess, type, bTen)
    PublicFunc.msg_dispatch(msg_activity.gc_niudan_use, result, type, bTen, vecReward ,vecRealReward);
end
--        //兑换装备
function msg_activity.cg_niudan_exchange_equip(index, count)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_niudan_exchange_equip(Socket.socketServer, index, count);
end
function msg_activity.gc_niudan_exchange_equip(result,index,count)
    --[[
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)     
        return;
    end
    ]]
    PublicFunc.msg_dispatch(msg_activity.gc_niudan_exchange_equip, result, index, count);
end


--------------------------  运营活动 begin -------------------------------------
-- 请求活动状态 
function msg_activity.cg_activity_request_state()
    if isLocalData then
        activity_reward_local.cg_activity_request_state()
    else 
        --if not Socket.socketServer then return end
        --if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_activity.cg_activity_request_state(robot_s)")
        --end
        nmsg_activity.cg_activity_request_state(Socket.socketServer);
    end
     
end
function msg_activity.gc_activity_request_state(stateData)
     g_dataCenter.activityReward:setState(stateData)
end

--------------------- 登录奖励 ---------------------

-- 登录奖励配置
function msg_activity.cg_login_request_my_data()
    if isLocalData then
        activity_reward_local.cg_login_request_my_data()
    else 
        --if not Socket.socketServer then return end
        --if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_activity.cg_login_request_my_data(robot_s)")
        --end
        nmsg_activity.cg_login_request_my_data(Socket.socketServer);
    end
end
function msg_activity.gc_login_request_my_data(loginDays, configDatas, getIndexs) 
    g_dataCenter.activityReward:setLoginData(loginDays, configDatas, getIndexs)
    PublicFunc.msg_dispatch("msg_activity.gc_login_request_my_data");
end

-- 领取登录奖励
function msg_activity.cg_login_get_reward(index)
    if isLocalData then
        activity_reward_local.cg_login_get_reward(index)
    else 
        --if not Socket.socketServer then return end
        --if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_activity.cg_login_get_reward(robot_s, "..tostring(index)..")")
        --end
        nmsg_activity.cg_login_get_reward(Socket.socketServer, index)
    end
end
function msg_activity.gc_login_get_reward(result, index, reward)
    --[[
    if tonumber(result) ~= 0 then
        GLoading.Hide(GLoading.EType.msg)
        PublicFunc.GetErrorString(result)        
        return;
    end
    ]]
    g_dataCenter.activityReward:loginReward(index, reward)
end

--------------------- 闯关奖励 ---------------------

-- 闯关奖励配置
function msg_activity.cg_hurdle_request_my_data()
    if isLocalData then
        activity_reward_local.cg_hurdle_request_my_data()
    else 
        --if not Socket.socketServer then return end
        --if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_activity.cg_hurdle_request_my_data(robot_s)")
        --end
        nmsg_activity.cg_hurdle_request_my_data(Socket.socketServer);
    end
end
function msg_activity.gc_hurdle_request_my_data(configDatas, getIndexs) 
    g_dataCenter.activityReward:setHurdleData(configDatas, getIndexs)
end

-- 领取闯关奖励
function msg_activity.cg_hurdle_get_reward(index)
    if isLocalData then
        activity_reward_local.cg_hurdle_get_reward(index)
    else 
        --if not Socket.socketServer then return end
        nmsg_activity.cg_hurdle_get_reward(Socket.socketServer, index)
    end
end
function msg_activity.gc_hurdle_get_reward(result, index, reward)
    --[[
    if tonumber(result) ~= 0 then
        GLoading.Hide(GLoading.EType.msg)
        PublicFunc.GetErrorString(result)        
        return;
    end
    ]]
    g_dataCenter.activityReward:hurdleReward(index, reward)
end

--------------------------  运营活动 end -------------------------------------
--------------------- 金币兑换 ---------------------
function msg_activity.cg_exchange_gold()
    if isLocalData then
       
    else 
        --if not Socket.socketServer then return end
        nmsg_activity.cg_exchange_gold(Socket.socketServer)
    end
end
function msg_activity.gc_exchange_gold(result,vecReward)
    --[[
    if tonumber(result) ~= 0 then
        local bsuccess,strError = PublicFunc.GetErrorString(result,false)
        PublicFunc.GetErrorString(result)
        return;
    end
    ]]
    FloatTip.Float("获得金币："..vecReward[1].count)
    PublicFunc.msg_dispatch(msg_activity.gc_exchange_gold,vecReward[1].count);
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.ShopMoney)
end
--------------------- 金币兑换 end---------------------


--------------------- 每日充值活动 ----------------------

--[[请求配置数据]]
function msg_activity.cg_get_everyday_recharge_data()
    --if not Socket.socketServer then return end
    --if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_get_everyday_recharge_data(robot_s)")
    --end
    nmsg_activity.cg_get_everyday_recharge_data(Socket.socketServer)
end

--[[领取奖励]]
function msg_activity.cg_get_everyday_recharge_gift_bag(day)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_everyday_recharge_gift_bag(Socket.socketServer, day)
end

--[[更新活动时间]]
function msg_activity.gc_update_gm_activity_time(activityid, begin_time, end_time)
    g_dataCenter.activityReward:updateGmActivityTime(activityid, begin_time, end_time)
end

--[[
//每日充值配置项
struct everyday_recharge_config_item
{
	int	id;						//第几天
	int	recharge_crystal;		//当日充值多少钻石可开启礼包
	list<item_id_num>	gift_bag;	//礼包内容
}
]]
--[[更新活动配置]]
function msg_activity.gc_update_everyday_recharge_gift_bag_config(bagConfig, ext_award)
    g_dataCenter.activityReward:updateERConfig(bagConfig, ext_award)
    PublicFunc.msg_dispatch("msg_activity.EveryDayRechargeUI.updateUi")
end

--[[可领取天数]]
function msg_activity.gc_update_everyday_recharge_can_get_gift_bag_day(days)
    g_dataCenter.activityReward:updateERGetDays(days)
    PublicFunc.msg_dispatch("msg_activity.EveryDayRechargeUI.updateUi")
end

--[[当天充值钻石]]
function msg_activity.gc_update_everyday_recharge_current_day_state(ofday, crystalNum, isComplete)
    g_dataCenter.activityReward:updateERCrystal(ofday, crystalNum, isComplete)
    PublicFunc.msg_dispatch("msg_activity.EveryDayRechargeUI.updateUi")
end

--[[领取礼包结果]]
function msg_activity.gc_get_everyday_recharge_gift_bag_ret(result, giftbag)
    GLoading.Hide(GLoading.EType.msg)
    --[[
    if tonumber(result) ~= 0 then
        local bsuccess,strError = PublicFunc.GetErrorString(result,false)
        FloatTip.Float(strError)
        return
    else
    ]]
        CommonAward.Start(giftbag)
    --end
end	

--[[服务器推送公告信息]]
function msg_activity.gc_sync_all_yunying_notice(vecData)
	app.log("所有公告来啦！");
	-- app.log(table.tostring(vecData));
	AnnouncementData = vecData;
	for k,v in pairs(AnnouncementData) do 
		v.displayed = false;
	end
	local fightManager = FightScene.GetFightManager();
	if fightManager ~= nil and fightManager._className == "MainCityFightManager" then 
		EmergencyAnnouncement.ShowUI();
	end 
end

--[[服务器新增一条公告信息]]
function msg_activity.gc_add_yunying_notice(data)
	app.log("来了个新公告！");
	data.displayed = false;
	table.insert(AnnouncementData,data);
	local fightManager = FightScene.GetFightManager();
	if fightManager ~= nil and fightManager._className == "MainCityFightManager" then 
		EmergencyAnnouncement.ShowUI();
	end 
end

-- 等级基金
function msg_activity.cg_get_level_fund_state( )
    --if not Socket.socketServer then return end
    --if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_get_level_fund_state(robot_s)")
    --end
    nmsg_activity.cg_get_level_fund_state(Socket.socketServer)
end

function msg_activity.gc_level_fund_state( buyState, vecLevelState)
    PublicFunc.msg_dispatch("msg_activity.gc_level_fund_state", buyState, vecLevelState);
end

function msg_activity.cg_buy_level_fund( crystalNum )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_buy_level_fund(Socket.socketServer, crystalNum);
end

function msg_activity.gc_buy_back( result )
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_buy_back");
    end
end

function msg_activity.cg_get_level_fund_award( id )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_level_fund_award(Socket.socketServer, id);
end

function msg_activity.gc_get_back( result, id )
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_get_back", id);
    end
end

function msg_activity.gc_is_all_finish( isAll )
    if isAll == 1 then
        g_dataCenter.activityReward:SetLevelFundAll(isAll);
    end
end

-------------- 招募送礼 ---------------

function msg_activity.cg_get_recruit_states( )
    --if not Socket.socketServer then return end
    --if AppConfig.script_recording then
        PublicFunc.RecordingScript("msg_activity.cg_get_recruit_states(robot_s)")
    --end
    nmsg_activity.cg_get_recruit_states(Socket.socketServer);
end

function msg_activity.gc_recruit_states(result, end_time, vecRecruitStates)
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_recruit_states", end_time, vecRecruitStates);
    end
end

function msg_activity.cg_recruit_get_award( rid )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_recruit_get_award(Socket.socketServer, rid);
end

function msg_activity.gc_get_recruit_back(result, rid)
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_get_recruit_back", rid);
    end
end

-------------- 目标奖励 ---------------

function msg_activity.cg_get_target_award_states( activity_id )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_target_award_states(Socket.socketServer, activity_id);
end

function msg_activity.gc_target_award_states(result, start_time, end_time, vecTargetStates, activity_id)
    if result == 0 then
        g_dataCenter.activityReward:SetTargetData(start_time, end_time, vecTargetStates, activity_id);
        PublicFunc.msg_dispatch("msg_activity.gc_target_award_states", start_time, end_time, vecTargetStates, activity_id);
    end
end

function msg_activity.cg_get_target_award( t_id, activity_id )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_target_award(Socket.socketServer, t_id, activity_id);
end

function msg_activity.gc_get_target_award_back(result, t_id, awardList, activity_id)
    if result == 0 then
        -- app.log("------------- gc_get_target_award_back");
        PublicFunc.msg_dispatch("msg_activity.gc_get_target_award_back", t_id, awardList, activity_id);
    end
end

--------- 一元购 --------------
function msg_activity.cg_get_buy_1_state( )
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg);
    nmsg_activity.cg_get_buy_1_state(Socket.socketServer);
end

function msg_activity.gc_buy_1_state( start_time, end_time, state, vecAward, storeData )
    -- app.log("message:activity");
    GLoading.Hide(GLoading.EType.msg);
    PublicFunc.msg_dispatch("msg_activity.gc_buy_1_state", start_time, end_time, state, vecAward, storeData);
end

function msg_activity.cg_get_award( )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_award(Socket.socketServer);
end

function msg_activity.gc_get_buy_1_back( result, vecAward )
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_get_buy_1_back", vecAward );
    end
end

function msg_activity.gc_check_is_buy_1( state )
    g_dataCenter.activityReward:SetBuy1State(state);
    PublicFunc.msg_dispatch(msg_activity.gc_check_is_buy_1);
end

----------------------- 累计充值 --------------------------------
function msg_activity.cg_get_total_recharge_state( )
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg);
    nmsg_activity.cg_get_total_recharge_state(Socket.socketServer);
end

function msg_activity.cg_get_total_recharge_award( tId )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_total_recharge_award(Socket.socketServer, tId);
end

function msg_activity.gc_back_total_recharge_state( result, start_time, end_time, vecStates )
    GLoading.Hide(GLoading.EType.msg);
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_back_total_recharge_state", start_time, end_time, vecStates);
    end
end

function msg_activity.gc_back_total_recharge_award( result, tId, vecAward )
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_back_total_recharge_award", tId, vecAward);
    end
end


----------------------- 累计消费 -------------------------------
function msg_activity.cg_get_total_consume_state( )
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg);
    nmsg_activity.cg_get_total_consume_state(Socket.socketServer);
end

function msg_activity.cg_get_total_consume_award( tId )
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg);
    nmsg_activity.cg_get_total_consume_award(Socket.socketServer, tId);
end

function msg_activity.gc_back_total_consume_state( result, start_time, end_time, vecStates )
    GLoading.Hide(GLoading.EType.msg);
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_back_total_consume_state", start_time, end_time, vecStates);
    end
end

function msg_activity.gc_back_total_consume_award( result, tId, vecAward )
    GLoading.Hide(GLoading.EType.msg);
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_back_total_consume_award", tId, vecAward);
    end
end

-------------------- 战力排行 ---------------------
function msg_activity.cg_get_rank_power_state( )
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg);
    nmsg_activity.cg_get_rank_power_state(Socket.socketServer);
end

function msg_activity.cg_get_rank_power_award( rid )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_rank_power_award(Socket.socketServer, rid);
end

function msg_activity.gc_back_rank_power_state( result, start_time, end_time, vecStates )
    GLoading.Hide(GLoading.EType.msg);
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_back_rank_power_state", start_time, end_time, vecStates);
    end
end

function msg_activity.gc_back_rank_power_award( result, rid )
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_back_rank_power_award", rid);
    end
end

function msg_activity.cg_old_rank( )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_old_rank(Socket.socketServer);
end

function msg_activity.gc_old_rank( result, rank_type, my_rank, ranklist )
    if not rank_type or not my_rank or not ranklist then
        return;
    end
    local t = { my_rank = RankPlayer:new(my_rank), list = {} }
    for i, v in ipairs(ranklist) do
        table.insert(t.list, RankPlayer:new(v))
    end
    g_dataCenter.rankInfo:SetData(tonumber(rank_type), t)
    
    PublicFunc.msg_dispatch(msg_rank.gc_rank, rank_type, my_rank, ranklist);
end

------------------- 招财猫 ----------------
function msg_activity.cg_get_luck_cat_state( )
    --if not Socket.socketServer then return end
    -- app.log("-------------cg_get_luck_cat_state");
    nmsg_activity.cg_get_luck_cat_state(Socket.socketServer);
end

function msg_activity.cg_get_luck_cat_castal( use_times )
     --if not Socket.socketServer then return end
    nmsg_activity.cg_get_luck_cat_castal(Socket.socketServer, use_times);
end

function msg_activity.cg_get_luck_cat_loop( )
     --if not Socket.socketServer then return end
    nmsg_activity.cg_get_luck_cat_loop(Socket.socketServer);
end


function msg_activity.gc_luck_cat_state( result, use_times)
    if result == 0 then
        -- app.log("----------------- 1408")
        PublicFunc.msg_dispatch(msg_activity.gc_luck_cat_state, use_times);
    end
end

function msg_activity.gc_luck_cat_castal( result, use_times, castal_num)
    if result == 0 then
        PublicFunc.msg_dispatch(msg_activity.gc_luck_cat_castal, use_times, castal_num);
    else
        PublicFunc.GetErrorString(result);
    end
end

function msg_activity.gc_luck_cat_loop( result, player_get_castals)
    if result == 0 then
        PublicFunc.msg_dispatch(msg_activity.gc_luck_cat_loop, player_get_castals);
    end
end


------------------- 改变活动时间 -----------
-----暂时只添加了目标奖励活动
function msg_activity.gc_change_activity_time(start_time, end_time, activity_id)
    -- app.log("-------------activity_id:" .. activity_id .. "-- start_time: " .. start_time .. "-- end_time: " .. end_time  .. "-- now_time: " .. system.time());
    
    g_dataCenter.activityReward:ChangeActivityTimeForActivityID(activity_id, start_time, end_time);
    PublicFunc.msg_dispatch("msg_activity.gc_change_activity_time", activity_id);
end

---- 活动开启状态
function msg_activity.gc_init_activity_state( result, activity_state_list )
    -- app.log("------------activity: " .. table.tostring(activity_state_list));
    if result == 0 then
        g_dataCenter.activityReward:ResetAllActivityTime()
        for k,v in pairs(activity_state_list) do
            local bPause = false;
            if v.is_pause and v.is_pause == 1 then
                bPause = true;
            end
            g_dataCenter.activityReward:SetActivityTimeForActivityID(
                    v.activity_id,
                    v.start_time,
                    v.end_time,
                    v.activity_name,
                    v.extra_num,
                    v.close_time,
                    bPause,
                    v.is_reset,
                    v.param_1,
                    v.param_2
                    );
            -- if tonumber(v.activity_id) == ENUM.Activity.activityType_score_hero or tonumber(v.activity_id) == ENUM.Activity.activityType_golden_egg then
            --     PublicFunc.msg_dispatch("msg_activity.gc_init_activity_state.spec", tonumber(v.activity_id))
            -- end
        end
    end
    PublicFunc.msg_dispatch("msg_activity.gc_init_activity_state", activity_state_list);
end

function msg_activity.gc_pause_activity(is_pause, activity_id)
    -- app.log("------------gc_pause_activity: activity_id  ==  " .. tostring(activity_id).."  is_pause ==  "..tostring(is_pause));
    g_dataCenter.activityReward:PauseActivityForActivityID(activity_id, is_pause);
    -- if tonumber(activity_id) == ENUM.Activity.activityType_score_hero or tonumber(activity_id) == ENUM.Activity.activityType_golden_egg then
    --     PublicFunc.msg_dispatch("msg_activity.gc_pause_activity.spec")
    -- end
    PublicFunc.msg_dispatch("msg_activity.gc_pause_activity");
end

------------------ 活动小红点 -------------------------
---- 初始化活动小红点状态
function msg_activity.gc_init_activity_red_point_state( red_point_states )
    -- app.log("---- is_red:" .. table.tostring(red_point_states))
    for k,v in pairs(red_point_states) do
        g_dataCenter.activityReward:SetInitRedPointState(v);
    end
end

function msg_activity.cg_kuikuliya_request_all_floor_data()
    --if not Socket.socketServer then return end
    --if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_kuikuliya_request_all_floor_data(robot_s)")
    --end
    nmsg_activity.cg_kuikuliya_request_all_floor_data(Socket.socketServer);
end

--兑换道具

function msg_activity.gc_get_exchange_config(result, activityid, exhcangeinfo)
    PublicFunc.unlock_send_msg(msg_activity.gc_get_exchange_config, 'msg_activity.gc_get_exchange_config')

    if result == 0 then
        g_dataCenter.activityReward:SetExchangeItemActConfig(activityid, exhcangeinfo.exchange_info)
    end
end

function msg_activity.cg_get_exchange_item_state(activity_id)
    if not PublicFunc.lock_send_msg(msg_activity.cg_get_exchange_item_state, 'msg_activity.cg_get_exchange_item_state') then return end
    --if not Socket.socketServer then return end

    nmsg_activity.cg_get_exchange_config(Socket.socketServer, activity_id)
    nmsg_activity.cg_get_exchange_item_state(Socket.socketServer, activity_id)
end

function msg_activity.gc_get_exchange_item_state(result, states, activity_id)
    PublicFunc.unlock_send_msg(msg_activity.cg_get_exchange_item_state, 'msg_activity.cg_get_exchange_item_state')
    --app.log("#hyg#gc_get_exchange_item_state " .. tostring(result) .. ' ' .. table.tostring(states))
    if result == 0 then
        g_dataCenter.activityReward:SetExchangeItemAllState(states, activity_id)
    end

    PublicFunc.msg_dispatch(msg_activity.gc_get_exchange_item_state, result, states, activity_id)
end

function msg_activity.cg_exchange_item_exchange(id, times, activity_id)
    --if not Socket.socketServer then return end
    if not PublicFunc.lock_send_msg(msg_activity.cg_exchange_item_exchange, 'msg_activity.cg_exchange_item_exchange') then return end
    nmsg_activity.cg_exchange_item_exchange(Socket.socketServer, id, times, activity_id)
end

function msg_activity.gc_exchange_item_exchange(result, id, times, activity_id)
    PublicFunc.unlock_send_msg(msg_activity.cg_exchange_item_exchange, 'msg_activity.cg_exchange_item_exchange')
    if result == 0 then
        g_dataCenter.activityReward:ExchangeItemSucc(id, times, activity_id)
    end

    PublicFunc.msg_dispatch(msg_activity.gc_exchange_item_exchange, result, id, times, activity_id)
end

--------------------------全服抢购----------------------------

function msg_activity.cg_get_all_buy_state(day)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_activity.cg_get_all_buy_state(Socket.socketServer, day)
end

function msg_activity.gc_get_all_buy_state(result, day, item_1_num, is_buy_1, item_2_num, is_buy_2)
    GLoading.Hide(GLoading.EType.msg)
    --[[
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    ]]
    g_dataCenter.activityReward:SetServerBuyState(day, item_1_num, is_buy_1 == 1, item_2_num, is_buy_2 == 1)
    PublicFunc.msg_dispatch(msg_activity.gc_get_all_buy_state)
end


function msg_activity.cg_all_buy_item(day, option)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_activity.cg_all_buy_item(Socket.socketServer, day, option)
end

local _MessageErrorCode_SellOut = 84211000

function msg_activity.gc_all_buy_item(result, day, option, item_1_num, item_2_num, reward)
    GLoading.Hide(GLoading.EType.msg)

    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        --服务器已购买完
        if result == _MessageErrorCode_SellOut then
            local state = g_dataCenter.activityReward:GetServerBuyState(day)
            state[option].count = 0
            PublicFunc.msg_dispatch(msg_activity.gc_all_buy_item, result)
        end
        return
    end

    local state = g_dataCenter.activityReward:GetServerBuyState(day)
    local is_buy_1 = state[1].isBuy
    local is_buy_2 = state[2].isBuy
    --左
    if option == 1 then
        is_buy_1 = true
    --右
    elseif option == 2 then
        is_buy_2 = true
    end

    g_dataCenter.activityReward:SetServerBuyState(day, item_1_num, is_buy_1, item_2_num, is_buy_2)
    PublicFunc.msg_dispatch(msg_activity.gc_all_buy_item, result)
end

function msg_activity.cg_login_back_get_state()
    --if not Socket.socketServer then return end
    -- GLoading.Show(GLoading.EType.msg)
    nmsg_activity.cg_login_back_get_state(Socket.socketServer)
end

function msg_activity.gc_login_back_get_state( result, states )
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_login_back_get_state", states);
    end
end

function msg_activity.cg_login_back_get_award( id )
    --if not Socket.socketServer then return end
    -- GLoading.Show(GLoading.EType.msg)
    nmsg_activity.cg_login_back_get_award(Socket.socketServer, id);
end

function msg_activity.gc_login_back_get_award( result, vecreward )
    if result == 0 then
        PublicFunc.msg_dispatch("msg_activity.gc_login_back_get_award", vecreward);
    end
end


function msg_activity.cg_vip_gift_get_state()
    if not PublicFunc.lock_send_msg(msg_activity.cg_vip_gift_get_state, 'msg_activity.cg_vip_gift_get_state') then return end
    --if not Socket.socketServer then return end

    nmsg_activity.cg_vip_gift_get_state(Socket.socketServer)
end

function msg_activity.gc_vip_gift_get_state(result, states)
    PublicFunc.unlock_send_msg(msg_activity.cg_vip_gift_get_state, 'msg_activity.cg_vip_gift_get_state')
    -- app.log("#hyg# gc_vip_gift_get_state " .. table.tostring(states))
    if result == 0 then
        g_dataCenter.activityReward:SetVipBagAllState(states)
    end

    PublicFunc.msg_dispatch(msg_activity.gc_vip_gift_get_state, result, states)
end

function msg_activity.cg_vip_gift_buy(vipleve, times)
    if not PublicFunc.lock_send_msg(msg_activity.cg_vip_gift_buy, 'msg_activity.cg_vip_gift_buy') then return end
    --if not Socket.socketServer then return end

    nmsg_activity.cg_vip_gift_buy(Socket.socketServer, vipleve, times)
end

function msg_activity.gc_vip_gift_buy(result, viplevel, buytimes, timesNum)
    PublicFunc.unlock_send_msg(msg_activity.cg_vip_gift_buy, 'msg_activity.cg_vip_gift_buy')
    -- app.log("#hyg# gc_vip_gift_buy " .. result .. ' ' .. viplevel .. ' ' .. buytimes .. ' ' .. timesNum)
    if result == 0 then
        g_dataCenter.activityReward:VipGiftBuySucc(viplevel, buytimes, timesNum)
    end

    PublicFunc.msg_dispatch(msg_activity.gc_vip_gift_buy, result, viplevel, buytimes, timesNum)
end

function msg_activity.cg_discount_buy_times( )
    --if not Socket.socketServer then return end

    nmsg_activity.cg_discount_buy_times(Socket.socketServer);
end

function msg_activity.gc_discount_buy_times( result, times_1, times_2, times_3 )
    if result == 0 then
        PublicFunc.msg_dispatch(msg_activity.gc_discount_buy_times, times_1, times_2, times_3);
    end
end

function msg_activity.cg_discount_buy_buy( id )
    --if not Socket.socketServer then return end

    nmsg_activity.cg_discount_buy_buy(Socket.socketServer, id);
end

function msg_activity.gc_discount_buy_buy( result, id )
    if result == 0 then
        PublicFunc.msg_dispatch(msg_activity.gc_discount_buy_buy, id );
    end
end

----------------------分享活动----------------------------------
function msg_activity.cg_share_activity_state()
    --if not Socket.socketServer then return end
    --if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_activity.cg_share_activity_state(robot_s)")
    --end
    nmsg_activity.cg_share_activity_state(Socket.socketServer)
end

function msg_activity.gc_share_activity_state(result, list)
    if result == 0 then
        --app.log("list =============="..table.tostring(list))
        g_dataCenter.activityShare:SetData(list)
        PublicFunc.msg_dispatch(msg_activity.gc_share_activity_state);
    end
end

function msg_activity.cg_share_activity_complete(id)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_share_activity_complete(Socket.socketServer,id)
end

function msg_activity.gc_share_activity_complete(result,id)
    if result == 0 then
        g_dataCenter.activityShare:SetStateToShare(id)
        PublicFunc.msg_dispatch(msg_activity.gc_share_activity_complete);
    end
end

function msg_activity.cg_share_activity_get_award(id)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_share_activity_get_award(Socket.socketServer,id)
end

function msg_activity.gc_share_activity_get_award(result,id,awardlist)
    if result == 0 then
        g_dataCenter.activityShare:SetStateToAward(id,awardlist)
        PublicFunc.msg_dispatch(msg_activity.gc_share_activity_get_award);
        CommonAward.Start(awardlist)
    end
end

----------------------------------------积分英雄---------------------------------------


--[[请求积分英雄数据]]
function msg_activity.cg_requset_score_hero_data()
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_activity.cg_requset_score_hero_data(Socket.socketServer)
end

--[[请求排行榜]]
function msg_activity.cg_request_score_hero_rankList()
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_activity.cg_request_score_hero_rankList(Socket.socketServer)
end

--[[领取积分英雄宝箱奖励]]
function msg_activity.cg_score_hero_get_box_reward(index)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_activity.cg_score_hero_get_box_reward(Socket.socketServer, index)
end

--[[同步积分英雄数据]]
function msg_activity.gc_sync_score_hero_data(scorePoint, vecBoxRewardGeted, freeTime, myRankIndex)
    GLoading.Hide(GLoading.EType.msg)
    g_dataCenter.activityReward:SetScoreHeroData(scorePoint, vecBoxRewardGeted, freeTime, myRankIndex)
    PublicFunc.msg_dispatch(msg_activity.gc_sync_score_hero_data)
end

--[[请求排行榜]]
function msg_activity.gc_request_score_hero_rankList(vecRankList)
    GLoading.Hide(GLoading.EType.msg)
    g_dataCenter.activityReward:SetScoreHeroRankList(vecRankList)
    PublicFunc.msg_dispatch(msg_activity.gc_request_score_hero_rankList)
end

--[[领取积分英雄宝箱奖励返回]]
function msg_activity.gc_score_hero_get_box_reward(result, index, vecReward)
    GLoading.Hide(GLoading.EType.msg)
    --[[
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    ]]
    CommonAward.Start(vecReward)
    g_dataCenter.activityReward:SetScoreBoxIsGet(index)
    PublicFunc.msg_dispatch(msg_activity.gc_score_hero_get_box_reward)
end

-------------- 后台设置小额累计充值 -----------------
function msg_activity.cg_every_recharge_back_state( )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_every_recharge_back_state(Socket.socketServer);
end

function msg_activity.gc_every_recharge_back_state( result, day, progress, award )
    if result == 0 then
        -- app.log("day:" .. day .. " progress:" .. progress .. " award:" .. table.tostring(award))
        PublicFunc.msg_dispatch(msg_activity.gc_every_recharge_back_state, day, progress, award);
    end
end

function msg_activity.cg_every_recharge_back_get_award( day )
    --if not Socket.socketServer then return end
    nmsg_activity.cg_every_recharge_back_get_award(Socket.socketServer, day);
end

function msg_activity.gc_every_recharge_back_get_award( result, award )
    if result == 0 then
        PublicFunc.msg_dispatch(msg_activity.gc_every_recharge_back_get_award, award)
    end
end

--------------------福利宝箱
function msg_activity.cg_welfare_treasure_box_get_config(localSaveTime)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_welfare_treasure_box_get_config(Socket.socketServer, localSaveTime);
end
function msg_activity.gc_welfare_treasure_box_get_config(ret, boxs, items)
    if ret == 1 then
        return;
    end
    if PublicFunc.GetErrorString(ret) then
        g_dataCenter.store:UpdateWelfareBoxList(boxs, items);
        g_dataCenter.store:CheckWelfareBoxRedPoint();
        PublicFunc.msg_dispatch(msg_activity.gc_welfare_treasure_box_get_config, boxs, items)
    end
end

function msg_activity.cg_welfare_treasure_box_get_state()
    --if not Socket.socketServer then return end
    nmsg_activity.cg_welfare_treasure_box_get_state(Socket.socketServer);
end
function msg_activity.gc_welfare_treasure_box_get_state(ret, totalScore, itemStates, boxStates)
    if not PublicFunc.GetErrorString(ret) then
        return;
    end
    for _,itemState in pairs(itemStates) do
        g_dataCenter.store:UpdateWelfareBoxItemsState(itemState);
    end
    for _,itemState in pairs(boxStates) do
        g_dataCenter.store:UpdateWelfareBoxBoxsState(itemState);
    end
    g_dataCenter.store:SetWelfareBoxScore(totalScore);
    g_dataCenter.store:CheckWelfareBoxRedPoint();
    PublicFunc.msg_dispatch(msg_activity.gc_welfare_treasure_box_get_state)
end

function msg_activity.cg_welfare_treasure_box_buy_item(id,num)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_welfare_treasure_box_buy_item(Socket.socketServer, id,num);
end
function msg_activity.gc_welfare_treasure_box_buy_item(ret, newScore, itemState, gainItem)
    if not PublicFunc.GetErrorString(ret) then
        return;
    end
    g_dataCenter.store:UpdateWelfareBoxItemsState(itemState);
    g_dataCenter.store:SetWelfareBoxScore(newScore);
    g_dataCenter.store:CheckWelfareBoxRedPoint();
    PublicFunc.msg_dispatch(msg_activity.gc_welfare_treasure_box_buy_item, newScore, itemState, gainItem)
end

function msg_activity.cg_welfare_treasure_box_open_box(id)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_welfare_treasure_box_open_box(Socket.socketServer, id);
end
function msg_activity.gc_welfare_treasure_box_open_box(ret, boxState, gainItems)
    if not PublicFunc.GetErrorString(ret) then
        return;
    end
    g_dataCenter.store:UpdateWelfareBoxBoxsState(boxState);
    g_dataCenter.store:CheckWelfareBoxRedPoint();
    PublicFunc.msg_dispatch(msg_activity.gc_welfare_treasure_box_open_box, boxState, gainItems)
end

--获取商城活动的配置
function msg_activity.cg_get_time_limit_gift_bag_config(localSaveTime)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_time_limit_gift_bag_config(Socket.socketServer, localSaveTime);
end
--返回商城活动配置
function msg_activity.gc_get_time_limit_gift_bag_config(ret, tabPageInfo, goods)
    if ret == 1 then
        return;
    end
    if PublicFunc.GetErrorString(ret) then
        g_dataCenter.store:UpdateActiveList(tabPageInfo, goods);
        PublicFunc.msg_dispatch(msg_activity.gc_get_time_limit_gift_bag_config, tabPageInfo, goods)
    end
end

--获取商品购买状态
function msg_activity.cg_get_time_limit_gift_bag_state()
    --if not Socket.socketServer then return end
    nmsg_activity.cg_get_time_limit_gift_bag_state(Socket.socketServer);
end
--返回商城活动购买状态
function msg_activity.gc_get_time_limit_gift_bag_state(ret, states)
    PublicFunc.GetErrorString(ret);
    for _,itemState in pairs(states) do
        g_dataCenter.store:UpdateState(itemState);
    end
    PublicFunc.msg_dispatch(msg_activity.gc_get_time_limit_gift_bag_state)
end

--商品id
function msg_activity.cg_buy_time_limit_gift_bag_item(id, buyTimes, currencyType)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_buy_time_limit_gift_bag_item(Socket.socketServer, id, buyTimes, currencyType);
end
--返回购买状态
function msg_activity.gc_buy_time_limit_gift_bag_item(ret, itemState, gainItems)
    g_dataCenter.store:UpdateState(itemState);
    if PublicFunc.GetErrorString(ret) then
        PublicFunc.msg_dispatch(msg_activity.gc_buy_time_limit_gift_bag_item, gainItems);
    end
end
--人民币购买成功
function msg_activity.gc_time_limit_gift_bag_rmb_buy_suc(overLimit, itemState, gainItems)
    g_dataCenter.store:UpdateState(itemState);
    PublicFunc.msg_dispatch(msg_activity.gc_time_limit_gift_bag_rmb_buy_suc, gainItems)
end

function msg_activity.cg_hero_trial_get_init_info()
    --if not Socket.socketServer then return end
    nmsg_activity.cg_hero_trial_get_init_info(Socket.socketServer)
end

function msg_activity.gc_hero_trial_get_init_info(result, info)
    -- app.log("#hero_trial# gc_hero_trial_get_init_info "..table.tostring({result, info}))
    if PublicFunc.GetErrorString(result) then
        local hero_trial = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial]
        hero_trial:gc_hero_trial_get_init_info(info)

        PublicFunc.msg_dispatch(msg_activity.gc_hero_trial_get_init_info, info)
    end
end

function msg_activity.cg_hero_trial_get_week_awards(index)
    --if not Socket.socketServer then return end
    nmsg_activity.cg_hero_trial_get_week_awards(Socket.socketServer, index)
end

function msg_activity.gc_hero_trial_get_week_awards(result, index, awards)
    -- app.log("#hero_trial# gc_hero_trial_get_week_awards "..table.tostring({result, index, awards}))
    if PublicFunc.GetErrorString(result) then
        local hero_trial = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial]
        hero_trial:UpdateTakenBoxAwards(index)
        PublicFunc.msg_dispatch(msg_activity.gc_hero_trial_get_week_awards, index, awards)

        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_HeroTrial);
    end
end

function msg_activity.cg_hero_trial_get_fight_box_awards()
    --if not Socket.socketServer then return end
    nmsg_activity.cg_hero_trial_get_fight_box_awards(Socket.socketServer)
end

function msg_activity.gc_hero_trial_get_fight_box_awards(result, awards)
    -- app.log("#hero_trial# gc_hero_trial_get_fight_box_awards "..table.tostring({result, awards}))
    if PublicFunc.GetErrorString(result) then
        local hero_trial = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial]
        hero_trial:UpdateFightBoxCount()

        PublicFunc.msg_dispatch(msg_activity.gc_hero_trial_get_fight_box_awards, awards)
    end
end

------------------------------ 订阅中---------------------------------
function msg_activity.cg_subscribe_get_state_list( )
     --if not Socket.socketServer then return end
    nmsg_activity.cg_subscribe_get_state_list(Socket.socketServer);
end

function msg_activity.cg_subscribe_set_state( )
     --if not Socket.socketServer then return end
    nmsg_activity.cg_subscribe_set_state(Socket.socketServer);
end

function msg_activity.gc_subscribe_get_state_list( result, is_buy, start_time_ref, states )
    if result == 0 then
        g_dataCenter.activityReward:SetSubscribeState(is_buy);
        g_dataCenter.activityReward:SetSubscribeStateList(states);
        PublicFunc.msg_dispatch(msg_activity.gc_subscribe_get_state_list, start_time_ref);
    end
end

function msg_activity.gc_subscribe_set_state( result, id, state )
    if result == 0 then
        g_dataCenter.activityReward:SetStateById( id, state);
        PublicFunc.msg_dispatch(msg_activity.gc_subscribe_set_state);
    end
end

function msg_activity.cg_subscribe_get_award( id )
     --if not Socket.socketServer then return end
    nmsg_activity.cg_subscribe_get_award(Socket.socketServer, id);
end

function msg_activity.gc_subscribe_get_award( result, id, awards )
    if result == 0 then
        g_dataCenter.activityReward:SetStateById( id, 2);
        PublicFunc.msg_dispatch(msg_activity.gc_subscribe_get_award, awards);
    end
end


----------------------------砸金蛋------------------------------

function msg_activity.cg_golden_egg_use(index)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_activity.cg_golden_egg_use(Socket.socketServer, index);
end

function msg_activity.gc_golden_egg_use(result, index, verReward, multiple)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    local function onRewardShowOver()
        PublicFunc.msg_dispatch(msg_activity.gc_golden_egg_use, index)
    end

    CommonAward.Start(verReward, nil, nil, nil, multiple)
    CommonAward.SetFinishCallback(onRewardShowOver)
end

function msg_activity.gc_sync_my_golden_egg_data(ticketCnt, todayProfit, todayCanGetTicketCnt, vecOpenRecord)
    local getRecord = {}
    for k, v in pairs(vecOpenRecord) do
        if tonumber(v) ~= 0 then
            getRecord[k] = tonumber(v)
        end
    end
    g_dataCenter.activityReward:SyncGoldenEgg(ticketCnt, todayProfit, todayCanGetTicketCnt, getRecord)
    PublicFunc.msg_dispatch(msg_activity.gc_sync_my_golden_egg_data)
end


----------------------- 贩卖机 ---------------------
function msg_activity.cg_vending_machine_get_state()
--[[ test
    do
    TimerManager.Add(function()
        msg_activity.gc_vending_machine_get_state(0, 0)
    end, 1000)
    return
    end
--]]
    --if not Socket.socketServer then return end
    nmsg_activity.cg_vending_machine_get_state(Socket.socketServer)
end

function msg_activity.gc_vending_machine_get_state(result, hasBuyTimes)
    -- app.log("#vending_machine# gc_vending_machine_get_buy_record "..table.tostring({result, hasBuyTimes}))
    if PublicFunc.GetErrorString(result) then
        g_dataCenter.activityReward:SetInitVendingMachine()
        g_dataCenter.activityReward:UpdateVendingMachineBuyTimes(hasBuyTimes)
        PublicFunc.msg_dispatch(msg_activity.gc_vending_machine_get_state, hasBuyTimes)
    end
end

function msg_activity.cg_vending_machine_get_buy_record()
--[[ test
    do
    local records = {0,0,0}
    records[1] = {
        {playerid="1", name="玩家1", time=1, obtainRedCrystal=432},
        {playerid="2", name="玩家2", time=2, obtainRedCrystal=321},
    }
    records[2] = {
        {playerid="2", name="玩家2", time=2, obtainRedCrystal=321},
        {playerid="3", name="玩家3", time=3, obtainRedCrystal=222},
        {playerid="4", name="玩家4", time=4, obtainRedCrystal=333},
    }
    records[3] = {
        {playerid="3", name="玩家3", time=3, obtainRedCrystal=222},
        {playerid="4", name="玩家4", time=4, obtainRedCrystal=333},
        {playerid="5", name="玩家5", time=5, obtainRedCrystal=444},
    }
    _test_record_index = _test_record_index or 0
    _test_record_index = _test_record_index % 3
    _test_record_index = _test_record_index + 1
    TimerManager.Add(function()
        msg_activity.gc_vending_machine_get_buy_record(records[_test_record_index])
    end, 1000)
    return
    end
--]]
    --if not Socket.socketServer then return end
    nmsg_activity.cg_vending_machine_get_buy_record(Socket.socketServer)
end

function msg_activity.gc_vending_machine_get_buy_record(records)
    -- app.log("#vending_machine# gc_vending_machine_get_buy_record "..table.tostring(records))
    g_dataCenter.activityReward:SetVendingMachineNewRecords(records)
    PublicFunc.msg_dispatch(msg_activity.gc_vending_machine_get_buy_record, records)
end

function msg_activity.cg_vending_machine_buy()
--[[ test
    do
    TimerManager.Add(function()
        _test_buy_times = _test_buy_times or 0
        _test_buy_times = _test_buy_times + 6
        msg_activity.gc_vending_machine_buy(0, 999, _test_buy_times)

        local player = g_dataCenter.player
        local records = {
            {playerid="1", name="玩家1", time=1, obtainRedCrystal=432},
            {playerid="2", name="玩家2", time=2, obtainRedCrystal=321},
            {playerid=player:GetGID(), name=player:GetName(), time=9, obtainRedCrystal=999},
        }
        msg_activity.gc_vending_machine_get_buy_record(records)

    end, 1000)
    return
    end
--]]
    --if not Socket.socketServer then return end
    nmsg_activity.cg_vending_machine_buy(Socket.socketServer)
end

function msg_activity.gc_vending_machine_buy(result, redCrystalNum, hasBuyTimes)
    -- app.log("#vending_machine# gc_vending_machine_buy "..table.tostring({result, redCrystalNum, hasBuyTimes}))
    if PublicFunc.GetErrorString(result) then
        g_dataCenter.activityReward:UpdateVendingMachineBuyTimes(hasBuyTimes)
    end
    PublicFunc.msg_dispatch(msg_activity.gc_vending_machine_buy, result, redCrystalNum, hasBuyTimes)
end



