EquipStarDownConfirmUI = Class("EquipStarDownConfirmUI", UiBaseClass)

local res = "assetbundles/prefabs/ui/package/ui_604_6.assetbundle"

function EquipStarDownConfirmUI:Init(data)
    self.pathRes = res

    UiBaseClass.Init(self, data)
end

function EquipStarDownConfirmUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickClose"] = Utility.bind_callback(self,self.OnClickClose);
    self.bindfunc["OnClickConfirm"] = Utility.bind_callback(self,self.OnClickConfirm)
end

function EquipStarDownConfirmUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)

    self.numberLabel = ngui.find_label(self.ui, "cont/txt/lab")
    self.confirmBtn = ngui.find_button(self.ui, "btn_yellow")
    self.closeBtn = ngui.find_button(self.ui, "btn_cha")

    
    self.confirmBtn:set_on_click(self.bindfunc["OnClickConfirm"])
    self.closeBtn:set_on_click(self.bindfunc["OnClickClose"])

    local data = self:GetInitData()
    self.numberLabel:set_text(tostring(data.cost))
end

function EquipStarDownConfirmUI:OnClickClose()
    uiManager:PopUi()
end

function EquipStarDownConfirmUI:OnClickConfirm()
    local data = self:GetInitData()

    Utility.CallFunc(data.callback)

    self:OnClickClose()
end