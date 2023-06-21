--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/10/16
-- Time: 17:59
-- To change this template use File | Settings | File Templates.
--

SystemLog = {
};

--[[必要信息]]
function SystemLog.GetNecessaryInfo()
	local temp_table = {};
	temp_table.adid = app.get_device_info_by_key("adid");
	temp_table.game_id = AppConfig.get_digisky_game_id();
	temp_table.child_id = AppConfig.get_child_ID();
	temp_table.ip = app.get_device_info_by_key("ip");
	if systems_data then
		temp_table.server_id = systems_data.get_enter_server_id();
	else
		temp_table.server_id = "";
	end
	if UserCenter then
		temp_table.account_id = UserCenter.get_accountid();
	else
		temp_table.account_id = 0;
	end
	local player_id = 0;
	if g_dataCenter then
		if g_dataCenter.player then
			player_id = g_dataCenter.player.playerid;
		end
	else
		player_id = 0;
	end
	temp_table.character_id = player_id;
	temp_table.receive_time = os.time() * 1000;
	temp_table.platformchannel_id = AppConfig.get_platformchannel_id();
	temp_table.log_time = os.time() * 1000 - Root.get_start_time();
	return temp_table;
end

--[[游戏启动信息表:只记启动类的信息]]
function SystemLog.AppStartClose(step_id)
	if step_id == nil then return end;
	local table_info = SystemLog.GetNecessaryInfo();
	table_info.type = "AppStartClose";
	table_info.mac = app.get_device_info_by_key("mac");
	table_info.step_id = step_id;
	table_info.idfa = app.get_device_info_by_key("idfa");
	table_info.android_id = app.get_device_info_by_key("android_id");

	local json_info = pjson.encode(table_info);
	app.on_sanalyze_event("AppStartClose",json_info);

--	app.log("@@@-->AppStartClose=="..table.tostring(json_info));
end

--[[场景切换信息：新手引导]]
function SystemLog.SceneSwitch(scene_id,begin_time,end_time)
	if scene_id == nil or begin_time == nil then return end;
	local table_info = SystemLog.GetNecessaryInfo();
	table_info.type = "SceneSwitch";
	table_info.ui = tostring(scene_id);
	table_info.open_time = tonumber(begin_time);
	if end_time then
		table_info.close_time = tonumber(end_time);
	else
		table_info.close_time = os.time() * 1000;
	end
	local json_info = pjson.encode(table_info);
	app.on_sanalyze_event("SceneSwitch",json_info);
--	app.log("@@@-->SceneSwitch=="..table.tostring(json_info));
end