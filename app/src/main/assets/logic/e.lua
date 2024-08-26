--[[
	入口文件 e.lua
]]
Root = {
    lua_name = ".lua";--[[LUA后缀名]]
    is_gray = false;--[[是不是读取灰度服资源]]
    deviceuniqueidentifier = nil;--[[U3D设备ID]]
    start_time = 0;--[[客户启动时间]]
    os_type = 11;--[[系统类型]]
    network_type = 0;--[[网络类型]]
    maincamera = nil;--[[主像机]]
    uiroot = nil;
    uicamera_obj = nil;
    uicamera = nil;

    coroutineID = 1;--[[协程ID]]
    coroutine_name = nil;--[[协程名]]

    root_font1_fzcsjw = nil;--[[字体]]
    root_font2_fzy4jw = nil;--[[字体]]
    root_font3_fzhtk = nil;--[[字体]]
    root_ui_2d = nil;--[[UI绑定的父对像]]
    root_ui_2d_fight = nil;--[[战斗UI绑定的父对像]]
    -- ui_public_atlas = nil;
	-- ui_public_ob_atlas = nil;
    ui_specific_atlas = nil;
    ui_guild_atlas = nil;
	ui_public_atlas = nil;
	art_font_ob_atlas = nil;

    root_s3d = nil;
    root_s3d_camera = nil;
    root_s3d_camera_render = nil;
    root_s3d_cube = nil;--[[S3D绑定的父对像]]

    Update_list = {};--[[回调集合]]
    fixedUpdate_list = {};--[[回调集合]]
    LateUpdate_list = {};--[[回调集合]]
    coroutine_list = {};--[[协程]]
    touch_list = {};--[[全局屏幕事件]]

    script_module = {};--[[LUA加载记录]]

    app_is_backstage = false;--[[APP是不是在后台,true 退到后面   false回到前台]]
    loop_count = 0;--[[退后台计数1秒一次]]
    loop_max_time = 60 * 60 * 24;--[[后台线程存活最大时间，单位：秒]]
    loop_close_socket = 60 * 2;--[[断SOCKET时间，单位：秒]]
    loop_game_quit = 60 * 60 * 24;--[[主动退出游戏时间，单位：秒]]

    used_system_info_urllist = {};--[[入口服使用过的例表]]
    use_system_info_max_num = 2;--[[入口服URL重试次数]]
    use_system_url = "";--[[正在使用的入口服地址]]
}
--游戏信息
GameInfoForThis = {
	ServerName = "水晶大厦";
	NoteTital = "欢迎回来";
	NoteInfo = "欢迎回到《东京战纪》，致那段已经逝去的青春。\n本游戏为残端，免费分享，无任何盈利，请勿随意外传。\n开源地址：https://github.com/ZUXTUO/Tokyo-Guru-War-Age-Origin-Offline";
	SceneInfo = nil;		--logic\message\message_enum.lua
	--LoadNum = 0;	--载入流程（测试）
    IsTeach = true;
    UserName = "测试账号";--用户名
    Exp = 99999999;--经验值
	Level = 150;--等级
	Vip = 10;--VIP等级
    Gold = 9999999;--金币
	Crystal = 9999999;--钻石
	Red_crystal = 9999999;--红钻
    Debug = true;--Debug按钮
    TellStr = "如有任何疑问欢迎进入游戏后联系客服咨询，\n咨询方式：依次点击头像-联系客服，\n不过东京战纪已经关服了，所以……";
    SceneTest = 0; --0是从头开始，3直接进入主城
    needSkip = true;--是否启动跳转序章选择窗口
    teams = {
	    {"6167577387891490818","6167577387891474434","6169349534347444226"},{},{}
	}
}

asset_loader.enable_shared_atlas_load(true);
asset_loader.set_load_type(1);		--设置为0-WWW加载，1-异步加载LoadFromFileAsync，2-同步加载LoadFromFile
----------------------------------------------[[重载底层必要函数 非必需不能修改 str]]-------------------------------------------------------------
--[[ 初始化随机函数函数 ]]
--math.randomseed(os.time());
math.randomseed(tostring(os.time()):reverse():sub(1, 7));
math.random(0, 10000);

--[[ 修改script.run函数, 保证只run一次 ]]
script.load = script.run;
function script.run(name)
    --app.log_warning(name)
    --[[ 判断包里面的后缀名 ]]
	--app.log("判断包里面的后缀名")
    if nil == name then
        app.log(debug.traceback())
    end
    local path = string.gsub(name, "%.lua", Root.lua_name);
    if nil == Root.script_module[path] then
        Root.script_module[path] = script.load(path) or true
    end
    return Root.script_module[path];
end

Root.start_time = os.time() * 1000;
Root.deviceuniqueidentifier = util.get_deviceuniqueidentifier();
Root.os_type = app.get_os_type();
Root.network_type = app.get_internet_reach_ability();

--[[ 判断LUA后缀名]]
if file.read_exist("logic/e.lc") then
    app.log("lua process YES");
    Root.lua_name = ".lc";
else
    app.log("lua process NO");
    Root.lua_name = ".lua";
end

--[[判断是不是读取灰度服资源]]
if file.write_exist("gray.txt") then
    app.log("grayp: YES");
    Root.is_gray = true;
else
    app.log("grayp: NO");
    Root.is_gray = false;
end

--[[得到正在使用的入口服地址]]
function Root.get_use_system_url()
	return Root.use_system_url;
end

--[[判断清理GRAY目录]]
function Root.clear_gray()

	local local_version = 0;
	local local_gray_version = 0;

	--[[灰度]]
	local gray_file_handler = file.open(AppConfig.get_version_gray_path(), 4);
	--[[正式]]
	local file_handler = file.open(AppConfig.get_version_path(), 4);

	if file_handler == nil or gray_file_handler == nil then
		app.log("not gray ver!!");
		--[[清理完再INIT]]
		Root.str();
		return;
	end

	local version = file_handler:read_string();
	if version ~= nil and version ~= "" then
		--[[check num]]
		if tonumber(version) ~= nil then
			if tonumber(version) > 0 then
				local_version = tonumber(version);
			end
		end
		app.log("read version number:"..local_version)
	end

	local gray_version = gray_file_handler:read_string();
	if gray_version ~= nil and gray_version ~= "" then
		--[[check num]]
		if tonumber(gray_version) ~= nil then
			if tonumber(gray_version) > 0 then
				local_gray_version = tonumber(gray_version);
			end
		end
		app.log("read local_gray_version number:"..local_version)
	end

	file_handler:close();
	gray_file_handler:close();

	if local_version >= local_gray_version then
		--[[执行清理]]
		app.log(local_version.."del gray!!!!"..local_gray_version);
		file.delete_dir("gray",true);
		timer.create("Root.str", 400, 1);
	else
		app.log("gray no del");
		--[[清理完再INIT]]
		Root.str();
	end

end

function gcallerr(msg)
    app.log(debug.traceback(msg, 2))
end

----*********************>>>>>>>>>>[[系统级初始化，避免干扰，私用]]<<<<<<<*********************
script.run "logic/systems/systems_func.lua";
----*********************>>>>>>>>>>[[系统级初始化，避免干扰，私用]]<<<<<<<*********************

--[[ 空方法 ]]
function Root.empty_func() end
--[[ 向WEB发送信息  info_type:自定义类型（查找KEY），str:内容 ]]
function Root.push_web_info(str_info_type, str)
    util.push_web_info(tostring(str_info_type), tostring(str));
end
--[[灰度标示]]
function Root.get_is_gray()
	return Root.is_gray;
end
--[[得到account ID     供C# WEB日志使用，必需不报错]]
function Root.get_account_id()
    local id = "";
    if UserCenter ~= nil then
        if UserCenter.get_accountid ~= nil then
            id = tostring(UserCenter.get_accountid());
        end
    end
    return id;
end
--[[得到角色ID     供C# WEB日志使用，必需不报错]]
function Root.get_player_id()
    local id = "";
    if g_dataCenter ~= nil then
        if g_dataCenter.player ~= nil then
            id = tostring(g_dataCenter.player.playerid);
        end
    end
    return id;
end
--[[得到角色名	供C# WEB日志使用，必需不报错]]
function Root.get_player_name()
    local name = "";
    if g_dataCenter ~= nil then
        if g_dataCenter.player ~= nil then
            name = tostring(g_dataCenter.player.name);
        end
    end
    return name;
end
--[[得到包版本   供C# WEB日志使用，必需不报错]]
function Root.get_package_version()
    return AppConfig.get_package_version()
end

--[[得到资源版本   供C# WEB日志使用，必需不报错]]
function Root.get_res_version()
    return tostring(AppConfig.get_package_ass_ver())
end

--[[ LUA堆栈信息 ]]
function Root.get_dumptracebackex()
    return "\n{\n" .. Root.tracebackex(1, 1) .. "\n}";
end
--[[ len表的深度,type1只打最后一条,2全打印 ]]
function Root.tracebackex(len, type)
    if len == nil then len = 1 end
    if type == nil then type = 1 end
    local strtxt = ""
    local level = 4;
    strtxt = strtxt .. "\n-----------------------------------Lua堆栈信息---------------------------------------\n"

    while true do
        -- get stack info
        local info = debug.getinfo(level)
        if not info then
            break;
        end

        local whatisit = "未知类型";
        if info.what == "Lua" then
            whatisit = "Lua函数";
        elseif info.what == "C" then
            whatisit = "C函数";
        elseif info.what == "main" then
            whatisit = "语句段main部分";
        elseif info.what == "tail" then
            whatisit = "尾部调用函数";
        end
        strtxt = strtxt .. "类型:" .. whatisit .. "\n";

        -- 排错检查
        -- 	if info.short_src==nil then
        -- 		strtxt = strtxt .. "info.short_src is nil\n";
        -- 	else
        -- 		strtxt = strtxt .. "info.short_src is "..info.short_src.."\n";
        -- 	end
        -- 	if info.currentline==nil then
        -- 		strtxt = strtxt .. "info.currentline is nil\n";
        -- 	else
        -- 		strtxt = strtxt .. "info.currentline is "..info.currentline.."\n";
        -- 	end
        -- 	if info.name==nil then
        -- 		strtxt = strtxt .. "info.name is nil\n";
        -- 	else
        -- 		strtxt = strtxt .. "info.name is "..info.name.."\n";
        -- 	end
        -- 	if info.linedefined==nil then
        -- 		strtxt = strtxt .. "info.linedefined is nil\n";
        -- 	else
        -- 		strtxt = strtxt .. "info.linedefined is "..info.linedefined.."\n";
        -- 	end



        local fname = info.name;
        if fname == nil then
            fname = "line:" .. info.linedefined;
        end

        if info.what == "C" then
            -- C function
            strtxt = strtxt .. tostring(level) .. "\tC function\n"
        else
            -- Lua function
            strtxt = strtxt .. string.format("\t [%s] \n\t %s: \n\t line:%d in function `%s`\n", info.source, info.short_src, info.currentline, fname);
            -- 	strtxt = strtxt .. string.format("\t [%s]: \n\t line:%d in function `%s`\n", info.source, info.currentline, fname);
        end


        -- 	do return strtxt end;


        -- get local vars
        local i = 1
        local error_line = "";
        while true do
            local name, value = debug.getlocal(level, i)
            -- 这里可能堆栈会很大,一定记得给个范围跳出去

            if type == 1 then
                if not name then
                    strtxt = strtxt .. error_line;
                    break;
                else
                    error_line = "\t\t" .. name .. " =\t" .. Root.tostringex(value, len) .. "\n";
                end
            elseif type == 2 then
                if not name then
                    break;
                end
                strtxt = strtxt .. "\t\t" .. name .. " =\t" .. Root.tostringex(value, len) .. "\n";
            end
            i = i + 1;
        end
        -- 	gsystem.debuglog(strtxt);
        strtxt = strtxt .. "--------------------------------------------------------------------------\n";
        level = level + 1

        -- 堆栈超过这个级别后跳出去,否则会无法报出错误行数
        if level > 10 then
            break;
        end
    end
    -- strtxt = strtxt .. "==Lua堆栈信息 结束=="

    return strtxt;
end
--[[ 格式化TABLE ]]
function Root.tostringex(v, len)
    if len == nil then len = 10 end
    local pre = string.rep("\t\t", len)
    local ret = ""

    if type(v) == "table" then
        if len <= 0 then return "\t\[ ... \]" end
        local t = ""
        for k, v1 in pairs(v) do
            t = t .. "\n\t" .. pre .. tostring(k) .. ":"
            t = t .. Root.tostringex(v1, len - 1)
        end

        if t == "" then
            ret = ret .. pre .. "\[ \]\t\(" .. tostring(v) .. "\)"
        else
            if len > 0 then
                ret = ret .. "\t\(" .. tostring(v) .. "\)\n"
            end

            ret = ret .. pre .. "\[" .. t .. "\n" .. pre .. "\]"
        end
    else
        ret = ret .. pre .. tostring(v) .. "\t\(" .. type(v) .. "\)"
    end

    return ret;
end
--[[ 退出游戏 ]]
function Root.quit()
	if UserCenter then
		UserCenter.get_sdk_push_info("logout");
	end
    util.quit();
end
--[[ 清除动态更新文件 只有安装APK时调用一次，其他时候不准调用 ]]
function Root.clear_doc()
    app.log("Root clear all doc!!!!!!!!"..os.time());
    --[[清理系统解压缓存]]
    app.clean_cache();
    --[[ 删除目录 ]]
    file.delete_dir("assetbundles", true);
    file.delete_dir("logic", true);
    file.delete_dir("gray", true);
    file.delete_dir("UnityCache", true);--[[系统解压缓存目录]]
    --[[ 删除本地文件 ]]
--    file.delete("loginfile");--[[帐号保留]]
    file.delete("package.data");
    file.delete("version.txt");
    file.delete("version_file_list.txt");

    script.run("logic/systems/del_file.lua");--[[ 清理自定义目录 ]]
    del_file.clear();
    app.log(">>>>del time="..os.time());
    --[[写package号]]
    timer.create("Root.writer_package", 10, 1);
end
----[[得到android_id 这玩意没有U3D唯一ID好用，仅提供，不要用]]
-- function Root.get_android_id()
-- local device_id = "0";
-- if Root.get_os_type() == 11 then
-- 	device_id = app.get_device_info_by_key("android_id");
-- elseif Root.get_os_type() == 8 then
-- 	device_id = Root.get_deviceuniqueidentifier();
-- end
-- return device_id;
-- end
--[[ 得到U3D唯一ID ]]
function Root.get_deviceuniqueidentifier()
    return Root.deviceuniqueidentifier;
end
--[[ 得到系统启动时间 ]]
function Root.get_start_time()
    return Root.start_time;
end
--[[ 得到系统型类型 11=android 8=IOS ]]
function Root.get_os_type()
    return Root.os_type;
end
--[[ 得到网络版本 -- 0无网 1移动 2WIFI ]]
function Root.get_network_type()
    Root.network_type = app.get_internet_reach_ability();
    return Root.network_type;
end
----------------------------------------------[[重载底层必要函数 非必需不能修改 end]]-------------------------------------------------------------

script.run("logic/app_config/main.lua");--[[ 加载配置表 ]]

function Root.str()
	app.log("Root.str");
	-------------------------------[[必需加载 str]]-------------------------------------------------------------
	---------------[[配置初始化C#]]------------------
--	asset_loader.enable_3rdparty_compression(AppConfig.get_enable_3rdparty_compression())--[[废]]
	--app.set_max_diskspace(AppConfig.get_max_disk_space());--[[系统最大缓存  暂时不设]]
	app.set_lua_version(AppConfig.get_package_version());--[[向C#设置LUA版本号]]
	app.set_asst_path_shareof(AppConfig.get_asst_path_shareof());--[[设置ASST需要特殊处理的PATH]]
	--[[设定文件中的资源号]]
	AppConfig.set_package_ass_ver();
	---------------[[配置初始化C#]]------------------

	script.run "logic/systems/public/main.lua";--[[基础库]]
	script.run("logic/systems/systems_data.lua");--[[ 系统数据 ]]
	script.run("logic/systems/utility.lua");--[[ G表 ]]
	script.run("logic/systems/system_hint_ui.lua");--[[ 系统独立的通用提示框 ]]
	script.run("logic/systems/log/main.lua");--[[ 公司日志收集 ]]
	script.run("logic/systems/talkingdata/main.lua");--[[ TD日志收集 ]]
	script.run("logic/systems/web_view/main.lua");--[[ WEB插件 ]]

	-------------------------------[[必需加载 end]]-------------------------------------------------------------

	-------------------------------------------------[[游戏初始化 start]]-----------------------------------------------------

	util.set_error_url(AppConfig.get_error_url());--[[ 设置HTTP ERROR URL ]]
	util.is_write_file(AppConfig.get_is_write_file());--[[ LOG写入本地 ]]
	util.is_web_post(AppConfig.get_is_web_post());--[[ 向WEB提交信息 ]]
	util.is_debug_show(AppConfig.get_is_debug_show());--[[ debug按钮 ]]
	util.is_debug_check(AppConfig.get_is_debug_check());--[[ debug按钮点击监控事件 ]]
	util.is_effect_console_enable(AppConfig.get_is_effect_console_enable()); --[[fps按钮是否显示]]

	-------------------------------------------------[[游戏初始化 end]]-----------------------------------------------------

	-- TODO 有bug, 暂时屏蔽快速查找接口
	asset_game_object.use_quick_loopup(false);

	Root.Init();
end

-------------------------------------------外调接口----------------------------------------------
--[[ 得到3D主像机 ]]
function Root.get_maincamera()
    return Root.maincamera;
end
--[[得到3dUI相机]]
function Root.get_3d_ui_camera()
    return Root.root_3d_ui_camera;
end
--[[ 得到UI绑定父对像 ]]
function Root.get_root_ui()
    return Root.uiroot;
end
--[[ 得到UI绑定父对像 ]]
function Root.get_root_ui_2d()
    return Root.root_ui_2d;
end
--[[ 得到战斗UI绑定父对像 ]]
function Root.get_root_ui_2d_fight()
    return Root.root_ui_2d_fight;
end
--[[ 得到S3D的RENDER ]]
function Root.get_s3d_camera_render()
    return Root.root_s3d_camera_render;
end
--[[ 得到UI摄像机 ]]
function Root.get_ui_camera()
    return Root.uicamera;
end
--[[ 得到UI摄像机 ]]
function Root.get_ui_camera_obj()
    return Root.uicamera_obj;
end
--[[ 得到S3D的绑定父对像 ]]
function Root.get_s3d_cube()
    return Root.root_s3d_cube;
end
--[获取截图设置对象texture]
function Root.get_screen_shot_texture()
    if Root.screen_shot_texture then
        return Root.screen_shot_texture.obj;
    else
        return nil;
    end
end
--[[ 绑定UI到UI层 ]]
function Root.SetRootUI(ngui_obj)
    if ngui_obj ~= nil then
        ngui_obj:set_parent(Root.uiroot);
        ngui_obj:set_local_scale(1, 1, 1);
    end
end
--[[ 注册Update回调 ]]
function Root.AddUpdate(f, p)
    if not type(f) == "function" then
        return false;
    end
    table.insert(Root.Update_list, { f, p });
    return true;
end
--[[ 清除Update回调 ]]
function Root.DelUpdate(f, p)
    local bfound = false
    if f then
        for k, v in pairs(Root.Update_list) do
            if v[1] == f and(p == nil or p == v[2]) then
                table.remove(Root.Update_list, k);
                bfound = true;
                break;
            end
        end
        if not bfound then
            -- 		app.log('有要删除Update的地方，结果没删除成功！'..tostring(f)..' '..debug.traceback())
            return false;
        else
            return true;
        end
    else
        -- 	app.log_warning('全部删除Update！！'..debug.traceback())
        Root.Update_list = { };
        return true;
    end
end
--[[ 注册fixedUpdate回调 ]]
function Root.AddFixedUpdate(f, p)
    if not type(f) == "function" then
        return false
    end
    table.insert(Root.fixedUpdate_list, { f, p });
    return true
end
--[[ 删除fixedUpdate回调 ]]
function Root.DelFixedUpdate(f)
    local bfound = false
    if f then
        for k, v in pairs(Root.fixedUpdate_list) do
            if v[1] == f then
                table.remove(Root.fixedUpdate_list, k);
                bfound = true;
                break;
            end
        end
        if not bfound then
            -- 		app.log('有要删除fixedUpdate的地方，结果没删除成功！'..tostring(f)..' '..debug.traceback())
            return false;
        else
            return true;
        end
    else
        Root.fixedUpdate_list = { };
        -- 	app.log_warning('全部删除fixedUpdate！！'..debug.traceback())
        return true
    end
end
--[[ 注册LateUpdate回调 ]]
function Root.AddLateUpdate(f, p)
    if not type(f) == "function" then
        return false
    end
    table.insert(Root.LateUpdate_list, { f, p });
    return true
end
--[[ 删除LateUpdate回调 ]]
function Root.DelLateUpdate(f, p)
    local bfound = false
    if f then
        for k, v in pairs(Root.LateUpdate_list) do
            if v[1] == f and(p == nil or v[2] == p) then
                table.remove(Root.LateUpdate_list, k);
                bfound = true;
                break;
            end
        end
        if not bfound then
            -- 		app.log('有要删除LateUpdate的地方，结果没删除成功！'..tostring(f)..' '..debug.traceback())
            return false;
        else
            return true;
        end
    else
        Root.LateUpdate_list = { };
        -- 	app.log_warning('全部删除LateUpdate！！'..debug.traceback())
        return true
    end
end

----[[清空LUA加载例表，不要随便用，系统级]]
-- function Root.clear_script_module()
-- Root.script_module = {};
-- end
-------------------------------------------外调接口----------------------------------------------

-------------------------------------------系统初始化----------------------------------------------
--[[ 初始化Root ]]
function Root.Init()
    Root.maincamera = asset_game_object.find("MainCamera");
    asset_game_object.dont_destroy_onload(Root.maincamera);
--    local maincamerafollow = Root.maincamera:add_component_camera_follow();
--    maincamerafollow:init_camera(-45, 0, 10);

    --[[ 注册fixed update回调 ]]
    app.set_on_fixed_update("Root_fixedUpdate");
    --[[ 注册update回调 ]]
    app.set_on_update("Root_Update");
    --[[ 注册Lateupdate回调 ]]
    app.set_on_late_update("Root_LateUpdate");
    -- 让手机屏幕不自动关闭
    util.sleep_timeout(-1);

    --异步资源延迟释放配置（目前主要是声音文件）
    asset_object.set_enable_sync_asset_deferred_release(AppConfig.get_enable_async_asset_deferred_release());

    --[[系统首先初始化ROOT+背景图]]
    Root.ui_root_init();

    --protol test
    if not AppConfig.is_release then
        util.enable_protol_test()
    end
end

--[[初始化ROOT]]
function Root.ui_root_init()
    Root._asset_loader = systems_func.loader_create("Root_loader")
    Root._asset_loader:set_callback("Root.ui_root_load")
    Root._asset_loader:load("assetbundles/prefabs/ui/uiroot.assetbundle");
end
function Root.ui_root_load(pid, filepath, asset_obj, error_info)
        Root.uiroot = asset_game_object.create(asset_obj);
        Root.uiroot:set_name("uiroot");
		Root.uiroot:set_position(0,0,0);
        Root.uicamera_obj = asset_game_object.find("uicamera");
        Root.uicamera = camera.find_by_name("uicamera");
        -- 关闭摄像机多点触控
        Root.uicamera:set_uicamera_multi_touch(false)
        Root.root_ui_2d = asset_game_object.find("ui_2d");
        Root.root_ui_2d:set_local_scale(1, 1, 1);
		
        Root.root_ui_2d_fight = asset_game_object.find("ui_2d_fight");
        Root.root_ui_2d_fight:set_local_scale(1, 1, 1);
        asset_game_object.dont_destroy_onload(Root.uiroot);

        Root.root_ui_2d_pool = Root.root_ui_2d_fight:clone()
        Root.root_ui_2d_pool:set_name("ui_2d_pool")
        Root.root_ui_2d_pool:set_active(false)
        --得到截图texture
        Root.screen_shot_texture = ngui.find_texture(Root.uiroot, "screen_shot_texture");
        Root.screen_shot_texture:set_active(false);

    --[[ LOGO背景 ]]
    script.run("logic/systems/load/login_bg.lua");
    login_bg.Start(Root.ui_obj_init);
end

--[[ 初始化 字体 共公资源]]
local pathRes = { };
pathRes.dynamic_font1 = "assetbundles/prefabs/font/dynamicfont_3_simhei.assetbundle";
pathRes.dynamic_font2 = "assetbundles/prefabs/font/dynamicfont_3_rzdfchj.assetbundle";
pathRes.s3d = "assetbundles/prefabs/s3d.assetbundle";
pathRes.audio_source_node = "assetbundles/prefabs/sound/prefab/audio_source_node.assetbundle";
pathRes.audio_listener_node = "assetbundles/prefabs/sound/prefab/audio_listener_node.assetbundle";
pathRes._3dUiCamera = "assetbundles/prefabs/3dui/login/login_back_camera.assetbundle";
--pathRes.public_atlas = "assetbundles/prefabs/ui/preloading/public_atlas.assetbundle";
-- pathRes.ui_public_ob_atlas = "assetbundles/prefabs/ui/preloading/ui_public_ob_atlas.assetbundle";
-- pathRes.art_font_atlas = "assetbundles/prefabs/ui/preloading/art_font_atlas.assetbundle";
-- pathRes.ui_guild_atlas = "assetbundles/prefabs/ui/preloading/ui_guild_atlas.assetbundle";
pathRes.ui_public_atlas = "assetbundles/prefabs/ui/preloading/ui_public_atlas.assetbundle";
pathRes.art_font_ob_atlas = "assetbundles/prefabs/ui/preloading/art_font_ob_atlas.assetbundle";
function Root.ui_obj_init()

    Root.root_font1_fzcsjw = nil;
    Root.root_font2_fzhtk = nil;
    Root.root_s3d = nil;
    Root.root_audio_source_node = nil;
    Root.root_audio_listener_node = nil;
    Root.root_3d_ui_camera = nil;
    -- Root.ui_public_atlas = nil;
    -- Root.ui_public_ob_atlas = nil;
    -- Root.art_font_atlas = nil;
    -- Root.ui_guild_atlas = nil;
    Root.ui_public_atlas = nil;
    Root.art_font_ob_atlas = nil;

    if Root._asset_loader == nil then
        Root._asset_loader = systems_func.loader_create("Root_loader")
    end

    Root._asset_loader:set_callback("Root.ui_obj_asset_load")
    Root._asset_loader:load(pathRes.dynamic_font1);
    Root._asset_loader:load(pathRes.dynamic_font2);
    -- Root._asset_loader:load(pathRes.s3d);
    Root._asset_loader:load(pathRes._3dUiCamera);
    Root._asset_loader:load(pathRes.audio_source_node);
    Root._asset_loader:load(pathRes.audio_listener_node);
    -- Root._asset_loader:load(pathRes.public_atlas);
    -- Root._asset_loader:load(pathRes.ui_public_ob_atlas);
    -- Root._asset_loader:load(pathRes.art_font_atlas);
    -- Root._asset_loader:load(pathRes.ui_guild_atlas);
    Root._asset_loader:load(pathRes.ui_public_atlas);
    Root._asset_loader:load(pathRes.art_font_ob_atlas);
end

function Root.ui_obj_asset_load(pid, filepath, asset_obj, error_info)
    if filepath == pathRes.dynamic_font1 then
        Root.root_font1_fzcsjw = asset_obj;
    elseif filepath == pathRes.dynamic_font2 then
        Root.root_font2_fzhtk = asset_obj;
    elseif filepath == pathRes.s3d then
        Root.root_s3d = systems_func.game_object_create(asset_obj);
        Root.root_s3d:set_name("s3d");
        Root.root_s3d:set_local_position(0, 50, 0);
        Root.root_s3d:set_local_rotation(0, 0, 0);
        Root.root_s3d_cube = asset_game_object.find("s3d_cube");
        Root.root_s3d_cube:set_local_rotation(0, 180, 0);
        Root.root_s3d_camera = camera.find_by_name("s3d_camera");
        Root.root_s3d_camera_render = Root.root_s3d_camera:get_camera_render_texture();
        asset_game_object.dont_destroy_onload(Root.root_s3d);
    elseif filepath == pathRes.audio_source_node then
        Root.root_audio_source_node = systems_func.game_object_create(asset_obj);
        Root.root_audio_source_node:set_name("audio_source_node");
        asset_game_object.dont_destroy_onload(Root.root_audio_source_node);
    elseif filepath == pathRes.audio_listener_node then
        Root.root_audio_listener_node = systems_func.game_object_create(asset_obj);
        Root.root_audio_listener_node:set_name("audio_listener_node");
        asset_game_object.dont_destroy_onload(Root.root_audio_listener_node);
    elseif filepath == pathRes._3dUiCamera then
        Root.root_3d_ui_camera = systems_func.game_object_create(asset_obj);
        Root.root_3d_ui_camera:set_name("3d_ui_camera");
        Root.root_3d_ui_camera:set_active(false);
        asset_game_object.dont_destroy_onload(Root.root_3d_ui_camera);
--    elseif filepath == pathRes.public_atlas then
--        Root.ui_public_atlas = asset_obj;
    -- elseif filepath == pathRes.ui_public_ob_atlas then
    --     Root.ui_public_ob_atlas = asset_obj;
    -- elseif filepath == pathRes.art_font_atlas then
    --     Root.art_font_atlas = asset_obj;
    -- elseif filepath == pathRes.ui_guild_atlas then
        -- Root.ui_guild_atlas = asset_obj;
    elseif filepath == pathRes.ui_public_atlas then
	    Root.ui_public_atlas = asset_obj;
    elseif filepath == pathRes.art_font_ob_atlas then
	    Root.art_font_ob_atlas = asset_obj;
    end

    Root.ui_init_check();
end
--[[查看是不是所有资源都准备好了]]
function Root.ui_init_check()
    if Root.root_font1_fzcsjw ~= nil
        and  Root.root_font2_fzhtk ~= nil
        -- and  Root.root_s3d ~= nil
        and  Root.root_audio_source_node ~= nil
        and  Root.root_audio_listener_node ~= nil
        -- and  Root.root_3d_ui_camera ~= nil
        -- and  Root.ui_public_atlas ~= nil
        -- and  Root.ui_public_ob_atlas ~= nil
        -- and  Root.art_font_atlas ~= nil
        -- and Root.ui_guild_atlas ~= nil
        and Root.ui_public_atlas ~= nil
        and Root.art_font_ob_atlas ~= nil
    then
        Root._asset_loader = nil;
        --[[ 游戏入口逻辑开始 ]]
        Root.game_start();
    end
end

--[[重新加载共公资源]]
function Root.reload_ui_init()
    -- login_bg.Destroy();--[[删除通用背景]]
    --[[ loading背景 ]]
    script.run("logic/systems/load/loading_bg.lua");
    loading_bg.Start(Root.reload_time_stop);
end
function Root.reload_time_stop()
    app.log("Root.reload_time_stop");
    --[[延迟 释放资源]]
	Root.root_font1_fzcsjw = nil;
	Root.root_font2_fzhtk = nil;
    -- Root.ui_public_atlas = nil;
    -- Root.ui_public_ob_atlas = nil;
    -- Root.art_font_atlas = nil;
    -- Root.ui_guild_atlas = nil;
    Root.ui_public_atlas = nil;
    Root.art_font_ob_atlas = nil;

	app.reload_shader();--[[重加载shader]]

    collectgarbage("collect");
    collectgarbage("collect");
    collectgarbage("collect");

	timer.create("Root.reload_ui_init_time", 5000, 1);
end
function Root.reload_ui_init_time()
    app.log("Root.reload_ui_init_time");
    loading_bg.Destroy();  --关闭LOADING
    Root._asset_loader = systems_func.loader_create("Root_loader");
    Root._asset_loader:set_callback("Root.ui_obj_asset_load");
	Root._asset_loader:load(pathRes.dynamic_font1);
	Root._asset_loader:load(pathRes.dynamic_font2);
    -- Root._asset_loader:load(pathRes.public_atlas);
    -- Root._asset_loader:load(pathRes.ui_public_ob_atlas);
    -- Root._asset_loader:load(pathRes.art_font_atlas);
    -- Root._asset_loader:load(pathRes.ui_guild_atlas);
    Root._asset_loader:load(pathRes.ui_public_atlas);
    Root._asset_loader:load(pathRes.art_font_ob_atlas);
end
-------------------------------------------系统初始化----------------------------------------------
-- 运行帧数
function Root.GetFrameCount()
    return Root.update_seq or 0
end
-- 运行帧数
function Root.GetFixFrameCount()
    return Root.fixedupdate_seq or 0
end
-- 运行帧数
function Root.GetLateFrameCount()
    return Root.lateupdate_seq or 0
end

-------------------------------------------循环事件----------------------------------------------
--[[ fixedUpdate主体 ]]
function Root_fixedUpdate(fixedDeltaTime)
    Root.fixedupdate_seq =(Root.fixedupdate_seq or 0) + 1
    for k, v in pairs(Root.fixedUpdate_list) do
        if v[1] ~= nil and PublicFunc.check_type_function(v[1]) then
            if v[2] then
                v[1](v[2], fixedDeltaTime);
            else
                v[1](fixedDeltaTime);
            end
        end
    end
end

--[[ Update主体 ]]
function Root_Update(deltaTime)
    Root.update_seq =(Root.update_seq or 0) + 1

    for k, v in pairs(Root.Update_list) do
        if v[2] then
            v[1](v[2], deltaTime);
        else
            v[1](deltaTime);
        end
    end

    --[[ 协程 ]]
    for i, c in pairs(Root.coroutine_list) do
        Root.coroutine_name = i
        local r, s = coroutine.resume(c[1], c[2], c[3], c[4])
        if not r then
            -- app.log('coroutine error: '..tostring(s))
        end

        if coroutine.status(c[1]) == 'dead' then
            if type(s) == "table" then
                local callback = s.callback
                if nil ~= callback then
                    local callback_type = type(callback)
                    if callback_type == "string" then
                        local callback_func = _G[v]
                        if callback_func ~= nil and type(callback_func) == "function" then
                            callback_func()
                        else
                            app.log_warning("callback faild 01.")
                        end
                    elseif callback_type == "function" then
                        callback()
                    else
                        app.log_warning("callback faild unkown cb type[" .. tostring(callback_type) .. "]")
                    end
                end
            end

            Root.coroutine_list[i] = nil
        end
    end
    Root.coroutine_name = nil


    -- if xx == nil and msg_activity ~= nil and Socket.socketServer ~= nil then
    -- 	xx = 1
    -- 	msg_activity.cg_activity_config(MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu);
    -- end
end

--[[ Update协程 ]]
function Root.Coroutine(name, fun, p1, p2, p3)
    name = string.format('%s_%d', name, Root.coroutineID)
    Root.coroutineID = Root.coroutineID + 1
    Root.coroutine_list[name] = { coroutine.create(fun), p1, p2, p3 }
end

--[[ LateUpdate主体 ]]
function Root_LateUpdate(fixedDeltaTime)
    Root.lateupdate_seq =(Root.lateupdate_seq or 0) + 1
    for k, v in pairs(Root.LateUpdate_list) do
        if v[1] ~= nil and PublicFunc.check_type_function(v[1]) then
            if v[2] then
                v[1](v[2], fixedDeltaTime);
            else
                v[1](fixedDeltaTime);
            end
        end
    end
end
-------------------------------------------循环事件----------------------------------------------


-------------------------------------------通过URL取得必要游戏信息----------------------------------------------
--[[ 通过URL得到游戏更新信息 ]]
function Root.url_get_system_info()
    --Root.push_web_info("sys_002", "通过URL得到游戏更新信息");
	--[[公司日志：游戏启动信息]]
	--SystemLog.AppStartClose(500000001);

    --app.log("更新URL地址：（单机）");

    --Root.use_system_url = Root.filter_system_info_url();

    --app.log("check url--"..Root.use_system_url);
    --app.log("check url path--"..AppConfig.get_system_check_filepath());

    --if Root.use_system_url == "" then
        --app.log("all system info url is used");
        --Root.push_web_info("system_info_url", "无有效的入口服URL")
        --SystemHintUI.SetAndShow(ESystemHintUIType.one, "无法获取版本信息！请稍后重试！",
            --{ str = "退出", func = Root.quit }
        --);
        --return;
    --end

    --ghttp.get(
	    --Root.use_system_url,
        --"Root.on_op_success",
        --"Root.on_op_error",
        --AppConfig.get_system_check_filepath()
    --);
end

--获取设备型号对应的特效设置等级
function Root.url_get_effect_level()
	if Root.use_system_url == "" then
		Root.use_system_url = Root.filter_system_info_url();
	end

	if Root.use_system_url ~= "" then
	    ghttp.get(
	        system_info_url,
	        "Root.on_effect_level_op_suceess",
	        "Root.on_effect_level_op_error",
	        AppConfig.get_effect_level_filepath()
	    );
    end

end

function Root.on_effect_level_op_suceess(t)
    if t.reuslt == nil or t.result == '' then
        app.log_warning("服务器没有对应特效等级")
        return;
    end
    local json_info = pjson.decode(t.result);
    app.log(table.tostring(json_info));
    if json_info ~= nil and json_info.level then
        systems_data.set_effect_level(json_info.level);
    end
end

function Root.on_effect_level_op_error(t)
    --暂不做处理
    app.log_warning("on_effect_level_op_error   t== "..table.tostring(t))
end

--[[ 筛选入口服URL ]]
function Root.filter_system_info_url()
    local url_list = AppConfig.get_system_check_httpurl();

    for i = 1, table.getn(url_list) do
        app.log("筛选入口服URL=" .. url_list[i]);
        local used_index = 0;
        --[[ 查看有没有使用过 ]]
        for j = 1, table.getn(Root.used_system_info_urllist) do
            local temp = Root.used_system_info_urllist[j];
            if temp.url == url_list[i] then
                used_index = j;
                break;
            end
        end

        if used_index ~= 0 then
            --[[ 使用过 次数还可以用 ]]
            app.log("使用过=" .. Root.used_system_info_urllist[used_index].num);
            if Root.used_system_info_urllist[used_index].num < Root.use_system_info_max_num then
                Root.used_system_info_urllist[used_index].num = Root.used_system_info_urllist[used_index].num + 1;
                app.log("url_list=" .. url_list[i]);
                return url_list[i];
            end
        else
            --[[ 没有使用过 ]]
            app.log("没有使用过");
            local inset_table = { };
            inset_table.url = url_list[i];
            inset_table.num = 1;
            table.insert(Root.used_system_info_urllist, inset_table);
            app.log("url_list=" .. url_list[i]);
            return url_list[i];
        end

    end

    --[[ 没有URL ]]
    return "";
end

--[[URL成功回调]]
function Root.on_op_success(t)
    app.log("URL成功回调");
    Root.used_system_info_urllist = {};--[[还原使用过的临时例表]]

    Root.push_web_info("sys_003","通过URL得到游戏更新信息,URL成功回调");
	--[[公司日志：游戏启动信息]]
	SystemLog.AppStartClose(3);

    local json_info = pjson.decode(t.result);
    app.log(table.tostring(json_info));

    --[[APK包信息]]
    systems_data.init_new_apk_url_list();
    if json_info.new_apk ~= nil then
        local temp = {};
        temp.channel_id = json_info.new_apk.channel_id;
        temp.package_id = json_info.new_apk.package_id;
        temp.client_ver = json_info.new_apk.client_ver;
        temp.package_id = json_info.new_apk.package_id;
        temp.md5 = json_info.new_apk.md5;
        temp.redirect = json_info.new_apk.redirect;
        temp.url = json_info.new_apk.url;
        systems_data.set_new_apk_url_list(temp);
        app.log("APK包信息"..table.tostring(systems_data.get_new_apk_url_list()));
    end


    --[[ 帐号服信息 ]]
    if json_info.auth_server ~= nil then
        app.log("帐号服信息");
        --[[ URL ]]
        local temp_url = json_info.auth_server.url;
        if temp_url ~= nil and type(temp_url) == "table" then
            systems_data.init_auth_server_list();
            for i = 1, table.getn(temp_url) do
                table.insert(systems_data.get_auth_server_list(), temp_url[i]);
            end
            app.log("URL=" .. table.tostring(systems_data.get_auth_server_list()));
        end
        --[[ PATH ]]
        local temp_path = json_info.auth_server.path;
        if temp_path ~= nil and type(temp_path) == "string" then
            systems_data.init_auth_server_path();
            systems_data.set_auth_server_path(temp_path);
            app.log("path=" .. temp_path);
        end
        --[[ SERVER LIST PATH ]]
        local temp_slist_path = json_info.auth_server.slist_path;
        if temp_slist_path ~= nil and type(temp_slist_path) == "string" then
            systems_data.init_auth_server_list_path();
            systems_data.set_auth_server_list_path(temp_slist_path);
            app.log("temp_slist_path=" .. temp_slist_path);
        end
        --[[ PAy PATH ]]
        local temp_pay_path = json_info.auth_server.pay_path;
        if temp_pay_path ~= nil and type(temp_pay_path) == "string" then
            systems_data.init_auth_server_pay_path();
            systems_data.set_auth_server_pay_path(temp_pay_path);
            app.log("temp_pay_path=" .. temp_pay_path);
        end
	    --[[ Notice PATH ]]
	    local temp_notice_path = json_info.auth_server.notice_path;
	    if temp_notice_path ~= nil and type(temp_notice_path) == "string" then
		    systems_data.init_auth_notice_info_path();
		    systems_data.set_auth_notice_info_path(temp_notice_path);
		    app.log("temp_notice_path=" .. temp_notice_path);
	    end
    end

	--[[ DTREE ]]
	if json_info.dtree_server ~= nil then
		app.log("DTREE信息");
		--[[ URL ]]
		local temp_url = json_info.dtree_server.url;
		if temp_url ~= nil and type(temp_url) == "table" then
			systems_data.init_dtree_server_list();
			for i = 1, table.getn(temp_url) do
				table.insert(systems_data.get_dtree_server_list(), temp_url[i]);
			end
			app.log("URL=" .. table.tostring(systems_data.get_dtree_server_list()));
		end
		--[[ PATH ]]
		local temp_path = json_info.dtree_server.path;
		if temp_path ~= nil and type(temp_path) == "string" then
			systems_data.init_dtree_server_path();
			systems_data.set_dtree_server_path(temp_path);
			app.log("path=" .. temp_path);
		end
	end

    --[[ 广告公告信息 ]]
    if json_info.ad_notice ~= nil then
        app.log("广告公告信息");
        --[[ 公告标题+内容]]
        --json_info.ad_notice.notice = {[1]={ title = 'aaaa', content = 'bbbb', },[2]={title='cccc',content='dddd'} }
        local temp_notice_list = json_info.ad_notice.notice;
        if temp_notice_list ~= nil and type(temp_notice_list) == "table" then
            systems_data.init_notice_list();
            for i = 1, table.getn(temp_notice_list) do
                local temp_notice = temp_notice_list[i]
                if type(temp_notice) == "table" then
                    table.insert(systems_data.get_notice_list(), temp_notice);
                end
            end
            app.log("temp_notice_list=" .. table.tostring(temp_notice_list));
        end
        --[[ 公告图片列表]]
        local temp_ad_picture_list = json_info.ad_notice.ad_picture;
        if temp_ad_picture_list ~= nil and type(temp_ad_picture_list) == "table" then
            systems_data.init_ad_picture_list();
            for i = 1, table.getn(temp_ad_picture_list) do
                table.insert(systems_data.get_ad_picture_list(), temp_ad_picture_list[i]);
            end
            app.log("temp_ad_picture_list=" .. table.tostring(temp_ad_picture_list));
        end
    end

    --[[问卷调查]]
    if json_info.question_url ~= nil and json_info.question_url ~= "" then
        app.log("问卷调查="..json_info.question_url);
        systems_data.init_question_url();
        systems_data.set_question_url(json_info.question_url);
    end

    --[[ 帐号信息验证URL ]]
    local auth_list = systems_data.get_auth_server_list()
    if table.getn(auth_list) <= 0 then
        app.log("帐号服例表为空");
        --SystemHintUI.SetAndShow(ESystemHintUIType.two, "帐号例表为空！请重试！",
            --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
        --);
        return;
    end
    --[[ 帐号信息验证PATH ]]
    local auth_path = systems_data.get_auth_server_path()
    if auth_path == "" then
        app.log("帐号服PATH为空");
        --SystemHintUI.SetAndShow(ESystemHintUIType.two, "帐号信息为空！请重试！",
            --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
        --);
        return;
    end
    --[[ 服务器例表验证PATH ]]
    local slilst_path = systems_data.get_auth_server_list_path()
    if slilst_path == "" then
        app.log("服务器例表PATH为空");
        --SystemHintUI.SetAndShow(ESystemHintUIType.two, "服务器例表信息为空！请重试！",
            --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
        --);
        return;
    end
    --[[ PAY例表验证PATH ]]
    if Root.get_os_type() == 11 then
        local slilst_path = systems_data.get_auth_server_pay_path()
        if slilst_path == "" then
            app.log("PAY例表PATH为空");
            --SystemHintUI.SetAndShow(ESystemHintUIType.two, "PAY服务器例表信息为空！请重试！",
                --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
            --);
            return;
        end
    end

    --[[ 文件更新信息 ]]
    if json_info.res_update_server ~= nil then
        app.log("文件更新信息");
        --[[ 版本文件 ]]
        if json_info.res_update_server.ver ~= nil then
            app.log("版本文件");
            --[[ PATH ]]
            local temp_path = json_info.res_update_server.ver.path;
            if temp_path ~= nil and type(temp_path) == "string" then
                systems_data.init_ver_update_server_list_path();
                systems_data.set_ver_update_server_list_path(temp_path);
                app.log("path=" .. temp_path);
            end
            --[[ URL ]]
            local temp_url = json_info.res_update_server.ver.url;
            if temp_url ~= nil and type(temp_url) == "table" then
                systems_data.init_ver_update_server_list();
                for i = 1, table.getn(temp_url) do
                    table.insert(systems_data.get_ver_update_server_list(), temp_url[i]);
                end
                app.log("URL=" .. table.tostring(systems_data.get_ver_update_server_list()));
            end
        end
        --[[ 下载例表 ]]
        if json_info.res_update_server.res ~= nil then
            app.log("下载例表");
            --[[ PATH ]]
            local temp_path = json_info.res_update_server.res.path;
            if temp_path ~= nil and type(temp_path) == "string" then
                systems_data.init_res_update_server_list_path();
                systems_data.set_res_update_server_list_path(temp_path);
                app.log("path=" .. temp_path);
            end
            --[[ URL ]]
            local temp_url = json_info.res_update_server.res.url;
            if temp_url ~= nil and type(temp_url) == "table" then
                systems_data.init_res_update_server_list();
                for i = 1, table.getn(temp_url) do
                    table.insert(systems_data.get_res_update_server_list(), temp_url[i]);
                end
                app.log("URL=" .. table.tostring(systems_data.get_res_update_server_list()));
            end
        end
    end

    --[[ 信息验证 ]]

    --[[ 版本文件ULR ]]
    if table.getn(systems_data.get_ver_update_server_list()) <= 0 then
        Root.push_web_info("get_ver_update_server_list", "版本文件例表为空")
        app.log("版本文件例表为空");
        --SystemHintUI.SetAndShow(ESystemHintUIType.two, "版本文件例表为空！请重试！",
            --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
        --);
        return;
    end
    --[[ 版本文件PATH ]]
    if systems_data.get_ver_update_server_list_path() == "" then
        --SystemHintUI.SetAndShow(ESystemHintUIType.two, "版本文件信息为空！请重试！",
            --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
        --);
        return;
    end

    --[[ 资源URL ]]
    if table.getn(systems_data.get_res_update_server_list()) <= 0 then
        Root.push_web_info("get_res_update_server_list", "资源文件例表为空")
        app.log("资源文件例表为空");
        --SystemHintUI.SetAndShow(ESystemHintUIType.two, "资源文件例表为空！请重试！",
            --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
        --);
        return;
    end
    --[[ 资源PATH ]]
    if systems_data.get_res_update_server_list_path() == "" then
        --SystemHintUI.SetAndShow(ESystemHintUIType.two, "资源文件信息为空！请重试！",
            --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
        --);
        return;
    end

	--[[得到服务器维护公告]]
	script.run("logic/systems/server_list_data/main.lua");
	ServerListData.get_server_notice();

	--[[ 判断更新流程 ]]
    Root.check_update_process();
end

function Root.on_op_error()
    Root.push_web_info("sys_004", "通过URL得到游戏更新信息ERROR");
    app.log("失败重连");

    --SystemHintUI.SetAndShow(ESystemHintUIType.two, "获取游戏信息失败！请重试！",
        --{ str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
    --);
end
-------------------------------------------通过URL取得必要游戏信息----------------------------------------------

--[[判断更新流程]]
function Root.check_update_process()
    --[[ 是否更新APK ]]
    if systems_data.get_new_apk_url_list() ~= nil and AppConfig.get_enable_update_file() then
        local temp = systems_data.get_new_apk_url_list();
        if temp.redirect == "0" then
            Root.push_web_info("sys_005", "判断更新流程");

            --[[ 进入APK更新 ]]
            if Root.get_os_type() == 11 then
                app.log("包更新");
                script.run "logic/systems/installer/main.lua";

                --[[ 是不是已经下载了 ]]
                if Installer.IsDownloading() then
                    Root.push_web_info("sys_007", "进入APK更新,检测到已经下载安装包，将接着下载");
                    --SystemHintUI.SetAndShow(ESystemHintUIType.two, "检测到已经下载安装包，将接着下载！",
                        --{ str = "是", func = Installer.UpdatePackage }, { str = "否", func = Root.quit }
                    --);
                else
                    Root.push_web_info("sys_006", "需要重新下载安装包");
                    --SystemHintUI.SetAndShow(ESystemHintUIType.two, "需要重新下载安装包！",
                        --{ str = "是", func = Installer.UpdatePackage }, { str = "否", func = Root.quit }
                    --);
                end
            else
                --SystemHintUI.SetAndShow(ESystemHintUIType.one, "需要重新下载安装包！你的系统版本不正确！",
                    --{ str = "是", func = Root.quit }
                --);
            end
        else
            Root.push_web_info("sys_009", "APK包更新，打开URL");

            --[[ 打开网页 ]]
            if temp.url[1] ~= nil then
                --SystemHintUI.SetAndShow(ESystemHintUIType.two, "需要重新下载安装包！",
                    --{ str = "是", func = function() app.open_url(temp.url[1]) end }, { str = "否", func = Root.quit }
                --);
            end
            return;
        end
    else
        --[[ 进入更新流程 ]]
        Root.PackageUpdateComplete();
        return;
    end
end


--[[APK更新完成回调]]
function Root.PackageUpdateComplete()
    app.log("包更新返回");
    -- 删除包更新的安装包
    script.run "logic/systems/installer/main.lua";
    --[[ APK更新 ]]
    Installer.DeleteCacheUpdateFile()

	--[[判断是不是第一次进来]]
	if not file.write_exist("first.data") then
	    --[[协议]]
		UiAnn.Start(UiAnn.Type.RegAgreeMent,nil,Root.ann_cb);
	else
		Root.ann_cb();
	end

end

--[[协议回调]]
function Root.ann_cb()
	app.log("ann_cb");
	--[[同意协议后写入标示文件]]
	local fileHandle = file.open("first.data", 2);
	if fileHandle ~= nil then
		fileHandle:close();
	end

	--[[得到服务器例表]]
	script.run("logic/systems/server_list_data/main.lua");
	ServerListData.apply_data_list(Root.check_update_file);--[[更新]]

--	--[[登陆界面]]
--	script.run("logic/systems/login/main.lua");
--	login_enter.Start(Root.login_ui_callback);
end

--[[ 文件热更新 ]]
function Root.update_file()
--	--[[ 删除LOGO背景 ]]
--    login_bg.Destroy();

    -- if AppConfig.get_update_type() == 0 then
    -- 	app.log("update type is socket!");
    -- 	--[[socket]]
    ----		script.run("logic/systems/update/socket_update/main.lua");
    ----		UpdateDownload.start();
    -- elseif AppConfig.get_update_type() == 1 then

    app.log("update type is ="..tostring(AppConfig.get_use_update_fserver()));

	if AppConfig.get_use_update_fserver() then
		--[[公司http更新]]
		script.run("logic/systems/update/platform_update/main.lua");
		platform_update_down.start();
	else
		--[[ 自己写的http更新 ]]
		script.run("logic/systems/update/http_update/main.lua");
		http_update_down.start();
	end
--end
end

--[[判断本地的版本号，是否需要清理缓存文件]]
function Root.check_loacl_file()
    local config_ver = (AppConfig.get_package_version());
    local file_name = "package.data";
    if file.exist(file_name) == true then
        local fileHandle = file.open_read(file_name);
        local content = fileHandle:read_all_text();
        fileHandle:close();
        app.log(tostring(content).."=package.data="..tostring(config_ver));
        if string.find(tostring(content),tostring(config_ver)) then
            app.log("no clear");
	        --[[先清理GRAY目录]]
	        Root.clear_gray();
            do return end;
        end
    end
    
    --[[清除动态更新文件 ]]
     Root.clear_doc();

--    --[[写package号]]
--    timer.create("Root.writer_package", 1000, 1);
    --[[ 加载其他必要资源 ]]
--    timer.create("Root.Init", 1500, 1);
end

--[[写package号]]
function Root.writer_package()
    app.log(">>>>writer package.data time="..os.time());
    local config_ver = (AppConfig.get_package_version());
    local file_name = "package.data";
    local fileHandle = file.open(file_name, 2);
    fileHandle:write_string(tostring(config_ver));
    fileHandle:close();
	--[[先清理GRAY目录]]
	Root.clear_gray();
end

--[[ 游戏入口逻辑开始 ]]
function Root.game_start()
    app.log("Root.game_start");

    --[[判断有没有网
    if Root.get_network_type() == 0 then
        app.log("无网");
        --SystemHintUI.SetAndShow(ESystemHintUIType.one, "无法连接到网络！请打开网络后重试！",
            --{ str = "退出", func = Root.quit }
        --);
        return;
    end
	--]]

	--[[帐号中心可以提前准备好了]]
	script.run("logic/systems/user_center/main.lua");--[[ 帐号中心 ]]

    --[[ 游戏开始 跳过线上流程  最终都是要去DTREE取信息]]
    --if AppConfig.get_enable_on_line() then
        app.log("root===on_line");
        --[[ 通过URL取得必需信息，不然不准进入游戏 ]]
        --Root.url_get_system_info();
        --获取设备型号对应的特效设置等级
        --Root.url_get_effect_level();
    --else
        app.log("root===on_local");

	    --[[得到服务器例表]]
	    script.run("logic/systems/server_list_data/main.lua");
	    --ServerListData.apply_data_list(Root.check_update_file);--[[更新]]

	    --[[登陆界面]]
	    	script.run("logic/systems/login/main.lua");
	    	login_enter.Start(Root.login_ui_callback);
    --end
end
--[[文件更新判断]]
function Root.check_update_file()
	--if AppConfig.get_enable_update_file() then
		--[[登陆界面]]
		--script.run("logic/systems/login/main.lua");
		--[[得到本地文件信息 主要是读取出上次登陆服务器的ID]]
		--if not login_enter.get_local_file() then
			--login_enter.first_set_enter_id();--[[第一次进游戏，取一个正式服ID]]
		--end
		--[[更新]]
		--Root.update_file();
	--else
		--[[登陆界面]]
		Root.legin_ui_str();
	--end
end
--[[登陆界面]]
function Root.legin_ui_str()
	app.log("Root.legin_ui_str");
	--[[登陆界面]]
	script.run("logic/systems/login/main.lua");
	login_enter.Start(Root.login_ui_callback);
end

--[[登陆UI初始化后回调]]
function Root.login_ui_callback()
--	--[[得到服务器例表]]
--	script.run("logic/systems/server_list_data/main.lua");
--	ServerListData.apply_data_list(login_enter.update);--[[刷新UI]]

	login_enter.update();--[[刷新登陆UI]]

	--[[公告]]
	script.run("logic/systems/load/notice_bg.lua");
	notice_bg.Start();
end

--[[SDK登陆成功后]]
function Root.usercenter_login_callback()
	app.log("Root.usercenter_login_callback");
end

--[[ 切换到后台回调 ]]
function Root.on_application_pause(pause)
--    app.log("Root.on_application_pause="..tostring(pause));
    --Root.app_is_backstage = pause;
    --[[ true 退到后面   false回到前台 ]]
    --if not Root.app_is_backstage then
        --[[断了SOCKET，又没有达到退出游戏时间]]
        --if Root.loop_count >= Root.loop_close_socket then
            --if GameBegin then
                --[[ 断线重连 ]]
                --GameBegin.usercenter_logout_callback();
            --end
        --end
    --end
    --Root.loop_count = 0;
end

--[[切后台后的LOOP,非主线程执行，没有主线程权限，所以不要做一些大的操作]]
function  Root.on_application_loop()
    --Root.loop_count = Root.loop_count + 1
--    app.log("Root.loop_count="..Root.loop_count);
    --[[超时断网]]
    --if Root.loop_count >= Root.loop_close_socket then
        --[[断网]]
        --if Socket then
            --Socket.GameServer_close();
        --end
    --end

    --[[超时4分钟就直接退游戏]]
    --if Root.loop_count >= Root.loop_game_quit then
        --[[ 退出游戏 ]]
        --Root.quit();
    --end
end

-----------------------------------------------------------系统启动--------------------------------------------------------------------------------------

--[[android处理]]
if Root.get_os_type() == 11 then
    --[[ 退后台处理 ]]
    app.set_on_application_pause_call("Root.on_application_pause")
    app.set_on_application_loop_call("Root.on_application_loop")
    app.set_pause_loop_call_timeout(Root.loop_max_time);--[[后台线程最长时间]]

    --[[ 返回键处理 ]]
    script.run("logic/systems/back_key.lua");
    BackKey.Init();
end



--[[判断本地的版本号，是否需要清理缓存文件]]
Root.check_loacl_file()

-------------------------------------------------------------测试区--------------------------------------------------------------------

----[[OP]]
--local op_url = "http://192.168.20.244:7022/digisky_file_server/CheckOP?deviceid=30000&optype=android&opid=6";
--
--ghttp.set_op_listener("on_op_success", "on_op_error");
--ghttp.check_op(op_url);
--function on_op_success(t)
--	app.log("on_op_success="..table.tostring(t));
--end
--function on_op_error(t)
--	app.log("on_op_error="..table.tostring(t));
--end


----[[下载FILEMAP文件]]
--local url = "http://192.168.20.244:7022/digisky_file_server/checkfile?optype=android&deviceid=30000";
----local url = "http://version.lzjd.qq.com:9000/digisky_file_server/checkfile?optype=ios&deviceid=10102";
--local save_path = "check_file.data";
--
--ghttp.set_check_file_listener("on_success", "on_error");
--ghttp.check_file(url, save_path);
--
--function on_success(t)
--	app.log("e_test_ghttp_check_file on_success="..table.tostring(t));
--	local result1 = ghttp.get_check_file_value("logic/k.lua");
--	local result2 = ghttp.get_check_file_value("logic/e.lc");
--	local result3 = ghttp.get_check_file_value("logic/recharge_tx/recharge_tx_mgr_ios.lua");
--	app.log(string.format("result: '%s' '%s' '%s'", result1, result2, result3 ));
--end
--function on_error(t)
--	app.log("e_test_ghttp_check_file on_error="..table.tostring(t));
--	if t.err_code == 301 or t.err_code == 302 then
--		ghttp.check_file(t.err_str, save_path);
--	end
--end

--[[下载文件]]
--local url = "http://192.168.60.152:8081/assetbundles/s3d.assetbundle";
--local save_path = "assetbundles/s3d.assetbundle";
--
--ghttp.set_check_file_listener("on_success", "on_error");
--ghttp.down(
--	url,
--	"on_success",
--	"on_error",
--	"on_downing",
--	save_path
--);
--
--function on_success()
--    app.log("e_test_ghttp_check_file on_success");
--end
--function on_downing()
--	app.log("e_test_ghttp_check_file on_downing");
--end
--function on_error(t)
--    app.log("e_test_ghttp_check_file on_error="..table.tostring(t));
--end







--function Root.testst() end

--scene.set_listener_v5("Root.testst", "Root.testst", "Root.testst", "Root.testst");
--scene.load_v5("assetbundles/prefabs/map/009_shenxiang/70000009_shenxiang.assetbundle","70000009_shenxiang");
--scene.load_v5("assetbundles/prefabs/map/009_shenxiang/70000010_shenxiang.assetbundle","70000010_shenxiang");
--scene.load_v5("assetbundles/prefabs/map/009_shenxiang/70000011_shenxiang.assetbundle","70000011_shenxiang");


--script.run ("logic/systems/user_center/main.lua");
--
----[[帐号中心新的POST提交]]
--function Root.on_check_success(t)
--	app.log("on_check_success="..t.result);
--end
--function Root.on_check_error(t)
--	app.log("path="..t.path..".err_code="..t.err_code..".err_str="..t.err_str);
--end
--
----ghttp.post("http://125.71.203.241:9321", "Root.on_check_success", "Root.on_check_error", "/post.php","name@@@");
----ghttp.post("http://192.168.81.97:8080", "Root.on_check_success", "Root.on_check_error", "/login_service/account_login.do","name=pk@pwd=123@text=goodjob");
----ghttp.post("http://192.168.81.97:8080", "Root.on_check_success", "Root.on_check_error", "/login_service/device_login.do","device=123");
--
--function Root.post()
--
--
--	--[[1第三方登陆 2游客登录 3邮箱登录 4邮箱注册 5手机登陆 6手机注册 7邮箱绑定 8手机绑定 9普通帐号注册  10普通帐号登录 11申请验证码 12找回密码]]
--
--	local account = "13677778888";
--	local passwd = "123456";
--
----on_check_success={"account":"","account_tips":"","account_type":1,"account_type_tips":0,"accountid":"291536882496438977","bind_accounts":[],"login_times":0,"msg":"","ret":0,"token":"3135583910017125089","request_type":2}
--
--	local accountid = "291570280162132673";
--	local token = "3135586257216762542";
--
--	local table_info = UserCenter.get_need_info();
--
--	local type = 8;
--
--
--
--
--
--
--
--	if type == 2 then
--		table_info.type = type;
--		local json_info = pjson.encode(table_info);
--		--		ghttp.post("http://210.73.210.86:8080/", "Root.on_check_success", "Root.on_check_error", "/sms/seed_code.do",json_str);
--		ghttp.post("http://192.168.81.101:8080/", "Root.on_check_success", "Root.on_check_error", "/login_service/user_center.do",json_info);
--	end
--
--	if type == 8 then
--		table_info.type = type;
--		table_info.account = account;
--		table_info.passwd = passwd;
--		table_info.accountid = accountid;
--		table_info.token = token;
--		local json_info = pjson.encode(table_info);
--		--		ghttp.post("http://210.73.210.86:8080/", "Root.on_check_success", "Root.on_check_error", "/sms/seed_code.do",json_str);
--		ghttp.post("http://192.168.81.101:8080/", "Root.on_check_success", "Root.on_check_error", "/login_service/user_center.do",json_info);
--	end
--
--
--	if type == 9 or type == 10 then
--		table_info.type = type;
--		table_info.account = account;
--		table_info.passwd = passwd;
--		local json_info = pjson.encode(table_info);
--		--		ghttp.post("http://210.73.210.86:8080/", "Root.on_check_success", "Root.on_check_error", "/sms/seed_code.do",json_str);
--		ghttp.post("http://192.168.81.101:8080/", "Root.on_check_success", "Root.on_check_error", "/login_service/user_center.do",json_info);
--	end
--
--
--	if type == 6 then
--		table_info.type = type;
--		table_info.account = account;
--		table_info.passwd = passwd;
--		local json_info = pjson.encode(table_info);
--		--		ghttp.post("http://210.73.210.86:8080/", "Root.on_check_success", "Root.on_check_error", "/sms/seed_code.do",json_str);
--		ghttp.post("http://192.168.81.101:8080/", "Root.on_check_success", "Root.on_check_error", "/login_service/user_center.do",json_info);
--	end
--
--	if type == 11 then
--		table_info.type = type;
--		table_info.account = account;
--		local json_info = pjson.encode(table_info);
----		ghttp.post("http://210.73.210.86:8080/", "Root.on_check_success", "Root.on_check_error", "/sms/seed_code.do",json_str);
--		ghttp.post("http://192.168.81.101:8080/", "Root.on_check_success", "Root.on_check_error", "/login_service/user_center.do",json_info);
--	end
--
--	if type == 12 then
--		table_info.type = type;
--		table_info.account = account;
--		table_info.passwd = passwd;
--		table_info.other = "GET PWD";
--		local json_info = pjson.encode(table_info);
----		ghttp.post("http://210.73.210.86:8080/", "Root.on_check_success", "Root.on_check_error", "/sms/check_code.do",json_str);
--		ghttp.post("http://192.168.81.101:8080/", "Root.on_check_success", "Root.on_check_error", "/login_service/user_center.do",json_info);
--	end
--
----	ghttp.get(
----		"http://192.168.81.97:8080",
----		"Root.on_op_success",
----		"Root.on_op_error",
----		"sfsdf"
----	);
--end
--timer.create("Root.post", 100, 1);


-- Root.AddUpdate(function()
-- ghttp.post("http://192.168.81.97:8080", "Root.on_check_success", "Root.on_check_error", "/login_service/device_login.do","device=123");
-- app.log("@@@");
-- end);

-- do return end;


--do return end;
----[[测试帐号系统与充值]]
--centen_test ={};
--script.run("logic/systems/user_center/main.lua");
--
--
--local table_info = UserCenter.get_need_info();
--local json_info = pjson.encode(table_info);
--
--ghttp.post("http://192.168.81.101:8080/",
--	"Root.on_success",
--	"Root.on_error",
--	"pay_web/get_payid.do",
--	json_info);
--
--function Root.on_success()
--	app.log("Root.on_success");
--end
--function Root.on_error()
--	app.log("Root.on_error");
--end
--
--
--
--
--user_center.set_payment_listener("UserCenter.on_payment");--[[支付回调]]
--
--function centen_test.test_load(pid, filepath, asset_obj, error_info)
--	centen_test.ui_loading = asset_game_object.create(asset_obj);
--	centen_test.ui_loading:set_parent(Root.get_root_ui_2d());
--	centen_test.ui_loading:set_local_scale(1,1,1);
--	centen_test.ui_loading:set_name("ui_loading");
--
--	centen_test.but_login = ngui.find_button(centen_test.ui_loading,"cont/btn_logo");
--	centen_test.set_but_click(centen_test.but_login,"login");
--	centen_test.but_loginout = ngui.find_button(centen_test.ui_loading,"cont/btn_logo_out");
--	centen_test.set_but_click(centen_test.but_loginout,"loginout");
--	centen_test.but_login_ex = ngui.find_button(centen_test.ui_loading,"cont/btn_exchange");
--	centen_test.set_but_click(centen_test.but_login_ex,"ex");
--	centen_test.but_login_sure = ngui.find_button(centen_test.ui_loading,"cont/btn_sure");
--	centen_test.set_but_click(centen_test.but_login_sure,"sure");
--
--	centen_test.label1 = ngui.find_label(centen_test.ui_loading,"cont/lab1");
--	centen_test.label2 = ngui.find_label(centen_test.ui_loading,"cont/lab2");
--
--	centen_test.ui_send_input = ngui.find_input(centen_test.ui_loading,"cont/sp_input");
--	centen_test.ui_send_input:set_default_text("请输入内容");
--	centen_test.ui_send_input:set_value("");
--end
--
--function centen_test.set_but_click(but,str)
--	but:reset_on_click();
--	but:set_event_value(str,0);
--	but:set_on_click("centen_test.test_but_click");
--end
--
--function centen_test.set_text(str1,str2)
--	if str1 ~= nil then
--		centen_test.label1:set_text(tostring(str1));
--	end
--	if str2 ~= nil then
--		centen_test.label2:set_text(tostring(str2));
--	end
--end
--
--function centen_test.test_but_click(t)
--	if t.string_value == "login" then
--		app.log("click login");
--		Root.push_web_info("@@@","####")
----		util.quit();
----		UserCenter.login();
--	elseif t.string_value == "loginout" then
--		app.log("click loginout");
--		UserCenter.on_logout();
--	elseif t.string_value == "ex" then
--		app.log("click ex");
--		UserCenter.switch_account();
--	elseif t.string_value == "sure" then
--		app.log("click sure");
--		local input_str = centen_test.ui_send_input:get_value();
--		app.log("input_str:"..input_str);
----		UserCenter.open_user_center_kefu();
--		UserCenter.alipay_pay(0.01,"东京喰种测试充值","一个小钱","ghoul"..os.time());
--	end
--end
--
--ResourceLoader.LoadAsset("assetbundles/prefabs/text/ui_test_liujia.assetbundle", centen_test.test_load);
