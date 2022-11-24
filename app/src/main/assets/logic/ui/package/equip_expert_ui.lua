
EquipExpertUI = Class("EquipExpertUI", UiBaseClass)

function EquipExpertUI.Start(data)
    if EquipExpertUI.cls == nil then
        EquipExpertUI.cls = EquipExpertUI:new(data)
    end
end

function EquipExpertUI.End()
    if EquipExpertUI.cls then
        EquipExpertUI.cls:DestroyUi()
        EquipExpertUI.cls = nil
    end
end

local _UIText = {
    [1] = "装备升品",
    [2] = "装备进化",
    [3] = "专属升品",
    [4] = "专属进化",
    [5] = "(%s级)",
    [6] = "级",
    [7] = "等级",
}

local _MaxExpertLevelLvl = 20
local _MaxExpertStarLvl = 5

function EquipExpertUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_604_7.assetbundle"
    UiBaseClass.Init(self, data)
end

function EquipExpertUI:InitData(data)
    self.roleData = data
    self.yekaCfg = {
        [1] = {type = ENUM.EquipExpertType.Level, name =  _UIText[1]},
        [2] = {type = ENUM.EquipExpertType.Star, name =  _UIText[2]},
        [3] = {type = ENUM.EquipExpertType.SpecLevel, name =  _UIText[3]},
        [4] = {type = ENUM.EquipExpertType.SpecStar, name =  _UIText[4]},
    }
    self.equipPositionList = {
        ENUM.EEquipPosition.weapon,  ENUM.EEquipPosition.Armor,
        ENUM.EEquipPosition.Trouser, ENUM.EEquipPosition.Boots,
        ENUM.EEquipPosition.Accessories, ENUM.EEquipPosition.Helmet,
    }
    UiBaseClass.InitData(self, data)
end

function EquipExpertUI:Restart(data)
    self.yekaList = {}
    self.currType = ENUM.EquipExpertType.Level

    self.allExpertInfo = {}
    for k, v in pairs(self.yekaCfg) do
        local currLvl = PublicFunc.GetEquipExpertLevel(v.type, self.roleData)
        local nextLvl = currLvl + 1
        local maxLvl = self:GetMaxLvl(v.type)
        if nextLvl > maxLvl then
            nextLvl = maxLvl
        end
        self.allExpertInfo[v.type] = {
            currLvl = currLvl,
            nextLvl = nextLvl,
            isMax = (currLvl == maxLvl),
        }
    end
    self.equipItemList = {}
    if UiBaseClass.Restart(self, data) then
    end
end

function EquipExpertUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_select_tab"] = Utility.bind_callback(self, self.on_select_tab)
end

function EquipExpertUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

function EquipExpertUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function EquipExpertUI:DestroyUi()
    if self.yekaList then
        self.yekaList = nil
    end
    for k,v in pairs(self.equipItemList) do
        if v.smallItem then
            v.smallItem:DestroyUi()
            v.smallItem = nil
        end
    end
    if self.equipItemList then
        self.equipItemList = nil
    end
    UiBaseClass.DestroyUi(self)
end

function EquipExpertUI:on_close()
    EquipExpertUI.End()
end

function EquipExpertUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("equip_expert")

    local aniPath = "center_other/animation/"
    local contPath = aniPath .. "content/"

    local btnClose = ngui.find_button(self.ui, aniPath .. "content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    local gridTab = ngui.find_grid(self.ui, contPath .. "grid")
    local objGridTab = gridTab:get_game_object()
    local cloneYeka = self.ui:get_child_by_name(contPath .. "grid/yeka1")
    cloneYeka:set_active(false)

    for k, v in ipairs(self.yekaCfg) do
        local item = {}
        item.obj = cloneYeka:clone()
        item.obj:set_parent(objGridTab)
        item.obj:set_name("tab_" .. k)
        item.obj:set_active(true)
        item.toggle = ngui.find_toggle(item.obj, item.obj:get_name())

        item.labNameFocus = ngui.find_label(item.obj, "lab")
        item.lblNameNormal = ngui.find_label(item.obj, "lab_hui")

        local _name = string.format(v.name .. _UIText[5], self.allExpertInfo[v.type].currLvl)
        item.labNameFocus:set_text(_name)
        item.lblNameNormal:set_text(_name)

        local btnTab = ngui.find_button(item.obj, item.obj:get_name())
        btnTab:reset_on_click()
        btnTab:set_event_value("", v.type)
        btnTab:set_on_click(self.bindfunc["on_select_tab"], "MyButton.Flag")

        self.yekaList[k] = item
    end
    gridTab:reposition_now()


    local gridCard = ngui.find_grid(self.ui, contPath .. "grid_card")
    local objGridCard = gridCard:get_game_object()
    local cloneItem = self.ui:get_child_by_name(contPath .. "grid_card/yeka1")
    cloneItem:set_active(false)
    for i = 1, 4 do
        local item = {}
        item.obj = cloneItem:clone()
        item.obj:set_parent(objGridCard)
        item.obj:set_name("card_" .. i)

        item.spBg = ngui.find_sprite(item.obj, "sp_di")
        item.objSmallItem = item.obj:get_child_by_name("new_small_card_item")
        item.smallItem = UiSmallItem:new({parent = item.objSmallItem, cardInfo = nil, delay = -1})

        item.spTitle = ngui.find_sprite(item.objSmallItem, "sp_title")
        item.lblName = ngui.find_label(item.obj, "lab_name")

        item.pro = ngui.find_progress_bar(item.obj, "pro_di")
        item.lblPro = ngui.find_label(item.obj, "pro_di/lab_num")
        item.objFullFx = item.obj:get_child_by_name("pro_di/fx_ui_604_7_manji")

        self.equipItemList[i] = item
    end
    gridCard:reposition_now()

    self.levelItem = {
        lblName = ngui.find_label(self.ui, contPath .. "lab_nature"),
        lblCurrLv = ngui.find_label(self.ui, contPath .. "lab_nature/lab_num"),
        spArrow = ngui.find_sprite(self.ui, contPath .. "lab_nature/sp"),
        lblToLv = ngui.find_label(self.ui, contPath .. "lab_nature/lab"),
    }

    local _properName = {"cont_life", "cont_attack", "cont_defense"}
    self.upPropertyUi = {}
    for k, v in pairs(_properName) do
        local temp = {}
        temp.obj = self.ui:get_child_by_name(contPath .. "cont_nature1/" .. v)
        temp.lblName = ngui.find_label(temp.obj, "txt")

        temp.lblNum1 = ngui.find_label(temp.obj, "content/lab_num1")
        temp.lblNum2 = ngui.find_label(temp.obj, "content/lab_num2")
        self.upPropertyUi[k] = temp
    end

    self.topPropertyUi = {}
    for i = 1, 3 do
        local temp = {}
        temp.obj = self.ui:get_child_by_name(contPath .. "cont_nature2/grid_nature/nature" .. i)
        temp.lblName = ngui.find_label(temp.obj, "txt")

        temp.lblNum = ngui.find_label(temp.obj, "content/lab_num")
        self.topPropertyUi[i] = temp
    end
    self.upUi = self.ui:get_child_by_name(contPath .. "cont_nature1")
    self.topUi = self.ui:get_child_by_name(contPath .. "cont_nature2")
    self.upUi:set_active(false)
    self.topUi:set_active(false)

    --local spTop = ngui.find_sprite(self.topUi, "sp_art_font")
    --spTop:set_active(false)
    self.gridTop = ngui.find_grid(self.topUi, "grid_nature")

    self:SelectdTab()
    self:UpdateUI()
end

function EquipExpertUI:SelectdTab()
    for k, v in ipairs(self.yekaList) do
        if v.toggle then
            v.toggle:set_value(self.yekaCfg[k].type == self.currType)
        end
    end
end

function EquipExpertUI:on_select_tab(t)
    if t.float_value ~= self.currType then
        self.currType= t.float_value
        self:UpdateUI()
    end
end

function EquipExpertUI:UpdateUI()

    local _info = self.allExpertInfo[self.currType]

    if self.currType == ENUM.EquipExpertType.SpecLevel or self.currType == ENUM.EquipExpertType.SpecStar then
        for k, v in pairs(self.equipItemList) do
            local pos = self.equipPositionList[k + 4]
            self:UpdateEqupItem(v, pos, true, _info.isMax)
        end

    else
        for k, v in pairs(self.equipItemList) do
            local pos = self.equipPositionList[k]
            self:UpdateEqupItem(v, pos, false, _info.isMax)
        end
    end

    self.levelItem.lblName:set_text(self:GetExpertName() .. _UIText[7])
    self.levelItem.spArrow:set_active(not _info.isMax)
    self.levelItem.lblToLv:set_active(not _info.isMax)

    if _info.isMax then
        self.levelItem.lblCurrLv:set_text(self:GetMaxLvl(self.currType) .. _UIText[6])
    else
        self.levelItem.lblCurrLv:set_text(_info.currLvl .. _UIText[6])
        self.levelItem.lblToLv:set_text(_info.nextLvl .. _UIText[6])
    end

    self.upUi:set_active(false)
    self.topUi:set_active(false)

    local currProp = PublicFunc.GetEquipExpertProps(self.roleData.default_rarity, _info.currLvl, self.currType)
    if not _info.isMax then
        self.upUi:set_active(true)
        local upProp = PublicFunc.GetEquipExpertProps(self.roleData.default_rarity, _info.nextLvl, self.currType)
        for k, v in pairs(self.upPropertyUi) do
            local pp = upProp[k]
            if pp then
                v.obj:set_active(true)
                v.lblName:set_text(PublicFunc.GetHeroPropertyName(pp.key))
                if _info.currLvl == 0 then
                    v.lblNum1:set_text("0")
                else
                    v.lblNum1:set_text(tostring(currProp[k].value))
                end
                v.lblNum2:set_text(tostring(pp.value))
            else
                v.obj:set_active(false)
            end
        end

    else
        self.topUi:set_active(true)
        for k, v in pairs(self.topPropertyUi) do
            local pp = currProp[k]
            if pp then
                v.obj:set_active(true)
                v.lblName:set_text(PublicFunc.GetHeroPropertyName(pp.key))
                v.lblNum:set_text(tostring(pp.value))
            else
                v.obj:set_active(false)
            end
        end
        self.gridTop:reposition_now()
    end
end

function EquipExpertUI:UpdateEqupItem(v, pos, showHuiZhang, isMax)
    if pos == nil then
        v.obj:set_active(false)
        return
    else
        v.obj:set_active(true)
    end
    local dataid = self.roleData.equipment[pos]
    if dataid ~= '0' and dataid ~= 0 then
        local cardEquip = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, dataid);
        v.smallItem:SetData(cardEquip)
        v.lblName:set_text(cardEquip.name)

        if showHuiZhang then
            v.spTitle:set_active(true)
            v.spTitle:set_sprite_name(self:GetSpecEquipHuiZhang(cardEquip.rarity))
        else
            v.spTitle:set_active(false)
        end

        local _vv = cardEquip.rarity
        local nextLvl = self.allExpertInfo[self.currType].nextLvl
        if self.currType == ENUM.EquipExpertType.Star or self.currType == ENUM.EquipExpertType.SpecStar then
            _vv = cardEquip.star
        end
        v.lblPro:set_text(string.format("[974D04FF]%s[-][7463C9FF]/%s[-]", _vv, nextLvl))
        v.pro:set_value(_vv / nextLvl)

        v.objFullFx:set_active(isMax)
    else
        app.log("equip dataid = '0'")
    end
end

function EquipExpertUI:GetMaxLvl(type)
    if type == ENUM.EquipExpertType.Star or type == ENUM.EquipExpertType.SpecStar then
        return _MaxExpertStarLvl
    end
    return _MaxExpertLevelLvl
end

function EquipExpertUI:GetExpertName()
    for k, v in pairs(self.yekaCfg) do
        if v.type == self.currType then
            return v.name
        end
    end
    return ''
end

local __huiZhangSpriteName = {
    [ENUM.EEquipRarity.White] = "zb_daojuhuizhang1",

    [ENUM.EEquipRarity.Green] = "zb_daojuhuizhang3",
    [ENUM.EEquipRarity.Green1] = "zb_daojuhuizhang3",
    [ENUM.EEquipRarity.Green2] = "zb_daojuhuizhang3",

    [ENUM.EEquipRarity.Blue] = "zb_daojuhuizhang2",
    [ENUM.EEquipRarity.Blue1] = "zb_daojuhuizhang2",
    [ENUM.EEquipRarity.Blue2] = "zb_daojuhuizhang2",
    [ENUM.EEquipRarity.Blue3] = "zb_daojuhuizhang2",

    [ENUM.EEquipRarity.Purple] = "zb_daojuhuizhang4",
    [ENUM.EEquipRarity.Purple1] = "zb_daojuhuizhang4",
    [ENUM.EEquipRarity.Purple2] = "zb_daojuhuizhang4",
    [ENUM.EEquipRarity.Purple3] = "zb_daojuhuizhang4",
    [ENUM.EEquipRarity.Purple4] = "zb_daojuhuizhang4",

    [ENUM.EEquipRarity.Orange] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange1] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange2] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange3] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange4] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange5] = "zb_daojuhuizhang5",

    [ENUM.EEquipRarity.Red] = "zb_daojuhuizhang6",
    [ENUM.EEquipRarity.Red1] = "zb_daojuhuizhang6",
}
function EquipExpertUI:GetSpecEquipHuiZhang(rarity)
    return __huiZhangSpriteName[rarity]
end