DiscountBuyUI = Class("DiscountBuyUI", UiBaseClass);

local _lab_txt = {
	[1] = "%d月%d日%02d:00~%d月%d日%02d:00";
}

function DiscountBuyUI:Init(data)
	self.m_activity_id = data.id;
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1142_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function DiscountBuyUI:InitData(data)
    UiBaseClass.InitData(self, data);    

    self.updateTimer = 0;
    self.m_times = {};
end

function DiscountBuyUI:Restart(data)
	
	UiBaseClass.Restart(self, data);
end

function DiscountBuyUI:DestroyUi()

	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end

    if self.m_texture then
    	self.m_texture:clear_texture();
    	self.m_texture = nil;
    end

    for k,v in pairs(self.m_ui_list) do
    	if v then
    		v.item_ui:DestroyUi();
    		v.item_ui = nil;
    		v = nil;
    	end
    end
    self.m_ui_list = {};
    self.m_times = {};
	UiBaseClass.DestroyUi(self);

	
end

function DiscountBuyUI:RegistFunc()
	
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_go_buy"] = Utility.bind_callback(self, self.on_go_buy);
	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);

	self.bindfunc["gc_discount_buy_times"] = Utility.bind_callback(self, self.gc_discount_buy_times);
	self.bindfunc["gc_discount_buy_buy"] = Utility.bind_callback(self, self.gc_discount_buy_buy);
end

function DiscountBuyUI:MsgRegist()
	PublicFunc.msg_regist(msg_activity.gc_discount_buy_times, self.bindfunc["gc_discount_buy_times"]);
	PublicFunc.msg_regist(msg_activity.gc_discount_buy_buy, self.bindfunc["gc_discount_buy_buy"]);
end

function DiscountBuyUI:MsgUnRegist()
	PublicFunc.msg_unregist(msg_activity.gc_discount_buy_times, self.bindfunc["gc_discount_buy_times"]);
	PublicFunc.msg_unregist(msg_activity.gc_discount_buy_buy, self.bindfunc["gc_discount_buy_buy"]);
end

function DiscountBuyUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("discount_ui");

	app.log("---------------- m_activity_id:" .. self.m_activity_id);

	-- self.btn_go = ngui.find_button(self.ui, "extra_ui/center_other/animation/btn_fight");
	-- self.btn_go:set_on_click(self.bindfunc["on_go"]);

	self.m_play_config = ConfigManager.Get(EConfigIndex.t_activity_play, self.m_activity_id);
	self.tittle_txt = ngui.find_label(self.ui, "center_other/animation/lab_down");
	local t_des = self.m_play_config.des;
	if tostring(t_des) == "0" or tostring(t_des) == "nil" then
		t_des = ""
	end
	self.tittle_txt:set_text(t_des);

	-- self.tittle_des = ngui.find_label(self.ui, "center_other/animation/cont/lab1");
	-- local t_des = tostring(self.m_play_config.activity_info);
	-- if t_des == "0" then
	-- 	t_des = "";
	-- end
	-- self.tittle_des:set_text(t_des);

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
	self.lab_time = ngui.find_label(self.ui, "center_other/animation/txt_time");
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
	-- self.m_texture = ngui.find_texture(self.ui, "center_other/animation/texture_bk");
	-- local bg = nil;
 --    if self.m_play_config.bg_img then
 --    	bg = tostring(self.m_play_config.bg_img);   
 --    	app.log("bg:" .. bg) 	
 --    	if bg ~= "0" and bg ~= "" then
 --    		self.m_texture:set_texture(bg);
 --    	end
 --    end
    
    self.m_ui_list = {};
    local res = "";
    local config_data = nil;
    local item_data = nil;
    for i=1,3 do
    	self.m_ui_list[i] = {};
    	config_data = ConfigManager.Get(EConfigIndex.t_discount_buy, i);
    	item_data = ConfigManager.Get(EConfigIndex.t_item, config_data.item_id);
    	res = "center_other/animation/texture"..i.."/";
    	self.m_ui_list[i].lab_item_name = ngui.find_label(self.ui, res.."lab_num");
    	-- self.m_ui_list[i].lab_item_name:set_text(PublicFunc.GetItemName(item_data.name, item_data.rarity));
    	self.m_ui_list[i].lab_item_name:set_text(item_data.name);
    	self.m_ui_list[i].price = ngui.find_label(self.ui, res.."txt1/lab_num");
    	self.m_ui_list[i].price:set_text(tostring(config_data.price));
    	self.m_ui_list[i].dis_price = ngui.find_label(self.ui, res.."txt2/lab_num");
    	self.m_ui_list[i].dis_price:set_text(tostring(config_data.dis_price))
    	self.m_ui_list[i].lab_times = ngui.find_label(self.ui, res.."lab_cishu");
    	self.m_ui_list[i].lab_times:set_text("")
    	self.m_ui_list[i].sp_art_font = ngui.find_sprite(self.ui, res.."sp_art_font");
    	self.m_ui_list[i].sp_art_font:set_active(false);
    	self.m_ui_list[i].new_small_card_item = self.ui:get_child_by_name(res.."new_small_card_item");
    	self.m_ui_list[i].item_ui = UiSmallItem:new({parent = self.m_ui_list[i].new_small_card_item, is_enable_goods_tip = true, delay = 500});
    	self.m_ui_list[i].item_ui:SetDataNumber(config_data.item_id, config_data.item_num);
    	self.m_ui_list[i].item_ui:SetAsReward(config_data.is_line and config_data.is_line == 1);
    	self.m_ui_list[i].ui_button_left = ngui.find_button(self.ui, res.."ui_button_left");
    	self.m_ui_list[i].ui_button_left:set_active(false);
    	self.m_ui_list[i].ui_button_left:reset_on_click();
    	self.m_ui_list[i].ui_button_left:set_on_click(self.bindfunc["on_go_buy"]);
    	self.m_ui_list[i].ui_button_left:set_event_value("", i);
    	self.m_ui_list[i].ui_button_left_lab = ngui.find_label(self.ui, res.."ui_button_left/animation/lab");
    	self.m_ui_list[i].ui_button_left_lab:set_text("购买");
    end

    msg_activity.cg_discount_buy_times();
end

function DiscountBuyUI:UpdateUI( )
	local data_config = nil;
	for i=1,10 do
		data_config = ConfigManager.Get(EConfigIndex.t_discount_buy, i);
		if self.m_ui_list[i] and data_config and self.m_times[i] then
			self.m_ui_list[i].ui_button_left:set_active(true);
			self.m_ui_list[i].sp_art_font:set_active(false);
			local c_times = data_config.buy_times-self.m_times[i];
			local t_times = data_config.buy_times;
			if self.m_times[i] == 0 then
				self.m_ui_list[i].lab_times:set_text(string.format("今日可购买次数[00FF00FF]%s[-]/%s", c_times, t_times));
			elseif self.m_times[i] < data_config.buy_times then --可购
				self.m_ui_list[i].lab_times:set_text(string.format("今日可购买次数[FFFFFFFF]%s[-]/%s", c_times, t_times));
			elseif self.m_times[i] >= data_config.buy_times then				
				self.m_ui_list[i].lab_times:set_text(string.format("今日可购买次数[FF0000FF]%s[-]/%s", c_times, t_times));
				self.m_ui_list[i].ui_button_left:reset_on_click();
				self.m_ui_list[i].ui_button_left:set_active(false);
				self.m_ui_list[i].sp_art_font:set_active(true);
			end
		end
	end
end

function DiscountBuyUI:on_go_buy( t )
	local data_config = ConfigManager.Get(EConfigIndex.t_discount_buy, t.float_value);
	if g_dataCenter.player.crystal < data_config.dis_price then
		FloatTip.Float("钻石不足");
	else
		msg_activity.cg_discount_buy_buy(t.float_value);
	end
end

function DiscountBuyUI:set_deff_time( )
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

function DiscountBuyUI:gc_discount_buy_times( times_1, times_2, times_3 )
	self.m_times[1] = times_1;
	self.m_times[2] = times_2;
	self.m_times[3] = times_3;
	self:UpdateUI();
end

function DiscountBuyUI:gc_discount_buy_buy( id )
	app.log("id:" .. id)
	local data_config = ConfigManager.Get(EConfigIndex.t_discount_buy, id);
	local award = {{id=data_config.item_id, count=data_config.item_num}};
	CommonAward.Start(award);
	self.m_times[id] = self.m_times[id] - 1;	
	-- self:UpdateUI();
end