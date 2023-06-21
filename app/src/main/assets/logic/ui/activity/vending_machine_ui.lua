VendingMachineUI = Class("VendingMachineUI", UiBaseClass);

local _UIText = {
	[1] = "活动倒计时:%s";
	[2] = "恭喜[FFF000FF]%s[-]获得";
	[3] = "钻石不足";
	[4] = "好感度达到[FFF000FF]%s-%s[-],可以获得额外次数";
}

local res = "assetbundles/prefabs/ui/award/ui_1146_award.assetbundle";

function VendingMachineUI:Init(data)
    self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function VendingMachineUI:InitData(data)
    UiBaseClass.InitData(self, data);    
    self.m_activity_id = ENUM.Activity.activityType_niudan_hunxia;
end

function VendingMachineUI:RestartData(data)
	local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_vending_machine)
	self.endTime = activityTime and activityTime.e_time or 0
	self.buyRecords = g_dataCenter.activityReward:GetVendingMachineNewRecords()
	self.queueRecords = table.copyarray(self.buyRecords)
	
	self.buyTimes = g_dataCenter.activityReward:GetVendingMachineBuyTimes()
	self.buyMaxTimes = g_dataCenter.activityReward:GetVendingMachineMaxTimes()
	if not g_dataCenter.activityReward:IsInitVendingMachine() then
		msg_activity.cg_vending_machine_get_state()
		msg_activity.cg_vending_machine_get_buy_record()
	end
end

function VendingMachineUI:DestroyUi()
	if self.labLeftGo1 then
		Tween.removeTween(self.labLeftGo1)
		self.labLeftGo1 = nil
	end
	if self.labLeftGo2 then
		Tween.removeTween(self.labLeftGo2)
		self.labLeftGo2 = nil
	end
	
	if self.labRightGo1 then
		Tween.removeTween(self.labRightGo1)
		self.labRightGo1 = nil
	end
	if self.labRightGo2 then
		Tween.removeTween(self.labRightGo2)
		self.labRightGo2 = nil
	end

	self.buyRecords = nil
	self.queueRecords = nil
	self.buyMaxTimes = nil
	self.buyTimes = nil
	self.pauseQuery = nil
	self.playingOpen = nil
	self.loadSuccessRes = nil
	self:StopQuery()
	self:StopCountDown()
	UiBaseClass.DestroyUi(self);
end

function VendingMachineUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
	self.bindfunc["on_btn_put_coin"] = Utility.bind_callback(self, self.on_btn_put_coin);
	self.bindfunc["cb_play_open_drink"] = Utility.bind_callback(self, self.PlayOpenDrinkResult);
	self.bindfunc["gc_vending_machine_get_buy_record"] = Utility.bind_callback(self, self.gc_vending_machine_get_buy_record);
	self.bindfunc["gc_vending_machine_get_state"] = Utility.bind_callback(self, self.gc_vending_machine_get_state);
	self.bindfunc["gc_vending_machine_buy"] = Utility.bind_callback(self, self.gc_vending_machine_buy);
end

function VendingMachineUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_vending_machine_get_buy_record, self.bindfunc["gc_vending_machine_get_buy_record"])
    PublicFunc.msg_regist(msg_activity.gc_vending_machine_get_state, self.bindfunc["gc_vending_machine_get_state"])
    PublicFunc.msg_regist(msg_activity.gc_vending_machine_buy, self.bindfunc["gc_vending_machine_buy"])
end

function VendingMachineUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_vending_machine_get_buy_record, self.bindfunc["gc_vending_machine_get_buy_record"])
    PublicFunc.msg_unregist(msg_activity.gc_vending_machine_get_state, self.bindfunc["gc_vending_machine_get_state"])
    PublicFunc.msg_unregist(msg_activity.gc_vending_machine_buy, self.bindfunc["gc_vending_machine_buy"])
end

function VendingMachineUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("vending_machine_ui");
	
	local path = "center_other/animation/top"
	local btnClose = ngui.find_button(self.ui, path.."/btn_cha")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])

	self.labRedCrystal = ngui.find_label(self.ui, path.."/sp_gem_red/lab_num")
	self.labBlueCrystal = ngui.find_label(self.ui, path.."/sp_gem_bule/lab_num")

	local pnLeft = ngui.find_panel(self.ui, path.."/panel1")
	local pnRight = ngui.find_panel(self.ui, path.."/panel2")
	local _w,_h,cw,ch = pnLeft:get_size()
	self.cwPanelLeft = cw
	_w, _h, cw, ch 	= pnRight:get_size()
	self.cwPanelRight = cw

	self.labLeftGo1 = ngui.find_label(self.ui, path.."/panel1/lab1")
	self.labLeftGo2 = ngui.find_label(self.ui, path.."/panel1/lab2")
	self.labRightGo1 = ngui.find_label(self.ui, path.."/panel2/lab_time1")
	self.labRightGo2 = ngui.find_label(self.ui, path.."/panel2/lab_time2")
	self.xLabLeftGo = self.labLeftGo1:get_position()
	self.xLabRightGo = self.labRightGo1:get_position()
	local x, y, z = self.labLeftGo1:get_position()
	local w, h = self.labLeftGo1:get_size()
	self.leftValue = {x=x, y=y, z=z, w=w}
	x, y, z = self.labRightGo1:get_position()
	w, h = self.labRightGo1:get_size()
	self.rightValue = {x=x, y=y, z=z, w=w}

	path = "center_other/animation/right"
	self.btnPutCoin = ngui.find_button(self.ui, path.."/btn_yellow")
	self.btnPutCoin:set_on_click(self.bindfunc["on_btn_put_coin"])
	self.labCountTips = ngui.find_label(self.ui, path.."/lab_feel")
	self.labMaxNoTimes = ngui.find_label(self.ui, path.."/txt_hao")
	self.nodeMaxNumber = self.ui:get_child_by_name(path.."/cont")
	self.labMaxNumber = ngui.find_label(self.nodeMaxNumber, "lab_num")
	self.nodeVipInfo = self.ui:get_child_by_name(path.."/sp_art_font")
	self.nodeBuyInfo = self.ui:get_child_by_name(path.."/sp_bk1")
	self.nodeMaxNoInfo = self.ui:get_child_by_name(path.."/sp_bk2")
	self.labVipLevel = ngui.find_label(self.nodeVipInfo, "lab_v")
	self.labVipLevelStar = ngui.find_label(self.nodeVipInfo, "lab_v2")
	self.labBuyCost = ngui.find_label(self.nodeBuyInfo, "lab_num")
	self.buyRecordsInfo = {}
	self.indexRecord = 0

	self.fxPutCoin = self.ui:get_child_by_name("center_other/animation/fx_ui_1132_coin")
	self.fxGetDrink = self.ui:get_child_by_name("center_other/animation/fx_ui_1132_yinliao")
	self.fxPutCoin:set_active(false)
	self.fxGetDrink:set_active(false)

	self:InitContRecords()

	self:UpdateUi()

	self:StartQuery()
	self:StartCountDown()
	self:PlayLeftLoopGo()
	self:PlayRightLoopGo()
end

function VendingMachineUI:InitContRecords()
	if self.ui == nil then return end

	for i=1, 4 do
		local buyInfo = {}
		buyInfo.self = self.ui:get_child_by_name("list"..i)
		buyInfo.labName = ngui.find_label(buyInfo.self, "lab_paiming")
		buyInfo.labNumber = ngui.find_label(buyInfo.self, "lab_num")
		local x, y, z = buyInfo.self:get_local_position()
		buyInfo.pos = {x,y,z}
		self.buyRecordsInfo[i] = buyInfo
	end

	for i, v in ipairs(self.queueRecords) do
		self.indexRecord = self.indexRecord + 1
	end

	local offset = 3 - #self.queueRecords
	for i, v in ipairs(self.buyRecordsInfo) do
		if i > offset then
			local record = self.queueRecords[i - offset]
			if record then
				v.self:set_active(true)
				v.labName:set_text(string.format(_UIText[2], record.name))
				v.labNumber:set_text(tostring(record.obtainRedCrystal))
			end
		else
			v.self:set_active(false)
		end
	end
end

function VendingMachineUI:UpdateUi()
	if self.ui == nil then return end

	local config = ConfigManager.Get(EConfigIndex.t_activity_play, ENUM.Activity.activityType_vending_machine)
	self.labCountTips:set_text(tostring(config.activity_info))

	local nextTimes = self.buyTimes + 1
	local need_vip = g_dataCenter.activityReward:GetVendingMachineNeedVip(nextTimes)
	if need_vip then
		self.nodeMaxNumber:set_active(true)
		self.nodeBuyInfo:set_active(true)
		self.nodeMaxNoInfo:set_active(false)
		self.btnPutCoin:set_active(true)
		self.labMaxNoTimes:set_active(false)

		if need_vip > 0 then
			self.nodeVipInfo:set_active(true)
			local vip_config = ConfigManager.Get(EConfigIndex.t_vip_data, need_vip)
			self.labVipLevel:set_text(tostring(vip_config.level))
			self.labVipLevelStar:set_text("-"..tostring(vip_config.level_star))
		else
			self.nodeVipInfo:set_active(false)
		end

		local config = ConfigManager.Get(EConfigIndex.t_vending_machine, nextTimes)
		if config == nil then
            app.log("贩卖机抽取消耗id=["..tostring(nextTimes).."]配置未找到，请检查！")
			return
		end
		self.labBuyCost:set_text(tostring(config.cost_num))
		if config.cost_num > g_dataCenter.player.crystal then
			PublicFunc.SetUILabelRed(self.labBuyCost)
		else
			PublicFunc.SetUiSpriteColor(self.labBuyCost, 0, 255/255, 115/255, 1)
		end

		self.labMaxNumber:set_text(tostring(config.max_num))

	else
		self.nodeVipInfo:set_active(false)
		self.nodeMaxNumber:set_active(false)
		self.nodeBuyInfo:set_active(false)
		self.nodeMaxNoInfo:set_active(true)
		self.nodeVipInfo:set_active(false)
		self.btnPutCoin:set_active(false)
		self.labMaxNoTimes:set_active(true)
	end

	self.labRedCrystal:set_text(tostring(g_dataCenter.player.red_crystal))
	self.labBlueCrystal:set_text(tostring(g_dataCenter.player.crystal))
end

function VendingMachineUI:UpdateCountDown()
	if self.ui == nil then return end

	local sec = self.endTime - system.time()
	if sec >= 0 then
		local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(sec)
		local timeStr = tostring(day) .. "天" 
			.. string.format("%02d:", hour) 
			.. string.format("%02d:", min) 
			.. string.format("%02d", sec)
		self.labRightGo1:set_text(string.format(_UIText[1], timeStr))
		self.labRightGo2:set_text(string.format(_UIText[1], timeStr))
	else
		self.labRightGo1:set_text(string.format(_UIText[1], "0天00:00:00"))
		self.labRightGo2:set_text(string.format(_UIText[1], "0天00:00:00"))
		self:StopCountDown()
	end
end

function VendingMachineUI:PlayLeftLoopGo()
	Tween.removeTween(self.labLeftGo1)
	Tween.removeTween(self.labLeftGo2)

	local value = self.leftValue
	local duration1 = value.w / 25
	local duration2 = (value.w + 100) / 25
	self.labLeftGo1:set_position(value.x, value.y, value.z)
	self.labLeftGo2:set_position(value.x + value.w + 100, value.y, value.z)

	local finishFunc = function()
		self:PlayLeftLoopGo()
	end
	Tween.addTween(self.labLeftGo1, duration1, {position={value.x - value.w, value.y, value.z}}, nil, 0, nil, nil, nil)
	Tween.addTween(self.labLeftGo2, duration2, {position={value.x, value.y, value.z}}, nil, 0, nil, nil, finishFunc)
end

function VendingMachineUI:PlayRightLoopGo()
	Tween.removeTween(self.labRightGo1)
	Tween.removeTween(self.labRightGo2)

	local value = self.rightValue
	local duration1 = value.w / 25
	local duration2 = (value.w + 100) / 25
	self.labRightGo1:set_position(value.x, value.y, value.z)
	self.labRightGo2:set_position(value.x + value.w + 100, value.y, value.z)

	local finishFunc = function()
		self:PlayRightLoopGo()
	end
	Tween.addTween(self.labRightGo1, duration1, {position={value.x - value.w, value.y, value.z}}, nil, 0, nil, nil, nil)
	Tween.addTween(self.labRightGo2, duration2, {position={value.x, value.y, value.z}}, nil, 0, nil, nil, finishFunc)
end

function VendingMachineUI:PlayNewRecords()
	if self.ui == nil then return end
	if self.pauseQuery then return end

	if #self.queueRecords > self.indexRecord or #self.queueRecords > 3 then 
		self:PlayNextRecords()
	end
end

function VendingMachineUI:PlayNextRecords()
	local contArray = {}
	if #self.queueRecords > self.indexRecord then
		self.indexRecord = self.indexRecord + 1
		local lastIndex = self.indexRecord
		local data = self.queueRecords[lastIndex]
		for i, v in ipairs(self.buyRecordsInfo) do
			if i <= 4 - lastIndex then
				v.self:set_active(false)
			else
				local record = self.queueRecords[i - 4 + lastIndex]
				v.labName:set_text(string.format(_UIText[2],record.name))
				v.labNumber:set_text(tostring(record.obtainRedCrystal))
				v.self:set_active(true)
				v.self:set_local_position(v.pos[1],v.pos[2],v.pos[3])
				table.insert(contArray, v)
			end
		end
	else
		self.indexRecord = self.indexRecord + 1
		for i, v in ipairs(self.buyRecordsInfo) do
			local record = self.queueRecords[i]
			v.labName:set_text(string.format(_UIText[2],record.name))
			v.labNumber:set_text(tostring(record.obtainRedCrystal))
			v.self:set_active(true)
			v.self:set_local_position(v.pos[1],v.pos[2],v.pos[3])
			table.insert(contArray, v)
		end

		table.remove(self.queueRecords, 1)
	end

	for i, v in ipairs(contArray) do
		local cbfunc = nil
		if i == #contArray then
			cbfunc = function() self:PlayNewRecords() end
		end
		Tween.addTween(v.self, 0.5, {local_position={v.pos[1], v.pos[2]-25, v.pos[3]}, nil, 0, nil, nil, cbfunc})
	end
end

function VendingMachineUI:PlayPutCoin()
	if self.fxPutCoin then
		self.fxPutCoin:set_active(false)
		self.fxPutCoin:set_active(true)
		-- 投硬币
		AudioManager.PlayUiAudio(81200231)
	end
end

function VendingMachineUI:PlayGetDrink()
	if self.fxGetDrink then
		self.fxGetDrink:set_active(false)
		self.fxGetDrink:set_active(true)

		self.playingOpen = true

		-- 结束时播放第三个动画：打开饮料
		TimerManager.Add(self.PlayOpenDrink, 800, 1, self)
	end
end

function VendingMachineUI:PlayOpenDrink()
	uiManager:PushUi(EUI.VendingMachineCansUI, self.bindfunc["cb_play_open_drink"])
end

function VendingMachineUI:PlayOpenDrinkResult()
	uiManager:PushUi(EUI.VendingMachineSuccessUI, self.redCrystalNum)

	self.playingOpen = false
	self.pauseQuery = false
	self:PlayNewRecords()
	self:StartQuery()

	self.buyTimes = g_dataCenter.activityReward:GetVendingMachineBuyTimes()
	self:UpdateUi()
end

function VendingMachineUI:StartCountDown()
	if self.endTime > system.time() then
		TimerManager.Add(self.UpdateCountDown, 1000, -1, self)
	else
		self:UpdateCountDown()
	end
end

function VendingMachineUI:StopCountDown()
	TimerManager.Remove(self.UpdateCountDown)
end

function VendingMachineUI:StartQuery()
	TimerManager.Add(self.SendQueryMsg, 10000, -1, self)
end

function VendingMachineUI:StopQuery()
	TimerManager.Remove(self.SendQueryMsg)
end

function VendingMachineUI:SendQueryMsg()
	msg_activity.cg_vending_machine_get_buy_record()
end

function VendingMachineUI:on_btn_close( t )
	if self.playingOpen then return end
	uiManager:PopUi()
end

function VendingMachineUI:on_btn_put_coin( t )
	if self.pauseQuery == true then return end
	
	local nextTimes = self.buyTimes + 1
	local need_vip = g_dataCenter.activityReward:GetVendingMachineNeedVip(nextTimes)
	if need_vip ~= nil then
		if need_vip > g_dataCenter.player.vip then
			local vip_config = ConfigManager.Get(EConfigIndex.t_vip_data, need_vip)
			FloatTip.Float(string.format(_UIText[4], vip_config.level, vip_config.level_star))
		else
			local config = ConfigManager.Get(EConfigIndex.t_vending_machine, self.buyTimes+1)
			if config == nil then
				app.log("贩卖机抽取消耗id=["..tostring(self.buyTimes+1).."]配置未找到，请检查！")
				return
			end
			if config.cost_num > g_dataCenter.player.crystal then
				FloatTip.Float(_UIText[3])
				return 
			end
	
			self:PlayPutCoin()
			self:StopQuery()
			self.pauseQuery = true
	
			--延迟发送消息，调整动画衔接时间
			TimerManager.Add(function()
				msg_activity.cg_vending_machine_buy()
			end, 1000, 1)
		end
	end
end

function VendingMachineUI:gc_vending_machine_get_state(hasBuyTimes)
	self.buyTimes = g_dataCenter.activityReward:GetVendingMachineBuyTimes()
	self:UpdateUi()
end

function VendingMachineUI:gc_vending_machine_get_buy_record(records)
	self.buyRecords = g_dataCenter.activityReward:GetVendingMachineNewRecords()

	local lastTime = 0
	if #self.queueRecords > 0 then
		lastTime = tonumber(self.queueRecords[#self.queueRecords].time)
	end
	for i, v in ipairs(self.buyRecords) do
		if tonumber(v.time) > lastTime then
			table.insert(self.queueRecords, v)
		end
	end

	self:PlayNewRecords()
end

function VendingMachineUI:gc_vending_machine_buy(result, redCrystalNum, hasBuyTimes)
	if result == 0 then
		self.redCrystalNum = redCrystalNum
		self:PlayGetDrink()

		-- 提前预加载
		if not self.loadSuccessRes then
			self.loadSuccessRes = true
			UiBaseClass.PreLoadUIRes(VendingMachineSuccessUI, Root.empty_func)
		end
	else
		self.pauseQuery = false
	end
end