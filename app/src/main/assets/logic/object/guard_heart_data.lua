GuardHeartData = Class('GuardHeartData')

g_guard_heart_max_pos_count = 5

g_guardHeartMutexTeam = 
{
    [ENUM.ETeamType.normal] = true,
    [ENUM.ETeamType.kuikuliya] = true,
    [ENUM.ETeamType.arena] = true,
    [ENUM.ETeamType.world_boss] = true,
    [ENUM.ETeamType.world_treasure_box] = true,

    [ENUM.ETeamType.guild_gaosujuji] = true,
    [ENUM.ETeamType.guild_Defend_war] = true,
    [ENUM.ETeamType.Clown_plan] = true,
}

EGuardHeartHeroPropIndex =
{
    Begin = 0,

    Hero = 0,
    Equip1 = 1,
    Equip2 = 2,
    Equip3 = 3,
    Equip4 = 4,
    Equip5 = 5,
    Equip6 = 6,

    Max = 6,
};

g_guardHeartUsedProperty = 
{
    max_hp = ENUM.EHeroAttribute.max_hp,
    atk_power = ENUM.EHeroAttribute.atk_power,    
    def_power = ENUM.EHeroAttribute.def_power,  
}

function GuardHeartData:Init()
    self.pos2PosData = {}
    self.pos2Property = {}
    self.hasBoughtPos = {}
    self.guardHeartHeroDataID = {}
end

function GuardHeartData:SetData(isAll, posDatas)
    if isAll then
        self.pos2PosData = {}
        self.guardHeartHeroDataID = {}
    end

    for k,v in ipairs(posDatas) do
        self:SetPositionData(v.pos, v)
    end
end

function GuardHeartData:RemovePosHero(poss)
    for k,v in ipairs(poss) do
        self:SetPositionData(v, nil)
    end
end

function GuardHeartData:SetPositionData(pos, data)
    self.pos2PosData[pos] = data
    self.pos2Property[pos] = nil
    self.totalProperty = nil
    self.baseTotalProperty = nil

    for k,v in pairs(self.guardHeartHeroDataID) do
        self.guardHeartHeroDataID[k] = nil
    end

    for k,v in pairs(self.pos2PosData) do
        self.guardHeartHeroDataID[v.heroDataID] = k
    end

    PublicFunc.msg_dispatch(GuardHeartMainUi.OnUpdatePosHero, pos)
end

function GuardHeartData:GetPosData(pos)
    return self.pos2PosData[pos]
end

function GuardHeartData:IsGuardHeartHero(dataid)
    return self.guardHeartHeroDataID[dataid] ~= nil
end

function GuardHeartData:GetHeroGuardPos(dataid)
    return self.guardHeartHeroDataID[dataid]
end

function GuardHeartData:GetProperty(pos)
    self:CalProperty(pos)
    return self.pos2Property[pos]
end

function GuardHeartData:GetTotalProperty()
    if self.totalProperty == nil then
        self.totalProperty = {}
        self:ResetProperty(self.totalProperty)

        for pos = 1, g_guard_heart_max_pos_count do
            local prop = self:GetProperty(pos)
            for k, v in pairs(g_guardHeartUsedProperty) do
                self.totalProperty[v] = self.totalProperty[v] + prop.total[v]
            end        
        end
    end
    
    return self.totalProperty
end

function GuardHeartData:GetBaseTotalProperty()
    if self.baseTotalProperty == nil then
        self.baseTotalProperty = {}
        self:ResetProperty(self.baseTotalProperty)

        for pos = 1, g_guard_heart_max_pos_count do
            local prop = self:GetProperty(pos)
            for k, v in pairs(g_guardHeartUsedProperty) do
                self.baseTotalProperty[v] = self.baseTotalProperty[v] + prop.base[v]
            end        
        end
    end
    
    return self.baseTotalProperty
end

function GuardHeartData:ResetProperty(prop)
    for k, v in pairs(g_guardHeartUsedProperty) do
		prop[v] = 0
	end
end

function GuardHeartData:CalPropertyFightValue(prop)
    local fightValue = 0
    local fvConfig = ConfigManager.Get(EConfigIndex.t_fight_value, 2)
    for k, v in pairs(g_guardHeartUsedProperty) do
        if fvConfig[k] and prop[v] then
            fightValue = fightValue + prop[v] * fvConfig[k]
        end
    end
    return fightValue
end

function GuardHeartData:GetCurrentUsedLevelRarityStar(pos, index)
    local propData, level, rarity, star = nil, 0, 0, 0

    local data = self:GetPosData(pos)

    if data then
        for k,v in ipairs(data.usedProps) do
            if v.index == index then
                propData = v;
                level = v.level
                rarity = v.rarity
                star = v.star
                break
            end
        end
    end

    return data, level, rarity, star
end

function GuardHeartData:GetPosExtraProperty(pos)
    local posConfig = ConfigManager.Get(EConfigIndex.t_guard_heart_type, pos)
    if posConfig == nil then
        app.log("guard herat pos config error " .. tostring(pos))
        return
    end

    local type, value
    if posConfig.max_hp > 0 then
        type = ENUM.EHeroAttribute.max_hp
        value = posConfig.max_hp
    elseif posConfig.atk_power > 0 then
        type = ENUM.EHeroAttribute.atk_power
        value = posConfig.atk_power
    elseif posConfig.def_power > 0 then
        type = ENUM.EHeroAttribute.def_power
        value = posConfig.def_power
    end
    return type, value
end

function GuardHeartData:GetActivePeroperty(extraData)

    local type, value

    for k,v in pairs(g_guardHeartUsedProperty) do
        if extraData[v] > 0 then
            type , value = v, extraData[v]
            break
        end
    end

    return type, value
end

function GuardHeartData:PosHeroTypeIsSame(cardInfo, posOrConfig)
    local posConfig = posOrConfig
    if type(posConfig) ~= 'table' then
        posConfig = ConfigManager.Get(EConfigIndex.t_guard_heart_type, posOrConfig)
    end
    if posConfig == nil then
        return false
    end

    local typeIsSame = false
    if posConfig.type >= 1 and posConfig.type <= 3 then
        if posConfig.type == cardInfo.pro_type then
            typeIsSame = true
        end
    elseif posConfig.type >= 4 or posConfig.type <= 5 then
        if cardInfo.sex == 0 or cardInfo.sex == posConfig.type - 3 then
            typeIsSame = true
        end
    else
        typeIsSame = false
        app.log("guard heart pos config type error ")
    end

    return typeIsSame;
end

function GuardHeartData:CalExtraProperty(pos)
    local data = self:GetPosData(pos)
    if not data then 
        return
    end
    local prop = self.pos2Property[pos].extra
    local heroDataID = data.heroDataID
    local cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, heroDataID)

    local posConfig = ConfigManager.Get(EConfigIndex.t_guard_heart_type, pos)
    if posConfig == nil then
        app.log("guard herat pos config error " .. tostring(pos))
        return
    end

    if self:PosHeroTypeIsSame(cardInfo, posConfig) then
        prop[ENUM.EHeroAttribute.max_hp] = posConfig.max_hp
        prop[ENUM.EHeroAttribute.atk_power] = posConfig.atk_power
        prop[ENUM.EHeroAttribute.def_power] = posConfig.def_power
    end
end

function GuardHeartData:CalProperty(pos)
    if self.pos2Property[pos] then return end

    local baseAndExtraProp = {base = {}, extra = {}, total = {}}
    self.pos2Property[pos] = baseAndExtraProp

    self:ResetProperty(baseAndExtraProp.base)
    self:ResetProperty(baseAndExtraProp.extra)
    self:ResetProperty(baseAndExtraProp.total)

    self:CalExtraProperty(pos)

    local prop = baseAndExtraProp.base
    local data = self:GetPosData(pos)
    if not data then 
        return
    end

    local heroDataID = data.heroDataID
    local cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, heroDataID)

    local propData, level, rarity, star = self:GetCurrentUsedLevelRarityStar(pos, EGuardHeartHeroPropIndex.Hero)    
    --app.log("#hyg# cal property 1 " .. table.tostring(prop))
    local defNumber = cardInfo.number - cardInfo.number%1000
    self:CalFatorProperty(EConfigIndex.t_guard_heart_hero_level, defNumber, level, prop)
    self:CalNormalProperty(EConfigIndex.t_guard_heart_hero_rarity, defNumber, "rarity", rarity, prop)
    self:CalNormalProperty(EConfigIndex.t_guard_heart_hero_star, defNumber, "star", star, prop)
    --app.log("#hyg# cal property 2 " .. table.tostring(prop))
    for eqipPos = EGuardHeartHeroPropIndex.Equip1, EGuardHeartHeroPropIndex.Equip6 do
        propData, level, rarity, star = self:GetCurrentUsedLevelRarityStar(pos, eqipPos)   
        if propData then
            self:CalFatorProperty(EConfigIndex.t_guard_heart_equip_level, defNumber, level, prop)
            self:CalNormalProperty(EConfigIndex.t_guard_heart_equip_rarity, defNumber, "rarity", rarity, prop)
            self:CalNormalProperty(EConfigIndex.t_guard_heart_equip_star, defNumber, "star", star, prop)
        else
            app.log("guard heart CalProperty date rror")
        end

        --app.log("#hyg# cal property equip " .. eqipPos .. ' ' .. table.tostring(prop))
    end
    

    for k, v in pairs(g_guardHeartUsedProperty) do
        baseAndExtraProp.total[v] = baseAndExtraProp.base[v] + baseAndExtraProp.extra[v]
    end

end

function GuardHeartData:CalFatorProperty(configIndex, defNumber, level, prop)
    
    local levelConfig = ConfigManager.Get(configIndex, defNumber)
    if levelConfig == nil then
        app.log("GuardHeartData:CalFatorProperty config error " .. tostring(configIndex) .. ' ' .. tostring(defNumber))
        return
    end

    local factorLevel = level - 1
    prop[ENUM.EHeroAttribute.max_hp] = prop[ENUM.EHeroAttribute.max_hp] + levelConfig.default_max_hp + levelConfig.max_hp_level_factor * factorLevel
    prop[ENUM.EHeroAttribute.atk_power] = prop[ENUM.EHeroAttribute.atk_power] + levelConfig.default_atk_power + levelConfig.atk_power_level_factor * factorLevel
    prop[ENUM.EHeroAttribute.def_power] = prop[ENUM.EHeroAttribute.def_power] + levelConfig.default_def_power + levelConfig.def_power_level_factor * factorLevel
end

function GuardHeartData:CalNormalProperty(configIndex, defNumber, colName, num, prop)
    local config = ConfigManager.Get(configIndex, defNumber)
    if config == nil then
        app.log("GuardHeartData:CalNormalProperty config error " .. tostring(configIndex) .. ' ' .. tostring(defNumber))
        return
    end

    local numConfig = nil
    for k,v in pairs(config) do
        if v[colName] == num then
            numConfig = v
            break;
        end
    end
    if numConfig == nil then
        app.log("GuardHeartData:CalNormalProperty detail item error " .. tostring(configIndex) .. ' ' .. tostring(defNumber) .. ' ' .. tostring(num))
        return
    end

    prop[ENUM.EHeroAttribute.max_hp] = prop[ENUM.EHeroAttribute.max_hp] + numConfig.max_hp
    prop[ENUM.EHeroAttribute.atk_power] = prop[ENUM.EHeroAttribute.atk_power] + numConfig.atk_power
    prop[ENUM.EHeroAttribute.def_power] = prop[ENUM.EHeroAttribute.def_power] + numConfig.def_power
end

function GuardHeartData:GetHeroProp(dataid, index)
    local level, rarity, star = nil, nil, nil
    local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, dataid)
    if card == nil then return end
    if index == EGuardHeartHeroPropIndex.Hero then
        level, rarity, star = card.level, card.realRarity, card.rarity
    elseif index >= EGuardHeartHeroPropIndex.Equip1 and index <= EGuardHeartHeroPropIndex.Equip6 then
        local equipCard = card:GetEquipmentCard(index)
        if equipCard then
            level, rarity, star = equipCard.level, equipCard.rarity, equipCard.star
        end
    end
    return level, rarity, star
end

function GuardHeartData:CanPromotion(pos)
    local data = self:GetPosData(pos)
    if data == nil then return false end

    for k,v in ipairs(data.usedProps) do
        local usedLevel, usedRarity, usedStar = v.level, v.rarity, v.star
        local newLevel, newRarity, newSatr = self:GetHeroProp(data.heroDataID, v.index)

        if newLevel == nil or newRarity == nil or newSatr == nil then
            return false
        end
        --[[
        app.log("#hyg#CanPromotion " .. pos .. ' ' .. v.index .. ' ' .. usedLevel .. ' ' .. usedRarity .. ' ' .. usedStar .. 
        '|' .. newLevel .. ' ' .. newRarity .. ' ' .. newSatr)]]
        if usedLevel ~= newLevel or usedRarity ~= newRarity or usedStar ~= newSatr then
            return true
        end
    end
    return false
end

function GuardHeartData:SetHasBoughtPos(poss)
    for k,v in ipairs(poss) do
        self.hasBoughtPos[v] = true
    end
end

function GuardHeartData:AddOneBoughtPos(pos)
    self.hasBoughtPos[pos] = true

    PublicFunc.msg_dispatch(GuardHeartMainUi.OnUpdatePosHero, pos)
end

function GuardHeartData:GetPosIsBought(pos)
    if self.hasBoughtPos[pos] then
        return true
    end
    return false
end

function GuardHeartData:GetAptitudeHeroNum(aptitude)
    local totalNum = 0
    local allHero = g_dataCenter.package:GetCard(ENUM.EPackageType.Hero)
    for name, card in pairs(allHero) do
        if card.config.aptitude >= aptitude then
            totalNum = totalNum + 1
        end
    end
    return totalNum
end

function GuardHeartData:LevelIsOpen(posConfig, pos)

    if posConfig.open_level ~= 0 then
        return g_dataCenter.player.level >= posConfig.open_level
    end

    return true
end

function GuardHeartData:HeroNumIsOpen(posConfig, pos)

    if type(posConfig.open_hero_num) == 'table' then
        local aptitude = posConfig.open_hero_num[1]
        local num = posConfig.open_hero_num[2]

        if aptitude and num then
            --app.log("HeroNumIsOpen " .. aptitude .. ' ' .. num .. ' ' .. self:GetAptitudeHeroNum(aptitude))
            return self:GetAptitudeHeroNum(aptitude) >= num
        else
            app.log("guard heart pos hero num open config error!")
            return false
        end
    end

    return true
end

function GuardHeartData:FightValueIsOpen(posConfig, pos)

    if posConfig.open_fight_vale ~= nil and posConfig.open_fight_vale ~= 0 then
        return g_dataCenter.player:GetHistoryFightValue() >= posConfig.open_fight_vale
    end

    return true
end

function GuardHeartData:CrystalIsOpen(posConfig, pos)

    if posConfig.open_crystal ~= 0 then
        if not self.hasBoughtPos[pos] then
            return false
        end
    end

    return true
end

function GuardHeartData:PosIsUnlock(pos)
    local posConfig = ConfigManager.Get(EConfigIndex.t_guard_heart_type, pos)
    if posConfig == nil then
        app.log("GuardHeartData:PosIsUnlock config error " .. tostring(pos))
        return false
    end
    
    local levelIsOpen = self:LevelIsOpen(posConfig, pos)
    if not levelIsOpen then return false end

    local heroNumIsOpen = self:HeroNumIsOpen(posConfig, pos)
    if not heroNumIsOpen then return false end

    local fvIsOpen = self:FightValueIsOpen(posConfig, pos)
    if not fvIsOpen then return false end

    local crystalIsOpen = self:CrystalIsOpen(posConfig, pos)
    if not crystalIsOpen then return false,posConfig.open_crystal end
    
    return true
end

function GuardHeartData:GetMutexTeamCaptain()
    local player = g_dataCenter.player
    local heros = {}
    for teamType,is in pairs(g_guardHeartMutexTeam) do

        local team = player.teams[teamType]
        if team then
            local dataid = team[1]
            if dataid then
                heros[dataid] = teamType
            end
        end

    end

    return heros
end

function GuardHeartData:IsMutexTeam(teamid)
    return g_guardHeartMutexTeam[teamid]
end