msg_client_log = msg_client_log or {}
--客户端到服务器
function msg_client_log.cg_record_auto_set_effect(info)
	--if not Socket.socketServer then return end
	nmsg_client_log.cg_record_auto_set_effect(Socket.socketServer, info);
end

function msg_client_log.cg_get_auto_set_effect(device_model)
	--if not Socket.socketServer then return end
	--TODO 拉取之前进行一次上传,修改统计不到型号的问题   修改登录流程后需要删掉
	-- g_dataCenter.autoQualitySet:UpdateProperty(false);
	-- nmsg_client_log.cg_get_auto_set_effect(Socket.socketServer, device_model);
end



--服务器到客户端
function msg_client_log.gc_get_auto_set_effect(device_model, effect_level)
	app.log("msg_client_log.gc_get_auto_set_effect effect_level="..table.tostring(effect_level))
	-- g_dataCenter.setting:SetRecvServerSetting(true);
	-- g_dataCenter.autoQualitySet:RecvServerAutoEffect(effect_level);
end