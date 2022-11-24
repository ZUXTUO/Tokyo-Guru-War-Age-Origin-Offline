ShowRole = Class("ShowRole");

--[[
data ={
	parent
	role_id|model_id
	load_call_back
}
--]]
function ShowRole:Init(data)
	data = data or {};
	self.panel_name = self._className
    self:InitData(data);
	self:RegistFunc();
	if self.roleId then
		self:LoadObjFromRole();
    elseif self.modelID then
        self:LoadObjFromModel()
	end
end

function ShowRole:InitData(data)
	self.bindfunc = {};
	self.parent = data.parent;
	self.roleId = data.role_id;
    self.modelID = data.model_id
	self.loadCallBack = data.load_call_back;
end

function ShowRole:RegistFunc()
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, self.on_loaded);
    
end

function ShowRole:UnregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function ShowRole:SetLoadCallBack(load_call_back)
	self.loadCallBack = load_call_back
end

function ShowRole:ChangeObj(role_id)
	if self.roleId == role_id then return end
	self.roleId = role_id;
	self:LoadObjFromRole();
end

function ShowRole:ChangeObjByModelID(model_id)
	if self.modelID == model_id then return end
	self.modelID = model_id;
	self:LoadObjFromModel();
end

function ShowRole:SetClickCallback(func)
	self.clickCallback = func;
end

function ShowRole:LoadObjFromRole()
    local modelID = ConfigHelper.GetRole(self.roleId).model_id;
	self:ChangeObjByModelID(modelID);
end

function ShowRole:LoadObjFromModel()
    if self.modelID == nil then
        return
    end
    if self.obj then
		self.obj:set_active(false);
		self.obj = nil;
	end
    local modelFile = ObjectManager.GetHeroModelFileByModelId(self.modelID);
    if self.modelFile == modelFile then
    	return;
    end
    self.modelFile = modelFile;
	ResourceLoader.LoadAsset(self.modelFile, self.bindfunc["on_loaded"], self.panel_name)
end

function ShowRole:on_loaded(pid, filepath, asset_obj, error_info) 
	if self.modelFile == filepath then
		self:InitUI(asset_obj);
	end
end

function ShowRole:GetObj()
	return self.obj;
end

function ShowRole:InitUI(obj)
	if self.obj then
		self.obj:set_active(false);
	end
	self.obj = asset_game_object.create(obj);
	self.obj:disable_lightprobe_effect();
    self.obj:set_parent(self.parent);
    self.obj:set_layer(PublicStruct.UnityLayer.ui3d, true);
    local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,3)
    local bp_node = self.obj:get_child_by_name(bind_pos.bind_pos_name);
    bp_node:create_fast_shadows();
    if self.rot then
    	self.obj:set_rotation(self.rot.x, self.rot.y, self.rot.z);
    end
    if self.scale then
    	self.obj:set_local_scale(self.scale.x, self.scale.y, self.scale.z);
    end
    if self.pos then
    	self.obj:set_local_position(self.pos.x, self.pos.y, self.pos.z);
    else
    	self.obj:set_local_position(0, 0, 0);
    end
    if self.animName then
    	self.obj:animator_play(self.animName)
	end
    local navMeshAgent = self.obj:get_component_navmesh_agent()
    navMeshAgent:set_enable(false)

 --    local cfg = ConfigManager.Get(EConfigIndex.t_model_list, self.modelID);
 --    if cfg.material_list and cfg.material_list ~= 0 then
	--     for k,v in pairs(cfg.material_list) do
	--     	if v.list then
	--     		local objBody = self.obj:get_child_by_name(v.list);
	--     		if objBody then
	--     			objBody:set_material_float_with_name("_EdgeThickness",1);
	--     		end
	--     	end
	--     end
	-- end

    self.obj:set_name("people"..tostring(self.modelID));
	

    self.InvisiMateCfg = ConfigManager.Get(EConfigIndex.t_mondel_invisible_cfg,self.modelID);
    if self.InvisiMateCfg then
        self.InvisibleMaterial = asset_game_object.find("people"..tostring(self.modelID).."/"..self.InvisiMateCfg.mat_name);
        if self.InvisibleMaterial then
            self.InvisibleMaterial:set_active(false);
        end
    end
    -- self.obj:set_active(false)

	if self.loadCallBack ~= nil then
		Utility.CallFunc(self.loadCallBack,self.obj);
	end
end

function ShowRole:Destroy()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	self.parent = nil;
	if self.obj then
		self.obj:set_active(false);
		self.obj=nil;
	end
	self.modelID = nil;
	self.roleId = nil;
	self.modelFile = nil;
	self:UnregistFunc();
end

function ShowRole:ShowObj(isShow)
	if self.obj then
		self.obj:set_active(isShow);
	end
end

function ShowRole:SetParent(parent)
	self.parent = parent;
	if self.obj then
		self.obj:set_parent(parent);
	end
end

function ShowRole:GetLocalPosition()
	if self.obj then
		return self.obj:get_local_position();
	end
	return self.pos.x,self.pos.y,self.pos.z;
end

function ShowRole:SetLocalPosition(x, y, z)
	self.pos = {x=x,y=y,z=z};
	if self.obj then
		self.obj:set_local_position(x, y, z);
	end
end

function ShowRole:SetRotation(x, y, z)
	self.rot = {x=x,y=y,z=z};
	if self.obj then
		self.obj:set_rotation(x, y, z);
	end
end

function ShowRole:SetScale(x, y, z)
	self.scale = {x=x,y=y,z=z};
	if self.obj then
		self.obj:set_local_scale(x, y, z);
	end
end

function ShowRole:PlayAnim(anim_id)
	self.animName = PublicFunc.GetAniFSMName(anim_id, self.modelID);
	if self.animName and self.obj then
		self.obj:animator_play(self.animName)
	end
end
