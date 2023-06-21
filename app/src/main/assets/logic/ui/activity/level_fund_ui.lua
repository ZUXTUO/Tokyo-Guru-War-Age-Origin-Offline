LevelFundUI = Class("LevelFundUI", UiBaseClass);

local _text = {
	[1] = "%s钻石";
	[2] = "达到[ffdc4e]%s级[-]可领取";
	[3] = "未达到指定等级，不可领取";
	[4] = "钻石不足";
	[5] = "钻石不足！是否前往充值？";
	[6] = "星%s特权 可购买";
	[7] = "是否前往提升好感度";
	[8] = "否";
	[9] = "前往";
	[10] = "[FFDC49FF]%s[-]天后关闭购买"
}

local _need_vip_level = 3;
local _need_buy_crystal = 998;

function LevelFundUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1115_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function LevelFundUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.m_is_buy_state = 0;
    self.m_vec_back_data = {};

    self.m_list_data = {};
    self.m_list_item_ui = {};
    self.m_icon_list = {};

    self.m_end_time = 0;
    self.updateTimer = 0;
end

function LevelFundUI:DestroyUi()
    
    self.m_vec_back_data = {};	
	self.m_list_data = {};

	for k,v in pairs(self.m_icon_list) do
		if v then
			v:DestroyUi();
			v = nil;
		end
	end
	self.m_icon_list = {};


	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end
	UiBaseClass.DestroyUi(self);
end

function LevelFundUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["gc_level_fund_state"] = Utility.bind_callback(self, self.gc_level_fund_state);
    self.bindfunc["gc_buy_back"] = Utility.bind_callback(self, self.gc_buy_back);
    self.bindfunc["gc_get_back"] = Utility.bind_callback(self, self.gc_get_back);
    self.bindfunc["go_to_store"] = Utility.bind_callback(self, self.go_to_store);

    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc["on_click_rule"] = Utility.bind_callback(self, self.on_click_rule);
    self.bindfunc["on_click_buy"] = Utility.bind_callback(self, self.on_click_buy);
    self.bindfunc["on_click_get"] = Utility.bind_callback(self, self.on_click_get);

    self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
end

function LevelFundUI:MsgRegist()
	PublicFunc.msg_regist("msg_activity.gc_level_fund_state", self.bindfunc["gc_level_fund_state"]);
	PublicFunc.msg_regist("msg_activity.gc_buy_back", self.bindfunc["gc_buy_back"]);
	PublicFunc.msg_regist("msg_activity.gc_get_back", self.bindfunc["gc_get_back"]);

end

function LevelFundUI:MsgUnRegist()
    PublicFunc.msg_unregist("msg_activity.gc_level_fund_state", self.bindfunc["gc_level_fund_state"]);
	PublicFunc.msg_unregist("msg_activity.gc_buy_back", self.bindfunc["gc_buy_back"]);
	PublicFunc.msg_unregist("msg_activity.gc_get_back", self.bindfunc["gc_get_back"]);

end

function LevelFundUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("level_fund_ui");

	-- self.btn_rule = ngui.find_button(self.ui, "level_fund_ui/center_other/animation/content/btn_rule");
	-- self.btn_rule:set_on_click(self.bindfunc["on_click_rule"]);
	self.btn_buy = ngui.find_button(self.ui, "center_other/animation/btn_buy");
	self.btn_buy:set_on_click(self.bindfunc["on_click_buy"]);
	self.btn_buy:set_active(false);
	self.sp_art_font = ngui.find_sprite(self.ui, "center_other/animation/sp_art_font");
	self.sp_art_font:set_active(false);

	local lab_vip = ngui.find_label(self.ui, "center_other/animation/texture_di/sp_v/lab_v");
	local lab_vip_star = ngui.find_label(self.ui, "center_other/animation/texture_di/sp_v/lab_v2");

	self.m_other_config = ConfigManager.Get(EConfigIndex.t_activity_other, 4);
	if self.m_other_config then
		_need_vip_level = self.m_other_config.parm_1;
		_need_buy_crystal = self.m_other_config.parm_2;

		local cur_vipdata = g_dataCenter.player:GetVipDataByLevel( self.m_other_config.parm_1 );
		if cur_vipdata then
			if lab_vip and lab_vip_star then
				lab_vip:set_text(tostring(cur_vipdata.level));
				lab_vip_star:set_text("-"..tostring(cur_vipdata.level_star));
			end
		end		
	end
	

	self.lab_time = ngui.find_label(self.ui, "center_other/animation/lab1");
	-- self.lab_time_lab = ngui.find_label(self.ui, "center_other/animation/lab2");
	self.lab_time:set_text("");
	local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_level_fund);
	if activityTime then
		if activityTime.e_time == -1 then
			self.lab_time:set_text("");
			-- self.lab_time_lab:set_active(false);
		else
			self.m_end_time = activityTime.e_time;
			-- local diffSec = activityTime.e_time - system.time();
			-- local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
			-- self.lab_time:set_text(string.format(_text[10], (day+1)));
			-- self.lab_time_lab:set_active(true);
			self:set_deff_time();
			self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
		end
	end

	self.wrap_content = ngui.find_wrap_content(self.ui, "level_fund_ui/center_other/animation/panel/wrap_content");
	self.wrap_content:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
	self.wrap_content:set_min_index(0);
    self.wrap_content:set_max_index(-1);
    self.wrap_content:reset();
    self.scroll_view = ngui.find_scroll_view(self.ui, "level_fund_ui/center_other/animation/panel");

    msg_activity.cg_get_level_fund_state();
end

function LevelFundUI:set_deff_time( )
	local diffSec = self.m_end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
	self.lab_time:set_text("可购买倒计时:"..day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec) .. "");   
	if diffSec <= 0 then
	    if self.updateTimer ~= 0 then 
	        timer.stop(self.updateTimer);
	        self.updateTimer = 0;
	    end
	 --    uiManager:RemoveUi(EUI.ActivityUI);
		-- uiManager:ClearStack();
	end
end

function LevelFundUI:init_item_wrap_content( obj, b, real_id )
	-- app.log("init_item_wrap_content:" .. b .. "--" .. real_id);
	local index = math.abs(real_id) + 1;
	local index_b = math.abs(b) + 1;
	if #self.m_list_data <= 0 then
		return;
	end
	if self.m_list_item_ui[index] == nil then
		self.m_list_item_ui[index] = obj;
	end
	-- obj:set_name("item_list_" .. index);

	local item_back_data = self.m_list_data[index];
	local item_config_data = ConfigManager.Get(EConfigIndex.t_level_fund, item_back_data.id);
	-- app.log("----------" .. table.tostring(item_back_data));
	-- app.log("----------" .. table.tostring(item_config_data));
	-- do return end
	local small_card_item1 = obj:get_child_by_name("small_card_item1");
	local fx = obj:get_child_by_name("small_card_item1/fx");
	if item_config_data.is_line == 0 then
		fx:set_active(false);
	end

	local carditem = CardProp:new({number = item_config_data.item_id, count = item_config_data.num});
	if self.m_icon_list[index_b] == nil then
		self.m_icon_list[index_b] = UiSmallItem:new({parent = small_card_item1, cardInfo = carditem});
	else
		self.m_icon_list[index_b]:SetData(carditem);
	end
	self.m_icon_list[index_b]:SetLabNum(true);
	self.m_icon_list[index_b]:SetNumberStr(tostring(item_config_data.num));

	app.log("item_num:" .. item_config_data.num);
	app.log("item_num_t:" .. item_config_data.level_tittle);

	local lab1 = ngui.find_label(obj, "lab1");
	-- lab1:set_text(string.format(_text[1], item_config_data.num));
	lab1:set_text(item_config_data.level_tittle);
	local lab2 = ngui.find_label(obj, "lab2");
	-- lab2:set_text(string.format(_text[2], item_config_data.need_level));
	lab2:set_text(item_config_data.level_dec);

	local lab_num = ngui.find_label(obj, "lab_progress");
	-- if g_dataCenter.player.level <= item_config_data.need_level then
	-- 	lab_num:set_text(g_dataCenter.player.level .. "/" .. item_config_data.need_level);
	-- else
	-- 	lab_num:set_text(item_config_data.need_level .. "/" .. item_config_data.need_level);
	-- end
	local progress_l = g_dataCenter.player.level;
	if progress_l > item_config_data.need_level then
		progress_l = item_config_data.need_level;
	end
	lab_num:set_text(progress_l .. "/" .. item_config_data.need_level);
	local sp_get = ngui.find_sprite(obj, "sp_get");
	local btn_get = ngui.find_button(obj, "btn1");
	btn_get:reset_on_click();

	if self.m_is_buy_state == 0 then
		btn_get:set_active(false);
		sp_get:set_active(false);
	else
		if item_back_data.state == 0 then
			btn_get:set_active(true);
			sp_get:set_active(false);
			if g_dataCenter.player.level < item_config_data.need_level then
				lab_num:set_active(true);
				btn_get:set_event_value("0", item_back_data.id);
				btn_get:set_on_click(self.bindfunc["on_click_get"]);
				btn_get:set_sprite_names("ty_anniu5");
				btn_get:set_active(false);
			else
				lab_num:set_active(true);
				btn_get:set_event_value("1", item_back_data.id);
				btn_get:set_on_click(self.bindfunc["on_click_get"]);
				btn_get:set_sprite_names("ty_anniu3");
				btn_get:set_active(true);
			end
		elseif item_back_data.state == 1 then
			lab_num:set_active(true);
			btn_get:set_active(false);
			sp_get:set_active(true);
		end
	end
end

function LevelFundUI:UpdateListForBackData( )
	local index_num = 0;
	self.m_list_data = {};
	local is_red_state = 0;
	for k,v in pairs(self.m_vec_back_data) do
		index_num = index_num + 1;
		if v.state == 0 then
			table.insert(self.m_list_data, 1, v);
			if is_red_state == 0 then
				local item_config_data = ConfigManager.Get(EConfigIndex.t_level_fund, v.id);
				if g_dataCenter.player.level >= item_config_data.need_level then
					is_red_state = 1;
				end
			end
		else
			table.insert(self.m_list_data, v);
			
		end
	end
	
	if self.m_is_buy_state == 0 then
		is_red_state = 0;
	end
	g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_level_fund, is_red_state)

	-- self.m_icon_list = {};
	self.wrap_content:set_min_index(-index_num + 1);
    self.wrap_content:set_max_index(0);
    self.wrap_content:reset();
    self.scroll_view:reset_position();
end

function LevelFundUI:on_click_buy( t )
	if g_dataCenter.player.vip >= _need_vip_level then
		if g_dataCenter.player.crystal >= _need_buy_crystal then
	    	msg_activity.cg_buy_level_fund(_need_buy_crystal);
	    else
	    	HintUI.SetAndShowNew(EHintUiType.two, _text[4], _text[5], nil, {str = _text[9],func = self["go_to_store"]}, {str = _text[8],func = nil}, btn3Data, btn4Data)

			-- type = EHintUiType.two
			-- title = "钻石不足"
			-- content = "钻石不足！是否前往充值？"
			-- btnSpace = nil
			-- btn1Data = {str = "立即前往",func = XXXX}
			-- btn2Data = {str = "否",func = XXXX}
	    end
	else
		HintUI.SetAndShowNew(EHintUiType.two,string.format(_text[6], 3), _text[7], nil, {str = _text[9],func = self["go_to_store"]}, {str = _text[8],func = nil}, btn3Data, btn4Data)
	    	
	end
end

function LevelFundUI:go_to_store()
	uiManager:PushUi(EUI.VipPackingUI);
end

function LevelFundUI:on_click_get( t )
	if t.string_value == "1" then
		msg_activity.cg_get_level_fund_award(t.float_value);
	else
		FloatTip.Float(_text[3]);
	end
end

function LevelFundUI:on_click_rule( t )
	UiRuleDes.Start(ENUM.ERuleDesType.LevelFund);
end

function LevelFundUI:gc_level_fund_state( buyState, vecLevelState )
	self.m_is_buy_state = buyState;
	self.m_vec_back_data = vecLevelState;
	
	self.sp_art_font:set_active(self.m_is_buy_state == 1);
	self.btn_buy:set_active(self.m_is_buy_state == 0);
	self.lab_time:set_active(self.m_is_buy_state == 0);
	-- self.lab_time_lab:set_active(self.m_is_buy_state == 0);
	table.sort( self.m_vec_back_data, function ( a, b )
		return a.id > b.id
	end );
	self:UpdateListForBackData();
end

function LevelFundUI:gc_buy_back( )
	self.lab_time:set_text("");
	local o_time = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_level_fund);
	g_dataCenter.activityReward:SetActivityTimeForActivityID(ENUM.Activity.activityType_level_fund, o_time.s_time, -1);
	msg_activity.cg_get_level_fund_state();
end

function LevelFundUI:gc_get_back( id )
	local item_config_data = ConfigManager.Get(EConfigIndex.t_level_fund, id);
	local award = {};
	award[1] = {id = 3, count = item_config_data.num};
	CommonAward.Start(award);

	msg_activity.cg_get_level_fund_state();
end