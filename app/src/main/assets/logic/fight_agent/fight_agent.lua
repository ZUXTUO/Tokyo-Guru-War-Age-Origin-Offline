--[[
region fight_agent.lua
date: 2015-9-11
time: 19:6:50
author: Nation
]]
FightAgentInstance = nil
FightAgent = Class("FightAgent")

function FightAgent:FightAgent(data)
    self._arrFightScene = {}
end

function FightAgent:CreateFightScene(gid, agent_content)
    if self._arrFightScene[gid] ~= nil then
        app.log("已经存在同一id的场景代理实例")
    end
    self._arrFightScene[gid] = FightSceneAgent:new({_gid=gid, _agent_content=agent_content})
end
-----------------------------外部调用接口-----------------------------
--[[创建一个FightAgent实例]]
function CreateFightAgent()
    if FightAgentInstance ~= nil then
        app.log("已经存在战斗代理实例")
    end
    FightAgentInstance = FightAgent:new()
end

function DestroyFightAgent()
    if FightAgentInstance ~= nil then
        delete(FightAgentInstance)
        FightAgentInstance = nil
    end
end

function CreateFightScene(gid, agent_content)
    if FightAgentInstance then
        FightAgentInstance:CreateFightScene(gid, agent_content)
    end
end

function CreateFightObject(scene_gid, obj_gid, agent_content)
    if FightAgentInstance then
        if FightAgentInstance._arrFightScene[scene_gid] then
            FightAgentInstance._arrFightScene[scene_gid]:CreateFightObject(obj_gid, agent_content)
        end
    end
end
-----------------------------外部实现接口-----------------------------
--[[endregion]]