QingTongJiDi3D = Class("QingTongJiDi3D");

local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_006.assetbundle";

function QingTongJiDi3D.GetResList()
	return {res}
end

function QingTongJiDi3D.SetAndShow(data)
    if QingTongJiDi3D.instance then
		QingTongJiDi3D.instance:UpdateData(data);
	else
		QingTongJiDi3D.instance = QingTongJiDi3D:new(data)
	end
end

function QingTongJiDi3D.Destroy()
	if QingTongJiDi3D.instance then
        QingTongJiDi3D.instance:Hide();
        QingTongJiDi3D.instance:DestroyUi();
        QingTongJiDi3D.instance = nil;
    end
end

function QingTongJiDi3D.GetInstance()
	return QingTongJiDi3D.instance
end

function QingTongJiDi3D:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function QingTongJiDi3D:InitData(data)
	self.pathRes = res;
	self.bindfunc = {};
	self.role3d = {};
	if not data then return end
	self.roleData = data or {};
end

function QingTongJiDi3D:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function QingTongJiDi3D:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function QingTongJiDi3D:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function QingTongJiDi3D:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function QingTongJiDi3D:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function QingTongJiDi3D:DestroyUi()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
	for i=1,3 do
		if self.role3d[i] then
			self.role3d[i]:Destroy();
			self.role3d[i] = nil;
		end
	end
	self.role3d = {};
end

function QingTongJiDi3D:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function QingTongJiDi3D:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("role_3d_qtjd");
	self.ui3d_root = {};
	self.ui3d_root[1] = {};
	self.ui3d_root[1].nodeRole = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_mid");
	self.ui3d_root[2] = {};
	self.ui3d_root[2].nodeRole = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_left");
	self.ui3d_root[3] = {};
	self.ui3d_root[3].nodeRole = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_right");

	local x1,y1,z1 = self.ui3d_root[1].nodeRole:get_local_position();
	local x2,y2,z2 = self.ui3d_root[2].nodeRole:get_local_position();
	local x3,y3,z3 = self.ui3d_root[3].nodeRole:get_local_position();

	local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root[1].nodeRole) 
    scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root[2].nodeRole) 
	self.ui3d_root[2].nodeRole:set_local_position(x1 + (x2 - x1)*scaleModel,y2,z2);
    scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root[3].nodeRole) 
	self.ui3d_root[3].nodeRole:set_local_position(x1 + (x3 - x1)*scaleModel,y3,z3);
    
    self:UpdateData(self.roleData)
end

function QingTongJiDi3D:UpdateData(data)
	if data == nil then return end

	self.roleData = data
	if self.ui3d then
		for i=1,3 do
			if self.roleData[i] then
				if self.role3d[i] == nil then
					self.role3d[i] = Role3d:new({parent = self.ui3d_root[i].nodeRole,role_id = self.roleData[i].image,no_cfg_pos=true});
				else
					if self.roleData[i].image ~= self.role3d[i].roleId then
						self.role3d[i]:ChangeObj(self.roleData[i].image);
					end
					self.role3d[i]:ShowObj(true);
				end
			else
				if self.role3d[i] then
					self.role3d[i]:ShowObj(false);
				end
			end
		end
	end
	self:Show();
end
