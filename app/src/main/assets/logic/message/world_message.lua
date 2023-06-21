--[[
region world_message.lua.lua
date: 2015-10-15
time: 10:53:6
author: Nation
]]
world_msg = world_msg or {}
local _uiManager = nil;
function world_msg.gc_world_map_inf(map_inf)
    --加载场景的时候关闭消息分发
    if map_inf.active_type == MsgEnum.eactivity_time.eActivityTime_openWorld then
        map_inf.level_index = map_inf.map_gid
    end
    app.opt_enable_net_dispatch(false);
    --Socket.StopPingPong()
    if map_inf.active_type == MsgEnum.eactivity_time.eActivityTime_WorldBoss then
        
    elseif  map_inf.active_type == MsgEnum.eactivity_time.eActivityTime_fuzion then
        g_dataCenter.fuzion:SetShowFighter(map_inf.member_info)
    elseif  map_inf.active_type == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
        g_dataCenter.fuzion2:SetShowFighter(map_inf.member_info)
    elseif  map_inf.active_type == MsgEnum.eactivity_time.eActivityTime_threeToThree then
        _uiManager = uiManager;
        timer.create("world_msg.gc_world_map_inf___3v3_delay", 500, 1);

        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]:SetShowFighter(map_inf.member_info)
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.Begin3v3Fight);

    elseif  map_inf.active_type == MsgEnum.eactivity_time.eActivityTime_1v1 then
        _uiManager = uiManager;
        timer.create("world_msg.gc_world_map_inf___1v1_delay", 500, 1);

    end

    local lastMethodType = FightScene.GetPlayMethodType()
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    local fs = FightStartUpInf:new()
	local defTeam = g_dataCenter.player:GetDefTeam()
    app.log("server map id="..map_inf.level_index.."   map_gid=="..map_inf.map_gid)
	fs:SetLevelIndex(map_inf.level_index)
    fs:SetPlayMethod(map_inf.active_type);
    fs:SetWorldGID(map_inf.map_gid)
	--fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
    FightScene.is_loading_reconnect = map_inf.reconnect

    if map_inf.active_type == MsgEnum.eactivity_time.eActivityTime_openWorld then
        SceneManager.ReplaceScene(FightScene,fs)

    elseif map_inf.active_type == MsgEnum.eactivity_time.eActivityTime_1v1 then
        if lastMethodType and lastMethodType == MsgEnum.eactivity_time.eActivityTime_1v1 then
            SceneManager.ReplaceScene(FightScene,fs)
        else
            SceneManager.PushScene(FightScene,fs)
        end

    else
    	SceneManager.PushScene(FightScene,fs)
    end

    Socket.Pvp3v3 = true

    HintUI.Close() --关闭弹窗
end


function world_msg.create_fighter___normal(data)
    if g_dataCenter.player.playerid == data.owner_gid and not FightScene.flgPlayedSceneChange then
        FightScene.flgPlayedSceneChange = true;
        UiLevelLoadingNew.Destroy()
        UiSceneChange.Exit()
    end
end

function world_msg.create_fighter___fuzion(data)
    local ret = g_dataCenter.fuzion:UpdateFighter(data)
    if ret then
        UiLevelLoadingNew.Destroy()
        UiSceneChange.Exit()
        -- 321倒数开始
        if not FightScene.is_loading_reconnect then
            -- NewFightUiCount.Start()
            FightStartUI.Show();
        end
    end
end
function world_msg.create_fighter___fuzion2(data)
    local ret = g_dataCenter.fuzion2:UpdateFighter(data)
    if ret then
        UiLevelLoadingNew.Destroy()
        UiSceneChange.Exit()
        -- 321倒数开始
        if not FightScene.is_loading_reconnect then
            -- NewFightUiCount.Start()
            FightStartUI.Show({need_pause=true});
        end
    end
end
function world_msg.create_fighter___3v3(data)
    if g_dataCenter.player.playerid == data.owner_gid then
        --清空当前UI栈
        -- uiManager:PushUi(EUI.CommomPlayUI)
        -- uiManager:ClearStack()

        UiLevelLoadingNew.Destroy()
        UiSceneChange.Exit()
        -- 321倒数开始
        if not FightScene.is_loading_reconnect then
            -- NewFightUiCount.Start()
            FightStartUI.Show({need_pause=true});
        end
    end
end

function world_msg.gc_world_map_inf___3v3_delay()
    if _uiManager == nil then
        return;
    end
    _uiManager:RemoveUi(EUI.MobaMatchingUI);
    _uiManager:RemoveUi(EUI.MobaReadyEnterUI);
    _uiManager:RemoveUi(EUI.QingTongJiDiHeroChoseUI);
    _uiManager:RemoveUi(EUI.QingTongJiDiRoomUI);
end

function world_msg.gc_world_map_inf___1v1_delay()
    if _uiManager == nil then
        return;
    end
    _uiManager:RemoveUi(EUI.ChatFightSelectBuffUI);
    _uiManager:RemoveUi(EUI.ChatFightSelectHeroUI);
end

function world_msg.gc_create_fighter(data)
    app.log("创建角色 id="..data.player_gid.." "..data.owner_gid.." "..data.x.." "..data.y)
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        return
    end
    data.x = data.x*PublicStruct.Coordinate_Scale_Decimal
    data.y = data.y*PublicStruct.Coordinate_Scale_Decimal
    local object = ObjectManager.GetObjectByGID(data.player_gid)
    if object then
        ObjectManager.RemoveObject(object)
    end
    FightScene.CreatePVPHero(data);
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion then
        world_msg.create_fighter___fuzion(data)
    elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
        world_msg.create_fighter___fuzion2(data)
    elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
        world_msg.create_fighter___3v3(data)
    else
        world_msg.create_fighter___normal(data)
    end

    --自动寻路
    if data.owner_gid == g_dataCenter.player:GetGID() then
        if g_dataCenter.autoPathFinding.isFinding then
            local my_captain = FightScene.GetFightManager().GetMyCaptain();
            if my_captain then
                my_captain.start_path_finding = true;
            end
        end
    end
end

function world_msg.gc_del_fighter(gid)
    local is_ai_agent = false
    if g_dataCenter.fight_info.ai_agent_target_gid[gid] then
        is_ai_agent = true;
        g_dataCenter.fight_info.ai_agent_target_gid[gid] = nil
        if Utility.getTableEntityCnt(g_dataCenter.fight_info.ai_agent_target_gid) == 0 then
            FightScene.StopAIAgentKeepAlive()
        end

    end

    --app.log("删除英雄"..gid)
    local captain = g_dataCenter.fight_info:GetCaptain()
    local user = ObjectManager.GetObjectByGID(gid)
    if user then
        if captain and captain:GetAttackTarget() == user then
            captain:SetAttackTarget(nil)
        end
        if user:IsMyControl() then
            GetMainUI():ClearReliveInfo(user:GetName())
        end
        if is_ai_agent then
            if user:IsMonster() then
                local homePos = user:GetHomePosition();
                --app.log("home x="..homePos.x.." z="..homePos.z)
                if user.navMeshAgent then
                    user:SetNavFlag(true, false)
                    local x,y,z = user:GetLocalPosition3f()
                    local path = user.navMeshAgent:calculate_path(homePos.x, y, homePos.z)
                    if path then
                        local path_size = #path
                        local path_node = {}
                        if path_size >= 2 then
                            table.insert(path_node, {x=x*PublicStruct.Coordinate_Scale, y=z*PublicStruct.Coordinate_Scale})
                            for i=2, path_size do
                                table.insert(path_node, {x=path[i].x*PublicStruct.Coordinate_Scale, y=path[i].z*PublicStruct.Coordinate_Scale})
                            end
						    -- app.log("path_node="..table.tostring(path_node))
						    if path_size == 2 then
							    msg_move.cg_move_home(user:GetGID(), path_node[1].x, path_node[1].y, path_node[2].x, path_node[2].y)
						    elseif path_size == 3 then
							    msg_move.cg_move_home(user:GetGID(), path_node[1].x, path_node[1].y, path_node[2].x, path_node[2].y, path_node[3].x, path_node[3].y)
                            elseif path_size == 4 then
                                msg_move.cg_move_home(user:GetGID(), path_node[1].x, path_node[1].y, path_node[2].x, path_node[2].y, path_node[3].x, path_node[3].y, path_node[4].x, path_node[4].y)
						    end

                        end
                    end
                    --app.log("home="..table.tostring(path_node))

                end
            end
        end
        if GetMainUI() and GetMainUI():GetWorldTreasureBox() then
            GetMainUI():GetWorldTreasureBox():on_out_treasure_box(user);
        elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
            world_msg.del_fighter___fuzion2(gid)
        end

        NoticeManager.Notice(ENUM.NoticeType.DeleteWorldObject, user)
        FightScene.DeleteObj(user.name, 0)
    end
end

function world_msg.del_fighter___fuzion2(gid)
    g_dataCenter.fuzion2:DelFighter(gid);
end

function world_msg.gc_player_full_data(data)
end

function world_msg.gc_create_monster(data)
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        return
    end
    data.x = data.x*PublicStruct.Coordinate_Scale_Decimal
    data.y = data.y*PublicStruct.Coordinate_Scale_Decimal

    --app.log("创建monster id="..data.monster_gid.." "..data.config_id.." "..data.x.." "..data.y..table.tostring(data));

    data.born_x = data.born_x*PublicStruct.Coordinate_Scale_Decimal
    data.born_y = data.born_y*PublicStruct.Coordinate_Scale_Decimal
    data.level = 1
    FightScene.CreatePVPMonster(data);
    --app.log("创建完成")
end

function world_msg.gc_create_world_item(data)
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        return
    end
    data.x = data.x*PublicStruct.Coordinate_Scale_Decimal
    data.y = data.y*PublicStruct.Coordinate_Scale_Decimal
    local item_data = ConfigManager.Get(EConfigIndex.t_world_item, data.config_id)
--    app.log("刷新物品"..data.config_id)
    local item = FightScene.CreateItem(nil, item_data.model_id, data.camp_flag, item_data.trigger_id, item_data.effect_id, data.item_gid, data.config_id, data.is_opened)
    if item then
        item:SetPosition(data.x, 2, data.y, nil, true)
		item:SetScale(item_data.radius, item_data.radius, item_data.radius)

        NoticeManager.Notice(ENUM.NoticeType.CreateWorldItem, item)
    end
end

function world_msg.gc_fighter_relive(info)
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        return
    end
    info.x = info.x*PublicStruct.Coordinate_Scale_Decimal
    info.y = info.y*PublicStruct.Coordinate_Scale_Decimal
    local fighter = ObjectManager.GetObjectByGID(info.fighter_gid)
    if fighter then
        fighter:SetProperty(ENUM.EHeroAttribute.max_hp, info.max_hp);
        fighter:SetProperty(ENUM.EHeroAttribute.cur_hp, info.cur_hp);
        --[[fighter:SetPosition(info.x, 10, info.y)
		fighter:SetBornPoint(info.x, 10, info.y)
        if fighter:IsMyControl() then
            fighter:SetHandleState(EHandleState.Manual, true)
        else
            fighter:SetState(ESTATE.Stand, true)
        end]]
        fighter:Reborn(info.x, 5, info.y)
        NoticeManager.Notice(ENUM.NoticeType.ReliveWorldFighter, fighter)
        if fighter:IsMyControl() then
            app.log_warning("my control reborn "..fighter.name)
            local captain = g_dataCenter.fight_info:GetCaptain()
            if captain == nil or captain:IsDead() then
                local index = g_dataCenter.fight_info:GetControlIndex(fighter:GetName())
                if index ~= -1 then
                    g_dataCenter.player:ChangeCaptain(index, nil, false, true)
                end
            end
            GetMainUI():UpdateHeadData()
        end
    end
end

-- 通知英雄复活时间点
function world_msg.gc_fighter_relive_time(fightGid, reliveTime)
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion then
        g_dataCenter.fuzion:SetFighterReliveTime(fightGid, reliveTime)
    elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
        g_dataCenter.fuzion2:SetFighterReliveTime(fightGid, reliveTime)
    elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
        g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]:SetReliveTime(fightGid, reliveTime)
    end
end



-- 加载进度
function world_msg.gc_load_state(playerid, percent)
    -- app.log("  gc_load_state "..tostring(percent).." "..app.get_time())
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion then
        g_dataCenter.fuzion:PlayerLoadUpdate(playerid, percent)
    elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
        g_dataCenter.fuzion2:PlayerLoadUpdate(playerid, percent)
    end
    PublicFunc.msg_dispatch(world_msg.gc_load_state, playerid, percent)
end
--更新monster的标志
function world_msg.gc_update_monster_flag(data)
    local obj = ObjectManager.GetObjectByGID(data.monster_gid);
    if obj then
        obj:SetCanSearch(data.can_search);
    end
end

--请求几个大厅假人数据
function world_msg.cg_request_hall_mock_player(needCnt)
    --if not Socket.socketServer then return end
    nworld_msg.cg_request_hall_mock_player(Socket.socketServer,needCnt)
end

--请求几个大厅假人数据
function world_msg.gc_request_hall_mock_player(vecMockPlayer)
    PublicFunc.msg_dispatch(world_msg.gc_request_hall_mock_player, vecMockPlayer)
end

--进入场景失败
function world_msg.gc_fail_enter_world()
    SceneManager.PopScene()
end

----------------------------------------------------------------------------
function world_msg.cg_test_enter_world(world_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_test_enter_world(Socket.socketServer,world_id)
end

function world_msg.cg_test_leave_world(world_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_test_leave_world(Socket.socketServer,world_id)
end

function world_msg.cg_load_state(map_gid, percent, reconnect)
    --if not Socket.socketServer then return end
    nworld_msg.cg_load_state(Socket.socketServer,map_gid, percent, reconnect)
end

function world_msg.cg_enter_open_world(world_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_enter_open_world(Socket.socketServer, world_id)
end

function world_msg.cg_click_npc(user_gid, npc_id)
    if not PublicFunc.lock_send_msg(world_msg.cg_click_npc, npc_id) then return end
    --if not Socket.socketServer then return end
    nworld_msg.cg_click_npc(Socket.socketServer, user_gid, npc_id)
end

function world_msg.cg_accept_task(task_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_accept_task(Socket.socketServer, task_id)
end

function world_msg.cg_complete_task(task_id,sItem)
    --if not Socket.socketServer then return end
    nworld_msg.cg_complete_task(Socket.socketServer, task_id)
end

function world_msg.cg_giveup_task(task_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_giveup_task(Socket.socketServer, task_id)
end

function world_msg.gc_click_npc(npc_id)
    PublicFunc.unlock_send_msg(world_msg.cg_click_npc,npc_id)
    PublicFunc.msg_dispatch(world_msg.gc_click_npc,npc_id);
end

function world_msg.gc_play_screenplay(screenplay_id)
--    app.log_warning("播放NPC剧情："..tostring(screenplay_id))
    -- PublicFunc.msg_dispatch(world_msg.gc_play_screenplay ,screenplay_id);
    NoticeManager.Notice(ENUM.NoticeType.GcPlayScreenplay, screenplay_id)
end

function world_msg.gc_show_task_detail_info(task_id)
--    app.log_warning("播放NPC任务："..tostring(task_id))
    -- PublicFunc.msg_dispatch(world_msg.gc_show_task_detail_info ,task_id);
    NoticeManager.Notice(ENUM.NoticeType.GcShowTaskDeTailInfo, task_id)
end

function world_msg.gc_play_task_event(event_id)
--    app.log_warning("播放特殊事件任务：event:"..tostring(event_id))
    --PublicFunc.msg_dispatch(world_msg.gc_play_task_event, event_id);
    --local config = g_get_task_event(event_id)
    local config = ConfigManager.Get(EConfigIndex.t_task_event, event_id)
    --读条任务
    if config then
        if config.event_type == 0 then
            if GetMainUI():GetTaskLoadingBarUI() == nil then
                GetMainUI():InitTaskLoadingBarUI()
            end

            local cbfun = function ()
                world_msg.cg_update_task_condition(2, tostring(event_id))
            end
            GetMainUI():GetTaskLoadingBarUI():StartLoading(config.param1, config.param2, cbfun)
            GetMainUI():GetTaskLoadingBarUI():Show()
        --任务对话完成
        elseif config.event_type == 1 then
            world_msg.cg_update_task_condition(2, tostring(event_id))
        else

        end
    end
end

function world_msg.gc_accept_task(result, task_id)
--    app.log_warning("gc_accept_task："..tostring(result))
    if not PublicFunc.GetErrorString(result) then return end
    PublicFunc.msg_dispatch(world_msg.gc_accept_task, task_id);
--    app.log_warning("接受任务完成："..tostring(task_id))
    NoticeManager.Notice(ENUM.NoticeType.TaskAcceptOK, task_id);
    -- 检查自动做任务
    -- local config = g_get_task_data(task_id)
    -- if config and config.is_auto_do == 1 then
    --     g_dataCenter.task:TriggerAction(task_id)
    -- end
end

function world_msg.gc_complete_task(result, task_id, sItem)
    if not PublicFunc.GetErrorString(result) then return end
    PublicFunc.msg_dispatch(world_msg.gc_complete_task, task_id);
--    app.log_warning("提交任务完成："..tostring(task_id).." "..table.tostring(sItem))
    NoticeManager.Notice(ENUM.NoticeType.TaskSubmitOK, task_id);
    if sItem and #sItem > 0 then
        -- CommonAward.Start(sItem)
        for i, v in ipairs(sItem) do
            UiRollMsg.PushMsg( {priority = 1, number = v.id, count = v.count} )
        end
    end
end

function world_msg.gc_giveup_task(result, task_id)
    if not PublicFunc.GetErrorString(result) then return end
--    app.log_warning("放弃任务完成："..tostring(task_id))
    PublicFunc.msg_dispatch(world_msg.gc_giveup_task, task_id);
end

function world_msg.gc_sync_single_task(type, task_info)
    app.log_warning("同步单个任务："..tostring(type).." "..table.tostring(task_info))
    -- 跑环任务状态重置不处理
    if type == 2 and task_info.task_state == 1 then return end

    local old, new = g_dataCenter.task:UpdateTaskData( type, task_info );
    PublicFunc.msg_dispatch(world_msg.gc_sync_single_task, type, new);

    local updateNpc = false
    local updateState = false   -- 新增任务，完成任务
    local needTrigger = false
    local delay = false
    -- 新增任务
    if type == 0 then
        local task_id = task_info.task_id
        --local config = g_get_task_data(task_id)
        local config = ConfigManager.Get(EConfigIndex.t_task_data,task_id);
        -- 检查自动接受任务
        if config and config.is_auto_do == 1 then
            needTrigger = true
        end
        updateNpc = true
        updateState = true
    -- 删除任务
    elseif type == 1 then
        updateNpc = true
    -- 任务更新
    elseif type == 2 then
        --（若是完成某个条件，则触发自动寻路）
        local complete_state, t_type, index = g_dataCenter.task:GetUpdateTaskState(old, new);
        if complete_state then
            local task_id = task_info.task_id;
            --local config = g_get_task_data(task_id)
            local config = ConfigManager.Get(EConfigIndex.t_task_data,task_id);
            -- 停止自动战斗 等待1秒切换自动寻路
            if g_dataCenter.player:CaptionIsAutoFight() then
                g_dataCenter.player:ChangeFightMode(false)
                delay = true
            end

            -- 检查自动提交任务
            if new.task_state == 1 and config.is_auto_complete == 1 then
                needTrigger = true
            -- 检查自动完成任务下一条件
            elseif new.task_state == 0 and config.is_auto_do == 1 then
                needTrigger = true
            end
            updateNpc = true
            updateState = true

            -- 完成条件飘字显示
            local str = new:GetConditionStrByIndex(index, nil, true);
            if str and #str > 0 then
                local data = {str=str, priority = 1}
                UiRollMsg.PushMsg(data);
            end
        end
    end

    local fightManager = FightScene.GetFightManager()
    if fightManager and fightManager.UpdateNpcTask and updateNpc then
        fightManager:UpdateNpcTask(new);
    end
    if updateState then
        NoticeManager.Notice(ENUM.NoticeType.TaskStateUpdate, task_info.task_id);
    end

    if needTrigger then
        local duration = 200;
        if delay then duration = 1200 end
        world_msg._temp_task_id = task_info.task_id
        timer.create( "world_msg._temp_task_timer", duration, 1 )
    end
end

function world_msg._temp_task_timer()
    g_dataCenter.task:TriggerAction(world_msg._temp_task_id)
end

function world_msg.gc_sync_all_task(task_list)
--    app.log_warning("玩家身上的任务："..table.tostring(task_list))
    g_dataCenter.task:SetTaskList( task_list )
    PublicFunc.msg_dispatch(world_msg.gc_sync_all_task, task_list);
end

function world_msg.gc_add_referrer_task(taskid_list)
--    app.log_warning("推荐的任务列表："..table.tostring(taskid_list))
    g_dataCenter.task:SetTaskList( taskid_list, true )
    PublicFunc.msg_dispatch(world_msg.gc_add_referrer_task, taskid_list);

    local fightManager = FightScene.GetFightManager()
    if fightManager and fightManager.UpdateNpcTask then
        for i, id in ipairs(taskid_list) do
            local task = g_dataCenter.task:GetTaskById(id);
            fightManager:UpdateNpcTask(task);
        end
    end

    local task_id = taskid_list[1]
    --local config = g_get_task_data(task_id or 0)
    local config = ConfigManager.Get(EConfigIndex.t_task_data,task_id or 0);
    if config and config.is_auto_accept == 1 then
        g_dataCenter.task:TriggerAction(task_id)
    end
    NoticeManager.Notice(ENUM.NoticeType.TaskStateUpdate, task_id);
end

--更新任务某个条件
function world_msg.cg_update_task_condition(type, param1, param2, param3)
    --if not Socket.socketServer then return end
    nworld_msg.cg_update_task_condition(Socket.socketServer, type, param1, param2, param3);
end



--触发传送点
function world_msg.cg_trigger_translation_point(user_gid, translantion_id, target_index, src_x, src_y, world_gid)
    --if not Socket.socketServer then return end
    nworld_msg.cg_trigger_translation_point(Socket.socketServer,user_gid, translantion_id, target_index, src_x, src_y, world_gid);
end
function world_msg.gc_learn_skill(gid, skill_id, skill_level, skillIndex)
    if skillIndex == -1 then
        skillIndex = nil
    end
    local fighter = ObjectManager.GetObjectByGID(gid)
    if fighter then
        fighter:LearnSkill(skill_id, skill_level, nil, skillIndex, true)
        if fighter:GetName() == g_dataCenter.fight_info:GetCaptainName() then
            GetMainUI():UpdateSkillIcon(fighter)
        end
    end
end

function world_msg.gc_sync_player_camp_flag(camp_flag)
    g_dataCenter.player.camp_flag = camp_flag
end

--进入另外战斗场景
function world_msg.cg_enter_other_fight_scene(is_mmo_scene)
    --if not Socket.socketServer then return end
    nworld_msg.cg_enter_other_fight_scene(Socket.socketServer, is_mmo_scene);
end

function world_msg.gc_begin_mmo_relive()
    --app.log('world_msg.gc_begin_mmo_relive')
    PublicFunc.msg_dispatch(world_msg.gc_begin_mmo_relive)
end

function world_msg.cg_check_content_id(content_id,world_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_check_content_id(Socket.socketServer, content_id,world_id);
end

function world_msg.gc_check_content_id_rst(content_id,world_id,result)
    PublicFunc.msg_dispatch(world_msg.gc_check_content_id_rst,content_id,world_id,result)
    local active_id = MsgEnum.mmo_content[content_id];
    if active_id then
        g_dataCenter.activity[active_id]:SetOpenInfo(world_id,result);
    end
end

--    //请求传送到mmo地图
function world_msg.cg_request_transfer(world_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_request_transfer(Socket.socketServer, world_id);
end

function world_msg.cg_change_skill(user_gid, skill_id, index)
    --if not Socket.socketServer then return end
    nworld_msg.cg_change_skill(Socket.socketServer, user_gid, skill_id, index);
end

function world_msg.cg_trigger_npc_translation(user_gid, translantion_id, target_index, src_x, src_y, npc_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_trigger_npc_translation(Socket.socketServer, user_gid, translantion_id, target_index, src_x, src_y, npc_id);
end

--[[请求传送]]
function world_msg.cg_transfrom_to_boss(boss_id)
    --if not Socket.socketServer then return end
    nworld_msg.cg_transfrom_to_boss(Socket.socketServer, boss_id);
end

--[[传送返回]]
function world_msg.gc_transfrom_to_boss()
    --if not Socket.socketServer then return end
    --传送先到达传送点(避免直接被boss杀死)， 再次寻路
    g_dataCenter.bossList:path_finding(true)
end

--[[boss列表，状态更新]]
function world_msg.gc_mmo_boss_update(bosslist)
    --if not Socket.socketServer then return end
    g_dataCenter.bossList:update_boss_status(bosslist)
    g_dataCenter.bossList:send_kill_boss_marquee(bosslist)
    PublicFunc.msg_dispatch(world_msg.gc_mmo_boss_update)
end

function world_msg.cg_leave_open_world()
    --if not Socket.socketServer then return end
    nworld_msg.cg_leave_open_world(Socket.socketServer);
end

-- struct replace_hero_card_data
-- {
--     uint hero_gid;
--     int config_id;
--     int max_hp;
--     int cur_hp;
--     float move_speed;
--     list<skill_data> skill;
--     float original_move_speed;
-- };
function world_msg.gc_replace_hero_card(data)
    -- app.log("#lhf #"..table.tostring(data));
    local object = ObjectManager.GetObjectByGID(data.hero_gid)
    if object then
        data.player_gid = data.hero_gid;
        data.owner_gid = object.owner_player_gid
        data.owner_name = object.owner_player_name
        local pos = object:GetPosition();
        data.x = pos.x
        data.y = pos.z
        data.move_speed = object.speed_from_server
        data.des_x = 9999
        data.des_y = 9999
        data.camp_flag = object.camp_flag
        data.country_id = object.country_id
        data.captain  = object.is_captain
        FightScene.DeleteObj(object:GetName())
        FightScene.CreatePVPHero(data);
    end
end
--[[endregion]]
