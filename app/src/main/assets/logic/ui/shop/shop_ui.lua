
ShopUI = Class("ShopUI", UiBaseClass)

local _UIText = {
    [1] = "购买成功",
    [2] = "已达刷新次数上限", 
    [3] = "装备宝箱",
    [4] = "距离新货出现还有",
    [5] = "剩余时间:",
    [6] = "获得%s金币",
    [7] = "好感%s-%s开启",
}

local _MaxCount = 4

-------------------------------------外部调用-------------------------------------
function ShopUI:ShowNavigationBar()
    return true
end


function ShopUI:Init(data)
    self.shopId = data
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_exchange.assetbundle"
	UiBaseClass.Init(self, data);
end

function ShopUI:Show()
    if not UiBaseClass.Show(self) then
        return
    end
    --选中
    self:SelectdTab()
end

function ShopUI:Restart(data)
    self.grid = nil
    self.shopId = data
    self.shopInfo = g_dataCenter.shopInfo   
    self.dtAdd = 0
    self.lastPosX = 0
    self.isMoving = false

    self.yekaList = {}
    self.smallItemUi = {}
    self.isFirst = true

    local isEnabled = self.shopInfo:CheckShopIsEnabled(ENUM.ShopID.SUNDRY)
    if isEnabled then
        self.rarityMaterial = self.shopInfo:GetFormationHeroRarityMaterial()
    end
	if UiBaseClass.Restart(self, data) then        
	end
end

function ShopUI:InitData(data)
	UiBaseClass.InitData(self, data)
    --order为开启等级
    self.cfgData = {}
    table.insert(self.cfgData, {id=ENUM.ShopID.EquipBox, name=_UIText[3], order=-1})
    local openLevel = nil
    for i, data in ipairs(ConfigManager._GetConfigTable(EConfigIndex.t_shop)) do
        if type(data.open_limit) == "table" then
            openLevel = data.open_limit[2] or 0
        else
            openLevel = 0
        end
        table.insert(self.cfgData, {id=data.id, name=data.name, order=openLevel})
    end
    table.sort(self.cfgData, function(a, b)
        return a.order < b.order        
    end)

    self.objMystery = nil
end

function ShopUI:DestroyUi()
    if self.yekaList then
        self.yekaList = nil
    end
    if self.smallItemUi then
        for _, items in pairs(self.smallItemUi) do
            for __, it in pairs(items) do
                it:DestroyUi();
            end
        end
        self.smallItemUi = nil
    end

    if self.clsEquipBox then
        self.clsEquipBox:DestroyUi()
        self.clsEquipBox = nil
    end

    self.moveTargetX = nil
    self.isMoving = false
    self.lastPosX = 0
    self.rarityMaterial = nil

    ShopSellItemUI.End()   
    ShopBuyUI.End() 
    UiBaseClass.DestroyUi(self);
end

function ShopUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_select_tab"] = Utility.bind_callback(self, self.on_select_tab) 
    self.bindfunc["exchange_popup_info"] = Utility.bind_callback(self, self.exchange_popup_info) 

    self.bindfunc["update_shop_ui"] = Utility.bind_callback(self, self.update_shop_ui)
    self.bindfunc["after_buy_update_shop_ui"] = Utility.bind_callback(self, self.after_buy_update_shop_ui)
    --手动刷新商店
    self.bindfunc["refresh_shop"] = Utility.bind_callback(self, self.refresh_shop)  
    self.bindfunc["on_left_page"] = Utility.bind_callback(self, self.on_left_page)  
    self.bindfunc["on_right_page"] = Utility.bind_callback(self, self.on_right_page) 
    self.bindfunc["on_drag_start"] = Utility.bind_callback(self, self.on_drag_start)

    self.bindfunc["hide_mystery_shop"] = Utility.bind_callback(self, self.hide_mystery_shop)
    self.bindfunc["update_shop_gold"] = Utility.bind_callback(self, self.update_shop_gold)

    self.bindfunc["OnPressTips1"] = Utility.bind_callback(self, self.OnPressTips1)
    self.bindfunc["OnPressTips1_2"] = Utility.bind_callback(self, self.OnPressTips1_2)
    self.bindfunc["OnPressTips2"] = Utility.bind_callback(self, self.OnPressTips2)
    self.bindfunc["gc_shop_item_info"] = Utility.bind_callback(self, self.gc_shop_item_info)
end

--注册消息分发回调函数
function ShopUI:MsgRegist()
	UiBaseClass.MsgRegist(self)    
    PublicFunc.msg_regist(msg_shop.gc_shop_item_info, self.bindfunc['gc_shop_item_info'])
    PublicFunc.msg_regist(msg_shop.gc_buy_shop_item, self.bindfunc['after_buy_update_shop_ui'])
    PublicFunc.msg_regist(msg_shop.mystery_shop_close, self.bindfunc['hide_mystery_shop'])
    PublicFunc.msg_regist(msg_shop.gc_sell_item_for_sell, self.bindfunc['update_shop_gold'])
end

--注销消息分发回调函数
function ShopUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_shop.gc_shop_item_info, self.bindfunc['gc_shop_item_info'])
    PublicFunc.msg_unregist(msg_shop.gc_buy_shop_item, self.bindfunc['after_buy_update_shop_ui'])
    PublicFunc.msg_unregist(msg_shop.mystery_shop_close, self.bindfunc['hide_mystery_shop'])
    PublicFunc.msg_unregist(msg_shop.gc_sell_item_for_sell, self.bindfunc['update_shop_gold'])
end

--初始化UI
function ShopUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    --AudioManager.PlayUiAudio(ENUM.EUiAudioType.ShopMoney)
    self.ui:set_name("shop_ui")

    local aniPath = "centre_other/animation/"

    local panelPath = aniPath .. "scroll_view/panel_list"
    self.scrollView = ngui.find_scroll_view(self.ui, panelPath)
    self.wrapContent = ngui.find_wrap_content(self.ui, panelPath .. "/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self.scrollView:set_on_drag_started(self.bindfunc['on_drag_start'])
    self.wrapItemWidth = self.wrapContent:get_item_size()

    self.btnLeft = ngui.find_button(self.ui, aniPath .. "btn_left")
    self.btnRight = ngui.find_button(self.ui, aniPath .. "btn_right")
    self.btnLeft:set_on_click(self.bindfunc["on_left_page"])
    self.btnRight:set_on_click(self.bindfunc["on_right_page"])

    self.gridTab = ngui.find_grid(self.ui, aniPath .. "sco_view/panel/grid")
    local objGridTab = self.gridTab:get_game_object()
    local cloneYeka = self.ui:get_child_by_name(aniPath .. "grid/yeka1")
    cloneYeka:set_active(false)

    --商店页卡
    for i, v in ipairs(self.cfgData) do
        local yekaItem = {}
        self.yekaList[i] = yekaItem

        yekaItem.obj = cloneYeka:clone()
        yekaItem.obj:set_parent(objGridTab)
        yekaItem.obj:set_name("shop_tab_" .. i)

        yekaItem.obj:set_active(true)
        local btnTab = ngui.find_button(yekaItem.obj, "shop_tab_" .. i)
        btnTab:reset_on_click()
        btnTab:set_event_value("", v.id)
        btnTab:set_on_click(self.bindfunc["on_select_tab"], "MyButton.Flag")

        -- local spPrompt = ngui.find_sprite(yekaItem.obj, "sp_point")
        -- spPrompt:set_active(false)

        yekaItem.spFocus = ngui.find_sprite(yekaItem.obj, "sp")
        yekaItem.spNormal = ngui.find_sprite(yekaItem.obj, "sp_hui")
        yekaItem.spPoint = ngui.find_sprite(yekaItem.obj, "sp_point")
        yekaItem.spPoint:set_active(false)

        --商店名
        yekaItem.labNameFocus = ngui.find_label(yekaItem.obj, "lab")
        yekaItem.labNameNormal = ngui.find_label(yekaItem.obj, "lab_hui")

        yekaItem.labNameFocus:set_text(v.name)
        yekaItem.labNameNormal:set_text(v.name)

        yekaItem.toggle = ngui.find_toggle(yekaItem.obj, yekaItem.obj:get_name())

        --神秘商店
        if v.id == ENUM.ShopID.MYSTERY then
            self.objMystery = yekaItem.obj
        end
        if v.id == ENUM.ShopID.SUNDRY then
            self.spPointSundry = yekaItem.spPoint
        end
    end
    self:UpdateShopState()

    --货币及时间面板
    local panelBkPath1 = "centre_other/animation/content1/"
    self.nodePanelBk1 = self.ui:get_child_by_name(panelBkPath1)

    self.nodeRefreshCost = self.ui:get_child_by_name(panelBkPath1 .. "sp_gem")
    self.labRefreshCost = ngui.find_label(self.ui, panelBkPath1 .. "lab")
    self.btnRefresh = ngui.find_button(self.ui, panelBkPath1 .. "btn")
    self.btnRefresh:reset_on_click()
    self.btnRefresh:set_on_click(self.bindfunc["refresh_shop"]) 
    self.btnRefresh:set_active(false)

    self.lblInfo = ngui.find_label(self.ui, panelBkPath1 .. "txt")
    self.spMoney = ngui.find_sprite(self.ui, panelBkPath1 .. "sp_di2/sp_gold")                
    self.lblMoney = ngui.find_label(self.ui, panelBkPath1 .. "sp_di2/lab")
    self.spMoney2 = ngui.find_sprite(self.ui, panelBkPath1 .. "sp_di3/sp_gold")
    self.lblMoney2 = ngui.find_label(self.ui, panelBkPath1 .. "sp_di3/lab")

    self.lblShopRefreshTime = ngui.find_label(self.ui, panelBkPath1 .. "lab_time")
    self.lblShopRefreshTime:set_text("")
    local btnShopMoney = ngui.find_button(self.ui, panelBkPath1 .. "sp_di2")
    btnShopMoney:set_on_ngui_press(self.bindfunc["OnPressTips1"]);
    self.btnShopMoney2 = ngui.find_button(self.ui, panelBkPath1 .. "sp_di3")
    self.btnShopMoney2:set_on_ngui_press(self.bindfunc["OnPressTips1_2"]);

    --装备宝箱底部面板
    local panelBkPath2 = "centre_other/animation/content2/"
    self.nodePanelBk2 = self.ui:get_child_by_name(panelBkPath2)
    local btnEquipDebris = ngui.find_button(self.ui, panelBkPath2 .. "sp_di2")
    btnEquipDebris:set_on_ngui_press(self.bindfunc["OnPressTips2"]);

    local objView = self.ui:get_child_by_name( "panel_equip_box_item" );
    self.clsEquipBox = EquipBoxUI:new({parent = objView, down = self.nodePanelBk2});
    self.clsEquipBox:Hide()

    self:LoadShopData(false)
    self:SelectdTab()

    self:update_shop_ui()

    --请求数据显示小红点
    msg_shop.cg_shop_item_info(ENUM.ShopID.SUNDRY)

    ShopSellItemUI.Start()
end

function ShopUI:gc_shop_item_info(_shopId)
    --更新好感商店页卡
    if _shopId == ENUM.ShopID.VIP then
        local isEnabled = self.shopInfo:CheckShopIsEnabled(_shopId)
        if isEnabled then
            self:UpdateShopState()
        else
            return
        end
    end
    if self.shopId == _shopId then
        self:update_shop_ui()
    end
    --更新小红点
    if self.isFirst then
        self.isFirst = false
        self:UpdateYekaPoint(true)
    else
        self:UpdateYekaPoint()
    end
end

function ShopUI:UpdateYekaPoint(flag)
    if not AppConfig.get_enable_guide_tip() then
        return
    end
    if self.shopId == ENUM.ShopID.SUNDRY or flag then
        if self.spPointSundry and self.rarityMaterial then
            self.spPointSundry:set_active(self.shopInfo:IsShowSundryShopTip(self.rarityMaterial))
        end
    end
    if self.shopId == ENUM.ShopID.EquipBox or flag then
        if self.yekaList[1] then
            self.yekaList[1].spPoint:set_active(GuideTipData.GetRedCount(Gt_Enum.EMain_Shop_OpenFirstBtn) > 0)
        end
    end
end

--[[商店是否显示]]
function ShopUI:UpdateShopState()
    local startItem, endItem, curItem = nil, nil, nil
    for i, v in ipairs(self.cfgData) do
        curItem = self.yekaList[i]
        --商店开启判断
        local isEnabled = self.shopInfo:CheckShopIsEnabled(v.id)
        curItem.obj:set_active(isEnabled)


        if isEnabled then
            if startItem == nil then
                startItem = curItem
            else
                endItem = curItem

                curItem.spFocus:set_sprite_name("ty_anniu8")
                curItem.spNormal:set_sprite_name("ty_anniu9")
            end
        end
    end

    if startItem then
        startItem.spFocus:set_sprite_name("ty_anniu1")
        startItem.spNormal:set_sprite_name("ty_anniu2")
    end

    if endItem then
        endItem.spFocus:set_sprite_name("ty_anniu6")
        endItem.spNormal:set_sprite_name("ty_anniu7")
    end

    self.gridTab:reposition_now()
end

--[[隐藏神秘商店]]
function ShopUI:hide_mystery_shop()
    self.objMystery:set_active(false)
    self.gridTab:reposition_now()
    if self.shopId == ENUM.ShopID.MYSTERY then
        self:on_select_tab({float_value = ENUM.ShopID.EquipBox})
        self:SelectdTab()
    end
end

--[[获取商店数据]]
function ShopUI:LoadShopData(direct)
    if self.shopId == ENUM.ShopID.EquipBox then
        return false
    end
    if not self.shopInfo:IsLoadData(self.shopId) or direct then
        msg_shop.cg_shop_item_info(self.shopId)
        return true
    end
    return false
end

--[[选中页卡]]
function ShopUI:SelectdTab()
    for i, v in pairs(self.yekaList) do
        if v.toggle then
            v.toggle:set_value(self.shopId == self.cfgData[i].id)
        end
    end
end

--[[商店切换]]
function ShopUI:on_select_tab(t)
    if t.float_value ~= self.shopId then
        self.shopId = t.float_value
        if self.shopId == ENUM.ShopID.EquipBox then
            self:update_shop_ui()
        else
            --请求数据
            if not self:LoadShopData(false) then
                self:update_shop_ui()
            end
        end
    end
end

--[[商店购买货币面板]]
function ShopUI:UpdateMontyTypePanel()
    local mType, mType2 = self.shopInfo:GetMoneyType(self.shopId)
    if mType ~= nil then
        local name = self.shopInfo:GetSpriteName(mType)
        if name ~= nil then
            self.spMoney:set_sprite_name(name)
        end
        local currNum = PropsEnum.GetValue(mType)
        self.lblMoney:set_text(PublicFunc.NumberToStringByCfg(currNum))

        --第二货币
        self.btnShopMoney2:set_active(mType2 ~= nil)
        if mType2 then
            name = self.shopInfo:GetSpriteName(mType2)
            if name ~= nil then
                self.spMoney2:set_sprite_name(name)
            end
            currNum = PropsEnum.GetValue(mType2)
            self.lblMoney2:set_text(PublicFunc.NumberToStringByCfg(currNum))
        end

        --[[local desc = ConfigManager.Get(EConfigIndex.t_shop, self.shopId).money_type_desc
        if desc then
            self.lblDesc:set_text(desc)
        else
            app.log("config error")
        end]]
    end
    if self.shopId == ENUM.ShopID.MYSTERY then
        self.lblInfo:set_text(_UIText[5])
    else
        self.lblInfo:set_text(_UIText[4])
    end
end

function ShopUI:on_drag_start()
    self.moveTargetX = nil
end

function ShopUI:on_left_page(t)
    if self.isMoving then return end

    local x, y, z = self.scrollView:get_position()
    local cols = math.ceil(self.shopInfo:GetShopItemCount(self.shopId) / 2)
    local totalPage = math.ceil(cols / _MaxCount)
    local curPage = 0
    if x < 0 then
        local absX = -x
        curPage = math.floor(absX / (_MaxCount * self.wrapItemWidth))
        -- 在分页交界一定范围认为可以翻页
        if math.mod(absX, (_MaxCount*self.wrapItemWidth)) < 10 then
            curPage = math.max(0, curPage - 1)
        end
    end

    self.moveTargetX = -self.wrapItemWidth * _MaxCount * curPage
end

function ShopUI:on_right_page(t)
    if self.isMoving then return end

    local x, y, z = self.scrollView:get_position()
    local cols = math.ceil(self.shopInfo:GetShopItemCount(self.shopId) / 2)
    local totalPage = math.ceil(cols / _MaxCount)
    local curPage = 0
    if x < 0 then
        local absX = -x
        curPage = math.floor(absX / (_MaxCount * self.wrapItemWidth))
        -- 在分页交界一定范围认为可以翻页
        if _MaxCount*self.wrapItemWidth - math.mod(absX, (_MaxCount*self.wrapItemWidth)) < 10 then
            curPage = math.min(totalPage - 1, curPage + 1)
        end
    end
    self.moveTargetX = -self.wrapItemWidth * _MaxCount * (curPage + 1)
end

--[[手动刷新商店]]
function ShopUI:refresh_shop(t)
    if self.shopInfo:HaveRefreshCntLimit(self.shopId) then
        FloatTip.Float(_UIText[2])
        return
    end
    local cost = self.shopInfo:GetShopRefreshCost(self.shopId)
    if cost == nil then
        app.log("cost is nil")
        return
    end

    local func = function()
        msg_shop.cg_refresh_shop(self.shopId)
    end
    PublicFunc.BuyCheck(func, nil, cost, IdConfig.Crystal)
end

function ShopUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)
    local row = math.abs(b) + 1

    for i = 1, 2 do
        local objItem = obj:get_child_by_name("cont (" .. tostring(i-1) .. ")")
        local pos = index * 2 + i
        local data = self.shopInfo:GetShopItemData(self.shopId, pos)
        if data ~= nil then
            objItem:set_active(true)
            self:SetItemData(objItem, data, pos, row, i)
        else
            objItem:set_active(false)
        end
    end
end

function ShopUI:SetItemData(item, data, pos, row, i)

    local lblLimit = ngui.find_label(item, item:get_name() .. "/lab")
    lblLimit:set_active(false)
    local lblTime = ngui.find_label(item, "lab1")
    lblTime:set_active(false)

    local spPoint = ngui.find_sprite(item, "sp_point")
    local spMark = ngui.find_sprite(item, "sp_mark_x")
    --兑换按钮
    local btnExchange = ngui.find_button(item, item:get_name())

    --兑换花费
    --local spItemBg = ngui.find_sprite(item, "btn2/sprite_background")
    local spIcon = ngui.find_sprite(item, "btn2/sp_hongshuijing")
    local name = self.shopInfo:GetSpriteName(data.itemConfig.sell_price_item_id)
    if name ~= nil then
        spIcon:set_active(true)
        spIcon:set_sprite_name(name)
    else
        spIcon:set_active(false)
    end

    --原数量
    local objOldItem = item:get_child_by_name('btn2/cont')
    objOldItem:set_active(false)

    --现数量
    local lblNum = ngui.find_label(item, 'btn2/lab')
    lblNum:set_text(tostring(data.itemConfig.sell_price_num))

    ----------------------------------------------------------
    local objBtn2 = item:get_child_by_name('btn2')
    local lblVip = ngui.find_label(item, 'lab_feel')
    objBtn2:set_active(true)
    lblVip:set_active(false)
    if self.shopId == ENUM.ShopID.VIP then
        local vipLvl = data.itemConfig.vip_level
        if  g_dataCenter.player:GetVip() < vipLvl then
            objBtn2:set_active(false)
            lblVip:set_active(true)
            local vipConfig = ConfigManager.Get(EConfigIndex.t_vip_data, vipLvl)
            lblVip:set_text(string.format(_UIText[7], vipConfig.level, vipConfig.level_star))
        end
    end
    ----------------------------------------------------------

    --名称
    local itemName = ngui.find_label(item, 'lab_name')
    itemName:set_color(1,1,1,1) --调整文字为白色，使用内嵌color
    local info = PublicFunc.IdToConfig(data.itemConfig.item_id)
    if info ~= nil and info.rarity ~= nil then
        local color_str  = PublicFunc.GetItemRarityColor(info.rarity)
        local color_name = "[" .. color_str .. "]" ..info.name.."[-]"
        itemName:set_text(color_name)
    end

    --small card item
    local sItem = item:get_child_by_name('new_small_card_item')
    if self.smallItemUi[row] == nil then
        self.smallItemUi[row] = {}
    end
    local itemUi = self.smallItemUi[row][i]
    if itemUi == nil then
        itemUi = UiSmallItem:new({obj = nil, parent = sItem, cardInfo = nil, delay = 500})
        itemUi:SetEnablePressGoodsTips(true)
        self.smallItemUi[row][i] = itemUi
    end
    itemUi:SetDataNumber(data.itemConfig.item_id, data.itemConfig.num)

    --折扣
    local spDiscount = ngui.find_sprite(item, "sp_xxxxx")
    -- local spFrame = ngui.find_sprite(item, "sp_di")
    spDiscount:set_active(false)
    if tonumber(data.itemConfig.discount) ~= 1 then
        spDiscount:set_active(true)
        local lblDiscount = ngui.find_label(item, "sp_xxxxx/lab")
        lblDiscount:set_text(tostring(data.itemConfig.discount * 10) .. "折")
        -- spFrame:set_sprite_name("sc_zhekoubiankuang")
    else
        -- spFrame:set_sprite_name("cz_diban1")
    end

    btnExchange:reset_on_click()
    itemUi:ClearOnClicked()
    --已售罄
    if self:IsSellOut(data) then
        spMark:set_active(true)
    else
        spMark:set_active(false)
        btnExchange:set_on_click(self.bindfunc["exchange_popup_info"]);
        btnExchange:set_event_value("", pos)
        itemUi:SetOnClicked(self.bindfunc["exchange_popup_info"], "", pos)
    end

    if AppConfig.get_enable_guide_tip() then
        if self.shopId == ENUM.ShopID.SUNDRY and self.rarityMaterial then
            if self:IsSellOut(data) then
                spPoint:set_active(false)
            else
                spPoint:set_active(self.rarityMaterial[data.itemConfig.item_id] ~= nil)
            end
        else
            spPoint:set_active(false)
        end
    end
end

function ShopUI:IsSellOut(data)
    return data.canBuyTimes == 0
end

--[[兑换提示]]
function ShopUI:exchange_popup_info(param)
    local data = self.shopInfo:GetShopItemData(self.shopId, param.float_value)
    self.buyItemName = ""
    local info = PublicFunc.IdToConfig(data.itemConfig.item_id)
    if info ~= nil and info.name ~= nil then
        self.buyItemName = info.name
    end
    ShopBuyUI.Start({buyData = data})
end

function ShopUI:after_buy_update_shop_ui(item)
    --提示购买成功
    FloatTip.Float(self.buyItemName .. _UIText[1])
    self:update_shop_ui(false)
    self:UpdateYekaPoint()
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.ShopMoney)
end

function ShopUI:update_shop_ui(resetView)
    if not self:IsShow() then
        return
    end

    if self.shopId == ENUM.ShopID.EquipBox then
        self.scrollView:set_active(false)
        self.nodePanelBk1:set_active(false)
        self.nodePanelBk2:set_active(true)
        self.clsEquipBox:Show()
        self.clsEquipBox:UpdateUi()
    else
        self.scrollView:set_active(true)
        self.nodePanelBk1:set_active(true)
        self.nodePanelBk2:set_active(false)
        self.clsEquipBox:Hide()

        local count = self.shopInfo:GetShopItemCount(self.shopId)
        self.wrapContent:set_min_index(0);
        self.wrapContent:set_max_index(math.ceil(count / 2) - 1)
        self.wrapContent:reset()
        if resetView == nil or resetView then
            self.scrollView:reset_position()
        end
        --刷新面板
        self:UpdateMontyTypePanel()
        --刷新按钮
        local haveLimit = self.shopInfo:HaveRefreshCntLimit(self.shopId)
        self.btnRefresh:set_active(not haveLimit)
        if haveLimit then
            self.btnRefresh:set_active(false)
            self.nodeRefreshCost:set_active(false)
            self.labRefreshCost:set_active(false)
        else
            self.btnRefresh:set_active(true)
            self.nodeRefreshCost:set_active(true)
            self.labRefreshCost:set_active(true)
            self.labRefreshCost:set_text(tostring(self.shopInfo:GetShopRefreshCost(self.shopId)))
        end
    end
end

function ShopUI:Update(dt)
    if UiBaseClass.Update(self, dt) then
        self.dtAdd = self.dtAdd + dt
        if self.dtAdd >= 1 then
            self.dtAdd = 0
            if self.shopId == ENUM.ShopID.EquipBox then
                return
            end
            --无数据
            if not self.shopInfo:IsLoadData(self.shopId) then
                return
            end
            --正在请求数据   
            if self.shopInfo:IsRequestShopData() then
                return
            end
            if self.shopId == ENUM.ShopID.MYSTERY then
                self:UpdateMysteryShopTime()
            else
                self:UpdateShopTime()
            end
        end

        -- 更新左右箭头按钮
        if self.shopId ~= ENUM.ShopID.EquipBox then
            local x, y, z = self.scrollView:get_position()
            local cols = math.ceil(self.shopInfo:GetShopItemCount(self.shopId) / 2)
            if cols > _MaxCount then
                if x > -self.wrapItemWidth * 0.5 then
                    self.btnLeft:set_active(false)
                    self.btnRight:set_active(true)
                elseif x < -self.wrapItemWidth * (cols - _MaxCount - 0.5) then
                    self.btnLeft:set_active(true)
                    self.btnRight:set_active(false)
                else
                    self.btnLeft:set_active(true)
                    self.btnRight:set_active(true)
                end
            else
                self.btnLeft:set_active(false)
                self.btnRight:set_active(false)
            end

            if self.moveTargetX then
                local moveX = 0
                if self.moveTargetX > x then
                    moveX = math.min(30, self.moveTargetX - x)
                elseif self.moveTargetX < x then
                    moveX = -math.min(30, x - self.moveTargetX)
                end
                if math.abs(self.moveTargetX - x) <= 30 then
                    self.moveTargetX = nil
                end
                self.scrollView:move_relative(moveX, y, z)
            end

            self.isMoving = (self.lastPosX ~= x)
            self.lastPosX = x
        else
            self.btnLeft:set_active(false)
            self.btnRight:set_active(false)
            self.moveTargetX = nil
        end
    end
end

--[[神秘商店倒计时]]
function ShopUI:UpdateMysteryShopTime()
    local diffSec = self.shopInfo:GetRefreshTime(self.shopId) + self.shopInfo:GetMysteryDurationTime() - system.time()
    if diffSec > 0 then
        local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
        if self.lblShopRefreshTime then
            self.lblShopRefreshTime:set_text(string.format("%02d:", hour)
            .. string.format("%02d:", min) .. string.format("%02d", sec))
        end
    end
end

--[[商店计时]]
function ShopUI:UpdateShopTime()
    local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(system.time())
    local currTime = tonumber(hour) * 10000 +  tonumber(min) * 100 + tonumber(sec)
    --更新倒计时     
    local timeSec = self:GetNextRefreshTime(year, month, day, hour, min, sec, currTime)
    local diffSec = timeSec - system.time()
    if diffSec > 0 then
        local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
        if self.lblShopRefreshTime then
            self.lblShopRefreshTime:set_text(string.format("%02d:", hour)
            .. string.format("%02d:", min) .. string.format("%02d", sec))
        end
    end
    --刷新点不一致, 请求数据
    local localTime = self:GetLocalRefreshTime(year, month, day, hour, min, sec, currTime)
    local serverTime = self.shopInfo:GetRefreshTime(self.shopId)
    if serverTime ~= localTime then
        app.log("----> LoadShopData " .. tostring(localTime) .. "< -- >" .. tostring(serverTime))
        self:LoadShopData(true)
    end
end

--[[获取下次刷新秒数]]
function ShopUI:GetNextRefreshTime(year, month, day, hour, min, sec, currTime)
    --下次刷新点
    local nextIndex = nil
    local _shopTime = ConfigManager.Get(EConfigIndex.t_shop, self.shopId).refresh_time
    for k, v in pairs(_shopTime) do
        if tonumber(v) >= currTime then
            nextIndex = k
            break
        end
    end
    local nextRefreshTime = nil
    --刷新点为第二天第一个
    if nextIndex == nil then
        year, month, day = TimeAnalysis.ConvertToYearMonDay(system.time() + 24 * 3600)
        nextRefreshTime = _shopTime[1]
    else
        nextRefreshTime = _shopTime[nextIndex]
    end
    return self:GetTimeSecond(year, month, day, nextRefreshTime)
end

--[[获取本地刷新秒数]]
function ShopUI:GetLocalRefreshTime(year, month, day, hour, min, sec, currTime)
    --查找上次刷新点
    local index = nil
    local _shopTime = ConfigManager.Get(EConfigIndex.t_shop,self.shopId).refresh_time
    for k, v in pairs(_shopTime) do
        if currTime >= tonumber(v) then
            index = k
        else
            break
        end
    end
    local lastRefreshTime = nil
    --刷新点为上一天最后一个
    if index == nil then
        year, month, day = TimeAnalysis.ConvertToYearMonDay(system.time() - 24 * 3600)
        lastRefreshTime = _shopTime[#_shopTime]
    else
        lastRefreshTime = _shopTime[index]
    end
    return self:GetTimeSecond(year, month, day, lastRefreshTime)
end

--[[获取时间秒数]]
function ShopUI:GetTimeSecond(year, month, day, time)
    local str = tostring(time)
    local hour = tonumber(string.sub(str, 1, 2))
    local min = tonumber(string.sub(str, 3, 4))
    local sec = tonumber(string.sub(str, 5, 6))
    return os.time({year = year, month = month, day = day, hour = hour, min = min, sec = sec})
end

function ShopUI:update_shop_gold(money)
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.ShopMoney);
    local txtGold = PublicFunc.NumberToStringByCfg(money)
    FloatTip.Float(string.format(_UIText[6], txtGold))

    local mType = self.shopInfo:GetMoneyType(self.shopId)
    if mType ~= nil and mType == IdConfig.Gold then
        self.lblMoney:set_text(txtGold)
    end
end

function ShopUI:OnPressTips1(name, state, x, y, gameobj)
    if state == true then
        local worldX, worldY, worldZ = gameobj:get_position();
        local uiCamera = Root.get_ui_camera();
        local screenX,screenY = uiCamera:world_to_screen_point(worldX, worldY, worldZ);
        local sizeX, sizeY = gameobj:get_box_collider_size();

        local id = self.shopInfo:GetMoneyType(self.shopId)
        --默认都是上边缘
        GoodsTips.EnableGoodsTips(true, id, 0, screenX, screenY, sizeY, 1, 100)
    else
        GoodsTips.EnableGoodsTips(false)
    end
end

function ShopUI:OnPressTips1_2(name, state, x, y, gameobj)
    if state == true then
        local worldX, worldY, worldZ = gameobj:get_position();
        local uiCamera = Root.get_ui_camera();
        local screenX,screenY = uiCamera:world_to_screen_point(worldX, worldY, worldZ);
        local sizeX, sizeY = gameobj:get_box_collider_size();

        local id, id2 = self.shopInfo:GetMoneyType(self.shopId)
        --默认都是上边缘
        GoodsTips.EnableGoodsTips(true, id2, 0, screenX, screenY, sizeY, 1, 100)
    else
        GoodsTips.EnableGoodsTips(false)
    end
end

function ShopUI:OnPressTips2(name, state, x, y, gameobj)
    if state == true then
        local worldX, worldY, worldZ = gameobj:get_position();
        local uiCamera = Root.get_ui_camera();
        local screenX,screenY = uiCamera:world_to_screen_point(worldX, worldY, worldZ);
        local sizeX, sizeY = gameobj:get_box_collider_size();
        --默认都是上边缘
        GoodsTips.EnableGoodsTips(true, IdConfig.EquipDebris, 0, screenX, screenY, sizeY, 1, 100)
    else
        GoodsTips.EnableGoodsTips(false)
    end
end
