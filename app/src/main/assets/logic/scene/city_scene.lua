----
---- Created by IntelliJ IDEA.
---- User: PoKong_OS
---- Date: 2015/3/12
---- Time: 10:06
---- To change this template use File | Settings | File Templates.
----
--CityScene = {};

--function CityScene.Destroy() 
--	uiManager:DestroyAll(true)

--	ResourceManager.SetAutoGC(false)
--end

--function CityScene.Pause()
--	uiManager:DestroyAll()

--	ResourceManager.SetAutoGC(false)
--end

--function CityScene.Resume()
--	ResourceManager.SetAutoGC(true)

--	SceneLoading.start("assetbundles/prefabs/map/039_zhucheng/70000039_zhucheng.assetbundle","70000039_zhucheng",CityScene.OnResume);
--	--AudioManager.PreloadUiAudio();
--end

--function CityScene.Start()
--	ResourceManager.SetAutoGC(true)

--	SceneLoading.start("assetbundles/prefabs/map/039_zhucheng/70000039_zhucheng.assetbundle","70000039_zhucheng",CityScene.OnLoadScene);
--	--AudioManager.PreloadUiAudio();
--end

----[[场景载入成功后回调]]
--function CityScene.OnLoadScene()
--	--[[重新初始化主城的UI界面]]
--	--uiManager.MainUI = MainUI:new();
--    uiManager:Begin();
--    uiManager:PushUi(EUI.MainUi)
--    AudioManager.Stop();
--	AudioManager.Destroy();
--    AudioManager.Play2dAudioList({[1]={id=81000003,loop=-1}})
----	login_bg.Destroy();
--end
--function CityScene.OnResume()
--	uiManager:Restart()
--	AudioManager.Play2dAudioList({[1]={id=81000003,loop=-1}})
--	--AudioManager.PreloadUiAudio();
--end

---- 新手关卡保存了加载资源，切换到主场景后再清除
--function CityScene.SaveFirstLoadingAsset(pid, fpath, asset_obj, error_info)
--	CityScene.loading_asset_obj = asset_obj
--end
--function CityScene.ClearFirstLoadingAsset()
--	CityScene.loading_asset_obj = nil
--end

--return CityScene;

