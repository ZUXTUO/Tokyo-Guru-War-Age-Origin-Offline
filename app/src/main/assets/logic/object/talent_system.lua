
TalentSystem = Class("TalentSystem")

function TalentSystem:Init()
    self.talentMap = {}
    self:InitData()
end

function TalentSystem:InitData()
    self.talentData = {}   
    self:ResetConsume()
    
    --self:SetTalentInfo({})
end

function TalentSystem:ResetConsume()
    --各天赋树消耗天赋点
    self.consumeTP = {}
    for _, v in pairs(ENUM.TalentTreeID) do
        self.consumeTP[v] = 0
    end
    --总消耗天赋点
    self.totalConsumeTP = 0
end

--[[当前树消耗]]
function TalentSystem:GetConsumeTP(treeId)
    return self.consumeTP[treeId]
end

--[[共消耗]]
function TalentSystem:GetTotalConsumeTP()
    return self.totalConsumeTP
end

--[[天赋图]]
function TalentSystem:GetTalentMap(treeId)
    --生成天赋树地图
    if self.talentMap[treeId] == nil then
        self.talentMap[treeId] = self:GetAllTalentMap(treeId)
    end
    return self.talentMap[treeId]
end

--[[已开启的天赋]]
function TalentSystem:SetTalentInfo(infos)
    for _,v in pairs(infos) do
        self.talentData[v.id] = v
    end
    --self.talentData[40000101] = {id = 40000101, level = 7}
    self:CalTalentProperty();
    self:CalculateConsume() 
end

--[[重置成功]]
function TalentSystem:ResetSuccess()    
    self:InitData()
    self:CalTalentProperty();
end

--[[天赋升级成功]]
function TalentSystem:TalentUpgradeSuccess(info)
    self.talentData[info.id] = info
    self:CalTalentProperty();
    local growConfig = self:GetGrowConfig(info.id)
    if growConfig ~= nil then
        local treeId = self:GetTreeId(info.id)
        self.consumeTP[treeId] = self.consumeTP[treeId] + growConfig[info.level - 1].talent_point
        self.totalConsumeTP = self.totalConsumeTP + growConfig[info.level - 1].talent_point
    end   
end

--[[计算消耗天赋点]]
function TalentSystem:CalculateConsume()
    self:ResetConsume()
    for _, v in pairs(self.talentData) do
        self:UpdateConsume(v)
    end
end

--[[更新消耗]]
function TalentSystem:UpdateConsume(info)
    local growConfig = self:GetGrowConfig(info.id)
    if growConfig ~= nil then
        local treeId = self:GetTreeId(info.id)
        for level = 0, info.level - 1 do
            self.consumeTP[treeId] = self.consumeTP[treeId] + growConfig[level].talent_point
            self.totalConsumeTP = self.totalConsumeTP + growConfig[level].talent_point
        end
    end
end

function TalentSystem:GetTreeId(talentId)
    return math.floor(talentId / 1000) * 1000
end

function TalentSystem:GetGrowConfig(talentId)
    local config = ConfigManager.Get(EConfigIndex.t_talent_info, talentId)
    local tName =  ConfigManager.SpliceIndexName(config.cf)
    return ConfigManager._GetConfigTable(tName)
end

--[[查询天赋树是否激活]]
function TalentSystem:TalentTreeActivated(treeId)
    local config = ConfigManager.Get(EConfigIndex.t_talent_tree, treeId)
    if config == nil then
        app.log("config error! treeId = " .. tostring(treeId))
        return false
    end
    --有上一条天赋树
    if config.last_id ~= 0 then
        --玩家等级
        if config.level > g_dataCenter.player.level then
            return false
        end
        --上一天赋树消耗的天赋点
        local point = self:GetConsumeTP(config.last_id)
        local needPoint = config.last_add
        if point < needPoint then
            return false
        end
    end 
    return true
end

--[[查询天赋是否激活]]
function TalentSystem:TalentActivated(talentId)
    return self.talentData[talentId] ~= nil
end

--[[查询天赋状态]]
function TalentSystem:GetTalentStatus(talentId)
    local talData = self.talentData[talentId] 
    local config = ConfigManager.Get(EConfigIndex.t_talent_info, talentId)
    --无数据
    if talData == nil then        
        local unlocked = false
        --达到解锁条件(战队等级及上一级天赋等级限制)
        if config.last_id ~= 0 then            
            if g_dataCenter.player.level >= config.level then
                local lastTalData = self.talentData[config.last_id] 
                if lastTalData and lastTalData.level >= config.last_level then
                    unlocked = true
                end
            end
        --根结点
        else
            --天赋树解锁，再判断等级
            local treeId = self:GetTreeId(talentId)
            if self:TalentTreeActivated(treeId) then
                if g_dataCenter.player.level >= config.level then
                    unlocked = true
                end
            end
        end
        if unlocked then
            --等级0
            self.talentData[talentId] = {id = talentId, level = 0}
            return ENUM.TalentStatus.Unlocked
        end
        return ENUM.TalentStatus.Lock
    end    
    if talData.level == config.max_level then
        return ENUM.TalentStatus.TopLevel
    elseif talData.level == 0 then
        return ENUM.TalentStatus.Unlocked
    else
        return ENUM.TalentStatus.LevelUp
    end
end

--[[得到所有天赋地图]]
--[[
    map = {
        [1] = {40000102,}
        [2] = {40000103,}
    }
]]
function TalentSystem:GetAllTalentMap(treeId)    
    local _rootId =  ConfigManager.Get(EConfigIndex.t_talent_tree, treeId).root_talent_id
    local _mapIds = {}
    --根
    local rootInfo = ConfigManager.Get(EConfigIndex.t_talent_info, _rootId)     
    local cnt = #rootInfo.next_id
    for k, talId in pairs(rootInfo.next_id) do
        _mapIds[k] = {talId}    
        --几条主线
        local talInfo = ConfigManager.Get(EConfigIndex.t_talent_info, talId)
        while talInfo.next_id ~= 0 do
            table.insert(_mapIds[k], talInfo.next_id)
            talInfo = ConfigManager.Get(EConfigIndex.t_talent_info, talInfo.next_id)
        end
    end  
    local mapInfo = {
        rootId = _rootId,
        mapIds = _mapIds,
    }
    --app.log("--->" .. table.tostring(mapInfo))
    return mapInfo
end

--[[得到天赋相关信息]]
function TalentSystem:GetTalentInfo(talentId)    
    local info = self:GetTalentBriefInfo(talentId)
    info.growConfig = self:GetGrowConfig(talentId)
    local config = ConfigManager.Get(EConfigIndex.t_talent_info, talentId)
    info.needPlayerLevel = config.level
    info.needLastLevel = config.last_level
    info.name = config.name
    info.descType = config.grow_desc_type
    --上一天赋信息
    if config.last_id ~= 0 then
        local lastConfig = ConfigManager.Get(EConfigIndex.t_talent_info, config.last_id)
        info.lastName = lastConfig.name
        info.lastLevel = 0        
        if self.talentData[config.last_id] then
            info.lastLevel = self.talentData[config.last_id].level
        end
        info.lastMaxLevel = lastConfig.max_level
    end
    return info
end

--[[得到天赋信息]]
function TalentSystem:GetTalentBriefInfo(talentId)    
    local info = {}    
    info.status = self:GetTalentStatus(talentId)
    if info.status ~= ENUM.TalentStatus.Lock then
        info.level = self.talentData[talentId].level        
    end
    local config = ConfigManager.Get(EConfigIndex.t_talent_info, talentId)
    info.maxLevel = config.max_level    
    info.icon = config.icon
    return info
end

--[[重置消耗的钻石]]
function TalentSystem:GetConsumeCrystal(point)    
    local config = ConfigManager.Get(EConfigIndex.t_talent_reset, point)
    if config == nil then
        --最后一项
        local cnt = ConfigManager.GetDataCount(EConfigIndex.t_talent_reset)
        config = ConfigManager.Get(EConfigIndex.t_talent_reset, cnt)
    end
    return config.crystal
end

--[[
    天赋树小红点
]]
function TalentSystem:IsShowTipOfTalentTree(treeId)
    --等级开启
    local level = ConfigManager.Get(EConfigIndex.t_play_vs_data, MsgEnum.eactivity_time.eActivityTime_TalentSystem).open_level
    if level > g_dataCenter.player.level then
        return Gt_Enum_Wait_Notice.Player_Levelup
    end

    local activated = self:TalentTreeActivated(treeId)
    if not activated then
        return Gt_Enum_Wait_Notice.Forced
    else
        local enoughGold = PropsEnum.GetValue(IdConfig.Gold) >= ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_talent_gold_show_red_point).data
        if not enoughGold then
            return Gt_Enum_Wait_Notice.Gold
        end
        local enoughTalentPoint = PropsEnum.GetValue(IdConfig.TalentPoint) >= ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_talent_point_show_red_point).data
        if not enoughTalentPoint then
            return  Gt_Enum_Wait_Notice.Item_Talent
        end
        if self:IsAllTalentTopLevel(treeId) then
            return  Gt_Enum_Wait_Notice.Invalid
        end
    end
    return Gt_Enum_Wait_Notice.Success
end

--[[全部满级]]
function TalentSystem:IsAllTalentTopLevel(treeId)
    local data = self:GetTalentMap(treeId)
    local status = self:GetTalentStatus(data.rootId)
    if status ~= ENUM.TalentStatus.TopLevel then
        return false
    end
    for k, v in pairs(data.mapIds) do
        for kk, vv in pairs(v) do
            local status = self:GetTalentStatus(vv)
            if status ~= ENUM.TalentStatus.TopLevel then
                return false
            end
        end
    end
    return true
end

function TalentSystem:GetLevelConfig(id, level)
    local infoCf = ConfigManager.Get(EConfigIndex.t_talent_info, id);
    if not infoCf then
        return;
    end
    return ConfigManager.Get(ConfigManager.SpliceIndexName(infoCf.cf), level);
end

--计算天赋属性
function TalentSystem:CalTalentProperty()
    self.talentProperty = {};
    for k, v in pairs(self.talentData) do
        if v.level > 0 then
            local infoCf = ConfigManager.Get(EConfigIndex.t_talent_info, k);
            local levelCf = self:GetLevelConfig(v.id, v.level);
            if infoCf and levelCf then
                self.talentProperty[infoCf.pro_type] = self.talentProperty[infoCf.pro_type] or {};
                for k, v in pairs(ENUM.EHeroAttribute) do
                    self.talentProperty[infoCf.pro_type][v] = self.talentProperty[infoCf.pro_type][v] or 0;
                    if levelCf[k] then
                        self.talentProperty[infoCf.pro_type][v] = self.talentProperty[infoCf.pro_type][v] + levelCf[k];
                    end
                end
            end
        end
    end
end

--获取天赋属性
function TalentSystem:GetTalentProperty(pro_type)
    local property = {};
    if self.talentProperty == nil then
        return property
    end
    --先加上对应职业的属性
    if pro_type ~= 0 and self.talentProperty[pro_type] then
        for k, v in pairs(ENUM.EHeroAttribute) do
            property[v] = property[v] or 0;
            if self.talentProperty[pro_type][v] then
                property[v] = property[v] + self.talentProperty[pro_type][v];
            end
        end
    end
    --再加上对所有人加成的属性
    for k, v in pairs(ENUM.EHeroAttribute) do
        property[v] = property[v] or 0;
        if  self.talentProperty[0] and self.talentProperty[0][v] then
            property[v] = property[v] + self.talentProperty[0][v];
        end
    end
    return property;
end