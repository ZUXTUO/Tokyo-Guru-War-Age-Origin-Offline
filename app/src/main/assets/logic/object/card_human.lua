local property =
{
    -- oldLevel 上一次的等级状态 用于做客户端表现
    -- oldExp 上一次的经验状态 用于做客户端表现
    -- oldNumber 升星前的编号 用户做客户端表现
    -- oldSouls 上一次魂数 用于做客户端表现
    -- index 唯一编号
    -- number 编号
    -- level 等级
    -- hp_point 生命值加成点
    -- phy_at_point 物理攻击强度加成点
    -- energy_at_point 能量攻击强度加成点
    -- phy_def_point 物理防御强度加成点
    -- energy_def_point 能量防御强度加成点
    -- neidan_defense_level; //潜能防御等级
    -- neidan_attack_level;    //潜能攻击等级
    -- neidan_physical_level;  //潜能体力等级
    -- neidan_level 内丹等级
    -- surplus_point 剩余属性点
    -- cur_exp 当前经验
    -- souls 英魂数
    -- dataSource 数据源  当前唯一id 该去哪个数据源查找
    -- equipment={} 穿戴装备id 参见ENUM.EEquipPosition
    -- name 名字
    -- model_id 模型id
    -- small_icon 小图标
    -- head 头像
    -- icon 图标
    -- hezi 赫子 暂时无用
    -- camp 阵营 参见ENUM.ECamp
    -- sex 性别 参见ENUM.ESex
    -- pro_type 职业类型 参见ENUM.EProType
    -- attackType 攻击类型 参见ENUM.EAttackType
    -- passive_buff_id 被动buffid
    -- passive_buff_lv 被动bufflv
    -- skill={} 拥有技能id  参见ENUM.EOwnSkill
    -- skill3_effect 第三击额外效果
    -- skill3_describe 第三击描述
    -- team_add 羁绊队友召唤技能加成
    -- default_rarity 默认初始星级编号
    -- rarity 当前星级
    -- restraint 克制属性 参见ENUM.ERestraint
    -- jiban={} 拥有羁绊id  参见ENUM.EJiBan
    -- property = {} 拥有属性 参见ENUM.EHeroAttribute
    -- describe 描述
    -- bring_up 培养推荐
    -- star_up_number 升星后的编号
    -- soul_count 升星英魂数
    -- get_soul 兑换获得英魂数
    -- upexp 当前最大经验
    -- type 如果是怪的话所属类型 参见ENUM.EMonsterType
    -- view_radius 如果是怪的话视野范围
    -- act_radius 如果是怪的话活动范围
    -- ai 如果是ai的话  id
    -- config 配置表
    -- level_config 等级配置表
    -- lockType 锁定类型
    -- isNotCalProperty 是否不计算属性
    -- illumstration_number
    -- 
}

CardHuman = Class("CardHuman", nil, property)

CardHuman.DefaultShowPropertNames = nil


function CardHuman.InitDefault()
	CardHuman._InitDefaultShowPropertypNames()
end

function CardHuman._InitDefaultShowPropertypNames()
	if not CardHuman._IsInitDefault then
		CardHuman.DefaultShowPropertNames = { }
		local _tb = ConfigManager._GetConfigTable(EConfigIndex.t_property_show)
		if _tb then
			for k, v in spairs(_tb) do
				if v.is_show == 1 then
					for ek, ev in pairs(ENUM.EHeroAttribute) do
						if ev == v.property_id then
							CardHuman.DefaultShowPropertNames[v.id] = ek
						end
					end
				end
			end
		end


		CardHuman._IsInitDefault = true
	end
end

function CardHuman.GetDefaultSHowPropertyNames()
	if not CardHuman.DefaultShowPropertNames then
		CardHuman._InitDefaultShowPropertypNames()
	end
	-- app.log("#dddd#"..table.tostring(CardHuman.DefaultShowPropertNames))
	return CardHuman.DefaultShowPropertNames
end





function CardHuman:Init(data)
	if not data.not_init_data then
		self:initData(data);
	end
end

function CardHuman:initData(data)
    self.__initData = data
    self.oldLevel = self.level or math.max(1, data.level or 1);
    self.oldExp = self.cur_exp or data.cur_exp or 0;
    self.oldNumber = self.number or data.number;
    self.oldSouls = self.souls or data.souls or 0;
    self.oldNeidan_level = self.neidan_level or data.neidan_level or 0;
    self.oldFight_value = self.fight_value or 0
    self.fight_value = data.fight_value or 0
    self.bindfunc = { };
    self.index = data.dataid or 0;
    -- 唯一编号
    self.number = data.number;
    -- 编号
    self.level = math.max(1, data.level or 1);
    -- 等级
    self.cur_exp = data.cur_exp or 999999;
    -- 当前经验
    self.souls = data.souls or 999999;
    -- 拥有英魂数
    self.need_cal_fight_value = true
    self.isNotCalProperty = data.isNotCalProperty
    -- app.log("hero id="..self.number.." oldLevel="..self.oldLevel.." oldExp="..self.oldExp.." level="..self.level.." exp="..self.cur_exp);
    self.lockType = data.lockType;
    self.hp_point = data.hp_point or 999999;
    self.phy_at_point = data.phy_at_point or 999999;
    self.energy_at_point = data.energy_at_point or 999999;
    self.phy_def_point = data.phy_def_point or 999999;
    self.energy_def_point = data.energy_def_point or 999999;
    self.neidan_level = data.neidan_level or 7;
    self.neidan_defense_level = data.neidan_defense_level or 7
    self.neidan_attack_level = data.neidan_attack_level or 7
    self.neidan_physical_level = data.neidan_physical_level or 7
    self.surplus_point = data.surplus_point or 999999;
    self.contact_hp_per = data.contact_hp_per or 999999;
    self.contact_attack_per = data.contact_attack_per or 999999;
    self.contact_def_per = data.contact_def_per or 999999;
    self.team_add = 0;
    self.dataSource = data.dataSource or g_dataCenter.package;
	self.trainingHallLevel = data.trainingHallLevel or 7;
	self.trainingHallLevelExp = data.trainingHallLevelExp or 7;
	
    self.restrain_valid = self:LoadRestrainValid(data.restrain);    --已生效的克制属性
    self.oldIllumstration_number = self.illumstration_number or data.illumstration_number or 0;  --老的卡片id
    self.illumstration_number = data.illumstration_number or 0;  --卡牌图鉴操作记录的number
    self.breakthrough1_level = data.breakthrough1_level or 0;	--新的突破功能的1阶段突破等级
    self.breakthrough1_cur_exp = data.breakthrough1_cur_exp or 0;	--新的突破功能的1阶段突破当前经验值
    self.breakthrough2_level = data.breakthrough2_level or 0;
    self.breakthrough2_cur_exp = data.breakthrough2_cur_exp or 0;
    self.breakthrough3_level = data.breakthrough3_level or 0;
    self.breakthrough3_cur_exp = data.breakthrough3_cur_exp or 0;
    self.breakthrough4_level = data.breakthrough4_level or 0;
    self.breakthrough4_cur_exp = data.breakthrough4_cur_exp or 0;
    self.breakthrough5_level = data.breakthrough5_level or 0;
    self.breakthrough5_cur_exp = data.breakthrough5_cur_exp or 0;
    self.breakthrough6_level = data.breakthrough6_level or 0;
    self.breakthrough6_cur_exp = data.breakthrough6_cur_exp or 0;
    --self.breakthrough1_level = 2;611778852496336898
    --self.breakthrough2_level = 1;
    -- 数据源  默认数据源玩家背包

	-- 装备
    self.equipment = { };
	-- 装备达人等级
	self.equip_expert_normal_rarity_level = data.equip_expert_normal_rarity_level or 100;
	self.equip_expert_exclusive_rarity_level = data.equip_expert_exclusive_rarity_level or 100;
	self.equip_expert_normal_star_level = data.equip_expert_normal_star_level or 100;
	self.equip_expert_exclusive_star_level = data.equip_expert_exclusive_star_level or 100;

    self.learn_skill = data.skill_info
    self.learn_passivity_property = data.passivity_property_info
    self.halo_level = data.halo_level
    if data.property then
        if #data.property > 0 then
            self.property = {}
        else
            if self.property == nil then
                self.property = {}
            end
        end
        self.isNotCalProperty = true
        for i=1, #data.property do
            self.property[ENUM.min_property_id+i] = data.property[i]
        end
    else
         self.property = {}
    end
    self.play_method_cur_hp = {}
    if data.play_method_hp then
        for i=1, #data.play_method_hp do
            self.play_method_cur_hp[data.play_method_hp[i].type] = data.play_method_hp[i].hp
        end
    end
    self.count = 1;
    -- 装备和角色不能叠加  数量为1
    for i = 1, ENUM.EEquipPosition.Max do
        if data.equip then
            self.equipment[i] = data.equip[i] or 0;
        else
            self.equipment[i] = 0;
        end
    end
    if PropsEnum.IsRole(self.number) then
        --app.log("IsRole");
		self.config = ConfigHelper.GetRole(self.number)
    elseif PropsEnum.IsMonster(self.number) then
        --app.log("IsMonster");
		self.config = ConfigManager.Get(EConfigIndex.t_monster_property,self.number);
    elseif PropsEnum.IsNPC(self.number) then
        --app.log("IsNPC");
		self.config = ConfigManager.Get(EConfigIndex.t_npc,self.number);
    elseif PropsEnum.IsMMONPC(self.number) then
        --app.log("IsMMONPC");
        self.config = ConfigManager.Get(EConfigIndex.t_npc_data,self.number);
        self.config.max_hp = 9999
    end
    local config = self.config;
    if config then
        self.level = self.level or self.config.level;
        self.level = self.level or 1;
        self.type = config.type or ENUM.EMonsterType.Empty;
        self.view_radius = config.view_radius or 0;
        self.act_radius = config.act_radius or 0;
        self.ai = config.ai or 0;
        self.name = config.name or "";
        self.model_id = config.model_id or 0;
        self.small_icon = config.small_icon or "";
        self.icon300 = config.icon300 or "";
        self.head = config.head or 0;
        self.icon = config.icon or 0;
        self.sex = config.sex or ENUM.ESex.Boy;
        self.pro_type = config.pro_type or ENUM.EProType.Fang;
        self.attackType = config.attackType or ENUM.EAttackType.Melee;
        self.passive_buff_id = config.passive_buff_id or 0;
        self.passive_buff_lv = config.passive_buff_lv or 0;
        self.skill = { };
        for i = 1, ENUM.EOwnSkill.Max do
            self.skill[i] = config["skill" .. i] or 0;
        end
        self.default_rarity = config.default_rarity or 0;
        self.rarity = config.rarity or 1;
        self.restraint = config.restraint or ENUM.ERestraint.Empty;
        -- local restrainConfigName = 'gd_' .. tostring(config.restrain)
        -- self.restraintUpConfig = _G[restrainConfigName]

        -- if config.restrain ~= nil then
        --     local name = ConfigManager.SpliceIndexName(config.restrain)
        --     if name then
        --         self.restraintUpConfig = ConfigManager._GetConfigTable(name)
        --     end
        -- end

        self.jiban = { };
        for i = 1, ENUM.EJiBan.Max do
            self.jiban[i] = config["jiban" .. i] or 0;
        end
        self.describe = config.describe or "";
        self.bring_up = config.bring_up or "";
        self.star_up_number = config.star_up_number or 0;
        self.soul_count = config.soul_count or 0;
        self.get_soul = config.get_soul or 0;
        self.ccgType = config.ccg_type or ENUM.EHeroCcgType.CCG

        --升品
        self.realRarity = config.real_rarity
        self:CalProperty();
        self:UpdateFightValue()

        if self:IsLevelUp() then
            GNoticeGuideTip(Gt_Enum_Wait_Notice.Hero_LevelUp);
        end
        if self:IsIllumstration() then
            GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_BattleTeam_Illustrations);
            GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_BattleTeam_Illustrations_Main);
            GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_BattleTeam_Illustrations_CCG);
            GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_BattleTeam_Illustrations_SSG);
        end
    else
        app.log("英雄初始化数据失败，编号不对   number=" .. tostring(self.number) .. debug.traceback());
    end
end

function CardHuman:CloneWithNewNumber(number)
	local data = table.deepcopy(self.__initData)
	data.number = number
	return CardHuman:new(data)
end

function CardHuman:GetEquipmentCard(pos)
    return self.dataSource:find_card(ENUM.EPackageType.Equipment, self.equipment[pos])
end

-- 最终属性 
function CardHuman:CalProperty()
    self:CalBaseProperty();
    self:CalLevelProperty();
    if self.isNotCalProperty then
        return
    end
    self:CalAddProperty();
    self:CalNormalAttackProperty(self.property);
end

function CardHuman:GetProperty(team_id)
    if team_id == nil then
        return self.property 
    end
    local halo_property = nil
    if team_id then
        if g_dataCenter.player:IsTeam(self.index, team_id) then
            local halo_info = g_dataCenter.player:GetTeamHaloInfo(team_id)
            if halo_info then
                halo_property = halo_info.halo_property
            end
        end
    end
    if halo_property then
        local property = {}
        local self_halo_property = {}
        if self.halo_level and self.halo_level > 0 then
            local cfg_name = EConfigIndex["t_halo_property_"..self.config.default_rarity];
            if cfg_name then
                local skillLevelData = ConfigManager._GetConfigTable(cfg_name);
                if skillLevelData and skillLevelData[self.halo_level] then
                    for k, v in pairs(ENUM.EHeroAttribute) do
                        if skillLevelData[self.halo_level][k] then
                            self_halo_property[v] = skillLevelData[self.halo_level][k] 
                        end
                    end
                    
                end
            end
        end
        for k, v in pairs(ENUM.EHeroAttribute) do
            local a = self.property[v]
            a = a or 0
            local b = halo_property[v]
            b = b or 0
            local c = self_halo_property[v]
            c = c or 0
            if b-c > 0 then
                property[v] = a+b-c
            else
                property[v] = a
            end
        end
        return property
    else
        return self.property
    end
end
-- 基础属性
function CardHuman:CalBaseProperty()
	self.baseProperty = { }
	local config = self.config;
	if config then
		for k, v in pairs(ENUM.EHeroAttribute) do
			self:SetProperty(self.baseProperty, v, config[k]);
		end
        --[[if self.number == 30007514 then
            app.log("baseProperty="..table.tostring(self.baseProperty))
        end]]
	else
		app.log("英雄计算基础数据失败，编号不对   number=" .. tostring(self.number));
	end
end

function CardHuman:GetBaseProperty()
	return self.baseProperty
end

-- 等级属性
function CardHuman:CalLevelProperty()
	self.levelProperty = { }
    for k, v in pairs(ENUM.EHeroAttribute) do
        self:SetProperty(self.levelProperty, v, 0);
    end
	if not PropsEnum.IsRole(self.number) and not PropsEnum.IsMonster(self.number) then
		return
	end
	local config = CardHuman.GetLevelConfig(self.number, self.level, self.config);
	if config then
		for k, v in pairs(ENUM.EHeroAttribute) do
			self:SetProperty(self.levelProperty, v, config[k]);
		end
		self.upexp = config.upexp;
        --[[if self.number == 30007514 then
            app.log("levelProperty="..table.tostring(self.levelProperty))
        end]]
	else
		app.log_warning("英雄计算等级数据失败，等级不对 number = " .. self.number .. "  level=" .. tostring(self.level) .. "  " .. debug.traceback());
	end
end

function CardHuman:GetLevelProperty()
	return self.levelProperty
end

function CardHuman:GetEmptyEquipPos()
	local emptyPos = { }

	for i = 1, ENUM.EEquipPosition.Max do
		if self.equipment[i] == 0 or self.equipment[i] == '0' then
			table.insert(emptyPos, i)
		end
	end

	return emptyPos
end

-- 获取上一次经验比
function CardHuman:GetOldExpPro()
	local cf = CardHuman.GetLevelConfig(self.number, self.oldLevel, self.config);
	if cf then
		return tonumber(self.oldExp) / cf.upexp;
	else
		app.log("读取英雄等级配置出错     level=" .. tostring(self.oldLevel));
		return 0;
	end
end
-- 获取当前经验比
function CardHuman:GetExpPro()
	return self.cur_exp / self.upexp;
end
-- 计算最终普通攻击属性
function CardHuman:CalNormalAttackProperty(pro)
	if pro == nil then
		return
	end
	local atkPower = pro[ENUM.EHeroAttribute.atk_power] or 0;
	-- 计算1、2、3段
	if type(self.config.normal_attack) == "table" then
		local levelConfig = CardHuman.GetLevelConfig(self.number, self.level, self.config);
		local levelConfigPro = { 0, 0, 0 }
		-- 等级配置加成的普攻
		if levelConfig and type(levelConfig.normal_attack) == "table" then
			for k, v in ipairs(levelConfig.normal_attack) do
				levelConfigPro[k] = v.att + v.atk_coe * atkPower;
			end
		end
		-- 基础配置加成的普攻
		for k, v in ipairs(self.config.normal_attack) do
			local levelPro = levelConfigPro[k] or 0;
			local temp = v.att + v.atk_coe * atkPower;
			self:SetProperty(pro, ENUM.EHeroAttribute["normal_attack_" .. k], temp + levelPro);
		end
	end
end

local ERestraintDamagePlusProperty =
{
	[ENUM.ERestraint.Edge] = ENUM.EHeroAttribute.restraint1_damage_plus,
	[ENUM.ERestraint.Solid] = ENUM.EHeroAttribute.restraint2_damage_plus,
	[ENUM.ERestraint.Fast] = ENUM.EHeroAttribute.restraint3_damage_plus,
	[ENUM.ERestraint.Unusual] = ENUM.EHeroAttribute.restraint4_damage_plus,
}

local ERestraintDamageReduceProperty =
{
	[ENUM.ERestraint.Edge] = ENUM.EHeroAttribute.restraint1_damage_reduct,
	[ENUM.ERestraint.Solid] = ENUM.EHeroAttribute.restraint2_damage_reduct,
	[ENUM.ERestraint.Fast] = ENUM.EHeroAttribute.restraint3_damage_reduct,
	[ENUM.ERestraint.Unusual] = ENUM.EHeroAttribute.restraint4_damage_reduct,
}

-- 计算所有的添加属性
function CardHuman:CalAddProperty()
    self.property = { };
    for k, v in pairs(ENUM.EHeroAttribute) do
        self:AddPropertyVal(self.property, v, self.baseProperty[v]);
        self:AddPropertyVal(self.property, v, self.levelProperty[v]);
    end
end

-- 获取等级配置
function CardHuman.GetLevelConfig(number, level, role_cfg)
	-- app.log(string.format("CardHuman.GetLevelConfig number=%s,level=%s,role_cfg=%s",tostring(number),tostring(level),table.tostring(role_cfg)))
	local cf = nil;
	if PropsEnum.IsRole(number) then
        if level > PublicStruct.Const.MAX_CARD_LEVEL then
            return nil
        end
		cf = ConfigHelper.CalcRoleLevelProperty(role_cfg, number, level);
	elseif PropsEnum.IsMonster(number) then
		if not role_cfg then
			role_cfg = ConfigManager.Get(EConfigIndex.t_monster_property, number);
		end
		cf = ConfigManager.Get(ConfigManager.SpliceIndexName(role_cfg.config), level);
	end
	if cf == nil then
		app.log("获取英雄等级配置出错 number=" .. tostring(number) .. " level=" .. tostring(level));
	end
	return cf;
end

-- 获取突破配置, 新功能修改配置需求
function CardHuman:GetBreakThrouhtConfig(stage, level)
	if stage > 0 and stage <= 6 and level > 0 then
	    local stageData = ConfigHelper.GetBreakthroughStageConfig( self.default_rarity, stage );
	    if stageData then
		for lvl, value in pairs( stageData ) do
		    if lvl == level then
			return value;
		    end
		end
		  return nil;
	    else
		  return nil;
	    end
	else
		-- app.log_warning("没有突破配置   "..tostring(self.number).."      "..tostring(level));
		return nil
	end
end

-- 返回上次经验跟最新经验的差值
function CardHuman:GetDiffHeroExp()
	local diffExp = 0;

	if self.oldLevel >= PublicStruct.Const.MAX_CARD_LEVEL then
		return diffExp
	end

	if self.level > self.oldLevel then
		local cf = CardHuman.GetLevelConfig(self.number, self.oldLevel, self.config);
		if cf then
			diffExp = cf.upexp - tonumber(self.oldExp);
			local oldLevel = self.oldLevel + 1;
			while oldLevel < self.level do
				cf = CardHuman.GetLevelConfig(self.number, oldLevel, self.config);
				if cf then
					diffExp = diffExp + cf.upexp;
				end
				oldLevel = oldLevel + 1;
			end
			diffExp = diffExp + tonumber(self.cur_exp);
		else
			app.log("获取英雄等级配置出错    level=" .. tostring(self.oldLevel) .. "  config=" .. table.tostring(self.config.level_config));
		end
	else
		diffExp = tonumber(self.cur_exp) - tonumber(self.oldExp);
	end
	return diffExp;
end
-- 得到上次等级跟这次等级是否等级有提升
function CardHuman:IsLevelUp()
	return self.oldLevel ~= self.level;
end
-- 图鉴是否改变
function CardHuman:IsIllumstration()
    return self.oldIllumstration_number ~= self.illumstration_number;
end
-- 英雄是否升星
function CardHuman:IsStarUp()
	return self.number ~= self.oldNumber;
end

-- 英雄是否内胆等级提升
function CardHuman:IsNeidanUp()
	return self.neidan_level ~= self.oldNeidan_level;
end

-- 获取当前英雄英魂进度值
function CardHuman:GetSoulsProgress()
	local data = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_upgradeStarMaxLevel);
	if data == nil then
		return 0;
	else
		if self.rarity >= data.data then
			local neidanData = ConfigManager.Get(EConfigIndex.t_neidan, self.neidan_level);
			if neidanData == nil or neidanData.souls == 0 then
				return 0;
			else
				return self.souls / neidanData.souls;
			end
		else
			return self.souls / self.soul_count;
		end
	end
end

-- 穿装备
function CardHuman:ChangeEquip(equip_pos, equip_card_dataid)
	local old_equip = self.equipment[equip_pos];
	self.equipment[equip_pos] = equip_card_dataid;
	app.log(tostring(self.number) .. "(" .. self.index .. ")" .. "人物将装备" .. old_equip .. "替换为" .. equip_card_dataid);
	return old_equip;
end
-- 脱装备
function CardHuman:TakeOffEquip(equip_pos)
	local equip_id = self.equipment[equip_pos];
	self.equipment[equip_pos] = 0;
	return equip_id;
end
function CardHuman:TakeOffEquipByDataid(equip_dataid)
	for i = 1, ENUM.EEquipPosition.Max do
		if self.equipment[i] == equip_dataid then
			self.equipment[i] = 0;
		end
	end
--天赋改变的时候属性重算
end

-------------------------------属性相关操作--------------------------------------------
-- 设置属性值  property_type：ENUM.EHeroAttribute表中的值。可以用id，也可以用名字。
function CardHuman:SetProperty(property_table, property_type, newval)
	if type(property_type) == 'string' then
		property_type = ENUM.EHeroAttribute[property_type]
	end
	if not property_type then
		app.log('属性id获取失败    ' .. debug.traceback());
	end
	local maxval = self:GetPropertyMaxVal(property_type)
	local minval = self:GetPropertyMinVal(property_type)
	local last = property_table[property_type]
	-- 没有给值就付成最小值
	property_table[property_type] = newval or 0;

	if not property_table[property_type] or property_table[property_type] < minval then
		property_table[property_type] = minval;
	elseif property_table[property_type] > maxval then
		property_table[property_type] = maxval;
	end
end

function CardHuman:GetPropertyMaxVal(property_type)
	if type(property_type) == 'string' then
		property_type = ENUM.EHeroAttribute[property_type]
	end
	if not property_type then
		return
	end
		local config = ConfigManager.Get(EConfigIndex.t_absolute_property_max_min, property_type);
	if not config or not config.max then
		app.log('查询属性最大值错误！' .. tostring(property_type) .. "     堆栈=" .. debug.traceback())
	end
	return config.max;
end
function CardHuman:GetPropertyMinVal(property_type)
	if type(property_type) == 'string' then
		property_type = ENUM.EHeroAttribute[property_type]
	end
	if not property_type then
		return
	end
		local config = ConfigManager.Get(EConfigIndex.t_absolute_property_max_min, property_type);
	if not config or not config.min then
		app.log('查询属性最小值错误！' .. table.tostring(config) .. "     堆栈=" .. debug.traceback())
	end
	return config.min;
end

function CardHuman:GetPropertyVal(property_type, need_round)
    if need_round == nil then
        need_round = true
    end

	local p_name = property_type
	if type(property_type) == 'string' then
		property_type = ENUM.EHeroAttribute[property_type]
	end
	if not property_type then
		app.log('GetPropertyVal 有找不到的属性！ name=' .. tostring(p_name) .. " " .. debug.traceback())
		return -1
	end
	local maxval = self:GetPropertyMaxVal(property_type)
	local minval = self:GetPropertyMinVal(property_type)
    if not self.property[property_type] then
        self.property[property_type] = 0
    end
	if self.property[property_type] < minval then
		self.property[property_type] = minval;
	elseif self.property[property_type] > maxval then
		self.property[property_type] = maxval;
	end
	local value = self.property[property_type];
	if ENUM.EAttributeValueType[property_type] == 1 and need_round then
		value = PublicFunc.AttrInteger(self.property[property_type]);
	end
	return value;
end

function CardHuman:AddPropertyVal(property_table, property_type, addval)
	if type(property_type) == 'string' then
		property_type = ENUM.EHeroAttribute[property_type]
	end
	if not property_type then
		app.log('AddPropertyVal 有找不到的属性！' .. debug.traceback())
	end
	local minval = self:GetPropertyMinVal(property_type)
	local maxval = self:GetPropertyMaxVal(property_type)
    if not property_table[property_type] then
        property_table[property_type] = 0
    end
	
	if addval == nil then
		addval = 0;
	end
	property_table[property_type] = property_table[property_type] + addval
    if property_table[property_type] < minval then
        property_table[property_type] = minval;
    elseif property_table[property_type] > maxval then
		property_table[property_type] = maxval
	end
end
--更新战斗力
function CardHuman:UpdateFightValue()
    --[[if self.need_cal_fight_value then
        self.fight_value = 0
        for k, v in pairs(ENUM.EHeroAttribute) do
            if ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k] and self.property[v] then
                self.fight_value = self.fight_value + self.property[v] * ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k]
            end
        end
        if self.learn_skill then
            for k, v in pairs(self.learn_skill) do
                local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,v.id)
                if skillInfo and skillInfo[v.level] then
                    self.fight_value = self.fight_value + skillInfo[v.level].fight_value
                end
            end
        end
    end]]
end

-- 由外部数据计算战斗力
function CardHuman:UpdateFightValueByExData(data)
	local fight_value = 0
	if data.property then
		self.property = data.property
		for k, v in pairs(ENUM.EHeroAttribute) do
			if ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k] and self.property[v] then
				fight_value = fight_value + self.property[v] * ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k]
			end
		end
	end
	if data.learn_skill then
		self.learn_skill = data.learn_skill
		for k, v in pairs(self.learn_skill) do
			local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info,v.id)
			if skillInfo and skillInfo[v.level] then
				fight_value = fight_value + skillInfo[v.level].fight_value
			end
		end
	end
    if data.passivity_property_info then
        self.learn_passivity_property = data.passivity_property_info
    end
	self.fight_value = fight_value
end

-- 获取战斗力
function CardHuman:GetFightValue(team_id)
    --[[
    local add_fight_value = 0
    if team_id then
        if g_dataCenter.player:IsTeam(self.index, team_id) then
            local halo_info = g_dataCenter.player:GetTeamHaloInfo(team_id)
            if halo_info then
                add_fight_value = halo_info.halo_fight_value
            end
        end
    end
	return PublicFunc.AttrInteger(self.fight_value) + add_fight_value
    ]]
    return 999999
end

function CardHuman:GetOldFightValue()
    return self.oldFight_value
end

-- 计算装备战斗力
function CardHuman:_CalEquipFightValue(card)
    --[[
	if card == nil then
		return 0
	end

	local value = 0

	for k, v in pairs(ENUM.EHeroAttribute) do
		local proValue = card:GetPropertyVal(k)
		if ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k] and proValue then
			value = value + proValue * ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k]
		end
	end
	return value
    ]]
    return 999999
end

-- 获得更换装备时战斗力变化
function CardHuman:GetChangeEquipFightValueChange(newEquipDataid, pos)
	local newEquipCard = self.dataSource:find_card(ENUM.EPackageType.Equipment, newEquipDataid)
	local newEquipFightValue = self:_CalEquipFightValue(newEquipCard)

	local posEquip = self.dataSource:find_card(ENUM.EPackageType.Equipment, self.equipment[pos]);
	local oldEquipFightValue = self:_CalEquipFightValue(posEquip)


	return newEquipFightValue - oldEquipFightValue
end

-- 设置卡片锁定类型：见ENum.ELockType
function CardHuman:SetLockType(lockType)
	self.lockType = lockType;
end

 
-- 获取所有升星加成
function CardHuman:GetTargetStarAddition(target_rarity)
	-- 1、获取当前默认星级
	-- 2、获取目标星级
	-- 3、两个星级等级
	-- 4、计算属性差
	local target_star = target_rarity
	local default_star_number = CardHuman.GetDefaultRarityNumber(self.number)
	if not default_star_number then
		app.log("get default_rarity error:numebr=" .. tostring(self.number))
	end
	local default_role_cfg = ConfigHelper.GetRole(default_star_number)
	local target_star_cfg = nil
	local target_numer = default_star_number
	local vf = target_star - default_role_cfg.rarity
	if vf < 0 then
		app.log("目标星级必须大于默认星级")
		return { }
	end
	for i = 1, vf + 1 do
		local n_star_cfg = ConfigHelper.GetRole(target_numer)
		if n_star_cfg then
			if n_star_cfg.rarity == target_star then
				target_star_cfg = n_star_cfg
				break
			end
			target_numer = n_star_cfg.star_up_number
		else
			target_numer = nil
			break
		end
	end
	local defult_star_level_cfg = CardHuman.GetLevelConfig(default_star_number, self.level, default_role_cfg)
	-- default_role_cfg.config[self.level]
	local target_star_level_cfg = CardHuman.GetLevelConfig(target_numer, self.level, target_star_cfg)
	-- target_star_cfg.config[self.level]

	local property_diffs = { }
	for k, v in pairs({"max_hp","atk_power","def_power"}) do
		local curr_value = default_role_cfg[v] or defult_star_level_cfg[v]
		local next_value = target_star_cfg[v] or target_star_level_cfg[v]
		if curr_value and next_value then
			local diff_value = next_value - curr_value
			if diff_value > 0 then
				property_diffs[v] = diff_value
			end
		else
			-- app.log("xxxx no diff property ["..tostring(k).."]:c_number:" .. tostring(curr_star_number) .. "n_number：" .. next_star_number .. " p_name:" .. v)
		end
	end
    
	--    app.log("xxx property_diffs：" .. table.tostring(property_diffs))
	return property_diffs
end
 


-- 获取升星前后属性差值
function CardHuman:GetDiffStarUp()
	local curr_star_number = self.number
	local next_star_number = nil
	local level = self.level
	local curr_role_star_cfg = ConfigHelper.GetRole(curr_star_number)
	if not curr_role_star_cfg then
		app.log("GetDiffStarUp error:" .. tostring(curr_star_number))
		return nil
	end

	next_star_number = curr_role_star_cfg.star_up_number
	-- app.log("GetDiffStarUp:c_number:" .. tostring(curr_star_number) .. "n_number：" .. next_star_number)
	local next_role_star_cfg = ConfigHelper.GetRole(next_star_number)
	if not next_role_star_cfg then
		return nil
	end

	local curr_role_star_level_cfg = CardHuman.GetLevelConfig(curr_star_number, self.level)
	local next_role_star_level_cfg = CardHuman.GetLevelConfig(next_star_number, self.level)
    local pList = {"max_hp","atk_power","def_power"}
	local property_diffs = { }
	for k, v in pairs(pList) do
		local curr_value = curr_role_star_cfg[v] or curr_role_star_level_cfg[v]
		local next_value = next_role_star_cfg[v] or next_role_star_level_cfg[v]
		if curr_value and next_value then
			local diff_value = next_value - curr_value
			if diff_value > 0 then
				property_diffs[v] = diff_value
			end
		else
			-- app.log("xxxx no diff property ["..tostring(k).."]:c_number:" .. tostring(curr_star_number) .. "n_number：" .. next_star_number .. " p_name:" .. v)
		end
	end
 
	return property_diffs

end

function CardHuman:CanLevelUpAnyEquip()
	local role = g_dataCenter.package:find_card(1, self.index);
	if not role then
		return Gt_Enum_Wait_Notice.Invalid;
	end
    local noticeList = {}
	for k, v in pairs(self.equipment) do
        local result = self:CanLevelUpEquip(k)
		if result == Gt_Enum_Wait_Notice.Success then
			return Gt_Enum_Wait_Notice.Success;
		end
        if type(result) == "number" then
            noticeList[result] = 1;
        elseif type(result) == "table" then
            for k, v in pairs(result) do
                noticeList[k] = 1;
            end
        end
	end
	return noticeList;
end

function CardHuman:CanStarUpAnyEquip()
	local role = g_dataCenter.package:find_card(1, self.index);
	if not role then
		return Gt_Enum_Wait_Notice.Invalid;
	end
    local noticeList = {};
	for k, v in pairs(self.equipment) do
        local result = self:CanStarUpEquip(k)
        if result == Gt_Enum_Wait_Notice.Success then
            return Gt_Enum_Wait_Notice.Success;
        end
        if type(result) == "number" then
            noticeList[result] = 1;
        elseif type(result) == "table" then
            for k, v in pairs(result) do
                noticeList[k] = 1;
            end
        end
	end
	return noticeList;
end

function CardHuman:CanLevelUpEquip(pos)
	local v = self.equipment[pos];
	if tonumber(v) ~= 0 then
		local equip = self.dataSource:find_card(2, v);
		if equip then
            local result = {}
            local t1 = equip:CanLevelUp();
            if t1 == Gt_Enum_Wait_Notice.Success then
                return Gt_Enum_Wait_Notice.Success;
            end
            local t2 = equip:CanRarityUp();
            if t2 == Gt_Enum_Wait_Notice.Success then
                return Gt_Enum_Wait_Notice.Success;
            end
            result[t1] = 1;
            result[t2] = 1;
			return result;
		end
	end
	return Gt_Enum_Wait_Notice.Invalid;
end
function CardHuman:CanStarUpEquip(pos)
	local v = self.equipment[pos];
	if tonumber(v) ~= 0 then
		local equip = self.dataSource:find_card(2, v);
		if equip then
            return equip:CanStarUp();
		end
	end
	return Gt_Enum_Wait_Notice.Invalid;
end

--英雄可强化条件汇总
function CardHuman:CanPowerUp()
    return PublicFunc.ToBoolTip( self:CanStarUp() ) or 
            PublicFunc.ToBoolTip( self:CanRarityUp() ) or 
            PublicFunc.ToBoolTip( self:CanUpRestrain() ) or
            PublicFunc.ToBoolTip( self:CanSkillLevel() ) or 
            self:FormationCanLevelUp()
end

-- 英雄能技能升级
function CardHuman:CanSkillLevel()
    -- if g_dataCenter.player.skillPoint < 20 then
    --     return false;
    -- end
    self._skillStar,self._passiveSkillStar,self._haloSkill = PublicFunc.GetSkillOpenLearnInfo();
    local goldNum = g_dataCenter.player.gold;
    --  主动技能
    for i, v in ipairs(self.config.spe_skill) do
        if self.learn_skill == nil then
            return;
        end
        if self.learn_skill[i] ~= nil then
            local skill_id =self.learn_skill[i].id;
            local skill_lv = self.learn_skill[i].level;
            local can_level_up_star = self._skillStar[i].level_up;
            if can_level_up_star <= self.rarity
            and skill_lv < self.level then
                local _,skill_info = PublicFunc.GetSkillCfg(self.config.default_rarity, 0, skill_id);
                local lv_info = skill_info[skill_lv+1];
                if lv_info and lv_info.levelup_need_gold <= goldNum then
                    return Gt_Enum_Wait_Notice.Success;
                end
            end
        end
    end
    -- 被动技能
        --学习了的被动技能
    for k,learnSkill in ipairs(self.learn_passivity_property) do
        local cfg = ConfigManager.Get(EConfigIndex.t_role_passive_info,self.config.default_rarity);
        if cfg and cfg[learnSkill.id] then
            local skill_id = learnSkill.id;
            local skill_lv = learnSkill.level;
            local can_level_up_star = self._passiveSkillStar[skill_id].level_up;
            if can_level_up_star <= self.rarity
            and skill_lv < self.level then
                local _,skill_info = PublicFunc.GetSkillCfg(self.config.default_rarity, 1, skill_id);
                local lv_info = skill_info[skill_lv+1];
                if lv_info and lv_info.levelup_need_gold <= goldNum then
                    return Gt_Enum_Wait_Notice.Success;
                end
            end
        end
    end

    --  光环技能
    local cfg_name = EConfigIndex["t_halo_property_"..self.config.default_rarity];
    if cfg_name then
        local skillLevelData = ConfigManager._GetConfigTable(cfg_name);
        if skillLevelData then
            local skill_id = 1;
            local can_level_up_star = self._haloSkill;
            if can_level_up_star <= self.rarity 
            and self.halo_level and self.halo_level < self.level then
                local skill_lv = self.halo_level;
                local _,skill_info = PublicFunc.GetSkillCfg(self.config.default_rarity, 2, skill_id);
                local lv_info = skill_info[skill_lv+1];
                if lv_info and lv_info.levelup_need_gold <= goldNum then
                    return Gt_Enum_Wait_Notice.Success;
                end
            end
        end
    end
	return Gt_Enum_Wait_Notice.Gold;
end

function CardHuman:FormationCanLevelUp()
    local isFormation = g_dataCenter.player:IsTeam(self.index, ENUM.ETeamType.normal)
    if isFormation then
        return PublicFunc.ToBoolTip( self:CanLevelUp() )
    end
    return false
end

local __upExpId = {IdConfig.ExpMedi6, IdConfig.ExpMedi5, IdConfig.ExpMedi4, IdConfig.ExpMedi3, IdConfig.ExpMedi2, IdConfig.ExpMedi1}

--[[英雄能够升级]]
function CardHuman:CanLevelUp()
    if self.level >= g_dataCenter.player.level then
        return Gt_Enum_Wait_Notice.Player_Levelup
    end
	if self.level >= Const.MAX_CARD_LEVEL then
		return Gt_Enum_Wait_Notice.Invalid
	end
    local needExp = 0
    local config = CardHuman.GetLevelConfig(self.number, self.level, self.config);
	if config then
        needExp = config.upexp - self.cur_exp
	end
    if needExp <= 0 then
        return Gt_Enum_Wait_Notice.Invalid
    end

    local totalExp = 0
    for _, id in ipairs(__upExpId) do
        local itemConfig = ConfigManager.Get(EConfigIndex.t_item, id)
        if itemConfig then
            local count = PropsEnum.GetValue(id)
            totalExp = totalExp + itemConfig.exp * count
        end
        if totalExp >= needExp then
            return Gt_Enum_Wait_Notice.Success
        end
    end
    return Gt_Enum_Wait_Notice.Item_RoleLevelUp
end


-- 英雄能够升星判断
function CardHuman:CanStarUp()
	if self.rarity >= Const.HERO_MAX_STAR then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	if g_dataCenter.player.gold < self.config.star_up_gold then
		return Gt_Enum_Wait_Notice.Gold;
	end
	local need_id = PublicFunc.GetRoleIdByHeroNumber(self.config.default_rarity)
	local souls = g_dataCenter.player.package:find_count(ENUM.EPackageType.Item, need_id);
	local need = self.config.soul_count;
    if souls >= need then
        return Gt_Enum_Wait_Notice.Success;
    else
        return Gt_Enum_Wait_Notice.Item_HeroDebris;
    end
end

--[[英雄升品]]
function CardHuman:CanRarityUp()
	if self.realRarity == ENUM.EHeroRarity.Red1 then
        return Gt_Enum_Wait_Notice.Invalid;
    end
    if self.config.rarity_up_level > self.level then
        return Gt_Enum_Wait_Notice.Hero_LevelUp;
    end
    for k, v in pairs(self.config.rarity_up_material) do
        if v[2] > PropsEnum.GetValue(v[1]) then
            return Gt_Enum_Wait_Notice.Item_RoleRarity;
        end
    end
    if self.config.rarity_up_gold > PropsEnum.GetValue(IdConfig.Gold) then
        return Gt_Enum_Wait_Notice.Gold;
    end
    return Gt_Enum_Wait_Notice.Success;
end

--英雄克制是否能够提升
function CardHuman:CanUpRestrain()
    if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Restraint) then
        return Gt_Enum_Wait_Notice.Player_Levelup
    end

    local result, fun1_param, fun2_param = false, nil, nil

    local restrain_valid = self:GetRestrainValid()
    local restrainGroup = ConfigHelper.GetRestrainGroup(self.config.restrain)

    -- 升级消耗判定
    local canUpgradeFunc = function (id, level)
        local ret, cost_id = false, nil
        local config = ConfigHelper.GetRestrainConfig(self.config.restrain, id)
        if config then
            local enough = true
            for i, cost in pairs(PublicFunc.GetConfigDataValue(config[level+1].upgrade_cost)) do
                local id, num = next(cost)
                if PropsEnum.GetValue(id) < num then
                    enough = false
                    cost_id = id
                    break;
                end
            end
            if enough then ret = true; end
        end
        return ret, cost_id
    end

    -- 解锁条件判定
    local canUnlockFunc = function (config)
        local ret, need_type = true, 0
        local need_level, need_hero_qua = nil, nil
        for i, open_condition in pairs(PublicFunc.GetConfigDataValue(config.open_condition)) do
            if open_condition[1] then
                need_level = open_condition[1]
            elseif open_condition[2] then
                need_hero_qua = open_condition[2]
            end
        end

        if need_level and need_level > g_dataCenter.player.level then
            ret = false
            need_type = 1
        elseif need_hero_qua and need_hero_qua > self.config.real_rarity then
            ret = false
            need_type = 2
        end
        return ret, need_type
    end

    for i, groupData in ipairs(restrainGroup) do
        local unLockId = nil
        for j, data in pairs(groupData) do
            if restrain_valid[data] then
                unLockId = data
                break;
            end
        end
        -- 是否满足升级条件
        if unLockId then
            if restrain_valid[unLockId] < ConfigHelper.GetRestrainMaxLevel(self.config.restrain, unLockId) then
                result, fun1_param = canUpgradeFunc(unLockId, restrain_valid[unLockId])
            end 
        -- 是否满足解锁条件
        else
            local config = ConfigHelper.GetRestrainConfig(self.config.restrain, groupData[1])[1]
            result, fun2_param = canUnlockFunc(config)
        end

        if result then break; end
    end

    if result == false then
        if fun1_param ~= nil then
            return { [Gt_Enum_Wait_Notice.Gold] = 1, [Gt_Enum_Wait_Notice.Item_Restraint] = 1, }
        elseif fun2_param ~= nil then
            return { [Gt_Enum_Wait_Notice.Player_Levelup] = 1, [Gt_Enum_Wait_Notice.Hero_StarUp] = 1, }
        end
    end

    return Gt_Enum_Wait_Notice.Success
end

function CardHuman:GetHeroDefaultRarityCardInfo()
    local info = {}
    local allCard = self.dataSource:get_hero_card_table()
    for _, card in pairs(allCard) do
        info[card.default_rarity] = card
    end
    return info
end


function CardHuman:GetRestraint()
	return self.restraint
end

function CardHuman:LoadRestrainValid(data)
    local result = self.restrain_valid or {}
    table.clear_all(result)
    
    for i, _data in pairs(data or {}) do
        result[_data.id] = _data.level
    end
    return result
end

function CardHuman:GetRestrainValid()
	return self.restrain_valid
end

function CardHuman:UnlockRestrainValid(id)
    self.restrain_valid[id] = 0
end

function CardHuman:UpgradeRestrainValid(id)
	self.restrain_valid[id] = (self.restrain_valid[id] or 0) + 1
end

function CardHuman:ResetRestrainValid(id)
	if id == 0 then
        table.clear_all(self.restrain_valid)
	else
        self.restrain_valid[id] = nil
	end
end

--获取默认星级编号
--@param number 卡牌编号
--@return 默认卡牌编号
function CardHuman.GetDefaultRarityNumber(number)
    if not number then
        app.log("CardHuman.GetDefaultRarityNumber:parameter number is nil")
        return nil
    end
    local roleIndexCfg = ConfigManager.Get(EConfigIndex.t_role_index,number)
    if not roleIndexCfg then
        app.log("get role_index error:"..tostring(number))
        return nil
    end    
    return roleIndexCfg.default_rarity
end

function CardHuman:CanUpdateIllumstration()
	if self.illumstration_number == 0 then
		return Gt_Enum_Wait_Notice.Success;
	else
		if self.illumstration_number < self.rarity then
			return Gt_Enum_Wait_Notice.Success;
		else
			return Gt_Enum_Wait_Notice.Hero_RarityUp;
		end
	end
end

function CardHuman:CanUpdateIllumstrationState()
    if self.illumstration_number == 0 then
        return true;
    else
        if self.illumstration_number < self.rarity then
            return true;
        else
            return false;
        end
    end
end


--返回卡片在某玩法的当前血量，nil为满血， 
--type:见ENUM.RoleCardPlayMethodHPType
function CardHuman:GetPlayMethodCurHP(type)
    return self.play_method_cur_hp[type]
end

--设置卡片在某玩法的当前血量，满血状态下不要调此接口
--type:见ENUM.RoleCardPlayMethodHPType, 
--hp:当前血量
--update_server:是否同步到服务器,默认true
function CardHuman:SetPlayMethodCurHP(type, hp, update_server)
    if update_server == nil then
        update_server = true
    end
    self.play_method_cur_hp[type] = hp;
    if update_server and hp then
        msg_cards.cg_set_card_play_method_cur_hp(self.index, type, hp)
    end
end
--根据技能id获取技能等级
function CardHuman:GetSkillLevel(sType, id)
    if sType == ENUM.SkillType.passive then
        if self.learn_passivity_property then
            for k, v in pairs(self.learn_passivity_property) do
                if id == v.id then
                    return v.level;
                end
            end
        end
    elseif sType == ENUM.SkillType.halo then
        if self.halo_level ~= 0 and self.halo_level ~= nil then
            return self.halo_level;
        end
    else
        if self.learn_skill then
            for k, v in pairs(self.learn_skill) do
                if id == v.id then
                    return v.level;
                end
            end
        end
    end
    return 1;
end
