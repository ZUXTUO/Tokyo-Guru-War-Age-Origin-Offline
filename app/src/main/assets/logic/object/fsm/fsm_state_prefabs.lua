-- region NewFile_1.lua
-- Author : kevin
-- Date   : 2015/7/15
-- 此文件由[BabeLua]插件自动生成 


local __testMovepath = 
{
    {x = 3.0003669261932, y = 0.40076300501823, z = -19.958988189697},
    {x = 7.456594, y = 0.2674684, z = -6.397635},
    {x = 2.4547166824341, y = 0.26746839284897, z = 3.5041642189026},
    {x = 4.09913, y = 0.2674684, z = 17.58872},
    {x = 1.9339866638184, y = 0.26746839284897, z = 28.878559112549}
}


AI_State_MonsterInit = AI_State_MonsterInit or {}
function AI_State_MonsterInit.OnEnter(obj)
    local home = obj:GetHomePosition()
    if home == nil then
        obj:SetHomePosition(obj:GetPosition())
    end

    local isPursueAttack = obj:GetHFSMKeyValue("is_pursue_attack")
    if 
    --obj:IsMonster() or
    isPursueAttack then
        obj:AddAttackedCallbackFunc(AI_IsPursueAttackTipCaptain)
        local hfsmData = obj:GetHFSMData()
        hfsmData.lastTipCaptainTime = 0
        hfsmData.tipCaptainInterval = obj:GetHFSMKeyValue("tip_interval") or 3
        if gs_misc.pursue_attack_tip_captain_str then
            hfsmData.tipString = gs_misc.pursue_attack_tip_captain_str
        else
            hfsmData.tipString = "赶快逃跑"
        end
    end

    --obj:SetPatrolMovePath(__testMovepath)

    -- if obj:GetHFSMKeyValue("warning_speak") ~= nil then
    --     obj:InitSpeakBubbleUI()
    -- end
end

function AI_IsPursueAttackTipCaptain(obj, beAttacker)
    if beAttacker:GetName() ~= g_dataCenter.fight_info:GetCaptainName() then
        return
    end
    local hfsmData = obj:GetHFSMData()
    local now = app.get_time()
    if now - hfsmData.lastTipCaptainTime < hfsmData.tipCaptainInterval then return end

    hfsmData.lastTipCaptainTime = now
    FloatTip.Float(hfsmData.tipString)
end

function AI_MonsterBeAttackedCallBack(obj, attacker)
    if obj:GetBuffManager()._tauntTarget ~= nil then
        return ;
    end
    if not obj or not attacker or attacker:GetName() == obj:GetName() then
        return;
    end
    obj:RrecordLastBeAttackTime(attacker)
    local target = obj:GetAttackTarget()

    local posX,posY,posZ = obj:GetPositionXYZ()
    local attPosX,attPosY,attPosZ = attacker:GetPositionXYZ()

    local hfsmData = obj:GetHFSMData()
    if hfsmData then
        local attackerName = attacker:GetName()
        hfsmData.lastAttackMeObjectName = attackerName
        local time = app.get_time()
        hfsmData.lastAttackMeTime = time
        if AIC_EntityIsHero(attacker) then
            hfsmData.lastHeroAttackMeHeroName = attackerName
            hfsmData.lastHeroAttackMeTime = time
        end
    end

    if target == nil then
        local actRadius = tonumber(obj:GetConfig('act_radius')) or 30
        local viewRadius = tonumber(obj:GetConfig('view_radius')) or 0
        if viewRadius > 0 and actRadius > 0 and attacker:GetCanSearch() and algorthm.GetDistanceSquared(posX, posZ, attPosX, attPosZ) < actRadius * actRadius then
            obj:SetDetectedTarget(attacker:GetName())
        end
    elseif obj:GetDoNotChangeTargetBeAttack() ~= true and attacker:GetName() ~= obj:GetName() and target ~= attacker then
        if obj:IsMonster() then
            local tarPosX,tarPosY,tarPosZ = target:GetPositionXYZ()
            if algorthm.GetDistanceSquared(posX, posZ, tarPosX, tarPosZ) > algorthm.GetDistanceSquared(posX, posZ, attPosX, attPosZ) then
                obj:SetAttackTarget(attacker)
            end
        end
    end

    local bubble = attacker:GetHFSMKeyValue("group_attack_me_bubble")
    local whoSpeeder = attacker:GetHFSMKeyValue("group_attack_me_speaker")
    if bubble then
        local attackgroupName = attacker:GetGroupName()
        if attackgroupName then

            local speaker = obj
            if whoSpeeder then
                local objs = PublicFunc.GetObjectByInstanceName(whoSpeeder)
                if #objs > 0 then
                    speaker = objs[1]
                end
            end
            local shfsmData = speaker:GetHFSMData()

            local hasSpeed = shfsmData.hasSpeekAttackMeGroupBubble
            if hasSpeed == nil then
                hasSpeed = {}
                shfsmData.hasSpeekAttackMeGroupBubble = hasSpeed
            end
            if hasSpeed[attackgroupName] == nil then
                speaker:PlaySpeakByid(tonumber(bubble))
                hasSpeed[attackgroupName] = attacker:GetName()
            end
        end
    end
end

function AI_RecordLastAttackMeTowner(obj, attacker)
    if not obj or not attacker or attacker:GetName() == obj:GetName() then
        return;
    end

    if attacker:IsMonster() and attacker:GetType() == ENUM.EMonsterType.Tower then
        local hfsmData = obj:GetHFSMData()
        if hfsmData then
            hfsmData.lastTownerAttackEntityName = attacker:GetName()
        end
    end
end

AI_State_Patrol = AI_State_Patrol or { }
function AI_State_Patrol.OnEnter(obj)
    obj:SetState(ESTATE.Stand)

    --obj:ClearDetectedEnemy()

    --obj:SetAttackTarget(nil)
end

--function AI_State_Patrol.OnUpdate(obj, dt)
    ----if obj:HasDetectedEnemy() then
        ----return
    ----end
--
    ----obj:DetectANearestEnemy(5);
--end

AI_State_PatrolState = AI_State_PatrolState or {}
function AI_State_PatrolState.OnEnter(obj)
    obj:ShowViewAngleRangeEffect(true)
end

function AI_State_PatrolState.OnExit(obj)
    obj:ShowViewAngleRangeEffect(false)
end

AI_State_StandTime = AI_State_StandTime or {}
function AI_State_StandTime.OnEnter(obj)
    local time = obj:GetHFSMKeyValue("stand_time") or 2
    local hfsmData = obj:GetHFSMData()

    hfsmData.stateEndTime = app.get_time() + time

    obj:SetState(ESTATE.Stand)
end

AI_State_randomStand = AI_State_randomStand or {}
function AI_State_randomStand.OnEnter(obj)
    
    local hfsmData = obj:GetHFSMData()

    local time = obj:GetHFSMKeyValue("random_move_stand_time")

    hfsmData.passTime = 0

    if time == nil then
        if hfsmData.notFrsetRandomStand == nil then
            hfsmData.standTotalTime = math.random(6)
            hfsmData.notFrsetRandomStand = true
        else
            hfsmData.standTotalTime = 6 + math.random(10)
        end
    else
        hfsmData.standTotalTime = time
    end

    if hfsmData.standTotalTime > 0 then
        obj:SetState(ESTATE.Stand)
    end
end

function AI_State_randomStand.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    hfsmData.passTime = hfsmData.passTime + dt
end

AI_State_Pause = AI_State_Pause or { }
function AI_State_Pause.OnEnter(obj)
    obj:SetState(ESTATE.Stand)

    --非pause状态收到的resume状态清除
    --obj:RemoveEvent(AIEvent.RESUME)
end

AI_State_MonsterFightBehavior = AI_State_MonsterFightBehavior or {}
function AI_State_MonsterFightBehavior.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.monsterFightBehavior_IsEnterFight = true

    NoticeManager.Notice(ENUM.NoticeType.MonsterEnterFight, obj)

    hfsmData.hasNoticeOneMonsterEnterFight= true

    obj:SetCloseGroupDetectFunc(true)
    if obj.max_normal_skill_index > 1 then
        obj:KeepNormalAttack(true)
    end
end

function AI_State_MonsterFightBehavior.OnExit(obj)

    obj:SetCloseGroupDetectFunc(nil)
end

AI_State_ClearUncontrolEvent = AI_State_ClearUncontrolEvent or {}
function AI_State_ClearUncontrolEvent.OnEnter(obj)
    AIC_ClearUncontrolEvent(obj)
end

function AI_State_ClearUncontrolEvent.OnExit(obj)
    if not obj:IsHero() then
        obj:SetState(ESTATE.Stand)    
    end
end

AI_State_MonsterFight = AI_State_MonsterFight or {}
function AI_State_MonsterFight.OnEnter(obj)
    obj:ResetLastUseSkillTime()

    local hfsmData = obj:GetHFSMData()

    -- --首次进入的时候不要清除事件，以便出发击飞击退等效果。  在战斗中再次进入改状态时清除事件，防止连续出发相应效果
    -- if hfsmData.monsterFightBehavior_IsEnterFight == false then
    --     AIC_ClearUncontrolEvent(obj)
    -- else
    -- end

    -- hfsmData.monsterFightBehavior_IsEnterFight = false
    AIC_ClearUncontrolEvent(obj)

    if obj:GetAttackTarget() == nil then
        local dt = obj:GetDetectedTarget()
        obj:SetAttackTarget(dt)
        obj:ClearDetectedEnemy()
        obj:RrecordLastBeAttackTime()
    end
end

function AI_State_MonsterFight.OnExit(obj)

    -- 被击飞等状态处于该层上层，可能不想丢失现有目标
    --obj:SetAttackTarget(nil)
end

AI_State_FightStateAndLeaveClear = AI_State_FightStateAndLeaveClear or {}
function AI_State_FightStateAndLeaveClear.OnEnter(obj)
    AI_State_MonsterFight.OnEnter(obj)
end
function AI_State_FightStateAndLeaveClear.OnExit(obj)
    AI_State_LeaveFightState.OnEnter(obj)    
end

AI_State_Back2Home = AI_State_Back2Home or {}
function AI_State_Back2Home.OnEnter(obj)

    obj:ClearDetectedEnemy()
    local pos = obj:GetHomePosition()
    obj:SetDestination(pos.x, pos.y, pos.z)
    obj:SetState(ESTATE.Run)
    --obj:SetBeginPositionV3d(obj:GetPositionV3d())

    obj:SetAttackTarget(nil)

    -- restore full hp
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        if obj:GetHFSMKeyValue('not_reset_hp') == nil then
            obj:SetHP(obj:GetMaxHP())
        end
    end
end 

function AI_State_Back2Home.OnUpdate(obj, dt)
    --local pos = obj:GetPosition();
    --local dx, dy, dz = obj:GetDestination()
--
    --app.log("AI_State_Back2Home:" .. obj:GetName() .. " " .. algorthm.GetDistance(pos.x, pos.z, dx, dz))
end 

function AI_State_Back2Home.OnExit(obj)
end

Fight_State_MoveWithinAttackRange = Fight_State_MoveWithinAttackRange or {}
function Fight_State_MoveWithinAttackRange.OnEnter(obj)
    local target = obj:GetAttackTarget()

    if target == nil then
        return 
    end
    obj:SetDestination(target:GetPositionXYZ())
    obj:SetState(ESTATE.Run)
end

function Fight_State_MoveWithinAttackRange.OnUpdate(obj, dt)
    local target = obj:GetAttackTarget()

    obj:SetDestination(target:GetPositionXYZ())
    obj:SetState(ESTATE.Run)
end

function Fight_State_MoveWithinAttackRange.OnExit(obj)
   -- app.log(obj:GetName() .. " Fight_State_MoveWithinAttackRange exit")

   _AI_ResetMoveComponeteCheck(obj)

   obj:SetState(ESTATE.Stand)
end

Fight_State_FollowHeroMoveToAttackPosition = Fight_State_FollowHeroMoveToAttackPosition or {}
function Fight_State_FollowHeroMoveToAttackPosition.OnEnter(obj)

    Fight_State_FollowHeroMoveToAttackPosition.CalAttackPos(obj)
end
function Fight_State_FollowHeroMoveToAttackPosition.CalAttackPos(obj)
    local attTar = obj:GetAttackTarget()
    if attTar == nil then
        return
    end
    local name = obj:GetName()
    local hfsmData = obj:GetHFSMData()
    local tarPos = attTar:GetPositionV3d()
    hfsmData.followHeroMoveToAttackPosition_ChaseTargetPos = tarPos
    local attackRange = 3
    local skill = obj:GetSkill(1)
    if skill ~= nil then
        attackRange = skill:GetDistance()
    end
    local offsetLen = attackRange * 2 / 3 + attTar:GetRadius()
    local detectDist = 1.1
    local angleStep = 20
    local angle = 0
    local angleDir = 1
    if math.random() <= 0.5 then
        angleDir = -1
    end

    local myPos = obj:GetPositionV3d()
    local dir = myPos:RSub(tarPos)
    if dir:GetLengthSQ() < 0.00001 then
        dir:SetX(1)
        dir:SetY(0)
        dir:SetZ(0)
    end
    dir:RNormalize()

    local targetPos = nil
    local curPosIsInNavMesh = false

    while true do
        curPosIsInNavMesh = false
        local canUse = true
        local offset = dir:CScale(offsetLen)
        local qx,qy,qz,qw = util.quaternion_euler(0, angle * angleDir, 0)
        local nx,ny,nz = util.quaternion_multiply_v3(qx,qy,qz,qw, offset:GetX(), offset:GetY(), offset:GetZ())
        offset:SetX(nx)
        offset:SetY(ny)
        offset:SetZ(nz)
        targetPos = tarPos:CAdd(offset)

        local isSuc,sx,sy,sz = util.get_navmesh_sampleposition(targetPos:GetX(), targetPos:GetY(), targetPos:GetZ(), 0.5)

        canUse = isSuc

        if canUse then
            curPosIsInNavMesh = true
            targetPos:SetX(sx)
            targetPos:SetY(sy)
            targetPos:SetZ(sz)


            local myCaptain = FightManager.GetMyCaptain();
            if myCaptain ~= nil then
                canUse = not _AI_CheckPosIsClosedToEntity(targetPos, myCaptain:GetName(), detectDist, true)
            end
            if canUse then
                local allHero = AI_GetAllFollowHero()
                for k,v in ipairs(allHero) do
                    if v ~= name then
                        canUse = not _AI_CheckPosIsClosedToEntity(targetPos, v, detectDist)
                        if not canUse then
                            break;
                        end
                    end
                end
            end
        end

        if canUse then
            break
        end

        angle = angle + angleStep

        if angle > 360 - angleStep then
            local hfsmData = obj:GetHFSMData()
            hfsmData.followHeroLastCalPosFailedTime = os.time()

            if curPosIsInNavMesh == false then
                local isSuc,sx,sy,sz = util.get_navmesh_sampleposition(targetPos:GetX(), targetPos:GetY(), targetPos:GetZ(), attackRange)
                if isSuc then
                    targetPos:SetX(sx)
                    targetPos:SetY(sy)
                    targetPos:SetZ(sz)
                else
                    app.log_warning('error error att  position not in nav mesh :' .. obj:GetName())
                end
            end

            break;
        end

    end

    obj:SetDestination(targetPos:GetX(), targetPos:GetY(), targetPos:GetZ())
    obj:SetState(ESTATE.Run)
        
end
function Fight_State_FollowHeroMoveToAttackPosition.OnUpdate(obj, dt)
    local attTar = obj:GetAttackTarget()
    if attTar == nil then
        return
    end
    local hfsmData = obj:GetHFSMData()
    local tarPos = attTar:GetPositionV3d()
    if tarPos:RSub(hfsmData.followHeroMoveToAttackPosition_ChaseTargetPos):GetLengthSQ() > 0.5 then
        Fight_State_FollowHeroMoveToAttackPosition.CalAttackPos(obj)
    end
end
function Fight_State_FollowHeroMoveToAttackPosition.OnExit(obj)
   _AI_ResetMoveComponeteCheck(obj)

   obj:SetState(ESTATE.Stand)
end

Fight_State_Attack = Fight_State_Attack or {}
function Fight_State_Attack.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    local id = hfsmData.Fight_State_Follow_Select_Skill_id
    if id == nil then
        app.log('Fight_State_Attack.OnEnter id is nil')
    end
    --app.log("attack enter")
    obj:SetCurSkillIndex(id);
    obj:SetState(ESTATE.Attack);

    hfsmData.Fight_State_Follow_Select_Skill_id = nil
    hfsmData.oldKeepNormalAttackValue = nil

    local priorityUseSkill = obj:GetHFSMKeyValue("priority_use_skill")
    if priorityUseSkill then
        hfsmData.priorityUseSkill = true
    end
end

function Fight_State_Attack.OnUpdate(obj, dt)
    if obj:GetIsKeepNormalAttack() then
        local hfsmData = obj:GetHFSMData()
        if hfsmData.priorityUseSkill then
            local normalMaxIndex = PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX
            --app.log("#" .. obj:GetName() .. "#is using index = " .. tostring(obj:GetCurSkillIndex()))
            if obj:GetCurSkillIndex() <= normalMaxIndex - 1 then
                local tabSkillIndex = obj:GetCanUseSkillIndexs()
                for k,index in ipairs( tabSkillIndex) do
                    if index > normalMaxIndex then

                        local canUseResult = obj:CanAndNeedUseSkill(index)
                        if canUseResult then
                            --app.log("#" .. obj:GetName() .. "# need inteupt=================")
                            hfsmData.oldKeepNormalAttackValue = true
                            obj:KeepNormalAttack(false)
                            break
                        end
                    end
                end
            end
        end
    end 
end

function Fight_State_Attack.OnExit(obj)
    --app.log("attack exit")
    obj:T_StopCurrentSkill()

    local hfsmData = obj:GetHFSMData()
    if hfsmData.oldKeepNormalAttackValue then
        obj:KeepNormalAttack(true)
        hfsmData.oldKeepNormalAttackValue = nil
    end
end

AI_State_Dead = AI_State_Dead or {}
function AI_State_Dead.OnEnter(obj)


    local hfsmData = obj:GetHFSMData()
    
    if not hfsmData.hasNoticeOneMonsterEnterFight then
        NoticeManager.Notice(ENUM.NoticeType.MonsterEnterFight, obj)
    end

    obj:SetState(ESTATE.Die);

    AIC_ResetEntityData(obj)
end
function AI_State_Dead.OnUpdate(obj, dt)
end

function AI_State_Dead.OnExit(obj)
end

AI_State_Idle = AI_State_Idle or {}
function AI_State_Idle.OnEnter(obj)
    obj:SetState(ESTATE.Stand)
end

AI_State_FollowHeroBeavior = AI_State_FollowHeroBeavior or {followHero = {}}
function AI_State_FollowHeroBeavior.OnEnter(obj)

    local index = table.index_of(AI_State_FollowHeroBeavior.followHero, obj:GetName())

    if index <= 0 then
        --app.log("#hyg# add follow hero " .. obj:GetName())
        table.insert(AI_State_FollowHeroBeavior.followHero, obj:GetName())
    end
end
function AI_State_FollowHeroBeavior.OnExit(obj)
    local index = table.index_of(AI_State_FollowHeroBeavior.followHero, obj:GetName())
    if index > 0 then
        --app.log("#hyg# del follow hero " .. obj:GetName())
        table.remove(AI_State_FollowHeroBeavior.followHero, index)
    end
end

function AI_GetAllFollowHero()
    return AI_State_FollowHeroBeavior.followHero
end

AI_State_FollowRotateToCaptain = AI_State_FollowRotateToCaptain or {}
function AI_State_FollowRotateToCaptain.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    local captain = FightManager.GetMyCaptain()
    if captain == nil then
        hfsmData.stateEndTime = 0
        return
    end

    -- local cx, cy, cz = captain:GetPositionXYZ()
    -- local mx, my, mz = obj:GetPositionXYZ()
    -- local dirx, diry, dirz = cx - mx, cy - my, cz - mz
    -- local isSUc
    -- dirx, diry, dirz, isSuc = algorthm.Normalized(dirx, diry, dirz)
    -- if not isSuc then
    --     return
    -- end
    local dirx, diry, dirz = captain:GetFacieDirXYZ()

    hfsmData.fromqx, hfsmData.fromqy, hfsmData.fromqz, hfsmData.fromqw = obj:GetRotationq()
    hfsmData.toqx, hfsmData.toqy, hfsmData.toqz, hfsmData.toqw = util.quaternion_look_rotation(dirx, diry, dirz);

    hfsmData.useTime = 0
    hfsmData.totalTime = 0.2
    hfsmData.stateEndTime = -1
end

function AI_State_FollowRotateToCaptain.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()

    hfsmData.useTime = hfsmData.useTime + dt
    local t = hfsmData.useTime/hfsmData.totalTime
    if t >= 1 then
        t = 1 
        hfsmData.stateEndTime = 0
    end

    local cx, cy, cz, cw = util.quaternion_lerp(hfsmData.fromqx, hfsmData.fromqy, hfsmData.fromqz, hfsmData.fromqw, hfsmData.toqx, hfsmData.toqy, hfsmData.toqz, hfsmData.toqw, t)
    obj:SetRotationq(cx, cy, cz, cw)
end

AI_State_Follow_Idle = AI_State_Follow_Idle or {}
function AI_State_Follow_Idle.OnEnter(obj)
    obj:SetState(ESTATE.Stand)
end


AI_StateMoveCaptainAroundDelay = AI_StateMoveCaptainAroundDelay or {}
function AI_StateMoveCaptainAroundDelay.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()

    local diff = math.random(0, 8)/10
    hfsmData.stateEndTime = app.get_time() + diff
    --app.log("#ai# AI_StateMoveCaptainAroundDelay " .. tostring(diff))
end

AI_State_Move_Captain_Around = AI_State_Move_Captain_Around or {}
function AI_State_Move_Captain_Around.OnEnter(obj)

    local hfsmData = obj:GetHFSMData()
    hfsmData.lastFollowPos = nil
    hfsmData.lastFollowDir = nil

    AI_State_Move_Captain_Around.UpdateStandPos(obj)

    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
        obj:ClearFightStateTarget(true, false, "回到主角身边")
    end
end

function AI_State_Move_Captain_Around.OnUpdate(obj , dt)
    AI_State_Move_Captain_Around.UpdateStandPos(obj)
end

function AI_State_Move_Captain_Around.UpdateStandPos(obj)

    local hfsmData = obj:GetHFSMData()
    if AI_FollowCaptionUpdatePositionOrDir(obj) then
        
        local myCaptain = FightManager.GetMyCaptain()
        if myCaptain == nil then
            return
        end
        local captainPos = myCaptain:GetPosition()
        local captainDir = myCaptain:GetFaceDirV3d()

        hfsmData.lastFollowPos = captainPos
        hfsmData.lastFollowDir = captainDir
        

        local teamMemberIndex = g_dataCenter.fight_info:GetTeamMemberIndex(myCaptain:GetName())
        local qx,qy,qz,qw;
        local teamIndex = g_dataCenter.fight_info:GetControlIndex(obj:GetName())
        if teamIndex == -1 then
            app.log("hero not in normal team")
            return
        end
        local teamPosIndex = 1
        for k,v in ipairs(teamMemberIndex) do
            if v == teamIndex then
                teamPosIndex = k
            end
        end
        
        if teamPosIndex == 1 then
            qx,qy,qz,qw = AIStateConstVar.followPositionPositiveRotateAngleQuat.x,AIStateConstVar.followPositionPositiveRotateAngleQuat.y,AIStateConstVar.followPositionPositiveRotateAngleQuat.z,AIStateConstVar.followPositionPositiveRotateAngleQuat.w
        elseif teamPosIndex == 2 then
            qx,qy,qz,qw = AIStateConstVar.followPositionNegativeRotateAngleQuat.x,AIStateConstVar.followPositionNegativeRotateAngleQuat.y,AIStateConstVar.followPositionNegativeRotateAngleQuat.z,AIStateConstVar.followPositionNegativeRotateAngleQuat.w
        end

        if qx == nil then
            app.log('team index error ' .. tostring(teamIndex))
            return
        end

        local offsetLength = -AIStateConstVar.followHeroFollowDist
        if AIC_GetAttackRadius(myCaptain) >= 5 then
            offsetLength = AIStateConstVar.followHeroFollowDist + 1
        end

        local offset = captainDir:CScale(offsetLength)
        local nx,ny,nz = util.quaternion_multiply_v3(qx,qy,qz,qw, offset:GetX(), offset:GetY(), offset:GetZ());

        local randomAngle = math.random(360)
        local rax,ray,raz,raw = util.quaternion_euler(0, randomAngle, 0)
        local randomLen = math.random(4, 8)/10
        local rmx,rmy,rmz = 0, 0, 0 --util.quaternion_multiply_v3(rax,ray,raz,raw, 0, 0, randomLen);
        local tx, ty, tz = captainPos.x + nx + rmx , captainPos.y + ny + rmy, captainPos.z + nz + rmz

        -- fix bug DJZJ-2046
        local isSuc, tx, ty, tz = util.get_navmesh_sampleposition(tx, ty, tz, 6, obj:GetNavMeshAreaMask())
        if isSuc then
            AIC_SetEntityMoveToPosXYZ(obj, tx, ty, tz)
        end
    end

    local dstPosX,dstPosY,dstPosZ = obj:GetDestination()
    local objectX,objectY,objectZ = obj:GetPositionXYZ()
    local toDistanceLenSQ = algorthm.GetDistanceSquared(dstPosX,dstPosZ, objectX, objectZ)
    if toDistanceLenSQ > 2 then
        if obj:GetSpeedProp() ~= 8 then
            obj:SetSpeedProp(8)
        end
    elseif toDistanceLenSQ < 0.5 then
        if obj:GetSpeedProp() ~= nil then
            obj:SetSpeedProp(nil)
        end
    end
end

function AI_State_Move_Captain_Around.OnExit(obj)
   --obj:SetDetectedTarget(nil)
    if obj:GetSpeedProp() ~= nil then
        obj:SetSpeedProp(nil)
    end
end

AI_State_Follow_NPC_Init = AI_State_Follow_NPC_Init or {}
function AI_State_Follow_NPC_Init.OnEnter(obj)
    obj:SetConfig("act_radius", 0)
end

AI_State_Follow_NPC_Move_Captain_Around = AI_State_Follow_NPC_Move_Captain_Around or {}
function AI_State_Follow_NPC_Move_Captain_Around.OnEnter(obj)
    AI_State_Follow_NPC_Move_Captain_Around.CheckMove(obj)
end

function AI_State_Follow_NPC_Move_Captain_Around.OnUpdate(obj, dt)
    AI_State_Follow_NPC_Move_Captain_Around.CheckMove(obj)
end

-- function AI_State_Follow_NPC_Move_Captain_Around.OnExit(obj)
-- end

function AI_State_Follow_NPC_Move_Captain_Around.CheckMove(obj)
    
    local cap = FightManager.GetMyCaptain()
    if cap == nil then return end

    local hfsmData = obj:GetHFSMData()

    local pos = hfsmData.captainLastPos
    local cnx, cny, cnz = cap:GetPositionXYZ()
    
    local cx, cy, cz
    if pos == nil then
        pos = {}
        pos.x, pos.y, pos.z = cnx, cny, cnz
        hfsmData.captainLastPos = pos
    end

    cx, cy, cz = pos.x, pos.y, pos.z

    if algorthm.GetDistanceSquared(cx, cz, cnx, cnz) > 0.25 then

        local mx, my, mz = obj:GetPositionXYZ()
        local dx, dy, dz = mx - cnx, my - cny, mz - cnz
        local dnx, dny, dnz, isSuc = algorthm.Normalized(dx, dy, dz)
        if not isSuc then return end

        local dst = AIStateConstVar.followHeroFollowDist
        local dstX, dstY, dstZ = cnx + dnx * dst, cny + dny * dst, cnz + dnz * dst

        AIC_SetEntityMoveToPosXYZ(obj, dstX, dstY, dstZ)
    end
end

AI_State_Fight = AI_State_Fight or {}
function AI_State_Fight.OnEnter(obj)
    local dt = obj:GetDetectedTarget()
    if dt == nil then
        --app.log_warning(obj:GetName() .. ' AI_State_Fight.OnEnter detected target is nil')
    else
        obj:SetAttackTarget(dt)
        obj:SetDetectedTarget(nil)
    end
end

function AI_State_Fight.OnExit(obj)
    obj:SetAttackTarget(nil)
end

AI_State_ChangeToNextTarget = AI_State_ChangeToNextTarget or {}
function AI_State_ChangeToNextTarget.OnEnter(obj)

    --app.log("AI_State_ChangeToNextTarget.OnEnter " .. obj:GetDetectedTarget():GetName())

    obj:SetAttackTarget(obj:GetDetectedTarget())
    obj:ClearDetectedEnemy()
end

Fight_State_Follow_Select_Skill = Fight_State_Follow_Select_Skill or {}
function Fight_State_Follow_Select_Skill.OnEnter(obj)

    obj:SetState(ESTATE.Stand);
    local hfsmData = obj:GetHFSMData()
    if hfsmData.Fight_State_Follow_Select_Skill_id ~= nil then
        if not obj:CanAndNeedUseSkill(hfsmData.Fight_State_Follow_Select_Skill_id) then
            hfsmData.Fight_State_Follow_Select_Skill_id = nil
        end
    end
end

function Fight_State_Follow_Select_Skill.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.Fight_State_Follow_Select_Skill_id == nil then
        local id = obj:GetNextSkillID()
        hfsmData.Fight_State_Follow_Select_Skill_id = id    
    end
end

AI_State_BeRepel = AI_State_BeRepel or {}
function AI_State_BeRepel.OnEnter(obj)

    -- 击退 总： 40帧   位移距离3帧

    local hfsmData = obj:GetHFSMData()
    hfsmData.AI_State_BeRepel_useTime = 0
    hfsmData.AI_State_BeRepel_TotalTime = PublicStruct.MS_Each_Anim_Frame * 40 * 0.001
    hfsmData.AI_State_BeRepel_param = obj:GetEventParam('BeRepel', true)
    local param = hfsmData.AI_State_BeRepel_param

    local param = {
        attackName = param.attackName,
        backMoveLen = param.dis,
        backMoveTime = PublicStruct.MS_Each_Anim_Frame * 3,
        dir = param.dir
    }
    --obj:SetBeRepelParam(param)

    --obj:SetState(ESTATE.BeRepel)
    local aniID = EANI.repel
    local cfg = g_get_animation_config(obj, aniID)
    hfsmData.AI_State_BeRepel_TotalTime = cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame * 0.001
    obj:PlayAnimate(cfg.action_id, cfg)

    if param.backMoveLen ~= nil then
        local myPosX,myPosY,myPosZ = obj:GetPositionXYZ()
        local nx, ny, nz
        if param.dir == nil then
            local attacker = ObjectManager.GetObjectByName(param.attackName)
            if attacker then
                local attPosX,attPosY,attPosZ = attacker:GetPositionXYZ()
                obj:LookAt(attPosX,attPosY,attPosZ)
                nx, ny, nz = algorthm.Normalized(myPosX - attPosX, 0, myPosZ - attPosZ)
            end
        else
            nx = param.dir.x
            ny = param.dir.y
            nz = param.dir.z

            local x = myPosX - nx*5
            local y = myPosY
            local z = myPosZ - nz*5
            obj:LookAt(x,y,z)
        end
        if nx then
            local tx = myPosX + nx * param.backMoveLen
            local ty = myPosY + ny * param.backMoveLen
            local tz = myPosZ + nz * param.backMoveLen
            obj:PosMoveToPos(4, tx, ty, tz, param.backMoveTime, nil, nil, false, nil, nil, false, (obj:IsMyControl() or obj:IsAIAgent()))
        end
    end
    obj:SetBeControlOrOutOfControlState(true)
end

function AI_State_BeRepel.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    hfsmData.AI_State_BeRepel_useTime = hfsmData.AI_State_BeRepel_useTime + dt

    --app.log("AI_State_BeRepel.OnUpdate" .. dt .. ' ' .. AI_State_BeRepel[objName].useTime);
end

function AI_State_BeRepel.OnExit(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.AI_State_BeRepel_param.cbFunction then
        hfsmData.AI_State_BeRepel_param.cbFunction(hfsmData.AI_State_BeRepel_param.cbData)
    end
    if obj:GetState() ~= ESTATE.Stand then
        obj:SetState(ESTATE.Stand)
    else
        obj:PlayAnimate(EANI.stand);
    end
    obj:SetBeControlOrOutOfControlState(false)
end

function AI_GetBeAttackAniType(obj)
    local hfsmData = obj:GetHFSMData()
    return  hfsmData.playBeAttackAni_beAttackType
end

--g_attack_type = 1
AI_State_PlayBeAttackAni = AI_State_PlayBeAttackAni or {}
function AI_State_PlayBeAttackAni.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.playBeAttackAni_useTime = 0
    hfsmData.playBeAttackAni_totalTime = 10 * PublicStruct.MS_Each_Anim_Frame * 0.001
    
    local param = obj:GetEventParam('PlayBeAttackAni', true)
    if (param.type == 5 or param.type == 6) and (obj:IsMyControl() or obj:IsAIAgent()) then
        obj:GetBuffManager():SpecialEffect(ESpecialEffectType.XuanYun, true, true, nil, false)
    end
    if ((param.dis ~= nil and param.dis ~= 0) or (param.type == 5)) and (not obj:IsMyControl()) and (not obj:IsAIAgent()) and not obj:IsHero() then
        obj:SetState(ESTATE.Stand)
    end
    hfsmData.playBeAttackAni_param = param
    hfsmData.playBeAttackAni_beAttackType = param.type

    local moveTime = 1 * PublicStruct.MS_Each_Anim_Frame --类型1 2 3位移1帧的时间

    --{attackName=skillCreator, type=cfg.hited_action_seq, dis=cfg.hited_repel_dis}
    --type 1左手2右手3前方
    local attackDir = nil
    if param.dir then
        attackDir = param.dir;
    else
        local attacker = ObjectManager.GetObjectByName(param.attackName)
        if attacker == nil then
            return true
        end
        local attPos = attacker:GetPositionV3d():SetY(0)
        local myPos = obj:GetPositionV3d():SetY(0)
        attackDir = attPos:RSub(myPos)
        if attackDir:GetLengthSQ() < 0.0000000001 then
            attackDir = attacker:GetFaceDirV3d():RScale(-1):RNormalize()
        else
            attackDir:RNormalize()
        end
    end
    local myFaceDir = obj:GetFaceDirV3d():RNormalize()

    --local dot = myFaceDir:Dot(attackDir)
    local aniID = nil

    --if dot >= math.cos(math.rad(40)) then
        --aniID = EANI.hit
    --else
        --if myFaceDir:RCross(attackDir):GetY() > 0 then
            --aniID = EANI.hit_l
        --else
            --aniID = EANI.hit_r
        --end
    --end
    --param.type = g_attack_type
    local moveType = param.type
    if param.type == 3 then
        aniID = EANI.hit
    elseif param.type == 1 then
        local dot = myFaceDir:Dot(attackDir)
        if dot >= math.cos(math.rad(90)) then
            aniID = EANI.hit_l
            moveType = 1
        else
            aniID = EANI.hit_r
            moveType = 2
        end
    elseif param.type == 2 then
        local dot = myFaceDir:Dot(attackDir)
        if dot >= math.cos(math.rad(90)) then
            aniID = EANI.hit_r
            moveType = 2
        else
            aniID = EANI.hit_l
            moveType = 1
        end
    elseif param.type == 5 then --击飞
        aniID = 0
        --击飞（down） 26帧, 起身（getup） 24帧 ；在击飞阶段配合 位移距离14帧
        local totalFrameNum = 0
        local firstFrameNum = 0
        local cfg = g_get_animation_config(obj, EANI.up)
        totalFrameNum = totalFrameNum + cfg.frame_event[1].f


        cfg = g_get_animation_config(obj, EANI.down)
        totalFrameNum = totalFrameNum + cfg.frame_event[1].f
        firstFrameNum = totalFrameNum

        cfg = g_get_animation_config(obj, EANI.getup)
        totalFrameNum = totalFrameNum + cfg.frame_event[1].f

        hfsmData.playBeAttackAni_totalTime = totalFrameNum * PublicStruct.MS_Each_Anim_Frame * 0.001
        hfsmData.playBeAttackAni_firstAniTime = firstFrameNum * PublicStruct.MS_Each_Anim_Frame * 0.001
        moveTime = hfsmData.playBeAttackAni_firstAniTime*1000

    end
    if aniID ~= nil and aniID ~= 0 then
        local cfg = g_get_animation_config(obj, aniID)
        hfsmData.playBeAttackAni_totalTime = cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame * 0.001
        if not obj:IsHero() then
            obj:PlayAnimate(cfg.action_id, cfg)
            obj:GetAniCtrler().lock = true
        end
    end

    if (param.dis ~= nil and param.dis ~= 0) or param.type == 5 then
        local pos = nil
        if param.dis ~= nil and param.dis ~= 0 then
            pos = obj:GetPositionV3d():RAdd(attackDir:RScale(-1 * param.dis))
        else
            pos = obj:GetPositionV3d();
        end
        obj:PosMoveToPos(moveType, pos:GetX(), pos:GetY(), pos:GetZ(), moveTime, nil, nil, false, nil, param.height, false, (obj:IsMyControl() or obj:IsAIAgent()))
    end
    obj:SetBeControlOrOutOfControlState(true)
end

function AI_State_PlayBeAttackAni.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    hfsmData.playBeAttackAni_useTime = hfsmData.playBeAttackAni_useTime + dt

    if  hfsmData.playBeAttackAni_firstAniTime ~= nil then
        if hfsmData.playBeAttackAni_useTime >= hfsmData.playBeAttackAni_firstAniTime then

            if hfsmData.playBeAttackAni_param.cbFunction then
                hfsmData.playBeAttackAni_param.cbFunction(hfsmData.playBeAttackAni_param.cbData)
            end

            hfsmData.playBeAttackAni_firstAniTime = nil

        end
    end
end

function AI_State_PlayBeAttackAni.OnExit(obj, dt)
    local hfsmData = obj:GetHFSMData()
    if (hfsmData.playBeAttackAni_beAttackType == 5 or hfsmData.playBeAttackAni_beAttackType == 6) and (obj:IsMyControl() or obj:IsAIAgent()) then
        if obj:GetBuffManager() then
            obj:GetBuffManager():SpecialEffect(ESpecialEffectType.XuanYun, false, true)
        end
    end
    if not obj:IsHero() then
        obj:GetAniCtrler().lock = false
        if obj:GetState() ~= ESTATE.Stand then
            obj:SetState(ESTATE.Stand)
        else
            obj:PlayAnimate(EANI.stand);
        end
    end
    obj:SetBeControlOrOutOfControlState(false)
end

AI_State_Transform = AI_State_Transform or {}
function AI_State_Transform.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.transform_useTime = 0
    local param = obj:GetEventParam('Transform', true)

    if param.time == nil then
        hfsmData.transform_waitFinishEvent = true
    else
        hfsmData.transform_totalTime = param.time * 0.001
    end

    obj:SetBeControlOrOutOfControlState(true)
end

function AI_State_Transform.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    hfsmData.transform_useTime = hfsmData.transform_useTime + dt    
end

function AI_State_Transform.OnExit(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.transform_totalTime = nil
    hfsmData.transform_waitFinishEvent = nil
    obj:SetBeControlOrOutOfControlState(false)
end

AI_State_Throw = AI_State_Throw or {}
function AI_State_Throw.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.throw_useTime = 0

    local param = obj:GetEventParam('Throw', true)
    hfsmData.throw_height = param.height
    hfsmData.throw_step = 1
    hfsmData.throw_secondStepCount = 1 --5 --todo test
    hfsmData.throw_isEnd = false
    hfsmData.throw_beginPos = obj:GetPositionV3d()
    local endPos = obj:GetPositionV3d()
    endPos:SetY(endPos:GetY() + hfsmData.throw_height)
    hfsmData.throw_endPos = endPos

    local cfg = g_get_animation_config(obj, EANI.up)
    hfsmData.throw_curStepTime = cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame * 0.001
    obj:PlayAnimate(cfg.action_id, cfg)
    obj:GetAniCtrler().lock = true
    obj:SetNavFlag(false,true)

    obj:SetBeControlOrOutOfControlState(true)
end

function AI_State_Throw.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    hfsmData.throw_useTime = hfsmData.throw_useTime + dt  

    if  hfsmData.throw_step == 1 then

        local beginPos = hfsmData.throw_beginPos
        local endPos = hfsmData.throw_endPos
        local curPos = obj:GetPositionV3d()
        local toY =  algorthm.NumberLerp(beginPos:GetY(), endPos:GetY(), hfsmData.throw_useTime/hfsmData.throw_curStepTime)
        obj:SetPosition(curPos:GetX(),toY,curPos:GetZ(), true, false)

        if hfsmData.throw_useTime >=  hfsmData.throw_curStepTime then
            --app.log("AI_State_Throw.OnUpdate 1 to 2 " .. obj:GetName())
            hfsmData.throw_step = 2
            hfsmData.throw_useTime = 0

            local cfg = g_get_animation_config(obj, EANI.dangling)
            hfsmData.throw_curStepTime = (cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame * 0.001) * hfsmData.throw_secondStepCount
            obj:GetAniCtrler().lock = false
            obj:PlayAnimate(cfg.action_id, cfg)
            obj:GetAniCtrler().lock = true
        end
    elseif hfsmData.throw_step == 2 then
        if obj:IsReciveEvent("Throw", true) then
            hfsmData.throw_secondStepCount = hfsmData.throw_secondStepCount + 1
            hfsmData.throw_continue = true
        end

         if hfsmData.throw_useTime >=  hfsmData.throw_curStepTime and hfsmData.throw_continue == true  then
             hfsmData.throw_continue = false
             hfsmData.throw_useTime = 0
         end

         if hfsmData.throw_useTime >=  hfsmData.throw_curStepTime then
            hfsmData.throw_step = 3
            hfsmData.throw_useTime = 0

            local cfg = g_get_animation_config(obj, EANI.down)
            hfsmData.throw_curStepTime = cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame * 0.001

            --app.log("AI_State_Throw.OnUpdate 2 to 3 " .. obj:GetName() .. ' ' .. tostring(hfsmData.throw_curStepTime))

            obj:GetAniCtrler().lock = false
            obj:PlayAnimate(cfg.action_id, cfg)
            obj:GetAniCtrler().lock = true
         end
    elseif hfsmData.throw_step == 3 then

        if obj:IsReciveEvent("Throw", true) then
            hfsmData.throw_secondStepCount = 1
            hfsmData.throw_step = 2
            hfsmData.throw_useTime = 0

            local cfg = g_get_animation_config(obj, EANI.dangling)
            hfsmData.throw_curStepTime = (cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame * 0.001)
            obj:GetAniCtrler().lock = false
            obj:PlayAnimate(cfg.action_id, cfg)
            obj:GetAniCtrler().lock = true
        end

        local beginPos = hfsmData.throw_beginPos
        local endPos = hfsmData.throw_endPos

        local curPos = obj:GetPositionV3d()
        local t = hfsmData.throw_useTime/hfsmData.throw_curStepTime
        if t > 1 then
            t = 1
        end
        local toY =  algorthm.NumberLerp(endPos:GetY(), beginPos:GetY(), t)
        obj:SetPosition(curPos:GetX(),toY,curPos:GetZ(), true, false)

        if hfsmData.throw_useTime >=  hfsmData.throw_curStepTime then
            --app.log("AI_State_Throw.OnUpdate 3 to 4 " .. obj:GetName())
            hfsmData.throw_step = 4
            hfsmData.throw_useTime = 0

            local cfg = g_get_animation_config(obj, EANI.getup)
            hfsmData.throw_curStepTime = cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame * 0.001
            obj:GetAniCtrler().lock = false
            obj:PlayAnimate(cfg.action_id, cfg)
            obj:GetAniCtrler().lock = true
        end
    elseif hfsmData.throw_step == 4 then

        if hfsmData.throw_useTime >=  hfsmData.throw_curStepTime then
            --app.log("AI_State_Throw.OnUpdate end " .. obj:GetName())
            hfsmData.throw_isEnd = true
        end
    end
end

function AI_State_Throw.OnExit(obj)
    obj:GetAniCtrler().lock = false
    if obj:GetState() ~= ESTATE.Stand then
        obj:SetState(ESTATE.Stand)
    else
        obj:PlayAnimate(EANI.stand);
    end
    obj:SetBeControlOrOutOfControlState(false)
end

AI_State_LeaveFightState = AI_State_LeaveFightState or {}
function AI_State_LeaveFightState.OnEnter(obj)

    obj:CancelSkillAllCan()
    obj:GetBuffManager():CheckRemove(eBuffPropertyType.DeBuff)
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
        obj:ClearFightStateTarget(true, true, "脱离战斗")
        obj:ClearFightStateTarget(false, true, "脱离战斗")
    end
    obj:SetDoNotChangeTargetBeAttack(false)

    obj:SetAttackTarget(nil)
end

AI_Sate_PatrolRandomMove = AI_Sate_PatrolRandomMove or {}
function AI_Sate_PatrolRandomMove.OnEnter(obj)

    local begin = obj:GetHFSMKeyValue("random_move_begin_dst") or 3
    local endDst = obj:GetHFSMKeyValue("random_move_end_dst") or 4
    local randomAngle = obj:GetHFSMKeyValue("random_move_angle") or 360

    local tarPos = AIC_GenerateRandomPosition(obj:GetPositionV3d(), obj:GetFaceDirV3d(), begin, endDst, randomAngle)
    AIC_SetEntityMoveToV3d(obj, tarPos)
end

AI_Sate_PatrolRandomMoveAroundBornPoint = AI_Sate_PatrolRandomMoveAroundBornPoint or {}
function AI_Sate_PatrolRandomMoveAroundBornPoint.OnEnter(obj)

    local begin = obj:GetHFSMKeyValue("random_move_begin_dst") or 3
    local endDst = obj:GetHFSMKeyValue("random_move_end_dst") or 5
    local randomAngle = obj:GetHFSMKeyValue("random_move_angle") or 360

    local hfsmData = obj:GetHFSMData()
    local speed = obj:GetHFSMKeyValue("random_move_speed")
    if speed then
        hfsmData.oldMoveSpeed = obj:SetSpeedProp(speed)
    end
    
    if obj.HomePosition == nil then
        obj:SetHomePosition(obj:GetPosition())
    end
    local homePos = obj:GetHomePositionV3d ()

    local tarPos = AIC_GenerateRandomPosition(homePos, obj:GetFaceDirV3d(), begin, endDst, randomAngle)
    AIC_SetEntityMoveToV3d(obj, tarPos)
end

function AI_Sate_PatrolRandomMoveAroundBornPoint.OnExit(obj)
    local hfsmData = obj:GetHFSMData()

    obj:SetSpeedProp(hfsmData.oldMoveSpeed)
    hfsmData.oldMoveSpeed = nil
end

AI_Sate_PatrolRandomWalkAroundBornPoint = AI_Sate_PatrolRandomWalkAroundBornPoint or {}
function AI_Sate_PatrolRandomWalkAroundBornPoint.OnEnter(obj)

    local begin = obj:GetHFSMKeyValue("random_walk_begin_dst") or 2
    local endDst = obj:GetHFSMKeyValue("random_walk_end_dst") or 4
    local randomAngle = obj:GetHFSMKeyValue("random_walk_angle") or 360

    local hfsmData = obj:GetHFSMData()
    local walkSpeed = obj:GetHFSMKeyValue("random_walk_speed") or 3
    hfsmData.oldMoveSpeed = obj:SetSpeedProp(walkSpeed)
    hfsmData.oldMoveId =  obj:SetMoveAniId( EANI.walk )

    if obj.HomePosition == nil then
        obj:SetHomePosition(obj:GetPosition())
    end
    local homePos = obj:GetHomePositionV3d ()

    local tarPos = AIC_GenerateRandomPosition(homePos, obj:GetFaceDirV3d(), begin, endDst, randomAngle)
    AIC_SetEntityMoveToV3d(obj, tarPos)
end

function AI_Sate_PatrolRandomWalkAroundBornPoint.OnExit(obj)
    local hfsmData = obj:GetHFSMData()

    if hfsmData.oldMoveSpeed then
        obj:SetSpeedProp(hfsmData.oldMoveSpeed)
        hfsmData.oldMoveSpeed = nil
    else
        obj:SetSpeedProp(nil)
    end

    if hfsmData.oldMoveId then
        obj:SetMoveAniId( hfsmData.oldMoveId )
        hfsmData.oldMoveId = nil
    end
end

AI_State_ResetAlongPathMove = AI_State_ResetAlongPathMove or {}
function AI_State_ResetAlongPathMove.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    local allLiveData = obj:GetHfsmEntityAllLiveData()

    hfsmData.patrolAlongPathNextIndex = nil
    hfsmData.moveAlongPathIsEnd = nil
    allLiveData.patrolAlongPathNextIndex = nil
end

AI_Sate_PatrolAlongPathMove = AI_Sate_PatrolAlongPathMove or {}

function AI_Sate_PatrolAlongPathMove.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()

    if hfsmData.moveAlongPathIsEnd then return end

    if hfsmData.isMove then
        if hfsmData.alongPathMoveCompleteParam == nil then
            local ignoreTime = false
            if obj:GetHFSMKeyValue('move_one_by_one') ~= nil then
                ignoreTime = true
            end
            hfsmData.alongPathMoveCompleteParam = {false, ignoreTime}
        end
        
        local isComplete = AI_MoveComplete(obj, hfsmData.alongPathMoveCompleteParam)
        if isComplete then
            hfsmData.isMove = false
            local path = obj:GetPatrolMovePath()
            if path then
                if hfsmData.patrolAlongPathNextIndex >= table.maxn(path) then
                    hfsmData.patrolAlongPathNextIndex = 1
                    if not obj:GetAlongPathLoop() then
                        hfsmData.moveAlongPathIsEnd = true
                    end
                else
                    hfsmData.patrolAlongPathNextIndex = hfsmData.patrolAlongPathNextIndex + 1
                end
            end
        end
    else
        AI_Sate_PatrolAlongPathMove.MoveToNextPos(obj)
    end

    if hfsmData.warningStateSpeed and hfsmData.warningStateSpeedEndTime < app.get_time() then
        hfsmData.warningStateSpeed = nil
        hfsmData.warningStateSpeedEndTime = nil

        local walkSpeed = tonumber(obj:GetHFSMKeyValue("walk_speed")) or hfsmData.oldMoveSpeed
        obj:SetSpeedProp(walkSpeed)
    end
end

function AI_Sate_PatrolAlongPathMove.OnExit(obj)
    
    local hfsmData = obj:GetHFSMData()

    hfsmData.isMove = nil
    hfsmData.hasSetMoveAniAndSpeed = nil
    if hfsmData.oldMoveSpeed then
        obj:SetSpeedProp(hfsmData.oldMoveSpeed)
        hfsmData.oldMoveSpeed = nil
    else
        obj:SetSpeedProp(nil)
    end

    if hfsmData.oldMoveId then
        obj:SetMoveAniId(hfsmData.oldMoveId)
        hfsmData.oldMoveId = nil
    end
end

function AI_Sate_PatrolAlongPathMove.MoveToNextPos(obj)

    local hfsmData = obj:GetHFSMData()
    local path = obj:GetPatrolMovePath()
    if path ~= nil then
       local allLiveData = obj:GetHfsmEntityAllLiveData()
       allLiveData.patrolAlongPathNextIndex = hfsmData.patrolAlongPathNextIndex

        local pos = path[hfsmData.patrolAlongPathNextIndex]
        if pos.x == nil or pos.y == nil  or pos.z == nil then
            app.log(obj:GetName() .. ' ' .. tostring(obj:GetConfigNumber()) .. ' patrol alone path move pos error, index=' 
                .. tostring(hfsmData.patrolAlongPathNextIndex))
        end

        obj:SetDestination(pos.x, pos.y, pos.z)
        obj:SetState(ESTATE.Run)
        hfsmData.isMove = true
        if not hfsmData.hasSetMoveAniAndSpeed then

            local warningSpeed = nil
            if hfsmData.warningStateSpeed then
                if hfsmData.warningStateSpeedEndTime > app.get_time() then
                    warningSpeed = hfsmData.warningStateSpeed
                else
                    hfsmData.warningStateSpeed = nil
                    hfsmData.warningStateSpeedEndTime = nil
                end
            end


            local hfsmData = obj:GetHFSMData()
            local walkSpeed = warningSpeed or obj:GetHFSMKeyValue("walk_speed")
            if walkSpeed then
                hfsmData.oldMoveSpeed = obj:SetSpeedProp(walkSpeed)
            end
            local needWalkAni = obj:GetHFSMKeyValue("need_walk_ani")
            if needWalkAni then
                hfsmData.oldMoveId =  obj:SetMoveAniId( EANI.walk )
            end

            hfsmData.hasSetMoveAniAndSpeed = true
        end

    else
        app.log_warning(obj:GetName() ..  ' ' .. tostring(obj:GetConfigNumber()) .. ' ERROR:AI_Sate_PatrolAlongPathMove path is nil')
    end
end

function AI_Sate_PatrolAlongPathMove.SetNextIndex(obj, index)
    local path = obj:GetPatrolMovePath()
    if index >=1 and index <= #path then
        local hfsmData = obj:GetHFSMData()
        hfsmData.patrolAlongPathNextIndex = index
    end
end

AI_State_ChangeToTauntTarget = AI_State_ChangeToTauntTarget or {}
function AI_State_ChangeToTauntTarget.OnEnter(obj)
    local target = ObjectManager.GetObjectByGID(obj:GetBuffManager()._tauntTarget)
    if target ~= nil then
        obj:SetAttackTarget(target)
    end
end

AI_State_FightExit = AI_State_FightExit or {}
function AI_State_FightExit.OnEnter(obj)
    obj:SetAttackTarget(nil)
    __ResetTautTarget(obj)
end

Fight_State_RandomSideMove = Fight_State_RandomSideMove or {}
function Fight_State_RandomSideMove.OnEnter(obj)
    local faceDir = obj:GetFaceDirV3d()
    local upDir = Vector3d:new({x = 0, y = 1, z = 0})
    local sideMoveDir = faceDir:RCross(upDir)
    local side = 1;
    if math.random() < 0.5 then
        side = -1;
    end
    local sideMovePos = obj:GetPositionV3d():RAdd(sideMoveDir:RScale((2 + math.random() * 2) * side))
    
    obj:SetDestination(sideMovePos:GetX(), sideMovePos:GetY(), sideMovePos:GetZ())
    obj:SetState(ESTATE.Run)
    --app.log('Fight_State_RandomSideMove.OnEnter ' .. obj:GetName())
end

function Fight_State_RandomSideMove.OnExit(obj)
    obj:SetState(ESTATE.Stand)
end

AI_State_CalPatrolBeginPos = AI_State_CalPatrolBeginPos or {}
function AI_State_CalPatrolBeginPos.OnEnter(obj)
    local path = obj:GetPatrolMovePath()
    if type(path) == 'table' and #path > 0 then

        local nexMovePosIndex = nil
        local allLiveData = obj:GetHfsmEntityAllLiveData()

        if obj:GetHFSMKeyValue('move_one_by_one') ~= nil then
             nexMovePosIndex = allLiveData.patrolAlongPathNextIndex or 1

             --app.log("AI_State_CalPatrolBeginPos.OnEnter " .. tostring(nexMovePosIndex))
        else
            local myPos = obj:GetPositionV3d()
            local minIndex = nil
            local minDistSQ = 10000 * 10000
            for k,pos in ipairs(path) do
                local dst = algorthm.GetDistanceSquared(pos.x, pos.z, myPos:GetX(), myPos:GetZ())
                if dst < minDistSQ then
                    minIndex = k
                    minDistSQ = dst
                end
            end

            local lastIndex = allLiveData.patrolAlongPathNextIndex or 1
            if lastIndex > minIndex  then
                --[[
                    切换路径的时候有可能需要从几点1开始，暂时未处理这种情况
                ]]
                minIndex = lastIndex
            end

            nexMovePosIndex = minIndex
            if minIndex < #path then
                local minPos = path[minIndex]
                local nexPos = path[minIndex + 1]
                local minToNextVec = Vector3d:new({x = nexPos.x - minPos.x, y = nexPos.y - minPos.y, z = nexPos.z - minPos.z})
                if minToNextVec:Dot(myPos:RSub(Vector3d:new{x = minPos.x, y = minPos.y, z = minPos.z})) > 0 then    
                    nexMovePosIndex = nexMovePosIndex + 1
                end
            end
        end

        AI_Sate_PatrolAlongPathMove.SetNextIndex(obj, nexMovePosIndex)
    end
end


AI_State_ContinueUseAddHPSkill = AI_State_ContinueUseAddHPSkill or {}
function AI_State_ContinueUseAddHPSkill.OnUpdate(obj, dt)
    AIC_UseAddHPSkill(obj)
end

AI_State_UseAddHPSkillOnce = AI_State_UseAddHPSkillOnce or {}
function AI_State_UseAddHPSkillOnce.OnEnter(obj)
    SkillManager.UseSkill(obj, obj:GetRecoverSkill())
end

AI_State_MainHeroFight = AI_State_MainHeroFight or {}
function AI_State_MainHeroFight.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.handleFsm == nil then
        hfsmData.handleFsm = FSM:new(obj)
        hfsmData.handleFsm:Register(HandleState)

        local isTowner = obj:GetHFSMKeyValue('is_tower') ~= nil
        if isTowner then
            hfsmData.handleFsm:SetState(EHandleState.TowerAttack)
        else
            hfsmData.handleFsm:SetState(EHandleState.Manual)
        end

        obj:SetSkillUseByAIHFSM(false)
    end
    obj:SetHandleFsm(hfsmData.handleFsm)
    PublicFunc.msg_dispatch("SceneEntity_SetAI_AutoPathFinding",114);
end

function AI_State_MainHeroFight.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.handleFsm ~= nil then
        hfsmData.handleFsm:Update(dt)
    else
        app.log('AI_State_MainHeroFight OnUpdate handle fsm == nil')
    end
end

function AI_State_MainHeroFight.OnExit(obj)

    local hfsmData = obj:GetHFSMData()
    if hfsmData.handleFsm ~= nil then
        obj.last_handle_fsm_state = hfsmData.handleFsm:GetState()
        hfsmData.handleFsm:SetState(EHandleState.Manual)
    end
    obj:SetHandleFsm(nil)
end

AI_State_MainHeroEnterTaunt = AI_State_MainHeroEnterTaunt or {}
function AI_State_MainHeroEnterTaunt.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()

    hfsmData.oldKeepNormalAttackValue = obj:GetIsKeepNormalAttack()

    if hfsmData.oldKeepNormalAttackValue == nil then
        hfsmData.oldKeepNormalAttackValue = false
    end

    obj:KeepNormalAttack(true)
end

function AI_State_MainHeroEnterTaunt.OnExit(obj)
    local hfsmData = obj:GetHFSMData()

    obj:KeepNormalAttack(hfsmData.oldKeepNormalAttackValue)
end

AI_Sate_ExitAndSetHomePosition = AI_Sate_ExitAndSetHomePosition or {}
function AI_Sate_ExitAndSetHomePosition.OnEnter(obj)
    obj:RemoveEvent(AIEvent.StandTime)
end

function AI_Sate_ExitAndSetHomePosition.OnExit(obj)
    obj:SetHomePosition(obj:GetPosition())
    
end

AI_Sate_EnterAndSetHomePosition = AI_Sate_EnterAndSetHomePosition or {}
function AI_Sate_EnterAndSetHomePosition.OnEnter(obj)
    obj:SetHomePosition(obj:GetPosition())
end


AI_State_EntityDropOnGround = AI_State_EntityDropOnGround or {}
function AI_State_EntityDropOnGround.OnEnter(obj)
    --app.log('AI_State_EntityDropOnGround OnEnter ' .. obj:GetName())
   local dropSpeed = 8

   local hfsmData = obj:GetHFSMData()
   hfsmData.EntityDropOnGroundUseTime = 0;
   hfsmData.EntityDropOnGroundStartPos = obj:GetPositionV3d()
   hfsmData.EntityDropOnGroundTotalTime = hfsmData.EntityDropOnGroundStartPos:CSub(hfsmData.entityInTheGroundPos):GetLength() / dropSpeed;

   obj:SetNavFlag(false,true)
end

function AI_State_EntityDropOnGround.OnUpdate(obj, dt)
    --app.log('AI_State_EntityDropOnGround.OnUpdate')
    local hfsmData = obj:GetHFSMData()
    hfsmData.EntityDropOnGroundUseTime = hfsmData.EntityDropOnGroundUseTime + dt

    local pos = V3dLerp(hfsmData.EntityDropOnGroundStartPos, hfsmData.entityInTheGroundPos, hfsmData.EntityDropOnGroundUseTime/hfsmData.EntityDropOnGroundTotalTime)
    obj:SetPosition(pos:GetX(), pos:GetY(), pos:GetZ(), true, false)
end

function AI_State_EntityDropOnGround.OnExit(obj)
end

AI_State_SLG_DianZhangIdle = AI_State_SLG_DianZhangIdle or {}
function AI_State_SLG_DianZhangIdle.OnEnter(obj)

    --app.log("AI_State_SLG_DianZhangIdle.OnEnter")

    obj:PlayAnimate(EANI.stand);

    local hfsmData = obj:GetHFSMData()
    hfsmData.TotalTime = math.random(25, 35);
    hfsmData.BeginTime = app.get_time()
end

AI_State_SLG_DianZhangTianCha = AI_State_SLG_DianZhangTianCha or {}
function AI_State_SLG_DianZhangTianCha.OnEnter(obj)
    --app.log("AI_State_SLG_DianZhangTianCha.OnEnter")
    obj:PlayAnimate(EANI.idle);

    local hfsmData = obj:GetHFSMData()
    hfsmData.TotalTime = 134 * PublicStruct.MS_Each_Anim_Frame * 0.001;
    hfsmData.BeginTime = app.get_time()
end

AI_State_AIHeroRandomEscape = AI_State_AIHeroRandomEscape or {}
function AI_State_AIHeroRandomEscape.OnEnter(obj)
    


    local escapePos = AIC_AIC_GenerateRandomEscapePosition(obj,3, 6, 30)

    AIC_SetEntityMoveToV3d(obj, escapePos)
    
end

function AI_State_AIHeroRandomEscape.OnUpdate(obj, dt)
    AIC_UseAddHPSkill(obj)
end

function AI_State_AIHeroRandomEscape.OnExit(obj)
    obj:SetState(ESTATE.Stand)

    local hfsmData = obj:GetHFSMData()
    hfsmData.lastLeaveEscapeTime = app.get_time()
end

AI_State_HeroReturnMyBase = AI_State_HeroReturnMyBase or {}
function AI_State_HeroReturnMyBase.OnEnter(obj)
    local fm = FightScene.GetFightManager()

    if fm == nil then
        app.log('AI_State_HeroReturnMyBase fightManager nil')
    else
        local base = fm:GetNpcPos(0, obj:GetCampFlag());
        local x,z
        if #base > 0 then
            x = base[1].x
            z = base[1].y
        end

        if x == nil or z == nil then
            app.log('AI_State_HeroReturnMyBase ' .. tostring(x) .. ' ' .. tostring(z))
            return
        else
            --app.log('AI_State_HeroReturnMyBase true ' .. tostring(x) .. ' ' .. tostring(z))
        end

        AIC_SetEntityMoveToPos(obj, {x = x, y = 0, z = z})
    end

end

function AI_State_HeroReturnMyBase.OnUpdate(obj, dt)
    AIC_UseAddHPSkill(obj)
end

function AI_State_HeroReturnMyBase.OnExit(obj)
    obj:SetState(ESTATE.Stand)
end

AI_State_EscapWaitHPRestoreFull = AI_State_EscapWaitHPRestoreFull or {}
function AI_State_EscapWaitHPRestoreFull.OnUpdate(obj, dt)
    AIC_UseAddHPSkill(obj)
end

AI_State_MoveToRandomNpc = AI_State_MoveToRandomNpc or {}
function AI_State_MoveToRandomNpc.OnEnter(obj)
    local path = obj:GetPatrolMovePath()
    if path == nil or #path < 1 then
        app.log(obj:GetName() .. " AI_State_MoveToRandomNpc path == nil")
    else

        local index = nil
        local pos = nil
        local myCaptain = FightManager.GetMyCaptain();
        if myCaptain then
            local capPosX,capPosY,capPosZ = myCaptain:GetPositionXYZ()
            local allPosTemp = {}
            local maxDisSQ = 0
            for k,v in ipairs(path) do
                local sq = algorthm.GetDistanceSquared(v.x, v.z , capPosX, capPosZ)
                if sq > maxDisSQ then
                    maxDisSQ = sq
                end
                allPosTemp[k] = sq
            end
            local oneOfThree = 1/maxDisSQ
            local towOfThree = oneOfThree * 2
            
            local totalPro = 0
            for k,v in ipairs(allPosTemp) do
                if v <= oneOfThree then
                    allPosTemp[k] = 5
                elseif v > towOfThree then
                    allPosTemp[k] = 1
                else
                    allPosTemp[k] = 3
                end

                totalPro = totalPro + allPosTemp[k]
            end
            local randomNum = math.random(totalPro)

            totalPro = 0
            for k,v in ipairs(allPosTemp) do
                totalPro = totalPro + v
                if totalPro >= randomNum then
                    index = k
                    break
                end
            end
            
        else
            index = math.random(1, #path)
        end

        pos = path[index]

        AIC_SetEntityMoveToPos(obj, pos)
    end
end

AI_State_fireVirtualHeroExitEvent = AI_State_fireVirtualHeroExitEvent or {}
function AI_State_fireVirtualHeroExitEvent.OnEnter(obj)
    --app.log('AI_State_fireVirtualHeroExitEvent.OnEnter')
    obj:SetState(ESTATE.Stand)

    local hfsmData = obj:GetHFSMData()
    hfsmData.usedTime = 0

end

function AI_State_fireVirtualHeroExitEvent.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()

    hfsmData.usedTime = hfsmData.usedTime + dt
    if hfsmData.usedTime > 1 then
        PublicFunc.msg_dispatch('mainCityVirtualHeroExit', obj:GetName())
    end
end

AI_State_3v3MoveToNextFightPosition = AI_State_3v3MoveToNextFightPosition or {}
function AI_State_3v3MoveToNextFightPosition.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.hasBeginMoveToNextPosition then

        local obj = GetObj(hfsmData.State3v3MoveToNextFightPositionCurrentMvoeTo)
        if obj == nil or obj:IsDead() then
            hfsmData.hasBeginMoveToNextPosition = nil
        else
            return
        end
    end

    local enemyFlag = g_dataCenter.fight_info.left_3v3_flag
    local myFlag = obj:GetCampFlag()
    if myFlag == enemyFlag then
        enemyFlag = g_dataCenter.fight_info.right_3v3_flag
    end

    local monsterList = g_dataCenter.fight_info:GetMonsterList(enemyFlag)
    local enemyBaseEntity = nil
    local enemyCanAttackBaseEntity = {}
    for k,v in pairs(monsterList) do
        local entity = ObjectManager.GetObjectByName(v)
        if entity and not entity:IsDead() then
            if entity:GetType() == ENUM.EMonsterType.Basis then
                enemyBaseEntity = entity
            elseif entity:GetType() == ENUM.EMonsterType.Tower then
                if entity:GetCanSearch() then
                    local insertPosition = #enemyCanAttackBaseEntity + 1
                    while true do
                        prePosition = insertPosition - 1
                        if prePosition < 1 then
                            break
                        end
                        if enemyCanAttackBaseEntity[prePosition]:GetHP() <= entity:GetHP() then
                            break;
                        end
                        insertPosition = prePosition
                    end
                    table.insert(enemyCanAttackBaseEntity, insertPosition, entity)
                end        
            end
        end
    end


    local myBaseEntity = g_dataCenter.fight_info:GetBase(myFlag)
    if enemyBaseEntity == nil or myBaseEntity == nil then
        app.log('#ai#can not find basis ' .. obj:GetName())
        return
    end
    hfsmData.hasBeginMoveToNextPosition = true
    local selectEnitty = nil
    if #enemyCanAttackBaseEntity < 1 then
        selectEnitty = enemyBaseEntity
    else
        selectEnitty = enemyCanAttackBaseEntity[1]
        
    end
    --app.log("#hyg# move to " .. obj:GetName() .. ' ' .. selectEnitty:GetName())
    AIC_SetEntityMoveToV3d(obj, selectEnitty:GetPositionV3d())
    hfsmData.State3v3MoveToNextFightPositionCurrentMvoeTo = selectEnitty:GetName()
end

function AI_State_3v3MoveToNextFightPosition.OnExit(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.hasBeginMoveToNextPosition = nil
end

AI_State_TowWayMobaMoveToNextFightPosition = AI_State_TowWayMobaMoveToNextFightPosition or {}
function AI_State_TowWayMobaMoveToNextFightPosition.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.TowWayMobaMoveToNextFightPositionIsMove then return end

    local enemyFlag = g_dataCenter.fight_info.single_enemy_flag
    local myFlag = obj:GetCampFlag()
    if myFlag == enemyFlag then
        enemyFlag = g_dataCenter.fight_info.single_friend_flag
    end

    local myBase = g_dataCenter.fight_info:GetBase(myFlag)
    local enemyBase = g_dataCenter.fight_info:GetBase(enemyFlag)
    if myBase == nil or enemyBase == nil then 
        app.log_warning("AI_State_TowWayMobaMoveToNextFightPosition base has destroyed! " .. obj:GetName())
        return 
    end

    local myBasePos = myBase:GetPositionV3d()
    
    if hfsmData.enemyTown == nil or #(hfsmData.enemyTown[1]) == 0 then
        hfsmData.enemyTown = {}
        hfsmData.enemyTown[1] = {} --left
        hfsmData.enemyTown[2] = {} --right

        local monsterList = g_dataCenter.fight_info:GetMonsterList(enemyFlag)
        local enemyTown = {}  -- AIC_GetType(monsterList, {ENUM.EMonsterType.Tower})

        for i,v in pairs(monsterList) do
            local obj = GetObj(v)
            if obj._towerType == 1 or obj._towerType == 2 then
                table.insert(enemyTown, obj)
            end
            --app.log("xxxxxxxxxxxxx3 " .. entity:GetName() .. ' ' .. tostring(v._towerType))
        end

        --app.log('xxxxxxxxxxxxxxxxx1 ' .. table.tostring(monsterList))
        --app.log('xxxxxxxxxxxxxxxxx2 ' .. table.tostring(enemyTown))

        local centerLine = enemyBase:GetPositionV3d():RSub(myBasePos):RNormalize()

        for k,entity in ipairs(enemyTown) do
            local entityPos = entity:GetPositionV3d()
            local direction = entityPos:RSub(myBasePos)
            local eneityLenSQ = direction:GetLengthSQ()
            direction:RNormalize()
            local insertToSide = nil
            if centerLine:CCross(direction):GetY() > 0 then
                insertToSide = hfsmData.enemyTown[1]
            else
                insertToSide = hfsmData.enemyTown[2]
            end

            
            local count = #insertToSide
            local insertPos = count + 1
            for i = count, 1, -1 do
                local obj = GetObj(insertToSide[i])
                if eneityLenSQ > obj:GetPositionV3d():RSub(myBasePos):GetLengthSQ() then
                    break
                end
                insertPos = i
            end
            table.insert(insertToSide, insertPos, entity:GetName())
        end

        --app.log("===================1 " .. table.tostring(hfsmData.enemyTown))
    end

    if  hfsmData.lastMoveToMobaSideIndex == nil or obj:GetPositionV3d():RSub(myBasePos):GetLengthSQ() <= 15 * 15 then
        hfsmData.lastMoveToMobaSideIndex = math.random(1, 2)
    end

    local moveToObj = nil
    local sideEnemys = hfsmData.enemyTown[hfsmData.lastMoveToMobaSideIndex]
    for k,entityName in ipairs(sideEnemys) do
        local obj = GetObj(entityName)
        if obj and not obj:IsDead() then 
            moveToObj = obj
        end
    end

    if moveToObj == nil then
        moveToObj = enemyBase
    end
    
    if moveToObj then
        hfsmData.TowWayMobaMoveToNextFightPositionIsMove = true
        --app.log("===================2 " ..  obj:GetName() .. ' ' .. moveToObj:GetName() .. ' ' .. table.tostring(hfsmData.enemyTown))
        AIC_SetEntityMoveToV3d(obj, moveToObj:GetPositionV3d())
    else
        app.log("logic error!!!!!  " .. tostring(moveToObj) .. ' '  .. tostring(#(hfsmData.enemyTown[1])))
    end
end

function AI_State_TowWayMobaMoveToNextFightPosition.OnExit(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.TowWayMobaMoveToNextFightPositionIsMove = nil
end

AI_State_GoToEatAddHPItem = AI_State_GoToEatAddHPItem or {}
function AI_State_GoToEatAddHPItem.OnEnter(obj)

    --app.log('AI_State_GoToEatAddHPItem.OnEnter =================')

    local hfsmData = obj:GetHFSMData()
    local itemName = hfsmData.detectAddHPItemName or hfsmData.detectBuffItemName

    if itemName == nil then
        app.log_warning("AI_State_GoToEatAddHPItem add hp item is nil")
        return
    end

    local item = ObjectManager.GetObjectByName(itemName)
    if item then
        local pos = item:GetPositionV3d()
        AIC_SetEntityMoveToV3d(obj, pos)
    end
end
function AI_State_GoToEatAddHPItem.OnExit(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.detectAddHPItemName = nil
end

AI_State_GoToEatBuffItem = AI_State_GoToEatAddHPItem

AI_State_Clear_BeAttackEvent = AI_State_Clear_BeAttackEvent or {}
function AI_State_Clear_BeAttackEvent.OnEnter(obj)
	obj:RemoveEvent("EntityBeAttacked")
end


AI_State_AIMonsterRandomEscape = AI_State_AIMonsterRandomEscape or {}
function AI_State_AIMonsterRandomEscape.OnEnter(obj)
    local escapePos = AIC_AIC_GenerateRandomEscapePosition(obj, 8, 15, 30)

    AIC_SetEntityMoveToV3d(obj, escapePos)
    
end

function AI_State_AIMonsterRandomEscape.OnUpdate(obj, dt)
    AIC_UseAddHPSkill(obj)
end

function AI_State_AIMonsterRandomEscape.OnExit(obj)
    obj:SetState(ESTATE.Stand)
end

AI_State_CleanNewPatrolPathEvent = AI_State_CleanNewPatrolPathEvent or {}
function AI_State_CleanNewPatrolPathEvent.OnEnter(obj)
	obj:RemoveEvent(AIEvent.NEWPatrolPath)
end

AI_State_CleanResumeEvent = AI_State_CleanResumeEvent or {}
function AI_State_CleanResumeEvent.OnEnter(obj)
    --app.log('=================================== ' .. obj:GetName())
	-- obj:RemoveEvent(AIEvent.RESUME)
    --obj:RemoveEvent(AIEvent.PAUSE) --在一帧中间先发送了恢复，然后发送了暂停,会出现无法暂停的问题
end

AI_State_MoveAlongFaceDirection = AI_State_MoveAlongFaceDirection or {}
function AI_State_MoveAlongFaceDirection.OnEnter(obj)
    local myFaceDir = obj:GetFaceDirV3d()

    local moveLenValue = obj:GetHFSMKeyValue("beginning_move_len")
    local moveLen = 2
    if moveLenValue then
        moveLen = tonumber(moveLenValue)
    end
    local moveDir = myFaceDir:RScale(moveLen)
    local dstPos = obj:GetPositionV3d():RAdd(moveDir)

    AIC_SetEntityMoveToV3d(obj, dstPos)
end

function AI_State_MoveAlongFaceDirection.OnExit(obj)
    obj:SetState(ESTATE.Stand)
end

AI_State_ChangeNextAI = AI_State_ChangeNextAI or {}
function AI_State_ChangeNextAI.OnEnter(obj)
    local nxtAI = 112

    local nxtAIValue = obj:GetHFSMKeyValue("beginning_move_next_ai")
    if nxtAIValue then
        nxtAI = tonumber(nxtAIValue)
    end

    obj:SetAI(nxtAI)
end

AI_State_Fear = AI_State_Fear or {}
function AI_State_Fear.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.fearCenterPos = obj:GetPositionV3d()

    obj:SetBeControlOrOutOfControlState(true)
end

function AI_State_Fear.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()

    if hfsmData.isMove then
        local moveComplete = AI_MoveComplete(obj, {true})
        if moveComplete then
            hfsmData.isMove = false
        end
    else
        local myFaceDir = obj:GetFaceDirV3d()
        local randomPos = AIC_GenerateRandomPosition(hfsmData.fearCenterPos, myFaceDir, 3, 5, 360)
        if randomPos then
            AIC_SetEntityMoveToV3d(obj, randomPos)
            hfsmData.isMove = true
        end
    end
end

function AI_State_Fear.OnExit(obj)
    local hfsmData = obj:GetHFSMData()
    hfsmData.fearCenterPos = nil
    hfsmData.isMove = nil

    obj:SetBeControlOrOutOfControlState(false)
end

AI_State_Chaos = AI_State_Chaos or {}
function AI_State_Chaos.OnEnter(obj)

    obj:SetAttackTarget(nil)
    obj:SetBeControlOrOutOfControlState(true)

    local hfsmData = obj:GetHFSMData()
    hfsmData.chaosBasePosition = obj:GetPositionV3d()
end

function AI_State_Chaos.OnExit(obj)

    obj:SetAttackTarget(nil)
    obj:SetBeControlOrOutOfControlState(false)

    local hfsmData = obj:GetHFSMData()
    hfsmData.chaosBasePosition = nil

end

AI_State_ChaosRandomMove = AI_State_ChaosRandomMove or {}
function AI_State_ChaosRandomMove.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()

    local myFaceDir = obj:GetFaceDirV3d()
    local randomPos = AIC_GenerateRandomPosition(hfsmData.chaosBasePosition, myFaceDir, 3, 5, 360)

    if randomPos then
        AIC_SetEntityMoveToV3d(obj, randomPos)
    end
end

AI_State_ClownInit = AI_State_ClownInit or {}
function AI_State_ClownInit.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.hasInit then return end
    hfsmData.hasInit = true

    --obj:InitSpeakBubbleUI()
end

AI_State_ClownRandomStand = AI_State_ClownRandomStand or {}
function AI_State_ClownRandomStand.OnEnter(obj)
    obj:SetState(ESTATE.Stand)

    obj:PlayAnimate(EANI.idle);

    local hfsmData = obj:GetHFSMData()

    if hfsmData.clownStandEndTime == nil then
        hfsmData.clownStandEndTime = app.get_time() + 4 + math.random(4)

    end

    local probability = obj:GetHFSMKeyValue("speak_probability") or 0.5
    local speak_id = obj:GetHFSMKeyValue("speak_id")
    if speak_id and math.random() >= probability then
        obj:PlaySpeakByid(speak_id)
    end
end

AI_Sate_ClownRandomMove = AI_Sate_ClownRandomMove or {}
function AI_Sate_ClownRandomMove.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.clownMoveNextPos == nil then
        hfsmData.clownMoveNextPos = AIC_GenerateRandomPosition(obj:GetPositionV3d(), obj:GetFaceDirV3d(), 12, 18, 360)
    end
    AIC_SetEntityMoveToV3d(obj, hfsmData.clownMoveNextPos)

    obj:AddEventFilter(AIC_FilterNormalBeAttackEvent, obj)
end

function AI_Sate_ClownRandomMove.OnExit(obj)
    obj:DelEventFilter(AIC_FilterNormalBeAttackEvent)
end

AI_State_SetIsCanNotAttackAndStartPause = AI_State_SetIsCanNotAttackAndStartPause or {}
function AI_State_SetIsCanNotAttackAndStartPause.OnEnter(obj)
    obj:SetCanBeAttack(false, true)

    obj:RecoredInsideEntity()

    local time = tonumber(obj:GetHFSMKeyValue('start_pause_time'))
    if time == nil then
        time = 0
    end
    if time > 0 then
        obj:AnimatorPlay("idle")
    end

    local hfsmData = obj:GetHFSMData()
    hfsmData.stateEndTime = app.get_time() + time

    hfsmData.isObstacle = obj:GetHFSMKeyValue('is_obstacle') ~= nil
    hfsmData.isSwitchControl = obj:GetHFSMKeyValue('is_switch_control') ~= nil
    hfsmData.isSingleUse = obj:GetHFSMKeyValue('is_single_use') ~= nil
    hfsmData.changeCanBeAttack = obj:GetHFSMKeyValue('change_can_be_attack') ~= nil
    hfsmData.isGhost = obj:GetHFSMKeyValue('is_ghost') ~= nil
    hfsmData.isFake = obj:GetHFSMKeyValue('is_fake') ~= nil
    if hfsmData.isSwitchControl or hfsmData.isSingleUse then
        obj:SetHFSMKeyValue('attack_continue_time', -1)
        obj:SetHFSMKeyValue('pause_time', -1)
    end
    hfsmData.pause_time = tonumber(obj:GetHFSMKeyValue('pause_time')) or 5
    hfsmData.damageInterval = obj:GetHFSMKeyValue("damage_interval") or 1
    hfsmData.damageFlag = g_dataCenter.fight_info.single_friend_flag
    if obj:GetHFSMKeyValue("damage_all") == 1 then
        hfsmData.damageFlag = 0
    end
    hfsmData.continue_attack_time = tonumber(obj:GetHFSMKeyValue('attack_continue_time')) or 5
    hfsmData.warning_fx_id = obj:GetHFSMKeyValue('warning_fx_id') -- 17042
    hfsmData.warning_time = tonumber(obj:GetHFSMKeyValue('warning_time')) or 0.5
    if hfsmData.warning_fx_id then
        -- TODO 确定回收时机
        hfsmData.warning_fx_effect_ids = obj:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data, hfsmData.warning_fx_id), nil, nil, nil, nil, 0)
        hfsmData.warning_fx_show = false
        AI_ShowFxs(hfsmData.warning_fx_effect_ids, hfsmData.warning_fx_show, true)
    end
end

AI_State_ObstaclePlayAttackBeginAni = AI_State_ObstaclePlayAttackBeginAni or {}
function AI_State_ObstaclePlayAttackBeginAni.OnEnter(obj)
    --app.log('AI_State_ObstaclePlayAttackBeginAni.OnEnter')

    obj:AnimatorPlay("open")

    if obj.config and obj.config.model_id then
        local modelListCfg = ConfigManager.Get(EConfigIndex.t_model_list,obj.config.model_id);
        if modelListCfg and modelListCfg.egg_get_audio_id and modelListCfg.egg_get_audio_id ~= 0 then
            if type(modelListCfg.egg_get_audio_id) == "table" and modelListCfg.egg_get_audio_id[1] then
                if obj.object then
                    AudioManager.Play3dAudio(modelListCfg.egg_get_audio_id[1], obj.object)
                end
            end
        end
    end
    
    local hfsmData = obj:GetHFSMData()

    local time = hfsmData.continue_attack_time
    if time >= 0 then
        hfsmData.stateEndTime = app.get_time() + time
    else
        hfsmData.stateEndTime = -1
    end

    if  hfsmData.isFake then
        obj:SetIsObstacle(false, false)
    elseif hfsmData.isObstacle then
        obj:SetIsObstacle(true, false)
    end
end

function AI_State_ObstaclePlayAttackBeginAni.OnUpdate(obj, dt)
    AI_State_ObstaclePlayAttackBeginAni.CheckToSendDamage(obj)
end

function AI_State_ObstaclePlayAttackBeginAni.CheckToSendDamage(obj)
    local hfsmData = obj:GetHFSMData()

    if hfsmData.isObstacle == true then return end

    local sendDiff = hfsmData.damageInterval
    local now = app.get_time()
    -- local buffs = obj:GetConfig('passive_buff')
    -- if type(buffs) == 'table' then
    local buff = obj:GetConfig('ai_param')
    if type(buff) == 'table' and buff.id and buff.lv then
        local insertObj = obj:GetInsideEntityNames()
        for name, v in pairs(insertObj) do
            if v then
                local otherObj = GetObj(name)
                if otherObj and (hfsmData.damageFlag == 0 or otherObj:GetCampFlag() == hfsmData.damageFlag) 
                    and now - v > sendDiff then
                    otherObj:AttachBuff(buff.id, buff.lv)
                    insertObj[name] = now
                end
            end
        end
    else
        app.log('please config buffer!')
    end
end

AI_State_ObstaclePlayAttackEndAni = AI_State_ObstaclePlayAttackEndAni or {}
function AI_State_ObstaclePlayAttackEndAni.OnEnter(obj)
    --app.log('AI_State_ObstaclePlayAttackEndAni.OnEnter')

    local aniName = nil
    if obj:AnimatorHasState("close") then
        aniName = "close"
    elseif obj:AnimatorHasState("die") then
        aniName = "die"
    end

    --app.log('AI_State_ObstaclePlayAttackEndAni.OnEnter ' .. tostring(aniName))
    if aniName then
        obj:AnimatorPlay(aniName)
    end

    local hfsmData = obj:GetHFSMData()
    hfsmData.stateEndTime = app.get_time() + 1
end

-- function AI_State_ObstaclePlayAttackEndAni.OnUpdate(obj, dt)
--     AI_State_ObstaclePlayAttackBeginAni.CheckToSendDamage(obj)
-- end

function AI_State_ObstaclePlayAttackEndAni.OnExit(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.changeCanBeAttack then
        obj:SetCanBeAttack(true, true)
    elseif hfsmData.isGhost then
        AIC_PlaySceneOpenAnimation(obj)
        AIC_DeleteObj(obj)
    elseif hfsmData.isObstacle then
        obj:SetIsObstacle(false, false)
    end

    if hfsmData.switchEntityName then
        local objs = PublicFunc.GetObjectByInstanceName(hfsmData.switchEntityName)
        local eventName = nil
        if hfsmData.isSingleUse or hfsmData.isGhost then
            eventName = AIEvent.CloseAI
        else
            eventName = AIEvent.EntityOpenEnd
        end
        for k,switch in ipairs(objs) do
            switch:PostEvent(eventName)
        end
        hfsmData.switchEntityName = nil
    end
end

AI_State_ChangeCanBeAttack = AI_State_ChangeCanBeAttack or {}
function AI_State_ChangeCanBeAttack.OnEnter(obj)

    obj:AnimatorPlay("close")

    obj:SetCanBeAttack(true, true)

    local hfsmData = obj:GetHFSMData()
    if hfsmData.switchEntityName then
        local objs = PublicFunc.GetObjectByInstanceName(hfsmData.switchEntityName)
        local eventName = AIEvent.CloseAI

        for k,switch in ipairs(objs) do
            switch:PostEvent(eventName)
        end
        hfsmData.switchEntityName = nil
    end
end

AI_State_ObataclePlayPauseAni = AI_State_ObataclePlayPauseAni or {}
function AI_State_ObataclePlayPauseAni.OnEnter(obj)
    --app.log('AI_State_ObataclePlayPauseAni.OnEnter')
    obj:AnimatorPlay("idle")

    local hfsmData = obj:GetHFSMData()

    local time = hfsmData.pause_time

    if time >= 0 then
        hfsmData.stateEndTime = app.get_time() + time
    else
        hfsmData.stateEndTime = -1
    end

    if hfsmData.warning_fx_effect_ids then
        local delayTime = time - hfsmData.warning_time
        if delayTime < 0 then delayTime = 0 end
        hfsmData.warning_fx_begin_time = app.get_time() + delayTime
        hfsmData.warning_fx_show = false
    end
end

function AI_State_ObataclePlayPauseAni.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.warning_fx_effect_ids and not hfsmData.warning_fx_show
        and app.get_time() >= hfsmData.warning_fx_begin_time then
        hfsmData.warning_fx_show = true
        AI_ShowFxs(hfsmData.warning_fx_effect_ids, hfsmData.warning_fx_show)
    end
end

function AI_State_ObataclePlayPauseAni.OnExit(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.switchEntityName then
        local objs = PublicFunc.GetObjectByInstanceName(hfsmData.switchEntityName)
        for k,switch in ipairs(objs) do
            switch:PostEvent(AIEvent.EntityCloseEnd)
        end
        hfsmData.switchEntityName = nil
    end
    if hfsmData.warning_fx_effect_ids then
        AI_ShowFxs(hfsmData.warning_fx_effect_ids, false)
    end
end

AI_State_ChangeToObstacle = AI_State_ChangeToObstacle or {}
function AI_State_ChangeToObstacle.OnEnter(obj)
    obj:SetState(ESTATE.Stand)
    local canBeAttack = obj:GetHFSMKeyValue("can_be_attack") ~= nil
    if canBeAttack then
        obj:SetIsObstacle(true, false)
        obj:set_layer(PublicStruct.UnityLayer.monster, true);
    else
        obj:SetIsObstacle(true, true, true)
    end
end


AI_State_roadblockSwitchInit = AI_State_roadblockSwitchInit or {}
function AI_State_roadblockSwitchInit.OnEnter(obj)
    obj:AnimatorPlay("close")

    obj:SetCanBeAttack(false, true)
end

AI_State_roadBlockSwitchListenUseEnterAndExit = AI_State_roadBlockSwitchListenUseEnterAndExit or {}
function AI_State_roadBlockSwitchListenUseEnterAndExit.OnUpdate(obj, dt)

    if obj:IsReciveEvent(AIEvent.PlayerEnter) then
        local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
        if com then
            com:ShowOperatorUI()

            local hfsmData = obj:GetHFSMData()
            local param = obj:GetEventParam(AIEvent.PlayerEnter, true)
            hfsmData.controlObjectInstanceName = param[1]
            hfsmData.switchTipInstanceName = obj:GetHFSMKeyValue('tip_instance_name')

            if hfsmData.can_operate then
                com:EnableOperatorUI({obj:GetInstanceName()}, ETriggeUIOperatorType.PostEvent)
                AIC_SetEntityOperatorUiIcon(obj)
            else
                com:DisableOperatorUI()
            end
        end
    end


    if obj:IsReciveEvent(AIEvent.PlayerLeave, true) then
        local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
        if com then
            com:HideOperatorUI()
        end
    end

    if obj:IsReciveEvent(AIEvent.CloseAI, true) then
        obj:CloseAI()

        local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
        if com then
            com:HideOperatorUI()
        end
    end
end

AI_State_roadblockSwitchPlayClose = AI_State_roadblockSwitchPlayClose or {}
function AI_State_roadblockSwitchPlayClose.OnEnter(obj)

    app.log('AI_State_roadblockSwitchPlayClose.OnEnter')

    obj:AnimatorPlay("close")

    local hfsmData = obj:GetHFSMData()
    local objs = PublicFunc.GetObjectByInstanceName(hfsmData.controlObjectInstanceName)

    for k,v in ipairs(objs) do
        v:PostEvent(AIEvent.PlyaerClose, obj:GetInstanceName())
    end

    local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
    if com then
        com:DisableOperatorUI()
    end
    hfsmData.can_operate = false
end

AI_State_roadSwitchPlayOpen = AI_State_roadSwitchPlayOpen or {}
function AI_State_roadSwitchPlayOpen.OnEnter(obj)

    app.log('AI_State_roadSwitchPlayOpen.OnEnter ')

    obj:AnimatorPlay("open")

    local hfsmData = obj:GetHFSMData()
    local objs = PublicFunc.GetObjectByInstanceName(hfsmData.controlObjectInstanceName)
    for k,v in ipairs(objs) do
        v:PostEvent(AIEvent.PlayerOpen, obj:GetInstanceName())
    end

    

    local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
    if com then
        com:DisableOperatorUI()
    end
    hfsmData.can_operate = false
end

AI_State_roadblockSwitchCanOperate = AI_State_roadblockSwitchCanOperate or {}
function AI_State_roadblockSwitchCanOperate.OnEnter(obj)
    app.log('AI_State_roadblockSwitchCanOperate.OnEnter ')
    local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
    if com then
        com:EnableOperatorUI({obj:GetInstanceName()}, ETriggeUIOperatorType.PostEvent)
    end

    local hfsmData = obj:GetHFSMData()
    hfsmData.can_operate = true
end

function AI_State_roadblockSwitchCanOperate.OnExit(obj)

    -- 移除tip obj
    local hfsmData = obj:GetHFSMData()
    local tipEntityInstName = hfsmData.switchTipInstanceName
    if tipEntityInstName then
        local objs = PublicFunc.GetObjectByInstanceName(tipEntityInstName)
        for k, entity in ipairs(objs) do
            ObjectManager.RemoveObject(entity)
        end
    end
end

AI_State_ChangeTargetToMaxHatredValueEntity = AI_State_ChangeTargetToMaxHatredValueEntity or {}
function AI_State_ChangeTargetToMaxHatredValueEntity.OnEnter(obj)

    local hfsmData = obj:GetHFSMData()

    --app.log('State_ChangeTargetToMaxHatredValueEntity ' .. tostring(hfsmData.maxHatredValueEntityName))

    obj:SetAttackTarget(GetObj(hfsmData.maxHatredValueEntityName))
end

AI_State_dropedKeyInit = AI_State_dropedKeyInit or {}
function AI_State_dropedKeyInit.OnEnter(obj)
    obj:SetCanBeAttack(false, true)

    g_dataCenter.fight_info:SetPrepareOpenObstacle(true)
end

AI_State_dropedKeyInGroundTime = AI_State_dropedKeyInGroundTime or {}
function AI_State_dropedKeyInGroundTime.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()

    hfsmData.stateEndTime = app.get_time() + 2
end

AI_State_dropedKeyFlyUiIcon = AI_State_dropedKeyFlyUiIcon or {}
function AI_State_dropedKeyFlyUiIcon.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()

    hfsmData.stateEndTime = -1

    local objName = obj:GetName()

    -- assetbundles/prefabs/fx/prefab/fx_ui/fx_ui_get_items_trail.assetbundle
    OGM.GetGameObject("assetbundles/prefabs/fx/prefab/fx_ui/fx_ui_get_items_trail.assetbundle", function(gObject)
        local go = gObject:GetGameObject()
        local obj_Id = gObject:GetId()
        go:set_active(true)
        --go:set_local_scale(5,5,5)

        --app.log("OGM " .. go:get_name())
        
        local obj = GetObj(objName)
        local mainui = GetMainUI()

        if not obj or not mainui then
            OGM.UnUse(obj_Id)
            return
        end

        local tocom = mainui:GetComponent(EMMOMainUICOM.MainUITriggerOperator)
        if not tocom then
            OGM.UnUse(obj_Id)
            return
        end

        local x, y, z = obj:GetPositionXYZ()
        local fight_camera = CameraManager.GetSceneCamera();
        local ui_camera = Root.get_ui_camera();
        local view_x, view_y, view_z = fight_camera:world_to_screen_point(x, y, z);
        view_z = 0;
        local ui_x, ui_y, ui_z = ui_camera:screen_to_world_point(view_x, view_y, view_z);
        go:set_position(ui_x, ui_y, ui_z)
        local fm_x,fm_y,fm_z = go:get_local_position()
        local t_x,t_y,t_z = tocom:GetIconWorldPosition()
        local tween = ngui.find_tween_position(go, go:get_name())
        tween:set_bezier(true,fm_x-math.random(30,100),fm_x+math.random(30,100),0,t_x+math.random(30,100),t_y-math.random(30,100),0)
        --tween:set_bezier(true,fm_x,fm_y+math.random(200,300),0,t_x,t_y-math.random(30,100),0)
        tween:set_from_postion(fm_x,fm_y,fm_z)
        --app.log("fm_x=" .. tostring(fm_x) .. ' fm_y=' .. tostring(fm_y) .. ' fm_z=' .. tostring(fm_z)  )
        tween:set_to_postion(t_x,t_y,t_z)
        --app.log("tx=" .. tostring(t_x) .. ' ty=' .. tostring(t_y) .. ' tz=' .. tostring(t_z)  )
        tween:set_duration(0.6)
        tween:reset_to_begining()
        tween:play_foward()
        tween:clear_on_finished()

        obj:Show(false)
        
        tween:set_on_finished(Utility.create_callback( function()
            OGM.UnUse(obj_Id)

            g_dataCenter.fight_info:SetPrepareOpenObstacle(false)


            local tipInstName = obj:GetHFSMKeyValue('tip_instance_name')
            if tipInstName then
                local objs = PublicFunc.GetObjectByInstanceName(tipInstName)
                -- for k, entity in ipairs(objs) do
                --     entity:Show(true)
                -- end
                
                if #objs > 0 then
                    local entity = objs[1]
                    entity:Show(true)
                    
                    g_dataCenter.fight_info:SetCurrentTipEntity(entity:GetName())
                end
            end

            local mainui = GetMainUI()
            if mainui then
                local com = mainui:GetComponent(EMMOMainUICOM.MainUITriggerOperator)
                if com then
                    com:ShowOperatorUI(true)

                    AIC_SetEntityOperatorUiIcon(obj)
                end
            end

            ObjectManager.RemoveObject(obj)
        end ))
    end )

end

AI_State_MoveToSafePosAwayOffTowner = AI_State_MoveToSafePosAwayOffTowner or {}
function AI_State_MoveToSafePosAwayOffTowner.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()

    local towner = GetObj(hfsmData.lastTownerAttackEntityName)
    if not towner then return end

    local townerPosX, townerPosY, townerPosZ = towner:GetPositionXYZ()

    local fm = FightScene.GetFightManager()

    if fm == nil then
        app.log('AI_State_MoveToSafePosAwayOffTowner fightManager nil')
        return
    end
    
    local base = fm:GetNpcPos(0, obj:GetCampFlag());
    local x,z
    if #base > 0 then
        x = base[1].x
        z = base[1].y
    end

    if x == nil or z == nil then
        app.log('AI_State_MoveToSafePosAwayOffTowner ' .. tostring(x) .. ' ' .. tostring(z))
        return
    else
        --app.log('AI_State_MoveToSafePosAwayOffTowner true ' .. tostring(x) .. ' ' .. tostring(z))
    end

    local diffX = x - townerPosX
    local diffZ = z - townerPosZ

    local nx,ny,nz = algorthm.Normalized(diffX, 0, diffZ)

    local skill = obj:GetSkill(1)
    if skill == nil then return end

    local attackRange = skill:GetDistance() or 1

    local attackRange = attackRange * 2

    local MoveDirX, MoveDirZ = nx * attackRange, nz * attackRange

    local myPosX, myPosY, myPosZ = obj:GetPositionXYZ()

    AIC_SetEntityMoveToPos(obj, {x = myPosX + MoveDirX, y = 0, z = myPosZ + MoveDirZ})
end

AI_State_SelectSkillByEnableAndAttackRange = AI_State_SelectSkillByEnableAndAttackRange or {}
function AI_State_SelectSkillByEnableAndAttackRange.OnEnter(obj)
    local tar = obj:GetAttackTarget()
    if not tar then
        return 
    end

    obj:SetState(ESTATE.Stand);

    local hfsmData = obj:GetHFSMData()
    hfsmData.Fight_State_Follow_Select_Skill_id = nil

    --app.log("AI_State_SelectSkillByEnableAndAttackRange " .. tostring(obj:GetHFSMData().Fight_State_Follow_Select_Skill_id))

    local myPosX, myPosY, myPosZ = obj:GetPositionXYZ()
    local tarPosX, tarPosY, tarPosZ = tar:GetPositionXYZ()

    local distSQ = algorthm.GetDistanceSquared(myPosX, myPosZ, tarPosX, tarPosZ)

    local canUseSkillIndex = obj:GetCanUseSkillIndexs()

    for k,skillId in ipairs(canUseSkillIndex) do
        local canUse = obj:CanAndNeedUseSkill(skillId)
        if canUse then
            local skill = obj:GetSkill(skillId)
            if skill then
                local skillDist = skill:GetDistance() + tar:GetRadius()
                -- app.log("AI_State_SelectSkillByEnableAndAttackRange " .. obj:GetName() .. ' ' .. skillDist .. ' ' .. tostring(math.sqrt(distSQ)))
                if skillDist * skillDist >= distSQ then
                    hfsmData.Fight_State_Follow_Select_Skill_id = skillId
                    -- if obj:IsHero() then
                    --     app.log("AI_State_SelectSkillByEnableAndAttackRange.OnEnter " .. obj:GetName() .. ' ' .. tostring(skillDist) .. ' ' .. tostring(math.sqrt(distSQ)) .. ' ' .. tar:GetName() .. ' ' .. tostring(hfsmData.Fight_State_Follow_Select_Skill_id))
                    -- end
                    break
                end
            end
        end
    end
end

AI_Sate_AddTownerAttackMeRecord = AI_Sate_AddTownerAttackMeRecord or {}
function AI_Sate_AddTownerAttackMeRecord.OnEnter(obj)
    obj:AddBeAttackedCallbackFunc(AI_RecordLastAttackMeTowner)
end

AI_State_GotoOpenObstaclePos = AI_State_GotoOpenObstaclePos or {}
function AI_State_GotoOpenObstaclePos.OnEnter(obj)
    local tipItem = g_dataCenter.fight_info:GetCurrentTipEntity()

    if tipItem and tipItem:IsShow() then
        AIC_SetEntityMoveToPosXYZ(obj, tipItem:GetPositionXYZ())
    end
end

AI_State_ExecOpenObstacleAction = AI_State_ExecOpenObstacleAction or {}

function AI_State_ExecOpenObstacleAction.OnEnter(obj)
    obj:SetState(ESTATE.Stand)
end

function AI_State_ExecOpenObstacleAction.OnExit(obj)

    local fi = g_dataCenter.fight_info

    fi:SetCurrentTipEntity(nil)
    fi:SetCurrentObstacle(nil)
end


AI_State_actionOrderDelay = AI_State_actionOrderDelay or {}
function AI_State_actionOrderDelay.OnEnter(obj)
    local self = AI_State_actionOrderDelay

    if self.lastResetTime == nil or app.get_time() - self.lastResetTime > 1 then
        self.currentdelay = AIStateConstVar.stateDelayMinNumber
    end

    local hfsmData = obj:GetHFSMData()

    hfsmData.stateEndTime = app.get_time() + self.currentdelay

    -- app.log("self.currentdelay = " .. tostring(self.currentdelay))

    self.currentdelay = self.currentdelay + AIStateConstVar.stateDElayStep
    if self.currentdelay > AIStateConstVar.stateDelayMaxNumber then
        self.currentdelay = self.currentdelay - AIStateConstVar.stateDelayMaxNumber + AIStateConstVar.stateDelayMinNumber
    end
end


AI_State_AttackMove = AI_State_AttackMove or {}
function AI_State_AttackMove.OnEnter(obj)
    local target = obj:GetAttackTarget()
    if not target then
        return
    end

    local tx, ty, tz = target:GetPositionXYZ()
    local mx, my, mz = obj:GetPositionXYZ()

    local tox, toy, toz = tx - mx, ty - my, tz - mz
    local tox, toy, toz, isSuc = algorthm.Normalized(tox, toy, toz)

    if not isSuc then
        tox, toy, toz = obj:GetFacieDirXYZ()
    end

    local attackRadius = AIC_GetAttackRadius(obj)

    local toTargetdst = obj:GetHFSMKeyValue("to_target_dst") or AIStateConstVar.attackMoveToTargetDistance
    local moveMaxDst = obj:GetHFSMKeyValue("move_max_dst") or AIStateConstVar.attackMoveMaxMoveDistance
    local cannotMoveAngle = obj:GetHFSMKeyValue("can_not_move_angle") or AIStateConstVar.attackMoveCanNotMoveAngle
    local canMoveAngle = obj:GetHFSMKeyValue("can_move_angle") or AIStateConstVar.attackMoveCanMoveAngle

    for i = 1, 3 do
        local dirFactor = 1
        if math.random() < 0.5 then
            dirFactor = -1
        end
        local angle = math.random(1, canMoveAngle)
        local len = math.random(math.floor(moveMaxDst/2), moveMaxDst) + 0.5

        local baseX, baseY, baseZ = tx - tox * toTargetdst, ty - toy * toTargetdst, tz - toz * toTargetdst

        local qx,qy,qz,qw = util.quaternion_euler(0, (cannotMoveAngle + angle) * dirFactor, 0) 
        local nx,ny,nz = util.quaternion_multiply_v3(qx,qy,qz,qw, tox, toy, toz)

        local dx, dy, dz = baseX + nx * len, baseY + ny * len, baseZ + nz * len

        local isSuc, sx, sy, sz = util.get_navmesh_sampleposition(dx, dy, dz, 0.1)
        if isSuc then
            local hfsmData = obj:GetHFSMData()

            -- hfsmData.tx = tx
            -- hfsmData.ty = ty
            -- hfsmData.tz = tz
            -- hfsmData.bx = baseX
            -- hfsmData.by = baseY
            -- hfsmData.bz = baseZ
            -- hfsmData.dx = sx
            -- hfsmData.dy = sy
            -- hfsmData.dz = sz

            AIC_SetEntityMoveToPosXYZ(obj, sx, sy, sz)

            local needWalkAni = obj:GetHFSMKeyValue("need_walk_ani")
            if needWalkAni then
                hfsmData.oldMoveId =  obj:SetMoveAniId( EANI.walk ) -- EANI.stand EANI.walk
            end
            local speed = obj:GetHFSMKeyValue("walk_speed")
            if type(speed) == 'number' then
                obj:SetSpeedProp(speed)
            end
            break
        end
    end

end

-- function AI_State_AttackMove.OnUpdate(obj, dt)

--     local hfsmData = obj:GetHFSMData()

--     local r,g,b = 0, 1, 0

--     util.draw_line(hfsmData.bx, hfsmData.by + 1, hfsmData.bz, hfsmData.tx, hfsmData.ty + 1, hfsmData.tz, r,g,b)
--     util.draw_line(hfsmData.bx, hfsmData.by + 1, hfsmData.bz, hfsmData.dx, hfsmData.dy + 1, hfsmData.dz, r,g,b)
-- end

function AI_State_AttackMove.OnExit(obj)
    obj:SetSpeedProp(nil)

    local hfsmData = obj:GetHFSMData()
    if hfsmData.oldMoveId then
        obj:SetMoveAniId(hfsmData.oldMoveId)
        hfsmData.oldMoveId = nil
    end
end

AI_State_RotateToTarget = AI_State_RotateToTarget or {}
function AI_State_RotateToTarget.OnEnter(obj)

    --obj:SetState(ESTATE.Stand)

    local tar = obj:GetAttackTarget()
    if not tar then return end
    local tx, ty, tz = tar:GetPositionXYZ()
    local mx, my, mz = obj:GetPositionXYZ()

    local dirx, diry, dirz = tx - mx, ty - my, tz - mz
    local isSUc
    dirx, diry, dirz, isSuc = algorthm.Normalized(dirx, diry, dirz)
    if not isSuc then
        return
    end
    local hfsmData = obj:GetHFSMData()
    hfsmData.RotateToTargetfqx, hfsmData.RotateToTargetfqy, hfsmData.RotateToTargetfqz, hfsmData.RotateToTargetfqw = obj:GetRotationq()
    if not hfsmData.RotateToTargetfqw then return end
    hfsmData.RotateToTargettqx, hfsmData.RotateToTargettqy, hfsmData.RotateToTargettqz, hfsmData.RotateToTargettqw = util.quaternion_look_rotation(dirx, diry, dirz);

    hfsmData.useTime = 0
    hfsmData.totalTime = 0.3
    hfsmData.stateEndTime = -1
end

function AI_State_RotateToTarget.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()

    if not hfsmData.useTime then
        hfsmData.stateEndTime = 0
        return
    end

    hfsmData.useTime = hfsmData.useTime + dt
    local t = hfsmData.useTime/hfsmData.totalTime
    if t >= 1 then
        t = 1 
        hfsmData.stateEndTime = 0
    end

    -- public static Quaternion RotateTowards(Quaternion from, Quaternion to, float maxDegreesDelta);

    local cx, cy, cz, cw = util.quaternion_lerp(hfsmData.RotateToTargetfqx, hfsmData.RotateToTargetfqy, hfsmData.RotateToTargetfqz, hfsmData.RotateToTargetfqw, hfsmData.RotateToTargettqx, hfsmData.RotateToTargettqy, hfsmData.RotateToTargettqz, hfsmData.RotateToTargettqw, t)
    obj:SetRotationq(cx, cy, cz, cw)
end

AI_State_beEscortCharacterInit = AI_State_beEscortCharacterInit or {}
function AI_State_beEscortCharacterInit.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.HasInit then return end
    hfsmData.HasInit = true
    -- init hp,name ...

    obj:InitEscortHP();
end

AI_State_EscapeCharacterInit = AI_State_EscapeCharacterInit or {}
function AI_State_EscapeCharacterInit.OnEnter(obj)
    local hfsmData = obj:GetHFSMData()
    if hfsmData.HasInit then return end
    hfsmData.HasInit = true

    obj:SetConfig("view_radius", 0)
end

AI_State_SwitchToFight = AI_State_SwitchToFight or {}
function AI_State_SwitchToFight.OnEnter(obj)
    obj:SetConfig("view_radius", obj.config.view_radius or 5)
end

AI_State_SwitchToEscape = AI_State_SwitchToEscape or {}
function AI_State_SwitchToEscape.OnEnter(obj)
    obj:SetConfig("view_radius", 0)
end

-- AI_AccordingByConditionChangePursuitSpeed = AI_AccordingByConditionChangePursuitSpeed or {}
-- function AI_AccordingByConditionChangePursuitSpeed.OnEnter(obj)

--     local hfsmData = obj:GetHFSMData()
--     if hfsmData.fastPursuitSpeed == nil then
--         local fastPursuitSpeed = obj:GetHFSMKeyValue("fast_pursuit_speed")
--         if fastPursuitSpeed == nil then return end
--     end

--     if AI_IsReciveEvent(obj, AIEvent.FastSpeed) then
--         obj:SetSpeedProp(hfsmData.fastPursuitSpeed)
--     end

--     if AI_IsReciveEvent(obj, AIEvent.NormalSpeed) then
--         obj:SetSpeedProp(obj:GetConfig('move_speed'))
--     end

--     local targetName = obj:GetAttackTargetName()
--     if targetName == nil then return end

--     local target = GetObj(targetName)
--     if target == nil then return end

    

--     if hfsmData.fastPursuitMaxDst == nil then
--         local fastPursuitMaxDst = obj:GetHFSMKeyValue("fast_pursuit_max_dst")
--         if fastPursuitMaxDst == nil then return end
--         hfsmData.fastPursuitMaxDstSQ = hfsmData.fastPursuitMaxDst * hfsmData.fastPursuitMaxDst
--     end

--     local tx, ty, tz = target:GetPositionXYZ()
--     local mx, my, mz = obj:GetPositionXYZ()

--     if algorthm.GetDistanceSquared(tx, tz, mx, mz) >= hfsmData.fastPursuitMaxDstSQ then
--         obj:SetSpeedProp(fastPursuitSpeed)
--     end
-- end

AI_State_ClearDangerousEvent = AI_State_ClearDangerousEvent or {}
function AI_State_ClearDangerousEvent.OnEnter(obj)
    obj:RemoveEvent(AIEvent.Dangerous)

    local hfsmData = obj:GetHFSMData()
    hfsmData.FeelDangerousBeginTime = nil
end


AI_State_CloseSelfAI = AI_State_CloseSelfAI or {}
function AI_State_CloseSelfAI.OnEnter(obj)
    obj:CloseAI()
end

AI_State_ChangeToSceneProp = AI_State_ChangeToSceneProp or {}
function AI_State_ChangeToSceneProp.OnEnter(obj)

    obj:SetCanBeAttack(false)
    obj:SetNavFlag(false, false)

    local initAniName = obj:GetHFSMKeyValue("init_ani") 
    if type(initAniName) == 'string' then
        obj:AnimatorPlay(initAniName)
    end
end

AI_State_PlayWarningAction = AI_State_PlayWarningAction or {}
function AI_State_PlayWarningAction.OnEnter(obj)
    obj:SetState(ESTATE.Stand)

    local hfsmData = obj:GetHFSMData()
    local t = tonumber(obj:GetHFSMKeyValue("warning_stand_time")) or 3000
    hfsmData.playWarningActionTime = t/1000
    hfsmData.playWarningUseTime = 0

    hfsmData.playWarningState = 2
end

function AI_State_PlayWarningAction.OnUpdate(obj, dt)
    local hfsmData = obj:GetHFSMData()
    hfsmData.playWarningUseTime = hfsmData.playWarningUseTime + dt

    if hfsmData.playWarningState == 2 then
        local fxid = tonumber(obj:GetHFSMKeyValue("warning_fx"))
        -- fxid = 17025
        if fxid then
            local cfg = ConfigManager.Get(EConfigIndex.t_effect_data, fxid)
            if cfg then
                hfsmData.playWarningEffectsTime = 2
                hfsmData.playWarningEffectsEndUseTime = hfsmData.playWarningUseTime + hfsmData.playWarningEffectsTime
                hfsmData.playWarningEffectsIDs = obj:SetEffect(nil, cfg, nil, nil, nil, nil, hfsmData.playWarningEffectsTime)
                hfsmData.playWarningState = 3
            else
                hfsmData.playWarningState = 4
            end
        else
            hfsmData.playWarningState = 4
        end
    elseif hfsmData.playWarningState == 3 then
        if hfsmData.playWarningUseTime >= hfsmData.playWarningEffectsEndUseTime then
            hfsmData.playWarningState = 4
        end
    elseif hfsmData.playWarningState == 4 then
        local speakid = tonumber(obj:GetHFSMKeyValue("warning_speak"))
        --speakid = 1
        if speakid then
            obj:PlaySpeakByid(speakid)
        else
            hfsmData.playWarningState = 5
        end
    end
end

function AI_State_PlayWarningAction.OnExit(obj)
    local warningSpeed = tonumber(obj:GetHFSMKeyValue("warning_speed"))
    local warningSpeedTime = tonumber(obj:GetHFSMKeyValue("warning_speed_time")) or 0

    -- test 
    -- warningSpeed = 6
    -- warningSpeedTime = 3

    if warningSpeed and warningSpeedTime > 0 then
        local hfsmData = obj:GetHFSMData()
        hfsmData.warningStateSpeed = warningSpeed
        hfsmData.warningStateSpeedEndTime = app.get_time() + warningSpeedTime/1000
    end
end




