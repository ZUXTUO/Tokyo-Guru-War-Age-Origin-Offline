login = login or {}


function login.ca_gen_key()
	if not Socket.socketAccount then return end
	nlogin.ca_gen_key(Socket.socketAccount);
end
--客户端到账号服务器
function login.ca_connection(uid)
	if Socket.socketAccount then
		nlogin.ca_connection(Socket.socketAccount, uid);
	end
end
----注册用户名密码
--function login.ca_register_user(name, pwd)
--	if Socket.socketAccountIsconnected then
--		nlogin.ca_register_user(Socket.socketAccount, name, pwd);
--	else
--		LoginModule.ShowLoading(true);
--		timer.create("login.ConnectAccountFail", 3000, 1);
--		Socket.ConnectAccount();
--	end
--end
----用户名密码验证
--function login.ca_login(username, password, gameid, groupdid)
--	Socket.lastUserName = username;
--	Socket.lastPassword = password;
--
--	--Socket.lastUserName = UserCenter.get_openid();
--	--Socket.lastPassword = UserCenter.get_accessToken();
--
--	app.log("Socket.lastUserName="..tostring(Socket.lastUserName));
--	app.log("Socket.lastPassword="..tostring(Socket.lastPassword));
--
--	if Socket.socketAccountIsconnected then
--		nlogin.ca_login(Socket.socketAccount, Socket.lastUserName, Socket.lastPassword, gameid, groupdid, Target_Version);
--	else
--		LoginModule.ShowLoading(true);
--		timer.create("login.ConnectAccountFail", 3000, 1);
--		Socket.ConnectAccount();
--	end
--end

--function login.ConnectAccountFail()
--	LoginModule.ShowLoading(false);
--	if not Socket.socketAccountIsconnected then
--		-- 提示断开
--		HintUI.SetAndShow(EHintUiType.zero, "连接不上账号服务器，请重新登陆");
--	end
--end


----账号服务器到客户端
---- 获取到游戏id、群组id
--function login.ac_connection(isregister, gameid, groupdid)
--	LoginModule.ShowLoading(false);
--	Socket.isRegister = isregister;
--	Socket.gameID = gameid;
--	Socket.groupID = groupdid;
--	if Socket.socketAccount then
--		nlogin.ca_server_list(Socket.socketAccount, gameid, groupdid, Target_Version);
--	end
--	if Socket.lastUserName then
--		login.ca_login(Socket.lastUserName, Socket.lastPassword, gameid, groupdid);
--		Socket.lastUserName = nil;
--		Socket.lastPassword = nil;
--	end
--end
---- 登陆验证
--function login.ac_login(accountid, gameid, aid, state, token, ser)
--	-- 登陆成功
--	if state == 0 then
--		LoginFile.WriteRecommend(ser);
--		Socket.UpdateRecommentServer(ser);
--		Socket.accountID = accountid;
--		Socket.uuID = aid;
--		Socket.token = token;
--		LoginModule.Show(LoginModule.eEnterGame);
--		if Socket.lastUserName and Socket.lastPassword then
--			LoginFile.WriteUser(Socket.lastUserName, Socket.lastPassword);
--			--LoginFile.Save();
--			Socket.lastUserName = nil;
--			Socket.lastPassword = nil;
--		end
--	-- 登陆失败
--	else
--		LoginModule.OnError(LoginModule.eUserLogin, state)
--	end
--
--end
--function login.ac_server_list(serverList)
--	Socket.serverList = serverList;
--end
--
--function login.ac_register_user(state)
--	LoginModule.OnError(LoginModule.eRegister, state);
--end








--[[手机版连接帐号服进行帐号验证]]
function login.ca_verify_account_p(game_id, account_id, auth_token, device_uuid, user_platform_id, target_version)
	app.log("移动版登录");
	if not Socket.get_socketaccount() then return end
	nlogin.ca_verify_account_p(Socket.get_socketaccount(),game_id, account_id, auth_token, device_uuid, user_platform_id, target_version);
end

--[[PC版连接帐号服进行帐号验证]]
function login.ca_trusted_login_for_intranet(game_id, account_id, auth_token, device_uuid, user_platform_id, target_version)
	app.log("PC版登录");
	if not Socket.get_socketaccount() then return end
	nlogin.ca_trusted_login_for_intranet(Socket.get_socketaccount(),game_id, account_id, auth_token, device_uuid, user_platform_id, target_version);
end



--[[帐号服务器验证返回]]
function login.ac_verify_account_result_p(result)
	app.log("ac_verify_account_result_p="..result);
	if result ~= MsgEnum.error_code.error_code_success then
		timer.create("login.ac_verify_account_result_p_tips",1000,1);
	end
end
--[[失败回调提示]]
function login.ac_verify_account_result_p_tips()
	HintUI.SetAndShow(EHintUiType.two, "登录账号服务器失败！请确认重试！",
		{str = "是", func = UserCenter.login}, {str = "否", func = Root.quit});
end

--[[帐号服务器PUSH回服务器例表]]
function login.ac_server_list_p(new_token, account_server_id, info)
--	systems_data.set_relogin_token(new_token);
--	systems_data.set_account_server_id(account_server_id);
--	app.log("server list = "..#info);
--
--	app.log("@@>>>"..info[1].name);
--
--	systems_data.set_server_list(info);
--	if info[1] ~= nil then
----		Socket.SetSelectServer(info[1].serid);
--		Socket.UpdateRecommentServer(info[1]);
--		LoginFile.WriteRecommend(info[1]);
--	end
--	LoginModule.Show(LoginModule.eEnterGame,0);
end