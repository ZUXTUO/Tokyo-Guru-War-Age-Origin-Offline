
local _UIText = {    
    [1] = "一键升级可快速提升装备等级",
    [2] = "等级:",
    [3] = "生命值:",
    [4] = "防御:",
    [5] = "攻击:",
    [6] = "已达当前最高等级，无法升级",
    [7] = "金币不足,无法升级",
    [8] = "金币不足,无法升品",
    [9] = "材料不足,无法升品",
    [10] = "请先添加材料",
    [11] = "不足,无法升品",
    [12] = "已达当前最高品级，无法升品",
    [13] = "拥有%s",
}

function EquipPackageUI:InitSpecMaterialUI()
    if not self.equipSpecMaterialUI.isInit then
        self.equipSpecMaterialUI.isInit = true        
        --升品材料 "
        for i = 1, 4 do 
            local obj = self.specicalUi.levelUp:get_child_by_name("new_small_card_item" .. i)
            self.equipSpecMaterialUI.smallItem[i] = UiSmallItem:new({parent = obj, cardInfo = nil, delay = 400}) 
        end 
        --特殊升级
        self.equipSpecMaterialUI.objGold = self.specicalUi.levelUp:get_child_by_name("cont1/sp_gold_right")
        self.equipSpecMaterialUI.lblGold = ngui.find_label(self.equipSpecMaterialUI.objGold, "lab")
        self.equipSpecMaterialUI.objGold:set_active(false)

        self.equipSpecMaterialUI.objGold2 = self.specicalUi.levelUp:get_child_by_name("cont2/sp_gold_right")
        self.equipSpecMaterialUI.lblGold2 = ngui.find_label(self.equipSpecMaterialUI.objGold2, "lab")
        self.equipSpecMaterialUI.objGold2:set_active(false)
    end
end

function EquipPackageUI:InitProgressUI()
    if not self.expProgressUI.isInit then
        self.expProgressUI.isInit = true        
        local pathCont1 = "centre_other/animation/right_content/cont1/"
        self.expProgressUI.pro1 = ngui.find_progress_bar(self.ui, pathCont1 .. "cont_tongyong/txt_exp/pro_di")
        self.expProgressUI.pro2 = ngui.find_progress_bar(self.ui, pathCont1 .. "cont_tongyong/txt_exp/pro_di2")

        self.expProgressUI.fxPro1 = self.ui:get_child_by_name(pathCont1 .. "cont_tongyong/txt_exp/pro_di/fx_ui_602_level_up")
        self.expProgressUI.fxPro1:set_active(false)
        self.expProgressUI.lbl = ngui.find_label(self.ui, pathCont1 .. "cont_tongyong/txt_exp/lab_num")
    end 
end

function EquipPackageUI:ForeachNormalEquip(func)
	for k, v in ipairs(self.equipSmallItemList) do    
        local cardInfo = v:GetCardInfo()   
        if not cardInfo:IsSpecEquip() then
            if func(cardInfo, v) == false then
                break
            end
        end
    end
end

function EquipPackageUI:RemoveLevelUpEquipIndex(index)
    for i = #self.levelUpEquipIndexList, 1, -1 do
        if self.levelUpEquipIndexList[i] == index then
            table.remove(self.levelUpEquipIndexList, i)
            break
        end
    end
end

function EquipPackageUI:gc_special_equip_level_up_fast()
    self:UpdateCurrEquipment()
    self:UpdateRightLevelUpPane()
end

function EquipPackageUI:gc_equip_level_up(result, byfast, level, index, byAll)
    --app.log('====================>00 index = ' .. tostring(index) .. ' byAll = ' .. tostring(byAll))

    --出错也删除数据, 确保下面逻辑
    if byAll == 1 then
        self:RemoveLevelUpEquipIndex(index)
    end
    if PublicFunc.GetErrorString(result) == false then
        return
    end

    --全部升级
    if byAll == 1 then
        --所有数据返回, 刷新小红点
        --更新右边界面
        if #self.levelUpEquipIndexList == 0 then
            self:UpdateEquipmentByIndex(index, true)
            self:UpdateRightLevelUpPane()
            self.fxLevel:set_active(false)
            self.fxLevel:set_active(true)
            --app.log('====================>11  index = ' .. tostring(index))
        else
            self:UpdateEquipmentByIndex(index, false)
            --app.log('====================>22  index = ' .. tostring(index))
        end
        self:ForeachNormalEquip(function(cardInfo, item)
            if cardInfo.index == index then
                local objFx = item:GetExtFx()
                if objFx then
                    objFx:set_active(false)
                    objFx:set_active(true)
                end
                return false
            end
        end)
        AudioManager.PlayUiAudio(81200117)
    else
        --特殊升级
        self.needPlayProAnimation = (byfast == 0)
        --右侧装备动画
        if not self.needPlayProAnimation then
            self:PlayLevelAnimation()
        end

        self:UpdateCurrEquipment()
        self:UpdateRightLevelUpPane()
    end
end

function EquipPackageUI:PlayLevelAnimation()
    if self.lastEquipItem.cardInfo.level ~= self.oldEquipLevel then
        self.objLevelAnimation:set_active(false)
        self.objLevelAnimation:set_active(true)
    end
end

--[[装备升级pane]]
function EquipPackageUI:UpdateRightLevelUpPane()
    if self.lastEquipItem == nil then return end
    local cardInfo = self.lastEquipItem:GetCardInfo()

    self.normalUi.all:set_active(false)   
    self.specicalUi.all:set_active(false)   
    self.spTopEffect:set_active(false)

    self.expProgressUI.obj:set_active(false)

    local isLevelUp = (cardInfo.level ~= cardInfo.rarityConfig.level)

    self:CommonInfo(isLevelUp, cardInfo)
    if self.tp then
        self.tp:Stop()
        self.tp = nil
        self.expProgressUI.fxPro1:set_active(false)
    end
    self.fxLevel:set_active(false)
    --app.log('--cardInfo->' .. table.tostring(cardInfo))  
    --是否是特殊升级
    if cardInfo:IsSpecEquip() then
        self.specicalUi.all:set_active(true)
        isLevelUp = isLevelUp or self.needPlayProAnimation

        self.specicalUi.levelUp:set_active(isLevelUp == true)
        self.specicalUi.rarityUp:set_active(isLevelUp == false)

        self.objSpecLevelUpCont1:set_active(false)
        self.objSpecLevelUpCont2:set_active(false)
        if g_dataCenter.player.level >= ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_equip_quick_level_up_open_level).data then
            self.objSpecLevelUpCont1:set_active(true)
        else
            self.objSpecLevelUpCont2:set_active(true)
        end

        self:SpecialLevelUpPane(isLevelUp, cardInfo)
    else
        self.normalUi.all:set_active(true)
        self.normalUi.levelUp:set_active(isLevelUp == true)
        self.normalUi.rarityUp:set_active(isLevelUp == false)

        self:NormalLevelUpPane(isLevelUp, cardInfo)
    end    

    --满级效果
    if cardInfo.level >= CardEquipment.GetMaxLevel() then
        self.normalUi.all:set_active(false)   
        self.specicalUi.all:set_active(false)
        self.expProgressUI.obj:set_active(false) 
        self.spTopEffect:set_active(true)
    end
    self:UpdateUITips()
end

function EquipPackageUI:CommonInfo(isLevelUp, cardInfo)
    self.equipInfoUI.smallItem:SetData(cardInfo)
    self.equipInfoUI.name:set_text(cardInfo.name)
    self.equipInfoUI.level:set_text(PublicFunc.GetColorText(cardInfo.level, "orange_yellow")  .. "/" .. cardInfo.rarityConfig.level)

    local info = {}
    for _, v in ipairs(self.equipShowProp) do
        local _currValue = cardInfo:GetPropertyVal(v.key)
        if _currValue ~= 0 then
            --下一等级或品级
            local _nextValue = nil   
            local nextCardInfo = self:GetNextCardInfo(cardInfo, isLevelUp, cardInfo.level) 
            --满级后显示当前值
            if nextCardInfo ~= nil and cardInfo.level ~= CardEquipment.GetMaxLevel() then
                _nextValue = nextCardInfo:GetPropertyVal(v.key)
            end
            table.insert(info, {currValue = _currValue, nextValue = _nextValue, config = v})
        end
    end

    for k, v in pairs(self.equipInfoUI.props) do
        local data = info[k]
        if data ~= nil then
            v.lbl:set_active(true)
            v.lbl:set_text(data.config.str)

            v.num1:set_active(false)
            v.lblTop:set_active(false)

            --最高等级或品级时，不显示
            if data.nextValue ~= nil then
                v.num1:set_active(true)
                v.num1:set_text(tostring(data.currValue))
                v.num2:set_text(tostring(data.nextValue))
            else
                v.lblTop:set_active(true)
                v.lblTop:set_text(tostring(data.currValue))
            end
        else
            v.lbl:set_active(false)
        end
    end    
end

--[[下一等级或品级]]
function EquipPackageUI:GetNextCardInfo(cardInfo, isLevelUp, currLevel)
    if isLevelUp then
        if currLevel + 1 <= CardEquipment.GetMaxLevel() then
            return cardInfo:CloneWithNewNumberLevelRairty(cardInfo.number, currLevel + 1, nil)            
        end
    else
        if cardInfo.rarity + 1 <= CardEquipment.GetMaxRarity() then
            return cardInfo:CloneWithNewNumberLevelRairty(cardInfo.number, nil, cardInfo.rarity + 1)            
        end
    end
    return nil
end

--[[全部升级金币]]
--[[
    1. 如果任意装备金币都不足, 则显示最小花费的
    2. 依次升级， 在无等级限制情况下，累加金币
]]
function EquipPackageUI:GetLevelUpAllCostGold()
    local minCost = nil
    local noEnoughGold = true

    self:ForeachNormalEquip(function(cardInfo)
        if cardInfo.level ~= cardInfo.rarityConfig.level then
            --升到下一级
            local cost = cardInfo.levelConfig.cost_gold
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
    local total, list = self:GetCanLevelUpEquipInfo()
    return total
end

function EquipPackageUI:GetCanLevelUpEquipInfo()
    local total = 0
    local __list = {}

    --依次累加  
    self:ForeachNormalEquip(function(cardInfo)
        local cost = self:GetLevelUpKeyCostGold(cardInfo, total)
        --可以升级
        if cost > 0 then
            table.insert(__list, cardInfo.index)
        end
        total = total + cost 
    end)
    return total, __list
end

--[[一键升级金币]]
function EquipPackageUI:GetLevelUpKeyCostGold(cardInfo, initTotal)
    local total = 0
    if initTotal ~= nil then
        total = initTotal
    end
    local limitLevel = self:GetEquipLimitLevel()
    local maxLevel = CardEquipment.GetMaxLevel()

    for level = cardInfo.level, cardInfo.rarityConfig.level - 1 do
        --战队等级 --> 装备等级
        if level == limitLevel then
            break
        end
        --达最高
        if level >= maxLevel then
            break
        end
        --金币
        local costGold = self:GetCostGoldByLevel(cardInfo.number, level)
        if total + costGold > PropsEnum.GetValue(IdConfig.Gold) then
            break
        end     
        total = total + costGold
    end 
    if initTotal ~= nil then 
        return total - initTotal
    end 
    return total
end

function EquipPackageUI:GetCostGoldByLevel(number, level)
    return ConfigHelper.GetEquipLevel(number, level).cost_gold
end

function EquipPackageUI:GetEquipLimitLevel()
    return ConfigManager.Get(EConfigIndex.t_equipment_level_limit, g_dataCenter.player:GetLevel()).equip_max_level
end

function EquipPackageUI:NormalEquipLevelHaveLimit()
    local limitLevel = self:GetEquipLimitLevel()
    local flag = true

    self:ForeachNormalEquip(function(cardInfo)
        if cardInfo.level ~= limitLevel then
            flag = false
            return false
        end
    end)
    return flag
end

--[[普通升级]]
function EquipPackageUI:NormalLevelUpPane(isLevelUp, cardInfo)
    --升级    
    if isLevelUp then        
        --全部升级金币
        self.normalLevelUpUI.all.lblDesc:set_active(false)
        self.normalLevelUpUI.all.spGold:set_active(false)
        self.normalLevelUpUI.key.lblDesc:set_active(false)
        self.normalLevelUpUI.key.spGold:set_active(false)

        --普通装备都升到限制等级
        if self:NormalEquipLevelHaveLimit() then
            self.normalLevelUpUI.all.lblDesc:set_active(true)
        else
            self.normalLevelUpUI.all.spGold:set_active(true)
            local count = self:GetLevelUpAllCostGold()
            self.normalLevelUpUI.all.lblGold:set_text(PublicFunc.GetGoldStrWidthColor(count))
        end

        --一键升级金币
        if cardInfo.level == self:GetEquipLimitLevel() then
            self.normalLevelUpUI.key.lblDesc:set_active(true)
        else
            self.normalLevelUpUI.key.spGold:set_active(true)
            local count = self:GetLevelUpKeyCostGold(cardInfo)
            --显示升到下级花费
            if count == 0 then
                count = self:GetCostGoldByLevel(cardInfo.number, cardInfo.level)
            end
            self.normalLevelUpUI.key.lblGold:set_text(PublicFunc.GetGoldStrWidthColor(count))
        end
 
    --升品
    else
        self:InitMaterialUI()

        --升品材料
        for k, v in pairs(self.equipMaterialUI.smallItem) do
            local material = cardInfo.rarityConfig.material[k]
            if material ~= nil then
                v:Show()                
                v:ClearOnClicked()
                v:SetDataNumber(material.number)    
                v:SetNeedCount(material.count) 
                v:SetNumberType(2)
                --获取途径
                if material.count > PropsEnum.GetValue(material.number) then
                    v:SetBtnAddShow(true)                    
                    v:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(material.count), material.number)
                else
                    v:SetBtnAddShow(false)
                    v:SetOnClicked(self.bindfunc["on_find_way_material"], tostring(material.count), material.number)  
                end                  
                --app.log('material.number, count -->' .. material.number .. ' ' .. material.count)
            else
                v:Hide() 
            end            
        end

        --全部升品 
        local costGold = self:GetRarityUpAllCostGold()
        self.equipMaterialUI.lblGoldLeft:set_text(PublicFunc.GetGoldStrWidthColor(costGold))
        self.equipMaterialUI.lblGold:set_text(PublicFunc.GetGoldStrWidthColor(cardInfo.rarityConfig.need_gold))
 
    end
end

--[[特殊升级]]
function EquipPackageUI:SpecialLevelUpPane(isLevelUp, cardInfo) 
    --升级    
    if isLevelUp then
        self.expProgressUI.obj:set_active(true)

        self:InitSpecMaterialUI()
        self:InitProgressUI()

        if self.clsMaterialUi == nil then
            self.clsMaterialUi = EquipSelectMatirialUI:new()
        end
        self.needExp = cardInfo.levelConfig.need_exp
        self:update_exp_and_material({})
        
    --升品
    else 
        self:InitSpecRarityUI()
        self.specRarityUI.lblGold:set_text(PublicFunc.GetGoldStrWidthColor(cardInfo.rarityConfig.need_gold))

        --二级货币
        local material = cardInfo.rarityConfig.material[1]
        if material == nil then
            app.log("无二级货币配置")
        end
        local info = PublicFunc.IdToConfig(material.number)
        if info ~= nil and info.small_icon then
            --拥有
            --self.specRarityUI.lblHave:set_text(string.format(_UIText[13], info.name))

            --二级货币描述
            self.specRarityUI.lblDesc:set_text(info.description)

            local item = self.specRarityUI
            --货币数量
            local currCnt = PropsEnum.GetValue(material.number)
            item.texture1:set_texture(info.small_icon)            
            item.texture2 :set_texture(info.small_icon)
            item.lbl1:set_text(tostring(currCnt))
            if material.count > currCnt then
                item.lbl2:set_text('[ff0000]' ..material.count .. "[-]")
            else
                item.lbl2:set_text(tostring(material.count))
            end            
        end 
        
        --达最高, 按钮变灰
        if cardInfo.rarity >= CardEquipment.GetMaxRarity() then
            PublicFunc.SetUISpriteGray(self.spRarityUp)
            PublicFunc.SetUILabelEffectGray(self.lblRarityUp)
        else
            PublicFunc.SetUISpriteWhite(self.spRarityUp)
            PublicFunc.SetUILabelEffectRed(self.lblRarityUp)
        end       
    end
end

--[[更新材料信息]]
function EquipPackageUI:update_exp_and_material(material)
    self.selectMaterial = material
    --app.log('self.selectMaterial -- >' ..table.tostring(self.selectMaterial))

    self.calcuExp = 0
    for k, v in pairs(self.equipSpecMaterialUI.smallItem) do
        v:Show()
        local ma = self.selectMaterial[k]
        if ma ~= nil then
            v:SetDataNumber(ma.number, 1)
            v:SetNumberType(1)
            --加号
            v:SetBtnAddShow(false)
            self.calcuExp = self.calcuExp + ma.exp
        else
            v:SetData(nil)
            --加号
            v:SetBtnAddShow(true)
        end
        v:SetBtnAddOnClicked(self.bindfunc["on_add_material"])
        v:SetOnClicked(self.bindfunc["on_add_material"])
    end
    local cardInfo = self.lastEquipItem:GetCardInfo()
    self.currExp = cardInfo.exp + self.calcuExp

    self:UpdateConsumeGold(self.calcuExp)
     --[[当前经验足够时，显示小红点]]
    self.spTipSpecLv1:set_active(false)
    self.spTipSpecLv2:set_active(false)
    if cardInfo.exp >= self.needExp then
        if cardInfo:CanLevelUp() then
            self.spTipSpecLv1:set_active(true)
            self.spTipSpecLv2:set_active(true)
        end
    end

    if self.needPlayProAnimation then
        self.needPlayProAnimation = false
        if self.lastExpInfo then
            local last = self.lastExpInfo
            local sValue = last.exp / last.needExp
            if sValue >= 1 then
                sValue = 1
            end

            --上一次进度
            self.expProgressUI.pro2:set_value(last.currExp / last.needExp)
            --一次动画
            if last.currExp <= last.needExp then
                local eValue = last.currExp / last.needExp
                if eValue >= 1 then
                    eValue = 1
                end
                self:PlayExpAnimation(sValue, eValue, last.currExp, last.needExp)
            --两次动画
            else
                --直接播放第二次
                if sValue == 1 then
                    self:end_play_animation2()
                else
                    self:PlayExpAnimation(sValue, 1, last.currExp, last.needExp, true)
                end
            end
        end
    else
        self:UpdateProgress()
    end

    --记录上次经验
    self.lastExpInfo = {
        exp = cardInfo.exp,
        currExp = self.currExp,
        needExp = self.needExp
    }
end

function EquipPackageUI:UpdateProgress()
    local cardInfo = self.lastEquipItem:GetCardInfo()
    self.expProgressUI.pro2:set_value(self.currExp / self.needExp)
    self.expProgressUI.pro1:set_value(cardInfo.exp / self.needExp)
    --[974D04FF]30[-][7463C9FF]/100[-]
    self.expProgressUI.lbl:set_text('[974D04]' .. self.currExp .. "[-][7463C9]/" .. self.needExp .. '[-]')
end

function EquipPackageUI:PlayExpAnimation(startValue, endValue, currExp, needExp, playTwice)
    local diff = endValue - startValue
    if startValue > endValue then
        diff = startValue - endValue
    end

    local tp_data = {
        progress_bar = self.expProgressUI.pro1,
        duration = diff * 0.75,
        begin = startValue,
        eend = endValue,
        up_call = function(value)
            local _exp = math.ceil(value * currExp)
            if _exp > needExp then
                _exp = needExp
            end
            self.expProgressUI.lbl:set_text('[974D04]' .. _exp .. "[-][7463C9]/" .. needExp .. '[-]')
            self.expProgressUI.fxPro1:set_active(true)
        end,
        com_call = function()
            if currExp > needExp then
                self.expProgressUI.lbl:set_text('[974D04]' .. needExp .. "[-][7463C9]/" .. needExp .. '[-]')
            else
                self.expProgressUI.lbl:set_text('[974D04]' .. currExp .. "[-][7463C9]/" .. needExp .. '[-]')
            end
            self.expProgressUI.pro1:set_value(currExp / needExp)
            if playTwice then
                TimerManager.Add(self.bindfunc["end_play_animation2"], 10, 1)
                local eValue = self.currExp / self.needExp
                if eValue > 0 then
                else
                    --经验值可能为0
                    self:PlayLevelAnimation()
                end
            else
                TimerManager.Add(self.bindfunc["end_play_animation"], 300, 1)
                self:PlayLevelAnimation()
            end
        end
    }
    if not self.tp then
        self.tp = TweenProgress:new(tp_data)
    end
    self.tp:Play(tp_data)
end

function EquipPackageUI:end_play_animation()
    if self.expProgressUI and self.expProgressUI.fxPro1 then
        self.expProgressUI.fxPro1:set_active(false)
    end
    self:UpdateProgress()
    local cardInfo = self.lastEquipItem:GetCardInfo()
    local isLevelUp = (cardInfo.level ~= cardInfo.rarityConfig.level)
    --转到升品界面
    if not isLevelUp then
        self:UpdateRightLevelUpPane()
    end
end

function EquipPackageUI:end_play_animation2()
    if self.expProgressUI and self.expProgressUI.fxPro1 then
        self.expProgressUI.fxPro1:set_active(false)
    end
    self:UpdateProgress()
    local eValue = self.currExp / self.needExp
    if eValue >= 1 then
        eValue = 1
    end
    if eValue > 0 then
        self:PlayExpAnimation(0, eValue, self.currExp, self.needExp)
    elseif eValue == 0 then
        self:end_play_animation()
    end
end

function EquipPackageUI:RemoveAnimationTimer()
    TimerManager.Remove(self.bindfunc["end_play_animation2"])
    TimerManager.Remove(self.bindfunc["end_play_animation"])
end

--[[更新消耗的金币]]
function EquipPackageUI:UpdateConsumeGold(exp)
    local ui = self.equipSpecMaterialUI
    if exp ~= 0 then
        ui.objGold:set_active(true)
        ui.objGold2:set_active(true)
        local config = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_equip_levelup_exp_cost_gold)
        self.currConsumeGold = exp * config.data
        local _txt = PublicFunc.GetGoldStrWidthColor(self.currConsumeGold)
        ui.lblGold:set_text(_txt)
        ui.lblGold2:set_text(_txt)
    else
        self.currConsumeGold = 0
        ui.objGold:set_active(false)
        ui.objGold2:set_active(false)
    end
end

--[[升级]]
function EquipPackageUI:on_level_up()
    if self:CanLevelUp() then
        local useItem = {}
        local cardInfo = self.lastEquipItem:GetCardInfo()
        --特殊装备升级
        if cardInfo:IsSpecEquip() then
            local temp = {}
            for _, v in pairs(self.selectMaterial) do
                if temp[v.number] == nil then
                    temp[v.number] = 1
                else
                    temp[v.number] = temp[v.number] + 1
                end
            end
            for k, v in pairs(temp) do
                table.insert(useItem, {dataid = "", id = k, count = v})
            end
        end
        self.oldEquipLevel = self.lastEquipItem.cardInfo.level
        msg_cards.cg_equip_level_up(cardInfo.index, 0, useItem, 0)
    end
end

--[[全部升级]]
function EquipPackageUI:on_level_up_all()
    if self:NoramlEquipCanLevelUp() then
        local total, list = self:GetCanLevelUpEquipInfo()
        self.levelUpEquipIndexList = list
        for k, index in ipairs(self.levelUpEquipIndexList) do
            msg_cards.cg_equip_level_up(index, 1, {}, 1)
        end
    end
end

--[[一键升级]]
function EquipPackageUI:on_level_up_key()
    if self:CanLevelUp() then
        self.oldEquipLevel = self.lastEquipItem.cardInfo.level
        msg_cards.cg_equip_level_up(self.lastEquipItem.cardInfo.index, 1, {}, 0)
    end
end

--[[全部升级判断]]
function EquipPackageUI:NoramlEquipCanLevelUp()
    local limitLevel = self:GetEquipLimitLevel()
    local maxLevel = CardEquipment.GetMaxLevel()
    local haveLimit = true
    local upToMaxLevel = true
    --达到升品点
    local upToRarityPoint = true
    local enoughGold = false

    self:ForeachNormalEquip(function(cardInfo)
        if cardInfo.level ~= limitLevel then
            haveLimit = false
        end
        if cardInfo.level < maxLevel then
            upToMaxLevel = false
        end
        --是否升到升品点
        if cardInfo.level ~= cardInfo.rarityConfig.level then
            upToRarityPoint = false
        end
        if cardInfo.levelConfig.cost_gold <= PropsEnum.GetValue(IdConfig.Gold) then
            enoughGold = true
        end
    end)

    if haveLimit then
        FloatTip.Float(_UIText[6])
        return false
    end
    if upToMaxLevel then
        FloatTip.Float(_UIText[6])
        return false
    end
    if upToRarityPoint then
        return false
    end
    if not enoughGold then
        --FloatTip.Float(_UIText[7])
        PublicFunc.GotoExchangeGold()
        return false
    end
    return true
end

function EquipPackageUI:CanLevelUp(__showTip, __cardInfo, checkItem)
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
    if cardInfo == nil then return false end

    --战队等级 --> 装备等级
    if cardInfo.level == self:GetEquipLimitLevel() then
        if showTip then
            FloatTip.Float(_UIText[6])
        end
        return false
    end
    --达最高
    if cardInfo.level >= CardEquipment.GetMaxLevel() then
        if showTip then
            FloatTip.Float(_UIText[6])
        end
        return false
    end
    --是否升到升品点
    if cardInfo.level == cardInfo.rarityConfig.level then
        return false
    end

    --是否检查消耗道具
    if checkItem == false then
        return true
    end

    --特殊装备升级
    if cardInfo:IsSpecEquip() then
        --exp不足时，才需要添加材料
        if self.currExp < self.needExp then
            if self.calcuExp == 0 then
                if showTip then
                    FloatTip.Float(_UIText[10])
                end
                return false
            end
        end
        if self.currConsumeGold > PropsEnum.GetValue(IdConfig.Gold) then
            if showTip then
                --FloatTip.Float(_UIText[7])
                PublicFunc.GotoExchangeGold()
            end
            return false
        end
    else
        if cardInfo.levelConfig.cost_gold > PropsEnum.GetValue(IdConfig.Gold) then
            if showTip then
                --FloatTip.Float(_UIText[7])
                PublicFunc.GotoExchangeGold()
            end
            return false
        end
    end
    return true
end

function EquipPackageUI:on_add_material()
    local data = self:GetMaterialData(120)
    if #data == 0 then
        return
    end
    self.clsMaterialUi:Show()
    self.clsMaterialUi:UpdateData(data, self.selectMaterial, self.bindfunc["update_exp_and_material"] )
end

--[[材料获取途径]]
function EquipPackageUI:on_find_way_material(t)
    local temp = {}
    temp.item_id = t.float_value
    temp.number = tonumber(t.string_value)
    AcquiringWayUi.Start(temp)
end

--[[自动添加材料]]
function EquipPackageUI:on_auto_add_material()
    local cardInfo = self.lastEquipItem:GetCardInfo()
    if cardInfo.level >= CardEquipment.GetMaxLevel() then
        return
    end
    local data = self:GetMaterialData(4)
    if #data == 0 then
        return
    end
    local material = {}
    for i = 1,4 do
        if data[i] ~= nil then
            material[i] = data[i]
        end
    end
    self:update_exp_and_material(material)
end

function EquipPackageUI:GetMaterialData(_GetCount, isExpand)
    local cardInfo = self.lastEquipItem:GetCardInfo()
    local category = nil
    if cardInfo.position == ENUM.EEquipPosition.Helmet then
        category = ENUM.EItemCategory.Helmet
    elseif cardInfo.position == ENUM.EEquipPosition.Accessories then
        category = ENUM.EItemCategory.Accessories
    end
    local cardData = {}
    local retData = {}
    local pkg = g_dataCenter.package:GetCard(ENUM.EPackageType.Item)
    for dataid, card in pairs(pkg) do
        if card.category == category then
            table.insert(cardData, card)
        end
    end

    if #cardData == 0 then
        --材料获取途径
        local number = cardInfo:GetSpecEquipMaterialNumber()
        self:on_find_way_material({float_value = number, string_value = 1})
        return retData
    end

    --先按星级排序
    table.sort(cardData, function(a, b)
        return a.rarity < b.rarity
    end)

    if isExpand == false then
        retData = cardData
    else
        --再按数量展开  
        local cnt = 0
        for dataid, card in ipairs(cardData) do
            for i = 1, card.count do
                table.insert(retData, card)
                cnt = cnt + 1
                if cnt >= _GetCount then
                    return retData
                end
            end
        end
    end
    return retData
end

--[[快速升级]]
function EquipPackageUI:on_quick_level_up()
    if self:CanLevelUp(nil, nil, false) == false then
        return
    end
    local data = self:GetMaterialData(nil, false)
    if #data == 0 then
        return
    end

    local para = {equipCardInfo = self.lastEquipItem.cardInfo, materialCardInfo = data}
    EquipQuickLevelUpUI.Start(para)
end