
CityRobberyMgr = Class("CityBuildingMgr")

function CityRobberyMgr.GetInst()
    if CityRobberyMgr.__inst == nil then
        CityRobberyMgr.__inst = CityRobberyMgr:new()
    end
    return CityRobberyMgr.__inst
end

function CityRobberyMgr:Init()
    self.haveSearchedPlayerID = {}
    self.haveRobberyedPlayerID = {}
    self.hasUsedHerosIndex = {} 
    self.hasDeadHerosDataid = {}

    self.robberySessionLiveTime = 600

    self.buildingSceneUICount = 0
end

function CityRobberyMgr:GetExceptPlayerIDs()
    return self.haveSearchedPlayerID
end

function CityRobberyMgr:IsEnterRobberyMode()
    return self.targetPlayer ~= nil
end

function CityRobberyMgr:GetTargetPlayer()
    return self.targetPlayer
end

function CityRobberyMgr:SetTargetInfo(sr)

    self:ClearTarget()

    self.targetPlayer = Player:new()
    self.targetPlayer:UpdateData(sr.target_player)
    self:SetTargetGuildName(sr.guild_name)

    table.insert(self.haveSearchedPlayerID, sr.target_player.playerid)

    local pkg = Package:new()
    for k,v in ipairs(sr.target_cardinfo) do
        pkg:AddCard(ENUM.EPackageType.Hero, v)
    end
    self.targetPlayer:SetPackage(pkg)
    self.targetBuildingInfo = sr.target_buildinginfo
    self.sessionStartTime = tonumber(sr.session_begin_time)

    for k,v in ipairs(sr.used_heros) do
        self:AddPlayerHasUsedHero(v)
    end
    --app.log('has dead hero =' .. table.tostring(dead_hero))
    for k,v in ipairs(sr.dead_heros) do
        self:AddHasDeadHero(v)
    end
    self:SetHasRobbedAnyBuilding(sr.has_robbed_any)
    --app.log('has use robbery count ' .. tostring(urc))
    self:SetUsedRobberyCount(sr.used_robbery_count)
    self:SetHasRobbedMainBuilding(sr.has_robbery_main)

    self:SetWinAndLostScoreChange(sr.win_add_score, sr.lost_minus_score)
end

function CityRobberyMgr:SetTargetGuildName(name)
    self._guildName = name or ""
    if string.len(self._guildName) < 1 then
        self._guildName = gs_misc['str_31']
    end
end

function CityRobberyMgr:GetTargetGuildName()
    return self._guildName
end

function CityRobberyMgr:SetWinAndLostScoreChange(winChange, lostChange)
    self._winChange = winChange
    self._lostChange = lostChange
end

function CityRobberyMgr:GetWinAndLostScoreChange()
    return self._winChange, self._lostChange
end

function CityRobberyMgr:SetHasRobbedAnyBuilding(is)
    self.has_robbed_any_building = is
end

function CityRobberyMgr:HasRobbedAnyBuilding()
    return self.has_robbed_any_building
end

function CityRobberyMgr:SetHasRobbedMainBuilding(is)
    self.has_robbed_main_building = is
end

function CityRobberyMgr:HasRobbedMainBuilding()
    return self.has_robbed_main_building
end

function CityRobberyMgr:GetTargetCardInfos()
    return self.targetPlayer.package.list[ENUM.EPackageType.Hero]
end

function CityRobberyMgr:GetTargetBuildingInfo(targetBuildingid)
    if self.targetBuildingInfo == nil then
        return
    end

    for k,v in pairs(self.targetBuildingInfo) do
        if v.BuildingID == targetBuildingid then
            return v;
        end
    end
end

function CityRobberyMgr:SetCurrentRobberyInfo(buildingid, embattle)
    --app.log('SetCurrentRobberyInfo ' .. tostring(buildingid) .. ' ' .. table.tostring(embattle))
    self.curRobberyBuildingID = buildingid
    self.curRobberyTargetEmbattle = embattle
end

function CityRobberyMgr:GetCurrentRobberyInfo()
    return self.curRobberyBuildingID,self.curRobberyTargetEmbattle
end

function CityRobberyMgr:ClearCurrentRobberyInfo()
    self.curRobberyBuildingID = nil
    self.curRobberyTargetEmbattle = nil
end

function CityRobberyMgr:SetTipRobberyTimeOut(is)

    if is ~= true then
       self.tipRobberyTimeOut = nil
    elseif #self.haveRobberyedPlayerID < 3 then
        self.tipRobberyTimeOut = true
    end
end

function CityRobberyMgr:GetTipRobberyIsTimeOut()
    return self.tipRobberyTimeOut
end

function CityRobberyMgr:SetUsedRobberyCount(is)
    self._currentHasUsedRobberyCount = is
end

function CityRobberyMgr:GetUsedRobberyCount(is)
    return self._currentHasUsedRobberyCount
end

function CityRobberyMgr:ClearTarget()
    self.targetPlayer = nil
    self.targetBuildingInfo = nil
    self.curRobberyBuildingID = nil
    self.curRobberyTargetEmbattle = nil
    self.haveSearchedPlayerID = {}
    self._isRobbingBuildingID = nil
    self.hasUsedHerosIndex = {}
    self.hasDeadHerosDataid = {}
    self.haveRobberyedPlayerID = {}
    self.sessionStartTime = nil
    self._currentHasUsedRobberyCount = nil
end

function CityRobberyMgr:AddHasDeadHero(dataid)
    if dataid then
        self.hasDeadHerosDataid[dataid] = true
    end
end

function CityRobberyMgr:GetHasDeadHeros()
    return self.hasDeadHerosDataid
end

function CityRobberyMgr:AddPlayerHasUsedHero(cardIndex)

    if cardIndex == nil then
        return
    end

    self.hasUsedHerosIndex[cardIndex] = true
end

function CityRobberyMgr:SetCurrentBothSideFightHero(ownSide, otherSide)
    if ownSide ==nil or otherSide == nil then
        self.currentFightHero = nil
    else
        self.currentFightHero = {mySide = ownSide, targetSide = otherSide}
    end
end

function CityRobberyMgr:GetCurrentBothSideFightHero()
    return self.currentFightHero
end

function CityRobberyMgr:GetPlayerHasUsedHero()
    return self.hasUsedHerosIndex
end

function CityRobberyMgr:SetIsRobbingBuildingID(bid)
    self._isRobbingBuildingID = bid
end

function CityRobberyMgr:GetIsRobbingBuildingID()
    return self._isRobbingBuildingID
end

function CityRobberyMgr:AddHasRobberyBuildingID(buildingid)
    if table.index_of(self.haveRobberyedPlayerID, buildingid) < 1 then
        table.insert(self.haveRobberyedPlayerID, buildingid)
    end
end

function CityRobberyMgr:BuildingHasRobbed(buildingid)
    return table.index_of(self.haveRobberyedPlayerID, buildingid) > 0
end

function CityRobberyMgr:HasRobberyAllResource()
    local libray = self:BuildingHasRobbed(CityBuildingID.libraryID) or self:GetTargetBuildingInfo(CityBuildingID.libraryID) == nil
    local dining = self:BuildingHasRobbed(CityBuildingID.diningRoomID) or self:GetTargetBuildingInfo(CityBuildingID.diningRoomID) == nil
    local tech = self:BuildingHasRobbed(CityBuildingID.teachingBuildID) or self:GetTargetBuildingInfo(CityBuildingID.teachingBuildID) == nil

    return libray and dining and tech
end

function CityRobberyMgr:SetSelectedBuildingID(bid)
    self._selectedBuildingID = bid
end

function CityRobberyMgr:GetSelectedBuildingID()
    return self._selectedBuildingID
end

function CityRobberyMgr:RobberyTimeOut()

    --app.log('CityRobberyMgr:RobberyTimeOut 1111111111')

    local fightMgr = FightScene.GetFightManager()
    if fightMgr and fightMgr.OnResponseRobberyTimeOut then
        fightMgr:OnResponseRobberyTimeOut()
    else
        if self.buildingSceneUICount > 0 then
            self:ClearTarget()
            if uiManager:GetCurSceneID() ~= EUI.BuildingTabPageUI then
                HintUI.SetAndShow(EHintUiType.zero, gs_misc['str_15'])
                uiManager:SetStackSize(self.buildingSceneUICount)
            end
        end
    end
end

function CityRobberyMgr:SetBuildingSceneUICount(count)
    self.buildingSceneUICount = count
end

function CityRobberyMgr:Update(dt)
    if self.sessionStartTime ~= nil then
        if system.time() - self.sessionStartTime > self.robberySessionLiveTime then
            self:RobberyTimeOut()
        end
    end
end

function CityRobberyMgr:GetRemainRobberyTime()
    if self.sessionStartTime ~= nil then
        return self.robberySessionLiveTime - (system.time() - self.sessionStartTime)
    end
    return 0
end