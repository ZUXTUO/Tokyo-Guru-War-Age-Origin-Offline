--[[
region fight_info.lua
date: 2015-10-10
time: 17:21:19
author: Nation
]]

FightInfo = Class("FightInfo")
function FightInfo:FightInfo(data)
    self.hero_list = { }
    self.monster_list = { };
    self.npc_list = { }
    self.base_name = { }
    self.boss_name = { }
    self.player_list = { }
    self.delay_load_hero = { }
    self.item_list = { }
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        self.hero_list[i] = { }
        self.npc_list[i] = { }
        self.monster_list[i] = { };
        self.base_name[i] = nil
        self.boss_name[i] = nil
        self.delay_load_hero[i] = { }
    end
    self.single_friend_flag = EFightInfoFlag.flag_a
    self.single_enemy_flag = EFightInfoFlag.flag_b
    self.left_3v3_flag = EFightInfoFlag.flag_a
    self.right_3v3_flag = EFightInfoFlag.flag_b
    self.neutrality_flag = EFightInfoFlag.flag_neutrality       --中立flag，双方都不会攻击该flag
    self.control_hero_list = { }
    self.captain_hero_name = nil
    self.captain_index = nil
    self.ai_agent_target_gid = { }
end

function FightInfo:AddHero(hero)
   

    local hero_name = hero:GetName()
    if hero:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        for i = 1, 3 do
            if self.control_hero_list[i] == hero_name then
                break
            elseif self.control_hero_list[i] == nil then
                self.control_hero_list[i] = hero_name

                ResourceManager.SetControlHeroReservedRes(i, self:GetControlHeroAssets(hero))
                break
            end
        end
        -- table.insert(self.control_hero_list, hero_name)
    end
    self.hero_list[hero:GetCampFlag()][hero_name] = hero_name
end

function FightInfo:GetControlHeroList()
    return self.control_hero_list
end

--function FightInfo:DelHero(hero)
--    local hero_name = hero:GetName()
--    if self.hero_list[hero:GetCampFlag()][hero_name] then
--        self.hero_list[hero:GetCampFlag()][hero_name] = nil
--    end
--end

function FightInfo:AddMonster(monster)

    if PropsEnum.IsSpecMonster(monster:GetConfigNumber()) then return end

    local monster_name = monster:GetName()
    self.monster_list[monster:GetCampFlag()][monster_name] = monster_name
    if monster:IsBasis() then
        self.base_name[monster:GetCampFlag()] = monster_name
    end
    if monster:IsBoss() then
        self.boss_name[monster:GetCampFlag()] = monster_name
    end
end

-- function FightInfo:DelMonster(monster)
--     local monster_name = monster:GetName()
--     if self.monster_list[monster:GetCampFlag()][monster_name] then
--         self.monster_list[monster:GetCampFlag()][monster_name] = nil
--     end
-- end

function FightInfo:AddNPC(npc)
    local npc_name = npc:GetName()
    self.npc_list[npc:GetCampFlag()][npc_name] = npc_name
end

function FightInfo:DelNPC(npc)
    local npc_name = npc:GetName()
    if self.npc_list[npc:GetCampFlag()][npc_name] then
        self.npc_list[npc:GetCampFlag()][npc_name] = nil
    end
end

function FightInfo:GetNPCByNPCID(id)
    for k,v in pairs(self.npc_list) do
        for _k, _v in pairs(v) do
            local npc = ObjectManager.GetObjectByName(_v)
            if npc.config.npc_id == id then
                return npc
            end
        end
    end
    return nil
end

function FightInfo:GetNearestNPC()
    local captain = self:GetCaptain()
    local captain_pos = captain:GetPosition()
    local nearest_dis = 999999
    local ret_npc = nil
    for k,v in pairs(self.npc_list) do
        for _k, _v in pairs(v) do
            local npc = ObjectManager.GetObjectByName(_v)
            local npc_pos = npc:GetPosition()
            local dis = algorthm.GetDistance(captain_pos.x, captain_pos.z, npc_pos.x, npc_pos.z)
            if dis < nearest_dis then
                nearest_dis = dis
                ret_npc = npc
            end
        end
    end
    return ret_npc
end


function FightInfo:AddItem(item)
    local name = item:GetName()
    self.item_list[name] = name
end

function FightInfo:GetAllItem()
    return self.item_list
end

function FightInfo:AddDelayLoadHero(camp_flag, id)
    -- app.log('AddDelayLoadHero ' .. tostring(flag) .. ' ' .. tostring(id) )
    local index = table.index_of(self.delay_load_hero[camp_flag], id)
    if index < 1 then
        table.insert(self.delay_load_hero[camp_flag], id)
    end
end

function FightInfo:DelDelayLoadHero(camp_flag, id)
    -- app.log('DelDelayLoadHero ' .. tostring(flag) .. ' ' .. tostring(id) )
    local index = table.index_of(self.delay_load_hero[camp_flag], id)
    if index > 0 then
        table.remove(self.delay_load_hero[camp_flag], index)
    end
end

function FightInfo:DeleteObj(obj_name)
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        if self.hero_list[i][obj_name] ~= nil then
            self.hero_list[i][obj_name] = nil
            --if i == self.single_friend_flag then
                for k, v in pairs(self.control_hero_list) do
                    if v == obj_name then
                        self.control_hero_list[k] = nil
                        if obj_name == self.captain_hero_name then
                            self.captain_hero_name = nil
                            self.captain_index = nil
                        end
                    end
                end
            --end
        elseif self.monster_list[i][obj_name] ~= nil then
            self.monster_list[i][obj_name] = nil
        elseif self.npc_list[i][obj_name] ~= nil then
            self.npc_list[i][obj_name] = nil
        end
    end

    if self.item_list[obj_name] then
        self.item_list[obj_name] = nil
    end
end

function FightInfo:SetCaptain(index)
    if self.captain_index and self.control_hero_list[self.captain_index] then
        local obj = ObjectManager.GetObjectByName(self.control_hero_list[self.captain_index])
        if obj then
            obj:SetCaptain(false)
        end
    end
    if self.control_hero_list[index] then
        self.captain_index = index
        self.captain_hero_name = self.control_hero_list[index]
        local obj = ObjectManager.GetObjectByName(self.captain_hero_name)
        if obj then
            obj:SetCaptain(true)
        end
    end
end

function FightInfo:GetAliveCaptaion()
    for k, v in pairs(self.control_hero_list) do
        local obj = ObjectManager.GetObjectByName(v)
        if obj and not obj:IsDead() then
            return k, obj
        end
    end
    return nil
end

function FightInfo:IsInControlHero(name)
    for k,controlName in ipairs(self.control_hero_list) do
        if controlName == name then
            return true
        end
    end
    return false
end

function FightInfo:GetCaptain()
    return ObjectManager.GetObjectByName(self.captain_hero_name)
end

function FightInfo:GetCaptainIndex()
    return self.captain_index
end

function FightInfo:GetCaptainName()
    return self.captain_hero_name
end

function FightInfo:GetControlHeroName(index)
    return self.control_hero_list[index]
end

function FightInfo:GetControlHero(index)
    -- app.log_warning("control hero name:"..tostring(index) .. ", "..tostring(self.control_hero_list[index]))
    return ObjectManager.GetObjectByName(self.control_hero_list[index])
end

function FightInfo:GetControlIndex(name)
    for k, v in pairs(self.control_hero_list) do
        if v == name then
            return k
        end
    end

    --app.log("FightInfo:GetControlIndex failed:" .. tostring(name) .. ' ' .. table.tostring(self.control_hero_list))

    return -1
end

function FightInfo:GetTeamMemberIndex(captainName)
    local ret = {}
    for k, v in pairs(self.control_hero_list) do
        if v ~= captainName then
            table.insert(ret, k)
        end
    end
    return ret
end

function FightInfo:ClearUp()
    self.hero_list = { }
    self.monster_list = { }
    self.npc_list = { }
    self.base_name = { }
    self.boss_name = { }
    self.player_list = { }
    self.delay_load_hero = { }
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        self.hero_list[i] = { }
        self.monster_list[i] = { }
        self.npc_list[i] = { }
        self.base_name[i] = nil
        self.boss_name[i] = nil
        self.delay_load_hero[i] = { }
    end
    self.single_friend_flag = EFightInfoFlag.flag_a
    self.single_enemy_flag = EFightInfoFlag.flag_b
    self.control_hero_list = { }
    self.captain_hero_name = nil
    self.captain_index = nil
    self.ai_agent_target_gid = { }
end

function FightInfo:GetHeroList(camp_flag)
    if camp_flag >= EFightInfoFlag.flag_a and camp_flag <= EFightInfoFlag.flag_max then
        return self.hero_list[camp_flag]
    end
    -- app.log("hero camp_flag="..camp_flag.." "..debug.traceback())
    return nil
end

function FightInfo:GetMonsterList(camp_flag)
    if camp_flag >= EFightInfoFlag.flag_a and camp_flag <= EFightInfoFlag.flag_max then
        return self.monster_list[camp_flag]
    end
    -- app.log("monster camp_flag="..camp_flag.." "..debug.traceback())
    return nil
end

function FightInfo:GetNPCList(camp_flag)
    if camp_flag >= EFightInfoFlag.flag_a and camp_flag <= EFightInfoFlag.flag_max then
        return self.npc_list[camp_flag]
    end
    -- app.log("npc camp_flag="..camp_flag.." "..debug.traceback())
    return nil
end

function FightInfo:GetDelayLoadHeroList(camp_flag)
    if camp_flag >= EFightInfoFlag.flag_a and camp_flag <= EFightInfoFlag.flag_max then
        return self.delay_load_hero[camp_flag]
    end
    -- app.log("delay laod hero camp_flag="..camp_flag.." "..debug.traceback())
end

function FightInfo:ClearHeroList()
    self.hero_list = { }
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        self.hero_list[i] = { }
    end
end

function FightInfo:ClearMonsterList()
    self.monster_list = { }
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        self.monster_list[i] = { }
    end
end 

function FightInfo:ClearNPCList()
    self.npc_list = { }
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        self.npc_list[i] = { }
    end
end

function FightInfo:GetBase(camp_flag)
    if camp_flag < EFightInfoFlag.flag_a or camp_flag > EFightInfoFlag.flag_max then
        app.log("base camp_flag=" .. camp_flag .. " " .. debug.traceback())
        return nil
    end
    if nil ~= self.base_name[camp_flag] then
        return ObjectManager.GetObjectByName(self.base_name[camp_flag]);
    else
        return nil
    end
end

function FightInfo:GetBoss(camp_flag)
    if camp_flag < EFightInfoFlag.flag_a or camp_flag > EFightInfoFlag.flag_max then
        app.log("boss camp_flag=" .. camp_flag .. " " .. debug.traceback())
        return nil
    end
    if nil ~= self.boss_name[camp_flag] then
        return ObjectManager.GetObjectByName(self.boss_name[camp_flag]);
    else
        return nil
    end
end

function FightInfo:foreach_obj(camp_flag, heroOrMonster, func)
    if nil == func or type(func) ~= "function" then
        return
    end
    if camp_flag < EFightInfoFlag.flag_a or camp_flag > EFightInfoFlag.flag_max then
        app.log("foreach_obj camp_flag=" .. camp_flag .. " " .. debug.traceback())
        return
    end

    local objList = heroOrMonster and self.hero_list[camp_flag] or self.monster_list[camp_flag]
    for k, v in pairs(objList) do
        func(v)
    end
end

function FightInfo:GetMyBase()
    return self:GetBase(self.single_friend_flag)
end

function FightInfo:IsHaveMonster(camp_flag)
    if camp_flag < EFightInfoFlag.flag_a or camp_flag > EFightInfoFlag.flag_max then
        app.log("IsHaveNpc camp_flag=" .. camp_flag .. " " .. debug.traceback())
        return
    end
    for k, v in pairs(self.monster_list[camp_flag]) do
        local entity = ObjectManager.GetObjectByName(v);
        if entity and not entity:IsDead() then
            return false;
        end
    end
    return true;
end

function FightInfo:IsHaveNpc(camp_flag)
    if camp_flag < EFightInfoFlag.flag_a or camp_flag > EFightInfoFlag.flag_max then
        app.log("IsHaveNpc camp_flag=" .. camp_flag .. " " .. debug.traceback())
        return
    end
    for k, v in pairs(self.npc_list[camp_flag]) do
        local entity = ObjectManager.GetObjectByName(v);
        if entity and not entity:IsDead() then
            return false;
        end
    end
    return true;
end

function FightInfo:GetAvgLevel(camp_flag)
    if camp_flag < EFightInfoFlag.flag_a or camp_flag > EFightInfoFlag.flag_max then
        app.log("IsHaveNpc camp_flag=" .. camp_flag .. " " .. debug.traceback())
        return
    end
    return g_dataCenter.player.level
end

function FightInfo:CheckAllControlHeroDead()
    local all_dead = true;
    local hero_table = {}
    for k, v in pairs(self.control_hero_list) do
        local hero = ObjectManager.GetObjectByName(v)
        if hero then
            table.insert(hero_table, hero)
            if not hero:IsDead() then
                all_dead = false
                break
            end
        end
    end
    if all_dead then
        for i=1, #hero_table do
            hero_table[i].mmo_fight_state_begin_time = 0;
        end
    end
end

function FightInfo:IsInFight()
    for k, v in pairs(self.control_hero_list) do
        local hero = ObjectManager.GetObjectByName(v)
        if hero then
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync --[[or FightScene.GetPlayMethodType() == nil]] then
                if PublicFunc.QueryDeltaTime(hero.mmo_fight_state_begin_time) < PublicStruct.MMO_LEAVE_FIGHT_STATE_TIME then
                    return true
                end
            else
                if hero.fight_state_targets_cnt > 0 then
                    return true
                end
            end
        end

    end
    return false
end

-- function FightInfo:GetControlHeroSkillAssets()
--     -- app.log("xxx:FightInfo:GetControlHeroSkillAssets"..table.tostring(self:GetControlHeroList()))
--     local assetPaths = { }
--     for i = 1, #self.control_hero_list do
--         local obj = self:GetControlHero(i)
--         if obj then
--             local icons = obj:GetLearnSkillAssets()
--             if icons then
--                 for ki, vi in pairs(icons) do
-- --                    app.log("xxx:" .. tostring(vi))
--                     table.insert(assetPaths, vi)
--                 end
--             end
--         end
--     end

--     return assetPaths;
-- end

-- function FightInfo:GetControlHeroModelAssets()
--     local assets_file_list = {}
--     app.log_warning("============================>>>>>>> GetControlHeroModelAssets.")
--     for k, v in pairs(self.control_hero_list) do
--         local obj = self:GetControlHero(k)
--         if obj then
--             local file_name = ObjectManager.GetHeroModelFileByModelId(obj:GetModelID())
--             table.insert(assets_file_list, file_name)
--         else
--             app.log_warning("@@@@@@@@@@  obj not found........");
--         end
--     end
--     return assets_file_list
-- end

function FightInfo:GetControlHeroAssets(obj)
    local assets_file_list = {}
    if obj then
        local file_name = ObjectManager.GetHeroModelFileByModelId(obj:GetModelID())
        table.insert(assets_file_list, file_name)

        local icons = obj:GetLearnSkillAssets()
        if icons then
            for ki, vi in pairs(icons) do
                table.insert(assets_file_list, vi)
            end
        end
    end
    return assets_file_list
end

function FightInfo:IsHeroExist(owner_gid, default_rarity)
    if not owner_gid then
        return false
    end
    for i = EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        for k,v in pairs(self.hero_list[i]) do
            local obj = ObjectManager.GetObjectByName(v)
            if obj and obj.owner_player_gid == owner_gid and obj:GetDefaultRarity() == default_rarity then
                return true
            end
        end
    end
    return false
end

---------------------------------------------------------
function FightInfo:SetCurrentTipEntity(entityName)
    self._currentTipEntityName = entityName
end

function FightInfo:GetCurrentTipEntity()

    local entity = nil

    if self._currentTipEntityName then
        entity = GetObj(self._currentTipEntityName)
    end

    return entity
end

function FightInfo:SetPrepareOpenObstacle(is)
    self._isPrepareOpenObstacle = is
end

function FightInfo:GetPrepareOpenObstacle()
    return self._isPrepareOpenObstacle
end

function FightInfo:SetCurrentObstacle(entitys)
    self.currentObstacleEntitysName = entitys
end

function FightInfo:CurrentObstacleAllLostEffect()

    if self.currentObstacleEntitysName then
        for k,name in ipairs(self.currentObstacleEntitysName) do
            local obj = GetObj(name)

            if obj then 
                if not obj:GetCanBeAttack() and obj:GetIsObstacle() then
                    local x,y,z = obj:GetPositionXYZ()

                    local isSuc,sx,sy,sz = util.get_navmesh_sampleposition(x, y, z, 0.2)
                    if not isSuc then
                        app.log("CurrentObstacleAllLostEffect false " .. tostring(name) )
                        return false
                    end
                end
            end
        end
    end

    return true

end


-----------------------------------------------------------

--[[ endregion ]]