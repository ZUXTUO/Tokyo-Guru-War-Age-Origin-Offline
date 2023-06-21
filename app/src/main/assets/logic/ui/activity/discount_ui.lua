DiscountUI = Class("DiscountUI", UiBaseClass);

local _lab_txt = {
	[1] = "%d月%d日%02d:00~%d月%d日%02d:00";
}

function DiscountUI:Init(data)
	self.m_activity_id = data.id;
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1130_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function DiscountUI:InitData(data)
    UiBaseClass.InitData(self, data);    

    self.updateTimer = 0;
end

function DiscountUI:Restart(data)
	
	UiBaseClass.Restart(self, data);
end

function DiscountUI:DestroyUi()

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

function DiscountUI:RegistFunc()
	
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_go"] = Utility.bind_callback(self, self.on_go);
	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);

end

function DiscountUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("extra_ui");

	app.log("---------------- m_activity_id:" .. self.m_activity_id);

	self.btn_go = ngui.find_button(self.ui, "extra_ui/center_other/animation/btn_fight");
	self.btn_go:set_on_click(self.bindfunc["on_go"]);

	self.m_play_config = ConfigManager.Get(EConfigIndex.t_activity_play, self.m_activity_id);
	self.tittle_txt = ngui.find_label(self.ui, "extra_ui/center_other/animation/lab2");
	local t_des = self.m_play_config.des;
	if tostring(t_des) == "0" or tostring(t_des) == "nil" then
		t_des = ""
	end
	self.tittle_txt:set_text(t_des);

	self.tittle_des = ngui.find_label(self.ui, "center_other/animation/cont/lab1");
	local t_des = tostring(self.m_play_config.activity_info);
	if t_des == "0" or t_des == "nil" then
		t_des = "";
	end
	self.tittle_des:set_text(t_des);

	-- self.activity_des = ngui.find_label(self.ui, "center_other/animation/cont/lab2");
	-- self.activity_des:set_text(string.format(self.m_play_config.des, g_dataCenter.activityReward:GetExtraTimesByActivityID(self.m_activity_id)) or "");
	self.lab3 = ngui.find_label(self.ui, "center_other/animation/cont/lab3");
	if self.lab3 then
		self.lab3:set_active(false)
	end
	self.lab_time_des = ngui.find_label(self.ui, "center_other/animation/cont/lab4");
	if self.lab_time_des then	
		self.lab_time_des:set_text("");
		self.lab_time_des:set_active(false);
	end
	self.lab_time = ngui.find_label(self.ui, "center_other/animation/lab_time");
	self.lab_time:set_text("");
	local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID( self.m_activity_id );

	if activityTime then
		self.m_start_time = activityTime.s_time;
		self.m_end_time = activityTime.e_time;
		local sysStartTime   = os.date("*t", self.m_start_time);
		local sysEndTime = os.date("*t", self.m_end_time);
		if self.lab_time_des then
			self.lab_time_des:set_text(string.format(_lab_txt[1], sysStartTime.month, sysStartTime.day, sysStartTime.hour, sysEndTime.month, sysEndTime.day, sysEndTime.hour));
		end
	
		self:set_deff_time();
		self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
	end

	-- do return; end
	self.m_texture = ngui.find_texture(self.ui, "center_other/animation/texture");
	local bg = nil;
    if self.m_play_config.bg_img then
    	bg = tostring(self.m_play_config.bg_img);   
    	app.log("bg:" .. bg) 	
    	if bg ~= "0" and bg ~= "" then
    		self.m_texture:set_texture(bg);
    	end
    end
    -- self.m_texture:set_texture(tostring(self.m_play_config.bg_img));
end

function DiscountUI:set_deff_time( )
	local diffSec = self.m_end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
	self.lab_time:set_text("活动倒计时:"..day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
	if diffSec <= 0 then
	    if self.updateTimer ~= 0 then 
	        timer.stop(self.updateTimer);
	        self.updateTimer = 0;
	        self.lab_time:set_text("");
	    end
	 --    uiManager:RemoveUi(EUI.ActivityUI);
		-- uiManager:ClearStack();
	end
end

function DiscountUI:on_go( t )
	local enter_id = MsgEnum.eactivity_time.eActivityTime_Recruit;
	if self.m_activity_id == ENUM.Activity.activityType_niudan_discount then
		enter_id = MsgEnum.eactivity_time.eActivityTime_Recruit;
	elseif self.m_activity_id == ENUM.Activity.activityType_yuanzheng_box_discount then
		enter_id = MsgEnum.eactivity_time.eActivityTime_trial;
	elseif self.m_activity_id == ENUM.Activity.activityType_equip_box_discount then
		enter_id = MsgEnum.eactivity_time.eActivityTime_Equip;
	end
	app.log("enter_id:" .. enter_id);
	-- SystemEnterFunc[enter_id]();
	SystemEnterFunc.ActivityEnter(enter_id);
end