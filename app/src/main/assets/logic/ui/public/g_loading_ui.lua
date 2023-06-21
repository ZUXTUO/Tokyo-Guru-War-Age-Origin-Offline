
GLoading = {}

GLoading.EType = 
{
    msg=1,
    loading=2,
    ui=3,
}

local ELoadingCfg = 
{
    [GLoading.EType.msg] = { delay=5000, auto_close_time=20000, uuid={}, },
    [GLoading.EType.loading] = { delay=300, auto_close_time=10000, uuid={}, },
    [GLoading.EType.ui] = { delay=3000, auto_close_time=20000, uuid={}, },
}

function GLoading.Instance()
    if GLoading._inst == nil then
        GLoading._inst = Loading:new()
        GLoading._inst:SetParent(Root.get_root_ui_2d())
    end
end

function GLoading.Show(loading_type, delay, auto_close_time, canClick)
    GLoading.Instance()
    
    local type = ENUM.ELoadingType.FullScreen
    local scale = ENUM.ELoadingScale.Middle

    GLoading._inst:SetType(type)
    GLoading._inst:SetScale(scale)

    if loading_type then
        local cfg = ELoadingCfg[loading_type];
        delay = delay or cfg.delay;
        auto_close_time = auto_close_time or cfg.auto_close_time;
    end

    local uuid = GLoading._inst:Show(delay, auto_close_time, canClick);
    if loading_type then
        local cfg = ELoadingCfg[loading_type];
        cfg.uuid[uuid] = 1;
    end
    if loading_type == nil then
        app.log("#GLoading#show loading_type:"..tostring(loading_type).. " uuid:"..tostring(uuid)..debug.traceback());
    end
    return uuid;
end

function GLoading.Hide(loading_type, uuid)
    if loading_type == nil then
        app.log("#GLoading#hide loading_type:"..tostring(loading_type).. " uuid:"..tostring(uuid)..debug.traceback());
    end
    if uuid then
        for k,v in pairs(ELoadingCfg) do
            for kk,vv in pairs(v.uuid) do
                if kk == uuid then
                    if GLoading._inst ~= nil then
                        GLoading._inst:Hide(uuid);
                    end
                end
            end
        end
        return;
    end
    if loading_type then
        local cfg = ELoadingCfg[loading_type];
        for k,v in pairs(cfg.uuid) do
            if GLoading._inst ~= nil then
                GLoading._inst:Hide(k);
            end
        end
        cfg.uuid = {};
        return;
    end
    for k,v in pairs(ELoadingCfg) do
        for kk,vv in pairs(v.uuid) do
            if GLoading._inst ~= nil then
                GLoading._inst:Hide(kk);
            end
        end
        v.uuid = {};
    end
end