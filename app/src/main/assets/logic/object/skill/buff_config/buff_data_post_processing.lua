g_BuffEffectData = {}
g_BuffModelData = {}
g_BuffSoundData = {}
g_SkillPassiveBuff = {}
local unique_recursion_buff = nil
function RecursionBuff(srcBuffID, srcBufflv, buffid, bufflv, first)
    if (not g_BuffData[buffid]) or (not g_BuffData[buffid].level) or (not g_BuffData[buffid].level[bufflv]) or (not g_BuffData[buffid].level[bufflv].trigger) then
        return
    end
    if first then
        unique_recursion_buff = {}
    end
    local buff_key = bit.bit_lshift(buffid, 16) + bufflv
    if unique_recursion_buff[buff_key] then
        return
    end
    unique_recursion_buff[buff_key] = 1
    if not first then
        if g_BuffEffectData[buffid] and g_BuffEffectData[buffid][bufflv] then 
            if g_BuffEffectData[srcBuffID] == nil then
                g_BuffEffectData[srcBuffID] = {}
            end
            if g_BuffEffectData[srcBuffID][srcBufflv] == nil then
                g_BuffEffectData[srcBuffID][srcBufflv] = {}
            end
            for e_id, e_v in pairs(g_BuffEffectData[buffid][bufflv]) do
                g_BuffEffectData[srcBuffID][srcBufflv][e_id] = 1
            end
        end
        if g_BuffModelData[buffid] and g_BuffModelData[buffid][bufflv] then 
            if g_BuffModelData[srcBuffID] == nil then
                g_BuffModelData[srcBuffID] = {}
            end
            if g_BuffModelData[srcBuffID][srcBufflv] == nil then
                g_BuffModelData[srcBuffID][srcBufflv] = {}
            end
            for m_id, m_v in pairs(g_BuffModelData[buffid][bufflv]) do
                g_BuffModelData[srcBuffID][srcBufflv][m_id] = 1
            end
        end
        if g_BuffSoundData[buffid] and g_BuffSoundData[buffid][bufflv] then 
            if g_BuffSoundData[srcBuffID] == nil then
                g_BuffSoundData[srcBuffID] = {}
            end
            if g_BuffSoundData[srcBuffID][srcBufflv] == nil then
                g_BuffSoundData[srcBuffID][srcBufflv] = {}
            end
            for s_id, s_v in pairs(g_BuffSoundData[buffid][bufflv]) do
                g_BuffSoundData[srcBuffID][srcBufflv][s_id] = 1
            end
        end
    end
    for triggerindex, triggerdata in pairs(g_BuffData[buffid].level[bufflv].trigger) do
        if triggerdata.action then
            for actionindex, actiondata in pairs(triggerdata.action) do
                local next_buff_id = nil
                local next_buff_lv = nil
                if actiondata.atype == eBuffAction.AttachBuff then
                    next_buff_id = actiondata.buffid
                    next_buff_lv = actiondata.bufflv
                elseif actiondata.atype == eBuffAction.RunEffect then
                    next_buff_id = actiondata.abuffid
                    next_buff_lv = actiondata.abufflv
                elseif actiondata.atype == eBuffAction.AttachDelayBuffWithDistance then
                    next_buff_id = actiondata.buffid
                    next_buff_lv = actiondata.bufflv
                elseif actiondata.atype == eBuffAction.SequenceRunEffect then
                    next_buff_id = actiondata.buffid
                    next_buff_lv = actiondata.bufflv
                elseif actiondata.atype == eBuffAction.AttachBuffWhenUseSkill then
                    next_buff_id = actiondata.buffid
                    next_buff_lv = actiondata.bufflv
                elseif actiondata.atype == eBuffAction.AttachBuffWhenGainDamage then
                    next_buff_id = actiondata.buffid
                    next_buff_lv = actiondata.bufflv
                elseif actiondata.atype == eBuffAction.DamageAbsorb then
                    next_buff_id = actiondata.buffid
                    next_buff_lv = actiondata.bufflv
                elseif actiondata.atype == eBuffAction.KillTargetAddBuff then
                    next_buff_id = actiondata.buffid
                    next_buff_lv = actiondata.bufflv
                end
                if next_buff_id and next_buff_lv then
                    RecursionBuff(srcBuffID, srcBufflv, next_buff_id, next_buff_lv, false)
                end
            end
        end
    end
end

function BuffCalculateSize()
    for buffid, buffdata in pairs(g_BuffData) do
        buffdata.id = buffid
        buffdata.levelSize = #buffdata.level
        for levelid, leveldata in pairs(buffdata.level) do
            leveldata.lv = levelid
            if leveldata.skillid then
                if g_SkillPassiveBuff[leveldata.skillid] == nil then
                    g_SkillPassiveBuff[leveldata.skillid] = {}
                end
                table.insert(g_SkillPassiveBuff[leveldata.skillid], {id=buffdata.id, lv=leveldata.lv})
            end
            if leveldata.property == nil then
                app.log("buff找不到property, id="..buffid.." level="..levelid)
            end
            if leveldata.trigger then
                leveldata.triggerSize = #leveldata.trigger
                local trigger_index = 1
                for triggerid, triggerdata in ipairs(leveldata.trigger) do
                    
                    if triggerdata.action then
                        local real_size = 0
                        for __k,__v in pairs(triggerdata.action) do
                            real_size = real_size + 1
                        end
                        triggerdata.actionSize = #triggerdata.action
                        local action_index = 1
                        for actionid, actiondata in ipairs(triggerdata.action) do
                            if actiondata.atype == eBuffAction.UseThirdTarget then
                                if actiondata.typeindex and g_SkillTargetsData[actiondata.typeindex] then
                                    g_SkillTargetsData[actiondata.typeindex].use = true
                                end
                                if actiondata.usetype == 0 then
                                    if g_SkillTargetsData[actiondata.typeindex] == nil then
                                        app.log("找不到技能目标数据, index="..tostring(actiondata.typeindex).." buffid="..buffid.." levelid="..levelid.." triggerid="..triggerid.." actionid="..actionid)
                                    else
                                        local target_data = g_SkillTargetsData[actiondata.typeindex]
                                        if target_data.buff_id ~= nil and (target_data.buff_id ~= buffid or target_data.trigger_index ~= trigger_index or target_data.action_index ~= action_index) then
                                            app.log("配置技能目标数据时发现重复项, buffid="..buffid.." levelid="..levelid.." triggerid="..triggerid.." actionid="..actionid)
                                        else
                                            for k,v in pairs(target_data) do
                                                actiondata[k] = v
                                            end
                                            target_data.buff_id = buffid
                                            target_data.trigger_index = trigger_index
                                            target_data.action_index = action_index
                                        end
                                    end
                                end
                                
                            end
                            if actiondata.effectid and ConfigManager.Get(EConfigIndex.t_effect_data,actiondata.effectid) then
                                if g_BuffEffectData[buffid] == nil then
                                    g_BuffEffectData[buffid] = {}
                                end
                                if g_BuffEffectData[buffid][levelid] == nil then
                                    g_BuffEffectData[buffid][levelid] = {}
                                end
                                for ei, ed in pairs(ConfigManager.Get(EConfigIndex.t_effect_data,actiondata.effectid).id) do
                                    g_BuffEffectData[buffid][levelid][ed] = 1
                                end
                            end
                            if actiondata.animid then
                                local anim_cfg = ConfigManager.Get(EConfigIndex.t_skill_effect,actiondata.animid)
                                if anim_cfg then
                                    if g_BuffEffectData[buffid] == nil then
                                        g_BuffEffectData[buffid] = {}
                                    end
                                    if g_BuffEffectData[buffid][levelid] == nil then
                                        g_BuffEffectData[buffid][levelid] = {}
                                    end
                                    if type(anim_cfg.attack_effect_seq) == "table" then
                                        for k, v in pairs(anim_cfg.attack_effect_seq) do
                                            g_BuffEffectData[buffid][levelid][v.id] = 1
                                        end
                                    else
                                        if anim_cfg.attack_effect_seq ~= 0 then
                                            app.log("skill_effect表中attack_effect_seq配置错误。key:"..tostring(anim_cfg.key));
                                        end
                                    end
                                    if type(anim_cfg.emit_effect_seq) == "table" then
                                        for k, v in pairs(anim_cfg.emit_effect_seq) do
                                            g_BuffEffectData[buffid][levelid][v.id] = 1
                                        end
                                    else
                                        if anim_cfg.emit_effect_seq ~= 0 then
                                            app.log("skill_effect表中emit_effect_seq配置错误。key:"..tostring(anim_cfg.key));
                                        end
                                    end
                                    if type(anim_cfg.hited_effect_seq) == "table" then
                                        for k, v in pairs(anim_cfg.hited_effect_seq) do
                                            g_BuffEffectData[buffid][levelid][v.id] = 1
                                        end
                                    else
                                        if anim_cfg.hited_effect_seq ~= 0 then
                                            app.log("skill_effect表中hited_effect_seq配置错误。key:"..tostring(anim_cfg.key));
                                        end
                                    end

                                    if anim_cfg.attack_audio_seq ~= 0 then
                                        if g_BuffSoundData[buffid] == nil then
                                            g_BuffSoundData[buffid] = {}
                                        end
                                        if g_BuffSoundData[buffid][levelid] == nil then
                                            g_BuffSoundData[buffid][levelid] = {}
                                        end
                                        for k, v in pairs(anim_cfg.attack_audio_seq) do
                                            g_BuffSoundData[buffid][levelid][v.id] = 1
                                        end
                                    end
                                    if anim_cfg.hited_audio_seq ~= 0 then
                                        if g_BuffSoundData[buffid] == nil then
                                            g_BuffSoundData[buffid] = {}
                                        end
                                        if g_BuffSoundData[buffid][levelid] == nil then
                                            g_BuffSoundData[buffid][levelid] = {}
                                        end
                                        for k, v in pairs(anim_cfg.hited_audio_seq) do
                                            g_BuffSoundData[buffid][levelid][v.id] = 1
                                        end
                                    end
                                    if anim_cfg.frame_event ~= 0 then
                                        for k, v in pairs(anim_cfg.frame_event) do
                                            if v.e == "attack_prepared" then
                                                actiondata.have_prepare_step = true
                                            end
                                            
                                            if v.e == "attack1_end" then
                                                leveldata.ignore_anim_end = {}
                                                leveldata.ignore_anim_end[1] = triggerid
                                                leveldata.ignore_anim_end[2] = actionid
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                            if actiondata.obj_id and ConfigHelper.GetRole(actiondata.obj_id) then
                                if g_BuffModelData[buffid] == nil then
                                    g_BuffModelData[buffid] = {}
                                end
                                if g_BuffModelData[buffid][levelid] == nil then
                                    g_BuffModelData[buffid][levelid] = {}
                                end
                                g_BuffModelData[buffid][levelid][ConfigHelper.GetRole(actiondata.obj_id).model_id] = 1
                            end
                            if actiondata.modelid then
                                if g_BuffModelData[buffid] == nil then
                                    g_BuffModelData[buffid] = {}
                                end
                                if g_BuffModelData[buffid][levelid] == nil then
                                    g_BuffModelData[buffid][levelid] = {}
                                end
                                g_BuffModelData[buffid][levelid][actiondata.modelid] = 1
                            end
                            if actiondata.atype == eBuffAction.PlaySkillSound then
                                if g_BuffSoundData[buffid] == nil then
                                    g_BuffSoundData[buffid] = {}
                                end
                                if g_BuffSoundData[buffid][levelid] == nil then
                                    g_BuffSoundData[buffid][levelid] = {}
                                end
                                g_BuffSoundData[buffid][levelid][actiondata.id] = 1
                            end

                            if actiondata.atype == eBuffAction.UnlockSkill and (actiondata.lock == nil or actiondata.lock == 0) then
                                leveldata.ignore_anim_end = {}
                                leveldata.ignore_anim_end[1] = triggerid
                                leveldata.ignore_anim_end[2] = actionid
                            end
                            actiondata.action_index = action_index
                            action_index = action_index+1
                        end
                        if real_size ~= (action_index-1) then
                            app.log("action无序排列 buffid="..buffid.." lv="..levelid)
                        end
                    else
                        triggerdata.actionSize = 0
                    end
                    triggerdata.trigger_index = trigger_index
                    trigger_index = trigger_index+1
                end
            else
                leveldata.triggerSize = 0
            end
        end
    end
    for buffid, buffdata in pairs(g_BuffData) do
        for levelid, leveldata in pairs(buffdata.level) do
            RecursionBuff(buffid, levelid, buffid, levelid, true)
        end
    end
end
BuffCalculateSize()

function GetBuffConfigData(buffid, bufflv)
    if g_BuffData[buffid] then
        if g_BuffData[buffid].level[bufflv] then
            return g_BuffData[buffid].level[bufflv]
        end
    end
    return nil
end

function GetSkillPassiveBuff(skill_id)
    return g_SkillPassiveBuff[skill_id]
end