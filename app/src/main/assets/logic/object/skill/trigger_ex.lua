--[[
region trigger_ex.lua
date: 2015-8-3
time: 11:46:28
author: Nation
BUFF触发器
]]

TriggerEx = Class(TriggerEx)
function TriggerEx:Init(triggerInfo)
    self._bDestroy = false
	self._triggerData = triggerInfo.data
    self._triggerData.triggertype = eBuffActionTriggerType.Sequence
    self._arrAction = {}
	self._attachFrame = PublicFunc.QueryCurTime()
    self._activeRefCount = 0
    self._lastUpdateFrame = 0
    if self._triggerData.immediately == false then
        self._lastUpdateFrame = PublicFunc.QueryCurTime()
    end
    
    self._arrThirdTarget = {}
    self._arrCallBackTarget = {}
    self._bFinish = false
    self._index = 0
    self._delay = 0
    self._bRunDetach = false
    self._buff = triggerInfo.buff
    if self._buff._buffLevelData.ignore_anim_end == nil then
        self._buff.ignore_anim_end = true
    end
    if self._triggerData.actionSize == 0 then
        self._bFinish = true
    else
	    for i=1, self._triggerData.actionSize do
            local actionCreator = ACTION_CREATOR[self._triggerData.action[i].atype]
            if actionCreator then
		        local newAction = ACTION_CREATOR[self._triggerData.action[i].atype]:new({data=self._triggerData.action[i], buff=triggerInfo.buff, trigger=self})
		        self._arrAction[i] = newAction
            else
                app.log("缺少效果器 id="..self._triggerData.action[i].atype)
            end
	    end
    end
    if self._triggerData.activetype == eBuffTriggerActiveType.Detach then
        self._bFinish = true
    end
end

function TriggerEx:GetLastUpdateTime()
    return self._lastUpdateFrame
end

function TriggerEx:GetIntervalTime()
    return self._triggerData.interval
end

function TriggerEx:Finalize()
    if self._bDestroy then
        return
    end
	for i=1, self._triggerData.actionSize do
		delete(self._arrAction[i])
	end
    self._bDestroy = true
    self._arrAction = nil
    self._arrThirdTarget = nil
    self._arrCallBackTarget = nil
    if self._immuneAllControl then
        self._immuneAllControl:HandleRollBack()
        delete(self._immuneAllControl)
        self._immuneAllControl = nil
    end
end

function TriggerEx:HandleRollBack()
    for i=1, self._triggerData.actionSize do
        self._arrAction[i]:HandleRollBack()
    end
end
function TriggerEx:GetActiveType()
	return self._triggerData.activetype
end

function TriggerEx:OnTick()
    if self._triggerData.group ~= nil then
        if self._buff._triggerMutex[self._triggerData.group] ~= nil and self._buff._triggerMutex[self._triggerData.group] ~= self._index then
            self._bFinish = true
            return
        end
    end
    if self._triggerData.activetype == eBuffTriggerActiveType.Attach then
        if self._buff._buffState == eBuffState.Attached then
            if self._triggerData.condition == nil then
                self._activeRefCount = self._activeRefCount + 1
            else
                local srcobj = self._buff._buffOwner
                local desobj = srcobj:GetAttackTarget()
                if SkillCTree.CheckCondition(g_SkillConditionData[self._triggerData.condition], srcobj, desobj, self._buff) == true then
                    self._activeRefCount = self._activeRefCount + 1
                    if self._triggerData.group ~= nil then
                        self._buff._triggerMutex[self._triggerData.group] = self._index
                    end
                else
                    self._bFinish = true
                end
            end
        elseif self._buff._buffState == eBuffState.Detach then
            self._bFinish = true;
        end
    elseif self._triggerData.activetype == eBuffTriggerActiveType.Detach then
        if self._buff._buffState == eBuffState.Detach and self._bRunDetach == false then
            self._bFinish = false
            if self._triggerData.condition == nil then
                self._activeRefCount = self._activeRefCount + 1
            else
                local srcobj = self._buff._buffOwner
                local desobj = srcobj:GetAttackTarget()
                if SkillCTree.CheckCondition(g_SkillConditionData[self._triggerData.condition], srcobj, desobj, self._buff) == true then
                    self._activeRefCount = self._activeRefCount + 1
                    if self._triggerData.group ~= nil then
                        self._buff._triggerMutex[self._triggerData.group] = self._index
                    end
                else
                    self._bFinish = true
                end
            end
            self._bRunDetach = true
        end
    elseif self._triggerData.activetype == eBuffTriggerActiveType.Interval then
        local delta = PublicFunc.QueryDeltaTime(self._lastUpdateFrame)
        if (self._buff._buffState ~= eBuffState.Detach) and (delta > self._triggerData.interval) then
            local effect = false
            local srcobj = self._buff._buffOwner
            local desobj = srcobj:GetAttackTarget()
            if self._triggerData.condition == nil then
                effect = true
            elseif SkillCTree.CheckCondition(g_SkillConditionData[self._triggerData.condition], srcobj, desobj, self._buff) == true then
                effect = true
            end
            if effect then
                for i=1, self._triggerData.actionSize do
                    self._arrAction[i]._actionState = eBuffActionState.Begin
    	        end
                self._activeRefCount = self._activeRefCount + 1
            end
            if self._lastUpdateFrame == 0 then
                self._lastUpdateFrame = PublicFunc.QueryCurTime()
            else
                self._lastUpdateFrame = PublicFunc.QueryCurTime() - (delta-self._triggerData.interval)/1000
            end
        end
    elseif self._triggerData.activetype == eBuffTriggerActiveType.Delay then
        if self._buff._buffState == eBuffState.Run then
            
            local delay = self._triggerData.delay
            if self._delay and self._delay ~= 0 then
                delay = self._delay
            end
            if (self._bFinish == false) and (self._activeRefCount == 0) and (PublicFunc.QueryDeltaTime(self._attachFrame) > delay) then
                if self._triggerData.condition == nil then
                    self._activeRefCount = self._activeRefCount + 1
                else
                    local srcobj = self._buff._buffOwner
                    local desobj = srcobj:GetAttackTarget()
                    if SkillCTree.CheckCondition(g_SkillConditionData[self._triggerData.condition], srcobj, desobj, self._buff) == true then
                        self._activeRefCount = self._activeRefCount + 1
                        if self._triggerData.group ~= nil then
                            self._buff._triggerMutex[self._triggerData.group] = self._index
                        end
                    else
                        self._bFinish = true
                    end
                end
            end
        elseif self._buff._buffState == eBuffState.Detach and self._activeRefCount == 0 then
            self._bFinish = true
        end
    end
    if self._activeRefCount ~= 0 then
        if self._triggerData.triggertype == eBuffActionTriggerType.Sequence then
            local bGoNext = true
            for i=1, self._triggerData.actionSize do
                if bGoNext == true then
                    if self._arrAction[i]._actionData and self._arrAction[i]._actionData.attentionaction then
                        if self._arrAction[self._arrAction[i]._actionData.attentionaction] and self._arrAction[self._arrAction[i]._actionData.attentionaction]._success then
                            bGoNext = (self._arrAction[i]:RunAction() == eBuffActionState.Over)
                        else
                            bGoNext = true
                            self._arrAction[i]._actionState = eBuffActionState.Over
                        end
                    else
                        bGoNext = (self._arrAction[i]:RunAction() == eBuffActionState.Over)
                    end
                    --[[if self._buff:GetBuffID() == 51 and self._buff:GetBuffLv() == 1 then
                        app.log_warning("index="..i.." ret="..tostring(bGoNext).." time="..PublicFunc.QueryCurTime())
                    end]]
                    if self._buff._buffLevelData.ignore_anim_end and self._buff._buffLevelData.ignore_anim_end[1] == self._index and self._buff._buffLevelData.ignore_anim_end[2] == i then
                        self._buff.ignore_anim_end = true
                    end
                else
                    break
                end
	        end
            if bGoNext == true then
                self._activeRefCount = self._activeRefCount - 1
                if self._activeRefCount == 0 then
                    self._bFinish = true
                end
            end
        elseif self._triggerData.triggertype == eBuffActionTriggerType.All then
            for i=1, self._triggerData.actionSize do
                --[[if self._buff:GetBuffID() == 16 and self._buff:GetBuffLv() == 5 then
                    app.log("执行"..i.." "..table.tostring(self._arrAction[i]._actionData))
                end]]
                if self._arrAction[i]._actionData and self._arrAction[i]._actionData.attentionaction then
                    if self._arrAction[self._arrAction[i]._actionData.attentionaction] and self._arrAction[self._arrAction[i]._actionData.attentionaction]._success then
                        self._arrAction[i]:RunAction()
                    end
                else
                    self._arrAction[i]:RunAction()
                end
	        end
            self._activeRefCount = self._activeRefCount - 1
            if self._activeRefCount == 0 then
                self._bFinish = true
            end
        end
    end
end

function TriggerEx:Reset()
    self._attachFrame = PublicFunc.QueryCurTime()
	for i=1, self._triggerData.actionSize do
		self._arrAction[i]:Reset()
	end
end

function TriggerEx:ResetAllAction( beginAction )
    if self._bDestroy == true then
        return
    end
    if self._triggerData.triggertype == eBuffActionTriggerType.Sequence then
        local bStart = false
        if beginAction == nil then
            bStart = true
        end
        for i=1, self._triggerData.actionSize do
            if bStart == true then
		        self._arrAction[i]:Reset()
            else
                if self._arrAction[i] == beginAction then
                    bStart = true
                end
            end
	    end
    end
end

function TriggerEx:AddImmuneAllControl()
    if self._bDestroy then
        return
    end
    self._immuneAllControl = ImmuneStateAction:new({data={atype=22, type=immune_all_countrol_state, rollback=true}, buff=self._buff, trigger=self})
    self._immuneAllControl:RunAction()
end
--[[endregion]]