--[[
region buffex.lua
date: 2015-8-3
time: 11:52:14
author: Nation
BUFF对象
]]

BuffEx = Class(BuffEx)
function BuffEx:InitData(buffBaseData, buffLevelData, skillCreatorName, buffCreatorName, nestTimes, buffOwner, skillGID, directCallBack, delay, skillID, skillLevel, defaultTarget, overlap)
    self._prepared = true
	self._buffBaseData = buffBaseData
	self._buffLevelData = buffLevelData
	self._skillCreator = skillCreatorName
	self._buffCreator = buffCreatorName
	self._buffOwner = buffOwner
    self._attachFrame = PublicFunc.QueryCurTime()
    self._nestTimes = nestTimes
    self._buffGID = PublicStruct.Buff_GID_Creator
    PublicStruct.Buff_GID_Creator = PublicStruct.Buff_GID_Creator + 1
    if overlap then
        self._overlapNum = overlap
    else
        self._overlapNum = 1
    end
    self._buffState = nil
    self._arrTrigger = {}
    self._bImmediatelyDetach = false
    self._skillGid = skillGID
    self._arrThirdTarget = {}
    self._directCallBack = directCallBack
    self._positionCallBack = nil
    self._recordPosition = {}
    local skillCreator = ObjectManager.GetObjectByName(self._skillCreator)
    if skillCreator then
        if skillCreator == self._buffOwner then
            self.ability_change_from = ENUM.AbilityChangeFrom.Self
        elseif skillCreator and skillCreator:IsEnemy(self._buffOwner) then
            self.ability_change_from = ENUM.AbilityChangeFrom.Enemy
        else
            self.ability_change_from = ENUM.AbilityChangeFrom.Friend
        end
    end
    if self._buffLevelData.skillid ~= nil then
        skillID = self._buffLevelData.skillid
        if skillCreator then
            local skill = skillCreator:GetSkillBySkillID(skillID)
            if skill then
                skillLevel = skill._skillLevel
            else
                skillLevel = 1
            end
        else
            skillLevel = 1
        end
    end
    self._skillID = skillID
    self._skillLevel = skillLevel
    self._defaultTarget = defaultTarget
    self.duration = self._buffLevelData.duration
    if self._buffLevelData.durationweak ~= nil then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if buffOwner:IsAIAgent() then
               self.duration = self._buffLevelData.durationweak
            end
        else
            if not buffOwner:IsMyControl() or (buffOwner:GetName() == g_dataCenter.fight_info:GetCaptainName() and buffOwner:GetAI() == ENUM.EAI.MainHeroAutoFight) or (buffOwner:IsMyControl() and buffOwner:GetName() ~= g_dataCenter.fight_info:GetCaptainName())then
                self.duration = self._buffLevelData.durationweak
            end
        end
    end
    if delay and self.duration and self.duration ~= 0 then
        self.duration = self.duration + delay
    end
	for i=1,buffLevelData.triggerSize do
		self:AddTrigger(i, buffLevelData.trigger[i], delay)
	end
    if buffLevelData.triggerSize == 0 then
        self._bImmediatelyDetach = true
    end
    self._triggerMutex = {}
    --local target = buffOwner:GetAttackTarget()
    --if target ~= nil then
    --    self._defaultTarget = target:GetName()
    --end
    --[[if self._buffOwner:IsMyControl() and self._buffBaseData.id ~= 1 then
        app.log(self._buffOwner:GetName().."添加BUFF id="..buffBaseData.id.." level="..buffLevelData.lv.." skillCreator="..tostring(skillCreatorName).." time="..self._attachFrame.." "..debug.traceback())
    end]]
    if self._skillCreator ~= self._buffOwner:GetName() then
        if skillCreator and skillCreator:IsEnemy(self._buffOwner) and (not skillCreator:IsDead()) and (not self._buffOwner:IsDead()) then
            if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
                skillCreator:ChangeFightStateTarget(self._buffOwner:GetName(), true, true, "使用技能攻击")
                self._buffOwner:ChangeFightStateTarget(self._skillCreator, false, true, "使用技能攻击")
            end
        end
    end
end

function BuffEx:Finalize()
    for i=1, self._buffLevelData.triggerSize do
        self._arrTrigger[i]:HandleRollBack()
    end
	for i=1, self._buffLevelData.triggerSize do
		delete(self._arrTrigger[i])
	end
    if self._isKey == true and self._srcSkill ~= nil then
        self._srcSkill._bIsWorking = false
    end
end

function BuffEx:AddTrigger(index, triggerData, delay)
	local newTrigger = TriggerEx:new( {data=triggerData, buff=self} )
    newTrigger._index = index
    newTrigger._delay = delay
	self._arrTrigger[index] = newTrigger
end

function BuffEx:GetFirstTrigger(trigger_type)
	for i=1, self._buffLevelData.triggerSize do
        if self._arrTrigger[i]:GetActiveType() == trigger_type then
            return self._arrTrigger[i]
        end
	end
    return nil
end


function BuffEx:GetDuration()
    return self.duration
end

function BuffEx:GetDEltaTime()
    return PublicFunc.QueryDeltaTime(self._attachFrame)
end


function BuffEx:OnTick()
    if self._buffState == eBuffState.Detached then
        return
    end
    --[[if self._buffOwner:GetCampFlag() == 2 then
        app.log(self._buffOwner:GetName().."BUFF:OnTick id="..self._buffBaseData.id.." level="..self._buffLevelData.lv.." frame="..PublicStruct.Cur_Logic_Frame)
    end]]
    if self.duration > 0 and PublicFunc.QueryDeltaTime(self._attachFrame) > self.duration and self._buffState == eBuffState.Run then
        -- if self._overlapNum > 1 then
        --     self:DelOverlap()
        -- else
        --app.log(self._buffOwner:GetName().." buff 到期id="..self._buffBaseData.id.." level="..self._buffLevelData.lv)
            self._overlapNum = 0
            self:SetState(eBuffState.Detach)
        -- end
    end
    if self._buffState == eBuffState.Detach and self._bImmediatelyDetach then
        self:SetState(eBuffState.Detached)
    else
        local bFinish = true
        for i=1, self._buffLevelData.triggerSize do
		    self._arrTrigger[i]:OnTick()
            if self._arrTrigger[i]._bFinish == false then
                bFinish = false
            end
	    end
        if bFinish == true and self._buffLevelData.triggerSize > 0 then
            if self._buffState == eBuffState.Detach then
                self:SetState(eBuffState.Detached)
            elseif self._buffState == eBuffState.Run and self.duration == 0 then
                if self._overlapNum > 1 then
                    self:DelOverlap()
                else
                    self._overlapNum = 0
                    self:SetState(eBuffState.Detach)
                end
            end
        end
    end
end

function BuffEx:GetBuffID()
	return self._buffBaseData.id
end


function BuffEx:GetBuffLv()
	return self._buffLevelData.lv
end

function BuffEx:GetIcon()
    return self._buffLevelData.icon
end

function BuffEx:GetBuffGroupID()
	return self._buffBaseData.buffgroup
end

function BuffEx:GetOverlapType()
    return self._buffLevelData.overlap
end

function BuffEx:OnAttach()
    self:CheckAttentionSkill();
    self:OnTick()
    self:SetState(eBuffState.Run)
end

function BuffEx:OnDetach()
    self:CheckAttentionSkill();
    self:OnTick()
end

function BuffEx:IsALive()
    --if self._buffState == eBuffState.Detached then
    --    return false
    --end
    return self._overlapNum > 0
end

function BuffEx:SetState(state, force)
    if self._buffState == state then
        return
    end
    if self._buffState == eBuffState.Detached and force ~= true then
        return
    end
	self._buffState = state
   --[[ if state == eBuffState.Detached then
        app.log(self._buffOwner:GetName().." buff Detached id="..self._buffBaseData.id.." level="..self._buffLevelData.lv)
    end]]
    if state == eBuffState.Attached then
        self:OnAttach()

        PublicFunc.msg_dispatch(BuffManager.AttachBuff, self._buffOwner, self._buffGID)
    elseif state == eBuffState.Detach then
        self:OnDetach()

        PublicFunc.msg_dispatch(BuffManager.DetachBuff, self._buffOwner, self._buffGID)
        --[[if not self._buffOwner:IsMyControl() and self._buffBaseData.id ~= 1 then
            app.log(self._buffOwner:GetName().."移除BUFF id="..self._buffBaseData.id.." level="..self._buffLevelData.lv.." time="..PublicFunc.QueryCurTime().." "..debug.traceback())
        end]]
    elseif state == eBuffState.Detached then

        for i=1, self._buffLevelData.triggerSize do
            self._arrTrigger[i]:HandleRollBack()
        end
    end
end

function BuffEx:GetOverLap()
    return self._overlapNum
end


function BuffEx:AddOverLap()
    --[[if self._buffOwner:GetCampFlag() == 1 then
        app.log(self._buffOwner:GetName().."添加层数 id="..self._buffBaseData.id.." level="..self._buffLevelData.lv.." frame="..PublicStruct.Cur_Logic_Frame.." "..debug.traceback())
    end]]
    if self._buffLevelData.maxoverlap == nil then
        self._overlapNum = self._overlapNum + 1
        self:Reset()
    else
        if self._overlapNum < self._buffLevelData.maxoverlap then
            self._overlapNum = self._overlapNum + 1
            self:Reset()
        else
            self._attachFrame = PublicFunc.QueryCurTime()
        end
    end
end

function BuffEx:DelOverlap()
    self._attachFrame = PublicFunc.QueryCurTime()
    self._overlapNum = self._overlapNum - 1
    self:CheckAttentionSkill();
    self:SetState(eBuffState.Detach)
    self:SetState(eBuffState.Run, true)
end

function BuffEx:Reset()
    self._attachFrame = PublicFunc.QueryCurTime()
    for i=1, self._buffLevelData.triggerSize do
		self._arrTrigger[i]:Reset()
	end
    self:SetState(eBuffState.Attached)
end

function BuffEx:Is(propertybit)
    return ((bit.bit_and(self._buffLevelData.property, propertybit) ~= 0) and true or false)
end

function BuffEx:ResetTime()
    self._attachFrame = PublicFunc.QueryCurTime()
    --app.log(self._buffOwner:GetName().."重置BUFF时间 id="..self._buffBaseData.id.." level="..self._buffLevelData.lv.." "..debug.traceback())
end

function BuffEx:GetAttachTime()
    return self._attachFrame
end

function BuffEx:CheckAttentionSkill()
    if self._buffLevelData.attention_skill or self._buffLevelData.skillid then
        if self._buffOwner:GetName() == g_dataCenter.fight_info:GetCaptainName() then
            GetMainUI():UpdateSkillOverlap(self._buffOwner)
        end
    end
end
--[[endregion]]