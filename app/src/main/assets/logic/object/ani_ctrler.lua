-- region ani_ctrler.lua
-- Author : kevin
-- Date   : 2015/3/31
-- animation controller.



-- 玩家动作枚举 
EANI = {
    attack01 = 1,
    attack02 = 2,
    attack03 = 3,
    skill01 = 4,
    skill02 = 5,
    skill03 = 6,
    skill04 = 7,
    skill05 = 8,
    skill06 = 9,
    run = 10,
    hit = 11,
    die = 12,
    hit_l = 13,
    hit_r = 14,
    stun = 15,
    up = 16,
    getup = 17,
    down = 18,
    dangling = 19,
    idle = 20,
    showstand = 21,
    show = 22,
    walk = 23,
    stand = 24,
    hit01 = 25,
    hit02 = 26,
    hit03 = 27,
    hit04 = 28,
    hit05 = 29,
    enter01 = 30,
    enter02 = 31,
    enter03 = 32,
    dead = 33,
    skill07 = 34,
    skill08 = 35,
    repel = 36,
    skill10 = 37,
    attack04 = 38,
    attack05 = 39,
    attack06 = 40,
    npcstand = 41,
    skill10 = 42,
    boss_show = 43,
    win = 44,
    lose = 45,
    die01 = 46,
    dead01 = 47,
    die02 = 48,
    dead02 = 49,
    nd_show = 50,
    _min = 1,
    _max = 50,
}

-- 战斗中摄像机效果类型
ECAMERA_EFFECT_TYPE = {
    effect = 1,
    imageFuzzy = 2,
}
--[[
EModelBindPos = {
    head = 1,
    chest = 2,
    root = 3,
    leftHand = 4,
    leftWeapon = 5,
    rightHand = 6,
}
--]]

local AniReEnter = {
    [EANI.hit] = true,
    [EANI.hit_l] = true,
    [EANI.hit_r] = true,
}


local AniGroup = {
    -- [EANI.h_jump_middle] = EANI.jump,
    -- [EANI.h_jump_end] = EANI.jump
}

local AniNoTransition = {
    [EANI.stand] = { EANI.wall_u, EANI.hit, EANI.hit01, EANI.hit02, EANI.hit03, EANI.hit04, EANI.hit05, EANI.hit06, EANI.hit07 },
}

local function IsNormalSkillAnimation(action_id)
    if (action_id >= EANI.attack01 and action_id <= EANI.attack03) or(action_id >= EANI.attack04 and action_id <= EANI.attack06) then
        return true
    end
    return false
end
AniCtrler = Class("AniCtrler")

------begining of local funcion area.
function g_role_ani_event(obj_handler, eventParm)
    -- app.log(string.format(" %s g_role_ani_event call back %s", obj_handler:get_name(), eventParm))
    local obj_name = obj_handler:get_name();
    local scriptObj = ObjectManager.GetObjectByName(obj_name);
    if nil ~= scriptObj then
        local aniCtrler = scriptObj:GetAniCtrler();
        if nil ~= aniCtrler then
            if eventParm ~= "state_idle_finish" then
                app.log_warning("动作还是存在回调" .. eventParm .. " 叫美术取消")
            end
            aniCtrler:onAniCallBack("string", eventParm);
        end
    else
        app.log_warning("ani 动作回调的时候找不到对象:" .. obj_name);
    end
end 


function g_role_effect_collision_event(parm, target)
    local ani_ctler = parm

    if nil == ani_ctler then
        app.log("g_role_effect_collision_event: nil parm")
    else
        if ani_ctler.mRole:GetName() == target:GetName() then
            -- app.log("碰到自己了.............")
            return
        end

        if nil ~= ani_ctler.monEffectCollideTarget then
            ani_ctler._notifyAniEvent(ani_ctler, ani_ctler.monEffectCollideTarget)
        end
    end
end

local function playCameraEffect(effect_cfg, camera, autoReleaseTime)
    if nil == effect_cfg then
        app.log(string.format("ani %s null skill camera effect config %s", obj:get_name()))
        return nil, false
    end

    -- app.log("ani 开始播放摄像机特效：" .. effect_cfg.id);
    local effect_obj = EffectManager.createEffect(effect_cfg.id, autoReleaseTime);
    if nil == effect_obj then
        app.log("ani 无法加载摄像机特效 id:" .. skill_effect.id)
        return nil, false
    end

    local x, y, z = effect_cfg.x, effect_cfg.y, effect_cfg.z
    if x == nil or y == nil or z == nil then
        x, y, z = 0, 0, 0
    end

    x = 0
    y = 0
    z = 7


    effect_obj:set_parent(camera)
    effect_obj:set_local_position(x, y, z)
    effect_obj:set_local_rotation(0, 0, 0)

    return effect_obj, true
end

local function GetAniFSMTrigger(ani, msg)
    if nil == ani then
        app.log('GetAniFSMTrigger : ani is nil. msg:' .. msg)
        return "";
    end

    if ani < EANI._min or ani > EANI._max then
        return ""
    end

    return ConfigManager.Get(EConfigIndex.t_action_list,ani).fsm_trigger
end

local function IsAniReenterable(ani)
    return AniReEnter[ani];
end

-----------end of local function area.

function AniCtrler:AniCtrler(parm)
    self.mRole = parm.obj
    self._lastAnimSpeed = 1
    -- self.mOnAniHitTargetCallBack = parm.onHitTarget
    self.mOnAniAttackEndCallBack = parm.onAttackEnd
    self.mOnAniBeHitedEndCallBack = parm.onBeHitEnd
    self.mOnAniJumpTakeOff = parm.onJumpTakeOff
    self.mOnAniJumpLanding = parm.onJumpLanding
    self.mOnAniJumpLanded = parm.onJumpLanded
    self.mOnAniAtkThrow2wall_releaseTarget = parm.onAtkThrow2wall_releaseTarget
    self.mOnAniAtkThrow2Wall_end = parm.onAtkThrow2Wall_end
    self.mOnAniBeAtkThrow2Wall_end = parm.onBeAtkThrow2Wall_end
    self.monAniAttackCombo = parm.onAniAttackCombo
    self.monEffectCollideTarget = parm.onCollideTarget
    self.replace_anim = { }
    self.effect_whih_anim = {}
    self.isCombo = false;
    self:init();
end


function AniCtrler:init()
    self.mCurtAni = nil --EANI.stand
    self.singleActionEffect = nil

    -- 效果计数器
    self.cameraShakeCounter = 0
    self.cameraEffectCounter = 0
    self.timeScaleCnt = 0
    self.lastCheckFrame = 0
    self.beginTime = 0
end 

function AniCtrler:IsInSkillAnim()
    if self.mCurtAni == EANI.attack01 or self.mCurtAni == EANI.attack02 or self.mCurtAni == EANI.attack03 or self.mCurtAni == EANI.skill01 or 
        self.mCurtAni == EANI.skill02 or self.mCurtAni == EANI.skill03 or self.mCurtAni == EANI.skill04 or self.mCurtAni == EANI.skill05 or 
        self.mCurtAni == EANI.skill06 or self.mCurtAni == EANI.attack04 or self.mCurtAni == EANI.attack05 or self.mCurtAni == EANI.attack06 then
        return true
    else
        return false
    end
end

function AniCtrler:SetTimeScaleCnt(cnt)
    self.timeScaleCnt = cnt
end

function AniCtrler:GetTimeScaleCnt()
    return self.timeScaleCnt or 0
end

function AniCtrler:SetCameraShakeCnt(value)
    self.cameraShakeCounter = value
end

function AniCtrler:GetCameraShakeCnt()
    return self.cameraShakeCounter or 0
end

function AniCtrler:SetCameraEffectCnt(value)
    self.cameraEffectCounter = value
end

function AniCtrler:GetCameraEffectCnt(value)
    return self.cameraEffectCounter or 0
end 

function AniCtrler:ResetXCounter()
    self:SetCameraShakeCnt(0)
    self:SetCameraEffectCnt(0)
    self:SetTimeScaleCnt(0)
end

function AniCtrler:checkAniTransition(from, to)
    local check = AniNoTransition[to]
    if nil == check then
        return false
        -- true or false?
    end

    for k, v in pairs(check) do
        if v == from then
            return false;
        end
    end

    return true;
end
 
-- ANI_DEBUG_FLAG = true
function AniCtrler:_crossFade(ani_id, v)
    --[[if not self.mRole:IsMyControl() then
        app.log("_crossFade ani_id="..ani_id.." "..debug.traceback())
    end]]
    local speed = 1
    local recorver = false
    if IsNormalSkillAnimation(ani_id) then
        local attack_speed = self.mRole:GetPropertyVal(ENUM.EHeroAttribute.attack_speed)
        if attack_speed ~= 0 then
            local _property_ratio = ConfigManager.Get(EConfigIndex.t_property_ratio, 1)
            speed = speed + ((attack_speed>0) and (attack_speed/(attack_speed+_property_ratio.attack_speed_ratio)) or (attack_speed/(_property_ratio.attack_speed_ratio-attack_speed)))
            self._lastAnimSpeed = speed
            self.mRole.object:set_animator_speed("", speed)
        else
            recorver = true
        end
    elseif ani_id == EANI.run then
        local move_speed = self.mRole:GetPropertyVal(ENUM.EHeroAttribute.move_speed)
        if move_speed ~= self.mRole.original_move_speed then
            speed = move_speed/self.mRole.original_move_speed
            self._lastAnimSpeed = speed
            self.mRole.object:set_animator_speed("", speed)
        else
            recorver = true
        end
    else
        recorver = true
    end
    if recorver then
        if self._lastAnimSpeed ~= 1 then
            self.mRole.object:set_animator_speed("", 1)
            self._lastAnimSpeed = 1
        end
    end
    -- local useCrossFade = false;
    local useCrossFade = false;
    local haveAnim = true
    local model_id;
    if self.mRole and self.mRole.config and self.mRole.config.model_id then
        model_id = self.mRole.config.model_id;
        local model_config = ConfigManager.Get(EConfigIndex.t_model_list,self.mRole.config.model_id)
        if model_config.action_invalid and model_config.action_invalid ~= 0 then
            if model_config.action_invalid == 1 or model_config.action_invalid[ani_id] then
                haveAnim = false
            end
        end

    end
    local animName, animIndex = PublicFunc.GetAniFSMName(ani_id,model_id);
    if useCrossFade then
        -- TODO: 融合度配置表？？？
        if haveAnim then
            self:AnimatorCrossFade(animName, v or 0.1, 0, 0);
        end
        if ANI_DEBUG_FLAG then
            app.log("ani " .. self.mRole:GetName() .. " 1播放动作：" .. animName);
        end
    else
        local runName = PublicFunc.GetAniFSMName(EANI.run, model_id);
        local standName = PublicFunc.GetAniFSMName(EANI.stand, model_id);

        -- 站立和跑动时切换时才加融合
        if haveAnim then
            if (animName == runName or animName == standName) and(self.mRole.object:is_animator_name(0, runName) or self.mRole.object:is_animator_name(0, standName)) then
                self:AnimatorCrossFade(animName, 0.2, 0, 0);
            else
                self:AnimatorPlay(animName);
            end
        end
        if self.mRole:IsMyControl() then
            if ani_id == EANI.stand then
                self.mRole:SetExternalArea("wait_idle", true)
                self.mRole:SetExternalArea("idle_time", PublicFunc.QueryCurTime() + 5)
            else
                self.mRole:SetExternalArea("wait_idle", false)
            end
        end
        if ANI_DEBUG_FLAG then
            app.log("ani " .. self.mRole:GetName() .. " 2播放动作：" .. animName);
        end
    end
    self:OnAnimBegin(ani_id, nil, speed, animIndex);
end

function AniCtrler:AnimatorCrossFade(stateName, transitionDuration, layer, normalizedTime)

    if not self.mRole:AnimatorHasState(stateName) then return end

    self.mRole.object:animator_cross_fade(stateName, transitionDuration, layer, normalizedTime);

    self:SetLastPlayAniName(stateName, false)
end

function AniCtrler:AnimatorPlay(stateName)

    if not self.mRole:AnimatorHasState(stateName) then return end

    self.mRole.object:animator_play(stateName);

    self:SetLastPlayAniName(stateName, false)
end

function AniCtrler:AnimatorPlayUseHashName(hashName, layer, normailizedTime)
    self.mRole.object:animator_play_use_hash_name(hashName, layer, normailizedTime)
end

function AniCtrler:AnimationPlay(name)
    self.mRole.object:animated_play(name)

    self:SetLastPlayAniName(name, true)
end

function AniCtrler:SetLastPlayAniName(name, isAnimation)
    self.__lastAniName = name
    self.__lastAniIsAnimation = isAnimation
end

function AniCtrler:PlayLastAni()
    if self.__lastAniName then
        if self.__lastAniIsAnimation then
            self:AnimationPlay(self.__lastAniName)
        else
            if self.animatorStateInfo and self.animatorStateInfo.nameHash then
                self:AnimatorPlayUseHashName(self.animatorStateInfo.nameHash, 0, self.animatorStateInfo.normalizedTime)
            else
                self:AnimatorPlay(self.__lastAniName)
            end
        end
    end
end

function AniCtrler:RecordAnimatorInfo()
    if self.__lastAniName and not self.__lastAniIsAnimation then
        local animatorStateInfo = self.mRole.object:get_animator_state(0)

        self.animatorStateInfo = self.animatorStateInfo or {}

        local lastAniNameHash = asset_game_object.animator_string_to_hash(self.__lastAniName)

        if lastAniNameHash == animatorStateInfo.short_name_hash then
            self.animatorStateInfo.nameHash = animatorStateInfo.short_name_hash
            self.animatorStateInfo.normalizedTime = animatorStateInfo.normalized_time
            --app.log('RecordAnimatorInfo============== ' .. table.tostring(self.animatorStateInfo) )
        else
            self.animatorStateInfo.nameHash = nil
            self.animatorStateInfo.normalizedTime = nil
        end
    end
end

function AniCtrler:CheckMoveSpeed()
    if self.mCurtAni == EANI.run then
        local move_speed = self.mRole:GetPropertyVal(ENUM.EHeroAttribute.move_speed)
        if move_speed ~= self.mRole.original_move_speed then
            local speed = move_speed/self.mRole.original_move_speed
            self._lastAnimSpeed = speed
            self.mRole.object:set_animator_speed("", speed)
        else
            if self._lastAnimSpeed ~= 1 then
                self.mRole.object:set_animator_speed("", 1)
                self._lastAnimSpeed = 1
            end
        end
    end
end

function AniCtrler:SetAniEx(ani_id, eventCfg, cbfunction, cbdata, target, lock, skill_id, src_buff, src_trigger)
    self.src_buff = nil
    self.src_trigger = nil
    if self.lock and ani_id ~= EANI.die and ani_id ~= EANI.dead then
        if eventCfg and eventCfg.frame_event and eventCfg.frame_event ~= 0 then
            for k, v in pairs(eventCfg.frame_event) do
                if v.e == "attack1_end" then
                    self:onAniCallBackStr(v.e, eventCfg.action_id);
                    break
                end
            end
        end
        return
    end
    self.lock = lock
    self:OnAnimChange(ani_id)
    if self.replace_anim[ani_id] then
        local _se = ConfigManager.Get(EConfigIndex.t_skill_effect,self.replace_anim[ani_id])
        self:SetAniEx(_se.action_id, _se)

        self.mCurtAni = ani_id;
        return
    end
    self.mCurtAni = ani_id
    self.eventCfg = eventCfg
    self.src_buff = src_buff
    self.src_trigger = src_trigger
    -- app.log(table.tostring(self.eventCfg))
    self:ResetXCounter()
    self.emmitWait = nil
    self.target = target
    self.mRole.animStartPos = self.mRole:GetPosition(true)
    self.skill_id = skill_id
    local bEmmitEffect = false
    if self.eventCfg then
        -- play effect.
        local skill_effect_cfg = self.eventCfg
        if nil ~= skill_effect_cfg then
            -- local cfg = skill_effect_cfg.attack_effect_seq;
            -- if 0 ~= cfg and nil ~= cfg then
            --    cfg = skill_effect_cfg.attack_effect_seq[1]
            --    playRoleEffect(cfg, self.mRole.object, EffectManager.fightEffectDelTime, "atk");
            -- end

            local emmit_cfg = skill_effect_cfg.emit_effect_seq;
            -- TODO: 临时的
            if nil ~= emmit_cfg and 0 ~= emmit_cfg then
                emmit_cfg = emmit_cfg[1]
                self.emmitWait = { }
                self.emmitWait.cfg = emmit_cfg
                self.emmitWait.paramCfg = self.eventCfg
                if cbdata and (cbdata.type == 2 or cbdata.type == 3) then
                    self.emmitWait.cbfunction = cbfunction
                    self.emmitWait.cbdata = cbdata
                end
                self.emmitWait.effectTarget = target
                bEmmitEffect = true
            end
        end
    end

    if cbfunction ~= nil and cbdata and cbdata.type == 1 then
        self.mOnAniHitTargetCallBack = { func = cbfunction, obj = cbdata }
    else
        self.mOnAniHitTargetCallBack = nil
    end
    self:_crossFade(ani_id)
    --[[if self.mRole:IsMyControl() then
        app.log("动作id="..ani_id.." time="..app.get_time().." key="..eventCfg.key.." "..debug.traceback())
    end]]
end

function AniCtrler:SetAni(ani_id, eventCfg)
    self.src_buff = nil
    self.src_trigger = nil
    --app.log("ani="..ani_id.." lock="..tostring(self.lock))
    if self.lock and ani_id ~= EANI.die and ani_id ~= EANI.dead then
        return
    end
    local model_id;
    if self.mRole and self.mRole.config and self.mRole.config.model_id then
        model_id = self.mRole.config.model_id;
    end
    local aniName = PublicFunc.GetAniFSMName(ani_id, model_id)
    if ANI_DEBUG_FLAG then
        app.log(string.format("ani role:%s, SetAni:%s, curAni:%s %s", self.mRole:GetName() or "nil", aniName, PublicFunc.GetAniFSMName(self.mCurtAni, model_id), debug.traceback()))
    end
    self.emmitWait = nil
    if not IsAniReenterable(ani_id) then
        if ani_id == self.mCurtAni then
            if ANI_DEBUG_FLAG then
                -- if ani_id ~= EANI.stand then
                app.log_warning("ani 当前动作相同 无需设置." .. aniName);
                -- end
            end
            return;
        end
    end

    if self.mCurtAni and AniGroup[ani_id] == self.mCurtAni then
        if ANI_DEBUG_FLAG then
            app.log("ani " .. aniName .. "和" .. PublicFunc.GetAniFSMName(self.mCurtAni, model_id) .. "是同一组动作.");
        end
        return;
    end
    --[[if self.mRole:GetCampFlag() == 2 then
        app.log("name="..self.mRole.name.." animid="..ani_id.." time="..app.get_time().." "..debug.traceback())
    end]]
    self:OnAnimChange(ani_id)
    if self.replace_anim[ani_id] then
        local _se = ConfigManager.Get(EConfigIndex.t_skill_effect,self.replace_anim[ani_id]) 
        self:SetAniEx(_se.action_id, _se) 

        self.mCurtAni = ani_id;
        return
    end
    self.skill_id = nil
    self.eventCfg = eventCfg
    -- 切换动作， 清空效果计数器
    self:ResetXCounter()

    if ani_id == EANI.stand then
        self:_doStand();
    elseif ani_id == EANI.getup then
        self:_doGetUp();
    elseif ani_id == EANI.run then
        self:_doRun();
    elseif ani_id == EANI.hit then
        self:_crossFade(ani_id);
    elseif ani_id == EANI.hit_l then
        self:_crossFade(ani_id);
    elseif ani_id == EANI.hit_r then
        self:_crossFade(ani_id);
        -- self:_doBeHited();
    elseif ani_id == EANI.die then
        self:_doDie();
    elseif ani_id == EANI.dead then
        self:_doDead();
    elseif ani_id == EANI.jump then
        self:_doJump_begin();
    elseif ani_id == EANI.fall then
        self:_doBeAtkThrow2wall()
    elseif ani_id == EANI.buff01 or ani_id == EANI.buff02 or ani_id == EANI.buff03 then
        self:_doBuffAction(ani_id)
    elseif ani_id == EANI.stop then
        self:_doStop();
    else
        self:_crossFade((ani_id));
    end

    self.mCurtAni = ani_id;
end

function AniCtrler:getAni()
    return self.mCurtAni
end

function AniCtrler:ShowSingleActionEffect(action_id)
    if nil ~= self.singleActionEffect then
        self:HideSingleActionEffect();
        -- app.log("ani running effect is not nil");
    end

    self.singleActionEffect = { }
    local action_effect_cfg = self.mRole:GetActionEffectCfg(action_id)
    if nil ~= action_effect_cfg then
        local cfg = action_effect_cfg.attack_effect_seq;
        if cfg ~= 0 and cfg ~= nil then
            for k, v in pairs(cfg) do
                self.singleActionEffect[k] = playRoleEffect(v, self.mRole, nil, "ShowSingleActionEffect:" .. tostring(action_id));
            end
        end
    end
end

function AniCtrler:HideSingleActionEffect()
    if nil ~= self.singleActionEffect then
        for k, v in pairs(self.singleActionEffect) do
            self.singleActionEffect[k]:set_active(false)
            self.singleActionEffect[k] = nil
        end

        self.singleActionEffect = nil
    end
end

function AniCtrler:PlayCameraAnimation(skillAction)
    if nil == skillAction then
        return
    end

    --[[
    for k, v in pairs(skillAction) do
        app.log(string.format("playxxx: k: %s, v:%s", tostring(k), tostring(v)))
    end
    --]]

    if skillAction.camera_animation == 0 then
        return;
    end

    local camAni = ConfigManager.Get(EConfigIndex.t_camera_animation,skillAction.camera_animation)
    local fileName = "assetbundles/prefabs/scenecamera/" .. camAni.file_name .. ".assetbundle"

    if ANI_DEBUG_FLAG then
        app.log(string.format("ani play camera ani: mode:%d, bind:%d, pos:%d", camAni.mode, camAni.bind, camAni.point))
    end

    local bindPosCfg = ConfigManager.Get(EConfigIndex.t_model_bind_pos,camAni.point)
    if bindPosCfg ~= 0 and bindPosCfg ~= nil then
        bindPosCfg = bindPosCfg.bind_pos_name
    end

    local bind_pos = nil
    if nil ~= bindPosCfg then
        bind_pos = self.mRole:GetBindObj(camAni.point)
    end

    CameraManager.playAni(bind_pos, fileName, camAni.mode, camAni.bind, self.mRole.object);
end 


function AniCtrler:_doStand()
    self:HideSingleActionEffect()
    -- end
    -- if self:checkAniTransition(self.mCurtAni, EANI.stand) then
    --     self.mRole.object:set_animator_string_trigger(GetAniFSMTrigger(EANI.stand));
    --     -- self.mRole.object:animator_play(PublicFunc.GetAniFSMName(EANI.stand))
    -- else
    --     self.mRole.object:animator_play(PublicFunc.GetAniFSMName(EANI.stand));
    -- end

    if self.mCurtAni == EANI.stop then
        self:AnimatorCrossFade("stand", 0.5, 0, 0);
    else
        self:_crossFade(EANI.stand);
    end
end

function AniCtrler:_doGetUp()
    self:HideSingleActionEffect()
    self:_crossFade(EANI.getup);
end

function AniCtrler:_skill03()
    self:_crossFade(EANI.skill03);
end

function AniCtrler:_doStop()
    self:HideSingleActionEffect()
    -- end
    if self:checkAniTransition(self.mCurtAni, EANI.stop) then
        self.mRole.object:set_animator_string_trigger(GetAniFSMTrigger(EANI.stop));
        -- self.mRole.object:animator_play(PublicFunc.GetAniFSMName(EANI.stand))
    else
        self:_crossFade(EANI.stop);
    end
end

function AniCtrler:_doRun()
    self:_crossFade((EANI.run));
    -- self:ShowSingleActionEffect(EANI.run);
end 

--[[function AniCtrler:_doBeHited()
    local atk_seq_num = 1
    -- self.mRole:GetAttacker():GetAtkSeqNum()

    local action_id = EANI.hit
    local skill_effect_cfg = self.eventCfg
    if nil ~= skill_effect_cfg then
        -- get hited action id.

        local hited_action_seq = skill_effect_cfg.hited_action_seq;
        if 0 ~= hited_action_seq and nil ~= hited_action_seq then
            local hit_action_cfg = hited_action_seq[atk_seq_num]
            if nil == hit_action_cfg or nil == hit_action_cfg.id then
                action_id = EANI.hit
            else
                action_id = hit_action_cfg.id
                if action_id == EANI.hit_b or action_id == EANI.hit_f then
                    -- TODO:是击退动作
                    -- if not self.mRole:IsBoss() then
                    --     local direct = self.mRole:GetAttacker():GetForWard();
                    --     self.mRole:BeattackRepel(direct, 5, 5, self.mRole:GetName());
                    --     action_id = self.mRole:GetBehitAnim();
                    -- end
                end
            end
        end

        -- play effect
        local cfg = skill_effect_cfg.hited_effect_seq;
        cfg = skill_effect_cfg.hited_effect_seq[atk_seq_num]
        if nil ~= cfg then
            playRoleEffect(cfg, self.mRole, EffectManager.fightEffectDelTime, "beatk");
        else
            app.log(string.format("ani 被击特效播放错误. counter:%d 被击：%s 攻击者:%s %s", atk_seq_num, self.mRole.name, self.mRole.attacker, table.tostring(skill_effect_cfg.hited_effect_seq)));
        end
    end

    local attack = self.mRole:GetAttacker()
    if self.mRole:IsEnemy() and self.mRole.behitFinish and attack and attack:IsThump() then
        self.mRole.behitFinish = false;
        self:_crossFade(EANI.hit);
    end
    -- self.mCurtAni = EANI.hited;
    -- self.mRole.object:HightLightOnce(0.15, 1, 0, 0, 0.05, "_Add_Color");
end ]]

function AniCtrler:_IsBeHitedAction(action)
    if action == EANI.hit or
        (action >= EANI.hit01 and action <= EANI.hit07) or
        action == EANI.hit_f or action == EANI.hit_b then
        return true
    else
        return false
    end
end

function AniCtrler:_ShouldReplaceBeHitedAction(action)
    if (action >= EANI.hit01 and action <= EANI.hit07) then
        return true
    else
        return false
    end
end

function AniCtrler:_replaceAniClip(src, dst)
    self.mRole.object:animator_replace_animation_clip(src, dst);
end

function AniCtrler:_clearAnimationOverride(ani)

end

function AniCtrler:_doAttackThrow2wall()
    self:_crossFade(5)
    -- self.mRole.object:set_animator_string_trigger('t_skill02')
    -- self:_crossFade('t_skill02')

    -- self.mRole:GetAttackTarget():setXZPosBinding(self.mRole.object:get_child_by_name("point_fall"));
    -- self.mRole:GetAttackTarget():setYPosBinding(self.mRole.object:get_child_by_name("point_tail"));
    -- -- local tail = "Root/Bip001/Bip001 Pelvis/Bip001 Spine/Tail_03_001/Tail_03_002/Tail_03_003/Tail_03_004/Point001"
    -- local tail = "point_fall"
    -- self.mRole:GetAttackTarget():setYPosBinding(self.mRole.object:get_child_by_name(tail));
end 

function AniCtrler:_doBeAtkThrow2wall()
    if ANI_DEBUG_FLAG then
        app.log("ani 被帅到墙上")
    end
    self:_crossFade("fall")
end

function AniCtrler:_doDie()
    -- self.mRole.object:set_animator_string_trigger(GetAniFSMTrigger(EANI.die));
    self:_crossFade((EANI.die));

    -- 播放死亡特效 临时屏蔽 因为还没有死亡特效 lyl
    --[[if self.mRole and self.mRole:IsBoss() then
        self.effect_dead1 = EffectManager.createEffect(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_deadEffect1).data, EffectManager.fightEffectDelTime);
        local pos1 = self.mRole:GetBindPosition(2);
        self.effect_dead1:set_local_position(pos1.x, pos1.y, pos1.z);
    end
    self.effect_dead2 = EffectManager.createEffect(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_deadEffect2).data, EffectManager.fightEffectDelTime);
    local pos2 = self.mRole:GetBindPosition(3);
    self.effect_dead2:set_local_position(pos2.x, pos2.y, pos2.z);]]
    -- self.mRole:SetNavFlag(true, false);
    -- local pos = self.mRole:GetPosition()
    -- local isSuc, sx, sy, sz = util.get_navmesh_sampleposition(pos.x, pos.y, pos.z, 10)
    -- if isSuc then
    --     self.mRole:SetPosition(sx, sy, sz, true, false)
    -- end
    -- self.mRole:SetNavFlag(false, true);

    if self.mRole and self.mRole.config and self.mRole.config.dead_effect and type(self.mRole.config.dead_effect) == "table" then
        for k, v in ipairs(self.mRole.config.dead_effect) do
            local cf = ConfigManager.Get(EConfigIndex.t_effect_data, v);
            if cf then
                self.mRole:SetEffect(self.mRole:GetName(), cf, nil, nil, nil, nil, nil, nil, nil, false, nil)
            end
        end
    end
end

-- 直接躺地上，不起来了
function AniCtrler:_doDead()
    self:_crossFade((EANI.dead));

    -- 播放死亡特效 临时屏蔽 因为还没有死亡特效 lyl
    --[[if self.mRole and self.mRole:IsBoss() then
        self.effect_dead1 = EffectManager.createEffect(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_deadEffect1).data, EffectManager.fightEffectDelTime);
        local pos1 = self.mRole:GetBindPosition(2);
        self.effect_dead1:set_local_position(pos1.x, pos1.y, pos1.z);
    end
    self.effect_dead2 = EffectManager.createEffect(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_deadEffect2).data, EffectManager.fightEffectDelTime);
    local pos2 = self.mRole:GetBindPosition(3);
    self.effect_dead2:set_local_position(pos2.x, pos2.y, pos2.z);]]
end

function AniCtrler:_doJump_begin()
    -- self.mRole.object:set_animator_string_trigger(GetAniFSMTrigger(EANI.jump));
    self:_crossFade((EANI.jump));

    -- 播放摄像机动画
    local action_cfg = self.mRole:GetActionEffectCfg(EANI.jump)
    if nil ~= action_cfg then
        self:PlayCameraAnimation(action_cfg);
    end
end
 
function AniCtrler:_doSpecialSkillAction(action_id)
    -- self.mRole.object:set_animator_string_trigger(GetAniFSMTrigger(action_id,"kkk"));
    self:_crossFade((action_id))

    -- play effect.
    local skill_effect_cfg = self.eventCfg
    if skill_effect_cfg then
        local cfg = skill_effect_cfg.attack_effect_seq
        if 0 ~= cfg and nil ~= cfg then
            cfg = skill_effect_cfg.attack_effect_seq[1]
            playRoleEffect(cfg, self.mRole, EffectManager.fightEffectDelTime, tostring(action_id));
        end

        -- --播放音效
        -- local atk_audio_seq = skill_effect_cfg.attack_audio_seq;
        -- if 0 ~= atk_audio_seq and nil ~= atk_audio_seq then
        -- atk_audio_seq = skill_effect_cfg.attack_audio_seq[1] ;
        -- AudioManager.PlayWithObj({id = atk_audio_seq.id, obj = self.mRole.object});
        -- else
        -- app.log_warning(string.format("ani 没有大招音效"))
        -- end
    end
end

function AniCtrler:_doBuffAction(action_id)
    -- self.mRole.object:set_animator_string_trigger(GetAniFSMTrigger(action_id, "bbb"));
    self:_crossFade((action_id));

    -- play effect.
    local skill_effect_cfg = self.eventCfg
    if skill_effect_cfg then
        local cfg = skill_effect_cfg.attack_effect_seq
        if 0 ~= cfg and nil ~= cfg then
            cfg = skill_effect_cfg.attack_effect_seq[1]
            playRoleEffect(cfg, self.mRole, EffectManager.fightEffectDelTime, tostring(action_id));
        end
    end
end


-- 添加摄像机特效（全屏特效一类的）
function AniCtrler:OnCameraEffect()

    -- app.log("ani OnCameraEffect")
    local skill_effect_cfg = self.eventCfg
    if nil == skill_effect_cfg or 0 == skill_effect_cfg.camera_effect_seq or nil == skill_effect_cfg.camera_effect_seq then
        skill_effect_cfg = self.mRole:GetActionEffectCfg(self.mCurtAni);
    end

    if nil ~= skill_effect_cfg and 0 ~= skill_effect_cfg.camera_effect_seq and nil ~= skill_effect_cfg.camera_effect_seq then
        if ANI_DEBUG_FLAG then
            app.log("ani 播放摄像机特效")
        end
        table.tostring(skill_effect_cfg);

        local effect_index = self:GetCameraEffectCnt()
        effect_index = effect_index + 1
        self:SetCameraEffectCnt(effect_index)

        -- TODO: 暂时容错
        if effect_index > #skill_effect_cfg.camera_effect_seq then
            effect_index = 1
        end
        local cfg = skill_effect_cfg.camera_effect_seq[effect_index]

        if nil ~= cfg then
            if cfg.type == ECAMERA_EFFECT_TYPE.effect then
                local camera = asset_game_object.find("fightCamera")
                if nil ~= camera then
                    playCameraEffect(cfg, camera, cameraEffectDelTime)
                end
            elseif cfg.type == ECAMERA_EFFECT_TYPE.imageFuzzy then
                -- TODO:
            end
        else
            app.log(string.format("ani 播放摄像机特效错误. counter:%d", self:GetCameraEffectCnt()));
        end
    end
end

function AniCtrler:OnCameraShake()
    -- do return end
    -- 不是主角攻击不震动
    local curRole = FightManager.GetMyCaptain();
    if curRole == nil or self.mRole == nil then
        return;
    end
    if self.mRole:GetName() ~= curRole:GetName() then
        return;
    end


    if ANI_DEBUG_FLAG then
        app.log("ani OnCameraShake")
    end

    local skill_effect_cfg = self.eventCfg
    if nil ~= skill_effect_cfg and 0 ~= skill_effect_cfg.camera_shake_seq and nil ~= skill_effect_cfg.camera_shake_seq then
        local effect_index = self:GetCameraShakeCnt()
        effect_index = effect_index + 1
        self:SetCameraShakeCnt(effect_index)

        -- TODO: 暂时容错
        if effect_index > #skill_effect_cfg.camera_shake_seq then
            effect_index = 1
        end
        local cfg = skill_effect_cfg.camera_shake_seq[effect_index]
        if nil ~= cfg then
            if cfg.count ~= nil and cfg.x ~= nil and cfg.y ~= nil and cfg.z ~= nil and cfg.dis ~= nil and cfg.speed ~= nil and cfg.decay ~= nil and cfg.multiply ~= nil then
                if self.mRole:GetName() == FightManager.GetMyCaptainName() then
                    CameraManager.shake(
                    {
                        count = cfg.count,
                        x = cfg.x,
                        y = cfg.y,
                        z = cfg.z,
                        dis = cfg.dis,
                        speed = cfg.speed,
                        decay = cfg.decay,
                        multiply = cfg.multiply
                    }
                    )
                end
            else
                app.log(string.format("ani 摄像机抖动参数错误 %d", effect_index))
            end
        else
            app.log("ani 播放摄像机抖动错误. counter:%d", self:GetCameraShakeCnt());
        end
    end


    --[[  摄像机特效暂时没用
    if nil == skill_effect_cfg or 0 == skill_effect_cfg.camera_effect_seq or nil == skill_effect_cfg.camera_effect_seq then
        skill_effect_cfg = self.mRole:GetActionEffectCfg(self.mCurtAni);
    end
    if nil ~= skill_effect_cfg and 0 ~= skill_effect_cfg.camera_shake_seq and nil ~= skill_effect_cfg.camera_shake_seq then
        if ANI_DEBUG_FLAG then
            app.log("ani 开始摄像机抖动")
        end
        table.tostring(skill_effect_cfg);
    end
    ]]
end

function AniCtrler:OnTimeScale()

    local skill_effect_cfg = self.eventCfg
    if nil ~= skill_effect_cfg and 0 ~= skill_effect_cfg.time_scale_seq and nil ~= skill_effect_cfg.time_scale_seq then
        if ANI_DEBUG_FLAG then
            app.log("ani 技能时间变慢回调")
        end

        local index = self:GetTimeScaleCnt()
        index = index + 1
        self:SetTimeScaleCnt(index)

        -- TODO: 暂时容错
        if index > #skill_effect_cfg.time_scale_seq then
            index = 1
        end
        local cfg = skill_effect_cfg.time_scale_seq[index]

        if nil ~= cfg and nil ~= cfg.time_scale then
            local time_scale = cfg.time_scale
            if time_scale <= 0 then
                time_scale = 10
                -- TODO：用于发现错误
            else
                app.log(string.format("ani 时间变慢参数错误,time_scale:%f", cfg.time_scale))
            end

            app.set_time_scale(time_scale)
        else
            app.log(string.format("ani 时间变慢参数nil. counter:%d", self:GetTimeScaleCnt()));
        end
    end
end

function AniCtrler:OnPlayAttackAduio()
    if not self.eventCfg then return end
    local skill_effect_cfg = self.eventCfg
    -- 播放音效
    local attack_audio_seq = skill_effect_cfg.attack_audio_seq;
    if 0 ~= attack_audio_seq and nil ~= attack_audio_seq and nil ~= attack_audio_seq[1] then
        local audio_cfg = attack_audio_seq[1]
        if (audio_cfg.pos ~= nil) then
            --            local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,audio_cfg.pos)
            local bind_pos = self.mRole:GetBindObj(audio_cfg.pos)
            if (bind_pos ~= nil) then
                -- AudioManager.PlayWithObj( { id = audio_cfg.id, obj = bind_pos });
                local id, numAdObj;
                local volScale = AudioManager.GetVolScaleBySceneEntity(self.mRole);
                if self.mRole.showtype == true then
                    if audio_cfg.follow and audio_cfg.follow == 0 then
                        id, numAdObj = AudioManager.Play3dAudio(audio_cfg.id, bind_pos, true, false, nil, nil, nil, nil, 1)
                    else
                        id, numAdObj = AudioManager.Play3dAudio(audio_cfg.id, bind_pos, true, true, nil, nil, nil, nil, 1)
                    end
                elseif self.mRole:GetName() == FightManager.GetMyCaptainName()then
                    if audio_cfg.follow and audio_cfg.follow == 0 then
                        id, numAdObj = AudioManager.Play3dAudio(audio_cfg.id, bind_pos, true, false, nil, nil, nil, nil, volScale)
                    else
                        id, numAdObj = AudioManager.Play3dAudio(audio_cfg.id, bind_pos, true, true, nil, nil, nil, nil, volScale)
                    end
                else
                    if audio_cfg.follow and audio_cfg.follow == 0 then
                        id, numAdObj = AudioManager.Play3dAudio(audio_cfg.id, bind_pos, false, false, nil, nil, nil, nil, volScale)
                    else
                        id, numAdObj = AudioManager.Play3dAudio(audio_cfg.id, bind_pos, false, true, nil, nil, nil, nil, volScale)
                    end
                    -- app.log("非主角audio_cfg.id=="..audio_cfg.id);
                end
                self.mRole:SetCurSkillAudio(id, numAdObj);
            end
        end
    else
        -- app.log_warning(string.format("ani 没有攻击音效"))
    end
end

function AniCtrler:OnPlayRunAudio()
    if FightScene.footstep_effect and FightScene.footstep_effect ~= 0 then      
        self.mRole:SetEffect(self.mRole:GetName(), ConfigManager.Get(EConfigIndex.t_effect_data, FightScene.footstep_effect), nil, nil, nil, nil, nil, nil, nil, false, nil)
    end
    if not self.eventCfg then return end
    local run_audio_seq = self.eventCfg.attack_audio_seq;
    local root = self.mRole:GetBindObj(3)
    if (root ~= nil) then
        -- 只有当前操作的角色才有脚步声
        if self.mRole:GetName() == FightManager.GetMyCaptainName() then
            local volScale = AudioManager.GetVolScaleBySceneEntity(self.mRole);
            if run_audio_seq == nil or run_audio_seq == 0 then
                local sex = self.mRole.config.sex;
                if sex == 1 then
                    -- 男
                    local id = math.random(81100000, 81100004)
                    -- 随机脚步声
                    AudioManager.Play3dAudio(id, root, true, nil, nil, nil, nil, nil, volScale)
                elseif sex == 2 then
                    -- 女
                    local id = math.random(81100000, 81100004)
                    AudioManager.Play3dAudio(id, root, true, nil, nil, nil, nil, nil, volScale)
                else
                    app.log("性别配置不对，不播脚步声,性别id===" .. sex);
                end
            else
                if type(run_audio_seq) == "table" then
                    local length = #run_audio_seq;
                    -- 脚步声有几个，随机取一个
                    local n = math.random(1, length);
                    local id = run_audio_seq[n].id;
                    AudioManager.Play3dAudio(id, root, true, nil, nil, nil, nil, nil, volScale)
                end
            end
        end
    end
end

function AniCtrler:onAniCallBack(parmType, parm)
    if "string" == parmType then
        self:onAniCallBackStr(parm);
    end
end

function AniCtrler:OnAnimChange(ani_id)
    -- app.log("OnAnimChange ani_id="..ani_id)

    if self.mCurtAni and self.effect_whih_anim[self.mCurtAni] then
        for k, v in pairs(self.effect_whih_anim[self.mCurtAni]) do
            EffectManager.deleteEffect(v)
        end
        self.effect_whih_anim[self.mCurtAni] = nil
    end

    if self.eventCfg then
        -- app.log(table.tostring(self.eventCfg))
        --[[if self.eventCfg.action_with_transform ~= 0 and PublicStruct.PVP_MODE == 1 then
            self.mRole:SetExternalArea("recordLastNavEnable", false)
            if self.mRole.navMeshAgent then
                local enable = self.mRole:GetExternalArea("lastNavEnable")
                if enable == nil then
                    if self.lastNavEnable == false then
                        self.mRole:SetNavFlag(false, true)
                    end
                else
                    self.mRole:SetNavFlag(enable, not enable)
                end
            end
        end]]
        if self.eventCfg.frame_event ~= 0 and self.bFinishEvent == false and self.eventCfg.action_id ~= EANI.run then
            for k, v in pairs(self.eventCfg.frame_event) do
                if v.e == "attack_prepared" then
                    if self.src_buff then
                        self.src_buff._prepared = true
                    end
                elseif v.e == "attack1_completed" and self.isCombo then
                    if ani_id == EANI.attack03 or ani_id == EANI.attack02 or ani_id == EANI.attack06 or ani_id == EANI.attack05 then
                        if FightScene.GetFightManager()._className == "PeakShowFightManager" and self.mRole:GetName() == "Monster_1_7" then
                            app.log("巅峰展示 连击过滤掉attack1_end，当前技能"..tostring(self.mRole.last_used_skill))
                        end
                        break
                    end
                elseif v.e == "attack1_end" then
                    if self.lastCheckFrame < v.f then
                        self.lastCheckFrame = v.f
                        if (not self.mRole.skill_use_by_skillChange) then
                            self:onAniCallBackStr(v.e, self.eventCfg.action_id);
                        else
                            if FightScene.GetFightManager()._className == "PeakShowFightManager" and self.mRole:GetName() == "Monster_1_7" then
                                app.log("巅峰展示 skillChange过滤掉attack1_end, ani_id="..tostring(ani_id).." 当前技能"..tostring(self.mRole.last_used_skill).." "..debug.traceback())
                            end
                        end
                    end
                    break
                end
            end
        end
    end
    self.mRole.skill_use_by_skillChange = false
end

function AniCtrler:OnAnimBegin(ani_id, offsetTime, speed)
    -- app.log("OnAnimBegin ani_id="..ani_id)
    if self.eventCfg and ani_id then
        -- play effect.
        local skill_effect_cfg = self.eventCfg
        if nil ~= skill_effect_cfg then
            local cfg = skill_effect_cfg.attack_effect_seq;
            if 0 ~= cfg and nil ~= cfg then
                for k, v in pairs(cfg) do
                    local effectobj, created = playRoleEffect(v, self.mRole, 0, "atk", speed);
                    if created and effectobj and (v.live_anim == 1) then
                        if self.effect_whih_anim[ani_id] == nil then
                            self.effect_whih_anim[ani_id] = {}
                        end
                        table.insert(self.effect_whih_anim[ani_id], effectobj:GetGID())
                    end
                end
                -- if self.mRole:IsMyControl() or self.mRole:IsAIAgent() or EffectManager.activedEffectEntityCnt < EffectManager.maxEffectEntityCnt then
                -- if EffectManager.activedEffectEntityCnt < EffectManager.maxEffectEntityCnt then
                
                -- end
            end
        end
    end
    --[[if ani_id then
        local animName = PublicFunc.GetAniFSMName(ani_id);
        app.log(animName)
        local len = self.mRole.object:get_animated_length(animName)
        app.log(len.tostring())
        self.isLoop = self.mRole.object:animated_is_looping(animName)
        app.log(self.isLoop.tostring())

        self.maxAnimTime = len*1000

        app.log("name="..animName.." isloop="..self.isLoop.tostring().." maxAnimTime="..self.maxAnimTime)
    end]]
    self.beginTime = PublicFunc.QueryCurTime()
    if offsetTime then
        self.beginTime = self.beginTime + offsetTime
    end
    self.lastCheckFrame = 0
    self.bFinishEvent = false
    self.animationSpeed = speed
    self.have_combo = false
    self.frame_event_finish = {}
    if self.eventCfg then
        --[[if self.eventCfg.action_with_transform ~= 0 and PublicStruct.PVP_MODE == 1 then
            if self.mRole.navMeshAgent then
                self.lastNavEnable = self.mRole.navMeshAgent:get_enable()
                if self.lastNavEnable == false then
                    self.mRole:SetNavFlag(true, false)
                end
                self.mRole:SetExternalArea("recordLastNavEnable", true)
            end
        end]]
        if self.eventCfg.frame_event ~= 0 then
            for k, v in pairs(self.eventCfg.frame_event) do
                if v.f == 0 then
                    self.frame_event_finish[tostring(v.f)..tostring(v.e)] = 1
                    self:onAniCallBackStr(v.e, self.eventCfg.action_id)
                elseif v.e == "attack1_completed" then
                    self.have_combo = true
                end
            end
        end
    end
end

function AniCtrler:_notifyAniEvent(cb, parm)
    if nil ~= cb then
        if nil ~= cb.func and nil ~= cb.obj then
            cb.func(cb.obj, parm);
        else
            app.log("ani _notifyAniEvent 参数错误 cb.func" .. tostring(cb.func) .. ", cb.obj:" .. tostring(cb.obj) .. "parm" .. tostring(parm));
        end
    else
        app.log("ani _notifyAniEvent 空值 parm:" .. parm);
    end
end

function AniCtrler:onAniCallBackStr(eventParm, action_id)

    if nil == eventParm then
        -- TODO: kevin 配置问题导致输出太多，暂时屏蔽
        -- app.log_warning("ani nil event callback.")
        return;
    end
    -- 特效控制

    -- app.log(string.format("ani role:%s ani call back: %s", self.mRole:GetName(), eventParm))
    if eventParm == "attack1_hited" then
        -- 特效参与控制的条件
        -- 1、特效控制开关
        -- 2、并且跟自己无关(不是自己控制并且Ai不是自己掌控)
        -- 3、并且不是必须特效
        local isSelfEffect = self.mRole:IsMyControl() or self.mRole:IsAIAgent()
        local effect_gid = -1
        if self.emmitWait ~= nil then
            local effect_pos = self.mRole:GetBindPosition(self.emmitWait.cfg.pos);
            local disscallback = nil
            if self.emmitWait.cbdata and self.emmitWait.cbdata.type == 3 then
                disscallback = self.emmitWait.cbfunction
            end
            local cfg_effect_info = ConfigManager.Get(EConfigIndex.t_all_effect,self.emmitWait.cfg.id)
            local b, n, s, h = true, 0, 0, 0
            if not self.mRole:IsMyControl() and not self.mRole:IsAIAgent() then
                b, n, s, h = EffectManager.checkEffectCount(self.emmitWait.cfg.id)
            end
            if nil ~= self.emmitWait.effectTarget and (not self.emmitWait.effectTarget.finalized) then
                if b then
                    effect_gid = EffectManager.createActionEffect( {
                        cfg = self.emmitWait.paramCfg,
                        type = self.emmitWait.cfg.type,
                        effect_id = self.emmitWait.cfg.id,
                        speed = self.emmitWait.cfg.speed,
                        start_pos = effect_pos,
                        target = self.emmitWait.effectTarget,
                        bind_pos = self.emmitWait.cfg.pos,
                        callback_collision = self.emmitWait.cbfunction,
                        user_data = self.emmitWait.cbdata,
                        callback_dissipate = disscallback,
                        src_obj_name = self.mRole:GetName(),
                        handlehit = true,
                        skill_id = self.skill_id,
                        src_angle = self.emmitWait.paramCfg.angle,
                    } )
                end
            else
                if b then
                    effect_gid = EffectManager.createActionEffect( {
                        cfg = self.emmitWait.paramCfg,
                        type = self.emmitWait.cfg.type,
                        effect_id = self.emmitWait.cfg.id,
                        speed = self.emmitWait.cfg.speed,
                        start_pos = effect_pos,
                        direct = self.mRole:GetForWard(),
                        use_time = 0.4,
                        callback_dissipate = disscallback,
                        user_data = self.emmitWait.cbdata,
                        src_obj_name = self.mRole:GetName(),
                        handlehit = true,
                        skill_id = self.skill_id,
                        src_angle = self.emmitWait.paramCfg.angle,
                    } )
                end
            end
        else
            if self.eventCfg ~= nil and self.target ~= nil then
                EffectManager.HandleHitedEffect(self.mRole.name, self.eventCfg, self.target, self.skill_id)
            end
        end

        if self.mOnAniHitTargetCallBack ~= nil then
            self.mOnAniHitTargetCallBack.func(self.mOnAniHitTargetCallBack.obj, self.target)
            -- self.mOnAniHitTargetCallBack = nil
        end
        if self.have_combo then
            self.mRole:onAniAttackCanCombo()
        end
--        if effect_gid ~= -1 then
--            EffectManager.SetIsSelfEffect(effect_gid, isSelfEffect)
--        end
    elseif eventParm == "attack1_end" then
        self:_notifyAniEvent(self.mOnAniAttackEndCallBack, eventParm)
    elseif eventParm == "hited_end" then
        self:_notifyAniEvent(self.mOnAniBeHitedEndCallBack, eventParm)
    elseif eventParm == "jump_start_end" then
        self:_notifyAniEvent(self.mOnAniJumpTakeOff, eventParm)
    elseif eventParm == "jump_middle_end" then
        self:_notifyAniEvent(self.mOnAniJumpLanding, eventParm)
    elseif eventParm == "jump_end_end" then
        self:_notifyAniEvent(self.mOnAniJumpLanded, eventParm)
    elseif eventParm == "skill02_release_obj" then
        self:_notifyAniEvent(self.mOnAniAtkThrow2wall_releaseTarget, eventParm)
    elseif eventParm == "skill02_end" then
        self:_notifyAniEvent(self.mOnAniAtkThrow2Wall_end, eventParm)
    elseif eventParm == "fall_end" then
        self:_notifyAniEvent(self.mOnAniBeAtkThrow2Wall_end, eventParm)
    elseif eventParm == "camera_effect" then
        self:OnCameraEffect()
    elseif eventParm == "camera_shake" then
        self:OnCameraShake()
    elseif eventParm == "time_scale" then
        self:OnTimeScale()
    elseif eventParm == "attack_aduio" then
        -- app.log("播放攻击音效");
        self:OnPlayAttackAduio();
    elseif eventParm == "run_aduio" then
        self:OnPlayRunAudio();
    elseif eventParm == "attack1_completed" then
        if self.isCombo then
            self:_notifyAniEvent(self.monAniAttackCombo, eventParm)
        end
    elseif eventParm == "skill_change" then
        self.mRole:SetExternalArea("canSkillChange", true)
        self.mRole:SetExternalArea("canSkillChangeByNormal5", false)
        self.mRole:SetExternalArea("canSkillChangeByNormal4", false)
        self.mRole:SetExternalArea("canSkillChangeByNormal3", false)
        self.mRole:SetExternalArea("canSkillChangeByNormal2", false)
        self.mRole:SetExternalArea("canSkillChangeByNormal1", false)
        if self.mCurtAni == EANI.attack03 or self.mCurtAni == EANI.attack06 then
            self.mRole:SetExternalArea("canSkillChangeByNormal3", true)
        elseif self.mCurtAni == EANI.attack02 then
            self.mRole:SetExternalArea("canSkillChangeByNormal2", true)
        elseif self.mCurtAni == EANI.attack01 then
            self.mRole:SetExternalArea("canSkillChangeByNormal1", true)
        elseif self.mCurtAni == EANI.attack04 then
            self.mRole:SetExternalArea("canSkillChangeByNormal4", true)
        elseif self.mCurtAni == EANI.attack05 then
            self.mRole:SetExternalArea("canSkillChangeByNormal5", true)
        end
        if self.mRole._skillAfterCanChange then
            self.mRole.new_attack_state_check = true
            local retState, retDestination, retTarget, retNeedChangeTarget = self.mRole:CheckAttackState()
            if retState == ESTATE.Attack or retState == ESTATE.Run then
                self.mRole:SetExternalArea("skillChange", true)
                self.mRole:GetAniCtrler().lock = false
            end
        else
            if GetMainUI():GetJoystick() and GetMainUI():GetJoystick().touch_move_begin then
                if self.mRole:GetName() == g_dataCenter.fight_info:GetCaptainName() then
                    self.mRole:SetHandleState(EHandleState.Move)
                end
            end
        end
    elseif eventParm == "state_finish" then
    elseif eventParm == "attack_move" then
    elseif eventParm == "state_idle_finish" then
        self:SetAni(EANI.stand)
    elseif eventParm == "attack_prepared" then
        if self.src_buff then
            self.src_buff._prepared = true
        end
        if self.src_trigger then
            self.src_trigger:AddImmuneAllControl()
        end
    else
        app.log_warning("ani unknown event callback. evt="..eventParm)
    end
    -- if FightScene.GetFightManager()._className == "PeakShowFightManager" and self.mRole:GetName() == "Monster_1_7" and (eventParm == "attack1_hited" or eventParm == "attack1_end" or eventParm == "skill_change" or eventParm == "attack1_completed") then
    --     app.log("巅峰展示 动作回调:"..tostring(eventParm).."，当前技能"..tostring(self.mRole.last_used_skill))
    -- end
end 

function AniCtrler:OnTick()
    if self.eventCfg then
        -- if self.eventCfg.action_with_transform ~= 0 and PublicStruct.PVP_MODE == 0 then
        --    self.mRole:SetPosition(self.mRole.animStartPos.x, self.mRole.animStartPos.y, self.mRole.animStartPos.z, true)
        -- end
        if self.eventCfg.frame_event ~= 0 then
            local passTime = PublicFunc.QueryDeltaTime(self.beginTime)
            passTime = passTime * self.animationSpeed
            local curFrame = math.floor(passTime / PublicStruct.MS_Each_Anim_Frame)
            local oldLastFrame = self.lastCheckFrame
            self.lastCheckFrame = curFrame
            if oldLastFrame < curFrame then
                for k, v in pairs(self.eventCfg.frame_event) do
                    if v.f <= curFrame and self.frame_event_finish[tostring(v.f)..tostring(v.e)] == nil then
                        self.frame_event_finish[tostring(v.f)..tostring(v.e)] = 1
                        if v.e == "attack1_end" then
                            if self.effect_whih_anim[self.eventCfg.action_id] then
                                for k, v in pairs(self.effect_whih_anim[self.eventCfg.action_id]) do
                                    EffectManager.deleteEffect(v)
                                end
                            end
                            self.effect_whih_anim[self.eventCfg.action_id] = nil
                            self.bFinishEvent = true
                            self:onAniCallBackStr(v.e, self.eventCfg.action_id)
                            break
                        elseif v.e == "action_restart" then
                            self:OnAnimBegin(nil, nil, 1)
                            break
                        elseif v.e == "attack1_completed" then
                            self:onAniCallBackStr(v.e, self.eventCfg.action_id)
                            break
                        else
                            self:onAniCallBackStr(v.e, self.eventCfg.action_id)
                            break
                        end
                    end
                end
            end
        end
    end
end

function AniCtrler:ReplaceAnimID(old_id, new_id)
    self.replace_anim[old_id] = new_id
end
return AniCtrler; 
-- endregion
