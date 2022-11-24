LoginLimitUI = {};

function LoginLimitUI.Show(updateHour)
	LoginLimitUI.Init(updateHour);
end

function LoginLimitUI.Destroy()
	LoginLimitUI.ui:set_active(false);
	LoginLimitUI.ui = nil;
	LoginLimitUI.lab = nil;
end

function LoginLimitUI.Init(data)
    LoginLimitUI.pathRes = "assetbundles/prefabs/ui/login/login_limit.assetbundle";
    local _asset_loader = systems_func.loader_create("LoginLimitUI_loader")
	_asset_loader:set_callback("LoginLimitUI.load_callback")
	_asset_loader:load(LoginLimitUI.pathRes);
	LoginLimitUI.time = data;
end

function LoginLimitUI.load_callback(pid, fpath, asset_obj, error_info)
	if fpath == LoginLimitUI.pathRes then
		LoginLimitUI.ui = systems_func.game_object_create(asset_obj);
		LoginLimitUI.ui:set_parent(Root.get_root_ui_2d());
		LoginLimitUI.ui:set_name("login_limit");
		LoginLimitUI.ui:set_local_rotation(0, 0, 0);
		LoginLimitUI.ui:set_local_scale(1, 1, 1);
	end
	LoginLimitUI.InitUI();
end

function LoginLimitUI.InitUI()
	LoginLimitUI.lab = ngui.find_label(LoginLimitUI.ui,"centre_other/animation/lab");
	local btnClose = systems_func.ngui_find_button(LoginLimitUI.ui,"centre_other/animation/btn");
	btnClose:set_on_click("LoginLimitUI.onClose");
    LoginLimitUI.UpdateUi();
end

function LoginLimitUI.UpdateUi()
	local time = LoginLimitUI.time or "10";
	-- local str = "今日捕猎区名额已满，欢迎各位“美食家”明日"..time..":00 再临!";
	local str = "“捕猎区”暴满，本次测试名额已达上限，感谢大家的支持和关注~！！";
	LoginLimitUI.lab:set_text(str);
end

function LoginLimitUI.onClose()	
	LoginLimitUI.Destroy();
end
