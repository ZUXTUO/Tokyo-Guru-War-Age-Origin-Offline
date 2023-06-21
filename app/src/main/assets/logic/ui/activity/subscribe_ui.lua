SubscribeUI = Class("SubscribeUI", UiBaseClass);


local _lab_txt = {
	[1] = "活动日期:%d月%d日%02d:00~%d月%d日%02d:00";
	[2] = "¥%s/%s天";
}

function SubscribeUI:Init(data)
	
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1147_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function SubscribeUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.updateTimer = 0;
    self.m_end_time = 0;

    self.m_cont1_ui = {};
    self.m_cont2_ui = {};
end

function SubscribeUI:DestroyUi()

	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end

    if self.m_texture then
    	self.m_texture:clear_texture();
    	self.m_texture = nil;
    end

    UiBaseClass.DestroyUi(self);
end

function SubscribeUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_go"] = Utility.bind_callback(self, self.on_btn_go);
    self.bindfunc["on_btn_buy"] = Utility.bind_callback(self, self.on_btn_buy);
    self.bindfunc["on_btn_recovery"] = Utility.bind_callback(self, self.on_btn_recovery);
    self.bindfunc["on_btn_rule"] = Utility.bind_callback(self, self.on_btn_rule);


    self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);

    self.bindfunc["gc_subscribe_get_state_list"] = Utility.bind_callback(self, self.gc_subscribe_get_state_list);
    self.bindfunc["gc_subscribe_set_state"] = Utility.bind_callback(self, self.gc_subscribe_set_state);
    self.bindfunc["gc_subscribe_get_award"] = Utility.bind_callback(self, self.gc_subscribe_get_award);
end

function SubscribeUI:MsgRegist()
	PublicFunc.msg_regist(msg_activity.gc_subscribe_get_state_list, self.bindfunc["gc_subscribe_get_state_list"])
	
	PublicFunc.msg_regist(msg_activity.gc_subscribe_set_state, self.bindfunc["gc_subscribe_set_state"])

	PublicFunc.msg_regist(msg_activity.gc_subscribe_get_award, self.bindfunc["gc_subscribe_get_award"])
end

function SubscribeUI:MsgUnRegist()
	PublicFunc.msg_unregist(msg_activity.gc_subscribe_get_state_list, self.bindfunc["gc_subscribe_get_state_list"])
	
	PublicFunc.msg_unregist(msg_activity.gc_subscribe_set_state, self.bindfunc["gc_subscribe_set_state"])

	PublicFunc.msg_unregist(msg_activity.gc_subscribe_get_award, self.bindfunc["gc_subscribe_get_award"])
end

function SubscribeUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("subscribe_ui");
	
	self.m_activity_play_data = ConfigManager.Get(EConfigIndex.t_activity_play, ENUM.Activity.activityType_subscribe);
	self.activity_title_des = ngui.find_label(self.ui, "center_other/animation/content/lab_title1");
	local title_des = "";
	if self.m_activity_play_data then
		title_des = tostring(self.m_activity_play_data.des);
	end
	if title_des == "nil" or title_des == "0" then
		title_des = "";
	end
	self.activity_title_des:set_text(title_des);

	self.lab_time = ngui.find_label(self.ui, "center_other/animation/content/lab_time");
	self.lab_time:set_text("");

	self.cont1 = self.ui:get_child_by_name("center_other/animation/cont1");
	self.cont1:set_active(false);

	if self.m_cont1_ui == nil then
		self.m_cont1_ui = {};
	end
	
	self.m_cont1_ui.btn_xiangqing = ngui.find_button(self.cont1, "btn_xiangqing");
	self.m_cont1_ui.btn_yellow = ngui.find_button(self.cont1, "btn_yellow");
	self.m_cont1_ui.btn_buleda = ngui.find_button(self.cont1, "btn_buleda");	
	self.m_cont1_ui.lab_num = ngui.find_label(self.cont1, "txt/lab_num");	
	self.m_cont1_ui.lab_des = ngui.find_label(self.cont1, "panel/lab");	

	self.cont2 = self.ui:get_child_by_name("center_other/animation/cont2");
	self.cont2:set_active(false);
    
    if self.m_cont2_ui == nil then
    	self.m_cont2_ui = {};
    end 

    local item = nil;
    local new_small_card_item = nil;
    for i=1,3 do
    	if self.m_cont2_ui[i] == nil then
    		self.m_cont2_ui[i] = {};
    	end
    	item = self.cont2:get_child_by_name("item"..i);
    	self.m_cont2_ui[i].item = item;
    	self.m_cont2_ui[i].texture = ngui.find_texture(item, "texture");
    	self.m_cont2_ui[i].texture_human = ngui.find_texture(item, "texture_human");
    	self.m_cont2_ui[i].sp_tips = ngui.find_sprite(item, "sp_tips");
    	self.m_cont2_ui[i].lab_title = ngui.find_label(item, "lab_title");
    	self.m_cont2_ui[i].lab_title2 = ngui.find_label(item, "lab_title/lab_title2");
    	self.m_cont2_ui[i].sp_point = ngui.find_sprite(item, "sp_point");

    	for s=1,3 do
    		if self.m_cont2_ui[i].card_item_list == nil then
    			self.m_cont2_ui[i].card_item_list = {};
    		end
    		if self.m_cont2_ui[i].card_item_list[s] == nil then
    			self.m_cont2_ui[i].card_item_list[s] = {};
    		end
    		new_small_card_item = item:get_child_by_name("new_small_card_item"..s);
    		self.m_cont2_ui[i].card_item_list[s].new_small_card_item = new_small_card_item;
    		self.m_cont2_ui[i].card_item_list[s].small_card_item_ui = UiSmallItem:new({parent=new_small_card_item});
    	end

    	self.m_cont2_ui[i].sp_suo_di = ngui.find_sprite(item, "sp_suo_di");
    	self.m_cont2_ui[i].sp_suo_di_sou_level = ngui.find_label(item, "sp_suo_di/lab1");
    	self.m_cont2_ui[i].lab_times_num = ngui.find_label(item, "sp_tips/lab_num");
    	self.m_cont2_ui[i].sp_bar = ngui.find_sprite(item, "sp_bar");
    	self.m_cont2_ui[i].btn_yellow = ngui.find_button(item, "btn_yellow");
    	self.m_cont2_ui[i].btn_yellow_lab = ngui.find_label(item, "btn_yellow/animation/lab");

    end

    msg_activity.cg_subscribe_get_state_list();
end

function SubscribeUI:UpdateUI( )
	local state = g_dataCenter.activityReward:GetSubscribeState();
	if state == 0 then
		self:UpdateUICont1();
		self.cont2:set_active(false);
	else
		self:UpdateUICont2();
		self.cont1:set_active(false);
	end

end

function SubscribeUI:UpdateUICont1(  )
	self.cont1:set_active(true);
	local aother_data = ConfigManager.Get(EConfigIndex.t_activity_other, 5);
	self.m_cont1_ui.lab_num:set_text( string.format(_lab_txt[2], aother_data.parm_2, aother_data.parm_1) );

	local des = "";
	if self.m_activity_play_data then
		des = tostring(self.m_activity_play_data.activity_info);
	end
	if des == "nil" or des == "0" then
		des = "";
	end
	self.m_cont1_ui.lab_des:set_text(des);

	self.m_cont1_ui.btn_xiangqing:reset_on_click();
	self.m_cont1_ui.btn_xiangqing:set_on_click(self.bindfunc["on_btn_rule"]);

	self.m_cont1_ui.btn_yellow:reset_on_click();
	self.m_cont1_ui.btn_yellow:set_on_click(self.bindfunc["on_btn_buy"]);

	self.m_cont1_ui.btn_buleda:reset_on_click();
	self.m_cont1_ui.btn_buleda:set_on_click(self.bindfunc["on_btn_recovery"]);


end

function SubscribeUI:UpdateUICont2(  )
	self.cont2:set_active(true);
	
	local states = g_dataCenter.activityReward:GetSubscribeStateList();

	local cur_ui = nil;
	local cur_state = nil;
	local task_types_data = nil;
	local vs_data = nil;
	local config_data = nil;
	local r = 1;
	for k,v in pairs(self.m_cont2_ui) do
		cur_ui = self.m_cont2_ui[k];
		cur_state = states[k];
		if cur_state then
			config_data = ConfigManager.Get(EConfigIndex.t_subscribe, cur_state.id);
			if config_data then
				task_types_data = ConfigManager.Get(EConfigIndex.t_activity_task_types, config_data.task_type);
			end
			if task_types_data then
				vs_data = ConfigManager.Get(EConfigIndex.t_play_vs_data, task_types_data.system_enter_id);
			end

			if config_data and task_types_data and vs_data then
				cur_ui.item:set_active(true);
				cur_ui.sp_point:set_active(false);
				cur_ui.texture_human:set_texture(config_data.texture_path);
				cur_ui.lab_title:set_text(tostring(config_data.title_name or ""));
				if cur_ui.lab_title2 then
					cur_ui.lab_title2:set_active(false);
				end
				local cardInfo = nil;
				local award_data = nil;
				for i=1,3 do
					award_data = config_data.awards[i];
					if award_data then
						cur_ui.card_item_list[i].new_small_card_item:set_active(true);
						cardInfo = CardProp:new({number = award_data.item_id, count = award_data.item_num});
						cur_ui.card_item_list[i].small_card_item_ui:SetData(cardInfo);
						cur_ui.card_item_list[i].small_card_item_ui:SetLabNum(true);
						cur_ui.card_item_list[i].small_card_item_ui:SetNumberStr(tostring(award_data.item_num));
						cur_ui.card_item_list[i].small_card_item_ui:SetAsReward(award_data.is_line and award_data.is_line == 1);
					else
						cur_ui.card_item_list[i].new_small_card_item:set_active(false);
					end
				end

				cur_ui.sp_suo_di:set_active(g_dataCenter.player:GetLevel() < config_data.unlock_param1);
				cur_ui.sp_suo_di_sou_level:set_text(tostring(config_data.unlock_param1 or 0));

				local cur_times = cur_state.progress;
				if cur_times > config_data.need_times then
					cur_times = config_data.need_times;
				end
				cur_ui.lab_times_num:set_text(cur_times .. "/" .. config_data.need_times);

				cur_ui.btn_yellow:reset_on_click();
				cur_ui.btn_yellow:set_on_click(self.bindfunc["on_btn_go"]);

				if cur_state.state == 0 then
					cur_ui.sp_bar:set_active(false);
					cur_ui.btn_yellow_lab:set_text("执行");
					PublicFunc.SetButtonShowMode(cur_ui.btn_yellow, 1);						
					if task_types_data then
						cur_ui.btn_yellow:set_event_value(tostring(task_types_data.system_enter_id), 1);
					end
				elseif cur_state.state == 1 then
					cur_ui.sp_bar:set_active(true);
					PublicFunc.SetButtonShowMode(cur_ui.btn_yellow, 1);
					cur_ui.btn_yellow_lab:set_text("领取");
					cur_ui.btn_yellow:set_event_value(tostring(cur_state.id), 2);
				elseif cur_state.state == 2 then
					cur_ui.sp_bar:set_active(true);
					PublicFunc.SetButtonShowMode(cur_ui.btn_yellow, 3);
					cur_ui.btn_yellow_lab:set_text("已领取");
					cur_ui.btn_yellow:set_event_value(tostring(cur_state.id), 3);
				end


				if g_dataCenter.player:GetLevel() < config_data.unlock_param1 then
					r = 0;
					cur_ui.sp_suo_di:set_active(true);
					cur_ui.btn_yellow:set_active(false);
				end

				-- cur_ui.sp_art_font:set_color(r,r,r,1);
				cur_ui.texture:set_color(r,r,r,1);
				cur_ui.texture_human:set_color(r,r,r,1);
				cur_ui.sp_tips:set_color(r,r,r,1);
				

			else
				cur_ui.item:set_active(false);
			end
		else
			cur_ui.item:set_active(false);
		end
	end
end

function SubscribeUI:set_deff_time( )
	local diffSec = self.m_end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
	self.lab_time:set_text("活动倒计时:"..day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
	if diffSec <= 0 then
	    if self.updateTimer ~= 0 then 
	        timer.stop(self.updateTimer);
	        self.updateTimer = 0;
	    end
	    self.lab_time:set_text("活动倒计时:0天00:00:00");
	end
end

function SubscribeUI:on_btn_go( t )
	if t.float_value == 0 then
		FloatTip.Float("等级不足");
	elseif t.float_value == 1 then
		if t.float_value > 0 then
			SystemEnterFunc.ActivityEnter( tonumber(t.string_value) );
		end
	elseif t.float_value == 2 then
		msg_activity.cg_subscribe_get_award( tonumber(t.string_value) );
	elseif t.float_value == 3 then
		FloatTip.Float("已领取");
	end
end

function SubscribeUI:on_btn_buy( t )
	msg_activity.cg_subscribe_set_state();
end

function SubscribeUI:on_btn_recovery( t )
	FloatTip.Float("你还未订阅行动档案");
end

function SubscribeUI:on_btn_rule( t )
	
end

function SubscribeUI:gc_subscribe_get_state_list( start_time_ref )
	
	if g_dataCenter.activityReward:GetSubscribeState() == 1 then
		self.m_end_time = start_time_ref + tonumber(ConfigManager.Get(EConfigIndex.t_activity_other, 5).parm_1) * 24 * 60 * 60;
		self:set_deff_time();
		if self.updateTimer ~= 0 then 
	        timer.stop(self.updateTimer);
	        self.updateTimer = 0;
	    end
	    self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000, -1);
	end

	self:UpdateUI();
end

function SubscribeUI:gc_subscribe_set_state(  )
	self:UpdateUI();
end

function SubscribeUI:gc_subscribe_get_award( awards )
	app.log("gc_subscribe_get_award:" .. table.tostring(awards));
	if #awards > 0 then
		CommonAward.Start(awards);
	end
	-- self:UpdateUI();
end