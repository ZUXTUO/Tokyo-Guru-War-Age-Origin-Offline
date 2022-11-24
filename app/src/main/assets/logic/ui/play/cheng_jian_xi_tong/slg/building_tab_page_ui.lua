
BuildingTabPageUI = Class('BuildingTabPageUI', UiBaseClass)

local pageEnum = 
{
    INFO = 1,
    UPGRADE = 2,
    EMBATTLE = 3,
}

local tabPageClass =
{
    [pageEnum.INFO] = BuildingInfoUI;
    [pageEnum.UPGRADE] = BuildingUpgradeUI;
    [pageEnum.EMBATTLE] = BuildingEmbattleInfoUI;
}

local uiTxt = 
{
    [1] = '%s的%s';
}

function BuildingTabPageUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/slg/ui_2312_slg_university.assetbundle"
    UiBaseClass.Init(self, data);
end

--function BuildingTabPageUI:Restart()
--    UiBaseClass.Restart(self, data)
--end

function BuildingTabPageUI:InitData()
    self.ui = nil;
    self.bindfunc = {}

    self.currentPage = nil
end

function BuildingTabPageUI:RegistFunc()

    UiBaseClass.RegistFunc(self);

    self.bindfunc["OnClickInfoUI"]	   = Utility.bind_callback(self, BuildingTabPageUI.OnClickInfoUI);
    self.bindfunc["OnClickGuardUI"]	   = Utility.bind_callback(self, BuildingTabPageUI.OnClickGuardUI);
    self.bindfunc["OnClickUpgradeUI"]	   = Utility.bind_callback(self, BuildingTabPageUI.OnClickUpgradeUI);
    --self.bindfunc["OnClickRobberyUI"]	   = Utility.bind_callback(self, BuildingTabPageUI.OnClickRobberyUI);
    self.bindfunc["OnClickRuleBtn"]	   = Utility.bind_callback(self, BuildingTabPageUI.OnClickRuleBtn);
    self.bindfunc["OnClickClose"]	   = Utility.bind_callback(self, BuildingTabPageUI.OnClickClose);
end

function BuildingTabPageUI:OnClickClose()
    uiManager:PopUi()
end

function BuildingTabPageUI:OnClickRuleBtn()
    UiRuleDes.Start(ENUM.ERuleDesType.XiaoYuanJianShe)
end

function BuildingTabPageUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_name('ui_2312_slg_university')

    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()
    local buildingConfig = cbmgr:GetBuildingConfigFromID(bid)

    self.centerNode = self.ui:get_child_by_name('centre_other')

    local titleLab = ngui.find_label(self.ui, 'sp_title/lab')
    titleLab:set_text(string.format(uiTxt[1] , g_dataCenter.player:GetName(), buildingConfig.name))

    self.infoToggle = ngui.find_toggle(self.ui, 'yeka/yeka1')
    self.infoToggle:set_on_change(self.bindfunc["OnClickInfoUI"])

    self.UpgradeToggle = ngui.find_toggle(self.ui, 'yeka/yeka2')
    self.UpgradeToggle:set_on_change(self.bindfunc["OnClickUpgradeUI"])

    self.GuardToggle = ngui.find_toggle(self.ui, 'yeka/yeka3')
    self.GuardToggle:set_on_change(self.bindfunc["OnClickGuardUI"])

--    local btn = ngui.find_button(self.ui, 'button')
--    btn:set_on_click(self.bindfunc["OnClickRobberyUI"])

--    local btn = ngui.find_button(self.ui, 'btn_rule')
--    btn:set_on_click(self.bindfunc["OnClickRuleBtn"])

    btn = ngui.find_button(self.ui, 'btn_cha')
    btn:set_on_click(self.bindfunc["OnClickClose"])

    self.uiCount = uiManager:GetUICount()

    if self.currentPageIndex == pageEnum.EMBATTLE then
        local showTabToggle =
        {
            [pageEnum.INFO] = self.infoToggle;
            [pageEnum.UPGRADE] = self.UpgradeToggle;
            [pageEnum.EMBATTLE] = self.GuardToggle;
        }

        showTabToggle[pageEnum.INFO]:set_value(false)
        showTabToggle[pageEnum.UPGRADE]:set_value(false)
        showTabToggle[self.currentPageIndex]:set_value(true)
    end
end

function BuildingTabPageUI:DestroyCurrent()
    if self.currentPage then
        self.currentPage:Hide()
        self.currentPage:DestroyUi()
        self.currentPage = nil
    end
end

function BuildingTabPageUI:OnClickInfoUI(value)
    if value == true then
        self:DestroyCurrent()
        self.currentPage = tabPageClass[pageEnum.INFO]:new({parent = self.centerNode})
        self.currentPageIndex = pageEnum.INFO
    end
end

function BuildingTabPageUI:OnClickGuardUI(value)
    if value == true then
        self:DestroyCurrent()
        self.currentPage = tabPageClass[pageEnum.EMBATTLE]:new({parent = self.centerNode})
        self.currentPageIndex = pageEnum.EMBATTLE
    end
end

function BuildingTabPageUI:OnClickUpgradeUI(value)
    if value == true then
        self:DestroyCurrent()
        self.currentPage = tabPageClass[pageEnum.UPGRADE]:new({parent = self.centerNode})
        self.currentPageIndex = pageEnum.UPGRADE
    end
end

function BuildingTabPageUI:OnClickRobberyUI(param)
    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()
    local bc = cbmgr:GetBuildingConfigFromID(bid)
    if bc ~= nil and bc.robbery_unlock_level ~= nil then
        if cbmgr:GetBuildingLevel(bid) < bc.robbery_unlock_level then
            HintUI.SetAndShow(EHintUiType.zero, string.format(gs_misc['str_19'], bc.name,bc.robbery_unlock_level))
        else
            if CityRobberyMgr.GetInst():GetTargetPlayer() ~= nil then
                uiManager:ReplaceUi(EUI.TargetBuildingSceneUI2)
            else
                uiManager:ReplaceUi(EUI.SearchingRobberyTargetUI)
            end
        end
    end
end

function BuildingTabPageUI:Update(dt)
    if self.currentPage and self.currentPage.Update then
        self.currentPage:Update(dt)
    end
end

function BuildingTabPageUI:DestroyUi()
    if self.ui ~= nil then    
        if uiManager:GetUICount() <= self.uiCount then
            self.currentPageIndex = nil
        end
        self:DestroyCurrent()
        self.tabPages = {}
    end
    UiBaseClass.DestroyUi(self);
end

function BuildingTabPageUI:Show()
    if not self.ui then
        return false
    end
    UiBaseClass.Show(self)

    if self.currentPage then
        self.currentPage:Show()
    end

    return true;
end

function BuildingTabPageUI:Hide()
    if not self.ui then
        return false
    end

    UiBaseClass.Hide(self)

    if self.currentPage then
        self.currentPage:Hide()
    end

    return true;
end