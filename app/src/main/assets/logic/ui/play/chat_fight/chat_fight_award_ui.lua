---
--- Created by 111.
--- DateTime: 2017/8/18 10:48
---

ChatFightAwardUI = Class("ChatFightAwardUI", UiBaseClass)


local _UIText = {
    [1] = "本周约战次数:[00FF73FF]%s[-]",
    [2] = "本周胜利次数:[00FF73FF]%s[-]",

    [3] = "周约战到达    次",
    [4] = "周胜利到达    次",
    [5] = "未达到领取条件"
}

function ChatFightAwardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/chat_fight/ui_5403_yuezhan.assetbundle"
    UiBaseClass.Init(self, data)
end

function ChatFightAwardUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightAwardUI:Restart(data)
    self.wrapItem = {}
    self.currYeka = "yeka1"
    self.currType = ENUM.ChatFightAward.Fight
    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightAwardUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self,self.on_close)
    self.bindfunc["update_ui"] = Utility.bind_callback(self,self.update_ui)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self,self.on_init_item)
    self.bindfunc["on_get_award"] = Utility.bind_callback(self,self.on_get_award)
    self.bindfunc["on_yeka"] = Utility.bind_callback(self,self.on_yeka)
end

function ChatFightAwardUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_1v1.gc_get_week_reward, self.bindfunc['update_ui'])
end

function ChatFightAwardUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_1v1.gc_get_week_reward, self.bindfunc['update_ui'])
end

function ChatFightAwardUI:DestroyUi()
    for _, v in pairs(self.wrapItem) do
        if v.smallItem then
            for _, vv in pairs(v.smallItem) do
                if vv then
                    vv:DestroyUi()
                    vv = nil
                end
            end
        end
    end
    self.wrapItem = {}
    UiBaseClass.DestroyUi(self)
end

function ChatFightAwardUI:on_close()
    uiManager:PopUi()
end

function ChatFightAwardUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    local btnAward = ngui.find_button(self.ui, path .. "yeka/yeka1")
    btnAward:set_event_value("yeka1", 0)
    btnAward:set_on_click(self.bindfunc["on_yeka"])

    local btnWinnerAward = ngui.find_button(self.ui, path .. "yeka/yeka2")
    btnWinnerAward:set_event_value("yeka2", 0)
    btnWinnerAward:set_on_click(self.bindfunc["on_yeka"])


    local panelPath = path .. "scroll_view/panel_list"
    self.scrollView = ngui.find_scroll_view(self.ui, panelPath)
    self.wrapContent = ngui.find_wrap_content(self.ui, panelPath .. "/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self.lblTimes = ngui.find_label(self.ui, path .. "cont_down/lab")

    self:update_ui()
end

function ChatFightAwardUI:on_yeka(t)
    if t.string_value ~= self.currYeka then
        self.currYeka = t.string_value
        self:update_ui()
    end
end

function ChatFightAwardUI:update_ui()
    local info = g_dataCenter.chatFight:GetAwardInfo()
    if self.currYeka == "yeka1" then
        self.currTimes = info.fightTimes
        self.currType = ENUM.ChatFightAward.Fight
        self.lblTimes:set_text(string.format(_UIText[1], self.currTimes))
    else
        self.currTimes = info.winTimes
        self.currType = ENUM.ChatFightAward.Win
        self.lblTimes:set_text(string.format(_UIText[2], self.currTimes))
    end

    self.cfg = g_dataCenter.chatFight:GetAwardCfg(self.currType)
    self.wrapContent:set_min_index(-#self.cfg + 1)
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position()
end

function ChatFightAwardUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1

    local data = self.cfg[index]
    if data == nil then return end

    if self.wrapItem[row] == nil then
        local item = {}
        item.lblDesc = ngui.find_label(obj, "txt")
        item.lblToTimes = ngui.find_label(obj, "txt/lab_num")

        item.grid = ngui.find_grid(obj, "grid")
        item.smallItem = {}
        for i = 1, 4 do
            local _objItem = obj:get_child_by_name("grid/new_small_card_item" .. i)
            item.smallItem[i] = UiSmallItem:new({parent = _objItem, cardInfo = nil, delay = 500, is_enable_goods_tip = true})
        end

        item.spLabel = ngui.find_sprite(obj, "sp_biaoqian")
        item.spLabel:set_active(false)

        item.spGetIcon = ngui.find_sprite(obj, "sp_art_font")

        item.btnGet = ngui.find_button(obj, "btn1")
        item.btnGet:set_on_click(self.bindfunc["on_get_award"])
        item.spGet = ngui.find_sprite(obj, "btn1/animation/sp")
        item.lblGet = ngui.find_label(obj, "btn1/animation/lab")

        self.wrapItem[row] = item
    end

    local item = self.wrapItem[row]
    if self.currType == ENUM.ChatFightAward.Fight then
        item.lblDesc:set_text(_UIText[3])
    else
        item.lblDesc:set_text(_UIText[4])
    end

    local _times = data.id
    item.lblToTimes:set_text(tostring(_times))

    local dropData = self:GetDropData(data.reward_dropid)
    for k, v in pairs(item.smallItem) do
        local _data = dropData[k]
        if _data then
            v:Show()
            v:SetDataNumber(_data.id, _data.num)
        else
            v:Hide()
        end
    end
    item.grid:reposition_now()

    item.spGetIcon:set_active(false)
    item.btnGet:set_active(false)
    local isGet = g_dataCenter.chatFight:CheckAwardIsGet(self.currType, _times)
    if isGet then
        item.spGetIcon:set_active(true)
    else
        item.btnGet:set_active(true)
        item.btnGet:set_event_value("", _times)

        local _mode = 1
        --不可领取
        if _times > self.currTimes then
            _mode = 3
        end
        local eData = PublicFunc.GetButtonShowData(_mode)
        item.spGet:set_sprite_name(eData.nameSprite)
        item.lblGet:set_color(eData.colorTxt[1]/255, eData.colorTxt[2]/255, eData.colorTxt[3]/255, 1)
    end
end

function ChatFightAwardUI:GetDropData(dropId)
    local _awards = {}
    local cfg = ConfigManager.Get(EConfigIndex.t_drop_something, dropId);
    for i, v in pairs(cfg) do
        if v.goods_show_number > 0 then
            table.insert(_awards, {id = v.goods_show_number, num = v.goods_number})
        end
    end
    return _awards
end

function ChatFightAwardUI:on_get_award(t)
    local times = t.float_value
    if times > self.currTimes then
        FloatTip.Float(_UIText[5])
        return
    end
    msg_1v1.cg_get_week_reward(self.currType, times)
end