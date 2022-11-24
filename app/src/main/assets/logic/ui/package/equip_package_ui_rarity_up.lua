
local _UIText = { 
    [8] = "金币不足,无法升品",
    [9] = "材料不足,无法升品",
    [10] = "请先添加材料",
    [11] = "不足,无法升品",
    [12] = "已达当前最高品级，无法升品",
    [13] = "当前拥有%s",
}

function EquipPackageUI:InitMaterialUI()
    if not self.equipMaterialUI.isInit then
        self.equipMaterialUI.isInit = true        
        --升品材料 
        for i = 1, 4 do 
            local obj = self.normalUi.rarityUp:get_child_by_name("new_small_card_item" .. i)
            self.equipMaterialUI.smallItem[i] = UiSmallItem:new({parent = obj, cardInfo = nil, delay = 400, use_sweep_icon = true})
        end 
        --升品
        self.equipMaterialUI.objGold = self.normalUi.rarityUp:get_child_by_name("sp_gold_right")
        self.equipMaterialUI.lblGold = ngui.find_label(self.equipMaterialUI.objGold, "lab")
        --全部升品
        self.equipMaterialUI.objGoldLeft = self.normalUi.rarityUp:get_child_by_name("sp_gold_left")
        self.equipMaterialUI.lblGoldLeft = ngui.find_label(self.equipMaterialUI.objGoldLeft, "lab")
    end    
end

function EquipPackageUI:InitSpecRarityUI()
    if not self.specRarityUI.isInit then
        self.specRarityUI.isInit = true
        self.specRarityUI.texture1 = ngui.find_texture(self.specicalUi.rarityUp, "txt/sp_token")
        self.specRarityUI.lbl1 = ngui.find_label(self.specicalUi.rarityUp, "txt/lab")
        self.specRarityUI.texture2 = ngui.find_texture(self.specicalUi.rarityUp, "sp_gold_left")
        self.specRarityUI.lbl2 = ngui.find_label(self.specicalUi.rarityUp, "sp_gold_left/lab")

        self.specRarityUI.lblHave = ngui.find_label(self.specicalUi.rarityUp, "txt1")
        self.specRarityUI.lblDesc = ngui.find_label(self.specicalUi.rarityUp, "txt")
        self.specRarityUI.lblGold = ngui.find_label(self.specicalUi.rarityUp, "sp_gold_right/lab")
    end    
end

function EquipPackageUI:gc_equip_rarity_up(result, index, byAll)
    --app.log('====================>00 index = ' .. tostring(index) .. ' byAll = ' .. tostring(byAll))

    if byAll == 1 then
        table.insert(self.serverRarityUpInfo, {index = index, result = result})
    end
    if PublicFunc.GetErrorString(result) == false then
        return
    end

    --全部升品
    if byAll == 1 then
        --所有数据返回, 刷新小红点
        --更新右边界面
        if #self.serverRarityUpInfo == #self.rarityUpEquipIndexList then
            self:UpdateEquipmentByIndex(index, true)
            self:UpdateRightLevelUpPane()
            --app.log('====================>11  index = ' .. tostring(index))
            --todo 弹出升品界面(多个装备)

            local allCardInfo = {}
            for k, v in ipairs(self.equipSmallItemList) do    
                local cardInfo = v:GetCardInfo() 
                for _, _index in pairs(self.rarityUpEquipIndexList) do 
                    if cardInfo.index == _index then
                        table.insert(allCardInfo , cardInfo)
                        break
                    end
                end
            end
            UiEquipRarityUpAllResult.Start(allCardInfo, self.roleData)
            UiEquipRarityUpAllResult.SetFinishCallback(EquipPackageUI.CheckEquipExpert, self)
        else
            self:UpdateEquipmentByIndex(index, false)
            --app.log('====================>22  index = ' .. tostring(index))
        end
    else
        self:UpdateCurrEquipment()
        self:UpdateRightLevelUpPane()

        UiCommonPropertyChangResult.Start(self.lastEquipItem:GetCardInfo(), UiCommonPropertyChangEType.EquipRarityUp, self.roleData, self.oldFightValue)
        UiCommonPropertyChangResult.SetFinishCallback(EquipPackageUI.CheckEquipExpert, self)
    end
end

--[[全部升品金币]]
--[[
    1. 如果任意装备金币都不足, 则显示最小花费的
    2. 依次升品，累加金币
]]
function EquipPackageUI:GetRarityUpAllCostGold()
    local minCost = nil
    local noEnoughGold = true

    self:ForeachNormalEquip(function(cardInfo)
        if cardInfo.level == cardInfo.rarityConfig.level then
            --升品金币
            local cost = cardInfo.rarityConfig.need_gold
            if cost <= PropsEnum.GetValue(IdConfig.Gold) then
                noEnoughGold = false
                return false
            else
                if minCost == nil then
                    minCost = cost
                else
                    if cost < minCost then 
                        minCost = cost
                    end
                end
            end
        end
    end)
    
    if noEnoughGold == true then
        return minCost
    end

    --依次累加  
    local total = 0
    self:ForeachNormalEquip(function(cardInfo)
        if cardInfo.level == cardInfo.rarityConfig.level then  
            local cost = cardInfo.rarityConfig.need_gold
            if total + cost > PropsEnum.GetValue(IdConfig.Gold) then
                return false
            end
            total = total + cost 
        end
    end)
    return total
end

--[[升品]]
function EquipPackageUI:on_rarity_up()
    if self:CanRarityUp() then
    	self.oldFightValue = self.roleData:GetFightValue()
        local cardInfo = self.lastEquipItem:GetCardInfo()
        if cardInfo:IsSpecEquip() then
            UiEquipExpertResult.SaveOldLevel(ENUM.EquipExpertType.SpecLevel, self.roleData)
        else
            UiEquipExpertResult.SaveOldLevel(ENUM.EquipExpertType.Level, self.roleData)
        end
        msg_cards.cg_equip_rarity_up(self.lastEquipItem.cardInfo.index, 0)
    end
end

--[[全部升品]]
function EquipPackageUI:on_rarity_up_all()
    if self:NoramlEquipCanRarityUp() then
        --可以升品的装备列表
        self:SetCanRarityUpEquipInfo()
        self.serverRarityUpInfo = {}

        UiEquipExpertResult.SaveOldLevel(ENUM.EquipExpertType.Level, self.roleData)
        for k, index in ipairs(self.rarityUpEquipIndexList) do
            msg_cards.cg_equip_rarity_up(index, 1)
        end
    end
end

function EquipPackageUI:SetCanRarityUpEquipInfo()    
    self.rarityUpEquipIndexList = {}
    local total = 0
    local materialValue = {}
    local maxRarity = CardEquipment.GetMaxRarity() 

    self:ForeachNormalEquip(function(cardInfo)
        if cardInfo.rarity < maxRarity and cardInfo.level == cardInfo.rarityConfig.level then    
            --金币
            local enoughGold = true
            local cost = cardInfo.rarityConfig.need_gold
            if total + cost > PropsEnum.GetValue(IdConfig.Gold) then
                enoughGold = false
            end
            --升品材料
            local enoughMaterial = true
            if enoughGold then
                for _, v in pairs(cardInfo.rarityConfig.material) do
                    if materialValue[v.number] == nil then
                        materialValue[v.number] = 0
                    end
                    if materialValue[v.number] + v.count > PropsEnum.GetValue(v.number) then
                        enoughMaterial = false
                        break
                    end
                end 
            end
            if enoughGold and enoughMaterial then
                total = total + cost 
                for _, v in pairs(cardInfo.rarityConfig.material) do
                    materialValue[v.number] = materialValue[v.number] + v.count 
                end  
                table.insert(self.rarityUpEquipIndexList, cardInfo.index)
            end
        end
    end)
end

--[[全部升品判断]]
function EquipPackageUI:NoramlEquipCanRarityUp() 
    local maxRarity = CardEquipment.GetMaxRarity()    

    local upToMaxRarity = true
    local allLackMaterial = true
    local enoughGold = false
    local upToRarityPoint = false

    self:ForeachNormalEquip(function(cardInfo)
        if cardInfo.level == cardInfo.rarityConfig.level then
            upToRarityPoint = true
        end 

        if cardInfo.rarity < maxRarity then
            upToMaxRarity = false
        end
        --检查材料
        local enoughMaterail = true
        for _, v in pairs(cardInfo.rarityConfig.material) do
            if v.count > PropsEnum.GetValue(v.number) then
                enoughMaterail = false
                break
            end
        end     
        if enoughMaterail then
            allLackMaterial = false
        end
        --金币
        if cardInfo.rarityConfig.need_gold <= PropsEnum.GetValue(IdConfig.Gold) then
            enoughGold = true
        end
    end)

    if not upToRarityPoint then
        -- app.log('未到升品点！')
        return false
    end
    if upToMaxRarity then
        FloatTip.Float(_UIText[12])
        return false
    end
    if not enoughGold then
        --FloatTip.Float(_UIText[8])
        PublicFunc.GotoExchangeGold()
        return false
    end
    if allLackMaterial then
        FloatTip.Float(_UIText[9])
        return false
    end
    return true
end

function EquipPackageUI:CanRarityUp(__showTip, __cardInfo)
    local showTip = true
    if __showTip ~= nil then
        showTip = __showTip
    end 
    local cardInfo = nil
    if __cardInfo ~= nil then
        cardInfo = __cardInfo
    else
        cardInfo = self.lastEquipItem:GetCardInfo()
    end
    local cardInfo = self.lastEquipItem:GetCardInfo()
    if cardInfo == nil then return false end

    if cardInfo.level ~= cardInfo.rarityConfig.level then
        return false
    end 

    --达最高
    if cardInfo.rarity >= CardEquipment.GetMaxRarity() then
        if showTip then
            FloatTip.Float(_UIText[12])
        end
        return false
    end  
    --gold
    if cardInfo.rarityConfig.need_gold > PropsEnum.GetValue(IdConfig.Gold) then
        if showTip then
            --FloatTip.Float(_UIText[8])
            PublicFunc.GotoExchangeGold()
        end
        return false
    end 
    if cardInfo:IsSpecEquip() then
        --检查二级货币
        local material = cardInfo.rarityConfig.material[1]
        local currCnt = PropsEnum.GetValue(material.number)
        if material.count > currCnt then
            if showTip then 
                --local name = PropsEnum.GetName(material.number)
                --FloatTip.Float(name .._UIText[11])
                self:on_find_way_material({float_value = material.number, string_value = material.count})
            end
            return false
        end
    else        
        --检查材料
        for _, v in pairs(cardInfo.rarityConfig.material) do
            if v.count > PropsEnum.GetValue(v.number) then
                if showTip then
                    --FloatTip.Float(_UIText[9])
                    self:on_find_way_material({float_value = v.number, string_value = v.count})
                end
                return false
            end
        end        
    end
    return true
end