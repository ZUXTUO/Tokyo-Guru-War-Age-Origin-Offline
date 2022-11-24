PlayTargetAward = Class("PlayTargetAward", UiBaseClass);

local _text = {};
_text.target = {
	[1] = "领取";
	[2] = "前往";
	[3] = "达成目标%d次";
	[4] = "%d月%d日~%d月%d日";
	[5] = "未达到任务条件,不可领取";
}

function PlayTargetAward:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1109_award.assetbundle";
    self.m_activity_id = tonumber(data.id);
    app.log("activity_id:" .. self.m_activity_id);
    UiBaseClass.Init(self, data);
end

function PlayTargetAward:InitData(data)
    UiBaseClass.InitData(self, data);

    self.m_vec_back_data = {};
    self.m_start_time = 0;
    self.m_end_time = 0;
    self.m_list_data = {};
    self.m_list_item_ui = {};
    
    self.m_icon_list = {};

    self.updateTimer = 0;
end

function PlayTargetAward:DestroyUi()
    
    self.m_vec_back_data = {};	
	self.m_list_data = {};

	for k,v in pairs(self.m_icon_list) do
		for k2,v2 in pairs(v) do
			if v2 then
				v2:DestroyUi();
			end
		end
		v = {};
		v = nil;
	end
	self.m_icon_list = {};

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

function PlayTargetAward:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["gc_target_award_states"] = Utility.bind_callback(self, self.gc_target_award_states);
    self.bindfunc["gc_get_target_award_back"] = Utility.bind_callback(self, self.gc_get_target_award_back);
    self.bindfunc["gc_change_activity_time"] = Utility.bind_callback(self, self.gc_change_activity_time);
    self.bindfunc["gc_pause_activity"] = Utility.bind_callback(self, self.gc_pause_activity);

    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc["on_click_get_go"] = Utility.bind_callback(self, self.on_click_get_go);
    
    self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
end

function PlayTargetAward:MsgRegist()
	PublicFunc.msg_regist("msg_activity.gc_target_award_states", self.bindfunc["gc_target_award_states"]);
	PublicFunc.msg_regist("msg_activity.gc_get_target_award_back", self.bindfunc["gc_get_target_award_back"]);
	PublicFunc.msg_regist("msg_activity.gc_change_activity_time", self.bindfunc["gc_change_activity_time"]);
	PublicFunc.msg_regist("msg_activity.gc_pause_activity", self.bindfunc["gc_pause_activity"]);
end

function PlayTargetAward:MsgUnRegist()
    PublicFunc.msg_unregist("msg_activity.gc_target_award_states", self.bindfunc["gc_target_award_states"]);
	PublicFunc.msg_unregist("msg_activity.gc_get_target_award_back", self.bindfunc["gc_get_target_award_back"]);
	PublicFunc.msg_unregist("msg_activity.gc_change_activity_time", self.bindfunc["gc_change_activity_time"]);
	PublicFunc.msg_unregist("msg_activity.gc_pause_activity", self.bindfunc["gc_pause_activity"]);
end

function PlayTargetAward:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("play_target_award_ui");

	local act_play_config = ConfigManager.Get(EConfigIndex.t_activity_play, self.m_activity_id);

	self.lab_title1 = ngui.find_label(self.ui, "play_target_award_ui/center_other/animation/content/lab_title1");--
	local des = tostring(act_play_config.des);
	if des == "0" or des == "nil" then
		des = "";
	end
	self.lab_title1:set_text(des);
	self.lab_time = ngui.find_label(self.ui, "play_target_award_ui/center_other/animation/content/lab_time");--
	self.lab_time:set_text("");
	self.lab_title2 = ngui.find_label(self.ui, "play_target_award_ui/center_other/animation/content/lab_title2");--
	self.lab_title2:set_active(false);
	if act_play_config and tostring(act_play_config.activity_name) ~= "0" and tostring(act_play_config.activity_name) ~= "nil" then
		self.lab_title2:set_active(true);
		self.lab_title2:set_text(tostring(act_play_config.activity_name));
	end

	-- self.m_texture = ngui.find_texture(self.ui, "center_other/animation/content/texture_di");
	-- self.m_texture:set_texture(act_play_config.bg_img);
	-- self.m_play_config = ConfigManager.Get(EConfigIndex.t_activity_play, ENUM.Activity.activityType_consume_total);
    self.m_texture = ngui.find_texture(self.ui, "center_other/animation/content/texture_di");
    local bg = nil;
    if act_play_config and act_play_config.bg_img then
        bg = tostring(act_play_config.bg_img);
        if bg ~= "0" then
            self.m_texture:set_texture(bg);
        end
    end

	self.lab_big = ngui.find_label(self.ui, "animation/content/lab_big_title");
	local big_name = tostring(act_play_config.activity_name);
	if big_name == "0" or big_name == "nil" then
		big_name = "";
	end
	if self.lab_big then
		self.lab_big:set_text(big_name);
	end
	local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(self.m_activity_id);
	self.sp_shuaxin = ngui.find_sprite(self.ui, "animation/content/sp_shuaxin");
	self.sp_shuaxin:set_active(activityTime and activityTime.is_reset == 1);	

	self.scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/panel");
	
	self.wrap_content = ngui.find_wrap_content(self.ui, "center_other/animation/panel/wrap_content");
	self.wrap_content:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
	self.wrap_content:set_min_index(0);
    self.wrap_content:set_max_index(-1);
    self.wrap_content:reset();

    local result, targetData = g_dataCenter.activityReward:GetTargetData(self.m_activity_id);
    if result then
    	self:gc_target_award_states(targetData.begin_time, targetData.end_time, targetData.data, self.m_activity_id);
    else
   		msg_activity.cg_get_target_award_states(self.m_activity_id);
	end
end

function PlayTargetAward:init_item_wrap_content( obj, b, real_id )
	local index = math.abs(real_id) + 1;
	local index_b = math.abs(b) + 1;

	if self.m_list_item_ui[index] == nil then
		self.m_list_item_ui[index] = obj;
	end
	obj:set_name("item_list_" .. index);

	if #self.m_list_data <= 0 then
		return;
	end

	local item_back_data = self.m_list_data[index];
	local task_type_config = ConfigManager.Get(EConfigIndex.t_activity_task_types, tonumber(item_back_data.task_type_id));
	app.log("--------------task_type_id:" .. item_back_data.task_type_id);
	app.log("--------------" .. table.tostring(task_type_config));
	local lab_num = ngui.find_label(obj, "lab_progress");
	local progress_num = tonumber(item_back_data.finish_progress);
	if progress_num > tonumber(item_back_data.finish_need) then
		progress_num = item_back_data.finish_need;		
	end
	lab_num:set_text(progress_num .. "/" .. item_back_data.finish_need);
	lab_num:set_active(true);
 
	local lab = ngui.find_label(obj, "lab");
	-- lab:set_text(string.format(_text.target[3], item_back_data.finish_need));
	lab:set_text(string.format(task_type_config.des, item_back_data.finish_need));

	if self.m_icon_list[index_b] == nil then
		self.m_icon_list[index_b] = {};
	end
	
	local small_card_item = nil;
	local carditem = nil;
	local award_item = nil;
	
	local award_list = Utility.lua_string_split(item_back_data.award_list, ",");
	for i = 1, 3 do
		small_card_item = obj:get_child_by_name("new_small_card_item" .. i );
		small_card_item:set_active(true);
		award_item = award_list[i];
		if award_item and award_item ~= "" then
			local signAwardList = Utility.lua_string_split(award_item, "#");
			carditem = CardProp:new({number = tonumber(signAwardList[1]), count = tonumber(signAwardList[2])});
			if self.m_icon_list[index_b][i] == nil then
				self.m_icon_list[index_b][i] = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
			else
				self.m_icon_list[index_b][i]:SetData(carditem);
			end
			self.m_icon_list[index_b][i]:SetCount(tonumber(signAwardList[2]));
			self.m_icon_list[index_b][i]:SetAsReward(signAwardList[3] and tonumber(signAwardList[3]) == 1);
			-- local fx = small_card_item:get_child_by_name("fx");
			-- fx:set_active(false);
			-- if signAwardList[3] and tonumber(signAwardList[3]) == 1 then
			-- 	fx:set_active(true);
			-- end
			
		else
			small_card_item:set_active(false);
		end
			
	end
	
	
	local sp_get = ngui.find_sprite(obj, "sp_art_font");
	local btn_get = ngui.find_button(obj, "btn1");
	local btn_get_lab = ngui.find_label(obj, "btn1/animation/lab");
	local btn_get_sp = ngui.find_sprite(obj, "btn1/animation/sp");
	-- local btn2 = ngui.find_button(obj, "btn2");
	-- btn2:set_active(false);
	btn_get:reset_on_click();
	if item_back_data.state == 0 then
		lab_num:set_active(true);
		if task_type_config.button_type == 0 then
			sp_get:set_active(false);
			btn_get:set_active(true)
			-- btn_get_lab:set_text(_text.target[1]);
			-- btn_get_lab:set_effect_color(198/255, 198/255, 198/255, 1);
			btn_get_lab:set_text("[C6C6C6FF]领取[-]");
			btn_get:set_event_value(tostring(item_back_data.id), 0);
			btn_get:set_on_click(self.bindfunc["on_click_get_go"]);
			btn_get:set_sprite_names("ty_anniu5");
			btn_get_sp:set_sprite_name("ty_anniu5");
			lab_num:set_active(true);
		elseif task_type_config.button_type == 1 then -- 前往
			sp_get:set_active(false);
			btn_get:set_active(true);
			-- btn_get_lab:set_text(_text.target[2]);
			-- btn_get_lab:set_effect_color(60/255, 75/255, 143/255, 1);
			btn_get_lab:set_text("[3C4B8FFF]前往[-]");
			btn_get:set_event_value(tostring(task_type_config.system_enter_id), 1);
			btn_get:set_on_click(self.bindfunc["on_click_get_go"]);
			btn_get:set_sprite_names("ty_anniu4");
			btn_get_sp:set_sprite_name("ty_anniu4");
			lab_num:set_active(true);

		elseif task_type_config.button_type == 2 then
			btn_get:set_active(false);
			lab_num:set_active(true);
			sp_get:set_active(false);
		end
	elseif item_back_data.state == 1 then
		sp_get:set_active(false);
		btn_get:set_active(true);
		-- btn_get_lab:set_text(_text.target[1]);
		btn_get:set_event_value(tostring(item_back_data.id), 2);
		btn_get:set_on_click(self.bindfunc["on_click_get_go"]);
		-- btn_get_lab:set_effect_color(0/255, 0/255, 0/255, 1);
		btn_get_lab:set_text("[973900FF]领取[-]");
		btn_get:set_sprite_names("ty_anniu3");
		btn_get_sp:set_sprite_name("ty_anniu3");
		lab_num:set_active(true);
		lab_num:set_text(item_back_data.finish_need .. "/" .. item_back_data.finish_need);
	elseif item_back_data.state == 2 then
		sp_get:set_active(true);
		btn_get:set_active(false);
		lab_num:set_active(true);
		lab_num:set_text(item_back_data.finish_need .. "/" .. item_back_data.finish_need);
	end
end

function PlayTargetAward:UpdateUIForBack( )
	local index_num = 0;
	local state_1 = 1;
	self.m_list_data = {};
	for k,v in pairs(self.m_vec_back_data) do
		index_num = index_num + 1;
		if v.state == 2 then
			table.insert(self.m_list_data, v);
		elseif v.state == 1 then
			state_1 = state_1 + 1;
			table.insert(self.m_list_data, 1, v);
		else
			table.insert(self.m_list_data, state_1, v);
		end
	end
	app.log("------------------- UpdateUIForBack")
	-- self.m_icon_list = {};
	self.wrap_content:set_min_index(-index_num + 1);
    self.wrap_content:set_max_index(0);
    self.wrap_content:reset();
    self.scroll_view:reset_position();
end

function PlayTargetAward:on_click_get_go( t )
	app.log("-------------t.string_value: " .. t.string_value .. "--------t.float_value: " .. t.float_value);
	local enter_id = tonumber(t.string_value);
	app.log("------------ enter_id:" .. enter_id);
	if t.float_value == 0 then
		FloatTip.Float(_text.target[5]);
	elseif t.float_value == 1 then
		if enter_id ~= 0 then
			-- SystemEnterFunc[enter_id]();
			SystemEnterFunc.ActivityEnter(enter_id);
		else
			app.log("activity_task_types表,任务按钮类型和进入系统方法id配置有误");
		end
	elseif t.float_value == 2 then
		msg_activity.cg_get_target_award(tonumber(t.string_value), self.m_activity_id);
	end
end

function PlayTargetAward:set_deff_time( )
	local diffSec = self.m_end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
	self.lab_time:set_text("活动倒计时:"..day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
	if diffSec <= 0 then
	    if self.updateTimer ~= 0 then 
	        timer.stop(self.updateTimer);
	        self.updateTimer = 0;
	    end
	 --    uiManager:RemoveUi(EUI.ActivityUI);
		-- uiManager:ClearStack();
	end
end
function PlayTargetAward:gc_target_award_states( start_time, end_time, vecTargetStates, activity_id )
	app.log("---------- end_time:" .. end_time .. "---- vec:" .. table.tostring(vecTargetStates) .. "----- activity_id:" .. activity_id);

	if activity_id == self.m_activity_id then
		local is_red_point_state = 0;
	    for k,v in pairs(vecTargetStates) do
	    	if v.state == 1 then
	    		is_red_point_state = 1;
	    		break;
	    	end
	    end
	    g_dataCenter.activityReward:SetRedPointStateByActivityID(activity_id, is_red_point_state);


		self.m_start_time = start_time;
		self.m_end_time = end_time;
		local start_time_con = os.date("*t", self.m_start_time);
		local end_time_con = os.date("*t", self.m_end_time);
		-- self.lab_title1:set_text(string.format(_text.target[4], start_time_con.month, start_time_con.day, end_time_con.month, end_time_con.day));

		self:set_deff_time();
		if self.updateTimer == 0 then
	        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
	    end

		self.m_vec_back_data = vecTargetStates;
		table.sort( self.m_vec_back_data, function ( a, b )
			return a.id > b.id
		end );

		self:UpdateUIForBack();
	end
end

function PlayTargetAward:gc_get_target_award_back( t_id, awardList, activity_id )
	-- local item_config_data = ConfigManager.Get(EConfigIndex.t_recruit_get, t_id);
	-- local award = {};
	-- for k,v in pairs(item_config_data.award) do
	-- 	table.insert(award, {id = v.item_id, count = v.item_num});
	-- end
	app.log("---------- awardList:" .. table.tostring(awardList));
	if activity_id == self.m_activity_id then
		CommonAward.Start(awardList);

		msg_activity.cg_get_target_award_states(self.m_activity_id);
	end
end

function PlayTargetAward:gc_change_activity_time( start_time, end_time )
	-- self.m_start_time = start_time;
	-- self.m_end_time = end_time;
	-- local start_time_con = os.date("*t", self.m_start_time);
	-- local end_time_con = os.date("*t", self.m_end_time);
	-- self.lab_title1:set_text(string.format(_text.target[4], start_time_con.month, start_time_con.day, end_time_con.month, end_time_con.day));

	-- self:set_deff_time();
	-- if self.updateTimer == 0 then
	-- 	self:set_deff_time(); 
 --        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
 --    end
end

function PlayTargetAward:gc_pause_activity(is_pause, activity_id)
	
end