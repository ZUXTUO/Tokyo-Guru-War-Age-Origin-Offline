ExchangeActivitySelectNumUi = Class("ExchangeActivitySelectNumUi", UiBaseClass)

function ExchangeActivitySelectNumUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1136_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function ExchangeActivitySelectNumUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.exchangeItemNode = {}
    self.exchangeItemGrid = ngui.find_grid(self.ui, 'center/grid')
    for i = 1, 3 do
        local info = {}
        info.node = self.ui:get_child_by_name("new_small_card_item" .. i)
        info.node:set_active(false)
        self.exchangeItemNode[i] = info
    end
    self.exchangeAfterItemNode = self.ui:get_child_by_name("new_small_card_item4")
    self.progressLabel = ngui.find_label(self.ui, "lab_num")
    self.minBtn = ngui.find_button(self.ui, "btn_red")
    self.minBtnSp = ngui.find_sprite(self.ui, "btn_red/sp_red")
    self.maxBtn = ngui.find_button(self.ui, "btn_blue")
    self.maxBtnSp = ngui.find_sprite(self.ui, "btn_blue/sp_red")
    self.sliderBar = ngui.find_slider(self.ui, "pro_back")
    self.exchangeBtn = ngui.find_button(self.ui, "btn")
    self.closeBtn = ngui.find_button(self.ui, "btn_cha")


    self.closeBtn:set_on_click(self.bindfunc["OnClickClose"])
    self.exchangeBtn:set_on_click(self.bindfunc["OnClickExchange"])
    self.minBtn:set_on_click(self.bindfunc["OnClickMinBtn"])
    self.maxBtn:set_on_click(self.bindfunc["OnClickMaxBtn"])
    self.sliderBar:set_on_change(self.bindfunc["OnSiderValueChange"])

    self:UpdateUi()
end

function ExchangeActivitySelectNumUi:DestroyUi()
    if self.exchangeAfterSmallItemUi then
        self.exchangeAfterSmallItemUi:DestroyUi()
        self.exchangeAfterSmallItemUi = nil
    end

    if self.exchangeItemNode then
        for k,v in ipairs(self.exchangeItemNode) do
            if v.smallItemUi then
                v.smallItemUi:DestroyUi()
            end
        end
        self.exchangeItemNode = nil
    end

    UiBaseClass.DestroyUi(self)
end

function ExchangeActivitySelectNumUi:UpdateUi()
    local data = self:GetInitData()
    local config = data.config[data.id]
    if config == nil then return end

    for i = 1, 3 do
        local idNum = config.need_items[i]
        if idNum == nil then break end
        local info = self.exchangeItemNode[i]
        info.node:set_active(true)
        info.smallItemUi = UiSmallItem:new({parent = info.node, is_enable_goods_tip = true, delay = 0})
        info.smallItemUi:SetDataNumber(idNum.id, idNum.count)
    end
    self.exchangeAfterSmallItemUi = UiSmallItem:new({parent = self.exchangeAfterItemNode, is_enable_goods_tip = true, delay = 0})
    local exchangedIdNum = config.have_items[1]
    self.exchangeAfterSmallItemUi:SetDataNumber(exchangedIdNum.id, exchangedIdNum.count)

    self.totalCount = data.count
    self.currentCount = self.totalCount

    self.sliderBar:set_steps(self.totalCount)

    self:SetProgressContent()

    self.exchangeItemGrid:reposition_now()
end

function ExchangeActivitySelectNumUi:SetProgressContent(fromSlider)
    self.progressLabel:set_text(string.format("%d/%d", self.currentCount, self.totalCount))
    if not fromSlider then
        self.sliderBar:set_value((self.currentCount - 1)/(self.totalCount - 1))
    end
end

function ExchangeActivitySelectNumUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickClose"]     = Utility.bind_callback(self, self.OnClickClose)
    self.bindfunc["OnClickExchange"]     = Utility.bind_callback(self, self.OnClickExchange)
    self.bindfunc["OnClickMinBtn"]     = Utility.bind_callback(self, self.OnClickMinBtn)
    self.bindfunc["OnClickMaxBtn"]     = Utility.bind_callback(self, self.OnClickMaxBtn)
    self.bindfunc["OnSiderValueChange"] = Utility.bind_callback(self, self.OnSiderValueChange)
end

function ExchangeActivitySelectNumUi:OnClickClose()
    uiManager:PopUi()
end

function ExchangeActivitySelectNumUi:OnClickExchange()

    local data = self:GetInitData()

    msg_activity.cg_exchange_item_exchange(data.id, self.currentCount, data.activityid)

    self:OnClickClose()
end

function ExchangeActivitySelectNumUi:OnClickMinBtn()
    if self.currentCount <= 1 then return end

    self.currentCount = self.currentCount - 1

    self:SetProgressContent()
end

function ExchangeActivitySelectNumUi:OnClickMaxBtn()

    if self.currentCount >= self.totalCount then return end

    self.currentCount = self.currentCount + 1
    
    self:SetProgressContent()
end

function ExchangeActivitySelectNumUi:OnSiderValueChange(value)
    --app.log("OnSiderValueChange " .. value)
    local step = 1/(self.totalCount - 1)
    self.currentCount = value/step + 1

    self:SetProgressContent(true)

    if self.currentCount <= 1 then
        self.minBtnSp:set_color(0, 0, 0, 1)
    else
        self.minBtnSp:set_color(1, 1, 1, 1)
    end

    if self.currentCount >= self.totalCount then
        self.maxBtnSp:set_color(0, 0, 0, 1)
    else
        self.maxBtnSp:set_color(1, 1, 1, 1)
    end
end