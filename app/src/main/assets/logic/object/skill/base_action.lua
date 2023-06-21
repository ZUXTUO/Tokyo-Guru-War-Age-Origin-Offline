--[[
region base_action.lua
date: 2015-8-3
time: 11:53:10
author: Nation
技能效果器基类
]]
--[[endregion]]
BaseAction = Class(BaseAction)
function BaseAction:Init(actionInfo)
    self._actionData = actionInfo.data
    self._buffOwner = actionInfo.buff._buffOwner
    self._buff = actionInfo.buff
    self._trigger = actionInfo.trigger
    self._actionState = eBuffActionState.Begin
    self._beginFrame = 0
    self._callBackRef = 0
    self._attachBuffTargets = {}
    self._effectUUID = -1
    self._beforeMovePos = nil
    self._cbFunction = nil
    self._cbData = nil
    self._value = 0
    self._values = {}
    self._actionTimes = 0
    self._finalize = false
    self._success = false
    self._handle_roll_back = false
end

function BaseAction:Finalize()
    self._buff = nil
    self._trigger = nil
    self._actionData = nil
    self._buffOwner = nil
    self._attachBuffTargets = nil
    self._cbFunction = nil
    self._cbData = nil
    self._value = nil
    self._finalize = true
end

function BaseAction:HandleRollBack()
    if self._handle_roll_back then
        return
    end
    if self._actionData and self._actionData.rollback == true and self._actionTimes ~= 0 then
        self:RollBack()
        self._handle_roll_back = true
    end
end


function BaseAction:Reset()
    self._actionState = eBuffActionState.Begin
end

function BaseAction:RunAction(force, actionTimes)
    if self._finalize then
        self._actionState = eBuffActionState.Over
        return false
    end
    if self._actionState == eBuffActionState.Begin or force then
        if self._actionData.condition ~= nil then
            local srcobj = self._buffOwner
            if SkillCTree.CheckCondition(g_SkillConditionData[self._actionData.condition], srcobj, nil, self._trigger) ~= true then
                self._actionState = eBuffActionState.Over
                return false
            end
        end
        local probability = 1
        if self._actionData.actionodds then
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                if self._buff then
                    local creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if creator then
                        local skill = creator:GetSkillBySkillID(self._buff._skillID)
                        if skill then
                            probability = skill.action_odds/100
                            skill.action_odds = (skill.action_odds+70)%100
                        elseif self._buff.action_odds then
                            probability = self._buff.action_odds/100
                            self._buff.action_odds = (self._buff.action_odds+70)%100
                        end
                    end
                end
            else
                probability = math.random()
            end
        end
        if self._actionData.actionodds == nil or probability <= self._actionData.actionodds then
            if actionTimes == nil then
                self._actionTimes = self._actionTimes + 1
            end
            self._beginFrame = PublicFunc.QueryCurTime()
            return true
        else
            self._actionState = eBuffActionState.Over 
            if self._actionData.fail_buffid and self._actionData.fail_bufflv then
                self._buffOwner:AttachBuff(self._actionData.fail_buffid, self._actionData.fail_bufflv, self._buff._skillCreator, self._buffOwner:GetName(), nil, self._buff._skillGid, nil, nil, self._buff._skillID, self._buff._skillLevel, self._buff._defaultTarget, nil, false, nil)
            end
            return false
        end
    end
    return false
end

function BaseAction:RollBack()
end
