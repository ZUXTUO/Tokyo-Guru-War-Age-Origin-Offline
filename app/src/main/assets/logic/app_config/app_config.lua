--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/6
-- Time: 16:31
-- To change this template use File | Settings | File Templates.

--[[ 帐号IP连接 ]]
Target_Version_Name = { ART = "art", BETA = "beta", QA = "qa", TEST_ONLINE = "test_online"}
Target_Version = Target_Version_Name.QA
---
AppConfig = {
	--------------------------- [[打包 start]]-------------------------------------------------------------------------------
	is_release = false; --[[ ********是不是发布版本******* ]]
	is_digisky_sdk = false;--[[ ********是不是使用公司SDK版本******* ]]
	package_version1 = "0"; --[[版本号1]]
	package_version2 = "9"; --[[版本号2]]
	package_version3 = "0"; --[[版本号3（针对线上:如果公共资源有改变就需要改变版本号）]]
	package_ass_ver = "0";--[[资源版本号]]
	asst_path_shareof = "preloading@dynamicfont@shader";--[[ASST特殊处理PATH:xxxx@xxxxx@xxxxx]]

	digisky_queue_url = "",--"http://cn.web.gh.ppgame.com:2601/";--[[官网排队临时功能 如果配了就实行排队功能，不区分版本]]
	digisky_queue_path = "login_service/user_center.do";--[[同上]]

	gray_path = "gray/";--[[灰度服资源路径]]
	version_path = "version.txt";--[[版本文件]]
	version_gray_path = "gray/version.txt";--[[版本文件]]

	--------------------------- [[打包 end]]---------------------------------------------------------------------------------

	----------------------------- [[系统级主要参数]]----------------------------------------------------------------------------------------
	is_numerical_version = true; --[[数值测试版本]]
	new_player_script_recording = false;	  --[[新玩家消息脚本录制]]
	update_region = 1; --[[ 语言区域版本 1:中文 ]]
	enable_peak_show = true; --[[ 巅峰展示   true启用   false关掉 ]]
	enable_guide = true; --[[ 新手引导   true启用   false关掉 ]]
	enable_guide_tip = true; --[[ 引导提示   true启用   false关掉 ]]
	enable_on_line = false; --[[ 线上流程   true启用  false关掉 ]]
	enable_update_file = false; --[[ 文件动态更新   true启用  false关掉 ]]
	enable_keep_alive_check = false; --[[ 客户端主动心跳，SOCKET超时检查 ]]
	enable_reg_mail = false;--[[公司平台帐号邮箱注册 true启用  false关掉]]

	new_account_index = ""; --[[ ART版本修改设备ID  换号]]

	--[[ 系统DEBUG调试信息类 ]]
	error_url = "http://errorloggate.ghoul.ppgame.com:9321/webpost_ghoul.php"; --[[ HTTP ERROR URL]]
	is_write_file = true; --[[ 写信本地LOG true写入 ]]
	is_web_post = false; --[[ 向WEB提交信息 true提交 ]]
	is_debug_show = true; --[[ 显示debug按钮 true显示 ]]
	is_debug_check = false; --[[ debug按钮点击事件 true接受点击 ]]
	is_effect_console_enable = false; --[[是否显示FPS按钮]]
	is_format_log = false; --[[ 是否关掉所有日志打印（用于性能分析）true关掉所有日志 ]]

	upload_resource_record = false; --[[上传文件加载记录]]

	--------------------------- [[运营,日志，用户中心 start]]---------------------------------------------------------------------------------
	system_list = {
		android =
		{
			max_disk_space = 0;--[[系统最大缓存M]]
			app_id = "0002000200020020";
			user_center_key = "1234567890";
			game_id = "20"; --[[ 私有：与平台无关：GAME服务器匹配标示，与GAME配置一样才可以进入GAME 不修改]]

			--[[ 渠道ID 参照渠道表，线上流程使用定版数字，内网测试:1008
			-- 自己做的入口服需要使用，平台DTREE也拿这个值来做client_version的值
			-- ]]
			platformchannel_id = "1008";--[[渠道ID 支付使用的channel_id]]
			--[[ 1:DTREE的channel,如果不为空就以这个值去取DTREE，如果为空就以上面的真channel取去,混服使用,多个渠道看到同样的服务器
			-- 2:进入GAME服也要传这个值,服务器开启时的TYPE与这个要相同才能进入游戏服]]
			dtree_channle_id = "1008";

			package_id = "gw"; --[[ 包标示 入口服需要值:package_id=%s 判断是不是需要更新APK]]
--			client_version = ""; --[[ 评审服标示 ：平台DTREE client_version的值]]
			game_version = "djzj"; --[[ 项目标示 ：平台DTREE djzj的值 不能修改]]

			--[[ 入口HTTP URL ]]
			system_check_httpurl = {
				[1] = "http://192.168.60.66:8090/";--[[内网]]
			};
			system_check_filepath = "entry_service/entry_info.do?channel_id=%s&client_ver=%s&package_id=%s"; --[[ 入口HTTP PATH ]]
			effect_level_filepath = "entry_service/effect_level.do?device_model=%s";--[[特效等级PATH]]
			notice_info_path = "entry_service/notice_info.do";--[[维护公告PATH]]

			--[[ 帐号服URL ]]
			auth_server_url = {
				[1] = {"http://192.168.60.66:8090/"};--[[内网]]
			};
			auth_server_path = "/login_service/user_center.do";  --[[用户中心]]

			--[[DTREE地址]]
			dtree_server_url = {
				[1] = {"http://plat-all-cncs-cs-dirtreecli-0001.ppgame.com:8080/"}; --[[DTREE URL]]
			};
			dtree_server_path = {
				[1] = "dirtree/getserverinfo";--[[DTREE PATH]]
			};

			--[[fserver url: filemap and op    对应下发变量：ver:url]]
			fserver_check_url = {
				[1] = {"http://192.168.20.244:7022/"};
			};
			--[[fserver url: down    对应下发变量：ver:path]]
			fserver_check_path = "digisky_file_server";
			--[[fserver url: down    对应下发变量：res:url]]
			fserver_down_url = {
				[1] = {"http://192.168.20.244:92/"};
			};
			--[[fserver url: down    对应下发变量：res:path]]
			fserver_down_path = "ghoul";

			im_appid = 1000233;--[[IM ID]]
			im_is_test = false;--[[IM 调试]]

			--[[平台需求]]
			child_id = "0002"; --[[平台需求]]
			gameID = "0020"; --[[平台需求]]
			deviceid = "30000";--[[平台包ID  平台需求]]
			fserver_version_number = 0;--[[fserver更新起始版本号]]
		};
		ios = {
			max_disk_space = 0;--[[系统最大缓存M]]
			app_id = "0001000200020020";
			user_center_key = "1234567890";
			game_id = "20"; --[[ 私有：与平台无关：GAME服务器匹配标示，与GAME配置一样才可以进入GAME 不修改]]

			--[[ 渠道ID 参照渠道表，线上流程使用定版数字，内网程序:ghoul_dev 内网策划:ghoul_ch 内网QA：ghoul_qa
			-- 自己做的入口服需要使用，平台DTREE也拿这个值来做client_version的值
			-- ]]
			platformchannel_id = "2001";--[[渠道ID 支付使用的channel_id]]
			dtree_channle_id = "2001";--[[ DTREE的channel,如果不为空就以这个值去取DTREE，如果为空就以上面的真channel取去]]

			package_id = "gw_ios"; --[[ 包标示 入口服需要值:package_id=%s 判断是不是需要更新APK]]
--			client_version = ""; --[[ 评审服标示 ：平台DTREE client_version的值]]
			game_version = "djzj"; --[[ 项目标示 ：平台DTREE djzj的值 不能修改]]

			--[[ 入口HTTP URL ]]
			system_check_httpurl = {
				[1] = "http://192.168.56.163:8090/";--[[内网]]
			};
			system_check_filepath = "entry_service/entry_info.do?channel_id=%s&client_ver=%s&package_id=%s"; --[[ 入口HTTP PATH ]]
			effect_level_filepath = "entry_service/effect_level.do?device_model=%s";--[[特效等级PATH]]
			notice_info_path = "entry_service/notice_info.do";--[[维护公告PATH]]

			--[[ 帐号服URL ]]
			auth_server_url = {
				[1] = {"http://192.168.60.66:8090/"};--[[内网]]
			};
			auth_server_path = "/login_service/user_center.do";  --[[用户中心]]

			--[[DTREE地址]]
			dtree_server_url = {
				[1] = {"http://plat-all-cncs-cs-dirtreecli-0001.ppgame.com:8080/"}; --[[DTREE URL]]
			};
			dtree_server_path = {
				[1] = "dirtree/getserverinfo";--[[DTREE PATH]]
			};

			--[[fserver url: filemap and op    对应下发变量：ver:url]]
			fserver_check_url = {
				[1] = {"http://192.168.20.244:7022/"};
			};
			--[[fserver url: down    对应下发变量：ver:path]]
			fserver_check_path = "digisky_file_server";
			--[[fserver url: down    对应下发变量：res:url]]
			fserver_down_url = {
				[1] = {"http://192.168.20.244:92/"};
			};
			--[[fserver url: down    对应下发变量：res:path]]
			fserver_down_path = "ghoul";

			im_appid = 1000233;
			im_is_test = false;--[[IM 调试]]

			--[[平台需求]]
			child_id = "0002";--[[申请值  不变 平台需求]]
			gameID = "0020"; --[[申请值  不变 平台需求]]
			deviceid = "10102";--[[设备ID 对应下载什么平台的资源 平台需求]]
			fserver_version_number = 0;--[[fserver更新起始版本号]]
		};
	};
	--------------------------- [[运营,日志，用户中心 end]]---------------------------------------------------------------------------------

	--------------------------- [[自己写的HTTP更新 start]]---------------------------------------------------------------------------------
	use_update_fserver = false;--[[更新模式：true=fserver,false=http web]]
	update_role = 1; --[[ 使用对像   0=稳定,  1=美术ART ]]

	-- socket = {
	-- 	release = {
	-- 		update_ip = "103.17.41.91";--[[文件更新IP]]
	-- 		update_port = 8081;--[[文件更新端口 PC=6050]]
	-- 		update_device_id = 30000;--[[ 文件更新设备号 pc:0 iphone:10102 android:30000]]
	-- 		update_version_number = 4;--[[初始版本号  android:5(没有任何资源的版本号)]]
	-- 	};
	-- 	art = {
	-- 		update_ip = "192.168.2.9";--[[文件更新IP]]
	-- 		update_port = 7050;--[[文件更新端口 PC=6050]]
	-- 		update_device_id = 30000;--[[ 文件更新设备号 pc:0 iphone:10102 android:30000]]
	-- 		update_version_number = 4287;--[[初始版本号  android:美术测试=213(没有任何资源的版本号)]]
	-- 	};
	-- };

	http = {
		release =
		{
			check_op =
			{
				[1] = "http://192.168.2.91/http_update/",
				[2] = "http://125.71.203.241:9321/http_update/",
			};
			down_url = {
				[1] = "http://192.168.2.91/http_update/",
				[2] = "http://125.71.203.241:9321/http_update/",
			};
			update_device_id = "digitalsky"; --[[ 文件更新设备号 pc:0 iphone:10102 android:30000 ]]
			update_version_number = 0; --[[ 初始版本号(没有任何资源的版本号) ]]
		};
		art = {
			check_op =
			{
				[1] = "http://192.168.2.91/http_update/",
				[2] = "http://125.71.203.241:9321/http_update/",
			};
			down_url = {
				[1] = "http://192.168.2.91/http_update/",
				[2] = "http://125.71.203.241:9321/http_update/",
			};
			update_device_id = "android_bata"; --[[ 文件更新设备号 pc:0 iphone:10102 android:30000 ]]
			update_version_number = 0; --[[ 初始版本号(没有任何资源的版本号) ]]
		};
	};
	--------------------------- [[自己写的HTTP更新 end]]---------------------------------------------------------------------------------
};
----------------------------------------------------- [[通用必初始化 str]]---------------------------------------------------------------------------------
--[[
appid = app_id
playerid = accountid
playername = player_name+player_id(玩家名+player_id  xxxxx_player_id)
-- ]]
AppConfig.kefu_url = "file:///android_asset/www/kefu.html"; --[[ 客服Url地址 ]]
AppConfig.question_url = "http://www.sojump.com/jq/6819519.aspx"; --[[ 问卷Url地址 ]]
AppConfig.realname_auth_cmd_url = "http://realauth.ucenter.ppgame.com/cmd"
AppConfig.realname_auth_url  = "http://realauth.ucenter.ppgame.com/authoriz.html?appid=%s&openid=%s&accounttype=%s&language=zh"
----------------------------------------------------- [[通用必初始化 end]]---------------------------------------------------------------------------------


----------------------------------------------------- [[QA ONLINE_TEST独立设置，走线上流程 str]]-----------------------------------------------------------------------------------

if Target_Version == Target_Version_Name.BETA then
	AppConfig.enable_peak_show = true; --[[ 巅峰展示   true启用   false关掉 ]]
	AppConfig.enable_guide = true; --[[ 新手引导   true启用   false关掉 ]]
	AppConfig.enable_guide_tip = true; --[[ 引导提示   true启用   false关掉 ]]
	AppConfig.enable_on_line = false; --[[ 线上流程   true启用  false关掉 ]]
	AppConfig.enable_update_file = false; --[[ 文件动态更新   true启用  false关掉 ]]
	AppConfig.enable_keep_alive_check = false; --[[ 客户端主动心跳，SOCKET超时检查 ]]
	AppConfig.enable_reg_mail = false; --[[公司平台帐号邮箱注册 true启用  false关掉]]

	AppConfig.use_update_fserver = false;--[[更新模式：true=fserver,false=http web]]

	--[[ 系统DEBUG调试信息类 ]]
	AppConfig.error_url = "http://errorloggate.ghoul.ppgame.com:9321/webpost_ghoul.php"; --[[ HTTP ERROR URL]]
	AppConfig.is_write_file = true; --[[ 写信本地LOG true写入 ]]
	AppConfig.is_web_post = false; --[[ 向WEB提交信息 true提交 ]]
	AppConfig.is_debug_show = GameInfoForThis.Debug; --[[ 显示debug按钮 true显示 ]]
	AppConfig.is_debug_check = false; --[[ debug按钮点击事件 true接受点击 ]]
	AppConfig.is_effect_console_enable = false; --[[显示后期特效控制台]]
	AppConfig.is_format_log = false; --[[ 是否关掉所有日志打印（用于性能分析）true关掉所有日志 ]]

	--[[android]]
	AppConfig.system_list.android.system_check_httpurl = {
		[1] = "http://211.155.91.217:2601/";--[beta服]]
	};
	AppConfig.system_list.android.system_check_filepath = "entry_service/entry_info.do?channel_id=%s&client_ver=%s&package_id=%s"; --[[ 入口HTTP PATH ]]
	AppConfig.system_list.android.effect_level_filepath = "entry_service/effect_level.do?device_model=%s";--[[特效等级PATH]]
	AppConfig.system_list.android.notice_info_path = "entry_service/notice_info.do";--[[维护公告PATH]]
	--[[IOS]]
	AppConfig.system_list.ios.system_check_httpurl = {
		[1] = "http://211.155.91.217:2601/";--[[beta服]]
	};
	AppConfig.system_list.ios.system_check_filepath = "entry_service/entry_info.do?channel_id=%s&client_ver=%s&package_id=%s"; --[[ 入口HTTP PATH ]]
	AppConfig.system_list.ios.effect_level_filepath = "entry_service/effect_level.do?device_model=%s";--[[特效等级PATH]]
	AppConfig.system_list.ios.notice_info_path = "entry_service/notice_info.do";--[[维护公告PATH]]
end

if Target_Version == Target_Version_Name.QA then

	--[[配置全从服务器下载，本地配置无效]]
	AppConfig.enable_peak_show = true; --[[ 巅峰展示   true启用   false关掉 ]]
	AppConfig.enable_guide = true; --[[ 新手引导   true启用   false关掉 ]]
	AppConfig.enable_guide_tip = true; --[[ 引导提示   true启用   false关掉 ]]
	AppConfig.enable_on_line = false; --[[ 线上流程   true启用  false关掉 ]]
	AppConfig.enable_update_file = false; --[[ 文件动态更新   true启用  false关掉 ]]
	AppConfig.enable_keep_alive_check = false; --[[ 客户端主动心跳，SOCKET超时检查 ]]
	AppConfig.enable_reg_mail = false; --[[公司平台帐号邮箱注册 true启用  false关掉]]

	AppConfig.use_update_fserver = true;--[[更新模式：true=fserver,false=http web]]

	--[[ 系统DEBUG调试信息类 ]]
	AppConfig.error_url = "http://errorloggate.ghoul.ppgame.com:9321/webpost_ghoul.php"; --[[ HTTP ERROR URL]]
	AppConfig.is_write_file = true; --[[ 写信本地LOG true写入 ]]
	AppConfig.is_web_post = false; --[[ 向WEB提交信息 true提交 ]]
	AppConfig.is_debug_show = GameInfoForThis.Debug; --[[ 显示debug按钮 true显示 ]]
	AppConfig.is_debug_check = false; --[[ debug按钮点击事件 true接受点击 ]]
	AppConfig.is_effect_console_enable = false; --[[显示后期特效控制台]]
	AppConfig.is_format_log = false; --[[ 是否关掉所有日志打印（用于性能分析）true关掉所有日志 ]]

	--[[android]]
	AppConfig.system_list.android.system_check_httpurl = {
		[1] = "http://127.0.0.1/";--[[QA服]]
	};
	AppConfig.system_list.android.system_check_filepath = "entry_service/entry_info.do?channel_id=%s&client_ver=%s&package_id=%s"; --[[ 入口HTTP PATH ]]
	AppConfig.system_list.android.effect_level_filepath = "entry_service/effect_level.do?device_model=%s";--[[特效等级PATH]]
	AppConfig.system_list.android.notice_info_path = "entry_service/notice_info.do";--[[维护公告PATH]]
	AppConfig.system_list.android.package_id = "gw"; --[[ 包标示 入口服需要值:package_id=%s 判断是不是需要更新APK]]
--	AppConfig.system_list.android.client_version = ""; --[[ 评审服标示 ：平台DTREE client_version的值]]
	AppConfig.system_list.android.platformchannel_id = "1008"; --[[渠道ID 支付使用的channel_id]]
	AppConfig.system_list.android.dtree_channle_id = "1006";--[[ DTREE的channel,如果不为空就以这个值去取DTREE，如果为空就以上面的真channel取去 进入GAME服也要传这个值 混服使用]]
	--[[IOS]]
	AppConfig.system_list.ios.system_check_httpurl = {
		[1] = "http://127.0.0.1/";
	};
	AppConfig.system_list.ios.system_check_filepath = "entry_service/entry_info.do?channel_id=%s&client_ver=%s&package_id=%s"; --[[ 入口HTTP PATH ]]
	AppConfig.system_list.ios.effect_level_filepath = "entry_service/effect_level.do?device_model=%s";--[[特效等级PATH]]
	AppConfig.system_list.ios.notice_info_path = "entry_service/notice_info.do";--[[维护公告PATH]]
	AppConfig.system_list.ios.package_id = "gw_ios"; --[[ 包标示 入口服需要值:package_id=%s 判断是不是需要更新APK]]
--	AppConfig.system_list.ios.client_version = ""; --[[ 评审服标示 ：平台DTREE client_version的值]]
	AppConfig.system_list.ios.platformchannel_id = "2001"; --[[渠道ID 支付使用的channel_id]]
	AppConfig.system_list.ios.dtree_channle_id = "2001";--[[ DTREE的channel,如果不为空就以这个值去取DTREE，如果为空就以上面的真channel取去 进入GAME服也要传这个值 混服使用]]
end

----------------------------------------------------- [[QA独立设置，走线上流程 end]]-----------------------------------------------------------------------------------


----------------------------------------------------- [[正式版线上服发布 不准修改 str]]---------------------------------------------------------------------------------

--[[ 发布版本初始化 ]]
if AppConfig.is_release or Target_Version == Target_Version_Name.TEST_ONLINE then

	AppConfig.is_digisky_sdk = false;--[[ ********是不是使用公司SDK版本******* ]]

	AppConfig.asst_path_shareof = "preloading@dynamicfont";--[[ASST特殊处理PATH:xxxx@xxxxx@xxxxx]]
	AppConfig.is_numerical_version = false; --[[数值测试版本]]
	AppConfig.new_player_script_recording = false;	  --[[新玩家消息脚本录制]]
	AppConfig.update_region = 1; --[[ 语言区域版本 1:中文 ]]

	AppConfig.enable_peak_show = true; --[[ 巅峰展示   true启用   false关掉 ]]
	AppConfig.enable_guide = true; --[[ 新手引导   true启用   false关掉 ]]
	AppConfig.enable_guide_tip = true; --[[ 引导提示   true启用   false关掉 ]]
	AppConfig.enable_on_line = false; --[[ 线上流程   true启用  false关掉 ]]
	AppConfig.enable_update_file = false; --[[ 文件动态更新   true启用  false关掉 ]]
	AppConfig.enable_keep_alive_check = false; --[[ 客户端主动心跳，SOCKET超时检查 ]]
	AppConfig.enable_reg_mail = false; --[[公司平台帐号邮箱注册 true启用  false关掉]]

	AppConfig.new_account_index = ""; --[[ ART版本修改设备ID  换号]]

	AppConfig.use_update_fserver = true;--[[更新模式：true=fserver,false=http web]]

	--[[ 系统DEBUG调试信息类 ]]
	AppConfig.error_url = "http://errorloggate.ghoul.ppgame.com:9321/webpost_ghoul.php"; --[[ HTTP ERROR URL]]
	AppConfig.is_write_file = false; --[[ 写信本地LOG true写入 ]]
	AppConfig.is_web_post = true; --[[ 向WEB提交信息 true提交 ]]
	AppConfig.is_debug_show = GameInfoForThis.Debug; --[[ 显示debug按钮 true显示 ]]
	AppConfig.is_debug_check = false; --[[ debug按钮点击事件 true接受点击 ]]
	AppConfig.is_effect_console_enable = false; --[[显示后期特效控制台]]
	AppConfig.is_format_log = true; --[[ 是否关掉所有日志打印（用于性能分析）true关掉所有日志 ]]

	--[[android]]
	AppConfig.system_list.android.system_check_httpurl = {
		[1] = "http://127.0.0.1/";--[[外网QA]]
	};
	AppConfig.system_list.android.system_check_filepath = "entry_service/entry_info.do?channel_id=%s&client_ver=%s&package_id=%s"; --[[ 入口HTTP PATH ]]
	AppConfig.system_list.android.effect_level_filepath = "entry_service/effect_level.do?device_model=%s";--[[特效等级PATH]]
	AppConfig.system_list.android.notice_info_path = "entry_service/notice_info.do";--[[维护公告PATH]]
	AppConfig.system_list.android.max_disk_space = 0;--[[系统最大缓存M]]
	AppConfig.system_list.android.app_id = "0002000200020020";
	AppConfig.system_list.android.user_center_key = "1234567890";
	AppConfig.system_list.android.game_id = "20"; --[[ 私有：与平台无关：GAME服务器匹配标示，与GAME配置一样才可以进入GAME 不修改]]
	AppConfig.system_list.android.platformchannel_id = "1008"; --[[渠道ID 支付使用的channel_id]]
	AppConfig.system_list.android.dtree_channle_id = "1008";--[[ DTREE的channel,如果不为空就以这个值去取DTREE，如果为空就以上面的真channel取去 进入GAME服也要传这个值 混服使用]]
	AppConfig.system_list.android.package_id = "gw"; --[[ 包标示 入口服需要值:package_id=%s 判断是不是需要更新APK]]
--	AppConfig.system_list.android.client_version = ""; --[[ 评审服标示 ：平台DTREE client_version的值]]
	AppConfig.system_list.android.game_version = "djzj"; --[[ 项目标示 ：平台DTREE djzj的值 不能修改]]

	AppConfig.system_list.android.im_appid = 1000233; --[[ IM ID ]]
	AppConfig.system_list.android.im_is_test = false; --[[ IM]]

	AppConfig.system_list.android.child_id = "0002";--[[申请值  不变 平台需求]]
	AppConfig.system_list.android.gameID = "0002";--[[申请值  不变 平台需求]]
	AppConfig.system_list.android.deviceid = "30000";--[[设备ID 对应下载什么平台的资源 平台需求]]
	AppConfig.system_list.android.fserver_version_number = 0;--[[fserver更新起始版本号]]

	--[[IOS]]
	AppConfig.system_list.ios.system_check_httpurl = {
		[1] = "http://127.0.0.1/";
	};
	AppConfig.system_list.ios.system_check_filepath = "entry_service/entry_info.do?channel_id=%s&client_ver=%s&package_id=%s"; --[[ 入口HTTP PATH ]]
	AppConfig.system_list.ios.effect_level_filepath = "entry_service/effect_level.do?device_model=%s";--[[特效等级PATH]]
	AppConfig.system_list.ios.notice_info_path = "entry_service/notice_info.do";--[[维护公告PATH]]
	AppConfig.system_list.ios.max_disk_space = 0;--[[系统最大缓存M]]
	AppConfig.system_list.ios.app_id = "0001000200020020";
	AppConfig.system_list.ios.user_center_key = "1234567890";
	AppConfig.system_list.ios.game_id = "20"; --[[ 私有：与平台无关：GAME服务器匹配标示，与GAME配置一样才可以进入GAME 不修改]]
	AppConfig.system_list.ios.platformchannel_id = "2001"; --[[渠道ID 支付使用的channel_id]]
	AppConfig.system_list.ios.dtree_channle_id = "2001";--[[ DTREE的channel,如果不为空就以这个值去取DTREE，如果为空就以上面的真channel取去]]
	AppConfig.system_list.ios.package_id = "gw_ios"; --[[ 包标示 入口服需要值:package_id=%s 判断是不是需要更新APK]]
--	AppConfig.system_list.ios.client_version = ""; --[[ 评审服标示 ：平台DTREE client_version的值]]
	AppConfig.system_list.ios.game_version = "djzj"; --[[ 项目标示 ：平台DTREE djzj的值 不能修改]]

	AppConfig.system_list.ios.im_appid = 1000233; --[[ IM ID ]]
	AppConfig.system_list.ios.im_is_test = false; --[[ IM]]

	AppConfig.system_list.ios.child_id = "0002";--[[申请值  不变 平台需求]]
	AppConfig.system_list.ios.gameID = "0002";--[[申请值  不变 平台需求]]
	AppConfig.system_list.ios.deviceid = "10102";--[[平台需求]]
	AppConfig.system_list.ios.fserver_version_number = 0;--[[fserver更新起始版本号]]


	if Target_Version == Target_Version_Name.TEST_ONLINE then
		--[[预发布开启GM]]
		AppConfig.enable_zy_gm = true; --[[ 是否启用zy的gm命令   true启用  false关掉 ]]

		--[[ 系统DEBUG调试信息类 ]]
		AppConfig.is_write_file = true; --[[ 写信本地LOG true写入 ]]
		AppConfig.is_web_post = false; --[[ 向WEB提交信息 true提交 ]]
		AppConfig.is_debug_show = GameInfoForThis.Debug; --[[ 显示debug按钮 true显示 ]]
		AppConfig.is_debug_check = false; --[[ debug按钮点击事件 true接受点击 ]]
		AppConfig.is_effect_console_enable = false; --[[显示后期特效控制台]]
		AppConfig.is_format_log = false; --[[ 是否关掉所有日志打印（用于性能分析）true关掉所有日志 ]]

		--[[android]]
		AppConfig.system_list.android.system_check_httpurl = {
			[1] = "http://ghoul-adr-cn-pre-login-0001.ppgame.com:8080/" --[[预发布服]]
		};

		--[[IOS]]
		AppConfig.system_list.ios.system_check_httpurl = {
			[1] = "http://ghoul-adr-cn-pre-login-0001.ppgame.com:8080/" --[[预发布服]]
		};
	end

	if AppConfig.is_release then
		--[[ 系统DEBUG调试信息类 ]]
		AppConfig.is_write_file = true; --[[ 写信本地LOG true写入 ]]
		AppConfig.is_web_post = false; --[[ 向WEB提交信息 true提交 ]]
		AppConfig.is_debug_show = GameInfoForThis.Debug; --[[ 显示debug按钮 true显示 ]]
		AppConfig.is_debug_check = false; --[[ debug按钮点击事件 true接受点击 ]]
		AppConfig.is_effect_console_enable = false; --[[显示后期特效控制台]]
		AppConfig.is_format_log = true; --[[ 是否关掉所有日志打印（用于性能分析）true关掉所有日志 ]]

		AppConfig.enable_reg_mail = false; --[[公司平台帐号邮箱注册 true启用  false关掉]]

		--[[android]]
		AppConfig.system_list.android.system_check_httpurl = {
			[1] = "http://ghoul-adr-cncs-cbt-login-0001.ppgame.com:8080/";--[[正式线上服]]
		};

		--[[IOS]]
		AppConfig.system_list.ios.system_check_httpurl = {
			[1] = "http://ghoul-ios-cn-ps-login-001.ppgame.com:8080/";--[[正式线上服]]
		};

		Target_Version = nil; --[[取消DEBUG标志]]
	end

end


----------------------------------------------------- [[正式版线上服发布 不准修改 end]]---------------------------------------------------------------------------------

--[[ 是否关掉所有日志输出 ]]
if AppConfig.is_format_log then
	local temp = { 0 };
	local b_info = systems_func.BitOr(temp);
	app.set_log_level(b_info);
	-- *@param type 打印等级相与(int) 0 => Nothing, 1 => Lua, 2 => Normal, 4 = > Object, 8 => Socket, 16 => Important, 32 => Emergy
	temp = { 2, 4 };
	b_info = systems_func.BitOr(temp);
	app.set_log_open_flag(b_info);
	-- open_flag 打印标识相与(int) 0 => Nothing, 1 => Log, 2 => Warning, 4 = > Error

	app.log = function() end; --[[取消LOG]]
	app.log_warning = function() end; --[[取消WAR]]
end

--------------------------------- [[通用]]----------------------------------------
--[[ 得到设备ID ]]
function AppConfig.get_deviceuniqueidentifier()
	if Target_Version == Target_Version_Name.ART then
		return Root.get_deviceuniqueidentifier() .. AppConfig.new_account_index;
	else
		return Root.get_deviceuniqueidentifier();
	end
end

--[[ 是否跳过巅峰展示 ]]
function AppConfig.get_enable_peak_show()
	return AppConfig.enable_peak_show;
end

--[[ 是否跳过新手引导 ]]
function AppConfig.get_enable_guide()
	return AppConfig.enable_guide;
end

--[[ 是否跳过引导提示 ]]
function AppConfig.get_enable_guide_tip()
	if Socket.get_socketgame() then
		return AppConfig.enable_guide_tip;
	else
		return false
	end
end

--[[ 线上流程 ]]
function AppConfig.get_enable_on_line()
	return AppConfig.enable_on_line;
end

--[[ FILE热更新 ]]
function AppConfig.get_enable_update_file()
	return AppConfig.enable_update_file;
end

--[[ 公司平台帐号邮箱注册 ]]
function AppConfig.get_enable_reg_mail()
	return AppConfig.enable_reg_mail;
end

--[[ 得到客服Url地址 ]]
function AppConfig.get_kefu_url(appid, server_id, accountid, playername_playerid)
	return string.format(AppConfig.kefu_url, appid, server_id, accountid, playername_playerid);
end

--[[ 得到问卷Url地址 ]]
function AppConfig.get_question_url()
	--[[ 正式版 ]]
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_question_url();
	else
		return AppConfig.question_url;
	end
end

--[[ 得到ERROR URL ]]
function AppConfig.get_error_url()
	return AppConfig.error_url;
end

--[[ 写信本地LOG ]]
function AppConfig.get_is_write_file()
	return AppConfig.is_write_file;
end

--[[ 向WEB提交信息 ]]
function AppConfig.get_is_web_post()
	return AppConfig.is_web_post;
end

--[[ 写入本地LOG ]]
function AppConfig.get_is_write_file()
	return AppConfig.is_write_file;
end

--[[ 显示debug按钮 ]]
function AppConfig.get_is_debug_show()
	return AppConfig.is_debug_show;
end

--[[ debug按钮点击事件 ]]
function AppConfig.get_is_debug_check()
	return AppConfig.is_debug_check;
end

function AppConfig.get_is_effect_console_enable()
	return AppConfig.is_effect_console_enable;
end

--[[ 日志开关 ]]
function AppConfig.get_game_log_is_open()
	if Root.get_os_type() == 8 or Root.get_os_type() == 1 then
		return true;
	else
		return false;
	end
end

--[[ 帐号务器URL ]]
function AppConfig.get_account_url()
	--[[ 正式版 ]]
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_auth_server_list();
	else
		if Root.get_os_type() == 8 then
			return AppConfig.system_list.ios.auth_server_url[1];
		else
			return AppConfig.system_list.android.auth_server_url[1];
		end
	end
end

function AppConfig.get_auth_server_path()
		--[[ 正式版 ]]
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_auth_server_path();
	else
		if Root.get_os_type() == 8 then
			return AppConfig.system_list.ios.auth_server_path;
		else
			return AppConfig.system_list.android.auth_server_path;
		end
	end
end

--[[ dtree url]]
function AppConfig.get_dtree_server_url()
	--[[ 正式版 ]]
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_dtree_server_list();
	else
		if Root.get_os_type() == 8 then
			return AppConfig.system_list.ios.dtree_server_url[1];
		else
			return AppConfig.system_list.android.dtree_server_url[1];
		end
	end
end

--[[ dtree例表PATH ]]
function AppConfig.get_dtree_server_path()
	--[[ 正式版 ]]
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_dtree_server_path();
	else
		if Root.get_os_type() == 8 then
			return AppConfig.system_list.ios.dtree_server_path[1];
		else
			return AppConfig.system_list.android.dtree_server_path[1];
		end
	end
end

--[[ 游戏语言版本 ]]
function AppConfig.get_update_region()
	return AppConfig.update_region;
end

--[[ 得到包版本号: x.x.x]]
function AppConfig.get_package_version()
	return AppConfig.package_version1.."."..AppConfig.package_version2.."."..AppConfig.package_version3;
end

--[[ 得到包版本号: x_x_x]]
function AppConfig.get_package_version_x()
	local temp = "cn";
	if AppConfig.get_update_region() == 1 then
		temp = "cn";
	end
	return temp.."_"..AppConfig.package_version1.."_"..AppConfig.package_version2.."_"..AppConfig.package_version3;
end

--[[得到灰度服PATH]]
function AppConfig.get_gray_path()
	return AppConfig.gray_path;
end



--[[版本文件PATH]]
function AppConfig.get_version_path()
	return AppConfig.version_path;
end

--[[灰度服版本文件PATH]]
function AppConfig.get_version_gray_path()
	return AppConfig.version_gray_path;
end

--[[设定文件中的资源号]]
function AppConfig.set_package_ass_ver()
	local temp_num = 0;
	local file_handler = nil;

	if Root.get_is_gray() then
		--[[灰度]]
		file_handler = file.open(AppConfig.get_version_gray_path(), 4)
	else
		--[[正式]]
		file_handler = file.open(AppConfig.get_version_path(), 4)
	end

	if file_handler ~= nil then
		local version = file_handler:read_line();
		file_handler:close();
		if version ~= nil then
			temp_num = version;
		end
	end
	AppConfig.package_ass_ver = tostring(temp_num);
end

--[[得到资源版本号:0]]
function AppConfig.get_package_ass_ver()
	return AppConfig.package_ass_ver;
end

--[[系统初始化时，读取本地版本号，包内版本号与热更新版本号共同判断]]
function AppConfig.get_apk_res_version()

	local local_version = 0;
	local file_handler = nil;

	if Root.get_is_gray() then
		--[[灰度]]
		file_handler = file.open(AppConfig.get_version_gray_path(), 4)
	else
		--[[正式]]
		file_handler = file.open(AppConfig.get_version_path(), 4)
	end

	if file_handler == nil then
		app.log("no have version.txt");
		return local_version;
	end
	local version = file_handler:read_string()
	if version ~= nil and version ~= "" then
		--[[check num]]
		if tonumber(version) ~= nil then
			if tonumber(version) > 0 then
				local_version = tonumber(version);
			end
		end
		app.log("read version number:"..local_version)
	end
	file_handler:close()

	local temp_num = 0;

	--[[包内版本号不为0]]
	if local_version > AppConfig.get_fserver_version_number() then
		--[[本地文件读出来的版本大于包内版本号，说明已经更新过了，所以使用本地文件读出来的版本号进行更新 舍弃包内预值版本号]]
		temp_num = local_version;
	else
		--[[本地文件读出来的版本号小于包内版本号，说明包内比包外新，直接使用包内的版本号]]
		temp_num = AppConfig.get_fserver_version_number();
	end

	return temp_num;
end

--[[系统最大缓存]]
function AppConfig.get_max_disk_space()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.max_disk_space;
	else
		return AppConfig.system_list.android.max_disk_space;
	end
end

--[[得到ASST特殊处理PATH]]
function AppConfig.get_asst_path_shareof()
	return AppConfig.asst_path_shareof;
end

--[[ 得到系统启动URL地址 ]]
function AppConfig.get_system_check_httpurl()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.system_check_httpurl;
	else
		return AppConfig.system_list.android.system_check_httpurl;
	end
end

--[[ 得到系统启动URL地址后半部份 ]]
function AppConfig.get_system_check_filepath()
	if Root.get_os_type() == 8 then
		local strurl = AppConfig.system_list.ios.system_check_filepath;
		local str_channel = AppConfig.get_dtree_channle_id();
		local str_version = AppConfig.get_package_version();
		local str_package = AppConfig.get_package_id();
		return string.format(strurl, str_channel, str_version, str_package);
	else
		local strurl = AppConfig.system_list.android.system_check_filepath;
		local str_channel = AppConfig.get_dtree_channle_id();
		local str_version = AppConfig.get_package_version();
		local str_package = AppConfig.get_package_id();
		return string.format(strurl, str_channel, str_version, str_package);
	end
end

--[[ 得到特效等级url地址后半部分 ]]
function AppConfig.get_effect_level_filepath()
	local str_device_model = util.get_devicemodel();
	str_device_model = string.gsub(str_device_model, " ","_");
	if Root.get_os_type() == 8 then
		local strurl = AppConfig.system_list.ios.effect_level_filepath;
		return string.format(strurl, str_device_model);
	else
		local strurl = AppConfig.system_list.android.effect_level_filepath;
		return string.format(strurl, str_device_model);
	end
end

--[[ 得到维护公告url地址后半部分 ]]
function AppConfig.get_notice_info_path()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.notice_info_path;
	else
		return AppConfig.system_list.android.notice_info_path;
	end
end


--[[ 得到包标示 ]]
function AppConfig.get_package_id()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.package_id;
	else
		return AppConfig.system_list.android.package_id;
	end
end

--[[ 得到评审标示 使用区域版本+版本号代替：cn_1_1_1]]
function AppConfig.get_client_version()
	if Root.get_os_type() == 8 then
		return AppConfig.get_package_version_x();
--		return AppConfig.system_list.ios.client_version;
	else
		return AppConfig.get_package_version_x();
--		return AppConfig.system_list.android.client_version;
	end
end

--[[ 得到DTREEGAME标示 ]]
function AppConfig.get_game_version()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.game_version;
	else
		return AppConfig.system_list.android.game_version;
	end
end

--------------------------------- [[运营接口]]----------------------------------------
--[[ app_id ]]
function AppConfig.get_app_id()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.app_id;
	else
		return AppConfig.system_list.android.app_id;
	end
end

--[[ user_center_key ]]
function AppConfig.get_user_center_key()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.user_center_key;
	else
		return AppConfig.system_list.android.user_center_key;
	end
end

--[[ game_id ]]
function AppConfig.get_game_id()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.game_id;
	else
		return AppConfig.system_list.android.game_id;
	end
end

--[[ digisky_game_id ]]
function AppConfig.get_digisky_game_id()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.gameID;
	else
		return AppConfig.system_list.android.gameID;
	end
end

--[[ deviceid ]]
function AppConfig.get_deviceid()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.deviceid;
	else
		return AppConfig.system_list.android.deviceid;
	end
end

--[[ fserver更新起始版本号 ]]
function AppConfig.get_fserver_version_number()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.fserver_version_number;
	else
		return AppConfig.system_list.android.fserver_version_number;
	end
end

--[[ child_ID ]]
function AppConfig.get_child_ID()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.child_id;
	else
		return AppConfig.system_list.android.child_id;
	end
end

----[[ 是不是官方 ]]
--function AppConfig.get_check_official()
--	--[[是不是APPSTORE]]
--	if AppConfig.get_check_appstore() then
--		return true;
--	end
--	--[[GOOGLE PAY？]]
--
--	if AppConfig.get_platformchannel_id() == AppConfig.get_officialchannle_id() then
--		return true;
--	else
--		return false;
--	end
--end

--[[得到支付类型 公司平台支付
--//10-充值卡支付  11-支付宝支付  12-appstore支付   13-google支付  14-联运   15-易联支付 16-官网微信
-- ]]
function AppConfig.get_pay_type()
	if Root.get_os_type() == 8 then
		return 12;
	else
		if AppConfig.get_platformchannel_id() == "1008" then
			return 11;--[[安卓官网：支付宝]]
		else
			return 14;--[[安卓渠道：14]]
		end
	end
end

--[[是不是公司平台SDK]]
function AppConfig.get_check_digisky()
	return AppConfig.is_digisky_sdk;
end

--[[是不是APPSTORE]]
function AppConfig.get_check_appstore()
	--if AppConfig.get_platformchannel_id() == AppConfig.get_officialchannle_id() and Root.get_os_type() == 8 then
	if Root.get_os_type() == 8 then
		return true;
	else
		return false;
	end
end

--[[是不是官网]]
function AppConfig.get_check_digisky_channel()
	if AppConfig.get_platformchannel_id() == "1008"then
		return true;
	else
		return false;
	end
end

--[[是不是腾讯SDK    100000:qq  100001:wx]]
function AppConfig.get_check_tencent()
	if AppConfig.get_platformchannel_id() == "100000" or AppConfig.get_platformchannel_id() == "100001" then
		return true;
	else
		return false;
	end
end

--[[是不是UC SDK]]
function AppConfig.get_check_uc()
	if AppConfig.get_platformchannel_id() == "10002"then
		return true;
	else
		return false;
	end
end

--[[ 得到支付渠道ID ]]
function AppConfig.get_platformchannel_id()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.platformchannel_id;
	else
		return AppConfig.system_list.android.platformchannel_id;
	end
end

--[[ 得到DTREE渠道ID ]]
function AppConfig.get_dtree_channle_id()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.dtree_channle_id;
	else
		return AppConfig.system_list.android.dtree_channle_id;
	end
end

--[[ 得到tree名 ]]
function AppConfig.get_channel_name()
	return AppConfig.get_platformchannel_id();
end

--[[得到更新类型 ]]
function AppConfig.get_use_update_fserver()
	return AppConfig.use_update_fserver;
end

--------------------------------- [[socket接口]]----------------------------------------
---- [[文件更新IP]]
-- function AppConfig.get_socket_update_ip()
-- if AppConfig.update_role == 1 then
-- return AppConfig.socket.art.update_ip;
-- else
-- local temp = systems_data.get_res_update_server_list();
-- if table.getn(temp) > 0 then
-- if temp[1] ~= nil then
-- app.log("动态SOCKET IP："..tostring(temp[1].ip));
-- return temp[1].ip;
-- end
-- end
-- return AppConfig.socket.release.update_ip;
-- end
-- end
---- [[文件更新端口]]
-- function AppConfig.get_socket_update_port()
-- if AppConfig.update_role == 1 then
-- return AppConfig.socket.art.update_port;
-- else
-- local temp = systems_data.get_res_update_server_list();
-- if table.getn(temp) > 0 then
-- if temp[1] ~= nil then
-- return temp[1].port;
-- end
-- end
-- return AppConfig.socket.release.update_port;
-- end
-- end
---- [[文件更新设备号]]
-- function AppConfig.get_socket_update_device_id()
-- if AppConfig.update_role == 1 then
-- return AppConfig.socket.art.update_device_id;
-- else
-- return AppConfig.socket.release.update_device_id;
-- end
-- end
---- [[文件更新初始版本号]]
-- function AppConfig.get_socket_update_version_number()
-- if AppConfig.update_role == 1 then
-- return AppConfig.socket.art.update_version_number;
-- else
-- return AppConfig.socket.release.update_version_number;
-- end
-- end

--------------------------------- [[自己写的  http接口   str]]----------------------------------------
--[[ OP地址 ]]
function AppConfig.get_http_op_url()
	--[[ 线上 ]]
	if AppConfig.get_enable_on_line() then
		return systems_data.get_ver_update_server_list();
	end

	if AppConfig.update_role == 0 then
		return AppConfig.http.release.check_op;
	elseif AppConfig.update_role == 1 then
		return AppConfig.http.art.check_op;
	else
		return "";
	end
end

--[[ 资源下载地址URL ]]
function AppConfig.get_http_down_url()
	--[[ 线上 ]]
	if AppConfig.get_enable_on_line() then
		return systems_data.get_res_update_server_list();
	end

	if AppConfig.update_role == 0 then
		return AppConfig.http.release.down_url;
	elseif AppConfig.update_role == 1 then
		return AppConfig.http.art.down_url;
	else
		return "";
	end
end

--[[ 文件更新设备号 ]]
function AppConfig.get_http_resource_root()
	--[[ 正式版 ]]
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_ver_update_server_list_path();
	else
		if AppConfig.update_role == 0 then
			return AppConfig.http.release.update_device_id;
		elseif AppConfig.update_role == 1 then
			return AppConfig.http.art.update_device_id;
		else
			return 0;
		end
	end
end

--[[ 文件更新初始版本号 ]]
function AppConfig.http_platform_update()
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return 0;
	end

	if AppConfig.update_role == 0 then
		return AppConfig.http.release.update_version_number;
	elseif AppConfig.update_role == 1 then
		return AppConfig.http.art.update_version_number;
	else
		return 0;
	end
end

--------------------------------- [[自己写的  http接口   end]]----------------------------------------


--------------------------------- [[Fserver更新 str]]----------------------------------------
--[[fserver check url]]
function AppConfig.get_fserver_check_url()
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_ver_update_server_list();
	end
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.fserver_check_url[1];
	else
		return AppConfig.system_list.android.fserver_check_url[1];
	end
end

--[[fserver check file path]]
function AppConfig.get_fserver_check_op_path()
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_ver_update_server_list_path();
	end
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.fserver_check_path;
	else
		return AppConfig.system_list.android.fserver_check_path;
	end

end

--[[fserver down url]]
function AppConfig.get_fserver_down_url()
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_res_update_server_list();
	end
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.fserver_down_url[1];
	else
		return AppConfig.system_list.android.fserver_down_url[1];
	end
end

--[[fserver down path]]
function AppConfig.get_fserver_down_path()
	if AppConfig.is_release or Target_Version == Target_Version_Name.QA or Target_Version == Target_Version_Name.TEST_ONLINE then
		return systems_data.get_res_update_server_list_path();
	end
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.fserver_down_path;
	else
		return AppConfig.system_list.android.fserver_down_path;
	end
end

--------------------------------- [[Fserver更新 end]]----------------------------------------

--[[数值测试版本]]
function AppConfig.get_is_numerical_version()
	return AppConfig.is_numerical_version;
end

--[[新玩家消息脚本录制]]
function AppConfig.get_new_player_script_recording()
	return AppConfig.new_player_script_recording;
end

--[[ 客户端主动心跳 ]]
function AppConfig.get_enable_keep_alive_check()
	return AppConfig.enable_keep_alive_check;
end

--[[ 获取im_appid ]]
function AppConfig.get_im_appid()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.im_appid;
	else
		return AppConfig.system_list.android.im_appid;
	end
end

--[[ 获取imtest ]]
function AppConfig.get_im_is_test()
	if Root.get_os_type() == 8 then
		return AppConfig.system_list.ios.im_is_test;
	else
		return AppConfig.system_list.android.im_is_test;
	end
end
--[[ 获取实名认证查询Url ]]
function AppConfig.get_realname_auth_cmd_url()
	return AppConfig.realname_auth_cmd_url
end

--[[ 获取实名认证Url ]]
function AppConfig.get_realname_auth_url(appid,openid,accounttype)
	return string.format(AppConfig.realname_auth_url,appid,openid,accounttype or 0)
end


function AppConfig.get_enable_async_asset_deferred_release()
	--	return AppConfig.enable_async_asset_deferred_release;
	return false;
end

function AppConfig.get_enable_3rdparty_compression()
	--	return AppConfig.enable_3rdparty_compression;
	return false;
end

--[[得到排队URL]]
function AppConfig.get_digisky_queue_url()
	return AppConfig.digisky_queue_url;
end
--[[得到排队URL]]
function AppConfig.get_digisky_queue_path()
	return AppConfig.digisky_queue_path;
end

------------------------------------------------

function AppConfig.is_upload_resource_record()
	return AppConfig.upload_resource_record;
end


--[[ 打包标示 ]]
script.run("logic/app_config/app_config_package.lua");
app.log("package_id>>>>>>>"..AppConfig.get_package_id());
app.log("dtree_channle_id>>>>>>>"..AppConfig.get_dtree_channle_id());
