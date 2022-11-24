
BuildingInfoUI = Class("BuildingInfoUI", UiBaseClass)

function BuildingInfoUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/slg/ui_2309_slg_university.assetbundle"
    UiBaseClass.Init(self, data);
end

function BuildingInfoUI:Restart(data)
    self:InitData(data)
    UiBaseClass.Restart(self, data)
end

function BuildingInfoUI:InitData(data)

    UiBaseClass.InitData(self, data)

    self.modelRender = nil

    self.cur_resource = nil
    self.progressbar = nil
--    self.remainTimeLabel = nil
--    self.curShowRemainTime = nil
    self.textureSave = {}
end

function BuildingInfoUI:InitUI(asset_obj)
    
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_name('ui_2308_slg_university')

    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()
    local level = cbmgr:GetBuildingLevel(bid)
    local buildingConfig = cbmgr:GetBuildingConfigFromID(bid)
    local upconfig = cbmgr:GetUpgradeConfig(bid, level)


--    local label = ngui.find_label(self.ui, 'kug1/txt1')
--    label:set_text(buildingConfig.name)
    local label = ngui.find_label(self.ui, 'lab_level')
    label:set_text('Lv.' .. tostring(level))

    label = ngui.find_label(self.ui, 'kug1/lab_num1')
    label:set_text(string.format(gs_misc['prod_per_hour'], upconfig.production))

    label = ngui.find_label(self.ui, 'sp_di/txt')
    label:set_text(buildingConfig.desc)

    self.totalStore = upconfig.max_storage
    self.currentStore = 0
    self.showResourceLabel = ngui.find_label(self.ui, 'kug2/lab_num1')
    self.showResourceProgressBar = ngui.find_progress_bar(self.ui, 'kug2/sp_back_bar')

    self.textureSave[1] = ngui.find_texture(self.ui, 'kug1/sp_jing_yan')
    self.textureSave[1]:set_texture(SLGiconsPath[bid])
    self.textureSave[2] = ngui.find_texture(self.ui, 'kug2/sp_jing_yan')
    self.textureSave[2]:set_texture(SLGiconsPath[bid])

    self.texName = "sp_cat"
    self.renderTex = self.ui:get_child_by_name(self.texName)
    self.modelRender = RenderTexture:new({ui_obj_root = self.renderTex, ui_texture_name = self.texName, model_id = SLGBuildingModeID[bid]})
end

function BuildingInfoUI:UpdateStorage()
    if self.showResourceProgressBar ~= nil then
        local cbmgr = CityBuildingMgr.GetInst()
        local bid = cbmgr:GetSelectedBuildingID()
        local curRes = cbmgr:GetBuildingResource(bid)

        if self.cur_resource ~= curRes then
            local str = string.format(gs_misc['num_per_num'], curRes, self.totalStore)
            self.showResourceLabel:set_text(str)
            local barValue = curRes/self.totalStore
            self.showResourceProgressBar:set_value(barValue)

            self.cur_resource = curRes
        end
    end

end


function BuildingInfoUI:Update(dt)
    self:UpdateStorage()
end

function BuildingInfoUI:DestroyUi()

    UiBaseClass.DestroyUi(self)

    if self.modelRender then
        self.modelRender:Destroy()
        self.modelRender = nil
    end

    for k,v in pairs(self.textureSave) do
        v:Destroy()
    end
    self.textureSave = {}
end