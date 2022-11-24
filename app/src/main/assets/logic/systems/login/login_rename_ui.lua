LoginReNameUI = {};

local des =
{
	[1] = "您当前使用的账号还没有进行实名认证。根据国家相关法律法规规定，游戏账号需要进行实名认证。每日在线体验超过3小时后需要进行下线，并在接下来的24小时内无法继续体验游戏。您当前累积在线时间已达到3小时，我们建议您尽快进行实名认证，保证您的正常游戏~",
	[2] = "您当前使用的账号还没有进行实名认证。根据国家相关法律法规规定，未进行实名认证的账号暂时无法使用支付功能。我们建议您尽快进行实名认证，保证您的正常游戏~",
	[3] = "您当前使用的账号未进行实名认证，目前已经超过每日3小时限时体验时间，接下来的24小时内无法继续体验游戏。我们建议您尽快进行实名认证，保证您的正常游戏~",
	[4] = "我们建议您尽快进行实名认证，保证您的正常游戏~",
};

--data 1 登陆超时 2 支付限制 3 重登提示 4 无法充值
function LoginReNameUI.Show(data)
	
	-- 隐藏新手引导
    if GuideManager ~= nil then
        GuideManager.SetHideMode(true)
    end

    LoginReNameUI.Init(data);

end

function LoginReNameUI.Destroy()
	if LoginReNameUI.ui then
		LoginReNameUI.ui:set_active(false);
	end
	LoginReNameUI.ui = nil;
	LoginReNameUI.lab = nil;
	LoginReNameUI.isShow = false;
end

function LoginReNameUI.Init(data)
    LoginReNameUI.pathRes = "assetbundles/prefabs/ui/login/login_4.assetbundle";
    local _asset_loader = systems_func.loader_create("LoginReNameUI_loader")
	_asset_loader:set_callback("LoginReNameUI.load_callback")
	_asset_loader:load(LoginReNameUI.pathRes);
	LoginReNameUI.type = tonumber(data);
end

function LoginReNameUI.load_callback(pid, fpath, asset_obj, error_info)
	if fpath == LoginReNameUI.pathRes then
		LoginReNameUI.ui = systems_func.game_object_create(asset_obj);
		LoginReNameUI.ui:set_parent(Root.get_root_ui_2d());
		LoginReNameUI.ui:set_name("login_rename");
		LoginReNameUI.ui:set_local_rotation(0, 0, 0);
		LoginReNameUI.ui:set_local_scale(1, 1, 1);
	end
	LoginReNameUI.InitUI();
end

function LoginReNameUI.InitUI()
	LoginReNameUI.lab = ngui.find_label(LoginReNameUI.ui,"centre_other/animation/lab");
	local btnClose = systems_func.ngui_find_button(LoginReNameUI.ui,"centre_other/animation/btn1");
	local btnRename = systems_func.ngui_find_button(LoginReNameUI.ui,"centre_other/animation/btn2");
	btnClose:set_on_click("LoginReNameUI.onClose");
	btnRename:set_on_click("LoginReNameUI.onRename");
    LoginReNameUI.UpdateUi();
end

function LoginReNameUI.UpdateUi()
	LoginReNameUI.isShow = true
	if LoginReNameUI.lab then
		LoginReNameUI.lab:set_text(des[LoginReNameUI.type]);
	end
end

function LoginReNameUI.onClose()
	LoginReNameUI.Destroy();
	UserCenter.sdk_logout();
end

function LoginReNameUI.onRename()
--	app.log("LoginReNameUI.onRename");
	LoginReNameUI.Destroy();
	UiAnn.Start(UiAnn.Type.RealNameAuth,nil,LoginReNameUI.uiann_call_back);
end

function LoginReNameUI.uiann_call_back()
--	app.log("LoginReNameUI.uiann_call_back");
	UserCenter.check_realname(LoginReNameUI.check_name_bk);
end

function LoginReNameUI.check_name_bk()
--	app.log("LoginReNameUI.check_name_bk1");
	if UserCenter.get_web_realname() ~= 0  then
--		app.log("LoginReNameUI.check_name_bk2");
		LoginReNameUI.Show(1);
	else
--		app.log("LoginReNameUI.check_name_bk3");
		LoginReNameUI.Destroy();
		-- 恢复新手引导
	    if GuideManager ~= nil then
	        GuideManager.SetHideMode(false)
	    end
	end
end
