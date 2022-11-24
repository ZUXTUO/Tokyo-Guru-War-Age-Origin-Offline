
ShopInfo = Class("ShopInfo")

local _UIText = {
    [1] = "暂未开启"
}

function ShopInfo:Init()
    self.shopList = {}    
    for id = 1, ENUM.ShopID.MAX do
        self.shopList[id] = {isLoad = false, data = {}, refreshTime = 0, count = 0}
    end 
    self.requestShopData = false  
    self.isShow = false
end

--[[是否加载数据]]
function ShopInfo:IsLoadData(shopId) 
    return self.shopList[shopId].isLoad
end

--[[获取刷新时间]]
function ShopInfo:GetRefreshTime(shopId) 
    return self.shopList[shopId].refreshTime
end

function ShopInfo:SetRefreshTime(shopId, time) 
    self.shopList[shopId].refreshTime = time
end

function ShopInfo:IsRequestShopData()
    return self.requestShopData
end

function ShopInfo:SetRequestShopData(v)
    self.requestShopData = v
end

--[[获得items数量]]
function ShopInfo:GetShopItemCount(shopId) 
    return #self.shopList[shopId].data
end

--[[获得具体item]]
function ShopInfo:GetShopItemData(shopId, pos)
    return self.shopList[shopId].data[pos]
end

function ShopInfo:SetShowPopup(v)
    self.isShow = v
end

function ShopInfo:IsShowPopup()
    return self.isShow
end

--[[商店数据]]
--[[struct shop_Item_info
{
	int shop_item_id;
    int nItemCanBuyTimes;		//商品剩余可以购买次数
};]]
function ShopInfo:SetShopItems(shopId, refreshTime, items, count) 
    self.shopList[shopId].isLoad = true     
     --先清空数据
    self.shopList[shopId].data = {}
    self.shopList[shopId].refreshTime = 0
    --已刷新次数
    self.shopList[shopId].count = count

    local shopConfig = ConfigManager.Get(EConfigIndex.t_shop, shopId)
    --商店刷新时间    
    --if shopConfig.refresh_time ~= 0 then      
    --    self.shopList[shopId].refreshTime = tonumber(refreshTime)
    --end
    self:SetRefreshTime(shopId, refreshTime)

    local vip = 0
    if shopId == ENUM.ShopID.VIP then
        vip = self:GetShowVipLvl()
    end
    for k, v in ipairs(items) do
        local _shopItemConfig = ConfigManager.Get(EConfigIndex.t_shop_item, v.shop_item_id)
        if _shopItemConfig ~= nil then
            if shopId == ENUM.ShopID.VIP then
                if vip >= _shopItemConfig.vip_level then
                    table.insert(self.shopList[shopId].data, {itemConfig = _shopItemConfig, canBuyTimes = v.nItemCanBuyTimes})
                end
            else
                table.insert(self.shopList[shopId].data, {itemConfig = _shopItemConfig, canBuyTimes = v.nItemCanBuyTimes})
            end
        end
    end
end

--[[更新购买物品]]
function ShopInfo:UpdateShopItem(item) 
    local shopId = ConfigManager.Get(EConfigIndex.t_shop_item, item.shop_item_id).shop_id
    for k, v in pairs(self.shopList[shopId].data) do
        if item.shop_item_id == v.itemConfig.id then
            v.canBuyTimes = item.nItemCanBuyTimes
            break
        end
    end
end

--[[打开商店]]
function ShopInfo:OpenShop(shopID) 
    --uiManager:PushUi(EUI.GuildWarMapUI)
    if GuideManager.IsGuideRuning() and GuideManager.GetGuideFunctionId() > 0 then
        local function_id = GuideManager.GetGuideFunctionId()
        local eType = {
            [MsgEnum.eactivity_time.eActivityTime_Equip]        = ENUM.ShopID.EquipBox,
            [MsgEnum.eactivity_time.eActivityTime_ShopSundry]   = ENUM.ShopID.SUNDRY,
            [MsgEnum.eactivity_time.eActivityTime_ShopArena]    = ENUM.ShopID.ARENA,
            [MsgEnum.eactivity_time.eActivityTime_ThreeToThree] = ENUM.ShopID.ThreeToThree, 
            [MsgEnum.eactivity_time.eActivityTime_ShopFuzion]   = ENUM.ShopID.FUZION, 
            [MsgEnum.eactivity_time.eActivityTime_ShopKuikuliya] = ENUM.ShopID.KKLY, 
            [MsgEnum.eactivity_time.eActivityTime_ShopMystery]  = ENUM.ShopID.MYSTERY, 
            [MsgEnum.eactivity_time.eActivityTime_ShopGuild]    = ENUM.ShopID.Guild, 
            [MsgEnum.eactivity_time.eActivityTime_ShopTrial]    = ENUM.ShopID.Trial,
            [MsgEnum.eactivity_time.eActivityTime_ShopVip]    = ENUM.ShopID.VIP,
        }
        uiManager:PushUi(EUI.ShopUI, eType[function_id])

        -- 设置返回关卡界面不再弹窗神秘商店开启UI
        self:SetShowPopup(false)

        return
    end
    
    --默认
    if shopID == nil then
        local ret, id = self:IsSomeShopEnabled()
        if ret then
            uiManager:PushUi(EUI.ShopUI, id)
        end
    else
        if self:CheckShopIsEnabled(shopID) then
            uiManager:PushUi(EUI.ShopUI, shopID)
        else
            FloatTip.Float(_UIText[1])
        end 
    end
end

--[[某个商店是否可用]]
function ShopInfo:CheckShopIsEnabled(shopId)
    if shopId == ENUM.ShopID.EquipBox then
        return self:IsEquipBoxEnabled()
    end
    local shopConfig = ConfigManager.Get(EConfigIndex.t_shop, shopId)
    if shopConfig == nil then
        return false
    end   
    if shopId == ENUM.ShopID.MYSTERY then
        local upTime = self:GetRefreshTime(shopId)
        if upTime == 0 then
            return false
        else
            local durationTime = self:GetMysteryDurationTime()
            return upTime + durationTime > system.time() 
        end
    else
        local limit = shopConfig.open_limit    
        if limit == 0 or limit == '' then
            return false
        end
        --等级检查
        local open_level = limit[ENUM.ShopLimit.Level]
        local ret = false
        if open_level ~= nil then
            ret = g_dataCenter.player.level >= open_level
        end
        if ret then
            if shopId == ENUM.ShopID.VIP then
                ret = self:GetShopItemCount(ENUM.ShopID.VIP) > 0
            end
        end
        return ret
    end 
    return false
end

--[[是否有商店可用]]
function ShopInfo:IsSomeShopEnabled()
    if self:IsEquipBoxEnabled() then
        return true, ENUM.ShopID.EquipBox
    end
    local _shop = ConfigManager._GetConfigTable(EConfigIndex.t_shop)
    for k, v in ipairs(_shop) do
        if self:CheckShopIsEnabled(k) then
            return true, k
        end        
    end
    return false
end

function ShopInfo:IsEquipBoxEnabled()
    local config = ConfigManager.Get(EConfigIndex.t_play_vs_data, MsgEnum.eactivity_time.eActivityTime_Equip)
    if config and config.open_level <= g_dataCenter.player.level then
        return true
    end
    return false
end

function ShopInfo:GetMysteryDurationTime()
    return ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_mystery_shop_duration_time).data
end

function ShopInfo:GetShowVipLvl()
    local vip = g_dataCenter.player:GetVip()
    local addVip = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_shop_show_vip_add).data
    return vip + addVip
end

--[[购买货币]]
function ShopInfo:GetMoneyType(shopId)
    local config = ConfigManager.Get(EConfigIndex.t_shop, shopId)
    if config == nil or config.money_type == '' or  config.money_type == 0 then
        return nil
    end
    if type(config.money_type) == "table" then
        return config.money_type[1], config.money_type[2]
    else
        return config.money_type
    end
end

--[[购买货币 sprite name]]
local _spNameList = {
    [2] = "dh_jinbi",  
    [3] = "dh_hongshuijing",  
    [20000038] = "dh_zhanhun",
    [20000039] = "dh_qingtongyinbi",
    [20000040] = "dh_shengdian",    -- 已废弃
    [20000041] = "dh_jiangpai",
    [20000123] = "dh_jixiantiaozhandaibi",
    [20000125] = "dh_gongxian",
    [20000129] = "dh_zhanhun",

    [20000137] = "tuzi2",
    [20000138] = "tuzi1",
}
function ShopInfo:GetSpriteName(id)
    return _spNameList[id]
end

function ShopInfo:GetRefreshCnt(shopId) 
    return self.shopList[shopId].count
end

--[[次数上限(普通商店各vip等级配置相同， 神秘商店与vip相关]]
function ShopInfo:HaveRefreshCntLimit(shopId)  
    if not self:IsLoadData(shopId) then
        return true
    end  
    local vipConfig = g_dataCenter.player:GetVipData();
    local cntLimit = vipConfig.shop_refresh_times
    if cntLimit[shopId] ~= nil then
        local currCnt = self:GetRefreshCnt(shopId)
        if currCnt < cntLimit[shopId] then
            return false
        end
    else
        app.log("config error!")
    end
    return true
end

--[[刷新消耗钻石]]
function ShopInfo:GetShopRefreshCost(shopId)
    --第几次刷新
    local times = self:GetRefreshCnt(shopId) + 1
    local refresh_cost = ConfigManager.Get(EConfigIndex.t_shop, shopId).refresh_cost    
    if type(refresh_cost) ~= "table" then
        app.log("config error!")
        return nil
    end
    if times > #refresh_cost then
        times = #refresh_cost 
    end
    return refresh_cost[times]
end

function ShopInfo:GetSellItemData()
    local dataList = {}
    local canGetGold = 0
    local _config = ConfigManager._GetConfigTable(EConfigIndex.t_only_sell_item)
    if _config == nil then
       return dataList, canGetGold
    end
    for _, v in pairs(_config) do
        local count = PropsEnum.GetValue(v.item_id)
        if count > 0 then
            local itemConfig = ConfigManager.Get(EConfigIndex.t_item, v.item_id)
            table.insert(dataList, {
                id = v.id,
                item_id = v.item_id, 
                item_count = count, 
                rarity = itemConfig.rarity,
            })
            canGetGold = canGetGold + v.sell_price_num * count
        end
    end
    --按品质排序
    table.sort(dataList, function(a, b) 
        return a.rarity > b.rarity
    end)
    return dataList, canGetGold
end

function ShopInfo:GetFormationHeroRarityMaterial()
    local mt = {}
    local _teamInfo = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
	if not _teamInfo then
        return mt
    end
	for k, v in pairs(_teamInfo) do	
		local roleData = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, v)
		if roleData.realRarity ~= ENUM.EHeroRarity.Red1 then 
		    local config = ConfigHelper.GetRole(roleData.number)
            if config then
                for k, v in pairs(config.rarity_up_material) do 
                    local number, count = v[1], v[2]
                    if mt[number] then
                        mt[number] = mt[number] + count
                    else
                        mt[number] = count
                    end
                end
            end
        end 
	end
    return mt
end

function ShopInfo:IsItemSellOut(shopId, itemId)
    for k, v in pairs(self.shopList[shopId].data) do
        if itemId == v.itemConfig.id then
            return v.canBuyTimes == 0
        end
    end
    return true
end

function ShopInfo:IsShowSundryShopTip(rarityMaterial)
    local itemConfig = ConfigManager._GetConfigTable(EConfigIndex.t_shop_item)
    for _, v in pairs(itemConfig) do
        if v.shop_id == ENUM.ShopID.SUNDRY then
            if rarityMaterial[v.item_id] then
                if not self:IsItemSellOut(v.shop_id, v.id) then
                    return true
                end
            end
        end
    end
    return false
end


