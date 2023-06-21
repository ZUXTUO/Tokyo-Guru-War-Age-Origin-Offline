EnterShow = {
	startLoadCallback = nil; --场景加载回调
    enterGameCallback = nil; --进入游戏回调
}

-- 0/1/2/3/-1 无记录/完成巅峰/完成序章1/完成序章2/待查询记录
local _record = 0
local _last_record = 0
local _timerId = nil
local _test_local_mode = false

local dataTable = { 
type = ENUM.ELoadingType.Single, 
scale = ENUM.ELoadingScale.Middle, 
parent = Root.uiroot, 
}


--判断登录是否进入展示
function EnterShow.CheckEnter( )
    -- 0/1/2/3 无记录/完成巅峰/完成序章1/完成序章2
    --if AppConfig.get_enable_peak_show() then
        EnterShow.QureyRecord()
		if _record == nil then
            _record = 0
        end
		
        if _record < 3 then
            return true
        else
            return false
        end
    --else
        --return false
    --end
end

function EnterShow.Start(startLoadCallback, enterGameCallback)
    EnterShow.startLoadCallback = startLoadCallback or EnterShow.startLoadCallback
    EnterShow.enterGameCallback = enterGameCallback or EnterShow.enterGameCallback
	
	_record = enterGameCallback;

    --查询结果回调只执行1次
    if startLoadCallback == nil or enterGameCallback == nil then
        if _last_record == _record then
            return
        end
        _last_record = _record
    else
       _last_record = _record
    end

    if _record == -1 then
    elseif _record == 0 then
        app.log("GameBegin 巅峰展示");
        --GameBegin.login_bg_destroy();
        --SceneManager.PushMainCityScene();
        PeakShowFightManager.Begin()
    elseif _record == 1 then--序章1
        app.log("EnterShow.Start [1] 序章1");
        SceneManager.BeginPlayFirstStory()
        EnterShow.CallStartLoadback()
    elseif _record == 2 then--序章2
        app.log("EnterShow.Start [2] 序章2");
        SceneManager.BeginPlaySecondStory()
        EnterShow.CallStartLoadback()
    elseif _record == 3 then--进入游戏
        app.log("EnterShow.Start [3] 进入游戏");
        EnterShow.CallStartBack()

        --g_player_local.cg_rand_name();--随机名称
        --g_player_local.cg_set_name();--设置角色名
        g_player_local.cg_create_player_info();--创建本地角色
        
        GameBegin.login_bg_destroy();
        SceneManager.PushMainCityScene();
    end
end

function EnterShow.CallStartLoadback()
    if EnterShow.startLoadCallback then
        EnterShow.startLoadCallback()
        EnterShow.startLoadCallback = nil
    end
end

function EnterShow.CallStartBack()
    --if EnterShow.enterGameCallback then
        --EnterShow.enterGameCallback()
        EnterShow.enterGameCallback = nil
    --end
end

function EnterShow.CallLog()
	app.log("响应测试");
end

function EnterShow.QureyRecord()
    if _test_local_mode then
        _record = LocalFile.GetPrologueRecord()
    else
        _record = LocalFile.GetPrologueRecord()
        if _record == -1 then
            _record = 0
        end
    end
    return _record
end

function EnterShow.OnGetHttpSuccess(t)
    if _timerId then
        timer.stop(_timerId)
        _timerId = nil
    end

    local json_info = pjson.decode(t.result);
    if json_info and json_info.ret == 0 and json_info.accountid == UserCenter.get_accountid() then
        _record = tonumber(json_info.flag) or 0
        --回写到本地记录
        LocalFile.WritePrologueRecord(_record)
    else
        _record = 0
    end

    EnterShow.Start()
end

function EnterShow.OnGetHttpError(t)
    if _timerId then
        timer.stop(_timerId)
        _timerId = nil
    end
    _record = 0 --获取失败默认未记录

    EnterShow.Start()
end

function EnterShow.GetHttpRecord()
    if _test_local_mode then return end

    local url = AppConfig.get_system_check_httpurl()[1]
    local path = AppConfig.get_auth_server_path()
    if type(url) == "string" and #url > 0 and 
        type(path) == "string" and #path > 0 then

        local req_inf = {type=60, openid=UserCenter.get_accountid(), token=UserCenter.get_accessToken()}
        req_inf = pjson.encode(req_inf)

        ghttp.post( url, "EnterShow.OnGetHttpSuccess", "EnterShow.OnGetHttpError", path, req_inf );

        _timerId = timer.create("EnterShow.OnGetHttpError", 10000, 1);
    end
end

function EnterShow.OnPostHttpSuccess(t)
    app.log("OnPostHttpSuccess="..table.tostring(t));
end

function EnterShow.OnPostHttpError(t)
    app.log("OnPostHttpError="..table.tostring(t));
end

function EnterShow.PostHttpRecord(value)
    if _test_local_mode then return end

    local url = AppConfig.get_system_check_httpurl()[1]
    local path = AppConfig.get_auth_server_path()
    if type(url) == "string" and #url > 0 and 
        type(path) == "string" and #path > 0 then

        local req_inf = {type=61, openid=UserCenter.get_accountid(), token=UserCenter.get_accessToken(), flag=tostring(value)}
        req_inf = pjson.encode(req_inf)

        ghttp.post( url, "EnterShow.OnPostHttpSuccess", "EnterShow.OnPostHttpError", path, req_inf );
    end
end