RenderTexture = Class("RenderTexture");

--[[
data ={
	ui_obj_root
	ui_texture_name
	ui_btn_name

	role_id|model_id
	load_call_back

	res_type		--1:role_plane  默认nil为role_plane
	plane_type		--1:红 2:黄 3:紫 4:过渡蓝 5:蓝 默认nil无背景
	align_adjust_val	--上下调整位置
	texture_size	--texture尺寸: {w,h} --render_texture创建尺寸，默认{512,512}
}
--]]

local _local = {}
_local.pathRes = "assetbundles/prefabs/map/jingjichang_dipan/role_plane.assetbundle"

_local.cursor = 0
_local.space = 3
-- 容量最大100
_local.genCursorDistance = function ()
	_local.cursor = _local.cursor + 1
	if _local.cursor > 50 then
		_local.cursor = -50
	end
	return _local.cursor, _local.cursor * _local.space
end


function RenderTexture:ChangePlaneType(plane_type)
	self.plane_type = plane_type
	self:UpdatePlane()
end

function RenderTexture:Init(data)
    self:InitData(data);
	self:RegistFunc();
	self:LoadAssetS3d();	
end

function RenderTexture:InitData(data)
	self.bindfunc = {};
	self.playerOnly = data.playerOnly;
	self.uiObjRoot = data.ui_obj_root;
    self.uiTextureName = data.ui_texture_name
    self.uiBtnName = data.ui_btn_name
	self.roleId = data.role_id
    self.modelId = data.model_id
    self.loadModelId = 0 -- 当前已加载成功的Model
	self.obj = nil;
	self.uiBtn = nil;
	self.uiTexture = nil;
	self.beginPos = nil;
	self.notNeedHz = data.notNeedHz;
	self.rot = 0;
	self.cfg = nil;
    self.modelFile = nil
	self.clickCallback = nil;
	self.clickValue = nil;
	self.loadCallBack = data.load_call_back;
	self.modelScale = data.modelScale;
	--[[
	data.buffDepth 深度缓存一般用16或者24位，建议16位节省内存
	data.textureFormat 设置的贴图格式，需要透明通道可以使用ARGB32
		ARGB32 = 0(内存占用0.7MB),Depth = 1,ARGBHalf = 2(内存占用1.4MB),Shadowmap = 3,RGB565 = 4,
		Default = 7,ARGB2101010 = 8(内存占用0.7MB),DefaultHDR = 9,ARGBFloat = 11(内存占用2.9MB),
		RGFloat = 12(内存占用1.4MB),RGHalf = 13(内存占用0.7MB), RFloat = 14, RHalf = 15, R8 = 16,ARGBInt = 17(内存占用2.9MB),RGInt = 18,RInt = 19
	]]
	self.renderParam = {512,512,data.buffDepth or 16,data.textureFormat or 0};
	if data.texture_size then
		local precision = data.texture_size[3] or 512 --指定了精度（2的倍数，256/512/1024）
		--保证精度，计算缩放比
		local scale = precision / math.max(data.texture_size[1], data.texture_size[2]);
		self.renderParam[1] = data.texture_size[1] * scale;
		self.renderParam[2] = data.texture_size[2] * scale;
	end
	
	self.res_type = data.res_type or 1
	self.plane_type = data.plane_type
    self.align_adjust_val = data.align_adjust_val

	if self.res_type == 1 then
		self.s3dPathRes = _local.pathRes;
	else
		--添加使用的其他3d模型资源...
	end
end

function RenderTexture:RegistFunc()
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, RenderTexture.on_loaded);
	-- self.bindfunc["on_drag_start"] = Utility.bind_callback(self, RenderTexture.on_drag_start);
	-- self.bindfunc["on_drag_move"] = Utility.bind_callback(self, RenderTexture.on_drag_move);
	-- self.bindfunc["on_drag_end"] = Utility.bind_callback(self, RenderTexture.on_drag_end);
	self.bindfunc["on_click"] = Utility.bind_callback(self, RenderTexture.on_click);
	-- self.bindfunc["on_change_animator"] = Utility.bind_callback(self, RenderTexture.on_change_animator);
 --    self.bindfunc["on_begin_animator"] = Utility.bind_callback(self, RenderTexture.on_begin_animator);
    self.bindfunc["on_texture_loader"] = Utility.bind_callback(self, RenderTexture.on_texture_loader);
end

function RenderTexture:UnregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function RenderTexture:ChangeObj(role_id)
	if not role_id or role_id == 0 then
		app.log("RenderTexture.ChangeObj 参数错误 role_id:"..tostring(role_id).." "..debug.traceback())
		return;
	end

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

function RenderTexture:ChangeModel(model_id,model_type)
	self.model_type = model_type;
	if not model_id or model_id == 0 then
		app.log("RenderTexture.ChangeModel 参数错误 model_id:"..tostring(model_id).." "..debug.traceback())
		return;
	end
	
	if self.time_id1 then
		timer.stop(self.time_id1)
		self.time_id1 = nil;
	end
	if self.time_id2 then
		timer.stop(self.time_id2)
		self.time_id2 = nil;
	end
	self.modelId = model_id
	self:LoadObjFromModel()
end

function RenderTexture:SetClickCallback(clickCallback, clickValue)
	self.clickCallback = clickCallback;
	self.clickValue = clickValue;
end

function RenderTexture:LoadAssetS3d()
	ResourceLoader.LoadAsset(self.s3dPathRes, self.bindfunc["on_loaded"]);
end

function RenderTexture:LoadObjFromRole()
	local config = ConfigHelper.GetRole(self.roleId)
	if not config then
		app.log("RenderTexture.LoadObjFromRole 没有找到配置 roleId:"..tostring(self.roleId).." "..debug.traceback())
		return;
	end
    local modelId = config.model_id;
	if self.obj then
		if modelId == self.modelId and self.loadModelId == self.modelId then
			-- self.time_id1 = timer.create(self.bindfunc["on_begin_animator"],100,1);
			return;
		end
		self.obj:set_active(false);
		self.obj = nil;
	end
    self.modelId = modelId;

    self:LoadObjFromModel()
end

function RenderTexture:LoadObjFromModel()
    if self.modelId == nil then
        return
    end
	local modelFile;
	if self.model_type == nil then 
		modelFile = ObjectManager.GetHighItemModelFile(self.modelId)
	else
		modelFile = ObjectManager.GetItemModelFile(self.modelId);
	end 
    if self.modelFile == modelFile and self.modelId == self.loadModelId then
    	return;
    end
    self.modelFile = modelFile;
	ResourceLoader.LoadAsset(self.modelFile, self.bindfunc["on_loaded"])
end

function RenderTexture:on_loaded(pid, filepath, asset_obj, error_info) 
	if self.modelFile == filepath then
		self:InitModelObj(asset_obj);

	elseif self.s3dPathRes == filepath then
		self:InitS3dUI(asset_obj);
	end
end

function RenderTexture:GetObj()
	return self.obj;
end

function RenderTexture:UpdatePlane()
	if self.root_s3d_plane == nil then return end
	for i, v in pairs(self.root_s3d_plane) do
		-- if self.plane_type == i then
		-- 	v:set_active(true)
		-- else
			v:set_active(false)
		-- end
	end
end


function RenderTexture:InitS3dUI(obj)
	local index, distance = _local.genCursorDistance()
	app.log("render_texture create param:"..table.tostring({self.renderParam[1], self.renderParam[2], self.renderParam[3], self.renderParam[4]}));
	local renderTexture = render_texture.create(self.renderParam[1], self.renderParam[2], self.renderParam[3],self.renderParam[4]);
	local name = "s3d_"..index
	self.root_s3d = asset_game_object.create(obj);
    self.root_s3d:set_name(name);
    self.root_s3d:set_local_position(distance, 50, 0);
    self.root_s3d:set_local_rotation(0, 0, 0);
    -- self.root_s3d_cube = self.root_s3d:get_child_by_name("s3d_cube");
    -- self.root_s3d_cube:set_local_rotation(0, 180, 0);
    -- self.root_s3d_camera = camera.find_by_name(name.."/s3d_camera");
    self.root_s3d_cube = self.root_s3d:get_child_by_name("role_character");
    self.root_s3d_cube:set_local_rotation(0, 0, 0);
    self.root_s3d_camera = camera.find_by_name(name.."/role_camera002");
    self.root_s3d_camera:set_camera_render_texture(renderTexture);
    self.root_s3d_camera_render = renderTexture;--self.root_s3d_camera:get_camera_render_texture();
	if self.align_adjust_val then
		local camera_go = self.root_s3d_camera:get_game_object()
		local x,y,z = camera_go:get_local_position()
		camera_go:set_local_position(x,y + self.align_adjust_val,z)
    end

	if self.playerOnly == true then 
		local mask = PublicFunc.GetBitLShift({PublicStruct.UnityLayer.player})
		self.root_s3d_camera:set_culling_mask(mask);
	end 
    self.renderTexture = renderTexture;

    if self.res_type == 1 then
    	self.root_s3d_plane = {}
    	for i = 1, 5 do
    		local plane = self.root_s3d:get_child_by_name(""..i)
    		if plane == nil then
    			break;
    		end
    		self.root_s3d_plane[i] = plane;
    		self:UpdatePlane()
    	end
    end

    if self.roleId then
		self:LoadObjFromRole();
    elseif self.modelId then
        self:LoadObjFromModel()
	end

	if self.obj then
		self:Load3dModel()
	end
end

function RenderTexture:Load3dModel()
	if not self.obj or not self.root_s3d then return end

	local model_id = self.modelId
	local cfg_id = ConfigManager.Get(EConfigIndex.t_model_list,model_id).ui_inspect_camera_id;
	self.cfg = ConfigManager.Get(EConfigIndex.t_ui_inspect_camera, cfg_id);
	local sx, sy, sz = 1, 1, 1
	if self.cfg then
		sx, sy, sz = self.cfg.x_size_2 or 1, self.cfg.y_size_2 or 1, self.cfg.z_size_2 or 1
	end
	if self.modelScale ~= nil then 
		self.obj:set_local_scale(self.modelScale[1] or sx,self.modelScale[2] or sy,self.modelScale[3] or sz);
	else 
		self.obj:set_local_scale(sx, sy, sz);
	end 
	--self.obj:set_local_scale(sx, sy, sz);

	if self.uiBtn == nil and self.uiBtnName ~= nil then
		self.uiBtn = ngui.find_button(self.uiObjRoot, self.uiBtnName);
		if self.uiBtn then
	        -- self.uiBtn:set_on_ngui_drag_start(self.bindfunc["on_drag_start"]);
	        -- self.uiBtn:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
	        -- self.uiBtn:set_on_ngui_drag_end(self.bindfunc["on_drag_end"]);
	        self.uiBtn:set_on_click(self.bindfunc["on_click"]);
	    end
	end

	if self.uiTexture ~= nil then
		self.uiTexture:Destroy()
	end
	self.uiTexture = ngui.find_texture(self.uiObjRoot, self.uiTextureName);
	self.uiTexture.obj:set_render_texture(self.root_s3d_camera_render);
	-- if self.uiTexture == nil then
	-- 	self.uiTexture = ngui.find_texture(self.uiObjRoot, self.uiTextureName);
	-- 	self.uiTexture.obj:set_texture(self.root_s3d_camera_render);
	-- else
	-- 	self.uiTexture:clear_texture();
	-- end
	
	self:on_s3d_load(self.obj);
	if self.loadCallBack ~= nil then
		Utility.CallFunc(self.loadCallBack, self.obj);
	end
end

function RenderTexture:InitModelObj(obj)
	if self.obj then
		self.obj:set_active(false)
	end

	self.obj = asset_game_object.create(obj);
    self.obj:set_parent(self.root_s3d_cube);
    self.obj:disable_lightprobe_effect();
    local navMeshAgent = self.obj:get_component_navmesh_agent()
	if navMeshAgent ~= nil then 
		navMeshAgent:set_enable(false);
	end 
	if self.modelScale ~= nil then 
		self.obj:set_local_scale(self.modelScale[1] or 1,self.modelScale[2] or 1,self.modelScale[3] or 1);
	else 
		self.obj:set_local_scale(1,1,1);
	end 
    self.obj:set_local_position(0,0,0);
    self.obj:set_local_rotation(0,0,0);
    self.obj:set_name("people"..tostring(self.modelId));
	local camera_point = self.obj:get_child_by_name("camera_point");
	if camera_point ~= nil then 
		camera_point:set_active(false);
	end 
	local CameraHero = self.obj:get_child_by_name("CameraHero");
	if CameraHero ~= nil then 
		CameraHero:set_active(false);
	end 
    self.InvisiMateCfg = ConfigManager.Get(EConfigIndex.t_mondel_invisible_cfg, self.modelId);
    if self.InvisiMateCfg then
        self.InvisibleMaterial = asset_game_object.find("people"..tostring(self.modelId).."/"..self.InvisiMateCfg.mat_name);
        if self.InvisibleMaterial then
            self.InvisibleMaterial:set_active(false);
        end
    end
    self:ShowObj(false)

    if self.root_s3d then
		self:Load3dModel()
	end
end

function RenderTexture:ShowObj(isShow)
	if self.obj then
		self.obj:set_active(isShow);
	end
end

function RenderTexture:ShowTexture(isShow)
	if self.uiTexture then
		self.uiTexture:set_active(isShow);
	end
end

-- function RenderTexture:on_drag_start(name,x,y)
-- 	self.beginPos = x;
-- end

-- function RenderTexture:on_drag_move(name,x,y)
-- 	local rot = self.rot + self.beginPos - x;
-- 	if (rot > self.cfg.rot_begin and rot < self.cfg.rot_end)
-- 	or self.cfg.rot_begin == self.cfg.rot_end then
-- 	    self.root_s3d_cube:set_rotation(0,rot*gd_discrete[83000004].data-180,0);
-- 	end
-- end

-- function RenderTexture:on_drag_end(name,x,y)
-- 	self.rot = self.rot + self.beginPos - x;
-- 	if self.cfg.rot_begin == self.cfg.rot_end then return; end
-- 	if self.rot < self.cfg.rot_begin then
-- 		self.rot = self.cfg.rot_begin;
-- 	elseif self.rot > self.cfg.rot_end then
-- 		self.rot = self.cfg.rot_end;
-- 	end
-- end

function RenderTexture:on_click()
	if self.clickCallback then
		Utility.CallFunc(self.clickCallback, self.clickValue);
	end
end

-- function RenderTexture:on_change_animator()
-- 	if self.obj and self.time_id2 then
-- 		self.time_id2 = nil;
-- 		app.log("change anim"..tostring(self.obj:get_name()))
-- 		self.obj:animator_play(g_get_action_list(EANI.showstand).name);
-- 	end
-- end

-- function RenderTexture:on_begin_animator()
-- 	if self.obj and self.time_id1 then
-- 		app.log("play begin anim"..tostring(self.obj:get_name()))
-- 		self.time_id1 = nil;
-- 		self.obj:set_active(true);
-- 		self.obj:animator_play(g_get_action_list(EANI.show).name);
-- 		self.time_id2 = timer.create(self.bindfunc["on_change_animator"],self.time,1);
-- 	end
-- end

function RenderTexture:on_s3d_load(go_obj)
    local file = ConfigManager.Get(EConfigIndex.t_model_list, self.modelId).material_list;
    if file ~= 0 then
        self.go_obj = {};
		self.playerObj = {};
        for k,v in pairs(file) do
			self.go_obj[k] = {};
			local itemname = nil;
			if v.list ~= nil then 
				itemname = v.list;
				self.playerObj[v.list] = 1;
			elseif v.hz ~= nil then 
				itemname = v.hz;
			end 
			self.go_obj[k].tex = go_obj:get_child_by_name(itemname);
            -- self.go_obj[k].obj = go_obj;
        end
		if self.notNeedHz == true and self.playerOnly == true then 
			local maxindex = go_obj:get_child_count();
			for i = 0,maxindex-1 do 
				local obj = go_obj:get_child_by_index(i);
				if obj ~= nil then 
					if self.playerObj[obj:get_name()] == nil then 
						obj:set_layer(PublicStruct.UnityLayer.player,true);
					else 
						obj:set_layer(PublicStruct.UnityLayer.player,true);
					end
				end
			end 
		end 
        ResourceLoader.LoadTexture("assetbundles/prefabs/ui/image/s3d/matcap_toon.assetbundle",self.bindfunc["on_texture_loader"]);
    else
        self:ShowObj(true);
    end
	self.loadModelId = self.modelId
end

function RenderTexture:on_texture_loader(pid, filepath, asset_obj, error_info)
    if self.go_obj then
        -- self.asset = asset_obj;
        for k,v in pairs(self.go_obj) do
            if v.tex then
            	-- TODO: kevin resobject test
                -- util.chang_role_s3d_material(v.tex,"_ViewTex",asset_obj);
                util.chang_role_s3d_material(v.tex,"_ViewTex",asset_obj:GetObject());
            end
            -- v.obj:set_active(true);
            -- v.obj = nil;
        end
        self:ShowObj(true);
    end
end

function RenderTexture:Destroy()
	if self.root_s3d_camera then
		self.root_s3d_camera:clear_camera_render_texture()
		self.root_s3d_camera = nil
	end
	self.uiObjRoot = nil;
	self.root_s3d_cube = nil
	self.root_s3d_camera_render = nil
	self.root_s3d_plane = nil
	self.res_type = nil
	self.plane_type = nil
	self.renderTexture = nil

	if self.root_s3d then
		self.root_s3d:set_active(false)
		self.root_s3d = nil
	end
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
	self.clickCallback = nil;
	self.clickValue = nil;
	self.loadModelId = nil;
	self.modelId = nil;
	self.roleId = nil;
	self.modelFile = nil;
	self:UnregistFunc();
end
