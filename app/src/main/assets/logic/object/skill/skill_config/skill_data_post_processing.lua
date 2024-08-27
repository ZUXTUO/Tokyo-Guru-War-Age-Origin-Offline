local function GetHeroModelFile(id)
    if ConfigHelper.GetRole(id) == nil then
        app.log("取了一个不存在英雄属性id........"..tostring(id)..debug.traceback());
        return;
    end
    local model_id = ConfigHelper.GetRole(id).model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("英雄模型id配置错误........"..tostring(model_id)..' '..tostring(id)..debug.traceback());
        return;
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,model_id).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle',modelName,modelName);
    return filePath;
end

local function GetModelFile(model_id)
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("模型id配置错误........"..tostring(model_id)..' '..tostring(id)..debug.traceback());
        return;
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,model_id).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle',modelName,modelName);
    return filePath;
end

local function GetMonsterModelFile(id)
    if ConfigManager.Get(EConfigIndex.t_monster_property,id) == nil then
        app.log("取了一个不存在怪物属性id........"..id..debug.traceback());
        return;
    end
    local model_id = ConfigManager.Get(EConfigIndex.t_monster_property,id).model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("怪物模型id配置错误........"..model_id..' '..id..debug.traceback());
        return;
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,model_id).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle',modelName,modelName);
    return filePath;
end
function CheckAllSkillTargetsIndex()
    for buffid, buffdata in pairs(g_BuffData) do
        for levelid, leveldata in pairs(buffdata.level) do
            if leveldata.trigger then
                for triggerid, triggerdata in pairs(leveldata.trigger) do
                    if triggerdata.action then
                        for actionid, actiondata in pairs(triggerdata.action) do
                            if actiondata.atype == eBuffAction.UseThirdTarget and actiondata.usetype == 0 then
                                if actiondata.typeindex and not g_SkillTargetsData[actiondata.typeindex].handle_skill then
                                    app.log("技能目标数据, index="..actiondata.typeindex.." 未处理")
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    for k, v in pairs(g_SkillTargetsData) do
        if not v.use then
            app.log("skill_target_index未使用 id="..k)
        end
    end
end

function HandleSkillTargetsIndex(buffid, bufflv, targets_index, handle_buff_info)
    if buffid == nil or bufflv == nil then
        return
    end
    if (not g_BuffData[buffid]) or (not g_BuffData[buffid].level) or (not g_BuffData[buffid].level[bufflv]) then
        return
    end
    if handle_buff_info[tostring(buffid).."|"..tostring(bufflv)] then
        return
    end
    handle_buff_info[tostring(buffid).."|"..tostring(bufflv)] = 1
    local leveldata = g_BuffData[buffid].level[bufflv]
    if leveldata.trigger then
        for triggerid, triggerdata in pairs(leveldata.trigger) do
            for actionid, actiondata in pairs(triggerdata.action) do
                if actiondata.atype == eBuffAction.UseThirdTarget and actiondata.usetype == 0 then
                    if actiondata.typeindex then
                        table.insert(targets_index, actiondata.typeindex)
                        if g_SkillTargetsData[actiondata.typeindex] then
                            g_SkillTargetsData[actiondata.typeindex].handle_skill = true
                        else
                            app.log("找不到技能目标数据, index="..actiondata.typeindex)
                        end
                    end 
                elseif actiondata.atype == eBuffAction.AttachBuff then
                    HandleSkillTargetsIndex(actiondata.buffid, actiondata.bufflv, targets_index, handle_buff_info)
                elseif actiondata.atype == eBuffAction.RunEffect then
                    HandleSkillTargetsIndex(actiondata.abuffid, actiondata.abufflv, targets_index, handle_buff_info)
                end
            end
        end
    end
end

local skillEffectData = {}
local skillModelData = {}
local skillSoundData = {}
function SkillCalculateSize()
    for skillid, skilldata in pairs(g_SkillData) do
        skilldata.id = skillid
        local skill_info = ConfigManager.Get(EConfigIndex.t_skill_info, skilldata.id)
        for effectid, effectdata in pairs(skilldata.effect) do
            if g_BuffEffectData[effectdata.buffid] and g_BuffEffectData[effectdata.buffid][effectdata.bufflv] then
                for effect_id, v in pairs(g_BuffEffectData[effectdata.buffid][effectdata.bufflv]) do
                    if skillEffectData[skillid] == nil then
                        skillEffectData[skillid] = {}
                    end
                    skillEffectData[skillid][effect_id] = 1
                end
            end
            if g_BuffModelData[effectdata.buffid] and g_BuffModelData[effectdata.buffid][effectdata.bufflv] then
                for obj_id, v in pairs(g_BuffModelData[effectdata.buffid][effectdata.bufflv]) do
                    if skillModelData[skillid] == nil then
                        skillModelData[skillid] = {}
                    end
                    skillModelData[skillid][obj_id] = 1
                end
            end
            if g_BuffSoundData[effectdata.buffid] and g_BuffSoundData[effectdata.buffid][effectdata.bufflv] then
                for sound_id, v in pairs(g_BuffSoundData[effectdata.buffid][effectdata.bufflv]) do
                    if skillSoundData[skillid] == nil then
                        skillSoundData[skillid] = {}
                    end
                    skillSoundData[skillid][sound_id] = 1
                end
            end
            if skill_info and skill_info.cd == 0 then
                if g_BuffData[effectdata.buffid] and g_BuffData[effectdata.buffid].level[effectdata.bufflv] then
                    local buff_level_data = g_BuffData[effectdata.buffid].level[effectdata.bufflv]
                    if buff_level_data then
                        for i=1, #buff_level_data.trigger do
                            if skill_info.cd ~= 0 then
                                break
                            end
                            if buff_level_data.trigger[i].action then
                                for j=1, #buff_level_data.trigger[i].action do
                                    if skill_info.cd ~= 0 then
                                        break
                                    end
                                    local action_data = buff_level_data.trigger[i].action[j]
                                    if action_data and action_data.atype == eBuffAction.RunAnimation then
                                        if action_data.animid then
                                            local cfg = ConfigManager.Get(EConfigIndex.t_skill_effect, action_data.animid)
                                            if cfg and cfg.frame_event ~= 0 then
                                                for k=1, #cfg.frame_event do
                                                    if skill_info.captain_attack_skate_dis and skill_info.captain_attack_skate_dis > 0 and not skill_info.captain_attack_skate_time and cfg.frame_event[k].e == 'attack_move' then
                                                        --if cfg.frame_event[k].f > 5 then
                                                        --    skill_info.captain_attack_skate_time = (cfg.frame_event[k].f-4)*PublicStruct.MS_Each_Anim_Frame
                                                        --else
                                                            skill_info.captain_attack_skate_time = cfg.frame_event[k].f*PublicStruct.MS_Each_Anim_Frame
                                                        --end
                                                    end
                                                    if cfg.frame_event[k].e == 'attack1_end' or cfg.frame_event[k].e == 'attack1_completed' then
                                                        skill_info.cd = cfg.frame_event[k].f*PublicStruct.MS_Each_Anim_Frame
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            local targets_index = {}
            local handle_buff_info = {}
            HandleSkillTargetsIndex(effectdata.buffid, effectdata.bufflv, targets_index, handle_buff_info);
            if #targets_index > 0 then
                skilldata.targets_index = targets_index
            else
                skilldata.targets_index = nil
            end
        end
        if skill_info and skill_info.captain_attack_skate_dis and not skill_info.captain_attack_skate_time then
            skill_info.captain_attack_skate_time = PublicStruct.MS_Each_Anim_Frame*4
        end
    end
    g_BuffEffectData = nil
    g_BuffModelData = nil
    CheckAllSkillTargetsIndex()
end


SkillCalculateSize()

function SupplementResourceConfig(cfg)

    -- 检查 cfg 是否为 nil
    if cfg == nil then
        -- 创建一个新的 cfg 表
        cfg = {
            all_skill_effect = {},
            all_skill_model = {},
            all_skill_sound = {}
        }
    end

    if cfg and cfg.all_skill_effect and cfg.all_skill_model and cfg.all_skill_sound then
        return
    end

    cfg.all_skill_effect = {}
    cfg.all_skill_model = {}
    cfg.all_skill_sound = {}
    if cfg.normal_skill and cfg.normal_skill ~= 0 then
        for k,v in ipairs(cfg.normal_skill) do
            local skill_id = v[1]
            if skillEffectData[skill_id] then
                for _k, _v in pairs(skillEffectData[skill_id]) do
                    local _d = ConfigManager.Get(EConfigIndex.t_all_effect,_k)
                    if _d then
                        cfg.all_skill_effect[ConfigManager.Get(EConfigIndex.t_all_effect,_k).file] = _d.file
                    end
                end
            end
            if skillModelData[skill_id] then
                for _k, _v in pairs(skillModelData[skill_id]) do
                    local file = GetModelFile(_k)
                    if file then
                        cfg.all_skill_model[file] = file
                    end
                end
            end
            if skillSoundData[skill_id] then
                for _k, _v in pairs(skillSoundData[skill_id]) do
                    local _path = ConfigHelper.GetAudioPath(_k)
                    if _path then
                        cfg.all_skill_sound[_path] = _path
                    end
                end
            end
        end
    end
end