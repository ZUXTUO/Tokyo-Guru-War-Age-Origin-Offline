DoubleUI = Class("DoubleUI", UiBaseClass);

_double_type_id = {
	[1] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_defend, activity_id = ENUM.Activity.activityType_double_defend};
	[2] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_gold_exchange, activity_id = ENUM.Activity.activityType_double_gold_exchange};
	[3] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_buy_ap, activity_id = ENUM.Activity.activityType_double_buy_ap};
	[4] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_church_hook, activity_id = ENUM.Activity.activityType_double_church_hook};
	[5] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_hight_sniper, activity_id = ENUM.Activity.activityType_double_hight_sniper};
	[6] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_kuikuliya, activity_id = ENUM.Activity.activityType_double_kuikuliya};
	[7] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_hurdle_normal, activity_id = ENUM.Activity.activityType_double_hurdle_normal};
	[8] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_hurdle_elite, activity_id = ENUM.Activity.activityType_double_hurdle_elite};
	[9] = {ui_path = "ui_1130_award.assetbundle", activity_type = ENUM.Activity.activityType_double_xiaochoujihua, activity_id = ENUM.Activity.activityType_double_xiaochoujihua};
}

local _lab_txt = {
	[1] = "活动日期:%d月%d日%02d:00~%d月%d日%02d:00";
}

function DoubleUI:Init(data)
	app.log("------ double_type:" .. table.tostring(data));
	self.m_double_type = tonumber(data.double_type);
	self.m_activity_id = tonumber(data.id);
    self.pathRes = "assetbundles/prefabs/ui/award/" .. _double_type_id[self.m_double_type].ui_path;
    UiBaseClass.Init(self, data);
end

function DoubleUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.updateTimer = 0;
end

function DoubleUI:DestroyUi()

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

function DoubleUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_go"] = Utility.bind_callback(self, self.on_btn_go);
    self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
end

function DoubleUI:MsgRegist()
	
end

function DoubleUI:MsgUnRegist()

end

function DoubleUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("double_ui");
	local double_config = ConfigManager.Get(EConfigIndex.t_activity_double, self.m_double_type);
	if double_config == nil then
		return;
	end
	self.btn_go = ngui.find_button(self.ui, "center_other/animation/btn_fight");
	self.btn_go:reset_on_click();
	self.btn_go:set_event_value(tostring(double_config.enter_id), 0);
	self.btn_go:set_on_click(self.bindfunc["on_btn_go"]);
	self.lab3 = ngui.find_label(self.ui, "center_other/animation/cont/lab3");
	if self.lab3 then
		self.lab3:set_active(false)
	end
	self.lab_day = ngui.find_label(self.ui, "center_other/animation/cont/lab4");
	self.lab_day:set_active(false);
	self.lab_time = ngui.find_label(self.ui, "center_other/animation/lab_time");

	local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(self.m_activity_id);
	if activityTime == nil then
		do return; end
	end
	self.m_start_time = activityTime.s_time;
	self.m_end_time = activityTime.e_time;
	local sysStartTime   = os.date("*t", self.m_start_time);
	local sysEndTime = os.date("*t", self.m_end_time);
	if self.lab_day then
		self.lab_day:set_text(string.format(_lab_txt[1], sysStartTime.month, sysStartTime.day, sysStartTime.hour, sysEndTime.month, sysEndTime.day, sysEndTime.hour));
	end
	
	self:set_deff_time();
	if self.updateTimer == 0 then
        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
    end


    self.m_play_config = ConfigManager.Get(EConfigIndex.t_activity_play, self.m_activity_id);
    if self.m_play_config == nil then
    	return;
    end
    self.lab_title = ngui.find_label(self.ui, "center_other/animation/cont/lab2");
    local t_des = self.m_play_config.des;
	if tostring(t_des) == "0" or tostring(t_des) == "nil" then
		t_des = ""
	end
    self.lab_title:set_text(t_des);

    self.lab_des = ngui.find_label(self.ui, "center_other/animation/cont/lab1");
    local l_des = tostring(self.m_play_config.activity_info);
    if l_des == "0" or l_des == "nil" then
    	l_des = "";
    end
    self.lab_des:set_text( l_des );

    self.m_texture = ngui.find_texture(self.ui, "center_other/animation/texture");
    local bg = nil;
    if self.m_play_config.bg_img then
    	bg = tostring(self.m_play_config.bg_img);
    	if bg ~= "0" then
    		self.m_texture:set_texture(bg);
    	end
    end
    
end

function DoubleUI:set_deff_time( )
	local diffSec = self.m_end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
	self.lab_time:set_text("活动倒计时:"..day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
	if diffSec <= 0 then
	    if self.updateTimer ~= 0 then 
	        timer.stop(self.updateTimer);
	        self.updateTimer = 0;
	    end
	end
end

function DoubleUI:on_btn_go( t )
	if t.string_value ~= "0" then
		-- SystemEnterFunc[tonumber(t.string_value)]();
		SystemEnterFunc.ActivityEnter(tonumber(t.string_value));
	end
end