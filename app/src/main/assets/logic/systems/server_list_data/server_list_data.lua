--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/11/7
-- Time: 10:26
-- To change this template use File | Settings | File Templates.
--

ServerListData = {
	--[[  返回例表样式
	--
	- 内网测试结构
	-
		{
		    server_id='1030'
		    type=0
		    name='30 FangWei(node1030)'
		    pro_list={
		      1={
		        is_frist=0
		        port='5000'
		        proxyid='0'
		        ip='192.168.53.163'
		      }
		    }
		    state=0
		}

		线上正式结构

		data={
		opurl={							//新增字段
			[1]={
				checkopurl="",
				checkfileurl=""
			}
		},
		proxy_info={
			[1]={
				server_id=1,
				name="测试服",
				state=0,   0开服 1繁忙 2瀑满 3维护
				type=1,    0普通 1推荐 2新服
				opurlindex=1,			//新增字段使用的url组索引
				optype="xxx",				//新增字段，服务器类型；1-全量 2-灰度 3-ios评审
				max_opid_list={			//新增字段，设备文件更新最大id列表
					[1]={
						deviceid=100,	//设备id
						maxopid=10000,	//maxopid
					}
				},
				pro_list={
					[1]={
						proxyid=1,
						ip="",
						port=8080,
						is_frist=0
					}
				},
			},
		},
	}


服务器维护公告格式：
{
    "1008": {
        "30000": {
            "title": "30000服务器标题",
            "content": "30000服务器内容"
            "server_id": "30000"
        },
        "30001": {
            "title": "30001服务器标题",
            "content": "30001服务器内容"
            "server_id": "30001"
        },
        "common": {
            "title": "通用标题",
            "content": "通用内容"
            "server_id": "common"
        }
    },
    "1009": {
        "20000": {
            "title": "20000服务器标题",
            "content": "20000服务器内容"
            "server_id": "20000"
        },
        "20001": {
            "title": "20001服务器标题",
            "content": "20001服务器内容"
            "server_id": "20001"
        },
        "common": {
            "title": "通用标题",
            "content": "通用内容"
            "server_id": "common"
        }
    }
}

	-- ]]
	_dirtree_data = {};
	proxy_data_list = {};
	opurl_data_list = {};

	url = "";
	path = "";
	call_back = nil;
	check_max = 20;
	check_num = 0;
	is_check = false;

	use_server_url = "";--[[当前使用的URL]]
	used_server_urllist = {};--[[使用过的例表]]
	use_server_url_max_num = 5;--[[每个URL使用次数]]

	enter_server_id = -1;--[[进入游戏服务器ID]]

	server_notice_max_num = 3;--[[维护公告重试次数]]
	server_notice_try_num = 0;--[[维护公告重试次数]]
	server_notice_get_time = 0;--[[请求的时间]]
	server_notice_time_max = 10;--[[秒]]

	server_notice_check_callback = nil;
	server_notice_check_serverid = 0;
};

function ServerListData.apply_data_list(call_back)
	ServerListData.is_check = false;
	ServerListData.check_num = 0;

	if call_back ~= nil then
		if type(call_back) == "function" then
			ServerListData.call_back = call_back;
		end
	end
	ServerListData.check_num = ServerListData.check_num + 1;
	timer.create("ServerListData.re_apply", 500, 1);
end

function ServerListData.re_apply()
	app.log("ServerListData re_apply!");

	if not ServerListData.get_url() then
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "无法取得有效的服务器地址！请稍后重试！",
			{ str = "退出", func = Root.quit }
		);
	end

	if ServerListData.is_check then
		ServerListData.is_check = false;
		ServerListData.check_num = 0;
		return;
	end

	if ServerListData.check_num > ServerListData.check_max then
		if ServerListData.call_back ~= nil then
			ServerListData.call_back(ServerListData.proxy_data_list);
			ServerListData.call_back = nil;
		end
		app.log("can not get server list data!");
		return;
	end

	app.log(">>>>dtree url="..table.tostring(ServerListData.url));
	app.log(">>>>dtree path="..tostring(ServerListData.path));

	ghttp.get(
			ServerListData.url,
			"ServerListData.on_op_success",
			"ServerListData.on_op_error",
			ServerListData.path
		);

--	ghttp.get(
--		"http://dir.lzjd.qq.com:8888/",
--		"ServerListData.on_op_success",
--		"ServerListData.on_op_error",
--		"digisky_tencent_dirtree/getserverinfo?appId=0002000100020016&accountId=1&channel=lzjd_yfb_aqq&deviceid=30003&client_version=app_cn_20160326_0220"
--	);

	--[[老的]]
	-- http://192.168.2.160:8880/dirtree/getserverinfo?appId=0001000201020020&accountId=xx&channel=ghoul
	-- http://192.168.2.160:8880/dirtree/getserverinfo?appId=0001000201020020&accountId=xx&channel=ghoul&datatype=json
	--[[新的]]
--	http://119.29.33.139:8088/digisky_tencent_dirtree/getserverinfo?appId=0001000100010016&accountId=111&channel=lzjd_pr1_sq
--	http://119.29.33.139:8088/digisky_tencent_dirtree/getserverinfo?appId=0001000100010016&accountId=111&channel=digisky_ghoul

end

function ServerListData.get_url()
	ServerListData.url = ServerListData.fileter_server_url();

	--[[DTREE的CHANNEL 在判断一下，有设就用，没用就使用支付的ID]]
	if AppConfig.get_dtree_channle_id() ~= "" then
		if Root.get_os_type() == 8 then
			ServerListData.path = AppConfig.get_dtree_server_path().."?appId="..AppConfig.get_app_id().."&accountId="..UserCenter.get_accountid().."&channel="..AppConfig.get_dtree_channle_id().."&deviceid="..AppConfig.get_deviceid().."&game="..AppConfig.get_game_version().."&client_version="..AppConfig.get_client_version();
		else
			ServerListData.path = AppConfig.get_dtree_server_path().."?appId="..AppConfig.get_app_id().."&accountId="..UserCenter.get_accountid().."&channel="..AppConfig.get_dtree_channle_id().."&deviceid="..AppConfig.get_deviceid().."&game="..AppConfig.get_game_version();
		end
	else
		if Root.get_os_type() == 8 then
			ServerListData.path = AppConfig.get_dtree_server_path().."?appId="..AppConfig.get_app_id().."&accountId="..UserCenter.get_accountid().."&channel="..AppConfig.get_platformchannel_id().."&deviceid="..AppConfig.get_deviceid().."&game="..AppConfig.get_game_version().."&client_version="..AppConfig.get_client_version();
		else
			ServerListData.path = AppConfig.get_dtree_server_path().."?appId="..AppConfig.get_app_id().."&accountId="..UserCenter.get_accountid().."&channel="..AppConfig.get_platformchannel_id().."&deviceid="..AppConfig.get_deviceid().."&game="..AppConfig.get_game_version();
		end
	end

	if ServerListData.url == "" then
		return false;
	else
		return true;
	end
end

function ServerListData.on_op_error(t)
	timer.create("ServerListData.re_apply", 500, 1);
	app.log("[ServerListData on_op_error] error code: " .. tostring(t.err_code).." error info: ".. tostring(t.err_str));
end

--[[
-- type 对应  普通=0 推荐=1，新服=2
state 对应 0:开服空闲 1:繁忙 2:爆满 3:维护 4:没开服 5:白名单
-- ]]
function ServerListData.on_op_success(t)
	ServerListData.is_check = true;
	ServerListData.check_num = 0;

--	app.log("ServerListData on_op_success>>>>>"..t.result);

	--[[转原表]]
	local temp = loadstring(t.result);

	--if temp == nil then
		--ServerListData.is_check = false;

		--SystemHintUI.SetAndShow(ESystemHintUIType.one, "连接服务器错误！请稍后重试！",
			--{ str = "退出", func = Root.quit }
		--);

		--return;
	--end

	temp();

	ServerListData._dirtree_data = table.deepcopy(_dirtree_data);
	app.log("ServerListData._dirtree_data>>>>>"..table.tostring(ServerListData._dirtree_data));

	--[[代理信息]]
	if ServerListData._dirtree_data.proxy_info then
		ServerListData.proxy_data_list = table.deepcopy(ServerListData._dirtree_data.proxy_info);
	end

	--[[下载资源地址]]
	if ServerListData._dirtree_data.opurl then
		ServerListData.opurl_data_list = table.deepcopy(ServerListData._dirtree_data.opurl);
	end

	UserCenter.get_player_info_toweb();--[[拉取玩家信息,用于历史角色信息显示]]

	if ServerListData.call_back ~= nil then
		ServerListData.call_back(ServerListData.proxy_data_list);
		ServerListData.call_back = nil;
	end

	--[[还原重试次数]]
	ServerListData.used_server_urllist = {};
end

--[[维护公告得到的时间]]
function ServerListData.get_server_notice_get_time()
	return ServerListData.server_notice_get_time;
end

--[[请求维护公告信息]]
function ServerListData.get_server_notice()
	if Root.get_use_system_url() ~= "" and AppConfig.get_notice_info_path() ~= "" then
		ghttp.get(
			Root.get_use_system_url(),
			"ServerListData.on_notice_success",
			"ServerListData.on_notice_error",
			AppConfig.get_notice_info_path().."?channel_id="..AppConfig.get_dtree_channle_id()
		);
	end
end
--[[服务器公告返回]]
function ServerListData.on_notice_success(t)
	app.log("ServerListData.on_notice_success="..table.tostring(t));

	if t.result == "" then
		ServerListData.server_notice_try_num = 0;
		ServerListData.server_notice_get_time = os.time();
		systems_data.init_server_notice();
	else
		local json_info = pjson.decode(t.result);
		if json_info ~= nil then
			--[[加上时间]]
			for k,v in pairs(json_info) do
				v.time = os.time();
			end
			ServerListData.server_notice_try_num = 0;
			ServerListData.server_notice_get_time = os.time();
			systems_data.init_server_notice();
			systems_data.set_server_notice(json_info);
		end
	end

	--[[如果有回调，说明是主动调用的，不是第一次刷新]]
	local temp =  ServerListData.get_server_notice_info(ServerListData.server_notice_check_serverid );
	if ServerListData.server_notice_check_callback ~= nil then
		ServerListData.server_notice_check_callback(temp);
		ServerListData.server_notice_check_callback = nil;
	end
end
function ServerListData.on_notice_error(t)
	app.log("ServerListData.on_notice_error="..table.tostring(t));
	if ServerListData.server_notice_try_num < ServerListData.server_notice_max_num then
		timer.create("ServerListData.get_server_notice_info", 1000, 1);
	else
		app.log("ServerListData.on_notice_error try num = "..ServerListData.server_notice_try_num);
	end
end

--[[得到单个服务器维护公告]]
function ServerListData.get_server_notice_info_cb(server_id,call_back)
	if server_id == nil then return nil end;
	ServerListData.server_notice_check_callback = call_back;
	ServerListData.server_notice_check_serverid = server_id;

	--[[超过时间就取]]
	if os.time() - ServerListData.server_notice_get_time >= ServerListData.server_notice_time_max then
		app.log("重新请求维护公告")
		ServerListData.get_server_notice();
	else
		app.log("不用请求维护公告")
		local temp =  ServerListData.get_server_notice_info(server_id);
		if ServerListData.server_notice_check_callback ~= nil then
			ServerListData.server_notice_check_callback(temp);
			ServerListData.server_notice_check_callback = nil;
		end
	end

end
--[[得到服务器维护公告]]
function ServerListData.get_server_notice_info(server_id)
	local temp = nil;
	if server_id == nil then return temp end;
	server_id = tostring(server_id);
	local temp_table = systems_data.get_server_notice();
	app.log("get_server_notice_info"..table.tostring(temp_table));
	if temp_table["common"] == nil then return temp end;

	if temp_table[server_id] == nil then
		return temp_table["common"];
	else
		return temp_table[server_id];
	end
end


--[[得到总的服务器LIST]]
function ServerListData.get_proxy_data_list()
	return ServerListData.proxy_data_list;
end

--[[有没有服务器]]
function ServerListData.check_proxy_data_list()
	local num = table.getn(ServerListData.proxy_data_list);
	if num > 0 then
		return true;
	else
		return false;
	end
end

--[[查找ID是否存在]]
function ServerListData.check_serverid(serverid)
	for k,v in pairs(ServerListData.proxy_data_list) do
		if tostring(serverid) == tostring(v.server_id) then
			return true;
		end
	end
	return false;
end

--[[通过ID得到信息]]
function ServerListData.get_server_info(serverid)
	for k,v in pairs(ServerListData.proxy_data_list) do
		if tostring(serverid) == tostring(v.server_id) then
			return v;
		end
	end
	return nil;
end

--[[得到正式服的MAXID]]
function ServerListData.get_release_maxid()
	local temp = -1;
	for k,v in pairs(ServerListData.proxy_data_list) do
		if not string.find(v.optype,"gray") then
			if v.max_opid_list[1].maxopid ~= nil then
				temp = tonumber(v.max_opid_list[1].maxopid);
			end
		end
	end
	return temp;
end

--[[得到灰度服的MAXID]]
function ServerListData.get_gray_maxid()
	local temp = -1;
	for k,v in pairs(ServerListData.proxy_data_list) do
		if string.find(v.optype,"gray") then
			if v.max_opid_list[1].maxopid ~= nil then
				temp = tonumber(v.max_opid_list[1].maxopid);
			end
		end
	end
	return temp;
end

--[[取一个推荐服务器包含灰度服]]
function ServerListData.get_recommend()
	for k,v in pairs(ServerListData.proxy_data_list) do
		if v.type == 1 then
			return v.server_id;
		end
	end

	for k,v in pairs(ServerListData.proxy_data_list) do
		if v.type == 2 then
			return v.server_id;
		end
	end

	for k,v in pairs(ServerListData.proxy_data_list) do
		if v.type == 0 then
			return v.server_id;
		end
	end

	return -1;
end

--[[取一个推荐服务器包不含灰度服]]
function ServerListData.get_recommend_no_gray()
	for k,v in pairs(ServerListData.proxy_data_list) do
		if v.type == 1 and not string.find(v.optype,"gray") then
			return v.server_id;
		end
	end

	for k,v in pairs(ServerListData.proxy_data_list) do
		if v.type == 2 and not string.find(v.optype,"gray") then
			return v.server_id;
		end
	end

	for k,v in pairs(ServerListData.proxy_data_list) do
		if v.type == 0 and not string.find(v.optype,"gray") then
			return v.server_id;
		end
	end

	return -1;
end

--[[取一组推荐服务器]]
function ServerListData.get_recommend_list()
	local temp_table = {};
	--[[推荐=1，新服=2]]
	for k,v in pairs(ServerListData.proxy_data_list) do
		if v.type == 1 then
			table.insert(temp_table,v);
		end
	end

	return temp_table;
end

--[[取一组推荐服务器]]
function ServerListData.get_recommend_new_list()
	local temp_table = {};
	--[[推荐=1，新服=2]]
	for k,v in pairs(ServerListData.proxy_data_list) do
		if v.type == 2 then
			table.insert(temp_table,v);
		end
	end

	return temp_table;
end

--[[ dtree url]]
function ServerListData.fileter_server_url()
	local url_list = AppConfig.get_dtree_server_url();
	app.log("url_list="..#url_list);
	for i=1,table.getn(url_list) do
		app.log("筛选DTREE验证服URL="..url_list[i]);
		local used_index = 0;
		--[[查看有没有使用过]]
		for j=1,table.getn(ServerListData.used_server_urllist) do
			local temp = ServerListData.used_server_urllist[j];
			if temp.url == url_list[i] then
				used_index = j;
				break;
			end
		end

		if used_index ~= 0 then
			--[[使用过 次数还可以用]]
			app.log("使用过="..ServerListData.used_server_urllist[used_index].num);
			if ServerListData.used_server_urllist[used_index].num < ServerListData.use_server_url_max_num then
				ServerListData.used_server_urllist[used_index].num = ServerListData.used_server_urllist[used_index].num + 1;
				ServerListData.use_server_url = url_list[i];--[[取一个URL]]
				app.log("ServerListData.use_server_url="..ServerListData.use_server_url);
				return url_list[i];
			end
		else
			--[[没有使用过]]
			app.log("没有使用过");
			local inset_table = {};
			inset_table.url = url_list[i];
			inset_table.num = 1;
			table.insert(ServerListData.used_server_urllist,inset_table);
			ServerListData.use_server_url = url_list[i];--[[取一个URL]]
			app.log("ServerListData.use_server_url="..ServerListData.use_server_url);
			return url_list[i];
		end

	end

	--[[没有URL]]
	UserCenter.use_server_url = "";--[[取一个URL]]
	return "";
end

--[[设定进入服务器ID]]
function ServerListData.set_enter_server_id(n_id)
	if n_id == nil then return end;
	ServerListData.enter_server_id = n_id;
	--[[设定进入游戏的服务器ID]]
	systems_data.set_enter_server_id(n_id);
end

--[[得到进入服务器ID]]
function ServerListData.get_enter_server_id()
	return ServerListData.enter_server_id;
end

--[[得到进入服务器的MAXOPID]]
function ServerListData.get_enter_server_maxopid()
	local info =  ServerListData.get_server_info(ServerListData.get_enter_server_id());
	if info ~= nil then
		if table.getn(info.max_opid_list) > 0 then
			if info.max_opid_list[1].maxopid == nil then
				return  -1;
			else
				return info.max_opid_list[1].maxopid;
			end
		else
			return -1;
		end
	else
		return -1;
	end
end

--[[得到进入服务器的TYPE]]
function ServerListData.get_enter_server_type()
	local info =  ServerListData.get_server_info(ServerListData.get_enter_server_id());
	if info ~= nil then
		return info.optype;
	else
		return "";
	end
end

--[[得到一个进入服的随机代理]]
function ServerListData.get_enter_server_proxy()
	local enter_server_info = ServerListData.get_server_info(ServerListData.get_enter_server_id());
	if enter_server_info ~= nil then
		return ServerListData.r_proxy(enter_server_info.pro_list);
	end
	return nil;
end
function ServerListData.r_proxy(pro_list)
	if pro_list == nil then return nil end;
	local t_num = table.getn(pro_list);
	if t_num > 0 then
		local r_num = math.random(1,t_num);
		return pro_list[r_num];
	else
		return nil;
	end
end


