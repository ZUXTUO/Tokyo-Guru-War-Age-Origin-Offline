--region mmo_task.lua 任务数据管理
--Author : zzc
--Date   : 2016/3/16

MMOTask = Class("MMOTask")

function MMOTask:Init()
	self.cur_task_id = 0	-- 任务对话界面的任务id
	self.task_list = {}
	self.sub_task_list = {}
end

function MMOTask:SetCurTask( task_id )
	self.cur_task_id = task_id
end

function MMOTask:GetCurTask( task_id )
	return self.cur_task_id
end

-- 合并任务
function MMOTask:SetTaskList( list, isRecommend )
	if list then
		-- 将推荐任务id转换成任务信息
		if isRecommend then
			local task_list = {}
			for k, id in pairs(list) do
				local task_info = {task_id=id, condition_list={}}
				local config = ConfigManager.Get(EConfigIndex.t_task_data,id)
				for i, con in ipairs(config.complete_condition) do
					local task_condition_info = {}
					task_condition_info.condition_type = con.type;
					task_condition_info.condition_value = con.value or 0;
					task_condition_info.complete_value = 0;
					table.insert(task_info.condition_list, task_condition_info);
				end
				table.insert(task_list, task_info);
			end
			list = task_list;
		end

		for i, v in pairs(list) do
			self.task_list[v.task_id] = MMOTaskInfo:new(v)
		end

		-- 检查添加的子任务类型
		local sub_list = {}
		for i, v in pairs(list) do
			local main_task = nil
			local task = self.task_list[v.task_id]
			if task:IsLoopSubTask() then
				sub_list[v.task_id] = task:GetLoopRelatedId()
			end
		end

		-- 将子任务提取出来放到父任务上，从列表中移除
		for sub_id, main_id in pairs(sub_list) do
			self.sub_task_list[sub_id] = main_id;
		end
	end
end

-- ntype 0新增，1删除，2更新
function MMOTask:UpdateTaskData( ntype, task_info )
	local task = MMOTaskInfo:new(task_info)
	local old = self.task_list[task.task_id]

	if ntype == 0 then
		if task:IsLoopSubTask() then
			self.sub_task_list[task.task_id] = task:GetLoopRelatedId()
		end
		self.task_list[task.task_id] = task;
		app.log("=== 新增："..task.task_id)
	elseif ntype == 1 then
		if task:IsLoopSubTask() then
			self.sub_task_list[task.task_id] = nil
		end
		self.task_list[task.task_id] = nil
		app.log("=== 删除："..task.task_id)
	elseif ntype == 2 then
		self.task_list[task.task_id] = task
		app.log("=== 更新："..task.task_id)
	end
	return old, task;
end

-- 得到更新的任务状态
function MMOTask:GetUpdateTaskState( old, new )
	if old and new then
		for i, v in ipairs(old.condition_list) do
			local new_v = new.condition_list[i]
			if not table.compare_value(v, new_v) then
				return new:GetConditionResult(nil, new_v), v.condition_type, i;
			end
		end
	end
end

function MMOTask:GetList()
	return self.task_list
end

-- 按排序好返回任务列表，用于快捷追踪界面
function MMOTask:GetListByOrder()
	return self:GetSortTask(self.task_list)
end

-- 按大类返回任务列表，用于任务列表界面
function MMOTask:GetListByType()
	local result = {}
	local tempRet = {}
	local config = nil
	for k, v in pairs(self.task_list) do
		if not v:IsLoopSubTask() then
			config = ConfigManager.Get(EConfigIndex.t_task_data,v.task_id)
			if tempRet[config.task_type] == nil then
				tempRet[config.task_type] = {}
			end
			table.insert(tempRet[config.task_type], v)
		end
	end
	
	-- 按任务大类由小到大排序
	for k, data in pairs_key(tempRet) do
		table.insert(result, {task_type=k, data=self:GetSortTask(data)})
	end

	return result;
end

function MMOTask:GetSortTask(list)
	local result = {}
	local t = {}
	local config = nil
	for i, v in pairs(list) do
		if not v:IsLoopSubTask() then
			config = ConfigManager.Get(EConfigIndex.t_task_data,v.task_id)
			-- task_order显示权重，值大的显示在前面
			local order = (20 - v.task_type) * 10000 + (10000 - config.task_order)
			-- 完成待提交的放到最前面
			if v.task_state == 1 then
				order = order + 1000000
			-- 跑环子任务完成的放到其他完成任务的后面
			elseif v:IsLoopMainTask() then
				local loop_sub_task = v:GetLoopRelatedTask()
				if loop_sub_task and loop_sub_task.task_state == 1 then
					order = order + 500000
				end
			end
			table.insert(t, {order=order, i=i})
		end
	end
	table.sort(t, function(A, B)
		if A == nil or B == nil then return false end
		return A.order > B.order;
	end)

	for i, data in pairs(t) do
		table.insert(result, list[data.i])
	end

	return result;
end

-- 按任务Id查询任务
function MMOTask:GetTaskById( id )
	return self.task_list[id]
end

function MMOTask:TriggerAction( id )
	local fightManager = FightScene.GetFightManager();
	--当前已经在寻路中
	if fightManager == nil or fightManager.IsLoadComplete == nil then
		app.log_warning("MMO战斗管理器未初始化。。。")
		return
	end

	if fightManager:IsLoadComplete() == false then
		app.log_warning("MMO战斗管理器还在加载中。。。")
		return
	elseif fightManager:GetNpcID() then
		app.log_warning("当前已经在寻路中。。。")
		return
	end
	
	local task = self.task_list[id]
	if task then
		app.log_warning("开始新的寻路。。。")
		task:TriggerAction()
	end
end

--[[ 任务是否满足接受条件
参数：
	id : 任务id
返回：
	result    true/false	可接状态
--]]
function MMOTask:CanAcceptTaskById( id )
	local task = self:GetTaskById(id)
	if task == nil then
		local config = ConfigManager.Get(EConfigIndex.t_task_data,id)
		local task_info = {task_id=id, condition_list={}}
		for i, con in ipairs(config.complete_condition) do
			local task_condition_info = {}
			task_condition_info.condition_type = con.type;
			task_condition_info.condition_value = con.value or 0;
			task_condition_info.complete_value = 0;
			table.insert(task_info.condition_list, task_condition_info);
		end
		task = MMOTaskInfo:new(task_info)
	end

	return task:CanAcceptTask();
end

--[[ 获取接任务描述（包含了未完成条件）
参数：
	id : 任务id
返回：
	未满足的接受条件字符串数组
说明：
	若任务接受条件不满足，返回任务描述+未满足条件
	若任务接受条件满足，返回任务描述
--]]
function MMOTask:GetAcceptTaskDesById( id )
	local task = self:GetTaskById(id)
	if task == nil then
		local config = ConfigManager.Get(EConfigIndex.t_task_data,id)
		local task_info = {task_id=id, condition_list={}}
		for i, con in ipairs(config.complete_condition) do
			local task_condition_info = {}
			task_condition_info.condition_type = con.type;
			task_condition_info.condition_value = con.value or 0;
			task_condition_info.complete_value = 0;
			table.insert(task_info.condition_list, task_condition_info);
		end
		task = MMOTaskInfo:new(task_info)
	end

	return task:GetAcceptTaskDes();
end

--[[ 获取任务的完成条件文本数组
参数：
	id : 任务id
返回：
	字符串数组
--]]
function MMOTask:GetConditionStrArrayById( id )
	local task = self:GetTaskById(id)
	if task == nil then
		local task_info = {task_id=id, condition_list={}}
		local config = ConfigManager.Get(EConfigIndex.t_task_data,id)
		for i, con in ipairs(config.complete_condition) do
			local task_condition_info = {}
			task_condition_info.condition_type = con.type;
			task_condition_info.condition_value = con.value or 0;
			task_condition_info.complete_value = 0;
			table.insert(task_info.condition_list, task_condition_info);
		end
		task = MMOTaskInfo:new(task_info)
	end

	return task:GetConditionStrArray()
end

--[[ 获取任务倒计时时间
参数：
	id : 任务id
返回：
	倒计时格式如：00:00:00
--]]
function MMOTask:GetCountdownTimeStrById( id )
	local result = ""
	local task = self:GetTaskById(id)
	if task then
		result = task:GetCountdownTimeStr()
	end
	return result;
end

--是否接了主线关卡任务
function MMOTask:IsAcceptHurdleTask(hurdle_id)
	local result = false
	for k, v in pairs(self.task_list) do
		if v.task_state == 0 then
			for m, n in pairs(v.condition_list) do
				if n.condition_type == 11 then
					local config = ConfigManager.Get(EConfigIndex.t_task_data,v.task_id)
					if config and config.complete_condition[m] and 
						config.complete_condition[m].param1 == hurdle_id then
						result = true;
						break;
					end
				end
			end
		end
	end
	return result
end