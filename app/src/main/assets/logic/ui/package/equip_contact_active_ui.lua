EquipContactActiveUI = Class("EquipContactActiveUI", UiBaseClass)

function EquipContactActiveUI.Start(data, roleData)
    if EquipContactActiveUI.cls == nil then
        EquipContactActiveUI.roleData = roleData
        EquipContactActiveUI.cls = EquipContactActiveUI:new(data);
	end
end

function EquipContactActiveUI.End()
    if EquipContactActiveUI.cls then
        --装备达人
        UiEquipExpertResult.Start(EquipContactActiveUI.roleData)
        EquipContactActiveUI.cls:DestroyUi()
        EquipContactActiveUI.cls = nil
    end
end

function EquipContactActiveUI.GetActiveEquipContactInfo(cardInfo, position)
    local contactConfig = ConfigManager.Get(EConfigIndex.t_role_contact, cardInfo.default_rarity)
    local retData = {}
    if contactConfig == nil then
        return retData
    end
    for _, v in ipairs(contactConfig) do
        if v.contact_type ~= ENUM.ContactType.Hero then
            if v.equip_number ~= 0 then
                local equipConfig = ConfigManager.Get(EConfigIndex.t_equipment, v.equip_number)
                --获取相应的装备
                if position == equipConfig.position then
                    local dataid = cardInfo.equipment[position]
                    if tonumber(dataid) ~= 0 then
                        local card = cardInfo.dataSource:find_card(ENUM.EPackageType.Equipment, dataid)
                        if card then
                            if card.star == equipConfig.star then
                                table.insert(retData, {config = v, card = card, equipConfig = equipConfig})
                            end
                        end
                    end
                end
            end
        end
    end
    return retData
end

----------------------------------------------------------------------------------


local _UIText = {
    [1] = "你激活了%s条连协",
    [2] = "生命增加",
    [3] = "攻击增加",
    [4] = "防御增加",

    [5] = "%s替换为%s",
    [6] = "将%s升星到%s",
    [7] = "星",

    [8] = "徽章",  --"帽子",
    [9] = "衣服",
    [10] = "裤子",
    [11] = "鞋子",
    [12] = "戒指", -- "饰品"
    [13] = "武器",
}

local _EquipPosName = {
    [ENUM.EEquipPosition.Helmet] = _UIText[8],
    [ENUM.EEquipPosition.Armor] = _UIText[9],
    [ENUM.EEquipPosition.Trouser] = _UIText[10],
    [ENUM.EEquipPosition.Boots] = _UIText[11],
    [ENUM.EEquipPosition.Accessories] = _UIText[12],
    [ENUM.EEquipPosition.weapon] = _UIText[13],
}

function EquipContactActiveUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_8.assetbundle"
	UiBaseClass.Init(self, data);
end

function EquipContactActiveUI:InitData(data)
    UiBaseClass.InitData(self, data)
    self.wrapContentMember = {}
    self.configData = data
end

function EquipContactActiveUI:DestroyUi()
    for _, item in pairs(self.wrapContentMember) do
        for i = 1, 5 do
            local contItem = item.cont[i]
            if contItem and contItem.smallItem then
                contItem.smallItem:DestroyUi()
                contItem.smallItem = nil
            end
        end        
    end
    UiBaseClass.DestroyUi(self);
end

function EquipContactActiveUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item); 
end

function EquipContactActiveUI:InitUI(obj)
    AudioManager.PlayUiAudio(81200044)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_equip_contact_active')

    local path = "centre_other/animation/"
    local btnClose = ngui.find_button(self.ui, path .. "content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    self.lblDesc = ngui.find_label(self.ui, path .. "content/sp_bk/lab_num")
    self.scrollView = ngui.find_scroll_view(self.ui, path .. "content/scroll_view/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path .. "content/scroll_view/panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self:UpdateUi();
end

function EquipContactActiveUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1  
    local data = self.configData[index]    
    if data == nil then return end

    if self.wrapContentMember[row] == nil then
        local item = {}
        item.lblName = ngui.find_label(obj, "sp_title/lab_name")
        item.lblName1 = ngui.find_label(obj, "sp_title/lab_name1")
        item.lblProp = ngui.find_label(obj, "txt_attack")
        item.lblProp1 = ngui.find_label(obj, "txt_attack/lab_attack")
        item.lblEqupSkill = ngui.find_label(obj, "lan_equip_name")
        item.equipDesc = ngui.find_label(obj, "sp_title/lab")

        item.cont = {}
        for i = 1, 5 do
            local contItem = {}
            contItem.objItem = obj:get_child_by_name("cont_hero/big_card_item_80" .. i)
            contItem.smallItem = nil
            contItem.spAdd = nil
            if i ~= 1 then
                contItem.spAdd = ngui.find_sprite(obj, "cont_hero/sp_add" .. (i - 1))
            end
            item.cont[i] = contItem
        end
        self.wrapContentMember[row] = item
    end

    local item = self.wrapContentMember[row]
    PublicFunc.SetSinkText(data.config.name, item.lblName, item.lblName1)

    local desc, desc1, desc2 = self:GetPropDesc(data.config)
    item.lblProp:set_text(desc)
    item.lblProp1:set_text(desc1)
    item.lblEqupSkill:set_active(data.desc2 ~= '')
    item.lblEqupSkill:set_text(desc2)

    local _equipDesc = self:GetEquipDesc(data.card, data.equipConfig)
    item.equipDesc:set_text(_equipDesc)

    for i = 1, 5 do
       local contItem = item.cont[i]
       if i == 1 then
            contItem.objItem:set_active(true)
            if contItem.spAdd then
                contItem.spAdd:set_active(true)
            end
            --挂载
            if contItem.smallItem == nil then
                contItem.smallItem = UiSmallItem:new(
                {
                    parent = contItem.objItem,
                    cardInfo = nil, delay = -1,
                })
            end
            contItem.smallItem:SetData(data.card)
            
       else
            contItem.objItem:set_active(false)
            if contItem.spAdd then
                contItem.spAdd:set_active(false)
            end
       end
    end    
end

function EquipContactActiveUI:GetPropDesc(config)
    local desc = ""
    local desc1 = ""
    local desc2 = ""

    if config.hp_per ~= 0 then
        desc = _UIText[2]
        desc1 = config.hp_per/100 .. "%"
    elseif config.attack_per ~= 0 then
        desc = _UIText[3]
        desc1 = config.attack_per/100 .. "%"
    elseif config.def_per ~= 0 then
        desc = _UIText[4]
        desc1 = config.def_per/100 .. "%"
        --装备技能
    else
        local srcNumber = EquipContactActiveUI.roleData.config.spe_skill[config.skill_index][1]
        local destNumber = config.skill_number
        if srcNumber and destNumber and srcNumber > 0 and destNumber > 0 then
            local srcSkillConfig = ConfigManager.Get(EConfigIndex.t_skill_info, srcNumber)
            local destSkillConfig = ConfigManager.Get(EConfigIndex.t_skill_info, destNumber)
            desc2 = string.format(_UIText[5], tostring(srcSkillConfig.name), tostring(destSkillConfig.name))
        end
    end
    return desc, desc1, desc2
end

function EquipContactActiveUI:GetEquipDesc(equipCard, equipConfig)
    local srcConfig = ConfigManager.Get(EConfigIndex.t_equipment, equipCard.default_rarity)
    --类型名称
    local srcStr = _EquipPosName[srcConfig.position]
    local destStr = equipConfig.star .. _UIText[7]
    return string.format(_UIText[6], tostring(srcStr), tostring(destStr))
end

function EquipContactActiveUI:UpdateUi()
    local initData = self:GetInitData()
    local count = #self.configData
    --self.lblDesc:set_text(string.format(_UIText[1], count))   
    self.lblDesc:set_text(tostring(count))

    self.wrapContent:set_min_index(- count + 1);
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position() 
end

function EquipContactActiveUI:on_close(t)
    EquipContactActiveUI.End()
end