-- region effect_manager.lua
-- Author : kevin
-- Date   : 2015/4/28
-- 此文件由[BabeLua]插件自动生成

Effect = Class("Effect")

----app.log("game start.")

-- local function __getn(t)
--     local cnt = 0;
--     for k, v in pairs(t) do
--         cnt = cnt + 1
--     end
--     return cnt
-- end

-- local function __getns(t)
--     return tostring(__getn(t))
-- end

function playRoleEffect(skill_effect, obj, autoReleaseTime, msg, speed)
    -- by Ewing 特效开关
    speed = speed or 1
    if nil == skill_effect then
        ----app.log(string.format("nfx ani %s null skill effect config %s stack:%s", obj:get_name(), msg, debug.traceback()))
        return nil, false
    end
    -- 特效控制
    local isSelfEffect = obj:IsMyControl() or obj:IsAIAgent()

    if false == isSelfEffect and skill_effect.is_necessary == 0 then
        local b, n, s, h = EffectManager.checkEffectCount(skill_effect.id)
        if not b then
            -- app.log("特效控制 playRoleEffect" .. tostring(skill_effect.id) .. " n:" .. n .. " s:" .. s.." h:"..h)
            return nil, false
        end
    end



    if obj == nil then
        return nil, false
    end
    if autoReleaseTime == 0 then
        local effect_cfg = ConfigManager.Get(EConfigIndex.t_all_effect,skill_effect.id)
        if skill_effect and effect_cfg and effect_cfg.time and effect_cfg.time ~= 0 then
            autoReleaseTime = effect_cfg.time * 0.001
        else
            if skill_effect.live_anim ~= 1 then
                autoReleaseTime = EffectManager.fightEffectDelTime
            else
                autoReleaseTime = nil
            end
        end
    end
    --  ----app.log("nfx ani 开始播放特效：" .. skill_effect.id);

    local effect_obj = EffectManager.createEffect(skill_effect.id, autoReleaseTime, isSelfEffect);
    local bind_pos = nil
    if nil == effect_obj then
        ----app.log("nfx ani 无法加载特效 id:" .. skill_effect.id)
        return nil, false
    end
    effect_obj:SetSpeed(speed)
    --    bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,skill_effect.pos)
    bind_pos = obj:GetBindObj(skill_effect.pos)
    if bind_pos == nil then
        ----app.log(string.format("hfx PlayRoleEffect 无绑定点 角色ID:%s,绑定点:%s", obj:get_name(), tostring(skill_effect.pos)))
        return nil, false
    end
	effect_obj:getNode():set_layer(PublicStruct.UnityLayer.TransparentFx,true);
    effect_obj:set_position(bind_pos:get_position())
    if obj:GetObject() then
        effect_obj:set_rotationq(obj:GetObject():get_rotationq());
    end
    if skill_effect.bind == 1 then
        effect_obj:set_parent(bind_pos)
    else
        effect_obj.is_scene_effect = true
        FightScene.InsertSceneEffect(effect_obj:GetGID())
    end
    -- if skill_effect.id == 1500001 then
    --    local x,y,z = effect_obj:get_position()
    --    ----app.log("nfx x="..x.." y="..y.." z="..z.." name"..obj:get_name())
    -- end

    return effect_obj, true
end

--
-- local effect_gid_counter = 1;
function Effect:Effect(inf)
    self.id = inf.id
    self.placeHolder = nil
    self.effectEntity = nil
    self.GID = inf.gid;
    self.releaseTime = nil
    self.destroyTime = nil
    self.isActive = false;
    self.last_x = nil;
    self.last_y = nil;
    self.last_z = nil;

    self.local_scale = nil;

    self.isSelfEffect = false;

    self.objCallBack = { }
    self.bindfunc = { };
    self.bindfunc["on_trigger_enter"] = Utility.bind_callback(self, Effect.on_trigger_enter);

    self.playSpeed = nil; --
end
--暂时没用
-- function Effect:__cloneEntity(e)
--     if nil == e then
--         ----app.log("nfx __cloneEntity nil obj")
--         return nil
--     end

--     if e.effectEntity == nil then
--         ----app.log("nfx __cloneEntity error..")
--         return false;
--     end

--     if self.effectEntity ~= nil then
--         ----app.log("nfx __cloneEntity. effectEntity is not nil")
--     end

--     self.effectEntity = e.effectEntity:clone();
--     if nil == effectEntity then
--         ----app.log(string.format("nfx __cloneEntity 克隆失败: %d:%d", e:GetID(), e:GetGID()))
--         return false
--     end


--     -- TODO: 避免名字越来越长
--     self.effectEntity:set_name(e.effectEntity:get_name());

--     self.effectEntity:set_parent(EffectManager.sceneEffectObjNode)
--     self.effectEntity:set_position(0, 0, 0);

--     return true;
-- end


function Effect:Destroy(force)

    -- ----app.log("nfx Effect:Destory:"..tostring(self.id).. debug.traceback())

    -- TODO: 暂时都放入池中
    -- if nil == force then
    --     force = true;
    -- end

    if not force then
        EffectManager.deleteEffect(self:GetGID())
        return
    end


    ----app.log(string.format("nfx Effect:Destroy: %d:%d", self:GetID(), self:GetGID()))

    -- if self.placeHolder then
    --     self.placeHolder:set_active(false);
    --     self.placeHolder = nil;
    -- end
    -- if self.effectEntity then
    --     self.effectEntity:set_active(false);
    --     self.effectEntity = nil;
    -- end

    -- for k, v in pairs(self.bindfunc) do
    --     Utility.unbind_callback(self, v)
    -- end
end

function Effect:__Dispose()

    if self.placeHolder then
        self.placeHolder:set_active(false);
        self.placeHolder = nil;
    end
    if self.effectEntity then
        self.effectEntity:set_active(false);
        self.effectEntity = nil;
    end

    for k, v in pairs(self.bindfunc) do
        Utility.unbind_callback(self, v)
    end

    self.bindfunc = nil;
end



function Effect:GetID()
    return self.id
end

function Effect:GetGID()
    return self.GID;
end

function Effect:SetIsSelfEffect(value)
    if nil ~= value then
        self.isSelfEffect = value or false
        local gid = self:GetGID()
        -- app.log("Effect:SetIsSelfEffect:gid :" .. tostring(gid) .. " value" .. tostring(value) .. debug.traceback())
        -- 跟自己不相关才计数
        if false == value then
            local eff_info = EffectManager.GetEffect(gid)
            if eff_info then
                -- 0.其他
                -- 1.主角技能
                -- 2.主角普攻
                -- 3.buff；弹道；
                -- 4.受击；小怪死亡
                local skill_info = ConfigManager.Get(EConfigIndex.t_all_effect,eff_info:GetID())
                if skill_info then
                    if skill_info.is_skill == 0 then
                    elseif skill_info.is_skill == 1 then
                        EffectManager.AddSkillEffectCnt()
                    elseif skill_info.is_skill == 2 then
                        EffectManager.AddNormalSkillEffectCnt()
                    elseif skill_info.is_skill == 3 then
                    elseif skill_info.is_skill == 5 then
                        EffectManager.AddHitedEffectCnt()
                        --                        app.log("EffectManager.AddHitedEffectCnt:"..tostring(EffectManager.GetHitedEffectCnt())..debug.traceback())
                    end
                else
                    app.log("Effect:SetIsSelfEffect 2" .. "  gid:" .. tostring(gid) .. " value:" .. tostring(value) .. "    " .. debug.traceback());
                end
            else
                app.log("Effect:SetIsSelfEffect 3" .. "  gid:" .. tostring(gid) .. " value:" .. tostring(value) .. "    " .. debug.traceback());
            end
        end

    end
end

function Effect:GetIsSelfEffect()
    return self.isSelfEffect
end

function Effect:getNode()
    if self.placeHolder ~= nil then
        return self.placeHolder
    else
        return self.effectEntity
    end
end

function Effect:set_parent(parent, entity)
    
    -- if self == nil then
        ----app.log("nfx kkk:"..debug.traceback())
    -- end
-- 
    -- if self:getNode() == nil then
        ----app.log("nfx sss:"..table.tostring(self).. debug.traceback())
    -- end

    -- if self:getNode().set_parent == nil then
        ----app.log("nfx zz:"..table.tostring(self))
    -- end

    self:getNode():set_parent(parent);
    --通知他下面挂载了一个特效  删除时需要移出来
    --解决bug：当一个怪身上挂有攻击光圈特效时，此时死了却还没有消失，又攻击另外的怪的时候，光圈特效会移动到另外的人身上
    --此时应该去掉原有怪的挂载关系，不然另外的怪身上的光圈会在死的那个怪消失的时候，被移出父节点，位置设置为10000
    if self.parentEntityName ~= nil then
        local obj = ObjectManager.GetObjectByName(self.parentEntityName);
        if obj then
            obj:NoticeMoveMountingEffect(self:GetGID());
        end
        self.parentEntityName = nil;
    end
    if entity then
        self.parentEntityName = entity:GetName();
        entity:NoticeMountingEffect(self:GetGID());
    end
end

function Effect:set_position(x, y, z)
    if x == nil or y == nil or z == nil then
        app.log("Effect:set_position" .. debug.traceback())
        return
    end

    if nil == self:getNode() then
        ----app.log("nfx nil effect "..table.tostring(self) ..debug.traceback())
        return
    end

    self:getNode():set_position(x, y, z)

    -- if nil == self.last_x then
    self.last_x, self.last_y, self.last_z = self:getNode():get_local_position();
    -- end
end

function Effect:get_pid()
	return self:getNode():get_pid();
end 

function Effect:get_position()
    return self:getNode():get_position()
end

function Effect:__raw_set_local_position(x, y, z)
    self:getNode():set_local_position(x, y, z)
end

function Effect:set_local_position(x, y, z)
    -- self:getNode():set_local_position(x, y, z)
    self:__raw_set_local_position(x, y, z)

    -- if nil == self.last_x then
    self.last_x, self.last_y, self.last_z = x, y, z
    -- end
end

function Effect:get_local_position()
    return self:getNode():get_local_position()
end

function Effect:set_local_scale(x, y, z)

    if nil ~= self.placeHolder then
        self.placeHolder:set_local_scale(1, 1, 1)
    end

    if self.effectEntity ~= nil then
        self.effectEntity:set_local_scale(x, y, z)
    else
        self.local_scale = { x = x, y = y, z = z }
    end
end

function Effect:set_local_rotation(x, y, z)
    self:getNode():set_local_rotation(x, y, z)
end

function Effect:set_forward(x, y, z)
    self:getNode():set_forward(x, y, z)
end

function Effect:get_forward()
    return self:getNode():get_forward(x, y, z)
end

function Effect:set_rotationq(x, y, z, w)
    self:getNode():set_rotationq(x, y, z, w)
end

function Effect:get_rotation()
    return self:getNode():get_rotation()
end

function Effect:set_rotation(x, y, z)
    self:getNode():set_rotation(x, y, z)
end

function Effect:set_active(flag)
    -- app.log("effect cnt1:"..EffectManager.activedEffectEntityCnt.. "max cnt:".. EffectManager.maxEffectEntityCnt);


    -- if(time.get_time() % 30 ==0) then

    --  end
    if self:getNode() == nil then
        app.log("effect_node = nil "..debug.traceback())
        return;
    end

    self:getNode():opt_effect_reset_quality();


    if flag then

        if nil ~= self.isSelfEffect and self.isSelfEffect == false then
            local b, n, s, h = EffectManager.checkEffectCount(self.id)

            if not b then
                self.isActive = false;
                self:getNode():set_active(false);
                -- app.log("特效多了 set_active" .. tostring(self.id) .. " n:" .. n .. " s:" .. s.." h:"..h)
                return
            else
            end
        end
        --        if GameSettings.enable_effect_count_control then
        --            if flag ~= self.isActive then
        --                -- if not EffectManager.__checkIsNecessaryEffect(self:GetID()) then
        --                --     -- app.log("check is unnecessary......curt:"..EffectManager.activedEffectEntityCnt.." , max:"..EffectManager.maxEffectEntityCnt)
        --                if EffectManager.activedEffectEntityCnt >= EffectManager.maxEffectEntityCnt then

        --                    self.isActive = false;
        --                    self:getNode():set_active(false);
        --                    app.log("激活特效数量达到最大：" .. EffectManager.maxEffectEntityCnt .. ", 特效" .. self:getNode():get_name() .. "将不会被激活.")
        --                    return
        --                end
        --                -- end

        --                -- app.log("effect cnt2:"..EffectManager.activedEffectEntityCnt);
        --                EffectManager.activedEffectEntityCnt = EffectManager.activedEffectEntityCnt + 1;
        --            end
        --        end

        if not self:getNode():get_active() then
            -- app.log("find a hidden effect obj.")
            self:getNode():set_active(true);
        end

        if nil == self.last_x then
            self.last_x, self.last_y, self.last_z = self:get_local_position()
        end

        self:__raw_set_local_position(self.last_x, self.last_y, self.last_z)
        if nil ~= self.effectEntity then
            self.effectEntity:opt_effect_set_culling_mode(0)
            -- 0: Always, 1: transform only, 2: complately.
            self.effectEntity:opt_replay_effect()            
        end

    else
        if GameSettings.enable_effect_count_control then
            if flag ~= self.isActive then
                EffectManager.activedEffectEntityCnt = EffectManager.activedEffectEntityCnt - 1;
            end
        end

        if nil ~= self.effectEntity then
            self.effectEntity:opt_effect_set_culling_mode(2)
            self.effectEntity:opt_stop_effect()
        end
        self:__raw_set_local_position(99999, -99999, 99999)
        --self:getNode():set_local_scale(1, 1, 1);
    end
    self.isActive = flag;

    -- do return end

    -- if nil ~= self.placeHolder then
    --     if self.placeHolder:get_active() ~= flag then
    --         self.placeHolder:set_active_2(flag)
    --     end
    -- end

    -- if nil ~= self.effectEntity then
    --     if self.effectEntity:get_active() ~= flag then
    --         self.effectEntity:set_active_2(flag)
    --     end
    -- end
end

-- function Effect:__Replay()

--     self.playSpeed = 1.0;
--     if self.isActive then
--         if nil ~= self.effectEntity then
--             self.effectEntity:opt_replay_effect()
--         end
--     else
--         self:set_active(true)
--     end
-- end
 
 
function Effect:set_place_holder(obj)
    if nil == obj then
        ----app.log("nfx nil placeHolder "..debug.traceback())
    end

    self.placeHolder = obj;
end

function Effect:get_place_holder(obj)
    return self.placeHolder;
end


function Effect:setEffectEntity(obj, collision)
    if nil == obj then
        ----app.log("nfx nil effectEntity :"..debug.traceback() )
    end

    self.effectEntity = obj;
    if obj and collision then
        if EffectManager.actionEffectList[self.GID] then
            local data = EffectManager.actionEffectList[self.GID];
            if data.is_register == true then
                obj:set_on_trigger_enter(self.bindfunc["on_trigger_enter"])
            end
        end
    end
end

function Effect:getEffectEntity()
    return self.effectEntity;
end

function Effect:on_trigger_enter(other_obj, cur_obj)
    local name = cur_obj:get_name()
    if self.objCallBack[name] == nil then
        if EffectManager.actionEffectList[self.GID] then
            local data = EffectManager.actionEffectList[self.GID];
            if data.callback_collision then
                self.objCallBack[name] = 1
                if data.callback_obj then
                    data.callback_collision(data.callback_obj, data.user_data, ObjectManager.GetObjectByName(name));
                else
                    data.user_data.direct.x, data.user_data.direct.y, data.user_data.direct.z = cur_obj:get_forward()

                    data.callback_collision(data.user_data, ObjectManager.GetObjectByName(name));
                end
            end
        end
    end
end

function Effect:SetSpeed(speed)
    if speed < 0 or speed == self.playSpeed then
        return;
    end

    self.playSpeed = speed;

    if nil ~= self.effectEntity then
        self.effectEntity:opt_set_effect_play_speed(self.playSpeed)
    end
end

function Effect:__applySettingOnLoadOK()
    if self.playSpeed ~= nil and nil ~= self.effectEntity then
        self.effectEntity:opt_set_effect_play_speed(self.playSpeed)
    end

    if self.local_scale ~= nil and nil ~= self.effectEntity then
        self.effectEntity:set_local_scale(self.local_scale.x, self.local_scale.y, self.local_scale.z);
    end
end

------------------------------------------------------------------------------

EffectManager = {
    checkUpdateTime = 0,

    effect_serno = 1,

    pending_loading_effect_obj = { },
    --[[ all effect object ]]


    -- 所有正在使用的特效列表
    allUsingObjList = { },
    --暂时没用了
    -- allUsingObjIdLookUp = { },

    -- 自动回收检测的特效列表
    autoRecyleCheckObjList = { },

    -- 待用特效对象池 k: id, v: {obj_list}
    standByObjPool = { },

    next_check_release_time = 0,
    next_check_destroy_time = 0,

    place_holder_effect_id = 1,
    placeHolderRes = nil,

    actionEffectList = { },
    transformEffectList = { },

    --standby对象池
    effectPoolRootNode = nil,

    --没有父节点的有效特效集合， 放在一起方便查看
    sceneEffectObjNode = nil,

    -- fightEffectDelTime = 6.0,
    fightEffectDelTime = 1.0,

    cameraEffectDelTime = 6.0,

    actionEffectDelTime = 1.5,

    effectStandByTime = 100000,


    effectQualityCfg =
    {
        [30] = 1000,
        [25] = 100,
        [20] = 50,
        [10] = 20,
    },

    ---------------------------
    has_setup = false;
    -- 特效质量等级
    qualityLevel = 3,
    -- 1:low, 2:middle, 3: high (default)

    -- 最大特效数量（控制非必要特效资源）
    referenceFPS = 60;
    maxEffectEntityCnt = 1000,

    activedEffectEntityCnt = 0,

    -- 技能计数器
    counters =
    {
        normal_cnt = 0,
        skill_cnt = 0,
        hited_cnt = 0,
    }
}
-- region 特效计数
function EffectManager.AddNormalSkillEffectCnt()
    EffectManager.counters.normal_cnt = EffectManager.counters.normal_cnt + 1
    --    app.log("EffectManager.AddNormalSkillEffectCnt:" .. EffectManager.counters.normal_cnt)
end

function EffectManager.MinusNormalSkillEffectCnt()
    if EffectManager.counters.normal_cnt > 0 then
        EffectManager.counters.normal_cnt = EffectManager.counters.normal_cnt - 1
    else
        EffectManager.counters.normal_cnt = 0
    end
    --    app.log("EffectManager.MinusNormalSkillEffectCnt:" .. EffectManager.counters.normal_cnt)
end

function EffectManager.GetNormalSkillEffectCnt()
    return EffectManager.counters.normal_cnt
end

function EffectManager.AddSkillEffectCnt()
    EffectManager.counters.skill_cnt = EffectManager.counters.skill_cnt + 1
    --    app.log("EffectManager.AddSkillEffectCnt:" .. EffectManager.counters.skill_cnt)
end

function EffectManager.MinusSkillEffectCnt()
    if EffectManager.counters.skill_cnt > 0 then
        EffectManager.counters.skill_cnt = EffectManager.counters.skill_cnt - 1
    else
        EffectManager.counters.skill_cnt = 0
    end
    --    app.log("EffectManager.MinusSkillEffectCnt:" .. EffectManager.counters.skill_cnt)
end

function EffectManager.GetSkillEffectCnt()
    return EffectManager.counters.skill_cnt
end


function EffectManager.AddHitedEffectCnt()
    EffectManager.counters.hited_cnt = EffectManager.counters.hited_cnt + 1
end

function EffectManager.MinusHitedEffectCnt()
    if EffectManager.counters.hited_cnt > 0 then
        EffectManager.counters.hited_cnt = EffectManager.counters.hited_cnt - 1
    else
        EffectManager.counters.hited_cnt = 0
    end
--    app.log("EffectManager.MinusHitedEffectCnt:" .. tostring(EffectManager.counters.hited_cnt) .. debug.traceback())
end

function EffectManager.GetHitedEffectCnt()
    return EffectManager.counters.hited_cnt
end

-- endregion
local load_num = 0
local loading_call_back = nil 
function g_on_load_effect_callback(parm, pid, fpath, asset_obj, error_info)

    if loading_call_back then
        loading_call_back(load_num)
    end
    load_num = load_num - 1
    if load_num == 0 then loading_call_back = nil end
    if nil == asset_obj then
        ----app.log("nfx ani 特效加载失败:" .. parm.name);
        return;
    end


    ----app.log("nfx 特效加载成功："..parm.id)

    -- 检查是否需要创建？？
    if parm.create_obj then
        local _effect_inf = EffectManager.pending_loading_effect_obj[parm.id]
        if _effect_inf ~= nil then
            for k, v in pairs(_effect_inf) do
                local eo = v.obj
                ----app.log(string.format("hfx 用资源%d填充特效%d", parm.id, eo:GetGID()))

                if eo:GetID() ~= parm.id then
                    ----app.log(string.format("hfx what fuck...%d, %d", eo:GetID(), parm.id ) )
                end

                local effect_obj = asset_game_object.create(asset_obj)

                
                -- app.log("set layer:" .. effect_obj:get_name())
                if effect_obj:get_layer() < PublicStruct.UnityLayer.ngui then
                    effect_obj:set_layer(PublicStruct.UnityLayer.TransparentFx, true);
                end
                local layer = eo:get_place_holder():get_layer();
				if layer == PublicStruct.UnityLayer.ngui then 
					effect_obj:set_layer(PublicStruct.UnityLayer.ngui,true);
				end 
                local effConfig = ConfigManager.Get(EConfigIndex.t_all_effect,parm.id);
                if effConfig.isBullet == 0 then
                    eo:setEffectEntity(effect_obj, false);
                else
                    eo:setEffectEntity(effect_obj, true);
                end
				--app.log("[][] effect_obj.name = : "..effect_obj:get_name().." | eo:get_place_holder() name = "..);
				if eo:get_place_holder():get_name() == nil then 
					--local effect_obj = asset_game_object.create(EffectManager.placeHolderRes);
					--app.log("[][]eo : "..table.tostring(eo));
					eo.placeHolder = nil;
					eo.effectEntity = effect_obj;
					effect_obj:set_name(eo.ef_name);
					eo:set_active(eo.isActive);
				else 
					effect_obj:set_parent(eo:get_place_holder())
					effect_obj:set_local_position(0, 0, 0)
					effect_obj:set_local_rotation(0, 0, 0)
				end 
				
                if v.release_time ~= nil then
                    v.obj.releaseTime = v.release_time;
                    EffectManager.autoRecyleCheckObjList[v.obj:GetGID()] = v.obj;
                end

                eo:__applySettingOnLoadOK();
                -- TODO: (kevin) 测试一下。。。。如果外部已经释放了的情况
            end

            EffectManager.pending_loading_effect_obj[parm.id] = nil
        else
            ----app.log(string.format("hfx 特效:%d加载完成后， 找不到挂载节点。。。。。", parm.id));
        end
    else
        -- TODO:一般是因为预加载原因
    end
end 

function g_on_load_effect_place_holder_callback(parm, pid, fpath, asset_obj, error_info)
    if nil == asset_obj then
        ----app.log("nfx ani failed to load effect place-holder.:" .. parm.name);
        return;
    end


    EffectManager.placeHolderRes = asset_obj;
    EffectManager.effectPoolRootNode = asset_game_object.create(EffectManager.placeHolderRes);

    EffectManager.effectPoolRootNode:set_position(99999, -99999, 99999)
    EffectManager.effectPoolRootNode:set_parent(nil)
    EffectManager.effectPoolRootNode:set_name("effect_pool_ex")
    asset_game_object.dont_destroy_onload(EffectManager.effectPoolRootNode);

    EffectManager.sceneEffectObjNode = asset_game_object.create(EffectManager.placeHolderRes);
    EffectManager.sceneEffectObjNode:set_position(0,0,0)
    EffectManager.sceneEffectObjNode:set_parent(nil)
    EffectManager.sceneEffectObjNode:set_name("scene_effect")
    -- asset_game_object.dont_destroy_onload(EffectManager.sceneEffectObjNode);


    -- EffectManager.effectPoolRootNode = asset_game_object.find("effect_pool");
    -- EffectManager.effectPoolRootNode:set_active(false);
end 

function EffectManager.__checkIsNecessaryEffect(id)
    local cfg = EffectManager.getConfig(id);
    if nil ~= cfg and nil ~= cfg.is_necessary then
        return Utility.to_bool(cfg.is_necessary)
    else
        app.log_warning("EffectManager.__checkIsNecessaryEffect bad config: " .. id);
    end

    return true;
end

function EffectManager.__GetFPSEffectCnt(fps)
    for k, v in pairs(EffectManager.effectQualityCfg) do
        if fps <= k then
            return k
        end
    end
end

function EffectManager.SetMaxActiveEffectEntityCnt(count)
    EffectManager.maxEffectEntityCnt = count
--    app.log("EffectManager Max Effect Entity count:" .. tostring(count))
end

function EffectManager.Setup()
--    app.log("setup effect quality level..........")

    -- 特效控制开关
    if GameSettings.GetEnableEffectQualityControl() then
        EffectManager.SetEffectQualityLevel(GameSettings.effect_quality_level)
    end

    if GameSettings.enable_effect_count_control then
        if GameSettings.effect_max_count > 0 then
            EffectManager.SetMaxActiveEffectEntityCnt(GameSettings.effect_max_count);
        end
    end
end

function EffectManager.SetEffectQualityLevel(level)
    if level > 3 then
        level = 3
    end

    if level < 1 then
        level = 1
    end

    EffectManager.qualityLevel = level
    util.set_effect_quality_level(level);

    app.log("Effect Quality level:" .. tostring(level))
end

function EffectManager.CheckIfShow(effect_id)
    local cfg = EffectManager.getConfig();
end


function EffectManager.getConfig(id)
    return ConfigManager.Get(EConfigIndex.t_all_effect,id);
end


function EffectManager.LoadPlaceHolderRes()
    if EffectManager.placeHolderRes == nil then
        EffectManager.LoadEffect(EffectManager.place_holder_effect_id, EffectManager.__genSerNo())
    else
        app.log("nfx 重复初始化effectmanager.");
    end
end

function EffectManager.PreLoadEffect(id_list, fun)
    ----app.log("nfx PreLoadEffect 注意");

    load_num = 0
    loading_call_back = fun
    for k, v in pairs(id_list) do
        load_num = load_num + 1
        EffectManager.LoadEffect(v)
    end
end

function EffectManager.LoadEffect(id, create_obj)

    local effect_cfg = ConfigManager.Get(EConfigIndex.t_all_effect,id)
    if effect_cfg == nil then
        ----app.log(string.format("hfx id: %s, reqst_ser_no: %s, callstack: %s", tostring(id), tostring(reqst_ser_no), debug.traceback()))
        return
    end


    local name = effect_cfg.file or ""


    -- local file = "assetbundles/prefabs/fx/prefab/" .. name .. ".assetbundle";
    local file = name

    local call_back = g_on_load_effect_callback;
    if id == EffectManager.place_holder_effect_id then
        call_back = g_on_load_effect_place_holder_callback;
    end

    -- EffectManager.loader:Load(file, call_back, { name = name, id = id, create_obj = create_obj });
    ResourceLoader.LoadAsset(file, { func = call_back, user_data = { name = name, id = id, create_obj = create_obj } }, nil)
end

function EffectManager.__fetchObjectFromPool(id)
    local obj_list = EffectManager.standByObjPool[id]
    if nil == obj_list then
        return nil
    end

    for k, v in pairs(obj_list) do
        obj_list[k] = nil
        return v
    end
end

function EffectManager.__putObjectIntoPool(effect_obj)
    if nil == effect_obj then
        ----app.log("nfx put nil obj into pool")
        return
    end

    ----app.log(string.format("nfx put id:%d, gid:%d into pool.", effect_obj:GetID(), effect_obj:GetGID()))

    local obj_list = EffectManager.standByObjPool[effect_obj:GetID()]
    if nil == obj_list then
        EffectManager.standByObjPool[effect_obj:GetID()] = { }
        obj_list = EffectManager.standByObjPool[effect_obj:GetID()]
    end

    if obj_list[effect_obj:GetGID()] ~= nil then
        ----app.log(string.format("hfx __putObjectIntoPool 重复的特效对象 object id:%d, gid:%d", effect_obj.id, effect_obj.gid))
    end

    obj_list[effect_obj:GetGID()] = effect_obj
    effect_obj:set_parent(EffectManager.effectPoolRootNode)
    effect_obj:set_active(false)
    effect_obj:set_local_scale(1, 1, 1)

    effect_obj.releaseTime = nil
    effect_obj.destroyTime = app.get_time() + EffectManager.effectStandByTime;
    -- secons
end

function EffectManager.__disposeEffect(eo)
    local gid = eo.GID;
    eo:__Dispose();
    if EffectManager.pending_loading_effect_obj[eo.id] then
        for k, v in pairs(EffectManager.pending_loading_effect_obj[eo.id]) do
            if v.obj.GID == gid then
                EffectManager.pending_loading_effect_obj[eo.id][k] = nil;
                break;
            end
        end
    end
end

function EffectManager.__ClearEffectPoolObj()
    for k, v in pairs(EffectManager.standByObjPool) do
        for kk, vv in pairs(v) do
            vv:__Dispose();
            v[kk] = nil
        end
        EffectManager.standByObjPool[k] = nil
    end
end

function EffectManager.__ClearInvalidEffectFromPool(id, effect_obj)
    EffectManager.allUsingObjList[effect_obj:GetGID()] = nil
    local obj_list = EffectManager.standByObjPool[id]
    if nil == obj_list then
        return
    end
    for k, v in pairs(obj_list) do
        if v == effect_obj then
            obj_list[k] = nil
            return
        end
    end
end


function EffectManager.__add2UsingList(obj)

    if nil == obj or nil == obj:GetID() or nil == obj:GetGID() then
        ----app.log(string.format("hfx __add2UsingList 错误的特效对象 :%s, GID：%s, %s", tostring(obj.id), tostring(obj:GetGID()), debug.traceback()))
        return false;
    end
    if nil ~= e then
        ----app.log(string.format("hfx allUsingObjList 重复的特效对象 :%d, GID：%d ,%s", obj.id, obj:GetGID(), debug.traceback()))
    end

    EffectManager.allUsingObjList[obj:GetGID()] = obj
    ----app.log(string.format("nfx 对象:%d:%d放入allUsingObjList", obj:GetID(), obj:GetGID()))

    --暂时没用了
    -- local id_look_up = EffectManager.allUsingObjIdLookUp[obj:GetID()]
    -- if nil == id_look_up then
    --     EffectManager.allUsingObjIdLookUp[obj:GetID()] = { }
    --     id_look_up = EffectManager.allUsingObjIdLookUp[obj:GetID()]
    -- end

    -- e = id_look_up[obj:GetGID()]
    -- if nil ~= e then
    --     ----app.log(string.format("hfx allUsingObjIdLookUp 重复的特效对象 :%d, GID：%d", obj.id, obj:GetGID()))
    -- end
    -- id_look_up[obj:GetGID()] = obj

    -- ----app.log(string.format("hfx End __add2UsingList", obj:GetID(), obj:GetGID()));

    return true;
end

function EffectManager.__removeFromUsingList(obj)
    if nil == obj or nil == obj:GetID() then
        ----app.log(string.format("hfx __removeFromUsingList 错误的特效对象 :%d, GID：%d", tostring(obj.id), tostring(obj:GetGID())))
        return false
    end

    ----app.log(string.format("nfx begin __removeFromUsingList", obj:GetID(), obj:GetGID()));

    local e = EffectManager.allUsingObjList[obj:GetGID()]
    if nil == e then
        ----app.log(string.format("hfx allUsingObjList 特效对象不存在 :%d, GID：%d", obj.id, obj:GetGID()))
    end

    EffectManager.allUsingObjList[obj:GetGID()] = nil
    --暂时没用了
    -- local id_look_up = EffectManager.allUsingObjIdLookUp[obj:GetID()]
    -- if nil == id_look_up then
    --     ----app.log(string.format("hfx allUsingObjIdLookUp 1 特效对象不存在 :%d, GID：%d", obj.id, obj:GetGID()))
    --     return;
    -- end

    -- e = id_look_up[obj:GetGID()]
    -- if nil == e then
    --     ----app.log(string.format("hfx allUsingObjIdLookUp 2 特效对象不存在 :%d, GID：%d", obj.id, obj:GetGID()))
    -- end

    -- id_look_up[obj:GetGID()] = nil

    -- ----app.log(string.format("hfx end __removeFromUsingList", obj:GetID(), obj:GetGID()));

    return true;
end


function EffectManager.__removeFromAutoRecyleList(obj, certain_action)
    if nil == obj or nil == obj:GetID() or nil == obj:GetGID() then
        ----app.log(string.format("hfx __removeFromAutoRecyleList 错误的特效对象 :%d, GID：%d", tostring(obj.id), tostring(obj:GetGID())))
        return false
    end

    ----app.log(string.format("nfx begin __removeFromAutoRecyleList", obj:GetID(), obj:GetGID()));

    local e = EffectManager.autoRecyleCheckObjList[obj:GetGID()]
    if nil == e then
        if certain_action then
            ----app.log(string.format("nfx __removeFromAutoRecyleList 特效对象不存在 :%d, GID：%d", obj.id, obj:GetGID()))
        else
            return
        end
    end

    if nil ~= e and e:GetGID() ~= obj:GetGID() then
        ----app.log(string.format("nfx  __removeFromAutoRecyleList 特效对象GID error. :%d：%d", e:GetGID(), obj:GetGID()))
    end


    EffectManager.autoRecyleCheckObjList[obj:GetGID()] = nil

    ----app.log(string.format("nfx end __removeFromAutoRecyleList", obj:GetID(), obj:GetGID()));
end
--暂时没用
-- function EffectManager.__cloneFromObj(id)
--     local id_look_up = EffectManager.allUsingObjIdLookUp[id]
--     if nil ~= id_look_up then
--         for k, v in pairs(id_look_up) do
--             if v.effectEntity ~= nil then
--                 -- nil则 对象还在加载队列中， 目前只是一个空的placeholder,
--                 local obj = Effect:new( { id = id, gid = EffectManager.__genSerNo() })
--                 if not obj:__cloneEntity(v) then
--                     -- TODO: 特效实体已经被销毁了（比如挂载玩家的特效实体， 但是玩家提前删除了。。。。。这里的就野指针了。。。)
--                     return nil
--                 end

--                 ----app.log(string.format("hfx __cloneFromOjb: %d, %d, new [id: %d, GID:%d]", v:GetID(), v:GetGID(), obj:GetID(), obj:GetGID()))
--                 return obj
--             end

--         end
--     end

--     return nil
-- end

function EffectManager.__genSerNo()
    EffectManager.effect_serno = EffectManager.effect_serno + 1
    return EffectManager.effect_serno;
end

function EffectManager.GetEffect(gid)
    return EffectManager.allUsingObjList[gid]
end

function EffectManager.SetIsSelfEffect(gid, value)
    -- app.log("EffectManager.SetIsSelfEffect:" .. " gid:" .. tostring(gid) .. " value:" .. tostring(value) .. debug.traceback())
    local effect = EffectManager.GetEffect(gid)
    if effect then
        effect:SetIsSelfEffect(value)
        --        if value then
        --            local eff_info = ConfigManager.Get(EConfigIndex.t_all_effect,effect.id)
        --            if eff_info then
        --                -- 0.其他
        --                -- 1.主角技能
        --                -- 2.主角普攻
        --                -- 3.buff；弹道；
        --                -- 4.受击；小怪死亡
        --                local eff_info = ConfigManager.Get(EConfigIndex.t_all_effect,effect.id)
        --                if eff_info.is_skill == 0 then
        --                elseif eff_info.is_skill == 1 then
        --                    EffectManager.AddSkillEffectCnt()
        --                elseif eff_info.is_skill == 2 then
        --                    EffectManager.AddNormalSkillEffectCnt()
        --                elseif eff_info.is_skill == 3 then

        --                end
        --            else
        --                app.log("EffectManager.SetIsSelfEffect 3" .. "  gid:" .. tostring(gid) .. " value:" .. tostring(value))
        --            end
        --        else
        --            app.log("EffectManager.SetIsSelfEffect 2" .. "  gid:" .. tostring(gid) .. " value:" .. tostring(value))
        --        end
    else
        app.log("EffectManager.SetIsSelfEffect 1" .. "  gid:" .. tostring(gid) .. " value:" .. tostring(value))
    end
end

function getn(t)
    local n = 0;
    for k, v in pairs(t) do
        n = n + 1
    end

    return n
end

function EffectManager.createEffect(id, autoRelaseTime, isSelfEffect)

    -- if EffectManager.activedEffectEntityCnt >= EffectManager.maxEffectEntityCnt then
    --   app.log("effect "..debug.traceback())
    -- end
    if not EffectManager.has_setup then
        EffectManager.Setup();
        EffectManager.has_setup = true;
    end
    local cfg_effect = ConfigManager.Get(EConfigIndex.t_all_effect,id)

    -- app.log("createEffect end" .. " n:" .. n .. " s:" .. s.."  h:"..h)
    -- app.log("EffectManager.createEffect：id:" ..tostring(id).." autoRelaseTime:"..tostring(autoRelaseTime).."isSelfEffect:"..tostring(isSelfEffect).." cfg_effect.is_effect:"..tostring(cfg_effect.is_skill).. debug.traceback())
    -- 计数器中，只统计跟自己无关的，否者BUG
    if nil ~= isSelfEffect and false == isSelfEffect then
        local b, n, s, h = EffectManager.checkEffectCount(id)
        if false == b then
--            app.log("特效数量多了。 createEffect" .. " n:" .. n .. " s:" .. s .. "  h:" .. h )
            return nil
        end
    end

    --    -- 0.其他
    --    -- 1.主角技能
    --    -- 2.主角普攻
    --    -- 3.buff；弹道；
    --    -- 4.受击；小怪死亡
    --    local eff_info = ConfigManager.Get(EConfigIndex.t_all_effect,id)
    --    if eff_info.is_skill == 0 then
    --    elseif eff_info.is_skill == 1 then
    --        EffectManager.AddSkillEffectCnt()
    --    elseif eff_info.is_skill == 2 then
    --        EffectManager.AddNormalSkillEffectCnt()
    --    elseif eff_info.is_skill == 3 then

    --    end

    -- app.log(string.format(" all: %d, actived: %d, max:%d", getn(EffectManager.allUsingObjList), EffectManager.activedEffectEntityCnt,
    --     EffectManager.maxEffectEntityCnt));


    -- --策略
    -- 1.从对象池中找
    -- 2.从现有对象克隆 （暂时取消这条，容易出问题）
    -- 3.创建新的

    if true then
        -- app.log("nfx create effect:" .. id)
        local nice_try = EffectManager.__fetchObjectFromPool(id)
        if nice_try ~= nil then
            -- app.log("nfx 从对象池中找到特效:" .. id)

            if nil ~= autoRelaseTime then
                nice_try.releaseTime = app.get_time() + autoRelaseTime
                EffectManager.autoRecyleCheckObjList[nice_try:GetGID()] = nice_try;
            end
        else
            -- 取消这条。
            -- nice_try = EffectManager.__cloneFromObj(id) --TODO: 可能克隆到一个不完整的对象
        end

        if nil ~= nice_try then
            EffectManager.__add2UsingList(nice_try)
            nice_try:set_active(true)
            nice_try:set_parent(EffectManager.sceneEffectObjNode)
            --nice_try:__Replay();
            -- 特效控制

            --重新创建的时候恢复播放速度标志(opt_replay_effect 会恢复内部的速度为1.0)
            if nice_try.playSpeed ~= nil then
                nice_try.playSpeed = 1.0
            end

            nice_try:SetIsSelfEffect(isSelfEffect)
            if nice_try:getNode() and (not nice_try:getNode():is_nil()) then
                nice_try:set_local_rotation(0, 0, 0);
                return nice_try;
            else
                EffectManager.__ClearInvalidEffectFromPool(id, nice_try)
            end
        end
    end

    --------------------------------------------------------------------------------

    -- create new.

    -- fix
    local releaseTime = nil
    if autoRelaseTime == nil then
        releaseTime = nil
    else
        releaseTime = app.get_time() + autoRelaseTime
    end

    local effect_cfg = ConfigManager.Get(EConfigIndex.t_all_effect,id)
    if effect_cfg and effect_cfg.file then
        file_name = effect_cfg.file
    end

    -- TODO: kevin res load test.
    -- local effect_res = ResourceManager.GetRes(file_name);
    local effect_res = ResourceManager.GetResourceObject(file_name);

    local effect_obj = nil
    local effect_wapper = Effect:new( { id = id, gid = EffectManager.__genSerNo() })

    -- TODO: 可能导致提前释放
    effect_wapper.releaseTime = releaseTime;
    -- app.log(string.format("hfx create new effect:id:%d, gid:%d", effect_wapper:GetID(), effect_wapper:GetGID()))
	
    local need_load = false
    if nil == effect_res then
        -- app.log("nfx effect res 还没有加载:" .. id)
        if nil ~= EffectManager.placeHolderRes then
            -- TODO:
            effect_obj = asset_game_object.create(EffectManager.placeHolderRes)
            -- TODO:
            if nil == effect_obj then
                app.log("nfx create node by placeHolderRes failed..... ");
                return nil
            end

            effect_obj:set_parent(EffectManager.sceneEffectObjNode);

            local posx, posy, posz = effect_obj:get_local_position()
            effect_wapper:set_place_holder(effect_obj);

            if effect_wapper:getNode() == nil then
                app.log("nfx fkfkfkfkfkfkkf" .. id)
            end

            -- check is loading?
            local loading_inf = EffectManager.pending_loading_effect_obj[id]
            if nil == loading_inf then
                EffectManager.pending_loading_effect_obj[id] = { }
                need_load = true
            end
            -- TIPS:这句一定要在load之前， 因为可能会遇到loadeffect立刻回调...
            EffectManager.pending_loading_effect_obj[id][#EffectManager.pending_loading_effect_obj[id] + 1] = { obj = effect_wapper, release_time = releaseTime }
			
        else
            ----app.log("nfx 特效没有默认占位节点资源");
            -- return nil; TODO: (kevin) return ?
        end
    else
        effect_obj = asset_game_object.create(effect_res)
        effect_obj:set_parent(EffectManager.sceneEffectObjNode)
        effect_obj:set_local_rotation(0, 0, 0);
		
        local effConfig = ConfigManager.Get(EConfigIndex.t_all_effect,id);
        if effConfig and effConfig.isBullet == 0 then
            effect_wapper:setEffectEntity(effect_obj, false);
        else
            effect_wapper:setEffectEntity(effect_obj, true);
        end
		
        if nil ~= releaseTime then
            effect_wapper.releaseTime = releaseTime
            EffectManager.autoRecyleCheckObjList[effect_wapper:GetGID()] = effect_wapper
        else
            effect_wapper.releaseTime = nil;
        end
    end

    effect_wapper:set_active(true)
    EffectManager.__add2UsingList(effect_wapper)

    local cfg_effect = ConfigManager.Get(EConfigIndex.t_all_effect,id)
    ---------debug inf
    local time = 0;
    local ef_name = string.format("nfx_%d_%d_%d_%s", effect_wapper:GetID(), cfg_effect.is_skill, effect_wapper:GetGID(), tostring(effect_wapper.releaseTime))
	effect_wapper.ef_name = ef_name
    if effect_wapper.placeHolder ~= nil then
        effect_wapper.placeHolder:set_name(ef_name)
    elseif effect_wapper.effectEntity ~= nil then
        effect_wapper.effectEntity:set_name(ef_name)
    else
        ----app.log("nfx set effect name error!");
    end
    -- 特效控制
	--app.log("[][]fileName = "..file_name.." , EffectName = "..ef_name);
    effect_wapper:SetIsSelfEffect(isSelfEffect)
	if need_load then
		EffectManager.LoadEffect(effect_wapper:GetID(), effect_wapper:GetGID())
	end
    return effect_wapper
end


-- 创建一个动作特效
-- data = {
-- 必填数据
-- effect_id = 1,                   特效id
-- speed = 1,                       速度
-- start_pos = {x = 0,y = 0,z=0}    开始位置
-- 以下三选一
-- target = ,                       跟随目标entity
-- bind_pos = 1,                    人物哪个位置
-- 或者
-- direct = {x = 0, y = 0, z = 0},  方向
-- use_time = 10秒,                  使用时间
-- 或者
-- end_pos = {x = 0, y = 0, z = 0}, 终点位置
-- 选填数据
-- is_register = true,              是否注册碰撞
-- callback_obj = entity,            调用对象
-- callback_collision = function,   碰撞回调函数
-- callback_dissipate = function,   消散回调
-- user_data = ??,                  用户数据
-- 私有数据
-- move_game_obj = ,                    特效附着对象
-- }
function EffectManager.createActionEffect(data)
    -- data.effect_id = 600005;
    ------app.log("nfx 创建一个运动特效................."..data.effect_id);

    -- 是否是自己的特效
    local effect_obj = EffectManager.createEffect(data.effect_id);
    if effect_obj == nil then
        ----app.log('动作特效创建失败')
        return nil
    end
    data.move_game_obj = effect_obj;
	effect_obj:getNode():set_layer(PublicStruct.UnityLayer.TransparentFx,true);
    effect_obj:set_position(data.start_pos.x, data.start_pos.y, data.start_pos.z);
    if data.target then
        local pos = data.target:GetBindPosition(data.bind_pos, true);
        if pos.x == nil then
            pos.x = data.target:GetBindPosition(3);
            if pos.x == nil then
                app.log("pos.x2=nil "..debug.traceback())
                return nil
            end
        end
        if data.start_pos.x == nil then
            app.log("data.start_pos.x=nil "..debug.traceback())
            return nil
        end
        pos.x = pos.x - data.start_pos.x;
        pos.y = pos.y - data.start_pos.y;
        pos.z = pos.z - data.start_pos.z;
        local direct_x, direct_y, direct_z = util.v3_normalized(pos.x, pos.y, pos.z);
        effect_obj:set_forward(direct_x, 0, direct_z);
    elseif data.direct then
        effect_obj:set_forward(data.direct.x, 0, data.direct.z);
    elseif data.end_pos then
        local pos = data.end_pos;
        pos.x = pos.x - data.start_pos.x;
        pos.y = pos.y - data.start_pos.y;
        pos.z = pos.z - data.start_pos.z;
        local direct_x, direct_y, direct_z = util.v3_normalized(pos.x, pos.y, pos.z);
        effect_obj:set_forward(direct_x, 0, direct_z);
    else
        app.log_warning("cfg="..tostring(data.cfg).." id="..tostring(data.effect_id))
    end
    if data.type == ENUM.EffectType.Transform then
        data.length = 1
    end
    EffectManager.actionEffectList[effect_obj:GetGID()] = data;
    FightScene.InsertSceneEffect(effect_obj:GetGID())
    return effect_obj:GetGID()
end

function EffectManager.CreateTransformationEffect(data)
    local effect_obj = EffectManager.createEffect(data.effect_id);
    if effect_obj == nil then
        ----app.log('变形特效创建失败')
        return nil
    end
    data.move_game_obj = effect_obj;
    effect_obj:set_position(data.start_pos.x, data.start_pos.y, data.start_pos.z);
    EffectManager.transformEffectList[effect_obj:GetGID()] = data;
    effect_obj.is_scene_effect = true
    FightScene.InsertSceneEffect(effect_obj:GetGID())
    return effect_obj:GetGID()
end

function EffectManager.updateActionEffect(deltaTime)
    for k, v in pairs(EffectManager.actionEffectList) do
        if v.destroy then
            FightScene.DelSceneEffect(v.move_game_obj:GetGID())
            v.move_game_obj:Destroy()
            EffectManager.actionEffectList[k] = nil;
        else
            local data = v;
            data.speed = data.speed or 7;
            if data.target then
                if data.target:GetObject() == nil then
                    if data.user_data then
                        if data.user_data.direct ~= nil then
                            data.user_data.direct.x, data.user_data.direct.y, data.user_data.direct.z = data.move_game_obj:get_forward()
                        end
                        if data.user_data.pos ~= nil then
                            data.user_data.pos.x, data.user_data.pos.y, data.user_data.pos.z = data.move_game_obj:get_position()
                        end
                    end
                    if data.callback_dissipate then
                        if data.callback_obj then
                            data.callback_dissipate(data.callback_obj, data.user_data);
                        else
                            data.callback_dissipate(data.user_data);
                        end
                    end
                    v.destroy = true
                else
                    local tar_pos = data.target:GetBindPosition(3);
                    local cur_pos = { }
                    cur_pos.x, cur_pos.y, cur_pos.z = data.move_game_obj:get_position()
                    -- 求方向并且归一化
                    local direct_x = tar_pos.x - cur_pos.x;
                    local direct_y = 0;
                    local direct_z = tar_pos.z - cur_pos.z;
                    direct_x, direct_y, direct_z = util.v3_normalized(direct_x, direct_y, direct_z);
                    local dis = util.v3_distance(cur_pos.x, 0, cur_pos.z, tar_pos.x, 0, tar_pos.z);
                    if data.type == ENUM.EffectType.Transform then
                        data.move_game_obj:set_forward(direct_x, direct_y, direct_z)
                        if v.return_pos then
                            data.length = dis
                            if data.length < 1 or PublicFunc.QueryDeltaTime(data.begin_return) > 500 then
                                data.length = 0
                                v.destroy = true
                            end 
                        else
                            data.length = data.length + data.speed * deltaTime
                            if data.length > dis-0.5 then
                                if data.user_data then
                                    if data.user_data.direct ~= nil then
                                        data.user_data.direct.x, data.user_data.direct.y, data.user_data.direct.z = data.move_game_obj:get_forward()
                                    end
                                    if data.user_data.pos ~= nil then
                                        data.user_data.pos.x, data.user_data.pos.y, data.user_data.pos.z = data.move_game_obj:get_position()
                                    end
                                end
                                if data.handlehit then
                                    EffectManager.HandleHitedEffect(data.src_obj_name, data.cfg, data.target, data.skill_id)
                                end
                                if data.callback_collision then
                                    if data.callback_obj then
                                        data.callback_collision(data.callback_obj, data.user_data, data.target:GetObject());
                                    else
                                        data.callback_collision(data.user_data, data.target);
                                    end
                                elseif data.callback_dissipate then
                                    if data.callback_obj then
                                        data.callback_dissipate(data.callback_obj, data.user_data);
                                    else
                                        data.callback_dissipate(data.user_data);
                                    end
                                end
                                v.return_pos = true
                                data.begin_return = PublicFunc.QueryCurTime();
                            end
                        end
                        data.move_game_obj:set_local_scale(1, 1, data.length)
                    else
                        local move_dis = data.speed * deltaTime
                        if move_dis > dis then
                            data.move_game_obj:set_position(tar_pos.x, cur_pos.y, tar_pos.z);
                            if data.user_data then
                                if data.user_data.direct ~= nil then
                                    data.user_data.direct.x, data.user_data.direct.y, data.user_data.direct.z = data.move_game_obj:get_forward()
                                end
                                if data.user_data.pos ~= nil then
                                    data.user_data.pos.x, data.user_data.pos.y, data.user_data.pos.z = data.move_game_obj:get_position()
                                end
                            end
                            if data.handlehit then
                                EffectManager.HandleHitedEffect(data.src_obj_name, data.cfg, data.target, data.skill_id)
                            end
                            if data.callback_collision then
                                if data.callback_obj then
                                    data.callback_collision(data.callback_obj, data.user_data, data.target:GetObject());
                                else
                                    data.callback_collision(data.user_data, data.target);
                                end
                            elseif data.callback_dissipate then
                                if data.callback_obj then
                                    data.callback_dissipate(data.callback_obj, data.user_data);
                                else
                                    data.callback_dissipate(data.user_data);
                                end
                            end
                            v.destroy = true
                        else
                            local move_x = direct_x * move_dis;
                            local move_z = direct_z * move_dis;
                            data.move_game_obj:set_position(cur_pos.x + move_x, cur_pos.y, cur_pos.z + move_z);
                        end
                    end
                end
            elseif data.use_time then
                -- 得到移动距离
                local cur_pos = { }
                cur_pos.x, cur_pos.y, cur_pos.z = data.move_game_obj:get_position();
                local move_dis = data.speed * deltaTime;
                local move_x = data.direct.x * move_dis;
                local move_z = data.direct.z * move_dis;
                cur_pos.x = cur_pos.x + move_x
                cur_pos.z = cur_pos.z + move_z
                data.move_game_obj:set_position(cur_pos.x, cur_pos.y, cur_pos.z);
                data.use_time = data.use_time - deltaTime;
                local alive = true
                if data.type == ENUM.EffectType.EmitterCollision then
                    local targets = { }
                    local finaltarget = nil
                    FightScene.SearchAreaTargetEx(true, cur_pos, 1, nil, 360, { PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster }, data.obj, targets, nil, 0, nil, nil, data.obj, false)
                    for i = 1, #targets do
                        local checkok = true
                        if data.collisioninfo.cbuff then
                            for j = 1, #data.collisioninfo.cbuff do
                                local ret = targets[i]:IsBuffExist(data.collisioninfo.cbuff[j].id, data.collisioninfo.cbuff[j].lv)
                                if ret ~= data.collisioninfo.checkret then
                                    checkok = false
                                    break
                                end
                            end
                        end
                        if checkok then
                            finaltarget = targets[i]
                            alive = false
                            break
                        end
                    end
                    if alive == false then
                        if data.handlehit then
                            EffectManager.HandleHitedEffect(data.src_obj_name, data.cfg, finaltarget, data.skill_id)
                        end
                        if data.callback_collision then
                            if data.callback_obj then
                                data.callback_collision(data.callback_obj, data.user_data, finaltarget:GetObject());
                            else
                                data.callback_collision(data.user_data, finaltarget);
                            end
                        elseif data.callback_dissipate then
                            if data.callback_obj then
                                data.callback_dissipate(data.callback_obj, data.user_data);
                            else
                                data.callback_dissipate(data.user_data);
                            end
                        end
                        v.destroy = true
                    end
                end
                if alive and data.use_time < 0 then
                    if data.user_data then
                        if data.user_data.direct ~= nil then
                            data.user_data.direct.x, data.user_data.direct.y, data.user_data.direct.z = data.move_game_obj:get_forward()
                        end
                        if data.user_data.pos ~= nil then
                            data.user_data.pos.x, data.user_data.pos.y, data.user_data.pos.z = data.move_game_obj:get_position()
                        end
                    end
                    if data.callback_dissipate then
                        if data.callback_obj then
                            data.callback_dissipate(data.callback_obj, data.user_data);
                        else
                            data.callback_dissipate(data.user_data);
                        end
                    end
                    v.destroy = true
                end
            else
                local tar_pos = data.end_pos;
                local cur_pos = { }
                cur_pos.x, cur_pos.y, cur_pos.z = data.move_game_obj:get_position();
                -- 求方向并且归一化
                local direct_x = tar_pos.x - cur_pos.x;
                local direct_y = 0;
                local direct_z = tar_pos.z - cur_pos.z;
                direct_x, direct_y, direct_z = util.v3_normalized(direct_x, direct_y, direct_z);
                -- 得到移动距离
                local move_dis = data.speed * deltaTime
                local move_x = direct_x * move_dis;
                local move_z = direct_z * move_dis;

                local dis = util.v3_distance(cur_pos.x, 0, cur_pos.z, tar_pos.x, 0, tar_pos.z);
                if move_dis >= dis then
                    v.destroy = true
                    data.move_game_obj:set_position(tar_pos.x, tar_pos.y, tar_pos.z);
                else
                    data.move_game_obj:set_position(cur_pos.x + move_x, cur_pos.y, cur_pos.z + move_z);
                end
            end
        end
    end
    for k, v in pairs(EffectManager.transformEffectList) do
        local data = v;
        if data.lastLen == nil then
            data.lastLen = 0
        end
        local direct = data.obj:GetForWard()
        local maxLen = data.maxlen
        if data.callback_collision then

            local arrTarget = { }
            data.obj:SearchRectangleTarget(true, data.maxlen, 2, data.obj, arrTarget, 1, direct, 0, false, nil, nil, nil)
            if arrTarget[1] ~= nil then
                local pos = data.obj:GetPosition(true)
                local tPos = arrTarget[1]:GetPosition(true)
                maxLen = math.min(maxLen, algorthm.GetDistance(pos.x, pos.z, tPos.x, tPos.z))
                if data.callbacked == nil and maxLen <= data.lastLen then
                    data.callback_collision(data.user_data, arrTarget[1]);
                    data.callbacked = true
                end
            end

        end

        local passTime = PublicFunc.QueryDeltaTime(data.start_frame)
        local moveLen = data.speed * 0.001 * passTime
        if moveLen > maxLen then
            moveLen = maxLen
        end
        data.lastLen = moveLen
        data.move_game_obj:set_local_scale(1.0, 1.0, moveLen / data.maxlen)
        data.move_game_obj:set_forward(direct.x, direct.y, direct.z)
    end
end


function EffectManager.Start()
    Root.AddUpdate(EffectManager.updateActionEffect);
end
function EffectManager.Destroy()
    Root.DelUpdate(EffectManager.updateActionEffect);
    -- effect_gid_counter = 1;

    for k, v in pairs(EffectManager.actionEffectList) do
        v.move_game_obj:Destroy();
        EffectManager.actionEffectList[k] = nil;
    end
    for k, v in pairs(EffectManager.transformEffectList) do
        v.move_game_obj:Destroy();
        EffectManager.transformEffectList[k] = nil;
    end
end
-- huhu 加一个创建特效的接口
-- id:ConfigManager.Get(EConfigIndex.t_all_effect key,-- id:gd_all_effect key)-- id:gd_all_effect key
-- autoRelaseTime:持续时长，单位秒，填nil表示持续循环播放
-- bind_pos:ConfigManager.Get(EConfigIndex.t_model_bind_pos key,-- bind_pos:gd_model_bind_pos key)-- bind_pos:gd_model_bind_pos key
-- obj:场上unity对象一个
function EffectManager.createEffectWithObj(id, autoRelaseTime, bind_pos, obj,hasParent)
	if nil == hasParent then
		hasParent = true	
	end
	 
    -- ----app.log('特效创建 '..id..' '..tostring(autoRelaseTime))

    local effect = EffectManager.createEffect(id, autoRelaseTime);
    if not effect then
        ----app.log('特效创建失败')
        return nil
    end
    --    bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,bind_pos)
    bind_pos = obj:GetBindObj(bind_pos)
    effect:set_position(bind_pos:get_position())
    effect:set_rotationq(bind_pos:get_rotationq());
	  
	if hasParent then
		effect:set_parent(bind_pos)
    else
        effect.is_scene_effect = true
        FightScene.InsertSceneEffect(effect:GetGID())
	end
    return effect
end

-- isDestroy 直接删除资源不放入缓存池
function EffectManager.deleteEffect(gid, isDestroy)
    ----app.log("nfx delete effect:"..tostring(gid))
    local eo = EffectManager.allUsingObjList[gid]
    if nil == eo then
        ----app.log("nfx 删除特效的时候已经不存在了. GID:"..tostring(gid)..debug.traceback())
        return
    end

    eo:set_active(false);

    -- 计数
    EffectManager.minusEffectCount(gid)
    -- ui特效中有些资源需要即时删除避免报错（战队挑战竞技界面特效）
    if not isDestroy then
        EffectManager.__putObjectIntoPool(eo)
    end
    EffectManager.__removeFromUsingList(eo)
    EffectManager.__removeFromAutoRecyleList(eo)


    EffectManager.actionEffectList[gid] = nil
    EffectManager.transformEffectList[gid] = nil
    --TODO 苟晓辉   此处有内存泄露   特效没有调用__dispose()
    if isDestroy then
        EffectManager.__disposeEffect(eo);
    end


    --- old bak---------------------------------------------------------------

    -- if EffectManager.allUsingObjList[id] ~= nil then
    --     EffectManager.allUsingObjList[id]:Destroy()
    -- end


    -- if EffectManager.actionEffectList[gid] then
    --     EffectManager.actionEffectList[gid] = nil
    -- elseif EffectManager.transformEffectList[gid] then
    --     EffectManager.transformEffectList[gid] = nil
    -- end
end 



function EffectManager.update(deltaTime)
    EffectManager.checkUpdateTime = EffectManager.checkUpdateTime + deltaTime
    if EffectManager.checkUpdateTime < 0.2 then --0.2秒更新一次
        return;
    end
    EffectManager.checkUpdateTime = 0;
    -----------------------------------------------------------------

    EffectManager.checkRelease();
    -- EffectManager.checkDestory();
end

function EffectManager.getEffectCnt()
    return EffectManager.GetNormalSkillEffectCnt(), EffectManager.GetSkillEffectCnt(), EffectManager.GetHitedEffectCnt()
end

function EffectManager.checkEffectCount(id)
    local n, s, h = EffectManager.getEffectCnt()
    local cfg_effect = ConfigManager.Get(EConfigIndex.t_all_effect,id)
    local is_skill = -1
    local b, n, s, h = true, n, s, h
    if not cfg_effect then
        app.log(" EffectManager.checkEffectCount:" .. id .. "  " .. debug.traceback())
    else
        is_skill = cfg_effect.is_skill
        -- 特效数量控制开关（关）或者是必需要的特效直接直接返回
        if not GameSettings.GetEnableEffectCountControl() or cfg_effect.is_necessary == 1 then
           return true, n, s, h
        end
    end

    if cfg_effect then
        if cfg_effect.is_skill == 2 then
            -- 普攻
            b, n, s, h = n <= GameSettings.GetNormalEffectMaxCount(), n, s, h
        elseif cfg_effect.is_skill == 1 then
            -- 技能
            b, n, s, h = s <= GameSettings.GetSkillEffectMaxCount(), n, s, h
        elseif cfg_effect.is_skill == 5 then
            -- 受击
            b, n, s, h = h <= GameSettings.GetHitedEffectMaxCount(), n, s, h
        end
    end

    --    local b1 =(n + s) >= GameSettings.GetEffectMaxCount()
    --    if b1 then
    --        b = false
    --    end
--    app.log("EffectManager.checkEffectCount:" .. tostring(id) .. " is_skill:" .. tostring(is_skill) .. " b:" .. tostring(b) .. " n:" .. n .. " s:" .. s .. " h:" .. h)
    return b, n, s, h
end

function EffectManager.checkRelease(releaseAll)
    local now = app.get_time();

    if EffectManager.next_check_release_time <= now then
        EffectManager.next_check_release_time = now + 0.5
        -- seconds
    else
        if not releaseAll then
            return
        end
    end


    for k, v in pairs(EffectManager.autoRecyleCheckObjList) do
        if releaseAll or now >= v.releaseTime then
            if v.is_scene_effect then
                FightScene.DelSceneEffect(v:GetGID())
                v.is_scene_effect = false
            end
            -- 计数
            EffectManager.minusEffectCount(v:GetGID())
            -- 放入池中
            EffectManager.__putObjectIntoPool(v)

            -- 从记录中清除
            EffectManager.__removeFromUsingList(v)
            EffectManager.__removeFromAutoRecyleList(v, true)
        end
    end
end

function EffectManager.minusEffectCount(gid)
    local eff_info = EffectManager.GetEffect(gid)
    if eff_info and eff_info.isSelfEffect == false then
        local skill_info = ConfigManager.Get(EConfigIndex.t_all_effect,eff_info:GetID())
        if skill_info then
            if skill_info.is_skill == 1 then
                EffectManager.MinusSkillEffectCnt()
            elseif skill_info.is_skill == 2 then
                EffectManager.MinusNormalSkillEffectCnt()
            elseif skill_info.is_skill == 5 then
                EffectManager.MinusHitedEffectCnt()
            end
        else
            app.log("xxxxxxx 1 " .. tostring(gid) .. debug.traceback())
        end
    end
end



function EffectManager.checkDestory()

    do return end;
    --[[
    local now = app.get_time();
    if EffectManager.next_check_destroy_time <= now then
        EffectManager.next_check_destroy_time = now + 0.5
        -- seconds
    else
        return
    end

-----------------------------------------------------------------
    local cnt = 0
    for k, v in pairs(EffectManager.standByObjPool) do
        cnt = cnt + __getn(v)
    end

    if cnt == 0 then
        return

    end
    ----app.log("nfx 清理前 池中对象数量:"..cnt)
----------------------------------------------------------------


    for k, v in pairs(EffectManager.standByObjPool) do
        for kk, vv in pairs(v) do
            local e = v[kk]
            -- ----app.log(string.format("nfx destroy obj %d:%d, time[now, destoryTime]:%f,%f", e:GetID(), e:GetGID(), now, tostring(e.destroyTime)));
             if e.destroyTime <= now then
                --TODO: 对象需要destroy不？
                ----app.log(string.format("nfx destroy obj %d:%d, time[now, destoryTime]:%f,%f", e:GetID(), e:GetGID(), now, tostring(e.destroyTime)));
                ----app.log(string.format("nfx checkDestory: %d:%d", e:GetID(), e:GetGID()))

                e:Destroy(true)


                v[kk]= nil
            end
        end
    end

    ---------------------------------------------------------------------
    cnt = 0
    for k, v in pairs(EffectManager.standByObjPool) do
        cnt = cnt + __getn(v)
    end

    ----app.log("nfx 清理后 池中对象数量:"..cnt)
    ---------------------------------------------------------------------
    ]]
    --
end


function EffectManager.dump()
    ----app.log_warning("nfx >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

    ----app.log_warning("nfx 1 allUsingObjList:"..__getns(EffectManager.allUsingObjList))
    msg = "nfx "
    for k, v in pairs(EffectManager.allUsingObjList) do
        local p_name = "_p_";
        if v.placeHolder ~= nil then
            p_name = v.placeHolder:get_name();
            if nil == p_name then
                p_name = "bad get_name()"
            end
        end

        local e_name = "_e_"
        if v.effectEntity ~= nil then
            e_name = v.effectEntity:get_name();
            if nil == e_name then
                e_name = "bad get_name"
            end
        end
        msg = msg .. string.format("id:%d, gid:%d, name:%s,%s", v:GetID(), v:GetGID(), p_name, e_name)
    end
    ----app.log_warning(msg)

    -----------------------------------------------------------------
    -- local n = 0
    -- for k, v in pairs(EffectManager.allUsingObjIdLookUp) do
    --     n = n + __getn(v)
    -- end
    ----app.log_warning("nfx --2 allUsingObjIdLookUp cnt:"..tostring(n))

    ----app.log_warning(table.tostring(EffectManager.allUsingObjIdLookUp))


    ----app.log_warning("nfx ---3utoRecyleCheckObjList"..__getns(EffectManager.autoRecyleCheckObjList))
    msg = "nfx "
    for k, v in pairs(EffectManager.autoRecyleCheckObjList) do
        -- msg = msg .. string.format("id:%d, gid:%d, name:%s,%s", v:GetID(), v:GetGID(), v.placeHolder:get_name(), v.effectEntity:get_name())
        msg = msg .. string.format("id:%d:%d", v:GetID(), v:GetGID())
    end
    ----app.log_warning(msg)

    msg = "nfx "
    ----app.log_warning("nfx ---4-standByObjPool-------------"..__getns(EffectManager.standByObjPool))
    for k, v in pairs(EffectManager.standByObjPool) do
        -- msg = msg .. string.format("id:%d, gid:%d, name:%s,%s", v:GetID(), v:GetGID(), v.placeHolder:get_name(), v.effectEntity:get_name())
        for kk, vv in pairs(v) do
            msg = msg .. string.format("id:%d:%d", vv:GetID(), vv:GetGID())
            ----app.log_warning(msg)
        end
    end

    ----app.log_warning("nfx <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
end


-- 显示被指示线选中时，脚底的光圈特效
function EffectManager.ShowHitCircle(list)
    local hit_player = { };
    -- 显示被射线击中的人的脚底光圈
    if list then
        for k, v in pairs(list) do
            local info = PlayerManager.GetRole(v:get_nam());
            if info then
                if (info.effect_hit_circle ~= nil) then
                    info.effect_hit_circle:set_active(true);
                else
                    ----app.log("nfx 角色脚底没有被射线击中光圈特效！！");
                end
                hit_player[v:get_name()] = true;
            end
        end
    end
    -- 隐藏未被射线击中的人的脚底光圈
    for k, v in pairs(PlayerManager.GetRoleList()) do
        if (hit_player[v.name] ~= true) then
            if (v.effect_hit_circle ~= nil) then
                v.effect_hit_circle:set_active(false);
            else
                ----app.log("nfx 脚底没有被射线击中光圈特效");
            end
        end
    end
end

-- 显示当前选中状态特效
function EffectManager.ShowCurChoose(is_show)
    if (EffectManager.effect_cur_choose == nil) then
        EffectManager.effect_cur_choose = EffectManager.createEffect(500003);
    end
    if nil ~= EffectManager.effect_cur_choose then
        --        local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,3)
        if (is_show) then
            if (FightManager.GetMyCaptain() ~= nil) then
                --               local  bind_pos = FightManager.GetMyCaptain().object:GetBindPosition(3)
                local x, y, z = FightManager.GetMyCaptain().object:GetBindPositionA(3);
                EffectManager.effect_cur_choose:set_position(x, y + 0.01, z)
                EffectManager.effect_cur_choose:set_parent(bind_pos)
                EffectManager.effect_cur_choose:set_local_rotation(0, 0, 0);
                EffectManager.effect_cur_choose:set_local_scale(1, 1, 1);

                EffectManager.effect_cur_choose:set_active(true);
            else
                ----app.log("nfx 没有当前角色，选中特效播不出来");
            end
        else
            EffectManager.effect_cur_choose:set_active(false);
            EffectManager.effect_cur_choose:set_parent(FightScene.fightScene);
        end

    end
end

-- 显示当前选中状态爆发特效
function EffectManager.ShowCurChooseBaofa(is_show)
    if (EffectManager.effect_cur_choose_baofa == nil) then
        EffectManager.effect_cur_choose_baofa = EffectManager.createEffect(500009);
    end
    if nil ~= EffectManager.effect_cur_choose_baofa then
        --        local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,3)
        if (is_show) then
            if (FightManager.GetMyCaptain() ~= nil) then
                --                bind_pos = FightManager.GetMyCaptain().object:GetBindPosition(3)
                local x, y, z = FightManager.GetMyCaptain().object:GetBindPositionA(3);
                EffectManager.effect_cur_choose_baofa:set_position(x, y + 0.01, z)
                EffectManager.effect_cur_choose_baofa:set_parent(bind_pos)
                EffectManager.effect_cur_choose_baofa:set_local_rotation(0, 0, 0);
                EffectManager.effect_cur_choose_baofa:set_local_scale(1, 1, 1);

                EffectManager.effect_cur_choose_baofa:set_active(is_show);
            else
                ----app.log("nfx 没有当前角色，选中爆发特效播不出来");
            end
        else
            EffectManager.effect_cur_choose_baofa:set_active(false);
            EffectManager.effect_cur_choose_baofa:set_parent(FightScene.fightScene);
        end
    end
end

function EffectManager.ShowKillNumEffect(killNum)
    local id = 700001;
    if (killNum == 1) then
        id = 700001;
    elseif (killNum == 2) then
        id = 700002;
    elseif (killNum == 3) then
        id = 700003;
    else
        id = 700001;
    end
    local effect = EffectManager.createEffect(id, 1);
    --    local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,3)
    if (FightManager.GetMyCaptain() ~= nil) then
        --        local bind_pos = FightManager.GetMyCaptain().object:GetBindObj(3)
        local x, y, z = FightManager.GetMyCaptain().object:GetBindPositionA(3);
        effect:set_position(x, y + 6, z)
        effect:set_parent(bind_pos)
        effect:set_local_rotation(0, 0, 0);
        effect:set_local_scale(1, 1, 1);
        effect:set_active(true);
    else
        ----app.log("nfx 没有当前角色，选中爆发特效播不出来");
    end
end

function EffectManager.DestroyAllEffectObj()
    EffectManager.effect_cur_choose = nil;
    EffectManager.effect_cur_choose_baofa = nil;
    EffectManager.effect_kill_one = nil;
end
-- 被击特效朝向旋转
-- effect 特效对象 Effect类对象
-- attack 攻击者   entity对象
-- beattack 被击者 entity对象
-- angle 角度 0 - 360
function EffectManager.RotationBeattackEffect(effect, attack, beattack, angle)
    if effect == nil or attack == nil or beattack == nil or angle == nil then
        return;
    end
    local attForward = attack:GetForWard();
    -- 得到应该偏向的朝向
    local eulerX, eulerY, eulerZ, eulerW = util.quaternion_euler(0, angle, 0);
    local realX, realY, realZ = util.quaternion_multiply_v3(eulerX, eulerY, eulerZ, eulerW, attForward.x, attForward.y, attForward.z);
    ------app.log("nfx realX="..realX.."   realY="..realY.."   realZ="..realZ);
    -- 由于特效是绑定在被击者身上  所以要加入一个被击者朝向旋转 util.quaternion_multiply_v3是旋转一个向量
    -- local beattRot = beattack:GetRotation();
    -- local beeulerX,beeulerY,beeulerZ,beeulerW = util.quaternion_euler(0, beattRot.y, 0);
    -- local resultX,resultY,resultZ = util.quaternion_multiply_v3(beeulerX,beeulerY,beeulerZ,beeulerW,realX,realY, realZ);
    -- effect:set_forward(resultX,resultY,resultZ);
    effect:set_forward(realX, realY, realZ);
end

function EffectManager.HandleHitedEffect(skillCreator, cfg, _target, skill_id)
    if cfg.hited_effect_seq ~= 0 and _target then
        local len = #cfg.hited_effect_seq
        for i = 1, len do
            _target:SetEffect(skillCreator, cfg.hited_effect_seq[i], nil, nil, nil, nil, nil, { attacker = skillCreator, target = _target }, nil, true, skill_id)
        end
    end
    if cfg.beattack_shake_seq ~= "" and cfg.beattack_shake_seq ~= 0 and cfg.beattack_shake_seq ~= nil and FightManager.GetMyCaptainName() == skillCreator then
        local _cfg = cfg.beattack_shake_seq[1]
        if _cfg.count ~= nil and _cfg.x ~= nil and _cfg.y ~= nil and _cfg.z ~= nil and _cfg.dis ~= nil and _cfg.speed ~= nil and _cfg.decay ~= nil and _cfg.multiply ~= nil then
            CameraManager.shake(
            {
                count = _cfg.count,
                x = _cfg.x,
                y = _cfg.y,
                z = _cfg.z,
                dis = _cfg.dis,
                speed = _cfg.speed,
                decay = _cfg.decay,
                multiply = _cfg.multiply
            }
            )
        else
            ----app.log(string.format("hfx ani 摄像机抖动参数错误 %d", effect_index))
        end
    end
    if cfg.hited_action_seq ~= nil and cfg.hited_action_seq ~= 0 and _target and not _target:IsDead() and not _target:GetBuffManager():IsStateImmune(EImmuneStateType.BeAttackEffect) then
        if skillCreator == FightManager.GetMyCaptainName() then
            local except_flag = 0
            if cfg.hited_action_seq >= 1 and cfg.hited_action_seq <= 3 then
                if skill_id then
                    except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id).beattack1_3
                end
                if not CheckExcept(_target, except_flag) then
                    _target:PostEvent("PlayBeAttackAni", { attackName = skillCreator, type = cfg.hited_action_seq, dis = cfg.hited_repel_dis })
                end
            elseif cfg.hited_action_seq == 4 then
                if skill_id then
                    except_flag = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id).repel_except
                end
                if not CheckExcept(_target, except_flag) then
                    _target:PostEvent("BeRepel", { attackName = skillCreator, dis = cfg.hited_repel_dis })
                end
            end
        end
    end
    -- 播放被击音效
    if _target.config and _target.config.sp_hited_audio_seq and _target.config.sp_hited_audio_seq ~= 0 then
        if _target.config.sp_hited_audio_seq ~= -1 and type(_target.config.sp_hited_audio_seq) == "table" then
            local length = #_target.config.sp_hited_audio_seq;
            local n = math.random(1,length);
            local audio_id = _target.config.sp_hited_audio_seq[n];
            local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,3)
            bind_pos = _target.object:get_child_by_name(bind_pos.bind_pos_name)
            if (bind_pos ~= nil) then
                local volScale = AudioManager.GetVolScaleBySceneEntity(creator);
                if _target:GetName() == FightManager.GetMyCaptainName() then
                    AudioManager.Play3dAudio(audio_id, bind_pos,true,nil,nil,nil,nil,nil,volScale)
                else
                    AudioManager.Play3dAudio(audio_id, bind_pos,nil,nil,nil,nil,nil,nil,volScale)
                end
            end
        else
            --app.log("不播受击音效");
        end
    elseif cfg.hited_audio_seq ~= nil and cfg.hited_audio_seq ~= 0 and _target then
        local length = #cfg.hited_audio_seq;
        local n = math.random(1,length);
        local audio_cfg = cfg.hited_audio_seq[n];
        if nil ~= audio_cfg then
            local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,audio_cfg.pos)
            if not _target or not _target.object then
                return
            end
            bind_pos = _target.object:get_child_by_name(bind_pos.bind_pos_name)
            if (bind_pos ~= nil) then
                local creator = ObjectManager.GetObjectByName(skillCreator)
                local volScale = AudioManager.GetVolScaleBySceneEntity(creator);
                if _target:GetName() == FightManager.GetMyCaptainName() then
                    AudioManager.Play3dAudio(audio_cfg.id, bind_pos,true,nil,nil,nil,nil,nil,volScale)
                else
                    AudioManager.Play3dAudio(audio_cfg.id, bind_pos,nil,nil,nil,nil,nil,nil,volScale)
                end
            end
        else
            ----app.log(string.format("nfx ani 被击特效播放错误."))
        end
    end
end

function EffectManager.SetEffect(obj, src_obj_name, eventCfg, cbfunction, cbdata, effectTarget, direction, durationTime, hitedinfo, collisioninfo, handlehit, skill_id, end_pos, use_time)
    -- app.log(tostring(obj:IsMyControl()).."    "..tostring(EffectManager.activedEffectEntityCnt).."    "..tostring(EffectManager.maxEffectEntityCnt))

    --    if not obj:IsMyControl() and not obj:IsAIAgent() and EffectManager.activedEffectEntityCnt >= EffectManager.maxEffectEntityCnt then
    --        return -1;
    --    end

    --    if GameSettings.GetEnableEffectCountControl() and not obj:IsMyControl() and not obj:IsAIAgent() then
    --        local b, n, s = EffectManager.checkEffectCount(skill_id)
    --        if not b then
    --            app.log("特效多了SetEffect" .. tostring(skill_id) .. " n:" .. n .. " s:" .. s)
    --            return -1
    --        end
    --    end
    local delTime = durationTime
    if delTime == nil then
        local _effect = ConfigManager.Get(EConfigIndex.t_all_effect,eventCfg.id)
        if eventCfg and _effect and _effect.time and _effect.time ~= 0 then
            delTime = _effect.time * 0.001
        else
            delTime = EffectManager.fightEffectDelTime
        end
    elseif delTime == 0 then
        delTime = nil
    end
    local action_effect_deltime = durationTime
    if action_effect_deltime == nil then
        action_effect_deltime = 0.4
    else
        action_effect_deltime = action_effect_deltime * 0.001
    end
    --[[if effectTarget then
        obj:LookAt(effectTarget:GetPositionXYZ())
    end]]
    if eventCfg.type == ENUM.EffectType.Fixed or eventCfg.type == nil then
        local effectObj, createRet = playRoleEffect(eventCfg, obj, delTime, "atk");
        if createRet == true then
            if hitedinfo ~= nil and eventCfg.angle ~= nil and eventCfg.angle ~= 0 then
                local attcker = ObjectManager.GetObjectByName(hitedinfo.attacker);
                if attcker then
                    EffectManager.RotationBeattackEffect(effectObj, attcker, hitedinfo.target, eventCfg.angle)
                end
            end
            if direction then
                effectObj:set_forward(direction.x, 0, direction.z);
            end
            return effectObj:GetGID()
        end
    elseif eventCfg.type == ENUM.EffectType.Emitter or eventCfg.type == ENUM.EffectType.Transform then
        local effect_pos = obj:GetBindPosition(eventCfg.pos, true);
        if nil ~= effectTarget and (not effectTarget.finalized) then
            return EffectManager.createActionEffect( {
                cfg = eventCfg,
                type = eventCfg.type,
                effect_id = eventCfg.id,
                speed = eventCfg.speed,
                start_pos = effect_pos,
                target = effectTarget,
                bind_pos = eventCfg.pos,
                callback_collision = cbfunction,
                user_data = cbdata,
                src_obj_name = src_obj_name,
                handlehit = handlehit,
                skill_id = skill_id,
            } )
        else
            local direct = nil
            local endpos = nil
            local speed = eventCfg.speed
            local usetime = action_effect_deltime
            local disscallback = nil
            local user_data = nil
            if end_pos then
                endpos = end_pos
                if use_time then
                    local dis = algorthm.GetDistance(effect_pos.x, effect_pos.z, end_pos.x, end_pos.z)
                    usetime = use_time*0.001
                    speed = dis/usetime
                    local direct_x, direct_y, direct_z = util.v3_normalized(end_pos.x - effect_pos.x, 0, end_pos.z - effect_pos.z);
                    direct = {x=direct_x, y=direct_y, z=direct_z}
                end
                disscallback = cbfunction
                user_data = cbdata
            else
                if direction == nil then
                    direct = obj:GetForWard()
                else
                    direct = direction
                end
            end
            

            return EffectManager.createActionEffect( {
                cfg = eventCfg,
                type = eventCfg.type,
                effect_id = eventCfg.id,
                speed = speed,
                start_pos = effect_pos,
                direct = direct,
                use_time = usetime,
                src_obj_name = src_obj_name,
                handlehit = handlehit,
                skill_id = skill_id,
                end_pos = endpos,
                callback_dissipate = disscallback,
                user_data = user_data,
            } )
        end
    --[[elseif eventCfg.type == ENUM.EffectType.Transform then
        local effect_pos = obj:GetBindPosition(eventCfg.pos);
        return EffectManager.CreateTransformationEffect( {
            cfg = eventCfg,
            effect_id = eventCfg.id,
            speed = eventCfg.speed,
            start_pos = effect_pos,
            callback_collision = cbfunction,
            user_data = cbdata,
            start_frame = PublicFunc.QueryCurTime(),
            maxlen = eventCfg.maxlen,
            obj = obj,
        } )]]
    elseif eventCfg.type == ENUM.EffectType.EmitterCollision then
        local effect_pos = obj:GetBindPosition(eventCfg.pos, true);
        local direct
        if direction == nil then
            direct = obj:GetForWard()
        else
            direct = direction
        end
        if eventCfg.offset and eventCfg.offset ~= 0 then
            local angle = 90
            if math.random() >= 0.5 then
                angle = -90
            end
            local len = math.random() * eventCfg.offset
            local rx, ry, rz, rw = util.quaternion_euler(0, angle, 0);
            local resultX, resultY, resultZ = util.quaternion_multiply_v3(rx, ry, rz, rw, direct.x, direct.y, direct.z)
            effect_pos.x = effect_pos.x + resultX * len
            effect_pos.z = effect_pos.z + resultZ * len
        end
        return EffectManager.createActionEffect( {
            cfg = eventCfg,
            type = eventCfg.type,
            effect_id = eventCfg.id,
            speed = eventCfg.speed,
            start_pos = effect_pos,
            direct = direct,
            use_time = delTime * 0.001,
            obj = obj,
            collisioninfo = collisioninfo,
            callback_collision = cbfunction,
            user_data = cbdata,
            src_obj_name = src_obj_name,
            handlehit = handlehit,
            skill_id = skill_id,
        } )
    elseif eventCfg.type == 4 then
        local effect_pos = obj:GetBindPosition(eventCfg.pos, true);
        if nil ~= effectTarget and (not effectTarget.finalized) then
            return EffectManager.createActionEffect( {
                cfg = eventCfg,
                type = eventCfg.type,
                effect_id = eventCfg.id,
                speed = eventCfg.speed,
                start_pos = effect_pos,
                target = effectTarget,
                bind_pos = eventCfg.pos,
                callback_collision = cbfunction,
                user_data = cbdata,
                src_obj_name = src_obj_name,
                handlehit = handlehit,
                skill_id = skill_id,
                src_angle = eventCfg.angle
            } )
        else
            local direct
            if direction == nil then
                direct = obj:GetForWard()
            else
                direct = direction
            end
            return EffectManager.createActionEffect( {
                cfg = eventCfg,
                type = eventCfg.type,
                effect_id = eventCfg.id,
                speed = eventCfg.speed,
                start_pos = effect_pos,
                direct = direct,
                use_time = action_effect_deltime,
                src_obj_name = src_obj_name,
                handlehit = handlehit,
                skill_id = skill_id,
                src_angle = eventCfg.angle
            } )
        end
    end
    return -1
end


--切换场景的时候需要立刻回收 ‘托管’ 的特效对象
function EffectManager.__ClearAutoReleaseEffectObj()
    EffectManager.checkRelease(true)
end


function EffectManager.DestroyRes(force)
    -- TODO: 先暂时clear pool.
    if force then
        -- other res.
    end 

    EffectManager.__ClearAutoReleaseEffectObj();

    EffectManager.__ClearEffectPoolObj();
    EffectManager.counters.skill_cnt = 0;
    EffectManager.counters.normal_cnt = 0;
    EffectManager.counters.hited_cnt = 0;
end

function EffectManager.StartUp()
    EffectManager.checkUpdateTime = 0;
    Root.AddUpdate(EffectManager.update);
    EffectManager.LoadPlaceHolderRes();
end

