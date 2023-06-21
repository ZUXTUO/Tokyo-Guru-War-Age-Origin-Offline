
msg_weaknet_white = msg_weaknet_white or {}

function msg_weaknet_white.cg_ping()
	--if not Socket.socketServer then return end
	if AppConfig.script_recording then
		PublicFunc.RecordingScript("nmsg_weaknet_white.cg_ping(robot_s)")
	end
	nmsg_weaknet_white.cg_ping(Socket.socketServer)
end

function msg_weaknet_white.cg_receive_server_msg(seq_num)
    nmsg_weaknet_white.cg_receive_server_msg(Socket.get_socketgame(),seq_num)
end

function msg_weaknet_white.cg_re_enter_game(info)
    --app.log("cg_re_enter_game============")
    nmsg_weaknet_white.cg_re_enter_game(Socket.get_socketgame(),info)
end

function msg_weaknet_white.gc_pong(time)
    if PublicFunc.check_type_number(time) then
        system.time_d = os.time() - time
        Socket.ping_pong_ref = 0
        
        --关闭菊花
        --netmgr.HidePingUITime()
    end
end

function msg_weaknet_white.gc_receive_client_msg(seq_num)
    --app.log("接收0号协议的Ext_data"..tostring(seq_num))
    netmgr.receive(seq_num) 
end

function msg_weaknet_white.gc_send_cache_msg_end()
    app.log("=======gc_send_cache_msg_end============") 
    --local show = PublicFunc.GetErrorString(result);
    --app.log("gc_send_cache_msg_end============")
    --if show then
    Socket.reconnectUniversalSuccess()
    --end
end

function msg_weaknet_white.gc_re_enter_game(result)
    --local show = PublicFunc.GetErrorString(result);
    --app.log("gc_re_enter_game============"..tostring(result))
    if result == 0 then
        --app.log("gc_re_enter_game=====OKOKOKOKOKOK=======")
    else
        Socket.ShowDialog() 
    end
end

function msg_weaknet_white.gc_displacement(msgstr)
    local str = ConfigManager.Get(EConfigIndex.t_error_code_cn,MsgEnum.error_code.error_code_player_displacement)
    if not str then
		str = "帐号在其他调备登录 ";
    end

	HintUI.SetAndShow(EHintUiType.one, str.tip, {str = "重新进入", func = GameBegin.usercenter_logout_callback}, nil, nil, nil, true);
end