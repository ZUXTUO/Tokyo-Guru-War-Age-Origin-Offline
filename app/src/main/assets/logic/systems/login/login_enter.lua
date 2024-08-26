--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2017/5/3
-- Time: 16:51
-- To change this template use File | Settings | File Templates.
--


login_enter = {
	call_back = nil;
	path_enter = "assetbundles/prefabs/ui/login/login_enter.assetbundle";
	ui_server_name_lab = nil;
	ui_server_but = nil;
	ui_enter_name_lab = nil;
	ui_enter_but = nil;
	ui_versiopn_lab = nil;
	ui_beian_lab = nil;
	ui_kefu_but = nil;

	on_click_time = 0;
	on_click_server = 0;

	on_click_useing = false;--[[防止多次点击]]

	local_file_name = "loginfile.data";--[[本地文件]]
	local_file_time = "logintime.data";--[[本地文件]]

	--[[
		[1] = 111111,
	-- ]]

	local_file_data = {};--[[本地数据表 支持切换帐号]]
	enter_server_id = -1;--[[选中的服务器ID]]
};

function login_enter.Start(call_back)
	app.log("login_enter begin");

	--[[干掉黑条]]
	if UiSceneChange then
		UiSceneChange.ExitCallback();
	end

	login_enter.call_back = call_back;
	login_enter._asset_loader = systems_func.loader_create("ResourceLoader_loader")
	login_enter._asset_loader:set_callback("login_enter.on_load")
	login_enter._asset_loader:load(login_enter.path_enter);
	login_enter._asset_loader = nil;
end

function login_enter.on_load(pid, fpath, asset_obj, error_info)
	if fpath == login_enter.path_enter then
		login_enter.ui = systems_func.game_object_create(asset_obj);
		login_enter.ui:set_parent(Root.get_root_ui_2d());
		login_enter.ui:set_name("login_enter");
		login_enter.ui:set_local_rotation(0, 0, 0);
		login_enter.ui:set_local_scale(1, 1, 1);

		login_enter.ui_server_name_lab = ngui.find_label(login_enter.ui,"sp_di/lab");
		login_enter.ui_server_but = systems_func.ngui_find_button(login_enter.ui,"sp_di");
		login_enter.ui_enter_name_lab = ngui.find_label(login_enter.ui,"btn_enter/animation/lab");
		login_enter.ui_enter_but = systems_func.ngui_find_button(login_enter.ui,"btn_enter");
		login_enter.ui_versiopn_lab = ngui.find_label(login_enter.ui,"right_other/lab_version");
		login_enter.ui_beian_lab = ngui.find_label(login_enter.ui,"left_down_other/lab");
		login_enter.ui_beian_lab1 = ngui.find_label(login_enter.ui,"left_down_other/lab1")
		login_enter.ui_kefu_but = systems_func.ngui_find_button(login_enter.ui,"right_down_other/btn_kefu");
		--login_enter.ui_kefu_but:set_on_click("login_enter.kefu_click");

		----网络状态
		login_enter.ui_netstate_sp = ngui.find_sprite(login_enter.ui,"sp_di/sp_arrows");
		login_enter.ui_netstate_lab = ngui.find_label(login_enter.ui,"sp_di/sp_arrows/lab_x")
		--推荐
		login_enter.ui_tuijian_lab = ngui.find_label(login_enter.ui,"sp_di/txt_tuijian")

		
		login_enter.ui_login_notice_btn = systems_func.ngui_find_button(login_enter.ui,"right_down_other/btn_exit");
		login_enter.ui_login_notice_btn:set_on_click("login_enter.login_notice_click");

		login_enter.ui_login_reg_btn = systems_func.ngui_find_button(login_enter.ui,"right_down_other/btn_protocol");
		login_enter.ui_login_reg_btn:set_on_click("login_enter.login_reg_click");

		login_enter.ui_enter_name_lab:set_text("进入游戏");
		login_enter.ui_server_but:set_on_click("login_enter.server_on_click");
		login_enter.ui_server_but:set_active(false);
		login_enter.ui_server_name_lab:set_text("******");
		login_enter.ui_enter_but:set_on_click("login_enter.enter_on_click_ui");
		login_enter.ui_enter_but:set_active(false);


		--TODO: 先修改显示， 下次包更修改appconfig.
		--read from file
		local ver_code = AppConfig.get_package_version();
		local fileName = "logic/ver_code.txt";
		if file.exist(fileName) then
			local ver_file = file.open(fileName, 3)
			if ver_file ~= nil then
				local code = ver_file:read_string()
				ver_file:close();
				if code ~= nil and code ~= "" then
					ver_code = code;
				end
			end 
		end
		

		login_enter.ui_versiopn_lab:set_text("Ver:"..ver_code.." Res:"..AppConfig.get_package_ass_ver());

		-- login_enter.ui_versiopn_lab:set_text("Ver:"..AppConfig.get_package_version().." Res:"..AppConfig.get_package_ass_ver());




		login_enter.ui_beian_lab:set_text("文网游备字[2016]M-RPG 5590号 川网文(2017)2374-076号 新广出审〔2017〕5358号");
		login_enter.ui_beian_lab1:set_text("出版服务单位:上海科技技术文献出版社 出版物号ISBN:978-7-7979-8826-1");
		login_enter.ui_kefu_but:set_on_click("login_enter.kefu_on_click");

		login_enter.on_click_time = 0;

		--[[登录UI显示完成后处理]]
		if type(login_enter.call_back) == "function" then
			login_enter.call_back();
			login_enter.call_back = nil;
		end
	end
end

local serverState =
{
	[0] = "",
	[1] = "推荐",
	[2] = "新服",
}

local serverType = 
{	[0] = "dl_lv",
	[1] = "dl_hong",
	[2] = "dl_hong",
	[3] = "dl_hui",
}

local serverTypeText = 
{	
	[0] = "流畅",
	[1] = "繁忙",
	[2] = "爆满",
	[3] = "维护",
}


--[[刷新数据]]
function login_enter.update()
	app.log("login_enter.update");

	--[[先判断本地记录的服务器ID是不是还有效，如果没有效就取一个推荐服务器]]
	if login_enter.get_local_file() then
		--[[本地SERVERID是有效的]]
		app.log("本地SERVERID是有效的");
	else
		app.log("取一个推荐服务器");
		--[[取一个推荐服务器]]
		login_enter.enter_server_id = "0";
	end

	--[[刷新UI界面]]
	login_enter.update_ui();

end

function login_enter.analyzeName(str, split_char)
	local sub_str_tab = { };

    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    app.log("sub_str_tab=========="..table.tostring(sub_str_tab))

    return sub_str_tab;
end

--[[刷新UI界面]]
function login_enter.update_ui()
	--[[得到服务器信息]]
	app.log("login_enter.update_ui id >>>"..login_enter.enter_server_id);
	local showservername = GameInfoForThis.ServerName;
	--local server_info = ServerListData.get_server_info(login_enter.enter_server_id);
	local server_info = "000";
	app.log("login_enter.uidate_ui info >>>"..table.tostring(server_info))
	if server_info ~= nil then
		if login_enter.ui_server_but then
			login_enter.ui_server_but:set_active(true);
			login_enter.ui_enter_but:set_active(true);
			local servername = login_enter.analyzeName(showservername,"_")
			--if servername[1] then
				--showservername = servername[1]
			--end
			--if servername[2] then
				--showservername = showservername.." "..servername[2]
			--end
			login_enter.ui_server_name_lab:set_text(showservername);
			--local prolist = server_info.pro_list
			
			--if #prolist > 0 then
				--login_enter.ui_netstate_lab:set_text(serverTypeText[server_info.state]);
				--login_enter.ui_netstate_sp:set_sprite_name(serverType[server_info.state]);
				--login_enter.ui_tuijian_lab:set_text(serverState[server_info.type])
			--else
				login_enter.ui_netstate_lab:set_text(serverTypeText[3]);
				login_enter.ui_netstate_sp:set_sprite_name(serverType[3]);
				login_enter.ui_tuijian_lab:set_text(serverState[0])
			--end
		end
	end
end

--[[得到本地文件信息]]
function login_enter.get_local_file()
	if file.exist(login_enter.local_file_name) == true then
		local fileHandle = file.open_read(login_enter.local_file_name);
		local content = fileHandle:read_all_text();
		app.log("login file have");
		fileHandle:close();
		if content then
			local temp_table = loadstring(content);
			if temp_table then
				login_enter.local_file_data = temp_table();
				app.log("login_enter.local_file_data="..table.tostring(login_enter.local_file_data));

				--[[判断本地存的服务器ID是不是有效]]
				login_enter.check_local_server_list();

				if table.getn(login_enter.local_file_data) > 0 then
					login_enter.enter_server_id = login_enter.local_file_data[1];
					--if login_enter.enter_server_id ~= -1 then
						--ServerListData.set_enter_server_id(login_enter.enter_server_id);--[[存ID DTREE使用]]
						--return true;
					--else
						--return false;
					--end
				else
					login_enter.enter_server_id = -1;
					return false;
				end
			end
		end
	end
	return false;
end

--[[第一次进游戏，取一个正式服ID]]
function login_enter.first_set_enter_id()
	--login_enter.enter_server_id = ServerListData.get_recommend_no_gray();
	--ServerListData.set_enter_server_id(login_enter.enter_server_id);--[[存ID DTREE使用]]
end

function login_enter.login_notice_click()
	--[[公告]]
	--notice_bg.Start();
end
function login_enter.login_reg_click()
	--[[协议]]
	UiAnn.Start(UiAnn.Type.RegAgreeMent,nil,nil);
end

--[[写入时间]]
function login_enter.save_time_file()
	local fileHandle = file.open(login_enter.local_file_time,2)

end

function login_enter.read_time_file()


end

--[[写入本地文件信息]]
function login_enter.save_local_file()
	local fileHandle = file.open(login_enter.local_file_name, 2);
	fileHandle:write_string(table.tostringEx(login_enter.local_file_data));
	fileHandle:close();

	--[[灰度标示]]
	login_enter.set_gray();

end

--[[灰度标示]]
function login_enter.set_gray()
	--[[根据ID判断灰度标识]]
	local server_info = ServerListData.get_server_info(login_enter.enter_server_id);
	if server_info ~= nil then
		if string.find(server_info.optype,"gray") then
			local temp = file.open("gray.txt",2);
			temp:close();
		else
			file.delete("gray.txt");
		end
	end
end

--[[判断本地存的服务器ID是不是有效]]
function login_enter.check_local_server_list()
	app.log("login_enter.check_local_server_list1="..table.tostring(login_enter.local_file_data));

	if login_enter.local_file_data ~= nil and table.getn(login_enter.local_file_data) > 0 then
		local temp_table = {};
		for i=1,table.getn(login_enter.local_file_data) do
			local server_id = login_enter.local_file_data[i];
			--if ServerListData.check_serverid(server_id) then
				table.insert(temp_table,server_id);
			--end
		end
		login_enter.local_file_data = temp_table;
	end

	app.log("login_enter.check_local_server_list2="..table.tostring(login_enter.local_file_data));
end

--[[存入当前SERVERID]]
function login_enter.inset_server_id()

	local temp_file_data = {};
	table.insert(temp_file_data,login_enter.enter_server_id);
	for i=1,table.getn(login_enter.local_file_data) do
		if login_enter.local_file_data[i] == login_enter.enter_server_id then
			--return;
		else
			table.insert(temp_file_data,login_enter.local_file_data[i]);
		end
	end
	--table.insert(login_enter.local_file_data,login_enter.enter_server_id);
	login_enter.local_file_data = temp_file_data
	--[[写入本地文件信息]]
	login_enter.save_local_file();
end

--[[得到本地进入的服务器例表ID]]
function login_enter.get_local_server_list()
	return login_enter.local_file_data;
end

--[[选好服务器后设定ID]]
function login_enter.set_enter_server_id(serverid)
	if serverid ~= nil then
		login_enter.enter_server_id = serverid;
		login_enter.update_ui();
	end
end

--[[点击服务器例表]]
function login_enter.server_on_click()
	app.log("server_on_click");

	if login_enter.on_click_server == 0 then
		--[[公司日志：游戏启动信息]]
		SystemLog.AppStartClose(500000004);
	end
	login_enter.on_click_server = login_enter.on_click_server + 1

	--[[显示服务器例表]]
	login_server.Start();
end


--login_enter.temp_chick = 1;


--[[10秒后主动释放]]
function login_enter.unlock_click()
	login_enter.on_click_useing = false;
end

--[[进入服务器]]
function login_enter.enter_on_click_ui()
	app.log("enter_on_click_ui>"..login_enter.enter_server_id);

	if os.time() - login_enter.on_click_time < 3 then
		app.log("点快了>>"..os.time() - login_enter.on_click_time);
		return;
	end
	login_enter.on_click_time = os.time();

	if login_enter.on_click_useing then
		app.log("login_enter.on_click_useing>"..tostring(login_enter.on_click_useing));
		do return end;
	end
	login_enter.on_click_useing = true;
	timer.create("login_enter.unlock_click", 1000*8, 1);

--	 --[[分享测试
--	 --type_sdk: 1微信好友 2朋友圈 3微博
--	 --type_list: 1web 2photo
--	 -- ]]
--	 app.log("login_enter.temp_chick="..tostring(login_enter.temp_chick));
--	 if login_enter.temp_chick ==  1 then
--	 	--[[微信好友 WEB:IOS必需要有真实的图才能分享  安卓可以不需要有真实的图，只需非空字符串]]
--	    app.log("微信好友 WEB");
--	 	UserCenter.share_online(1,1,false,"nill","http://djzj.ppgame.com/yy/index.html","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	 end
--
--	 if login_enter.temp_chick ==  2 then
--	 		--[[微信好友 PHOTO]]
--		 app.log("微信好友 PHOTO");
--	 	UserCenter.share_online(1,2,true,"","","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	 end
--
--	 if login_enter.temp_chick ==  3 then
--		 --[[朋友圈 WEB:IOS必需要有真实的图才能分享  安卓可以不需要有真实的图，只需非空字符串]]
--		 app.log("朋友圈 WEB");
--	 	UserCenter.share_online(2,1,false,"nill","http://djzj.ppgame.com/yy/index.html","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	 end
--
--	 if login_enter.temp_chick ==  4 then
--		 --[[朋友圈 PHOTO]]
--		 app.log("朋友圈 PHOTO");
--	 	UserCenter.share_online(2,2,true,"","","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	 end
--
--	 if login_enter.temp_chick ==  5 then
--		 --[[博 WEB:IOS必需要有真实的图才能分享  安卓可以不需要有真实的图，只需非空字符串]]
--		 app.log("博 WEB");
--	 	UserCenter.share_online(3,1,false,"nill","http://djzj.ppgame.com/yy/index.html","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	 end
--
--	 if login_enter.temp_chick ==  6 then
--	 		--[[博 PHOTO]]
--		 app.log("博 PHOTO");
--	 	UserCenter.share_online(3,2,true,"","http://djzj.ppgame.com/yy/index.html","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	 end
--
--	 if login_enter.temp_chick >= 6 then
--	 	login_enter.temp_chick = 0;
--	 end
--	 login_enter.temp_chick = login_enter.temp_chick + 1;
--
--	 do return end;

	


	--[[如果不是上线的话就提示 并刷新LIST]]

	--[[有没有DTREE]]
	--if not ServerListData.check_proxy_data_list() then
		--SystemHintUI.SetAndShow(ESystemHintUIType.one, "服务器没有找到，可能在维护哦，请您稍后重试！",
			--{ str = "确定", func = login_enter.serverlist_up }--[[刷新一下服务器例表]]
		--);
		--login_enter.unlock_click();--[[释放点击]]
		--return;
	--end

	--[[得到服务器信息]]
	--local server_info = ServerListData.get_server_info(login_enter.enter_server_id);
	local server_info = "000";

	--if server_info ~= nil then

		--[[是不是维护中]]
		--if server_info.state == 3 then
			--[[判断维护公告]]
			--ServerListData.get_server_notice_info_cb(login_enter.enter_server_id,login_enter.enter_notice_callback);
			login_enter.unlock_click();--[[释放点击]]
			--do return end;
		--end

		--[[确认有没有代理服务器在线]]
		--if table.getn(server_info.pro_list) <= 0 then
			--SystemHintUI.SetAndShow(ESystemHintUIType.one, "服务器正在维护中，请稍后重试！",
				--{ str = "确定", func = login_enter.serverlist_up }--[[刷新一下服务器例表]]
			--);
			--login_enter.unlock_click();--[[释放点击]]
			--do return end;
		--end

		--[[SDK登陆]]
		--UserCenter.init_user_center(login_enter.enter_on_sdk_cb);

		login_enter.enter_ok();
		
	--else
		--SystemHintUI.SetAndShow(ESystemHintUIType.one, "服务器没有找到，可能在维护哦，请您稍后重试！",
			--{ str = "确定", func = login_enter.serverlist_up }--[[刷新一下服务器例表]]
		--);
		--login_enter.unlock_click();--[[释放点击]]
	--end
end

function login_enter.serverlist_up()
	app.log("login_enter.serverlist_up");
	--ServerListData.apply_data_list(login_enter.update);
end

function login_enter.enter_notice_callback(info)
	app.log("login_enter.enter_notice_callback>"..table.tostring(info));
	if info == nil then
		login_enter.enter_on_sdk_cb();
	else
		SystemHintUI.SetAndShow(ESystemHintUIType.one, info.content,
			{ str = "确认", func = Root.empty_func }
		);
	end
end
function login_enter.enter_on_sdk_cb()
	app.log("enter_on_sdk_cb");

	login_enter.unlock_click();--[[释放点击]]

	--[[本地存ACCID]]
	UserCenter.Save_Player_Accountid(UserCenter.get_accountid());

	--[[实名认证]]
	--UserCenter.check_realname();

--	--实名认语
--	app.log("UserCenter.get_web_realname()=="..UserCenter.get_web_realname());
--	if UserCenter.get_web_realname() ~= 0  then
--		app.log("未实名");
--		local flag = PlayerEnterUITimesCurDay.GetGameTimeData() --是否满3小时
--		if flag then
--			LoginReNameUI.Show(3)
--			return;
--		end
--	end

	--[[灰度服判断 如果上次进入的服务器与当前进入的服务器类型不一样，就必需重进]]
	local server_info = ServerListData.get_server_info(login_enter.enter_server_id);
	if server_info == nil then
		app.log("服务器信息没找到ID："..login_enter.enter_server_id);
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "服务器正在维护中，请稍后重试！",
			{ str = "确定", func = login_enter.serverlist_up }--[[刷新一下服务器例表]]
		);
		do return end;
	else
		if string.find(server_info.optype,"gray") and not Root.get_is_gray() then
			SystemHintUI.SetAndShow(ESystemHintUIType.one, "您选择了测试服务器，请重新进入游戏！",
				{ str = "退出游戏", func = function()
					login_enter.set_gray();
					login_enter.inset_server_id();--[[存SERVER ID]]
					Root.quit();
				end}
			);
			do return end;
		end

		if not string.find(server_info.optype,"gray") and Root.get_is_gray() then
			SystemHintUI.SetAndShow(ESystemHintUIType.one, "您选择了正式服务器，请重新进入游戏！",
				{ str = "退出游戏", func = function()
					login_enter.set_gray();
					login_enter.inset_server_id();--[[存SERVER ID]]
					Root.quit();
				end}
			);
			do return end;
		end
	end

	local apk_res_ver = AppConfig.get_apk_res_version();
	local server_maxopid = 0;
	local temp_deviceid = 0;

	if server_info.max_opid_list[1] ~= nil then
		temp_deviceid = server_info.max_opid_list[1].deviceid;
		server_maxopid = server_info.max_opid_list[1].maxopid;
	end

	--[[服务器下发的DEVID与本地DEVID一样]]
	if tostring(AppConfig.get_deviceid()) == tostring(temp_deviceid) then
		app.log(apk_res_ver..">>>maxopid>>>"..server_maxopid);

		if tostring(server_maxopid) == "-1" and AppConfig.get_use_update_fserver() then
			--[[如果本地的ID大于选中服务器ID，那么就不准进入，提示只能进入灰度服]]
			SystemHintUI.SetAndShow(ESystemHintUIType.one, "服务器资源异常！请选择其他服务器！",
				{ str = "确定", func = Root.empty_func }
			);
		else
			login_enter.enter_ok();
		end
	else
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "服务器信息异常，请选择其他服务器！",
			{ str = "确定", func = Root.empty_func }
		);
	end

end

function login_enter.share_call_back(is_ok)
	app.log("login_enter.share_call_back>"..tostring(is_ok));
end

--[[确认进入游戏 存档]]
function login_enter.enter_ok()
	app.log("login_enter.enter_ok");

	--login_enter.inset_server_id();--[[存SERVER ID]]
	--ServerListData.set_enter_server_id(login_enter.enter_server_id);

	--[[分享测试
	--type_sdk: 1微信好友 2朋友圈 3微博
	--type_list: 1web 2photo
	-- ]]
	--[[微信好友 WEB]]
	-- UserCenter.share_online(1,1,false,"nill","http://djzj.ppgame.com/yy/index.html","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
	--[[微信好友 PHOTO]]
--	UserCenter.share_online(1,2,true,"","","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	--[[朋友圈 WEB]]
--	UserCenter.share_online(2,1,false,"nill","http://djzj.ppgame.com/yy/index.html","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	--[[朋友圈 PHOTO]]
--	UserCenter.share_online(2,2,true,"","","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--
--	--[[博 WEB]]
--	UserCenter.share_online(2,1,false,"nill","http://djzj.ppgame.com/yy/index.html","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
--	--[[博 PHOTO]]
--	UserCenter.share_online(2,2,true,"","http://djzj.ppgame.com/yy/index.html","titile:我在东京战纪","desc:这是我的个人分享，您也可以加入!",login_enter.share_call_back);
	-- do return end;

	--[[官网排队]]
	--if AppConfig.get_digisky_queue_url() ~= "" then
		--UserCenter.digisky_check_login(login_enter.enter_digisky_check_callback);
	--else
		login_enter.enter_ok_goon();
	--end

end
--[[官网排队功能回调]]
function login_enter.enter_digisky_check_callback(temp_table)
	app.log("login_enter.enter_digisky_check_callback>>>>>>>>"..table.tostring(temp_table));
	if temp_table.ret ~= 0 then
		--[[排队UI显示]]
		app.log("login_enter.enter_digisky_check_callback >> ret ~= 0");
		script.run("logic/systems/login/login_limit_ui.lua")
		LoginLimitUI.Show(temp_table.timer)
		return;
	else
		login_enter.enter_ok_goon();
	end
end

--[[执行进入游戏]]
function login_enter.enter_ok_goon()
	login_enter.Destroy();
	login_server.Destroy();

	--[[公司日志：游戏启动信息]]
	SystemLog.AppStartClose(500000005);
	
--	if AppConfig.get_enable_update_file() then
--		Root.update_file();
--	else
		app.log("Resourceload.Start");
		--[[recource_load]]
		script.run("logic/systems/load/resource_load.lua");
		Resourceload.Start();
--	end
end

--[[客服]]
function login_enter.kefu_on_click()
	--[[金立渠道取消QQ信息]]
	if AppConfig.get_platformchannel_id() == "10032" then
		SystemHintUI.SetAndShow(ESystemHintUIType.one, GameInfoForThis.TellStr,
			{ str = "确定", func = Root.empty_func }
		);
	else
		SystemHintUI.SetAndShow(ESystemHintUIType.one, GameInfoForThis.TellStr,
			{ str = "确定", func = Root.empty_func }
		);
	end
end

function login_enter.show_ui(is_show)
	if nil ~= login_enter.ui then
		login_enter.ui:set_active(is_show);
	end
end

function login_enter.Destroy()
	login_enter.show_ui(false);
	login_enter.ui_server_but = nil;
	login_enter.ui_enter_but = nil;
	login_enter.ui_server_name_lab = nil;
	login_enter.ui = nil
end
