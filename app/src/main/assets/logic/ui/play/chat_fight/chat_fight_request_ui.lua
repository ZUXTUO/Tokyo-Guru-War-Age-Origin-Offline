---
--- Created by 111.
--- DateTime: 2017/8/18 10:48
---

ChatFightRequestUI = Class("ChatFightRequestUI", UiBaseClass)


local _UIText = {
    [1] = "等级[FDE517FF]%s[-]",
    [2] = "好友",
    [3] = "同社员",
    [4] = "陌生人",
    [5] = "社团:",

    [6] = "全部忽略",
    [7] = "全部取消",
    [8] = "约战",
    [9] = "发出",
    [10] = "当前约战申请:[00FF73]%s/%s[-]人"
}

local _TypeDesc = {
    [ENUM.ChatFightPlayerType.Guild] = _UIText[3],
    [ENUM.ChatFightPlayerType.Friend] = _UIText[2],
    [ENUM.ChatFightPlayerType.Stranger] = _UIText[4],
}

local _countDownTime = 60 * 5

function ChatFightRequestUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/chat_fight/ui_5402_yuezhan.assetbundle"
    UiBaseClass.Init(self, data)
end

function ChatFightRequestUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightRequestUI:Restart(data)
    self.currType = ENUM.ChatFightPlayerType.All
    --约战申请
    self.isFight = data.isFight
    self.requestData = {}
    self.wrapItem = {}

    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightRequestUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self,self.on_close)
    self.bindfunc["on_click_yeka"] = Utility.bind_callback(self,self.on_click_yeka)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self,self.on_init_item)

    self.bindfunc["on_btn_cancel_request"] = Utility.bind_callback(self,self.on_btn_cancel_request)
    self.bindfunc["on_btn_cancel"] = Utility.bind_callback(self,self.on_btn_cancel)
    self.bindfunc["on_btn_confirm"] = Utility.bind_callback(self,self.on_btn_confirm)
    self.bindfunc["on_btn_all_cancel"] = Utility.bind_callback(self,self.on_btn_all_cancel)

    self.bindfunc["on_toggle_change"] = Utility.bind_callback(self,self.on_toggle_change)
    self.bindfunc["update_ui"] = Utility.bind_callback(self,self.update_ui)
    self.bindfunc["check_time"] = Utility.bind_callback(self,self.check_time)
end

function ChatFightRequestUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    if self.isFight then
        PublicFunc.msg_regist("msg_1v1.update_request", self.bindfunc['update_ui'])
    else
        PublicFunc.msg_regist("msg_1v1.update_my_request", self.bindfunc['update_ui'])
    end
end

function ChatFightRequestUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    if self.isFight then
        PublicFunc.msg_unregist("msg_1v1.update_request", self.bindfunc['update_ui'])
    else
        PublicFunc.msg_unregist("msg_1v1.update_my_request", self.bindfunc['update_ui'])
    end
end

function ChatFightRequestUI:DestroyUi()
    TimerManager.Remove(self.bindfunc["check_time"])
    for _, v in pairs(self.wrapItem) do
        if v.uiPlayer then
            v.uiPlayer:DestroyUi()
            v.uiPlayer = nil
        end
    end
    self.wrapItem = {}
    UiBaseClass.DestroyUi(self)
end

function ChatFightRequestUI:on_close()
    uiManager:PopUi()
end

function ChatFightRequestUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])
    local lblTitle = ngui.find_label(self.ui, path .. "content_di_1004_564/lab_title")

    local _type = {ENUM.ChatFightPlayerType.All, ENUM.ChatFightPlayerType.Guild,
            ENUM.ChatFightPlayerType.Friend, ENUM.ChatFightPlayerType.Stranger}
    for i = 1, 4 do
        local btnYeka = ngui.find_button(self.ui, path .. "yeka/yeka" .. i)
        btnYeka:set_event_value("", _type[i])
        btnYeka:set_on_click(self.bindfunc["on_click_yeka"])
    end

    local panelPath = path .. "scroll_view/panel_list"
    self.scrollView = ngui.find_scroll_view(self.ui, panelPath)
    self.wrapContent = ngui.find_wrap_content(self.ui, panelPath .. "/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self.lblRequestCnt = ngui.find_label(self.ui, path .. "cont_down/lab")

    local toggleShield = ngui.find_toggle(self.ui, path .. "cont_down/yeka_down")
    toggleShield:set_on_change(self.bindfunc["on_toggle_change"])
    toggleShield:set_value(g_dataCenter.chatFight:Ishield())

    local lblShield = ngui.find_label(self.ui, path .. "cont_down/txt")

    local btnAllCancel = ngui.find_button(self.ui, path .. "cont_down/btn")
    btnAllCancel:set_on_click(self.bindfunc["on_btn_all_cancel"])
    local lblAllCancel = ngui.find_label(self.ui, path .. "cont_down/btn/animation/lab")
    lblAllCancel:set_text(_UIText[7])

    if self.isFight then
        lblTitle:set_text(_UIText[8])
        toggleShield:set_active(true)
        lblShield:set_active(true)
    else
        lblTitle:set_text(_UIText[9])
        toggleShield:set_active(false)
        lblShield:set_active(false)
    end

    self:update_ui()

    TimerManager.Add( self.bindfunc["check_time"], 1000, -1)
    self:check_time()
end

function ChatFightRequestUI:on_click_yeka(t)
    if t.float_value ~= self.currType then
        self.currType = t.float_value
        self:update_ui()
    end
end

function ChatFightRequestUI:update_ui()
    self.requestData = g_dataCenter.chatFight:GetRequestList(self.isFight, self.currType)
    self.reqCnt = #self.requestData
    self.wrapContent:set_min_index(- self.reqCnt + 1)
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position()

    self:UpdateCnt()
end

function ChatFightRequestUI:UpdateCnt()
    local id = nils
    if self.isFight then
        id = MsgEnum.ediscrete_id.eDiscreteID_1v1_request_count
    else
        id = MsgEnum.ediscrete_id.eDiscreteID_1v1_my_request_count
    end
    local cnt = g_dataCenter.chatFight:GetRequestCnt(self.isFight)
    self.lblRequestCnt:set_text(string.format(_UIText[10], cnt, ConfigManager.Get(EConfigIndex.t_discrete, id).data))
end

function ChatFightRequestUI:check_time()
    if self.reqCnt == 0 then
        return
    end
    self:UpdateCnt()

    local currTime = system.time()
    local isUp = false
    for _, data in pairs(self.requestData) do
        if currTime - tonumber(data.starTime) >= _countDownTime then
            isUp = true
            break
        end
    end

    if isUp then
        self:update_ui()
    else
        for _, item in pairs(self.wrapItem) do
            local data = self.requestData[item.dataIndex]
            if data ~= nil then
                local diffSec = _countDownTime - (currTime - tonumber(data.starTime))
                if diffSec > 0 then
                    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
                    item.lblTime:set_text(string.format("%02d:", min) .. string.format("%02d", sec))
                end
            end
        end
    end
end

function ChatFightRequestUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1

    if self.wrapItem[row] == nil then
        local item = {}
        local objHead = obj:get_child_by_name("sp_head_di_item")
        item.uiPlayer = UiPlayerHead:new({parent = objHead})

        item.lblName = ngui.find_label(obj, "lab_name")
        item.lblLevel = ngui.find_label(obj, "lab_level")

        item.lblFightValue = ngui.find_label(obj, "sp_fight/lab_fight")
        item.lblLabel = ngui.find_label(obj, "sp_biaoqian/lab")
        item.lblOnline = ngui.find_label(obj, "lab_zaixian")
        item.lblOnline:set_active(false)

        item.lblGuild = ngui.find_label(obj, "lab_shetuan")

        item.lblTime = ngui.find_label(obj, "lab_time")

        item.objCont1 = obj:get_child_by_name("cont1")
        item.objCont2 = obj:get_child_by_name("cont2")

        item.btnCancelRequest = ngui.find_button(obj, "cont1/btn")
        item.btnCancelRequest:set_on_click(self.bindfunc["on_btn_cancel_request"])

        item.btnCancel = ngui.find_button(obj, "cont2/btn1")
        item.btnCancel:set_on_click(self.bindfunc["on_btn_cancel"])
        item.btnConfirm = ngui.find_button(obj, "cont2/btn2")
        item.btnConfirm:set_on_click(self.bindfunc["on_btn_confirm"])

        item.dataIndex = nil
        self.wrapItem[row] = item
    end

    local item = self.wrapItem[row]
    local data = self.requestData[index]
    if data == nil then
        return
    end
    item.dataIndex = index

    item.uiPlayer:SetRoleId(data.playerImage)

    item.lblName:set_text(data.playerName)
    item.lblLevel:set_text(string.format(_UIText[1], data.player_level))
    item.lblFightValue:set_text(tostring(data.fightValue))
    item.lblLabel:set_text(_TypeDesc[data.type])

    item.lblGuild:set_text(_UIText[5] .. data.guildName)

    if self.isFight then
        item.objCont1:set_active(false)
        item.objCont2:set_active(true)
        item.btnCancel:set_event_value(data.playerid, 0)
        item.btnConfirm:set_event_value(data.playerid, 0)
    else
        item.objCont1:set_active(true)
        item.objCont2:set_active(false)
        item.btnCancelRequest:set_event_value(data.playerid, 0)
    end
end

function ChatFightRequestUI:on_btn_cancel(t)
    msg_1v1.cg_answer_challenge(false, t.string_value)
end

function ChatFightRequestUI:on_btn_confirm(t)
    msg_1v1.cg_answer_challenge(true, t.string_value)
end

function ChatFightRequestUI:on_btn_all_cancel()
    if self.reqCnt == 0 then
        return
    end
    if self.isFight then
        msg_1v1.cg_answer_challenge(false, 0)
    else
        msg_1v1.cg_cancel_challenge(0)
    end
end

function ChatFightRequestUI:on_btn_cancel_request(t)
    msg_1v1.cg_cancel_challenge(t.string_value)
end

function ChatFightRequestUI:on_toggle_change(value)
    local ishield = g_dataCenter.chatFight:Ishield()
    if value ~= ishield then
        msg_1v1.cg_set_1v1_function_state(not ishield)
    end
end