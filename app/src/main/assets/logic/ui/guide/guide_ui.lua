--region guide_ui.lua
--author : zzc
--date   : 2015/11/26


-- 新手引导界面
-- 说明：
-- 1.单例方式
GuideUI = {
	opened = false,		-- 是否处于打开状态
	ui = nil,

	tempLog = {},
	
	info = nil,
	bindkey = nil,
	checkTimer = nil,
	waitTimer = nil,
	layerTimer = nil,
	layerCount = 0,
	loadedData = false,
	loadedAsset = false,
	audioId = 0,

	res = {
		main = "assetbundles/prefabs/ui/guide/guide_camera.assetbundle",
		--引导员资源项
		item_text = "assetbundles/prefabs/ui/guide/guide_text_item.assetbundle",

		item_hand = "assetbundles/prefabs/ui/guide/guide_hand_item.assetbundle",

		item_mask = "assetbundles/prefabs/ui/guide/guide_mark_item.assetbundle",
		
		--item_float = "assetbundles/prefabs/ui/guide/guide_float_item.assetbundle",
	}
}

function GuideUI.GetResList()
	return GuideUI.res
end

-------------------------------------local声明-------------------------------------
-- 内部可以用this指向，简化代码
local this = GuideUI

local _ENABLE_TRANSPARENT_MASK = false	-- 是否全部启用透明遮罩
local _ENABLE_UI_ANI_FIXED_TIME = false	-- UI动画是否使用固定时间
local _SCREEN_SIZE_MIN_OFFSET = 1 
-- 屏幕适配最小偏差值
if app.get_screen_width() > 3200 - 100 then
	_SCREEN_SIZE_MIN_OFFSET = 8
elseif app.get_screen_width() > 2560 - 100 then
	_SCREEN_SIZE_MIN_OFFSET = 4
elseif app.get_screen_width() > 1920 - 100 then
	_SCREEN_SIZE_MIN_OFFSET = 2
end

local _PopUiNameMap = 
{
	-- TODO : 暂无需求
	-- hero_chose_ui				= EUI.HeroChoseUI,
}

local _PopUiFuncNameMap = 
{
	-- TODO : 暂无需求
	-- get_hero_list_item 			= EUI.HeroChoseUI,
}

-------------------------------------函数声明-------------------------------------

--注册方法
function GuideUI.RegistFunc()
	this.bindfunc = {}
	this.bindkey = {}
	this.bindfunc["on_loaded"] = Utility.bind_callback(this.bindkey, this.on_loaded)
end

--撤销注册方法
function GuideUI.UnRegistFunc()
	if this.bindfunc then
	    for k,v in pairs(this.bindfunc) do
	        if v ~= nil then
	            Utility.unbind_callback(this, v)
	        end
	    end
	end
end

--打开界面
function GuideUI.Open(stepInfo)
	if this.opened then return end
	OutGuideLog(" ### stepInfo : " .. stepInfo.cmd .. ", " .. table.tostring(stepInfo.ui_path))
	this.opened = true

	g_GuideLockUI.Show()

	if not this.loadedAsset then
		this.uis = {}
		this.info = stepInfo
		this.ownUiName = this.ownUiName or ""
		this.RegistFunc()
		this.LoadAsset()

	else
		this.info = stepInfo
		this.ownUiName = this.ownUiName or ""
		-- this.ui:set_active(true)
		this.InitAllUI()
	end

	-- Root.AddUpdate(this.Update)
end

function GuideUI.Update(deltaTime)
	if this.timeRecord == nil then return end
	if system.time() - this.timeRecord > 20 then
		this.timeRecord = nil
	end
end


--关闭界面
function GuideUI.Close( isExit )
	if isExit then
		this.ownUiName = "" 
	end

	if this.opened then
		this.opened = false
		this.ClearData()
	end
	--g_GuideLockUI.Hide()
end

--加载资源
function GuideUI.LoadAsset()
	ResourceLoader.LoadAsset(this.res.main, this.bindfunc["on_loaded"])
	ResourceLoader.LoadAsset(this.res.item_text, this.bindfunc["on_loaded"])
	ResourceLoader.LoadAsset(this.res.item_hand, this.bindfunc["on_loaded"])
	ResourceLoader.LoadAsset(this.res.item_mask, this.bindfunc["on_loaded"])
end

--资源加载完成
function GuideUI.on_loaded(bindkey, pid, filepath, asset_obj, error_info)
	if bindkey ~= this.bindkey then return end

	this.uis[filepath] = asset_game_object.create(asset_obj)

    if filepath == this.res.main then
    	this.ui = this.uis[filepath]

    	-- 隐藏显示
    	this.ui:set_active(false)

    	this.InitUI()
    elseif filepath == this.res.item_text then
    	this.item_text = this.uis[filepath]

    	this.InitItemText()

    elseif filepath == this.res.item_hand then
    	this.item_hand = this.uis[filepath]

    	this.InitItemHand()

	elseif filepath == this.res.item_mask then
		this.item_mask = this.uis[filepath]

		this.InitItemMask()
    end

    if table.get_num(this.uis) == table.get_num(this.res) then
    	this.InitAllUI()
    	table.clear_all(this.uis)
    end
end

function GuideUI.HandleGuideCmd()
	local outParam = {duration=0, jump=false, done=false, goto_id=nil, goto_step=nil}
	local cmd = this.info.cmd

	if cmd == "open_left_list" then
		this.HandleCmdLeftList(outParam, true)

	elseif cmd == "close_left_list" then
		this.HandleCmdLeftList(outParam, false)

	elseif cmd == "open_right_list" then
		this.HandleCmdRightList(outParam, true)

	elseif cmd == "close_right_list" then
		this.HandleCmdRightList(outParam, false)

	elseif cmd == "clear_ui_stack" then
		this.HandleCmdClearUiStack(outParam)

	elseif cmd == "battle_guide_arrow" then
		this.HandleCmdSetBattleGuideArrow(outParam)

	elseif cmd == "chushi_join_formation" then
		this.HandleCmdChushiJoinFormation(outParam)

	elseif string.find(cmd, "goto", 1, true) then
		local data = Utility.lua_string_split(cmd, ":")
		this.HandleCmdGoto(outParam, data)

	elseif string.find(cmd, "screen_play", 1, true) then
		local data = Utility.lua_string_split(cmd, ":")
		this.HandleCmdScreenPlay(outParam, data)

	elseif string.find(cmd, "push_ui", 1, true) then
		local data = Utility.lua_string_split(cmd, ":")
		this.HandleCmdPushUi(outParam, data)

	elseif string.find(cmd, "float_string", 1, true) then
		local data = Utility.lua_string_split(cmd, ":")
		this.HandleCmdFloatString(outParam, data)

	elseif string.find(cmd, "wait_time") then
		local data = Utility.lua_string_split(cmd, ":")
		this.HandleCmdWaitTime(outParam, data)

	elseif string.find(cmd, "check_condition") then
		this.HandleCmdCheckCondition(outParam)

	elseif string.find(cmd, "remove_ui") then
		local data = Utility.lua_string_split(cmd, ":")
		this.HandleCmdRemoveUi(outParam, data)

	elseif string.find(cmd, "play_guide_ui") then
		local data = Utility.lua_string_split(cmd, ":")
		this.HandleCmdPlayGuideUi(outParam, data)

	end

	-- 播放音效
	if this.info.sound_id > 0 then
		AudioManager.Play3dAudio(this.info.sound_id, AudioManager.GetUiAudioSourceNode(), true, true, true)
	end

	-- 检查引导对象
	if outParam.done then
		GuideManager.UpdateGuideKeyPoint(true);
		GuideManager.StopGuide(true);
		return;
	elseif outParam.jump then
		return;
	elseif outParam.goto_id then
		GuideManager.UpdateGuideKeyPoint(true);
		GuideManager.StopGuide(true);
		GuideManager.BeginGuide(outParam.goto_id, outParam.goto_step);
	elseif outParam.duration > 0 then
		-- timer.create("GuideManager.DoNextGuideStep", outParam.duration, 1)
		TimerManager.Add(GuideManager.DoNextGuideStep, outParam.duration, 1)
	else
		this.CheckSelectUi()
	end
end

function GuideUI.ScreenPlayCallback()
	if not GuideManager.IsGuideRuning() then return end
	if GetMainUI() and GetMainUI():IsLoaded() then
		timer.stop(this.loadedTimer)
		this.loadedTimer = nil
		this.HandleGuideCmd()
	end
end

function GuideUI.HandleCmdGoto(outParam, data)
	outParam.duration = 1
	outParam.goto_id = tonumber(data[2])
	outParam.goto_step = tonumber(data[3])
	OutGuideLog("### goto跳转："..tostring(outParam.goto_id).."-"..tostring(outParam.goto_step))
end

function GuideUI.HandleCmdScreenPlay(outParam, data)
	outParam.duration = 1
	local play_id = tonumber(data[2])
	if play_id then
		local cbScreenPlay = function()
			ScreenPlay.Play(play_id)
		end
		TimerManager.Add( cbScreenPlay, 1, 1 )
	end
end

function GuideUI.HandleCmdPushUi(outParam, data)
	outParam.duration = 30
	local ui_name = tostring(data[2])
	-- 特殊处理: 仅没有充值的玩家才弹出界面
	if ui_name == "UiFirstRecharge" and g_dataCenter.player:GetFirstRechargeType() == ENUM.ETypeFirstRecharge.haveGet then
		outParam.done = true
	elseif uiManager then
		uiManager:PushUi(ui_name)
	end
end

function GuideUI.HandleCmdFloatString(outParam, data)
	local direction =  tonumber(data[2])
	local float_type = tonumber(data[3])
	if direction and float_type and this.info and this.info.float_txt ~= 0 then
		local data = {
			content = this.info.float_txt,
			parent_path = this.info.ui_path,
			float_type = float_type,
			direction = direction,
		}
		this.item_float = GuideFloatTips:new(data)
	end
end

function GuideUI.HandleCmdSetBattleGuideArrow(outParam)
	local func = function()
		local curUi = uiManager:GetCurScene()
		if curUi and curUi.SetGuideArrow then
			curUi:SetGuideArrow(true)
		end
	end
	TimerManager.Add( func, 250, 1 )
end

function GuideUI.HandleCmdClearUiStack(outParam)
	outParam.duration = 30
	if uiManager then
		uiManager:SetStackSize(1)
	end
end

function GuideUI.HandleCmdChushiJoinFormation(outParam)
	outParam.duration = 1
	--笛口雏实上阵
	local defTeam = g_dataCenter.player:GetDefTeam() or {}
	local seatHero3 = defTeam[3] and tonumber(defTeam[3]) or 0
	if seatHero3 == 0 then
		local heroCid = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_guide_hurdle_get_hero_id).data
		local heroInfo = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, heroCid)
		if heroInfo then
			local cards = {}
			for i, v in ipairs(defTeam) do
				table.insert(cards, v)
			end
			--发送笛口雏实上阵消息
			table.insert(cards, heroInfo.index)
			local team = 
		    {
		        ["teamid"] = ENUM.ETeamType.normal,
		        cards = cards,
		    }
		    msg_team.cg_update_team_info(team)
		end
	end
end

function GuideUI.HandleCmdWaitTime(outParam, data)
	local duration =  tonumber(data[2])
	outParam.duration = duration or 0
end

function GuideUI.HandleCmdLeftList(outParam, isOpen)
	outParam.duration = 1
	if this.CheckMainUiLoaded() == false then
		outParam.jump = true
		return;
	end
	local comPlayerMenu = GetMainUI():GetPlayerMenu()
	local nowOpen = comPlayerMenu:IsLeftMenuOpen()
	if isOpen ~= nowOpen then
		if isOpen then
			comPlayerMenu:OpenLeftMenu()
		else
			comPlayerMenu:CloseLeftMenu()
		end
		outParam.duration = 1000
	end
end

function GuideUI.HandleCmdRightList(outParam, isOpen)
	outParam.duration = 1
	if this.CheckMainUiLoaded() == false then
		outParam.jump = true
		return;
	end
	local comPlayerMenu = GetMainUI():GetPlayerMenu()
	local nowOpen = comPlayerMenu:IsRightMenuOpen()
	if isOpen ~= nowOpen then
		if isOpen then
			comPlayerMenu:OpenRightMenu()
		else
			comPlayerMenu:CloseRightMenu()
		end
		outParam.duration = 1000
	end
end

function GuideUI.HandleCmdCheckCondition(outParam)
	outParam.jump = true
	if type(this.info.condition_fun) == "table" then
		for k, v in pairs(this.info.condition_fun) do
			if GuideManager[k] then
				if GuideManager.CheckConditionFunc(k, v) then
					break;
				end
			end
		end
	end
end

function GuideUI.HandleCmdRemoveUi(outParam, data)
	outParam.duration = 200
	uiManager:RemoveUi(tostring(data[2]))
end

function GuideUI.HandleCmdPlayGuideUi(outParam, data)
	GuidePlayGuideUI.Start({data[2],data[3]})
end

function GuideUI.CheckMainUiLoaded()
	local result = true
	local comPlayerMenu = GetMainUI():GetPlayerMenu()
	if comPlayerMenu == nil then
		this.loadedTimer = timer.create("GuideUI.MainUiLoadedCallback", 60, 100)
		result = false
	end

	return result;
end

-- 
function GuideUI.MainUiLoadedCallback()
	if not GuideManager.IsGuideRuning() then return end
	if GetMainUI() and GetMainUI():IsLoaded() then
		timer.stop(this.loadedTimer)
		this.loadedTimer = nil
		this.HandleGuideCmd()
	end
end

-- 检查引导对象
function GuideUI.CheckSelectUi()
	-- 没有配置引导对象
	if this.info.ui_path == nil or this.info.ui_path == 0 then
		this.CheckUIAnimation()
		return
	end

	-- 引导对象已存在
	local selectGo = this.GetSelectGameObject(this.info.ui_path)
	if selectGo then
		this.selectGo = selectGo
		if this.info.click_path and this.info.click_path ~= 0 then
			local clickGo = this.GetSelectGameObject(this.info.click_path)
			if clickGo then
				this.clickGo = clickGo
				this.CheckUIAnimation()
				return
			end
		else
			this.CheckUIAnimation()
			return
		end
	end

	-- 定时器查询引导对象是否创建成功
	if this.checkTimer == nil then
		this.checkCount = 0
		this.checkTimer = timer.create("GuideUI.CheckTimerCallback", 60, -1)
		return
	end
end

-- 获取gameobject
function GuideUI.GetSelectGameObject(param)
	local go = nil

	if type(param) == "string" then
		go = asset_game_object.find(param)
	-- 代码动态获取gameobject
	elseif type(param) == "table" then
		for k, v in pairs(param) do
			go = GuideManager.GetGameObjectByFunc(k, v)
			break
		end
	end

	return go
end

-- 定时器回调
function GuideUI.CheckTimerCallback()
	this.checkCount = this.checkCount + 1

	local selectGo = this.selectGo or this.GetSelectGameObject(this.info.ui_path)
	if selectGo then
		if this.info.click_path and this.info.click_path ~= 0 then
			local clickGo = this.GetSelectGameObject(this.info.click_path)
			if clickGo then
				timer.stop(this.checkTimer)
				this.checkTimer = nil

				this.selectGo = selectGo
				this.clickGo = clickGo
				this.CheckUIAnimation()
				return
			end
		else
			timer.stop(this.checkTimer)
			this.checkTimer = nil

			this.selectGo = selectGo
			this.CheckUIAnimation()
			return
		end
	end

	-- 查询超时，退出新手引导
	if this.checkCount == 100 then
		OutGuideLog("新手引导检查超时：id:" .. GuideManager.GetIdStepStr() .. tostring(this.info.ui_path), true)
		--this.Close()
		timer.stop(this.checkTimer)
		this.checkTimer = nil

		g_GuideLockUI.Hide()
	end
end

-- 定时器回调 - 检查并调整object位置
function GuideUI.CheckCopyPosCallback(pid)
	if not this.selectGo or not this.copy then return end

	local wx1, wy1, wz1 = this.selectGo:get_position()
	local wx2, wy2, wz2 = this.copy:get_position()

	local ui_camera = Root.get_ui_camera()
	local x1, y1, z1 = ui_camera:world_to_screen_point(wx1, wy1, wz1)
	local x2, y2, z2 = ui_camera:world_to_screen_point(wx2, wy2, wz2)

	local rx, ry = PublicFunc.Round(x1 - x2, 1), PublicFunc.Round(y1 - y2, 1)

	if math.abs(rx) > _SCREEN_SIZE_MIN_OFFSET or math.abs(ry) > _SCREEN_SIZE_MIN_OFFSET then
		-- 同步更新位置
		this.copy:set_position(wx1, wy1, wz1)
		-- 同步更新箭头位置
		if this.info.have_arrow > 0 then
			--远征用到的特殊手指位置修正
			if GuideManager._expedition_trial_fix then
				wx1, wy1, wz1 = ui_camera:screen_to_world_point(x1, y1+180, z1)
			end

			this.item_hand:set_position(wx1, wy1, wz1)
		end

		if not GuideUI.tempLog[ guideIdStr ] then
			OutGuideLog("新手引导： copy object's position has change !!! "..GuideManager.GetIdStepStr())
		end
	end
end

-- 定时器回调 - 检查调整object层级
function GuideUI.CheckLayerCallback(pid)
	if not this.selectGo then return end

	local needLayer = PublicStruct.UnityLayer.guide
	local curLayer = 0
	if this.clickGo then
		curLayer = this.clickGo:get_layer()
		this.clickGo:set_layer(needLayer, false)
	elseif this.selectGo then
		curLayer = this.selectGo:get_layer()
		this.selectGo:set_layer(needLayer, false)
	end

	if curLayer == needLayer and pid == this.layerTimer then
		this.layerCount = this.layerCount + 1
		if this.layerCount > 2 then
			timer.stop(this.layerTimer)
			this.layerTimer = nil
			this.layerCount = 0
		end
	end
end

-- 延时执行检查
function GuideUI.CheckUIAnimation()
	local duration = 30
	if this.info.have_ui_ani == 1 then
		duration = 2000 -- 超时
	elseif this.info.have_ui_ani == 2 then
		duration = 4000 -- 超时
	end
	
	if this.waitTimer ~= nil then
		timer.stop(this.waitTimer)
	end
	this.waitTimer = timer.create("GuideUI.CallLoadDataUi", duration, 1)
end

function GuideUI.GetFormatKeyStr(content)
	local keyStrArray = {}
	
	while(true) do
		local start_index, end_index = string.find(content, "#<%w*>")
		if start_index == nil then
			break
		end
		if start_index and end_index then
			local key = string.sub(content, start_index + 2, end_index - 1)
			local value = string.sub(content, start_index, end_index)
			if key and #key > 0 then keyStrArray[key] = value end
			content = string.sub(content, end_index + 1)
		end
	end
	return keyStrArray
end

-- 通配符替换
function GuideUI.GetFormatContent(str)
	local content = tostring(str)

	for k, v in pairs(this.GetFormatKeyStr(content)) do
		-- 换行符
		if k == "10" then
			content = string.gsub(str, v, "\n")
		-- 玩家名字
		elseif k == "player_name" then
			local player_name = g_dataCenter.player:GetName()
			content = string.gsub(str, v, player_name)
		end
		-- 根据需求增加其他通配符...
	end

	return content
end

function GuideUI.CheckStopGuide()
	this.isInactiveTimer = nil
	if not this.IsSelectGoInactive() then
		-- GuideManager.StopGuide();
	end
end

function GuideUI.CheckPopOwnUi(scene_id)
	if this.info and this.info.wait_fun == 0 then
		if this.ownUiName == scene_id then
			-- this.isInactiveTimer = timer.create("GuideUI.CheckStopGuide", 30, 1)
			return true
		end
	end
	return false
end

function GuideUI.GetOwnUiName()
	if this.info.ui_path ~= 0 then
		if type(this.info.ui_path) == "table" then
			for m, n in pairs(this.info.ui_path) do
				if _PopUiFuncNameMap[m] then
					return _PopUiFuncNameMap[m];
				end
			end
		else
			-- TODO: 指定ui名字
			for k, v in pairs(_PopUiNameMap) do
				if string.find(this.info.ui_path, v) then
					return v;
				end
			end
		end
	end
	return ""
end

function GuideUI.CallLoadDataUi()
	if this.opened and not this.loadedData then 
		this.LoadDataUi()
		g_GuideLockUI.Hide()
	end
end

function GuideUI.InitAllUI()
	this.loadedAsset = true
	
	this.item_mask:set_parent(this.parentMask)
	this.item_mask:set_local_scale(1,1,1)
	this.item_text:set_parent(this.node_item)
	this.item_text:set_local_scale(1,1,1)
	this.item_hand:set_parent(this.node_item)
	this.item_hand:set_local_scale(1,1,1)

	-- 无遮罩
	if this.info.mask_type == 0 then
		this.spMask:set_active(false)
	else
		this.spMask:set_active(true)
	end

	if GuideManager.hideMode then
		this.Hide()
	else
		this.Show()
	end

	this.HandleGuideCmd()
end

function GuideUI.InitItemText()
	this.item_text:set_name("guide_text_item")
	this.item_text:set_active(false)
end

function GuideUI.InitItemHand()
	this.item_hand:set_name("guide_hand_item")
	this.item_hand:set_active(false)
end

function GuideUI.InitItemMask()
	this.item_mask:set_name("guide_mask_item")
	-- this.item_mask:get_child_by_name("content"):set_active(false)
	this.item_mask:set_active(false)
end

function GuideUI.InitUI()
	this.ui:set_parent(Root.get_root_ui());
	this.ui:set_local_scale(Utility.SetUIAdaptation());
	this.ui:set_name("guide_camera")

	-- 分辨率适配，使用UI资源自身的缩放比
	if this.info.local_scale == 1 then
		this.ui:set_local_scale(1,1,1);
	end

	this.parentCopy = this.ui:get_child_by_name("guide_camera/panel_copy")
	-- 检查是否需要显示遮罩
	this.parentMask = this.ui:get_child_by_name("guide_camera/panel_mask")
	this.spMask = ngui.find_sprite(this.ui, "guide_camera/panel_mask/mark")
	this.node_item = this.ui:get_child_by_name("panel_item")

	this.spMask:set_on_ngui_click("GuideUI.OnClickMask")
end


--加载UI数据
function GuideUI.LoadDataUi()
	this.loadedData = true

	-- 禁止scrollview滚动
	if type(this.info.scroll_path) == "string" then
		this.scrollView = ngui.find_scroll_view(Root.get_root_ui(), this.info.scroll_path)

		if this.scrollView then
			this.scrollView:set_enable(false)
		else
			this.enchanceScrollView = ngui.find_enchance_scroll_view(Root.get_root_ui(), this.info.scroll_path);
			if this.enchanceScrollView then
				this.enchanceScrollView:set_enable_drag(false)
			end
		end
		if not this.scrollView and not this.enchanceScrollView then
			OutGuideLog("新手引导未找到scroll_view：" .. this.info.scroll_path, true)	
		end
	end
	
	-- 检查是否显示文本
	if this.info.have_txt > 0 then
		local labTxt = ngui.find_label(this.item_text, "lab")
		labTxt:set_text(this.GetFormatContent(this.info.popui_txt))

		this.item_text:set_active(true)
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.GuideSlide);
		-- 文本显示位置have_txt 0不显示 1-6对应不同位置点
		local nodeText = this.node_item:get_child_by_name(tostring(this.info.have_txt))
		if nodeText then
			this.item_text:set_parent(nodeText)
			this.item_text:set_local_position(0,0,0)
		end
	end

	if this.info.other_path and this.info.other_path ~= 0 then
		this.othersGo = {}
		if type(this.info.other_path) == "table" then
			for i, v in pairs(this.info.other_path) do
				local go = asset_game_object.find(v)
				if go then
					table.insert(this.othersGo, go)
				else
					OutGuideLog("新手引导未找到：" .. "id:" .. GuideManager.GetIdStepStr() .. " " .. v, true);
				end
			end
		elseif type(this.info.other_path) == "string" then
			local go = asset_game_object.find(this.info.other_path)
			if go then
				table.insert(this.othersGo, go)
			else
				OutGuideLog("新手引导未找到：" .. "id:" .. GuideManager.GetIdStepStr() .. " " .. this.info.other_path, true);
			end
		end
		-- 设置对象到guide
		for i, v in pairs(this.othersGo) do
			v:set_layer(PublicStruct.UnityLayer.guide, false)
		end
	end
	
	-- 配置了引导对象
	if this.selectGo then
		this.ownUiName = this.GetOwnUiName();
		-- 被替换过的方法，取原来的方法
		local find_button_func = old_ngui_button or ngui.find_button
		
		-- 有遮罩的情况取选中对象的拷贝
		if this.info.mask_type ~= 0 then
			if this.info.mask_type ~= -1 then
				if this.clickGo then
					-- 设置选中对象到guide层
					this.clickGo:set_layer(PublicStruct.UnityLayer.guide, false)
				else
					-- 设置选中对象到guide层
					this.selectGo:set_layer(PublicStruct.UnityLayer.guide, false)
				end
			end

			if not _ENABLE_TRANSPARENT_MASK then
				this.copy = this.selectGo:clone()
				if this.copy == nil then
					OutGuideLog("新手引导克隆ui失败：" .. tostring(this.info.ui_path), true);
				end
				-- 按钮去掉box_collider会自动变成失效状态，所以没去掉，事件是克隆过来的
				local btn = find_button_func(this.copy,this.copy:get_name() or "")
				if btn then
				-- 非按钮对象去掉box_collider，事件响应是selectGo的
					this.copy:set_button_script_enable(false)
					this.copy:set_collider_enable(false)
				else
					this.copy:set_collider_enable(false)
				end
				
				--
				this.copy:set_parent(this.parentCopy)
				this.copy:set_active(false)
				-- this.copy:set_active(true)

				this.copyPosTimer = timer.create("GuideUI.CheckCopyPosCallback", 100, 20)
			end			
			
			-- 临时增加一个定时器刷新层级，避免被wrapcontent重置
			if this.info.mask_type ~= -1 then
				this.layerTimer = timer.create("GuideUI.CheckLayerCallback", 100, 50) 
			end
		end

		-- 设置点击事件拦截
		if this.info.cmd == "ui_click" then
			-- 有单独指定的点击对象
			-- this.clickGo = this.GetSelectGameObject(this.info.click_path)
			if this.clickGo then
				this.clickGo:set_on_click("GuideUI.OnClickSelect")
				local btn = find_button_func(this.clickGo, this.clickGo:get_name() or "")
				if btn then
					this.isBtnClick = true
				end
			else
				this.selectGo:set_on_click("GuideUI.OnClickSelect")
				local btn = find_button_func(this.selectGo, this.selectGo:get_name() or "")
				if btn then
					this.isBtnClick = true
				end
			end
		end

		if this.info.ui_effect_id and this.info.ui_effect_id > 0 then
			this.effect = EffectManager.createEffect(this.info.ui_effect_id)
			if this.copy then
				this.effect:set_parent(this.copy)
				this.effect:set_local_position(0,0,0)
				this.effect:set_local_scale(1,1,1)
			else
				this.effect:set_parent(this.selectGo)
				this.effect:set_local_position(0,0,0)
				this.effect:set_local_scale(1,1,1)
			end
		end


		-- 显示箭头,位置由click object得到
		if this.info.have_arrow > 0 then
			local x, y, z = 0, 0, 0
			if this.copy then
				x, y, z = this.copy:get_local_position()
			else
				x, y, z = this.selectGo:get_local_position()
			end

			if GuideManager._expedition_trial_fix then
				if this.selectGo then
					x, y, z = this.selectGo:get_local_position()
					y = y + 180
				end
			end

			this.item_hand:set_active(true)
			this.item_hand:set_local_position(x,y,z)

			local hand_left = this.item_hand:get_child_by_name("hand_left")
			local hand_right = this.item_hand:get_child_by_name("hand_right")
			local hand_down = this.item_hand:get_child_by_name("hand_down")
			local hand_top = this.item_hand:get_child_by_name("hand_top")
			--1左 2右 3上 4下
			if this.info.have_arrow == 1 then
				hand_left:set_active(true)
				hand_right:set_active(false)
				hand_down:set_active(false)
				hand_top:set_active(false)
			elseif this.info.have_arrow == 2 then
				hand_left:set_active(false)
				hand_right:set_active(true)
				hand_down:set_active(false)
				hand_top:set_active(false)
			elseif this.info.have_arrow == 3 then
				hand_left:set_active(false)
				hand_right:set_active(false)
				hand_down:set_active(true)
				hand_top:set_active(false)
			elseif this.info.have_arrow == 4 then
				hand_left:set_active(false)
				hand_right:set_active(false)
				hand_down:set_active(false)
				hand_top:set_active(true)
			end
		end
	end
end

function GuideUI.IsSelectGoInactive()
	if this.selectGo then
		return this.selectGo:get_active_inhierarchy();
	end
	return true;
end

--点击选择对象
function GuideUI.OnClickSelect()
	-- 播放按钮音效（覆盖了MyButton的点击事件）
	if this.isBtnClick then
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn);
	end

	-- 没有等待函数，立即执行下一步
	if this.info.wait_fun == 0 then
		-- GuideManager.DoNextGuideStep()
		TimerManager.Add(GuideManager.DoNextGuideStep, 30, 1)

	-- 打点记录立即检查
	else
		GuideManager.CheckGuideKeyPoint()
	end
end

--点击背景遮罩
function GuideUI.OnClickMask()
	-- if this.info and this.info.have_skip == 1 then
	-- 	local cbfunc = function ()
	-- 		--直接通知服务器打点完成
	-- 		GuideManager.UpdateGuideKeyPoint(true);
	-- 		GuideManager.EndGuide(true)
	-- 	end
	-- 	HintUI.SetGuideMode()
	-- 	HintUI.SetAndShow(EHintUiType.two, "是否要跳过引导？", {str="是", func=cbfunc}, {str="否"});
	-- end

	if this.info then
		this.ShowMissMaskFx()
	end

	if this.timeRecord == nil then
		this.timeRecord = system.time()
	end
end

function GuideUI.HideMissMaskFx()
	if app.get_real_time() - this.clickMaskTime < 1 then
		TimerManager.Add(this.HideMissMaskFx, 1000)
	else
		-- this.openMissMask = false
		-- if this.item_mask then
		-- 	this.item_mask:set_active(false)
		-- end

		if this.item_mask then
			local tweenFunc = function()
				this.openMissMask = false
				if this.item_mask then
					this.item_mask:set_active(false)
				end
			end

			local startAlpha = 1
			local endAlpha = 0.1
			local duration = 0.5

			local sp1 = ngui.find_sprite(this.item_mask, "sp1")
			local sp2 = ngui.find_sprite(this.item_mask, "sp2")
			local sp3 = ngui.find_sprite(this.item_mask, "sp3")
			local sp4 = ngui.find_sprite(this.item_mask, "sp4")
	
			sp1:set_color(1,1,1,startAlpha)
			sp2:set_color(1,1,1,startAlpha)
			sp3:set_color(1,1,1,startAlpha)
			sp4:set_color(1,1,1,startAlpha)
	
			Tween.addTween(sp1,duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,tweenFunc)
			Tween.addTween(sp2,duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,nil)
			Tween.addTween(sp3,duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,nil)
			Tween.addTween(sp4,duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,nil)
		end
	end
end

function GuideUI.ShowMissMaskFx()
	if this.copy == nil then return end
	if this.item_mask == nil then return end

	--打开渐变背景
	this.clickMaskTime = app.get_real_time()
	--打开渐变背景
	if not this.openMissMask then
		Tween.removeTween(this.item_mask)

		this.openMissMask = true

		this.item_mask:set_active(true)
		local x,y,z = 0,0,0
		if this.item_hand:get_active() then
			x,y,z = this.item_hand:get_local_position()
		else
			x,y,z = this.copy:get_local_position()
		end

		this.item_mask:set_local_position(x,y,z)

		--停顿1s退出
		local tweenFunc = function()
			TimerManager.Add(this.HideMissMaskFx, 800)
		end

		local startAlpha = 0.1
		local endAlpha = 1
		local duration = 0.6

		local sp1 = ngui.find_sprite(this.item_mask, "sp1")
		local sp2 = ngui.find_sprite(this.item_mask, "sp2")
		local sp3 = ngui.find_sprite(this.item_mask, "sp3")
		local sp4 = ngui.find_sprite(this.item_mask, "sp4")

		sp1:set_color(1,1,1,startAlpha)
		sp2:set_color(1,1,1,startAlpha)
		sp3:set_color(1,1,1,startAlpha)
		sp4:set_color(1,1,1,startAlpha)

		Tween.addTween(sp1,duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,tweenFunc)
		Tween.addTween(sp2,duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,nil)
		Tween.addTween(sp3,duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,nil)
		Tween.addTween(sp4,duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,nil)
	end

	local fxObj = this.item_mask:get_child_by_name("fx_xinshou_anniu_1")
	if fxObj then
		fxObj:set_active(false)
		fxObj:set_active(true)
	end
end

--显示UI
function GuideUI.Show()
	if this.ui == nil then
		return 
	end
	if this.opened then
		this.ui:set_active(true)
	else
		this.ui:set_active(false)
	end

	NoticeManager.Notice(ENUM.NoticeType.GuideCameraChange, true)
end

--隐藏UI
function GuideUI.Hide()
	if this.ui == nil then
        return 
    end
	this.ui:set_active(false)

	NoticeManager.Notice(ENUM.NoticeType.GuideCameraChange, false)
end

function GuideUI.IsShow()
	if this.ui == nil then
		return false
	end
	return this.ui:get_active()
end

function GuideUI.ClearData()
	-- Root.DelUpdate(this.Update)

	g_GuideLockUI.Hide()

	this.Hide()

    ------------------------- 还原layer层级 -----------------------
    if this.selectGo then
    	-- 还原到ngui层
    	this.selectGo:set_layer(PublicStruct.UnityLayer.ngui, false)
    	this.selectGo:set_on_click("")
    	this.selectGo = nil

	    this.isBtnClick = false
    end

    if this.clickGo then
		this.clickGo:set_layer(PublicStruct.UnityLayer.ngui, false)
		this.clickGo:set_on_click("")
		this.clickGo = nil
	end

	-- 隐藏拷贝对象
	if this.copy then
    	this.copy:set_active(false)
    	this.copy = nil
    end

    if this.effect then
    	this.effect:Destroy();
    	this.effect = nil
    end

    if this.othersGo then
    	-- 还原到ngui层
		for i, v in pairs(this.othersGo) do
			v:set_layer(PublicStruct.UnityLayer.ngui, false)
		end
		this.othersGo = nil
    end


    ------------------------- 重置组件 -----------------------
    if this.item_hand then
    	this.item_hand:set_active(false)
    end
    if this.item_text then
    	this.item_text:set_active(false)
    end
	if this.item_mask then
		this.item_mask:set_active(false)
	end

	if this.item_float then
		this.item_float:DestroyUi()
		this.item_float = nil
	end

    ------------------------- 重置数据 -----------------------
    if this.checkTimer then
    	timer.stop(this.checkTimer)
    	this.checkTimer = nil
    end
	if this.waitTimer then
    	timer.stop(this.waitTimer)
    	this.waitTimer = nil
    end
	if this.layerTimer then
    	timer.stop(this.layerTimer)
    	this.layerTimer = nil
    end
    if this.copyPosTimer then
    	timer.stop(this.copyPosTimer)
    	this.copyPosTimer = nil
    end
    if this.isInactiveTimer then
    	timer.stop(this.isInactiveTimer)
    	this.isInactiveTimer = nil
    end

	if this.scrollView then
		this.scrollView:set_enable(true)
		this.scrollView = nil
	end
	if this.enchanceScrollView then
		this.enchanceScrollView:set_enable_drag(true)
		this.enchanceScrollView = nil
	end

	this.openMissMask = false
	this.loadedData = false
	this.layerCount = 0
	this.timeRecord = nil
	
	this.info = nil
end

--释放界面
function GuideUI.Destroy()
	this.Close()

	this.UnRegistFunc()

	this.loadedAsset = false

	this.Hide()

	if this.ui then
    	this.ui = nil

    	PublicFunc.ClearUserDataRef(this)
    end
end

-- UI动画结束回调
function GuideUI.OnUiAniEnd(obj, value)
	if _ENABLE_UI_ANI_FIXED_TIME then return end
	if not GuideManager.IsGuideRuning() then return end
	if this.info == nil or this.info.have_ui_ani ~= 1 then return end

	value = value or ""
	local expect_value = (this.info.ani_cb_val ~= 0 and tostring(this.info.ani_cb_val) or "")
	if value == expect_value then
		this.CallLoadDataUi()
	end
end
