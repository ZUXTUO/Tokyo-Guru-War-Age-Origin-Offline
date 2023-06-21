--[[--异步加载器
AsyncLoader = {};

local loader = asset_loader.create("AsyncLoader");
local loadingAssets = {};
local funCallback = {};

--------------外部接口----------------------------------
--参数：path：路径字符串
--      string_callback: 回调函数字符串
function AsyncLoader.load(path,callback)
	if(loadingAssets[path] == nil)then
		if(funCallback[path] == nil)then
			funCallback[path] = {};
		end
		funCallback[path][#funCallback[path] + 1] = callback;
		loader:set_callback("AsyncLoader.callback");
		loadingAssets[path] = true;
		loader:load(path);
	else
		if(not funCallback[path])then
			app.log("path=="..path);
			return
		end
		funCallback[path][#funCallback[path] + 1] = callback;
	end
end

-----------内部接口----------------------
--回调函数
function AsyncLoader.callback(pid, filepath, asset_obj, error_info)
	local callback_type = ""
	local global_callback = nil
	for k,v in pairs(funCallback[filepath]) do
		-- if(_G[v] ~= nil and type(_G[v]) == "function")then
		-- 	_(G[v]pid, filepath, asset_obj, error_info);
		-- end
		callback_type = type(v)
		if callback_type == "string" then
			global_callback = _G[v]
			if global_callback ~= nil and type(global_callback) == "function" then
				global_callback(pid, filepath, asset_obj, error_info)
			else
				app.log_warning("AsyncLoader.callback faild 01.")
			end
		elseif callback_type == "table" then
			v.func(v.user_data, pid, filepath, asset_obj, error_info)
		else
			app.log_warning("AsyncLoader.callback faild 02.")
		end
	end
	loadingAssets[filepath] = nil;
	funCallback[filepath] = {};
end]]