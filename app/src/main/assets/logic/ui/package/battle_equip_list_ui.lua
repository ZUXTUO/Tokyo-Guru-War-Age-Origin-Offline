BattleEquipListUI = Class("BattleEquipListUI",UiBaseClass);

function BattleEquipListUI:Init(data)
	-- self.smallPool = data.atlas;
	self.roleData = data.info;
    self.backCallback = data.callback;
    self.showRight = data.show_right;
    self.showLeft = data.show_left;
    self.loading = data.loading;
    self.equipPos = data.equip_pos;

    self.equipList = nil;
    self.equipView = nil;
    self.equipItem = {};
    self.choseItemInfo = nil;
    self.equipShowList = {};
    self.equipDiffAttr = {};

    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_battle_2.assetbundle";
    UiBaseClass.Init(self, data);
end

function BattleEquipListUI:SetInfo(info)
	self.roleData = info;
end

function BattleEquipListUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["chose_item"] = Utility.bind_callback(self, self.chose_item);
    self.bindfunc["on_btn_equip"] = Utility.bind_callback(self, self.on_btn_equip);
    self.bindfunc["set_equip_item"] = Utility.bind_callback(self, self.set_equip_item);
    self.bindfunc["on_init_equip_attr"] = Utility.bind_callback(self, self.on_init_equip_attr);
    self.bindfunc["on_hide_equipment_info"] = Utility.bind_callback(self, self.on_hide_equipment_info);
    self.bindfunc["on_seach"] = Utility.bind_callback(self, self.on_seach);
    self.bindfunc["UpdatePackage"] = Utility.bind_callback(self, self.UpdatePackage);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
end

function BattleEquipListUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("battle_equip_list_ui")

    local path = "content2";
    self.spNotHaveEquip = self.ui:get_child_by_name(self.ui:get_name().."/sp_bk");
    --right
    self.rightUi = ngui.find_sprite(self.ui,path);
    self.equipView= ngui.find_wrap_content(self.ui,path.."/panel_list/wrap_content");
    self.equipView:set_on_initialize_item(self.bindfunc["set_equip_item"]);
    self.scrollview = ngui.find_scroll_view(self.ui,path.."/panel_list");
    local _btnSeach = ngui.find_button(self.ui,path.."/btn5");
    _btnSeach:set_on_click(self.bindfunc["on_seach"]);
    --left
    path = "content1";
    self.ui2 = ngui.find_sprite(self.ui,path);
    self.ui2:set_active(false);
    self.equipGrid = ngui.find_wrap_content(self.ui,path.."/panel_content/scrollview_nature1/wrap_content");
    self.equipGrid:set_on_initialize_item(self.bindfunc["on_init_equip_attr"]);
    self.equipAttrScroll = ngui.find_scroll_view(self.ui,path.."/panel_content/scrollview_nature1");
    self.equipAttr = ngui.find_label(self.ui,path.."/panel_content/scrollview_nature2/lab");
    self.equipName = ngui.find_label(self.ui,path.."/lab_name");
    self.equipLevel = ngui.find_label(self.ui,path.."/lab_lv");
    self.equipLetter = ngui.find_sprite(self.ui,path.."/sp");
    self.equipFrame = ngui.find_sprite(self.ui,path.."/sp_bk/sp_frame");
    self.equipSp = ngui.find_texture(self.ui,path.."/sp_bk/sp_icon");
    self.equipStar = {};
    local obj = self.ui:get_child_by_name("sp_human_di");
    self.spHuamHead = SmallCardUi:new({obj=obj});
    -- self.spHuamFrame = ngui.find_sprite(self.ui,"sp_human_di/sp_frame");
    for i=1,5 do
        self.equipStar[i] = ngui.find_sprite(self.ui,path.."/star/sp_star_di"..i.."/star");
    end
    local _btnEquip = ngui.find_button(self.ui,path.."/btn");
    _btnEquip:set_on_click(self.bindfunc["on_btn_equip"]);
    local _btnClose = ngui.find_button(self.ui,path.."/btn_close");
    _btnClose:set_on_click(self.bindfunc["on_hide_equipment_info"]);

    if self.equipPos then
        self:Show(self.equipPos);
    end
    -- self.btnList = ngui.find_sprite(self.ui,"centre_other/animation/right_content/btn");
    -- self.equip = ngui.find_sprite(self.ui,"centre_other/animation/left_content/content1");
    -- self.equipList:set_active(false);
    -- self:UpdateEquipmentInfo();
end

function BattleEquipListUI:set_equip_item(obj,b,real_id)
    local index = math.abs(real_id)+1;
    local info = self.equipShowList[index];
    if not info then
        app.log("BattleEquipListUI set_equip_item real_id:"..tostring(index));
        return;
    end
    if self.equipItem[real_id] then
        self.equipItem[real_id]:SetInfo(info,obj);
        self.equipItem[real_id]:ChoseItem(false);
    else
        local data = {
            -- equip_atlas = self.smallPool,
        };
        self.equipItem[real_id] = EquipItemUI:new(data);
        self.equipItem[real_id]:SetInfo(info,obj);
        self.equipItem[real_id]:SetCallback(self.bindfunc["chose_item"]);
        self.equipItem[real_id]:ChoseItem(false);
    end
    if self.choseItemInfo and self.choseItemInfo.index == info.index then
        self:chose_item(self.equipItem[real_id],info);
    end
end

function BattleEquipListUI:chose_item(obj,info)
    if self.choseItem then
        self.choseItem:ChoseItem(false);
    end
    self.choseItem = obj;
    self.choseItemInfo = info;
    self.choseItem:ChoseItem(true);
    self:UpdateEquipmentInfo();
end

function BattleEquipListUI:UpdateEquipmentInfo()
    if self.choseItemInfo then
        self.ui2:set_active(true);
        -- self.equip:set_active(false);
        _G[self.showLeft](false);
        local _equipInfo = g_dataCenter.package:find_card(2,self.roleData.equipment[self.equipPos]);
        if _equipInfo then
            local _choseEquipInfo = CardEquipment:new({level=_equipInfo.level,number=self.choseItemInfo.number});
            self.equipDiffAttr = CardEquipment:GetDiffProperty2(_equipInfo,_choseEquipInfo);
        else
            self.equipDiffAttr = self.choseItemInfo:GetDeltaProperty();
        end
        self.equipGrid:set_min_index(-#self.equipDiffAttr+1);
        self.equipGrid:set_max_index(0);
        self.equipGrid:reset();
        local attrs = self.choseItemInfo:GetDeltaProperty();
        local str = "";
        for i=1,#attrs do
            local value = attrs[i].value;
            local key = attrs[i].key;
            if value > 0 then
                str = str.."+"..value..attrs[i].showUnit.." "..gs_string_property_name[key].."\n";
            else
                str = str..value..attrs[i].showUnit.." "..gs_string_property_name[key].."\n";
            end
        end
        self.equipAttr:set_text(str);
        self.equipName:set_text(self.choseItemInfo.name);
        self.equipLevel:set_text(string.format("Lv.%s",tostring(self.choseItemInfo.level)))
        self.equipSp:set_texture(self.choseItemInfo.config.small_icon);
        -- self.smallPool:SetIcon(self.equipSp,self.choseItemInfo.number);
        PublicFunc.SetIconFrameSprite(self.equipFrame,self.choseItemInfo.rarity);
        PublicFunc.SetEquipRaritySprite(self.equipLetter,self.choseItemInfo.rarity);
        for i=1,5 do
            if i > self.choseItemInfo.star then
                self.equipStar[i]:set_active(false);
            else
                self.equipStar[i]:set_active(true);
            end
        end
        if self.choseItemInfo.roleid and tonumber(self.choseItemInfo.roleid) ~= 0 then 
            local choseItemInfo = g_dataCenter.package:find_card(1,self.choseItemInfo.roleid);
            -- self.spHuamHead:set_texture(choseItemInfo.config.small_icon);
            self.spHuamHead:SetData(choseItemInfo);
            self.spHuamHead:ShowOnlyPic();
            -- self.EquipAtlas:SetIcon(self.spHuamHead,choseItemInfo.number);
            PublicFunc.SetIconFrameSprite(self.spHuamFrame,choseItemInfo.rarity);
            self.spHuamHead:Show(true);
            -- self.huamHead:set_active(true);
        else
            self.spHuamHead:Hide(false);
            -- self.huamHead:set_active(false);
        end
    else
        self.ui2:set_active(false);
        if self.roleData.index ~= 0 then
            -- self.equip:set_active(true);
            _G[self.showLeft](true);
        else
            -- self.equip:set_active(false);
            _G[self.showLeft](false);
        end
    end
end

function BattleEquipListUI:Show(equip_pos)
    self.choseItemInfo = nil;
    self.equipPos = equip_pos;
    self.selectState = nil;
    if UiBaseClass.Show(self) then
        self.rightUi:set_active(true);
        -- self.btnList:set_active(false);
        _G[self.showRight](false);
        -- self:UpdateEquipmentInfo();
        self:UpdatePackage();
    end
end

function BattleEquipListUI:UpdatePackage(equip_list,selectState)
    self.selectState = selectState or self.selectState;
    local _equipInfo = g_dataCenter.package:find_card(2,self.roleData.equipment[self.equipPos]);
    local index;
    if _equipInfo then
        index = _equipInfo.index;
    end
    if self.equipPos == 6 then
        self.equipShowList = equip_list or PublicFunc.GetEquipment(self.equipPos-1,nil,false,nil,nil,nil,{index});
    else
        self.equipShowList = equip_list or PublicFunc.GetEquipment(self.equipPos,nil,false,nil,nil,nil,{index});
    end
    if #self.equipShowList == 0 then
        self.scrollview:set_active(false);
        self.spNotHaveEquip:set_active(true);
    else
        self.scrollview:set_active(true);
        self.spNotHaveEquip:set_active(false);
        self.equipView:set_min_index(-#self.equipShowList+1);
        self.equipView:set_max_index(0);
        self.equipView:reset();
        self.scrollview:reset_position();
    end
end

function BattleEquipListUI:Hide()
    self.choseItem = nil;
    self.choseItemInfo = nil;
    if UiBaseClass.Hide(self) then
        self.rightUi:set_active(false);
        self.spNotHaveEquip:set_active(false);
        -- self.btnList:set_active(true);
        _G[self.showRight](true);
        self:on_hide_equipment_info();
    end
end

function BattleEquipListUI:on_init_equip_attr(obj,b,real_id)
    local _index = math.abs(real_id)+1;
    local _lab = ngui.find_label(obj,"lab");
    local _arrows = ngui.find_sprite(obj,"sp_arrows");
    local _attr = self.equipDiffAttr[_index];
    local _name = "";
    if _attr then
        local _str = nil;
        local value = _attr.value;
        local key = _attr.key;
        if value > 0 then
            _name = "jiantou6";
            _str = "+"..value.._attr.showUnit.." "..gs_string_property_name[key];
        else
            _name = "jiantou5";
            _str = value.._attr.showUnit.." "..gs_string_property_name[key];
        end
        _arrows:set_sprite_name(_name);
        _lab:set_text(_str);
    end
end

function BattleEquipListUI:on_btn_equip()
    if self.choseItemInfo then
        self.loading:Show()
        --if not Socket.socketServer then return end
        msg_cards.cg_change_equip_on_role(Socket.socketServer,self.roleData.index,self.choseItemInfo.index,self.equipPos);
    end
    if self.backCallback then
        _G[self.backCallback]();
    end
end

function BattleEquipListUI:on_hide_equipment_info()
    if self.ui2 then
        if self.roleData.index ~= 0 then
            -- self.equip:set_active(true);
            _G[self.showLeft](true);
        else
            -- self.equip:set_active(false);
            _G[self.showLeft](false);
        end
        if self.choseItem then
            self.choseItem:ChoseItem(false);
        end
        self.ui2:set_active(false);
    end
end

function BattleEquipListUI:on_seach()
    local filterUI = uiManager:PushUi(EUI.EquipFilterUI)
    filterUI:SetFilterResultCallback(self.bindfunc["UpdatePackage"])
    if self.equipPos == 6 then
        filterUI:SetEquipPositionFilter({self.equipPos-1})
    else
        filterUI:SetEquipPositionFilter({self.equipPos})
    end
    if self.selectState then
        filterUI:SetDefaultState(self.selectState);
    end
    self:on_hide_equipment_info();
end

function BattleEquipListUI:on_close()
    if self.backCallback then
        _G[self.backCallback]();
    end
end

function BattleEquipListUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
	self.rightUi = nil;
    self.selectState = nil;
    self.equipList = nil;
    self.equipView = nil;
    for k,v in pairs(self.equipItem) do
        v:DestroyUi();
    end
    if self.equipSp then
        self.equipSp:Destroy();
        self.equipSp = nil;
    end
    if self.spHuamHead then
        self.spHuamHead:DestroyUi();
        self.spHuamHead = nil;
    end
    self.equipItem = {};
    self.choseItem = nil;
    self.choseItemInfo = nil;
    self.equipShowList = nil;
    self.equipDiffAttr = nil;
end

--------------------  新手引导添加  ---------------------
function BattleEquipListUI:GetEquipItemUi(index)
    for real_id, data in pairs(self.equipItem or {}) do
        if math.abs(real_id)+1 == index then
            return self.equipItem[real_id].ui
        end
    end
end
function BattleEquipListUI:GetEquipItemBtn(index)
    for real_id, data in pairs(self.equipItem or {}) do
        if math.abs(real_id)+1 == index then
            if self.equipItem[real_id].btn then
                return self.equipItem[real_id].btn:get_game_object();
            end
        end
    end
end