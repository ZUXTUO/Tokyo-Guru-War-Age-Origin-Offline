
LevelUpReward = Class("LevelUpReward")

level_up_reward_ret = 
{
	level_up_reward_get_ret_success = 0, 
	level_up_reward_get_ret_failed = 1,	

	level_up_reward_get_ret_msg_failed = 10,    
	level_up_reward_get_ret_msg_have_get = 11,    
	level_up_reward_get_ret_msg_activity_time_expire=12,  
	level_up_reward_get_ret_msg_level_Illegal  = 13,    
	level_up_reward_get_ret_msg_player_level_low = 14,
	level_up_reward_get_ret_msg_player_add_item_failed = 15,
    level_up_reward_not_find_player = 16,
}

function LevelUpReward.GetInstance()
    if LevelUpReward.__instance == nil then
        LevelUpReward.__instance=LevelUpReward:new()
    end
    return  LevelUpReward.__instance
end

function LevelUpReward:Init()
    self.dataCenter = g_dataCenter.levelUpRewardData

    self['reponseInitDataCalbak'] = Utility.bind_callback(self, LevelUpReward.OnServerReponseInitData)
    self['reponseGetRewardLevel'] = Utility.bind_callback(self, LevelUpReward.OnResponseGetLevelReward)
    self['OnLevelUp'] = Utility.bind_callback(self, self.OnLevelUp)

    PublicFunc.msg_regist(player.gc_update_player_exp_level, self['OnLevelUp'])
end

function LevelUpReward:OnLevelUp()
    self:CalHasnotGetRewardLevel()
end

function LevelUpReward:RequestInitData()
    if self.dataCenter:GetHasGetLevels() == nil then
        msg_activity.cg_get_level_up_reward_data(self['reponseInitDataCalbak'])
    end
end

function LevelUpReward:OnServerReponseInitData(data)
    self:SetHasGetLevels(data.hasGetLevelStr)
    self:SetBeginTime(data.beginTime)
    self:SetEndTime(data.endTime)
    self:SetConfig(data.config)
end

function LevelUpReward:GetLevelReward(reward, calbak)
    self._GetLevelReward = calbak
    msg_activity.client_get_level_reward(self['reponseGetRewardLevel'], reward)
end

function LevelUpReward:OnResponseGetLevelReward(ret, msgid, reward)
    if ret == level_up_reward_ret.level_up_reward_get_ret_success then
        self:CacheANewGet(reward)
    end
    if self._GetLevelReward ~= nil and _G[self._GetLevelReward] ~= nil then
        _G[self._GetLevelReward](ret, msgid, reward)
    end
    self._GetLevelReward = nil
end

function LevelUpReward:CalHasnotGetRewardLevel()
    self.__notGetRewardLevel={}

    local   hasGetLevels = self.dataCenter:GetHasGetLevels()
    local config = self.dataCenter:GetConfig()

    local playerlevel= g_dataCenter.player:GetLevel()
    --app.log("playerlevel"..playerlevel)
    for k,v in pairs(config) do
        local level=v.level
        if table.index_of(hasGetLevels, level) < 1 then
            table.insert(self.__notGetRewardLevel,{level=level,itemsID=v.reward_items,canGet=playerlevel>=level})
        end
    end
    table.sort(self.__notGetRewardLevel, function(a, b) return a.level < b.level end)

end

function LevelUpReward:GetRewardCount()

    if self.dataCenter:GetHasGetLevels()==nil then
        return 0
    end

    return table.maxn(self.__notGetRewardLevel)
end

function LevelUpReward:GetAReward(index)
    local count=table.maxn(self.__notGetRewardLevel)
    if index>=count then
        return nil
    end

    return self.__notGetRewardLevel[index+1]
end

function LevelUpReward:SetHasGetLevels(levelsStr)

    local strLevels = Utility.lua_string_split(levelsStr, ';')
    local levels = {}
    for k,v in pairs(strLevels) do
        table.insert(levels, tonumber(v))
    end
    
    self.dataCenter:SetHasGetLevels(levels)
    self:CalHasnotGetRewardLevel()
end

function LevelUpReward:SetConfig(config)
    self.dataCenter:SetConfig(config)

    self:CalHasnotGetRewardLevel()
end

function LevelUpReward:CacheANewGet(rew)
    self.dataCenter:AddAHasGetLevel(rew.level)

    self:CalHasnotGetRewardLevel()
end

function LevelUpReward:SetBeginTime(time)
    self.dataCenter:SetBeginTime(time)
end

function LevelUpReward:SetEndTime(time)
    self.dataCenter:SetEndTime(time)
end

function LevelUpReward:isExpired()

    local beginTime = self.dataCenter:GetBeginTime()
    local endTime = self.dataCenter:GetEndTime()

    if beginTime == nil or endTime == nil then
        return true
    end

    if self:GetRewardCount() == 0 then
        return true;
    end
    
    local time = os.time()
    return time < beginTime or time >= endTime
end

function LevelUpReward:GetExpiredDay()

    if self:isExpired() then
        return 0
    end

    return math.ceil((self.dataCenter:GetEndTime() - os.time())/(24 * 60 * 60))
end

--[[是否能得到升级奖励]]
function LevelUpReward:canGetLevelUpReward()
    if self:isExpired() then
        return false
    else 
        if self.__notGetRewardLevel == nil then 
            return false
        end
        local playerlevel = g_dataCenter.player:GetLevel()
        for _, data in pairs(self.__notGetRewardLevel) do
            if playerlevel >= data.level then 
                return true
            end
        end
    end
    return false
end