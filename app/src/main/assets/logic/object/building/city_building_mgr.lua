

CityBuildingMgr = Class("CityBuildingMgr")

CityBuildingID = 
{
    teachingBuildID = 1000,
    diningRoomID = 2000,
    libraryID = 3000,
}

CityBuildingID2TeamId = 
{
    [CityBuildingID.teachingBuildID] = ENUM.ETeamType.city_building_teaching_build,
    [CityBuildingID.diningRoomID] = ENUM.ETeamType.city_building_dining_room,
    [CityBuildingID.libraryID] = ENUM.ETeamType.city_building_library,
}

BuildingID2SpriteName = {
        [CityBuildingID.teachingBuildID] = 'slg_changjing3',
        [CityBuildingID.diningRoomID] = 'slg_changjing5',
        [CityBuildingID.libraryID] = 'slg_changjing1',
    }

function CityBuildingMgr.GetInst()
    if CityBuildingMgr.__inst == nil then
        CityBuildingMgr.__inst = CityBuildingMgr:new()
    end
    return CityBuildingMgr.__inst
end

function CityBuildingMgr:Init()
    self.dc = g_dataCenter.cityBuildingData
    --self.buildingIDEntityMap = {}

    self.GAIN_SEP_TIME = 60

    self.log = true

    self:RegistFunc()

    self:MsgRegist()
end

function CityBuildingMgr:RegistFunc()
    self.bindfunc = {}
    self.bindfunc['OnTeamUpgrade'] = Utility.bind_callback(self, self.OnTeamUpgrade);
end

function CityBuildingMgr:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end

    self.bindfunc = {}
end

function CityBuildingMgr:MsgRegist()
    PublicFunc.msg_regist('TeamUpgrade', self.bindfunc['OnTeamUpgrade'])
end

function CityBuildingMgr:MsgUnRegist()
    PublicFunc.msg_unregist('TeamUpgrade', self.bindfunc['OnTeamUpgrade'])
end

function CityBuildingMgr:Finalize()
    self:MsgUnRegist()
    self:UnRegistFunc()
end

function CityBuildingMgr:Update(dt)

    CityRobberyMgr.GetInst():Update()

    local allBuilding = self:GetAllBuildingInfo()
    --app.log('CityBuildingMgr:Update ' .. table.tostring(allBuilding))

    if allBuilding ~= nil then
        for k,v in pairs(allBuilding) do
            if self:IsUpgrading(v.BuildingID) then
                if self:GetUpgradeRemainTime(v.BuildingID) <=0 and v.requestUpgradeEndTime == nil then

                    v.passUpgradeTime = v.passUpgradeTime or 0
                    v.passUpgradeTime = v.passUpgradeTime + dt
                    if v.passUpgradeTime > 1 then
                        v.requestUpgradeEndTime = 0
                        msg_city_building.cg_upgrade_building_end(v.BuildingID)
                    end
                elseif v.requestUpgradeEndTime ~= nil then
                    v.requestUpgradeEndTime = v.requestUpgradeEndTime + dt
                    if v.requestUpgradeEndTime >= 10 then
                        v.requestUpgradeEndTime = 0
                        msg_city_building.cg_upgrade_building_end(v.BuildingID)
                    end
                end
            end
        end
    end
end

function CityBuildingMgr:GetDC()
    return self.dc
end

--function CityBuildingMgr:AddBuildingEntity(modelid, entity)

--    local buildingConfig = self:GetBuildingConfig(modelid)
--    if buildingConfig == nil then
--        app.log('building config donnt config modelid:' .. tostring(modelid))
--        return
--    end

--    self.buildingIDEntityMap[buildingConfig.id] = entity
--end

--function CityBuildingMgr:GetBuildingEntity(buildingid)
--    return self.buildingIDEntityMap[buildingid]
--end


--function CityBuildingMgr:GetBuildingIDFromEntity(entity)
--    if entity == nil then
--        app.log('entity == nil ' .. debug.traceback())
--    end
--    local buildingConfig = self:GetBuildingConfig(entity:GetModelID())
--    return buildingConfig.id
--end

--function CityBuildingMgr:GetBuildingIDFromEntityName(entityName)
--    for k,v in pairs(self.buildingIDEntityMap) do
--        if v:GetName() == entityName then
--            return k
--        end
--    end

--    return nil
--end

function CityBuildingMgr:GetMinExpItemExp()

    local minExp = 100000000

    for k,item in ipairs(ConfigManager.Get(EConfigIndex.t_city_building_exp_item,1000)) do 
        local itemConfig = ConfigManager.Get(EConfigIndex.t_item,item.itemid)
        if itemConfig and itemConfig.exp < minExp then
            minExp = itemConfig.exp
        end
    end
    
    --app.log('xxxxxxxxx ' .. minExp)

    return minExp
end

function CityBuildingMgr:CheckIsShowHarvestTip(buildingid)
    --app.log('CheckIsShowHarvestTip')
    
    local bi = self.dc:GetBuildingInfo(buildingid)
    
    local isUpgrade = self:IsUpgrading(buildingid)
    
    if isUpgrade == true then
        return false
    end
    
    local curTime = system.time()

    if curTime - bi.lastGainTime > self.GAIN_SEP_TIME then
        local resource = self:GetBuildingResource(buildingid)
        if CityBuildingID.libraryID == buildingid then
            if resource < self:GetMinExpItemExp() then 
                -- exp to low, can not exchange exp item
                -- app.log('=============== ' .. tostring(self:GetMinExpItemExp()))
                return false
            else
                return true
            end
        else
            if resource < 1 then 
                return false
            else
                return true
             end
        end
    end
    return false
end

function CityBuildingMgr:GetHarvestRemainTime(buildingid)
    local bi = self.dc:GetBuildingInfo(buildingid)
    local isUpgrade = self:IsUpgrading(buildingid)
    if isUpgrade == true then
        return -1
    end

    local passTime = system.time() - bi.lastGainTime
    if passTime < 0 then
        app.log_warning('passTime < 0')
        passTime = 0
    end
    --app.log('x2 ' .. passTime)
    local remainTime = self.GAIN_SEP_TIME - passTime
    if remainTime < 0 then
        remainTime = 0 
    end
    return remainTime
end

--function CityBuildingMgr:SetGetTipUICalbak(calbak)
--    self._getTipUICallback = calbak
--end

function CityBuildingMgr:PlayerGainResource(buildingid, callback)

    msg_city_building.cg_player_gain_resource(buildingid)

    self._gainResourceCallback = callback

    self.loadingId = GLoading.Show(GLoading.EType.ui)
end

function CityBuildingMgr:PlayerGainResourceResult(ret, buildingid, gainItem)
    local bi = self.dc:GetBuildingInfo(buildingid)
    GLoading.Hide(GLoading.EType.ui, self.loadingId)
    local show = PublicFunc.GetErrorString(ret)
    if show then
--        if self._getTipUICallback ~= nil and _G[self._getTipUICallback] ~= nil then
--            local tipui = _G[self._getTipUICallback]()
--            local entity = self:GetBuildingEntity(buildingid)
--            if entity ~= nil then
--                tipui:DelIcon(entity:GetName())
--            end
--        end
        self.lastGainGetItem = gainItem
        if self._gainResourceCallback ~= nil and type(_G[self._gainResourceCallback]) == 'function' then
            _G[self._gainResourceCallback](buildingid, false)
        end

        --HintUI.SetAndShow(EHintUiType.zero, gs_misc['str_11'])
    else
        self.lastGainGetItem = nil
    end
end

function CityBuildingMgr:GetLastGainGetItem()
    return self.lastGainGetItem
end

function CityBuildingMgr:GetBuildingConfig(modeleID)
    local _building = ConfigManager._GetConfigTable(EConfigIndex.t_building)
    for k,v in pairs(_building) do
        if v.model_id == modeleID then
            return v
        end
    end
    app.log_warning('GetBuildingConfig return nil ' .. modeleID)
    return nil
end

function CityBuildingMgr:GetBuildingConfigFromID(bid)
    return ConfigManager.Get(EConfigIndex.t_building,bid)
end

function CityBuildingMgr:GetUpgradeConfig(buildID, level)
    local buildConfig = ConfigManager.Get(EConfigIndex.t_building_upgrade,buildID)
    for k,v in pairs(buildConfig) do
        if v.level == level then
            return v
        end
    end
    app.log_warning('GetUpgradeConfig return nil ' .. buildID)
    return nil
end

function CityBuildingMgr:IsUpgrading(buildID)
    local startTime = self.dc:GetBuildingUpgradeBeginTime(buildID)
    if startTime <= 0 then
        return false
    else
        return true
    end

--    local config = self:GetUpgradeConfig(buildID, level)
--    local currentTime = system.time()
--    if currentTime - startTime > config.upgrade_cost_time then
--        return false
--    else
--        return true
--    end
end

function CityBuildingMgr:GetUpgradeRemainTime(buildID)
    local startTime = self.dc:GetBuildingUpgradeBeginTime(buildID)
    if startTime <= 0 then
        return 0
    end

    local level = self.dc:GetBuildingLevel(buildID)
    local config = self:GetUpgradeConfig(buildID, level)
    local currentTime = system.time()
    local upgradeUseTime = currentTime - startTime
    if upgradeUseTime < config.upgrade_cost_time then
        return config.upgrade_cost_time - upgradeUseTime
    else
        return 0
    end
end

function CityBuildingMgr:GetMaxBuildingLevel(buildID)
    local buildConfig = ConfigManager.Get(EConfigIndex.t_building_upgrade,buildID)
    local maxLevel = 1
    for k,v in pairs(buildConfig) do
        if v.level > maxLevel then
            maxLevel = v.level
        end
    end
    return maxLevel
end

function CityBuildingMgr:GetBuildingLevel(buildingid)
    return self.dc:GetBuildingLevel(buildingid)
end

function CityBuildingMgr:GetMaxStorage(bid)
    local myLevel = self:GetBuildingLevel(bid)
    local config = self:GetUpgradeConfig(bid, myLevel)
    if config then
        return config.max_storage
    end
    return 0
end

function CityBuildingMgr:GetBuildingResource(buildingid)
    local bi = self.dc:GetBuildingInfo(buildingid)
    local myresource = bi.resource

    if self:IsUpgrading(buildingid) then
        return myresource
    end

    local myLevel = self.dc:GetBuildingLevel(buildingid)
    local config = self:GetUpgradeConfig(buildingid, myLevel)
    if myresource < config.max_storage then
        local curtime = system.time()
        local lastCalTime = bi.lastCalcResourceTime
        myresource = myresource + (curtime - lastCalTime)/3600 * config.production

        if myresource > config.max_storage then
            myresource = config.max_storage
        end
    end
    return myresource
end

function CityBuildingMgr:GetBuildingGuardHero(buildingid)
    local bi = self.dc:GetBuildingInfo(buildingid)
    return bi.guardHero
end

function CityBuildingMgr:LevelUp(buildingid, callback)
    local buildingConfig = ConfigManager.Get(EConfigIndex.t_building,buildingid)
    --app.log('x1 ' .. buildingConfig.id)
    if buildingConfig == nil then
        HintUI.SetAndShow(EHintUiType.zero, 'buildingConfig == nil')
        return
    end
    local myLevel = self.dc:GetBuildingLevel(buildingConfig.id)

    if myLevel >= self:GetMaxBuildingLevel(buildingConfig.id) then
        --app.log_warning('building id:' .. tostring(buildingConfig.id) .. 'have reach max level')
        HintUI.SetAndShow(EHintUiType.zero, string.format(gs_misc['building_reach_max_level'], buildingConfig.name))
        return 
    end

    if self:IsUpgrading(buildingConfig.id) then
        --app.log_warning('building is upgrading!')
        HintUI.SetAndShow(EHintUiType.zero, string.format(gs_misc['building_is_upgrading'], buildingConfig.name))
        return 
    end
    local config = self:GetUpgradeConfig(buildingConfig.id, myLevel)
    local myresource = self.dc:GetResource()
    if myresource < config.upgrade_cost_resource then
        --app.log_warning('resource is to poor')
        HintUI.SetAndShow(EHintUiType.zero, gs_misc['resource_is_poor'])
        return 
    end

    if buildingConfig.id ~= CityBuildingID.teachingBuildID then
        local mainBuildingLevel = self.dc:GetBuildingLevel(CityBuildingID.teachingBuildID)
        if mainBuildingLevel < config.unlock_req_main_building_level then
            --app.log_warning('main building level is to low')
            HintUI.SetAndShow(EHintUiType.zero, string.format(gs_misc['main_building_level_is_low'], buildingConfig.name))
            return 
        end
    else
        local player = g_dataCenter.player
        local level = player:GetLevel()
        if myLevel >= level then
            HintUI.SetAndShow(EHintUiType.zero, gs_misc['cannot_over_player_level'])
            return 
        end
    end

    self.loadingId = GLoading.Show(GLoading.EType.ui)
    msg_city_building.UpgradeBuilding(buildingConfig.id)
    self.upgradeReponseCallback = callback
end

function CityBuildingMgr:RequestUpgradeResponse(ret, buildingid)
    GLoading.Hide(GLoading.EType.ui, self.loadingId)

    if self.upgradeReponseCallback ~= nil and _G[self.upgradeReponseCallback] ~= nil then
        _G[self.upgradeReponseCallback](ret, buildingid)
    end
end

function CityBuildingMgr:needCreateEntityForModelID(model_id)

    if type(self.dc.buildinginfo) ~= 'table' then
        return false
    end

    local buildingConfig = self:GetBuildingConfig(model_id)
    --app.log('xx33 ' .. model_id .. ' ' .. buildingConfig.id)
    for k,v in pairs(self.dc.buildinginfo) do
        if v.BuildingID==buildingConfig.id then
            return true
        end
    end
    return false
end

function CityBuildingMgr:HasRequestBuildingInfo()
    return self.dc:GetBuildingHomeInfo() ~= nil
end

function CityBuildingMgr:OnTeamUpgrade()

    if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_SLG) == false and self:HasRequestBuildingInfo() then
        return
    end

    self:RequestMyBuildingInfo()
end

function CityBuildingMgr:HasTipPoint()
    if not self:HasRequestBuildingInfo() then
        return false
    end

    for k,bid in pairs(CityBuildingID) do
        if self:GetBuildingResource(bid) >= self:GetMaxStorage(bid) then
            return true        
        end
    end
    

    if self:GetRobberyCount() > 0 then
        return true
    end
    return false
end

function CityBuildingMgr:IsOpen()
    return self:HasTipPoint()
end

function CityBuildingMgr:RequestMyBuildingInfo()
    
    if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_SLG) == false or self._isRequestBUuildingInfo == true then
        return
    end
    

    if not self:HasRequestBuildingInfo() then
        --GLoading.Show()
        self._isRequestBUuildingInfo = true
        msg_city_building.RequestMyBuildingInfo(CityBuildingMgr.ResponseMyBuildingInfo, self)
    else
        --PlayUI.on_enter_ui_scene()
    end
end

function CityBuildingMgr:ResponseMyBuildingInfo(ret, buildinginfo, bhi)
    --GLoading.Hide()
    local isSuc,info = PublicFunc.GetErrorString(ret, false)
    self._isRequestBUuildingInfo = false
    if isSuc == true then
    
        if type(buildinginfo)~='table' and type(bhi)~= 'table' then
            app.log_warning('RequestMyBuildingInfo response data is error!')
            return 
        end

        --app.log('bhi = ' .. table.tostring(bhi))

        self.dc:ResetAllBuildingInfo()
        self.dc:SetBuildingHomeInfo(bhi)
        for k,v in ipairs(buildinginfo) do
            self:SetBuildingInfo(v)
        end

        self:UpdateResourceAndFightScoreShow()
        --PlayUI.on_enter_ui_scene()
    else
        HintUI.SetAndShow(EHintUiType.zero, "ret:" .. ret .. ' ' .. info);
    end
end

function CityBuildingMgr:SetUpdateResourceCallback(calbak)
    self._UpdateResource = calbak
end

function CityBuildingMgr:SetPlayerResource(newResource)
    if self.log then
        app.log('SetPlayerResource old:' .. tostring(self.dc:GetResource()) .. ' new:' .. tostring(newResource))
    end

    self.dc:SetResource(newResource)

    self:UpdateResourceAndFightScoreShow()
end

function CityBuildingMgr:SetFightScore(newScore)
    
    self.dc.building_home_info.fightScore = newScore
    self:UpdateResourceAndFightScoreShow()
end

function CityBuildingMgr:UpdateResourceAndFightScoreShow()
    if self._UpdateResource ~= nil and _G[self._UpdateResource] ~= nil then
        _G[self._UpdateResource]()
    end
end

function CityBuildingMgr:GetPlayerResource()
    return self.dc:GetResource()
end

function CityBuildingMgr:SetOnUpdateRobberyCount(calback)
    self._OnUpdateRobberyCount = calback
end

function CityBuildingMgr:SetUsedRobberyCount(usedCount)
    self._usedRobberyCount = usedCount;
    Utility.call_func(self._OnUpdateRobberyCount)
end

function CityBuildingMgr:SetBuyRobberyCountData(buyTimes, buyCount)
    self._buyRobberyCountTimes = buyTimes
    self._buyRobberyCount = buyCount
    Utility.call_func(self._OnUpdateRobberyCount)
end

function CityBuildingMgr:GetBuyRobberyCountTimes()
    return self._buyRobberyCountTimes
end

function CityBuildingMgr:GetRobberyCount()
    local count = self.dc:GetRobberyCountEveryDay()
    count = count + self._buyRobberyCount

    
    local vipData = g_dataCenter.player:GetVipData();
    local freeCount = 0;
    if vipData then
        freeCount = vipData.ex_slg_free_times
    else
        app.log('vip config error!')
    end

    count = count + freeCount;

    return count - self._usedRobberyCount
end

function CityBuildingMgr:SetBuildingInfo(newbi)
    if self.log then
        --app.log('SetBuildingInfo old:' .. table.tostring(self.dc:GetBuildingInfo(newbi.BuildingID)) .. ' new:' .. table.tostring(newbi))
    end

     self.dc:SetBuildingInfo(newbi.BuildingID, newbi)
end

function CityBuildingMgr:GetBuildingInfo(bid)
    return self.dc:GetBuildingInfo(bid)
end

function CityBuildingMgr:GetAllBuildingInfo()
    return self.dc:GetAllBuildingInfo()
end

function CityBuildingMgr:GetHasEmbattleHeroCount(teamEmbattle)
    local num = 0;
    if type(teamEmbattle) == 'table' then
        for k,v in ipairs(teamEmbattle) do 
            if v[1] ~= nil and v[2] ~= nil then
                num = num + 1
            end
        end
    end
    
    return num
end

function CityBuildingMgr:SetBuildingGuardHero(teamEmbattle)
    --app.log('SetBuildingGuardHero ' .. table.tostring(teamEmbattle))
    if type(teamEmbattle) ~= 'table' or self:GetHasEmbattleHeroCount(teamEmbattle) == 0 then
        return
    end
    local bid = self:GetSelectedBuildingID()
    local guardHero = self:GetBuildingGuardHero(bid)
    local isSame = true
    local hero = '';
    if guardHero ~= nil then
        for pos, em in pairs(teamEmbattle) do
            if em[1] ~= nil and em[2] ~= nil then
                if string.len(hero) > 0 then
                    hero = hero .. ';'
                end
                local curHero = em[1] .. '=' .. em[2]
                hero = hero .. curHero
                if string.find(guardHero, curHero) == nil then
                    isSame = false
                end
            end
        end
    else
        isSame = false
    end
    if isSame == true or string.len(hero) < 1 then
        app.log('isSame ' .. tostring(isSame))
        return
    end
    app.log('----------========== ' .. hero)
    msg_city_building.gc_set_building_guard_hero(bid, hero)
end

function CityBuildingMgr:ReponseSetBuildingGuardHero(ret,buildingid)
    local isSuc, info = PublicFunc.GetErrorString(ret)
--    if ret == 0 then
--        HintUI.SetAndShow(EHintUiType.zero, gs_misc['str_12'])
--    end
    app.log('ReponseSetBuildingGuardHero ' .. tostring(isSuc) .. ' ' .. tostring(info) )
end

function CityBuildingMgr:GetFightScore()
    return self.dc.building_home_info.fightScore
end

function CityBuildingMgr:SetSelectedBuildingID(bid)
    self._selectedBuildingID = bid
end

function CityBuildingMgr:GetSelectedBuildingID()
    return self._selectedBuildingID
end

function CityBuildingMgr:isBeAttack()
    return self.dc.building_home_info.beRobbery == 1
end

function CityBuildingMgr:SetIsBeAttack(is)
    return self.dc.building_home_info.beRobbery == is
end

function CityBuildingMgr:GetExtResource()

    local player = g_dataCenter.player
    local level = player:GetLevel()

    local ret = nil
    if ConfigManager.Get(EConfigIndex.t_robbery_extra_award,level) ~= nil then
        ret = ConfigManager.Get(EConfigIndex.t_robbery_extra_award,level).award_resource
    end

    --如果该等级未找到配置，直接使用配置表中最大的奖励
    if ret == nil then
        ret = 0
        local _robbery_extra_award = ConfigManager._GetConfigTable(EConfigIndex.t_robbery_extra_award)
        for k,v in pairs(_robbery_extra_award) do
            if v.award_resource > ret then
                ret = v.award_resource
            end
        end
    end

    return ret
end

-- slg common

function CityBuildingMgr.embattleStrToTable(str)
    local ret = {}

    if type(str)=='string' then 
        local heros = Utility.lua_string_split(str, ';')
        for k,v in ipairs(heros) do
            local pos2Hero = Utility.lua_string_split(v, '=')
            if #pos2Hero == 2 then
                local pos = tonumber(pos2Hero[1])
                if pos >=0 and pos <=12 then
                    table.insert(ret, {pos, pos2Hero[2]})
                end
            end
        end
    end

    return ret
end

function CityBuildingMgr.embattleTableToStr(embattle)
    local hero = ''
    for pos, em in pairs(embattle) do
        if em[1] ~= nil and em[2] ~= nil then
            if string.len(hero) > 0 then
                hero = hero .. ';'
            end
            local curHero = em[1] .. '=' .. em[2]
            hero = hero .. curHero
        end
    end
    return hero
end