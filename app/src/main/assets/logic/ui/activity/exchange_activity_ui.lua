ExchangeActivityUI = Class("ExchangeActivityUI", UiBaseClass)


local _uiText = 
{
    [1] = "数量不足，无法兑换";
    [2] = "%d月%d日-%d月%d日活动期间，收集幸运星兑换超值大礼";
    [3] = "天";
    [4] = "活动倒计时: ";
}

function ExchangeActivityUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1135_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function ExchangeActivityUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));

    self.actvityDesLabel = ngui.find_label(self.ui, "content/lab_title1")
    self.countDownLabel = ngui.find_label(self.ui, "content/lab_time")
    self.wrapContent = ngui.find_wrap_content(self.ui, "wrap_content")
    self.wrapContentScroolView = ngui.find_scroll_view(self.ui, "panel")
    self.refreshTipNode = ngui.find_sprite(self.ui, "sp_bar")

    self.wrapContent:set_on_initialize_item(self.bindfunc["OnInitItem"])

    self.rowContentData = {}

    local initData = self:GetInitData()

    self.activityid = initData.id
    self.dataCenter = g_dataCenter.activityReward
    --self:UpdateUI()
    self:Hide()

    if self.dataCenter:HasRequestExchangeItemActivityData(self.activityid) then
        self:OnReponsedState()
    else
        msg_activity.cg_get_exchange_item_state(self.activityid)
    end

    g_dataCenter.activityReward:SetRedPointStateByActivityID(self.activityid, 0);
end

function ExchangeActivityUI:OnReponsedState()
    self:Show()
    self.config = g_dataCenter.activityReward:GetExchangeItemActConfig(self.activityid)
    self:UpdateUI()
end

function ExchangeActivityUI:DestroyUi()
    if self.rowContentData then
        for k,v in pairs(self.rowContentData) do

            for i,item in ipairs(v.exchangeBeforeItem) do
                item.smallItemUi:DestroyUi()
            end

            v.exchangeAfterItemUi:DestroyUi()
        end
        self.rowContentData = nil
    end

    UiBaseClass.DestroyUi(self)
end

function ExchangeActivityUI:UpdateUI()

    self.activityTime = self.dataCenter:GetActivityTimeForActivityID(self.activityid)
    local beginTime = os.date("*t", self.activityTime.s_time)
    local endTime = os.date("*t", self.activityTime.e_time)
    self.actvityDesLabel:set_text(string.format(_uiText[2], beginTime.month, beginTime.day, endTime.month, endTime.day))
    self.countDownLabel:set_text("")

    if self.activityTime.is_reset ~= 0 then
        self.refreshTipNode:set_active(true)
    else
        self.refreshTipNode:set_active(false)
    end

    self:RefreshExchangeList()
end

local sortfunc = function(a, b)
    if a.state == b.state then
        return a.id < b.id
    else
        return a.state > b.state
    end
end

function ExchangeActivityUI:RefreshExchangeList()
    local cfg = self.config
    --app.log("#hyg#Exchange item config " .. table.tostring(cfg))
    self.exchangeIDs = {}
    local tempList = {}
    for k,v in pairs(cfg) do

        local state = 1
        if v.exchange_num < 1 then
            state = 3
        else
            local usedTimes = self.dataCenter:GetItemExchangeTimes(self.activityid, v.id)
            if usedTimes < v.exchange_num then
                state = 3
            end
        end
        if state > 1 then
            for k,v in ipairs(v.need_items) do
                if self:GetItemCount(v.id) < v.count then
                    state = 2
                    break
                end
            end
        end

        table.insert(tempList, {id = v.id, state = state})
    end
    table.sort(tempList, sortfunc)
    for k,v in ipairs(tempList) do
        table.insert(self.exchangeIDs, v.id)
    end

    local itemCount = #self.exchangeIDs

    self.wrapContent:set_min_index(-itemCount + 1);
    self.wrapContent:set_max_index(0);
    self.wrapContent:reset();
    self.wrapContentScroolView:reset_position();
end

function ExchangeActivityUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnInitItem"]     = Utility.bind_callback(self, self.OnInitItem)
    self.bindfunc["OnClickExchange"]     = Utility.bind_callback(self, self.OnClickExchange)
    self.bindfunc["OnExchangeResult"]   = Utility.bind_callback(self, self.OnExchangeResult)
    self.bindfunc["OnReponsedState"] = Utility.bind_callback(self, self.OnReponsedState)
end

function ExchangeActivityUI:MsgRegist()
    PublicFunc.msg_regist(msg_activity.gc_exchange_item_exchange, self.bindfunc["OnExchangeResult"]);
    PublicFunc.msg_regist(msg_activity.gc_get_exchange_item_state, self.bindfunc["OnReponsedState"]);
end

function ExchangeActivityUI:MsgUnRegist()
    PublicFunc.msg_unregist(msg_activity.gc_exchange_item_exchange, self.bindfunc["OnExchangeResult"]);
    PublicFunc.msg_unregist(msg_activity.gc_get_exchange_item_state, self.bindfunc["OnReponsedState"]);
end

function ExchangeActivityUI:InitItemUI(obj)
    local rowData = {}

    rowData.titleLabel = ngui.find_label(obj, "lab")
    rowData.titleLabel_txt = ngui.find_label(obj, "lab/txt")
    rowData.titleLabel_txt:set_text("")
    rowData.completeSprite = ngui.find_sprite(obj, "sp_art_font")
    rowData.exchangeBtn = ngui.find_button(obj, "btn1");
    rowData.exchangeBtn_lab = ngui.find_label(obj, "btn1/animation/lab");
    rowData.exchangeBtnSprite = ngui.find_sprite(obj, "btn1/sp")
    rowData.exchangeBeforeItem = {}
    for i = 1, 3 do
        local info = {}
        info.node = obj:get_child_by_name("new_small_card_item" .. i)
        --info.itemFx = info.node:get_child_by_name("fx");
        info.smallItemUi = UiSmallItem:new({parent = info.node, is_enable_goods_tip = true, delay = 500})
        -- info.node:set_active(true);
        rowData.exchangeBeforeItem[i] = info
    end
    rowData.exchangeAfterNode = obj:get_child_by_name("new_small_card_item4")
    rowData.timesLabel = ngui.find_label(obj, "lab_progress")

    rowData.exchangeBtn:set_on_click(self.bindfunc["OnClickExchange"]);
    rowData.exchangeAfterItemUi = UiSmallItem:new({parent = rowData.exchangeAfterNode, is_enable_goods_tip = true, delay = 500})

    return rowData
end

function ExchangeActivityUI:OnInitItem(obj, b, real_id)

    local index = math.abs(real_id) + 1
    local id = self.exchangeIDs[index]
    local name = obj:get_name()
    local rowData = self.rowContentData[name]
    if rowData == nil then
        rowData = self:InitItemUI(obj)
        self.rowContentData[name] = rowData
    end

    local config = self.config[id]
    if config == nil then 
        app.log("#hyg#exchange activiey,config error, id=" .. tostring(id)) 
        return
    end
    
    rowData.titleLabel:set_text(tostring(config.description))
    for i = 1, 3 do
        local info = rowData.exchangeBeforeItem[i]
        local idNum = config.need_items[i]
        if idNum then
            info.smallItemUi:SetDataNumber(idNum.id, idNum.count)
            info.smallItemUi:SetAsReward(idNum.is_shine and idNum.is_shine == 1);
            info.node:set_active(true)
            -- if idNum.is_shine and idNum.is_shine ~= 0 then
            --     info.itemFx:set_active(true)
            -- else
            --     info.itemFx:set_active(false)
            -- end 
        else
            info.node:set_active(false)
        end
    end
    local exchangedIdNum = config.have_items[1]
    rowData.exchangeAfterItemUi:SetDataNumber(exchangedIdNum.id, exchangedIdNum.count)
    
    rowData.timesLabel:set_active(false)
    rowData.exchangeBtn:set_active(false)
    rowData.exchangeBtn_lab:set_color(140/255, 66/255, 19/255, 1);
    -- rowData.exchangeBtn_lab:set_text("[973900FF]兑换[-]");
    rowData.completeSprite:set_active(false)
    local usedTimes = self.dataCenter:GetItemExchangeTimes(self.activityid, id)
    -- rowData.exchangeBtnSprite:set_color(1, 1, 1, 1)
    rowData.exchangeBtnSprite:set_sprite_name("ty_anniu3")
    if config.exchange_num < 1 then
        rowData.exchangeBtn:set_active(true)

    else
        if usedTimes >= config.exchange_num then
            rowData.completeSprite:set_active(true)
        else
            rowData.timesLabel:set_active(true)
            rowData.timesLabel:set_text(string.format("[00FF53FF]%d[-]/%d", usedTimes, config.exchange_num))
            rowData.exchangeBtn:set_active(true)
            if not self:CanExchange(config) then
                rowData.exchangeBtnSprite:set_sprite_name("ty_anniu5")                
                rowData.exchangeBtn_lab:set_color(198/255, 198/255, 198/255, 1);
                -- rowData.exchangeBtn_lab:set_text("[C6C6C6FF]兑换[-]")
            end
        end
    end
    rowData.exchangeBtn:set_event_value("", id)
end

function ExchangeActivityUI:CanExchange(idOrConfig)
    local config = idOrConfig
    if type(config) == "number" then
        config = self.config[idOrConfig]
    end

    for k,item in ipairs(config.need_items) do
        local number = self:GetItemCount(item.id);
        if number < item.count then
            return false
        end
    end

    return true
end

function ExchangeActivityUI:GetItemCount(id)
    local count = 0
    if PropsEnum.IsGold(id) then
        count = g_dataCenter.player.gold
    elseif id == IdConfig.Crystal then
        count = g_dataCenter.player.crystal
    elseif id == IdConfig.RedCrystal then
        count = g_dataCenter.player.red_crystal
    else
        count = g_dataCenter.package:find_count(ENUM.EPackageType.Item, id);
    end
    
    return count
end

function ExchangeActivityUI:CanExchangeCount(id)
    local config = self.config[id]
    if config == nil then
        app.log("#hyg# can not read config " .. tostring(self.activityid) .. ' ' .. tostring(id))
        return 0
    end
    local canExchangeCount = nil
    for k,item in ipairs(config.need_items) do
        local number = self:GetItemCount(item.id);
        local c = math.floor(number/item.count)
        local usedTimes = self.dataCenter:GetItemExchangeTimes(self.activityid, id)
        local remainTimes = config.exchange_num - usedTimes
        if c > remainTimes then
            c = remainTimes
        end
        if canExchangeCount == nil or c < canExchangeCount then
            canExchangeCount = c
        end
    end

    if canExchangeCount == nil then
        canExchangeCount = 0
    end

    return canExchangeCount
end

-- -- param.float_value = id
function ExchangeActivityUI:OnClickExchange(param)

    local id = param.float_value
    local count = self:CanExchangeCount(id)
    if count < 1 then
        FloatTip.Float(_uiText[1])
        return
    end

    if count > 1 then
        uiManager:PushUi(EUI.ExchangeActivitySelectNumUi, {config = self.config, id = id, count = count, activityid = self.activityid})
    else
        msg_activity.cg_exchange_item_exchange(id, 1, self.activityid)
    end
end

function ExchangeActivityUI:OnExchangeResult(result, id, times, activity_id)
    
    if self.config and PublicFunc.GetErrorString(result, true) then
        self:RefreshExchangeList()
        local config = self.config[id]

        local award = {}
        for k,item in ipairs(config.have_items) do
            local n = {}
            n.id = item.id
            n.count = item.count * times
            table.insert(award, n)
        end

        CommonAward.Start(award)
    end
end

function ExchangeActivityUI:Update(dt)
    self:UpdateCountDown()
end

function ExchangeActivityUI:UpdateCountDown()
    if not self.countDownLabel then return end

    if self.activityTime then
        local endDiff = self.activityTime.e_time - system.time()
        if self.currentShowDiff ~= endDiff then
            local second = endDiff % 60
            local min = math.floor(endDiff / 60)
            local hour = math.floor(min / 60)
            min = min % 60
            local day = math.floor(hour / 24)
            hour = hour % 24

            local showStr = _uiText[4]
            if day > 0 then
                showStr = showStr .. day .. _uiText[3]
            end
            showStr = showStr .. string.format("%02d:%02d:%02d", hour, min, second)

            self.countDownLabel:set_text(showStr)
        end
    end
end