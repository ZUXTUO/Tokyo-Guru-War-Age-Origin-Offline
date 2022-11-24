--[[
region resource_manager.lua
date: 2015-11-9
time: 19:3:40
author: Nation
]]
ResourceManager = {
    -- init = false,
    auto_gc = true,

    -- resource = {},
    resource_loading = { },

    resourceObjects = { },

    control_hero_reserved_res = {}, -- {[1]={},[2]={},[3]={}}
    reserved_res = {},
    permanent_reserved_res =
    {
        ["assetbundles/prefabs/ui/new_fight/xin_main.assetbundle"] = true,
        ["assetbundles/prefabs/ui/mmo_task/ui_3305_task.assetbundle"] = true,
        ["assetbundles/prefabs/ui/new_fight/left_touch_ui_bk.assetbundle"] = true,
        ["assetbundles/prefabs/ui/new_fight/right_down_other.assetbundle"] = true,
        ["assetbundles/prefabs/ui/new_fight/right_centre_other.assetbundle"] = true,
        ["assetbundles/prefabs/ui/image/icon/zhan_dou/90_90/jinzhi.assetbundle"] = true,
        ["assetbundles/prefabs/ui/image/icon/zhan_dou/90_90/jiaxue.assetbundle"] = true,

        --loading
        ["assetbundles/prefabs/ui/loading/ui_loading_normal.assetbundle"] = true,
    },

    res_object_pool_node = nil,


    main_city_reserved_ui_res = {}
}

local function __is_main_city_reserved_ui(path)
    local _fm = FightScene.GetFightManager()
    if nil == _fm then
        -- app.log("__is_main_city_reserved_ui  nil fightmanager........." );
        return false;
    end

    if _fm._className ~= "MainCityFightManager" then
        return false;
    end

    if nil == MainCityFightManager.pre_load_file_list then
        return false;
    else
        local f = MainCityFightManager.pre_load_file_list[path]
        return f ~= nil
    end
end 




----------------------------------------------------------------------------
-- TODO: kevin ResourceObject 重构过程中临时使用的资源对象
ResourceObject = Class("ResourceObject")

function ResourceObject:ResourceObject()

    -- isRawAssetObj: 针对非预设资源(比如纹理资源) 和一些必须用assetobj的情况
    self.isRawAssetObj = false

    -- object: 通过assetobj生成的 GameObject
    self.object = nil

end

function ResourceObject:GetIsRawAssetObj()
    return self.isRawAssetObj;
end

function ResourceObject:SetObject(obj, is_raw_asset_obj)
    self.isRawAssetObj = is_raw_asset_obj
    self.obj = obj;
end

function ResourceObject:GetObject()
    return self.obj;
end
----------------------------------------------------------------------------
 

function ResourceManager.SetAutoGC(auto)
    --TODO: kevin auto_gc 是个遗留概念，主要是以前“主城” 是纯UI数量大， 但是后来主城都是UI加人物资源混杂了， auto_gc已经不能适应了。
    --如果UI有问题就修改UI把， 不要auto_gc了。 


    -- ResourceManager.auto_gc = auto;

    --    local mt = { __mode = nil }
    --    if auto then
    --        mt.__mode = "v"
    --    end

    --    setmetatable(ResourceManager.resourceObjects, mt);
end


function ResourceManager.AddResourceObject(path, obj)
    if nil ~= ResourceManager.res_object_pool_node and not obj:GetIsRawAssetObj() then
        if obj:GetObject() then
            obj:GetObject():set_parent(ResourceManager.res_object_pool_node)
        end
    end

    ResourceManager.resourceObjects[path] = obj;
    ResourceManager.resource_loading[path] = nil


    if __is_main_city_reserved_ui(path) then
        -- app.log("add reserved res:" .. path);
        ResourceManager.main_city_reserved_ui_res[path] = true
    end
end

function ResourceManager.SetLoadingComplete(fpath)
    ResourceManager.resource_loading[fpath] = nil
end

function ResourceManager.Dump()
    for k, v in pairs(ResourceManager.reserved_res) do
        app.log("k=" .. tostring(k))
    end
end

function ResourceManager.DelRes(path)
    ResourceManager.DelResObject(path)
end

function ResourceManager.DelResObject(path)
    if ResourceManager.IsReservedRes(path) then
        --app.log("try to delete a reserved res:"..path)
        return
    end

    if ResourceManager.resourceObjects[path] ~= nil then
        ResourceManager.resourceObjects[path] = nil
    end
end

function ResourceManager.IsLoading(path)
    return(ResourceManager.resource_loading[path] ~= nil)
end

function ResourceManager.AddLoading(path)
    ResourceManager.resource_loading[path] = path
end



function ResourceManager.GetRes(path)
    return ResourceManager.GetResourceObject(path)
end



function ResourceManager.GetResourceObject(path)
    return ResourceManager.resourceObjects[path];
end

 
function ResourceManager.DestroyRes()
    for k, v in pairs(ResourceManager.resourceObjects) do
        if not ResourceManager.IsReservedRes(k) then
            ResourceManager.DelResObject(k)
        end
    end
    
    -- call other subsystem..
    EffectManager.DestroyRes();

    PublicFunc.lua_gc();
end

function ResourceManager.GC(force, real_gc)

    -- ResourceManager.DestroyRes 代替 ResourceManager.GC 功能。
    do return end

    -- if not ResourceManager.auto_gc then
    --     for k, v in pairs(ResourceManager.resourceObjects) do
    --         if not ResourceManager.IsReservedRes(k) then
    --             ResourceManager.DelResObject(k)
    --         end
    --     end
    -- end

    -- -- call other subsystem..

    -- --TODO: kevin 暂时保留所有特效。。。。。。。
    -- -- EffectManager.DestroyRes();

    -- if real_gc then
    --     PublicFunc.lua_gc();
    -- end
end

function ResourceManager.Destory()
    -- ResourceManager.resource = {}
    ResourceManager.resource_loading = { }
    ResourceManager.reserved_res = { }
    ResourceManager.resourceObjects = { }
end

function ResourceManager.SetControlHeroReservedRes(pos, data)
    ResourceManager.control_hero_reserved_res[pos] = {}

    -- app.log(">>>>>>>>>> add hero reserved res:"..tostring(pos).." ,"..tostring(#data))
    for k, v in pairs(data) do
        -- app.log("add control hero reserved res ..".. v)
        ResourceManager.control_hero_reserved_res[pos][v] = true
    end
end

function ResourceManager.AddReservedRes(data)
    if type(data) == "string" then
        ResourceManager.reserved_res[data] = true
        -- app.log("########reserved_res:"..data)
    elseif type(data) == "table" then
        for k, v in pairs(data) do
            ResourceManager.reserved_res[v] = true
            -- app.log("#######reserved_res:"..v)
        end
    end
end

function ResourceManager.AddPermanentReservedRes(data)
    if type(data) == "string" then
        ResourceManager.permanent_reserved_res[data] = true
        -- app.log("######## permanent_reserved_res:"..data)
    elseif type(data) == "table" then
        for k, v in pairs(data) do
            ResourceManager.permanent_reserved_res[v] = true
            -- app.log("#######permanent_reserved_res:"..v)
        end
    end
end

function ResourceManager.DelReservedRes(path)
    ResourceManager.reserved_res[path] = nil
end

function ResourceManager.IsReservedRes(path)

    --TODO:kevin 临时不释放所ui
    -- app.log("xxxxxxxxxxxxx:"..path)
    if ResourceManager.main_city_reserved_ui_res[path] ~= nil then
        -- app.log("find reserved res:" .. path)
        return true;
    end


    local find = ResourceManager.reserved_res[path] ~= nil or ResourceManager.permanent_reserved_res[path] ~= nil
    if not find then
        for k, v in pairs(ResourceManager.control_hero_reserved_res) do
            if v[path] then
                return true
            end
        end
    else
        return true
    end

    return false;
end

function ResourceManager.ClearReservedRes()
    ResourceManager.reserved_res = {}
end

ResourceManager.SetAutoGC(true);
ResourceManager.res_object_pool_node = asset_game_object.find("res_object_pool")
ResourceManager.res_object_pool_node:set_active(false);

--[[ endregion ]]