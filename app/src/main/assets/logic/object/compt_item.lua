

ComptItem = {}

function ComptItem.Remove(entity)
    if entity.__itemComponent ~= nil then
        delete(entity.__itemComponent)
        entity.__itemComponent = nil
    end
end

function ComptItem.Start(entity, param)
    if entity.__itemComponent then
        entity.__itemComponent:Start(param)
    end
end

--[[添加组件]] 
function ComptItem.Add(triggerId, entity)
    local triggerConfig = ConfigManager.Get(EConfigIndex.t_trigger_config, triggerId)
    if triggerConfig == nil then
        app.log('触发器不存在 triggerId = ' .. triggerId)
        return
    end
    local config = triggerConfig[1]
    local __component = nil
    if config.trigger_type ==  ENUM.E_TRIGGER_TYPE.TriggerEnterTimer then
        __component = ComptTimer:new(entity)
    elseif config.trigger_type ==  ENUM.E_TRIGGER_TYPE.TriggerEnterAreaRandomItem then
        __component = ComptGrenadeArea:new(entity)
    end
    if __component ~= nil then
        entity.__itemComponent = __component
    end
end

function ComptItem.AddGrenade(entity)
    entity.__itemComponent = ComptGrenade:new(entity)
    ComptItem.SetBuffPara(entity, 1001, 5)
end

function ComptItem.SetBuffPara(entity, id, lv)
    if entity.__itemComponent then
        entity.__itemComponent.buffId = id
        entity.__itemComponent.buffLv = lv
    end
end

function ComptItem.AttachBuff(entity)
    local item = entity.__itemComponent
    if item == nil or item.buffId == nil or item.buffLv == nil then
        return
    end
    if TRIGGER_DEBUG then
        app.log('ComptItem.AttachBuff  id = ' .. item.buffId ..' lv = ' .. item.buffLv)
    end
    entity:AttachBuff(item.buffId, item.buffLv, entity:GetName(), entity:GetName())
end