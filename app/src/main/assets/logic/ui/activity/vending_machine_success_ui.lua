VendingMachineSuccessUI = Class("VendingMachineSuccessUI", MultiResUiBaseClass);

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
	-- ui/new_fight
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_839_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

function VendingMachineSuccessUI.GetResList()
	return {resPaths[resType.Front], resPaths[resType.Back]}
end

function VendingMachineSuccessUI:Init(data)
    self.pathRes = resPaths
    MultiResUiBaseClass.Init(self, data);
end

function VendingMachineSuccessUI:RestartData(data)
    self.crystalNumber = data
end

function VendingMachineSuccessUI:SetEndCallback(callback)
    self.callback = callback
end

function VendingMachineSuccessUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
end

function VendingMachineSuccessUI:InitedAllUI()
    self.backui = self.uis[resPaths[resType.Back]]
	self.frontui = self.uis[resPaths[resType.Front]]

    local labRedCrystal = ngui.find_label(self.frontui, "animation/sp_di/lab")
    labRedCrystal:set_text(tostring(self.crystalNumber))

    local spTitle = ngui.find_sprite(self.backui, "sp_art_font")
    local nodeParent = self.backui:get_child_by_name("add_content")
    local btnClose = ngui.find_button(self.backui, "mark")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])

    spTitle:set_sprite_name("js_gongxihuode")
    self.frontui:set_parent( nodeParent )
end

function VendingMachineSuccessUI:DestroyUi()
    self.crystalNumber = 0
    self.callback = nil

    self.backui = nil
    self.frontui = nil
    MultiResUiBaseClass.DestroyUi(self);
end

function VendingMachineSuccessUI:Show()
    if not self.backui then return end
    self.backui:set_local_position(0, 0, 0)
end

function VendingMachineSuccessUI:Hide()
	if not self.backui then return end
	self.backui:set_local_position(100000, 0, 0)
end

function VendingMachineSuccessUI:on_btn_close(t)
    local callback = self.callback

    uiManager:PopUi()

    if callback then
        callback()
    end
end

