-- region *.lua
-- Date
-- 此文件由[BabeLua]插件自动生成

local ObjectRenderManager = {
    myObj = nil,
    showObjs = { },
    -- ObjectManager.objects
    maxShowCount = 20,
    radius = 1,
    layer = nil,
}

 

 


-- 范围内英雄
function ObjectRenderManager.OnUpdate()
    if ObjectManager.GetHeroCount() <= GameSettings.GetHeroRendererMaxCount() then
        return
    end

    local cap = g_dataCenter.fight_info:GetCaptain();
    if cap then
        local pos = cap:GetPosition()
        if pos then
            local iids = util.overlap_sphere(pos.x, pos.y, pos.z, ObjectRenderManager.radius, ObjectRenderManager.layer);
            local iidsTable = { }
            local iidsLen = 0;
            -- 上一次显示数量
            local lastShowLen = table.get_num(ObjectRenderManager.showObjs)
            if iids then
                for k, v in pairs(iids) do
                    local scene_obj = ObjectManager.GetObjectByIid(v)
                    if scene_obj and not scene_obj:IsMyControl() and scene_obj.sync_type == ENUM.SyncObjType.FullSync then
                        iidsTable[v] = v
                        iidsLen = iidsLen + 1
                    end
                end
            end
            -- 不变的操作
            local noActionData = { }
            local noActionCount = 0

            for k, iid in pairs(iidsTable) do
                if ObjectRenderManager.showObjs[iid] ~= nil then
                    local scene_obj = ObjectManager.GetObjectByIid(iid)
                    if scene_obj and not scene_obj:IsMyControl() then
                        noActionData[iid] = scene_obj
                        iidsTable[iid] = nil
                        noActionCount = noActionCount + 1
                    end
                end
                -- 不操作的数据 == 最大显示数量则返回
                if noActionCount >= GameSettings.GetHeroRendererMaxCount() then
                    --app.log("xxx:" .. tostring(noActionCount))

                    break
                end

            end



            -- 隐藏的部分
            -- if noActionCount > 0 then
            for iid, v in pairs(ObjectRenderManager.showObjs) do
                if noActionData[iid] == nil then
                    local scene_obj = ObjectManager.GetObjectByIid(iid)
                    if scene_obj and not scene_obj:IsMyControl() then
                        local obj = scene_obj:GetObject()
                        if obj then
                            obj:set_render_enable(false, true)
                            ObjectRenderManager.showObjs[iid] = nil
                        end
                    end
                end
            end
            -- end
            local needGetShowCount = GameSettings.GetHeroRendererMaxCount() - noActionCount
            local getCount = 0;
            for iid, v in pairs(iidsTable) do
                if getCount >= needGetShowCount then
                    break
                end
                local scene_obj = ObjectManager.GetObjectByIid(iid)
                if scene_obj and not scene_obj:IsMyControl() then
                    local obj = scene_obj:GetObject()
                    if obj then
                        obj:set_render_enable(true, true)
                        ObjectRenderManager.showObjs[iid] = scene_obj
                        getCount = getCount + 1
                    end
                end

            end
        end
    end

end


ORM = {
    lastUpdateTime = 0;
}
function ORM.Init(radius, layer)
    ObjectRenderManager.radius = radius or 6
    layer = layer or PublicFunc.GetBitLShift( { PublicStruct.UnityLayer.player })
    ObjectRenderManager.layer = layer
    Root.AddUpdate(ORM.OnUpdate)
end

function ORM.GetShowingRendersCount()
    return #ObjectRenderManager.showObjs;
end

function ORM.OnUpdate(fixedDeltime)
    local now = app.get_time()
    if ORM.lastUpdateTime <= now then
        ORM.lastUpdateTime = now + 0.5
    else
        return
    end
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        return
    end
    if ObjectManager.GetHeroCount() < GameSettings.GetHeroRendererMaxCount() then
        return
    end

    ObjectRenderManager.OnUpdate()
    --[[  local iids = ObjectRenderManager.GetRangeObjects()
    local intersectionData, hideData, showData = ObjectRenderManager.GetActionData(ObjectRenderManager.showObjs, iids)



    for k, v in pairs(hideData) do
        local gameoobj = v:GetObject()
        if gameoobj then
            gameoobj:set_render_enable(false, true)
            --  v.is_renderer_show = false
        end
    end

    for k, obj in pairs(showData) do
        local gameoobj = obj:GetObject()
        if gameoobj then
            gameoobj:set_render_enable(true, true)
            -- obj.is_renderer_show = true
        end
    end

    ObjectRenderManager.showObjs = showData;
    for k, v in pairs(intersectionData) do
        ObjectRenderManager.showObjs[k] = v
    end
    --]]

end

ORM.Init()

return ORM
-- endregion
