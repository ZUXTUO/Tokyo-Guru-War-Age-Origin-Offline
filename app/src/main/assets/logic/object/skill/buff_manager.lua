--[[
region buff_manager.lua
date: 2015-8-3
time: 11:52:44
author: Nation
BUFF管理器
]]
BuffManager = Class(BuffManager)
function BuffManager:Init(fightObj)
	self._fightObj = fightObj
    self._arrbuff = {}
    self._arrThirdTarget = {}
    self._bNextHitCrit = false
    self._bNextHitedMustCrit = false
    self._immuneRefCount = {}
    self._abilityScaleMultiply = {}
    self._abilityScaleAddition = {}
    self._attrFinallyCalcuAdd = {}
    self._abilityAbsolute = {}
    self._bUpdateProperty = false
    self._bRecordDamage = true
    self._nRecordDamage = 0
    self._nChangeAbsoluteMDamage = 0
    self._nScaleMDamageIndex = 0
    self._changeScaleMDamage = {}
    self._backScaleRDamage = nil

    self._nScaleRDamageIndex = 0
    self._changeScaleRDamage = {}

    self._nScaleNormalMDamageIndex = 0
    self._changeScaleNormalMDamage = {}

    self._nAbsoluteNormalMDamageIndex = 0
    self._changeAbsoluteNormalMDamage = {}
    
    self._recordTowards = nil
    self._recordPosition = nil
    self._buffID2AttachWhenUseSkill = 0
    self._buffLv2AttachWhenUseSkill = 0
    self._buffCreator2AttachWhenUseSkill = nil
    self._buff2AttachSkillIDWhenUseSkill = 0
    self._buff2AttachSkillLevelWhenUseSkill = 0

    self._disposableAbsoluteRDamage = 0
    self._disposableAbsoluteMDamage = 0
    self._disposableAbsoluteMNormalDamage = 0
    self._disposableScaleRDamage = 1
    self._disposableScaleMDamage = 1
    -- self._disposableScaleMCritHurt = 1

    self._buffID2AttachWhenGainHP = 0
    self._buffLv2AttachWhenGainHP = 0

    self._damageTransferObj = nil       --伤害转移对象
    self._damageTransferPersent = nil   --伤害转移比例

    self._bRecoverHPFeedback = false    --恢复生命反馈
    self._recoverHPFeedbackScale = 0    --恢复生命反馈比例

    self._bDamageRebound = false --伤害反弹
    self._damageReboundScale = 0 --伤害反弹比例
    self._damageReboundCalcuAbilityName = nil --伤害反弹计算的属性
    self._damageReboundCalcuScale = 0 --伤害反弹的计算缩放

    self._tauntTarget = nil --嘲讽攻击对象
    self._tauntBuffID = 0
    self._tauntBuffLv = 0
    self._bAbsorbDamage = false --吸收伤害
    self._lastAbsorbDamage = 0  --剩余伤害吸收量

    self._bDisposableImmuneSkillDamage = false

    self._bSuckBlood = false
    self._suckBloosPersent = 0
    self._scaleMDamage2SomeStars = nil
    self._invincible = false;   --是否无敌
    self._invincible_except_gid = nil;--无敌不起作用的目标
    self._damageFromSkillCreatorScale = nil; --收到技能释放者伤害时缩放
    self._damageFromSkillCreatorGID = nil; --技能释放者GID
    self._disposableRDamageCrit = nil; --一次性受到伤害必暴

    self._addNormalDamageFromSkillCreator = {};       --受到技能释放者普攻时伤害增加
    self._nAddNormalDamageFromSkillCreatorIndex = 0;

    self._bRecordRecover = false;
    self._nRecordRecover = 0;

    self._changeScaleProMDamage = nil   --一次性对特定职业制造额外伤害缩放值
    self._changeScaleProMType = nil
    self._immortal = false; -- 不死状态

    self._reboundNormalDamageScale = 0
    self._recoverHPScale = {}
    self._changeAbsoluteMNormalDamage = 0           --普攻额外绝对值伤害
    self._immuneFrontDamage = false     --免疫正面伤害
    self._scaleMDamageByTargetHPPersent = nil
    self._scaleMDamageByTargetHPValue = nil
    self._specialEffect = {}
    self._specialEffectCopy = {}
    for k,v in pairs(ESpecialEffectType) do
        self._specialEffect[v] = 0
        self._specialEffectCopy[v] = 0
    end
    self._extraDamagePool = 0
end

function BuffManager:Finalize()
	for k, v in pairs(self._arrbuff) do
		delete(v)
        self._arrbuff[k] = nil
	end
end

function BuffManager:OnTick()
	for k, v in pairs(self._arrbuff) do
		if v._buffState == eBuffState.Detached then
            delete(v)
			self._arrbuff[k] = nil
		else
			v:OnTick()
		end
	end
    if self.kidnaperGID then
        local kidnaper = ObjectManager.GetObjectByGID(self.kidnaperGID)
        if kidnaper and self._fightObj and self.kidnaperType == 0 then
            local pos = kidnaper:GetPosition()
            self._fightObj:SetPosition(pos.x, pos.y, pos.z, true, false)
        end
    end
end

function BuffManager:AttachBuff(buffID, buffLv, skillCreator, buffCreator, nestTimes, skillGid, directCallBack, delay, skillID, skillLevel, defaultTarget, skillFrom, isKey, overlap, actionodds)
    --app.log("jinlaile........")
    if not self._fightObj then
        --app.log("1");
	    return nil
	end
    if self._fightObj:IsDead() then
        --app.log("2   "..tostring(self._fightObj:GetHP()).." "..tostring(self._fightObj:GetState()));
        return nil
    end
    
	local buffBaseData = g_BuffData[buffID]
	if not buffBaseData then
        --app.log("3");
		return nil
	end
	local buffLevelData = g_BuffData[buffID].level[buffLv]
	if not buffLevelData then
        --app.log("4....."..tostring(buffID).."  "..tostring(buffLv));
		return nil
	end
	local bCanAttach = true
    if buffBaseData.buffgroup then
        local buffGroupInfo = g_BuffGroupData[buffBaseData.buffgroup]
        if buffGroupInfo then
            if buffGroupInfo.overlap == eBuffGroupOverlapType.SameIDMutex then
                local earlyBuff = nil
                local same_id_count = 0;
                for k, v in pairs(self._arrbuff) do
                    if v:GetBuffGroupID() == buffBaseData.buffgroup then
                        if earlyBuff == nil then
                            earlyBuff = v
                        else
                            if v:GetAttachTime() < earlyBuff:GetAttachTime() then
                                earlyBuff = v
                            end
                        end
                    end
	            end
                if same_id_count >= buffGroupInfo.limit and earlyBuff then
                    earlyBuff._overlapNum = 0
                    earlyBuff:SetState(eBuffState.Detach)
                end
            elseif buffGroupInfo.overlap == eBuffGroupOverlapType.SameIDIgnore then
                for k, v in pairs(self._arrbuff) do
                    if v:GetBuffGroupID() == buffBaseData.buffgroup then
                        bCanAttach = false
                        break
                    end
	            end
            end
        end
    end
    if buffLevelData.overlap ~= 0 and bCanAttach then
        if buffLevelData.overlap == eBuffOverlapType.Overlap then
	        for k, v in pairs(self._arrbuff) do
                if v:GetBuffID() == buffID and v:GetBuffLv() == buffLv then
                    if overlap then
                        for _i=1, overlap do
                            v:AddOverLap()
                        end
                    else
                        v:AddOverLap()
                    end
                    bCanAttach = false
                    break
                end
	        end
        elseif (buffLevelData.overlap == eBuffOverlapType.SameAllMutex) or (buffLevelData.overlap == eBuffOverlapType.SameIDMutex) then
	        for k, v in pairs(self._arrbuff) do
                if v:GetBuffID() == buffID and ((buffLevelData.overlap == eBuffOverlapType.SameIDMutex) or (v:GetBuffLv() == buffLv)) then
                    v._overlapNum = 0
                    v:SetState(eBuffState.Detach)
                end
	        end
        elseif (buffLevelData.overlap == eBuffOverlapType.SameAllDetach) or (buffLevelData.overlap == eBuffOverlapType.SameIDDetach) then
	        for k, v in pairs(self._arrbuff) do
                if v:GetBuffID() == buffID and ((buffLevelData.overlap == eBuffOverlapType.SameIDDetach) or (v:GetBuffLv() == buffLv)) then
                    v._overlapNum = 0
                    v:SetState(eBuffState.Detach)
                    bCanAttach = false
                end
	        end
        elseif (buffLevelData.overlap == eBuffOverlapType.SameAllIgnore) or (buffLevelData.overlap == eBuffOverlapType.SameIDIgnore) then
            for k, v in pairs(self._arrbuff) do
                if v:GetBuffID() == buffID and ((buffLevelData.overlap == eBuffOverlapType.SameIDIgnore) or (v:GetBuffLv() == buffLv)) then
                    bCanAttach = false
                    break
                end
	        end
        elseif (buffLevelData.overlap == eBuffOverlapType.SameAllResetTime) or (buffLevelData.overlap == eBuffOverlapType.SameIDResetTime) then
            for k, v in pairs(self._arrbuff) do
                if v:GetBuffID() == buffID and ((buffLevelData.overlap == eBuffOverlapType.SameIDResetTime) or (v:GetBuffLv() == buffLv)) then
                    v:ResetTime()
                    bCanAttach = false
                    break
                end
	        end
        end
    end
	
	--处理BUFF覆盖，重叠
   
	if not bCanAttach then
        --app.log("5");
		return nil
	end
    --app.log("6");
	local newBuff = BuffEx:new()
    newBuff.action_odds = actionodds
	newBuff:InitData(buffBaseData, buffLevelData, skillCreator, buffCreator, nestTimes, self._fightObj, skillGid, directCallBack, delay, skillID, skillLevel, defaultTarget, overlap)
	self._arrbuff[newBuff._buffGID] = newBuff
    newBuff._srcSkill = skillFrom
    newBuff._isKey = isKey
	newBuff:SetState(eBuffState.Attached)
	return newBuff
end

function BuffManager:DetachBuff(buffID, buffLv, bImmediately)
    for k, v in pairs(self._arrbuff) do
		if v:GetBuffID() == buffID and v:GetBuffLv() == buffLv then
            if v:GetOverLap() > 1 and bImmediately == false then
                v:DelOverlap()
            else
                --app.log("移除BUFF "..buffID.."-"..buffLv.." frame="..PublicStruct.Cur_Logic_Frame)
                v._overlapNum = 0
			    v:SetState(eBuffState.Detach)
                if bImmediately == true then
                    v._bImmediatelyDetach = true
                end
            end
			--break
		end
	end
end

function BuffManager:DetachAllBuff()
    for k,v in pairs(self._arrbuff) do
        v._bImmediatelyDetach = true;
        v._overlapNum = 0
        v:SetState(eBuffState.Detach);
    end
end

function BuffManager:DetachBuffObject(buff, bImmediately)
    for k, v in pairs(self._arrbuff) do
		if v == buff then
            if v:GetOverLap() > 1 and bImmediately == false then
                v:DelOverlap()
            else
                --app.log("移除BUFF "..buffID.."-"..buffLv.." frame="..PublicStruct.Cur_Logic_Frame)
                v._overlapNum = 0
			    v:SetState(eBuffState.Detach)
                if bImmediately == true then
                    v._bImmediatelyDetach = true
                end
            end
			break
		end
	end
end

function BuffManager:CheckRemove(specialEvent)
    local second_event = nil
    if specialEvent == eBuffPropertyType.RemoveOnMove then
        second_event = eBuffPropertyType.RemovePrepareOnMove
    elseif specialEvent == eBuffPropertyType.RemoveOnSilence then
        second_event = eBuffPropertyType.RemovePrepareOnSilence
    elseif specialEvent == eBuffPropertyType.RemoveOnVertigo then
        second_event = eBuffPropertyType.RemovePrepareOnVertigo
    end
    local detach_tigger_buff = {}
    for k, v in pairs(self._arrbuff) do
        if ((v:Is(specialEvent) == true) or (not v._prepared and second_event and (v:Is(second_event) == true))) and v:IsALive() then
            --[[if specialEvent == eBuffPropertyType.RemoveOnSilence or specialEvent == eBuffPropertyType.RemoveOnVertigo then
                if v._isKey and v._skillCreator == self._fightObj:GetName() then
                    self._fightObj:onAniAttackEnd()
                    self._fightObj.skillForceComplete = true
                end
            end]]
            v._overlapNum = 0
            v:SetState(eBuffState.Detach)
            v._bImmediatelyDetach = true
            if not v.ignore_anim_end then
                self._fightObj:onAniAttackEnd()
                self._fightObj.skillForceComplete = true
            end
            if specialEvent ~= eBuffPropertyType.RemoveOnDead and v._buffLevelData.passive_detach_tigger_buff then
                local buff = {}
                buff.id = v._buffLevelData.passive_detach_tigger_buff.id
                buff.lv = v._buffLevelData.passive_detach_tigger_buff.lv
                buff.skillid = v._skillID
                buff.skilllv = v._skillLevel
                table.insert(detach_tigger_buff, buff)
            end
        end
    end
    if #detach_tigger_buff then
        for i=1, #detach_tigger_buff do
            local buffID = detach_tigger_buff[i].id
            local buffLv = detach_tigger_buff[i].lv
            local skillid = detach_tigger_buff[i].skillid
            local skilllv = detach_tigger_buff[i].skilllv
            self._fightObj:AttachBuff(buffID, buffLv, self._fightObj:GetName(), self._fightObj:GetName(), nil, nil, nil, nil, skillid, skilllv)
        end
        detach_tigger_buff = nil
    end
end

function BuffManager:IsBuffExist(buffID, buffLv)
    for k, v in pairs(self._arrbuff) do
        if v:GetBuffID() == buffID and ((buffLv == 0) or (v:GetBuffLv() == buffLv)) and v:IsALive() then
            --app.log(self._fightObj:GetName().."存在BUFF"..buffID.."-"..buffLv)
            return true
        end
    end
    --app.log(self._fightObj:GetName().."不存在BUFF"..buffID.."-"..buffLv)
    return false
end

function BuffManager:GetBuffOverlap(buffID, buffLv)
    for k, v in pairs(self._arrbuff) do
        if v:GetBuffID() == buffID and ((buffLv == 0) or (v:GetBuffLv() == buffLv)) and v:IsALive() then
            --app.log(self._fightObj:GetName().." 2 "..buffID.."-"..buffLv.." "..v:GetOverLap().."层")
            return v:GetOverLap()
        end
    end
    --app.log(self._fightObj:GetName().." 不存在BUFF"..buffID.."-"..buffLv)
    return 0
end

function BuffManager:GetBuffByGid(gid)
    return self._arrbuff[gid]
end

function BuffManager:GetBuff(buffID, buffLv)
    for k, v in pairs(self._arrbuff) do
        if v:GetBuffID() == buffID and v:GetBuffLv() == buffLv  then
            return v
        end
    end
    --app.log("不存在BUFF"..buffID.."-"..buffLv)
    return nil
end

function BuffManager:SpecialEffect(effect_type, bEffect, real_process, skill_creator, show_text)
    if show_text == nil then
        show_text = true
    end
    if bEffect then
        if self._fightObj:IsDead() then
            return nil
        end
        local creator;
        if skill_creator then
            creator = ObjectManager.GetObjectByName(skill_creator)
        end
        local is_immune = false
        if effect_type == ESpecialEffectType.DingShen and self:IsStateImmune(EImmuneStateType.DingShen) then
            is_immune = true
            if self._fightObj:GetHeadInfoControler():Check(creator) then
                self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ImmuneDingShen)
            end
        elseif effect_type == ESpecialEffectType.XuanYun and self:IsStateImmune(EImmuneStateType.XuanYun) then
            is_immune = true
            if self._fightObj:GetHeadInfoControler():Check(creator) then
                self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ImmuneXuanYun)
            end
        elseif effect_type == ESpecialEffectType.KongJu and self:IsStateImmune(EImmuneStateType.KongJu) then
            is_immune = true
            if self._fightObj:GetHeadInfoControler():Check(creator) then
                self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ImmuneKongJu)
            end
        elseif effect_type == ESpecialEffectType.ChenMo and self:IsStateImmune(EImmuneStateType.ChenMo) then
            is_immune = true
            if self._fightObj:GetHeadInfoControler():Check(creator) then
                self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ImmuneChenMo)
            end
        elseif effect_type == ESpecialEffectType.ZhiMang and self:IsStateImmune(EImmuneStateType.ZhiMang) then
            is_immune = true
        elseif effect_type == ESpecialEffectType.HunLuan and self:IsStateImmune(EImmuneStateType.HunLuan) then
            is_immune = true
        end
        if real_process then
            if is_immune then
                return nil
            end
            self._specialEffect[effect_type] = self._specialEffect[effect_type] + 1
            if effect_type == ESpecialEffectType.DingShen then
                if not self._fightObj:IsInPosMove() then
                    local pos = self._fightObj:GetPosition(true)
                    self._fightObj:SetNavFlag(false, true)
                end
                if show_text and self._fightObj:GetHeadInfoControler():Check(creator) then
                    self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.DingShenChengGong)
                end
            elseif self._specialEffect[effect_type] == 1 and effect_type == ESpecialEffectType.XuanYun then
                self._fightObj:DisenableSkill(bit_merge(eSkillDisenableType.Normal, eSkillDisenableType.AllSkill), true)
                if show_text and self._fightObj:GetHeadInfoControler():Check(creator) then
                    self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.XuanYunChengGong)
                end
            elseif self._specialEffect[effect_type] == 1 and effect_type == ESpecialEffectType.ChenMo then
                self._fightObj:DisenableSkill(eSkillDisenableType.AllSkill, true)
                if show_text and self._fightObj:GetHeadInfoControler():Check(creator) then
                    self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ChenMoChengGong)
                end
            elseif self._specialEffect[effect_type] == 1 and effect_type == ESpecialEffectType.HunLuan then
                self._fightObj:PostEvent("chaos");
            elseif self._specialEffect[effect_type] == 1 and effect_type == ESpecialEffectType.KongJu then
                self._fightObj:DisenableSkill(bit_merge(eSkillDisenableType.Normal, eSkillDisenableType.AllSkill), true)
                self._fightObj:PostEvent("Fear");
                if show_text and self._fightObj:GetHeadInfoControler():Check(creator) then
                    self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.KongJuChengGong)
                end
            end
        else
            if is_immune then
                return nil
            end
            self._specialEffectCopy[effect_type] = self._specialEffectCopy[effect_type] + 1
            if effect_type == ESpecialEffectType.DingShen then
                if self._fightObj:GetHeadInfoControler():Check(creator) then
                    self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.DingShenChengGong)
                end
            elseif effect_type == ESpecialEffectType.XuanYun then
                if self._fightObj:GetHeadInfoControler():Check(creator) then
                    self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.XuanYunChengGong)
                end
            elseif effect_type == ESpecialEffectType.KongJu then
                if self._fightObj:GetHeadInfoControler():Check(creator) then
                    self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.KongJuChengGong)
                end
            elseif effect_type == ESpecialEffectType.ChenMo then
                if self._fightObj:GetHeadInfoControler():Check(creator) then
                    self._fightObj:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ChenMoChengGong)
                end
            end
        end
        
        if effect_type == ESpecialEffectType.XuanYun then
            self:CheckRemove(eBuffPropertyType.RemoveOnVertigo)
            if not self._fightObj:IsMyControl() and not self._fightObj:IsAIAgent() then
                --if self._fightObj:GetState() ~= ESTATE.Run then
                    if self._fightObj:GetState() ~= ESTATE.Stand then
                        self._fightObj:SetState(ESTATE.Stand)
                    else
                        self._fightObj:PlayAnimate(EANI.stand);
                    end
                --end
            else
                if not self._fightObj:IsInPosMove() then
                    local pos = self._fightObj:GetPosition(true)
                    self._fightObj:SetNavFlag(false, true)
                end
                self._fightObj:GetAniCtrler():SetAni(EANI.stand)
            end
        elseif effect_type == ESpecialEffectType.ChenMo then
            self:CheckRemove(eBuffPropertyType.RemoveOnSilence)
        end
        --if real_process then
            return effect_type
        --else
        --    return nil
        --end
    else
        if self._specialEffect[effect_type] and self._specialEffect[effect_type] > 0 then
            self._specialEffect[effect_type] = self._specialEffect[effect_type] - 1
            if self._specialEffect[effect_type] == 0 and real_process and effect_type == ESpecialEffectType.HunLuan then
                self._fightObj:PostEvent("Finishchaos");
            elseif self._specialEffect[effect_type] == 0 and real_process and effect_type == ESpecialEffectType.KongJu then
                self._fightObj:DisenableSkill(bit_merge(eSkillDisenableType.Normal, eSkillDisenableType.AllSkill), false)
                self._fightObj:PostEvent("FinishFear");
            elseif self._specialEffect[effect_type] == 0 and real_process and effect_type == ESpecialEffectType.XuanYun then
                self._fightObj:DisenableSkill(bit_merge(eSkillDisenableType.Normal, eSkillDisenableType.AllSkill), false)
            elseif self._specialEffect[effect_type] == 0 and real_process and effect_type == ESpecialEffectType.ChenMo then
                self._fightObj:DisenableSkill(eSkillDisenableType.AllSkill, false)
            end
        end
        if self._specialEffectCopy[effect_type] and self._specialEffectCopy[effect_type] > 0 then
            self._specialEffectCopy[effect_type] = self._specialEffectCopy[effect_type] - 1
        end
    end
    
end

function BuffManager:IsInSpecialEffect(effect_type)
    if self._specialEffect[effect_type] > 0 or self._specialEffectCopy[effect_type] > 0 then
        return true
    else
        return false
    end
end


function BuffManager:ImmuneState(state, bImmune)
    if bImmune == true then
        if self._immuneRefCount[state] == nil then
            self._immuneRefCount[state] = 0
        end
        self._immuneRefCount[state] = self._immuneRefCount[state]+1
        if state == EImmuneStateType.DingShen then
            self._specialEffect[ESpecialEffectType.DingShen] = 0
        elseif state == EImmuneStateType.XuanYun then
            self._specialEffect[ESpecialEffectType.XuanYun] = 0
        elseif state == EImmuneStateType.KongJu then
            self._specialEffect[ESpecialEffectType.KongJu] = 0
        elseif state == EImmuneStateType.ChaoFeng then
            if self._fightObj:GetBuffManager()._tauntTarget then
                local tauntTarget = ObjectManager.GetObjectByGID(self._fightObj:GetBuffManager()._tauntTarget)
                if tauntTarget then
                    tauntTarget.taunt_list[self._fightObj:GetGID()] = nil
                end
                self._fightObj:GetBuffManager()._tauntTarget = nil
                self._fightObj:PostEvent("FinishBeTaunt")
            end
        elseif state == EImmuneStateType.ChenMo then
            self._specialEffect[ESpecialEffectType.ChenMo] = 0
        elseif state == EImmuneStateType.ZhiMang then
            self._specialEffect[ESpecialEffectType.ZhiMang] = 0
        end
    else
        if self._immuneRefCount[state] ~= nil and self._immuneRefCount[state] > 0 then
            self._immuneRefCount[state] = self._immuneRefCount[state]-1
        end
    end
end

function BuffManager:IsStateImmune(state)
    if self._immuneRefCount[state] ~= nil and self._immuneRefCount[state] > 0 then
        return true
    else
        return false
    end
end

function BuffManager:ScaleAbilityMultiply(type, value, bScale)
    if ENUM.EHeroAttribute[type] == nil then
        app.log("errortype["..type.."]--BuffManager:ScaleAbilityMultiply")
        return false
    end
    if bScale then
        if (type == "move_speed") and (value < 1) and self:IsStateImmune(EImmuneStateType.MoveSpeed) then
            return false
        end
        if self._abilityScaleMultiply[type] == nil then
            self._abilityScaleMultiply[type] = {}
        end
        table.insert(self._abilityScaleMultiply[type], value)
        self._bUpdateProperty = true
        if self._fightObj:IsMyControl() and PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
            local attribute_verify_change_info = {}
            attribute_verify_change_info.gid = self._fightObj:GetGID()
            attribute_verify_change_info.scale_type = 1
            attribute_verify_change_info.ability_type = ENUM.EHeroAttribute[type]-ENUM.min_property_id-1
            attribute_verify_change_info.value = value
            attribute_verify_change_info.change = true
            self._fightObj:InsertAttributeVerifyChangeInfo(attribute_verify_change_info)
        end
    else
        if self._abilityScaleMultiply[type] ~= nil then
            for k,v in pairs(self._abilityScaleMultiply[type]) do
                if v == value then
                    table.remove(self._abilityScaleMultiply[type], k)
                    self._bUpdateProperty = true
                    if self._fightObj:IsMyControl() and PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
                        local attribute_verify_change_info = {}
                        attribute_verify_change_info.gid = self._fightObj:GetGID()
                        attribute_verify_change_info.scale_type = 1
                        attribute_verify_change_info.ability_type = ENUM.EHeroAttribute[type]-ENUM.min_property_id-1
                        attribute_verify_change_info.value = value
                        attribute_verify_change_info.change = false
                        self._fightObj:InsertAttributeVerifyChangeInfo(attribute_verify_change_info)
                    end
                    return true
                end
            end
        end
    end
    return true
end

function BuffManager:ScaleAbilityAddition(type, value, bScale)
    if ENUM.EHeroAttribute[type] == nil then
        app.log("errortype["..type.."]--BuffManager:ScaleAbilityAddition")
        return false
    end
    if bScale then
        if (type == "move_speed") and (value < 1) and self:IsStateImmune(EImmuneStateType.MoveSpeed) then
            return false
        end
        if self._abilityScaleAddition[type] == nil then
            self._abilityScaleAddition[type] = {}
        end
        table.insert(self._abilityScaleAddition[type], value)
        self._bUpdateProperty = true
        if self._fightObj:IsMyControl() and PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
            local attribute_verify_change_info = {}
            attribute_verify_change_info.gid = self._fightObj:GetGID()
            attribute_verify_change_info.scale_type = 2
            attribute_verify_change_info.ability_type = ENUM.EHeroAttribute[type]-ENUM.min_property_id-1
            attribute_verify_change_info.value = value
            attribute_verify_change_info.change = true
            self._fightObj:InsertAttributeVerifyChangeInfo(attribute_verify_change_info)
        end
    else
        if self._abilityScaleAddition[type] ~= nil then
            for k,v in pairs(self._abilityScaleAddition[type]) do
                if v == value then
                    table.remove(self._abilityScaleAddition[type], k)
                    self._bUpdateProperty = true
                    if self._fightObj:IsMyControl() and PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
                        local attribute_verify_change_info = {}
                        attribute_verify_change_info.gid = self._fightObj:GetGID()
                        attribute_verify_change_info.scale_type = 2
                        attribute_verify_change_info.ability_type = ENUM.EHeroAttribute[type]-ENUM.min_property_id-1
                        attribute_verify_change_info.value = value
                        attribute_verify_change_info.change = false
                        self._fightObj:InsertAttributeVerifyChangeInfo(attribute_verify_change_info)
                    end
                    return true
                end
            end
        end
    end
    return true
end

function BuffManager:GetAttrFinallyCalcu(type)
    return self._attrFinallyCalcuAdd[type]
end

function BuffManager:AttrFinallyCalcuAdd(type, value, bScale)
    if bScale then
        if self._attrFinallyCalcuAdd[type] == nil then
            self._attrFinallyCalcuAdd[type] = 0
        end
        self._attrFinallyCalcuAdd[type] = self._attrFinallyCalcuAdd[type] + value
    else
        if self._attrFinallyCalcuAdd[type] ~= nil then
            self._attrFinallyCalcuAdd[type] = self._attrFinallyCalcuAdd[type] - value
        end
    end
    return true
end

function BuffManager:ScaleHPRecover(value, bScale)
    if bScale then
        table.insert(self._recoverHPScale, value)
    else
        for k,v in pairs(self._recoverHPScale) do
            if v == value then
                table.remove(self._recoverHPScale, k)
                return
            end
        end
    end
end

function BuffManager:ChangeAbility(type, value)
    if ENUM.EHeroAttribute[type] == nil then
        app.log("errortype["..type.."]--BuffManager:ScaleAbility")
        return false
    end
    if (type == "move_speed") and (value < 0) and self:IsStateImmune(EImmuneStateType.MoveSpeed) then
        return false
    end
    if self._abilityAbsolute[type] == nil then
        self._abilityAbsolute[type] = 0
    end 
    self._abilityAbsolute[type] = self._abilityAbsolute[type] + value
    self._bUpdateProperty = true
    if self._fightObj:IsMyControl() and PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
        local attribute_verify_change_info = {}
        attribute_verify_change_info.gid = self._fightObj:GetGID()
        attribute_verify_change_info.scale_type = 0
        attribute_verify_change_info.ability_type = ENUM.EHeroAttribute[type]-ENUM.min_property_id-1
        attribute_verify_change_info.value = value
        attribute_verify_change_info.change = true
        self._fightObj:InsertAttributeVerifyChangeInfo(attribute_verify_change_info)
    end
    return true
end
--[[endregion]]