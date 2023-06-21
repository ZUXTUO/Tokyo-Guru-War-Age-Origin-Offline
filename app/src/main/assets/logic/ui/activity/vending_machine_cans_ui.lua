VendingMachineCansUI = Class("VendingMachineCansUI", MultiResUiBaseClass);

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
	[resType.Front] = "assetbundles/prefabs/character/yilaguan/ui_yilaguan.assetbundle";
	[resType.Back] = "assetbundles/prefabs/ui/award/ui_1146_award_tc.assetbundle";
}

function VendingMachineCansUI.GetResList()
	return {resPaths[resType.Front], resPaths[resType.Back]}
end

function VendingMachineCansUI:Init(data)
    self.pathRes = resPaths
    MultiResUiBaseClass.Init(self, data)
end

function VendingMachineCansUI:RestartData(data)
	self.callback = data
end

function VendingMachineCansUI:InitOneUI(asset_obj, filepath)
	local ui = asset_game_object.create(asset_obj)

	if filepath == resPaths[resType.Back] then
		ui:set_parent(Root.get_root_ui_2d())
		ui:set_name("ui_1146_award_tc")
		local sx,sy,sz = Utility.SetUIAdaptation()
		ui:set_local_scale(sx,sy,sz)
		ui:set_local_position(0,0,0)

	elseif filepath == resPaths[resType.Front] then
		
	end
	
    ui:set_active(false)
    self.uis[filepath] = ui
end

function VendingMachineCansUI:InitedAllUI()
	self.backui = self.uis[resPaths[resType.Back]]
	self.frontui = self.uis[resPaths[resType.Front]]

	self:CreateRenderTexture()
	--拉罐音效
	AudioManager.PlayUiAudio(81200232)
end

function VendingMachineCansUI:DestroyUi()
	if self.s3d_camera then
		self.s3d_camera:clear_camera_render_texture()
		self.s3d_camera = nil
	end
	if self.texture then
		self.texture:Destroy()
		self.texture = nil
	end
	self.callback = nil
	self.backui = nil
    self.frontui = nil
	MultiResUiBaseClass.DestroyUi(self);
end

function VendingMachineCansUI:CreateRenderTexture()
	if self.frontui then
		
		local param = {512,512,16,0}
		self.texture = ngui.find_texture(self.backui, "center_other/animation/texture")
		local w, h = self.texture:get_size()
		param[1] = w
		param[2] = h

		local renderTexture = render_texture.create(param[1], param[2], param[3],param[4]);

		self.frontui:set_name("rt_yilaguan")
		self.frontui:set_local_position(0,60,0)
		self.s3d_camera = camera.find_by_name("rt_yilaguan/camera_yalaguan");
		self.s3d_camera:set_camera_render_texture(renderTexture)
		self.texture.obj:set_render_texture(renderTexture)

		self.frontui:get_child_by_name("fx_yilaguan_001"):set_active(true)
	end

	TimerManager.Add(self.FinishRenderTexture, 1500, 1, self)
end

function VendingMachineCansUI:FinishRenderTexture()
	local callback = self.callback
	-- uiManager:PopUi()
	TimerManager.Add(function()
		uiManager:RemoveUi(EUI.VendingMachineCansUI)
	end, 30, 1)

	if callback then
		Utility.CallFunc(callback)
	end
end
