-- region fight_manager.lua
-- Author : kevin
-- Date   : 2015/8.18

script.run 'logic/public/assest.lua'
-- script.run 'logic/data/monster.lua'
script.run 'logic/object/fight_state.lua'
script.run 'logic/screen_play/screen_play.lua'
script.run 'logic/object/head_info_controler.lua'
script.run 'logic/object/top_object_manager.lua'

-- script.run 'logic/data/hurdle/hurdle_mapinfo/mapinfo_60052005.lua'


FightScene = {
	fightResultReport = nil, --战斗结果
	area = {}, areaTrigger = {--[[]]}, triggerRemoveTable = {}, burchMonsterTimer = {}, burchFunc = {},
    sync_targets = {}, --状态同步下的技能目标集合
    skill_targets_listener = {}, --技能目标集合监听
    world_gid = 0,
    keep_ai_agent_alive_timer_gid = nil,
    msg_skill_calculate_list = {},
    active_effect = {},
    flgPlayedSceneChange = false,
}
local levelData = nil
local sectionID = 0
local pathRes = {};
pathRes.fight_scene = "assetbundles/prefabs/fight_scene.assetbundle";
---------------------------------------------------------------------------------

EFightManagerType = {
	TowerDefenceFightManager = 1,
}



local startUpInf = nil;    -- <struct:fightSceneStartUpInf>  关卡启动信息
--local fightManagerType = nil -- <enum: EFightManagerType>
local fightManager = nil;  -- <class: EFightManagerType> 战斗管理器
local sectionID = nil;
local mapInfoID = nil;

local rimLightingObjName = nil; --被主攻英雄攻击高亮对象
local have_camera_follow_target = true;

local enable_skill = {}

local _group_loader_index = 0		-- 记录资源组索引
local _send_progress_timer = nil	-- 推送加载进度定时器
local _last_send_percent = nil		-- 记录上次推送的进度值

local currentSceneData = nil

--分时创建对象控制
local _createEntityOneByOne = false;	--是否分步创建对象
local _lastCreatEntityTime = 0;
local _entityLoadTask = {}
local _createEntityInterval = 0.1 --unit: seconds.

loadmain = {
	levelData = {
		hurdleid = nil;
		map_info = nil;
		fight_type = nil;
		fight_script = nil;
	}
}

--parms:
-- startUpInf: <class: FightStartUpInf>
function FightScene.Start(stratUpEvn, sceneData)
	
	app.log("延迟销毁的战斗结束UI")
	
	-- 延迟销毁的战斗结束UI
    CommonBattle.Destroy()
	CommonBattle3v3.Destroy()

	-- g_load_start_time = app.get_time();
	-- g_scene_loadtime = g_load_start_time
	-- g_timer_3 = g_load_start_time;
	-- g_timer_4 = g_load_start_time


	app.log("start load scene: "..app.get_time())
	FightScene.flgPlayedSceneChange = false


	app.log("1..."..table.tostring(stratUpEvn).." debug="..debug.traceback())


	ObjectManager.Init();

	--[[
	if GameInfoForThis.LoadNum == 0 then
		app.log("改为默认的值")
		startUpInf = stratUpEvn;
	else
		app.log("改为原设置的值")
		--loadmain.levelData.hurdleid = stratUpEvn.levelData.hurdleid;
		loadmain.levelData.hurdleid = GameInfoForThis.SceneInfo;
		--loadmain.levelData.map_info = stratUpEvn.levelData.map_info;
		loadmain.levelData.map_info = 0;
		--loadmain.levelData.fight_type = stratUpEvn.levelData.fight_type;
		loadmain.levelData.fight_type = 0;
		--loadmain.levelData.fight_script = stratUpEvn.levelData.fight_script;
		loadmain.levelData.fight_script = 0;
		startUpInf = loadmain;
	end
	--]]
	
	startUpInf = stratUpEvn;
    currentSceneData = sceneData

	sectionID = startUpInf.levelData.hurdleid
	mapInfoID = startUpInf.levelData.map_info

	
	FightScene.UseAddHpSkill = false;
	FightScene.SetFightManager(startUpInf.levelData.fight_type,startUpInf.levelData.fight_script);

	FightScene.SetCreateEntityPolicy(FightScene.GetFightManager():GetCreateEntityPolicy());
	app.log("FightScene==========================================11")
    ResourceLoader.LoadAsset(pathRes.fight_scene, {func=FightScene.OnStageLoaded, user_data=nil}, nil)
    app.log("FightScene==========================================22")

    Show3dText.Start()
    FightScene.active_effect = {}

end

function FightScene.IsHideLoadingBar()
    return FightScene.hideLoadingBar
end

function FightScene.SetHideLoading(value)
    FightScene.hideLoadingBar = value
end

function FightScene.InsertSceneEffect(effect_gid)
	FightScene.active_effect[effect_gid] = effect_gid
end

function FightScene.DelSceneEffect(effect_gid)
	FightScene.active_effect[effect_gid] = nil
end

function FightScene.HideAllSceneEffect()
	for k, v in pairs(FightScene.active_effect) do
		EffectManager.deleteEffect(v)
	end
end

--return <table:fightSceneStartUpInf>
function FightScene.GetStartUpEnv()
	return startUpInf;
end

function FightScene.GetPlayMethodType()
	if not startUpInf then return nil end
	return startUpInf.play_method_id;
end


function FightScene.GetPlayMethodTeamID()
	if not startUpInf then return nil end
	if startUpInf.play_method_id == nil then
		return ENUM.ETeamType.normal
	elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_MainCity then
    	return nil
    elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa then
    	return ENUM.ETeamType.kuikuliya
    elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_CloneFight then
    	return ENUM.ETeamType.clone_fight
    elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_arena then
    	return ENUM.ETeamType.arena
    elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_trial then
    	return ENUM.ETeamType.trial
    elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_ClownPlan then
    	return ENUM.ETeamType.normal
    elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang then
    	return ENUM.ETeamType.normal
 	elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi then
    	return ENUM.ETeamType.normal
    elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao then
    	return nil
    elseif startUpInf.play_method_id == MsgEnum.eactivity_time.eActivityTime_heroTrial then
        return nil
	else
		app.log("该玩法没对应阵容ID，看到的来补充下[id="..startUpInf.play_method_id.."]")
	end
	return nil
end


function FightScene.GetWorldGID()
	if not startUpInf then return nil end
	return startUpInf.world_gid;
end

function FightScene.OnFightOver()
	--app.log("Game Over.............................."..tostring(debug.traceback()));
	-- AudioManager.SetAudioListenerFollowObj(false);
	-- AudioManager.Stop();
	EffectManager.activedEffectEntityCnt = 0;
    if g_dataCenter.playMethodInfo == nil then 
        g_dataCenter.playMethodInfo = PlayMethodInfo:new()
    end
	if FightRecord.IsWin() then
		g_dataCenter.playMethodInfo:RecordInfo(startUpInf.levelData.fight_type);
	end
 
end

function FightScene.SetFightManager(fight_type, fight_script_id)
	local class_name = "RPGFightManager"
	local fight_class = nil
	if 0 ~= fight_type and nil ~= fight_type then
		class_name = ConfigManager.Get(EConfigIndex.t_fight_type,fight_type).type_name.."FightManager"
	end

	local fight_class = _G[class_name]

	fightManager = fight_class.InitInstance();

	-- ------------------------------------------------------------------
	-- -- TODO: kevin 重新定义一个默认的fightmanager.
	-- local __runAsDefault = false;
	-- if fightManager == FightManager then
	-- 	__runAsDefault = true;
	-- end
	-- fightManager:RunAsDefaultFightManager(__runAsDefault)
	-- -----------------------------------------------------------------


	if 0 ~= fight_script_id and nil ~= fight_script_id then
		-- fightManager:SetFightScript(_G["gd_fight_script_"..tostring(startUpInf.levelData.fight_script)])
		fightManager:SetFightScript(ConfigHelper.GetFightScript(startUpInf.levelData.fight_script))
	else
		-- TODO: (kevin) default rpg fight script?
	end

	if not mapInfoID or 0 == mapInfoID then
		fightManager:SetFightMapInfoID(sectionID)
	else
		fightManager:SetFightMapInfoID(mapInfoID)
	end
end

function FightScene.GetFightManager( )
	return fightManager
end

function FightScene.SetCreateEntityPolicy(createOneByOne, inteval)
	_createEntityOneByOne = createOneByOne or false
	_createEntityInterval = inteval or 0.1
end

function FightScene.OnStageLoaded(data, pid, filepath, asset_obj, error_info)
	if filepath ~= pathRes.fight_scene then
		app.log("加载战斗场景主节点失败！！！");
		return
	end

	app.log("OnStageLoaded2222222222222222222222")

	FightScene.fightScene = asset_game_object.create(asset_obj);
	asset_game_object.dont_destroy_onload(FightScene.fightScene);
	FightScene.fightScene:set_name("fightScene");


	levelData = FightScene.GetStartUpEnv().levelData

	--local scene_file = levelData.scene_file;
	--app.log(table.tostring(levelData))
	local scene_id = levelData.scene_id;
	local scene_config = ConfigManager.Get(EConfigIndex.t_scene_config, scene_id)
	if not scene_config then
		if scene_id == nil then scene_id = FightScene.GetLevelID() end
		app.log("scene_id=="..scene_id.."的scene_config没有配置");
	end
	local scene_file = scene_config.file_path
	FightScene.footstep_effect = scene_config.footstep_effect
	app.log("场景文件===="..scene_file.."关卡id==="..levelData.hurdleid);
	local scene_name = scene_config.scene_name;
	local scene_asset_list = {}
	fightManager:GetPreLoadAssetFileList(scene_asset_list)

	local misc_asset_file_list = {}
	for k, v in pairs(scene_asset_list) do
		table.insert(misc_asset_file_list, k)
	end

	local texture_file_list = {};
	fightManager:GetPreLoadTextureFileList(texture_file_list);
    local group_loader_index = ResourceLoader.CreateGroupLoader()
    ResourceLoader.AddCamera(group_loader_index)
    ResourceLoader.AddScene(group_loader_index, {scene_file, scene_name})
    ResourceLoader.AddAsset(group_loader_index, misc_asset_file_list)
    ResourceLoader.AddTexture(group_loader_index, texture_file_list)
    if fightManager.AddResourceLoad then
        fightManager:AddResourceLoad(group_loader_index)
    end

	--[[local load_task = {
		{ SceneLoader:new(),0.4, scene_file,scene_name},
		{ AssetLoader:new(),0.4, misc_asset_file_list },
		{ CameraLoader:new(), 0.1, },
		{ TextureLoader:new(), 0.1, texture_file_list },
	}]]
    FightScene.is_loading_secene = true
    if FightScene.IsHideLoadingBar() then
        FightScene.SetHideLoading(false)
        LoadHideBarScene(FightScene.OnLoadVideo, nil, nil, nil, group_loader_index);
    else
        LoadScene(FightScene.OnLoadVideo, nil, nil, nil, group_loader_index);
    end
	
end

function FightScene.GetCurHurdleID()
	return sectionID;
end

function FightScene.GetLevelID()
	return sectionID;
end

function FightScene.OnLoadVideo()
    FightScene.is_loading_secene = false
	if levelData then
		if levelData.video_path and levelData.video_path ~= 0 then
			-- file.player_mp4(levelData.video_path, ENUM.EVideoMode.Hidden);
			PublicFunc.MediaPlay(levelData.video_path, "", "", false, false, nil)
			--timer.create("FightScene.OnLoadSceneAssetsComplete", levelData.video_time * 1000, 1);
		end
		FightScene.OnLoadSceneAssetsComplete();
	else
		FightScene.OnLoadSceneAssetsComplete()
	end
end



function FightScene.GetHurdleConfig(id)

    if id == nil then
        id = sectionID
    end

	local cfg = ConfigManager.Get(EConfigIndex.t_hurdle, id)
	if nil == cfg then
		cfg = ConfigManager.Get(EConfigIndex.t_play_method_hurdle, id)
	end

	return cfg
end

-- 1 moba 2 rpg
function FightScene.IsMobaHurdle()
	local cfg = FightScene.GetHurdleConfig(sectionID)

	if nil == cfg or not cfg.fight_type then
		app.log('huhu_map_debug 当前关卡配置里面没有第16个字段！'..tostring(sectionID)..table.tostring(ConfigHelper.GetHurdleConfig(sectionID)))
	end

	return cfg.fight_type == EFightType.hurdlemoba
end

-- -- 加载各个物件，加载完成后直接放在场景上就行了。
-- function FightScene.LoadEntity()
-- 	-- 先找配置ConfigManager.Get(EConfigIndex.t_hurdle_id_entity,-- 	-- 先找配置gd_hurdle_id_entity)-- 	-- 先找配置gd_hurdle_id_entity
-- 	local config = ConfigHelper.GetMapInf(FightScene.GetCurHurdleID(),EMapInfType.entity)
-- 	-- gd_hurdle_id_entity = {{p_id = 111,x = 2,y = 1,z = 1,filename = 'sp_bighp_di'},{id = 111},{p_id = 111,x = 4,y = 1,z = 1},}
-- 	-- 创建对象
-- 	-- 创建主节点，如果res_path没有数据，就不创建了。
-- 	local count = nil;
-- 	local path = nil;
-- 	local new_entity = nil;
-- 	if MAP_RESTORE_DEBUG then
-- 		app.log('huhu_map_debug'..tostring(FightScene.GetCurHurdleID())..' 创建物件！'..table.tostring(config))
-- 	end
-- 	for k,el_v in pairs(config) do
-- 		-- 创建
-- 		if not count then
-- 			FightScene.entitys = asset_game_object.create(EffectManager.placeHolderRes);
-- 			FightScene.entitys:set_name("entitys");
-- 	        PublicFunc.obj_init(FightScene.entitys);
-- 	        FightScene.entitys:set_active(true);
-- 	        count = 0
-- 		end
-- 		-- TODO 约定物件资源存放目录，物件表名字格式。
-- 		if not el_v.filename then
-- 			app.log('huhu_map_debug 有没有配文件名字的物件 '..table.tostring(config)..table.tostring(el_v))
-- 		end
-- 		path = el_v.filename;
-- 		if not g_sceneObjRes[path] then
-- 			app.log('huhu_map_debug 没有找到对象的asset，没法创建对象了。'..tostring(el_v.filename)..' '..tostring(path))
-- 		end

-- 		new_entity = asset_game_object.create(EffectManager.placeHolderRes);

--         new_entity:set_parent(FightScene.entitys);
--         PublicFunc.SetGameObjPos3(new_entity,el_v);

-- 		count = count + 1;
-- 	end
-- end

--ml_v: {p_id = 111,x = 2,y = 1,z = 1,p_code = {at = 3000,i = 3000}}
function FightScene.BurchAt(ml_v,createfunc)

	if MAP_RESTORE_DEBUG then
		--app.log('huhu_map_debug'..tostring(FightScene.GetCurHurdleID())..' 刷怪偏移时间到了。'..table.tostring(ml_v))
	end
	if ml_v.i then
		local funcname = Utility.gen_callback(FightScene.BurchInterval,ml_v,createfunc)
		table.insert(FightScene.burchFunc,funcname);
		local timerid = timer.create(funcname,ml_v.i,ml_v.c);
		table.insert(FightScene.burchMonsterTimer,timerid);
	else
		local newmonster = createfunc(ml_v.id,ml_v.flag);
		if newmonster then
			newmonster:SetPosition(ml_v.px,ml_v.py,ml_v.pz)
			newmonster:SetRotation(ml_v.rx,ml_v.ry,ml_v.rz)
			newmonster:SetScale(ml_v.sx,ml_v.sy,ml_v.sz)
		end
	end
end

function FightScene.BurchInterval(ml_v,createfunc)
	if MAP_RESTORE_DEBUG then
		app.log('huhu_map_debug'..tostring(FightScene.GetCurHurdleID())..' 刷怪时间到了。'..table.tostring(ml_v))
	end
	local newmonster = createfunc(ml_v.id,ml_v.flag);
	if newmonster then
		newmonster:SetPosition(ml_v.px,ml_v.py,ml_v.pz)
		newmonster:SetRotation(ml_v.rx,ml_v.ry,ml_v.rz)
		newmonster:SetScale(ml_v.sx,ml_v.sy,ml_v.sz)
	end
end

function FightScene.ExitFightScene()
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld then
        SceneManager.ReplaceByMainCityScene()
    else
	    SceneManager.PopScene(FightScene);
    end
end

function FightScene.GetCurrentUpSceneUIMgr()
    local sceneData = SceneManager.GetCurrentUpSceneData()
    if sceneData then
        return sceneData.uiMgr
    end
end

--[[场景载入成功后回调]]
function FightScene.OnLoadSceneAssetsComplete()
	 --[[清除]]
	SceneLoading.Destroy()
	--[[战斗空节点]]
	Root.get_root_ui_2d_fight():set_active(false);
	--[[注册Update]]
	Root.AddUpdate(FightScene.Update);
	--[[设定投像机]]
	--CameraManager.init();


--	TouchManager.Init();--[[弹射全屏触屏UI]]

	--光圈管理器
	ApertureManager.CreateEffect()
	-- if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
 --    	ApertureManager.CreateEffect()
 --    end
	--[[小地图]]
    -- mini_map.init();
    -- FightMap.init();

	--[[战斗初始化]]
	--Fight.Init();



	--[[场景对象创建]]
	-- 物件
	-- FightScene.LoadEntity();
	-- 怪
	-- FightScene.LoadMonster();
	-- 英雄些
	--FightScene.LoadHero();
	-- 场上的道具
	-- FightScene.LoadItem();

	--fightManager:Start()


	--[[特效]]
	EffectManager.Start();
	--[[音效  暂停主城]]
	--AudioManager.Stop(nil, true);
	--AudioManager.Destroy();
	--播放战斗音效  --随机播放
	local h_cfg = FightScene.GetHurdleConfig(sectionID)
	if h_cfg then
		if h_cfg.back_audio1 then
			local audio_id = h_cfg.back_audio1;
			if audio_id ~= 0 then
				if sectionID == 61000000 and FightScene.isResume == true then
			        uiManager = currentSceneData.uiMgr
			        local scene_id = uiManager.ui_stack[#uiManager.ui_stack];
			        local ui_audio_id = uiManager:GetBackAudioId(scene_id)
			        if not ui_audio_id or ui_audio_id == audio_id then
			        	AudioManager.Play2dAudioList({[1]={id=audio_id,loop=-1}})
			        end
			    else
					AudioManager.Play2dAudioList({[1]={id=audio_id,loop=-1}})
			    end
			end
		end

		-- if h_cfg.back_audio2 then
		-- 	local audio_id = 81000013;
		-- 	if h_cfg.back_audio2 ~= 0 then
		-- 		audio_id = h_cfg.back_audio2;
		-- 		AudioManager.Play2dAudioList({[1]={id=audio_id,loop=1}}, ENUM.EAudioPlayMode.Loop, ENUM.EAudioPlayer.p2)
		-- 	end
		-- end

		if h_cfg.scene_id and h_cfg.scene_id ~= 0 then
			local scene_config = ConfigManager.Get(EConfigIndex.t_scene_config, h_cfg.scene_id)
			if not scene_config then
				app.log("scene_id=="..h_cfg.scene_id.." 的关卡没有scene_config");
			end
			local audio_id = scene_config.environmental_audio_id
			if audio_id and audio_id ~= 0 then
				--app.log("11111111播放环境音效id=="..tostring(audio_id));
				AudioManager.Play2dAudioList({[1]={id=audio_id,loop=-1}}, ENUM.EAudioPlayMode.Loop, ENUM.EAudioPlayer.p2)
			end
			local obj_audio_config = scene_config.obj_audio_config
			if obj_audio_config and obj_audio_config ~= 0 then
				for k,v in pairs (obj_audio_config) do
					local obj_path = v.obj_path
					local id = v.audio_id
					--app.log("obj_path=="..tostring(obj_path).."   id==="..tostring(id));
					local obj = asset_game_object.find(obj_path)
					if obj then
						AudioManager.Play3dAudio(id, obj, false, true, false, false)
					else
						app.log("路径为:  "..tostring(obj_path).."  的场景物件不存在,无法播放音效,请检查scene_config配置文件");
					end
				end
			end
		end
	end

	--AudioManager.Play2dAudioList({[1]={id=9,loop=-1}}, ENUM.EAudioPlayMode.Loop, ENUM.EAudioPlayer.p2)

	if MAP_RESTORE_DEBUG then
		app.log('map_debug LoadEntity 地图资源已经加载完成了。5')
	end
	--初始化关卡技能屏蔽
	FightScene.HurdleSkillShield();

	--TODO : 临时修改, 针对主城 
	--必须在uiManager 恢复之前
    --[[local c =  asset_game_object.find("background_root");
	if nil ~= c then
		local cg = c:get_child_by_name("login_background");
		CameraManager.SetLoginBackGroundCamera(cg);
	end]]
    local c = asset_game_object.find("p_zhuejiemian");
    if nil ~= c then
        CameraManager.SetLoginBackGroundCamera(c);
    end

    if FightScene.isResume ~= true then
        currentSceneData.uiMgr = UiManager:new()
        uiManager = currentSceneData.uiMgr
        currentSceneData.uiMgr:Begin()
    else
        uiManager = currentSceneData.uiMgr
        currentSceneData.uiMgr:Restart()
        -- currentSceneData.uiMgr:Show()
    end

	

	fightManager:Start()

	if have_camera_follow_target then

	else
		CameraManager.LookToPos(Vector3d:new({x=4.2,y=0,z=7.5}));
	end
	have_camera_follow_target = true;

    --CameraManager.LookToPos({x=4.22,y=0,z=7.5});

		--[[战斗UI]]
	--FightUI.Start();
	--关卡剧情
    --ps:优化一下，mmo的地图就加载所有的mmo的剧情，这样允许多个mmo地图共享一条剧情数据。
    local hurdleid = FightScene.GetLevelID();
    ScreenPlay.Clean();
    if ScreenPlay.isMMoMap(hurdleid) then
        ScreenPlay.LoadMMoConfig();
    else
        ScreenPlay.LoadConfig(FightScene.GetLevelID());
    end


	
     

    
    HeadInfoControler.LoadRes()
		-- 检查摄像机准备好了没
	--FightScene.checkFightResOkTimer = timer.create('FightScene.CheckFightResOk', 100, -1);

	if _send_progress_timer then
		timer.stop(_send_progress_timer)
		_send_progress_timer = nil
	end

end

-- 检查摄像机准备好了没
-- function FightScene.CheckFightResOk()
-- 	if not CameraManager.CheckOk() then
-- 		return
-- 	end
-- 	timer.stop(FightScene.checkFightResOkTimer);
-- 	--[[战斗开始]]


-- 	fightManager:Start()

-- 		--[[战斗UI]]
-- 	--FightUI.Start();
-- 	--关卡剧情

-- 	ScreenPlay.LoadConfig(FightScene.GetLevelID());

-- 		ObjectManager.ForEachObj(function (objname,obj)
-- 		obj:OnFightStart();
-- 	end)


--     HeadInfoControler.LoadRes()



-- 	--加载战斗飘血字
-- 	-- HpTextUi.Start();
-- end

-- --[[触发器清空]]
-- function FightScene.CheckTrigger()
-- 	for k,v in pairs(FightScene.areaTrigger) do
-- 		if v:IsTrigger() then
-- 			if v:Trigger() then
-- 				table.insert(FightScene.triggerRemoveTable,k);
-- 			end
-- 		end
-- 	end
-- 	-- 需要清空的清空
-- 	for i,v in ipairs(FightScene.triggerRemoveTable) do
-- 		delete(FightScene.areaTrigger[v])
-- 		table.remove(FightScene.areaTrigger, v)
-- 	end
-- 	FightScene.triggerRemoveTable = {}
-- end

function FightScene.Update( deltaTime )
	--todo：伤害协议定时每帧发送合并的包
	if table.getn(FightScene.msg_skill_calculate_list) > 0 then
		-- app.log("伤害包----"..table.getn(FightScene.msg_skill_calculate_list)..table.tostring(FightScene.msg_skill_calculate_list))
		msg_fight.cg_skill_calculate_multi(FightScene.msg_skill_calculate_list)
		FightScene.msg_skill_calculate_list = {}
	end

    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.FrameSync then
        deltaTime = PublicStruct.S_Each_Frame
    end

    FightScene.__LoadEntityObjByFrame();

    PublicStruct.Cur_Logic_Frame = PublicStruct.Cur_Logic_Frame+1;
	ObjectManager.Update(deltaTime)
	if not fightManager then
		return
	end
	fightManager:Update(deltaTime)

    if currentSceneData and currentSceneData.uiMgr then
        currentSceneData.uiMgr:Update(deltaTime)
    end

	--UI更新
	--FightUI.Update(deltaTime);
	--头顶飘字更新
	-- HpTextUi.Update();

    -- 需要屏蔽，因为在播放战斗结束boss展示动画时，会关掉主摄像机导致报错
    FightScene.CheckPrintEntityState()

    for k,v in pairs(FightScene.skill_targets_listener) do
        if PublicFunc.QueryDeltaTime(v.time) > 5000 then
            if v.action then
                v.action._actionState = eBuffActionState.Over
            end
            FightScene.skill_targets_listener[k] = nil
        end
    end
end

function FightScene.Pause(sceneData)
    FightScene.isPause = true

    --保存当前scene data，以便resume还原
    sceneData.loadData = startUpInf


    FightScene.Destroy(sceneData)
end

function FightScene.Resume(sceneData)
    FightScene.Start(sceneData.loadData, sceneData)
    FightScene.isResume = true
end

function FightScene.SetCheckPrintEntityStateClick(is)
    FightScene.CheckPrintEntityStateClick = is

    app.log('CheckPrintEntityStateClick ' .. tostring(is))
end

function FightScene.GetCheckPrintEntityStateClick()
    return FightScene.CheckPrintEntityStateClick
end

function FightScene.CheckPrintEntityState()
    --if FightScene.CheckPrintEntityStateClick == true then
        local isClick,x,y = util.get_click()
        if isClick then
            local fight_camera = CameraManager.GetSceneCamera();
            if fight_camera == nil then
                return
            end
            local layer_mask = PublicFunc.GetBitLShift({PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster});
            local result, hit = fight_camera:raycast_out_screen(x,y,100,layer_mask);
            if result then
                local selectedObj = ObjectManager.GetObjectByName(hit.game_object:get_name())
                if selectedObj ~= nil then
                    local skillid = '';
                    if selectedObj.last_used_skill ~= nil then
                        skillid = selectedObj.last_used_skill
                    end
                    local logString = selectedObj:GetName() .." config_ai:" .. tostring(selectedObj:GetConfig("ai")) .. ' current_ai:' .. tostring(selectedObj:GetAI()) .. ' State:' .. tostring(selectedObj:GetObjHFSMState()) .. '\n'
                    local entityLog = selectedObj:GetObjLog()
                    if false and string.len(entityLog) > 0 then
                        logString = logString .. selectedObj:GetObjLog() .. '\n\n'
                        selectedObj:ClearLog()
                    end
                    logString = logString .. 'skilliscomplete:' .. tostring(selectedObj:GetLastSkillComplete()) .. ' skillid:' .. tostring(skillid) .. ' outOfControl:' .. tostring(selectedObj:IsBeControlOrOutOfControlState()) .. '\n'
                    logString = logString .. "id:" .. tostring(selectedObj:GetConfig("id")) .. ' view_radius = ' .. tostring(selectedObj:GetConfig('view_radius')) .. ' act_radius:' .. tostring(selectedObj:GetConfig('act_radius')) .. ' move_speed:' .. tostring(selectedObj:GetConfig('move_speed')) .. ' current_speed:' .. tostring(selectedObj:GetSpeed()) .. '\n'
                    logString = logString .. 'type = ' ..  tostring(selectedObj:GetType()) .. ' attackType = ' .. tostring(selectedObj:GetAttackType()) .. '\n'
                    logString = logString .. "fight_state = "..table.tostring(selectedObj.fight_state_targets) .. '\n'
                    logString = logString .. "wait_finish_skill = "..table.tostring(selectedObj.wait_finish_skill) .. '\n'
                    
                    for k, v in pairs(selectedObj:GetBuffManager()._arrbuff) do
                        logString = logString .. "buff id="..v:GetBuffID().." lv="..v:GetBuffLv().." overlap="..v:GetOverLap() .. '\n'
                    end

                    app.log_warning(logString)
                end
            end
        end
    --end
end

-- 查找对象
local LayerFindObj = {
	PublicStruct.UnityLayer.monster,
	PublicStruct.UnityLayer.player,
}
function FightScene.FindObject( pos,radius,dir,angle,layer,exceptname )
	if layer == nil then
		layer = PublicFunc.GetBitLShift(LayerFindObj)
	end
	local objList = algorthm.GetOverlapSphere( pos,radius,dir,angle,layer )
	if not objList then
		return nil;
	end
	local roleList = {}
	for k,v in pairs(objList) do
		local r = v:get_name()
		if r and r ~= exceptname then
			table.insert(roleList,r)
		end
	end
	return roleList
end

--[[得到出生点目标]]
function FightScene.GetHeroBornPos(camp_flag,index)
	local config = ConfigHelper.GetMapInf(tostring(FightScene.GetFightManager():GetFightMapInfoID()),EMapInfType.burchhero)
	if not config then
		return
	end
	local i = 0
	for k, ml_v in pairs(config) do
		if ml_v.flag and ml_v.flag == camp_flag then
			i = i + 1
			if i == index or not index then
				return ml_v.px,ml_v.py,ml_v.pz;
			end
		end
	end
end

--[[搜索区域目标]]
function FightScene.SearchAreaTarget(pos, radius, direct, angle, layerMark)
    layerMark = layerMark or {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster}
    layerMark = PublicFunc.GetBitLShift(layerMark)
    local targets = algorthm.GetOverlapSphere(pos, radius, direct, angle, layerMark);
    if (targets ~= nil) then
        if (not Utility.isEmpty(targets)) then
        	for k, v in pairs(targets) do
        		local entity = v-- ObjectManager.GetObjectByName(v:get_name());
        		if entity and not entity:GetCanSearch() then
        			targets[k] = nil;
        		end
        	end
            return true,targets;
        end
    end
    return false,nil;
end

local _sortSrcObj = nil
local _sortHeroPriority = false
local Sort_Target_By_Nearest_Distance = function(a, b)
    if _sortHeroPriority == true then
        if a.objType ~= b.objType then
            if a.objType == OBJECT_TYPE.HERO then
                return true
            elseif b.objType == OBJECT_TYPE.HERO then
                return false
            end
        end
    end
    local pos_self = _sortSrcObj:GetPosition(true);
    local pos_a = a:GetPosition(true);
    local disa = algorthm.GetDistance(pos_a.x, pos_a.z, pos_self.x, pos_self.z);
    local pos_b = b:GetPosition(true);
    local disb = algorthm.GetDistance(pos_b.x, pos_b.z, pos_self.x, pos_self.z);
    return disa < disb
end

local Sort_Target_By_Farest_Distance = function(a, b)
    local pos_self = _sortSrcObj:GetPosition(true);
    local pos_a = a:GetPosition(true);
    local disa = algorthm.GetDistance(pos_a.x, pos_a.z, pos_self.x, pos_self.z);
    local pos_b = b:GetPosition(true);
    local disb = algorthm.GetDistance(pos_b.x, pos_b.z, pos_self.x, pos_self.z);
    return disa > disb
end

local Sort_Target_By_Make_Damage = function(a, b)
    return a._makeDamage > b._makeDamage
end

local sort_by_min_hp_pos = nil
local Sort_Target_By_Min_HP = function(a, b)
	local persenta = a:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/a:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
	local persentb = b:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/b:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
	if persenta ~= persentb then
		return persenta < persentb
	end
	if sort_by_min_hp_pos then
		local pos_a = a:GetPosition(true);
	    local disa = algorthm.GetDistance(pos_a.x, pos_a.z, sort_by_min_hp_pos.x, sort_by_min_hp_pos.z);
	    local pos_b = b:GetPosition(true);
	    local disb = algorthm.GetDistance(pos_b.x, pos_b.z, sort_by_min_hp_pos.x, sort_by_min_hp_pos.z);
	    return disa < disb
   	end
    return false
end

local Sort_Target_By_Max_HP = function(a, b)
    return a:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/a:GetPropertyVal(ENUM.EHeroAttribute.max_hp) > b:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/b:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
end

local _standardSortSrcObj = nil
local _standardSortRadius = nil
local _standardSortSrcPos = nil
local Sort_Standard = function(a, b)
	if a.objType ~= b.objType then
        if a.objType == OBJECT_TYPE.HERO then
            return true
        elseif b.objType == OBJECT_TYPE.HERO then
            return false
        end
    elseif a.objType == OBJECT_TYPE.MONSTER and b.objType == OBJECT_TYPE.MONSTER then
    	if a:GetSubType() ~= b:GetSubType() then
    		if a:GetSubType() == ENUM.EMonsterType.SceneItem then
    			return false;
    		elseif b:GetSubType() == ENUM.EMonsterType.SceneItem then
    			return true
    		end
    	end
    end
    if _standardSortSrcPos and _standardSortRadius then
	    local pos_a = a:GetPosition(true);
	    local disa = algorthm.GetDistance(pos_a.x, pos_a.z, _standardSortSrcPos.x, _standardSortSrcPos.z);
	    local pos_b = b:GetPosition(true);
	    local disb = algorthm.GetDistance(pos_b.x, pos_b.z, _standardSortSrcPos.x, _standardSortSrcPos.z);
		if disa <= _standardSortRadius and disb > _standardSortRadius then
			return true
		elseif disa > _standardSortRadius and disb <= _standardSortRadius then
			return false
		end
	end
	if a.objType == OBJECT_TYPE.HERO and b.objType == OBJECT_TYPE.HERO then
		local persenta = (a:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/a:GetPropertyVal(ENUM.EHeroAttribute.max_hp))
		local persentb = (b:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/b:GetPropertyVal(ENUM.EHeroAttribute.max_hp))
		if persenta ~= persentb then
			return persenta < persentb
		end
	end
	if _standardSortSrcPos then
	    local pos_a = a:GetPosition(true);
	    local disa = algorthm.GetDistance(pos_a.x, pos_a.z, _standardSortSrcPos.x, _standardSortSrcPos.z);
	    local pos_b = b:GetPosition(true);
	    local disb = algorthm.GetDistance(pos_b.x, pos_b.z, _standardSortSrcPos.x, _standardSortSrcPos.z);
		return disa < disb
	end
	return false
end
--[[搜索区域目标]]
function FightScene.SearchAreaTargetEx(enemy, pos, radius, direct, angle, layerMark, sourceFounder, arrTarget, targetCnt, sorttype, buffID, buffLv, founder, includeFounder, sortRadius)
    layerMark = layerMark or {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster}
    layerMark = PublicFunc.GetBitLShift(layerMark)
    local targets = algorthm.GetOverlapSphere(pos, radius, direct, angle, layerMark);
    local targetRet = {}
    local targetIndex = 1
    if founder and includeFounder == true and founder:GetCanSearch() and (not founder:IsDead()) then
    	targetRet[targetIndex] = founder
        targetIndex = targetIndex+1
    end
    if (targets ~= nil) then
        if (not Utility.isEmpty(targets)) then
            --up by:EwingChow
            for k, v in pairs(targets) do
                local entity = v
                --app.log_warning("entity name="..entity:GetName())
                if entity ~= nil and (entity ~= founder) and (not entity:IsDead()) and ((not sourceFounder) or sourceFounder:CheckSearchTarget(entity, enemy)) and entity:GetCanSearch() and (not entity:IsHide()) and (not entity:IsKidnap()) then
                    if (buffID == nil and buffLv == nil) then
                    	--app.log("entity name="..entity.name.." founder name="..founder.name)
                        targetRet[targetIndex] = entity
                        targetIndex = targetIndex+1
                    elseif entity:IsBuffExist(buffID, buffLv) == true then
                        targetRet[targetIndex] = entity
                        targetIndex = targetIndex+1
                    end
                end
            end
        end
    end
    --[[if includeFounder == true and (not founder:IsDead()) and (enemy ==founder:IsEnemy(sourceFounder)) then
        targetRet[targetIndex] = founder
        targetIndex = targetIndex+1
    end]]
    local nLen = #targetRet
    if nLen ~= 0 then
        if sorttype == 0 then
            _sortSrcObj = founder
            _sortHeroPriority = false
            table.sort(targetRet, Sort_Target_By_Nearest_Distance)
        elseif sorttype == 1 then
            _sortSrcObj = founder
            _sortHeroPriority = true
            table.sort(targetRet, Sort_Target_By_Nearest_Distance)
        elseif sorttype == 2 then
            table.sort(targetRet, Sort_Target_By_Make_Damage)
        elseif sorttype == 3 then
            _standardSortSrcObj = founder
            _standardSortRadius = sortRadius
            if founder then
            	_standardSortSrcPos = founder:GetPosition(true)
            else
            	_standardSortSrcPos = nil
            end
            table.sort(targetRet, Sort_Standard)
            --[[if _standardSortSrcPos and _standardSortSrcObj:IsMyControl() then
            	app.log_warning("排序结果 srcPos="..table.tostring(_standardSortSrcPos))
            	for i=1, #targetRet do
	            	app.log_warning(targetRet[i]:GetName().." pos="..table.tostring(targetRet[i]:GetPosition(true)))
            	end
            end]]
        elseif sorttype == 4 then
        	if founder then
        		sort_by_min_hp_pos = founder:GetPosition(true)
        	else
        		sort_by_min_hp_pos = nil
        	end
            table.sort(targetRet, Sort_Target_By_Min_HP)
        elseif sorttype == 5 then
        	_sortSrcObj = founder
        	table.sort(targetRet, Sort_Target_By_Farest_Distance)
        elseif sorttype == 6 then
            table.sort(targetRet, Sort_Target_By_Max_HP)
        end
    end
    if targetCnt ~= nil then
        nLen = math.min(nLen,targetCnt)
    end
    for i=1, nLen-#arrTarget do
    	table.insert(arrTarget, targetRet[i]);
    end
    --app.log("cnt="..#arrTarget)
end

--[[搜索目标矩形内的对像]]
function FightScene.SearchRectangleTarget(enemy, pos, direct, length, width, layerMark, sourceFounder, arrTarget, targetCnt, sorttype, founder, includeFounder, buffID, buffLv, aroundradius)
    layerMark = layerMark or {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster}
    layerMark = PublicFunc.GetBitLShift(layerMark)
    if aroundradius then
   		pos.x = pos.x - direct.x*aroundradius
   		pos.z = pos.z - direct.z*aroundradius
   		length  = length + aroundradius
   	end
    local targetRet = {}
    local targetIndex = 1
    local targets = algorthm.GetOverlapRectangle(pos, direct, length, width, layerMark);
    if (targets ~= nil) then
        if (not Utility.isEmpty(targets)) then
            for k, v in pairs(targets) do
                    local entity = v --ObjectManager.GetObjectByName(name)
                    if entity~= nil and entity ~= founder and (not entity:IsDead()) and ((not sourceFounder) or sourceFounder:CheckSearchTarget(entity, enemy)) and entity:GetCanSearch() and (not entity:IsHide()) and (not entity:IsKidnap()) then
                        if (buffID == nil and buffLv == nil) then
                            targetRet[targetIndex] = entity
                            targetIndex = targetIndex+1
                        elseif entity:IsBuffExist(buffID, buffLv) == true then
                            targetRet[targetIndex] = entity
                            targetIndex = targetIndex+1
                        end
                    end
	          -- end
            end
        end
    end
    if founder and includeFounder == true and founder:GetCanSearch() and (not founder:IsDead()) then
    	targetRet[targetIndex] = founder
        targetIndex = targetIndex+1
    end
    -- if includeFounder == true and (not founder:IsDead()) and (enemy == founder:IsEnemy(sourceFounder)) then
    --     targetRet[targetIndex] = founder
    --     targetIndex = targetIndex+1
    -- end
    local nLen = #targetRet
    if nLen ~= 0 then
        if sorttype == 0 then
            _sortSrcObj = founder
            _sortHeroPriority = false
            table.sort(targetRet, Sort_Target_By_Nearest_Distance)
        end
    end
    if targetCnt ~= nil then
        nLen = math.min(nLen,targetCnt)
    end
    for i=1, nLen-#arrTarget do
    	table.insert(arrTarget, targetRet[i]);
    end
end

function FightScene.SearchHeroTarget(enemy, sourceFounder, sorttype, includeFounder, founder, arrTarget, targetCnt, radius)
    local targetRet = {}

    if founder and includeFounder == true and founder:GetCanSearch() and (not founder:IsDead()) then
    	table.insert(targetRet,founder);
    end
    local pos = nil
    if founder then
    	pos = founder:GetPosition()
    end
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
    	local heroList = g_dataCenter.fight_info:GetHeroList(i);
    	for k, v in pairs(heroList) do
    		local entity = ObjectManager.GetObjectByName(v)
    		if entity ~= nil and (entity ~= founder) and (not entity:IsDead()) and ((not sourceFounder) or sourceFounder:CheckSearchTarget(entity, enemy)) and entity:GetCanSearch() and (not entity:IsHide()) and (not entity:IsKidnap()) then
    			local insert = true
    			if radius and radius ~= 0 and pos then
    				local target_pos = entity:GetPosition()
    				local dis = algorthm.GetDistance(pos.x, pos.z, target_pos.x, target_pos.z);
    				if dis > radius then
    					insert = false
    				end
    			end
    			if insert then
    				table.insert(targetRet,entity);
    			end
    		end
    	end
    end

	local nLen = #targetRet
    if nLen ~= 0 then
        if sorttype == 0 then
            _sortSrcObj = founder
            _sortHeroPriority = false
            table.sort(targetRet, Sort_Target_By_Nearest_Distance)
        elseif sorttype == 1 then
            _sortSrcObj = founder
            _sortHeroPriority = true
            table.sort(targetRet, Sort_Target_By_Nearest_Distance)
        elseif sorttype == 2 then
            table.sort(targetRet, Sort_Target_By_Make_Damage)
        elseif sorttype == 3 then
            _sortSrcObj = founder
            _sortHeroPriority = false
            table.sort(targetRet, Sort_Target_By_Nearest_Distance)
        elseif sorttype == 4 then
            table.sort(targetRet, Sort_Target_By_Min_HP)
        elseif sorttype == 5 then
        	_sortSrcObj = founder
        	table.sort(targetRet, Sort_Target_By_Farest_Distance)
        elseif sorttype == 6 then
            table.sort(targetRet, Sort_Target_By_Max_HP)
        end
    end
    if targetCnt ~= nil then
        nLen = math.min(nLen,targetCnt)
    end
    for i=1, nLen-#arrTarget do
        table.insert(arrTarget, targetRet[i]);
    end
end

--[[创建特效]]
function FightScene.CreateEffect(pos, cfg, cbfunction, cbdata, target, direction, durationTime, _speed, handlehit, skill_id)
    local eventCfg = {}
    local uuid = {}
    local uuid_index = 1


    for i=1, #cfg.id do
        eventCfg.type = cfg.type
        eventCfg.id = cfg.id[i]
        eventCfg.pos = cfg.pos[i]
        eventCfg.offset = cfg.offset[i]
        eventCfg.bind = cfg.bind[i]
        eventCfg.speed = cfg.speed
        eventCfg.maxlen = cfg.maxlen
        eventCfg.hited_effect_seq = cfg.hited_effect_seq
        eventCfg.hited_action_seq = cfg.hited_action_seq
        eventCfg.hited_repel_dis = cfg.hited_repel_dis
        eventCfg.description = cfg.description
        eventCfg.angle = cfg.angle
        local delTime = durationTime
        if delTime == nil then
			local _effect_cfg = ConfigManager.Get(EConfigIndex.t_all_effect,eventCfg.id)
            if eventCfg and _effect_cfg and _effect_cfg.time and _effect_cfg.time ~= 0 then
                delTime = _effect_cfg.time * 0.001
            else
                delTime = EffectManager.fightEffectDelTime
            end
        elseif delTime == 0 then
            delTime = nil
        end
        local finalSpeed = eventCfg.speed
        if _speed then
            finalSpeed = _speed
        end
        if eventCfg.type == ENUM.EffectType.Fixed or eventCfg.type == nil then
            --if direction == nil then
                local effect_obj = EffectManager.createEffect(eventCfg.id, delTime)
                if effect_obj then
                    effect_obj:set_position(pos.x, pos.y, pos.z)
                    if direction then
                    	effect_obj:set_forward(direction.x, direction.y, direction.z)
                    end
                    uuid[uuid_index] = effect_obj:GetGID()
                    effect_obj.is_scene_effect = true
                    FightScene.InsertSceneEffect(effect_obj:GetGID())
                    uuid_index = uuid_index+1
                end
            --[[else
                	EffectManager.createActionEffect( {
                    effect_id = eventCfg.id,
                    speed = finalSpeed,
                    start_pos = pos,
                    direct = direction,
                    target = target,
                    bind_pos = eventCfg.pos,
                    callback_collision = cbfunction,
                    user_data = cbdata,
                    use_time = 1,
                    skill_id = skill_id,
                } )
            end]]
        elseif eventCfg.type == ENUM.EffectType.Emitter then
            if nil ~= target and (not target.finalized) then
                EffectManager.createActionEffect( {
                    cfg = eventCfg,
                    type = eventCfg.type,
                    effect_id = eventCfg.id,
                    speed = finalSpeed,
                    start_pos = pos,
                    target = target,
                    bind_pos = eventCfg.pos,
                    callback_collision = cbfunction,
                    user_data = cbdata,
                    handlehit = handlehit,
                    skill_id = skill_id,
                } )
            else
                EffectManager.createActionEffect( {
                    effect_id = eventCfg.id,
                    speed = finalSpeed,
                    start_pos = pos,
                    direct = direction,
                    use_time = 0.4,
                    skill_id = skill_id,
                } )
            end
        elseif eventCfg.type == 4 then
            if nil ~= target and (not target.finalized) then
                EffectManager.createActionEffect( {
                    cfg = eventCfg,
                    type = eventCfg.type,
                    effect_id = eventCfg.id,
                    speed = finalSpeed,
                    start_pos = pos,
                    target = target,
                    bind_pos = eventCfg.pos,
                    callback_collision = cbfunction,
                    user_data = cbdata,
                    handlehit = handlehit,
                    skill_id = skill_id,
                    src_angle = eventCfg.angle
                } )
            else
                EffectManager.createActionEffect( {
                    effect_id = eventCfg.id,
                    speed = finalSpeed,
                    start_pos = pos,
                    direct = direction,
                    use_time = 0.4,
                    skill_id = skill_id,
                    src_angle = eventCfg.angle
                } )
            end
        end

    end
    return uuid
end

-- function FightScene.RefreshReservedRes()
--     -- if FightScene.GetPlayMethodType() ==  MsgEnum.eactivity_time.eActivityTime_openWorld then
--     -- ResourceManager.ClearReservedRes()
--     -- ResourceManager.AddReservedRes(g_dataCenter.fight_info:GetControlHeroSkillAssets())
--     -- ResourceManager.AddReservedRes(g_dataCenter.fight_info:GetControlHeroModelAssets())
--     -- end
-- end

function FightScene.Destroy()
	app.log("FightScene.Destroy...........")

    if fightManager then
        fightManager:OnBeginDestroy()
    end

	-- 刷新保留资源
    -- FightScene.RefreshReservedRes()
	startUpInf = nil;
    --[[清空剧情对象]]
    ScreenPlay.Destroy()
	--[[清空跟随对像]]
	CameraManager.clear_follow_tar();
	--[[取消注册战斗回调]]
	Root.DelUpdate(FightScene.Update)
	--[[小地图清空]]
	mini_map.Destroy();
	FightMap.Destroy();
	-- TODO 清理场上怪物
	-- TODO 清理触发点
	-- PlayerManager.Destroy()
	TouchManager.Destroy()
	CameraManager.Destroy()
	
	--销毁战斗ui
	--app.log("关闭ui");
	--FightUI.Destroy();
	--释放战斗飘血字
	-- HpTextUi.Destroy();

    if currentSceneData and currentSceneData.uiMgr then
        if FightScene.isPause ~= true and  currentSceneData.uiMgr then
            currentSceneData.uiMgr:DestroyAll(true)
            currentSceneData.uiMgr = nil
        else
        	if currentSceneData.uiMgr then
            	currentSceneData.uiMgr:DestroyAll()
            	-- currentSceneData.uiMgr:Hide()
            end
        end
    end
	-- 清理所有的场上活动对象
	ObjectManager.Destroy();
	--清理光圈
	ApertureManager.DestroyEffect()
    --应该值为 nil,但是防止全局调用uiManager出错，赋值一个没用的uiManager
    uiManager = g_uiManager

	--释放战斗对象
	-- Fight.Destroy();
	--停止并释放战斗音效
    AudioManager.SetAudioListenerFollowObj(false);
	--AudioManager.Stop(nil, true);
	--AudioManager.Destroy();

	--释放所有角色asset对象
	ResourceManager.GC(false, true);


    ResourceLoader.ClearGroupCallBack()
	--[[特效]]
	EffectManager.Destroy();
	--释放所有战斗特效
	EffectManager.DestroyAllEffectObj();
	--[[取消注册回调事件]]
	for i,v in ipairs(FightScene.burchFunc) do
		Utility.del_callback(v);
	end
    if FightScene.fightScene then
	    FightScene.fightScene:set_active(false);
	    FightScene.fightScene = nil;
    end
    g_dataCenter.fight_info:ClearUp()

    if fightManager then
        fightManager:Destroy()
        fightManager = nil
    end
    FightScene.StopAIAgentKeepAlive()

    currentSceneData = nil
    FightScene.isResume = nil
    FightScene.isPause = nil

    --OGM.Clear("assetbundles/prefabs/ui/fight/panel_smallhp.assetbundle")
    --OGM.Clear("assetbundles/prefabs/ui/fight/fight_num_dy.assetbundle")
    OGM.ClearAll()
    PublicFunc.HideAllUiFightChild()
    HeadInfoControler.DestroyPart()
    TopObjectManager.ClearObjPool();
end

function FightScene.DeleteObjByObj(obj)
    local obj_name = obj:GetName()
    if fightManager then
	    fightManager:OnEvent_OnDeleteObj(obj_name)
    end
	g_dataCenter.fight_info:DeleteObj(obj_name)

	ObjectManager.DeleteObjByObj(obj)
end

---management
function FightScene.DeleteObj(obj_name, time_delay)
	local obj = ObjectManager.GetObjectByName(obj_name)
	if nil ~= obj then
		obj:PostEvent("Pause");
		--obj:GetObject():set_active(false)
	end
    if time_delay and time_delay > 0 then
		timer.create(Utility.create_callback(FightScene.DeleteObj, obj_name, 0), time_delay, 1)
		return
	end
    if fightManager then
	    fightManager:OnEvent_OnDeleteObj(obj_name)
    end
	g_dataCenter.fight_info:DeleteObj(obj_name)

	ObjectManager.DeleteObj(obj_name)
end


function FightScene.CreateHero(fight_player_id, index, camp_flag, country_id, level, uuid, package_source, gid)
	if nil == index or 0 == index then
		app.log("FightScene.CreateHero: index is nil or zero.")
		return nil
	end
	local obj = ObjectManager.CreateHero(fight_player_id, index, camp_flag, country_id, level, uuid, package_source, gid, nil, false, CREATE_OBJ_MODEL_OPTION.REAL_MODEL)
    if obj then
        obj:OnCreate()
        obj:SetOwnerPlayerGID(fight_player_id)
        g_dataCenter.fight_info:AddHero(obj)
    end
	--fightManager:OnLoadHero(obj);
	return obj
end

--playMethodAcitvityTimeEnum:玩法ActivityTime的ID
function FightScene.CreateHeroAsync(fight_player_id, index, camp_flag, country_id, level, uuid, package_source, gid, playMethodAcitvityTimeEnum)
 	local filename = ObjectManager.GetHeroModelFile(index);
	if filename == nil then
        app.log("模型名字未找到，id="..index);
		return;
	end
    -- local use_temp_model = (ResourceManager.GetRes(filename) == nil)
    local hero,use_temp_model = ObjectManager.CreateHero(fight_player_id, index, camp_flag, country_id, level, uuid, package_source, gid, nil, false, CREATE_OBJ_MODEL_OPTION.AUTO,playMethodAcitvityTimeEnum)
    if hero then
        hero:OnCreate()
        hero:SetOwnerPlayerGID(fight_player_id)
        g_dataCenter.fight_info:AddHero(hero)
        if use_temp_model then
            local function AsyncHeroLoadOK(pid, filepath, asset_obj, error_info)
            	if not _createEntityOneByOne then
	                hero:ChangeObject(asset_obj)
	            else
	                FightScene.__addEntityLoadTask(hero, asset_obj)
	            end
            end
            hero.change_obj = false
            ResourceLoader.LoadAsset(filename, AsyncHeroLoadOK, nil)
	    end
        return hero;
    end
end

function FightScene.CreateTrialHeroAsync(fight_player_id,cardTrial,camp_flag, uuid)
	local filename = ObjectManager.GetHeroModelFile(cardTrial.number);
	if filename == nil then
        app.log("模型名字未找到，id="..index);
		return;
	end
    -- local use_temp_model = (ResourceManager.GetRes(filename) == nil)
    local hero,use_temp_model = ObjectManager.CreateTrialHero(fight_player_id, cardTrial, camp_flag, uuid,CREATE_OBJ_MODEL_OPTION.TEMP_MODEL)
    if hero then
        hero:OnCreate()
        hero:SetOwnerPlayerGID(fight_player_id)
        g_dataCenter.fight_info:AddHero(hero)
        if use_temp_model then
            local function AsyncHeroLoadOK(pid, filepath, asset_obj, error_info)
            	if not _createEntityOneByOne then
	                hero:ChangeObject(asset_obj)
	            else
	                FightScene.__addEntityLoadTask(hero, asset_obj) 
	            end
            end
            hero.change_obj = false
            ResourceLoader.LoadAsset(filename, AsyncHeroLoadOK, nil)
	    end
        return hero;
    end
end 

function FightScene.CreateNoPreLoadHero(fight_player_id, index, camp_flag, country_id, level, uuid, package_source, gid)
    local filename = ObjectManager.GetHeroModelFile(index);
	if filename == nil then
        app.log("模型名字未找到，id="..index);
		return;
	end
    -- local use_temp_model = (ResourceManager.GetRes(filename) == nil)
    local hero, use_temp_model = ObjectManager.CreateHero(fight_player_id, index, camp_flag, country_id, level, uuid, package_source, gid, nil, false, CREATE_OBJ_MODEL_OPTION.TEMP_MODEL)
    if hero then
        hero:OnCreate()
        hero:SetOwnerPlayerGID(fight_player_id)
        g_dataCenter.fight_info:AddHero(hero)
        if use_temp_model then
            local function HeroLoadOK(pid, filepath, asset_obj, error_info)
            	if not _createEntityOneByOne then
	                hero:ChangeObject(asset_obj)
	            else
					FightScene.__addEntityLoadTask(hero, asset_obj)
				end
            end
            hero.change_obj = false
            ResourceLoader.LoadAsset(filename, HeroLoadOK, nil)
	    end
        return hero;
    end
end

function FightScene.CreateNPC(id, camp_flag, gid)
	if id == nil or id == 0 then
		app.log("FightScene.CreateNPC: index is nil or zero.")
		return nil;
	end
	--level = level or 1;

	local obj = ObjectManager.CreateNPC(id, camp_flag, gid, CREATE_OBJ_MODEL_OPTION.REAL_MODEL)
    if obj then
        obj:OnCreate()
        g_dataCenter.fight_info:AddNPC(obj)
        --fightManager:OnLoadMonster(obj);
    end
	return obj
end

function FightScene.CreateMMONPC(id, camp_flag, gid)
	if id == nil or id == 0 then
		app.log("FightScene.CreateMMONPC: index is nil or zero.")
		return nil;
	end

	local obj = ObjectManager.CreateMMONPC(id, camp_flag, gid, CREATE_OBJ_MODEL_OPTION.REAL_MODEL)
    if obj then
        obj:OnCreate()
        g_dataCenter.fight_info:AddNPC(obj)
    end
	return obj
end

function FightScene.CreateMMONPCAsync(id, camp_flag, gid)
	if id == nil or id == 0 then
		app.log("CreateMMONPCAsync: index is nil or zero.")
		return nil;
	end

	local filename = ObjectManager.GetMMONpcModelFile(id);
	if filename == nil then
        app.log("CreateMMONPCAsync 模型名字未找到，id="..id);
		return;
	end

	local obj, use_temp_model = ObjectManager.CreateMMONPC(id, camp_flag, gid, CREATE_OBJ_MODEL_OPTION.TEMP_MODEL)
    if obj then
        obj:OnCreate()
        g_dataCenter.fight_info:AddNPC(obj)
        fightManager:OnLoadNPC(obj);
        if use_temp_model then
			local function AsyncLoadMMONPCOK(pid, filepath, asset_obj, error_info)
				if not _createEntityOneByOne then
					obj:ChangeObject(asset_obj)
				else
					FightScene.__addEntityLoadTask(obj, asset_obj)
				end
	        end
	        obj.change_obj = false
			ResourceLoader.LoadAsset(filename, AsyncLoadMMONPCOK, nil)
        else
            local cfg = ConfigManager.Get(EConfigIndex.t_npc_data,id)
            if cfg.model_id ~= 80002002 then
                timer.create(Utility.create_callback_ex(FightScene.DelayPlayNPCAni, true, 0, obj), 1000, 1);
            end
		end
    end
	return obj
end

function FightScene.DelayPlayNPCAni(obj)
    local cfg = obj.config;
    if cfg.init_action then
        obj:PlayAnimate(cfg.init_action);
    else
        obj:PlayAnimate(EANI.npcstand);
    end
end

function FightScene.CreateNPCAsync(id, team_flag,gid)
	if id == nil or id == 0 then
		app.log("FightScene.CreateNPC: index is nil or zero.")
		return nil;
	end
	--level = level or 1;

	local filename = ObjectManager.GetNpcModelFile(id);

	local obj, use_temp_model = ObjectManager.CreateNPC(id, team_flag, gid, CREATE_OBJ_MODEL_OPTION.TEMP_MODEL)
    if obj then
        obj:OnCreate()
        g_dataCenter.fight_info:AddNPC(obj)
        fightManager:OnLoadNPC(obj);
        --fightManager:OnLoadMonster(obj);

        if use_temp_model then
			local function AsyncLoadNPCOK(pid, filepath, asset_obj, error_info)
				if not _createEntityOneByOne then
		            obj:ChangeObject(asset_obj)
		        else
		            FightScene.__addEntityLoadTask(obj, asset_obj)
		        end
	        end
	        obj.change_obj = false
	        ResourceLoader.LoadAsset(filename, AsyncLoadNPCOK, nil)
	    end
    end
	return obj
end
function FightScene.CreateMonster(fight_player_id, index, camp_flag,gid,level)
	if index == nil or index == 0 then
		app.log("FightScene.CreateMonster: index is nil or zero.")
		return nil;
	end
	level = level or 1;

	local obj = ObjectManager.CreateMonster(index, camp_flag, gid,level, CREATE_OBJ_MODEL_OPTION.AUTO)
    if obj then
        obj:OnCreate()
        g_dataCenter.fight_info:AddMonster(obj)
        --fightManager:OnLoadMonster(obj);
    end
	return obj
end

function FightScene.CreateSummoneUnitAsync(fight_player_gid, id, gid, camp_flag, country_id, card_source)

	local obj, use_temp_model = ObjectManager.CreateSummoneUnit(fight_player_gid, id, gid, camp_flag, country_id, card_source, CREATE_OBJ_MODEL_OPTION.AUTO)
	if obj then
		if use_temp_model then
			local function AsyncLoadSummoneUnitOK(pid, filepath, asset_obj, error_info)
				if not _createEntityOneByOne then
					obj:ChangeObject(asset_obj);
				else
					FightScene.__addEntityLoadTask(obj, asset_obj)
				end
			end

			obj.change_obj = false
			ResourceLoader.LoadAsset(filename, AsyncLoadSummoneUnitOK, nil)
		end
	end
end

function FightScene.__addEntityLoadTask(obj, asset_obj)
	_entityLoadTask[obj] = asset_obj;
end

function FightScene.__LoadEntityObjByFrame()
	local now = app.get_time();
	if now - _lastCreatEntityTime < _createEntityInterval then
		return;
	end

	_lastCreatEntityTime = now

	for k, v in pairs(_entityLoadTask) do
		if nil ~= v then
			k:ChangeObject(v)
			_entityLoadTask[k] = nil
			return;
		end
	end
end


function FightScene.CreateMonsterAsync(fight_player_id, index, team_flag,gid,level, group_name, begin_anim)
	if index == nil or index == 0 then
		app.log("FightScene.CreateMonsterAsync: index is nil or zero. " .. debug.traceback())
		return nil;
	end
	level = level or 1;

	local filename = ObjectManager.GetMonsterModelFile(index);

	local obj, use_temp_model = ObjectManager.CreateMonster(index, team_flag, gid,level, nil, CREATE_OBJ_MODEL_OPTION.AUTO, group_name, begin_anim)
	-- app.log("async create monster:"..tostring(obj).. ", use temp mode "..tostring(use_temp_model))
    if obj then
        obj:OnCreate()
        g_dataCenter.fight_info:AddMonster(obj)
        --fightManager:OnLoadMonster(obj);
        if use_temp_model then
--	app.log("xxxxxxxxxxxxxxxxxuse_temp_model1")
			local function AsyncMonsterLoadOK(pid, filepath, asset_obj, error_info)
	--app.log("xxxxxxxxxxxxxxxxxuse_temp_model2")
				if not _createEntityOneByOne then
	--app.log("xxxxxxxxxxxxxxxxxuse_temp_model3")
		            obj:ChangeObject(asset_obj)
		        else
	--app.log("xxxxxxxxxxxxxxxxxuse_temp_model4")
		            FightScene.__addEntityLoadTask(obj, asset_obj)
		        end
	        end
	        obj.change_obj = false
	        ResourceLoader.LoadAsset(filename, AsyncMonsterLoadOK, nil)
	    end
    end
	return obj
end


function FightScene.CreateItem(fight_player_id, model_id, camp_flag, trigger_id, item_effectid, gid, config_id, is_opened)
	-- TODO:(kevin) fight_player_id ?
	local msg = {trigger_id, camp_flag, model_id, item_effectid}

	-- TODO: kevin createItem 是否需要异步支持
	local obj,use_temp_model = ObjectManager.CreateItem(trigger_id, camp_flag, model_id, item_effectid, gid, config_id, is_opened)
	if obj then
		if use_temp_model then
	        local function AsyncMonsterLoadOK(pid, filepath, asset_obj, error_info)
	            obj:ChangeObject(asset_obj)
	        end
        	obj.change_obj = false
        	if model_id == 0 then
		        model_id = 80002002;
		    end
        	local filename = ObjectManager.GetItemModelFile(model_id)
        	ResourceLoader.LoadAsset(filename, AsyncMonsterLoadOK, nil)
    	end
	    g_dataCenter.fight_info:AddItem(obj)
	end
	-- fightManager:OnLoadItem(obj)
    return obj,use_temp_model
end

function FightScene.CreateItemAsync(fight_player_id, model_id, camp_flag, trigger_id, item_effectid, gid, config_id, is_opened)

    local obj, use_temp_model = FightScene.CreateItem(fight_player_id, model_id, camp_flag, trigger_id, item_effectid, gid, config_id, is_opened)

    if use_temp_model then
        local function AsyncMonsterLoadOK(pid, filepath, asset_obj, error_info)
            obj:ChangeObject(asset_obj)
        end
        obj.change_obj = false

        local filename = ObjectManager.GetItemModelFile(model_id)
        ResourceLoader.LoadAsset(filename, AsyncMonsterLoadOK, nil)
    end

    return obj
end

function FightScene.GetFightTime()
	return fightManager:_GetFightTime()
end

function FightScene.SetCurtRimLightObj(cur_obj)

	--boss 是长亮的。。。。。。
	if nil == cur_obj or cur_obj:IsBasis() or cur_obj:IsBoss() then
		return
	end

	local obj = ObjectManager.GetObjectByName(rimLightingObjName);
	if nil ~= obj then
		obj:ShowRimLight(false);
	end

	if nil ~= cur_obj then
		rimLightingObjName = cur_obj:GetName()
		cur_obj:ShowRimLight(true)
	end
end

function FightScene.GetCurRimLightName()
	return rimLightingObjName;
end

function FightScene.CreatePVPHero(create_data)
    local filename = ObjectManager.GetHeroModelFile(create_data.config_id);
	if filename == nil then
        app.log("模型名字未找到，id="..create_data.config_id);
		return;
	end

    -- local use_temp_model = (ResourceManager.GetRes(filename) == nil)
    --app.log("gid"..create_data.player_gid.." camp="..create_data.camp_flag.." x="..create_data.x.." y="..create_data.y)
    local hero, use_temp_model = ObjectManager.CreateHero(create_data.owner_gid, create_data.config_id, create_data.camp_flag, create_data.country_id, create_data.level, nil, nil,
    				 create_data.player_gid, nil, true, CREATE_OBJ_MODEL_OPTION.TEMP_MODEL)
    if hero then
    --[[临时关掉，为了能进游戏]]
        if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion or
		   FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2 or
           FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
            hero:SetDontReborn(true)
        end
        hero:SetProperty(ENUM.EHeroAttribute.move_speed, create_data.move_speed);
        hero:SetProperty(ENUM.EHeroAttribute.attack_speed, create_data.attack_speed);
        hero:SetProperty(ENUM.EHeroAttribute.max_hp, create_data.max_hp);
        hero:SetProperty(ENUM.EHeroAttribute.cur_hp, create_data.cur_hp);
        if hero.navMeshAgent then
            hero.navMeshAgent:set_speed(create_data.move_speed)
            hero:RecordSpeedFromServer(create_data.move_speed)
            if create_data.original_move_speed then
            	hero.original_move_speed = create_data.original_move_speed
            else
        		hero.original_move_speed = create_data.move_speed
            end
        end
        hero:SetOwnerPlayerGID(create_data.owner_gid)
        hero:SetVIPLevel(create_data.vip_level)
        hero:SetGuildName(create_data.guild_name)
        hero:SetPosition(create_data.x, 5, create_data.y)
		hero:SetBornPoint(create_data.x, 5, create_data.y)
        hero:SetRotation(0, create_data.rotation or 0, 0);
        hero:SetCaptain(create_data.captain)
        PublicFunc.UnifiedScale(hero)
        --app.log("创建英雄"..hero:GetGID().." x="..create_data.x.." y="..create_data.y)
        if create_data.cur_hp == 0 then
            hero._buffManager:CheckRemove(eBuffPropertyType.RemoveOnDead)
            hero:SetState(ESTATE.Dead)
            hero:PlayAnimate(EANI.dead)
        else
            hero:SetState(ESTATE.Stand)
        end
        hero:OnCreate()
        for k, v in ipairs(create_data.skill) do
            hero:LearnSkill(v.id, v.level, nil, PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX+k)
        end
        hero.sync_type = create_data.sync_type
        hero:SetOwnerPlayerName(create_data.owner_name)
        g_dataCenter.fight_info:AddHero(hero)

        fightManager:OnLoadHero(hero);

        if create_data.cur_hp ~= 0 and (create_data.des_x ~= 9999 or create_data.des_y ~= 9999) then
            local desX,desY,desZ = hero:GetPositionXYZ();
            desX = create_data.des_x*PublicStruct.Coordinate_Scale_Decimal
            desZ = create_data.des_y*PublicStruct.Coordinate_Scale_Decimal
            hero:SetDestination(desX, 0, desZ)
            hero:LookAt(desX,desY,desZ)
            hero:SetState(ESTATE.Run)
        end

        if create_data.owner_gid == g_dataCenter.player.playerid then
            --hero:SetAI(114)
            local card_human = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, create_data.config_id)
            hero.mmo_card = card_human
        else
            --hero:SetAI(115)
        end







        --↑↑↑↑↑↑↑↑↑↑↑↑↑   这段逻辑放最后
        if use_temp_model then
            local function PVPHeroLoadOK(pid, filepath, asset_obj, error_info)
            	if not _createEntityOneByOne then
	                hero:ChangeObject(asset_obj)
	            else
	                FightScene.__addEntityLoadTask(hero, asset_obj)
	            end
            end
            hero.change_obj = false
            ResourceLoader.LoadAsset(filename, PVPHeroLoadOK, nil)
	    end
    end
end

function FightScene.CreatePVPMonster(create_data)
    local filename = ObjectManager.GetMonsterModelFile(create_data.config_id);
	if filename == nil then
        app.log("monster模型名字未找到，id="..create_data.config_id);
		return;
	end
    local data = {
        not_init_data = true,
    }
    local config = ObjectManager.MonsterConfigToRole(ConfigManager.Get(EConfigIndex.t_monster_property,create_data.config_id))
    local card = nil

    -- local use_temp_model = (ResourceManager.GetRes(filename) == nil)
    local monster, use_temp_model = ObjectManager.CreateMonster(create_data.config_id, create_data.camp_flag, create_data.monster_gid, create_data.level, card, CREATE_OBJ_MODEL_OPTION.TEMP_MODEL)
    if monster then
    	monster:SetCanSearch(create_data.can_search);
        monster:SetDontReborn(true)
        monster:EnableBehavior(false)
        monster:SetProperty(ENUM.EHeroAttribute.move_speed, create_data.move_speed);
        monster:SetProperty(ENUM.EHeroAttribute.max_hp, create_data.max_hp);
        monster:SetProperty(ENUM.EHeroAttribute.cur_hp, create_data.cur_hp);
        if monster.navMeshAgent then
            monster.navMeshAgent:set_speed(create_data.move_speed)
            monster:RecordSpeedFromServer(create_data.move_speed)
            if create_data.original_move_speed then
            	monster.original_move_speed = create_data.original_move_speed
            else
        		monster.original_move_speed = create_data.move_speed
            end
        end
        monster:SetPosition(create_data.x, 5, create_data.y)
		local born_x = create_data.born_x
		local born_y = 1
		local born_z = create_data.born_y

		--app.log(monster.name..".................."..tostring(create_data.rotation))
		monster:SetRotation(0, create_data.rotation, 0);
        if monster.navMeshAgent then
            monster:SetNavFlag(true, false)
	        local bRet, hit = util.raycase_out4(born_x, 20, born_z, 0, -1, 0, 50, PublicFunc.GetBitLShift({PublicStruct.UnityLayer.terrain}));
	        if not bRet then
	            bRet, born_x, born_y, born_z = util.get_navmesh_sampleposition(create_data.born_x, 5, create_data.born_y, 15);
	        else
	            born_x = hit.x
	            born_y = hit.y
	            born_z = hit.z
	        end
	        if not bRet then
	            born_x = create_data.born_x
	            born_y = 0.1;
	            born_z = create_data.born_y
	        end
            monster:SetNavFlag(false, true)
        end
        monster:SetBornPoint(born_x, born_y, born_z)
        monster:SetHomePosition({x=born_x, y=born_y, z=born_z})
        if create_data.cur_hp == 0 then
            monster._buffManager:CheckRemove(eBuffPropertyType.RemoveOnDead)
            monster:SetState(ESTATE.Dead)
            monster:PlayAnimate(EANI.dead)
        else
            monster:SetState(ESTATE.Stand)
        end
        monster:OnCreate()
        g_dataCenter.fight_info:AddMonster(monster)
        fightManager:OnLoadMonster(monster);
        if create_data.cur_hp ~= 0 and (create_data.des_x ~= 9999 or create_data.des_y ~= 9999) then
            local desX,desY,desZ = monster:GetPositionXYZ();
            desX = create_data.des_x*PublicStruct.Coordinate_Scale_Decimal
            desZ = create_data.des_y*PublicStruct.Coordinate_Scale_Decimal
            monster:SetDestination(desX, 0, desZ)
            monster:LookAt(desX,desY,desZ)
            monster:SetState(ESTATE.Run)
        end

        monster:SetAI(115)






        --这段逻辑放最后
        if use_temp_model then
            local function MonsterLoadOK(pid, filepath, asset_obj, error_info)
            	if not _createEntityOneByOne then
	                monster:ChangeObject(asset_obj)
	            else
	               FightScene.__addEntityLoadTask(monster, asset_obj)
	            end
            end
            monster.change_obj = false
            ResourceLoader.LoadAsset(filename, MonsterLoadOK, nil)
	    end
    end
end

function FightScene.SetCameraFollowTarget(isFollow)
	have_camera_follow_target = isFollow;
end

function FightScene.FillSkillTargets(skillCreator, targets, skill_action, register_listener, actionTimes)
    local targetsData = FightScene.sync_targets[skillCreator:GetGID()]
    if actionTimes == nil then
    	actionTimes = skill_action._actionTimes
    end
    local local_targets_index = PublicFunc.GenerateSkillTargetIndex(nil, skill_action._buff._skillID, skill_action._buff._buffBaseData.id, skill_action._trigger._triggerData.trigger_index, skill_action._actionData.action_index, actionTimes)
    if targetsData ~= nil then
        local _targetsData = targetsData[local_targets_index]
        if _targetsData ~= nil then
            for i=1, #_targetsData do
                if i > 1 then
                    local target = ObjectManager.GetObjectByGID(_targetsData[i])
                    if target then
                        table.insert(targets, target)
                        --app.log("找到目标"..target:GetName())
                    end
                end
            end
            targetsData[local_targets_index] = nil
            return true
        else
            --app.log("找不到目标对象")
            if register_listener then
            	--app.log("监听1 "..local_targets_index.." gid="..skillCreator:GetGID().." "..debug.traceback())
                --skill_action._buff._skillID, skill_action._buff._buffBaseData.id, skill_action._trigger._triggerData.trigger_index, skill_action._actionData.action_index, skill_action._actionTimes,
                FightScene.AddSkillTargetsListener(skillCreator:GetGID(), local_targets_index, skill_action, actionTimes)
            end
            return false
        end
    else
        --app.log("找不到目标对象")
        if register_listener then
        	--app.log("监听2 "..local_targets_index.." gid="..skillCreator:GetGID().." "..debug.traceback())
            --skill_action._buff._skillID, skill_action._buff._buffBaseData.id, skill_action._trigger._triggerData.trigger_index, skill_action._actionData.action_index, skill_action._actionTimes,
            FightScene.AddSkillTargetsListener(skillCreator:GetGID(), local_targets_index, skill_action, actionTimes)
        end
        return false
    end
end

function FightScene.AddSkillTargets(skill_creator_gid, skill_id, buff_id, trigger_index, action_index, action_ref, targets_gid)
    if FightScene.sync_targets[skill_creator_gid] == nil then
        FightScene.sync_targets[skill_creator_gid] = {}
    end
    local targets_key = PublicFunc.GenerateSkillTargetIndex(nil, skill_id, buff_id, trigger_index, action_index, action_ref)
    FightScene.sync_targets[skill_creator_gid][targets_key] = {}
    FightScene.sync_targets[skill_creator_gid][targets_key][1] = PublicFunc.QueryCurTime()
    for i=1, #targets_gid do
        FightScene.sync_targets[skill_creator_gid][targets_key][i+1] = targets_gid[i]
    end
    --app.log("添加"..targets_key.." gid="..skill_creator_gid)
    local listener = FightScene.skill_targets_listener[""..skill_creator_gid..targets_key]
    if listener then
        listener.action:RunAction(true, listener.actionTimes)
        FightScene.skill_targets_listener[""..skill_creator_gid..targets_key] = nil
    end
end

function FightScene.AddSkillTargetsListener(skill_creator_gid, targets_key, skill_action, actionTimes)
    FightScene.skill_targets_listener[""..skill_creator_gid..targets_key] = {}
    FightScene.skill_targets_listener[""..skill_creator_gid..targets_key].action = skill_action
    FightScene.skill_targets_listener[""..skill_creator_gid..targets_key].actionTimes = actionTimes
    FightScene.skill_targets_listener[""..skill_creator_gid..targets_key].time = PublicFunc.QueryCurTime()
end

function FightScene.BeginAIAgentKeepAlive()
    if FightScene.keep_ai_agent_alive_timer_gid == nil then
        FightScene.keep_ai_agent_alive_timer_gid = timer.create("FightScene.OnAIAgentKeepAlive", 5000, -1)
    end
end

function FightScene.StopAIAgentKeepAlive()
    if FightScene.keep_ai_agent_alive_timer_gid then
        timer.stop(FightScene.keep_ai_agent_alive_timer_gid)
        FightScene.keep_ai_agent_alive_timer_gid = nil
        g_dataCenter.fight_info.ai_agent_target_gid = {}
    end
end

function FightScene.OnAIAgentKeepAlive()
    local targets = {}
    for k,v in pairs(g_dataCenter.fight_info.ai_agent_target_gid) do
        table.insert(targets, v)
    end
    msg_fight.cg_ai_agent_keep_alive(targets)
end
--关卡技能屏蔽的初始化
function FightScene.HurdleSkillShield()
    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    if cf then
        enable_skill[1] = 1;
        enable_skill[2] = cf.add_hp;
        enable_skill[3] = cf.is_useskill_1;
        enable_skill[4] = cf.is_useskill_2;
        enable_skill[5] = cf.is_useskill_3;
    end
end
--获取关卡屏蔽开关
--index==1:普功，2加血3下4中5上
function FightScene.GetHudleSkillEnable(index)
	return enable_skill[index]>0,enable_skill[index];
end
--return  ENUM.AreaRel
function FightScene.GetAreaRel()
    local world_gid =  FightScene.GetWorldGID()
    local result = ENUM.AreaRel.Self
     local world_info  =nil
    if world_gid and  world_gid >0 then
      world_info =  ConfigManager.Get(EConfigIndex.t_world_info,world_gid)
        if   world_info then
          if world_info.country_id ==  g_dataCenter.player:GetCountryId() then
              result  = ENUM.AreaRel.Self
          elseif world_info.fight_restirct ~= 0  then
              result = ENUM.AreaRel.Enemy
          end
        end
    end
    return result,world_info
end

function FightScene.IsPauseState()
    return ScreenPlay.IsRun()
end
