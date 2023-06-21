
BuyFightTimesUi = Class('BuyFightTimesUi', UiBaseClass)
--WorldBossBuyTimesUI 继承该类

local _UIText = {
    ["not_enough_cost"] = "%s不足",
    ["buy_count_0_tips"] = "请选择购买数量",
}

--设置回调函数
function BuyFightTimesUi:SetCallback(callback, callParam)
    self.callback = callback
    self.callParam = callParam
end

--设置数据data
-- data
--      costCount    消耗货币数量
--      maxCount    可购买最大次数
function BuyFightTimesUi:SetData(data)
    self.costCount = data.costCount or 1
    self.costId = IdConfig.Crystal

    self.ownCost = PropsEnum.GetValue(self.costId)
    self.useCount = data.useCount or 0
    self.maxCount = data.maxCount or (self.useCount + 1)
    self.counter = 1    -- 选择购买计数

    self:UpdateUi()
end

function BuyFightTimesUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/arena/ui_4409_jjc_tc.assetbundle"
	UiBaseClass.Init(self, data);
end

function BuyFightTimesUi:InitData()
	UiBaseClass.InitData(self, data)
end

function BuyFightTimesUi:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function BuyFightTimesUi:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
	self.bindfunc["on_buy_btn"] = Utility.bind_callback(self, self.on_buy_btn)
    self.bindfunc["on_click_min"] = Utility.bind_callback(self, self.on_click_min)
    self.bindfunc["on_click_max"] = Utility.bind_callback(self, self.on_click_max)
    self.bindfunc["on_slider_value_change"] = Utility.bind_callback(self, self.on_slider_value_change)
end

function BuyFightTimesUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("buy_fight_times_ui")

    local btnClose = ngui.find_button(self.ui, "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    -----------------------------------购买ui-------------------------------------------
    local path = "centre_other/animation/cont/"
    self.labPrice = ngui.find_label(self.ui, path.."txt/lab")
    self.labBuyCount = ngui.find_label(self.ui, path.."have/lab_num1")

    local btnBuy = ngui.find_button(self.ui, path.."btn1")
    btnBuy:set_on_click(self.bindfunc["on_buy_btn"])

    self.slider = ngui.find_slider(self.ui, path.."act/pro_back")
    self.slider:set_on_change(self.bindfunc["on_slider_value_change"])
    
    self.btnMin = ngui.find_button(self.ui, path.."act/btn_red")
    self.btnMinSp = ngui.find_sprite(self.ui, path .. "act/btn_red/sp_red")
    self.btnMax = ngui.find_button(self.ui, path.."act/btn_blue")
    self.btnmaxSp = ngui.find_sprite(self.ui, path .. 'act/btn_blue/sp_red')
    self.btnMin:set_on_click(self.bindfunc["on_click_min"])
    self.btnMax:set_on_click(self.bindfunc["on_click_max"])

    self.ui:set_active(false)

    self:UpdateUi()
end

function BuyFightTimesUi:UpdateUi()
    if not self.ui then return end

    if self.maxCount then
        self.ui:set_active(true)
        self.slider:set_steps(self.maxCount+1)
        self.slider:set_value(1/self.maxCount)

        self:UpdateSliderValue(1)
    end
end

function BuyFightTimesUi:UpdateSliderValue(count)
    self.counter = count
    local totalCost = self:GetCost(self.counter)
    self.labBuyCount:set_text("" .. self.counter)
    self.labPrice:set_text(tostring(totalCost))
    --货币数量文字颜色
    if totalCost > self.ownCost then
        self.labPrice:set_color(1,0,0,1)
    else
        self.labPrice:set_color(253/155,229/255,23/255,1)
    end
    
    if self.counter >= self.maxCount then
        --PublicFunc.SetButtonShowMode(self.btnMax, 3, "sp_red", "lab_min")
        self.btnmaxSp:set_color(0,0,0,1)
	else
        --PublicFunc.SetButtonShowMode(self.btnMax, 1, "sp_red", "lab_min")
        self.btnmaxSp:set_color(1,1,1,1)
	end 

    if self.counter < 1 then
		--PublicFunc.SetButtonShowMode(self.btnMin, 3, "sp_red", "lab_min")
        self.btnMinSp:set_color(0,0,0,1)
	else
		--PublicFunc.SetButtonShowMode(self.btnMin, 2, "sp_red", "lab_min")
        self.btnMinSp:set_color(1,1,1,1)
	end 
end

function BuyFightTimesUi:GetCost(count)
    local totalCost = 0
    local costMaxNum = ConfigManager.GetDataCount(EConfigIndex.t_arena_cost)
    for i=self.useCount + 1, self.useCount + count do
	    local costIndex = math.min(i, costMaxNum)
        totalCost = totalCost + ConfigManager.Get(EConfigIndex.t_arena_cost,costIndex).challenge_cost
    end
    return totalCost
end

function BuyFightTimesUi:on_buy_btn()
    if self.counter == 0 then
        FloatTip.Float(_UIText["buy_count_0_tips"])
        return
    end
    local totalCost = self:GetCost(self.counter)
    if self.ownCost < totalCost then
        local config = ConfigManager.Get(EConfigIndex.t_item, self.costId)
        local str = string.format(_UIText["not_enough_cost"], config.name)
        FloatTip.Float(str)
        -- uiManager:PushUi(EUI.StoreUI)
        return
    end

    self:Hide()

    if self.callback then
        local data = {}
        data.totalCount = self.counter
        data.totalCost = totalCost
        Utility.CallFunc(self.callback, self.callParam, data)

        self.callback = nil
        self.callParam = nil
    end
end

function BuyFightTimesUi:on_click_min(t)

    local value = self.slider:get_value()
    if value <= 0 then return end
    value = value - 1/(self.maxCount - 1)

    self.slider:set_value(value)
end

function BuyFightTimesUi:on_click_max(t)

    local value = self.slider:get_value()
    if value >= 1 then return end
    value = value + 1/(self.maxCount - 1)

    self.slider:set_value(value)
end

function BuyFightTimesUi:on_close()
	self:Hide()
end

function BuyFightTimesUi:on_slider_value_change(value)
    local count = PublicFunc.Round(value * self.maxCount)
	self:UpdateSliderValue(count)
end
