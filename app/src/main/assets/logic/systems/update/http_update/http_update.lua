--[[
  http update lib  
--]]

update_state = {
	check_version = 0,
	check_file_list = 1,
	download_res = 2,
}


http_update = {
	auto_save = true;

	version_file_name = "version.txt";
	version_file_list_name = "version_file_list.txt";
	temp_file_list_name = "temp_list.txt";

	need_download_next = false;

	single_file_max_try_times = 3;
	file_try_times = 1;
	try_url_index = 1;
	check_url_list = {};	
	down_url_list = {};
	current_downloading_index = 0;
	redirect_url = nil;

	resource_root = '';

	on_op_success_callback = nil;
	on_op_error_callback = nil;
	on_success_callback = nil;
	on_error_callback = nil;
	on_downing_callback = nil;
	on_complete_callback = nil;

	version_number = 0;
	version_lst = {};

	server_version_number = 0;
	server_version_lst = {};
	server_version = "";

	-- error_count = 0;
	need_download_cnt = 0;
	complete_count = 0;
	state = 0;

	task_list = {};
	-- down_table = {};
	-- error_table = {};
};

-- 参数:待分割的字符串,分割字符
-- 返回:子串表.(含有空串)
function http_update.string_split(str, split_char)
	local sub_str_tab = {};

	while (true) do
		local pos = string.find(str, split_char);
		if (not pos) then
			sub_str_tab[#sub_str_tab + 1] = str;
			break;
		end
		local sub_str = string.sub(str, 1, pos - 1);
		sub_str_tab[#sub_str_tab + 1] = sub_str;
		str = string.sub(str, pos + 1, #str);
	end

	return sub_str_tab;
end

function http_update.init()
	--init
	--platform_update.read_version();

	--set file update listener
	--ghttp.set_op_listener("platform_update.on_op_success", "platform_update.on_op_error");

	--TODO: kevin 检测各种参数是否齐备
		-- return false;

	--step 1
	http_update.check_update();

	return true;
end


function http_update.reset_state()
	http_update.state = 0
	http_update.try_url_index = 1;
	http_update.file_try_times = 0;
	http_update.need_download_next = false;
end



function http_update.check_update()
	app.log("http_update.check_update: "..http_update.try_url_index)

	local url = http_update.check_url_list[http_update.try_url_index]

	if http_update.state == 0 then
		app.log("get:"..url..http_update.resource_root);
		ghttp.get(url..http_update.resource_root.."/", "http_update.on_check_success", "http_update.on_check_error", http_update.version_file_name);
	end

	if http_update.state == 1 or http_update.state == 2 then    --TODO: kevin state 的含义。
		app.log("get:"..url..http_update.resource_root);
		ghttp.get(url..http_update.resource_root.."/", "http_update.on_check_success", "http_update.on_check_error", http_update.version_file_list_name);
	end
end

function http_update.on_check_success(t)
	app.log("http_update.on_check_success:"..http_update.state)

	if http_update.state == 0 then
		-- get server resource version number to decide to whether download file list.txt
		http_update.server_version_number = tonumber(t.result)
		app.log("[http_update.on_check_success] server version: "..http_update.server_version_number)

		http_update.version_number = tonumber(http_update.read_version(http_update.version_file_name))
		app.log("[http_update.on_check_success] local version: "..http_update.version_number)

		if http_update.version_number == 0 then
			file.delete(http_update.version_file_list_name);
		end

		if http_update.server_version_number - http_update.version_number > 1 then
			-- just request the newest list from http server
			http_update.state = 1
			http_update.check_update();
		elseif http_update.server_version_number - http_update.version_number == 1 then
			-- some update havn't been finish yet, we just donwload the remain temp list
			http_update.state = 1
			http_update.check_update();
		elseif http_update.server_version_number - http_update.version_number < 1 then
			-- there is no update, we are the newest
			-- http_update.state = 0
			http_update.reset_state()
			app.log("[http_update.download_list] there is no update to download")
			http_update.complete(false)
		end

		return
	end

	if http_update.state == 1 then
		app.log("[http_update.on_check_success] server version file list: ")
		-- get server update file list from http response
		http_update.server_version = t.result
		http_update.server_version_lst = http_update.get_file_list(t.result)

		app.log("[http_update.on_check_success] local version file list: ")
		-- get local update file list from disk
		http_update.version_lst = http_update.get_file_list(http_update.read_list(http_update.version_file_list_name))

		local server_list_table = {};
		local local_list_table = {};

		-- second save the server file list to a map
		server_list_table = http_update.get_list_table(http_update.server_version_lst);

		-- first save the local file list to a map
		local_list_table = http_update.get_list_table(http_update.version_lst);

		--相邻一个版本号的情况 temp_list 有效
		if file.exist(http_update.temp_file_list_name) then
			if http_update.version_number + 1 == http_update.server_version_number then
				app.log("read temp_list.txt")
				local temp_list = http_update.get_file_list(http_update.read_list(http_update.temp_file_list_name));
				local temp_list_table = http_update.get_list_table(temp_list);
				http_update.merge_table(local_list_table, temp_list_table);
			else				
				file.delete(http_update.temp_file_list_name);
			end
		end

		local need_update_table_table = {};
		-- get the file list which need to be update from server
		need_update_table_table = http_update.get_update_table(server_list_table, local_list_table)

		http_update.on_op_success_callback(need_update_table_table);
		return
	end
end

function http_update.on_check_error(t)
	--app.log_warning("on_check_error:"..http_update.try_url_index.." "..table.tostring(t))

	local url_cnt = #http_update.check_url_list
	if http_update.try_url_index < url_cnt then
		http_update.try_url_index = http_update.try_url_index + 1
		http_update.check_update()
		return
	end

	-- http_update.state = 0;
	http_update.reset_state();
	http_update.on_op_error_callback(t.path, t.err_code, t.err_str);
end



function http_update.download_list(download_table)
	http_update.state = 3;
	-- reset the download infomation
	http_update.down_table = {};
	-- http_update.error_table = {};
	http_update.complete_count = 0;
	-- http_update.error_count = 0;
	http_update.need_download_cnt = 0;

	-----------
	http_update.task_list = {}
	http_update.current_downloading_index = 0
	for k, v in pairs(download_table) do 
		http_update.task_list[#http_update.task_list + 1] = {file_name=k, file_inf = v}
	end
	http_update.need_download_cnt = #http_update.task_list

	if http_update.need_download_cnt == 0 then
		app.log("[http_update.download_list] there is no update to download")
		http_update.complete(false)
		return

	end

 	http_update.current_downloading_index = 0
 	http_update.download_next();

	-- local file_name = ""
	-- for key,item in pairs(http_update.update_table) do
	-- 	http_update.need_download_cnt = http_update.need_download_cnt + 1
	-- 	app.log(string.format("[http_update.download_list] download file: %s, md5: %s", key, item[1]));

	-- 	file_name = key .."?"..item[1]
	-- 	ghttp.down(http_update.down_url..http_update.resource_root.."/", "http_update.on_down_success",
	-- 		"http_update.on_down_error", "http_update.on_downing", file_name);
	-- end


	-- if http_update.need_download_cnt == 0 then
	-- 	app.log("[http_update.download_list] there is no update to download")
	-- 	http_update.complete(false)
	-- end
end

function http_update.download_next()
	http_update.try_url_index = 1
	http_update.file_try_times = 1

	http_update.current_downloading_index = http_update.current_downloading_index + 1

	http_update.need_download_next = true;
	http_update.download_one();
end

function http_update.download_one()
	app.log("download one: index: "..http_update.current_downloading_index);

	local item = http_update.task_list[http_update.current_downloading_index]
	app.log(string.format("[http_update.download_list] download file: %s, md5: %s", item.file_name, item.file_inf[1]));

	local try_url = http_update.down_url_list[http_update.try_url_index]

	local rqst_file_name = item.file_name

	-- ghttp.down(try_url..http_update.resource_root.."/", "http_update.on_down_success",
	-- 		"http_update.on_down_error", "http_update.on_downing", rqst_file_name);
	
	local param = "?"..item.file_inf[1];	
	if http_update.redirect_url ~= nil then
		try_url = redirect_url..param;
		http_update.redirect_url = nil;
	else
		try_url = try_url..http_update.resource_root.."/"..rqst_file_name..param;
	end
	
	util.download2file(try_url, rqst_file_name, "http_update.on_downing",
	"http_update.on_down_error", "http_update.on_down_success", "http_update.on_redirect")
end

function http_update.__purge_file_name(file_with_ver)
	local pos = string.find(file_with_ver, '?', 1, true)
	if not pos then
		return file_with_ver
	else
		return string.sub(file_with_ver, 1, pos-1)
	end
end

function http_update.on_down_success(t)
	--t.path looks like: a/b/c.txt?123123
	t.path = http_update.__purge_file_name(t.path)

	-- check if current download file's md5 code equal the md5 code which server give us
	local item = http_update.task_list[http_update.current_downloading_index]
	if t.md5 ~= item.file_inf[1] then
		app.log_warning(string.format("[http_update.on_down_success] check md5 failed: %s, t.md5: %s, update.md5: %s", t.path, t.md5, item.file_inf[1]))

		t.err_code = -1;
		t.err_str = "check md5 failed: "..t.path;

		-- give it to error handle process, while it check failed for 3 times, it will cause a download error
		http_update.on_down_error(t)
		return
	end

	if http_update.on_success_callback ~= nil then
		http_update.on_success_callback(t.path, t.fsize, t.result);
	end

	-- delete the item which download successfully in update_table, and add the item to down_table.
	-- local item = http_update.update_table[t.path];
	-- http_update.down_table[t.path] = item;
	-- http_update.update_table[t.path] = nil;
	
	local line = t.path.."\t"..item.file_inf[1].."\t"..item.file_inf[2];
	http_update.append_list(http_update.temp_file_list_name, line);

	http_update.complete_count = http_update.complete_count + 1;
	if(http_update.complete_count == http_update.need_download_cnt) then
		-- all update file have been downloaded
		http_update.complete(true)
	else
		http_update.download_next();
	end
end

function http_update.on_downing(t)
	if http_update.on_downing_callback ~= nil then
		http_update.on_downing_callback(t.path, t.down, t.current, t.total);
	end
end

function http_update.on_redirect(t)
	app.log_warning(string.format("redirect from %s to %s", tostring(t.url), tostring(t.new_url)));	

	http_update.redirect_url =  http_update.__purge_file_name(tostring(t.new_url));
	download_one();
end

function http_update.on_down_error(t)
	app.log_warning("http_update.on_down_error")

	local retry = false
	if http_update.file_try_times < http_update.single_file_max_try_times then
		retry = true
	else
		if http_update.try_url_index < #http_update.down_url_list then
			http_update.try_url_index = http_update.try_url_index + 1
			retry = true
		end
	end 

	if retry then
		app.log_warning("file download error, retry....\n")
		http_update.file_try_times = http_update.file_try_times + 1
		-- TODO: 重试提示
		http_update.download_one()
	else
		http_update.error(t);
	end

	-- if http_update.error_table[t.path] == nil then
	-- 	http_update.error_table[t.path] = 0;
	-- end

	-- -- if we retry more than 3 times, we think of it can't be download success and cause a donwload error
	-- if http_update.error_table[t.path] > 3 then
	-- 	http_update.error(t);
	-- 	return;
	-- end

	-- -- redownload the error file and add the error infomation
	-- ghttp.down(http_update.down_url..http_update.resource_root.."/", "http_update.on_down_success", "http_update.on_down_error", "http_update.on_downing", t.path);
	-- http_update.error_table[t.path] = http_update.error_table[t.path] + 1
end

function http_update.merge_table(to_table, from_table)
	for key,item in pairs(from_table) do
		-- replace to_table value from from_table
		to_table[key] = from_table[key];
	end
end

function http_update.get_update_table(server_list_table, local_list_table)
	local update_table = {};

	-- then traverse the server file list and check every "path" and "md5" with local file list map
	for key,item in pairs(server_list_table) do
		-- server has a new record or server's one md5 != local's one md5
		if( (local_list_table[key] == nil) or (local_list_table[key] ~= nil and local_list_table[key][1] ~= item[1]) ) then
			update_table[key] = item;
		end
	end

	return update_table;
end

function http_update.get_list_table(list)
	local list_table = {};

	-- first save the local file list to a map
	for i = 1, #list, 1 do
		local local_line_table = http_update.string_split(list[i], "\t")

		if #local_line_table > 2 then
			local local_key = local_line_table[1];
			local local_md5_value = local_line_table[2];
			local local_file_size = local_line_table[3];
			list_table[local_key] = {local_md5_value, local_file_size};
		end
	end


	return list_table;
end

function http_update.error(t)
	http_update.reset_state()
	-- http_update.state = 0;
	file.delete(t.path);

	if http_update.on_error_callback ~= nil then
		http_update.on_error_callback(t.path, t.err_code, t.err_str);
	end
end

function http_update.complete(is_update)
	-- http_update.state = 0;
	http_update.reset_state()

	if is_update == true and http_update.auto_save == true then
		http_update.write(true);
	end

	if http_update.on_complete_callback ~= nil then
		http_update.on_complete_callback();
	end
end

function http_update.write(delete_temp)
	if delete_temp == true then
		file.delete(http_update.temp_file_list_name);
	end

	http_update.write_version(http_update.version_file_name, tostring(http_update.server_version_number))
	http_update.write_list(http_update.version_file_list_name, http_update.server_version)
end

function http_update.get_file_list(all_text)
	-- parse list content to line table
	local line_table = http_update.string_split(all_text, "\n")
	return line_table
end

function http_update.print(line_table)
	for key,value in ipairs(line_table) do
		app.log("line: "..value)
	end
end

function http_update.read_list(path)
	-- read the file list content from local disk
	local file_handler = file.open_read(path)
	if file_handler == nil then
		return ""
	end

	local all_text = file_handler:read_all_text()
	file_handler:close()

	if all_text == nil then
		return ""
	end

	return all_text;
end

function http_update.read_version(path)
	-- read the file version from local disk
	local file_handler = file.open_read(path)
	if file_handler == nil then
		return AppConfig.http_platform_update()
	end

	local version = file_handler:read_line()
	file_handler:close()

	if version == nil then
		return "0"
	end

	return version
end

function http_update.write_version(path, file_version)
	-- write the file version to local disk
	local file_handler = file.open(path, 2)
	if file_handler == nil then
		return nil
	end

	file_handler:write_string(file_version)
	file_handler:close()
end

function http_update.write_list(path, file_list)
	-- write the file list content to local disk
	local file_handler = file.open(path, 2)
	if file_handler == nil then
		return nil
	end

	file_handler:write_string(file_list)
	file_handler:close()
end

function http_update.append_list(path, line)
	local file_handler = file.open(path, 6)
	if file_handler == nil then
		return nil
	end

	file_handler:write_string(line)
	file_handler:close()
end

return http_update;