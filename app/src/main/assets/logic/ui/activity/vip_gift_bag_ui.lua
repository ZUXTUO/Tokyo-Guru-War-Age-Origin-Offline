
VIPGiftBagUI = Class("VIPGiftBagUI", UiBaseClass)

local _uiText = 
{
    [1] = "好感度%d特惠超值礼包",
    [2] = "%d",
    [3] = "[FFCC00FF]好感度%d-%d[-]以上玩家可购买,当前好感度特权等级:[FFCC00FF]好感度%d-%d[-]",
    [4] = "今日剩余次数:",
    [5] = "剩余次数:",
    [6] = "活动时间:%04d.%02d.%02d-%04d.%02d.%02d",
    [7] = "活动倒计时:%d天%02d:%02d:%02d",
    [8] = "好感度不足",
    [9] = "钻石不足",
    [10] = "购买次数不足",
}

local SHOW_NUM = 9

function VIPGiftBagUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1137_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function VIPGiftBagUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));

    self.enchanceScroolView = ngui.find_enchance_scroll_view(self.ui, "panel_scoll_view")
    self.introLabel = ngui.find_label(self.ui, "lab_word")
    -- self.actTimeLabel = ngui.find_label(self.ui, "lab_time1")
    self.countDownLabel = ngui.find_label(self.ui, "lab_time2")
    self.titleLabel = ngui.find_label(self.ui, "animation/sp_di/sp_title/lab_vip")
    self.discountLabel = ngui.find_label(self.ui, "sp_zhekou/lab_zhekou")
    self.originPriceLabel = ngui.find_label(self.ui, "sp_di/sp_bar1/lab_num")
    self.discountPriceLabel = ngui.find_label(self.ui, "sp_di/sp_bar2/lab_num")
    self.currentVipLabel = ngui.find_label(self.ui, "sp_di/txt_cishu")
    self.timesLabel = ngui.find_label(self.ui, "lab_tishi")
    self.bagContentItemNodes = {}
    for i = 1, 4 do
        local info = {}
        info.parent = self.ui:get_child_by_name("sp_bar_bk/new_small_card_item" .. tostring(i))
        self.bagContentItemNodes[#self.bagContentItemNodes + 1] = info
    end

    self.buyBtn = ngui.find_button(self.ui, "btn_cheng")
    self.buyBtnSp = ngui.find_sprite(self.ui, "btn_cheng/sp")
    self.buyBtnLabel = ngui.find_label(self.ui, "btn_cheng/lab")
    self.leftBtn = ngui.find_button(self.ui, "btn_left")
    self.leftBtnSp = ngui.find_sprite(self.ui, "btn_left/sp")
    self.rightBtn = ngui.find_button(self.ui, "btn_right")
    self.rightBtnSp = ngui.find_sprite(self.ui, "btn_right/sp")


    self.buyBtn:set_on_click(self.bindfunc["OnClickBuyBtn"])
    self.leftBtn:set_on_click(self.bindfunc["OnClickLeftBtn"])
    self.rightBtn:set_on_click(self.bindfunc["OnClickRightBtn"])
    self.enchanceScroolView:set_on_initialize_item(self.bindfunc["OnInitItem"])
    self.enchanceScroolView:set_on_stop_move(self.bindfunc["OnListStop"])
    self.enchanceScroolView:set_on_start_move(self.bindfunc["OnListMoveStart"])


    self.dataCenter = g_dataCenter.activityReward
    self.tabListData = {}
    self.vip2itemMap = {}
    self.beginIndex = 0

    self:Hide()

    if self.dataCenter:HasRequestVipBagActivityData() then
        self:OnReponsedState()
    else
        msg_activity.cg_vip_gift_get_state()
    end

    g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_vip_buy, 0);
end

function VIPGiftBagUI:OnReponsedState()
    self:Show()
    self:UpdateUI()
end

function VIPGiftBagUI:DestroyUi()
    if self.bagContentItemNodes then
        for k,v in pairs(self.bagContentItemNodes) do
            if v.smallItemUi then
                v.smallItemUi:DestroyUi()
            end
        end
        self.bagContentItemNodes = nil
    end
    self.tabListData = nil
    UiBaseClass.DestroyUi(self)
end

function VIPGiftBagUI:UpdateUI()

    local actConfig = ConfigManager.Get(EConfigIndex.t_activity_play, ENUM.Activity.activityType_vip_buy)
    if actConfig then
        if tostring(actConfig.des) == "0" or tostring(actConfig.des) == "nil" then
            self.introLabel:set_active(false);
        end
        self.introLabel:set_text(tostring(actConfig.des))
    end

    self.activityTime = self.dataCenter:GetActivityTimeForActivityID(ENUM.Activity.activityType_vip_buy)
    local beginTime = os.date("*t", self.activityTime.s_time)
    local endTime = os.date("*t", self.activityTime.e_time)
    -- is_reset 1, 0
    -- self.actTimeLabel:set_text(string.format(_uiText[6], beginTime.year, beginTime.month, beginTime.day, endTime.year, endTime.month, endTime.day))
    self.countDownLabel:set_text("")

    local cfg = ConfigManager._GetConfigTable(EConfigIndex.t_vip_gift_bag)
    self.configVipList = {}
    self.maxVIP = 0;
    self.minVIP = 10000;
    local showVip = 0
    local pvip = g_dataCenter.player.vip
    for k,v in pairs(cfg) do
        if v.id > self.maxVIP then
            self.maxVIP = v.id
        end
        if v.id < self.minVIP then
            self.minVIP = v.id
        end

        if pvip > v.id then
            showVip = v.id
        end

        table.insert(self.configVipList, v.id)
    end
    table.sort(self.configVipList)
    if VIPGiftBagUI.lastShowVip ~= nil then
        showVip = VIPGiftBagUI.lastShowVip
    elseif showVip < self.minVIP then
        showVip = self.minVIP
    end
    self.currentSelectVip = showVip
    self.enchanceScroolView:set_maxNum(#self.configVipList);
    self.enchanceScroolView:set_showIndex(3);
    self.enchanceScroolView:refresh_list()

    self:SetTabContent(showVip)
end

function VIPGiftBagUI:SetTabContent(vip)
    local config = ConfigManager.Get(EConfigIndex.t_vip_gift_bag, vip)
    if config == nil then return end
    VIPGiftBagUI.lastShowVip = vip
    self.currentSelectVip = vip
    local cur_vip_data = g_dataCenter.player:GetVipDataConfigByLevel(vip);
    if cur_vip_data then
        self.titleLabel:set_text(string.format(_uiText[1], cur_vip_data.level))
    end
    self.originPriceLabel:set_text(tostring(config.price))
    self.discountPriceLabel:set_text(tostring(config.discount_price))
    self.discountLabel:set_text(string.format(_uiText[2], math.floor(config.discount_price/config.price*10)))

    
    local my_vip_data = g_dataCenter.player:GetVipData();
    if cur_vip_data and my_vip_data then
        self.currentVipLabel:set_text(string.format(_uiText[3], cur_vip_data.level, cur_vip_data.level_star, my_vip_data.level, my_vip_data.level_star))
    end
    
    local isTodayReset = self.activityTime.is_reset ~= 0
    local str = _uiText[5]
    if isTodayReset then
        str = _uiText[4]
    end
    -- TODO hyg 设置今日剩余次数或者剩余次数
    self.timesLabel:set_text(string.format("%d", config.times - self.dataCenter:GetBuyVipBagTimes(self.currentSelectVip)))

    for i = 1, 4 do
        local info = self.bagContentItemNodes[i]
        local idNum = config.items[i]
        if idNum then
            info.parent:set_active(true)
            if info.smallItemUi == nil then
                info.smallItemUi = UiSmallItem:new({parent = info.parent, is_enable_goods_tip = true, delay = 0})
            end
            info.smallItemUi:SetDataNumber(idNum.item_id, idNum.item_num)
        else
            info.parent:set_active(false)
        end
        
    end

    if self.currentSelectVip <= self.minVIP then
        self.leftBtnSp:set_color(0, 0, 0, 1)
    else
        self.leftBtnSp:set_color(1, 1, 1, 1)
    end

    if self.currentSelectVip >= self.maxVIP then
        self.rightBtnSp:set_color(0, 0, 0, 1)
    else
        self.rightBtnSp:set_color(1, 1, 1, 1)
    end


    local canBuy = true
    if g_dataCenter.player.vip < self.currentSelectVip then
        canBuy = false
    end

    local config = ConfigManager.Get(EConfigIndex.t_vip_gift_bag, self.currentSelectVip)
    if canBuy then
        local remainTimes = config.times - self.dataCenter:GetBuyVipBagTimes(self.currentSelectVip)
        if remainTimes <= 0 then
            canBuy = false
        end
    end

    -- if canBuy then
    --     local buyCount = math.floor(g_dataCenter.player.crystal / config.discount_price)
    --     if buyCount < 1 then
    --         canBuy = false
    --     end
    -- end

    if canBuy then
        -- self.buyBtnSp:set_color(1, 1, 1, 1)
        -- self.buyBtnLabel:set_effect_color(174/255, 65/255, 40/255, 1)
        PublicFunc.SetButtonShowMode(self.buyBtn, 1);
    else
        -- self.buyBtnSp:set_color(0, 0, 0, 1)
        -- self.buyBtnLabel:set_effect_color(95/255, 95/255, 95/255, 1)
        PublicFunc.SetButtonShowMode(self.buyBtn, 3);
    end

end

function VIPGiftBagUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickBuyBtn"]     = Utility.bind_callback(self, self.OnClickBuyBtn)
    self.bindfunc["OnClickLeftBtn"]     = Utility.bind_callback(self, self.OnClickLeftBtn)
    self.bindfunc["OnClickRightBtn"]     = Utility.bind_callback(self, self.OnClickRightBtn)
    self.bindfunc["OnInitItem"]     = Utility.bind_callback(self, self.OnInitItem)
    self.bindfunc["OnListStop"]     = Utility.bind_callback(self, self.OnListStop)
    self.bindfunc["OnListMoveStart"]     = Utility.bind_callback(self, self.OnListMoveStart)
    self.bindfunc["OnClickTab"] = Utility.bind_callback(self, self.OnClickTab)

    self.bindfunc["OnReponsedState"] = Utility.bind_callback(self, self.OnReponsedState)
    self.bindfunc["OnReponseBuy"] = Utility.bind_callback(self, self.OnReponseBuy)
end

function VIPGiftBagUI:MsgRegist()
    PublicFunc.msg_regist(msg_activity.gc_vip_gift_get_state, self.bindfunc["OnReponsedState"]);
    PublicFunc.msg_regist(msg_activity.gc_vip_gift_buy, self.bindfunc["OnReponseBuy"]);
end

function VIPGiftBagUI:MsgUnRegist()
    PublicFunc.msg_unregist(msg_activity.gc_vip_gift_get_state, self.bindfunc["OnReponsedState"]);
    PublicFunc.msg_unregist(msg_activity.gc_vip_gift_buy, self.bindfunc["OnReponseBuy"]);
end

-- function VIPGiftBagUI:GetCanBuyTimes(vip)
--     local costTimes = self.dataCenter:GetBuyVipBagTimes(vip)
--     local config = ConfigManager.Get(EConfigIndex.t_vip_gift_bag, vip)
--     local remainTimes = config.times - costTimes
--     if remainTimes < 0 then remainTimes = 0 end

--     local buyCount = math.floor(g_dataCenter.player.crystal / config.discount_price)
--     if buyCount < remainTimes then
--         remainTimes = buyCount
--     end

--     return remainTimes
-- end

function VIPGiftBagUI:OnClickBuyBtn()

    if g_dataCenter.player.vip < self.currentSelectVip then
        FloatTip.Float(_uiText[8])
        return
    end

    local config = ConfigManager.Get(EConfigIndex.t_vip_gift_bag, self.currentSelectVip)
    local remainTimes = config.times - self.dataCenter:GetBuyVipBagTimes(self.currentSelectVip)
    if remainTimes <= 0 then
        FloatTip.Float(_uiText[10])
        return 
    end

    local buyCount = math.floor(g_dataCenter.player.crystal / config.discount_price)
    if buyCount < 1 then
        FloatTip.Float(_uiText[9])
        return
    end
    if buyCount > remainTimes then
        buyCount = remainTimes
    end

    if buyCount == 1 then
        msg_activity.cg_vip_gift_buy(self.currentSelectVip, 1)
    else
        uiManager:PushUi(EUI.VIPGiftBagSelectNumUI, {vip = self.currentSelectVip, count = buyCount})
    end
end

function VIPGiftBagUI:OnReponseBuy(result, viplevel, buytimes, timesNum)
    if PublicFunc.GetErrorString(result, true) then
        if self.currentSelectVip == viplevel then
            self:SetTabContent(viplevel)
        end
        
        local config = ConfigManager.Get(EConfigIndex.t_vip_gift_bag, viplevel)

        local award = {}
        for k,item in ipairs(config.items) do
            local n = {}
            n.id = item.item_id
            n.count = item.item_num * buytimes
            table.insert(award, n)
        end

        CommonAward.Start(award)
    end
end

function VIPGiftBagUI:OnInitItemData(obj)
    local data = {}
    data.normalSp = ngui.find_sprite(obj, "sp_zi")
    data.btn_lab = ngui.find_label(obj, "txt_haogan")
    data.selectSp = ngui.find_sprite(obj, "sp_lan")
    data.vipSp = ngui.find_label(obj, "sp_v/lab_v")
    data.vipSp_star = ngui.find_label(obj, "sp_v/lab_v2")
    data.btn = ngui.find_button(obj, obj:get_name())
    data.btn:set_on_click(self.bindfunc["OnClickTab"])
    return data
end

function VIPGiftBagUI:OnInitItem(obj, index)
    --app.log("OnInitItem index = " .. tostring(index))
    local instId = obj:get_instance_id()
    local data = self.tabListData[instId]
    if data == nil then
        data = self:OnInitItemData(obj)
        self.tabListData[instId] = data
    end

    local vip = self.configVipList[index]
    app.log("OnInitItem index = " .. tostring(index) .. ' ' .. tostring(vip) )
    if vip == nil then return end
    local cur_vip_data = g_dataCenter.player:GetVipDataConfigByLevel(vip);
    if cur_vip_data then
       PublicFunc.SetImageVipLevel(data.vipSp, cur_vip_data.level);
       data.vipSp_star:set_text("-"..tostring(cur_vip_data.level_star))
   end
    if index <= 1 then
        data.normalSp:set_sprite_name("ty_anniu2")
        data.selectSp:set_sprite_name("ty_anniu1")
    elseif index >= #self.configVipList then
        data.normalSp:set_sprite_name("ty_anniu7")
        data.selectSp:set_sprite_name("ty_anniu6")
    else
        data.normalSp:set_sprite_name("ty_anniu9")
        data.selectSp:set_sprite_name("ty_anniu8")
    end
    if vip == self.currentSelectVip then
        self:SetSelectTabState(data, true)
    else
        self:SetSelectTabState(data, false)
    end
    data.showVip = vip

    for k,v in pairs(self.vip2itemMap) do
        if v == instId then
            self.vip2itemMap[k] = nil
            break
        end
    end
    self.vip2itemMap[vip] = instId
end

function VIPGiftBagUI:SetSelectTabState(data, is)
    data.normalSp:set_active(not is)
    data.selectSp:set_active(is)
    if is then        
        data.btn_lab:set_color(139/255, 87/255, 11/255, 1);
    else
        data.btn_lab:set_color(184/255, 133/255, 254/255, 1);
    end
end

function VIPGiftBagUI:OnListStop(index)
    self.beginIndex = index
end

function VIPGiftBagUI:OnListMoveStart()
    --app.log("OnListMoveStart " )
end

function VIPGiftBagUI:OnClickTab(param)
    local obj = param.game_object

    local oldInst = self.vip2itemMap[self.currentSelectVip]

    local newInst = obj:get_instance_id()
    if newInst == oldInst then return end

    self:SelectTab(newInst)
end

function VIPGiftBagUI:SelectTab(newInst)
    local oldInst = self.vip2itemMap[self.currentSelectVip]
    if oldInst then
        local data = self.tabListData[oldInst]
        self:SetSelectTabState(data, false)
    end

    data = self.tabListData[newInst]
    self:SetSelectTabState(data, true)
    self:SetTabContent(data.showVip)
end

function VIPGiftBagUI:UnSelectCurrentTab()
    local oldInst = self.vip2itemMap[self.currentSelectVip]
    if oldInst then
        local data = self.tabListData[oldInst]
        self:SetSelectTabState(data, false)
    end
end

function VIPGiftBagUI:OnClickLeftBtn()
    if self.currentSelectVip <= self.minVIP then return end
    local oldIndex = table.index_of(self.configVipList, self.currentSelectVip)
    local nxtIndex = oldIndex - 1
    local nextVip = self.configVipList[nxtIndex]
    local instid = self.vip2itemMap[nextVip]
    if instid then
        self:SelectTab(instid)
    else
        self:UnSelectCurrentTab()
        self:SetTabContent(nextVip)
    end
    self:TweenToSelectTab()
end

function VIPGiftBagUI:OnClickRightBtn()
    if self.currentSelectVip >= self.maxVIP then return end
    local oldIndex = table.index_of(self.configVipList, self.currentSelectVip)
    local nxtIndex = oldIndex + 1
    local nextVip = self.configVipList[nxtIndex]
    local instid = self.vip2itemMap[nextVip]
    if instid then
        self:SelectTab(instid)
    else
        self:UnSelectCurrentTab()
        self:SetTabContent(nextVip)
    end
    self:TweenToSelectTab()
end

function VIPGiftBagUI:TweenToSelectTab()
    local needShowIndex = table.index_of(self.configVipList, self.currentSelectVip)
    if needShowIndex < self.beginIndex then
        self.enchanceScroolView:tween_to_index(needShowIndex)
    elseif needShowIndex >= self.beginIndex + SHOW_NUM then
        self.enchanceScroolView:tween_to_index(self.beginIndex + (needShowIndex - (self.beginIndex + SHOW_NUM)) + 1 )
    end
end

function VIPGiftBagUI:Update(dt)
    self:UpdateCountDown()
end

function VIPGiftBagUI:UpdateCountDown()
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

            local showStr = string.format(_uiText[7], day, hour, min, second)

            self.countDownLabel:set_text(showStr)
        end
    end
end