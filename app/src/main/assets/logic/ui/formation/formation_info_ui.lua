FormationInfoUi = Class("FormationInfoUi", UiBaseClass);

function FormationInfoUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/zhenrong/ui_602_4_1.assetbundle";
    UiBaseClass.Init(self, data);
end

function FormationInfoUi:InitData(data)
	self.chosePos = 1;
    self.equipPositionList = {
        ENUM.EEquipPosition.weapon,  ENUM.EEquipPosition.Armor, 
        ENUM.EEquipPosition.Trouser, ENUM.EEquipPosition.Boots, 
        ENUM.EEquipPosition.Helmet, ENUM.EEquipPosition.Accessories
    } 
    UiBaseClass.InitData(self, data);
end

function FormationInfoUi:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
end

function FormationInfoUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_click_info"] = Utility.bind_callback(self, self.on_click_info);
    self.bindfunc["on_click_equip"] = Utility.bind_callback(self, self.on_click_equip);
    self.bindfunc["on_click_intensify"] = Utility.bind_callback(self, self.on_click_intensify);
    self.bindfunc["on_change_role"] = Utility.bind_callback(self, self.on_change_role);
    self.bindfunc["on_lock_equip"] = Utility.bind_callback(self, self.on_lock_equip);
end

function FormationInfoUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_602_4_1");

    local btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
    btnClose:set_on_click(self.bindfunc["on_close"]);

    self.objHead = {};
    for i=1,3 do
    	self.objHead[i] = {};
    	local obj = self.ui:get_child_by_name("centre_other/animation/sp_left_di/big_card_item_80"..i);
    	local data = {};
    	data.parent = obj;
    	data.stypes = {
    		SmallCardUi.SType.Texture,
    		SmallCardUi.SType.Level,
    		SmallCardUi.SType.Star,
    		SmallCardUi.SType.Qh,
    		SmallCardUi.SType.Rarity,
    	};
    	self.objHead[i].obj = SmallCardUi:new(data);
    	self.objHead[i].obj:SetCallback(self.bindfunc["on_change_role"]);
    	self.objHead[i].obj:SetParam(i);
    end

    self.labFightPower = ngui.find_label(self.ui,"centre_other/animation/sp_left_di/sp_bk/lab_fight");

    self.teamNode = {};
    self.teamNode.btnInfo = ngui.find_button(self.ui,"centre_other/animation/content/sp_di1/btn_rule");
    self.teamNode.btnInfo:set_on_click(self.bindfunc["on_click_info"]);
    self.teamNode.btnInfo:set_active(false);
    self.teamNode.btnEquip = ngui.find_button(self.ui,"centre_other/animation/right_content/btn_1");
    self.teamNode.btnEquip:set_on_click(self.bindfunc["on_click_equip"]);
    self.teamNode.spEquipPoint = ngui.find_sprite(self.ui,"centre_other/animation/right_content/btn_1/animation/sp_point");
    self.teamNode.btnIntensify = ngui.find_button(self.ui,"centre_other/animation/right_content/btn_2");
    self.teamNode.btnIntensify:set_on_click(self.bindfunc["on_click_intensify"]);
    self.teamNode.spIntensifyPoint = ngui.find_sprite(self.ui,"centre_other/animation/right_content/btn_2/animation/sp_point");
    self.teamNode.equip = {};
    for j=1,6 do
    	self.teamNode.equip[j] = {};
    	local node = self.ui:get_child_by_name("centre_other/animation/right_content/grid/new_small_card_item"..j);
    	local data = {};
    	data.parent=node;
    	data.equip ={new_point = true, level_tip = true};
    	self.teamNode.equip[j].obj = UiSmallItem:new(data);
        self.teamNode.equip[j].btnMark = ngui.find_sprite(self.ui,"centre_other/animation/right_content/grid/new_small_card_item"..j.."/sp_mark");
        if self.teamNode.equip[j].btnMark then
            self.teamNode.equip[j].btnMark:set_on_ngui_click(self.bindfunc["on_lock_equip"]);
            self.teamNode.equip[j].btnMark:set_event_value(tostring(self.equipPositionList[j]))
        end
    end
    self.teamNode.star = {};
    for j=1,Const.HERO_MAX_STAR do
    	self.teamNode.star[j] = {};
    	self.teamNode.star[j].obj = self.ui:get_child_by_name("centre_other/animation/content/sp_di1/content_star/sp_star"..j);
    end
    self.teamNode.labName = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/lab_name");
    self.teamNode.labLv = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/lab_level");
    self.teamNode.spOcc = ngui.find_sprite(self.ui,"centre_other/animation/content/sp_di1/cont1/sp");
    self.teamNode.labRarity = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/cont2/lab");
    self.teamNode.labRestrait = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/cont3/lab");
    self.teamNode.labHP = ngui.find_label(self.ui,"centre_other/animation/content/sp_di2/nature_grid/cont1/lab");
    self.teamNode.labAttack = ngui.find_label(self.ui,"centre_other/animation/content/sp_di2/nature_grid/cont2/lab");
    self.teamNode.labDef = ngui.find_label(self.ui,"centre_other/animation/content/sp_di2/nature_grid/cont3/lab");
	self.teamNode.contacts = {};
	for i = 1, 6 do
		self.teamNode.contacts[i] = ngui.find_label(self.ui, "centre_other/animation/content/sp_di3/grid/sp_di"..i.."/lab")
	end

    self:UpdateUi();
end

function FormationInfoUi:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    self.labFightPower:set_text(tostring(g_dataCenter.player:GetFightValue()));

    local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
    local curCard = nil;
    for i=1,3 do
    	local card = g_dataCenter.package:find_card(1,team[i])
        self.objHead[i].obj:SetData(card);
    	if card then
    		if i == self.chosePos then
    			self.objHead[i].obj:ChoseItem(true);
    			curCard = card;
    		else
    			self.objHead[i].obj:ChoseItem(false);
    		end
    	end
    end

    for j=1,6 do
    	local pos = self.equipPositionList[j]
    	local dataid = curCard.equipment[pos] 
    	if dataid ~= '0' then
    		local cardEquip = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, dataid);
    		self.teamNode.equip[j].obj:SetData(cardEquip)
    		self.teamNode.equip[j].obj:SetOnClicked(self.bindfunc["on_click_equip"],nil,nil,j);
            if self.teamNode.equip[j].btnMark then
                if cardEquip:IsEquipLock() then
                    self.teamNode.equip[j].btnMark:set_active(true);
                else
                    self.teamNode.equip[j].btnMark:set_active(false);
                end
            end
        else
    		app.log("equip dataid = '0'. pos:"..pos);
    	end
    end
    for j=1,Const.HERO_MAX_STAR do
    	if j <= curCard.rarity then
    		self.teamNode.star[j].obj:set_active(true)
    	else
    		self.teamNode.star[j].obj:set_active(false)
    	end
    end
    self.teamNode.labName:set_text(tostring(curCard.name));
    self.teamNode.labLv:set_text("Lv."..tostring(curCard.level));
    PublicFunc.SetProTypePic(self.teamNode.spOcc, curCard.config.pro_type, 3)
    self.teamNode.labRarity:set_text(PublicFunc.GetAptitudeText(curCard.config.aptitude))
    self.teamNode.labRestrait:set_text(PublicFunc.GetRestraintStr(curCard.config.restraint))
    local data = PublicFunc.GetPropertyShowValue(curCard);
    self.teamNode.labHP:set_text(tostring(data[1][2]));
    self.teamNode.labAttack:set_text(tostring(data[2][2]));
    self.teamNode.labDef:set_text(tostring(data[3][2]));

    if AppConfig.get_enable_guide_tip() then
        if curCard:CanPowerUp() then
            self.teamNode.spIntensifyPoint:set_active(true);
        else
            self.teamNode.spIntensifyPoint:set_active(false);
        end
        if PublicFunc.ToBoolTip(curCard:CanLevelUpAnyEquip()) or PublicFunc.ToBoolTip(curCard:CanStarUpAnyEquip()) then
            self.teamNode.spEquipPoint:set_active(true);
        else
            self.teamNode.spEquipPoint:set_active(false);
        end
    end

	local data = PublicFunc.GetContactDescData(curCard);
	if data and type(data) == "table" then
		for i = 1,6 do
			local row_data = data[i];
			if row_data then
				self.teamNode.contacts[i]:set_text(row_data.name);
				self.teamNode.contacts[i]:set_active(true);
			else
				self.teamNode.contacts[i]:set_active(false);
			end
		end
	end
end

function FormationInfoUi:setPos(pos)
	self.chosePos = pos;
	self:UpdateUi();
end

function FormationInfoUi:DestroyUi()
    for i=1,3 do
    	self.objHead[i].obj:DestroyUi();
    end
    for j=1,6 do
    	self.teamNode.equip[j].obj:DestroyUi();
    end
    UiBaseClass.DestroyUi(self);
end

function FormationInfoUi:on_close(t)
	uiManager:PopUi();
end

function FormationInfoUi:GetCurrHeroCard()
    local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
    return g_dataCenter.package:find_card(1, team[self.chosePos])
end

function FormationInfoUi:on_click_info(t)
	local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
    local curCard = g_dataCenter.package:find_card(1,team[self.chosePos])
    local ui = uiManager:PushUi(EUI.BattleUI);
    ui:SetRoleNumber(curCard.number,true);
end

function FormationInfoUi:on_click_equip(t)
    local open_level = ConfigManager.Get(EConfigIndex.t_play_vs_data,62000006).open_level;
    if g_dataCenter.player:GetLevel() < open_level then
        FloatTip.Float(string.format('战队等级达到%d级开启', open_level))
        return;
    end
	local pos = t.ex_data;
	local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
    local curCard = g_dataCenter.package:find_card(1,team[self.chosePos])
    uiManager:PushUi(EUI.EquipPackageUI, {cardNumber = curCard.number, equipPos = pos})
end

function FormationInfoUi:on_click_intensify(t)
	local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
    local curCard = g_dataCenter.package:find_card(1,team[self.chosePos])
    local ui = uiManager:PushUi(EUI.BattleUI);
    ui:SetRoleNumber(curCard.number,true);
    ui:SetToggle(62002001);
end

function FormationInfoUi:on_change_role(obj, info, pos)
    if info then 
        self:setPos(pos);
    else
        FloatTip.Float('该位置未有上阵角色');
    end
end

function FormationInfoUi:on_lock_equip(name, x, y, go_obj, value)
    local position = tonumber(value)
    if position == ENUM.EEquipPosition.Helmet then
        id = MsgEnum.ediscrete_id.eDiscreteID_equip_level_up_helmet_unlock_player_level
    elseif position == ENUM.EEquipPosition.Accessories then
        id = MsgEnum.ediscrete_id.eDiscreteID_equip_level_up_accessories_unlock_player_level
    end
    local level = ConfigManager.Get(EConfigIndex.t_discrete, id).data
    FloatTip.Float(string.format('战队等级达到%d级开启', level))
end
