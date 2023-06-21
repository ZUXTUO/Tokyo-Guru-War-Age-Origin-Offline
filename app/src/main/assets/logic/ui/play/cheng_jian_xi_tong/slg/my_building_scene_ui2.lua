
MyBuildingSceneUI2 = Class('MyBuildingSceneUI2', UiBaseClass)

SLGiconsPath = 
{
    [CityBuildingID.diningRoomID] = 'assetbundles/prefabs/ui/image/icon/equip_item/80_80/jinbi.assetbundle',
    [CityBuildingID.teachingBuildID] = 'assetbundles/prefabs/ui/image/icon/equip_item/80_80/kafei.assetbundle',
    [CityBuildingID.libraryID] = 'assetbundles/prefabs/ui/image/icon/equip_item/80_80/yingxiongjingyan.assetbundle',
}

SLGFightScoreIcon = 'assetbundles/prefabs/ui/image/icon/equip_item/80_80/jifen.assetbundle'

local harvestAnimation = 
{
    [CityBuildingID.libraryID] = {'ui_2303_slg1', 'ui_2303_slg1_1'};
    [CityBuildingID.teachingBuildID] = {'ui_2303_slg1', 'ui_2303_slg1_1'};
    [CityBuildingID.diningRoomID] = {'ui_2303_slg1', 'ui_2303_slg1_1'};
}

ItemSceneNodeName = 
{
    [CityBuildingID.diningRoomID] = '034_slg_item/F_kafeidian_wujian034',
    [CityBuildingID.teachingBuildID] = '034_slg_item/F_kafeidian_wujian032',
    [CityBuildingID.libraryID] = '034_slg_item/F_kafeidian_wujian038',
}

SLGBuildingModeID = 
{
--@@^^$$     [CityBuildingID.diningRoomID] = gd_building[CityBuildingID.diningRoomID].model_id,
    [CityBuildingID.diningRoomID] = ConfigManager.Get(EConfigIndex.t_building,CityBuildingID.diningRoomID).model_id,
--@@^^$$     [CityBuildingID.teachingBuildID] = gd_building[CityBuildingID.teachingBuildID].model_id,
    [CityBuildingID.teachingBuildID] = ConfigManager.Get(EConfigIndex.t_building,CityBuildingID.teachingBuildID).model_id,
--@@^^$$     [CityBuildingID.libraryID] = gd_building[CityBuildingID.libraryID].model_id,
    [CityBuildingID.libraryID] = ConfigManager.Get(EConfigIndex.t_building,CityBuildingID.libraryID).model_id,
}

MATCH_ROBBERY_COST_GOLD = 'x200'


function MyBuildingSceneUI2:Init(data)

    self.pathRes = "assetbundles/prefabs/ui/wanfa/slg/ui_2303_slg_university.assetbundle"
    UiBaseClass.Init(self, data);
end

function MyBuildingSceneUI2:Restart(data)

    self:InitData()
    UiBaseClass.Restart(self, data)
end


function MyBuildingSceneUI2:InitData(data)
    UiBaseClass.InitData(self, data)

    self.itemsNode = {}
    self.showNameAndLevelNodes = {}
    self.showBuildingLevelStr = {}
    self.hasShowBuildingLevel = {}
    self.showHarvestIconNodes = {}
    self.harvestAnimationNodes = {}
    self.showHarvestIconNodeTexs = {}
    self.harvestShowNumLabel = {}
    self.harvestFxNodes = {}

    self.showUpgradeTimeNodes = {}

--@@^^$$     self.showBuildingLevelStr[CityBuildingID.libraryID] = gd_building[CityBuildingID.libraryID].name
    self.showBuildingLevelStr[CityBuildingID.libraryID] = ConfigManager.Get(EConfigIndex.t_building,CityBuildingID.libraryID).name
--@@^^$$     self.showBuildingLevelStr[CityBuildingID.teachingBuildID] = gd_building[CityBuildingID.teachingBuildID].name
    self.showBuildingLevelStr[CityBuildingID.teachingBuildID] = ConfigManager.Get(EConfigIndex.t_building,CityBuildingID.teachingBuildID).name
--@@^^$$     self.showBuildingLevelStr[CityBuildingID.diningRoomID] = gd_building[CityBuildingID.diningRoomID].name
    self.showBuildingLevelStr[CityBuildingID.diningRoomID] = ConfigManager.Get(EConfigIndex.t_building,CityBuildingID.diningRoomID).name

    self.hasInitUIContent = nil

    self.isHarvestings = {}
    self.isShowBeAttacked = false

end

function MyBuildingSceneUI2:RegistFunc()

    UiBaseClass.RegistFunc(self);

    self.bindfunc["OnClickRuleBtn"]	   = Utility.bind_callback(self, MyBuildingSceneUI2.OnClickRuleBtn)
    self.bindfunc["OnEnterRanking"]	   = Utility.bind_callback(self, MyBuildingSceneUI2.OnEnterRanking);
    self.bindfunc["OnEnterFightReport"]	   = Utility.bind_callback(self, MyBuildingSceneUI2.OnEnterFightReport);
    self.bindfunc["OnClickHarvestIcon"] = Utility.bind_callback(self, MyBuildingSceneUI2.OnClickHarvestIcon);
    self.bindfunc['OnHarvestSucced'] = Utility.bind_callback(self, MyBuildingSceneUI2.OnHarvestSucced)
    self.bindfunc["OnUpdateResourceAndScore"] = Utility.bind_callback(self, MyBuildingSceneUI2.OnUpdateResourceAndScore);
    self.bindfunc["on_click_scene"] = Utility.bind_callback(self, MyBuildingSceneUI2.on_click_scene);
    self.bindfunc["OnClickRobbery"] = Utility.bind_callback(self, MyBuildingSceneUI2.OnClickRobbery);
end

function MyBuildingSceneUI2:OnClickRuleBtn()
    UiRuleDes.Start(ENUM.ERuleDesType.XiaoYuanJianShe)
end

function MyBuildingSceneUI2:OnEnterRanking()

    if not CityBuildingMgr.GetInst():HasRequestBuildingInfo() then
        return
    end

    uiManager:PushUi(EUI.SLGRanking)
end

function MyBuildingSceneUI2:OnEnterFightReport()

    if not CityBuildingMgr.GetInst():HasRequestBuildingInfo() then
        return
    end

    uiManager:PushUi(EUI.BuildingRobberyFightReport)
end

function MyBuildingSceneUI2:OnClickRobbery()
    if CityRobberyMgr.GetInst():GetTargetPlayer() ~= nil then
        uiManager:PushUi(EUI.TargetBuildingSceneUI2)
    else
        uiManager:PushUi(EUI.SearchingRobberyTargetUI)
    end
end

function MyBuildingSceneUI2:InitUI(asset_obj)
    self.ui = asset_game_object.create(asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d())
    self.ui:set_name('ui_2303_slg_university')
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);

    local cbMgr = CityBuildingMgr.GetInst()
    cbMgr:SetUpdateResourceCallback(self.bindfunc["OnUpdateResourceAndScore"])

    self.canHarvestIconNode = self.ui:get_child_by_name('cont1')
    self.canHarvestIconNode:set_active(false)
    self.showNameAndLevelNode = self.ui:get_child_by_name('cont2')
    self.showNameAndLevelNode:set_active(false)
    self.showUpgradeArrawNode = self.ui:get_child_by_name('cont3')
    self.showUpgradeArrawNode:set_active(false)
    self.showUpgradeLabelNode = self.ui:get_child_by_name('content/sp_di')
    self.showUpgradeLabelNode:set_active(false)

    self.showBeAttackSp = ngui.find_sprite(self.ui, 'top_left_other/sp_di')
    self.showBeAttackSp:set_active(false)

--    local btn = ngui.find_button(self.ui, 'btn_rule')
--    btn:set_on_click(self.bindfunc["OnClickRuleBtn"])

    btn = ngui.find_button(self.ui, 'btn_ranklist')
    btn:set_on_click(self.bindfunc["OnEnterRanking"])

    btn = ngui.find_button(self.ui, 'btn_zhanbao')
    btn:set_on_click(self.bindfunc["OnEnterFightReport"])

    btn = ngui.find_button(self.ui, 'mark')
    btn:set_on_ngui_click(self.bindfunc["on_click_scene"])

    btn = ngui.find_button(self.ui, 'button')
    btn:set_on_ngui_click(self.bindfunc["OnClickRobbery"])

    local robberyCostLab = ngui.find_label(self.ui, 'sp_di2/lab')
    robberyCostLab:set_text(MATCH_ROBBERY_COST_GOLD)

    --CameraManager.EnterTouchMoveMode(nil, btn)

    for bid, v in pairs(ItemSceneNodeName) do
        local n = asset_game_object.find(v)
        if n then        
            n:set_name(tostring(bid))
        end
    end
    
    for k,bid in pairs(CityBuildingID) do
        self.itemsNode[bid] = asset_game_object.find("034_slg_item/" .. tostring(bid))
    end
    --app.log('itemsNode============ ' .. table.tostring(self.itemsNode))



    local coffeSp = ngui.find_sprite(self.ui, 'sp_di3/sp_token')
    coffeSp:set_sprite_name('kafei')

--    self.RightFightScoreTex = ngui.find_texture(self.ui, 'btn_di1/sp')
--    self.RightFightScoreTex:set_texture(SLGFightScoreIcon)

--    self.rightFightScoreLabel = ngui.find_label(self.ui, 'btn_di1/lab')
--    self.rightFightScoreLabel:set_text('')
    self.rightResourceShowLabel = ngui.find_label(self.ui, 'sp_di3/lab')
    self.rightResourceShowLabel:set_text('')
    self:OnUpdateResourceAndScore()

    CityBuildingMgr.GetInst():RequestMyBuildingInfo()

    CityRobberyMgr.GetInst():SetBuildingSceneUICount(uiManager:GetUICount())
end

function MyBuildingSceneUI2:OnUpdateResourceAndScore(resource, fightScore)
    
    local cbMgr = CityBuildingMgr.GetInst()
    
    if not cbMgr:HasRequestBuildingInfo() then    
        return 
    end

    self.rightResourceShowLabel:set_text(tostring(cbMgr:GetPlayerResource()))
    
    --self.rightFightScoreLabel:set_text(tostring(cbMgr:GetFightScore()))
end

function MyBuildingSceneUI2:on_click_scene(name, x, y, obj)

    if not CityBuildingMgr.GetInst():HasRequestBuildingInfo() then
        return
    end

    local layer_mask = PublicFunc.GetBitLShift({[1]=PublicStruct.UnityLayer.Default});
    local result, hit = util.raycase_out_object(x,y,100,layer_mask);
    if result then
        --app.log('selected obj========== ' .. hit.game_object:get_name())
        local bid = tonumber(hit.game_object:get_name())

        if self:IsShowHarvestIcon(bid) then
            return
        end

        CityBuildingMgr.GetInst():SetSelectedBuildingID(bid)

        uiManager:PushUi(EUI.BuildingTabPageUI)
    end
end

function MyBuildingSceneUI2:CheckShowNameAndLevel()
    local cbMgr = CityBuildingMgr.GetInst()
    local allBuildingInfo = cbMgr:GetAllBuildingInfo()
    for buildingid,v in pairs(allBuildingInfo) do
        local hasShowLevel = self.hasShowBuildingLevel[buildingid]
        local level = cbMgr:GetBuildingLevel(buildingid)
        if hasShowLevel ~= level then
            local node = self.showNameAndLevelNodes[buildingid]
            if node == nil then
                node = self.showNameAndLevelNode:clone()
                self.showNameAndLevelNodes[buildingid] = node
                node:set_active(true)

                local bindObj = self.itemsNode[buildingid]:get_child_by_name('node2')
                local x,y,z = bindObj:get_position()
                local isSuc,ux,uy,uz = PublicFunc.SceneWorldPosToUIWorldPos(x,y,z)
                if isSuc then
                    node:set_position(ux,uy, uz)
                end
            end

            local label = ngui.find_label(node, 'lab_name')
            label:set_text(self.showBuildingLevelStr[buildingid])
            label = ngui.find_label(node, 'lab_level')
            label:set_text(string.format('LV.%d', level))
        end
    end
end

function MyBuildingSceneUI2:OnClickHarvestIcon(param)

    local bid = param.float_value
    if self.isHarvestings[bid] ~= true then
        local cbMgr = CityBuildingMgr.GetInst()
        cbMgr:PlayerGainResource(bid, self.bindfunc["OnHarvestSucced"])

        self.isHarvestings[bid] = true
    end
end

function MyBuildingSceneUI2:OnHarvestSucced(bid, isShow)
    self.isHarvestings[bid] = nil

--    self.harvestFxNodes[bid]:set_active(true)
--    self.harvestShowNumLabel[bid]:set_active(true)

    local item = CityBuildingMgr.GetInst():GetLastGainGetItem();
    self.showExpItem = {}
    if item ~= nil then
        for k,v in ipairs(item) do
            table.insert(self.showExpItem, {id = v.high, count = v.low})
        end
    end

--    if bid ~= CityBuildingID.libraryID then
--        self.harvestShowNumLabel[bid]:set_text('+' .. tostring(count))
--        self.harvestAnimationNodes[bid]:animated_play(harvestAnimation[bid][1])
--    end

    if #self.showExpItem > 0 then
        self.harvestFxNodes[bid]:set_active(true)
        self.harvestShowNumLabel[bid]:set_active(true)

        self:ShowHarvestAnimation(bid)
    else
        self:HideHarvestIcon(bid)
    end
end

function MyBuildingSceneUI2:ShowHarvestAnimation(bid)

    if self.showExpItem == nil or #self.showExpItem == 0 then
        return
    end

    local showItem = self.showExpItem[1]
    table.remove(self.showExpItem, 1)
    self.harvestShowNumLabel[bid]:set_text('+' .. tostring(showItem.count))
    self.harvestAnimationNodes[bid]:animated_play(harvestAnimation[bid][2])
    self.harvestAnimationNodes[bid]:animated_play(harvestAnimation[bid][1])

    if bid == CityBuildingID.libraryID then
--@@^^$$         local itemConfig = gd_item[showItem.id]
        local itemConfig = ConfigManager.Get(EConfigIndex.t_item,showItem.id)

        self:SetHarvestIconTexture(bid, itemConfig.small_icon)
    end
end

function MyBuildingSceneUI2:SetHarvestIconTexture(bid, path)
    local node = self.showHarvestIconNodes[bid]

    local tex = ngui.find_texture(node, 'sp')
    if self.showHarvestIconNodeTexs[bid] then
        self.showHarvestIconNodeTexs[bid]:Destroy()
    end
    self.showHarvestIconNodeTexs[bid] = tex
    tex:set_texture(path) 
end


-- 收获动画完 回调
function MyBuildingSceneUI2:OnHarvestExp(obj)

    if self.showExpItem == nil then
        return
    end

    local bid = tonumber(obj:get_name())

    if #self.showExpItem == 0 then
        self:HideHarvestIcon(bid)

        if bid == CityBuildingID.libraryID then
            self:SetHarvestIconTexture(bid, SLGiconsPath[bid])
        end
    else
        self:ShowHarvestAnimation(bid)
    end
end

function MyBuildingSceneUI2:HideHarvestIcon(bid)
    if self.showHarvestIconNodes[bid] then
        self.showHarvestIconNodes[bid]:set_active(false)
    end

    if self.harvestFxNodes[bid] then
        self.harvestFxNodes[bid]:set_active(false)
    end
    self.showExpItem = nil
end

function MyBuildingSceneUI2:HideUpgradeIcon(bid)
    --app.log('HideUpgradeIcon ' .. tostring(bid) .. ' ' .. tostring(self.showUpgradeTimeNodes[bid]))
    if self.showUpgradeTimeNodes[bid] then
        self.showUpgradeTimeNodes[bid]:set_active(false)
    end
end

function MyBuildingSceneUI2:IsShowHarvestIcon(bid)

    local isShow = false;
    if self.showHarvestIconNodes[bid] then
        isShow = self.showHarvestIconNodes[bid]:get_active() == true
    end

    return isShow
end

function MyBuildingSceneUI2:Update(dt)
    local cbMgr = CityBuildingMgr.GetInst()
    if self.ui == nil or not cbMgr:HasRequestBuildingInfo() then
        return
    end

    self:CheckShowNameAndLevel()
    
    if self.isShowBeAttacked == true and cbMgr:isBeAttack() == false then
        self.showBeAttackSp:set_active(false)
        self.isShowBeAttacked = false
    elseif self.isShowBeAttacked == false and cbMgr:isBeAttack() == true then
        self.showBeAttackSp:set_active(true)
        self.isShowBeAttacked = true
        return
    end

    local allBuildingInfo = cbMgr:GetAllBuildingInfo()
    if allBuildingInfo then
        for buildingid,v in pairs(allBuildingInfo) do
            self:HideUpgradeIcon(buildingid)
            if cbMgr:IsUpgrading(buildingid) then
                self:HideHarvestIcon(buildingid)
                local remainTime = cbMgr:GetUpgradeRemainTime(buildingid)

                local d,h,m,s = TimeAnalysis.ConvertSecToDayHourMin(remainTime)
                local str = string.format(gs_misc['time_colon_str'], h, m, s)

                local node = self.showUpgradeTimeNodes[buildingid]
                --app.log('---------===== ' .. tostring(node))
                if node == nil then
                    node = self.showUpgradeLabelNode:clone()
                    self.showUpgradeTimeNodes[buildingid] = node

                    local bindObj = self.itemsNode[buildingid]:get_child_by_name('node1')
                    local x,y,z = bindObj:get_position()
                    local isSuc,ux,uy,uz = PublicFunc.SceneWorldPosToUIWorldPos(x,y,z)
                    if isSuc then
                        node:set_position(ux,uy, uz)
                    end
                end
                node:set_active(true)
                local label = ngui.find_label(node, 'lab2')
                label:set_text(str)

            elseif  cbMgr:CheckIsShowHarvestTip(buildingid) == true and 
                    (self.showHarvestIconNodes[buildingid] == nil or 
                        self.showHarvestIconNodes[buildingid]:get_active() == false) then

                local node = self.showHarvestIconNodes[buildingid]
                if node == nil then
                    node = self.canHarvestIconNode:clone()
                    self.showHarvestIconNodes[buildingid] = node

                    local bindObj = self.itemsNode[buildingid]:get_child_by_name('node1')
                    local x,y,z = bindObj:get_position()
                    local isSuc,ux,uy,uz = PublicFunc.SceneWorldPosToUIWorldPos(x,y,z)
                    if isSuc then
                        --app.log('my' .. tostring(buildingid) .. ' x= ' .. ux .. ' y=' .. uy .. ' z='.. uz )
                        node:set_position(ux,uy, uz)
                    end

                    self.harvestFxNodes[buildingid] = node:get_child_by_name('fx')
                    self.harvestFxNodes[buildingid]:set_active(false)

                    local tex = ngui.find_texture(node, 'sp')
                    self.showHarvestIconNodeTexs[buildingid] = tex
                    tex:set_texture(SLGiconsPath[buildingid])

                    local btn = ngui.find_button(node, 'sp')
                    btn:set_event_value('', buildingid)
                    btn:set_on_click(self.bindfunc["OnClickHarvestIcon"])

                    self.harvestAnimationNodes[buildingid] = node:get_child_by_name('animation')
                    self.harvestAnimationNodes[buildingid]:set_name(tostring(buildingid))
                    self.harvestShowNumLabel[buildingid] = ngui.find_label(self.harvestAnimationNodes[buildingid], "lab_num")

                end
                node:set_active(true)
                self.harvestFxNodes[buildingid]:set_active(false)
                self.harvestShowNumLabel[buildingid]:set_active(false)
                self.harvestAnimationNodes[buildingid]:animated_play(harvestAnimation[buildingid][2])
            end
        end
    end

end

function MyBuildingSceneUI2:DestroyUi()

    if self.ui ~= nil then
--        self.RightFightScoreTex:Destroy()
--        self.RightFightScoreTex = nil
        for k,v in pairs(self.showHarvestIconNodeTexs) do
            v:Destroy()
        end
        self.showHarvestIconNodeTexs = {}
    end

    UiBaseClass.DestroyUi(self);
end

function MyBuildingSceneUI2:on_navbar_back()
    uiManager:PopUi(nil, true)
    SceneManager.PopScene()
    CityRobberyMgr.GetInst():SetBuildingSceneUICount(-1)
    return true
end

function MyBuildingSceneUI2:Hide()
    if self.ui == nil then
        return false
    end

    for k,bid in pairs(CityBuildingID) do
        if self.harvestFxNodes[bid] ~= nil and self.harvestFxNodes[bid]:get_active() == true then
            if bid == CityBuildingID.libraryID then
                --app.log('MyBuildingSceneUI2:Hide ===================== 2')
                self:SetHarvestIconTexture(bid, SLGiconsPath[bid])
            end
            self:HideHarvestIcon(bid)
        end
    end

    return UiBaseClass.Hide(self)
end
