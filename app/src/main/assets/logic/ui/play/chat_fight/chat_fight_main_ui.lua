
ChatFightMainUI = Class("ChatFightMainUI", UiBaseClass)


local _UIText = {
}

function ChatFightMainUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/chat_fight/ui_5401_yuezhan.assetbundle"
    UiBaseClass.Init(self, data)
end

function ChatFightMainUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightMainUI:on_navbar_back()
    ChatUI.HideUI()
    uiManager:PopUi()
    return true
end

function ChatFightMainUI:ProcessData()
    local ids = g_dataCenter.chatFight:GetHeroIdsByWeek()
    self.heroDataList = {}
    for i = 1, #ids do
        local cardInfo = g_dataCenter.package:find_card_for_num(1, ids[i])
        if cardInfo == nil then
            cardInfo = CardHuman:new({number = ids[i], isNotCalProperty = true})
            --头像设置为金色
            cardInfo.realRarity = ENUM.EHeroRarity.Orange
        end
        self.heroDataList[i] = cardInfo
    end
    --资质排序
    table.sort(self.heroDataList, function(a, b)
        return a.config.aptitude > b.config.aptitude
    end)
    self.heroPageMax = math.ceil(#self.heroDataList / 8)

    local buffIds = g_dataCenter.chatFight:GetBuffIdsByWeek()
    self.buffCfg = {}
    for i = 1, #buffIds do
        self.buffCfg[i] = ConfigManager.Get(EConfigIndex.t_chat_1v1_buff, buffIds[i])
    end
    self.buffPageMax = math.ceil(#self.buffCfg / 6)

    self.currHeroPage = 1
    self.currBuffPage = 1
end

function ChatFightMainUI:Restart(data)
    self:ProcessData()
    self.currWeek = g_dataCenter.chatFight:GetWeek()
    self.currShield = g_dataCenter.chatFight:Ishield()
    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightMainUI:Show()
    UiBaseClass.Show(self)
    ChatUI.SetAndShow({
        showType = PublicStruct.Chat.fight
    }, true)
end

function ChatFightMainUI:Hide()
    UiBaseClass.Hide(self)
    ChatUI.HideUI()
end

function ChatFightMainUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_btn_request"] = Utility.bind_callback(self,self.on_btn_request)
    self.bindfunc["on_btn_award"] = Utility.bind_callback(self,self.on_btn_award)
    self.bindfunc["check_chat_fight_request"] = Utility.bind_callback(self, self.check_chat_fight_request)

    self.bindfunc["on_btn_arrow_hero"] = Utility.bind_callback(self,self.on_btn_arrow_hero)
    self.bindfunc["on_btn_arrow_buff"] = Utility.bind_callback(self,self.on_btn_arrow_buff)
    self.bindfunc["gc_sync_my_1v1_data"] = Utility.bind_callback(self,self.gc_sync_my_1v1_data)
    self.bindfunc["on_press_buff"] = Utility.bind_callback(self, self.on_press_buff)
end

--注册消息分发回调函数
function ChatFightMainUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_1v1.gc_sync_my_1v1_data, self.bindfunc["gc_sync_my_1v1_data"]);
end

--注销消息分发回调函数
function ChatFightMainUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_1v1.gc_sync_my_1v1_data, self.bindfunc["gc_sync_my_1v1_data"]);
end

function ChatFightMainUI:DestroyUi()
    if self.smallCardHero then
        for _, card in pairs(self.smallCardHero) do
            card:DestroyUi()
            card = nil
        end
    end
    if self.textBuff then
        for _, text in pairs(self.textBuff) do
            text:Destroy()
            text = nil
        end
    end
    if self.popUpUi then
        if self.popUpUi.textBuff then
            self.popUpUi.textBuff:Destroy()
            self.popUpUi.textBuff = nil
        end
    end

    ChatFightSendInfoUI.End()
    TimerManager.Remove(self.bindfunc['check_chat_fight_request'])

    UiBaseClass.DestroyUi(self)
end

function ChatFightMainUI:on_btn_request()
    uiManager:PushUi(EUI.ChatFightRequestUI, {isFight = true})
end

function ChatFightMainUI:on_btn_award()
    uiManager:PushUi(EUI.ChatFightAwardUI)
end

function ChatFightMainUI:HandleShield()
    local flag = g_dataCenter.chatFight:Ishield()
    if self.spShieldRequest then
        self.spShieldRequest:set_active(flag)
    end
end

function ChatFightMainUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "right_other/animation/"
    ChatUI.SetAndShow({
        showType = PublicStruct.Chat.fight
    }, true)

    local btnRequest = ngui.find_button(self.ui, "right_top_other/animation/btn_zhanbao")
    btnRequest:set_on_click(self.bindfunc["on_btn_request"])
    local btnAward = ngui.find_button(self.ui, "right_top_other/animation/btn_award")
    btnAward:set_on_click(self.bindfunc["on_btn_award"])
    self.spShieldRequest = ngui.find_sprite(self.ui, "right_top_other/animation/btn_zhanbao/animation/sp_jinzhi")
    self:HandleShield()

    self.gridHero = ngui.find_grid(self.ui, path .. "grid1")
    self.smallCardHero = {}
    for i = 1, 8 do
        local _obj = self.ui:get_child_by_name("grid1/big_card_item_80" .. i)
        self.smallCardHero[i] = SmallCardUi:new({parent = _obj, upFrame = false,
            stypes = { SmallCardUi.SType.Texture, SmallCardUi.SType.Aptitude, SmallCardUi.SType.Rarity}
        });
    end

    self.gridBuff = ngui.find_grid(self.ui, path .. "grid2")
    self.textBuff = {}
    for i = 1, 6 do
        self.textBuff[i] = ngui.find_texture(self.ui, path .. "grid2/Texture" .. i)
        local btn = ngui.find_button(self.ui, path .. "grid2/Texture" .. i)
        btn:set_on_ngui_press(self.bindfunc["on_press_buff"])
        btn:set_name(tostring(i))
    end

    self.btnArrowHeroL = ngui.find_button(self.ui, path .. "btn_arrows2")
    self.btnArrowHeroL:set_event_value("", -1)
    self.btnArrowHeroL:set_on_click(self.bindfunc["on_btn_arrow_hero"])

    self.btnArrowHeroR = ngui.find_button(self.ui, path .. "btn_arrows1")
    self.btnArrowHeroR:set_event_value("", 1)
    self.btnArrowHeroR:set_on_click(self.bindfunc["on_btn_arrow_hero"])

    self.btnArrowBuffL = ngui.find_button(self.ui, path .. "btn_arrows4")
    self.btnArrowBuffL:set_event_value("", -1)
    self.btnArrowBuffL:set_on_click(self.bindfunc["on_btn_arrow_buff"])

    self.btnArrowBuffR = ngui.find_button(self.ui, path .. "btn_arrows3")
    self.btnArrowBuffR:set_event_value("", 1)
    self.btnArrowBuffR:set_on_click(self.bindfunc["on_btn_arrow_buff"])

    self.popUpUi = {
        objCont = self.ui:get_child_by_name(path .. "cont"),
        lblBuffName = ngui.find_label(self.ui, path .. "cont/lab_2"),
        lblBuffDesc = ngui.find_label(self.ui, path .. "cont/lab_1"),
        textBuff = ngui.find_texture(self.ui, path .. "cont/texture_buff"),
    }
    self.popUpUi.objCont:set_active(false)
    TimerManager.Add(self.bindfunc['check_chat_fight_request'], 1000, -1)
    self.curHaveRequest = nil

    self:UpdateUI()
end

function ChatFightMainUI:check_chat_fight_request()
    if not self:IsShow() then
        return
    end
    local flag = g_dataCenter.chatFight:HaveRequest(true)
    --更新请求小红点
    if  flag ~= self.curHaveRequest then
        self.curHaveRequest = flag
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Chat_Fight_Request)
    end
end

function ChatFightMainUI:gc_sync_my_1v1_data()
    local newWeek = g_dataCenter.chatFight:GetWeek()
    if self.currWeek ~= newWeek then
        self.currWeek = newWeek
        self:ProcessData()
        self:UpdateUI()
    end
    local flag = g_dataCenter.chatFight:Ishield()
    if self.currShield ~= flag then
        self.currShield = flag
        self:HandleShield()
    end
end

function ChatFightMainUI:UpdateUI()
    self:UpdateHero()
    self:UpdateBuff()
end

function ChatFightMainUI:UpdateHero()
    local sPos = (self.currHeroPage - 1) * 8
    for i = 1, 8 do
        local smallCard = self.smallCardHero[i]
        local cardInfo = self.heroDataList[sPos + i]
        if cardInfo then
            smallCard:Show()
            smallCard:SetData(cardInfo)
            -- s以上资质要显示特效
            smallCard:SetAsReward(cardInfo.config.aptitude >= 4)
        else
            smallCard:Hide()
        end
    end
    if #self.heroDataList <= 8 then
        self.btnArrowHeroL:set_active(false)
        self.btnArrowHeroR:set_active(false)
    else
        self.btnArrowHeroL:set_active(false)
        self.btnArrowHeroR:set_active(false)
        if self.currHeroPage > 1 then
            self.btnArrowHeroL:set_active(true)
        end
        if self.currHeroPage < self.heroPageMax then
            self.btnArrowHeroR:set_active(true)
        end
    end
    self.gridHero:reposition_now()
end

function ChatFightMainUI:UpdateBuff()
    local sPos = (self.currBuffPage - 1) * 6
    for i = 1, 6 do
        local text = self.textBuff[i]
        local cfg = self.buffCfg[sPos + i]
        if cfg then
            text:set_active(true)
            text:set_texture(cfg.icon)
        else
            text:set_active(false)
        end
    end
    if #self.buffCfg <= 6 then
        self.btnArrowBuffL:set_active(false)
        self.btnArrowBuffR:set_active(false)
    else
        self.btnArrowBuffL:set_active(false)
        self.btnArrowBuffR:set_active(false)
        if self.currBuffPage > 1 then
            self.btnArrowBuffL:set_active(true)
        end
        if self.currBuffPage < self.buffPageMax then
            self.btnArrowBuffR:set_active(true)
        end
    end
    self.gridBuff:reposition_now()
end

function ChatFightMainUI:on_btn_arrow_hero(t)
    self.currHeroPage = self.currHeroPage + t.float_value
    if self.currHeroPage < 1 then
        self.currHeroPage = 1
    end
    if self.currHeroPage > self.heroPageMax then
        self.currHeroPage = self.heroPageMax
    end
    self:UpdateHero()
end

function ChatFightMainUI:on_btn_arrow_buff(t)
    self.currBuffPage = self.currBuffPage + t.float_value
    if self.currBuffPage < 1 then
        self.currBuffPage = 1
    end
    if self.currBuffPage > self.buffPageMax then
        self.currBuffPage = self.buffPageMax
    end
    self:UpdateBuff()
end

function ChatFightMainUI:on_press_buff(name, state, x, y, go_obj)
    if state then
        self.popUpUi.objCont:set_active(true)
        local sPos = (self.currBuffPage - 1) * 6
        local cfg = self.buffCfg[sPos + tonumber(name)]
        if cfg then
            self.popUpUi.lblBuffName:set_text(cfg.name or '')
            self.popUpUi.lblBuffDesc:set_text(cfg.desc or '')
            self.popUpUi.textBuff:set_texture(cfg.icon)
        end
    else
        self.popUpUi.objCont:set_active(false)
    end
end