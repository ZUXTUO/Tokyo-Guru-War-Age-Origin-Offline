--[[
file	scene_manager.lua
author	dengchao
time	2015.3.19

]]--

SceneManager = {}

local sceneList = {}
local currentSceneAndData = nil

function start_rcd_scene_load_time()
    g_load_start_time = app.get_time();
    g_scene_loadtime = g_load_start_time
    g_timer_3 = g_load_start_time;
    g_timer_4 = g_load_start_time
end


function SceneManager.PushScene(scene, param,perms)
     -- TODO: kevin test.
    app.log("push scene "..tostring(scene).. "time: ".. app.get_time())
    if FightScene.is_loading_secene then
        app.log("正在加载场景的时候PushScene hurdleid="..tostring(FightScene.GetCurHurdleID()).." playmethod="..tostring(FightScene.GetPlayMethodType()).." worldgid="..tostring(FightScene.GetWorldGID()).." "..debug.traceback())
    end
    start_rcd_scene_load_time()

    -- 巅峰展示loading资源没有loadingui
	app.log("巅峰展示loading资源没有loadingui")
    if scene.IsHideLoadingBar() then
        SceneManager.PushSceneCallback({scene=scene, param = param})
    elseif param and param.GetPlayMethod and param:GetPlayMethod() == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
        SceneManager.PushSceneCallback({scene=scene, param = param})
    else
		app.opt_enable_net_dispatch(false);
        UiSceneChange.Enter(scene, param)
        UiSceneChange.SetEnterCallback(SceneManager.PushSceneCallback, {scene=scene, param = param})
        UiSceneChange.SetExitCallback(function()
            UiSceneChange.Destroy();
            end )
    end
    --AudioManager.Stop(nil,true)
end

function SceneManager.PushSceneCallback(data)
    ----------------------------------------------------------------------------------------------
    app.log("ResourceManager Destroy()");
    -----------暂停自动寻路------------------------------
    if g_dataCenter.autoPathFinding == nil then
        g_dataCenter.autoPathFinding = AutoPathFinding:new();
    end
    if g_dataCenter.autoPathFinding.isFinding then
        if g_dataCenter.autoPathFinding.isNear then
            g_dataCenter.autoPathFinding:StopPathFind();
        else
            g_dataCenter.autoPathFinding:PausePathFind(true);
        end
    end
    -----------------------------------------------------
    if data.scene == CityScene then
    end
    if data.scene == mainCityScene then
    end
    ResourceManager.GC(false, true);

    -- -- --TODO: kevin
    if data.scene == FightScene then
        ResourceManager.SetAutoGC(false);
    end

    ---------------------------------------------------------------------------------------------
    local sceneAndData = {}
    sceneAndData.scene = data.scene
    sceneAndData.sceneData = {}
    table.insert(sceneList,sceneAndData)
    if currentSceneAndData then
        -- if currentSceneAndData.scene.isInherit then
            -- currentSceneAndData.scene:Pause()
        -- else
        currentSceneAndData.scene.Pause(currentSceneAndData.sceneData)
        -- end
    end

    ResourceManager.DestroyRes()


    currentSceneAndData = sceneAndData
    -- if currentSceneAndData.scene.isInherit then
        -- currentSceneAndData.scene:Start(data.param)
    -- else
        currentSceneAndData.scene.Start(data.param, currentSceneAndData.sceneData)
    -- end
    --释放unused资源
    util.unload_unused_assets()
	app.opt_enable_net_dispatch(true);
end

function SceneManager.PopScene(scene)
    --TODO: kevin test。
    app.log("pop scene "..tostring(scene).. "time: ".. app.get_time())
    start_rcd_scene_load_time();
    if FightScene.is_loading_secene then
        app.log("正在加载场景的时候PopScene hurdleid="..tostring(FightScene.GetCurHurdleID()).."playmethod="..tostring(FightScene.GetPlayMethodType()).." worldgid="..tostring(FightScene.GetWorldGID()).." "..debug.traceback())
    end
    UiSceneChange.Enter()
    UiSceneChange.SetEnterCallback(SceneManager.PopSceneCallback, scene)
    UiSceneChange.SetExitCallback(function()
        UiSceneChange.Destroy();
        -- 将游戏开始的触发器延后在这里触发
        -- 防止界面还未加载完毕，就被触发器里的行为隐藏界面，导致界面查找不到节点等一系列问题
        ObjectManager.ForEachObj(function (objname,obj)
            obj:OnFightStart();
        end)
    end )
    AudioManager.Stop(nil,true)

    --SceneManager.PopSceneCallback(scene);
end

function SceneManager.PopSceneCallback(scene)
    ResourceManager.GC(false, true);
    
    scene = scene or currentSceneAndData.scene
    if currentSceneAndData and currentSceneAndData.scene == scene then
        table.remove(sceneList,#sceneList)
        -- if currentSceneAndData.scene.isInherit then
        --     currentSceneAndData.scene:Destroy()
        -- else
            currentSceneAndData.scene.Destroy(currentSceneAndData.sceneData)
        -- end

        ResourceManager.DestroyRes()

        currentSceneAndData = nil
        if #sceneList > 0 then
            currentSceneAndData = sceneList[#sceneList]
            -- if currentSceneAndData.scene.isInherit then
            --     currentSceneAndData.scene:Resume()
            -- else
                if currentSceneAndData.sceneData.loadData.play_method_id == MsgEnum.eactivity_time.eActivityTime_openWorld then
                    if g_dataCenter.send_first_enter_game_complete then
                        world_msg.cg_enter_other_fight_scene(true)
                    end
                end
                currentSceneAndData.scene.Resume(currentSceneAndData.sceneData)
            -- end
        else
            -- 游戏初始化
            if not GameBegin.get_ready() then
                GameBegin.init()
                UiSceneChange.Exit()
            else
                SceneManager.ReplaceByMainCityScene()
            end
        end
    end
end

function SceneManager.PushMainCityScene()
	app.log("地图载入")
    local fs = FightStartUpInf:new()
    fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_MainCity)
    fs:SetLevelIndex(61000000)

    --此时玩家数据还未回来
    --local defTeam = g_dataCenter.player:GetDefTeam()
    --fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, {defTeam[1]})
    SceneManager.PushScene(FightScene,fs)
end

function SceneManager.ReplaceByMainCityScene()
    app.log(debug.traceback())
    --local fs = FightStartUpInf:new()
    --fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_MainCity)
    --fs:SetLevelIndex(61000000)
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    --local defTeam = g_dataCenter.player:GetDefTeam()
    --fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, {defTeam[1]})
    SceneManager.ReplaceScene(FightScene,fs)
	SceneManager.PushMainCityScene()
end

function SceneManager.PushPeakShowScene()
    local cfg = ConfigManager.Get(EConfigIndex.t_peak_data, 1)
    local fs = FightStartUpInf:new()
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    fs:SetLevelIndex(cfg.hurdle_id);
    SceneManager.PushScene(FightScene, fs);
end

function SceneManager.BeginPlayFirstStory()
    local fs = FightStartUpInf:new()
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    fs:SetLevelIndex(60020000);
    SceneManager.ReplaceScene(FightScene, fs);

    -- 黑幕转场
    local data = 
    {
        text="故事从这里开始…",
        textfade = true,
        duration=6,
        callback=BlackFadeEffectUi.Destroy,
    }
    BlackFadeEffectUi.KeepBlack(data);
end

function SceneManager.BeginPlaySecondStory()
    local fs = FightStartUpInf:new()
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    fs:SetLevelIndex(60020001);
    SceneManager.ReplaceScene(FightScene, fs);

    -- 黑幕转场
    local data = 
    {
        text="水晶大厦喰种袭人事件后…",
        textfade = true,
        duration=6,
        callback=BlackFadeEffectUi.Destroy,
    }
    BlackFadeEffectUi.KeepBlack(data);
end

function SceneManager.Update(dt)
    --app.log('SceneManager.Update')
    if currentSceneAndData then 
        if currentSceneAndData.scene.isInherit then
            currentSceneAndData.scene:Update(dt)
        else
		    --currentScene.Update() --fight scene中会自己 add update
        end
	end
end

function SceneManager.ReplaceScene(scene,param)

    if #sceneList == 0 then
        return SceneManager.PushScene(scene, param)
    end

	if currentSceneAndData and scene then
		UiSceneChange.Enter()
        UiSceneChange.SetEnterCallback(SceneManager.ReplaceSceneCallback, {scene=scene, param = param})
        UiSceneChange.SetExitCallback(function()
        UiSceneChange.Destroy();
        -- 将游戏开始的触发器延后在这里触发
        -- 防止界面还未加载完毕，就被触发器里的行为隐藏界面，导致界面查找不到节点等一系列问题
        ObjectManager.ForEachObj(function (objname,obj)
            obj:OnFightStart();
        end)
    end )
	end
    AudioManager.Stop(nil,true)
end

function SceneManager.ReplaceSceneCallback(data)
    if g_dataCenter.autoPathFinding.isFinding then
        if g_dataCenter.autoPathFinding.isNear then
            g_dataCenter.autoPathFinding:StopPathFind();
        else
            g_dataCenter.autoPathFinding:PausePathFind(true);
        end
    end
    table.remove(sceneList,#sceneList)

    currentSceneAndData.scene.isPause = false 
    currentSceneAndData.scene.Destroy(currentSceneAndData.sceneData);

    local sceneAndData = {}
    sceneAndData.scene = data.scene
    sceneAndData.sceneData = {}
    table.insert(sceneList,sceneAndData)
    currentSceneAndData = sceneAndData
    currentSceneAndData.scene.isPause = false 
    currentSceneAndData.scene.Start(data.param, sceneAndData.sceneData)
end



function SceneManager.GetCurrentScene()
    local scene = nil
    if currentSceneAndData then
        scene = currentSceneAndData.scene
    end
    return scene
end

function SceneManager.GetCurrentUpSceneData()
    local sceneCount = #sceneList
    if sceneCount > 1 then
        currentSceneAndData = sceneList[sceneCount - 1]
        return currentSceneAndData.sceneData
    end
    return nil
end

function SceneManager.GetUIMgr()

    if currentSceneAndData and currentSceneAndData.scene then 
        if currentSceneAndData.scene.isInherit then
            return currentSceneAndData.scene:GetUIMgr()
        else
            if FightScene.GetFightManager() and FightScene.GetFightManager().GetUIMgr ~= nil then
                return FightScene.GetFightManager():GetUIMgr()
            else
                return uiManager
            end
        end
	end
end

function SceneManager.Destroy()
    for i, v in pairs(sceneList) do
        if v.scene.isInherit then
            v.scene:Destroy()
        else
            v.scene.Destroy(v.sceneData)
        end
    end
    sceneList = {}
    currentSceneAndData = nil
end

Root.AddUpdate(SceneManager.Update)

return SceneManager