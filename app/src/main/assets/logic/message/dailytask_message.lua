local isLocalData = true;
msg_dailytask = msg_dailytask or {}
msg_dailytask.is_cg_line = false
--请求日常任务信息
function msg_dailytask.cg_request_my_dailytask_info()
    if isLocalData then
        app.log("msg_dailytask.cg_request_my_dailytask_info 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_dailytask.cg_request_my_dailytask_info(robot_s)")
        end
        nmsg_dailytask.cg_request_my_dailytask_info(Socket.socketServer);
    end
end

--请求日常任务列表
function msg_dailytask.cg_request_dailytask_list()
    --app.log("请求日常任务列表"..debug.traceback());
    if isLocalData then
        app.log("msg_dailytask.cg_request_my_dailytask_info 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_dailytask.cg_request_dailytask_list(robot_s)")
        end
        nmsg_dailytask.cg_request_dailytask_list(Socket.socketServer);
    end
end

--领取奖励
function msg_dailytask.cg_finish_task(taskIndexs)
    if isLocalData then
        app.log("msg_dailytask.cg_finish_task 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            local _taskIndexs = "local taskIndexs = {}\n"
            for i=1, #taskIndexs do
                _taskIndexs = _taskIndexs.."\
                taskIndexs["..i.."] = "..tostring(taskIndexs[i]).."\n"
            end
            PublicFunc.RecordingScript(_taskIndexs.."nmsg_dailytask.cg_finish_task(robot_s, taskIndexs)")
        end
        nmsg_dailytask.cg_finish_task(Socket.socketServer, taskIndexs);
    end
end

-- 补领
function msg_dailytask.cg_repair_task( taskindex )
    --if not Socket.socketServer then return end
    nmsg_dailytask.cg_repair_task( Socket.socketServer, taskindex );
end

function msg_dailytask.gc_repair_task( result, vecItem )
    if result == 0 then
        PublicFunc.msg_dispatch(msg_dailytask.gc_repair_task, vecItem);
    end
end

-- 主线任务领取奖励
function  msg_dailytask.cg_line_finish_task( taskIndexs )
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        local _taskIndexs = "local taskIndexs = {}\n"
        for i=1, #taskIndexs do
            _taskIndexs = _taskIndexs.."\
            taskIndexs["..i.."] = "..tostring(taskIndexs[i]).."\n"
        end
        PublicFunc.RecordingScript(_taskIndexs.."nmsg_dailytask.cg_line_finish_task(robot_s, taskIndexs)")
    end
    nmsg_dailytask.cg_line_finish_task(Socket.socketServer, taskIndexs);
end

-- 主线任务一键领取奖励
function  msg_dailytask.cg_line_finish_task_all( taskIndexs )
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        local _taskIndexs = "local taskIndexs = {}\n"
        for i=1, #taskIndexs do
            _taskIndexs = _taskIndexs.."\
            taskIndexs["..i.."] = "..tostring(taskIndexs[i]).."\n"
        end
        PublicFunc.RecordingScript(_taskIndexs.."nmsg_dailytask.cg_line_finish_task_all(robot_s, taskIndexs)")
    end
    nmsg_dailytask.cg_line_finish_task_all(Socket.socketServer, taskIndexs);
end

--领取星星奖励
function msg_dailytask.cg_get_star_reward(starIndex)
    if isLocalData then
        app.log("msg_dailytask.cg_get_star_reward 暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_dailytask.cg_get_star_reward(Socket.socketServer, starIndex);
    end
end

--得到任务列表
function msg_dailytask.gc_sync_dailytask_list(vecTaskList)
    -- app.log("获得每日任务列表vecTaskList=="..table.tostring(vecTaskList));
    g_dataCenter.daily_task:SetTaskData(vecTaskList);
    PublicFunc.msg_dispatch(msg_dailytask.gc_sync_dailytask_list, vecTaskList);
end

--更新任务信息
function msg_dailytask.gc_update_dailytask_data(index, taskdata)
    --app.log("每日任务列表更新msg_dailytask.gc_update_dailytask_data  index, taskdata=="..table.tostring({index, taskdata}));
    g_dataCenter.daily_task:UpdateTaskData(index, taskdata);
    PublicFunc.msg_dispatch(msg_dailytask.gc_update_dailytask_data, index, taskdata);
end

--得到自己的日常任务信息
function msg_dailytask.gc_sync_my_dailytask_info(vecStarRewardFlag, taskeLevel)
    --app.log("得到自己的日常任务信息taskeLevel=="..tostring(taskeLevel).."   vecStarRewardFlag=="..table.tostring(vecStarRewardFlag));
    g_dataCenter.daily_task:SetStarRewardState(vecStarRewardFlag, taskeLevel);
    PublicFunc.msg_dispatch(msg_dailytask.gc_sync_my_dailytask_info, vecStarRewardFlag, taskeLevel);
end

-- 请求主线任务列表
function msg_dailytask.cg_on_line_task_state( )
    --if not Socket.socketServer then return end
    app.log("----------cg_on_line");
    
    if msg_dailytask.is_cg_line == false then
        msg_dailytask.is_cg_line = true;
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_dailytask.cg_on_line_task_state(robot_s)")
        end
        nmsg_dailytask.cg_on_line_task_state(Socket.socketServer);
    end
end

function msg_dailytask.gc_on_line_task_state(vecItem )
   -- if tonumber(result) ~= 0 then
   --      PublicFunc.GetErrorString(result);
   --      return;
   --  end
    app.log("88");
    msg_dailytask.is_cg_line = false;
    g_dataCenter.daily_task:UpdataLineTaskData(vecItem);
    PublicFunc.msg_dispatch(msg_dailytask.gc_on_line_task_state, result, vecItem);
end

--领取奖励
function msg_dailytask.gc_finish_task(result, vecItem)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
    PublicFunc.msg_dispatch(msg_dailytask.gc_finish_task, result, vecItem);
end

-- 主线任务领取奖励返回
function msg_dailytask.gc_line_finish_task(result, vecItem)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
    PublicFunc.msg_dispatch(msg_dailytask.gc_line_finish_task, result, vecItem);
end

-- 任务小红点返回
function msg_dailytask.gc_task_red_point( t_type, state )
    -- app.log("------------- gc_task_red_point:" .. t_type .. "--" .. state);
    -- do return end
    if state == 1 then
        if t_type == 0 then -- 每日任务
            g_dataCenter.daily_task:SetRedPointState(true);
        elseif t_type == 1 then -- 主线任务
            g_dataCenter.daily_task:SetLineRedPointState(true);
        elseif t_type == 2 then -- 大小月卡
            g_dataCenter.activityReward:SetMonthCard(true);
        elseif t_type == 3 then -- 30日签到
            g_dataCenter.activityReward:SetSignIn30RedPoint(true);
        end
    end
    PublicFunc.msg_dispatch(msg_dailytask.gc_task_red_point);
end

--领取星星奖励
function msg_dailytask.gc_get_star_reward(result, vecItem)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        return;
    end
    PublicFunc.msg_dispatch(msg_dailytask.gc_get_star_reward, result, vecItem);
end
