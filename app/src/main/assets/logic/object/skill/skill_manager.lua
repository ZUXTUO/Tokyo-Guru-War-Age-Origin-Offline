--[[
region skill_manager.lua
date: 2015-8-3
time: 11:40:28
author: Nation
技能调用入口
]]
SkillManager = {}
local lastDlgAudioTime = 0;   --上一次播放技能配音的时间
--[[使用技能]]
--user 使用者(scene_entity)
--skill 技能(skill_ex)
SkillManager.UseSkill = function(user, skill, is_force)
    if SkillManager.attack_skate_factor == nil then
        local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_attackSkateFactor);
        if cf then
            SkillManager.attack_skate_factor = cf.data;
        end
    end
    if SkillManager.attack_skate_factor_except == nil then
        local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_attackSkateFactorExcept);
        if cf then
            SkillManager.attack_skate_factor_except = cf.data;
        end
    end

    if SkillManager.normal_skill_reset_time == nil then
        local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_normalSkillResetTime);
        if cf then
            SkillManager.normal_skill_reset_time = cf.data;
        else
            SkillManager.normal_skill_reset_time = 1000
        end
    end
	local ret = eUseSkillRst.OK
    if (not is_force) and (not skill) then
        return eUseSkillRst.Illegal1
    end
    if (not is_force) and skill:IsWorking() then
        return eUseSkillRst.IsWorking
    end
    if (not is_force) and (not user) then
        return eUseSkillRst.Illegal2
    end
    if (not is_force) and (user ~= skill._owner) then
        return eUseSkillRst.Illegal3
    end
    if (not is_force) and user:IsDead() then
        return eUseSkillRst.Deaded
    end
    local targetName = nil
    local targetGID = 0
    local target = nil
    if not skill._owner:IsMyControl() or skill:IsIntelligent() then
        target = skill._owner:GetAttackTarget()
    end
    if target ~= nil then
        targetName = target:GetName()
        targetGID = target:GetGID()
    end
    if not is_force  then
    	ret = SkillManager.CheckBaseCondition(user, skill)
        if ret ~= eUseSkillRst.OK then
            return ret
        end
        ret = SkillManager.CheckTargetCondition(skill, target)
        if ret ~= eUseSkillRst.OK then
            return ret
        end
        ret = SkillManager.CheckExpressionCondition(skill, user, target)
        if ret ~= eUseSkillRst.OK then
            return ret
        end
    end
    if target and (skill:GetSkillType() ~= eSkillType.ImmediatelyNoStateSkill) and (skill:GetSkillType() ~= eSkillType.ImmediatelyStateSkill) and (not skill:IsIgnoreDir()) then
		user:LookAt(target:GetPositionXYZ())
    elseif (skill._skillInfo.aperture == 5 or skill._skillInfo.aperture == 4) and skill._owner.aperture_manager then 
        local pos = skill._owner.aperture_manager:GetRTPosition(skill._owner.aperture_manager.apertureType[5], true)
        if pos then
            user:LookAt(pos.x, pos.y, pos.z)
        end
    end
    --[[if user:IsMyControl() then
        app.log("使用技能"..skill._skillData.id.." targetName="..tostring(targetName).." "..debug.traceback() )
    end]]

    --没有动作的技能音效
    local audio = skill._skillInfo.audio;
    if audio and audio ~= 0 then
        local id = audio[1].id;
        local pos = audio[1].pos;
--        local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,pos);
        local bind_pos = user:GetBindObj(pos)
        if (bind_pos ~= nil) then
            local volScale = AudioManager.GetVolScaleBySceneEntity(user);
            if user:GetName() == FightManager.GetMyCaptainName() then
                AudioManager.Play3dAudio(id, bind_pos, true, true, nil, nil, nil, nil, volScale)
            else
                AudioManager.Play3dAudio(id, bind_pos, false, true, nil, nil, nil, nil, volScale)
            end
        end
    end

    --技能配音
    local dlg_audio = skill._skillInfo.dlg_audio;
    if dlg_audio and dlg_audio ~= 0 then
        -- local id = dlg_audio[1].id;
        -- local probability = dlg_audio[1].probability;
        local probability_table = {}
        local index = 0
        probability_table[0] = 0;
        local all_probability = 0;
        for k,v in pairs(dlg_audio) do
            index = index + 1;
            local id = v.id;
            local probability = v.probability;
            probability_table[index] = probability_table[index-1] + probability;
            all_probability = all_probability + probability;
            --app.log("k==="..k.."   all_probability=="..all_probability);
        end
        --local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,3);
        local bind_pos = user:GetBindObj(3)
        if user:GetName() == FightManager.GetMyCaptainName() then
            local x = math.random(1,100);
            --app.log("x=="..x);
            if x <= all_probability then
                local id = nil;
                for k,v in pairs(probability_table) do
                    if x <= v then
                        id = dlg_audio[k].id;
                        --app.log("id==="..id.."    k=="..k);
                        break;
                    end
                end
                if id then
                    local curtime = system.time();
                    if curtime - lastDlgAudioTime >= ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_dlgAudioIntervalTime).data then
                        if not AudioManager.cur3dAudioId then
                            lastDlgAudioTime = curtime;
                            local volScale = AudioManager.GetVolScaleBySceneEntity(user);
                            --AudioManager.Play3dAudio(id, bind_pos, true, true, true, nil, nil, nil, volScale)
                            AudioManager.PlayUiAudio(id)
                            local fightManager = FightScene.GetFightManager();
                            if fightManager then
                                if fightManager.lastRelaxAudioTime then
                                    fightManager.lastRelaxAudioTime = system.time();
                                    local t = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_relaxAudioIntervalTime).data
                                    fightManager.RelaxAudioIntervalTime = math.random(t[1],t[2]);
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    user._lastSkillTarget = targetName
    if skill:GetSkillType() ~= eSkillType.Normal then
        
    end
    if (skill._skillInfo.type == eSkillType.DirectionSkill or skill._skillInfo.type == eSkillType.DoubleCircleSkill or skill._skillInfo.type == eSkillType.TripleCircleSkill or skill._skillInfo.type == eSkillType.ImmediatelyStateSkill) and skill._angle and skill._angle ~= 0 then
        skill._owner:SetRotation(0, skill._angle, 0)
    end
    
    local skill_message_info = nil 
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync and (user:IsMyControl() or user:IsAIAgent())then
        skill_message_info = {}
        skill_message_info.targets_info = {}
        skill_message_info.targets_info.targets_gid = {}
        local targets_key = 0
        if skill._skillData.targets_index then
            for i=1, #skill._skillData.targets_index do
                local searchTargetData = g_SkillTargetsData[skill._skillData.targets_index[i]]
                if searchTargetData then
                    local targets = {}
                    --app.log_warning("index="..skill._skillData.targets_index[i])
                    SkillManager.SearchSkillTarget(searchTargetData, user, user:GetName(), user:GetName(), skill:GetID(), nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, target, SkillEx.SKILL_GID_CREATOR, targets)
                    targets_key = PublicFunc.GenerateSkillTargetIndex(skill_message_info.targets_info, skill:GetID(), searchTargetData.buff_id, searchTargetData.trigger_index, searchTargetData.action_index, 1)
                    local user_gid = user:GetGID()
                    if FightScene.sync_targets[user_gid] == nil then
                        FightScene.sync_targets[user_gid] = {}
                    end
                    FightScene.sync_targets[user_gid][targets_key] = {}
                    FightScene.sync_targets[user_gid][targets_key][1] = PublicFunc.QueryCurTime()
                    if #targets > 0 then
                        for i=1, #targets do
                            local gid = targets[i]:GetGID()
                            FightScene.sync_targets[user_gid][targets_key][i+1] = gid
                            skill_message_info.targets_info.targets_gid[i] = gid
                        end
                    end
                    skill_message_info.targets_info.user_gid = user_gid
                else
                    app.log("技能目标索引为空 index="..skill._skillData.targets_index[i])
                end
            end
        end
        local forward = user:GetForWard()
        
        skill_message_info.user_gid = user:GetGID()
        skill_message_info.skill_id = skill:GetID()
        skill_message_info.default_target_gid = targetGID
        skill_message_info.towards_x = forward.x
        skill_message_info.towards_z = forward.z
        local user_pos = user:GetPosition()
        skill_message_info.x = user_pos.x*PublicStruct.Coordinate_Scale
        skill_message_info.z = user_pos.z*PublicStruct.Coordinate_Scale
        skill_message_info.action_odds = math.random(0, 100)
        local pos = nil
        if (skill._skillInfo.aperture == 5 or skill._skillInfo.aperture == 4) and skill._owner.aperture_manager then
            pos = skill._owner.aperture_manager:GetRTPosition(skill._owner.aperture_manager.apertureType[5], true)
        end
        if pos and (pos.x ~= 0 or pos.y ~= 0 or pos.z ~= 0) then
            skill_message_info.aperture_posx = pos.x
            skill_message_info.aperture_posy = pos.y
            skill_message_info.aperture_posz = pos.z
        else
            skill_message_info.aperture_posx = 9999
            skill_message_info.aperture_posy = 9999
            skill_message_info.aperture_posz = 9999
        end
        skill.action_odds = skill_message_info.action_odds
        --app.log("发送技能包 dx="..forward.x.." dz="..forward.z)
        
    end
    if user:GetExternalArea("skillChange") == true then
        user.skill_use_by_skillChange = true
        --[[if FightScene.GetFightManager()._className == "PeakShowFightManager" and user:GetName() == "Monster_1_7" then
            app.log("巅峰展示 skill_use_by_skillChange=true 当前技能"..skill:GetSkillID())
        end]]
    else
        user.skill_use_by_skillChange = false
    end
    LocalModeAbortReborn()
    user:OnUseSkill(skill, targetGID)
    skill:StartCD(false)
    user.just_learn_skill = false;
    user.wait_finish_skill = skill:GetSkillID()
    local movex, movey, movez = skill:StartWork(target)
    if skill_message_info then
        if movex and movez then
            skill_message_info.movex = movex*PublicStruct.Coordinate_Scale
            skill_message_info.movez = movez*PublicStruct.Coordinate_Scale
        end
        msg_fight.cg_use_skill(skill_message_info, skill._skillData.cdtype)
    end
    --[[if 146 == user.wait_finish_skill then
        app.log_warning("已经使用巅峰技能")
    end]]
    if skill:GetSkillType() == eSkillType.Normal and user:GetName() == FightManager.GetMyCaptainName() and target then
        FightScene.SetCurtRimLightObj(target)
    end
    if skill:GetSkillType() ~= eSkillType.Normal then
        user.normalAttackIndex = 1
    else
        user.last_use_normal_skill_time = PublicFunc.QueryCurTime()
        user.normalAttackIndex = (user.normalAttackIndex + 1) % user.max_normal_skill_index;
        if (user.normalAttackIndex == 0) then
            user.normalAttackIndex = user.max_normal_skill_index;
        end
    end
    local fightManager = FightScene.GetFightManager()
    if fightManager ~= nil then
        local OnEvent_UseSkill = FightScene.GetFightManager().OnEvent_UseSkill
        if OnEvent_UseSkill~= nil then
            OnEvent_UseSkill(fightManager, user, skill:GetSkillID())
        end
    end
    return ret
end

--[[检测技能是否可用]]
--user 使用者(scene_entity)
--skill 技能(skill_ex)
SkillManager.CanUseSkill = function(user,skill)
	local ret = eUseSkillRst.OK
    if not skill then
        return eUseSkillRst.Illegal1
    end
    if not user then
        return eUseSkillRst.Illegal2
    end
    if user ~= skill._owner then
        return eUseSkillRst.Illegal3
    end
    local target = skill._owner:GetAttackTarget()
	ret = SkillManager.CheckBaseCondition(user, skill)
    if ret ~= eUseSkillRst.OK then
        return ret
    end
    ret = SkillManager.CheckTargetCondition(skill, target)
    if ret ~= eUseSkillRst.OK then
        return ret
    end
    return ret
end

SkillManager.CanCancelSkill = function(user, skill, bInitiative)

    if not skill then
        return false
    end
    if not user then
        return false
    end
    if user ~= skill._owner then
        return false
    end
    local canCancel = false
    local cancelType = skill:GetCancelType()
    if cancelType ~= nil then
        if bInitiative then
            canCancel = true
        else
            if cancelType == 1 then
                canCancel = true
            end 
        end
    else
        return false
    end

    if canCancel and skill:IsWorking() then
        if skill:IsPassCancelTime() then
            return true
        end
    end
    return false
end

--[[取消技能]]
--user 使用者(scene_entity)
--skill 技能(skill_ex)
SkillManager.CancelSkill = function(user,skill,bInitiative)

    local canCancel = SkillManager.CanCancelSkill(user,skill,bInitiative)

    if canCancel then
        skill:Cancel()
    end

    return canCancel
end

--[[检测技能基本使用需求]]
--skill 技能(skill_ex)
SkillManager.CheckBaseCondition = function(user, skill)
    local ret = skill:CheckCD()
    if ret ~= eUseSkillRst.OK then
        return ret
    end
    if skill:IsDisenable() then
        return eUseSkillRst.Disenable
    end
    if skill:GetSkillType() == eSkillType.Normal then
        if user._buffManager:IsInSpecialEffect(ESpecialEffectType.DingShen) or
           user._buffManager:IsInSpecialEffect(ESpecialEffectType.XuanYun) or
           user._buffManager:IsInSpecialEffect(ESpecialEffectType.KongJu) then
            return eUseSkillRst.ProhibitSkill
        end
    elseif skill:GetSkillType() ~= eSkillType.Normal then
        if user._buffManager:IsInSpecialEffect(ESpecialEffectType.XuanYun) or
           user._buffManager:IsInSpecialEffect(ESpecialEffectType.KongJu) or
           user._buffManager._tauntTarget or 
           user._buffManager:IsInSpecialEffect(ESpecialEffectType.ChenMo) then
            return eUseSkillRst.ProhibitSkill
        end
    end
    local less_hp = skill:GetLessThanHP()
    if less_hp and user:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/user:GetPropertyVal(ENUM.EHeroAttribute.max_hp) > less_hp then
        return eUseSkillRst.LessThanHP
    end 
    return ret
end

--[[检测技能目标需求]]
--skill 技能(skill_ex)
--target 目标(scene_entity)
SkillManager.CheckTargetCondition = function(skill, target)
    local ret = skill:CheckTarget(target)
    if ret ~= eUseSkillRst.OK then
        return ret
    end
    return ret
end

SkillManager.CheckExpressionCondition = function(skill, user, target)
    local condition_id = skill:GetCondition()
    if condition_id then
        if SkillCTree.CheckCondition(g_SkillConditionData[condition_id], user, target) then
            return eUseSkillRst.OK
        else
            return eUseSkillRst.Expression
        end
    end
    return eUseSkillRst.OK
end


SkillManager.SearchSkillTarget = function(search_data, buff_owner_obj, buff_creator_name, skill_creator_name, skill_id, trigger_callback_targets, trigger_third_targets,
    buff_callback_direct, buff_callback_position, buffmanager_record_position, buff_record_position, buff_record_direct, trigger_record_position, buff_record_multi_position, buff_manager_record_multi_position, default_target_obj, skill_gid, array_targets)
    --app.log(debug.traceback())
    local temp_array_targets = {}
    if search_data == nil then
        app.log("技能目标的配置数据为空")
        return
    end
    if search_data.enemy == nil then
        search_data.enemy = true
    end
    local radius = search_data.radius
    if radius == nil and skill_id and skill_id ~= 0 then
        if search_data.targettype == 2 then
            radius = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id).extra_distance
        else
            radius = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id).distance
        end
        if search_data.radiusfactor then
            radius = radius*search_data.radiusfactor
        end
    end
    local width = search_data.width
    if width == nil and skill_id and skill_id ~= 0 then
        width = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id).width
    end
    local srcObj =  nil
    local direct = nil
    local buffid = search_data.buffid
    local bufflv = search_data.bufflv
    if search_data.srctype == 0 then
        srcObj = ObjectManager.GetObjectByName(buff_creator_name)
    elseif search_data.srctype == 1 then
        srcObj = buff_owner_obj
    elseif search_data.srctype == 2 then
        srcObj = ObjectManager.GetObjectByName(skill_creator_name)
    elseif search_data.srctype == 4 then
        srcObj = trigger_callback_targets[1]
    elseif search_data.srctype == 5 then
        srcObj = default_target_obj
    elseif search_data.srctype == 6 then
        srcObj = trigger_third_targets[1]
    end
    local length = search_data.length
    if length == nil then
        if lengthtype == 1 and srcObj and default_target_obj then
            local srcPos = srcObj:GetPosition();
            local targetPos = default_target_obj:GetPosition();
            length = algorthm.GetDistance(srcPos.x, srcPos.z, targetPos.x, targetPos.z)+1
        elseif skill_id and skill_id ~= 0 then
            length = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id).distance
        end
        
    end
    if search_data.direct == nil then
        if srcObj ~= nil then
            direct = {x=1,y=0,z=1}
            if srcObj:GetObject() then
                direct.x, direct.y, direct.z = srcObj:GetObject():get_forward()
            end
        end
    elseif search_data.direct == 0 then
        if buff_callback_direct ~= nil then
            direct = buff_callback_direct
        end
    elseif search_data.direct == 1 then
        if srcObj then
            local srcDir = srcObj:GetForWard()
            local rx,ry,rz,rw = util.quaternion_euler(0, search_data.directoffset, 0);
            local resultX,resultY,resultZ = util.quaternion_multiply_v3(rx, ry, rz, rw, srcDir.x, srcDir.y, srcDir.z);
            direct = {}
            direct.x, direct.y, direct.z = util.v3_normalized(resultX, resultY, resultZ);
        end
    elseif search_data.direct == 2 then
        direct = buff_record_direct
    end
    if search_data.targettype == 1 then
        local skillCreator = ObjectManager.GetObjectByName(skill_creator_name)
        if skillCreator ~= nil then
            if search_data.srctype == 3 then
                local pos = nil
                if search_data.position == 0 then
                    pos = buff_callback_position
                    if pos == nil then
                        app.log(" 1pos=nil.."..debug.traceback())
                    end
                elseif search_data.position == 1 then
                    pos = buffmanager_record_position
                    if pos == nil then
                        app.log(" 2pos=nil.."..debug.traceback())
                    end
                elseif search_data.position == 2 then
                    pos = buff_record_position
                    if pos == nil then
                        app.log(" 3pos=nil.."..debug.traceback())
                    end
                elseif search_data.position == 3 then
                    local creator = ObjectManager.GetObjectByName(buff_creator_name)
                    local creator_dir = creator:GetForWard()
                    pos = creator:GetPosition()
                    local position_offset = search_data.position_offset
                    if position_offset == nil and skill_id ~= 0 then
                        position_offset = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id).distance
                    end
                    pos.x = pos.x + creator_dir.x*position_offset
                    pos.z = pos.z + creator_dir.z*position_offset
                elseif search_data.position == 4 then
                    pos = trigger_record_position
                    if pos == nil then
                        app.log(" 4pos=nil.."..debug.traceback())
                    end
                elseif search_data.position == 5 then
                    pos = buff_record_multi_position[search_data.position_offset]
                    if pos == nil then
                        app.log(" 5pos=nil.."..debug.traceback())
                    end
                elseif search_data.position == 6 then
                    pos = buff_manager_record_multi_position[search_data.position_offset]
                    if pos == nil then
                        app.log(" 6pos=nil.."..debug.traceback())
                    end
                end
                FightScene.SearchAreaTargetEx(search_data.enemy, pos, radius, direct, search_data.angle, search_data.layer, skillCreator, temp_array_targets, search_data.targetcnt, search_data.sorttype, buffid, bufflv, buff_owner_obj, search_data.includeself)
            elseif srcObj then
                srcObj:SearchAreaTarget(search_data.enemy, radius, skillCreator, temp_array_targets, search_data.targetcnt, search_data.angle, direct, search_data.sorttype, search_data.includeself, buffid, bufflv, search_data.layer)
                --app.log("name="..srcObj:GetName().." enemy="..tostring(search_data.enemy).." radius="..radius.." include="..tostring(search_data.includeself).." len="..#temp_array_targets)
            end
        end
    elseif search_data.targettype == 2 then
        local skillCreator = ObjectManager.GetObjectByName(skill_creator_name)
        if skillCreator ~= nil then
            local fromController = true
            local aperturePos = nil
            if skillCreator then
                if skillCreator:IsAIAgent() then
                    fromController = false
                else
                    fromController = skillCreator:IsMyControl()
                end
                if skillCreator.aperture_manager then
                    aperturePos = skillCreator.aperture_manager:GetRTPosition(skillCreator.aperture_manager.apertureType[5], fromController)
                end
            end
            local include_self = search_data.includeself
            local founder = buff_owner_obj
            if aperturePos == nil or (aperturePos.x==0 and aperturePos.y==0 and aperturePos.z==0) then
                if default_target_obj ~= nil then
                    founder = default_target_obj
                    include_self = true
                    aperturePos = default_target_obj:GetPosition(true)
                else
                    aperturePos = buff_owner_obj:GetPosition(true)
                end
            end
            FightScene.SearchAreaTargetEx(search_data.enemy, aperturePos, radius, {x=0, y=0, z=1}, search_data.angle, search_data.layer, skillCreator, temp_array_targets, search_data.targetcnt, search_data.sorttype, buffid, bufflv, founder, include_self)
        end
    elseif search_data.targettype == 3 then
        temp_array_targets[1] = default_target_obj
    elseif search_data.targettype == 4 then
        if srcObj then
            local skillCreator = ObjectManager.GetObjectByName(skill_creator_name)
            if skillCreator ~= nil then
                if width == nil or width == 0 then
                    app.log("skill_id="..skill_id.." 直线搜索没有配宽度")
                end
                srcObj:SearchRectangleTarget(search_data.enemy, length, width, skillCreator, temp_array_targets, search_data.targetcnt, direct, search_data.sorttype, search_data.includeself, buffid, bufflv, search_data.layer, search_data.aroundradius)
            end
        end
    elseif search_data.targettype == 5 then
        if srcObj then
            local skillCreator = ObjectManager.GetObjectByName(skill_creator_name)
            if skillCreator ~= nil then
                temp_array_targets[1] = srcObj:SearchAreaTarget_SkillRef(search_data.enemy, skillCreator, skill_gid, radius, search_data.angle,search_data.includeself)
            end
        end
    elseif search_data.targettype == 6 then
        if srcObj then
            local skillCreator = ObjectManager.GetObjectByName(skill_creator_name)
            if skillCreator ~= nil then
                FightScene.SearchHeroTarget(search_data.enemy, skillCreator, search_data.sorttype, search_data.includeself, srcObj, temp_array_targets, search_data.targetcnt, radius);
            end
            -- local searchFlag = srcObj:GetCampFlag()
            -- if search_data.enemy then
            --     if searchFlag == g_dataCenter.fight_info.single_friend_flag then
            --         searchFlag = g_dataCenter.fight_info.single_enemy_flag
            --     else
            --         searchFlag = g_dataCenter.fight_info.single_friend_flag
            --     end
            -- end
            -- local heroList = g_dataCenter.fight_info:GetHeroList(searchFlag)
            -- local heroIndex = 1
            -- for k, v in pairs(heroList) do
            --     local obj = ObjectManager.GetObjectByName(v)
            --     if obj then
            --         if search_data.includeself or obj ~= srcObj then
            --             temp_array_targets[heroIndex] = obj
            --             heroIndex = heroIndex + 1
            --         end
            --     end
            -- end
        end
    end
    if array_targets then
        for i=1, #temp_array_targets do
            if not temp_array_targets[i]:GetCanNotAttack() then
                table.insert(array_targets, temp_array_targets[i])
            end
        end
    end
end

SkillManager.GetSkillIntroduce = function(atk_power, skill_id, skill_level)
    local describe, value = PublicFunc.FormatSkillString(nil, skill_id, nil, skill_level, atk_power)
    return describe
end
--[[endregion]]