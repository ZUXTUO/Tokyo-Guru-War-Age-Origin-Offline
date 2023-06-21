Formation3D = Class("Formation3D");

local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_001.assetbundle";

function Formation3D.GetResList()
	return {res}
end

function Formation3D.SetAndShow(data)
    if Formation3D.instance then
		Formation3D.instance:UpdateData(data);
	else
		Formation3D.instance = Formation3D:new(data)
	end
end

function Formation3D.Destroy()
	if Formation3D.instance then
        Formation3D.instance:Hide();
        Formation3D.instance:DestroyUi();
        Formation3D.instance = nil;
    end
end

function Formation3D.GetInstance()
	return Formation3D.instance
end

function Formation3D:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function Formation3D:InitData(data)
	self.pathRes = res;
	self.bindfunc = {};
	self.role3d = {};
	self.choseEffect = {};
	self.noHeroEffect = {};
	if not data then return end
	self.roleData = data.roleData or {};
	self.callback = data.callback;
	self.roleNum = data.roleNum or 3;
end

function Formation3D:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function Formation3D:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function Formation3D:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function Formation3D:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function Formation3D:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function Formation3D:DestroyUi()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
	for k,list in pairs(self.choseEffect) do
		for id,v in pairs(list) do
			EffectManager.deleteEffect(id);
		end
		self.choseEffect[k] = nil;
	end
	for k,list in pairs(self.noHeroEffect) do
		for id,v in pairs(list) do
			EffectManager.deleteEffect(id);
		end
		self.noHeroEffect[k] = nil;
	end
	for i=1,3 do
		if self.role3d[i] then
			self.role3d[i]:Destroy();
			self.role3d[i] = nil;
		end
	end
	self.role3d = {};
end

function Formation3D:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function Formation3D:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("role_3d_show");
	self.ui3d_root = {};
	self.ui3d_root[1] = {};
	self.ui3d_root[1].nodeRole = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_mid");
	self.ui3d_root[1].nodeEffect = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_mid");
	-- self.ui3d_root[1].nodeModel = self.ui3d:get_child_by_name("not_move/P_jiaotang (1)");
	self.ui3d_root[2] = {};
	self.ui3d_root[2].nodeRole = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_left");
	self.ui3d_root[2].nodeEffect = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_left");
	-- self.ui3d_root[2].nodeModel = self.ui3d:get_child_by_name("not_move/P_jiaotang");
	self.ui3d_root[3] = {};
	self.ui3d_root[3].nodeRole = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_right");
	self.ui3d_root[3].nodeEffect = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001_right");

	-- self.ui3d_root[3].nodeModel = self.ui3d:get_child_by_name("not_move/P_jiaotang (2)");
	local x1,y1,z1 = self.ui3d_root[1].nodeRole:get_local_position();
	local x2,y2,z2 = self.ui3d_root[2].nodeRole:get_local_position();
	local x3,y3,z3 = self.ui3d_root[3].nodeRole:get_local_position();

	--app.log("screenWidth = "..tostring(app.get_screen_width()).." screenHeight = "..tostring(app.get_screen_height()).." scaleModel = "..tostring(scaleModel));
	--app.log(table.tostring({{x1,x2,x3},{y1,y2,y3},{z1,z2,z3}}));
    local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root[1].nodeRole) 
    scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root[2].nodeRole) 
    scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root[3].nodeRole) 
    
	--app.log("left posx = "..tostring(x1 + (x2 - x1)*scaleModel));
	--app.log("right posx = "..tostring(x1 + (x3 - x1)*scaleModel));
	self.ui3d_root[1].nodeRole:set_local_position(x1,y1*scaleModel,z1);
	self.ui3d_root[2].nodeRole:set_local_position(x1 + (x2 - x1)*scaleModel,y2*scaleModel,z2);
	self.ui3d_root[3].nodeRole:set_local_position(x1 + (x3 - x1)*scaleModel,y3*scaleModel,z3);

	self.ui_plane = self.ui3d:get_child_by_name("Plane")
	if self.ui_plane then
		local x, y, z = self.ui_plane:get_local_position();
		self.ui_plane:set_local_position(x,y*scaleModel,z)
	end
	
    for i=1,3 do
    	if i <= self.roleNum then
    		self.ui3d_root[i].nodeEffect:set_active(true);
    		-- self.ui3d_root[i].nodeModel:set_active(true);
		    if self.roleData[i] then
		        self.role3d[i] = Role3d:new({parent = self.ui3d_root[i].nodeRole,role_id = self.roleData[i].number,load_call_back= self.callback,no_cfg_pos=true});
		        -- self:SetNoHeroEffect(i,false);
		    else
		        self.role3d[i] = Role3d:new({parent = self.ui3d_root[i].nodeRole,load_call_back= self.callback,no_cfg_pos=true});
		        -- self:SetNoHeroEffect(i,true);
		    end
		else
    		self.ui3d_root[i].nodeEffect:set_active(false);
    		-- self.ui3d_root[i].nodeModel:set_active(false);
		end
	end
end

function Formation3D:UpdateData(data)
	if data and data.roleData then
		self.roleNum = data.roleNum;
		if self.ui3d then
			for i=1,3 do
				if i <= self.roleNum then
					self.ui3d_root[i].nodeEffect:set_active(true);
		    		-- self.ui3d_root[i].nodeModel:set_active(true);
		    		if self.role3d[i] and data.roleData[i] then
		    			local role_id = data.roleData[i].number;
		    			if not self.roleData[i] or self.roleData[i].number ~= role_id then
		    				self.role3d[i]:ChangeObj(role_id);
		    			end
						-- self.role3d[i]:ShowObj(true);
						-- self:SetNoHeroEffect(i,false);
					else
						self.role3d[i]:ShowObj(false);
						-- self:SetNoHeroEffect(i,true);
					end
				else
					self.ui3d_root[i].nodeEffect:set_active(false);
					-- self.ui3d_root[i].nodeModel:set_active(false);
				end
			end
		end
		self:Show();
		self.roleData = data.roleData;
	end
end

function Formation3D:SetChoseEffect(pos,isShow)
	do return end;
	if not self.choseEffect[pos] and isShow then
		local ids = FightScene.CreateEffect({x=0,y=0,z=0}, ConfigManager.Get(EConfigIndex.t_effect_data,19011), nil, nil, nil, nil, 0, nil, nil, nil)
		for k,id in pairs(ids) do
			self.choseEffect[pos] = {};
			self.choseEffect[pos][id] = EffectManager.GetEffect(id);
			self.choseEffect[pos][id]:set_parent(self.ui3d_root[pos].nodeEffect);
		end
	end
	if self.choseEffect[pos] then
		for k,effect in pairs(self.choseEffect[pos]) do
			effect:set_active(isShow);
		end
	end
end

function Formation3D:SetNoHeroEffect(pos,isShow)
	if not self.noHeroEffect[pos] and isShow then
		local ids = FightScene.CreateEffect({x=0,y=0,z=0}, ConfigManager.Get(EConfigIndex.t_effect_data,19012), nil, nil, nil, nil, 0, nil, nil, nil)
		for k,id in pairs(ids) do
			self.noHeroEffect[pos] = {};
			self.noHeroEffect[pos][id] = EffectManager.GetEffect(id);
			self.noHeroEffect[pos][id]:set_parent(self.ui3d_root[pos].nodeEffect);
		end
	end
	if self.noHeroEffect[pos] then
		for k,effect in pairs(self.noHeroEffect[pos]) do
			effect:set_active(isShow);
		end
	end
end
