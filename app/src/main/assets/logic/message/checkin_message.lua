msg_checkin = msg_checkin or {}

g_isLocalCheckin = false;

msg_checkin.is_cg = false;

function msg_checkin.cg_get_checkin_info()
	if Socket.socketServer then
		if g_isLocalCheckin then
			gc_checkin_info.cg()
		else
			if AppConfig.script_recording then
				PublicFunc.RecordingScript("nmsg_checkin.cg_get_checkin_info(robot_s)")
			end
			nmsg_checkin.cg_get_checkin_info(Socket.socketServer);
		end
	end
end

function msg_checkin.gc_checkin_info(check_seven,check_month)
	if nil == check_seven or nil == check_month then return; end;
	g_checkin.SetData(check_seven,check_month);
    --更新ui
    PublicFunc.msg_dispatch(msg_checkin.gc_checkin_info);
end

function msg_checkin.cg_checkin(signType)
	if Socket.socketServer then
		if g_isLocalCheckin then
			gc_checkin_ret.cg(signType)
		else
			nmsg_checkin.cg_checkin(Socket.socketServer,signType);
		end
	end
end

function msg_checkin.gc_checkin_ret(check_type, ret, info, awards)
	if(nil == info) then return; end;

	--1代表7日签到 2代表月签到
	if check_type == CheckinEnum.CHECKIN_TYPE.SEVEN_CHECKIN then
		if ret == CheckinEnum.SEVEN_STATE.SUCCESS then
			g_checkin.SetData(info,nil);
			CommonAward.Start(awards, 1);
            --更新ui
            PublicFunc.msg_dispatch(msg_checkin.gc_checkin_ret);
		elseif ret == CheckinEnum.SEVEN_STATE.DATA_UNLOAD then
			HintUI.SetAndShow(EHintUiType.zero, "数据未加载,签到失败");
		elseif ret == CheckinEnum.SEVEN_STATE.TODAT_CHECKED then
			HintUI.SetAndShow(EHintUiType.zero, "今天已经签到");
		elseif ret == CheckinEnum.SEVEN_STATE.UNKNOW1 then
			HintUI.SetAndShow(EHintUiType.zero, "未知错误1,签到失败");
		elseif ret == CheckinEnum.SEVEN_STATE.UNKNOW2 then
			HintUI.SetAndShow(EHintUiType.zero, "未知错误2,签到失败");
		end
	elseif check_type == CheckinEnum.CHECKIN_TYPE.MONTH_CHECKIN then
		if ret == CheckinEnum.SEVEN_STATE.SUCCESS then
			g_checkin.SetData(nil,info);
            --if uiManager:GetCurScene().currentPage then
			    CommonAward.Start(awards, 1);
                --更新ui
                PublicFunc.msg_dispatch(msg_checkin.gc_checkin_ret);
            --end
		elseif ret == CheckinEnum.SEVEN_STATE.DATA_UNLOAD then
			HintUI.SetAndShow(EHintUiType.zero, "数据未加载,签到失败");	
		elseif ret == CheckinEnum.SEVEN_STATE.TODAT_CHECKED then
			HintUI.SetAndShow(EHintUiType.zero, "今天已经签到");	
		elseif ret == CheckinEnum.SEVEN_STATE.UNKNOW1 then
			HintUI.SetAndShow(EHintUiType.zero, "未知错误1,签到失败");	
		elseif ret == CheckinEnum.SEVEN_STATE.UNKNOW2 then
			HintUI.SetAndShow(EHintUiType.zero, "未知错误2,签到失败");	
		end
	end
end

function msg_checkin.cg_get_month_sign_state( )
	if Socket.socketServer then
		if AppConfig.script_recording then
			PublicFunc.RecordingScript("nmsg_checkin.cg_get_month_sign_state(robot_s)")
		end
		nmsg_checkin.cg_get_month_sign_state(Socket.socketServer);
	end
end

function msg_checkin.cg_sign_in_c_day( day, vipState )
	if Socket.socketServer and msg_checkin.is_cg == false then
		msg_checkin.is_cg = true;
		if AppConfig.script_recording then
			PublicFunc.RecordingScript("nmsg_checkin.cg_sign_in_c_day(robot_s, "..tostring(day)..", "..tostring(vipState)..")")
		end
		nmsg_checkin.cg_sign_in_c_day(Socket.socketServer, day, vipState);
	end
end

function msg_checkin.cg_get_total( num )
	if Socket.socketServer and msg_checkin.is_cg == false then
		msg_checkin.is_cg = true;
		nmsg_checkin.cg_get_total(Socket.socketServer, num);
	end
end

function msg_checkin.gc_month_sign_state(state, t_type, day, states )
	msg_checkin.is_cg = false;
	g_dataCenter.signin:SetTotal(state, t_type, day, states);
	PublicFunc.msg_dispatch(msg_checkin.gc_month_sign_state, state, t_type, day, states);
end

return msg_checkin;