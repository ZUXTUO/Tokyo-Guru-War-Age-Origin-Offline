MonthSignUi = Class('MonthSignUi', UiBaseClass);

local _labtext = {
	[1] = "本月签到[00FF73FF]%d次[-]";
	[2] = "好感度不足";
	[3] = "是否前往充值?";
	[4] = "立即前往";
	[5] = "取消";
}
--初始化
function MonthSignUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/sign/ui_200_checkin_month.assetbundle";
	UiBaseClass.Init(self, data);
end

function MonthSignUi:Restart()
	-- msg_checkin.cg_get_month_sign_state();
    if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

function MonthSignUi:InitData(data)
	UiBaseClass.InitData(self, data);

	self.m_obj_lists = {};
	self.m_item_cards = {};
	self.m_total_item_cards = {};
end

function MonthSignUi:DestroyUi()
    for k,v in pairs(self.m_item_cards) do
    	v:DestroyUi();
    end
    self.m_item_cards = {};

    for k,v in pairs(self.m_total_item_cards) do
    	v:DestroyUi();
    end
    self.m_total_item_cards = {};

    for k,v in pairs(self.m_obj_lists) do
    	v = nil;
    end
    self.m_obj_lists = {};
    UiBaseClass.DestroyUi(self);
end

function MonthSignUi:ShowNavigationBar()
    return false;
end

function MonthSignUi:Show()
	if UiBaseClass.Show(self) then
	--todo 
	end
end

function MonthSignUi:Hide()
	if UiBaseClass.Hide(self) then
	--todo 
	end
end

function MonthSignUi:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_sign_in"] = Utility.bind_callback(self,self.on_sign_in);
    self.bindfunc["on_total_award"] = Utility.bind_callback(self,self.on_total_award);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);

    self.bindfunc["on_set_month_sign_state"] = Utility.bind_callback(self, self.on_set_month_sign_state);
end

function MonthSignUi:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function MonthSignUi:MsgRegist()
	UiBaseClass.MsgRegist(self);
   	PublicFunc.msg_regist(msg_checkin.gc_month_sign_state, self.bindfunc["on_set_month_sign_state"]);
end

--注销消息分发回调函数
function MonthSignUi:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_checkin.gc_month_sign_state, self.bindfunc["on_set_month_sign_state"]);
end

--加载UI
function MonthSignUi:LoadUI()
	if UiBaseClass.LoadUI(self) then
	end
end

function MonthSignUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("month_sign_Ui");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);
	local sp_fx = nil;
	for i = 1,3 do 
		sp_fx = self.ui:get_child_by_name("animation/cont_left/new_small_card_item"..i.."/fx_checkin_month_left");
		sp_fx:set_local_position(10000,10000,0);
		local tp = {};
		tp.fx = sp_fx;
		function tp:get_pid()
			return 111111100+i;
		end
		function tp.onOver()
			tp.fx:set_local_position(0,0,0);
		end
		Tween.addTween(tp,0.5,{},nil,0,nil,nil,tp.onOver);
	end 
	self.btn_close = ngui.find_button(self.ui, "center_other/animation/content_di_1004_564/btn_cha");
	self.btn_close:set_on_click(self.bindfunc["on_close"]);

    self.grid = ngui.find_grid(self.ui, "center_other/animation/cont_right/sco_view/panel/grid");
    self.grid_obj = self.grid:get_game_object();
    self.list_obj = self.ui:get_child_by_name("center_other/animation/sco_view/panel/grid/list1");
    self.list_obj:set_active(false);

    for i=1, 30 do
	    if self.m_obj_lists[i] == nil then
	    	local item_obj = self.list_obj:clone();
	    	-- item_obj:set_active(false);
	    	item_obj:set_name("item_list_" .. i);
	    	self.m_obj_lists[i] = item_obj;
	    end
    end

    self.lab_font_art = ngui.find_label(self.ui, "center_other/animation/content_di_1004_564/lab_title");
    self.lab_font_art:set_text("");
    -- self.lab_font_art2 = ngui.find_label(self.ui, "center_other/animation/cont_top/sp_bk2/lab_num");
    -- self.lab_font_art2:set_text("");

    self.lab_num_c = ngui.find_label(self.ui, "center_other/animation/cont_right/txt");
    self.lab_num_c:set_text("");

    self.lab_num_total = ngui.find_label(self.ui, "center_other/animation/cont_left/sp_bar/lab_num");
    self.lab_num_total:set_text("");

    self.panel = self.ui:get_child_by_name("center_other/animation/cont_right/sco_view/panel");   

    self.btn_total_award = ngui.find_button(self.ui, "center_other/animation/cont_left/btn");
    -- self.btn_total_award:set_sprite_names("ty_anniu5");
    self.btn_total_award_lab = ngui.find_label(self.ui, "center_other/animation/cont_left/btn/animation/lab");
    -- self.btn_total_award_lab:set_effect_color(1, 1, 1, 1);

    self.btn_total_award_sp = ngui.find_sprite(self.ui, "center_other/animation/cont_left/btn/animation/sp");
    -- self.btn_total_award_sp:set_color(1, 1, 1, 1);
    
    self.btn_total_award_sp_point = ngui.find_sprite(self.ui, "center_other/animation/cont_left/btn/animation/sp_point");
    self.btn_total_award_sp_point:set_active(false);

    local new_small_card_item = nil;
    local fx = nil;
    for i=1,3 do
    	new_small_card_item = self.ui:get_child_by_name("center_other/animation/cont_left/new_small_card_item" .. i);
    	if new_small_card_item then
    		fx = new_small_card_item:get_child_by_name("fx_checkin_month_left");
    		if fx then
    			fx:set_active(false);
    		end
    	end
    	
    end

    local state, t_type, day, states, is_checking = g_dataCenter.signin:GetIsMonth();
    if not is_checking then
        msg_checkin.cg_get_month_sign_state();
    else
        self:on_set_month_sign_state(state, t_type, day, states);
    end
end

function MonthSignUi:on_set_month_sign_state( state, t_type, day, states )
	app.log("------------ " .. tostring(t_type) .. "--" .. tostring(day) .. "--" .. table.tostring(states));
	local sysTime = os.date("*t",system.time());
	local month_config = nil;
    local item_list_config = nil;
    if (tonumber(sysTime.month) % 2) ~= 0 then
    	month_config = ConfigManager._GetConfigTable(EConfigIndex.t_month_sing_in_1);
    else
    	month_config = ConfigManager._GetConfigTable(EConfigIndex.t_month_sing_in_2);
    end
    -- if tonumber(sysTime.month) < 10 then
    -- 	self.lab_font_art:set_text(tostring(sysTime.month));
    -- else
    -- 	self.lab_font_art:set_text("/" .. tostring(sysTime.month));
    -- end
    self.lab_font_art:set_text(tostring(sysTime.month) .. "月");

    local total_config_all = ConfigManager._GetConfigTable(EConfigIndex.t_month_total);
    local total_config = nil;
    local award = {};
    if t_type == 1 then
	    if day > 0 then
	    	award[1] = {id = month_config[day].item_id, count = month_config[day].item_num};
		end
	elseif t_type == 2 then
		if day > 0 then
			-- total_config = total_config_all[states[4]]);

			local all_config_num = #total_config_all;
		    local nextSteep = 0;
		    local steepProgress = 10;
		    local curNum = day;
		    if curNum <= all_config_num then
		    	nextSteep = 0;
		    	total_config = total_config_all[curNum];
		    else
		    	nextSteep = curNum - all_config_num;
		    	total_config = total_config_all[all_config_num];
		    end

			for i,v in ipairs(total_config.award_items) do
				table.insert(award, {id = v.item_id, count = v.num});
			end
		end
	elseif t_type == 3 then
	    if day > 0 then
	    	award[1] = {id = month_config[day].item_id, count = month_config[day].item_num};
	    	if month_config[day].vip_level > 0 and g_dataCenter.player.vip >= month_config[day].vip_level then
	    		award[2] = {id = month_config[day].item_id, count = month_config[day].item_num};
	    	end
		end
	end

	if #award > 0 then
		CommonAward.Start(award);
	end

	local is_point = false;
	local item_obj = nil;
    for i=1, #month_config do
    	if self.m_obj_lists[i] == nil then
	    	item_obj = self.list_obj:clone();
	    	item_obj:set_name("item_list_" .. i);
	    	self.m_obj_lists[i] = item_obj;
	    else
	    	item_obj = self.m_obj_lists[i];
	    end
	    item_obj:set_active(true);

	    -- local month_num_tex = ngui.find_label(item_obj, "sp_di2/txt"); -- 天数
    	-- month_num_tex:set_text("");

    	local sp_di3 = ngui.find_sprite(item_obj, "sp_di"); -- vip dobule
    	sp_di3:set_active(false);

    	local sp_draw = ngui.find_sprite(item_obj, "sp_black_di"); -- 已签到标签
    	sp_draw:set_active(false);

    	local sp_font_art2 = ngui.find_sprite(item_obj, "sp_font_art2"); -- vip 继续领取
    	sp_font_art2:set_active(false);

    	local new_small_card_item = item_obj:get_child_by_name("new_small_card_item");

    	-- local fx = item_obj:get_child_by_name("new_small_card_item/fx");
    	-- fx:set_active(false);

    	-- local item_button = ngui.find_button(item_obj:get_parent(), "item_list_" .. i);
    	-- item_button:reset_on_click();
    	-- item_button:set_on_click(self.bindfunc["on_sign_in"]);

    	item_list_config = month_config[i];

    	local line_fx = item_obj:get_child_by_name("fx_checkin_month_right");
	    line_fx:set_active(false);
    	if item_list_config.is_line == 1 then
    		-- fx:set_active(true);
    		line_fx:set_active(true);
    	end

        local sp_vip = ngui.find_sprite(item_obj, "sp_di");
        sp_vip:set_active(false);
        local vipLevelTex = ngui.find_label(item_obj, "sp_di/lab");
        vipLevelTex:set_active(false);
        local lab_vip = ngui.find_label(item_obj, "sp_di/sp_v/lab_v");
        local lab_vip_star = ngui.find_label(item_obj, "sp_di/sp_v/lab_v2");
		if item_list_config.vip_level > 0 then
			sp_di3:set_active(true);
            sp_vip:set_active(true);
			-- PublicFunc.SetImageVipLevel(sp_vip, item_list_config.vip_level);
            vipLevelTex:set_active(true);
            if lab_vip and lab_vip_star then
                local cur_vipdata = g_dataCenter.player:GetVipDataByLevel(item_list_config.vip_level);
                if cur_vipdata then
                    lab_vip:set_text(tostring(cur_vipdata.level))
                    lab_vip_star:set_text("-"..tostring(cur_vipdata.level_star));
                end
            end
		end

	    local carditem = CardProp:new({number = item_list_config.item_id, count = item_list_config.item_num});
	    if not self.m_item_cards[i] then
	        self.m_item_cards[i] = UiSmallItem:new({parent = new_small_card_item, cardInfo = carditem});
	    else
	        self.m_item_cards[i]:SetData(carditem); 
	    end    
	    self.m_item_cards[i]:SetCount(item_list_config.item_num);
	    self.m_item_cards[i]:SetShine(false);
	    -- local sp_di2 = ngui.find_sprite(item_obj, "sp_di2");
	    -- sp_di2:set_sprite_name("st_biaozhi_d2");

	    
	    local checking_fx = item_obj:get_child_by_name("fx_checkin_month");
	    checking_fx:set_active(false);

	    
    	if (i - 1) < states[1] then -- 之前已领取
    		sp_draw:set_active(true);
    		-- sp_di3:set_active(false);
    		-- item_button:set_event_value(tostring(i), 0);
    		self.m_item_cards[i]:SetOnClicked(self.bindfunc["on_sign_in"], tostring(i), 0);
    		-- local the_config = month_config[i-1];
    		if item_list_config then
    			sp_di3:set_active(item_list_config.vip_level > 0);
    		end
    		line_fx:set_active(false);
    		checking_fx:set_active(false);
		elseif (i - 1) == states[1] then --当天的状态
			if states[2] == 0 then -- 未领取
				checking_fx:set_active(true);
				-- item_button:set_event_value(tostring(i), 1);
				self.m_item_cards[i]:SetOnClicked(self.bindfunc["on_sign_in"], tostring(i), 1);
				-- sp_di2:set_sprite_name("st_biaozhi_d1");
				-- g_dataCenter.activityReward:SetSignIn30RedPoint(true);
				self.m_item_cards[i]:SetShine(true);
				is_point = true;
			elseif states[2] == 1 then  -- 已领取，查看vip状态
				
				if item_list_config.vip_level > 0 then
					sp_font_art2:set_active(true);
					checking_fx:set_active(false);
					-- g_dataCenter.activityReward:SetSignIn30RedPoint(true);
					is_point = false;
					if g_dataCenter.player.vip >= item_list_config.vip_level then
						-- item_button:set_event_value(tostring(i), 2);
						self.m_item_cards[i]:SetOnClicked(self.bindfunc["on_sign_in"], tostring(i), 2);
                        is_point = true;
					else
						-- item_button:set_event_value(tostring(i), 3);
						self.m_item_cards[i]:SetOnClicked(self.bindfunc["on_sign_in"], tostring(i), 3);
					end
					-- sp_di2:set_sprite_name("st_biaozhi_d1");
				else
					sp_draw:set_active(true);
					-- g_dataCenter.activityReward:SetSignIn30RedPoint(false);
					is_point = false;
					-- item_button:set_event_value(tostring(i), 0);
    				self.m_item_cards[i]:SetOnClicked(self.bindfunc["on_sign_in"], tostring(i), 0);
				end
			else -- vip 都已领取
				sp_draw:set_active(true);
				-- item_button:set_event_value(tostring(i), 0);
				self.m_item_cards[i]:SetOnClicked(self.bindfunc["on_sign_in"], tostring(i), 0);
				-- g_dataCenter.activityReward:SetSignIn30RedPoint(false);
				is_point = false;
				checking_fx:set_active(false);
				line_fx:set_active(false);
			end
		else
			-- item_button:set_event_value("", 0);
			self.m_item_cards[i]:SetOnClicked(self.bindfunc["on_sign_in"], tostring(i), 0);
			-- g_dataCenter.activityReward:SetSignIn30RedPoint(false);
		end
    end
    self.grid:reposition_now();

    -- 累计相关
    local total_res = "month_sign_Ui/center_other/animation/";

    -- local lab = ngui.find_label(self.ui, total_res .. "cont1/lab");
    local month_in_num = states[1];
    if states[2] > 0 then
    	month_in_num = month_in_num + 1;
    end

    self.lab_num_c:set_text(string.format(_labtext[1], month_in_num));

    local all_config_num = #total_config_all;
    local nextSteep = 0;
    local steepProgress = 10;
    local dayProgress = 10;
    local curNum = states[4] + 1;

    -- app.log("---------- " .. curNum .. "----" .. all_config_num);
    -- do return end
    if curNum <= all_config_num then
    	nextSteep = 0;
    	total_config = total_config_all[curNum];
    else
    	nextSteep = curNum - all_config_num;
    	total_config = total_config_all[all_config_num];
    end

    -- local lab_num = ngui.find_label(self.ui, total_res .. "cont2/sp_bar/lab_num");
    self.lab_num_total:set_text("[FCD901FF]"..states[3].."[-]" .. "/" .. (total_config.total_days + nextSteep * dayProgress) .. "天");

    
    

    -- local sp_tishi = ngui.find_sprite(self.ui, total_res .. "cont2/btn/sp_tishi");
    local is_get_total = false;
    if states[3] >= (total_config.total_days + nextSteep * dayProgress) then
    	self.btn_total_award:set_enable(true);
    	-- sp_tishi:set_active(true);
    	-- self.btn_total_award_lab:set_effect_color(94/255, 43/255, 145/255, 1);
    	self.btn_total_award_lab:set_text("[973900FF]点击领取[-]");
    	self.btn_total_award_sp:set_sprite_name("an1");
    	-- self.btn_total_award:set_sprite_names("an1");
    	self.btn_total_award_sp_point:set_active(true);
    	
    	is_get_total = true;

    	self.btn_total_award:set_event_value("", states[4] + 1);
    	self.btn_total_award:set_on_click(self.bindfunc["on_total_award"]);
    else
    	self.btn_total_award:set_enable(false);
    	-- sp_tishi:set_active(false);
    	-- self.btn_total_award_lab:set_effect_color(1, 1, 1, 1);
    	self.btn_total_award_lab:set_text("[C6C6C6FF]点击领取[-]");
    	self.btn_total_award_sp:set_sprite_name("an2");
    	-- self.btn_total_award:set_sprite_names("an2");
    	self.btn_total_award_sp_point:set_active(false);
    	self.btn_total_award:set_event_value("", 0);
    	self.btn_total_award:set_on_click(self.bindfunc["on_total_award"]);

    	app.log("---------- 来了")
    end

--    app.log("0---------------- m_is_sign_30_red:is_point:" .. tostring(is_point));
--    app.log("0---------------- m_is_sign_30_red:is_get_total:" .. tostring(is_get_total));
    if is_point or is_get_total then
    	g_dataCenter.activityReward:SetSignIn30RedPoint(true);
    else
    	g_dataCenter.activityReward:SetSignIn30RedPoint(false);
    end

    local total_award_data = nil;
    local item_config = nil;

    local sp_frame = nil;
    local t_lab = nil;
    local t_texture = nil;
    local new_small_card_item = nil;
    local carditem = nil;
    local fx = nil;
    
    for i = 1, 3 do
    	new_small_card_item = self.ui:get_child_by_name("center_other/animation/cont_left/new_small_card_item" .. i);
    	fx = new_small_card_item:get_child_by_name("fx_checkin_month_left");
    	fx:set_active(false);
    	if i <= #total_config.award_items then
    		new_small_card_item:set_active(true);
    		if is_get_total then
    			fx:set_active(true);
    		end
	    	total_award_data = total_config.award_items[i];
	    	carditem = CardProp:new({number = total_award_data.item_id, count = total_award_data.num + nextSteep * steepProgress});
	    	if not self.m_total_item_cards[i] then
	    		self.m_total_item_cards[i] = UiSmallItem:new({parent = new_small_card_item, cardInfo = carditem});
	    	else
		        self.m_total_item_cards[i]:SetData(carditem); 
		    end    
	    	self.m_total_item_cards[i]:SetCount(total_award_data.num + nextSteep * steepProgress);
	    	

	    	-- item_config = ConfigManager.Get(EConfigIndex.t_item, total_award_data.item_id);

	    	-- sp_frame:set_active(true);
	    	-- t_lab = ngui.find_label(sp_frame,"lab");
		    -- t_texture = ngui.find_texture(sp_frame, "Texture");
    	
	    	-- t_lab:set_text(tostring(total_award_data.num + nextSteep * steepProgress));
	    	-- t_texture:set_texture(item_config.small_icon);
	    else
	    	fx:set_active(false);
	    	new_small_card_item:set_active(false);
	    end
    end

    if states[1] > 18 then
    	self.panel:set_local_position(0, 28, 0);
    end
end

function MonthSignUi:on_sign_in( t )
	app.log("------------------- click: " .. t.float_value)
	if t.float_value == 1 then -- 第一次可领取
		msg_checkin.cg_sign_in_c_day(tonumber(t.string_value), 0);
	elseif t.float_value == 2 then -- vip可领取
		msg_checkin.cg_sign_in_c_day(tonumber(t.string_value), 1);
	elseif t.float_value == 3 then -- vip 不可领取，前往充值
		-- uiManager:PushUi(EUI.StoreUI);
		HintUI.SetAndShowNew(EHintUiType.two, 
			_labtext[2], _labtext[3], 
			nil,
            {func=function() uiManager:PushUi(EUI.StoreUI) end, str=_labtext[4]},
            {str=_labtext[5]} );
	elseif t.float_value == 0 then -- 不管
	end
end

function MonthSignUi:on_total_award( t )
	if t.float_value > 0 then
		msg_checkin.cg_get_total(t.float_value);
	end
end

function MonthSignUi:on_close(  )
	uiManager:PopUi();
end

