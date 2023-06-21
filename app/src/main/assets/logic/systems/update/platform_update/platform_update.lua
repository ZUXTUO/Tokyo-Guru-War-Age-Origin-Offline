--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/9/21
-- Time: 17:40
-- To change this template use File | Settings | File Templates.
--

platform_update = {

	check_url_list = {};
	check_url_use = "http://192.168.20.244:7022/";
	check_url_use = "";

	check_type = "";

	check_file_path = "digisky_file_server/checkfile?deviceid=30000&optype=android";
	check_file_server_path = "check_file.data";

	check_op_path = "digisky_file_server/CheckOP?deviceid=30000&opid=0&optype=android";

	down_url_list = {};
	down_url_use = "http://192.168.20.244:92/ghoul/";
	down_url_use = "";

	update_version_path = AppConfig.get_version_path();--[[版本文件地址]]
	update_gray_version_path = AppConfig.get_version_gray_path();--[[版本文件地址]]
	device_id = 0;
	version_index_local = 0;--[[本地版本号]]
	version_max = -1;--[[灰度 最大更新值]]

	url_max_num = 3;--[[每个URL使用次数]]
	
	web_max_num = 5;--[[WEB访问自动重连最大次数]]
	web_num_now = 0;

	down_max_num = 3;--[[每个文件下载的最大次数]]
	down_num_now = 0;
	re_down_url = "";--[[重定向下载的URL]]

	on_op_callback = nil;
	on_op_error_callback = nil;
	on_error_callback = nil;
	on_complete_callback = nil;
	on_downing_callback = nil;
	on_downloaded_callback = nil;

	web_list = {};

	downing_obj = nil;
	version_index_use = 1;
	version_index_max = 99999;
	version_lst = {};
};


--[[清理]]
function platform_update.clear()
	platform_update.version_lst = {};
	platform_update.version_index_use = 1;
	platform_update.version_index_max = 99999;
	platform_update.downing_obj = nil;
end

--[[查看op最大次数]]
function platform_update.check_max_num_web(re_set)
	if tostring(re_set) == "reset" then
		platform_update.init_op_url_num();
		return true;
	else
		if not platform_update.get_op_url() then
			platform_update_down.set_fonts("Connect Fail！Please contact GM and Try again later！");
			return false;
		else
			platform_update_down.set_fonts("Connect....  ");
			return true;
		end
	end
end

--[[查看down最大次数]]
function platform_update.check_max_num_down(re_set)
	if tostring(re_set) == "reset" then
		platform_update.init_down_url_num()
		return true;
	else
		if not platform_update.get_down_url() then
			platform_update_down.set_fonts("Connect Fail！Please contact GM and Try again later！");
			return false;
		else
			platform_update_down.set_fonts("Connect....  ");
			return true;
		end
	end
end

--[[INIT]]
function platform_update.init()
	app.log("platform_update.init");
	--[[读取本地版本号 判断是否需要更新]]
	if platform_update.read_version() then
		app.log("本地版本号与线上号一样，不需要更新.");
		--[[版本正常 直接跳过更新]]
		if platform_update.on_complete_callback ~= nil then
			platform_update.on_complete_callback();
			do return end;
		end
	end
	--[[需要更新]]

	platform_update.check_file_path = AppConfig.get_fserver_check_op_path().."/checkfile?".."deviceid="..platform_update.device_id.."&optype="..platform_update.check_type;
	platform_update.check_op_path = AppConfig.get_fserver_check_op_path().."/CheckOP?".."deviceid="..platform_update.device_id.."&opid="..platform_update.version_index_local.."&optype="..platform_update.check_type;

	app.log("platform_update.check_file_path>>"..platform_update.check_file_path);
	app.log("platform_update.check_op_path>>"..platform_update.check_op_path);

	--[[取得FILE MAP文件]]
	platform_update.get_check_file()
end

--[[取得FILE MAP文件]]
function platform_update.get_check_file()
	--[[查看最大次数]]
	if not platform_update.check_max_num_web() then
		return;
	end
	app.log("platform_update.check_url_use url="..platform_update.check_url_use);
	ghttp.set_check_file_listener("platform_update.get_check_file_on_success", "platform_update.get_check_file_on_error");
	ghttp.check_file(platform_update.check_url_use..platform_update.check_file_path, platform_update.check_file_server_path);
end
function platform_update.get_check_file_on_error(t)
	app.log("get_check_file_on_error="..table.tostring(t));
	platform_update.is_check_file = false;
	if tostring(t.err_code) == "301" or tostring(t.err_code) == "302" then
		ghttp.check_file(t.err_str, platform_update.check_file_server_path);
	else
		timer.create("platform_update.get_check_file", 500, 1);
	end
end
function platform_update.get_check_file_on_success(t)
	app.log("get_check_file_on_success"..table.tostring(t));
	platform_update.is_check_file = true;
	--[[重置连接次数]]
	platform_update.check_max_num_web("reset");
	--[[读取本地版本号]]
	platform_update.read_version();
	--[[清库]]
	platform_update.clear();
	--[[OP]]
	platform_update.check_op_start();
end

--[[OP]]
function platform_update.check_op_start()
	app.log("check_op_start");
	--[[查看最大次数]]
	if not platform_update.check_max_num_web() then
		return;
	end
	ghttp.set_op_listener("platform_update.check_op_on_success", "platform_update.check_op_on_error");
	if platform_update.re_down_url ~= "" then
		app.log("check_op = "..platform_update.re_down_url);
		ghttp.check_op(platform_update.re_down_url);
	else
		ghttp.check_op(platform_update.check_url_use..platform_update.check_op_path);
	end
end
function platform_update.check_op_on_error(t)
	app.log("check_op_on_error="..table.tostring(t));

	if tostring(t.err_code) == "301" or tostring(t.err_code) == "302" then
		app.log("check_op_on_error err_code == "..t.err_code);
		app.log("check_op_on_error err_str == "..t.err_str);
		platform_update.re_down_url = t.err_str;
		platform_update.check_op_start();
	else
		timer.create("platform_update.check_op_start", 500, 1);
	end
end
function platform_update.check_op_on_success(t)
	app.log("check_op_on_success is ok="..table.tostring(t));
	platform_update.re_down_url = "";
	--[[重置连接次数]]
	platform_update.check_max_num_web("reset");

	--step 2 response
	app.log("[platform_update on_success]check_op_on_success:" .. t.all_fsize .. ", count:" .. #t );
	app.log("original list: "..#t);

	platform_update.web_list = table.deepcopy(t);

	app.log("platform_update.filter_op_list>"..table.tostring(platform_update.web_list));

	--[[转表：拼接MD5值]]
	platform_update.filter_op_list(platform_update.web_list);

	app.log("platform_update.filter_op_list>"..table.tostring(platform_update.web_list));
	app.log("platform_update.version_lst>"..table.tostring(platform_update.version_lst));

	--[[回调界面显示]]
	if platform_update.on_op_callback ~= nil then
		platform_update.on_op_callback(#t,#platform_update.version_lst,tonumber(t.all_fsize));
	end

	--[[不需要更新]]
	if table.getn(platform_update.version_lst) == 0 then
		if platform_update.on_complete_callback ~= nil then
			platform_update.on_complete_callback();
			return;
		end
	end

	platform_update.check_max_num_down("reset");
	platform_update.check_max_num_down();

	--[[网络WIFI提示]]
	if Root.get_network_type() ~= 2 then
		local siz_text = platform_update_down.get_mb_test(tonumber(t.all_fsize));
		SystemHintUI.SetAndShow(ESystemHintUIType.two, "更新大小："..siz_text.."\n您正在使用移动数据！",
			{str = "更新", func = platform_update.version_list_handle}, {str = "取消", func = Root.quit});
	else
		--[[开始下载]]
		platform_update.version_list_handle();
	end

end

--[[转表：拼接MD5值]]
function platform_update.filter_op_list(list)
	platform_update.version_lst = {};
	for i = 1, table.getn(list) do
		local md5 = ghttp.get_check_file_value(list[i].path);
		list[i].md5 = md5;
		table.insert(platform_update.version_lst,list[i]);
	end
end

--[[下载文件]]
function platform_update.version_list_handle()
	platform_update.downing_obj = platform_update.version_lst[platform_update.version_index_use];--[[取INDEX]]
	app.log("DOWN URL="..platform_update.down_url_use);
	if platform_update.downing_obj.type == 1 or platform_update.downing_obj.type == 2 then
		app.log("[platform_update version_list_handle] download item: "..platform_update.downing_obj.path.." oid: "..tostring(platform_update.downing_obj.oid));
		app.log(platform_update.downing_obj.oid..">>>>>>"..ServerListData.get_release_maxid());
		--[[判断oid是不是超过了正式服，如果超过了就保存到gray灰度服目录]]
		if tonumber(platform_update.downing_obj.oid) <= ServerListData.get_release_maxid() then
			--[[正式服]]
			app.log("正式服"..platform_update.downing_obj.path);
			ghttp.down(platform_update.down_url_use..platform_update.downing_obj.path.."."..platform_update.downing_obj.md5, "platform_update.on_down_success", "platform_update.on_down_error", "platform_update.on_down_ing",platform_update.downing_obj.path, platform_update.downing_obj.path);
		else
			--[[灰度服]]
			app.log("灰度服:"..AppConfig.get_gray_path()..platform_update.downing_obj.path);
			ghttp.down(platform_update.down_url_use..platform_update.downing_obj.path.."."..platform_update.downing_obj.md5, "platform_update.on_down_success", "platform_update.on_down_error", "platform_update.on_down_ing",platform_update.downing_obj.path, AppConfig.get_gray_path()..platform_update.downing_obj.path);
		end

	elseif platform_update.downing_obj.type == 3 then
		app.log("[platform_update version_list_handle] delete item: "..platform_update.downing_obj.path);
		file.delete(platform_update.downing_obj.path);
		platform_update.item_success_handle();
	else
		app.log("[platform_update version_list_handle] ignore item: "..platform_update.downing_obj.path);
		platform_update.item_success_handle();
	end
end

--[[重定向下载]]
function platform_update.re_file_donw(url)
	platform_update.downing_obj = platform_update.version_lst[platform_update.version_index_use];--[[取INDEX]]
	if platform_update.downing_obj.type == 1 or platform_update.downing_obj.type == 2 then
		app.log("[platform_update version_list_handle] download item: "..platform_update.downing_obj.path.." oid: "..tostring(platform_update.downing_obj.oid));
		ghttp.down(url, "platform_update.on_down_success", "platform_update.on_down_error", "platform_update.on_down_ing",platform_update.downing_obj.path);
	end
end

--[[索引自增  ADD下条]]
function platform_update.item_success_handle()
	app.log("all index="..table.getn(platform_update.version_lst).."  lst index="..tostring(platform_update.version_index_use));

	if platform_update.version_lst[platform_update.version_index_use] == nil then
		app.log("数组越界:"..#platform_update.version_lst..">"..platform_update.version_index_use);
		--[[数组越界]]
		if platform_update.on_error_callback ~= nil then
			platform_update.on_error_callback();
		end
		do return end;
	end

	platform_update.write_version(platform_update.version_lst[platform_update.version_index_use].oid);

	--[[判断是不是超过了设定最大更新值]]
	app.log(platform_update.version_lst[platform_update.version_index_use].oid..">>MAX>>"..platform_update.version_max);
	if platform_update.version_max ~= -1 and platform_update.version_lst[platform_update.version_index_use].oid  >= platform_update.version_max then
		app.log("==version_max:"..platform_update.version_max);
		if platform_update.on_complete_callback ~= nil then
			platform_update.on_complete_callback();
		end
		do return end;
	end

	--[[继续下一个文件]]
	platform_update.version_index_use = platform_update.version_index_use + 1;

	--[[所以文件全部下载完 不设上限]]
	if platform_update.version_index_use > table.getn(platform_update.version_lst) then
		if platform_update.on_complete_callback ~= nil then
--			platform_update.on_complete_callback();
		end
		return;
	end

	--[[下载文件]]
	platform_update.version_list_handle();
end

function platform_update.on_down_ing(t)
end
function platform_update.on_down_error(t)
	app.log("[platform_update on_down_error] error code: " .. tostring(t.err_code).." error info: ".. t.err_str);

	--[[超过次数 返回]]
	if platform_update.check_max_num_down() then
		if tostring(t.err_code) == "301" or tostring(t.err_code) == "302" then
			platform_update.re_file_donw(t.err_str);
		else
			--[[下载文件]]
			platform_update.version_list_handle();
		end
	else
		if platform_update.on_error_callback ~= nil then
			platform_update.on_error_callback(t.path, t.err_code, t.err_str);
		end
	end
end
function platform_update.on_down_success(t)
	if platform_update.on_downloaded_callback ~= nil then
		platform_update.on_downloaded_callback(t.path, t.fsize, t.result,platform_update.version_lst[platform_update.version_index_use]);
	end
	--[[索引自增  ADD下条]]
	platform_update.item_success_handle();
end

--[[OP URL自增]]
function platform_update.get_op_url()
	for i=1,table.getn(platform_update.check_url_list) do
		if platform_update.check_url_list[i].use_num < platform_update.url_max_num then
			platform_update.check_url_list[i].use_num = platform_update.check_url_list[i].use_num + 1;
			platform_update.check_url_use = platform_update.check_url_list[i].url;
			return true;
		end
	end
	platform_update.check_url_use = "";
	return false;
end
--[[还原OP URL使用次数]]
function platform_update.init_op_url_num()
	for i=1,table.getn(platform_update.check_url_list) do
		platform_update.check_url_list[i].use_num = 0;
	end
end

--[[DOWN URL自增]]
function platform_update.get_down_url()
	for i=1,table.getn(platform_update.down_url_list) do
		if platform_update.down_url_list[i].use_num < platform_update.url_max_num then
			platform_update.down_url_list[i].use_num = platform_update.down_url_list[i].use_num + 1;
			platform_update.down_url_use = platform_update.down_url_list[i].url;
			return true;
		end
	end
	return false;
end
--[[还原DOWN URL使用次数]]
function platform_update.init_down_url_num()
	for i=1,table.getn(platform_update.down_url_list) do
		platform_update.down_url_list[i].use_num = 0;
	end
end


--[[读取本地版本号]]
function platform_update.read_version()
	local local_version = 0;
	local file_handler = nil;
	if Root.get_is_gray() then
		app.log("gray");
		--[[初始判断灰度VER文件在不在，是否需要从正式服CP一份]]
		platform_update.check_gray_ver();
		--[[灰度]]
		file_handler = file.open(platform_update.update_gray_version_path, 4);
	else
		app.log("no gray");
		--[[正式]]
		file_handler = file.open(platform_update.update_version_path, 4);
	end

	if file_handler == nil then
		app.log("no have version.txt");
		return;
	end

	local version = file_handler:read_string()
	file_handler:close();
	if version ~= nil and version ~= "" then
		--[[check num]]
		if tonumber(version) ~= nil then
			if tonumber(version) > 0 then
				local_version = tonumber(version);
			end
		end
		app.log("read version number:"..local_version)
	end

	if platform_update.version_index_local ~= 0 then
		--[[包内版本号不为0]]
		if local_version > platform_update.version_index_local then
			--[[本地文件读出来的版本大于包内版本号，说明已经更新过了，所以使用本地文件读出来的版本号进行更新 舍弃包内预值版本号]]
			platform_update.version_index_local = local_version;
		else
			--[[本地文件读出来的版本号小于包内版本号，说明包内比包外新，直接使用包内的版本号，其这不应该出现这种情况，因为新包会把下载更新的版本文件删除]]
		end
	else
		--[[包内版本号=0 直接使用读出来的值]]
		platform_update.version_index_local = local_version;
	end

	--[[如果本地的版本号等于设定应该更新的版本号，那么就直接成功，只有小于设定的版本号才更新，灰度服需要这样设计]]
	if tostring(platform_update.version_index_local) == tostring(platform_update.version_max) then
		return true;
	else
		return false;
	end
end

--[[初始判断灰度VER文件在不在，是否需要从正式服CP一份]]
function platform_update.check_gray_ver()
	local local_version = 0;
	local local_version_grap = 0;
	local file_handler = nil;
	local version = "";

	file_handler = file.open(platform_update.update_gray_version_path, 4);--[[灰度]]

	--[[先读出内容]]
	version = "";
	version = file_handler:read_string();
	file_handler:flush();
	file_handler:close();
	if version ~= nil and version ~= "" then
		--[[check num]]
		if tonumber(version) ~= nil then
			if tonumber(version) > 0 then
				local_version_grap = tonumber(version);
			end
		end
	end

	if local_version_grap > 0 then
		--[[灰度原来有文件]]
		do return end;
	end

	--[[没有文件，那么CP正式文件过来]]

	file_handler = file.open(platform_update.update_version_path, 4);--[[正式]]
	--[[正式的版本号]]
	version = "";
	version = file_handler:read_string();
	file_handler:flush();
	file_handler:close();
	if version ~= nil and version ~= "" then
		--[[check num]]
		if tonumber(version) ~= nil then
			if tonumber(version) > 0 then
				local_version = tonumber(version);
			end
		end
	end

	--[[写入灰度版本号]]
	file_handler = file.open(platform_update.update_gray_version_path, 2);
	file_handler:write_string(tostring(local_version));
	file_handler:flush();
	file_handler:close();
end

--[[写入版本号]]
function platform_update.write_version(version)
	app.log("write_version==="..tostring(version));

	--[[正式服与灰度服都要分情况写入]]

	local file_handler = nil;
	if tonumber(version) <= ServerListData.get_release_maxid() then
		--[[正式服]]
		app.log("正式服");
		file_handler = file.open(platform_update.update_version_path, 2)
	else
		app.log("灰度服");
		file_handler = file.open(platform_update.update_gray_version_path, 2)
	end

	if file_handler == nil then
		app.log("no have version.txt");
		return;
	end
	file_handler:write_string(tostring(version));
	file_handler:flush();
	file_handler:close();
end

--[[对外接口]]
function platform_update.set_check_type(type)
	if type == nil then return end;
	platform_update.check_type = tostring(type);
end

function platform_update.set_check_url(url_list)
	if url_list == nil then return end;
	platform_update.check_url_list = {};
	for i=1,table.getn(url_list) do
		local temp = {};
		temp.url = url_list[i];
		temp.use_num = 0;
		table.insert(platform_update.check_url_list,temp);
	end
end
function platform_update.set_down_url(url_list)
	if url_list == nil then return end;
	platform_update.down_url_list = {};
	for i=1,table.getn(url_list) do
		local temp = {};
		temp.url = url_list[i]..AppConfig.get_fserver_down_path().."/";
		temp.use_num = 0;
		table.insert(platform_update.down_url_list,temp);
	end
end
function platform_update.set_update_version_path(s_url)
	if s_url == nil or s_url == "" then return end;
	platform_update.update_version_path = s_url;
end
function platform_update.set_update_version_gray_path(s_url)
	if s_url == nil or s_url == "" then return end;
	platform_update.update_gray_version_path = s_url;
end
function platform_update.set_device_id(n_id)
	if n_id == nil then return end;
	platform_update.device_id = n_id;
end
function platform_update.set_check_web_max_num(n_id)
	if n_id == nil then return end;
	platform_update.web_max_num = n_id;
end
function platform_update.set_version_max(n_id)
	if n_id == nil then return end;
	platform_update.version_max = n_id;
end
function platform_update.set_version_index_local(n_id)
	if n_id == nil then return end;
	platform_update.version_index_local = n_id;
end
function platform_update.set_on_op_callback(call_back)
	if call_back == nil then return end;
	if not type(call_back) == "function" then return end;
	platform_update.on_op_callback = call_back;
end
function platform_update.set_on_op_error_callback(call_back)
	if call_back == nil then return end;
	if not type(call_back) == "function" then return end;
	platform_update.on_op_error_callback = call_back;
end
function platform_update.set_on_error_callback(call_back)
	if call_back == nil then return end;
	if not type(call_back) == "function" then return end;
	platform_update.on_error_callback = call_back;
end
function platform_update.set_on_complete_callback(call_back)
	if call_back == nil then return end;
	if not type(call_back) == "function" then return end;
	platform_update.on_complete_callback = call_back;
end
function platform_update.set_on_downing_callback(call_back)
	if call_back == nil then return end;
	if not type(call_back) == "function" then return end;
	platform_update.on_downing_callback = call_back;
end
function platform_update.set_on_downloaded_callback(call_back)
	if call_back == nil then return end;
	if not type(call_back) == "function" then return end;
	platform_update.on_downloaded_callback = call_back;
end
function platform_update.get_web_list()
	return platform_update.web_list;
end
