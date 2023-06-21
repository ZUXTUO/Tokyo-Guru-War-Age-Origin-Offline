
ChatFightResultUI = Class("ChatFightResultUI", UiBaseClass)


function ChatFightResultUI.Start()
    if ChatFightResultUI.cls == nil then
        ChatFightResultUI.cls = ChatFightResultUI:new()
    end
end

function ChatFightResultUI.End()
    if ChatFightResultUI.cls then
        ChatFightResultUI.cls:DestroyUi()
        ChatFightResultUI.cls = nil
    end
end


local _UIText = {
    [1] = "第一战",
    [2] = "第二战",
    [3] = "第三战",
}

function ChatFightResultUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/chat_fight/ui_5405_yuezhan.assetbundle"
    UiBaseClass.Init(self, data)
end

function ChatFightResultUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightResultUI:Restart(data)
    self.resultListUI = {}
    self.roleList = g_dataCenter.chatFight:GetFightRoleList()
    self.fightData = g_dataCenter.chatFight:GetStartFightData()
    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightResultUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
end

function ChatFightResultUI:DestroyUi()
    for k,v in pairs(self.playerInfo) do
        if v.uiPlayer then
            v.uiPlayer:DestroyUi()
            v.uiPlayer = nil
        end
    end

    for _, v in pairs(self.resultListUI) do
        if v.heroInfo then
            for _, info in pairs(v.heroInfo) do
                if info.textBuff then
                    info.textBuff:Destroy()
                    info.textBuff = nil
                end
                if info.smallCard then
                    info.smallCard:DestroyUi()
                    info.smallCard = nil
                end
            end
        end
    end
    UiBaseClass.DestroyUi(self)
end

function ChatFightResultUI:on_close()
    ChatFightResultUI.End()
    FightScene.ExitFightScene()
end

function ChatFightResultUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "center_other/animation/"

    local btnClose = ngui.find_button(self.ui, "sp_mark")
    btnClose:set_on_click(self.bindfunc["on_close"])

    self.playerInfo = {}
    for i = 1,2 do
        local tPath = path .. "sp_title" .. i .. "/"
        local objHead = self.ui:get_child_by_name(tPath .. "sp_head_di_item")
        self.playerInfo[i] = {
            lblName= ngui.find_label(self.ui, tPath .. "lab"),
            uiPlayer = UiPlayerHead:new({parent = objHead}),
            spResult = ngui.find_sprite(self.ui, tPath .. "sp_win")
        }
    end


    self.grid = ngui.find_grid(self.ui, path .. "grid")
    local objGrid = self.grid:get_game_object()
    local cloneObj = self.ui:get_child_by_name(path .. "grid/list1")
    cloneObj:set_active(false)

    for i = 1, 3 do
        local temp = {}
        temp.obj = cloneObj:clone()
        temp.obj:set_parent(objGrid)
        temp.obj:set_name("list_" .. i)
        temp.obj:set_active(true)

        temp.heroInfo = {}
        for j = 1, 2 do
            local diPath = "sp_di" .. j
            local _obj = temp.obj:get_child_by_name(diPath .. "/big_card_item_80")
            temp.heroInfo[j] = {
                spBg = ngui.find_sprite(temp.obj, diPath),
                spLine = ngui.find_sprite(temp.obj, diPath .. "/sp_line"),

                spWin = ngui.find_sprite(temp.obj, diPath .. "/sp_win"),
                textBuff = ngui.find_texture(temp.obj, diPath .. "/texture_buff"),
                smallCard = SmallCardUi:new({parent = _obj,
                    stypes = { SmallCardUi.SType.Texture, SmallCardUi.SType.Rarity }
                });
            }
        end

        temp.lblFight = ngui.find_label(temp.obj, "lab_fight")
        self.resultListUI[i] = temp
    end

    self:UpdateUI()

end

function ChatFightResultUI:UpdateUI()
    local result1, result2 = g_dataCenter.chatFight:GetFinalFightResult()
    local ret = {result1, result2}
    for i = 1, 2 do
        local ui = self.playerInfo[i]
        local data = self.fightData.playerData[i]
        ui.lblName:set_text(data.playerName)
        ui.uiPlayer:SetRoleId(data.playerImage)
        self:SetResultSprite(ui.spResult, ret[i])
    end

    for i = 1, 3 do
        local item = self.resultListUI[i]
        item.lblFight:set_text(_UIText[i])
        for j = 1, 2 do
            local data = self.roleList[j][i]
            local ui = item.heroInfo[j]
            self:SetResultSprite(ui.spWin, data.result)

            if data.buffId then
                ui.textBuff:set_active(true)
                local cfg = ConfigManager.Get(EConfigIndex.t_chat_1v1_buff, data.buffId)
                ui.textBuff:set_texture(cfg.icon)
            else
                ui.textBuff:set_active(false)
            end

            if data.result ~= ENUM.ChatFightResult.Fail then
                PublicFunc.SetUISpriteWhite(ui.spBg)
                PublicFunc.SetUISpriteWhite(ui.spLine)
                PublicFunc.SetUISpriteWhite(ui.spWin)
                PublicFunc.SetUISpriteWhite(ui.textBuff)
            else
                PublicFunc.SetUISpriteGray(ui.spBg)
                PublicFunc.SetUISpriteGray(ui.spLine)
                PublicFunc.SetUISpriteGray(ui.spWin)
                PublicFunc.SetUISpriteGray(ui.textBuff)
            end

            local cardInfo = CardHuman:new({number = data.number, isNotCalProperty = true})
            cardInfo.realRarity = ENUM.EHeroRarity.Orange
            ui.smallCard:SetData(cardInfo)
            ui.smallCard:SetGray(data.result == ENUM.ChatFightResult.Fail)
        end
    end
end

function ChatFightResultUI:SetResultSprite(sp, result)
    if result == ENUM.ChatFightResult.Success then
        sp:set_sprite_name("zb_win")
    elseif result == ENUM.ChatFightResult.Fail then
        sp:set_sprite_name("zb_lose")
    else
        sp:set_sprite_name("zb_pingju")
    end
end
