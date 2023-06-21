
GuardHeartMainUi = Class("GuardHeartMainUi", UiBaseClass)

local InfoPanelPropPath = 
{
    {"txt_life", "lab_life"},
    {"txt_attack", "lab_attack"},
    {"txt_defense", "lab_defense"},
}

local uiText = 
{
    [1] = "未解锁",
    [2] = "生命",
    [3] = "攻击",
    [4] = "防御",
    [5] = "[F39998FF]放入%s属性角色，%s额外增加[-][07EE0AFF]%d[-]",
    [6] = "[9A9A9AFF]放入%s属性角色，%s额外增加%d[-]",
    [7] = "战队达到%d级",
    [8] = "拥有%d名%s级角色",
    [9] = "战队战力%d",
    [10] = "%d钻石开启",
    [11] = "购买位置",
    [12] = "购买将花费|item:3|%d",
    [13] = "确定",
    [14] = "取消",
    [15] = "守护",
}

local Property2Str = 
{
    [g_guardHeartUsedProperty.max_hp] = uiText[2],
    [g_guardHeartUsedProperty.atk_power] = uiText[3],
    [g_guardHeartUsedProperty.def_power] = uiText[4],
}

local type2spriteName = 
{
    [1] = {"shzx_fang", "防"},
    [2] = {"shzx_gong", "攻"},
    [3] = {"shzx_ji", "技"},
    [4] = {"shzx_nan", "男"},
    [5] = {"shzx_nv", "女"},
}

function GuardHeartMainUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/guard/ui_8101_guard.assetbundle"
    UiBaseClass.Init(self, data);
end

function GuardHeartMainUi:DestroyUi()
    UiBaseClass.DestroyUi(self)

    if self._3dScene then
        self._3dScene:Destroy()
        self._3dScene = nil
    end

    if self.guardPos then
        for k,v in ipairs(self.guardPos) do
            if v.smallCardItem then
                v.smallCardItem:DestroyUi()
            end
        end
        self.guardPos = nil
    end

    if self.playingAudioIds then
        for k,id in pairs(self.playingAudioIds) do
            AudioManager.StopUiAudio(id)
        end

        self.playingAudioIds = nil
    end
end

function GuardHeartMainUi:MsgRegist()
    PublicFunc.msg_regist(GuardHeartMainUi.OnUpdatePosHero, self.bindfunc["OnUpdatePosHero"])
    PublicFunc.msg_regist(player.gc_guard_heart_pos_promotion, self.bindfunc["OnPromotionSuc"])
    PublicFunc.msg_regist(player.gc_guard_heart_place_hero_in_pos, self.bindfunc["OnPlaceSuc"])
    PublicFunc.msg_regist(player.gc_guard_heart_remove_hero, self.bindfunc["OnRemovePos"])
    PublicFunc.msg_regist(player.gc_update_fight_value, self.bindfunc["OnFightValueChange"])
end

function GuardHeartMainUi:MsgUnRegist()
    PublicFunc.msg_unregist(GuardHeartMainUi.OnUpdatePosHero, self.bindfunc["OnUpdatePosHero"])
    PublicFunc.msg_regist(player.gc_guard_heart_pos_promotion, self.bindfunc["OnPromotionSuc"])
    PublicFunc.msg_regist(player.gc_guard_heart_place_hero_in_pos, self.bindfunc["OnPlaceSuc"])
    PublicFunc.msg_regist(player.gc_guard_heart_remove_hero, self.bindfunc["OnRemovePos"])
    PublicFunc.msg_regist(player.gc_update_fight_value, self.bindfunc["OnFightValueChange"])
end

function GuardHeartMainUi:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["OnClickReplaceBtn"]     = Utility.bind_callback(self, self.OnClickReplaceBtn)
    self.bindfunc["OnClickEquipBtn"] = Utility.bind_callback(self, self.OnClickEquipBtn)
    self.bindfunc["OnClickHeroBtn"] = Utility.bind_callback(self, self.OnClickHeroBtn)
    self.bindfunc["OnSelectedRole"]     = Utility.bind_callback(self, self.OnSelectedRole)
    self.bindfunc["OnCloseInfoPanel"] = Utility.bind_callback(self, self.OnCloseInfoPanel)
    self.bindfunc["OnClickPosBtn"] = Utility.bind_callback(self, self.OnClickPosBtn)
    self.bindfunc["OnUpdatePosHero"] = Utility.bind_callback(self, self.OnUpdatePosHero)
    self.bindfunc["OnConfirmBuy"] = Utility.bind_callback(self, self.OnConfirmBuy)
    self.bindfunc["OnPromotionSuc"] = Utility.bind_callback(self, self.OnPromotionSuc)
    self.bindfunc["OnPlaceSuc"] = Utility.bind_callback(self, self.OnPlaceSuc)
    self.bindfunc["OnRemovePos"] = Utility.bind_callback(self, self.OnRemovePos)
    self.bindfunc["OnClickPosHead"] = Utility.bind_callback(self, self.OnClickPosHead)
    self.bindfunc["OnFightValueChange"] = Utility.bind_callback(self, self.OnFightValueChange)
end

function GuardHeartMainUi:OnPlaceSuc(pos)
    --app.log("#hyg#GuardHeartMainUi:OnPlaceSuc " .. pos .. ' ' .. tostring(self.needTransformAnimation))
    if self._3dScene and not self.backupOldPos[pos] then
        self._3dScene:PlayeAnimation(pos, g_guardHeartFlowerAniName.open)
    end

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.InsertTeam);
    local data = g_dataCenter.guardHeart:GetPosData(pos)
    if data then
        local card =  g_dataCenter.package:find_card(ENUM.EPackageType.Hero, data.heroDataID)
        if card then
            local modelCfg = ConfigManager.Get(EConfigIndex.t_model_list, card.model_id)
            if modelCfg and  type(modelCfg.egg_get_audio_id) == "table" then
                local n = math.random(1, #modelCfg.egg_get_audio_id)
                self.playingAudioIds[pos] = AudioManager.PlayUiAudio(modelCfg.egg_get_audio_id[n])
            end
        end
    end
end

function GuardHeartMainUi:OnRemovePos(poss)
    --app.log("#hyg#GuardHeartMainUi:OnPlaceSuc " .. pos .. ' ' .. tostring(self.needTransformAnimation))
    if self._3dScene == nil then return end

    for k,pos in ipairs(poss) do
        if self.backupOldPos[pos] then
            self._3dScene:PlayeAnimation(pos, g_guardHeartFlowerAniName.close)
        end
    end


end

function GuardHeartMainUi:OnFightValueChange()
    local dc = g_dataCenter.guardHeart
    for i = 1, g_guard_heart_max_pos_count do
        if dc:GetPosData(i) == nil then
            --app.log("#hyg#OnFightValueChange " .. i)
            self:SetPosTabContent(i, true)
        end
    end
end

function GuardHeartMainUi:OnPromotionSuc(pos)
    if self._3dScene then
        self._3dScene:PlayeEffect(pos, 19030)
    end
end

function GuardHeartMainUi:OnUpdatePosHero(pos)
    self:SetPosTabContent(pos)
    self:SetTitleBarContent()
end

function GuardHeartMainUi:OnClickReplaceBtn()
    self:ShowPosInfoPanel(false)
    local roleid = nil
    local data = g_dataCenter.guardHeart:GetPosData(self.currentSelectPos)
    if data then
        roleid = data.heroDataID
    end
    uiManager:PushUi(EUI.GuardHeartSelectRoleUi , {OnSelectedRole = self.bindfunc["OnSelectedRole"] , posOldHero = roleid, pos = self.currentSelectPos })
end

function GuardHeartMainUi:OnClickPosBtn(t)
    self:OnDealClickPosBtn(t.float_value)
end

function GuardHeartMainUi:OnClickPosHead(smallcard, card, pos)
    self:OnDealClickPosBtn(pos)
end

function GuardHeartMainUi:OnDealClickPosBtn(pos)

    if self.currentSelectPos ~= pos then
        self.infoPanelIsShow = false
    end

    self.currentSelectPos = pos
    --app.log("#hyg#OnClickPosBtn " .. self.currentSelectPos)

    --self.needTransformAnimation = false
    local dc = g_dataCenter.guardHeart
    self.backupOldPos = {}
    for i = 1, g_guard_heart_max_pos_count do
        if dc:GetPosData(i) then
            self.backupOldPos[i] = true
        end
    end

    local data = dc:GetPosData(self.currentSelectPos)
    if data then
        if self:GetPosCanPromote(self.currentSelectPos) then
            player.cg_guard_heart_pos_promotion(self.currentSelectPos)
        else
            self:ShowPosInfoPanel(not self.infoPanelIsShow, self.currentSelectPos)
        end
    else
        local isUnlock,costNum = self:GetPosIsUnlock(self.currentSelectPos)
        if self:GetPosIsUnlock(self.currentSelectPos) then
            --self.needTransformAnimation = true
            uiManager:PushUi(EUI.GuardHeartSelectRoleUi , {OnSelectedRole = self.bindfunc["OnSelectedRole"], pos = self.currentSelectPos })
        else
            if costNum then
                HintUI.SetAndShowHybrid(EHintUiType.two, uiText[11], string.format(uiText[12], costNum),
                    nil,{str = uiText[13],func = self.bindfunc["OnConfirmBuy"]}, {str = uiText[14]});
            else
                FloatTip.Float(uiText[1])
            end
        end
    end
end

function GuardHeartMainUi:OnConfirmBuy()
    player.cg_guard_heart_buy_pos(self.currentSelectPos)
end

function GuardHeartMainUi:OnClickEquipBtn()
    local selectCard = self:GetSelectHeroCard()
    if selectCard == nil then return end

    uiManager:PushUi(EUI.EquipPackageUI, {cardNumber = selectCard.number})

    self:ShowPosInfoPanel(false)
end

function GuardHeartMainUi:OnClickHeroBtn()
    local selectCard = self:GetSelectHeroCard()
    if selectCard == nil then return end

    uiManager:PushUi(EUI.BattleUI,{cardInfo = selectCard});

    self:ShowPosInfoPanel(false)
end

function GuardHeartMainUi:OnCloseInfoPanel()
    self:ShowPosInfoPanel(false)
end

function GuardHeartMainUi:OnSelectedRole(roleDataid)
    player.cg_guard_heart_place_hero_in_pos(roleDataid, self.currentSelectPos)
end

function GuardHeartMainUi:Init3D()
    local team = g_dataCenter.player:GetDefTeam()
    self._3dScene = UiGuardHeartRole3DScene:new()
end

function GuardHeartMainUi:InitPosData()
    for i = 1, g_guard_heart_max_pos_count do
        local uiInfo = self.guardPos[i]
        local posConfig = ConfigManager.Get(EConfigIndex.t_guard_heart_type, i)
        uiInfo.typeSprite:set_sprite_name(type2spriteName[posConfig.type][1])

        self:SetPosTabContent(i)

    end

    self:SetTitleBarContent()
end

function GuardHeartMainUi:SetTitleBarContent()
    local dc = g_dataCenter.guardHeart
    local totalFightValue = dc:CalPropertyFightValue(dc:GetTotalProperty())
    self.guardHeartFightValue:set_text(tostring(PublicFunc.AttrInteger(totalFightValue)))

    local baseProperty = dc:GetBaseTotalProperty()
    self.propsNode[1].valueLabel:set_text("+" .. PublicFunc.AttrInteger(baseProperty[ENUM.EHeroAttribute.max_hp]))
    self.propsNode[2].valueLabel:set_text("+" .. PublicFunc.AttrInteger(baseProperty[ENUM.EHeroAttribute.atk_power]))
    self.propsNode[3].valueLabel:set_text("+" .. PublicFunc.AttrInteger(baseProperty[ENUM.EHeroAttribute.def_power]))

    for i = 1, 5 do
        local uiNode = self.extraPropsNode[i]
        local posData = dc:GetProperty(i)

        if posData then
            local txt = ''
            local type, value = dc:GetActivePeroperty(posData.extra)
            if type then
                txt = string.format("[f39998]%s[-][66EE33FF]+%d", Property2Str[type], value)
                --uiNode.posNameLabel:set_active(true)
                uiNode.contentLabel:set_active(true)
                uiNode.inactiveLabel:set_active(false)
            else
                --uiNode.posNameLabel:set_active(false)
                uiNode.contentLabel:set_active(false)
                uiNode.inactiveLabel:set_active(true)
            end
            uiNode.contentLabel:set_text(txt)
        else
            --uiNode.posNameLabel:set_active(false)
            uiNode.contentLabel:set_active(false)
            uiNode.inactiveLabel:set_active(true)
        end
    end
end

function GuardHeartMainUi:GetSelectHeroCard()
    if self.currentSelectPos == nil then return end

    local data = g_dataCenter.guardHeart:GetPosData(self.currentSelectPos)
    return g_dataCenter.package:find_card(ENUM.EPackageType.Hero, data.heroDataID)
end

function GuardHeartMainUi:HeroCanImprove(card)
    --app.log("#hyg#HeroCanImprove " .. tostring(card:CanLevelUp()) .. ' ' .. tostring(card:CanStarUp()) .. ' ' .. tostring(card:CanRarityUp()))
    return card:CanLevelUp() == Gt_Enum_Wait_Notice.Success or card:CanStarUp() == Gt_Enum_Wait_Notice.Success or card:CanRarityUp() == Gt_Enum_Wait_Notice.Success
end

function GuardHeartMainUi:EquipCanImprove(card)
    local can = false

    for i = EGuardHeartHeroPropIndex.Equip1, EGuardHeartHeroPropIndex.Equip6 do
        local equipCard = card:GetEquipmentCard(i)
        if equipCard then
            --app.log("#hyg#EquipCanImprove " .. i ..  ' ' .. tostring(equipCard:CanLevelUp()) .. ' ' .. tostring(equipCard:CanStarUp()) .. ' ' .. tostring(equipCard:CanRarityUp()))
            can = equipCard:CanLevelUp() == Gt_Enum_Wait_Notice.Success or equipCard:CanStarUp() == Gt_Enum_Wait_Notice.Success or equipCard:CanRarityUp() == Gt_Enum_Wait_Notice.Success
            if can then
                break
            end
        end
    end

    return can
end

function GuardHeartMainUi:SetPosTabContent(pos, checkLock)
    local dc = g_dataCenter.guardHeart
    local data = dc:GetPosData(pos)
    local uiInfo = self.guardPos[pos]
    uiInfo.sp1:set_color(1, 1, 1, 1)
    uiInfo.natureSp:set_color(1, 1, 1, 1)
    uiInfo.lockSp:set_color(1, 1, 1, 1)
    if data then
        uiInfo.unlockNode:set_active(false)
        uiInfo.emptyNode:set_active(false)
        local canProm = self:GetPosCanPromote(pos)
        if canProm then
            uiInfo.canPromote:set_active(true)
            uiInfo.placedNode:set_active(true)
        else
            uiInfo.canPromote:set_active(false)
            uiInfo.placedNode:set_active(true)
        end

        local heroID = data.heroDataID
        local card =  g_dataCenter.package:find_card(ENUM.EPackageType.Hero, heroID)
        if card == nil then
            app.log("Guard heart hero data id error:" .. tostring(heroID))
            return 
        end
        uiInfo.heroName:set_text(string.format("[CAB4FFFF]%s[-]", PublicFunc.GetNoColorName(card.name)))
        uiInfo.guardFightValue:set_text(tostring(PublicFunc.AttrInteger(dc:CalPropertyFightValue(dc:GetProperty(pos).total))))
        if uiInfo.smallCardItem == nil then
            uiInfo.smallCardItem = SmallCardUi:new({parent = uiInfo.smallCardParent, sgroup = 5})
            uiInfo.smallCardItem:SetCallback(self.bindfunc["OnClickPosHead"])
        end
        uiInfo.smallCardItem:SetData(card)
        uiInfo.smallCardItem:SetParam(pos)

        self._3dScene:SetRoleCard(pos, card)

        if not canProm and (self:HeroCanImprove(card) or self:EquipCanImprove(card)) then
            uiInfo.redPoint:set_active(true)
        else
            uiInfo.redPoint:set_active(false)
        end
    else
        if checkLock ~= true then
            self._3dScene:SetRoleCard(pos, nil)
        end
        uiInfo.canPromote:set_active(false)
        uiInfo.placedNode:set_active(false)
        uiInfo.redPoint:set_active(false)
        if self:GetPosIsUnlock(pos) then
            uiInfo.emptyNode:set_active(true)
            uiInfo.unlockNode:set_active(false)
        else
            uiInfo.emptyNode:set_active(false)
            uiInfo.unlockNode:set_active(true)

            uiInfo.sp1:set_color(0, 0, 0, 1)
            uiInfo.natureSp:set_color(0, 0, 0, 1)
            uiInfo.lockSp:set_color(0, 0, 0, 1)

            for k,v in ipairs(uiInfo.unlockContitionLabel) do
                v:set_active(false)
            end
            local strs = self:GetLockColorString(pos)
            for k,v in ipairs(strs) do
                local lab = uiInfo.unlockContitionLabel[k]
                if lab == nil then break end
                lab:set_active(true)
                lab:set_text(v)
            end
        end
    end
end

function GuardHeartMainUi:GetLockColorString(pos)
    local posConfig = ConfigManager.Get(EConfigIndex.t_guard_heart_type, pos)
    local unLockStrs = {}
    if posConfig then
        local unlockColorStr = "[00FF73FF]%s[-]"
        local lockColorStr = "[FF0000FF]%s[-]"
        local dc = g_dataCenter.guardHeart
        if posConfig.open_level ~= 0 then
            local txt = string.format(uiText[7], posConfig.open_level)
            local colorTxt
            if dc:LevelIsOpen(posConfig, pos) then
                colorTxt = string.format(unlockColorStr, txt)
            else
                colorTxt = string.format(lockColorStr, txt)
            end
            table.insert(unLockStrs, colorTxt)
        end

        if type(posConfig.open_hero_num) == 'table' then
            local aptitude = posConfig.open_hero_num[1]
            local num = posConfig.open_hero_num[2]
            if aptitude and num then
                local txt = string.format(uiText[8], num, PublicFunc.GetAptitudeText(aptitude))
                local colorTxt
                if dc:HeroNumIsOpen(posConfig, pos) then
                    colorTxt = string.format(unlockColorStr, txt)
                else
                    colorTxt = string.format(lockColorStr, txt)
                end

                table.insert(unLockStrs, colorTxt)
            end
        end

        if posConfig.open_fight_vale ~= 0 then
            local txt = string.format(uiText[9], posConfig.open_fight_vale)
            local colorTxt
            if dc:FightValueIsOpen(posConfig, pos) then
                colorTxt = string.format(unlockColorStr, txt)
            else
                colorTxt = string.format(lockColorStr, txt)
            end
            table.insert(unLockStrs, colorTxt)
        end
        
        if posConfig.open_crystal ~= 0 then
            local colorTxt
            local txt = string.format(uiText[10], posConfig.open_crystal)
            if dc:CrystalIsOpen(posConfig ,pos) then
                colorTxt = string.format(unlockColorStr, txt)
            else
                colorTxt = string.format(lockColorStr, txt)
            end
            table.insert(unLockStrs, colorTxt)
        end
    end

    return unLockStrs
end

function GuardHeartMainUi:GetPosIsUnlock(pos)
    return g_dataCenter.guardHeart:PosIsUnlock(pos)
end

function GuardHeartMainUi:GetPosCanPromote(pos)

    return g_dataCenter.guardHeart:CanPromotion(pos)

end

function GuardHeartMainUi:UpdateUi()
    if not self.ui then return end

    for i = 1, g_guard_heart_max_pos_count do
        self:SetPosTabContent(i)
    end

    self:SetTitleBarContent()
end

function GuardHeartMainUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("guard_heart_main_ui")

    self.guardHeartFightValue = ngui.find_label(self.ui, "sp_title1/sp_fight/lab_fight")
    self.propsNode = {}
    for i = 1, 3 do
        local node = {}
        node.node = self.ui:get_child_by_name("sp_point" .. i)
        node.nameLabel = ngui.find_label(node.node, "lab_nature")
        node.valueLabel = ngui.find_label(node.node, "lab_num")

        self.propsNode[i] = node
    end
    self.extraPropsNode = {}
    for i = 1, 5 do
        local node = {}
        node.node = self.ui:get_child_by_name("sp_guard_di" .. i)
        node.posNameLabel = ngui.find_label(node.node, "txt")
        node.contentLabel = ngui.find_label(node.node, "lab")
        node.inactiveLabel = ngui.find_label(node.node, "lab_inactive")
        self.extraPropsNode[i] = node

        node.posNameLabel:set_text(uiText[15] .. i)
    end
    self.centerNode = self.ui:get_child_by_name("centre_other")

    self.posInfoNode = self.ui:get_child_by_name("down_other/sp_bk")
    self.posFightValueLabel = ngui.find_label(self.posInfoNode, "lab_fight")
    self.posInfoPanelpropsNode = {}
    for i = 1, 3 do
        local nodeInfo = {}
        nodeInfo.nameLabel = ngui.find_label(self.posInfoNode, InfoPanelPropPath[i][1])
        nodeInfo.valueLabel = ngui.find_label(self.posInfoNode, InfoPanelPropPath[i][2])
        self.posInfoPanelpropsNode[i] = nodeInfo
    end
    self.extraPropLabel = ngui.find_label(self.posInfoNode, "txt_describe")
    self.infoPanelCloseBtn = ngui.find_button(self.posInfoNode, "btn_cha")
    self.replaceBtn = ngui.find_button(self.posInfoNode, "btn_tihuan")
    self.equipBtn = ngui.find_button(self.posInfoNode, "btn_equip")
    self.heroBtn = ngui.find_button(self.posInfoNode, "btn_qianghua")
    self.equipBtnRedPoint = ngui.find_sprite(self.posInfoNode, "btn_equip/sp_point")
    self.heroBtnRedPoint = ngui.find_sprite(self.posInfoNode, "btn_qianghua/sp_point")
    self.guardPos = {}
    for i = 1, 5 do
        local uiInfo = {}
        local posRootNode = self.ui:get_child_by_name("yeka_grid/cont_di" .. i)
        local parentNodeName = "cont_di" .. i;
        local btn = ngui.find_button(posRootNode, parentNodeName)
        btn:set_on_click(self.bindfunc["OnClickPosBtn"])
        btn:set_event_value("", i)
        uiInfo.root = posRootNode
        uiInfo.sp1 = ngui.find_sprite(posRootNode, "sp_di")
        uiInfo.sp1Obj = posRootNode
        uiInfo.smallMarkSp = ngui.find_sprite(posRootNode, "sp_black_mark")
        uiInfo.smallMarkSp:set_active(false)
        uiInfo.natureSp = ngui.find_sprite(uiInfo.sp1Obj, "sp_nature")
        uiInfo.canPromote = ngui.find_sprite(posRootNode, "sp_mark")
        uiInfo.unlockNode = posRootNode:get_child_by_name("cont3")
        uiInfo.lockSp = ngui.find_sprite(uiInfo.unlockNode, "sp_clock")
        uiInfo.unlockContitionLabel = {}
        for i = 1, 2 do
            local lab = ngui.find_label(uiInfo.unlockNode, "lab" .. i)
            lab:set_color(1, 1, 1, 1)
            table.insert(uiInfo.unlockContitionLabel, lab)
        end
        uiInfo.emptyNode = posRootNode:get_child_by_name("cont2")
        uiInfo.placedNode = posRootNode:get_child_by_name("cont1")
        uiInfo.heroName = ngui.find_label(posRootNode, "lab_name")
        uiInfo.guardFightValue = ngui.find_label(posRootNode, "lab_fight")
        uiInfo.smallCardParent = posRootNode:get_child_by_name("big_card_item_80")
        uiInfo.smallCardItem = nil
        uiInfo.typeSprite = ngui.find_sprite(posRootNode, "sp_nature")
        uiInfo.redPoint = ngui.find_sprite(posRootNode, "sp_point")
        self.guardPos[i] = uiInfo
    end

    self.centerNode:set_active(false)
    self.posInfoNode:set_active(false)
    self.infoPanelCloseBtn:set_on_click(self.bindfunc["OnCloseInfoPanel"])
    self.replaceBtn:set_on_click(self.bindfunc["OnClickReplaceBtn"])
    self.equipBtn:set_on_click(self.bindfunc["OnClickEquipBtn"])
    self.heroBtn:set_on_click(self.bindfunc["OnClickHeroBtn"])

    self.infoPanelIsShow = false
    self.playingAudioIds = {}
    self:Init3D()
    self:InitPosData()
end

function GuardHeartMainUi:ShowPosInfoPanel(show, pos)

    -- TODO update ancher
    self.infoPanelIsShow = show
    
    if not show then

        for i = 1, 5 do
            local uiInfo = self.guardPos[i]
            uiInfo.sp1Obj:set_local_scale(1, 1, 1)
            uiInfo.smallMarkSp:set_active(false)
        end

        self.posInfoNode:set_active(false)
        return
    end

    for i = 1, 5 do
        local uiInfo = self.guardPos[i]
        if i == pos then
            uiInfo.sp1Obj:set_local_scale(1.05, 1.05, 1.05)
            uiInfo.smallMarkSp:set_active(false)
        else
            uiInfo.sp1Obj:set_local_scale(0.95, 0.95, 0.95)
            uiInfo.smallMarkSp:set_active(true)
        end
    end

    local uiInfo = self.guardPos[pos]
    self.posInfoNode:set_active(true)
    local x, y, z = uiInfo.root:get_position()
    if pos == 1 then
        x = x + 0.096
    elseif pos == 5 then
        x = x - 0.096
    end
    local mx, my, mz = self.posInfoNode:get_position()
    self.posInfoNode:set_position(x, my, mz)

    local dc = g_dataCenter.guardHeart
    local data = dc:GetPosData(pos)
    local prop = dc:GetProperty(pos)
    self.posFightValueLabel:set_text(tostring(PublicFunc.AttrInteger(dc:CalPropertyFightValue(prop.total))))
    local baseProperty = prop.base
    self.posInfoPanelpropsNode[1].valueLabel:set_text("+" .. PublicFunc.AttrInteger(baseProperty[ENUM.EHeroAttribute.max_hp]))
    self.posInfoPanelpropsNode[2].valueLabel:set_text("+" .. PublicFunc.AttrInteger(baseProperty[ENUM.EHeroAttribute.atk_power]))
    self.posInfoPanelpropsNode[3].valueLabel:set_text("+" .. PublicFunc.AttrInteger(baseProperty[ENUM.EHeroAttribute.def_power]))

    local posConfig = ConfigManager.Get(EConfigIndex.t_guard_heart_type, pos)
    local type, value = dc:GetActivePeroperty(prop.extra)
    local posPropStr = type2spriteName[posConfig.type][2]
    if type then
        local txt = string.format(uiText[5], posPropStr, Property2Str[type], value)
        self.extraPropLabel:set_text(txt)
    else
        type, value = dc:GetPosExtraProperty(pos)
        local txt = string.format(uiText[6], posPropStr, Property2Str[type], value)
        self.extraPropLabel:set_text(txt)
    end

    local heroID = data.heroDataID
    local card =  g_dataCenter.package:find_card(ENUM.EPackageType.Hero, heroID)
    if card and self:HeroCanImprove(card) then
        self.heroBtnRedPoint:set_active(true)
    else
        self.heroBtnRedPoint:set_active(false)
    end

    if card and self:EquipCanImprove(card) then
        self.equipBtnRedPoint:set_active(true)
    else
        self.equipBtnRedPoint:set_active(false)
    end
end