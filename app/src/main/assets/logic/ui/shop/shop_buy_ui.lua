
ShopBuyUI = Class('ShopBuyUI', UiBaseClass)

function ShopBuyUI.Start(data)
    if ShopBuyUI.cls == nil then
        ShopBuyUI.cls = ShopBuyUI:new(data)
    end
end

function ShopBuyUI.End()
    if ShopBuyUI.cls then
        ShopBuyUI.cls:DestroyUi()
        ShopBuyUI.cls = nil
    end
end

local _UIText = {
    [1] = "拥有数量   ", -- 废弃
    [2] = "物品购买",
    [3] = "数量不足", 
	[4] = "购买",
	[5] = "售罄", 
    [6] = "购买1件:",   -- 废弃
    [7] = "好感%s-%s可购买"
}

--初始化
function ShopBuyUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop_window.assetbundle"
	UiBaseClass.Init(self, data);
end

--初始化数据
function ShopBuyUI:InitData(data)
    self.data = data.buyData
	UiBaseClass.InitData(self, data)
end

function ShopBuyUI:DestroyUi()
    if self.smallItemUi then
        self.smallItemUi:DestroyUi()
        self.smallItemUi = nil
    end
    -- if self.roleInfo then
    --     self.roleInfo:DestroyUi()
    --     self.roleInfo = nil
    -- end
    UiBaseClass.DestroyUi(self);
end

--注册方法
function ShopBuyUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
	self.bindfunc["to_exchange"] = Utility.bind_callback(self, self.to_exchange)
    self.bindfunc["show_hero_desc"] = Utility.bind_callback(self, self.show_hero_desc)
end

--初始化UI
function ShopBuyUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("shop_buy_ui") 

    local btnClose = ngui.find_button(self.ui, "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    local path = "center_other/animation/cont/"

    local objSmallCard = self.ui:get_child_by_name(path .."new_small_card_item")
    self.smallItemUi = UiSmallItem:new({obj = nil, parent = objSmallCard, cardInfo = nil, delay = 500})

    --名称及描述
    self.lblName = ngui.find_label(self.ui, path .. "lab_name")
    self.lblDesc = ngui.find_label(self.ui, path .. "lab2")
    self.lblHaveNum = ngui.find_label(self.ui, path .. "lab1/lab_num1")

    --货币及价格
    self.spMoneyType = ngui.find_sprite(self.ui, path .. "txt/sp")
    self.lblPriceNum = ngui.find_label(self.ui, path .. "txt/lab")
    -- local lblTxt = ngui.find_label(self.ui, path .. "txt")
    -- lblTxt:set_text(_UIText[6])

    --购买
    self.btnBuy = ngui.find_button(self.ui, path .. "btn2")
    self.btnBuy:set_on_click(self.bindfunc["to_exchange"])   
	self.lblBuy = ngui.find_label(self.ui, path .. "btn2/animation/lab")

    self.btnRoleInfo = ngui.find_button(self.ui, path .. "btn_rule")

    self:SetInfo(self.data)
end

--[[显示弹窗及购买界面]]
function ShopBuyUI:SetInfo(data)
    self.shopItemId = data.itemConfig.id

    self.sellPriceNum = data.itemConfig.sell_price_num
    self.sellPriceId = data.itemConfig.sell_price_item_id
    self.vipLvl = data.itemConfig.vip_level

    self.data = data
        
    -- self.lblTitle:set_text(_UIText[2])

    if self.roleInfo then   
        self.roleInfo:Hide()
        self.roleInfo:DestroyUi()
        self.roleInfo = nil
    end
    self:UpdateUi(data)
end

--[[刷新UI]]
function ShopBuyUI:UpdateUi(data)
    --small icon
    self.smallItemUi:SetDataNumber(data.itemConfig.item_id, data.itemConfig.num)

    --名称及描述
    local info = PublicFunc.IdToConfig(data.itemConfig.item_id)
    if info ~= nil and info.name ~= nil then
        self.lblName:set_text(info.name)
    end
    self.lblDesc:set_text(data.itemConfig.describe) 
    self.lblHaveNum:set_text(tostring(PropsEnum.GetValue(data.itemConfig.item_id)))

    --货币及价格   
    self.spMoneyType:set_sprite_name(g_dataCenter.shopInfo:GetSpriteName(self.sellPriceId) or "")    
    local currNum = PropsEnum.GetValue(self.sellPriceId)
    if currNum < self.sellPriceNum then
        self.lblPriceNum:set_text(" [ff0000]" .. tostring(self.sellPriceNum) .. '[-]')
    else
        self.lblPriceNum:set_text(" " .. tostring(self.sellPriceNum))
    end

    if PropsEnum.IsRoleSoul(data.itemConfig.item_id) then
        self.btnRoleInfo:set_active(true)
        self.btnRoleInfo:set_on_click(self.bindfunc["show_hero_desc"]) 
        self.btnRoleInfo:set_event_value(tostring(data.itemConfig.item_id), 0)
    else
        self.btnRoleInfo:set_active(false)
    end
	
	if self:CanExchangeItem(self.data) then		
		self.lblBuy:set_text(_UIText[4])
		self.btnBuy:set_enable(true)
	else		
		self.lblBuy:set_text(_UIText[5])
		self.btnBuy:set_enable(false)
	end
end

--[[检查可购买]]
function ShopBuyUI:CanExchangeItem(data)
    return data.canBuyTimes ~= 0
end

function ShopBuyUI:show_hero_desc(t)
    local itemId = tonumber(t.string_value)
    local itemConfig = ConfigManager.Get(EConfigIndex.t_item, itemId)
    if itemConfig and tonumber(itemConfig.hero_number) ~= 0 then
        local cardInfo = g_dataCenter.package:find_card_for_num(1, itemConfig.hero_number)
        if cardInfo == nil then
            cardInfo = CardHuman:new({number = itemConfig.hero_number, isNotCalProperty = true})
        end
        local data = 
        {
            info = cardInfo,
            isPlayer = true,
            heroDataList = {}
        }
        --self.roleInfo = BattleRoleInfoUI:new(data)
        self:on_close()
        uiManager:PushUi(EUI.BattleRoleInfoUI,data)
    end
end

--[[兑换]]
function ShopBuyUI:to_exchange()
    if not self:CanExchangeItem(self.data) then
        return
    end
    --vip等级
    if g_dataCenter.player:GetVip() < self.vipLvl then
        local vipConfig = ConfigManager.Get(EConfigIndex.t_vip_data, self.vipLvl)
        FloatTip.Float(string.format(_UIText[7], vipConfig.level, vipConfig.level_star))
        return
    end

    --玩家身上的物品数量
    local currNum = PropsEnum.GetValue(self.sellPriceId)                
    if currNum < self.sellPriceNum then                
        local info = PublicFunc.IdToConfig(self.sellPriceId)
        if info ~= nil and info.name ~= nil then
            FloatTip.Float(info.name .. _UIText[3])
        end 
        return
    end    
    self:on_close()
    msg_shop.cg_buy_shop_item(self.shopItemId)
end

function ShopBuyUI:on_close()
	ShopBuyUI.End()
end