

PlayerDataLoader = Class('PlayerDataLoader')

function PlayerDataLoader:Load()
    app.log("begin waiting player data")
end

function PlayerDataLoader:LoadIsCompleted()
    local res = not g_dataCenter.player:GetIsWaitingPlayerData()
    if res then
        app.log("waiting player data end")
        Socket.soketstate = ""
    end
    return res
end
