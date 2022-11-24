--[[

SLGSearchTargetCostUI = Class('SLGSearchTargetCostUI', UiBaseClass)


local resPath = "assetbundles/prefabs/ui/wanfa/slg/ui_2313_slg_university.assetbundle"

function SLGSearchTargetCostUI:Init(data)
    self.pathRes = resPath
    UiBaseClass.Init(self, data);
end

function SLGSearchTargetCostUI:InitData(data)
    UiBaseClass.InitData(self, data)

end

function SLGSearchTargetCostUI:OnClose()
    uiManager:PopUi();
end

function SLGSearchTargetCostUI:OnClickSearch()
    uiManager:ReplaceUi(EUI.SearchingRobberyTargetUI)
end

function SLGSearchTargetCostUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["OnClose"] = Utility.bind_callback(self, SLGSearchTargetCostUI.OnClose)
    self.bindfunc["OnClickSearch"] = Utility.bind_callback(self, SLGSearchTargetCostUI.OnClickSearch)
end

function SLGSearchTargetCostUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    local btn = ngui.find_button(self.ui, 'mark')
    btn:set_on_click(self.bindfunc["OnClose"])
    btn = ngui.find_button(self.ui, 'btn_fork')
    btn:set_on_click(self.bindfunc["OnClose"])

    local label = ngui.find_label(self.ui, 'button/lab_num')
    label:set_text("200")
    btn = ngui.find_button(label:get_parent(), 'button')
    btn:set_on_click(self.bindfunc["OnClickSearch"])

    label = ngui.find_label(self.ui, 'lab')
    label:set_text(string.format(gs_misc['str_34'], CityBuildingMgr.GetInst():GetFightScore()))

end

]]