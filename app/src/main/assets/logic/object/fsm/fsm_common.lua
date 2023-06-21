

local DEF_LowHPProportion = 0.1
function AIC_GetLowHPTargets(targets)
    local ret = {}
    for k,entity in ipairs(targets) do
        if entity:GetHP()/entity:GetMaxHP() < 0.1 then  
            table.insert(ret, entity)
        end
    end
    return ret
end

function AIC_GetType(targets, types, exceptTypes)
    local ret = {}
    if types then
        for k,entity in ipairs(targets) do
            if table.index_of(types, entity:GetConfig('type')) > 0 then  
                table.insert(ret, entity)
            end
        end
    else
        for k,entity in ipairs(targets) do
            if table.index_of(exceptTypes, entity:GetConfig('type')) < 1 then  
                table.insert(ret, entity)
            end
        end
    end

    return ret
end

function AIC_GetHeros(targets)
    local ret = {}
    for k,v in ipairs(targets) do
        if AIC_EntityIsHero(v) then
            table.insert( ret, v )
        end
    end
    return ret
end

function AIC_GetMonsters(targets)
    local ret = {}
    for k,v in ipairs(targets) do
        if v:IsMonster() then
            table.insert( ret, v )
        end
    end
    return ret
end

function AIC_GetHPLowestTarget(targets)
    local minhp = 100000000
    local minhpEntity = nil
    for k, entity in ipairs(targets) do 
        if entity:GetHP() < minhp then
            minhpEntity = entity
        end
    end
    
    return minhpEntity
end

function AIC_GetClosestTarget(obj, targets)
    local closestDstSQ = 100000000
    local closestEntity = nil
    local myPosX,myPosY,myPosZ = obj:GetPositionXYZ()
    for k, entity in ipairs(targets) do 
        local entityPosX,entityPosY,entityPosZ = entity:GetPositionXYZ()
        local dstSQ = algorthm.GetDistanceSquared(myPosX,myPosZ, entityPosX, entityPosZ)
        if dstSQ < closestDstSQ then
            closestDstSQ = dstSQ
            closestEntity = entity
        end
    end
    
    return closestEntity
end

--根据优先级 血量 > type > distance 选择一个最好的工具对象 
function AIC_GetBestTargetByLowHPandTypeAndDistance(obj, target)
    local lowhps = AIC_GetLowHPTargets(target)
    if #lowhps > 0 then
        target = lowhps
    end

    local boss = AIC_GetType(target, {ENUM.EMonsterType.Boss})
    if #boss>0 then 
        target = boss
    end

    local super = AIC_GetType(target, {ENUM.EMonsterType.CloseSuper, ENUM.EMonsterType.FarSuper})
    if #super > 0 then 
        target = super
    end

    return AIC_GetClosestTarget(obj, target)
end

function AIC_GetIsAttackTypeTargets(obj, targets)
    local ret = {}
    local attackType = obj:GetAttackType()
    for k,entity in ipairs(targets) do
        if attackType == entity:GetType() then
            table.insert(ret, entity)            
        end
    end

    return ret
end

--  攻击类型>distance
function AIC_GetBestTargetFistAttackAttackType(obj, target)
    local typeTargets = AIC_GetIsAttackTypeTargets(obj, target)
    if #typeTargets > 0 then
        --app.log('AIC_GetBestTargetFistAttackAttackType')
        target = typeTargets
    else
       -- app.log('AIC_GetBestTargetFistAttackAttackType false ' .. tostring(obj:GetAttackType()))
    end

    return AIC_GetClosestTarget(obj, target)
end

function AIC_GetEntityViewRadius(obj, defValue)
    defValue = defValue or 5
    return tonumber(obj:GetConfig('view_radius')) or defValue
end

function AIC_GetEntityActRadius(obj, defValue)
    defValue = defValue or 30
    return tonumber(obj:GetConfig('act_radius')) or defValue
end

function AIC_AIC_GenerateRandomEscapePosition(obj,lenStar,lenEnd,maxRandomAngle)

    maxRandomAngle = 0

    -- local isverbos = false
    -- if obj:IsMyControl() then
    --     isverbos = true
    -- end

    local hfsmData = obj:GetHFSMData()
    local needResetMoveDir = false
    if not hfsmData.lastLeaveEscapeTime or app.get_time() - hfsmData.lastLeaveEscapeTime > 1 then
        local angleDir = 1
        if math.random() <= 0.5 then
            angleDir = -1
        end
        hfsmData.lastLeaveEscapeSpinDir = angleDir
        needResetMoveDir = true
    end
    local spinDir = hfsmData.lastLeaveEscapeSpinDir

    local dir = nil
    local target = GetObj(hfsmData.lastAttackMeObjectName)
    local myPos = obj:GetPositionV3d()
    if target then

        local toTargetDir = target:GetPositionV3d():RSub(myPos)

        local dir = target:GetPositionV3d():RSub(myPos):RNormalize()
        if dir then
            --app.log("=========AIC_AIC_GenerateRandomEscapePosition===========")
            dir:RScale(-1)
        end
    end

    if not dir then
        dir = obj:GetFaceDirV3d()
    end

    return AIC_GenerateRandomPosition(myPos, dir, lenStar,lenEnd,maxRandomAngle, spinDir)
end

function AIC_GenerateRandomPosition(initPos, dir, lenStart, lenEnd, maxRandomAngle, spinDir)
    initPos = initPos:Clone()
    local randomineLen = math.random(lenStart, lenEnd)
    local angle = 0
    if maxRandomAngle > 0 then
        angle = math.random(0, maxRandomAngle)
    end
    local angleDir = nil
    if spinDir == nil then
        if math.random() <= 0.5 then
            angleDir = -1
        else
            angleDir = 1
        end
    else
        angleDir = spinDir
    end
    local targetPos = nil
    local addAngle = 0;
    local myPos = initPos
    while true do
        local offset = dir:CScale(randomineLen)
        local qx,qy,qz,qw = util.quaternion_euler(0, (angle + addAngle) * angleDir, 0)
        local nx,ny,nz = util.quaternion_multiply_v3(qx,qy,qz,qw, offset:GetX(), offset:GetY(), offset:GetZ())
        offset:SetX(nx)
        offset:SetY(ny)
        offset:SetZ(nz)

        local caltargetPos = myPos:CAdd(offset)

        local isSuc,sx,sy,sz = util.get_navmesh_sampleposition(caltargetPos:GetX(), 
                                    caltargetPos:GetY(), caltargetPos:GetZ(), 1)
        
        if isSuc then
            caltargetPos:SetX(sx)
            caltargetPos:SetY(sy)
            caltargetPos:SetZ(sz)
            targetPos = caltargetPos
            break;
        else
            addAngle = addAngle + 30;

            if addAngle >= 360 then
                break;
            end
        end
          
    end

    if targetPos == nil then
        dir:RScale(randomineLen)
        targetPos = myPos:RSub(dir);
    end

    return targetPos
end

function AIC_SetEntityMoveToV3d(obj, posV3d)
    obj:SetDestination(posV3d:GetX(), posV3d:GetY(), posV3d:GetZ())
    obj:SetState(ESTATE.Run)
end

function AIC_SetEntityMoveToPos(obj, pos)
    obj:SetDestination(pos.x, pos.y, pos.z)
    obj:SetState(ESTATE.Run)
end

function AIC_SetEntityMoveToPosXYZ(obj, x , y, z)
    obj:SetDestination(x , y, z)
    obj:SetState(ESTATE.Run)
end

function AIC_UseAddHPSkill(obj)
    if AI_MyHPNotFull(obj) then
        local addHpSkill = obj:GetRecoverSkill()
        --app.log('AIC_UseAddHPSkill 111')
        if addHpSkill then
            local canUseResult = SkillManager.CanUseSkill(obj, addHpSkill)
            if canUseResult == eUseSkillRst.OK then
                local ret = SkillManager.UseSkill(obj, addHpSkill)
                --app.log('AIC_UseAddHPSkill 3  ' .. ret)
            else
                --app.log('AIC_UseAddHPSkill ' .. obj:GetName())
            end
        end
    end
end

function AIC_EntityHPIsTooLow(obj)
    return obj:GetHP()/obj:GetMaxHP() < 0.1
end

function AIC_GetAttackRadius(obj)
    local attackRange = 3
    local skill = obj:GetSkill(1)
    if skill ~= nil then
        attackRange = skill:GetDistance()
    end
    return attackRange
end

function AIC_ResetEntityData(obj)
    obj:SetAttackTarget(nil)
    obj:SetDetectedTarget(nil)

    obj:ClearHFSMData()
    
end

function AIC_GetCurrentSceneAddHPItem()
    local items = nil 
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
        items = AIC_GetAllBuffItems()
    else
        local buffLoader = FightScene.GetFightManager():GetBuffLoader()
        if buffLoader then
            local itemsName = buffLoader:GetAllBuffName()
            items = {}
            for k,name in pairs(itemsName) do
                local obj = GetObj(name)
                if obj then
                    table.insert(items, obj)
                end
            end
        end
    end

    return items
end

function AIC_GetAllBuffItems()

    local itemsName = g_dataCenter.fight_info:GetAllItem()
    --app.log('AIC_GetAllBuffItems ======= ' ..  table.tostring(itemsName) )
    local result = {}
    for k, name in pairs(itemsName) do
        local entity = GetObj(name)
        if PublicFunc.IsBuffItem(entity) then
            --app.log('AIC_GetAllBuffItems 2 =============')
            local insertData = entity
            table.insert(result, insertData)
        end
    end

    return result
end

local unControlEvent =
{
    "PlayBeAttackAni",
    "BeRepel",
    "Throw",
    "Transform",
    "FinishTransform",
    "Fear",
    "FinishFear",
    "chaos",
    "Finishchaos",
    "BeTaunt",
}

function AIC_ClearUncontrolEvent(obj)
    for k,v in ipairs(unControlEvent) do
        obj:RemoveEvent(v)
    end
end

function AIC_SetEntityOperatorUiIcon(obj)
    local iconName = obj:GetHFSMKeyValue('operator_ui_icon')
    --iconName = 'zhandou_dahuoji'
    if iconName then
        local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
        if com then
            com:SetButtonIcon(iconName)
        end
    end
end

function AIC_DeleteObj(obj)
    local delayTime = 0
    local configTime = obj:GetHFSMKeyValue('delete_delay_time')
    if configTime then
        delayTime  = tonumber(configTime)
    end

    if delayTime > 0 then
        local fun = Utility.create_callback(
            function(name)
                ObjectManager.DeleteObj(name)
            end, 
            obj:GetName())

        timer.create(fun, delayTime, 1)
    else
        ObjectManager.RemoveObject(obj)
    end
end

function AIC_PlaySceneOpenAnimation(obj)
    local animationObjName = obj:GetHFSMKeyValue('open_animation')
    if type(animationObjName) == "string" then
        local obj = asset_game_object.find(animationObjName)
        obj:animator_play("open")
    end
end

function AIC_FilterNormalBeAttackEvent(obj, eventName, param)
    if eventName == "PlayBeAttackAni" and type(param) == 'table' then
        if param.type == 1 or param.type == 2 or param.type == 3 then
            return false
        end
    end

    return true
end

-- local ManulDoNotReciveEvents =
-- {
--     [AIEvent.PAUSE] = true,
--     [AIEvent.RESUME] = true,
-- }

-- function AIC_CaptainManulDoNotReciveEvent(obj, eventName, param)
--     if ManulDoNotReciveEvents[eventName] and obj:GetName() == g_dataCenter.fight_info:GetCaptainName() and not g_dataCenter.player:CaptionIsAutoFight() then
--         return false
--     end

--     return true
-- end

function AIC_LostTargetCommonCheck(obj)
    local tar = obj:GetAttackTarget()
    if tar == nil then
        return true
    end

    if tar:IsDead() then
        return true
    end

    if tar:IsHide() then
        return true
    end

    return false
end

function AIC_EntityIsHero(obj)
    if obj:IsHero() then
        return true
    end

    if obj:IsMonster() and obj:GetType() == ENUM.EMonsterType.Hero then
        return true
    end

    return false
end

function AI_ShowFxs(ids, show, resetPos)
    if ids then
        for k,id in ipairs(ids) do
            local effect = EffectManager.GetEffect(id)
            if effect then
                if resetPos then
                    effect:set_local_position(0, 0, 0)
                end
                effect:set_active(show)
            end
        end
    end
end