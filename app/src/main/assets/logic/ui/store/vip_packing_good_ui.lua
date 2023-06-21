VipPackingGoodUI = Class('VipPackingGoodUI', UiBaseClass)

local _txt = {
	[1] = "好感度[07EE0AFF]+%d[-]"
}

--重新加载
function VipPackingGoodUI:Restart(data)
	UiBaseClass.Restart(self, data);

	self.data = data;
	self.parent = data.parent;
	self.ui = data and data.obj;
	self:InitUI();
end

--注册方法
function VipPackingGoodUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	
	self.bindfunc["on_btn_good"] = Utility.bind_callback(self, self.on_btn_good);
	self.bindfunc["on_btn_good_press"] = Utility.bind_callback(self, self.on_btn_good_press);
	
	self.bindfunc["on_yijian_btn_good1"] = Utility.bind_callback(self, self.on_yijian_btn_good1);
	self.bindfunc["on_yijian_btn_good2"] = Utility.bind_callback(self, self.on_yijian_btn_good2);
	self.bindfunc["on_btn_shop"] = Utility.bind_callback(self, self.on_btn_shop);
	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
	self.bindfunc["up_level_time"] = Utility.bind_callback(self, self.up_level_time);

	self.bindfunc["gc_vip_add_yijian_good"] = Utility.bind_callback(self, self.gc_vip_add_yijian_good);
end

--取消注册
function VipPackingGoodUI:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function VipPackingGoodUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	
	PublicFunc.msg_regist(player.gc_vip_add_yijian_good, self.bindfunc["gc_vip_add_yijian_good"])
end

--注销消息分发回调函数
function VipPackingGoodUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	
	PublicFunc.msg_unregist(player.gc_vip_add_yijian_good, self.bindfunc["gc_vip_add_yijian_good"])
end

--初始化数据
function VipPackingGoodUI:InitData(data)
	UiBaseClass.InitData(self, data);
	
	self.m_item_ui_list = {};
	self.m_click_btn_name = "";
	self.m_current_click_index = 0;
	self.m_current_num = 0;
	self.m_click_time = 0;

	self.m_old_vip = 0;
	self.m_old_vipdata = nil;

	self.m_update_vip = 0;
	self.m_update_vipstar = 0;
	self.m_update_vipexp = 0;

	self.m_press_item_id = 0;
	self.m_press_up_level_type = -1;
end

--销毁数据
function VipPackingGoodUI:DestroyUi()
	if self.ui then
		self.ui:set_active(false);
		-- self.ui:set_parent(nil);
		-- self.parent = nil;
		self.ui = nil;
	end

	for k,v in pairs(self.m_item_ui_list) do
		if v then
			v = nil;
		end
	end
	self.m_item_ui_list = {};

	for k,v in pairs(self.data) do
		if v then
			v = nil;
		end
	end
	self.data = nil;

	UiBaseClass.DestroyUi(self);
end

function VipPackingGoodUI:Show(  )
	self:UpdateUI();
end

--初始化UI
function VipPackingGoodUI:InitUI(asset_obj)
	
	if self.ui == nil then return end
	
	if self.parent then
		self.ui:set_parent(self.parent);
	end
	self.ui:set_active(true);


	self.lab_title = ngui.find_label(self.ui, "sp_effect/lab_title");
	self.lab_title:set_text("");

	self.cont1 = self.ui:get_child_by_name("cont1");
	
	self.cont2 = self.ui:get_child_by_name("cont2");
	self.cont2:set_active(false);
	self.m_btn_shop = ngui.find_button(self.cont2, "btn_shop");
	self.m_btn_shop:reset_on_click();
	self.m_btn_shop:set_on_click(self.bindfunc["on_btn_shop"]);

	local dis_item_data = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_vip_up_item).data;

	local i_list = nil;
	local btn = nil;
	for i=1,2 do
		self.m_item_ui_list[i] = {};
		self.m_item_ui_list[i].data = dis_item_data[i];
		self.m_item_ui_list[i].item_num = g_dataCenter.package:GetCountByNumber(self.m_item_ui_list[i].data.item_id);
		if i == 1 then
			self.m_item_ui_list[i].btn = ngui.find_button(self.cont1, "btn_left");
			self.m_item_ui_list[i].btn_txt = ngui.find_label(self.cont1, "btn_left/animation/sp_tab/lab_num");
			self.m_item_ui_list[i].good_txt = ngui.find_label(self.cont1, "btn_left/animation/lab");
			self.m_item_ui_list[i].btn_bg = ngui.find_sprite(self.cont1, "btn_left/animation/sprite_background");
		elseif i == 2 then
			self.m_item_ui_list[i].btn = ngui.find_button(self.cont1, "btn_right");
			self.m_item_ui_list[i].btn_txt = ngui.find_label(self.cont1, "btn_right/sp_tab/lab_num");
			self.m_item_ui_list[i].good_txt = ngui.find_label(self.cont1, "btn_right/animation/lab");
			self.m_item_ui_list[i].btn_bg = ngui.find_sprite(self.cont1, "btn_right/animation/sprite_background");
		end
	end
	self.m_yijian_btn = ngui.find_button(self.cont1, "btn_give");
	self.m_yijian_btn:reset_on_click();
	self.m_yijian_btn:set_on_click(self.bindfunc["on_yijian_btn_good2"]);
	self.m_yijian_btn_sp_point = ngui.find_sprite(self.cont1, "btn_give/animation/sp_point");
	self.m_yijian_btn_sp_point:set_active(false);

	self.btn_up = ngui.find_button(self.parent, "btn_left");
    if self.btn_up then
    	self.btn_up:set_active(false);
    end
    self.btn_next = ngui.find_button(self.parent, "btn_right");
    if self.btn_next then
    	self.btn_next:set_active(false);
    end

	self:UpdateUI();
end

function VipPackingGoodUI:UpdateUI( )
	local vip_config = g_dataCenter.player:GetVipDataConfigByLevel(g_dataCenter.player.vip);
	local vip_data = g_dataCenter.player:GetVipData();
	
	if vip_data and vip_config then
		local is_max = g_dataCenter.player.vip >= self:GetVipMax()

		self.cont1:set_active(not is_max);
		self.cont2:set_active(is_max);

		self.lab_title:set_text(vip_data.tittle or "");
		local is_yijian = false;
		for k,v in pairs(self.m_item_ui_list) do
			
			v.good_txt:set_text(string.format(_txt[1], (v.data.item_exp or "")));

			local cont = g_dataCenter.package:GetCountByNumber(v.data.item_id);			
			v.btn_txt:set_text(tostring(cont or "0"));

			v.btn:reset_on_click();
			if cont > 0 then				
				v.btn:set_on_ngui_press(self.bindfunc["on_btn_good_press"]);
				is_yijian = true;
				v.btn_bg:set_color(1, 1, 1, 1);
			else
				v.btn:set_event_value(tostring(v.data.item_id), tonumber(k));
				v.btn:set_on_click(self.bindfunc["on_btn_good"]);
				v.btn_bg:set_color(0, 0, 0, 1);
			end
		end
		
		self.m_yijian_btn_sp_point:set_active(g_dataCenter.player:GetVipIsLevel());
	end

	local cont = 0;
	local btn_type = 3;
	local dis_item_data = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_vip_up_item).data;
	if dis_item_data then
		for k,v in pairs(dis_item_data) do
			cont = g_dataCenter.package:GetCountByNumber(v.item_id);
			if cont > 0 then
				btn_type = 1;
				break;
			end
		end
	end
	self.m_yijian_btn:set_enable(cont>0);
	PublicFunc.SetButtonShowMode(self.m_yijian_btn, btn_type, "sprite_background");
end

function VipPackingGoodUI:on_btn_good( t )
	app.log("t.float_value:" .. t.float_value .. " t.string_value:" .. t.string_value)
	if t.string_value ~= "" then
		AcquiringWayUi.Start({item_id=tonumber(t.string_value), number=0});
	end
end

function VipPackingGoodUI:on_btn_good_press( name, state )
	app.log("progress:"..tostring(state) .. " name:" .. name);
	self.m_is_click = state;
	if state then
		if name == "btn_left" then
			self.m_current_click_index = 1;
		elseif state and name == "btn_right" then
			self.m_current_click_index = 2;
		end
		self.m_old_vip = g_dataCenter.player.vip;
		self.m_old_vipdata = g_dataCenter.player:GetVipData();

		self.m_update_vip = g_dataCenter.player.vip;
		self.m_update_vipstar = g_dataCenter.player.vipstar;
		self.m_update_vipexp = g_dataCenter.player.vipexp;

		self:set_deff_time();
		self.m_click_time = timer.create(self.bindfunc["set_deff_time"], 100 ,-1);
	else
		self:DesPress();
	end	
end

function VipPackingGoodUI:set_deff_time( )
	if self.m_current_click_index > 0 and self.m_is_click then
		local item_id_cont = 0;
		local item_id_exp = 0;
		local dis_item_data = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_vip_up_item).data;
		if dis_item_data and dis_item_data[self.m_current_click_index] then
			self.m_press_item_id = dis_item_data[self.m_current_click_index].item_id;
			item_id_cont = g_dataCenter.package:GetCountByNumber(dis_item_data[self.m_current_click_index].item_id);
			item_id_exp = dis_item_data[self.m_current_click_index].item_exp;
		end
		if self.m_click_num == nil then
			self.m_click_num = 1;
		else
			self.m_click_num = self.m_click_num + 1;
		end
		if self.m_click_num > item_id_cont then
			self.m_click_num = item_id_cont;
			self:DesPress();
		else
			self:UpdatePressUI(item_id_exp);
		end
	else
		self:DesPress();
	end
end

function VipPackingGoodUI:UpdatePressUI( item_id_exp )
	local vip_data = g_dataCenter.player:GetVipDataByLevel(self.m_update_vip, self.m_update_vipstar);
	if vip_data then
		self.m_update_vipexp = self.m_update_vipexp + item_id_exp;
		local up_vip_type = 0;
		if self.m_update_vipexp >= vip_data.need_exp then
			self.m_update_vipexp = self.m_update_vipexp - vip_data.need_exp;
			up_vip_type = 1;
			self.m_update_vip = self.m_update_vip + 1;
			if self.m_update_vip > g_dataCenter.player:GetVipMax() then
				self.m_update_vip = g_dataCenter.player:GetVipMax();
				self.m_click_num = self.m_click_num - 1;
				self.m_update_vipexp = self.m_update_vipexp - item_id_exp;
				self.m_update_vip = self.m_update_vip - 1;
				up_vip_type = 0;
				self:DesPress();
			end
			
			local new_vip_data = g_dataCenter.player:GetVipDataByLevel(self.m_update_vip);

			app.log("self.m_update_vip:" .. self.m_update_vip .. " new_vip_data.level:" .. new_vip_data.level .. " self.m_old_vipdata.level:" .. self.m_old_vipdata.level);
			if self.m_old_vipdata and new_vip_data and new_vip_data.level > self.m_old_vipdata.level then
				up_vip_type = 2;
			end			
		end
		self.m_press_up_level_type = math.max(self.m_press_up_level_type, up_vip_type);

		if self.m_item_ui_list[self.m_current_click_index] then
			local cont = g_dataCenter.package:GetCountByNumber(self.m_press_item_id);	
			local cur_cont = cont - self.m_click_num;		
			if cur_cont < 0 then
				cur_cont = 0;
			end
			self.m_item_ui_list[self.m_current_click_index].btn_txt:set_text(tostring(cur_cont or 0));
		end

		PublicFunc.msg_dispatch("UpdateBannerUIByPress", self.m_update_vip, self.m_update_vipstar, self.m_update_vipexp);
	end
end

function VipPackingGoodUI:DesPress(  )

	app.log("DesPress:" .. ' self.m_press_item_id:' .. self.m_press_item_id .. ' self.m_click_num:' .. self.m_click_num );
	app.log("DesPress:" .. ' self.m_update_vipexp:' .. self.m_update_vipexp .. ' self.m_update_vip:' .. self.m_update_vip .. ' self.m_update_vipstar:' .. self.m_update_vipstar .. ' self.m_press_up_level_type:' .. self.m_press_up_level_type );

	if self.m_click_num > 0 then
		if self.m_press_up_level_type == 0 then
			FloatTip.Float("好感值提升" .. self.m_update_vipexp - g_dataCenter.player.vipexp);
			AudioManager.PlayUiAudio(81200000);
		end

		player.cg_vip_add_yijian_good(self.m_press_item_id, self.m_click_num, 0, 0, self.m_update_vipexp, self.m_update_vip, self.m_update_vipstar, self.m_press_up_level_type);
	end

	if self.m_click_time ~= 0 then 
        timer.stop(self.m_click_time);
        self.m_click_time = 0;
    end
    self.m_current_click_index = 0;
    self.m_click_num = 0;
    self.m_is_click = false;
    self.m_press_item_id = 0;
    self.m_press_up_level_type = -1;

    -- self:UpdateUI();
end

function VipPackingGoodUI:on_yijian_btn_good1( t )
	
end

function VipPackingGoodUI:on_yijian_btn_good2( t )
	local item_id1 = 0;
	local item_id1_cont = 0;
	local item_id1_exp = 0;

	local item_id2 = 0;
	local item_id2_cont = 0;
	local item_id2_exp = 0;

	local have_total_exp_1 = 0;
	local have_total_exp_2 = 0;	
	local dis_item_data = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_vip_up_item).data;
	if dis_item_data and dis_item_data[1] then
		item_id1 = dis_item_data[1].item_id;
		item_id1_cont = g_dataCenter.package:GetCountByNumber(dis_item_data[1].item_id);
		item_id1_exp = dis_item_data[1].item_exp;
		have_total_exp_1 = item_id1_cont * item_id1_exp;
	end
	if dis_item_data and dis_item_data[2] then
		item_id2 = dis_item_data[2].item_id;
		item_id2_cont = g_dataCenter.package:GetCountByNumber(dis_item_data[2].item_id);
		item_id2_exp = dis_item_data[2].item_exp;
		have_total_exp_2 = item_id2_cont * item_id2_exp;
	end

	local vip = g_dataCenter.player.vip;
	local vipstar = g_dataCenter.player.vipstar;
	local vipexp = g_dataCenter.player.vipexp;

	local prese_vip = vip;
	local prese_star = vipstar;
	local prese_exp = vipexp;
	local up_vip_type = 0;

	local diff_exp = 0;
	local prese_diff_exp = 0;
	local vip_data = g_dataCenter.player:GetVipDataByLevel(vip, vipstar);

	if vip_data then
		app.log('on_yijian_btn_good2-0' ..' vipexp:'.. vipexp .. ' need_exp:' .. vip_data.need_exp .. ' vip:' .. vip .. " vipstar:" .. vipstar .. ' have_total_exp_1:' .. have_total_exp_1 .. ' have_total_exp_2:' .. have_total_exp_2);
		diff_exp = math.abs(vip_data.need_exp - vipexp);
		if have_total_exp_1 + have_total_exp_2 < diff_exp then -- 当前等级，经验消耗完，没升级
			prese_diff_exp = vipexp + have_total_exp_1 + have_total_exp_2;

			app.log('on_yijian_btn_good2-1:' .. 'prese_diff_exp:' .. prese_diff_exp .. " prese_vip:" .. prese_vip .. ' prese_star:' .. prese_star .. 'up_vip_type:' .. up_vip_type);
			FloatTip.Float("好感值提升" .. have_total_exp_1 + have_total_exp_2);
			AudioManager.PlayUiAudio(81200000);
			player.cg_vip_add_yijian_good(item_id1, item_id1_cont, item_id2, item_id2_cont, prese_diff_exp, prese_vip, prese_star, up_vip_type);

		else -- 肯定升级了
			local max_vip = g_dataCenter.player:GetVipMax();
			local max_star = vip;

			prese_vip = vip + 1;
			up_vip_type = 1;
			if prese_vip > max_vip then
				prese_vip = max_vip;
			end			

			-- if prese_vip ~= vip then
			-- 	local prese_vip_data = g_dataCenter.player:GetVipDataByLevel(prese_vip, prese_star);
			-- 	if prese_vip_data then
			-- 		prese_diff_exp = prese_vip_data.need_exp - 1;
			-- 		if prese_diff_exp < 0 then
			-- 			prese_diff_exp = 0;
			-- 		end
			-- 	end
			-- else
			-- 	prese_diff_exp = diff_exp;
			-- 	diff_exp = 0;
			-- end

			-- local total_sure_exp = diff_exp + prese_diff_exp;
			-- local is_2 = false;
			local total_sure_exp = diff_exp;
			local consume_id1_cont = 0;
			if have_total_exp_1 <= total_sure_exp then
				consume_id1_cont = item_id1_cont;
				total_sure_exp = total_sure_exp - have_total_exp_1;
				is_2 = true;
				-- local consume_exp = consume_id1_cont * item_id1_exp;
				-- if consume_exp <= diff_exp then
				-- 	diff_exp = diff_exp - consume_exp;
				-- else
				-- 	diff_exp = consume_exp - diff_exp;
				-- end

				-- if item_id2_cont > 0 then
				-- 	is_2 = true;
				-- else
				-- 	prese_diff_exp = diff_exp;
				-- end
			else
				local mod_cont, mod_dec = math.modf(total_sure_exp / item_id1_exp);
				if mod_dec > 0 then
					consume_id1_cont = mod_cont + 1;
				else
					consume_id1_cont = mod_cont;
				end
				-- prese_diff_exp = prese_diff_exp - math.ceil(mod_dec * item_id1_exp);
				-- total_sure_exp = 0;
			end

			local consume_id2_cont = 0;
			if is_2 then
				if have_total_exp_2 <= total_sure_exp then
					consume_id2_cont = item_id2_cont;
					-- prese_diff_exp = have_total_exp_2 - diff_exp;
				else
					local mod_cont, mod_dec = math.modf(total_sure_exp / item_id2_exp);
					if mod_dec > 0 then
						consume_id2_cont = mod_cont + 1;
					else
						consume_id2_cont = mod_cont;
					end
					-- prese_diff_exp = prese_diff_exp - math.ceil(mod_dec * item_id2_exp);
				end

			end

			local new_vip_data = g_dataCenter.player:GetVipDataByLevel(prese_vip);
			if new_vip_data and new_vip_data.level > vip_data.level then
				up_vip_type = 2;
			end

			app.log('on_yijian_btn_good2-2:' .. 'prese_diff_exp:' .. prese_diff_exp .. " prese_vip:" .. prese_vip .. ' prese_star:' .. prese_star .. 'up_vip_type:' .. up_vip_type);
			-- if prese_diff_exp < 0 then
			-- 	prese_diff_exp = 0;
			-- end
			if consume_id1_cont > 0 or consume_id2_cont > 0 then
				player.cg_vip_add_yijian_good(item_id1, consume_id1_cont, item_id2, consume_id2_cont, prese_diff_exp, prese_vip, prese_star, up_vip_type);

				-- if up_vip_type == 0 then
				-- 	FloatTip.Float("好感值提升" .. have_total_exp_1 + have_total_exp_2);
				-- end
			end
		end


	end
	
end

function VipPackingGoodUI:on_btn_shop(  )
	SystemEnterFunc[MsgEnum.eactivity_time.eActivityTime_ShopVip]();
end

function VipPackingGoodUI:GetNeedVipExp( vip, vipstar )
	local need_exp = 0;
	local vip_data = g_dataCenter.player:GetVipDataByLevel(vip, vipstar);
	if vip_data then
		need_exp = vip_data.need_exp;
	end
	return need_exp;
end

function VipPackingGoodUI:GetVipMax( )
	local vip_table = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
	local num = -1;
	for k,v in pairs(vip_table) do
		num = num + 1;
	end
	return num;
end

function VipPackingGoodUI:GetVipStarMax( level )
	local vip_config = g_dataCenter.player:GetVipDataConfigByLevel(level);
	local num = 0;
	if vip_config then
		for k,v in pairs(vip_config) do
			num = math.max(num, v.level_star);
		end
	end
	return num;
end

function VipPackingGoodUI:FindMinByLevel( level )
	local result = 0;
	local vip_config = g_dataCenter.player:GetVipDataConfigByLevel(level);
	if vip_config then
		for k,v in pairs(vip_config) do
			if tonumber(k) == 1 then
				result = v.level_star;
			end
			result = math.min(result, v.level_star);
		end
	end
	return result;
end

function VipPackingGoodUI:FindMaxByLevel( level )
	local result = 0;
	local vip_config = g_dataCenter.player:GetVipDataConfigByLevel(level);
	if vip_config then
		for k,v in pairs(vip_config) do
			result = math.max(result, v.level_star);
		end
	end
	return result;
end

function VipPackingGoodUI:gc_vip_add_yijian_good( vip_up_level )
	self:UpdateUI();
	self.m_press_up_level_type = -1;
	PublicFunc.msg_dispatch("UpdateGiftSpPoint");

	-- if vip_up_level == 2 then
	-- 	-- PublicFunc.msg_dispatch("UpdateDisFullStars", g_dataCenter.player.vip - 1);
	-- 	if self.m_up_level_time and self.m_up_level_time > 0 then
	-- 		timer.stop(self.m_up_level_time);
	-- 		self.m_up_level_time = 0;
	-- 	end
	-- 	self.m_up_level_time = timer.create(self.bindfunc["up_level_time"], 1000, 1);
	-- end	
end

function VipPackingGoodUI:up_level_time(  )
	if self.m_up_level_time and self.m_up_level_time > 0 then
		timer.stop(self.m_up_level_time);
		self.m_up_level_time = 0;
	end
	self:UpdateUI();
end

function VipPackingGoodUI:Update( dt )
	
end