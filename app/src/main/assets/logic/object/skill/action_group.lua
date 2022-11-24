--[[
region action_group.lua
date: 2015-8-3
time: 11:46:57
author: Nation
技能所有的效果器
]]
function CheckExcept(entity, except_flag)
    if except_flag == nil or except_flag == 0 then
        return false
    end
    if entity:IsHero() then
        if (bit.bit_and(except_flag, ENUM.EMonsterType.Hero) ~= 0) then
            return true
        end
    elseif entity:IsMonster() then
        if (bit.bit_and(except_flag, entity:GetSubType()) ~= 0) then
            return true
        end
    end
    return false
end

function AnimationActionCallBack(data, param)
    if not data.action or not data.action._actionData or (data.action._callBackRef == 0 and not data.action._actionData.ignoreref) or not data.trigger._arrAction then
        return
    end
    if data.action._callBackRef > 0 then
        data.action._callBackRef = data.action._callBackRef-1
    end
    if data.action._callBackRef == 0 then
        data.action._actionState = eBuffActionState.Over
    end
    data.trigger:ResetAllAction(data.action)
    if data.type == 1 then
        if param ~= nil and data.trigger._arrCallBackTarget ~= nil and not data.action._actionData.ignoretarget then
            data.trigger._arrCallBackTarget[#data.trigger._arrCallBackTarget+1] = param
        end
    elseif data.type == 2 or data.type == 3 then
        data.buff._directCallBack = data.direct
        data.buff._positionCallBack = data.pos
        if param ~= nil and data.action._actionData ~= nil then
            if data.action._actionData.refskill == 1 then
                if param._skillCheckRef[data.buff._skillGid] == nil then
                    param._skillCheckRef[data.buff._skillGid] = 1
                else
                    param._skillCheckRef[data.buff._skillGid] = param._skillCheckRef[data.buff._skillGid] + 1
                end
            end
            if data.type == 3 and not data.action._actionData.ignoretarget then
                if data.trigger._arrThirdTarget ~= nil then
                    data.trigger._arrThirdTarget[#data.trigger._arrThirdTarget+1] = param
                end
            else
                if data.trigger._arrCallBackTarget ~= nil and not data.action._actionData.ignoretarget then
                    data.trigger._arrCallBackTarget[#data.trigger._arrCallBackTarget+1] = param
                end
            end
        end
    end
    data.trigger:OnTick()
end

function EffectActionCallBack(data, param)
    if not data.action or not data.action._actionData or data.action._callBackRef == 0 or not data.trigger._arrAction then
        return
    end
    if data.action._callBackRef > 0 then
        data.action._callBackRef = data.action._callBackRef-1
    end
    if data.action._callBackRef == 0 then
        data.action._actionState = eBuffActionState.Over
    end
    data.buff._directCallBack = data.direct
    data.trigger:ResetAllAction(data.action)
    if data.action._actionData and param then
        if data.action._actionData.refskill == 1 then
            if param._skillCheckRef[data.buff._skillGid] == nil then
                param._skillCheckRef[data.buff._skillGid] = 1
            else
                param._skillCheckRef[data.buff._skillGid] = param._skillCheckRef[data.buff._skillGid] + 1
            end
        end
    end
    if data.trigger._arrCallBackTarget ~= nil then
        data.trigger._arrCallBackTarget[#data.trigger._arrCallBackTarget+1] = param
    end
    data.trigger:OnTick()
end

function SequenceEffectActionCallBack(data, param)
    if not data.action or not data.action._actionData or data.action._callBackRef == 0 or not data.trigger._arrAction then
        return
    end
    if data.action._callBackRef > 0 then
        data.action._callBackRef = data.action._callBackRef-1
    end
    local target = nil
    if data.action._actionData.targettype == 0 then
        target = data.trigger._arrThirdTarget
    elseif data.action._actionData.targettype == 1 then
        target = data.buff._arrThirdTarget
    end
    if param ~= nil then
        param:AttachBuff(data.action._actionData.buffid, data.action._actionData.bufflv, data.buff._skillCreator, data.action._buffOwner:GetName(), -1, data.buff._skillGid, data.buff._directCallBack, 0, data.buff._skillID, data.buff._skillLevel, data.buff._defaultTarget, nil, false, nil)
    end
    data.action.sequenceIndex = data.action.sequenceIndex+1
    if target[data.action.sequenceIndex] == nil then
        if data.action._actionData.mintimes and data.action.sequenceIndex <= data.action._actionData.mintimes then
        else
            data.action._actionState = eBuffActionState.Over
            return
        end
    else
        data.action._beginFrame = PublicFunc.QueryCurTime()
    end
    local cbFunction = SequenceEffectActionCallBack
    local cbData = data
    if data.action._actionData.srctype == 0 then
        local curTarget = nil
        if data.action.sequenceIndex%(#target) == 0 then
            curTarget = target[#target];
        else
            curTarget = target[data.action.sequenceIndex%(#target)]
        end
        local pos = curTarget:GetPosition(true)
        local x = math.random(-data.action._actionData.radius, data.action._actionData.radius)
        pos.x = pos.x + x
        local z = math.sqrt(data.action._actionData.radius*data.action._actionData.radius-x*x)
        if math.random(0,2) <= 1 then
            z = -z
        end
        pos.z = pos.z + z
        if pos ~= nil then
            data.action._callBackRef = data.action._callBackRef + 1
            -- FightScene.CreateEffect(pos, gd_effect_data[data.action._actionData.effectid], cbFunction, cbData, curTarget, nil, nil, nil, true, data.buff._skillID)
            FightScene.CreateEffect(pos, ConfigManager.Get(EConfigIndex.t_effect_data, data.action._actionData.effectid), cbFunction, cbData, curTarget, nil, nil, nil, true, data.buff._skillID)
        end
    end
end

function MovePositionActionCallBack(data, param)
    if not data.action or not data.action._actionData or not data.trigger._arrAction then
        return
    end
    data.buff._directCallBack = data.direct
    local actionData = data.action._actionData;
    if param ~= nil then
        for k,v in pairs(param) do 
            if data.trigger._arrCallBackTarget ~= nil then
                data.trigger._arrCallBackTarget[#data.trigger._arrCallBackTarget+1] = v; 
            end
        end
    end
    data.action._actionState = eBuffActionState.Over
    data.trigger:OnTick()
end

function BeAttackAnimationActionCallBack(data)
    if not data.action or not data.action._actionData or not data.trigger._arrAction then
        return
    end
    data.action._actionState = eBuffActionState.Over
    data.trigger:OnTick()
end

function RepelActionCallBack(data)
    if not data.action or not data.action._actionData or not data.trigger._arrAction then
        return
    end
    data.action._actionState = eBuffActionState.Over
    data.trigger:OnTick()
end

function SkillSoundActionCallBack(data)
    if not data.action or not data.action._actionData or not data.trigger._arrAction then
        return
    end
    data.action._actionState = eBuffActionState.Over
    data.trigger:OnTick()
end

-----eBuffAction.AnimWithEffect-----
--srctype 0=忽略 1=buff释放者 2=buff接受者 3=技能释放者
--targettype 0=忽略 1=buff释放者 2=buff接受者 3=技能释放者 4=当前目标
--callbacktype 0=忽略 1=动作回调  2=特效碰撞回调
RunAnimationAction = Class(RunAnimationAction,BaseAction)
function RunAnimationAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
         --目标
        local target = nil
        if self._actionData.targettype == 4 then
            target = self._buff._defaultTarget
        elseif self._actionData.targettype == 5 then
            target = self._trigger._arrThirdTarget[1]
        end
        --播放者
        local srcObj = nil
        if self._actionData.callbacktype ~= 0 then
            self._cbFunction = AnimationActionCallBack
            self._cbData = {action=self, buff=self._buff, trigger=self._trigger, type=self._actionData.callbacktype, direct={x=0,y=0,z=1}, pos={x=0,y=0,z=0}}
        end
        if self._actionData.srctype == 1 then
        elseif self._actionData.srctype == 2 then
            srcObj = {}
            srcObj[1] = self._buffOwner
        elseif self._actionData.srctype == 3 then
            srcObj = {}
            srcObj[1] = ObjectManager.GetObjectByName(self._buff._skillCreator)
        elseif self._actionData.srctype == 4 then
            srcObj = self._trigger._arrThirdTarget
        elseif self._actionData.srctype == 5 then
            srcObj = self._trigger._arrCallBackTarget
        end
        if srcObj ~= nil then
            local len = #srcObj
            for i=1, len do
                if not srcObj[i]:IsDead() then
                    self._callBackRef = self._callBackRef+1
                    local _skill_cfg = ConfigManager.Get(EConfigIndex.t_skill_effect,self._actionData.animid)
                    srcObj[i]:SetAnimate(_skill_cfg.action_id, _skill_cfg, self._cbFunction, self._cbData, target, self._actionData.lock, self._buff._skillID, self._buff, self._trigger)
                    if self._actionData.have_prepare_step then
                        self._buff._prepared = false
                    end
                end
            end
        end
        if self._actionData.callbacktype == 0 then
            self._actionState = eBuffActionState.Over
	    elseif self._actionState == eBuffActionState.Begin then
		    self._actionState = eBuffActionState.Run
        end
    elseif self._actionState == eBuffActionState.Run then
        --app.log(tostring(PublicFunc.QueryDeltaTime(self._beginFrame)).."."..tostring(self._actionData.limit))
        if PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.limit then
            if self._actionData.callbacktype ~= 0 then
                AnimationActionCallBack(self._cbData, nil)
            end
            self._actionState = eBuffActionState.Over
        end
    end
    
    return self._actionState
end

function RunAnimationAction:RollBack()
    if self._actionData.lock then
        self._buffOwner:GetAniCtrler().lock = false
    end

    if not self._buffOwner:IsDead() and self._buffOwner.last_used_skill == self._buff._skillID and not self._actionData.notstand then
        self._buffOwner:GetAniCtrler():SetAni(EANI.stand)
    end
end

-----eBuffAction.UseThirdTarget-----
UseThirdTargetAction = Class(UseThirdTargetAction,BaseAction)
function UseThirdTargetAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._actionData.layer = self._actionData.layer or lay_all_role
        local oldTriggerThirdTargets = table.copy(self._trigger._arrThirdTarget)
        self._trigger._arrThirdTarget = {}
        self._buff._arrThirdTarget = {}
        if self._actionData.targettype == 0 then
            self._trigger._arrThirdTarget = {}
            self._trigger._arrCallBackTarget = {}
        else
            if self._actionData.arraytype == 1 and self._buff._defaultTarget ~= nil then
                self._actionState = eBuffActionState.Over
                return self._actionState
            end
            local arrayTarget = nil
            if self._actionData.arraytype == nil then
                arrayTarget = self._trigger._arrThirdTarget
            elseif self._actionData.arraytype == 0 then
                arrayTarget = self._buff._arrThirdTarget
            elseif self._actionData.arraytype == 1 then
                arrayTarget = {}
            elseif self._actionData.arraytype == 2 then
                self._buffOwner:GetBuffManager()._arrThirdTarget = {}
                arrayTarget = self._buffOwner:GetBuffManager()._arrThirdTarget
            end
            local calcu_local = false
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                if self._actionData.usetype == 0 then
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if skillCreator then
                        FightScene.FillSkillTargets(skillCreator, arrayTarget, self, false, actionTimes)
                    end
                elseif self._actionData.usetype == 1 then
                    calcu_local = true
                else
                    local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if user and (user:IsMyControl() or user:IsAIAgent())then
                        calcu_local = true
                    else
                        local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        if skillCreator then
                            if not FightScene.FillSkillTargets(skillCreator, arrayTarget, self, true, actionTimes) then
                                self._actionState = eBuffActionState.Run
                                return self._actionState
                            end
                        end
                    end
                end
            else
                calcu_local = true
            end
            if calcu_local then
                if self._actionData.typeindex then
                    local searchTargetData = g_SkillTargetsData[self._actionData.typeindex]
                    SkillManager.SearchSkillTarget(searchTargetData, self._buffOwner, self._buff._buffCreator, self._buff._skillCreator, self._buff._skillID, self._trigger._arrCallBackTarget, oldTriggerThirdTargets, self._buff._directCallBack,
                    self._buff._positionCallBack, self._buffOwner:GetBuffManager()._recordPosition, self._buff._recordPosition, self._buff._recordTowards, self._trigger._recordPosition, self._buff._multi_record_pos, self._buffOwner:GetBuffManager()._multi_record_pos, self._buff._defaultTarget, self._buff._skillGid, arrayTarget)
                else
                    SkillManager.SearchSkillTarget(self._actionData, self._buffOwner, self._buff._buffCreator, self._buff._skillCreator, self._buff._skillID, self._trigger._arrCallBackTarget, oldTriggerThirdTargets, self._buff._directCallBack,
                    self._buff._positionCallBack, self._buffOwner:GetBuffManager()._recordPosition, self._buff._recordPosition, self._buff._recordTowards, self._trigger._recordPosition, self._buff._multi_record_pos, self._buffOwner:GetBuffManager()._multi_record_pos, self._buff._defaultTarget, self._buff._skillGid, arrayTarget)
                end
                if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync and self._actionData.usetype ~= 1 then
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if skillCreator then
                        --[[if not skillCreator:IsAIAgent() then
                            local pos = nil
                            if skillCreator.aperture_manager then
                                skillCreator.aperture_manager:GetRTPosition(nil, true)
                            end
                            if pos then
                                msg_fight.cg_sync_aperture_pos(skillCreator:GetGID(), pos.x, pos.y, pos.z)
                            end
                        end]]

                        local info = {}
                        local targets_key = PublicFunc.GenerateSkillTargetIndex(info, self._buff._skillID, self._buff._buffBaseData.id, self._trigger._triggerData.trigger_index, self._actionData.action_index, self._actionTimes)
                        info.user_gid = skillCreator:GetGID()
                        info.targets_gid = {}
                        for i=1, #arrayTarget do
                            table.insert(info.targets_gid, arrayTarget[i]:GetGID())
                        end
                        msg_fight.cg_sync_skill_targets(info)
                    end    
                end
            end
            --app.log("UseThirdTarget num:"..#arrayTarget)
            if self._actionData.arraytype == 1 and (#arrayTarget > 0) then
                self._buff._defaultTarget = arrayTarget[1]
            end  
        end
        self._actionState = eBuffActionState.Over
    end
    
    return self._actionState
end

function UseThirdTargetAction:RollBack()
end


-----eBuffAction.ChangeAbilityScaleMultiply-----
--abilityname 属性名
--scale 改变数据
ChangeAbilityScaleMultiplyAction = Class(ChangeAbilityScaleMultiplyAction,BaseAction)
function ChangeAbilityScaleMultiplyAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local except_flag = 0
        if self._buff._skillID and self._buff._skillID > 0 and ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID) then
            except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).ability_except
        end
        if CheckExcept(self._buffOwner, except_flag) then
            self._actionTimes = self._actionTimes-1
        else
            local scale = self._actionData.scale
            local fromtype = ""
            if scale == nil then
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                if skillInfo and skillInfo[self._buff._skillLevel] then
                    if self._buff.ability_change_from == ENUM.AbilityChangeFrom.Self then
                        fromtype = "self_ability_change"
                        if skillInfo[self._buff._skillLevel].self_ability_change ~= 0 then
                            scale = skillInfo[self._buff._skillLevel].self_ability_change[self._actionData.abilityname]
                        end
                    elseif self._buff.ability_change_from == ENUM.AbilityChangeFrom.Enemy then
                        fromtype = "enemy_ability_change"
                        if skillInfo[self._buff._skillLevel].enemy_ability_change ~= 0 then
                            scale = skillInfo[self._buff._skillLevel].enemy_ability_change[self._actionData.abilityname]
                        end
                    elseif self._buff.ability_change_from == ENUM.AbilityChangeFrom.Friend then
                        fromtype = "friend_ability_change"
                        if skillInfo[self._buff._skillLevel].friend_ability_change ~= 0 then
                            scale = skillInfo[self._buff._skillLevel].friend_ability_change[self._actionData.abilityname]
                        end
                    else
                        fromtype = "not found creator"                                                    
                    end
                end
            end
            if scale == nil then
                self._actionTimes = self._actionTimes-1
                app.log("buff获取属性参数失败, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel).." fromtype="..fromtype.." buffid="..self._buff:GetBuffID().." lv="..self._buff:GetBuffLv().." ability="..self._actionData.abilityname)
            else
                if self._buffOwner:GetBuffManager():ScaleAbilityMultiply(self._actionData.abilityname, scale, true) then
                    self._value = scale
                    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        if user and (user:IsMyControl() or user:IsAIAgent()) and ENUM.EHeroAttribute[self._actionData.abilityname] ~= nil then
                            local duration = 0
                            if self._buff.duration > 0 and self._buff:GetOverlapType() ~= eBuffOverlapType.Overlap and self._buff:GetOverlapType() ~= eBuffOverlapType.SameAllResetTime and self._buff:GetOverlapType() ~= eBuffOverlapType.SameIDResetTime then
                                duration = self._buff.duration
                                self.send_cancel_msg = true
                            end
                            msg_fight.cg_scale_ability(user:GetGID(), self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, true, true, duration, (self._actionData.record and self._actionData.recordname or ""))
                        end
                    elseif PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
                        local frame_info = {}
                        frame_info.type = ENUM.FightKeyFrameType.ScaleAbilityMultiply
                        frame_info.integer_params = {}
                        frame_info.string_params = {}
                        frame_info.float_params = {}
                        local user_gid = 0
                        local user_pos = nil
                        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        if user then
                            user_gid = user:GetGID()
                            user_pos = user:GetPosition()
                        end
                        table.placeholder_insert_number(frame_info.integer_params, user_gid)
                        if user_pos then
                            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(user_pos.x))
                            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(user_pos.z))
                        else
                            table.placeholder_insert_number(frame_info.integer_params, 0)
                            table.placeholder_insert_number(frame_info.integer_params, 0)
                        end
                        table.placeholder_insert_number(frame_info.integer_params, self._buffOwner:GetGID())
                        local target_pos = self._buffOwner:GetPosition();
                        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.x))
                        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.z))
                        table.placeholder_insert_number(frame_info.integer_params, 1)
                        table.placeholder_insert_number(frame_info.integer_params, self._buff._skillID)
                        table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffID())
                        table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffLv())
                        table.placeholder_insert_number(frame_info.integer_params, self._trigger._triggerData.trigger_index)
                        table.placeholder_insert_number(frame_info.integer_params, self._actionData.action_index)
                        table.placeholder_insert_number(frame_info.float_params, self._value)
                        FightKeyFrameInfo.AddKeyInfo(frame_info)
                    end
                    ----------------飘字--------------
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if self._buffOwner._headInfoControler:Check(skillCreator) then
                        local abilityid = ENUM.EHeroAttribute[self._actionData.abilityname];
                        local offset_abilityid = abilityid-ENUM.min_property_id-1;
                        local offset_typeid = ENUM.EHeadInfoShowType.MaxHpUp-1;
                        local typeid = offset_abilityid*2-1+offset_typeid;
                        if scale > 1 then
                            self._buffOwner:GetHeadInfoControler():ShowArtisticText(typeid)
                        else
                            self._buffOwner:GetHeadInfoControler():ShowArtisticText(typeid+1)
                        end
                    end
                    ----------------------------------
                    if self._actionData.record then
                        local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        if skillCreator then
                            local cur = self._buffOwner:GetPropertyVal(self._actionData.abilityname)
                            local after = cur*self._value
                            skillCreator:SetExternalArea(self._actionData.recordname, math.abs(after-cur))
                        end
                    end
                else
                    self._actionTimes = self._actionTimes - 1
                end
            end
            
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeAbilityScaleMultiplyAction:RollBack()
    for i=1, self._actionTimes do
        self._buffOwner:GetBuffManager():ScaleAbilityMultiply(self._actionData.abilityname, self._value, false)
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
            if self._buff.duration > 0 and self._buff:GetOverlapType() ~= eBuffOverlapType.Overlap and self._buff:GetOverlapType() ~= eBuffOverlapType.SameAllResetTime and self._buff:GetOverlapType() ~= eBuffOverlapType.SameIDResetTime then
                duration = self._buff.duration
            end
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_scale_ability(0, self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, false, true, duration)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) and ENUM.EHeroAttribute[self._actionData.abilityname] ~= nil then
                    msg_fight.cg_scale_ability(0, self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, false, true, duration)
                end
            end
        elseif PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
            local frame_info = {}
            frame_info.type = ENUM.FightKeyFrameType.ScaleAbilityMultiply
            frame_info.integer_params = {}
            frame_info.string_params = {}
            frame_info.float_params = {}
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, self._buffOwner:GetGID())
            local target_pos = self._buffOwner:GetPosition();
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.x))
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.z))
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, self._buff._skillID)
            table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffID())
            table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffLv())
            table.placeholder_insert_number(frame_info.integer_params, self._trigger._triggerData.trigger_index)
            table.placeholder_insert_number(frame_info.integer_params, self._actionData.action_index)
            table.placeholder_insert_number(frame_info.float_params, self._value)
            FightKeyFrameInfo.AddKeyInfo(frame_info)
        end
    end
end

-----eBuffAction.MakeDamage-----
MakeDamageAction = Class(MakeDamageAction,BaseAction)
function MakeDamageAction:RunAction(force, actionTimes)
    --todo(Nation)
    if self._super.RunAction(self, force, actionTimes) then
        if not self._buffOwner:IsDead() then
            --app.log("id="..self._buff:GetBuffID().." lv="..self._buff:GetBuffLv().." "..debug.traceback())
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                if user and (user:IsMyControl() or user:IsAIAgent())then
                    local ex_persent = 1.0
                    if self._actionData.persent then
                        ex_persent = self._actionData.persent
                    end
                    local calculate_info = {}
                    calculate_info.user_gid = user:GetGID()
                    calculate_info.target_gid = self._buffOwner:GetGID()
                    calculate_info.skill_id = self._buff._skillID
                    calculate_info.skill_type = 0
                    calculate_info.calc_type = self._actionData.type
                    calculate_info.calc_info_index = self._actionData.infoindex
                    calculate_info.ex_persent = ex_persent

                    local pos = self._buffOwner:GetPosition()
                    local direct = self._buffOwner:GetForWard()
                    local target_pos = user:GetPosition()
                    if algorthm.AtSector(pos.x, pos.z, 100, direct, 180, target_pos.x, target_pos.z) then
                        calculate_info.is_front_attcker = true
                    end
                    msg_fight.cg_skill_calculate(calculate_info)
                end
            else
                local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                local damageInfo = nil
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                if skillInfo and skillInfo[self._buff._skillLevel] then
                    damageInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.infoindex]
                    if damageInfo and damageInfo.skillrefscale == 1 then
                        damageInfo.skillgid = self._buff._skillGid
                    end
                end
                local damage = nil
                if self._actionData.type == 0 then
                    if damageInfo == nil then
                        app.log("计算伤害时damageInfo_"..tostring(self._actionData.infoindex).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                    end
                    damage = self._buffOwner:CalcuDamageAsTarget(self._buff._skillCreator, damageInfo, self._buff._skillID);
                elseif self._actionData.type == 1 then
                    local hp = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.max_hp)*self._actionData.persent
                    hp = PublicFunc.AttrInteger(hp)
                    self._buffOwner:OnGainHP(-hp, skill_creator, false)
                    damage = hp
                elseif self._actionData.type == 2 then
                    local hp = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)*self._actionData.persent
                    hp = PublicFunc.AttrInteger(hp)
                    self._buffOwner:OnGainHP(-hp, skill_creator, false)
                    damage = hp
                elseif self._actionData.type == 3 then
                    if damageInfo == nil then
                        app.log("计算伤害时damageInfo_"..tostring(self._actionData.infoindex).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                    end
                    damageInfo.use_fix_attack = true
                    damageInfo.src_atk_power = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.atk_power) * self._actionData.persent
                    damage = self._buffOwner:CalcuDamageAsTarget(self._buff._skillCreator, damageInfo, self._buff._skillID)
                elseif self._actionData.type == 4 then
                    if skill_creator and damageInfo then
                        local _damage = skill_creator:GetPropertyVal(ENUM.EHeroAttribute.max_hp)*self._actionData.persent;
                        damage = self._buffOwner:CalcuDamageAsTarget(self._buff._skillCreator, damageInfo, self._buff._skillID, _damage)
                    end
                elseif self._actionData.type == 5 then
                    if skill_creator then
                        damage = skill_creator:GetBuffManager()._nRecordDamage * self._actionData.persent;
                        self._buffOwner:OnGainHP(PublicFunc.AttrInteger(-damage), skill_creator, false)
                    end
                end
                if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
                    local frame_info = {}
                    frame_info.type = ENUM.FightKeyFrameType.MakeDamage
                    frame_info.integer_params = {}
                    frame_info.string_params = {}
                    table.placeholder_insert_number(frame_info.integer_params, self._buffOwner:GetGID())
                    local target_pos = self._buffOwner:GetPosition();
                    table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.x))
                    table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.z))
                    if skill_creator then
                        table.placeholder_insert_number(frame_info.integer_params, skill_creator:GetGID())
                        local creator_pos = skill_creator:GetPosition();
                        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(creator_pos.x))
                        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(creator_pos.z))
                    else
                        table.placeholder_insert_number(frame_info.integer_params, 0)
                        table.placeholder_insert_number(frame_info.integer_params, 0)
                        table.placeholder_insert_number(frame_info.integer_params, 0)
                    end
                    table.placeholder_insert_number(frame_info.integer_params, self._buff._skillID)
                    table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffID())
                    table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffLv())
                    table.placeholder_insert_number(frame_info.integer_params, self._trigger._triggerData.trigger_index)
                    table.placeholder_insert_number(frame_info.integer_params, self._actionData.action_index)
                    if damage then
                        table.placeholder_insert_number(frame_info.integer_params, math.ceil(damage));
                    else
                        table.placeholder_insert_number(frame_info.integer_params, 0)
                    end
                    FightKeyFrameInfo.AddKeyInfo(frame_info)
                end
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function MakeDamageAction:RollBack()
end

-----eBuffAction.AttachBuff-----
--buffid
--bufflv
--maxnes 最大次数
--targettype 0=buff接受者 1=trigger第三方结果 2=triggerCallBack结 3=entity存的结果 4=buff第三方结果
AttachBuffAction = Class(AttachBuffAction,BaseAction)
function AttachBuffAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local nestTimes = nil
        if self._buff._nestTimes ~= nil and self._actionData.buffid == self._buff:GetBuffID() and self._actionData.bufflv == self._buff:GetBuffLv() then
            self._buff._nestTimes = self._buff._nestTimes - 1
            nestTimes = self._buff._nestTimes
        end
        if nestTimes ~= 0 then
            
            if nestTimes == nil then
                nestTimes = self._actionData.maxnes
            end
            local target = {}
            if self._actionData.targettype == 0 then
                target[1] = self._buffOwner;
            elseif self._actionData.targettype == 1 then
                target = self:_GetTargetByIndex(self._trigger._arrThirdTarget)
            elseif self._actionData.targettype == 2 then
                target = self:_GetTargetByIndex(self._trigger._arrCallBackTarget)
            elseif self._actionData.targettype == 3 then
                if self._buffOwner._AttackerName then
                    target[1] = ObjectManager.GetObjectByName(self._buffOwner._AttackerName);
                end
            elseif self._actionData.targettype == 4 then
                target = self:_GetTargetByIndex(self._buff._arrThirdTarget);
            elseif self._actionData.targettype == 5 then
                target[1] = ObjectManager.GetObjectByName(self._buff._skillCreator)
            elseif self._actionData.targettype == 6 then
                target = self:_GetTargetByIndex(self._buffOwner:GetBuffManager()._arrThirdTarget)
            elseif self._actionData.targettype == 7 then
                target[1] = self._buff._defaultTarget
            end
            local len = #target
            for i=1, len do
                if self._actionData.refskill == 1 then
                    if target[i]._skillCheckRef[self._buff._skillGid] == nil then
                        target[i]._skillCheckRef[self._buff._skillGid] = 1
                    else
                        target[i]._skillCheckRef[self._buff._skillGid] = target[i]._skillCheckRef[self._buff._skillGid] + 1
                    end
                end
                --app.log(target[i]:GetName().." attahbuff "..self._actionData.buffid.."-"..self._actionData.bufflv)
                target[i]:AttachBuff(self._actionData.buffid, self._actionData.bufflv, self._buff._skillCreator, self._buffOwner:GetName(), nestTimes, self._buff._skillGid, self._buff._directCallBack, nil, self._buff._skillID, self._buff._skillLevel, self._buff._defaultTarget, nil, false, self._actionData.overlap)
                if self._actionData.sendserver then
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if skillCreator and (skillCreator:IsMyControl() or skillCreator:IsAIAgent())then
                        msg_fight.cg_add_buff(skillCreator:GetGID(), target[i]:GetGID(), self._actionData.buffid, self._actionData.bufflv, self._buff._skillID, self._buff._skillLevel)
                    end
                end
                
                if self._actionData.rollback == true then
                    self._attachBuffTargets[#self._attachBuffTargets+1] = target[i]:GetName()
                end
            end
        end
        self._success = true;
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function AttachBuffAction:RollBack()
    local len = #self._attachBuffTargets
    for i=1, len do
        local entity = ObjectManager.GetObjectByName(self._attachBuffTargets[i])
        if entity then
            entity:DetachBuff(self._actionData.buffid, self._actionData.bufflv, true )
        end
    end
end

function AttachBuffAction:_GetTargetByIndex(list)
    local target = {};
    if list ~= nil then
        local len = #list
        if self._actionData.targetindex == nil then
            target = list 
        elseif self._actionData.targetindex == 0 then
            if len ~= 0 then
                target[1] = list[math.random(1,len)]
            end  
        else
            if list[self._actionData.targetindex] ~= nil then
                target[1] = list[self._actionData.targetindex]
            else
                target[1] = list[(self._actionData.targetindex%len)+1]
            end
        end
    end
    return target;
end

-----eBuffAction.RunEffect-----
--srctype 0=忽略 1=buff释放者 2=buff接受者 3=技能释放者
--targettype 0=忽略 1=buff释放者 2=buff接受者 3=技能释放者  4=当前目标  5=默认目标 
--           6=buff接受者附近计数最小的玩家
--radius   targettype为6时代表范围
--callbacktype 0=忽略 1特效碰撞回调
--effectid 动作id
--limit 超时时间(毫秒)
--musttarget 必须要目标
RunEffectAction = Class(RunEffectAction,BaseAction)
function RunEffectAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.callbacktype == nil then
            self._actionData.callbacktype = 0
        end
        local effectid = 0
        local point = string.find(""..self._actionData.effectid, ".", 1, true)
        if point == nil then
            effectid = self._actionData.effectid
        else
            local min = string.sub(""..self._actionData.effectid, 1, point)
            local max = string.sub(""..self._actionData.effectid, point+1)
            effectid = math.random(min, max)
        end
        if self._actionData.handlehit == nil then
            self._actionData.handlehit = true
        end
         --目标
        local target = {}
        if self._actionData.targettype == 2 then
            target[1] = self._buffOwner
        elseif self._actionData.targettype == 4 then
            target[1] = self._buff._defaultTarget--self._buffOwner:GetAttackTarget()
        elseif self._actionData.targettype == 5 then
            target[1] = self._buff._defaultTarget
        elseif self._actionData.targettype == 6 then
            if self._actionData.targetindex == nil then
                target = self._trigger._arrThirdTarget
            elseif self._actionData.targetindex == 0 then
                local len = #self._trigger._arrThirdTarget
                if len ~= 0 then
                    target[1] = self._trigger._arrThirdTarget[math.random(1,len)]
                end  
            else
                if self._trigger._arrThirdTarget[self._actionData.targetindex] ~= nil then
                    target[1] = self._trigger._arrThirdTarget[self._actionData.targetindex]
                else
                    local len = #self._trigger._arrThirdTarget
                    target[1] = self._trigger._arrThirdTarget[(self._actionData.targetindex%len)+1]
                end
            end
        elseif self._actionData.targettype == 7 then
            if self._actionData.targetindex == nil then
                target = self._buffOwner._arrThirdTarget
            elseif self._actionData.targetindex == 0 then
                local len = #self._buff._arrThirdTarget
                if len ~= 0 then
                    target[1] = self._buff._arrThirdTarget[math.random(1,len)]
                end  
            else
                if self._buff._arrThirdTarget[self._actionData.targetindex] ~= nil then
                    target[1] = self._buff._arrThirdTarget[self._actionData.targetindex]
                else
                    local len = #self._buff._arrThirdTarget
                    target[1] = self._buff._arrThirdTarget[(self._actionData.targetindex%len)+1]
                end
            end
        elseif self._actionData.targettype == 8 then
            if self._actionData.targetindex == nil then
                target = self._buffOwner:GetBuffManager()._arrThirdTarget
            elseif self._actionData.targetindex == 0 then
                local len = #self._buffOwner:GetBuffManager()._arrThirdTarget
                if len ~= 0 then
                    target[1] = self._buffOwner:GetBuffManager()._arrThirdTarget[math.random(1,len)]
                end  
            else
                if self._buffOwner:GetBuffManager()._arrThirdTarget[self._actionData.targetindex] ~= nil then
                    target[1] = self._buffOwner:GetBuffManager()._arrThirdTarget[self._actionData.targetindex]
                else
                    local len = #self._buffOwner:GetBuffManager()._arrThirdTarget
                    target[1] = self._buffOwner:GetBuffManager()._arrThirdTarget[(self._actionData.targetindex%len)+1]
                end
            end
        end
        --播放者
        local runSuccess = false
        local effectPlayer = {}
        if self._actionData.srctype == 1 then
        elseif self._actionData.srctype == 2 then
            effectPlayer[1] = self._buffOwner
        elseif self._actionData.srctype == 3 then
        elseif self._actionData.srctype == 4 then
            effectPlayer = self._trigger._arrCallBackTarget
        elseif self._actionData.srctype == 5 then
            if self._actionData.targetindex == nil then
                effectPlayer = self._trigger._arrThirdTarget
            elseif self._actionData.targetindex == 0 then
                local len = #self._trigger._arrThirdTarget
                if len ~= 0 then
                    effectPlayer[1] = self._trigger._arrThirdTarget[math.random(1,len)]
                end  
            else
                if self._trigger._arrThirdTarget[self._actionData.targetindex] ~= nil then
                    effectPlayer[1] = self._trigger._arrThirdTarget[self._actionData.targetindex]
                else
                    local len = #self._trigger._arrThirdTarget
                    effectPlayer[1] = self._trigger._arrThirdTarget[(self._actionData.targetindex%len)+1]
                end
            end
        elseif self._actionData.srctype == 7 then
            local len = #self._buff._arrThirdTarget
            effectPlayer[1] = self._buff._arrThirdTarget[len]
        elseif self._actionData.srctype == 8 then
            effectPlayer[1] = self._buff._defaultTarget
        elseif self._actionData.srctype == 9 then
            effectPlayer = self._buff._arrThirdTarget
        end
        if self._actionData.callbacktype ~= 0 then
            self._cbFunction = EffectActionCallBack
            self._cbData = {action=self, buff=self._buff, trigger=self._trigger, type=self._actionData.callbacktype, direct={x=0,y=0,z=1}, effectid=effectid }
        end
        local direct = nil
        if self._actionData.direct == 0 then
            if self._buff._directCallBack ~= nil then
                direct = self._buff._directCallBack
            end
        elseif self._actionData.direct == 1 then
            local srcDir = self._buffOwner:GetForWard()
            local rx,ry,rz,rw = util.quaternion_euler(0, self._actionData.directoffset, 0);
            local resultX,resultY,resultZ = util.quaternion_multiply_v3(rx, ry, rz, rw, srcDir.x, srcDir.y, srcDir.z);
            resultY = 0
            direct = {}
            direct.x, direct.y, direct.z = util.v3_normalized(resultX, resultY, resultZ);
        elseif self._actionData.direct == 2 then
            direct = self._buffOwner:GetBuffManager()._recordTowards
        elseif self._actionData.direct == 3 then
            direct = self._buff._recordTowards
        end
        local collisionInfo = nil
        local _effect_data = ConfigManager.Get(EConfigIndex.t_effect_data,effectid)
        if _effect_data and _effect_data.type == 3 then
            collisionInfo = {}
            collisionInfo.cbuff = self._actionData.cbuff
            collisionInfo.checkret = self._actionData.checkret
            collisionInfo.skillid = self._buff._skillID
        end
        local nLen = #target
        if self._actionData.srctype == 6 then
            local pos = nil
            if self._actionData.position == 0 then
                local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                local fromController = true
                if skillCreator then
                    if skillCreator:IsAIAgent() then
                        fromController = false
                    else
                        fromController = skillCreator:IsMyControl()
                    end
                    if skillCreator.aperture_manager then
                        pos = skillCreator.aperture_manager:GetRTPosition(skillCreator.aperture_manager.apertureType[5], fromController)
                    end
                end
                if pos == nil or (pos.x==0 and pos.y==0 and pos.z==0) then
                    if self._buff._defaultTarget ~= nil then
                        pos = self._buff._defaultTarget:GetPosition(true)
                    else
                        pos = self._buffOwner:GetPosition(true)
                    end
                end
            elseif self._actionData.position == 1 then
                pos = self._buffOwner:GetPosition(true)
                local x = math.random(-5, 5)
                pos.x = pos.x + x
                local z = math.sqrt(25-x*x)
                if math.random(0,2) < 1 then
                    z = -z
                end
                pos.z = pos.z + z
            elseif self._actionData.position == 2 then
                pos = self._buff._positionCallBack
                local src_pos = self._buffOwner:GetPosition(true)
                pos.y = src_pos.y
            elseif self._actionData.position == 3 then
                pos = self._buffOwner:GetPosition(true)
            elseif self._actionData.position == 4 then
                self._buffOwner:GetBuffManager()._recordPosition.x = self._buffOwner:GetBuffManager()._recordPosition.x + (self._buffOwner:GetBuffManager()._recordTowards.x*self._actionData.speed*0.001*self._actionData.passtime)
                self._buffOwner:GetBuffManager()._recordPosition.z = self._buffOwner:GetBuffManager()._recordPosition.z + (self._buffOwner:GetBuffManager()._recordTowards.z*self._actionData.speed*0.001*self._actionData.passtime)
                pos = self._buffOwner:GetBuffManager()._recordPosition
                self._buff._recordPosition.x = self._buffOwner:GetBuffManager()._recordPosition.x
                self._buff._recordPosition.y = self._buffOwner:GetBuffManager()._recordPosition.y
                self._buff._recordPosition.z = self._buffOwner:GetBuffManager()._recordPosition.z
            elseif self._actionData.position == 5 then
                pos = self._buff._recordPosition
            elseif self._actionData.position == 6 then
                self._buffOwner:GetBuffManager()._recordPosition.x = self._buffOwner:GetBuffManager()._recordPosition.x + (self._buffOwner:GetBuffManager()._recordTowards.x*self._actionData.length)
                self._buffOwner:GetBuffManager()._recordPosition.z = self._buffOwner:GetBuffManager()._recordPosition.z + (self._buffOwner:GetBuffManager()._recordTowards.z*self._actionData.length)
                pos = self._buffOwner:GetBuffManager()._recordPosition
                self._buff._recordPosition.x = self._buffOwner:GetBuffManager()._recordPosition.x
                self._buff._recordPosition.y = self._buffOwner:GetBuffManager()._recordPosition.y
                self._buff._recordPosition.z = self._buffOwner:GetBuffManager()._recordPosition.z
            elseif self._actionData.position == 7 then
                pos = self._buffOwner:GetPosition();                   
                local forward = self._buffOwner:GetForWard();
                pos.x = pos.x + forward.x*self._actionData.len;
                pos.y = pos.y + forward.y*self._actionData.len;
                pos.z = pos.z + forward.z*self._actionData.len;
            elseif self._actionData.position == 8 then
                pos = self._trigger._recordPosition
            elseif self._actionData.position == 9 then
                pos = self._buffOwner:GetBuffManager()._multi_record_pos[self._actionData.posindex]
            elseif self._actionData.position == 10 then
                pos = self._buffOwner:GetBuffManager()._recordPosition
            end
            if pos ~= nil then
                self._callBackRef = self._callBackRef+1
                local not_create = false;
                if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync and self._actionData.createworlditem then
                    not_create  = true
                end
                if not not_create then
                    self._effectUUID = FightScene.CreateEffect(pos, ConfigManager.Get(EConfigIndex.t_effect_data,effectid), self._cbFunction, self._cbData, target[1], direct, self._actionData.durationtime, nil, true, self._buff._skillID)
                else
                    self._effectUUID = {}
                    self._effectUUID[1] = -1
                end
                if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync and self._actionData.createworlditem then
                    local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if user and (user:IsMyControl() or user:IsAIAgent()) then
                        local duration = 0
                        if self._buff.duration > 0 then
                            duration = self._buff.duration
                        end
                        msg_fight.cg_create_world_item(user:GetGID(), self._actionData.createworlditem, pos.x*PublicStruct.Coordinate_Scale, pos.z*PublicStruct.Coordinate_Scale, duration)
                        self._effectPos = pos
                    end
                end
                runSuccess = true
            end
        else
            local end_pos = nil
            if self._actionData.targetpos == 1 then
                end_pos = self._buff._recordPosition
            elseif self._actionData.targetpos == 2 then
                end_pos = self._buffOwner:GetBuffManager()._recordPosition;
            end
            local effect_data = ConfigManager.Get(EConfigIndex.t_effect_data,effectid)
            local durationtime = self._actionData.durationtime
            if durationtime == nil and self._actionData.durationwithspeed then
                local skillDistance = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).distance
                durationtime = (skillDistance+1.5)/effect_data.speed*1000
            end
            local use_time = self._actionData.usetime
            if nLen == 0 then
                if self._actionData.musttarget == 1 then
                    self._actionState = eBuffActionState.Over
                else--if self._actionData.targettype == 0 then
                    local srcLen = #effectPlayer
                    for i=1, srcLen do
                        self._callBackRef = self._callBackRef+1
                        self._effectUUID = effectPlayer[i]:SetEffect(self._buff._skillCreator, effect_data, self._cbFunction, self._cbData, nil, direct, durationtime, nil, collisionInfo, self._actionData.handlehit, self._buff._skillID, end_pos, use_time)
                        runSuccess = true
                    end
                end
            else
                for i=1, nLen do
                    local srcLen = #effectPlayer
                    for j=1, srcLen do
                        self._callBackRef = self._callBackRef+1
                        self._effectUUID = effectPlayer[j]:SetEffect(self._buff._skillCreator, effect_data, self._cbFunction, self._cbData, target[1], direct, durationtime, nil, collisionInfo, self._actionData.handlehit, self._buff._skillID, end_pos, use_time)
                        runSuccess = true
                    end
                end
            end
        end
        if self._actionData.callbacktype == 0 or runSuccess == false then
            self._actionState = eBuffActionState.Over
	    elseif self._actionState == eBuffActionState.Begin then
		    self._actionState = eBuffActionState.Run
        end
    elseif self._actionState == eBuffActionState.Run then
        if PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.limit then
            if self._actionData.callbacktype ~= 0 then
                EffectActionCallBack(self._cbData, nil)
            end
            self._actionState = eBuffActionState.Over
        end
    end
    return self._actionState
end

function RunEffectAction:RollBack()
    if self._effectUUID then
        for i=1, #self._effectUUID do
            if self._effectUUID[i] ~= -1 then
                EffectManager.deleteEffect( self._effectUUID[i] )
            end
        end
        if #self._effectUUID >0 and PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync and self._actionData.createworlditem then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                end
                msg_fight.cg_del_world_item(user:GetGID(), self._actionData.createworlditem, self._effectPos.x*PublicStruct.Coordinate_Scale, self._effectPos.z*PublicStruct.Coordinate_Scale, duration)
            end
        end
    end
end

-----------eBuffAction.SpecialEffect-----------
SpecialEffectAction = Class(SpecialEffectAction,BaseAction)
function SpecialEffectAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local take_effect = true
        local real_process = true
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if (not self._buffOwner:IsMyControl()) and (not self._buffOwner:IsAIAgent()) then
                real_process = false
            end
        end
        local except_flag = 0
        local skill_info = nil
        if self._buff._skillID and self._buff._skillID > 0 and ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID) then
            if self._actionData.effect_type == ESpecialEffectType.XuanYun then
                except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).vertigo_except
            elseif self._actionData.effect_type == ESpecialEffectType.DingShen then
                except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).dingshen_except
            elseif self._actionData.effect_type == ESpecialEffectType.ChenMo then
                except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).silence_except
            end
            if except_flag and except_flag ~= 0 and CheckExcept(self._buffOwner, except_flag) then
                take_effect = false
            end
        end
        if take_effect then
            self.real_process = real_process
            self._value = self._buffOwner:GetBuffManager():SpecialEffect(self._actionData.effect_type, true, real_process, self._buff._skillCreator)
            if self._value --[[or (not real_process)]] then
                self._success = true;
            end
        end
        self._actionState = eBuffActionState.Over
    end

    
    return self._actionState
end

function SpecialEffectAction:RollBack()
    if self._value then
        self._buffOwner:GetBuffManager():SpecialEffect(self._value, false, self.real_process)
    end
end

-----------eBuffAction.ImmuneEnemySkill-----------
ImmuneEnemySkillAction = Class(ImmuneEnemySkillAction,BaseAction)
function ImmuneEnemySkillAction:RunAction(force, actionTimes)
    --todo(Nation)
    if self._super.RunAction(self, force, actionTimes) then
        
        self._actionState = eBuffActionState.Over
    end

    
    return self._actionState
end

function ImmuneEnemySkillAction:RollBack()
end

-----------eBuffAction.DamageScaleFromSkillCreator-----------
DamageScaleFromSkillCreatorAction = Class(DamageScaleFromSkillCreatorAction,BaseAction)
function DamageScaleFromSkillCreatorAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if skill_creator then
            self._buffOwner:GetBuffManager()._damageFromSkillCreatorScale = self._actionData.scale
            self._buffOwner:GetBuffManager()._damageFromSkillCreatorGID = skill_creator:GetGID()
            
        end
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        if skill_creator and (skill_creator:IsMyControl() or skill_creator:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.f_value1 = self._actionData.scale
                info.n_value2 = skill_creator:GetGID()
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 10, info, duration)
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DamageScaleFromSkillCreatorAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if self._buffOwner:GetBuffManager()._damageFromSkillCreatorScale and self._buffOwner:GetBuffManager()._damageFromSkillCreatorGID then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.f_value1 = self._buffOwner:GetBuffManager()._damageFromSkillCreatorScale
            info.n_value2 = self._buffOwner:GetBuffManager()._damageFromSkillCreatorGID
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 10, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 10, info, duration)
		        end
	        end
        end
    end
    self._buffOwner:GetBuffManager()._damageFromSkillCreatorScale = nil
    self._buffOwner:GetBuffManager()._damageFromSkillCreatorGID = nil
end

-----------eBuffAction.Hide-----------
HideAction = Class(HideAction,BaseAction)
function HideAction:RunAction(force, actionTimes)
    --todo(Nation)
    if self._super.RunAction(self, force, actionTimes) then
        
        self._buffOwner:SetHide(true)
        self._actionState = eBuffActionState.Over
    end

    
    return self._actionState
end

function HideAction:RollBack()
    self._buffOwner:SetHide(false)
end

-----------eBuffAction.DetachBuff-----------
DetachBuffAction = Class(DetachBuffAction,BaseAction)
function DetachBuffAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.immediately == nil then
            self._actionData.immediately = true
        end
        if self._actionData.targettype == 0 then
            if self._actionData.buffid == nil and self._actionData.bufflv == nil then
                self._buffOwner:DetachBuffObject(self._buff, self._actionData.immediately )
            else
                self._buffOwner:DetachBuff(self._actionData.buffid, self._actionData.bufflv, self._actionData.immediately )
            end
        elseif self._actionData.targettype == 1 then
            local len = #self._trigger._arrThirdTarget
            for i=1, len do
                self._trigger._arrThirdTarget[i]:DetachBuff(self._actionData.buffid, self._actionData.bufflv, self._actionData.immediately )
            end
        elseif self._actionData.targettype == 2 then
            if self._trigger._arrCallBackTarget ~= nil then
                local len = #self._trigger._arrCallBackTarget
                for i=1, len do
                    self._trigger._arrCallBackTarget[i]:DetachBuff(self._actionData.buffid, self._actionData.bufflv, self._actionData.immediately )
                end
            end
        elseif self._actionData.targettype == 3 then
            local targetTable = self._buffOwner:GetFrozenTargetList()
            for k, v in pairs(targetTable) do
                local target = ObjectManager.GetObjectByName(v)
                if target then
                    target:DetachBuff(self._actionData.buffid, self._actionData.bufflv, self._actionData.immediately )
                end
            end
        elseif self._actionData.targettype == 4 then
            local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if skill_creator then
                skill_creator:DetachBuff(self._actionData.buffid, self._actionData.bufflv, self._actionData.immediately )
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DetachBuffAction:RollBack()
end

-----------eBuffAction.ShowAperture-----------
ShowApertureAction = Class(ShowApertureAction,BaseAction)
function ShowApertureAction:RunAction(force, actionTimes)
    if self._beginFrame and self._actionData.hideprepared then
        if self._buff._prepared or (PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.limit) then
            self:RollBack()
            self._value = nil
        end
    end
    if self._super.RunAction(self, force, actionTimes) then
        local show = true
        if self._actionData.onlycaptain and self._buffOwner ~= FightManager.GetMyCaptain() then
            show = false
        end
        if show then
            local skillDistance = self._actionData.distance
            if skillDistance == nil then
                skillDistance = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).distance 
            end
            skillDistance = skillDistance + PublicStruct.Const.SEARCH_OBJ_RADIUS_OFFSET
            local skillExtraDistance = self._actionData.extradistance
            if skillExtraDistance == nil then
                skillExtraDistance = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).extra_distance
            end
            local skillWitdh = self._actionData.width
            if skillWitdh == nil then
                skillWitdh = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).width
            end
            local position = self._buffOwner:GetPosition(true)
            if self._buffOwner.aperture_manager then
                if self._actionData.type == 0 then
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[6], true, self._buffOwner:GetBindObj(3), 0, 0, 0, skillDistance, skillDistance, self._buffOwner, nil, true, nil);
                elseif self._actionData.type == 1 then
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[6], true, self._buffOwner:GetBindObj(3), 0, 0.01, 0, skillDistance, skillDistance, self._buffOwner, nil, true, nil);
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[7], true, self._buffOwner:GetBindObj(3), 0, 0.01, 0, skillExtraDistance, skillExtraDistance, self._buffOwner, nil, true, nil);
                elseif self._actionData.type == 2 then
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[12], true, nil, 0, 0.01, 0, skillWitdh, skillDistance, nil, nil, true, self._buffOwner:GetForWard())
                    self._buffOwner.last_skill_aperture = self._buffOwner.aperture_manager.apertureType[12]
                    if self._actionData.angle then
                        local angle = self._buffOwner:GetRotation().y + self._actionData.angle;
                        self._buffOwner.aperture_manager:SetNotMoveAngle(angle, self._buffOwner.aperture_manager.apertureType[12])
                    end
                elseif self._actionData.type == 3 then
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[11], true, nil, 0, 0.01, 0, skillDistance, skillDistance, nil, nil, true, self._buffOwner:GetForWard())
                    self._buffOwner.last_skill_aperture = self._buffOwner.aperture_manager.apertureType[11]
                elseif self._actionData.type == 4 then
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[0], true, self._buffOwner:GetBindObj(3), 0, 0.01, 0, skillDistance, skillDistance, self._buffOwner, nil, true, nil);
                    self._buffOwner.aperture_manager:Open(self._buffOwner.aperture_manager.apertureType[5], position.x, position.y+0.01, position.z, skillExtraDistance, skillDistance, 1)
                elseif self._actionData.type == 5 then
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[0], true, self._buffOwner:GetBindObj(3), 0, 0.01, 0, skillDistance, skillDistance, self._buffOwner, nil, true, nil);
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[1], true, self._buffOwner:GetBindObj(3), 0, 0.01, 0, skillDistance-skillExtraDistance*2, skillDistance-skillExtraDistance*2, self._buffOwner, nil, true, nil);
                    local target = self._buffOwner:GetAttackTarget()
                    local dir
                    if target then
                        local targetPos = target:GetPosition(true)
                        dir = {}
                        dir.x = targetPos.x - position.x;
                        dir.y = 0
                        dir.z = targetPos.z - position.z;
                        dir.x, dir.y, dir.z = util.v3_normalized(dir.x, dir.y, dir.z);
                    else
                        dir = self._buffOwner:GetForWard()
                    end
                    self._buffOwner.aperture_manager:Open(self._buffOwner.aperture_manager.apertureType[5], position.x, position.y+0.01, position.z, skillExtraDistance, skillDistance-skillExtraDistance, 1, true, dir)
                elseif self._actionData.type == 6 then
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[2], true, nil, 0, 0.01, 0, 1, skillDistance, self._buffOwner, true, true, self._buffOwner:GetForWard())
                    self._buffOwner.last_skill_aperture = self._buffOwner.aperture_manager.apertureType[2]
                elseif self._actionData.type >= 7 and self._actionData.type <= 11 then
                    local pos = nil
                    if self._actionData.postype == 1 then
                        pos = self._buff._recordPosition
                    elseif self._actionData.postype == 2 then
                        pos = self._buff._positionCallBack
                        local src_pos = self._buffOwner:GetPosition(true)
                        pos.y = src_pos.y
                    elseif self._actionData.postype == 3 then
                        pos = self._trigger._recordPosition
                    elseif self._actionData.postype == 4 then
                        pos = self._buff._multi_record_pos[self._actionData.posindex]
                    elseif self._actionData.postype == 5 then
                        pos = self._buffOwner:GetBuffManager()._recordPosition;
                    elseif self._actionData.postype == 6 then
                        pos = self._buffOwner:GetBuffManager()._multi_record_pos[self._actionData.posindex];
                    end
                    if pos then
                        self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[self._actionData.type-1], true, nil, pos.x, pos.y, pos.z, skillDistance, skillDistance, nil, nil, false, nil);
                    end
                elseif self._actionData.type > 11 and self._actionData.type <= 15 then
                    local index = self._actionData.type+16;
                    self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[index], true, self._buffOwner:GetBindObj(3), 0, 0, 0, skillWitdh, skillDistance, nil, nil, true, self._buffOwner:GetForWard());
                    if self._actionData.angle then
                        local angle = self._buffOwner:GetRotation().y + self._actionData.angle;
                        self._buffOwner.aperture_manager:SetNotMoveAngle(angle, self._buffOwner.aperture_manager.apertureType[index])
                    end
                end
                self._value = 1
            end
        end
        self._actionState = eBuffActionState.Over
    end
    
    return self._actionState
end

function ShowApertureAction:RollBack()
    if self._value == 1 and self._buffOwner.aperture_manager then
        if self._actionData.type == 0 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[6], false)
        elseif self._actionData.type == 1 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[6], false)
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[7], false)
        elseif self._actionData.type == 2 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[12], false)
        elseif self._actionData.type == 3 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[11], false)
        elseif self._actionData.type == 4 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[0], false)
            self._buffOwner.aperture_manager:Stop(self._buffOwner.aperture_manager.apertureType[5])
        elseif self._actionData.type == 5 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[0], false)
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[1], false)
            self._buffOwner.aperture_manager:Stop(self._buffOwner.aperture_manager.apertureType[5])
        elseif self._actionData.type == 6 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[2], false)
        elseif self._actionData.type >= 7 and self._actionData.type <= 11 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[self._actionData.type-1], false)
        elseif self._actionData.type > 11 and self._actionData.type <= 15 then
            self._buffOwner.aperture_manager:SetOpenNotMove(self._buffOwner.aperture_manager.apertureType[self._actionData.type+16], false)
        end
        self._buffOwner.last_skill_aperture = -1
    end
end

-----------eBuffAction.AttachDelayBuffWithDistance-----------
AttachDelayBuffWithDistanceAction = Class(AttachDelayBuffWithDistanceAction,BaseAction)
function AttachDelayBuffWithDistanceAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.fixtime == nil then
            self._actionData.fixtime = 0
        end
        local srcPos
        if self._actionData.srctype == 0 then
            srcPos = self._buffOwner:GetPosition(true)
        elseif self._actionData.srctype == 1 then
            srcPos = self._buff._positionCallBack
        end
        if self._actionData.targettype == 0 then
            local len = #self._trigger._arrThirdTarget
            if self._actionData.maxtargets then
                len = math.min(len, self._actionData.maxtargets)
            end
            for i=1, len do
                local tpos = self._trigger._arrThirdTarget[i]:GetPosition(true);
                local dis = algorthm.GetDistance(tpos.x, tpos.z, srcPos.x, srcPos.z);
                local delay = self._actionData.fixtime + dis/self._actionData.speed*1000
                self._trigger._arrThirdTarget[i]:AttachBuff(self._actionData.buffid, self._actionData.bufflv, self._buff._skillCreator, self._buffOwner:GetName(), nestTimes, self._buff._skillGid, self._buff._directCallBack, delay, self._buff._skillID, self._buff._skillLevel, self._buff._defaultTarget, nil, false, nil)
            end
        elseif self._actionData.targettype == 1 then
            if self._trigger._arrCallBackTarget ~= nil then
                local len = #self._trigger._arrCallBackTarget
                if self._actionData.maxtargets then
                    len = math.min(len, self._actionData.maxtargets)
                end
                for i=1, len do
                    local tpos = self._trigger._arrCallBackTarget[i]:GetPosition(true);
                    local dis = algorthm.GetDistance(tpos.x, tpos.z, srcPos.x, srcPos.z);
                    local delay = self._actionData.fixtime + dis/self._actionData.speed*1000
                    self._trigger._arrCallBackTarget[i]:AttachBuff(self._actionData.buffid, self._actionData.bufflv, self._buff._skillCreator, self._buffOwner:GetName(), nestTimes, self._buff._skillGid, self._buff._directCallBack, delay, self._buff._skillID, self._buff._skillLevel, self._buff._defaultTarget, nil, false, nil)
                end
            end
        elseif self._actionData.targettype == 2 then
            if self._buff._arrThirdTarget ~= nil then
                local len = #self._buff._arrThirdTarget
                if self._actionData.maxtargets then
                    len = math.min(len, self._actionData.maxtargets)
                end
                for i=1, len do
                    local tpos = self._buff._arrThirdTarget[i]:GetPosition(true);
                    local dis = algorthm.GetDistance(tpos.x, tpos.z, srcPos.x, srcPos.z);
                    local delay = self._actionData.fixtime + dis/self._actionData.speed*1000
                    self._buff._arrThirdTarget[i]:AttachBuff(self._actionData.buffid, self._actionData.bufflv, self._buff._skillCreator, self._buffOwner:GetName(), nestTimes, self._buff._skillGid, self._buff._directCallBack, delay, self._buff._skillID, self._buff._skillLevel, self._buff._defaultTarget, nil, false, nil)
                end
            end
        end
        self._actionState = eBuffActionState.Over
    end

    return self._actionState
end

function AttachDelayBuffWithDistanceAction:RollBack()
end

-----------eBuffAction.MovePosition-----------
MovePositionAction = Class(MovePositionAction,BaseAction)
function MovePositionAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.updatesever == nil then
            self._actionData.updatesever = true
        end
        local target = nil
        if self._actionData.targettype == 1 then
            target = self._buff._defaultTarget
        elseif self._actionData.targettype == 2 then
            target = self._trigger._arrThirdTarget[1]
        elseif self._actionData.targettype == 3 then
            target = ObjectManager.GetObjectByName(self._buff._skillCreator)
        elseif self._actionData.targettype == 4 then
            target = ObjectManager.GetObjectByName(self._buffOwner._AttackerName)
        elseif self._actionData.targettype == 5 then
            target = self._trigger._arrCallBackTarget[1]
        elseif self._actionData.targettype == 6 then
            target = self._buff._defaultTarget
        end
        if self._actionData.callbacktype ~= nil then
            self._cbFunction = MovePositionActionCallBack
            self._cbData = {action=self, buff=self._buff, trigger=self._trigger, direct={x=0,y=0,z=1}, type=self._actionData.callbacktype, buffid=self._actionData.abuffid, bufflv=self._actionData.abufflv,}
            if self._actionData.callbacktype == 2 then
                local skillWitdh = 1.5
                if skillWitdh == nil then
                    skillWitdh = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).width
                end
                self._cbData.collision_width = skillWitdh
            end
        end
        local except_flag = 0
        if self._buff._skillID and self._buff._skillID > 0 then
            except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).translation_except
        end
        local move_effect = false
        if target == nil then
            local tpos = nil
            if self._actionData.position == 0 then
                tpos = self._buff._beforeMovePos
            elseif self._actionData.position == 1 then
                tpos = self._buffOwner:GetBuffManager()._recordPosition
            elseif self._actionData.position == 2 then
                tpos = self._buff._positionCallBack
            elseif self._actionData.position == 3 then
                local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                if skillCreator then
                    local fromController = true
                    if skillCreator:IsAIAgent() then
                        fromController = false
                    else
                        fromController = skillCreator:IsMyControl()
                    end
                    if skillCreator.aperture_manager then
                        tpos = skillCreator.aperture_manager:GetRTPosition(skillCreator.aperture_manager.apertureType[5], fromController)
                    end
                end
            elseif self._actionData.position == 4 then
                local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                if skillCreator then
                    tpos = skillCreator:GetBuffManager()._recordPosition;
                end
            elseif self._actionData.position == 5 then
                tpos = self._buff._recordPosition
            elseif self._actionData.position == 6 then
                tpos = self._buff._multi_record_pos[1]
            else
                local pos = self._buffOwner:GetPosition(true)
                local direct = {x=0, y=0, z=0}
                if self._actionData.direct == 1 then
                    direct.x, direct.y, direct.z = self._buffOwner:GetObject():get_forward()
                elseif self._actionData.direct == 2 then
                    if self._buff._directCallBack then
                        direct = self._buff._directCallBack
                    end
                elseif self._actionData.direct == 3 then
                    if self._buff._directCallBack then
                        direct = self._buff._directCallBack
                        if direct.x == nil then
                            app.log("direct错误 buffid="..self._buff:GetBuffID())
                            --app.log(table.tostring(direct))
                        end
                        direct.x = -direct.x
                        direct.z = -direct.z
                    end
                elseif self._actionData.direct == 4 then
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if skillCreator ~= nil then
                        local spos = skillCreator:GetPosition(true)
                        local tpos = self._buffOwner:GetPosition(true)
                        local dx = tpos.x - spos.x;
                        local dy = 0;
                        local dz = tpos.z - spos.z;
                        direct.x, direct.y, direct.z = util.v3_normalized(dx, dy, dz);
                    end
                elseif self._actionData.direct == 5 then
                    local srcDir = self._buffOwner:GetBuffManager()._recordTowards
                    local dx = -srcDir.x;
                    local dy = 0;
                    local dz =-srcDir.z;
                    direct.x, direct.y, direct.z = util.v3_normalized(dx, dy, dz);
                elseif self._actionData.direct == 6 then
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if skillCreator ~= nil then
                        local srcDir = skillCreator:GetBuffManager()._recordTowards
                        direct.x, direct.y, direct.z = util.v3_normalized(srcDir.x, 0, srcDir.z);
                    end
                elseif self._actionData.direct == 7 then
                    local curTarget = self._buff._defaultTarget
                    if curTarget then
                        local spos = self._buffOwner:GetPosition(true)
                        pos = curTarget:GetPosition(true)
                        local dx = spos.x - pos.x;
                        local dy = 0;
                        local dz = spos.z - pos.z;
                        direct.x, direct.y, direct.z = util.v3_normalized(dx, dy, dz);
                    end
                end
                tpos = {}
                tpos.x = pos.x+direct.x*self._actionData.distance;
                tpos.y = pos.y
                tpos.z = pos.z+direct.z*self._actionData.distance
            end
            local curPos = self._buffOwner:GetPosition(true)
            local useTime = 0
            if self._actionData.usetime then
                useTime = self._actionData.usetime
            else
                local dis = util.v3_distance(curPos.x,curPos.y,curPos.z, tpos.x, tpos.y, tpos.z);
                useTime = dis / self._actionData.speed * 1000
            end
            if (self._buff._skillCreator == self._buffOwner:GetName()) or ((not CheckExcept(self._buffOwner, except_flag)) and (not self._buffOwner:GetBuffManager():IsStateImmune(EImmuneStateType.PassivityMove))) then
                move_effect = true
                if self._buff._skillCreator ~= self._buffOwner:GetName() then
                    self._buffOwner:GetBuffManager():CheckRemove(eBuffPropertyType.RemoveOnMove)
                end
                self._buffOwner:PosMoveToPos(nil, tpos.x, tpos.y, tpos.z, useTime, self._cbFunction, self._cbData, self._actionData.autoforward, self._actionData.speed, nil, (self._buffOwner:GetName()~=self._buff._skillCreator), self._actionData.updatesever)
            end
        else
            local offset = 0
            if self._actionData.offset ~= nil then
                offset = self._actionData.offset
            end
            local _time = nil
            if self._actionData.speed == nil then
                _time = self._actionData.usetime
            end

            if (self._buff._skillCreator == self._buffOwner:GetName()) or ((not CheckExcept(self._buffOwner, except_flag)) and (not self._buffOwner:GetBuffManager():IsStateImmune(EImmuneStateType.PassivityMove)))then
                move_effect = true
                if self._buff._skillCreator ~= self._buffOwner:GetName() then
                    self._buffOwner:GetBuffManager():CheckRemove(eBuffPropertyType.RemoveOnMove)
                end
                self._buffOwner:PosMoveToTarget(target, self._actionData.usetime, self._cbFunction, self._cbData, offset, self._actionData.offsettype, self._actionData.finaltorward, self._actionData.speed, (self._buffOwner:GetName()~=self._buff._skillCreator), self._actionData.updatesever)
            end
        end
        self._buff._beforeMovePos = self._buffOwner:GetPosition(true)
        if self._actionData.callbacktype == nil or self._actionData.callbacktype == 2 then
            self._actionState = eBuffActionState.Over
	    elseif self._actionState == eBuffActionState.Begin then
            if not move_effect then
                MovePositionActionCallBack(self._cbData)
                self._actionState = eBuffActionState.Over
            else
		      self._actionState = eBuffActionState.Run
            end
        end
    elseif self._actionState == eBuffActionState.Run then
        if PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.limit then
            if self._actionData.callbacktype ~= nil then
                MovePositionActionCallBack(self._cbData)
            end
            self._actionState = eBuffActionState.Over
        end
    end

    return self._actionState
end

function MovePositionAction:RollBack()
end

-----------eBuffAction.UnlockSkill-----------
UnlockSkillAction = Class(UnlockSkillAction,BaseAction)
function UnlockSkillAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local srcObj = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if srcObj then
            local bExecute = true
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                if not srcObj:IsMyControl() and not srcObj:IsAIAgent() then
                    bExecute = false;
                end
            end
            if self._actionData.lock then
                if bExecute then
                    srcObj.lastSkillComplete = false
                end
            else
                srcObj:onAniAttackEnd()
                srcObj.skillForceComplete = true
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function UnlockSkillAction:RollBack()
end

-----------eBuffAction.ChangeLockAttackTarget-----------
ChangeLockAttackTargetAction = Class(ChangeLockAttackTargetAction,BaseAction)
function ChangeLockAttackTargetAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        local target = nil
        if self._actionData.targettype == 0 then
            target = self._trigger._arrThirdTarget[1]
        elseif self._actionData.targettype == 1 then
            target = self._buff._defaultTarget
        end
        self._buffOwner:SetAttackTarget(target)
        if target ~= nil then
             self._buffOwner.object:look_at(target.object:get_local_position())
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeLockAttackTargetAction:RollBack()
end

-----------eBuffAction.SequenceRunEffect-----------
SequenceRunEffectAction = Class(SequenceRunEffectAction,BaseAction)
function SequenceRunEffectAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.handlehit == nil then
            self._actionData.handlehit = true
        end
         --目标
        local target = nil
        if self._actionData.targettype == 0 then
            target = self._trigger._arrThirdTarget
        elseif self._actionData.targettype == 1 then
            target = self._buff._arrThirdTarget
        end
        self._cbFunction = SequenceEffectActionCallBack
        self._cbData = {action=self, buff=self._buff, trigger=self._trigger, direct={x=0,y=0,z=1} }
        local nLen = #target
        if nLen == 0 then
            self._actionState = eBuffActionState.Over
            return
        end
        self.sequenceIndex = 1
        if target and target[self.sequenceIndex] then
            if self._actionData.srctype == 0 then
                local pos = target[self.sequenceIndex]:GetPosition(true)
                local x = math.random(-self._actionData.radius, self._actionData.radius)
                pos.x = pos.x + x
                local z = math.sqrt(self._actionData.radius*self._actionData.radius-x*x)
                if math.random(0,2) <= 1 then
                    z = -z
                end
                pos.z = pos.z + z
                if pos ~= nil then
                    self._callBackRef = self._callBackRef + 1
                    FightScene.CreateEffect(pos, ConfigManager.Get(EConfigIndex.t_effect_data,self._actionData.effectid), self._cbFunction, self._cbData, target[self.sequenceIndex], direct, self._actionData.durationtime, nil, self._actionData.handlehit, self._buff._skillID)
                end
            elseif self._actionData.srctype == 1 then
                self._buffOwner:SetEffect(self._buff._skillCreator, ConfigManager.Get(EConfigIndex.t_effect_data,self._actionData.effectid), self._cbFunction, self._cbData, target[self.sequenceIndex], nil, self._actionData.durationtime, nil, nil, true, self._buff._skillID)
            end
        end
        self._actionState = eBuffActionState.Run
    elseif self._actionState == eBuffActionState.Run then
        if PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.limit then
            SequenceEffectActionCallBack(self._cbData, nil)
        end
    end
    return self._actionState
end

function SequenceRunEffectAction:RollBack()
end

-----------eBuffAction.FixedCamera-----------
FixedCameraAction = Class(FixedCameraAction,BaseAction)
function FixedCameraAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        CameraManager.IsFixedView = self._actionData.fixed
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function FixedCameraAction:RollBack()
end

-----------eBuffAction.RenderEnable-----------
RenderEnableAction = Class(RenderEnableAction,BaseAction)
function RenderEnableAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:ShowHero(self._actionData.enable);
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RenderEnableAction:RollBack()
    self._buffOwner:ShowHero(not self._actionData.enable);
end

-----------eBuffAction.TimeDelay-----------
TimeDelayAction = Class(TimeDelayAction,BaseAction)
function TimeDelayAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._actionState = eBuffActionState.Run
    elseif self._actionState == eBuffActionState.Run then
        if PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.delay  then
            self._actionState = eBuffActionState.Over
        end
    end
    return self._actionState
end

function TimeDelayAction:RollBack()
end

-----------eBuffAction.StartSkillCD-----------
StartSkillCDAction = Class(StartSkillCDAction,BaseAction)
function StartSkillCDAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local take_effect = true
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if (not self._buffOwner:IsMyControl()) and (not self._buffOwner:IsAIAgent()) then
                take_effect = false
            end
        end
        if take_effect then
            local skill_id = nil
            if self._actionData.skillid == nil then
                self._buff._srcSkill:StartCD(true)
                skill_id = self._buff._srcSkill:GetID()
            else
                if self._actionData.skillid == -1 then
                    for i = 1, MAX_SKILL_CNT do
                        local skill = self._buffOwner:GetSkill(i)
                        if skill then
                            skill:StartCD(true)
                            msg_fight.cg_start_skill_cd(self._buffOwner:GetGID(), skill:GetID())
                        end
                    end
                else
                    local skill = self._buffOwner:GetSkillBySkillID(self._actionData.skillid)
                    if skill then
                        skill:StartCD(true)
                        skill_id = self._actionData.skillid
                    end
                end
            end
            if skill_id then
                msg_fight.cg_start_skill_cd(self._buffOwner:GetGID(), skill_id)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function StartSkillCDAction:RollBack()
end


-----------eBuffAction.ImmuneState-----------
ImmuneStateAction = Class(ImmuneStateAction,BaseAction)
function ImmuneStateAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        for k,v in pairs(EImmuneStateType) do
            if (bit.bit_and(self._actionData.type, v) ~= 0) then
                self._buffOwner:GetBuffManager():ImmuneState(v, true)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ImmuneStateAction:RollBack()
    for k,v in pairs(EImmuneStateType) do
        if (bit.bit_and(self._actionData.type, v) ~= 0) then
            self._buffOwner:GetBuffManager():ImmuneState(v, false)
        end
    end
end

-----------eBuffAction.Repel-----------
RepelAction = Class(RepelAction,BaseAction)
function RepelAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local target = nil
        if self._actionData.targettype == 0 then
            target = self._trigger._arrThirdTarget
        elseif self._actionData.targettype == 1 then
            target = {}
            target[1] = self._buffOwner
        elseif self._actionData.targettype == 2 then
            if self._trigger._arrCallBackTarget ~= nil then
                target = {};
                local len = #self._trigger._arrCallBackTarget
                for i=1, len do
                    target[i] = self._trigger._arrCallBackTarget[i];
                end
            end
        end
        if self._actionData.callbacktype ~= nil then
            self._cbFunction = RepelActionCallBack
            self._cbData = {action=self, buff=self._buff, trigger=self._trigger}
        end
        local except_flag = 0
        if self._buff._skillID and self._buff._skillID > 0 then
            except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).repel_except
        end


        local direction = nil
        if self._actionData.dirtype == 1 then
            local srcObj = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if srcObj then
                local srcDir = srcObj:GetBuffManager()._recordTowards
                if srcDir then
                    srcDir.y = 0
                    local p1 = {}
                    p1.x = srcObj:GetBuffManager()._recordPosition.x + srcDir.x*5
                    p1.z = srcObj:GetBuffManager()._recordPosition.z + srcDir.z*5
                    local p2 = srcObj:GetBuffManager()._recordPosition
                    local p3 = self._buffOwner:GetPosition(true)
                    local r =  (p1.z - p2.z) * p3.x + (p2.x - p1.x) * p3.z + p1.x * p2.z - p2.x * p1.z
                    local angle = 0
                    if r < 0 then
                        angle = -90
                    else
                        angle = 90
                    end
                    local rx,ry,rz,rw = util.quaternion_euler(0, angle, 0);
                    local resultX,resultY,resultZ = util.quaternion_multiply_v3(rx, ry, rz, rw, srcDir.x, srcDir.y, srcDir.z);
                    direction = {}
                    direction.x, direction.y, direction.z = util.v3_normalized(resultX, resultY, resultZ);
                end
            end
        elseif self._actionData.dirtype == 2 then
            local srcObj = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if srcObj then
                local srcDir = srcObj:GetBuffManager()._recordTowards
                direction = {}
                direction.x, direction.y, direction.z = util.v3_normalized(srcDir.x, srcDir.y, srcDir.z);
            end
        end
        if target ~= nil then
            local nLen = #target
            for i=1, nLen do
                if not target[i]:IsDead() and not target[i]:GetBuffManager():IsStateImmune(EImmuneStateType.BeAttackEffect) and not CheckExcept(target[i], except_flag) then
                    target[i]:PostEvent("BeRepel", {attackName=self._buff._skillCreator, dis=self._actionData.distance, dir=direction, cbFunction=self._cbFunction, cbData=self._cbData})
                    target[i]:GetBuffManager():CheckRemove(eBuffPropertyType.RemoveOnMove)
                end
            end
        end
        if self._actionData.callbacktype == nil then
            self._actionState = eBuffActionState.Over
	    elseif self._actionState == eBuffActionState.Begin then
		    self._actionState = eBuffActionState.Run
        end
    elseif self._actionState == eBuffActionState.Run then
        if PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.limit then
            if self._actionData.callbacktype ~= 0 then
                RepelActionCallBack(self._cbData)
            end
            self._actionState = eBuffActionState.Over
        end
    end
    return self._actionState
end

function RepelAction:RollBack()
end

-----------eBuffAction.RecordDamage-----------
RecordDamageAction = Class(RecordDamageAction,BaseAction)
function RecordDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.type == 1 then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            user:GetBuffManager()._bRecordDamage = true
            user:GetBuffManager()._nRecordDamage = 0
        else
            self._buffOwner:GetBuffManager()._bRecordDamage = true
            self._buffOwner:GetBuffManager()._nRecordDamage = 0
        end
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
                    self.send_cancel_msg = true
		        end
                local info = {}
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 15, info, duration)
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RecordDamageAction:RollBack()
    if self._buffOwner:GetBuffManager()._bRecordDamage then
        if self._actionData.type == 1 then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            user:GetBuffManager()._bRecordDamage = false
        else
            self._buffOwner:GetBuffManager()._bRecordDamage = false
        end
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
            if self._buff.duration > 0 then
                duration = self._buff.duration
            end
            local info = {}
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 15, info, duration)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 15, info, duration)
                end
            end
        end
    end
end

-----------eBuffAction.RecoverHP-----------
RecoverHPAction = Class(RecoverHPAction,BaseAction)
function RecoverHPAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            self._success = true;
            if user and (user:IsMyControl() or user:IsAIAgent())then
                local calculate_info = {}
                calculate_info.user_gid = user:GetGID()
                calculate_info.target_gid = self._buffOwner:GetGID()
                calculate_info.skill_id = self._buff._skillID
                calculate_info.skill_type = 1
                calculate_info.calc_type = self._actionData.type
                calculate_info.calc_info_index = self._actionData.value
                calculate_info.ex_persent = self._actionData.value
                calculate_info.add_scale = self._actionData.add_scale
                msg_fight.cg_skill_calculate(calculate_info)
            end
        else
            local value = 0
            if self._actionData.type == 0 then
                if user then
                    value = user:GetBuffManager()._nRecordDamage * self._actionData.value
                    if user:GetBuffManager()._nRecordDamage ~= 0 then
                        value = math.max(1, value)
                    end
                end
            elseif self._actionData.type == 1 then
                value = self._actionData.value
            elseif self._actionData.type == 2 then
                value = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.max_hp)*self._actionData.value
            elseif self._actionData.type == 3 then
                value = (self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.max_hp)-self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.cur_hp))*self._actionData.value
            elseif self._actionData.type == 4 then
                if user then
                    local damageInfo = nil
                    local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                    if skillInfo and skillInfo[self._buff._skillLevel] then
                        damageInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.value]
                        if damageInfo and damageInfo.skillrefscale == 1 then
                            damageInfo.skillgid = self._buff._skillGid
                        end
                    end
                    if damageInfo == nil then
                        app.log("计算治疗时damageInfo_"..tostring(self._actionData.value).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                    end
                    value = user:CalcuRecoverFormula(self._buff._skillCreator, damageInfo);
                    if self._actionData.add_scale then
                        local curHpPro = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
                        value = value * (1+(1-curHpPro)*self._actionData.add_scale)
                    end
                end
            elseif self._actionData.type == 5 then
                if user then
                    value = user:GetBuffManager()._nRecordRecover * self._actionData.value
                    if user:GetBuffManager()._nRecordRecover ~= 0 then
                        value = math.max(1, value)
                    end
                end
            end
            value = PublicFunc.AttrInteger(value)
            if value ~= 0 then
                self._success = true;
                self._buffOwner:CalcuRecoverHPAsTarget(value, self._buff._skillCreator, nil)

                if user:GetBuffManager()._bRecordRecover then
                    user:GetBuffManager()._nRecordRecover = user:GetBuffManager()._nRecordRecover + value
                end
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RecoverHPAction:RollBack()
end

-----------eBuffAction.AddAbsoluteDamage-----------
ChangeAbsoluteMDamageAction = Class(ChangeAbsoluteMDamageAction,BaseAction)
function ChangeAbsoluteMDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        self._buffOwner:GetBuffManager()._nChangeAbsoluteMDamage = self._buffOwner:GetBuffManager()._nChangeAbsoluteMDamage + self._actionData.value
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
                    self.send_cancel_msg = true
		        end
                local info = {}
                info.f_value1 = 0
                info.n_value1 = self._actionData.value
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 1, info, duration)
	        end
        end
        self._value = self._actionData.value
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeAbsoluteMDamageAction:RollBack()
    if self._value then
        self._buffOwner:GetBuffManager()._nChangeAbsoluteMDamage = self._buffOwner:GetBuffManager()._nChangeAbsoluteMDamage - self._value
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
            if self._buff.duration > 0 then
                duration = self._buff.duration
            end
            local info = {}
            info.f_value1 = 0
            info.n_value1 = self._value
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 1, info, duration)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 1, info, duration)
                end
            end
        end
    end
end

-----------eBuffAction.BeAttackAnimation-----------
BeAttackAnimationAction = Class(BeAttackAnimationAction,BaseAction)
function BeAttackAnimationAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local beAttackType = 0
        local point = string.find(""..self._actionData.type, ".", 1, true)
        if point == nil then
            beAttackType = self._actionData.type
        else
            local min = string.sub(""..self._actionData.type, 1, point)
            local max = string.sub(""..self._actionData.type, point+1)
            beAttackType = math.random(min, max)
        end
        local except_flag = 0
        if self._buff._skillID and self._buff._skillID > 0 then
            if beAttackType >= 1 and beAttackType <= 3 then
                if beAttackType == 3 and (self._actionData.distance or self._actionData.distype == 2) then
                    except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).repel_except
                else
                    except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).beattack1_3
                end
            elseif beAttackType == 5 then
                except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).beattack5
            elseif beAttackType == 6 then
                except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).beattack6
            end
        end
        --app.log("beAttackType="..beAttackType.." except_flag="..except_flag)
        local target = nil
        if self._actionData.targettype == 0 then
            target = self._trigger._arrThirdTarget
        elseif self._actionData.targettype == 1 then
            target = {}
            target[1] = self._buffOwner
        elseif self._actionData.targettype == 2 then
            target = self._trigger._arrCallBackTarget
        elseif self._actionData.targettype == 3 then
            target = self._buff._arrThirdTarget
        end
        if self._actionData.callbacktype ~= nil then
            self._cbFunction = BeAttackAnimationActionCallBack
            self._cbData = {action=self, buff=self._buff, trigger=self._trigger}
        end
        local distance = self._actionData.distance
        if self._actionData.distype == 1 then
            distance = self._actionData.distance
        elseif self._actionData.distype == 2 then
            local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if skillCreator and skillCreator:IsCaptain() then
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID)
                if skillInfo and skillInfo.captain_attack_repel_dis > 0 then
                    distance = skillInfo.captain_attack_repel_dis
                end
            end
        end 
        local dirtype = self._actionData.dirtype;
        if target ~= nil then
            local nLen = #target
            for i=1, nLen do
                if not CheckExcept(target[i], except_flag) and not target[i]:IsDead() then
                    if target[i]:GetBuffManager():IsStateImmune(EImmuneStateType.BeAttackEffect) then
                        -- local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        -- if target[i]:IsMyControl() or (skillCreator and skillCreator:IsMyControl()) then
                        --     target[i]:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ImmuneControl)
                        -- end
                    else
                        if beAttackType ~= 6 then
                            local dir = nil;
                            if dirtype == 0 then
                                local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                                local fromController = true
                                local _pos = nil
                                if skillCreator then
                                    if skillCreator:IsAIAgent() then
                                        fromController = false
                                    else
                                        fromController = skillCreator:IsMyControl()
                                    end
                                    if skillCreator.aperture_manager then
                                        _pos = skillCreator.aperture_manager:GetRTPosition(nil, fromController)
                                    end
                                end
                                 
                                if _pos == nil then
                                    _pos = {x=0, y=0, z=0}
                                end
                                local pos = Vector3d:new(_pos)
                                local target_pos = target[i]:GetPositionV3d();
                                dir = pos:CSub(target_pos);
                                dir = dir:RNormalize();
                            elseif dirtype == 1 then
                                local srcDir = self._buffOwner:GetBuffManager()._recordTowards
                                dir = Vector3d:new({x=-srcDir.x,y=srcDir.y,z=-srcDir.z});
                            elseif dirtype == 2 then
                                local srcObj = ObjectManager.GetObjectByName(self._buff._skillCreator)
                                if srcObj then
                                    local srcDir = srcObj:GetBuffManager()._recordTowards
                                    dir = Vector3d:new({x=-srcDir.x,y=srcDir.y,z=-srcDir.z});
                                end
                            elseif dirtype == 3 then
                                local srcObj = ObjectManager.GetObjectByName(self._buff._skillCreator)
                                local srcDir = srcObj:GetBuffManager()._recordTowards
                                if srcDir then
                                    srcDir.y = 0
                                    local p1 = {}
                                    p1.x = srcObj:GetBuffManager()._recordPosition.x + srcDir.x*5
                                    p1.z = srcObj:GetBuffManager()._recordPosition.z + srcDir.z*5
                                    local p2 = srcObj:GetBuffManager()._recordPosition
                                    local p3 = self._buffOwner:GetPosition(true)
                                    local r =  (p1.z - p2.z) * p3.x + (p2.x - p1.x) * p3.z + p1.x * p2.z - p2.x * p1.z
                                    local angle = 0
                                    if r < 0 then
                                        angle = -90
                                    else
                                        angle = 90
                                    end
                                    local rx,ry,rz,rw = util.quaternion_euler(0, angle, 0);
                                    local resultX,resultY,resultZ = util.quaternion_multiply_v3(rx, ry, rz, rw, srcDir.x, srcDir.y, srcDir.z);
                                    direction = {}
                                    direction.x, direction.y, direction.z = util.v3_normalized(resultX, resultY, resultZ);
                                    dir = Vector3d:new({x=direction.x,y=srcDir.y,z=direction.z});
                                end
                            elseif dirtype == 4 then
                                local srcObj = ObjectManager.GetObjectByName(self._buff._skillCreator)
                                if srcObj then
                                    local srcDir = srcObj:GetBuffManager()._recordTowards
                                    dir = Vector3d:new({x=srcDir.x,y=srcDir.y,z=srcDir.z});
                                end
                            elseif dirtype == 5 then
                                local srcObj = ObjectManager.GetObjectByName(self._buff._skillCreator)
                                if srcObj then
                                    local srcPos = srcObj:GetBuffManager()._recordPosition

                                    local pos = Vector3d:new(srcPos)
                                    local target_pos = target[i]:GetPositionV3d();
                                    dir = pos:CSub(target_pos);
                                    dir = dir:RNormalize();
                                end
                            end
                            if not target[i]:IsDead() then
                                target[i]:PostEvent("PlayBeAttackAni", {dir=dir,attackName=self._buff._skillCreator, type=beAttackType, dis=distance, cbFunction=self._cbFunction, cbData=self._cbData, height=self._actionData.height, eventLevel=distance})
                                if self._actionData.height and self._actionData.height > 0 then
                                    target[i]:GetBuffManager():CheckRemove(eBuffPropertyType.RemoveOnVertigo)
                                end
                                if distance and distance ~= 0 then
                                    target[i]:GetBuffManager():CheckRemove(eBuffPropertyType.RemoveOnMove)
                                end
                            end
                        else
                            if not target[i]:IsDead() then
                                target[i]:PostEvent("Throw", {height=self._actionData.height, cbFunction=self._cbFunction, cbData=self._cbData})
                                target[i]:GetBuffManager():CheckRemove(eBuffPropertyType.RemoveOnVertigo)
                            end
                        end
                    end
                elseif not target[i]:IsDead() then
                    if self._actionData.callbacktype ~= nil then
                        BeAttackAnimationActionCallBack(self._cbData)
                    end
                end
            end
        end
        if self._actionData.callbacktype == nil then
            self._actionState = eBuffActionState.Over
	    elseif self._actionState == eBuffActionState.Begin then
		    self._actionState = eBuffActionState.Run
        end
    elseif self._actionState == eBuffActionState.Run then
        if PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.limit then
            if self._actionData.callbacktype ~= nil then
                BeAttackAnimationActionCallBack(self._cbData)
            end
            self._actionState = eBuffActionState.Over
        end
    end
    return self._actionState
end

function BeAttackAnimationAction:RollBack()
end

-----------eBuffAction.RemoveRationEffect-----------
RemoveRationEffectAction = Class(RemoveRationEffectAction,BaseAction)
function RemoveRationEffectAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        for i=1, MAX_SKILL_CNT do
		    if self._buffOwner._arrSkill[i] ~= nil then
			    if self._buffOwner._arrSkill[i]._skillData.id == self._buff._skillID then
                    if self._buffOwner == FightManager.GetMyCaptain() then
                        GetMainUI():EnableRationEffect(self._buffOwner._arrSkill[i]._uiIndex, false)
                    end
                    break
                end
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RemoveRationEffectAction:RollBack()
end

-----------eBuffAction.ResetAttachTime-----------
ResetAttachTimeAction = Class(ResetAttachTimeAction,BaseAction)
function ResetAttachTimeAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        self._buff._attachFrame = PublicFunc.QueryCurTime()
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ResetAttachTimeAction:RollBack()
end

-----------eBuffAction.ChangeScaleMDamage-----------
ChangeScaleMDamageAction = Class(ChangeScaleMDamageAction,BaseAction)
function ChangeScaleMDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        self._buffOwner:GetBuffManager()._changeScaleMDamage[self._buffOwner:GetBuffManager()._nScaleMDamageIndex+1] = {scale=self._actionData.scale, odds=self._actionData.odds}
        self._buffOwner:GetBuffManager()._nScaleMDamageIndex = self._buffOwner:GetBuffManager()._nScaleMDamageIndex + 1
        self._values[#self._values+1] = self._buffOwner:GetBuffManager()._nScaleMDamageIndex

        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
                local info = {}
                info.f_value1 = self._actionData.scale
                info.n_value1 = self._actionData.odds
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 2, info, duration)
	        end
        end
        ----------------飘字--------------
        local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if self._buffOwner._headInfoControler:Check(skillCreator) then
            if self._actionData.scale > 1 then
                self._buffOwner:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.DamageUp)
            else
                self._buffOwner:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.DamageDown)
            end
        end
        ----------------------------------

        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeScaleMDamageAction:RollBack()
    local len = #self._values
    for i=1, len do
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if self._buffOwner:GetBuffManager()._changeScaleMDamage[self._values[i]] then
                local scale = self._buffOwner:GetBuffManager()._changeScaleMDamage[self._values[i]].scale
                local odds = self._buffOwner:GetBuffManager()._changeScaleMDamage[self._values[i]].odds
	            local duration = 0
	            if self._buff.duration > 0 then
		            duration = self._buff.duration
	            end
                local info = {}
                info.f_value1 = scale
                info.n_value1 = odds
	            if duration > 0 and self.send_cancel_msg then
		            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 2, info, duration)
	            else
		            if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 2, info, duration)
		            end
	            end
            end
        end
        self._buffOwner:GetBuffManager()._changeScaleMDamage[self._values[i]] = nil
    end
end

-----------eBuffAction.ChangeScaleRDamage-----------
ChangeScaleRDamageAction = Class(ChangeScaleRDamageAction,BaseAction)
function ChangeScaleRDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._actionData.odds = (self._actionData.odds or 1)
        self._buffOwner:GetBuffManager()._changeScaleRDamage[self._buffOwner:GetBuffManager()._nScaleRDamageIndex+1] = {scale=self._actionData.scale, odds=self._actionData.odds}
        self._buffOwner:GetBuffManager()._nScaleRDamageIndex = self._buffOwner:GetBuffManager()._nScaleRDamageIndex + 1
        self._value = self._buffOwner:GetBuffManager()._nScaleRDamageIndex

        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
                local info = {}
                info.f_value1 = self._actionData.scale
                info.n_value1 = self._actionData.odds
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 3, info, duration)
	        end
        end

        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeScaleRDamageAction:RollBack()
    if self._value ~= 0 then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if self._buffOwner:GetBuffManager()._changeScaleRDamage[self._value] then
                local scale = self._buffOwner:GetBuffManager()._changeScaleRDamage[self._value].scale
                local odds = self._buffOwner:GetBuffManager()._changeScaleRDamage[self._value].odds
	            local duration = 0
	            if self._buff.duration > 0 then
		            duration = self._buff.duration
	            end
                local info = {}
                info.f_value1 = scale
                info.n_value1 = odds
	            if duration > 0 and self.send_cancel_msg then
		            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 3, info, duration)
	            else
		            if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 3, info, duration)
		            end
	            end
            end
        end
        self._buffOwner:GetBuffManager()._changeScaleRDamage[self._value] = nil
    end
end

-----------eBuffAction.RecordTowardsAndPosition-----------
local random_pos_angle_and_radius = {{0.0012512588885159,203},{0.19330423902097,292},{0.58500930814539,173},{0.3502914517655,323},{0.82284005249184,269},{0.17410809656056,310},
{0.71050141911069,185},{0.30399487289041,6},{0.091402935880612,132},{0.14731284524064,60},{0.98852504043703,161},{0.11908322397534,2},{0.0089114047669912,137},{0.53166295358135,206},
{0.60176396984771,219},{0.16623432111576,239},{0.45078890346995,127},{0.057039094210639,219},{0.78331858272042,289},{0.51988280892361,109},{0.87597277748955,262},{0.95590075380718,334},
{0.5393536179693,52},{0.46208075197607,85},{0.86223944822535,76},{0.7796563615833,304},{0.99679555650502,360},{0.61149937437056,142},{0.26621295815912,108},{0.84014404736473,9},{0.37586596270638,34},
{0.67720572527238,21},{0.0087893307290872,331},{0.27588732566301,99},{0.58790856654561,249},{0.83761101107822,262},{0.4849391155736,74},{0.74373607593005,169},{0.45796075319681,342},{0.744438001648,39},{0.59904782250435,139},
{0.73500778221992,220},{0.5724051637318,131},{0.1515549180578,82},{0.42515335551012,290},{0.5171056245613,357},{0.75154881435591,125},{0.1689809869686,237},{0.49189733573412,23},{0.69975890377514,182},{0.14749595629749,342},
{0.14157536545915,326},{0.69289223914304,110},{0.42655720694601,26},{0.96661275063326,246},{0.15323343607898,316},{0.82168034913175,210},{0.1913510544145,65},{0.81719412823878,172},{0.15555284279916,182},{0.73201696829127,147},
{0.27958006530961,205},{0.68224127933592,273},{0.72191534165471,172},{0.12302011169774,133},{0.83468123416852,13},{0.51701406903287,239},{0.42622150334178,38},{0.94933927426984,332},{0.54954680013428,125},{0.47172460097049,135},
{0.84698019348735,115},{0.45609912411878,98},{0.98297067171239,108},{0.73918881801813,205},{0.19598986785485,275},{0.83944212164678,144},{0.50090029602954,321},{0.027466658528397,359},{0.57258827478866,19},{0.53132724997711,70},
{0.84304330576495,226},{0.65761284218879,72},{0.84215826899014,45},{0.10992767113254,268},{0.31406598101749,339},{0.286080507828,122},{0.14026306955168,264},{0.83462019714957,255},{0.60023804437391,269},{0.25272377697073,53},
{0.0016174810022279,22},{0.80623798333689,307},{0.21057771538438,42},{0.5532090212714,6},{0.11377300332652,164},{0.75222022156438,248},{0.54344309823908,27},{0.43671987060152,73},{0.69621875667592,105},}

local random
RecordTowardsAndPositionAction = Class(RecordTowardsAndPositionAction,BaseAction)
function RecordTowardsAndPositionAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local forward = self._buffOwner:GetForWard()
        local pos = self._buffOwner:GetPosition()
        if self._actionData.srctype == nil then
            if self._actionData.targettype == 2 then
                local defTarget = self._buff._defaultTarget
                if defTarget then
                    local tarPos = defTarget:GetPosition();
                    forward.x = tarPos.x - pos.x;
                    forward.y = tarPos.y - pos.y;
                    forward.z = tarPos.z - pos.z;
                    forward.x,forward.y,forward.z = util.v3_normalized(forward.x,forward.y,forward.z);
                    pos = tarPos;
                end
            elseif self._actionData.targettype == 4 then
                local skill = self._buffOwner:GetSkillBySkillID(self._buff._skillID)
                local skill_dis = self._actionData.radius
                if skill_dis == nil and skill then
                    skill_dis = skill:GetDistance()
                end
                local radius = 0
                local angle = 0
                if skill and skill.action_odds then
                    if skill.action_odds == 0 then
                        skill.action_odds = 1
                    end
                    local index = ((skill.action_odds + (self._actionData.randomindex))%100)+1
                    radius = random_pos_angle_and_radius[index][1]
                    angle = random_pos_angle_and_radius[index][2]
                else
                    radius = math.random()
                    angle = math.random(1, 360)
                end
                radius = radius * skill_dis
                pos.x = pos.x + math.sin(angle*3.1415926/180)*radius;  
                pos.z = pos.z + math.cos(angle*3.1415926/180)*radius;
            elseif self._actionData.targettype == 5 then
                local skill_dis = self._actionData.offset
                if skill_dis == nil then
                    local skill = self._buffOwner:GetSkillBySkillID(self._buff._skillID)
                    if skill then
                        skill_dis = skill:GetDistance()
                        pos.x = pos.x + forward.x*skill_dis
                        pos.z = pos.z + forward.z*skill_dis
                    end
                end
            end
        elseif self._actionData.srctype == 1 then
            local targets;
            if self._actionData.targettype == 1 then
                if self._actionData.targetindex == nil then
                    targets = self._trigger._arrThirdTarget
                elseif self._actionData.targetindex == 0 then
                    local len = #self._trigger._arrThirdTarget
                    if len ~= 0 then
                        targets = {}
                        targets[1] = self._trigger._arrThirdTarget[math.random(1,len)]
                    end  
                else
                    if self._trigger._arrThirdTarget[self._actionData.targetindex] ~= nil then
                        targets = {}
                        targets[1] = self._trigger._arrThirdTarget[self._actionData.targetindex]
                    else
                        local len = #self._trigger._arrThirdTarget
                        targets = {}
                        targets[1] = self._trigger._arrThirdTarget[(self._actionData.targetindex%len)+1]
                    end
                end
            elseif self._actionData.targettype == 2 then
                targets = {}
                targets[1] = self._buff._defaultTarget
            elseif self._actionData.targettype == 3 then
                targets = self._buffOwner:GetBuffManager()._arrThirdTarget
            end
            if targets ~= nil then
                local target = targets[1];
                if target then
                    local tarPos = target:GetPosition();
                    forward.x = tarPos.x - pos.x;
                    forward.y = tarPos.y - pos.y;
                    forward.z = tarPos.z - pos.z;
                    forward.x,forward.y,forward.z = util.v3_normalized(forward.x,forward.y,forward.z);
                    pos = tarPos;
                end
            end
            
        elseif self._actionData.srctype == 2 then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user then
                forward = user:GetForWard()
                pos = user:GetPosition()
            end
        elseif self._actionData.srctype == 3 then
            local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if skillCreator then
                forward = skillCreator:GetForWard()
                local fromController = true;
                if skillCreator:IsAIAgent() then
                    fromController = false
                else
                    fromController = skillCreator:IsMyControl()
                end
                if skillCreator.aperture_manager then
                    pos = skillCreator.aperture_manager:GetRTPosition(skillCreator.aperture_manager.apertureType[5], fromController)
                end
            end
        elseif self._actionData.srctype == 4 then
            forward = self._buff._directCallBack
            pos = self._buff._positionCallBack
        end
        if self._actionData.offset then
            if self._actionData.aoffset then
                local srcDir = self._buffOwner:GetForWard()

                local rx,ry,rz,rw = util.quaternion_euler(0, self._actionData.aoffset, 0);
                local resultX,resultY,resultZ = util.quaternion_multiply_v3(rx, ry, rz, rw, srcDir.x, srcDir.y, srcDir.z);
                forward.x, forward.y, forward.z = util.v3_normalized(resultX, resultY, resultZ);
            end
            if self._actionData.dirtype == 0 then
                forward.x = -forward.x
                forward.z = -forward.z
            end
            pos.x = pos.x + forward.x*self._actionData.offset
            pos.z = pos.z + forward.z*self._actionData.offset
        end
        local bRet, hit = util.raycase_out4(pos.x, 20, pos.z, 0, -1, 0, 50, PublicFunc.GetBitLShift({PublicStruct.UnityLayer.terrain}));
        if bRet then
            pos.y = hit.y
            local _x, _y, _z
            bRet, _x, _y, _z = util.get_navmesh_sampleposition(hit.x, hit.y, hit.z, 15);
            if bRet then
                pos.y = _y;
            end
        end
        if self._actionData.type == 0 then
            self._buff._recordPosition = pos
            self._buff._recordTowards = forward
            self._buff._recordTowards.y = 0
        elseif self._actionData.type == 1 then
            self._buffOwner:GetBuffManager()._recordPosition = pos
            self._buffOwner:GetBuffManager()._recordTowards = forward
            self._buffOwner:GetBuffManager()._recordTowards.y = 0
        elseif self._actionData.type == 2 then
            self._trigger._recordPosition = pos
            self._trigger._recordTowards = forward
            self._trigger._recordTowards.y = 0
        end
        self._buffOwner:GetBuffManager()._recordTowards = forward
        self._buffOwner:GetBuffManager()._recordTowards.y = 0
        self._actionState = eBuffActionState.Over
        self._success = true
    end
    return self._actionState
end

function RecordTowardsAndPositionAction:RollBack()
end

-----------eBuffAction.ScaleModel-----------
ScaleModelAction = Class(ScaleModelAction,BaseAction)
function ScaleModelAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.type == 1 then
            local cur_scale = self._buffOwner:GetScale();
            cur_scale.x = cur_scale.x + self._actionData.scale;
            if cur_scale.x < 1 then
                cur_scale.x = 1;
            end
            cur_scale.y = cur_scale.y + self._actionData.scale;
            if cur_scale.y < 1 then
                cur_scale.y = 1;
            end
            cur_scale.z = cur_scale.z + self._actionData.scale;
            if cur_scale.z < 1 then
                cur_scale.z = 1;
            end
            self._buffOwner:SetScale(cur_scale.x, cur_scale.y, cur_scale.z);
        else
            self._buffOwner:SetScale(self._actionData.scale, self._actionData.scale, self._actionData.scale)
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ScaleModelAction:RollBack()
    self._buffOwner:SetScale(1, 1, 1)
end

-----------eBuffAction.AttachBuffWhenUseSkill-----------
AttachBuffWhenUseSkillAction = Class(AttachBuffWhenUseSkillAction,BaseAction)
function AttachBuffWhenUseSkillAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._buffID2AttachWhenUseSkill = self._actionData.buffid
        self._buffOwner:GetBuffManager()._buffLv2AttachWhenUseSkill = self._actionData.bufflv
        if self._buffOwner:GetBuffManager()._buffID2AttachWhenUseSkill == 0 or self._buffOwner:GetBuffManager()._buffLv2AttachWhenUseSkill == 0 then
            self._buffOwner:GetBuffManager()._buffCreator2AttachWhenUseSkill = nil
            self._buffOwner:GetBuffManager()._buff2AttachSkillIDWhenUseSkill = 0
            self._buffOwner:GetBuffManager()._buff2AttachSkillLevelWhenUseSkill = 0
        else
            self._buffOwner:GetBuffManager()._buffCreator2AttachWhenUseSkill = self._buff._skillCreator
            self._buffOwner:GetBuffManager()._buff2AttachSkillIDWhenUseSkill = self._buff._skillID
            self._buffOwner:GetBuffManager()._buff2AttachSkillLevelWhenUseSkill = self._buff._skillLevel
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function AttachBuffWhenUseSkillAction:RollBack()
end


-----------eBuffAction.ChangeScaleNormalMDamage-----------
ChangeScaleNormalMDamageAction = Class(ChangeScaleNormalMDamageAction,BaseAction)
function ChangeScaleNormalMDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        self._buffOwner:GetBuffManager()._changeScaleNormalMDamage[self._buffOwner:GetBuffManager()._nScaleNormalMDamageIndex+1] = {scale=self._actionData.scale, objtype=self._actionData.objtype, times=self._actionData.times}
        self._buffOwner:GetBuffManager()._nScaleNormalMDamageIndex = self._buffOwner:GetBuffManager()._nScaleNormalMDamageIndex + 1
        self._value = self._buffOwner:GetBuffManager()._nScaleNormalMDamageIndex
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.f_value1 = self._actionData.scale;
	            info.n_value1 = self._actionData.objtype;
	            info.n_value2 = self._actionData.times;
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 4, info, duration)
	        end
        end

        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeScaleNormalMDamageAction:RollBack()
    if self._value ~= 0 then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if self._buffOwner:GetBuffManager()._changeScaleNormalMDamage[self._value] then
	            local duration = 0
	            if self._buff.duration > 0 then
		            duration = self._buff.duration
	            end
	            local info = {}
                info.f_value1 = self._buffOwner:GetBuffManager()._changeScaleNormalMDamage[self._value].scale
                info.n_value1 = self._buffOwner:GetBuffManager()._changeScaleNormalMDamage[self._value].objtype
                info.n_value2 = self._buffOwner:GetBuffManager()._changeScaleNormalMDamage[self._value].times
	            if duration > 0 and self.send_cancel_msg then
		            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 4, info, duration)
	            else
		            if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 4, info, duration)
		            end
	            end
            end
        end
        self._buffOwner:GetBuffManager()._changeScaleNormalMDamage[self._value] = nil
    end
end

-----------eBuffAction.ChangeAbsoluteNormalMDamage-----------
ChangeAbsoluteNormalMDamageAction = Class(ChangeAbsoluteNormalMDamageAction,BaseAction)
function ChangeAbsoluteNormalMDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        self._buffOwner:GetBuffManager()._changeAbsoluteNormalMDamage[self._buffOwner:GetBuffManager()._nAbsoluteNormalMDamageIndex+1] = {value=self._actionData.value, objtype=self._actionData.objtype, times=self._actionData.times}
        self._buffOwner:GetBuffManager()._nAbsoluteNormalMDamageIndex = self._buffOwner:GetBuffManager()._nAbsoluteNormalMDamageIndex + 1
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.n_value1 = self._actionData.value
                info.n_value2 = self._actionData.objtype
                info.n_value3 = self._actionData.times
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 5, info, duration)
	        end
        end

        self._value = self._buffOwner:GetBuffManager()._nAbsoluteNormalMDamageIndex
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeAbsoluteNormalMDamageAction:RollBack()
    if self._value ~= 0 then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if self._buffOwner:GetBuffManager()._changeAbsoluteNormalMDamage[self._value] then
	            local duration = 0
	            if self._buff.duration > 0 then
		            duration = self._buff.duration
	            end
	            local info = {}
                info.n_value1 = self._buffOwner:GetBuffManager()._changeAbsoluteNormalMDamage[self._value].value
                info.n_value2 = self._buffOwner:GetBuffManager()._changeAbsoluteNormalMDamage[self._value].objtype
                info.n_value3 = self._buffOwner:GetBuffManager()._changeAbsoluteNormalMDamage[self._value].times
	            if duration > 0 and self.send_cancel_msg then
		            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 5, info, duration)
	            else
		            if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 5, info, duration)
		            end
	            end
            end
        end
        self._buffOwner:GetBuffManager()._changeAbsoluteNormalMDamage[self._value] = nil
    end
end

-----------eBuffAction.DisposableAbsoluteRDamage-----------
DisposableAbsoluteRDamageAction = Class(DisposableAbsoluteRDamageAction,BaseAction)
function DisposableAbsoluteRDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.n_value1 = user:GetGID()
                info.n_value2 = self._buff._skillID
                info.n_value3 = self._actionData.type
                if self._actionData.type == 0 then
                    info.f_value1 = self._actionData.value
                elseif self._actionData.type == 1 then
                    info.n_value4 = self._actionData.value
                elseif self._actionData.type == 2 then
                    info.n_value4 = self._actionData.value
                end
                self._value = info.n_value1
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 12, info, duration)
	        end
        else
            if self._actionData.type == 0 then
                self._buffOwner:GetBuffManager()._disposableAbsoluteRDamage = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)*self._actionData.value
            elseif self._actionData.type == 1 then 
                local damageInfo = nil
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                if skillInfo and skillInfo[self._buff._skillLevel] then
                    damageInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.value]
                    if damageInfo and damageInfo.skillrefscale == 1 then
                        damageInfo.skillgid = self._buff._skillGid
                    end
                end
                if damageInfo == nil then
                    app.log("计算伤害时damageInfo_"..tostring(self._actionData.value).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                end
                local value = self._buffOwner:CalcuDamageFormula(self._buff._skillCreator, damageInfo);
                value = PublicFunc.AttrInteger(value)
                self._buffOwner:GetBuffManager()._disposableAbsoluteRDamage = value
            elseif self._actionData.type == 2 then 
                self._buffOwner:GetBuffManager()._disposableAbsoluteRDamage = self._actionData.value
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DisposableAbsoluteRDamageAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if self._value then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.n_value1 = self._value
            info.n_value2 = self._buff._skillID
            info.n_value3 = self._actionData.type
            if self._actionData.type == 0 then
                info.f_value1 = self._actionData.value
            elseif self._actionData.type == 1 then
                info.n_value4 = self._actionData.value
            elseif self._actionData.type == 2 then
                info.n_value4 = self._actionData.value
            end
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 12, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 12, info, duration)
		        end
	        end
        end
    end
    self._buffOwner:GetBuffManager()._disposableAbsoluteRDamage = 0
end

-----------eBuffAction.DisposableScaleRDamageAction-----------
DisposableScaleRDamageAction = Class(DisposableScaleRDamageAction,BaseAction)
function DisposableScaleRDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._disposableScaleRDamage = self._actionData.scale
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.f_value1 = self._actionData.scale
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 6, info, duration)
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DisposableScaleRDamageAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	    local duration = 0
	    if self._buff.duration > 0 then
		    duration = self._buff.duration
	    end
	    local info = {}
	    if duration > 0 and self.send_cancel_msg then
		    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 6, info, duration)
	    else
		    if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 6, info, duration)
		    end
	    end
    end
    self._buffOwner:GetBuffManager()._disposableScaleRDamage = 1
end

-----------eBuffAction.AttachBuffWhenGainDamage-----------
AttachBuffWhenGainDamageAction = Class(AttachBuffWhenGainDamageAction,BaseAction)
function AttachBuffWhenGainDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        
        self._buffOwner:GetBuffManager()._buffID2AttachWhenGainHP = self._actionData.buffid
        self._buffOwner:GetBuffManager()._buffLv2AttachWhenGainHP = self._actionData.bufflv
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function AttachBuffWhenGainDamageAction:RollBack()
    self._buffOwner:GetBuffManager()._buffID2AttachWhenGainHP = 0
    self._buffOwner:GetBuffManager()._buffLv2AttachWhenGainHP = 0
end

-----------eBuffAction.ChangeAppearance-----------
local function ChangeModel(scene_entity, assetobj)
    scene_entity:ChangeObject(assetobj, true)
end

ChangeAppearanceAction = Class(ChangeAppearanceAction,BaseAction)
function ChangeAppearanceAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if ConfigManager.Get(EConfigIndex.t_model_list,self._actionData.modelid) then
		    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,self._actionData.modelid).file;
            local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle', modelName, modelName);
            local asset = ResourceManager.GetRes(filePath)
            if asset == nil then
                local param = {
                    func = function(data, pid, filepath, asset_obj, error_info)
                                ChangeModel(data.scene_entity, asset_obj)
                                if data.scene_entity:IsMonster() then
                                    data.action._value = ObjectManager.GetMonsterModelFile(data.scene_entity.config.id);
                                elseif data.scene_entity:IsHero() then
                                    data.action._value = ObjectManager.GetHeroModelFile(data.scene_entity.config.id);
                                end
                                data.action._actionState = eBuffActionState.Over
                           end,
                    user_data = {scene_entity=self._buffOwner, action=self},
                }
                ResourceLoader.LoadAsset(filePath, param, nil)
                self._actionState = eBuffActionState.Run
                return self._actionState
            else
                ChangeModel(self._buffOwner, asset)
            end
            if self._buffOwner:IsMonster() then
                self._value = ObjectManager.GetMonsterModelFile(self._buffOwner.config.id);
            elseif self._buffOwner:IsHero() then
                self._value = ObjectManager.GetHeroModelFile(self._buffOwner.config.id);
            end
	    end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeAppearanceAction:RollBack()
    if self._value ~= 0 then
        ChangeModel(self._buffOwner, ResourceManager.GetRes(self._value))
    end
end

-----eBuffAction.ChangeAbilityAbsolute-----
ChangeAbilityAbsoluteAction = Class(ChangeAbilityAbsoluteAction,BaseAction)
function ChangeAbilityAbsoluteAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._actionData.valuetype = self._actionData.valuetype or 1
        local except_flag = 0
        if self._buff._skillID and self._buff._skillID > 0 and ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID) then
            except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).ability_except
        end
        if CheckExcept(self._buffOwner, except_flag) then
            self._actionTimes = self._actionTimes-1
        else
            if self._actionData.valuetype == 1 then
                local scale = self._actionData.value
                local fromtype = ""
                if scale == nil then
                    local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                    if skillInfo and skillInfo[self._buff._skillLevel] then
                        if self._buff.ability_change_from == ENUM.AbilityChangeFrom.Self then
                            fromtype = "self_ability_change"
                            if skillInfo[self._buff._skillLevel].self_ability_change ~= 0 then
                                scale = skillInfo[self._buff._skillLevel].self_ability_change[self._actionData.abilityname]
                            end
                        elseif self._buff.ability_change_from == ENUM.AbilityChangeFrom.Enemy then
                            fromtype = "enemy_ability_change"
                            if skillInfo[self._buff._skillLevel].enemy_ability_change ~= 0 then
                                scale = skillInfo[self._buff._skillLevel].enemy_ability_change[self._actionData.abilityname]
                            end
                        elseif self._buff.ability_change_from == ENUM.AbilityChangeFrom.Friend then
                            fromtype = "friend_ability_change"
                            if skillInfo[self._buff._skillLevel].friend_ability_change ~= 0 then
                                scale = skillInfo[self._buff._skillLevel].friend_ability_change[self._actionData.abilityname]
                            end
                        else
                            fromtype = "not found creator"                                                    
                        end
                    end
                end
                if scale == nil then
                    self._actionTimes = self._actionTimes-1
                    app.log("buff获取属性参数失败, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel).." fromtype="..fromtype.." buffid="..self._buff:GetBuffID().." lv="..self._buff:GetBuffLv().." ability="..self._actionData.abilityname)
                else
                    local curHpPro = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
                    self._value = scale * (1+(1-curHpPro)*(self._actionData.add_scale or 0));
                end
            elseif self._actionData.valuetype == 2 then

                local obj = ObjectManager.GetObjectByName(self._buff._skillCreator)
                if obj then
                    local ability = obj:GetPropertyVal(self._actionData.abilityname);
                    local record = obj:GetExternalArea(self._actionData.value) or 0;
                    self._value = record
                    if self._actionData.add_scale then
                        if record/ability > self._actionData.add_scale then
                            self._value = ability*self._actionData.add_scale
                        end
                    end
                end
                if self._value == nil then
                    self._value = 0
                end
            end
            if self._value then
                if self._buffOwner:GetBuffManager():ChangeAbility(self._actionData.abilityname, self._value) then
                    self._success = true;
                    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        if user and (user:IsMyControl() or user:IsAIAgent()) and ENUM.EHeroAttribute[self._actionData.abilityname] ~= nil then
                            local duration = 0
		                    if self._buff.duration > 0 and self._buff:GetOverlapType() ~= eBuffOverlapType.Overlap and self._buff:GetOverlapType() ~= eBuffOverlapType.SameAllResetTime and self._buff:GetOverlapType() ~= eBuffOverlapType.SameIDResetTime then
			                    duration = self._buff.duration
                                self.send_cancel_msg = true
		                    end
                            msg_fight.cg_change_ability(user:GetGID(), self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, true, duration, ((self._actionData.valuetype == 2) and self._actionData.value or ""), 0--[[self._actionData.add_scale]])
                        end
                    elseif PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
                        local frame_info = {}
                        frame_info.type = ENUM.FightKeyFrameType.ChangeAbsoluteAbility
                        frame_info.integer_params = {}
                        frame_info.string_params = {}
                        frame_info.float_params = {}
                        local user_gid = 0
                        local user_pos = nil
                        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        if user then
                            user_gid = user:GetGID()
                            user_pos = user:GetPosition()
                        end
                        table.placeholder_insert_number(frame_info.integer_params, user_gid)
                        if user_pos then
                            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(user_pos.x))
                            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(user_pos.z))
                        else
                            table.placeholder_insert_number(frame_info.integer_params, 0)
                            table.placeholder_insert_number(frame_info.integer_params, 0)
                        end
                        table.placeholder_insert_number(frame_info.integer_params, self._buffOwner:GetGID())
                        local target_pos = self._buffOwner:GetPosition();
                        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.x))
                        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.z))
                        table.placeholder_insert_number(frame_info.integer_params, 1)
                        table.placeholder_insert_number(frame_info.integer_params, self._buff._skillID)
                        table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffID())
                        table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffLv())
                        table.placeholder_insert_number(frame_info.integer_params, self._trigger._triggerData.trigger_index)
                        table.placeholder_insert_number(frame_info.integer_params, self._actionData.action_index)
                        table.placeholder_insert_number(frame_info.float_params, self._value)
                        FightKeyFrameInfo.AddKeyInfo(frame_info)
                    end
                    ----------------飘字--------------
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if self._buffOwner._headInfoControler:Check(skillCreator) then
                        local abilityid = ENUM.EHeroAttribute[self._actionData.abilityname];
                        local offset_abilityid = abilityid-ENUM.min_property_id-1;
                        local offset_typeid = ENUM.EHeadInfoShowType.MaxHpUp-1;
                        local typeid = offset_abilityid*2-1+offset_typeid;
                        if self._value > 0 then
                            self._buffOwner:GetHeadInfoControler():ShowArtisticText(typeid)
                        elseif self._value < 0 then
                            self._buffOwner:GetHeadInfoControler():ShowArtisticText(typeid+1)
                        end
                    end
                    ----------------------------------
                else
                    self._actionTimes = self._actionTimes-1
                end
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeAbilityAbsoluteAction:RollBack()
    for i=1, self._actionTimes do
        self._buffOwner:GetBuffManager():ChangeAbility(self._actionData.abilityname, -self._value)
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
		    if self._buff.duration > 0 and self._buff:GetOverlapType() ~= eBuffOverlapType.Overlap and self._buff:GetOverlapType() ~= eBuffOverlapType.SameAllResetTime and self._buff:GetOverlapType() ~= eBuffOverlapType.SameIDResetTime then
			    duration = self._buff.duration
		    end
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_change_ability(0, self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, false, duration, ((self._actionData.valuetype == 2) and self._actionData.value or ""), self._actionData.add_scale)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) and ENUM.EHeroAttribute[self._actionData.abilityname] ~= nil then
                    msg_fight.cg_change_ability(0, self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, false, duration, ((self._actionData.valuetype == 2) and self._actionData.value or ""), self._actionData.add_scale)
                end
            end
        elseif PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
            local frame_info = {}
            frame_info.type = ENUM.FightKeyFrameType.ChangeAbsoluteAbility
            frame_info.integer_params = {}
            frame_info.string_params = {}
            frame_info.float_params = {}
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, self._buffOwner:GetGID())
            local target_pos = self._buffOwner:GetPosition();
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.x))
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.z))
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, self._buff._skillID)
            table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffID())
            table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffLv())
            table.placeholder_insert_number(frame_info.integer_params, self._trigger._triggerData.trigger_index)
            table.placeholder_insert_number(frame_info.integer_params, self._actionData.action_index)
            table.placeholder_insert_number(frame_info.float_params, self._value)
            FightKeyFrameInfo.AddKeyInfo(frame_info)
        end
    end
end

-----eBuffAction.DamageTransfer-----
DamageTransferAction = Class(DamageTransferAction,BaseAction)
function DamageTransferAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if skill_creator then
            self._buffOwner:GetBuffManager()._damageTransferObj = skill_creator:GetGID()
            self._buffOwner:GetBuffManager()._damageTransferPersent = self._actionData.persent

            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
    	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
    	        if user and (user:IsMyControl() or user:IsAIAgent()) then
    		        local duration = 0
    		        if self._buff.duration > 0 then
    			        duration = self._buff.duration
    			        self.send_cancel_msg = true
    		        end
    		        local info = {}
                    info.f_value1 = self._actionData.persent
                    info.n_value2 = skill_creator:GetGID()
    		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 13, info, duration)
    	        end
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DamageTransferAction:RollBack()
    if self._buffOwner:GetBuffManager()._damageTransferObj then
        self._buffOwner:GetBuffManager()._damageTransferObj = nil
        self._buffOwner:GetBuffManager()._damageTransferPersent = 0
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 13, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 13, info, duration)
		        end
	        end
        end
    end
end

-----eBuffAction.RecoverHPFeedback-----
RecoverHPFeedbackAction = Class(RecoverHPFeedbackAction,BaseAction)
function RecoverHPFeedbackAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._bRecoverHPFeedback = true
        self._buffOwner:GetBuffManager()._recoverHPFeedbackScale = self._actionData.scale
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RecoverHPFeedbackAction:RollBack()
    self._buffOwner:GetBuffManager()._damageTransferObj = nil    
end

-----eBuffAction.DamageRebound-----
DamageReboundAction = Class(DamageReboundAction,BaseAction)
function DamageReboundAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._bDamageRebound = true
        self._buffOwner:GetBuffManager()._damageReboundType = self._actionData.type
        self._buffOwner:GetBuffManager()._damageReboundScale = self._actionData.scale
        self._buffOwner:GetBuffManager()._damageReboundCalcuAbilityName = self._actionData.calcuabilityname
        self._buffOwner:GetBuffManager()._damageReboundCalcuScale = self._actionData.calcscale
        self._buffOwner:GetBuffManager()._damageReboundCalcuInfoindex = self._actionData.infoindex
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DamageReboundAction:RollBack()
    self._buffOwner:GetBuffManager()._bDamageRebound = false
    self._buffOwner:GetBuffManager()._damageReboundScale = 0
    self._buffOwner:GetBuffManager()._damageReboundCalcuAbilityName = nil
    self._buffOwner:GetBuffManager()._damageReboundCalcuScale = 0
end

-----eBuffAction.RecordTime-----
RecordTimeAction = Class(RecordTimeAction,BaseAction)
function RecordTimeAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._recordTime = PublicFunc.QueryCurTime()
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RecordTimeAction:RollBack()
end

-----eBuffAction.DamageAbsorb-----
DamageAbsorbAction = Class(DamageAbsorbAction,BaseAction)
function DamageAbsorbAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if skill_creator and (skill_creator:IsMyControl() or skill_creator:IsAIAgent()) then
                self._buffOwner:GetBuffManager()._bAbsorbDamage = true
		        local duration = 0
    		    if self._buff.duration > 0 then
    			    duration = self._buff.duration
    			    self.send_cancel_msg = true
    		    end
    		    msg_fight.cg_change_absorb_damage(self._buffOwner:GetGID(), true, self._buff._skillID, self._actionData.type, self._actionData.value, self._buff:GetBuffID(), self._buff:GetBuffLv(), skill_creator:GetGID(), self._actionData.buffid, self._actionData.bufflv, duration)
                self._buffOwner:GetBuffManager()._bAbsorbDamage = true
                self._buffOwner:GetBuffManager()._AbsorbBuffGID = self._buff._buffGID
            end
        else
            local value = 0
            if self._actionData.type == 0 then
                if skill_creator then
                    local calcuInfo = nil
                    local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                    if skillInfo and skillInfo[self._buff._skillLevel] then
                        calcuInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.value]
                    end
                    if calcuInfo == nil then
                        app.log("计算吸收时calcuInfo_.."..tostring(self._actionData.value).."..不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                    end
                    value = skill_creator:CalcuDamageAbsorbAsTarget(calcuInfo)
                end
            elseif self._actionData.type == 1 then
                value = self._actionData.value
            end
            self._buffOwner:GetBuffManager()._bAbsorbDamage = true
            self._buffOwner:GetBuffManager()._AbsorbBuffGID = self._buff._buffGID
            self._buffOwner:GetBuffManager()._lastAbsorbDamage = value
            self._buffOwner:GetBuffManager()._BuffLvAbsorbDamage = self._actionData.bufflv
            self._buffOwner:GetBuffManager()._BuffIDAbsorbDamage = self._actionData.buffid
            self._buffOwner:GetBuffManager()._SkillIDAbsorbDamage = self._buff._skillID
            self._buffOwner:GetBuffManager()._SkillLevelAbsorbDamage = self._buff._skillLevel
            self._buffOwner:GetBuffManager()._absorbDamageSrcBuff = {buffid=self._buff:GetBuffID(), bufflv=self._buff:GetBuffLv()}
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DamageAbsorbAction:RollBack()
    if self._buffOwner:GetBuffManager()._bAbsorbDamage and self._buffOwner:GetBuffManager()._AbsorbBuffGID == self._buff._buffGID then
        self._buffOwner:GetBuffManager()._bAbsorbDamage = false
        self._buffOwner:GetBuffManager()._lastAbsorbDamage = 0
        self._buffOwner:GetBuffManager()._absorbDamageSrcBuff = nil
        self._buffOwner:GetBuffManager()._BuffLvAbsorbDamage = nil
        self._buffOwner:GetBuffManager()._BuffIDAbsorbDamage = nil
        self._buffOwner:GetBuffManager()._SkillIDAbsorbDamage = nil
        self._buffOwner:GetBuffManager()._SkillLevelAbsorbDamage = nil
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_absorb_damage(self._buffOwner:GetGID(), false)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_absorb_damage(self._buffOwner:GetGID(), false)
		        end
	        end
        end
    end
end

-----eBuffAction.UnlockAnimation-----
UnlockAnimationAction = Class(UnlockAnimationAction,BaseAction)
function UnlockAnimationAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetAniCtrler().lock = false
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function UnlockAnimationAction:RollBack()
    
end

-----eBuffAction.DisposableImmuneSkillDamage-----
DisposableImmuneSkillDamageAction = Class(DisposableImmuneSkillDamageAction,BaseAction)
function DisposableImmuneSkillDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._bDisposableImmuneSkillDamage = true
        self._actionState = eBuffActionState.Over
        local pos = self._buffOwner:GetPosition(true)
        if self._actionData.effectid then
            self._buffOwner:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID = self._buffOwner:SetEffect(self._buff._skillCreator, ConfigManager.Get(EConfigIndex.t_effect_data,self._actionData.effectid), nil, nil, nil, nil, 0, nil, nil, false, self._buff._skillID)
        end
    end
    return self._actionState
end

function DisposableImmuneSkillDamageAction:RollBack()
    self._buffOwner:GetBuffManager()._bDisposableImmuneSkillDamage = false
    -- app.log("self._buffOwner:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID=="..tonumber(self._buffOwner:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID[1]));
    if self._buffOwner:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID and self._buffOwner:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID[1] then
        EffectManager.deleteEffect( self._buffOwner:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID[1] )
    end
end

-----eBuffAction.SuckBlood-----
-- SuckBloodAction = Class(SuckBloodAction,BaseAction)
-- function SuckBloodAction:RunAction(force, actionTimes)
--     if self._super.RunAction(self, force, actionTimes) then
--         self._buffOwner:GetBuffManager()._bSuckBlood = true
--         self._buffOwner:GetBuffManager()._suckBloosPersent = self._actionData.value
--         self._actionState = eBuffActionState.Over
--     end
--     return self._actionState
-- end

-- function SuckBloodAction:RollBack()
--     self._buffOwner:GetBuffManager()._bSuckBlood = false
--     self._buffOwner:GetBuffManager()._suckBloosPersent = 0
-- end

-----eBuffAction.CreateSummoneUnit-----
CreateSummoneUnitAction = Class(CreateSummoneUnitAction,BaseAction)
function CreateSummoneUnitAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if skillCreator and (skillCreator:IsAIAgent() or skillCreator:IsMyControl()) then
            end
        else
            local card_data = 
            {
                dataid = ObjectManager.cur_uuid,
                number = self._actionData.obj_id,
                level = 1,
                not_init_data = true,
            }
            if self._actionData.maxcnt then
                if #self._buffOwner.summone_list >= self._actionData.maxcnt then
                    ObjectManager.DeleteObj(self._buffOwner.summone_list[1])
                    table.remove(self._buffOwner.summone_list, 1)
                end
            end
            local card = CardHuman:new(card_data)
            card.baseProperty = self._buffOwner.card:GetBaseProperty()
            card.levelProperty = self._buffOwner.card:GetLevelProperty()
            local summone = FightScene.CreateSummoneUnitAsync(self._buffOwner:GetOwnerPlayerGID(), self._actionData.obj_id, nil, self._buffOwner:GetCampFlag(), self._buffOwner:GetCountryID(), card)
            if summone then
                self._value = summone:GetName()
                summone:SetOwnerPlayerGID(self._buffOwner:GetOwnerPlayerGID())
                local pos = nil
                if self._actionData.position == 0 then
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    local fromController = true
                    if skillCreator then
                        if skillCreator:IsAIAgent() then
                            fromController = false
                        else
                            fromController = skillCreator:IsMyControl()
                        end
                        if skillCreator.aperture_manager then
                            pos = skillCreator.aperture_manager:GetRTPosition(skillCreator.aperture_manager.apertureType[5], fromController)
                        end
                    end
                    
                    if pos == nil or (pos.x==0 and pos.y==0 and pos.z==0) then
                        pos = self._buffOwner:GetPosition(true)
                    end
                end
                summone:SetPosition(pos.x, pos.y, pos.z, true, true)
                summone:SetBornPoint(pos.x, pos.y, pos.z)
                summone:OnCreate()
                summone:SetCurSkillIndex(1)
                if self._actionData.effectid then
                           summone:SetEffect(self._buff._skillCreator, ConfigManager.Get(EConfigIndex.t_effect_data,self._actionData.effectid), nil, nil, nil, nil, nil, nil, nil, false, self._buff._skillID)
                end
                summone:SetAI(ENUM.EAI.Towner)
                table.insert(self._buffOwner.summone_list, self._value)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function CreateSummoneUnitAction:RollBack()
    if self._value then
        ObjectManager.DeleteObj(self._value)
    end
end

-----eBuffAction.ReplaceAnimID-----
ReplaceAnimIDAction = Class(ReplaceAnimIDAction,BaseAction)
function ReplaceAnimIDAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:ReplaceAnimID(self._actionData.old_id, self._actionData.new_id)
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ReplaceAnimIDAction:RollBack()
    self._buffOwner:ReplaceAnimID(self._actionData.old_id)
end

-----eBuffAction.VertigoAnimID-----
VertigoAnimIDAction = Class(VertigoAnimIDAction,BaseAction)
function VertigoAnimIDAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local take_effect = true
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if (not self._buffOwner:IsMyControl()) and (not self._buffOwner:IsAIAgent()) then
                take_effect = false
            end
        end
        if take_effect then
            self._buffOwner:PlayAnimate(EANI.stand)
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function VertigoAnimIDAction:RollBack()
    if not self._buffOwner:IsDead() then
        self._buffOwner:PlayAnimate(EANI.stand)
    end
end

-----eBuffAction.ShakeCamera-----
ShakeCameraAction = Class(ShakeCameraAction,BaseAction)
function ShakeCameraAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._buffOwner == FightManager.GetMyCaptain() then
            CameraManager.shake(
            {
            count = self._actionData.count or 2,
            x = self._actionData.x or 1,
            y = self._actionData.y or 3,
            z = self._actionData.z or 2,
            dis = self._actionData.dis or 0.1,
            speed = self._actionData.speed or 60,
            decay = self._actionData.decay or 0.5,
            multiply = self._actionData.multiply or 0,
            }
            )
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ShakeCameraAction:RollBack()
    self._buffOwner:PlayAnimate(EANI.stand)
end

-----eBuffAction.Invincible-----
InvincibleAction = Class(InvincibleAction,BaseAction)
function InvincibleAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local probability = math.random();
        if self._actionData.probability == nil or probability <= self._actionData.probability then
            self._buffOwner:GetBuffManager()._invincible = true;
            if self._actionData.except_type == 0 then
                if self._buff._defaultTarget then
                    self._buffOwner:GetBuffManager()._invincible_except_gid = self._buff._defaultTarget:GetGID()
                end
            else
                self._buffOwner:GetBuffManager()._invincible_except_gid = nil
            end
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
    	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
    	        if user and (user:IsMyControl() or user:IsAIAgent()) then
    		        local duration = 0
    		        if self._buff.duration > 0 then
    			        duration = self._buff.duration
    			        self.send_cancel_msg = true
    		        end
                    local info = {}
                    info.n_value2 = self._buffOwner:GetBuffManager()._invincible_except_gid
    		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 14, info, duration)
    	        end
            end
        end
        
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function InvincibleAction:RollBack()
    if self._buffOwner:GetBuffManager()._invincible then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.n_value2 = self._buffOwner:GetBuffManager()._invincible_except_gid
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 14, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 14, info, duration)
		        end
	        end
        end
        self._buffOwner:GetBuffManager()._invincible = false
        self._buffOwner:GetBuffManager()._invincible_except_gid = nil
    end
end

-----eBuffAction.ScaleMDamage2SomeStars-----
ScaleMDamage2SomeStarsAction = Class(ScaleMDamage2SomeStarsAction,BaseAction)
function ScaleMDamage2SomeStarsAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local action_info = {}
        action_info.stars = self._actionData.stars
        action_info.value = self._actionData.value
        action_info.type = self._actionData.type
        self._buffOwner:GetBuffManager()._scaleMDamage2SomeStars = action_info
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.f_value1 = self._actionData.value
                info.n_value1 = self._actionData.stars
                info.n_value2 = self._actionData.type
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 8, info, duration)
	        end
        end

        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ScaleMDamage2SomeStarsAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if self._buffOwner:GetBuffManager()._scaleMDamage2SomeStars then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.f_value1 = self._buffOwner:GetBuffManager()._scaleMDamage2SomeStars.value
            info.n_value1 = self._buffOwner:GetBuffManager()._scaleMDamage2SomeStars.stars
            info.n_value2 = self._buffOwner:GetBuffManager()._scaleMDamage2SomeStars.type
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 8, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 8, info, duration)
		        end
	        end
        end
    end
    self._buffOwner:GetBuffManager()._scaleMDamage2SomeStars = nil
end


-----eBuffAction.DetachAllDebuff-----
DetachAllDebuffAction = Class(DetachAllDebuffAction,BaseAction)
function DetachAllDebuffAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager():CheckRemove(eBuffPropertyType.DeBuff)
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DetachAllDebuffAction:RollBack()
end

-----eBuffAction.PlaySkillSound-----
PlaySkillSoundAction = Class(PlaySkillSoundAction,BaseAction)
function PlaySkillSoundAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.callbacktype ~= nil then
            self._cbFunction = SkillSoundActionCallBack
            self._cbData = {action=self, trigger=self._trigger}
        end
        local audioid = 0
        local point = string.find(""..self._actionData.id, ".", 1, true)
        if point == nil then
            audioid = self._actionData.id
        else
            local min = string.sub(""..self._actionData.id, 1, point)
            local max = string.sub(""..self._actionData.id, point+1)
            audioid = math.random(min, max)
        end
        local targets = {};
        local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator);
        if self._actionData.targettype == 1 then
            targets[1] = skillCreator;
        elseif self._actionData.targettype == 2 then
            targets = self:_GetTargetByIndex(self._trigger._arrThirdTarget)
        elseif self._actionData.targettype == 3 then
            targets = self:_GetTargetByIndex(self._buff._arrThirdTarget)
        else
            targets[1] = self._buffOwner
        end
        -- local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,3);
        for k,owner in ipairs(targets) do
            local bind_pos = owner:GetBindObj(3)
            local volScale = AudioManager.GetVolScaleBySceneEntity(skillCreator);
            local id, num, unique = AudioManager.Play3dAudio(audioid, bind_pos, owner:IsMyControl(), self._actionData.follow, self._actionData.unique, self._actionData.autostop, self._cbFunction, self._cbData, volScale)
            -- self._values[1] = AudioManager.GetAudio3dObject(id,num)
            table.insert(self._values,{id=id,num=num,unique=unique});
        end
        if self._actionData.callbacktype == nil then
            self._actionState = eBuffActionState.Over
	    elseif self._actionState == eBuffActionState.Begin then
		    self._actionState = eBuffActionState.Run
        end
    elseif self._actionState == eBuffActionState.Run then
        if PublicFunc.QueryDeltaTime(self._beginFrame) > self._actionData.limit then
            if self._actionData.callbacktype ~= nil then
                SkillSoundActionCallBack(self._cbData)
            end
            self._actionState = eBuffActionState.Over
        end
    end
    return self._actionState
end

function PlaySkillSoundAction:RollBack()
    for k,_values in ipairs(self._values) do
        local audio = AudioManager.GetAudio3dObject(_values.id, _values.num);
        AudioManager.Stop3dAudio(audio, _values.id, _values.num, _values.unique)
    end
end

function PlaySkillSoundAction:_GetTargetByIndex(list)
    local target = {};
    if list ~= nil then
        local len = #list
        if self._actionData.targetindex == nil then
            target = list 
        elseif self._actionData.targetindex == 0 then
            if len ~= 0 then
                target[1] = list[math.random(1,len)]
            end  
        else
            if list[self._actionData.targetindex] ~= nil then
                target[1] = list[self._actionData.targetindex]
            else
                target[1] = list[(self._actionData.targetindex%len)+1]
            end
        end
    end
    return target;
end

-----eBuffAction.DisposableRDamageCrit-----
DisposableRDamageCritAction = Class(DisposableRDamageCritAction,BaseAction)
function DisposableRDamageCritAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._disposableRDamageCrit = true
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
                    self.send_cancel_msg = true
		        end
                local info = {}
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 0, info, duration)
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DisposableRDamageCritAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        local duration = 0
		if self._buff.duration > 0 then
			duration = self._buff.duration
		end
        local info = {}
	    if duration > 0 and self.send_cancel_msg then
		    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 0, info, duration)
	    else
		    if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 0, info, duration)
		    end
	    end
    end
    self._buffOwner:GetBuffManager()._disposableRDamageCrit = false
end

-----eBuffAction.ChangeAbilityScaleAddition-----
ChangeAbilityScaleAdditionAction = Class(ChangeAbilityScaleAdditionAction,BaseAction)
function ChangeAbilityScaleAdditionAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local except_flag = 0
        if self._buff._skillID and self._buff._skillID > 0 and ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID) then
            except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).ability_except
        end
        if CheckExcept(self._buffOwner, except_flag) then
            self._actionTimes = self._actionTimes-1
        else
            local scale = self._actionData.scale
            local fromtype = ""
            if scale == nil then
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                if skillInfo and skillInfo[self._buff._skillLevel] then
                    if self._buff.ability_change_from == ENUM.AbilityChangeFrom.Self then
                        fromtype = "self_ability_change"
                        if skillInfo[self._buff._skillLevel].self_ability_change ~= 0 then
                            scale = skillInfo[self._buff._skillLevel].self_ability_change[self._actionData.abilityname]
                        end
                    elseif self._buff.ability_change_from == ENUM.AbilityChangeFrom.Enemy then
                        fromtype = "enemy_ability_change"
                        if skillInfo[self._buff._skillLevel].enemy_ability_change ~= 0 then
                            scale = skillInfo[self._buff._skillLevel].enemy_ability_change[self._actionData.abilityname]
                        end
                    elseif self._buff.ability_change_from == ENUM.AbilityChangeFrom.Friend then
                        fromtype = "friend_ability_change"
                        if skillInfo[self._buff._skillLevel].friend_ability_change ~= 0 then
                            scale = skillInfo[self._buff._skillLevel].friend_ability_change[self._actionData.abilityname]
                        end
                    else
                        fromtype = "not found creator"                                                    
                    end
                end
            end
            if scale == nil then
                self._actionTimes = self._actionTimes-1
                app.log("buff获取属性参数失败, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel).." fromtype="..fromtype.." buffid="..self._buff:GetBuffID().." lv="..self._buff:GetBuffLv().." ability="..self._actionData.abilityname)
            else
                if self._buffOwner:GetBuffManager():ScaleAbilityAddition(self._actionData.abilityname, scale, true) then
                    self._value = scale
                    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        if user and (user:IsMyControl() or user:IsAIAgent()) and ENUM.EHeroAttribute[self._actionData.abilityname] ~= nil then
                            local duration = 0
                            if self._buff.duration > 0 and self._buff:GetOverlapType() ~= eBuffOverlapType.Overlap and self._buff:GetOverlapType() ~= eBuffOverlapType.SameAllResetTime and self._buff:GetOverlapType() ~= eBuffOverlapType.SameIDResetTime then
                                duration = self._buff.duration
                                self.send_cancel_msg = true
                            end
                            msg_fight.cg_scale_ability(0, self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, true, false, duration, "")
                        end
                    elseif PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
                        local frame_info = {}
                        frame_info.type = ENUM.FightKeyFrameType.ScaleAbilityAddition
                        frame_info.integer_params = {}
                        frame_info.string_params = {}
                        frame_info.float_params = {}
                        local user_gid = 0
                        local user_pos = nil
                        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                        if user then
                            user_gid = user:GetGID()
                            user_pos = user:GetPosition()
                        end
                        table.placeholder_insert_number(frame_info.integer_params, user_gid)
                        if user_pos then
                            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(user_pos.x))
                            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(user_pos.z))
                        else
                            table.placeholder_insert_number(frame_info.integer_params, 0)
                            table.placeholder_insert_number(frame_info.integer_params, 0)
                        end
                        table.placeholder_insert_number(frame_info.integer_params, self._buffOwner:GetGID())
                        local target_pos = self._buffOwner:GetPosition();
                        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.x))
                        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.z))
                        table.placeholder_insert_number(frame_info.integer_params, 1)
                        table.placeholder_insert_number(frame_info.integer_params, self._buff._skillID)
                        table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffID())
                        table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffLv())
                        table.placeholder_insert_number(frame_info.integer_params, self._trigger._triggerData.trigger_index)
                        table.placeholder_insert_number(frame_info.integer_params, self._actionData.action_index)
                        table.placeholder_insert_number(frame_info.float_params, self._value)
                        FightKeyFrameInfo.AddKeyInfo(frame_info)
                    end
                    ----------------飘字--------------
                    local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                    if self._buffOwner._headInfoControler:Check(skillCreator) then
                        local abilityid = ENUM.EHeroAttribute[self._actionData.abilityname];
                        local offset_abilityid = abilityid-ENUM.min_property_id-1;
                        local offset_typeid = ENUM.EHeadInfoShowType.MaxHpUp-1;
                        local typeid = offset_abilityid*2-1+offset_typeid;
                        if scale > 0 then
                            self._buffOwner:GetHeadInfoControler():ShowArtisticText(typeid)
                        else
                            self._buffOwner:GetHeadInfoControler():ShowArtisticText(typeid+1)
                        end
                    end
                    ----------------------------------
                else
                    self._actionTimes = self._actionTimes-1
                end
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeAbilityScaleAdditionAction:RollBack()
    for i=1, self._actionTimes do
        self._buffOwner:GetBuffManager():ScaleAbilityAddition(self._actionData.abilityname, self._value, false)
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
            if self._buff.duration > 0 and self._buff:GetOverlapType() ~= eBuffOverlapType.Overlap and self._buff:GetOverlapType() ~= eBuffOverlapType.SameAllResetTime and self._buff:GetOverlapType() ~= eBuffOverlapType.SameIDResetTime then
                duration = self._buff.duration
            end
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_scale_ability(0, self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, false, false, duration)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) and ENUM.EHeroAttribute[self._actionData.abilityname] ~= nil then
                    msg_fight.cg_scale_ability(0, self._buffOwner:GetGID(), ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1, self._value, false, false, duration)
                end
            end
        elseif PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
            local frame_info = {}
            frame_info.type = ENUM.FightKeyFrameType.ScaleAbilityAddition
            frame_info.integer_params = {}
            frame_info.string_params = {}
            frame_info.float_params = {}
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, self._buffOwner:GetGID())
            local target_pos = self._buffOwner:GetPosition();
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.x))
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(target_pos.z))
            table.placeholder_insert_number(frame_info.integer_params, 0)
            table.placeholder_insert_number(frame_info.integer_params, self._buff._skillID)
            table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffID())
            table.placeholder_insert_number(frame_info.integer_params, self._buff:GetBuffLv())
            table.placeholder_insert_number(frame_info.integer_params, self._trigger._triggerData.trigger_index)
            table.placeholder_insert_number(frame_info.integer_params, self._actionData.action_index)
            table.placeholder_insert_number(frame_info.float_params, self._value)
            FightKeyFrameInfo.AddKeyInfo(frame_info)
        end
    end
end

-----eBuffAction.RecoverHPScale-----
RecoverHPScaleAction = Class(RecoverHPScaleAction,BaseAction)
function RecoverHPScaleAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager():ScaleHPRecover(self._actionData.scale, true)
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                    self.send_cancel_msg = true
                end
                msg_fight.cg_scale_hp_recover(self._buffOwner:GetGID(), self._actionData.scale, true, duration)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RecoverHPScaleAction:RollBack()
    for i=1, self._actionTimes do
        self._buffOwner:GetBuffManager():ScaleHPRecover(self._actionData.scale, false)
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
            if self._buff.duration > 0 then
                duration = self._buff.duration
            end
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_scale_hp_recover(self._buffOwner:GetGID(), self._actionData.scale, false, duration)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                    msg_fight.cg_scale_hp_recover(self._buffOwner:GetGID(), self._actionData.scale, false, duration)
                end
            end
        end
    end
end

-----eBuffAction.DisposableNormalDamageScale-----
DisposableNormalDamageScaleAction = Class(DisposableNormalDamageScaleAction,BaseAction)
function DisposableNormalDamageScaleAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._disposableNormalDamageScale = self._actionData.scale
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.f_value1 = self._actionData.scale
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 11, info, duration)
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DisposableNormalDamageScaleAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if self._buffOwner:GetBuffManager()._disposableNormalDamageScale ~= 0 then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.f_value1 = self._buffOwner:GetBuffManager()._disposableNormalDamageScale
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 11, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 11, info, duration)
		        end
	        end
        end
    end
    self._buffOwner:GetBuffManager()._disposableNormalDamageScale = 0
end

-----eBuffAction.SpecifiedRDamage-----
SpecifiedRDamageAction = Class(SpecifiedRDamageAction,BaseAction)
function SpecifiedRDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._specifiedRDamage = self._actionData.value
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function SpecifiedRDamageAction:RollBack()
    self._buffOwner:GetBuffManager()._specifiedRDamage = nil
end

-----eBuffAction.KillTargetAddBuff-----
KillTargetAddBuffAction = Class(KillTargetAddBuffAction,BaseAction)
function KillTargetAddBuffAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._killTargetAddBuffID = self._actionData.buffid
        self._buffOwner:GetBuffManager()._killTargetAddBuffLv = self._actionData.bufflv
        self._buffOwner:GetBuffManager()._killTargetAddBuffSkillID = self._actionData.skillid
        self._buffOwner:GetBuffManager()._killTargetBossAddBuffOverLap = self._actionData.bossadd
        self._buffOwner:GetBuffManager()._killTargetNotBossAddBuffOverLap = self._actionData.notbossadd
        self._buffOwner:GetBuffManager()._killTargetHeroAddBuffOverLap = self._actionData.heroadd
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function KillTargetAddBuffAction:RollBack()
    self._buffOwner:GetBuffManager()._killTargetAddBuffID = nil
    self._buffOwner:GetBuffManager()._killTargetAddBuffLv = nil
    self._buffOwner:GetBuffManager()._killTargetAddBuffSkillID = nil
end

-----eBuffAction.ClearSkillCD-----
ClearSkillCDAction = Class(ClearSkillCDAction,BaseAction)
function ClearSkillCDAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local take_effect = true
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if (not self._buffOwner:IsMyControl()) and (not self._buffOwner:IsAIAgent()) then
                take_effect = false
            end
        end
        if take_effect then
            if self._actionData.skillid then
                local skill = self._buffOwner:GetSkillBySkillID(self._actionData.skillid)
                if skill then
                    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                        msg_fight.cg_stop_skill_cd(self._buffOwner:GetGID(), skill:GetID(), self._actionData.cdvalue, self._actionData.cdtype)
                    end
                    skill:ClearCD(self._actionData.cdvalue, self._actionData.cdtype)
                end
            else
                for i = 1, MAX_SKILL_CNT do
                    local skill = self._buffOwner:GetSkill(i)
                    if skill and skill:CheckCD() == eUseSkillRst.CD then
                        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                            msg_fight.cg_stop_skill_cd(self._buffOwner:GetGID(), skill:GetID(), self._actionData.cdvalue, self._actionData.cdtype)
                        end
                        skill:ClearCD(self._actionData.cdvalue, self._actionData.cdtype)
                    end
                end
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ClearSkillCDAction:RollBack()
end

-----eBuffAction.LearnSkill-----
LearnSkillAction = Class(LearnSkillAction,BaseAction)
function LearnSkillAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local skill_id = self._actionData.skill_id;
        local skill_index = self._actionData.skill_index;
        local index = self._actionData.ui_index;
        self._buffOwner.old_skill_index = -1
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent() then
                world_msg.cg_change_skill(self._buffOwner:GetGID(), skill_id, skill_index)
            end
        else
            local level = 1;
            local skill = self._buffOwner:GetSkill(index)
            if skill then
                level = skill._skillLevel
            end
            self._buffOwner:LearnSkill(skill_id, level, index, skill_index, self._actionData.save_cd );
            if self._buffOwner:GetName() == g_dataCenter.fight_info:GetCaptainName() then
                GetMainUI():UpdateSkillIcon(self._buffOwner);
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function LearnSkillAction:RollBack()
end

-----eBuffAction.ClearAtteckerRecord-----
ClearAtteckerRecordAction = Class(ClearAtteckerRecordAction,BaseAction)
function ClearAtteckerRecordAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner._AttackerName = nil;
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ClearAtteckerRecordAction:RollBack()
end

-----eBuffAction.CanSearch-----
CanSearchAction = Class(CanSearchAction,BaseAction)
function CanSearchAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:SetCanSearch(self._actionData.search);
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function CanSearchAction:RollBack()
    self._buffOwner:SetCanSearch(not self._actionData.search);
end

-----------eBuffAction.HPEnable-----------
HPEnableAction = Class(HPEnableAction,BaseAction)
function HPEnableAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:ShowHP(self._actionData.enable);
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function HPEnableAction:RollBack()
    self._buffOwner:ShowHP(not self._actionData.enable);
end

-----------eBuffAction.AddNormalDamageFromSkillCreator-----------
AddNormalDamageFromSkillCreatorAction = Class(AddNormalDamageFromSkillCreatorAction,BaseAction)
function AddNormalDamageFromSkillCreatorAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if skill_creator then
            self._buffOwner:GetBuffManager()._addNormalDamageFromSkillCreator[self._buffOwner:GetBuffManager()._nAddNormalDamageFromSkillCreatorIndex+1] = {infoindex=self._actionData.infoindex, creatorgid=skill_creator:GetGID(), skillid=self._buff._skillID}
            self._buffOwner:GetBuffManager()._nAddNormalDamageFromSkillCreatorIndex = self._buffOwner:GetBuffManager()._nAddNormalDamageFromSkillCreatorIndex + 1
            self._value = self._buffOwner:GetBuffManager()._nAddNormalDamageFromSkillCreatorIndex
        end
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if skill_creator and (skill_creator:IsMyControl() or skill_creator:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.n_value1 = self._actionData.infoindex
                info.n_value2 = skill_creator:GetGID()
                info.n_value3 = self._buff._skillID
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 16, info, duration)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function AddNormalDamageFromSkillCreatorAction:RollBack()
    if self._value ~= 0 then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if self._buffOwner:GetBuffManager()._addNormalDamageFromSkillCreator[self._value] then
	            local duration = 0
	            if self._buff.duration > 0 then
		            duration = self._buff.duration
	            end
	            local info = {}
                info.n_value1 = self._buffOwner:GetBuffManager()._addNormalDamageFromSkillCreator[self._value].infoindex
                info.n_value2 = self._buffOwner:GetBuffManager()._addNormalDamageFromSkillCreator[self._value].creatorgid
                info.n_value3 = self._buffOwner:GetBuffManager()._addNormalDamageFromSkillCreator[self._value].skillid
	            if duration > 0 and self.send_cancel_msg then
		            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 16, info, duration)
	            else
		            if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 16, info, duration)
		            end
	            end
            end
        end
        self._buffOwner:GetBuffManager()._addNormalDamageFromSkillCreator[self._value] = nil
    end
end

-----------eBuffAction.EnableMoveWhenSkill-----------
EnableMoveWhenSkillAction = Class(EnableMoveWhenSkillAction,BaseAction)
function EnableMoveWhenSkillAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner.canMoveWhenSkill = true;
        self._buffOwner.canMoveWhenSkillID = self._buff._skillID
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function EnableMoveWhenSkillAction:RollBack()
    self._buffOwner.canMoveWhenSkill = false;
end

-----------eBuffAction.ReboundNormalDamage-----------
ReboundNormalDamageAction = Class(ReboundNormalDamageAction,BaseAction)
function ReboundNormalDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._reboundNormalDamageScale = self._actionData.scale
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if skill_creator and (skill_creator:IsMyControl() or skill_creator:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.f_value1 = self._actionData.scale
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 17, info, duration)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ReboundNormalDamageAction:RollBack()
    if self._buffOwner:GetBuffManager()._reboundNormalDamageScale ~= 0 then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.f_value1 = self._actionData.scale
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 17, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 17, info, duration)
		        end
	        end
        end
        self._buffOwner:GetBuffManager()._reboundNormalDamageScale = 0
    end
end

-----------eBuffAction.Taunt-----------
TauntAction = Class(TauntAction,BaseAction)
function TauntAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if not self._buffOwner:GetBuffManager():IsStateImmune(EImmuneStateType.ChaoFeng) then
            local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                if skill_creator and (skill_creator:IsMyControl() or skill_creator:IsAIAgent()) then
		            local duration = 0
		            if self._buff.duration > 0 then
			            duration = self._buff.duration
			            self.send_cancel_msg = true
		            end
		            msg_fight.cg_sync_taunt_target(self._buffOwner:GetGID(), skill_creator:GetGID(), duration, self._buff:GetBuffID(), self._buff:GetBuffLv(), true)
                end
            else
                local tauntTarget = ObjectManager.GetObjectByName(self._buff._skillCreator)
                if tauntTarget then
                    self._buffOwner:GetBuffManager()._tauntTarget = tauntTarget:GetGID()
                    self._buffOwner:GetBuffManager()._tauntBuffID = self._buff:GetBuffID()
                    self._buffOwner:GetBuffManager()._tauntBuffLv = self._buff:GetBuffLv()
                    tauntTarget.taunt_list[self._buffOwner:GetGID()] = 1
                end
                self._buffOwner:PostEvent("BeTaunt")
            end
            if self._buffOwner._headInfoControler:Check(skill_creator) then
                self._buffOwner:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ChaoFengChengGong)
            end
        else
            local skill_creator = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if self._buffOwner._headInfoControler:Check(skill_creator) then
                self._buffOwner:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ImmuneChaoFeng)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function TauntAction:RollBack()
    local tauntTarget = ObjectManager.GetObjectByName(self._buff._skillCreator)
    if tauntTarget then
        if self._buffOwner:GetBuffManager()._tauntTarget == tauntTarget:GetGID() then
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                end
                if duration > 0 and self.send_cancel_msg then
                    msg_fight.cg_sync_taunt_target(self._buffOwner:GetGID(), tauntTarget:GetGID(), duration, 0, 0, false)
                else
                    if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                        msg_fight.cg_sync_taunt_target(self._buffOwner:GetGID(), tauntTarget:GetGID(), duration, 0, 0, false)
                    end
                end
            else
                local tauntTarget = ObjectManager.GetObjectByGID(self._buffOwner:GetBuffManager()._tauntTarget)
                if tauntTarget then
                    tauntTarget.taunt_list[self._buffOwner:GetGID()] = nil
                end
                self._buffOwner:GetBuffManager()._tauntTarget = nil

                self._buffOwner:PostEvent("FinishBeTaunt")
            end
        end
    end
end

-----------eBuffAction.DisposableAbsoluteMDamage-----------
DisposableAbsoluteMDamageAction = Class(DisposableAbsoluteMDamageAction,BaseAction)
function DisposableAbsoluteMDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.n_value1 = user:GetGID()
                info.n_value2 = self._buff._skillID
                info.n_value3 = self._actionData.type
                if self._actionData.type == 0 then
                    info.n_value4 = self._actionData.value
                end
                self._value = info.n_value1
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 19, info, duration)
	        end
        else
            if self._actionData.type == 0 then
                local damageInfo = nil
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                if skillInfo and skillInfo[self._buff._skillLevel] then
                    damageInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.value]
                    if damageInfo and damageInfo.skillrefscale == 1 then
                        damageInfo.skillgid = self._buff._skillGid
                    end
                end
                if damageInfo == nil then
                    app.log("计算伤害时damageInfo_"..tostring(self._actionData.value).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                end
                local atk_value = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
                local value = PublicFunc.AttrInteger(damageInfo.fixeddamage + atk_value*damageInfo.atkscale)
                value = math.floor(value)
                self._buffOwner:GetBuffManager()._disposableAbsoluteMDamage = value
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DisposableAbsoluteMDamageAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if self._value then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.n_value1 = self._value
            info.n_value2 = self._buff._skillID
            info.n_value3 = self._actionData.type
            if self._actionData.type == 0 then
                info.f_value1 = self._actionData.value
            elseif self._actionData.type == 1 then
                info.n_value4 = self._actionData.value
            elseif self._actionData.type == 2 then
                info.n_value4 = self._actionData.value
            end
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 19, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 19, info, duration)
		        end
	        end
        end
    end
    self._buffOwner:GetBuffManager()._disposableAbsoluteMDamage = 0
end

-----------eBuffAction.Immortal-----------
ImmortalAction = Class(ImmortalAction,BaseAction)
function ImmortalAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._immortal = true;
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 21, info, duration)
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ImmortalAction:RollBack()
    if self._buffOwner:GetBuffManager()._immortal then
        self._buffOwner:GetBuffManager()._immortal = false;
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 21, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 21, info, duration)
		        end
	        end
        end
    end
end

-----------eBuffAction.Kidnap-----------
KidnapAction = Class(KidnapAction,BaseAction)
function KidnapAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._buffOwner:GetBuffManager().KidnaperGID == nil then
            local take_effect = true
            local skill_info = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID)
            if self._buff._skillID and self._buff._skillID > 0 and skill_info then
                local except_flag = 0
                except_flag = skill_info.kidnap_except
                if except_flag and except_flag ~= 0 and CheckExcept(self._buffOwner, except_flag) then
                    take_effect = false
                end
            end
            if take_effect then
                local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
                if user then
                    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	                    if user:IsMyControl() or user:IsAIAgent() then
		                    local duration = 0
		                    if self._buff.duration > 0 then
			                    duration = self._buff.duration
			                    self.send_cancel_msg = true
		                    end
		                    local info = {}
                            info.n_value1 = user:GetGID()
                            info.n_value2 = self._actionData.type;
                            --app.log("发送开始抓取消息")
		                    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 20, info, duration)
	                    end 
                    else
                        self._buffOwner:KidnapByGID(user:GetGID(), self._actionData.type);
                    end
                    self._value = user:GetGID()
                end
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function KidnapAction:RollBack()
    if self._value then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.n_value1 = self._value
	        if duration > 0 and self.send_cancel_msg then
                --app.log("发送停止抓取消息")
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 20, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                    --app.log("发送停止抓取消息")
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 20, info, duration)
		        end
	        end
        else
            self._buffOwner:KidnapByGID()
        end
        
    end
end

-----------eBuffAction.ChangeAbsoluteMNormalDamage-----------
ChangeAbsoluteMNormalDamageAction = Class(ChangeAbsoluteMNormalDamageAction,BaseAction)
function ChangeAbsoluteMNormalDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.n_value1 = self._buff._skillID
                info.n_value2 = self._actionData.infoindex
                self._value = info.n_value1
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 22, info, duration)
	        end
        else
            
            local damageInfo = nil
            local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
            if skillInfo and skillInfo[self._buff._skillLevel] then
                damageInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.infoindex]
                if damageInfo and damageInfo.skillrefscale == 1 then
                    damageInfo.skillgid = self._buff._skillGid
                end
            end
            if damageInfo == nil then
                app.log("计算伤害时damageInfo_"..tostring(self._actionData.infoindex).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
            end
            local atk_value = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
            local value = PublicFunc.AttrInteger(damageInfo.fixeddamage + atk_value*damageInfo.atkscale)
            value = math.floor(value)
            self._buffOwner:GetBuffManager()._changeAbsoluteMNormalDamage = value
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeAbsoluteMNormalDamageAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if self._value then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.n_value1 = self._buff._skillID
            info.n_value2 = self._actionData.infoindex
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 22, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 22, info, duration)
		        end
	        end
        end
    end
    self._buffOwner:GetBuffManager()._changeAbsoluteMNormalDamage = 0
end

-----------eBuffAction.RecordRecover-----------
RecordRecoverAction = Class(RecordRecoverAction,BaseAction)
function RecordRecoverAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if self._actionData.type == nil then
            self._buffOwner:GetBuffManager()._bRecordRecover = true
            self._buffOwner:GetBuffManager()._nRecordRecover = 0
        end
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
                    self.send_cancel_msg = true
		        end
                local info = {}
                if self._actionData.recordtimes then
                    info.n_value1 = self._actionData.recordtimes
                else
                    info.n_value1 = -1
                end
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 18, info, duration)
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RecordRecoverAction:RollBack()
   if self._buffOwner:GetBuffManager()._bRecordRecover then
        self._buffOwner:GetBuffManager()._bRecordRecover = false
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
            if self._buff.duration > 0 then
                duration = self._buff.duration
            end
            local info = {}
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 18, info, duration)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 18, info, duration)
                end
            end
        end
    end
end

-----------eBuffAction.UnlockAnim-----------
UnlockAnimAction = Class(UnlockAnimAction,BaseAction)
function UnlockAnimAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetAniCtrler().lock = false
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function UnlockAnimAction:RollBack()
end

-----------eBuffAction.ChangeScaleProMDamage-----------
ChangeScaleProMDamageAction = Class(ChangeScaleProMDamageAction,BaseAction)
function ChangeScaleProMDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._changeScaleProMDamage = self._actionData.scale
        self._buffOwner:GetBuffManager()._changeScaleProMType = self._actionData.protype
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.f_value1 = self._actionData.scale
                info.n_value1 = self._actionData.protype
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 23, info, duration)
	        end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeScaleProMDamageAction:RollBack()
    if self._buffOwner:GetBuffManager()._changeScaleProMDamage and self._buffOwner:GetBuffManager()._changeScaleProMType then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
    	    if self._buff.duration > 0 then
    		    duration = self._buff.duration
    	    end
    	    local info = {}
    	    if duration > 0 and self.send_cancel_msg then
    		    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 23, info, duration)
    	    else
    		    if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
    			    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 23, info, duration)
    		    end
    	    end
        end
        self._buffOwner:GetBuffManager()._changeScaleProMDamage = nil
        self._buffOwner:GetBuffManager()._changeScaleProMType = nil
    end
end

-----------eBuffAction.DisposableAbsoluteMNormalDamage-----------
DisposableAbsoluteMNormalDamageAction = Class(DisposableAbsoluteMNormalDamageAction,BaseAction)
function DisposableAbsoluteMNormalDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
	        if user and (user:IsMyControl() or user:IsAIAgent()) then
		        local duration = 0
		        if self._buff.duration > 0 then
			        duration = self._buff.duration
			        self.send_cancel_msg = true
		        end
		        local info = {}
                info.n_value1 = user:GetGID()
                info.n_value2 = self._buff._skillID
                info.n_value3 = self._actionData.type
                if self._actionData.type == 0 then
                    info.n_value4 = self._actionData.value
                end
                self._value = info.n_value1
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 24, info, duration)
	        end
        else
            if self._actionData.type == 0 then
                local damageInfo = nil
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                if skillInfo and skillInfo[self._buff._skillLevel] then
                    damageInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.value]
                    if damageInfo and damageInfo.skillrefscale == 1 then
                        damageInfo.skillgid = self._buff._skillGid
                    end
                end
                if damageInfo == nil then
                    app.log("计算伤害时damageInfo_"..tostring(self._actionData.value).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                end
                local atk_value = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
                local value = PublicFunc.AttrInteger(damageInfo.fixeddamage + atk_value*damageInfo.atkscale)
                value = math.floor(value)
                self._buffOwner:GetBuffManager()._disposableAbsoluteMNormalDamage = value
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DisposableAbsoluteMNormalDamageAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if self._value then
	        local duration = 0
	        if self._buff.duration > 0 then
		        duration = self._buff.duration
	        end
	        local info = {}
            info.n_value1 = self._value
            info.n_value2 = self._buff._skillID
            info.n_value3 = self._actionData.type
            if self._actionData.type == 0 then
                info.f_value1 = self._actionData.value
            elseif self._actionData.type == 1 then
                info.n_value4 = self._actionData.value
            elseif self._actionData.type == 2 then
                info.n_value4 = self._actionData.value
            end
	        if duration > 0 and self.send_cancel_msg then
		        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 24, info, duration)
	        else
		        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
			        msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 24, info, duration)
		        end
	        end
        end
    end
    self._buffOwner:GetBuffManager()._disposableAbsoluteMNormalDamage = 0
end

-----------eBuffAction.DisposableAbsoluteMNormalDamage-----------
UpdatePos2ServerAction = Class(UpdatePos2ServerAction,BaseAction)
function UpdatePos2ServerAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	        if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                local pos = self._buffOwner:GetPosition();
                msg_move.cg_translate_position(self._buffOwner:GetGID(), pos.x * PublicStruct.Coordinate_Scale, pos.z * PublicStruct.Coordinate_Scale)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function UpdatePos2ServerAction:RollBack()
end

-----------eBuffAction.ShowArtisticText-----------
ShowArtisticTextAction = Class(ShowArtisticTextAction,BaseAction)
function ShowArtisticTextAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local target = {}
        if self._actionData.targettype == 0 then
            target[1] = self._buffOwner;
        elseif self._actionData.targettype == 1 then
            target = self._trigger._arrThirdTarget
        elseif self._actionData.targettype == 2 then
            target = self._trigger._arrCallBackTarget
        end
        local bCreatorControl = false
        local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if skillCreator and skillCreator:IsMyControl() and skillCreator:IsCaptain() then
            bCreatorControl = true
        end
        local len = #target
        for i=1, len do
            if target[i]._headInfoControler:Check(skillCreator) or bCreatorControl then
                target[i]:GetHeadInfoControler():ShowArtisticText(self._actionData.type)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ShowArtisticTextAction:RollBack()
end


-----------eBuffAction.DisposableScaleMDamage-----------
DisposableScaleMDamageAction = Class(DisposableScaleMDamageAction,BaseAction)
function DisposableScaleMDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._disposableScaleMDamage = self._actionData.scale
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                    self.send_cancel_msg = true
                end
                local info = {}
                info.f_value1 = self._actionData.scale
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 25, info, duration)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function DisposableScaleMDamageAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        local duration = 0
        if self._buff.duration > 0 then
            duration = self._buff.duration
        end
        local info = {}
        if duration > 0 and self.send_cancel_msg then
            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 25, info, duration)
        else
            if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 25, info, duration)
            end
        end
    end
    self._buffOwner:GetBuffManager()._disposableScaleMDamage = 1
end

-----------eBuffAction.ScaleMDamageByTargetHP-----------
ScaleMDamageByTargetHPAction = Class(ScaleMDamageByTargetHPAction,BaseAction)
function ScaleMDamageByTargetHPAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._scaleMDamageByTargetHPPersent = self._actionData.hppersent
        self._buffOwner:GetBuffManager()._scaleMDamageByTargetHPValue = self._actionData.damagescale
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                    self.send_cancel_msg = true
                end
                local info = {}
                info.f_value1 = self._actionData.damagescale
                info.n_value1 = self._actionData.hppersent
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 26, info, duration)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ScaleMDamageByTargetHPAction:RollBack()
    if self._buffOwner:GetBuffManager()._scaleMDamageByTargetHPPersent and self._buffOwner:GetBuffManager()._scaleMDamageByTargetHPValue then
        self._buffOwner:GetBuffManager()._scaleMDamageByTargetHPPersent = nil
        self._buffOwner:GetBuffManager()._scaleMDamageByTargetHPValue = nil
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
            if self._buff.duration > 0 then
                duration = self._buff.duration
            end
            local info = {}
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 26, info, duration)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 26, info, duration)
                end
            end
        end
    end
end

-----------eBuffAction.TowardsTarget-----------
TowardsTargetAction = Class(TowardsTargetAction,BaseAction)
function TowardsTargetAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local x,y,z = nil
        if self._actionData.targettype == 1 then
            x,y,z = self._buff._defaultTarget:GetPositionXYZ()
        end
        if x then
            self._buffOwner:LookAt(x,y,z)
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function TowardsTargetAction:RollBack()
end

-----------eBuffAction.RandomSetSkillLock-----------
RandomSetSkillLockAction = Class(RandomSetSkillLockAction,BaseAction)
function RandomSetSkillLockAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._actionState = eBuffActionState.Over
        local skill_list = table.copy(self._actionData.skill_list);
        local num = self._actionData.num;
        while(num~=0 and #skill_list ~= 0)do
            local index = math.random(1,#skill_list);
            local skill_id = skill_list[index]+Const.MAX_NORMAL_ATTACK_INDEX;
            local skill = self._buffOwner:GetSkill(skill_id);
            if skill then
                skill:SetDisenable(true);
            end
            table.insert(self._values, skill_id);
            num = num - 1;
            table.remove(skill_list,index);
        end
        if GetMainUI() then
            GetMainUI():UpdateSkillIcon(self._buffOwner);
        end
    end
    return self._actionState
end

function RandomSetSkillLockAction:RollBack()
    for k,skill_id in pairs(self._values) do
        local skill = self._buffOwner:GetSkill(skill_id);
        if skill then
            skill:SetDisenable(false);
        end
    end
    self._values = {};
end

-----------eBuffAction.CreateMonster-----------
CreateMonsterAction = Class(CreateMonsterAction,BaseAction)
function CreateMonsterAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if skillCreator then
            local pos = nil
            if self._actionData.postype == 0 then
                pos = self._buff._recordPosition
            end
            if pos then
                local newmonster = FightScene.CreateMonsterAsync(nil, self._actionData.monsterid, skillCreator:GetCampFlag(), nil, nil, self._actionData.groupname)
                newmonster:SetPosition(pos.x, pos.y, pos.z)
                local rotation = skillCreator:GetRotation()
                newmonster:SetRotation(rotation.x,rotation.y,rotation.z)
                newmonster:SetHomePosition(newmonster:GetPosition(true, true))
                newmonster:SetHostGID(skillCreator:GetGID())
                newmonster:SetDeadAttachHostBuff(self._actionData.deadcreatorbuff)
                PublicFunc.UnifiedScale(newmonster)
                FightScene.GetFightManager():OnLoadMonster(newmonster);
                skillCreator:AddSummonMonster(newmonster:GetName())
                self.value = newmonster:GetName()
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function CreateMonsterAction:RollBack()
    if self.value then
        local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if skillCreator then
            skillCreator:DelSummonMonster(self.value)
        end
        FightScene.DeleteObj(self.value)
    end
end

-----------eBuffAction.ImmuneFrontDamage-----------
ImmuneFrontDamageAction = Class(ImmuneFrontDamageAction,BaseAction)
function ImmuneFrontDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._buffOwner:GetBuffManager()._immuneFrontDamage = true
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ImmuneFrontDamageAction:RollBack()
    self._buffOwner:GetBuffManager()._immuneFrontDamage = false
end

-----------eBuffAction.PlayVideo-----------
PlayVideoAction = Class(PlayVideoAction,BaseAction)
function PlayVideoAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        ObjectManager.EnableAllAi(false) -- 直接停掉所有AI
        -- file.player_mp4(self._actionData.path, ENUM.EVideoMode.Hidden)
        -- if self._actionData.callback then
        --     Utility.CallFunc(self._actionData.callback)
        -- end
        
        local ready_func = function()
            NoticeManager.Notice(ENUM.NoticeType.TriggerPlayVideoAction)
        end
        PublicFunc.MediaPlay(self._actionData.path, self._actionData.callback, ready_func, false, false, true)
        
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function PlayVideoAction:RollBack()
end

-----------eBuffAction.AttachDelayBuff-----------
AttachDelayBuffAction = Class(AttachDelayBuffAction,BaseAction)
function AttachDelayBuffAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self.delay_index = self.delay_index or 0
        self.delay_record = self.delay_record or {}
        local target = nil
        if self._actionData.targettype == 0 then
            target = self._trigger._arrThirdTarget
        elseif self._actionData.targettype == 1 then
            target = self._trigger._arrCallBackTarget
        elseif self._actionData.targettype == 2 then
            target = self._buff._arrThirdTarget
        end
        if target then
            for i=1, #target do
                local delay = 0
                if self._actionData.recorddelay and self.delay_record[target[i]:GetGID()] then
                    delay = self.delay_record[target[i]:GetGID()]
                else
                    delay = self.delay_index*self._actionData.delayincrease
                    self.delay_index = self.delay_index + 1
                    if self._actionData.recorddelay then
                        self.delay_record[target[i]:GetGID()] = delay
                    end
                end
                if self._actionData.maxdelay and delay > self._actionData.maxdelay then
                    delay = self._actionData.maxdelay
                    self.delay_index = 0
                end
                target[i]:AttachBuff(self._actionData.buffid, self._actionData.bufflv, self._buff._skillCreator, self._buffOwner:GetName(), nil, self._buff._skillGid, nil, delay, self._buff._skillID, self._buff._skillLevel, self._buff._defaultTarget, nil, false, nil)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function AttachDelayBuffAction:RollBack()
end


-----------eBuffAction.ServerSearchAndCalcuDamage-----------
ServerSearchAndCalcuDamageAction = Class(ServerSearchAndCalcuDamageAction,BaseAction)
function ServerSearchAndCalcuDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent())then
                local ex_persent = 1.0
                if self._actionData.persent then
                    ex_persent = self._actionData.persent
                end
                local radius = self._actionData.radius
                local length = self._actionData.length
                local width = self._actionData.width
                if radius == nil then
                    radius = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).distance 
                end
                if length == nil then
                    length = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).distance 
                end
                if width == nil then
                    width = ConfigManager.Get(EConfigIndex.t_skill_info,self._buff._skillID).width 
                end
                if radius then
                    radius = radius * PublicStruct.Coordinate_Scale
                end
                if length then
                    length = length * PublicStruct.Coordinate_Scale
                end
                if width then
                    width = width * PublicStruct.Coordinate_Scale
                end
                local dir = {x=0, y=0, z=0}
                if self._actionData.dirtype == 0 then
                    dir = self._buffOwner:GetForWard()
                end
                local posx = 9999
                local posz = 9999
                if self._actionData.searchtype == 2 then
                    if self._buff._recordPosition then
                        posx = self._buff._recordPosition.x * PublicStruct.Coordinate_Scale
                        posz = self._buff._recordPosition.z * PublicStruct.Coordinate_Scale
                    end
                end
                msg_fight.cg_server_search_and_calculate(user:GetGID(), self._buff._skillID, self._actionData.type, self._actionData.infoindex, ex_persent, posx, posz, self._actionData.targetype, radius, length, width, dir.x, dir.z, self._actionData.buffid, self._actionData.bufflv)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ServerSearchAndCalcuDamageAction:RollBack()
end


-----------eBuffAction.CalcuExtraDamagePool-----------
CalcuExtraDamagePoolAction = Class(CalcuExtraDamagePoolAction,BaseAction)
function CalcuExtraDamagePoolAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent())then
                local overlap = self._buffOwner:GetBuffManager():GetBuffOverlap(self._actionData.buffid, self._actionData.bufflv)
                if overlap > 0 then
                    local target_cnt = 1
                    if self._trigger._arrThirdTarget and #self._trigger._arrThirdTarget > 1 then
                        target_cnt = #self._trigger._arrThirdTarget
                    end
                    self.value = true
                    msg_fight.cg_calculate_extra_damage_pool(self._buffOwner:GetGID(), self._buff._skillID, overlap, self._actionData.infoindex, target_cnt)
                end
            end
        else
            local damageInfo = nil
            local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
            if skillInfo and skillInfo[self._buff._skillLevel] then
                damageInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.infoindex]
                if damageInfo and damageInfo.skillrefscale == 1 then
                    damageInfo.skillgid = self._buff._skillGid
                end
            end
            if self._actionData.type == 0 then
                if damageInfo == nil then
                    app.log("计算伤害池时damageInfo_"..tostring(self._actionData.infoindex).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                end
                local overlap = self._buffOwner:GetBuffManager():GetBuffOverlap(self._actionData.buffid, self._actionData.bufflv)
                if overlap > 0 then
                    local damage = self._buffOwner:CalcuDamageFormula(nil, damageInfo) * overlap;
                    local target_cnt = 1
                    if self._trigger._arrThirdTarget and #self._trigger._arrThirdTarget > 1 then
                        target_cnt = #self._trigger._arrThirdTarget
                    end
                    damage = math.floor(damage/target_cnt)
                    self._buffOwner:GetBuffManager()._extraDamagePool = damage 
                end
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function CalcuExtraDamagePoolAction:RollBack()
    if (self._buffOwner:GetBuffManager()._extraDamagePool and self._buffOwner:GetBuffManager()._extraDamagePool > 0) or self.value then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            msg_fight.cg_clear_extra_damage_pool(self._buffOwner:GetGID());
        end
        self._buffOwner:GetBuffManager()._extraDamagePool = 0
    end
end

-- -----------eBuffAction.DisposableScaleMCritHurt-----------
-- DisposableScaleMCritHurtAction = Class(DisposableScaleMCritHurtAction,BaseAction)
-- function DisposableScaleMCritHurtAction:RunAction(force, actionTimes)
--     if self._super.RunAction(self, force, actionTimes) then
--         self._buffOwner:GetBuffManager()._disposableScaleMCritHurt = self._actionData.scale
--         if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
--             local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
--             if user and (user:IsMyControl() or user:IsAIAgent()) then
--                 local duration = 0
--                 if self._buff.duration > 0 then
--                     duration = self._buff.duration
--                     self.send_cancel_msg = true
--                 end
--                 local info = {}
--                 info.f_value1 = self._actionData.scale
--                 msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 27, info, duration)
--             end
--         end
--         self._actionState = eBuffActionState.Over
--     end
--     return self._actionState
-- end

-- function DisposableScaleMCritHurtAction:RollBack()
--     if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
--         local duration = 0
--         if self._buff.duration > 0 then
--             duration = self._buff.duration
--         end
--         local info = {}
--         if duration > 0 and self.send_cancel_msg then
--             msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 27, info, duration)
--         else
--             if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
--                 msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 27, info, duration)
--             end
--         end
--     end
--     self._buffOwner:GetBuffManager()._disposableScaleMCritHurt = 1
-- end

-----------eBuffAction.AttrFinallyCalcuAdd-----------
AttrFinallyCalcuAddAction = Class(AttrFinallyCalcuAddAction,BaseAction)
function AttrFinallyCalcuAddAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local _scale = self._actionData.scale;
        local _attrType = self._actionData.type;
        self._buffOwner:GetBuffManager():AttrFinallyCalcuAdd(_attrType,_scale,true);
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local cur_scale = self._buffOwner:GetBuffManager():GetAttrFinallyCalcu(_attrType)
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                    self.send_cancel_msg = true
                end
                local info = {}
                info.f_value1 = cur_scale
                info.n_value1 = _attrType
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 27, info, duration)
            end
        end
        ----------------飘字--------------
        local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if self._buffOwner._headInfoControler:Check(skillCreator) then
            local abilityid = ENUM.EHeroAttribute[self._actionData.abilityname];
            local typeid = nil;
            if _attrType == 1 then
                typeid = ENUM.EHeadInfoShowType.DodgeRateUp;
            elseif _attrType == 2 then
                typeid = ENUM.EHeadInfoShowType.ParryRateUp;
            elseif _attrType == 3 then
                typeid = ENUM.EHeadInfoShowType.CritRateUp;
            elseif _attrType == 4 then
                typeid = ENUM.EHeadInfoShowType.ParryPlusUp;
            elseif _attrType == 5 then
                typeid = ENUM.EHeadInfoShowType.CritHurtUp;
            elseif _attrType == 6 then
                typeid = ENUM.EHeadInfoShowType.BloodsuckRateUp;
            elseif _attrType == 7 then
                typeid = ENUM.EHeadInfoShowType.RallyRateUp;
            end
            if typeid then
                if _scale > 0 then
                    self._buffOwner:GetHeadInfoControler():ShowArtisticText(typeid)
                else
                    self._buffOwner:GetHeadInfoControler():ShowArtisticText(typeid+1)
                end
            end
        end
        ----------------------------------
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function AttrFinallyCalcuAddAction:RollBack()
    local _scale = self._actionData.scale;
    local _attrType = self._actionData.type;
    self._buffOwner:GetBuffManager():AttrFinallyCalcuAdd(_attrType,_scale,false);
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        local cur_scale = self._buffOwner:GetBuffManager():GetAttrFinallyCalcu(_attrType)
        local duration = 0
        if self._buff.duration > 0 then
            duration = self._buff.duration
        end
        local info = {}
        info.n_value1 = _attrType
        info.f_value1 = cur_scale
        if duration > 0 and self.send_cancel_msg then
            msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), cur_scale ~= 0, 27, info, duration)
        else
            if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), cur_scale ~= 0, 27, info, duration)
            end
        end
    end
end

-----------eBuffAction.ScaleMDamageByTeamHeroHP-----------
ScaleMDamageByTeamHeroHPAction = Class(ScaleMDamageByTeamHeroHPAction,BaseAction)
function ScaleMDamageByTeamHeroHPAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local num = 0;
        if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
            g_dataCenter.fight_info:foreach_obj(self._buffOwner:GetCampFlag(),true
                , function (obj_name)
                    if obj_name == self._buffOwner:GetName() then
                        return;
                    end
                    local obj = ObjectManager.GetObjectByName(obj_name);
                    if obj:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/obj:GetPropertyVal(ENUM.EHeroAttribute.max_hp) < self._actionData.hppersent then
                        num = num + 1;
                    end
                end)
        else
            g_dataCenter.fight_info:foreach_obj(self._buffOwner:GetCampFlag(),true
                , function (obj_name)
                    if obj_name == self._buffOwner:GetName() then
                        return;
                    end
                    local obj = ObjectManager.GetObjectByName(obj_name);
                    if obj:GetOwnerPlayerGID() ~= self._buffOwner:GetOwnerPlayerGID() then
                        return;
                    end
                    if obj:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)/obj:GetPropertyVal(ENUM.EHeroAttribute.max_hp) < self._actionData.hppersent then
                        num = num + 1;
                    end
                end)
        end
        self._buffOwner:GetBuffManager()._scaleMDamageByTeamHeroHPValue = self._actionData.damagescale * num
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                    self.send_cancel_msg = true
                end
                local info = {}
                info.f_value1 = self._buffOwner:GetBuffManager()._scaleMDamageByTeamHeroHPValue
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), true, 28, info, duration)
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ScaleMDamageByTeamHeroHPAction:RollBack()
    if self._buffOwner:GetBuffManager()._scaleMDamageByTeamHeroHPValue then
        self._buffOwner:GetBuffManager()._scaleMDamageByTeamHeroHPValue = nil
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local duration = 0
            if self._buff.duration > 0 then
                duration = self._buff.duration
            end
            local info = {}
            if duration > 0 and self.send_cancel_msg then
                msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 28, info, duration)
            else
                if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
                    msg_fight.cg_change_fight_extra_property(self._buffOwner:GetGID(), false, 28, info, duration)
                end
            end
        end
    end
end

-- -----------eBuffAction.LockRecordName-----------
-- LockRecordNameAction = Class(LockRecordNameAction,BaseAction)
-- function LockRecordNameAction:RunAction(force, actionTimes)
--     if self._super.RunAction(self, force, actionTimes) then
--         local name = self._actionData.name;
--         local value = self._actionData.lock;
--         self._buffOwner:SetExternalAreaState(name, value);
--         if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
--             local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
--             if user and (user:IsMyControl() or user:IsAIAgent()) then
--                 local duration = 0
--                 if self._buff.duration > 0 then
--                     duration = self._buff.duration
--                     self.send_cancel_msg = true
--                 end
--                 msg_fight.cg_lock_property_change_record(self._buffOwner:GetGID(), name, value)
--             end
--         end
--         self._actionState = eBuffActionState.Over
--     end
--     return self._actionState
-- end

-- function LockRecordNameAction:RollBack()
--     local name = self._actionData.name;
--     local value = self._actionData.lock;
--     self._buffOwner:SetExternalAreaState(name, not value);
--     if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
--         local duration = 0
--         if self._buff.duration > 0 then
--             duration = self._buff.duration
--         end
--         local info = {}
--         if duration > 0 and self.send_cancel_msg then
--             msg_fight.cg_lock_property_change_record(self._buffOwner:GetGID(), name, not value)
--         else
--             if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
--                 msg_fight.cg_lock_property_change_record(self._buffOwner:GetGID(), name, not value)
--             end
--         end
--     end
-- end

-- -----------eBuffAction.BackScaleRDamage-----------
-- BackScaleRDamageAction = Class(BackScaleRDamageAction,BaseAction)
-- function BackScaleRDamageAction:RunAction(force, actionTimes)
--     if self._super.RunAction(self, force, actionTimes) then
--         local value = self._actionData.scale;
--         self._buffOwner:GetBuffManager()._backScaleRDamage = value;
--         if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
--             -- local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
--             -- if user and (user:IsMyControl() or user:IsAIAgent()) then
--             --     local duration = 0
--             --     if self._buff.duration > 0 then
--             --         duration = self._buff.duration
--             --         self.send_cancel_msg = true
--             --     end
--             --     msg_fight.cg_lock_property_change_record(self._buffOwner:GetGID(), name, value)
--             -- end
--         end
--         self._actionState = eBuffActionState.Over
--     end
--     return self._actionState
-- end

-- function BackScaleRDamageAction:RollBack()
--     self._buffOwner:GetBuffManager()._backScaleRDamage = nil;
--     if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
--         -- local duration = 0
--         -- if self._buff.duration > 0 then
--         --     duration = self._buff.duration
--         -- end
--         -- local info = {}
--         -- if duration > 0 and self.send_cancel_msg then
--         --     msg_fight.cg_lock_property_change_record(self._buffOwner:GetGID(), name, not value)
--         -- else
--         --     if (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent()) then
--         --         msg_fight.cg_lock_property_change_record(self._buffOwner:GetGID(), name, not value)
--         --     end
--         -- end
--     end
-- end

-----------eBuffAction.AbsorbAbilityToCreator-----------
AbsorbAbilityToCreatorAction = Class(AbsorbAbilityToCreatorAction,BaseAction)
function AbsorbAbilityToCreatorAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local abilityname = self._actionData.abilityname;
        local abilityscale = self._actionData.abilityscale;
        local creatorability = self._actionData.creatorability;
        local maxscale = self._actionData.maxscale;
        local recordname = self._actionData.recordname;
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                self._value = PublicFunc.GetIncrementSequence()
                msg_fight.cg_absorb_ability_to_creator(user:GetGID(), self._buffOwner:GetGID(), true, ENUM.EHeroAttribute[self._actionData.abilityname]-ENUM.min_property_id-1,
                    self._actionData.abilityscale, ENUM.EHeroAttribute[self._actionData.creatorability]-ENUM.min_property_id-1, self._actionData.maxscale, self._value)
            end
        else
            local selfability = self._buffOwner:GetPropertyVal(abilityname);
            local add_value = selfability * abilityscale
            if add_value >= 1 then
                local skillCreator = ObjectManager.GetObjectByName(self._buff._skillCreator)
                if skillCreator then
                    local skillability = skillCreator.card:GetPropertyVal(creatorability);
                    local maxValue = skillability * maxscale;
                    local recordvalue = skillCreator:GetExternalArea(recordname) or 0;
                    if maxValue > recordvalue then
                        self._value = add_value;
                        self._buffOwner:GetBuffManager():ChangeAbility(abilityname, -self._value);
                        skillCreator:SetExternalArea(recordname, recordvalue+self._value);
                        skillCreator:GetBuffManager():ChangeAbility(creatorability, self._value);
                    end
                end
            end
            
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function AbsorbAbilityToCreatorAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
    else
        if self._value then
            self._buffOwner:GetBuffManager():ChangeAbility(self._actionData.abilityname, self._value);
        end
    end
end

-----------eBuffAction.ChangeAngularSpeed-----------
ChangeAngularSpeedAction = Class(ChangeAngularSpeedAction,BaseAction)
function ChangeAngularSpeedAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local _value = self._actionData.value;
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                end
                local dir = self._buffOwner:GetForWard()
                msg_fight.cg_change_angular_velocity(self._buffOwner:GetGID(), _value, duration, dir.x, dir.z, true)
            end
        end
        if self._buffOwner and (self._buffOwner:IsMyControl() or self._buffOwner:IsAIAgent() or (PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single)) then
            self._value = self._buffOwner:GetAngularSpeed();
            self._buffOwner:SetAngularSpeed(_value);
            self._actionState = eBuffActionState.Over
        end
    end
    return self._actionState
end

function ChangeAngularSpeedAction:RollBack()
    if self._value then
        self._buffOwner:SetAngularSpeed(self._value);
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                end
                local dir = self._buffOwner:GetForWard()
                msg_fight.cg_change_angular_velocity(self._buffOwner:GetGID(), self._value, duration, dir.x, dir.z, false)
            end
        end
    end
    
end

-----------eBuffAction.ChangeFrontScaleDamage-----------
ChangeFrontScaleDamageAction = Class(ChangeFrontScaleDamageAction,BaseAction)
function ChangeFrontScaleDamageAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local _value = self._actionData.value;
        local _valuetype = self._actionData.valuetype;
        local _scale = self._actionData.scale;
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
            if user and (user:IsMyControl() or user:IsAIAgent()) then
                local duration = 0
                if self._buff.duration > 0 then
                    duration = self._buff.duration
                end
                msg_fight.cg_change_front_scale_damage(user:GetGID(), self._buff._skillID, true, _scale or 1, _value or 0, _valuetype, duration)
            end
        else
            if _valuetype == 2 then
                local damageInfo = nil
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,self._buff._skillID)
                if skillInfo and skillInfo[self._buff._skillLevel] then
                    damageInfo = skillInfo[self._buff._skillLevel].damage[self._actionData.value]
                    if damageInfo and damageInfo.skillrefscale == 1 then
                        damageInfo.skillgid = self._buff._skillGid
                    end
                end
                if damageInfo == nil then
                    app.log("计算伤害时damageInfo_"..tostring(self._actionData.value).."不存在, skillid="..tostring(self._buff._skillID).." skilllv="..tostring(self._buff._skillLevel))
                end
                local atk_value = self._buffOwner:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
                local value = PublicFunc.AttrInteger(damageInfo.fixeddamage + atk_value*damageInfo.atkscale)
                _value = math.floor(value)
            end
            self._buffOwner:GetBuffManager()._changeFrontScaleDamageScale = _scale or 1;
            self._buffOwner:GetBuffManager()._changeFrontScaleDamageValue = _value or 0;
            self._buffOwner:GetBuffManager()._changeFrontScaleDamage = true;
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function ChangeFrontScaleDamageAction:RollBack()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        local user = ObjectManager.GetObjectByName(self._buff._skillCreator)
        if user and (user:IsMyControl() or user:IsAIAgent()) then
            msg_fight.cg_change_front_scale_damage(user:GetGID(), 0, false, 0, 0, 0, 0)
        end
    else
        self._buffOwner:GetBuffManager()._changeFrontScaleDamageScale = nil;
        self._buffOwner:GetBuffManager()._changeFrontScaleDamageValue = nil;
        self._buffOwner:GetBuffManager()._changeFrontScaleDamage = nil;
    end
end

-----------eBuffAction.RecordMultiPos-----------
RecordMultiPosAction = Class(RecordMultiPosAction,BaseAction)
function RecordMultiPosAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        self._actionData.minradiusscale = self._actionData.minradiusscale or 0
        local src_pos = self._buffOwner:GetPosition()
        local skill = self._buffOwner:GetSkillBySkillID(self._buff._skillID)
        local skill_dis = self._actionData.radius
        if skill_dis == nil and skill then
            skill_dis = skill:GetDistance()
        end
        local all_pos = {}
        if self._actionData.postype == 0 then
            for i=1, self._actionData.times do
                local pos = {}
                pos.x = src_pos.x
                pos.y = src_pos.y
                pos.z = src_pos.z
                local found_time = 0;
                local found = false;
                while (not found) and found_time < 20 do
                    local radius = ((math.random(0, 100-self._actionData.minradiusscale) + self._actionData.minradiusscale)/100)*skill_dis
                    local angle = math.random(0, 360)
                    pos.x = src_pos.x + math.sin(angle*3.1415926/180)*radius;  
                    pos.z = src_pos.z + math.cos(angle*3.1415926/180)*radius;

                    local bRet, hit = util.raycase_out4(pos.x, 20, pos.z, 0, -1, 0, 50, PublicFunc.GetBitLShift({PublicStruct.UnityLayer.terrain}));
                    if bRet then
                        bRet, _x, _y, _z = util.get_navmesh_sampleposition(hit.x, hit.y, hit.z, 15);
                        if bRet then
                            pos.x = _x
                            pos.y = _y
                            pos.z = _z
                            found = true;
                        end
                    end
                    found_time = found_time+1
                end
                table.insert(all_pos, pos)
            end
        elseif self._actionData.postype == 1 then
            for i=1, self._actionData.times do
                local pos = {}
                local found = false;
                while not found do
                    local radius = ((math.random(0, 100-self._actionData.minradiusscale) + self._actionData.minradiusscale)/100)*skill_dis
                    local angle = math.random(0, 360)
                    pos.x = src_pos.x + math.sin(angle*3.1415926/180)*radius;
                    pos.y = src_pos.y
                    pos.z = src_pos.z + math.cos(angle*3.1415926/180)*radius;

                    local bRet, nx, ny, nz = self._buffOwner.navMeshAgent:ray_cast(src_pos.x, src_pos.y, src_pos.z, pos.x, pos.y, pos.z, self._buffOwner.navMeshAgent:get_area_mask())
                    if bRet then
                        bRet, _x, _y, _z = util.get_navmesh_sampleposition(nx, ny, nz, 15);
                        if bRet then
                            pos.x = _x
                            pos.y = _y
                            pos.z = _z
                            found = true;
                        end
                    end
                end
                table.insert(all_pos, pos)
            end
        elseif self._actionData.postype == 2 then
            for i=1, self._actionData.times do
                table.insert(all_pos, self._buff._defaultTarget:GetPosition()) 
            end
        elseif self._actionData.postype == 3 then
            for i=1, self._actionData.times do
                local pos = {}
                local radius = ((math.random(0, 100-self._actionData.minradiusscale) + self._actionData.minradiusscale)/100)*skill_dis
                local angle = math.random(0, 360)
                pos.x = src_pos.x + math.sin(angle*3.1415926/180)*radius;
                pos.y = src_pos.y
                pos.z = src_pos.z + math.cos(angle*3.1415926/180)*radius;
                table.insert(all_pos, pos)
            end
        elseif self._actionData.postype == 4 then
            for i=1, self._actionData.times do
                local pos = {}
                local forward = self._buffOwner:GetForWard()
                pos.x = src_pos.x + forward.x*(i-1)*self._actionData.offset+forward.x*self._actionData.offset_begin
                pos.y = src_pos.y
                pos.z = src_pos.z + forward.z*(i-1)*self._actionData.offset+forward.z*self._actionData.offset_begin
                table.insert(all_pos, pos)
            end
        end
        
        if self._actionData.savetype == 0 then
            self._buff._multi_record_pos = self._buff._multi_record_pos or {}
            for i=1, #all_pos do
                table.insert(self._buff._multi_record_pos, all_pos[i])
            end
        elseif self._actionData.savetype == 1 then
            local buff_manager = self._buffOwner:GetBuffManager()
            if self._actionData.clear == nil or self._actionData.clear == true then
                buff_manager._multi_record_pos = {}
            end
            for i=1, #all_pos do
                table.insert(buff_manager._multi_record_pos, all_pos[i])
            end
        end
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function RecordMultiPosAction:RollBack()
end

-----------eBuffAction.SetPosition-----------
SetPositionAction = Class(SetPositionAction,BaseAction)
function SetPositionAction:RunAction(force, actionTimes)
    if self._super.RunAction(self, force, actionTimes) then
        local pos = nil
        if self._actionData.postype == 0 then
            if self._actionData.posindex == 0 then
                local index = math.random(1,#self._buff._multi_record_pos)
                if index == self._buff._multi_record_index then
                    index = index + 1
                    if index > #self._buff._multi_record_pos then
                        index = 1 
                    end
                end
                self._buff._multi_record_index = index
                pos = self._buff._multi_record_pos[index]
            end
        end
        self._buffOwner:SetPosition(pos.x, pos.y, pos.z, true, true)
        self._actionState = eBuffActionState.Over
    end
    return self._actionState
end

function SetPositionAction:RollBack()
end

ACTION_CREATOR = {
    [eBuffAction.RunAnimation] = RunAnimationAction,
    [eBuffAction.UseThirdTarget] = UseThirdTargetAction,
	[eBuffAction.ChangeAbilityScaleMultiply] = ChangeAbilityScaleMultiplyAction,
	[eBuffAction.MakeDamage] = MakeDamageAction,
    [eBuffAction.AttachBuff] = AttachBuffAction,
    [eBuffAction.RunEffect] = RunEffectAction,
    [eBuffAction.SpecialEffect] = SpecialEffectAction,
    [eBuffAction.ImmuneEnemySkill] = ImmuneEnemySkillAction,
    [eBuffAction.DamageScaleFromSkillCreator] = DamageScaleFromSkillCreatorAction,
    [eBuffAction.Hide] = HideAction,
    [eBuffAction.DetachBuff] = DetachBuffAction,
    [eBuffAction.ShowAperture] = ShowApertureAction,
    [eBuffAction.AttachDelayBuffWithDistance] = AttachDelayBuffWithDistanceAction,
    [eBuffAction.MovePosition] = MovePositionAction,
    [eBuffAction.UnlockSkill] = UnlockSkillAction,
    [eBuffAction.ChangeLockAttackTarget] = ChangeLockAttackTargetAction,
    [eBuffAction.SequenceRunEffect] = SequenceRunEffectAction,
    [eBuffAction.FixedCamera] = FixedCameraAction,
    [eBuffAction.RenderEnable] = RenderEnableAction,
    [eBuffAction.TimeDelay] = TimeDelayAction,
    [eBuffAction.StartSkillCD] = StartSkillCDAction,
    [eBuffAction.ImmuneState] = ImmuneStateAction,
    [eBuffAction.Repel] = RepelAction,
    [eBuffAction.RecordDamage] = RecordDamageAction,
    [eBuffAction.RecoverHP] = RecoverHPAction,
    [eBuffAction.ChangeAbsoluteMDamage] = ChangeAbsoluteMDamageAction,
    [eBuffAction.BeAttackAnimation] = BeAttackAnimationAction,
    [eBuffAction.RemoveRationEffect] = RemoveRationEffectAction,
    [eBuffAction.ResetAttachTime] = ResetAttachTimeAction,
    [eBuffAction.ChangeScaleMDamage] = ChangeScaleMDamageAction,
    [eBuffAction.ChangeScaleRDamage] = ChangeScaleRDamageAction,
    [eBuffAction.RecordTowardsAndPosition] = RecordTowardsAndPositionAction,
    [eBuffAction.ScaleModel] = ScaleModelAction,
    [eBuffAction.AttachBuffWhenUseSkill] = AttachBuffWhenUseSkillAction,
    [eBuffAction.ChangeScaleNormalMDamage] = ChangeScaleNormalMDamageAction,
    [eBuffAction.ChangeAbsoluteNormalMDamage] = ChangeAbsoluteNormalMDamageAction,
    [eBuffAction.DisposableAbsoluteRDamage] = DisposableAbsoluteRDamageAction,
    [eBuffAction.DisposableScaleRDamage] = DisposableScaleRDamageAction,
    [eBuffAction.AttachBuffWhenGainDamage] = AttachBuffWhenGainDamageAction,
    [eBuffAction.ChangeAppearance] = ChangeAppearanceAction,
    [eBuffAction.ChangeAbilityAbsolute] = ChangeAbilityAbsoluteAction,
    [eBuffAction.DamageTransfer] = DamageTransferAction,
    [eBuffAction.RecoverHPFeedback] = RecoverHPFeedbackAction,
    [eBuffAction.DamageRebound] = DamageReboundAction,
    --[eBuffAction.Taunt] = TauntAction,
    [eBuffAction.RecordTime] = RecordTimeAction,
    [eBuffAction.DamageAbsorb] = DamageAbsorbAction,
    [eBuffAction.UnlockAnimation] = UnlockAnimationAction,
    [eBuffAction.DisposableImmuneSkillDamage] = DisposableImmuneSkillDamageAction,
    -- [eBuffAction.SuckBlood] = SuckBloodAction,
    [eBuffAction.CreateSummoneUnit] = CreateSummoneUnitAction,
    [eBuffAction.ReplaceAnimID] = ReplaceAnimIDAction,
    [eBuffAction.VertigoAnimID] = VertigoAnimIDAction,
    [eBuffAction.ShakeCamera] = ShakeCameraAction,
    [eBuffAction.Invincible] = InvincibleAction,
    [eBuffAction.ScaleMDamage2SomeStars] = ScaleMDamage2SomeStarsAction,
    [eBuffAction.DetachAllDebuff] = DetachAllDebuffAction,
    [eBuffAction.PlaySkillSound] = PlaySkillSoundAction,
    [eBuffAction.DisposableRDamageCrit] = DisposableRDamageCritAction,
    [eBuffAction.ChangeAbilityScaleAddition] = ChangeAbilityScaleAdditionAction,
    [eBuffAction.RecoverHPScale] = RecoverHPScaleAction,
    [eBuffAction.DisposableNormalDamageScale] = DisposableNormalDamageScaleAction,
    [eBuffAction.SpecifiedRDamage] = SpecifiedRDamageAction,
    [eBuffAction.KillTargetAddBuff] = KillTargetAddBuffAction,
    [eBuffAction.ClearSkillCD] = ClearSkillCDAction,
    [eBuffAction.LearnSkill] = LearnSkillAction,
    [eBuffAction.ClearAtteckerRecord] = ClearAtteckerRecordAction,
    [eBuffAction.CanSearch] = CanSearchAction,
    [eBuffAction.HPEnable] = HPEnableAction,
    [eBuffAction.AddNormalDamageFromSkillCreator] = AddNormalDamageFromSkillCreatorAction,
    [eBuffAction.EnableMoveWhenSkill] = EnableMoveWhenSkillAction,
    [eBuffAction.ReboundNormalDamage] = ReboundNormalDamageAction,
    [eBuffAction.Taunt] = TauntAction,
    [eBuffAction.DisposableAbsoluteMDamage] = DisposableAbsoluteMDamageAction,
    [eBuffAction.Immortal] = ImmortalAction,
    [eBuffAction.Kidnap] = KidnapAction,
    [eBuffAction.ChangeAbsoluteMNormalDamage] = ChangeAbsoluteMNormalDamageAction,
    [eBuffAction.RecordRecover] = RecordRecoverAction,
    [eBuffAction.UnlockAnim] = UnlockAnimAction,
    [eBuffAction.ChangeScaleProMDamage] = ChangeScaleProMDamageAction,
    [eBuffAction.DisposableAbsoluteMNormalDamage] = DisposableAbsoluteMNormalDamageAction,
    [eBuffAction.UpdatePos2Server] = UpdatePos2ServerAction,
    [eBuffAction.ShowArtisticText] = ShowArtisticTextAction,
    [eBuffAction.DisposableScaleMDamage] = DisposableScaleMDamageAction,
    [eBuffAction.ScaleMDamageByTargetHP] = ScaleMDamageByTargetHPAction,
    [eBuffAction.TowardsTarget] = TowardsTargetAction,
    [eBuffAction.RandomSetSkillLock] = RandomSetSkillLockAction,
    [eBuffAction.CreateMonster] = CreateMonsterAction,
    [eBuffAction.ImmuneFrontDamage] = ImmuneFrontDamageAction,
    [eBuffAction.PlayVideo] = PlayVideoAction,
    [eBuffAction.AttachDelayBuff] = AttachDelayBuffAction,
    [eBuffAction.ServerSearchAndCalcuDamage] = ServerSearchAndCalcuDamageAction,
    [eBuffAction.CalcuExtraDamagePool] = CalcuExtraDamagePoolAction,
    -- [eBuffAction.DisposableScaleMCritHurt] = DisposableScaleMCritHurtAction,
    [eBuffAction.AttrFinallyCalcuAdd] = AttrFinallyCalcuAddAction,
    [eBuffAction.ScaleMDamageByTeamHeroHP] = ScaleMDamageByTeamHeroHPAction,
    -- [eBuffAction.LockRecordName] = LockRecordNameAction,
    -- [eBuffAction.BackScaleRDamage] = BackScaleRDamageAction,
    [eBuffAction.AbsorbAbilityToCreator] = AbsorbAbilityToCreatorAction,
    [eBuffAction.ChangeAngularSpeed] = ChangeAngularSpeedAction,
    [eBuffAction.ChangeFrontScaleDamage] = ChangeFrontScaleDamageAction,
    [eBuffAction.RecordMultiPos] = RecordMultiPosAction,
    [eBuffAction.SetPosition] = SetPositionAction,
}
--[[endregion]]