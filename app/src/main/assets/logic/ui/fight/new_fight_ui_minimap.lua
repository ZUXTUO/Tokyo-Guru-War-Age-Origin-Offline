NewFightUiMinimap = Class('NewFightUiMinimap', UiBaseClass);

local min_dis_green_point = 15;   --两个绿点之间的距离

----------------------------外部接口-------------------------------
function NewFightUiMinimap:AddPeople(entity, entityType, syncRotation, iconParam)
    --app.log('NewFightUiMinimap:AddPeople ' ..debug.traceback())
    if entity == nil then
        return
    end

    if syncRotation == nil then
        syncRotation = false
    end

    local gid = entity:GetGID()
    if self.ui then

        local entityInfo = self.mapEntityInfo[gid]
        if entityInfo then
            if entityInfo.eType == entityType then
                return
            else
                self:DeletePeopleByGid(gid)
            end
        end


        local iconNode = self.iconsNode[entityType]
        if not iconNode then
            return
        end
        
        local data = {}
        data.syncRot = syncRotation
        data.node = iconNode:clone()
        data.node:set_active(true)
        data.node:set_name(entity:GetName())

        local ip = self.data.iconsParam[entityType]
        data.adjustAngle = ip.adjustAngle or 0

        data.eType = entityType
        data.iconParam = iconParam

        if type(iconParam) == 'table' then
            if iconParam.spriteName then
                local spNodeName = nil
                if iconParam.spriteNodeName then
                    spNodeName = iconParam.spriteNodeName
                else
                    spNodeName = data.node:get_name()
                end
                local sp = ngui.find_sprite(data.node, spNodeName)
                if sp then
                    sp:set_sprite_name(iconParam.spriteName)
                end
            end
        end

        self.mapEntityInfo[gid] = data

        self:UpdateEntityPos(entity, data)
        self:HideSyncPosEntity(gid)
    else
        self.uiLoadObj[gid] = {eType = entityType, syncRot = syncRotation}
    end

    if self.bigMap then
        self.bigMap:AddPeople(entity, entityType, syncRotation, iconParam)
    end
end

function NewFightUiMinimap:GetPeopleData(entity) 
    local gid = entity:GetGID()
    return self.mapEntityInfo[gid]
end

function NewFightUiMinimap:DeletePeopleByGid(gid)
    --app.log('NewFightUiMinimap:DeletePeopleByGid ' ..debug.traceback())
    if self.uiLoadObj[gid] then
        self.uiLoadObj[gid] = nil
    end
    
    local info = self.mapEntityInfo[gid]
    if info then
        info.node:set_active(false)
        self.mapEntityInfo[gid] = nil


        local x,y,z = info.node:get_local_position()
        self:ShowSyncPosEntity(gid, x, y)
    end

    if self.bigMap then
        self.bigMap:DeletePeopleByGid(gid)
    end
end

function NewFightUiMinimap:DeletePeople(entity)
    
    if not entity then return end
    local gid = entity:GetGID()
    self:DeletePeopleByGid(gid)

--[[
    local entityGid = entity:GetGID();
    local curEntity =  g_dataCenter.fight_info:GetCaptain();
    if curEntity and curEntity:GetGID() ~= entityGid then
        self:DestroyMinimapObj(entityGid);
    end
    ]]
end

function NewFightUiMinimap:GetGhostIndex()
    self.mapPosIndex = self.mapPosIndex + 1
    return self.mapPosIndex
end

function NewFightUiMinimap:AddPositionEntity(pos, entityType, delayTime, gray)
    local gid = "position_" .. self:GetGhostIndex()
    self.mapPositionEntityInfo = self.mapPositionEntityInfo or {}
    if self.mapPositionEntityInfo[gid] then
        return
    end
    if not self.iconsNode or not self.iconsNode[entityType] then
        return    
    end
    info = {}
    info.node = self.iconsNode[entityType]:clone()
    info.node:set_active(true)
    info.node:set_name(tostring(gid))
    info.eType = entityType
    self.mapPositionEntityInfo[gid] = info

    info.pos = pos
    local tx, ty = self:WorldPosToMapPos(pos.x, pos.y)
    info.node:set_local_position(tx, ty, 0);
    info.gray = gray
    if gray then
        local sp = ngui.find_sprite(info.node, info.node:get_name())
        if sp then
            sp:set_color(0, 0, 0, 1)
        end
    end

    if delayTime then
        info.deleteTime = app.get_time() + delayTime
    end
    --app.log("#hyg#AddPositionEntity info.deleteTime " .. tostring(info.deleteTime))
    if self.bigMap then
        self.bigMap:AddPositionEntity(pos, entityType, delayTime, gray)
    end

    return gid
end

function NewFightUiMinimap:DelPositionEntity(gid)
    local info = self.mapPositionEntityInfo[gid]
    if info then
        info.node:set_active(false)
        self.mapPositionEntityInfo[gid] = nil
    end

    if self.bigMap then
        self.bigMap:DelPositionEntity(gid)
    end
end

function NewFightUiMinimap:AddSyncPosEntity( gid ,bossid, eType)
    if self.mapSyncPosEntityInfo[gid] then
        return
    end

    if not self.iconsNode or not self.iconsNode[eType] then
        return    
    end
    
    info = {}
    info.node = self.iconsNode[eType]:clone()
    info.node:set_active(true)

    info.node:set_name(tostring(gid))

--    local cf = ConfigManager.Get(EConfigIndex.t_monster_property,bossid);
--    if cf then
--        local sp = ngui.find_sprite(info.node, 'sp_human')
--        sp:set_sprite_name(cf.small_icon)
--    end
    
    info.eType = eType
    info.bossid = bossid

    self.mapSyncPosEntityInfo[gid] = info

    if self.bigMap then
        self.bigMap:AddSyncPosEntity( gid ,bossid, eType)
    end

    return info
end

function NewFightUiMinimap:DelSyncPosEntity(gid)
    local info = self.mapSyncPosEntityInfo[gid]
    if info then
        info.node:set_active(false)
        self.mapSyncPosEntityInfo[gid] = nil
    end

    if self.bigMap then
        self.bigMap:DelSyncPosEntity(gid)
    end
end

function NewFightUiMinimap:ShowSyncPosEntity(gid, mapx, mapy)
    local info = self.mapSyncPosEntityInfo[gid]
    if info then
        info.node:set_active(true)
        info.node:set_local_position(mapx, mapy, 0)
    end
end

function NewFightUiMinimap:HideSyncPosEntity(gid)
    local info = self.mapSyncPosEntityInfo[gid]
    if info then
        info.node:set_active(false)
    end
end

--9宫格的情况下更新boss位置
function NewFightUiMinimap:UpdateBossPos(entityGid, bossid, x, y, state)

    if state == 1 then
        self:DelSyncPosEntity(entityGid)
    else
        local info = self.mapSyncPosEntityInfo[entityGid]
        if not info then
            info = self:AddSyncPosEntity(entityGid, bossid, EMapEntityType.EBoss)
        end
        local tx, ty = self:WorldPosToMapPos(x,y)
        info.node:set_local_position(tx, ty, 0);

        info.lastPos = {x = x, y = y}
    end

    if self.bigMap then
        self.bigMap:UpdateBossPos(entityGid, bossid, x, y, state)
    end

   --[[
    local cf = ConfigManager.Get(EConfigIndex.t_monster_property,bossid);
    if not cf then
        return;
    end
    if state == 1 then
        self:DestroyMinimapObj(entityGid);
    else
        local uiObj = self.minimapPool[entityGid];
        --没有就创建一个
        if not uiObj then
            uiObj = self.cloneHead:clone();
            if self.texturePool[entityGid] then
                self.texturePool[entityGid]:Destroy();
                self.texturePool[entityGid] = nil;
            end
            self.texturePool[entityGid] = ngui.find_texture(uiObj, "text_human");
            self.texturePool[entityGid]:set_texture(cf.icon46);           
            uiObj:set_active(true);
            uiObj:set_name("minimap_"..tostring(entityGid));
            self:CreateMinimapObj(entityGid, uiObj)
        end
        local pos = {x=x, z=y};
        local newPosX = (pos.x - self.xPosMinimap) * self.xScaleMinimap;
        local newPosY = (pos.z - self.zPosMinimap) * self.zScaleMinimap;
        uiObj:set_local_position(newPosX, newPosY, 0);
    end
    ]]
end


----------------------=-----内部接口--------------------------------
--初始化
--data = 
--{
--  parent = nil, 父节点
--  tType = 1, 1显示最靠右的地图 2显示旁边靠左点的地图
--  ratation = {x=0, y=0, z=0} 旋转的度数
--}

function NewFightUiMinimap:Init(data)
    self.pathRes = data.uiPath
    UiBaseClass.Init(self, data);
end

--初始化数据
function NewFightUiMinimap:RestartData(data)
    UiBaseClass.RestartData(self, data);
    self.data = data;

    self.mapEntityInfo = {}
    self.mapSyncPosEntityInfo = {}

    self.mapPosIndex = 0
    self.mapPositionEntityInfo = nil

    self.uiLoadObj = {};

    self.pointNodePool = {}
    self.cornerPointNodePool = {}
--[[
    self.minimapPool = {};
    self.texturePool = {};
    --场景中的底板
    self.objMinimapBk = nil;
    --当前显示的texture
    self.objCurTexture = nil;
    --boss头像
    self.cloneHead = nil;
    --玩家点
    self.clonePot = nil;
    --当前场景面片所在的位置
    self.xPosMinimap = 0;
    self.zPosMinimap = 0;
    --场景上的面片与我们的texture之间的比例
    self.xScaleMinimap = 0;
    self.zScaleMinimap = 0;
    --ui没有加载成功时来加入的对象
    self.uiLoadObj = {};
    self.showLock = false;
    ]]
end

--注册回调函数
function NewFightUiMinimap:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['UpdateMinimap'] = Utility.bind_callback(self, self.UpdateMinimap);
    self.bindfunc['OpenBigMap'] = Utility.bind_callback(self, self.OpenBigMap);
    self.bindfunc['OnClickClose'] = Utility.bind_callback(self, self.OnClickClose);
    self.bindfunc['OnClickMove'] = Utility.bind_callback(self, self.OnClickMove);
end

--初始化UI
function NewFightUiMinimap:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_name("NewFightUiMinimap")

    self.iconsNode = {}
    for k,v in pairs(self.data.iconsParam) do
        local node = self.ui:get_child_by_name(v.nodeName)
        if node then
            node:set_active(false)
            self.iconsNode[k] = node
        end
    end
    

    self.mapSceneSizeNode = asset_game_object.find(self.data.sceneMapSizeName)

    if self.mapSceneSizeNode == nil then
        app.log('NewFightUiMinimap:InitUI find node error:' .. tostring(self.data.sceneMapSizeName))
    end

    self.uiMapBkTexture = ngui.find_texture(self.ui, self.data.uiMapBkTex)
    self:CalMinimapPro()

    local pathWayPiontSp = ngui.find_sprite(self.ui, 'sp_yellow')
    local pathWayCornerPointSp = ngui.find_sprite(self.ui, 'sp_green')

    if pathWayPiontSp == nil or pathWayCornerPointSp == nil then
        if self.data.clickMove then
            self.data.clickMove = nil
            app.log('minimap not path sprite!')
        end
    else
        pathWayPiontSp:set_active(false)
        pathWayCornerPointSp:set_active(false)

        self.pathWayPiontNode = pathWayPiontSp:get_game_object()
        self.pathWayCornerPointNode = pathWayCornerPointSp:get_game_object()
    end

    if self.data.isBigMap == true then
        local btn = ngui.find_sprite(self.ui, 'sp_mark')
        if self.data.clickMove == true then
            btn:set_on_ngui_click(self.bindfunc['OnClickMove']);
        else
            btn:set_on_ngui_click(self.bindfunc['OnClickClose'])
        end

        local closeBtn = ngui.find_button(self.ui, 'sp_cha')
        if closeBtn then
            closeBtn:set_on_click(self.bindfunc['OnClickClose'])
        end
    else
        local btn = ngui.find_button(self.ui , 'sp_di')
        btn:set_on_click(self.bindfunc['OpenBigMap'])

        -- local ct = GetMainUI():GetComponent(EMMOMainUICOM.MainUIOptionTip);
        -- if ct then
        --     local sp = ngui.find_sprite(self.ui, 'sp_di')
        --     local h = sp:get_height() or 0
        --     ct:SetLocalPosition(0, -h, 0);
        -- end
    end

    for gid, v in pairs(self.uiLoadObj) do
        local entity = ObjectManager.GetObjectByGID(gid)
        if entity then
            self:AddPeople(entity, v.eType, v.syncRot, v.iconParam);
        end
    end
    self.uiLoadObj = {}

    self.tmUpdateMinimap = timer.create(self.bindfunc['UpdateMinimap'], 100, -1);

    if self.data.mapEntityInfo then
        self:SetMapEntityInfo(self.data.mapEntityInfo)
    end

    -- if g_dataCenter.autoPathFinding:IsMoving() then
    --     self:ShowMovePath()
    -- end

    for entityType,info in pairs(self.data.iconsParam) do
        for _,entity in pairs(info.entity_list or {}) do
            if entityType == EMapEntityType.EMy then
                self:AddPeople(entity, entityType, true);
            else
                self:AddPeople(entity, entityType);
            end
        end
    end

    if self.data.loadedCallback then
        Utility.CallFunc(self.data.loadedCallback, self.data.callbackParam, self)
    end

    --[[
    if self.data.parent then
        self.ui:set_parent(self.data.parent);
        --设置了父节点后需要马上将这个父节点去掉引用  不然会引起其他地方释放不到资源
        self.data.parent = nil;
    else
        self.ui:set_parent(Root.get_root_ui_2d_fight());
    end
    self.ui:set_local_scale(1,1,1);
    self.ui:set_local_position(0,0,0); 

    do return end

    --类型
    local tType = self.data.tType;
    local ratation = self.data.ratation;
    --ui初始化
    self.control = {}
    local rightTopOther = self.control;
    --小地图
    rightTopOther.listMap = {};
    for i = 1, 1 do
        rightTopOther.listMap[i] = {};
        local mapInfo = rightTopOther.listMap[i];
        mapInfo.objRoot = self.ui:get_child_by_name("sp_di"..i);
        local btn = ngui.find_button(mapInfo.objRoot, mapInfo.objRoot:get_name());
        btn:set_on_click(self.bindfunc['OpenBigMap']);
        mapInfo.textureMap = ngui.find_texture(mapInfo.objRoot, "Texture");
        mapInfo.objHead = mapInfo.objRoot:get_child_by_name("content");
        mapInfo.objHead:set_active(false);
        mapInfo.objPot = mapInfo.objRoot:get_child_by_name("sp");
        mapInfo.objPot:set_active(false);
        if i ~= tType then
            mapInfo.objRoot:set_active(false);
        end
    end
    self.objMinimapBk = asset_game_object.find("scene_minimap");
    --当前texture以及场景中的底板 各自玩法自己去修改
    self.objCurTexture = rightTopOther.listMap[tType].textureMap;
    self.objCurTexture:get_game_object():set_local_rotation(ratation.x, ratation.y, ratation.z);
    self.cloneHead = rightTopOther.listMap[tType].objHead;
    self.cloneHead:set_local_rotation(ratation.x, ratation.y, -ratation.z);
    self.clonePot = rightTopOther.listMap[tType].objPot;
    --ui加载完成后需要加入在ui加载之间的对象
    for k, v in pairs(self.uiLoadObj) do
        self:AddPeople(v);
        self.uiLoadObj[k] = nil;
    end
    --小地图的更新池
    self.tmUpdateMinimap = timer.create(self.bindfunc['UpdateMinimap'], 300, -1);

    self:CalMinimapPro();
    ]]
end

function NewFightUiMinimap:ClearMapEntity()

    for k,v in pairs(self.mapSyncPosEntityInfo) do
        v.node:set_active(false)
    end
    self.mapSyncPosEntityInfo = {}
    
    for k,v in pairs(self.mapEntityInfo) do
        v.node:set_active(false)
    end
    self.mapEntityInfo = {}
end

--析构函数
function NewFightUiMinimap:DestroyUi()
    self:ClearMapEntity()
    self:ClearPath()

    UiBaseClass.DestroyUi(self);

    if self.tmUpdateMinimap then
        timer.stop(self.tmUpdateMinimap);
        self.tmUpdateMinimap = nil;
    end

    self.iconsNode = nil
    if self.bigMap then
        self.bigMap:DestroyUi()
        self.bigMap = nil
    end

    if self.pointNodePool then
        self.pointNodePool = nil
    end

    if self.cornerPointNodePool then
        self.cornerPointNodePool = nil
    end

    --[[
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
    if self.minimapPool and self.control then 
        for k, v in pairs(self.control) do
            self.minimapPool[k]:set_active(false);
            self.minimapPool[k] = nil;
        end
    end
    if self.texturePool then
        for k, v in pairs(self.texturePool) do
            v:Destroy();
            self.texturePool[k] = nil;
        end
    end
    if self.tmUpdateMinimap then
        timer.stop(self.tmUpdateMinimap);
        self.tmUpdateMinimap = nil;
    end
    ]]
end


-----------------------更新小地图------------------
--计算地图之间的比例
function NewFightUiMinimap:CalMinimapPro()
    
    if not self.uiMapBkTexture or not self.mapSceneSizeNode then
        app.log('NewFightUiMinimap:CalMinimapPro resource error!!!')
        return
    end
    local textW, textH = self.uiMapBkTexture:get_size();
    self.mapTexUiPosX, self.mapTexUiPosY = PublicFunc.GetUiWorldPosition(self.uiMapBkTexture)

    local bkPosX, bkPosY, bkPosZ = self.mapSceneSizeNode:get_local_position();
    local bkScaleX, bkScaleY, bkScaleZ = self.mapSceneSizeNode:get_local_scale();
    self.xPosMinimap = bkPosX;
    self.zPosMinimap = bkPosZ;


    if (textW > textH and bkScaleX > bkScaleZ) or (textW < textH and bkScaleX < bkScaleZ) then
        self.xScaleMinimap = textW / bkScaleX;
        self.zScaleMinimap = textH / bkScaleZ;
    else
        self.xScaleMinimap = textW / bkScaleZ;
        self.zScaleMinimap = textH / bkScaleX;
    end

    self.uiMapRotQuat = {}
    self.uiMapRotQuat.x, self.uiMapRotQuat.y, self.uiMapRotQuat.z, self.uiMapRotQuat.w = util.quaternion_euler(0, 0 , self.data.adjustAngle);
    self.uiMapInverseRotQuat = {}
    self.uiMapInverseRotQuat.x, self.uiMapInverseRotQuat.y, self.uiMapInverseRotQuat.z, self.uiMapInverseRotQuat.w = util.quaternion_euler(0, 0 , -self.data.adjustAngle);
end

--[[
--加入小地图更新池
function NewFightUiMinimap:CreateMinimapObj(entityGid, uiObj)
    self.minimapPool[entityGid] = uiObj;
end
--从小地图更新池删除更新
function NewFightUiMinimap:DestroyMinimapObj(entityGid)
    if self.minimapPool[entityGid] then
        self.minimapPool[entityGid]:set_active(false);
        self.minimapPool[entityGid] = nil;
    end
    --地图上的boss
    if self.texturePool[entityGid] then
        self.texturePool[entityGid]:Destroy();
        self.texturePool[entityGid] = nil;
    end
end
]]

--用于大地图离开时清楚Entity信息
function NewFightUiMinimap:OnClickClose()

    --app.log('-------------------------- OnClickClose')

    self:ClearMapEntity()

    self:ClearPath()

    self:Hide()
    
    uiManager:PopUi(EUI.NewFightUiMinimap)
end

function NewFightUiMinimap:OnClickMove(name,x,y,game_obj)

    local ngui_x,ngui_y = PublicFunc.TouchPtToNguiPoint(x,y);

    local local_x = ngui_x - self.mapTexUiPosX;
    local local_y = ngui_y - self.mapTexUiPosY;

    local des_pos_x,des_pos_y,des_pos_z = self:MapPosToWorldPos(local_x,local_y);
    local data = 
    {
        my_captain = g_dataCenter.fight_info:GetCaptain(),
        des_world_id = FightScene.GetCurHurdleID(),
        des_x = des_pos_x,
        des_y = des_pos_y,
        des_z = des_pos_z,
    }

    g_dataCenter.autoPathFinding:SetDestination(data)
    self:ShowMovePath()
end

function NewFightUiMinimap:GetLineShowNodePos(bx, by, ex,ey)
    local dis = algorthm.GetDistance(bx, by, ex,ey)
    local n = math.ceil(dis/min_dis_green_point) - 1;
    local linePos = {};
    for i=1,n do
        linePos[i] = {}
        linePos[i].x = (ex - bx)*i/(n+1) + bx
        linePos[i].y = (ey - by)*i/(n+1) + by
    end
    return linePos
end

function NewFightUiMinimap:GetWayPointNode()

    local count = #self.pointNodePool
    local node = nil
    if count < 1 then
        node = self.pathWayPiontNode:clone()
    else
        node = self.pointNodePool[count]
        table.remove(self.pointNodePool, count)

        
    end

    node:set_active(true)
    return node
end
function NewFightUiMinimap:GiveBackWayPointNode(node)
    if node then
        node:set_active(false)
        --node:set_name('point_node')
        table.insert(self.pointNodePool, node)
    end
end

function NewFightUiMinimap:GetWayCornerPointNode()

    local count = #self.cornerPointNodePool
    local node = nil
    if count < 1 then
        node = self.pathWayCornerPointNode:clone()
    else
        node = self.cornerPointNodePool[count]
        table.remove(self.cornerPointNodePool, count)
    end

    node:set_active(true)
    return node
end
function NewFightUiMinimap:GiveBackWayCornerPointNode(node)
    if node then
        node:set_active(false)
        --node:set_name('corner_point_node')
        table.insert(self.cornerPointNodePool, node)
    end
end

function NewFightUiMinimap:ShowMovePath()
    local pf = g_dataCenter.autoPathFinding
    self.result_point = pf.result_point;
    if not self.result_point or #self.result_point < 2 then return end

    self:ClearPath()

    self.pathNodes = {}
    self.movingCornorCount = #self.result_point - 1

    local curMoveTo = pf:GetCurrentMoveToPointIndex() or 2

    self.curMoveToPointIndex = curMoveTo
    self.curMoveToPointChildIndex = 1
    self.showEntityName = pf:GetMyCaptain():GetName()

    curMoveTo = curMoveTo - 1
    --app.log('ShowMovePath begin ' .. tostring(#self.result_point))
    for i = curMoveTo, self.movingCornorCount do
        local beginPos = self.result_point[i]
        local endPos = self.result_point[i + 1]
        local beginX, beginY = self:WorldPosToMapPos(beginPos.x, beginPos.z)
        local endX, endY = self:WorldPosToMapPos(endPos.x, endPos.z)

        local lineShowPos = self:GetLineShowNodePos(beginX, beginY, endX, endY)

        local posCount = #lineShowPos

        local info = {}
        self.pathNodes[i] = info 

        info.cornerPointNode = self:GetWayCornerPointNode()
        info.cornerPointNode:set_local_position(endX, endY, 0)
        --info.cornerPointNode:set_name('corner_node_' .. tostring(i + 1))
        --app.log('ShowMovePath ' .. tostring(i))

        info.pointNodes = { }

        local curPosX, curPosY, curPosZ = pf:GetCurrentPosition()
        local curPosMapX, curPosMapY = self:WorldPosToMapPos(curPosX, curPosZ)
        for posIndex = 1, posCount do

            local point = lineShowPos[posIndex]

            local pvx = point.x - curPosMapX
            local pvy = point.y - curPosMapY

            local tvx = endX - curPosMapX
            local tvy = endY - curPosMapY

            local dot = pvx * tvx + pvy * tvy

            if dot > 0 then
                local node = self:GetWayPointNode()
                --node:set_name('point_node_' .. tostring(i) .. ' ' .. tostring(posIndex))
                node:set_local_position(point.x, point.y, 0)

                table.insert(info.pointNodes, node)
            end
        end

    end
end

function NewFightUiMinimap:ClearPath()
    if self.pathNodes then
        for k,info in pairs(self.pathNodes) do
            self:GiveBackWayCornerPointNode(info.cornerPointNode)

            for kk, node in ipairs(info.pointNodes) do
                self:GiveBackWayPointNode(node)
            end
        end

        self.pathNodes = nil
        self.movingCornorCount = nil

    end
end

function NewFightUiMinimap:Update()

    if self.data.isBigMap then
        local pf = g_dataCenter.autoPathFinding
        if pf:IsMoving() then

            if self.showEntityName ~= pf:GetMyCaptain():GetName() then
                self:ClearPath()
                self:ShowMovePath()
            end

            local carMoveTo = pf:GetCurrentMoveToPointIndex()
            if self.curMoveToPointIndex then
                local info = self.pathNodes[self.curMoveToPointIndex -  1]
                if self.curMoveToPointIndex ~= carMoveTo then
                    info.cornerPointNode:set_active(false)
                    -- for kk, node in ipairs(info.pointNodes) do
                    --     node:set_active(false)
                    -- end

                    self.curMoveToPointIndex = carMoveTo
                    self.curMoveToPointChildIndex = 1
                else
                    if self.curMoveToPointChildIndex <= #info.pointNodes then
                        local node = info.pointNodes[self.curMoveToPointChildIndex]

                        local x, y, z = node:get_local_position()

                        local px, py, pz = pf:GetCurrentPosition()
                        local pux, puy = self:WorldPosToMapPos(px, pz)
                        local disSQ = algorthm.GetDistanceSquared(x, y, pux, puy)
                        --app.log("NewFightUiMinimap:Update " .. tostring(disSQ) .. ' ' .. tostring(self.curMoveToPointChildIndex))
                        if disSQ < 1 then
                            node:set_active(false)
                            self.curMoveToPointChildIndex = self.curMoveToPointChildIndex + 1
                        end
                    end
                end
            end
        else
            self:ClearPath()
        end
    end

    if self.bigMap and self.bigMap:IsShow() then
        self.bigMap:Update()
    end
end

--打开大地图
function NewFightUiMinimap:OpenBigMap()
    --BigMap.Show(self.minimapPool, self.objMinimapBk);
    --app.log('-------------------------- OpenBigMap')

    if self.data.bigMapParam == nil then return end

    if self.bigMap then
        local mapEntityInfo = 
        {
            commonEntity = self.mapEntityInfo,
            syncPosEntity = self.mapSyncPosEntityInfo,
            positionEntity = self.mapPositionEntityInfo
        }
        self.bigMap:SetMapEntityInfo(mapEntityInfo)
        self.bigMap:Show()
    else

        local data = table.copy(self.data.bigMapParam)
        data.isBigMap = true
        data.mapEntityInfo = {
                                commonEntity = self.mapEntityInfo,
                                syncPosEntity = self.mapSyncPosEntityInfo,
                                positionEntity = self.mapPositionEntityInfo
                            }
        data.parent = GetMainUI().ui

        self.bigMap = NewFightUiMinimap:new(data)
    end
end

function NewFightUiMinimap:Show()
    UiBaseClass.Show(self)

    if self.bigMap then
        self.bigMap:Show()
    end
end

function NewFightUiMinimap:Hide()
    UiBaseClass.Hide(self)

    if self.bigMap then
        self.bigMap:Hide()
    end
end

function NewFightUiMinimap:SetMapEntityInfo(info)
    if type(info) == 'table' then
        if type(info.commonEntity) == 'table' then
            for gid,ci in pairs(info.commonEntity) do
                self:AddPeople(ObjectManager.GetObjectByGID(gid), ci.eType, ci.syncRot, ci.iconParam)
            end
        end
        
        if type(info.syncPosEntity) == 'table' then
            for gid,ci in pairs(info.syncPosEntity) do
                self:AddSyncPosEntity( gid , ci.bossid, ci.eType)
                self:UpdateBossPos(gid, ci.bossid, ci.lastPos.x, ci.lastPos.y)
            end
        end
        if type(info.positionEntity) == 'table' then
            for k,info in pairs(info.positionEntity) do
                local delayTime = nil
                --app.log("#hyg#=============info.deleteTime " .. tostring(info.deleteTime))
                if info.deleteTime then
                    delayTime = info.deleteTime - app.get_time()
                end
                self:AddPositionEntity(info.pos, info.eType, delayTime, info.gray)
                --app.log("#hyg#=============")
            end
        end
    end
    
    if g_dataCenter.autoPathFinding:IsMoving() then
        self:ShowMovePath()
    end

end

function NewFightUiMinimap:WorldPosToMapPos(wx,wz)

    if self.xPosMinimap == nil then return 0, 0 end

    local newPosX = (wx - self.xPosMinimap) * self.xScaleMinimap;
    local newPosZ= (wz - self.zPosMinimap) * self.zScaleMinimap;

    local tx,ty,tz = util.quaternion_multiply_v3(self.uiMapRotQuat.x, self.uiMapRotQuat.y, self.uiMapRotQuat.z, self.uiMapRotQuat.w, newPosX, newPosZ, 0);

    return tx, ty
end

function NewFightUiMinimap:MapPosToWorldPos(x,y)

    local rx,ry,rz = util.quaternion_multiply_v3(self.uiMapInverseRotQuat.x, self.uiMapInverseRotQuat.y, self.uiMapInverseRotQuat.z, self.uiMapInverseRotQuat.w, 
                                            x, 0, y);

    local worldX = rx / self.xScaleMinimap + self.xPosMinimap
    local worldZ = rz / self.zScaleMinimap + self.zPosMinimap



    return worldX, ry, worldZ;
end

function NewFightUiMinimap:UpdateEntityPos(entity, info)
    local pos = entity:GetPosition(false);

    local tx,ty = self:WorldPosToMapPos(pos.x, pos.z)
    info.node:set_local_position(tx, ty, 0);
    if info.syncRot then
        local rot = entity:GetRotation()
        info.node:set_local_rotation(0, 0, info.adjustAngle - rot.y)
    end
end

--小地图位置更新
function NewFightUiMinimap:UpdateMinimap()
    if not self:IsShow() then
        return
    end

    for gid,info in pairs(self.mapEntityInfo) do
        local entity = ObjectManager.GetObjectByGID(gid);
        if entity and ( not entity:IsMonster() or (entity:IsMonster() and not entity:IsDead())) then
            self:UpdateEntityPos(entity, info)
        else
            self:DeletePeopleByGid(gid)
        end
    end
    
    if self.mapPositionEntityInfo then
        local now = app.get_time()
        for k,info in pairs(self.mapPositionEntityInfo) do
            local delTime = info.deleteTime
            if delTime and now > delTime then
                self:DelPositionEntity(k)
            end
        end
    end

    --[[
    local rightTopOther = self.control;
    for k, v in pairs(self.minimapPool) do
        local entityObj = ObjectManager.GetObjectByGID(k);
        if entityObj then
            local pos = entityObj:GetPosition(false);
            local newPosX = (pos.x - self.xPosMinimap) * self.xScaleMinimap;
            local newPosY = (pos.z - self.zPosMinimap) * self.zScaleMinimap;
            v:set_local_position(newPosX, newPosY, 0);
        else
            --self:DestroyMinimapObj(k);
        end
    end
    ]]
end
