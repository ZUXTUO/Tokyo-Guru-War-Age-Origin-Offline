GetApUI = Class("GetApUI", UiBaseClass);

local _text = {
	[1] = "领取截止倒计时:";
	[2] = "下一次领取还需:";
}

local _ref_time = {
	[1] = {[1] = 7, [2] = 12, [3] = 22};
	[2] = {[1] = 12, [2] = 18, [3] = 23};
	[3] = {[1] = 18, [2] = 21, [3] = 24};
	[4] = {[1] = 21, [2] = 24, [3] = 25};
}

function GetApUI:Init(data)
	self.m_activity_id = data;
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1132_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function GetApUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.m_ui_list = {};
    self.m_back_data = {};

    self.m_lab_type = 0;
    self.m_time_desc = 0;
    self.m_timer = 0;
end

function GetApUI:Restart(data)
	
	UiBaseClass.Restart(self, data);
end

function GetApUI:DestroyUi()
	self.m_lab_type = 0;
	self.m_time_desc = 0;
	if self.m_timer ~= 0 then
		timer.stop(self.m_timer);
		self.m_timer = 0;
	end

	UiBaseClass.DestroyUi(self);
end

function GetApUI:RegistFunc()
	
	UiBaseClass.RegistFunc(self);

	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
	self.bindfunc["on_sign_in"] = Utility.bind_callback(self,self.on_sign_in);

	self.bindfunc['gc_sync_dailytask_list'] = Utility.bind_callback(self, self.gc_sync_dailytask_list);
	self.bindfunc['gc_finish_task'] = Utility.bind_callback(self, self.gc_finish_task);
	self.bindfunc['gc_repair_task'] = Utility.bind_callback(self, self.gc_repair_task);
end

--注册消息分发回调函数
function GetApUI:MsgRegist()
	PublicFunc.msg_regist(msg_dailytask.gc_sync_dailytask_list,self.bindfunc['gc_sync_dailytask_list']);
	PublicFunc.msg_regist(msg_dailytask.gc_repair_task,self.bindfunc['gc_repair_task']);
	PublicFunc.msg_regist(msg_dailytask.gc_finish_task,self.bindfunc['gc_finish_task']);
end

--注销消息分发回调函数
function GetApUI:MsgUnRegist()
	PublicFunc.msg_unregist(msg_dailytask.gc_sync_dailytask_list,self.bindfunc['gc_sync_dailytask_list']);
	PublicFunc.msg_unregist(msg_dailytask.gc_finish_task,self.bindfunc['gc_finish_task']);
	PublicFunc.msg_unregist(msg_dailytask.gc_repair_task,self.bindfunc['gc_repair_task']);
end

function GetApUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("get_ap_ui");	

	
	local res = "";
	for i=1, 4 do
		res = "center_other/animation/sp_di"..i.."/";
		self.m_ui_list[i] = {
			sp = ngui.find_sprite(self.ui, res .. "sp"),
			sp_lab = ngui.find_label(self.ui, res .. "sp/lab"),
			lab_time = ngui.find_label(self.ui, res .. "lab_time"),
			card_item = self.ui:get_child_by_name(res.."big_card_item_80");
			sp_art_font = ngui.find_sprite(self.ui, res .. "sp_art_font");
		}
		self.m_ui_list[i].sp_art_font:set_active(false);
		self.m_ui_list[i].sp:set_active(false);
		local item_data_config = ConfigManager.Get(EConfigIndex.t_dailytask, _ref_time[i][3]);

	    local item_get_award_config = ConfigManager.Get(EConfigIndex.t_dailytask_reward, _ref_time[i][3]);
	    if not item_get_award_config then
	        return;
	    end
	    item_get_award_config = item_get_award_config[1];
	    self.m_ui_list[i].lab_time:set_text(item_data_config.task_describe);
        local carditem = CardProp:new({number = item_get_award_config.item[1].id, count = item_get_award_config.item[1].num});
        if self.m_ui_list[i].small_item_ui == nil then
        	self.m_ui_list[i].small_item_ui = UiSmallItem:new({parent = self.m_ui_list[i].card_item, cardInfo = carditem});
        end
        self.m_ui_list[i].small_item_ui:SetData(carditem);
        self.m_ui_list[i].small_item_ui:SetCount(item_get_award_config.item[1].num);
        self.m_ui_list[i].small_item_ui:SetShine(false);
	end

	self.m_lab = ngui.find_label(self.ui, "center_other/animation/lab_daojishi");
	self.m_lab:set_text("");

	-- msg_dailytask.cg_request_dailytask_list();
	if not g_dataCenter.daily_task:GetTaskData() or #g_dataCenter.daily_task:GetTaskData() < 1 then
        msg_dailytask.cg_request_dailytask_list();
    else
        self:gc_sync_dailytask_list();
    end
	-- self:UpdateUI();
end

function GetApUI:UpdateUIRef( )
	-- self.m_back_data = {
	-- 	[1] = {taskIndex = 22, state = 1},
	-- 	[2] = {taskIndex = 23, state = 1},
	-- 	[3] = {taskIndex = 24, state = 1},
	-- 	[4] = {taskIndex = 25, state = 1},
	-- }
	
	app.log("------------------------ UpdateUI")
	local data = nil;
	local ui = nil;
	local i = 1;
	local is_get = false;
	local is_red_point = 0;
	for k,v in pairs(self.m_back_data) do
		i = tonumber(k);
		app.log("------iiii:" .. i)
		local sysTime = os.date("*t",system.time());
        local currentTime = tonumber(sysTime.hour .. string.format("%02d",sysTime.min) .. string.format("%02d",sysTime.sec));
        local item_data_config = ConfigManager.Get(EConfigIndex.t_dailytask, v.taskIndex);

		if v.state == 0 then
			
		elseif v.state == 1 then
			if tonumber(sysTime.hour) < 5 then -- 每天小于5点，补领昨天的 
				local num = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_get_ap_task).data;
	        	self.m_ui_list[i].sp:set_active(true);
	        	self.m_ui_list[i].sp_lab:set_text(tostring(num));
				self.m_ui_list[i].lab_time:set_active(false);
				self.m_ui_list[i].sp_art_font:set_sprite_name("hd_buling");
				self.m_ui_list[i].sp_art_font:set_active(true);
				self.m_ui_list[i].small_item_ui:SetOnClicked(self.bindfunc["on_sign_in"], tostring(v.taskIndex), 2);
				self.m_ui_list[i].small_item_ui:SetAsReward(false);
				self.m_time_desc = 0;
				self.m_ui_list[i].small_item_ui:SetGray(false);
			
	        elseif currentTime > item_data_config.unlock_parm1 and currentTime < item_data_config.unlock_parm2 then -- 在时间内，可领
	        	self.m_ui_list[i].sp:set_active(false);
				self.m_ui_list[i].lab_time:set_active(true);
				self.m_ui_list[i].lab_time:set_text("[00ff00ff]"..item_data_config.task_describe.."[-]");
				self.m_ui_list[i].sp_art_font:set_active(false);
				self.m_ui_list[i].small_item_ui:SetShine(false);
				self.m_ui_list[i].small_item_ui:SetOnClicked(self.bindfunc["on_sign_in"], tostring(v.taskIndex), 1);
				self.m_ui_list[i].small_item_ui:SetAsReward(true);
				self.m_lab_type = 1;
				local c_ref_time = _ref_time[i];
				sysTime.hour = c_ref_time[2];
				sysTime.min = 0;
				sysTime.sec = 0;
				local cur_time = os.time(sysTime);
                self.m_time_desc = cur_time - system.time();
                self.m_ui_list[i].small_item_ui:SetGray(false);
                is_get = false;
                is_red_point = 1;
	        elseif currentTime > item_data_config.unlock_parm2 then -- 补领
	        	local num = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_get_ap_task).data;
	        	self.m_ui_list[i].sp:set_active(true);
	        	self.m_ui_list[i].sp_lab:set_text(tostring(num));
				self.m_ui_list[i].lab_time:set_active(false);
				self.m_ui_list[i].sp_art_font:set_sprite_name("hd_buling");
				self.m_ui_list[i].sp_art_font:set_active(true);
				self.m_ui_list[i].small_item_ui:SetOnClicked(self.bindfunc["on_sign_in"], tostring(v.taskIndex), 2);
				self.m_ui_list[i].small_item_ui:SetAsReward(false);
				self.m_time_desc = 0;
				self.m_ui_list[i].small_item_ui:SetGray(false);
			elseif currentTime < item_data_config.unlock_parm1 then -- 时间还未到
				self.m_ui_list[i].sp:set_active(false);
				self.m_ui_list[i].lab_time:set_active(true);
				self.m_ui_list[i].lab_time:set_text(item_data_config.task_describe);
				self.m_ui_list[i].sp_art_font:set_active(false);
				self.m_ui_list[i].small_item_ui:SetOnClicked(self.bindfunc["on_sign_in"], tostring(v.taskIndex), 3);
				self.m_ui_list[i].small_item_ui:SetAsReward(false);
				self.m_ui_list[i].small_item_ui:SetGray(not is_get);
				is_get = false;
	        end
		elseif v.state == 2 then -- 已领取
			self.m_ui_list[i].sp:set_active(false);
			self.m_ui_list[i].lab_time:set_active(true);
			self.m_ui_list[i].lab_time:set_text(item_data_config.task_describe);
			self.m_ui_list[i].sp_art_font:set_active(true);
			self.m_ui_list[i].sp_art_font:set_sprite_name("qd_yilingqu");
			self.m_ui_list[i].small_item_ui:SetOnClicked(self.bindfunc["on_sign_in"], tostring(v.taskIndex), 0);
			self.m_ui_list[i].small_item_ui:SetAsReward(false);
			self.m_lab_type = 2;
			-- self.m_time_desc = item_data_config.unlock_parm2 - currentTime;

			local is_get_all = false;
			local c_ref_time = _ref_time[i];
			if tonumber(sysTime.hour) < 5 then
				c_ref_time = _ref_time[1];
				sysTime.hour = c_ref_time[1];
			elseif tonumber(sysTime.hour) >= 21 and tonumber(sysTime.hour) <= 24 then
				is_get_all = true;
			else
				sysTime.hour = c_ref_time[2];
			end
			
			sysTime.min = 0;
			sysTime.sec = 0;
			local cur_time = os.time(sysTime);
            self.m_time_desc = cur_time - system.time();
            
			self.m_ui_list[i].small_item_ui:SetGray(true);
			is_get = true;
			if is_get_all then
				self.m_time_desc = 0;
				self.m_lab:set_text("");
			end
		end
	end

	g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_get_ap_reward, is_red_point);
	if self.m_time_desc > 0 then
		-- self.m_lab:set_text("");
		if self.m_timer ~= 0 then
			timer.stop(self.m_timer);
			self.m_timer = 0;
		end
		self:set_deff_time();
		self.m_timer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
	end
end

function GetApUI:set_deff_time( )
	self.m_time_desc = self.m_time_desc - 1;
	if self.m_time_desc > 0 then
		local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(self.m_time_desc);
		self.m_lab:set_text((_text[self.m_lab_type] or "") .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));
	else
		msg_dailytask.cg_request_dailytask_list();

		if self.m_timer ~= 0 then
			timer.stop(self.m_timer);
			self.m_timer = 0;
		end
	end
end

function GetApUI:on_sign_in( t )
	app.log("------------------- click: t.string_value:" .. t.string_value .. "-- t.float_value:" .. t.float_value)
	if t.float_value == 1 then -- 正常领取
		-- msg_dailytask.cg_finish_task({tonumber(t.string_value)});
		local item_get_award_config = ConfigManager.Get(EConfigIndex.t_dailytask_reward, tonumber(t.string_value));
		if item_get_award_config and item_get_award_config[1] then
			item_get_award_config = item_get_award_config[1];
		end
		if tonumber(item_get_award_config.item[1].id) == 4 then
			if not PublicFunc.CheckApLimit(g_dataCenter.player:GetAP() + tonumber(item_get_award_config.item[1].num)) then
				msg_dailytask.cg_finish_task({tonumber(t.string_value)});
			end
		else
			msg_dailytask.cg_finish_task({tonumber(t.string_value)});
		end
	elseif t.float_value == 2 then -- 补领
		local num = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_get_ap_task).data
		app.log("num:" .. num .. "--crystal:" .. g_dataCenter.player.crystal)
		if g_dataCenter.player.crystal < num then
			FloatTip.Float("钻石不足");
		else

			local item_get_award_config = ConfigManager.Get(EConfigIndex.t_dailytask_reward, tonumber(t.string_value));
			if item_get_award_config and item_get_award_config[1] then
				item_get_award_config = item_get_award_config[1];
			end
			if tonumber(item_get_award_config.item[1].id) == 4 then
				if not PublicFunc.CheckApLimit(g_dataCenter.player:GetAP() + tonumber(item_get_award_config.item[1].num)) then
					msg_dailytask.cg_repair_task(tonumber(t.string_value));
				end
			else
				msg_dailytask.cg_repair_task(tonumber(t.string_value));
			end
			
		end
	elseif t.float_value == 3 then
		FloatTip.Float("未到领取时间");
	end
end

function GetApUI:gc_sync_dailytask_list()
    local taskdata = g_dataCenter.daily_task:GetTaskData();
    self.m_back_data = {};
    for k,v in pairs(taskdata) do
    	if v.taskIndex == 22 or v.taskIndex == 23 or v.taskIndex == 24 or v.taskIndex == 25 then
    		table.insert(self.m_back_data, v);
    	end
    end
    table.sort( self.m_back_data, function ( a, b )
    	return a.taskIndex < b.taskIndex;
    end )
    self:UpdateUIRef();
end

function GetApUI:gc_finish_task( result, vecItem )
	app.log("-----------gc_finish_task:" .. table.tostring(vecItem))
	CommonAward.Start(vecItem, 1);
	CommonAward.SetFinishCallback(self.back_upper_layer, self)
	-- msg_dailytask.cg_request_dailytask_list();
end

function GetApUI:gc_repair_task( vecItem )
	CommonAward.Start(vecItem, 1);
	CommonAward.SetFinishCallback(self.back_upper_layer, self)
	-- msg_dailytask.cg_request_dailytask_list();
end

function GetApUI:back_upper_layer(  )
	app.log("-----------back_upper_layer:" .. table.tostring(vecItem))
	msg_dailytask.cg_request_dailytask_list();
end