--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/9/21
-- Time: 17:40
-- To change this template use File | Settings | File Templates.
--

--script.run("logic/app_config/app_config.lua");

platform_update_down = {
--	check_file_url = "http://192.168.20.244:7022/digisky_file_server/checkfile?optype=android&deviceid=30000";
--	check_file_path = "check_file.data";
--
--	check_op_url = "http://192.168.20.244:7022/";
--	check_op_path = "digisky_file_server/CheckOP?deviceid=30000&opid=0";
--
--	down_url = "http://192.168.20.244:92/ghoul/";

	mainUI = nil,
	all_list_num = 0;
	this_index = 0;
	shareof = {};--[[公共资源名]]
	is_reload = false;--[[下载的资源中是否有公共资源，需要重新加载]]
--	call_back = nil;--[[回调]]
	show_all_num = 1;--[[显示的最大个数]]

	all_file_size = 0;--[[总大小]]
	now_file_size = 0--[[已下载文件大小]]
};

function platform_update_down.Destroy()
	if platform_update_down.mainUI ~= nil then
		platform_update_down.mainUI:set_active(false);
	end
	platform_update_down.mainUI = nil;
	platform_update_down.progressBar = nil;
	platform_update_down.progressBarTxt = nil;
end

function platform_update_down.start(call_back)
	platform_update_down.call_back = call_back;

	--[[公共资源标示]]
	local temp_str = AppConfig.get_asst_path_shareof();
	platform_update_down.shareof = systems_func.string_split(temp_str,"@");

	local ui_path = "assetbundles/prefabs/ui/loading/updateload.assetbundle"
	platform_update_down._asset_loader = systems_func.loader_create("platform_update_down.asset_loaded");
	platform_update_down._asset_loader:set_callback("platform_update_down.asset_loaded");
	platform_update_down._asset_loader:load(ui_path);
	platform_update_down._asset_loader = nil;
end

function platform_update_down.asset_loaded(pid, fpath, asset_obj, error_info)
	platform_update_down.mainUI = systems_func.game_object_create(asset_obj);
	Root.SetRootUI(platform_update_down.mainUI);
	platform_update_down.progressBar = ngui.find_progress_bar(platform_update_down.mainUI,"progress_bar");
	if platform_update_down.progressBar ~= nil then
		platform_update_down.progressBar:set_active(true);
		platform_update_down.set_progress(0);
	end
	platform_update_down.progressBarTxt = ngui.find_label(platform_update_down.mainUI,"progress_font_label");
	if platform_update_down.progressBarTxt ~= nil then
		platform_update_down.set_fonts("正在查询更新文件...");
	end

	--[[开始文件下载]]
	platform_update_down.start_file();
end

function platform_update_down.set_fonts(str)
	if platform_update_down.progressBarTxt ~= nil and str ~= nil then
		platform_update_down.progressBarTxt:set_active(true);
		platform_update_down.progressBarTxt:set_text(tostring(str));
	end
end

function platform_update_down.set_progress(value)
	if type(value) ~= "number" or type(value) == "nil" then return end;
	local this_value = string.format("%6.2f", value);
	if platform_update_down.progressBar ~= nil then
		platform_update_down.progressBar:set_active(true);
		platform_update_down.progressBar:set_value(this_value);
	end
end

--[[开始文件下载]]
function platform_update_down.start_file()
	platform_update.set_check_type(ServerListData.get_enter_server_type());
	platform_update.set_check_url(AppConfig.get_fserver_check_url());
	platform_update.set_down_url(AppConfig.get_fserver_down_url());
	platform_update.set_update_version_path(AppConfig.get_version_path());
	platform_update.set_update_version_gray_path(AppConfig.get_version_gray_path());
	platform_update.set_device_id(AppConfig.get_deviceid());

	platform_update.set_check_web_max_num(5);
	--[[存一下最大值]]
	platform_update_down.show_all_num = ServerListData.get_enter_server_maxopid();
	app.log("platform_update.set_version_max="..platform_update_down.show_all_num);
	platform_update.set_version_max(platform_update_down.show_all_num);--[[灰度服  设定更新最大值]]

	platform_update.set_version_index_local(AppConfig.get_fserver_version_number());

	platform_update.set_on_op_callback(platform_update_down.on_op);
	platform_update.set_on_op_error_callback(platform_update_down.on_op_error);
	platform_update.set_on_error_callback(platform_update_down.on_download_error);
	platform_update.set_on_complete_callback(platform_update_down.on_download_complete);
	platform_update.set_on_downing_callback(platform_update_down.on_downing);
	platform_update.set_on_downloaded_callback(platform_update_down.on_downloaded);

	-- this will start the auto update function
	platform_update.init();

end

-- this function will be called once on op ok
function platform_update_down.on_op(n_original_list,n_filter_list,n_all_fsize)
	app.log(string.format("[on_op] original_list: %s, filter_list: %s ", n_original_list, n_filter_list));

	platform_update_down.this_index = 0;
	platform_update_down.all_list_num = n_filter_list;
	platform_update_down.all_file_size = n_all_fsize;

	platform_update_down.set_fonts(string.format("正在更新：%s / %s",platform_update_down.this_index,platform_update_down.show_all_num));

	if platform_update_down.show_all_num <= 0 then
		platform_update_down.set_progress(1);
	else
		platform_update_down.set_progress(platform_update_down.this_index / platform_update_down.show_all_num);
	end


end

-- this function will be called once a file have been downloaded
function platform_update_down.on_op_error(err_code, err_str)
	app.log(string.format("[on_op_error] error code: %d,  error str: %s", err_code, err_str));
	platform_update_down.set_fonts("网络连接错误！请重试！");

	SystemHintUI.SetAndShow(ESystemHintUIType.two,"网络连接错误！请重试！",
		{str = "是", func = UserCenter.on_logout}, {str = "否", func = Root.quit});
end

-- this function will be called once a file have been downloaded
function platform_update_down.on_download_error(path, err_code, err_str)
	app.log(string.format("[on_download_error] path: %s, error code: %d,  error str: %s", path, err_code, err_str));
	platform_update_down.set_fonts("更新错误！请重试！");

	SystemHintUI.SetAndShow(ESystemHintUIType.two,"更新错误！请重试！",
		{str = "是", func = UserCenter.on_logout}, {str = "否", func = Root.quit});
end

-- this function will be called once a file have been downloaded
function platform_update_down.on_downing(path, fsize, result)
	app.log(string.format("[on_downing] path: %s, size: %d ", path, fsize));
end

-- this function will be called once a file have been downloaded
function platform_update_down.on_downloaded(path, fsize, result, info)
	app.log(string.format("[on_downloaded] path: %s, size: %d ", path, fsize));

	platform_update_down.this_index = platform_update_down.this_index + 1;
	platform_update_down.now_file_size = platform_update_down.now_file_size +  info.fsize;

	app.log("now_file_size>>"..platform_update_down.now_file_size.."    all>>"..platform_update_down.all_file_size);

	local temp1 = string.format("%.0f", platform_update_down.now_file_size / platform_update_down.all_file_size * 100).."%";

	platform_update_down.set_fonts(string.format("下载文件：%s     %s / %s",temp1,platform_update_down.get_mb_test(platform_update_down.now_file_size),platform_update_down.get_mb_test(platform_update_down.all_file_size)));
--	platform_update_down.set_progress(platform_update_down.this_index / platform_update_down.show_all_num);

	local temp_num = string.format("%.0f", platform_update_down.now_file_size / platform_update_down.all_file_size * 100);
	platform_update_down.set_progress(tonumber(temp_num) / 100);

	--[[判断是否有共公资源，需要重新加载公共资源]]
	for k,v in pairs(platform_update_down.shareof) do
		if string.find(path,v) then
			platform_update_down.is_reload = true;
		end
	end

end

-- this function will be called when all file have been downloaded
function platform_update_down.on_download_complete()
	app.log(string.format("[on_download_complete] you can do what you want"));
	platform_update_down.set_progress(1);
	platform_update_down.set_fonts("更新完成，进入游戏。")
	platform_update_down.Destroy();

	--[[设定文件中的资源号]]
	AppConfig.set_package_ass_ver();

	--[[下载的资源中是否有公共资源，需要重新加载]]

	app.log("is_reload="..tostring(platform_update_down.is_reload));

	if platform_update_down.is_reload then
		platform_update_down.is_reload = false;
		app.log("Root.reload_ui_init");
		--[[重新加载共公资源]]
		Root.reload_ui_init();
	else
--		if platform_update_down.call_back ~= nil then
--			platform_update_down.call_back();
--			platform_update_down.call_back = nil;
--		end

--		app.log("Resourceload.Start");
--		--[[recource_load]]
--		script.run("logic/systems/load/resource_load.lua");
--		Resourceload.Start();

		--[[登陆界面]]
		Root.legin_ui_str();
	end

end

--[[字节转KB OR MB]]
function platform_update_down.get_mb_test(fsize)
	local temp_num = tonumber(fsize);
	local siz_text = temp_num / 1024 / 1024; --[[多少M的总量]]
	if string.format("%.2f", siz_text) == "0.00" then
		siz_text = temp_num / 1024;
		siz_text = string.format("%.0f", siz_text).." KB";
	else
		siz_text = string.format("%.2f", siz_text).." MB";
	end
	return siz_text;
end