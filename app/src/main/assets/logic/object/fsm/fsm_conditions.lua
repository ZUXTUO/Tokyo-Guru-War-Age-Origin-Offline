--region NewFile_1.lua
--Author : kevin
--Date   : 2015/7/15
--此文件由[BabeLua]插件自动生成

--TODO: kevin 本模块object均为 SceneEntity

function AI_SubFSMIsEnd(obj, fsm)
    return fsm:SubFSMIsEnd()
end

function AI_Key(obj, param, fsm)
    local keyName = param[1]
    local fun = _G[fsm:GetKeyValue(keyName)]
    if fun ~= nil then
        if #param > 1 then
            table.remove(param, 1)
            return fun(obj, param, fsm)
        else
            return fun(obj, fsm)
        end
    else
        app.log('AI_Key function is nil! info:' .. tostring(obj:GetName()) .. ' ' .. tostring(keyName))
    end
    return false
end

function AI_CloseCondition(obj)
    return false
end

local function __CommonDetectedEnemy(obj)
    
    local taut = obj:GetBuffManager()._tauntTarget
    if taut ~= nil then
        local target = ObjectManager.GetObjectByGID(taut)
        if target ~= nil and not target:IsDead() then
            local posX,posY,posZ = obj:GetPositionXYZ()
            local tarPosX,tarPosY,tarPosZ = target:GetPositionXYZ(); 
            local viewRadius = AIC_GetEntityViewRadius(obj)
            if viewRadius > 0 then
                local actRadius = AIC_GetEntityActRadius(obj)
                actRadius = actRadius*9/10
                if algorthm.GetDistanceSquared(posX, posZ, tarPosX, tarPosZ) < actRadius * actRadius then
                    obj:SetDetectedTarget(target:GetName())
                    return true
                end
            end
        end
    end

    -- check group view
    if obj:IsMonster() and obj:GetCloseGroupDetectFunc() ~= true then
        local groupName = obj:GetGroupName()
        if groupName then
            local group = ObjectManager.GetGroup(groupName)
            if group then
                for entityName,v in pairs(group) do
                    local entity = ObjectManager.GetObjectByName(entityName)
                    if entity then
                        local target = entity:GetAttackTarget()
                        if target and target ~= obj then
                            obj:SetDetectedTarget(target:GetName())
                            return true
                        end
                    end
                end
                
            end
        end
    end

    return false
end

function AI_DetectedEnemy(object)

    local viewRadius = AIC_GetEntityViewRadius(object)

    if viewRadius <= 0 then
        return false
    end

    if OperationTimeLimit.IsFrequently(object, "AI_DetectedEnemy") then
        return false
    end

    if __CommonDetectedEnemy(object) == true then
        return true
    end
    

    if object:GetAttackTarget() ~= nil then
        return true
    end

    if object:HasDetectedEnemy() == true then
        return true
    end
    
    object:DetectANearestEnemy(viewRadius);
    local res = object:HasDetectedEnemy()
    -- if res then
    --     local decttarget = object:GetDetectedTarget()
    --     local MyPos = object:GetPositionV3d()
    --     local tarPos = decttarget:GetPositionV3d()
    --     app.log("AI_DetectedEnemy dst = " .. tostring(MyPos:RSub(tarPos):GetLength()) .. ' view_radius = ' .. tostring(viewRadius) .. ' randisu = ' .. tostring(decttarget:GetRadius()) )
    -- end

    return res
end

function AI_DetectedEnemyInActiveAttack(object)
    if OperationTimeLimit.IsFrequently(object, "AI_DetectedEnemyInActiveAttack") then
        return false
    end

    if __CommonDetectedEnemy(object) == true then
        return true
    end
    
    if object:GetAttackTarget() ~= nil or object:HasDetectedEnemy() then
        return true
    end
    return false
end

local __sort_by_distance_target = nil
local __sort_by_distance = function(a, b)
    local selfX,selfY,selfZ = __sort_by_distance_target:GetPositionXYZ(true);
    local ax, ay, az = a:GetPositionXYZ()
    local disa = algorthm.GetDistanceSquared(ax, az, selfX, selfZ);
    local bx, by, bz = b:GetPositionXYZ();
    local disb = algorthm.GetDistanceSquared(bx, bz, selfX, selfZ);
    return disa < disb
end

function AI_DetectedEnemyJustAccordingToType(obj)

    if OperationTimeLimit.IsFrequently(obj, "AI_DetectedEnemyJustAccordingToType") then
        return false
    end

    if __CommonDetectedEnemy(obj) == true then
        return true
    end

    local type = obj:GetAttackType()
    if type ~= -1 then
        local fdir = obj:GetForWard()
        local viewRadius = tonumber(obj:GetConfig('view_radius')) or 5

        if viewRadius <= 0 then
            return false
        end

        local hfsmData = obj:GetHFSMData()
        local posOutVar = hfsmData.AI_DetectedEnemyJustAccordingToTypeMyPosOut
        local have_target,targets = FightScene.SearchAreaTarget(obj:GetPosition(true,false,posOutVar), viewRadius, fdir, 360, nil)
        if have_target==true then
            __sort_by_distance_target = obj
            table.sort(targets, __sort_by_distance)
            __sort_by_distance_target = nil
            for k,entity in ipairs(targets) do
                if entity and entity:GetType()== type and not entity:IsDead() then
                    obj:SetDetectedTarget(entity:GetName())
                    return true
                end
            end
        end
    end

    return false;
end

function AI_DetectedEnemyFistAttackType(obj)
    if OperationTimeLimit.IsFrequently(obj, "AI_DetectedEnemyFistAttackType") then
        return false;
    end

    if __CommonDetectedEnemy(obj) then
        return true
    end

    local viewRadius = tonumber(obj:GetConfig('view_radius')) or 5
    if viewRadius <= 0 then
        return false
    end
    local viewAllTarget = obj:SearchAllEnemyOnAround(viewRadius)
    if #viewAllTarget > 0 then
        local bestTarget = AIC_GetBestTargetFistAttackAttackType(obj, viewAllTarget)
        if bestTarget ~= nil then
            obj:SetDetectedTarget(bestTarget:GetName())
            --app.log('AI_DetectedEnemyFistAttackType ' .. bestTarget:GetType())

            if obj:GetHFSMKeyValue('when_lock_type_donot_change_target')==1 then
                obj:SetDoNotChangeTargetBeAttack(true)
            end

            return true
        end
    end

    return false
end

function AI_DetectEnemyUseOrderMonsterHeroBase(obj)

    if OperationTimeLimit.IsFrequently(obj, "AI_DetectEnemyUseOrderMonsterHeroBase") then
        return false
    end

    if __CommonDetectedEnemy(obj) == true then
        return true
    end

    local viewRadius = AIC_GetEntityViewRadius(obj)
    local viewAllTarget = obj:SearchAllEnemyOnAround(viewRadius)
    if #viewAllTarget > 0 then
        local selectEntity = nil
        local monsterAndBase = AIC_GetMonsters(viewAllTarget)
        if #monsterAndBase > 0 then
            local monsters = AIC_GetType(monsterAndBase, nil, {ENUM.EMonsterType.Tower})
            if #monsters > 0 then
                selectEntity = AIC_GetHPLowestTarget(monsters)
            else
                selectEntity = monsterAndBase[1]
            end
        else
            selectEntity = AIC_GetHPLowestTarget(viewAllTarget)
        end

        if selectEntity then
            obj:SetDetectedTarget(selectEntity:GetName())
            return true
        end
    end
    return false
end

function AI_DetectEnemyUseOrderHeroMonsterBase(obj)

    if OperationTimeLimit.IsFrequently(obj, "AI_DetectEnemyUseOrderHeroMonsterBase") then
        return false
    end

    if __CommonDetectedEnemy(obj) == true then
        return true
    end

    local viewRadius = AIC_GetEntityViewRadius(obj)
    local viewAllTarget = obj:SearchAllEnemyOnAround(viewRadius)
    if #viewAllTarget > 0 then
        local selectEntity = nil
        local heros = AIC_GetHeros(viewAllTarget)
        if #heros > 0 then
            selectEntity = AIC_GetHPLowestTarget(heros)
        else
            local monsters = AIC_GetType(viewAllTarget, nil, {ENUM.EMonsterType.Tower})
            if #monsters > 0 then
                selectEntity = AIC_GetHPLowestTarget(monsters)
            else
                selectEntity = viewAllTarget[1]
            end
        end

        if selectEntity then
            obj:SetDetectedTarget(selectEntity:GetName())
            return true
        end

    end
    return false
end

function AI_HasTarget(obj)
    if obj:GetAttackTarget() ~= nil then
        return true
    end
    return false
end

function AI_HaveMoreClosedTargetThanCurrentTarget(obj)
    
    if AI_CurrentStateCanInterrupt(obj) ~= true then
        return false
    end
    
    if OperationTimeLimit.IsFrequently(obj, "AI_HaveMoreClosedTargetThanCurrentTarget", 3) then
        return false;
    end

    local target = obj:GetAttackTarget()
    if target ~= nil and AIC_EntityHPIsTooLow(target) then
        return false            
    end

    local viewRadius = AIC_GetEntityViewRadius(obj)
    local viewAllTarget = obj:SearchAllEnemyOnAround(viewRadius)
    local target = obj:GetAttackTarget()
    if target ~= nil then
        local myPosX,myPosY,myPosZ = obj:GetPositionXYZ()
        local targetX,targetY,targetZ = target:GetPositionXYZ()
        local targetDistSQ = algorthm.GetDistanceSquared(myPosX,myPosZ, targetX, targetZ)
        for k,entity in ipairs(viewAllTarget) do
            local entityX,entityY,entityZ = entity:GetPositionXYZ()
            local dstSQ = algorthm.GetDistanceSquared(myPosX,myPosZ, entityX, entityZ)
            if dstSQ < targetDistSQ then
                obj:SetDetectedTarget(entity:GetName())
                return true
            end
        end
        
    end

    return false;
end

function AI_DetectedOtherSideHero(obj)

    if OperationTimeLimit.IsFrequently(obj, "AI_DetectedOtherSideHero") then
        return false
    end

    if __CommonDetectedEnemy(obj) == true then
        return true
    end

    local viewRadius = tonumber(obj:GetConfig('view_radius')) or 5

    if viewRadius <= 0 then
        return false
    end

    local targets = obj:SearchAllEnemyOnAround(viewRadius)
    for k, v in ipairs(targets) do
        if v:IsHero() then
            obj:SetDetectedTarget(v:GetName())
            return true
        end
    end
    return false
end

function AI_DetectedTargetByBeAttackOrder(obj)
    if OperationTimeLimit.IsFrequently(obj, "AI_DetectedTargetByBeAttackOrder") then
        return false;
    end

--    if __CommonDetectedEnemy(obj) then
--        return true
--    end

    local viewRadius = AIC_GetEntityViewRadius(obj)
    if viewRadius <= 0 then
        return false
    end

    local targetIndex = nil
    local targets = obj:SearchAllEnemyOnAround(viewRadius)
    local targetsCount = #targets
    if targetsCount > 0 then
        targetIndex = 1
    end
    local index = 2
    while index <= targetsCount do
        if targets[index]:GetBeAttackOrder() < targets[targetIndex]:GetBeAttackOrder() then
            targetIndex = index
        end
        index = index + 1
    end

    if targetIndex ~= nil then
        --app.log('selected order ' .. tostring(targetsCount) .. ' ' .. tostring(targets[targetIndex]:GetName()) .. ' ' .. tostring(targets[targetIndex]:GetBeAttackOrder()))
        obj:SetDetectedTarget(targets[targetIndex]:GetName())
        obj:SetDoNotChangeTargetBeAttack(true)
        return true
    end

    return false
end

function __ResetTautTarget(obj)
    if obj:GetBuffManager()._tauntTarget then
        local tauntTarget = ObjectManager.GetObjectByGID(obj:GetBuffManager()._tauntTarget)
        if tauntTarget then
            tauntTarget.taunt_list[obj:GetGID()] = nil
        end
    end
    obj:GetBuffManager()._tauntTarget = nil
end

function AI_FindNextTarget(obj, fsm)

    __ResetTautTarget(obj)
    obj:SetAttackTarget(nil)
    obj:ClearDetectedEnemy()

    local oldViewRadius = obj:GetConfig("view_radius")
    if oldViewRadius then
        local newViewRadius = math.max( oldViewRadius, AIStateConstVar.findNextMinDistance )
        obj:SetConfig("view_radius", newViewRadius)
    end
    
    local hfsmData = obj:GetHFSMData()
    hfsmData.ignoreOperatorLimit = true
    local res = AI_Key(obj, {"con_check_enemy_key"}, fsm)
    hfsmData.ignoreOperatorLimit = nil

    if oldViewRadius then
        obj:SetConfig("view_radius", oldViewRadius)
    end

    return res
end

function AI_IsDead(obj)
    return obj:IsDead()
end

--function DetectedNone(object)
    --return not object:HasDetectedEnemy()
--end

function AI_MonsterIsOutofActRange(obj)

    local actRadius = tonumber(obj:GetConfig('act_radius')) or 30
    if actRadius <= 0 then
        return false
    end

    local posX,posY,posZ = obj:GetPositionXYZ()
    local homePos = obj:GetHomePosition()

    local isOutOfAct = algorthm.GetDistanceSquared(posX, posZ, homePos.x, homePos.z) > actRadius * actRadius

--    if isOutOfAct then
--        app.log("AI_MonsterIsOutofActRange AI_MonsterIsOutofActRange")
--    end
    
    return isOutOfAct
end

function AI_ChaseIsTooLong(obj)
    --app.log('AI_ChaseIsTooLong' .. obj:GetLastUseSkillPassTime())
    return obj:GetLastUseSkillPassTime(0) > 8
end

function AI_LostTarget(obj)
    return AI_TargetIsDead(obj) or AI_CurrentTargetOutOfViewRange(obj) or AI_TargetIsHide(obj)
end

function AI_TargetIsDead(obj)
    local tar = obj:GetAttackTarget()
    if tar == nil then
        return true
    end
    return tar:IsDead()
end

function AI_CurrentTargetOutOfViewRange(obj)
--    if obj:GetBuffManager()._tauntTarget ~= nil then
--        return false
--    end
--    local tar = obj:GetAttackTarget()

--    if tar == nil then
--        return true
--    end
--    local pos = obj:GetPosition()
--    local tarPos = tar:GetPosition(); 
--    local viewRadius = tonumber(obj:GetConfig('view_radius')) or 5

--    if viewRadius <= 0 then
--        return false
--    end

--    return algorthm.GetDistanceSquared(pos.x, pos.z, tarPos.x, tarPos.z) > viewRadius * viewRadius;

    return false
end

function _AI_ResetMoveComponeteCheck(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.moveCompleteCheckTime = nil
end

--param = {是否高精度, 是否忽略速度检测}
function AI_MoveComplete(object, param)

    local name = object:GetName()

    --local detectNum = 0.00001
    local detectNum = 0.5
    local detectNumSQ = detectNum * detectNum
    local detectTime = 0.2
    local endDistance = 1

    local useVelCheck = true
    if param ~= nil then
        if param[1] == true then
            detectNum = 0.1
            endDistance = 0.1
        end

        if param[2] == true then
            useVelCheck = false
        end
    end
    
    if object:IsHero() then
        endDistance = 0.1
    end

    local hfsmData = object:GetHFSMData()

    local dstPosX,dstPosY,dstPosZ = object:GetDestination()
    if dstPosX ~= nil then
        local objectX,objectY,objectZ = object:GetPositionXYZ()
        local toDstSQ = algorthm.GetDistanceSquared(dstPosX,dstPosZ, objectX, objectZ)
        local checkToDstSQ = endDistance * endDistance

        if toDstSQ <= checkToDstSQ then

            hfsmData.moveCompleteCheckTime = nil

            return true
        end
    else
        app.log_warning('targetPos == nil ' .. object:GetName() .. ' ' .. object:GetObjHFSMState())
        return true
    end
    
    if useVelCheck then
        local x, y, z = object:GetVelocityXYZ()
        if x * x + y * y + z * z < detectNumSQ then
            
            if hfsmData.moveCompleteCheckTime == nil then
                hfsmData.moveCompleteCheckTime = 0
            else
                local dt = app.get_delta_time()
                if dt > 0.000001 then
                    hfsmData.moveCompleteCheckTime = hfsmData.moveCompleteCheckTime + dt
                else
                    hfsmData.moveCompleteCheckTime = 0
                end
            end

            if hfsmData.moveCompleteCheckTime > detectTime then
                hfsmData.moveCompleteCheckTime = nil
                return true
            end

        else
            hfsmData.moveCompleteCheckTime = nil
        end
    end

    return false
end

function AI_IsTargetInAttackRange(obj)
    local tar = obj:GetAttackTarget()

    if tar == nil then
        return true
    end

    local posX,posY,posZ = obj:GetPositionXYZ()
    local tarPosX,tarPosY,tarPosZ = tar:GetPositionXYZ(); 
--    local attackRange = 3
--    local skill = obj:GetSkill(1)
--    if skill ~= nil then
--        attackRange = skill:GetDistance()
--    end
    local attackRange = AIC_GetAttackRadius(obj)

    --只要攻击距离可以打到模型边沿，就认为可以攻击
    local checkRadius = tar:GetRadius() + attackRange
    return algorthm.GetDistanceSquared(posX, posZ, tarPosX, tarPosZ) < checkRadius * checkRadius;
end

function AI_IsTargetInNearestAttackRange(obj)
    local tar = obj:GetAttackTarget()

    if tar == nil then
        return true
    end

    local posX,posY,posZ = obj:GetPositionXYZ()
    local tarPosX,tarPosY,tarPosZ = tar:GetPositionXYZ(); 
    local attackRange = 3
    local skill = obj:GetSkill(1)
    if skill ~= nil then
        attackRange = skill:GetDistance()
        --app.log("AI_IsTargetInAttackRangeAI_IsTargetInAttackRange" .. attackRange)
    end
    local checkDistance = attackRange*2/3 + tar:GetRadius()
    return algorthm.GetDistanceSquared(posX, posZ, tarPosX, tarPosZ) < checkDistance * checkDistance;
end

function AI_TargetIsHide(obj)
    local tar = obj:GetAttackTarget()

    if tar == nil then
        return false
    end
    return tar:IsHide()
end



function AI_FollowHeroCanEnterFight(obj,hfsm)
    
    if not g_dataCenter.fight_info:IsInFight() then
        --app.log('AI_FollowHeroCanEnterFight not in fight')
        return false
    end

    -- local canEnter = false;
    -- local mySideHeroList = g_dataCenter.fight_info:GetControlHeroList()
    -- for k, heroName in pairs(mySideHeroList) do
    --     local hero = GetObj(heroName)
    --     if hero then
    --         local ht = hero:GetAttackTarget()
    --         if ht then
    --             canEnter = true;
    --             break
    --         end
    --     end
    -- end
    -- if not canEnter then
    --     return false
    -- end

    -- 在check target时，判断是否在主角周围加长了范围
    local inCaptainAround = not AI_FollowHeroOutOfCaptainAround(obj, hfsm, AIStateConstVar.followHeroCheckTargetInCaptainAroundRadiusSQ)
    --app.log('AI_FollowHeroCanEnterFight in fight ' .. tostring(inCaptainAround))
    return inCaptainAround
end

function AI_FollowCaptionUpdatePositionOrDir(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.lastFollowPos == nil or hfsmData.lastFollowDir == nil then
        return true
    end
    --app.log('a4 ')
    local myCaptain = FightManager.GetMyCaptain()
    if myCaptain == nil then
        --app.log('AI_FollowCaptionUpdatePositionOrDir captain is nil')
        return false
    end
    local captainPosX,_,captainPosZ = myCaptain:GetPositionXYZ()
    --app.log('a1 ' .. tostring(algorthm.GetDistanceSquared(captainPos.x, captainPos.z, hfsmData.lastFollowPos.x, hfsmData.lastFollowPos.z)))
    if algorthm.GetDistanceSquared(captainPosX, captainPosZ, hfsmData.lastFollowPos.x, hfsmData.lastFollowPos.z) > AIStateConstVar.followDetectTargetUpdateDistSQ then
        return true
    end
    --app.log('a2 ' .. tostring(captainDir:Dot(hfsmData.lastFollowDir)) .. ' ' .. tostring(AIStateConstVar.followDetectTargetUpdateAngleCos))
    local captainDir = myCaptain:GetFaceDirV3d()
    if captainDir:Dot(hfsmData.lastFollowDir) < AIStateConstVar.followDetectTargetUpdateAngleCos then
        return true
    end
     --app.log('a3 ')
    return false
end

function AI_CaptainIsNotRun(obj)
    local myCaptain = FightManager.GetMyCaptain()
    if myCaptain == nil then
        return true
    end

    if myCaptain:GetState() == ESTATE.Run and obj:CheckStateValid(EHandleState.Move) then
        return false
    end

    return true
end

function AI_FollowHeroOutOfCaptainAround(obj, hfsm, checkDstSQ)
    local myCaptain = FightManager.GetMyCaptain();
    if myCaptain == nil then
        return false
    end
    local captainPosX,captainPosY,captainPosZ = myCaptain:GetPositionXYZ()
    local myPosX, myPosY,myPosZ = obj:GetPositionXYZ()

    if checkDstSQ == nil then
        checkDstSQ = AIStateConstVar.followHeroInCappainAroundRadiusSQ
    end

    return algorthm.GetDistanceSquared(captainPosX, captainPosZ, myPosX, myPosZ) > checkDstSQ
end

function _AI_CheckPosIsClosedToEntity(pos, entityName, cd, ignoreDest)
    if ignoreDest == nil then
        ignoreDest = false
    end
    local entity = ObjectManager.GetObjectByName(entityName)
    if entity == nil then
        return false
    end

    local dst = 0

    if ignoreDest then
        local cposX,cposY,cposZ = entity:GetPositionXYZ()
        dst = algorthm.GetDistanceSquared(cposX, cposZ, pos:GetX(), pos:GetZ())
    else
        local dstPosX,dstPosY,dstPosZ = entity:GetDestination()
        if dstPosX ~= nil then
            dst = algorthm.GetDistanceSquared(dstPosX, dstPosZ, pos:GetX(), pos:GetZ())
        else
            local cposX,cposY,cposZ = entity:GetPositionXYZ()
            dst = algorthm.GetDistanceSquared(cposX, cposZ, pos:GetX(), pos:GetZ())
        end
    end
    --app.log("_AI_CheckPosIsClosedToEntity " .. tostring(math.sqrt(dst)) .. ' ' .. tostring(math.sqrt(cd)))
    if dst < cd * cd then
        return true
    end
    
    return false
end

function AI_HeroStandToOtherHeroIsTooClosed(obj)
    --do return false end
    local name = obj:GetName()
    local hfsmData = obj:GetHFSMData()

    if hfsmData.lastCheckHeroStandToOtherHeroIsTooClosed == nil then
        hfsmData.lastCheckHeroStandToOtherHeroIsTooClosed = 0
    end    

    local now = os.time()
    if now -  hfsmData.lastCheckHeroStandToOtherHeroIsTooClosed < 0.2 then   
        return false
    end
    hfsmData.lastCheckHeroStandToOtherHeroIsTooClosed = now

    local detectDist = 1
    local detectTime = 0.5

    if hfsmData.followHeroLastCalPosFailedTime ~= nil then
        if os.time() - hfsmData.followHeroLastCalPosFailedTime < detectTime then
            return false
        else
            hfsmData.followHeroLastCalPosFailedTime = nil
        end
    end

    local myPos = obj:GetPositionV3d(true, false, hfsmData.HeroStandToOtherHeroIsTooClosedMyPos)
    local myCaptain = FightManager.GetMyCaptain();
    if myCaptain ~= nil then
        local isClosed = _AI_CheckPosIsClosedToEntity(myPos, myCaptain:GetName(), detectDist, true)
        if isClosed then
            return true
        end
    end

    local allHero = AI_GetAllFollowHero()
    for k,v in ipairs(allHero) do
        if v ~= name then
            local isClosed = _AI_CheckPosIsClosedToEntity(myPos, v, detectDist)
            if isClosed then
                return true
            end
        end
    end

    return false
end

function AI_FollowHeroIsOutOfScreenRange(obj)
    local myCaptain = FightManager.GetMyCaptain();
    if myCaptain == nil then
        return false
    end
    local captainPosX,captainPosY,captainPosZ = myCaptain:GetPositionXYZ()
    local myPosX,myPosY,myPosZ = obj:GetPositionXYZ()

    return algorthm.GetDistanceSquared(captainPosX, captainPosZ, myPosX, myPosZ) > AIStateConstVar.followHeroOutOfScreenRangeSQ;
end

-- lowHP > type > dst
function AI_HeroDetectedMonster(obj, param)

    local ignoreTimeFreq = param[1]
    --app.log('AI_HeroDetectedMonster ' .. type(ignoreTimeFreq) .. ' ' .. tostring(ignoreTimeFreq))
    if ignoreTimeFreq ~= true and OperationTimeLimit.IsFrequently(obj, "AI_HeroDetectedMonster") == true then
        return false
    end

    if __CommonDetectedEnemy(obj) == true then
        return true
    end

    if obj:HasDetectedEnemy() == true then
        return true
    end

    local heroViewDst = AIC_GetEntityViewRadius(obj, 7) --tonumber(obj:GetConfig("view_radius")) or 7;

    local viewAllTarget = obj:SearchAllEnemyOnAround(heroViewDst)

    local count = #viewAllTarget
    if count > 0 and g_dataCenter.player:CaptionIsAutoFight() then
        for i = count, 1, -1 do
            if viewAllTarget[i]:IsSceneItem() then
                table.remove(viewAllTarget, i)
            end
        end
    end

    if #viewAllTarget < 1 then 
        --return false
    else
        local selectTarget = AIC_GetBestTargetByLowHPandTypeAndDistance(obj, viewAllTarget)
        if selectTarget ~= nil then
            obj:SetDetectedTarget(selectTarget:GetName())
            return true
        else
            app.log('AI_HeroDetectedMonster get best target error')
            --return false
        end
    end

    local myCaptain = FightManager.GetMyCaptain();
    if myCaptain ~= nil then
        local lastAttackCaptionAttacker = myCaptain:GetLastBeAttackAttacker()
        if myCaptain:GetName() ~= obj:GetName() and lastAttackCaptionAttacker ~= nil then
            local attacker = ObjectManager.GetObjectByName(lastAttackCaptionAttacker)
            if attacker ~= nil and not attacker:IsDead() and myCaptain:GetLastBeAttackTimePassTime() < 0.1 then
                obj:SetDetectedTarget(lastAttackCaptionAttacker)
                return true
            end
        end
    end
    -- check low hp
    return false
end

function AI_captainIsAttacking(obj)
    local myCaptain = FightManager.GetMyCaptain();
    if myCaptain == nil then
        return false
    end
    local ctarget = myCaptain:GetAttackTarget()
    local res = ctarget ~= nil
    if res == true then

        local ctPosX, ctPosY, ctPosZ = ctarget:GetPositionXYZ()
        local capPosX, capPosY, capPosZ = myCaptain:GetPositionXYZ()

        --跟随英雄最多只能达到主角周围这么远的目标,如果再远就会出现来回跑的问题
        local canAttackRange = AIStateConstVar.followHeroOutOfScreenRange + AIC_GetAttackRadius(obj) * 2 / 3 -- + ctarget:GetRadius()
        if algorthm.GetDistanceSquared(ctPosX, ctPosZ, capPosX, capPosZ) > canAttackRange * canAttackRange then
            return false
        end

        obj:SetDetectedTarget(ctarget:GetName())
    end
    return res
end

function AI_TargetHPIsToLow(obj)
    local target = obj:GetAttackTarget()
    return AIC_EntityHPIsTooLow(target)
end

--function AI_FollowHeroCanSearchEnemyAgain(obj)
--    return obj:GetLastSearchEnemyDeltaTime() > 2
--end

function __SortEveryTypeTarget(targets)
    local result = {}
    for k, v in ipairs(targets) do
        if AIC_EntityHPIsTooLow(v) then
            table.insert(result, v)
        end
    end
    return result
end

function AI_FollowHeroHaveAnotherBetterAttackTarget(obj)

    if obj:GetBuffManager()._tauntTarget ~= nil then
        return false
    end

    if OperationTimeLimit.IsFrequently(obj, "AI_FollowHeroHaveAnotherBetterAttackTarget", 2) then
        return false
    end

    local attackRange = 5
    local skill = obj:GetSkill(1)
    if skill ~= nil then
        attackRange = skill:GetDistance()
    end

    local allEnemyInAttackRange = obj:SearchAllEnemyOnAround(attackRange)
    local hpIsTooLow = __SortEveryTypeTarget(allEnemyInAttackRange)
    if table.maxn(hpIsTooLow) > 0 then
        obj:SetDetectedTarget(hpIsTooLow[1]:GetName())
        return true
    end

    local myPosX,myPosY,myPosZ = obj:GetPositionXYZ()
    local myTar = obj:GetAttackTarget()
    local myCaptain = FightManager.GetMyCaptain();
    if myCaptain ~= nil and obj ~= myCaptain then
        local capTar = myCaptain:GetAttackTarget()
        if capTar ~= nil and capTar ~= myTar then
            local ctPosX,ctPosY,ctPosZ = capTar:GetPositionXYZ()
            local checkDistance = attackRange + capTar:GetRadius()
            if algorthm.GetDistanceSquared(myPosX, myPosZ, ctPosX, ctPosZ)< checkDistance * checkDistance then
                obj:SetDetectedTarget(capTar:GetName())
                return true
            end
        end
    end
    return false
end

function AI_CurrentSkillIsEnd(obj)
    --if obj:GetCurrentSkillIsEnd() then
        --app.log("GetCurrentSkillIsEndGetCurrentSkillIsEnd true")
    --else
        --app.log("GetCurrentSkillIsEndGetCurrentSkillIsEnd false")
    --end
    return obj:GetCurrentSkillIsEnd()
end

function AI_LockUseSkillFreq(obj)
    return true
    --return obj:GetLastUseSkillPassTime(999) >= 1
end

function AI_SelectSkillsucceed(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.Fight_State_Follow_Select_Skill_id ~= nil
end


function AI_CancelCurrentSkill(obj)
    local curSkill = obj:GetCurSkill()
    local bCancel = false
    if curSkill ~= nil then
        bCancel = SkillManager.CancelSkill(obj, curSkill, false)
    end
    return bCancel == false
end

function AI_IsReciveEvent(obj, param)
    if param == nil or param[1] == nil then
        return false
    end
    return obj:IsReciveEvent(param[1], param[2])
end

function AI_RepelIsEnd(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.AI_State_BeRepel_useTime >= hfsmData.AI_State_BeRepel_TotalTime then
        return true
    end
    return false
end

function AI_PlayBeAttackAniIsEnd(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.playBeAttackAni_useTime > hfsmData.playBeAttackAni_totalTime
end

function AI_TransformStateIsEnd(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.transform_waitFinishEvent == true then
        return obj:IsReciveEvent("FinishTransform", true)
    else
        return hfsmData.transform_useTime >= hfsmData.transform_totalTime
    end
end

function AI_ThrowStateIsEnd(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.throw_isEnd
end

function AI_IsBeControlOrOutOfControlState(obj)
    return obj:IsBeControlOrOutOfControlState()
end

function AI_InterruptCurrentState(obj)
    if not obj:CanCloseCurrSkill() then
        local skillIndex = obj:GetCurSkillIndex() 
        if skillIndex == 1 or skillIndex == 2 then
            obj:SetOnAniAttackComboSetKeepNormalAttackTrue()
            obj:KeepNormalAttack(false)
        end
        return false
    end

    obj:CancelSkillAllCan()

    return AI_CurrentStateCanInterrupt(obj)
end

function AI_CurrentStateCanInterrupt(obj)
    return obj:IsBeControlOrOutOfControlState()~=true and obj:GetCurrentSkillIsEnd()
end

function AI_RandomStandIsEnd(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.passTime > hfsmData.standTotalTime
end

function AI_HasAValidPath(obj)
    local path = obj:GetPatrolMovePath()
    if type(path) == 'table' and #path > 0 then
        local pos1 = path[1]
        if type(pos1.x) == 'number' and type(pos1.y) == 'number' and type(pos1.z) == 'number' then
            return true
        end
    end 
    return false
end

function AI_AlongPathEnd(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.moveAlongPathIsEnd
end

function AI_IsNotMoveToPathEnd(obj)
    if OperationTimeLimit.IsFrequently(obj, "AI_IsNotMoveToPathEnd") then
        return false
    end
    
    local path = obj:GetPatrolMovePath()
    if type(path) == 'table' and #path > 0 then
        local pos = path[#path]
        local myPosX,myPosY,myPosZ = obj:GetPositionXYZ()
        if algorthm.GetDistanceSquared(pos.x, pos.z, myPosX, myPosZ) > 1 then
            return true
        end
    end
    
    return false
end

function AI_MyHPNotFull(obj)
    if obj:GetHP()/obj:GetMaxHP() < 1 then 
        return true
    end
    return false
end

local DEF_NEEDTOADDHPPROPORTION = 0.5

function AI_HeroNeedAddHP(obj)

    if FightScene.GetHudleSkillEnable(2)== false then
        return false
    end
    --if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if g_dataCenter.fight_info:IsInFight() then
            return false
        end
    --end
    --[[local mySideHeroList = g_dataCenter.fight_info:GetHeroList(obj:GetCampFlag())

    for k,heroName in pairs(mySideHeroList) do
        local hero = ObjectManager.GetObjectByName(heroName)
        if hero:GetAttackTarget() ~= nil then
            --app.log('is fight follow can not add hp')
            return false
        end
    end]]

    return obj:GetHP()/obj:GetMaxHP() < DEF_NEEDTOADDHPPROPORTION
end

function AI_TeamNeedRestoreHP(obj)
    --app.log('AI_TeamNeedRestoreHP')

    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld or FightScene.GetHudleSkillEnable(2)== false  then
        return false
    end

    local mySideHeroList = g_dataCenter.fight_info:GetControlHeroList(obj:GetCampFlag())

    for k,heroName in pairs(mySideHeroList) do
        local hero = ObjectManager.GetObjectByName(heroName)
        if hero ~= nil then
            if not hero:IsDead() and hero:GetHP()/hero:GetMaxHP() < DEF_NEEDTOADDHPPROPORTION then 
                return true
            end
        end
    end
    
    return false
end

function AI_MainHeroAutoFightNeedUseAddHPSkill(obj)
    local methodType = FightScene.GetPlayMethodType()
    if methodType == MsgEnum.eactivity_time.eActivityTime_openWorld
            --or methodType == nil
         then
        
        if AI_CurrentStateCanInterrupt(obj) ~= true then
            return false
        end
        
        if obj:GetHP()/obj:GetMaxHP() < DEF_NEEDTOADDHPPROPORTION and SkillManager.CanUseSkill(obj, obj:GetRecoverSkill()) == eUseSkillRst.OK  then
            return true
        end
    end
    return false
end

function AI_TeamRestoreHPEnd(obj)
    --app.log('AI_TeamRestoreHPEnd')
    local mySideHeroList = g_dataCenter.fight_info:GetControlHeroList(obj:GetCampFlag())

    for k,heroName in pairs(mySideHeroList) do
        local hero = ObjectManager.GetObjectByName(heroName)
        if hero ~= nil then
            if not hero:IsDead() and hero:GetHP()/hero:GetMaxHP() < DEF_NEEDTOADDHPPROPORTION then 
                return false
            end
        end
    end
    
    return true
end

function AI_OtherHeroIsAttacking(obj)
    --app.log('AI_OtherHeroIsAttacking')
    local mySideHeroList = g_dataCenter.fight_info:GetControlHeroList(obj:GetCampFlag())
    --app.log('sdfjasld ' .. table.tostring(mySideHeroList))
    for k,heroName in pairs(mySideHeroList) do
        local hero = ObjectManager.GetObjectByName(heroName)
        if hero ~= nil then
            local heroTarget = hero:GetAttackTarget()
            if heroTarget ~= nil and not heroTarget:IsDead() then

                --app.log('AI_OtherHeroIsAttacking1 ' .. table.tostring(heroTarget:GetName()))

                obj:SetDetectedTarget(heroTarget:GetName())

                return true
            end
        end
    end
    return false
end

function AI_IsMonster(obj)
    return obj:IsMonster()
end

function AI_BeAttacked(obj)
    return obj:GetDetectedTarget() ~= nil
end

function AI_NeedToBack2Home(obj)
    return obj:GetHFSMKeyValue('no_back2home') == nil
end

function AI_OverMaxBeAttackedInterval(obj)
    local maxInterval = obj:GetHFSMKeyValue('be_attack_max_interval')
    if maxInterval ~= nil then
        local maxIntervalNum = tonumber(maxInterval)
        if obj:GetLastBeAttackTimePassTime() > maxIntervalNum then
            --app.log('AI_OverMaxBeAttackedInterval true ' .. maxIntervalNum)
            return true
        end
    end
    return false
end

function AI_EntityInTheAir(obj)

    local x,y,z = obj:GetPositionXYZ()

    local isSuc, sx, sy, sz = util.get_navmesh_sampleposition(x,y,z,10);
    if isSuc then
        if math.abs(y - sy) > 0.1 then
            local hfsmData = obj:GetHFSMData()

            hfsmData.entityInTheGroundPos = Vector3d:new({x = sx, y = sy, z = sz})

            return true
        end
    end
    return false
end

function AI_DropOnGroundComplete(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.EntityDropOnGroundUseTime > hfsmData.EntityDropOnGroundTotalTime
end

function AI_SLGDianZhangFirstAction(obj)
    return math.random() > 0.3
end

function AI_SLGDianZhangIdleIsEnd(obj)
    local hfsmData = obj:GetHFSMData()

    if app.get_time() - hfsmData.BeginTime >= hfsmData.TotalTime then
        return true;
    end

    return false
end

function AI_SLGDianZhangTianChaIsEnd(obj)
    local hfsmData = obj:GetHFSMData()

    if app.get_time() - hfsmData.BeginTime >= hfsmData.TotalTime then
        return true;
    end

    return false
end

function AI_AIHeroExecAddHPAction(obj)

    if AI_CurrentStateCanInterrupt(obj) ~= true then
        return false
    end

--    if obj:GetHP()/obj:GetMaxHP() <= 0.4 then
--        app.log(obj:GetName() .. ' AI_AIHeroExecAddHPAction true1')
--    end

    if obj:GetHP()/obj:GetMaxHP() <= 0.4 
        and SkillManager.CanUseSkill(obj, obj:GetRecoverSkill()) == eUseSkillRst.OK 
            then
        --app.log(obj:GetName() .. ' AI_AIHeroExecAddHPAction true2')
        return true
    end
    return false
end

function AI_OnBaseAroundHasEnemy(obj)
    local baseAroundRadius = 6

    obj:DetectANearestEnemy(baseAroundRadius);
--    if obj:HasDetectedEnemy() == true then
--        app.log('AI_OnBaseAroundHasEnemy true true true ')
--    end
    return obj:HasDetectedEnemy()
end 

function AI_FindAddHPItem(obj)
    --do return false end

    local detectHPRadius = 9

    local items = AIC_GetCurrentSceneAddHPItem()

    if items then
        local myPosX,myPosY,myPosZ = obj:GetPositionXYZ()
        for k,item in pairs(items) do
            --local item = ObjectManager.GetObjectByName(itemName)
            --if item then
                local itemPosX,itemPosY,itemPosZ = item:GetPositionXYZ()
                if algorthm.GetDistanceSquared(myPosX, myPosZ, itemPosX, itemPosZ) <= 
                    detectHPRadius * detectHPRadius then
                    
                    local hfsmData = obj:GetHFSMData()
                    hfsmData.detectAddHPItemName = itemName
                    
                    return true
                end
            --end
        end
    end

    return false
end

function AI_3v3NeedExecEatAddHPItem(obj)
    --do return false end;

    -- if OperationTimeLimit.IsFrequently(obj, "AI_3v3NeedExecEatAddHPItem") then
    --     return false
    -- end
    local isNotPlayer = obj:GetHFSMKeyValue("is_player_operator") == nil
    if isNotPlayer then
        return false
    end

    if AI_CurrentStateCanInterrupt(obj) ~= true then
        return false
    end
    if obj:GetHP()/obj:GetMaxHP() <= 0.2 then
        local fm = FightScene.GetFightManager()
        local bases = fm:GetNpcPos(0, obj:GetCampFlag());
        local baseX,baseZ = bases[1].x, bases[1].y
        local myPosX, myPosY, myPosZ = obj:GetPositionXYZ()

        local items = AIC_GetCurrentSceneAddHPItem()
        if items then
            for k,item in pairs(items) do
                local itemPosX,itemPosY,itemPosZ = item:GetPositionXYZ()
                local dir1X,dir1Z = itemPosX - baseX,itemPosZ - baseZ
                
                local dir2X,dir2Z = itemPosX - myPosX, itemPosZ - myPosZ

                local dot = dir1X * dir2X + dir1Z * dir2Z
                if dot <= 0 then

                    local myPosX, myPosY, myPosZ = obj:GetPositionXYZ()

                    local hfsmData = obj:GetHFSMData()
                    hfsmData.detectAddHPItemName = item:GetName()
                    --app.log("AI_3v3NeedExecEatAddHPItem " .. tostring(hfsmData.detectAddHPItemName))
                    return true
                end
            end
        end
    end

    return false    
end

function AI_EatAddHPItemEnd(obj)
    local hfsmData = obj:GetHFSMData()

    if not hfsmData.checkMoveCompleteParam then
        hfsmData.checkMoveCompleteParam = {true}
    end

    local moveComplete = AI_MoveComplete(obj, hfsmData.checkMoveCompleteParam)
    if moveComplete == true then
        return true
    end

    
    local itemName = hfsmData.detectAddHPItemName or hfsmData.detectBuffItemName
    if GetObj(itemName) == nil then
        app.log('AI_EatAddHPItemEnd =================== true')
        return true
    end

    return false
end

AI_EatBuffItemEnd = AI_EatAddHPItemEnd

function AI_3v3HeroNeedExecEscapeAction(obj)

    if obj:GetHP()/obj:GetMaxHP() > 0.2 then
        return false
    end

    if AI_InterruptCurrentState(obj) ~= true then
        return false
    end

    return true
end

function AI_AIHeroExecEscapeAction(obj)
    if AI_CurrentStateCanInterrupt(obj) ~= true then
        return false
    end

    if obj:GetHP()/obj:GetMaxHP() <= 0.2 then

        local target = obj:GetAttackTarget()
        if target ~= nil and AIC_EntityHPIsTooLow(target) then
            return false            
        end
        return true
    end
    return false
end

function AI_AIHeroEscapeReturnAttack(obj, param)

    local percentage = 0.5
    local isPlayer = obj:GetHFSMKeyValue("is_player_operator") ~= nil
    if isPlayer then
        percentage = 0.99
    end

    if obj:GetHP()/obj:GetMaxHP() >= percentage then
        return true
    end
    return false
end

function AI_OtherSideHasAttackToMyBase(obj)

    do return false end

    local baseObj = g_dataCenter.fight_info:GetBase(obj:GetCampFlag())
    if baseObj then
        local viewAllTarget = obj:SearchAllEnemyOnAround(6)
        if #viewAllTarget > 0 then
            return true;
        end
        
    else
        app.log('AI_OtherSideHasAttackMyBase  can not find my base')
    end

    return false
end

function AI_virtualHeroRandomMove(obj)
    return math.random() >= 0.8
end

function AI_VirtualHeroRandomExit(obj)
    return math.random() >= 0.8
end

function AI_BeTauntCanChangeTarget(obj)
    if obj:GetCurrentSkillIsEnd() == false then
        return false
    end

    if obj:IsReciveEvent("BeTaunt", true) == true then
        local target = obj:GetAttackTarget()
        if target and target:GetGID() ==obj:GetBuffManager()._tauntTarget  then
            --app.log('AI_BeTauntCanChangeTarget same true')
            return false
        else
            return true
        end
        --return true
    end

    return false
end

function AI_IsTaunting(obj)
    return obj:GetBuffManager()._tauntTarget ~= nil
end

function AI_TauntIsEnd(obj)
    return obj:GetBuffManager()._tauntTarget == nil
end

function AI_ChaosIsEnd(obj)
    if obj:GetCurrentSkillIsEnd() and obj:IsReciveEvent("Finishchaos", false) then
        obj:RemoveEvent("Finishchaos")
        return true
    end

    return false
end

function AI_ChaosDetectARandomTarget(obj)
    local viewRadius = AIC_GetEntityViewRadius(obj)

    local except = nil
    local tar = obj:GetAttackTarget()
    if tar then
        except = {tar:GetName()}
    end
    app.log('except =' .. table.tostring(except))
    local targets = obj:SearchAllEnemyOnAround(viewRadius, true, except)

    local targetsCount = #targets
    if targetsCount > 0 then
        
        obj:SetAttackTarget(targets[math.random(1, targetsCount)])
        app.log('AI_ChaosDetectARandomTarget '  .. tostring(obj.attackTargetName) )
        return true
    end

    
    return false
end

function AI_UsedOnOrStageSkill(obj)
    --app.log('AI_UsedOnOrStageSkill index = ' .. tostring(obj.old_skill_index))
    if obj.old_skill_index and obj.old_skill_index > 2 then
        --app.log('AI_UsedOnOrStageSkill true')
        return true
    end
    return false
end

function AI_TargetOutOfAttackRangeAndEnterCheckOtherTargetRange(obj, fsm)

    if obj:IsMonster() ~= true or obj:IsHatredValueLockTarget() then
        return false
    end

    local tar = obj:GetAttackTarget()

    if tar == nil then
        return false
    end
    --app.log('AI_TargetOutOfAttackRangeAndEnterCheckOtherTargetRange')
    local posX,posY,posZ = obj:GetPositionXYZ()
    local tarPosX,tarPosY,tarPosZ = tar:GetPositionXYZ(); 
    local attackRange = AIC_GetAttackRadius(obj)

    local checkRadius = attackRange + AIStateConstVar.enterDetectOtherTargetExtraRadius
    if algorthm.GetDistanceSquared(posX, posZ, tarPosX, tarPosZ) >= checkRadius * checkRadius then
        local oldTarget = obj:GetAttackTarget()
        obj:SetAttackTarget(nil)
        obj:ClearDetectedEnemy()
        local res = AI_DetectedEnemy(obj)
        obj:SetAttackTarget(oldTarget)
        --app.log("AI_TargetOutOfAttackRangeAndEnterCheckOtherTargetRange " .. tostring(res) .. ' ' .. tostring(obj.detectedTargetName))
        
        if res and obj.detectedTargetName ~= tar:GetName() then
            return true
        end
    end


    return false
end

function AI_ClownRandomStandIsEnd(obj)
    local hfsmData = obj:GetHFSMData()
    local res = app.get_time() > hfsmData.clownStandEndTime

    if res then
        hfsmData.clownStandEndTime = nil
    end

    return res
end

function AI_ClownNeedMove(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.clownMoveNextPos ~= nil
end

function AI_ClownRandomMoveIsEnd(obj)
    local res =  AI_MoveComplete(obj, {true, true}) 
    if res then
        local hfsmData = obj:GetHFSMData()
        hfsmData.clownMoveNextPos = nil
    end

    return res
end

function AI_StateTimeIsEnd(obj)
    
    local hfsmData = obj:GetHFSMData()
    
    if hfsmData.stateEndTime then

        if hfsmData.stateEndTime < 0 then
            return false
        elseif app.get_time() >= hfsmData.stateEndTime then
            return true
        end
    end
    
    return false
end

function AI_ControlObjectOpenEnd(obj)
    return obj:IsReciveEvent(AIEvent.EntityOpenEnd, true)
end

function AI_ControlObjectCloseEnd(obj)
    return obj:IsReciveEvent(AIEvent.EntityCloseEnd, true)
end

function AI_UseClickSwitchUI(obj)
    return obj:IsReciveEvent(AIEvent.UserHasOperatedUI, true)
end

function AI_ReciveSwitchOpen(obj)

    local hfsmData = obj:GetHFSMData()
    if not hfsmData.isSwitchControl then
        return false
    end

    local isRecive = obj:IsReciveEvent(AIEvent.PlayerOpen, false)

    if isRecive then
        local param = obj:GetEventParam(AIEvent.PlayerOpen, true)
        
        hfsmData.switchEntityName = param
    end

    return isRecive
end

function AI_ReciveSwitchClose(obj)

    local hfsmData = obj:GetHFSMData()
    if not hfsmData.isSwitchControl then
        return false
    end
    local isRecive = obj:IsReciveEvent(AIEvent.PlyaerClose, false)

    if isRecive then
        local param = obj:GetEventParam(AIEvent.PlyaerClose, true)
        hfsmData.switchEntityName = param
    end

    return isRecive
end

function AI_AroundNotTarget(obj)

    if OperationTimeLimit.IsFrequently(obj, "AI_AroundNotTarget") then
        return false
    end

    local targets = obj:SearchAllEnemyOnAround(AIStateConstVar.aroundRandius)
    if #targets > 0 then
        return false
    end

    return true
end

function AI_SearchLatestBuffItem(obj)

    --app.log('AI_SearchLatestBuffItem ======================')

    local buffs = AIC_GetAllBuffItems()
    if #buffs > 0 then
        local clostestEntity = AIC_GetClosestTarget(obj, buffs)
        if clostestEntity then
            local hfsmData = obj:GetHFSMData()
            hfsmData.detectBuffItemName = clostestEntity:GetName()
            
            --app.log('AI_SearchLatestBuffItem  ' .. tostring(hfsmData.detectBuffItemName))

            return true
        else
            app.log("Fatal error!")
        end
    end

    return false
end

function AI_MaxHatredValueNotCurrentTarget(obj)

    if OperationTimeLimit.IsFrequently(obj, "AI_MaxHatredValueNotCurrentTarget") then
        return false
    end

    local hatredValueInfo = obj:GetHatredValueInfo()
    if hatredValueInfo == nil then return false end
    --app.log( obj:GetName() .. ' AI_MaxHatredValueNotCurrentTarget ========== ' .. table.tostring(hatredValueInfo))
    local maxValue = 0
    local maxValueEntity = nil
    for entityName, info in pairs(hatredValueInfo) do
        --if info then
            local now = app.get_time()
            local entityObj = GetObj(entityName)
            if entityObj == nil or now - info.lastBeAttackedTime > AIStateConstVar.hatredValueResetTime then
                hatredValueInfo[entityName] = nil
            else
                if info.value > maxValue then
                    maxValue = info.value
                    maxValueEntity = entityObj
                end
            end
        --end
    end

    if maxValueEntity and maxValueEntity ~= obj:GetAttackTarget() then
        local hfsmData = obj:GetHFSMData()
        hfsmData.maxHatredValueEntityName = maxValueEntity:GetName()
        return true
    end

    return false
end

function AI_IsChangeCanBeAttack(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.changeCanBeAttack == true
end

function AI_TownerFindATarget(obj)

    if OperationTimeLimit.IsFrequently(obj, "AI_TownerFindATarget") then
        return false
    end
    
    local attackRange = AIC_GetAttackRadius(obj)
    local targets = obj:SearchAllEnemyOnAround(attackRange)
    if #targets == 0 then
        return false
    end

    local monsters = AIC_GetMonsters(targets)
    if #monsters > 0 then
        targets = monsters
    end
    
    local selectEntity = AIC_GetHPLowestTarget(targets)
    
    if selectEntity then
        --app.log("AI_TownerFindATarget " .. tostring(selectEntity:GetName()))
        obj:SetDetectedTarget(selectEntity:GetName())
        return true
    end
    
    return false
end

function AI_TownerLostTarget(obj)
    if AIC_LostTargetCommonCheck(obj) then
        return true
    end

    local tar = obj:GetAttackTarget()

    if tar == nil then
        return true
    end

    local attackRange = AIC_GetAttackRadius(obj)

    local posX, posY, posZ = obj:GetPositionXYZ()
    local tarPosX, tarPosY, tarPosZ = tar:GetPositionXYZ()
    return algorthm.GetDistanceSquared(posX, posZ, tarPosX, tarPosZ) > attackRange * attackRange
end

function AI_TownerIsAttackMonsterAndHasEnemyHeroAttackMyHero(obj)

    local tar = obj:GetAttackTarget()

    if tar == nil then
        return false
    end

    if tar:IsHero() then
        return false
    end

    local myPosX, myPosY, myPosZ = obj:GetPositionXYZ()

    local attackRange = AIC_GetAttackRadius(obj)
    local attackRangeSQ = attackRange * attackRange

    local myHeroList = g_dataCenter.fight_info:GetHeroList(obj:GetCampFlag())

    local hero = nil
    local heroHfsmData = nil
    local nowTime = system.time()
    for k,name in pairs(myHeroList) do
        hero = GetObj(name)
        if hero then
            heroHfsmData = hero:GetHFSMData()
            if heroHfsmData.lastHeroAttackMeTime and nowTime - heroHfsmData.lastHeroAttackMeTime < 1 then
                local heroTarget = GetObj(heroHfsmData.lastHeroAttackMeHeroName)
                if heroTarget then
                    local heroTargetPosX, heroTargetPosY, heroTargetPosZ = heroTarget:GetPositionXYZ()
                    if algorthm.GetDistanceSquared(myPosX, myPosZ, heroTargetPosX, heroTargetPosZ) < attackRangeSQ then
                        --app.log("AI_TownerIsAttackMonsterAndHasEnemyHeroAttackMyHero " .. heroTarget:GetName())
                        obj:SetDetectedTarget(heroTarget:GetName())
                        return true
                    end
                end
            end
        end
    end        

    return false
end

function AI_TownerIsAttackMe(obj)

    local hfsmData = obj:GetHFSMData()
    local towner = GetObj(hfsmData.lastTownerAttackEntityName)
    if towner then
        local townerAttackTarget = towner:GetAttackTarget()
        if townerAttackTarget and townerAttackTarget:GetName() == obj:GetName() then
            if AI_InterruptCurrentState(obj) ~= true then
                return false
            end
            return true
        end
    end

    return false
end

function AI_EnemyIsDangous(obj)
    return AI_CheckHasDangous(obj, AIStateConstVar.dangousCheckRangeSQ)
end

function AI_EscapeDangousRangeHasSave(obj)
    return not AI_CheckHasDangous(obj, AIStateConstVar.safeCheckRangeSQ)
end

function AI_CheckHasDangous(obj, checkRangeSQ)

    -- if AI_CurrentStateCanInterrupt(obj) ~= true then
    --     return false
    -- end

    local myFlag = obj:GetCampFlag()
    local enemyFlag = g_dataCenter.fight_info.single_enemy_flag
    if myFlag == enemyFlag then
        enemyFlag = g_dataCenter.fight_info.single_friend_flag
    end

    local myHpPercent = obj:GetHP() / obj:GetMaxHP()

    local dangousCheckFactor = 2.5

    if myHpPercent > 1/ dangousCheckFactor then
        return false
    end

    local myDangousHpPercent = myHpPercent * dangousCheckFactor

    local enemyHeroList = g_dataCenter.fight_info:GetHeroList(enemyFlag)

    local myPosX, myPosY, myPosZ = obj:GetPositionXYZ()

    for k,name in pairs(enemyHeroList) do
        local enemy = GetObj(name)
        if enemy then

            local enemyPosX, enemyPosY, enemyPosZ = enemy:GetPositionXYZ()

            if algorthm.GetDistanceSquared(myPosX, myPosZ, enemyPosX, enemyPosZ) <= checkRangeSQ then

                local enemyHpPercent = enemy:GetHP() / enemy:GetMaxHP()
                if enemyHpPercent > myDangousHpPercent then

                    if AI_InterruptCurrentState(obj) ~= true then
                        return false
                    end

                    return true
                end

            end
        end
    end

    return false
end

function AI_DetectTargetBySkillDistanceAndSkillEnable(obj)

    -- 带来嘲讽可能不能打的问题，因为现在没有追击过程
    -- if __CommonDetectedEnemy(obj) == true then
    --     return true
    -- end

    local canUseSkillIndex = obj:GetCanUseSkillIndexs()

    local maxAttackRange = 0

    
    local detectSkillid = nil
    for k,skillId in ipairs(canUseSkillIndex) do
        local canUse = obj:CanAndNeedUseSkill(skillId)
        if canUse then
            local skill = obj:GetSkill(skillId)
            if skill then
                local skillDist = skill:GetDistance()
                if skillDist > maxAttackRange then
                    maxAttackRange = skillDist
                    detectSkillid = skillId
                end
            end
        end
    end

    if maxAttackRange <= 0 then
        return false
    end

    local targets = obj:SearchAllEnemyOnAround(maxAttackRange)

    if #targets < 1 then
        return false
    end

    local isPlayer = obj:GetHFSMKeyValue("is_player_operator") ~= nil
    if isPlayer then
        local heros = AIC_GetHeros(targets)
        if #heros > 0 then
            targets = heros
        else
            local monsters = AIC_GetType(targets, nil, {ENUM.EMonsterType.Tower})
            if #monsters > 0 then
                targets = monsters
            end
        end
    end

    local selectTarget = AIC_GetClosestTarget(obj, targets)

    obj:SetDetectedTarget(selectTarget:GetName())

    -- app.log("AI_DetectTargetBySkillDistanceAndSkillEnable " .. obj:GetName() .. ' ' .. tostring(detectSkillid) .. ' ' .. tostring(maxAttackRange) .. ' '..  selectTarget:GetName())

    return true
end

function AI_HaveAddHpSkillAndNeedAndCan(obj)
    if not AI_CurrentStateCanInterrupt(obj) then
        return false
    end

    if obj:GetHP() / obj:GetMaxHP() > 0.9 then
        return false
    end

    local id = obj:GetCanUsedAddHpSkillId()
    if not id then
        return false
    end

    local hfsmData = obj:GetHFSMData()
    hfsmData.Fight_State_Follow_Select_Skill_id = id

    return true
end

function AI_NeedToOpenObstacle(obj)

    local item = g_dataCenter.fight_info:GetCurrentTipEntity()

    return item and item:IsShow()
end

function AI_PrepareOPenObstacle(obj)
    return g_dataCenter.fight_info:GetPrepareOpenObstacle()
end

function AI_OpenObstacleEnd(obj)

    local fi = g_dataCenter.fight_info
    local item = fi:GetCurrentTipEntity()

    local res = item and item:IsShow()

    if res then
        if item then
            app.log("AI_OpenObstacleEnd " .. item:GetName())
        else
            app.log("AI_OpenObstacleEnd nil")
        end
        return false
    end

    return fi:CurrentObstacleAllLostEffect()

end

function AI_NeedAttackMove(obj)

    if obj:GetHFSMKeyValue("attack_move") ~= nil then

        local pro = obj:GetHFSMKeyValue("probability") or AIStateConstVar.attackMoveProbability
        return  math.random() <= pro
    end

    

    return false
end

function AI_AttackMoveContinue(obj)
    
    local pro = obj:GetHFSMKeyValue("attack_probability") or AIStateConstVar.attackMoveAttackProbability

    return math.random() > pro
end

function AI_BeAttackedOnce(obj)

    local hfsmData = obj:GetHFSMData()
    if app.get_time() - hfsmData.lastAttackMeTime < 0.5 then
        return true
    end

    return false
end

function AI_BeEscortCharactorFeeldangerous(obj)

    local recive = AI_IsReciveEvent(obj, {AIEvent.Dangerous, true})

    if recive then
        local hfsmData = obj:GetHFSMData()
        hfsmData.FeelDangerousBeginTime = app.get_time()
    end

    return recive

end

function AI_BeEscortFeelDangrousEnd(obj)

    local hfsmData = obj:GetHFSMData()

    if hfsmData.FeelDangerousBeginTime == nil then
        return false
    end

    local wt = obj:GetHFSMKeyValue("dangerous_wait_time")

    if wt then
		
        if app.get_time() - hfsmData.FeelDangerousBeginTime > wt then
            return true
        end
    end

    return false
end

function AI_BeEscortCharactorNeedFightEndWati(obj)
    local waitTime = obj:GetHFSMKeyValue("fight_end_wait_time")
    if type(waitTime) == 'number' then
        local hfsmData = obj:GetHFSMData()
        hfsmData.stateEndTime = app.get_time() + waitTime

        return true
    end

    return false
end

function AI_BeEscortEnterFightState(obj)

    -- local hfsmData = obj:GetHFSMData()
    -- hfsmData.ignoreOperatorLimit = true

    local res = AI_DetectedEnemy(obj)

    --  hfsmData.ignoreOperatorLimit = false

    if res then
        return res
    end

    local cap = FightManager.GetMyCaptain()
    if cap then
        local capTarget = cap:GetAttackTarget()
        res = capTarget ~= nil
        if res then
            obj:SetDetectedTarget(capTarget:GetName())
        end
        return res
    end

    return false
end

function AI_BeEscortLeaveFightState(obj)

    local cap = FightManager.GetMyCaptain()
    if cap then
        local capTarget = cap:GetAttackTarget()
        if not capTarget then
            local hfsmData = obj:GetHFSMData()
            obj:SetDetectedTarget(nil)
            obj:SetAttackTarget(nil)

            local heroViewDst = AIC_GetEntityViewRadius(obj)
            local viewAllTarget = obj:SearchAllEnemyOnAround(heroViewDst)

            local count = #viewAllTarget
            if count > 0 and g_dataCenter.player:CaptionIsAutoFight() then
                for i = count, 1, -1 do
                    local vt = viewAllTarget[i]
                    if vt:IsSpecMonster() then
                        table.remove(viewAllTarget, i)
                    end
                end
            end


            return #viewAllTarget == 0
        end
    end

    return false
end

function AI_escapeCharactorNotNeedEscape(obj)
    local vr = obj:GetConfig("view_radius")
    return vr > 0
end

function AI_CheckWhetherEnterFightAction(obj)
    local canInter = AI_CurrentStateCanInterrupt(obj)
    if not canInter then
        return false
    end

    local is =  AI_IsReciveEvent(obj, {AIEvent.EnterFight, true})
    if is then
        local hfsmData = obj:GetHFSMData()
        hfsmData.fightActionBeginTime = app.get_time()

        return true
    end
    return false
end

function AI_CheckWhetherReturnToEscape(obj)
    local canInter = AI_CurrentStateCanInterrupt(obj)
    if not canInter then
        return false
    end

    local returnEscapeTime = obj:GetHFSMKeyValue("return_escape_time")
    local hfsmData = obj:GetHFSMData()
    --returnEscapeTime = 5
    if returnEscapeTime and app.get_time() - hfsmData.fightActionBeginTime >= returnEscapeTime then
        return true
    end

    local returnEscapeHp = obj:GetHFSMKeyValue("return_escape_hp_percent")
    if returnEscapeHp and obj:GetHP()/obj:GetMaxHP() < returnEscapeHp then
        return true
    end

    local groupName = obj:GetHFSMKeyValue("refresh_monster_group")
    local hasDeadMaxCount = obj:GetHFSMKeyValue("refresh_has_dead_count_escape")
    if groupName and hasDeadMaxCount then
        if FightRecord.GetGroupDeadNum(groupName) >= hasDeadMaxCount then
            return true
        end
    end

    return false
end

function AI_IsPause(obj)
    return obj:IsPause()
end

function AI_FollowHeroNeedRotateToCaptain(obj)
    local captain = FightManager.GetMyCaptain()
    if captain == nil then
        return false
    end

    local cdirx, cdiry, cdirz = captain:GetFacieDirXYZ()
    local mdirx, mdiry, mdirz = obj:GetFacieDirXYZ()

    if cdirx * mdirx + cdiry * mdiry + cdirz * mdirz <= AIStateConstVar.followNeedRotateAngle then
        return true
    end


    return false
end

function AI_EnemyEnterWarningRange(obj)

    local warning_radius = obj:GetHFSMKeyValue("warning_radius")

    -- test
    --warning_radius = AIC_GetEntityViewRadius(obj) + 3

    if warning_radius == nil then
        return false
    end

    if OperationTimeLimit.IsFrequently(obj, "AI_EnemyEnterWarningRange") then
        return false
    end
    local hfsmData = obj:GetHFSMData()
    if hfsmData.lastPlayWarningActionTime then
        local warningStandTime = tonumber(obj:GetHFSMKeyValue("warning_stand_time")) or 3000
        local warningSpeedTime = tonumber(obj:GetHFSMKeyValue("warning_speed_time")) or 0
        warningStandTime = warningStandTime/1000
        warningSpeedTime = warningSpeedTime/1000
        if app.get_time() - hfsmData.lastPlayWarningActionTime < warningStandTime + warningSpeedTime + 2 then
            return false
        end
    end

    local viewRadius = AIC_GetEntityViewRadius(obj)
    local viewRadiusSQ = viewRadius * viewRadius

    local entitys = obj:SearchAllEnemyOnAround(warning_radius)

    if #entitys > 0 then
        local mx, my, mz = obj:GetPositionXYZ()
        for k,entity in ipairs(entitys) do
            local ex, ey, ez = entity:GetPositionXYZ()
            if algorthm.GetDistanceSquared(mx, mz, ex, ez) > viewRadiusSQ then
                hfsmData.lastPlayWarningActionTime = app.get_time()
                return true
            end
        end
    end

    return false
end

function AI_PlayWarningActionStandEnd(obj)
    local hfsmData = obj:GetHFSMData()
    return hfsmData.playWarningUseTime >=  hfsmData.playWarningActionTime
end

function AI_PatrolNeedStandTime(obj)
    if obj:IsReciveEvent(AIEvent.StandTime, false) then
        local hfsmData = obj:GetHFSMData()
        local st = tonumber(obj:GetEventParam(AIEvent.StandTime, true))
        hfsmData.StandEndTime = app.get_time() + st
        return true
    end
    return false
end

function AI_PatrolStandTimeEnd(obj)
    local hfsmData = obj:GetHFSMData()

    return app.get_time() >= hfsmData.StandEndTime
end