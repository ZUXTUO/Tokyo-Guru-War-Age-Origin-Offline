TongTianTa3D = Class("TongTianTa3D");

local path = {};
path[1] = "";
path[2] = "";
path[3] = "";

function TongTianTa3D.SetAndShow(data)
    if TongTianTa3D.instance then
		TongTianTa3D.instance:UpdateData(data);
	else
		TongTianTa3D.instance = TongTianTa3D:new(data)
	end
end

function TongTianTa3D.Destroy()
	if TongTianTa3D.instance then
        TongTianTa3D.instance:Hide();
        TongTianTa3D.instance:DestroyUi();
        TongTianTa3D.instance = nil;
    end
end

function TongTianTa3D.GetInstance()
	return TongTianTa3D.instance
end

function TongTianTa3D:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function TongTianTa3D:InitData(data)
	-- self.pathRes = res2;
	self.bindfunc = {};
	self.ui3d = {};
	if not data then return end
end

function TongTianTa3D:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function TongTianTa3D:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function TongTianTa3D:LoadAsset()
	for i=1,6 do
		ResourceLoader.LoadAsset(res[i], self.bindfunc['on_loaded'], self.panel_name);
	end
end

function TongTianTa3D:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function TongTianTa3D:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function TongTianTa3D:DestroyUi()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
end

function TongTianTa3D:on_loaded(pid, filepath, asset_obj, error_info)
	-- if filepath == self.pathRes then
		self:InitUI(asset_obj,filepath);
	-- end
end

function TongTianTa3D:InitUI(obj,filepath)
	self.ui3d[filepath] = asset_game_object.create(obj);
	self.ui3d[filepath]:set_name("TongTianTa3D");
end

function TongTianTa3D:UpdateData(data)
end

