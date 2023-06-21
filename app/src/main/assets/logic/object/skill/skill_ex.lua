--[[
region skill_ex.lua
date: 2015-8-3
time: 11:50:34
author: Nation
单个技能对象
]]

SkillEx = Class(SkillEx)
SkillEx.SKILL_GID_CREATOR = 1
function SkillEx:Init(owner)
   self._owner = owner
   self._skillCDEnd = PublicFunc.QueryCurTime()
   self._skillCancelTime = 0
   self._bIsWorking = false
   self._uiIndex = 1
   self._angle = 0
   self._lastCD = 0
   self._skillLevel = 0
   self._isInForeverCD = false
   self._disenableRef = 0
end

function SkillEx:InitData(skillData, skillLevel)
    self._skillData = skillData
    self._skillInfo = ConfigManager.Get(EConfigIndex.t_skill_info,self._skillData.id)
    self._skillLevel = skillLevel
    if self._skillInfo == nil then
        app.log("找不到技能基础信息..id="..tostring(self._skillData.id))
    end
    self._lastCD = self._skillInfo.cd
end

function SkillEx:CheckCD()
    if self._isInForeverCD then
        return eUseSkillRst.CD
    end
    return (PublicFunc.QueryCurTime() > self._skillCDEnd) and eUseSkillRst.OK or eUseSkillRst.CD
end

function SkillEx:SetDisenable(disenable)
    if disenable then
        self._disenableRef = self._disenableRef + 1
    else
        self._disenableRef = self._disenableRef - 1
    end
    if self._disenableRef < 0 then
        self._disenableRef = 0
    end
end

function SkillEx:IsDisenable()
    return (self._disenableRef > 0)
end

function SkillEx:StartInitCD()
    if self._skillInfo.init_skill_cd and type(self._skillInfo.init_skill_cd) == "table" then
        for k, v in pairs(self._skillInfo.init_skill_cd) do
            if v[1] == FightScene.GetCurHurdleID() then
                self:StartCD(false, v[2]*1000)
                break
            end
        end
    end
end

function SkillEx:StartCD(fromBuff, force_cd)
    if self._skillData.cdtype == ESkillCDType.Forever then
        self._isInForeverCD = true
        return
    end
    local cd = self._skillInfo.cd
    if cd and cd ~= 0 and self:GetSkillType() == eSkillType.Normal and self._owner and 
        self._owner:GetAniCtrler()._lastAnimSpeed and self._owner:GetAniCtrler()._lastAnimSpeed ~= 1 then
        if self._owner:GetAniCtrler()._lastAnimSpeed < 1 then
            local offset = 1-self._owner:GetAniCtrler()._lastAnimSpeed;
            cd = cd + cd*offset
        else
            local offset = self._owner:GetAniCtrler()._lastAnimSpeed-1;
            cd = cd - cd*offset
        end
    end
    if cd and cd ~= 0 then
        local useSuccess = false
        if fromBuff == true then
            --if self._skillData.cdtype == 1 then
                useSuccess = true
            --end
        else
            if self._skillData.cdtype == ESkillCDType.Immediately or self._skillData.cdtype == nil then
                useSuccess = true
            end
        end
        if useSuccess == true then
            local cool_down_dec = self._owner:GetPropertyVal(ENUM.EHeroAttribute.cool_down_dec)
            local _property_ratio = ConfigManager.Get(EConfigIndex.t_property_ratio, 1) 
            self._lastCD = cd*((cool_down_dec>0) and (1-(cool_down_dec/(cool_down_dec+_property_ratio.cool_down_dec_ratio))) or 1)
            if type(force_cd) == "number" then
                self._lastCD = force_cd;
            end
            self._skillCDEnd = PublicFunc.QueryFutureTime(self._lastCD)
            if self._owner == FightManager.GetMyCaptain() then
                GetMainUI():SkillStartCd(self._uiIndex, self._skillCDEnd, self._lastCD/1000)
            end
            if self._owner:IsHero() then
                PublicFunc.msg_dispatch("start_skill_cd", self._owner:GetName(), self._uiIndex, self._skillCDEnd, self._lastCD/1000)
            end
        end
    end
end

function SkillEx:ClearCD(cd_value, cd_type)
    if cd_value then
        local del_time = nil
        if cd_type == 1 then
            del_time = cd_value
        elseif cd_type == 0 then
            del_time = self._lastCD*cd_value
        end
        self._skillCDEnd = self._skillCDEnd - (del_time/1000)
    else
        self._skillCDEnd = 0
    end
    if self._owner == FightManager.GetMyCaptain() then
        if self._skillCDEnd <= PublicFunc.QueryCurTime() then
            GetMainUI():SkillStopCD(self._uiIndex)
        else
            GetMainUI():SkillStartCd(self._uiIndex, self._skillCDEnd, self._lastCD/1000)
        end
    end

    if self._owner:IsHero() then
        if self._skillCDEnd <= PublicFunc.QueryCurTime() then
            PublicFunc.msg_dispatch("stop_skill_cd", self._owner:GetName(), self._uiIndex)
        else
            PublicFunc.msg_dispatch("start_skill_cd", self._owner:GetName(), self._uiIndex, self._skillCDEnd, self._lastCD/1000)
        end
    end

end

function SkillEx:GetCD()
    return self._skillInfo.cd
end

function SkillEx:GetLastCD()
    return self._lastCD
end

function SkillEx:GetID()
    return self._skillInfo.id
end

function SkillEx:GetEffectType()
    return self._skillInfo.effect_type
end

function SkillEx:GetCancelType()
    return self._skillData.cancel
end

function SkillEx:IsCanRotate()
    return (self._skillData.canrotate == 1)
end

function SkillEx:IsWorking()
    return self._bIsWorking
end

function SkillEx:IsComboSkill()
    return (self._skillData.combo == 1)
end

function SkillEx:IsIgnoreDir()
    return (self._skillData.ignoredir == 1)
end

function SkillEx:GetLessThanHP()
    return self._skillData.lesshp
end

function SkillEx:GetSkillType()
    return self._skillInfo.type
end

function SkillEx:IsCanManualDir()
    return self._skillData.manualdir == 1
end

function SkillEx:GetDistance()
    return self._skillInfo.distance
end

function SkillEx:GetExtraDistance()
    return self._skillInfo.extra_distance
end

function SkillEx:GetApertureType()
    return self._skillInfo.aperture
end

function SkillEx:GetPriorityBuff()
    return self._skillData.pri_buff
end

function SkillEx:GetCDType()
    return self._skillData.cdtype
end

function SkillEx:CheckTarget(target)
    --[[if self._skillData.needtarget == eSkillNeedTargetType.NotNeed or
       self._skillData.needtarget == eSkillNeedTargetType.NeedGround then
        return eUseSkillRst.OK
    elseif self._skillData.needtarget == eSkillNeedTargetType.NeedTarget then
        if not target then
            return eUseSkillRst.NeedTarget
        end
        --todo(Nation) 一系列条件
    end]]
    return eUseSkillRst.OK
end

function SkillEx:GetTargetType(target)
    return self._skillData.needtarget
end

function SkillEx:StartWork(target)
    --if self._skillData.canceltime then
    local pos = self._owner:GetPosition(true)
    self._skillCancelTime = PublicFunc.QueryFutureTime(500)
    --end
    self._bIsWorking = true
    if self._skillData.lasthalo == 1 and self._owner == FightManager.GetMyCaptain() then
        GetMainUI():EnableRationEffect(self._uiIndex, true)
    end
    local defaultTarget = target
    if target and self._owner:IsMyControl() then
        --app.log("skill id="..self:GetSkillID())
        if target:GetCanNotAttack() then
            --app.log("1")
            defaultTarget = nil
        else
            --app.log("2")
            local tpos = target:GetPosition(true)
            local dis = algorthm.GetDistance(pos.x, pos.z, tpos.x, tpos.z);
            dis = dis - target:GetRadius()
            if dis > self._skillInfo.distance then
                defaultTarget = nil
            end
        end
    end
    local haveKey = false
    for effectindex, effect in pairs(self._skillData.effect) do
        if effect.targettype == 0 then
            --app.log("buffid="..effect.buffid.." bufflv="..effect.bufflv.." skillid="..self._skillData.id)
            local newBuff = self._owner:AttachBuff(effect.buffid, effect.bufflv, self._owner:GetName(), self._owner:GetName(), nil, SkillEx.SKILL_GID_CREATOR, nil, 0, self._skillData.id, self._skillLevel, defaultTarget, self, effect.key == 1, nil)
            if newBuff and effect.key == 1 then
                haveKey = true
            end
        elseif effect.targettype == 1 then
            if target ~= nil then
                local newBuff = target:AttachBuff(effect.buffid, effect.bufflv, self._owner:GetName(), self._owner:GetName(), nil, SkillEx.SKILL_GID_CREATOR, nil, 0, self._skillData.id, self._skillLevel, defaultTarget, self, effect.key == 1, nil)
                if newBuff and effect.key == 1 then
                    haveKey = true
                end
            end
        end
    end
    if not haveKey then
        self._bIsWorking = false
    end
    SkillEx.SKILL_GID_CREATOR = SkillEx.SKILL_GID_CREATOR+1
    local movex = nil
    local movey = nil
    local movez = nil
    if self._owner:IsCaptain() then
        if self._skillInfo.captain_attack_skate_dis and self._skillInfo.captain_attack_skate_dis > 0 and (not self._owner:IsInPosMove()) then
            local skate = false
            local skate_dir = nil
            if defaultTarget then
                local tpos = defaultTarget:GetPosition(true)
                local dis = algorthm.GetDistance(pos.x, pos.z, tpos.x, tpos.z);
                dis = dis - defaultTarget:GetRadius()

                local except_flag = ConfigManager.Get(EConfigIndex.t_skill_info, self:GetSkillID()).repel_except
                local attack_skate_factor = 0
                if CheckExcept(defaultTarget, except_flag) then
                    attack_skate_factor = SkillManager.attack_skate_factor_except
                else
                    attack_skate_factor = SkillManager.attack_skate_factor
                end
                if dis > self._skillInfo.distance*attack_skate_factor then
                    skate = true
                    local sx = tpos.x - pos.x
                    local sy = 0
                    local sz = tpos.z - pos.z
                    skate_dir = {}
                    skate_dir.x, skate_dir.y, skate_dir.z = util.v3_normalized(sx, sy, sz);
                end
            else
                skate = true
                skate_dir = self._owner:GetForWard()
            end
            if skate then
                local tx = pos.x + skate_dir.x * self._skillInfo.captain_attack_skate_dis
                local tz = pos.z + skate_dir.z * self._skillInfo.captain_attack_skate_dis 
                self._owner:PosMoveToPos(nil, tx, pos.y, tz, self._skillInfo.captain_attack_skate_time, nil, nil, nil, nil, nil, nil, nil)
                
                local ray_cast_y = pos.y

                local bRayRet, hit = util.raycase_out4(tx, 20, tz, 0, -1, 0, 50, PublicFunc.GetBitLShift({PublicStruct.UnityLayer.terrain}));
                if bRayRet then
                    ray_cast_y = hit.y
                    local isSuc, sx, sy, sz = util.get_navmesh_sampleposition(tx, ray_cast_y, tz, 10)
                    if isSuc then
                        ray_cast_y = sy
                    end
                end
                movex = pos.x
                movey = pos.y
                movez = pos.z
                local bRet, nx, ny, nz = self._owner.navMeshAgent:ray_cast(pos.x, pos.y, pos.z, tx, ray_cast_y, tz, self._owner.navMeshAgent:get_area_mask())
                if bRet then
                    movex = nx
                    movey = ny
                    movez = nz
                end
            end
        end
    end
    return movex, movey, movez
end

function SkillEx:Cancel()
    if self._bIsWorking == false then
        return
    end
    --self._bIsWorking = false
    for effectindex, effect in pairs(self._skillData.effect) do
        if effect.targettype == 0 then
            self._owner:DetachBuff(effect.buffid, effect.bufflv, false )
        elseif effect.targettype == 1 then
            if target ~= nil then
                target:DetachBuff(effect.buffid, effect.bufflv, false )
            end
        end
    end
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if self._owner:IsMyControl() or self._owner:IsAIAgent() then
            msg_fight.cg_cancel_skill(self._owner:GetGID(), self._skillData.id)
        end
    end
    self:OnBreak()
end

function SkillEx:IsPassCancelTime()
    return (PublicFunc.QueryCurTime() > self._skillCancelTime)
end

function SkillEx:IsIntelligent()
    return self._bIsIntelligent
end

function SkillEx:SetIntelligent(bValue)
    if not bValue and g_dataCenter.setting:Getintelligence() then
        return
    end
    self._bIsIntelligent = bValue
end

function SkillEx:SetAngle(angle)
    if angle ~= 0 and g_dataCenter.setting:Getintelligence() then
        return
    end
    self._angle = angle
end

function SkillEx:OnBreak()
    self._owner:StopCurSkillAudio()
end

function SkillEx:GetCondition()
    return self._skillData.condition
end

function SkillEx:GetSkillID()
    return self._skillData.id
end

function SkillEx:GetSkillAttentionBuff()
    return self._skillData.attention_buff
end

function SkillEx:GetSkillIcon()
    if self._skillInfo then
         return self._skillInfo.small_icon
    end
    return nil
end

function SkillEx:GetSkillSortType()
    if self._skillInfo then
         return self._skillInfo.sort_type
    end
    return nil
end


--[[endregion]]