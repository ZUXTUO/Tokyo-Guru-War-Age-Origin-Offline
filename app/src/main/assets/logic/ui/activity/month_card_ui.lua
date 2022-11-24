
MonthCardUI = Class("MonthCardUI", UiBaseClass)

local resPath = "assetbundles/prefabs/ui/award/ui_1106_award.assetbundle";

MonthCardUI.is_get = false;

EMonthCardIds = 
{
    smallCard = 1,
    bagCard = 2,
}

EMonthCardId2DailyTaskId =
{
    [EMonthCardIds.smallCard] = MsgEnum.edailytask_index.eDailyTask_type_store_card1,
    [EMonthCardIds.bagCard] = MsgEnum.edailytask_index.eDailyTask_type_store_card2,
}

local smllCardSpriteInactiveAndActiveName = 
{
    {path='sp_left_lable', inactive='hd_cf_weijihuo', active='hd_cf_yijihuo'},
    {path='sp_left', inactive='hd_cf_miaoshu2', active='hd_cf_miaoshu1'},
    {path='ui_button_left/sp', inactive='hd_cf_chongzhi2', active='hd_cf_qianwanglingqu1'},
}

local MonthCardUIStr = 
{
    [1] = '持续%d天',
    [2] = '剩余%d天',
    [3] = '尚未达到开启等级，暂不可领取',
    [4] = "已激活",
    [5] = "未激活",
    [6] = "[973900FF]充值[-]",
    [7] = "[973900FF]领取[-]",
    [8] = "[C6C6C6FF]已领取[-]",
    [9] = "持续[FFCC00FF]%d天[-]，每日赠送[FFCC00FF]100[-]钻石"
}

local cards_state = {
    is_active_month = 1; -- 是否开启每日任务奖励
    card_1_state = 0; --卡片1开启状态（0-未激活显示冲值，1激活未领取显示前往领取，2-当天已领取显示已领取
    card_1_day = 0; -- 卡片1剩余天数
    card_2_state = 2;--卡片2开启状态（0-未激活显示冲值，1-激活未领取显示前往领取，2-当天已领取显示已领取
    card_2_day = 20; -- 卡片2剩余天数
}


function MonthCardUI:Init(data)
    self.pathRes = resPath
    UiBaseClass.Init(self, data);
end

function MonthCardUI:Restart()
    if UiBaseClass.Restart(self, data) then
    --todo 
    end
end

function MonthCardUI:Show()
    if UiBaseClass.Show(self) then
    --todo 
    end
end

function MonthCardUI:DestroyUi( )
    app.log("------------------ month_card_ui:DestroyUi")
    if MonthCardUI.is_get == false then
        g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_month_card, 0);
    end
    UiBaseClass.DestroyUi(self);
end

function MonthCardUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    -- self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_name("month_card_ui");
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));


    local lab_left_one = ngui.find_label(self.ui, "center_other/animation/left/lab_left_one");
    lab_left_one:set_active(false);
    local lab_left_two = ngui.find_label(self.ui, "center_other/animation/left/lab_left_two");
    lab_left_two:set_active(false);
    local lab_left_three = ngui.find_label(self.ui, "center_other/animation/left/lab_left_three");
    lab_left_three:set_active(false);
    local sp_art_font_left = ngui.find_sprite(self.ui, "center_other/animation/left/sp_art_font");
    sp_art_font_left:set_active(false);
    local ui_button_left = ngui.find_button(self.ui, "center_other/animation/left/ui_button_left");
    ui_button_left:set_active(false);

    local lab_right_one = ngui.find_label(self.ui, "center_other/animation/right/lab_left_one");
    lab_right_one:set_active(false);
    local lab_right_two = ngui.find_label(self.ui, "center_other/animation/right/lab_left_two");
    lab_right_two:set_active(false);
    local lab_right_three = ngui.find_label(self.ui, "center_other/animation/right/lab_left_three");
    lab_right_three:set_active(false);
    local sp_art_font_right = ngui.find_sprite(self.ui, "center_other/animation/right/sp_art_font");
    sp_art_font_right:set_active(false);
    local ui_button_right = ngui.find_button(self.ui, "center_other/animation/right/ui_button_right");
    ui_button_right:set_active(false);
    
    self:UpdateUi()

end

function MonthCardUI:set_ui_data( is_active_month, card_1_state, card_1_day, card_2_state, card_2_day, progress1, progress2 )
    
    cards_state.is_active_month = tonumber(is_active_month) or 0;
    cards_state.card_1_state = tonumber(card_1_state) or 0;
    cards_state.card_1_day = tonumber(card_1_day) or 0;
    cards_state.card_2_state = tonumber(card_2_state) or 0;
    cards_state.card_2_day = tonumber(card_2_day) or 0;

    app.log("来了" .. cards_state.is_active_month);
    -- 进入每日任务按钮
    -- local btn_sp_mark = ngui.find_button(self.ui, "center_other/animation/btn_sp_mark");
    -- btn_sp_mark:reset_on_click();
    -- btn_sp_mark:set_event_value("", cards_state.is_active_month);
    -- btn_sp_mark:set_on_click(self.bindfunc["OnClickSpMask"]);

    MonthCardUI.is_get = false;

    local ui_button_left = ngui.find_button(self.ui, "center_other/animation/left/ui_button_left");
    ui_button_left:set_active(true);
    local sp_left_label = ngui.find_label(self.ui, "center_other/animation/left/lab");
    sp_left_label:set_active(true);
    -- local sp_left = ngui.find_sprite(self.ui, "center_other/animation/right_content/sp_bk/sp_left");
    -- sp_left:set_active(true);
    -- local left_btn_sp = ngui.find_sprite(self.ui, "center_other/animation/right_content/sp_bk/ui_button_left/animation/sp");
    local left_btn_lab = ngui.find_label(self.ui, "center_other/animation/left/ui_button_left/animation/lab");
    ui_button_left:set_sprite_names("ty_anniu3")
    local lab_left_one = ngui.find_label(self.ui, "center_other/animation/left/lab_left_one");
    local lab_left_one_lab = ngui.find_label(self.ui, "center_other/animation/left/lab_left_one/lab");
    local lab_left_two = ngui.find_label(self.ui, "center_other/animation/left/lab_left_two");
    local lab_left_three = ngui.find_label(self.ui, "center_other/animation/left/lab_left_three");
    local lab_left_three_lab = ngui.find_label(self.ui, "center_other/animation/left/lab_left_three/lab");
    local is_red_point = 0;
    local sp_art_font_left = ngui.find_sprite(self.ui, "center_other/animation/left/sp_art_font");
    sp_art_font_left:set_active(true);
    if cards_state.card_1_state == 0 then
        sp_left_label:set_text(MonthCardUIStr[5]);
        -- left_btn_sp:set_sprite_name("hd_cf_chongzhi2");
        left_btn_lab:set_text(MonthCardUIStr[6]);
        lab_left_one:set_active(true);
        
        if progress1 then
            local item_config = ConfigManager.Get(EConfigIndex.t_activity_other, 2);
            local diss = math.ceil((item_config.parm_1 - progress1)/100);
            lab_left_one_lab:set_text(string.format("%d元", diss));
            lab_left_two:set_text(string.format(MonthCardUIStr[9], item_config.parm_3));
        else
            lab_left_one_lab:set_text("25元")
        end
        
        lab_left_two:set_active(true);
        lab_left_three:set_active(false);
        lab_left_three_lab:set_active(false);
        sp_art_font_left:set_sprite_name("hd_weijihuo");
        ui_button_left:set_sprite_names("ty_anniu3")
    elseif cards_state.card_1_state == 1 then
        sp_left_label:set_text(MonthCardUIStr[4]);
        -- left_btn_sp:set_sprite_name("hd_cf_qianwanglingqu2");
        left_btn_lab:set_text(MonthCardUIStr[7]);
        lab_left_one:set_active(false);
        lab_left_two:set_active(false);
        -- lab_left_two:set_text("剩余" .. cards_state.card_1_day .. "天");
        lab_left_three:set_active(true);
        -- lab_left_three:set_text(string.format("剩余%d天", cards_state.card_1_day));
        lab_left_three_lab:set_active(true);
        lab_left_three_lab:set_text(cards_state.card_1_day .. "天");
        sp_art_font_left:set_sprite_name("hd_yijihuo");
        MonthCardUI.is_get = true;
        is_red_point = 1;
    elseif cards_state.card_1_state == 2 then
        sp_left_label:set_text(MonthCardUIStr[8]);
        -- left_btn_sp:set_sprite_name("yilingqu");
        left_btn_lab:set_text(MonthCardUIStr[8]);
        -- lab_left_one:set_active(false);
        -- lab_left_two:set_text("剩余" .. cards_state.card_1_day .. "天");

        lab_left_one:set_active(false);
        lab_left_two:set_active(false);
        -- lab_left_two:set_text("剩余" .. cards_state.card_1_day .. "天");
        lab_left_three:set_active(true);
        -- lab_left_three:set_text(string.format("剩余%d天", cards_state.card_1_day));
        lab_left_three_lab:set_active(true);
        lab_left_three_lab:set_text(cards_state.card_1_day .. "天");
        sp_art_font_left:set_sprite_name("hd_yijihuo");
        ui_button_left:set_sprite_names("ty_anniu5")
    end
    ui_button_left:reset_on_click();
    ui_button_left:set_event_value("", cards_state.card_1_state);
    ui_button_left:set_on_click(self.bindfunc["OnClickLeftBtn"]);


    local ui_button_right = ngui.find_button(self.ui, "center_other/animation/right/ui_button_right");
    ui_button_right:set_sprite_names("ty_anniu3")
    ui_button_right:set_active(true);
    local sp_right_label = ngui.find_label(self.ui, "center_other/animation/right/lab");
    sp_right_label:set_active(true);
    -- local sp_right = ngui.find_sprite(self.ui, "center_other/animation/right_content/sp_bk/sp_right");
    -- sp_right:set_active(true);
    -- local right_btn_sp = ngui.find_sprite(self.ui, "center_other/animation/right_content/sp_bk/ui_button_right/animation/sp");
    local sp_right_bt_label = ngui.find_label(self.ui, "center_other/animation/right/ui_button_right/animation/lab");
    local lab_right_one = ngui.find_label(self.ui, "center_other/animation/right/lab_left_one");
    local lab_right_one_lab = ngui.find_label(self.ui, "center_other/animation/right/lab_left_one/lab");
    local lab_right_two = ngui.find_label(self.ui, "center_other/animation/right/lab_left_two");
    local lab_right_three = ngui.find_label(self.ui, "center_other/animation/right/lab_left_three");
    local lab_right_three_lab = ngui.find_label(self.ui, "center_other/animation/right/lab_left_three/lab");
    lab_right_two:set_active(true);
    local sp_art_font_right = ngui.find_sprite(self.ui, "center_other/animation/right/sp_art_font");
    sp_art_font_right:set_active(true);
    if cards_state.card_2_state == 0 then
        sp_right_label:set_text(MonthCardUIStr[5]);
        -- right_btn_sp:set_sprite_name("hd_cf_chongzhi1");
        sp_right_bt_label:set_text(MonthCardUIStr[6]);
        lab_right_one:set_active(true);
        if progress2 then
            local item_config = ConfigManager.Get(EConfigIndex.t_activity_other, 2);
            local diss = math.ceil((item_config.parm_2 - progress2)/100);
            lab_right_one_lab:set_text(string.format("%d元", diss));
            lab_right_two:set_text(string.format(MonthCardUIStr[9], item_config.parm_4));
        else
            lab_right_one_lab:set_text("88元");
        end
        
        lab_right_three:set_active(false);
        lab_right_three_lab:set_active(false);
        sp_art_font_right:set_sprite_name("hd_weijihuo");
        ui_button_right:set_sprite_names("ty_anniu3")
    elseif cards_state.card_2_state == 1 then
        sp_right_label:set_text(MonthCardUIStr[4]);
        -- right_btn_sp:set_sprite_name("hd_cf_qianwanglingqu1");
        sp_right_bt_label:set_text(MonthCardUIStr[7]);
        lab_right_one:set_active(false);
        lab_right_two:set_active(false);
        -- lab_left_two:set_text("剩余" .. cards_state.card_1_day .. "天");
        lab_right_three:set_active(true);
        -- lab_right_three:set_text(string.format("剩余%d天", cards_state.card_2_day));
        lab_right_three_lab:set_active(true);
        lab_right_three_lab:set_text(cards_state.card_2_day .. "天")
        sp_art_font_right:set_sprite_name("hd_yijihuo");
        MonthCardUI.is_get = true;
        is_red_point = 1;
    elseif cards_state.card_2_state == 2 then
        sp_right_label:set_text(MonthCardUIStr[8]);
        -- right_btn_sp:set_sprite_name("yilingqu");
        sp_right_bt_label:set_text(MonthCardUIStr[8]);
        lab_right_one:set_active(false);
        lab_right_two:set_active(false);
        -- lab_left_two:set_text("剩余" .. cards_state.card_1_day .. "天");
        lab_right_three:set_active(true);
        -- lab_right_three:set_text(string.format("剩余%d天", cards_state.card_2_day));
        lab_right_three_lab:set_active(true);
        lab_right_three_lab:set_text(cards_state.card_2_day .. "天")
        sp_art_font_right:set_sprite_name("hd_yijihuo");
        ui_button_right:set_sprite_names("ty_anniu5")
    end

    ui_button_right:reset_on_click();
    ui_button_right:set_event_value("", cards_state.card_2_state);
    ui_button_right:set_on_click(self.bindfunc["OnClickRightBtn"]);

    g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_month_card, is_red_point);
end

function MonthCardUI:UpdateUi()
    if not self.ui then
        return
    end

    player.cg_get_month_cards_state();
    
end

function MonthCardUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickRechargeBtn"]	   = Utility.bind_callback(self, self.OnClickRechargeBtn);
    self.bindfunc["set_ui_data"]	   = Utility.bind_callback(self, self.set_ui_data);

    self.bindfunc["OnClickLeftBtn"] = Utility.bind_callback(self, self.OnClickLeftBtn);
    self.bindfunc["OnClickRightBtn"] = Utility.bind_callback(self, self.OnClickRightBtn);
    self.bindfunc["OnClickSpMask"] = Utility.bind_callback(self, self.OnClickSpMask);

    self.bindfunc['gc_btn_get'] = Utility.bind_callback(self, self.gc_btn_get);
end

function MonthCardUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
    --PublicFunc.msg_regist(player.gc_update_player_store_card_info, self.bindfunc["UpdateUi"])

    PublicFunc.msg_regist(player.gc_get_month_cards_state, self.bindfunc["set_ui_data"]);

    PublicFunc.msg_regist(msg_dailytask.gc_finish_task,self.bindfunc['gc_btn_get']);
end

function MonthCardUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    --PublicFunc.msg_unregist(player.gc_update_player_store_card_info, self.bindfunc["UpdateUi"])

    PublicFunc.msg_unregist(player.gc_get_month_cards_state, self.bindfunc["set_ui_data"]);
end

function MonthCardUI:OnClickLeftBtn( param )
    local state = tonumber(param.float_value);
    if state == 0 then
        uiManager:PushUi(EUI.StoreUI);
    elseif state == 1 then
        if cards_state.is_active_month == 1 then
            -- uiManager:PushUi(EUI.UiDailyTask);
            msg_dailytask.cg_finish_task({17});
        else
            FloatTip.Float("每日任务未开启");
        end
    elseif state == 2 then
        FloatTip.Float("今日奖励已领取");
    end
end

function MonthCardUI:OnClickRightBtn( param )
    local state = param.float_value;
    if state == 0 then
        uiManager:PushUi(EUI.StoreUI);
    elseif state == 1 then
        if cards_state.is_active_month == 1 then
            -- uiManager:PushUi(EUI.UiDailyTask);
            msg_dailytask.cg_finish_task({18});
        else
            FloatTip.Float("每日任务未开启");
        end
    elseif state == 2 then
        FloatTip.Float("今日奖励已领取");
    end
end

-- 领取返回
function MonthCardUI:gc_btn_get(result, vecItem)
    -- self.upperLayersCount = self.upperLayersCount + 1
    CommonAward.Start(vecItem, 1);
    -- CommonAward.SetFinishCallback(self.back_upper_layer, self)
    player.cg_get_month_cards_state();
end

function MonthCardUI:OnClickSpMask( param )
    if tonumber(param.float_value) == 0 or g_dataCenter.player.level < 6 then
        FloatTip.Float("每日任务未开启");
    else
        uiManager:PushUi(EUI.UiDailyTask);
    end
end

function MonthCardUI:OnClickRechargeBtn(param)
    local cardid = param.float_value
    app.log('OnClickRechargeBtn ' .. tostring(cardid))
    local lastDay = g_dataCenter.player:GetStoreCardLastDay(cardid)
    if lastDay > 0 then
        --local taskid = EMonthCardId2DailyTaskId[cardid]
        if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Task) then
            uiManager:PushUi(EUI.UiDailyTask)
        else
            FloatTip.Float(MonthCardUIStr[3])
        end
    else
        uiManager:PushUi(EUI.StoreUI, cardid)
    end
end