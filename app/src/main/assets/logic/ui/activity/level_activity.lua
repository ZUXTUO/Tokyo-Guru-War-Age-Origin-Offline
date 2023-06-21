LevelActivity = Class('LevelActivity',UiBaseClass)

local _UIText = {
    [1] = "[00FF00FF]%s[-]/%s",
    [2] = "%s",

    [3] = "防止[713908FF]敌人入侵[-]  即可获得[713908FF]大量金币[-]",
    [4] = "守卫[713908FF]笛口母女[-]  即可获得[713908FF]大量咖啡[-]",
    [5] = "驱逐[713908FF]小丑[-]  即可获得[713908FF]大量研究点[-]",
}

local _LevelDesc = {
    [MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang] = _UIText[3],
    [MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi] =_UIText[4],
    [MsgEnum.eactivity_time.eActivityTime_ClownPlan] = _UIText[5],
}

--重新开始
function LevelActivity:Restart(data)
    ----app.log("LevelActivity:Restart");
	--app.log("Restart data = "..tostring(data));
	--app.log("Restart curTab = "..tostring(LevelActivity.curTab));
	if data == nil then 
		self.openTab = LevelActivity.curTab or 1;
	else 
		self.openTab = data;
	end 

	if LevelActivity.allCf == nil then 
		LevelActivity.initAllCf();
	end
	self.activityData = {};
	for k,v in pairs(LevelActivity.allCf) do 
		local cfplayvs = ConfigManager.Get(EConfigIndex.t_play_vs_data,v.id);
		--if cfplayvs.open_level <= g_dataCenter.player.level then 
			v.open_level = cfplayvs.open_level;
			table.insert(self.activityData,v);
		--end
	end
	temp = {};
	for k,v in pairs(self.activityData) do 
		if v.id == MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang then 
			temp[1] = v;
		end
		if v.id == MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi then 
			temp[2] = v;
		end
		if v.id == MsgEnum.eactivity_time.eActivityTime_ClownPlan then 
			temp[3] = v;
		end
	end 
	self.activityData = temp;

	--新手引导定位指定功能按钮
    if GuideManager.IsGuideRuning() and GuideManager.GetGuideFunctionId() > 0 then
        local function_id = GuideManager.GetGuideFunctionId()
        for i, v in pairs(self.activityData) do
        	if v.id == function_id then
        		self.openTab = i
        		break;
        	end
        end
    end

	self.openTab = self.openTab or 1;
	if self.openTab > #self.activityData then 
		self.openTab = 1;
	end
	LevelActivity.curTab = self.openTab;

	LevelActivity.idToUiNode = {};
	LevelActivity.indexToId = {};
    UiBaseClass.Restart(self, data);
	--self.activityData = LevelActivity.allCf;
end

function LevelActivity:InitData(data)
    ----app.log("LevelActivity:InitData");
	--app.log("InitData data = "..tostring(data));
	--app.log("InitData curTab = "..tostring(LevelActivity.curTab));
	if data == nil then 
		self.openTab = LevelActivity.curTab or 1;
	else 
		self.openTab = data;
	end 
	if LevelActivity.allCf == nil then 
		LevelActivity.initAllCf();
	end
	self.activityData = {};
	local temp = {};
	local vipData = g_dataCenter.player:GetVipData();
	for k,v in pairs(LevelActivity.allCf) do 
		local cfplayvs = ConfigManager.Get(EConfigIndex.t_play_vs_data,v.id);
		v.open_level = cfplayvs.open_level;
		table.insert(self.activityData,v);
		if v.id == 60054001 then 
			v.relative = vipData.gsjj_cool_time;
			--app.log("高速狙击VIP冷却时间："..tostring(v.relative));
		end
		if v.id == MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang then 
			temp[1] = v;
		end
		if v.id == MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi then 
			temp[2] = v;
		end
		if v.id == MsgEnum.eactivity_time.eActivityTime_ClownPlan then 
			temp[3] = v;
		end
	end
	self.activityData = temp;
	self.openTab = self.openTab or 1;
	if self.openTab > #self.activityData then 
		self.openTab = 1;
	end
	LevelActivity.curTab = self.openTab;
    UiBaseClass.InitData(self, data);
	--self.activityData = LevelActivity.allCf;
end

function LevelActivity.initAllCf()
	local cfList = ConfigManager._GetConfigTable(EConfigIndex.t_activity_time);
	local allCf = {};
	for k,v in pairs_key(cfList) do 
		if v.open == 1 then 
			table.insert(allCf,v);
		end
	end
	LevelActivity.allCf = allCf;
end 

function LevelActivity:RegistFunc()
	----app.log("LevelActivity:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['initItem'] = Utility.bind_callback(self, self.initItem);
	self.bindfunc['onClickYeka'] = Utility.bind_callback(self, self.onClickYeka);
	self.bindfunc['on_toggle_change'] = Utility.bind_callback(self, self.on_toggle_change);
	self.bindfunc['on_enter_activity'] = Utility.bind_callback(self, self.on_enter_activity);
	self.bindfunc['on_difficult_selected'] = Utility.bind_callback(self, self.on_difficult_selected);
	self.bindfunc['to_sweep_activity'] = Utility.bind_callback(self, self.to_sweep_activity);
	self.bindfunc['onTimer'] = Utility.bind_callback(self, self.onTimer);
	self.bindfunc['serverSweepOver'] = Utility.bind_callback(self, self.serverSweepOver);
	--self.bindfunc['UpdateRedPoint'] = Utility.bind_callback(self, self.UpdateRedPoint);
end

function LevelActivity:InitUI(asset_obj)
	--app.log("LevelActivity:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('LevelActivity');
	self.vs = {};
	self.vs.panel = ngui.find_panel(self.ui,self.ui:get_name());
	self.vs.yeka1 = ngui.find_button(self.ui,"centre_other/animation/grid_yeka/yeka1");	
	self.vs.yeka2 = ngui.find_button(self.ui,"centre_other/animation/grid_yeka/yeka2");
	self.vs.yeka3 = ngui.find_button(self.ui,"centre_other/animation/grid_yeka/yeka3");
	self.vs.tg1 = ngui.find_toggle(self.ui,"centre_other/animation/grid_yeka/yeka1");	
	self.vs.tg2 = ngui.find_toggle(self.ui,"centre_other/animation/grid_yeka/yeka2");	
	self.vs.tg3 = ngui.find_toggle(self.ui,"centre_other/animation/grid_yeka/yeka3");	
	self.vs.yeka1:set_name("1");
	self.vs.yeka2:set_name("2");
	self.vs.yeka3:set_name("3");
	
	self.vs.panel1 = ngui.find_panel(self.ui,"centre_other/animation/panel_1");
	self.vs.panel2 = ngui.find_panel(self.ui,"centre_other/animation/panel_2");
	self.vs.panel3 = ngui.find_panel(self.ui,"centre_other/animation/panel_3");
	
	self.vs.texture1 = ngui.find_texture(self.ui,"centre_other/animation/panel_1/texture");
	self.vs.texture2 = ngui.find_texture(self.ui,"centre_other/animation/panel_2/texture");
	self.vs.texture3 = ngui.find_texture(self.ui,"centre_other/animation/panel_3/texture");
	
	self.vs.mohu1 = ngui.find_texture(self.ui,"centre_other/animation/panel_1/texture2");
	self.vs.mohu2 = ngui.find_texture(self.ui,"centre_other/animation/panel_2/texture2");
	self.vs.mohu3 = ngui.find_texture(self.ui,"centre_other/animation/panel_3/texture2");
	self.vs.mohuShuangbei1 = ngui.find_texture(self.ui,"centre_other/animation/panel_1/texture3");
	self.vs.mohuShuangbei2 = ngui.find_texture(self.ui,"centre_other/animation/panel_2/texture3");
	self.vs.mohuShuangbei3 = ngui.find_texture(self.ui,"centre_other/animation/panel_3/texture3");
	self.vs.mohuClock1 = ngui.find_texture(self.ui,"centre_other/animation/panel_1/texture4");
	self.vs.mohuClock2 = ngui.find_texture(self.ui,"centre_other/animation/panel_2/texture4");
	self.vs.mohuClock3 = ngui.find_texture(self.ui,"centre_other/animation/panel_3/texture4");
	
	self:initCard(self.vs.texture1:get_game_object(),self.vs.yeka1:get_game_object(),1);
	self:initCard(self.vs.texture2:get_game_object(),self.vs.yeka2:get_game_object(),2);
	self:initCard(self.vs.texture3:get_game_object(),self.vs.yeka3:get_game_object(),3);
	
	self.vs.yeka1:set_on_ngui_click(self.bindfunc["on_toggle_change"]);	
	self.vs.yeka2:set_on_ngui_click(self.bindfunc["on_toggle_change"]);
	self.vs.yeka3:set_on_ngui_click(self.bindfunc["on_toggle_change"]);
	self.vs.cishu = ngui.find_label(self.ui,"")
    local di2Path = "centre_other/animation/"

	self.vs.rewardPos1 = self.ui:get_child_by_name(di2Path .. "cont/new_small_card_item1");
	self.vs.rewardPos2 = self.ui:get_child_by_name(di2Path .. "cont/new_small_card_item2");
	self.vs.rewardPos3 = self.ui:get_child_by_name(di2Path .. "cont/new_small_card_item3");
	self.vs.rewardPos4 = self.ui:get_child_by_name(di2Path .. "cont/new_small_card_item4");

	self.vs.timesRemain = ngui.find_label(self.ui, di2Path .. "cont/txt_cishu/lab");
	self.vs.btnEnter = ngui.find_button(self.ui, di2Path .. "cont/btn");
	self.vs.btnEnter:set_on_click(self.bindfunc['on_enter_activity']);

    --[[self.vs.levelFont = {
        [MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi] = ngui.find_sprite(self.ui, di2Path .. "texture/sp_art_font1"),
        [MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang] = ngui.find_sprite(self.ui, di2Path .. "texture/sp_art_font2"),
        [MsgEnum.eactivity_time.eActivityTime_ClownPlan] = ngui.find_sprite(self.ui, di2Path .. "texture/sp_art_font3"),
    }]]
    --
	self:UpdateUi();
end

function LevelActivity.GetUiNode(id)
	return LevelActivity.idToUiNode[id];
end

function LevelActivity:initItem(obj,b,real_id)
	local index = math.abs(real_id)+1;
	self.activityItemList = self.activityItemList or {};
	self.activityItemList[index] = self.activityItemList[index] or self:createActivityItem(obj,index);
	self.activityItemList[index]:setData(self.activityData[index],index,self.openTab);
end 

function LevelActivity:initCard(obj,yekaObj,index)
	self.vs["cardArtFont"..tostring(index)] = ngui.find_sprite(obj,"sp_art_font1");
	self.vs["cardLab"..tostring(index)] = ngui.find_label(obj,"lab");
	self.vs["cardLabTime"..tostring(index)] = ngui.find_label(obj,"lab_time");
	self.vs["cardLabDouble"..tostring(index)] = ngui.find_label(obj,"lab_fanbei");
	self.vs["titleSelect"..tostring(index)] = ngui.find_label(yekaObj,"lab_xuanzhong");
	self.vs["title"..tostring(index)] = ngui.find_label(yekaObj,"lab_wei");
	self.vs["spDouble"..tostring(index)] = ngui.find_sprite(yekaObj,"sp_fanbei");
end 

function LevelActivity:onTimer()
	if self.vs.curLabTime ~= nil then 
		if self.timeFlagNum == nil then 
			--self.vs.downClockLabDesc:set_active(false); 
			self.vs.curLabTime:set_active(false);
			if self.timerId ~= nil then 
				timer.stop(self.timerId);	
				self.timerId = nil;
			end 
		else 
			--self.vs.downClockLabDesc:set_active(true); 
			self.vs.curLabTime:set_active(true);
			if self.timeFlagNum > system.time() then 
				local str = g_getTimeString(self.timeFlagNum - system.time());
				--app.log("玩法时间标志"..self.timeFlagNum.." | 服务器时间："..system.time());
				self.vs.curLabTime:set_text(string.format(_UIText[2], str))
			else 
				self.timeFlagNum = nil;
				--self.vs.downClockLabDesc:set_active(false); 
				self.vs.curLabTime:set_active(false);
				if self.timerId ~= nil then 
					timer.stop(self.timerId);	
					self.timerId = nil;
				end 
			end
		end
	end 
end 

function LevelActivity:on_toggle_change(para)
	--[[if type(para) == "table" then 
		app.log("on_toggle_change:"..table.tostring(para)); 
	else
		app.log("on_toggle_change:"..tostring(para)); 
	end ]]
    local name = para
    if type(para) == "table" then
        name = para.float_value
    end
	if name then 
		if self.isFirst ==nil then
            self.isFirst = true;
        else
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
        end
		--app.log("on_toggle_change" .. name);
		local data = self.activityData[tonumber(name)];
		if data == nil then 
			do return end;
		end 
		if data.open_level > g_dataCenter.player.level then 
			FloatTip.Float(tostring(data.open_level).."等级开启");
			self:on_toggle_change(LevelActivity.curTab or 1);
			self:SetCardData(1);
			self:SetCardData(2);
			self:SetCardData(3);
			do return end;
		else 
			LevelActivity.curTab = tonumber(name);
			self:SetCardData(1);
			self:SetCardData(2);
			self:SetCardData(3);
		end 
		self.curSelectData = data;
		--app.log("yeKadata"..table.tostring(data));
		for i = 1,3 do
			if i == tonumber(name) then
				self.vs["tg"..tostring(i)]:set_value(true);
				self.vs["panel"..tostring(i)]:set_depth(1704);
				self.vs["texture"..tostring(i)]:set_active(true);
				self.vs["mohu"..tostring(i)]:set_active(false);
				self.vs["mohuClock"..tostring(i)]:set_active(false);
				self.vs["mohuShuangbei"..tostring(i)]:set_active(false);
			else 
				self.vs["tg"..tostring(i)]:set_value(false);
				self.vs["panel"..tostring(i)]:set_depth(1703-math.abs(i-tonumber(name)));
				self.vs["texture"..tostring(i)]:set_active(false);
				self.vs["mohu"..tostring(i)]:set_active(true);
				self.vs["mohuClock"..tostring(i)]:set_active(false);
				self.vs["mohuShuangbei"..tostring(i)]:set_active(false);
			end
		end
		self.item1 = self.item1 or UiSmallItem:new({parent = self.vs.rewardPos1,is_enable_goods_tip = true});
		self.item2 = self.item2 or UiSmallItem:new({parent = self.vs.rewardPos2,is_enable_goods_tip = true});
		self.item3 = self.item3 or UiSmallItem:new({parent = self.vs.rewardPos3,is_enable_goods_tip = true});
		self.item4 = self.item4 or UiSmallItem:new({parent = self.vs.rewardPos4,is_enable_goods_tip = true});
		self.item1:SetData();
		self.item2:SetData();
		self.item3:SetData();
		self.item4:SetData();
		self.item1:Hide();
		self.item2:Hide();
		self.item3:Hide();
		self.item4:Hide();
		local itemList = data.award;
		
		self.dataCenter = g_dataCenter.activity[data.id]--MsgEnum.eactivity_time.
		local enterTimes,totalTimes = 0,0;
		if self.dataCenter.GetFightTimes ~= nil then 
			enterTimes,totalTimes = self.dataCenter:GetFightTimes();
		end
		self.enterTimes = enterTimes;
		self.totalTimes = totalTimes;

		if totalTimes - enterTimes <= 0 then 
			self.vs.timesRemain:set_text(string.format("[FF0000FF]%s[-]/%s", totalTimes - enterTimes, totalTimes));
		else
			self.vs.timesRemain:set_text(string.format("[00FF00FF]%s[-]/%s", totalTimes - enterTimes, totalTimes));
		end 
		
		
		for k,v in pairs(itemList) do 
			self["item"..tostring(k)]:Show();
			self["item"..tostring(k)]:SetDataNumber(tonumber(v),0);
			self["item"..tostring(k)]:SetNumberStr("");
		end
		local flagHelper = g_dataCenter.player:GetFlagHelper();
		--app.log("[][][][][][][]data.id = "..tostring(data.id));
		local timeStr = flagHelper:GetStringFlag(data.id);
		--app.log("[][][][][][][]TimeStr = "..tostring(timeStr));
		self.timeFlagNum = nil;
		if self.timerId ~= nil then 
			timer.stop(self.timerId);
			self.timerId = nil;
		end 
		if self.enterTimes < self.totalTimes and timeStr ~= nil then 
			self.timeFlagNum = tonumber(timeStr);
			if self.timeFlagNum == nil then 
				local a = string.split(timeStr,";");
				if a[2] ~= nil then 
					local b = string.split(a[2],"=");
					self.timeFlagNum = tonumber(b[2]);
				end 
			end 
			if self.timeFlagNum ~= nil then 
				self.timeFlagNum = self.timeFlagNum + data.relative;
				--app.log("取到的高速狙击VIP冷却时间："..tostring(data.relative));
				if self.timeFlagNum > system.time() then 
					local str = g_getTimeString(self.timeFlagNum - system.time());
					--app.log("玩法时间标志"..self.timeFlagNum.." | 服务器时间："..system.time());
					--self.vs.downClockLabDesc:set_active(true); 
					self.vs["cardLabTime"..tostring(name)]:set_active(true);
					self.vs["cardLabTime"..tostring(name)]:set_text(string.format(_UIText[2], str))
					self.vs.curLabTime = self.vs["cardLabTime"..tostring(name)];
					self.timerId = timer.create(self.bindfunc['onTimer'],1000,-1);
				else 
					self.timeFlagNum = nil;
					--self.vs.downClockLabDesc:set_active(false); 	
					self.vs["cardLabTime"..tostring(name)]:set_active(false);
			self.vs["cardLabTime"..tostring(name)]:set_text("0天00:00:00");
				end
			else
				--self.vs.downClockLabDesc:set_active(false); 	
				self.vs["cardLabTime"..tostring(name)]:set_active(false);
			self.vs["cardLabTime"..tostring(name)]:set_text("0天00:00:00");
			end 
		else
			--self.vs.downClockLabDesc:set_active(false); 
			self.vs["cardLabTime"..tostring(name)]:set_active(false);
			self.vs["cardLabTime"..tostring(name)]:set_text("0天00:00:00");
		end 
		if DifficultSelect.instance then 
			DifficultSelect.instance:changeChallengeTimes(self.enterTimes,self.totalTimes);
		end
		self:recheckTimeAndDouble();
		local navbar = uiManager:GetNavigationBarUi();
		-- 双倍
		if data.id == MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang then	
			if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_hight_sniper) then
			end
			uiManager:SetRuleId(EUI.LevelActivity, ENUM.ERuleDesType.GaoSuZuJi)	
			if navbar then
				navbar:setRuleId(ENUM.ERuleDesType.GaoSuZuJi)
			end
		elseif data.id == MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi then
			if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_defend) then
			end
			uiManager:SetRuleId(EUI.LevelActivity, ENUM.ERuleDesType.BaoWeiZhan)	
			if navbar then
				navbar:setRuleId(ENUM.ERuleDesType.BaoWeiZhan)
			end
		elseif data.id == MsgEnum.eactivity_time.eActivityTime_ClownPlan then
			if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_xiaochoujihua) then
			end
			uiManager:SetRuleId(EUI.LevelActivity, ENUM.ERuleDesType.ClownPlan)	
			if navbar then
				navbar:setRuleId(ENUM.ERuleDesType.ClownPlan)
			end
		end
	end
end 

function LevelActivity:recheckTimeAndDouble()
	for index = 1,3 do 
		if LevelActivity.curTab ~= index then 
			local data = self.activityData[index];
			if data.id == MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang then
				if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_hight_sniper) then
					self.vs["mohuShuangbei"..tostring(index)]:set_active(true);
				end
			elseif data.id == MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi then
				if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_defend) then
					self.vs["mohuShuangbei"..tostring(index)]:set_active(true);
				end
			elseif data.id == MsgEnum.eactivity_time.eActivityTime_ClownPlan then
				if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_xiaochoujihua) then
					self.vs["mohuShuangbei"..tostring(index)]:set_active(true);
				end
			end
			local flagHelper = g_dataCenter.player:GetFlagHelper();
			local timeStr = flagHelper:GetStringFlag(data.id);
			if timeStr ~= nil then 
				local timeFlagNum = tonumber(timeStr);
				if timeFlagNum == nil then 
					local a = string.split(timeStr,";");
					if a[2] ~= nil then 
						local b = string.split(a[2],"=");
						timeFlagNum = tonumber(b[2]);
					end 
				end 
				if timeFlagNum ~= nil then 
					timeFlagNum = timeFlagNum + data.relative;
					if timeFlagNum > system.time() then 
						self.vs["mohuClock"..tostring(index)]:set_active(true);
					else
						self.vs["mohuClock"..tostring(index)]:set_active(false);
					end
				else
					self.vs["mohuClock"..tostring(index)]:set_active(false);
				end
			else 
				self.vs["mohuClock"..tostring(index)]:set_active(false);
			end
		end 
	end
end 

function LevelActivity:SetCardData(index)
	local data = self.activityData[index];
	self.vs["title"..tostring(index)]:set_text(data.name);
	self.vs["titleSelect"..tostring(index)]:set_text(data.name);
	if data.open_level >= g_dataCenter.player.level then 
		self.vs["title"..tostring(index)]:set_color(0.776,0.776,0.776,1);
		self.vs["titleSelect"..tostring(index)]:set_color(0.776,0.776,0.776,1);
	else
		self.vs["title"..tostring(index)]:set_color(1,1,1,1);
		self.vs["titleSelect"..tostring(index)]:set_color(1,1,1,1);
	end 
	self.vs["spDouble"..tostring(index)]:set_active(false);
	self.vs["mohuShuangbei"..tostring(index)]:set_active(false);
	if data.open_level > g_dataCenter.player.level then 
		self.vs["cardLab"..tostring(index)]:set_text(tostring(_LevelDesc[data.id]));
	else 
		self.vs["cardLab"..tostring(index)]:set_text(tostring(_LevelDesc[data.id]));
	end 
	
	self.vs["cardLabDouble"..tostring(index)]:set_active(false);
	local des = "";
	-- 双倍
	if data.id == MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang then
		if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_hight_sniper) then
			if index == LevelActivity.curTab then 
				des = "今日[fed440]收益翻倍[-]";
				self.vs["spDouble"..tostring(index)]:set_active(true);
				self.vs["mohuShuangbei"..tostring(index)]:set_active(true);
			end 
		end
		if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_extra_times_hight_sniper) then
			if des == "" then
				des = des .. "高速狙击次数+" .. g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_hight_sniper);
			else
				des = des .. "\n高速狙击次数+" .. g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_hight_sniper);
			end
		end		
	elseif data.id == MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi then
		if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_defend) then
			if index == LevelActivity.curTab then 
				des = "今日[fed440]收益翻倍[-]";
				self.vs["spDouble"..tostring(index)]:set_active(true);
				self.vs["mohuShuangbei"..tostring(index)]:set_active(true);
			end 
		end
		if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_extra_times_baoweizhang) then
			if des == "" then
				des = des .. "保卫战次数+" .. g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_baoweizhang);
			else
				des = des .. "\n保卫战次数+" .. g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_baoweizhang);
			end
		end
	elseif data.id == MsgEnum.eactivity_time.eActivityTime_ClownPlan then
		if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_xiaochoujihua) then
			if index == LevelActivity.curTab then 
				des = "今日[fed440]收益翻倍[-]";
				self.vs["spDouble"..tostring(index)]:set_active(true);
				self.vs["mohuShuangbei"..tostring(index)]:set_active(true);
			end 
		end
		if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_extra_times_xiaochoujihua) then
			if des == "" then
				des = des .. "小丑计划次数+" .. g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_xiaochoujihua);
			else
				des = des .. "\n小丑计划次数+" .. g_dataCenter.activityReward:GetExtraTimesByActivityID(ENUM.Activity.activityType_extra_times_xiaochoujihua);
			end
		end
	end

	local dataCenter = g_dataCenter.activity[data.id]--MsgEnum.eactivity_time.
	local enterTimes,totalTimes = 0,0;
	if dataCenter.GetFightTimes ~= nil then 
		enterTimes,totalTimes = dataCenter:GetFightTimes();
	end
	self.enterTimes = enterTimes;
	self.totalTimes = totalTimes;
	
	local flagHelper = g_dataCenter.player:GetFlagHelper();
	--app.log("[][][][][][][]data.id = "..tostring(data.id));
	local timeStr = flagHelper:GetStringFlag(data.id);
	--app.log("[][][][][][][]TimeStr = "..tostring(timeStr));
	self.timeFlagNum = nil;
	if self.timerId ~= nil then 
		timer.stop(self.timerId);
		self.timerId = nil;
	end 
	if self.enterTimes < self.totalTimes and timeStr ~= nil then 
		self.timeFlagNum = tonumber(timeStr);
		if self.timeFlagNum == nil then 
			local a = string.split(timeStr,";");
			if a[2] ~= nil then 
				local b = string.split(a[2],"=");
				self.timeFlagNum = tonumber(b[2]);
			end 
		end 
		if self.timeFlagNum ~= nil then 
			self.timeFlagNum = self.timeFlagNum + data.relative;
			--app.log("取到的高速狙击VIP冷却时间："..tostring(data.relative));
			if self.timeFlagNum > system.time() then 
				local str = g_getTimeString(self.timeFlagNum - system.time());
				--app.log("玩法时间标志"..self.timeFlagNum.." | 服务器时间："..system.time());
				--self.vs.downClockLabDesc:set_active(true); 
				self.vs["cardLabTime"..tostring(index)]:set_active(true);
				self.vs["cardLabTime"..tostring(index)]:set_text(string.format(_UIText[2], str))
				--self.vs.curLabTime = self.vs["cardLabTime"..tostring(index)];
				self.timerId = timer.create(self.bindfunc['onTimer'],1000,-1);
			else 
				self.timeFlagNum = nil;
				--self.vs.downClockLabDesc:set_active(false); 	
				self.vs["cardLabTime"..tostring(index)]:set_active(false);
				self.vs["cardLabTime"..tostring(index)]:set_text("0天00:00:00");
			end
		else
			--self.vs.downClockLabDesc:set_active(false); 	
				self.vs["cardLabTime"..tostring(index)]:set_active(false);
				self.vs["cardLabTime"..tostring(index)]:set_text("0天00:00:00");
		end 
	else
		--self.vs.downClockLabDesc:set_active(false); 
				self.vs["cardLabTime"..tostring(index)]:set_active(false);
				self.vs["cardLabTime"..tostring(index)]:set_text("0天00:00:00");
	end 
	--app.log("-------------- des:" .. des);
	if des ~= "" then
		self.vs["cardLabDouble"..tostring(index)]:set_active(true);
		self.vs["cardLabDouble"..tostring(index)]:set_text(des);
	end
end 

function LevelActivity:on_enter_activity()
	if g_dataCenter.chatFight:CheckMyRequest() then
		return
	end
	if self.enterTimes >= self.totalTimes and g_dataCenter.gmCheat:getPlayLimit()==true then 
		FloatTip.Float("今日挑战次数已用完");
		do return end;
	end
	--if self.timeFlagNum ~= nil and g_dataCenter.gmCheat:getPlayLimit()==true then 
		--local str = g_getTimeChString(self.timeFlagNum - os.time());
		--FloatTip.Float("活动还需要 "..str.." 才能参加");
		--do return end;
	--end
	diffData = self.dataCenter:Join();
	DifficultSelect.popPanel(diffData,self.bindfunc['on_difficult_selected'],self.bindfunc['to_sweep_activity'],self.enterTimes,self.totalTimes,self.curSelectData);
end 

function LevelActivity:on_difficult_selected(difficultLevel)
	self.dataCenter:StartBattle(difficultLevel);
end 

function LevelActivity:to_sweep_activity()
	if self.dataCenter.Sweep ~= nil then 
		self.dataCenter:Sweep();
	end 
end 

function LevelActivity:serverSweepOver(system_id,awards,param)
	local double_type = ENUM.Double.hight_sniper;
	if system_id == MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang then	--高速狙击
		double_type = ENUM.Double.hight_sniper;
	elseif system_id == MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi then -- 保卫战
		double_type = ENUM.Double.defend;
	elseif system_id == MsgEnum.eactivity_time.eActivityTime_ClownPlan then -- 小丑计划
		double_type = ENUM.Double.xiaochoujihu;
	end

	local itemList = {};
	for k,v in pairs(awards) do 
		itemList[v.id] = itemList[v.id] or {};
		itemList[v.id].count = itemList[v.id].count or 0;
		itemList[v.id].dataid = itemList[v.id].dataid or v.dataid;
		itemList[v.id].id = itemList[v.id].id or v.id;
		itemList[v.id].count = itemList[v.id].count + v.count;
		itemList[v.id].radio_num = g_dataCenter.activityReward:GetDoubleByID(double_type, v.id);
	end

	awards = {};
	for k,v in pairs(itemList) do 
		if double_type == ENUM.Double.xiaochoujihu and v.radio_num > 1 then
			v.count = v.count / v.radio_num;
		end
		table.insert(awards,v);
	end
	data = 
	{
		drop_items = {{awards = awards}},
	}
	CommonRaids.Start(data)
	self:on_toggle_change(tostring(LevelActivity.curTab));
	if DifficultSelect.instance ~= nil then 
		DifficultSelect.instance:UpdateUi();
	end
end 

function LevelActivity:UpdateUi()
	self:SetCardData(1);	
	self:SetCardData(2);
	self:SetCardData(3);

	--self.vs.yekaScrollList:reset_position();
	--self.vs.yekaWrapContent:set_min_index();
	--self.vs.yekaWrapContent:set_max_index();
	self:on_toggle_change(tostring(LevelActivity.curTab or 1));
end 

function LevelActivity:Init(data)
	--app.log("LevelActivity:Init");
    self.pathRes = "assetbundles/prefabs/ui/level_activity/ui_7101_award_level.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function LevelActivity:DestroyUi()
	--app.log("LevelActivity:DestroyUi");

    if self.vs and self.vs.activityTexture then
        self.vs.activityTexture:Destroy()
        self.vs.activityTexture = nil
    end

	if self.redPointUpdateTimer ~= nil then 
		timer.stop(self.redPointUpdateTimer);
		self.redPointUpdateTimer = nil;
	end
	if self.timerId ~= nil then 
		timer.stop(self.timerId);
		self.timerId = nil;
	end 
	if self.vs ~= nil then 
		self.vs = nil;
	end 
	if self.activityItemList ~= nil then 
		self.activityItemList = nil;
	end
	if self.item1 then self.item1:DestroyUi(); self.item1 = nil end;
	if self.item2 then self.item2:DestroyUi(); self.item2 = nil end;
	if self.item3 then self.item3:DestroyUi(); self.item3 = nil end;
	if self.item4 then self.item4:DestroyUi(); self.item4 = nil end;

    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function LevelActivity:Show()
	--app.log("LevelActivity:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function LevelActivity:Hide()
	--app.log("LevelActivity:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function LevelActivity:MsgRegist()
	--app.log("LevelActivity:MsgRegist");
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_activity.gc_raids,self.bindfunc['serverSweepOver'])
end

--注销消息分发回调函数
function LevelActivity:MsgUnRegist()
	--app.log("LevelActivity:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_activity.gc_raids,self.bindfunc['serverSweepOver'])
end