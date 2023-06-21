
ShopSellItemUI = Class('ShopSellItemUI', UiBaseClass)

function ShopSellItemUI.Start()
    if not GuideManager.IsGuideRuning() then
        local _dataList, _canGetGold = g_dataCenter.shopInfo:GetSellItemData()
        if #_dataList > 0 then
            if ShopSellItemUI.cls == nil then
                ShopSellItemUI.cls = ShopSellItemUI:new({dataList = _dataList, canGetGold = _canGetGold})
            end
        end
    end
end

function ShopSellItemUI.End()
    if ShopSellItemUI.cls then
        ShopSellItemUI.cls:DestroyUi()
        ShopSellItemUI.cls = nil
    end
end

--初始化
function ShopSellItemUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop_chushou.assetbundle"    
	UiBaseClass.Init(self, data);
end

--初始化数据
function ShopSellItemUI:InitData(data)
    self.dataList = data.dataList
    self.canGetGold = data.canGetGold
    self.smallItemUi = {} 
	UiBaseClass.InitData(self, data)
end

function ShopSellItemUI:DestroyUi() 
    for _, items in pairs(self.smallItemUi) do
        for _, it in pairs(items) do
            if it then
                it:DestroyUi();
                it = nil;
            end
	    end
	end   
    UiBaseClass.DestroyUi(self);
end

--注册方法
function ShopSellItemUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["to_exchange"] = Utility.bind_callback(self, self.to_exchange)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
end

--初始化UI
function ShopSellItemUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("shop_sell_item_ui") 

    local btnClose = ngui.find_button(self.ui, "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])
    
    local path = "center_other/animation/cont/" 
    local btnConfirm = ngui.find_button(self.ui, path .. "btn_right")
    btnConfirm:set_on_click(self.bindfunc["to_exchange"])
    
    self.scrollView = ngui.find_scroll_view(self.ui, path .. "scro_view/panel")
    self.wrapContent = ngui.find_wrap_content(self.ui, path .. "scro_view/panel/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])
            
    self.lblGold = ngui.find_label(self.ui, path .. 'lab_num') 
    
    self:UpdateUi()
end

function ShopSellItemUI:on_close()
    ShopSellItemUI.End()
end

--[[刷新UI]]
function ShopSellItemUI:UpdateUi()
    local count = #self.dataList
    self.wrapContent:set_min_index(- math.ceil(count / 5) + 1);
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position() 
    --
    self.lblGold:set_text(tostring(self.canGetGold))
end

function ShopSellItemUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)
    local row = math.abs(b) + 1    

    for i = 1, 5 do 
        local objItem = obj:get_child_by_name("new_small_card_item" .. i)
        local pos = index * 5 + i
        local data = self.dataList[pos]
        if data ~= nil then
            objItem:set_active(true)
            self:SetItemData(objItem, data, row, i)
        else
            objItem:set_active(false)
        end
    end
end

function ShopSellItemUI:SetItemData(item, data, row, i)    
    --small card item
    if self.smallItemUi[row] == nil then
        self.smallItemUi[row] = {}
    end
    local itemUi = self.smallItemUi[row][i]  
    if itemUi == nil then   
        itemUi = UiSmallItem:new({obj = nil, parent = item, cardInfo = nil, delay = 500})
        itemUi:SetEnablePressGoodsTips(true)
        self.smallItemUi[row][i] = itemUi
    end
    itemUi:SetDataNumber(data.item_id, data.item_count)    
end


--[[兑换]]
function ShopSellItemUI:to_exchange()
    local ids = {}
    for k, v in pairs(self.dataList) do
        ids[k] = v.id
    end
    self:on_close()
    GLoading.Show(GLoading.EType.msg) 
    msg_shop.cg_sell_item_for_sell(ids)
end