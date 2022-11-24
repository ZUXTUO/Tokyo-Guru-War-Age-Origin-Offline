msg_sign_in = msg_signin or {}
msg_sign_in.is_req = false;
msg_sign_in.is_req_total = false;

msg_sign_in.is_req_back = false;
msg_sign_in.is_req_total_back = false;

function msg_sign_in.cg_request_task_list( type1, type2 )
	--if not Socket.socketServer then return end

	if not msg_sign_in.is_req then
		msg_sign_in.is_req = true;
		-- app.log(":==========");
		if AppConfig.script_recording then
			PublicFunc.RecordingScript("nmsg_sign_in.cg_request_task_list(robot_s, "..tostring(type1)..", "..tostring(type2)..")")
		end
	    nmsg_sign_in.cg_request_task_list(Socket.socketServer, type1, type2);
	end
end

function msg_sign_in.gc_task_list( startTime, endTime, type1, type2, taskList )
	msg_sign_in.is_req = false;
	-- app.log("=========:");
	g_dataCenter.signin:SetTime(startTime, endTime);
	g_dataCenter.signin:SetVecDataByType1Type2(type1, type2, taskList);

	g_dataCenter.signin:SetRedPointStatesByDataList(type1, type2, taskList);
	PublicFunc.msg_dispatch(msg_sign_in.gc_task_list, startTime, endTime, type1, type2, taskList);
end

function msg_sign_in.cg_get_award( task_id )
	--if not Socket.socketServer then return end

	if not msg_sign_in.is_req then
		msg_sign_in.is_req = true;
		-- app.log(":==========");
		if AppConfig.script_recording then
			PublicFunc.RecordingScript("nmsg_sign_in.cg_get_award(robot_s, "..tostring(task_id)..")")
		end
	    nmsg_sign_in.cg_get_award(Socket.socketServer, task_id);
	end
end

function msg_sign_in.gc_get_award( result, task_id )
	msg_sign_in.is_req = false;
	if result == 0 then
		PublicFunc.msg_dispatch(msg_sign_in.gc_get_award, task_id);
	end
end

function msg_sign_in.cg_request_total_state( )
	if not msg_sign_in.is_req_total then
		msg_sign_in.is_req_total = true;
		if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_sign_in.cg_request_total_state(robot_s)")
        end
	    nmsg_sign_in.cg_request_total_state(Socket.socketServer);
	end
end

function msg_sign_in.gc_total_state( is_get_total, c_score, timeLeft )
	msg_sign_in.is_req_total = false;
	g_dataCenter.signin:SetTotal(is_get_total, c_score, timeLeft);
	PublicFunc.msg_dispatch(msg_sign_in.gc_total_state, is_get_total, c_score, timeLeft);
end

function msg_sign_in.cg_get_award_total( t_index, c_score )
	if not msg_sign_in.is_req then
		msg_sign_in.is_req = true;
	    nmsg_sign_in.cg_get_award_total(Socket.socketServer, t_index, c_score);
	end
end

function msg_sign_in.gc_get_award_total( result, t_index )
	msg_sign_in.is_req = false;
	if result == 0 then
		PublicFunc.msg_dispatch(msg_sign_in.gc_get_award_total, t_index);
	end
end

function msg_sign_in.gc_set_point( p_type, state )
--	app.log("------------- p_type -1-: " .. p_type .. "--- state: " .. state);
	if state == 1 then
		if p_type == 1 then
			g_dataCenter.signin:SetRedPoint(true);
		elseif p_type == 2 then
			g_dataCenter.signin:SetIsOpen(true);
		end
	elseif state == 0 then
		if p_type == 2 then
			g_dataCenter.signin:SetIsOpen(false);
		end
	end
end

function msg_sign_in.gc_set_point_states( vecRedPointStates )
--	app.log("------------ vecRedPointStates:" .. table.tostring(vecRedPointStates));
	g_dataCenter.signin:SetRedPointStates(vecRedPointStates);
	PublicFunc.msg_dispatch(msg_sign_in.gc_set_point_states);
end

------------------------------ 节日七天乐 ---------------------------
function msg_sign_in.cg_request_task_list_back( type1, type2 )
	--if not Socket.socketServer then return end

	app.log("cg_request_task_list_back:" .. tostring(msg_sign_in.is_req_back))
	if not msg_sign_in.is_req_back then
		msg_sign_in.is_req_back = true;
		-- app.log(":==========");
		if AppConfig.script_recording then
			PublicFunc.RecordingScript("nmsg_sign_in.cg_request_task_list_back(robot_s, "..tostring(type1)..", "..tostring(type2)..")")
		end
	    nmsg_sign_in.cg_request_task_list_back(Socket.socketServer, type1, type2);
	end
end

function msg_sign_in.gc_task_list_back( startTime, endTime, type1, type2, taskList )
	msg_sign_in.is_req_back = false;
	app.log("=========:gc_task_list_back");
	g_dataCenter.signin:SetRedPointStatesByDataList_back(type1, type2, taskList);
	PublicFunc.msg_dispatch(msg_sign_in.gc_task_list_back, startTime, endTime, type1, type2, taskList);
end

function msg_sign_in.cg_get_award_back( task_id )
	--if not Socket.socketServer then return end

	if not msg_sign_in.is_req_back then
		msg_sign_in.is_req_back = true;
		-- app.log(":==========");
		if AppConfig.script_recording then
			PublicFunc.RecordingScript("nmsg_sign_in.cg_get_award_back(robot_s, "..tostring(task_id)..")")
		end
	    nmsg_sign_in.cg_get_award_back(Socket.socketServer, task_id);
	end
end

function msg_sign_in.gc_get_award_back( result, task_id )
	msg_sign_in.is_req_back = false;
	if result == 0 then
		PublicFunc.msg_dispatch(msg_sign_in.gc_get_award_back, task_id);
	end
end

function msg_sign_in.cg_request_total_state_back( )
	if not msg_sign_in.is_req_total_back then
		msg_sign_in.is_req_total_back = true;
		if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_sign_in.cg_request_total_state_back(robot_s)")
        end
	    nmsg_sign_in.cg_request_total_state_back(Socket.socketServer);
	end
end

function msg_sign_in.gc_total_state_back( is_get_total, c_score, timeLeft )
	msg_sign_in.is_req_total_back = false;
	PublicFunc.msg_dispatch(msg_sign_in.gc_total_state_back, is_get_total, c_score, timeLeft);
end

function msg_sign_in.cg_get_award_total_back( t_index, c_score )
	if not msg_sign_in.is_req_back then
		msg_sign_in.is_req_back = true;
	    nmsg_sign_in.cg_get_award_total_back(Socket.socketServer, t_index, c_score);
	end
end

function msg_sign_in.gc_get_award_total_back( result, t_index )
	msg_sign_in.is_req = false;
	if result == 0 then
		PublicFunc.msg_dispatch(msg_sign_in.gc_get_award_total_back, t_index);
	end
end

function msg_sign_in.gc_set_point_back( p_type, state )
--	app.log("------------- p_type -2 -: " .. p_type .. "--- state: " .. state);
	if state == 1 then
		if p_type == 1 then
			g_dataCenter.signin:SetRedPoint_back(true);
		elseif p_type == 2 then
			g_dataCenter.signin:SetIsOpen_back(true);
		end
	elseif state == 0 then
		if p_type == 2 then
			g_dataCenter.signin:SetIsOpen_back(false);
		end
	end
end

function msg_sign_in.gc_set_point_states_back( vecRedPointStates )
--	app.log("------------ vecRedPointStates:" .. table.tostring(vecRedPointStates));
	g_dataCenter.signin:SetRedPointStates_back(vecRedPointStates);
	PublicFunc.msg_dispatch(msg_sign_in.gc_set_point_states_back);
end