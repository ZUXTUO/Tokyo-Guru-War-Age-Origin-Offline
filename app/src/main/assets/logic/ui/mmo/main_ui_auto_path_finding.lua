
MainUIAutoPathFinding = Class('MainUIAutoPathFinding', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/panel_auto_way.assetbundle"

function MainUIAutoPathFinding.GetResList()
    return {res}
end

function MainUIAutoPathFinding:Init(data)
    self.pathRes = res
	UiBaseClass.Init(self, data);
end

function MainUIAutoPathFinding:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['ShowAnimation'] = Utility.bind_callback(self, self.ShowAnimation)
end

function MainUIAutoPathFinding:MsgRegist()
	PublicFunc.msg_regist("AutoPathFinding_Start_Find", self.bindfunc['ShowAnimation'])
end

function MainUIAutoPathFinding:MsgUnRegist()
	PublicFunc.msg_unregist("AutoPathFinding_Start_Find", self.bindfunc['ShowAnimation'])
end

function MainUIAutoPathFinding:ShowAnimation(is_show)
    if is_show then
        self:Show()
    else
        self:Hide()
    end
end

function MainUIAutoPathFinding:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("panel_auto_way")
    self:Hide()
end