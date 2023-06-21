--[[
region fight_scene_agent.lua
date: 2015-9-14
time: 11:11:56
author: Nation
]]
FightSceneAgent = Class("FightSceneAgent")
function FightSceneAgent:FightSceneAgent(data)
    self._content = data._agent_content
    self._gid = data._gid
end

function FightSceneAgent:CreateFightObject(obj_gid, agent_content)
    self._content = data._agent_content
    self._gid = data._gid
end
--[[endregion]]