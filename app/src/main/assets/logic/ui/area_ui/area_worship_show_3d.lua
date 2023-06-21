AreaWorshipShow3d = Class("AreaWorshipShow3d");

-- local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d.assetbundle";
local res = "assetbundles/prefabs/map/056_niudanbeij/056_niudanbeij.assetbundle";

function AreaWorshipShow3d.GetResList()
	return {res}
end

function AreaWorshipShow3d.SetAndShow(data)
    if AreaWorshipShow3d.instance then
		AreaWorshipShow3d.instance:UpdateData(data);
	else
		AreaWorshipShow3d.instance = AreaWorshipShow3d:new(data)
	end
end

function AreaWorshipShow3d.Destroy()
	if AreaWorshipShow3d.instance then
        AreaWorshipShow3d.instance:Hide();
        AreaWorshipShow3d.instance:DestroyUi();
        AreaWorshipShow3d.instance = nil;
    end
end

function AreaWorshipShow3d.GetInstance()
	return AreaWorshipShow3d.instance
end

function AreaWorshipShow3d:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function AreaWorshipShow3d:InitData(data)
	self.pathRes = res;
	self.bindfunc = {};
	if not data then return end
	self.roleData = data.roleData;
end

function AreaWorshipShow3d:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function AreaWorshipShow3d:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function AreaWorshipShow3d:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function AreaWorshipShow3d:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function AreaWorshipShow3d:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function AreaWorshipShow3d:DestroyUi()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
	if self.role3ds then
		self.role3ds[1][1]:Destroy();
		self.role3ds[2][1]:Destroy();
		self.role3ds[3][1]:Destroy();
		self.role3ds[1][2]:Destroy();
		self.role3ds[2][2]:Destroy();
		self.role3ds[3][2]:Destroy();
		self.role3ds[1][3]:Destroy();
		self.role3ds[2][3]:Destroy();
		self.role3ds[3][3]:Destroy();
		self.role3ds = nil;
	end
end

function AreaWorshipShow3d:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function AreaWorshipShow3d:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("area_worship_3d_show");
	self.ui3d:set_local_position(0,1000,0)
	local no1 = self.ui3d:get_child_by_name("NO1");
	local no2 = self.ui3d:get_child_by_name("NO2");
	local no3 = self.ui3d:get_child_by_name("NO3");
	self.noCenter1 = no1:get_child_by_name("mid");
	self.noLeft1 = no1:get_child_by_name("left");
	self.noRight1 = no1:get_child_by_name("rigt");
	self.noCenter2 = no2:get_child_by_name("mid");
	self.noLeft2 = no2:get_child_by_name("left");
	self.noRight2 = no2:get_child_by_name("rigt");
	self.noCenter3 = no3:get_child_by_name("mid");
	self.noLeft3 = no3:get_child_by_name("left");
	self.noRight3 = no3:get_child_by_name("rigt");
	self.role3ds = {};
	self.role3ds[1] = {};
	self.role3ds[2] = {};
	self.role3ds[3] = {};
	self.role3ds[1][1] = AreaRole3d:new({parent = self.noCenter1});
    self.role3ds[1][2] = AreaRole3d:new({parent = self.noLeft1});
    self.role3ds[1][3] = AreaRole3d:new({parent = self.noRight1});
    self.role3ds[2][1] = AreaRole3d:new({parent = self.noCenter2});
    self.role3ds[2][2] = AreaRole3d:new({parent = self.noLeft2});
    self.role3ds[2][3] = AreaRole3d:new({parent = self.noRight2});
    self.role3ds[3][1] = AreaRole3d:new({parent = self.noCenter3});
    self.role3ds[3][2] = AreaRole3d:new({parent = self.noLeft3});
    self.role3ds[3][3] = AreaRole3d:new({parent = self.noRight3});
	app.log("((((((((((((()))))))))))))");
	app.log("self.roleData:"..table.tostring(self.roleData));
    if self.roleData then
		for k,v in pairs(self.roleData) do 
			if #v.vecCardNum == 1 then 
				self.role3ds[k][1]:ChangeObj(v.vecCardNum[1]);
			elseif #v.vecCardNum == 2 then 
				self.role3ds[k][2]:ChangeObj(v.vecCardNum[1]);
				self.role3ds[k][3]:ChangeObj(v.vecCardNum[2]);
			elseif #v.vecCardNum == 3 then  
				self.role3ds[k][1]:ChangeObj(v.vecCardNum[1]);
				self.role3ds[k][2]:ChangeObj(v.vecCardNum[2]);
				self.role3ds[k][3]:ChangeObj(v.vecCardNum[3]);
			end
		end 
    end
end

function AreaWorshipShow3d:UpdateData(data)
	self.roleData = data.roleData
	if self.ui3d == nil or self.role3ds == nil then return end

	if self.roleData then
		for k,v in pairs(self.roleData) do 
			if #v.vecCardNum == 1 then 
				self.role3ds[k][1]:ChangeObj(v.vecCardNum[1]);
			elseif #v.vecCardNum == 2 then 
				self.role3ds[k][2]:ChangeObj(v.vecCardNum[1]);
				self.role3ds[k][3]:ChangeObj(v.vecCardNum[2]);
			elseif #v.vecCardNum == 3 then  
				self.role3ds[k][1]:ChangeObj(v.vecCardNum[1]);
				self.role3ds[k][2]:ChangeObj(v.vecCardNum[2]);
				self.role3ds[k][3]:ChangeObj(v.vecCardNum[3]);
			end	
		end
		self:Show();
	else
		self.role3ds[1][1]:ChangeObj();
		self.role3ds[1][2]:ChangeObj();
		self.role3ds[1][3]:ChangeObj();
		self.role3ds[2][1]:ChangeObj();
		self.role3ds[2][2]:ChangeObj();
		self.role3ds[2][3]:ChangeObj();
		self.role3ds[3][1]:ChangeObj();
		self.role3ds[3][2]:ChangeObj();
		self.role3ds[3][3]:ChangeObj();
		--self.role3d = Role3d:new({parent = self.ui3d_root,load_call_back= self.callback,uiSp = self.role3d_ui_touch});
	end
end