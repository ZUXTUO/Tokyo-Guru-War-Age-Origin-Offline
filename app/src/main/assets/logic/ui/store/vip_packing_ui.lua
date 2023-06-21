VipPackingUI = Class('VipPackingUI', UiBaseClass)

VipPackingUI.is_open = false;

local _txt = {
	[1] = "[974D04FF]%d[-][7463C9FF]/%d[-]";
	[2] = "[7463C9FF]满[-]";
}

function VipPackingUI:Init(data)
	
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop.assetbundle";
	UiBaseClass.Init(self, data);

end

--重新加载
function VipPackingUI:Restart(data)
	if data == "replace" then
		self.m_push_type = math.max(1, g_dataCenter.player.vip);
	else
		self.m_push_type = tonumber(data);
	end

	UiBaseClass.Restart(self, data);
end

--注册方法
function VipPackingUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_toggle_change"] = Utility.bind_callback(self, self.on_toggle_change);
	self.bindfunc["on_click_hero"] = Utility.bind_callback(self, self.on_click_hero);
	self.bindfunc["on_anima_back"] = Utility.bind_callback(self, self.on_anima_back);
	self.bindfunc["on_load_callback"] = Utility.bind_callback(self, self.on_load_callback);

	self.bindfunc["on_award_back"] = Utility.bind_callback(self, self.on_award_back);

	self.bindfunc["UpdateBannerUIByPress"] = Utility.bind_callback(self, self.UpdateBannerUIByPress);
	self.bindfunc["UpdateGiftSpPoint"] = Utility.bind_callback(self, self.UpdateGiftSpPoint);
	self.bindfunc["UpdateDisFullStars"] = Utility.bind_callback(self, self.UpdateDisFullStars);

	self.bindfunc["up_level_time"] = Utility.bind_callback(self, self.up_level_time);

	self.bindfunc["gc_vip_add_yijian_good"] = Utility.bind_callback(self, self.gc_vip_add_yijian_good);
	
end

--取消注册
function VipPackingUI:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function VipPackingUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	
	PublicFunc.msg_regist(player.gc_vip_add_yijian_good, self.bindfunc["gc_vip_add_yijian_good"])
	PublicFunc.msg_regist("UpdateBannerUIByPress", self.bindfunc["UpdateBannerUIByPress"])
	PublicFunc.msg_regist("UpdateGiftSpPoint", self.bindfunc["UpdateGiftSpPoint"])
	PublicFunc.msg_regist("UpdateDisFullStars", self.bindfunc["UpdateDisFullStars"])

end

--注销消息分发回调函数
function VipPackingUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	
	PublicFunc.msg_unregist(player.gc_vip_add_yijian_good, self.bindfunc["gc_vip_add_yijian_good"])
	PublicFunc.msg_unregist("UpdateBannerUIByPress", self.bindfunc["UpdateBannerUIByPress"])
	PublicFunc.msg_unregist("UpdateGiftSpPoint", self.bindfunc["UpdateGiftSpPoint"])
	PublicFunc.msg_unregist("UpdateDisFullStars", self.bindfunc["UpdateDisFullStars"])
end

--初始化数据
function VipPackingUI:InitData(data)
	UiBaseClass.InitData(self, data);

	self.m_toggle_ui_list = {};
	self.m_current_index = 1;
	self.m_current_ui = nil;

	self.m_star_ui = {};

	self.m_current_anima = 0;
end

--销毁数据
function VipPackingUI:DestroyUi()
	self.m_current_anima = 0;

	if self.m_current_ui then
		self.m_current_ui:DestroyUi();
		self.m_current_ui = nil;
	end
	if Show3dVip.instance then
		Show3dVip.instance:Destroy();
	end
	
	UiBaseClass.DestroyUi(self);
end

function VipPackingUI:Hide(  )
	-- if Show3dVip.instance then
		-- Show3dVip.instance:Destroy();
	-- end
	Show3dVip.SetVisible(false);
	UiBaseClass.Hide(self);
end

function VipPackingUI:Show(  )
	if self.m_current_ui and self.m_current_ui.Show then
		self.m_current_ui:Show();
		g_dataCenter.player:CheckVipRedPoint();
	end
	Show3dVip.SetVisible(true);
	self:UpdateBannerUI();
	-- self:UpdateHero3d();
	UiBaseClass.Show(self);
end

--初始化UI
function VipPackingUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)

	self.ui:set_name("vip_packing_ui")

	self.gBanngerUI = self.ui:get_child_by_name("right_other/animation/sp_title_bk");
	self.sp_di_bg = self.ui:get_child_by_name("right_other/animation/content1/sp_di");
	self.sp_di_bg:set_active(false);
	self.sp_di_bg = self.ui:get_child_by_name("right_other/animation/content1/sp_di");
	self.sp_di_bg:set_active(false);

	-- 好感
	self.goodUI_parent = self.ui:get_child_by_name("right_other/animation");
	self.goodUI = self.ui:get_child_by_name("right_other/animation/content2");
	self.goodUI:set_active(false);
	-- 馈赠
	self.giveUI_parent = self.ui:get_child_by_name("right_other/animation/content1");
	self.giveUI = self.ui:get_child_by_name("right_other/animation/content1/cont1");
	self.giveUI:set_active(false);
	-- 礼物
	self.giftUI_parent = self.ui:get_child_by_name("right_other/animation/content1");
	self.giftUI = self.ui:get_child_by_name("right_other/animation/content1/cont2");
	self.giftUI:set_active(false);

	self.fx_ui_602_level_up = self.gBanngerUI:get_child_by_name("pro_di/fx_ui_602_level_up");
	self.fx_ui_602_level_up:set_active(false);

	local sp_lock = nil;
	for i=1,3 do
		self.m_toggle_ui_list[i] = ngui.find_toggle(self.ui, "left_other/animation/yeka/yeka"..i);
		self.m_toggle_ui_list[i]:set_on_change(self.bindfunc["on_toggle_change"]);
		sp_lock = ngui.find_sprite(self.ui, "left_other/animation/yeka/yeka"..i.. "/sp_lock");
		if sp_lock then
			sp_lock:set_active(false);
		end
		if i == 3 then
			self.m_yeka3_sp_point = ngui.find_sprite(self.ui, "left_other/animation/yeka/yeka"..i.."/sp_point");
			self.m_yeka3_sp_point:set_active(false);
		elseif i == 1 then
			self.m_yeka1_sp_point = ngui.find_sprite(self.ui, "left_other/animation/yeka/yeka"..i.."/sp_point");
			self.m_yeka1_sp_point:set_active(false);

		end
	end

	self.vip_level_txt = ngui.find_label(self.gBanngerUI, "sp_heart/lab_v");
	self.vip_level_txt:set_text("");
	self.vip_level_star_txt = ngui.find_label(self.gBanngerUI, "sp_heart/lab_v2");
	self.vip_level_star_txt:set_text("");
	for i=1,9 do
		self.m_star_ui[i] = ngui.find_sprite(self.gBanngerUI, "grid/sp_heart"..i);
		self.m_star_ui[i]:set_sprite_name("vip_xin2");
	end
	self.progress_ui = ngui.find_progress_bar(self.gBanngerUI, "pro_di");
	self.progress_ui:set_value(0);
	self.progress_txt = ngui.find_label(self.gBanngerUI, "pro_di/lab_num");
	self.progress_txt:set_text("");

	self.sp_full_level = ngui.find_sprite(self.ui, "pro_di/sp_full_level");
	self.sp_full_level:set_active(false);

	self.btn_up = ngui.find_button(self.ui, "right_other/animation/content1/btn_left");
	if self.btn_up then
		self.btn_up:set_active(false);
	end

	self.btn_next = ngui.find_button(self.ui, "right_other/animation/content1/btn_right");
	if self.btn_next then
		self.btn_next:set_active(false);
	end

	self.sp_di = ngui.find_sprite(self.ui, "left_other/animation/sp_di");
	self.sp_di:set_active(false);
	self.lab_describe = ngui.find_label(self.ui, "left_other/animation/sp_di/lab_describe");
	self.lab_describe:set_text("");

	self.hero3D = ngui.find_sprite(self.ui, "left_other/animation/sp_human");
	self:UpdateHero3d();

	self:UpdateBannerUI();
	self:UpdateGiftSpPoint();

	VipPackingUI.is_open = true;
	g_dataCenter.player:CheckVipRedPoint();
end

function VipPackingUI:UpdateBannerUI( )
	local vip_data = g_dataCenter.player:GetVipData();	
	local vip_level = 0;
	local cur_vipexp = g_dataCenter.player.vipexp;
	local need_vipexp = 0;
	local vipstar = 0;
	if vip_data then
		vip_level = vip_data.level;
		vipstar = vip_data.level_star;
		self.vip_level_txt:set_text(tostring(vip_level or 0));
		self.vip_level_star_txt:set_text("-" .. tostring(vip_data.level_star or 1));
		cur_vipexp = g_dataCenter.player.vipexp or 0;
		need_vipexp = vip_data.need_exp or 0;
		if cur_vipexp > need_vipexp then
			cur_vipexp = need_vipexp;
		elseif cur_vipexp <= 0 then
			cur_vipexp = 0;
		end
		if need_vipexp == 0 then
			self.progress_txt:set_text("");
			self.progress_ui:set_value(1);
			self.sp_full_level:set_active(true);
		else
			self.progress_txt:set_text(string.format(_txt[1], cur_vipexp, need_vipexp));
			self.progress_ui:set_value(cur_vipexp / need_vipexp);
			self.sp_full_level:set_active(false);
		end

		local max_star = vip_level;
		for k,v in pairs(self.m_star_ui) do
			if v then
				v:set_active(tonumber(k) <= max_star);
				if tonumber(k) <= vipstar then
					v:set_sprite_name("vip_xin3");
				else
					v:set_sprite_name("vip_xin2");
				end
			end
		end
	end
	self.fx_ui_602_level_up:set_active(false);
end

function VipPackingUI:UpdateBannerUIByPress( vip, vipstar, vipexp )
	local my_vip_data = g_dataCenter.player:GetVipData();
	local vip_data = g_dataCenter.player:GetVipDataByLevel(vip);	
	local vipstar = vip_data.level_star;
	if vip_data then
		self.vip_level_txt:set_text(tostring(vip_data.level));
		local need_vipexp = vip_data.need_exp or 0;
		if vipexp > need_vipexp then
			vipexp = need_vipexp;
		end
		self.progress_txt:set_text(string.format(_txt[1], vipexp, need_vipexp));
		self.progress_ui:set_value(vipexp / need_vipexp);

		local max_star = tonumber(vip_data.level);
		for k,v in pairs(self.m_star_ui) do
			if v then
				v:set_active(tonumber(k) <= max_star);
				if tonumber(k) <= vipstar then
					v:set_sprite_name("vip_xin3");
				else
					v:set_sprite_name("vip_xin2");
				end
			end
		end
		self.fx_ui_602_level_up:set_active(true);
	end
end

function VipPackingUI:UpdateGiftSpPoint( )
	if self.m_yeka3_sp_point then
		self.m_yeka3_sp_point:set_active(g_dataCenter.player.vip > 0 and g_dataCenter.player.vipEveryGet == 0);
	end

	if self.m_yeka1_sp_point then
		self.m_yeka1_sp_point:set_active(g_dataCenter.player:GetVipIsLevel());
	end
end

function VipPackingUI:UpdateDisFullStars( full_vip_level )
	-- 播满级动画，显示一会满级
	local max_star = self:GetVipStarMax( full_vip_level );
	for k,v in pairs(self.m_star_ui) do
		if v then
			v:set_active(tonumber(k) <= max_star);
			v:set_sprite_name("vip_xin3");
		end
	end
end

function VipPackingUI:GetVipStarMax( level )
	local vip_config = g_dataCenter.player:GetVipDataConfigByLevel(level);
	local num = 0;
	if vip_config then
		for k,v in pairs(vip_config) do
			num = num + 1;
		end
	end
	return num;
end

function VipPackingUI:on_toggle_change(value, name)
	-- app.log("value:" .. tostring(value) .. "name:" .. tostring(name));

	if not self.is_first then
		
	else
		AudioManager.PlayUiAudio(81200006);
		app.log("----------------------- on_toggle_change")
	end

	if value and tostring(name) == "yeka1" then
		
		if self.m_current_ui then
			self.m_current_ui:DestroyUi();
		end
		self.m_current_index = 1;
		self.m_current_ui = VipPackingGoodUI:new({obj = self.goodUI, parent = self.goodUI_parent});
		self.sp_di_bg:set_active(false);
	elseif value and tostring(name) == "yeka2" then
		
		if self.m_current_ui then
			self.m_current_ui:DestroyUi();
		end
		self.m_current_index = 2;
		self.m_current_ui = VipPackingGiveUI:new({obj = self.giveUI, parent = self.giveUI_parent});
		self.sp_di_bg:set_active(true);
	elseif value and tostring(name) == "yeka3" then
		if not self.is_first then
			self.is_first = 1;
		end
		if self.m_current_ui then
			self.m_current_ui:DestroyUi();
		end
		self.m_current_index = 3;
		self.m_current_ui = VipPackingGiftUI:new({obj = self.giftUI, parent = self.giftUI_parent});
		self.sp_di_bg:set_active(true);
	end

	-- if not value and tostring(name) == "yeka1" then
	-- 	self.goodUI:set_active(false);
	-- elseif not value and tostring(name) == "yeka2" then
	-- 	self.giveUI:set_active(false);
	-- elseif not value and tostring(name) == "yeka3" then
	-- 	self.giftUI:set_active(false);
	-- end
end

function VipPackingUI:set_diff_exp( diff )
	self.m_cur_diff = self.m_cur_diff + diff;
end

function VipPackingUI:gc_vip_add_yijian_good( vip_up_level )
	-- self:UpdateBannerUI();
	self.m_vip_up_level = vip_up_level;
	if vip_up_level == 0 then
		self:UpdateBannerUI();
	elseif vip_up_level == 1 then
		self:UpdateBannerUI();
		local vip_config = g_dataCenter.player:GetVipDataConfigByLevel(g_dataCenter.player.vip);
		
		CommonAwardVip.Start({vip=g_dataCenter.player.vip, vipstar=g_dataCenter.player.vipstar, vip_up_level=vip_up_level, vip_config = vip_config});
		CommonAwardVip.SetFinishCallback(self.bindfunc["on_award_back"], vip_up_level);
	elseif vip_up_level == 2 then
		self:UpdateBannerUI();
		local vip_config = g_dataCenter.player:GetVipDataConfigByLevel(g_dataCenter.player.vip);
		
		CommonAwardVip.Start({vip=g_dataCenter.player.vip, vipstar=g_dataCenter.player.vipstar, vip_up_level=vip_up_level, vip_config = vip_config});
		CommonAwardVip.SetFinishCallback(self.bindfunc["on_award_back"], vip_up_level);
	end
end

function VipPackingUI:on_award_back( vip_up_level )
	if vip_up_level == 2 then
		if Show3dVip.instance then
			Show3dVip.instance:SetAnimaIsPlaying(false);
		end
	end
	if Show3dVip.GetInstance() and not Show3dVip.GetInstance():GetAnimaIsPlaying() and self.m_vip_up_level then
		if self.m_vip_up_level == 0 then
			
		elseif self.m_vip_up_level == 1 then
			self.m_current_anima = ROLE_VIP_MODEL_ANIMA_TYPE.UP_STAR;
			Show3dVip.SetAnimationByType(self.m_current_anima);
		elseif self.m_vip_up_level == 2 then 
			self.m_current_anima = ROLE_VIP_MODEL_ANIMA_TYPE.UP_LEVEL_EXIT;
			
			Show3dVip.SetAnimationByType(self.m_current_anima);
		end
	end
end

function VipPackingUI:UpdateHero3d()
	local vip_data = g_dataCenter.player:GetVipData();
	if vip_data then
	    -- local cardinfo = CardHuman:new({number=30016000, isNotCalProperty = true});
	    local data = 
	    {
	        -- roleData = cardinfo,
	        model_id = vip_data.model_id,
	        clickRoleCallBack = self.bindfunc["on_click_hero"],
	        animaCallBack = self.bindfunc["on_anima_back"],
	        callback = self.bindfunc["on_load_callback"],
	        sp_di = self.sp_di;
	        describeTxt = self.lab_describe,
	        role3d_ui_touch = self.hero3D,
	        type = "left",
	    }   
	    -- self.m_current_anima = ROLE_VIP_MODEL_ANIMA_TYPE.STAND;
	    Show3dVip.SetLoadCallBack(self.bindfunc["on_load_callback"]);
	    Show3dVip.SetAndShow(data);	  
	    
	end
end

function VipPackingUI:on_click_hero( t )
	app.log("--------------- 点击角色 ---------------");
	self.m_current_anima = ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM;
	-- self.m_current_anima = ROLE_VIP_MODEL_ANIMA_TYPE.UP_LEVEL_EXIT;
	Show3dVip.SetAnimationByType(self.m_current_anima);
end

function VipPackingUI:on_anima_back( anima_type )
	app.log("--------------- on_anima_back -------- self.m_current_anima:" .. self.m_current_anima .. " anima_type:" .. anima_type);
	if self.m_current_anima and anima_type == ROLE_VIP_MODEL_ANIMA_TYPE.UP_LEVEL_EXIT then
		if Show3dVip.instance then
			-- Show3dVip.instance:DestroyUi();
		end

		self.m_current_anima = ROLE_VIP_MODEL_ANIMA_TYPE.UP_LEVEL_EXIT;
		self:UpdateHero3d();
	end
end

function VipPackingUI:on_load_callback( )
	-- Show3dVip.SetAnimationByType(ROLE_VIP_MODEL_ANIMA_TYPE.STAND)
	
	app.log("on_load_callback: self.m_current_anima:" .. tostring(self.m_current_anima));
	if self.m_current_anima and self.m_current_anima == ROLE_VIP_MODEL_ANIMA_TYPE.UP_LEVEL_EXIT then

		self.m_current_anima = ROLE_VIP_MODEL_ANIMA_TYPE.UP_LEVEL_ENTER;
		app.log("on_load_callback:" .. self.m_current_anima);
		Show3dVip.SetAnimationByType(self.m_current_anima);
		-- Show3dVip.SetAndShow(true);
	end
end

function VipPackingUI:Update( dt )
	if self.m_current_ui and self.m_current_ui.Update then

	end
end