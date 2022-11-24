--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/12
-- Time: 16:08
-- To change this template use File | Settings | File Templates.
--

script.run "logic/object/camera_shake.lua"

CameraManager = {

	FightCameraStencil = nil;--[[摄像机配置]]

	FightCameraLoaderObj = nil;--[[战斗像机加载器OBJ]]
	FigthCameraObj = nil;--[[战斗像机OBJ]]
	FigthCamera = nil;--[[战斗像机]]
	FightCameraFollow = nil;--[[战斗像机跟随组件]]
	FightCameraFollowTar = nil;--[[战斗摄像机跟随目标]]

	--摄像机围绕当前角色得x角度
	FightCameraFollowX = 45;
	--摄像机围绕当前角色得y角度
	FightCameraFollowY = -30;
	--摄像机距离当前角色的距离
	FightCameraFollowD = 13;
	--摄像机fov
	FightCameraFov = 35;
	--目的地
	DestinationX  = 0;
	DestinationY  = 0;
	DestinationZ  = 0;
	--差值
	DvalueFollowX = 0;
	DvalueFollowY = 0;
	DvalueFollowZ = 0;
	--旋转速度
	AngelSpeedX = 0;
	AngelSpeedY = 0;
	DistanceSpeedD = 0;
	--X轴减缓速度
	SpeedX = 1;
	SpeedZ = 1;
	--bloom效果强度 0 关闭bloom效果
	bloomIntensity = 0;
	--阈值,像素亮度大于阈值会bloom
	bloomThreshold = 1;
	--模糊步长，会影响bloom泛光范围和强度	
	blurSize = 2.5;
	--人物泛光程度(0~1从不会泛光到100%泛光)
	bloomFactor = 1;
	CanMoveX = true;
	CanMoveZ = true;
	
	--是否正在切换人物
	IsChangeRole  = false;

	AniTarObj = nil;--[[像机动画跟随对像]]
	AniBindObj = nil;--[[像机动画盯住对像]]
	AniIsMode = false;--[[是否钉住]]
	AniIsBind = false;--[[是否跟随]]
	AniLoaderObj = nil;--[[像机动画加载器OBJ]]
	AniCameraObj = nil;--[[像机动画]]
	AniFinishCallback = nil;--[[摄像机动画完成回调]]

	CameraShake = nil;--[[像机拌动]]
    IsFixedView = false;--固定摄像机

    CameraOffsetRelativeTarget = nil;
    CameraCurrentSyncSpeed = 0;
    CameraCurrentSpeed = 0;
    CameraIsDecSyncSpeed = false;
    CameraHasLookAtTarget = false;

    FightCameraOffsetY = 1;
    TargetOffsetsetY = 0;
    CameraMoveSpeed = 2;
    CameraSpeedAcc = 15;
    CameraSpeedDecAcc = 10;
    CameraLerpSpeed = 2;
    CameraZoomOutSpeed = 0.5;
    CameraAheadOfOffset = 2;
	CameraMaxOffset = 3;

    CameraZoomInDst = 5;
    CameraZoomInLerpSpeed = 5;

	newCameraDir = nil, 
    changeDirTime = 0,

    loginBackGroundCamera = nil, 

    m_target_z = -1;
    m_look_targetX = -1;
    m_look_targetY = -1;
    m_look_targetZ = -1;
};

CameraManager.CameraMaxOffsetSQ = CameraManager.CameraMaxOffset * CameraManager.CameraMaxOffset

CameraState = 
{
    followHero = 1,
    MoveToPosition = 2,
    ZoomIn = 3,
    LookToPos = 4,
    changeCamera = 5,
    syncFollowHero = 6,
    syncFollowHero2 = 7,
    TouchMoveMode = 8,
    Path = 9,
    FreeState = 10,
    RotateAround = 11;
}

function CameraManager.Destroy()

	local self = CameraManager
    
    Root.DelUpdate(self.Update)

	self.FightCameraLoaderObj = nil;--[[战斗像机加载器OBJ]]
	if self.FigthCameraObj ~= nil then
		self.FigthCameraObj:set_active(false);
	end
	self.FigthCameraObj = nil;--[[战斗像机OBJ]]
	self.FigthCamera = nil;--[[战斗像机]]
	self.FightCameraFollow = nil;--[[战斗像机跟随组件]]
	self.FightCameraFollowTar = nil;--[[战斗摄像机跟随目标]]

	self.AniTarObj = nil;--[[像机动画跟随对像]]
	self.AniBindObj = nil;--[[像机动画盯住对像]]
	self.AniIsMode = false;--[[是否钉住]]
	self.AniIsBind = false;--[[是否跟随]]
	self.AniLoaderObj = nil;--[[像机动画加载器OBJ]]
	self.AniCameraObj = nil;--[[像机动画]]
	self.AniFinishCallback = nil;--[[摄像机动画完成回调]]

	self.CameraShake = nil--[[像机拌动]]

	--[[显示主城摄像机]]
	--self.SetMainCameraShow(true);

    self._targetPositon = nil
    self.lastCameraPosition = nil
    CameraTouchMoveManager.Destroy()

    self.newCameraDir = nil
end

--[[主城3D摄像机 游戏入口像机]]
function CameraManager.SetMainCameraShow(is_show)
	local main_camera = Root.get_maincamera();
	if main_camera ~= nil then
		main_camera:set_active(is_show);
	end
end

--[[UI摄像机 游戏入口像机]]
function CameraManager.SetUICameraShow(is_show)
	local ui_camera = Root.get_ui_camera_obj();
	if ui_camera ~= nil then
		ui_camera:set_active(is_show);
	end
end

--[[得到战斗摄像机]]
function CameraManager.GetSceneCameraObj()
	return CameraManager.FigthCameraObj;
end

function CameraManager.SetSceneCameraActive(is)
    if CameraManager.FigthCameraObj then
        CameraManager.FigthCameraObj:set_active(is)
    end
end

--[[得到战斗摄像机]]
function CameraManager.GetSceneCamera()
	return CameraManager.FigthCamera;
end

--[[得到战斗摄像机跟随目标]]
function CameraManager.GetFightCameraFollwTar()
	return CameraManager.FightCameraFollowTar;
end


function CameraManager.SetLoginBackGroundCamera(camera)
	CameraManager.loginBackGroundCamera = camera;
end

function CameraManager.GetLoginBackGroundCamera()
	return CameraManager.loginBackGroundCamera;
end


--[[加载战斗场景特效像机]]
function CameraManager.init()
	--[[隐藏主城摄像机]]
	-- 这里不隐藏主摄像机，将这个相机作为背景，防止黑屏
	-- CameraManager.SetMainCameraShow(false);
--	CameraManager.SetUICameraShow(false);

    CameraManager.FigthCamera = nil

    CameraManager.UseCamera()
	camera.on_bloom_camera_change("CameraManager.OnCameraChange")
    ResourceLoader.LoadAsset(CameraManager.CameraFile, CameraManager.LoadedCallBack, nil)
end

CamearPathToId = {
	["role_3d_show/role_camera001"] = 84205050;
	["role3d_mid/role_camera"] = 84205052;
	["role3d_left/role_camera"] = 84205053;
	["70000055_jixiantiaozhan/s054_scenecamera_01"] = 84205054;
	["p_zhuejiemian/login_background_camera"] = 84205038;
}

function CameraManager.OnCameraChange(cameraPath)
	local id = CamearPathToId[cameraPath];
	if id ~= nil then 
		local cf = ConfigManager.Get(EConfigIndex.t_camera_list,id);
		if cf ~= nil then 
			camera.set_bloom(cf.bloomIntensity or 0,cf.bloomThreshold or 1,cf.bloomFactor or 1,cf.blurSize or 2.5);
		end 
	end
end 

function CameraManager.UseCamera(cameraid)

	local self = CameraManager

    if cameraid == nil then
        -- use level config camera
        local curScene = SceneManager.GetCurrentScene()
        local hurdleid = nil
        if curScene.isInherit then
            hurdleid = curScene:GetCurHurdleID()
        else
            hurdleid = curScene.GetCurHurdleID()
        end
        local hurdle = ConfigHelper.GetHurdleConfig(hurdleid);
        if hurdle ~= nil then
            cameraid = hurdle.camera_id
        else
            app.log("hurdle = nil id:"..tostring(hurdleid));
        end
    end

    if cameraid == nil then
        app.log('use cameea failed')
        return 
    end
    if self.currertCameraID == cameraid then
        return 
    end
    self.currertCameraID = cameraid
    self.FightCameraStencil = ConfigManager.Get(EConfigIndex.t_camera_list,cameraid);
    if self.FightCameraStencil ~= nil then
		self.FightCameraFollowX = self.FightCameraStencil.followX;
		self.FightCameraFollowY = self.FightCameraStencil.followY;
		self.FightCameraFollowD = self.FightCameraStencil.followZ;
		self.FightCameraFov = self.FightCameraStencil.fov;
        self.FightCameraOffsetY = self.FightCameraStencil.camera_offsetY;
        self.TargetOffsetsetY = self.FightCameraStencil.target_offsetY
        self.ClearFlags = self.FightCameraStencil.clear_flags
        self.BackgroundColor = self.FightCameraStencil.background_color
        self.ClipPlaneNear = self.FightCameraStencil.clip_plane_near
        self.ClipPlaneFar =self.FightCameraStencil.clip_plane_far
        self.CameraFile = self.FightCameraStencil.camera_file
        self.offsetHp = self.FightCameraStencil.hp_offset
        self.bloomIntensity = self.FightCameraStencil.bloomIntensity or 0;
		self.bloomThreshold = self.FightCameraStencil.bloomThreshold or 1;
		self.bloomFactor = self.FightCameraStencil.bloomFactor or 1;
		self.blurSize = self.FightCameraStencil.blurSize or 2.5;
        self.lens_type = self.FightCameraStencil.lens_type
        self.m_distance = self.FightCameraStencil.distance;

        local rolationX,rolationY,rolationZ,rolationW = util.quaternion_euler(self.FightCameraFollowY, self.FightCameraFollowX, 0)
        local disX,disY,disZ = util.quaternion_multiply_v3(rolationX,rolationY,rolationZ,rolationW,0,0,self.FightCameraFollowD)
        self.CameraOffsetRelativeTarget = Vector3d:new({x = disX, y =disY + self.FightCameraOffsetY , z = disZ})

        self.CameraLastRelOffset = self.CameraOffsetRelativeTarget:Clone()

        --if self.FigthCamera then
            --self.FigthCamera:set_fov(self.FightCameraFov);
        --end
    else
        app.log("camera config = nil id:"..tostring(cameraid));
    end
end

function CameraManager.setInitFinshCallback(fun)
    CameraManager._initFinshCallback = fun
end

--[[清除特效像机]]
function CameraManager.clear()
	CameraManager.AniLookAtObj = nil;
	CameraManager.AniFollowObj = nil;
	CameraManager.AniIsLookAt = false;
	CameraManager.AniIsFollow = false;
	CameraManager.AniLoaderObj = nil;
	if CameraManager.AniCameraObj ~= nil then
		CameraManager.AniCameraObj:set_active(false);
	end
	CameraManager.AniCameraObj = nil;
end

--[[检查当前摄像机是否已经加载好了。]]
function CameraManager.CheckOk()
	if CameraManager.FigthCameraObj then
		return true;
	else
		return false;
	end
end

function CameraManager.refreshCameraEffect()
	local self = CameraManager;
	if self.FigthCamera ~= nil then 
		camera.set_bloom(self.bloomIntensity or 0,self.bloomThreshold or 1,self.bloomFactor or 1,self.blurSize or 2.5);
	else
		app.log("no fightCamera");
	end
end

function CameraManager.SetFightCamera(isShow)
	if CameraManager.FigthCameraObj then
		CameraManager.FigthCameraObj:set_active(isShow)
	end
end

function CameraManager.LoadedCallBack(pid, fpath, asset_obj, error_info)

	local self = CameraManager

	--[[加载场景像机]]
	self.FightCameraLoaderObj = asset_obj;
	self.FigthCameraObj = asset_game_object.create(asset_obj);
	self.FigthCameraObj:set_parent(SceneManager.GetCurrentScene().fightScene);
	self.FigthCameraObj:set_name("fightCamera");
    self.FigthCameraObj:set_animator_enable(true)
    CameraManager.CloseMainCamera();

	
	self.FigthCamera = camera.find_by_name("fightCamera");
	 
	if self.ClearFlags then
		self.FigthCamera:set_clear_flags(self.ClearFlags)
	end
	local color = self.BackgroundColor
	-- app.log("CameraManager.LoadedCallBack color="..table.tostring(color))
	if color and type(color) == "table" then
		self.FigthCamera:set_background_color(color[1]/255,color[2]/255,color[3]/255,color[4]/255)
	end
	if self.ClipPlaneNear and self.ClipPlaneFar then
			self.FigthCamera:set_clip_plane(self.ClipPlaneNear,self.ClipPlaneFar)
	end
	camera.set_bloom(self.bloomIntensity or 0,self.bloomThreshold or 1,self.bloomFactor or 1,self.blurSize or 2.5);
    Root.AddUpdate(self.Update)
    self.LastFollowTargetPos = nil;
    self._closeShake = false;


    local targetX,targetY,targetZ = 0, 0, 0 
	local desX,desY,desZ;
	desX = targetX + self.CameraOffsetRelativeTarget:GetX();
	desY = targetY + self.CameraOffsetRelativeTarget:GetY();
	desZ = targetZ + self.CameraOffsetRelativeTarget:GetZ();
	self.FigthCameraObj:set_local_position(desX,desY,desZ);
	self.FigthCameraObj:look_at(targetX,targetY,targetZ);

    self.CameraWallLayerMask = PublicFunc.GetBitLShift({PublicStruct.UnityLayer.camera_wall})

    CameraTouchMoveManager.LoadedCallBack()

    if self._initFinshCallback then
        if type(self._initFinshCallback) == "function" then
            self._initFinshCallback()
        else
            if _G[self._initFinshCallback] then
                _G[self._initFinshCallback]()
            end
        end
    end
end

--[[强行对准场景中的中心位置]]
--[[function CameraManager.ForceSetSceneCenter()
	local center_obj = asset_game_object.find("centerpoint");
	if center_obj == nil then return end;
	CameraManager.init_target(center_obj);
end]]

--[[对准场景中的中心位置]]
--[[function CameraManager.SetSceneCenter()
	--如果已经是看中心点 就PASS
	if CameraManager.FightCameraFollowTar ~= nil then
		if  CameraManager.FightCameraFollowTar:get_name() == "centerpoint" then
			do return end;
		end
	end

	local center_obj = asset_game_object.find("centerpoint");
	if center_obj == nil then return end;
	CameraManager.init_target(center_obj);
end]]

--[[对准正在操作的角色]]
function CameraManager.OnShakeComplete()
	local player = FightManager.GetMyCaptain();
	if player ~= nil then
		if player.object ~= nil then
			CameraManager.init_target(player);
		end
	end
end

--[[设定战斗像机]]
function CameraManager.init_xyz(x,y,z,mode, angleSpeed, moveSpeed)
	if CameraManager.FightCameraFollow == nil then return end;

	CameraManager.FightCameraFollow:init_camera(x, y, z, mode, angleSpeed, moveSpeed);
    --app.log(string.format("set camera: %f, %f, %f, %f,%f, %f", x, y, z, mode or 0, angleSpeed or 0, moveSpeed or 0)); 
    --app.log(debug.traceback())
end

--[[设定战斗像机跟随对像]]
function CameraManager.init_target(target, initState)

	local self = CameraManager

	if target == nil then return end;
	self.FightCameraFollowTar = target;
    initState = initState or CameraState.followHero
    self._currentState = initState

    if self.lens_type and self.lens_type == 1 then
    	self._currentState = CameraState.RotateAround;
    end
    
	self.reset_follow_role_use_speed()
end

--[[清空跟随对像]]
function CameraManager.clear_follow_tar()
	if CameraManager.FightCameraFollow == nil then return end;
	CameraManager.FightCameraFollowTar = nil;
	CameraManager.FightCameraFollow:clear_target();
end

--[[ 像机动画对外接口
--
-- LookAtObj  盯住的OBJ,loot at obj
-- AniName	镜头动画路径,
-- IsLookAt	1是否盯住,
-- IsFollow	1是跟随，设为子对像
-- FollowObj	跟随对像，把摄机设为它的子
-- AniFinishCallback 	回调
-- ]]
function CameraManager.playAni(LookAtObj,AniName,IsLookAt,IsFollow,FollowObj,AniFinishCallback) 
	AniName = AniName or "";
	IsLookAt = IsLookAt or 0;--[[0自由 1盯住]]
	IsFollow = IsFollow or 0;--[[0不绑定，1绑定]]
	if CameraManager.FigthCameraObj == nil or FollowObj==nil or  AniName == "" then
		return
	end;
	CameraManager.AniLookAtObj = LookAtObj;
	CameraManager.AniIsLookAt = IsLookAt;
	CameraManager.AniIsFollow = IsFollow;
	CameraManager.AniFollowObj = FollowObj;
	CameraManager.AniFinishCallback = AniFinishCallback;
    ResourceLoader.LoadAsset(AniName, CameraManager.LoadAniCallBack, nil)
end
--[[动画像机回调]]
function CameraManager.LoadAniCallBack(pid, fpath, asset_obj, error_info)
	CameraManager.AniLoaderObj = asset_obj;
	CameraManager.AniCameraObj = asset_game_object.create(asset_obj);

	CameraManager.FightCameraFollow:clear_target();

	--[[设定像机对像]]
	CameraManager.set_target(CameraManager.FigthCameraObj);
	local camera_path_obj = CameraManager.AniCameraObj:get_component_camera_path_animator();
	camera_path_obj:stop();
	camera_path_obj:set_on_finished("CameraManager.OnCameraFinish");

	--[[是否跟随]]
	if CameraManager.AniIsFollow == 1 and CameraManager.AniFollowObj ~= nil then
		CameraManager.AniCameraObj:set_parent(CameraManager.AniFollowObj);
	end

	--[[是否盯住]]
	if CameraManager.AniIsLookAt == 1 and CameraManager.AniLookAtObj ~= nil then
		camera_path_obj:set_orientation_target(CameraManager.AniLookAtObj);
	end

	CameraManager.AniCameraObj:set_local_position(0,0,0);
	CameraManager.AniCameraObj:set_local_rotation(0,0,0);
	CameraManager.AniCameraObj:set_local_scale(1,1,1);
	camera_path_obj:play();
end


--[[设定时间scale]]
function CameraManager.settime(str)
	if tonumber(str) == nil and str == "" then return end;
	app.set_time_scale(tonumber(str));
end

--[[摄像机正视场景]]
-- function CameraManager.set_in_sky()
-- 	if CameraManager.FigthCameraObj == nil or CameraManager.FightCameraFollow == nil then return end;
-- 	CameraManager.FightCameraFollow:clear_target();
-- 	CameraManager.FigthCameraObj:set_local_position(0,25,0);
-- 	CameraManager.FigthCameraObj:set_local_rotation(90,180,0);
-- end

--[[绑定对像]]
function CameraManager.set_target(target)
	if target == nil then return end;
	if CameraManager.AniCameraObj == nil then return end;
	local camera_path_obj = CameraManager.AniCameraObj:get_component_camera_path_animator();
	camera_path_obj:set_animation_object(target);
end

--[[特效像机播放]]
function CameraManager.set_animation_play()
	if CameraManager.AniCameraObj == nil then return end;
	local camera_path_obj = CameraManager.AniCameraObj:get_component_camera_path_animator();
	camera_path_obj:play();
end

--[[特效像机暂停]]
function CameraManager.set_animation_pause()
	if CameraManager.AniCameraObj == nil then return end;
	local camera_path_obj = CameraManager.AniCameraObj:get_component_camera_path_animator();
	camera_path_obj:pause();
end

--[[特效像机停止]]
function CameraManager.set_animation_stop()
	if CameraManager.AniCameraObj == nil then return end;
	local camera_path_obj = CameraManager.AniCameraObj:get_component_camera_path_animator();
	camera_path_obj:stop();
end

--[[清除摄像机对像]]
function CameraManager.clear_animation_target()
	if CameraManager.AniCameraObj ~= nil then
		local camera_path_obj = CameraManager.AniCameraObj:get_component_camera_path_animator();
		camera_path_obj:clear_animation_object();
	end
end

--[[像机动画播放完成后回调]]
function CameraManager.OnCameraFinish()
	CameraManager.clear();
	PublicFunc.UnityResume();
	if CameraManager.AniFinishCallback ~= nil then
		CameraManager.AniFinishCallback();
	end
	--[[对准正在操作的角色]]
	CameraManager.OnShakeComplete();
end

--[[得到像机对像or像机动画]]
function CameraManager.GetCameraObj()
	if CameraManager.AniCameraObj ~= nil then
		return CameraManager.AniCameraObj;
	end
	if CameraManager.FigthCameraObj ~= nil then
		return CameraManager.FigthCameraObj;
	end
	return nil;
end

--[[像机拌动接口]]
-- data = {
-- count 抖动次数
-- x
-- y
-- z
-- dis 抖动距离
-- cd  抖动cd时间，单位s
-- 衰减百分比
-- 时间
-- }
function CameraManager.shake(data)
	--[[LUA抖]]
--	CameraManager.clear_follow_tar();
--	CameraShake.shake(data);

    if CameraManager._closeShake == true then
        return ;
    end

    if CameraManager.FigthCamera == nil then 
    	return 
	end;
	local camera_shake_obj = CameraManager.FigthCamera:get_component_camera_shake();

--	camera_shake_obj:shake_with(
--		10,
--		1,
--		1,
--		1,
--		0.1,
--		50,
--		0.1,
--		false
--	);

	if data.multiply == 0 then
		data.multiply = false;
	else
		data.multiply = true;
	end


--	app.log(string.format("shake=== %d %d %d %d %s %d %s %s",
--		data.count,
--		data.x,
--		data.y,
--		data.z,
--		tostring(data.dis),
--		data.speed,
--		tostring(data.decay),
--		tostring(data.multiply)));
	-- 临时检测 shake_with 方法是否存在，用于处理c#返回对象不正确问题
	if camera_shake_obj and camera_shake_obj.shake_with then
		camera_shake_obj:shake_with(
			data.count,
			data.x,
			data.y,
			data.z,
			data.dis,
			data.speed,
			data.decay,
			data.multiply
		);
	end
end

--[[抖动完成后回调]]
function CameraManager.shake_callback()
--	if CameraManager.FightCameraFollowTar ~= nil then
--		CameraManager.init_target(CameraManager.FightCameraFollowTar);
--	end
end

function CameraManager.GetTargetVelocity()
    local navMeshAgent = CameraManager.FightCameraFollowTar.object:get_component_navmesh_agent();
    local x, y, z = navMeshAgent:get_velocity()
    return Vector3d:new({x = x, y = y, z = z})
end

function CameraManager.follow_role_use_speed(deltaTime)

	local self = CameraManager

	local fc = self.FigthCameraObj;
	if nil == fc then
		return
	end

    local targetPos = self.GetWatchTargetPositinV3d()
    local cameraPos = self.GetPositionV3d()

    local lastPos = self.LastFollowTargetPos
    if lastPos == nil then
        return
    end

    self.CalcOffset();
    local isChanging = self._IsChangingDir()


    local current = targetPos:Clone()
    current:RSub(lastPos)
    local currentFrameCameraMove = nil
    if current:GetLengthSQ() > 0.00001 and not isChanging then
        local targetSpeed = self.FightCameraFollowTar:GetSpeed()
        local currentMoveDir = current:CNormalize()
        if self.TargetLastMoveDir ~= nil then
            if self.TargetLastMoveDir:Dot(currentMoveDir) < math.cos(math.rad(45)) then
                self.CameraCurrentSpeed = 0
                self.CameraCurrentSyncSpeed = 0
                self.CameraIsDecSyncSpeed = false
            end
        end
        self.TargetLastMoveDir = currentMoveDir

        if self.CameraHasLookAtTarget == false then

            local toPos = targetPos:CAdd(self.CameraOffsetRelativeTarget)

            if toPos:CSub(cameraPos):GetLengthSQ() <= 3 then
                self.CameraHasLookAtTarget = true
            else
				local lerpSpeed = self.CameraLerpSpeed* deltaTime
				local lerpPos = V3dLerp(cameraPos, toPos, lerpSpeed)
				currentFrameCameraMove = lerpPos:RSub(cameraPos)
			end
		end

		if self.CameraHasLookAtTarget then
			if self.CameraCurrentSpeed < targetSpeed then
				self.CameraCurrentSpeed = self.CameraCurrentSpeed + self.CameraSpeedAcc * deltaTime
				current:RNormalize()
				current:RScale(self.CameraCurrentSpeed * deltaTime)
				currentFrameCameraMove = current

	--            local offsetDiff = self.CameraOffsetRelativeTarget:CSub(self.CameraLastRelOffset)
	--            if offsetDiff:GetLengthSQ() > 0.00001 then
	--                cameraPos:RAdd(offsetDiff)
	--            end
			else
				self.CameraCurrentSpeed = targetSpeed
				currentFrameCameraMove = current
				local toPos = targetPos:CAdd(self.CameraOffsetRelativeTarget)
				local moveDir = current:CNormalize()
				local toAheadPos = toPos:RAdd(moveDir:RScale(self.CameraAheadOfOffset))
				local toAheadOffsetVec = toAheadPos:RSub(cameraPos)
				local syncDiffLen = toAheadOffsetVec:GetLengthSQ()
				if self.CameraIsDecSyncSpeed == false and  syncDiffLen > 0.1 then
					local syncDiffDir = toAheadOffsetVec;
					if self.CameraCurrentSyncSpeed < self.CameraMoveSpeed then
						self.CameraCurrentSyncSpeed = self.CameraCurrentSyncSpeed + self.CameraSpeedAcc * deltaTime
						if self.CameraCurrentSyncSpeed > self.CameraMoveSpeed then
							self.CameraCurrentSyncSpeed = self.CameraMoveSpeed
						end
					end
					local moveLen = self.CameraCurrentSyncSpeed * deltaTime
					if (syncDiffLen > moveLen * moveLen) then
						syncDiffDir = toAheadOffsetVec:RNormalize():RScale(moveLen)
					end
					currentFrameCameraMove:RAdd(syncDiffDir)
				else
					self.CameraIsDecSyncSpeed = true
					if self.CameraCurrentSyncSpeed > 0 then
						self.CameraCurrentSyncSpeed = self.CameraCurrentSyncSpeed - self.CameraSpeedDecAcc * deltaTime
						if self.CameraCurrentSyncSpeed < 0 then
							self.CameraCurrentSyncSpeed = 0
						end
						moveDir = current:CNormalize()
						moveDir:RScale(self.CameraCurrentSyncSpeed * deltaTime)
						currentFrameCameraMove:RAdd(moveDir)
						--app.log('c3')
					else
	--                    local offsetDiff = self.CameraOffsetRelativeTarget:CSub(self.CameraLastRelOffset)
	--                    if offsetDiff:GetLengthSQ() > 0.00001 then
	--                        cameraPos:RAdd(offsetDiff)
	--                    end
					end
				end
			end


			local toPos = targetPos:CAdd(self.CameraOffsetRelativeTarget)
			local finalPos = cameraPos:CAdd(currentFrameCameraMove)

			local offsetVec = toPos:RSub(finalPos)
			local offsetLenSQ = offsetVec:GetLengthSQ()
			if offsetLenSQ > self.CameraMaxOffsetSQ then
				local needMoveLen = math.sqrt(offsetLenSQ) - self.CameraMaxOffset
				local maxOffsetLimitMoveDir = offsetVec:RNormalize():RScale(needMoveLen)
				currentFrameCameraMove:RAdd(maxOffsetLimitMoveDir)
				app.log("#camera# trigger max offset limit " .. tostring(needMoveLen))
			end

		end

        --local realWatchPos = cameraPos:CSub(self.CameraOffsetRelativeTarget)
        --self.SetPositionV3d(cameraPos)
        --self.LookAtTarget(realWatchPos)

        --TODO: kevin 
        -- self.cameraLerpAgent:set_position(targetPos:GetX(), targetPos:GetY(), targetPos:GetZ());
    else
        self.reset_follow_role_use_speed()

        local lerpSpeed = self.CameraLerpSpeed* deltaTime
        local toPos = targetPos:CAdd(self.CameraOffsetRelativeTarget)

        -- local ax, ay, az = self.cameraLerpAgent:get_position();
        -- local lx, ly, lz = util.v3_lerp(ax, ay, az, targetPos:GetX(), targetPos:GetY(), targetPos:GetZ(), lerpSpeed)
        -- self.cameraLerpAgent.set_position(lx, ly, lz);

        local lerpPos = V3dLerp(cameraPos, toPos, lerpSpeed)
        currentFrameCameraMove = lerpPos:RSub(cameraPos)
    end

    local currentCameraMoveLenSQ = currentFrameCameraMove:GetLengthSQ()
    if currentCameraMoveLenSQ > 0.00001 then
        local adjustMove = self.AdjustCurrentFrameMoveByCameraWall(cameraPos, currentFrameCameraMove)
        self.lastCameraPosition = cameraPos:RAdd(adjustMove)
		if self:GetPositionV3d():RSub(self.lastCameraPosition):GetLengthSQ() > 0.00001 then
        	self.SetPositionV3d(self.lastCameraPosition)
		end
    end

    if isChanging then
    	fc:look_at(targetPos:GetX(), targetPos:GetY(), targetPos:GetZ());
    end
end

function CameraManager.reset_follow_role_use_speed()

	local self = CameraManager

	self.CameraCurrentSpeed = 0
	self.CameraCurrentSyncSpeed = 0;
	self.TargetLastMoveDir = nil
	self.CameraIsDecSyncSpeed = false
	self.CameraHasLookAtTarget = false;
end

function CameraManager.ShortenOffset(x, y, z)

	local decLen = 0.02
	local decLenSQ = decLen * decLen
	local d = x * x + y * y + z * z
	if d - decLenSQ > 0.000001 then
        d = 1/math.sqrt(d) * -decLen
        local sx, sy, sz = x * d, y * d, z * d

		return x + sx, y + sy, z + sz
	end

	return 0, 0, 0
end

function CameraManager.AdjustCurrentFrameMoveByCameraWall(lastPos, move)
	--do return move end
	local self = CameraManager

--    if lastPos == nil or move == nil or move:GetLengthSQ() < 0.00001 then
--        return move
--    end

	local lpx, lpy, lpz = lastPos:GetX(), lastPos:GetY(), lastPos:GetZ()
	local mx, my, mz = move:GetX(), move:GetY(), move:GetZ()
    local result, hit = util.raycase_out4(lpx, lpy, lpz, mx, my, mz, move:GetLength(), self.CameraWallLayerMask)
    local ret = nil
    if result then

		local hnx, hny, hnz = hit.normal.x, hit.normal.y, hit.normal.z
		local hpx, hpy, hpz = hit.x, hit.y, hit.z

		local dot = hnx * mx + hny * my + hnz * mz
		-- parallel hit normal vector
		local phnx, phny, phnz = hnx * dot, hny * dot, hnz * dot

		-- parallel hit face move vector
		local phfx, phfy, phfz = mx - phnx, my - phny, mz - phnz

		-- begin to hit vector
		local bhvx, bhvy, bhvz = hpx - lpx, hpy - lpy, hpz - lpz
		bhvx, bhvy, bhvz = CameraManager.ShortenOffset(bhvx, bhvy, bhvz)

		dot = hnx * bhvx + hny * bhvy + hnz * bhvz

		phnx, phny, phnz = hnx * dot, hny * dot, hnz * dot

		-- total move
		local tmx, tmy, tmz = phfx + phnx, phfy + phny, phfz + phnz
		local tmlen = math.sqrt(tmx * tmx + tmy * tmy + tmz * tmz)
		result, hit = util.raycase_out4(lpx, lpy, lpz, tmx, tmy, tmz, tmlen, self.CameraWallLayerMask)
		if result then
			mx, my, mz = hit.x - lpx,  hit.y - lpy, hit.z - lpz
			mx, my, mz = CameraManager.ShortenOffset(mx, my, mz)
			ret = Vector3d:new({x = mx, y = my, z = mz})
		else
			ret = Vector3d:new({x = tmx, y = tmy , z = tmz})
		end
    else
        ret = move
    end
	
    return ret
end

function CameraManager.BeginFollowHero()
    self._currentState = CameraState.followHero

    self.LastFollowTargetPos = self.GetWatchTargetPositinV3d()

    self.CameraCurrentSpeed = 0
    self.CameraCurrentSyncSpeed = 0;
    self.TargetLastMoveDir = nil
    self.CameraIsDecSyncSpeed = false
end


-- time(ms)
function CameraManager.MoveToPos(posV3d, time, calback)
	self = CameraManager
	self.CameraOffsetRelativeTarget = self:GetPositionV3d():RSub(self:GetWatchTargetPositinV3d())
	
	self._targetPositon = posV3d
    self._moveToPosCompleteCallBack = calback
    self._currentState = CameraState.MoveToPosition
	if type(time) ~= 'number' then
		time = 500
	end

	time = time / 1000
	local curPos = self.GetPositionV3d()
	local moveVec = curPos:RSub(CameraManager.CameraOffsetRelativeTarget):RSub(posV3d)

	self.moveToPosUseSpeed = moveVec:GetLength()/time
end

function CameraManager.LookToPos(posV3d)
    CameraManager._LookToPosCamPos = posV3d:CAdd(CameraManager.CameraOffsetRelativeTarget)
    CameraManager._currentState = CameraState.LookToPos

    CameraManager.Update(0)
end

--initPosV3d:初始位置
--mark：遮罩button
--lockX：是否锁定x方向的移动
--lockY：是否锁定y方向的移动
function CameraManager.EnterTouchMoveMode(initPosV3d, mark, lockX, lockY, cameraObj, speed)
    CameraManager._currentState = CameraState.TouchMoveMode
   
    cameraObj = cameraObj or CameraManager.FigthCameraObj
    speed = speed or 10
    CameraTouchMoveManager.EnterTouchMoveMode(initPosV3d, mark, lockX, lockY, cameraObj, speed, CameraManager)
end

function CameraManager.ZoomInAndVignetting(zoomInDist, zoomInSpeed, calbak)

	local self = CameraManager

	if zoomInDist then
		self.useCameraZoomInDst = zoomInDist
	else
		self.useCameraZoomInDst = self.CameraZoomInDst
	end

	if zoomInSpeed then
		self.useCameraZoomInSpeed = zoomInSpeed
	else
		self.useCameraZoomInSpeed = self.CameraZoomInLerpSpeed
	end

    self._currentState = CameraState.ZoomIn
	self.ZoomInRelativeOffset = self.CameraOffsetRelativeTarget:CSub(self.CameraOffsetRelativeTarget:CNormalize():RScale(self.useCameraZoomInDst))
    self._ZoomInCompleteCallBack = calbak
    if self.FigthCameraObj then
        self.FigthCameraObj:set_animator_bool("isPlay",true)
    end
end

function CameraManager.MoveToTargetImm(ignoreCameraWall)
	local self = CameraManager

    if self._targetPositon ~= nil then
        return ;
    end

    local watchPos = self.GetWatchTargetPositinV3d()
    local toPos = watchPos:CAdd(self.CameraOffsetRelativeTarget)
    
    if self.lastCameraPosition == nil then
        self.lastCameraPosition = watchPos
    end

    if ignoreCameraWall ~= true then
        local move = toPos:RSub(self.lastCameraPosition)
        if move:GetLengthSQ() > 0.00001 then
            local adjustPos = self.AdjustCurrentFrameMoveByCameraWall(self.lastCameraPosition, move)
            self.lastCameraPosition = self.lastCameraPosition:RAdd(adjustPos)
        end
        toPos = self.lastCameraPosition
    end

    self.SetPositionV3d(toPos)
end


function g_OnCameraDirChange(trigger_name, x, y, z, yAngle)
	local co = CameraManager.FigthCameraObj;

	if nil == co then
		return
	end

	local se = ObjectManager.GetObjectByName(trigger_name);
	 if nil == se or not se:IsCaptain() then
	 	return;
	 end

	local cx, cy, cz = co:get_forward();
	local angle = util.v3_angle(x, 0, z, cx, 0, cz)
	if math.abs(angle) < 30 then
		return;	
	end

	app.log("caption trigger change camera dir:" .. x .. y .. z);
	CameraManager.newCameraDir = {x=x, y= y, z=z, yAngle = yAngle};
	CameraManager.changeDirTime = app.get_time() + 1;
end

function CameraManager._IsChangingDir()

	local self = CameraManager

	-- TODO: 加入角度判断

	if app.get_time() > self.changeDirTime + 1 then
		return false;
	else
		return true;
	end
end

function CameraManager.CalcOffset()
	local self = CameraManager

	if nil == self.newCameraDir then
		return
	end


	local frx, fry, frz, frw = util.quaternion_look_rotation(-1 * self.newCameraDir.x, -1 * self.newCameraDir.y, -1 *self.newCameraDir.z)
	local ax, ay, az = util.get_quaternion_euler(frx, fry, frz, frw)

	local rolationX,rolationY,rolationZ,rolationW = util.quaternion_euler(self.FightCameraFollowY, ay, 0)

    local disX,disY,disZ = util.quaternion_multiply_v3(rolationX,rolationY,rolationZ,rolationW,0,0,self.FightCameraFollowD)
    self.CameraOffsetRelativeTarget = Vector3d:new({x = disX, y =disY + self.FightCameraOffsetY , z = disZ})
    self.CameraLastRelOffset = self.CameraOffsetRela
end

function CameraManager.UpdateRotateAround( dt )
	local self = CameraManager;
	--Vector3 A = m_Center.position; // 0, 0, 0
	--Vector3 B = m_Target.position; //3, 0, 0

	-- 摄像机距离
	-- local l = self.FightCameraFollowD;
	local cameraPos = self.GetPositionV3d();
	local l = math.sqrt(self.FightCameraFollowD*self.FightCameraFollowD - cameraPos:GetY()*cameraPos:GetY());


	--圆心点
	local x0 = 0;
	local y0 = 0;
	local z0 = 0;
	local center_pos_obj = asset_game_object.find("center_pos");
	
	if center_pos_obj then
		local center_pos_x, center_pos_y, center_pos_z = center_pos_obj:get_local_position();
		x0 = center_pos_x;
		y0 = center_pos_y;
		z0 = center_pos_z;
	end
	-- app.log("x0:" .. x0 .. "z0:" .. z0);
	
	if not self.FightCameraFollowTar or not self.FightCameraFollowTar.object then 
		return; 
	end;

	-- 主角点
	local targetX,targetY,targetZ = self.FightCameraFollowTar.object:get_local_position();
	local x1 = targetX;
	local z1 = targetZ;

	if self.m_distance and self.m_target_z == -1 then
		-- self.m_target_z = math.sqrt(math.pow(x1 - x0, 2) + math.pow(z1 - z0, 2));
		self.m_target_z = self.m_distance;
		app.log("m_target_z:" .. self.m_target_z)
	else
		-- self.m_target_z = math.sqrt(math.pow(x1 - x0, 2) + math.pow(z1 - z0, 2));
	end

	local tempz1 = math.sqrt(math.pow(x1 - x0, 2) + math.pow(z1 - z0, 2));
	-- app.log("m_target_z:" .. self.m_target_z)
	-- app.log("tempz1:" .. tempz1)
	self.aroundTargetYOffset = 0;
	local offset = 0;
	if tempz1 > self.m_target_z then
		l = l - (tempz1 - self.m_target_z);
		offset = (tempz1 - self.m_target_z)/tempz1 * 35;
		-- app.log("offset:" .. offset)
		-- local offset =  1 - l / self.FightCameraFollowD;
		-- local offset = math.sqrt(self.FightCameraFollowD * self.FightCameraFollowD - l * l) * 0.5;
		self.aroundTargetYOffset = offset * 1;
	end
	-- app.log("l:" .. l);

	-- 摄像机点
	local x2;
	local z2;

	local a;
	if (z1 == z0) then
		--a = x1 - x0;
		z2 = 0;
		x2 = math.sqrt (l * l) + x1;
	else 
		a = (x1 - x0) / (z1 - z0);
		z2 = math.sqrt (l * l / (a * a + 1)) + z1;
		
		if (z1 < z0) then
			z2 = -math.sqrt (l * l / (a * a + 1)) + z1;
		end
		x2 = (z2 - z1) * a + x1;
	end

	--Vector3 t = new Vector3(x2, m_Camera.position.y, z2);
	--m_Camera.position = Vector3.Lerp (m_Camera.position, t, Time.deltaTime);	
	-- app.log("-- RotateAround: x2:" .. x2 .. "--- z2:" .. z2);
	
	self.FigthCameraObj:set_local_position(x2, cameraPos:GetY(), z2);
	--m_Camera.LookAt (m_Target);
	-- app.log("targetX:" .. targetX .. "--targetY:" .. targetY .. "--targetZ:" .. targetZ)
	self.FigthCameraObj:look_at(targetX, targetY + self.aroundTargetYOffset, targetZ);
	-- self.FigthCameraObj:look_at(x0, y0, z0);
end

function CameraManager.CloseMainCamera()
	CameraManager.openMainCamera = false;
	CameraManager.SetMainCameraShow(false);
end

function CameraManager.Update(dt)

	local self = CameraManager

	if not CameraManager.openMainCamera then
		CameraManager.SetMainCameraShow(true);
		self.openMainCamera = true;
	end

	if self._currentState == CameraState.RotateAround then
		self:UpdateRotateAround(dt);
		return;
	end

    if self._currentState == CameraState.FreeState then
    	return;
    end

    if self._currentState == CameraState.TouchMoveMode then
        CameraTouchMoveManager.Update(dt)
        return
    end

    if self._currentState == CameraState.LookToPos then
        local camPos = self.GetPositionV3d()
        if camPos:RSub(self._LookToPosCamPos):GetLengthSQ() > 0.0000001 then
            self.SetPositionV3d(self._LookToPosCamPos)
        end
        return
    end
    if not self.FigthCameraObj then return; end;
	if not self.FightCameraFollowTar or not self.FightCameraFollowTar.object then 
		return; 
	end;

    if self._currentState == CameraState.followHero then
        self.follow_role_use_speed(dt)
    elseif self._currentState == CameraState.MoveToPosition then
        if self._targetPositon ~= nil then
            local cameraMoveToPos = self._targetPositon:CAdd(self.CameraOffsetRelativeTarget)
            local cameraPos = self.GetPositionV3d()
            local needMoveVec = cameraMoveToPos:RSub(cameraPos)
            local needMoveLenSQ = needMoveVec:GetLengthSQ()

            if needMoveLenSQ < 0.0001 then
                
                if self._moveToPosCompleteCallBack ~= nil then
                    self._moveToPosCompleteCallBack()
                end
				--不能清空_targetPosition，下一个状态需要使用
                return 
            end

			local moveLen = dt * self.moveToPosUseSpeed
			if needMoveLenSQ < moveLen * moveLen then
				moveLen = math.sqrt(needMoveLenSQ)
			end

            needMoveVec:RNormalize():RScale(moveLen)
            cameraPos:RAdd(needMoveVec)
            self.SetPositionV3d(cameraPos)
        end
    elseif self._currentState==CameraState.ZoomIn then
		if self.ZoomInRelativeOffset then
			local cameraPos = self.GetPositionV3d()
			local currentMoveTo = self.GetWatchTargetPositinV3d():RAdd(self.ZoomInRelativeOffset)
			local moveDiffVec = currentMoveTo:RSub(cameraPos)

			if moveDiffVec:GetLengthSQ() < 0.0001 then
				if self._ZoomInCompleteCallBack ~= nil then
					self._ZoomInCompleteCallBack()
				end
				self.ZoomInRelativeOffset = nil
				return ;
			end

			cameraPos:RAdd(moveDiffVec:RScale(self.CameraZoomInLerpSpeed * dt))

			self.SetPositionV3d(cameraPos)
		end
    elseif self._currentState == CameraState.changeCamera then
        local cameraconfig = {[84205004]= Vector3d:new({x = 0.2009214, y = 0.04135203, z = -66.81631}),
                            [84205007] = Vector3d:new({x = 23.43213, y = 0.04135203, z = -109.0035})}

        local beginCameraConfig = ConfigManager.Get(EConfigIndex.t_camera_list,self._changeCameraCurID)
        local endCameraConfig = ConfigManager.Get(EConfigIndex.t_camera_list,self._changeCameraToID)

        local rolationX,rolationY,rolationZ,rolationW = util.quaternion_euler(beginCameraConfig.followY, beginCameraConfig.followX, 0)
        local bx,by,bz = util.quaternion_multiply_v3(rolationX,rolationY,rolationZ,rolationW,0,0,beginCameraConfig.followZ)
        by = by + beginCameraConfig.camera_offsetY

        rolationX,rolationY,rolationZ,rolationW = util.quaternion_euler(endCameraConfig.followY, endCameraConfig.followX, 0)
        local ex,ey,ez = util.quaternion_multiply_v3(rolationX,rolationY,rolationZ,rolationW,0,0,endCameraConfig.followZ)
        ey = ey + endCameraConfig.camera_offsetY

        local watchPos = self.GetWatchTargetPositinV3d()
        local cornerVector = cameraconfig[self._changeCameraToID]:CSub(cameraconfig[self._changeCameraCurID])

        local cornerLen = cornerVector:GetLength()

        local beginToWatchVecotr = watchPos:CSub(cameraconfig[self._changeCameraCurID])
        local btwLen = beginToWatchVecotr:GetLength()
        local watchMoveLen = btwLen * cornerVector:RNormalize():Dot(beginToWatchVecotr:RNormalize())

        local nx,ny,nz = util.v3_slerp(bx,by,bz,ex,ey,ez,watchMoveLen/cornerLen)

        --local offset = Vector3d:new({x = nx, y = ny, z = nz})
        --local targetPos = watchPos:CAdd(offset)
--
        --local cameraPos = self.GetPositionV3d()
--
        --local curTargetPos = targetPos
        ----local curTargetPos = V3dLerp(cameraPos, targetPos, 0.1)
--
        --self.SetPositionV3d(curTargetPos)
        --self.LookAtTarget(watchPos)

        self.CameraLastRelOffset = self.CameraOffsetRelativeTarget
        self.CameraOffsetRelativeTarget = Vector3d:new({x = nx, y = ny, z = nz})

        self.follow_role_use_speed(dt)

    elseif self._currentState == CameraState.syncFollowHero then
        local watchPos = self.GetWatchTargetPositinV3d()
        local targetPos = watchPos:RAdd(self.CameraOffsetRelativeTarget)
        local cameraPos = self.GetPositionV3d()
        local moveDir = targetPos:RSub(cameraPos)
        if moveDir:GetLengthSQ() > 0.00001 then
            moveDir = self.AdjustCurrentFrameMoveByCameraWall(cameraPos, moveDir)
        end
        targetPos = cameraPos:RAdd(moveDir)
        self.SetPositionV3d(targetPos)
    elseif self._currentState == CameraState.syncFollowHero2 then
        if self.LastFollowTargetPos ~= nil then

            local watchPos = self.GetWatchTargetPositinV3d()
            watchPos:RSub(self.LastFollowTargetPos)

            local cameraPos = self.GetPositionV3d()
            cameraPos:RAdd(watchPos)

            self.SetPositionV3d(cameraPos)
        end
    end

    self.LastFollowTargetPos = self.GetWatchTargetPositinV3d()

    --app.log('xyz123 ' .. self._currentState)
end

function CameraManager.TriggerChangeCamera(cameraID)
	local self = CameraManager
    if self._currentState == CameraState.changeCamera then
        
    end

    self._currentState = CameraState.changeCamera
    self._changeCameraCurID = cameraID
    self._changeCameraToID = 84205007
    if cameraID == 84205007 then
        self._changeCameraToID = 84205004
    end

    --app.log(string.format('%d, %d', self._changeCameraCurID, self._changeCameraToID))
end

function CameraManager.GetWatchTargetPositinV3d()
	local self = CameraManager
	local targetX = 0;
    local targetY = 0;
    local targetZ = 0;
    if self._targetPositon == nil then
        if self.FightCameraFollowTar and self.FightCameraFollowTar.object then
            targetX,targetY,targetZ = self.FightCameraFollowTar.object:get_local_position();
        end
		targetY = targetY + self.TargetOffsetsetY
    else
        targetX = self._targetPositon:GetX()
        targetY = self._targetPositon:GetY()
        targetZ = self._targetPositon:GetZ()
    end
    return Vector3d:new({x = targetX, y =targetY, z = targetZ})
end

function CameraManager.GetPositionV3d()
	local self = CameraManager
    if self.FigthCameraObj==nil then
        app.log('CameraManager.GetPositionV3d FigthCameraObj == nil ' .. debug.traceback())
    end
    local cameraX,cameraY,cameraZ = self.FigthCameraObj:get_local_position();
    return Vector3d:new({x = cameraX, y =cameraY , z = cameraZ})
end

function CameraManager.GetPosition()
	local self = CameraManager
	if self.FigthCameraObj==nil then
        app.log('CameraManager.GetPositionV3d FigthCameraObj == nil ' .. debug.traceback())
    end
	local cameraX,cameraY,cameraZ = self.FigthCameraObj:get_position();
	return cameraX,cameraY,cameraZ;
end

function CameraManager.SetPositionV3d(pos)
	local self = CameraManager
    if pos == nil or self.FigthCameraObj==nil then
        app.log('CameraManager.SetPositionV3d pos or FigthCameraObj == nil ' .. debug.traceback())
    end
    self.FigthCameraObj:set_local_position(pos:GetX(), pos:GetY(), pos:GetZ())
end

function CameraManager.SetRotationQ(x, y, z, w)

	local self = CameraManager

	if self.FigthCameraObj==nil then
        app.log('CameraManager.SetRotationQ FigthCameraObj == nil ' .. debug.traceback())
    end
    self.FigthCameraObj:set_rotationq(x, y, z, w);
end

function CameraManager.LookAtTarget(tarPosV3d)
    CameraManager.FigthCameraObj:look_at(tarPosV3d:GetX(), tarPosV3d:GetY(), tarPosV3d:GetZ())
end

--[[跟随captain目标]]
-- function CameraManager.follow_role()
--     --if CameraManager.IsFixedView then
--     --    return
--     --end
-- 	if not CameraManager.FigthCameraObj then return; end;
-- 	if not CameraManager.FightCameraFollowTar or not not CameraManager.FightCameraFollowTar.object then 
-- 		return; 
-- 	end;
-- 	if CameraManager.IsChangeRole then return; end;
	
-- 	local rolationX,rolationY,rolationZ,rolationW = util.quaternion_euler(CameraManager.FightCameraFollowY, CameraManager.FightCameraFollowX, 0);
-- 	--需要移动得位移
-- 	local distanceX,distanceY,distanceZ = util.quaternion_multiply_v3(rolationX,rolationY,rolationZ,rolationW,0,0,CameraManager.FightCameraFollowD)
-- 	--跟随目标得当前位置
-- 	local targetX,targetY,targetZ = CameraManager.FightCameraFollowTar.object:get_local_position();

-- 	--摄像机当前位置
-- 	local cameraX,cameraY,cameraZ = CameraManager.FigthCameraObj:get_local_position();
-- 	--需要移动到得位置
-- 	local destinationX,destinationY,destinationZ;
-- 	local outSpeed = 0.01;
-- 	local enterSpeed = 0.02;

-- 	if CameraManager.CanMoveX == true then
-- 		if CameraManager.SpeedX < 1 then
-- 			CameraManager.SpeedX = CameraManager.SpeedX + outSpeed;
-- 			destinationX = cameraX + (targetX + distanceX - cameraX)*CameraManager.SpeedX;
-- 		else
-- 			CameraManager.SpeedX = 1;
-- 			destinationX = targetX + distanceX*CameraManager.SpeedX;
-- 		end
-- 		--destinationX = targetX + distanceX;
-- 	else 
-- 		if CameraManager.SpeedX > 0 then
-- 			CameraManager.SpeedX = CameraManager.SpeedX - enterSpeed;
-- 			destinationX = cameraX + (targetX+distanceX-cameraX)*CameraManager.SpeedX;
-- 		else
-- 			CameraManager.SpeedX = 0;
-- 			destinationX = cameraX;
-- 		end
-- 	end;
-- 	if CameraManager.CanMoveZ == true then 
-- 		if CameraManager.SpeedZ < 1 then
-- 			CameraManager.SpeedZ = CameraManager.SpeedZ + outSpeed;
-- 			destinationZ = cameraZ + (targetZ + distanceZ - cameraZ)*CameraManager.SpeedZ;
-- 		else
-- 			CameraManager.SpeedZ = 1;
-- 			destinationZ = targetZ + distanceZ*CameraManager.SpeedZ;
-- 		end
-- 		--destinationZ = targetZ + distanceZ;
-- 	else 
-- 		if CameraManager.SpeedZ > 0 then
-- 			CameraManager.SpeedZ = CameraManager.SpeedZ - enterSpeed;
-- 			destinationZ = cameraZ + (targetZ+distanceZ-cameraZ)*CameraManager.SpeedZ;
-- 		else
-- 			CameraManager.SpeedZ = 0;
-- 			destinationZ = cameraZ;
-- 		end
-- 		--destinationZ = cameraZ;
-- 	end;
-- 	destinationY = targetY + distanceY;
-- 	CameraManager.FigthCameraObj:set_local_position(destinationX,destinationY+1,destinationZ);
-- 	if CameraManager.CanMoveX == true and CameraManager.CanMoveZ == true and SpeedX == 1 and SpeedZ == 1 then
-- 		CameraManager.FigthCameraObj:look_at(targetX,targetY,targetZ);
-- 	end
-- end

--摄像机是否停止跟随captain目标 1 为跟随 0为摄像机静止
function CameraManager.CameraMove(isMove)
	if isMove == 1 then 
		CameraManager.CanMoveX = true; 
		CameraManager.CanMoveZ = true;
	elseif isMove == 0 then 
		CameraManager.CanMoveX = false; 
		CameraManager.CanMoveZ = false;
	end;
end
--摄像机是否停止跟随captain目标横向移动 1 为跟随 0为摄像机静止
function CameraManager.CameraMoveX(isMoveX)
	if isMoveX == 1 then 
		CameraManager.CanMoveX = true; 
	elseif isMoveX == 0 then 
		CameraManager.CanMoveX = false; 
	end;
end
-- --当切换captain角色得时候调用此方法,摄像机切换跟随对象
-- function CameraManager.change_role_path()
-- 	if not CameraManager.FightCameraFollowTar or not CameraManager.FightCameraFollowTar.object then return; end;
-- 	Root.AddUpdate(CameraManager.change_role_path_update);
-- end
-- --当切换captain角色得时候调用此方法,摄像机位移到当前captain角色那
-- function CameraManager.change_role_path_update()
-- 	if not CameraManager.FigthCameraObj then return; end;
-- 	if not CameraManager.FightCameraFollowTar or not CameraManager.FightCameraFollowTar.object then return; end;
-- 	local speed = 10;
-- 	local rolationX,rolationY,rolationZ,rolationW = util.quaternion_euler(CameraManager.FightCameraFollowY, CameraManager.FightCameraFollowX, 0);
-- 	local disX,disY,disZ = util.quaternion_multiply_v3(rolationX,rolationY,rolationZ,rolationW,0,0,CameraManager.FightCameraFollowD)
-- 	local targetX,targetY,targetZ = CameraManager.FightCameraFollowTar.object:get_local_position();
-- 	local CameraX,CameraY,CameraZ = CameraManager.FigthCameraObj:get_local_position();
	
-- 	local desX = targetX + disX;
-- 	local desY = targetY + disY + 1;
-- 	local desZ = targetZ + disZ;
	
-- 	local chaX = desX - CameraX;
-- 	local chaY = desY - CameraY;
-- 	local chaZ = desZ - CameraZ;
	
-- 	local speedX,speedY,speedZ;
-- 	if chaX >= 0 then speedX =  math.abs(chaX)*speed*PublicFunc.getDeltaTime();
-- 	else speedX =  -1*math.abs(chaX)*speed*PublicFunc.getDeltaTime();
-- 	end
-- 	if math.abs(chaX) < 0.1 then speedX = 0; end;
	
-- 	if chaY >= 0 then speedY =  math.abs(chaY)*speed*PublicFunc.getDeltaTime();
-- 	else speedY =  -1*math.abs(chaY)*speed*PublicFunc.getDeltaTime();
-- 	end
-- 	if math.abs(chaY) < 0.1 then speedY = 0; end;
	
-- 	if chaZ >= 0 then speedZ =  math.abs(chaZ)*speed*PublicFunc.getDeltaTime();
-- 	else speedZ =  -1*math.abs(chaZ)*speed*PublicFunc.getDeltaTime();
-- 	end
-- 	if math.abs(chaZ) < 0.1 then speedZ = 0; end;
	
-- 	CameraManager.FigthCameraObj:set_local_position(CameraX + speedX,CameraY + speedY,CameraZ + speedZ);
-- 	local length = util.v3_distance(desX,desY,desZ,CameraX + speedX,CameraY + speedY,CameraZ + speedZ)
-- 	if length < 0.5 then
-- 		CameraManager.IsChangeRole = false;
-- 		CameraManager.FigthCameraObj:set_local_position(desX,desY,desZ);
-- 		CameraManager.FigthCameraObj:look_at(targetX,targetY,targetZ);
-- 		Root.DelUpdate(CameraManager.change_role_path_update);
-- 	end
-- end

--[[旋转摄像头XY角度 并且拉近拉远距离 
	xAngel,yAngel,distance分别对应 FightCameraFollowX FightCameraFollowY FightCameraFollowD变化后
	SpeedXX为旋转x轴移动速度 SpeedYY为旋转y轴移动速度 SpeedZZ为移动摄像机速度
]]
function CameraManager.rotate_Camera(xAngel,yAngel,distance,SpeedXX,SpeedYY,SpeedZZ)
	if CameraManager.FightCameraFollowTar == nil or not CameraManager.FightCameraFollowTar.object then return end;
	DestinationX  = xAngel;
	DestinationY  = yAngel;
	DestinationZ  = distance;
	
	AngelSpeedX    = SpeedXX;
	AngelSpeedY    = SpeedYY;
	DistanceSpeedD = SpeedZZ;
	
	DvalueFollowX = DestinationX - CameraManager.FightCameraFollowX;
	DvalueFollowY = DestinationY - CameraManager.FightCameraFollowY;
	DvalueFollowZ = DestinationZ - CameraManager.FightCameraFollowD;
	
	Root.AddLateUpdate(CameraManager.rotate_camera_update);
end
--[[旋转摄像头]]
function CameraManager.rotate_camera_update()
	if CameraManager.FightCameraFollowTar == nil or not CameraManager.FightCameraFollowTar.object then return end;
	local nowPosX = CameraManager.FightCameraFollowX;
	local nowPosY = CameraManager.FightCameraFollowY;
	local nowPosZ = CameraManager.FightCameraFollowD;

	local DistanceX,DistanceY,DistanceZ;
	local NextPosX,NextPosY,NextPosZ;
	local setPos = true;

	DistanceX = DestinationX - nowPosX;
	NextPosX  = nowPosX + PublicFunc.getDeltaTime()*DvalueFollowX*AngelSpeedX;
	if (DestinationX - NextPosX) * DistanceX <= 0.01 then	
		nowPosX = DestinationX;
	else
		nowPosX = nowPosX + PublicFunc.getDeltaTime()*DvalueFollowX*AngelSpeedX;
		setPos  = false;
	end
	
	DistanceY = DestinationY - nowPosY;
	NextPosY  = nowPosY + PublicFunc.getDeltaTime()*DvalueFollowY*AngelSpeedY;
	if (DestinationY - NextPosY) * DistanceX <= 0.01 then
		nowPosY = DestinationY;
	else
		nowPosY = nowPosY + PublicFunc.getDeltaTime()*DvalueFollowY*AngelSpeedY;
		setPos  = false; 
	end
	
	DistanceZ = DestinationZ - nowPosZ;
	NextPosZ  = nowPosZ + PublicFunc.getDeltaTime()*DvalueFollowZ*DistanceSpeedD;
	if (DestinationZ - NextPosZ) * DistanceZ <= 0.01 then
		nowPosZ = DestinationZ;
	else
		nowPosZ = nowPosZ + PublicFunc.getDeltaTime()*DvalueFollowZ*DistanceSpeedD;
		setPos  = false;
	end
	
	if not setPos then 	
		CameraManager.FightCameraFollowX = nowPosX;
		CameraManager.FightCameraFollowY = nowPosY;
		CameraManager.FightCameraFollowD = nowPosZ;
		return;
	end;

	Root.DelLateUpdate(CameraManager.rotate_camera_update);
end
--设置镜头模糊，
function CameraManager.SetFihgtCameraBlurEffect(enable)
    if  CameraManager.FigthCamera then
       return CameraManager.FigthCamera:get_motion_blur_effect():set_enable(enable)
    end
end
--设置镜头模糊参数
--@param intensity模糊强度
--@param ox x偏移
--@param oy y偏移
--@param bw 迭代次数
function CameraManager.SetFightCameraBlurEffectValue(intensity,ox,oy,bw)
    if  CameraManager.FigthCamera then
        CameraManager.FigthCamera:get_motion_blur_effect():set_value(intensity,ox,oy,bw)
    end
end

function CameraManager.GetIntensityValue()
    if  CameraManager.FigthCamera then
       return CameraManager.FigthCamera:get_motion_blur_effect():get_intensity_value()
    end
    return 0
end

function CameraManager.GetCameraState()
	return CameraManager._currentState;
end

function CameraManager.SetCameraState(state)
	CameraManager._currentState = state;
end
