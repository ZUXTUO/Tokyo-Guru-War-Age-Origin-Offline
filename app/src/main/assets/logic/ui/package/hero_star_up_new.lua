HeroStarUpNew = Class("HeroStarUpNew", UiBaseClass);

local neidan_cfg_data = {
	[0] = { name = "体能强化", sprite_name = "tinengqianghuazi", bg_sprite_name = "tinengqianghua", property_name = "neidan_physical_level" },
	[1] = { name = "攻击强化", sprite_name = "gongjiqianghuazi", bg_sprite_name = "gongjiqianghua", property_name = "neidan_attack_level" },
	[2] = { name = "防御强化", sprite_name = "fangyuqianghuazi", bg_sprite_name = "fangyuqianghua", property_name = "neidan_defense_level" },
}
local _UIText = {
	[1] = "下一星级",
	[2] = "当前星级",

    [3] = "解锁该技能升级",
    [4] = "解锁新技能",
    [5] = "解锁潜能强化",

    [6] = "解锁[00F6FF]新技能[-]",
    [7] = "解锁技能[00F6FF]一键升级[-]"
}

local _SPropertyKeys = { 
	[1]="max_hp",
	[2]="atk_power",
	[3]="def_power"
}

function HeroStarUpNew:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/package/ui_602_star_up.assetbundle"
	UiBaseClass.Init(self, data);
end

function HeroStarUpNew:Restart(data)
    self.tipsUI = nil
	if UiBaseClass.Restart(self, data) then

	end
end

function HeroStarUpNew:InitData(data)
	UiBaseClass.InitData(self, data);
	self.roleData = data.info;
	self.parent = data.parent;
	self.isPlayer = data.isPlayer;
	self.go_qh_items = { }
	self.is_open_qh = false
	self.need_soul_id = PublicFunc.GetRoleIdByHeroNumber(self.roleData.config.default_rarity)
end

function HeroStarUpNew:DestroyUi()
	UiBaseClass.DestroyUi(self);
	if self.scard then
		self.scard:DestroyUi();
		self.scard = nil;
	end
	self.shard_exchange_ui = nil
	if self.pro_view_list then
		self.pro_view_list:Destroy()
	end

	if self.pro_view_list then
		self.pro_view_list:Destroy()
	end

	if self.qh_press_propertyListShow then
		self.qh_press_propertyListShow:Destroy()
	end
	if UiHeroQnqh.Inst then
		UiHeroQnqh.Inst.Destroy()
	end
    if self.textSkill then
        self.textSkill:Destroy()
        self.textSkill = nil
    end
    ShardExchange.SDestroy()
end

function HeroStarUpNew:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
	self.bindfunc["on_btn_star_up"] = Utility.bind_callback(self, self.on_btn_star_up);
	self.bindfunc["on_btn_shard_exchange"] = Utility.bind_callback(self, self.on_btn_shard_exchange)
	self.bindfunc["gc_hero_star_up"] = Utility.bind_callback(self, self.gc_hero_star_up);
	self.bindfunc["gc_change_souls"] = Utility.bind_callback(self, self.UpdatePartUi)
	self.bindfunc["gc_neidan_upgrade"] = Utility.bind_callback(self, self.gc_neidan_upgrade)
	self.bindfunc["on_initialize_item"] = Utility.bind_callback(self, self.on_initialize_item)
	self.bindfunc["btn_act_qh"] = Utility.bind_callback(self, self.on_btn_act_qh)
	self.bindfunc["on_btn_qh_ico_press"] = Utility.bind_callback(self, self.on_btn_qh_ico_press)
	self.bindfunc["on_btn_show_property"] = Utility.bind_callback(self, self.on_btn_show_property)
	self.bindfunc["OnBtnQnqh"] = Utility.bind_callback(self, self.OnBtnQnqh)
	self.bindfunc["OnBtnGetAway"] = Utility.bind_callback(self, self.OnBtnGetAway)

end

function HeroStarUpNew:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

-- 注册消息分发回调函数
function HeroStarUpNew:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_cards.gc_hero_star_up, self.bindfunc['gc_hero_star_up']);
	PublicFunc.msg_regist(msg_cards.gc_change_souls, self.bindfunc['gc_change_souls']);
	PublicFunc.msg_regist(msg_cards.gc_change_role_card_property, self.bindfunc["gc_neidan_upgrade"])
	PublicFunc.msg_regist(msg_cards.gc_update_role_cards,self.bindfunc["gc_neidan_upgrade"]);
end

-- 注销消息分发回调函数
function HeroStarUpNew:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_cards.gc_hero_star_up, self.bindfunc['gc_hero_star_up']);
	PublicFunc.msg_unregist(msg_cards.gc_change_souls, self.bindfunc['gc_change_souls']);
	PublicFunc.msg_unregist(msg_cards.gc_change_role_card_property, self.bindfunc["gc_neidan_upgrade"])
	PublicFunc.msg_unregist(msg_cards.gc_update_role_cards,self.bindfunc["gc_neidan_upgrade"]);
end

function HeroStarUpNew:InitUI(obj)
	UiBaseClass.InitUI(self, obj);
	-- self.ui:set_parent(self.parent);
	-- self.ui:set_local_scale(1,1,1);
	self.ui:set_name('ui_battle_star_up');

    local leftPath = "left_other/animation/"  

    local spQizhi = ngui.find_sprite(self.ui, leftPath .. "cont/sp_qizhi")
    spQizhi:set_active(false)

    --星图
    self.starMap = {}
    for i = 1, Const.HERO_MAX_STAR do
        local _path = leftPath .. "cont/sp" .. i
        local _lastPath = leftPath .. "cont/sp" .. (i - 1)
        local temp = {}

        temp.spBigBall = ngui.find_sprite(self.ui, _path)
        temp.spStar = ngui.find_sprite(self.ui,   _path .. "/sp_star")
        temp.objEffect = self.ui:get_child_by_name(_path .. "/fx_ui_602_star")
        temp.objEffect:set_active(false)

        if i == 1 then
            temp.spGallery = nil
        else
            temp.spGallery = ngui.find_sprite(self.ui,  _lastPath .. "/sp_gallery")
        end
        if i == Const.HERO_MAX_STAR then
            temp.spMiddleBall = ngui.find_sprite(self.ui, _path .. '/sp_bk1')
            temp.spSmallBall = ngui.find_sprite(self.ui, _path .. '/sp_bk2')
            temp.spEffect = ngui.find_sprite(self.ui, _path .. '/sp_xxxx')
        else            
            temp.spSmallBall = ngui.find_sprite(self.ui, _path .. '/sp_bk')
        end

        self.starMap[i]  = temp
	end

	self.sp_star = { };
	for i = 1, Const.HERO_MAX_STAR do
		self.sp_star[i] = ngui.find_sprite(self.ui, leftPath .. "cont_star/sp_star" .. i);
	end    

	-- 升星相关
	--self.go_container1 = self.ui:get_child_by_name("centre_other/animation/content/sp_bk3/container1")
	-- 2升星 1潜能强化
	--self.sp_btn_star_exchange1_bg = ngui.find_sprite(self.ui, "centre_other/animation/content/sp_bk3/container1/btn2/animation/sprite_background")
	--self.lbl_btn_star_exhcange1 = ngui.find_label(self.ui, "centre_other/animation/content/sp_bk3/container1/btn2/animation/sprite_background/lab")	
    
	self.lbl_gold_progress_count = ngui.find_label(self.ui, leftPath .. "pro_suipian_di/lab")
	self.pro_suipian = ngui.find_progress_bar(self.ui, leftPath .. "pro_suipian_di")

    self.btn_get_away = ngui.find_button(self.ui, leftPath .. "btn_add")
	self.btn_get_away:set_on_click(self.bindfunc["OnBtnGetAway"])

	--self.lbl_tips = ngui.find_label(self.ui, "centre_other/animation/content/sp_bk2/container1/lab_tips")
	--self.lbl_tip_ext = ngui.find_label(self.ui, "centre_other/animation/content/sp_bk2/sp_title/txt")	

	--[[self.propertys_item2 = {}
	self.propertys_item2.parent = self.ui:get_child_by_name("centre_other/animation/content/sp_bk2/cont_nature")
	for i=1,3 do
		local item = {}
		item.lbl_name = ngui.find_label(self.ui,"centre_other/animation/content/sp_bk2/cont_nature/txt"..i)
		item.lbl_value = ngui.find_label(self.ui,"centre_other/animation/content/sp_bk2/cont_nature/txt"..i.."/lab")
		
		self.propertys_item2[i] = item
	end]]

    local rightPath = "right_other/animation/" 

	self.propertys_item1 = {}
	self.propertys_item1.parent = self.ui:get_child_by_name(rightPath .. "cont_nature")
	for i = 1, 3 do
		local item = {}
		item.lbl_name = ngui.find_label(self.ui, rightPath .. "cont_nature/sp_bk".. i .. '/txt')
        item.lbl_top_value = ngui.find_label(self.ui, rightPath .. "cont_nature/sp_bk".. i .. '/lab_num')
        item.obj_content = self.ui:get_child_by_name(rightPath .. "cont_nature/sp_bk".. i .. '/content')

		item.lbl_value = ngui.find_label(self.ui, rightPath .. "cont_nature/sp_bk".. i .. '/content/lab_num1')
		item.lbl_n_value = ngui.find_label(self.ui, rightPath .. "cont_nature/sp_bk".. i .. '/content/lab_num2')	
		self.propertys_item1[i] = item
	end

	--self.star_property_item = self.ui:get_child_by_name("centre_other/animation/content/sp_bk2/container2/grid/cont1")
	--self.star_property_grid = ngui.find_grid(self.ui, "centre_other/animation/content/sp_bk2/container2/grid")
	--self.go_container2 = self.ui:get_child_by_name("centre_other/animation/content/sp_bk3/container2")
	--self.max_star_property_item = self.ui:get_child_by_name("centre_other/animation/content/sp_bk3/container1/nature_grid/cont1")
	--self.max_star_property_grid = ngui.find_grid(self.ui, "centre_other/animation/content/sp_bk3/container1/nature_grid")

    self.lbl_need_gold = ngui.find_label(self.ui, rightPath .. "content/sp_gold_di/lab")
    self.lblFragment = ngui.find_label(self.ui, rightPath .. "content/sp_suipian_di/lab")

	self.unlockContentNode = self.ui:get_child_by_name(rightPath .. "content/sp_bk")
    self.textSkill = ngui.find_texture(self.ui, rightPath .. "content/sp_bk/Texture")
    self.lblSkillDesc = ngui.find_label(self.ui, rightPath .. "content/sp_bk/lab")
    self.lblSkillDescKey = ngui.find_label(self.ui, rightPath .. "content/sp_bk/lab_skill_name")    

    self.objTopEffect = self.ui:get_child_by_name(rightPath .. "sp_effect")
	self.fxTopEffect = 	self.objTopEffect:get_child_by_name("fx_ui_604_4_dingji")

    self.objContent = self.ui:get_child_by_name( rightPath .. "content")

    self.btn_star_exchange1 = ngui.find_button(self.ui, rightPath .. "btn1")
	self.btn_star_exchange1:set_on_click(self.bindfunc["on_btn_shard_exchange"])
	self.btn_star_exchange1:set_event_value("", 2)

    self.btn_star_up = ngui.find_button(self.ui, rightPath .. "btn2")
	self.btn_star_up:set_on_click(self.bindfunc["on_btn_star_up"],"MyButton.NoneAudio")

	--self.btn_qnqh = ngui.find_button(self.ui, "centre_other/animation/content/sp_bk3/container1/btn2")
	--self.btn_qnqh:set_on_click(self.bindfunc["OnBtnQnqh"])	

	-- self.btn_show_property = ngui.find_button(self.ui, "centre_other/animation/content/sp_bk2/container2/btn2");
	-- self.btn_show_property:set_on_click(self.bindfunc["on_btn_show_property"]);

	self:UpdateUi();
end


 
function HeroStarUpNew:UpdatePropertyUi()
	--self.roleData = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, self.roleData.number)
	self.roleData = 
	{
		rarity = 7,
	}
	--self.is_open_qh = self.roleData.rarity >= Const.HERO_MAX_STAR
	self.props = { }
	--[[
	if not self.is_open_qh then
        if self.roleData.config.star_up_number ~= nil and self.roleData.config.star_up_number ~= 0 then
		    self.props = PublicFunc.GetHeroRarityNextProperyDiff(self.roleData,self.roleData.config.star_up_number,_SPropertyKeys)
        end
		--self.props = self.roleData:GetDiffStarUp()
		--props = self.roleData:GetNextStarLevelProperty()
		
		--self.lbl_tip_ext:set_text(_UIText[1])
	else
		--for k,v in ipairs(_SPropertyKeys) do
		--	self.props[v] = self.roleData:GetPropertyVal(v)
		--end
		--self.props = self.roleData:GetTargetStarAddition(Const.HERO_MAX_STAR)
		--props = self.roleData:GetNextStarLevelProperty()

		-- 设置潜能强化数据
		--self.lbl_tip_ext:set_text(_UIText[2])
	end
	]]
	--app.log("UpdatePropertyUi:"..table.tostring(self.props))
	local a_value= 0;
	--app.log(table.tostring(self.props))
	--do return end
	local property_name_2_local_name = function(property_name)
		local property_id = ENUM.EHeroAttribute[property_name]
		return property_id,gs_string_property_name[property_id]
	end
	--if table.get_num(self.props) ~= 0 then
		--if not self.is_open_qh then
        if self.roleData.rarity < Const.HERO_MAX_STAR then
			local index = 1
			for k,v in pairs(_SPropertyKeys) do
				k = v
				v = self.props[v]	
				local item = self.propertys_item1[index]
				local property_id,local_name = property_name_2_local_name(k)
                item.lbl_top_value:set_active(false)
                item.obj_content:set_active(true)
				--item.lbl_name:set_text(local_name)
				item.lbl_value:set_text(PropertyListShow.Value2ShowForamt(property_id, self.roleData:GetPropertyVal(k)))
				item.lbl_n_value:set_text(PropertyListShow.Value2ShowForamt(property_id, v + self.roleData:GetPropertyVal(k)))
				index = index + 1				
			end	
			--self.propertys_item1.parent:set_active(true)
			--self.propertys_item2.parent:set_active(false)
        --满级
		else
            local index = 1
            for k,v in pairs(_SPropertyKeys) do
				k = v
				local item = self.propertys_item1[index]
				local property_id,local_name = property_name_2_local_name(k)
				--item.lbl_name:set_text(local_name)
                item.obj_content:set_active(false)
                item.lbl_top_value:set_active(true)
                --item.lbl_top_value:set_text(PropertyListShow.Value2ShowForamt(property_id, self.roleData:GetPropertyVal(k)))
				item.lbl_top_value:set_text(PropertyListShow.Value2ShowForamt(property_id, 0))
				index = index + 1			
			end	
			--[[local index = 1
			for k,v in pairs(_SPropertyKeys) do
				k = v
				v = self.props[v]	
				local item = self.propertys_item2[index]
				local property_id,local_name = property_name_2_local_name(k)
				item.lbl_name:set_text(local_name)
				item.lbl_value:set_text(PropertyListShow.Value2ShowForamt(property_id,self.roleData:GetPropertyVal(k)))
				index = index + 1			
			end	
			self.propertys_item1.parent:set_active(false)
			self.propertys_item2.parent:set_active(true)]]
		 
		end
	--end

end

function HeroStarUpNew:OnBtnQnqh(t)
	app.log("TODO:打开潜能强化")
	UiHeroQnqh.Star(self.roleData)
end

function HeroStarUpNew:OnBtnGetAway(t)
    local data = {}
    
    -- 检查 self.roleData.config 是否为 nil
    if self.roleData.config == nil then
        -- 创建默认数据
        self.roleData.config = {
            soul_count = 999 -- 设置默认的 soul_count
        }
        app.log("Warning: self.roleData.config is nil, using default values.")
    end

    data.item_id = self.need_soul_id
    data.number = self.roleData.config.soul_count
    AcquiringWayUi.Start(data)
end


function HeroStarUpNew:on_initialize_item(obj, b, real_id)
	-- app.log(string.format("HeroStarUpNew:on_initialize_item ojb=%s,b=%s,real_id=%s",tostring(obj),tostring(b),tostring(real_id)))
	if not self.is_open_qh then return end
	if not self.go_qh_items[b] then
		self.go_qh_items[b] = {
			btn_ico_qh = ngui.find_button(obj,"sp_bk"),
			sp_qh_bg = ngui.find_sprite(obj,"sp_bk"),
			sp_qh_font = ngui.find_sprite(obj,"sp_bk/sp_art_font"),
			lbl_chip_number = ngui.find_label(obj,"sp_bk1/lab"),
			lbl_gold_number = ngui.find_label(obj,"sp_bk2/lab"),
			lbl_level = ngui.find_label(obj,"sp_title/lab"),
			go_content = obj:get_child_by_name("go_content"),
			btn_act_qh = ngui.find_button(obj,"go_content/btn1"),
			sp_top_level = ngui.find_sprite(obj,"sp_top_level")
		}
	end
	local go_item = self.go_qh_items[b]
	if go_item then
		local _row_data = neidan_cfg_data[b]

		local neidan_cfg = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(self.roleData.config.neidan))
		if neidan_cfg then
			local group_neidan_cfg = neidan_cfg[b]
			if not group_neidan_cfg then
				app.log("not found neidan_cfg,category=" .. tostring(b))
				return
			end

			local _curr_level = self.roleData[_row_data.property_name]
			local neidan_current_level_cfg = group_neidan_cfg[_curr_level]
			local neidan_next_level_cfg = group_neidan_cfg[_curr_level + 1]
			-- 是否拥有下一级配置，用来判断是否显示LevelMax
			local has_next_level = neidan_next_level_cfg ~= nil
			-- app.log(string.format("xxxx: has_next_level [%s],level=%s,group=%s",tostring(has_next_level),table.tostring(neidan_next_level_cfg),table.tostring(group_neidan_cfg)))
			if has_next_level then
				go_item.go_content:set_active(true)
				go_item.sp_top_level:set_active(false)

				go_item.lbl_level:set_text("LV." .. tostring(self.roleData[_row_data.property_name] or 1))

				go_item.btn_act_qh:set_on_click(self.bindfunc["btn_act_qh"])
				go_item.btn_act_qh:set_event_value("", b)


				go_item.lbl_chip_number:set_text(PublicFunc.GetProgressColorStr(g_dataCenter.package:GetCountByNumber(self.need_soul_id), neidan_current_level_cfg.upgrade_chip))
				go_item.lbl_gold_number:set_text(PublicFunc.GetProgressColorStr(g_dataCenter.player.gold, neidan_current_level_cfg.upgrade_gold, false))
			else
				go_item.go_content:set_active(false)
				go_item.sp_top_level:set_active(true)
				go_item.lbl_level:set_text("LV.MAX")
			end

			go_item.sp_qh_bg:set_sprite_name(_row_data.bg_sprite_name)
			go_item.sp_qh_font:set_sprite_name(_row_data.sprite_name)
		end

		go_item.btn_ico_qh:set_on_ngui_press(self.bindfunc["on_btn_qh_ico_press"])
		go_item.btn_ico_qh:get_parent():set_name(tostring(b))
	end
end

local __starUnlockConfig = 
{
    --[2] = {func = PublicFunc.GetUnlockSkillInfo, desc = _UIText[3]},
    [3] = {func = PublicFunc.GetUnlockSkillInfo, desc = _UIText[4]},
    [4] = {func = PublicFunc.GetUnlockSkillInfo, desc = _UIText[4]},
    [5] = {func = PublicFunc.GetUnlockSkillInfo, desc = _UIText[4]},
    [6] = {func = PublicFunc.GetUnlockSkillInfo, desc = _UIText[4]},
	[7] = {func = PublicFunc.GetUnlockSkillInfo, desc = _UIText[4]},
}

function HeroStarUpNew:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then return end
	if not self.roleData then return end
	--self.roleData = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, self.roleData.number)
	-- 是否开启潜能强化
	--self.is_open_qh = self.roleData.rarity >= Const.HERO_MAX_STAR
	--self.go_container2:set_active(not self.is_open_qh)
	--self.go_container1:set_active(self.is_open_qh)

	-- 更新属性面板
	--self:UpdatePropertyUi()

	self.roleData = 
	{
		rarity = 7,
	}

    for i = 1, Const.HERO_MAX_STAR do
        local ui = self.starMap[i]
        ui.objEffect:set_active(false)

        if i <= self.roleData.rarity then
            ui.spBigBall:set_sprite_name('yx_shengxing_qipao(3)')
            ui.spStar:set_active(true)
            ui.spSmallBall:set_active(false)

            if ui.spGallery then
                ui.spGallery:set_sprite_name('yx_shengxing_lianjie(' .. (i - 1) .. ')')
            end
		else
            ui.spBigBall:set_sprite_name('yx_shengxing_qipao3')
            ui.spStar:set_active(false)
            ui.spSmallBall:set_active(true)

            if ui.spGallery then
                ui.spGallery:set_sprite_name('yx_shengxing_lianjie' .. (i - 1))
            end
		end
        if i == Const.HERO_MAX_STAR then
            if i == self.roleData.rarity then
                ui.spMiddleBall:set_sprite_name('yx_shengxing_qipao(2)')
                ui.spEffect:set_active(true)
            else
                ui.spMiddleBall:set_sprite_name('yx_shengxing_qipao2')
                ui.spEffect:set_active(false)
            end
        end
    end

	for i = 1, PublicStruct.Const.HERO_MAX_STAR do
		if self.sp_star[i] then
			if i <= self.roleData.rarity then
				self.sp_star[i]:set_sprite_name("xingxing1");
			else
				self.sp_star[i]:set_sprite_name("xingxing3");
			end
		end
	end

	self:UpdatePartUi()

	if UiHeroQnqh.Inst and UiHeroQnqh.Inst:IsShow() then
		UiHeroQnqh.Inst:SetInfo(self.roleData)
	end	
    
    local nextStar = self.roleData.rarity + 1
    --self.textSkill:set_active(false)
    --self.lblSkillDesc:set_active(false)
	self.unlockContentNode:set_active(false)
    if nextStar <= PublicStruct.Const.HERO_MAX_STAR then
        local info = nil
        local config = __starUnlockConfig[nextStar]
        if config then
            info = config.func(self.roleData, nextStar, false)
        end
        if info ~= nil then
            --self.textSkill:set_active(true)
            --self.lblSkillDesc:set_active(true)
			self.unlockContentNode:set_active(true)
            self.textSkill:set_texture(info.icon)
            --self.lblSkillDesc:set_text(config.desc)
        end

        if nextStar >= 3 then
            if nextStar == 5 then
                self.lblSkillDescKey:set_text(_UIText[6] .. '\n' .. _UIText[7]) 
            else
                self.lblSkillDescKey:set_text(_UIText[6])
            end
        else
            self.lblSkillDescKey:set_text('') 
        end


    -- elseif nextStar == PublicStruct.Const.HERO_MAX_STAR then
    --     self.lblSkillDesc:set_active(true)
    --     self.lblSkillDesc:set_text(_UIText[5])
    end

    self.objTopEffect:set_active(false)
    self.objContent:set_active(false)
    self.btn_star_exchange1:set_active(true)
    self.btn_star_up:set_active(true)

    if self.roleData.rarity < Const.HERO_MAX_STAR then
        self.objContent:set_active(true)
    else
        self.objTopEffect:set_active(true)
		self.fxTopEffect:set_active(false)

        self.btn_star_exchange1:set_active(false)
        self.btn_star_up:set_active(false)
    end

    self:UpdateUITips()

end

function HeroStarUpNew:UpdateUITips()
    if not AppConfig.get_enable_guide_tip() then
		return
	end
    if self.roleData == nil then
        return
    end
    if self.tipsUI == nil then
        self.tipsUI = {
            ["btn_rarity_up"] = ngui.find_sprite(self.ui,  "right_other/animation/btn2/animation/sp_point"),
        }
    end
    --local __flag1 = PublicFunc.ToBoolTip(self.roleData:CanStarUp())
    --self.tipsUI["btn_rarity_up"]:set_active(__flag1)
end

-- 更新碎片信息
function HeroStarUpNew:UpdatePartUi()
	--local souls = g_dataCenter.player.package:find_count(ENUM.EPackageType.Item, self.need_soul_id)
	--local need = self.roleData.config.soul_count;
	local souls = 1;
	local need = 1;

	self.lbl_gold_progress_count:set_text("[973900]" ..souls .. '[-][000000]/' .. need .. "[-]")
    self.lblFragment:set_text(PublicFunc.GetProgressColorStr(souls, need, false))

	self.pro_suipian:set_value(souls / need)
	--self.lbl_need_gold:set_text(PublicFunc.GetProgressColorStr(g_dataCenter.player.gold, self.roleData.config.star_up_gold, false))
	self.lbl_need_gold:set_text(PublicFunc.GetProgressColorStr(g_dataCenter.player.gold, 0, false))

	self:UpdatePropertyUi()
end 

function HeroStarUpNew:on_btn_close(t)
	uiManager:PopUi();
end

function HeroStarUpNew:on_btn_star_up()
	if self.roleData.index == 0 then
		HintUI.SetAndShow(EHintUiType.zero, "您还未获得该角色");
		return
	end
	if not self.isPlayer and self.isPlayer ~= nil then
		return
	end


	if self.is_open_qh then
		--self.go_container2:set_active(true)
		--self.go_container1:set_active(false)
	else
		if self.roleData.rarity >= Const.HERO_MAX_STAR then
			FloatTip.Float("已经是最高星级了");
			return
		end
		if g_dataCenter.player.gold < self.roleData.config.star_up_gold then
			FloatTip.Float("金币不足")
			return
		end
		local souls = g_dataCenter.player.package:find_count(ENUM.EPackageType.Item, self.need_soul_id);
		local need = self.roleData.config.soul_count;

		if souls >= need then
			msg_cards.cg_hero_star_up(self.roleData.index, 1);
		else
			FloatTip.Float("碎片不足")
		end
	end
end

function HeroStarUpNew:on_btn_shard_exchange(t)
	-- if nil == self.shard_exchange_ui then
	-- 	self.shard_exchange_ui = ShardExchange:new( { info = self.roleData, number_type = t.float_value })
	-- else
	-- 	self.shard_exchange_ui:Show( { info = self.roleData, number_type = t.float_value })
	-- end
	ShardExchange.Start({ info = self.roleData, number_type = t.float_value })
end

function HeroStarUpNew:on_btn_act_qh(t)
	local point = t.float_value

	local neidan_cfg = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(self.roleData.config.neidan))
	local current_level = self.roleData[neidan_cfg_data[point].property_name]
	local neidan_current_level_cfg = neidan_cfg[point][current_level]
	if neidan_current_level_cfg then
		if g_dataCenter.package:GetCountByNumber(self.need_soul_id) < neidan_current_level_cfg.upgrade_chip then
			FloatTip.Float("碎片不足")
			return
		end

		if g_dataCenter.player.gold < neidan_current_level_cfg.upgrade_gold then
			FloatTip.Float("金币不足 ")
			return
		end
		-- 保存当前战斗力
		self.roleData.old_fight_value = self.roleData:GetFightValue()

		msg_cards.cg_neidan_upgrade(self.roleData.index, point)
		self.last_neidan_index = point
	end
	-- g_dataCenter.player.package:find_count(ENUM.EPackageType.Item, self.need_soul_id);

end


function HeroStarUpNew:on_btn_qh_ico_press(name, state, x, y, goObj)
	--app.log(string.format("name=%s,state=%s,x=%s,y=%s,goObj=%s", name, tostring(state), tostring(x), tostring(y), tostring(goObj:get_name())))

	self.sp_di_item:set_active(state)
	if (state) then
		local p_name = goObj:get_parent():get_name()
		local index = tonumber(p_name)
		local local_neidan_cfg = neidan_cfg_data[index]
		if neidan_cfg_data then
			self.sp_di_itembg:set_sprite_name(local_neidan_cfg.bg_sprite_name)
			self.lbl_sp_item:set_text(local_neidan_cfg.name)

			-- 获取内丹配置数据

			local neidan_cfg = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(self.roleData.config.neidan))
			if neidan_cfg then
				local _level = self.roleData[local_neidan_cfg.property_name]
				-- app.log(string.format("xxxxxxxxxxx :_level=%s,index=%s,property_name=%s",tostring(_level),tostring(index),local_neidan_cfg.property_name))
				local neidan_level_cfg = neidan_cfg[index][_level]

				local props = { }
				for k, v in pairs(CardHuman.GetDefaultSHowPropertyNames()) do
					local p_data = neidan_level_cfg[v]
					if p_data and p_data > 0 then
						props[v] = p_data
					end
				end

				-- app.log("xxxxxxxxxxxxxxx:"..table.tostring(props))

				if not self.qh_press_propertyListShow then
					self.qh_press_propertyListShow = PropertyListShow:new( {
						info = props,
						pro_item = self.go_qh_property_grid_item,
						format_type = 1,
						pro_grid = self.grid_qh_property
					} )
				else
					self.qh_press_propertyListShow:UpdateUi(props)
				end
			end

		else
			app.log("获取本地潜能强化数据失败")
		end
	end
end

function HeroStarUpNew:on_btn_show_property(t)
	--self.go_container1:set_active(true)
	--self.go_container2:set_active(false)
end

function HeroStarUpNew:gc_hero_star_up(result)
	if result == 0 then
		self:after_hero_star_up()
		local function delay()
			g_SingleLockUI.Hide()
			UiHeroStarUpAnimation.SetAndShow( { roleData = self.roleData });
			--UiHeroStarUpAnimation.SetTouchCallback(self.after_hero_star_up, self)
		end
		timer.create(Utility.create_callback(delay), 2500, 1);
		AudioManager.PlayUiAudio(81200103)

		--TODO 7星判断
		-- if self.roleData.rarity == Const.HERO_MAX_STAR then
		-- 	AdvFuncPanel.ShowAdvance({icon_path="",title_path="",desc1="潜能强化开启",desc2=""})
		-- end
		
	end
end

function HeroStarUpNew:after_hero_star_up()
    self.roleData = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, self.roleData.number)
	self:UpdateUi();
    --播放特效
    local ui = self.starMap[self.roleData.rarity]
    if ui then
        ui.objEffect:set_active(false)
        ui.objEffect:set_active(true)
    end
	if self.roleData.rarity == Const.HERO_MAX_STAR then
		self.fxTopEffect:set_active(false)
		self.fxTopEffect:set_active(true)
	end
end

function HeroStarUpNew:gc_neidan_upgrade(role_id,property)
	--app.log("HeroStarUpNew:on_gc_neidan_upgrade " .. tostring(result))
	if role_id ~= self.roleData.index then
		return
	end
	-- local old_fight_value = self.roleData:GetFightValue()
	self.roleData = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, self.roleData.number)
	self:UpdatePropertyUi()
	-- app.log(string.format("new=%s,old=%s", tostring(self.roleData:GetFightValue()), tostring(self.roleData.old_fight_value)))
	-- FightValueChangeUI.ShowChange(ENUM.FightingType.Role, self.roleData:GetFightValue(), self.roleData.old_fight_value)
	-- local neidan_cfg = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(self.roleData.config.neidan))

	-- local current_level = self.roleData[neidan_cfg_data[self.last_neidan_index].property_name]
	-- local neidan_last_level_cfg = neidan_cfg[self.last_neidan_index][current_level - 1]
	-- local neidan_current_level_cfg = neidan_cfg[self.last_neidan_index][current_level]

	-- local props = { }
	-- for k, v in pairs(CardHuman.GetDefaultSHowPropertyNames()) do
	-- 	local l_data = neidan_last_level_cfg[v]
	-- 	local c_data = neidan_current_level_cfg[v]
	-- 	if c_data and l_data then
	-- 		if c_data - l_data > 0 then
	-- 			props[v] = c_data - l_data
	-- 		end
	-- 	end
	-- end
	-- for k, v in pairs(props) do
	-- 	local p_name = gs_string_property_name[ENUM.EHeroAttribute[k]]
	-- 	local x, y, z = self.go_qh_items[self.last_neidan_index].go_content:get_position()
	-- 	-- app.log(string.format("xxxxxxxxxxxxxx:x=%s,y=%s,z=%s",tostring(x),tostring(y),tostring(z)))
	-- 	PopLabMgr.PushMsg( { str = string.format("%s +%.0f", p_name, v), world_pos = { x = x, y = y, z = z } })
	-- end

	-- app.log("xxxxxxxxxxxxxxxxxxxxxxx:"..table.tostring(props))
end

function HeroStarUpNew:SetInfo(roleData, isPlayer)
	self.roleData = roleData;
	self.isPlayer = isPlayer;
	self.need_soul_id = PublicFunc.GetRoleIdByHeroNumber(self.roleData.config.default_rarity)
	self:UpdateUi();
end


function HeroStarUpNew:Show()
	--app.log("HeroStarUpNew:Show "..debug.traceback())
	if UiBaseClass.Show(self) then
		-- self:PlayLevelUp(false)
		self:UpdateUi()
	end
end

function HeroStarUpNew:Hide()
	if UiBaseClass.Hide(self) then
		-- self:PlayLevelUp(false)
		-- self.hero_upe_level_log:clear()

	end
	if UiHeroQnqh.Inst then
		UiHeroQnqh.Inst:Hide()
	end
end


function HeroStarUpNew:ShowEx()
	--	app.log("HeroStarUpNew:ShowEx "..debug.traceback())
	UiBaseClass.Show(self)
end

function HeroStarUpNew:HideEx( )
	UiBaseClass.Hide(self)
end