Store = Class('Store')

function Store:Init()
	self.storeList = nil -- 充值商品列表
	self._localActiveFileName = 
	{
		[ENUM.Activity.activityType_welfare_box] = "welfare_box",
		[ENUM.Activity.activityType_limit_buy] = "store",
	};
	self.loaclSaveTime = {};
end

-- 删除一条商品
function Store:DeleleStoreData(index)
	if self.storeList then
		for i, data in ipairs(self.storeList) do
			if data.index == index then
				table.remove(self.storeList, i)
				break;
			end
		end
	end
end

-- 更新充值商品列表
function Store:SetStoreDataList(storeDataList)
	self.storeList = storeDataList or {}
end

-- 获取商品支付Id列表
function Store:GetPayDataList()
	local result = {}
	if self.storeList then
		for i, data in ipairs(self.storeList) do
			table.insert(result, data.index)
		end
	end
	return result
end

-- 获取充值商品列表
function Store:GetStoreList(isShowList)
	if isShowList then
		local result = {}
		for k, v in ipairs(self.storeList or {}) do
			if v.type ~= 3 then
				table.insert(result, v)
			end
		end
		return result;
	else
		return self.storeList or {}
	end
end

-- 先读取本地配置，再请求
function Store:RequestActive(id)
	self:ReadLocalActiveInfo(id);
	if id == ENUM.Activity.activityType_welfare_box then
		msg_activity.cg_welfare_treasure_box_get_config(self:GetSaveTime(id))
	elseif id == ENUM.Activity.activityType_limit_buy then
		msg_activity.cg_get_time_limit_gift_bag_config(self:GetSaveTime(id))
	end
end

-- 读取本地商品配置
function Store:ReadLocalActiveInfo(id)
	local file_handler = file.open(self._localActiveFileName[id],4);
	if not file_handler then
		return;
	end
	local str = file_handler:read_all_text()
	local fileInfo = loadstring(str)();
	file_handler:close();
	if fileInfo == nil then
		return;
	end
	if id == ENUM.Activity.activityType_welfare_box then
		self:ReadWelfareBoxCfg(fileInfo);
	elseif id == ENUM.Activity.activityType_limit_buy then
		self:ReadActiveCfg(fileInfo);
	end
end

-- 保存本地商品配置
function Store:SaveActiveInfo(id)
	local file_handler = file.open(self._localActiveFileName[id],2);
	if not file_handler then
		return;
	end

	local str = "";
	if id == ENUM.Activity.activityType_welfare_box then
		str = self:SaveWelfareBoxCfg();
	elseif id == ENUM.Activity.activityType_limit_buy then
		str = self:SaveActiveCfg();
	end

	file_handler:write_string(str);
	file_handler:close();
end

-- 获取本地商品记录时间
function Store:GetSaveTime(id)
	return self.loaclSaveTime[id] or 0;
end

------------------限时购活动-----------------------
function Store:SaveActiveCfg()
	local fileInfo = {};
	fileInfo.pageInfo = self.pageInfo or {};
	fileInfo.pageList = self.pageList or {};
	fileInfo.loaclSaveTime = self.loaclSaveTime[ENUM.Activity.activityType_limit_buy] or 0;
	return table.tostringEx(fileInfo);
end
function Store:ReadActiveCfg(fileInfo)
	if self.loaclSaveTime[ENUM.Activity.activityType_limit_buy] == fileInfo.loaclSaveTime then
		return;
	end
	self.loaclSaveTime[ENUM.Activity.activityType_limit_buy] = fileInfo.loaclSaveTime;
	self.pageInfo = fileInfo.pageInfo;
	self.pageList = fileInfo.pageList;
	self._goods = {};
	for k,page in pairs(self.pageList) do
		for k,goods in pairs(page) do
			self._goods[goods.id] = goods;
		end
	end
end
-- 更新商品配置信息
function Store:UpdateActiveList(tabPageInfo, goods)
	self.pageList = {};
	self.pageInfo = {};
	self._goods = {};
	for k,info in ipairs(tabPageInfo) do
		self.pageInfo[k] = info;
	end

	for k,info in ipairs(goods) do
		self.pageList[info.tabPageID] = self.pageList[info.tabPageID] or {};
		table.insert(self.pageList[info.tabPageID], info);
		self._goods[info.id] = info;
		self._goods[info.id].buyNum = 0;
	end
	self.loaclSaveTime[ENUM.Activity.activityType_limit_buy] = system.time();
	self:SaveActiveInfo(ENUM.Activity.activityType_limit_buy);
end

-- 获取分页列表信息
function Store:GetPageInfo(index)
	if type(self.pageInfo) ~= "table" then
		return nil;
	end
	return self.pageInfo[index];
end

-- 获取分页列表数量
function Store:GetPageInfoNum()
	if type(self.pageInfo) ~= "table" then
		return 0;
	end
	return #self.pageInfo;
end

-- 获取某页商品列表
function Store:GetGoodsList(page_id)
	if type(self.pageList) ~= "table" then
		return {};
	end
	local list = self.pageList[page_id];
	if list then
		return list;
	else
		return {};
	end
end

-- 更新单个商品已购买数量
function Store:UpdateState(goods_state)
	if type(self._goods) ~= "table" then
		return;
	end
	if type(goods_state) ~= "table" then
		return;
	end
	if self._goods[goods_state.id] then
		self._goods[goods_state.id].buyNum = goods_state.buyNum;
	end
end
-------------------------------------------------------

------------------福利宝箱活动-----------------------
-- 请求福利宝箱信息
function Store:ReadWelfareBoxCfg(fileInfo)
	if self.loaclSaveTime[ENUM.Activity.activityType_welfare_box] == fileInfo.loaclSaveTime then
		return;
	end
	self.loaclSaveTime[ENUM.Activity.activityType_welfare_box] = fileInfo.loaclSaveTime;
	self.WelfareBoxBoxList = fileInfo.boxList;
	self.WelfareBoxItemList = fileInfo.itemList;
	self.WelfareBoxBoxs = {};
	self.WelfareBoxItems = {};
	for k,v in pairs(self.WelfareBoxBoxList) do
		self.WelfareBoxBoxs[v.id] = v;
		self.WelfareBoxBoxs[v.id].buyNum = 0;
	end
	for k,v in pairs(self.WelfareBoxItemList) do
		self.WelfareBoxItems[v.id] = v;
		self.WelfareBoxItems[v.id].buyNum = 0;
	end
end

function Store:SaveWelfareBoxCfg()
	local fileInfo = {};
	fileInfo.loaclSaveTime = self.loaclSaveTime[ENUM.Activity.activityType_welfare_box] or 0;
	fileInfo.boxList = self.WelfareBoxBoxList;
	fileInfo.itemList = self.WelfareBoxItemList;
	return table.tostringEx(fileInfo);
end

-- 更新商品配置信息
function Store:UpdateWelfareBoxList(boxs, items)
	self.WelfareBoxBoxs = {};
	self.WelfareBoxItems = {};
	self.WelfareBoxBoxList = boxs;
	for k,v in pairs(boxs) do
		self.WelfareBoxBoxs[v.id] = v;
		self.WelfareBoxBoxs[v.id].buyNum = 0;
	end
	self.WelfareBoxItemList = items;
	for k,v in pairs(items) do
		self.WelfareBoxItems[v.id] = v;
		self.WelfareBoxItems[v.id].buyNum = 0;
	end
	self.loaclSaveTime[ENUM.Activity.activityType_welfare_box] = system.time();
	self:SaveActiveInfo(ENUM.Activity.activityType_welfare_box);
end

-- 更新宝箱状态
function Store:UpdateWelfareBoxBoxsState(state)
	self.WelfareBoxBoxs[state.high].buyNum = state.low;
end
function Store:UpdateWelfareBoxItemsState(state)
	self.WelfareBoxItems[state.high].buyNum = state.low;
end

-- 更新小红点状态
function Store:CheckWelfareBoxRedPoint()
	if self.WelfareBoxBoxs == nil then
		return;
	end
	for k,box in pairs(self.WelfareBoxBoxs) do
		if box.needScore <= self:GetWelfareBoxScore() and box.buyNum < 1 then
			g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_welfare_box, 1);
			return;
		end
	end
	g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_welfare_box, 0);
end

function Store:SetWelfareBoxScore(value)
	self.WelfareBoxScore = value;
end
function Store:GetWelfareBoxScore()
	return self.WelfareBoxScore or 0;
end
function Store:GetWelfareBoxItemList()
	return self.WelfareBoxItemList or {};
end
function Store:GetWelfareBoxBoxList()
	return self.WelfareBoxBoxList or {};
end

-------------------------------------------------------

return Store