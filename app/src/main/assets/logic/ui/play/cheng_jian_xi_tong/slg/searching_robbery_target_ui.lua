
SearchingRobberyTargetUI = Class("SearchingRobberyTargetUI", UiBaseClass)

function SearchingRobberyTargetUI:Init()
    self.pathRes = "assetbundles/prefabs/ui/wanfa/slg/ui_2306_slg_university.assetbundle"
    UiBaseClass.Init(self, data);
end

function SearchingRobberyTargetUI:Restart()
    self:InitData()
    UiBaseClass.Restart(self, data)
end

function SearchingRobberyTargetUI:InitData()
    self.ui = nil;
    self.bindfunc = {}
end

function SearchingRobberyTargetUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["onServerSearchRobberyRet"]	   = Utility.bind_callback(self, SearchingRobberyTargetUI.onServerSearchRobberyRet);
    self.bindfunc["OnClickBack"]	   = Utility.bind_callback(self, SearchingRobberyTargetUI.OnClickBack);
end

function SearchingRobberyTargetUI:ShowNavigationBar()
    return false
end

function SearchingRobberyTargetUI:MsgRegist()
    PublicFunc.msg_regist(msg_city_building.gc_search_robbery_target_ret, self.bindfunc['onServerSearchRobberyRet'])
end

function SearchingRobberyTargetUI:MsgUnRegist()
    PublicFunc.msg_unregist(msg_city_building.gc_search_robbery_target_ret, self.bindfunc['onServerSearchRobberyRet'])
end

function  SearchingRobberyTargetUI:onServerSearchRobberyRet(ret, search_result)
    
    --do return end

    local crmgr = CityRobberyMgr.GetInst()
    if ret == 0 then 
        --app.log('search target ' .. table.tostring(target_player))
        crmgr:SetTargetInfo(search_result)
        uiManager:ReplaceUi(EUI.TargetBuildingSceneUI2)
    else
        local isSuc, str = PublicFunc.GetErrorString( ret, false )
        HintUI.SetAndShow(EHintUiType.zero, str)
        if crmgr:GetTargetPlayer() ~= nil then
            uiManager:ReplaceUi(EUI.TargetBuildingSceneUI2)
        else
            uiManager:PopUi()
        end
    end
end

function SearchingRobberyTargetUI:OnClickBack(param)
    self:CancelSearchRequest()
end

function SearchingRobberyTargetUI:CancelSearchRequest()
    local cbMgr = CityBuildingMgr.GetInst()
    --local bid = cbMgr:GetSelectedBuildingID()
    msg_city_building.cg_cancel_search_request(1000)
    local crmgr = CityRobberyMgr.GetInst()
    crmgr:ClearTarget()

    uiManager:PopUi()
end

function SearchingRobberyTargetUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    local btn = ngui.find_button(self.ui, 'btn2')
    btn:set_on_click(self.bindfunc["OnClickBack"])

    self:SendSearchRequest()

end

function SearchingRobberyTargetUI:SendSearchRequest()

    --app.log('search except ' .. table.tostring(CityRobberyMgr.GetInst():GetExceptPlayerIDs()))
    msg_city_building.cg_search_robbery_target(CityRobberyMgr.GetInst():GetExceptPlayerIDs(),1000)
end