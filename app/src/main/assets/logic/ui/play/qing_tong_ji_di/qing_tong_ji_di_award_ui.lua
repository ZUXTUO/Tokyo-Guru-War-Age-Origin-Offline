QingTongJiDiAwardUI = Class("QingTongJiDiAwardUI", UiBaseClass);

local _local = {}
_local.UIText = {
    [1] = "",
    [2] = "赛季结束后，奖励会发送至你的邮箱",
    [3] = "每日%s点，奖励将发送至你的邮箱",
    [4] = "积分达到",
    [5] = "排名达到",
    [6] = "我的积分",
    [7] = "我的排名",
}

function QingTongJiDiAwardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_4304_ghoul_3v3.assetbundle";
    UiBaseClass.Init(self, data);
end

function QingTongJiDiAwardUI:Restart(data)
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]
    UiBaseClass.Restart(self, data);
end

function QingTongJiDiAwardUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function QingTongJiDiAwardUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)

    self.bindfunc["on_get_award_btn"] = Utility.bind_callback(self, self.on_get_award_btn)
    self.bindfunc["gc_get_integral_award"] = Utility.bind_callback(self, self.gc_get_integral_award)
    self.bindfunc["on_yeka_change"] = Utility.bind_callback(self, self.on_yeka_change)

end

function QingTongJiDiAwardUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_three_to_three.gc_get_integral_award,self.bindfunc['gc_get_integral_award']);
end

function QingTongJiDiAwardUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_three_to_three.gc_get_integral_award,self.bindfunc['gc_get_integral_award']);
end

function QingTongJiDiAwardUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("qtjd_award_ui");

    self.items = {}
    self.viewIndex = 0

    --预处理积分奖励配置数据
    -- self.pointConfig = {}
    self.dailyConfig = {}
    self.seasonConfig = {}
    local sortFunc = function (A, B)
        if A == nil or B == nil then return false end
        return A > B
    end
    -- for k, v in pairs_key(ConfigManager._GetConfigTable(EConfigIndex.t_three_to_three_integral_award)) do
    --     table.insert( self.pointConfig, v )
    -- end
    for k, v in pairs_key(ConfigManager._GetConfigTable(EConfigIndex.t_three_to_three_daily_award), sortFunc) do
        table.insert( self.dailyConfig, v )
    end
    local date = os.date("*t", system.time())
    self.seasonConfig = ConfigManager.Get(EConfigIndex.t_three_to_three_season_award, date.month) or {}

    self.myDailyIndex = 0
    local integral = self.dataCenter.integral
    for i, config in pairs_key(self.dailyConfig) do
        if config.start_fraction <= integral and config.end_fraction >= integral then
            self.myDailyIndex = i;
            break;
        end
    end
    self.mySeasonIndex = 0
    local rankNum = self.dataCenter.rankNum
    for i, config in pairs(self.seasonConfig) do
        if config.start_ranking <= rankNum and config.end_ranking >= rankNum then
            self.mySeasonIndex = i
            break;
        end
    end

    local path = "centre_other/animation/sco_view/"
    ----------------------- 积分奖励 ----------------------
    self.sv = ngui.find_scroll_view(self.ui, path.."panel")
    self.wc = ngui.find_wrap_content(self.ui, path.."panel/wrap_content")
    self.wc:set_on_initialize_item(self.bindfunc["on_init_item"])

    path = "centre_other/animation/"
    ----------------------- 其他 ----------------------
    self.labBottom1 = ngui.find_label(self.ui, path.."txt")
    self.labBottom2 = ngui.find_label(self.ui, path.."txt_reward")
    local btnClose = ngui.find_button(self.ui, path.."content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])

    path = "centre_other/animation/yeka/"
    local yekaPoint = ngui.find_toggle(self.ui, path.."yeka1")
    local yekaSeason = ngui.find_toggle(self.ui, path.."yeka2")
    yekaPoint:set_on_change(self.bindfunc["on_yeka_change"])
    yekaSeason:set_on_change(self.bindfunc["on_yeka_change"])

    self:SwitchView(1)
    self:UpdateUi()
end

function QingTongJiDiAwardUI:DestroyUi()
    -- if self.previewAwards then
    --     for i, uiItem in pairs(self.previewAwards) do
    --         uiItem:DestroyUi()
    --     end
    --     self.previewAwards = nil
    -- end
    if self.items then
        for b, item in pairs(self.items) do
            for i=1, 4 do
                if item["card"..i] then
                    item["card"..i]:DestroyUi()
                end
            end
        end
        self.items = nil
    end
    self.viewIndex = 0
    self.pointConfig = nil
    self.dailyConfig = nil
    self.seasonConfig = nil

    UiBaseClass.DestroyUi(self);
end

function QingTongJiDiAwardUI:SwitchView(index)
    if not self.ui then return end;
    if index == self.viewIndex then return end

    self.viewIndex = index
    if self.viewIndex == 1 then
        self:UpdateDaily()

    elseif self.viewIndex == 2 then
        self:UpdateSeason()
    end
end

function QingTongJiDiAwardUI:UpdateDaily()
    if not self.ui then return end;
    if self.viewIndex ~= 1 then return end

    self:ResetWrapContent()
    local integral = self.dataCenter.integral
    self.labBottom1:set_text(_local.UIText[6]..PublicFunc.GetColorText(tostring(integral), "new_green"))
    self.labBottom2:set_text(string.format(_local.UIText[3], PublicStruct.DayResetTime))
end

function QingTongJiDiAwardUI:UpdateSeason()
    if not self.ui then return end;
    if self.viewIndex ~= 2 then return end

    self:ResetWrapContent()
    local rankNum = self.dataCenter.rankNum
    self.labBottom1:set_text(_local.UIText[7]..PublicFunc.GetColorText(tostring(rankNum), "new_green"))
    self.labBottom2:set_text(_local.UIText[2])
end

function QingTongJiDiAwardUI:UpdateUi()
    if not self.ui then return end;
    
end

function QingTongJiDiAwardUI:ResetWrapContent()
    local data = nil
    if self.viewIndex == 1 then
        data = self.dailyConfig
    elseif self.viewIndex == 2 then
        data = self.seasonConfig
    else
        data = {}
    end
    self.wc:set_min_index(1-#data);
    self.wc:set_max_index(0)
    self.wc:reset()
    self.sv:reset_position()
end

function QingTongJiDiAwardUI:LoadItemDaily(item, index)
    local data = self.dailyConfig[index]

    if data then
        item.spMe:set_active(self.myDailyIndex == index)
        item.lab:set_text(_local.UIText[4])
        item.labNum:set_text(tostring(data.start_fraction))
        for i=1, 4 do
            local card_name = "card"..i
            if not item[card_name] then break end

            local key_id = "goods"..i.."_id"
            local key_count = "goods"..i.."_count"
            if data[key_id] and data[key_count] and data[key_id] > 0 then
                item[card_name]:Show()
                item[card_name]:SetDataNumber(data[key_id], data[key_count])
                item[card_name]:SetEnablePressGoodsTips(true)
            else
                item[card_name]:Hide()
            end
        end
    end
end

function QingTongJiDiAwardUI:LoadItemSeason(item, index)
    local data = self.seasonConfig[index]

    if data then
        item.spMe:set_active(self.mySeasonIndex == index)
        item.lab:set_text(_local.UIText[5])
        item.labNum:set_text(tostring(data.end_ranking))
        
        for i=1, 4 do
            local card_name = "card"..i
            if not item[card_name] then break end

            local key_id = "goods"..i.."_id"
            local key_count = "goods"..i.."_count"
            if data[key_id] and data[key_count] and data[key_id] > 0 then
                item[card_name]:Show()
                item[card_name]:SetDataNumber(data[key_id], data[key_count])
                item[card_name]:SetEnablePressGoodsTips(true)
            else
                item[card_name]:Hide()            
            end
        end
    end
end

function QingTongJiDiAwardUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1

    local item = self.items[b]
    if not item then
        item = {}
        item.spMe = ngui.find_sprite(obj, "sp_ziji")
        item.lab = ngui.find_label(obj, "sp_ban_tou/lab_jiang_li")
        item.labNum = ngui.find_label(obj, "sp_ban_tou/lab_num")
        for i=1, 4 do
            local obj_card_item = obj:get_child_by_name("grid/small_card_item"..i)
            if obj_card_item then
                item["card"..i] = UiSmallItem:new({parent=obj_card_item})
            else
                break;
            end
        end

        self.items[b] = item
    end

    if self.viewIndex == 1 then
        self:LoadItemDaily(item, index)
    elseif self.viewIndex == 2 then
        self:LoadItemSeason(item, index)
    end
end

function QingTongJiDiAwardUI:on_btn_close()
    uiManager:PopUi()
end

function QingTongJiDiAwardUI:on_yeka_change(value, name)
    if value == true then
        local index = 1
        if name == "yeka1" then
            index = 1
        elseif name == "yeka2" then
            index = 2
        end
        self:SwitchView(index)
    end
end

function QingTongJiDiAwardUI:on_get_award_btn(t)
    local id = t.float_value
    msg_three_to_three.cg_get_integral_award(id)
end

function QingTongJiDiAwardUI:gc_get_integral_award(id, awards)
    CommonAward.Start(awards)

    self:UpdatePoint()
end
