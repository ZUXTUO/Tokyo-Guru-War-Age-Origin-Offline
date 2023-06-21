VipPackingGiftUI = Class('VipPackingGiftUI', UiBaseClass)

local function _GetVipRewardsState(level)
	return bit.bit_and(g_dataCenter.player.vip_reward_flag, bit.bit_lshift(1, level)) > 0
end

local TAB_NUM = 1;

--重新加载
function VipPackingGiftUI:Restart(data)
	UiBaseClass.Restart(self, data);

	self.data = data;
	self.parent = data.parent;
	self.ui = data and data.obj;
	self:InitUI();
end

--注册方法
function VipPackingGiftUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_btn_get_every"] = Utility.bind_callback(self, self.on_btn_get_every);
	self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
	self.bindfunc["on_vip_award_btn"] = Utility.bind_callback(self, self.on_vip_award_btn);
	self.bindfunc["go_to_store"] = Utility.bind_callback(self, self.go_to_store);

	self.bindfunc['on_btn_up'] = Utility.bind_callback(self, self.on_btn_up);
	self.bindfunc['on_btn_next'] = Utility.bind_callback(self, self.on_btn_next);
	self.bindfunc["OnListStop"]     = Utility.bind_callback(self, self.OnListStop)

	self.bindfunc["gc_get_vip_every_reward"] = Utility.bind_callback(self, self.gc_get_vip_every_reward);
	self.bindfunc["get_vip_rewards"] = Utility.bind_callback(self, self.get_vip_rewards);
end

--取消注册
function VipPackingGiftUI:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function VipPackingGiftUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	
	PublicFunc.msg_regist(player.gc_get_vip_every_reward, self.bindfunc["gc_get_vip_every_reward"])
	PublicFunc.msg_regist(msg_store.gc_get_vip_rewards_rst, self.bindfunc["get_vip_rewards"])
end

--注销消息分发回调函数
function VipPackingGiftUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	
	PublicFunc.msg_unregist(player.gc_get_vip_every_reward, self.bindfunc["gc_get_vip_every_reward"])
	PublicFunc.msg_unregist(msg_store.gc_get_vip_rewards_rst, self.bindfunc["get_vip_rewards"])
end

--初始化数据
function VipPackingGiftUI:InitData(data)
	UiBaseClass.InitData(self, data);

	self.m_every_ui = {};
	self.m_every_smallItem_ui = {};

	self.m_wrap_smallItem_ui = {};

	self.m_vip_level = 0;

	self.beginIndex = 0;
	self.max_index = 0;
	self.cur_index = 0;
end

--销毁数据
function VipPackingGiftUI:DestroyUi()
	
	if self.ui then
		self.ui:set_active(false);
		self.ui = nil;
	end

	for k,v in pairs(self.m_every_smallItem_ui) do
		if v then
			v:DestroyUi();
			v = nil;
		end
	end

	for k,v in pairs(self.m_wrap_smallItem_ui) do
		if v then
			for k1,v1 in pairs(v) do
				if v1 then
					v1:DestroyUi();
					v1 = nil;
				end
			end
			v = nil;
		end
	end

	for k,v in pairs(self.data) do
		if v then
			v = nil;
		end
	end
	self.data = nil;

	UiBaseClass.DestroyUi(self);
end

function VipPackingGiftUI:Show(  )
	-- self.wrap_content:set_min_index(0);
 --    self.wrap_content:set_max_index(-1);
 --    self.wrap_content:reset();
 --    self.scroll_view:reset_position();

	-- self:UpdateUI();
end

--初始化UI
function VipPackingGiftUI:InitUI(asset_obj)
	if self.ui == nil then return end
	
	if self.parent then
		self.ui:set_parent(self.parent);
	end
	self.ui:set_active(true);

	local cardInfo = nil;
	for i = 1, 4 do
		self.m_every_ui[i] = self.ui:get_child_by_name("sp_gift_di/new_small_card_item"..i);
		cardInfo = CardProp:new({number = 1});
		if self.m_every_smallItem_ui[i] == nil then
			self.m_every_smallItem_ui[i] = UiSmallItem:new({obj = nil, parent = self.m_every_ui[i], cardInfo = cardInfo, delay = 100});
		end
	end

	self.btn_get_every = ngui.find_button(self.ui, "sp_gift_di/btn_gift");
	self.btn_get_every_lab = ngui.find_label(self.ui, "sp_gift_di/btn_gift/animation/lab");
	-- self.btn_get_every_lab:set_text("");

	self.sp_art_font = ngui.find_sprite(self.ui, "sp_gift_di/sp_art_font");
	self.sp_art_font:set_active(false);

	self.lab_describe = ngui.find_label(self.ui, "sp_gift_di/lab_describe");
	self.lab_describe:set_active(false);

	-- self.scroll_view = ngui.find_scroll_view(self.ui, "scroll_view/panel_list");
	self.wrap_content = ngui.find_enchance_scroll_view(self.ui, "panel_list");
	self.wrap_content:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
	self.wrap_content:set_on_stop_move(self.bindfunc["OnListStop"]);
	-- self.wrap_content:set_on_stop_move(self.bindfunc["OnListStop"]);
	-- self.wrap_content:set_min_index(0);
 --    self.wrap_content:set_max_index(-1);
 --    self.wrap_content:reset();
 --    self.scroll_view:reset_position();

    self.btn_up = ngui.find_button(self.parent, "btn_left");
    if self.btn_up then
    	self.btn_up:set_active(false);
	    self.btn_up:reset_on_click();
	    self.btn_up:set_on_click(self.bindfunc["on_btn_up"]);
	end

	self.btn_next = ngui.find_button(self.parent, "btn_right");
	if self.btn_next then
		self.btn_next:set_active(false);
    	self.btn_next:reset_on_click();
    	self.btn_next:set_on_click(self.bindfunc["on_btn_next"]);
    end

	self:UpdateUI();
end

function VipPackingGiftUI:on_btn_up( t )
	self.cur_index = self.cur_index - TAB_NUM;
	if self.cur_index < 1 then
		self.cur_index = 1;
	end
	self.wrap_content:tween_to_index(self.cur_index);

	self:UpdateBtn();
end

function VipPackingGiftUI:on_btn_next( t )
	self.cur_index = self.cur_index + TAB_NUM;
	if self.cur_index > self.max_index - 2 then
		self.cur_index = self.max_index - 2;
	end
	self.wrap_content:tween_to_index(self.cur_index);

	self:UpdateBtn();
end

function VipPackingGiftUI:UpdateBtn( )
	self.btn_up:set_active(self.cur_index > 1);
	self.btn_next:set_active(self.cur_index < self.max_index - 2);
end

function VipPackingGiftUI:OnListStop(index)
    self.cur_index = index;
    self:UpdateBtn();
end

function VipPackingGiftUI:UpdateUI( )
	local vip_data = g_dataCenter.player:GetVipData();
	self.m_vip_level = g_dataCenter.player.vip;
	local is_every_get = false;
	if vip_data then
		local every_data = vip_data.every_day_reward;
		if every_data and every_data ~= "" and every_data ~= "0" and every_data ~= 0 then
			local reward_data = nil;
			local cardInfo = nil;
			for i=1,4 do
				reward_data = every_data[i];
				if reward_data then
					self.m_every_ui[i]:set_active(true);
					cardInfo = CardProp:new({number = reward_data.id, count = reward_data.num});
					self.m_every_smallItem_ui[i]:SetData(cardInfo);
					self.m_every_smallItem_ui[i]:SetCount(reward_data.num);
				else
					self.m_every_ui[i]:set_active(false);
				end
			end
			self.btn_get_every:set_active(true);
			self.lab_describe:set_active(false);
			is_every_get = true;
		else
			for i=1,4 do
				self.m_every_ui[i]:set_active(false);
			end
			self.btn_get_every:set_active(false);
			self.lab_describe:set_active(true);
		end
	end

	local vip_table = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
	table.sort( vip_table, function ( a, b )
		return a.vip < b.vip;
	end )

	self.m_vip_table_data = {};
	local index_num = 0;
	local vip_level = 0;
	for k,v in ipairs(vip_table) do
		if vip_level ~= tonumber(v.level) then
			app.log("vip_level:" .. vip_level .. " v.level:" .. v.level)
			vip_level = tonumber(v.level);
			if v.rewards ~= "0" then
				index_num = index_num + 1;
				self.m_vip_table_data[index_num] = v;
			end
		end
	end
	
	-- app.log("self.m_vip_table_data:" .. table.tostring(self.m_vip_table_data))
	table.sort( self.m_vip_table_data, function ( a, b )
		return a.level < b.level;
	end )

	self.max_index = index_num;
	self.cur_index = 1;
	self.wrap_content:set_maxNum(index_num);
	self.wrap_content:set_showIndex(self.cur_index);
	self.wrap_content:refresh_list();
	self:UpdateBtn();

	-- self.wrap_content:set_min_index(0);
 --    self.wrap_content:set_max_index(index_num - 1);
 --    self.wrap_content:reset();
 --    self.scroll_view:reset_position();

    if g_dataCenter.player.vipEveryGet == 0 then
		-- self.btn_get_every_lab:set_text("领取");
		-- self.btn_get_every:reset_on_click();
		-- self.btn_get_every:set_on_click(self.bindfunc["on_btn_get_every"]);
		-- self.btn_get_every:set_event_value("", 1);

		if is_every_get then
			self.btn_get_every:set_active(true);
			self.btn_get_every:reset_on_click();
			self.btn_get_every:set_on_click(self.bindfunc["on_btn_get_every"]);
			self.btn_get_every:set_event_value("", 1);

			self.sp_art_font:set_active(false);
		else
			self.btn_get_every:set_active(false);
			self.sp_art_font:set_active(false);
		end
	else
		-- self.btn_get_every_lab:set_text("已领取");
		-- self.btn_get_every:reset_on_click();
		-- self.btn_get_every:set_on_click(self.bindfunc["on_btn_get_every"]);
		-- self.btn_get_every:set_event_value("", 0);

		if is_every_get then
			self.btn_get_every:set_active(false);
			self.sp_art_font:set_active(true);
		else
			self.btn_get_every:set_active(false);
			self.sp_art_font:set_active(false);
		end
	end
end

function VipPackingGiftUI:init_item_wrap_content( obj, index )
	-- local index = math.abs(real_id) + 1;
 --    local index_b = math.abs(b) + 1;
 	local index = index;
 	local index_b = obj:get_instance_id();

    app.log("index:" .. index .. " index_b:" .. index_b);
    local vip_config = self.m_vip_table_data[index];
    if vip_config then
    	-- vip_config = vip_config[1];
    	local vip_num_txt = ngui.find_label(obj, "sp_heart/lab");
    	local lab_num = ngui.find_label(obj, "sp_heart/lab_num");
    	vip_num_txt:set_text(tostring(vip_config.level or 0));
    	lab_num:set_text("-" .. tostring(vip_config.level_star or 0) );
    	local price_txt = ngui.find_label(obj, "sp_gem1/lab");
    	price_txt:set_text(tostring(vip_config.price or 0));
    	local dis_prict_txt = ngui.find_label(obj, "sp_gem2/lab");
    	dis_prict_txt:set_text(tostring(vip_config.discount_price or 0));

    	if self.m_wrap_smallItem_ui[index_b] == nil then
    		self.m_wrap_smallItem_ui[index_b] = {};
    	end

    	local new_small_card_item = nil;
    	local carditem = nil;
    	local award_data = nil;
    	for i=1,4 do
    		new_small_card_item = obj:get_child_by_name("cont/new_small_card_item"..i);
    		if vip_config.rewards ~= "" and vip_config.rewards ~= nil and vip_config.rewards ~= 0 then
    			award_data = vip_config.rewards[i];
    		end
    		if award_data then
    			new_small_card_item:set_active(true);
	    		carditem = CardProp:new({number = award_data.id, count = award_data.num});
	    		if self.m_wrap_smallItem_ui[index_b][i] == nil then
	    			self.m_wrap_smallItem_ui[index_b][i] = UiSmallItem:new({parent = new_small_card_item, cardInfo = carditem});
	    		else
	    			self.m_wrap_smallItem_ui[index_b][i]:SetData(carditem);
	    		end
	    		self.m_wrap_smallItem_ui[index_b][i]:SetCount(award_data.num);
	    	else
	    		new_small_card_item:set_active(false);
	    	end
    	end
    	local award_grid = ngui.find_grid(obj, "cont");
    	award_grid:reposition_now();

    	local sp_art_font = ngui.find_sprite(obj, "sp_art_font");
    	local btn_buy = ngui.find_button(obj, "btn_buy");
    	local btn_buy_lab = ngui.find_label(obj, "btn_buy/animation/lab");
    	local btn_buy_bg = ngui.find_sprite(obj, "btn_buy/animation/sprite_background");
    	btn_buy:reset_on_click();
    	btn_buy:set_on_click(self.bindfunc["on_vip_award_btn"]);
    	if vip_config.vip <= self.m_vip_level then
    		if _GetVipRewardsState(vip_config.level) then -- 已领取
    			sp_art_font:set_active(true);
    			btn_buy:set_active(false);
    		else
    			sp_art_font:set_active(false);
	    		btn_buy:set_active(true);
	    		btn_buy:set_event_value(tostring(vip_config.vip), 1);
	    		-- btn_buy_bg:set_sprite_name("ty_anniu3");
	    		-- btn_buy_lab:set_text("[5E2B91FF]领取[-]");
	    		-- btn_buy_lab:set_color(1, 1, 1, 1);
	    		PublicFunc.SetButtonShowMode(btn_buy, 1, "sprite_background");
    		end
    	else
    		sp_art_font:set_active(false);
    		btn_buy:set_active(true);
    		btn_buy:set_event_value(tostring(vip_config.vip), 0);
    		-- btn_buy_bg:set_sprite_name("ty_anniu5");
    		-- btn_buy_lab:set_text("[C6C6C6FF]领取[-]");
    		-- btn_buy_lab:set_color(0, 0, 0, 1);
    		PublicFunc.SetButtonShowMode(btn_buy, 3, "sprite_background");
    	end

    end
end

function VipPackingGiftUI:on_btn_get_every( t )
	if g_dataCenter.player.vipEveryGet == 0 and t.float_value == 1 then
		player.cg_get_vip_every_reward( g_dataCenter.player.vip, g_dataCenter.player.vipstar );
	else
		FloatTip.Float("今日礼物已领取");
	end
end

function VipPackingGiftUI:on_vip_award_btn( t )
	if t.float_value == 0 then
		FloatTip.Float("好感度不足");
	elseif t.float_value == 1 then
		local cur_vip = tonumber(t.string_value);
		local vip_data = g_dataCenter.player:GetVipDataConfigByLevel(cur_vip);
		local vip_config = g_dataCenter.player:GetVipConfigByLevel(vip_data.level);
		if vip_config and vip_config[1] then
			table.sort(vip_config, function ( a, b )
				return a.level_star < b.level_star;
			end)
			vip_config = vip_config[1];
		end
		if g_dataCenter.player.crystal >= vip_config.discount_price then
	    	msg_store.cg_get_vip_rewards(cur_vip, vip_config.discount_price);
	    else
	    	HintUI.SetAndShowNew(EHintUiType.two, "钻石不足", "钻石不足！是否前往充值？", nil, {str = "立即前往",func = self["go_to_store"]}, {str = "否",func = nil}, btn3Data, btn4Data)
	    end
	end
	
end

function VipPackingGiftUI:go_to_store( )
	uiManager:PushUi(EUI.StoreUI);
	-- uiManager:ReplaceUi(EUI.StoreUI, "replace")
end

function VipPackingGiftUI:get_vip_rewards(level)

	--展示获得奖励
	local vip_data = g_dataCenter.player:GetVipDataConfigByLevel(level);
	local vip_config = g_dataCenter.player:GetVipConfigByLevel(vip_data.level);
	if vip_config and vip_config[1] then
		table.sort(vip_config, function ( a, b )
			return a.level_star < b.level_star;
		end)
		vip_config = vip_config[1];
	end
	if vip_config and vip_config.rewards ~= "" and vip_config.rewards ~= nil and vip_config.rewards ~= 0 then
    	local award = {};
		for i, v in ipairs(vip_config.rewards) do
			table.insert(award, {id=v.id, count=v.num or 0})
		end
		CommonAward.Start(award)
    end

	self:UpdateUI()
end

function VipPackingGiftUI:gc_get_vip_every_reward( vip, vipstar )
	if g_dataCenter.player.vipEveryGet == 1 then
		-- self.btn_get_every_lab:set_text("已领取");
		self.btn_get_every:set_active(false);
		self.sp_art_font:set_active(true);
		PublicFunc.msg_dispatch("UpdateGiftSpPoint");
		local vip_data = g_dataCenter.player:GetVipData();
		if vip_data then
			local every_data = vip_data.every_day_reward;
			if every_data and every_data ~= "" and every_data ~= "0" and every_data ~= 0 then
				local reward = {};
				for k,v in pairs(every_data) do
					table.insert(reward, {id=v.id, count=v.num});
				end
				if #reward > 0 then
					CommonAward.Start(reward);
				end
			end
		end
	end
end