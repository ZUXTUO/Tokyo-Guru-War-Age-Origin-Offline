ConfigHelper = {
	skill_effect_model_key = nil,

	role_default_rarity_property = {},

	--角色等级成长属性缓存
	role_max_level = 100, 	-- 角色最大等级
	role_level_property_growth = {},

    equip_level_info = {},
    equip_rarity_info = {},
    systemid_to_npc_id = {},
    restrain_table = {},

    preLoadFlag = {
        onStarup = 1, -- 启动游戏， 加载脚本阶段
        onEnterGame = 2, -- 完成登录， 进入游戏
    }
}

function ConfigHelper.GetHurdleConfig(id)
    if id == nil then
        app.log("."..debug.traceback())
    end
	local cfg = ConfigManager.Get(EConfigIndex.t_hurdle, id)
	if nil == cfg then
		cfg = ConfigManager.Get(EConfigIndex.t_play_method_hurdle, id)
	end
    if cfg == nil then
        app.log("config helper id="..tostring(id)..debug.traceback())
    end
	return cfg;
end

function ConfigHelper.GetNpcIdBySystemid(systemid)
    local t = ConfigHelper.systemid_to_npc_id[systemid];
    if t == nil then
        local cfg = ConfigManager._GetConfigTable(EConfigIndex.t_npc);
        if cfg then
            for k, v in pairs(cfg) do
                if v.systemid == systemid then
                    ConfigHelper.systemid_to_npc_id[systemid] = k;
                    t = k;
                    break;
                end
            end
        end
    end
    return t;
end

-----------mapinfo helper..
EMapInfType = {
	monster = "monster";	
	burchmonster = "burchmonster";
	item = "item";
	entity = "entity";
	burchhero = "burchhero";
	pathpoint = "pathpoint";
	npc = "npc";
	translation_point = "translation_point";
	map_info = "map_info";
	task_destination = "task_destination";
	map_monster = "map_monster";
	safe_area = "safe_area";
}

function ConfigHelper.__LoadMapInfo(map_id)
	local cfgName = EConfigIndex["t_mapinfo_"..map_id]
	ConfigManager.LoadConfig(cfgName)
end

function ConfigHelper.GetMapInf(map_id, inf_type)
	if map_id == nil or inf_type == nil then
		app.log(string.format("ConfigHelper.GetMapInf bad input parm. map_id:%s, inf_type:%s",tostring(map_id), tostring(inf_type)))
		return nil
	end

	ConfigHelper.__LoadMapInfo(tostring(map_id))
	local tableName = string.format("gd_hurdle_%s_%s", tostring(map_id), tostring(inf_type))
	return _G[tableName]
end

function ConfigHelper.GetFightScript(id)

	local cfg_name = string.format("t_fight_script_%s", tostring(id))
	ConfigManager.LoadConfig(EConfigIndex[cfg_name])

	local table_name = string.format("gd_fight_script_%s", tostring(id))
	local t = _G[table_name]

	if nil == t then
		app.log(string.format("#######sfs:%s,%s,%s", tostring(id), tostring(table_name), tostring(cfg_name)))
	end

	return t;
end


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
function ConfigHelper.BuildSkillEffectModelKey()
    --TODO:能否独立一张表？？
	if ConfigHelper.skill_effect_model_key == nil then
		ConfigHelper.skill_effect_model_key = {}
		local _skill_effect = ConfigManager._GetConfigTable(EConfigIndex.t_skill_effect)
		for k, v in pairs(_skill_effect) do
		    local new_key = bit.bit_lshift(v.model_id, 8) + v.action_id
		    ConfigHelper.skill_effect_model_key[new_key] = v
		end
	end
end

function ConfigHelper.GetSkillEffectByModelId(modeid, actionid)
	if nil == ConfigHelper.skill_effect_model_key then
		ConfigHelper.BuildSkillEffectModelKey()
	end
    return ConfigHelper.skill_effect_model_key[bit.bit_lshift(modeid, 8) + actionid]
end
---<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--role表获取接口
function ConfigHelper.GetRole(role_id)
	local role_index = ConfigManager.Get(EConfigIndex.t_role_index, role_id)
	if nil == role_index then
		--return nil
        role_index = { default_rarity = 1 }  -- 根据需要设置默认值
	end
	local lookup_table = "role_index_"..tostring(role_index.default_rarity)
	local cfgIndexName = ConfigManager.SpliceIndexName(lookup_table)
	local cfg = ConfigManager.Get(cfgIndexName, role_id)
	if nil == cfg then
		app.log("GetRole :xxxxxxxxxx: " ..role_id.." lookup_table="..lookup_table.." cfgIndexName="..tostring(cfgIndexName)..debug.traceback())
	end
    SupplementResourceConfig(cfg)
	return cfg;
end

function ConfigHelper.GetEquipLevel(equip_id, equip_lv)
    if ConfigHelper.equip_level_info[equip_id] then
        return ConfigHelper.equip_level_info[equip_id][equip_lv]
    end
    local equip_base = ConfigManager.Get(EConfigIndex.t_equipment, equip_id)
    if equip_base == nil then
        return nil
    end
    local base_role_id = nil
    local cost_ratio = 1.0
    local equip_role_cfg = ConfigManager.Get(EConfigIndex.t_equipment_role, equip_base.default_rarity)
    if equip_role_cfg then
        base_role_id = equip_role_cfg.role_id
    else
        app.log("not found equip base role id["..equip_id.."]")
    end
    if base_role_id then
        local role_cfg = ConfigHelper.GetRole(base_role_id)
        if role_cfg then
            local cost_config = ConfigManager.Get(EConfigIndex.t_equipment_cost_ratio, role_cfg.aptitude)
            if cost_config then
                cost_ratio = cost_config.ratio
            else
                app.log("not found equip cost cfg["..role_cfg.aptitude.."]")
            end
        else
            app.log("not found equip base role cfg["..base_role_id.."]")
        end
    end
    ConfigHelper.equip_level_info[equip_id] = {}
    if equip_base.level_config == 0 then
        local max_equip_level = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_equip_max_level).data
        for level=1, max_equip_level do
            local level_data = {}
            level_data.level = level
            level_data.max_hp = equip_base.default_max_hp + equip_base.max_hp_level_factor*(level-1);
			level_data.atk_power = equip_base.default_atk_power + equip_base.atk_power_level_factor*(level-1);
			level_data.def_power = equip_base.default_def_power + equip_base.def_power_level_factor*(level-1);
            local level_cost = ConfigManager.Get(EConfigIndex["t_equipment_lv_cost_"..equip_base.level_cost_config], level)
            if level_cost then
                level_data.need_exp = math.ceil(level_cost.exp*cost_ratio)
                level_data.cost_gold = math.floor(level_cost.gold*cost_ratio/10)*10
            else
                app.log("not found level cost data ["..equip_base.level_cost_config.."-"..level.."]")
            end
            ConfigHelper.equip_level_info[equip_id][level] = level_data
        end
    else
        local equip_level_cfg = ConfigManager._GetConfigTable(EConfigIndex["t_equipment_"..equip_base.level_config])
        if equip_level_cfg then
            for k,v in pairs(equip_level_cfg) do
                local level_data = {}
                level_data.level = k
                level_data.max_hp = v.max_hp
                level_data.atk_power = v.atk_power
                level_data.def_power = v.def_power
                local level_cost = ConfigManager.Get(EConfigIndex["t_equipment_lv_cost_"..equip_base.level_cost_config], level_data.level)
                if level_cost then
                    level_data.need_exp = math.ceil(level_cost.exp*cost_ratio)
                    level_data.cost_gold = math.floor(level_cost.gold*cost_ratio/10)*10
                else
                    app.log("not found level cost data ["..equip_base.level_cost_config.."-"..level_data.level.."]")
                end
                ConfigHelper.equip_level_info[equip_id][level_data.level] = level_data
            end
        else
            app.log("not found equip level cfg ["..equip_base.level_config.."]")
        end
    end
    return ConfigHelper.equip_level_info[equip_id][equip_lv]
end

function ConfigHelper.__GetEquipRarityIconIndex(rarity)
    if rarity == 0 then
        return 0
    elseif rarity >= 1 and rarity <= 2 then
        return 1
    elseif rarity >= 3 and rarity <= 5 then
        return 2
    elseif rarity >= 6 and rarity <= 9 then
        return 3
    elseif rarity >= 10 and rarity <= 14 then
        return 4
    else
        return 5
    end
end

function ConfigHelper.GetEquipRarity(equip_id, rarity)
    if ConfigHelper.equip_rarity_info[equip_id] then
        return ConfigHelper.equip_rarity_info[equip_id][rarity]
    end
    local equip_base = ConfigManager.Get(EConfigIndex.t_equipment, equip_id)
    if equip_base == nil then
        return nil
    end
    local base_role_id = nil
    local cost_ratio = 1.0
    local equip_role_cfg = ConfigManager.Get(EConfigIndex.t_equipment_role, equip_base.default_rarity)
    if equip_role_cfg then
        base_role_id = equip_role_cfg.role_id
    else
        app.log("not found equip base role id["..equip_id.."]")
    end
    if base_role_id then
        local role_cfg = ConfigHelper.GetRole(base_role_id)
        if role_cfg then
            local cost_config = ConfigManager.Get(EConfigIndex.t_equipment_cost_ratio, role_cfg.aptitude)
            if cost_config then
                cost_ratio = cost_config.ratio
            else
                app.log("not found equip cost cfg["..role_cfg.aptitude.."]")
            end
        else
            app.log("not found equip base role cfg["..base_role_id.."]")
        end
    end
    ConfigHelper.equip_rarity_info[equip_id] = {}
    if equip_base.rarity_config == 0 then
        local max_equip_rarity = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_equip_max_rarity).data
        for rarity=0, max_equip_rarity do
            local rarity_data = {}
            rarity_data.rarity = rarity
            rarity_data.max_hp = equip_base.max_hp_rarity_factor*rarity;
			rarity_data.atk_power = equip_base.atk_power_rarity_factor*rarity;
			rarity_data.def_power = equip_base.def_power_rarity_factor*rarity;
            local rarity_cost = ConfigManager.Get(EConfigIndex["t_equipment_rarity_cost_"..equip_base.rarity_cost_config], rarity)
            if rarity_cost then
                rarity_data.level = rarity_cost.level
                rarity_data.need_gold = math.floor(rarity_cost.need_gold*cost_ratio)
                rarity_data.material = {}
                if rarity_cost.material ~= 0 then
                    for k, v in pairs(rarity_cost.material) do
                        rarity_data.material[k] = {}
                        rarity_data.material[k].number = v.number
                        if equip_base.position == ENUM.EEquipPosition.Helmet or equip_base.position == ENUM.EEquipPosition.Accessories then
                            rarity_data.material[k].count = math.floor(v.count*cost_ratio/10)*10
                        else
                            rarity_data.material[k].count = math.ceil(v.count*cost_ratio)
                        end
                    end
                end
            else
                app.log("not found rarity cost data ["..equip_base.rarity_cost_config.."-"..rarity.."]")
            end
            rarity_data.small_icon = equip_base["equip_icon"]
            rarity_data.name = PublicFunc.GetEquipName(equip_base["equip_name"], rarity_data.rarity)  

            ConfigHelper.equip_rarity_info[equip_id][rarity] = rarity_data
        end
    else
        local equip_rarity_cfg = ConfigManager._GetConfigTable(EConfigIndex["t_equipment_rarity_"..equip_base.rarity_config])
        if equip_rarity_cfg then
            for k,v in pairs(equip_rarity_cfg) do
                local rarity_data = {}
                rarity_data.rarity = k
                rarity_data.max_hp = v.max_hp
                rarity_data.atk_power = v.atk_power
                rarity_data.def_power = v.def_power
                local rarity_cost = ConfigManager.Get(EConfigIndex["t_equipment_rarity_cost_"..equip_base.rarity_cost_config], rarity_data.rarity)
                if rarity_cost then
                    rarity_data.level = rarity_cost.level
                    rarity_data.need_gold = math.floor(rarity_cost.need_gold*cost_ratio)
                    rarity_data.material = {}
                    if rarity_cost.material ~= 0 then
                        for k, v in pairs(rarity_cost.material) do
                            rarity_data.material[k] = {}
                            rarity_data.material[k].number = v.number
                            if equip_base.position == ENUM.EEquipPosition.Helmet or equip_base.position == ENUM.EEquipPosition.Accessories then
                                rarity_data.material[k].count = math.floor(v.count*cost_ratio/10)*10
                            else
                                rarity_data.material[k].count = math.ceil(v.count*cost_ratio)
                            end
                        end
                    end
                else
                    app.log("not found rarity cost data ["..equip_base.rarity_cost_config.."-"..rarity_data.rarity.."]")
                end
                rarity_data.small_icon = equip_base["equip_icon"]
                rarity_data.name = PublicFunc.GetEquipName(equip_base["equip_name"], rarity_data.rarity) 

                ConfigHelper.equip_rarity_info[equip_id][rarity_data.rarity] = rarity_data
            end
        else
            app.log("not found equip rarity cfg ["..equip_base.rarity_config.."]")
        end
    end
    return ConfigHelper.equip_rarity_info[equip_id][rarity]
end

--预加载配置表
function ConfigHelper.PreLoadConfigFile(step)

    local steps = {
        --游戏启动阶段
        [ConfigHelper.preLoadFlag.onStarup] = 
        {
            func =  function()
                ConfigHelper.__ParseRoleDefaultRarityProperty()
            end,

            tables = {
                -- EConfigIndex.t_task_data,
                -- EConfigIndex.t_skill_effect,
                -- EConfigIndex.t_drop_something,
            },

            peakShowNeededFiles = {

            }
        },

        --进入主城阶段
        [ConfigHelper.preLoadFlag.onEnterGame] = 
        {
            func =  function()
                -- ConfigHelper.__ParseRoleDefaultRarityProperty()
                PublicFunc.GetAllHero();
            end,

            tables = {
                EConfigIndex.t_task_data,
                EConfigIndex.t_skill_effect,
                EConfigIndex.t_drop_something,
                EConfigIndex.t_skill_level_info,
                EConfigIndex.t_hurdle,
                EConfigIndex.t_hurdle_group,
                EConfigIndex.t_task_data,
                EConfigIndex.t_player_level,
                EConfigIndex.t_equipment_level_limit,
                EConfigIndex.t_mondel_invisible_cfg,
                EConfigIndex.t_scale_property_max,
                EConfigIndex.t_scale_property_min,
                EConfigIndex.t_model_bind_pos,
                EConfigIndex.t_hfsm,
                EConfigIndex.t_trigger_config,
                EConfigIndex.t_action_list,
                EConfigIndex.t_vol_scale,
                EConfigIndex.t_property_ratio,
                EConfigIndex.t_role_contact,
            },
        }
    }

    local s = steps[step]
    if nil ~= s then
        if nil ~= s.func then
            s.func();
        end

        for k, v in pairs(s.tables) do
            ConfigManager.LoadConfig(v);
        end
    else
        app.log(tostring(step) .. " not found.")
    end
end

function ConfigHelper.__ParseRoleDefaultRarityProperty()
	local t = ConfigManager._GetConfigTable(EConfigIndex.t_role_index)

	for k, v in pairs(t) do
		if k == v.default_rarity then
			ConfigHelper.role_default_rarity_property[k] = v
		end
	end
end

function ConfigHelper.GetRoleDefaultRarityTable()
	return ConfigHelper.role_default_rarity_property;
end


--角色等级成长属性
function ConfigHelper.CalcRoleLevelProperty(card_cfg, card_number, level)

	local cfg =  ConfigHelper._CalcRoleLevelProperty(card_cfg, card_number, level)

	if nil ~= cfg then
		-- app.log(table.tostring(cfg))
	else
		app.log("get level property failed." .. card_number or card_cfg.number.. " level:"..level);

	end
    return cfg;
end


function ConfigHelper._CalcRoleLevelProperty(card_cfg, card_number, level)
	if level <= 0 or level > ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_playerMaxLevel--[[玩家最大等级]]).data then
        return nil
    end

    -- {upexp, max_hp, atk_power,def_power}
    local card_levels = ConfigHelper.role_level_property_growth[card_number]
    if card_levels ~= nil then
        local l = card_levels[level] 
        if nil ~= l then
            return l
        end
    end

    if nil == card_cfg then
        local cfgName = "role_index_" .. card_number
        card_cfg = ConfigHelper.GetRole(card_number)
        if nil == card_cfg then
            return nil
        end
    end

    --
    if level > ConfigHelper.role_max_level then
        level = ConfigHelper.role_max_level 
    end
    
    local exp_config_name = "role_upgrade_exp_" .. tostring(card_cfg.upgrade_exp_cfg)
    
    local exp_cfg = ConfigManager.Get(ConfigManager.SpliceIndexName(exp_config_name), level)

    if exp_cfg == nil then
        exp_cfg = { upexp = 1 }
    end

    local exp = 0 
    if level < ConfigHelper.role_max_level then
        exp = exp_cfg.upexp
    else
        exp = 0
    end

    ConfigHelper.role_level_property_growth[card_number] = ConfigHelper.role_level_property_growth[card_number] or {}
    card_levels = ConfigHelper.role_level_property_growth[card_number]
    if card_levels[level] == nil then
        card_levels[level] = {}
    end
    local level_property = card_levels[level]
    -- N级卡片属性=1级卡片属性+（N-1）*卡片属性等级成长
    if card_cfg.default_max_hp == nil then card_cfg.default_max_hp = 100 end
    if card_cfg.max_hp_level_factor == nil then card_cfg.max_hp_level_factor = 10 end
    if card_cfg.default_atk_power == nil then card_cfg.default_atk_power = 20 end
    if card_cfg.atk_power_level_factor == nil then card_cfg.atk_power_level_factor = 5 end
    if card_cfg.default_def_power == nil then card_cfg.default_def_power = 15 end
    if card_cfg.def_power_level_factor == nil then card_cfg.def_power_level_factor = 3 end
    if card_cfg.config == nil then card_cfg.config = 1 end

    level_property.max_hp = card_cfg.default_max_hp + (level - 1) * card_cfg.max_hp_level_factor
    level_property.atk_power = card_cfg.default_atk_power + (level - 1) * card_cfg.atk_power_level_factor
    level_property.def_power = card_cfg.default_def_power + (level - 1) * card_cfg.def_power_level_factor
    level_property.upexp = exp
    local level_config_name = "t_role_" .. tostring(card_cfg.config)
    local level_cfg = ConfigManager.Get(EConfigIndex[level_config_name], level)
    if level_cfg then
        level_property.max_hp = level_property.max_hp + level_cfg.max_hp
        level_property.atk_power = level_property.atk_power + level_cfg.atk_power
        level_property.def_power = level_property.def_power + level_cfg.def_power
    end
    return level_property;
end

--fy添加，获取当前突破界限对应阶段所有等级配置
function ConfigHelper.GetBreakthroughStageConfig( defaultNum, stage )
	local index = ConfigManager.Get( EConfigIndex.t_breakthrough_index, defaultNum );
	if index then
		index = tostring( index.breakthrough_index );
		index = string.sub( index, 1, string.len(index) - 1 )..tostring( stage );
		local key = "t_breakthrough_"..index;
		local stageData = ConfigManager._GetConfigTable( EConfigIndex[key] );
		return stageData;
	else
		return nil;
	end
end

--cj添加
function ConfigHelper.GetBreakthroughStageActiveProperty(number)
    local roleConfig = ConfigHelper.GetRole(number)
	
	local defaultNum = roleConfig.default_rarity
	--self.allStageConfigData = {};
	--self.allStageData = {};
	local all_property = {};
	for i = 1, 6 do
		local stageData = ConfigHelper.GetBreakthroughStageConfig( defaultNum, i );
		local active = false
        --app.log("number##############"..tostring(number))
		--app.log("stageData###############" .. i .. '   '.. table.tostring(stageData))
		for k, v in pairs(stageData[1].active_number) do
			if v == number then
				active = true
				break
			end
		end
		if active then
			all_property["atk_power"] = all_property["atk_power"] or 0
			all_property["atk_power"] = all_property["atk_power"] + stageData[1].atk_power
			
			all_property["max_hp"] = all_property["max_hp"] or 0
			all_property["max_hp"] = all_property["max_hp"] + stageData[1].max_hp
			
			all_property["def_power"] = all_property["def_power"] or 0
			all_property["def_power"] = all_property["def_power"] + stageData[1].def_power
		end
	end	
	return all_property
end

--获取整理后的克制数据
function ConfigHelper.GetRestrainTable( restrain_name )
    if not ConfigHelper.restrain_table[restrain_name] then
        local restrain_table = {}
        restrain_table.config = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(restrain_name))
        if restrain_table.config then
            --提取分组信息
            restrain_table.group = {}
            local group_index = 0
            for id, item in pairs_key(restrain_table.config) do
                local index = math.fmod(id - 1, 3) + 1
                if index == 1 then
                    group_index = group_index + 1
                    restrain_table.group[group_index] = {}
                end
                restrain_table.group[group_index][index] = id
            end

            --提取最大等级
            restrain_table.max_level = {}
            for id, item in pairs_key(restrain_table.config) do
                restrain_table.max_level[id] = #item - 1 --配置0-N级
            end

            ConfigHelper.restrain_table[restrain_name] = restrain_table
        end
    end
    
    return ConfigHelper.restrain_table[restrain_name]
end

--获取指定克制id数据
function ConfigHelper.GetRestrainConfig( restrain_name, id )
    local config = {}
    local restrain_table = ConfigHelper.GetRestrainTable( restrain_name )
    if restrain_table and restrain_table.config then
        config = restrain_table.config[id]
    end
    return config
end

--获取克制项最大等级
function ConfigHelper.GetRestrainMaxLevel( restrain_name, id )
    local maxLevel = 0
    local restrain_table = ConfigHelper.GetRestrainTable( restrain_name )
    if restrain_table and restrain_table.max_level then
        maxLevel = restrain_table.max_level[id]
    end
    return maxLevel;
end

--获取克制项分组数据
function ConfigHelper.GetRestrainGroup( restrain_name )
    local group = {}
    local restrain_table = ConfigHelper.GetRestrainTable( restrain_name )
    if restrain_table then
        group = restrain_table.group
    end
    return group;
end

--获取克制项分组数据(id为键，分组未值)
function ConfigHelper.GetRestrainIdGroup( restrain_name )
    local result = {}
    for group_index, data in pairs(ConfigHelper.GetRestrainGroup( restrain_name )) do
        for index, id in pairs(data) do
            result[id] = group_index
        end
    end
    return result
end

-----<Audio helper area>
function ConfigHelper.GetAudioPath(id)
    local cfg = ConfigManager.Get(EConfigIndex.t_audio, id)
    if nil == cfg or nil == cfg.path then
        return nil
    end

    ConfigHelper.UpdateAudioPath(cfg)
    return cfg._fpath;
end

function ConfigHelper.UpdateAudioPath(cfg)
    if nil == cfg then
        return nil
    end

    if cfg._fpath == nil then
        cfg._fpath = "assetbundles/prefabs/sound/prefab/" .. cfg.path
        cfg.path = nil
    end

    return cfg._fpath;
end
----</Audio helper area>
