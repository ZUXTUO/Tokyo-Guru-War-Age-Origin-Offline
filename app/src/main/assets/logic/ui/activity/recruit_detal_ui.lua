RecruitDetalUI = Class("RecruitDetalUI", UiBaseClass);

local _tex = {};
_tex.restraint = {
	[1] = "锐";
	[2] = "坚";
	[3] = "疾";
	[4] = "特";
	[5] = "属性:";
};

_tex.eaptitudeName =
{
    [1] = "B";
    [2] = "A";
    [3] = "A+";
    [4] = "S";
    [5] = "S+";
    [6] = "SS";
    [7] = "SS";
    [8] = "SS";
    [9] = "SSS";
    [10] = "SSS";
    [11] = "SSS";
    [12] = "资质:";
}

function RecruitDetalUI:Init(data)
	self.m_role_default_id = data;
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1118_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function RecruitDetalUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.m_head_icon = nil;
    self.m_card_human = nil;

    self.m_skill_textures = {};
end

function RecruitDetalUI:Restart(data)
	self.m_role_default_id = data;

	UiBaseClass.Restart(self, data);
end

function RecruitDetalUI:DestroyUi()
	UiBaseClass.DestroyUi(self);

	if self.m_head_icon then
		self.m_head_icon:DestroyUi();
		self.m_head_icon = nil;
	end

	for k,v in pairs(self.m_skill_textures) do
    	if v then
    		v:clear_texture();
    		v = nil;
    	end
    end
    self.m_skill_textures = {};
end

function RecruitDetalUI:RegistFunc()
	
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
	self.bindfunc["on_skill_press"] = Utility.bind_callback(self, self.on_skill_press);

end

function RecruitDetalUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("recruit_detal_ui");

	self.btn_close = ngui.find_button(self.ui, "recruit_detal_ui/centre_other/btn_cha");
	self.btn_close:set_on_click(self.bindfunc["on_close"]);

	local new_small_card_item = self.ui:get_child_by_name("centre_other/big_card_item_80");
	self.m_card_human = CardHuman:new( { number = self.m_role_default_id});
	self.m_head_icon = SmallCardUi:new({parent = new_small_card_item, info = self.m_card_human, stypes = {SmallCardUi.SType.Texture}});

	-- local role_config = ConfigManager.Get(EConfigIndex.t_role_index .. self.m_role_default_id);
	local role_config = ConfigHelper.GetRole(tonumber(self.m_role_default_id));
	-- app.log("------------" .. table.tostring(role_config));

	local lab_level = ngui.find_label(self.ui, "centre_other/lab1");
	lab_level:set_text("等级:" .. "1");

	-- 职业
	local sp_pro_type = ngui.find_sprite(self.ui, "centre_other/txt_profession/sp");
	PublicFunc.SetProTypePic(sp_pro_type, role_config.pro_type, 3);

	--克制属性
	-- local sp_restraint = ngui.find_sprite(self.ui, "centre_other/cont1/sp_di/sp_art_font");
	-- PublicFunc.SetRestraintSprite(sp_restraint, role_config.restraint);
	local sp_restraint = ngui.find_label(self.ui, "centre_other/lab_kezhi");
	sp_restraint:set_text(_tex.restraint[5] .. _tex.restraint[role_config.restraint] or "");

	-- 资质
	-- local sp_aptitude = ngui.find_sprite(self.ui, "centre_other/cont2/sp");
	-- PublicFunc.SetAptitudeSprite(sp_aptitude, role_config.aptitude);
	local sp_aptitude = ngui.find_label(self.ui, "centre_other/lab2");
	sp_aptitude:set_text( _tex.eaptitudeName[12] .. PublicFunc.GetAptitudeText(role_config.aptitude) );

	local sp_name = ngui.find_label(self.ui, "centre_other/lab_name");
	sp_name:set_text(role_config.name);

	local lab_describe = ngui.find_label(self.ui, "centre_other/lab_describe");
	lab_describe:set_text("技能");
	-- local star = nil;
	-- for i=1,5 do
	-- 	star = ngui.find_sprite(self.ui, "centre_other/cont3/cont_star/sp_star".. i);
	-- 	star:set_active(i <= role_config.rarity);
	-- end

	local skill_config = nil;
	local skill_sprite = nil;
	local skill_icon = nil;
	local labRank = nil;
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
	for i=1,6 do
		skill_sprite = ngui.find_sprite(self.ui, "centre_other/lab_describe/sp_skill" .. i);
		skill_sprite:set_on_ngui_press(self.bindfunc["on_skill_press"]);
		self.m_skill_textures[i] = ngui.find_texture(self.ui, "centre_other/lab_describe/sp_skill" .. i .. "/Texture");
		labRank = ngui.find_label(self.ui,"centre_other/lab_describe/sp_skill" .. i .. "/lab");
		local cfg = self.skill_info[i];
        if cfg ~= nil then
            skill_config = PublicFunc.GetSkillCfg(self.m_card_human.default_rarity, cfg.skillType, cfg.id)
		    skill_sprite:set_name(tostring(i));
		    self.m_skill_textures[i]:set_texture(skill_config.small_icon);
		    if skill_config.rank then
			    labRank:set_text(PublicFunc.GetPassiveSkillRankText(skill_config.rank));
		    else
			    labRank:set_text("");
		    end
        else
            skill_sprite:set_active(false)
        end		
	end
end

function RecruitDetalUI:on_close( t )
	self:Hide();
	self:DestroyUi();
	self = nil;
end

function RecruitDetalUI:on_skill_press( name, state, x, y, go_obj )
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
