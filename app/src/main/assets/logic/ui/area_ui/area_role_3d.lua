AreaRole3d = Class("AreaRole3d");

--[[
data ={
	parent
	role_id|model_id
	load_call_back
	uiSp
}
--]]
function AreaRole3d:Init(data)
	self.panel_name = self._className
    self:InitData(data);
	self:RegistFunc();
	if self.roleId then
		self:LoadObjFromRole();
    elseif self.modelID then
        self:LoadObjFromModel()
	end
end

function AreaRole3d:InitData(data)
	self.bindfunc = {};
	self.enableScale = not data.no_scale -- 布阵界面保持原始大小
	self.parent = data.parent;
	self.roleId = data.role_id;
    self.modelID = data.model_id
	self.rot = 0;
end

function AreaRole3d:RegistFunc()
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, self.on_loaded);
	self.bindfunc["on_change_animator"] = Utility.bind_callback(self, self.on_change_animator);
    self.bindfunc["on_begin_animator"] = Utility.bind_callback(self, self.on_begin_animator);
    
end

function AreaRole3d:UnregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function AreaRole3d:ChangeObj(role_id)
	-- if self.roleId == role_id then return end
	if self.time_id1 then
		timer.stop(self.time_id1)
		self.time_id1 = nil;
	end
	if self.time_id2 then
		timer.stop(self.time_id2)
		self.time_id2 = nil;
	end
	self.roleId = role_id;
	self:LoadObjFromRole();
end

function AreaRole3d:LoadObjFromRole()
	app.log(tostring(self.roleId));
    local modelID = ConfigHelper.GetRole(self.roleId).model_id;
	if self.obj then
		self.obj:set_active(false);
		if modelID == self.modelID then
			self.time_id1 = timer.create(self.bindfunc["on_begin_animator"],100,1);
			return;
		end
		self.obj = nil;
	end
    self.modelID = modelID;

    self:LoadObjFromModel()
end

function AreaRole3d:LoadObjFromModel()

    if self.modelID == nil then
        return
    end
    local modelFile = ObjectManager.GetHighItemModelFile(self.modelID)
    if self.modelFile == modelFile then
    	return;
    end
    self.modelFile = modelFile;
	ResourceLoader.LoadAsset(self.modelFile, self.bindfunc["on_loaded"], self.panel_name)
end

function AreaRole3d:on_loaded(pid, filepath, asset_obj, error_info) 
	if self.modelFile == filepath then
		self:InitUI(asset_obj);
	end
end

function AreaRole3d:GetObj()
	return self.obj;
end

function AreaRole3d:InitUI(obj)
	if not self.parent then
		return;
	end
	if self.obj then
		self.obj:set_active(false);
	end
	

	self.obj = asset_game_object.create(obj);
    self.obj:set_parent(self.parent);
    self.obj:set_layer(PublicStruct.UnityLayer.ui3d, true);
    local navMeshAgent = self.obj:get_component_navmesh_agent()
    navMeshAgent:set_enable(false)
	--获取贴图列表
	self.modelList = {}
	local modelList = ConfigManager.Get(EConfigIndex.t_model_list,self.modelID).show_material_list;
	--app.log("1..."..table.tostring(modelList));
	if type(modelList) == "table" then
		for k, v in pairs(modelList) do
			local map = self.obj:get_child_by_name(v.list);
			if map then
				table.insert(self.modelList, map);
			end
		end
	end

    --self.obj:set_local_scale(3,3,3);
    self.obj:set_local_position(0,1,0);
    self.obj:set_local_rotation(0,0,0);
    self.obj:set_name("people"..tostring(self.modelID));

    self.parent:set_local_rotation(0,0,0);
    self.rot = 0;

    self.InvisiMateCfg = ConfigManager.Get(EConfigIndex.t_mondel_invisible_cfg,self.modelID);
    if self.InvisiMateCfg then
        self.InvisibleMaterial = asset_game_object.find("people"..tostring(self.modelID).."/"..self.InvisiMateCfg.mat_name);
        if self.InvisibleMaterial then
            self.InvisibleMaterial:set_active(false);
        end
    end
    self.obj:set_active(false)
	local camera_point = self.obj:get_child_by_name("camera_point");
	if camera_point ~= nil then 
		camera_point:set_active(false);
	end 
	local CameraHero = self.obj:get_child_by_name("CameraHero");
	if CameraHero ~= nil then 
		CameraHero:set_active(false);
	end 
    local model_id = self.modelID
    local cfg_id = ConfigManager.Get(EConfigIndex.t_model_list,model_id).ui_inspect_camera_id;
	self.cfg = ConfigManager.Get(EConfigIndex.t_ui_inspect_camera,cfg_id);
	self.time = ConfigManager.Get(EConfigIndex.t_model_list,model_id).show_frame * PublicStruct.MS_Each_Anim_Frame;
	self.time_id1 = timer.create(self.bindfunc["on_begin_animator"],100,1);
	--local cam = Root.root_s3d_camera:get_game_object();
	if self.cfg then
		self.cfg = Utility.clone(ConfigManager.Get(EConfigIndex.t_ui_inspect_camera,cfg_id));
		self.obj:set_local_position(self.cfg.x_pos,self.cfg.y_pos,self.cfg.z_pos);
		--self.obj:set_local_rotation(self.cfg.x_rot,self.cfg.y_rot,self.cfg.z_rot);
	else
		self.cfg = Utility.clone(ConfigManager.Get(EConfigIndex.t_ui_inspect_camera,1));
		self.obj:set_local_position(self.cfg.x_pos,self.cfg.y_pos,self.cfg.z_pos);
		--self.obj:set_local_rotation(self.cfg.x_rot,self.cfg.y_rot,self.cfg.z_rot);
	end
	--TODO::....
	if self.enableScale then
		local sx, sy, sz = self.parent:get_local_scale()
		sx, sy, sz = 1,1,1 --1.0/sx, 1.0/sy, 1.0/sz;
		self.obj:set_local_scale(self.cfg.x_size*sx,self.cfg.y_size*sy,self.cfg.z_size*sz);
	end
	-- self.obj:set_local_position(0,0.8,0);
	self.obj:set_local_rotation(90,0,0);
	--Root.get_s3d_cube():set_rotation(0,180,0);
	if self.loadCallBack ~= nil then
		Utility.CallFunc(self.loadCallBack,self.obj);
	end
end

function AreaRole3d:ShowObj(isShow)
	if self.obj then
		self.obj:set_active(isShow);
	end
end

function AreaRole3d:Show(isShow)
	if self.uiTexture then
		self.uiTexture:set_active(isShow);
	end
end

function AreaRole3d:on_change_animator()
	if self.obj and self.time_id2 then
		self.time_id2 = nil;
		app.log("change anim"..tostring(self.obj:get_name()))
		self.obj:animator_play(PublicFunc.GetAniFSMName(EANI.showstand,self.modelID));
	end
end

function AreaRole3d:on_begin_animator()
	if self.obj and self.time_id1 then
		app.log("play begin anim"..tostring(self.obj:get_name()))
		self.time_id1 = nil;
		self.obj:set_active(true);
		self.obj:animator_play(PublicFunc.GetAniFSMName(EANI.show,self.modelID));
		self.time_id2 = timer.create(self.bindfunc["on_change_animator"],self.time,1);
	end
end

function AreaRole3d:Destroy()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	self.parent = nil;
	if self.time_id1 then
		timer.stop(self.time_id1);
		self.time_id1 = nil;
	end
	if self.time_id2 then
		timer.stop(self.time_id2);
		self.time_id2 = nil;
	end
	if self.obj then
		self.obj:set_active(false);
		self.obj=nil;
	end
	if self.uiTexture then
		self.uiTexture:Destroy();
		self.uiTexture = nil;
	end
	self.modelID = nil;
	self.roleId = nil;
	self.modelFile = nil;
	self:UnregistFunc();
end