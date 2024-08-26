--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/11
-- Time: 15:13
-- To change this template use File | Settings | File Templates.
--


GameBegin = {
	is_first = true;
	is_ready = false;
};

function GameBegin.get_ready()
	return GameBegin.is_ready
end

function GameBegin.load_first_res()
	--[[只运行一次]]
	if GameBegin.is_first then
		GameBegin.is_first = false;
		--[[TIMER UPDATE]]
		Root.AddFixedUpdate(UpdateTimer);
		--[[自定义消息分发]]
		Root.AddUpdate(PublicFunc.UnregistAllMsg);
        --[[定时管理器]]
		Root.AddUpdate(TimerManager.Update);        
		--[[特效管理器]]
		EffectManager.StartUp();
		--[[加载必要数据]]
		GameBegin.initData();
		--[[开始点击特效]]
		FxClicked.Start();
		-- [[创建通用人物120头像图集]]
		SmallCardUi.SetAtlas120(Root.ui_picture_human_120_atlas);
		--初始化视频播放插件
		-- util.media_player_init()
	end
end

--[[加载脚本完成后回调]]
function GameBegin.init()
	app.log("GameBegin.init "..debug.traceback());

	--[[公司日志：游戏启动信息]]
	--SystemLog.AppStartClose(22);


	--设置声音采样率
	util.audio_set_sample_rate(44100);


	GameBegin.is_ready = true

--	--[[平台日志]]
--	if AppConfig.get_game_log_is_open() then
--		script.run("logic/systems/log/main.lua");
--		SystemLog.AppStartClose();
--		SystemLog.SceneSwitch();
--	end

	GameBegin.load_first_res()

	--[[登录背景音乐]]
	--AudioManager.Stop(nil, true);
	----AudioManager.Destroy();
	--AudioManager.Play2dAudioList({[1]={id=81000006,loop=-1}});


	--[[添加网络缓存忽略消息]]
	app.log("添加网络缓存忽略消息");
	app.add_net_cache_ignore_msg("gc_pong");
	app.add_net_cache_ignore_msg("gc_sync_cur_time");

	local isEnterShow = EnterShow.CheckEnter()

	-- 预先缓存1张随机loading背景图
	app.log("预先缓存1张随机loading背景图");
	if UiLevelLoadingNew then
		UiLevelLoadingNew.InitTempTexture(isEnterShow)
    end

	--[[判断巅峰展示]]
	--if isEnterShow then
		EnterShow.Start(GameBegin.login_bg_destroy, GameInfoForThis.SceneTest);
	--else
		--[[socket初始化]]
		--Socket.Init();
	--end
	
end

--[[清理掉加载界面 用于巅峰展示回调]]
function GameBegin.login_bg_destroy()
	app.log("GameBegin.login_bg_destroy");
	UiAnn.on_btn_close();--[[关掉网页弹窗]]
	login_bg.Destroy();--[[清理掉开始背景]]
	Resourceload.Destroy();--[[清理掉资源加载背景]]
end

----[[登录UI显示完成后处理]]
--function GameBegin.time_login()
--	app.log("GameBegin.time_login");
--
--	--[[得到服务器例表]]
--	script.run("logic/systems/server_list_data/main.lua");
--	ServerListData.apply_data_list(GameBegin.server_list_callback);
--
--	--[[公告]]
--	script.run("logic/systems/load/notice_bg.lua");
--    notice_bg.Start();
--end

----[[服务器例表得到后的回调]]
--function GameBegin.server_list_callback(list)
--	app.log("得到服务器例表成功 通知UI层"..table.tostring(list));
--
--	systems_data.set_game_server_list_dtree(list);--[[存服务器例表]]
--
--	--[[socket初始化]]
--	Socket.Init();
--
--end

--[[平台帐号处理成功回调]]
function GameBegin.usercenter_login_callback()
	app.log("平台帐号处理成功回调");
end

--[[GAME SOCKET处理成功回调]]
function GameBegin.game_socket_callback()
	app.log("GAME SOCKET处理成功回调");
	--获取特效设置
    --if not g_dataCenter.setting:GetRecvServerSetting() then
    --    msg_client_log.cg_get_auto_set_effect(util.get_devicemodel());
    --end
end

--[[平台帐号注销]]
function GameBegin.usercenter_logout_callback()
	--[[关掉网页弹窗]]
	if UiAnn then
		if UiAnn.on_btn_close then
			UiAnn.on_btn_close();
		end
	end
	--[[系统级信息不清理，只清理个人信息，然后再次打开登录提示]]
	app.log("平台帐号注销");
	app.opt_enable_net_dispatch(true);
	if UiLevelLoadingNew then
		UiLevelLoadingNew.Destroy(true)
	end
	GameBegin.reload();

	--[[如果为空 就说明还没有加载过LUA  只在前面]]
	if login_scene then
        login_scene.Start();
    else
        --[[直接重来就行]]
		Root.game_start();
    end
end

--[[帐号重新登录时，数据清理操作]]
function GameBegin.reload()
	--[[重置数据]]
	if g_dataCenter then
		g_dataCenter.clear_all();
		g_dataCenter.init();
	end
	--[[关闭GAME连接]]
	if Socket ~= nil then
		Socket.GameServer_close();
		Socket.Uinit();


	end

	--[[清楚接收协议数据]]
	if netmgr ~= nil then
		netmgr.clear()
	end

	--[[清除音乐]]
	if AudioManager ~= nil then
		AudioManager.Stop(nil, true);
		--AudioManager.Destroy();
	end
	--[[UI界面]]
	if uiManager ~= nil then
		uiManager:DestroyAll(true);
		uiManager:InitData();
	end

	--[[主城NPC]]
	if mainCityScene ~= nil then
		mainCityScene:Destroy();
	end
	--[[战斗退出]]
	if FightScene ~= nil then
		if FightScene.GetFightManager() ~= nil then
			FightScene.GetFightManager():FightOver(false, true);
		end
	end
	if SceneManager then
		SceneManager.Destroy()
	end

	if CommonUiObjectManager ~= nil then
		CommonUiObjectManager.Destroy()
		CommonUiObjectManager.InitData()
	end
	--[[重置新手引导数据]]
	if GuideManager ~= nil then
		GuideManager.Destroy()
		GuideManager.InitData()
	end
	--ResourceManager.Destory()
	--ResourceLoader.Destroy()
	if UiSceneChange then
		UiSceneChange.Destroy();
	end
	--没有走uimanager的独立界面
	if ScreenPlayChat then
		ScreenPlayChat.DestroyTalk();
	end
	if CommonBattle then
		CommonBattle.Destroy();
	end
	if CommonBattle3v3 then
		CommonBattle3v3.Destroy();
	end
	if CommonStar then
		CommonStar.Destroy();
	end
	if CommonAddExp then
		CommonAddExp.Destroy();
	end
	if CommonPlayerLevelup then
		CommonPlayerLevelup.Destroy();
	end
	if CommonAward then
		CommonAward.Destroy();
	end
	if CommonLeave then
		CommonLeave.Destroy();
	end
	if CommonDead then
		CommonDead.Destroy();
	end
	if GaoSuJuJiFightUI then
		GaoSuJuJiFightUI.Destroy();
	end
	-- CommonSuccess.Destroy();
	-- CommonEquipAward.Destroy();
	if CommonEquipLose then
		CommonEquipLose.Destroy();
	end
	if CommonFailAward then
		CommonFailAward.Destroy();
	end
	if Fuzion2RankUI then
		Fuzion2RankUI.Destroy();
	end
	if EggHunXiaAwardUI then
		EggHunXiaAwardUI.Destroy();
	end
	if FightStartUI then
		FightStartUI.EndCallback();
	end
	if PlayGuideUI then
		PlayGuideUI.Destroy();
	end
	if GuidePlayGuideUI then
		GuidePlayGuideUI.Destroy()
	end
	if UiBaoWeiCanChangAward then
		UiBaoWeiCanChangAward.DestroyAward();
	end
	--聊天
	if ChatUI then
		ChatUI.Destroy();
	end
	if MysteryShopPopupUI then
		MysteryShopPopupUI.Destroy();
	end
	--规则说明
	if UiRuleDes then
		UiRuleDes.End();
	end
	if EggHeroGetOne then
		EggHeroGetOne.Destroy();
	end
	if Show3dText then
		Show3dText.Destroy()
	end
	if TimerManager then
		TimerManager.ClearAll();
	end
	if CommonRaids then
		CommonRaids.Destroy();
	end
	if ResourceRecord then
		ResourceRecord.Clear()
	end
end

--[[游戏加载完成后必要数据初始化]]
function GameBegin.initData()
	app.log("GameBegin.initData")
	
	--[[音效]]
	AudioManager.Stop(nil, true);
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.Start);
	
	-- 把加载脚本直接调用的初始化操作写到这里
	CommonUiObjectManager.InitData()
	GuideManager.InitData()
	g_ScreenLockUI.Create()
	g_GuideLockUI.Create()
	g_SingleLockUI.Create()

	GLoading.Instance()
	HintUI.Instance()
	CardHuman.InitDefault()
--  每个场景自己new UiManager
	g_uiManager = UiManager:new()
    uiManager = g_uiManager
	ObjectGroupManager.Init()
	
--  local data = {};
--	data.item_id = 20000006;
--  data.number = 1;
--	AcquiringWayUi.Start(data)
end