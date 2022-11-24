--region guide_manager.lua (备注：新手引导管理器放到了ui目录，方便管理)
--author : zzc
--date   : 2015/11/26

--新手引导管理器
GuideManager = {
	recordSet = {},				-- 完成的引导集合
	checkNextSet = {},			-- 关联后置引导集合（移除）
	guideSet = {},				-- 引导集合
	groupSet = {},				-- 分组集合
	guideHurdleId = 0,			-- 设置引导的关卡id
	guideFunctionId = 0,		-- 设置引导的功能id
	currentGuideId = 0,			-- 当前引导id
	currentStepsData = nil,		-- 当前生效的引导序列数据
	currentStepIndex = 0,		-- 当前引导序列索引
	need_server_confirm = nil,	-- 需要服务器协议确认
	passKeyPoint = false,		-- 记录是否通过了关键点

	playPreOpenMark = {},		-- 玩法功能预告等级

	playerLevelGuideId = nil,	-- 记录待引导的等级触发引导id
	playerLevelFunctionId = nil,-- 记录待引导的等级触发功能id（接功能开启界面）

	totalCount = 0,				-- 引导配置表总个数
	registNotice = false,		-- 是否注册了本地消息
	-- openHook = false,			-- 允许替换接口（完成条件采用配置服务器协议消息名）
	isLoadedRecord = false,			-- 是否已经load record
	isReady = false,			-- 是否初始化
} 

-- 引导触发类型定义
GuideManager.GuideType = {
	SceneLoad = 1,		-- 场景加载完成
	PlotEnd = 2,		-- 剧情结束
	PrevCall = 3,		-- 承接引导调用
	OpenUI = 4,			-- 打开某个UI
	PlayerLevel = 5,	-- 战队等级（可以带功能预告id）
	HurdlePassed = 6,	-- 通关关卡
	OpenFunctionUI = 7,		-- 功能开启界面
	SpecailFunction = 8,	-- 功能有单独开启条件	
	-- 后续根据需求可添加其他触发类型


	Amount	= 8			-- 总数
}

-- 引导序列命令(与配置保持一致)
GuideManager.GuideCmd = {
	wait_end 		= "wait_end",	-- 该参数仅用于说明
	ui_click 		= "ui_click",
	open_left_list 	= "open_left_list",
	open_right_list = "open_right_list",
	close_left_list = "close_left_list",
	close_right_list = "close_right_list",
	['goto'] 		= "goto",
	clear_ui_stack 	= "clear_ui_stack",
	push_ui			= "push_ui",
	move_camera 	= "move_camera",
}

GuideManager.EventTag = {
	firstDressEquip 	= 83100000,		--装备穿戴
	firstUseExpItem 	= 83100001,		--吃经验药水
	firstSkillUpgrade 	= 83100002,		--技能升级
	firstHeroStarUp 	= 83100003,		--英雄升星
	firstEquipLevelUp 	= 83100004,		--装备升级
	firstEquipStarUp 	= 83100005,		--装备升星
	firstEquipStepUp 	= 83100006,		--装备进阶
	firstNiudanHero 	= 83100007,		--扭蛋英雄
	firstNiudanEquip 	= 83100008,		--扭蛋装备
	freeReliveResetDay 	= 83100009,		--免费复活的重置时间
	immediatelyReliveTimes 	= 83100010,		--已经立即复活的次数
	selectCountry		= 83100011,		--选区
	firstBattle 		= 83100012, 	--第一次上阵
	secendBattle		= 83100013,		--第二次上阵
	openMysticalShop	= 83100014,		--是否开启神秘商店
	firstArenaFight		= 83100015,		--是否完成过竞技场战斗

	firstTaskReward		= 83100016,		--领取过每日任务
	firstGSMethodFight	= 83100017,		--打过高速阻击战
	firstBWMethodFight	= 83100018,		--打过保卫战
	firstJXMethodFight	= 83100019,		--打过极限挑战
	firstYZMethodFight	= 83100020,		--打过远征试炼
	firstQYMethodFight	= 83100021,		--打过区域占领
	firstXCMethodFight	= 83100022,		--打过小丑计划
	firstTalentTrain	= 83100023,		--天赋升级过1次
	firstInstitTrain	= 83100024,		--研究所培养过1次
}

GuideManager.CheckTrigger = {
	[GuideManager.GuideType.SceneLoad]		= function ( ... ) return GuideManager.CheckSceneLoad( ... ) end,
	[GuideManager.GuideType.PlotEnd]		= function ( ... ) return GuideManager.CheckPlotEnd( ... ) end,
	[GuideManager.GuideType.PrevCall]		= function ( ... ) return GuideManager.CheckPrevCall( ... ) end,
	[GuideManager.GuideType.OpenUI]			= function ( ... ) return GuideManager.CheckOpenUI( ... ) end,
	[GuideManager.GuideType.PlayerLevel]	= function ( ... ) return GuideManager.CheckPlayerLevel( ... ) end,
	[GuideManager.GuideType.HurdlePassed]	= function ( ... ) return GuideManager.CheckHurdlePassed( ... ) end,
	[GuideManager.GuideType.OpenFunctionUI] = function ( ... ) return GuideManager.CheckOpenFunctionUI( ... ) end,
	[GuideManager.GuideType.SpecailFunction] = function ( ... ) return GuideManager.CheckSpecailFunction( ... ) end,
}

-- GuideManager.NetReceiveHookList = {
-- 	"player.gc_select_country",				--选区结果
-- 	"msg_cards.gc_hero_star_up",			--角色升星
-- 	"msg_activity.gc_niudan_use",			--扭蛋招募
-- 	"msg_activity.gc_raids",				--关卡扫荡
-- 	"msg_activity.gc_look_for_rival",		--查找区域对手
-- }

local _outLogFile = false
OutGuideLog = function(content, is_error)
	if is_error then
		app.log(content)
	else
		app.log(content)
	end

	if _outLogFile then
		LocalFile.InsertGuideLog(content)
	end
end

LocalFile.RemoveGuideLog()

-------------------------------------local声明-------------------------------------
-- 内部可以用this指向，简化代码
local this = GuideManager

-------------------------------------函数声明-------------------------------------
-- 配置数据初始化
function GuideManager.InitData()
	-- 功能开关
	if AppConfig.enable_guide == false then return end

	this.InitPlayPreOpenMark()

	this.isReady = true

	-- 初始化引导配置表
	for i, v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_guide)) do
		if v.enable == 1 then
			this.guideSet[i] = v
			this.totalCount = this.totalCount + 1

			if v.check_next_id and v.check_next_id > 0 then
				this.checkNextSet[v.check_next_id] = i
			end
		end
	end

	-- 配置检查
	for id, v in pairs(this.guideSet) do
		if v.type == this.GuideType.OpenUI and v.param == "MMOMainUI" then
			OutGuideLog("### 配置参数错误："..id..debug.traceback(), true)
		end
	end

	-- 关联引导配置表
	

	-- 初始化ui映射表
	if next(this.guideSet) then
		this.registNotice = true
	end

	this.SetNoticeListen(this.registNotice)

	-- if this.openHook then
	-- 	this.CreateNetReceiveHook()
	-- end
end

function GuideManager.InitPlayPreOpenMark()
	local cfg_play_vs_data = ConfigManager._GetConfigTable(EConfigIndex.t_play_vs_data);
	for k, v in pairs(cfg_play_vs_data) do
		if v.notice_level ~= 0 then
			this.playPreOpenMark[v.open_level or 0] = true
		end
	end
end

function GuideManager.SetNoticeListen(bool)
	local _ListenFunction = bool and NoticeManager.BeginListen or NoticeManager.EndListen

	-- _ListenFunction(ENUM.NoticeType.FightOverBegin, this.OnFightOverBegin)
	_ListenFunction(ENUM.NoticeType.FightStartBegin, this.OnFightStartBegin)
	_ListenFunction(ENUM.NoticeType.FightUiLoadComplete, this.OnFightUiLoadComplete)
	_ListenFunction(ENUM.NoticeType.SceneChangeEnter, this.OnSceneChangeEnter)
	-- _ListenFunction(ENUM.NoticeType.ChangeAutoFightMode, this.OnChangeAutoFightMode)
	_ListenFunction(ENUM.NoticeType.ChangeAreaSuccess, this.OnChangeAreaSuccess)
	-- _ListenFunction(ENUM.NoticeType.UpdatePlayerFlag, this.OnUpdatePlayerFlag)
	_ListenFunction(ENUM.NoticeType.NiuDanSuccess, this.OnNiuDanSuccess)
	_ListenFunction(ENUM.NoticeType.ChangeEquipSuccess, this.OnChangeEquipSuccess)
	_ListenFunction(ENUM.NoticeType.ChangeTeamSuccess, this.OnChangeTeamSuccess)
	_ListenFunction(ENUM.NoticeType.GetCommonAddExpBack, this.OnGetCommonAddExpBack)
	_ListenFunction(ENUM.NoticeType.GetCommonAwardBack, this.OnGetCommonAwardBack)
	_ListenFunction(ENUM.NoticeType.GetCommonHurdleBack, this.OnGetCommonHurdleBack)
	_ListenFunction(ENUM.NoticeType.GetHeroQuaUpShowBack, this.OnGetHeroQuaUpShowBack)
	_ListenFunction(ENUM.NoticeType.GetHeroStarupShowBack, this.OnGetHeroStarupShowBack)
	_ListenFunction(ENUM.NoticeType.GetHurdleRaidsShowBack, this.OnGetHurdleRaidsShowBack)
	_ListenFunction(ENUM.NoticeType.GetFloatTipsShowBack, this.OnGetFloatTipsShowBack)
	_ListenFunction(ENUM.NoticeType.GetBattleShowBack, this.OnGetBattleShowBack)
	_ListenFunction(ENUM.NoticeType.GetNewHeroShowBack, this.OnGetNewHeroShowBack)
	_ListenFunction(ENUM.NoticeType.GetContactActiveShowBack, this.OnGetContactActiveShowBack)
	_ListenFunction(ENUM.NoticeType.ScreenPlayOver, this.OnScreenPlayOver)
	_ListenFunction(ENUM.NoticeType.ScreenPlayBegin, this.OnScreenPlayBegin)
	_ListenFunction(ENUM.NoticeType.PushUi, this.OnPushUi)
	_ListenFunction(ENUM.NoticeType.PopUi, this.OnPopUi)
	_ListenFunction(ENUM.NoticeType.UiManagerRestart, this.OnUiManagerRestart)
	_ListenFunction(ENUM.NoticeType.PlayerLevelUp, this.OnPlayerLevelUp)
	_ListenFunction(ENUM.NoticeType.AdvFuncAutoOpen, this.OnAutoOpenFunc)
	_ListenFunction(ENUM.NoticeType.AdvFuncEffectEnd, this.OnOpenFuncEffectShowEnd)
	_ListenFunction(ENUM.NoticeType.PlayerLevelupUiFinish, this.OnPlayerLevelupUiFinish)
	_ListenFunction(ENUM.NoticeType.FightStartEnd, this.OnFightStartEnd)
	_ListenFunction(ENUM.NoticeType.BackToUiDailyTask, this.OnBackToUiDailyTask)
	_ListenFunction(ENUM.NoticeType.RegionSelectRivalOK, this.OnRegionSelectRivalOK)
	_ListenFunction(ENUM.NoticeType.MainSceneBtnClick, this.OnMainSceneBtnClick)
	_ListenFunction(ENUM.NoticeType.GuidePlayGuideUiBack, this.OnGuidePlayGuideUiBack)
	_ListenFunction(ENUM.NoticeType.FarTrialChooseDiff, this.OnFarTrialChooseDiff)
	_ListenFunction(ENUM.NoticeType.FarTrialChooseRole, this.OnFarTrialChooseRole)
	_ListenFunction(ENUM.NoticeType.GuideCareMsgSend, this.OnGuideCareMsgSend)
	_ListenFunction(ENUM.NoticeType.GuideCareMsgReceive, this.OnGuideCareMsgReceive)
end

-- function GuideManager.CreateNetReceiveHook()
-- 	if not this.isReady then return end

-- 	this.hookOldFuns = {}
-- 	this.hookNewFuns = {}
-- 	-- 替换接口
-- 	for i, name in ipairs(this.NetReceiveHookList) do
-- 		local oldfunc = Utility.GetRealFunc(name)
-- 		local newfunc = function(...) GuideManager.OnNetReceiveHook(name) oldfunc(...) end

-- 		this.hookOldFuns[ name ] = oldfunc
-- 		this.hookNewFuns[ name ] = newfunc

-- 		local nameSection = Utility.lua_string_split(name, ".")
-- 		_G[ nameSection[1] ][ nameSection[2] ] = newfunc
-- 	end
-- end

-- function GuideManager.ResetNetReceiveHook()
-- 	if not this.isReady then return end

-- 	--还原接口
-- 	if this.hookOldFuns and this.hookNewFuns then
-- 		for i, name in ipairs(this.NetReceiveHookList) do
-- 			local nameSection = Utility.lua_string_split(name, ".")
-- 			_G[ nameSection[1] ][ nameSection[2] ] = this.hookOldFuns[ name ]
-- 		end

-- 		this.hookOldFuns = nil
-- 		this.hookNewFuns = nil
-- 	end
-- end

function GuideManager.Destroy()
	if not this.isReady then return end

	GuideUI.Destroy()
	
	this.isReady = false
	this.hideMode = nil
	this.guideHurdleId = 0
	this.guideFunctionId = 0
	this.currentGuideId = 0
	this.currentStepsData = nil
	this.currentStepIndex = 0
	this.need_server_confirm = nil
	
	this.isLoadedRecord = false
	this.totalCount = 0
	this.checkNextSet = {}
	this.recordSet = {}
	this.guideSet = {}

	this.playPreOpenMark = {}

	this.levelUpInFight = nil
	this._expedition_trial_fix = nil

	if this.registNotice then
		this.registNotice = false
		this.SetNoticeListen(false)
	end

	-- if this.openHook then
	-- 	this.ResetNetReceiveHook()
	-- end

	this.RemoveStuckId()
end

-- 引导记录打点消息
function GuideManager.send_guide_id_msg(id)
	local guideData = this.guideSet[id]
	-- 本地记录不通知服务器打点（巅峰展示）
	if guideData and guideData.is_local ~= 1 then
		player.cg_guide_id(id)
	end
end

-- 已直接完成
function GuideManager.DoneGuide(guideList)
	if #guideList == 0 then return end
	for i, id in ipairs(guideList) do
		OutGuideLog(" ### DoneGuide " .. id)
		this.send_guide_id_msg(id)
		this.RemoveGuide(id)
		this.recordSet[id] = true
	end
end

-- 从集合中移除一个引导
function GuideManager.RemoveGuide(guideId)
	OutGuideLog(" ### RemoveGuide " .. guideId)
	this.guideSet[guideId] = nil
	this.recordSet[guideId] = true;

	this.CheckPrevGuide(guideId)
end

-- 引导触发检查
function GuideManager.Trigger(Type, param1, param2)
	-- OutGuideLog(" ### 引导触发器 type:"..Type..", param1:"..tostring(param1)..", param2:"..tostring(param2))
	-- if not this.isLoadedRecord then OutGuideLog(" ### invalid guide trigger, does't load record ", true) return end
	if next(this.guideSet) == nil then return end
	if type(Type) ~= "number" or 
		Type < 0 or Type > this.GuideType.Amount then  OutGuideLog(" ### 无效引导类型 type:"..tostring(Type), true) return end

	local id = this.CheckTrigger[Type](param1, param2)
	if id ~= nil and id ~= 0 then
		this.BeginGuide(id);
	end
end

--前20级闯关按钮动画的常态播放
function GuideManager.CheckAdventureAnimationBefore20Level()
	if GetMainUI() and GetMainUI():GetPlayerMenu() then
		if g_dataCenter.player.level < 20 and this.IsGuideRuning() == false and this.playerLevelFunctionId == nil then
			GetMainUI():GetPlayerMenu():ShowAdventureFingerNode(true)
		else
			GetMainUI():GetPlayerMenu():ShowAdventureFingerNode(false)
		end
	end
end

--必要前置引导检查
function GuideManager.CheckPrevId(prev_id)
	prev_id = prev_id or 0
	if prev_id == 0 or (prev_id > 0 and this.recordSet[prev_id]) then
		return true
	else
		OutGuideLog(" ### 前置引导不满足 prev_id: " .. prev_id)
	end
	return false
end

-- 进游戏第一个引导检查
function GuideManager.CheckFirstGuide()
	if not AppConfig.get_enable_guide() then
		return false;
	end

	return table.get_num(this.recordSet) == 0
end

-- 场景加载完成检查
function GuideManager.CheckSceneLoad(param)
	if param == nil or param == 0 then return end
	-- 新手关卡引导
	local id = nil
	local doneRemove = {}
	for i, v in pairs(this.guideSet) do
		if v.type == GuideManager.GuideType.SceneLoad then
			if type(v.param) == "table" then
				for j, scene_id in pairs(v.param) do
					if param == scene_id then
						if this.CheckDoneParam(v.done_param) then
							table.insert(doneRemove, i);
						else
							id = i;
							break;
						end
					end
				end
			elseif v.param == param then
				if this.CheckDoneParam(v.done_param) then
					table.insert(doneRemove, i);
				else
					id = i;
					break;
				end
			end
		end
	end
	this.DoneGuide(doneRemove);

	return id;
end

-- 剧情播放完毕检查
function GuideManager.CheckPlotEnd(param)
	for i, v in pairs(this.guideSet) do
		if v.type == this.GuideType.PlotEnd and v.param == param then
			return i;
		end
	end
end

-- 承接引导检查
function GuideManager.CheckPrevCall(param)
	-- 登录游戏后恢复引导检查
	if param == nil then
		for i, v in pairs(this.guideSet) do
			if v.type == this.GuideType.PrevCall and (v.param == 0 or this.recordSet[v.param])  then
				return i;
			end
		end
	else
		for i, v in pairs(this.guideSet) do
			if v.type == this.GuideType.PrevCall and v.param == param then
				return i;
			end
		end
	end
end


-- 某个UI打开时检查
function GuideManager.CheckOpenUI(param1, param2)
	local fitUI = {}
	local doneRemove = {}
	-- 新手关卡引导
	for i, v in pairs(this.guideSet) do
		if v.type == GuideManager.GuideType.OpenUI then
			local flag = false
			if type(v.param) == "string" and v.param == param1 then
				flag = true
			elseif type(v.param) == "table" and v.param[1] == param1 and v.param[2] == param2 then
				flag = true
			end
			-- 附加条件检查
			if flag and this.CheckAddParam(v.add_param) then
				if GuideManager.CheckDoneParam(v.done_param) then
					table.insert(doneRemove, i);
				else
					fitUI[i] = v;
				end
			end
		end
	end
	-- 找到最先触发的id
	local id = nil
	local order = nil
	for i, v in pairs(fitUI) do
		if id == nil then
			id = i
			order = v.order
		elseif v.order < order then
			id = i
			order = v.order
		end
	end
	this.DoneGuide(doneRemove);

	return id
end

-- 战队等级触发（param等级，param1功能开启界面功能id）
function GuideManager.CheckPlayerLevel(param)
	local id = nil
	-- param1 = param1 or 0
	for i, v in pairs(this.guideSet) do
		if v.type == this.GuideType.PlayerLevel and type(v.param) == "table" then
			if v.param[1] == param then
				-- if v.param[2] == param1 then
				-- 	id = i
				-- end
				id = i
				break;
			end
		end
	end
	return id;
end

-- 等待回到主界面触发
function GuideManager.IsWaitBackToCity()
	app.log("等待回到主界面触发");
	return (this.playerLevelGuideId ~= nil) or (this.playerLevelFunctionId ~= nil)
end

-- 获取战队等级触发条件（param等级）
function GuideManager.GetPlayerLevelConditon(param)
	local id = nil
	local functionId = nil

	local openFuncCfg = {}
	for k, v in pairs(this.guideSet) do
		if v.type == this.GuideType.OpenFunctionUI then
			openFuncCfg[v.param] = k
		end
	end
	-- param1 = param1 or 0
	for i, v in pairs(this.guideSet) do
		if v.type == this.GuideType.PlayerLevel and type(v.param) == "table" then
			if v.param[1] == param then
				-- if v.param[2] == param1 then
				-- 	id = i
				-- end
				if v.param[2] > 0 then
					if openFuncCfg[ v.param[2] ] then
						functionId = v.param[2]
					end
				end
				id = i
				-- functionId = (v.param[2] > 0) and v.param[2] or nil
				break;
			end
		end
	end
	if id == nil then
		for i, v in pairs(this.guideSet) do
			if v.type == this.GuideType.SpecailFunction and type(v.param) == "table" and v.param[2] == param then
				if this.IsSpecailFunctionOpen(v.param[1], v.param[2]) then

					if openFuncCfg[ v.param[1] ] then
						functionId = v.param[1]
					end

					id = i;
					break;
				end
			end
		end
	end
	return id, functionId;
end

-- 通关关卡触发(仅打开关卡界面检查)
function GuideManager.CheckHurdlePassed(param)
	if param and param > 0 then
		for i, v in pairs(this.guideSet) do
			if v.type == this.GuideType.HurdlePassed and v.param == param then
				if v.param == param then
					return i;
				end
			end
		end
	end
end

-- 通关关卡触发(打开功能开启界面)
function GuideManager.CheckOpenFunctionUI(param)
	if param and param > 0 then
		for i, v in pairs(this.guideSet) do
			if v.type == this.GuideType.OpenFunctionUI and v.param == param then
				if v.param == param then
					return i;
				end
			end
		end
	end
end

function GuideManager.IsSpecailFunctionOpen(funcid, level)
	--7天乐
	if funcid == MsgEnum.eactivity_time.eActivityTime_Sign_in then
		if g_dataCenter.signin:GetIsOpen() and SystemEnterFunc.IsOpenFunc(funcid) then
			return true
		end
	end

	return false
end

-- 功能有单独开启条件
function GuideManager.CheckSpecailFunction()
	local param1, param2 = 0, 0
	local playerLevel = g_dataCenter.player.level
	for i, v in pairs(this.guideSet) do
		if v.type == this.GuideType.SpecailFunction and type(v.param) == "table" then
			param1, param2 = v.param[1], v.param[2]
			if param2 == 0 or playerLevel >= param2 then
				if this.IsSpecailFunctionOpen(param1, param2) then
					return i;
				end
			end
		end
	end
end

-- 返回当前引导Id
function GuideManager.GetCurrentGuideId()
	return this.currentGuideId
end

-- 返回是否执行引导中
function GuideManager.IsGuideRuning()
	return this.currentGuideId > 0
end

-- 是否使用关卡内的新手引导剧情（替换默认的关卡剧情 - 进战斗，出战斗剧情）
function GuideManager.IsUseGuideHurdleScreenplay(hurdle_id)
	if not AppConfig.get_enable_guide() then
		return false;
	end

	if this.currentGuideId > 0 then
		local data = this.guideSet[this.currentGuideId]
		if data and data.use_guide_hurdle_screenplay == 1 then
			return true
		end
	else
		local id = this.CheckSceneLoad(hurdle_id)
		if id then
			local data = this.guideSet[id]
			if data and data.use_guide_hurdle_screenplay == 1 then
				return true
			end
		end
	end

	return false
end

function GuideManager.GetSceneFunctionId()
	if this.currentGuideId > 0 then
		local data = this.guideSet[this.currentGuideId]
		if data and data.scene_function_id then
			return data.scene_function_id
		end
	end
	return 0
end

function GuideManager.GetConfigFunctionId()
	if this.currentGuideId > 0 then
		local data = this.guideSet[this.currentGuideId]
		if data and data.function_id then
			return data.function_id
		end
	end
	return 0
end

-- 返回定位关卡id页面
function GuideManager.GetGuideHurdleId()
	return this.guideHurdleId
end

-- 返回定位功能id页面
function GuideManager.GetGuideFunctionId()
	return this.guideFunctionId
end

-- 更新引导步骤
function GuideManager.UpdateGuideStep(guideId, isSkip)
	-- TODO: 暂无需求
end

-- 更新引导关键点
function GuideManager.UpdateGuideKeyPoint(isSkip)
	if not this.passKeyPoint then
		OutGuideLog(" ### UpdateGuideKeyPoint " .. this.currentGuideId)
		this.send_guide_id_msg(this.currentGuideId)
		this.passKeyPoint = true
	end
end

-- 关键点提前检查
function GuideManager.CheckGuideKeyPoint()
	if this.currentGuideId == 0 then return end
	-- 打点检查
	local step = this.currentStepsData[this.currentStepIndex]
	if step and step.key_point == 1 then
		OutGuideLog(" ### CheckGuideKeyPoint " .. this.currentGuideId)
		this.send_guide_id_msg(this.currentGuideId)
		this.passKeyPoint = true
	end
end

-- 服务器关键打点
function GuideManager.CheckDoneParam(done_param)
	local tag = done_param or 0
	if tag ~= 0 then
		local data = g_dataCenter.player_flag[tag]
		if data and data.value > 0 then
			OutGuideLog(" ### 服务器打点已完成  "..tag)
			return true
		end
	end
	return false;
end

-- 服务器关卡通关检查
function GuideManager.CheckDoneHurdle(done_hurdle)
	if done_hurdle == nil or done_hurdle == 0 then return false end
	return g_dataCenter.hurdle:IsPassHurdle(done_hurdle);
end

-- 附加条件检查
function GuideManager.CheckAddParam(add_param)
	if add_param and type(add_param) == "table" then
		for i, param in ipairs(add_param) do
			--拥有英雄个数
			if param.tp == 1 then
				local heroCards = g_dataCenter.package:get_hero_card_table()
				local needCount = param.p1 or 1
				if #heroCards < needCount then
					return false
				end
			--拥有指定道具
			elseif param.tp == 2 then
				local count = g_dataCenter.package:find_count(ENUM.EPackageType.Item, param.p1)
				local needCount = param.p2 or 1
				if count < needCount then
					return false
				end
			--拥有指定装备
			elseif param.tp == 3 then
				local equipCfgId = param.p1 or 0
				local needLevel = param.p2 or 1
				local needRarity = param.p3 or 1
				local needStar  = param.p4 or 1
				local equipCard = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Equipment, equipCfgId)
				if not equipCard or equipCard.level < needLevel or equipCard.rarity < needRarity or equipCard.star < needStar then
					return false
				end
			--指定英雄的某部位装备已解锁
			elseif param.tp == 4 then
				local heroCfgId = param.p1 or 0
				local heroCard = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, heroCfgId)
				if heroCard == nil then
					return false
				end

				local equipIndex = param.p2 or 1
				local equipCard = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, heroCard.equipment[equipIndex] or 0)
				if equipCard == nil then
					return false
				end

				local lockType = param.p3 or 0
				--1升级 2升品 3升星
				if lockType == 1 then 
					-- 特殊装备未解锁情况
					if equipCard:IsEquipLock() then
						return false
					end
					if equipCard.level >= CardEquipment.GetMaxLevel() then
						return false
					end
					if equipCard.level == equipCard.rarityConfig.level then
						return false
					end
				elseif lockType == 2 then
					-- 特殊装备未解锁情况
					if equipCard:IsEquipLock() then
						return false
					end
					if equipCard.level == equipCard.rarityConfig.level then
						return false
					end
				elseif lockType == 3 then
					if equipCard:IsEquipLock("StarUp") then
						return false
					end
				else
					return false
				end
			--拥有指定英雄
			elseif param.tp == 5 then
				local heroCfgId = param.p1 or 0
				local heroCard = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, heroCfgId)
				if not heroCard then
					return false
				end
			end
		end
	end
	return true;
end

function GuideManager.CheckNextGuide(isSkip, guideId)
	-- 承接类型将跳过所有的关联引导
	if not isSkip then
		-- 触发承接引导检查
		local id = this.CheckPrevCall(guideId)
		if id and id ~= 0 then
			this.BeginGuide(id)
		end
	end

	this.CheckMainUI()
end

function GuideManager.CheckMainUI()
	--主界面
	if uiManager:GetUICount() == 1 and uiManager:FindUI(EUI.MMOMainUI) then
		local playType = FightScene.GetPlayMethodType()
		local isMainCity = playType == MsgEnum.eactivity_time.eActivityTime_MainCity
		local lastGuideId = this.currentGuideId
		local lastStepIndex = this.currentStepIndex
		-- 打开主界面，恢复触发引导检查
		if not this.IsGuideRuning() and isMainCity then
			this.Trigger(this.GuideType.PrevCall)
		end
		-- 检查战队等级
		if not this.IsGuideRuning() and isMainCity then
			-- 有功能开启引导 触发条件:等待飞入效果完成后触发
			if not this.playerLevelFunctionId then
				this.Trigger(this.GuideType.PlayerLevel, g_dataCenter.player.level)
			end
		end
		-- 单独功能开启条件检查
		if not this.IsGuideRuning() and isMainCity then
			-- 有功能开启引导 触发条件:等待飞入效果完成后触发
			if not this.playerLevelFunctionId then
				this.Trigger(this.GuideType.SpecailFunction)
			end
		end
		-- 打开主界面UI触发引导
		if not this.IsGuideRuning() then
			this.Trigger(this.GuideType.OpenUI, EUI.MMOMainUI, playType)
		end

		-- 闯关按钮特效常态播放检查
		this.CheckAdventureAnimationBefore20Level()

		if lastGuideId > 0 and lastGuideId ~= this.lastGuideId and lastStepIndex ~= this.lastStepIndex then
			this.lastGuideId = lastGuideId
			this.lastStepIndex = lastStepIndex
			TimerManager.Add(this.CheckStuckId, 5000, 1)
		end
	end
end

function GuideManager.CheckPushUI(scene_id)
	if scene_id == EUI.MMOMainUI then 
		this.CheckMainUI()
	else
		-- 打开UI触发引导
		local playType = FightScene.GetPlayMethodType()
		this.Trigger(this.GuideType.OpenUI, scene_id, playType)
	end
end

function GuideManager.CheckStuckId()
	if this.currentGuideId > 0 and this.lastGuideId ~= this.currentGuideId and this.lastStepIndex ~= this.currentStepIndex then
		OutGuideLog(" ### 引导卡住: "..GuideManager.GetIdStepStr())
	end
	this.lastGuideId = nil
	this.lastStepIndex = nil
end

function GuideManager.RemoveStuckId()
	TimerManager.Remove(this.CheckStuckId)
	this.lastGuideId = nil
	this.lastStepIndex = nil
end

function GuideManager.CheckStopGuide()
	if this.currentGuideId == 0 then return end

	local data = this.guideSet[this.currentGuideId]
	if data and data.scene_switch_stop == 1 then
		OutGuideLog(" ### 停止引导 ==" .. this.currentGuideId .. "==")
		this.DoStopGuideClose()
	end
end

-- 开始引导
function GuideManager.BeginGuide(guideId, guideStep)
	OutGuideLog(" ### 引导开始 ==" .. tostring(guideId) .. "-" .. tostring(guideStep or 1) .. "==")
	if this.guideSet[guideId] == nil then return end
	if ConfigManager.Get(EConfigIndex.t_guide_step,guideId) == nil then return end
	if this.currentGuideId > 0 then 
		local str = " ### exception: begin guide %s , but guide %s is running.";
		OutGuideLog(string.format(str, guideId, this.currentGuideId))
		return
	end

	-- Temp 临时处理，巅峰展示屏蔽多余引导
	if guideId > 1 and FightScene.GetFightManager() and FightScene.GetFightManager()._className == "PeakShowFightManager" then 
		return
	end

	if this.guideSet[guideId].type == this.GuideType.PlayerLevel or
		this.guideSet[guideId].type == this.GuideType.SpecailFunction then
		--清除临时标记
		this.playerLevelGuideId = nil
		this.playerLevelFunctionId = nil
	end
	this.passKeyPoint = false
	this.guideHurdleId = this.guideSet[guideId].hurdle_id or 0
	this.guideFunctionId = this.guideSet[guideId].function_id or 0
	this.currentGuideId = guideId
	this.currentStepIndex = 0
	this.currentStepsData = ConfigManager.Get(EConfigIndex.t_guide_step,guideId)

	-- 指定step开始
	if guideStep then
		this.currentStepIndex = math.max(0, guideStep - 1)
	end

	this.ExecuteGuideStep()
end

-- 结束引导
function GuideManager.EndGuide(isSkip)
	OutGuideLog(" ### 引导完成 ==" .. this.currentGuideId .. "==  skip:" .. tostring(isSkip==true))
	if this.currentGuideId == 0 then return end

	local guideId = this.currentGuideId

	GuideUI.Close(true)
	this.guideHurdleId = 0
	this.guideFunctionId = 0
	this.currentGuideId = 0
	this.currentStepsData = nil
	this.currentStepIndex = 0
	this.need_server_confirm = nil
	this.RemoveGuide(guideId)

	this.CheckNextGuide(isSkip, guideId)
end

-- 中断引导
function GuideManager.StopGuide(isForce)
	if this.currentGuideId == 0 then return end

	if isForce then
		OutGuideLog(" ### 强制中断引导 ==" .. this.currentGuideId .. "==")
	else
		local data = this.guideSet[this.currentGuideId]
		if data and data.scene_switch_stop ~= 1 and (data.type == this.GuideType.PrevCall or data.type == this.GuideType.PlayerLevel) then
			OutGuideLog(" ### 未中断引导 ==" .. this.currentGuideId .. "==")
			return;
		else
			OutGuideLog(" ### 中断引导 ==" .. this.currentGuideId .. "==")
		end
	end

	this.DoStopGuideClose()
end

function GuideManager.DoStopGuideClose()
	local guideId = this.currentGuideId

	GuideUI.Close()
	this.guideHurdleId = 0
	this.guideFunctionId = 0
	this.currentGuideId = 0
	this.currentStepsData = nil
	this.currentStepIndex = 0
	this.need_server_confirm = nil

	if this.passKeyPoint then
		this.RemoveGuide(guideId)
	end
end

-- 执行一个步骤
function GuideManager.ExecuteGuideStep()
	if this.currentStepsData == nil then return end
	if type(this.need_server_confirm) == "number" then return end

	-- 重置临时变量
	if this._expedition_trial_fix then
		--恢复远征滑动事件
		this._set_disable_move_expedition_trial_map(false)
		this._expedition_trial_fix = nil
	end

	if this.currentStepIndex == #this.currentStepsData then
		this.EndGuide()
		return
	end

	-- step索引自增
	this.currentStepIndex = this.currentStepIndex + 1

	OutGuideLog(" ### ExecuteGuideStep " .. GuideManager.GetIdStepStr())
	
	if this.currentGuideId > 100 then
		system.cg_add_guide_log(this.currentGuideId, this.currentStepIndex)
	end

	-- 打开新手引导界面
	local step = this.currentStepsData[this.currentStepIndex]
	this.need_server_confirm = this.CheckNeedServerConfirm(step)
	GuideUI.Open(step)
end

-- 调用下一个步骤
function GuideManager.DoNextGuideStep()
	if this.currentGuideId == 0 then return end

	GuideUI.Close()

	-- 打点检查
	--local step = this.currentStepsData[this.currentStepIndex]
	--if step and step.key_point == 1 then
		--this.UpdateGuideKeyPoint()
	--end

	this.ExecuteGuideStep()
end

-- 检查关联前置引导并删除
function GuideManager.CheckPrevGuide(id)
	local prev_id = this.checkNextSet[id]
	if prev_id and this.guideSet[prev_id] then
		this.guideSet[prev_id] = nil
		this.CheckPrevGuide(prev_id)
	end
end

function GuideManager.CheckRecord(guideRecord)
	if AppConfig.enable_guide == false then return end

	this.isLoadedRecord = true

	-- 首先清除本地用配置
	for k, v in pairs(this.guideSet) do
		if v.is_local == 1 then
			this.guideSet[k] = nil
		end
	end

	OutGuideLog(" ### guideRecord:" .. table.tostring(guideRecord))
	guideRecord = guideRecord or {}

	for i, v in pairs(guideRecord) do
		this.CheckPrevGuide(v)
		if this.guideSet[v] then
			this.guideSet[v] = nil
		end
		this.recordSet[v] = true
	end

	-- 玩家等级检查
	app.log("玩家等级检查")
	local level = g_dataCenter.player.level
	for k, v in pairs(this.guideSet) do
		if v.check_level and v.check_level > 0 and level > v.check_level then
			this.guideSet[k] = nil
		end
	end

	-- 服务器打点检查
	app.log("服务器打点检查")
	--local doneRemove = {}
	--for k, v in pairs(this.guideSet) do
		--if this.CheckDoneParam(v.done_param) or this.CheckDoneHurdle(v.done_hurdle) then
			--table.insert(doneRemove, k);
		--end
	--end
	--this.DoneGuide(doneRemove);

	-- 常驻资源不释放
	app.log("常驻资源不释放")
	if next(this.guideSet) then
		ResourceManager.AddPermanentReservedRes(GuideUI.res)
	end

	-- this.OnUpdatePlayerFlag()
end

-- 动画帧回调检查(新增的)
function GuideManager.CheckAnimationBack(UiName)
	if this.currentGuideId == 0 then return false end

	local result = false
	local step = this.currentStepsData[this.currentStepIndex]
	if step and step.name_ani_back == UiName then
		OutGuideLog(" ### CheckAnimationBack " .. UiName)
		this.DoNextGuideStep()
		result = true
	end
	return result
end

-- 检查隐藏UI函数调用
function GuideManager.CheckHideUiFunc(hide_fun_name, param)
	if this.currentGuideId == 0 then return false end
	if GuideUI.opened == false then return false end
	
	local result = false
	local step = this.currentStepsData[this.currentStepIndex]
	if type(step.hide_ui_fun) == "table" then
		if #step.hide_ui_fun > 0 then
			for k, v in ipairs(step.hide_ui_fun) do
				if v[hide_fun_name] and (param == nil or param == v[hide_fun_name]) then
					OutGuideLog(" ### CheckHideUiFunc " .. hide_fun_name .. ", " .. tostring(param))
					GuideUI.Close();
					result = true
					break;
				end
			end
		else
			if step.hide_ui_fun[hide_fun_name] and (param == nil or param == step.hide_ui_fun[hide_fun_name] ) then
				OutGuideLog(" ### CheckHideUiFunc " .. hide_fun_name .. ", " .. tostring(param))
				GuideUI.Close();
				result = true
			end
		end
	end

	if result and this.currentGuideId == 1 then
		if this.currentStepIndex == 1 then
			--[[移动教学1]]
			SystemLog.AppStartClose(500000015);
		elseif this.currentStepIndex == 2 then
			--[[普通攻击教学]]
			SystemLog.AppStartClose(500000016);
		elseif this.currentStepIndex == 4 then
			--[[解锁第一个技能]]
			SystemLog.AppStartClose(500000017);
		elseif this.currentStepIndex == 5 then
			--[[移动教学2]]
			SystemLog.AppStartClose(500000018);
		elseif this.currentStepIndex == 6 then
			--[[解锁第二个技能]]
			SystemLog.AppStartClose(500000019);
		elseif this.currentStepIndex == 8 then
			--[[移动教学3]]
			SystemLog.AppStartClose(500000020);
		elseif this.currentStepIndex == 9 then
			--[[解锁第三个技能]]
			SystemLog.AppStartClose(500000022);

		end
	end

	return result
end

--[[ 检查等待函数调用
	enter_region （新手关卡）进入光圈范围
	kill_monster （新手关卡）击杀第几波怪完成
	use_skill    （新手关卡）使用了第几个技能
	move_joystick（新手关卡）英雄移动了位置
	battle_burst  （新手关卡）关卡最后爆发（获得大招技能）
	battle_exit  （新手关卡）退出关卡

	restart_ui					UI栈恢复了界面
	push_ui       				打开了界面
	pop_ui						关闭了界面
	niudan_success     			扭蛋单抽成功
	change_area_success			选区成功
	get_common_add_exp_back 	关卡经验结算界面退出
	get_common_award_back 		物品展示界面退出
	get_common_hurdle_back		关卡星级评定界面退出
	get_hero_qua_up_show_back	英雄升品界面返回
	get_float_tips_show_back	冒泡文字展示完毕返回
	get_battle_show_back		战斗结算展示完毕返回（1/0 胜利/失败）
	get_contact_active_show_back	连协激活界面返回
	get_new_hero_show_back		英雄展示界面返回
	screen_play_over 			剧情播放展示退出
	get_hero_starup_show_back	英雄升星展示退出
	get_hurdle_raids_show_back	关卡扫荡结果返回
	complete_condition 			完成了任务条件
	wait_open_func_show_end		功能开启展示完成
	main_scene_btn_click		主界面场景上功能按钮点击
	guide_play_guide_ui_back	玩法引导界面返回
	open_far_trial_choose_diff	打开远征难度选择
	open_far_trial_choose_role	打开远征对手选择
	wait_fight_start_end		战斗开场321界面退出
	back_to_ui_daily_task		每日任务所有弹窗关闭返回到每日任务界面
	region_select_rival_ok		区域占领选择对手成功
	wait_screen_click			全屏点击
--]] 
function GuideManager.CheckWaitFunc(wait_fun_name, param)
	if this.currentGuideId == 0 then return false end
	
	local result = false
	local step = this.currentStepsData[this.currentStepIndex]
	if type(step.wait_fun) == "table" then
		if step.wait_fun[wait_fun_name] and (param == nil or param == step.wait_fun[wait_fun_name] ) then
			OutGuideLog(" ### CheckWaitFunc " .. wait_fun_name .. ", " .. tostring(param))
			this.DoNextGuideStep()
			result = true
		end
	elseif type(step.wait_fun) == "string" then
		if step.wait_fun == wait_fun_name then
			OutGuideLog(" ### CheckWaitFunc " .. wait_fun_name)
			this.DoNextGuideStep()
			result = true
		end
	end

	return result
end

--[[ 检查可跳过的条件]]
function GuideManager.CheckConditionFunc(condition_fun_name, param)
	if this.currentGuideId == 0 then return false end
	local step = this.currentStepsData[this.currentStepIndex]
	if type(step.condition_fun) ~= "table" or
		step.condition_fun[condition_fun_name] == nil then return false end

	local result = false
	if this[condition_fun_name] then
		result = this[condition_fun_name](param)
	else
		OutGuideLog(" ### 未找到的condition_fun " .. tostring(condition_fun_name))
	end

	if result then
		this.DoNextGuideStep()
	end

	return result
end

--[[ 代码动态获取gameobject
	get_main_scene_btn_by_id		获取主界面场景中按钮组件
	get_main_ui_btn_by_name			获取主界面指定name按钮组件
	get_role_item_by_id 			获取角色列表界面指定英雄id列表项
	get_role_item_by_index 			获取角色列表界面指定英雄索引index列表项
	get_role_item_btn1_by_id 		获取角色列表界面指定英雄id列表项 - 装备按钮
	get_role_item_btn2_by_id 		获取角色列表界面指定英雄id列表项 - 强化按钮
	get_role_item_btn3_by_id 		获取角色列表界面指定英雄id列表项 - 招募按钮
	get_role_item_btn1_by_index 		获取角色列表界面指定索引index列表项 - 装备按钮
	get_role_item_btn2_by_index 		获取角色列表界面指定索引index列表项 - 强化按钮
	get_role_item_btn3_by_index 		获取角色列表界面指定索引index列表项 - 招募按钮
	get_role_item_by_index			获取角色列表界面指定索引index列表项
	get_role_item_btn1_by_formation		获取角色列表界面第一个上阵英雄列表项 - 装备按钮
	get_role_item_btn2_by_formation		获取角色列表界面第一个上阵英雄列表项 - 强化按钮
	get_role_item_btn1_by_fight_value		获取角色列表界面战力第一英雄列表项 - 装备按钮
	get_role_item_btn2_by_fight_value		获取角色列表界面战力第一英雄列表项 - 强化按钮
	get_hero_trial_item			获取角色历练引导英雄（第一个）
	get_hurdle_item				获取指定难度的指定关卡项（章节确定）
	get_hurdle_box				获取的指定关卡第index宝箱（章节确定）
	get_hero_equip_item 		获取指定装备列表项
	get_hero_equip_item_button 	获取指定装备列表项的按钮
	get_hero_list_item			获取指定英雄列表项
	get_egg_hero_item			获取英雄扭蛋界面指定index列表项
	get_play_list_item_by_index	获取指定index玩法列表项（同时定位）
	get_daily_task_item_btn_by_index	获取每日任务列表指定index项领取按钮
	get_daily_task_item_btn_by_id		获取每日任务列表指定id项领取按钮	
	get_role_view_yeka_by_id	获取角色详情界面指定功能id页签的列表项
	get_role_view_hero_item_by_id		获取角色详情界面指定英雄配置编号id的列表项
	get_role_view_hero_item_by_index	获取角色详情界面指定索引index列表项
	get_equip_view_hero_item_by_id		获取装备详情界面指定英雄配置编号id的列表项
	get_equip_view_hero_item_by_index	获取装备详情界面指定索引index列表项
	get_team_view_hero_item_by_id		获取阵容详情界面指定英雄配置编号id的列表项
	get_team_view_hero_item_by_index	获取阵容详情界面指定索引index列表项
	get_arena_player_ahead_fight_btn	获取竞技场前面那个对手的挑战按钮
	get_clan_list_item_btn_by_index		获取战队列表界面指定索引index进入按钮（同时定位）
--]]
function GuideManager.GetGameObjectByFunc(name, param)
	if name and type(this[name]) == "function" then
		if type(param) == "table" then
			return this[name](unpack(param))
		else
			return this[name](param)
		end
	end
end

function GuideManager.GetIdStepStr()
	return tostring(this.currentGuideId).."-"..tostring(this.currentStepIndex)
end

function GuideManager.CheckNeedServerConfirm(step)
	local result = false
	if step and step.need_server_confirm == 1 then
		result = true
	end
	return result
end

----------------------------外部调用------------------------------
-- 设置隐藏模式(true/false 隐藏/显示)
function GuideManager.SetHideMode(bool)
	if not this.isReady then return end

	this.hideMode = bool
	if not bool then
		GuideUI.Show()
	else
		GuideUI.Hide()
	end
end