
BuildingUpgradeUI = Class("BuildingUpgradeUI", UiBaseClass)


function BuildingUpgradeUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/slg/ui_2307_slg_university.assetbundle"
    UiBaseClass.Init(self, data);
end

function BuildingUpgradeUI:Restart(data)
    self:InitData()
    UiBaseClass.Restart(self, data)
end

function BuildingUpgradeUI:InitData(data)

    UiBaseClass.InitData(self, data)

    self.modelRender = nil
    self.isUpgrading = false

    self.lastShowRemainTime = nil
    self.textureSave = {}
end

function BuildingUpgradeUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["onClickUpgrade"]	   = Utility.bind_callback(self, BuildingUpgradeUI.onClickUpgrade);
    self.bindfunc["onUpgradeReponse"] = Utility.bind_callback(self, BuildingUpgradeUI.onUpgradeReponse);
    self.bindfunc["onClickCancel"]	   = Utility.bind_callback(self, BuildingUpgradeUI.onClickCancel);
    self.bindfunc["onCancelUpgradeReponse"]	   = Utility.bind_callback(self, BuildingUpgradeUI.onCancelUpgradeReponse);
    self.bindfunc["onConfirmCancel"]	   = Utility.bind_callback(self, BuildingUpgradeUI.onConfirmCancel);
end

function BuildingUpgradeUI:MsgRegist()
    PublicFunc.msg_regist(msg_city_building.gc_cancel_upgrade_ret, self.bindfunc["onCancelUpgradeReponse"])
end

function BuildingUpgradeUI:MsgUnRegist()
    PublicFunc.msg_unregist(msg_city_building.gc_cancel_upgrade_ret, self.bindfunc["onCancelUpgradeReponse"])
end


function BuildingUpgradeUI:onClickUpgrade(param)

    local cbmgr = CityBuildingMgr.GetInst()
    local buildingid = cbmgr:GetSelectedBuildingID()
    CityBuildingMgr.GetInst():LevelUp(buildingid, self.bindfunc["onUpgradeReponse"])
end

function BuildingUpgradeUI:onUpgradeReponse(ret)
    app.log('onUpgradeReponse=============== ' .. tostring(ret))
    local show,info = PublicFunc.GetErrorString(ret, false);
    if show then
        self:ShowUIContent()
    else
        HintUI.SetAndShow(EHintUiType.zero, info)
    end
end

function BuildingUpgradeUI:onClickCancel()
    HintUI.SetAndShow(EHintUiType.two, gs_misc['str_23'], {str=gs_misc['ok'], func = self.bindfunc["onConfirmCancel"]}, {str=gs_misc['cancel']})
end

function BuildingUpgradeUI:onConfirmCancel()

    local cbmgr = CityBuildingMgr.GetInst()
    local buildingid = cbmgr:GetSelectedBuildingID()
    msg_city_building.cg_cancel_upgrade(buildingid)

    self.loadingId = GLoading.Show(GLoading.EType.ui)
end

function BuildingUpgradeUI:onCancelUpgradeReponse(ret, buildingid, retResource)
    GLoading.Hide(GLoading.EType.ui, self.loadingId);
    app.log('onCancelUpgradeReponse=============== ' .. tostring(ret))
    local show,info = PublicFunc.GetErrorString(ret, false);
    if show then

        self:ShowUIContent()

        HintUI.SetAndShow(EHintUiType.zero, string.format(gs_misc['ret_resource_str'],retResource))
    else
        HintUI.SetAndShow(EHintUiType.zero, info)
    end
end

function BuildingUpgradeUI:ShowUpgradeNexLevel()   
    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()
    local buildingConfig = cbmgr:GetBuildingConfigFromID(bid)
    local level = cbmgr:GetBuildingLevel(bid)
    local upconfig = cbmgr:GetUpgradeConfig(bid, level)

    local node = self.ui:get_child_by_name('sp_di/sp_art_font')
    node:set_active(false)
    node = self.ui:get_child_by_name('sp_di/cont2')
    node:set_active(false)
    node = self.ui:get_child_by_name('sp_di/cont1')
    node:set_active(true)

    local costTime = upconfig.upgrade_cost_time
    local d,h,m,s = TimeAnalysis.ConvertSecToDayHourMin(costTime)
    str = string.format(gs_misc['time_colon_str'], h, m, s)
    local label = ngui.find_label(self.ui, 'sp_di/cont1/lab_num')
    label:set_text(str)

    local poorStr = '[fa0909]%d/%d[-]'
    local enoughStr = '[09fd0d]%d/%d[-]'
    local playerRes = cbmgr:GetPlayerResource()
    local str = poorStr;
    if playerRes >= upconfig.upgrade_cost_resource then
        str = enoughStr
    end
    str = string.format(str, playerRes,upconfig.upgrade_cost_resource)
    label = ngui.find_label(self.ui, 'sp_di/cont1/sp_di/lab')
    label:set_text(str)

    local upgradeBtn = ngui.find_button(self.ui, 'sp_di/cont1/btn1')
    upgradeBtn:reset_on_click()
    upgradeBtn:set_on_click(self.bindfunc["onClickUpgrade"])

--    local count = #self.textureSave + 1
--    self.textureSave[count] = ngui.find_texture(self.ui, 'choose1/sp_box')
--    self.textureSave[count]:set_texture(SLGiconsPath[CityBuildingID.teachingBuildID])
end

function BuildingUpgradeUI:ShowUpgrading()

    local node = self.ui:get_child_by_name('sp_di/sp_art_font')
    node:set_active(false)
    node = self.ui:get_child_by_name('sp_di/cont1')
    node:set_active(false)
    node = self.ui:get_child_by_name('sp_di/cont2')
    node:set_active(true)

    self.countDownLabel = ngui.find_label(self.ui, 'sp_di/cont2/lab_num')

--    local btn = ngui.find_button(self.ui, 'choose2/btn_anniu')
--    btn:reset_on_click()
--    btn:set_on_click(self.bindfunc["onClickCancel"])

end

function BuildingUpgradeUI:SetCommonContent()
    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()
    local buildingConfig = cbmgr:GetBuildingConfigFromID(bid)
    local level = cbmgr:GetBuildingLevel(bid)
    local upconfig = cbmgr:GetUpgradeConfig(bid, level)
    local nexupconfig = cbmgr:GetUpgradeConfig(bid, level + 1)

--    local label = ngui.find_label(self.ui, 'kug1/txt1')
--    label:set_text(buildingConfig.name)
--    label = ngui.find_label(self.ui, 'kug1/lab_num1')
--    label:set_text("LV." .. tostring(level))

--    label = ngui.find_label(self.ui, 'kug1/lab_num2')
--    label:set_text("LV." .. tostring(level + 1))

    local label = ngui.find_label(self.ui, 'kug1/lab_num1')
    label:set_text(tostring(upconfig.production))
    label = ngui.find_label(self.ui, 'kug1/lab_num2')
    label:set_text(tostring(nexupconfig.production))

    label = ngui.find_label(self.ui, 'kug2/lab_num1')
    label:set_text(tostring(upconfig.max_storage))
    label = ngui.find_label(self.ui, 'kug2/lab_num2')
    label:set_text(tostring(nexupconfig.max_storage))

    local progressBar1 = ngui.find_progress_bar(self.ui, 'kug1/sp_back_bar')
    local progressBar2 = ngui.find_progress_bar(self.ui, 'kug2/sp_back_bar')

    progressBar1:set_value(0.6)
    progressBar2:set_value(0.6)
end

function BuildingUpgradeUI:SetBuildingHasTeachMaxLevelContent()
    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()
    local buildingConfig = cbmgr:GetBuildingConfigFromID(bid)
    local level = cbmgr:GetBuildingLevel(bid)
    local upconfig = cbmgr:GetUpgradeConfig(bid, level)

--    local label = ngui.find_label(self.ui, 'kug1/txt1')
--    label:set_text(buildingConfig.name)


    local label = ngui.find_label(self.ui, 'kug1/lab_num1')
    label:set_text(tostring(upconfig.production))
    label = ngui.find_label(self.ui, 'kug1/lab_num2')
    label:set_active(false)
    local sp = ngui.find_sprite(self.ui, 'kug1/sp_arrows')
    sp:set_active(false)

    label = ngui.find_label(self.ui, 'kug2/lab_num1')
    label:set_text(tostring(upconfig.max_storage))
    label = ngui.find_label(self.ui, 'kug2/lab_num2')
    label:set_active(false)
    sp = ngui.find_sprite(self.ui, 'kug2/sp_arrows')
    sp:set_active(false)


    local progressBar1 = ngui.find_progress_bar(self.ui, 'kug1/sp_back_bar')
    local progressBar2 = ngui.find_progress_bar(self.ui, 'kug2/sp_back_bar')

    progressBar1:set_value(1)
    progressBar2:set_value(1)

--    sp = ngui.find_sprite(self.ui, 'choose1')
--    sp:set_active(true)
--    sp = ngui.find_sprite(self.ui, 'choose2')
--    sp:set_active(false)

--    local btn = ngui.find_button(self.ui, 'btn_anniu')
--    btn:set_active(false)

--    label = ngui.find_label(self.ui, 'choose1/lab_num1')
--    label:set_active(false)

--    label = ngui.find_label(self.ui, 'choose1/txt2')
--    label:set_active(false)

--    label = ngui.find_label(self.ui, 'choose1/lab_num')
--    label:set_text(string.format(gs_misc['building_reach_max_level'], ''))

--    label = ngui.find_label(self.ui, 'choose1/txt1')
--    label:set_active(false)
    local node = self.ui:get_child_by_name('sp_di/cont1')
    node:set_active(false)
    node = self.ui:get_child_by_name('sp_di/cont2')
    node:set_active(false)
    node = self.ui:get_child_by_name('sp_di/sp_art_font')
    node:set_active(true)
end

function BuildingUpgradeUI:ShowUIContent()
    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()
    local level = cbmgr:GetBuildingLevel(bid)

    label = ngui.find_label(self.ui, 'lab_level')
    label:set_text("Lv." .. tostring(level))
    if level >= cbmgr:GetMaxBuildingLevel(bid) then
        self:SetBuildingHasTeachMaxLevelContent(bid)
    else
        self.isUpgrading = cbmgr:IsUpgrading(bid)
        self:SetCommonContent()
        self.showLevel = level

        app.log('=============1 ' .. tostring(self.isUpgrading) .. ' ' .. self.showLevel)

        if self.isUpgrading then
            self:ShowUpgrading()
        else
            self:ShowUpgradeNexLevel()
        end
    end
end

function BuildingUpgradeUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()

    self.texName = "sp_cat"
    self.renderTex = self.ui:get_child_by_name(self.texName)
    self.modelRender = RenderTexture:new({ui_obj_root = self.renderTex, ui_texture_name = self.texName, model_id = SLGBuildingModeID[bid]})

    self.textureSave[1] = ngui.find_texture(self.ui, 'kug1/sp_jing_yan')
    self.textureSave[1]:set_texture(SLGiconsPath[bid])
    self.textureSave[2] = ngui.find_texture(self.ui, 'kug2/sp_jing_yan')
    self.textureSave[2]:set_texture(SLGiconsPath[bid])

    self:ShowUIContent()

end

function BuildingUpgradeUI:Update(dt)


    local cbmgr = CityBuildingMgr.GetInst()

    if self.isUpgrading and self.countDownLabel ~= nil then
        local bid = cbmgr:GetSelectedBuildingID()
        local remainTime = cbmgr:GetUpgradeRemainTime(bid)
        if remainTime > 0 then
            if self.lastShowRemainTime ~= remainTime then
                local d,h,m,s = TimeAnalysis.ConvertSecToDayHourMin(remainTime)
                local str = string.format(gs_misc['time_colon_str'], h, m, s)
                self.countDownLabel:set_text(str)
                self.lastShowRemainTime = remainTime
            end
        else
            local level = cbmgr:GetBuildingLevel(bid)
            --app.log(' -======- ' .. tostring(level) .. ' ' .. tostring(self.showLevel))
            if level ~= self.showLevel then
                self:ShowUIContent()
            end
        end
    end
end


function BuildingUpgradeUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.modelRender then
        self.modelRender:Destroy()
        self.modelRender = nil
    end
    for k,v in pairs(self.textureSave) do
        v:Destroy()
    end
    self.textureSave = {}
end