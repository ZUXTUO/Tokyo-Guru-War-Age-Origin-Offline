
ChatFightSelectHeroUI = Class("ChatFightSelectHeroUI", UiBaseClass)


local _UIText = {
    [1] = "先手",
    [2] = "后手",
    [3] = "我方已选",
    [4] = "敌方已选",
    [5] = "我方选择",
    [6] = "敌方选择",
}

local _SelectCfg = {
    ["my"] = {spName = "yz_xuanren_di2", txt = _UIText[3]},
    ["enemy"] = {spName = "yz_xuanren_di3", txt = _UIText[4]}
}

local _CountDown = 10

function ChatFightSelectHeroUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/chat_fight/ui_5407_yuezhan.assetbundle"
    UiBaseClass.Init(self, data)
end

function ChatFightSelectHeroUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightSelectHeroUI:Restart(data)
    self.fightData = g_dataCenter.chatFight:GetStartFightData()
    self.cardDataCache = {}
    self.currSelectIndex = {}

    self.currState = nil
    self.startSec = _CountDown

    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightSelectHeroUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["update_ui"] = Utility.bind_callback(self, self.update_ui)
    self.bindfunc["on_btn_confirm"] = Utility.bind_callback(self, self.on_btn_confirm)
    self.bindfunc["on_big_card_click"] = Utility.bind_callback(self,self.on_big_card_click)
    self.bindfunc["update_time"] = Utility.bind_callback(self,self.update_time)

    self.bindfunc["gc_sync_select_state"] = Utility.bind_callback(self,self.gc_sync_select_state)
    self.bindfunc["gc_update_select_role_data"] = Utility.bind_callback(self,self.gc_update_select_role_data)
end

function ChatFightSelectHeroUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_1v1.gc_update_select_role_data, self.bindfunc['gc_update_select_role_data'])
    PublicFunc.msg_regist(msg_1v1.gc_sync_select_state, self.bindfunc['gc_sync_select_state'])
end

function ChatFightSelectHeroUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_1v1.gc_update_select_role_data, self.bindfunc['gc_update_select_role_data'])
    PublicFunc.msg_unregist(msg_1v1.gc_sync_select_state, self.bindfunc['gc_sync_select_state'])
end

function ChatFightSelectHeroUI:DestroyUi()
    for _,v in pairs(self.topHero) do
        if v.smallCard then
            for _, card in pairs(v.smallCard) do
                if card then
                    card:DestroyUi()
                    card = nil
                end
            end
        end
        if v.uiPlayer then
            v.uiPlayer:DestroyUi()
            v.uiPlayer = nil
        end
    end
    for _, v in pairs(self.centerHero) do
        if v.bigCard then
            v.bigCard:DestroyUi()
            v.bigCard = nil
        end
    end
    TimerManager.Remove(self.bindfunc["update_time"])
    UiBaseClass.DestroyUi(self)
end

function ChatFightSelectHeroUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "center_other/animation/"

    self.objAnimation = self.ui:get_child_by_name("center_other/animation")
    self.topHero = {}
    for i = 1, 2 do
        local tPath = path .. "top_other/cont" .. i .. "/"
        local temp = {}
        local objHead = self.ui:get_child_by_name(tPath .. "sp_head_di_item")
        temp.uiPlayer = UiPlayerHead:new({parent = objHead, vip = g_dataCenter.player.vip})

        temp.lblName = ngui.find_label(self.ui, tPath .. "lab_name")
        temp.lblFirst = ngui.find_label(self.ui, tPath .. "lab_xianshou")

        temp.smallCard = {}
        temp.fx = {}
        for j = 1, 3 do
            local _obj = self.ui:get_child_by_name(tPath .. "big_card_item_80" .. j)
            temp.smallCard[j] = SmallCardUi:new({parent = _obj,
                stypes = { SmallCardUi.SType.Texture, SmallCardUi.SType.Aptitude, SmallCardUi.SType.Rarity }
            });
            local fx = _obj:get_child_by_name("fx_ui_5407_touxiang")
            fx:set_active(false)
            temp.fx[j] = fx
        end
        self.topHero[i] = temp
    end

    self.lblSelect = ngui.find_label(self.ui, path .. "top_other/lab_xianshou")
    self.lblCountDownTime = ngui.find_label(self.ui, path .. "top_other/lab_time")
    self.lblCountDownTime:set_text(tostring(self.startSec))

    self.centerHero = {}
    for i = 1, 6 do
        local _obj = self.ui:get_child_by_name(path .. "center_other/cont_big_item" .. i)
        local bigCard = UiBigCard:new({
            parent = _obj,
            infoType = 1,
            showAddButton = false,
            showStar = false,
            showLvl = false,
            showFight = false,
            useWhiteName = true,
        })

        bigCard:SetTeamPos(-1)
        bigCard:SetCallback(self.bindfunc["on_big_card_click"])

        local objFx = _obj:get_child_by_name("fx_ui_5407_xuanze")
        objFx:set_active(false)

        local spEye = ngui.find_sprite(_obj, "sp_kexuan")
        spEye:set_active(false)
        self.centerHero[i] = {
            spSelect = ngui.find_sprite(_obj, "sp_xuanze"),
            lblSelect = ngui.find_label(_obj, "sp_xuanze/lab1"),
            objFx = objFx,
            bigCard = bigCard,
            spEye = spEye,
            --lblClickCheck = ngui.find_label(_obj, "lab_dianji"),
            lblRandomRole = ngui.find_label(_obj, "lab_suiji"),
        }

    end

    self.btnConfirm = ngui.find_button(self.ui, "down_other/btn_yellow")
    self.btnConfirm:set_on_click(self.bindfunc["on_btn_confirm"])

    self.lblEnemySelect = ngui.find_label(self.ui, "down_other/lab_difang")

    TimerManager.Add(self.bindfunc["update_time"], 1000, _CountDown)

    --第一阶段手动调用
    self:gc_sync_select_state()
end

function ChatFightSelectHeroUI:update_time()
    self.startSec = self.startSec - 1
    if self.startSec >= 0 then
        self.lblCountDownTime:set_text(tostring(self.startSec))
    end
end

function ChatFightSelectHeroUI:GetCardDataFromCache(number)
    if self.cardDataCache[number] == nil then
        self.cardDataCache[number] = CardHuman:new({number = number, isNotCalProperty = true})
        --头像设置为金色
        self.cardDataCache[number].realRarity = ENUM.EHeroRarity.Orange
    end
    return self.cardDataCache[number]
end

function ChatFightSelectHeroUI:gc_sync_select_state()
    if self:GetCanSelectCnt() > 0 then
        self.objAnimation:animated_play("fx_ui_5407_yuezhan_blue")
    else
        self.objAnimation:animated_play("fx_ui_5407_yuezhan_red")
    end
    self:update_ui()
end

function ChatFightSelectHeroUI:gc_update_select_role_data(updata)
    self:update_ui()

    for k, ui in pairs(self.topHero) do
        local data = self.fightData.playerData[k]
        local roleList = g_dataCenter.chatFight:GetRoleListByPlayerId(data.playerid)
        for kk, fx in pairs(ui.fx) do
            local roleData = roleList[kk]
            if roleData then
                local isChecked = false
                for _, v in pairs(updata) do
                    if v.index == roleData.index then
                        isChecked = true
                        break
                    end
                end
                if isChecked then
                    fx:set_active(false)
                    fx:set_active(true)
                else
                    fx:set_active(false)
                end
            end
        end
    end
end

function ChatFightSelectHeroUI:update_ui()

    self.canSelectCnt = self:GetCanSelectCnt()

    --状态改变, 清空选择英雄
    local _state = g_dataCenter.chatFight:GetSyncState()
    if self.currState ~= _state then
        self.currState = _state
        self.currSelectIndex = {}
        --默认选择
        local cnt = 0
        if self.canSelectCnt > 0 then
            for i = 1, 6 do
                local data = self.fightData.roleData[i]
                if data.ownerID == '0' then
                    table.insert(self.currSelectIndex, data.index)
                    cnt = cnt + 1
                    if cnt >= self.canSelectCnt then
                        break
                    end
                end
            end
            if g_dataCenter.chatFight:GetSyncState() ~= ENUM.ChatFightSelectState.SecondOne then
                --更新选中
                self:on_btn_confirm()
            end
        end
        self.replacePos = 1

        self.startSec = 10
        TimerManager.Add(self.bindfunc["update_time"], 1000, _CountDown)
    end

    local myId = g_dataCenter.player:GetGID()
    for k, ui in pairs(self.topHero) do
        local data = self.fightData.playerData[k]

        ui.uiPlayer:SetRoleId(data.playerImage)
        ui.lblName:set_text(data.playerName)
        if data.bFirst then
            ui.lblFirst:set_text(_UIText[1])
        else
            ui.lblFirst:set_text(_UIText[2])
        end
        local roleList = g_dataCenter.chatFight:GetRoleListByPlayerId(data.playerid)
        for kk, card in pairs(ui.smallCard) do
            local roleData = roleList[kk]
            --敌方不可见角色, 选中后...
            if roleData and roleData.bVisible == false and roleData.ownerID ~= '0' and roleData.ownerID ~= myId then
                card:SetRarityOrange()
            else
                if (roleData and roleData.bVisible) or (roleData and roleData.ownerID == myId) then
                    card:SetData(self:GetCardDataFromCache(roleData.cardNumber))
                else
                    card:SetData(nil)
                end
            end
        end
    end

    for k, ui in pairs(self.centerHero) do
        local data = self.fightData.roleData[k]
        local cardData = nil
        if (data and data.bVisible) or (data and data.ownerID == myId) then
            cardData = self:GetCardDataFromCache(data.cardNumber)
        end
        ui.bigCard:SetData(cardData, 1)
        ui.bigCard:SetParam(data.index)
        if data.ownerID == "0" then
            ui.bigCard:SetGray(false)
        else
            ui.bigCard:SetGray(true)
        end

        if data.ownerID == "0" then
            ui.spSelect:set_active(false)
        else
            ui.spSelect:set_active(true)
            local key = "enemy"
            if data.ownerID == myId then
                key = "my"
            end
            local cfg = _SelectCfg[key]
            ui.spSelect:set_sprite_name(cfg.spName)
            ui.lblSelect:set_text(cfg.txt)
        end

        --最后阶段不提示
        --[[if _state == ENUM.ChatFightSelectState.SecondOne then
            ui.lblClickCheck:set_active(false)
        else
            ui.lblClickCheck:set_active(cardData == nil and self.canSelectCnt > 0 and data.ownerID == "0")
        end]]
        ui.lblRandomRole:set_active(cardData == nil)

        local isShow = false
        if self.canSelectCnt > 0 and data.ownerID == "0" then
            if not self:isChecked(data.index) then
                isShow = true
            end
        end
        ui.spEye:set_active(isShow)
    end

    --自己选择
    if self.canSelectCnt > 0 then
        self.btnConfirm:set_active(true)
        self.lblEnemySelect:set_active(false)
        self.lblSelect:set_text(_UIText[5])

    else
        self.btnConfirm:set_active(false)
        self.lblEnemySelect:set_active(true)
        self.lblSelect:set_text(_UIText[6])
    end
    --self:UpdateBtn()
    self:UpdateItemSelect()
end

function ChatFightSelectHeroUI:GetCanSelectCnt()
    local isFirst = g_dataCenter.chatFight:IsFirstHand()
    local state = g_dataCenter.chatFight:GetSyncState()

    if state == ENUM.ChatFightSelectState.FirstOne then
        if isFirst then
            return 1
        else
            return 0
        end
    elseif state == ENUM.ChatFightSelectState.SecondTwo then
        if isFirst then
            return 0
        else
            return 2
        end
    elseif state == ENUM.ChatFightSelectState.FirstTwo then
        if isFirst then
            return 2
        else
            return 0
        end
    elseif state == ENUM.ChatFightSelectState.SecondOne then
        if isFirst then
            return 0
        else
            return 1
        end
    end
end

function ChatFightSelectHeroUI:on_big_card_click(bigCard, cardInfo, para)
    --不能选中
    if self.canSelectCnt == 0 then
        return
    end

    --已经被人选择，不能再选择
    if g_dataCenter.chatFight:CheckIsSelect(para) then
        return
    end

    --已选
    if self:isChecked(para) then
        return
    end

    --[[for k, v in pairs(self.fightData.roleData) do
        if v.index == para then
            if self.centerHero then
                self.centerHero[k].lblClickCheck:set_active(false)
            end
            break
        end
    end]]

    --直接替换
    if self.canSelectCnt == 1 then
        self.currSelectIndex[1] = para
    else
        self.currSelectIndex[self.replacePos] = para
        if self.replacePos == 1 then
            self.replacePos = 2
        else
            self.replacePos = 1
        end
    end

    for k, ui in pairs(self.centerHero) do
        local data = self.fightData.roleData[k]
        local isShow = false
        if self.canSelectCnt > 0 and data.ownerID == "0" then
            if not self:isChecked(data.index) then
                isShow = true
            end
        end
        ui.spEye:set_active(isShow)
    end

    --self:UpdateBtn()
    self:UpdateItemSelect()
    self:on_btn_confirm()
end

function ChatFightSelectHeroUI:isChecked(index)
    --已选
    for i = self:GetSelectCnt(), 1, -1 do
        if self.currSelectIndex[i] == index then
            return true
        end
    end
    return false
end

function ChatFightSelectHeroUI:UpdateBtn()
    if self:GetSelectCnt() > 0 and self:GetSelectCnt() == self.canSelectCnt then
        PublicFunc.SetButtonShowMode(self.btnConfirm, 1)
    else
        PublicFunc.SetButtonShowMode(self.btnConfirm, 3)
    end
end

function ChatFightSelectHeroUI:UpdateItemSelect()
    for k, ui in pairs(self.centerHero) do
        local data = self.fightData.roleData[k]
        local isSel = false
        for _, v in pairs(self.currSelectIndex) do
            if data.index == v then
                isSel = true
                break
            end
        end
        if isSel then
            if data.ownerID ~= '0' then
                isSel = false
            end
        end
        ui.objFx:set_active(isSel)
    end
end

function ChatFightSelectHeroUI:on_btn_confirm(t)
    if self:GetSelectCnt() == 0 or self:GetSelectCnt() ~= self.canSelectCnt then
        return
    end
    msg_1v1.cg_select_choose(self.fightData.roomId, self.currState, self.currSelectIndex, t ~= nil)
end

function ChatFightSelectHeroUI:GetSelectCnt()
    return #self.currSelectIndex
end