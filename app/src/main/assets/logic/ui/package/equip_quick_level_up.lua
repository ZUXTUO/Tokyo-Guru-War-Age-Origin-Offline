
EquipQuickLevelUpUI = Class("EquipQuickLevelUpUI", UiBaseClass)

function EquipQuickLevelUpUI.Start(data)
    if EquipQuickLevelUpUI.cls == nil then
        EquipQuickLevelUpUI.cls = EquipQuickLevelUpUI:new(data)
    end
end

function EquipQuickLevelUpUI.End()
    if EquipQuickLevelUpUI.cls then
        EquipQuickLevelUpUI.cls:DestroyUi()
        EquipQuickLevelUpUI.cls = nil
    end
end

local _UIText = {
    [1] = "已达当前最高等级",
    [2] = "目标等级与当前等级一致,请重新选择",
}

function EquipQuickLevelUpUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_604_5.assetbundle"    
    UiBaseClass.Init(self, data)
end

function EquipQuickLevelUpUI:InitData(data)
    self.data = data
	UiBaseClass.InitData(self, data)
    
end

function EquipQuickLevelUpUI:Restart(data) 
    self.materialSmallItem = {}
    self.__consumeInfo = {materialList =  nil,   needGold = 0,  needCurrency = 0, targetRarity = nil}
    self.chooseLevel = nil

	if UiBaseClass.Restart(self, data) then        
	end
end

function EquipQuickLevelUpUI:RegistFunc()
    UiBaseClass.RegistFunc(self)    
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    
    self.bindfunc["on_slider_value_change"] = Utility.bind_callback(self, self.on_slider_value_change)
    self.bindfunc["on_min_btn_click"] = Utility.bind_callback(self, self.on_min_btn_click)
    self.bindfunc["on_max_btn_click"] = Utility.bind_callback(self, self.on_max_btn_click)
    self.bindfunc["on_confirm"] = Utility.bind_callback(self, self.on_confirm)
end

function EquipQuickLevelUpUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_special_equip_level_up_fast,self.bindfunc['on_close'])
end

function EquipQuickLevelUpUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_special_equip_level_up_fast,self.bindfunc['on_close'])
end

function EquipQuickLevelUpUI:DestroyUi()    
    if self.equipSmallItem then
        self.equipSmallItem:DestroyUi()
        self.equipSmallItem = nil
    end
    for k, v in pairs(self.materialSmallItem) do
        if v then
            v:DestroyUi()
            v = nil
        end
    end
    self.materialSmallItem = {}
    if self.textCurrency then
        self.textCurrency:Destroy()
        self.textCurrency = nil
    end

    UiBaseClass.DestroyUi(self)
end

function EquipQuickLevelUpUI:on_close()
    EquipQuickLevelUpUI.End()
end

function EquipQuickLevelUpUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("equip_quick_level_up")

    local path = "centre_other/animation/"
    local btnClose = ngui.find_button(self.ui, path .. "content_di_754_458/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    local btnCancel = ngui.find_button(self.ui, path .. "content/btn1")
    btnCancel:set_on_click(self.bindfunc["on_close"])

    local btnConfirm = ngui.find_button(self.ui, path .. "content/btn2")
    btnConfirm:set_on_click(self.bindfunc["on_confirm"])

    local conPath = path .. 'content/'
    self.lblLevelDesc = ngui.find_label(self.ui, conPath .. 'txt_dengji/lab')
    
    if self.equipSmallItem == nil then
        local item_path = conPath .. "new_small_card_item"
        local obj = self.ui:get_child_by_name(item_path) 
        self.equipSmallItem = UiSmallItem:new({parent = obj, cardInfo = nil, delay = -1})
    end
    self.slider = ngui.find_slider(self.ui, conPath .. "act/pro_back")
    self.slider:set_on_change(self.bindfunc["on_slider_value_change"])
    self.spSlider = ngui.find_sprite(self.ui, conPath .. "act/pro_back/thumb")

	self.btnMin = ngui.find_button(self.ui, conPath .. "act/btn_red")
    self.btnMin:set_on_click(self.bindfunc["on_min_btn_click"])	
    self.spMin = ngui.find_sprite(self.ui, conPath .. "act/btn_red/animation/sp_red")
    self.lblMin = ngui.find_label(self.ui, conPath .. "act/btn_red/animation/lab_min")

    self.btnMax = ngui.find_button(self.ui, conPath .. "act/btn_blue")
    self.btnMax:set_on_click(self.bindfunc["on_max_btn_click"])	
    self.spMax = ngui.find_sprite(self.ui, conPath .. "act/btn_blue/animation/sp_red")
    self.lblMax = ngui.find_label(self.ui, conPath .. "act/btn_blue/animation/lab_min")

    self.lblCanNoLevelUp = ngui.find_label(self.ui, conPath .. 'lab_red')
    self.objRarityDesc = self.ui:get_child_by_name(conPath .. 'sp_title')
    self.lblRarityDesc = ngui.find_label(self.ui, conPath .. 'sp_title/lab')

    for i = 1, 3 do 
        local obj = self.ui:get_child_by_name(conPath.. "cont/new_small_card_item" .. i)
        self.materialSmallItem[i] = UiSmallItem:new({parent = obj, cardInfo = nil, delay = 400}) 
    end 
    self.lblGold = ngui.find_label(self.ui, conPath .. "txt_xiaohao/sp_gem/lab")
    self.textCurrency = ngui.find_texture(self.ui, conPath .. "txt_xiaohao/sp_jiangpai")
    self.lblCurrency = ngui.find_label(self.ui, conPath .. "txt_xiaohao/sp_jiangpai/lab")

    self:CalculateMaxTargeLevel()
    self:UpdateUI()

end

function EquipQuickLevelUpUI:UpdateUI()
    self.equipSmallItem:SetData(self.data.equipCardInfo)
    self.slider:set_steps(100)
	self.slider:set_value(0)

    self.lblRarityDesc:set_text(PublicFunc.GetEquipRarityStr(self.data.equipCardInfo.rarity))
    --材料
    for k, v in ipairs(self.materialSmallItem) do 
        local cardInfo = self.data.materialCardInfo[k]
        if cardInfo ~= nil then
            v:Show()
            v:SetDataNumber(cardInfo.number) 
            v:SetNeedCount(0) 
            v:SetNumberType(2)
        else
            v:Hide()           
        end
    end

    local material = self.data.equipCardInfo.rarityConfig.material[1]
    local _count = 0

    local info = PublicFunc.IdToConfig(material.number)
    if info ~= nil and info.small_icon then
        self.textCurrency:set_texture(info.small_icon)
    end 
    if _count > PropsEnum.GetValue(material.number) then
        self.lblCurrency:set_text('[ff0000]' .. _count .. "[-]")
    else
        self.lblCurrency:set_text(tostring(_count))
    end  

    self.lblGold:set_text(PublicFunc.GetGoldStrWidthColor(0))
end

function EquipQuickLevelUpUI:UpdateBySlider(value)
    if value == nil then
        return
    end

    self.lblCanNoLevelUp:set_active(false)
    self.objRarityDesc:set_active(true)

    --不能升级
    if self.maxTargetLevel == self.data.equipCardInfo.level then
        self.lblLevelDesc:set_text(self.maxTargetLevel .. '/' .. self.maxTargetLevel)

        self.lblCanNoLevelUp:set_active(true)
        self.objRarityDesc:set_active(false)

        PublicFunc.SetUISpriteGray(self.spMin)
	    PublicFunc.SetUILabelEffectGray(self.lblMin)
        PublicFunc.SetUISpriteGray(self.spMax)
	    PublicFunc.SetUILabelEffectGray(self.lblMax)

        self.spSlider:get_game_object():set_collider_enable(false)
        self.btnMin:get_game_object():set_collider_enable(false)
        self.btnMax:get_game_object():set_collider_enable(false)

        PublicFunc.SetUISpriteGray(self.spSlider)
        return
    end

    --等级相关
    local diffLevel = math.ceil(value * (self.maxTargetLevel - self.data.equipCardInfo.level))
    local currLevel = self.data.equipCardInfo.level + diffLevel     

    if self.chooseLevel ~= currLevel then
        self.lblLevelDesc:set_text(currLevel .. '/' .. self.maxTargetLevel)
     
        if currLevel == self.data.equipCardInfo.level then
		    PublicFunc.SetUISpriteGray(self.spMin)
		    PublicFunc.SetUILabelEffectGray(self.lblMin)
	    else
		    PublicFunc.SetUISpriteWhite(self.spMin)
		    PublicFunc.SetUILabelEffectBlue(self.lblMin)
	    end

	    if currLevel == self.maxTargetLevel then
		    PublicFunc.SetUISpriteGray(self.spMax)
		    PublicFunc.SetUILabelEffectGray(self.lblMax)
	    else
		    PublicFunc.SetUISpriteWhite(self.spMax)
		    PublicFunc.SetUILabelEffectRed(self.lblMax)
	    end
    end

    if self.chooseLevel == nil then
        self.chooseLevel = currLevel
    else
        if self.chooseLevel ~= currLevel then
            self.chooseLevel = currLevel
            --
            self:CalculateConsumeInfo(self.chooseLevel)
            self:UpdateUIByLevel(self.chooseLevel)
        end
    end
end

function EquipQuickLevelUpUI:UpdateUIByLevel(level)
    self.lblRarityDesc:set_text(PublicFunc.GetEquipRarityStr(self.__consumeInfo.targetRarity))
    --材料
    for k, v in ipairs(self.materialSmallItem) do 
        local cardInfo = self.data.materialCardInfo[k]
        if cardInfo ~= nil then 
            local cnt = 0
            if self.__consumeInfo.materialList and self.__consumeInfo.materialList[cardInfo.number] then
                cnt = self.__consumeInfo.materialList[cardInfo.number]
            end
            v:SetNeedCount(cnt) 
        end
    end

    local mNumber, mCount = self:GetRarityMaterail()
    local _count = self.__consumeInfo.needCurrency

    if _count > mCount then
        self.lblCurrency:set_text('[ff0000]' .. _count .. "[-]")
    else
        self.lblCurrency:set_text(tostring(_count))
    end  

    self.lblGold:set_text(PublicFunc.GetGoldStrWidthColor(self.__consumeInfo.needGold))
end

function EquipQuickLevelUpUI:GetRarityMaterail()
    local material = self.data.equipCardInfo.rarityConfig.material[1]
    return material.number, PropsEnum.GetValue(material.number)
end

function EquipQuickLevelUpUI:CalculateConsumeInfo(level)
    if level == nil or level < self.data.equipCardInfo.level or level > self.maxTargetLevel then
        return
    end
    local __exp = self:GetConsumeExp(level)
    local __consumeExp = 0 

    -- index --> count
    local materialList = {}
    --各道具消耗
    if __exp > 0 then
        for k, item in pairs(self.data.materialCardInfo) do
            local itemExp = item.exp * item.count
            if materialList[item.number] == nil then
                materialList[item.number] = 0
            end
       
            --全部消耗
            if itemExp <= __exp - __consumeExp then            
                __consumeExp = __consumeExp + itemExp
                materialList[item.number] = materialList[item.number] + item.count

            --消耗一部分
            else
                for i = 1, item.count do
                    __consumeExp = __consumeExp + item.exp
                    if __consumeExp >= __exp then
                        materialList[item.number] = materialList[item.number] + i
                        break
                    end  
                end
            end
            if __exp - __consumeExp <= 0 then
                break
            end
        end 
    end

    --升到品质
    local targetRarity = self.data.equipCardInfo.rarity
    local max_equip_rarity = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_equip_max_rarity).data
    for rarity = self.data.equipCardInfo.rarity, max_equip_rarity do
        local config = ConfigHelper.GetEquipRarity(self.data.equipCardInfo.number, rarity)
        if level > config.level then
            targetRarity = rarity + 1
        else
            break
        end
    end 

    --累加升品消耗    
    local needCurrency = 0    
    local rarityGold = 0
    for rarity = self.data.equipCardInfo.rarity, targetRarity - 1 do
        local config = ConfigHelper.GetEquipRarity(self.data.equipCardInfo.number, rarity)
        local ma = config.material[1]
        needCurrency = needCurrency + ma.count
        rarityGold = rarityGold + config.need_gold
    end 

    --花费金币及二级货币
    local config = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_equip_levelup_exp_cost_gold)
    local needGold = __consumeExp * config.data + rarityGold
    --app.log('==========> __consumeExp = ' .. __consumeExp .. '  rarityGold = ' .. rarityGold)

    self.__consumeInfo.materialList =  materialList
    self.__consumeInfo.needGold = needGold
    self.__consumeInfo.needCurrency = needCurrency
    self.__consumeInfo.targetRarity = targetRarity

    --app.log('==========> self.__consumeInfo = ' .. table.tostring(self.__consumeInfo))
end

--[[可以升到到等级]]
function EquipQuickLevelUpUI:CalculateMaxTargeLevel()
    --之前拥有exp
    local currExp = self.data.equipCardInfo.exp
    for k, item in pairs(self.data.materialCardInfo) do
        currExp = currExp + item.exp * item.count
    end
    
    local total = 0
    local limitLevel = self:GetEquipLimitLevel()

    self.maxTargetLevel = self.data.equipCardInfo.level
    for level = self.data.equipCardInfo.level, limitLevel - 1 do
        local needExp = self:GetNeedExp(self.data.equipCardInfo.number, level)
        if total + needExp <= currExp then
            total = total + needExp
            self.maxTargetLevel = level + 1
        else
            break
        end
    end
end

function EquipQuickLevelUpUI:GetEquipLimitLevel()
    return ConfigManager.Get(EConfigIndex.t_equipment_level_limit, g_dataCenter.player:GetLevel()).equip_max_level
end

function EquipQuickLevelUpUI:GetConsumeExp(lvl)
    local total = 0
    for level = self.data.equipCardInfo.level, lvl - 1 do
        local needExp = self:GetNeedExp(self.data.equipCardInfo.number, level)
        total = total + needExp
    end
    --之前拥有exp
    return total - self.data.equipCardInfo.exp
end

function EquipQuickLevelUpUI:GetNeedExp(number, level)
    return ConfigHelper.GetEquipLevel(number, level).need_exp
end

function EquipQuickLevelUpUI:on_slider_value_change(value)
    self:UpdateBySlider(value)
end

function EquipQuickLevelUpUI:on_min_btn_click()

    local value = self.slider:get_value()
    if value <= 0 then return end

    local diff = self.maxTargetLevel - self.data.equipCardInfo.level
    value = value - 1/(diff - 1)

    self.slider:set_value(value)
end

function EquipQuickLevelUpUI:on_max_btn_click()

    local value = self.slider:get_value()
    if value >= 1 then return end
    
    local diff = self.maxTargetLevel - self.data.equipCardInfo.level
    value = value + 1/(diff - 1)

    self.slider:set_value(value)
end

function EquipQuickLevelUpUI:on_confirm()
    if self.chooseLevel == nil then
        return
    end
    --不能升级
    if self.data.equipCardInfo.level == self.maxTargetLevel then
        FloatTip.Float(_UIText[1])
        return
    end
    if self.data.equipCardInfo.level == self.chooseLevel then
        FloatTip.Float(_UIText[2])
        return
    end
    if PublicFunc.ExchangeGold(self.__consumeInfo.needGold) then
        return
    end
    if self:CheckMaterial() then
        self:on_close()
        return
    end
    local useExpItem = {}
    if self.__consumeInfo.materialList then
        for number, count in pairs(self.__consumeInfo.materialList) do
            table.insert(useExpItem, {dataid = '0', id = number, count = count})
        end
    end
    msg_cards.cg_special_equip_level_up_fast(self.data.equipCardInfo.index, self.chooseLevel, useExpItem)
end

function EquipQuickLevelUpUI:CheckMaterial()
    local mNumber, mCount = self:GetRarityMaterail()
    if self.__consumeInfo.needCurrency > mCount then
        local temp = {}
        temp.item_id = mNumber
        temp.number = mCount
        AcquiringWayUi.Start(temp)
        return true
    end 
    return false
end