local property = 
{
	--oldLevel 上一次的等级状态 用于做客户端表现
	--index 唯一编号
	--number 编号
	--roleid 所属英雄id
	--level 等级
	--count 数量
	--name 名字
	--small_icon 小图标
	--icon 图标
	--price 出售价格
	--default_rarity 默认初始星级编号
	--star 当前星级
	--rarity 品质 参见ENUM.EEquipRarity
	--position 装备位置 参见ENUM.EEquipPosition
	--property = {} 拥有属性 参见ENUM.EHeroAttribute
	--describe 描述
	--star_up_number 升星后的编号
	--starup_material_id 升星所需材料编号
	--starup_material_num  升星所需材料数量
	--starup_gold  升星所需金钱
	--starup_success_rate  升星成功率
	--starup_fail_concentration 升星失败返还集中度
	--starup_success_concentration 升星所需集中度
	--config 配置表
}

CardEquipment = Class("CardEquipment", nil, property)

function CardEquipment:Init(data)
	self:initData(data);
end

function CardEquipment:initData(data)
    self.__initData = data
	self.oldLevel = self.level or data.level or 1;
	self.oldNumber = self.number or data.number;
    self.oldRarity = self.rarity or data.rarity
	self.index = data.dataid or 0;				--唯一编号
	self.number = data.number;					--编号
	self.level = data.level or 1;				--等级
	self.roleid = data.roleid or 0;				--所属英雄id
	self.count = 1;								--装备和角色不能叠加  数量为1
	self.dataSource = data.dataSource or g_dataCenter.package;			--数据源  默认数据源玩家背包
    self.rarity = data.rarity or ENUM.EEquipRarity.White;
    --当前特殊装备exp
    self.exp = data.exp or 0

	self.config = ConfigManager.Get(EConfigIndex.t_equipment,self.number);
    self.rarityConfig = CardEquipment.GetRarityConfig(self.number, self.rarity, self.config)
    self.levelConfig = CardEquipment.GetLevelConfig(self.number, self.level, self.config)

	local config = self.config;
	if config and self.rarityConfig then
		self.name = self.rarityConfig.name 
		self.small_icon = self.rarityConfig.small_icon or "";
		--self.big_icon = rarityConfig.big_icon or "";
		self.icon = self.rarityConfig.icon or 0;
		self.star = config.star or 1;
		self.default_rarity = config.default_rarity or 0;
		--self.rarity = config.rarity or ENUM.EEquipRarity.White;
		self.position = config.position or ENUM.EEquipPosition.Empty;
		self.describe = config.describe or "";
		self.star_up_number = config.star_up_number or 0;
		--self.starup_material_id = config.starup_material_id or 0;
		--self.starup_material_num = config.starup_material_num or 0;
		--self.starup_gold = config.starup_gold or 0;
		--self.starup_success_rate = config.starup_success_rate or 0;
		--self.starup_fail_concentration = config.starup_fail_concentration or 0;
		--self.starup_success_concentration = config.starup_success_concentration or 0;
		--属性，读取配置表
		self:CalProperty();
	else
		app.log("装备初始化数据失败   number="..tostring(self.number).. '  ' .. tostring(self.config) .. "  debug="..debug.traceback());
	end
end

function CardEquipment:CloneWithNewNumberLevelRairty(number, level, rarity)
    number = number or self.number
    level = level or self.level
    rarity = rarity or self.rarity

    local data = table.copy(self.__initData)
    data.number = number
    data.level = level
    data.rarity = rarity

    return CardEquipment:new(data)
end

function CardEquipment:IsSpecEquip()
    return self.position == ENUM.EEquipPosition.Helmet or self.position == ENUM.EEquipPosition.Accessories
end

function CardEquipment.PlayerReachStarUpLevel()
	local needPlyerLevel = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_equip_star_up_unlock_player_level).data
	return g_dataCenter.player:GetLevel() >= needPlyerLevel
end

function CardEquipment:IsEquipLock(type)
	if type == "StarUp" then
		if not self.PlayerReachStarUpLevel() then
			return true
		end
		local id = nil
		if  self.position == ENUM.EEquipPosition.Helmet then
			id = MsgEnum.ediscrete_id.eDiscreteID_equip_star_up_helmet_unlock_player_level
		elseif self.position == ENUM.EEquipPosition.Accessories then
			id = MsgEnum.ediscrete_id.eDiscreteID_equip_star_up_accessories_unlock_player_level
		end

		local isLock = false
		if id ~= nil then
			local level = ConfigManager.Get(EConfigIndex.t_discrete, id).data
			isLock = g_dataCenter.player:GetLevel() < level
		end

		if isLock then
			return true
		end
	else
		local isLock, level = PublicFunc.IsSpecEquipLevelLock(self.position)
		return isLock
	end
    return false
end

local __equipMaterailNumber = {
    [ENUM.EEquipPosition.Helmet] = 20000117,
    [ENUM.EEquipPosition.Accessories] = 20000120,
}
--[[特殊装备材料获取]]
function CardEquipment:GetSpecEquipMaterialNumber()
    return __equipMaterailNumber[self.position]
end

function CardEquipment:HasEquiped()
    return tostring(self.roleid) ~= '0'
end

--最终属性
function CardEquipment:CalProperty()
	self:CalBaseProperty();
	self:CalLevelProperty();
    self:CalRarityProperty();
	self:CalAddProperty();
end
--基础属性
function CardEquipment:CalBaseProperty()
	self.baseProperty = {}
	local config = self.config;
	if config then
		for k, v in pairs(ENUM.EHeroAttribute) do
            self:SetProperty(self.baseProperty, v, config[k]);
		end	
	else
		app.log("装备计算基础数据失败，编号不对   number="..tostring(self.number));
	end
end
--等级属性
function CardEquipment:CalLevelProperty()
	self.levelProperty = {}
	local config = self.levelConfig
	if config then
		for k, v in pairs(ENUM.EHeroAttribute) do
			self:SetProperty(self.levelProperty, v, config[k]);
		end	
		self.price = config.price;
	else
		app.log(debug.traceback());
		app.log_warning("装备计算等级数据失败，等级不对   level="..tostring(self.level));
	end
end

function CardEquipment:CalRarityProperty()
    self.rarityProperty = {}
    local config = self.rarityConfig
    if config then
        for k, v in pairs(ENUM.EHeroAttribute) do
			self:SetProperty(self.rarityProperty, v, config[k]);
		end	
    else
        app.log_warning("装备计算品质数据失败，品质不对   rarity="..tostring(self.rarity));
    end
end

--计算所有的添加属性
function CardEquipment:CalAddProperty()
	self.property = {};
	for k, v in pairs(ENUM.EHeroAttribute) do
		self:AddPropertyVal(v, self.baseProperty[v]);
		self:AddPropertyVal(v, self.levelProperty[v]);
        self:AddPropertyVal(v, self.rarityProperty[v]);
	end
end

--[[获取等级配置]]
function CardEquipment.GetLevelConfig(number, level, cfg)
    local equip_id = number
    if cfg then
        equip_id = cfg.id
    end
    --app.log('----GetLevelConfig --> ' .. table.tostring(ConfigHelper.GetEquipLevel(equip_id, level)))
    return ConfigHelper.GetEquipLevel(equip_id, level)
end

--[[获取最大等级]]
function CardEquipment.GetMaxLevel()
    return ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_equip_max_level).data
end

function CardEquipment.GetMaxRarity()
    return ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_equip_max_rarity).data
end

--[[获取品质配置]]
function CardEquipment.GetRarityConfig(number, rarity, cfg)
    local equip_id = number
    if cfg then
        equip_id = cfg.id
    end
    --app.log('----GetRarityConfig --> ' .. table.tostring(ConfigHelper.GetEquipRarity(equip_id, rarity)))
    return ConfigHelper.GetEquipRarity(equip_id, rarity)
end


function CardEquipment:SetHaveRole(role_dataid)
	app.log(tostring(self.number).."("..self.index..")".."装备将拥有者"..self.roleid.."替换为"..role_dataid);
	self.roleid = role_dataid;
end
-------------------------------属性相关操作--------------------------------------------
-- 设置属性值  property_type：ENUM.EHeroAttribute表中的值。可以用id，也可以用名字。
function CardEquipment:SetProperty(property_table, property_type, newval)

	if property_type == nil then
		return
	end

	if type(property_type) == 'userdata' then
		return
	end

	if type(property_type) == 'string' then
		property_type = ENUM.EHeroAttribute[property_type]
	end
	if not property_type then
		app.log('属性id获取失败    '..debug.traceback());
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

function CardEquipment:GetPropertyMaxVal(property_type)

	if property_type == nil then
		return
	end

	if type(property_type) == 'userdata' then
		return
	end

    if type(property_type) == 'string' then
        property_type = ENUM.EHeroAttribute[property_type]
    end
    if not property_type then
        return
    end
    local config = ConfigManager.Get(EConfigIndex.t_absolute_property_max_min,property_type);
    if not config or not config.max then
        app.log('查询属性最大值错误！' .. table.tostring(config).."     堆栈="..debug.traceback())
    end
    return config.max;
end

function CardEquipment:GetPropertyMinVal(property_type)

	if property_type == nil then
		return
	end

	if type(property_type) == 'userdata' then
		return
	end

    if type(property_type) == 'string' then
        property_type = ENUM.EHeroAttribute[property_type]
    end
    if not property_type then
        return
    end
    local config = ConfigManager.Get(EConfigIndex.t_absolute_property_max_min,property_type);
    if not config or not config.min then
        app.log('查询属性最小值错误！' .. table.tostring(config).."     堆栈="..debug.traceback())
    end
    return config.min;
end

function CardEquipment:GetPropertyVal(property_type)

    if property_type == nil then
        return
    end

    if type(property_type) == 'userdata' then
        return
    end

    -- 检查 self.property 是否为 nil，如果是，则初始化为一个空表
    if self.property == nil then
        self.property = {}
    end

    if type(property_type) == 'string' then
        property_type = ENUM.EHeroAttribute[property_type]
    end
    if not property_type then
        app.log_warning('GetPropertyVal 有找不到的属性！ '..debug.traceback())
        return
    end
    local maxval = self:GetPropertyMaxVal(property_type)
    local minval = self:GetPropertyMinVal(property_type)
    if not self.property[property_type] then
        self.property[property_type] = 0
    end
    if self.property[property_type] < minval then
        self.property[property_type] = minval
    elseif self.property[property_type] > maxval then
        self.property[property_type] = maxval
    end
    local value = self.property[property_type]
    -- 数值类型取整
    if ENUM.EAttributeValueType[property_type] == 1 then
        value = PublicFunc.Round(self.property[property_type])
    end
    return value
end


function CardEquipment:AddPropertyVal(property_type, addval)

	if property_type == nil then
		return
	end

	if type(property_type) == 'userdata' then
		return
	end

    if type(property_type) == 'string' then
        property_type = ENUM.EHeroAttribute[property_type]
    end
    if not property_type then
        app.log('AddPropertyVal 有找不到的属性！'..debug.traceback())
    end
    local minval = self:GetPropertyMinVal(property_type)
    local maxval = self:GetPropertyMaxVal(property_type)
    if not self.property[property_type] then
    	self.property[property_type] = 0
    end
    if addval == nil then
    	addval = 0;
    end
    self.property[property_type] = self.property[property_type] + addval
    if self.property[property_type] < minval then
        self.property[property_type] = minval;
    elseif self.property[property_type] > maxval then
        self.property[property_type] = maxval
    end
end

--根据等级获取装备的属性
function CardEquipment:GetPropertyByLevel(level)
	local property = {};
	local config = self.config;
	local level_config = CardEquipment.GetLevelConfig(self.number, level, config)
	if config and level_config then
		for k, v in pairs(ENUM.EHeroAttribute) do   --k是string，v是number
			if config[k] ~= nil then
				property[v] = config[k];
			else
				property[v] = 0;
			end
			
			if level_config[k] ~= nil then
				property[v] = property[v] + level_config[k];
			end
		end
	else
		app.log("装备计算等级数据失败，等级不对   level="..tostring(level));
		return nil;
	end
	
	return property;
end

function CardEquipment:GetGetDifferentOfTwoLevel(level1,level2)
	local property1 = self:GetPropertyByLevel(level1);
	local property2 = self:GetPropertyByLevel(level2);
	local diff = {};
	if property1 and property2 then
		for k, v in pairs(ENUM.EHeroAttribute) do
			if property1[v] ~= property2[v] then
				diff[v] = property2[v] - property1[v];
			end
		end
	end
	return diff;
end

function CardEquipment.GetAttrDiff(new_attr,old_attr)
    old_attr = old_attr or {};
    local table = {};
    for k,v in pairs(ENUM.EHeroAttribute) do
        if old_attr.property and old_attr.property[v] then
            table[v] = new_attr:GetPropertyVal(v) - old_attr:GetPropertyVal(v);
        else
            table[v] = new_attr:GetPropertyVal(v);
        end
    end
    return table;
end
function CardEquipment:GetPropertyDiff(cardInfo1,cardInfo2)
	local property1 = cardInfo1.property;
	local property2 = cardInfo2.property;
	local diff = {}
	local cnt = 0;
	local addProperty = {};
	local t = {};
	for k,v in pairs(gs_string_property_name) do
		table.insert(t,{k=k,v=v});
	end
	
	table.sort(t,function(a,b) return a.k<b.k end);
	for k,v in pairs(t) do
		if property1[v.k] ~= property2[v.k] then
			diff[v.k] = property2[v.k] - property1[v.k];
		else
			diff[v.k] = nil;
		end
	end
	
	for k,v in pairs(t) do
		if diff[v.k] then
			cnt = cnt + 1;
			addProperty[cnt] = {};
			addProperty[cnt].whole = property2[v.k] or 0;
			addProperty[cnt].diff = diff[v.k];
			addProperty[cnt].number = v.k;
			addProperty[cnt].name = v.v;
		end
	end
	
	for k,v in pairs(t) do
		if property1[v.k] ~= 0 and not diff[v.k] then
			cnt = cnt + 1;
			addProperty[cnt] = {};
			addProperty[cnt].whole = property2[v.k] or 0;
			addProperty[cnt].diff = 0;
			addProperty[cnt].number = v.k;
			addProperty[cnt].name = v.v;
		end
	end
	
	return addProperty;
end

--对属性按照表ConfigManager.Get(EConfigIndex.t_property_show进行排序,--对属性按照表gd_property_show进行排序)--对属性按照表gd_property_show进行排序
function CardEquipment:SortProperty(level)
	local property = {};
	if not level then
		property = self.property;
	else
		property = self:GetPropertyByLevel(level);
	end
	if not property then
		return {};
	end

	local t = {};
	local show_type = 1;
	local min = ConfigManager.Get(EConfigIndex.t_property_show.showType,show_type).minIndex;
	local cnt = 0;
	-- for i=min, #gd_property_show do
	for i=min, ConfigManager.GetDataCount(EConfigIndex.t_property_show) do
		if ConfigManager.Get(EConfigIndex.t_property_show,i).show_type ~= show_type then
			break;
		end
		cnt = cnt + 1;
		t[cnt] = {};
		t[cnt].key = ConfigManager.Get(EConfigIndex.t_property_show,i).property_id;
		t[cnt].value = property[t[cnt].key];
		t[cnt].showUnit = ConfigManager.Get(EConfigIndex.t_property_show,i).showUnit;
		local str = string.find(t[cnt].showUnit, "%",1,true);
		if str ~= nil then
			t[cnt].value = t[cnt].value * 100;
		end
	end
	return t;
end

--获取不等于0的属性
function CardEquipment:GetDeltaProperty()
	local cnt = 0;
	local t = self:SortProperty();
	local t_delta = {};
	for i=1,#t do
		if t[i].value ~= 0 then
			-- local str = string.find(t[i].showUnit, "%%");
			-- if str ~= nil then
			-- 	t[i].value = t[i].value * 100;
			-- end
			cnt = cnt + 1;
			t_delta[cnt] = t[i]
		end
	end
	return t_delta;
end

--获取2张卡片不同的属性，以及不等于0的属性
function CardEquipment:GetDiffProperty(cardInfo1,cardInfo2)
	local t1 = cardInfo1:SortProperty();
	local t2 = cardInfo2:SortProperty();
	local t_diff = {};
	local t_origin = {};
	local t_end = {};
	local cnt = 0;
	for i=1,#t1 do
		if t1[i].value ~= 0 or t1[i].value ~= t2[i].value then
			cnt = cnt + 1;
			t_origin[cnt] = t1[i];
			t_diff[cnt] = {};
			t_diff[cnt].key = t1[i].key;
			t_diff[cnt].showUnit = t1[i].showUnit;
			t_diff[cnt].value = t2[i].value - t1[i].value;
			t_end[cnt] = t2[i];
		end
	end
	return t_origin,t_end,t_diff;
end
--获取2张卡片不同的属性
function CardEquipment:GetDiffProperty2(cardInfo1,cardInfo2)
	local t_origin,t_end,t_diff = self:GetDiffProperty(cardInfo1,cardInfo2);
	local t = {};
	for i=1,#t_diff do
		if t_diff[i].value ~= 0 then
			table.insert(t,t_diff[i]);
		end
	end
	return t;
end

--获取2张卡片不同的属性
function CardEquipment:GetDiffProperty3(cardInfo1,cardInfo2)
	local t1 = cardInfo1:SortProperty();
	local t2 = cardInfo2:SortProperty();
	local t_diff = {};
	local t_origin = {};
	local t_end = {};
	local cnt = 0;
	for i=1,#t1 do
		if t1[i].value ~= t2[i].value then
			cnt = cnt + 1;
			t_origin[cnt] = t1[i];
			t_diff[cnt] = {};
			t_diff[cnt].key = t1[i].key;
			t_diff[cnt].showUnit = t1[i].showUnit;
			t_diff[cnt].value = t2[i].value - t1[i].value;
			t_end[cnt] = t2[i];
		end
	end
	return t_origin,t_end,t_diff;
end

function CardEquipment:GetDiffPropertyLevel(level1, level2)
	local t1 = self:SortProperty(level1);
	local t2 = self:SortProperty(level2);
	local t_diff = {};
	local t_origin = {};
	local t_end = {};
	local cnt = 0;
	for i=1,#t1 do
		if t1[i].value ~= 0 or t1[i].value ~= t2[i].value then
			cnt = cnt + 1;
			t_origin[cnt] = t1[i];
			t_diff[cnt] = {};
			t_diff[cnt].key = t1[i].key;
			t_diff[cnt].showUnit = t1[i].showUnit;
			t_diff[cnt].value = t2[i].value - t1[i].value;
			t_end[cnt] = t2[i];
		end
	end
	return t_origin,t_end,t_diff;
end

function CardEquipment:GetDiffPropertyLevel2(level1, level2)
	local t1 = self:SortProperty(level1);
	local t2 = self:SortProperty(level2);
	local t_diff = {};
	local t_origin = {};
	local t_end = {};
	local cnt = 0;
	for i=1,#t1 do
		if t1[i].value ~= t2[i].value then
			cnt = cnt + 1;
			t_origin[cnt] = t1[i];
			t_diff[cnt] = {};
			t_diff[cnt].key = t1[i].key;
			t_diff[cnt].showUnit = t1[i].showUnit;
			t_diff[cnt].value = t2[i].value - t1[i].value;
			t_end[cnt] = t2[i];
		end
	end
	return t_origin,t_end,t_diff;
end

function CardEquipment:GetSpecMaterialData()
    local category = nil
    if self.position == ENUM.EEquipPosition.Helmet then
        category = ENUM.EItemCategory.Helmet
    elseif self.position == ENUM.EEquipPosition.Accessories then
        category = ENUM.EItemCategory.Accessories
    end
    local cardData = {}
    local pkg = g_dataCenter.package:GetCard(ENUM.EPackageType.Item)
    for dataid, card in pairs(pkg) do
        if card.category == category then
            table.insert(cardData, card)
        end
    end    

    --先按星级排序
    table.sort(cardData, function(a, b) 
        return a.rarity < b.rarity
    end)  

    return cardData
end

function CardEquipment:__GetCalExp(data, needExp)
	local calExp = 0
	for _, v in ipairs(data) do
		local allExp = v.exp * v.count
		--全部消耗
		if allExp <= needExp - calExp then
			calExp = calExp + allExp
		--消耗一部分
		else
			for i = 1, v.count do
				calExp = calExp + v.exp
				if calExp >= needExp then
					return calExp
				end
			end
		end
		if calExp >= needExp then
			return calExp
		end
	end
	return calExp
end

--[[升级]]
function CardEquipment:CanLevelUp()
	if self:IsEquipLock() then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	local open_level = ConfigManager.Get(EConfigIndex.t_play_vs_data,62000006).open_level;
	if g_dataCenter.player:GetLevel() < open_level then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	local limitConfig = ConfigManager.Get(EConfigIndex.t_equipment_level_limit, g_dataCenter.player:GetLevel())
	if self.level == limitConfig.equip_max_level then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	if self.level >= CardEquipment.GetMaxLevel() then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	if self.level == self.rarityConfig.level then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	if self:IsSpecEquip() then
		--exp不足时，检查材料
		if self.exp < self.levelConfig.need_exp then
			local data = self:GetSpecMaterialData()
			if #data == 0 then
				return Gt_Enum_Wait_Notice.Item_EquipLevelUp
			else
				--检查exp及金币是否能升到下一级
				local config = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_equip_levelup_exp_cost_gold)
				local needExp = self.levelConfig.need_exp - self.exp
				local currGold = PropsEnum.GetValue(IdConfig.Gold)

				local calExp = self:__GetCalExp(data, needExp)
				local calGold = calExp * config.data

				if calExp >= needExp and currGold >= calGold then
					return Gt_Enum_Wait_Notice.Success
				else
					if calExp < needExp then
						return Gt_Enum_Wait_Notice.Item_EquipLevelUp
					end
					if currGold < calGold then
						return Gt_Enum_Wait_Notice.Gold
					end
				end
			end
		end
	else
		if self.levelConfig.cost_gold > PropsEnum.GetValue(IdConfig.Gold) then
			return Gt_Enum_Wait_Notice.Gold
		end
	end
	return Gt_Enum_Wait_Notice.Success
end

--[[升品]]
function CardEquipment:CanRarityUp()
	if self:IsEquipLock() then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	local open_level = ConfigManager.Get(EConfigIndex.t_play_vs_data,62000006).open_level;
	if g_dataCenter.player:GetLevel() < open_level then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	if self.level ~= self.rarityConfig.level then
		return Gt_Enum_Wait_Notice.Invalid;
	end

	if self.rarity >= CardEquipment.GetMaxRarity() then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	--等级达最高后， 不能升品
	if self.level >= CardEquipment.GetMaxLevel() then
		return Gt_Enum_Wait_Notice.Invalid;
	end

	if self:IsSpecEquip() then
		--检查二级货币
		local material = self.rarityConfig.material[1]
		local currCnt = PropsEnum.GetValue(material.number)
		if material.count > currCnt then
			return Gt_Enum_Wait_Notice.Item_EquipRarity;
		end
	else
		--检查材料
		for _, v in pairs(self.rarityConfig.material) do
			if v.count > PropsEnum.GetValue(v.number) then
				return Gt_Enum_Wait_Notice.Item_EquipRarity;
			end
		end
	end
	if self.rarityConfig.need_gold > PropsEnum.GetValue(IdConfig.Gold) then
		return Gt_Enum_Wait_Notice.Gold;
	end
	return Gt_Enum_Wait_Notice.Success;
end

function CardEquipment:CanStarUp()
	if self:IsEquipLock("StarUp") then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	local open_level = ConfigManager.Get(EConfigIndex.t_play_vs_data,62000006).open_level;
	if g_dataCenter.player:GetLevel() < open_level then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	local costGold = self.config.cost_gold or 0
	if costGold > PropsEnum.GetValue(IdConfig.Gold) then
		return Gt_Enum_Wait_Notice.Gold;
	end

	local starUpMaterial = self.config.starup_material

	if type(starUpMaterial) ~= 'table' then
		return Gt_Enum_Wait_Notice.Invalid;
	end

	for k,v in ipairs(starUpMaterial) do
		if v.count > PropsEnum.GetValue(v.number) then
			return Gt_Enum_Wait_Notice.Item_EquipStar;
		end
	end

	if tostring(self.config.star_up_number) == '0' then
		return Gt_Enum_Wait_Notice.Invalid;
	end

	return Gt_Enum_Wait_Notice.Success;
	--[[local equip = g_dataCenter.package:find_card(2,self.index);
	if not equip then
		return false;
	end
	if self.star >= 5 then
		return false;
	end
	if self.rarity < ENUM.EEquipRarity.Blue then
		return false;
	end
	local gold = g_dataCenter.player.gold;
	local star_up_need_gold = self.config.starup_gold;
	local item_id = self.config.starup_material_id;
	local item_need_num = self.config.starup_material_num;
	local jewel = self.dataSource:find_card_for_num(ENUM.EPackageType.Item,self.config.starup_material_id)
    local item_num = 0
    if jewel then
		item_num = jewel.count;
	else
		item_num = 0;
	end
	if item_num < item_need_num then
		return false;
	end
	if gold < star_up_need_gold then
		return false;
	end
    return true]]
end

--[[升星激活连协]]
function CardEquipment:IsActiveEquipContact()
    local cardHuman = self.dataSource:find_card(ENUM.EPackageType.Hero, self.roleid)
    local contactConfig = ConfigManager.Get(EConfigIndex.t_role_contact, cardHuman.default_rarity)
    if contactConfig == nil then
        return false
    end
    for _, v in pairs(contactConfig) do
        if v.contact_type == ENUM.ContactType.EquipProp or v.contact_type == ENUM.ContactType.EquipSkill then
            local equipConfig = ConfigManager.Get(EConfigIndex.t_equipment, v.equip_number)
            if equipConfig and self.position == equipConfig.position then
                --星级相等
                if self.star >= equipConfig.star then
                    return true
                end
                break
            end
        end
    end
    return false
end

--[[降星不激活连协]]
function CardEquipment:IsDeactiveEquipContact()
	local cardHuman = self.dataSource:find_card(ENUM.EPackageType.Hero, self.roleid)
	local contactConfig = ConfigManager.Get(EConfigIndex.t_role_contact, cardHuman.default_rarity)
	if contactConfig == nil then
		return false
	end
	for _, v in pairs(contactConfig) do
		if v.contact_type == ENUM.ContactType.EquipProp or v.contact_type == ENUM.ContactType.EquipSkill then
			local equipConfig = ConfigManager.Get(EConfigIndex.t_equipment, v.equip_number)
			if equipConfig and self.position == equipConfig.position then
				--星级已下降
				if self.star + 1 == equipConfig.star then
					return true
				end
				break
			end
		end
	end
	return false
end