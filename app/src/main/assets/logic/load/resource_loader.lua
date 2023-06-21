--[[
region resource_loader.lua
date: 2015-11-9
time: 14:35:33
acuthor: Nation
]]
script.run("logic/manager/resource_manager.lua")
ResourceLoader = {
    coroutine_index = 1,
    group_loader_params = {},
    group_loader_index = 0,
    loaded_call_back_func = {}, -- { "xxx_file" = {unloadRawFile = false, groups = {} } , {}, ...}
    asset_loader.set_max_parallel_cnt(10);   --设置同时加载文件数量（默认3）
    assetObjLoader = asset_loader.create("asset_obj_loader"),
    preload_group = "group_loader",
    fight_group = "fight_loader",
    texture_group = "texture_loader",

    process_asset_loading = false,
    asset_loaded_list = {},


    flag_release_raw_asset_obj = true, -- tips: false: 新版本webstream占用内存已经修复。 kevin@2017.10


    -- TODO: keivn 首次加载场景使用
    first_load_scene_res = true;
}

function ResourceLoader.InitLoader()
    ResourceLoader.assetObjLoader:set_callback("ResourceLoader_OnAssetLoaded")
end

function ResourceLoader.Destroy()
    ResourceLoader.loaded_call_back_func = {}
    ResourceLoader.asset_loaded_list = {}
end

function ResourceLoader.CreateGroupLoader()
    ResourceLoader.group_loader_index = ResourceLoader.group_loader_index + 1
    ResourceLoader.group_loader_params[ResourceLoader.group_loader_index] = {}
    local params = ResourceLoader.group_loader_params[ResourceLoader.group_loader_index]
    params.scene_task = nil
    params.asset_task = {}
    params.texture_task = {}
    params.network_task = {}
    params.load_camera = false
    params.finish_scene_num = 0
    params.finish_asset_num = 0
    params.finish_texture_num = 0
    params.finish_camera_num = 0
    params.finish_network_num = 0
    params.all_num = 0
    params.scene_progress = 0
    params.complete_callback = nil
    params.progress_callback = nil
    return ResourceLoader.group_loader_index
end

function ResourceLoader.LoadRawAsset(path, callback, group)
    ResourceLoader.LoadAsset(path, callback, group, false)
end

function ResourceLoader.SetAssetLoadedCallback(path, group, callback, unloadRawFile)
    local loadedCallback = ResourceLoader.loaded_call_back_func[path]
    if loadedCallback == nil then
        ResourceLoader.loaded_call_back_func[path] = {unloadRawFile = unloadRawFile, groups = {}}
        loadedCallback = ResourceLoader.loaded_call_back_func[path]
    end

    local load_group = loadedCallback.groups[group]
    if nil == load_group then
        loadedCallback.groups[group] = {}
        load_group = loadedCallback.groups[group]
    end

    table.insert(load_group, callback)
end

function ResourceLoader.LoadAsset(path, callback, group, unloadRawFile)
    if group == nil then
        group = ResourceLoader.fight_group
    end

    if ResourceLoader.flag_release_raw_asset_obj then
        if nil == unloadRawFile then
            --TODO: 如果没有指定 则需要检查一下是否是音效()
            if string.find(path, "/sound/") then
                 unloadRawFile = false;
            else
                unloadRawFile = true;
            end
        end
    else
        unloadRawFile = false;
    end

    local asset_obj = ResourceManager.GetResourceObject(path);
    if asset_obj then
        ResourceLoader.HandleCallBack(callback, nil, path, asset_obj, nil)
    else
        ResourceLoader.SetAssetLoadedCallback(path, group, callback, unloadRawFile)
        if not ResourceManager.IsLoading(path) then
            --app.log("start load file .."..path.." "..PublicFunc.QueryCurTime())
            ResourceManager.AddLoading(path)
            ResourceLoader.assetObjLoader:load(path)
            ResourceRecord.Add(path)
        end
    end
end

function ResourceLoader.LoadTexture(path, callback, group)

    if group == nil then
        group = ResourceLoader.fight_group
    end

    local asset_obj = ResourceManager.GetResourceObject(path)
    if asset_obj then
        ResourceLoader.HandleCallBack(callback, nil, path, asset_obj, nil)
    else
        ResourceLoader.SetAssetLoadedCallback(path, group, callback, true)
        if not ResourceManager.IsLoading(path) then
            ResourceManager.AddLoading(path)
            texture.load(path, "ResourceLoader_OnTextureLoaded");
            ResourceRecord.Add(path)
        end
    end
end

function ResourceLoader.LoadAncontroller(path, callback, group)
--     AssociatedFilesMgr.Load(3, path, callback, group, unloadRawFile);
-- end

-- function ResourceLoader._LoadAncontroller(path, callback, group, unloadRawFile)
    if group == nil then
        group = ResourceLoader.fight_group
    end

    local asset_obj = ResourceManager.GetResourceObject(path)
    if asset_obj then
        ResourceLoader.HandleCallBack(callback, nil, path, asset_obj, nil)
    else
        ResourceLoader.SetAssetLoadedCallback(path, group, callback, true)
        if not ResourceManager.IsLoading(path) then
            ResourceManager.AddLoading(path)
            systems_func.ancontroller_load(path, "ResourceLoader_OnAncontrollerLoaded");
            ResourceRecord.Add(path)
        end
    end
end

function ResourceLoader.GetGroupProgress(index)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    local curFinish = (params.finish_scene_num * 10 + params.finish_asset_num + params.finish_texture_num + params.finish_camera_num + params.finish_network_num)/params.all_num
    if params.finish_scene_num == 0 and params.scene_task then
        local persent = 10 / params.all_num * params.scene_progress
        curFinish = curFinish + persent
    end
    return curFinish
end

function ResourceLoader.AddScene(index, task_list)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    params.scene_task = task_list
end

function ResourceLoader.AddCamera(index)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    params.load_camera = true
end

function ResourceLoader.AddAsset(index, task_list)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    if type(task_list) == "table" then
        for k, v in pairs(task_list) do
            table.insert(params.asset_task, v)
        end
    else
        table.insert(params.asset_task, task_list)
    end
end

function ResourceLoader.AddTexture(index, task_list)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    if type(task_list) == "table" then
        for k, v in pairs(task_list) do
            table.insert(params.texture_task, v)
        end
    else
        table.insert(params.texture_task, task_list)
    end
end

function ResourceLoader.AddNetwork(index, task_list)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    if type(task_list) == "table" and type(task_list[1]) == "table" then
        for k, v in pairs(task_list) do
            table.insert(params.network_task, v)
        end
    else
        table.insert(params.network_task, task_list)
    end
end

function ResourceLoader.GO(index, cbComplete, cbProgress)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    params.complete_callback = cbComplete
    params.progress_callback = cbProgress
    if params.scene_task then
        params.all_num = params.all_num + 10
    end
    params.all_num = params.all_num + #params.asset_task
    params.all_num = params.all_num + #params.texture_task
    params.all_num = params.all_num + #params.network_task
    if params.load_camera then
        params.all_num = params.all_num + 1
    end
    app.log("before co")
    Root.Coroutine("preLoader_coroutine"..ResourceLoader.coroutine_index, ResourceLoader.__GO, index)
    ResourceLoader.coroutine_index = ResourceLoader.coroutine_index + 1
end


function ResourceLoader.__GO(index)
    app.log("set fps 60")
    -- app.set_frame_rate(30)

    app.log("enter co......")
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    --加载场景
    if params.scene_task then
        app.log("开始加载场景")
        local funcSceneLoading = Utility.create_callback_ex(ResourceLoader.OnSceneLoading, false, 1, index)
        local funcSceneLoaded = Utility.create_callback_ex(ResourceLoader.OnSceneLoaded, false, nil, index)
        SceneMessage.set_listener(
            funcSceneLoading,
            funcSceneLoaded,
            nil, nil
        )
        SceneMessage.load(params.scene_task[1], params.scene_task[2])
        while params.finish_scene_num == 0 do
            coroutine.yield()
        end
        Utility.del_callback(funcSceneLoading)
        Utility.del_callback(funcSceneLoaded)
    end

    app.log(string.format("场景加载完成: time:%f, used time:%f", app.get_time(), app.get_time() - g_scene_loadtime))
    g_scene_loadtime = app.get_time()


    --加载各种assetbundle
    if #params.asset_task > 0 then
        app.log("开始加载assetbundle")
        for i=1, #params.asset_task do
            --app.log("assetloader preload asset : " .. params.asset_task[i])
            local funcAssetLoaded = Utility.create_callback_ex(ResourceLoader.OnGroupAssetLoaded, true, 4, index)
            ResourceLoader.LoadAsset(params.asset_task[i], funcAssetLoaded, ResourceLoader.group_loader);
        end

        while params.finish_asset_num ~= #params.asset_task do
            --app.log(" wait complete.."..params.finish_asset_num)
            coroutine.yield()
        end
    end

    app.log(string.format("Asset 预加载完成: time:%f, used time:%f", app.get_time(), app.get_time() - g_scene_loadtime))
    g_scene_loadtime = app.get_time()

    --加载texture
    if #params.texture_task > 0 then
        app.log("开始加载纹理")
        for i=1, #params.texture_task do
            app.log("load texture :".. tostring(params.texture_task[i]))
            local funcTextureLoaded = Utility.create_callback_ex(ResourceLoader.OnGroupTextureLoaded, true, 4, index)
            ResourceLoader.LoadTexture(params.texture_task[i], funcTextureLoaded, ResourceLoader.preload_group)
        end
        while params.finish_texture_num ~= #params.texture_task do
            coroutine.yield()
        end
    end




    --TODO: kevin 处理卡牌初始化
    if ResourceLoader.first_load_scene_res then
        
        g_delay_process_card_msg = false;
        for k, v in pairs(g_first_hero_card_msg) do
            msg_cards.gc_role_cards_list(v.info, v.finish)
        end

        coroutine.yield()

        for k, v in pairs(g_first_equip_card_msg) do
            msg_cards.gc_equip_cards_list(v.info, v.finish);
        end
        
        coroutine.yield() 

        for k, v in pairs(g_first_item_card_msg) do
            msg_cards.gc_item_cards_list(v.info, v.finish)
        end

        ResourceLoader.first_load_scene_res = false;

        coroutine.yield()
        --预加载一些配置
        ConfigHelper.PreLoadConfigFile(ConfigHelper.preLoadFlag.onEnterGame)

        coroutine.yield()
    end

    -- app.log(string.format("texture 预加载完成: time:%f, used time:%f", app.get_time(), app.get_time() - g_scene_loadtime))
    g_scene_loadtime = app.get_time()

    if params.load_camera then
        local funcCameraLoaded = Utility.create_callback_ex(ResourceLoader.OnCameraLoaded, true, nil, index)
        CameraManager.setInitFinshCallback(funcCameraLoaded)
        CameraManager.init()
        while params.finish_camera_num == 0 do
            coroutine.yield()
        end
    end

    if #params.network_task > 0 then
        for i=1, #params.network_task do
            params.network_task[i]:Load()
        end
        while params.finish_network_num ~= #params.network_task do
            params.finish_network_num = 0
            for i=1, #params.network_task do
                finish = params.network_task[i]:LoadIsCompleted()
                if not finish then
                    coroutine.yield()
                    break
                end
                params.finish_network_num = params.finish_network_num + 1
            end
            --break
        end
    end

    ResourceLoader.group_loader_params[index] = nil
    
    if params.complete_callback then
        g_scene_loadtime = app.get_time()
        -- app.log(string.format("ALL 加载完成: time:%f, used time:%f", app.get_time(), app.get_time() - g_load_start_time))
        return {callback=params.complete_callback};
    end
end

function ResourceLoader.OnSceneLoading(progress, index)
    --app.log(""..progress)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    
    params.scene_progress = progress
    if params.progress_callback then
        params.progress_callback()
    end
end

function ResourceLoader.OnSceneLoaded(index)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    params.finish_scene_num = params.finish_scene_num + 1
    if params.progress_callback then
        params.progress_callback()
    end
    app.log("场景加载完成")
end


function ResourceLoader_OnAssetLoaded(pid, fpath, asset_obj, error_info)
    -- app.log("ResourceLoader_OnAssetLoaded "..tostring(fpath));
    if asset_obj == nil then
        app.log(string.format("ResourceLoader_OnAssetLoaded asset_obj is nil file:%s", tostring(fpath)))
        return
    end

    if ResourceLoader.process_asset_loading then
        app.log(string.format("reenter function: , file: %s", tostring(fpath)));
        ResourceLoader.asset_loaded_list[fpath] = {}
        ResourceLoader.asset_loaded_list[fpath].pid = pid
        ResourceLoader.asset_loaded_list[fpath].asset_obj = asset_obj
        ResourceLoader.asset_loaded_list[fpath].error_info = error_info
        ResourceLoader.asset_loaded_list[fpath].fpath = fpath
        return
    end
    --app.log("加载完成.."..fpath.." "..PublicFunc.QueryCurTime())
    ResourceLoader.process_asset_loading = true;
     
    ResourceManager.SetLoadingComplete(fpath)

    local loadFileCallback = ResourceLoader.loaded_call_back_func[fpath]
    local unloadRawFile = false;
    if nil ~= loadFileCallback then
        unloadRawFile = loadFileCallback.unloadRawFile
    else
        local fm = FightScene.GetFightManager()
        local tip_msg = string.format("file:%s can't find callback", tostring(fpath))
        if nil ~= fm and fm:IsFightOver() then
            app.log_warning(tip_msg);
        else
            app.log("<color=#ff0000ff>"..tip_msg.."</color>");
        end
    end

    local res_obj = ResourceManager.GetResourceObject(fpath)
    if nil == res_obj then
        local o = nil
        if not unloadRawFile then
            o = asset_obj
        else
            if not ResourceLoader.flag_release_raw_asset_obj then
                app.log("should not see me.");
            end

            o = asset_game_object.create_unsave(asset_obj)

            -- (before u3d 5.3.5f1) 既然是unsave 那就立刻清除该asset_obj相关资源(而不是等待垃圾回收)，
            -- 避免累计大量的webstream文件占用内存
            asset_obj:clear()
            o:set_name("res_obj_"..o:get_name())
        end

        res_obj = ResourceObject:new()
        res_obj:SetObject(o, not unloadRawFile);
        ResourceManager.AddResourceObject(fpath, res_obj);

        -- --TODO: 暂时保留所有的特效资源
        -- if string.find(fpath, '/fx/', 1, true) then
        --     ResourceManager.AddPermanentReservedRes(fpath)
        -- end
    end
   

    ResourceLoader.last_loaded_path = fpath;
    -- local file_list = ResourceLoader.loaded_call_back_func[fpath]
    if loadFileCallback and loadFileCallback.groups then
        for k, v in pairs(loadFileCallback.groups) do
            for _k, _v in pairs(v) do
                ResourceLoader.HandleCallBack(_v, pid, fpath, res_obj, error_info)
            end
        end
        ResourceLoader.loaded_call_back_func[fpath] = nil
    end
    ResourceLoader.process_asset_loading = false
    local _pid, _fpath, _asset_obj, _error_info
    for k, v in pairs(ResourceLoader.asset_loaded_list) do
        _pid = v.pid
        _fpath = v.fpath
        _asset_obj = v.asset_obj
        _error_info = v.error_info
        ResourceLoader.asset_loaded_list[k] = nil
        break
    end
    if _fpath then
        ResourceLoader_OnAssetLoaded(_pid, _fpath, _asset_obj, _error_info)
    end
end


function ResourceLoader.HandleCallBack(any_call_func, pid, fpath, asset_obj, error_info)
    local callback_type = type(any_call_func)
    if callback_type == "string" then
        local callback_func = _G[any_call_func]
        if callback_func and type(callback_func) == "function" then
            callback_func(pid, fpath, asset_obj, error_info)
        else
            app.log_warning("ResourceLoader.OnAssetLoaded error callback."..tostring(v))
        end
    elseif callback_type == "table" then
        any_call_func.func(any_call_func.user_data, pid, fpath, asset_obj, error_info)
    elseif callback_type == "function" then
        any_call_func(pid, fpath, asset_obj, error_info)
    end
end

function ResourceLoader.OnGroupAssetLoaded(pid, fpath, asset_obj, error_info, index)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    params.finish_asset_num = params.finish_asset_num + 1
    if params.progress_callback then
        params.progress_callback()
    end
    -- app.log("Asset加载进度"..params.finish_asset_num.."/"..#params.asset_task)
end

function ResourceLoader_OnTextureLoaded(pid, fpath, asset_obj, error_info)
    if asset_obj == nil then
        app.log(string.format("ResourceLoader_OnTextureLoaded asset_obj is nil file:%s", tostring(fpath)))
        return
    end

    ResourceManager.SetLoadingComplete(fpath)
    local res_obj= ResourceManager.GetResourceObject(fpath)
    if res_obj == nil then
        res_obj = ResourceObject:new();
        res_obj:SetObject(asset_obj, true) 
        ResourceManager.AddResourceObject(fpath, res_obj)        
    end

    local fileLoadCallback = ResourceLoader.loaded_call_back_func[fpath]
    if fileLoadCallback and fileLoadCallback.groups then
        for k, v in pairs(fileLoadCallback.groups) do
            for _k, _v in pairs(v) do
                ResourceLoader.HandleCallBack(_v, pid, fpath, res_obj, error_info)
            end
        end
        ResourceLoader.loaded_call_back_func[fpath] = nil
    end
end

function ResourceLoader_OnAncontrollerLoaded(pid, fpath, asset_obj, error_info)
    if asset_obj == nil then
        app.log(string.format("ResourceLoader_OnAncontrollerLoaded asset_obj is nil file:%s", tostring(fpath)))
        return
    end

    ResourceManager.SetLoadingComplete(fpath)
    local res_obj= ResourceManager.GetResourceObject(fpath)
    if res_obj == nil then
        res_obj = ResourceObject:new();
        res_obj:SetObject(asset_obj, true) 
        ResourceManager.AddResourceObject(fpath, res_obj)        
    end

    local fileLoadCallback = ResourceLoader.loaded_call_back_func[fpath]
    if fileLoadCallback and fileLoadCallback.groups then
        for k, v in pairs(fileLoadCallback.groups) do
            for _k, _v in pairs(v) do
                ResourceLoader.HandleCallBack(_v, pid, fpath, res_obj, error_info)
            end
        end
        ResourceLoader.loaded_call_back_func[fpath] = nil
    end
end

function ResourceLoader.OnGroupTextureLoaded(pid, fpath, asset_obj, error_info, index)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    params.finish_texture_num = params.finish_texture_num + 1
    if params.progress_callback then
        params.progress_callback()
    end
    --app.log("Texture加载进度"..params.finish_texture_num.."/"..#params.texture_task)
end


function ResourceLoader.OnCameraLoaded(index)
    local params = ResourceLoader.group_loader_params[index]
    if params == nil then
        app.log("ResourceLoader找不到群组加载器信息 index="..index)
        return
    end
    params.finish_camera_num = params.finish_camera_num + 1
    if params.progress_callback then
        params.progress_callback()
    end
    --app.log("摄像机加载完成")
end

function ResourceLoader.ClearGroupCallBack(group)

    if group == nil then
        group = ResourceLoader.fight_group
    end
    for fileName, loadedCallback in pairs(ResourceLoader.loaded_call_back_func) do
        local clear = true;
        for group_name, callback in pairs(loadedCallback.groups) do
            if group_name == group then
                loadedCallback[group_name] = nil
                -- AssociatedFilesMgr._MainFileCallback[fileName] = nil;
            else
                clear = false;
            end
        end
        
        if clear then
            ResourceLoader.loaded_call_back_func[fileName] = nil
        end
    end
end


function ResourceLoader.ClearAllGroupCallback()
    -- AssociatedFilesMgr._MainFileCallback = {}
    ResourceLoader.loaded_call_back_func = {}
end


ResourceLoader.InitLoader();
--[[endregion]]