VipPackingGiveUI = Class('VipPackingGiveUI', UiBaseClass)

function VipPackingGiveUI:Init(data)
	
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop.assetbundle";
	UiBaseClass.Init(self, data);

end

--重新加载
function VipPackingGiveUI:Restart(data)
	UiBaseClass.Restart(self, data);

	self.data = data;
	self.parent = data.parent;
	self.ui = data and data.obj;
	self:InitUI();
end

--注册方法
function VipPackingGiveUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc['on_btn_up'] = Utility.bind_callback(self, self.on_btn_up);
	self.bindfunc['on_btn_next'] = Utility.bind_callback(self, self.on_btn_next);
	self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
	
end


--注册消息分发回调函数
function VipPackingGiveUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	-- NoticeManager.BeginListen(ENUM.NoticeType.VipDataChange, self.bindfunc["on_vip_change"]);
	-- PublicFunc.msg_regist(msg_store.gc_get_vip_rewards_rst, self.bindfunc["get_vip_rewards"])
end

--注销消息分发回调函数
function VipPackingGiveUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	-- NoticeManager.EndListen(ENUM.NoticeType.VipDataChange, self.bindfunc["on_vip_change"]);
	-- PublicFunc.msg_unregist(msg_store.gc_get_vip_rewards_rst, self.bindfunc["get_vip_rewards"])
end

--初始化数据
function VipPackingGiveUI:InitData(data)
	UiBaseClass.InitData(self, data);

	self.m_every_ui = {};
	self.m_every_smallItem_ui = {};

	self.m_my_vip_level = 0;
	self.m_cur_vip = 0;
end

--销毁数据
function VipPackingGiveUI:DestroyUi()
	
	if self.ui then
		self.ui:set_active(false);
		self.ui = nil;
	end

	if self.m_my_uiPlayerHead then
		self.m_my_uiPlayerHead:DestroyUi();
		self.m_my_uiPlayerHead = nil;
	end

	for k,v in pairs(self.m_every_smallItem_ui) do
		if v then
			v:DestroyUi();
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

--初始化UI
function VipPackingGiveUI:InitUI(asset_obj)
	-- UiBaseClass.InitUI(self, asset_obj)

	if self.ui == nil then return end
	
	if self.parent then
		self.ui:set_parent(self.parent);
	end
	self.ui:set_active(true);

	self.cur_vip_txt = ngui.find_label(self.ui, "sp_yellow_heart/lab_num");
	if self.cur_vip_txt then
		self.cur_vip_txt:set_text("");
	end
	self.lab_title = ngui.find_label(self.ui, "sp_yellow_heart/lab_title");
	self.lab_title:set_text("");
	self.up_vip_txt = ngui.find_label(self.ui, "sp_yellow_gift/lab_gift");
	if self.up_vip_txt then
		self.up_vip_txt:set_text("");
	end

	self.m_lab_discribe = ngui.find_label(self.ui, "sp_gift_di/lab_describe");
	self.m_lab_discribe:set_active(false);

	local cardInfo = nil;
	for i = 1, 4 do
		self.m_every_ui[i] = self.ui:get_child_by_name("sp_gift_di/new_small_card_item"..i);
		cardInfo = CardProp:new({number = 1});
		if self.m_every_smallItem_ui[i] == nil then
			self.m_every_smallItem_ui[i] = UiSmallItem:new({obj = nil, parent = self.m_every_ui[i], cardInfo = cardInfo, delay = 100});
		end
	end

	self.scroll_view = ngui.find_scroll_view(self.ui, "panel");
	self.wrap_list = ngui.find_wrap_list(self.ui, "panel/wrap_list");
	self.wrap_list:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
	self.wrap_list:set_min_index(0);
    self.wrap_list:set_max_index(-1);
    self.wrap_list:reset();

    self.txt_head = ngui.find_label(self.ui, "sp_gift_di/txt_head");
    if self.txt_head then
    	self.txt_head:set_active(false);
    end

    self.sp_head_di_item = self.ui:get_child_by_name("sp_gift_di/sp_head_di_item");
    if self.sp_head_di_item then
    	-- self.m_my_uiPlayerHead = UiPlayerHead:new({parent=self.sp_head_di_item});
    	self.sp_head_di_item:set_active(false);
    end

    self.m_vip_data = g_dataCenter.player:GetVipData();
    self.m_my_vip_level = self.m_vip_data.level;
    self.m_cur_vip = self.m_vip_data.level;
    if self.m_cur_vip < 0 then
    	self.m_cur_vip = 0;
    end
    self.m_min_vip = 0;
    self.m_max_vip = g_dataCenter.player:GetVipMaxLevel();
    app.log("self.m_max_vip:" .. self.m_max_vip)

    self.btn_up = ngui.find_button(self.parent, "btn_left");
    if self.btn_up then
    	self.btn_up:set_active(true);
	    self.btn_up:reset_on_click();
	    self.btn_up:set_on_click(self.bindfunc["on_btn_up"]);
	end

	self.btn_next = ngui.find_button(self.parent, "btn_right");
	if self.btn_next then
		self.btn_next:set_active(true);
    	self.btn_next:reset_on_click();
    	self.btn_next:set_on_click(self.bindfunc["on_btn_next"]);
    end

	self:UpdateUI();
end

function VipPackingGiveUI:UpdateUI( )
	app.log("self.m_cur_vip:" .. self.m_cur_vip .. " self.m_max_vip:" .. self.m_max_vip)
	self.btn_up:set_active(self.m_cur_vip > self.m_min_vip);
	self.btn_next:set_active(self.m_cur_vip < self.m_max_vip);
	-- local vip_data = g_dataCenter.player:GetVipDataConfigByLevel( self.m_cur_vip );
	local vip_config = g_dataCenter.player:GetVipConfigByLevel(self.m_cur_vip );
	self.m_current_item_data = {};
	if vip_config then
		local index_num = 0;
		for k,v in pairs(vip_config) do
			if v.des ~= "" and v.des ~= "0" and v.des ~= 0 then
				index_num = index_num + 1;
				table.insert(self.m_current_item_data, v);
			end
		end

		table.sort(self.m_current_item_data, function ( a, b )
			return a.level_star < b.level_star;
		end)

		self.wrap_list:set_min_index(0);
	    self.wrap_list:set_max_index(index_num - 1);
	    self.wrap_list:reset();
	    self.scroll_view:reset_position();
	-- end

		local vip_data = nil;
		if vip_config and vip_config[1] then
			vip_data = vip_config[1];
		end
		if vip_data then
			self.lab_title:set_text(tostring(vip_data.tittle or ""));
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
				self.m_lab_discribe:set_active(false);
			else
				for i=1,4 do
					self.m_every_ui[i]:set_active(false);
				end
				self.m_lab_discribe:set_active(true);
			end
			if self.cur_vip_txt then
				self.cur_vip_txt:set_text(tostring(vip_data.level or 0));
			end
			local up_vip = vip_data.level - 1;
			if up_vip <= 0 then
				up_vip = 0;
			end
			if self.up_vip_txt then
				self.up_vip_txt:set_text(tostring(up_vip));
			end
			if self.m_my_uiPlayerHead then
				-- self.m_my_uiPlayerHead:SetVipLevel(g_dataCenter.player.vip);
				-- self.m_my_uiPlayerHead:SetRoleId(vip_data.model_id);
			end
		end		
	end
end

function VipPackingGiveUI:init_item_wrap_content( obj,b,real_id )
	local index = math.abs(real_id) + 1;
    local index_b = math.abs(b) + 1;
    app.log("index:" .. index .. " index_b:" .. index_b);

    local vip_data = self.m_current_item_data[index];
    if vip_data then
    	local lab_num = ngui.find_label(obj, "sp_title/lab_num");
    	local lab_num2 = ngui.find_label(obj, "sp_title/lab_num2");
    	lab_num:set_text("[8C4213FF]"..tostring(vip_data.level).."[-]" );
    	lab_num2:set_text("[8C4213FF]-".. tostring(vip_data.level_star).."[-]");
    	local lab_describe = ngui.find_label(obj, "lab_describe");
    	lab_describe:set_text(tostring(vip_data.des or ""));

    	local is_gray = false;
    	if self.m_cur_vip > self.m_my_vip_level then
    		is_gray = true;
		elseif self.m_cur_vip == self.m_my_vip_level then
			is_gray = index > self.m_vip_data.level_star;
    	end
    	if self.m_cur_vip == 0 then
    		is_gray = false;
    	end
    	 
    	local r,g,b,a = 1,1,1,1;
    	if is_gray then
    		r=0;g=0;b=0;a=1;
    	end
    	local sp_title = ngui.find_sprite(obj, "sp_title");
    	sp_title:set_color(r,g,b,a);
    	local sp_heart = ngui.find_sprite(obj, "sp_title/sp_heart");
    	sp_heart:set_color(r,g,b,a);
    	local sp_point = ngui.find_sprite(obj, "sp_point");
    	sp_point:set_color(r,g,b,a);
    	local sp_bk = ngui.find_sprite(obj, "sp_bk");
    	sp_bk:set_color(r,g,b,a);

    	lab_num:set_color(r,g,b,a);
    	lab_num2:set_color(r,g,b,a);
    end

end

function VipPackingGiveUI:on_btn_up( t )

	self.m_cur_vip = self.m_cur_vip - 1;
	self.btn_up:set_active(true);
	if self.m_cur_vip <= 0 then
		self.m_cur_vip = 0;
	end
	self:UpdateUI();
end

function VipPackingGiveUI:on_btn_next( t )
	self.m_cur_vip = self.m_cur_vip + 1;
	self.btn_up:set_active(true);
	if self.m_cur_vip > self.m_max_vip then
		self.m_cur_vip = self.m_max_vip;
	end
	self:UpdateUI();
end

function VipPackingGiveUI:GetMinVip( )
	return 0;
end

function VipPackingGiveUI:GetMaxVip( )
	local max = -1;
	local vip_table = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
	for k,v in pairs(vip_table) do
		max = max + 1;
	end
	return max;
end

function VipPackingGiveUI:GetVipDataBy( ... )
	-- body
end
