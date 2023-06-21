
RoleLevelUpKeyUI = Class("RoleLevelUpKeyUI", UiBaseClass);


function RoleLevelUpKeyUI.Start(data)
    if RoleLevelUpKeyUI.cls == nil then
        RoleLevelUpKeyUI.cls = RoleLevelUpKeyUI:new(data)
    end
end

function RoleLevelUpKeyUI.End()
    if RoleLevelUpKeyUI.cls then
        RoleLevelUpKeyUI.cls:DestroyUi()
        RoleLevelUpKeyUI.cls = nil
    end
end

local _UIText = {
    [1] = "已达当前最高等级",
    [2] = "目标等级与当前等级一致,请重新选择",
}

function RoleLevelUpKeyUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/package/ui_602_10.assetbundle";
	UiBaseClass.Init(self, data);
end

function RoleLevelUpKeyUI:InitData(data)
	UiBaseClass.InitData(self, data)
    self.heroData = data

    self.expItemId = {IdConfig.ExpMedi1, IdConfig.ExpMedi2, IdConfig.ExpMedi3, IdConfig.ExpMedi4, IdConfig.ExpMedi5, IdConfig.ExpMedi6}
	self.expItemData = {}
	for i = 1, 6 do
        local data = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item, self.expItemId[i])
        if data ~= nil then
            self.expItemData[i] = data
        else
            self.expItemData[i] = CardProp:new({number = self.expItemId[i]})
        end
	end
    self.playerLevel = g_dataCenter.player:GetLevel()
    self.curHeroLevel = self.heroData.level
end

function RoleLevelUpKeyUI:Restart(data)
    self.consumeMaterialList = {}
    self.chooseLevel = nil
    self.maxSliderValue = 0 
	if UiBaseClass.Restart(self, data) then
	end
end

function RoleLevelUpKeyUI:DestroyUi()
    if self.heroSmallCard then
        self.heroSmallCard:DestroyUi()
        self.heroSmallCard  = nil
    end
    self.chooseLevel = nil
	UiBaseClass.DestroyUi(self)
end

function RoleLevelUpKeyUI:on_close()
    RoleLevelUpKeyUI.End()
end

function RoleLevelUpKeyUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_slider_value_change"] = Utility.bind_callback(self, self.on_slider_value_change)
    self.bindfunc["on_min_btn_click"] = Utility.bind_callback(self, self.on_min_btn_click)
    self.bindfunc["on_max_btn_click"] = Utility.bind_callback(self, self.on_max_btn_click)
    self.bindfunc["on_level_up"] = Utility.bind_callback(self, self.on_level_up)
    self.bindfunc["on_check_value_change"] = Utility.bind_callback(self, self.on_check_value_change)
end

function RoleLevelUpKeyUI:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_eat_exps,self.bindfunc['on_close'])
end

function RoleLevelUpKeyUI:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_eat_exps,self.bindfunc['on_close'])
end

function RoleLevelUpKeyUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("role_level_up_key")
    local path = "centre_other/animation/"

    local btnCancel = ngui.find_button(self.ui, path .. 'btn_cancel')
    btnCancel:set_on_click(self.bindfunc["on_close"])
    local btnClose = ngui.find_button(self.ui, path .. 'content_di_754_458/btn_cha')
    btnClose:set_on_click(self.bindfunc["on_close"])

    local pathCont = path .. "content/"
    self.heroSmallCard = SmallCardUi:new(
    {   
        parent = self.ui:get_child_by_name(pathCont .. 'big_card_item_80') ,
        info = self.heroData,
        stypes = {SmallCardUi.SType.Texture, SmallCardUi.SType.Level, SmallCardUi.SType.Rarity}
    })
    self.lblLevel = ngui.find_label(self.ui, pathCont .. 'lab_level')

    local pathPro = path .. "cont_pro/"
    self.slider = ngui.find_slider(self.ui, pathPro .. "pro_back")
    self.slider:set_on_change(self.bindfunc["on_slider_value_change"])
    self.spSlider = ngui.find_sprite(self.ui, pathPro .. "pro_back/thumb")

    self.btnMin = ngui.find_button(self.ui, pathPro .. "btn_red")
    self.btnMin:set_on_click(self.bindfunc["on_min_btn_click"])	
    self.spMin = ngui.find_sprite(self.ui, pathPro .. "btn_red/animation/sp_red")
    self.lblMin = ngui.find_label(self.ui, pathPro .. "btn_red/animation/lab_min")

    self.btnMax = ngui.find_button(self.ui, pathPro .. "btn_blue")
    self.btnMax:set_on_click(self.bindfunc["on_max_btn_click"])	
    self.spMax = ngui.find_sprite(self.ui, pathPro .. "btn_blue/animation/sp_red")
    self.lblMax = ngui.find_label(self.ui, pathPro .. "btn_blue/animation/lab_min")
        
    self.expSmallItem = {}
    self.lblExpCount = {}
    for i = 1, 6 do 
        local obj = self.ui:get_child_by_name(path .. "grid/new_small_card_item" .. i)
        local __check = nil
        if self.expItemData[i].count > 0 then
            __check = {
                default_value = true,
                callback = self.bindfunc["on_check_value_change"],
                callback_para = i,
            }
        end
        self.expSmallItem[i] = UiSmallItem:new({ 
            parent = obj, cardInfo = self.expItemData[i], delay = -1,
            check = __check
        }) 
        self.expSmallItem[i]:SetShowNumber(false)
        self.lblExpCount[i] = ngui.find_label(obj, 'lab') 
    end

    local btnLevelUp = ngui.find_button(self.ui, path .. 'btn_level')
    btnLevelUp:set_on_click(self.bindfunc["on_level_up"])
    
    self:UpdateUi()
end

function RoleLevelUpKeyUI:on_check_value_change(para, value, name)
    self:UpdateUi()
end

function RoleLevelUpKeyUI:UpdateUi()
    self:CalculateMaxTargeLevel()
    self.slider:set_steps(100)
	self.slider:set_value(self.maxSliderValue)
end

function RoleLevelUpKeyUI:UpdateBySlider(value)
    --不能升级
    if self.curHeroLevel == self.playerLevel 
        or self.curHeroLevel == self.maxTargetLevel then
        self.lblLevel:set_text(self.curHeroLevel .. '/' .. self.playerLevel)
        self.slider:set_value(0)

        PublicFunc.SetUISpriteGray(self.spMin)
	    PublicFunc.SetUILabelEffectGray(self.lblMin)
        PublicFunc.SetUISpriteGray(self.spMax)
	    PublicFunc.SetUILabelEffectGray(self.lblMax)
        PublicFunc.SetUISpriteGray(self.spSlider)        
    else
        PublicFunc.SetUISpriteWhite(self.spMin)
	    PublicFunc.SetUILabelEffectBlue(self.lblMin)
        PublicFunc.SetUISpriteWhite(self.spMax)
	    PublicFunc.SetUILabelEffectRed(self.lblMax)
        PublicFunc.SetUISpriteWhite(self.spSlider)
    end

    --等级相关
    local diffLevel = math.ceil(value * (self.playerLevel- self.curHeroLevel))
    local currLevel = self.curHeroLevel + diffLevel  
    self.lblLevel:set_text(currLevel .. '/' .. self.playerLevel) 
    
    if self.chooseLevel ~= currLevel then
        if currLevel == self.curHeroLevel then
		    PublicFunc.SetUISpriteGray(self.spMin)
		    PublicFunc.SetUILabelEffectGray(self.lblMin)
	    else
		    PublicFunc.SetUISpriteWhite(self.spMin)
		    PublicFunc.SetUILabelEffectBlue(self.lblMin)
	    end

	    if currLevel == self.playerLevel then
		    PublicFunc.SetUISpriteGray(self.spMax)
		    PublicFunc.SetUILabelEffectGray(self.lblMax)
	    else
		    PublicFunc.SetUISpriteWhite(self.spMax)
		    PublicFunc.SetUILabelEffectRed(self.lblMax)
	    end

        self.chooseLevel = currLevel
        self:CalculateConsumeInfo(self.chooseLevel)
    end
    self:UpdateUIByLevel()
end

function RoleLevelUpKeyUI:UpdateUIByLevel()
    --材料数量
    for i = 1, 6 do
        local item = self.expItemData[i]
        local cnt = 0
        if self.consumeMaterialList[item.index] then
            cnt = self.consumeMaterialList[item.index]
        end
        self.lblExpCount[i]:set_text(item.count .. '/' .. tostring(cnt))
    end
end

function RoleLevelUpKeyUI:CalculateConsumeInfo(level)
    if level == nil or level < self.curHeroLevel or level > self.maxTargetLevel then
        return
    end
    local __exp = self:GetConsumeExp(level)
    local __consumeExp = 0 

    -- index --> count
    local materialList = {}
    --各道具消耗
    if __exp > 0 then
        for k, item in pairs(self.expItemData) do
            --选中
            if item.index ~= nil and self.expSmallItem[k]:GetCheckValue() then
                local itemExp = item.exp * item.count
                if materialList[item.index] == nil then
                    materialList[item.index] = 0
                end
       
                --全部消耗
                if itemExp <= __exp - __consumeExp then            
                    __consumeExp = __consumeExp + itemExp
                    materialList[item.index] = materialList[item.index] + item.count

                --消耗一部分
                else
                    for i = 1, item.count do
                        __consumeExp = __consumeExp + item.exp
                        if __consumeExp >= __exp then
                            materialList[item.index] = materialList[item.index] + i
                            break
                        end  
                    end
                end
                if __exp - __consumeExp <= 0 then
                    break
                end
            end
        end 
    end
    self.consumeMaterialList = materialList
end

function RoleLevelUpKeyUI:on_slider_value_change(value)
    if value == nil then
        return
    end
    if value > self.maxSliderValue then
        value = self.maxSliderValue
        self.slider:set_value(value)
    end
    self:UpdateBySlider(value)
end

function RoleLevelUpKeyUI:on_min_btn_click()

    local value = self.slider:get_value()
    if value <= 0 then return end
    local diff = self.playerLevel - self.curHeroLevel
    value = value - 1/(diff - 1)

    self.slider:set_value(value)
end

function RoleLevelUpKeyUI:on_max_btn_click()
    local value = self.slider:get_value()
    if value >= 1 then return end
    local diff = self.playerLevel - self.curHeroLevel
    value = value + 1/(diff - 1)

    self.slider:set_value(value)
end

function RoleLevelUpKeyUI:GetConsumeExp(lvl)
    local total = 0
    for level = self.curHeroLevel, lvl - 1 do
        local needExp = self:GetNeedExp(self.heroData.number, level)
        total = total + needExp
    end
    --之前拥有exp
    return total - tonumber(self.heroData.cur_exp)
end


--[[可以升到到等级]]
function RoleLevelUpKeyUI:CalculateMaxTargeLevel()
    --之前拥有exp
    local currExp = tonumber(self.heroData.cur_exp)
    for k, item in pairs(self.expItemData) do
        --选中
        if self.expSmallItem[k]:GetCheckValue() then
            currExp = currExp + item.exp * item.count
        end
    end
    
    local total = 0
    self.maxTargetLevel = self.curHeroLevel
    for level = self.curHeroLevel, self.playerLevel - 1 do
        local needExp = self:GetNeedExp(self.heroData.number, level)
        if total + needExp <= currExp then
            total = total + needExp
            self.maxTargetLevel = level + 1
        else
            break
        end
    end

    if self.playerLevel - self.curHeroLevel > 0 then
        self.maxSliderValue = (self.maxTargetLevel  - self.curHeroLevel) / (self.playerLevel - self.curHeroLevel)
    end
end

function RoleLevelUpKeyUI:GetNeedExp(number, level)
    return CardHuman.GetLevelConfig(number, level).upexp
end
function RoleLevelUpKeyUI:on_level_up()
    if self.curHeroLevel == self.playerLevel then
        FloatTip.Float(_UIText[1])
        return
    end
    if self.curHeroLevel == self.chooseLevel or self.curHeroLevel == self.maxTargetLevel then
        FloatTip.Float(_UIText[2])
        return
    end
    local useExpItem = {}
    if self.consumeMaterialList then
        for index, count in pairs(self.consumeMaterialList) do
            table.insert(useExpItem, {dataid = index, number = 0, count = count})
        end
    end
    if #useExpItem == 0 or self.chooseLevel == nil then
        return
    end
    msg_cards.cg_eat_exps(self.heroData.index, self.chooseLevel, useExpItem)
end