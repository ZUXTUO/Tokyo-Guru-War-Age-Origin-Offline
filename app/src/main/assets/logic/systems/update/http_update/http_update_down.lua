--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2016/1/12
-- Time: 11:40
-- To change this template use File | Settings | File Templates.
--

script.run("logic/app_config/app_config.lua");

http_update_down = {
	mainUI = nil,
	update_list = {};
	update_list_all_num = 0;
	update_list_down_now = 1;
	shareof = {};--[[公共资源名]]
	is_reload = false;--[[下载的资源中是否有公共资源，需要重新加载]]
};

function http_update_down.init()
	http_update_down.update_list_all_num = 0;
	http_update_down.update_list_down_now = 0;
end

function http_update_down.Destroy()
	if http_update_down.mainUI ~= nil then
		http_update_down.mainUI:set_active(false);
	end
	http_update_down.mainUI = nil;
	http_update_down.progressBar = nil;
	http_update_down.progressBarTxt = nil;
end

function http_update_down.start()
	--[[初始化版本文件]]
--	http_update_down.init_version_file("version.txt");
--	http_update_down.init_version_file("version_file_list.txt");

	--[[公共资源标示]]
	local temp_str = AppConfig.get_asst_path_shareof();
	http_update_down.shareof = systems_func.string_split(temp_str,"@");

	local ui_path = "assetbundles/prefabs/ui/loading/updateload.assetbundle";
	http_update_down._asset_loader = systems_func.loader_create("ResourceLoader_loader")
	http_update_down._asset_loader:set_callback("http_update_down.asset_loaded")
	http_update_down._asset_loader:load(ui_path);
	http_update_down._asset_loader = nil;
end

--[[如果写目录不存在，读目录存在，就把读目录的CP到写目录   已废]]
function http_update_down.init_version_file(file_name)
	if (not file.write_exist(file_name)) and file.read_exist(file_name) then
		local all_text = "";
		local file_handler = file.open_read(file_name);
		if file_handler ~= nil then
			all_text = file_handler:read_all_text();
			file_handler:close();
		end
		file_handler = nil;

		file_handler = file.open(file_name, 2);
		if file_handler ~= nil then
			if all_text ~= nil then
				file_handler:write_string(all_text);
			end
			file_handler:close();
		end
	end
end

function http_update_down.asset_loaded(pid, fpath, asset_obj, error_info)
	http_update_down.mainUI = systems_func.game_object_create(asset_obj);
	Root.SetRootUI(http_update_down.mainUI);
	http_update_down.progressBar = ngui.find_progress_bar(http_update_down.mainUI,"progress_bar");
	if http_update_down.progressBar ~= nil then
		http_update_down.progressBar:set_active(true);
		http_update_down.set_progress(0);
	end
	http_update_down.progressBarTxt = ngui.find_label(http_update_down.mainUI,"progress_font_label");
	if http_update_down.progressBarTxt ~= nil then
		http_update_down.set_fonts("正在查询文件更新...");
	end

	http_update_down.start_file();
end

function http_update_down.set_fonts(str)
	if http_update_down.progressBarTxt ~= nil and str ~= nil then
		http_update_down.progressBarTxt:set_active(true);
		http_update_down.progressBarTxt:set_text(tostring(str));
	end
end

function http_update_down.set_progress(value)
	if type(value) ~= "number" or type(value) == "nil" then return end;
	local this_value = string.format("%6.2f", value);
	if http_update_down.progressBar ~= nil then
		http_update_down.progressBar:set_active(true);
		http_update_down.progressBar:set_value(this_value);
	end
end

--[[开始文件下载]]
function http_update_down.start_file()
	-- this will start the auto update function
    http_update.check_url_list = AppConfig.get_http_op_url();
    http_update.down_url_list = AppConfig.get_http_down_url();
	--[[--TODO 现在取版本文件的目录名，下载资源的目录名也必需一样,不然无法下载文件，
	-- 虽然HTTP得到的信息支持版本文件目录与下载目录不相同，但还是使用同相的名字
	-- ]]

	--TODO: kevin 	res_update_server "path 提取出来"
    http_update.resource_root = AppConfig.get_http_resource_root();

    app.log("resource root."..http_update.resource_root)

    http_update.version_number = AppConfig.http_platform_update();

    http_update.on_op_success_callback = http_update_down.on_op_success;
    http_update.on_op_error_callback = http_update_down.on_op_error;


	http_update.on_success_callback = http_update_down.on_download_success;
    http_update.on_error_callback = http_update_down.on_download_error;
    http_update.on_downing_callback = http_update_down.on_downing;
    http_update.on_complete_callback = http_update_down.on_download_complete;

    -- this will start the auto update function
    http_update.init();
end
--[[OP]]
function http_update_down.on_op_success(update_list)


	Root.push_web_info("update_op_ok","on_op_success is ok");
	app.log(string.format("[on_op_success] get update_list ok"));

	-- do return end;

	http_update_down.update_list = update_list;
	needReLoadShader = false;	
	http_update_down.update_list_all_num = 0;
	
    --[[计算总大小]]    
    local info_siz = 0;
    for k,v in pairs(update_list) do
		http_update_down.update_list_all_num = http_update_down.update_list_all_num + 1;
    	info_siz = info_siz + v[2];
    end
    local siz_text = info_siz / 1024 / 1024; --[[多少M的总量]]
    if string.format("%.2f", siz_text) == "0.00" then
		siz_text = info_siz / 1024;
		siz_text = string.format("%.0f", siz_text).." KB";
	else
		siz_text = string.format("%.2f", siz_text).." M";
    end

	--[[网络WIFI提示]]
	if Root.get_network_type() ~= 2 then
		Root.push_web_info("update_ok_no_wifi","on_op_success is ok");
		SystemHintUI.SetAndShow(ESystemHintUIType.two, "更新大小："..siz_text.."\n您正在使用移动数据！",
			{str = "更新", func = http_update_down.time_set_update_list}, {str = "取消", func = Root.quit});
	else
		http_update.download_list(http_update_down.update_list);
	end
end
function http_update_down.time_set_update_list()
	http_update_down.set_fonts("需要几秒钟准备更新列表......");
	timer.create("http_update_down.set_update_list", 100, 1);
end
function http_update_down.set_update_list()
	Root.push_web_info("update_set_update_list","set_update_list");
	http_update.download_list(http_update_down.update_list);
end

-- this function will be called once a check update file have been download failed
function http_update_down.on_op_error(path, err_code, err_str)
	--[[重联]]
    app.log(string.format("[on_op_error] path: %s, error code: %d,  error str: %s", path, err_code, err_str));

	Root.push_web_info("update_op_error","on_op_success is error");

    if string.find(path,'version.txt', 1, true) then
		Root.push_web_info("update_op_error_version","on_op_error");
		SystemHintUI.SetAndShow(ESystemHintUIType.two, "版本文件无法获取，请多试几次。\n如果一直无法获取请报告GM！",
			{str = "是", func = http_update.init}, {str = "否", func = Root.quit});
    elseif string.find(path,'version_file_list.txt', 1, true) then
		Root.push_web_info("update_op_error_version_file_list","version_file_list");
		SystemHintUI.SetAndShow(ESystemHintUIType.two, "下载例表无法获取，请多试几次。\n如果一直无法获取请截图报告GM！",
			{str = "是", func = http_update.init}, {str = "否", func = Root.quit});
    end
end

--[[DOWN]]
-- this function will be called once a file have been downloaded
function http_update_down.on_download_error(path, err_code, err_str)
	Root.push_web_info("update_on_download_error",string.format("[on_download_error] path: %s, error code: %d,  error str: %s", path, err_code, err_str));

    app.log(string.format("[on_download_error] path: %s, error code: %d,  error str: %s", path, err_code, err_str));
	http_update_down.set_fonts(string.format("更新失败：%s, code: %d, str: %s", path, err_code, err_str));

	SystemHintUI.SetAndShow(ESystemHintUIType.two, "更新失败："..path.."\n请多试几次,截图报告GM！",
		{str = "是", func = function() http_update_down.init(); http_update.init() end}, {str = "否", func = Root.quit});
end

-- this function will be called once a file have been downloaded
function http_update_down.on_download_success(path, fsize, result)
	http_update_down.update_list_down_now = http_update_down.update_list_down_now + 1;
    app.log(string.format("[ooon_download_success] path: %s, size: %d result: %s", path, fsize, tostring(result)));

    --[[判断是否有共公资源，需要重新加载公共资源]]
    for k,v in pairs(http_update_down.shareof) do
		if string.find(path,v) then
			http_update_down.is_reload = true;
		end
    end
end

function http_update_down.on_downing(path, down, current, total)
	app.log(string.format("[on_downing] path: %s, down size: %d, current size: %d, total size: %d", path, down, current, total));
	local n_current_kb =  math.ceil(current / 1024);
	local n_fsize_kb =  math.ceil(total / 1024);
	if n_fsize_kb == 0 then
		http_update_down.set_progress(1);
	else
		http_update_down.set_progress(n_current_kb / n_fsize_kb);
	end
--	http_update_down.set_fonts(string.format("正在更新[%d/%d]：%s %d / %d KB",http_update_down.update_list_down_now,http_update_down.update_list_all_num,path,n_current_kb,n_fsize_kb));
	http_update_down.set_fonts(string.format("正在更新[%d/%d]： %d / %d KB",http_update_down.update_list_down_now,http_update_down.update_list_all_num,n_current_kb,n_fsize_kb));
end

-- this function will be called when all file have been downloaded
function http_update_down.on_download_complete()
	Root.push_web_info("update_on_download_complete","on_download_complete");
    app.log(string.format("[on_download_complete] you can do what you want"));
	http_update_down.set_progress(1);
	http_update_down.set_fonts("更新完成，进入游戏。")
	http_update_down.Destroy();
	--[[设定文件中的资源号]]
	AppConfig.set_package_ass_ver();

	--[[热更新完成]]
	SystemLog.AppStartClose(500000006);

	--[[下载的资源中是否有公共资源，需要重新加载]]
	app.log("is_reload="..tostring(http_update_down.is_reload));

	if http_update_down.is_reload then
		http_update_down.is_reload = false;
		app.log("Root.reload_ui_init");
		--[[重新加载共公资源]]
		Root.reload_ui_init();
	else
--		app.log("Resourceload.Start");
--		--[[recource_load]]
--		script.run("logic/systems/load/resource_load.lua");
--		Resourceload.Start();

		--[[登陆界面]]
		Root.legin_ui_str();
	end
end

