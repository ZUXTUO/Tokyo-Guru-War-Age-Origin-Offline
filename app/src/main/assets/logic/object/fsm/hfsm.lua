-- region NewFile_1.lua
-- Author : kevin
-- Date   : 2015/7/15
-- 此文件由[BabeLua]插件自动生成

HFSM = Class("HFSM")

local __HFSM_keyValues = {}

function HFSM:HFSM(parm)
    self.states = nil
    self.currState = nil
    self.nextState = nil
    self.object = parm.object
    -- 防止object无法释放， fsm挂接在object上运行。
    self.name = parm.name
    self.log = parm.log
end

function HFSM:Finalize()
    self:Close()
end

-- stateName = 'stateName'
function HFSM:Load(stateName)
    
    -- if self.object:IsMonster() then
    --     return;
    -- end


    states = _G[stateName]
    if states==nil then
        app.log("hfsm can't load file: " .. stateName .. ' ' .. type(stateName))
        return
    end
    self.name = stateName
    self.states = { }
    local s = nil
    for k, v in pairs(states) do
        s = {} --FSMState:new()
        s.data = v
        if v.subFSM ~= nil then
            self:SetAllSubFSM(s, v.subFSM)
        elseif v.subFSMKey ~= nil then
            self:SetAllSubFSMKey(s, v.subFSMKey)
        end

        if v.default == true then
            self.currState = nil
            self.nextState = s

            self.stateEntry = s
        end

        if v.state ~= nil then
            self:SetStateAllFunc(s, v.state)
        elseif v.stateKey ~= nil then
            self:SetStateAllFuncKey(s, v.stateKey)
        end
        s.name = v.name
        self.states[v.name] = s
    end

    if self.nextState == nil then
        app.log("no default state!!!!!!")
    end
end

function HFSM:SetAllSubFSMKey(s, subFSMKeys)

    if type(subFSMKeys) == 'table' then
        for k,v in ipairs(subFSMKeys) do
            local value = self:GetKeyValue(v)
            if value ~= nil then
                self:SetAllSubFSM(s, value)
            end
        end
    else
        local value = self:GetKeyValue(subFSMKeys)
        if value ~= nil then
            self:SetAllSubFSM(s, value)
        end
    end

end

function HFSM:SetAllSubFSM(s, subFSMNames)

    s.subFSMs = s.subFSMs or {}

    if type(subFSMNames) == 'table' then
        for k,v in ipairs(subFSMNames) do
            self:SetSbuFSM(s.subFSMs, v)
        end
    else
        self:SetSbuFSM(s.subFSMs, subFSMNames)
    end
end

function HFSM:SetSbuFSM(fsms, subName)
    local fsm = HFSM:new({object=self.object, name = "_subFsm:" .. subName, log = self.log})
    fsm:Load(subName) 
    table.insert(fsms, fsm)
end

function HFSM:SetStateAllFuncKey(s, keys)
    if s == nil or keys == nil then return end

    if type(keys) == 'table' then
        for k,v in ipairs(keys) do
            self:SetStateAllFunc(s, self:GetKeyValue(v))
        end
    else
        self:SetStateAllFunc(s, self:GetKeyValue(keys))
    end
end

function HFSM:SetStateAllFunc(s, name)
    if s == nil or name == nil then return end

    s.actions = s.actions or {}

    if type(name) == 'table' then
        
        for k,v in ipairs(name) do
            self:SetStateFunc(s.actions, v)
        end

    else
        self:SetStateFunc(s.actions, name)
    end

end

function HFSM:SetStateFunc(s, name)
    local act = {}

    local state = _G[name]
    act.stateEnterFun = state.OnEnter
    act.stateUpdateFun = state.OnUpdate
    act.stateExitFun = state.OnExit

    table.insert(s, act)
end

--function HFSM:Reload(stateName)
    --self:Close()
    --local name =  self.name
    --self:Load(name)
--end

-- data = {key=, key = , ...}
function HFSM:SetMultiKeyValue(data)
    if type(data) ~= 'table' then
        return
    end

    for k,v in pairs(data) do
        --app.log('SetMultiKeyValue ' .. k .. ' ' .. v)
        self:SetKeyValue(k,v)
    end
end

function HFSM:SetKeyValue(key, value)

    local name = self.object:GetName()

    if __HFSM_keyValues[name] == nil then
        __HFSM_keyValues[name] = {}
    end
    --app.log('SetKeyValue ' .. key .. ' ' .. value)
    __HFSM_keyValues[name][key] = value
end

function HFSM:GetKeyValue(key)

    local name = self.object:GetName()

    if __HFSM_keyValues[name] == nil then
        return nil
    end

    local value = __HFSM_keyValues[name][key]

--    if value==nil then
--        app.log("HFSM can't load key:" .. key)
--    end

    return value
end

function HFSM:ExistKey(key)
    local name = self.object:GetName()
    if __HFSM_keyValues[name] == nil or __HFSM_keyValues[name][key] == nil then
        return false
    end
    return true
end

function HFSM:ClearAllKeyValue()
    local name = self.object:GetName()

    __HFSM_keyValues[name] = {}
end

function HFSM:GetCurrentStateName()
    local name = ""
    if self.currState ~= nil then
        name = name.." " .. self.currState.name

        if self.currState.subFSMs ~= nil then
            name = name.." "..self.currState.subFSMs[1]:GetCurrentStateName()
        end
    end

    return name
end

function HFSM:Update(dt)

    -- if self.object:IsMonster() then
    --     return;
    -- end
    -- --if true then return end

    if self.object == nil then
        app.log('self.object == nil')
        return
    end

    if self.currState == nil then
        if self.nextState ~= nil then
            self:Enter()
        else 
            app.log_warning("fsm self.currState == nil and self.nextState == nil ".. tostring(self.object:GetName()))
            return
        end
    end

    --while true do
        for k, v in pairs(self.currState.data.transitions) do
            if v.condition == nil then
                --app.log("nil condition" .. table.tostring(self.currState))
                break
            end
            --if v.condition(self.object) then
            if self:CheckConditions(v.condition, 1, true) then
                local nextState = self.states[v.to]
                if nil == nextState then
                    app.log("state missed:" .. v.to)
                    break;
                end

                self.nextState = nextState

                break
            end
        end

        if self.nextState == nil then
            if self.currState.subFSMs == nil then
                if self.currState.actions ~= nil then
                    for k,act in ipairs(self.currState.actions) do
                        if act.stateUpdateFun then
                            act.stateUpdateFun(self.object, dt)
                        end
                    end
                end
            else
                if self.currState.subFSMs ~= nil then
                    local fsms = self.currState.subFSMs
                    for k,subFSM in ipairs(fsms) do
                        subFSM:Update(dt)
                    end
                end
            end

            --break
        else
            if nil ~= self.currState then
                self:Exit()
            end
            self:Enter()
        end
    --end
end

function HFSM:Enter()
    self.currState = self.nextState
    self.nextState = nil

    if self.currState.actions ~= nil then
        for k,act in ipairs(self.currState.actions) do
            if act.stateEnterFun then
                act.stateEnterFun(self.object)
            end
        end
    end
    -- if self.log == true then
    --     self.object:log(string.format("%s fsm:%s actived.", self.object:GetName(), self.name .. " " .. self.currState.name))
    -- end
    --[[
    local name = self.object:GetName()
    if self.object:IsHero() then
         app.log(string.format("#%s#[%f]%s %d fsm:%s %s actived.", string.sub(name, string.len(name) - 3), app.get_time(), name, self.object.__ai_id, self.name, self.currState.name))
    end
    ]]

    if self.currState.subFSMs ~= nil then
        local fsms = self.currState.subFSMs
        for k,subFSM in ipairs(fsms) do
            subFSM.nextState = subFSM.stateEntry
            -- if self.log == true then
            --     self.object:log('enter sub fsm: ' .. subFSM.name .. ' ' .. tostring(subFSM.nextState))
            -- end
            subFSM:Enter()
        end
    end
end 

function HFSM:Exit()
    -- if self.log == true then
    --     self.object:log(string.format("%s fsm:%s Deactived.", self.object:GetName(), self.name .. " " .. self.currState.name))
    -- end

    if self.currState.actions ~= nil then
        for k,act in ipairs(self.currState.actions) do
            if act.stateExitFun then
                act.stateExitFun(self.object)
            end
        end
    end

    if self.currState.subFSMs ~= nil then
        local fsms = self.currState.subFSMs
        for k,subFSM in ipairs(fsms) do
            subFSM:Exit()
        end
    end
    self.currState = nil
end

function HFSM:Close()
    if self.currState ~= nil then
        self:Exit()
    end
end

function HFSM:ReOpen()
    self.nextState = self.stateEntry
end

function HFSM:IsEntered()
    return self.currState ~= nil
end

function HFSM:SubFSMIsEnd()
    if self.currState.subFSMs ~= nil then
        local isEnd = true
        local fsms = self.currState.subFSMs
        for k,subFSM in ipairs(fsms) do
            isEnd = isEnd and subFSM.currState ~= nil and subFSM.currState.name == 'Exit'

            if isEnd == false then
                break
            end
        end

        return isEnd
    end
    return false
end

function HFSM:CheckConditions(condition, index, needEval)
    local con = condition[index]
    --if #condition > 0 then
        if con then
        --if type(con) == 'function' then
            return con(self, condition, index + 1, needEval) --param contition,nextUseIdx, needEval; return resutl, nextUseIdx
        -- else
        --     app.log("CheckConditions condition==nil " .. self.currState.name .. ' ' .. tostring(index) .. ' ' .. tostring(con) .. ' ' .. table.tostring(condition))
        end
    --end
    return true, index
end

function HFSM:_funcall_(condition, index, needEval)
    local fun = condition[index]
    if fun == nil and needEval == true then
        app.log("funcall fun == nil " .. self.currState.name .. ' ' .. tostring(index) .. ' ' .. table.tostring(condition))
    end
    local paramNum = condition[index + 1]

    if paramNum == 0 then
        if needEval == true then
            return fun(self.object, self),index+2
        else
            return true, index+2
        end

    else
        local nxi = index + 2
        local param = nil
        local params = {}
        for i=1, paramNum do
            param, nxi = self:CheckConditions(condition, nxi, needEval)
            params[i] = param
        end
        if needEval == true then
            return fun(self.object, params, self), nxi
        else
            return true, nxi
        end
    end
end

function HFSM:_const_immediate_(condition, index, needEval)
    return condition[index], index + 1
end

function HFSM:_immediate_(condition, index, needEval)
    return self[condition[index]], index + 1
end

function HFSM:_strparam_(condition, index, needEval)
    return condition[index], index + 1
end

function HFSM:_not_(condition, index, needEval)
    local r, nxi = self:CheckConditions(condition, index, needEval)
    return not r, nxi
end

function HFSM:_unaryadd_(condition, index, needEval)
    local r, nxi = self:CheckConditions(condition, index, needEval)
    return r, nxi
end

function HFSM:_unarysub_(condition, index, needEval)
    local r, nxi = self:CheckConditions(condition, index, needEval)
    return -1 * r, nxi
end

function HFSM:_and_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    if ra == false then
        needEval = false
    end
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra and rb , nix
     
end

function HFSM:_or_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    if ra == true then
        needEval = false
    end
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra or rb , nix
     
end

function HFSM:_less_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra < rb , nix
end
function HFSM:_lessorequal_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra <= rb , nix
end
function HFSM:_greater_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)

    return ra > rb , nix
end
function HFSM:_greaterorequal_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)

    return ra >= rb , nix
end
function HFSM:_equal_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra == rb , nix
end
function HFSM:_notequal_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra ~= rb , nix
end
function HFSM:_add_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra + rb , nix
end
function HFSM:_sub_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra - rb , nix
end
function HFSM:_mul_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra * rb , nix
end
function HFSM:_div_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra / rb , nix
end
function HFSM:_mod_(condition, index, needEval)
    local ra, nix = self:CheckConditions(condition, index, needEval)
    local rb, nix = self:CheckConditions(condition, nix, needEval)
    
    return ra % rb , nix
end


-- endregion
