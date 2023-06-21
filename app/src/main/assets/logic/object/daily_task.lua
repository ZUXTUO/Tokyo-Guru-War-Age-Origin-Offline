--日常任务数据中心
DailyTask = Class("DailyTask");

local _ref_time = {
	[22] = {[1] = 7, [2] = 12};
	[23] = {[1] = 12, [2] = 18};
	[24] = {[1] = 18, [2] = 21};
	[25] = {[1] = 21, [2] = 24};
}

function DailyTask:Init()
	self.bindfunc = {};
	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
	self:initData();
end

-- function DailyTask:RegistFunc()
-- 	UiBaseClass.RegistFunc(self);

	
-- end

function DailyTask:initData()
	self.taskdata = {};
	self.starRewardState = {};
	self.lineTaskData = {};
	-- 小红点状态
	self.m_red_state = false;
	self.m_line_red_state = false;

	self.m_is_daily_open = false;

	self.m_timer = 0;
end

function DailyTask:SetIsDailytaskOpen( isOpen )
	self.m_is_daily_open = isOpen;
end

function DailyTask:SetRedPointState( state )
	self.m_red_state = state;
	-- app.log("task_red_point:" .. tostring(self.m_red_state));
	
	-- app.log("task_red_point:" .. cf.data);
	-- app.log("task_red_point:" .. g_dataCenter.player.level);
 --    if cf and tonumber(cf.data) > tonumber(g_dataCenter.player.level) then
 --    	self.m_red_state = false;
 --    end
--	app.log("task_red_point:" .. tostring(self.m_red_state));
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Task_DailyTask);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Task);
	 
end

function DailyTask:GetRedPointState( )
	local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_daily_task_open);
	if cf and tonumber(cf.data) > tonumber(g_dataCenter.player.level) then
    	self.m_red_state = false;
    end
	return self.m_red_state;
end

function DailyTask:SetLineRedPointState( state )
	self.m_line_red_state = state;

	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Task_MainTask);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Task);
end

function DailyTask:GetLineRedPointState(  )
	return self.m_line_red_state;
end

--设置所有任务列表信息
function DailyTask:SetTaskData(vecTaskList)
	self.m_vecTaskList = vecTaskList;
	local result = false;
	self.taskdata = {};
	if self.m_timer and self.m_timer ~= 0 then
		timer.stop(self.m_timer);
		self.m_timer = 0;
	end
	for k,v in pairs(vecTaskList) do
		self.taskdata[v.taskIndex] = {};
		self.taskdata[v.taskIndex].taskIndex = v.taskIndex;
		self.taskdata[v.taskIndex].state = v.state;            --任务状态：0未完成1已完成2已领取
		self.taskdata[v.taskIndex].finishTimes = v.finishTimes;--已经完成次数
		if v.taskIndex == 22 or v.taskIndex == 23 or v.taskIndex == 24 or v.taskIndex == 25 then
            local sysTime = os.date("*t",system.time());
            local currentTime = tonumber(sysTime.hour .. string.format("%02d",sysTime.min) .. string.format("%02d",sysTime.sec));
            local item_data_config = ConfigManager.Get(EConfigIndex.t_dailytask, v.taskIndex);
            if currentTime > item_data_config.unlock_parm1 and currentTime < item_data_config.unlock_parm2 then
            	if v.state ~= 2 then
            		-- result = true;
            		g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_get_ap_reward, 1);
            	else
            		local d_hour = (_ref_time[v.taskIndex][2] - sysTime.hour - 1) * 60 * 60;
            		local d_min = (60 - sysTime.min - 1) * 60 ;
            		local d_sec = (60 - sysTime.sec);
            		local  timerDes = (d_hour + d_min + d_sec) * 1000 + 2000;
            		app.log("------------- timerDes1:" .. timerDes)
            		self.m_timer = timer.create(self.bindfunc["set_deff_time"], timerDes, 1);
            	end
            end
        elseif v.taskIndex == 17 or v.taskIndex == 18 then

        elseif v.state == 1 then
        	result = true;
        end
	end
--	app.log("-------------- DailyTask_point:" .. tostring(result));
	self:SetRedPointState(result);
	-- self:SetRedPointState(self:CheckTaskState());

end

function DailyTask:set_deff_time( )
	g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_get_ap_reward, 1);
end

function DailyTask:GetTaskData()
	return self.taskdata;
end

--返回指定任务是否可以领取
function DailyTask:TaskIsFinishAndNotGet(taskIndex)
	if not self.taskdata[taskIndex] then
		return false;
	end
	if self.taskdata[taskIndex].state == 1 then
		return true;
	end
    return false;
end

--返回指定任务是否已经领取
function DailyTask:TaskHasGet(taskIndex)
	if not self.taskdata[taskIndex] then
		return false;
	end
    if self.taskdata[taskIndex].state == 2 then
		return true;
	end
    return false;
end

--根据id得到日常任务信息
function DailyTask:GetTaskDataByTaskindex(taskIndex)
	if not self.taskdata[taskIndex] then
		app.log("taskIndex=="..taskIndex.."的日常任务信息为空"..debug.traceback());
		return nil;
	end
	return self.taskdata[taskIndex];
end

--刷新某一个任务信息
function DailyTask:UpdateTaskData(taskIndex, taskdata)
	-- if not self.taskdata[taskIndex] then
	-- 	app.log("有新任务  index, taskdata=="..table.tostringEx({index, taskdata}));
	-- end
	self.taskdata[taskIndex] = {};
	self.taskdata[taskIndex].taskIndex = taskdata.taskIndex;
	self.taskdata[taskIndex].state = taskdata.state;
	self.taskdata[taskIndex].finishTimes = taskdata.finishTimes;
end

function DailyTask:UpdataLineTaskData( taskdata )
	self.lineTaskData = taskdata;
	-- self:SetRedPointState(self:CheckTaskState());
	-- self:CheckTaskState();
	local result = false
	for k,v in pairs(self.lineTaskData) do
		if v.state == 1 then
			result = true;
		end
	end
	self:SetLineRedPointState(result);
end

function DailyTask:CheckTaskState( )
	local result = false;
	local get_ap_result = false;
	if self.m_timer and self.m_timer ~= 0 then
		timer.stop(self.m_timer);
		self.m_timer = 0;
	end
	if self.taskdata then
		for k,v in pairs(self.taskdata) do
			if v.taskIndex == 22 or v.taskIndex == 23 or v.taskIndex == 24 or v.taskIndex == 25 then
                local sysTime = os.date("*t",system.time());
                local currentTime = tonumber(sysTime.hour .. string.format("%02d",sysTime.min) .. string.format("%02d",sysTime.sec));
                local item_data_config = ConfigManager.Get(EConfigIndex.t_dailytask, v.taskIndex);
                if currentTime > item_data_config.unlock_parm1 and currentTime < item_data_config.unlock_parm2 then
                	if v.state ~= 2 then
                		get_ap_result = true;
                		g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_get_ap_reward, 1);
                		-- break;
                	else        		
	            		local d_hour = (_ref_time[v.taskIndex][2] - sysTime.hour - 1) * 60 * 60;
	            		local d_min = (60 - sysTime.min - 1) * 60 ;
	            		local d_sec = (60 - sysTime.sec);
	            		local  timerDes = (d_hour + d_min + d_sec) * 1000 + 2000;
	            		app.log("------------- timerDes1:" .. timerDes)
	            		self.m_timer = timer.create(self.bindfunc["set_deff_time"], timerDes, 1);
                	end
                end
            elseif v.taskIndex == 17 or v.taskIndex == 18 then
            	
            elseif v.state == 1 then
            	result = true;
            	self:SetRedPointState(true);
            	break;
            end
		end
	end

	-- if result == false then
		if self.lineTaskData then
			for k,v in pairs(self.lineTaskData) do
				if v.state == 1 then
					result = true;
					self:SetLineRedPointState(true);
					break;
				end
			end
		end
	-- end

	return result;
end

function DailyTask:GetLineTaskData(  )
	return self.lineTaskData;
end

--设置三个奖励的领取状态
function DailyTask:SetStarRewardState(starRewardState, taskeLevel)
	self.taskeLevel = taskeLevel or 1;
	-- app.log("starRewardState:" .. table.tostring(starRewardState));
	-- for k,v in pairs(starRewardState) do
	-- 	self.starRewardState[k] = v;
	-- end
end

function DailyTask:GetTaskLevel()
	if not self.taskeLevel then
		self.taskeLevel = 1;
	end
	return self.taskeLevel;
end

--刷新某一个奖励的领取状态
function DailyTask:UpdateStarRewardState(rewardIndex,state)
	self.starRewardState[rewardIndex] = state;
end

--得到奖励的领取状态
function DailyTask:GetStarRewardState(rewardIndex)
	if not self.starRewardState[rewardIndex] then
		--app.log_warning("rewardIndex=="..rewardIndex.."的奖励领取状态为空");
		return nil;
	end
	return self.starRewardState[rewardIndex];
end

--判断是否有未领取的奖励
function DailyTask:CheckNotGetReward()
	local have_not_get = false;
	--判断普通奖励是否有未领取的
	local taskdata = self:GetTaskData();
    local level = self:GetTaskLevel();
    local cnt = 0;
    local curStar = 0;
    for k,v in pairs(taskdata) do
        if v.state == 1 then
        	have_not_get = true;
        	return have_not_get;
        elseif v.state == 2 then
        	local getstar = ConfigManager.Get(EConfigIndex.t_dailytask,v.taskIndex).star;
        	curStar = curStar + getstar;
        end
    end

    --判断星星奖励是否有未领取的
    --星星奖励现在已经取消
    -- local unlockStar = {};
    -- for i=1,3 do
    --     unlockStar[i] = ConfigManager.Get(EConfigIndex.t_dailytask_star_reward,level)["star_unlock_"..i];
    --     local state = self:GetStarRewardState(i);
    --     if curStar >= unlockStar[i] then
    --         if state == 0 then   --未领取
    --             have_not_get = true;
    --             return have_not_get;
    --         end
    --     end
    -- end

    return have_not_get;
end
