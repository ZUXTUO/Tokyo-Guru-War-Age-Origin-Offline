ChatFight = Class("ChatFight", PlayMethodBase)

local _cdTime = 60
local _countDownTime = 60 * 5

function ChatFight:Init()
    self.sendTime = nil
    self.isShield = false
    self.currWeek = 1

    --请求列表
    self.requestList = {}
    --我的请求
    self.myRequestList = {}
    self:ClearFightData()
end

function ChatFight:ClearFightData()
    self.startFightData = {
        roomId = nil,
        playerData = {},
        roleData = {},
        buffData = {},
        isFirst = false
    }
    self.syncState = ENUM.ChatFightSelectState.FirstOne
    self.currRound = 1
    self.roundResult = {}
end

function ChatFight:Ishield()
    return self.isShield
end

function ChatFight:GetAwardInfo()
    return self.awardInfo
end

function ChatFight:GetWeek()
    return self.currWeek
end

function ChatFight:SyncData(week, shield, lastNoticTime, awardInfo)
    self.currWeek = week
    self.isShield = shield
    self.sendTime = tonumber(lastNoticTime)
    self.awardInfo = awardInfo
end

function ChatFight:CheckAwardIsGet(type, times)
    if type == ENUM.ChatFightAward.Fight then
        if self.awardInfo.fightRecord[times] then
            return true
        end
    elseif type == ENUM.ChatFightAward.Win then
        if self.awardInfo.winRecord[times] then
            return true
        end
    end
    return false
end

-----------------------------------------------------------------

function ChatFight:__GetList(isFight)
    if isFight then
        return self.requestList
    else
        return self.myRequestList
    end
end

function ChatFight:__ClearList(isFight)
    if isFight then
        self.requestList = {}
    else
        self.myRequestList = {}
    end
end

--[[约战申请数量]]
function ChatFight:GetRequestCnt(isFight)
    local list = self:__GetList(isFight)
    local cnt = 0
    local currTime = system.time()
    for _, v in pairs(list) do
        if currTime - tonumber(v.starTime) < _countDownTime  then
            cnt = cnt + 1
        end
    end
    return cnt
end

function ChatFight:HaveRequest(isFight)
    local list = self:__GetList(isFight)
    local cnt = #list
    --检查最新的一条
    if cnt > 0 then
        local request = list[cnt]
        if system.time() - tonumber(request.starTime) < _countDownTime  then
            return true
        end
    end
    return false
end

function ChatFight:GetRequestList(isFight, type)
    local list = self:__GetList(isFight)
    local temp = {}
    local currTime = system.time()
    for _, v in pairs(list) do
        if currTime - tonumber(v.starTime) < _countDownTime  then
            local _type = self:GetPlayerType(v)
            v.type = _type[1]
            v.type2 = _type[2]

            if v.type == type or v.type2 == type or type == ENUM.ChatFightPlayerType.All then
                table.insert(temp, v)
            end
        end
    end
    --好友-社团成员-陌生人，战斗力高-战斗力低，进行先后排序
    table.sort(temp, function(a, b)
        if a.type ~= b.type then
            return a.type < b.type
        else
            return a.fightValue > b.fightValue
        end
    end)
    return temp
end

--[[清理]]
function ChatFight:ClearInvalidRequest(list)
    local currTime = system.time()
    for i = #list, 1, -1 do
        if currTime - tonumber(list[i].starTime) > _countDownTime + 5  then
            table.remove(list, i)
        end
    end
end

function ChatFight:AddRequestList(isFight, data)
    local list = self:__GetList(isFight)
    self:ClearInvalidRequest(list)

    for _, playerData in pairs(data) do
        --相同请求
        self:RemoveRequestByPlayerId(isFight, playerData.playerid)
        table.insert(list, playerData)
    end
end

function ChatFight:RemoveRequestByPlayerId(isFight, playerid)
    local list = self:__GetList(isFight)
    --清空所有
    if tonumber(playerid) == 0 then
        self:__ClearList(isFight)
        return
    end
    for i = #list, 1, -1 do
        if list[i].playerid == playerid then
            local pName = list[i].playerName
            table.remove(list, i)
            return pName
        end
    end
    return ''
end

function ChatFight:GetPlayerType(playerData)
    local temp = {}
    --好友
    if g_dataCenter.friend:GetFriendDataByPlayerGID(playerData.playerid) then
        table.insert(temp, ENUM.ChatFightPlayerType.Friend)
    end
    --同社团
    if playerData.guildName ~= '' and playerData.guildName == g_dataCenter.guild:GetMyGuildName() then
        table.insert(temp, ENUM.ChatFightPlayerType.Guild)
    end
    --陌生人
    if #temp == 0 then
        table.insert(temp, ENUM.ChatFightPlayerType.Stranger)
    end
    return temp
end


---------------------------------------------------------------

function ChatFight:GetSendTimeDiff()
    if self.sendTime == nil or self.sendTime == 0 then
        return 0
    end
    return _cdTime - (system.time() - self.sendTime)
end

function ChatFight:IsSendInfoCD()
    if self.sendTime == nil then
        return false
    end
    local _diffTime = system.time() - self.sendTime
    if _diffTime >= -5 and _diffTime <= _cdTime then
        return true
    end

    return false
end

function ChatFight:GetHeroIdsByWeek()
    local ids = {}
    local config = ConfigManager.Get(EConfigIndex.t_chat_1v1_random, self.currWeek)
    if config == nil then
        app.log("获取配置出错 -- " .. debug.traceback())
        return ids
    end

    local keys = {"normal_role_pool", "s_pool"}
    for _, key in pairs(keys) do
        local poolId = config[key]
        if poolId then
            local poolConfig = ConfigManager.Get(EConfigIndex.t_chat_1v1_role_pool, poolId)
            if poolConfig then
                for k, v in pairs(poolConfig) do
                    local roleId = v.role_id
                    if roleId then
                        local roleConfig = ConfigManager.Get(EConfigIndex.t_chat_1v1_role, roleId)
                        if roleConfig then
                            table.insert(ids, roleConfig.cardNumber)
                        end
                    end
                end
            end
        end
    end
    return ids
end

--[[表chat_1v1_buff ]]
function ChatFight:GetBuffIdsByWeek()
    local ids = {}
    local config = ConfigManager.Get(EConfigIndex.t_chat_1v1_random, self.currWeek)
    if config == nil then
        app.log("获取配置出错 -- " .. debug.traceback())
        return ids
    end

    for i = 1, 2 do
        local key = "buff_pool_" .. i
        local poolId = config[key]
        if poolId then
            local poolConfig = ConfigManager.Get(EConfigIndex.t_chat_1v1_buff_pool, poolId)
            if poolConfig then
                for k, v in pairs(poolConfig) do
                    local buffId = v.buff_id
                    if buffId then
                        table.insert(ids, buffId)
                    end
                end
            end
        end
    end
    return ids
end

function ChatFight:GetAwardCfg(type)
    local __cfg = nil
    if type == ENUM.ChatFightAward.Fight then
        __cfg = ConfigManager._GetConfigTable(EConfigIndex.t_chat_1v1_fight_reward)
    else
        __cfg = ConfigManager._GetConfigTable(EConfigIndex.t_chat_1v1_win_reward)
    end
    local cfg = {}
    local pos = 1
    for k, v in pairs(__cfg) do
        cfg[pos] = v
        pos = pos + 1
    end
    table.sort(cfg, function (a,b)
        return a.id < b.id
    end)
    return cfg
end

---------------------------------------------------------------


function ChatFight:GetStartFightData()
    return self.startFightData
end

function ChatFight:GetRealCardNumber(cardNumber)
    local roleConfig = ConfigManager.Get(EConfigIndex.t_chat_1v1_role, cardNumber)
    if roleConfig == nil then
        app.log('roleConfig == nil' .. debug.traceback())
        return
    end
    return roleConfig.cardNumber
end

function ChatFight:SetStartFightData(roomid, playerData, roleData, buffData)
    self:ClearFightData()
    self.startFightData = {
        roomId = roomid,
        playerData = playerData,
        roleData = roleData,
        buffData = buffData,
        isFirst = true
    }
    --自己放前面
    local playerData = self.startFightData.playerData
    if playerData[1].playerid ~= g_dataCenter.player:GetGID() then
        local temp = playerData[1]
        playerData[1] = playerData[2]
        playerData[2] = temp
    end
    --更新英雄编号
    for _, v in pairs(self.startFightData.roleData) do
        v.cardNumber = self:GetRealCardNumber(v.cardNumber)
    end
end

--[[先手]]
function ChatFight:IsFirstHand()
    local myPid = g_dataCenter.player:GetGID()
    for k, v in pairs(self.startFightData.playerData) do
        if v.playerid == myPid then
            return v.bFirst
        end
    end
    return false
end

----------------------------------------------------------

function ChatFight:UpdateRoleData(roleData)
    local _upData = {}
    for _, data in pairs(roleData) do
        for k, v in pairs(self.startFightData.roleData) do
            if v.index == data.index then
                --更新英雄编号
                data.cardNumber = self:GetRealCardNumber(data.cardNumber)
                self.startFightData.roleData[k] = data
                table.insert(_upData, data)
                break
            end
        end
    end
    return _upData
end

function ChatFight:GetRoleListByPlayerId(pId)
    local temp = {}
    for _, v in pairs(self.startFightData.roleData) do
        if v.ownerID == pId then
            table.insert(temp, v)
        end
    end
    return temp
end

function ChatFight:GetRoleByIndex(index)
    for _, v in pairs(self.startFightData.roleData) do
        if v.index == index then
            return v
        end
    end
    return nil
end

function ChatFight:CheckIsSelect(index)
    for _, v in pairs(self.startFightData.roleData) do
        if v.index == index then
            return v.ownerID ~= "0"
        end
    end
    return false
end

function ChatFight:SetSyncState(state)
    self.syncState = state
end

function ChatFight:GetSyncState()
    return self.syncState
end

----------------------------------------------------------

--playerId为'0'，平局
function ChatFight:SyncRoundResult(round, playerId)
    self.roundResult[round] = playerId
    self.currRound = table.get_num(self.roundResult) + 1
    if self.currRound > 3 then
        self.currRound = 3
    end
end

function ChatFight:GetResult(round, playerId)
    if self.roundResult[round] == '0' then
        return ENUM.ChatFightResult.Draw
    else
        if self.roundResult[round] == playerId then
            return ENUM.ChatFightResult.Success
        else
            return ENUM.ChatFightResult.Fail
        end
    end
end

function ChatFight:GetSuccessCountByPId(pId)
    local cnt = 0
    for _, v in pairs(self.roundResult) do
        if v ~= '0' and v == pId then
            cnt = cnt + 1
        end
    end
    return cnt
end

function ChatFight:GetFinalFightResult()
    local ret = {}
    for i = 1, 2 do
        local _pId = self.startFightData.playerData[i].playerid
        ret[i] = self:GetSuccessCountByPId(_pId)
    end
    local p1Cnt, p2Cnt = ret[1], ret[2]
    if p1Cnt ~= 0 and p2Cnt ~= 0 then
        if p1Cnt > p2Cnt then
            return ENUM.ChatFightResult.Success, ENUM.ChatFightResult.Fail
        elseif p1Cnt < p2Cnt then
            return ENUM.ChatFightResult.Fail, ENUM.ChatFightResult.Success
        else
            return ENUM.ChatFightResult.Draw, ENUM.ChatFightResult.Draw
        end
    elseif p1Cnt == 0 and p2Cnt == 0 then
        return ENUM.ChatFightResult.Draw, ENUM.ChatFightResult.Draw

    elseif p1Cnt == 0 then
        return ENUM.ChatFightResult.Fail, ENUM.ChatFightResult.Success

    else
        return ENUM.ChatFightResult.Success, ENUM.ChatFightResult.Fail
    end
end

function ChatFight:SyncFightSeq(data)
    self.fightSeq = data
end

function ChatFight:GetCurrRound()
    return self.currRound
end

function ChatFight:GetShowFighter()
    return self.startFightData.roleData
end

function ChatFight:GetFightRoleListByPlayerId(pId)
    local list = {}
    for _, v in pairs(self.fightSeq) do
        if v.playerid == pId then
            local _buffPos = v.vecRoleFihgtSequence[4] + 1  --0, 1, 2
            local _buffId = v.vecRoleFihgtSequence[5]
            for i = 1, 3 do
                local temp = {}
                local index = v.vecRoleFihgtSequence[i]
                local data = self:GetRoleByIndex(index)

                temp.number = data.cardNumber
                if i == _buffPos then
                    temp.buffId = _buffId
                else
                    temp.buffId = nil
                end
                temp.result = self:GetResult(i, pId)
                list[i] = temp
            end
            break
        end
    end
    return list
end

function ChatFight:GetFightRoleList()
    local list = {}
    for i = 1, 2 do
        local pId = self.startFightData.playerData[i].playerid
        list[i] = self:GetFightRoleListByPlayerId(pId)
    end
    return list
end

-------------------------------------------------------------

local _UIText = {
    [1] = "你当前正在对决申请中，进入将取消当前申请?"
}

function ChatFight:CheckMyRequest()
    if self:HaveRequest(false) then
        local _func = function()
            msg_1v1.cg_cancel_challenge(0)
        end
        HintUI.SetAndShow(EHintUiType.two, _UIText[1],  {str="确定", func = _func}, {str="取消"});
        return true
    end
    return false
end

function ChatFight:CanGetAward(type)
    local info = self:GetAwardInfo()
    if info == nil then
        return false
    end
    local times = 0
    if type == ENUM.ChatFightAward.Fight then
        times = info.fightTimes
    else
        times = info.winTimes
    end
    if times > 0 then
        local cfg = self:GetAwardCfg(type)
        for k, v in pairs(cfg) do
            if times >= v.id then
                if not self:CheckAwardIsGet(type, v.id) then
                    return true
                end
            end
        end
    end
    return false
end