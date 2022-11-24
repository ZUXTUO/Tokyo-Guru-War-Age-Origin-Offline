
BuyBatchUi = Class('BuyBatchUi', UiBaseClass)

local _UIText = {
    ["not_enough_cost"] = "%s不足",
    ["buy_count_0_tips"] = "请选择购买数量",
    ["buy_count"] = "数量[00FF73]%s[-]",
}

--设置回调函数
function BuyBatchUi:SetCallback(callback, callParam)
    self.callback = callback
    self.callParam = callParam
end

--设置数据data
-- data
--      itemId	    道具配置id
--      itemCount    购买一批次道具的数量（默认1）
--      itemDesc     道具描述内容（默认item配置）
--      costCount    消耗货币数量
--      costId      使用货币类型（默认钻石）
function BuyBatchUi:SetData(data)
    if not data or not data.itemId or not PropsEnum.IsItem(data.itemId) then
        app.log("*** BuyBatchUi:SetInfo 错误的参数:"..table.tostring(data))
        return;
    end 
    
    self.itemId = data.itemId
    self.itemConfig = PublicFunc.IdToConfig(self.itemId)
    self.itemCount = data.itemCount or 1
    self.itemDesc = data.itemDesc or self.itemConfig.description
    self.costCount = data.costCount or 0
    self.costId = data.costId or IdConfig.Crystal

    self.ownCost = PropsEnum.GetValue(self.costId)
    self.counter = 1    -- 选择购买计数
    self.maxCount = math.max(1, math.floor(self.ownCost/self.costCount))

    self:UpdateUi()
end

-- function BuyBatchUi:ResetSlider()
--     if self.slider then
--         self.slider:set_value(0)
--     end
-- end

--初始化
function BuyBatchUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop_buy.assetbundle"
	UiBaseClass.Init(self, data);
end

--初始化数据
function BuyBatchUi:InitData()
	UiBaseClass.InitData(self, data)
end

function BuyBatchUi:DestroyUi()
    if self.smallItemUi then
        self.smallItemUi:DestroyUi()
        self.smallItemUi = nil
    end
    UiBaseClass.DestroyUi(self);
end

--注册方法
function BuyBatchUi:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
	self.bindfunc["on_buy_btn"] = Utility.bind_callback(self, self.on_buy_btn)
    self.bindfunc["on_click_min"] = Utility.bind_callback(self, self.on_click_min)
    self.bindfunc["on_click_max"] = Utility.bind_callback(self, self.on_click_max)
    self.bindfunc["on_slider_value_change"] = Utility.bind_callback(self, self.on_slider_value_change)
end

--初始化UI
function BuyBatchUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("buy_batch_ui")

    local btnClose = ngui.find_button(self.ui, "centre_other/animation/content_di_754_458/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    -----------------------------------购买ui-------------------------------------------
    local objSmallCard = self.ui:get_child_by_name("new_small_card_item")
    self.smallItemUi = UiSmallItem:new({parent = objSmallCard, prop={show_number=false}})

    local path = "centre_other/animation/cont/"

    --商品名称
    self.labName = ngui.find_label(self.ui, path.."lab_name")
    --拥有数量
    self.labOwn = ngui.find_label(self.ui, path.."have/lab_num1")

	--购买
    local btnBuy = ngui.find_button(self.ui, path.."btn1")
    btnBuy:set_on_click(self.bindfunc["on_buy_btn"])

    --购买数量
    self.labBuyCount = ngui.find_label(self.ui, path.."lab_num2")
    --货币图标
    self.spCostIcon = ngui.find_sprite(self.ui, path.."txt/sp")
    --价格
    self.labPrice = ngui.find_label(self.ui, path.."txt/lab")

    --滑动条
    self.slider = ngui.find_slider(self.ui, path.."act/pro_back")
    self.slider:set_on_change(self.bindfunc["on_slider_value_change"])
    
    self.btnMin = ngui.find_button(self.ui, path.."act/btn_red")
    self.btnMinSp = ngui.find_sprite(self.ui, path .. "act/btn_red/sp_red")
    self.btnMax = ngui.find_button(self.ui, path.."act/btn_blue")
    self.btnMaxSp = ngui.find_sprite(self.ui, path .. "act/btn_blue/sp_red")
    self.btnMin:set_on_click(self.bindfunc["on_click_min"])
    self.btnMax:set_on_click(self.bindfunc["on_click_max"])


    self.ui:set_active(false)

    self:UpdateUi()
end

--刷新
function BuyBatchUi:UpdateUi()
    if not self.ui then return end
    if not self.itemId then return end

    self.ui:set_active(true)
    self.slider:set_steps(self.maxCount+1)
    self.slider:set_value(1)

    self:UpdateSliderValue(self.maxCount)
    
    self.smallItemUi:SetDataNumber(self.itemId, 1)

    --名称及描述
    local config = PublicFunc.IdToConfig(self.itemId)
    if config ~= nil and config.name ~= nil then
        self.labName:set_text(config.name)
    end

    self.spCostIcon:set_sprite_name(PublicFunc.GetCostItemSprite(self.costId))

    --拥有数量
    self.labOwn:set_text(tostring(PropsEnum.GetValue(self.itemId)))
end

function BuyBatchUi:UpdateSliderValue(count)
    self.counter = count
    local totalCost = self.costCount * self.counter
    self.labBuyCount:set_text(string.format(_UIText["buy_count"], self.counter))
    self.labPrice:set_text(tostring(totalCost))
    --货币数量文字颜色
    if totalCost > self.ownCost then
        self.labPrice:set_color(1,0,0,1)
    else
        self.labPrice:set_color(1,1,1,1)
    end

    if self.counter >= self.maxCount then
        --PublicFunc.SetButtonShowMode(self.btnMax, 3, "sp_red", "lab_min")
        self.btnMaxSp:set_color(0,0,0,1)
	else
        --PublicFunc.SetButtonShowMode(self.btnMax, 1, "sp_red", "lab_min")
        self.btnMaxSp:set_color(1,1,1,1)
	end 

    if self.counter < 1 then
        --PublicFunc.SetButtonShowMode(self.btnMin, 3, "sp_red", "lab_min")
        self.btnMinSp:set_color(0,0,0,1)
	else
        --PublicFunc.SetButtonShowMode(self.btnMin, 2, "sp_red", "lab_min")
        self.btnMinSp:set_color(1,1,1,1)
	end
end

--购买
function BuyBatchUi:on_buy_btn()
    if self.counter == 0 then
        FloatTip.Float(_UIText["buy_count_0_tips"])
        return
    end
    if self.ownCost < self.costCount * self.counter then
        local config = ConfigManager.Get(EConfigIndex.t_item, self.costId)
        local str = string.format(_UIText["not_enough_cost"], config.name)
        FloatTip.Float(str)
        return
    end

    self:Hide()

    if self.callback then
        local data = {}
        data.itemId = self.itemId
        data.totalCount = self.itemCount * self.counter
        data.totalCost = self.costCount * self.counter
        data.costId = self.costId
        Utility.CallFunc(self.callback, self.callParam, data)

        self.callback = nil
        self.callParam = nil
        self.itemId = nil
    end
end

function BuyBatchUi:on_click_min(t)
    local value = self.slider:get_value()
    if value <= 0 then return end
    value = value - 1/(self.maxCount - 1)
    self.slider:set_value(value)
end

function BuyBatchUi:on_click_max(t)
    local value = self.slider:get_value()
    if value >= 1 then return end
    value = value + 1/(self.maxCount - 1)
    self.slider:set_value(value)
end

function BuyBatchUi:on_close()
	self:Hide()
end

function BuyBatchUi:on_slider_value_change(value)
    local count = PublicFunc.Round(value * self.maxCount)
	self:UpdateSliderValue(count)
end

