
UiEquipExpertResult = Class("UiEquipExpertResult", MultiResUiBaseClass);


function UiEquipExpertResult.Start(ownerCard)
    local _canLevel, _type = UiEquipExpertResult.CanLevel(ownerCard)
    if not _canLevel then
        return
    end
    if UiEquipExpertResult.cls == nil then
        UiEquipExpertResult.cls = UiEquipExpertResult:new({ownerCard = ownerCard, type = _type})
    end
end

function UiEquipExpertResult.End()
    if UiEquipExpertResult.cls then
        UiEquipExpertResult.cls:DestroyUi()
        UiEquipExpertResult.cls = nil
    end

    UiEquipExpertResult.oldType = nil
    UiEquipExpertResult.oldLevel = nil
end

function UiEquipExpertResult.CanLevel(roleData)
    if UiEquipExpertResult.oldType == nil or UiEquipExpertResult.oldLevel == nil then
        return false
    end

    local currLevel = PublicFunc.GetEquipExpertLevel(UiEquipExpertResult.oldType, roleData)
    if currLevel ~= UiEquipExpertResult.oldLevel then
        return true, UiEquipExpertResult.oldType
    end
    return false
end

function UiEquipExpertResult.SaveOldLevel(type, roleData)
    UiEquipExpertResult.oldType = type
    UiEquipExpertResult.oldLevel  = PublicFunc.GetEquipExpertLevel(type, roleData)
end

local _UIText = {
    [1] = "装备升品",
    [2] = "装备进化",
    [3] = "专属升品",
    [4] = "专属进化",

    [5] = "等级提升至    级",
}

local resType =
{
    Front = 1,
    Back = 2,
}

local resPaths =
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_834_fight.assetbundle',
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle',
}

local _typeName = {
    [ENUM.EquipExpertType.Level] = _UIText[1],
    [ENUM.EquipExpertType.Star] = _UIText[2],
    [ENUM.EquipExpertType.SpecLevel] = _UIText[3],
    [ENUM.EquipExpertType.SpecStar] = _UIText[4],
}

function UiEquipExpertResult:Init(data)
    self.pathRes = resPaths
    self.ownerCard = data.ownerCard
    self.currType = data.type

    MultiResUiBaseClass.Init(self, data);
end

function UiEquipExpertResult:RestartData()
    CommonClearing.canClose = false

    MultiResUiBaseClass.RestartData(self)
end

function UiEquipExpertResult:DestroyUi()
    MultiResUiBaseClass.DestroyUi(self)
end

function UiEquipExpertResult:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self)
    self.bindfunc['on_click_mark'] = Utility.bind_callback(self, self.on_click_mark)
end

function UiEquipExpertResult:on_click_mark()
    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    UiEquipExpertResult.End()
end

function UiEquipExpertResult:InitedAllUI()
    local backui = self.uis[resPaths[resType.Back]]

    local titleSprite = ngui.find_sprite(backui, 'sp_art_font')
    titleSprite:set_sprite_name("js_zhuangbeidaren")

    local frontParentNode = backui:get_child_by_name("add_content")
    local frontui = self.uis[resPaths[resType.Front]]
    frontui:set_parent(frontParentNode)

    local btn = ngui.find_button(backui, 'mark')
    btn:set_on_click(self.bindfunc['on_click_mark'],"MyButton.NoneAudio")


    --------------------------------------------------------------------------

    local lblDescribe = ngui.find_label(frontui, 'sp_line/lab_describe')
    local lblLvl = ngui.find_label(frontui, 'sp_line/lab_num')
    local desc = _typeName[self.currType] .. _UIText[5]
    lblDescribe:set_text(desc)
    local currLevel = PublicFunc.GetEquipExpertLevel(self.currType, self.ownerCard)
    lblLvl:set_text(tostring(currLevel))

    local oldLevel = currLevel - 1
    if oldLevel < 0 then
        app.log('level error!!')
        return
    end

    self.upPropertyUi = {}
    for i = 1, 3 do
        local temp = {}
        temp.obj = frontui:get_child_by_name("grid_nature/lab_nature" .. i)
        temp.lblName = ngui.find_label(temp.obj, temp.obj:get_name())
        temp.lblNum1 = ngui.find_label(temp.obj, "lab_num")
        temp.lblNum2 = ngui.find_label(temp.obj, "lab")
        self.upPropertyUi[i] = temp
    end
    local grid = ngui.find_grid(frontui, "grid_nature")
    local oldProp = PublicFunc.GetEquipExpertProps(self.ownerCard.default_rarity, oldLevel, self.currType)
    local currProp = PublicFunc.GetEquipExpertProps(self.ownerCard.default_rarity, currLevel, self.currType)

    for k, v in pairs(self.upPropertyUi) do
        local pp = currProp[k]
        if pp then
            v.obj:set_active(true)
            v.lblName:set_text(PublicFunc.GetHeroPropertyName(pp.key))
            --等级0
            if #oldProp == 0 then
                v.lblNum1:set_text("0")
            else
                v.lblNum1:set_text(tostring(oldProp[k].value))
            end
            v.lblNum2:set_text(tostring(pp.value))
        else
            v.obj:set_active(false)
        end
    end
    grid:reposition_now()

    --------------------------------------------------------------------------

    local oldFightValueLabel = ngui.find_label(frontui, 'sp_fight/lab_fight')
    local newFightValueLabel = ngui.find_label(frontui, 'sp_fight/lab_num')
    oldFightValueLabel:set_text(tostring(self.ownerCard:GetOldFightValue()))
    newFightValueLabel:set_text(tostring(self.ownerCard:GetFightValue()))

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
end

function UiEquipExpertResult:GetOldCardInfo(cardInfo)
    return cardInfo:CloneWithNewNumberLevelRairty(nil, nil, cardInfo.oldRarity)
end