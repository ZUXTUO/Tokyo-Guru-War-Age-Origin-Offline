--[[
file	state.lua
author	dengchao
time	2015.3.24

]]--

FSM = Class("FSM")
-----------------------
function EnumState(t, name)
    local stateEnum = { }
    local _mt = {
        __index = function(_, key)
            if t[key] then
                return key
            else
                app.log(name .. '不存在的枚举值. ' .. key .. table.tostring(t))
                return ''
            end
        end
    }
    setmetatable(stateEnum, _mt)
    return stateEnum
end
-----------------------
function FSM:Init(obj)
    self.m_obj = obj
    self.m_currentState = nil
    self.m_stateTree = nil
    self.m_stateName = ''
end
function FSM:Register(stateTree)
    self.m_stateTree = stateTree
end
function FSM:SetState(stateName)
    local objName = '';
    if self.m_obj ~= nil and self.m_obj.GetName ~= nil then
        objName = tostring(self.m_obj:GetName())
    end
     --app.log(string.format("SetState role %s 状态设置 %s", objName, tostring(stateName)));


    local state = self.m_stateTree[stateName]
    if state and self.m_currentState ~= state then
        if self.m_currentState then			
            self.m_currentState.OnEnd(self.m_obj)
        end
        self.m_stateName = stateName
        self.m_currentState = state
        self.m_currentState.OnBegin(self.m_obj)
		 --app.log(string.format("role %s 状态设置 %s", objName, tostring(stateName)));
    else
        -- if self.m_stateName ~= 'Stand' then
         --app.log_warning(string.format("role %s 状态设置无效, curt:%s, new:%s,%s", objName, self.m_stateName, tostring(stateName),debug.traceback()));
        -- end
    end
end
function FSM:SetNextState(stateName)
    self.nextState = stateName
end
function FSM:GetState()
    return self.m_stateName
end
function FSM:Update(deltaTime)
    -- if self.nextState then
    --     local nextState = self.nextState
    --     self.nextState = nil
    --     self:SetState(nextState)
    -- end
    if self.m_currentState then
        return self.m_currentState.OnUpdate(self.m_obj, deltaTime);
    end
end
return FSM
