-- 查看某个模块  搜索下列相应文字 lyl
-- 初始化以及销毁相关
-- 获取相关
-- 设置相关
-- 判断相关
-- AI相关
-- 属性相关
-- 内部更新
-- 动作相关
-- 事件相关
-- 技能相关
-- 移动相关
-- 对象状态机
script.run("logic/object/entity_state.lua");
-- 操作及AI状态机
script.run("logic/object/handle_state.lua");

SceneEntity = Class("SceneEntity")
-- 初始化以及销毁相关
local ui_all_index = nil
function SceneEntity:SceneEntity(data)
    self.isReady = true

    if ui_all_index == nil then
        ui_all_index = {}
        for i=1, PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX do
            table.insert(ui_all_index, 0)
        end
        table.insert(ui_all_index, 2)
        table.insert(ui_all_index, 3)
        table.insert(ui_all_index, 4)
    end
    if SceneEntity.normal_skill_add_view_radius == nil then
        local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_normalSkillAddViewRadius);
        if cf then
            SceneEntity.normal_skill_add_view_radius = cf.data;
        end
    end
    -- <回调区>
    self.OnDeadCallBack = nil




    -- </回调区>


    -- 构造函数
    self.destination = { x = 0, y = 0, z = 0 }
    self.canSearch = true;
    -- huhu 以属性id为key的属性值表。
    self.property = { }
    self.runSetProperty = {}
    self.property_limit_max = { }
    self.property_limit_min = { }
    self.objType = data.objType;
    self.change_obj = true
    self.showType = data.showType;

    self.object = CreateFromResourceObj(data.obj)

    -- if self:ismonster() then
    --     self.object = data.obj:clone();

    --     self.object = asset_game_object.create(data.obj); else
    -- end
	self.playMethodAcitvityTimeEnum = data.playMethodAcitvityTimeEnum;
    self.name = data.name;
    self.iid = self.object:get_instance_id()
    self.gid = data.gid
    self.uuid = data.uuid
    self.groupName = data.group_name
    -- dataid
    self:SetName(self.name);
    self.config = data.config;
    self.is_renderer_show = false

    self:SetAnimatorFile();

    self.frame_cnt_local = -1
    self.frame_cnt = -1
    self.local_position = { x = 0, y = 0, z = 0 }
    self.position = { x = 0, y = 0, z = 0 }
    -- 战斗状态相关
    self.fight_state_targets_cnt = 0
    self.fight_state_initiative_targets = { }
    self.fight_state_passivity_targets = { }
    self.mmo_fight_state_begin_time = 0

    self.bindNodeLookUp = { };
    self.can_reborn_now = false
    self.InvisiMateCfg = ConfigManager.Get(EConfigIndex.t_mondel_invisible_cfg,data.config.model_id);
    if self.InvisiMateCfg then
        self.InvisibleMaterial = asset_game_object.find(data.name .. "/" .. self.InvisiMateCfg.mat_name);
        if self.InvisibleMaterial then
            self.InvisibleMaterial:set_active(false);
            self.InvisibleMaterial = self.InvisibleMaterial:get_material();
        end
    end
    self.aperture_manager = ApertureManager:new(self:GetGID())
    self.camp_flag = data.camp_flag;
    self.country_id = data.country_id;
    self.objType = data.objType;
    self.card = data.card
    self.owner_player_gid = owner_player_gid
    self.is_item_open = false;
    self.list_play_method_ability_scale_multiply = {}
    self.navMeshAgent = self.object:get_component_navmesh_agent();
    if self.navMeshAgent then
        self.navMeshAgent:set_speed(self:GetPropertyVal(ENUM.EHeroAttribute.move_speed));
--        if self:IsMonster() then
--            self.navMeshAgent:set_radius(1)
--        end
    end
    if (self.objType == OBJECT_TYPE.HERO) then
        self.object:set_layer(PublicStruct.UnityLayer.player, true);
        local layer_mask = PublicFunc.GetBitLShift({[1]=PublicStruct.NavigationAreas.walkable});
        if self.navMeshAgent then
            self.navMeshAgent:set_area_mask(layer_mask);
        end
        self.old_layer_mask = layer_mask;
    elseif self.objType == OBJECT_TYPE.NPC then
        self.object:set_layer(PublicStruct.UnityLayer.npc, true);
    elseif self.objType == OBJECT_TYPE.ITEM then
        self.object:set_layer(PublicStruct.UnityLayer.ground_item, true);
    elseif self.objType == OBJECT_TYPE.MONSTER then
        self.object:set_layer(PublicStruct.UnityLayer.monster, true);
        if self.config.area_mask then
            if self.config.area_mask[1] == -1 then
                if self.navMeshAgent then
                    self.navMeshAgent:set_area_mask(-1);
                end
                self.old_layer_mask = -1
            else
                local layer_mask = PublicFunc.GetBitLShift(self.config.area_mask);
                if self.navMeshAgent then
                    self.navMeshAgent:set_area_mask(layer_mask);
                end
                self.old_layer_mask = layer_mask;
            end
        end
    end
    self.level = data.level or data.config.level or 1;
    self:UpdateProperty(true);
    -- self.beAtkCounter = 0   -- 被某个技能攻击计数累加
    -- self.attackSeqNum = 0
   

    if not self:IsItem() then
        -- 初始化血条
        self:InitUiHp();
        -- Root.AddLateUpdate(SceneEntity.LateUpdate, self); 放在scene entity update
        -- 不是触发器或者道具才加代理跟动态障碍


        self.navMeshObstacle = self.object:get_component_navmesh_obstacle()
        if self.navMeshObstacle then
            self.navMeshObstacle:set_enable(false);
--            if self:IsMonster() then
--                self.navMeshObstacle:set_radius(1)
--            end
        end
    end    
    
    self.fsm = FSM:new(self)
    self.fsm:Register(EntityState)
    self.aniCtroller = AniCtrler:new( {
        obj = self,
        onAttackEnd = { func = self.onAniAttackEnd, obj = self },
        onBeHitEnd = { func = self.onAniBeHitedEnd, obj = self },
        onJumpTakeOff = { func = self.onJumpTakeOff, obj = self },
        onJumpLanding = { func = self.onJumpLanding, obj = self },
        onJumpLanded = { func = self.onJumpLanded, obj = self },
        onAtkThrow2wall_releaseTarget = { func = self.onAtkThrow2Wall_ReleaseTarget, obj = self },
        onAtkThrow2Wall_end = { func = self.onAtkThrow2Wall_end, obj = self },
        onBeAtkThrow2Wall_end = { func = self.onBeAtkThrow2Wall_end, obj = self },
        onAniAttackCombo = { func = self.onAniAttackCombo, obj = self },
        onCollideTarget = { func = self.onAniCollideTarget, obj = self },
    } );
    self:SetMoveAniId(EANI.run)
    -- self.ctrl = {}
    -- 战斗动作回调需要恢复的标记
    -- self.attackEndCallBackFlags = {}

    -- 当前连杀对方英雄个数,时间间隔5秒,5秒后清0
    self.killNum = 0;
    -- 当前累计杀对方英雄个数,自身死亡后清0
    self.killAllNum = 0;

    -- 出场战斗的序号，现在主要是英雄用，用来查出生位置什么的,在fight_player:OnCreateSceneEntity赋值
    self.index = nil;


    -- 被冰冻的对象列表， 死亡时候尝试接触列表中对象身上的 冰冻buff。
    self.frozenTargetList = nil;
    self.buff_manager_tick_count = 1;


    -- self:InitAI();


    -- 小地图相关
    -- if not self:IsEnemy() then
    --     mini_map.add_partner(self.object);
    -- else
    --     mini_map.add_enemy(self.object);
    -- end
    -- local mini = mini_map.get_com_by_obj(self.object);
    -- if self:IsHero() then
    --     self.big_map_obj = FightMap.add_player(self.object, FightMap.EObj_type.player, self:GetCampFlag());
    --     if mini then
    --         mini:set_inner_sprite("dayuan3");
    --     end
    -- elseif self:IsMonster() then
    --     if self:IsTower() then
    --         self.big_map_obj = FightMap.add_player(self.object, FightMap.EObj_type.small_tower, self:GetCampFlag());
    --         if mini then
    --             mini:set_inner_sprite("xiaota3");
    --         end
    --     elseif self:IsSoldierClose() or self:IsSoldierRnage() or self:IsSoldierSuper() then
    --         self.big_map_obj = FightMap.add_player(self.object, FightMap.EObj_type.monster, self:GetCampFlag());
    --         if mini then
    --             mini:set_inner_sprite("xiaodian1");
    --         end
    --     elseif self:IsBasis() then
    --         self.big_map_obj = FightMap.add_player(self.object, FightMap.EObj_type.big_tower, self:GetCampFlag());
    --         if mini then
    --             mini:set_inner_sprite("xiaota1");
    --         end
    --     end
    -- end
    FightMap.ChangeIcon(self.big_map_obj, FightEnum.KILL_HEAD[self:GetModelID()]);

    -- 技能状态
    self.useSkillOnce = true;
    self.skillUsed = false;
    self.lastSkillComplete = true;
    self.canMoveWhenSkill = false;
    self.canSkillRotate = false
    self.attackBegin = false;
    -- 被击动作是否播完
    self.behitFinish = false;
    -- 连击数据
    self.can_combo = false;
    -- 是否采用连击
    self.normalAttackIndex = 1;
    -- 是否强制动作结束
    self.skillForceComplete = false;
    -- 使用的普攻index

    --[[if(self:GetCampFlag() == 1)then
		self:SetProperty("max_hp", 10000)
		self:SetHP(10000);
	end]]
    self.attackRange = 2;
    self.detectRange = 10;
    self.attack_cd_time = 2;
    self._arrSkill = { }
    if self:IsMonster() then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            self:KeepNormalAttack(false);
        else
            self:KeepNormalAttack(true);
        end
    else
        if self:IsMyControl() then
            self:KeepNormalAttack(true);
        else
            self:KeepNormalAttack(false);
        end
    end
    self._buffManager = BuffManager:new(self)
    self._skillCheckRef = { }
    -- 自定义移动列表
    self.posMoveList = nil;

    -- 外部自定义变量区
    self.externalArea = { };
    self.externalAreaState = { };

    -- 上次发送移动的向量
    self.last_move_forward = { }
    -- 上次发送移动的目标
    self.last_move_dest_pos = nil

    -- if (self:GetCampFlag() == 1) then
    --    self.object:set_material_color_with_name("",0.2, 0.2, 0.2, 0.2)
    -- end
    self._newRotation = nil

    -- 触发器组件
    self:AddTriggerComponent()
    -- <临时重构状态机使用>
    self:extraInitData()

    self.realConfig = { }

    self._careGlobalPauseState = true
    if self:IsMonster() then

        -- 设置开场动画
        self._beginAnim = data.beginAnim;
        self._delayAi = self.config.ai;
        self._delayAiParam = nil;
        if data.beginAnim and data.beginAnim ~= 0 then
            self:SetBeginAnim(data.beginAnim);
        else
            local aiId = self.config.ai
            if aiId == nil then
                app.log("can't read monster ai config")
            else
                self:SetAI(aiId)
            end

            self:UpdateViewAngleRangeEffect()
        end
    end

    self.entityRadius = 0
    local modelConfig = ConfigManager.Get(EConfigIndex.t_model_list, self:GetModelID())
    if modelConfig then
        self.entityRadius = modelConfig.radius * PublicFunc.GetUnifiedScale(self)
    end

    -- </临时重构状态机使用>
    -- 每个人的光环
    if not self:IsItem() and not self:IsNpc() then
        --        self.effectAperture = self.aperture_manager:CreateNotMove(1700009);
        --        if self.effectAperture then
        --            local parent = self:GetBindObj(3);
        --            self.aperture_manager:SetOpenNotMove(self.effectAperture, true, parent);
        --        end
        -- 优化版影子 Ewing
        self:CreateFastShadow()
        
    end
    self.__event_mgr = { eventQueue = { } }
    self._headInfoControler = HeadInfoControler:new(self)


    self.managedEffectList = { }
    self._makeDamage = 0


    -- 受击高光
    -- 所有材质
    self.materialList = { };
    self.shineList = { };

    local modelConfig = ConfigManager.Get(EConfigIndex.t_model_list,self.config.model_id);
    if modelConfig and modelConfig.material_list ~= 0 then
        for k, v in pairs(modelConfig.material_list) do
			local itemname = nil;
			if v.list ~= nil then 
				itemname = v.list;
			elseif v.hz ~= nil then 
				itemname = v.hz;
			end 
            local shine = self.object:get_child_by_name(itemname);
            if shine then
                table.insert(self.materialList, shine);
                table.insert(self.shineList, ShineObj:new( { obj = shine, name = self.name }))
            end
        end
        self.shineList.shinePower = modelConfig.shine_power;
        self.shineList.shineReduce = modelConfig.shine_reduce;
    end

    self:CreateEffect();


    -- --主角列表
    -- self.gainMaterialList = {};
    -- -- self.gainPower = 2;
    -- self.gainColor = {r=1,g=1,b=1,a=1};
    -- -- self.oldGainPower = 2;
    -- self.oldGainColor = {r=200/255,g=200/255,b=200/255,a=1};
    -- if modelConfig and modelConfig.gain_material_list ~= 0 then
    --     for k, v in pairs(modelConfig.gain_material_list) do
    --         local tex = self.object:get_child_by_name(v.list);
    --         if tex then
    --             table.insert(self.gainMaterialList, tex);
    --             -- self.oldGainPower = tex:get_material_float_with_name("_ViewInten");
    --             self.oldGainColor.r,self.oldGainColor.g,self.oldGainColor.b,self.oldGainColor.a = tex:get_material_color_with_name("_Color")
    --         end
    --     end
    --     --self.gainPower = modelConfig.gain_power;
    -- end
    -- 挂载特效列表
    self.mountingEffectList = { }

    self.showRimLight = false;
    -- boss永远高亮
    if (self:IsBasis() or self:IsBoss()) and not data.not_boss then

        self:ShowRimLight(true)
        if not self:IsEnemy() then
            self._bossAperture = self.aperture_manager:CreateNotMove(ApertureManager.Enum.BossFootBlue);
        else
            self._bossAperture = self.aperture_manager:CreateNotMove(ApertureManager.Enum.BossFootRed);
        end
        self.aperture_manager:SetOpenNotMove(self._bossAperture, true, self:GetObject(), nil, nil, nil, nil, nil, nil, nil, true, nil)
    end

    if self:IsNpc() then
        if self.config.halo_id and self.config.halo_id ~= 0 then
            if not self:IsEnemy() then
                self._npcAperture = self.aperture_manager:CreateNotMove(self.config.halo_id);
            else
                self._npcAperture = self.aperture_manager:CreateNotMove(self.config.halo_id);
            end
            self.aperture_manager:SetOpenNotMove(self._npcAperture, true, self:GetObject(), nil, nil, nil, nil, nil, nil, nil, true, nil)
        end
    end

    -- self:SetProperty("max_hp", 10)
    -- self:SetHP(10);
    self.summone_list = { }

    self.hpBarBindPos = nil
    self.hasHpBarBindPos = true

    self.tabSkillIndex = {}
    for i = 1, 3 do
        table.insert(self.tabSkillIndex, PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX + i)
    end
    if self:IsMonster() then
        table.insert(self.tabSkillIndex, 1, 1)
    else
        table.insert(self.tabSkillIndex, 1)
    end
    -- app.log("AI skill index = " .. self:GetName() .. ' ' .. table.tostring(self.tabSkillIndex))
    self.beTauntSkillIndex = {1};
    --self:AddEventFilter(AIC_CaptainManulDoNotReciveEvent, self)
    self._BeAttackedCallbackFuncs = {}
    self._AttackedCallbackFuncs = {}
    self.__log = {}
    self.__aiPauseCount = 0
    if self:IsHero() then
        PublicFunc.SetHurdleHeroViewRadius(self)
    end

    self:InitHatredValue()

    self._isShow = true

    self.fix_move = nil
    self.one_sec_accumulator = 0
    self.taunt_list = {}
    self.hide_hp = false
    self.host_gid = 0
    self.sync_type = ENUM.SyncObjType.FullSync
    Root.AddLateUpdate(self.LateUpdate, self);

    self:EntityInit()
end

function SceneEntity:EntityInit()
    self:SetNavMeshRadius()

    if self.navMeshAgent then
        self.navMeshAreaMask = self.navMeshAgent:get_area_mask()
    end

    if self:IsSpecMonster() then
        self.object:set_layer(PublicStruct.UnityLayer.ground_item, true);
    end

    --禁用一个collider,防止2个collider出发2次
    if self:IsHero() or self:IsMonster() then
        self.object:set_collider_enable(false, true)
        self.object:set_collider_enable(true, false)
        self.object:set_is_trigger(false)
    end
end

function SceneEntity:SetIsTrigger(is)
    self._isTrigger = is
    if self.object then
        self.object:set_is_trigger(is)
    end
end

function SceneEntity:GetNavMeshAreaMask()
   return  self.navMeshAreaMask
end

function SceneEntity:UpdateViewAngleRangeEffect()

    if self:IsDead() then return end

    local angle = self.config.view_angle
    --angle = 120
    if angle == nil or angle == 0 then return end
    self:DestroyViewAngleEffects()

    local effectID = ENUM.ViewAngleEffectID.angle90
    if angle == 360 then
        effectID = ENUM.ViewAngleEffectID.angle360
    elseif angle > 100 then
        effectID = ENUM.ViewAngleEffectID.angle120
    end
    
    self.viewRadiusEffectGids = self:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data, effectID), nil, nil, nil, nil, 0)
    local radius = self:GetConfig("view_radius")
    for k,id in ipairs(self.viewRadiusEffectGids) do
        local effect = EffectManager.GetEffect(id)
        if effect then
            effect:set_local_scale(radius, radius, radius)
            effect:set_local_position(0, 0, 0)
        end
    end

    if  self.viewAngleRangeEffectIsShow ~= nil then
        self:ShowViewAngleRangeEffect(self.viewAngleRangeEffectIsShow)
    end
end

function SceneEntity:HasViewRangeEffect()
    return self.viewRadiusEffectGids ~= nil
end

function SceneEntity:ShowViewAngleRangeEffect(show)
    self.viewAngleRangeEffectIsShow = show
    if self.viewRadiusEffectGids then
        for k,id in ipairs(self.viewRadiusEffectGids) do
            local effect = EffectManager.GetEffect(id)
            if effect then
                effect:set_active(show)
            end
        end
    end
end

function SceneEntity:DestroyViewAngleEffects()
    if self.viewRadiusEffectGids then
        for k,id in ipairs(self.viewRadiusEffectGids) do
            EffectManager.deleteEffect(id)
        end
    end
end

function SceneEntity:SetAnimatorFile()
    local filepath = PublicFunc.GetModelAnimFilePath(self:GetModelID());
    if type(filepath) == "string" then
        local obj = ResourceManager.GetResourceObject(filepath);
        self.object:set_an_collider(obj:GetObject());
    end
end

function SceneEntity:CreateFastShadow()
    if self:IsSpecMonster() then return end

    local bind_obj = self:GetBindObj(3)
    if bind_obj then
        bind_obj:create_fast_shadows()    
    end
end

function SceneEntity:SetBeginAnim(anim_id)
    local cfg = ConfigHelper.GetSkillEffectByModelId(self.config.model_id, anim_id);
    if type(cfg.frame_event) == "table" then
        local animTime = cfg.frame_event[1].f*PublicStruct.MS_Each_Anim_Frame;
        local func = function ()
            self._beginAnim = nil;
            self:SetAI(self._delayAi, self._delayAiParam);
            self:UpdateViewAngleRangeEffect()
            --local setSearch = function()
                self:SetCanSearch(true);
                --app.log(self:GetName().." 解除攻击锁定")
                self.beginAnimTimeId = nil;
                self._delayAi = nil;
                self._delayAiParam = nil;
            --end
            --self.beginAnimTimeId = timer.create(Utility.create_callback(setSearch),500,1);
        end
        self.beginAnimTimeId = timer.create(Utility.create_callback(func),animTime,1);
        local animName = PublicFunc.GetAniFSMName(anim_id,self.config.model_id);
        if animName ~= "" then
            local delay = function ()
                self.object:animator_play(animName);
                self:SetCanSearch(false);
            end
            timer.create(Utility.create_callback(delay),10,1);
        else
            func();
        end
    end
end

function SceneEntity:OnCreate()
    if SceneManager.GetCurrentScene() == FightScene and FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
        if self.config.passive_buff ~= nil and self.config.passive_buff ~= 0 then
            for k, v in pairs(self.config.passive_buff) do
                --app.log(tostring(self.name).."添加被动BUFF..id="..tostring(v.id).." lv="..tostring(v.lv))
                self:AttachBuff(v.id, v.lv, self:GetName(), self:GetName(), nil, 0, nil, 0, 0, 0, nil, nil, false, nil)
            end
        end

        if self.config.restraint_buff_id and self.config.restraint_buff_id ~= 0 and
            self.config.restraint_buff_lv_set and self.config.restraint_buff_lv_set ~= 0 then
            for k, v in pairs(self.config.restraint_buff_lv_set) do
                self:AttachBuff(self.config.restraint_buff_id, v, self:GetName(), self:GetName(), nil, 0, nil, 0, 0, 0, nil, nil, false, nil)
            end
        end
        self.max_normal_skill_index = 0
        if self.config.normal_skill ~= nil and self.config.normal_skill ~= 0 then
            for k,v in ipairs(self.config.normal_skill) do
                if v[1] and v[1] ~= 0 then
                    self:LearnSkill(v[1], v[2], nil, k)
                    self.max_normal_skill_index = k
                end
            end
        end
        if self:IsHero() then
            if self.card then
                for k, v in ipairs(self.card.learn_skill) do
                    self:LearnSkill(v.id, v.level, nil, PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX+k)
                end
            end
            local _,skill_id = FightScene.GetHudleSkillEnable(2);
            if skill_id > 0 then
                if skill_id == PublicStruct.Recover_Skill_ID then
                    FightScene.UseAddHpSkill = true;
                end
                self:LearnSkill(skill_id, 1, 1, PublicStruct.Const.SPECIAL_HURDLE_SKILL)
            end
        else
            if self.config.spe_skill ~= nil and self.config.spe_skill ~= 0 then
                for k,v in ipairs(self.config.spe_skill) do
                    if v[1] > 0 then 
                        self:LearnSkill(v[1], v[2], nil, PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX+k)
                    end
                end
            end
        end
        self.currSkillEx = self._arrSkill[1]
    end
end

function SceneEntity:GetGroupName()
    return self.groupName
end

function SceneEntity:GetCardInfo()
    return self.card
end

function SceneEntity:SetHostGID(gid)
    self.host_gid = gid
end

function SceneEntity:SetDeadAttachHostBuff(buff_info)
    self.dead_attach_host_buff = buff_info
end

function SceneEntity:GetHostGID()
    return self.host_gid
end

function SceneEntity:SetConfig(key, value)
    if key == nil or value == nil then
        return
    end
    self.realConfig[key] = value
end

function SceneEntity:GetRadius()
    if self.entityRadius then
        return self.entityRadius
    else
        return 0
    end
end

function SceneEntity:ShowAperture(isShow)
    if self._bossAperture then
        self.aperture_manager:SetOpenNotMove(self._bossAperture, isShow, self:GetObject(), nil, nil, nil, nil, nil, nil, nil, true, nil)
    end
end

function SceneEntity:HideHP(is_hide)
    if is_hide then
        self:ShowHP(false)
    end
    self.hide_hp = is_hide
end


function SceneEntity:GetConfig(key)
    local value = nil
    if self.realConfig[key] == nil then
        value = self.config[key]
    else
        value = self.realConfig[key]
    end
    return value
end

function SceneEntity:GetUUID()
    return self.uuid
end
function SceneEntity:Init()
    self:registFunc();
end

function SceneEntity:registFunc()
    self.bindfunc = { };
    self.bindfunc["RebornTimeUp"] = Utility.bind_callback(self, SceneEntity.RebornTimeUp)
    self.bindfunc["KillCountdown"] = Utility.bind_callback(self, SceneEntity.KillCountdown)
    self.bindfunc["UpdateMove"] = Utility.bind_callback(self, SceneEntity.UpdateMove)
    self.bindfunc["DelayPlayAni"] = Utility.bind_callback(self, SceneEntity.DelayPlayAni)
    self.bindfunc["OnTriggerEnter"] = Utility.bind_callback(self, SceneEntity.OnTriggerEnter)
    self.bindfunc["OnTriggerExit"] = Utility.bind_callback(self, SceneEntity.OnTriggerExit)
    -- app.log('huhu_fight_debug 注册函数 '..self:GetName()..table.tostring(self.bindfunc))
end

function SceneEntity:unregistFunc()
    -- app.log('huhu_fight_debug 清空角色注册的函数 '..self:GetName())
    for k, v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function SceneEntity:CreateEffect()
    if self.config.effect_id and self.config.effect_id ~= 0 then
        local cfg = ConfigManager.Get(EConfigIndex.t_effect_data,self.config.effect_id);
        local p = self:GetPosition();
        --- app.log("px==="..p.x.."  py==="..p.y.."  pz==="..p.z);
        self.cfg_effect_obj = EffectManager.createEffect(cfg.id[1])
        self.cfg_effect_obj:set_parent(self.object);
        self.cfg_effect_obj:set_local_position(0, 0, 0);
        -- self.effectID = FightScene.CreateEffect(p, cfg, nil, nil, nil, nil, 0, nil, false, nil)
    end
end

function SceneEntity:GetGID()
    return self.gid
end

function SceneEntity:GetConfigId()
    return self.config.config_id
end

function SceneEntity:GetProfession()
    return self.config.pro_type
end

-- function SceneEntity:InitSpeakBubbleUI( )
--     if self.ui_speak_bubble then return end
--     self.ui_speak_bubble = SpeakBubbleUI:new();
--     self.ui_speak_bubble:SetData(self);
-- end

function SceneEntity:PlaySpeakByid( speak_id )
    if self.ui_speak_bubble == nil then
        self.ui_speak_bubble = SpeakBubbleUI:new();
        self.ui_speak_bubble:SetData(self);
    end
    self.ui_speak_bubble:SetSpeakByid(speak_id);
end

function SceneEntity:InitEscortHP( )
    if self.ui_escort_hp == nil then
        self.ui_escort_hp = EscortHpUI:new(self);
    end
end

function SceneEntity:DestroyEscortHP()
    if self.ui_escort_hp then
        self.ui_escort_hp:DestroyUi();
        self.ui_escort_hp = nil;
    end
end

function SceneEntity:InitUiHp()
    if self:IsBoss() or self:IsBasis() or self:IsTower() or self:IsSuper() then
        self.ui_hp = TopObjectUi:new( { type = 3, });
    elseif self:IsHero() or (self:IsMonster() and self:GetType() == ENUM.EMonsterType.Hero) then
        self.ui_hp = TopObjectUi:new( { type = 1, });
    elseif self:IsNpc() then
        self.ui_hp = TopObjectUi:new( { type = 4, });
        self.ui_hp:SetNpcName(self.config.npc_name);
    else
        self.ui_hp = TopObjectUi:new( { type = 2, });
    end
    if self.ui_hp then
        self.ui_hp:SetData(self);
        self:ShowHP(true);
    end
end

function SceneEntity:GetHpUi()
    return self.ui_hp;
end

-- 设置本对象的出场次序,暂时只有英雄用到～
function SceneEntity:SetMyIndex(index)
    self.index = index
end

function SceneEntity:GetMyIndex()
    return self.index
end

function SceneEntity:StartFight()
end

function SceneEntity:getLastMovePath()
    return self.last_move_dest_pos
end

function SceneEntity:checkLastMovePath(new_path_node, last_path_node)
    if #new_path_node == #last_path_node then
        for i=2, #new_path_node do
            if new_path_node[i].x ~= last_path_node[i].x or
                new_path_node[i].y ~= last_path_node[i].y then
                return false
            end
        end
        return true
    end
    return false
end

function SceneEntity:setLastMovePath(path_node)
    self.last_move_dest_pos = path_node
end

function SceneEntity:checkSameForWard(new_forward, last_forward)
    if new_forward == nil then
        return false
    end
    -- body
    -- app.log(string.format("向量对比 {%f, %f, %f}{%f, %f, %f}", self.last_move_forward.x, self.last_move_forward.y, self.last_move_forward.z,pos.x, pos.y,pos.z))
    if (last_forward.x == new_forward.x)
        and(last_forward.y == new_forward.y)
        and(last_forward.z == new_forward.z) then
        return true
    end
    return false
end


function SceneEntity:ChangeObject(obj, restart_dead)
    if self.finalized or(FightScene.GetFightManager() and FightScene.GetFightManager():IsFightOver()) then
        return
    end
    local pos = self:GetPosition()
    local forward = self:GetForWard()
    local size = self:GetScale();
    local old_navmesh_agent = false;
    local old_navmesh_obstacle = false;
    -- 需要将当前挂载的特效移出这个节点以外
    for k, v in pairs(self.mountingEffectList) do
        local ef = EffectManager.GetEffect(k);
        if ef then
            ef:set_parent(nil);
            ef:set_local_position(0, 10000, 0);
        end
    end
    self.mountingEffectList = { };
    if self.object then
        if self.navMeshAgent then
            old_navmesh_agent = self.navMeshAgent:get_enable()
        end
        ObjectManager.SetIid(self.object:get_instance_id(), nil);
        self.object:set_active(false)
        self:SetGameObjectParent(nil)
        self.object:destroy_object()
    end
    self.hpBarBindPos = nil
    self.bindNodeLookUp = { }
    self.object = asset_game_object.create(obj);
    self:SetAnimatorFile();

    ObjectManager.SetIid(self.object:get_instance_id(), self);
    if (self.objType == OBJECT_TYPE.HERO) then
        self:SetGameObjectParent(ObjectManager.heroRootAssert);
        self.object:set_layer(PublicStruct.UnityLayer.player, true);
    elseif (self.objType == OBJECT_TYPE.NPC) then
        self:SetGameObjectParent(ObjectManager.npcRootAssert);
        self.object:set_layer(PublicStruct.UnityLayer.npc, true);
    elseif (self.objType == OBJECT_TYPE.ITEM) then
        self:SetGameObjectParent(ObjectManager.itemRootAssert);
        self.object:set_layer(PublicStruct.UnityLayer.ground_item, true);
    elseif (self.objType == OBJECT_TYPE.MONSTER) then
        self:SetGameObjectParent(ObjectManager.monsterRootAssert);
        self.object:set_layer(PublicStruct.UnityLayer.monster, true);
    end
    self:SetName(self.name);
    if not self:IsItem() then
        self.navMeshObstacle = self.object:get_component_navmesh_obstacle()
    end
    self.navMeshAgent = self.object:get_component_navmesh_agent();
    if self.navMeshObstacle then
        self.navMeshObstacle:set_enable(false);
    end
    if self.navMeshAgent then
        self.navMeshAgent:set_speed(self:GetPropertyVal(ENUM.EHeroAttribute.move_speed));
        self.navMeshAgent:set_enable(false);

        if self.last_angular_speed then
            self.navMeshAgent:set_angular_speed(self.last_angular_speed);
        end
        --self.navMeshAgent:set_auto_braking(false)
        if self:GetState() == ESTATE.Run then
            self:GetAniCtrler().mCurtAni = EANI.stand
            self:SetExternalArea("lastMovePos", nil);
        end
    end
    -- self.navMeshAgent:set_enable(true);
    self:SetPosition(pos.x, pos.y, pos.z, true, false)
    -- self.navMeshAgent:set_enable(false);
    self:SetScale(size.x, size.y, size.z);
    -- if self.navMeshAgent then
    -- self.navMeshAgent:set_next_position(pos.x, pos.y, pos.z);
    -- end
    self.object:set_forward(forward.x, forward.y, forward.z)
    -- self:SetState(ESTATE.Stand)
    self.shineList = { };
    self.materialList = { };
    local modelConfig = ConfigManager.Get(EConfigIndex.t_model_list,self.config.model_id);
    if modelConfig and modelConfig.material_list ~= 0 then
        for k, v in pairs(modelConfig.material_list) do
			local itemname = nil;
			if v.list ~= nil then 
				itemname = v.list;
			elseif v.hz ~= nil then 
				itemname = v.hz;
			end 
            local shine = self.object:get_child_by_name(itemname);
            if shine then
                table.insert(self.materialList, shine);
                table.insert(self.shineList, ShineObj:new( { obj = shine, name = self.name }))
            end
        end
        self.shineList.shinePower = modelConfig.shine_power;
        self.shineList.shineReduce = modelConfig.shine_reduce;
    end
    if self:IsItem() then
        if self.is_item_open then
            self:PlayAnimate(EANI.stand)
            self:PlayAnimate(EANI.dead)
        end
    elseif self:IsDead() and not self:IsNpc() then
        self:SetState(ESTATE.Die)
        self:GetAniCtrler().mCurtAni = EANI.stand
        if restart_dead then
            self:PlayAnimate(EANI.die)
        else
            self:PlayAnimate(EANI.dead)
        end
    end
    if self:IsNpc() and self.config.model_id ~= 80002002 then
        timer.create(self.bindfunc["DelayPlayAni"], 1000, 1);
    end
    self:AddTriggerComponent()
    if self.cfg_effect_obj then
        self.cfg_effect_obj:set_parent(self.object);
    end
    --[[if g_dataCenter.fight_info:GetCaptainName() == self.name then
        g_dataCenter.player:SetCtrlHeroEffect(self)
    end]]
    if self.effectAperture then
        local parent = self:GetBindObj(3);
        self.aperture_manager:SetOpenNotMove(self.effectAperture, true, parent, nil, nil, nil, nil, nil, nil, nil, true, nil);
    end

    if self.navMeshAgent then
        if self.old_layer_mask then
            self.navMeshAgent:set_area_mask(self.old_layer_mask)
        end
    end

    if FightScene.GetFightManager() then
        FightScene.GetFightManager():OnEntityModelChanged(self)
    end
    if self.InvisiMateCfg then
        self.InvisibleMaterial = asset_game_object.find(self.name .. "/" .. self.InvisiMateCfg.mat_name);
        if self.InvisibleMaterial then
            self.InvisibleMaterial:set_active(false);
            self.InvisibleMaterial = self.InvisibleMaterial:get_material();
        end
    end
    if self:IsBasis() or self:IsBoss() then
        self:ShowRimLight(true)
        if not self.aperture_manager:IsNotMoveOpen(self._bossAperture) then
            self.aperture_manager:SetOpenNotMove(self._bossAperture, true, self:GetObject(), nil, nil, nil, nil, nil, nil, nil, true, nil)
        end
    end

    -- 影子
    self:CreateFastShadow()
    if self:IsNpc() and self._npcAperture then
        self.aperture_manager:SetOpenNotMove(self._npcAperture, true, self:GetObject(), nil, nil, nil, nil, nil, nil, nil, true, nil)
    end
    self.change_obj = true

    if self.hero_is_show == false then
        self:ShowHero(self.hero_is_show);
    else
        self:ShowHero(true);
    end

    if self:IsMonster() then
        FightScene.GetFightManager():MonsterLoadFinish(self);

        if self.viewRadiusEffectGids then
            self:UpdateViewAngleRangeEffect()
        end
    end

    self:EntityInit()
    if self._isTrigger then
        self:SetIsTrigger(self._isTrigger)
    end

    self:SetIsObstacle(self._objectIsObstacle)
    local oldShow = self._isShow
    self._isShow = nil
    self:Show(oldShow)

    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        return
    end
    if ObjectManager.GetHeroCount() > GameSettings.GetHeroRendererMaxCount() then
        if not self:IsMyControl() and not self:IsItem() and not self:IsNpc() and not self:IsMonster() then
            self:GetObject():set_render_enable(false, true)
        end
    end
end

function SceneEntity:SetNavMeshRadius()
    if self:IsSpecMonster() then return end
    
    local radius = nil
    local  type = 0
    if self:IsMonster() then
        radius = 0.4
        type = 4
    elseif self:IsHero() then
        radius = 0.1
    end

    if radius then
        if self.navMeshAgent then
            self.navMeshAgent:set_radius(radius)
            self.navMeshAgent:set_obstacle_avoidance_type(type)
        end
        if self.navMeshObstacle then
            self.navMeshObstacle:set_radius(radius)
        end
    end
end

function SceneEntity:GetIsObstacle()
    return self._objectIsObstacle
end

function SceneEntity:SetIsObstacle(is, updateCanAttack, ignoreAI)
    if is == nil then return end

    if updateCanAttack == nil then
        updateCanAttack = true
    end

    self._objectIsObstacle = is

    if self._objectIsObstacle then
        if self.navMeshObstacle then
            self:SetNavFlag(false, true)
            self.navMeshObstacle:set_carving(true)
        end
        
    else
        if self.navMeshObstacle then
            self.navMeshObstacle:set_carving(false)
            self:SetNavFlag(false, false)
        end

    end

    if updateCanAttack then
        self:SetCanBeAttack(not is, ignoreAI)
    end
end

function SceneEntity:GetCanBeAttack()
    return self:GetCampFlag() ~= g_dataCenter.fight_info.neutrality_flag
end

function SceneEntity:SetCanBeAttack(is, ignoreAI)
    if is ~= true then
        if self._beAttack_old_data == nil or self._beAttack_old_data.campFlag ~= g_dataCenter.fight_info.neutrality_flag then
            self._beAttack_old_data = {}
            self._beAttack_old_data.ai = self:GetAI()
            self._beAttack_old_data.campFlag = self:GetCampFlag()
        end

        if ignoreAI ~= true then
            self:CloseAI()
        end
        self:HideHP(true)
        self:SetCampFlag(g_dataCenter.fight_info.neutrality_flag)
    else
        if self._beAttack_old_data then
            if ignoreAI ~= true then
                self:SetAI(self._beAttack_old_data.ai)
            end
            self:SetCampFlag(self._beAttack_old_data.campFlag)
        end

        self:HideHP(false)
        self:ShowHP(true)
        self.object:set_layer(PublicStruct.UnityLayer.monster, true)
        if self.ui_hp then
            self.ui_hp:UpdateUi()
        end
    end
end

function SceneEntity:IsShow()
    return self._isShow
end

function SceneEntity:Show(is)
    if is == self._isShow then
        return 
    end

    self._isShow = is

    if not is then
        self.aniCtroller:RecordAnimatorInfo()
    end

    if self.object then
        self.object:set_active(is)
    else
        app.log_warning("destroy traceback:" .. tostring(self.destroyTraceback))
        app.log_warning("self.object is nil. name:"..tostring(self:GetName())..debug.traceback());
    end

    -- 一些地方显示了entity,但是不需要恢复ai，所以不能在Show函数内部暂停和恢复ai
    -- if not is then
    --     self:RemoveEvent(AIEvent.RESUME)
    --     self:PostEvent(AIEvent.PAUSE)
    -- end
    if --[[not self:IsMyControl() and]] self.aperture_manager then
        self.aperture_manager:ShowAperture(is)
    end
    if is then
        self.aniCtroller:PlayLastAni()
    end
end

function SceneEntity:DelayPlayAni()
    local cfg = self.config;
    if cfg.init_action then
        self:PlayAnimate(cfg.init_action);
    else
        self:PlayAnimate(EANI.npcstand);
    end
end

function SceneEntity:IsValid()
    return self.isReady
end

function SceneEntity:SetCaptain(is_captain)
    self.is_captain = is_captain
end

function SceneEntity:IsCaptain()
    return self.is_captain
end

function SceneEntity:Finalize()

    --self.destroyTraceback = debug.traceback()

    if self.isReady then
        self.isReady = false
    else
        app.log("name=" .. self.name .. " 对象重复释放: " .. debug.traceback())
        return
    end

    if self.triggerMgr then
        delete(self.triggerMgr)
        self.triggerMgr = nil
    end

    if self.beginAnimTimeId then
        timer.stop(self.beginAnimTimeId);
        self.beginAnimTimeId = nil;
    end

    -- self.object:disable_behavior();
    -- delete(self.aiData)
    -- self.aiData = nil
    if self.ai_fsm ~= nil then
        self.ai_fsm:Close()
        self.ai_fsm = nil
    end
    if self._buffManager then
        delete(self._buffManager)
        self._buffManager = nil
    end
    Root.DelLateUpdate(self.LateUpdate, self)
    mini_map.del_obj(self.object);
    FightMap.del_obj(self.object);
    -- 需要将当前挂载的特效移出这个节点以外
    for k, v in pairs(self.mountingEffectList) do
        local ef = EffectManager.GetEffect(k);
        if ef then
            ef:set_parent(nil);
            ef:set_local_position(0, 10000, 0);
        end
    end
    self.mountingEffectList = { };

    if self.object then
        self.object:set_active(false)
        self.object = nil;
    end
    self:unregistFunc()
    self.finalized = true

    self.mini_obj = nil
    self.fsm = nil
    self.aniCtroller = nil

    for i = 1, MAX_SKILL_CNT do
        if self._arrSkill[i] ~= nil then
            delete(self._arrSkill[i])
            self._arrSkill[i] = nil
        end
    end
    if self.aperture_manager then
        if self._bossAperture ~= nil then
            self.aperture_manager:DestroyNotMove(self._bossAperture)
            self._bossAperture = nil
        end
        delete(self.aperture_manager)
        self.aperture_manager = nil
    end
    if self.ui_hp then
        self.ui_hp:Destroy();
    end
    if self.ui_hp_new then
        delete(self.ui_hp_new);
        self.ui_hp_new = nil;
    end

    self:DestroyEscortHP()

    if self.mainNameUi then
        delete(self.mainNameUi);
        -- self.mainNameUi:DestroyUi();
        self.mainNameUi = nil;
    end
    if self.ui_speak_bubble then
        self.ui_speak_bubble:DestroyUi();
        self.ui_speak_bubble = nil;
    end
    self.ui_hp = nil
    self.killNum = 0;
    self.killAllNum = 0;
    if self.killTimer then
        timer.stop(self.killTimer);
        self.killTimer = nil;
    end
    self.object = nil
    mini_map.del_obj(self.object)

    if self.areaID then
        FightScene.area[self.areaID][self.name] = nil
    end


    if HUHU_AI then
        if self.aiForceBehaveTimer then
            timer.stop(self.aiForceBehaveTimer)
            self.aiForceBehaveTimer = nil
        end
    end
    delete(self._headInfoControler)
    self._headInfoControler = nil

    if self.effectID then
        for k, v in pairs(self.effectID) do
            EffectManager.deleteEffect(v)
        end
    end
    if self.shineList then
        for k, v in ipairs(self.shineList) do
            v:Destroy();
        end
        self.shineList = nil;
    end
    if self.materialList then
        for k, v in pairs(self.materialList) do
            self.materialList[k] = nil;
        end
        self.materialList = nil;
    end
    self.bindNodeLookUp = {}

    if self.cfg_effect_obj then
        EffectManager.deleteEffect(self.cfg_effect_obj:GetGID());
        self.cfg_effect_obj = nil;
    end

    ComptItem.Remove(self)
end

--[[ 战斗开始触发 ]]
function SceneEntity:OnFightStart()
    if self:GetTriggerManager() then
        return self:GetTriggerManager():OnEnterHurdleFight(FightScene.GetCurHurdleID());
    end
end

--[[ 刷怪器触发器 ]]
function SceneEntity:OnMonsterLoader(type, cur_groud, cur_wave)
    if self:GetTriggerManager() then
        return self:GetTriggerManager():OnMonsterLoader(type, cur_groud, cur_wave);
    end
end

function SceneEntity:OnFightOver(isWin)
    if self:GetTriggerManager() then
        self:GetTriggerManager():OnHurdleFightOver(FightScene.GetCurHurdleID(), isWin);
    end
    
    --战斗完成，清除多余的表现
    self:DestroyEscortHP()
end

function SceneEntity:OnFinishClearingTrigger()
    if self:GetTriggerManager() then
        self:GetTriggerManager():OnFinishClearingTrigger();
    end
end

function SceneEntity:AddTriggerComponent()
    if self.config.trigger_id and self.config.trigger_id ~= 0 then
        if TRIGGER_DEBUG then
            app.log('huhu_trigger_debug 生成触发器管理器 ' .. tostring(self.config.trigger_id) .. '\n' .. tostring(self:GetName()));
        end
        --初始化触发器
        self.triggerMgr = TriggerManager:new( { roleEntity = self, });
        self.triggerMgr:AddTrigger(self.config.trigger_id, self);
        --添加组件 
        ComptItem.Add(self.config.trigger_id, self)

        self.object:set_is_trigger(true)
    end
end

function SceneEntity:SetTrigger(obj)
    self.triggerObj = obj
end

function SceneEntity:HasTriggerEffect(effectName)
    local has = false
    local effects = nil
    if self.triggerMgr then
        has, effects = self.triggerMgr:HasTriggerEffect(effectName)
    end
    return has, effects
end

function SceneEntity:HasIdsTrigger(ids)
    if self.triggerMgr then
        return self.triggerMgr:HasIdsTrigger(ids)
    end

    return false
end

-- 获取相关



-- function SceneEntity:GetFollower()
--     local follower = PlayerManager.GetRole(self.follower)
--     return follower;
-- end
-- function SceneEntity:GetFollowTarget()
--     local followTarget = PlayerManager.GetRole(self.followTargetName)
--     return followTarget;
-- end
function SceneEntity:GetActionEffectCfg(action_id)
    app.log("SceneEntity:GetActionEffectCfg() is empty.")
    -- local model_id = self:GetModelID()
    -- -- TODO: 临时的， 需要重新规划特效表 key 值
    -- for k, v in pairs(gd_skill_effect) do
    --     if v.model_id == model_id and v.action_id == action_id then
    --         return v
    --     end
    -- end
    -- return nil
end

-- function SceneEntity:GetSkillEffectCfg()
--     local model_id = self:GetModelID()
--     local currSkill = self:GetCurSkill()

--     local skill_id = currSkill and currSkill.config.id or nil
--     for k, v in pairs(gd_skill_effect) do
--         if v.model_id == model_id and v.skill_id == skill_id then
--             return v
--         end
--     end
--     return nil
-- end

function SceneEntity:GetRunActionID()
    local model_id = self:GetModelID()
    if self.runActionId == nil then
        -- for k, v in pairs(gd_action_list) do
        for k, v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_action_list)) do
            if v.name == "run" then
                self.runActionId = v.id;
                break;
            end
        end
    end
    return self.runActionId;
end

function SceneEntity:GetRunActionEffectCfg()
    if self.runActionEffectCfg == nil then
        local runActionID = self:GetRunActionID();
        local modelID = self:GetModelID()
        self.runActionEffectCfg = ConfigHelper.GetSkillEffectByModelId(modelID, runActionID);
    end
    return self.runActionEffectCfg;
end


function SceneEntity:SetGameObjectParent(parentobj)
    -- huhu 设置unity对象的父节点。
    if self.object then
        self.object:set_parent(parentobj)
    end
end
function SceneEntity:SetName(name)
    if self.name and self.name ~= name then
        ObjectManager.ChangeObjName(self.name, name)
    end
    -- 设置物件名字
    self.name = name;
    if self.object then
        self.object:set_name(name);
    end
end

function SceneEntity:SetInstanceName(name)
    -- mapinfo 中的 obj_name
    self._instanceName = name
end

function SceneEntity:GetInstanceName()
    return self._instanceName
end

-- function SceneEntity:SetFollower(follower)
--     self.follower = follower;

--     if self.boss then
--         if self.follower then
--             AiMsg.TriggerMsgToFriend('be_follow_attacked', self, { self, })
--         else
--             AiMsg.TriggerMsgToFriend('be_follow_attacked_cancel', self, { self, })
--         end
--     end
-- end
-- function SceneEntity:SetFollowTarget(target)

--     if type(target) == type('') then
--         target = PlayerManager.GetRole(target)
--     end

--     local lastfollow = self:GetFollowTarget()
--     if lastfollow == target then
--         return
--     end
--     if lastfollow then
--         lastfollow:SetFollower(nil);
--     end

--     if not target then
--         self.followTargetName = nil
--     else
--         self.followTargetName = target:GetName()
--     end
--     local newfollow = self:GetFollowTarget()
--     if newfollow then
--         newfollow:SetFollower(self)
--     end
-- end

function SceneEntity:IsSuper()
    return self:IsCloseSuper() or self:IsFarSuper();
end
function SceneEntity:IsCloseSuper()
    return self.config.type == ENUM.EMonsterType.CloseSuper;
end
function SceneEntity:IsFarSuper()
    return self.config.type == ENUM.EMonsterType.FarSuper;
end
function SceneEntity:IsSoldier()
    return self:IsSoldierClose() or self:IsSoldierRnage();
end
function SceneEntity:IsSoldierClose()
    return self.config.type == ENUM.EMonsterType.SoldierClose;
end
function SceneEntity:IsSoldierRnage()
    return self.config.type == ENUM.EMonsterType.SoldierRnage;
end
function SceneEntity:IsPatrol()
    return self.config.type == ENUM.EMonsterType.Patrol;
end
function SceneEntity:IsBasis()
    return self.config.type == ENUM.EMonsterType.Basis;
end

function SceneEntity:IsBoss()
    return self.config.type == ENUM.EMonsterType.Boss or self.config.type == ENUM.EMonsterType.WorldBoss;
end

function SceneEntity:IsWorldBoss()
    return self.config.type == ENUM.EMonsterType.WorldBoss;
end

function SceneEntity:IsTower()
    return self.config.type == ENUM.EMonsterType.Tower;
end

function SceneEntity:IsSceneItem()
    return self.config.type == ENUM.EMonsterType.SceneItem
end

function SceneEntity:IsMonsterHero()
    return self.config.type == ENUM.EMonsterType.Hero;
end

function SceneEntity:IsBloodPool()
    return self.config.type == ENUM.EMonsterType.BloodPool;
end

function SceneEntity:GetSubType()
    return self.config.type;
end

--[[ 获取触发器管理器 ]]
function SceneEntity:GetTriggerManager()
    return self.triggerMgr;
end

-- 是不是死了就删除
function SceneEntity:IsDeleteOnDead()
    if self:IsHero() or (self:IsMonster() and self:GetType() == ENUM.EMonsterType.Hero) 
        or (self:IsMonster() and self:GetType() == ENUM.EMonsterType.NotRemoveItem) then
        return false
    end
    return true;
end

-- AI相关
function SceneEntity:PatrolType()
    -- 对象巡逻方式，暂时返回个1表示主动追击的。
    return 1;
end
function SceneEntity:GetAiDtTime()
    -- huhu 获取这个对象AI的更新频率
    return 2000
end
function SceneEntity:on_load_bt(pid, filepath, asset_obj, error_info)

    SceneEntity.ai_asset = asset_obj;

    -- app.log(self:GetName() .. "load ai complete...." .. tostring(asset_obj))
    --    self.object:set_extern_behavior(asset_obj);
    --    self.object:enable_behavior();
end

-- 用于英雄 手动操作和Ai自动控制之间切换

-- 属性相关

-- 判断我的某个属性是不是大于等于某个值
function SceneEntity:CheckPropertyMoreThen(property_type, val)
    local curval = self:GetPropertyVal(property_type);
    -- cur_hp要特殊处理一下，如果val是小数则表示达到多少百分比
    if property_type == 'cur_hp' then
        if val < 1 then
            curval = curval / self:GetPropertyVal('max_hp');
        end
    end
    if curval >= val then
        return true;
    else
        return false;
    end
end

--[[ 判断我的某个属性是不是小于等于某个值 ]]
function SceneEntity:CheckPropertyLessThen(property_type, val)
    local curval = self:GetPropertyVal(property_type);
    -- cur_hp要特殊处理一下，如果val是小数则表示达到多少百分比
    if property_type == 'cur_hp' then
        if val < 1 then
            curval = curval / self:GetPropertyVal('max_hp');
        end
    end
    if curval <= val then
        return true;
    else
        return false;
    end
end

-- 内部更新
function SceneEntity:UpdateBlood()
    -- 更新血条显示（切换操作角色时，血条颜色改变什么的）
    if self.ui_hp then
        self.ui_hp:UpdateUi();
    else
        app.log('self.ui_hp 为空！！！！' .. self:GetName())
    end
end

function SceneEntity:ShowName(isShow)
    if self.mainNameUi then
         app.log("name= "..self.name.."isShow="..tostring(isShow).." "..debug.traceback())
        self.mainNameUi:SetIsShow(isShow);
    end
end

function SceneEntity:GetBarBindPosInFrame()
    if self._update_sep ~= Root.GetLateFrameCount() then
        self._update_sep = Root.GetLateFrameCount()

        local fight_camera = CameraManager.GetSceneCamera();
        local ui_camera = Root.get_ui_camera();
        if fight_camera == nil or ui_camera == nil then
            return;
        end
        if not self.hasHpBarBindPos then
            --app.log("has no hp bar bind pos.");
            return
        end

        if self.hpBarBindPos == nil then
            self.hpBarBindPos = self:GetBindObj(10);

            if self.hpBarBindPos == nil then
                self.hasHpBarBindPos = false;
                return;
            else
                self.hasHpBarBindPos = true;
            end
        end

        local x, y, z = self.hpBarBindPos:get_position();
        if (type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number") then
            self.hpBarBindPos = nil
            return
        end

        --验证是否在摄像机内
        local vx,vy,vz = fight_camera:world_to_viewport_point(x,y,z)
        if vx>=0 and vx <=1 and vy>=0 and vy<=1 and vz>0 then
            self._is_in_camera = true

            local view_x, view_y, view_z = fight_camera:world_to_screen_point(x, y, z);
            local offset = CameraManager.offsetHp or -30;
            view_y = view_y + offset;
            local ui_x, ui_y, ui_z = ui_camera:screen_to_world_point(view_x, view_y, 0);

            self._bind_ui_x = ui_x
            self._bind_ui_y = ui_y
            self._bind_ui_z = ui_z
        else
            self._is_in_camera = false

            self._bind_ui_x = 0
            self._bind_ui_y = 0
            self._bind_ui_z = 0
        end
    end
    return self._is_in_camera, self._bind_ui_x, self._bind_ui_y, self._bind_ui_z;
end

function SceneEntity:LateUpdate()
    if not self.isReady then return end

    self:UpdateUiHpPos()
    -- 气泡验证
    self:UpdateBubbleUI();
end

function SceneEntity:UpdateUiHpPos()
    -- 最新的人物头顶字
    if self.ui_hp_new then
        self.ui_hp_new:OnTick();
    end

    if self.ui_escort_hp then
        self.ui_escort_hp:UpdateBlood();
    end

    if self.mainNameUi then
        self.mainNameUi:OnTick();
    end

    if self.ui_hp and self.ui_hp:IsShow() then
        if self.object and(self:IsNpc() or(not self:IsDead())) then

            local is_in_camera, x, y, z = self:GetBarBindPosInFrame()
            if is_in_camera == true then
                self.ui_hp:SetPosition(x, y + 0.1, 0);
                self.ui_hp:UpdateBlood();
            elseif is_in_camera == false then
                self.ui_hp:SetPosition(999,999,9);
            end
        else
            self:ShowHP(false)
            
            self.ui_hp:Show(false);
            -- if self.mainNameUi then
            --     self.mainNameUi:Hide();
            -- end
            if self.ui_speak_bubble then
                self.ui_speak_bubble:Show(false);
            end
        end
    end

end

function SceneEntity:UpdateBubbleUI(  )
    if self.ui_speak_bubble == nil then
        return;
    end
    
    local is_in_camera, x, y, z = self:GetBarBindPosInFrame()
    if is_in_camera == true then
        if self.ui_speak_bubble:GetIsShow() then
            local offset = 0.1

            if self:GetHPIsShow() then
                offset = offset + 0.1
            end
            
            self.ui_speak_bubble:SetPosition(x, y + offset, 0);
        end
    elseif is_in_camera == false then
        self.ui_speak_bubble:SetPosition(999, 999, 9);
    end
end

-- 事件相关
function SceneEntity:OnBeCurrentRole(last_role)
end
function SceneEntity:OnAppear()
    -- 出场
end
function SceneEntity:Stop()
    -- self:SetState(ESTATE.Stand)
end

-- 检查能否重生，以及重生方式
function SceneEntity:CheckReborn(reborn_time)

    -- 如果是英雄
    -- app.log('huhu_fight_debug 死亡后检查是不是可以注册个重生过程了！'..self:GetName()..debug.traceback())
    if not self._dontReBorn and self:IsHero() and self:IsMyControl() then
        local time = reborn_time or (self:GetRebornTime() or 1)
        -- -s
        if time == 0 then
            self:RebornTimeUp()
        else
            timer.create(self.bindfunc["RebornTimeUp"], 1000 * time, 1);
        end
        local mainui = GetMainUI()
        if mainui then
            mainui:RoleDead(self.name, time);
        end
        --PublicFunc.msg_dispatch(SceneEntity.CheckReborn, self.name, time)
    else
        local mainui = GetMainUI()
        if mainui then
            local time = reborn_time or self:GetRebornTime()
            mainui:RoleDead(self.name, time)
        end
    end
end

function SceneEntity:SetDontReborn(enable)
    self._dontReBorn = enable
end

function SceneEntity:GetDontReborn()
    return self._dontReBorn
end

function SceneEntity:SetRebornTime(time)
    self._reBornTime = time
end

function SceneEntity:GetRebornTime(time)
    return self._reBornTime
end


function SceneEntity:RebornTimeUp()
    -- AiMsg.TriggerMsg('time_in_dead', self)
    -- app.log('huhu_fight_debug 重生时间到了！'..self:GetName())
    self.can_reborn_now = self:IsDead() and true or false
    --[[local bRebornNow = false
    if self:IsMyControl() then
        if g_dataCenter.fight_info:IsInFight() then
            self.can_reborn_now = true
            bRebornNow = false
        else
            bRebornNow = true
        end
    else
        bRebornNow = true
    end
    -- 走重生逻辑
    if bRebornNow then
        self:Reborn();
    end]]
end

function SceneEntity:GetMyRebornPos()
    -- 场景类型判断
    local reborn_pos_x = 0;
    local reborn_pos_y = 0;
    local reborn_pos_z = 0;

    -- 出生点判断
    if FightScene.IsMobaHurdle() then
        local bornPoint =  self:GetBornPoint()
        if bornPoint then
            reborn_pos_x = bornPoint.x or 0
            reborn_pos_y = bornPoint.y or 0;
            reborn_pos_z = bornPoint.z or 0;
        end
    else
        local captaion = g_dataCenter.fight_info:GetCaptain()
        if captaion and not captaion:IsDead() then
            local pos = captaion:GetPosition()
            reborn_pos_y = pos.y
            reborn_pos_x = pos.x +((math.random() < 0.5) and -1 or 1);
            reborn_pos_z = pos.z +((math.random() < 0.5) and -1 or 1)
        else
            reborn_pos_x, reborn_pos_y, reborn_pos_z = self:GetPositionXYZ(true);
        end

    end
    return reborn_pos_x, reborn_pos_y, reborn_pos_z
end

--[[ huhu 获取本对象在配置里的id ]]
function SceneEntity:GetConfigNumber()
    return self.config.id;
end

function SceneEntity:GetConfigBigIcon()
    return self.config.small_icon;
end

--[[ huhu 获得对象在剧情对话当中的图标 ]]
function SceneEntity:GetTalkIcon()
    return self.config.head
end

function SceneEntity:GetDefaultRarity()
    return self.config.default_rarity
end



function SceneEntity:Reborn(x, y, z)
    -- AiMsg.TriggerMsg('reborn', self);
    self.lastSkillComplete = true;
    self.canSkillRotate = false
    self.after_comb_event = false
    self:SetExternalArea("skillChange", false)
    self:SetExternalArea("canSkillChange", false)
    self.can_reborn_now = false
    self:SetProperty('cur_hp', self:GetPropertyVal('max_hp'));
    local pos_x, pos_y, pos_z
    if x and y and z then
        pos_x = x
        pos_y = y
        pos_z = z
    else
        pos_x, pos_y, pos_z = self:GetMyRebornPos()
    end
    self.isSink = false;
    self:SetPosition(pos_x, pos_y, pos_z, true, true);
    self:SetState(ESTATE.Stand, true);
    self.object:set_collider_enable(true, false)
    self:SetHandleState(EHandleState.Idle, true)
    self:DisenableSkill(bit_merge(eSkillDisenableType.Normal, eSkillDisenableType.AllSkill), false)
    FightScene.GetFightManager():EntityReborn(self);
    if SceneManager.GetCurrentScene() == FightScene then
        if self.config.passive_buff_id ~= nil and self.config.passive_buff_id > 0 and self.config.passive_buff_lv ~= nil and self.config.passive_buff_lv > 0 then
            self:AttachBuff(self.config.passive_buff_id, self.config.passive_buff_lv, self:GetName(), self:GetName(), nil, 0, nil, 0, 0, 0, nil, nil, false, nil)
        end
        if self.config.restraint_buff_id and self.config.restraint_buff_id ~= 0 and
            self.config.restraint_buff_lv_set and self.config.restraint_buff_lv_set ~= 0 then
            for k, v in pairs(self.config.restraint_buff_lv_set) do
                self:AttachBuff(self.config.restraint_buff_id, v, self:GetName(), self:GetName(), nil, 0, nil, 0, 0, 0, nil, nil, false, nil)
            end
        end
        for i = 1, MAX_SKILL_CNT do
            if self._arrSkill[i] ~= nil then
                local passive_buff = GetSkillPassiveBuff(self._arrSkill[i]:GetSkillID())
                if passive_buff then
                    for k, v in pairs(passive_buff) do
                        self:AttachBuff(v.id, v.lv, self:GetName(), self:GetName(), nil, 0, nil, 0, 0, 0, nil, nil, false, nil)
                    end
                end
            end
        end
    end

    for i = 1, MAX_SKILL_CNT do
        local skill = self._arrSkill[i]
        if skill and skill:CheckCD() == eUseSkillRst.CD then
            skill:ClearCD()
        end
    end


    if self:IsHero() and self:IsMyControl() then
        GetMainUI():UpdateHeadData();
        self:UpdateBlood();
        -- app.log('huhu_fight_debug 复活更新血条！！！！！！'..self:GetName()..'\n'..tostring(self:GetPropertyVal('cur_hp'))..'/'..tostring(self:GetPropertyVal('max_hp')))
    end
    if GetMainUI() then
        GetMainUI():ClearReliveInfo(self:GetName())
    end

    if self:IsHero() then
        -- 播放复活特效
        self:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data,19006))
        NoticeManager.Notice(ENUM.NoticeType.HeroEntityReborn, self)
    end
end


-- 移动相关
function SceneEntity:NavMoveToPos(x, y, z)
    if self.object then
        local nav = self.object:get_component_navmesh_agent();
        if nav then
            self:SetNavFlag(true, false)
            PublicFunc.CheckCanUseNavMeshOperation(self, true)
            nav:set_destination(x, y, z);
            if self:GetState() == ESTATE.Stand then
                self:SetState(ESTATE.Run);
            end
        end
    end
end
function SceneEntity:Pursuit()
    self:SetState(ESTATE.Pursuit)
end
function SceneEntity:Follow()

end
function SceneEntity:Walk()

end
function SceneEntity:Move(x, y, z)
end
function SceneEntity:Escape()
end




function SceneEntity:FindNearestObject(atkLayerMask)
    atkLayerMask = PublicFunc.GetBitLShift( { atkLayerMask });
end
function SceneEntity:GetDistanceToEntity(sceneEntity)
    -- 得到自己与entity之间的距离
    local x, y, z = self.object:get_local_position();
    local dx, dy, dz = sceneEntity.object:get_local_position();
    local dis = algorthm.GetDistance(x, z, dx, dz);
    return dis;
end
function SceneEntity:GetDistanceToObject(Object)
    -- 得到自己与object之间的距离
    local x, y, z = self.object:get_local_position();
    local dx, dy, dz = Object:get_local_position();
    local dis = algorthm.GetDistance(x, z, dx, dz);
    return dis;
end
--



function SceneEntity:GetAroundRandomPos()
    local x, y, z = self.object:get_local_position();
    local x1 = x + math.random(-1, 1);
    local z1 = z + math.random(-1, 1);
    return x1, y, z1;
end



----------------------------------------------------------add by moba----------------------------------------------------

function SceneEntity:SetDiffDestination(cx, cy, cz, dis)
    local sx, sy, sz = self.object:get_local_position();
    local dirx = sx - cx;
    local dirz = sz - cz;
    local temp;
    dirx, temp, dirz = util.v3_normalized(dirx, 0, dirz)
    local positionList = ObjectManager.GetPositionDistance(cx, cz, dis, { x = dirx, z = dirz });
    -- app.log_warning("坐标    "..table.tostring(positionList));
    for k, v in pairs(positionList) do
        if ObjectManager.IsEmptyPosition(self.name, v.x, 0, v.z) then
            self:SetDestination(v.x, 0, v.z);
            break;
        end
    end
end

function SceneEntity:PlaySkill(is_force)
    local rst = nil
    if self.currSkillEx ~= nil then
        rst = SkillManager.UseSkill(self, self.currSkillEx, is_force)
    end
    self._skillAfterCanChange = falses

    if rst == eUseSkillRst.OK then
        --[[if self:IsMyControl() then
            app.log("id="..self.currSkillEx:GetID().." "..debug.traceback())
        end]]
        --self.bNotChangeSkillCombo = false
    end
    --[[if self:IsMyControl() then
        app.log(tostring(rst))
    end]]
    if rst and rst ~= eUseSkillRst.OK and rst ~= eUseSkillRst.CD and rst ~= eUseSkillRst.ProhibitSkill and rst ~= eUseSkillRst.NeedTarget and rst ~= eUseSkillRst.IsWorking and rst ~= eUseSkillRst.Expression and rst ~= eUseSkillRst.Deaded and rst ~= eUseSkillRst.Disenable then
        app.log("使用技能返回" .. rst)
    end
    self:RecordLastUseSkillTime()
    local bNeedFullProcess = true
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        if not self:IsMyControl() and not self:IsAIAgent() then
            bNeedFullProcess = false;
        end
    end

    if rst == eUseSkillRst.OK and self.skillForceComplete == false and bNeedFullProcess then
        self.lastSkillComplete = false
        self.can_combo = false
        self:SetExternalArea("canSkillChange", false)
        self:SetExternalArea("skillChange", false)
        self.canSkillRotate = self:GetCurSkill():IsCanRotate()
        if self.canSkillRotate then
            self:SetSlowRotation(self:GetRotation().y)
        end
    end
    self.skillForceComplete = false
    return rst
end


-- 死亡回调
function SceneEntity:OnDead(t)
    if self == g_dataCenter.player.lastShowObj then
        g_dataCenter.player:ShowAttackTargetEffects(nil, false)
    end
    self:ShowRimLight(false);
    if g_dataCenter.fight_info:GetCaptainName() == self:GetName() then
        GetMainUI():ClearSkillRefInfo(self)
        AudioManager.StopUiAudio(ENUM.EUiAudioType.Heartbeat)
    end
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        for k, v in pairs(self.taunt_list) do
            local taunter = ObjectManager.GetObjectByGID(k)
            if taunter then
                taunter:DetachBuff(taunter:GetBuffManager()._tauntBuffID, taunter:GetBuffManager()._tauntBuffLv, false)
                taunter:PostEvent("FinishBeTaunt")
            end
        end
        self.taunt_list = {}
    end
    if self.OnDeadCallBack ~= nil then
        Utility.CallFunc(self.OnDeadCallBack, self, ObjectManager.GetObjectByName(self:GetKillerName()))
    end
    if g_dataCenter.player:GetCurCtrlHero() == self:GetName() then
        g_dataCenter.player:SetCurCtrlHero("")
    end

    if self.aperture_manager then
        self.aperture_manager:SetAttackAperture(false);
        self.aperture_manager:SetOpenNotMove(self._bossAperture, false)
    end

    if self:IsTower() then
        if self._towerAttackTarget then
            self:ShowTowerLockTarget(self._towerAttackTarget, false)
        end

        self:DestroyTowerAreaEffect()
        self._towerAreaType = nil
    end

    if self._beTowerAttacker then
        self:DestroyTowerLockEffect()

        local tower = nil
        for k, v in pairs(self._beTowerAttacker) do
            tower = ObjectManager.GetObjectByName(k)
            if tower then
                tower._towerAttackTarget = nil
            end
        end
        self._beTowerAttacker = nil
    end

    -- 检查重生
    self:CheckReborn();

    -- 恢复宇井郡技能3记录的属性
    local recordname = "yjj_skill3";
    local recordvalue = self:GetExternalArea(recordname) or 0;
    self:SetExternalArea(recordname, 0);
    self:GetBuffManager():ChangeAbility("def_power", recordvalue);

    -- Fight.OnSomeOneDead(self);
    FightScene.GetFightManager():OnEvent_ObjDead(ObjectManager.GetObjectByName(self:GetKillerName()), self)
    if self._buffManager then
        self._buffManager:CheckRemove(eBuffPropertyType.RemoveOnDead)
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
    end
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        if self:IsDeleteOnDead() then
            -- 延迟删除对象
            SetTimer(7, 1, FightScene.DeleteObj, self:GetName(), 0)
        end
        --[[if not self:IsHero() then
            self.isSink = true;
            self.sinkStartTime = os.clock() + 5;
            self.sinkEndTime = self.sinkStartTime + 1;
            self.navMeshAgent:set_enable(false);
        end]]
    end

    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss or
       FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss then
        if self:IsHero() then
            if self.ui_hp_new then
                self.ui_hp_new:SetIsShow(false);
            end

            -- if g_dataCenter.fight_info:GetCaptain() ~= self or g_dataCenter.fight_info:GetAliveCaptaion() then
                self.isSink = true;
                self.sinkStartTime = os.clock() + 2;
                self.sinkEndTime = self.sinkStartTime + 2;
                self.navMeshAgent:set_enable(false);
            -- end
        end
    end

    --if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil ]] then
    if g_dataCenter.fight_info:GetCaptain() == self then
        local index = g_dataCenter.fight_info:GetAliveCaptaion()
        if index ~= nil then
            g_dataCenter.player:ChangeCaptain(index, true)
        end
    end
    --end
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
        self:ClearFightStateTarget(true, true, "死亡")
        self:ClearFightStateTarget(false, true, "死亡")
    end

    if FightScene.GetFightManager() then
        FightScene.GetFightManager():OnDead(self);
    end

    local audio_id = self:GetConfig("dead_voice_id")
    if audio_id and audio_id ~= 0 then
        AudioManager.PlayUiAudio(audio_id)
    end

    if self.host_gid then 
        local host = ObjectManager.GetObjectByGID(self.host_gid)
        if host then
            if self.dead_attach_host_buff then
                host:AttachBuff(self.dead_attach_host_buff[1], self.dead_attach_host_buff[2], host:GetName(), host:GetName(), nil, 0, nil, 0, 0, nil, nil)
            end
            host:DelSummonMonster(self:GetName())
        end
    end
    for i = 1, MAX_SKILL_CNT do
        local skill = self._arrSkill[i]
        if skill and skill:CheckCD() == eUseSkillRst.CD then
            skill:ClearCD()
        end
    end
    self:DisenableSkill(bit_merge(eSkillDisenableType.Normal, eSkillDisenableType.AllSkill), true);

    if self.ui_speak_bubble then
        self.ui_speak_bubble:Show(false);
    end
end

--type  见eSkillDisenableType组合
function SceneEntity:DisenableSkill(type, disenable, skillid)
    local is_normal = (bit.bit_and(type, eSkillDisenableType.Normal) ~= 0)
    local is_all_skill = (bit.bit_and(type, eSkillDisenableType.AllSkill) ~= 0)
    local is_single_skill = (bit.bit_and(type, eSkillDisenableType.SingleSkill) ~= 0)
    if self:IsMyControl() then
        for i = 1, MAX_SKILL_CNT do
            if self._arrSkill[i] ~= nil then
                local effect = false
                if is_normal then
                    if self._arrSkill[i]:GetSkillType() == eSkillType.Normal then
                        effect = true
                    end
                end
                if is_all_skill then
                    if self._arrSkill[i]:GetSkillType() ~= eSkillType.Normal then
                        effect = true
                    end
                elseif is_single_skill then
                    if self._arrSkill[i]:GetSkillID() == skillid then
                        effect = true
                    end
                end
                if effect then
                    self._arrSkill[i]:SetDisenable(disenable)
                end
            end
        end
        if GetMainUI() and g_dataCenter.fight_info:GetCaptain() == self then
            GetMainUI():UpdateSkillIcon(self)
        end
    end
end

function SceneEntity:CheckAttribute()
    self.attribute_verify = true
end

function SceneEntity:Update(deltaTime)
    if not self.isReady then return end

    if self._buffManager then
        if self._buffManager._bUpdateProperty and self:IsDead() == false then
            self:UpdateProperty(false)
            self._buffManager._bUpdateProperty = false
        end
        if FightScene.GetFightManager():IsFightOver() then
            self.buff_manager_tick_count =  self.buff_manager_tick_count - 1;
        end
        if self.buff_manager_tick_count >= 0 then
            self._buffManager:OnTick()
        end
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
    end

    if self.aniCtroller then
        self.aniCtroller:OnTick()
    else
        return
    end
    if not self._headInfoControler then
        return
    end
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        if not self:IsDead() and FightScene.GetFightManager() and not FightScene.GetFightManager():IsFightOver() then
            self.one_sec_accumulator = self.one_sec_accumulator + deltaTime
            if self.one_sec_accumulator > 1 then
                self.one_sec_accumulator = self.one_sec_accumulator - math.floor(self.one_sec_accumulator)
                local res_hp = self:GetPropertyVal(ENUM.EHeroAttribute.res_hp)
                if res_hp > 0 then
                    if self:GetPropertyVal(ENUM.EHeroAttribute.cur_hp) < self:GetPropertyVal(ENUM.EHeroAttribute.max_hp) then
                        local _property_ratio = ConfigManager.Get(EConfigIndex.t_property_ratio, 1)
                        local res_hp = self:GetPropertyVal(ENUM.EHeroAttribute.max_hp) * (res_hp/(res_hp+_property_ratio.res_hp_ratio));
                        res_hp = PublicFunc.AttrInteger(res_hp)
                        self:OnGainHP(res_hp)
                    end
                end
            end
        end
    end
    self._headInfoControler:OnTick()

    self:CheckToChangeAI()
    if self.last_use_normal_skill_time and PublicFunc.QueryDeltaTime(self.last_use_normal_skill_time) >= SkillManager.normal_skill_reset_time then
        self.normalAttackIndex = 1
        self.last_use_normal_skill_time = nil
    end
    if self.ai_fsm then
        --util.begin_sample('ai_fsm:Update')
        -- util.begin_sample('ai_fsm:Update ' .. self:GetName())
        self.ai_fsm:Update(deltaTime)
        -- util.end_sample()
        --util.end_sample()
    end
    if self.start_path_finding and self.change_obj then
        local des_world_id = g_dataCenter.autoPathFinding.des_world_id;
        local des_x = g_dataCenter.autoPathFinding.des_x;
        local des_y = g_dataCenter.autoPathFinding.des_y;
        local des_z = g_dataCenter.autoPathFinding.des_z;
        local cur_world_id = FightScene.GetStartUpEnv().levelData.hurdleid;
        g_dataCenter.autoPathFinding:StartPathFinding(self, cur_world_id, des_world_id, des_x, des_y, des_z);
        self.start_path_finding = false;
    end
    if self.fsm then
        self.fsm:Update(deltaTime)
        -- 	self:RepelUpdate()
    end

    if self.canSkillRotate and self._slowRotation then
        local rotate = self:GetRotation()
        local speed = 6
        if self._slowRotation > rotate.y then
            if self._slowRotation - rotate.y > 180 then
                speed = - speed
            end
            if rotate.y + speed > self._slowRotation then
                rotate.y = self._slowRotation
                self._slowRotation = nil
            else
                rotate.y = rotate.y + speed
            end

        else
            if rotate.y - self._slowRotation > 180 then
                speed = - speed
            end
            if rotate.y - speed < self._slowRotation then
                rotate.y = self._slowRotation
                self._slowRotation = nil
            else
                rotate.y = rotate.y - speed
            end
        end
        if rotate.y < 0 then
            rotate.y = 360 + rotate.y
        elseif rotate.y > 360 then
            rotate.y = rotate.y - 360
        end
        self:SetRotation(0, rotate.y, 0)
    end
    self:PosMoveUpdate(deltaTime);
    self.aperture_manager:UpdateNotMovePos();
    -- self:UpdateUiHpPos()
    if self.aperture_manager and g_dataCenter.fight_info:GetCaptainName() == self.name then
        self.aperture_manager:MovePos(deltaTime)
    end
    -- 死亡下沉效果
    if self.isSink then
        local curTime = os.clock();
        if curTime > self.sinkStartTime then
            local pos = self:GetPosition();
            self:SetPosition(pos.x, pos.y - 0.05, pos.z, true, false);
        end
        if curTime > self.sinkEndTime then
            self.isSink = false;
        end
    end
    if self:GetExternalArea("wait_idle") then
        if PublicFunc.QueryCurTime() > self:GetExternalArea("idle_time") then
            self:SetExternalArea("wait_idle", false)
            self:PlayAnimate(EANI.idle)
        end
    end
    -- 角色高亮效果
    for k, v in ipairs(self.shineList) do
        v:TimeUpdate();
    end
    if self:IsMonster() and (not self.hide_hp) then
        local captaion = g_dataCenter.fight_info:GetCaptain()
        if captaion then
            local my_pos = self:GetPosition()
            local cap_pos = captaion:GetPosition()
            local dis = algorthm.GetDistanceSquared(my_pos.x, my_pos.z, cap_pos.x, cap_pos.z);
            if dis <= PublicStruct.Const.SHOW_MONSTER_HP_RADIUS*PublicStruct.Const.SHOW_MONSTER_HP_RADIUS then
                self:ShowHP(true)
            else
                self:ShowHP(false)
            end
        end
    end

    if self.triggerMgr then
        self.triggerMgr:Update(deltaTime)
    end

    local curClock = os.clock();
    --[[if self.aperture_manager and self.showChangeTargeEffect and self.showChangeTargeEffect + 0.5 < curClock then
        self.aperture_manager:SetOpenNotMove(self.aperture_manager.changeTargetHeadEffect, false, nil, 0, 0, 0, 1, 1);
        self.showChangeTargeEffect = nil;
    end]]
end

-- 动作相关
function SceneEntity:PlayAnimate(id, event)
    --[[if id == EANI.stand then
        app.log(debug.traceback())
    end]]
    if (self:IsMonster() or self:IsHero()) and
        self:IsDead() and id ~= EANI.die and id ~= EANI.dead then
        return
    end
    self.aniCtroller:SetAni(id, event)
end

function SceneEntity:AnimatorPlay(name)
    if self.aniCtroller then
        self.aniCtroller:AnimatorPlay(name)
    end
end

function SceneEntity:AnimatorHasState(name)
    return self.object:animator_has_state(name)
end

function SceneEntity:AnimationPlay(name)
    if self.aniCtroller then
        self.aniCtroller:AnimationPlay(name)
    end
end

function SceneEntity:SetAnimate(id, event, cbfunction, cbdata, target, lock, skill_id, src_buff, src_trigger)
    self.aniCtroller:SetAniEx(id, event, cbfunction, cbdata, target, lock, skill_id, src_buff, src_trigger)
end

function SceneEntity:SetHide(bHide)
    if bHide then
        -- app.log("隐身开启")
        if self:IsMyControl() then
            if self.InvisiMateCfg then
                local body = asset_game_object.find(self.name .. "/" .. self.InvisiMateCfg.body);
                local cfg = self.InvisiMateCfg.invisi_after;
                self.materialCfg = { };
                if body and cfg then
                    for i, info in pairs(cfg) do
                        for k, v in pairs(info) do
                            if k == "_ViewColor" or k == "_Color" then
                                local r, g, b, a = body:get_material_color_with_name(k);
                                self.materialCfg[k] = { r, g, b, a };
                                if tonumber(v[1]) ~= -1 then
                                    r = v[1] / 255;
                                end
                                if tonumber(v[2]) ~= -1 then
                                    g = v[2] / 255;
                                end
                                if tonumber(v[3]) ~= -1 then
                                    b = v[3] / 255;
                                end
                                if tonumber(v[4]) ~= -1 then
                                    a = v[4] / 255;
                                end
                                body:set_material_color_with_name(k, r, g, b, a);
                            else
                                self.materialCfg[k] = body:get_material_float_with_name(k);
                                body:set_material_float_with_name(k, tonumber(v));
                            end
                        end
                    end
                end
                local hezi = asset_game_object.find(self.name .. "/" .. self.InvisiMateCfg.hezi);
                if hezi then
                    if not self.oldMate then
                        self.oldMate = hezi:get_material();
                    end
                    if self.InvisibleMaterial then
                        hezi:set_material(self.InvisibleMaterial);
                    end
                end
            end
        else
            self:ShowHP(false);
            if self.ui_hp_new then
                self.ui_hp_new:SetIsShow(false);
            end
            self:ShowHero(false)
        end
    else
        -- app.log("隐身关闭")
        if self:IsMyControl() then
            if self.InvisiMateCfg then
                local body = self.object:get_child_by_name(self.name .. "/" .. self.InvisiMateCfg.body);
                -- local cfg = self.InvisiMateCfg.invisi_before;
                -- for i,info in pairs(cfg) do
                --     for k,v in pairs(info) do
                for k, v in pairs(self.materialCfg) do
                    if k == "_ViewColor" or k == "_Color" then
                        body:set_material_color_with_name(k, tonumber(v[1]), tonumber(v[2]), tonumber(v[3]), tonumber(v[4]));
                    else
                        body:set_material_float_with_name(k, tonumber(v));
                    end
                    -- end
                end
                self.materialCfg = nil;
                local hezi = asset_game_object.find(self.name .. "/" .. self.InvisiMateCfg.hezi);
                if hezi then
                    hezi:set_material(self.oldMate);
                end
            end
        else
            self:ShowHero(true)
            if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_openWorld then
                self:ShowHP(true);
            end
        end
    end
    self._bHide = bHide
end

function SceneEntity:IsHide()
    return(self._bHide == true)
end

--[[ 播放特效 ]]
-- event 特效配置
-- cbfunction 回调函数,默认nil
-- cbdata 回调函数,默认nil
-- target 目标,默认nil
-- direct 方向,默认nil
-- durationTime 持续时间, nil默认时间, 0循环, 其余指定时间
-- hitedinfo 击中信息,默认为nil,包含attacker、target
function SceneEntity:SetEffect(src_obj_name, cfg, cbfunction, cbdata, target, direct, durationTime, hitedinfo, collisioninfo, handlehit, skill_id, end_pos, use_time)
    local uuid = { }
    local uuid_index = 1
    if type(cfg.id) == "table" then
        local eventCfg = { }
        for i = 1, #cfg.id do
            eventCfg.type = cfg.type
            eventCfg.id = cfg.id[i]
            eventCfg.pos = cfg.pos[i]
            eventCfg.offset = cfg.offset[i]
            eventCfg.bind = cfg.bind[i]
            eventCfg.speed = cfg.speed
            eventCfg.maxlen = cfg.maxlen
            eventCfg.hited_effect_seq = cfg.hited_effect_seq
            eventCfg.hited_action_seq = cfg.hited_action_seq
            eventCfg.hited_repel_dis = cfg.hited_repel_dis
            eventCfg.description = cfg.description
            eventCfg.angle = cfg.angle
            --[[if not self:IsMyControl() then
                app.log("添加特效id="..eventCfg.id)
            end]]
            local effect_gid = EffectManager.SetEffect(self, src_obj_name, eventCfg, cbfunction, cbdata, target, direct, durationTime, hitedinfo, collisioninfo, handlehit, skill_id, end_pos, use_time)
            uuid[uuid_index] = effect_gid
            uuid_index = uuid_index + 1
            local isSelfEffect = self:IsMyControl() or self:IsAIAgent()
            --            local effInfo = EffectManager.GetEffect(effect_gid)
            --            effInfo:SetIsSelfEffect(isSelfEffect)
            --            if effect_gid and effect_gid ~= -1 then
            --                EffectManager.SetIsSelfEffect(effect_gid, isSelfEffect)
            --            end
        end
    else
        --[[if not self:IsMyControl() then
            app.log("添加特效id="..cfg.id)
        end]]
        local effect_gid = EffectManager.SetEffect(self, src_obj_name, cfg, cbfunction, cbdata, target, direct, durationTime, hitedinfo, collisioninfo, handlehit, skill_id, end_pos, use_time)
        uuid[1] = effect_gid
        local isSelfEffect = self:IsMyControl() or self:IsAIAgent()
        --        local effInfo = EffectManager.GetEffect(effect_gid)
        --        effInfo:SetIsSelfEffect(isSelfEffect)
        --        if effect_gid and effect_gid ~= -1 then
        --            EffectManager.SetIsSelfEffect(effect_gid, isSelfEffect)
        --        end
    end
    return uuid
end

function SceneEntity:onAniCollideTarget()
end

function SceneEntity:GetHeadInfoControler()
    return self._headInfoControler
end

function SceneEntity:GetShowComboAttacker()
    local cap = FightManager.GetMyCaptain()
    if cap then
        return cap
    end

    local aliveIndex,aliveObj = g_dataCenter.fight_info:GetAliveCaptaion()
    if aliveObj then
        return aliveObj
    end
end

function SceneEntity:OnGainHP(hp, attacker, bCrit, skill_id)
    if FightScene.GetFightManager() and FightScene.GetFightManager():IsFightOver() then
        return
    end

    if attacker then
        --记录被攻击
        FightRecord.SetIsAttack(attacker:GetConfigNumber());
    end

    hp = PublicFunc.AttrInteger(hp);
    if hp < 0 then
        if attacker and attacker:GetName() ~= self.name then
            self._AttackerName = attacker:GetName();
            self:OnHitted()
        end
        if self._buffManager then
            if self._buffManager._buffID2AttachWhenGainHP ~= 0 and self._buffManager._buffLv2AttachWhenGainHP ~= 0 then
                self:AttachBuff(self._buffManager._buffID2AttachWhenGainHP, self._buffManager._buffLv2AttachWhenGainHP, self:GetName(), self:GetName(), nil, 0, nil, 0, 0, 0, nil, nil, false, nil)
            end
        else
            app.log_warning("buffManager=nil " .. debug.traceback())
        end
        --显示连击数
        --if attacker and self:GetShowComboAttacker() == attacker --[[attacker:IsMyControl()]] then
        --    HeadInfoControler.ShowCombo()
        --    g_dataCenter.player:ShowAttackEffect(self,system.time());
        --end
    end
    
    --hp = -1;
    --[[if self:IsMonster() then
        if self:IsBoss() then
            hp = -1
        else
            hp = -1000
        end
    else
        hp = -1
    end]]
    -- if attacker and FightManager.GetMyCaptain() == attacker then
    --     hp = -1000
    -- else
    --     hp = -1
    -- end
    --[[if self:GetCampFlag() == 2 then
        app.log("hp="..self:GetPropertyVal(ENUM.EHeroAttribute.cur_hp))
    end]]
    -- -- TODO:(kevin) hp test.
    --[[if self:GetCampFlag() == 1 and self.name ~= g_dataCenter.fight_info:GetCaptainName() then
         hp = -1000;
    end]]
    -- if hp < 0 then
    --     if self:GetCampFlag() == 2 then
    --         hp = -10000
    --         --self:SetHP(0);
    --     else
            -- hp = -1
    --         --hp =0;
    --     end
    -- end
    
    -- 血条需要改到具体的fightmanager去处理
    -- if self:GetCampFlag() == 1 then
    --     hp = 0;
    -- else
    --    self:SetHP(0);
    -- end
    --[[if self:GetCampFlag() == 1 then
        hp = -1
    else
        hp = -100000
    end]]

    if hp < 0 then
        --app.log(self.name.." hp="..hp)
        FightScene.GetFightManager():MonsterBloodReduce(self, attacker)
    end
    -- if hp < 0 and self:IsBoss() and GetMainUI() then
    --     GetMainUI():InitBosshp(2, self:GetName());
    -- end

    local curPlayer = FightManager.GetMyCaptain();
	local c_hp  = self:GetHP()
    repeat 
        if GuideManager.IsGuideRuning() then
            local hp_limit = self:GetPropertyVal(ENUM.EHeroAttribute.max_hp)*0.2;
            if hp_limit >= c_hp+hp 
            and FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_arena 
            and FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao 
            and (self:IsMyControl() or self.ui_escort_hp) then
                self:SetHP(hp_limit);
                break;
            end
        end
        self:ChangeHP(hp)
    until true
	local notify_hp = c_hp-self:GetHP()
    FightScene.GetFightManager():OnEvent_OnInjured(self, attacker,notify_hp) 

    self:CalHatredValue(attacker, notify_hp)
    
    
    if hp < 0 and attacker ~= nil then
        local curPlayer = FightManager.GetMyCaptain();
        if curPlayer then
            if self ~= curPlayer and attacker.name == curPlayer.name then
                --            if bCrit then
                --                self._headInfoControler:ShowCrit()
                --            end
                -- 播放受击高亮   被主角攻击的怪
                if self:IsMonster() then
                    self:PlayShine()
                end
            elseif self.name == curPlayer.name then
                --self:PlayShine();
            end
        end
    end
    local skill_info = ConfigManager.Get(EConfigIndex.t_skill_info, skill_id)

    if self._headInfoControler:Check(attacker) then
        self._headInfoControler:ShowHP(hp, bCrit,(skill_info and (skill_info.type ~= eSkillType.Normal) or false))
    -- else
    --     -- 巅峰展示特殊处理，显示全部怪物掉血
    --     local fightManager = FightScene.GetFightManager()
    --     if fightManager and fightManager._className == "ArenaFightManager" then
    --         self._headInfoControler:ShowHP(hp, bCrit,(skill_info and (skill_info.type ~= eSkillType.Normal) or false))
    --     end
    end

    if GetMainUI() and self:IsHero() then
        GetMainUI():TeamHeroProChanged()
    end

    if GetMainUI() and self:IsMyControl() then
        GetMainUI():UpdateHeadData();
    end
    --[[if self:GetCampFlag() == 1 and self.boss == true then
        FightUI.UpdateHeadData();
    end]]
    if self:GetHP() <= 0 then
        if self._buffManager then
            if self._buffManager._immortal == true then
                self:SetHP(1)
                return;
            end
        else
            app.log_warning("buffManager=nil " .. debug.traceback())
        end
        self:SetHP(0)
        if attacker then
            if skill_id then
                local skill_info = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id);
                if skill_info
                    and skill_info.repel_dis ~= 0
                    and self:IsMonster()
                    and attacker:GetName() == FightManager.GetMyCaptainName()
                then
                    local pos = self:GetPositionV3d();
                    local attacker_pos = attacker:GetPositionV3d();
                    local vec = pos:RSub(attacker_pos);
                    vec = vec:RNormalize();
                    if vec then
                        local dis = skill_info.repel_dis;
                        vec = vec:RScale(dis);
                        vec = vec:RAdd(self:GetPositionV3d());
                        self:PosMoveToPos(nil, vec._x, vec._y, vec._z, 100);
                    end
                end
            end
            self._killer = attacker:GetName()
            attacker:SetAttackTarget(nil)
            if attacker:GetBuffManager()._killTargetAddBuffID and attacker:GetBuffManager()._killTargetAddBuffLv then
                if attacker:GetBuffManager()._killTargetAddBuffSkillID == nil or attacker:GetBuffManager()._killTargetAddBuffSkillID == skill_id then
                    local buffID = attacker:GetBuffManager()._killTargetAddBuffID
                    local buffLv = attacker:GetBuffManager()._killTargetAddBuffLv
                    local overlap = 1
                    if self:IsHero() then
                        overlap = attacker:GetBuffManager()._killTargetHeroAddBuffOverLap
                    elseif self:IsBoss() then
                        overlap = attacker:GetBuffManager()._killTargetBossAddBuffOverLap
                    else
                        overlap = attacker:GetBuffManager()._killTargetNotBossAddBuffOverLap
                    end
                    attacker:AttachBuff(buffID, buffLv, attacker.name, attacker.name, nil, 0, nil, 0, 0, 0, nil, nil, false, overlap)
                end
            end
            -- attacker:SetHandleState(EHandleState.Idle)

            
        end

        -- 移到 MainUITeam:CaptainOnDead
        --        if FightScene.GetPlayMethodType() == nil then
        --            if self.name == g_dataCenter.fight_info:GetCaptainName() then
        --                for i=1, 3 do
        --                    if g_dataCenter.fight_info.control_hero_list[i] and g_dataCenter.fight_info.control_hero_list[i] ~= self.name then
        --                        local follower = ObjectManager.GetObjectByName(g_dataCenter.fight_info.control_hero_list[i])
        --                        if follower then
        --                            follower:SetHP(0)
        --                            follower:SetHandleState(EHandleState.Die)
        --                        end
        --                    end
        --                end
        --            end
        --        end
        self:SetHandleState(EHandleState.Die)

        -- if self:GetHP() <= 0 then
        --     FightScene.GetFightManager():OnEvent_ObjDead(attacker, self)
        -- end
        -- -
    end

    if self.minHP == nil or self.minHP > self:GetHP() then
        self.minHP = self:GetHP()
    end
    
    
    
    
end

function SceneEntity:SetKillerName(name)
    self._killer = name
end

function SceneEntity:GetKillerName()
    return self._killer
end

function SceneEntity:onAniAttackEnd(aniName)
    self.wait_finish_skill = nil
    self.lastSkillComplete = true;
    self.canSkillRotate = false
    self.after_comb_event = false
    if not self._skillAfterCanChange then
        self:SetExternalArea("skillChange", false)
        self:SetExternalArea("canSkillChange", false)
    end
    self.behitFinish = true;
    -- app.log("xxxxxxxxxxxxxxx--end"..self:GetName());
    -- local target = self:GetAttackTarget()
    -- if target then
    --    target:onAniBeHitedEnd();
    -- end
    if not self:IsMyControl() and not self:IsAIAgent() then
        if self:GetState() ~= ESTATE.Run and self:GetState() ~= ESTATE.Die and self:GetState() ~= ESTATE.Dead then
            if self:GetState() ~= ESTATE.Stand then
                self:SetState(ESTATE.Stand)
            else
                self:PlayAnimate(EANI.stand);
            end
        end
    else
        if self:GetState() ~= ESTATE.Die and self:GetState() ~= ESTATE.Dead then
            self:GetAniCtrler():SetAni(EANI.stand)
        end
    end
    if GetMainUI() and GetMainUI():GetJoystick() and GetMainUI():GetJoystick().touch_move_begin then
        if self:GetName() == g_dataCenter.fight_info:GetCaptainName() then
            self:SetHandleState(EHandleState.Move)
        end
    end
end

function SceneEntity:onAniBeHitedEnd(aniName)
    self.lastSkillComplete = true;
    self.canSkillRotate = false
    self.behitFinish = true;
    do return end

    if self:GetHP() < 1 then
        local attacker_name = self:GetAttacker()
        if nil == attacker_name then
            attacker_name = "null"
        end
        -- app.log("我被打死了~~~~~~~~~~");
        app.log(string.format("%s 被 %s 打死了 %s", self:GetName(), attacker_name, debug.traceback()))
        self.killAllNum = 0;
        self:SetState(ESTATE.Die)
    else
        self:SetState(ESTATE.Stand)
        app.log(string.format("%s has %d hp left.", self:GetName(), self:GetHP()))
    end
end

-- 当动作进行到这一帧，再按按钮，就可以连击
function SceneEntity:onAniAttackCanCombo(aniName)
    self.can_combo = true;
    self.after_comb_event = false
end

function SceneEntity:UseComboSkill()
    local target = nil
    local target_name = nil
    if self:IsMyControl() then
        target = self:GetAttackTarget()
    end
    if (target ~= nil) then
        target_name = target:GetName()
    end
    if self._lastSkillTarget ~= target_name or (target == nil) or (target and target:IsDead()) then
        self.new_attack_state_check = true
        local retState, retDestination, retTarget, retNeedChangeTarget = self:CheckAttackState()
        if retTarget then
            self:SetAttackTarget(retTarget)
            if retState == ESTATE.Run then
                return
            end
            self._lastSkillTarget = retTarget:GetName()
        else
            if not self:IsMyControl() then
                return
            elseif self:IsMyControl() and g_dataCenter.player:CaptionIsAutoFight() then
                return
            end
        end
    end
    --[[if self._lastSkillTarget ~= target_name then
        return
    end]]
    if (target ~= nil) then
        self:LookAt(target:GetPositionXYZ())
    end
    --if not self.bNotChangeSkillCombo then
        
    --end
    self:SetCurSkillIndex(self.normalAttackIndex);
    self:PlaySkill()

end

-- 当动作进行到这一帧，如果采用连击，则切换普攻动作
function SceneEntity:onAniAttackCombo(aniName)
    self.after_comb_event = true
    if (self.keepNormalAttack == true) then
        self.bComboEx = true
    end
    if self.bComboEx == true then
        local use = true
        if GetMainUI() and GetMainUI():GetJoystick() and GetMainUI():GetJoystick().touch_move_begin then
            if self:GetName() == g_dataCenter.fight_info:GetCaptainName() then
                use = false;
            end
        end
        if use then
            self:UseComboSkill()
        end
        self.bComboEx = false
        self.can_combo = false;
    end

    if self.OnAniAttackComboSetKeepNormalAttackTrue then
        self.keepNormalAttack = true
        self.OnAniAttackComboSetKeepNormalAttackTrue = nil
    end
end

function SceneEntity:OnPropertyChange(property_type, lastval)
    if property_type == 'move_speed' or ENUM.EHeroAttribute['move_speed'] == property_type then

    end

    -- 通知所有人的触发器，我的属性改变了。
    ObjectManager.ForEachObj( function(objname, obj)
        if obj:GetTriggerManager() then
            obj:GetTriggerManager():OnPropertyChange(self, property_type, lastval);
        end
    end )
end

function SceneEntity:SetPlayMethodAbilityScaleMultiply(type, value)
    local old = self.list_play_method_ability_scale_multiply[type] or 0
    self.list_play_method_ability_scale_multiply[type] = value
    if value ~= old then
        self._buffManager._bUpdateProperty = true
        if self:IsMyControl() and PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
            local attribute_verify_change_info = {}
            attribute_verify_change_info.gid = self:GetGID()
            attribute_verify_change_info.scale_type = 4
            attribute_verify_change_info.ability_type = ENUM.EHeroAttribute[type]-ENUM.min_property_id-1
            attribute_verify_change_info.value = value
            attribute_verify_change_info.change = true
            self:InsertAttributeVerifyChangeInfo(attribute_verify_change_info)
        end
    end
end

function SceneEntity:UpdateProperty(bFirst)
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        return
    end
    local cur_hp = 0
    local old_max_hp = self.property[ENUM.EHeroAttribute.max_hp]
    if not bFirst then
        cur_hp = self.property[ENUM.EHeroAttribute.cur_hp]
    end
    local lastMoveSpeed = self:GetPropertyVal(ENUM.EHeroAttribute.move_speed)
    self.property = { }
    if self.card then
        local team_id = FightScene.GetPlayMethodTeamID()
        local property = self.card:GetProperty(team_id)
        for k, v in pairs(ENUM.EHeroAttribute) do
            self.property[v] = property[v]
        end
        local move_speed = self:GetPropertyVal(ENUM.EHeroAttribute.move_speed)
        self:SetProperty(ENUM.EHeroAttribute.move_speed, move_speed *(1 + self:GetPropertyVal(ENUM.EHeroAttribute.move_speed_plus)))
        if bFirst then
            self:CalPropertyLimit();
        end
        self:CalRunSetProperty()
        if bFirst then
            self.original_move_speed = self:GetPropertyVal(ENUM.EHeroAttribute.move_speed)
        end
		self:CalPlayMethodProperty();
        self:CalBuffProperty()
        self:AdjustmentProperty()
    end
    local maxHP = self:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
    if bFirst == true then
        self:SetProperty(ENUM.EHeroAttribute.cur_hp, maxHP);
        self.minHP = maxHP
    else
        if maxHP > old_max_hp then
            cur_hp = cur_hp + maxHP - old_max_hp
        end
        if cur_hp > maxHP then
			cur_hp = maxHP;
        end
        self.property[ENUM.EHeroAttribute.cur_hp] = cur_hp
    end
    curMoveSpeed = self:GetPropertyVal(ENUM.EHeroAttribute.move_speed)
    if curMoveSpeed ~= lastMoveSpeed then
        if self.navMeshAgent then
            self.navMeshAgent:set_speed(curMoveSpeed)
        end
        if self.aniCtroller then
            self.aniCtroller:CheckMoveSpeed()
        end
    end
end

function SceneEntity:GetMinHP()
    return self.minHP
end

function SceneEntity:CalPropertyLimit()
    for k, v in pairs(ENUM.EHeroAttribute) do
        local maxminAbsolute = ConfigManager.Get(EConfigIndex.t_absolute_property_max_min,v)
        if self.property[v] and self.property[v] > 0 then
            local maxScale = ConfigManager.Get(EConfigIndex.t_scale_property_max,v)
            local minScale = ConfigManager.Get(EConfigIndex.t_scale_property_min,v)
            if maxScale then
                self.property_limit_max[v] = self.property[v] * maxScale.value
            end
            if minScale then
                self.property_limit_min[v] = self.property[v] * minScale.value
            end
        end
        if maxminAbsolute then
            if self.property[v] and self.property[v] > 0 and v ~= ENUM.EHeroAttribute.attack_speed then
                if self.property_limit_min[v] == nil or self.property_limit_min[v] < maxminAbsolute.min then
                    self.property_limit_min[v] = maxminAbsolute.min
                end
                if self.property_limit_max[v] == nil or self.property_limit_max[v] > maxminAbsolute.max then
                    self.property_limit_max[v] = maxminAbsolute.max;
                end
            else
                self.property_limit_max[v] = maxminAbsolute.max
                self.property_limit_min[v] = maxminAbsolute.min
            end
        end
    end
end

function SceneEntity:AdjustmentProperty()
    for k, v in pairs(ENUM.EHeroAttribute) do
        if self.property[v] then
            if self.property_limit_min[v] and self.property[v] < self.property_limit_min[v] then
                self.property[v] = self.property_limit_min[v]
            elseif self.property_limit_max[v] and self.property[v] > self.property_limit_max[v] then
                self.property[v] = self.property_limit_max[v]
            end
        end
    end
end

function SceneEntity:SetPlayMethodAcitvityTimeEnum(id)
    self.playMethodAcitvityTimeEnum = id
end

function SceneEntity:CalPlayMethodProperty()
    for k, v in pairs(ENUM.EHeroAttribute) do
        if self.list_play_method_ability_scale_multiply[k] ~= nil then
            local value = self:GetPropertyVal(k)
            value = value * self.list_play_method_ability_scale_multiply[k]
            self:SetProperty(v, value)
        end
    end
	if self.playMethodAcitvityTimeEnum == nil then 
		return;
	end
	if self.playMethodAcitvityTimeEnum == MsgEnum.eactivity_time.eActivityTime_trial then 
		local buffIdList = g_dataCenter.trial.allInfo.buff_info;
		--buffIdList = {206,206,206,206,206,206,206,206,206,206,206,206,207,207,207,207,207,207,207,207,207,207,207,207,207,207,207,207};
		local len = #buffIdList;
		local buffEffectNumList = {};
		for i = 1,len do 
			local id = buffIdList[i];
			local cf = ConfigManager.Get(EConfigIndex.t_expedition_trial_buff,id);
			buffEffectNumList[cf.type] = buffEffectNumList[cf.type] or 0;
			buffEffectNumList[cf.type] = buffEffectNumList[cf.type] + cf.effect;
		end
		local cfRatio = ConfigManager.Get(EConfigIndex.t_property_ratio,1);
		for k, v in pairs(ENUM.EHeroAttribute) do
			if buffEffectNumList[v] ~= nil then 
				local value = self:GetPropertyVal(k)
				local newValue = value *(1+buffEffectNumList[v]);
				if k == "bloodsuck_rate" then 
					local normalRate = value/(value+cfRatio.bloodsuck_rate_ratio);
					local newRate = normalRate + buffEffectNumList[v];
					if newRate >= 0.9999667 then 
						newValue = 99999999;
					else 
						newValue = newRate * cfRatio.bloodsuck_rate_ratio / (1-newRate);
						--app.log_warning("吸血率："..tostring(value).."->"..tostring(newValue));
					end 
				elseif k == "broken_rate" then 
					local normalRate = value/(value+cfRatio.broken_ratio);
					local newRate = normalRate + buffEffectNumList[v];
					if newRate >= 0.9999667 then 
						newValue = 99999999;
					else 
						newValue = newRate * cfRatio.broken_ratio / (1-newRate);
						--app.log_warning("破击率："..tostring(value).."->"..tostring(newValue));
					end 
				elseif k == "crit_rate" then 
					local normalRate = value/(value+cfRatio.crite_ratio);
					local newRate = normalRate + buffEffectNumList[v];
					if newRate >= 0.9999667 then 
						newValue = 99999999;
					else 
						newValue = newRate * cfRatio.crite_ratio / (1-newRate);
						--app.log_warning("暴击率："..tostring(value).."->"..tostring(newValue));
					end 
				elseif k == "dodge_rate" then 
					local normalRate = value/(value+cfRatio.dodge_raio);
					local newRate = normalRate + buffEffectNumList[v];
					if newRate >= 0.9999667 then 
						newValue = 99999999;
					else 
						newValue = newRate * cfRatio.dodge_raio / (1-newRate);
						--app.log_warning("闪避率："..tostring(value).."->"..tostring(newValue));
					end 
				elseif k == "parry_rate" then 
					local normalRate = value/(value+cfRatio.parry_ratio);
					local newRate = normalRate + buffEffectNumList[v];
					if newRate >= 0.9999667 then 
						newValue = 99999999;
					else 
						newValue = newRate * cfRatio.parry_ratio / (1-newRate);
						--app.log_warning("格挡率："..tostring(value).."->"..tostring(newValue));
					end 
				elseif k == "rally_rate" then 
					local normalRate = value/(value+cfRatio.rally_rate_ratio);
					local newRate = normalRate + buffEffectNumList[v];
					if newRate >= 0.9999667 then 
						newValue = 99999999;
					else 
						newValue = newRate * cfRatio.rally_rate_ratio / (1-newRate);
						--app.log_warning("反弹率："..tostring(value).."->"..tostring(newValue));
					end 
				end
				self:SetProperty(v, newValue);
			end
		end
	end
end 

function SceneEntity:CalBuffProperty()
    if self._buffManager == nil then
        return
    end
    local have_addtion = false
    local addtion_property = { };
    for k, v in pairs(ENUM.EHeroAttribute) do
        if self._buffManager._abilityScaleMultiply[k] ~= nil then
            local value = self:GetPropertyVal(k)
            for _k, _v in pairs(self._buffManager._abilityScaleMultiply[k]) do
                value = value * _v
            end
            self:SetProperty(v, value)
        end
        if self._buffManager._abilityScaleAddition[k] ~= nil then
            have_addtion = true
            addtion_property[k] = 0
            for _k, _v in pairs(self._buffManager._abilityScaleAddition[k]) do
                addtion_property[k] = addtion_property[k] + _v
            end
        end
        if self._buffManager._abilityAbsolute[k] ~= nil then
            local value = self:GetPropertyVal(k)
            value = value + self._buffManager._abilityAbsolute[k]
            self:SetProperty(v, value)
        end
    end
    if have_addtion then
        for k, v in pairs(ENUM.EHeroAttribute) do
            if addtion_property[k] then
                local value = self:GetPropertyVal(k)
                local scale = 1
                scale = 1 + addtion_property[k]
                scale = math.max(0.001, scale)
                value = value * scale
                self:SetProperty(v, value)
            end
        end
    end
end

function SceneEntity:CalRunSetProperty()
    if not self.runSetProperty then return end

    for k,v in pairs(self.runSetProperty) do
        if v then
            self:SetProperty(k, v)
        end
    end
end

function SceneEntity:KeepNormalAttack(value)
    self.keepNormalAttack = value
end

function SceneEntity:GetIsKeepNormalAttack()
    return self.keepNormalAttack
end

function SceneEntity:SetOnAniAttackComboSetKeepNormalAttackTrue()
    self.OnAniAttackComboSetKeepNormalAttackTrue = true
end

function SceneEntity:SetAiEnable(is_enable)
    local fm = FightScene.GetFightManager()
    if (is_enable == true) then
        local ai = fm:GetFollowHeroAIID()
        if ai == nil then
            ai = ENUM.EAI.FollowHero
        end

        --  ai = 145
        -- self:SetPatrolMovePath({{x = 18, y = 0, z = -54}})

        
        self:KeepNormalAttack(true)
        self:SetAI(ai)
    else
        local mainHeroAi = fm:GetMainHeroAI()
        if mainHeroAi == nil or mainHeroAi == ENUM.EAI.MainHero or mainHeroAi == ENUM.EAI.PVPMainHero then
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                self:SetAI(ENUM.EAI.PVPMainHero)
            else
                self:SetAI(ENUM.EAI.MainHero)
            end
        else
            g_dataCenter.player:ChangeFightMode(true)
        end
    end
end
function SceneEntity:SetHP(n)
    local maxHP = self:GetPropertyVal('max_hp');
    if n <= 0 then
        n = 0
    elseif n > maxHP then
        n = maxHP
    end
    self:SetProperty('cur_hp', n);
end
--自杀
function SceneEntity:Suicide()
    self:SetHP(0);
    self:SetHandleState(EHandleState.Die);
end

function SceneEntity:SetNavFlag(enableNavAgent, enableObstacle)

    if not self.navMeshAgent then
        return
    end
    if not enableNavAgent and self.waitSkill then
        self:SetExternalArea("navEnableWhenWaitSkill", false)
        return
    end
    self:SetExternalArea("navEnableWhenWaitSkill", enableNavAgent)
    -- self.navMeshAgent:set_enable(false);
    -- self.navMeshObstacle:set_enable(false);
    -- self.navMeshAgent:reset_path();
    -- self.navMeshAgent:set_update_rotation(enableNavAgent);
    --[[if self:IsMyControl() then
        if enableNavAgent then
            app.log(self:GetName().."导航开启 ".." "..debug.traceback())
        else
            app.log(self:GetName().."导航关闭 ".." "..debug.traceback())
        end
    end]]
    --[[if self:GetExternalArea("recordLastNavEnable") == true then
        self:SetExternalArea("lastNavEnable", enableNavAgent)
    end]]
    if not enableNavAgent then
        self.navMeshAgent:set_enable(enableNavAgent);
        if not self:IsHero() then
            if self.navMeshObstacle then
                self.navMeshObstacle:set_enable(enableObstacle);
            end
        end
    else
        if not self:IsHero() then
            if self.navMeshObstacle then
                self.navMeshObstacle:set_enable(false);
            end
        end
        self.navMeshAgent:set_enable(enableNavAgent);
    end
    if (enableNavAgent) then
        self.navMeshAgent:set_update_rotation(enableNavAgent);
    end

end

-- 判断相关
function SceneEntity:IsHero()
    return self.objType == OBJECT_TYPE.HERO;
end

function SceneEntity:IsMonster()
    return self.objType == OBJECT_TYPE.MONSTER;
end

function SceneEntity:IsSpecMonster()
    if self:GetConfigNumber() then
        return PropsEnum.IsSpecMonster(self:GetConfigNumber()) or self:IsSceneItem()
    else
        return false
    end
end

--[[ 是否是场景道具 ]]
function SceneEntity:IsItem()
    return self.objType == OBJECT_TYPE.ITEM;
end

--[[ 是否是npc ]]
function SceneEntity:IsNpc()
    return self.objType == OBJECT_TYPE.NPC;
end

-- 是否是指定类型set
-- type 参见OBJECT_TYPE
function SceneEntity:IsObjType(type)
    return self.objType == type;
end

function SceneEntity:IsNeutrality()
    return self.camp_flag == g_dataCenter.fight_info.neutrality_flag
end

function SceneEntity:IsEnemy(role)
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then

        if self:IsNeutrality() or (role and role:IsNeutrality()) then
            return false
        end

        if role == nil then
            return(self.camp_flag ~= g_dataCenter.player.camp_flag)
        else
            return(self.camp_flag ~= role:GetCampFlag())
        end
    else
        if role then
            if role:IsNpc() or role:IsItem() or self:IsNpc() or self:IsItem() then
                return false
            elseif (role:IsMonster() and self:IsHero()) or(self:IsMonster() and role:IsHero()) then
                if role:IsMonster() and role:IsNeutrality() then
                    return false
                end
                if self:IsMonster() and self:IsNeutrality() then
                    return false
                end
                if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
                    return(self.camp_flag ~= role:GetCampFlag())
                else
                    return true;
                end
            end
        else
            if self:IsNpc() or self:IsItem() then
                return false
            elseif self:IsMonster() then
                if self:IsNeutrality() then
                    return false
                end
                if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
                    return(self.camp_flag ~= g_dataCenter.player.camp_flag)
                else
                    return true
                end
            end
        end
        if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss then
            return false
        elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox then
            if role == nil then
                return (self.country_id ~= g_dataCenter.player.country_id)
            else
                return (self.country_id ~= role:GetCountryID())
            end
        elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_pvptest then
            if role == nil then
                return self.owner_player_gid ~= g_dataCenter.player.playerid
            else
                return self.owner_player_gid ~= role.owner_player_gid
            end
        elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion
            or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2
            or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree
            or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_1v1 then
            if role == nil then
                return(self.camp_flag ~= g_dataCenter.player.camp_flag)
            else
                return(self.camp_flag ~= role:GetCampFlag())
            end
        elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld then
            local isInSafeArea = self:IsInSafeArea(role);
            if isInSafeArea == true then
                return false;
            end
            local worldInfo = ConfigManager.Get(EConfigIndex.t_world_info,FightScene.GetWorldGID())
            if worldInfo then
                if worldInfo.fight_restirct == ENUM.WorldFightRestirctType.Peace then
                    return false
                elseif worldInfo.fight_restirct == ENUM.WorldFightRestirctType.Country then
                    if role == nil then
                        -- app.log("1 self="..self:GetName()..tostring(self.country_id ~= g_dataCenter.player.country_id))
                        -- app.log("mycounty="..self.country_id.." play="..g_dataCenter.player.country_id)
                        return(self.country_id ~= g_dataCenter.player.country_id)
                    else
                        -- app.log("2 self="..self:GetName().." target="..role:GetName().." "..tostring(self.country_id ~= role:GetCountryID()))
                        return(self.country_id ~= role:GetCountryID())
                    end
                elseif worldInfo.fight_restirct == ENUM.WorldFightRestirctType.Camp then
                    if role == nil then
                        return(self.camp_flag ~= g_dataCenter.player.camp_flag)
                    else
                        return(self.camp_flag ~= role:GetCampFlag())
                    end
                end
            end
        end
    end
end

--判断是否在安全区
function SceneEntity:IsInSafeArea(role)
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld then
            local world_id = FightScene.GetWorldGID();
            local safe_area_info = ConfigHelper.GetMapInf(world_id,EMapInfType.safe_area)
            if safe_area_info then
                if not role then
                    role = self;
                end
                local my_pos = role:GetPosition(false);
                local isSafe = false;
                for k,v in pairs(safe_area_info) do
                    local safe_area_type = v.safe_area_type;
                    local pos = {};
                    pos.x = v.px;
                    pos.y = 0;
                    pos.z = v.pz;
                    local rot = v.ry;
                    local scale = {};
                    scale.x = v.sx;
                    scale.y = 1;
                    scale.z = v.sz;
                    --矩形
                    if safe_area_type == 0 then
                        local pa = {};
                        pa.x = v.vertex_0x - my_pos.x;
                        pa.z = v.vertex_0z - my_pos.z;
                        local pb = {};
                        pb.x = v.vertex_1x - my_pos.x;
                        pb.z = v.vertex_1z - my_pos.z;
                        local pc = {};
                        pc.x = v.vertex_2x - my_pos.x;
                        pc.z = v.vertex_2z - my_pos.z;
                        local pd = {};
                        pd.x = v.vertex_3x - my_pos.x;
                        pd.z = v.vertex_3z - my_pos.z;
                        --a×b=（x1y2-x2y1）
                        --(pa x pb) * (pd x pc)
                        local ret_ab_dc = (pa.x*pb.z - pb.x*pa.z) * (pd.x*pc.z - pc.x*pd.z);
                        --(pa x pd) * (pb x pc)
                        local ret_ad_bc = (pa.x*pd.z - pd.x*pa.z) * (pb.x*pc.z - pc.x*pb.z);
                        if ret_ab_dc <= 0 and ret_ad_bc <= 0 then
                            isSafe = true;
                            break;
                        end
                    --圆形
                    elseif safe_area_type == 1 then
                        local r = (my_pos.x - pos.x)*(my_pos.x - pos.x) + (my_pos.z - pos.z)*(my_pos.z - pos.z)
                        if r <= scale.x*scale.x*0.25 then
                            isSafe = true;
                            break;
                        end
                    else
                        app.log("world_id=="..world_id.."  k=="..k.."的安全区配置，类型出错");
                    end
                end
                return isSafe;
            else
                return false;
            end
    else
        return true;
    end
end

function SceneEntity:IsDead()
    return (self:GetState() == nil or self:GetState() == ESTATE.Die or self:GetState() == ESTATE.Dead)
end

function SceneEntity:GetCurSkillIndex()
    return self.old_skill_index
end

function SceneEntity:SetCurSkillIndex(index, skillAngle)
    --[[if self:IsMyControl() then
        app.log(" skillindex="..index.." skillAngle="..tostring(skillAngle).." "..debug.traceback())
    end]]
    if self:IsItem() then
        return
    end
    if self.old_skill_index == index and self.old_skill_angle == skillAngle then

        return
    end
    self.old_skill_index = index
    self.old_skill_angle = skillAngle
    self.currSkillEx = self._arrSkill[index]
    if self.currSkillEx == nil then
        app.log("name=" .. self:GetName() .. "技能为空 index=" .. index.." "..debug.traceback())
        return;
    end
    self.currSkillEx:SetIntelligent(true)
    if self.currSkillEx:IsCanManualDir() then
        if skillAngle and skillAngle ~= 0 then
            self.currSkillEx:SetIntelligent(false)
        end
        self.currSkillEx:SetAngle(skillAngle)
    end
    self:SetExternalArea("selectedSkill", true)
end

function SceneEntity:SetCurSkillID(skill_id)
    for i = 1, MAX_SKILL_CNT do
        if self._arrSkill[i] ~= nil and self._arrSkill[i]._skillData.id == skill_id then
            self.currSkillEx = self._arrSkill[i]
            self:SetExternalArea("selectedSkill", true)
            return
        end
    end
    app.log("SetCurSkillID未找到技能id" .. skill_id)
end

function SceneEntity:FindNearestEnemy()
    -- 寻找离自己最近的敌人
    local minDistance = 9999;
    local target = nil;
    for k, v in pairs(self.targets) do
        local entity = ObjectManager.GetObjectByName(v:get_name())
        if entity ~= nil and entity:GetHP() > 0 then
            local pos_self = self:GetPosition(true);
            local x, y, z = v:get_local_position();
            local dis = algorthm.GetDistance(x, z, pos_self.x, pos_self.z);
            if (dis < minDistance) then
                minDistance = dis;
                target = v;
            end
        end
    end
    if (target ~= nil) then
        self:SetAttackTarget(ObjectManager.GetObjectByName(target:get_name()));
        return true;
    else
        return false;
    end
end
function SceneEntity:SetAttackTarget(obj, isChangeTargetEffect)
    if self:IsMyControl() and self:IsCaptain() then
        isChangeTargetEffect = true
    end
    --[[
    if type(obj) == type('') then
        if obj == self.name then
            return
        end
        self.attackTargetName = obj;
        return;
    end
    if obj and obj ~= self then
        self.attackTargetName = obj:GetName()
    end
    --]]
    local target = nil
    if nil ~= obj then
        target = obj:GetName()
        --[[if self:IsMyControl() then
            app.log("设置目标="..target.." "..debug.traceback())
        end]]
    else
        --[[if self:IsMyControl() then
            app.log("清空目标 "..debug.traceback())
        end]]
    end
    if self.attackTargetName ~= nil then
        if target ~= self.attackTargetName then
            --[[if self:GetCurSkill() and self:GetCurSkill():GetSkillType() == eSkillType.Normal then
                self:SetCurSkillIndex(self.normalAttackIndex)
                --self.bNotChangeSkillCombo = true
            end]]
        else
            return
        end
    end
    self.attackTargetName = target
    if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
        if obj and obj:IsEnemy(self) and(not obj:IsDead()) and(not self:IsDead()) then
            obj:ChangeFightStateTarget(self.name, false, true, "成为目标")
            self:ChangeFightStateTarget(target, true, true, "成为目标")
        end
    end
    if self.name == g_dataCenter.fight_info:GetCaptainName() then
        g_dataCenter.player:ShowAttackTargetEffects(obj, isChangeTargetEffect)
    end

    if self.attackTargetName then
        FightRecord.RecordDiscoverEnemy(self, obj)
    end


    if GetMainUI() and GetMainUI():GetEnemyHp() and obj then
        -- 攻击者是自己的队长同时攻击的不是自己方的人，同时不是boss
        if self:IsMyControl() and
            self:IsCaptain() then
            if not obj:IsMyControl() and
                not obj:IsWorldBoss() and 
                not obj:IsHero() then
                GetMainUI():GetEnemyHp():SetShowEntityName(obj.name);
            else
                GetMainUI():GetEnemyHp():Hide();
            end
        end
    end
end
function SceneEntity:SetPosition(x, y, z, isLocal, isNavmesh)
    if self.object == nil then return end

    if x == nil or y == nil or z == nil then
        app.log("SetPosition = nil " .. debug.traceback())
        return
    end

    -- 设置坐标 isLocal是要local还是世界坐标 默认本地坐标
    if isLocal == nil then
        isLocal = true;
    end
    if isNavmesh == nil then
        isNavmesh = true
    end

    -- app.log("SetPosition "..self:GetName().." "..debug.traceback())
    if isNavmesh then
        local _x, _y, _z
        local bRet, hit = util.raycase_out4(x, 20, z, 0, -1, 0, 50, PublicFunc.GetBitLShift({PublicStruct.UnityLayer.terrain}));
        if bRet then
            --[[if self:IsMyControl() then
                app.log("1")
            end]]
            bRet, _x, _y, _z = util.get_navmesh_sampleposition(hit.x, hit.y, hit.z, 15);
            --[[if self.name == "Monster_2_12" then
                app.log("2 ret="..tostring(bRet).." x="..tostring(_x).." y="..tostring(_y).." z="..tostring(_z))
            end]]
        else
            bRet, _x, _y, _z = util.get_navmesh_sampleposition(x, y, z, 15);
            --if self:IsMyControl() then
            --    app.log("3 ret="..tostring(bRet).." x=".._x.." y=".._y.." z=".._z.." name="..hit.name)
            --end
        end
        if not bRet then
            app.log("SceneEntity:SetPosition failed to find a valid name="..self.name.." id="..tostring(self:GetConfigNumber()).." x="..x.." y="..y.." z="..z.." hurdleid="..tostring(FightScene.GetCurHurdleID()).." mapid="..tostring(FightScene.GetWorldGID()).." play="..tostring(FightScene.GetPlayMethodType()).." "..debug.traceback());
            _x = x
            _y = y;
            -- TODO: (kevin) 大部分情况是为了让对象下落到导航网格上。。。
            _z = z
        end
        x, y, z = _x, _y, _z
    end

    if isLocal then
        self.object:set_local_position(x, y, z);
    else
        self.object:set_position(x, y, z);
    end
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        if not self.first_set_pos and isNavmesh then
            local frame_info = {}
            if self:IsHero() then
                frame_info.type = ENUM.FightKeyFrameType.CreateHero
            elseif self:IsMonster() then
                frame_info.type = ENUM.FightKeyFrameType.CreateMonster
            end
            if frame_info.type then
                frame_info.integer_params = {}
                frame_info.string_params = {}
                table.placeholder_insert_number(frame_info.integer_params, self:GetConfigNumber())
                table.placeholder_insert_number(frame_info.integer_params, self.level)
                table.placeholder_insert_number(frame_info.integer_params, self:GetGID())
                table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(x))
                table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(z))
                table.placeholder_insert_number(frame_info.integer_params, self.camp_flag)
                FightKeyFrameInfo.AddKeyInfo(frame_info)
            end
            self.first_set_pos = true
        end
    end
end

function SceneEntity:SetLocalPosition3f(x, y, z)
    self.object:set_local_position(x, y, z);
end

function SceneEntity:GetLocalPosition3f()
    return self.object:get_local_position()
end


function SceneEntity:SetRotation(x, y, z, isLocal)
    -- 设置旋转值 isLocal是要相对旋转还是绝对旋转 默认相对旋转
    if isLocal == nil then
        isLocal = true;
    end
    if self.object then
        if isLocal then
            self.object:set_local_rotation(x, y, z);
        else
            self.object:set_rotation(x, y, z);
        end
    end
end
function SceneEntity:SetScale(x, y, z)
    -- 设置缩放
    if self.object then
        self.object:set_local_scale(x, y, z);
    end
end

function SceneEntity:SetBoxColliderParam(sizeX, sizeY, sizeZ)
    if self.object then
        self.object:set_box_collider_size(sizeX, sizeY, sizeZ);
    end
end

function SceneEntity:SetCapsuleColliderParam(radius, height)
    self.capsuleColliderRadius = radius
    if self.object then
        self.object:set_capsule_collider_radius(radius)
        self.object:set_capsule_collider_height(height)
    end
end

function SceneEntity:GetCapsuleColliderRadius()
    return self.capsuleColliderRadius
end

function SceneEntity:SetState(state, force)
    if self.fsm == nil then
        -- app.log(debug.traceback() .. "+++++++++" .. table.tostring(self))
    end
    if (self.fsm:GetState() == ESTATE.Die or self.fsm:GetState() == ESTATE.Dead) and not force then
        return
        -- app.log_warning("死亡后非法改变状态 "..debug.traceback())
    end
    --[[if self:IsMyControl() and state ~= self.fsm:GetState() then
        app.log(self.name.." entitystate="..state.." "..debug.traceback())
    end]]
    self.fsm:SetState(state)

    if state ~= ESTATE.Stand then
        LocalModeAbortReborn()
    end
end

function SceneEntity:SetHandleState(state, force)
    if self.handleFsm == nil then
        if state == EHandleState.Die then
            self:SetState(ESTATE.Die)
        end
        return
    end
    if self.handleFsm:GetState() == EHandleState.Die and not force then
        return
        -- app.log_warning("死亡后非法改变状态 "..debug.traceback())
    end
    --[[if self:IsMyControl() and state ~= self.handleFsm:GetState() then
        app.log("handlestate="..state.." "..debug.traceback())
    end]]
    self.handleFsm:SetState(state)
end

function SceneEntity:GetHandleState()
    if self.handleFsm then
        return self.handleFsm:GetState()
    else
        return nil
    end
end

function SceneEntity:SetHandleFsm(fsm)
    local new_state = nil 
    if fsm and (self.handleFsm == nil) then
        if self.last_handle_fsm_state == EHandleState.Move then
            if GetMainUI() and GetMainUI():GetJoystick() and GetMainUI():GetJoystick().touch_move_begin then
                new_state = EHandleState.Move
            end
        elseif self.last_handle_fsm_state == EHandleState.Attack then
            if self.real_use_normal_attack then
                new_state = EHandleState.Attack
            end
        end
        self.last_handle_fsm_state = nil
    end
    self.handleFsm = fsm
    if new_state then
        self:SetHandleState(new_state)
    end
end

function SceneEntity:GetHP()
    return self:GetPropertyVal('cur_hp');
end

function SceneEntity:GetObject()
    return self.object;
end

-- 设置相关
function SceneEntity:SetProperty(property_type, newval)
    -- 设置属性值  property_type：ENUM.EHeroAttribute表中的值。可以用id，也可以用名字。
    if type(property_type) == 'string' then
        property_type = ENUM.EHeroAttribute[property_type]
    end
    if not property_type then
        app.log('property_debug 有找不到的属性！' .. self:GetName() .. debug.traceback())
        return
    end
    local last = self.property[property_type]
    self.property[property_type] = newval;
    if last ~= newval then
        self:OnPropertyChange(property_type, last)
    end
    if property_type == ENUM.EHeroAttribute.cur_hp and newval < 0 then
        app.log("error set hp = "..newval.." "..debug.traceback())
    end
    if g_dataCenter.fight_info:GetCaptainName() == self:GetName() then
        if property_type == ENUM.EHeroAttribute.cur_hp then
            local hurdle_id = FightScene.GetCurHurdleID()
            local cfg = ConfigHelper.GetHurdleConfig(hurdle_id)
            if cfg and cfg.low_hp_audio and cfg.low_hp_audio == 1 then
                local max_hp = self:GetPropertyVal("max_hp")
                if not max_hp or max_hp == 0 then
                    --app.log("没有max_hp");
                    return
                end
                if max_hp == 0 then
                    --app.log("max_hp=0");
                    return
                end
                local boundary = ConfigManager.Get(EConfigIndex.t_discrete,83000119)
                if not boundary then return end
                if newval*100/max_hp < boundary.data and not self.isPlayLowHpAudio then
                    self.isPlayLowHpAudio = true;
                    --app.log("血量低于30%");
                    AudioManager.PlayUiAudio(ENUM.EUiAudioType.Heartbeat)
                elseif newval*100/max_hp >= boundary.data and self.isPlayLowHpAudio then
                    self.isPlayLowHpAudio = false;
                    --app.log("血量高于30%");
                    AudioManager.StopUiAudio(ENUM.EUiAudioType.Heartbeat)
                end
            end
        end
    end
end

function SceneEntity:SetPropertyFromServer(property_type, newval)
    self:SetProperty(property_type, newval)
    if property_type == ENUM.EHeroAttribute.move_speed then
        if self.navMeshAgent then
            self:RecordSpeedFromServer(newval)
            if self.fix_move == nil then
                self.navMeshAgent:set_speed(newval)
            end
            if self.aniCtroller then
                self.aniCtroller:CheckMoveSpeed()
            end
        end
    elseif property_type == ENUM.EHeroAttribute.cur_hp or property_type == ENUM.EHeroAttribute.max_hp then
        if self:IsMyControl() then
            GetMainUI():UpdateHeadData();
        end
    end
end

function SceneEntity:RecordSpeedFromServer(value)
    self.speed_from_server = value
end

function SceneEntity:SetDestination(x, y, z, temp)
    --[[if x then
        self.destination.x = math.floor(x * PublicStruct.Coordinate_Scale) * PublicStruct.Coordinate_Scale_Decimal;
    else
        self.destination.x = nil
    end
    if y then
        self.destination.y = math.floor(y * PublicStruct.Coordinate_Scale) * PublicStruct.Coordinate_Scale_Decimal;
    else
        self.destination.y = nil
    end
    if z then
        self.destination.z = math.floor(z * PublicStruct.Coordinate_Scale) * PublicStruct.Coordinate_Scale_Decimal;
    else
        self.destination.z = nil
    end]]

    if not self.object then
        return
    end

    local _x = x
    local _y = y
    local _z = z
    if not temp and self.navMeshAgent and x and y and z then
        local state = self.navMeshAgent:get_enable()
        self:SetNavFlag(true, false);
        local bRet, hit = util.raycase_out4(x, 20, z, 0, -1, 0, 50, PublicFunc.GetBitLShift({PublicStruct.UnityLayer.terrain}));

        if bRet then
            bRet, _x, _y, _z = util.get_navmesh_sampleposition(hit.x, hit.y, hit.z, 15);
        else
            bRet, _x, _y, _z = util.get_navmesh_sampleposition(x, y, z, 15);
        end

        if not bRet then
            _x = x
            _y = 0.1;
            _z = z
        end
    end
    self.destination.x = _x;
    self.destination.y = _y;
    self.destination.z = _z;
    if (_x == nil or _y == nil or _z == nil) and not temp then
        app.log("SetDestination x=" .. tostring(_x) .. " y=" .. tostring(_y) .. " z=" .. tostring(_z).." "..debug.traceback())
    end
end

function SceneEntity:SetBeginPositionV3d(pos)
    self._runBeginPosV3d = pos
end
function SceneEntity:GetBeginPositionV3d(pos)
    return self._runBeginPosV3d:Clone()
end
function SceneEntity:GetCurSkill()
    return self.currSkillEx
end

function SceneEntity:GetAttackTarget()
    if nil ~= self.attackTargetName then
        local target = ObjectManager.GetObjectByName(self.attackTargetName)
        if target ~= nil and target:GetHP() > 0 then
            return target
        else
            return nil
        end
    else
        return nil
    end
end

function SceneEntity:GetSkill(index)
    return self._arrSkill[index];
end

function SceneEntity:GetSkillBySkillID(id)
    for i = 1, MAX_SKILL_CNT do
        if self._arrSkill[i] ~= nil and self._arrSkill[i]._skillData.id == id then
            return self._arrSkill[i]
        end
    end
    return nil
end

function SceneEntity:GetSkillByUIIndex(index)
    for i = 1, MAX_SKILL_CNT do
        if self._arrSkill[i] ~= nil and self._arrSkill[i]._uiIndex == index then
            return self._arrSkill[i]
        end
    end
    return nil
end

function SceneEntity:GetDestination()
    return self.destination.x, self.destination.y, self.destination.z;
end

function SceneEntity:GetName()
    -- 获取物件名字
    return self.name;
end

function SceneEntity:GetIid()
    return self.iid;
end

function SceneEntity:GetPositionXYZ(isLocal, doNotUseCache)
    if isLocal == nil then
        isLocal = true;
    end

    if doNotUseCache then
        self.frame_cnt_local = -1
    end

    local x,y,z = 0,0,0
    if self.object then
        local frame_cnt = Root.GetFrameCount()
        if isLocal then
            local localCachePos = self.local_position
            if self.frame_cnt_local ~= frame_cnt then
                x, y, z = self.object:get_local_position();
                localCachePos.x = x
                localCachePos.y = y
                localCachePos.z = z
                self.frame_cnt_local = frame_cnt
            else
                x = localCachePos.x
                y = localCachePos.y
                z = localCachePos.z
            end
        else
            local cachePos = self.position
            if self.frame_cnt ~= frame_cnt then
                x, y, z = self.object:get_position();
                cachePos.x = x
                cachePos.y = y
                cachePos.z = z
                self.frame_cnt = frame_cnt
            else
                x = cachePos.x
                y = cachePos.y
                z = cachePos.z
            end
        end
    end

    return x,y,z
end

function SceneEntity:GetPosition(isLocal, doNotUseCache, outVar)
    -- 获取坐标 isLocal是要local还是世界坐标 默认本地坐标
    local pos = outVar or {}
    pos.x, pos.y, pos.z = self:GetPositionXYZ(isLocal, doNotUseCache)


    return pos;
end


function SceneEntity:GetPositionV3d(isLocal, doNotUseCache, outVar)

    local x, y, z = self:GetPositionXYZ(isLocal, doNotUseCache)

    if outVar then
        outVar:SetX(x)
        outVar:SetY(y)
        outVar:SetZ(z)
    else
        outVar = Vector3d:new( { x = x, y = y, z = z });
    end

    return outVar
end

function SceneEntity:GetAnimStartPositionV3d()
    local x = self.animStartPos.x
    local y = self.animStartPos.y
    local z = self.animStartPos.z
    return Vector3d:new( { x = x, y = y, z = z });
end

function SceneEntity:GetVelocityXYZ()
    return self.navMeshAgent:get_velocity()
end

function SceneEntity:GetBindPosition(id, check)
    local bind_node = self:GetBindObj(id, check)

    local pos = { }
    if nil ~= bind_node then
        pos.x, pos.y, pos.z = bind_node:get_position();
    end

    return pos;
end

function SceneEntity:GetBindPositionA(id)
    local pos = self:GetBindPosition(id)
    return pos.x, pos.y, pox.z
end


function SceneEntity:GetBindObj(id, check)
    --    app.log("ddddd"..tostring(id))
    local bp_node = self.bindNodeLookUp[id]
    if nil ~= bp_node then
        return bp_node
    else
        local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,id)
        if bind_pos then
            if self.object then
                bp_node = self.object:get_child_by_name(bind_pos.bind_pos_name);
                if not bp_node and check then
                    app.log("查询绑定位置失败 name=" .. bind_pos.bind_pos_name .. " model=" .. self:GetModelID())
                end
            else
                if check then
                    app.log("查询绑定位置时object为nil")
                end
            end
            self.bindNodeLookUp[id] = bp_node;
        end
    end

    return bp_node;
end

function SceneEntity:GetRotation(isLocal)
    -- 获取旋转值 isLocal是要相对旋转还是绝对旋转 默认相对旋转
    isLocal = isLocal or true;
    local rotation = { }
    if self.object then
        if isLocal then
            rotation.x, rotation.y, rotation.z = self.object:get_local_rotation();
        else
            rotation.x, rotation.y, rotation.z = self.object:get_rotation();
        end
    else
        rotation.x, rotation.y, rotation.z = 0, 0, 0
    end
    return rotation;
end

function SceneEntity:GetRotationq()
    if self.object then
        return self.object:get_local_rotationq()
    end
    --return nil,nil,nil,nil
end

function SceneEntity:SetRotationq(x, y, z, w)
    if self.object then
        self.object:set_local_rotationq(x, y, z, w)
    end
end

function SceneEntity:GetScale()
    -- 获取缩放
    local scale = { }
    if self.object then
        scale.x, scale.y, scale.z = self.object:get_local_scale();
    end
    return scale;
end

function SceneEntity:GetScaleV3d()
    -- 获取缩放
    local x,y,z = 0, 0, 0
    if self.object then
        x, y, z = self.object:get_local_scale();
    end
    return Vector3d:new({x = x, y = y, z = z});
end

function SceneEntity:GetState()
    if nil == self.fsm then
        -- app.log("fsm == nil "..debug.traceback())
        return nil
    end
    return self.fsm.m_stateName
end
function SceneEntity:GetModelID()
    return self.config.model_id
end

function SceneEntity:GetForWard()
    -- 获得方向
    local v = { }
    if self.object then
        v.x, v.y, v.z = self.object:get_forward()
    else
        v.x = 1
        v.y = 0
        v.z = 1
    end
    return v
end
function SceneEntity:GetAniCtrler()
    -- 动画控制
    return self.aniCtroller;
end
function SceneEntity:GetObjType()
    return self.objType;
end

function SceneEntity:SetCampFlag(camp_flag)
    self.camp_flag = camp_flag
end

function SceneEntity:GetCampFlag()
    return self.camp_flag
end

function SceneEntity:SetCountryID(country_id)
    self.country_id = country_id
end

function SceneEntity:GetCountryID()
    return self.country_id
end

function SceneEntity:GetProperty()
    if self._buffManager._bUpdateProperty and self:IsDead() == false then
        self:UpdateProperty(false)
        self._buffManager._bUpdateProperty = false
    end
    return self.property
end

function SceneEntity:GetPropertyVal(property_type)
    if type(property_type) == 'string' then
        property_type = ENUM.EHeroAttribute[property_type]
    end
    if not property_type then
        app.log('property_debug GetPropertyVal 有找不到的属性！' .. self:GetName() .. debug.traceback())
    end
    if self.property[property_type] == nil then
        self.property[property_type] = 0
    end
    return self.property[property_type];
end

function SceneEntity:AddPropertyVal(property_type, addval)
    if type(property_type) == 'string' then
        property_type = ENUM.EHeroAttribute[property_type]
    end
    if not property_type then
        app.log('property_debug AddPropertyVal 有找不到的属性！' .. self:GetName() .. debug.traceback())
    end
    self.property[property_type] = self.property[property_type] + addval
end

function SceneEntity:ChangeHP(delata)
    self:SetHP(self:GetHP() + delata)
end

function SceneEntity:PosMoveToTarget(_target, _usetime, _cbFunction, _cbData, _offset, _offsetType, _finalTorward, _usespeed, _bTransformState, _bUpdateSever)
    
    _offset = _offset or 0;
    --self:SetNavFlag(true, false);
    --PublicFunc.CheckCanUseNavMeshOperation(self, true)
    --self.navMeshAgent:reset_path();
    --self.navMeshAgent:set_update_rotation(false);
    self:SetNavFlag(false, false);
    local _speed = _usespeed
    if _speed then
        _speed = _speed * 0.001
    end
    if self.posMoveList then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
            local curPos = self:GetPosition();
            local frame_info = {}
            frame_info.type = ENUM.FightKeyFrameType.Translate
            frame_info.integer_params = {}
            frame_info.string_params = {}
            table.placeholder_insert_number(frame_info.integer_params, self:GetGID())
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.x))
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.z))
            table.placeholder_insert_number(frame_info.integer_params, 0)
            FightKeyFrameInfo.AddKeyInfo(frame_info)
        end
        if self.posMoveList.bTransformState then
            self:PostEvent("FinishTransform")
        end
    end
    if _bTransformState then
        self:PostEvent("Transform", { })
    end
    self.posMoveList = {}
    self.posMoveList.begintime = PublicFunc.QueryCurTime()
    self.posMoveList.target = _target
    self.posMoveList.usetime = _usetime
    self.posMoveList.cbFunction = _cbFunction
    self.posMoveList.cbData = _cbData
    self.posMoveList.offset = _offset
    self.posMoveList.offsetType = _offsetType
    self.posMoveList.finalTorward = _finalTorward
    self.posMoveList.speed = _speed
    self.posMoveList.bTransformState = _bTransformState
    self.posMoveList.bUpdateSever = _bUpdateSever
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        local curPos = self:GetPosition();
        local frame_info = {}
        frame_info.type = ENUM.FightKeyFrameType.Translate
        frame_info.integer_params = {}
        frame_info.string_params = {}
        table.placeholder_insert_number(frame_info.integer_params, self:GetGID())
        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.x))
        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.z))
        table.placeholder_insert_number(frame_info.integer_params, 1)
        FightKeyFrameInfo.AddKeyInfo(frame_info)
    end
end

--[[ 位移到指定位置 ]]
-- _type 位移类型(nil普通1左手2右手3前方4击退5击飞)
-- x, y, z 目标位置
-- _usetime 耗时
-- _cbFunction 回调函数
-- _cbData 回调数据
-- _autoforward  自定调整方向(bool)
-- _usespeed 位移速度(可选)
-- _height 高度
function SceneEntity:PosMoveToPos(_type, x, y, z, _usetime, _cbFunction, _cbData, _autoforward, _usespeed, _height, _bTransformState, _bUpdateSever)
    if self:IsDead() then
        return
    end
    if self.posMoveList then
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
            local curPos = self:GetPosition();
            local frame_info = {}
            frame_info.type = ENUM.FightKeyFrameType.Translate
            frame_info.integer_params = {}
            frame_info.string_params = {}
            table.placeholder_insert_number(frame_info.integer_params, self:GetGID())
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.x))
            table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.z))
            table.placeholder_insert_number(frame_info.integer_params, 0)
            FightKeyFrameInfo.AddKeyInfo(frame_info)
        end
        if self.posMoveList.bTransformState then
            self:PostEvent("FinishTransform")
        end
    end
    if _bTransformState then
        self:PostEvent("Transform", { })
    end

    local curPos = self:GetPosition();
    local dis = util.v3_distance(curPos.x, curPos.y, curPos.z, x, y, z);
    local _speed = 0
    if _usespeed then
        _speed = _usespeed * 0.001
    else
        _speed = dis / _usetime
    end
    local dx = x - curPos.x;
    local dy = 0;
    local dz = z - curPos.z;
    dx, dy, dz = util.v3_normalized(dx, dy, dz);
    if _autoforward == true then
        self:LookAt(x,y,z);
    end
    --self:SetNavFlag(true, false);
    --PublicFunc.CheckCanUseNavMeshOperation(self, true)
    --self.navMeshAgent:reset_path();
    --self.navMeshAgent:set_update_rotation(false);
    self:SetNavFlag(false, false);
    self.posMoveList = {}
    self.posMoveList.begintime = PublicFunc.QueryCurTime()
    self.posMoveList.directx = dx
    self.posMoveList.directy = 0
    self.posMoveList.directz = dz
    self.posMoveList.speed = _speed
    self.posMoveList.usetime = _usetime
    self.posMoveList.cbFunction = _cbFunction
    self.posMoveList.cbData = _cbData
    self.posMoveList.desx = x
    self.posMoveList.desy = y
    self.posMoveList.desz = z
    self.posMoveList.height = _height
    self.posMoveList.type = _type
    self.posMoveList.bTransformState = _bTransformState
    self.posMoveList.bUpdateSever = _bUpdateSever
    if _type == 1 then
        --self:PlayAnimate(EANI.hit_l)
    elseif _type == 2 then
        --self:PlayAnimate(EANI.hit_r)
    elseif _type == 3 then
        --self:PlayAnimate(EANI.hit)
    elseif _type == 4 then
        --self:PlayAnimate(EANI.repel)
    elseif _type == 5 then
        self:PlayAnimate(EANI.up)
        if self.posMoveList.height == nil then
            self.posMoveList.height = 1
        end
        if self.posMoveList.height then
            self.posMoveList.hstep = 0
            local cfg = ConfigHelper.GetSkillEffectByModelId(self.config.model_id, EANI.up)
            if cfg ~= nil then
                if cfg.frame_event ~= nil and cfg.frame_event ~= 0 then
                    self.posMoveList.utime = cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame
                    self.posMoveList.uspeed = self.posMoveList.height / self.posMoveList.utime
                else
                    self.posMoveList.utime = _usetime / 2
                    self.posMoveList.uspeed = self.posMoveList.height / self.posMoveList.utime
                end
            else
                self.posMoveList.utime = _usetime / 2
                self.posMoveList.uspeed = self.posMoveList.height / self.posMoveList.utime
            end
            cfg = ConfigHelper.GetSkillEffectByModelId(self.config.model_id, EANI.down)
            if cfg ~= nil then
                if cfg.frame_event ~= nil and cfg.frame_event ~= 0 then
                    local time = cfg.frame_event[1].f * PublicStruct.MS_Each_Anim_Frame
                    self.posMoveList.dtime = self.posMoveList.utime + time
                    self.posMoveList.dspeed = self.posMoveList.height / time
                else
                    self.posMoveList.dtime = _usetime
                    self.posMoveList.dspeed = self.posMoveList.height /(_usetime / 2)
                end
            else
                self.posMoveList.dtime = _usetime
                self.posMoveList.dspeed = self.posMoveList.height /(_usetime / 2)
            end
        end
    end
    if _usetime == 0 then
        self.navMeshAgent:set_next_position(x, y, z)
    end


    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        local frame_info = {}
        frame_info.type = ENUM.FightKeyFrameType.Translate
        frame_info.integer_params = {}
        frame_info.string_params = {}
        table.placeholder_insert_number(frame_info.integer_params, self:GetGID())
        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.x))
        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.z))
        table.placeholder_insert_number(frame_info.integer_params, 1)
        FightKeyFrameInfo.AddKeyInfo(frame_info)
    end
end

function SceneEntity:PosMoveUpdate(deltaTime)
    local bHaveFinish = false
    local bTargetUseSpeed = false
    local bTransformState = false
    if self.posMoveList then
        if self._buffManager and self._buffManager:IsInSpecialEffect(ESpecialEffectType.DingShen) then
            if self.posMoveList.finalTorward == 1 and self.posMoveList.target then
                self:LookAt(self.posMoveList.target:GetPositionXYZ())
            end
            if self.posMoveList.cbFunction ~= nil then
                self.posMoveList.cbData.direct.x = self.posMoveList.directx
                self.posMoveList.cbData.direct.y = self.posMoveList.directy
                self.posMoveList.cbData.direct.z = self.posMoveList.directz
                self.posMoveList.cbFunction(self.posMoveList.cbData, nil)
            end
            if self.posMoveList.target ~= nil and self.posMoveList.speed ~= nil then
                bTargetUseSpeed = true
            end
            if self.posMoveList.bTransformState then
                bTransformState = true
            end
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                if (self:IsMyControl() or self:IsAIAgent()) and self.posMoveList.bUpdateSever then
                    local pos = self:GetPosition();
                    msg_move.cg_translate_position(self:GetGID(), pos.x * PublicStruct.Coordinate_Scale, pos.z * PublicStruct.Coordinate_Scale)
                end
            end
            self.posMoveList = nil;
            bHaveFinish = true
        elseif self.posMoveList.bArrive then
            if self.posMoveList.finalTorward == 1 and self.posMoveList.target then
                self:LookAt(self.posMoveList.target:GetPositionXYZ())
            end
            if self.posMoveList.cbFunction ~= nil then
                self.posMoveList.cbData.direct.x = self.posMoveList.directx
                self.posMoveList.cbData.direct.y = self.posMoveList.directy
                self.posMoveList.cbData.direct.z = self.posMoveList.directz
                if self.posMoveList.cbData.type == 1 then
                    self.posMoveList.cbFunction(self.posMoveList.cbData, nil)
                else
                    self.posMoveList.cbFunction(self.posMoveList.cbData, { self.posMoveList.target })
                end

            end
            if self.posMoveList.target ~= nil and self.posMoveList.speed ~= nil then
                bTargetUseSpeed = true
            end
            if self.posMoveList.bTransformState then
                bTransformState = true
            end
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                if (self:IsMyControl() or self:IsAIAgent()) and self.posMoveList.bUpdateSever then
                    local pos = self:GetPosition();
                    msg_move.cg_translate_position(self:GetGID(), pos.x * PublicStruct.Coordinate_Scale, pos.z * PublicStruct.Coordinate_Scale)
                end
            elseif PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
                local curPos = self:GetPosition();
                local frame_info = {}
                frame_info.type = ENUM.FightKeyFrameType.Translate
                frame_info.integer_params = {}
                frame_info.string_params = {}
                table.placeholder_insert_number(frame_info.integer_params, self:GetGID())
                table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.x))
                table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(curPos.z))
                table.placeholder_insert_number(frame_info.integer_params, 0)
                FightKeyFrameInfo.AddKeyInfo(frame_info)
            end
            self.posMoveList = nil;
            bHaveFinish = true
        else
            local curPos = self:GetPosition(true);
            if not self.posMoveList.bArrive then
                local bArrive = false
                local targetPos = nil
                local speed = 0
                local usedTime = PublicFunc.QueryDeltaTime(self.posMoveList.begintime)
                local newdx, newdy, newdz
                if self.posMoveList.target ~= nil then
                    targetPos = self.posMoveList.target:GetPosition(true);
                    newdx = targetPos.x - curPos.x;
                    newdy = 0
                    newdz = targetPos.z - curPos.z;
                    newdx, newdy, newdz = util.v3_normalized(newdx, newdy, newdz);
                    if self.posMoveList.offset ~= 0 then
                        if self.posMoveList.offsetType == 0 then
                            local oldDis = util.v3_distance(targetPos.x, targetPos.y, targetPos.z, curPos.x, curPos.y, curPos.z);
                            local newDis = util.v3_distance(targetPos.x, targetPos.y, targetPos.z, targetPos.x - newdx * self.posMoveList.offset, curPos.y, targetPos.z - newdz * self.posMoveList.offset);
                            if oldDis < newDis then
                                targetPos = curPos
                            else
                                targetPos.x = targetPos.x - newdx * self.posMoveList.offset
                                targetPos.z = targetPos.z - newdz * self.posMoveList.offset
                            end
                        elseif self.posMoveList.offsetType == 1 then
                            local forward = self.posMoveList.target:GetForWard()
                            targetPos.x = targetPos.x - forward.x * self.posMoveList.offset
                            targetPos.z = targetPos.z - forward.z * self.posMoveList.offset
                        end
                    end
                else
                    targetPos = { }
                    targetPos.x = self.posMoveList.desx
                    targetPos.y = self.posMoveList.desy
                    targetPos.z = self.posMoveList.desz
                    newdx = targetPos.x - curPos.x;
                    newdy = 0
                    newdz = targetPos.z - curPos.z;
                    newdx, newdy, newdz = util.v3_normalized(newdx, newdy, newdz);
                end
                local dis = util.v3_distance(curPos.x, curPos.y, curPos.z, targetPos.x, targetPos.y, targetPos.z);
                if self.posMoveList.target ~= nil then
                    if self.posMoveList.speed then
                        speed = self.posMoveList.speed
                    else
                        speed = dis /(self.posMoveList.usetime - usedTime);
                    end
                else
                    speed = self.posMoveList.speed
                end
                local frameLength = 0
                if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.FrameSync then
                    frameLength = speed * PublicStruct.MS_Each_Frame
                else
                    frameLength = speed * deltaTime * 1000
                end

                self.posMoveList.directx = newdx;
                self.posMoveList.directy = newdy;
                self.posMoveList.directz = newdz;
                if self.posMoveList.usetime > usedTime then
                    if frameLength >= dis and self.posMoveList.type ~= 5 then
                        bArrive = true
                    else
                        -- if self.posMoveList.target ~= nil then

                        -- end
                        local hpos = nil
                        if self.posMoveList.hstep == 0 then
                            hpos = curPos.y + self.posMoveList.uspeed * deltaTime * 1000
                            if usedTime >= self.posMoveList.utime then
                                self.posMoveList.hstep = 1
                                self:PlayAnimate(EANI.down)
                            end
                        elseif self.posMoveList.hstep == 1 then
                            hpos = curPos.y - self.posMoveList.dspeed * deltaTime * 1000
                            if usedTime >= self.posMoveList.dtime then
                                self.posMoveList.hstep = 2
                            end
                        end
                        local newx = curPos.x + self.posMoveList.directx * frameLength
                        local newy = curPos.y
                        if hpos then
                            newy = hpos
                        end
                        local newz = curPos.z + self.posMoveList.directz * frameLength
                        if self.navMeshAgent then
                            local ray_cast_y = curPos.y
                            local bRayRet, hit = util.raycase_out4(curPos.x, 20, curPos.z, 0, -1, 0, 50, PublicFunc.GetBitLShift({PublicStruct.UnityLayer.terrain}));
                            if bRayRet then
                                ray_cast_y = hit.y
                                local isSuc, sx, sy, sz = util.get_navmesh_sampleposition(curPos.x, ray_cast_y, curPos.z, 10)
                                if isSuc then
                                    ray_cast_y = sy
                                end
                            end
                            local bRet, nx, ny, nz = self.navMeshAgent:ray_cast(curPos.x, ray_cast_y, curPos.z, newx, newy, newz, self.navMeshAgent:get_area_mask())
                            if bRet then
                                if self.posMoveList.type ~= 5 then
                                    self.posMoveList.bArrive = true
                                end
                                self.posMoveList.desx = nx
                                self.posMoveList.desy = ny
                                self.posMoveList.desz = nz
                            end
                            self:SetNavFlag(true, false);
                            local isSuc, sx, sy, sz = util.get_navmesh_sampleposition(nx, ny, nz, 10)
                            -- local path = self.navMeshAgent:calculate_path(nx, ny, nz)
                            --                            if path then
                            --                                if ny < path[#path].y then
                            --                                    ny = path[#path].y
                            --                                end
                            --                            end
                            if isSuc and ny < sy then
                                ny = sy
                            end
                            self:SetNavFlag(false, true);
                            self:SetPosition(nx, ny, nz, true, false)
                        else
                            self:SetPosition(newx, newy, newz, true, false)
                        end

                    end
                else
                    if self.posMoveList.type == 5 then
                        self:PlayAnimate(EANI.getup)
                    end
                    bArrive = true
                end
                if bArrive == true then
                    if self.navMeshAgent then
                        local ray_cast_y = curPos.y
                        local bRayRet, hit = util.raycase_out4(curPos.x, 20, curPos.z, 0, -1, 0, 50, PublicFunc.GetBitLShift({PublicStruct.UnityLayer.terrain}));
                        if bRayRet then
                            ray_cast_y = hit.y
                            local isSuc, sx, sy, sz = util.get_navmesh_sampleposition(curPos.x, ray_cast_y, curPos.z, 10)
                            if isSuc then
                                ray_cast_y = sy
                            end
                        end
                        local bRet, nx, ny, nz = self.navMeshAgent:ray_cast(curPos.x, ray_cast_y, curPos.z, targetPos.x, targetPos.y, targetPos.z, self.navMeshAgent:get_area_mask())
                        self:SetNavFlag(true, false);
                        local isSuc, sx, sy, sz = util.get_navmesh_sampleposition(nx, ny, nz, 10)
                        if isSuc then
                            -- if ny < sy then
                            ny = sy
                            -- end
                        end
                        --[[local path = self.navMeshAgent:calculate_path(nx, ny, nz)
                        if path then
                            if ny < path[#path].y then
                                ny = path[#path].y
                            end
                        end]]
                        self:SetNavFlag(false, true);
                        self:SetPosition(nx, ny, nz, true, false)
                    else
                        self:SetPosition(targetPos.x, targetPos.y, targetPos.z, true, false)
                    end
                    self.posMoveList.bArrive = true
                    self.posMoveList.desx = targetPos.x
                    self.posMoveList.desy = targetPos.y
                    self.posMoveList.desz = targetPos.z
                end
                if self.posMoveList.cbFunction ~= nil and self.posMoveList.cbData.type == 1 then
                    local targets = {}
                    self:SearchAreaTarget(false, 1.5, self, targets, nil, 360, nil, 1, true, nil, nil, nil)
                    if #targets > 1 then
                        self:SetNavFlag(false,true);
                        self.posMoveList.cbData.direct.x = self.posMoveList.directx
                        self.posMoveList.cbData.direct.y = self.posMoveList.directy
                        self.posMoveList.cbData.direct.z = self.posMoveList.directz
                        if self.posMoveList.bTransformState then
                            bTransformState = true
                        end
                        self.posMoveList.cbFunction(self.posMoveList.cbData, targets)
                        self.posMoveList = nil;
                        bHaveFinish = true
                    end
                elseif self.posMoveList.cbData and self.posMoveList.cbData.type == 2 then
                    local targets = {}
                    self:SearchRectangleTarget(true, 1.5, self.posMoveList.cbData.collision_width, self, targets, nil, nil, nil, false, nil, nil, nil)
                    for k,v in pairs(targets) do
                        if self.posMoveList.cbData.buffid and self.posMoveList.cbData.bufflv then
                            v:AttachBuff(self.posMoveList.cbData.buffid, self.posMoveList.cbData.bufflv, self.posMoveList.cbData.buff._skillCreator, self.posMoveList.cbData.buff._buffOwner:GetName(), nil, self.posMoveList.cbData.buff._skillGid,nil,nil,self.posMoveList.cbData.buff._skillID, self.posMoveList.cbData.buff._skillLevel)
                        end
                    end
                end
            end
        end
    end
    if bHaveFinish then
        if bTargetUseSpeed then
            self:PostEvent("FinishTransform")
        end
        if bTransformState then
            self:PostEvent("FinishTransform")
        end
        
        if self:IsDead() then
            self:SetNavFlag(false, false);
        else
            self:SetNavFlag(false, true);
        end
    end
end

function SceneEntity:IsAreaTargetExistBuff(radius, buffID, buffLv)
    local target = { }
    self:SearchAreaTarget(true, radius, self, target, nil, 360, nil, nil, false, buffID, buffLv, nil)
    return((#target > 0) and(true) or(false))
end

-- sorttype   nil=不排序 0=距离优先 1=英雄优先距离优先 2=制造伤害量优先 3=生命值少于20%>英雄(boss)>精英>小怪 4=血量最少  5=距离最远
function SceneEntity:SearchAreaTarget(enemy, radius, sourceFounder, arrTarget, targetCnt, angle, direct, sorttype, includeSelf, buffID, buffLv, layerMask, sortRadius)
    local pos_self = self:GetPosition(true);
    local forward_direction = { };
    if direct ~= nil then
        forward_direction.x = direct.x
        forward_direction.y = direct.y
        forward_direction.z = direct.z
    else
        forward_direction.x, forward_direction.y, forward_direction.z = self.object:get_forward();
    end
    -- app.log("dx="..forward_direction.x.." dy="..forward_direction.y.." dz="..forward_direction.z)
    FightScene.SearchAreaTargetEx(enemy, pos_self, radius, forward_direction, angle, layerMask, sourceFounder, arrTarget, targetCnt, sorttype, buffID, buffLv, self, includeSelf, sortRadius)
end

-- sorttype 0距离
function SceneEntity:SearchRectangleTarget(enemy, length, width, sourceFounder, arrTarget, targetCnt, direct, sorttype, includeSelf, buffID, buffLv, layerMask, aroundradius)
    local pos_self = self:GetPosition(true);
    local forward_direction = { }
    if direct ~= nil then
        forward_direction.x = direct.x
        forward_direction.y = direct.y
        forward_direction.z = direct.z
    else
        forward_direction.x, forward_direction.y, forward_direction.z = self.object:get_forward();
    end
    FightScene.SearchRectangleTarget(enemy, pos_self, forward_direction, length, width, layerMask, sourceFounder, arrTarget, targetCnt, sorttype, self, includeSelf, buffID, buffLv, aroundradius)
end

function SceneEntity:SearchAreaTarget_SkillRef(enemy, sourceFounder, skillGID, radius, angle, includeFounder)
    local target = nil;
    local pos_self = self:GetPosition(true);
    local forward_direction = { };
    forward_direction.x, forward_direction.y, forward_direction.z = self.object:get_forward();
    local have_target, targets = FightScene.SearchAreaTarget(pos_self, radius, forward_direction, angle, { PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster })
    if (have_target == true) then
        local targetRet = { }
        local targetIndex = 1
        local minRef = 0xffffff
		for k, v in pairs(targets) do
            local entity = v
            if entity~= nil and entity ~= self and entity:GetHP() > 0 and ((not sourceFounder) or sourceFounder:CheckSearchTarget(entity, enemy)) and (not entity:IsHide()) and (not entity:IsKidnap()) then
                if entity._skillCheckRef[skillGID] == nil then
                    if minRef ~= nil then
                        taregetRet = { }
                        targetIndex = 1
                    end
                    minRef = nil
                    targetRet[targetIndex] = entity
                    targetIndex = targetIndex + 1
                elseif minRef == nil then
                    if entity._skillCheckRef[skillGID] == nil then
                        targetRet[targetIndex] = entity
                        targetIndex = targetIndex + 1
                    end
                elseif entity._skillCheckRef[skillGID] <= minRef then
                    if entity._skillCheckRef[skillGID] ~= minRef then
                        taregetRet = { }
                        targetIndex = 1
                    end
                    minRef = entity._skillCheckRef[skillGID]
                    targetRet[targetIndex] = entity
                    targetIndex = targetIndex + 1
                end
            end
        end
        if includeFounder == true and self:GetCanSearch() and(not self:IsDead()) then
            if self._skillCheckRef[skillGID] == nil then
                if minRef ~= nil then
                    taregetRet = { }
                    targetIndex = 1
                end
                minRef = nil
                targetRet[targetIndex] = self
                targetIndex = targetIndex + 1
            elseif minRef == nil then
                if self._skillCheckRef[skillGID] == nil then
                    targetRet[targetIndex] = self
                    targetIndex = targetIndex + 1
                end
            elseif self._skillCheckRef[skillGID] <= minRef then
                if self._skillCheckRef[skillGID] ~= minRef then
                    taregetRet = { }
                    targetIndex = 1
                end
                minRef = self._skillCheckRef[skillGID]
                targetRet[targetIndex] = self
                targetIndex = targetIndex + 1
            end
        end
        local nLen = #targetRet
        if nLen == 0 then
            return nil
        end
        if nLen == 1 then
            target = targetRet[1]
        else
            local minDistance = 9999;
            for i = 1, nLen do
                local pos_self = self:GetPosition(true);
                local x, y, z = targetRet[i]:GetObject():get_local_position();
                local dis = algorthm.GetDistance(x, z, pos_self.x, pos_self.z);
                if (dis < minDistance) then
                    minDistance = dis;
                    target = targetRet[i];
                end
            end
        end
        if target ~= nil then
            if target._skillCheckRef[skillGID] == nil then
                target._skillCheckRef[skillGID] = 1
            else
                target._skillCheckRef[skillGID] = target._skillCheckRef[skillGID] + 1
            end
        end
        return target
    else
        return nil;
    end
end

function SceneEntity:HandleInitSkillCD()
    for i=1,3 do
        local skill = self:GetSkill(PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX+i)
        if skill then
            skill:StartInitCD()
        end
    end
    
end

function SceneEntity:LearnSkill(skillID, level, ui_index, put_index, save_cd)
    if level == 0 or level == nil then
        level = 1
    end
    --[[if self:IsMyControl() then
        app.log("学习技能"..skillID.."-"..level)
    end]]
	local freeGrid = put_index
    local uiIndex = ui_index
    if freeGrid == nil then
	    for i=1, MAX_SKILL_CNT do
		    if self._arrSkill[i] == nil then
			    freeGrid = i
                uiIndex = ui_all_index[i]
			    break
            else
                if self._arrSkill[i]:GetSkillID() == skillID then
                    self._arrSkill[i]._skillLevel = level
                    return
                end
            end
        end
    end
    if freeGrid == nil then
        app.log("没有技能空间")
        return false
    end
    if uiIndex == nil then
        uiIndex = ui_all_index[freeGrid]
    end
    local skillData = g_SkillData[skillID]
    if not skillData then
        app.log("错误的技能id" .. tostring(skillID).." "..debug.traceback())
        return false
    end
    if self._arrSkill[freeGrid] and not save_cd and self:GetName() == g_dataCenter.fight_info:GetCaptainName() then
        GetMainUI():SkillStopCD(self._arrSkill[freeGrid]._uiIndex)
    end
    local skill_cd_end = nil
    if self._arrSkill[freeGrid] and save_cd then
         skill_cd_end = self._arrSkill[freeGrid]._skillCDEnd
    end
    
    local newSkill = SkillEx:new(self)
    newSkill:InitData(skillData, level)
    newSkill._uiIndex = uiIndex
    newSkill._arrIndex = freeGrid
    if skill_cd_end then
        newSkill._skillCDEnd = skill_cd_end
    end
    self._arrSkill[freeGrid] = newSkill
    local passive_buff = GetSkillPassiveBuff(skillID)
    if passive_buff then
        for k, v in pairs(passive_buff) do
            -- app.log("skillID="..skillID.." level="..level.." buffid="..v.id.." bufflv="..v.lv)
            self:AttachBuff(v.id, v.lv, self:GetName(), self:GetName(), nil, 0, nil, 0, 0, 0, nil, nil, false, nil)
        end
    end
    self.just_learn_skill = true
    --[[if self:IsHero() then
        app.log("学技能id="..skillID.." lv="..level.." freeGrid="..freeGrid)
    end]]
    -- app.log(self.name.." 学习技能 "..skillID)
end

--[[ 挂接BUFF ]]
-- buffID
-- buffLv
-- skillCreator 技能释放者
-- buffCreator  BUFF添加者
-- nestTimes 最大嵌套几次 默认nil
-- skillGid 技能来源唯一GID 默认0
-- directCallBack 回调的方向 默认nil
-- delay 动态延迟 默认0
-- skillID 技能ID 默认0
-- defaultTarget 默认的目标 默认nil
-- skillFrom 来源的技能对象 默认nil
-- isKey 是否为keyBUFF 默认为false
-- overlap 初始化的层数 默认为nil
function SceneEntity:AttachBuff(buffID, buffLv, skillCreator, buffCreator, nestTimes, skillGid, directCallBack, delay, skillID, skillLevel, defaultTarget, skillFrom, isKey, overlap, actionodds)
    if self._buffManager then
        if self:GetTriggerManager() then
            self:GetTriggerManager():OnAddBuff(buffID, buffLv);
        end
        return self._buffManager:AttachBuff(buffID, buffLv, skillCreator, buffCreator, nestTimes, skillGid, directCallBack, delay, skillID, skillLevel, defaultTarget, skillFrom, isKey, overlap, actionodds)
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
        return nil
    end
end

function SceneEntity:DetachBuff(buffID, buffLv, bImmediately)
    if self._buffManager then
        self._buffManager:DetachBuff(buffID, buffLv, bImmediately)
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
    end
end

function SceneEntity:DetachAllBuff()
    if self._buffManager then
        self._buffManager:DetachAllBuff();
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
    end
end

function SceneEntity:DetachBuffObject(buff, bImmediately)
    if self._buffManager then
        self._buffManager:DetachBuffObject(buff, bImmediately)
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
    end
end


function SceneEntity:IsBuffExist(buffID, buffLv)
    if self._buffManager then
        return self._buffManager:IsBuffExist(buffID, buffLv)
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
        return false;
    end
end

function SceneEntity:GetBuffOverlap(buffID, buffLv)
    if self._buffManager then
        return self._buffManager:GetBuffOverlap(buffID, buffLv)
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
        return 0
    end
end


function SceneEntity:CalcuDamageAsTarget(attackerName, damageInfo, skill_id, pure_damage)
    if damageInfo == nil then
        return
    end
    local attacker = ObjectManager.GetObjectByName(attackerName)
    if attacker == nil or attacker._buffManager == nil then
        return
    end
    if self._buffManager == nil then
        return
    end
    if self:GetBuffManager()._invincible then
        if self:GetBuffManager()._invincible_except_gid then
            if attacker:GetGID() ~= self:GetBuffManager()._invincible_except_gid then
                return
            end
        else
            return
        end
    end
    if self:GetBuffManager()._immuneFrontDamage then
        local pos = self:GetPosition()
        local direct = self:GetForWard()
        local target_pos = attacker:GetPosition()
        if algorthm.AtSector(pos.x, pos.z, 100, direct, 180, target_pos.x, target_pos.z) then
            if self._headInfoControler:Check(attacker) then
                self:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ImmuneDamage)
            end
            return
        end
    end
    local _property_ratio = ConfigManager.Get(EConfigIndex.t_property_ratio, 1)
    local isCrit = false
    local isParry = false
    local isDodge = false
    local damage = 0
    if self:GetBuffManager()._specifiedRDamage then
        damage = self:GetBuffManager()._specifiedRDamage
    else
        -- 1.计算基础伤害
        local pureDamage
        if pure_damage then
            pureDamage = pure_damage
        else
            local atk_power = 0
            local fix_ability_damage = 0
            local fix_ability_damage_type = nil
            if not damageInfo.use_fix_attack then

                if damageInfo.damagestep == 0 then
                    fix_ability_damage_type = nil
                elseif damageInfo.damagestep == 1 then
                    fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_1
                elseif damageInfo.damagestep == 2 then
                    fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_2
                elseif damageInfo.damagestep == 3 then
                    fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_3
                elseif damageInfo.damagestep == 4 then
                    fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_4
                elseif damageInfo.damagestep == 5 then
                    fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_5
                end
                if fix_ability_damage_type then
                    fix_ability_damage = attacker:GetPropertyVal(fix_ability_damage_type)
                end
                atk_power = attacker:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
            else
                atk_power = damageInfo.src_atk_power
            end
            pureDamage = fix_ability_damage + damageInfo.fixeddamage + atk_power * damageInfo.atkscale
        end
        -- 2.计算闪避率
        local dodge_rate = self:GetPropertyVal(ENUM.EHeroAttribute.dodge_rate)
        dodge_rate = (dodge_rate/(dodge_rate+_property_ratio.dodge_raio))
        if self:GetBuffManager()._attrFinallyCalcuAdd[1] then
            dodge_rate = dodge_rate + self:GetBuffManager()._attrFinallyCalcuAdd[1];
        end
        dodge_rate = math.floor(dodge_rate*PublicStruct.Const.RANDOM_SCALE)
        if PublicFunc.Key_Random_Int(0, PublicStruct.Const.RANDOM_SCALE-1) < dodge_rate then
            isDodge = true;
            if self._headInfoControler:Check(attacker) then
                self._headInfoControler:ShowArtisticText(ENUM.EHeadInfoShowType.ShanBi)
            end
        end
        if not isDodge then
            -- 3.计算格挡率
            local base_parry_rate = self:GetPropertyVal(ENUM.EHeroAttribute.parry_rate)
            local base_broken_rate = attacker:GetPropertyVal(ENUM.EHeroAttribute.broken_rate)
            local min_compare = ((base_parry_rate>base_broken_rate) and ((base_parry_rate-base_broken_rate)/(base_parry_rate-base_broken_rate+_property_ratio.parry_ratio)) or 0)
            local parry_rate = math.min(1-dodge_rate, min_compare)
            if self:GetBuffManager()._attrFinallyCalcuAdd[2] then
                parry_rate = parry_rate + self:GetBuffManager()._attrFinallyCalcuAdd[2];
            end
            parry_rate = math.floor(parry_rate*PublicStruct.Const.RANDOM_SCALE)
            if PublicFunc.Key_Random_Int(0, PublicStruct.Const.RANDOM_SCALE-1) < parry_rate then
                isParry = true;
                if self._headInfoControler:Check(attacker) then
                    self._headInfoControler:ShowArtisticText(ENUM.EHeadInfoShowType.GeDang)
                end
            end
            -- 4.计算暴击
            if damageInfo.realdamage ~= 1 then
                if self:GetBuffManager()._disposableRDamageCrit then
                    isCrit = true
                    self:GetBuffManager()._disposableRDamageCrit = false
                else
                    local left_compare = ((1-dodge_rate-parry_rate)>0) and (1-dodge_rate-parry_rate) or 0;
                    local base_crit_rate = attacker:GetPropertyVal(ENUM.EHeroAttribute.crit_rate)
                    local base_anti_crite = self:GetPropertyVal(ENUM.EHeroAttribute.anti_crite)
                    local right_compare = ((base_crit_rate>base_anti_crite) and ((base_crit_rate-base_anti_crite)/(base_crit_rate-base_anti_crite+_property_ratio.crite_ratio)) or 0)
                    local crit_rate = math.min(left_compare, right_compare)
                    if self:GetBuffManager()._attrFinallyCalcuAdd[3] then
                        crit_rate = crit_rate + self:GetBuffManager()._attrFinallyCalcuAdd[3];
                    end
                    crit_rate = math.floor(crit_rate*PublicStruct.Const.RANDOM_SCALE)
                    if PublicFunc.Key_Random_Int(0, PublicStruct.Const.RANDOM_SCALE-1) < crit_rate then
                        isCrit = true;
                    end
                end
            end
        end
        -- 5.计算进阶伤害

        if isDodge then
            damage = 0
        else
            local def_power = self:GetPropertyVal(ENUM.EHeroAttribute.def_power)
            if damageInfo.realdamage ~= 1 then
                if damageInfo.damagesegments and damageInfo.damagesegments > 0 then
                    damage = pureDamage-def_power/damageInfo.damagesegments
                else
                    damage = pureDamage-def_power
                end
            else
                damage = pureDamage
            end
            if isParry then
                local parry_plus = self:GetPropertyVal(ENUM.EHeroAttribute.parry_plus)
                local final_attr = self:GetBuffManager()._attrFinallyCalcuAdd[4] or 0
                damage = damage * (0.8-(parry_plus)/(parry_plus+_property_ratio.parry_plus_ratio)-final_attr)
            end
            local restrain_plus = attacker:GetPropertyVal(ENUM.EHeroAttribute.restraint_all_damage_plus)
            if self.config.restraint and self.config.restraint ~= 0 then
                local restraint_info = "restraint"..self.config.restraint.."_damage_plus"
                restrain_plus = restrain_plus + attacker:GetPropertyVal(ENUM.EHeroAttribute[restraint_info])
            end
            local restrain_reduct = self:GetPropertyVal(ENUM.EHeroAttribute.restraint_all_damage_reduct)
            if attacker.config.restraint and attacker.config.restraint ~= 0 then
                local restraint_info = "restraint"..attacker.config.restraint.."_damage_reduct"
                restrain_reduct = restrain_reduct + self:GetPropertyVal(ENUM.EHeroAttribute[restraint_info])
            end
            local restrain_value = ((restrain_plus>=restrain_reduct) and ((restrain_plus-restrain_reduct)/(restrain_plus-restrain_reduct+_property_ratio.restrain_plus_ratio)) or (-(restrain_reduct-restrain_plus)/(restrain_reduct-restrain_plus+_property_ratio.restrain_plus_ratio)))
            local attacker_quan_neng = attacker:GetPropertyVal(ENUM.EHeroAttribute.quan_neng)
            local target_quan_neng = self:GetPropertyVal(ENUM.EHeroAttribute.quan_neng)

            local quan_neng_value = PublicFunc.GetQuanNengRatio(attacker_quan_neng-target_quan_neng)
            --local quan_neng_value = ((attacker_quan_neng>=(target_quan_neng/2)) and ((attacker_quan_neng-target_quan_neng/2)*_property_ratio.quan_neng_ratio) or (-(((target_quan_neng/2)-attacker_quan_neng)*_property_ratio.quan_neng_ratio)))
            damage = damage * (1 + restrain_value + quan_neng_value)
            damage = math.max(1, damage)
        end
        -- 血量影响伤害
        if damageInfo.scalebyhp then
            local curHP = attacker:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
            local maxHP = attacker:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
            local scale = 1 +(1 - curHP / maxHP) * damageInfo.scalebyhp
            damage = damage * scale
        end
        -- 自身血量影响伤害
        if damageInfo.scalebyselfhp then
            local curHP = self:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
            local maxHP = self:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
            local scale = 1 +(1 - curHP / maxHP) * damageInfo.scalebyselfhp
            damage = damage * scale
        end
        if damageInfo.distancebonus then
            local target_pos = attacker:GetPosition();
            local pos = self:GetPosition();
            local dis = algorthm.GetDistance(pos.x, pos.z, target_pos.x, target_pos.z);
            if damageInfo.distance then
                if damageInfo.distance - dis > 0 then 
                    damage = damage * (1+math.floor(damageInfo.distance - dis)*damageInfo.distancebonus)
                end
            else
                damage = damage * (1+math.floor(dis)*damageInfo.distancebonus)
            end
        end
        -- 【先处理所有乘法的】
        -- buff里面的制造额外伤害绝对值
        damage = damage + attacker:GetBuffManager()._nChangeAbsoluteMDamage
        -- buff里面的制造额外伤害缩放值
        for k, v in pairs(attacker:GetBuffManager()._changeScaleMDamage) do
            if math.random(100) < v.odds then
                damage = damage * v.scale
            end
        end
        -- buff里面的受到额外伤害缩放值
        for k, v in pairs(self:GetBuffManager()._changeScaleRDamage) do
            if math.random() <= v.odds then
                damage = damage * v.scale
            end
        end


        -- 处理skill衰减
        if damageInfo.skillrefscale == 1 then
            -- app.log("伤害缩减"..self._skillCheckRef[damageInfo.skillgid])
        end
        -- buff里面的一次性受到额外伤害缩放值
        damage = damage * self:GetBuffManager()._disposableScaleRDamage
        self:GetBuffManager()._disposableScaleRDamage = 1

        damage = damage * attacker:GetBuffManager()._disposableScaleMDamage
        attacker:GetBuffManager()._disposableScaleMDamage = 1

        -- 处理星级范围的对本英雄伤害缩放
        if self.config.rarity then
            local _scaleMDamage2SomeStars = attacker:GetBuffManager()._scaleMDamage2SomeStars
            if _scaleMDamage2SomeStars then
                if _scaleMDamage2SomeStars.type == 0 and self.config.rarity < _scaleMDamage2SomeStars.stars then
                    damage = damage * _scaleMDamage2SomeStars.value
                elseif _scaleMDamage2SomeStars.type == 1 and self.config.rarity > _scaleMDamage2SomeStars.stars then
                    damage = damage * _scaleMDamage2SomeStars.value
                end
            end
        end
        -- 处理特定技能技能释放者的伤害缩放
        if self:GetBuffManager()._damageFromSkillCreatorScale then
            if self:GetBuffManager()._damageFromSkillCreatorGID == attacker:GetGID() then
                damage = damage * self:GetBuffManager()._damageFromSkillCreatorScale
            end
        end
        -- 一次性对特定职业制造额外伤害缩放
        if attacker:GetBuffManager()._changeScaleProMDamage and attacker:GetBuffManager()._changeScaleProMType then
            if self:GetProfession() == attacker:GetBuffManager()._changeScaleProMType then
                damage = damage * attacker:GetBuffManager()._changeScaleProMDamage
            end
        end

        if damageInfo.damagestep > 0 then
            -- buff里面的普通攻击制造额外伤害缩放值
            for k, v in pairs(attacker:GetBuffManager()._changeScaleNormalMDamage) do
                if v.objtype == 0 or bit.bit_and(attacker:GetObjType(), v.objtype) ~= 0 then
                    damage = damage * v.scale
                    v.times = v.times - 1
                    if v.times == 0 then
                        attacker:GetBuffManager()._changeScaleNormalMDamage[k] = nil
                    end
                end
            end
            -- buff里面的普通攻击制造额外伤害绝对值
            for k, v in pairs(attacker:GetBuffManager()._changeAbsoluteNormalMDamage) do
                if bit.bit_and(attacker:GetObjType(), v.objtype) ~= 0 then
                    damage = damage + v.value
                    v.times = v.times - 1
                    if v.times == 0 then
                        attacker:GetBuffManager()._changeAbsoluteNormalMDamage[k] = nil
                    end
                end
            end
            -- 处理一次性普通攻击伤害缩放
            if attacker:GetBuffManager()._disposableNormalDamageScale and attacker:GetBuffManager()._disposableNormalDamageScale ~= 0 then
                damage = damage * attacker:GetBuffManager()._disposableNormalDamageScale
                attacker:GetBuffManager()._disposableNormalDamageScale = 0
            end
            -- 受到技能释放者普攻时伤害增加
            for k, v in pairs(self:GetBuffManager()._addNormalDamageFromSkillCreator) do
                if v.creatorgid == attacker:GetGID() then
                    local skill = attacker:GetSkillBySkillID(v.skillid)
                    if skill then
                        local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,v.skillid)
                        if skillInfo and skillInfo[skill._skillLevel] then
                            local otherDamageInfo = skillInfo[skill._skillLevel].damage[v.infoindex]
                            if otherDamageInfo then
                                local other_atk_power = attacker:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
                                damage = damage + otherDamageInfo.fixeddamage + other_atk_power * otherDamageInfo.atkscale
                            end
                        end
                    end
                end
            end
            -- 处理普通攻击的反弹伤害
            if self:GetBuffManager()._reboundNormalDamageScale ~= 0 then
                local reboundvalue = damage * self:GetBuffManager()._reboundNormalDamageScale
                if reboundvalue > 0 then
                    reboundvalue = math.max(1, reboundvalue)
                    attacker:OnGainHP(- PublicFunc.AttrInteger(reboundvalue), self, false)
                end
            end
            -- 处理普攻制造额外绝对伤害
            if attacker:GetBuffManager()._changeAbsoluteMNormalDamage then
                damage = damage + attacker:GetBuffManager()._changeAbsoluteMNormalDamage
            end
            -- 处理一次性额外普攻伤害
            if attacker._buffManager._disposableAbsoluteMNormalDamage ~= 0 then
                damage = damage + attacker._buffManager._disposableAbsoluteMNormalDamage
                attacker._buffManager._disposableAbsoluteMNormalDamage = 0
            end
        end
        --处理目标血量小于值后伤害增加
        if attacker._buffManager._scaleMDamageByTargetHPPersent and attacker._buffManager._scaleMDamageByTargetHPValue then
            local curHP = self:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
            local maxHP = self:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
            if (curHP/maxHP) < (attacker._buffManager._scaleMDamageByTargetHPPersent/100) then
                damage = damage * attacker._buffManager._scaleMDamageByTargetHPValue
            end
        end
        -- 处理队友血量小于值后伤害增加
        if attacker._buffManager._scaleMDamageByTeamHeroHPValue then
            damage = damage * (1 + attacker:GetBuffManager()._scaleMDamageByTeamHeroHPValue)
        end
        -- 处理背后伤害加成
        -- if self:GetBuffManager()._backScaleRDamage then
        --     local pos = self:GetPosition()
        --     local direct = self:GetForWard()
        --     local target_pos = attacker:GetPosition()
        --     if not algorthm.AtSector(pos.x, pos.z, 100, direct, 180, target_pos.x, target_pos.z) then
        --         if self == FightManager.GetMyCaptain() or FightManager.GetMyCaptain() == attacker then
        --             damage = damage * (1 + self:GetBuffManager()._backScaleRDamage)
        --         end
        --     end
        -- end
        if self:GetBuffManager()._changeFrontScaleDamage then
            local pos = self:GetPosition()
            local direct = self:GetForWard()
            local target_pos = attacker:GetPosition()
            if algorthm.AtSector(pos.x, pos.z, 100, direct, 180, target_pos.x, target_pos.z) then
                damage = damage - self:GetBuffManager()._changeFrontScaleDamageValue
                damage = damage * self:GetBuffManager()._changeFrontScaleDamageScale
            end
            damage = math.max(1, damage);
        end
        -- 【后处理所有加减法的】
        -- buff里面的一次性受到额外伤害绝对值
        damage = damage + self:GetBuffManager()._disposableAbsoluteRDamage
        self:GetBuffManager()._disposableAbsoluteRDamage = 0
        -- 处理伤害转移
        if self:GetBuffManager()._damageTransferObj ~= nil then
            local transfer = ObjectManager.GetObjectByGID(self:GetBuffManager()._damageTransferObj)
            if transfer then
                local transferDamage = damage * self:GetBuffManager()._damageTransferPersent
                transferDamage = math.max(1, transferDamage)
                self:OnGainHP(- transferDamage, attacker, false)
                damage = damage - transferDamage
            end
        end
        -- 根据时间计算伤害
        if damageInfo.scalebytime == 1 then

        end
        -- 根据BUFF层数计算伤害
        if damageInfo.scalebybuff == 1 then
            local overlap = self._buffManager:GetBuffOverlap(damageInfo.buffid, damageInfo.bufflv)
            if overlap > 0 then
                damage = damage +(damage *(overlap - 1) * damageInfo.buffscale)
            end
        end
        -- 处理一次性额外伤害
        if attacker._buffManager._disposableAbsoluteMDamage ~= 0 then
            damage = damage + attacker._buffManager._disposableAbsoluteMDamage
            attacker._buffManager._disposableAbsoluteMDamage = 0
        end
        --处理额外伤害池
        if attacker._buffManager._extraDamagePool ~= 0 then
            damage = damage + attacker._buffManager._extraDamagePool
        end
        -- 免疫一次技能伤害
        if damageInfo.damagestep == 0 and self._buffManager._bDisposableImmuneSkillDamage then
            damage = 0
            self._buffManager._bDisposableImmuneSkillDamage = false
            if self:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID and self:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID[1] then
                EffectManager.deleteEffect(self:GetBuffManager()._bDisposableImmuneSkillDamageEffectUUID[1])
            end
            if self._headInfoControler:Check(attacker) then
                self._buffOwner:GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.ImmuneDamage)
            end
        end
        if isCrit then
            local crit_hurt = attacker:GetPropertyVal(ENUM.EHeroAttribute.crit_hurt)
            local final_attr = self:GetBuffManager()._attrFinallyCalcuAdd[5] or 0
            damage = damage * (1.5+(crit_hurt)/(crit_hurt+_property_ratio.crit_hurt_ratio)+final_attr)
            -- 一次性暴击伤害增加
            -- damage = damage * self:GetBuffManager()._disposableScaleMCritHurt;
            -- self:GetBuffManager()._disposableScaleMCritHurt = 1;
        end
        -- 计算伤害护盾吸收
        if self._buffManager._bAbsorbDamage then
            if damage > self._buffManager._lastAbsorbDamage then
                damage = damage - self._buffManager._lastAbsorbDamage
                self._buffManager._lastAbsorbDamage = 0
                self._buffManager._bAbsorbDamage = false
                if self._buffManager._absorbDamageSrcBuff then
                    self:DetachBuff(self._buffManager._absorbDamageSrcBuff.buffid, self._buffManager._absorbDamageSrcBuff.bufflv, true)
                    self._buffManager._absorbDamageSrcBuff = nil
                end
                if self._buffManager._BuffLvAbsorbDamage and self._buffManager._BuffIDAbsorbDamage then
                    self:AttachBuff(self._buffManager._BuffIDAbsorbDamage, self._buffManager._BuffLvAbsorbDamage, self:GetName(), self:GetName(), nil, 0, nil, 0, self._buffManager._SkillIDAbsorbDamage, self._buffManager._SkillLevelAbsorbDamage, nil, nil, false, nil);
                end
            else
                self._buffManager._lastAbsorbDamage = self._buffManager._lastAbsorbDamage - damage
                damage = 0
            end
        end
    end
    damage = PublicFunc.AttrInteger(damage)
    if damage > 0 then
        local cur_hp = self:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
        if attacker:GetBuffManager()._bRecordDamage then
            attacker:GetBuffManager()._nRecordDamage = attacker:GetBuffManager()._nRecordDamage + damage
        end
        --[[if not self:IsMyControl() then
            app.log("damage="..damage)
        end]]
        self:OnGainHP(- damage, attacker, isCrit, skill_id)
        attacker._makeDamage = attacker._makeDamage + damage
        -- 处理吸血
        local bloodsuck_rate = attacker:GetPropertyVal(ENUM.EHeroAttribute.bloodsuck_rate)
      --app.log(attacker.name.." bloodsuck_rate="..bloodsuck_rate)
        -- if attacker._buffManager._bSuckBlood then
        --     bloodsuck_rate = bloodsuck_rate + attacker._buffManager._suckBloosPersent
        -- end
        local final_bloodsuck_rate_add = self:GetBuffManager()._attrFinallyCalcuAdd[6] or 0
        if bloodsuck_rate > 0 or final_bloodsuck_rate_add ~= 0 then
            local suck_damage = math.min(cur_hp, damage)
            local suck_value = suck_damage * (bloodsuck_rate/(bloodsuck_rate+_property_ratio.bloodsuck_rate_ratio)+ final_bloodsuck_rate_add);
            if suck_value > 0 then
                suck_value = math.max(1, suck_value)
                attacker:OnGainHP(PublicFunc.AttrInteger(suck_value))
            end
        end

        -- 处理反弹
        local rally_rate = self:GetPropertyVal(ENUM.EHeroAttribute.rally_rate)
        local final_rally_rate_add = self:GetBuffManager()._attrFinallyCalcuAdd[7] or 0
        if rally_rate > 0 or final_rally_rate_add ~= 0 then
            local rally_value = damage * (rally_rate/(rally_rate+_property_ratio.rally_rate_ratio) + final_rally_rate_add)
            if rally_value > 0  then
                rally_value = math.max(1, rally_value)
                attacker:OnGainHP(-PublicFunc.AttrInteger(rally_value), self, false, nil)
            end
        end
        if self:GetBuffManager()._bDamageRebound then
            local reboundvalue = damage * self:GetBuffManager()._damageReboundScale
            if self:GetBuffManager()._damageReboundType == nil then
                if self:GetBuffManager()._damageReboundCalcuAbilityName ~= nil then
                    reboundvalue = reboundvalue + self:GetPropertyVal(self:GetBuffManager()._damageReboundCalcuAbilityName) * self:GetBuffManager()._damageReboundCalcuScale
                end
            elseif self:GetBuffManager()._damageReboundType == 1 then
                if self._buffOwner:GetBuffManager()._damageReboundCalcuInfoindex ~= nil then
                    reboundvalue = reboundvalue + self:CalcuDamageFormula(self:GetName(), self._buffOwner:GetBuffManager()._damageReboundCalcuInfoindex)
                end
            end
            if reboundvalue > 0 then
                reboundvalue = math.max(1, reboundvalue)
                attacker:OnGainHP(- PublicFunc.AttrInteger(reboundvalue), self, false)
            end
        end
    end
    if damage > 0 then
        self:CallBeAttackedCallbackFunc(attacker)
        attacker:CallAttackedCallbackFunc(self)
        return damage
    end
end

function SceneEntity:CalcuDamageFormula(attackerName, damageInfo)
    if damageInfo == nil then
        return 0;
    end
    local attacker = nil
    if attackerName == nil then
        attacker = self
    else
        attacker = ObjectManager.GetObjectByName(attackerName)
    end
    if attacker == nil then
        return 0;
    end
    -- 1.计算伤害值
    local damage = 0
    local atk_value = 0
    local fix_ability_damage = 0
    local fix_ability_damage_type = nil
    if not damageInfo.use_fix_attack then
        if damageInfo.damagestep == 0 then
            fix_ability_damage_type = nil
        elseif damageInfo.damagestep == 1 then
            fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_1
        elseif damageInfo.damagestep == 2 then
            fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_2
        elseif damageInfo.damagestep == 3 then
            fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_3
        elseif damageInfo.damagestep == 4 then
            fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_4
        elseif damageInfo.damagestep == 5 then
            fix_ability_damage_type = ENUM.EHeroAttribute.normal_attack_5
        end
        if fix_ability_damage_type then
            fix_ability_damage = attacker:GetPropertyVal(fix_ability_damage_type)
        end
        atk_value = attacker:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
    else
        atk_value = damageInfo.src_atk_power
    end
    pureDamage = fix_ability_damage + damageInfo.fixeddamage + atk_value * damageInfo.atkscale
    damage = math.max(1, pureDamage)
    return damage;
end

function SceneEntity:CalcuRecoverFormula(attackerName, damageInfo)
     if damageInfo == nil then
        return 0;
    end
    local attacker = ObjectManager.GetObjectByName(attackerName)
    if attacker == nil then
        return 0;
    end
    local atk_power = attacker:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
    local recover = damageInfo.fixeddamage + atk_power*damageInfo.atkscale;
    local crit_rate = attacker:GetPropertyVal(ENUM.EHeroAttribute.crit_rate)
    local _property_ratio = ConfigManager.Get(EConfigIndex.t_property_ratio, 1)
	if math.random() < (crit_rate/(crit_rate+_property_ratio.crite_ratio)) then
		recover = recover * 1.2;
    end
	local treat_plus = attacker:GetPropertyVal(ENUM.EHeroAttribute.treat_plus);
	recover = recover * ((treat_plus>0) and (1+treat_plus/(treat_plus+_property_ratio.treat_plus_ratio)) or (1+treat_plus/(_property_ratio.treat_plus_ratio-treat_plus)))
    return math.floor(recover);
end

function SceneEntity:CalcuRecoverHPAsTarget(fixvalue, healerName, calcuInfo)
    local finalValue = fixvalue
    for k, v in pairs(self:GetBuffManager()._recoverHPScale) do
        finalValue = finalValue * v
    end
    self:OnGainHP(finalValue)
    if self:GetBuffManager()._bRecoverHPFeedback then
        local healer = ObjectManager.GetObjectByName(healerName)
        if healer then
            healer:OnGainHP(finalValue * self:GetBuffManager()._recoverHPFeedbackScale)
        end
    end
end

function SceneEntity:CalcuDamageAbsorbAsTarget(calcuInfo)
    if calcuInfo == nil then
        return 0
    end
    local atk_value = self:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
    return PublicFunc.AttrInteger(calcuInfo.fixeddamage + atk_value * calcuInfo.atkscale)
end

function SceneEntity:SetNewRotation(angle)
    self._newRotation = angle
end

function SceneEntity:SetSlowRotation(angle)
    self._slowRotation = angle
    if self._slowRotation > 360 then
        self._slowRotation = self._slowRotation - 360
    end
end

function SceneEntity:Rotate2New()
    if self._newRotation ~= nil then
        self:SetRotation(0, self._newRotation, 0)
    end
    self._newRotation = nil
end

function SceneEntity:CheckStateValid(state)
    if state == EHandleState.Move then
        local bExecute = true
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
            if not self:IsMyControl() and not self:IsAIAgent() then
                bExecute = false;
            end
        end

        if self:GetBuffManager().kidnaperGID then
            return false;
        end

        if self._buffManager and(self._buffManager:IsInSpecialEffect(ESpecialEffectType.DingShen) or
            self._buffManager:IsInSpecialEffect(ESpecialEffectType.XuanYun)) then
            return false
        end

        if self.canMoveWhenSkill and self.canMoveWhenSkillID == self.last_used_skill then
            return true;
        end

        if bExecute and not self.lastSkillComplete and self:GetExternalArea("canSkillChange") == false then
            return false
        end
    elseif state == EHandleState.Manual then
        if self.canMoveWhenSkill and self.canMoveWhenSkillID == self.last_used_skill then
            return true;
        end
        if not self.lastSkillComplete and self:GetExternalArea("canSkillChange") == false then
            return false
        end

    end
    return true
end

function SceneEntity:GetLastSkillComplete()
    if self.lastSkillComplete == true then
        return true
    end
    return false
end

function SceneEntity:IsSkillInWorking()
    for i = 1, MAX_SKILL_CNT do
        if self._arrSkill[i] ~= nil then
            if self._arrSkill[i]:IsWorking() then
                return true
            end
        end
    end
    return false
end

function SceneEntity:GetBuffManager()
    return self._buffManager
end

function SceneEntity:OnUseSkill(skill, targetGID)
    self:SetExternalArea("selectedSkill", false)
    if self._buffManager then
        if self._buffManager._buffID2AttachWhenUseSkill ~= 0 and self._buffManager._buffLv2AttachWhenUseSkill ~= 0 then
            self:AttachBuff(self._buffManager._buffID2AttachWhenUseSkill, self._buffManager._buffLv2AttachWhenUseSkill, self._buffManager._buffCreator2AttachWhenUseSkill,
            self._buffManager._buffCreator2AttachWhenUseSkill, nil, 0, nil, 0, self._buffManager._buff2AttachSkillIDWhenUseSkill,
            self._buffOwner:GetBuffManager()._buff2AttachSkillLevelWhenUseSkill, nil, nil, false, nil)
        end
        self._buffManager:CheckRemove(eBuffPropertyType.RemoveOnUseSkill)
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
    end

    local myobj = FightManager.GetMyCaptain();
    if myobj and myobj:GetGID() == self:GetGID() and GetMainUI() then
        if GetMainUI():GetWorldTreasureBox() then
            GetMainUI():GetWorldTreasureBox():on_cancel_open_treasure_box();
        end
        if GetMainUI():GetTaskLoadingBarUI() then
            GetMainUI():GetTaskLoadingBarUI():Hide();
        end
    end
    --[[if FightScene.GetPlayMethodType() == nil then
        self.mmo_fight_state_begin_time = PublicFunc.QueryCurTime()
    end]]
    if skill then
        self.last_used_skill = skill:GetID()
    end
    if FightScene.GetFightManager()._className == "PeakShowFightManager" and self:GetName() == "Monster_1_7" then
        app.log("巅峰展示 使用技能"..tostring(self.last_used_skill))
    end
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        local pos = self:GetPosition();
        local frame_info = {}
        frame_info.type = ENUM.FightKeyFrameType.UseSkill
        frame_info.integer_params = {}
        frame_info.string_params = {}
        table.placeholder_insert_number(frame_info.integer_params, skill:GetID())
        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(pos.x))
        table.placeholder_insert_number(frame_info.integer_params, PublicFunc.Trans2ServerPos(pos.z))
        table.placeholder_insert_number(frame_info.integer_params, self:GetGID())
        table.placeholder_insert_number(frame_info.integer_params, skill._skillData.cdtype)
        FightKeyFrameInfo.AddKeyInfo(frame_info)
    end
    self.is_initiative_move = false

    if skill then
        self:GetAniCtrler().isCombo = skill:IsComboSkill();
    end

    NoticeManager.Notice(ENUM.NoticeType.EntityUseSkill, self, skill:GetID(), targetGID);
end

function SceneEntity:OnHitted()
    if self._buffManager then
        self._buffManager:CheckRemove(eBuffPropertyType.RemoveOnHitted)
    else
        app.log_warning("buffManager=nil " .. debug.traceback())
    end

    local myobj = FightManager.GetMyCaptain();
    if myobj and myobj:GetGID() == self:GetGID() and GetMainUI() then
        if GetMainUI():GetWorldTreasureBox() then
            GetMainUI():GetWorldTreasureBox():on_cancel_open_treasure_box();
        end
        if GetMainUI():GetTaskLoadingBarUI() then
            GetMainUI():GetTaskLoadingBarUI():Hide();
        end
    end

    LocalModeAbortReborn()
    --[[if FightScene.GetPlayMethodType() == nil then
        self.mmo_fight_state_begin_time = PublicFunc.QueryCurTime()
    end]]
    NoticeManager.Notice(ENUM.NoticeType.EntityHitted, self);
end

function SceneEntity:OnBeginMove()
    local myobj = FightManager.GetMyCaptain();
    if myobj and myobj:GetGID() == self:GetGID() and GetMainUI() then
        if GetMainUI():GetWorldTreasureBox() then
            GetMainUI():GetWorldTreasureBox():on_cancel_open_treasure_box();
        end
        -- if GetMainUI():GetTaskLoadingBarUI() then
        --     GetMainUI():GetTaskLoadingBarUI():Hide();
        -- end
        NoticeManager.Notice(ENUM.NoticeType.EntityBeginMove, self)
    end
end
---------外部区域临时变量区-----------

-- 获取外部区域临时变量
function SceneEntity:GetExternalArea(name)
    return self.externalArea[name];
end
-- 设置外部区域临时变量
function SceneEntity:SetExternalArea(name, value)
    if not self.externalAreaState[name] then
        self.externalArea[name] = 0;
    end
    if type(value) == "number" then
        self.externalArea[name] = (self.externalArea[name] or 0) + value;
    else
        self.externalArea[name] = value;
    end
    --[[if self:GetCampFlag() == 1 and ("canSkillChange"==name or "skillChange"==name) then
        app.log("set "..name.."="..tostring(value).."  "..debug.traceback())
    end]]
end
-- 设置外部区域临时变量
function SceneEntity:SetExternalAreaState(name, value)
    self.externalAreaState[name] = value;
end

function SceneEntity:GetType()
    return self.config.type or -1;
end

function SceneEntity:CheckToChangeAI()

    if self.__execCloseAIImpl == true then
        self:CloseAIImpl()
    end

    if self.__nextAIID ~= nil then
        --        if self:IsDead() then
        --            self.__nextAIID = nil
        --        else
        --            if AI_CurrentStateCanInterrupt(self) then
        --                self:__SetAI(self.__nextAIID)
        --                self.__nextAIID = nil
        --            end
        --        end

        if AI_CurrentStateCanInterrupt(self) and not self:IsDead() then
            self:__SetAI(self.__nextAIID, self.__nextAIParam)
            self.__nextAIID = nil
            self.__nextAIParam = nil
        end
    end
end

function SceneEntity:SetAI(id, param)
    --app.log('app.log self:GetName()=='..self:GetName().."id=="..id.."   " .. debug.traceback())
    -- if self:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
    --     if self.__ai_id == nil then
    --         self:__SetAI(id)
    --     else
    --         self.__nextAIID = id
    --     end
    -- end
    if self._beginAnim ~= nil and self._beginAnim ~= 0 then
        self._delayAi = id;
        self._delayAiParam = param;
        return;
    end

    if ConfigManager.Get(EConfigIndex.t_hfsm,id) == nil then
        app.log("SceneEntity:SetAI ai id error! id=" .. tostring(id) .. ' ' .. debug.traceback())
        return
    end

    -- if self:IsMonster() then
    --     id = 143
    -- end

    if self.__ai_id == nil then
        self:__SetAI(id, param)
    else
        self.__nextAIID = id
        self.__nextAIParam = param
    end

    -- if self:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
    --     if self.__ai_id == nil then
    --         self:__SetAI(id, param)
    --     else
    --         self.__nextAIID = id
    --         self.__nextAIParam = param
    --     end
    -- end

    self:CheckToChangeAI()
end

function SceneEntity:GetAI()
    return self.__ai_id
end

function SceneEntity:CloseAI()
    self.__execCloseAIImpl = true
end

function SceneEntity:CloseAIImpl()

    self.__execCloseAIImpl = nil

    if self.ai_fsm ~= nil then
        --self:SetState(ESTATE.Stand)
        self:CancelSkillAllCan()
        self.ai_fsm:Close()

        self.__event_mgr = { eventQueue = {} }
    end
    self.ai_fsm = nil
    self.__ai_id = nil
    self.__isPause = nil
end

function SceneEntity:SetHFSMKeyValueFromConfig(fsm, id)
    local result = true
    local keys
    local hfsmConfig = ConfigManager.Get(EConfigIndex.t_hfsm,id)
    if hfsmConfig then
        keys = hfsmConfig.keys
    else
        app.log("set ai error. id :" .. tostring(id));
        return false;
    end

    if keys.base_id then
        result = self:SetHFSMKeyValueFromConfig(fsm, keys.base_id)
        if not result then
            return result
        end
    end

    fsm:SetMultiKeyValue(keys)
    return result
end

function SceneEntity:__SetAI(id, param)
    -- app.log('__SetAI ' .. id .. ' ' .. self:GetName() .. ' ' .. debug.traceback())
    if self.__ai_id == id then
        -- 已经是该AI
        PublicFunc.msg_dispatch("SceneEntity_SetAI_AutoPathFinding", id);
        return
    end

    -- app.log('__SetAI 1 ')

    self:InitHFSMData()
    self.hfsmEntityAllLiveData = self.hfsmEntityAllLiveData or { }
    self:CloseAIImpl()
    self.ai_fsm = HFSM:new( {
        name = "hfsm",
        object = self
        -- , log = true
    } )

    self.__ai_id = id
    self.ai_fsm:ClearAllKeyValue()
    local res = self:SetHFSMKeyValueFromConfig(self.ai_fsm, id)
    if not res then return end

    self.ai_fsm:SetMultiKeyValue(param)
    if type(self.config) == 'table' and type(self.config.ai_param) == 'table' then
        self.ai_fsm:SetMultiKeyValue(self.config.ai_param)
    end

    local file = "character"
    if self.ai_fsm:ExistKey('hfsm_file') then
        file = self.ai_fsm:GetKeyValue('hfsm_file')
    end

    self.ai_fsm:Load(file)
    self:SetSkillUseByAIHFSM(true)

end

function SceneEntity:InitHFSMData()
    self.hfsmData = { }

    
    self.hfsmData.AI_DetectedEnemyJustAccordingToTypeMyPosOut = {}
    self.hfsmData.SearchAllEnemyOnAroundPosOut = {}
    self.hfsmData.HeroStandToOtherHeroIsTooClosedMyPos = Vector3d:new({x = 0, y = 0, z = 0})
    self.hfsmData.lastAttackMeTime = 0
end

function SceneEntity:GetHFSMData()
    return self.hfsmData
end

function SceneEntity:ClearHFSMData()
    self.hfsmData = { }
end

function SceneEntity:GetHfsmEntityAllLiveData()
    return self.hfsmEntityAllLiveData
end

-- function SceneEntity:IsManualWay()
--    return self.__ai_id == ENUM.EAI.MainHero
-- end

function SceneEntity:EnableBehavior(is_enable)
    if self:IsMonster() then
        if is_enable then
            local aiId = self.config.ai
            if self.ai_fsm ~= nil then
                self.ai_fsm:Close()
                self.ai_fsm = nil
                self.__ai_id = nil
            end
            if aiId ~= nil then
                self:SetAI(aiId)
            end
        else
            if self.ai_fsm ~= nil then
                self.ai_fsm:Close()
                self.ai_fsm = nil
                self.__ai_id = nil
            end
        end
    elseif self:IsHero() then
        if is_enable then
            if self.ai_fsm ~= nil then
                self.ai_fsm:Close()
                self.ai_fsm = nil
                self.__ai_id = nil
            end
            if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
                if self:IsMyControl() then
                    self:SetAI(ENUM.EAI.ThreeVThreeAutoFight)
                else
                    self:SetAI(ENUM.EAI.ThreeVThreeRobot)
                end
                self:SetConfig("view_radius", 8)
                self:SetConfig("act_radius", 100)
            elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_1v1 then
                self:SetAI(100)
                self:SetConfig("view_radius", 100)
                self:SetConfig("act_radius", 100)
            else
                self:SetAI(117)
                self:SetConfig("view_radius", 100)
                self:SetConfig("act_radius", 100)
            end
        else
            if self.ai_fsm ~= nil then
                self.ai_fsm:Close()
                self.ai_fsm = nil
                self.__ai_id = nil
            end
        end
    end
end


function SceneEntity:IsInPosMove()
    if self.posMoveList then
        return true
    end
    return false
end

function SceneEntity:CanCloseCurrSkill()
    if self:GetLastSkillComplete() == true or self:GetExternalArea("canSkillChange") then
        return true
    end

    local skill = self.currSkillEx

    if skill and skill:IsWorking() and not SkillManager.CanCancelSkill(self, skill, true) then
        return false
    end

    -- for i = 1, MAX_SKILL_CNT do
    --     local skill = self._arrSkill[i]
    --     if skill ~= nil then
    --         if skill:IsWorking() and not SkillManager.CanCancelSkill(self, skill, true) then
    --             return false
    --         end
    --     end
    -- end

    return true
end

function SceneEntity:CancelSkillAllCan(initiativeIndex)
    for i = 1, MAX_SKILL_CNT do
        if self._arrSkill[i] ~= nil then
            local ative = true
            if initiativeIndex ~= nil then
                ative = initiativeIndex == i
            end
            if SkillManager.CancelSkill(self, self._arrSkill[i], ative) then
                return true, self._arrSkill[i]
            end
        end
    end
    return false, nil
end

function SceneEntity:AddSummonMonster(name)
    if self.summon_monster_list == nil then
        self.summon_monster_list = {}
    end
    self.summon_monster_list[name] = name
end

function SceneEntity:DelSummonMonster(name)
    if self.summon_monster_list == nil then
        return
    end
    self.summon_monster_list[name] = nil
end

function SceneEntity:AddManagedEffect(effect_obj, bind_point_id)
    local bind_pos = self:GetObject()

    if bind_point_id ~= nil then
        --        local bind_pos_name = ConfigManager.Get(EConfigIndex.t_model_bind_pos,bind_point_id)
        bind_pos = self:GetBindObj(bind_point_id)
    end
    effect_obj:set_parent(bind_pos)

    table.insert(self.managedEffectList, effect_obj)
end

function SceneEntity:SetOwnerPlayerName(name)
    self.owner_player_name = name
end

function SceneEntity:SetOwnerPlayerGID(owner_gid)
    self.owner_player_gid = owner_gid
    if self:IsMyControl() then
        --        if FightScene.GetHudleSkillEnable(2) then
        --            self:LearnSkill(PublicStruct.Recover_Skill_ID, 1, 7)
        --        end
        self:KeepNormalAttack(true)

        -- 计算AI哪些技能可以使用
        if self.card and self.card.rarity then
            self.tabSkillIndex = { };
            for i = 1, 3 do
                local skillIndex = PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX + i
                if self._arrSkill[skillIndex] then
                    if FightScene.GetHudleSkillEnable(i + 2) then
                        table.insert(self.tabSkillIndex, skillIndex);
                    end
                end
            end
            -- 当前关卡是否可以使用普攻
            if FightScene.GetHudleSkillEnable(1) then
                table.insert(self.tabSkillIndex, 1);
            end
        end
    end
    if self.ui_hp then
        self.ui_hp:UpdateUi();
    end
end

function SceneEntity:SetVIPLevel(vip_level)
    self.vip_level = vip_level
end

function SceneEntity:SetGuildName(guild_name)
    self.guild_name = guild_name
end

function SceneEntity:IsMyControl()
    if self.owner_player_gid then
        return self.owner_player_gid == g_dataCenter.player:GetGID()
    end
    return false
end


function SceneEntity:IsAIAgent()
    return(g_dataCenter.fight_info.ai_agent_target_gid[self:GetGID()] ~= nil)
end

function SceneEntity:GetOwnerPlayerGID()
    return self.owner_player_gid
end


function SceneEntity:SetOnDeadCallBack(callback)
    self.OnDeadCallBack = callback
end


function SceneEntity:AddFrozenTarget(target_name)
    self.frozenTargetList = self.frozenTargetList or { };
    if self.frozenTargetList[target_name] ~= nil then
        return
    end
    self.frozenTargetList[target_name] = target_name
end

function SceneEntity:GetFrozenTargetList()
    return self.frozenTargetList
end

-- 播放高光
function SceneEntity:PlayShine()
    self.oldShowRimLight = self.showRimLight;
    -- 先关闭描边
    --self:ShowRimLight(false);
    -- 然后开启高亮
    for k, v in ipairs(self.shineList) do
        v:Start(self.shineList.shinePower, self.shineList.shineReduce);
    end
end

function SceneEntity:ShowRimLight(show)
    --[[if show then
        if self:IsCloseSuper() or self:IsFarSuper() or self:IsDead() then
            return;
        end
    end
    --有三个玩法不做处理
    local n = FightScene.GetPlayMethodType();
    if n == MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa or n == MsgEnum.eactivity_time.eActivityTime_trial 
        or n == MsgEnum.eactivity_time.eActivityTime_arena then
        return;
    end
    self.showRimLight = show;
    for k, v in ipairs(self.shineList) do
        v:SetSelect(show);
    end]]
end

-- 开启主角光环
function SceneEntity:OpenGain(open)
    -- if open then
    --     for k, v in pairs(self.gainMaterialList) do
    --         v:set_material_color_with_name("_Color", self.gainColor.r, self.gainColor.g, self.gainColor.b, self.gainColor.a);
    --         -- v:set_material_float_with_name("_ViewInten", self.gainPower)
    --         v:set_material_float_with_name("_LightProbOpenFlag", 0);
    --     end
    -- else
    --     for k, v in pairs(self.gainMaterialList) do
    --         v:set_material_color_with_name("_Color", self.oldGainColor.r, self.oldGainColor.g, self.oldGainColor.b, self.oldGainColor.a);
    --         -- v:set_material_float_with_name("_ViewInten", self.oldGainPower)
    --         v:set_material_float_with_name("_LightProbOpenFlag", 1);
    --     end
    -- end
end

function SceneEntity:set_active(isShow)
    if self.object then
        self.object:set_active(isShow)
    end
end

function SceneEntity:set_layer(layer,has_childe)
    self.object:set_layer(layer,has_childe)
end

-- 隐藏/显示主角
function SceneEntity:ShowHero(isShow)
    -- app.log("222222222"..tostring(isShow));
    if self.hero_is_show == isShow then
        return
    end
    self.hero_is_show = isShow;
    local childCount = self.object:get_child_count();
    for i = 0, childCount - 1 do
        local child = self.object:get_child_by_index(i);
        child:set_active(isShow);
    end
    if self.InvisiMateCfg then
        local InvisibleMaterial = asset_game_object.find(self.name .. "/" .. self.InvisiMateCfg.mat_name);
        if InvisibleMaterial then
            InvisibleMaterial:set_active(false);
        end
    end
    if --[[not self:IsMyControl() and]] self.aperture_manager then
        self.aperture_manager:ShowAperture(isShow)
    end
end

function SceneEntity:ShowHP(isShow)
    if self.hide_hp then
        return
    end
    --怪物根据配置来设定是否显示血条
    if self:IsMonster() then
        if isShow then
            isShow = self.config.show_hp > 0;
        end
    end
    if isShow == nil then
        isShow = true;
    end
    if self.old_show_hp_state == isShow then
        return
    end
    self.old_show_hp_state = isShow
    if self.ui_hp then
        self.ui_hp:ShowHP(isShow);
    end
    if self.ui_hp_new then
        self.ui_hp_new:SetIsShow(isShow);
    end
end

function SceneEntity:GetHPIsShow()
    return self.old_show_hp_state
end

-----------------------------技能音效相关----------------------------------------------
function SceneEntity:SetCurSkillAudio(id, numAdObj)
    self.curSkillAudioId = id;
    self.curSkillAudioNumAdObj = numAdObj;
end

function SceneEntity:StopCurSkillAudio()
    if self.curSkillAudioId and self.curSkillAudioNumAdObj then
        local audioObj = AudioManager.GetAudio3dObject(self.curSkillAudioId, self.curSkillAudioNumAdObj)
        if audioObj then
            AudioManager.Stop3dAudio(audioObj, self.curSkillAudioId, self.curSkillAudioNumAdObj, false);
        end
        self.curSkillAudioId = nil;
        self.curSkillAudioNumAdObj = nil;
    end
end

function SceneEntity:OnRecUseSkillMessage(info)
    if self:IsMyControl() or self:IsAIAgent() then
        return
    end
    if self:IsDead() then
        return
    end
    if info.aperture_posx < 9000 and info.aperture_posy < 9000 and info.aperture_posz < 9000 then
        if self and self.aperture_manager then
            self.aperture_manager.syncRTPosition = {}
            self.aperture_manager.syncRTPosition.x = info.aperture_posx
            self.aperture_manager.syncRTPosition.z = info.aperture_posz
            self.aperture_manager.syncRTPosition.y = info.aperture_posy
        end
    end
    if info.targets_info.user_gid ~= 0 then
        FightScene.AddSkillTargets(info.targets_info.user_gid, info.targets_info.skill_id, info.targets_info.buff_id, info.targets_info.trigger_index, info.targets_info.action_index, info.targets_info.action_ref, info.targets_info.targets_gid)
    end
    
    local pos = self:GetPosition()
    if algorthm.GetDistanceSquared(pos.x, pos.z, info.x * PublicStruct.Coordinate_Scale_Decimal, info.z * PublicStruct.Coordinate_Scale_Decimal) > 4 then
        self:SetPosition(info.x * PublicStruct.Coordinate_Scale_Decimal, 2, info.z * PublicStruct.Coordinate_Scale_Decimal, true, true)
    end
    local forward_direction = { }
    forward_direction.x, forward_direction.y, forward_direction.z = self.object:get_forward();
    forward_direction.x = info.towards_x
    forward_direction.z = info.towards_z
    self.object:set_forward(forward_direction.x, forward_direction.y, forward_direction.z)
    -- app.log("收到技能包 dx="..forward_direction.x.." dz="..forward_direction.z)
    local default_target = ObjectManager.GetObjectByGID(info.default_target_gid)
    self:SetState(ESTATE.Stand)
    local skill = self:GetSkillBySkillID(info.skill_id)
    skill.action_odds = info.action_odds
    self:SetCurSkill(skill)
    self:SetAttackTarget(default_target)
    self:PlaySkill(true)
    if info.movex ~= 0 and info.movez ~= 0 and not self:IsCaptain() then
        local pos = self:GetPosition()
        local dir = self:GetForWard()
        local tx, ty, tz
        if skill._skillInfo.captain_attack_skate_dis > 0 and (not self:IsInPosMove()) then
            tx = pos.x + dir.x*skill._skillInfo.captain_attack_skate_dis
            tz = pos.z + dir.z*skill._skillInfo.captain_attack_skate_dis
            ty = pos.y
            self:PosMoveToPos(nil, tx, ty, tz, skill._skillInfo.captain_attack_skate_time, nil, nil, nil, nil, nil, nil, nil)
        end
    end
    
    -- self:SetState(ESTATE.Attack)
    if default_target and default_target ~= 0 and skill then
        local target = ObjectManager.GetObjectByGID(default_target)
        if target then
            local target_pos = target:GetPosition()
            if algorthm.GetDistance(pos.x, pos.z, target_pos.x, target_pos.z) >(skill:GetDistance() + 2) then
                msg_move.cg_request_real_position(default_target)
            end
        end
    end
end

function SceneEntity:SetCurSkill(skill)
    -- app.log("设置技能..id="..skill:GetID())
    self.currSkillEx = skill
end

function SceneEntity:OnRecCancelSkillMessage(skill_id)
    local skill = self:GetSkillBySkillID(skill_id)
    if skill then
        skill:Cancel()
    end
end

function SceneEntity:ReplaceAnimID(old_id, new_id)
    self.aniCtroller:ReplaceAnimID(old_id, new_id)
end

function SceneEntity:ChangeFightStateTarget(target_name, is_initiative, is_add, info)
    local old_targets_cnt = self.fight_state_targets_cnt
    if is_add then
        if is_initiative then
            if self.fight_state_initiative_targets[target_name] == nil then
                self.fight_state_initiative_targets[target_name] = target_name
                self.fight_state_targets_cnt = self.fight_state_targets_cnt + 1
                --[[if self:GetCampFlag() == 1 then
                    app.log("self="..self.config.name.." 增加主动计数 name="..target_name.." cnt="..self.fight_state_targets_cnt.."info="..tostring(info))
                end]]
            end
        else
            if self.fight_state_passivity_targets[target_name] == nil then
                self.fight_state_passivity_targets[target_name] = target_name
                self.fight_state_targets_cnt = self.fight_state_targets_cnt + 1
                --[[if self:GetCampFlag() == 1 then
                    app.log("self="..self.config.name.." 增加被动计数 name="..target_name.." cnt="..self.fight_state_targets_cnt.."info="..tostring(info))
                end]]
            end
        end
    else
        if is_initiative then
            if self.fight_state_initiative_targets[target_name] then
                self.fight_state_initiative_targets[target_name] = nil
                self.fight_state_targets_cnt = self.fight_state_targets_cnt - 1
                --[[if self:GetCampFlag() == 1 then
                    app.log("self="..self.config.name.." 减少主动计数 name="..target_name.." cnt="..self.fight_state_targets_cnt.."info="..tostring(info))
                end]]
            end
        else
            if self.fight_state_passivity_targets[target_name] then
                self.fight_state_passivity_targets[target_name] = nil
                self.fight_state_targets_cnt = self.fight_state_targets_cnt - 1
                --[[if self:GetCampFlag() == 1 then
                    app.log("self="..self.config.name.." 减少被动计数 name="..target_name.." cnt="..self.fight_state_targets_cnt.."info="..tostring(info))
                end]]
            end
        end
    end
    if GetMainUI() and self:IsMyControl() and((old_targets_cnt == 0 and self.fight_state_targets_cnt > 0) or(old_targets_cnt > 0 and self.fight_state_targets_cnt == 0)) and FightScene.GetHudleSkillEnable(2) then
        GetMainUI():CheckFightState()
    end
end

function SceneEntity:ClearFightStateTarget(is_initiative, clear_relative, info)
    if is_initiative then
        local effect = false
        for k, v in pairs(self.fight_state_initiative_targets) do
            effect = true
            self.fight_state_targets_cnt = self.fight_state_targets_cnt - 1
            if clear_relative then
                local target = ObjectManager.GetObjectByName(k)
                if target then
                    target:ChangeFightStateTarget(self.name, false, false, tostring(info) .. " - 清除主动目标的关联操作")
                end
            end
        end
        --[[if self:GetCampFlag() == 1 and effect then
            app.log("self="..self.config.name.." 清空主动计数 cnt="..self.fight_state_targets_cnt.."info="..tostring(info))
        end]]
        self.fight_state_initiative_targets = { }
    else
        local effect = false
        for k, v in pairs(self.fight_state_passivity_targets) do
            effect = true
            self.fight_state_targets_cnt = self.fight_state_targets_cnt - 1
            if clear_relative then
                local target = ObjectManager.GetObjectByName(k)
                if target then
                    target:ChangeFightStateTarget(self.name, true, false, tostring(info) .. " - 清除被动目标的关联操作")
                end
            end
        end
        --[[if self:GetCampFlag() == 1 and effect then
            app.log("self="..self.config.name.." 清空被动计数 cnt="..self.fight_state_targets_cnt.."info="..tostring(info))
        end]]
        self.fight_state_passivity_targets = { }
    end

    if GetMainUI() and self:IsMyControl() and self.fight_state_targets_cnt == 0 and FightScene.GetHudleSkillEnable(2) then
        GetMainUI():CheckFightState()
    end
end

function SceneEntity:TrySendStand()
    if self:IsMyControl() or self:IsAIAgent() then
        if self.object then
            local x, y, z = self.object:get_local_position()
            x = x * PublicStruct.Coordinate_Scale
            y = z * PublicStruct.Coordinate_Scale
            msg_move.cg_stand(self:GetGID(), x, y)
        end
        self:setLastMovePath(nil)
    end
end

function SceneEntity:GetRecoverSkill()
    return self:GetSkillBySkillID(PublicStruct.Recover_Skill_ID)
end

function SceneEntity:SetCanSearch(b)
    if b == nil then
        --b = false;
        b = true;
        app.log("参数传递错误 " .. debug.traceback());
    end
    self.canSearch = b;
end

function SceneEntity:GetCanSearch()
    return self.canSearch;
end

function SceneEntity:SetCanNotAttack(b)
    if b == nil then
        --b = false;
        b = true;
        app.log("参数传递错误 " .. debug.traceback());
    end
    if self.cannotAttack and (b == false) and self.wait_can_attach_show_target_effect then
        self.aperture_manager:SetOpenNotMove(self.aperture_manager.changeTargetHeadEffect, true, self:GetBindObj(3), 0, 0, 0, 1, 1, self, nil, true, nil);
        self.showChangeTargeEffect = os.clock();
        self.wait_can_attach_show_target_effect = false
    end
    self.cannotAttack = b;

end

function SceneEntity:GetCanNotAttack()
    return self.cannotAttack;
end

function SceneEntity:InitMainNameUi(data)
    -- if not data then return end
    -- self.mainNameUi = MainNameUi:new(data);
    self.mainNameUi = TopObjectManager:new(self);
    self.mainNameUi:ShowTopInfo()
end

function SceneEntity:GetMainNameUi()
    return self.mainNameUi;
end

function SceneEntity:CreateHpNew()
    if self.ui_hp_new == nil then
        self.ui_hp_new = TopObjectManager:new(self);
        self.ui_hp_new:ShowTopInfo()
    end
end

function SceneEntity:GetMaterial()
    return self.materialList;
end

function SceneEntity:CheckAttackState_In_AttackRadius(target, checkParams)
    local retState, retDestination, retTarget, retNeedChangeTarget
    if checkParams.skillType == eSkillType.DirectionSkill or checkParams.skillType == eSkillType.MustTargetSkill or
        checkParams.skillType == eSkillType.DoubleCircleSkill or checkParams.skillType == eSkillType.Normal or
        checkParams.skillType == eSkillType.NormalSkill or checkParams.skillType == eSkillType.TripleCircleSkill then
        retTarget = target
        retNeedChangeTarget = true
        retState = ESTATE.Attack
        return retState, retDestination, retTarget, retNeedChangeTarget
    elseif checkParams.skillType == eSkillType.ImmediatelyNoStateSkill then
        retTarget = target
        retNeedChangeTarget = true
        retState = ESTATE.Attack
        return retState, retDestination, retTarget, retNeedChangeTarget
    end
end

function SceneEntity:CheckAttackState_Between_AttackAndView(target, checkParams)
    local retState, retDestination, retTarget, retNeedChangeTarget
    if checkParams.skillType == eSkillType.DirectionSkill or checkParams.skillType == eSkillType.MustTargetSkill or
        checkParams.skillType == eSkillType.DoubleCircleSkill or checkParams.skillType == eSkillType.Normal or
        checkParams.skillType == eSkillType.NormalSkill or checkParams.skillType == eSkillType.TripleCircleSkill then
        local dx, dy, dz = target.object:get_local_position()
        retTarget = target
        retNeedChangeTarget = true
        retState = ESTATE.Run
        retDestination = { x = dx, y = dy, z = dz }
        return retState, retDestination, retTarget, retNeedChangeTarget
    elseif checkParams.skillType == eSkillType.ImmediatelyNoStateSkill then
        retTarget = target
        retNeedChangeTarget = true
        retState = ESTATE.Attack
        return retState, retDestination, retTarget, retNeedChangeTarget
    end
end

function SceneEntity:CheckAttackState_Out_ViewRadius(target, checkParams)
    local arrTargets = { }
    self:SearchAreaTarget(true, checkParams.viewRadius, self, arrTargets, 1, 360, nil, checkParams.sortType, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster})
    local _target = arrTargets[1]
    if _target then
        dx, dy, dz = _target.object:get_local_position()
        local target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
        target_dis = target_dis - _target:GetRadius()
        if target_dis > checkParams.attackDistance then
            return self:CheckAttackState_Between_AttackAndView(_target, checkParams)
        else
            return self:CheckAttackState_In_AttackRadius(_target, checkParams)
        end
    else
        return self:CheckAttackState_No_Target_In_ViewRadius(checkParams)
    end
end

function SceneEntity:CheckAttackState_No_Target_In_ViewRadius(checkParams)
    local retState, retDestination, retTarget
    local retNeedChangeTarget = true
    if checkParams.skillType == eSkillType.DirectionSkill or checkParams.skillType == eSkillType.DoubleCircleSkill or
        checkParams.skillType == eSkillType.Normal or checkParams.skillType == eSkillType.NormalSkill or checkParams.skillType == eSkillType.TripleCircleSkill then
        retState = ESTATE.Attack
        return retState, retDestination, retTarget, retNeedChangeTarget
    elseif checkParams.skillType == eSkillType.MustTargetSkill then
        return retState, retDestination, retTarget, retNeedChangeTarget
    elseif checkParams.skillType == eSkillType.ImmediatelyNoStateSkill then
        retState = ESTATE.Attack
        return retState, retDestination, retTarget, retNeedChangeTarget
    end
end

function SceneEntity:CheckAttackState(force_intelligent, force_skill)
    local target = self:GetAttackTarget()
    if target and (target:IsKidnap() or target:IsHide() or (self:IsMyControl() and not target:IsEnemy())) then
        target = nil
        self:SetAttackTarget(nil)
    end
    local checkParams = {}
    local skill = force_skill
    if skill == nil then
        skill = self:GetCurSkill()
    end
    checkParams.skillType = skill:GetSkillType()
    checkParams.srcPos = self:GetPosition()
    checkParams.attackDistance = skill:GetDistance()
    if checkParams.skillType == eSkillType.Normal then
        checkParams.viewRadius = checkParams.attackDistance
        if SceneEntity.normal_skill_add_view_radius then
            checkParams.viewRadius = checkParams.viewRadius + SceneEntity.normal_skill_add_view_radius
        end
    else
        checkParams.viewRadius = PublicStruct.Const.ATTACK_VIEW_RADIUS--checkParams.attackDistance * 3
    end
    checkParams.extraDistance = skill:GetExtraDistance()
    checkParams.priorityBuff = skill:GetPriorityBuff()
    checkParams.isIntelligent = skill:IsIntelligent()
    checkParams.viewRadius = math.min(checkParams.viewRadius, 10)
    checkParams.sortType = skill:GetSkillSortType()
    checkParams.sortType = checkParams.sortType or 3
    if not self.new_attack_state_check then
        if target then
            dx, dy, dz = target.object:get_local_position()
            target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
            target_dis = target_dis - target:GetRadius()
            if target_dis <= checkParams.attackDistance then
                return self:CheckAttackState_In_AttackRadius(target, checkParams)
            elseif target_dis <= checkParams.viewRadius then
                return self:CheckAttackState_Between_AttackAndView(target, checkParams)
            end
        end
        return
    end
    self.new_attack_state_check = false
    -----新规则
    --原地释放技能和需要BUFF目标判断的技能单独处理
    if checkParams.skillType == eSkillType.NormalSkill then
        if checkParams.extraDistance ~= 0 then
            local buff = checkParams.priorityBuff
            if buff ~= nil then
                local arrTargets = { }
                self:SearchAreaTarget(true, checkParams.extraDistance, self, arrTargets, 1, 360, nil, checkParams.sortType, false, buff.id, buff.lv, { PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster })
                if #arrTargets > 0 then
                    return ESTATE.Attack, nil, nil, nil
                end
            end
        end
    elseif checkParams.skillType == eSkillType.ImmediatelyStateSkill then
        return ESTATE.Attack, nil, nil, nil
    end
    if checkParams.skillType == eSkillType.Normal then
        --普攻
        if target and target:GetSubType() == ENUM.EMonsterType.SceneItem then
            target = nil
            self:SetAttackTarget(nil)
        end
        if self.is_initiative_move or target == nil then
            self.is_initiative_move = false
            local arrTargets = { }
            self:SearchAreaTarget(true, checkParams.viewRadius, self, arrTargets, 1, 360, nil, checkParams.sortType, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster}, checkParams.attackDistance)
            target = arrTargets[1]
            if target then
                dx, dy, dz = target.object:get_local_position()
                target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
                target_dis = target_dis - target:GetRadius()
                if target_dis > checkParams.attackDistance then
                    return self:CheckAttackState_Between_AttackAndView(target, checkParams)
                else
                    return self:CheckAttackState_In_AttackRadius(target, checkParams)
                end
            else
                return self:CheckAttackState_No_Target_In_ViewRadius(checkParams)
            end
        elseif target then
            dx, dy, dz = target.object:get_local_position()
            target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
            target_dis = target_dis - target:GetRadius()
            if target_dis <= checkParams.attackDistance then
                return self:CheckAttackState_In_AttackRadius(target, checkParams)
            elseif target_dis < checkParams.attackDistance and target_dis < checkParams.viewRadius then
                return self:CheckAttackState_Between_AttackAndView(target, checkParams)
            else
                local arrTargets = { }
                self:SearchAreaTarget(true, checkParams.viewRadius, self, arrTargets, 1, 360, nil, checkParams.sortType, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster}, checkParams.attackDistance)
                target = arrTargets[1]
                if target then
                    dx, dy, dz = target.object:get_local_position()
                    target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
                    target_dis = target_dis - target:GetRadius()
                    if target_dis > checkParams.attackDistance then
                        return self:CheckAttackState_Between_AttackAndView(target, checkParams)
                    else
                        return self:CheckAttackState_In_AttackRadius(target, checkParams)
                    end
                else
                    return self:CheckAttackState_No_Target_In_ViewRadius(checkParams)
                end
            end
        end
    else
        --技能
        if checkParams.isIntelligent or force_intelligent then--智能施法
            local arrTargets = { }
            self:SearchAreaTarget(true, checkParams.viewRadius, self, arrTargets, 1, 360, nil, checkParams.sortType, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster}, checkParams.attackDistance)
            target = arrTargets[1]
            if target then
                dx, dy, dz = target.object:get_local_position()
                target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
                target_dis = target_dis - target:GetRadius()
                if target_dis > checkParams.attackDistance then
                    return self:CheckAttackState_Between_AttackAndView(target, checkParams)
                else
                    return self:CheckAttackState_In_AttackRadius(target, checkParams)
                end
            else
                return self:CheckAttackState_No_Target_In_ViewRadius(checkParams)
            end
        else
            if checkParams.skillType == eSkillType.DirectionSkill then
                return ESTATE.Attack, nil, nil, nil
            elseif checkParams.skillType == eSkillType.TripleCircleSkill then
                return ESTATE.Attack, nil, nil, nil
            elseif checkParams.skillType == eSkillType.DoubleCircleSkill then
                return ESTATE.Attack, nil, nil, nil
            elseif checkParams.skillType == eSkillType.ImmediatelyNoStateSkill then
                return ESTATE.Attack, nil, nil, nil
            elseif checkParams.skillType == eSkillType.MustTargetSkill then
                local arrTargets = { }
                self:SearchAreaTarget(true, checkParams.attackDistance, self, arrTargets, 1, 360, nil, checkParams.sortType, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster})
                target = arrTargets[1]
                if target then
                    return ESTATE.Attack, nil, target, true
                else
                    return nil, nil, nil, nil
                end
            end
        end
    end
    


    --[[
    local dx, dy, dz
    local target_dis
    if target then
        dx, dy, dz = target.object:get_local_position()
        target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
        target_dis = target_dis - target:GetRadius()
    end
    if self.old_sort_type and checkParams.sortType ~= self.old_sort_type then
        target = nil
        self:SetAttackTarget(nil)
    end
    self.old_sort_type = checkParams.sortType
    if checkParams.skillType == eSkillType.NormalSkill then
        if checkParams.extraDistance ~= 0 then
            local buff = checkParams.priorityBuff
            if buff ~= nil then
                local arrTargets = { }
                self:SearchAreaTarget(true, checkParams.extraDistance, self, arrTargets, 1, 360, nil, checkParams.sortType, false, buff.id, buff.lv, { PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster })
                if #arrTargets > 0 then
                    return ESTATE.Attack, nil, nil, nil
                end
            end
        end
    elseif checkParams.skillType == eSkillType.ImmediatelyStateSkill then
        return ESTATE.Attack, nil, nil, nil
    end
    if checkParams.isIntelligent then
        if not target then
            local arrTargets = { }
            self:SearchAreaTarget(true, checkParams.viewRadius, self, arrTargets, 1, 360, nil, checkParams.sortType, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster})
            target = arrTargets[1]
            if target then
                dx, dy, dz = target.object:get_local_position()
                target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
                target_dis = target_dis - target:GetRadius()
                if target_dis > checkParams.attackDistance then
                    return self:CheckAttackState_Between_AttackAndView(target, checkParams)
                else
                    return self:CheckAttackState_In_AttackRadius(target, checkParams)
                end
            else
                return self:CheckAttackState_No_Target_In_ViewRadius(checkParams)
            end
        elseif target_dis > checkParams.viewRadius then
            return self:CheckAttackState_Out_ViewRadius(target, checkParams)
        elseif (target_dis > checkParams.attackDistance and target_dis <= checkParams.viewRadius) then
            return self:CheckAttackState_Between_AttackAndView(target, checkParams)
        else
            return self:CheckAttackState_In_AttackRadius(target, checkParams)
        end
    else
        if checkParams.skillType == eSkillType.DirectionSkill then
            return ESTATE.Attack, nil, nil, nil
        elseif checkParams.skillType == eSkillType.TripleCircleSkill then
            return ESTATE.Attack, nil, nil, nil
        elseif checkParams.skillType == eSkillType.ImmediatelyNoStateSkill then
            return ESTATE.Attack, nil, nil, nil
        elseif checkParams.skillType == eSkillType.MustTargetSkill then
            if not target or target_dis > checkParams.viewRadius then
                local arrTargets = { }
                self:SearchAreaTarget(true, checkParams.viewRadius, self, arrTargets, 1, 360, nil, checkParams.sortType, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster})
                target = arrTargets[1]
                if target then
                    dx, dy, dz = target.object:get_local_position()
                    target_dis = algorthm.GetDistance(checkParams.srcPos.x, checkParams.srcPos.z, dx, dz);
                    target_dis = target_dis - target:GetRadius()
                    if target_dis <= checkParams.attackDistance then
                        return ESTATE.Attack, nil, target, true
                    elseif (target_dis > checkParams.attackDistance and target_dis <= checkParams.viewRadius) then
                        return nil, nil, nil, nil
                    end
                else
                    return nil, nil, nil, nil
                end
            elseif (target_dis > checkParams.attackDistance and target_dis <= checkParams.viewRadius) then
                local arrTargets = { }
                self:SearchAreaTarget(true, checkParams.attackDistance, self, arrTargets, 1, 360, nil, checkParams.sortType, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster})
                target = arrTargets[1]
                if target then
                    return ESTATE.Attack, nil, target, true
                else
                    return nil, nil, nil, nil
                end
            elseif target_dis <= checkParams.attackDistance then
                return ESTATE.Attack, nil, nil, nil
            end
        end
    end--]]

end

function SceneEntity:NoticeMountingEffect(id)
    self.mountingEffectList[id] = id;
end

function SceneEntity:NoticeMoveMountingEffect(id)
   self.mountingEffectList[id] = nil;
end

function SceneEntity:GetLearnSkillAssets()
    local resultTable = { }
    for i = 4, 6 do
        local skill = self:GetSkill(i)
        if skill then
            local icon_path = skill:GetSkillIcon()
            if icon_path then
                table.insert(resultTable, icon_path)
            end
        end
    end
    return resultTable;
end

function SceneEntity:KidnapByGID(gid, type)
    --app.log("gid="..gid.."type="..tostring(type))
    if gid then
        if self:GetBuffManager() then
            self:GetBuffManager().kidnaperGID = gid
            self:GetBuffManager().kidnaperType = type
            self:PostEvent("Transform", { })
            if type==1 then
                local kidnaper = ObjectManager.GetObjectByGID(gid)
                if kidnaper then
                    self:SetGameObjectParent(kidnaper:GetBindObj(9));
                end
            elseif type==0 then
                self:ShowHero(false)
                local kidnaper = ObjectManager.GetObjectByGID(gid)
                if kidnaper then
                    kidnaper:SetAttackTarget(nil)
                end
            end
            self:SetState(ESTATE.Stand);
        end
    else
        if self:GetBuffManager() then
            self:GetBuffManager().kidnaperGID = nil
            self:ShowHero(true)
            self:PostEvent("FinishTransform", { })
            if self:GetBuffManager().kidnaperType == 1 then
                if (self.objType == OBJECT_TYPE.HERO) then
                    self:SetGameObjectParent(ObjectManager.heroRootAssert);
                else
                    self:SetGameObjectParent(ObjectManager.monsterRootAssert);
                end
            end
            self:GetBuffManager().kidnaperType = nil
        end
    end
end

function SceneEntity:IsKidnap()
    if self:GetBuffManager() then
        return (self:GetBuffManager().kidnaperGID ~= nil)
    else
        return false
    end
end

function SceneEntity:CheckSearchTarget(target, is_enemy)
    if is_enemy then
        if self:IsEnemy(target) then
            return true
        end
    else
        if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
            if target:IsMonster() and (target.config.type == ENUM.EMonsterType.Basis or target.config.type == ENUM.EMonsterType.Tower) then
                return false
            else
                return(self.camp_flag == target:GetCampFlag())
            end
        elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion then
            return(self.camp_flag == target:GetCampFlag())
        elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
            return(self.camp_flag == target:GetCampFlag())
        elseif FightScene.GetPlayMethodType() == nil then
            return self:GetCampFlag() == target:GetCampFlag()
        else
            if self.owner_player_gid and self.owner_player_gid ~= 0 then
                if self.owner_player_gid == target.owner_player_gid then
                    return true
                end
            else
                return self:GetCampFlag() == target:GetCampFlag()
            end
        end
    end
    return false
end

-- info = {gid 玩家id
--         scale_type 0:绝对值 1:缩放乘法 2:缩放加法
--         ability_type 属性id(客户端属性枚举-ENUM.min_property_id-1)
--         value 改变值
--         change 改变or恢复 bool}
function SceneEntity:InsertAttributeVerifyChangeInfo(info)
    self.attribute_verify_change_info = self.attribute_verify_change_info or {}
    if (info.scale_type == 1 or info.scale_type == 2) and info.change == false then
        for i=1, #self.attribute_verify_change_info do
            local cur_info = self.attribute_verify_change_info[i]
            if cur_info.scale_type == info.scale_type and 
                cur_info.ability_type == info.ability_type and
                cur_info.value == info.value and
                cur_info.change == true then
                table.remove(self.attribute_verify_change_info, i)
                return
            end
        end
    end
    table.insert(self.attribute_verify_change_info, info)
end


function SceneEntity:GetSpeed()
    local speed = 0

    if self.navMeshAgent then
        speed = self.navMeshAgent:get_speed()
    end
    --app.log("GetSpeed " .. tostring(speed))
    return speed
end

function SceneEntity:SetSpeedProp(speed)
    local old = self.runSetProperty[ENUM.EHeroAttribute.move_speed]
    self.runSetProperty[ENUM.EHeroAttribute.move_speed] = speed
    self._buffManager._bUpdateProperty = true
    if self:IsMyControl() and PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
        local attribute_verify_change_info = {}
        attribute_verify_change_info.gid = self:GetGID()
        attribute_verify_change_info.scale_type = 3
        attribute_verify_change_info.ability_type = ENUM.EHeroAttribute.move_speed-ENUM.min_property_id-1
        attribute_verify_change_info.value = self.runSetProperty[ENUM.EHeroAttribute.move_speed]
        attribute_verify_change_info.change = true
        self:InsertAttributeVerifyChangeInfo(attribute_verify_change_info)
    end
    return  old
end

function SceneEntity:GetSpeedProp()
    return self.runSetProperty[ENUM.EHeroAttribute.move_speed]
end

function SceneEntity:SetMoveAniId(aniId)
    local old = self.currentMoveAniId
    self.currentMoveAniId = aniId
    return old
end

function SceneEntity:GetMoveAniId()
    return self.currentMoveAniId
end

function SceneEntity:GetTowerAttackTarget()
    return self._towerAttackTarget
end

--显示/隐藏/清除 防御塔攻击目标特效
function SceneEntity:ShowTowerLockTarget(obj, isShow)
    local target = self._towerAttackTarget
    --切换攻击目标
    if obj ~= target then
        if target then
            target._beTowerAttacker = target._beTowerAttacker or {}
            target._beTowerAttacker[self:GetName()] = nil
            -- 隐藏攻击目标
            target:DestroyTowerLockEffect()
        end
    end

    if isShow then
        self._towerAttackTarget = obj
        target = self._towerAttackTarget
        if target then
            target._beTowerAttacker = target._beTowerAttacker or {}
            target._beTowerAttacker[self:GetName()] = true
            -- 显示攻击目标标记
            target:ShowTowerLockEffect(true)
        end
    else
        target = self._towerAttackTarget
        self._towerAttackTarget = nil
        if target then
            target._beTowerAttacker = target._beTowerAttacker or {}
            target._beTowerAttacker[self:GetName()] = nil
            -- 隐藏攻击目标
            target:DestroyTowerLockEffect()
        end
    end

    self:UpdateTowerAreaEffect()
end

function SceneEntity:GetTowerLockEffect(isShow)
    if isShow and self._towerLockEffect == nil then
        self._towerLockEffect = self:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data, ENUM.EffectID.towerAttackLock), nil, nil, nil, nil, 0)
        local effect = EffectManager.GetEffect(self._towerLockEffect[1])
        if effect then
            effect:set_local_scale(1, 1, 1)
            effect:set_local_position(0, 0.25, 0) --调整至头顶上方0.25
            effect:set_active(true)
        end
    end
    return self._towerLockEffect
end

function SceneEntity:ShowTowerLockEffect(isShow)
    local lockEffect = self:GetTowerLockEffect(isShow)
    if lockEffect then
        local effect = EffectManager.GetEffect(lockEffect[1])
        if effect then
            effect:set_active(isShow)
        end
    end
end

function SceneEntity:DestroyTowerLockEffect()
    if self._towerLockEffect then
        EffectManager.deleteEffect(self._towerLockEffect[1])
        self._towerLockEffect = nil
    end
end

function SceneEntity:InitTowerAreaEffect()
    --光圈绿黄红
    self._towerAreaEffect = {}
    self._towerAreaEffect[1] = self:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data, ENUM.EffectID.towerAreaGreen), nil, nil, nil, nil, 0)
    self._towerAreaEffect[2] = self:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data, ENUM.EffectID.towerAreaYellow), nil, nil, nil, nil, 0)
    self._towerAreaEffect[3] = self:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data, ENUM.EffectID.towerAreaRed), nil, nil, nil, nil, 0)
    local dis = self:GetSkill(1):GetDistance()
    for i=1, 3 do
        for k,id in ipairs(self._towerAreaEffect[i]) do
            local effect = EffectManager.GetEffect(id)
            if effect then
                effect:set_local_scale(dis, 1, dis)
                effect:set_local_position(0, 0, 0)
                effect:set_active(false)
            end
        end
    end
end

function SceneEntity:ShowTowerAreaEffect(type)
    if type == self._towerAreaType then return end
    if self._towerAreaEffect == nil then return end

    for i, areaEffect in pairs(self._towerAreaEffect) do
        local effect = EffectManager.GetEffect(areaEffect[1])
        if effect then
            effect:set_active(i == type)
        end
    end

    self._towerAreaType = type
end

function SceneEntity:DestroyTowerAreaEffect()
    if self._towerAreaEffect then
        EffectManager.deleteEffect(self._towerAreaEffect[1][1])
        EffectManager.deleteEffect(self._towerAreaEffect[2][1])
        EffectManager.deleteEffect(self._towerAreaEffect[3][1])
        self._towerAreaEffect = nil
    end
end

--防御塔范围特效刷新（主控英雄切换 或 防御塔攻击对象切换）
function SceneEntity:UpdateTowerAreaEffect()
    --主控英雄是否在预警区内
    if not self._towerIntoTarget then
        self:ShowTowerAreaEffect(nil)
        return
    end

    -- -- 当前攻击锁定对象
    -- -- 0预警区外 不显示
    -- --1预警区中 如果有非主控单位被攻击显示绿色否则黄色
    -- --2攻击区中 如果主控单位被攻击显示红色否则绿色
    -- local towerEffectType = 2
    -- if self._towerIntoValue == 2 then
    --     if self._towerAttackTarget == self._towerIntoTarget then
    --         towerEffectType = 3
    --     else
    --         towerEffectType = 1
    --     end
    -- elseif self._towerIntoValue == 1 then
    --     if  self._towerAttackTarget and 
    --         self._towerAttackTarget ~= self._towerIntoTarget then
    --         towerEffectType = 1
    --     end
    -- end

    --当前攻击锁定对象
    -- 0预警区外 不显示
    --1预警区中 黄色
    --2攻击区中 如果主控单位被攻击显示红色否则绿色
    local towerEffectType = 2
    if self._towerIntoValue == 2 then
        if self._towerAttackTarget == self._towerIntoTarget then
            towerEffectType = 3
        else
            towerEffectType = 1
        end
    end


    --刷新光圈显示
    self:ShowTowerAreaEffect(towerEffectType)
end

--into: 0/1/2 预警区外/预警区中/攻击区中
function SceneEntity:IntoTowerShowArea(target, into)
    if self:IsDead() or not target or into == 0 then
        self._towerIntoTarget = nil
    else
        self._towerIntoTarget = target
    end
    self._towerIntoValue = into

    self:UpdateTowerAreaEffect()
end

function SceneEntity:GetAngularSpeed()
    if self.navMeshAgent then
        return self.navMeshAgent:get_angular_speed();
    end
    return 0;
end

function SceneEntity:SetAngularSpeed(speed)
    if self.navMeshAgent then
        self.navMeshAgent:set_angular_speed(speed);
    end
    self.last_angular_speed = speed
end
