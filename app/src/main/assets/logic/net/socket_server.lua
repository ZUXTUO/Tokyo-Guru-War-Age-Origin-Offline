--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/12/19
-- Time: 15:13
-- To change this template use File | Settings | File Templates.
--

-- 用于protol tool工具
net = 
{
	p_client_ = nil
}

--[[帐号登录 与 GAME登录 主文件]]

Socket = 
{
--	--[[帐号服连接]]
--	is_socketaccount = false;--[[是否连接过帐号服，备用]]
--	socketAccount = nil,

	--[[GAME服连接]]
	is_soucketserver = true;--[[是否连接过GAME服，判断重连]]
	socketServer = nil,--[[GAME连接]]
	socketServer_obj = nil;--[[GAME返回的连接]]

	initFlag = false,
	connect_game_ip = 0;--[[登陆GAME IP]]
	connect_game_port = 0;--[[登陆GAME PORT]]

    ping_pong_timer = nil,--[[客户端计时器]]
    ping_pong_ref = 0,--[[客户端心跳次数]]

    realSendFunc = nil,

    onSendListeners = {},
    onRecvListeners = {},

    idCode = 0;
    dispatchFilter = nil,
    onBeforeSendCallBack = nil,
    processTimeId = nil,
    erroeNumb = 0;   --重连次数
    socketerrorNumb = 0;
    isAlone = false;       --相同协议能否重复发送 false为可以进入队列 true 不进入队列
    IsShowDialog = false;  --正在显示对话重连对话框
    lastSocketIdList = {}; -- 历史socketid
    IsSilence = true;     --静默模式 false 为关闭 true 打开 
    AutoSilenceDialog = false; --关卡中是否已连接3次
    IsOpen = true; --弱网开关

    sendtime = nil;

--    isopenweak = true;  --[[一个不晓得啥子作的动西 ]]

    --soket连接状态   --1.close 2.connect 3.replaced
    soketstate = "2";

    lastSendTime = 0;

    Pvp3v3 = false;

    isLogin = false; --是否在登录过程中

	guide_care_msg_id = {};
	silence_msg_id = {};
}

function Socket.Send(client, msg_id, ...)
	app.log("send message:" ..msg_id)

	if nil ~= Socket.onBeforeSendCallBack then
		Socket.onBeforeSendCallBack(client, msg_id, ...);
	end

	Socket.realSendFunc(client, msg_id, ...)
end

function Socket_set_isAlone(value)
		
	if value then
		Socket.isAlone = value	
	end	
end

function Socket.Set_isSilence(value)
	if value then
		Socket.IsSilence = value
	end
end

function Socket.seedmsg_local( client, msg_id, ...)

	if Socket.IsOpen then

		local MsgState = netmgr.getSendMsgState()
		
		if MsgState then
			--local idCode = Socket.genIdCode()
			--gnet.set_next_ext_data(Socket.socketServer,idCode)
			--重发不废黜ext_data
		else
			local idCode = Socket.genIdCode()
			if msg_id ~= 1402 and msg_id ~= 1403 then
				app.log("发送msg_id.........."..tostring(msg_id))
			end
			gnet.set_next_ext_data(Socket.socketServer,idCode)	
			
			if not netmgr.IsBlacklist(msg_id) then
			--if netmgr.IsBlacklist(msg_id) then
				local cg = netmgr.cg:new(msg_id,{...},idCode);
				cg:setAlone(Socket.isAlone)
				--重置状态
				Socket.isAlone = false;
				netmgr.send(cg,idCode,msg_id)
				app.log("发送msg_id.........."..tostring(msg_id))
				app.log("发送ext_data.........."..tostring(idCode))	
			end
		end

	end
	--app.log("idCode.........."..tostring(idCode))
end

function Socket_DispatchMsg(client_id, msg_id, ext_data, seq_num, lua_func, ...)
	
	if Socket.IsOpen then
		--app.log("Socket.receive:" .. lua_func);
		--if msg_id == 1406 then
			--app.log("1406====================")
			--app.log("接收 msg_id:"..tostring(msg_id))
			--app.log("接收 ext_data:"..tostring(ext_data))
		--end
		 
		--if ext_data > 0 and msg_id > 0 then
		if msg_id <= 3000 then  -- TODO:chengjia　特殊协议不需要回？？？？
			
		else
			--app.log("cg_receive_server_msg..."..tostring(ext_data))
			msg_weaknet_white.cg_receive_server_msg(ext_data)
		end

		--处理客户端收到重复消息 （刷新界面）
		if msg_id ~= 1402 and ext_data ~= 0 and netmgr.isCanNotifyQueues(msg_id,ext_data) then
			--已经接收过了，不再通知客户端处理		
			app.log("重复消息不处理！msgid..."..tostring(msg_id).." ext_data...."..tostring(ext_data))
			do return end
		end
		
		if msg_id ~= 1402 and ext_data ~= 0  then
			netmgr.registercg(msg_id,ext_data)
		end
	end
	

	--TODO: chengjia 上面的逻辑放入 dispatchFilter
	if nil ~= dispatchFilter and not dispatchFilter(client_id, msg_id, ext_data, seq_num) then
		return;	
	end

	local s_pos = string.find(lua_func, '.', 1, 0)
	if nil ~= s_pos then
		local t = string.sub(lua_func, 1, s_pos-1)
		local f = string.sub(lua_func, s_pos+1, string.len(lua_func))
		t = _G[t]
		if nil ~= t then
			f = t[f]
			if nil ~= f then
				--app.log("xxx parm:" .. table.tostring({...}))
				f(...)
			end
		end
	else
		f = _G[lua_func]
		if nil ~= f then
			f(...)
		end
	end
end

function Socket.genIdCode()
	Socket.idCode = Socket.idCode + 1
	return Socket.idCode
end

function Socket.SetDispatchFilter(filter)
	dispatchFilter = filter;
end


function Socket.AddOnSendListeners(id, on_send)
	Socket.onSendListeners[id] = on_send;
end

function Socket.RemoveOnSendListeners(id)
	if nil == nil then
		Socket.onSendListeners = nil
		return
	end
	Socket.onSendListeners[id] = nil;
end

function Socket.AddOnRecvListeners(id, on_send)
	Socket.onRecvListeners[id] = on_send;
end

function Socket.RemoveOnRecvListeners(id)
	if nil == nil then
		Socket.onRecvListeners = nil
		return
	end
	Socket.onRecvListeners[id] = nil;
end


function Socket_OnRecv(id, ext_data, seq_num)
	for k, v in pairs(Socket.onRecvListeners) do
		v(id, ext_data, seq_num);
	end
end

function Socket_OnSend(id, ext_data, seq_num)
	for k, v in pairs(Socket.onSendListeners) do
		v(id, ext_data, seq_num);
	end
end

--[[游戏服连接]]
function Socket.get_socketgame()
	--return Socket.socketServer;
	return true;
end

function Socket.LoadProtocolFile()
	--[[加载协议]]
	gnet.load_des("logic/net/des/netdes.snd");
end

-- 测试出引导关心的消息id
function Socket.TestGuideCareMsg()
	local guide_care_msg_list = {
		nmsg_cards.cg_hero_rarity_up,		--角色升品（觉醒）
		nmsg_cards.cg_soul_exchange_hero,	--角色合成
		nmsg_cards.cg_hero_star_up,			--角色升星
		nmsg_cards.cg_skill_level_up,		--角色技能升级

		nmsg_cards.cg_equip_star_up,		--装备进化
		nmsg_cards.cg_equip_level_up,		--装备一键升级
		nmsg_cards.cg_equip_rarity_up,		--装备升品

		nmsg_team.cg_update_team_info,		--更新队伍
		nmsg_dailytask.cg_line_finish_task,	--领取主线任务奖励

		nmsg_hurdle.cg_take_award,			--领取章节宝箱
		nmsg_hurdle.cg_hurlde_box,			--领取关卡宝箱
		nmsg_hurdle.cg_hurdle_fight,		--进关卡战斗
		-- nmsg_cards.cg_eat_exp,				--角色吃药升级

		nmsg_dailytask.cg_finish_task,		--完成每日任务

		nmsg_activity.cg_churchpray_unlock,	--区域占领点击开启
		nmsg_activity.cg_look_for_rival,	--区域占领点击探索
		nmsg_activity.cg_niudan_use,		--扭蛋
		nmsg_activity.cg_enter_activity,		--进入活动玩法
		nmsg_activity.cg_arena_get_climb_reward,	--竞技场爬梯奖领取
		nmsg_activity.cg_kuikuliya_get_climb_reward,--极限挑战爬梯奖领取

		nmsg_expedition_trial.cg_get_expedition_trial_points_reward,	--远征奖励领取

		nmsg_shop.cg_buy_shop_item,			--购买道具

		nmsg_talent.cg_talent_upgrade,		--天赋升级
		nmsg_laboratory.cg_unLock_laboratory,--研究所培养
	}

	local msg_silence_list = {
		nplayer.cg_guide_id,				--记录引导关键点

		--nsystem.cg_cheater_check,			--上报作弊检查
		--nsystem.cg_add_guide_log,			--记录引导步骤
		--nsystem.cg_add_custom_log,		--记录公司日志

		nmsg_hurdle.cg_attribute_verify_start,
		nmsg_hurdle.cg_attribute_verify_create_hero,
		nmsg_hurdle.cg_attribute_verify_upload,
		nmsg_hurdle.cg_attribute_verify_change_info,
		nmsg_hurdle.cg_attribute_verify_over,
	}

	local old_gnet_send_func = gnet.send
	-- 替换gnet接口，测试引导关心的msg_id
	--gnet.send = function(c, msg_id)
		--Socket.guide_care_msg_id[msg_id] = true
	--end

	--for i, f in pairs(guide_care_msg_list) do
	--	if f == nil then f = 0 end
	--	if f then f() end
	--end

	-- 测试静默msg_id
	--gnet.send = function(c, msg_id)
		--Socket.silence_msg_id[msg_id] = true
	--end

	--for i, f in pairs(msg_silence_list) do
	--	if f == nil then f = 0 end
	--	if f then f() end
	--end

	-- 测试完成，还原gnet接口
	--gnet.send = old_gnet_send_func
end

--[[网络协议初始化]]
function Socket.Init()
	app.log("Socket.Init");

	Socket.isopenweak = true;
	--if not Socket.initFlag then
		Socket.initFlag = true;

		Socket.TestGuideCareMsg()

		--Socket.realSendFunc = gnet.send
		--gnet.send = Socket.Send;
		Socket.onBeforeSendCallBack = Socket.seedmsg_local;

		--gnet.set_on_send("Socket_OnSend");
		--gnet.set_on_receive("Socket_OnRecv");

		Socket.LoadProtocolFile();
	--end

	--[[直接直入游戏服]]
	--local enter_proxy_info = ServerListData.get_enter_server_proxy()
	--if enter_proxy_info ~= nil then
	--	Socket.ConnectGameServer(enter_proxy_info.ip ,enter_proxy_info.port);
		Socket.ConnectGameServer();
	--end
	
	--恢复新手引导显示
	--if GuideManager then
	 	GuideManager.SetHideMode(true)
	--end

end

--[[重置]]
function Socket.Uinit()
	Socket.soketstate = "";
	Socket.Pvp3v3 = false;
	Socket.isLogin = false;
	Socket.IsSilence = false;
	Socket.m_is_reconnecting = false;
	Socket.IsShowDialog = false;
	g_net_is_disconnect = false;
	--Socket.erroeNumb =0;		--重置断线重连次数
	--Socket.AutoSilenceDialog = false;  --关卡中是否已自动连接3次  true 是  false 否
end

-----------------------------------------------------------------------帐号登录 str--------------------------------------------------------------------------

----[[帐号登录]]
--function Socket.ConnectAccount()
--
--	--[[关闭帐号服连接]]
--	Socket.Account_close();
--	--[[网络初始化]]
--	gnet.set_listener("Socket.OnAccountConnect", "Socket.OnAccountClose", "Socket.OnAccountError");
--	Socket.socketAccount = gnet.create();
--	Socket.socketAccount:asyc_connection(AppConfig.get_account_ip(), AppConfig.get_account_port());
--	app.log('登录帐号服 ip:'..tostring(AppConfig.get_account_ip())..' port:'..tostring(AppConfig.get_account_port()))
--end
----[[关闭帐号服连接]]
--function Socket.Account_close()
--	if Socket.socketAccount ~= nil then
--        Socket.socketAccount:close();
--    end
--	Socket.socketAccount = nil;
--end
--
--function Socket.OnAccountConnect(object)
--
--	--[[验证连接]]
--	if Socket.socketAccount == nil and Socket.socketAccount:get_socket_id() ~= object:get_socket_id() then
--		HintUI.SetAndShow(EHintUiType.two, "帐号连接验证失败，请重试！",
--			{str = "是", func = GameBegin.usercenter_logout_callback},{str = "否", func = Root.quit}
--		);
--		return;
--	end
--
--	Socket.is_socketaccount = true;
--
--	--[[PC与手机分开处理，因为PC得不到ID]]
--	if Root.get_os_type() == PublicStruct.App_OS_Type.Android or Root.get_os_type() == PublicStruct.App_OS_Type.IPhonePlayer then
--		app.log("移动版帐号验证");
--		--[[向服务器发送和户端信息，进行验证]]
--		login.ca_verify_account_p(
--			AppConfig.get_game_id(),
--			UserCenter.get_openid(),
--			UserCenter.get_accessToken(),
--			AppConfig.get_device_id(),
--			AppConfig.get_platformchannel_id(),
--			AppConfig.get_gameserver_tarver()
--			);
--	else
--		app.log("PC版帐号验证");
--		--[[向服务器发送和户端信息，进行验证]]
--		login.ca_trusted_login_for_intranet(
--			AppConfig.get_game_id(),
--			AppConfig.get_deviceuniqueidentifier(),
--			AppConfig.get_deviceuniqueidentifier(),
--			AppConfig.get_device_id(),
--			AppConfig.get_platformchannel_id(),
--			AppConfig.get_gameserver_tarver()
--		);
--	end
--end
--
--function Socket.OnAccountClose(object)
--	if Socket.socketAccount and (object == nil or Socket.socketAccount:get_socket_id() == object:get_socket_id()) then
--		--[[关闭帐号服连接]]
--		Socket.Account_close();
--		HintUI.SetAndShow(EHintUiType.two, "帐号服断开连接，请重新登陆！",
--			{str = "是", func = GameBegin.usercenter_logout_callback},{str = "否", func = Root.quit}
--		);
--		return;
--	end
--end
--
--function Socket.OnAccountError(object,error_type)
--
--	if Socket.socketAccount and (object == nil or Socket.socketAccount:get_socket_id() == object:get_socket_id()) then
--		--[[关闭帐号服连接]]
--		Socket.Account_close();
--		HintUI.SetAndShow(EHintUiType.two, "帐号服连接错误，请重新登陆！",
--			{str = "是", func = GameBegin.usercenter_logout_callback},{str = "否", func = Root.quit}
--		);
--		return;
--	end
--end
-----------------------------------------------------------------------帐号登录 end--------------------------------------------------------------------------


-----------------------------------------------------------------------GAME登录 str--------------------------------------------------------------------------
--[[登录GAME服]]
function Socket.ConnectGameServer()
	--if ip == nil or port == nil then return end;
	--Socket.connect_game_ip = tostring(ip);
	--Socket.connect_game_port = tonumber(port);

	app.log('准备登录GAME服');

	--[[帐号成功后的登陆回调]]
	Socket.user_center_ConnectGameServer();

end


--[[帐号成功后的登陆回调]]
function Socket.user_center_ConnectGameServer()
	app.log("user_center_ConnectGameServer..."..debug.traceback())
	--[[友盟设定事件监控]]
	GLoading.Hide(GLoading.EType.msg)
	Root.push_web_info("sys_050","登陆game socket开始");
	--[[公司日志：游戏启动信息]]
	--SystemLog.AppStartClose(50);
	--Socket.soketstate = "connecting"
	--[[关闭GAME连接]]
	Socket.GameServer_close();
	app.log('登录GAME服1');
	--[[网络初始化]]
	app.log('网络初始化')
	gnet.set_listener("Socket.OnGameConnect", "Socket.OnGameClose", "Socket.OnGameError");
	--Socket.socketServer = gnet.create();
	--Socket.socketServer:set_dispatch_func("Socket_DispatchMsg");
	--Socket.socketServer:asyc_connection_ex("127.0.0.1", 80);
	app.log('登录GAME服2');
	Socket.OnGameConnect();
	
	Socket.isLogin = true;
	Socket.isopenweak = true;
	--连Socket的时候 还是加个Timer
	--if Socket.processTimeId == nil then
		--Socket.processTimeId = timer.create("Socket.ErrorInfo", 5000, 1);
	--end


	net.p_client_ = Socket.socketServer
end

function Socket.ErrorInfo()
	
	app.log('Socket 连接超时')

	if Socket.processTimeId then
		timer.stop(Socket.processTimeId)
		Socket.processTimeId = nil;
	end
	
	
	Socket.erroeNumb = Socket.erroeNumb + 1

	if Socket.socketServer ~= nil then
	 	app.log("socketserver  ========== not")
	 	Socket.socketServer:close();
	end
	
	-- if Socket.IsSilence then
	--  	if Socket.socketerrorNumb > 2 then
	--  		GLoading.Hide()
	-- 		Socket.socketServer = nil;
	-- 		local str = "无法连接上网络,请在网络恢复后重新登录游戏.";
	-- 	    HintUI.SetAndShow(EHintUiType.one, str, {str = "重新进入", func = UserCenter.sdk_logout}, nil, nil, nil, true);
	-- 	    do return end;
	-- 	else
	-- 		Socket.user_center_ConnectGameServer()
	-- 	end
	-- else
	--  	Socket.user_center_ConnectGameServer()
	-- end
end

--[[关闭GAME连接]]
function Socket.GameServer_close()
	--[[友盟设定事件监控]]
	Root.push_web_info("sys_051","主动关闭game socket连接");
	--[[公司日志：游戏启动信息]]
	SystemLog.AppStartClose(51);

	if Socket.socketServer ~= nil then
		Socket.socketServer:close();
	end
	Socket.socketServer = nil;
	Socket.StopPingPong()
end

function Socket.StartPingPong()
	if not AppConfig.get_enable_keep_alive_check() then return end
	if Socket.isUpdating then return end
	Socket.isUpdating = true;
	Socket.ping_pong_ref = 0;
	Socket.lastSendTime = os.time()
	Root.AddUpdate(Socket.PingPongUpdate)
end

function Socket.StopPingPong()
	if Socket.isUpdating then 
		Root.DelUpdate(Socket.PingPongUpdate)
		Socket.isUpdating = nil
		Socket.ping_pong_ref = 0;
		Socket.isUpdating = false;
	end
end

function Socket.PingPongUpdate()
	if os.time() - Socket.lastSendTime >= 5 then
		Socket.SendPingMsg()
		Socket.lastSendTime = os.time()
	end
end

function Socket.SendPingMsg()
	if Socket.socketServer then
--		app.log("send ping msg:" .. Socket.ping_pong_ref)
		Socket.ping_pong_ref = Socket.ping_pong_ref + 1;
		if Socket.ping_pong_ref > 3 then
			    --Socket.ShowDialog("游戏服连接超时，请重新登陆！")
				Socket.StopPingPong()
				--加入断线重连的逻辑
				if Socket.socketServer then
				    Socket.socketServer:close();
				--Socket.GameServer_close();
				end
				--app.log("Unlock receivelist........"..table.tostring(netmgr.seqnumlist))
			    app.log("SendPingMsg.游戏服连接超时==========")
		else
		    msg_weaknet_white.cg_ping()
		end
	end
end

--断线重连成功后服务器发个消息
function Socket.reconnectUniversalSuccess()
	app.log("==============reconnectUniversalSuccess=================")
	Socket.m_is_reconnecting = false
	netmgr.reconnectDel()
	Socket.ClearErroNumber()
	GLoading.Hide(GLoading.EType.msg)
	Socket.AutoSilenceDialog = false;

	--恢复新手引导显示
	-- if GuideManager then
	-- 	GuideManager.SetHideMode(false)
	-- end
end

function Socket.ClearErroNumber()
	Socket.erroeNumb = 0;
end

function Socket.OnGameConnect(object)
	g_net_is_disconnect = false
	app.log("Socket.OnGameConnect");

	--if Socket.processTimeId then
		--timer.stop(Socket.processTimeId)
		--Socket.processTimeId = nil;
	--end

	--连接成功
	app.log("伪连接成功");
	if object == nil then
		app.log("Socket.OnGameConnect object==nil")
	end

	--Socket.socketServer_obj = object;--[[存连接]]

	--if Socket.soketstate == "connect" then
		--app.log("Socket.OnGameConnect soketstate=='connect'")
		--do return end
	--end

	Socket.socketerrorNumb = 0;
	
	Socket.soketstate = "connect"

	Root.push_web_info("sys_052","登陆game socket成功");
	--[[公司日志：游戏启动信息]]
	--SystemLog.AppStartClose(52);

	--Socket.StartPingPong()

	app.log("Socket.OnGameConnect  OK");

	--[[GAME SOCKET处理成功回调]]
	GameBegin.game_socket_callback();

	--[[进入游戏消息]]
	app.log("进入游戏消息");
	Socket.enter_game();

	--[[判断巅峰展示]]
	if EnterShow.CheckEnter() then
		app.log("判断巅峰展示");
	 	EnterShow.Start(GameBegin.login_bg_destroy, Socket.enter_game);
	else
	--[[进入游戏消息]]
		app.log("ENTER 进入游戏消息");
	 	--Socket.enter_game();
	end

end

--[[进入游戏消息]]
function Socket.enter_game()
	app.log("Socket.OnGameConnect  enter_game");

	--if Socket.socketServer and Socket.socketServer_obj and Socket.socketServer:get_socket_id() == Socket.socketServer_obj:get_socket_id() then
		Socket.is_soucketserver = true;
		app.log("进入游戏 accountid="..UserCenter.get_accountid());
		local enter_game_info =
		{
			account_server_id = 0,
			channel_id = "",
			account_id = "1000",
			account_id_3p = "0", --[[第三方渠道ID：现在只有应用宝使用]]
			token = UserCenter.get_accessToken(),
			game_id = AppConfig.get_game_id(),
			server_id = "000",
			version = AppConfig.get_package_version(),
			language = AppConfig.get_update_region(),
			package_id = AppConfig.get_package_id(),
			device_id = AppConfig.get_deviceuniqueidentifier(),
			access_token_debug = 0,
			mac = app.get_device_info_by_key("mac"),
			android_id = app.get_device_info_by_key("android_id"),
			u3d_device_id = AppConfig.get_deviceuniqueidentifier(),
			ip = app.get_device_info_by_key("ip");
			idfa = app.get_device_info_by_key("idfa");
			bUseMobilePhone = UserCenter.get_sdk_user_type();
			channel_id = AppConfig.get_platformchannel_id();
		}

		--[[第三方渠道ID：现在只有应用宝使用]]
		--if AppConfig.get_check_tencent() then
--			app.log("UserCenter.exten_val str ="..UserCenter.exten_val);
			--local temp_lua = pjson.decode(UserCenter.exten_val);
--			app.log("UserCenter.exten_val lua ="..table.tostring(temp_lua));
--			app.log("openId="..tostring(temp_lua.openId));
			--enter_game_info.account_id_3p = tostring(temp_lua.openId);
		--end

		app.log("UserCenter.account_id_3p ="..enter_game_info.account_id_3p);

		--if enter_game_info.mac == nil or enter_game_info.mac == "" then
		--	enter_game_info.mac = "0000";
		--else
		--	enter_game_info.mac = string.lower(enter_game_info.mac);
		--	enter_game_info.mac = string.gsub(enter_game_info.mac, ":","");
		--end
		--if enter_game_info.ip == nil then
		--	enter_game_info.ip = ""
		--end
		--local index = string.find(enter_game_info.ip,":")
		---if index and type(index) == "number" then
		--	enter_game_info.ip = string.sub(enter_game_info.ip,1,index-1)
		--end

		--if UserCenter.get_sdk_user_type() == 17 and then
		--enter_game_info.bUseMobilePhone = UserCenter.get_sdk_user_type()
		--else
			--enter_game_info.bUseMobilePhone = false
		--end

		--if UserCenter.get_web_realname() == 0  then
			enter_game_info.bRealName = true
		--else
		--	enter_game_info.bRealName = false
		--end
		
		Socket.m_is_reconnecting = false

		app.log("Socket.m_is_reconnecting状态为"..tostring(Socket.m_is_reconnecting))

		--重连状态下 不走登录流程
		--if Socket.m_is_reconnecting then
			--app.log("cp_re_enter_game=================")
			-- TODO: chengjia 新的协议
			--client_proxy.cp_re_enter_game(enter_game_info)
		--else
			--if Root.get_os_type() == 8 or Root.get_os_type() == 11 then
				--app.log("帐号验证登陆");
				--client_proxy.cp_enter_game(enter_game_info);
			--else
			--	app.log("帐号非验证登陆");
			--	client_proxy.cp_enter_game_no_auth(enter_game_info);
			--end
		--end
		
		app.log("帐号验证登陆");
		client_proxy.cp_enter_game(enter_game_info);

	--else
		--SystemHintUI.SetAndShow(ESystemHintUIType.one, "连接服务器异常，请重新连接！",
			--{ str = "是", func = Socket.Init }
		--);
	--end

end

function Socket.onPvpDialog()
	Socket.Pvp3v3 = false;
	Socket.IsShowDialog = false;
	UserCenter.sdk_logout();
end

function Socket.OnGameClose(object)
	app.log("game socket服连接断开======")
	g_net_is_disconnect = true   -- 网络断开
	local socket_game = Socket.socketServer
	--Socket.socketServer = nil
	if Socket.processTimeId then
		timer.stop(Socket.processTimeId)
		Socket.processTimeId = nil;
	end

	net.p_client_ = nil

--	if Socket.isopenweak == false then
--		app.log(" Socket.isopenweak ");
--		do return end
--	end

	Root.push_web_info("sys_053","game socket服连接断开");
	
	if not Socket.initFlag then
		app.log(" not Socket.initFlag ");
		do return end
	end
	--[[公司日志：游戏启动信息]]
	SystemLog.AppStartClose(53);

	-- --登录过程中 网络出问题 直接重新登录
	-- if Socket.isLogin and Socket.m_is_reconnecting == false then
	-- 	Socket.ShowDialog()
	-- 	do return end
	-- end
	if Socket.Pvp3v3 then
		Socket.IsShowDialog = true;
		app.log(" Socket.Pvp3v3 ");
		GLoading.Hide()
		info = "网络不稳定，确定重新进入游戏！"
		HintUI.SetAndShow(EHintUiType.one, info, {str = "重新进入", func = Socket.onPvpDialog});
		do return end
	end
	--Socket.erroeNumb = Socket.erroeNumb + 1
	--被踢下线时不弹出重连消息
	if Socket.soketstate == "replaced" then
		app.log(" Socket.soketstate = replaced ");
		do return end
	end

	Socket.soketstate = "close";
	
	--关卡中断线不弹提示 重连3次后 弹出重新连接框
	if Socket.IsSilence then
		if Socket.AutoSilenceDialog then
			Socket.ShowDialog()
		else
			if Socket.erroeNumb > 2 then
				Socket.ShowSilenceDialog()
			else
				Socket.Reconnect()
			end
		end
		--app.log(" 关卡中断线不弹提示 重连3次后 弹出重新登录框 ");
		do return end;
	end
	
	if socket_game and (object == nil or socket_game:get_socket_id() == object:get_socket_id()) then

		Socket.StopPingPong()

		app.log("Socket.OnGameClose==========Number :"..tostring(Socket.erroeNumb))

		if Socket.IsShowDialog then
			
		else
			Socket.ShowErrorDialog()
		end
		
	end
end

function Socket.OnGameError(object,error_type)
	g_net_is_disconnect = true
	Socket.soketstate = "close"
	local socket_game = Socket.socketServer
	--Socket.socketServer = nil
	if Socket.processTimeId then
		timer.stop(Socket.processTimeId)
		Socket.processTimeId = nil;
	end

	app.log("game socket服连接错误======")

--	if Socket.isopenweak == false then
--		do return end
--	end

	if Socket.Pvp3v3 then
		local info = "无法连接上网络,请在网络恢复后重新登录游戏.！"
		Socket.IsShowDialog = true;
		GLoading.Hide()
		HintUI.SetAndShow(EHintUiType.one, info, {str = "重新进入", func = Socket.onPvpDialog});
		do return end
	end

	--app.log("......"..debug.traceback())

	Root.push_web_info("sys_054","game服cokse连接错误");
	--[[关掉网页弹窗]]
	UiAnn.on_btn_close();

	if object == nil then
		Root.push_web_info("sys_054","game服cokse连接错误 object=nil");
	end

	if Socket.processTimeId then
		timer.stop(Socket.processTimeId)
		Socket.processTimeId = nil;
	end

	if not Socket.initFlag then
		do return end
	end

	--登录过程中 网络出问题 直接重新登录
	-- app.log("Socket.m_is_reconnecting...."..tostring(Socket.m_is_reconnecting))
	-- if Socket.isLogin and Socket.m_is_reconnecting == false then
	-- 	Socket.ShowDialog()
	-- 	do return end
	-- end

	--被踢下线时不弹出重连消息
	if Socket.soketstate == "replaced" then
		do return end
	end

	--关卡中断线不弹提示 重连2次后 弹出重新登录框
	if Socket.IsSilence then
		if Socket.AutoSilenceDialog then
			Socket.ShowDialog()
		else
			if Socket.erroeNumb > 2 then
				Socket.ShowSilenceDialog()
			else
				Socket.Reconnect()
			end
		end
		do return end	
	end

	if socket_game and socket_game:get_socket_id() == object:get_socket_id() then

		Socket.StopPingPong()

		if error_type == 1 then
			--[[连接错误]]
		elseif error_type == 2 then
			--[[接收错误]]
		elseif error_type == 4 then
			--[[发送错误]]
		elseif error_type == 8 then
			--[[关闭]]
		end
		app.log("Socket.OnGameError==========Number :"..tostring(Socket.erroeNumb))

		if Socket.IsShowDialog then
			
		else
			Socket.ShowErrorDialog()
		end

	end
end

--开始重连
function Socket.Reconnect()
	
	if Socket.processTimeId then
		timer.stop(Socket.processTimeId)
		Socket.processTimeId = nil;
	end

--	Socket.isopenweak = false;

	Socket.user_center_ConnectGameServer();

	if Socket.IsSilence then
		--GLoading.showFight()
	else
		GLoading.Show(GLoading.EType.msg)
	end

	Socket.m_is_reconnecting = true;
	Socket.IsShowDialog = false;
	
	Socket.erroeNumb = Socket.erroeNumb + 1	
end

function Socket.ReconnetFinishRecall()
	Socket.m_is_reconnecting = false
	--Socket.ClearErroNumber()
end

function Socket.ShowDialogCall()
	GLoading.Hide(GLoading.EType.msg)
	UserCenter.sdk_logout()
	Socket.IsShowDialog = false
end

function Socket.ShowDialog()
	GLoading.Hide(GLoading.EType.msg)

	Socket.IsShowDialog = true;
			
	app.log("重连失败，请重新登录.")
	--local info = "重连失败，请重新登录."
	--HintUI.SetAndShow(EHintUiType.one, info, {str = "重新进入", func = Socket.ShowDialogCall});
   	
	-- if GuideManager then
	-- 	GuideManager.SetHideMode(true)
	-- end
	
	Socket.m_is_reconnecting = false
	Socket.ClearErroNumber()

end

function Socket.ShowSilenceDialog()
	GLoading.Hide(GLoading.EType.msg)

	Socket.IsShowDialog = true;
	
	app.log("伪连接失败，请检查Debug日志")
		
	--info = 	"网络不稳定，是否重连！"
		
	--HintUI.SetAndShow(EHintUiType.two, info,
	--	{str = "是", func = Socket.OnDialogReconnect},{str = "否", func = Socket.OnDialogQuitDialog}
	--);
   	
	-- if GuideManager then
	-- 	GuideManager.SetHideMode(true)
	-- end
	
	Socket.m_is_reconnecting = false

	Socket.AutoSilenceDialog = true;   ---关卡中是否已自动连接3次
end

function Socket.ShowErrorDialog()
	GLoading.Hide(GLoading.EType.msg)  

	if Socket.erroeNumb < 3 then
		
		
		if Socket.processTimeId then
			timer.stop(Socket.processTimeId)
			Socket.processTimeId = nil;
		end
		
		info = 	"网络不稳定，是否重连！"
		
		HintUI.SetAndShow(EHintUiType.two, info,
			{str = "是", func = Socket.OnDialogReconnect},{str = "否", func = Socket.OnDialogQuitDialog}
		);
		
		Socket.IsShowDialog = true
		
		-- if GuideManager then
		-- 	GuideManager.SetHideMode(true)
		-- end
	else
		info = "无法连接上网络,请在网络恢复后重新登录游戏！"
		HintUI.SetAndShow(EHintUiType.one, info,
			{str = "是", func = Socket.OnDialogRestlogout});
		
		Socket.IsShowDialog = true
		
		-- if GuideManager then
		-- 	GuideManager.SetHideMode(true)
		-- end
		
		Socket.m_is_reconnecting = false
		Socket.ClearErroNumber()
		netmgr.clear()	
	end
	
end

function Socket.ShowCheatCheckingDialog()
	HintUI.SetAndShow(EHintUiType.one, "系统检测到您在使用第三方软件！请关闭后再进入游戏！",
		{str = "是", func = Socket.OnDialogUsercenterLogoutCallback, time=8},nil,nil,nil,true
	);
	if GuideManager then
		GuideManager.Destroy()	-- 提前释放新手引导，避免卡住界面
	end
end

function Socket.OnDialogUsercenterLogoutCallback()
	-- if GuideManager then
	-- 	GuideManager.SetHideMode(false)
	-- end
	GameBegin.usercenter_logout_callback()
end

function Socket.OnDialogQuitGame()
	-- if GuideManager then
	-- 	GuideManager.SetHideMode(false)
	-- end
	--Root.quit()
	UserCenter.sdk_logout();
end

function Socket.OnDialogQuitDialog()
	-- if GuideManager then
	-- 	GuideManager.SetHideMode(false)
	-- end
	Socket.IsShowDialog = false
	--Root.quit()
	--GameBegin.usercenter_logout_callback()
	UserCenter.sdk_logout();
end

function Socket.OnDialogReconnect()
	-- if GuideManager then
	-- 	GuideManager.SetHideMode(false)
	-- end
	Socket.Reconnect()
end

function Socket.OnDialogRestlogout()
	-- if GuideManager then
	-- 	GuideManager.SetHideMode(false)
	-- end
--	Socket.isopenweak = false
	GameBegin.usercenter_logout_callback()
end

--[[帐号登录GAME服]]
function Socket.SendLogin(username, password)
	login.ca_login(username, password, Socket.gameID, Socket.groupID);
end
-----------------------------------------------------------------------GAME登录 end--------------------------------------------------------------------------



return Socket
