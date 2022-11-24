--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/12/14
-- Time: 22:16
-- To change this template use File | Settings | File Templates.
--

--[[系统级数据存储]]

systems_data = {
	------------------------------------[[从URL取回来的动态信息]]-----------------------------------------
	--[[ APK更新例表
		string channel_id;
		string package_id;
		string client_ver;
		string package_id;
		string md5;
		string redirect;
		string<list> url;
	-- ]]
	new_apk_url_list = {};

	--[[帐号服URL
		{
			string<list> url;
		}
	-- ]]
	auth_server_list = {};
	auth_server_list_path = "";
	auth_server_pay_path = "";
	auth_notice_info_path = "";

	notice_data_list = {};--[[总维护公告]]

	--[[DTREE]]
	dtree_server_list = {};

	--公告列表
	notice_list = {};
	--广告图片列表
	ad_picture_list = {};
	--问卷调查
	question_url = "";

	--[[ 动态更新版本文件
		{
			string<list> url;
		}
	-- ]]
	ver_update_server_list = {};
	ver_update_server_list_path = "";


	--[[ 动态更新UPDATA IP与端口
		{
			string<list> url;
		}
	-- ]]
	res_update_server_list = {};
	res_update_server_list_path = "";

	--[[游戏服
	{
		int ret;
		string channel_id;
		string notice_url;
		list<server_info> server_list;
		//保留做兼容
		list<int> played_servers;
		//有角色的服务器玩家信息
		list<PlayedServerInf> played_server_info;
	};

	struct server_info
	{
		int id;		//id
		string name;
		string ip;
		int port;
		short prefer_state;	//推荐标示. 0:默认， 1: 新服 2：推荐
		short state;	//服务器状态：0流畅 1繁忙 2爆满 3维护
		string r1;  //保留字段
	};
	-- ]]
	game_server_list = {
		channel_id = 0;--[[服务器渠道ID]]
		notice_url = "";--[[服务器群组信息URL]]
		server_list = {};--[[服务器例表]]
		played_servers = {};--[[建立过角色的例表]]
		played_server_info = {};--[[//有角色的服务器玩家信息]]
	};

	game_server_list_dtree = {};--[[公司DTREE例表]]

	enter_server_id = 0;--[[进入游戏的服务器ID]]

	effect_level = nil;


	------------------------------------[[从URL取回来的动态信息 end]]-----------------------------------------

--	--[[帐号登录后返回的重连token]]
--	relogin_token = "";
--	--[[帐号登录后返回服务器ID]]
--	account_server_id = 0;
};

--[[特效设置等级]]
function systems_data.init_effect_level()
	systems_data.effect_level = nil;
end
function systems_data.set_effect_level(level)
	systems_data.effect_level = level;
end
function systems_data.get_effect_level()
	return systems_data.effect_level;
end

--[[包更新地址]]
function systems_data.init_new_apk_url_list()
	systems_data.new_apk_url_list = nil;
end
function systems_data.set_new_apk_url_list(list)
	systems_data.new_apk_url_list = list;
end
function systems_data.get_new_apk_url_list()
	return systems_data.new_apk_url_list;
end

--[[服务器例表PATH]]
function systems_data.init_auth_server_list_path()
	systems_data.auth_server_list_path = "";
end
function systems_data.set_auth_server_list_path(path)
	systems_data.auth_server_list_path = path;
end
function systems_data.get_auth_server_list_path()
	return systems_data.auth_server_list_path;
end

--[[支付PATH]]
function systems_data.init_auth_server_pay_path()
	systems_data.auth_server_pay_path = "";
end
function systems_data.set_auth_server_pay_path(path)
	systems_data.auth_server_pay_path = path;
end
function systems_data.get_auth_server_pay_path()
	return systems_data.auth_server_pay_path;
end

--[[维护公告PATH]]
function systems_data.init_auth_notice_info_path()
	systems_data.auth_notice_info_path = "";
end
function systems_data.set_auth_notice_info_path(path)
	systems_data.auth_notice_info_path = path;
end
function systems_data.get_auth_notice_info_path()
	return systems_data.auth_notice_info_path;
end

--[[帐号连接PATH]]
function systems_data.init_auth_server_path()
	systems_data.auth_server_path = "";
end
function systems_data.set_auth_server_path(path)
	systems_data.auth_server_path = path;
end
function systems_data.get_auth_server_path()
	return systems_data.auth_server_path;
end

--[[帐号连接URL]]
function systems_data.init_auth_server_list()
	systems_data.auth_server_list = {};
end

--[[DTREE URL]]
function systems_data.init_dtree_server_list()
	systems_data.dtree_server_list = {};
end
function systems_data.set_dtree_server_list(list)
	systems_data.dtree_server_list = list;
end
function systems_data.get_dtree_server_list()
	 return systems_data.dtree_server_list;
end

--[[DTREE PATH]]
function systems_data.init_dtree_server_path()
	systems_data.dtree_server_path = "";
end
function systems_data.set_dtree_server_path(path)
	systems_data.dtree_server_path = path;
end
function systems_data.get_dtree_server_path()
	return systems_data.dtree_server_path;
end

--[[公告列表]]
function systems_data.init_notice_list()
	systems_data.notice_list = {};
end
function systems_data.get_notice_list()
	return systems_data.notice_list;
end
--[[广告列表]]
function systems_data.init_ad_picture_list()
	systems_data.ad_picture_list = {};
end
function systems_data.get_ad_picture_list()
	return systems_data.ad_picture_list;
end
--[[问卷调查]]
function systems_data.init_question_url()
	systems_data.question_url = "";
end
function systems_data.set_question_url(str_url)
	if str_url == nil then return end;
	systems_data.question_url = tostring(str_url);
end
function systems_data.get_question_url()
	 return systems_data.question_url;
end

function systems_data.set_auth_server_list(list)
	systems_data.auth_server_list = list;
end
function systems_data.get_auth_server_list()
	return systems_data.auth_server_list;
end

--[[版本文件PATH]]
function systems_data.init_ver_update_server_list_path()
	systems_data.ver_update_server_list_path = "";
end
function systems_data.set_ver_update_server_list_path(patj)
	systems_data.ver_update_server_list_path = patj;
end
function systems_data.get_ver_update_server_list_path()
	return systems_data.ver_update_server_list_path;
end

--[[版本文件URL LIST]]
function systems_data.init_ver_update_server_list()
	systems_data.ver_update_server_list = {};
end
function systems_data.set_ver_update_server_list(list)
	systems_data.ver_update_server_list = list;
end
function systems_data.get_ver_update_server_list()
	return systems_data.ver_update_server_list;
end

--[[资源地址PATH]]
function systems_data.init_res_update_server_list_path()
	systems_data.res_update_server_list_path = "";
end
function systems_data.set_res_update_server_list_path(path)
	systems_data.res_update_server_list_path = path;
end
function systems_data.get_res_update_server_list_path()
	return systems_data.res_update_server_list_path;
end
--[[资源地址URL]]
function systems_data.init_res_update_server_list()
	systems_data.res_update_server_list = {};
end
function systems_data.set_res_update_server_list(list)
	systems_data.res_update_server_list = list;
end
function systems_data.get_res_update_server_list()
	return systems_data.res_update_server_list;
end

----[[帐号重连token]]
--function systems_data.set_relogin_token(str)
--	if str == nil then return end;
--	systems_data.relogin_token = str;
--end
--function systems_data.get_relogin_token()
--	return systems_data.relogin_token;
--end
--
----[[帐号登录后返回服务器ID]]
--function systems_data.set_account_server_id(id)
--	if id == nil then return end;
--	systems_data.account_server_id = id;
--end
--function systems_data.get_account_server_id()
--	return systems_data.account_server_id;
--end

--[[进入游戏的服务器ID]]
function systems_data.get_enter_server_id()
	return systems_data.enter_server_id;
end
--[[设定进入游戏的服务器ID]]
function systems_data.set_enter_server_id(id)
	if id == nil or id == 0 then return end;
	systems_data.enter_server_id = id;
end


--[[维护公告]]
function systems_data.init_server_notice()
	systems_data.notice_data_list = {};
end
function systems_data.set_server_notice(list)
	systems_data.notice_data_list = list;
end
function systems_data.get_server_notice()
	return systems_data.notice_data_list;
end
--[[得到维护公告]]
function systems_data.get_notice_info(channle_id,server_id)
	if channle_id == nil or server_id == nil then return nil end;
	channle_id = tostring(channle_id);
	server_id = tostring(server_id);

	local temp = systems_data.notice_data_list[channle_id];
	if temp ~= nil then
		if temp[server_id] ~= nil then
			return temp[server_id];
		else
			return temp["common"];
		end
	end
end

------------------------------------------------------自己的服务器例表STR-----------------------------------------------------
--[[GAME服务器例表]]
function systems_data.init_game_server_list()
	systems_data.game_server_list.channel_id = 0;
	systems_data.game_server_list.notice_url = "";
	systems_data.game_server_list.server_list = {};
	systems_data.game_server_list.played_servers = {};
	systems_data.game_server_list.played_server_info = {};
end
function systems_data.set_game_server_list(server_list)
	if server_list == nil then return end;
	systems_data.game_server_list.server_list = server_list;
end
--[[得到GAME服务器例表]]
function systems_data.get_game_server_list()
	return systems_data.game_server_list.server_list;
end
function systems_data.set_played_servers(server_list)
	systems_data.game_server_list.played_servers = server_list;
end
--[[得到建立过角色的服务器例表  老]]
function systems_data.get_played_servers()
	return systems_data.game_server_list.played_servers;
end
function systems_data.set_played_server_info(server_list)
	systems_data.game_server_list.played_server_info = server_list;
end
--[[得到建立过角色的服务器例表  新]]
function systems_data.get_played_server_info()
	return systems_data.game_server_list.played_server_info;
end
--[[通过ID验证服务器信息]]
function systems_data.check_gaeme_server_id(id)
	if id == nil or id == 0 then return false end;
	for k,v in pairs(systems_data.game_server_list.server_list) do
		if tostring(v.id) == tostring(id) then
			return true;
		end
	end
	return false;
end
--[[通过ID得到服务器信息]]
function systems_data.get_game_server_info_id(id)
	if id == nil or id == 0 then return false end;
	for k,v in pairs(systems_data.game_server_list.server_list) do
		if tostring(v.id) == tostring(id) then
			return v;
		end
	end
	return nil;
end

--[[得到一个新的推荐服]]
function systems_data.get_recommend_server()
	local num = table.getn(systems_data.game_server_list.server_list);
	if num <= 0 then return nil end;
	for k,v in pairs(systems_data.game_server_list.server_list) do
		if tostring(v.prefer_state) == tostring(2) then--[[推荐服]]
			return v;
		end
	end
	for k,v in pairs(systems_data.game_server_list.server_list) do
		if tostring(v.prefer_state) == tostring(1) then--[[新服]]
			return v;
		end
	end
	return systems_data.game_server_list.server_list[1];
end

function systems_data.set_game_server_notice(notice_url)
	if notice_url ~= nil and notice_url ~= "" then
		systems_data.game_server_list.notice_url = notice_url;
	end
end
--[[得到公告URL]]
function systems_data.get_game_server_notice()
	return systems_data.game_server_list.notice_url;
end

function systems_data.set_game_server_channel_id(channel_id)
	if channel_id == nil then
		systems_data.game_server_list.channel_id = channel_id;
	end
end
--[[得到渠道ID]]
function systems_data.get_game_server_channel_id()
	return systems_data.game_server_list.channel_id;
end

function systems_data.set_game_server_ret(ret)
	if ret == nil then
		systems_data.game_server_list.ret = ret;
	end
end
--[[得到错误码]]
function systems_data.get_game_server_ret()
	return systems_data.game_server_list.ret;
end

------------------------------------------------------公司DTREE服务器例表STR-----------------------------------------------------

--[[  返回例表样式
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
-- ]]

--[[GAME服务器例表]]
function systems_data.init_game_server_list_dtree()
	systems_data.game_server_list_dtree = {};
end

function systems_data.set_game_server_list_dtree(server_list)
	if server_list == nil then return end;
	systems_data.game_server_list_dtree = server_list;
end

function systems_data.get_game_server_list_dtree()
	return systems_data.game_server_list_dtree;
end

--[[得到服务器信息]]
--[[
-- type 对应 0-正常 1-爆满 2-拥挤
state 对应 0:空闲 1:繁忙 2:爆满 3:维护 4:没开服 5:白名单
-- ]]

function systems_data.get_dtree_server_info(server_id)
	for k,v in pairs(systems_data.game_server_list_dtree) do
		if tostring(v.server_id) == tostring(server_id) then
			return v;
		end
	end
	return nil;
end

--[[检查服务器状态 目前只判断维护]]
function  systems_data.check_dtree_server_state(server_id)
	for k,v in pairs(systems_data.game_server_list_dtree) do
		if tostring(v.server_id) == tostring(server_id) and v.state == 3 then
			return true;
		end
	end
	return false;
end

--[[通过服务器随机一个代理]]
function systems_data.get_dtree_random_port_server(server_id)

	if server_id == nil then return nil end;
	for k,v in pairs(systems_data.game_server_list_dtree) do
		if tostring(v.server_id) == tostring(server_id) then
			local t_num = table.getn(v.pro_list);
			if t_num <= 0 then
				return nil;
			else
				local random_num = math.random(1, t_num);
				random_num = math.random(1, t_num);
				return v.pro_list[random_num];
			end
		end
	end
	return nil;
end

--[[得到一个在线的服务器的全套信息 推荐]]
function systems_data.get_dtree_recommend_server()
	--[[有代理的服务器]]
	for k,v in pairs(systems_data.game_server_list_dtree) do
		local t_num = table.getn(v.pro_list);
		if t_num > 0 then
			return v;
		end
	end
	--[[没有代理的服务器]]
	for k,v in pairs(systems_data.game_server_list_dtree) do
		return v;
	end

	return nil;
end


