
AllServerBuyUI = Class("AllServerBuyUI", UiBaseClass)

local resPath = "assetbundles/prefabs/ui/award/ui_1133_award.assetbundle";


local _DayText = {'一','二','三','四','五','六','七'}

local _UIText = {
    [1] = "第%s天",
    [2] = "活动开启后的第%s天\n05:00开放购买",    
    [3] = "活动倒计时:%s天%02d:%02d:%02d", 
    [4] = "%s",  
    [5] = "购买成功",   

    [6] = "好感度不够",
    [7] = "钻石不足",
    [8] = "前往充值",
}

function AllServerBuyUI:Init(data)
    self.pathRes = resPath
    UiBaseClass.Init(self, data);
end

function AllServerBuyUI:Restart()
    self.itemList = {}
    self.dtAdd = 0 
   
    self.currDay = nil
    if UiBaseClass.Restart(self, data) then
    end
end

function AllServerBuyUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["gc_change_activity_time"]= Utility.bind_callback(self, self.gc_change_activity_time);
    self.bindfunc["on_select_yeka"] = Utility.bind_callback(self, self.on_select_yeka)
    self.bindfunc["on_buy"] = Utility.bind_callback(self, self.on_buy)  
    self.bindfunc["gc_get_all_buy_state"] = Utility.bind_callback(self, self.gc_get_all_buy_state)
    self.bindfunc["gc_all_buy_item"] = Utility.bind_callback(self, self.gc_all_buy_item)
end

function AllServerBuyUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist("msg_activity.gc_change_activity_time", self.bindfunc["gc_change_activity_time"]);

    PublicFunc.msg_regist(msg_activity.gc_get_all_buy_state, self.bindfunc["gc_get_all_buy_state"]);
    PublicFunc.msg_regist(msg_activity.gc_all_buy_item, self.bindfunc["gc_all_buy_item"]);
end

function AllServerBuyUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist("msg_activity.gc_change_activity_time", self.bindfunc["gc_change_activity_time"]);

    PublicFunc.msg_unregist(msg_activity.gc_get_all_buy_state, self.bindfunc["gc_get_all_buy_state"]);
    PublicFunc.msg_unregist(msg_activity.gc_all_buy_item, self.bindfunc["gc_all_buy_item"]);
end

function AllServerBuyUI:DestroyUi()
    for _, v in pairs(self.itemList) do
        if v.smallItem then
            v.smallItem:DestroyUi()
            v.smallItem = nil
        end
    end   
    UiBaseClass.DestroyUi(self);
end

function AllServerBuyUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("all_server_buy_ui");
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));

    local aniPath = "center_other/animation/"

    self.lblTime = ngui.find_label(self.ui, aniPath .. "texture_title/lab_time")
    local lblActivityDesc = ngui.find_label(self.ui, aniPath .. "texture_title/lab_word")
    local playConfig = ConfigManager.Get(EConfigIndex.t_activity_play, ENUM.Activity.activityType_all_buy)
    if playConfig and playConfig.activity_info then
        lblActivityDesc:set_text(tostring(playConfig.activity_info))
    end
   
    self.gridTab = ngui.find_grid(self.ui, aniPath .. "grid")
    local objGridTab = self.gridTab:get_game_object()
    local cloneYeka = self.ui:get_child_by_name(aniPath .. "grid/yeka")
    cloneYeka:set_active(false)
    
    local days = ConfigManager.GetDataCount(EConfigIndex.t_all_buy)
    self.activityDay = self:GetActivityDay()  
    if self.activityDay >= days then
        self.activityDay = days
    end

    self.yekaList = {}
    for i = 1, days do
        local temp = {}
        temp.obj = cloneYeka:clone()
        temp.obj:set_parent(objGridTab) 
        temp.obj:set_name('day'.. i)
        temp.obj:set_active(true)

        temp.spBlue = ngui.find_sprite(temp.obj, "sp_lan")
        temp.spChoose = ngui.find_sprite(temp.obj, "sp_zi")
        
        temp.lblDay = ngui.find_label(temp.obj, "lab_tian1")
        temp.lblDay:set_text(string.format(_UIText[1], _DayText[i]))
        temp.toggle = ngui.find_toggle(temp.obj, "day" .. i)

        local btnYeka = ngui.find_button(temp.obj, "day" .. i)
        --未开放， 不能点击
        if self:IsOpenBuy(i) then
            btnYeka:set_event_value("", i)
            btnYeka:set_enable(true)
            btnYeka:set_on_click(self.bindfunc["on_select_yeka"], "MyButton.Flag")
        else
            btnYeka:set_enable(false)
        end
        self.yekaList[i] = temp
    end
    self.gridTab:reposition_now() 

    --sprite设置
    for i = 1, days do
        local yeka = self.yekaList[i]
        if i == 1 then
            yeka.spChoose:set_sprite_name('ty_anniu1') 
            yeka.spBlue:set_sprite_name('ty_anniu2') 
        elseif i == days then
            yeka.spChoose:set_sprite_name('ty_anniu6') 
            yeka.spBlue:set_sprite_name('ty_anniu7')  
        else
            yeka.spChoose:set_sprite_name('ty_anniu8') 
            yeka.spBlue:set_sprite_name('ty_anniu9')  
        end
    end

    local itemPath = {"sp_left", "sp_right"}
    for k, v in pairs(itemPath) do
        local item = {}
        local iPath = aniPath .. v .. '/'

        --item.spDiscount = ngui.find_sprite(self.ui, iPath .. 'sp_zhekou')
        item.lblDiscount = ngui.find_label(self.ui, iPath .. 'sp_zhekou/lab_zhekou')
        item.imgVip = ngui.find_sprite(self.ui, iPath .. 'sp_bar')
        item.lblVip = ngui.find_label(self.ui, iPath .. 'sp_bar/sp_v/lab_v')
        item.lblVip_star = ngui.find_label(self.ui, iPath .. 'sp_bar/sp_v/lab_v2')

        local objItem = self.ui:get_child_by_name(iPath .. "new_small_card_item")
        item.smallItem =  UiSmallItem:new({parent = objItem, cardInfo = nil, delay = 400, is_enable_goods_tip = true})
        item.lblItemName = ngui.find_label(self.ui, iPath .. 'lab_name')
        item.lblItemName:set_color(1,1,1,1) --调整文字为白色，使用内嵌color

        item.lblOrigPrice = ngui.find_label(self.ui, iPath .. 'sp_bar1/lab_num')
        item.lblDiscountPrice = ngui.find_label(self.ui, iPath .. 'sp_bar2/lab_num')
        item.lblServerCount = ngui.find_label(self.ui, iPath .. 'txt_cishu/lab_cishu') 
        item.lblHintInfo = ngui.find_label(self.ui, iPath .. 'lab_tishi')        

        item.btnBuy = ngui.find_button(self.ui, iPath .. 'btn_cheng')
        item.btnBuy:set_on_click(self.bindfunc["on_buy"])
        --item.spBtnBuy = ngui.find_sprite(self.ui, iPath .. 'btn_cheng/animation/sp')  
              
        item.spBuy = ngui.find_sprite(self.ui, iPath .. 'sp_art_font')
        self.itemList[k] = item
    end   
    self:Hide()
    
    self:on_select_yeka({float_value = self.activityDay})  
    g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_all_buy, 0);
end

--[[选中页卡]]
function AllServerBuyUI:SelectdTab()
    for day, v in pairs(self.yekaList) do
        if v.toggle then
            v.toggle:set_value(day == self.currDay)
        end
    end
end

function AllServerBuyUI:gc_change_activity_time(t)
    --更新天数
    --self.activityDay = self:GetActivityDay()
    --self:UpdateUi()
end

--[[可购数量及状态返回]]
function AllServerBuyUI:gc_get_all_buy_state()
    if not self:IsShow() then
        self:Show()
        self:SelectdTab()
    end
    self:UpdateUi()
end

function AllServerBuyUI:gc_all_buy_item(result)
    self:UpdateUi()
    if result == 0 then 
        FloatTip.Float(_UIText[5])
    end
end

function AllServerBuyUI:on_select_yeka(t)
    if t.float_value ~= self.currDay then
        self.currDay = t.float_value  
        for day, v in pairs(self.yekaList) do
            if day == self.currDay then
                v.lblDay:set_color(140/255, 66/255, 19/255, 1)
            else
                v.lblDay:set_color(1, 1, 1, 1)  
            end
        end
        if self:IsOpenBuy(self.currDay) then
            msg_activity.cg_get_all_buy_state(self.currDay)
        else
            self:UpdateUi()
        end
    end 
end

function AllServerBuyUI:on_buy(t)
    local day = tonumber(t.string_value)
    local option = t.float_value
    local buyConfig = ConfigManager.Get(EConfigIndex.t_all_buy, day)
    --vip 
    local needVip = buyConfig['item_' .. option .. '_vip']
    if g_dataCenter.player:GetVip() < needVip then
        HintUI.SetAndShowNew(EHintUiType.one, 
        "", _UIText[6], 
        nil,
        {func=function() uiManager:PushUi(EUI.VipPackingUI) end, str = _UIText[8]});
        return
    end
    --钻石
    if PropsEnum.GetValue(IdConfig.Crystal) <  buyConfig['dis_price_' .. option] then
        HintUI.SetAndShowNew(EHintUiType.one, 
        "", _UIText[7], 
        nil,
        {func=function() uiManager:PushUi(EUI.StoreUI) end, str = _UIText[8]});
        return
    end
    msg_activity.cg_all_buy_item(day, option)
end

function AllServerBuyUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return
    end        
    self:CountDown()
    
    --页卡逻辑
    for day, yeka in pairs(self.yekaList) do
        if self:IsOpenBuy(day) then
            PublicFunc.SetUISpriteWhite(yeka.spBlue)
        else
            PublicFunc.SetUISpriteGray(yeka.spBlue)
        end
    end         

    local buyConfig = ConfigManager.Get(EConfigIndex.t_all_buy, self.currDay)
    if buyConfig then
        local buyState = g_dataCenter.activityReward:GetServerBuyState(self.currDay)

        for k, item in pairs(self.itemList) do     
            item.lblDiscount:set_text(string.format(_UIText[4], buyConfig['dis_' .. k]))
            item.lblOrigPrice:set_text(tostring(buyConfig['price_' .. k]))

            local disPrice = buyConfig['dis_price_' .. k]
            item.lblDiscountPrice:set_text(tostring(disPrice))

            local needVip = buyConfig['item_' .. k .. '_vip']
            if item.imgVip then
                item.imgVip:set_active(needVip ~= 0)
            end
            -- PublicFunc.SetImageVipLevel(item.imgVip, needVip)
            if item.lblVip and item.lblVip_star then
                local cur_vipdata = g_dataCenter.player:GetVipDataByLevel( needVip );
                if cur_vipdata then
                    item.lblVip:set_text(tostring(cur_vipdata.level)) 
                    item.lblVip_star:set_text("-"..tostring(cur_vipdata.level_star))
                end
            end
            item.smallItem:SetDataNumber(buyConfig['item_id_' .. k], buyConfig['item_num_' .. k])      
            
            local cardInfo = item.smallItem:GetCardInfo()            
            local info = PublicFunc.IdToConfig(cardInfo.number)
            if info ~= nil and info.rarity ~= nil then
                local color_str  = PublicFunc.GetItemRarityColor(info.rarity)
		        local color_name = "[" .. color_str .. "]" ..info.name.."[-]"
                item.lblItemName:set_text(color_name)
            end

            item.btnBuy:set_active(false)
            item.spBuy:set_active(false)
            item.lblHintInfo:set_active(false)

            --已开放
            if self:IsOpenBuy(self.currDay) then
                local count = buyState[k].count
                local isBuy = buyState[k].isBuy
                --已售罄
                if count == 0 then
                    item.lblServerCount:set_text('0')
                    item.spBuy:set_active(true)
                    item.spBuy:set_sprite_name('sc_yishouqing')
                else
                    item.lblServerCount:set_text(tostring(count))
                    --已购买
                    if isBuy then
                        item.spBuy:set_active(true)
                        item.spBuy:set_sprite_name('yigoumai')
                    else
                        item.btnBuy:set_active(true)
                        item.btnBuy:set_event_value(tostring(self.currDay), k)

                        --vip,钻石检查
                        if g_dataCenter.player:GetVip() < needVip or PropsEnum.GetValue(IdConfig.Crystal) < disPrice then
                            PublicFunc.SetButtonShowMode(item.btnBuy, 3)
                        else
                            PublicFunc.SetButtonShowMode(item.btnBuy, 1)
                        end
                    end
                end  

            --未开放           
            else
                item.lblServerCount:set_text('--')
                item.lblHintInfo:set_active(true)
                item.lblHintInfo:set_text(string.format(_UIText[2], self.currDay))
            end
        end
    end
end

function AllServerBuyUI:IsOpenBuy(day)
    return day <= self.activityDay 
end

function AllServerBuyUI:CountDown()
    if self.lblTime == nil or self.activityEndTime == nil then
        return
    end
    local diffSec = self.activityEndTime - system.time()
    if diffSec > 0 then 
        local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
        self.lblTime:set_text(string.format(_UIText[3], day,hour,min,sec))
    end
end

function AllServerBuyUI:Update(dt)
    self.dtAdd = self.dtAdd + dt
    if self.dtAdd >= 1 then
        self.dtAdd = 0 
        self:CountDown()
    end
end

function AllServerBuyUI:GetActivityDay()    
    local config = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_all_buy)
    if config then
        self.activityStartTime = config.s_time
        self.activityEndTime = config.e_time
    else
        app.log('获取全服活动时间失败' .. debug.traceback())
    end
    if self.activityStartTime ~= nil then
        local diffSec = system.time() - self.activityStartTime
        if diffSec > 0 then
            local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
            app.log('==============>>>' .. day ..' ' .. hour .. ':'.. min .. ':'.. sec) 
            return day + 1  
        end
    end
    return 1
end