--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/16
-- Time: 19:11
-- To change this template use File | Settings | File Templates.
--

system = {};
--------------------------客户端到服务器-----------------------------------
--[[NEW]]
-- function system.cg_enter_game(account_server_id, platform_id, account_id, token, game_id, server_id, version, language)
function system.cg_enter_game(enter_game_info)
	if not Socket.get_socketgame() then return end
	GLoading.Show(GLoading.EType.msg);
	nsystem.cg_enter_game(Socket.get_socketgame(),enter_game_info)
end

function system.cp_enter_game(enter_game_info)
	if not Socket.get_socketgame() then return end
	GLoading.Show(GLoading.EType.msg);
	nclient_proxy.cp_enter_game(Socket.get_socketgame(),enter_game_info)
end

function system.cg_gm_cmd(cmd)
	if not Socket.get_socketgame() then return end
	nsystem.cg_gm_cmd(Socket.get_socketgame(),cmd)
end


--------------------------服务器到客户端-----------------------------------
function system.gc_gm_cmd(result, cmd)
	GLoading.Hide(GLoading.EType.msg);
	local e, info = PublicFunc.GetErrorString(result, false)
	if not e then
		HintUI.SetAndShow(EHintUiType.zero, "cmd="..tostring(cmd).."\nerror="..tostring(info));
	else
		FloatTip.Float("操作成功");
	end
end

local _name_index = 0
local _rand_index = 0
-------------------  自动创建随机名角色  ---------------
function system.__auto_gc_rand_name()
	if PublicFunc.is_lock_msg(player.cg_rand_name) then return end

	_name_index = _name_index + 1
	local name = g_dataCenter.player:getRollNameList()[_name_index]
	if not name then
		_rand_index = _rand_index + 1
		-- temp 请求多次均未返回名字列表 认为服务器未加载名字库配置，客户端随机生成1组名字
		if _rand_index > 3 then
			local listName = {}
			for i=1, 10 do
				table.insert(listName, "随机"..math.random(1000,9999))
			end
			_name_index = 1
			g_dataCenter.player:SetRollNameList(listName)
			system.__auto_cg_create_player(listName[_name_index])
		else
			player.cg_rand_name()
		end
	else
		system.__auto_cg_create_player(name)
	end
end
function system.__auto_cg_create_player(name)
	local createInfo = {
		name = name,
		regist_package_id = AppConfig.get_package_id(),
	}
	player.cg_create_player_info(createInfo);
end
function system.__auto_gc_create_player_info(ret)
	-- 创建成功
	if ret == 0 then
		PublicFunc.msg_unregist(player.gc_rand_name, system.__auto_gc_rand_name)
		PublicFunc.msg_unregist(player.gc_create_player_info, system.__auto_gc_create_player_info)
	-- 换个名字再来一次
	else
		system.__auto_gc_rand_name()
	end
end


--返回有几个玩家
function system.gc_have_player(size, recommend_country_id)
	if size == 0 and AppConfig.get_new_player_script_recording() then
		AppConfig.script_recording = true
	end
	local num = tonumber(size);
	if num < 0 then
		HintUI.SetAndShow(EHintUiType.zero,"您的角色已经被冻结");
		return
	end;

	if num == 0 then
		--LoginSetName.Show();

		--自动创建随机名角色
		PublicFunc.msg_regist(player.gc_rand_name, system.__auto_gc_rand_name)
		PublicFunc.msg_regist(player.gc_create_player_info, system.__auto_gc_create_player_info)
		system.__auto_gc_rand_name()
	end
end


system.time_d = 0;
system.check_time_id = nil
function system.check_cheater()
	if Socket.socketServer ~= nil then
        nsystem.cg_cheater_check(Socket.socketServer, math.floor(app.get_real_tick()))--math.floor(app.get_time()*1000)
	end
end

function system.ShowLogTime(time,str)
    local year,month,day,hour,min,sec = TimeAnalysis.ConvertToYearMonDay(time)
    app.log(str..year.."年"..month.."月"..day.."日"..hour.."时"..min.."分"..sec.."秒");
end

-- 获得当前正确的服务器时间
function system.time()
	return os.time() - system.time_d
end


--[[进入GAME服后回调]]
function system.gc_enter_game_rst(result)
	app.log("gc_enter_game_rst="..tostring(result));
	if not PublicFunc.GetErrorString( result, false ) then
		Root.push_web_info("sys_055","登陆game服后回调失败");
		--[[公司日志：游戏启动信息]]
		SystemLog.AppStartClose(55);

		--[[验证不成功的处理]]
		app.log("result="..tostring(result)..",错误码！");

	else
		Root.push_web_info("sys_056","登陆game服后回调成功");
		--[[公司日志：游戏启动信息]]
		SystemLog.AppStartClose(56);

		LoginFile.Save();
	end
end

-- function system.gc_pong(time)
--     if PublicFunc.check_type_number(time) then
--         system.time_d = os.time() - time
--         Socket.ping_pong_ref = 0
--         --关闭菊花
--         netmgr.HidePingUITime()
--     end
-- end

function system.cg_add_guide_log(nGuideId, nStep)
	--app.log("nGuideId="..tostring(nGuideId).." "..tostring(nStep).." "..type(nGuideId));
	--if not Socket.socketServer then return end
	if AppConfig.script_recording then
		PublicFunc.RecordingScript("nsystem.cg_add_guide_log(robot_s, "..nGuideId..", "..nStep..")")
	end
	nsystem.cg_add_guide_log(Socket.socketServer, tonumber(nGuideId), tonumber(nStep))
	-- 同时发一份到公司日志
	SystemLog.SceneSwitch(nGuideId * 100 + nStep,os.time());
end


function system.gc_find_cheater()
    Socket.ShowCheatCheckingDialog()
end

-- function system.cg_upload_client_info(osType, packageid)
--     if Socket.socketServer then
--         nsystem.cg_upload_client_info(Socket.socketServer, osType, packageid)
--     end
-- end

return system;
