--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/10/28
-- Time: 12:26
-- To change this template use File | Settings | File Templates.
--

UserCenter = {
	call_back = nil;--[[处理成功后回调]]
	check_login = nil;--[[处理成功后回调]]

	--[[内部初始化]]
	accountid = 0;
	token = 0;

	--[[外部传过来的明文信息]]
	login_str = "ghoul";--[[登陆时传入到JAR的参数：qq,wx，用于腾讯登陆判断]]
	user_name = "";--[[本地帐号]]
	use_account_url = "";--[[当前使用的帐号验证URL]]
	used_account_urllist = {};--[[帐号验证使用过的例表]]
	use_account_url_max_num = 5;--[[每个URL使用次数]]

	--[[登录成功后信息]]
	accountid = "";
	token = "";
	is_realname = -1;--[[-1未请求 0-已实名认证  1-未实名认证]]
	exten_val = "";--[[自定义JSON串，应用宝会传很重要的数据回来]]
	login_json = "";--[[SDK登陆传回来的完整JSON]]
	login_json_lua = nil;--[[SDK登陆传回来的完整JSON转LUA]]
	login_json_lua_ext = nil;--[[SDK登陆传回来的完整JSON转LUA]]
	realname_call_back = nil;--[[实名认证回调]]
	web_realname = -1;--[[WEB版实名认证：-1未请求 0已实名认证 1未实名认证]]
	login_times = 0;--[[登录次数，判断是不是第一次]]
	account_request_type = 0;-- 1 设备， 2： 手机 ， 3 邮箱 4.普通帐号

	is_ok = false;--[[帐号中心是否已经初始化过]]
	is_sdk_useing = false;--[[SDK是否在使用，同时只能使用一次]]
	is_sdk_login = false;--[[是不是SDK自己主动回调的]]

	--[[购买商品]]
	buy_is_useing = false;--[[是否在使用支付]]
	buy_index = 0;--[[商品index]]
	buy_id = "";--[[商品ID]]
	buy_num = "";--[[商品数量]]
	buy_price = 0;--[[支付金额 人民币]]
	buy_name = "";--[[商名]]
	buy_discount = "";--[[描述]]
	buy_order_id = "";--[[支付单号]]
	buy_order_json_str = "";--[[申请支付时，某些渠道多余的参数]]
	buy_order_json = nil;--[[申请支付时，某些渠道多余的参数]]
	buy_call_back = nil;--[[支付回调]]
	buy_pay_type = -1;--[[支付类型]]

	is_useing_share = false;--[[只能一个一个的分享]]
	share_type_sdk = nil;--[[分享类型1微信好友 2朋友圈 3微博]]
	share_type_list = nil;--[[分享类型1web 2photo]]
	share_is_capture = false;--[[是否需要截屏]]
	share_img_path = "";--[[图片PATH，不截图使用传进来的图片地址]]
	share_url = "";--[[WEB url]]
	share_title = "";--[[tile 必需要有]]
	share_desc = "";--[[desc 必需要有]]
	share_call_back = nil;--[[分享回调]]

	get_player_info_timerId = nil; --[[获取玩家信息timer]]
	player_info_list = {};        --[[玩家信息列表]]
	player_file_accountid = "paccountid.data";  --[[本地上次登录成功accountid]]
};

--------------------------------------------对外接口-----------------------------------------------------
--[[设定登陆str]]
function UserCenter.set_login_str(str)
	UserCenter.login_str = str;
end

--[[得到登陆str]]
function UserCenter.get_login_str()
	return UserCenter.login_str;
end

--[[得到明文帐号]]
function UserCenter.get_user_name()
	return UserCenter.user_name;
end

--[[accountid是否有效，是否需要重新登陆]]
function UserCenter.check_is_ok()
	return UserCenter.is_ok;
end

--[[得到帐号登录成功后的accountid]]
function UserCenter.get_accountid()
	return "001";
end
--[[得到帐号登录成功后的TOKEN]]
function UserCenter.get_accessToken()
	return "000";
end
--[[得到实名认证结果  -1未请求 0-已实名认证  1-未实名认证]]
function UserCenter.get_is_realname()
	return 0;
end

--[[SDK帐号是否有手机]]
function UserCenter.get_sdk_user_type()
	--[[
	--1	username注册
2	username注册并绑定激活了email
3	username注册并绑定了手机
4	username注册并绑定激活了email，并绑定了手机
5	devid注册
6	devid注册并绑定激活了email
7	devid注册并绑定了手机
8	devid注册并绑定激活了email，并绑定了手机
9	email注册
10	email注册，并激活
11	email注册并绑定了手机
12	email注册，并激活，并绑定了手机
13	3方注册
14	3方注册，并绑定激活了email
15	3方注册，并绑定了手机
16	3方注册并绑定激活了email，并绑定了手机
17	手机号注册
18	手机号注册并绑定激活了email
	-- ]]
	local temp = false;
	app.log("UserCenter.login_json_lua_ext>>> "..table.tostring(UserCenter.login_json_lua_ext));
	if UserCenter.login_json_lua_ext == nil then
		temp = false;
	else
		if UserCenter.login_json_lua_ext.state == 3 or UserCenter.login_json_lua_ext.state == 4 or
				UserCenter.login_json_lua_ext.state == 7 or UserCenter.login_json_lua_ext.state == 8 or
				UserCenter.login_json_lua_ext.state == 11 or UserCenter.login_json_lua_ext.state == 12 or
				UserCenter.login_json_lua_ext.state == 15 or UserCenter.login_json_lua_ext.state == 16 or UserCenter.login_json_lua_ext.state == 17 then
			temp = true;
		else
			temp = false;
		end
	end
	return temp;
end

--[[得到帐号登录成功后的type:-- 帐号的类型 -- 1 设备， 2： 手机 ， 3 邮箱 4. 第三方 5.昵称帐号 ]]
function UserCenter.get_account_type()
	return UserCenter.account_request_type;
end

--[[打开用户中心]]
function UserCenter.open_user_center()
	app.log("user center >>> open");
--	if AppConfig.get_check_official() then
--		--[[游戏内界面]]
--	else
		user_center.open_user_center(1);
--	end
end

--[[打开客服中心]]
function UserCenter.open_user_center_kefu()
	app.log("user center open >>> kufu");
--	if AppConfig.get_check_official() then
--		--[[游戏内界面]]
--	else
		user_center.open_user_center(4);
--	end
end

--[[切换帐号]]
function UserCenter.switch_account()
	app.log("user center >>> switch");
--	if AppConfig.get_check_official() then
--		--[[游戏内界面]]
--	else
		user_center.switch_account();
--	end
end

--[[得到WEB版实名认证信息]]
function UserCenter.get_web_realname()
	return UserCenter.web_realname;
end

--[[得到帐号URL]]
function UserCenter.fileter_account_url()
	local url_list = AppConfig.get_account_url();
	app.log("url_list="..#url_list);
	for i=1,table.getn(url_list) do
		app.log("筛选帐号验证服URL="..url_list[i]);
		local used_index = 0;
		--[[查看有没有使用过]]
		for j=1,table.getn(UserCenter.used_account_urllist) do
			local temp = UserCenter.used_account_urllist[j];
			if temp.url == url_list[i] then
				used_index = j;
				break;
			end
		end

		if used_index ~= 0 then
			--[[使用过 次数还可以用]]
			app.log("使用过="..UserCenter.used_account_urllist[used_index].num);
			if UserCenter.used_account_urllist[used_index].num < UserCenter.use_account_url_max_num then
				UserCenter.used_account_urllist[used_index].num = UserCenter.used_account_urllist[used_index].num + 1;
				app.log("url_list="..url_list[i]);
				UserCenter.use_account_url = url_list[i];--[[取一个URL]]
				app.log("UserCenter.use_account_url="..UserCenter.use_account_url);
				return url_list[i];
			end
		else
			--[[没有使用过]]
			app.log("没有使用过");
			local inset_table = {};
			inset_table.url = url_list[i];
			inset_table.num = 1;
			table.insert(UserCenter.used_account_urllist,inset_table);
			app.log("url_list="..url_list[i]);
			UserCenter.use_account_url = url_list[i];--[[取一个URL]]
			app.log("UserCenter.use_account_url="..UserCenter.use_account_url);
			return url_list[i];
		end

	end

	--[[没有URL]]
	UserCenter.use_account_url = "";--[[取一个URL]]
	return "";
end

--[[重置成功URL的重试次数]]
function UserCenter.reset_used_account_url_num()
	for i=1,table.getn(UserCenter.used_account_urllist) do
		local temp = UserCenter.used_account_urllist[i];
		if temp.url == UserCenter.use_account_url then
			UserCenter.used_account_urllist[i].num = 0;
			return;
		end
	end
end

--[[提交第三方SDK需要提供的信息]]
function UserCenter.get_sdk_push_info(event_name)
	if g_dataCenter then
		if g_dataCenter.player then
			local table_info = {};
			table_info.roleId = g_dataCenter.player.playerid;
			table_info.roleName = g_dataCenter.player.name;
			table_info.roleLevel = g_dataCenter.player.level;
			table_info.zoneId = systems_data.get_enter_server_id();
			table_info.vipLevel = g_dataCenter.player.vip;

			local server_info = nil;
			if systems_data then
				server_info = systems_data.get_dtree_server_info(systems_data.get_enter_server_id());
			end
			if server_info ~= nil then
				table_info.zoneName = server_info.name;--[[]]
			else
				table_info.zoneName = "";--[[]]
			end

			if g_dataCenter.guild then
				table_info.partyName = g_dataCenter.guild:GetMyGuildName();
			end

			table_info.balance = g_dataCenter.player.gold;
			if event_name ~= nil then
				table_info.type = tostring(event_name);
			end
			UserCenter.submit_extend_info(table_info);
		end
	end
end

--[[初始化]]
function UserCenter.init_user_center(call_back)
	app.log("user center init digisky");
	UserCenter.call_back = call_back;

	--[[如果已经成功登陆过了就直接返回]]
	if UserCenter.check_is_ok() then
		if type(UserCenter.call_back) == "function" then
			UserCenter.call_back();
			UserCenter.call_back = nil;
		end
		do return end;
	end

	Root.push_web_info("sys_023","平台帐号登录开始,init_user_center");

	--[[第三方登陆]]
	if Root.get_os_type() == 11 or Root.get_os_type() == 8 then
		--[[第三方SDK]]
		--[[初始化SDK登录URL，虽然SDK可以写死，但还是使用动态解析出来的URL]]
		local table_info = {};
--		table_info.change_login_url = UserCenter.use_account_url..AppConfig.get_account_login_path();--[[修改登录地址]]
--		table_info.change_pay_url = UserCenter.use_account_url..AppConfig.get_account_server_pay_path();--[[修改支付地址]]
		--[[系统必要信息]]
		local need_info = UserCenter.get_need_info();
		local json_info = pjson.encode(need_info);
		table_info.custom = json_info;--[[自定义串]]

		--[[只开手机注册]]
		table_info.type = "addInfo";--[[只开手机注册]]
		local addInfo = {};
		addInfo.enable_tehphone_tab = "true";
		if AppConfig.get_enable_reg_mail() then
			addInfo.enable_email_tab = "true";
		else
			addInfo.enable_email_tab = "false";
		end
		addInfo.hide_guest = "true";
		table_info.ext = addInfo;--[[只开手机注册]]

		UserCenter.submit_extend_info(table_info);

		user_center.init_user_center(AppConfig.get_app_id(),AppConfig.get_user_center_key());--[[用户中心初始化]]
		user_center.set_login_listener("UserCenter.on_login");--[[登录回调]]
		user_center.set_logout_listener("UserCenter.on_logout");--[[等出回调]]
		user_center.set_payment_listener("UserCenter.on_payment");--[[支付回调]]

		user_center.set_wechatshare_listener("UserCenter.on_wechatshare");--[[微信SHARE]]
		user_center.set_wechatpay_listener("UserCenter.on_wechatpay");--[[微信支付]]

		user_center.set_weiboshare_listener("UserCenter.on_weiboshare");--[[微博SHARE]]

		app.log("平台SDK帐号登陆");
		--[[腾讯处理]]
		if AppConfig.get_check_tencent() then
			app.log("tencent sdk login");
			--[[显示腾讯登陆UI]]
			script.run("logic/systems/login/login_tencent_login.lua");
			LoginTencentLogin.LoadAsset(UserCenter.sdk_login);
		else
			--[[平台SDK帐号登陆]]
			UserCenter.sdk_login();
		end

	else
		app.log("本机登陆");
		UserCenter.accountid = AppConfig.get_deviceuniqueidentifier();
		UserCenter.token = AppConfig.get_deviceuniqueidentifier();

		--[[登录UI显示完成后处理]]
		if type(UserCenter.call_back) == "function" then
			UserCenter.call_back();
			UserCenter.call_back = nil;
		end

	end
end

--[[平台帐登陆]]
function UserCenter.sdk_login()

	--[[公司日志：游戏启动信息]]
	SystemLog.AppStartClose(500000002);

	if not UserCenter.is_sdk_useing then
		UserCenter.is_sdk_useing = true;
		app.log("UserCenter.sdk_login="..UserCenter.login_str);
		--[[腾讯处理]]
		if AppConfig.get_check_tencent() then
			--[[判断参数是不是checklogin]]
			local x,y = string.find(UserCenter.login_str,"checkLogin");
			if x ~= nil or y ~= nil then
				app.log("@@@>checkLogin");
				UserCenter.sdk_login_goon("checkLogin");
			else
				app.log("@@@>"..UserCenter.login_str);
				UserCenter.sdk_login_goon(UserCenter.login_str);
			end
		else
			UserCenter.sdk_login_goon(UserCenter.login_str);
		end
	end
end
function UserCenter.sdk_login_goon(login_str)
	app.log("UserCenter.sdk_login_goon>>"..tostring(UserCenter.is_sdk_login));
	UserCenter.is_sdk_login = false;--[[是正常流程]]
	user_center.login(login_str);
end

--[[平台帐号陆出]]
function UserCenter.sdk_logout()
	app.log("UserCenter.is_sdk_useing"..tostring(UserCenter.is_sdk_useing))

	if not UserCenter.is_ok then
		app.log("UserCenter.is_ok>>>"..tostring(UserCenter.is_ok));
		do return end;
	end

	if not UserCenter.is_sdk_useing then
		UserCenter.is_sdk_useing = true;
		UserCenter.login_str = "";
		LoginTencentLogin.set_txt("");
		user_center.logout();
	end
end


--[[购买商品 单位为分]]
function UserCenter.pay(index, id, num, price, name, discount, call_back)
	--[[UserCenter.pay ---->index=1,id=3,num=6480,price=648,name=6480钻石,discount=100]]
	app.log("UserCenter.pay ---->index="..index..",id="..id..",num="..num..",price="..price..",name="..name..",discount="..discount);

	--[[不能为空信息]]
	if index == nil or index == "" then
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "index为空",
			{str = "确认", func = Root.empty_func}
		);
		return;
	end

	if id == nil or id == "" then
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "id为空",
			{str = "确认", func = Root.empty_func}
		);
		return;
	end

	if num == nil or num == "" or num == 0 then
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "数量为空",
			{str = "确认", func = Root.empty_func}
		);
		return;
	end

	if tonumber(price) == nil or price == 0 then
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "价格为空",
			{str = "确认", func = Root.empty_func}
		);
		return;
	end

	if discount == nil or discount == "" then
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "描述为空",
			{str = "确认", func = Root.empty_func}
		);
		return;
	end

--	app.log("type(call_back)="..type(call_back));
--	if type(call_back) ~= "function" then
--		SystemHintUI.SetAndShow(ESystemHintUIType.one, "回调错误",
--			{str = "确认", func = Root.empty_func}
--		);
--		return;
--	end

	UserCenter.buy_index = index;--[[这是项目自己的购买ID，因为各渠道ID不一样，又要混服，所以需要把这个ID拿去转为正的product id,这才是运营在后台配置的对应ID]]
	UserCenter.product_id = id; --[[策划使用ID，与支付无管]]
	UserCenter.buy_num = num;
	UserCenter.buy_price = price;
	UserCenter.buy_name = name;
	UserCenter.buy_discount = discount;
	UserCenter.buy_call_back = call_back;


	--[[如果是官网的话就要选支付宝OR微信]]
	if AppConfig.get_check_digisky_channel() then
		--[[使用单独的UI 为了好看]]
		SystemHintUI_pay.str(
			"支",
			"付",
			"请选择支付类型！",
			{str = "支付宝", func = UserCenter.pay_digisky_ali},
			{str = "微信", func = UserCenter.pay_digisky_wx},
			Root.empty_func
			);
	else
		UserCenter.pay_goon();
	end
end
function UserCenter.pay_digisky_ali()
	UserCenter.pay_goon(11);
end
function UserCenter.pay_digisky_wx()
	UserCenter.pay_goon(16);
end
function UserCenter.pay_goon(n_pay_type)
	--[[只能在手机上面测试]]

	if Root.get_os_type() == 8 or Root.get_os_type() == 11 then
		if UserCenter.buy_is_useing then
			--		SystemHintUI.SetAndShow(ESystemHintUIType.one, "已经申请支付中....",
			--			{str = "确认", func = Root.empty_func}
			--		);
		end
		UserCenter.buy_is_useing = true;


		--[[是不是公司平台SDK IOS]]
		if AppConfig.get_check_digisky() and Root.get_os_type() == 8 then
			--[[IOS]]
			iap.buy(UserCenter.buy_index_to_product(UserCenter.buy_index));
		else
			--[[第三方安卓通用]]

			--[[新加公司安卓数据块：现在安卓只开通支付宝与联运，易联支付暂时不加]]
			--[[//10-充值卡支付  11-支付宝支付  12-appstore支付   13-google支付  14-联运   15-易联支付 16-官网微信]]
			UserCenter.buy_pay_type = -1;
			if n_pay_type == nil then
				UserCenter.buy_pay_type = AppConfig.get_pay_type();
			else
				UserCenter.buy_pay_type = n_pay_type;
			end

			local temp_digisky_payinfo = UserCenter.get_digisky_payinfo(UserCenter.buy_pay_type);

			--[[向服务器发送请求，返回定单号,这里不转换buy_index]]
			msg_store.cg_buy_store_goods(UserCenter.buy_index, UserCenter.product_id, UserCenter.buy_num, UserCenter.buy_price, UserCenter.buy_discount,
				temp_digisky_payinfo.appId,
				temp_digisky_payinfo.serverId,
				temp_digisky_payinfo.accountId,
				temp_digisky_payinfo.charId,
				temp_digisky_payinfo.payType,
				temp_digisky_payinfo.secondType,
				temp_digisky_payinfo.bill,
				temp_digisky_payinfo.ext);
		end

	else
		SystemHintUI.SetAndShow(ESystemHintUIType.one, "请在手机上面支付！",
			{str = "确认", func = Root.empty_func}
		);
	end
end

--[[公司IOS支付接口]]
function UserCenter.digisky_ios_pay_goon(productId,ios_identifier,ios_key,receipt)
	app.log("UserCenter.digisky_ios_pay_goon productId="..productId..",ios_identifier="..ios_identifier..",ios_key="..ios_key..",receipt="..receipt);
	--[[通过物品名反推物品信息，再给服务器]]
	if g_dataCenter then
--		app.log("1");
		if g_dataCenter.store then
			local temp_storelist = g_dataCenter.store:GetStoreList();--[[商城LIST]]
--			app.log("2>"..table.tostring(temp_storelist));
			for k,v in ipairs(temp_storelist) do
				local temp_name = tostring("com.digitalsky.ghoul.cn.gold_"..v.index);
				if tostring(productId) == temp_name then
--					app.log("3"..productId);
					if AppConfig.get_check_digisky() then
						local temp_digisky_payinfo = UserCenter.get_digisky_payinfo(12,0,tostring(ios_identifier), tostring(receipt));
						temp_digisky_payinfo.ext = tostring(ios_key).."|"..tostring(ios_identifier);--[[IOS用于透传ID与KEY，发货成功后返回客户端消耗订单]]
						app.log("ext="..temp_digisky_payinfo.ext);
						--[[向服务器发送请求，返回定单号,这里不转换buy_index]]
						msg_store.cg_buy_store_goods(v.index, v.id, v.num, v.price, v.discount,
							temp_digisky_payinfo.appId,
							temp_digisky_payinfo.serverId,
							temp_digisky_payinfo.accountId,
							temp_digisky_payinfo.charId,
							temp_digisky_payinfo.payType,
							temp_digisky_payinfo.secondType,
							temp_digisky_payinfo.bill,
							temp_digisky_payinfo.ext);
					end
				end
			end
		end
	end
end

--------------------------------------------------内部方法 atr--------------------------------------------------
--[[商口product id转换]]
function UserCenter.buy_index_to_product(buy_index)
	local retun_index = buy_index;
	if g_dataCenter then
		if g_dataCenter.store then
			local temp = g_dataCenter.store:GetStoreList();--[[商城LIST]]

--			app.log("buy_index_to_product  g_dataCenter.store>>>"..table.tostring(temp));

			local platformchannel_id = AppConfig.get_platformchannel_id();
			local channel_item_info = {}; --[[渠道转换]]

			--[[先要得到当前INDEX对像的LIST，里面只有一条信息，]]
			for k,v in ipairs(temp) do
				if tostring(v.index) == tostring(buy_index) then
					channel_item_info = v.channel_item_info;
					break;
				end
			end

			--[[查找转换ID]]
			for k,v in ipairs (channel_item_info) do
				if tostring(v.channel_id) == tostring(platformchannel_id) then
					retun_index = v.item_id;
					break;
				end
			end

		end
	end

	app.log("UserCenter.buy_index_to_product, buy_index:"..tostring(buy_index).."retun_index="..tostring(retun_index));

	return retun_index;
end


--[[传输数据封装]]
function UserCenter.pack(table_info)
	if type(table_info) == "table" then
		return pjson.encode(table_info);
	else
		return nil;
	end
end
--[[传输数据解包]]
function UserCenter.unpack(json_str)
	if json_str == nil or json_str == "" then return nil end;
	return pjson.decode(json_str);
end

--[[WEB PUSH必要信息]]
function UserCenter.get_need_info()
	local temp = {};
	temp.u3d_device_id = AppConfig.get_deviceuniqueidentifier();
	temp.ver_flag = AppConfig.get_package_version();
	temp.channel_id = AppConfig.get_platformchannel_id();
	temp.android_id = app.get_device_info_by_key("android_id");
	temp.idfa = app.get_device_info_by_key("idfa");
	temp.mac = app.get_device_info_by_key("mac");
	temp.package_id = AppConfig.get_package_id();

	if temp.u3d_device_id == nil or temp.u3d_device_id == "" then
		temp.u3d_device_id = "0000";
	end
	if temp.ver_flag == nil or temp.ver_flag == "" then
		temp.ver_flag = "0000";
	end
	if temp.channel_id == nil or temp.channel_id == "" then
		temp.channel_id = "0000";
	end
	if temp.android_id == nil or temp.android_id == "" then
		temp.android_id = "";
	end
	if temp.idfa == nil or temp.idfa == "" then
		temp.idfa = "";
	end
	if temp.mac == nil or temp.mac == "" then
		temp.mac = "0000";
	else
		temp.mac = string.lower(temp.mac);
		temp.mac = string.gsub(temp.mac, ":","");
	end
	if temp.package_id == nil or temp.package_id == "" then
		temp.package_id = "0000";
	end

	return temp;

end

--[[公司支付信息
-- pay_type://10-充值卡支付  11-支付宝支付  12-appstore支付   13-google支付  14-联运   15-易联支付  16-官网微信
-- ios_type:sandbox=1沙盒测试，sandbox=0正式环境
-- ]]
function UserCenter.get_digisky_payinfo(pay_type,ios_sandbox_type,ios_identifier, ios_receiptData)
	local temp_table = {};
	temp_table.appId = AppConfig.get_app_id();
	temp_table.serverId = AppConfig.get_digisky_game_id();--[[服务器要更新这个值，以服务器值为准]]
	temp_table.accountId = UserCenter.get_accountid();
	temp_table.charId = AppConfig.get_child_ID();

	--[[//10-充值卡支付  11-支付宝支付  12-appstore支付   13-google支付  14-联运   15-易联支付  16-官网微信]]
	temp_table.payType = pay_type;
	--[[payType=10时，secondType的值(3-神州付移动，4-神州付联通，8-神州付电信)]]
	temp_table.secondType = tonumber(AppConfig.get_platformchannel_id());--[[就是渠道ID]]

	temp_table.bill = "";

	if temp_table.payType == 15 then
		local temp = {};
		temp.amount = tostring(UserCenter.buy_price / 100);--[[分转元]]
		temp_table.bill = pjson.encode(temp);
	elseif temp_table.payType == 12 then
		local ios_temp = {};
		ios_temp.identifier = tostring(ios_identifier);--[[交易单据号]]
		ios_temp.receiptData = tostring(ios_receiptData);--[[交易收据]]
--		ios_temp.sandbox = ios_sandbox_type;--[[sandbox=1沙盒测试，sandbox=0正式环境    公司平台没有要这个]]
--		temp_table.bill = pjson.encode(ios_temp);
		temp_table.bill = "{\"identifier\":\""..ios_temp.identifier.."\",\"receiptData\":\""..ios_temp.receiptData.."\"}";
	elseif temp_table.payType == 13 then
		local temp = {};
		temp.signature = "";
		temp.purchase = "";
		temp_table.bill = pjson.encode(temp);
	elseif temp_table.payType == 16 then
		local temp = {};
		temp.body = tostring(UserCenter.buy_discount);
		temp.total_fee = tostring(UserCenter.buy_price);--[[单位：分]]
--		temp_table.bill = pjson.encode(temp);
		temp_table.bill = "{\"body\":\""..temp.body.."\",\"total_fee\":\""..temp.total_fee.."\"}";
	elseif temp_table.payType == 14 then
		--[[vivo]]
		if temp_table.secondType == 10034 then
			local temp = {};
			temp.orderAmount = UserCenter.buy_price;--[[特例单位：分]]
			temp.orderTitle = "ghoul "..(UserCenter.buy_price / 100).." rmb";
			temp.thirdpartyNotifyUrl = "http://business.ppgame.com/thirdparty_receiver/"..temp_table.secondType.."/"..AppConfig.get_app_id();
--			temp_table.bill = pjson.encode(temp);
			temp_table.bill = "{\"orderAmount\":"..temp.orderAmount..",\"orderTitle\":\""..temp.orderTitle.."\",\"thirdpartyNotifyUrl\":\""..temp.thirdpartyNotifyUrl.."\"}";
		end

		--[[金立]]
		if temp_table.secondType == 10032 then
			local temp = {};
			if UserCenter.exten_val ~= nil and UserCenter.exten_val ~= "" then
				local temp_jsop = pjson.decode(UserCenter.exten_val);
				temp.playerId = temp_jsop.amigo_playerId;
				temp.subject = "ghoul "..tostring(UserCenter.buy_price /100).." rmb";
				temp.thirdpartyNotifyUrl = "http://business.ppgame.com/thirdparty_receiver/"..temp_table.secondType.."/"..AppConfig.get_app_id();
				temp.totalFee = tostring(UserCenter.buy_price / 100);--[[分转元]]
				temp.userId = temp_jsop.amigo_userId;
--				temp_table.bill = pjson.encode(temp);
				temp_table.bill = "{\"playerId\":\""..temp_jsop.amigo_playerId.."\",\"subject\":\""..temp.subject.."\",\"thirdpartyNotifyUrl\":\""..temp.thirdpartyNotifyUrl.."\",\"totalFee\":\""..temp.totalFee.."\",\"userId\":\""..temp.userId.."\"}";
			end

		end

		--[[ali(UC)]]
		if temp_table.secondType == 10002 then
			if UserCenter.exten_val ~= nil and UserCenter.exten_val ~= "" then
				local temp_jsop = pjson.decode(UserCenter.exten_val);
				local temp = {};
				temp.amount = tostring(UserCenter.buy_price / 100);
				temp.accountId = tostring(temp_jsop.ali_accountId);
--				temp_table.bill = pjson.encode(temp);
				temp_table.bill = "{\"accountId\":\""..temp.accountId.."\",\"amount\":\""..temp.amount.."\"}";
			end
		end

		--[[coolpad]]
		if temp_table.secondType == 10033 then
			if UserCenter.exten_val ~= nil and UserCenter.exten_val ~= "" then
				local temp_jsop = pjson.decode(UserCenter.exten_val);
				local temp = {};
				temp.secondType = 10033;
				temp_table.bill = pjson.encode(temp);
			end
		end

		--[[flyme]]
		if temp_table.secondType == 10041 then
			if UserCenter.exten_val ~= nil and UserCenter.exten_val ~= "" then
				local temp_jsop = pjson.decode(UserCenter.exten_val);
				local temp = {};

				if UserCenter.login_json_lua ~= nil then
					temp.uid = tostring(temp_jsop.flyme_uid);--[[//登录返回flyme_uid]]
				end
				temp.product_id = tostring(UserCenter.buy_index_to_product(UserCenter.buy_index));--[[//CP游戏道具ID ，默认值： ”0”]]
				temp.product_subject = "ghoul"..UserCenter.buy_num.."g";--[[//订单标题]]
				temp.product_body = "";--[[//游戏道具说明，默认值： ””]]
				temp.product_unit = "";--[[//道具的单位，默认值： ””]]
				temp.buy_amount = "1";--[[//道具购买的数量，默认值： ”1”]]
				temp.product_per_price = tostring(UserCenter.buy_price / 100);--[[分转元]]--[[//游戏道具单价，默认值：总金额 元]]
				temp.total_price = tostring(UserCenter.buy_price / 100);--[[分转元]]--[[//总金额 元]]
				temp.pay_type = "0";--[[//支付方式，默认值： ”0”（即定额支付）]]
--				temp_table.bill = pjson.encode(temp);
				temp_table.bill = "{\"buy_amount\":\""..temp.buy_amount.."\",\"pay_type\":\""..temp.pay_type.."\",\"product_body\":\""..temp.product_body.."\",\"product_id\":\""..temp.product_id.."\",\"product_per_price\":\""..temp.product_per_price.."\",\"product_subject\":\""..temp.product_subject.."\",\"product_unit\":\""..temp.product_unit.."\",\"total_price\":\""..temp.total_price.."\",\"uid\":\""..temp.uid.."\"}";
			end
		end
	end

	temp_table.ext = tostring(UserCenter.exten_val);

	return temp_table;
end




--[[腾讯私有：充值上次]]
function UserCenter.r_pay_id_call_back()
--	--[[自定义JSON串]]
--	local table_info = {};
--	table_info.order_id = UserCenter.buy_order_id;
--	table_info.product_id = UserCenter.product_id;
--	local json_str = pjson.encode(table_info);
--	--[[第三方支付]]
--	UserCenter.payment(UserCenter.buy_price,UserCenter.product_id,UserCenter.buy_name,systems_data.get_enter_server_id(),Root.get_player_id(),Root.get_account_id(),json_str);
end

--[[支付ID回调]]
function UserCenter.pay_id_call_back(buy_order_id,buy_order_json_str)
	app.log("UserCenter.pay_id_call_back ="..buy_order_id);
	app.log("buy_order_json_str ="..buy_order_json_str);
	if buy_order_id == nil or buy_order_id == "" then return end;
	UserCenter.buy_order_id = buy_order_id;
	UserCenter.buy_order_json_str = buy_order_json_str;
	if UserCenter.buy_order_json_str ~= nil and UserCenter.buy_order_json_str ~= "" then
		UserCenter.buy_order_json = pjson.decode(buy_order_json_str);
		app.log("UserCenter.buy_order_json="..table.tostring(UserCenter.buy_order_json));
	end


	--[[IOS直接PASS]]
	if AppConfig.get_check_digisky() and Root.get_os_type() == 8 then
		app.log("公司支付，IOS得到支付ID后直接PASS! id="..buy_order_id..",buy_order_json_str="..buy_order_json_str);
		do return end;
	end


--	--[[官网 自己的支付，并且不使用公司的SDK]]
--	if AppConfig.get_check_official() and not AppConfig.get_check_digisky() then
--		app.log("官网");
--		if AppConfig.get_check_appstore()  then
--			app.log("官网IOS="..UserCenter.buy_index_to_product(UserCenter.buy_index));
--			--[[IOS]]
--			iap.buy(UserCenter.buy_index_to_product(UserCenter.buy_index));
--		else
--			app.log("官网android");
--			--[[安卓官网支付宝支付]]
--			UserCenter.alipay_pay(UserCenter.buy_price, UserCenter.buy_name, UserCenter.buy_discount, UserCenter.buy_order_id, UserCenter.buy_call_back);
--		end
--	else
		app.log("第三方SDK支付");
		--[[腾讯：充值后就扣完，所以不需要特别处理了]]
--		if AppConfig.get_check_tencent() then
--			app.log("QQ PAY="..UserCenter.buy_price.."="..UserCenter.buy_order_id);
--			--[[腾讯扣款 amt：金额，不能为0, order_id：自定义订单号]]
--			UserCenter.tencent_pay(UserCenter.buy_price,UserCenter.buy_order_id);
--		else
			--[[自定义JSON串]]
			local table_info = {};
			table_info.order_id = UserCenter.buy_order_id;--[[老SDK]]
			table_info.product_id = UserCenter.buy_index_to_product(UserCenter.buy_index);--[[老SDK]]

			---------------------新的SDK-------------------------
			if AppConfig.get_check_tencent() then--[[腾讯处理微信与QQ]]
				table_info.paytype = UserCenter.login_str;
			else
				table_info.paytype = "";
			end

			table_info.money = tonumber(UserCenter.buy_price / 100); --[[公司SDK单位：元]]
			table_info.productId = UserCenter.buy_index_to_product(UserCenter.buy_index);--[[这需要使用运营后台的ID]]
			table_info.productName = UserCenter.buy_name;--[[]]
			table_info.productDesc = UserCenter.buy_name;--[[]]
			table_info.rate = tonumber(10);--[[转换比，像QQ是1:10]]
			table_info.roleId = Root.get_player_id();--[[]]
			table_info.roleName = Root.get_player_name();--[[]]
			table_info.roleLevel = tostring(g_dataCenter.player.level);--[[]]
			table_info.zoneId = systems_data.get_enter_server_id();--[[QQ的话，服务器ID必需是YSDK后面配的ID]]

			local server_info = systems_data.get_dtree_server_info(systems_data.get_enter_server_id());
			if server_info ~= nil then
				table_info.zoneName = server_info.name;--[[]]
			else
				table_info.zoneName = "";--[[]]
			end

			table_info.balance = 1;--[[余额,暂时没有强制要求]]
			table_info.partyName = tostring(g_dataCenter.player.groupid);--[[]]
			table_info.vipLevel = tostring(g_dataCenter.player.level);--[[]]
			table_info.orderId = UserCenter.buy_order_id;--[[]]

			table_info.channel = "";
			if AppConfig.get_check_digisky_channel() then
				--[[官网支付宝11 微信16]]
				table_info.channel = tostring(UserCenter.buy_pay_type);--[[ 得到支付渠道ID ]]
			else
--				table_info.channel = AppConfig.get_platformchannel_id();--[[第三方渠道在SDK中写的有，不需要传]]
				table_info.channel = "";--[[第三方渠道在SDK中写的有，不需要传]]
			end

			app.log("table_info.channel>"..tostring(table_info.channel));

			table_info.orderChannel = tostring(UserCenter.buy_order_json_str);--[[服务器传回来的值]]
			local json_str = pjson.encode(table_info);

			--[[官网微信支付新接口]]
			if AppConfig.get_check_digisky_channel() and UserCenter.buy_pay_type == 16 then
				--[[是否安有微信]]
				app.log("wx pay!!!");
				if UserCenter.wechat_check() then
					--[[微信支付]]
					app.log("json_str>"..UserCenter.buy_order_json_str);
					user_center.wechat_pay(UserCenter.buy_order_json_str);
				else
					--[[没有微信]]
					SystemHintUI.SetAndShow(ESystemHintUIType.one, "请安装微信！",
						{str = "确认", func = Root.empty_func}
					);
				end
			else
				app.log("3d pay!!!");--[[支付宝是自带了的，不需要检查，第三方SDK也直接调用]]
				--[[第三方支付]]
				UserCenter.payment(UserCenter.buy_price,UserCenter.product_id,UserCenter.buy_name,systems_data.get_enter_server_id(),Root.get_player_id(),Root.get_account_id(),json_str);
			end

--		end
--	end
end

--[[官网支付宝  不要连续点击，应该是保证至少2秒的点击间隔  而全且点击后应该全屏锁，等回调再解开]]
--function UserCenter.alipay_pay(money, name, desc, order_id, call_back)
--	app.log(string.format("UserCenter.alipay_pay,money=%s,name=%s,order_id=%s,call_back=%s",tostring(money),tostring(name),tostring(desc),tostring(order_id),tostring(call_back)));
--	--以下如果存在中文，请使用utf-8格式编码
--	local money = money;
--	money = money / 100;--[[分转元]]
--	local name = tostring(name);
--	local desc = tostring(desc);
--	--订单号：从服务器处获取，需要保证唯一，否则将无法支付或支付后无法到帐
--	--注意：被用户取消支付的订单号在一定周期内不能再次使用，表现为"订单号1未完成支付时用户取消支付，再使用订单号1支付时会返回支付错误。"
--	local private_key = "MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBALI9csz77qkibbiEYtRF0FsKZLrOdQCi4YAzz0IHIMNJ7cZFyVsSJmKDVIQNfiXB1sQtQLTCLez1jdFNIQ6fF3kxBUxScLvF222Y+2TloysqIBlB6kVt8dk+0L13fHlVSHplnSCrhCyCaPD3Hlbd1uTb1MpfNoPQBHS66vjGHH3DAgMBAAECgYEApl5c7aCqYAzWxUgsx15y4MeOxh83buSZ/4RcjJECr8Ytvsgc7ni+g216UdgWSz/nKy3iG9az7140hYyssm0lBlc1RKy5nDsN6esr3Ezyn7MOPA1kjAZmG97v291HLZMsdXuroPV4O6m5hAMyXU3rRSoZ1S4M8kC4QvJTM6Vkn8ECQQDZ6DYa1JJMHeo7NAbf5bNs8u/ii27ZUnkT9XtPO6j/rTeQHZrqGq2pO3z7f5HAB3sCO1PwEIG5zkLqJIAl+b9bAkEA0WYOOVutP2B0AvEZ/SyEHosGVoM9t9nFWrus9+m41rpYCujptB2kq/4BaduZk0lzGe8sPo+eF/m/vZDcyxavuQJBANbI8nujx8hLPFO6xoPuz9q14wm0UkDX8AxiTXcd4UiTHk9pPwc94KsMvfbQGYPkW7UpcWURgCz7SC2uaLoF4D0CQQC/Uha283t0h4UX1wBe4JiKa43L57exTmjSQN2F2edHUhT1St+U8OyvNLJH7RwBhb+Dt5JeSswwrcExy7TgXgcJAkEAxAuSLKNDgf8IRbQmET/LqWC1PTopCR849Zq29bv6UtSGDaN84NK+43SYltfyA3PnehI3c3bRu1s2akrGBPiD4A==";
--	local partner = "2088801184219754";
--	local seller_id = "wangying@xindong100.com";
--	--[[只能用外网地址，SDK需要回调]]
----	local notify_url = UserCenter.use_account_url.."pay_call_back_alipay/pay_notify.do";--[[正式地址]]
--	local notify_url = UserCenter.use_account_url..AppConfig.get_account_server_pay_path();--[[正式地址]]
--
--	app.log("notify_url="..notify_url);
--
--	local t = {
--		private_key = private_key,
--		partner = partner,
--		seller_id = seller_id,
--		total_fee = string.format("%.2f", money),
--		body = desc,
--		service = "mobile.securitypay.pay",
--		_input_charset = "utf-8",
--		out_trade_no = order_id,
--		subject = name,
--		payment_type = "1",
--
--		notify_url = notify_url,
--		app_id = AppConfig.get_app_id(),
--		appenv = nil,
--		it_b_pay = nil, --"30m",
--		show_url = nil, --"m.alipay.com",
--	};
--	alipay.pay(pjson.encode(t), "UserCenter.alipay_send_call_back");
--end
----[[官网支付宝查看帐号是否存在]]
--function UserCenter.alipay_check_account_exist()
--	return alipay.check_account_exist();
--end
----[[官网支付宝得到版本号]]
--function UserCenter.alipay_get_version()
--	return alipay.get_version();
--end
--[[官网支付宝支付回调]]
--function UserCenter.alipay_send_call_back(t)
--	app.log("官网支付宝支付回调");
--	UserCenter.buy_is_useing = false;
--	t = pjson.decode(t);
--	local result_status_info = {
--		["9000"] = "支付成功",
--		["8000"] = "正在处理中",
--		["4000"] = "订单支付失败",
--		["6001"] = "用户中途取消",
--		["6002"] = "网络连接出错"
--	};
--	app.log("status: " .. tostring(t.ResultStatus) ..",".. tostring(t.status) );
--	local status = t.ResultStatus or t.status;
--	app.log("result_status_info: " .. tostring(result_status_info[status]) );
--	app.log("result: " .. tostring(t.result));
--	app.log("memo:   " .. tostring(t.memo));
--
--	if UserCenter.buy_call_back then
--		local call_back = UserCenter.buy_call_back
--		if call_back == nil then
--			app.log("UserCenter.buy_call_back is null!");
--			return;
--		end
--
--		if type(call_back) == "string" then
--			call_back = _G[call_back]
--		end
--
--		if status == "9000" then
--			call_back(true);
--			SystemHintUI.SetAndShow(ESystemHintUIType.one, tostring(result_status_info[status]),
--				{str = "确定", func = function() call_back(true,UserCenter.order_id) end}
--			);
--			do return end;
--		elseif status == "8000" or status == "4000" or status == "6002" then
--			SystemHintUI.SetAndShow(ESystemHintUIType.one, tostring(result_status_info[status]..",避免重复支付，请稍后重试！"),
--				{str = "确定", func = function() call_back(false,UserCenter.order_id) end}
--			);
--		end
--		call_back(false);
--	end
--end

--------------------------------------------------第三方SDK atr--------------------------------------------------
--[[第三方JSON串上传]]
function UserCenter.submit_extend_info(table_info)
	app.log("user center JSON"..table.tostring(table_info));
	local json_info = pjson.encode(table_info);
	user_center.submit_extend_info(json_info);
end

--[[SDK登录回调
-- result: 0成功（有可能不是0为成功） 其他全是错的 -1登录失败 -2用户自己关闭 其他情况SDK自己管理
-- msg
-- accountid
-- accessToken
-- exten_val传回的扩展数据，Json String 应用宝会用到
-- str_json 平台返回的原生JSON1
-- ]]
function UserCenter.on_login(state, msg, accountid, token, exten_val,login_json)
	app.log(string.format("UserCenter.on_logined ok, state=%d, msg=%s, accountid=%s, token=%s, exten_val=%s , login_json=%s",state, msg, accountid, token, exten_val,login_json));

	--[[腾讯处理:点击释放]]
	if AppConfig.get_check_tencent() then
		if LoginTencentLogin then
			LoginTencentLogin.set_is_check(false);
		end
	end

	UserCenter.is_sdk_useing = false;

	state = tostring(state);

	--[[成功处理]]
	if state == "0" then

		--[[标示=成功]]
		if accountid == nil or accountid == "" or token == nil or token == "" then
			app.log("token is nill!!!");
			--[[腾讯处理]]
			if AppConfig.get_check_tencent() then
				--[[登录失败]]
				SystemHintUI.SetAndShow(ESystemHintUIType.one,"未知信息错误，请重新登录！",
					{str = "确认", func = Root.empty_func});
			else
				--[[登录失败]]
				SystemHintUI.SetAndShow(ESystemHintUIType.two,"未知信息错误，请重新登录！",
					{str = "是", func = UserCenter.sdk_login}, {str = "否", func = Root.quit});
			end
		else
			app.log("accountid="..tostring(accountid)..">>>>".."token="..tostring(token));
			app.log("exten_val="..tostring(exten_val));
			--[[成功]]
			UserCenter.user_name = accountid;
			UserCenter.accountid = accountid;
			UserCenter.token = token;
			UserCenter.exten_val = exten_val;
			UserCenter.login_json = login_json;
			if UserCenter.login_json == nil or UserCenter.login_json == "" then
				UserCenter.login_json_lua = nil;
			else
				UserCenter.login_json_lua = pjson.decode(UserCenter.login_json);
				local temp_ext = nil;
				if (type(UserCenter.login_json_lua.ext) == type("string"))  then
					local temp = UserCenter.login_json_lua.ext;
					local fn = loadstring('return ' .. temp )
					if fn then
						temp_ext = fn()
					end
				end
				if temp_ext ~= nil or temp_ext ~= "" then
					UserCenter.login_json_lua_ext = temp_ext;
				end
			end
			UserCenter.account_request_type = 4;--[[帐号的类型 -- 1 设备， 2： 手机 ， 3 邮箱 4. 第三方 5.昵称帐号 ]]

			app.log("UserCenter.is_ok = true");
			UserCenter.is_ok = true;

			--[[登陆成功后处理与通知UI]]
			UserCenter.on_login_ok();

		end
		do return end;
	end

	--[[异常处理]]

	--[[重置本地信息]]
	UserCenter.uinit_info();

	--[[主动注销处理]]
	if state == "-10" then
		UserCenter.on_logout();
		do return end;
	end

	if state == "-1" then
		--[[腾讯处理]]
		if AppConfig.get_check_tencent() then
			LoginTencentLogin.set_txt("");--[[重置用本地记录]]
			--[[登录失败]]
			SystemHintUI.SetAndShow(ESystemHintUIType.one,"登录失败，请重新登录！",
				{str = "确认", func = function() LoginTencentLogin.LoadAsset(UserCenter.sdk_login) end});
		else
			--[[登录失败]]
			SystemHintUI.SetAndShow(ESystemHintUIType.two,"登录失败，请重新登录！",
				{str = "是", func = UserCenter.sdk_login}, {str = "否", func = Root.quit});
		end
	elseif state == "-2" then
		--[[腾讯处理]]
		if AppConfig.get_check_tencent() then
			LoginTencentLogin.set_txt("");--[[重置用本地记录]]
			--[[登录失败]]
			SystemHintUI.SetAndShow(ESystemHintUIType.one,"未获得到帐号信息，请重新登录！",
				{str = "确认", func = function() LoginTencentLogin.LoadAsset(UserCenter.sdk_login) end});
		else
			--[[登录失败]]
			SystemHintUI.SetAndShow(ESystemHintUIType.two,"未获得到帐号信息，请重新登录！",
				{str = "是", func = UserCenter.sdk_login}, {str = "否", func = Root.quit});
		end
	elseif state == "4" then
		--[[腾讯处理]]
		if AppConfig.get_check_tencent() then
			LoginTencentLogin.set_txt("");--[[重置用本地记录]]
			SystemHintUI.SetAndShow(ESystemHintUIType.one,"微信未安装或版本太低！",
				{str = "确认", func = function() LoginTencentLogin.LoadAsset(UserCenter.sdk_login) end});
		end
	elseif state == "5" then
		--[[腾讯处理]]
		if AppConfig.get_check_tencent() then
			LoginTencentLogin.set_txt("");--[[重置用本地记录]]
			SystemHintUI.SetAndShow(ESystemHintUIType.one,"用户取消授权！",
				{str = "确认", func = function() LoginTencentLogin.LoadAsset(UserCenter.sdk_login) end});
		end
	elseif state == "6" then
		--[[腾讯处理]]
		if AppConfig.get_check_tencent() then
			LoginTencentLogin.set_txt("");--[[重置用本地记录]]
			SystemHintUI.SetAndShow(ESystemHintUIType.one,"需要重新登录！",
				{str = "确认", func = function() LoginTencentLogin.LoadAsset(UserCenter.sdk_login) end});
		end
	else
		--[[腾讯处理]]
		if AppConfig.get_check_tencent() then
			LoginTencentLogin.set_txt("");--[[重置用本地记录]]
			--[[登录失败]]
			SystemHintUI.SetAndShow(ESystemHintUIType.one,"登录异常ID："..tostring(state).."，请重新登录！",
				{str = "确认", func = function() LoginTencentLogin.LoadAsset(UserCenter.sdk_login) end});
		else
			--[[登录失败]]
			SystemHintUI.SetAndShow(ESystemHintUIType.two,"登录异常ID："..tostring(state).."，请重新登录！",
				{str = "是", func = UserCenter.sdk_login}, {str = "否", func = Root.quit});
		end
	end

end

--[[登陆成功后处理与通知UI]]
function UserCenter.on_login_ok()

	app.log("UserCenter.on_login_ok ");

	--[[公司日志：游戏启动信息]]
	SystemLog.AppStartClose(500000003);

	--[[清理前面的提示框]]
	SystemHintUI.hide();

	--[[隐藏SDK UI]]
	user_center:hide_tool_bar();

	--[[Talkingdata]]
	talkingdata.submit("login",UserCenter.get_accountid());


	--[[腾讯处理]]
	if AppConfig.get_check_tencent() then
		LoginTencentLogin.close();
	end

	--[[重置成功URL的重试次数]]
	UserCenter.reset_used_account_url_num();

	--[[实名认证]]
	UserCenter.check_realname(UserCenter.on_login_ok_torname);

	app.log("UserCenter.is_sdk_login >>>>>"..tostring(UserCenter.is_sdk_login));
end

function UserCenter.on_login_ok_torname()
	app.log("UserCenter.on_login_ok_torname");
	--[[登录UI显示完成后处理]]
	if not UserCenter.is_sdk_login then
		UserCenter.is_sdk_login = true;--[[还原，让SDK登陆能正重进游戏]]
		--		--[[正常SDK登陆回调]]
		--		Root.usercenter_login_callback();
		--[[登录UI显示完成后处理]]
		if type(UserCenter.call_back) == "function" then
			UserCenter.call_back();
			UserCenter.call_back = nil;
		end
	else
		--[[应用会主动推送，不相应动作,主动OUT]]
		if AppConfig.get_check_tencent() then
			return;
		end

		if Socket then
			Socket.Uinit();
		end
		--[[重进游戏]]
		UserCenter.on_logout();
	end
	app.log("UserCenter.is_sdk_login >>>>>"..tostring(UserCenter.is_sdk_login));
end

--[[登出回调]]
function UserCenter.on_logout()
	--[[腾讯处理:点击释放]]
	app.log("UserCenter.on_logout")
	if AppConfig.get_check_tencent() then
		if LoginTencentLogin then
			LoginTencentLogin.set_is_check(false);
		end
	end

	UserCenter.is_sdk_login = true;

	--[[重置本地信息]]
	UserCenter.uinit_info();

	app.log("UserCenter.on_logouted");
	script.run("logic/game_begin.lua");
	GameBegin.usercenter_logout_callback();
end

--[[重置本地信息]]
function UserCenter.uinit_info()
	app.log("UserCenter.uinit_info");
	--[[重置信息]]
	UserCenter.is_ok = false;
	UserCenter.web_realname = -1;--[[重置实名]]
	UserCenter.accountid = "";
	UserCenter.token = "";
	UserCenter.is_sdk_useing = false;
end

--[[腾讯查询余额]]
function UserCenter.cneent_balance(is_loop)

	app.log("UserCenter.cneent_balance>>>"..UserCenter.exten_val);
	app.log("UserCenter.login_str>>>"..UserCenter.login_str);

	--[[腾讯处理]]
	if AppConfig.get_check_tencent() and UserCenter.exten_val ~= "" then
		--[[传回给ACCOUNT exten_val，用于支付的关键数据]]
		--[[//腾讯SDK信息]]
		--[[
		 struct tencent_sdk_info
			{
				string type;		//类型："qq","wx"
				string openId;		//从手Q登录态或微信登录态中获取的openid的值
				string openkey;		//从手Q登录态中获取的pay_token的值或微信登录态中获取的access_token 的值
				string pf;			//平台来源，登录获取的pf值
				string pfKey;		//登录获取的pfkey值
				string zoneid;		//账户分区ID_角色ID，客户端只传角色ID，服务器加上分区ID
		};
		]]
		local temp_table = UserCenter.unpack(UserCenter.exten_val);
		--[[判断参数是不是checklogin]]
		local login_type = "";
		local x,y = string.find(UserCenter.login_str,"checkLogin");
		if x ~= nil or y ~= nil then
--			login_type = string.sub(UserCenter.login_str,y+1,string.len(UserCenter.login_str));
			login_type = LoginTencentLogin.red_txt();
		else
			login_type = UserCenter.login_str;
		end

		if login_type == "qq" then
			login_type = "100000";
		elseif login_type == "wx" then
			login_type = "100001";
		end

		if is_loop then
			app.log("1腾讯查询余额="..login_type);
			msg_store.cg_tencent_balance(1,login_type,temp_table.openId,temp_table.payToken,temp_table.pf,temp_table.pfKey);
		else
			app.log("0腾讯查询余额="..login_type);
			msg_store.cg_tencent_balance(0,login_type,temp_table.openId,temp_table.payToken,temp_table.pf,temp_table.pfKey);
		end

	end
end

--[[腾讯扣款 amt：金额，不能为O,order_id：自定义订单号]]
function UserCenter.tencent_pay(amt,order_id)
--	if amt == nil or amt == 0 then return end;
--	if order_id == nil then return end;
--	--[[腾讯处理]]
--	if AppConfig.get_check_tencent() and UserCenter.exten_val ~= "" then
--		--[[传回给ACCOUNT exten_val，用于支付的关键数据]]
--		--[[//腾讯SDK信息]]
--		--[[
--		 struct tencent_sdk_info
--			{
--				string type;		//类型："qq","wx"
--				string openId;		//从手Q登录态或微信登录态中获取的openid的值
--				string openkey;		//从手Q登录态中获取的pay_token的值或微信登录态中获取的access_token 的值
--				string pf;			//平台来源，登录获取的pf值
--				string pfKey;		//登录获取的pfkey值
--				string zoneid;		//账户分区ID_角色ID，客户端只传角色ID，服务器加上分区ID 服务器组装
--		};
--		]]
--
--		app.log("msg_store.cg_tencent_pay");
--
--		local temp_table = UserCenter.unpack(UserCenter.exten_val);
--		msg_store.cg_tencent_pay(amt,order_id,UserCenter.login_str,temp_table.openId,temp_table.payToken,temp_table.pf,temp_table.pfKey);
--	end
end

--[[第三方支付购买
-- money int 钱
-- product_id 物品ID
-- product_name 物品名
-- serverid 服务器ID
-- charid 角色ID（如果没有就传一个固定值）
-- accountid 帐号ID = player id
-- json_str 自定义JSON，主要是用于传名为order_id的定单号，因为平台是JAVA生成，而现在是自己生成
-- ]]
function UserCenter.payment(money,product_id,product_name,serverid,charid,accountid,json_str)
	app.log(string.format("UserCenter.payment money=%s,product_id=%s,product_name=%s,serverid=%s,charid=%s,accountid=%s,json_str=%s",tostring(money),tostring(product_id),tostring(product_name),tostring(serverid),tostring(charid),tostring(accountid),tostring(json_str)));
	if money == nil or product_id == nil or product_name == nil or serverid == nil or charid == nil or accountid == nil or json_str == nil then
		app.log("UserCenter.payment have something is nil!");
		return;
	end
--	money = 1;
	user_center.payment(money,tostring(product_id),tostring(product_name),tostring(serverid),tostring(charid),tostring(accountid),tostring(json_str));
end

--[[第三方支付回调
-- state
-- msg
-- money
-- orderid
-- ]]
function UserCenter.on_payment(state,msg,money,orderid)
	UserCenter.buy_is_useing = false;
	app.log(string.format("on_payment,state=%s, money=%s, orderid=%s, msg=%s",tostring(state), tostring(msg), tostring(money), tostring(orderid)));

	if UserCenter.buy_call_back then
		local call_back = UserCenter.buy_call_back
		if type(call_back) == "string" then
			call_back = _G[call_back]
		end

		if state == "0" then
--			SystemHintUI.SetAndShow(ESystemHintUIType.one, "支付成功",
--				{str = "确定", func = function() call_back(true,UserCenter.order_id) end}
--			);
--			call_back("0");

			--[[腾讯查询余额]]
			UserCenter.cneent_balance(true);
		else
			--[[UC只有成功才回调，因为退出也会回调，所以取消]]
			if AppConfig.get_check_uc() then
--				call_back("-2");
			else
--				call_back("-1");
			end
		end
	end

end

--[[腾讯SDK支付回调]]
function UserCenter.tencent_pay_call_back(state,msg,money,orderid)
	if UserCenter.buy_call_back then
		local call_back = UserCenter.buy_call_back
		if type(call_back) == "string" then
			call_back = _G[call_back]
		end

		if state == "0" then
			SystemHintUI.SetAndShow(ESystemHintUIType.one, "支付成功，请等待到帐，没有到帐前请不要重复充值！\n如果一直没有到帐，请联系GM处理！",
				{str = "确定", func = function() call_back(true,UserCenter.order_id) end}
			);
			call_back(true);
		else
			call_back(false);
		end
	end
end

--------------------------------------------------第三方SDK end--------------------------------------------------

--------------------------------------------------实名认证 str--------------------------------------------------
--[[实名认证]]


--[[在SDK登陆成功后，马上查看帐号是否进行了实名认证]]
function UserCenter.check_realname(call_back)
	app.log("UserCenter.get_web_realname >>"..tostring(UserCenter.get_web_realname()));

	PlayerEnterUITimesCurDay.IsRestGameTimeData();
	if UserCenter.get_web_realname() == 0 or UserCenter.get_sdk_user_type() then
		app.log("true");
		UserCenter.realname_call_back = call_back;
		if UserCenter.realname_call_back ~= nil then
			UserCenter.realname_call_back();
		end
		UserCenter.realname_call_back = nil;
	else
		if UserCenter.get_web_realname() == -1 then
			app.log("false -1");
			--[[-1未请求，马上请求]]
			UserCenter.check_realname_auth(call_back);
		elseif UserCenter.get_web_realname() == 1 then
			--[[1未实名认证 弹页面]]
			app.log("false 1");
			UserCenter.check_realname_auth(call_back);
		end
	end
end

--function UserCenter.show_realname_tips()
--	SystemHintUI.SetAndShow(ESystemHintUIType.one, "您当前使用的账号未进行实名认证，目前已经超过\n每日3小时限时体验时间，接下来的24小时内\n无法继续体验游戏。",
--		{str = "确定", func = function() UiAnn.Start(UiAnn.Type.RealNameAuth,nil,UserCenter.check_realname_auth) end}
--	);
--end

--[[发送WEB请求]]
function UserCenter.check_realname_auth(call_back)
	if call_back then
		UserCenter.realname_call_back = call_back;
	end
	--请求数据
	local json_data = {
		cmdId  = 1001,
		appId = AppConfig.get_app_id(),
		openid = Root.get_account_id(),
		accountType = 0,
	}
	ghttp.post_body_data(AppConfig.get_realname_auth_cmd_url(),pjson.encode(json_data),"UserCenter.on_get_realname_auth_error","UserCenter.on_get_realname_auth_succ");
end

function UserCenter.on_get_realname_auth_error(error_str)
	app.log("on_get_realname_auth_error:"..error_str)
end

function UserCenter.on_get_realname_auth_succ(result)
	--[[{"code":0,"msg":"success.","result":1}
	code：0-操作成功  其它失败
	msg：错误说明
	result：0-已实名认证  1-未实名认证]]
	local result_json = pjson.decode(result)
	app.log("on_get_realname_auth_succ:"..table.tostring(result_json))
	if result_json.code == 0 then
		--[[设定]]
		UserCenter.web_realname = result_json.result;
		if UserCenter.realname_call_back ~= nil then
			UserCenter.realname_call_back();
		end
		UserCenter.realname_call_back = nil;
	else
		app.log("获取实名认证信息失败.."..tostring(result_json.code))
	end
end


--function UserCenter.get_realname_auth(check)
--	local is_realname_auth = -1;
--	if g_dataCenter and g_dataCenter.player then
--		is_realname_auth = g_dataCenter.player:GetIsRealNameAuth();
--	end
--	if is_realname_auth == -1 or  true == check then
--		--请求数据
--		local json_data = {
--			cmdId  = 1001,
--			appId = AppConfig.get_app_id(),
--			openid = Root.get_account_id(),
--			accountType = 0,
--		}
--		ghttp.post_body_data(AppConfig.get_realname_auth_cmd_url(),pjson.encode(json_data),"UserCenter.on_get_realname_auth_error","UserCenter.on_get_realname_auth_succ")
--	elseif is_realname_auth == 0 then
--		--已认证
--	elseif is_realname_auth == 1 then
--		--未认证
--	end
--end
--
--function UserCenter.on_get_realname_auth_error(error_str)
--	app.log("on_get_realname_auth_error:"..error_str)
--end
--
--function UserCenter.on_get_realname_auth_succ(result)
--	--[[{"code":0,"msg":"success.","result":1}
--	code：0-操作成功  其它失败
--	msg：错误说明
--	result：0-已实名认证  1-未实名认证]]
--	local result_json = pjson.decode(result)
--	app.log("on_get_realname_auth_succ:"..table.tostring(result_json))
--
--	UserCenter.is_realname = result_json.code;
--
--	if result_json.code == 0 then
--
--		if g_dataCenter and g_dataCenter.player then
--			g_dataCenter.player:SetIsRealNameAuth(result_json.result);
--		end
--		--通知UI
--		if PublicFunc and player then
--			PublicFunc.msg_dispatch(player.gc_check_realname_auth);
--		end
--	else
--		app.log("获取实名认证信息失败.."..tostring(result_json.code))
--	end
--end

--------------------------------------------------实名认证 end--------------------------------------------------

--[[官网限制登陆]]
function UserCenter.digisky_check_login(check_login)
	UserCenter.check_login = check_login;

	--[[登录URL写死]]
	local web_url = AppConfig.get_digisky_queue_url();
	local web_path = AppConfig.get_digisky_queue_path();

	local table_info = UserCenter.get_need_info();
	table_info.type = 40;
	table_info.accountid = UserCenter.get_accountid();
	table_info.token = UserCenter.get_accessToken();
	local json_info = pjson.encode(table_info);

	app.log("UserCenter.digisky_check_login="..web_url);
	ghttp.post(
		web_url,
		"UserCenter.digisky_check_on_success",
		"UserCenter.digisky_check_on_error",
		web_path,
		json_info);
end
function UserCenter.digisky_check_on_success(t)
	app.log("UserCenter.digisky_check_on_success="..table.tostring(t));
	local temp = {};

	if t.result ~= nil or t.result ~= "" then
		local temp_table = pjson.decode(t.result);
		temp.ret = temp_table.ret;
		temp.num = temp_table.num;
		temp.timer = temp_table.timer;
		temp.msg = temp_table.msg;
	else
		app.log("digisky_check_on_success t.result =="..t.result);
		temp.ret = -1;
		temp.num = 0;
		temp.timer = 0;
		temp.msg = "json is error";
	end
	UserCenter.digisky_check_callback(temp);
end
function UserCenter.digisky_check_on_error(t)
	app.log("UserCenter.digisky_check_on_error="..table.tostring(t));
	local temp = {};
	temp.ret = -1;
	UserCenter.digisky_check_callback(temp);
end
function UserCenter.digisky_check_callback(t)
	if type(UserCenter.check_login) == "function" then
		UserCenter.check_login(t);
		UserCenter.check_login = nil;
	end
end

--------------------------------------------------微信 微博 str--------------------------------------------------
--[[
-- type_sdk: 1微信好友 2朋友圈 3微博
-- type_list: 1web 2photo
-- is_capture：true 是否需要截图
-- img_path = ""; 图片地址 也可以为空 如果有载图了，就会在截图成功后使用截图的地址，如果没有，就自己传入地址，例:xxxxx.png
-- share_url = ""; 网页跳转地址 http://djzj.ppgame.com/yy/index.html
-- title: 必需有
-- desc: 必需有
-- call_back： 回调
-- ]]
function UserCenter.share_online(type_sdk,type_list,is_capture,img_path,share_url,title,desc,call_back)
	if type_sdk == nil or is_capture == nil or type_list == nil then return false end;

	app.log("UserCenter.share_online type_sdk="..tostring(type_sdk).." type_list="..tostring(type_list).." is_capture="..tostring(is_capture).." img_path="..tostring(img_path).." share_url="..tostring(share_url).." title="..tostring(title).." desc="..tostring(desc));

	--[[先就判断有没有对应的SDK]]
	if type_sdk == 1 or type_sdk == 2 then --[[信]]
		if not UserCenter.wechat_check() then
			SystemHintUI.SetAndShow(ESystemHintUIType.one,"没有找到微信，请先安装哦！",
				{str = "确认", func = Root.empty_func});
			do return end;
		end
	elseif type_sdk == 3 then--[[博]]
		if not UserCenter.weibo_check() then
			SystemHintUI.SetAndShow(ESystemHintUIType.one,"没有找到微博，请先安装哦！",
				{str = "确认", func = Root.empty_func});
			do return end;
		end
	end

	if UserCenter.is_useing_share then
		app.log("分享功能还在使用，不能重复使用！");
		return false;
	else
		UserCenter.is_useing_share = true;
		--[[激活3秒后自动释放]]
		timer.create("UserCenter.unlocl_share", 1000*3, 1);

		UserCenter.share_type_sdk = type_sdk;--[[分享类型1微信好友 2朋友圈 3微博]]
		UserCenter.share_type_list = type_list;--[[分享类型1web 2photo]]
		UserCenter.is_capture = is_capture;
		if img_path == nil or img_path == "" then
--			if Root.get_os_type() == 8 then
--				UserCenter.share_img_path = "";
--			else
--				UserCenter.share_img_path = "ghoul.png";
--			end
			UserCenter.share_img_path = "";
		else
			UserCenter.share_img_path = tostring(img_path);
		end
		if share_url == nil then
			share_url = "http://djzj.ppgame.com/yy/index.html";
		end
		UserCenter.share_url = tostring(share_url);
		if title == nil then
			title = "东京战纪";
		end
		UserCenter.share_title = tostring(title);
		if desc == nil then
			desc = "东京战纪";
		end
		UserCenter.share_desc = tostring(desc);
		UserCenter.share_call_back = call_back;

		if UserCenter.is_capture then
			app.log("截图");
			UserCenter.capture_screenshot();
		else
			app.log("不截图");
			UserCenter.share_online_goon();
		end

		return true;
	end
end

function UserCenter.share_online_goon()
	if UserCenter.share_type_sdk == 1 or UserCenter.share_type_sdk == 2 then
		--[[微信]]
		app.log("UserCenter.share_online_goon:wechat");
		UserCenter.wechat_share_goon();
	elseif UserCenter.share_type_sdk == 3 then
		app.log("UserCenter.share_online_goon:weibo");
		--[[微博]]
		UserCenter.weibo_share_goon();
	end
end

function UserCenter.unlocl_share()
	UserCenter.is_useing_share = false;--[[重置标示]]
end

--[[截图]]
function UserCenter.capture_screenshot()
	local time_temp = os.date("*t");
	local time_str = "ghoul_img_"..time_temp.month.."_";
	time_str = time_str..time_temp.day.."_";
	time_str = time_str..time_temp.hour.."_";
	time_str = time_str..time_temp.min.."_";
	time_str = time_str..time_temp.sec..".png";

	--[[使用外面传来的图片名字]]
--	time_str = "";
--	time_str = tostring(UserCenter.share_img_path);

	app.log("UserCenter.capture_screenshot>"..time_str);

	local temp = util.capture_screenshot(time_str,"UserCenter.capture",3);--[[只用3类型截图]]

	return temp;
end

--[[载图回调]]
function UserCenter.capture(t)
	app.log("UserCenter.capture>>>"..table.tostring(t));
	UserCenter.share_img_path = tostring(t.path);
	UserCenter.share_online_goon();
end

function UserCenter.wechat_check()
	return user_center.wechat_check();
end

function UserCenter.wechat_share_goon()
	local temp_table =  {};
	app.log("UserCenter.wechat_share_goon:"..tostring(UserCenter.share_type_list));
	if UserCenter.share_type_list == 1 then
		--[[WEB]]
		if UserCenter.share_type_sdk == 1 then
			temp_table.scene = 0;--[[	//scene 发送到聊天界面 0	发送到朋友圈 1]]
		elseif UserCenter.share_type_sdk == 2 then
			temp_table.scene = 1;--[[	//scene 发送到聊天界面 0	发送到朋友圈 1]]
		end
		temp_table.title = tostring(UserCenter.share_title);
		temp_table.desc = tostring(UserCenter.share_desc);
		temp_table.url = tostring(UserCenter.share_url);
		temp_table.thumbPath = tostring(UserCenter.share_img_path);
		app.log("temp_table="..table.tostring(temp_table));
		local res = user_center.wechat_share(pjson.encode(temp_table));
		app.log("user_center.wechat_share res = "..tostring(res));
		if not res then
			UserCenter.unlocl_share();--[[重置标示]]
		end
	elseif UserCenter.share_type_list == 2 then
		--[[PHOTO]]
		if UserCenter.share_type_sdk == 1 then
			temp_table.scene = 0;--[[	//scene 发送到聊天界面 0	发送到朋友圈 1]]
		elseif UserCenter.share_type_sdk == 2 then
			temp_table.scene = 1;--[[	//scene 发送到聊天界面 0	发送到朋友圈 1]]
		end
		temp_table.title = tostring(UserCenter.share_title);
		temp_table.desc = tostring(UserCenter.share_desc);
		temp_table.picPath = tostring(UserCenter.share_img_path);
		app.log("temp_table="..table.tostring(temp_table));
		local res = user_center.wechat_share(pjson.encode(temp_table));
		app.log("user_center.wechat_share res = "..tostring(res));
		if not res then
			UserCenter.unlocl_share();--[[重置标示]]
		end
	end
end

--[[微信share]]
function UserCenter.on_wechatshare(state,json_str)
	app.log("UserCenter.on_wechatshare>"..state..",json_str="..json_str);
	state = tostring(state);
	local temp = false;
	if state == "0" then
		temp = true;
	end

	--[[lua回调]]
	UserCenter.share_call_bcak(temp);
end

--[[微信pay]]
function UserCenter.on_wechatpay(state,json_str)
	app.log("UserCenter.on_wechatpay>"..state..",json_str="..json_str);
end





--[[微博check]]
function UserCenter.weibo_check()
	return user_center.weibo_check();
end

--[[微博share]]
function UserCenter.weibo_share_goon(img_path)
	local temp_table =  {};
	app.log("UserCenter.weibo_share_goon:"..tostring(UserCenter.share_type_list));
	if UserCenter.share_type_list == 1 then
		--[[WEB]]
		temp_table.text = tostring(UserCenter.share_title);
		temp_table.title = tostring(UserCenter.share_title);
		temp_table.desc = tostring(UserCenter.share_desc);
		temp_table.url = tostring(UserCenter.share_url);
		temp_table.thumbPath = tostring(UserCenter.share_img_path);
		app.log("temp_table="..table.tostring(temp_table));
		local res = user_center.weibo_share(pjson.encode(temp_table));
		app.log("user_center.weibo_share res = "..tostring(res));
	elseif UserCenter.share_type_list == 2 then
		--[[PHOTO]]
		temp_table.text = tostring(UserCenter.share_title);
		temp_table.picPath = tostring(UserCenter.share_img_path);
		app.log("temp_table="..table.tostring(temp_table));
		local res = user_center.weibo_share(pjson.encode(temp_table));
		app.log("user_center.weibo_share res = "..tostring(res));
	end
end

--[[微博share]]
function UserCenter.on_weiboshare(state,json_str)
	app.log("UserCenter.on_weiboshare>"..state..",json_str="..json_str);
	state = tostring(state);
	local temp = false;
	if state == "0" then
		temp = true;
	end

	--[[lua回调]]
	UserCenter.share_call_bcak(temp);
end

--[[lua回调]]
function UserCenter.share_call_bcak(is_true)
	if UserCenter.share_call_back ~= nil then
		UserCenter.share_call_back(is_true);
		UserCenter.share_call_back = nil;
	end
	UserCenter.unlocl_share();--[[重置标示]]
end
--------------------------------------------------微信 微博 end--------------------------------------------------

--------------------------------------------------拉取玩家信息 begin --------------------------------------------
function UserCenter.get_player_info_toweb()
    local url = UserCenter.fileter_account_url();
    local path = AppConfig.get_auth_server_path();
    local accountid = UserCenter.Get_Player_Accountid();
--    app.log("UserCenter.get_player_info_toweb...."..tostring(accountid))
    --获取accoutid 如果不存在 则发送u3d_uuid
	if accountid ~= 0 then
	    if type(url) == "string" and #url > 0 and 
	        type(path) == "string" and #path > 0 then
	        local req_inf = {type=62, openid=accountid, token=UserCenter.get_accessToken()}
	        req_inf = pjson.encode(req_inf)
	        ghttp.post( url, "UserCenter.OnGetHttpSuccess", "UserCenter.OnGetHttpError", path, req_inf );
	        UserCenter.get_player_info_timerId = timer.create("UserCenter.OnGetHttpError", 10000, 1);
	    end
	else
		if type(url) == "string" and #url > 0 and 
	        type(path) == "string" and #path > 0 then
	        local req_inf = {type=62, u3d_uuid = AppConfig.get_deviceuniqueidentifier(), token=UserCenter.get_accessToken()}
	        req_inf = pjson.encode(req_inf)
	        ghttp.post( url, "UserCenter.OnGetHttpSuccess", "UserCenter.OnGetHttpError", path, req_inf );
	        UserCenter.get_player_info_timerId = timer.create("UserCenter.OnGetHttpError", 10000, 1);
	    end
	end
end

function UserCenter.OnGetHttpSuccess(t)
	app.log("UserCenter.OnGetHttpSuccess="..table.tostring(t));
	UserCenter.reset_used_account_url_num();--[[重置成功URL的重试次数]]
	if UserCenter.get_player_info_timerId then
        timer.stop(UserCenter.get_player_info_timerId)
        UserCenter.get_player_info_timerId = nil
    end
    local json_info = pjson.decode(t.result);

    if json_info and json_info.ret == 0 and json_info.accountid == UserCenter.Get_Player_Accountid() then
        --存到本地 eg:result='{"accountid":"9a729862019fdb287374db27d36bb5bbf548c8ae","players":[{"player_image":30005000,"player_lv":1,"player_name":"随机7964","reserved_int1":0,"reserved_str1":"","server_id":204},{"player_image":30005000,"player_lv":1,"player_name":"随机2710","reserved_int1":0,"reserved_str1":"","server_id":308}],"ret":0}'
  		--fsize=316}
        UserCenter.player_info_list = json_info.players

--        app.log("json_info......"..table.tostring(json_info))
       
    else
  --   	SystemHintUI.SetAndShow(ESystemHintUIType.one, "获取玩家信息失败，点击确定重新获取。",
		-- 	{str = "确认", func = UserCenter.get_player_info_toweb}
		-- );
    end

-- 	app.log("UserCenter.player_info_list  >>>>>"..table.tostring(UserCenter.player_info_list))
end

function UserCenter.OnGetHttpError()
	if UserCenter.get_player_info_timerId then
        timer.stop(UserCenter.get_player_info_timerId)
        UserCenter.get_player_info_timerId = nil
    end

  --   SystemHintUI.SetAndShow(ESystemHintUIType.one, "获取玩家信息失败，点击确定重新获取。",
		-- 	{str = "确认", func = UserCenter.get_player_info_toweb}
		-- );
end

function UserCenter.get_player_info_list()
	return UserCenter.player_info_list
end

function UserCenter.get_player_info_id(id)

	local info = {}
	for k,v in pairs(UserCenter.player_info_list) do
		if v.server_id == id then
			info = v
			return info
		end
	end

	return info
end

--[[本地存ACCID]]
function UserCenter.Save_Player_Accountid(id)
	local file_handler = file.open(UserCenter.player_file_accountid, 2);
	if not file_handler then
		return
	end
	local account = {accountid = tostring(id)}
	file_handler:write_string(table.tostringEx(account));
	file_handler:close();
end

function UserCenter.Get_Player_Accountid()
	local result = 0
	local file_handler = file.open_read(UserCenter.player_file_accountid);
	if file_handler then
		local temp_file = file_handler:read_all_text();
		file_handler:close();
		if temp_file ~= "" then
			local temp_func = loadstring(temp_file);
			local temp_data = temp_func();
			if temp_data then
				if type(temp_data) == "number" then
					result = temp_data;
					UserCenter.Save_Player_Accountid(result);--[[更新数据结构]]
				else
					result = temp_data.accountid
				end
				result = temp_data.accountid
			end
		end
	end
	return result 
end

----------------------------------end-----------------------------------------------------------------

--[[可以提前初始化]]
user_center.set_wechatshare_listener("UserCenter.on_wechatshare");--[[微信SHARE]]
user_center.set_wechatpay_listener("UserCenter.on_wechatpay");--[[微信支付]]

user_center.set_weiboshare_listener("UserCenter.on_weiboshare");--[[微博SHARE]]

