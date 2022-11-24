script.run("logic/message/scene_message.lua");

SceneLoading = {
	main_ui = nil,
	progress_bar = nil;
	scene_path = "";
	func_loading = "";
	func_loaded = "";
	func_datail_loading = "";
	func_datail_loaded = "";
};

function SceneLoading.Destroy()
	if SceneLoading.main_ui ~= nil then
		SceneLoading.main_ui:set_active(false);
	end
	SceneLoading.main_ui = nil;
	SceneLoading.progress_bar = nil;

	SceneLoading.func_loading = "";
	SceneLoading.func_loaded = "";
	SceneLoading.func_datail_loading = "";
	SceneLoading.func_datail_loaded = "";
end

--[[
-- scene_path = 场景路径
-- func_loading = 加截中回调
-- func_loaded = 加载完成回调
-- func_datail_loading = 单个加载中回调
-- func_datail_loaded = 单个加载完成回调
-- isNotShowLoading = 是否不显示loading界面
-- ]]

function SceneLoading.start(scene_path,scene_name,func_loaded,func_loading,func_datail_loading,func_datail_loaded, isNotShowLoading)

	app.log("SceneLoading==="..tostring(scene_path));
	app.log("SceneLoading scene_name==="..tostring(scene_name));

	--[[scene]]
	SceneLoading.scene_path = scene_path;
	SceneLoading.scene_name = scene_name;

	func_loading = type(func_loading) == "function" and func_loading or "";
	SceneLoading.func_loading = func_loading;

	func_loaded = type(func_loaded) == "function" and func_loaded or "";
	SceneLoading.func_loaded = func_loaded;

	func_datail_loading = type(func_datail_loading) == "function" and func_datail_loading or "";
	SceneLoading.func_datail_loading = func_datail_loading;

	func_datail_loaded = type(func_datail_loaded) == "function" and func_datail_loaded or "";
	SceneLoading.func_datail_loaded = func_datail_loaded;
	
	isNotShowLoading = false;

	--[[UI]]
	app.log("Load菜单UI界面载入");
	if isNotShowLoading then
		SceneMessage.set_listener(
		"SceneLoading.loading",
		"SceneLoading.loaded",
		"SceneLoading.detail_loading",
		"SceneLoading.detail_loaded");

		SceneMessage.load(SceneLoading.scene_path,SceneLoading.scene_name)
	else
    	ResourceLoader.LoadAsset("assetbundles/prefabs/ui/loading/sceneload.assetbundle", SceneLoading.asset_loaded, nil)
    end
end

function SceneLoading.asset_loaded(pid, fpath, asset_obj, error_info)
	SceneLoading.main_ui = asset_game_object.create(asset_obj);
	UiSceneChange.HideInstace()
	Root.SetRootUI(SceneLoading.main_ui);
	SceneLoading.progress_bar = ngui.find_progress_bar(SceneLoading.main_ui,"progress_bar");
	if SceneLoading.progress_bar ~= nil then
		SceneLoading.progress_bar:set_active(false);
	end
	SceneLoading.progress_bar_txt = ngui.find_label(SceneLoading.main_ui,"progress_font_label");
	if SceneLoading.progress_bar_txt ~= nil then
		SceneLoading.set_fonts("");
	end

--	SceneLoading.texture = ngui.find_texture(SceneLoading.main_ui,"Panel/Texture");
--	texture.load("assetbundles/prefabs/ui/image/senceload/dl_canting.assetbundle","SceneLoading.textload");
----	SceneLoading.texture:set_texture(SceneLoading.ttt);
--	app.log("加载图片");


	SceneMessage.set_listener(
		"SceneLoading.loading",
		"SceneLoading.loaded",
		"SceneLoading.detail_loading",
		"SceneLoading.detail_loaded");

	SceneMessage.load(SceneLoading.scene_path,SceneLoading.scene_name)
end

function SceneLoading.textload(pid, filepath, texture_object, error_message)
	app.log("加载图片  成功");
	SceneLoading.sss = texture_object;
	SceneLoading.texture:set_texture(texture_object);
end


function SceneLoading.set_fonts(str)
	if SceneLoading.progress_bar_txt ~= nil and str ~= nil then
		SceneLoading.progress_bar_txt:set_text(tostring(str));
	end
end

function SceneLoading.set_progress(value)
	if type(value) ~= "number" then return end;
	-- local this_value = string.format("%6.1f", value);
	if SceneLoading.progress_bar ~= nil then
		SceneLoading.progress_bar:set_value(value);
	end
end

function SceneLoading.loading(progress)
	if progress < 0  or progress > 1 then
		if SceneLoading.progress_bar ~= nil then
			SceneLoading.progress_bar:set_active(false);
		end
	else
		if SceneLoading.progress_bar ~= nil then
			SceneLoading.progress_bar:set_active(true);
		end
		SceneLoading.set_progress(progress);
	end
	--[[回调]]
	if SceneLoading.func_loading ~= "" then
		SceneLoading.func_loading(progress);
	end
end

function SceneLoading.loaded()
	if SceneLoading.func_loaded ~= "" then
		SceneLoading.func_loaded()
	end

	SceneLoading.Destroy()
	--UiSceneChange.Exit()
	PublicFunc.lua_gc();
end

function SceneLoading.detail_loading(progress)
	--[[回调]]
	if SceneLoading.func_datail_loading ~= "" then
		SceneLoading.func_datail_loading();
	end
end

function SceneLoading.detail_loaded()
	--[[回调]]
	if SceneLoading.func_datail_loaded ~= "" then
		SceneLoading.func_datail_loaded();
	end
end

local progress_bar = nil
local loadUI = nil
local function set_progress( p)
	if type(p) ~= "number" then return end
	-- local n = string.format("%6.1f", p)
	-- if progress_bar then
	-- 	progress_bar:set_value(p)
	-- end
	UiLevelLoadingNew.SetProgressBar(p)
end






local function _GetLoadingDataByType()
	local data = {type_loading = 0}

	local curScene = SceneManager.GetCurrentScene()
	local _fightStartUpInf = curScene:GetStartUpEnv()
	if _fightStartUpInf == nil then
        return data
    end

	local type_loading = _fightStartUpInf.levelData.isVs;
	-- pvp
	if type_loading == 1 then
		local player = {};
		local cardhuman = {};
		for team_flag, team in pairs(_fightStartUpInf.fightTeamInfo) do
			cardhuman[team_flag] = {};
			for player_id, player_info in pairs(team.players) do
				player[team_flag] = player_info.obj;
				for k, v in pairs(player_info.hero_card_list) do
					if v ~= nil and 0 ~= v then
						local card = player_info.package_source:find_card(ENUM.EPackageType.Hero,v)
						cardhuman[team_flag][k] = card;
					end
				end
			end
		end
		local card1 = {[1] = cardhuman[1][1], [2] = cardhuman[1][2], [3] = cardhuman[1][3]};
		local card2 = {[1] = cardhuman[2][1], [2] = cardhuman[2][2], [3] = cardhuman[2][3]};

		data.type_loading = type_loading
		data[1] = {player=player[1], cardinfo=card1}
		data[2] = {player=player[2], cardinfo=card2}
	-- 3v3
	elseif type_loading == 3 then
		data.type_loading = type_loading
		local showFighter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree].members;
		for i = 1, 2 do
			data[i] = data[i] or {};
			for j = 1, 3 do
				local index = j + (i - 1) * 3;
				if showFighter[index] then
					data[i][j] = data[i][j] or {};
					data[i][j].name = showFighter[index].owner_name;
					data[i][j].cardinfo = CardHuman:new({number=showFighter[index].hero_id, level=showFighter[index].level})
					data[i][j].cardinfo.fight_value = showFighter[index].fight_value	-- 设置战斗力
					data[i][j].cardinfo.need_cal_fight_value = false	-- 战斗力使用服务器的fight_value
				end
			end
		end

	-- 大乱斗
	elseif type_loading == 4 then
		data.type_loading = type_loading
		local showFighter = g_dataCenter.fuzion.showFighter or {};
		for i, v in ipairs(showFighter) do
			data[i] = {}
			data[i].name = v.owner_name
			data[i].cardinfo = CardHuman:new({number=v.hero_id, level=v.level})
			data[i].cardinfo.fight_value = v.fight_value	-- 设置战斗力
			data[i].cardinfo.need_cal_fight_value = false	-- 战斗力使用服务器的fight_value
		end

	-- (10人)大乱斗
	elseif type_loading == 5 then
		data.type_loading = type_loading
		data.showFighter = g_dataCenter.fuzion2.playerList or {};

	-- 序章战斗（用黑幕遮住loading，不显示loading界面）
	elseif type_loading == 6 then
		data.type_loading = type_loading

	-- 普通关卡
	else
		data.type_loading = 0
	end

	return data
end

------------------------------------------------------
function LoadScene(fun, p1, p2, p3, group_loader_index)
	local data = _GetLoadingDataByType()
	local pathRes = UiLevelLoadingNew.GetLoadingRes(data.type_loading)
	-- 先加载进度UI
	ResourceLoader.LoadAsset(pathRes,
	    function( pid, fpath, asset_obj, error_info )
			UiLevelLoadingNew.SetAndShow(data)
			UiLevelLoadingNew.SetProgressBar(0)
			local progress = 0;
	        local completeFunc = function()
	                                fun(p1, p2, p3)
									app.log("场景信息："..tostring(GameInfoForThis.SceneInfo))
                                    if GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_WorldBoss
                                    	or GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_fuzion
                                    	or GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_fuzion2
                                    	or GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_pvptest
                                    	or GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_threeToThree
                                        or GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_openWorld
                                        or GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox
										or GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_GuildBoss
									    or GameInfoForThis.SceneInfo == MsgEnum.eactivity_time.eActivityTime_1v1
                                    	then
    	                                timer.create("SceneLoading.SendLoadState", 1000, 1);
                                    else
									--[[
									app.log("场景信息："..tostring(FightScene.GetPlayMethodType()))
                                    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss
                                    	or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion
                                    	or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2
                                    	or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_pvptest
                                    	or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree
                                        or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld
                                        or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox
										or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss
									    or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_1v1
                                    	then
    	                                timer.create("SceneLoading.SendLoadState", 1000, 1);
                                    else
									--]]
                                    	BlackFadeEffectUi.Destroy()
										UiLevelLoadingNew.Destroy()
										UiSceneChange.Exit()
                                    end
	                                --TODO: memory test.
	                                -- Utility.ClearObj(UiLevelLoading);
	                                -- PublicFunc.lua_gc();
	                             end
	        local progressFunc = function()
	        						UiLevelLoadingNew.SetProgressBar(ResourceLoader.GetGroupProgress(group_loader_index))
	        						local cur_pro = ResourceLoader.GetGroupProgress(group_loader_index);
	        						if (cur_pro - progress) > 0.1 and cur_pro ~= 1 then
	        							progress = cur_pro;
										if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
											g_dataCenter.fuzion2:GetMyPlayerData().percent = progress*100;
											local function delay()
												world_msg.cg_load_state(FightScene.GetWorldGID(), progress*100, FightScene.is_loading_reconnect)
											end
											timer.create(Utility.create_callback(delay),1,1);
										elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_1v1 then
											local function delay()
												world_msg.cg_load_state(FightScene.GetWorldGID(), progress*100, FightScene.is_loading_reconnect)
											end
											timer.create(Utility.create_callback(delay),1,1);
										end
	        						end
	                             end
	        ResourceLoader.GO(group_loader_index, completeFunc, progressFunc)
	    end
	    ,
	    nil
    )
    --app.log("type="..tostring(FightScene.GetPlayMethodType()))
    --[[if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_openWorld  then
        world_msg.cg_enter_other_fight_scene(false)
    elseif g_dataCenter.send_first_enter_game_complete then
        world_msg.cg_enter_other_fight_scene(true)
    end]]
end

--加载巅峰展示资源不显示loading界面
function LoadHideBarScene(fun, p1, p2, p3, group_loader_index)
	local completeFunc = function() fun(p1, p2, p3) end
	local progressFunc = function()
		Resourceload.set_add_progress(ResourceLoader.GetGroupProgress(group_loader_index))
	end
	ResourceLoader.GO(group_loader_index, completeFunc, progressFunc)
end

function SceneLoading.SendLoadState(percent)
    --if percent == nil or percent > 100 then
        percent = 100
    --end
	world_msg.cg_load_state(FightScene.GetWorldGID(), percent, FightScene.is_loading_reconnect)
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld  then
        PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    end
end

-- function LoadMainCityScene(fun, p1, p2, p3, group_loader_index)
-- 	ResourceLoader.LoadAsset("assetbundles/prefabs/ui/loading/ui_loading_normal.assetbundle",
-- 	    function( pid, fpath, asset_obj, error_info )
-- 			UiLevelLoadingNew.SetAndShow({type_loading = 0})
-- 			UiLevelLoadingNew.SetProgressBar(0)
--             uiManager:Restart()
-- 	        local completeFunc = function()
-- 	                                fun(p1, p2, p3)
--                                     UiLevelLoadingNew.Destroy()
--                                     UiSceneChange.Exit()
-- 	                             end
-- 	        local progressFunc = function()
-- 	        						UiLevelLoadingNew.SetProgressBar(ResourceLoader.GetGroupProgress(group_loader_index))
-- 	                             end
-- 	        ResourceLoader.GO(group_loader_index, completeFunc, progressFunc)
-- 	    end
-- 	    ,
-- 	    nil
--     )
-- end
