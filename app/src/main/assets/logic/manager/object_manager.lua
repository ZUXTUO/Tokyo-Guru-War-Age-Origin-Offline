
ObjectManager =
{
    delete_list = {},
    last_attribute_verify_time = nil
};
-- 对象类型
OBJECT_TYPE =
{
    ALL = 0,
    -- 所有
    HERO = 1,
    -- 英雄
    MONSTER = 2,
    -- 怪物
    ITEM = 4,
    -- 道具
    SUMMONEUNIT = 8,
    -- 召唤物
    NPC = 16,-- npc

    -- ui使用
    SHOWHERO = 32,

    -- 剧情展示
    SHOWBOSS = 64,
}

OBJECT_SUB_TYPE =
{
    HERO_TANK = 1,
    -- 肉盾
    HERO_WARRIOR = 2,
    -- 战士
    HERO_MAGE = 3,
    -- 法师
    HERO_PRIEST = 4,
    -- 牧师
    HERO_HUNTER = 5,
    -- 猎人
    HERO_UNUSE1 = 6,
    HERO_UNUSE2 = 7,
    HERO_UNUSE3 = 8,
    HERO_UNUSE4 = 9,
    MONSTER_SOLDIER_CLOSE = 10,
    -- 近战小兵
    MONSTER_SOLDIER_RNAGE = 11,
    -- 远程小兵
    MONSTER_SOLDIER_SUPER = 12,
    -- 超级小兵
    MONSTER_TOWER = 13,
    -- 塔
    MONSTER_BASIS = 14,
    -- 基地
    MONSTER_BOSS = 15,
    -- boss
    MONSTER_WILD = 16,
    -- 野怪
    MONSTER_UNUSE2 = 17,
    MONSTER_UNUSE3 = 18,
    MONSTER_UNUSE4 = 19,
    -- ITEM_TRIGGER = 20,
}
-- 对象阵营标志
OBJECT_TYPE_FLAG =
{
    ALL = 0,
    -- ALL
    WE = 1,
    -- 我方
    ENEMY = 2,
    -- 敌方
    NEUTRAL = 3,-- 中立
}

CREATE_OBJ_MODEL_OPTION =
{
    REAL_MODEL = 0,
    TEMP_MODEL = 1,
    -- temp model only
    AUTO = 2,--
}


function ObjectManager.Update(deltaTime)
    local attribute_verify_change_info = {}
    local attribute_verify_upload_info = {}
    local check_attribute = false
    if ObjectManager.last_attribute_verify_time and PublicFunc.QueryDeltaTime(ObjectManager.last_attribute_verify_time) >= PublicStruct.Const.ATTRIBUTE_VERIFY_RATE then
        ObjectManager.last_attribute_verify_time = PublicFunc.QueryCurTime()
        check_attribute = true
    end
    for k, v in pairs(ObjectManager.objects) do
        v:Update(deltaTime);
        if check_attribute and v.attribute_verify and not v:IsDead() then
            if v.attribute_verify_change_info then
                if ObjectManager.last_attribute_verify_time then
                    for i=1, #v.attribute_verify_change_info do
                        table.insert(attribute_verify_change_info, v.attribute_verify_change_info[i])
                    end
                end
                v.attribute_verify_change_info = nil
            end
            local upload_info = {}
            local property = v:GetProperty()
            upload_info.gid = v:GetGID()
            upload_info.attribute = {}
            for k, v in pairs(property) do
                if v ~= 0 and k ~= ENUM.EHeroAttribute.cur_hp then
                    local property_info = {}
                    property_info.attribute_type = k-ENUM.min_property_id-1
                    property_info.value = v
                    table.insert(upload_info.attribute, property_info)
                end
            end
            table.insert(attribute_verify_upload_info, upload_info)
        end
    end
    if #attribute_verify_change_info > 0 then
        msg_hurdle.cg_attribute_verify_change_info(FightScene.GetPlayMethodType(), attribute_verify_change_info)
    end
    if #attribute_verify_upload_info > 0 then
        msg_hurdle.cg_attribute_verify_upload(FightScene.GetPlayMethodType(), attribute_verify_upload_info)
    end
    for k, v in pairs(ObjectManager.delete_list) do
        local obj = v
        if obj then
            local gid = obj:GetGID()
            local iid = obj:GetIid()
            local name = obj:GetName()
            if ObjectManager.objects[name] == v then
                ObjectManager.objects[name] = nil;
                ObjectManager.objects_gid[gid] = nil;
                ObjectManager.objects_iid[iid] = nil;
            end
            if v:GetObject() then
                v:GetObject():set_active(false)
            end
            ObjectManager.RemoveFromGroup(obj:GetGroupName(), name)
            delete(v);
        end
    end
    ObjectManager.delete_list = {}


    -- create delay monster
    local fm = FightScene.GetFightManager()
    if fm and not fm:IsFightOver() then
        local count = #ObjectManager.delayCreateMonsterFromMapInfo
        if count > 0 then
            for i = count, 1, -1 do
                local instance = ObjectManager.delayCreateMonsterFromMapInfo[i]
                if app.get_time() >= instance.createTime then
                    local newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(instance.config, instance.level)
                    if instance.callback then
                        instance.callback(newmonster)
                    end

                    local fm = FightScene.GetFightManager()
                    if newmonster and fm then
                        fm:OnLoadMonster(newmonster)
                    end

                    table.remove(ObjectManager.delayCreateMonsterFromMapInfo, i)
                end
            end
        end
    end
end

function ObjectManager.Init()
    ObjectManager.objects = { };
    ObjectManager.objects_gid = { };
    ObjectManager.objects_iid = { };
    ObjectManager.groups = {}
    ObjectManager.cur_uuid = 1;
    ObjectManager.monsterRootAssert = nil;
    ObjectManager.showBossRootAssert = nil;
    ObjectManager.heroRootAssert = nil;
    ObjectManager.itemRootAssert = nil;
    ObjectManager.npcRootAssert = nil;
    -- 当前场上有多少怪。
    ObjectManager.curMonsterCount = 0;
    ObjectManager.cur_gid = 0x7FFFFFFF

    ObjectManager.delayCreateMonsterFromMapInfo = {}
end

ObjectManager.Init();

function ObjectManager.DeleteObjByObj(obj)
    if obj then
        for k, v in pairs(ObjectManager.delete_list) do
            if v == obj then
                return true;
            end
        end
        obj.destroyTraceback = debug.traceback()
        table.insert(ObjectManager.delete_list, obj)
        return true
    end
    return false
end

function ObjectManager.DeleteObj(obj_name)
    if obj_name then
        local obj = ObjectManager.objects[obj_name]
        return ObjectManager.DeleteObjByObj(obj)
    end
    return false
end

function ObjectManager.Destroy(obj)
    app.log_warning("ObjectManager.Destroy()..................")
    if obj then
        local name = obj:GetName();
        local gid = obj:GetGID()
        local iid = obj:GetIid()
        if ObjectManager.objects[name] then
            delete(ObjectManager.objects[name]);
            ObjectManager.objects[name] = nil;
            ObjectManager.objects_gid[gid] = nil;
            ObjectManager.objects_iid[iid] = nil
        end
    else
        for k, v in pairs(ObjectManager.objects) do
            delete(v);
        end
        ObjectManager.objects = { };
        ObjectManager.objects_gid = { }
        ObjectManager.objects_iid = { }
        ObjectManager.groups = {}
        ObjectManager.cur_uuid = 1;
        ObjectManager.delete_list = {}
    end

    ObjectManager.autoFightPath = nil
    ObjectManager.delayCreateMonsterFromMapInfo = {}
end



function ObjectManager.OnFightOver(isWin)
    for k, role in pairs(ObjectManager.objects) do
        role:OnFightOver(isWin)
    end
end

function ObjectManager.MonsterConfigToRole(monster_config)
    local config = monster_config;
    --config.small_icon = config.head;
    return config
end

function ObjectManager.HeroConfigToRole(hero_config)

    local config = hero_config
    return config
end

function ObjectManager.ItemConfigToRole(item_config)

    local config = item_config;
    return config
end

function ObjectManager.NpcConfigToRole(npc_config)
    local config = npc_config;
    return config
end

function ObjectManager.GetHeroCount()
    local count = 0
    for k, v in pairs(ObjectManager.objects) do
        if v:IsHero() and not v:IsMyControl() then
            count = count + 1
        end
    end
    return count
end

function ObjectManager.AddObject(obj)

    local mgr = ObjectManager

    local name = obj:GetName()
    local gid = obj:GetGID()
    local iid = obj:GetIid()
    mgr.objects[name] = obj
    mgr.objects_gid[gid] = obj
    mgr.objects_iid[iid] = obj
end

-- 创建一个小兵与野怪 id   flag标识 1我方 2敌方 3中立
function ObjectManager.CreateMonster(id, camp_flag, gid, level, card_src, model_option, group_name, begin_anim)
    --app.log("CreateMonster-"..debug.traceback())
    local have_gid = false
    if gid == nil then
        gid = ObjectManager.cur_gid
        ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    else
        have_gid = true
    end
    -- 所有的怪物都放到一个节点下面
    if not ObjectManager.monsterRootAssert then
        local mr = asset_game_object.find("monster_root");
        if not mr then
            ObjectManager.monsterRootAssert = asset_game_object.create(EffectManager.placeHolderRes);
            ObjectManager.monsterRootAssert:set_name("monster_root");
            PublicFunc.obj_init(ObjectManager.monsterRootAssert);
            ObjectManager.monsterRootAssert:set_active(true);

            if not SceneManager.GetCurrentScene().fightScene then
                app.log('创建怪的时候fightScene节点还没有创建！')
            end
            ObjectManager.monsterRootAssert:set_parent(SceneManager.GetCurrentScene().fightScene);
        end
    end

    local filename = ObjectManager.GetMonsterModelFile(id);
    if filename == nil then
        app.log("CreateMonster 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateMonster", model_option)
    if nil == assetobj then
        return;
    end

    local oldObj = ObjectManager.GetObjectByGID(gid)
    if oldObj then
        ObjectManager.DeleteObj(oldObj:GetName())
    end
    local data =
    {
        dataid = ObjectManager.cur_uuid,
        number = id,
        level = level,
    }
    local card = nil
    if card_src then
        card = card_src
    else
        card = CardHuman:new(data);
    end
    local name = nil
    if have_gid then
        name = "Monster_" .. camp_flag .. "_" .. gid;
    else
        name = ObjectManager.GetObjectName(OBJECT_TYPE.MONSTER, camp_flag, ObjectManager.cur_uuid);
    end
    local data =
    {
        obj = assetobj,
        config = ObjectManager.MonsterConfigToRole(ConfigManager.Get(EConfigIndex.t_monster_property,id)),
        camp_flag = camp_flag,
        name = name,
        objType = OBJECT_TYPE.MONSTER,
        card = card;
        gid = gid,
        group_name = group_name,
        beginAnim = begin_anim,
    };
    if card == nil then
        app.log("error monster card, id:" .. tostring(id) .. debug.traceback())
    end
    local monster = SceneEntity:new(data);
    if monster then
        -- local iid = monster:GetIid()
        -- ObjectManager.objects[name] = monster;
        -- ObjectManager.objects_gid[gid] = monster;
        -- ObjectManager.objects_iid[iid] = monster;

        ObjectManager.AddObject(monster)

        ObjectManager.cur_uuid = ObjectManager.cur_uuid + 1;

        ObjectManager.AddToGroup(group_name, monster);
    end
    if MAP_RESTORE_DEBUG then
        app.log('huhu_map_debug' .. tostring(filename) .. ' 创建怪物成功！' .. id .. ' ' .. camp_flag)
    end
    -- 设置父节点
    monster:SetGameObjectParent(ObjectManager.monsterRootAssert);
    return monster, is_temp_model;
end

function ObjectManager.GetShowNode()
    -- 所有的展示物都放到一个节点下面
    if not ObjectManager.showBossRootAssert then
        local mr = asset_game_object.find("showBoss");
        if not mr then
            ObjectManager.showBossRootAssert = asset_game_object.create(EffectManager.placeHolderRes);
            ObjectManager.showBossRootAssert:set_name("showBoss");
            PublicFunc.obj_init(ObjectManager.showBossRootAssert);
            ObjectManager.showBossRootAssert:set_active(true);

            if not SceneManager.GetCurrentScene().fightScene then
                app.log('创建怪的时候fightScene节点还没有创建！')
            end
            ObjectManager.showBossRootAssert:set_parent(SceneManager.GetCurrentScene().fightScene);
        end
    end
    return ObjectManager.showBossRootAssert;
end

-- 创建一个小兵与野怪 id   flag标识 1我方 2敌方 3中立
function ObjectManager.CreateShowBoss(id, camp_flag)
    local gid = ObjectManager.cur_gid
    ObjectManager.cur_gid = ObjectManager.cur_gid - 1

    ObjectManager.GetShowNode();

    if ConfigManager.Get(EConfigIndex.t_monster_property,id) == nil then
        app.log("取了一个不存在怪物属性id........" .. id .. debug.traceback());
        return;
    end
    local model_id = ConfigManager.Get(EConfigIndex.t_monster_property,id).model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("怪物模型id配置错误........" .. model_id .. ' ' .. id .. debug.traceback());
        return;
    end
    local filename = ObjectManager.GetHighItemModelFile(model_id);
    if filename == nil then
        app.log("CreateMonster 模型名字未找到，id=" .. model_id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateMonster")
    if nil == assetobj then
        return;
    end

    local data =
    {
        dataid = ObjectManager.cur_uuid,
        number = id,
        level = 1,
    }
    local card = CardHuman:new(data);
    local name = ObjectManager.GetObjectName(OBJECT_TYPE.MONSTER, camp_flag, ObjectManager.cur_uuid);
    local data =
    {
        obj = assetobj,
        config = ObjectManager.MonsterConfigToRole(ConfigManager.Get(EConfigIndex.t_monster_property,id)),
        camp_flag = camp_flag,
        name = name,
        objType = OBJECT_TYPE.SHOWBOSS,
        showType = true,
        card = card,
        gid = gid,
        not_boss = true,
    };
    if card == nil then
        app.log("error monster card, id:" .. tostring(id) .. debug.traceback())
    end
    local monster = SceneEntity:new(data);
    if monster then
        -- local iid = monster:GetIid()
        -- ObjectManager.objects[name] = monster;
        -- ObjectManager.objects_gid[gid] = monster;
        -- ObjectManager.objects_iid[iid] = monster;
        ObjectManager.AddObject(monster)

        ObjectManager.cur_uuid = ObjectManager.cur_uuid + 1;
    end
    -- 设置父节点
    monster:SetGameObjectParent(ObjectManager.GetShowNode());
    return monster, is_temp_model;
end

-- 创建一个英雄 id   camp_flag标识 1我方 2敌方 3中立   level等级 uuid 唯一标识 equipTable装备表寻找源
function ObjectManager.CreateShowHero(id, camp_flag)
    gid = ObjectManager.cur_gid
    ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    -- 所有的展示物都放到一个节点下面
    ObjectManager.GetShowNode();

    if ConfigHelper.GetRole(id) == nil then
        app.log("取了一个不存在人物id........" .. id .. debug.traceback());
        return;
    end
    local model_id = ConfigHelper.GetRole(id).model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("模型id配置错误........" .. model_id .. ' ' .. id .. debug.traceback());
        return;
    end
    local filename = ObjectManager.GetHighItemModelFile(model_id);
    if filename == nil then
        app.log("CreateHero 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateHero")
    if nil == assetobj then
        return;
    end

    local data =
    {
        dataid = ObjectManager.cur_uuid,
        number = id,
        level = 1,
    }
    local card = CardHuman:new(data);
    local name = ObjectManager.GetObjectName(OBJECT_TYPE.HERO, camp_flag, uuid or ObjectManager.cur_uuid);
    local data =
    {
        obj = assetobj,
        config = ObjectManager.HeroConfigToRole(ConfigHelper.GetRole(id)),
        camp_flag = camp_flag,
        level = 1,
        name = name,
        objType = OBJECT_TYPE.SHOWHERO,
        showType = true,
        card = card,
        gid = gid,
    };
    local hero = SceneEntity:new(data);
    if hero then
        -- local iid = hero:GetIid()
        -- ObjectManager.objects[name] = hero;
        -- ObjectManager.objects_gid[gid] = hero;
        -- ObjectManager.objects_iid[iid] = hero
        ObjectManager.AddObject(hero)

    end
    -- 设置父节点
    hero:SetGameObjectParent(ObjectManager.GetShowNode());
    return hero, is_temp_model;
end

function ObjectManager.CreateShowHeroByModelID(model_id, camp_flag)
    gid = ObjectManager.cur_gid
    ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    -- 所有的展示物都放到一个节点下面
    ObjectManager.GetShowNode();

    -- if ConfigHelper.GetRole(id) == nil then
    --     app.log("取了一个不存在人物id........" .. id .. debug.traceback());
    --     return;
    -- end
    local model_id = model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("模型id配置错误........" .. model_id .. ' ' .. id .. debug.traceback());
        return;
    end
    local filename = ObjectManager.GetItemModelFile(model_id);
    if filename == nil then
        app.log("CreateHero 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateHero")
    if nil == assetobj then
        return;
    end

    -- vip 临时加上去，没实际用途
    local id = 30001003;
    local data =
    {
        dataid = ObjectManager.cur_uuid,
        number = id,
        level = 1,
    }
    local card = CardHuman:new(data);
    local name = ObjectManager.GetObjectName(OBJECT_TYPE.HERO, camp_flag, uuid or ObjectManager.cur_uuid);
    local data =
    {
        obj = assetobj,
        config = ObjectManager.HeroConfigToRole(ConfigHelper.GetRole(id)),
        config = {model_id = model_id},
        camp_flag = camp_flag,
        level = 1,
        name = name,
        objType = OBJECT_TYPE.SHOWHERO,
        showType = true,
        card = card,
        gid = gid,
    };
    local hero = SceneEntity:new(data);
    if hero then
        -- local iid = hero:GetIid()
        -- ObjectManager.objects[name] = hero;
        -- ObjectManager.objects_gid[gid] = hero;
        -- ObjectManager.objects_iid[iid] = hero
        ObjectManager.AddObject(hero)

    end
    -- 设置父节点
    hero:SetGameObjectParent(ObjectManager.GetShowNode());
    return hero, is_temp_model;
end

function ObjectManager.CreateShowHeroByModelIDVip(model_id, camp_flag)
    gid = ObjectManager.cur_gid
    ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    -- 所有的展示物都放到一个节点下面
    ObjectManager.GetShowNode();

    -- if ConfigHelper.GetRole(id) == nil then
    --     app.log("取了一个不存在人物id........" .. id .. debug.traceback());
    --     return;
    -- end
    local model_id = model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("模型id配置错误........" .. model_id .. ' ' .. id .. debug.traceback());
        return;
    end
    local filename = ObjectManager.GetItemModelFileVip(model_id);
    if filename == nil then
        app.log("CreateHero 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateHero")
    if nil == assetobj then
        return;
    end

    -- vip 临时加上去，没实际用途
    local id = 30001003;
    local data =
    {
        dataid = ObjectManager.cur_uuid,
        number = id,
        level = 1,
    }
    local card = CardHuman:new(data);
    local name = ObjectManager.GetObjectName(OBJECT_TYPE.HERO, camp_flag, uuid or ObjectManager.cur_uuid);
    local data =
    {
        obj = assetobj,
        config = ObjectManager.HeroConfigToRole(ConfigHelper.GetRole(id)),
        config = {model_id = model_id},
        camp_flag = camp_flag,
        level = 1,
        name = name,
        objType = OBJECT_TYPE.SHOWHERO,
        showType = true,
        card = card,
        gid = gid,
    };
    local hero = SceneEntity:new(data);
    if hero then
        -- local iid = hero:GetIid()
        -- ObjectManager.objects[name] = hero;
        -- ObjectManager.objects_gid[gid] = hero;
        -- ObjectManager.objects_iid[iid] = hero
        ObjectManager.AddObject(hero)

    end
    -- 设置父节点
    hero:SetGameObjectParent(ObjectManager.GetShowNode());
    return hero, is_temp_model;
end

function ObjectManager.ChangeObjName(old_name, new_name)
    ObjectManager.objects[new_name] = ObjectManager.objects[old_name]
    ObjectManager.objects[old_name] = nil
end

function ObjectManager._GetModelResWithOptions(file_name, create_tag, model_option)
    if file_name == nil then
        return nil, false;
    end

    if nil == model_option then
        model_option = CREATE_OBJ_MODEL_OPTION.REAL_MODEL
    else
        if model_option < CREATE_OBJ_MODEL_OPTION.REAL_MODEL or model_option > CREATE_OBJ_MODEL_OPTION.AUTO then
            app.log("ObjectManager._GetModelResWithOptions 错误的模型创建选项:" .. model_option)

            model_option = CREATE_OBJ_MODEL_OPTION.AUTO
        end
    end

    local assetobj = nil
    local is_temp_model = false;

    if model_option == CREATE_OBJ_MODEL_OPTION.REAL_MODEL then
        assetobj = ResourceManager.GetResourceObject(file_name)
        if nil == assetobj then
            app.log(create_tag .. "模型未预加载，不能显示:" .. file_name);
        end
    elseif model_option == CREATE_OBJ_MODEL_OPTION.AUTO then
        assetobj = ResourceManager.GetResourceObject(file_name)
        if nil == assetobj then
            assetobj = Root.temp_model_file
            is_temp_model = true
            if assetobj == nil then
                app.log(create_tag .. " 临时模型未预加载，不能显示" .. PublicStruct.Temp_Model_File);
            end
        end
    elseif model_option == CREATE_OBJ_MODEL_OPTION.TEMP_MODEL then
        assetobj = Root.temp_model_file
        is_temp_model = true
        if assetobj == nil then
            app.log(create_tag .. " 临时模型未预加载，不能显示" .. PublicStruct.Temp_Model_File);
        end
    end
	
    return assetobj, is_temp_model
end


-- 创建一个英雄 id   camp_flag标识 1我方 2敌方 3中立   level等级 uuid 唯一标识 equipTable装备表寻找源 playMethodAcitvityTimeEnum:玩法ActivityTime的ID
function ObjectManager.CreateHero(fight_player_id, id, camp_flag, country_id, level, uuid, equipTable, gid, card_src, bPvP, model_option,playMethodAcitvityTimeEnum)
    --app.log("CreateHero-"..debug.traceback())
    if gid == nil then
        gid = ObjectManager.cur_gid
        ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    end
    -- 所有的怪物都放到一个节点下面
    if not ObjectManager.heroRootAssert then
        local mr = asset_game_object.find("hero_root");
        if not mr then
            ObjectManager.heroRootAssert = asset_game_object.create(EffectManager.placeHolderRes);
            ObjectManager.heroRootAssert:set_name("hero_root");
            PublicFunc.obj_init(ObjectManager.heroRootAssert);
            ObjectManager.heroRootAssert:set_active(true);

            if not SceneManager.GetCurrentScene().fightScene then
                app.log('创建英雄的时候fightScene节点还没有创建！' .. debug.traceback())
                return nil
            end
            ObjectManager.heroRootAssert:set_parent(SceneManager.GetCurrentScene().fightScene);
        end
    end

    local filename = ObjectManager.GetHeroModelFile(id);
    if filename == nil then
        app.log("CreateHero 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateHero", model_option)
    if nil == assetobj then
        return;
    end

    local oldObj = ObjectManager.GetObjectByGID(gid)
    if oldObj then
        ObjectManager.DeleteObj(oldObj:GetName())
    end
    equipTable = equipTable or g_dataCenter.package;
    local card = nil;
    if equipTable and uuid then
        card = equipTable:find_card(1, uuid);
    elseif card_src then
        card = card_src
    elseif uuid then
        local data =
        {
            dataid = ObjectManager.cur_uuid,
            number = id,
            level = level,
            cur_exp = 0,
            souls = 0,
            dataSource = equipTable,
        }
        --[[local obj_config = ConfigHelper.GetRole(id)
        if obj_config then
            local role_skill_cfg = ConfigManager.Get(EConfigIndex.t_role_skill, obj_config.rarity)
            if role_skill_cfg then
                if role_skill_cfg.initiative_skill ~= 0 then
                    for i=1, #role_skill_cfg.initiative_skill do
                        if obj_config["skill"..(i+3)] and obj_config["skill"..(i+3)] ~= 0 then
                            data["skill"..i.."_id"] = obj_config["skill"..(i+3)]
                            data["skill"..i.."_level"] = 1
                        end
                    end
                end
                if role_skill_cfg.passive_skill ~= 0 then
                    for i=1, #role_skill_cfg.passive_skill do
                        if obj_config["skill"..(i+6)] and obj_config["skill"..(i+6)] ~= 0 then
                            data["skill"..(i+3).."_id"] = obj_config["skill"..(i+6)]
                            data["skill"..(i+3).."_level"] = 1
                        end
                    end
                end
            end
        end]]
        card = CardHuman:new(data);
    end
    if card == nil and uuid ~= nil then
        app.log("error hero card, id:" .. id .. " uuid=" .. uuid .. "  " .. debug.traceback());
        --[[for k, v in pairs(equipTable.list[1]) do
			app.log("uuid:"..k.." equipTable:"..table.tostring(v));
        end]]
    end
    local name = nil
    if not bPvP then
        name = ObjectManager.GetObjectName(OBJECT_TYPE.HERO, camp_flag, uuid or ObjectManager.cur_uuid);
    else
        name = "Hero_" .. camp_flag .. "_" .. gid;
    end
    local data =
    {
        obj = assetobj,
        config = ObjectManager.HeroConfigToRole(ConfigHelper.GetRole(id)),
        camp_flag = camp_flag,
        country_id = country_id,
        level = level,
        name = name,
        objType = OBJECT_TYPE.HERO,
        card = card,
        gid = gid,
        owner_player_gid = fight_player_id,
        uuid = uuid,
		playMethodAcitvityTimeEnum = playMethodAcitvityTimeEnum,
    };
    if fight_player_id == g_dataCenter.player.playerid then
        g_dataCenter.player.camp_flag = camp_flag
    end
    local hero = SceneEntity:new(data);
    if hero then
        -- local iid = hero:GetIid()
        -- ObjectManager.objects[name] = hero;
        -- ObjectManager.objects_gid[gid] = hero;
        -- ObjectManager.objects_iid[iid] = hero
        ObjectManager.AddObject(hero)

        if not uuid then
            ObjectManager.cur_uuid = ObjectManager.cur_uuid + 1;
        end
    end
    -- 设置父节点
    hero:SetGameObjectParent(ObjectManager.heroRootAssert);
    return hero, is_temp_model;
end

function ObjectManager.CreateTrialHero(fight_player_id, cardTrial, camp_flag, uuid, model_option)
    local gid = ObjectManager.cur_gid
    ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    -- 所有的怪物都放到一个节点下面
    if not ObjectManager.heroRootAssert then
        local mr = asset_game_object.find("hero_root");
        if not mr then
            ObjectManager.heroRootAssert = asset_game_object.create(EffectManager.placeHolderRes);
            ObjectManager.heroRootAssert:set_name("hero_root");
            PublicFunc.obj_init(ObjectManager.heroRootAssert);
            ObjectManager.heroRootAssert:set_active(true);

            if not SceneManager.GetCurrentScene().fightScene then
                app.log('创建英雄的时候fightScene节点还没有创建！' .. debug.traceback())
                return nil
            end
            ObjectManager.heroRootAssert:set_parent(SceneManager.GetCurrentScene().fightScene);
        end
    end

    local filename = ObjectManager.GetHeroModelFile(cardTrial.number);
    if filename == nil then
        app.log("CreateHero 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateHero", model_option)
    if nil == assetobj then
        return;
    end

    local oldObj = ObjectManager.GetObjectByGID(gid)
    if oldObj then
        ObjectManager.DeleteObj(oldObj:GetName())
    end
    if cardTrial == nil and uuid ~= nil then
        app.log("error hero card, id:" .. id .. " uuid=" .. uuid .. "  " .. debug.traceback());
        --[[for k, v in pairs(equipTable.list[1]) do
			app.log("uuid:"..k.." equipTable:"..table.tostring(v));
        end]]
    end
    local name = nil
	name = "Hero_" .. camp_flag .. "_" .. gid;
    local data =
    {
        obj = assetobj,
        config = ObjectManager.HeroConfigToRole(ConfigHelper.GetRole(cardTrial.number)),
        camp_flag = camp_flag,
        country_id = 0,
        level = level,
        name = name,
        objType = OBJECT_TYPE.HERO,
        card = cardTrial,
        gid = gid,
        owner_player_gid = fight_player_id,
        uuid = uuid,
    };
    if fight_player_id == g_dataCenter.player.playerid then
        g_dataCenter.player.camp_flag = camp_flag
    end
    local hero = SceneEntity:new(data);
    if hero then
        -- local iid = hero:GetIid()
        -- ObjectManager.objects[name] = hero;
        -- ObjectManager.objects_gid[gid] = hero;
        -- ObjectManager.objects_iid[iid] = hero
        ObjectManager.AddObject(hero)

        if not uuid then
            ObjectManager.cur_uuid = ObjectManager.cur_uuid + 1;
        end
    end
    -- 设置父节点
    hero:SetGameObjectParent(ObjectManager.heroRootAssert);
    return hero, is_temp_model;
end

-- 建一个道具 id   flag标识 1我方 2敌方 3中立  ps:config_id:world_item表中的id,(中原地图用到---chenlong,刷buff器用--罗皓方）
function ObjectManager.CreateItem(id, camp_flag, item_modelid, item_effectid, gid, config_id, is_opened)
    -- TODO: kevin CreateItem 是否需要异步支持？
    local have_gid = false
    if gid == nil then
        gid = ObjectManager.cur_gid
        ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    else
        have_gid = true
    end
    -- 所有的道具都放到一个节点下面
    if not ObjectManager.itemRootAssert then
        local mr = asset_game_object.find("item_root");
        if not mr then
            ObjectManager.itemRootAssert = asset_game_object.create(EffectManager.placeHolderRes);
            ObjectManager.itemRootAssert:set_name("item_root");
            PublicFunc.obj_init(ObjectManager.itemRootAssert);
            ObjectManager.itemRootAssert:set_active(true);

            if not SceneManager.GetCurrentScene().fightScene then
                app.log('创建道具的时候fightScene节点还没有创建！' .. debug.traceback())
            end
            ObjectManager.itemRootAssert:set_parent(SceneManager.GetCurrentScene().fightScene);
        else
            ObjectManager.itemRootAssert = mr
        end
    end
    if item_modelid == 0 then
        item_modelid = 80002002;
    end
    local assetobj = nil;
    local is_temp_model = nil
    if item_modelid and item_modelid > 0 then
        local filename = ObjectManager.GetItemModelFile(item_modelid);
        if filename == nil then
            return;
        end
        --app.log(filename)
        assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateItem", CREATE_OBJ_MODEL_OPTION.AUTO)
        if assetobj == nil then
            app.log("Item 模型未预加载，不能显示   3" .. filename);
            return;
        end
    else
        -- 来个不需要显示的空节点
        assetobj = EffectManager.placeHolderRes;
    end
    local oldObj = ObjectManager.GetObjectByGID(gid)
    if oldObj then
        ObjectManager.DeleteObj(oldObj:GetName())
    end
    local name = nil
    if have_gid then
        name = "Item_" .. camp_flag .. "_" .. gid;
    else
        name = ObjectManager.GetObjectName(OBJECT_TYPE.ITEM, camp_flag, ObjectManager.cur_uuid);
    end
    local data =
    {
        obj = assetobj,
        config = { },
        camp_flag = camp_flag,
        name = name,
        objType = OBJECT_TYPE.ITEM,
        gid = gid,
    };
    data.config.id = id;
    data.config.config_id = config_id;
    data.config.model_id = item_modelid;
    if data.config.model_id == 0 then
        data.config.model_id = nil;
    end
    data.config.effect_id = item_effectid;
    if data.config.effect_id == 0 then
        data.config.effect_id = nil;
    end
    data.config.trigger_id = id;
    local item = SceneEntity:new(data);
    if item then
        -- local iid = item:GetIid()
        -- ObjectManager.objects[name] = item;
        -- ObjectManager.objects_gid[gid] = item;
        -- ObjectManager.objects_iid[iid] = item
        ObjectManager.AddObject(item)

        ObjectManager.cur_uuid = ObjectManager.cur_uuid + 1;
    end
    -- 设置父节点
    item:SetGameObjectParent(ObjectManager.itemRootAssert);

    item:GetObject():set_layer(PublicStruct.UnityLayer.ground_item, true);
    if is_opened then
        item.is_item_open = true;
        item:PlayAnimate(EANI.dead)
    end
    return item, is_temp_model;
end

--[[ 创建召唤物 ]]
function ObjectManager.CreateSummoneUnit(fight_player_gid, id, gid, camp_flag, country_id, card_source, model_option)
    if gid == nil then
        gid = ObjectManager.cur_gid
        ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    end
    -- 所有的召唤物都放到一个节点下面
    if not ObjectManager.summoneRootAssert then
        local mr = asset_game_object.find("summone_root");
        if not mr then
            ObjectManager.summoneRootAssert = asset_game_object.create(EffectManager.placeHolderRes);
            ObjectManager.summoneRootAssert:set_name("summone_root");
            PublicFunc.obj_init(ObjectManager.summoneRootAssert);
            ObjectManager.summoneRootAssert:set_active(true);

            if not SceneManager.GetCurrentScene().fightScene then
                app.log('创建召唤物的时候fightScene节点还没有创建！' .. debug.traceback())
            end
            ObjectManager.summoneRootAssert:set_parent(SceneManager.GetCurrentScene().fightScene);
        end
    end
    local filename = ObjectManager.GetHeroModelFile(id);
    if filename == nil then
        app.log("CreateSummoneUnit 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateSummoneUnit", model_option)
    if nil == assetobj then
        return
    end

    local oldObj = ObjectManager.GetObjectByGID(gid)
    if oldObj then
        ObjectManager.DeleteObj(oldObj:GetName())
    end
    local assetobj = ResourceManager.GetResourceObject(filename);
    if assetobj == nil then
        app.log("SummoneUnit 模型未预加载，不能显示   2" .. filename);
        return;
    end
    equipTable = equipTable or g_dataCenter.package;

    if card_source == nil then
        app.log("error summone card, id:" .. id .. " uuid=" .. uuid .. "  " .. debug.traceback());
        --[[for k, v in pairs(equipTable.list[1]) do
			app.log("uuid:"..k.." equipTable:"..table.tostring(v));
        end]]
    end


    local name = ObjectManager.GetObjectName(OBJECT_TYPE.SUMMONEUNIT, camp_flag, uuid or ObjectManager.cur_uuid);
    local data =
    {
        obj = assetobj,
        config = ObjectManager.HeroConfigToRole(ConfigHelper.GetRole(id)),
        camp_flag = camp_flag,
        country_id = country_id,
        name = name,
        objType = OBJECT_TYPE.SUMMONEUNIT,
        card = card_source,
        gid = gid,
        owner_player_gid = fight_player_gid,
    };
    local summone = SceneEntity:new(data);
    if summone then
        -- local iid = summone:GetIid()
        -- ObjectManager.objects[name] = summone;
        -- ObjectManager.objects_gid[gid] = summone
        -- ObjectManager.objects_iid[iid] = summone
        ObjectManager.AddObject(summone)

        if not uuid then
            ObjectManager.cur_uuid = ObjectManager.cur_uuid + 1;
        end
    end
    -- 设置父节点
    summone:SetGameObjectParent(ObjectManager.summoneRootAssert);
    return summone, is_temp_model;
end

function ObjectManager.CreateNPC(id, camp_flag, gid, model_option)
    if gid == nil then
        gid = ObjectManager.cur_gid
        ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    end
    if not ObjectManager.npcRootAssert then
        local nr = asset_game_object.find("npc_root");
        if not nr then
            ObjectManager.npcRootAssert = asset_game_object.create(EffectManager.placeHolderRes);
            ObjectManager.npcRootAssert:set_name("npc_root");
            PublicFunc.obj_init(ObjectManager.npcRootAssert);
            ObjectManager.npcRootAssert:set_active(true);

            if not SceneManager.GetCurrentScene().fightScene then
                app.log('创建npc的时候fightScene节点还没有创建！' .. debug.traceback())
            end
            ObjectManager.npcRootAssert:set_parent(SceneManager.GetCurrentScene().fightScene);
        end
    end

    local filename = ObjectManager.GetNpcModelFile(id);
    if filename == nil then
        app.log("CreateNPC 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateNPC", model_option)
    if nil == assetobj then
        return
    end

    local oldObj = ObjectManager.GetObjectByGID(gid)
    if oldObj then
        ObjectManager.DeleteObj(oldObj:GetName())
    end
    local name = ObjectManager.GetObjectName(OBJECT_TYPE.NPC, camp_flag, ObjectManager.cur_uuid);
    local card_data =
    {
        dataid = uuid,
        number = id,
        level = 1,
    }
    local card = CardHuman:new(card_data);

    local data =
    {
        obj = assetobj,
        config = ObjectManager.NpcConfigToRole(ConfigManager.Get(EConfigIndex.t_npc,id)),
        camp_flag = camp_flag,
        name = name,
        card = card,
        objType = OBJECT_TYPE.NPC,
        gid = gid,
    };
    local npc = SceneEntity:new(data);

    if npc then
        -- local iid = npc:GetIid()
        -- ObjectManager.objects[name] = npc;
        -- ObjectManager.objects_gid[gid] = npc;
        -- ObjectManager.objects_iid[iid] = npc;
        ObjectManager.AddObject(npc)

        ObjectManager.cur_uuid = ObjectManager.cur_uuid + 1;
    end

    -- 设置父节点
    npc:SetGameObjectParent(ObjectManager.npcRootAssert);
    return npc, is_temp_model;
end

function ObjectManager.CreateMMONPC(id, camp_flag, gid, model_option)

    if gid == nil then
        gid = ObjectManager.cur_gid
        ObjectManager.cur_gid = ObjectManager.cur_gid - 1
    end
    if not ObjectManager.npcRootAssert then
        local nr = asset_game_object.find("npc_root");
        if not nr then
            ObjectManager.npcRootAssert = asset_game_object.create(EffectManager.placeHolderRes);
            ObjectManager.npcRootAssert:set_name("npc_root");
            PublicFunc.obj_init(ObjectManager.npcRootAssert);
            ObjectManager.npcRootAssert:set_active(true);

            if not SceneManager.GetCurrentScene().fightScene then
                app.log('创建npc的时候fightScene节点还没有创建！' .. debug.traceback())
            end
            ObjectManager.npcRootAssert:set_parent(SceneManager.GetCurrentScene().fightScene);
        end
    end

    local filename = ObjectManager.GetMMONpcModelFile(id);
    if filename == nil then
        app.log("CreateMMONPC 模型名字未找到，id=" .. id);
        return;
    end

    local assetobj, is_temp_model = ObjectManager._GetModelResWithOptions(filename, "CreateMMONPC", model_option)
    if nil == assetobj then
        return;
    end

    local oldObj = ObjectManager.GetObjectByGID(gid)
    if oldObj then
        ObjectManager.DeleteObj(oldObj:GetName())
    end
    local name = ObjectManager.GetObjectName(OBJECT_TYPE.NPC, camp_flag, ObjectManager.cur_uuid);
    local card_data =
    {
        dataid = uuid,
        number = id,
        level = 1,
    }
    local card = CardHuman:new(card_data);

    local data =
    {
        obj = assetobj,
        config = ObjectManager.NpcConfigToRole(ConfigManager.Get(EConfigIndex.t_npc_data,id)),
        camp_flag = camp_flag,
        name = name,
        card = card,
        objType = OBJECT_TYPE.NPC,
        gid = gid,
    };
    local npc = SceneEntity:new(data);
    if npc then
        -- local iid = npc:GetIid()
        -- ObjectManager.objects[name] = npc;
        -- ObjectManager.objects_gid[gid] = npc;
        -- ObjectManager.objects_iid[iid] = npc;
        ObjectManager.AddObject(npc)

        ObjectManager.cur_uuid = ObjectManager.cur_uuid + 1;
    end
    -- 设置父节点
    npc:SetGameObjectParent(ObjectManager.npcRootAssert);
    return npc, is_temp_model;
end

-- 获取assetbund路径
function ObjectManager.GetMonsterModelFile(id)
    if ConfigManager.Get(EConfigIndex.t_monster_property,id) == nil then
        app.log("取了一个不存在怪物属性id........" .. id .. debug.traceback());
        return;
    end
    local model_id = ConfigManager.Get(EConfigIndex.t_monster_property,id).model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("怪物模型id配置错误........" .. model_id .. ' ' .. id .. debug.traceback());
        return;
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,model_id).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle', modelName, modelName);
    return filePath;
end
function ObjectManager.GetHeroModelFile(id)
    if ConfigHelper.GetRole(id) == nil then
        app.log("取了一个不存在英雄属性id........" .. tostring(id) .. debug.traceback());
        return;
    end
    local model_id = ConfigHelper.GetRole(id).model_id;
    -- if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
    --     app.log("英雄模型id配置错误........" .. tostring(model_id) .. ' ' .. tostring(id) .. debug.traceback());
    --     return;
    -- end
    -- local modelName = ConfigManager.Get(EConfigIndex.t_model_list,model_id).file;
    -- local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle', modelName, modelName);
    -- return filePath;
    return ObjectManager.GetHeroModelFileByModelId(model_id)
end

function ObjectManager.GetHeroModelFileByModelId(model_id)
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("英雄模型id配置错误........" .. tostring(model_id) .. ' ' .. tostring(id) .. debug.traceback());
        return nil;
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,model_id).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle', modelName, modelName);
    return filePath;
end

function ObjectManager.GetItemModelFile(modelid)
    if not modelid then
        app.log('huhu_screenplay_debug GetItemModelFile' .. debug.traceback())
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,modelid).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle', modelName, modelName);
    return filePath;
end

function ObjectManager.GetItemModelFileVip(modelid)
    if not modelid then
        app.log('huhu_screenplay_debug GetItemModelFile' .. debug.traceback())
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,modelid).file;
    local filePath = string.format('assetbundles/prefabs/character/vip/%s/%s_fbx.assetbundle', modelName, modelName);
    return filePath;
end

function ObjectManager.GetHighItemModelFile(modelid)
    if not modelid then
        app.log('huhu_screenplay_debug GetItemModelFile' .. debug.traceback())
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,modelid).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_high_fbx.assetbundle', modelName, modelName);
    return filePath;
end

function ObjectManager.GetNpcModelFile(id)
    if ConfigManager.Get(EConfigIndex.t_npc,id) == nil then
        app.log("取了一个不存在npc属性id........" .. tostring(id) .. debug.traceback());
        return;
    end
    local model_id = ConfigManager.Get(EConfigIndex.t_npc,id).model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("英雄模型id配置错误........" .. tostring(model_id) .. ' ' .. tostring(id) .. debug.traceback());
        return;
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,model_id).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle', modelName, modelName);
    return filePath;
end

function ObjectManager.GetMMONpcModelFile(id)
    if ConfigManager.Get(EConfigIndex.t_npc_data,id) == nil then
        app.log("取了一个不存在npc属性id........" .. tostring(id) .. debug.traceback());
        return;
    end
    local model_id = ConfigManager.Get(EConfigIndex.t_npc_data,id).model_id;
    if ConfigManager.Get(EConfigIndex.t_model_list,model_id) == nil then
        app.log("MMONPC模型id配置错误........" .. tostring(model_id) .. ' ' .. tostring(id) .. debug.traceback());
        return;
    end
    local modelName = ConfigManager.Get(EConfigIndex.t_model_list,model_id).file;
    local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle', modelName, modelName);
    return filePath;
end

function ObjectManager.GetScreenPlayModelFile(name)
    if not name then
        return nil;
    end
    return string.format("assetbundles/prefabs/character/screen_play/%s/%s_fbx.assetbundle",name,name);
end

function ObjectManager.GetObjectByNumber(config_number)
    for k, v in pairs(ObjectManager.objects) do
        if v:GetConfig("id") == config_number then
            return v
        end
    end
end

-- 获取一个物件名字
-- obj_type 1 英雄 2 怪物 4 道具 8 召唤物 16 npc
-- camp_flag 1 敌方 2 我方
-- uuid 唯一id
function ObjectManager.GetObjectName(obj_type, camp_flag, uuid)
    local name = ""
    if obj_type == OBJECT_TYPE.HERO then
        name = name .. "Hero_" .. tostring(camp_flag) .. "_" .. tostring(uuid);
    elseif obj_type == OBJECT_TYPE.MONSTER then
        name = name .. "Monster_" .. tostring(camp_flag) .. "_" .. tostring(uuid)
    elseif obj_type == OBJECT_TYPE.ITEM then
        name = name .. "Item_" .. tostring(camp_flag) .. "_" .. tostring(uuid)
    elseif obj_type == OBJECT_TYPE.SUMMONEUNIT then
        name = name .. "Summone_" .. tostring(camp_flag) .. "_" .. tostring(uuid)
    elseif obj_type == OBJECT_TYPE.NPC then
        name = name .. "Npc_" .. tostring(camp_flag) .. "_" .. tostring(uuid)
    else
        name = name .. tostring(uuid);
    end
    return name;
end

-- 根据名字获取对象
function ObjectManager.GetObjectByName(name)
    if not ObjectManager.objects[name] then
        -- app.log_warning('找不到某个对象：'..tostring(name)..' '..table.tostring(ObjectManager.objects,1)..'\n'..debug.traceback())

        -- TODO: (kevin @all) 平时打开， 发布的时候屏蔽
        -- app.log_warning('找不到某个对象是不是逻辑有问题了：'..tostring(name))
    end
    return ObjectManager.objects[name];
end

function ObjectManager.GetObjectByGID(gid)
    local _gid = gid
    if type(_gid) == "string" and string.len(_gid) <= 10 then
        _gid = tonumber(gid)
    end
    if not ObjectManager.objects_gid[_gid] then
        -- app.log_warning('找不到某个对象：'..tostring(name)..' '..table.tostring(ObjectManager.objects,1)..'\n'..debug.traceback())

        -- TODO: (kevin @all) 平时打开， 发布的时候屏蔽
        -- app.log_warning('找不到某个对象是不是逻辑有问题了：'..tostring(name))
    end
    return ObjectManager.objects_gid[_gid];
end

function ObjectManager.GetObjectByIid(iid)
    local obj = ObjectManager.objects_iid[iid]
    if obj then
        return obj
    else
        --app.log_warning('找不到某个对象是不是逻辑有问题了：' .. tostring(iid))
    end


end

function ObjectManager.ChangeObjectGID(old_gid, new_gid)

    if ObjectManager.objects_gid[old_gid] then
        ObjectManager.objects_gid[new_gid] = ObjectManager.objects_gid[old_gid]
        ObjectManager.objects_gid[old_gid] = nil;
        ObjectManager.objects_gid[new_gid].gid = new_gid
    end
end

-- 根据标志获取对象列表
function ObjectManager.GetObjectByFlag(camp_flag)
    if camp_flag == nil then
        return ObjectManager.objects;
    else
        local objects = { }
        for k, v in pairs(ObjectManager.objects) do
            if v:GetCampFlag() == camp_flag then
                objects[k] = v;
            end
        end
        return objects;
    end
end
-- 根据配置编号获取对象列表
function ObjectManager.GetObjectByNumber(id)
    for k, v in pairs(ObjectManager.objects) do
        if v:GetConfigNumber() == id then
            return v;
        end
    end
end

-- 遍历对象的接口,func返回false表示不需要再继续遍历了。
function ObjectManager.ForEachObj(func)
    for k, v in pairs(ObjectManager.objects) do
        if func(k, v) == false then
            break;
        end
    end
end

function ObjectManager.SnapshootForeachObj(func)

    --我们删除在update中实际执行，不用当心对象删除
    local objs = {}
    for k,v in pairs(ObjectManager.objects) do
        table.insert(objs, v)
    end

    for k,v in ipairs(objs) do
        if func(v:GetName(), v) == false then
            break;
        end
    end
end


-- function ObjectManager.OnObjectDead(object)
-- 	if not object then
-- 		app.log('被通知有角色挂了，但是传入的role是个空的')
-- 		return
-- 	end

--     if object:IsDeleteOnDead() then
-- 		ObjectManager.RemoveObject(object)
--     end
-- end

ObjectManager.RemoveObject = ObjectManager.DeleteObjByObj

function ObjectManager.IsEmptyPosition(name, x, y, z)
    for k, v in pairs(ObjectManager.objects) do
        local posx, posy, posz = v:GetDestination();
        if posx and posz then
            if v:GetName() ~= name and algorthm.GetDistanceSquared(x, z, posx, posz) < 0.5 then
                return false;
            end
        end
    end
    return true;
end

function ObjectManager.GetPositionDistance(x, z, r, direct)
    local list = { };

    list[#list + 1] = { };
    list[#list].x = direct.x * r + x;
    list[#list].z = direct.z * r + z;

    local qx, qy, qz, qw = util.quaternion_euler(0, 40, 0);
    local nx, ny, nz = util.quaternion_multiply_v3(qx, qy, qz, qw, direct.x, direct.y, direct.z);
    list[#list + 1] = { };
    list[#list].x = nx * r + x;
    list[#list].z = nz * r + z;


    qx, qy, qz, qw = util.quaternion_euler(0, -40, 0);
    nx, ny, nz = util.quaternion_multiply_v3(qx, qy, qz, qw, direct.x, direct.y, direct.z);
    list[#list + 1] = { };
    list[#list].x = nx * r + x;
    list[#list].z = nz * r + z;

    return list;
end

function ObjectManager.OnFollowChanged()
    local captain = FightManager.GetMyCaptain()
    for k, role in pairs(ObjectManager.objects) do
        if role:IsMyControl() and role ~= captain and(not role:IsObjType(OBJECT_TYPE.SUMMONEUNIT)) then
            role:SetAiEnable(PublicStruct.Open_Follow)
        end
    end
end

function ObjectManager.EnableAllAi(enable)
    for k, role in pairs(ObjectManager.objects) do
        if role:IsShow() then
            if enable then
                role:PostEvent(AIEvent.RESUME);
            else
                role:PostEvent(AIEvent.PAUSE);
            end
        end
    end
end

function ObjectManager.ShowObjects(enable, names)
    for k,name in ipairs(names) do
        local obj = GetObj(name)
        if obj then
            obj:Show(enable)
        end
    end
end

function ObjectManager.ChangeCaptainFightMode(autoFight)
    local captain = FightManager.GetMyCaptain()
    if captain ~= nil then
        if autoFight == true then
            local view, act = FightScene.GetFightManager():GetMainHeroAutoFightViewAndActRadius()

            if captain:GetConfig("view_radius") == nil then
                captain:SetConfig("view_radius", view)
            end
            if captain:GetConfig("act_radius") == nil then
                captain:SetConfig("act_radius", act)
            end

            if FightScene.GetFightManager():IsAutoSetPath() then
                local pathName
                ObjectManager.autoFightPath, pathName = LevelMapConfigHelper.GetWayPoint('hwp_1', true)

                if type(ObjectManager.autoFightPath) ~= 'table' or #ObjectManager.autoFightPath < 1 then
                    -- 如果没有配置点，则使用主角当前所在位置为路径
                    local pos = captain:GetPosition(true, true)
                    ObjectManager.autoFightPath = { pos }
                end

                captain:SetPatrolMovePath(ObjectManager.autoFightPath)
                if pathName ~= nil and string.find(pathName, 'loop', 1, true) ~= nil then
                    captain:SetAlongPathLoop(true)
                end
            end

            local id = FightScene.GetFightManager():GetMainHeroAutoFightAI()
            captain:SetAI(id)
            captain:KeepNormalAttack(true)
            FightScene.GetFightManager():SetMainHeroAI(id)
        else
            if FightScene.GetFightManager():IsAutoSetPath() then
                captain:SetPatrolMovePath(nil)
            end
            local id = ENUM.EAI.MainHero
            -- 手动操作
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                id = ENUM.EAI.PVPMainHero
            end
            captain:SetAI(id)
            captain:KeepNormalAttack(false)
            FightScene.GetFightManager():SetMainHeroAI(id)
        end

        NoticeManager.Notice(ENUM.NoticeType.ChangeAutoFightMode, autoFight)
    end

end


function ObjectManager.GetHeroPreloadList(hero_id, out_file_list)
    local file_name = ObjectManager.GetHeroModelFile(hero_id)

    -- app.log(">>>>>>>>>>>>>>>>>>>>> preload hero:".. file_name)


    if file_name ~= nil then
        local roleData = ConfigHelper.GetRole(hero_id)
        if roleData then
            if roleData.all_skill_effect then
                for eid, edata in pairs(roleData.all_skill_effect) do
                    out_file_list[eid] = eid
                    -- app.log("         "..eid);
                end
            end
            if roleData.all_skill_model then
                for mid, edata in pairs(roleData.all_skill_model) do
                    out_file_list[mid] = mid
                    -- app.log("         "..mid);
                end
            end
            
            if roleData.all_skill_sound then
                for mid, edata in pairs(roleData.all_skill_sound) do
                    out_file_list[mid] = mid
                    -- app.log("         "..mid);
                end
            end
            
        end
        out_file_list[file_name] = file_name
        -- app.log("         "..file_name);
    else
        app.log("ObjectManager.GetHeroPreloadList null file name. id=" .. hero_id);
    end

    -- app.log(" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
end

function ObjectManager.GetMonterPreloadList(monster_id, out_file_list)
    local file_name = ObjectManager.GetMonsterModelFile(monster_id)

    -- app.log(">>>>>>>>>>>>>>>>>>>>> preload monster:".. file_name)

    if file_name ~= nil then
        local roleData = ConfigManager.Get(EConfigIndex.t_monster_property,monster_id)
        if roleData then
            if roleData.all_skill_effect then
                for eid, edata in pairs(roleData.all_skill_effect) do
                    out_file_list[eid] = eid
                    -- app.log("         "..eid);
                end
            end
            if roleData.all_skill_model then
                for mid, edata in pairs(roleData.all_skill_model) do
                    out_file_list[mid] = mid
                    -- app.log("         "..mid);
                end
            end
            
            if roleData.all_skill_sound then
                for mid, edata in pairs(roleData.all_skill_sound) do
                    out_file_list[mid] = mid
                    -- app.log("         "..mid);
                end
            end
            
        end
        out_file_list[file_name] = file_name
        -- app.log("         "..file_name);
    else
        app.log("ObjectManager.GetHeroPreloadList null file name. id=" .. hero_id);
    end

    -- app.log(" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
end

function ObjectManager.RemoveFromGroup(groupName, name)
    if not groupName or not name then return end
        
    local group = ObjectManager.groups[groupName]
    if group and group[name] then
        group[name] = nil
    end
end

function ObjectManager.AddToGroup(groupName, obj)
    if not groupName or not obj then return end

    local group = ObjectManager.groups[groupName]
    if not group then
        group = {}
        ObjectManager.groups[groupName] = group
    end
    group[obj:GetName()] = obj
end

function ObjectManager.GetGroup(groupName)
    return ObjectManager.groups[groupName]
end


GetObj = ObjectManager.GetObjectByName

function ObjectManager.SetIid(iid, role)
    ObjectManager.objects_iid[iid] = role;
end

function ObjectManager.ClearAllMonster()
    for k, v in pairs(ObjectManager.objects_gid) do
        if v:IsMonster() and v:IsEnemy() then
            v:Suicide();
        end
    end
end

-- delayTime (s)
function ObjectManager.DelayCreateMonsterFromMapinfoConfig(config, level, delayTime, callback)
    local createInstance = {config = config, level = level, callback = callback , passTime = 0 , createTime = app.get_time() + delayTime}
    table.insert(ObjectManager.delayCreateMonsterFromMapInfo, createInstance)
end