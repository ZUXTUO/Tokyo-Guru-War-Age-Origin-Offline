
EquipBoxUI = Class("EquipBoxUI", UiBaseClass)

local _local = {}
_local.UIText = {
    [1] = "(每日%s点首抽免费)",
    [2] = "开启一次",
    [3] = "必得%s",
    [4] = "%s次后必得%s",
    [5] = "本次必得%s",
    [6] = "必得装备%s",
    [7] = "今日首次免费",
    [8] = "购买装备碎片，可获得装备%s",
    [9] = "免费",
}

_local.temp_data = nil
_local.is_again = nil
_local.is_playing = nil

function EquipBoxUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/shop/equip_box_item.assetbundle"
	UiBaseClass.Init(self, data);
end

function EquipBoxUI:Restart(data)
	if UiBaseClass.Restart(self, data) then
        msg_activity.cg_niudan_request_equip_info();
    end
end

function EquipBoxUI:InitData(data)
    if data then
        self.parent = data.parent
        self.down = data.down
    end
    self.freeTimes = 0
    self.useOnceTimes = 0
    self.useTenTimes = 0
    self.todayDiscountTimes = 0
    self.todayUseMoneyTenTimes = 0
    self.cfgEquipCost = 
        ConfigManager.Get(EConfigIndex.t_niudan_cost, ENUM.NiuDanType.Equip);
    self.cfgShowData = 
        ConfigManager.Get(EConfigIndex.t_discrete, 
        MsgEnum.ediscrete_id.eDiscreteId_spec_equip_box_show_item).data
    local itemCfg = ConfigManager.Get(EConfigIndex.t_item, IdConfig.EquipEvolution);
    self.itemName = itemCfg.name or ""
	UiBaseClass.InitData(self, data)
end

function EquipBoxUI:DestroyUi()
    if self.itemsShow then
        for i,v in ipairs(self.itemsShow) do
            v:DestroyUi()
        end
        self.itemsShow = nil
    end
    UiBaseClass.DestroyUi(self)
end

function EquipBoxUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_exchange_btn"] = Utility.bind_callback(self, self.on_exchange_btn)
    self.bindfunc["on_one_btn"] = Utility.bind_callback(self, self.on_one_btn)
    self.bindfunc["on_ten_btn"] = Utility.bind_callback(self, self.on_ten_btn)
    self.bindfunc["one_btn_again"] = Utility.bind_callback(self, self.one_btn_again)
    self.bindfunc["ten_btn_again"] = Utility.bind_callback(self, self.ten_btn_again)
    self.bindfunc["gc_update_equip_info"] = Utility.bind_callback(self, self.gc_update_equip_info)
    self.bindfunc["gc_niudan_use"] = Utility.bind_callback(self, self.gc_niudan_use)
    self.bindfunc["on_item_data_change"] = Utility.bind_callback(self, self.on_item_data_change)
    self.bindfunc["on_btn_preview"] = Utility.bind_callback(self, self.on_btn_preview)
end

function EquipBoxUI:MsgRegist()
	NoticeManager.BeginListen(ENUM.NoticeType.CardItemChange, self.bindfunc["on_item_data_change"]);

    PublicFunc.msg_regist(msg_activity.gc_niudan_sync_equip_info,self.bindfunc['gc_update_equip_info']);
    PublicFunc.msg_regist(msg_activity.gc_niudan_use,self.bindfunc['gc_niudan_use']);
end

function EquipBoxUI:MsgUnRegist()
	NoticeManager.EndListen(ENUM.NoticeType.CardItemChange, self.bindfunc["on_item_data_change"]);

    PublicFunc.msg_unregist(msg_activity.gc_niudan_sync_equip_info,self.bindfunc['gc_update_equip_info']);
    PublicFunc.msg_unregist(msg_activity.gc_niudan_use,self.bindfunc['gc_niudan_use']);
end

--初始化UI
function EquipBoxUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)	
	self.ui:set_name("equip_box_item")
    self.ui:set_parent(self.parent)

    self.itemsShow = {}
    _local.temp_data = nil
    _local.is_again = nil
    _local.is_playing = nil

    if self.down == nil then
        app.log(" equip_box_item : data.down is nil ")
    end
    --------------------------- 底部 ---------------------------
    local btnExchange = ngui.find_button(self.down, "btn")
    btnExchange:set_on_click(self.bindfunc["on_exchange_btn"])
    self.labFragNum = ngui.find_label(self.down, "sp_di2/lab")

    for i=1, 4 do
        local obj = self.down:get_child_by_name("content/new_small_card_item"..i)
        self.itemsShow[i] = UiSmallItem:new({parent=obj, prop={show_number=false}})
        self.itemsShow[i]:SetEnablePressGoodsTips(true)
    end

    --------------------------- 右部 ---------------------------
    local labWordsTips = ngui.find_label(self.ui, "animation/top_tips_lab")
    labWordsTips:set_text(string.format(_local.UIText[8], self.itemName))

    local labFreeTips = ngui.find_label(self.ui, "animation/right/left_cont/txt")
    local spOneDiscount = ngui.find_sprite(self.ui, "animation/right/left_cont/so_dazhe")
    local labOneDiscountCost = ngui.find_label(self.ui, "animation/right/left_cont/so_dazhe/lab")
    local labOneTips = ngui.find_label(self.ui, "animation/right/left_cont/lab_num")
    local btnOne = ngui.find_button(self.ui, "animation/right/left_cont/btn2")
    local spIconOne = ngui.find_sprite(self.ui, "animation/right/left_cont/sp_icon")
    local labIconOne = ngui.find_label(self.ui, "animation/right/left_cont/sp_icon/lab")
    local labIconOne1 = ngui.find_label(self.ui, "animation/right/left_cont/sp_icon/lab_xinzeng")
    local spLineOne = ngui.find_sprite(self.ui, "animation/right/left_cont/sp_icon/sp_line")
    local tipsFree = self.ui:get_child_by_name("lab_mianfei")

    local labTenTips = ngui.find_label(self.ui, "animation/right/right_cont/lab_num")
    local spTenDiscount = ngui.find_sprite(self.ui, "animation/right/right_cont/so_dazhe")
    local labTenDiscountCost = ngui.find_label(self.ui, "animation/right/right_cont/so_dazhe/lab")
    local btnTen = ngui.find_button(self.ui, "animation/right/right_cont/btn2")
    local spIconTen = ngui.find_sprite(self.ui, "animation/right/right_cont/sp_icon")
    local labIconTen = ngui.find_label(self.ui, "animation/right/right_cont/sp_icon/lab")
    local labIconTen1 = ngui.find_label(self.ui, "animation/right/right_cont/sp_icon/lab_xinzeng")
    local spLineTen = ngui.find_sprite(self.ui, "animation/right/right_cont/sp_icon/sp_line")
    local tipsCheap = self.ui:get_child_by_name("lab_chaozhi")

    local fxShowAni = self.ui:get_child_by_name("content_anim")

    local btnPreview = ngui.find_button(self.ui, "animation/btn_yulan")
    btnPreview:set_on_click(self.bindfunc["on_btn_preview"])

    labTenTips:set_text(string.format(_local.UIText[6], self.itemName))

    btnOne:set_on_click(self.bindfunc["on_one_btn"])
    btnTen:set_on_click(self.bindfunc["on_ten_btn"])

    self.labFreeTips = labFreeTips
    self.labOneTips = labOneTips
    self.labIconOne = labIconOne
    self.labIconOne1 = labIconOne1
    self.labIconTen = labIconTen
    self.labIconTen1 = labIconTen1
    self.spIconOne = spIconOne
    self.spIconTen = spIconTen
    self.spLineOne = spLineOne
    self.spLineTen = spLineTen
    self.spOneDiscount = spOneDiscount
    self.labOneDiscountCost = labOneDiscountCost
    self.spTenDiscount = spTenDiscount
    self.labTenDiscountCost = labTenDiscountCost

    self.tipsFree = tipsFree
    self.tipsCheap = tipsCheap
    self.fxShowAni = fxShowAni

    self:InitPreviewItem()
    self:UpdateUi()

end


function EquipBoxUI:UpdateUi(dt)
    if self.ui == nil then return end

    --碎片数量
    local fragCount = PropsEnum.GetValue(IdConfig.EquipDebris)
    self.labFragNum:set_text(PublicFunc.NumberToStringByCfg(fragCount))

    --今日抽次免费单抽
    if self.freeTimes > 0 then
        self.labFreeTips:set_text(_local.UIText[7])
    else
        self.labFreeTips:set_text(string.format(_local.UIText[1], PublicStruct.DayResetTime))
    end

    --单抽提示文字
    local count = self.useOnceTimes + 1
    --本次必出
    if count % 10 == 0 then
        self.labOneTips:set_text(string.format(_local.UIText[5], self.itemName))
        --X次后必出
    else
        self.labOneTips:set_text(string.format(_local.UIText[4], 10 - count % 10, self.itemName))
    end

    --显示折扣信息（运营要求免费次数，足够钥匙 也显示折扣）
    local onceCost, isDiscount, discountNum = self:GetOnceCost()
    if isDiscount then
        self.labOneDiscountCost:set_text(tostring(discountNum / 10))
        self.spOneDiscount:set_active(true)
    else
        self.spOneDiscount:set_active(false)
    end

    local boxKeyCount = PropsEnum.GetValue(IdConfig.EquipBoxKey)
    --单抽消耗计算 免费次数 - 足够钥匙 - 钻石
    if self.freeTimes > 0 then
        self.spIconOne:set_sprite_name("")
        self.labIconOne:set_text(_local.UIText[9])
        self.spLineOne:set_active(false)
        self.labIconOne1:set_active(false)
    elseif boxKeyCount >= 1 then
        self.spIconOne:set_sprite_name("yaoshi_cheng")
        self.labIconOne:set_text(tostring(boxKeyCount).."/1")
        self.spLineOne:set_active(false)
        self.labIconOne1:set_active(false)
    else
        self.spIconOne:set_sprite_name("dh_hongshuijing1")
        self.labIconOne:set_text(tostring(self.cfgEquipCost.once_cost))
        if isDiscount then
            self.spLineOne:set_active(true)
            self.labIconOne1:set_active(true)
            self.labIconOne1:set_text(tostring(onceCost))
        else
            self.labIconOne:set_text(tostring(self.cfgEquipCost.once_cost))
            self.spLineOne:set_active(false)
            self.labIconOne1:set_active(false)
        end
    end

    local tenCost, isDiscount, discountNum = self:GetTenCost()
    if isDiscount then
        self.labTenDiscountCost:set_text(tostring(discountNum * 10))
        self.spTenDiscount:set_active(true)
        self.spLineTen:set_active(false)
        self.labIconTen1:set_active(false)
    else
        self.spTenDiscount:set_active(false)
        self.spLineTen:set_active(false)
        self.labIconTen1:set_active(false)
    end
    --十连抽消耗计算 足够钥匙 - 钻石
    if boxKeyCount >= 10 then
        self.spIconTen:set_sprite_name("yaoshi_cheng")
        self.labIconTen:set_text(tostring(boxKeyCount).."/10")
        self.spLineTen:set_active(false)
        self.labIconTen1:set_active(false)
    else
        self.spIconTen:set_sprite_name("dh_hongshuijing1")
        self.labIconTen:set_text(tostring(self.cfgEquipCost.ten_cost))
        if isDiscount then
            self.spLineTen:set_active(true)
            self.labIconTen1:set_active(true)
            self.labIconTen1:set_text(tostring(tenCost))
        else
            self.labIconTen:set_text(tostring(self.cfgEquipCost.ten_cost))
            self.spLineTen:set_active(false)
            self.labIconTen1:set_active(false)
        end
    end

    if self.freeTimes > 0 then
        -- self.spIconOne:set_active(false)
        -- self.spOneFree:set_active(true)
        self.tipsFree:set_active(true)
    else
        -- self.spIconOne:set_active(true)
        -- self.spOneFree:set_active(false)
        self.tipsFree:set_active(false)
    end

    self.boxKeyCount = boxKeyCount
end

function EquipBoxUI:InitPreviewItem()
    for i, v in ipairs(self.itemsShow) do
        local data = self.cfgShowData[i]
        if data then
            v:SetDataNumber(data)
        else
            v:Hide()
        end
    end
end

function EquipBoxUI:GetOnceCost()
    local result, isDiscount = 0, false
    local onceCost = self.cfgEquipCost.once_cost
    local is_activity, discountNum, limitTimes
        = g_dataCenter.activityReward:GetBoxDiscount(ENUM.Activity.activityType_equip_box_discount)

    if is_activity and limitTimes > self.todayDiscountTimes then
        isDiscount = true
        result = math.floor(onceCost * discountNum / 100)
    else
        result = onceCost
    end

    return result, isDiscount, discountNum
end

function EquipBoxUI:GetTenCost()
    
    local result, isDiscount, discountNum = 0, false, 1
    local tenCost = self.cfgEquipCost.ten_cost

    if 0 == self.todayUseMoneyTenTimes then
        isDiscount = true
        discountNum = ConfigManager.Get(EConfigIndex.t_discrete, 83000209).data
        result = math.floor(tenCost * discountNum)
    else
        result = tenCost
    end

    return result, isDiscount, discountNum
end

function EquipBoxUI:on_exchange_btn()
    uiManager:PushUi(EUI.EquipFragExchangeUI)
end

function EquipBoxUI:on_one_btn()
    _local.is_again = nil
    local is_speed_up = (_local.is_speed_up == true)
    _local.is_speed_up = nil
    local func = function()
        _local.temp_data = nil
        msg_activity.cg_niudan_use(ENUM.NiuDanType.Equip, false);
        self:ShowAni(false, is_speed_up)
    end
    if self.freeTimes > 0 then
        func()
    elseif self.boxKeyCount < 1 then
        -- PublicFunc.BuyCheck(func, false, self.cfgEquipCost.once_cost, IdConfig.RedCrystal)
        local onceCost = self:GetOnceCost()
        local redCrystalCount = PropsEnum.GetValue(IdConfig.RedCrystal)
        if redCrystalCount >= onceCost then
            func()
        else
            uiManager:PushUi(EUI.ExchangeRedCrystalUI, {needcast = onceCost - redCrystalCount});
        end
    else
        func()
    end
end

function EquipBoxUI:on_ten_btn()
    _local.is_again = nil
    local is_speed_up = (_local.is_speed_up == true)
    _local.is_speed_up = nil
    local func = function()
        _local.temp_data = nil
        msg_activity.cg_niudan_use(ENUM.NiuDanType.Equip, true);
        self:ShowAni(true, is_speed_up)
    end
    if self.boxKeyCount < 10 then
        -- PublicFunc.BuyCheck(func, true, self.cfgEquipCost.ten_cost, IdConfig.RedCrystal)
        local redCrystalCount = PropsEnum.GetValue(IdConfig.RedCrystal)
        local tenCost = self:GetTenCost()
        if redCrystalCount >= tenCost then
            func()
        else
            uiManager:PushUi(EUI.ExchangeRedCrystalUI, {needcast = tenCost - redCrystalCount});
        end
    else
        func()
    end
end

function EquipBoxUI:one_btn_again()
    -- self:HideAni()
    _local.is_speed_up = true
    self:on_one_btn()
    _local.is_again = true
end

function EquipBoxUI:ten_btn_again()
    -- self:HideAni()
    _local.is_speed_up = true
    self:on_ten_btn()
    _local.is_again = true
end

function EquipBoxUI:on_item_data_change(cid)
    if cid == IdConfig.EquipDebris then
        self:UpdateUi()
    end
end

function EquipBoxUI:on_btn_preview(t)
    uiManager:PushUi(EUI.RewardPreviewShowUI, MsgEnum.eactivity_time.eActivityTime_Equip)
end

function EquipBoxUI:gc_update_equip_info(byfreeTime,CDLeftTime,useOnceTimes,useTenTimes,todayDiscountTimes,todayUseMoneyTenTimes)
    self.freeTimes = byfreeTime;
    self.useOnceTimes = useOnceTimes
    self.useTenTimes = useTenTimes
    self.todayDiscountTimes = todayDiscountTimes or 1;
    self.todayUseMoneyTenTimes = todayUseMoneyTenTimes or 0;

    self:UpdateUi()
end

function EquipBoxUI:gc_niudan_use(result, egg_type, bTen, vecReward, vecItem)
    _local.is_again = nil
    if self.fxShowAni then
        
        if _local.is_playing ~= false then
            _local.temp_data = {result, egg_type, bTen, vecReward, vecItem}
        else
            self:show_niudan_result(result, egg_type, bTen, vecReward, vecItem)
        end
    end
end

function EquipBoxUI:show_niudan_result(result, egg_type, bTen, vecReward, vecItem)
    if tonumber(egg_type) == ENUM.NiuDanType.Equip  then
        -- 装备
        if bTen then
            local randomReward = {}
            for i = 1, #vecReward do
                table.insert(randomReward, table.remove(vecReward, math.random( 1, #vecReward )))
            end

            if self.boxKeyCount >= 10 then
                CommonAward.Start(randomReward, CommonAwardEType.operatorAgain, nil,
                {againFunc=self.ten_btn_again, againParam=self, againCostId=IdConfig.EquipBoxKey, againCostNum=10, againCostOwn=self.boxKeyCount, againCostType=10})
                -- EggHeroGetTen.Start({vecReward = vecReward, costItemId = IdConfig.EquipBoxKey, costItemNum = 10, costItemOwn = self.boxKeyCount})
            else
                local tenCost = self:GetTenCost()
                CommonAward.Start(randomReward, CommonAwardEType.operatorAgain, nil,
                {againFunc=self.ten_btn_again, againParam=self, againCostId=IdConfig.RedCrystal, againCostNum=tenCost, againCostType=10})
                -- EggHeroGetTen.Start({vecReward = vecReward, costItemId = IdConfig.Crystal, costItemNum = self.cfgEquipCost.ten_cost})
            end
            -- EggHeroGetTen.SetCallback(self.ten_btn_again, self, self.UpdateUi, self)
        else
            if self.boxKeyCount >= 1 then
                CommonAward.Start(vecReward, CommonAwardEType.operatorAgain, nil,
                {againFunc=self.one_btn_again, againParam=self, againCostId=IdConfig.EquipBoxKey, againCostNum=1, againCostOwn=self.boxKeyCount, againCostType=1})
                -- EggHeroGetOne.Start({vecReward = vecReward, costItemId = IdConfig.EquipBoxKey, costItemNum = 1, costItemOwn = self.boxKeyCount})
            else
                local onceCost = self:GetOnceCost()
                CommonAward.Start(vecReward, CommonAwardEType.operatorAgain, nil,
                {againFunc=self.one_btn_again, againParam=self, againCostId=IdConfig.RedCrystal, againCostNum=onceCost, againCostType=1})
                -- EggHeroGetOne.Start({vecReward = vecReward, costItemId = IdConfig.Crystal, costItemNum = self.cfgEquipCost.once_cost})
            end
            -- EggHeroGetOne.SetCallback(self.one_btn_again, self, self.UpdateUi, self)
        end
    end

    CommonAward.SetFinishCallback(self.HideAni, self)
end

function EquipBoxUI:ShowAni(bTen, isSpeedUp)
    if self.fxShowAni then
        _local.is_playing = true
        if self.fxShowAni:get_active() then
            self.fxShowAni:set_active(false)
        end
        self.fxShowAni:set_active(true)
        self.down:set_active(false)
        if bTen then
            if isSpeedUp then
                self.fxShowAni:set_animated_speed("fx_kaibaoxiang2", 3)
            else
                self.fxShowAni:set_animated_speed("fx_kaibaoxiang2", 1)
            end
            self.fxShowAni:animated_play("fx_kaibaoxiang2")
        else
            if isSpeedUp then
                self.fxShowAni:set_animated_speed("fx_kaibaoxiang1", 3)
            else
                self.fxShowAni:set_animated_speed("fx_kaibaoxiang1", 1)
            end
            self.fxShowAni:animated_play("fx_kaibaoxiang1")
        end
    end
end

function EquipBoxUI:HideAni()
    if _local.is_again then return end
    _local.is_playing = nil
    if self.fxShowAni then
        self.fxShowAni:set_active(false)
        self.down:set_active(true)
    end

    --检查商店ui页签红点状态
    uiManager:UpdateMsgData(EUI.ShopUI, "UpdateYekaPoint")
end

function EquipBoxUI:CbShowResult()
    _local.is_playing = false
    if self.fxShowAni and _local.temp_data then
        self:show_niudan_result(unpack(_local.temp_data))
    end
end

-- 动画关键帧，打开结算界面
function EquipBoxUI.CbShowBoxAni()
    if uiManager then
        local curUi = uiManager:FindUI(EUI.ShopUI)
        if curUi and curUi.clsEquipBox then
            curUi.clsEquipBox:CbShowResult()
        end
    end
end

function EquipBoxUI.CbShowBoxUiAudio()
    if AudioManager ~= nil then
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.OpenEquipBox);
	end
end
