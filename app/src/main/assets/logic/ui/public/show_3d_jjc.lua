Show3dJJC = Class("Show3dJJC");

local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_004.assetbundle";

function Show3dJJC.GetResList()
	return {res}
end

function Show3dJJC.SetAndShow(data)
    if Show3dJJC.instance then
		Show3dJJC.instance:UpdateData(data);
	else
		Show3dJJC.instance = Show3dJJC:new(data)
	end
end

function Show3dJJC.SetLoadCallBack(callback)
	local self = Show3dJJC.instance
	if self then
		self.loadOkCallback = callback
		if self.role3d then
			self.role3d:SetLoadCallBack(self.loadOkCallback)
		end
	end
end

function Show3dJJC.Destroy()
    if Show3dJJC.instance then
        Show3dJJC.instance:Hide();
        Show3dJJC.instance:DestroyUi();
        Show3dJJC.instance = nil;
    end
end

function Show3dJJC.GetInstance()
	return Show3dJJC.instance
end

function Show3dJJC.SetVisible(bool)
	if Show3dJJC.instance then
		Show3dJJC.instance:SetVisibleRole3d(bool)
	end
end

function Show3dJJC:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function Show3dJJC:InitData(data)
	self.pathRes = res;
	self.bindfunc = {};
	if not data then return end
	self.roleData = data.roleData;
	self.role3d_ui_touch = data.role3d_ui_touch;
	self.callback = data.callback;
	self.isGray = data.isGray;
end

function Show3dJJC:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function Show3dJJC:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function Show3dJJC:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function Show3dJJC:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function Show3dJJC:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function Show3dJJC:DestroyUi()
    self:UnRegistFunc()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
	if self.role3d then
		self.role3d:Destroy();
		self.role3d = nil;
	end
	self.visibleRole3d = nil;
end

function Show3dJJC:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function Show3dJJC:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("role_3d_show_jjc");

    local leftObj = self.ui3d:get_child_by_name("role3d_left")

	self.ui3d_root = leftObj:get_child_by_name("can_move")
	leftObj:set_active(true)
	local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root)
	
	local objCamera = leftObj:get_child_by_name("role_camera")
	local x1, y1, z1 = objCamera:get_local_position()
	local x, y, z = self.ui3d_root:get_local_position()
	self.ui3d_root:set_local_position(x1 + (x - x1)*scaleModel, y * scaleModel * scaleModel, z);


    if not self.ui3d_root then return end
    if self.roleData then
        self.role3d = Role3d:new({parent = self.ui3d_root,role_id = self.roleData.number,load_call_back= self.callback,uiSp = self.role3d_ui_touch, isGray = self.isGray});
    else
        self.role3d = Role3d:new({parent = self.ui3d_root,load_call_back= self.callback,uiSp = self.role3d_ui_touch});
    end

	self.role3d:SetLoadCallBack(self.loadOkCallback)

	if self.visibleRole3d ~= nil then
		self:SetVisibleRole3d(self.visibleRole3d)
	end
end

function Show3dJJC:UpdateData(data)
	if data.roleData and self.roleid == data.roleData.number then
		return  
	end
	self.roleData = data.roleData
	self.isGray = data.isGray;
        
	if data.roleData then
		self.roleid = data.roleData.number; 
	else
		self.roleid = 0;
	end
        
	if self.ui3d_root == nil or self.role3d == nil then return end

	if self.roleData then
		local role_id = data.roleData.number;
		self.role3d:ChangeObj(role_id);
		self.role3d:SetGray(self.isGray);
		self:Show();
	else
		self.role3d:Destroy()
		self.role3d = Role3d:new({parent = self.ui3d_root,load_call_back= self.callback,uiSp = self.role3d_ui_touch});
		self.role3d:SetGray(self.isGray);
	end

	self.role3d:SetLoadCallBack(self.loadOkCallback)

	if self.visibleRole3d ~= nil then
		self:SetVisibleRole3d(self.visibleRole3d)
	end
end

function Show3dJJC:SetVisibleRole3d(bVisible)
	self.visibleRole3d = (bVisible == true)
	if self.role3d then
		self.role3d:ShowObj(self.visibleRole3d)
	end
end
