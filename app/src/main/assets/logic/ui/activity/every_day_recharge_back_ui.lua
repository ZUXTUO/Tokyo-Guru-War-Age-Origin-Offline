

EveryDayRechargeBackUI = Class("EveryDayRechargeBackUI", UiBaseClass)

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

function EveryDayRechargeBackUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1107_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function EveryDayRechargeBackUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.reward = g_dataCenter.activityReward
    self.activityId = MsgEnum.eactivity_time.activityType_everyday_recharge_total_back_time

    self.itemObj = {}
    self.smallItemUi = {}
    self.awardUi = {}
end

function EveryDayRechargeBackUI:DestroyUi()
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

function EveryDayRechargeBackUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["set_time"] = Utility.bind_callback(self, self.set_time)  
    self.bindfunc["on_award_item_click"] = Utility.bind_callback(self, self.on_award_item_click) 
    self.bindfunc["on_today_get"] = Utility.bind_callback(self, self.on_today_get)
    self.bindfunc["updateUi"] = Utility.bind_callback(self, self.updateUi) 

    self.bindfunc["gc_every_recharge_back_state"] = Utility.bind_callback(self, self.gc_every_recharge_back_state);
    self.bindfunc["gc_every_recharge_back_get_award"] = Utility.bind_callback(self, self.gc_every_recharge_back_get_award);
end

function EveryDayRechargeBackUI:MsgRegist()
    PublicFunc.msg_regist("msg_activity.EveryDayRechargeBackUI.updateUi", self.bindfunc['updateUi']) 
    
    PublicFunc.msg_regist(msg_activity.gc_every_recharge_back_state, self.bindfunc['gc_every_recharge_back_state']) 
    PublicFunc.msg_regist(msg_activity.gc_every_recharge_back_get_award, self.bindfunc['gc_every_recharge_back_get_award']) 
end

function EveryDayRechargeBackUI:MsgUnRegist()
    PublicFunc.msg_unregist("msg_activity.EveryDayRechargeBackUI.updateUi", self.bindfunc['updateUi']) 

     PublicFunc.msg_unregist(msg_activity.gc_every_recharge_back_state, self.bindfunc['gc_every_recharge_back_state']) 
     PublicFunc.msg_unregist(msg_activity.gc_every_recharge_back_get_award, self.bindfunc['gc_every_recharge_back_get_award']) 
end

function EveryDayRechargeBackUI:InitUI(asset_obj)
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
    self.btnGet:set_active(false);
    self.btnGet:reset_on_click()
    self.btnGet:set_on_click(self.bindfunc["on_today_get"])
    self.btnGet_lab = ngui.find_label(self.ui, path .. "ui_button_get/animation/lab");
    self.btnGet_sp = ngui.find_sprite(self.ui, path .. "ui_button_get/animation/sp");

    --self.spGet = ngui.find_sprite(self.ui, path .. "ui_button_get/animation/sp")

    local cardInfo = nil;
    for i = 1, 3 do
        self.itemObj[i] = self.ui:get_child_by_name(path .. "new_small_card_item" .. i);
        self.itemObj[i]:set_active(false);
        cardInfo = CardProp:new({number = 1});
        if self.smallItemUi[i] == nil then   
            self.smallItemUi[i] = UiSmallItem:new({obj = nil, parent = self.itemObj[i], cardInfo = cardInfo, delay = 400}) 
        end
    end

    --进度条及按钮
    self.proAward = ngui.find_progress_bar(self.ui, path .."content/pro_di");
    self.proAward:set_value(0);
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

    if self.updateTimer == nil then 
        self.updateTimer = timer.create(self.bindfunc["set_time"], 1000 ,-1);
    end

    msg_activity.cg_every_recharge_back_state();
end

function EveryDayRechargeBackUI:updateUi()
    if not self:IsShow() then
        return
    end

    --倒计时
    self:set_time()
    --领取到第几天
    local today = self.m_day;
    local need = self.m_current_award.finish_need;
    self.lblCyrstalNum:set_text(need .. "")
    --充值描述
    local have = self.m_progress;
    local diff = need - have
    if diff <= 0 then
        diff = 0
    end
    self.lblRechargeDesc:set_text(string.format(_TextInfo.recharge_desc, have, diff))
    --今日奖励
    local award_list = Utility.lua_string_split(self.m_current_award.award_list, ",");
    local awards = {};
    for k,v in pairs(award_list) do
        table.insert(awards, Utility.lua_string_split(v, "#"));
    end   

    local cardInfo = nil;
    for i = 1, 3 do 
        if self.itemObj[i] and self.smallItemUi[i] then
            local ad = awards[i];
            app.log("ad181: " .. table.tostring(ad));
            if ad and ad[1] and tostring(ad[1]) ~= "" and ad[2] and tostring(ad[2]) ~= "" then
                self.itemObj[i]:set_active(true);
                cardInfo = CardProp:new({number = tonumber(ad[1]), count = tonumber(ad[2])});
                self.smallItemUi[i]:SetData(cardInfo);
                self.smallItemUi[i]:SetCount(tonumber(ad[2]));
            else
                self.itemObj[i]:set_active(false);
            end
        end
    end
    ------------今日领取按钮---------
    --未完成充值 -> 变灰
    --完成充值 -> 正常
    --已领取 -> 变灰+已领取
    self.lblCyrstal:set_active(true);
    self.lblRechargeDesc:set_active(true);
    local state = self.m_current_award.state;
    if state == 0 then
        self.btnGet:set_enable(true)
        -- self.btnGet:set_sprite_names("ty_anniu3");
        self.btnGet_lab:set_text("[973900FF]充值[-]");
        self.btnGet_sp:set_sprite_name("ty_anniu3")
    elseif state == 1 then
        self.btnGet:set_enable(true)
        -- self.btnGet:set_sprite_names("ty_anniu3");
        self.btnGet_lab:set_text("[973900FF]领取[-]");
        self.btnGet_sp:set_sprite_name("ty_anniu3")
        -- self.spGet:set_sprite_name("hd_mr_lingqu")
        self.lblCyrstal:set_active(false);
        self.lblRechargeDesc:set_active(false);
    else
        self.btnGet:set_enable(false)
        -- self.btnGet:set_sprite_names("ty_anniu5");
        self.btnGet_lab:set_text("[C6C6C6FF]已领取[-]");
        self.btnGet_sp:set_sprite_name("ty_anniu5")
        -- PublicFunc.SetUILabelEffectGray(self.btnGet_lab)
        -- self.spGet:set_sprite_name("hd_mr_yilingqu")
        self.lblCyrstal:set_active(false);
        self.lblRechargeDesc:set_active(false);
    end
     self.btnGet:set_active(true);

    --进度条    
    local value = _ProgressValue[self.m_day];
    if self.m_current_award.state ~= 0 then
        value = value + 0.2
    end
    self.proAward:set_value(value)

    --设置状态
    local is_red_point_state = 0;
    for i = 1, 5 do
        local aUi = self.awardUi[i]
        self:setBtnAwardStatus(self.m_day, i, aUi)

        if self.m_award[i].state == 1 then
            is_red_point_state = 1;
        end
    end
    g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_everyday_recharge_total_back_time, is_red_point_state);
    
    --额外奖励
    
    local ext_item_str = self.m_award[#self.m_award];
    local ext_item_list = Utility.lua_string_split(ext_item_str.award_list, ",");
    local item = Utility.lua_string_split(ext_item_list[1], "#");
    app.log("ext_item_str:" .. ext_item_str.award_list .. "ext_item_list:" .. table.tostring(ext_item_list));
    local id = tonumber(item[1]);
    local num = tonumber(item[2]);
    local carditem = CardProp:new({number = id});
    self.ext_small_item = UiSmallItem:new({parent = self.ext_small_item_ui, cardInfo = carditem});
    self.ext_small_item:SetLabNum(true);
    self.ext_small_item:SetCount(num);
end

--[[进度条按钮状态]]
function EveryDayRechargeBackUI:setBtnAwardStatus(today, day, aUi)
    local isComplete = 2
    if day < today then
        isComplete = self.m_award[day].state;
    elseif day == today then
        isComplete = self.m_current_award.state;
    elseif day > today then
        isComplete = 0;
    end

    -- aUi.spGet:set_active(false)
    aUi.spPoint:set_active(false)
    -- aUi.spGiftObj:set_animator_enable(false)    
        
    --未完成充值 -> 正常态(不播放动画)
    if isComplete == 0 then
        aUi.btn:set_enable(true)    
        app.log("day = " .. day .. "----------- 238");    
    --完成充值 -> 正常态(播放动画)    
    elseif isComplete == 1 then
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

--[[倒计时]]
function EveryDayRechargeBackUI:set_time()
    local diffTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_everyday_recharge_total_back_time);
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
function EveryDayRechargeBackUI:on_today_get(t)
    local day = self.m_day;
    if self.m_current_award.state == 1 then
        -- GLoading.Show(GLoading.EType.msg)
        msg_activity.cg_every_recharge_back_get_award(day)
    else
        -- uiManager:PushUi(EUI.StoreUI) 
        HintUI.SetAndShowNew(EHintUiType.two, _text[1], _text[2], nil, {str = _text[4],func = self["go_to_store"]}, {str = _text[3],func = nil}, btn3Data, btn4Data)
   
    end    
end

function EveryDayRechargeBackUI:go_to_store()
    uiManager:PushUi(EUI.StoreUI);
end

--[[领奖]]
function EveryDayRechargeBackUI:on_award_item_click(t)
    local day = t.float_value
    if self.m_award[day] and self.m_award[day].state == 1 then
        -- GLoading.Show(GLoading.EType.msg)
        msg_activity.cg_every_recharge_back_get_award(day);
    else
        local cur_award = self.m_award[day];
        local item_list = Utility.lua_string_split(cur_award.award_list, ",");
        local item_str;
        local data = {};
        for k,v in pairs(item_list) do
            item = Utility.lua_string_split(v, "#");
            table.insert( data, {id = tonumber(item[1]), count = tonumber(item[2])} );
            
        end
        uiManager:PushUi(EUI.AwardPreviewUI, data)
    end    
end

function EveryDayRechargeBackUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
    --todo 各自额外的逻辑
    end
end

function EveryDayRechargeBackUI:gc_every_recharge_back_state( day, progress, award )
    self.m_day = day;
    self.m_progress = progress;
    self.m_award = award;

    table.sort( self.m_award, function ( a, b )
        return a.id < b.id
    end )

    self.m_current_award = self.m_award[self.m_day];
    self:updateUi();
end

function EveryDayRechargeBackUI:gc_every_recharge_back_get_award( award )
    app.log("gc_every_recharge_back_get_award--------------" )
    CommonAward.Start(award);

    -- msg_activity.cg_every_recharge_back_state();
end