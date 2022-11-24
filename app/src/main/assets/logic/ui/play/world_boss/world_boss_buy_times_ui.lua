WorldBossBuyTimesUI = Class("WorldBossBuyTimesUI", BuyFightTimesUi);

function WorldBossBuyTimesUI:GetCost(count)
    local totalCost = 0
    local costMaxNum = ConfigManager.GetDataCount(EConfigIndex.t_world_boss_buy_times_cost)
    for i=self.useCount + 1, self.useCount + count do
        local costIndex = math.min(i, costMaxNum)
        totalCost = totalCost + ConfigManager.Get(EConfigIndex.t_world_boss_buy_times_cost,costIndex).price
    end
    return totalCost
end

