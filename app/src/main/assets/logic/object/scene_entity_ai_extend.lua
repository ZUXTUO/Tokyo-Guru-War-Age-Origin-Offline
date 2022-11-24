--------------
-- TODO: kevin 临时重构区域 
-- 

local g_viewEffectMonsterTargetRadius = 0.33 * PublicStruct.Const.HERO_SCALE

function SceneEntity:GetHFSM()
    return self.ai_fsm
end

function SceneEntity:extraInitData()
    self.detectRangeMin = 5 
    self.detectRangeMax = 10 
    self.detectedTargetName = nil

    self.activeDetection = true
    -- 优化 通过区域碰撞体 +　时间呼吸来设置，开启和关闭
    --self:SetCurSkillIndex(self.normalAttackIndex)

    self:SetNavFlag(false, false)
end

function SceneEntity:HasDetectedEnemy()
    --return self.detectedTargetName ~= nil
    if not self.detectedTargetName then
        return false
    end
    local target = ObjectManager.GetObjectByName(self.detectedTargetName) 
    return target ~= nil
end

function SceneEntity:GetDetectedTarget()
    local dt = ObjectManager.GetObjectByName(self.detectedTargetName)
    if dt == nil and self.detectedTargetName ~= nil then
        app.log_warning('GetDetectedTarget return nil self.detectedTargetName ~= nil ' .. self.detectedTargetName)
    end
    return dt
end

function SceneEntity:SetDetectedTarget(objName)
    self.detectedTargetName = objName
end

-- 侦测一个目标， 如果当前目标有效， 则不用侦测。 
function SceneEntity:ClearDetectedEnemy()
    self.detectedTargetName = nil
end

function SceneEntity:SearchAllEnemyOnAround(radius, isChaos, except)
    --if true then return {} end
    local layerMask = {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster};
    local pos_self = self:GetPosition(true, false, self.hfsmData.SearchAllEnemyOnAroundPosOut);
    local targets = nil

    local angle = self:GetConfig("view_angle") or 0

    local targetRadius = nil

    if self:HasViewRangeEffect() then
        targetRadius = g_viewEffectMonsterTargetRadius
    end
    
    if angle > 0 then
        local dir = self:GetFacieDir()
        targets = algorthm.GetOverlapSphere(pos_self, radius, dir, angle, PublicFunc.GetBitLShift(layerMask), targetRadius)
    else
        targets = algorthm.GetOverlapSphereRound(pos_self, radius, PublicFunc.GetBitLShift(layerMask), targetRadius)
    end
    local result  = {}
    if targets ~= nil then
        for k,v in ipairs(targets) do
--            if v:get_name() ~= nil then
                local e = v --ObjectManager.GetObjectByName(v:get_name())
                local isEnemy = nil
                if isChaos ~= true then 
                    isEnemy = e:IsEnemy(self)
                else
                    isEnemy = not e:IsNeutrality()
                end
                local isNotExcept = true
                if except then
                    isNotExcept = table.index_of(except, e:GetName()) < 1
                end
                if e ~= self and e ~= nil and not e:IsDead() and isEnemy and not e:IsHide() and isNotExcept then
                    if e:GetCanSearch() then
                        table.insert(result, e)
                    end
                end
--            end
        end
    end
    return result
end

function SceneEntity:DetectANearestEnemy(radius, except)
    if self.detectedTargetName == nil then
        local targets = self:SearchAllEnemyOnAround(radius)
        --if targets ~= nil then
            local minDistance = 9999;
            local detectedName = nil;
            local selfIsPatrol = true

            local posSelfX, posSelfY, posSelfZ = self:GetPositionXYZ();
            for k, v in pairs(targets) do
                local tarName = v:GetName()
                if not table.is_contains(except, tarName) then
                    local posX,posY,posZ = v:GetPositionXYZ();
                    local dis = algorthm.GetDistance(posX, posZ, posSelfX, posSelfZ);
                    if (dis < minDistance) then
                        minDistance = dis;
                        detectedName = tarName;
                    end

                end
            end
            self.detectedTargetName = detectedName
        --end
    end
end

function SceneEntity:SetHomePosition(pos)
    self.HomePosition = pos
end

function SceneEntity:GetHomePosition()
    return self.HomePosition
end

function SceneEntity:GetHomePositionV3d(pos)
    return Vector3d:new(self.HomePosition)
end

function SceneEntity:ResetLastUseSkillTime()
    self._lastUseSkillTime = nil
end

function SceneEntity:RecordLastUseSkillTime()
    self._lastUseSkillTime = os.time()
end

function SceneEntity:GetLastUseSkillPassTime(default)
    if self._lastUseSkillTime == nil then
        if default ~= nil then
            return default
        end
        return 0
    else
        return os.time() - self._lastUseSkillTime
    end
end

function SceneEntity:ResetLastBeAttackTime()
    self._lastBeAttackTime = nil
end

function SceneEntity:RrecordLastBeAttackTime(attacker)
    self._lastBeAttackTime = os.time()
    if attacker ~= nil then
        self._lastBeAttackAttacker = attacker:GetName()
    end
end

function SceneEntity:GetLastBeAttackAttacker()
    return self._lastBeAttackAttacker
end

function SceneEntity:GetLastBeAttackTimePassTime()
    if self._lastBeAttackTime == nil then
        return 0
    end
    return os.time() - self._lastBeAttackTime
end

function SceneEntity:CallBeAttackedCallbackFunc(attacker)
    AI_MonsterBeAttackedCallBack(self, attacker)
	--self:PostEvent("EntityBeAttacked", {attackerName = self:GetName()});
    for k,func in ipairs(self._BeAttackedCallbackFuncs) do
        func(self, attacker)
    end
end

function SceneEntity:AddBeAttackedCallbackFunc(func)
    local index = table.index_of(self._BeAttackedCallbackFuncs, func)
    if index < 1 then
        table.insert(self._BeAttackedCallbackFuncs, func)
    end
end

function SceneEntity:CallAttackedCallbackFunc(beAttacker)
    for k,func in ipairs(self._AttackedCallbackFuncs) do
        func(self, beAttacker)
    end
end

function SceneEntity:AddAttackedCallbackFunc(func)
    local index = table.index_of(self._AttackedCallbackFuncs, func)
    if index < 1 then
        table.insert(self._AttackedCallbackFuncs, func)
    end
end

--function SceneEntity:GetLastSearchEnemyDeltaTime()
--    if self._LastSearchEnemyTime == nil then
--        self._LastSearchEnemyTime = 0
--    end
--    return os.time() - self._LastSearchEnemyTime
--end

--function SceneEntity:RecordLastSearchEnemyTime()
--    self._LastSearchEnemyTime = os.time()
--end

function SceneEntity:GetMaxHP()
    return self:GetPropertyVal('max_hp')
end

function SceneEntity:GetCurrentSkillIsEnd()
    return self:GetLastSkillComplete()
end


function SceneEntity:SetSkillUseByAIHFSM(is)
    self._SkillUseByAiHFSM = is
end
function SceneEntity:GetIsSkillUseByAIHFSM()
    if self._SkillUseByAiHFSM == nil then
        return false
    end
    return self._SkillUseByAiHFSM
end

-- { 4, 5, 6, 1 };
function SceneEntity:SetCanUseSkillIndex(indexs)
    if type(indexs) == "table" then
         self.tabSkillIndex = indexs

          self._NextSkillIDIndex = 1
    end
end

function SceneEntity:GetCanUseSkillIndexs()
    local taut = self:GetBuffManager()._tauntTarget
    local tabSkillIndex = nil
    if taut == nil then
        tabSkillIndex = self.tabSkillIndex
    else
        tabSkillIndex = self.beTauntSkillIndex
    end

    return tabSkillIndex
end

function SceneEntity:GetNextSkillID()

    --while true do return 1 end

    local tabSkillIndex = self:GetCanUseSkillIndexs()

    if self._NextSkillIDIndex == nil then
        self._NextSkillIDIndex = 1
    end

    local len = #tabSkillIndex
    local origin = self._NextSkillIDIndex
    --替换了技能表
    if origin > len then
        origin = 1
    end
    
    local index = origin
    local skillID = nil;
    local canUseResult = nil

    repeat
        skillID = tabSkillIndex[index]
        index = index + 1
        if index > len then
            index = 1;
        end

        canUseResult = self:CanAndNeedUseSkill(skillID)

        if canUseResult then
            break;
        end
    until index == origin;

    self._NextSkillIDIndex = index
    if canUseResult then
        return skillID
    end
    return nil;
end

function SceneEntity:SetAINextSkillID(skillid)
    if self:CanAndNeedUseSkill(skillid) then
        local hfsmData = self:GetHFSMData()
        hfsmData.Fight_State_Follow_Select_Skill_id = skillid
    end
end

function SceneEntity:CanAndNeedUseSkill(skillID)

    local skill = self._arrSkill[skillID]
    if skill == nil then
        return false
    end

    local need = true

    if skill:GetEffectType() == ENUM.SkillEffectType.AddHP then
        need = false

        local mySide = g_dataCenter.fight_info:GetControlHeroList()
        if type(mySide) == 'table' then
            for k,name in pairs(mySide) do
                local entity = GetObj(name)
                if entity and entity:GetHP() < entity:GetMaxHP() then
                    --app.log('x=xCanAndNeedUseSkill need')
                    need = true
                    break;
                end
            end
            
        end
    end
    local canUse = false 
    if need then
        canUse =  SkillManager.CanUseSkill(self, skill) == eUseSkillRst.OK
    end
    return need and canUse
end

function SceneEntity:GetCanUsedAddHpSkillId()
    for i = 1, MAX_SKILL_CNT do
        local skill = self._arrSkill[i]
        if skill and skill:GetEffectType() == ENUM.SkillEffectType.AddHP and SkillManager.CanUseSkill(self, skill) == eUseSkillRst.OK then
            return i
        end
    end

    return nil
end

function SceneEntity:T_StopCurrentSkill()
    --self.lastSkillComplete = true
    --self.keepNormalAttack = false
end

-- 添加一个函数check PostEvent是否接受该事件
function SceneEntity:AddEventFilter(func, param)
    self.eventFilterFunc = self.eventFilterFunc or {}
    self.eventFilterFunc[func] = param
end

function SceneEntity:DelEventFilter(func)
    if self.eventFilterFunc then
        self.eventFilterFunc[func] = nil
    end
end

function SceneEntity:CanReciveEvent(eventName, param)
    local res = true
    if self.eventFilterFunc then
        for f, p in pairs(self.eventFilterFunc) do
            res = f(p, eventName, param)
            if not res then
                break
            end
        end
    end

    return res
end


function SceneEntity:EventPreprocess(eventName)
    local hasProcess = true
    if eventName == AIEvent.PAUSE then
        self.__aiPauseCount = self.__aiPauseCount + 1
    elseif eventName == AIEvent.RESUME then
        self.__aiPauseCount = self.__aiPauseCount - 1
        if self.__aiPauseCount < 0 then
            self.__aiPauseCount = 0
        end
    else
        hasProcess = false
    end

    return hasProcess
end

function SceneEntity:IsPause()
    return self.__aiPauseCount > 0 or (self._careGlobalPauseState and FightScene.IsPauseState())
end

function SceneEntity:SetCareGlobalPauseState(is)
    self._careGlobalPauseState = is
end

--self.__HFSM_event = {event = {}}
--接受一个事件
--eventName 暂停事件"Pause"

--恐惧("Fear", "FinishFear")
--混乱("chaos", "Finishchaos")

function SceneEntity:PostEvent(eventName, param)
    --[[if self:IsHero() then
        app.log("PostEvent " .. self:GetName() .. ' ' .. tostring(eventName) .. ' ' .. tostring(Root.GetFrameCount()))
    end]]



    if self:EventPreprocess(eventName) then
        return
    end

    --self.__event_mgr
    if eventName ~= nil then
        param = param or true

        if self:CanReciveEvent(eventName, param) then
            local lastEventParam = self.__event_mgr.eventQueue[eventName]
            if lastEventParam and type(param) == 'table' and param.eventLevel then
                if lastEventParam.eventLevel then
                    if param.eventLevel > lastEventParam.eventLevel then
                        self.__event_mgr.eventQueue[eventName] = param
                    end
                else
                    self.__event_mgr.eventQueue[eventName] = param
                end
            else
                self.__event_mgr.eventQueue[eventName] = param
            end

        end
    end
end

function SceneEntity:IsReciveEvent(eventName, isRemove)
    --self.__event_mgr
    if isRemove == nil then
        isRemove = false
    end
    local res = false
    if self.__event_mgr.eventQueue[eventName] ~= nil then
        if isRemove then
            --app.log("xxxxxx123")
            self.__event_mgr.eventQueue[eventName] = nil
        end
        res = true
    end
    return res
end

function SceneEntity:GetEventParam(eventName, isRemove)
    local res = self.__event_mgr.eventQueue[eventName]
    if isRemove == true then
        self.__event_mgr.eventQueue[eventName] = nil
    end

    return res
end

function SceneEntity:RemoveEvent(eventName)
     self.__event_mgr.eventQueue[eventName] = nil
end

function SceneEntity:LookAt(x,y,z)
    if not self.object then return end
    -- 如果角速度为0的话，就不生效
    if self:GetAngularSpeed() == 0 then
        return;
    end

    local _posX,y,_posZ = self:GetPositionXYZ()
    return self.object:look_at(x, y, z)
end

--param = {
  --attackName = '',
  --backMoveLen = 1
  --backMoveTime = 132,
--}
--function SceneEntity:SetBeRepelParam(param)
    --self.__beRepelParam = param
--end
--
--function SceneEntity:GetBeRepelParam()
    --return self.__beRepelParam
--end

function SceneEntity:GetFacieDir()
    local dir = {}
    dir.x, dir.y, dir.z = self.object:get_forward()
    return dir
end

function SceneEntity:GetFacieDirXYZ()
    return self.object:get_forward()
end

function SceneEntity:GetFaceDirV3d()
    local x, y, z = self.object:get_forward()
    return Vector3d:new({x = x, y = y, z = z})
end

function SceneEntity:SetBeControlOrOutOfControlState(state)
    self._BeControlOrOutOfControlState = state
end

function SceneEntity:IsBeControlOrOutOfControlState(state)
    return self._BeControlOrOutOfControlState == true
end

--path = {
--{x = 0, y = 0 , z = 0},
--}
function SceneEntity:SetPatrolMovePath(path)
    self:PostEvent(AIEvent.NEWPatrolPath)
    self.__PatrolMovePath = path
end

function SceneEntity:GetPatrolMovePath()
    return self.__PatrolMovePath
end

function SceneEntity:SetAttackType(type)
    self.__AttackType = type
end

function SceneEntity:GetAttackType()
    return self.__AttackType or -1
end

function SceneEntity:SetAlongPathLoop(is)
    self._alongPathLoop = is
end

function SceneEntity:GetAlongPathLoop()
    return self._alongPathLoop
end

function SceneEntity:GetHFSMKeyValue(key)
    local ret = nil
    if self.ai_fsm then
        ret = self.ai_fsm:GetKeyValue(key)
    end
    return ret
end

function SceneEntity:SetHFSMKeyValue(key, value)
    if self.ai_fsm then
        self.ai_fsm:SetKeyValue(key, value)
    end
end

function SceneEntity:SetHFSMMultiKeyValue(params)
    if self.ai_fsm then
        self.ai_fsm:SetMultiKeyValue(params)
    end
end

function SceneEntity:SetDoNotChangeTargetBeAttack(is)
    self._doNotChangeTargetBeAttack = is
end

function SceneEntity:GetDoNotChangeTargetBeAttack()
    return self._doNotChangeTargetBeAttack
end


function SceneEntity:SetCloseGroupDetectFunc(close)
    self._closeGroupFunc = close
end

function SceneEntity:GetCloseGroupDetectFunc()
    return self._closeGroupFunc
end

function SceneEntity:RecoredInsideEntity()

    if self._insideEntityNames ~= nil then return end

    self._insideEntityNames = {}

    self.object:set_on_trigger_enter(self.bindfunc["OnTriggerEnter"])
    self.object:set_on_trigger_exit(self.bindfunc["OnTriggerExit"])
end

function SceneEntity:OnTriggerEnter(otherObj, curObj)
    self._insideEntityNames[otherObj:get_name()] = 1
end

function SceneEntity:OnTriggerExit(otherObj, curObj)
    self._insideEntityNames[otherObj:get_name()] = nil
end

function SceneEntity:GetInsideEntityNames()
    return self._insideEntityNames
end

function SceneEntity:InitHatredValue()

    if self.hatredValueInfo ~= nil then return end

    self.hatredValueInfo = {}
end

function SceneEntity:IsHatredValueLockTarget()
    return self.hatredValueInfo ~= nil
end

-- 攻击者, 减少多少血量
function SceneEntity:CalHatredValue(attacker, value)
    if attacker == nil or type(value) ~= 'number' then
        return
    end

    local attackName = attacker:GetName()

    local now = app.get_time()
    local hatredInfo = self.hatredValueInfo[attackName]
    if hatredInfo == nil then
        hatredInfo = {}
        hatredInfo.value = 0
        hatredInfo.lastBeAttackedTime = 0
        self.hatredValueInfo[attackName] = hatredInfo
    elseif now - hatredInfo.lastBeAttackedTime > AIStateConstVar.hatredValueResetTime then
        hatredInfo.value = 0
    end

    hatredInfo.lastBeAttackedTime = now

    hatredInfo.value = hatredInfo.value + value
end

function SceneEntity:GetHatredValueInfo()
    return self.hatredValueInfo
end


------------debug func-------------
function SceneEntity:log(log)
    table.insert(self.__log, log)
end

function SceneEntity:ClearLog()
    self.__log = {}
end

function SceneEntity:GetObjLog()

    local str = ''

    if type(self.__log) == 'table' then
        for k,v in pairs(self.__log) do
            str = str .. '\n' .. v
        end
    end

    return str
end

function SceneEntity:GetObjHFSMState()
    local str = ''
    if self.ai_fsm ~= nil then
        str = tostring(self.__ai_id) .. ' '
        str = str .. self.ai_fsm:GetCurrentStateName()
    end
    return str 
end

--越小优选级越高
function SceneEntity:SetBeAttackOrder(order)
    self.__beAttackOrder = order
end

function SceneEntity:GetBeAttackOrder()
    return self.__beAttackOrder or 10000
end