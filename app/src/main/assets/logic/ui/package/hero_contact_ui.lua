HeroContactUI = Class("HeroContactUI", UiBaseClass)

local _UIText = {
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

function HeroContactUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_9.assetbundle"
	UiBaseClass.Init(self, data);
end

function HeroContactUI:InitData(data)
    UiBaseClass.InitData(self, data)
    -- self.parent = data.parent
    self.roleData = data.info
    self.isPlayer = data.isPlayer 
    self.configData = self:GetConfigData()
    self.wrapContentMemeber = {}
end

function HeroContactUI:DestroyUi()
    for _, item in pairs(self.wrapContentMemeber) do
        local cont = nil
        for i = 1, 5 do
            cont = item.contHero[i]
            if cont then
                if cont.smallCard then
                    cont.smallCard:DestroyUi()
                    cont.smallCard = nil
                end                             
            end
            cont = item.contEquip[i]
            if cont then
                if cont.smallItem then
                    cont.smallItem:DestroyUi()
                    cont.smallItem = nil
                end                             
            end
        end        
    end

    UiBaseClass.DestroyUi(self);    
end

function HeroContactUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.Hide)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_click_hero"] = Utility.bind_callback(self, self.on_click_hero)   
end

--注册消息分发回调函数
function HeroContactUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function HeroContactUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function HeroContactUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_hero_contact')  

    local btnClose = ngui.find_button(self.ui, "centre_other/animation/content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])

    local path = "centre_other/animation/content/"

    self.contactNameUI = {}
    for i = 1, 6 do 
        self.contactNameUI[i] = {
            sp = ngui.find_sprite(self.ui, path .. "sp_bk/sp_di" .. i) ,
            lbl = ngui.find_label(self.ui, path .. "sp_bk/sp_di" .. i .. "/lab") ,
        }   
        ngui.find_label(self.ui, path .. "sp_bk/sp_di" .. i .. "/lab")        
    end

    self.scrollView = ngui.find_scroll_view(self.ui, path .. "scroll_view/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path .. "scroll_view/panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self:UpdateUi();
end

function HeroContactUI:UpdateUi()
    if not self.roleData then return end 

    for k, v in ipairs(self.contactNameUI) do
        local data = self.configData[k]
        if data then
            if data.isActive then
                v.sp:set_sprite_name("yx_lianxie_di2")
                v.lbl:set_text('[FFE578]' .. data.name .. '[-]')
            else
                v.sp:set_sprite_name("yx_lianxie_di1")
                v.lbl:set_text('[A2A2E2]' .. data.name .. '[-]')
            end
            v.sp:set_active(true)  
        else
            v.sp:set_active(false)
        end
    end
    self.wrapContent:set_min_index(- #self.configData + 1);
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position()  
end

function HeroContactUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1  

    local data = self.configData[index]
    if data == nil then return end
    
    if self.wrapContentMemeber[row] == nil then
        local item = {}
        item.lblName = ngui.find_label(obj, "sp_title/lab_name")
        item.lblName1 = ngui.find_label(obj, "sp_title/lab_name1")
        item.lblProp = ngui.find_label(obj, "txt_attack")
        item.lblProp1 = ngui.find_label(obj, "txt_attack/lab_attack")

        item.lblEqupSkill = ngui.find_label(obj, "lan_equip_name")

        item.spBg = ngui.find_sprite(obj, "sp_di")
        item.spHead = ngui.find_sprite(obj, "sp_title")

        item.objContHero = obj:get_child_by_name("cont_hero")
        item.objContEquip = obj:get_child_by_name("cont_equip")
        item.contHero = {}
        item.contEquip = {}

        for i = 1, 5 do
            local contItem = {}
            contItem.objItem = obj:get_child_by_name("cont_hero/big_card_item_80" .. i)
            contItem.spAdd = nil
            if i ~= 1 then
                contItem.spAdd = ngui.find_sprite(obj, "cont_hero/sp_add" .. (i - 1))
            end
            item.contHero[i] = contItem
            --------------------------->>
            contItem = {}
            contItem.objItem = obj:get_child_by_name("cont_equip/new_small_card_item" .. i)
            contItem.spAdd = nil
            if i ~= 1 then
                contItem.spAdd = ngui.find_sprite(obj, "cont_equip/sp_add" .. (i - 1))
            end
            item.contEquip[i] = contItem
        end
        item.equipDesc = ngui.find_label(obj, "sp_title/lab")
        self.wrapContentMemeber[row] = item
    end

    local item = self.wrapContentMemeber[row]
    PublicFunc.SetItemBorderContent(item.spBg, data.isActive)

    PublicFunc.SetSinkText(data.name, item.lblName, item.lblName1)
    item.lblEqupSkill:set_active(data.desc2 ~= '')
    
    if data.isActive then
        PublicFunc.SetUILabelWhite(item.lblName)
        PublicFunc.SetUILabelWhite(item.lblName1)

        PublicFunc.SetUILabelWhite(item.lblProp)
        item.lblProp:set_text(data.desc)

        PublicFunc.SetUILabelWhite(item.lblProp1)
        item.lblProp1:set_text("[00F6FF]" .. data.desc1 .. '[-]')

        PublicFunc.SetUILabelWhite(item.lblEqupSkill)
        item.lblEqupSkill:set_text("[00F6FF]" .. data.desc2 .. '[-]')

        PublicFunc.SetUILabelWhite(item.equipDesc)

        PublicFunc.SetUISpriteWhite(item.spHead)
        PublicFunc.SetUISpriteWhite(item.spBg)
        item.lblName:set_gradient_bottom(213/255, 145/255, 247/255, 1)
        item.lblName1:set_gradient_bottom(213/255, 145/255, 247/255, 1)
    else
        PublicFunc.SetUILabelGray(item.lblName)
        PublicFunc.SetUILabelGray(item.lblName1)

        PublicFunc.SetUILabelGray(item.lblProp)
        item.lblProp:set_text(data.desc)

        PublicFunc.SetUILabelGray(item.lblProp1)
        item.lblProp1:set_text(data.desc1)

        PublicFunc.SetUILabelGray(item.lblEqupSkill)
        item.lblEqupSkill:set_text(data.desc2)

        PublicFunc.SetUILabelGray(item.equipDesc)

        PublicFunc.SetUISpriteGray(item.spHead)
        PublicFunc.SetUISpriteGray(item.spBg)
        item.lblName:set_gradient_bottom(1, 1, 1, 1)
        item.lblName1:set_gradient_bottom(1, 1, 1, 1)
    end


    local __cont = nil
    local __cards = nil
    item.objContHero:set_active(false)
    item.objContEquip:set_active(false)
    if data.isHero then
        __cont = item.contHero
        __cards = data.heroCards
        item.objContHero:set_active(true)        
    else
        __cont = item.contEquip
        __cards = data.equipCards
        item.objContEquip:set_active(true)  
    end

    for i = 1, 5 do
        local card = __cards[i]
        local contItem = __cont[i]       
        if card then
            contItem.objItem:set_active(true)
            if contItem.spAdd then
                contItem.spAdd:set_active(true)
                if data.isActive then
                    PublicFunc.SetUISpriteWhite(contItem.spAdd)
                else
                    PublicFunc.SetUISpriteGray(contItem.spAdd)
                end
            end
            self:SetIconInfo(contItem, data.isHero, card)
        else
            contItem.objItem:set_active(false)
            if contItem.spAdd then
                contItem.spAdd:set_active(false)
            end
        end
    end 
    
    item.equipDesc:set_text(data.equipDesc)   
end

function HeroContactUI:on_click_hero(obj, cardInfo, callParam)
    if callParam == -1 then
        return
    end 
    local data = {}
    data.item_id = cardInfo.config.hero_soul_item_id
    data.number = cardInfo.config.get_soul
    AcquiringWayUi.Start(data)
end

function HeroContactUI:SetIconInfo(contItem, isHero, card) 
    if isHero then
        if contItem.smallCard == nil then
            contItem.smallCard = SmallCardUi:new(
            {
                parent = contItem.objItem,
                stypes = {SmallCardUi.SType.Texture, SmallCardUi.SType.Rarity, SmallCardUi.SType.Star}	
            })
            contItem.smallCard:SetCallback(self.bindfunc["on_click_hero"])
        end
        contItem.smallCard:SetData(card.cardData)
        contItem.smallCard:SetGray(not card.active)
        if not card.active then
            contItem.smallCard:SetParam(card.cardData.number)
        else
            contItem.smallCard:SetParam(-1)
        end
    else
        if contItem.smallItem == nil then    
            contItem.smallItem = UiSmallItem:new(
            {
                parent = contItem.objItem, 
                cardInfo = nil, delay = -1,
            })
        end
        contItem.smallItem:SetData(card.cardData)
        contItem.smallItem:SetGray(not card.active)
    end
end

function HeroContactUI:GetConfigData()
    local contactConfig = ConfigManager.Get(EConfigIndex.t_role_contact, self.roleData.default_rarity)
    local retData = {}
    if contactConfig == nil then
        return retData        
    end
    --拥有角色信息
    local info = self.roleData:GetHeroDefaultRarityCardInfo()
    for _, v in ipairs(contactConfig) do 
        local isActive = true
        local _heroCards = {}
        local _equipCards = {}
        local _equipDesc = ""

        if v.contact_type == ENUM.ContactType.Hero then            
            if v.contact_role ~= 0 then
                for _, number in pairs(v.contact_role) do
                    if info[number] ~= nil then
                        table.insert(_heroCards, {active = true, cardData = info[number]})
                    else
                        table.insert(_heroCards, {
                            active = false, 
                            cardData = CardHuman:new({number = number, isNotCalProperty = true})
                        })
                        isActive = false
                    end
                end
            end
        else
            if v.equip_number ~= 0 then
                local equipConfig = ConfigManager.Get(EConfigIndex.t_equipment, v.equip_number)
                --获取相应的装备
                local dataid = self.roleData.equipment[equipConfig.position]
                if tonumber(dataid) ~= 0 then
                    local card = self.roleData.dataSource:find_card(ENUM.EPackageType.Equipment, dataid)
                    if card then
                        if card.star >= equipConfig.star then
                            table.insert(_equipCards, {active = true, cardData = card})
                        else
                            table.insert(_equipCards, {active = false, cardData = card})
                            isActive = false
                        end
                        _equipDesc = self:GetEquipDesc(card, equipConfig, isActive)
                    end
                end
            end
        end
        local _isHero = v.contact_type == ENUM.ContactType.Hero
        local _name = self:GetStrWithColor(isActive, v.name)
        local _desc, _desc1, _desc2 = self:GetPropDesc(isActive, v)
       
        table.insert(retData, {
            isActive = isActive,
            name = _name,
            desc = _desc, 
            desc1 = _desc1, 
            desc2 = _desc2,
            equipDesc = _equipDesc,
            isHero = _isHero,
            heroCards = _heroCards,
            equipCards = _equipCards,
        })
    end
    return retData 
end

function HeroContactUI:GetPropDesc(isActive, config)
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
        local srcNumber = self.roleData.config.spe_skill[config.skill_index][1]
        local destNumber = config.skill_number
        if srcNumber and destNumber and srcNumber > 0 and destNumber > 0 then
            local srcSkillConfig = ConfigManager.Get(EConfigIndex.t_skill_info, srcNumber)
            local destSkillConfig = ConfigManager.Get(EConfigIndex.t_skill_info, destNumber)
            desc2 = string.format(_UIText[5], tostring(srcSkillConfig.name), tostring(destSkillConfig.name))
        end 
    end
    return desc, desc1, desc2
end

function HeroContactUI:GetEquipDesc(equipCard, equipConfig, isActive)
    local srcConfig = ConfigManager.Get(EConfigIndex.t_equipment, equipCard.default_rarity)
    --类型名称
    local srcStr = self:GetStrWithColor(isActive, _EquipPosName[srcConfig.position])
    local destStr = self:GetStrWithColor(isActive, equipConfig.star .. _UIText[7])
    return string.format(_UIText[6], tostring(srcStr), tostring(destStr))
end

function HeroContactUI:GetStrWithColor(isActive, str, isDesc)
    return str
    --[[if isActive then
        if isDesc then
            return PublicFunc.GetColorText(str, "orange_yellow")
        end
        return PublicFunc.GetColorText(str, "green")
    else
        return PublicFunc.GetColorText(str, "gray")
    end]]
end

function HeroContactUI:SetInfo(roleData, isPlayer)    
    self.roleData = roleData 
    self.isPlayer = isPlayer
    self.configData = self:GetConfigData()
    self:UpdateUi();
end

function HeroContactUI:Hide()
    app.log("HeroContactUI:Hide")
   
    UiBaseClass.Hide(self)
end