--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/12/15
-- Time: 15:20
-- To change this template use File | Settings | File Templates.
--

--[[3D背景]]

login_bg = {
	reload_call_back = nil;--[[重新加载公共图集时回调方法]]
};


function login_bg.Start(call_back)
	app.log("login_bg begin");
	login_bg.reload_call_back = call_back;
	login_bg._asset_loader = systems_func.loader_create("ResourceLoader_loader")
	login_bg._asset_loader:set_callback("login_bg.on_load")
	login_bg._asset_loader:load("assetbundles/prefabs/ui/logo/logo_1.assetbundle");
	login_bg._asset_loader = nil;
end

function login_bg.on_load(pid, fpath, asset_obj, error_info)
	login_bg.ui = systems_func.game_object_create(asset_obj);
	login_bg.ui:set_parent(Root.get_root_ui_2d());
	login_bg.ui:set_name("login_bg");
	login_bg.ui:set_local_rotation(0, 0, 0);
	login_bg.ui:set_local_scale(1, 1, 1);
	app.log("login_bg ok");

	--[[UC渠道特别处理 在显示UI前调用SDK初始化]]
	if AppConfig.get_check_uc() then
		app.log("UC SDK INIT TO LUA");
		local table_info = {};
		table_info.type = "sdkInit";
		local json_info = pjson.encode(table_info);
		user_center.submit_extend_info(json_info);
	end

	--[[再次加载一个界面]]
	timer.create("login_bg.load_other", 7000, 1);

end

--[[再次加载一个界面]]
function login_bg.load_other()
	login_bg._asset_loader2 = systems_func.loader_create("ResourceLoader_loader2")
	login_bg._asset_loader2:set_callback("login_bg.on_load_other")
	login_bg._asset_loader2:load("assetbundles/prefabs/ui/login/login_bg.assetbundle");
	login_bg._asset_loader2 = nil;
end

function login_bg.on_load_other(pid, fpath, asset_obj, error_info)

	if nil ~= login_bg.ui then
		login_bg.ui:set_active(false);
	end
	login_bg.ui = nil

	login_bg.ui2 = systems_func.game_object_create(asset_obj);
	login_bg.ui2:set_parent(Root.get_root_ui_2d());
	login_bg.ui2:set_name("login_bg2");
	login_bg.ui2:set_local_rotation(0, 0, 0);
	login_bg.ui2:set_local_scale(1, 1, 1);

	-- app.log("login_bg2 ok");

	local audioObj = asset_game_object.find("uiroot/ui_2d/login_bg2/audio_obj");
	if audioObj then
		local file_handler = file.open("setting.data",4);
		if file_handler then
			local aaa = file_handler:read_all_text()
			if aaa == "" then
				audioObj:set_active(true);
			else
				local bbb = loadstring(aaa);
				if bbb == nil then
					audioObj:set_active(true);
				else
					for k,v in pairs(bbb()) do
						if k == "musicOpen" then
							audioObj:set_active(v);
						end
					end
				end
			end
			file_handler:close()
		end
	end

	login_bg.ok();
end

--[[加载成功]]
function login_bg.ok()
	--[[判断本地的版本号，是否需要清理缓存文件]]
	--	Root.check_loacl_file();
	if login_bg.reload_call_back ~= nil then
		login_bg.reload_call_back();
		login_bg.reload_call_back = nil;
	end
end

--[[清理]]
function login_bg.clear()
	login_bg._asset_loader = nil;
	login_bg._asset_loader2 = nil;
end


function login_bg.Destroy()
	app.log("删除LOGO背景");
	if nil ~= login_bg.ui then
		login_bg.ui:set_active(false);
	end
	login_bg.ui = nil

	if nil ~= login_bg.ui2 then
		login_bg.ui2:set_active(false);
	end
	login_bg.ui2 = nil
end
