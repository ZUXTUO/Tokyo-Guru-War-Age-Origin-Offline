ChangeAreaShow3d = Class("ChangeAreaShow3d");

-- local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d.assetbundle";
local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_002.assetbundle";

function ChangeAreaShow3d.GetResList()
	return {res}
end

function ChangeAreaShow3d.show()
	ChangeAreaShow3d.instance = ChangeAreaShow3d:new()
end

function ChangeAreaShow3d.Destroy()
	if ChangeAreaShow3d.instance then
        ChangeAreaShow3d.instance:Hide();
        ChangeAreaShow3d.instance:DestroyUi();
        ChangeAreaShow3d.instance = nil;
    end
end

function ChangeAreaShow3d.GetInstance()
	return ChangeAreaShow3d.instance
end

function ChangeAreaShow3d:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function ChangeAreaShow3d:InitData(data)
	self.pathRes = res;
	self.bindfunc = {};
end

function ChangeAreaShow3d:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function ChangeAreaShow3d:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function ChangeAreaShow3d:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function ChangeAreaShow3d:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function ChangeAreaShow3d:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function ChangeAreaShow3d:DestroyUi()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
end

function ChangeAreaShow3d:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function ChangeAreaShow3d:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("area_worship_3d_show");
	self.ui3d:set_local_position(0,1000,0)
end