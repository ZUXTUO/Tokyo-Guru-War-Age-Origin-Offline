TriggerFunc = TriggerFunc or {};
local entityCamPath = "CameraHero/GameObject";

local function GetNearRot(start_rot, end_rot)
	if (end_rot - start_rot) > 180 then
		end_rot = end_rot - 360;
	elseif (end_rot - start_rot) < -180 then
		end_rot = end_rot + 360;
	end
	return end_rot;
end

function TriggerFunc.RecordSceneCameraInfo(callback, param)
	TriggerFunc.CameraState =  CameraManager.GetCameraState();
	local rot = {};
	rot[1],rot[2],rot[3] = CameraManager.GetSceneCameraObj():get_rotation();
	TriggerFunc.CameraRot = rot;
	local pos = {};
	pos[1],pos[2],pos[3] = CameraManager.GetSceneCameraObj():get_position();
	TriggerFunc.CameraPos = pos;
	TriggerFunc.CameraFov = CameraManager.GetSceneCamera():get_fov();
	CameraManager.SetCameraState(CameraState.FreeState);
    if callback then
        callback();
    end
end

function TriggerFunc.SetAllAI(callback,param)
    ObjectManager.EnableAllAi(param[2] == 1);
    if param[2] == 0 then
        PublicFunc.msg_dispatch(UiManager.PushUi)
    end
    -- FightScene.GetFightManager():PauseLoader(param[2] ~= 1);
    if callback then
        callback();
    end
end

function TriggerFunc.ShowFigthCameraObj(callback,param)
    if CameraManager.FigthCameraObj then
        CameraManager.FigthCameraObj:set_active(param[2] == 1);
    end
    if callback then
        callback();
    end
end

local __ShowedMonster = {}
function TriggerFunc.ShowAllMonster(callback,param)
    -- if ObjectManager.monsterRootAssert then
    --     ObjectManager.monsterRootAssert:set_active(param[2] == 1);
    -- end

	local isShow = param[2] == 1

	if TriggerFunc.isShowMonster == isShow then
		return
	end
	TriggerFunc.isShowMonster = isShow
	if isShow then

		ObjectManager.ShowObjects(isShow, __ShowedMonster)
		__ShowedMonster = {}
		
	else

		ObjectManager.ForEachObj(
			function (name,obj)
				if obj:IsMonster() and obj:IsShow() then
					table.insert(__ShowedMonster, name)
				end
			end
		)

		ObjectManager.ShowObjects(isShow, __ShowedMonster)
	end

    if callback then
        callback();
    end
end

function TriggerFunc.HideSceneEffect(callback)
	FightScene.HideAllSceneEffect()
	if callback then
        callback();
    end
end

local __ShowedHero = {}
function TriggerFunc.ShowAllHero(callback,param)
    -- if ObjectManager.heroRootAssert then
    --     ObjectManager.heroRootAssert:set_active(param[2] == 1);
    -- end

	local isShow = param[2] == 1

	if TriggerFunc.isShowHeros == isShow then
		return
	end
	TriggerFunc.isShowHeros = isShow
	if isShow then

		ObjectManager.ShowObjects(isShow, __ShowedHero)
		__ShowedHero = {}
		
	else

		ObjectManager.ForEachObj(
			function (name,obj)
				if obj:IsHero() and obj:IsShow() then
					table.insert(__ShowedHero, name)
				end
			end
		)

		ObjectManager.ShowObjects(isShow, __ShowedHero)
	end

    if callback then
        callback();
    end
end

local __ShowedItem = {}
function TriggerFunc.ShowAllItem(callback,param)
    -- if ObjectManager.itemRootAssert then
    --     ObjectManager.itemRootAssert:set_active(param[2] == 1);
    -- end
	local isShow = param[2] == 1

	if TriggerFunc.isShowItems == isShow then
		return
	end
	TriggerFunc.isShowItems = isShow
	if isShow then
		ObjectManager.ShowObjects(isShow, __ShowedItem)
		__ShowedItem = {}
	else
		ObjectManager.ForEachObj(
			function (name,obj)
				if obj:IsItem() and obj:IsShow() then
					table.insert(__ShowedItem, name)
				end
			end
		)
		ObjectManager.ShowObjects(isShow, __ShowedItem)
	end
    if callback then
        callback();
    end
end

function TriggerFunc.ClearShowCache()
	__ShowedMonster = {}
	__ShowedHero = {}
	__ShowedItem = {}
	TriggerFunc.isShowMonster = true;
	TriggerFunc.isShowHeros = true;
	TriggerFunc.isShowItems = true;
end

function TriggerFunc.ShowAllUI(callback,param)
	if GetMainUI() then
		if param[2] == 1 then
			GetMainUI():Show(param.ui, param.hp);
		else
			GetMainUI():Hide(param.ui, param.hp);
		end
	end
	local list = g_dataCenter.fight_info:GetControlHeroList();
	TriggerFunc.keepAttack = TriggerFunc.keepAttack or {};
	for k,v in pairs(list) do
		local obj = ObjectManager.GetObjectByName(v);
		if obj then
			if param[2] == 1 then
				if TriggerFunc.keepAttack[k] ~= nil then
					obj:KeepNormalAttack(TriggerFunc.keepAttack[k]);
				end
			else
				TriggerFunc.keepAttack[k] = obj:GetIsKeepNormalAttack();
				obj.stopAttack = true
				obj:KeepNormalAttack(false);
			end
		end
	end
	list = g_dataCenter.fight_info:GetMonsterList(g_dataCenter.fight_info.single_friend_flag);
	for k,v in pairs(list) do
		local obj = ObjectManager.GetObjectByName(v);
		if obj then
			if param[2] == 1 then
				if TriggerFunc.keepAttack[k] ~= nil then
					obj:KeepNormalAttack(TriggerFunc.keepAttack[k]);
				end
			else
				TriggerFunc.keepAttack[k] = obj:GetIsKeepNormalAttack();
				obj.stopAttack = true
				obj:KeepNormalAttack(false);
			end
		end
	end
    if callback then
        callback();
    end
end

function TriggerFunc.CreateShowBoss(callback, param)
    local boss_id = param.boss;
    TriggerFunc.bossEntity = nil;
    if param.posName then
	    local hurdleMonsterBurchCfg = ConfigHelper.GetMapInf(FightScene.GetFightManager():GetFightMapInfoID(),EMapInfType.burchmonster)
	    for k,v in pairs(hurdleMonsterBurchCfg) do
	    	if v.obj_name == param.posName then
	            TriggerFunc.bossEntity = ObjectManager.CreateShowBoss(boss_id, v.flag)
				camera.set_dof_target(TriggerFunc.bossEntity:GetObject());
	            TriggerFunc.bossEntity:SetPosition(v.px,0,v.pz)
	            TriggerFunc.bossEntity:SetRotation(v.rx,v.ry,v.rz)
	            TriggerFunc.bossEntity:SetScale(v.sx,v.sy,v.sz)
	            TriggerFunc.bossEntity:ShowAperture(false);
	            break;
	    	end
	    end
	end
	if TriggerFunc.bossEntity == nil then
    	local hurdleMonsterCfg = ConfigHelper.GetMapInf(FightScene.GetFightManager():GetFightMapInfoID(),EMapInfType.monster)
	    for k,v in pairs(hurdleMonsterCfg) do
	        if v.id == boss_id then
	            TriggerFunc.bossEntity = ObjectManager.CreateShowBoss(boss_id, v.flag)
				camera.set_dof_target(TriggerFunc.bossEntity:GetObject());
	            TriggerFunc.bossEntity:SetPosition(v.px,0,v.pz)
	            TriggerFunc.bossEntity:SetRotation(v.rx,v.ry,v.rz)
	            TriggerFunc.bossEntity:SetScale(v.sx,v.sy,v.sz)
	            TriggerFunc.bossEntity:ShowAperture(false);
	            break;
	        end
	    end
    end
    if callback then
    	callback();
    end
end

function TriggerFunc.ShowBoss(callback, param)
    local boss_id = param.boss;
    if TriggerFunc.FightBossEntity then
    	TriggerFunc.FightBossEntity:Show(param.isShow);
    	TriggerFunc.FightBossEntity:HideHP(not param.isShow);
    	TriggerFunc.FightBossEntity:PostEvent(AIEvent.RESUME);
    end
    if callback then
    	callback();
    end
end

--[[临时处理，隐藏hero相机]]
function TriggerFunc.HideHeroCamera(callback, param)
    if TriggerFunc.teamHero == nil or TriggerFunc.teamHero[1] == nil then
        return
    end
    local obj = TriggerFunc.teamHero[1]:GetObject();
    if obj == nil then
        return
    end
    TriggerFunc.entityCameraObj = obj:get_child_by_name(entityCamPath);
    if TriggerFunc.entityCameraObj then
        TriggerFunc.entityCameraObj:set_active(false);
    end
    if callback then
    	callback();
    end
end

function TriggerFunc.MoveCameraToBossCamera(callback, param)
	local time = param[2] or 1;
	local ease = param[3] or "linear";
    local obj = TriggerFunc.bossEntity:GetObject();
    TriggerFunc.entityCameraObj = obj:get_child_by_name(entityCamPath);

    if TriggerFunc.entityCameraObj then
    	TriggerFunc.RecordSceneCameraInfo();

	    local posx,posy,posz = TriggerFunc.entityCameraObj:get_position();
	    local rotx,roty,rotz = TriggerFunc.entityCameraObj:get_rotation();
	    TriggerFunc.entityCamera = camera.find_by_name(obj:get_name().."/"..entityCamPath);
	    TriggerFunc.entityCameraObj:set_active(false);

	    local p = {};
	    p.time = time;
	    p.ease = ease;
	    p.rot = {TriggerFunc.entityCameraObj:get_rotation()};
	    p.pos = {TriggerFunc.entityCameraObj:get_position()};
	    local callbackfunc = function ()
		    TriggerFunc.entityCameraObj:set_active(true);
		    if callback then
		    	callback();
		    end
		end
		TriggerFunc.CameraMoveTo(callbackfunc, p);
	else
		app.log_warning("TriggerFunc.MoveCameraToBossCamera 找不到摄像机");
		if callback then
			callback();
		end
	end
end

function TriggerFunc.PlayBossAnim(callback,param)
	function TriggerFunc._DelayPlayAni()
		local _skill_cfg = ConfigManager.Get(EConfigIndex.t_skill_effect,param[2]);
		TriggerFunc.bossEntity:SetAnimate(_skill_cfg.action_id, _skill_cfg);
	end
	if TriggerFunc.bossEntity then
		timer.create("TriggerFunc._DelayPlayAni",1,1);
	else
		app.log_warning("TriggerFunc.PlayBossAnim:没有找到scene_entity对象")
	end
end

function TriggerFunc.BossAnimEndCallback()
	ScreenPlay.FuncOver()
end

function TriggerFunc.DeleteShowBoss(callback,param)
	TriggerFunc.bossEntity:set_active(false);
	TriggerFunc.bossEntity:HideHP(true);
	FightScene.DeleteObj(TriggerFunc.bossEntity:GetName(),1);
	TriggerFunc.bossEntity = nil;
	if callback then
		callback();
	end
end

function TriggerFunc.MoveBackCamera(callback, param)
	local time = param[2] or 1;
	local ease = param[3] or "linear";
	if TriggerFunc.entityCameraObj then
		TriggerFunc.entityCameraObj:set_active(false);
	end

	local p = {};
	p.time = time;
	p.ease = ease;
	p.rot = TriggerFunc.CameraRot;
	p.pos = TriggerFunc.CameraPos;
	p.fov = TriggerFunc.CameraFov;
	p.lookat = param.lookat;
	local callbackfunc = function ()
		CameraManager.SetCameraState(TriggerFunc.CameraState);
		if callback then
			callback();
		end
	end
	TriggerFunc.CameraMoveTo(callbackfunc, p);
end

function TriggerFunc.CameraMoveTo(callback, param)
	local ease = param.ease or "linear";
    local cameraObj = CameraManager.GetSceneCameraObj();
    local camera = CameraManager.GetSceneCamera();
    local rot = {cameraObj:get_rotation()};

    -- fov 缓动
    if param.fov then
	    local t = {};
	    t.get_pid = function ()
		    t.pid = t.pid or "t"..tostring(math.random(10000,20000));
		    return t.pid;
		end
		t.fov = camera:get_fov();
		Tween.addTween(t,param.time,{fov = param.fov;},ease,0,nil,function() camera:set_fov(t.fov); end)
	end

	-- 镜头旋转位置的缓动
    local transition = {};
    transition.position = param.pos;
    local update;
    if param.lookat == 1 then
    	-- 如果需要镜头看向目标
    	local curRot = {cameraObj:get_rotation()};
    	update = function (pro)
	    	local scene_entity = g_dataCenter.fight_info:GetCaptain();
			local pos = scene_entity:GetBindObj(1);
			cameraObj:look_at(pos:get_position());
			-- look_at 会将z的旋转强制重置成0，所以这里手动缓动z的旋转设置上去
			if rot then
				local r = {cameraObj:get_rotation()};
				local z = GetNearRot(rot[3],param.rot[3]);
				cameraObj:set_rotation(r[1],r[2],Transitions.execute(curRot[3],z,pro));
			end
    	end
	elseif param.lookat == 2 then
		-- 如果需要镜头看向目标
    	local curRot = {cameraObj:get_rotation()};
    	update = function (pro)
			local pos = CameraManager.GetWatchTargetPositinV3d();
			cameraObj:look_at(pos:GetX(),pos:GetY(),pos:GetZ());
			-- look_at 会将z的旋转强制重置成0，所以这里手动缓动z的旋转设置上去
			if rot then
				local r = {cameraObj:get_rotation()};
				local z = GetNearRot(rot[3],param.rot[3]);
				cameraObj:set_rotation(r[1],r[2],Transitions.execute(curRot[3],z,pro));
			end
    	end
    else
    	-- 如果不需要镜头看向目标，则直接xyz旋转都直接采用缓动方案
	    transition.rotation =
	    {
	    	GetNearRot(rot[1],param.rot[1]),
	    	GetNearRot(rot[2],param.rot[2]),
	    	GetNearRot(rot[3],param.rot[3]),
	    };
	end
    Tween.addTween(cameraObj,param.time,transition,ease,0,nil,
    	update,
		function ()
			-- 结束回调
			if callback then
				callback();
			end
	    end
	);
end

function TriggerFunc.BasicCameraMoveTo(callback,param)
	-- local speed = param.speed or 1000;
	-- local basicName = FightScene.GetFightManager().curDeadList["basis"];
	-- local basicObj = ObjectManager.GetObjectByName(basicName);
	-- local player = g_dataCenter.fight_info:GetCaptain();
	-- local dis = basicObj:GetPositionV3d():RSub(player:GetPositionV3d());
	-- param.speed = nil;
	-- param.time = dis:GetLength()/speed;
	CameraManager.SetCameraState(CameraState.FreeState);
	TriggerFunc.CameraMoveTo(callback,param);
end

function TriggerFunc.CreateTeam(callback, param)
	local info = LevelMapConfigHelper.GetHeroPosePoint(param.pos_name);
	local pos = {info.px,info.py,info.pz};
	local rot = {info.rx,info.ry,info.rz};
	local size = {info.sx,info.sy,info.sz};

    local env = FightScene.GetStartUpEnv()
    local cfg = env.levelData;
	local show_hero_num = param.show_hero_num;
    if not cfg.hero_limit or cfg.hero_limit == 0 then
		show_hero_num = show_hero_num or 3;
	else
		show_hero_num = cfg.hero_limit;
    end
	teamList = FightScene.GetStartUpEnv().fightTeamInfo;
	-- app.log("= teamList:"..table.tostring(teamList))
	for k, v in pairs(teamList) do
		app.log("= playerid:"..tostring(g_dataCenter.player:GetGID()))
		local info = v.players[g_dataCenter.player:GetGID()];
		if info then
			TriggerFunc.teamHero = {};
			for k, gid in pairs(info.hero_card_list) do
				if k <= show_hero_num then
					local card_info = info.package_source:find_card(1, gid);
					if nil ~= card_info then
						TriggerFunc.teamHero[k] = ObjectManager.CreateShowHero(card_info.number,g_dataCenter.player.camp_flag);
					else
						app.log("TriggerFunc.CreateTeam nil card :"..tostring(gid));
					end
				end
			end
		end
	end
	-- set pos
	-- Leader
	TriggerFunc.teamHero[1]:SetPosition(pos[1],pos[2],pos[3]);
	-- get member pos
	local pos1 = TriggerFunc.teamHero[1]:GetObject():get_child_by_name("point_hero01");
	if TriggerFunc.teamHero[2] then
		TriggerFunc.teamHero[2]:SetGameObjectParent(TriggerFunc.teamHero[1]:GetObject());
		local pos = {pos1:get_local_position()};
		TriggerFunc.teamHero[2]:SetPosition(pos[1],pos[2],pos[3],true,false);
		TriggerFunc.teamHero[2]:SetRotation(0,0,0);
		TriggerFunc.teamHero[2]:PlayAnimate(21);
		local cam = TriggerFunc.teamHero[2]:GetObject():get_child_by_name(entityCamPath);
		cam:set_active(false);
	end
	local pos2 = TriggerFunc.teamHero[1]:GetObject():get_child_by_name("point_hero02");
	if TriggerFunc.teamHero[3] then
		TriggerFunc.teamHero[3]:SetGameObjectParent(TriggerFunc.teamHero[1]:GetObject());
		local pos = {pos2:get_local_position()};
		TriggerFunc.teamHero[3]:SetPosition(pos[1],pos[2],pos[3],true,false);
		TriggerFunc.teamHero[3]:SetRotation(0,0,0);
		TriggerFunc.teamHero[3]:PlayAnimate(21);
		local cam = TriggerFunc.teamHero[3]:GetObject():get_child_by_name(entityCamPath);
		cam:set_active(false);
	end
	TriggerFunc.teamHero[1]:SetRotation(rot[1],rot[2],rot[3]);
	TriggerFunc.teamHero[1]:SetScale(size[1],size[2],size[3]);

	-- set rot and size
	-- for k,v in pairs(TriggerFunc.teamHero) do
	-- 	v:SetRotation(rot[1],rot[2],rot[3]);
		-- v:SetScale(size[1],size[2],size[3]);
	-- end
	if callback then
		callback();
	end
end

function TriggerFunc.PlayTeamEnd(callback, param)
	function TriggerFunc._DelayPlayAni()
		TriggerFunc.teamHero[1]:PlayAnimate(param.anim_id);
		camera.set_dof_target(TriggerFunc.teamHero[1]:GetObject());
	end
	if TriggerFunc.teamHero and TriggerFunc.teamHero[1] then
		timer.create("TriggerFunc._DelayPlayAni",1,1);
	else
		app.log_warning("TriggerFunc.PlayTeamEnd:没有找到队长对象 ");
    	if callback then
    		callback();
    	end
	end
end

function TriggerFunc.StopTeamEndAnim(callback,param)
	if TriggerFunc.teamHero then
		if TriggerFunc.teamHero[2] then
			TriggerFunc.teamHero[2]:GetObject():set_animator_speed("",0);
		end
		if TriggerFunc.teamHero[3] then
			TriggerFunc.teamHero[3]:GetObject():set_animator_speed("",0);
		end
	end
	if callback then
		callback();
	end
end

function TriggerFunc.PlayBossDeadAnim(callback, param)
	local bossName = FightScene.GetFightManager().curDeadList["boss"];
	local bossObj = ObjectManager.GetObjectByName(bossName);
	if bossObj then
		TriggerFunc._PlayBossDeadHPEffect(bossObj,callback, param)
    else
		app.log_warning("TriggerFunc.PlayBossDeadAnim:找不到最后击杀的boss对象");
    	if callback then
    		callback();
    	end
	end
end

function TriggerFunc.PlayBaseDeadAnim(callback, param)
	local baseName = FightScene.GetFightManager().curDeadList["basis"];
	local baseObj = ObjectManager.GetObjectByName(baseName);
	if baseObj then
		TriggerFunc._PlayDeadEffect(baseObj,callback, param)
    else
		app.log_warning("TriggerFunc.PlayBossDeadAnim:找不到最后击杀的boss对象");
    	if callback then
    		callback();
    	end
	end
end

function TriggerFunc.PlayHurdleSucEffect(callback, param)

	CameraManager.ZoomInAndVignetting(5, 8)

	app.set_time_scale(0.2)
	local camera = CameraManager.SetFihgtCameraBlurEffect(true)
    CameraManager.SetFightCameraBlurEffectValue(0.15,0.5,0.5,15)
    if camera then
        camera:begin_blur_tween(0.15,0,1800)--:begin_tc_tween(0.2,1,time)
    end

    local function PlaySuccessEffectEndCallback()
	    app.set_time_scale(1)    
	    local function endCallback()
		    if callback then
		    	callback();
		    end
	    end
	    timer.create(Utility.create_callback(endCallback),300, 1)
    end
    timer.create(Utility.create_callback(PlaySuccessEffectEndCallback),360, 1)
end

function TriggerFunc._PlayBossDeadHPEffect(obj, callback, param)

	local mainui = GetMainUI()
	if mainui == nil then 
		TriggerFunc._PlayDeadEffect(obj, callback, param)
		return 
	end

	local bosshpCom = mainui:DetachComponent(EMMOMainUICOM.NewFightUiBosshp)
	if bosshpCom == nil then
		TriggerFunc._PlayDeadEffect(obj, callback, param)
		return 
	end
	uiManager:AddGlobalUi(bosshpCom, true)

	local time = param[2];
	local frameCount = time * 5 / (1000/30)
	bosshpCom:PlayBossDeadEffect(frameCount, TriggerFunc._PlayBossDeadHPEffectEnd)

	TriggerFunc._PlayDeadEffect(obj, callback, param)
end

function TriggerFunc._PlayBossDeadHPEffectEnd(bosshpCom)
	
	uiManager:DelGlobalUi(bosshpCom)

	local mainui = GetMainUI()
	if mainui then
		mainui:AttachComponent(bosshpCom)
	else
		bosshpCom:DestroyUi()
	end
end

function TriggerFunc._PlayDeadEffect(obj,callback, param)
	AudioManager.PlayUiAudio(81200110)
	local targetPos = obj:GetPositionV3d() 
	targetPos:SetY(targetPos:GetY() + 1)
	CameraManager.MoveToPos(targetPos, param.camera_move_to_time, function ()
		TriggerFunc._PlaySlowMotion(callback, param)
	end) 
end

function TriggerFunc._PlaySlowMotion(callback, param)
    CameraManager.ZoomInAndVignetting(param.zoom_in_dist) 
    local time = param[2];
    app.set_time_scale(0.2)
    local camera = CameraManager.SetFihgtCameraBlurEffect(true)
    CameraManager.SetFightCameraBlurEffectValue(0.15,0.5,0.5,15)
    if camera then
        camera:begin_blur_tween(0.15,0,time*5)--:begin_tc_tween(0.2,1,time)
    end
    local function PlaySuccessEffectEndCallback()
	    app.set_time_scale(1)    
	    local function endCallback()
		    if callback then
		    	callback();
		    end
	    end
	    timer.create(Utility.create_callback(endCallback),param[3], 1)
    end
    timer.create(Utility.create_callback(PlaySuccessEffectEndCallback),time, 1)
    --镜头模糊   
end

function TriggerFunc.SetCamera(callback, param)
	local info = LevelMapConfigHelper.GetHeroPosePoint(param.pos_name);
	local pos
	local rot
	if info then
		pos = {info.px,info.py,info.pz};
		rot = {info.rx,info.ry,info.rz};
	else
		pos = param.pos;
		rot = param.rot;
	end
	local fov = param.fov;

	if rot then
		CameraManager.GetSceneCameraObj():set_rotation(rot[1],rot[2],rot[3]);
	end
	if pos then
		CameraManager.SetPositionV3d(Vector3d:new({x=pos[1],y=pos[2],z=pos[3]}));
	end
	if fov then
		CameraManager.GetSceneCamera():set_fov(fov);
	end
	if param.lookat == 1 then
		local scene_entity = g_dataCenter.fight_info:GetCaptain();
		local pos = scene_entity:GetBindObj(1);
		CameraManager.GetSceneCameraObj():look_at(pos:get_position());
		if rot then
			local r = {CameraManager.GetSceneCameraObj():get_rotation()};
			CameraManager.GetSceneCameraObj():set_rotation(r[1],r[2],rot[3]);
		end
	end
	if callback then
		callback();
	end
end

function TriggerFunc.Wait(callback, param)
	local function waitcallback()
		if callback then
			callback();
		end
	end
	timer.create(Utility.create_callback(waitcallback), param[2]*1000, 1);
end

function TriggerFunc.PlayScreenplay(callback,param)
    local objNameList;
    if type(param.obj) == "string" then
    	objNameList = {param.obj};
    else
    	objNameList = param.obj;
    end
    local pos = param.pos;
    local rot = param.rot;
    TriggerFunc.ScreenPlayObj = TriggerFunc.ScreenPlayObj or {};
    local objList = {};
    for k,name in pairs(objNameList) do
    	local obj;
    	if TriggerFunc.ScreenPlayObj[name] then
    		obj = TriggerFunc.ScreenPlayObj[name];
    	else
	    	local filename = ObjectManager.GetScreenPlayModelFile(name)
	    	local assetobj = ResourceManager.GetResourceObject(filename);
	    	obj = asset_game_object.create(assetobj);
	    	TriggerFunc.ScreenPlayObj[name] = obj;
	    end
	    -- obj:set_position(pos[1],pos[2],pos[3]);
	    -- obj:set_rotation(rot[1],rot[2],rot[3]);
    	table.insert(objList,obj);
    end
    local function deleycallback()
	    for k,v in pairs(objList) do
	    	v:animator_play(param.anim_name);
	    end
	end
    timer.create(Utility.create_callback(deleycallback), 1, 1);
    if param.rollback == 0 and callback then
		callback();
	end
end

-------------------播放音效--------------------
--boss警报
function TriggerFunc.BossAlarm(callback, param)
	dis_config = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_bossAlarmId)
	local audio_id = dis_config.data
	TriggerFunc.cur_audio_id,TriggerFunc.cur_audio_numAdObj = AudioManager.Play3dAudio(audio_id, AudioManager.GetUiAudioSourceNode(), true, true)
	if callback then
		callback();
	end
end

--boss出场语音
function TriggerFunc.BossAppearVoice(callback, param)
	local boss_id = param.boss
	local config = ConfigManager.Get(EConfigIndex.t_monster_property, boss_id)
	if not config then return end
	local audio_id = config.appear_voice_id
	if audio_id and audio_id ~= 0 then
		TriggerFunc.cur_audio_id,TriggerFunc.cur_audio_numAdObj = AudioManager.PlayUiAudio(audio_id)
	end
	if callback then
		callback();
	end
end

--boss死亡语音
function TriggerFunc.BossDeadVoice(callback, param)
	local bossName = FightScene.GetFightManager().curDeadList["boss"];
	local bossObj = ObjectManager.GetObjectByName(bossName);
	if not bossObj then return end
	local audio_id = bossObj:GetConfig("dead_voice_id")
	if audio_id and audio_id ~= 0 then
		AudioManager.PlayUiAudio(audio_id)
	end
	if callback then
		callback();
	end
end

function TriggerFunc.PlayBossShowUI(callback, param)
	if TriggerFunc.bossEntity then
		if type(param) == "table" then
			FightBossShowUI.Show(TriggerFunc.bossEntity:GetCardInfo().number, param.talk);
		else
			FightBossShowUI.Show(TriggerFunc.bossEntity:GetCardInfo().number);
		end
		FightBossShowUI.SetEndCallback(callback, param);
	else
		if callback then
			callback();
		end
	end
end
function TriggerFunc.PlayFightStartUI(callback, param)
	FightStartUI.Show();
	FightStartUI.SetEndCallback(callback, param);
end

function TriggerFunc.PlayTransitionUI(callback, param)
	FightEndTransitionUI.Show();
	FightEndTransitionUI.SetEndCallback(callback, param);
end

function TriggerFunc.PlayEndSound(callback, param)
	local isWin = FightRecord.IsWin()
	--app.log("isWin==="..tostring(isWin));
	AudioManager.Stop(nil, true);
	if isWin then
		AudioManager.PlayUiAudio(81010000)
	else
		AudioManager.PlayUiAudio(81010001)
	end
	if callback then
		callback();
	end
end

function TriggerFunc.GetScreenPlayObj(param)
	if TriggerFunc.ScreenPlayObj then
		return TriggerFunc.ScreenPlayObj[param]
	end
end

function TriggerFunc.DeleteScreenPlayObj(callback, param)
	if TriggerFunc.ScreenPlayObj then
		for i, v in pairs(TriggerFunc.ScreenPlayObj) do
			v:set_active(false)
		end
	end
	TriggerFunc.ScreenPlayObj = {}
	if callback then
		callback();
	end
end

function TriggerFunc.CreateObj(callback,param)
	local objFile = param.obj;
	local id = param.id;
	local pos = param.pos;
	local rot = param.rot;
	local filename = ObjectManager.GetScreenPlayModelFile(objFile)
	local assetobj = ResourceManager.GetResourceObject(filename);
	local obj = asset_game_object.create(assetobj);
    TriggerFunc.ScreenPlayObj = TriggerFunc.ScreenPlayObj or {};
	if id then
		TriggerFunc.ScreenPlayObj[id] = obj;
	else
		TriggerFunc.ScreenPlayObj[objFile] = obj;
	end
	obj:set_position(pos[1],pos[2],pos[3]);
	obj:set_rotation(rot[1],rot[2],rot[3]);

	if callback then
		callback();
	end
end

function TriggerFunc.PlayObjAnim(callback,param)
	local list = param;
	for name,animName in pairs(list) do
		local obj = TriggerFunc.ScreenPlayObj[name];
		if obj then
			obj:animator_play(animName);
		end
	end
	if param.rollback == 0 and callback then
		callback();
	end
end

function TriggerFunc.DeleteObj(callback,param)
	local nameList = param.list;
	if type(nameList) == "table" then
		for k,v in pairs(nameList) do
			local obj = TriggerFunc.ScreenPlayObj[v];
			if obj then
				obj:set_active(false);
			end
			TriggerFunc.ScreenPlayObj[v] = nil;
		end
	else
		local obj = TriggerFunc.ScreenPlayObj[nameList];
		if obj then
			obj:set_active(false);
		end
		TriggerFunc.ScreenPlayObj[nameList] = nil;
	end
	if callback then
		callback();
	end
end

function TriggerFunc.ResetMoveCamera()
	if TriggerFunc.CameraState and TriggerFunc.CameraPos and TriggerFunc.CameraRot and TriggerFunc.CameraFov then
		CameraManager.SetCameraState(TriggerFunc.CameraState);
		local cameraObj = CameraManager.GetSceneCameraObj()
		local camera = CameraManager.GetSceneCamera()
		local pos = TriggerFunc.CameraPos
		local rot = TriggerFunc.CameraRot
		cameraObj:set_position(pos[1],pos[2],pos[3])
		cameraObj:set_rotation(rot[1],rot[2],rot[3])
		camera:set_fov(TriggerFunc.CameraFov)
	end
end

function TriggerFunc.PlayVideo(callback,param)
	-- file.player_mp4(param[2], ENUM.EVideoMode.Hidden)
	-- if callback then
	-- 	callback();
	-- end

	PublicFunc.MediaPlay(param[2], callback or "", "", false, false, nil)
end

function TriggerFunc.PlayUiAudio(callback,param)
	if param and param.audio_id then
		AudioManager.PlayUiAudio(param.audio_id)
	end
	if callback then
		callback();
	end
end

function TriggerFunc.EmptyFunc(callback,param)
	if callback then
		callback();
	end
end

function TriggerFunc.CreateObstacle(callback, param)
	TriggerEffect.create_obstacle(nil, nil, param.list)
	if callback then
		callback();
	end
end

--进关卡剧情动画结束回调
function TriggerFunc.SceneEnterAnimCallback()
	ScreenPlay.FuncOver()
end

--出关卡剧情动画结束回调
function TriggerFunc.SceneExitAnimCallback()
	ScreenPlay.FuncOver()
end

--切换背景音乐
function TriggerFunc.ChangeBackAudio(callback, param)
	if param and param.audio_id then
		AudioManager.Stop(ENUM.EAudioType._2d, true)
		AudioManager.Play2dAudioList({[1]={id=param.audio_id,loop=-1}})
	end
	if callback then
		callback();
	end
end

-- type = FadeIn,FadeOut,KeepBlack
-- time = 默认1s
-- text = 文本内容
function TriggerFunc.BlackFadeEffectUI(callback, param)
	if BlackFadeEffectUi[param.type] then
		local func = function ()
			BlackFadeEffectUi.Destroy();
			if callback then
				callback();
			end
		end
		local data = 
		{
			text=param.text,
			duration=param.time,
			callback=func,
		}
		BlackFadeEffectUi[param.type](data);
	end
end

function TriggerFunc.PauseTimeTick(callback, param)
	if param.isPause == 1 then
		if FightScene.GetFightManager().tickTimer then
			timer.pause(FightScene.GetFightManager().tickTimer);
		end
		if FightScene.GetFightManager().countDownTimer then
			timer.pause(FightScene.GetFightManager().countDownTimer);
		end
		FightScene.GetFightManager():PauseLoader(true);
	else
		if FightScene.GetFightManager().tickTimer then
			timer.resume(FightScene.GetFightManager().tickTimer);
		end
		if FightScene.GetFightManager().countDownTimer then
			timer.resume(FightScene.GetFightManager().countDownTimer);
		end
		FightScene.GetFightManager():PauseLoader(false);
	end
	if callback then
		callback();
	end
end

--[[强敌来袭]]
function TriggerFunc.FightPowerfulEnemyAttack(callback, param)
	PowerfulEnemyAttackUI.Start();
	if not callback then
		return;
	end
	if param.rollback == 0 then
		callback();
	else
		PowerfulEnemyAttackUI.SetEndCallback(callback);
	end
end

function TriggerFunc.FightSuccessUI(callback, param)
	CommonKuikuliyaWinUI.Start();
	if not callback then
		return;
	end
	if param.rollback == 0 then
		callback();
	else
		CommonKuikuliyaWinUI.SetEndCallback(callback);
	end
end

function TriggerFunc.FightFailureUI(callback, param)
	CommonZuozhanshibai.Start();
	if not callback then
		return;
	end
	if param.rollback == 0 then
		callback();
	else
		CommonZuozhanshibai.SetEndCallback(callback);
	end
end

function TriggerFunc.FightLanguageUI(callback, param)
	FightLanguageUI.Start(param.type, param.text)
	if not callback then
		return;
	end
	if param.rollback == 0 then
		callback();
	else
		FightLanguageUI.SetEndCallback(callback);
	end
end

function TriggerFunc.TriggerStory(callback, param)
	app.log("story:" .. table.tostring(param));
	TriggerStory.Start(param);
	if not callback then
		return;
	end
	if param.rollback == 0 then
		callback();
	else
		TriggerStory.SetEndCallback(callback);
	end
end

function TriggerFunc.HurdlePassTip(callback, param)
	HurdlePassTip.Start(param);
	HurdlePassTip.SetEndCallback(callback);
end

--直接在动画上戳事件回调,切换背景音乐
function TriggerFunc.CallBackChangeBackAudio()
	local hurdle_id = FightScene.GetCurHurdleID();
	local cfg = ConfigManager.Get(EConfigIndex.t_hurdle, hurdle_id)
	if not cfg then return end
	local audio_id = cfg.boss_change_audioid
	if audio_id and audio_id ~= 0 then
		AudioManager.Stop(ENUM.EAudioType._2d, true)
		AudioManager.Play2dAudioList({[1]={id=audio_id,loop=-1}})
	end
end

--降低/增加背景音乐音量
function TriggerFunc.ChangeBackAudioVol(callback, param)
	if param and param.vol and param.need_time then
		AudioManager.ChangeBackAudioVol(param.end_vol, param.changeTime)
	end
end

-- 玩法引导功能
function TriggerFunc.ShowPlayGuideUI(callback)
	if not PlayGuideUI.ShowUI(callback) then
		callback();
	end
end

-- 指定怪物在剧情中可以继续ai
function TriggerFunc.IgnoreGlobalPauseState(callback, param)

	local numbers = param.number
	local enable = not param.open == 1

	local isNumber = type(numbers) == 'number'
	local isTable = type(numbers) == 'table'
	ObjectManager.ForEachObj(
		function(name, obj)

			if isNumber then
				if obj:GetConfigNumber() == numbers then
					obj:SetCareGlobalPauseState(enable)
				end
			elseif isTable then
				for k,v in pairs(numbers) do
					if obj:GetConfigNumber() == v then
						obj:SetCareGlobalPauseState(enable)
						break
					end
				end
			end

		end
	)

	callback()
end
