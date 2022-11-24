--region mmo_task_info.lua 任务详细信息
--Author : zzc
--Date   : 2016/3/16

MMOTaskInfo = Class("MMOTaskInfo")

local _EAcceptCondition = 
{
	eAcceptCondition_Level		= 0, 		-- 满足指定等级可接任务
	eAcceptCondition_HeroInTeam = 1,		-- 携带指定英雄可接任务（星级，英雄等级）
	eAcceptCondition_InGuild 	= 2, 		-- 处于公会中
	eAcceptCondition_HaveItem 	= 3,		-- 拥有指定物品
	eAcceptCondition_Country 	= 4, 		-- 指定国家
	eAcceptCondition_Heros 		= 5, 		-- 携带一定数量指定条件英雄
	eAcceptCondition_Ring 		= 6, 		-- 接受的跑环任务id
};

local _EAcceptConditionString = 
{
	[0] = "[FF0000FF](战队等级Lv%s)[-]",
	[1] = "[FF0000FF](上阵英雄%s)[-]",
	[2] = "[FF0000FF](加入公会)[-]",
	[3] = "[FF0000FF](获得[%s])[-]",
	[4] = "[FF0000FF](指定XX国家)[-]",
	[5] = "[FF0000FF](上阵英雄%s)[-]",
};

local _ECompleteCondition =
{
	eCompleteCondition_KillMonster	= 0,	-- 杀敌指定怪物
	eCompleteCondition_KillPlayer	= 1,	-- 杀死指定玩家
	eCompleteCondition_SpecialEvent = 2,	-- 完成指定特殊事件
	eCompleteCondition_GetItem		= 3,	-- 获得指定道具
	eCompleteCondition_Level		= 4,	-- 达到指定等级
	eCompleteCondition_GetHero		= 5,	-- 获得指定英雄
	eCompleteCondition_OnTime		= 6,	-- 限时任务
	eCompleteCondition_Immediately	= 7,	-- 立即完成
	eCompleteCondition_TalkNpc		= 8,	-- 与NPC对话
	eCompleteCondition_Ring			= 9,	-- 跑环次数
	eCompleteCondition_ToPosition	= 10,	-- 跑到指定位置点
	eCompleteCondition_PassHurdle	= 11,	-- 通关关卡
	eCompleteCondition_GetSpeHero	= 12,	-- 获得指定编号英雄
	eCompleteCondition_DoneDaily	= 13,	-- 完成每日任务
};

local _ECompleteConditionString =
{
	[0] = {"击杀","[%s]"},			-- 杀敌指定怪物(进度:0/1)
	[1] = {"击败","%s","的英雄"},	-- 杀死指定英雄
	[2] = {},						-- 完成指定特殊事件		(需要配置给出)
	[3] = {"获得","[%s]"},			-- 获得指定道具
	[4] = {"玩家等级达到", "%s级"},				-- 达到指定等级(进度:0/1)
	[5] = {"收集","[%s]"},			-- 获得指定英雄
	[6] = {},					-- 倒计时时间
	[7] = {},					-- 立即完成					(需要配置给出)
	[8] = {"与","[%s]","交谈"},		-- 与NPC对话
	[9] = {"当前进度"},				-- 跑环进度(进度:0/1)
	[10] = {},						-- 跑到指定位置点		(需要配置给出)
	[11] = {},--{"通过","关卡[%s]"}		-- 通关关卡
	[12] = {"收集","%s"},			-- 获得指定编号英雄
	[13] = {"完成","每日任务"},			-- 完成每日任务
};



function MMOTaskInfo:Init( data )
    self.task_id = 0			-- 任务id
    self.loop_mask = 0			-- 任务掩码值（0-一般任务，1-环主任务，2-环子任务）
    self.loop_id = 0			-- 关联的环任务id（loop_mask=1为子任务id，loop_mask=2为主任务id）
    self.task_type = 0			-- 任务大类型
    self.task_state = -1		-- 任务状态（-1未接，0已接，1完成，2失败）
    self.task_accept_time = 0	-- 接任务时间戳（显示倒计时）
    self.task_finish_time = 0	-- 任务结束时间戳（倒计时任务）
    self.expire_bein = 0		-- 时效起始时间（显示任务时效开始时间）
    self.expire_end = 0			-- 时效结束时间（显示任务时效结束时间）
    -- self.condition_relation = 1	-- 任务完成条件关联（0-or 1-and）
    self.condition_list = {}	-- 任务完成条件列表{condition_type=, complete_value=, condition_value=}

    if data then
    	self:UpdateData(data)
    end
end

-- 获取关联的环任务id（外部调用loop_id必须使用该接口来获取使用）
--   说明：某些情况下更新任务的顺序为：环主任务->环子任务，
--   获取环主任务的关联子任务loop_id可能不对，这时主动查询一次最新关联id（可能为0）
function MMOTaskInfo:GetLoopRelatedId()
	local loop_id = self.loop_id;
	if self.loop_mask == 1 then
		-- 试图查找最新的关联子任务id
		for sub_id, main_id in pairs(g_dataCenter.task.sub_task_list) do
			if main_id == self.task_id then
				loop_id = sub_id;
				break;
			end
		end
	end
	return loop_id;
end

function MMOTaskInfo:UpdateLoopMask()
	local config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id)
	self.task_type = config.task_type

	local loop_id = 0
	-- 跑环任务（检查是否为跑环主任务）
	local is_main_task = false
	local is_sub_task = false
	if self.task_type == 4 then
		is_main_task = true
		for k, v in pairs(config.accept_condition) do
			if v.type == _EAcceptCondition.eAcceptCondition_Ring then
				is_main_task = false
				is_sub_task = true

				self.loop_id = v.param1
				break;
			end
		end
		-- 试图查找子任务
		if is_main_task then
			self.loop_id = self:GetLoopRelatedId()
		end
	end

	if is_main_task then self.loop_mask = 1 end
	if is_sub_task then self.loop_mask = 2 end
end

function MMOTaskInfo:GetLoopRelatedTask()
	return g_dataCenter.task:GetTaskById(self:GetLoopRelatedId())
end

-- 是否为跑环主任务
function MMOTaskInfo:IsLoopMainTask()
	return self.loop_mask == 1;
end

-- 是否为跑环子任务
function MMOTaskInfo:IsLoopSubTask()
	return self.loop_mask == 2;
end

-- 是否为关卡任务
function MMOTaskInfo:IsHurdleTask()
	local result = false
	local hurdle_id = 0

	for k, v in pairs(self.condition_list) do
		if _ECompleteCondition.eCompleteCondition_PassHurdle == v.condition_type then
			result = true
			if v.condition_value > v.complete_value then
				local condition_config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id).complete_condition[k]
				hurdle_id = condition_config.param1 or 0
				break;
			end
		end
	end

	return result, hurdle_id;
end

function MMOTaskInfo:UpdateData( data )
	if data.task_id then
		self.task_id = data.task_id

		-- -- 更新完成任务条件关联逻辑
		-- local config = ConfigManager.Get(EConfigIndex.t_task_data,data.task_id)
		-- if config then
		-- 	self.condition_relation = config.complete_condition_relation
		-- end
	end

	if data.task_state then
		self.task_state = data.task_state
	end

	if data.acceptTime then
		self.task_accept_time = tonumber(data.acceptTime) or 0
	end

	if data.condition_list then
		self.condition_list = data.condition_list


		-- 检查完成条件
		if self.task_state == 0 then
			if self:GetNextCondition() == nil then
				self.task_state = 1
			end
		end

		-- 检查倒计时条件
		if self.task_finish_time == 0 then
			for k, v in pairs(data.condition_list) do
				-- 检查倒计时
				if _ECompleteCondition.eCompleteCondition_OnTime == v.condition_type then
					self.task_finish_time = self.task_accept_time + v.condition_value
				end
			end
		end

		-- TODO: 提取有效时间段

	end

	self:UpdateLoopMask()

end

function MMOTaskInfo:IsCountdownTask()
	return self.task_finish_time > self.task_accept_time
end

function MMOTaskInfo:GetCountdownTimeStr()
	if self.task_finish_time == 0 then return "" end
	local secs = PublicFunc.GetDurationByEndTime(self.task_finish_time)
	return TimeAnalysis.analysisSec_2(secs)
end

--[[ 返回单条完成条件结果
参数：（参数二选一）
	index : 完成条件索引
	data : 完成条件数据
返回：
	完成情况
--]] 
function MMOTaskInfo:GetConditionResult(index, data)
	local result = true
	data = data or self.condition_list[index]
	-- 0杀敌指定怪物
	if _ECompleteCondition.eCompleteCondition_KillMonster == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 1杀死指定英雄
	elseif _ECompleteCondition.eCompleteCondition_KillPlayer == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 2完成指定特殊事件
	elseif _ECompleteCondition.eCompleteCondition_SpecialEvent == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 3获得指定道具
	elseif _ECompleteCondition.eCompleteCondition_GetItem == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 4达到指定玩家等级
	elseif _ECompleteCondition.eCompleteCondition_Level == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 5获得指定条件英雄
	elseif _ECompleteCondition.eCompleteCondition_GetHero == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 6倒计时时间
	elseif _ECompleteCondition.eCompleteCondition_OnTime == data.condition_type then
	
	-- 7立即完成
	elseif _ECompleteCondition.eCompleteCondition_Immediately == data.condition_type then

	-- 8与NPC对话
	elseif _ECompleteCondition.eCompleteCondition_TalkNpc == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 9跑环次数
	elseif _ECompleteCondition.eCompleteCondition_Ring == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 10跑到指定位置点
	elseif _ECompleteCondition.eCompleteCondition_ToPosition == data.condition_type then
		if data.complete_value < 1 then
			result = false;
		end
	-- 11通关关卡
	elseif _ECompleteCondition.eCompleteCondition_PassHurdle == data.condition_type then
		if data.complete_value < 1 then
			result = false;
		end
	-- 12获得指定英雄
	elseif _ECompleteCondition.eCompleteCondition_GetSpeHero == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	-- 13完成每日任务
	elseif _ECompleteCondition.eCompleteCondition_DoneDaily == data.condition_type then
		if data.condition_value > data.complete_value then
			result = false;
		end
	end

	return result;
end

-- 获取下一个未完成条件
function MMOTaskInfo:GetNextCondition()
	local task = self
	if self:IsLoopMainTask() then
		local loop_sub_task = self:GetLoopRelatedTask()
		if loop_sub_task then
			task = loop_sub_task
		end
	end

	for i, v in ipairs(task.condition_list) do
		if not task:GetConditionResult(nil, v) then
			return v, i;
		end
	end
end

-- 获取下一个未完成条件字符串内容
function MMOTaskInfo:GetNextConditionStr()
	if self:IsLoopMainTask() then
		local condition, index = nil, nil;
		local loop_sub_task = self:GetLoopRelatedTask()
		if loop_sub_task then
			condition, index = loop_sub_task:GetNextCondition()
		end
		if condition and index then
			return loop_sub_task:GetConditionStrByIndex(index, nil, false);
		else
			return self:GetLastConditionStr()
		end
	else
		local condition, index = self:GetNextCondition()
		if condition and index then
			return self:GetConditionStrByIndex(index, nil, false);
		else
			return ""
		end
	end
end

-- 获取最后一个完成条件字符串内容
function MMOTaskInfo:GetLastConditionStr()
	if self:IsLoopMainTask() then
		local index = 0
		local loop_sub_task = self:GetLoopRelatedTask()
		if loop_sub_task then
			index = #loop_sub_task.condition_list or 0
		end
		if index > 0 then
			return loop_sub_task:GetConditionStrByIndex(index, nil, true);
		else
			return ""
		end
	else
		local index = #self.condition_list or 0
		if index > 0 then
			return self:GetConditionStrByIndex(index, nil, true);
		else
			return ""
		end
	end
end

local _GetProgressStr = function (value1, value2)
	local progress_str = "(%s/%s)"
	return string.format(progress_str, value1, value2)
end

--[[ 返回任务完成条件字符串
参数：
	index : 完成条件索引
	config : 当前任务配置（可选参数）
--]] 
function MMOTaskInfo:GetConditionStrByIndex(index, config, isComplete)
	local color_gold_begin = "[FF9800]"
	local color_green_begin = "[00FF00]"
	local color_end = "[-]"
	local color_begin = isComplete and color_green_begin or color_gold_begin;

	local con = self.condition_list[index]
	local condition_config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id).complete_condition[index]
	if condition_config == nil then return "" end
	local str_array = nil
	-- 优先取配置中文本资源
	if condition_config.text1 then
		str_array = {}
		if condition_config.text1 then
			table.insert(str_array, condition_config.text1)
		end
		if condition_config.text2 then
			table.insert(str_array, condition_config.text2)
		end
		if condition_config.text3 then
			table.insert(str_array, condition_config.text3)
		end
	else
		str_array = _ECompleteConditionString[con.condition_type] or {}
	end
	
	if #str_array > 1 then
		table.insert(str_array, 3, color_end)
		table.insert(str_array, 2, color_begin)
	end
	local str = table.concat(str_array)

	if condition_config then
		-- 0杀敌指定怪物
		if _ECompleteCondition.eCompleteCondition_KillMonster == con.condition_type then
			if condition_config.param1 then
				local monster_config = ConfigManager.Get(EConfigIndex.t_monster_property,condition_config.param1)
				local monster_name = monster_config.name
				str = string.format(str, monster_name) .. _GetProgressStr(con.complete_value, con.condition_value)
			end
		-- 1杀死指定英雄
		elseif _ECompleteCondition.eCompleteCondition_KillPlayer == con.condition_type then
			-- 职业与名字条件互斥
			local content = {}
			-- 职业 1肉盾 2战士 3能量 4辅助
			if condition_config.param1 then
				table.insert(content, gs_string_job[condition_config.param1] or "")
				-- 数量
				if condition_config.param2 and condition_config.param2 > 0 then
					table.insert(content, condition_config.param2.."个")
				end
			-- 英雄名字
			elseif condition_config.param3 then
				local role_config = ConfigHelper.GetRole(condition_config.param3)
				local role_name = role_config.name
				table.insert(content, role_name)
				-- 数量
				if condition_config.param2 and condition_config.param2 > 0 then
					table.insert(content, condition_config.param2.."个")
				end
			-- 数量
			elseif condition_config.param2 then
				table.insert(content, condition_config.param2.."个")
			end
			str = string.format(str, table.concat(content))

		-- 2完成指定特殊事件
		elseif _ECompleteCondition.eCompleteCondition_SpecialEvent == con.condition_type then
			local event_config = ConfigManager.Get(EConfigIndex.t_task_event,condition_config.param1)
			-- 显示读条次数进度
			if event_config.event_type == 0 then
				str = str .. _GetProgressStr(con.complete_value, con.condition_value)
			end
			
		-- 3获得指定道具
		elseif _ECompleteCondition.eCompleteCondition_GetItem == con.condition_type then
			if condition_config.param1 then
				local item_config = ConfigManager.Get(EConfigIndex.t_item,condition_config.param1)
				local item_name = item_config.name
				str = string.format(str, item_name) .. _GetProgressStr(con.complete_value, con.condition_value)
			end
		-- 4达到指定玩家等级
		elseif _ECompleteCondition.eCompleteCondition_Level == con.condition_type then
			if condition_config.value then
				-- 服务器记录的complete_value是玩家当前等级
				str = string.format(str, con.condition_value);
				-- str = str.. _GetProgressStr(con.complete_value, con.condition_value)
			end
		-- 5获得指定条件英雄
		elseif _ECompleteCondition.eCompleteCondition_GetHero == con.condition_type then
			local content = {}
			-- 星级
			if condition_config.param1 and condition_config.param1 > 1 then
				table.insert(content, tostring(condition_config.param1).."星")
			end
			-- 等级
			if condition_config.param2 and condition_config.param2 > 1 then
				table.insert(content, tostring(condition_config.param2).."级")
			end
			-- 职业 1肉盾 2战士 3能量 4辅助
			if condition_config.param3 then 
				table.insert(content, gs_string_job[condition_config.param3] or "")
			end
			if condition_config.value and condition_config.value > 1 then
				table.insert(content, tostring(condition_config.value).."个")
			end
			str = string.format(str, table.concat(content))
		-- 6倒计时时间
		elseif _ECompleteCondition.eCompleteCondition_OnTime == con.condition_type then
			
		-- 7立即完成
		elseif _ECompleteCondition.eCompleteCondition_Immediately == con.condition_type then
			
		-- 8与NPC对话
		elseif _ECompleteCondition.eCompleteCondition_TalkNpc == con.condition_type then
			if condition_config.param1 then
				local npc_config = ConfigManager.Get(EConfigIndex.t_npc_data,tonumber(condition_config.param1))
				str = string.format(str, npc_config.npc_name)
			end
		-- 9跑环次数
		elseif _ECompleteCondition.eCompleteCondition_Ring == con.condition_type then
			str = str .. _GetProgressStr(con.complete_value, con.condition_value)
		-- 10跑到指定位置点
		elseif _ECompleteCondition.eCompleteCondition_ToPosition == con.condition_type then
			
		-- 11通关关卡
		elseif _ECompleteCondition.eCompleteCondition_PassHurdle == con.condition_type then
			-- if condition_config.param1 and condition_config.param2 then
			-- 	local hurdle_config = ConfigHelper.GetHurdleConfig(condition_config.param1) or {}
			-- 	str = string.format(str, hurdle_config.index or "")
			-- end
		-- 12获得指定英雄
		elseif _ECompleteCondition.eCompleteCondition_GetSpeHero == con.condition_type then
			if condition_config.param1 then
				local content = {}
				if condition_config.param2 and condition_config.param2 > 1 then
					table.insert(content, tostring(condition_config.param2).."星")
				end
				if condition_config.param3 and condition_config.param3 > 1 then
					table.insert(content, tostring(condition_config.param2).."级")
				end

				local role_config = ConfigHelper.GetRole(config.param1)
				local role_name = role_config.name
				table.insert(content, role_name)
				if condition_config.value and condition_config.value > 1 then
					table.insert(content, tostring(condition_config.param2).."个")
				end
				
				str = string.format(str, table.concat(content,""))
			end
		-- 13完成每日任务
		elseif _ECompleteCondition.eCompleteCondition_DoneDaily == con.condition_type then
			-- 已完成的任务次数
			str = str .. _GetProgressStr(con.complete_value, con.condition_value)
		end
	end
	return str;
end

-- 返回任务完成条件字符串数组
function MMOTaskInfo:GetConditionStrArray()
	local result = {}

	if self:IsLoopMainTask() then
		local loop_sub_task = self:GetLoopRelatedTask()
		if loop_sub_task then
			local config = ConfigManager.Get(EConfigIndex.t_task_data,loop_sub_task.task_id);
			for i, v in pairs(loop_sub_task.condition_list) do
				local isComplete = loop_sub_task:GetConditionResult(i, v)
				local content = loop_sub_task:GetConditionStrByIndex(i, config, isComplete)
				if content ~= "" then
					table.insert(result, content);
				end
			end
			-- 直接完成的任务条件，没有内容，默认任务名字
			if #result == 0 then
				table.insert(result, config.task_name);
			end
		end
	else
		local config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id);
		for i, v in pairs(self.condition_list) do
			local isComplete = self:GetConditionResult(i, v)
			local content = self:GetConditionStrByIndex(i, config, isComplete)
			if content ~= "" then
				table.insert(result, content);
			end
		end
		-- 直接完成的任务条件，没有内容，默认任务名字
		if #result == 0 then
			table.insert(result, config.task_name);
		end
	end

	return result;
end

--[[ 获取循环任务完成条件字符串
参数：
	isShortValue:	是否为缩写格式
--]] 
function MMOTaskInfo:GetLoopMainValueStr(isShortValue)
	if not self:IsLoopMainTask() then return "" end

	local condition = self.condition_list[1]
	-- 跑环任务总进度显示接取任务进度
	local accept_value = math.min(condition.complete_value + 1, condition.condition_value)
	return _GetProgressStr(accept_value, condition.condition_value)
end

--[[ 返回未完成接受条件
参数：
	config : 任务的一个接受条件配置（可选参数）
--]] 
function MMOTaskInfo:GetUnsatisfiedAcceptByData(config)
	local str = ""
	if config then
		-- 0满足指定等级可接任务
		if _EAcceptCondition.eAcceptCondition_Level == config.type then
			if config.param1 and config.param1 > g_dataCenter.player.level then
				str = _EAcceptConditionString[config.type]
				str = string.format(str, config.param1)
			end
		-- 1携带指定英雄可接任务
		elseif _EAcceptCondition.eAcceptCondition_HeroInTeam == config.type then
			-- 编号
			if config.param1 then
				local flag = true
				local team = g_dataCenter.player:GetDefTeam()
				local card = nil
				for i, id in pairs(team) do
					card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, id);
					if card.number == config.param1 or card.default_rarity == config.param1 then
						break;
					else
						card = nil
					end
				end
				if card == nil then
					flag = false;
				end
				if flag == true and config.param2 and config.param2 > card.rarity then
					flag = false;
				end
				if flag == true and config.param3 and config.param3 > card.level then
					flag = false;
				end
				if flag == false then
					local content = {}
					-- 星级
					if config.param2 and config.param2 > 1 then
						table.insert(content, tostring(config.param2).."星")
					end
					-- 等级
					if config.param3 and config.param3 > 1 then
						table.insert(content, tostring(config.param3).."级")
					end
					local role_config = ConfigHelper.GetRole(config.param1)
					local role_name = role_config.name
					table.insert(content, role_name)

					str = _EAcceptConditionString[config.type]
					str = string.format(str, table.concat(content))
				end
			end
			

		-- 2处于公会中
		elseif _EAcceptCondition.eAcceptCondition_InGuild == config.type then
			
		-- 3拥有指定物品
		elseif _EAcceptCondition.eAcceptCondition_HaveItem == config.type then
			if config.param1 and config.param2 then
				local num = 0
				local name = ""
				-- 如果是装备
				if PropsEnum.IsEquip(config.param1) then
					num = g_dataCenter.package:find_count(ENUM.EPackageType.Equipment, config.param1)
					name = ConfigManager.Get(EConfigIndex.t_equipment,config.param1).name
				-- 道具
				elseif PropsEnum.IsItem(config.param1) then
					num = g_dataCenter.package:find_count(ENUM.EPackageType.Item, config.param1)
					name = ConfigManager.Get(EConfigIndex.t_item,config.param1).name
				-- 杂项
				elseif PropsEnum.IsVaria(config.param1) then
					num = g_dataCenter.package:find_count(ENUM.EPackageType.Other, config.param1)
					name = ConfigManager.Get(EConfigIndex.t_item,config.param1).name
				end
				if config.param2 > num then
					table.insert(content, name)
					table.insert(content, tostring(config.param2).."个")

					str = _EAcceptConditionString[config.type]
					str = string.format(str, table.concat(content))
				end
			end
		-- 4指定国家
		elseif _EAcceptCondition.eAcceptCondition_Country == config.type then
			
		-- 5携带一定数量指定条件英雄
		elseif _EAcceptCondition.eAcceptCondition_Heros == config.type then
			if config.param3 then
				local team = g_dataCenter.player:GetDefTeam()
				local star_ok_num = 0
				local lv_ok_num = 0
				for i, id in pairs(team) do
					local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, id);
					if config.param1 and card.rarity >= config.param1 then
						star_ok_num = star_ok_num + 1
					end
					if config.param2 and card.level >= config.param2 then
						lv_ok_num = lv_ok_num + 1
					end
				end
				
				local flag = true
				if flag == true and config.param1 and config.param3 > star_ok_num then
					flag = false
				end
				if flag == true and config.param2 and config.param3 > lv_ok_num then
					flag = false
				end

				if flag == false then
					local content = {}
					-- 星级
					if config.param1 and config.param1 > 1 then
						table.insert(content, tostring(config.param1).."星")
					end
					-- 等级
					if config.param2 and config.param2 > 1 then
						table.insert(content, tostring(config.param2).."级")
					end
					-- 数量
					if config.param3 and config.param3 > 1 then 
						table.insert(content, tostring(config.param3).."个")
					end

					str = _EAcceptConditionString[config.type]
					str = string.format(str, table.concat(content))
				end
			end
		-- 6接受的跑环任务id
		elseif _EAcceptCondition.eAcceptCondition_Ring == config.type then

		end
	end
	return str;
end

-- 是否满足了接受条件
function MMOTaskInfo:CanAcceptTask()
	local result = true;
	local config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id);

	if self.task_state == -1 then
		for i, v in pairs(config.accept_condition) do
			local str = self:GetUnsatisfiedAcceptByData(v)
			if str ~= "" then
				result = false;
				break;
			end
		end
	end
	return result;
end

--[[ 获取接任务描述（包含了未完成条件）
说明：
	若任务接受条件不满足，返回任务描述+未满足条件
	若任务接受条件满足，返回任务描述
--]]
function MMOTaskInfo:GetAcceptTaskDes()
	local config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id);

	local content = {}
	table.insert(content, config.task_des)
	if self.task_state == -1 then
		for i, v in pairs(config.accept_condition) do
			local str = self:GetUnsatisfiedAcceptByData(v)
			if str ~= "" then
				table.insert(content, str);
			end
		end
	end

	if #content > 1 then
		return table.concat(content, "\n");
	else
		return table.concat(content);
	end
end


function MMOTaskInfo.GetCompleteConditionByIndex(task_id, index)
	local config = ConfigManager.Get(EConfigIndex.t_task_data,task_id).complete_condition[index]
	return config.complete_condition[index]
end

--触发行为
function MMOTaskInfo:TriggerAction()
	-- 未接
    if self.task_state == -1 then
        local config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id)
        if config.accept_npc_id > 0 then
            g_dataCenter.autoPathFinding:SetNpcFinding(config.accept_npc_id);
        else
            MMOTaskDialogUI.ShowUi(self.task_id);
        end
    -- 未完成
    elseif self.task_state == 0 then
    	-- 自动寻路
    	if self:IsLoopMainTask() then
    		local loop_sub_task = self:GetLoopRelatedTask()
    		if loop_sub_task then
	    		-- 未接
			    if loop_sub_task.task_state == -1 then
			        local config = ConfigManager.Get(EConfigIndex.t_task_data,loop_sub_task.task_id)
			        if config.accept_npc_id > 0 then
			            g_dataCenter.autoPathFinding:SetNpcFinding(config.accept_npc_id);
			        else
			            MMOTaskDialogUI.ShowUi(loop_sub_task.task_id);
			        end
			    -- 未完成
			    elseif loop_sub_task.task_state == 0 then
			    	-- 自动寻路
				    loop_sub_task:MoveToConditionAim();
			    -- 已完成
			    elseif loop_sub_task.task_state == 1 then
			        local config = ConfigManager.Get(EConfigIndex.t_task_data,loop_sub_task.task_id)
			        if config.complete_npc_id > 0 then
			            g_dataCenter.autoPathFinding:SetNpcFinding(config.complete_npc_id);
			        else
			            MMOTaskDialogUI.ShowUi(loop_sub_task.task_id);
			        end
			    -- 失败
			    elseif loop_sub_task.task_state == 2 then
			    	world_msg.cg_giveup_task(loop_sub_task.task_id)
			    end
    		end
    	else
	        self:MoveToConditionAim();
	    end
    -- 已完成
    elseif self.task_state == 1 then
        local config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id)
        if config.complete_npc_id > 0 then
            g_dataCenter.autoPathFinding:SetNpcFinding(config.complete_npc_id);
        else
            MMOTaskDialogUI.ShowUi(self.task_id);
        end
    -- 失败
    elseif self.task_state == 2 then
    	-- MMOTaskDialogUI.ShowUi(self.task_id);
    	world_msg.cg_giveup_task(self.task_id)
    end
end

--自动条件寻路检查
function MMOTaskInfo:MoveToConditionAim()
	app.log("任务自动寻路检查: "..self.task_id)
	local condition, index = self:GetNextCondition();
	local task_config = ConfigManager.Get(EConfigIndex.t_task_data,self.task_id)
	local condition_config = task_config.complete_condition[index];
	-- 0杀敌指定怪物
	if _ECompleteCondition.eCompleteCondition_KillMonster == condition_config.type then
		app.log("开始自动杀怪寻路 ")
		if condition_config.task_pos then
			g_dataCenter.autoPathFinding:SetTaskDesFinding(condition_config.task_pos, "kill_monster");
		end
		-- TODO
	-- 1杀死指定英雄
	elseif _ECompleteCondition.eCompleteCondition_KillPlayer == condition_config.type then
		app.log("开始击杀指定英雄寻路 ")
		if condition_config.task_pos then
			g_dataCenter.autoPathFinding:SetTaskDesFinding(condition_config.task_pos, "kill_hero");
		end
	-- 2完成指定特殊事件
	elseif _ECompleteCondition.eCompleteCondition_SpecialEvent == condition_config.type then
		app.log("开始特殊事件寻路 ")
		local event_config = ConfigManager.Get(EConfigIndex.t_task_event,condition_config.param1)
		if event_config.event_type == 0 or event_config.event_type == 1 then
			g_dataCenter.autoPathFinding:SetNpcFinding(event_config.event_npc);
		end
		-- if condition_config.task_pos then
		-- 	g_dataCenter.autoPathFinding:SetTaskDesFinding(condition_config.task_pos, "");
		-- end
	-- 3获得指定道具
	elseif _ECompleteCondition.eCompleteCondition_GetItem == condition_config.type then
		app.log("开始道具寻路 ")
		if condition_config.task_pos then
			g_dataCenter.autoPathFinding:SetTaskDesFinding(condition_config.task_pos, "");
		end
	-- 4达到指定玩家等级
	elseif _ECompleteCondition.eCompleteCondition_Level == condition_config.type then
		
	-- 5获得指定条件英雄
	elseif _ECompleteCondition.eCompleteCondition_GetHero == condition_config.type then
		app.log("开始获取指定英雄寻路 ")
		if condition_config.task_pos then
			g_dataCenter.autoPathFinding:SetTaskDesFinding(condition_config.task_pos, "get_hero");
		end
	-- 6倒计时时间
	elseif _ECompleteCondition.eCompleteCondition_OnTime == condition_config.type then
		
	-- 7立即完成
	elseif _ECompleteCondition.eCompleteCondition_Immediately == condition_config.type then
		
	-- 8与NPC对话
	elseif _ECompleteCondition.eCompleteCondition_TalkNpc == condition_config.type then
		app.log("开始自动寻路NPC ")
		if condition_config.param1 then
            g_dataCenter.autoPathFinding:SetNpcFinding(condition_config.param1);
		end
	-- 9跑环次数
	elseif _ECompleteCondition.eCompleteCondition_Ring == condition_config.type then
		
	-- 10跑到指定位置点
	elseif _ECompleteCondition.eCompleteCondition_ToPosition == condition_config.type then
		app.log("开始自动寻路目标点：未完成 ")
		if condition_config.task_pos then
            g_dataCenter.autoPathFinding:SetTaskDesFinding(condition_config.task_pos, "special_des");
		end
	-- 11通关关卡
	elseif _ECompleteCondition.eCompleteCondition_PassHurdle == condition_config.type then
		-- 打开关卡界面
		if uiManager then
			uiManager:RemoveUi(EUI.UiLevelChallenge);
			local uiLevel = uiManager:FindUI(EUI.UiLevel)
			if uiLevel == nil or uiLevel.ui == nil then
				uiManager:PushUi(EUI.UiLevel, {taskId=self.task_id, goLevel=condition_config.param1});
			end
		end
	-- 12获得指定英雄
	elseif _ECompleteCondition.eCompleteCondition_GetSpeHero == condition_config.type then
		if condition_config.task_pos then
			g_dataCenter.autoPathFinding:SetTaskDesFinding(condition_config.task_pos, "get_hero");
		end
	-- 13完成每日任务
	elseif _ECompleteCondition.eCompleteCondition_DoneDaily == condition_config.type then
		-- 打开每日任务界面
		if uiManager then
			uiManager:PushUi(EUI.UiDailyTask);
		end
	end
end
