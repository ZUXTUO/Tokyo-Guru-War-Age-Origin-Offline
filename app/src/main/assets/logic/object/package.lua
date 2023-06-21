Package = Class('Package');
--背包包含数据：英雄卡牌数据(CardHuman)  装备卡牌数据(CardEquipment)  道具数据(CardProp)
--注意：无可点使用的变量，全部使用接口访问，接口不足请添加



function Package:Init()
	self.list = {};
	--每个列表中卡的数量 用于做显示
	self.cont =
	{
	[ENUM.EPackageType.Hero] = 0,
	[ENUM.EPackageType.Equipment] = 0,
	[ENUM.EPackageType.Item] = 0,
	};
	-- 角色<CardHuman>
	self.list[ENUM.EPackageType.Hero] = {};
	-- 装备<CardEquipment>
	self.list[ENUM.EPackageType.Equipment] = {};
	-- 道具<CardPorp>
	self.list[ENUM.EPackageType.Item] = {};
	-- 满星英雄的数量
	self.manStarCount = 0;
	-- 背包数据是否初始化完成
	self.initDataFlag = false;
end

-----------------------------------------外部接口-------------------------------------
function Package:Foreach(list_id, func)
    for k, v in pairs(self.list[list_id]) do
        func(v);
    end
end
--返回某个背包类型的数量
--list_id 参见ENUM.EPackageType
function Package:GetCont(list_id)
	if list_id < ENUM.EPackageType.Hero or list_id > ENUM.EPackageType.Item then
		app.log("传入背包类型出错   list_id="..tostring(list_id).."    debug="..tostring(debug.traceback()));
	end
	return self.cont[list_id];
end
--返回某个背包类型中某个编号的数量
--list_id 参见ENUM.EPackageType
--number 具体编号
function Package:find_count(list_id, number)
	--[[
	local count = 0;
	for k, v in pairs(self.list[list_id]) do
		if v.number == number then
			if v.count then
				count = count + v.count;
			else
				count = count + 1;
			end
		end
	end
	--app.log("Package:find_count list_id="..tostring(list_id).." number="..tostring(number).. " count="..tostring(count))
	return count;
	]]
	return 999
end

--返某个编号的数量
function Package:GetCountByNumber(number)
	--[[
	--app.log("Package:GetCountByNumber number="..tostring(number))
	local list_id = nil
	if number and type(number) == type(0) then
		if PropsEnum.IsEquip(number) then
			list_id = ENUM.EPackageType.Equipment
		elseif PropsEnum.IsItem(number) or PropsEnum.IsVaria(number) then
			list_id = ENUM.EPackageType.Item
		elseif PropsEnum.IsRole(number) then
			list_id = ENUM.EPackageType.Hero
		else
			return 0
		end
		return self:find_count(list_id,number)
	end
	--app.log_warning("Package:GetCountByNumber number="..tostring(number))
	return 0
	]]
	return 999
end

--删除某个背包类型中的数据
--list_id 参见ENUM.EPackageType
--uuid 唯一id
--count 数量
function Package:DeletCard(list_id,uuid,count)
	local card = self:find_card(list_id,uuid)
	if card then
		if list_id == ENUM.EPackageType.Hero then
			--满星加一个数量
			local maxRarityLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_upgradeStarMaxLevel).data;
			if card.rarity == maxRarityLevel then
				self.manStarCount = self.manStarCount - 1;
			end
		end
		if count  and card.count then
			card.count = card.count - count;
			if card.count <= 0 then
				self.list[list_id][uuid] = nil;
				self.cont[list_id] = self.cont[list_id] - 1;
			end
		else
			self.list[list_id][uuid] = nil;
			self.cont[list_id] = self.cont[list_id] - 1;
		end
		
		self:DataChangeNotice(list_id, card)
	end
end
--根据唯一id查找某种道具
--list_id 参见ENUM.EPackageType
--uuid 唯一id
--返回值：根据类型返回CardHuman、CardEquipment、CardProp中的一种
function Package:find_card(list_id,uuid)
	return self.list[list_id][uuid];
end
--根据编号查找某种道具
--list_id 参见ENUM.EPackageType
--number 编号
--返回值：根据类型返回CardHuman、CardEquipment、CardProp中的一种
function Package:find_card_for_num(list_id,number)
	for k,v in pairs(self.list[list_id]) do
		if v.number == number then
			return v;
		end
		if list_id == ENUM.EPackageType.Hero and v.default_rarity == number then
			return v;
		end
	end
	return nil;
end
--根据编号查找某类道具的所有集合（用于查找指定的装备集合）
--list_id 参见ENUM.EPackageType
--number 编号
--返回值：根据类型返回CardHuman、CardEquipment、CardProp中的集合
function Package:find_card_table_for_num(list_id, number)
	local result = {};
	for k,v in pairs(self.list[list_id]) do
		if v.number == number then
			table.insert(result, v);
		end
	end
	return result;
end
--返回拥有英雄集合
--返回值：返回CardHuman的集合
function Package:get_hero_card_table()
	local result = {};
	for k,v in pairs(self.list[ENUM.EPackageType.Hero]) do
	--for k,v in pairs(ConfigHelper.GetRoleDefaultRarityTable()) do
		table.insert(result, v);
	end
	return result;
end
--获取某个背包类型列表
--list_id 参见ENUM.EPackageType
----返回值：根据类型返回CardHuman、CardEquipment、CardProp中的一种列表集合,k为唯一id,例：{[uuid]=CardHuman,[uuid]=CardHuman,[uuid]=CardHuman};
function Package:GetCard(list_id)
	return self.list[list_id];
end
--是否拥有指定英雄
-- 参数：default_cid（角色初始卡牌配置id） 或者 role_cid（角色卡牌配置id）
function Package:HavedHeroCard(default_cid, role_cid)
	--[[
	local result = false
	local default_cid = default_cid or ConfigHelper.GetRole(role_cid).default_rarity
	--for k,v in pairs(self.list[ENUM.EPackageType.Hero]) do
	for k,v in pairs(ConfigHelper.GetRoleDefaultRarityTable()) do
		if v.default_rarity == default_cid then
			result = true
			break;
		end
	end
	return result
	]]
	return true
end

--[[增加一张卡片
--list_id 参见ENUM.EPackageType
-- ]]
function Package:AddCard(list_id,card)
	if card then
		card.dataSource = self;
		if list_id == ENUM.EPackageType.Hero then
			card = CardHuman:new(card);
			--满星加一个数量
			local maxRarityLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_upgradeStarMaxLevel).data;
			local isMaxStar = false;
			if card.rarity == maxRarityLevel then
				self.manStarCount = self.manStarCount + 1;
				isMaxStar = true;
			end
			-- 游戏中获得的英雄检查关联属性
			self:CheckStarUp(card, isMaxStar);
		elseif list_id == ENUM.EPackageType.Equipment then
			card = CardEquipment:new(card);
		elseif list_id == ENUM.EPackageType.Item then
			card = CardProp:new(card);
		end
		self.list[list_id][card.index] = card;
		self.cont[list_id] = self.cont[list_id]+1;
		
		self:DataChangeNotice(list_id, card)
		return card
	end
end

function Package:AddCardInst(list_id, cardInst)
	self.list[list_id][cardInst.index] = cardInst;
	self.cont[list_id] = self.cont[list_id]+1;
end

--[[清空一个类型的所有物品
--list_id 参见ENUM.EPackageType
-- ]]
function Package:ClearPackage(list_id)
	self.list[list_id] = {};
	self.cont[list_id] = 0;
	if list_id == ENUM.EPackageType.Hero then
		self.manStarCount = 0;
		PublicStruct.Role_Cards_Index = 1
	end
end

--[[更新一张卡片
--list_id 参见ENUM.EPackageType
-- ]]
function Package:UpdateCard(list_id, dataid, card)
	--app.log(string.format("list_Id=%s,dataid=%s,card=%s,trackback=%s",tostring(list_id),tostring(dataid),table.tostring(card),debug.traceback()))
	if self.list[list_id][dataid] then
		local oldRarity = self.list[list_id][dataid].rarity
		local oldLevel = self.list[list_id][dataid].level
		self.list[list_id][dataid]:initData(card)
		-- 英雄升星
		if list_id == ENUM.EPackageType.Hero then
			if oldRarity == nil or oldRarity < self.list[list_id][dataid].rarity then
				--满星加一个数量
				local maxRarityLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_upgradeStarMaxLevel).data;
				if self.list[list_id][dataid].rarity == maxRarityLevel then
					self.manStarCount = self.manStarCount + 1;
					self:CheckStarUp(self.list[list_id][dataid], true)
				else
					self:CheckStarUp(self.list[list_id][dataid])
				end
			end
			
			if oldLevel < self.list[list_id][dataid].level then
				local heroList = g_dataCenter.fight_info:GetControlHeroList()
				for index,name in pairs(heroList) do
					local hero = ObjectManager.GetObjectByName(name)
					if hero then
						if self.list[list_id][dataid].default_rarity == hero:GetConfig('default_rarity') then
							app.log('HeroLevelUp ================ ' .. name)
							PublicFunc.msg_dispatch('HeroLevelUp', name)
							break
						end
					end
				end
			end
		end
		
		self:DataChangeNotice(list_id, card)
	end
end
--获取满星英雄的数量
function Package:GetManStarCount()
	return self.manStarCount;
end
--重新计算英雄属性
function Package:CalAllHeroProperty()
	for k, v in pairs(self.list[ENUM.EPackageType.Hero]) do
	--for k, v in pairs(ConfigHelper.GetRoleDefaultRarityTable()) do
		v:CalProperty();
	end
end

function Package:SetInitDataFlag(bool)
	self.initDataFlag = bool
end

-- 通知背包物品变化。这里统一通知
function Package:DataChangeNotice(list_id, card)
	if self ~= g_dataCenter.package then return end
	
	if list_id == ENUM.EPackageType.Item then
		NoticeManager.Notice(ENUM.NoticeType.CardItemChange, card.number)
	end
end

-- 英雄星级提升的关联属性检查
function Package:CheckStarUp(hero, maxStar)  
    ------------------------------------
    --老的连协功能,屏蔽掉
    ------------------------------------  
	--[[
    -- 检查背包数据加载之后的属性变化
	if not self.initDataFlag then return end
	
	-- 刚好开启英雄羁绊功能检查
	if maxStar then
				local openCondition = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_fettersOpenCondition).data;
		if openCondition == self.manStarCount then
			self:CalAllHeroProperty()
			return
		end
	end
	
	local default_rarity = hero.default_rarity
	---------------------------- 关联连协属性 -------------------------
	-- 连协英雄关联列表
	local initHeroList = {} -- 需要更新的英雄列表(初始编号)
	-- for initHero, fettersData in pairs(gd_fetters) do
	for initHero, fettersData in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_fetters)) do
		if default_rarity ~= initHero then
			for i, data in pairs(fettersData) do
				if data.fetters_id == default_rarity then
					table.insert(initHeroList, initHero);
					break;
				end
			end
		end
	end
	
	local heroSet = self:GetCard(ENUM.EPackageType.Hero);
	for i, initHero in pairs(initHeroList) do
		for k, v in pairs(heroSet) do
			-- 重新计算连协属性
			if v.default_rarity == initHero then
				v:ChangeFettersProperty()
			end
		end
	end
    ]]
end

--得到背包中的所有图样（配方）
function Package:GetAllRecipe()
	local item = self:GetCard(ENUM.EPackageType.Item);
	local recipe_list = {};
	for k,v in pairs(item) do
		local number = v.number;
				if ConfigManager.Get(EConfigIndex.t_casting_material,number) and g_get_item_casting(number) then
			table.insert(recipe_list,v);
		end
	end
	
	local sort_func = function(a,b)
		if a.rarity > b.rarity then
			return true;
		elseif a.rarity < b.rarity then
			return false
		end
				if ConfigManager.Get(EConfigIndex.t_item_casting,a.number).is_equip > g_get_item_casting(b.number).is_equip then
			return true;
					elseif ConfigManager.Get(EConfigIndex.t_item_casting,a.number).is_equip < g_get_item_casting(b.number).is_equip then
			return false;
		end
		
				if ConfigManager.Get(EConfigIndex.t_item_casting,a.number).type > g_get_item_casting(b.number).type then
			return true;
					elseif ConfigManager.Get(EConfigIndex.t_item_casting,a.number).type < g_get_item_casting(b.number).type then
			return false;
		end
		return false;
	end
	
	table.sort(recipe_list, sort_func);
	return recipe_list;
end

--根据位置和品质得到装备列表
--rarity：品质
--pos：位置
--remove_list：排除的列表uuid
function Package:GetEquipByRarityAndPos(rarity, pos, remove_list)
	if pos == 0 then pos = nil end
	local equip = self:GetCard(ENUM.EPackageType.Equipment);
	local equip_list_result = {};
	for k,v in pairs(equip) do
		local remove = false;
		if remove_list then
			for m,n in pairs(remove_list) do
				if n == v.index then
					remove = true;
					break;
				end
			end
		end
		if not remove then
			if rarity and pos then
				if v.rarity == rarity and v.position == pos then
					table.insert(equip_list_result, v);
				end
			elseif rarity and not pos then
				if v.rarity == rarity then
					table.insert(equip_list_result, v);
				end
			elseif not rarity and pos then
				if v.position == pos then
					table.insert(equip_list_result, v);
				end
			end
		end
	end
	return equip_list_result;
end


--获取所有道具数据
function Package:GetAllItemData()
    local result = {}
	if self.list then
        local func = function(t,a,b) 
        	if not t or not t[a] or not t[b] then
        		return false
        	end
			if t[a].sort_number == t[b].sort_number then
				return t[a].number < t[b].number
			else
				return t[a].sort_number > t[b].sort_number
			end              
        end

        for k,v in spairs(self.list[ENUM.EPackageType.Item],func) do
			table.insert(result, {key = k,value= v})
        end
	end
	return result
end

--获取除去package_category==0的所有道具
function Package:GetAllItemDataExceptZero()
	local result = {}
	local data = self:GetAllItemData()
	if data then
		for k,v in spairs(data) do
			--{key=v.key,value=v.value}
			if 0 ~= v.value.package_category then
				table.insert(result, v)
			end
		end
	end
	return result
end

--获取指定类型的道具
function Package:GetItemData(enumPackageItemCategory)
	local result = {}
	local data = self:GetAllItemData()
	if data then
		for k,v in spairs(data) do
			--{key=v.key,value=v.value}
			if enumPackageItemCategory == v.value.package_category then
				table.insert(result, v)
			end
		end
	end
	return result
end

function Package:GetItemCountByDataId(dataId)
     if  self.list[ENUM.EPackageType.Item] then
     	local data =	self.list[ENUM.EPackageType.Item][dataId]
     	if data then
     		return data.count
     	end
     end
     return 0
end
--fy:图鉴修改后的卡片数据提升
function Package:UpdateCardByIllumstration( listid, dataid, illumstration_number )
    --if self.list[list_id][dataid] and illumstration_number > 0 then
    --    self.list[list_id][dataid].illumstration_number = illumstration_number;
    --    self.list[list_id][dataid].illumAddHP, self.list[list_id][dataid].illumAddAtk, self.list[list_id][dataid].illumAddDef = PublicFunc.getIllumstrationValue( illumstration_number );
    --end
end
