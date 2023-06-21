

-- SceneBase = Class("SceneBase")

-- local pathRes = {};
-- pathRes.fight_scene = "assetbundles/prefabs/fight_scene.assetbundle";

-- SceneBase.isInherit = true

-- function SceneBase:Start(stratUpEvn)

--     ObjectManager.Init();
--     self.loadData = stratUpEvn;

--     ResourceLoader.LoadAsset(pathRes.fight_scene, {func=SceneBase.OnStageLoaded, user_data=self}, nil)
-- end

-- function SceneBase:Pause()
--     local levelData = self.loadData
--     self:Destroy()
--     self.loadData = levelData
-- end

-- function SceneBase:Update(dt)
-- end

-- function SceneBase:Resume()
--     if self.loadData == nil then
--         app.log('self.loadData == nil resume failed')
--     else
--         self:Start(self.loadData)
--     end
-- end

-- function SceneBase:Destroy()
--     ObjectManager.Destroy()

--     CameraManager.Destroy()

--     self.fightScene:set_active(false)
--     self.fightScene = nil
--     self.loadData = nil
-- end

-- function SceneBase:OnStageLoaded(pid, filepath, asset_obj, error_info)
-- 	if filepath ~= pathRes.fight_scene then
-- 		app.log("load fightscene node error");
-- 		return
-- 	end

-- 	self.fightScene = asset_game_object.create(asset_obj);
-- 	asset_game_object.dont_destroy_onload(self.fightScene);
-- 	self.fightScene:set_name("fightScene")
--     self:LoadAll()
-- end

-- function SceneBase:LoadAll()
    
--     local ld = self.loadData.levelData

-- 	-- local scene_file = ld.scene_file;
--  --    local scene_name = ld.scene_name;
--     local scene_id = ld.scene_id;
-- 	local scene_config = ConfigManager.Get(EConfigIndex.t_scene_config, scene_id)
-- 	if not scene_config then
-- 		app.log("scene_id=="..scene_id.."的scene_config没有配置");
-- 	end
-- 	local scene_file = scene_config.file_path
-- 	--app.log("场景文件===="..scene_file.."关卡id==="..ld.hurdleid);
-- 	local scene_name = scene_config.scene_name;

    
-- 	local scene_asset_list = {} 

-- 	local misc_asset_file_list = {}
--     self:GetPreLoadAssetFileList(scene_asset_list)
-- 	for k, v in pairs(scene_asset_list) do
-- 		table.insert(misc_asset_file_list, k)
-- 	end
--     local group_loader_index = ResourceLoader.CreateGroupLoader()
-- 	ResourceLoader.AddCamera(group_loader_index)
--     ResourceLoader.AddScene(group_loader_index, {scene_file, scene_name})
--     ResourceLoader.AddAsset(group_loader_index, misc_asset_file_list)
--     self:AddSubLoadStep(group_loader_index)
-- 	LoadScene(self.OnLoadSceneAssetsComplete, self, nil, nil, group_loader_index);
-- end

-- function SceneBase:AddSubLoadStep()

-- end

-- function SceneBase:GetPreLoadAssetFileList(out)
-- end

-- function SceneBase:OnLoadSceneAssetsComplete()
--     -- need to impl in sub class
--     app.log('SceneBase:OnLoadSceneAssetsComplete !!')
-- end

-- function SceneBase:GetCurHurdleID()
--     return self.loadData.levelData.hurdleid
-- end

-- function SceneBase:GetHeroBornPos(camp_flag,index)
-- 	local config = ConfigHelper.GetMapInf(tostring(self:GetCurHurdleID()),EMapInfType.burchhero)
-- 	if not config then
--         app.log('SceneBase:GetHeroBornPos config is nil!')
--         return 0, 0, 0
-- 	end
-- 	local i = 0
-- 	for k, ml_v in pairs(config) do
-- 		if ml_v.flag and ml_v.flag == camp_flag then
-- 			i = i + 1
-- 			if i == index or not index then
-- 				return ml_v.px,ml_v.py,ml_v.pz;
-- 			end
-- 		end
-- 	end

--     app.log('SceneBase:GetHeroBornPos ERROR!')
--     return 0, 0, 0
-- end

-- function SceneBase:GetNPCAssetFileList(out_file_list)
--     local config = ConfigHelper.GetMapInf(tostring(self:GetCurHurdleID()),EMapInfType.monster)
-- 	if not config then
-- 		return
-- 	end

--     local filepath = nil;
-- 	for k, ml_v in pairs(config) do
-- 		if ml_v.id ~= nil and ml_v.id ~= 0 then
-- 			filepath = ObjectManager.GetMonsterModelFile(ml_v.id)		 
-- 			out_file_list[filepath] = filepath
-- 		end
-- 	end
-- 	config = ConfigHelper.GetMapInf(tostring(self:GetCurHurdleID()),EMapInfType.burchmonster)
-- 	if not config then
-- 		return
-- 	end
-- 	for k, ml_v in pairs(config) do
-- 		if ml_v.id ~= nil and ml_v.id ~= 0 then
-- 			filepath = ObjectManager.GetMonsterModelFile(ml_v.id)
-- 			out_file_list[filepath] = filepath
-- 		end
-- 	end
-- end

-- function SceneBase:GetItemAssetFileList(out_file_list)
-- 	local config = ConfigHelper.GetMapInf(tostring(self:GetCurHurdleID()),EMapInfType.item)
-- 	local filepath = nil;
-- 	if not config then
-- 		return
-- 	end
-- 	for k, ml_v in pairs(config) do
-- 		if ml_v.item_modelid ~= nil and ml_v.item_modelid > 0 then
-- 			filepath = ObjectManager.GetItemModelFile(ml_v.item_modelid)
-- 			out_file_list[filepath] = filepath
-- 		end
-- 	end
-- end

-- function SceneBase:GetStartUpEnv()
--     return self.loadData
-- end

-- function SceneBase:GetHeroBornPoint(name)
-- 	local config = ConfigHelper.GetMapInf(tostring(self:GetCurHurdleID()),EMapInfType.burchhero)
-- 	local point;
-- 	for k,v in pairs(config) do
-- 		if v.obj_name == name then
-- 			point = v;
-- 			break;
-- 		end
-- 	end
-- 	return point;
-- end