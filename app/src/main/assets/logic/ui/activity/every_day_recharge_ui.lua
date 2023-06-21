

EveryDayRechargeUI = Class("EveryDayRechargeUI", UiBaseClass)

local _TextInfo = {
    ["recharge_desc"] = "今日已充值[FDE517FF]%s[-]钻石，再充[FDE517FF]%s[-]钻石即可领取",
}

local _text = {
    [1] = "钻石不足";
    [2] = "钻石不足！是否前往充值？";
    [3] = "否";
    [4] = "前往";
   
}

local _ProgressValue = {
    [1] = 0,
    [2] = 0.2,
    [3] = 0.4,
    [4] = 0.6,
    [5] = 0.8,
}

function EveryDayRechargeUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1107_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function EveryDayRechargeUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.reward = g_dataCenter.activityReward
    self.activityId = MsgEnum.eactivity_time.eActivityTime_everydayRecharge

    self.itemObj = {}
    self.smallItemUi = {}
    self.awardUi = {}
end

function EveryDayRechargeUI:DestroyUi()
    UiBaseClass.DestroyUi(self)	
	-- 释放资源
    for _, v in pairs(self.smallItemUi) do
        if v then
            v:DestroyUi()
            v = nil
        end
    end
    self.smallItemUi = {}
    --[[if self.extAward and self.extAward.texture then
        self.extAward.texture:Destroy()
        self.extAward.texture = nil
    end]]
    if self.updateTimer ~= nil then 
        timer.stop(self.updateTimer)
        self.updateTimer = nil
   end

   if self.ext_small_item then
    self.ext_small_item:DestroyUi();
    self.ext_small_item = nil;
   end
end

function EveryDayRechargeUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["set_time"] = Utility.bind_callback(self, self.set_time)  
    self.bindfunc["on_award_item_click"] = Utility.bind_callback(self, self.on_award_item_click) 
    self.bindfunc["on_today_get"] = Utility.bind_callback(self, self.on_today_get)
    self.bindfunc["updateUi"] = Utility.bind_callback(self, self.updateUi) 
end

function EveryDayRechargeUI:MsgRegist()
    PublicFunc.msg_regist("msg_activity.EveryDayRechargeUI.updateUi", self.bindfunc['updateUi']) 
       
end

function EveryDayRechargeUI:MsgUnRegist()
    PublicFunc.msg_unregist("msg_activity.EveryDayRechargeUI.updateUi", self.bindfunc['updateUi']) 
end

function EveryDayRechargeUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	-- self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("every_day_recharge_ui");
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));

    local path = "center_other/animation/";

    self.lblCyrstal = ngui.find_label(self.ui, path .. "txt1");
    self.lblCyrstal:set_active(false);

    --充值钻石
    self.lblCyrstalNum = ngui.find_label(self.ui, path .. "txt1/lab_num")
    --倒计时
    self.lblTime = ngui.find_label(self.ui, path .. "txt_time")
    --充值描述
    self.lblRechargeDesc = ngui.find_label(self.ui, path .. "lab")
	--self.lab_txt = ngui.find_label(self.ui, path .. "txt")
    --self.lab_txt:set_text("活动期间内，累积充值5天，就可领取最终大奖");

    self.btnGet = ngui.find_button(self.ui, path .. "ui_button_get")
    self.btnGet:reset_on_click()
    self.btnGet:set_on_click(self.bindfunc["on_today_get"])
    self.btnGet_lab = ngui.find_label(self.ui, path .. "ui_button_get/animation/lab");
    self.btnGet_sp = ngui.find_sprite(self.ui, path .. "ui_button_get/animation/sp");

    --self.spGet = ngui.find_sprite(self.ui, path .. "ui_button_get/animation/sp")

    local cardInfo = nil;
    for i = 1, 3 do
        self.itemObj[i] = self.ui:get_child_by_name(path .. "new_small_card_item" .. i)
        cardInfo = CardProp:new({number = 1});
        if self.smallItemUi[i] == nil then   
            self.smallItemUi[i] = UiSmallItem:new({obj = nil, parent = self.itemObj[i], cardInfo = cardInfo, delay = 400}) 
        end
    end

    --进度条及按钮
    self.proAward = ngui.find_progress_bar(self.ui, path .."content/pro_di");
    for i = 1, 5 do         
        local _btn = ngui.find_button(self.ui, path .."cont1/btn_award" .. i);
        _btn:set_sprite_names("hd_guanbibaoxiang");
        _btn:reset_on_click()
        _btn:set_event_value("", i)
        _btn:set_on_click(self.bindfunc["on_award_item_click"])
                
        -- local _spGet = ngui.find_sprite(self.ui, path .."cont" .. i .. "/btn_award".. i .."/sp_get")        
        -- _spGet:set_active(false)        
        local _spPoint = ngui.find_sprite(self.ui, path .."cont1/btn_award".. i .."/sp_gift/sp_new")
        _spPoint:set_active(false)  

        local _spGiftObj = self.ui:get_child_by_name(path .."cont1/btn_award".. i .."/sp_gift")
        local _spGiftObj_sp = ngui.find_sprite(self.ui, path .."cont1/btn_award".. i .."/sp_gift");
        self.awardUi[i] = {btn = _btn, spGet = _spGet, spGiftObj = _spGiftObj, spGiftObj_sp = _spGiftObj_sp, spPoint = _spPoint}
    end

    --额外奖励
    self.ext_small_item_ui = self.ui:get_child_by_name(path .. "content/new_small_card_item");

    -- local cPath = path .. "content/sp_di/animation/"
    -- local _btn = ngui.find_button(self.ui, path .. "content/sp_di")
    -- local _bc = ButtonClick:new({obj = _btn});

    -- local _texture = ngui.find_texture(self.ui, cPath .. "Texture")
    -- local _lab = ngui.find_label(self.ui, cPath .. "lab")
    -- self.extAward = {
    --     bc = _bc,
    --     texture = _texture,
    --     lab = _lab
    -- }

    if self.updateTimer == nil then 
        self.updateTimer = timer.create(self.bindfunc["set_time"], 1000 ,-1);
    end

    -- msg_activity.cg_get_everyday_recharge_data();
    self:updateUi()

    --登录游戏服务器推送数据
end

function EveryDayRechargeUI:updateUi()
    if not self:IsShow() then
        return
    end

    --倒计时
    self:set_time()
    --领取到第几天
    local today = self.reward:getERDay()

    local need = self.reward:getERNeedCrystal(today)
    self.lblCyrstalNum:set_text(need .. "")
    --充值描述
    local have = self.reward:getERHaveCrystal()
    local diff = need - have
    if diff <= 0 then
        diff = 0
    end
    self.lblRechargeDesc:set_text(string.format(_TextInfo.recharge_desc, have, diff))
    --今日奖励
    local awards = self.reward:getERAwards(today)

    local cardInfo = nil;
    for i = 1, 3 do 
        local ad = awards[i] 
        if ad then 
            self.itemObj[i]:set_active(true)
            cardInfo = CardProp:new({number = ad.id, count = ad.count});
            -- self.smallItemUi[i]:SetDataNumber(ad.id, ad.count)
            self.smallItemUi[i]:SetData(cardInfo);
            self.smallItemUi[i]:SetCount(ad.count);
            --品质
            -- local frameName = self.reward:GetIconFrame(ad.id, ad.count)
            -- self.smallItemUi[i]:SetFrame(frameName);
        else
            self.itemObj[i]:set_active(false)
        end
    end
    ------------今日领取按钮---------
    --未完成充值 -> 变灰
    --完成充值 -> 正常
    --已领取 -> 变灰+已领取
    self.lblCyrstal:set_active(true);
    self.lblRechargeDesc:set_active(true);
    if not self.reward:isERComplete() then
        self.btnGet:set_enable(true)
        self.btnGet_lab:set_text("[973900FF]充值[-]");
        self.btnGet_sp:set_sprite_name("ty_anniu3")    
    else        
        if self.reward:isERCanGet(today) then
            self.btnGet:set_enable(true)
            self.btnGet_lab:set_text("[973900FF]领取[-]");
            self.btnGet_sp:set_sprite_name("ty_anniu3")
            self.lblCyrstal:set_active(false);
            self.lblRechargeDesc:set_active(false);
        else
            self.btnGet:set_enable(false)
            self.btnGet_lab:set_text("[C6C6C6FF]已领取[-]");
            self.btnGet_sp:set_sprite_name("ty_anniu5")
            self.lblCyrstal:set_active(false);
            self.lblRechargeDesc:set_active(false);
        end
    end

    --进度条    
    local value = _ProgressValue[today]
    if self.reward:isERComplete() then
        value = value + 0.2
    end
    self.proAward:set_value(value)

    --设置状态
    for i = 1, 5 do
        local aUi = self.awardUi[i]
        self:setBtnAwardStatus(today, i, aUi)
    end
    
    --额外奖励
    


    local item = self.reward:getERExtAwards()
    local id = item.id
    local num = item.count
    local carditem = CardProp:new({number = id});
    self.ext_small_item = UiSmallItem:new({parent = self.ext_small_item_ui, cardInfo = carditem});
    self.ext_small_item:SetLabNum(false);

    --self.extAward.bc:SetPress(GoodsTips.BCShow, {id = id, count = num})
    -- if PublicFunc.IdToConfig(id) ~= nil then
    --     local iconPath = PublicFunc.IdToConfig(id).small_icon;
    --     if iconPath ~= nil then
    --         self.extAward.texture:set_texture(iconPath)
    --     end
    -- end
    -- self.extAward.lab:set_text("x" .. num)
end

--[[进度条按钮状态]]
function EveryDayRechargeUI:setBtnAwardStatus(today, day, aUi)
    local isComplete = false
    if day < today then
        isComplete = true
    elseif day == today then
        isComplete = self.reward:isERComplete()
    end

    -- aUi.spGet:set_active(false)
    aUi.spPoint:set_active(false)
    -- aUi.spGiftObj:set_animator_enable(false)    
        
    --未完成充值 -> 正常态(不播放动画)
    if not isComplete then
        aUi.btn:set_enable(true)    
        app.log("day = " .. day .. "----------- 238");    
    --完成充值 -> 正常态(播放动画)    
    else
        if self.reward:isERCanGet(day) then
            app.log("day = " .. day .. "----------- 242");    
            aUi.btn:set_enable(true)
            aUi.btn:set_sprite_names("hd_guanbibaoxiang")
            aUi.btn:set_enable(true);   
            aUi.spPoint:set_active(true)
            aUi.spGiftObj:set_animator_enable(true)
            aUi.spGiftObj_sp:set_sprite_name("hd_guanbibaoxiang");
        --已领取 -> 变灰+已领取
        else
            -- aUi.spGet:set_active(true)   
            -- aUi.btn:set_enable(false)
            app.log("day = " .. day .. "----------- 253");    
            aUi.btn:set_sprite_names("hd_kaiqibaoxiang")
            aUi.spGiftObj_sp:set_sprite_name("hd_kaiqibaoxiang");
            aUi.spGiftObj:set_animator_enable(false);
            -- aUi.spGiftObj:set_active(false);
            -- aUi.btn:set_enable(false);         
        end
    end  
end

--[[倒计时]]
function EveryDayRechargeUI:set_time()
    -- local diffSec = self.reward:getGmActivityEndTime(self.activityId) - system.time()    
    -- if diffSec <= 0 then return end
    -- local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
    -- if self.lblTime then
    --     self.lblTime:set_text(day .. "天" .. string.format("%02d:", hour) 
    --         .. string.format("%02d:", min) .. string.format("%02d", sec))
    -- end
    local diffTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_everyday_recharge_total);
    local diffSec = diffTime.e_time - system.time();

    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
    self.lblTime:set_text("活动倒计时:" .. day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
    if diffSec <= 0 then
        if self.updateTimer ~= 0 then 
            timer.stop(self.updateTimer);
            self.updateTimer = 0;
            self.lblTime:set_text("0天00:00:00");
        end
    end
end

--[[今日领奖]]
function EveryDayRechargeUI:on_today_get(t)
    local day = self.reward:getERDay()
    if self.reward:isERCanGet(day) then
        GLoading.Show(GLoading.EType.msg)
        msg_activity.cg_get_everyday_recharge_gift_bag(day)
    else
        -- uiManager:PushUi(EUI.StoreUI) 
        HintUI.SetAndShowNew(EHintUiType.two, _text[1], _text[2], nil, {str = _text[4],func = self["go_to_store"]}, {str = _text[3],func = nil}, btn3Data, btn4Data)
   
    end    
end

function EveryDayRechargeUI:go_to_store()
    uiManager:PushUi(EUI.StoreUI);
end

--[[领奖]]
function EveryDayRechargeUI:on_award_item_click(t)
    local day = t.float_value
    if self.reward:isERCanGet(day) then
        GLoading.Show(GLoading.EType.msg)
        msg_activity.cg_get_everyday_recharge_gift_bag(day)
    else
        local data = self.reward:getERAwards(day)
        uiManager:PushUi(EUI.AwardPreviewUI, data)
    end    
end

function EveryDayRechargeUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
    --todo 各自额外的逻辑
    end
end