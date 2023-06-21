ActivityUI = Class("ActivityUI", UiBaseClass)

ACTUM = {
    receive = "receive";
    no_receive = "no_receive";
    gray = "gray";
}
activity_ui_sytle = {};
activity_ui_sytle.btn_sprite = {
    receive = "ty_anniu3";
    no_receive = "ty_anniu4";
    gray = "ty_anniu5";
}
activity_ui_sytle.btn_lab_rgb = {
    receive = {r=150/255, g=57/255, b=0/255};
    no_receive = {r=60/255, g=75/255, b=143/255};
    gray = {r=198/255, g=198/255, b=198/255}
}
activity_ui_sytle.set_btn = function ( btn, style )
    local btn_sprite = activity_ui_sytle.btn_sprite[style];
    if btn_sprite then
        btn_sprite:set_sprite_name(btn_sprite);
    end
    local lab = ngui.find_label(btn, "animation/lab");
    if lab then
        local lab_sytle = activity_ui_sytle.btn_lab_rgb[style];
        if lab_sytle then
            lab_sytle:set_effect_color(lab_sytle.a, lab_sytle.g, lab_sytle.b, 1);
        end
    end
end

local _lab_tex = {
    [1] = "大小月卡";
    [2] = "升级送礼";
    [3] = "每日充值";
    [4] = "登录送礼";
    [5] = "闯关活动";
    [6] = "礼包兑换";
    [7] = "等级基金";
    [8] = "招募送礼";
    [9] = "目标奖励";
    [10] = "绑定礼包";
    [11] = "累计消费";
    [12] = "累计充值";
    [13] = "保卫战收益双倍";
    [14] = "购买金币收益双倍";
    [15] = "购买体力收益双倍";
    [16] = "教堂挂机收益双倍";
    [17] = "高速狙击收益双倍";
    [18] = "极限挑战收益双倍";
    [19] = "普通关卡收益双倍";
    [20] = "精英关卡收益双倍";
    [21] = "玩法目标_2";
    [22] = "玩法目标_3";
    [23] = "玩法目标_4";
    [24] = "玩法目标_5";
    [25] = "高速狙击额外数次";
    [26] = "保卫战额外数次";
    [27] = "小丑计划额外数次";
    [28] = "魂匣";
    [29] = "小丑计划收益双倍";
    [30] = "每日体力领取";
    [31] = "全服抢购";
    [32] = "兑换活动";
    [33] = "兑换活动1";
    [34] = "兑换活动2";
    [35] = "关卡额外产出";
    [36] = "VIP超值礼包";
    [37] = "扭蛋折扣";
    [38] = "远征宝箱折扣";
    [39] = "装备宝箱折扣";
    [40] = "折扣购买";
    [41] = "分享活动",
    [42] = "福利宝箱",
    [43] = "订阅"
}

-- 显示类型
local _display_type = {
    [1] = 1, --一直存在
    [2] = 2, --刷新
}

ActivityPageMap = {
    [1] = {name = "MonthCardUI", dis_type = _display_type[1], lab = _lab_tex[1], reg_class = MonthCardUI, param = {id = ENUM.Activity.activityType_month_card}},
    [2] = {name = "AccountBindingUI", dis_type = _display_type[2], lab = _lab_tex[10], reg_class = AccountBindingUI, param = {id = ENUM.Activity.activityType_accout_binding}},
    [3] = {name = "levelUpReward", dis_type = _display_type[2], lab = _lab_tex[2], reg_class = LevelUpRewardUI, param = {id = ENUM.Activity.activityType_up_level_award}},
    [4] = {name = "EveryDayRechargeUI", dis_type = _display_type[2], lab = _lab_tex[3], reg_class = EveryDayRechargeUI, param = {id = ENUM.Activity.activityType_everyday_recharge_total}},
    [5] = {name = "loginBackRewardUI", dis_type = _display_type[2], lab = _lab_tex[4], reg_class = LoginBackRewardUI, param = {id = ENUM.Activity.activityType_login_award_back_time}},
    -- [6] = {name = "hurdleRewardUI", dis_type = _display_type[2], lab = _lab_tex[5], reg_class = HurdleRewardUI, order = 6},
    [7] = {name = "giftExchangeUI", dis_type = _display_type[1], lab = _lab_tex[6], reg_class = UiGiftExchange, param = {id = ENUM.Activity.activityType_gift_exchange}},
    [8] = {name = "LevelFundUI", dis_type = _display_type[2], lab = _lab_tex[7], reg_class = LevelFundUI, param = {id = ENUM.Activity.activityType_level_fund}},
    [9] = {name = "RecruitUI", dis_type = _display_type[2], lab = _lab_tex[8], reg_class = RecruitUI, param = {id = ENUM.Activity.activityType_recruit}},
    [10] = {name = "PlayTargetAward", dis_type = _display_type[2], lab = _lab_tex[9], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target}},
    [11] = {name = "TotalConsumeUI", dis_type = _display_type[2], lab = _lab_tex[11], reg_class = TotalConsumeUI, param = {id = ENUM.Activity.activityType_consume_total}},
    [12] = {name = "TotalRechargeUI", dis_type = _display_type[2], lab = _lab_tex[12], reg_class = TotalRechargeUI, param = {id = ENUM.Activity.activityType_recharge_total}},
    [13] = {name = "DoubleDefendUI", dis_type = _display_type[2], lab = _lab_tex[13], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_defend, double_type = ENUM.Double.defend}},
    [14] = {name = "DoubleExchangeGoldUI", dis_type = _display_type[2], lab = _lab_tex[14], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_gold_exchange, double_type = ENUM.Double.gold_exchange}},
    [15] = {name = "DoubleBuyApUI", dis_type = _display_type[2], lab = _lab_tex[15], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_buy_ap, double_type = ENUM.Double.buy_ap}},
    [16] = {name = "DoubleChurchBookUI", dis_type = _display_type[2], lab = _lab_tex[16], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_church_hook, double_type = ENUM.Double.church_hook}},
    [17] = {name = "DoubleHightSniperUI", dis_type = _display_type[2], lab = _lab_tex[17], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_hight_sniper, double_type = ENUM.Double.hight_sniper}},
    [18] = {name = "DoubleKuikuliyaUI", dis_type = _display_type[2], lab = _lab_tex[18], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_kuikuliya, double_type = ENUM.Double.kuikuliya}},
    [19] = {name = "DoubleHurdleNormalUI", dis_type = _display_type[2], lab = _lab_tex[19], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_hurdle_normal, double_type = ENUM.Double.hurdle_normal}},
    [20] = {name = "DoubleHurdleEliteUI", dis_type = _display_type[2], lab = _lab_tex[20], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_hurdle_elite, double_type = ENUM.Double.hurdle_elite}},
    [21] = {name = "PlayTargetAward_2", dis_type = _display_type[2], lab = _lab_tex[21], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_2}},
    [22] = {name = "PlayTargetAward_3", dis_type = _display_type[2], lab = _lab_tex[22], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_3}},
    [23] = {name = "PlayTargetAward_4", dis_type = _display_type[2], lab = _lab_tex[23], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_4}},
    [24] = {name = "PlayTargetAward_5", dis_type = _display_type[2], lab = _lab_tex[24], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_5}},
    [25] = {name = "ExtraUI_hight_sniper", dis_type = _display_type[2], lab = _lab_tex[25], reg_class = ExtraUI, param = {id = ENUM.Activity.activityType_extra_times_hight_sniper}},
    [26] = {name = "ExtraUI_baoweizhang", dis_type = _display_type[2], lab = _lab_tex[26], reg_class = ExtraUI, param = {id = ENUM.Activity.activityType_extra_times_baoweizhang}},
    [27] = {name = "ExtraUI_xiaochoujihua", dis_type = _display_type[2], lab = _lab_tex[27], reg_class = ExtraUI, param = {id = ENUM.Activity.activityType_extra_times_xiaochoujihua}},
    [28] = {name = "NiuDanHunxiaUI", dis_type = _display_type[2], lab = _lab_tex[28], reg_class = NiudanHunxiaUI, param = {id = ENUM.Activity.activityType_niudan_hunxia}},
    [29] = {name = "DoubleXiaochoujihuaUI", dis_type = _display_type[2], lab = _lab_tex[29], reg_class = DoubleUI, param = {id = ENUM.Activity.activityType_double_xiaochoujihua, double_type = ENUM.Double.xiaochoujihu}},
    [30] = {name = "GetApUI", dis_type = _display_type[1], lab = _lab_tex[30], reg_class = GetApUI, param = {id = ENUM.Activity.activityType_get_ap_reward}},
    [31] = {name = "AllServerBuyUI", dis_type = _display_type[2], lab = _lab_tex[31], reg_class = AllServerBuyUI, param = {id = ENUM.Activity.activityType_all_buy}},
    [40] = {name = "ExchangeActivityUI", dis_type = _display_type[2], lab = _lab_tex[32], reg_class = ExchangeActivityUI, param = {id = ENUM.Activity.activityType_exchange_item}},
    [41] = {name = "ExchangeActivityUI1", dis_type = _display_type[2], lab = _lab_tex[33], reg_class = ExchangeActivityUI, param = {id = ENUM.Activity.activityType_exchange_item_1}},
    [42] = {name = "ExchangeActivityUI2", dis_type = _display_type[2], lab = _lab_tex[34], reg_class = ExchangeActivityUI, param = {id = ENUM.Activity.activityType_exchange_item_2}},
    [43] = {name = "HurdleExtraProduce", dis_type = _display_type[2], lab = _lab_tex[35], reg_class = ExtraUI, param = {id = ENUM.Activity.activityType_hurdle_extra_produce}},
    [44] = {name = "VIPGiftBagUI", dis_type = _display_type[2], lab = _lab_tex[36], reg_class = VIPGiftBagUI, param = {id = ENUM.Activity.activityType_vip_buy}},
    [45] = {name = "NiuDanDiscount", dis_type = _display_type[2], lab = _lab_tex[37], reg_class = DiscountUI, param = {id = ENUM.Activity.activityType_niudan_discount}},
    [46] = {name = "YuanZhengDiscount", dis_type = _display_type[2], lab = _lab_tex[38], reg_class = DiscountUI, param = {id = ENUM.Activity.activityType_yuanzheng_box_discount}},
    [47] = {name = "EquipDiscount", dis_type = _display_type[2], lab = _lab_tex[39], reg_class = DiscountUI, param = {id = ENUM.Activity.activityType_equip_box_discount}},
    [48] = {name = "DiscountBuyUI", dis_type = _display_type[2], lab = _lab_tex[39], reg_class = DiscountBuyUI, param = {id = ENUM.Activity.activityType_discount_buy}},
    [49] = {name = "PlayTargetAward_6", dis_type = _display_type[2], lab = _lab_tex[9], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_6}},
    [50] = {name = "PlayTargetAward_7", dis_type = _display_type[2], lab = _lab_tex[9], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_7}},
    [51] = {name = "PlayTargetAward_8", dis_type = _display_type[2], lab = _lab_tex[9], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_8}},
    [52] = {name = "PlayTargetAward_9", dis_type = _display_type[2], lab = _lab_tex[9], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_9}},
    [53] = {name = "PlayTargetAward_10", dis_type = _display_type[2], lab = _lab_tex[9], reg_class = PlayTargetAward, param = {id = ENUM.Activity.activityType_play_target_10}},
    [54] = {name = "ShareUI", dis_type = _display_type[1], lab = _lab_tex[41], reg_class = ShareUI, param = {id = ENUM.Activity.activityType_share_activity}},
    [55] = {name = "EveryDayRechargeBackUI", dis_type = _display_type[2], lab = _lab_tex[3], reg_class = EveryDayRechargeBackUI, param = {id = ENUM.Activity.activityType_everyday_recharge_total_back_time}},
    [57] = {name = "ActivityWelfareBoxUI", dis_type = _display_type[2], lab = _lab_tex[42], reg_class = ActivityWelfareBoxUI, param = {id = ENUM.Activity.activityType_welfare_box}},
    [58] = {name = "SubscribeUI", dis_type = _display_type[2], lab = _lab_tex[43], reg_class = SubscribeUI, param = {id = ENUM.Activity.activityType_subscribe}},

}

ActivityItemPointState = 
{
    month_card_point_state = 0;
}

function ActivityUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1104_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function ActivityUI:InitData(data)
    UiBaseClass.InitData(self, data);
    if data and data.activity_id then
        self.ext_activity_id = data.activity_id;
    end
    -- for k,v in pairs(ActivityPageMap) do
    --     if v.dis_type == 1 then
    --         -- 默认显示的页签
    --         self.m_default_id = v.param.id;
    --         -- 当前显示的页签
    --         self.m_current_id = 1;
    --     end
    -- end
    

    -- if data and data.defPageName then
    --     if type(data.defPageName) == "string" then
    --         for k,v in pairs(ActivityPageMap) do
    --             if v.name == data.defPageName then
    --                 self.m_current_id = k;
    --             end
    --         end
    --     elseif type(data.defPageName) == "number" then
    --         self.m_current_id = data.defPageName;
    --     end
    -- end
    self.next_day_ref = false;
    -- 显示的列表id
    self.m_current_apm_list = {};
    -- 显示列表UI
    self.m_current_ui_list = {};
    self.m_distance_list = {}

    -- self.loginID = MsgEnum.eactivity_time.eActivityTime_loginReward;
    -- self.hurdleID = MsgEnum.eactivity_time.eActivityTime_hurdleReward;
    -- self.everydayRechargeID = MsgEnum.eactivity_time.eActivityTime_everydayRecharge;
    self.activityReward = g_dataCenter.activityReward;
end

function ActivityUI:DestroyUi()
    uiManager:GetNavigationBarUi():SetCoinCfgIgnore(nil)

    if MonthCardUI.is_get == false then
        g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_month_card, 0);
        -- MonthCardUI.is_get = true;
    end
    self.next_day_ref = false;
    self.m_current_apm_list = {};
    self.m_current_ui_list = {};
    self.m_distance_list = {}
    if self.m_current_panel then
        self.m_current_panel:Hide();
        self.m_current_panel:DestroyUi();
        self.m_current_panel = nil;
    end
    UiBaseClass.DestroyUi(self);
end

function ActivityUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["init_item"]     = Utility.bind_callback(self, ActivityUI.init_item);
    self.bindfunc["on_click_tab"]      = Utility.bind_callback(self, ActivityUI.on_click_tab);
    self.bindfunc["on_close"]      = Utility.bind_callback(self, ActivityUI.on_close);

    self.bindfunc["gc_change_activity_time"] = Utility.bind_callback(self, self.gc_change_activity_time);
    self.bindfunc["update_point_by_activity_id"] = Utility.bind_callback(self, self.update_point_by_activity_id);
    self.bindfunc["gc_pause_activity"] = Utility.bind_callback(self, self.gc_pause_activity);
    self.bindfunc["gc_init_activity_state"] = Utility.bind_callback(self, self.gc_init_activity_state);
end

function ActivityUI:MsgRegist()
    PublicFunc.msg_regist("msg_activity.gc_change_activity_time", self.bindfunc["gc_change_activity_time"]);
    PublicFunc.msg_regist("ActivityReward.update_point_by_activity_id", self.bindfunc["update_point_by_activity_id"]);
    PublicFunc.msg_regist("msg_activity.gc_pause_activity", self.bindfunc["gc_pause_activity"]);
    PublicFunc.msg_regist("msg_activity.gc_init_activity_state", self.bindfunc["gc_init_activity_state"]);
end

function ActivityUI:MsgUnRegist()
    PublicFunc.msg_unregist("msg_activity.gc_change_activity_time", self.bindfunc["gc_change_activity_time"]);
    PublicFunc.msg_unregist("ActivityReward.update_point_by_activity_id", self.bindfunc["update_point_by_activity_id"]);
    PublicFunc.msg_unregist("msg_activity.gc_pause_activity", self.bindfunc["gc_pause_activity"]);
    PublicFunc.msg_unregist("msg_activity.gc_init_activity_state", self.bindfunc["gc_init_activity_state"]);
end

function ActivityUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("activity_ui");
    
    self.gridScrollView = ngui.find_scroll_view(self.ui, "activity_ui/center_other/animation/sco_view/panel_list");
    self.grid = ngui.find_wrap_content(self.ui,"activity_ui/center_other/animation/sco_view/panel_list/wrap_content");
    self.grid:set_on_initialize_item(self.bindfunc["init_item"]);
    -- self.grid:set_min_index(0);
    -- self.grid:set_max_index(-1);
    -- self.grid:reset();

    --先刷出当前
    -- for k,v in pairs(ActivityPageMap) do
    --     if v.dis_type == _display_type[1] then
    --         table.insert(self.m_current_apm_list, v);
    --     end
    -- end    
    
    self:ChangeTableByGM();
    -- self:ChangeTableByGMForDouble();
    self:RefshItemListUI();
    self:ChangeOpenActivityUI();
end

function ActivityUI:Show( )
    app.log("---------- ActivityUI-- self.m_current_id:" .. self.m_current_id);
    if self.m_current_id == ENUM.Activity.activityType_share_activity then
        self.m_current_panel:Show()
    else
        self:ChangeOpenActivityUI();
        UiBaseClass.Show(self);
    end

    -- if self.m_current_id == 1 then
    --     player.cg_get_month_cards_state();
    -- end

end

function ActivityUI:RefshItemListUI( )
    table.sort( self.m_current_apm_list, function ( a, b )
        -- local activity_ida = _page_map_to_activity_id[a];
        -- local activity_idb = _page_map_to_activity_id[b]; 
        local activity_ida = a.param.id;
        local activity_idb = b.param.id;
        local is_pointa = g_dataCenter.activityReward:GetIsRedPointStateByActivityID(activity_ida);
        local is_pointb = g_dataCenter.activityReward:GetIsRedPointStateByActivityID(activity_idb);

        if is_pointa and is_pointb == false then
            do return true; end
        end

        if is_pointa == false and is_pointb then
            do return false; end
        end

        local config_data_a = ConfigManager.Get(EConfigIndex.t_activity_play, tonumber(activity_ida) );
        local config_data_b = ConfigManager.Get(EConfigIndex.t_activity_play, tonumber(activity_idb) );
        if config_data_a and config_data_b then
            if tonumber(config_data_a.param_2) == tonumber(config_data_b.param_2) then
                do return activity_ida < activity_idb; end
            else
                do return tonumber(config_data_a.param_2) < tonumber(config_data_b.param_2); end
            end
        end
        do return true; end
    end );

    self.m_default_id = self.m_current_apm_list[1].param.id;
    if self.ext_activity_id then
        self.m_current_id = self.ext_activity_id;
    else
        self.m_current_id = self.m_default_id;
    end
    
    local index_count = #self.m_current_apm_list;
    if index_count > 0 then
        self.grid:set_min_index(-index_count + 1);
        self.grid:set_max_index(0);
        self.grid:reset();
        self.gridScrollView:reset_position();
    end
end


function ActivityUI:init_item(obj, b, real_id)
    -- app.log("---- b:" ..b.. "---- real_id:" .. real_id );   
    local index = math.abs(real_id) + 1;
    local index_b = math.abs(b) + 1;
    local map_data = self.m_current_apm_list[index];
    if map_data == nil then
        do return; end
    end
    local id = map_data.param.id;
    local obj_name = "item_" .. id;
    obj:set_name(obj_name);

    -- app.log("---------- id:" .. id);
    if self.m_current_ui_list[id] == nil then
        self.m_current_ui_list[id] = obj;
    end

    self.m_distance_list[obj:get_instance_id()] = {obj = obj, id = id};

    local spBg = ngui.find_sprite(obj, "sp")
    local normal_ui_tex = ngui.find_label(obj, "lab");
    local choose_ui_tex = ngui.find_label(obj, "lab1");

    if id == self.m_current_id then
        spBg:set_sprite_name("hd_yeqian5")
        normal_ui_tex:set_active(false)
        choose_ui_tex:set_active(true)
    else
        spBg:set_sprite_name("hd_yeqian6")
        normal_ui_tex:set_active(true)
        choose_ui_tex:set_active(false)
    end

    local lab_txt_name = g_dataCenter.activityReward:GetActivityNameByActivityID(id);
    app.log("lab_txt_name========="..tostring(lab_txt_name))
    app.log("id================="..tostring(id))
    if lab_txt_name == "" then
        local play_config = ConfigManager.Get(EConfigIndex.t_activity_play, id );
        if play_config and play_config.activity_name and tostring(play_config.activity_name) ~= "" and tostring(play_config.activity_name) ~= "0" then
            lab_txt_name = play_config.activity_name;
        else
            lab_txt_name = map_data.lab;
        end
    end

    normal_ui_tex:set_text(tostring(lab_txt_name));
    choose_ui_tex:set_text(tostring(lab_txt_name));

    local btn = ngui.find_button(obj:get_parent(), obj_name);
    btn:reset_on_click()
    btn:set_on_click(self.bindfunc["on_click_tab"], "MyButton.Flag");    
    btn:set_event_value(tostring(obj:get_instance_id()), id);

    local sp_point = ngui.find_sprite(obj, "sp_point");
    if sp_point then   
        sp_point:set_active( g_dataCenter.activityReward:GetIsRedPointStateByActivityID(id) );       
    end

end

function ActivityUI:on_click_tab( t )
    local cur_id = 0;
    -- local obj = nil;
    if self.m_distance_list[tonumber(t.string_value)] then
        cur_id = self.m_distance_list[tonumber(t.string_value)].id;
        -- obj = self.m_distance_list[tonumber(t.string_value)].obj;
    end
    app.log("self.m_current_id:" .. self.m_current_id .. ", t.float_value:" .. t.float_value);
    if cur_id ~= self.m_current_id then
        self.m_current_id = cur_id;
        for k,v in pairs(self.m_distance_list) do
            -- local obj = self.ui:get_child_by_name("center_other/animation/sco_view/panel_list/wrap_content/item_" .. k);
            obj = v.obj;
            if obj then
                local spBg = ngui.find_sprite(obj, "sp")
                local normal_ui_tex = ngui.find_label(obj, "lab");
                local choose_ui_tex = ngui.find_label(obj, "lab1");

                if tonumber(v.id) == tonumber(self.m_current_id) then
                    spBg:set_sprite_name("hd_yeqian5")
                    normal_ui_tex:set_active(false)
                    choose_ui_tex:set_active(true)
                else
                    spBg:set_sprite_name("hd_yeqian6")
                    normal_ui_tex:set_active(true)
                    choose_ui_tex:set_active(false)
                end
            end
        end

        self:ChangeOpenActivityUI();
    end
end

function ActivityUI:ChangeOpenActivityUI( )
    if self.m_current_panel then
        self.m_current_panel:Hide();
        self.m_current_panel:DestroyUi();
        self.m_current_panel = nil;
    end
    
    -- local special_type = ActivityPageMap[self.m_current_id].double_type or ActivityPageMap[self.m_current_id].activity_id or ActivityPageMap[self.m_current_id].extra_act_type or ActivityPageMap[self.m_current_id].param or nil;
    for k,v in pairs(self.m_current_apm_list) do
        if v.param.id == self.m_current_id then
            self.m_current_panel = v.reg_class:new(v.param);
            -- 设置导航条货币栏显示开关
            if v.reg_class == GetApUI then
                uiManager:GetNavigationBarUi():SetCoinCfgIgnore(true)
            else
                uiManager:GetNavigationBarUi():SetCoinCfgIgnore(nil)
            end
            break;
        end
    end
    -- self.m_current_panel = ActivityPageMap[self.m_current_id].reg_class:new(special_type);
    -- if self.m_current_panel then
    --     app.log("self.m_current_id:" .. self.m_current_id);
    --     self.m_current_panel:new();
    -- end
end

function ActivityUI:addTabByid( id )    
    local is_add = true;
    for k,v in pairs(self.m_current_apm_list) do
        if v.param.id == id then
            is_add = false;
            break;
        end
    end

    if is_add then
        for k,v in pairs(ActivityPageMap) do
            if v.param.id == id then
                table.insert(self.m_current_apm_list, v);
                break;
            end
        end
    end
    
    -- local refresh = false;    
    -- local index = table.index_of(self.m_current_apm_list, id);
    -- if index <= 0 then        
        
    --     refresh = true;
    -- end
end

function ActivityUI:delTabByid( id )
    for k,v in pairs(self.m_current_apm_list) do
        if v.param.id == id then
            app.log("param.id:" .. v.param.id .. "--- id:" .. id)
            table.remove(self.m_current_apm_list, k);
            break;
        end
    end

    if id == self.m_current_id then
        self.m_current_id = self.m_default_id;
        self:ChangeOpenActivityUI();
    end
end

function ActivityUI:ShowNavigationBar()
    return true;
end

function ActivityUI:ChangeTableByGM( )
    self.m_current_apm_list = {};
    for k,v in pairs(ActivityPageMap) do
        if v.dis_type == _display_type[1]  then
            self:addTabByid(v.param.id);
        elseif v.dis_type == _display_type[2]  then
            if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(v.param.id) then
                self:addTabByid(v.param.id);
            else
                self:delTabByid(v.param.id);
            end
        end
    end
    do return; end
    -- 升级送礼
    if LevelUpReward.GetInstance():isExpired() then
        self:delTabByid( ENUM.Activity.activityType_up_level_award );
    else
        self:addTabByid( ENUM.Activity.activityType_up_level_award );
    end

end

function ActivityUI:ChangeTableByGMForDouble( )
end

function ActivityUI:gc_change_activity_time()
    self:RefAll();
end

function ActivityUI:gc_pause_activity()
    self:RefAll();
end

function ActivityUI:gc_init_activity_state( )

    self:RefAll();
end

function ActivityUI:RefAll(  )
    
    self.m_current_apm_list = {};
    self.m_current_ui_list = {};
    self.m_distance_list = {};
    if self.m_current_panel then
        self.m_current_panel:Hide();
        self.m_current_panel:DestroyUi();
        self.m_current_panel = nil;
    end

    self:ChangeTableByGM();
    self:RefshItemListUI();
    self:ChangeOpenActivityUI();

end

function ActivityUI:UpdateRewardUI()
    if self.m_current_panel and self.m_current_panel.UpdateRewardUI then
        self.m_current_panel:UpdateRewardUI()
    end
end

function ActivityUI:RewardCallBack(...)
    if self.m_current_panel and self.m_current_panel.RewardCallBack then
        self.m_current_panel:RewardCallBack(...)
    end
end

function ActivityUI:update_point_by_activity_id( activity_id )

    local obj = self.m_current_ui_list[activity_id];
    if obj then
        local sp_point = ngui.find_sprite(obj, "sp_point");
        sp_point:set_active( g_dataCenter.activityReward:GetIsRedPointStateByActivityID(activity_id) );
    end

    -- for k,v in pairs(_page_map_to_activity_id) do
    --     if v == activity_id then
    --         local id = k;
    --         local obj = self.m_current_ui_list[id];
    --         if obj then
    --             local sp_point = ngui.find_sprite(obj, "sp_point");
    --             sp_point:set_active( g_dataCenter.activityReward:GetIsRedPointStateByActivityID(activity_id) );
    --         end
    --         break;
    --     end
    -- end

    
end

function ActivityUI:Update(dt)
    if self.m_current_panel and self.m_current_panel.Update then
        self.m_current_panel:Update(dt)
    end
    -- local sysTime = os.date("*t",system.time());
    -- if self.next_day_ref == false and sysTime.hour == 5 and sysTime.min == 0 and sysTime.sec == 10 then          
    --     self.next_day_ref = true;
    --     self:ChangeTableByGM();
    --     self:RefshItemListUI();
    --     self:ChangeOpenActivityUI();
    --     -- self:on_click_tab( {float_value = self.m_default_id } );
    -- end
end
