Role3d = Class("Role3d");

local Role_Silhouette_Model_Id = 80007001	--3d人物剪影model id

--[[
data ={
	parent
	role_id
	load_call_back
	uiSp
}
--]]
function Role3d:Init(data)
	self.panel_name = self._className
    self:InitData(data);
	self:RegistFunc();
	if self.roleId then
		self:LoadObjFromRole();
	end
end

function Role3d:InitData(data)
	self.bindfunc = {};
	self.enableCfgPos = not data.no_cfg_pos	 -- 布阵界面保持初始坐标
	self.scaleValue = data.scale_value -- 布阵界面保持原始大小
	self.parent = data.parent;
	self.roleId = data.role_id;
    self.modelID = data.model_id
	self.loadCallBack = data.load_call_back;
	self.clickCallback = data.clickRoleCallBack;
	self.enableAppearAudio = data.enableAppearAudio;

    self.isActive = true
    if data.is_active ~= nil then
        self.isActive = data.is_active
    end
    
	self.uiSp = data.uiSp;
	self.rot = 0;
	self.isGray = data.isGray or false;
	self.iseggshow = data.iseggshow or false;
end

function Role3d:RegistFunc()
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, self.on_loaded);
	self.bindfunc["on_drag_start"] = Utility.bind_callback(self, self.on_drag_start);
	self.bindfunc["on_drag_move"] = Utility.bind_callback(self, self.on_drag_move);
	self.bindfunc["on_drag_end"] = Utility.bind_callback(self, self.on_drag_end);
	self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click);
	self.bindfunc["on_change_animator"] = Utility.bind_callback(self, self.on_change_animator);
    self.bindfunc["on_begin_animator"] = Utility.bind_callback(self, self.on_begin_animator);
    
end

function Role3d:UnregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function Role3d:SetLoadCallBack(load_call_back)
	self.loadCallBack = load_call_back
end

function Role3d:SetCallBack(uiSp)
	self.uiSp = uiSp;
	if self.uiSp ~= nil and self.obj then
        self.uiSp:set_on_ngui_drag_start(self.bindfunc["on_drag_start"]);
        self.uiSp:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
        self.uiSp:set_on_ngui_drag_end(self.bindfunc["on_drag_end"]);
        self.uiSp:set_on_ngui_click(self.bindfunc["on_click"]);
    end
end

function Role3d:ChangeObj(role_id)
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

function Role3d:GetRoleID()
	return self.roleId
end

function Role3d:SetClickCallback(func)
	self.clickCallback = func;
end

function Role3d:LoadObjFromRole()
	local modelID = nil
	if self.roleId == 0 then
		modelID = Role_Silhouette_Model_Id;
	else
    	modelID = ConfigHelper.GetRole(self.roleId).model_id;
	end
	if self.obj then
		self.obj:set_active(false);
		if modelID == Role_Silhouette_Model_Id then
			
		else
			if modelID == self.modelID then
				--self.isGray = true
				if self.isGray ~= true then 
					self.time_id1 = timer.create(self.bindfunc["on_begin_animator"],100,1);
				else 
					self.time_id2 = timer.create(self.bindfunc["on_change_animator"],100,1);
				end 
				return;
			end
		end
		ObjectManager.DeleteObjByObj(self.obj);
		self.obj = nil;
	end
    self.modelID = modelID;

    self:LoadObjFromModel()
end

function Role3d:LoadObjFromModel()

    if self.modelID == nil then
        return
    end
	local modelFile = nil
	if self.modelID == Role_Silhouette_Model_Id then
		modelFile = ObjectManager.GetItemModelFile(Role_Silhouette_Model_Id)
	else
    	modelFile = ObjectManager.GetHighItemModelFile(self.modelID)
	end
    if self.modelFile == modelFile then
    	return;
    end
    self.modelFile = modelFile;
	ResourceLoader.LoadAsset(self.modelFile, self.bindfunc["on_loaded"], self.panel_name)
end

function Role3d:on_loaded(pid, filepath, asset_obj, error_info) 
	if self.modelFile == filepath then
		self:InitUI(asset_obj);
	end
end

function Role3d:GetObj()
	return self.obj;
end

function Role3d:InitUI(obj)
	if not self.parent then
		return;
	end
	if self.obj then
		self.obj:set_active(false);
		ObjectManager.DeleteObjByObj(self.obj);
	end
	
	if self.roleId == 0 then
		self.obj = ObjectManager.CreateItem(0, 3, Role_Silhouette_Model_Id)
	else
		self.obj = ObjectManager.CreateShowHero(self.roleId);
	end
    self.obj:SetGameObjectParent(self.parent);
    if self.iseggshow then 
    	self.obj:set_layer(PublicStruct.UnityLayer.player, true);
    else
    	self.obj:set_layer(PublicStruct.UnityLayer.ui3d, true);
    end
	--获取贴图列表
	self.modelList = {}
	local modelList = ConfigManager.Get(EConfigIndex.t_model_list,self.modelID).show_material_list;
	--app.log("1..."..table.tostring(modelList));
	if type(modelList) == "table" then
		for k, v in pairs(modelList) do
			local map = self.obj:GetObject():get_child_by_name(v.list);
			if map then
				table.insert(self.modelList, map);
			end
		end
	end

    --self.obj:set_local_scale(3,3,3);
    self.obj:SetPosition(0,1,0,true,false);
    self.obj:SetRotation(0,180,0);
    self.obj:SetName("people"..tostring(self.modelID));
    self.parent:set_local_rotation(0,180,0);
    self.rot = 0;

    self.obj:set_active(false)
	local camera_point = self.obj:GetObject():get_child_by_name("camera_point");
	if camera_point ~= nil then 
		camera_point:set_active(false);
	end 
	local CameraHero = self.obj:GetObject():get_child_by_name("CameraHero");
	if CameraHero ~= nil then 
		CameraHero:set_active(false);
	end 
    local model_id = self.modelID
    local cfg_id = ConfigManager.Get(EConfigIndex.t_model_list,model_id).ui_inspect_camera_id;
	self.cfg = ConfigManager.Get(EConfigIndex.t_ui_inspect_camera,cfg_id) 
				or ConfigManager.Get(EConfigIndex.t_ui_inspect_camera,1);
	self.time = ConfigManager.Get(EConfigIndex.t_model_list,model_id).show_frame * PublicStruct.MS_Each_Anim_Frame;
	if model_id == Silhouette_Model_Id then
		self.obj:set_active(true)
	else
		if self.isGray ~= true then 
			self.time_id1 = timer.create(self.bindfunc["on_begin_animator"],100,1);
		else 
			self.time_id2 = timer.create(self.bindfunc["on_change_animator"],100,1);
		end 
	end
	--local cam = Root.root_s3d_camera:get_game_object();
	if self.enableCfgPos then
		self.obj:SetPosition(self.cfg.x_pos,self.cfg.y_pos,self.cfg.z_pos,true,false);
	else
		self.obj:SetPosition(0,0,0,true,false);
	end
--	if self.scaleValue then
--		local sx, sy, sz = self.scaleValue, self.scaleValue, self.scaleValue
--		self.obj:SetScale(self.cfg.x_size*sx,self.cfg.y_size*sy,self.cfg.z_size*sz);
	--TODO::....
	--else
	--	local sx, sy, sz = self.parent:get_local_scale()
	--	sx, sy, sz = 1,1,1 --1.0/sx, 1.0/sy, 1.0/sz;
	
	if not self.iseggshow then
		self.obj:SetScale(self.cfg.x_size, self.cfg.y_size, self.cfg.z_size);
	--end
	-- self.obj:set_local_position(0,0.8,0);
	
		self.obj:SetRotation(0,180,0);
	else
		self.obj:SetPosition(0,0,0,true,false);
		self.obj:SetRotation(0,0,0);
		self.obj:SetScale(1,1,1);
	end

	--Root.get_s3d_cube():set_rotation(0,180,0);
    if self.uiSp ~= nil then
        self.uiSp:set_on_ngui_drag_start(self.bindfunc["on_drag_start"]);
        self.uiSp:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
        self.uiSp:set_on_ngui_drag_end(self.bindfunc["on_drag_end"]);
        self.uiSp:set_on_ngui_click(self.bindfunc["on_click"]);
    end
	self:SetGray(self.isGray);
	if self.loadCallBack ~= nil then
		Utility.CallFunc(self.loadCallBack,self.obj);
	end
end

function Role3d:ActiveObj()
	app.log("Role3d:ActiveObj()"..tostring(self.isActive))
    if self.isActive == false then
        self.isActive = true
    else    
        return
    end
	if self.modelID ~= Role_Silhouette_Model_Id then
		if self.isGray ~= true then 
			self.time_id1 = timer.create(self.bindfunc["on_begin_animator"],100,1);
		else 
			self.time_id2 = timer.create(self.bindfunc["on_change_animator"],100,1);
		end 
	end
end

function Role3d:ShowObj(isShow)
	if self.obj then
		self.obj:set_active(isShow);
	end
	if not isShow then
		if self.time_id1 then
			timer.stop(self.time_id1)
			self.time_id1 = nil;
		end
		if self.time_id2 then
			timer.stop(self.time_id2)
			self.time_id2 = nil;
		end
	end
end

function Role3d:Show(isShow)
	if self.uiTexture then
		self.uiTexture:set_active(isShow);
	end
end

function Role3d:on_drag_start(name,x,y)
	self.beginPos = x;
end

function Role3d:on_drag_move(name,x,y)
	if not self.beginPos then return end
	local rot = self.rot + self.beginPos - x;
	if (rot > self.cfg.rot_begin and rot < self.cfg.rot_end)
	or self.cfg.rot_begin == self.cfg.rot_end then
	    --Root.get_s3d_cube():set_rotation(0,rot*ConfigManager.Get(EConfigIndex.t_discrete,83000004).data-180,0);
	    self.parent:set_rotation(0,rot*ConfigManager.Get(EConfigIndex.t_discrete,83000004).data-180,0);
	end
end

function Role3d:on_drag_end(name,x,y)
	if not self.beginPos then return end
	self.rot = self.rot + self.beginPos - x;
	if self.cfg.rot_begin == self.cfg.rot_end then return; end
	if self.rot < self.cfg.rot_begin then
		self.rot = self.cfg.rot_begin;
	elseif self.rot > self.cfg.rot_end then
		self.rot = self.cfg.rot_end;
	end
end

function Role3d:on_click()
	if self.clickCallback then
		Utility.CallFunc(self.clickCallback);
	end
end

function Role3d:on_change_animator()
    if self.isActive == false then
        return
    end
	if self.obj and self.time_id2 then
		self.time_id2 = nil;
		app.log("change anim"..tostring(self.obj:GetName()))
		self.obj:set_active(true);
		local show_wait_anim_id = ConfigManager.Get(EConfigIndex.t_model_list,self.modelID).show_wait_anim_id;
		local _skill_cfg = ConfigManager.Get(EConfigIndex.t_skill_effect, show_wait_anim_id)
		self.obj:SetAnimate(_skill_cfg.action_id, _skill_cfg);
	end
end

function Role3d:on_begin_animator()
    if self.isActive == false then
        return
    end
	if self.obj and self.time_id1 then
		app.log("play begin anim"..tostring(self.obj:GetName()))
		self.time_id1 = nil;
		self.obj:set_active(true);
		if self.iseggshow then
			local show_anim_id = ConfigManager.Get(EConfigIndex.t_model_list,self.modelID).show_egg_anim_id;
			app.log("show_anim_id...."..tostring(show_anim_id))
			local _skill_cfg = ConfigManager.Get(EConfigIndex.t_skill_effect,show_anim_id)
			if _skill_cfg == nil then
				app.log("#lhf #找不到动作配置。anim_id:"..tostring(show_anim_id).." modelID:"..tostring(self.modelID));
				return ;
			end
			self.obj:SetAnimate(_skill_cfg.action_id, _skill_cfg);
			--self.time_id2 = timer.create(self.bindfunc["on_change_animator"],self.time,1);
		else
			local show_anim_id = ConfigManager.Get(EConfigIndex.t_model_list,self.modelID).show_anim_id;
			local _skill_cfg = ConfigManager.Get(EConfigIndex.t_skill_effect,show_anim_id)
			if _skill_cfg == nil then
				app.log("#lhf #找不到动作配置。anim_id:"..tostring(show_anim_id).." modelID:"..tostring(self.modelID));
				return ;
			end
			self.obj:SetAnimate(_skill_cfg.action_id, _skill_cfg);
			self.time_id2 = timer.create(self.bindfunc["on_change_animator"],self.time,1);
		end
		self:play_appear_audio()
	end
end

function Role3d:play_appear_audio()
	if not self.enableAppearAudio then return end
	
    if self.modelID and self.modelID > 0 then
		if self.appear_audio then
			AudioManager.StopUiAudio(self.appear_audio)
			self.appear_audio = nil
		end
		
        local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, self.modelID);
        if model_list_cfg and type(model_list_cfg.egg_get_audio_id) == "table" then
            local count = #model_list_cfg.egg_get_audio_id;
            local n = math.random(1,count)
            self.appear_audio = AudioManager.PlayUiAudio(model_list_cfg.egg_get_audio_id[n])
        end
    end
end

function Role3d:player_effect(effectid)
	if self.obj then
		local cfg =  ConfigManager.Get(EConfigIndex.t_effect_data, effectid)
		if cfg then
			self.obj:SetEffect(nil, cfg)
		else
			app.log("Role3d:player_effect error " .. tostring(effectid))
		end
	end
end

function Role3d:Destroy()
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
		ObjectManager.DeleteObjByObj(self.obj);
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

function Role3d:SetGray(isGray)
	self.isGray = isGray or false;
	--app.log(tostring(self.isGray).."........"..tostring(self.obj)..".."..table.tostring(self.modelList));
	if self.obj and #self.modelList > 0 then
		if self.isGray then
			for k, v in pairs(self.modelList) do
				v:set_material_float_with_name("_is_gray", 1);
			end
		else
			for k, v in pairs(self.modelList) do
				v:set_material_float_with_name("_is_gray", 0);
			end
		end
	end
	if self.time_id1 then
		timer.stop(self.time_id1)
		self.time_id1 = nil;
	end
	if self.time_id2 then
		timer.stop(self.time_id2)
		self.time_id2 = nil;
	end

	if self.modelID == Role_Silhouette_Model_Id then
		if self.obj then
			self.obj:set_active(true);
		end
	else
		if self.isGray ~= true then 
			self.time_id1 = timer.create(self.bindfunc["on_begin_animator"],100,1);
		else 
			self.time_id2 = timer.create(self.bindfunc["on_change_animator"],100,1);
		end 
	end
end
