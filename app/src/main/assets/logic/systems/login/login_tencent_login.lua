--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2016/5/18
-- Time: 17:52
-- To change this template use File | Settings | File Templates.
--

LoginTencentLogin = {
	is_check = false;--[[只能点击一次]]
	pathRes = "assetbundles/prefabs/ui/login/login_qq.assetbundle",
	file_name = "loginfilet";--[[本地文件]]
	file_txt = "",
	call_back = nil;
};

function LoginTencentLogin.LoadAsset(call_back)
	LoginTencentLogin.call_back = call_back;

	local temp_txt = LoginTencentLogin.red_txt();
	if temp_txt ~= nil and temp_txt ~= "" then
		--[[已经登陆过 就写checkLogin让SDK去自动登陆]]
		UserCenter.set_login_str("checkLogin");

		if LoginTencentLogin.call_back ~= nil then
			LoginTencentLogin.call_back();
		end

		do return end;
	end

	LoginTencentLogin._asset_loader = systems_func.loader_create("LoginTencentLogin_loader")
	LoginTencentLogin._asset_loader:set_callback("LoginTencentLogin.on_load")
	LoginTencentLogin._asset_loader:load(LoginTencentLogin.pathRes);
	LoginTencentLogin._asset_loader = nil;
end

function LoginTencentLogin.on_load(pid, filepath, asset_obj, error_info)
	if filepath == LoginTencentLogin.pathRes then
		LoginTencentLogin.InitUI(asset_obj);
	end

	--[[读取文件]]
	LoginTencentLogin.red_txt();
end

function LoginTencentLogin.InitUI(asset_obj)
	LoginTencentLogin.ui = asset_game_object.create(asset_obj);
	LoginTencentLogin.ui:set_name("LoginTencentLogin");
	LoginTencentLogin.ui:set_parent(Root.get_root_ui_2d());
	LoginTencentLogin.ui:set_local_position(0,0,0);
	LoginTencentLogin.ui:set_local_scale(1,1,1);

	LoginTencentLogin._btnqq = ngui.find_button(LoginTencentLogin.ui, "btn_qq");
	LoginTencentLogin._btnqq:set_on_click("LoginTencentLogin.on_btn_qq");

	LoginTencentLogin._btnwx = ngui.find_button(LoginTencentLogin.ui, "btn_weixin");
	LoginTencentLogin._btnwx:set_on_click("LoginTencentLogin.on_btn_wx");
	
	LoginTencentLogin.Show(true)
end

function LoginTencentLogin.on_btn_qq()
	if not LoginTencentLogin.is_check then
		LoginTencentLogin.is_check = true;
		LoginTencentLogin.set_txt("qq");--[[用本地记录TYPE登陆]]
		timer.create("LoginTencentLogin.timer_rcheck",3000,1);

		if LoginTencentLogin.call_back ~= nil then
			LoginTencentLogin.call_back();
		end
	end
end
function LoginTencentLogin.on_btn_wx()
	if not LoginTencentLogin.is_check then
		LoginTencentLogin.is_check = true;
		LoginTencentLogin.set_txt("wx");--[[用本地记录TYPE登陆]]
		timer.create("LoginTencentLogin.timer_rcheck",3000,1);

		if LoginTencentLogin.call_back ~= nil then
			LoginTencentLogin.call_back();
		end
	end
end

function LoginTencentLogin.timer_rcheck()
	LoginTencentLogin.is_check = false;
end

function LoginTencentLogin.set_is_check(is_bool)
	if is_bool == nil then return end;
	LoginTencentLogin.is_check = is_bool;
end

function LoginTencentLogin.Show(b)
	if LoginTencentLogin.ui then
		LoginTencentLogin.ui:set_active(b);
	else
		LoginTencentLogin.LoadAsset()
	end
end

function LoginTencentLogin.close()
	if LoginTencentLogin.ui then
		LoginTencentLogin.ui:set_active(false);
		LoginTencentLogin.ui = nil;
	end
end

--[[得到本地写入TYPE]]
function LoginTencentLogin.get_local_txt()
	return LoginTencentLogin.red_txt();
end

--[[读取文件]]
function LoginTencentLogin.red_txt()
	if file.exist(LoginTencentLogin.file_name) == true then
		local fileHandle = file.open_read(LoginTencentLogin.file_name);
		LoginTencentLogin.file_txt = fileHandle:read_line();
		fileHandle:close();
	end
	return LoginTencentLogin.file_txt;
end

--[[写入]]
function LoginTencentLogin.set_txt(str_type)
	if str_type == nil then return end;
	LoginTencentLogin.file_txt = tostring(str_type);
	LoginTencentLogin.Save();
	UserCenter.set_login_str(str_type);--[[用本地记录TYPE登陆]]
end

--[[保存文件]]
function LoginTencentLogin.Save()
	--	app.log("保存文件="..table.tostring(LoginTencentLogin.file_txt));
	local fileHandle = file.open(LoginTencentLogin.file_name, 2);
	fileHandle:write_string(LoginTencentLogin.file_txt);
	fileHandle:close();
	UserCenter.set_login_str(LoginTencentLogin.file_txt);
end
