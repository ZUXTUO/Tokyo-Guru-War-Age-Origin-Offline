

LevelUpRewardData = Class("LevelUpRewardData")

function LevelUpRewardData:Init()
    self.hasGetLevels=nil
end

function LevelUpRewardData:SetConfig(config)
    self.__config = config
end

function LevelUpRewardData:GetConfig()
    return self.__config or {}
end

function LevelUpRewardData:GetHasGetLevels()
    return self.hasGetLevels
end

function LevelUpRewardData:SetHasGetLevels(levels)
    self.hasGetLevels=levels
end

function LevelUpRewardData:AddAHasGetLevel(level)
    if table.index_of(self.hasGetLevels, level) < 1 then
        table.insert(self.hasGetLevels, level)
    end
end

function LevelUpRewardData:SetBeginTime(time)
    self._BeginTime = time
end

function LevelUpRewardData:GetBeginTime(time)
    return self._BeginTime
end

function LevelUpRewardData:SetEndTime(time)
    self._EndTime = time
end

function LevelUpRewardData:GetEndTime(time)
    return self._EndTime
end