--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/18
-- Time: 9:59
-- To change this template use File | Settings | File Templates.
--

Resourceload = {
	_asset_loader = nil;
	mainUI = nil;
	progressBar = nil;
	progressBarTxt = nil;
	-- coLoadRes = nil;

	loadFunc = nil,
	loadComplete = false;

	is_reset_func = false;--[[重载标示]]
};
function Resourceload.Destroy()
	Resourceload._asset_loader = nil;
	if Resourceload.mainUI ~= nil then
		Resourceload.mainUI:set_active(false);
	end
	Resourceload.mainUI = nil;
	Resourceload.progressBar = nil;
	Resourceload.progressBarTxt = nil;
	-- Resourceload.coLoadRes = nil;

	Resourceload.textureBG = nil
	Resourceload.textureObj = nil
end

--[[ 文件下载完成后 进行LUA加载进度条 ]]
function Resourceload.Start()
	Resourceload.loadComplete = false;
	Root.push_web_info("sys_011", "热更新结束");
	if loading_bg ~= nil then
		loading_bg.Destroy();
	end
	--[[配置加载器 如果要使用DATA中的数据这个必需另载]]
	script.run("logic/manager/config_manager.lua")
	script.run("logic/manager/config_helper.lua")
	ConfigManager.LoadIndex();--[[初始化配置方法]]

	Resourceload.load_bg_texture()
	Resourceload.loaded_ui()
end

function Resourceload.loaded_ui()
	Resourceload._asset_loader = systems_func.loader_create("Resourceload_loader")
	Resourceload._asset_loader:set_callback("Resourceload.asset_loaded")
	Resourceload._asset_loader:load("assetbundles/prefabs/ui/loading/resourceload.assetbundle");
end

function Resourceload.asset_loaded(pid, fpath, asset_obj, error_info)
	Resourceload.mainUI = systems_func.game_object_create(asset_obj);
	Root.SetRootUI(Resourceload.mainUI);
	Resourceload.progressBar = ngui.find_progress_bar(Resourceload.mainUI, "progress_bar");
	if Resourceload.progressBar ~= nil then
		Resourceload.progressBar:set_active(false);
	end
	Resourceload.progressBarTxt = ngui.find_label(Resourceload.mainUI, "progress_font_label");
	if Resourceload.progressBarTxt ~= nil then
		Resourceload.set_fonts("正在加载...");
	end
	
	Resourceload.textureBG = systems_func.ngui_find_texture(Resourceload.mainUI, "Texture")
	if Resourceload.textureObj then
		Resourceload.textureBG:set_texture(Resourceload.textureObj)
	end

	--[[协程启动]]
	-- Resourceload.coLoadRes = coroutine.create(Resourceload.Load)
	-- timer.create("Resourceload.Update", 1, 1);

	Resourceload.loadFunc = Resourceload.Load()
	Root.AddUpdate(Resourceload.Update);
end

function Resourceload.load_bg_texture()
	systems_func.texture_load(
		"assetbundles/prefabs/ui/image/senceload/loading_tu9.assetbundle", 
		"Resourceload.texture_loaded")
end

function Resourceload.texture_loaded(pid, fpath, asset_obj, error_info)
	Resourceload.textureObj = asset_obj
	if Resourceload.textureBG then
		Resourceload.textureBG:set_texture(Resourceload.textureObj)
	end
end

function Resourceload.set_fonts(str)
	if Resourceload.progressBarTxt ~= nil and str ~= nil then
		Resourceload.progressBarTxt:set_active(true);
		Resourceload.progressBarTxt:set_text(tostring(str).."(不会使用网络数据)");
	end
end

function Resourceload.set_progress(value)
	if type(value) ~= "number" or type(value) == "nil" then return end;
	local this_value = string.format("%6.1f", value);
	if Resourceload.progressBar ~= nil then
		Resourceload.progressBar:set_active(true);
		Resourceload.progressBar:set_value(this_value);
	end
end

--设置第二段进度
function Resourceload.set_add_progress(value)
	local base_value = 0.5
	local total_value = base_value + value * (1 - base_value)
	Resourceload.set_progress(total_value)
end

-- function Resourceload.Load()
-- 	Resourceload.set_fonts("正在加载语言文件");
-- 	script.run("logic/app_config/main.lua");
-- 	script.run("logic/lang/main.lua");--[[语言]]
-- 	script.run("logic/game_settings.lua"); -- 游戏一般设置
-- 	script.run("logic/public/main.lua");
-- 	script.run("logic/systems/load/notice_bg.lua");--[[游戏文字公告]]
-- 	script.run("logic/systems/load/ad_picture_ui.lua");--[[游戏图片AD]]
-- 	script.run("logic/game_begin.lua");
-- 	script.run("logic/load/main.lua");--[[加载器]]

-- 	coroutine.yield(0.1);
-- 	--[[友盟设定事件监控]]
-- 	--	Root.push_web_info("sys_012","资源加载_01");

-- --	Resourceload.set_fonts("正在加载配置索引");

-- 	ConfigHelper.PreLoadConfigFile();
-- 	-- script.run("logic/data/main.lua");

-- 	--[[初始化角色配置表  必调]]
-- 	-- check.init_role_config();

-- 	--[[初始化装备配置表  必调]]
-- 	-- check.init_equip_config();
-- 	--[[初始化道具配置表]]
-- 	check.init_item_config();
-- 	--[[初始化关卡配置表  必调]]
-- 	-- check.init_hurdle_config();
-- 	--[[初始化怪物配置表  必调]]
-- 	-- check.init_monster_property_config();
-- 	--[[初始化属性显示列表]]
-- 	--check.init_property_show_config();
-- 	--[[初始化音频文件路径]]
-- 	check.init_audio_path();
-- 	--[[初始化多地图寻路路径]]
-- 	--check.init_map_path()
-- 	-- 装备推荐

-- 	check.init_equip_recommend()
-- 	coroutine.yield(0.2);

-- 	Resourceload.set_fonts("正在加载公共库");
-- 	script.run("logic/object/main.lua");
-- 	coroutine.yield(0.3);

-- 	Resourceload.set_fonts("正在加载网络");
-- 	script.run("logic/net/main.lua");
-- 	coroutine.yield(0.4);

-- 	script.run("logic/message/main.lua");
-- 	coroutine.yield(0.5);

-- 	script.run("logic/manager/main.lua");
-- 	script.run("logic/systems/user_center/main.lua");--[[ 帐号中心 ]]
-- 	script.run("logic/systems/im/main.lua");--语音聊天
-- 	coroutine.yield(0.6);

-- 	Resourceload.set_fonts("正在加载场景");
-- 	script.run("logic/scene/main.lua");
-- 	coroutine.yield(0.7);

-- 	Resourceload.set_fonts("正在加载UI");
-- 	script.run("logic/ui/main.lua");
-- 	script.run("logic/ui/uisync.lua");
-- 	coroutine.yield(0.8);

-- 	script.run("logic/game_begin.lua");
-- 	coroutine.yield(0.9);

-- 	return 0.9;
-- end

function Resourceload.Load()
	local stepIndex = 0;
	local loadSteps = {
		function()
			Resourceload.set_fonts("正在加载语言文件");
			script.run("logic/app_config/main.lua");
			script.run("logic/lang/main.lua");--[[语言]]
			script.run("logic/game_settings.lua"); -- 游戏一般设置
			script.run("logic/public/main.lua");
			script.run("logic/systems/load/notice_bg.lua");--[[游戏文字公告]]
			script.run("logic/systems/load/ad_picture_ui.lua");--[[游戏图片AD]]
			script.run("logic/game_begin.lua");
			script.run("logic/load/main.lua");--[[加载器]]
			return 0.1
		end,

		function()
			ConfigHelper.PreLoadConfigFile(ConfigHelper.preLoadFlag.onStarup);
			check.init_item_config();
			--[[初始化音频文件路径]]
			-- check.init_audio_path();
			check.init_equip_recommend()
			return 0.15
		end,

		function()
			Resourceload.set_fonts("正在加载公共库");
			script.run("logic/object/main.lua");

			Resourceload.set_fonts("正在加载网络");
			script.run("logic/net/main.lua");
			return 0.2
		end,

		function()
			Resourceload.set_fonts("正在加载核心模块");
			script.run("logic/message/main.lua");
			script.run("logic/manager/main.lua");
			script.run("logic/systems/user_center/main.lua");--[[ 帐号中心 ]]
			script.run("logic/systems/im/main.lua");--语音聊天
			return 0.3
		end,

		function ()
			Resourceload.set_fonts("正在加载场景");
			script.run("logic/scene/main.lua");
			Resourceload.set_fonts("正在加载UI");
			script.run("logic/ui/main.lua");
			return 0.35
		end,

		function()
			script.run("logic/game_begin.lua");
			return 0.4;
		end
	}


	return function()
		stepIndex = stepIndex + 1

		if stepIndex > #loadSteps then
			return nil
		end

		local f = loadSteps[stepIndex]
		if type(f)  ~= "function" then
			app.log("ResourceLoad Step Error: task is not function.")
		end

		return f()
	end
end


function Resourceload.Update()

	local r = Resourceload.loadFunc()

	if nil == r then
		Resourceload.loadComplete = true
		Root.DelUpdate(Resourceload.Update);
		Resourceload.loadFunc = nil

		Resourceload.reset_func();

		--[[公共资源加载]]
		timer.create("Resourceload.ui_obj_init", 50, 1);
	else
		Resourceload.set_progress(r);
	end
end


-- function Resourceload.Update()

-- local r, n = coroutine.resume(Resourceload.coLoadRes)
-- if not r and type(n) == 'string' then
-- 	app.log('coroutine error: ' .. tostring(n))
-- end

-- 	Resourceload.set_progress(n);

-- 	if (r == false) or ('dead' == coroutine.status(Resourceload.coLoadRes)) then
-- --		timer.create("Resourceload.LoadOK", 300, 1);
-- --		[[重截]]
-- 		Resourceload.reset_func();
-- 		--[[公共资源加载]]
-- 		timer.create("Resourceload.ui_obj_init", 300, 1);
-- 	else
-- 		timer.create("Resourceload.Update", 10, 1)
-- 	end
-- end

--[[重截]]
function Resourceload.reset_func()
	--[[只能重截一次]]
	if Resourceload.is_reset_func then return end;
	Resourceload.is_reset_func = true;

	--[[使用ResourceLoader必需要使用这个方法]]
	old_asset_game_object_create = asset_game_object.create;
	if Root.maincamera then 
		AssetGameObject.replace_functions(Root.maincamera);
	end 
	CreateFromResourceObj = function(resObj, info)
		if resObj == nil then return end;
		if resObj:GetIsRawAssetObj() then
			--app.log("DD:----包含GetIsRawAssetObj")
			if nil ~= info then
				app.log(info)
			end
			return old_asset_game_object_create(resObj:GetObject());
		else
			--app.log("DD:----不包含GetIsRawAssetObj")
			if nil ~= info then
				app.log(info)
			end
			local o = resObj:GetObject();
			if o == nil then
				return;
			end
			local new_obj = resObj:GetObject():clone()
			if nil == new_obj then
				app.log("clone failed."..debug.traceback())
			else
				new_obj:set_parent(nil)
				new_obj:set_active(true);
			end
			return new_obj;
		end
	end
	asset_game_object.create = function(resObj)
		return CreateFromResourceObj(resObj)
	end

	-------------------------------------------------[[按钮声音回调拦截 start]]-----------------------------------------------------
	if not old_ngui_button then
		old_ngui_button = ngui.find_button;
	end
	ngui.find_button = MyButton.find_button;
	-------------------------------------------------[[按钮声音回调拦截 end]]------------------------------------------------------
	-------------------------------------------------[[对平台texture接口封装 start]]-----------------------------------------------------
	if not old_ngui_texture then
		old_ngui_texture = ngui.find_texture;
	end
	ngui.find_texture = MyTexture.find_texture;
	-------------------------------------------------[[对平台texture接口封装 end]]------------------------------------------------------
end

local pathRes = {};
-- pathRes.fight_atlas = "assetbundles/prefabs/ui/preloading/new_fight_atlas.assetbundle";
pathRes.picture_human_120_atlas = "assetbundles/prefabs/ui/preloading/atlas_head_picture_120.assetbundle";
pathRes.temp_model_file = "assetbundles/prefabs/character/ch_base/ch_base_fbx.assetbundle";
-- pathRes.big_card_item = "assetbundles/prefabs/ui/public/big_card_item_80.assetbundle";
-- pathRes.new_small_card_item = "assetbundles/prefabs/ui/public/new_small_card_item.assetbundle";
--[[公共资源加载]]
function Resourceload.ui_obj_init()
	--[[清空资源]]
	Root.ui_picture_human_120_atlas = nil;
	Root.temp_model_file = nil;
	-- Root.big_card_item = nil;
	-- Root.new_small_card_item = nil;

	Resourceload.progressBar:set_value(0.45);
	Resourceload.set_fonts("正在加载公共资源");
	-- ResourceLoader.LoadRawAsset(pathRes.fight_atlas, Resourceload.ui_obj_asset_load);
	ResourceLoader.LoadRawAsset(pathRes.picture_human_120_atlas, Resourceload.ui_obj_asset_load);
	ResourceLoader.LoadAsset(pathRes.temp_model_file, Resourceload.ui_obj_asset_load);
	-- ResourceLoader.LoadAsset(pathRes.big_card_item, Resourceload.ui_obj_asset_load);
	-- ResourceLoader.LoadAsset(pathRes.new_small_card_item, Resourceload.ui_obj_asset_load);
end

function Resourceload.ui_obj_asset_load(pid, filepath, asset_obj, error_info)

	if filepath == pathRes.picture_human_120_atlas then
		Root.ui_picture_human_120_atlas = asset_obj;
	-- elseif filepath == pathRes.fight_atlas then
	-- 	Root.ui_fight_atlas = asset_obj;
	elseif filepath == pathRes.temp_model_file then
		Root.temp_model_file = asset_obj;
	-- elseif filepath == pathRes.big_card_item then
	-- 	Root.big_card_item = asset_obj;
	-- elseif filepath == pathRes.new_small_card_item then
	-- 	Root.new_small_card_item = asset_obj;

	end
	Resourceload.ui_init_check();
end
function Resourceload.ui_init_check()
	if 	Root.ui_picture_human_120_atlas ~= nil
		-- and  Root.ui_fight_atlas ~= nil
		and  Root.temp_model_file ~= nil
		-- and  Root.big_card_item ~= nil
		-- and  Root.new_small_card_item ~= nil
	then
		Resourceload.LoadOK();
	end
end

function Resourceload.LoadOK()
	Root.push_web_info("sys_021", "资源加载_10，资源加截ok");

	--[[公司日志：游戏启动信息]]
	--SystemLog.AppStartClose(500000007);

	-- Resourceload.progressBar:set_value(1);
	Resourceload.set_progress(0.5);

	Resourceload.set_fonts("正在进入游戏");

	app.log("Resourceload.LoadOK " .. os.date());

	GameBegin.init()
end

