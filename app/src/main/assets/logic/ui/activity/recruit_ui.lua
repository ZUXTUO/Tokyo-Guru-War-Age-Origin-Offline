RecruitUI = Class("RecruitUI", UiBaseClass);

local _text = {}
_text.recruit = {
	[1] = "领取";
	[2] = "获取";
	[3] = "招募角色送礼";
	[4] = "活动期间招募英雄即可兑换超值大礼包！";
	[5] = "招募[f2ae1c]%s[-] 即可获得奖励";
}

function RecruitUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1116_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function RecruitUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.m_vec_back_data = {};

    self.m_list_data = {};
    self.m_list_item_ui = {};
    self.m_head_icon_list = {};
    self.m_icon_list = {};

    self.updateTimer = 0;
end

function RecruitUI:Restart( )
	UiBaseClass.Restart(self, data)
end

function RecruitUI:DestroyUi()
    
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

	for k,v in pairs(self.m_head_icon_list) do
		if v then
			v:DestroyUi();
			v = nil;
		end
	end
	self.m_head_icon_list = {};

	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end

    UiBaseClass.DestroyUi(self);
end

function RecruitUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["gc_recruit_states"] = Utility.bind_callback(self, self.gc_recruit_states);
    self.bindfunc["gc_get_recruit_back"] = Utility.bind_callback(self, self.gc_get_recruit_back);

    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc["on_click_get_go"] = Utility.bind_callback(self, self.on_click_get_go);
    self.bindfunc["on_click_head_detail"] = Utility.bind_callback(self, self.on_click_head_detail);

    self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
end

function RecruitUI:MsgRegist()
	PublicFunc.msg_regist("msg_activity.gc_recruit_states", self.bindfunc["gc_recruit_states"]);
	PublicFunc.msg_regist("msg_activity.gc_get_recruit_back", self.bindfunc["gc_get_recruit_back"]);

end

function RecruitUI:MsgUnRegist()
 --    PublicFunc.msg_unregist("msg_activity.gc_level_fund_state", self.bindfunc["gc_level_fund_state"]);
	-- PublicFunc.msg_unregist("msg_activity.gc_buy_back", self.bindfunc["gc_buy_back"]);
	-- PublicFunc.msg_unregist("msg_activity.gc_get_back", self.bindfunc["gc_get_back"]);
	PublicFunc.msg_unregist("msg_activity.gc_recruit_states", self.bindfunc["gc_recruit_states"]);
	PublicFunc.msg_unregist("msg_activity.gc_get_recruit_back", self.bindfunc["gc_get_recruit_back"]);
end

function RecruitUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("recruit_ui");

	-- self.btn_rule = ngui.find_button(self.ui, "level_fund_ui/center_other/animation/content/btn_rule");
	-- self.btn_rule:set_on_click(self.bindfunc["on_click_rule"]);
	-- self.btn_buy = ngui.find_button(self.ui, "level_fund_ui/center_other/animation/content/btn_buy");
	-- self.btn_buy:set_on_click(self.bindfunc["on_click_buy"]);
	-- self.btn_buy:set_active(false);
	-- self.sp_art_font = ngui.find_sprite(self.ui, "level_fund_ui/center_other/animation/content/sp_art_font");
	-- self.sp_art_font:set_active(false);
	local act_play_config = ConfigManager.Get(EConfigIndex.t_activity_play, ENUM.Activity.activityType_recruit);
	self.lab_title1 = ngui.find_label(self.ui, "recruit_ui/center_other/animation/content/lab_title1");--
	self.lab_title1:set_text(act_play_config.activity_info);
	self.lab_time = ngui.find_label(self.ui, "recruit_ui/center_other/animation/content/lab_time");--

	-- self.lab_title4 = ngui.find_label(self.ui, "recruit_ui/center_other/animation/content/lab_title4");--
	-- self.lab_title4:set_text(_text.recruit[3]);

	self.scroll_view = ngui.find_scroll_view(self.ui, "recruit_ui/center_other/animation/panel");
	self.wrap_content = ngui.find_wrap_content(self.ui, "recruit_ui/center_other/animation/panel/wrap_content");
	self.wrap_content:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
	self.wrap_content:set_min_index(0);
    self.wrap_content:set_max_index(-1);
    self.wrap_content:reset();

   	msg_activity.cg_get_recruit_states();
end

function RecruitUI:init_item_wrap_content( obj, b, real_id )
	local index = math.abs(real_id) + 1;
	local index_b = math.abs(b) + 1;

	if self.m_list_item_ui[index] == nil then
		self.m_list_item_ui[index] = obj;
	end
	obj:set_name("item_list_" .. index);

	if #self.m_list_data <= 0 then
		return;
	end

	-- local lab_num = ngui.find_label(obj, "lab_num");
	-- lab_num:set_active(false);

	app.log("----------- index: " .. index);
	local item_back_data = self.m_list_data[index];
	local item_config_data = ConfigManager.Get(EConfigIndex.t_recruit_get, item_back_data.id);
	local role_config = ConfigHelper.GetRole(tonumber(item_config_data.role_default_id));

	local lab_name = ngui.find_label(obj, "lab");
	local lab_des = ngui.find_label(obj, "lab/lab1");
	lab_des:set_text(item_config_data.info);
	-- lab_name:set_text(string.format(_text.recruit[5], role_config.name));
	-- lab_name:set_text(item_config_data.info);

	local small_card_item = nil;
	local carditem = nil;
	local award_item = nil;

	small_card_item = obj:get_child_by_name("new_small_card_item1");
	carditem = CardHuman:new( {number = item_config_data.role_default_id});
	if self.m_head_icon_list[index_b] == nil then
		self.m_head_icon_list[index_b] = SmallCardUi:new({parent = small_card_item, info = carditem, stypes = {SmallCardUi.SType.Texture}});
	else
		self.m_head_icon_list[index_b]:SetDataNumber(item_config_data.role_default_id);
	end
	self.m_head_icon_list[index_b]:SetCallback(self.bindfunc["on_click_head_detail"])
	local fx = small_card_item:get_child_by_name("fx");
	if fx then
		fx:set_active(false);
	end

	if self.m_icon_list[index_b] == nil then
		self.m_icon_list[index_b] = {};
	end

	lab_name:set_text(carditem.name);
	-- do return end;
	-- carditem = nil;
	if item_config_data.award ~= "0" then
		for i = 1, 3 do
			small_card_item = obj:get_child_by_name("new_small_card_item" .. (i + 1));
			small_card_item:set_active(true);
			award_item = item_config_data.award[i];
			if award_item then
				carditem = CardProp:new({number = award_item.item_id, count = award_item.item_num});
				if self.m_icon_list[index_b][i] == nil then
					self.m_icon_list[index_b][i] = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
				else
					self.m_icon_list[index_b][i]:SetData(carditem);
				end
				self.m_icon_list[index_b][i]:SetLabNum(true);
				self.m_icon_list[index_b][i]:SetNumberStr(tostring(award_item.item_num));
				self.m_icon_list[index_b][i]:SetAsReward(award_item.is_line and award_item.is_line == 1);
				-- local fx = small_card_item:get_child_by_name("fx");
				-- fx:set_active(award_item.is_line == 1);
			else
				small_card_item:set_active(false);
			end
				
		end
	end
	
	local sp_get = ngui.find_sprite(obj, "sp_get");
	local btn_get = ngui.find_button(obj, "btn1");
	btn_get:set_active(true);
	local btn_get_lab = ngui.find_label(obj, "btn1/animation/lab");
	local btn_get_sp = ngui.find_sprite(obj, "btn1/animation/sp");
	-- local btn2 = ngui.find_button(obj, "btn2");
	-- btn2:set_active(false);

	btn_get:reset_on_click();
	if item_back_data.state == 0 then
		sp_get:set_active(false);
		-- btn_get_lab:set_text(_text.recruit[2]);
		-- btn_get_lab:set_effect_color(29/255, 85/255, 160/255, 1);
		btn_get_lab:set_text("[3C4B8FFF]前往[-]");
		btn_get:set_event_value("0", item_back_data.id);
		btn_get:set_on_click(self.bindfunc["on_click_get_go"]);
		btn_get:set_sprite_names("ty_anniu4");
		btn_get_sp:set_sprite_name("ty_anniu4");
	elseif item_back_data.state == 1 then
		sp_get:set_active(false);
		-- btn_get_lab:set_text(_text.recruit[1]);
		-- btn_get_lab:set_effect_color(174/255, 65/255, 40/255, 1);
		btn_get_lab:set_text("[973900FF]领取[-]");
		btn_get:set_event_value("1", item_back_data.id);
		btn_get:set_on_click(self.bindfunc["on_click_get_go"]);
		btn_get:set_sprite_names("ty_anniu3");
		btn_get_sp:set_sprite_name("ty_anniu3");
	else
		sp_get:set_active(true);
		btn_get:set_active(false);
	end
end

function RecruitUI:UpdateUIForBack( )
	local index_num = 0;
	local state_1 = 1;
	self.m_list_data = {};
	local is_red_state = 0;
	for k,v in pairs(self.m_vec_back_data) do
		index_num = index_num + 1;
		if v.state == 2 then
			table.insert(self.m_list_data, v);
		elseif v.state == 1 then
			state_1 = state_1 + 1;
			table.insert(self.m_list_data, 1, v);
			is_red_state = 1;
		else
			table.insert(self.m_list_data, state_1, v);
		end
	end
	g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_recruit, is_red_state)

	-- self.m_icon_list = {};
	self.wrap_content:set_min_index(-index_num + 1);
    self.wrap_content:set_max_index(0);
    self.wrap_content:reset();
    self.scroll_view:reset_position();
end

function RecruitUI:on_click_get_go( t )
	app.log("-----------sssssssss" .. t.string_value);
	if t.string_value == "0" then
		local item_config_data = ConfigManager.Get(EConfigIndex.t_recruit_get, t.float_value);
		if item_config_data.get_type == 1 then-- 首充
			--uiManager:RemoveUi(EUI.ActivityUI);
			--uiManager:ClearStack();
			-- uiManager:ReplaceUi(EUI.UiFirstRecharge);
			SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_FirsetRecharge]();
		elseif item_config_data.get_type == 2 then -- 招募
			uiManager:PushUi(EUI.EggHeroUi);
		elseif item_config_data.get_type == 3 then -- vip特权
			uiManager:PushUi(EUI.VipPackingUI);
		elseif item_config_data.get_type == 4 then -- 活动指定页
			-- uiManager:RemoveUi(EUI.ActivityUI);
			-- uiManager:ClearStack();
			-- uiManager:PushUi(EUI.LoginRewardUI);
		elseif item_config_data.get_type == 5 then -- 主界面登录送礼
			--uiManager:RemoveUi(EUI.ActivityUI);
			--uiManager:ClearStack();
			uiManager:ReplaceUi(EUI.LoginRewardUI);
		elseif item_config_data.get_type == 6 then -- 社团商店
			SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopGuild]();
		elseif item_config_data.get_type == 7 then -- 竞技场商店/
			SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopArena]();
		elseif item_config_data.get_type == 8 then -- 远征商店
			SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopTrial]();
		elseif item_config_data.get_type == 9 then -- 神秘商店
			SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopMystery]();
		elseif item_config_data.get_type == 10 then -- 杂货商店
			SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopSundry]();
		end
	else
		msg_activity.cg_recruit_get_award(t.float_value);
	end
end

function RecruitUI:on_click_head_detail( cardUI )
	app.log("--------------- 点击头像" .. tostring(cardUI.cardInfo.number));
	RecruitDetalUI:new(cardUI.cardInfo.number);
end

function RecruitUI:set_deff_time( )
	local diffSec = self.m_end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
	self.lab_time:set_text("活动倒计时:" .. day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec) .. "");   
	if diffSec <= 0 then
	    if self.updateTimer ~= 0 then 
	        timer.stop(self.updateTimer);
	        self.updateTimer = 0;
	    end
	end
end
function RecruitUI:gc_recruit_states( end_time, vecRecruitStates )
	app.log("---------- end_time:" .. end_time .. "---- vec:" .. table.tostring(vecRecruitStates));

	self.m_end_time = end_time;
	self:set_deff_time();
	if self.updateTimer == 0 then
		self:set_deff_time(); 
        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
    end

	self.m_vec_back_data = vecRecruitStates;
	table.sort( self.m_vec_back_data, function ( a, b )
		return a.id > b.id
	end );

	self:UpdateUIForBack();
end

function RecruitUI:gc_get_recruit_back( rid )
	local item_config_data = ConfigManager.Get(EConfigIndex.t_recruit_get, rid);
	local award = {};
	for k,v in pairs(item_config_data.award) do
		table.insert(award, {id = v.item_id, count = v.item_num});
	end
	CommonAward.Start(award);

	msg_activity.cg_get_recruit_states();
end