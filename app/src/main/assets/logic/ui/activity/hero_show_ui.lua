HeroShowUI = Class("HeroShowUI", UiBaseClass);

local _bg_ = {
	[1] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_qiridenglu/hd_kapai3.assetbundle",
    [2] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_qiridenglu/hd_kapai4.assetbundle"
}

function HeroShowUI:Init(data)
	-- self.m_role_default_id = data;
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1134_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function HeroShowUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.m_head_icon = nil;
    self.m_card_human = nil;
    self.m_bg_texture = nil;
    self.m_skill_textures = {};
end

function HeroShowUI:Restart(data)
	self.m_role_default_id = data.role_id;
	self.m_index = data.index;

	app.log("self.m_role_default_id:" .. self.m_role_default_id);
	UiBaseClass.Restart(self, data);
end

function HeroShowUI:DestroyUi()
	UiBaseClass.DestroyUi(self);

	if self.m_head_icon then
		self.m_head_icon:DestroyUi();
		self.m_head_icon = nil;
	end

	if self.m_bg_texture then
        self.m_bg_texture:clear_texture();
        self.m_bg_texture = nil;
    end

    for k,v in pairs(self.m_skill_textures) do
    	if v then
    		v:clear_texture();
    		v = nil;
    	end
    end
    self.m_skill_textures = {};
end

function HeroShowUI:RegistFunc()
	
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
	self.bindfunc["on_skill_press"] = Utility.bind_callback(self, self.on_skill_press);

end

function HeroShowUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("hero_show_ui");

	self.btn_close = ngui.find_button(self.ui, "center_other/animation/btn_cha");
	self.btn_close:set_on_click(self.bindfunc["on_close"]);

	self.btn_close1 = ngui.find_button(self.ui, "center_other/animation/btn_cheng");
	self.btn_close1:set_on_click(self.bindfunc["on_close"]);

	self.m_bg_texture = ngui.find_texture(self.ui, "center_other/animation/texture_human");
	self.m_bg_texture:set_texture(_bg_[self.m_index]);

	local role_config = ConfigHelper.GetRole(tonumber(self.m_role_default_id));
	self.m_card_human = CardHuman:new( { number = self.m_role_default_id});
	
	self.skill_info = {};
	--主动技能
    for k, v in ipairs(role_config.spe_skill) do
        local skill_id = v[1]
        table.insert(self.skill_info, {id=skill_id, level=1, skillType=0});
    end
    --被动技能
    --[[for i=1, 3 do
        local cfg = ConfigManager.Get(EConfigIndex.t_role_passive_info,self.m_card_human.default_rarity);
        if cfg and cfg[i] then
        	table.insert(self.skill_info, {id=i, level=1, skillType=1});
        end
    end]]
    -- 光环技能
    --[[local cfg_name = EConfigIndex["t_halo_property_"..self.m_card_human.default_rarity];
    if cfg_name then
        local skillLevelData = ConfigManager._GetConfigTable(cfg_name);
        if skillLevelData then
        	table.insert(self.skill_info, {id=1, level=1, skillType=2});
        end
    end]]

    local skill_btn = nil;
    self.m_skill_textures = {};
	for i=1, 3 do
		skill_btn = ngui.find_button(self.ui, "center_other/animation/texture_"..i);
		skill_btn:set_on_ngui_press(self.bindfunc["on_skill_press"]);
		self.m_skill_textures[i] = ngui.find_texture(self.ui, "center_other/animation/texture_"..i);

		-- skill_sprite = ngui.find_sprite(self.ui, "centre_other/lab_describe/sp_skill" .. i);
		-- skill_sprite:set_on_ngui_press(self.bindfunc["on_skill_press"]);
		-- skill_icon = ngui.find_texture(self.ui, "centre_other/lab_describe/sp_skill" .. i .. "/Texture");
		-- labRank = ngui.find_label(self.ui,"centre_other/lab_describe/sp_skill" .. i .. "/lab");
		local cfg = self.skill_info[i];
        if cfg ~= nil then
            skill_config = PublicFunc.GetSkillCfg(self.m_card_human.default_rarity, cfg.skillType, cfg.id)
		    -- skill_sprite:set_name(tostring(i));
		    skill_btn:set_name(tostring(i));
		    self.m_skill_textures[i]:set_texture(skill_config.small_icon);
		    -- if skill_config.rank then
			   --  labRank:set_text(PublicFunc.GetPassiveSkillRankText(skill_config.rank));
		    -- else
			   --  labRank:set_text("");
		    -- end
        else
            -- skill_sprite:set_active(false)
        end		
	end
end

function HeroShowUI:on_close( t )
	self:Hide();
	self:DestroyUi();
	self = nil;
end

function HeroShowUI:on_skill_press( name, state, x, y, go_obj )
	app.log("--------- " .. name);
	local cfg = self.skill_info[tonumber(name)];
	if state then
		if cfg.skillType == 1 then
			SkillTips.EnableSkillTips(true, cfg.id, 1, self.m_card_human:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 300, self.m_card_human.default_rarity,1);
		elseif cfg.skillType == 2 then
			SkillTips.EnableSkillTips(true, cfg.id, 1, self.m_card_human:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 300, self.m_card_human.default_rarity,2);
		else
			SkillTips.EnableSkillTips(true, cfg.id, 1, self.m_card_human:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 300);
		end
	else
		SkillTips.EnableSkillTips(false);
	end
end
