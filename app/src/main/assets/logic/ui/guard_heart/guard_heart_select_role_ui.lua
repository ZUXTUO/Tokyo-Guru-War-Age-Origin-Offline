GuardHeartSelectRoleUi = Class("GuardHeartSelectRoleUi", UiBaseClass)

local uiText = 
{
    [1] = "%s队长不能为空",
}

function GuardHeartSelectRoleUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/guard/ui_8102_guard.assetbundle"
    UiBaseClass.Init(self, data);
end

function GuardHeartSelectRoleUi:DestroyUi()
    UiBaseClass.DestroyUi(self)

    if self.wrapContentItemsUi then
        for k,v in pairs(self.wrapContentItemsUi) do
            for i,roleNode in ipairs(v.roleNode) do
                roleNode.smallItemUi:DestroyUi()
            end
        end
        self.wrapContentItemsUi = nil
    end
end

function GuardHeartSelectRoleUi:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["OnClickClose"]     = Utility.bind_callback(self, self.OnClickClose);
    self.bindfunc["OnInitItem"]     = Utility.bind_callback(self, self.OnInitItem);
    self.bindfunc["OnClickReplaceBtn"] = Utility.bind_callback(self, self.OnClickReplaceBtn);
end

function GuardHeartSelectRoleUi:OnClickClose()
    uiManager:PopUi()
end

function GuardHeartSelectRoleUi:OnClickReplaceBtn(t)
    local roleDataId = t.string_value
    --app.log("OnClickReplaceBtn " .. tostring(roleDataId))

    if self.captainHeros and self.captainHeros[roleDataId] then
        FloatTip.Float(string.format(uiText[1], PublicFunc.TeamIDToName(self.captainHeros[roleDataId])))
        return
    end

    local initData = self:GetInitData()
    Utility.call_func(initData.OnSelectedRole, roleDataId)

    self:OnClickClose()
end

function GuardHeartSelectRoleUi:GetItemUiNodes(obj, name)
    local nodes = self.wrapContentItemsUi[name]
    
    if nodes == nil then
        nodes = {}
        nodes.roleNode = {}
        for i = 1,2 do

            local roleUis = {}

            roleUis.node = obj:get_child_by_name("sp_di" .. i)
            roleUis.smallCardParent = roleUis.node:get_child_by_name("big_card_item_80")
            roleUis.smallItemUi = SmallCardUi:new({parent = roleUis.smallCardParent, sgroup = 5})
            roleUis.nameLabel = ngui.find_label(roleUis.node, "lab_name")
            roleUis.fightValueLabel = ngui.find_label(roleUis.node, "lab_fight")
            roleUis.btn = ngui.find_button(roleUis.node, "btn_replace")
            roleUis.btn:set_on_click(self.bindfunc["OnClickReplaceBtn"])
            roleUis.btnSP = ngui.find_sprite(roleUis.node, "btn_replace/sp")
            roleUis.btnTxt = ngui.find_label(roleUis.node, "btn_replace/lab")
            roleUis.jiaobiaoSp = ngui.find_sprite(roleUis.node, "sp_tuijian")

            nodes.roleNode[i] = roleUis
        end
        self.wrapContentItemsUi[name] = nodes
    end

    return nodes
end

function GuardHeartSelectRoleUi:OnInitItem(obj,b,real_id)
    --app.log("#hyg#OnInitItem " .. tostring(real_id))
    local baseIndex = math.abs(real_id)

    local name = obj:get_name()
    local uiNodes = self:GetItemUiNodes(obj, name)
    for i = 1, 2 do
        local uis = uiNodes.roleNode[i]
        local roleCard = self.heroList[baseIndex * 2 + i]
        --app.log("#hyg#OnInitItem index = " .. baseIndex * 2 + i)
        if roleCard == nil then
            if i == 1 then
                app.log("wrap content index too much!")
            else
                uis.node:set_active(false)
            end
        else
            uis.node:set_active(true)

            uis.smallItemUi:SetData(roleCard)
            uis.nameLabel:set_text(roleCard.name)
            uis.fightValueLabel:set_text(tostring(roleCard:GetFightValue()))
            uis.btn:set_event_value(roleCard.index, 0)

            if self.captainHeros and self.captainHeros[roleCard.index] then
                -- gray btn
                uis.btnSP:set_color(0, 0, 0, 1)
                uis.btnTxt:set_effect_color(95/255, 95/255, 95/255, 1)
            else
                uis.btnSP:set_color(1, 1, 1, 1)
                uis.btnTxt:set_effect_color(140/255, 66/255, 19/255, 1)
            end

            if g_dataCenter.guardHeart:PosHeroTypeIsSame(roleCard, self.initData.pos) then
                uis.jiaobiaoSp:set_active(true)
            else
                uis.jiaobiaoSp:set_active(false)
            end

            if g_dataCenter.guardHeart:IsGuardHeartHero(roleCard.index) then
                uis.smallItemUi:SetGuardHeart(true)
            else
                uis.smallItemUi:SetGuardHeart(false)
            end
        end
    end
end

function GuardHeartSelectRoleUi:NeedExceptHero(dataid)
    local defTeam = g_dataCenter.player:GetDefTeam()
    
    for k,v in pairs(defTeam) do
        if v == dataid then
            return true
        end
    end

    if self.initData.posOldHero == dataid then
        return true
    end

    return false
end

function GuardHeartSelectRoleUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("guard_heart_select_role_ui")

    self.closeBtn = ngui.find_button(self.ui, "btn_cha")
    self.heroListWrapContent = ngui.find_wrap_content(self.ui, "wrap_content")
    self.noHeroNode = self.ui:get_child_by_name("cont")

    self.closeBtn:set_on_click(self.bindfunc["OnClickClose"])

    self.wrapContentItemsUi = {}

    self.initData = self:GetInitData()

    local dc = g_dataCenter.guardHeart
    local posOldHero = self.initData.posOldHero
    if not posOldHero then
        self.captainHeros = dc:GetMutexTeamCaptain()
    else
        self.captainHeros = {}
    end

    self.heroList = {}
    local cards = g_dataCenter.package:GetCard(ENUM.EPackageType.Hero)

    for k,v in pairs(cards) do
        if not self:NeedExceptHero(v.index) then
            table.insert(self.heroList, v)
        end
    end

    table.sort(self.heroList, function(a, b)

        local muta = self.captainHeros[a.index]
        local mutb = self.captainHeros[b.index]

        if muta and mutb then
            return a:GetFightValue() > b:GetFightValue()
        end

        if not muta and not mutb then
            local posa = dc:GetHeroGuardPos(a.index)
            local posb = dc:GetHeroGuardPos(b.index)

            if posa and posb then
                return posa < posb
            elseif not posa and not posb then
                return a:GetFightValue() > b:GetFightValue()
            elseif posa then
                return true
            end

            return false
        end

        if not muta then
            return true
        end

        return false
    end
    )

    --[[
    local mutexCards = {}
    if posOldHero then
        for k,v in pairs(cards) do
            if posOldHero ~= v.index then
                if self.captainHeros[v.index] then
                    table.insert(mutexCards, v)
                else
                    table.insert(self.heroList, v)
                end
            end
        end
    else
        for k,v in pairs(cards) do
            if self.captainHeros[v.index] then
                table.insert(mutexCards, v)
            else
                table.insert(self.heroList, v)
            end
        end
    end

    table.sort(self.heroList, function(a, b)
        local posa = dc:GetHeroGuardPos(a.index)
        local posb = dc:GetHeroGuardPos(b.index)

        if posa and posb then
            return posa < posb
        elseif not posa and not posb then
            return a:GetFightValue() > b:GetFightValue()
        elseif posa then
            return true
        end

        return false
    end
    )

    for k,v in ipairs(mutexCards) do
        table.insert(self.heroList, v)
    end
    ]]


    --app.log("#hyg# hero list count " .. #self.heroList)

    if #self.heroList > 0 then

        self.heroListWrapContent:set_active(true)
        if self.noHeroNode then self.noHeroNode:set_active(false) end

        self.heroListWrapContent:set_on_initialize_item(self.bindfunc["OnInitItem"])
        self.heroListWrapContent:set_min_index(-math.ceil(#self.heroList/2) + 1)
        self.heroListWrapContent:set_max_index(0)
        self.heroListWrapContent:reset()

    else
        self.heroListWrapContent:set_active(false)
        if self.noHeroNode then self.noHeroNode:set_active(true) end
    end
end