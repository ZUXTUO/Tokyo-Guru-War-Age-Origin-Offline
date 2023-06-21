--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2017/3/21
-- Time: 10:31
-- To change this template use File | Settings | File Templates.
-- 客户端到代理

client_proxy = {};

--[[
struct cp_enter_game_info
{
	int account_server_id;
	string channel_id;
	string account_id;
	string token;
	int game_id;
	int server_id;
	uint version;
	int language;
	string package_id;
	string device_id;
	int access_token_debug;
};
-]]

function client_proxy.cp_enter_game(cp_enter_game_info)
	Socket.get_socketgame()
	--if not Socket.get_socketgame() then return end;
	--if cp_enter_game_info == nil then return end;
	nclient_proxy.cp_enter_game(Socket.get_socketgame(),cp_enter_game_info);
end

function client_proxy.cp_enter_game_no_auth(cp_enter_game_info)
	--if not Socket.get_socketgame() then return end;
	--if cp_enter_game_info == nil then return end;
	nclient_proxy.cp_enter_game_no_auth(Socket.get_socketgame(),cp_enter_game_info);
end

function client_proxy.pc_enter_game(code)
	app.log("client_proxy.pc_enter_game = "..code);

	if tonumber(code) ~= 0 then
		PublicFunc.GetErrorString(result)
		Socket.ShowDialog()
		return
	end

	client_proxy.enter_game_play()
end

function client_proxy.cp_re_enter_game(cp_enter_game_info)
	if not Socket.get_socketgame() then return end;
	if cp_enter_game_info == nil then return end;
	nclient_proxy.cp_re_enter_game(Socket.get_socketgame(),cp_enter_game_info)
end

function client_proxy.pc_re_enter_game(code)
	
	if code == 0 then
        app.log("re_enter_game======success=======")
    else
    	app.log("re_enter_game======fail============")
    	Socket.StopPingPong();
        Socket.socketServer = nil;
        local str = "重连失败，请重新登录.";
        HintUI.SetAndShow(EHintUiType.one, str, {str = "重新进入", func = UserCenter.sdk_logout}, nil, nil, nil, true);
        GLoading.Hide()
    end
end

function client_proxy.enter_game_play()
	app.log(" system.enter_game_play")
	g_dataCenter.player:SetIsWaitingPlayerData(true)

    local key = true;
    if key then--[[主城]]

        AudioManager.Stop(nil, true);
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.Start); -- 片头视频已有，这里去掉

        if not LocalFile.ReadUpdateAccountState() then
			FightScene.SetHideLoading(true)
		end
        SceneManager.ReplaceByMainCityScene()
    else
        -- 
    end
end

function client_proxy.pc_auth_replaced()
	local str = "帐号在其它设备登录, 你将被迫下线.";
    Socket.soketstate = "replaced"
    HintUI.SetAndShow(EHintUiType.one, str, {str = "重新进入", func = UserCenter.sdk_logout}, nil, nil, nil, true);
    Socket.GameServer_close()
    GLoading.Hide()
end

function client_proxy.pc_game_server_state(state)
	local str = "与服务器断开连接，你被迫下线！"
	if state == 1 then
		Socket.soketstate = "replaced"
	    HintUI.SetAndShow(EHintUiType.one, str, {str = "重新进入", func = UserCenter.sdk_logout}, nil, nil, nil, true);
	    Socket.GameServer_close()
	    GLoading.Hide()
	end
end



