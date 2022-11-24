
TargetBuildingSceneUI2 = Class("TargetBuildingSceneUI2", UiBaseClass)


local TargetBuildingSceneUI2Str = 
{
    [1] = "今天你的掠夺次数已用完，本次掠夺之后无法获得任何资源和积分";
}

function TargetBuildingSceneUI2:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/slg/ui_2305_slg_university.assetbundle"
    UiBaseClass.Init(self, data);
end

function TargetBuildingSceneUI2:Restart()
    local crmgr = CityRobberyMgr.GetInst()

    if  crmgr:GetTipRobberyIsTimeOut() == true then
        HintUI.SetAndShow(EHintUiType.zero, gs_misc['str_15'])
        crmgr:SetTipRobberyTimeOut(false)
    end

    if crmgr:HasRobberyAllResource() or crmgr:GetTargetPlayer() == nil then
        uiManager:PopUi()
        crmgr:ClearTarget()
        return 
    end

    self:InitData()
    UiBaseClass.Restart(self, data)
end

function TargetBuildingSceneUI2:InitData()
    self.ui = nil;
    self.bindfunc = {}
    self.itemsNode = {}
    self.canRobberyIconNodes = {}
    self.showResourceNumNodes = {}
    self.showResourceNumTexNodes = {}
end

function TargetBuildingSceneUI2:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickBackTown"]	   = Utility.bind_callback(self, TargetBuildingSceneUI2.OnClickBackTown);
    self.bindfunc["OnChangeTarget"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnChangeTarget)
    self.bindfunc["OnConfirmChangeTarget"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnConfirmChangeTarget)
    self.bindfunc["OnConfirmExitRobbery"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnConfirmExitRobbery)
    self.bindfunc["on_click_scene"] = Utility.bind_callback(self, TargetBuildingSceneUI2.on_click_scene);
    self.bindfunc["OnUpdateRobberyCount"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnUpdateRobberyCount);
    self.bindfunc["OnClickRuleBtn"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnClickRuleBtn);
    self.bindfunc["OnClickIcon"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnClickIcon);
    self.bindfunc["OnClickBuyCount"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnClickBuyCount);
    self.bindfunc["OnConfirmBuyCount"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnConfirmBuyCount);
    self.bindfunc["OnBuyRobberyCountResult"] = Utility.bind_callback(self, TargetBuildingSceneUI2.OnBuyRobberyCountResult);
end

function TargetBuildingSceneUI2:MsgRegist()
    PublicFunc.msg_regist(msg_city_building.gc_buy_robbery_count_ret, self.bindfunc['OnBuyRobberyCountResult'])
end

function TargetBuildingSceneUI2:MsgUnRegist()
    PublicFunc.msg_unregist(msg_city_building.gc_buy_robbery_count_ret, self.bindfunc['OnBuyRobberyCountResult'])
end

function TargetBuildingSceneUI2:ShowNavigationBar()
    return false
end

function TargetBuildingSceneUI2:OnClickRuleBtn()
    uiManager:PushUi(EUI.UiRuleDesNoNavBar,ENUM.ERuleDesType.XiaoYuanJianSheLueDuo)
end

function TargetBuildingSceneUI2:OnClickBackTown()
    --app.log('self.bindfunc["OnClickBackTown"] ')
    uiManager:PopUi()
end

function TargetBuildingSceneUI2:OnChangeTarget()
    if CityRobberyMgr.GetInst():HasRobbedAnyBuilding() == true then

        local crmgr = CityRobberyMgr.GetInst()
        local bid = CityBuildingID.teachingBuildID
        local bi = crmgr:GetTargetBuildingInfo(bid)
        local str = gs_misc['str_25']
        if crmgr:HasRobbedMainBuilding() then
            str = gs_misc['str_26']
        end
        HintUI.SetAndShow(EHintUiType.two, str, {str=gs_misc['ok'], func = self.bindfunc["OnConfirmExitRobbery"]}, {str=gs_misc['cancel']})
    else
        HintUI.SetAndShow(EHintUiType.two, gs_misc['str_24'], {str=gs_misc['ok'], func = self.bindfunc["OnConfirmChangeTarget"]}, {str=gs_misc['cancel']})
    end
end

function TargetBuildingSceneUI2:OnConfirmChangeTarget()
    uiManager:ReplaceUi(EUI.SearchingRobberyTargetUI)
end

function TargetBuildingSceneUI2:OnConfirmExitRobbery()
    msg_city_building.abort_robbery()
    CityRobberyMgr.GetInst():ClearTarget()
    uiManager:PopUi();
end

function TargetBuildingSceneUI2:on_click_scene(name, x, y, obj)
    local layer_mask = PublicFunc.GetBitLShift({[1]=PublicStruct.UnityLayer.Default});
    local result, hit = util.raycase_out_object(x,y,100,layer_mask);
    if result then
        local bid = tonumber(hit.game_object:get_name())

        local crm = CityRobberyMgr.GetInst()
        if bid ~= CityBuildingID.teachingBuildID and not crm:HasRobbedMainBuilding() then
            HintUI.SetAndShow(EHintUiType.zero, gs_misc['str_33'])
            return
        end

        self:OnClickEnterRobberyEmbattleUI(bid)
    end
end

function TargetBuildingSceneUI2:OnClickIcon(param)
    --app.log('OnClickIcon xxxxxxxxxxxxxxx')
    self:OnClickEnterRobberyEmbattleUI(param.float_value)
end

function TargetBuildingSceneUI2:OnClickBuyCount()
    local cbm = CityBuildingMgr.GetInst()

    local vipData = g_dataCenter.player:GetVipData();
    if vipData == nil then
        app.log("vip config error")
        return
    end
    local slgBuyData = ConfigManager.Get(EConfigIndex.t_slg_buy_cost,cbm:GetBuyRobberyCountTimes() + 1);
    if slgBuyData == nil then
        slgBuyData = ConfigManager.Get(EConfigIndex.t_slg_buy_cost, ConfigManager.GetDataCount(EConfigIndex.t_slg_buy_cost))
    end

    CommonBuy.Show(cbm:GetBuyRobberyCountTimes(), vipData.ex_slg_buy_times, slgBuyData.cost, slgBuyData.buy_count,gs_misc['str_42'], 
        gs_misc['str_43'], self.bindfunc["OnConfirmBuyCount"])
end

function TargetBuildingSceneUI2:OnConfirmBuyCount()
    msg_city_building.cg_buy_robbery_count()
end

function TargetBuildingSceneUI2:OnBuyRobberyCountResult(ret)
    local isSuc,info = PublicFunc.GetErrorString(ret, true)
    if isSuc then
        HintUI.SetAndShow(EHintUiType.zero, gs_all_string_cn['jiaotangqidao_17']);
    end
end

function TargetBuildingSceneUI2:OnClickEnterRobberyEmbattleUI(bid)
    local crm = CityRobberyMgr.GetInst()
    local robberyCount = CityBuildingMgr.GetInst():GetRobberyCount()
    if robberyCount < 1 and crm:GetUsedRobberyCount() ~= true then
        HintUI.SetAndShow(EHintUiType.two, TargetBuildingSceneUI2Str[1],
        {func = Utility.create_callback(TargetBuildingSceneUI2.EnterRobberyEmbattleUI, self, bid), str = gs_misc['str_17']}
        , {func = nil, str = gs_misc['str_18']})
    else
        self:EnterRobberyEmbattleUI(bid)
        crm:SetUsedRobberyCount(true)
    end
end

function TargetBuildingSceneUI2:EnterRobberyEmbattleUI(bid)
    local crmgr = CityRobberyMgr.GetInst()
    if crmgr:BuildingHasRobbed(bid) then
        return
    end

    local bi = crmgr:GetTargetBuildingInfo(bid)
    if bi ~= nil then
        crmgr:SetSelectedBuildingID(bid)
        uiManager:PushUi(EUI.TargetBuildingEmbattleInfoUI)
    else
        app.log('TargetBuildingSceneUI:OnClickBuildingBtn bi == nil')
    end
end

function TargetBuildingSceneUI2:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    local btn = ngui.find_button(self.ui, 'btn_back')
    btn:reset_on_click()
    btn:set_on_click(self.bindfunc["OnClickBackTown"])

    btn = ngui.find_button(self.ui, 'button')
    btn:reset_on_click()
    btn:set_on_click(self.bindfunc["OnChangeTarget"])

    local crmgr = CityRobberyMgr.GetInst()

    btn = ngui.find_button(self.ui, 'mark')
    btn:reset_on_click()
    btn:set_on_ngui_click(self.bindfunc["on_click_scene"])

    local cbMgr = CityBuildingMgr.GetInst()
    local targetPlayer = crmgr:GetTargetPlayer()

    local label = ngui.find_label(self.ui, 'sp_bk1/lab_name')
    label:set_text(tostring(targetPlayer:GetName()))
    label = ngui.find_label(self.ui, 'sp_bk2/lab_level')
    label:set_text('LV.' .. targetPlayer:GetLevel())
    label = ngui.find_label(self.ui, 'sp_bk3/lab_society_name')
    label:set_text(crmgr:GetTargetGuildName())

    local changeCostLabel = ngui.find_label(self.ui, 'centre_other/sp_di2/lab')
    changeCostLabel:set_text(MATCH_ROBBERY_COST_GOLD)

    self.showRobberyCountLabel = ngui.find_label(self.ui, 'right_top_other/sp_di3/lab_num')
    self.showRobberyCountLabel:set_text(tostring(cbMgr:GetRobberyCount()))

    cbMgr:SetOnUpdateRobberyCount(self.bindfunc["OnUpdateRobberyCount"])

    btn = ngui.find_button(self.ui, 'right_top_other/sp_di3/btn_add')
    btn:reset_on_click()
    btn:set_on_click(self.bindfunc["OnClickBuyCount"])

--    label = ngui.find_label(self.ui, 'content1/lab_num')
--    label:set_text(tostring(cbMgr:GetExtResource()))

--    self.extResourceTex = ngui.find_texture(self.ui, 'content1/sp')
--    self.extResourceTex:set_texture(SLGiconsPath[CityBuildingID.teachingBuildID])

    self.showRemainTimeLabel = ngui.find_label(self.ui, 'cont_time/lab_time')

    self.canRobberyIconTemplete = self.ui:get_child_by_name('centre_other/cont')
    self.canRobberyIconTemplete:set_active(false)
    self.showTargetResourceNumTemplete = self.ui:get_child_by_name('centre_other/cont2')
    self.showTargetResourceNumTemplete:set_active(false)

    local btn = ngui.find_button(self.ui, 'btn_rule')
    btn:set_on_click(self.bindfunc["OnClickRuleBtn"])

    for bid, v in pairs(ItemSceneNodeName) do
        local n = asset_game_object.find(v)
        if n then        
            n:set_name(tostring(bid))
        end
    end

    for k,bid in pairs(CityBuildingID) do
        self.itemsNode[bid] = asset_game_object.find("034_slg_item/" .. tostring(bid))
        local x,y,z = self.itemsNode[bid]:get_child_by_name('node1'):get_position()
    end

--    local sp = ngui.find_sprite(self.ui, 'cont')
--    local centerOtherNode = self.ui:get_child_by_name('centre_other')
--    sp:set_parent(centerOtherNode)
--    sp:set_active(false)

    self:UpdateUi()

end

function TargetBuildingSceneUI2:OnUpdateRobberyCount()
    if self.showRobberyCountLabel then
        self.showRobberyCountLabel:set_text(tostring(CityBuildingMgr.GetInst():GetRobberyCount()))
    end
end

function TargetBuildingSceneUI2:Show()
    UiBaseClass.Show(self)

    self:UpdateUi()
end

function TargetBuildingSceneUI2:UpdateUi()
    if not self.ui then
        return
    end
    local crmgr = CityRobberyMgr.GetInst()
    if crmgr:HasRobberyAllResource() or crmgr:GetTargetPlayer() == nil then
        uiManager:PopUi()
        crmgr:ClearTarget()
        return 
    end

    if crmgr:HasRobbedAnyBuilding() then
        label = ngui.find_label(self.ui, 'button/lab')
        label:set_text(gs_misc['str_27'])
        local showCostNode = self.ui:get_child_by_name('centre_other/sp_di2')
        showCostNode:set_active(false)
    end

    self:ShowCanRobberyBuilding()
end

function TargetBuildingSceneUI2:ShowCanRobberyBuilding()

    local crmgr = CityRobberyMgr.GetInst()

    for k,v in pairs(self.canRobberyIconNodes) do
        v:set_active(false)
    end
    

    for k,bid in pairs(CityBuildingID) do
        local bi = crmgr:GetTargetBuildingInfo(bid)
        if bi ~= nil and not crmgr:BuildingHasRobbed(bid)
            and (bid == CityBuildingID.teachingBuildID or crmgr:HasRobbedMainBuilding())
             then
            local node = self.canRobberyIconNodes[bid]
            if node == nil then
                node = self.canRobberyIconTemplete:clone()
                self.canRobberyIconNodes[bid] = node
            end
            node:set_active(true)
            --node:set_parent(self.ui)
            --node:set_name('icon_' .. bid)
            local bindObj = self.itemsNode[bid]:get_child_by_name('node1')
            local x,y,z = bindObj:get_position()
            local isSuc,ux,uy,uz = PublicFunc.SceneWorldPosToUIWorldPos(x,y,z)
            if isSuc then
                --app.log('target ' .. tostring(bid) .. ' x= ' .. ux .. ' y=' .. uy .. ' z='.. uz )
                node:set_position(ux,uy, uz)
            end
            local btn = ngui.find_button(node, 'sp')
            btn:reset_on_click()
            btn:set_event_value('', bid)
            btn:set_on_click(self.bindfunc["OnClickIcon"])
            
            node = self.showResourceNumNodes[bid]
            if node == nil then
                node = self.showTargetResourceNumTemplete:clone()
                self.showResourceNumNodes[bid] = node
            end
            node:set_active(true)
            --node:set_parent(self.ui)
            --node:set_name('num_' .. bid)
            bindObj = self.itemsNode[bid]:get_child_by_name('node2')
            x,y,z = bindObj:get_position()
            isSuc,ux,uy,uz = PublicFunc.SceneWorldPosToUIWorldPos(x,y,z)
            if isSuc then
                node:set_position(ux,uy, uz)
            end
            local label = ngui.find_label(node, 'sp_di/txt1')
            label:set_text(tostring(bi.resource))
            self.showResourceNumTexNodes[bid] = ngui.find_texture(node, 'sp_di/texture')
            self.showResourceNumTexNodes[bid]:set_texture(SLGiconsPath[bid])

            label = ngui.find_label(node, 'lab_name')
            local name = ConfigManager.Get(EConfigIndex.t_building,bid).name
            label:set_text(name)

            label = ngui.find_label(node, 'lab_level')
            label:set_text('Lv.' .. tostring(bi.level))

--            if bid == CityBuildingID.teachingBuildID and not crmgr:HasRobbedMainBuilding() and isSuc then
--                local sp = ngui.find_sprite(self.ui, 'cont'):get_game_object()
--                sp:set_active(true)
--                sp:set_position(ux,uy, uz)
--                local w,l = crmgr:GetWinAndLostScoreChange()
--                label = ngui.find_label(self.ui, 'cont/lab_num')
--                label:set_text(tostring(w))
--                label = ngui.find_label(self.ui, 'cont/lab_num2')
--                label:set_text(tostring(l))
--            end
        end
    end
end

function TargetBuildingSceneUI2:DestroyUi()

    if self.ui ~= nil then
--        self.extResourceTex:Destroy()
--        self.extResourceTex = nil
        for k,tex in pairs(self.showResourceNumTexNodes) do
            tex:Destroy()
        end
        self.showResourceNumTexNodes = nil
        self.showRobberyCountLabel = nil
        CityBuildingMgr.GetInst():SetOnUpdateRobberyCount(nil)

--        self.btnChangeTex:Destroy()
--        self.btnChangeTex = nil
    end

    UiBaseClass.DestroyUi(self);
end

function TargetBuildingSceneUI2:Update(dt)

    if self.showRemainTimeLabel ~= nil then
        local remainTime = CityRobberyMgr.GetInst():GetRemainRobberyTime()
        if self.hasShowRemainTime ~= remainTime and remainTime > 0 then
            self.hasShowRemainTime = remainTime
            local d,h,m,s = TimeAnalysis.ConvertSecToDayHourMin(remainTime)

            self.showRemainTimeLabel:set_text(string.format("%02d:%02d", m,s))
        end
    end
end
