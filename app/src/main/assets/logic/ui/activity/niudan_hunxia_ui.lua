NiudanHunxiaUI = Class("NiudanHunxiaUI", UiBaseClass);

local _lab_txt = {
	[1] = "%d月%d日%02d:00~%d月%d日%02d:00";
}

function NiudanHunxiaUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1131_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function NiudanHunxiaUI:InitData(data)
    UiBaseClass.InitData(self, data);    
    self.m_activity_id = ENUM.Activity.activityType_niudan_hunxia;
end

function NiudanHunxiaUI:Restart(data)
	
	UiBaseClass.Restart(self, data);
end

function NiudanHunxiaUI:DestroyUi()

	UiBaseClass.DestroyUi(self);
end

function NiudanHunxiaUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_go"] = Utility.bind_callback(self, self.on_go);
end

function NiudanHunxiaUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("hunxia_ui");
	
	self.labTitle = ngui.find_label(self.ui,"center_other/animation/texture_line/lab_title");
	self.labTime = ngui.find_label(self.ui,"center_other/animation/texture1/lab_time");
	self.labName = ngui.find_label(self.ui,"center_other/animation/texture1/lab_name");
	self.labDes = ngui.find_label(self.ui,"center_other/animation/texture1/txt2");
	self.labVip = ngui.find_sprite(self.ui,"center_other/animation/texture1/cont_vip/sp_vip");
	self.labVip_txt = ngui.find_label(self.ui,"center_other/animation/texture1/cont_vip/sp_v/lab_v");
	self.labVip_star_txt = ngui.find_label(self.ui,"center_other/animation/texture1/cont_vip/sp_v/lab_v2");
	self.heroDes = ngui.find_label(self.ui,"center_other/animation/texture1/txt1");
	self.labName2 = ngui.find_label(self.ui,"center_other/animation/texture1/txt");
	self.tex = ngui.find_texture(self.ui,"center_other/animation/Texture3");
	self.star = {};
	for i=1,Const.HERO_MAX_STAR do
		self.star[i] = ngui.find_sprite(self.ui,"center_other/animation/texture1/contain_star/sp_star"..i);
	end
	self.spPro = ngui.find_sprite(self.ui,"center_other/animation/texture1/sp_zizhi");
	self.spAptitude = ngui.find_sprite(self.ui,"center_other/animation/texture1/sp_pinzhi");

	local btn = ngui.find_button(self.ui,"center_other/animation/texture1/btn2");
	btn:set_on_click(self.bindfunc["on_go"]);
	self.spBtn = ngui.find_sprite(self.ui,"center_other/animation/texture1/btn2/animation/sp");
	self.spBtn_lab = ngui.find_label(self.ui, "center_other/animation/texture1/btn2/lab");
	self:UpdateUi();
end

function NiudanHunxiaUI:UpdateUi()
	UiBaseClass.UpdateUi(self);
	local activityTime_extGroup = 0;
	local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID( self.m_activity_id );
	if activityTime then
		local m_start_time = os.date('*t',activityTime.s_time);
		local m_end_time = os.date('*t',activityTime.e_time);
		self.labTime:set_text(string.format(_lab_txt[1],
				m_start_time.month,m_start_time.day,m_start_time.hour,
				m_end_time.month,m_end_time.day,m_end_time.hour));
		activityTime_extGroup = activityTime.extra_num;
	else
		self.labTime:set_text("");
	end

	-- local activeCfg = ConfigManager.Get(EConfigIndex.t_activity_play, self.m_activity_id);
	-- if activeCfg.des ~= 0 then
	-- 	self.labTitle:set_text(activeCfg.des or "");
	-- end

    repeat
    	local vipGroup = g_dataCenter.egg:GetHunxiaGroupId();
    	if vipGroup == 0 then
    		vipGroup = activityTime_extGroup;
    	end
    	local cfg = ConfigManager.Get(EConfigIndex.t_hunxia_other_drop, vipGroup);
    	if not cfg then
    		app.log_warning("NiudanHunxiaUI vipGroup:"..tostring(vipGroup));
    		break;
    	end
	    local numberid = cfg.mian_hero;
	    local heroCfg = CardHuman:new({number=numberid});
	    if not heroCfg then
    		app.log_warning("NiudanHunxiaUI mian_hero:"..tostring(numberid));
	    	break;
	    end
	    for i=1,Const.HERO_MAX_STAR do
	    	if i <= heroCfg.rarity then
	    		if self.star[i] then
	    			self.star[i]:set_active(true);
	    		end
	    	else
	    		if self.star[i] then
	    			self.star[i]:set_active(false);
	    		end
	    	end
	    end
	    PublicFunc.SetAptitudeSprite(self.spAptitude,heroCfg.config.aptitude, true);
	    PublicFunc.SetProTypePic(self.spPro,heroCfg.pro_type,3);
	    self.labName:set_text(heroCfg.name);
	    self.labName2:set_text(heroCfg.name);
	    self.heroDes:set_text("本期热点 "..heroCfg.name);
		-- PublicFunc.SetImageVipLevel(self.labVip, cfg.vip_level)
		if self.labVip_txt and self.labVip_star_txt then
			local cur_vip_data = g_dataCenter.player:GetVipDataConfigByLevel(cfg.vip_level);
			if cur_vip_data then
				self.labVip_txt:set_text(tostring(cur_vip_data.level));
				self.labVip_star_txt:set_text('-'..tostring(cur_vip_data.level_star));
			end
		end
	    self.labDes:set_text(tostring(cfg.des));
	    self.tex:set_texture(cfg.icon);
		if cfg.vip_level <= g_dataCenter.player:GetVip() then
			-- self.spBtn:set_color(1,1,1,1);
			self.spBtn_lab:set_effect_color(174/255, 65/ 255, 40/255, 1);
		else
			-- self.spBtn:set_color(0,0,0,1);			
			self.spBtn_lab:set_effect_color(95/255, 95/ 255, 95/255, 1);
		end
	    return ;
    until false
	for i=1,Const.HERO_MAX_STAR do
		if self.star[i] then
			self.star[i]:set_active(false);
		end
    end
    self.spAptitude:set_sprite_name("");
    self.spPro:set_sprite_name("");
    self.labName:set_text("");
    self.labName2:set_text("");
    self.heroDes:set_text("本期热点 ");
    -- PublicFunc.SetImageVipLevel(self.labVip, 0)
    self.labDes:set_text("");
    self.tex:clear_texture();
end

function NiudanHunxiaUI:on_go( t )
	local vipGroup = g_dataCenter.egg:GetHunxiaGroupId();
	local cfg = ConfigManager.Get(EConfigIndex.t_hunxia_other_drop, vipGroup);
	if cfg then
		if cfg.vip_level <= g_dataCenter.player:GetVip() then
			local enter_id = MsgEnum.eactivity_time.eActivityTime_Recruit;
			SystemEnterFunc[enter_id]();
		else
			FloatTip.Float("当前好感度不足");
		end
	else
		app.log_warning("NiudanHunxiaUI vipGroup:"..tostring(vipGroup));
	end
end