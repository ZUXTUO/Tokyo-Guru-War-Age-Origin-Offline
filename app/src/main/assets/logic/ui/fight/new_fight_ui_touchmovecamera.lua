
NewFightUITouchMoveCamera = Class('NewFightUITouchMoveCamera', UiBaseClass)

local resPath = 'assetbundles/prefabs/ui/fight/new_fight_ui_mark.assetbundle'

function NewFightUITouchMoveCamera.GetResList()
    return {resPath}
end

function NewFightUITouchMoveCamera:Init(data)
    self.pathRes = resPath;
    UiBaseClass.Init(self, data);
end

function NewFightUITouchMoveCamera:InitData(data)
    UiBaseClass.InitData(self, data);
    self.showLock = false;
end

function NewFightUITouchMoveCamera:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self:SetTouchMoveEnable()
end

function NewFightUITouchMoveCamera:SetTouchMoveEnable()
	if not self.ui then return end

	local btn = ngui.find_button(self.ui, 'sp_di')
    CameraManager.EnterTouchMoveMode(nil, btn, false, false)
end