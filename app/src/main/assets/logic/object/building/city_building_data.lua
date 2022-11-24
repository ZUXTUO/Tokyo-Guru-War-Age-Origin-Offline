
CityBuildingData = CityBuildingData or Class("CityBuildingData")

function CityBuildingData:Init()

end

function CityBuildingData:GetBuildingLevel(buildid)
    return self.buildinginfo[buildid].level
end

function CityBuildingData:IncBuildingLevel(buildid)
    self.buildinginfo[buildid].level = self.buildinginfo[buildid].level + 1
end

function CityBuildingData:GetBuildingUpgradeBeginTime(buildid)
    return self.buildinginfo[buildid].levelUpStartTime
end

function CityBuildingData:SetBuildingHomeInfo(bhi)
    self.building_home_info = bhi
end

function CityBuildingData:GetBuildingHomeInfo()
    return self.building_home_info
end

function CityBuildingData:GetRobberyCountEveryDay()
    return self.building_home_info.robberyCountEveryDay
end

function CityBuildingData:SetResource(res)
    self.building_home_info.resource = res
end


function CityBuildingData:GetResource()
    return self.building_home_info.resource
end

function CityBuildingData:ResetAllBuildingInfo()
    self.buildinginfo = {}
end

function CityBuildingData:GetAllBuildingInfo()
    return self.buildinginfo
end

function CityBuildingData:SetBuildingInfo(buildingid, bi)
    if ConfigManager.Get(EConfigIndex.t_building,buildingid) ~= nil then
        self.buildinginfo[buildingid] = bi
    else
        app.log_warning('buildingid error, id = ' .. tostring(v.BuildingID) .. ' config not exist!')
    end
end

function CityBuildingData:GetBuildingInfo(buildingid)
    local bi = self.buildinginfo[buildingid]
    --if bi == nil then
        --app.log('building info not exist buildingID:' .. tostring(buildingid) .. ' ' .. debug.traceback())
    --end
    return bi
end