

VIPGiftBagSelectNumUI = Class("VIPGiftBagSelectNumUI", UiBaseClass)

local _uiText = 
{
    [1] = "数量:%d",
}

function VIPGiftBagSelectNumUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1138_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function VIPGiftBagSelectNumUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.iconParent = self.ui:get_child_by_name("new_small_card_item")
    self.nameLabel = ngui.find_label(self.ui, "lab_name")
    self.desLabel = ngui.find_label(self.ui, "lab_num1")
    self.numLabel = ngui.find_label(self.ui, "lab_num2")
    self.totalPriceLabel = ngui.find_label(self.ui, "txt/lab")
    self.costIconSprite = ngui.find_sprite(self.ui, "txt/sp")

    self.minBtn = ngui.find_button(self.ui, "btn_red")
    self.minBtnSp = ngui.find_sprite(self.ui, "btn_red/sp_red")
    self.maxBtn = ngui.find_button(self.ui, "btn_blue")
    self.maxBtnSp = ngui.find_sprite(self.ui, "btn_blue/sp_red")
    self.sliderBar = ngui.find_slider(self.ui, "pro_back")
    self.closeBtn = ngui.find_button(self.ui, "btn_cha")
    self.buyBtn = ngui.find_button(self.ui, "btn1")


    self.minBtn:set_on_click(self.bindfunc["OnClickMinBtn"])
    self.maxBtn:set_on_click(self.bindfunc["OnClickMaxBtn"])
    self.buyBtn:set_on_click(self.bindfunc["OnClickBuyBtn"])
    self.closeBtn:set_on_click(self.bindfunc["OnClickCloseBtn"])
    self.sliderBar:set_on_change(self.bindfunc["OnSliderValueChanged"])

    self:UpdateUI()
end

function VIPGiftBagSelectNumUI:DestroyUi()
    if self.iconSmallItemUi then
        self.iconSmallItemUi:DestroyUi()
        self.iconSmallItemUi = nil
    end

     UiBaseClass.DestroyUi(self)
end

function VIPGiftBagSelectNumUI:UpdateUI()
    local data = self:GetInitData()

    self.vip = data.vip
    local config = ConfigManager.Get(EConfigIndex.t_vip_gift_bag, self.vip)
    self.price = config.discount_price

    local cardinfo = CardProp:new( { number = config.gift_bag_id})
    self.nameLabel:set_text(cardinfo.name)
    self.desLabel:set_text(cardinfo.description)

    self.iconSmallItemUi = UiSmallItem:new({parent = self.iconParent, is_enable_goods_tip = true, delay = 0, 
        cardInfo = cardinfo, prop = {show_number = false}})

    self.costIconSprite:set_sprite_name("dh_hongshuijing")

    self.totalCount = data.count
    self.currentCount = self.totalCount

    self.sliderBar:set_steps(self.totalCount)

    self:SetSliderContent()
end

function VIPGiftBagSelectNumUI:SetSliderContent(fromSlider)
    --self.progressLabel:set_text(string.format("%d/%d", self.currentCount, self.totalCount))
    self.numLabel:set_text(string.format(_uiText[1], self.currentCount))
    self.totalPriceLabel:set_text(tostring(self.currentCount * self.price))
    if not fromSlider then
        self.sliderBar:set_value((self.currentCount - 1)/(self.totalCount - 1))
    end
end

function VIPGiftBagSelectNumUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickBuyBtn"]     = Utility.bind_callback(self, self.OnClickBuyBtn)
    self.bindfunc["OnClickCloseBtn"]    = Utility.bind_callback(self, self.OnClickCloseBtn)
    self.bindfunc["OnClickMinBtn"]    = Utility.bind_callback(self, self.OnClickMinBtn)
    self.bindfunc["OnClickMaxBtn"]    = Utility.bind_callback(self, self.OnClickMaxBtn)
    self.bindfunc["OnSliderValueChanged"]    = Utility.bind_callback(self, self.OnSliderValueChanged)
end

function VIPGiftBagSelectNumUI:OnClickBuyBtn()
    msg_activity.cg_vip_gift_buy(self.vip, self.currentCount)
    self:OnClickCloseBtn()
end

function VIPGiftBagSelectNumUI:OnClickCloseBtn()
    uiManager:PopUi()
end

function VIPGiftBagSelectNumUI:OnClickMinBtn()
    if self.currentCount <= 1 then return end

    self.currentCount = self.currentCount - 1

    self:SetSliderContent()
end

function VIPGiftBagSelectNumUI:OnClickMaxBtn()
    if self.currentCount >= self.totalCount then return end

    self.currentCount = self.currentCount + 1
    
    self:SetSliderContent()
end

function VIPGiftBagSelectNumUI:OnSliderValueChanged(value)
    local step = 1/(self.totalCount - 1)
    self.currentCount = value/step + 1

    self:SetSliderContent(true)

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
