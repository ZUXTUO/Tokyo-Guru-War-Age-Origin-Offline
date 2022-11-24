HeroTrial3D = Class("HeroTrial3D");

local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_007.assetbundle";

function HeroTrial3D.GetResList()
	return {res}
end

function HeroTrial3D.SetAndShow(data)
    if HeroTrial3D.instance then
		HeroTrial3D.instance:UpdateData(data);
	else
		HeroTrial3D.instance = HeroTrial3D:new(data)
	end
end

function HeroTrial3D.Destroy()
	if HeroTrial3D.instance then
        HeroTrial3D.instance:DestroyUi();
        HeroTrial3D.instance = nil;
    end
end

function HeroTrial3D.GetInstance()
	return HeroTrial3D.instance
end

function HeroTrial3D:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function HeroTrial3D:InitData(data)
	self.pathRes = res;
	self.bindfunc = {};
	if not data then return end
	self.data = data;
end

function HeroTrial3D:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function HeroTrial3D:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function HeroTrial3D:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function HeroTrial3D:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function HeroTrial3D:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function HeroTrial3D:DestroyUi()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
	if self.role3d then
		self.role3d:Destroy();
		self.role3d = nil;
	end
end

function HeroTrial3D:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function HeroTrial3D:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("role_3d_hero_trial");
	self.ui3d_root = self.ui3d:get_child_by_name("can_move");
	self.shadow_plane = self.ui3d:get_child_by_name("Plane")

	local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root)
	local objCamera = self.ui3d:get_child_by_name("role_camera")
	local x1, y1, z1 = objCamera:get_local_position()
	local x, y, z = self.ui3d_root:get_local_position()
	self.ui3d_root:set_local_position(x1 + (x - x1)*scaleModel, y * scaleModel * scaleModel, z);

	local ui3d_root_y = y * scaleModel * scaleModel
	x, y, z = self.shadow_plane:get_local_position()
	self.shadow_plane:set_local_position(x, ui3d_root_y, z)
    
    self:UpdateData(self.data)
end

function HeroTrial3D:UpdateData(data)
	if data == nil then return end

	self.data = data
	if self.ui3d_root and self.data and self.data.number then
		if self.role3d == nil then
			self.role3d = Role3d:new({parent = self.ui3d_root,role_id = self.data.number, uiSp = self.data.spTouch, no_cfg_pos = true, enableAppearAudio = true});
		else
			if self.data.number ~= self.role3d.roleId then
				self.role3d:ChangeObj(self.data.number);
			end
			self.role3d:ShowObj(true);
		end
	else
		if self.role3d then
			self.role3d:ShowObj(false);
		end
	end
end
