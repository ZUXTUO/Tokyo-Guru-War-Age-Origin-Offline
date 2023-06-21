Show3dText = Class("Show3dText", UiBaseClass);

--------------------外部接口-------------------------
function Show3dText.Start()
	if Show3dText.cls == nil then
		Show3dText.cls = Show3dText:new();
	end
end

function Show3dText.GetCameraObj()
	if Show3dText.cls then
		return Show3dText.cls.ui;
	end
end

function Show3dText.GetCameraRotation()
	if Show3dText.cls and Show3dText.cls.cameraObj then
		return Show3dText.cls.cameraObj:get_local_rotation()
	end
	return 0,0,0
end

function Show3dText.Destroy()
	if Show3dText.cls then
		Show3dText.cls:DestroyUi();
		Show3dText.cls = nil;
	end
end

function Show3dText.SetShow(isShow)
	if Show3dText.cls then
		if isShow then
			Show3dText.cls:Show();
		else
			Show3dText.cls:Hide();
		end
	end
end

--------------------内部接口-------------------------
function Show3dText:Init(data)
	self.pathRes = "assetbundles/prefabs/3dui/ui_3d.assetbundle";
	UiBaseClass.Init(self, data);
end

function Show3dText:InitData(data)
	UiBaseClass.InitData(self, data);
    
end

function Show3dText:RegistFunc()
    UiBaseClass.RegistFunc(self);
end

function Show3dText:InitUI(asset_obj)
	self.ui = asset_game_object.create(asset_obj);
	self.camera = camera.find_by_name("ui_3d_camera");
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_local_position(0,0,0);
	self.ui:set_name("Show3dText");
	self:Hide();
	asset_game_object.dont_destroy_onload(self.ui);

	
	self.cameraObj = self.camera:get_game_object();
	self.cameraObj:set_layer(PublicStruct.UnityLayer.ngui, false);

	
	Root.AddLateUpdate(Show3dText.UpdateUi, self);
end

function Show3dText:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return;
	end
	local fightCameraObj = CameraManager.GetSceneCameraObj();
	if not fightCameraObj then
		return;
	end
	local px,py,pz = fightCameraObj:get_position();
	local rx,ry,rz = fightCameraObj:get_local_rotation();
	if px and type(px) == "number" then
		self.cameraObj:set_position(px, py, pz);
		self.cameraObj:set_local_rotation(rx, ry, rz);
	end
end

function Show3dText:DestroyUi()
	UiBaseClass.DestroyUi(self);
	Root.DelLateUpdate(Show3dText.UpdateUi);
end
