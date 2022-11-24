GuildWar = Class("GuildWar", PlayMethodBase)

local _UIText = {
    [1] = "阶段已改变",
    [2] = "(已解散)",
}

function GuildWar:Init()
    PlayMethodBase.Init(self);

    --当前阶段
    self.curPhase = nil 
    --我的队伍
    self.myTeamInfo = {}
    self.myTeamNumber = {}

    --本地临时存储
    self.tempMyAttackTeamInfo = nil
        
    self.nodeSummary = {}
    self.teamData = {}

    --据点信息
    self.strongholdInfo = {}
        
    for phase = ENUM.GuildWarPhase.Normal, ENUM.GuildWarPhase.Max do
        --节点基础信息
        self.nodeSummary[phase] = {}
        self.teamData[phase] = {}
    end  
      
    self.guildInfo = {}    
    --社团地图颜色
    self.guildMapColor = {}

    self.fightInfo = {}
    --布阵ui
    self.embattle = {
        isShowUI = false,
        teamType = nil
    }
    -- 双方鼓励次数信息
    self.encourageInfo = {};
    self.encourageInfo[1] = {};
    self.encourageInfo[1][1] = 0;
    self.encourageInfo[1][2] = 0;
    self.encourageInfo[1][3] = 0;
    self.encourageInfo[2] = {};
    self.encourageInfo[2][1] = 0;
    self.encourageInfo[2][2] = 0;
    self.encourageInfo[2][3] = 0;

    local cfg = ConfigManager.Get(EConfigIndex.t_guild_war_discrete,1);
    self.encourageTimes = {};
    self.encourageTimes[1] = {};
    self.encourageTimes[1].curTimes = 0;
    self.encourageTimes[1].maxTimes = cfg.gold_times;
    self.encourageTimes[1].costNum = cfg.gold_cost;
    self.encourageTimes[2] = {};
    self.encourageTimes[2].curTimes = 0;
    self.encourageTimes[2].maxTimes = cfg.crystal_times;
    self.encourageTimes[2].costNum = cfg.crystal_cost;

    self.fightLogs = {}
end

function GuildWar:SetSeasonInfo(season, beginTime, endTime, dan, danRanking)
    self.seasonInfo = {
        season = season, 
        beginTime = beginTime, 
        endTime = endTime,
        dan = dan,
        danRanking = danRanking,
    }
end

function GuildWar:GetSeasonInfo()
    return self.seasonInfo 
end

function GuildWar:GetCurPhase()
    return self.curPhase
end

function GuildWar:ResetCurPhase()
    self.curPhase = -1
end

function GuildWar:SetCurPhase(phase)
    self.curPhase = phase
end

function GuildWar:GetWeekdayConfig()
    if self.dayOfWeek == nil then
        local config = ConfigManager.Get(EConfigIndex.t_guild_war_discrete, 1)
        self.dayOfWeek = {
            _start = (config.beginDayOfWeek == 0) and 7 or config.beginDayOfWeek,
            _end = (config.endDayOfWeek == 0) and 7 or config.endDayOfWeek,
        }
    end
    return self.dayOfWeek
end

function GuildWar:GetConfigPhase(weekday, hour)  
    --当天是否可以操作 
    local wConfig  = self:GetWeekdayConfig() 
    if weekday < wConfig._start or weekday > wConfig._end then
        return ENUM.GuildWarPhase.Normal
    end

    local config = ConfigManager._GetConfigTable(EConfigIndex.t_guild_war_everyday_round_time)
    for _, v in ipairs(config) do
        if hour >= v.guard_begin and hour < v.guard_end then
            return ENUM.GuildWarPhase.Defence, v.guard_end
        elseif hour >= v.guard_end and hour < v.atack_begin then
            return ENUM.GuildWarPhase.Interval 
        elseif hour >= v.atack_begin and hour < v.attack_end then
            return ENUM.GuildWarPhase.Attack, v.attack_end
        end            
    end
    return ENUM.GuildWarPhase.Normal
end

--[[阶段限制]]
function GuildWar:IsHavePhaseLimit(...)
    for _, phase in ipairs(arg) do
        if phase == self.curPhase then
            return false
        end
    end
    app.log('-------------->' .. debug.traceback())
    --FloatTip.Float(_UIText[1])
    return true
end

function GuildWar:IsDefenceOrIntervalPhase()
    return self.curPhase == ENUM.GuildWarPhase.Defence 
        or self.curPhase == ENUM.GuildWarPhase.Interval 
end

function GuildWar:IsDefencePhase()
    return self.curPhase == ENUM.GuildWarPhase.Defence 
end

function GuildWar:IsIntervalPhase()
    return self.curPhase == ENUM.GuildWarPhase.Interval 
end

function GuildWar:IsAttackPhase()
    return self.curPhase == ENUM.GuildWarPhase.Attack 
end

function GuildWar:IsNormalPhase()
    return self.curPhase == ENUM.GuildWarPhase.Normal
end

--[[直接占领]]
function GuildWar:AddAttackTeamInfo(myTeam)
    table.insert(self.myTeamInfo, myTeam)
    return self.myTeamInfo
end

--[[更新布阵位置]]
function GuildWar:UpdateMyTeamPos(teamType, herosDataid)
    local _heroPos = {}
    for _, v in pairs(herosDataid) do
        _heroPos[v.dataid] = v.pos
    end
    local heros = self:GetMyTeamInfoHerosById(teamType)
    if heros ~= nil then
        for _, hero in pairs(heros) do
            hero.pos = _heroPos[hero.dataid]
        end
    end
end

function GuildWar:SetMyTeamInfo(teams)
    self.myTeamInfo = teams
    self:SetMyTeamNumber()
end

--[[我的队伍编号]]
function GuildWar:SetMyTeamNumber()
    self.myTeamNumber = {}
    --队伍所在的接点
    for k, v in pairs(self.myTeamInfo) do   
        if self.myTeamNumber[v.nodeId] == nil then
            self.myTeamNumber[v.nodeId] = {}
        end
        table.insert(self.myTeamNumber[v.nodeId], k)
    end
end

function GuildWar:GetMyTeamNumber()
    return self.myTeamNumber
end

function GuildWar:GetMyTeamInfoCount()
    return #self.myTeamInfo
end

function GuildWar:RemoveMyTeamInfo(teamType, teamTypeChange)
    local cnt = self:GetMyTeamInfoCount()
    for i = cnt, 1, -1 do
        local info = self.myTeamInfo[i]
        if info.teamType == teamType then
            table.remove(self.myTeamInfo, i)
            break
        end
    end
    --team type变化
    for _, v in pairs(self.myTeamInfo) do
        local newTeamType = teamTypeChange[v.teamType]
        if newTeamType then
            v.teamType = newTeamType
        end
    end
    return self.myTeamInfo
end

--[[是否满三支队伍]]
function GuildWar:HaveThreeDenfenceTeam(_heroIds)
    local count = self:GetMyTeamInfoCount()
    if count <= 1 then
        return false
    elseif count == 2 then
        --该队只有一个英雄, 选择之后，
        --此队无英雄, 还是两队
        for k, v in pairs(self.myTeamInfo) do
            local heros = v.heros          
            if #heros == 1 then
                local dataid = heros[1].dataid
                for _, id in pairs(_heroIds) do
                    if id == dataid then
                        return false
                    end
                end                
            end
        end 
    end
    return true
end

function GuildWar:GetMyTeamInfo(index)
    --队伍被重置，数据可能未同步， 
    --客户端直接不展示
    if self:IsNormalPhase() then
        return
    end
    return self.myTeamInfo[index]
end

function GuildWar:GetMyTeamInfoHerosById(teamType)
    --临时数据
    if self:IsTempAttackData(teamType) then
        return self:GetTempMyAttackTeamInfo()
    end
    for k, v in pairs(self.myTeamInfo) do  
        if v.teamType == teamType then
            return v.heros
        end
    end
    return nil
end

function GuildWar:SetNodeSummary(phase, nodeInfo, guildInfo)
    --清理
    for phase = ENUM.GuildWarPhase.Normal, ENUM.GuildWarPhase.Max do
        self.nodeSummary[phase] = {}
    end

    for _, v in pairs(nodeInfo) do
        self.nodeSummary[phase][v.id] = v
    end    
    for _, v in pairs(guildInfo) do
        self.guildInfo[v.guildId] = v
    end
    local _nodeColor = {
        [1] = {name = "lan", value = {r = 77/255, g = 196/255, b = 255/255}},
        [13] = {name = "hong", value = {r = 255/255, g = 86/255, b = 187/255}},
        [25] = {name = "huang", value = {r = 195/255, g = 255/255, b = 133/255}},
    }
    for nodeId, color in pairs(_nodeColor) do 
        local id = self:GetNodeGuildId(nodeId)
        self.guildMapColor[id] = color
    end
end

--[[社团地图颜色]]
function GuildWar:GetGuildMapColor(guildId)
    return self.guildMapColor[guildId].name , self.guildMapColor[guildId].value
end

local _nodeTypeIdMap = {
    [1] = 1,
    [2] = 3,
    [3] = 2,
    [4] = 4,
}
function GuildWar:GetNodeSpriteName(nodeId)
    local guildId = self:GetNodeGuildId(nodeId)
    local color, _ = self:GetGuildMapColor(guildId)
    local mapConfig = self:GetMapConfig(nodeId)
    return "stz_jianzhu_" .. color .. _nodeTypeIdMap[mapConfig.node_type]
end

function GuildWar:GetNodeBlockColor(nodeId)
    local guildId = self:GetNodeGuildId(nodeId)
    local _, value = self:GetGuildMapColor(guildId)
    return value
end

function GuildWar:GetStrongholdName(nodeId)
    local mapConfig = self:GetMapConfig(nodeId)
    local name = gs_string_guild_war_stronghold_name[mapConfig.name_id]
    if self:IsBaseCamp(nodeId) then
        local info = self:GetGuildInfo(nodeId)   
        local guildName = _UIText[2]
        if info and info.guildName and info.guildName ~= "" then
            guildName = info.guildName
        end
        name = string.format(name, guildName)
    end
    return name
end

--[[节点信息]]
function GuildWar:GetNodeSummary(nodeId)
    return self.nodeSummary[self.curPhase][nodeId]
end

function GuildWar:UpdateNodeSummary(phase, nodeId, summary)
    self.nodeSummary[phase][nodeId] = summary
end

function GuildWar:UpdateNodeSummaryDefenceTeamCnt(nodeId, cnt)
    if self:IsDefencePhase() then
        local summary = self:GetNodeSummary(nodeId)
        if summary then
            summary.teamNum = cnt
        end
    end
end


function GuildWar:SetMassOrder(nodeId, isKey)
    local data = self:GetNodeSummary(nodeId)
    if data then
        data.isKey = isKey
    end
end

function GuildWar:GetMassOrder(nodeId)
    local data = self:GetNodeSummary(nodeId)
    if data then
        return data.isKey
    end
    return 0
end

function GuildWar:GetMyGuildNodeId()
    local nodeIds = {1, 13, 25}
    for _, nodeId in pairs(nodeIds) do 
        if self:IsMyNode(nodeId) then
            return nodeId
        end
    end
    return nil
end

function GuildWar:GetNodeGuildId(nodeId) 
    local data = self:GetNodeSummary(nodeId)
    if data then
        --数据可能未同步， 
        --客户端直接展示据点归属
        if self:IsNormalPhase() then
            if data.occupyGuildId ~= '' then
                return data.occupyGuildId
            end
        end
        return data.ownGuildId
    end
    return nil
end

function GuildWar:IsMyNode(nodeId)
    local myGuildId = g_dataCenter.guild:GetMyGuildId()
    if myGuildId == nil then
        return false
    end
    return self:GetNodeGuildId(nodeId) == myGuildId
end

--[[大本营]]
function GuildWar:IsBaseCamp(nodeId)    
    if nodeId == 1 or nodeId == 13 or nodeId == 25 then
        return true
    end
    return false
end

--[[社团信息]]
function GuildWar:GetGuildInfo(nodeId)
    local info = self:GetNodeSummary(nodeId)
    if info then
        return self.guildInfo[info.ownGuildId]
    end
    return nil
end

--[[占领中]]
function GuildWar:IsOccupy(nodeId)
    local info = self:GetNodeSummary(nodeId)
    if info then
        return info.occupyGuildId ~= ''
    end
    return false
end

function GuildWar:GetOccupyGuildColor(nodeId)
    local info = self:GetNodeSummary(nodeId)
    if info then
        local _, value = self:GetGuildMapColor(info.occupyGuildId)
        return value
    end
    return nil
end

--[[与敌方接壤]]
function GuildWar:IsBorderOn(nodeId)
    local currId = self:GetNodeGuildId(nodeId)
    if currId == nil then
        return false
    end
    local myGuildId = g_dataCenter.guild:GetMyGuildId()
    --查找相邻节点
    local config = self:GetMapConfig(nodeId)
    for _, v in pairs(config.neighbor_nodes) do
        local neiId = self:GetNodeGuildId(v)
        if neiId ~= currId then
            --至少有一个是自己社团
            if currId == myGuildId or neiId == myGuildId then
                return true
            end
        end
    end
    return false
end

--[[
    1.布防阶段, 与敌方接壤
    2.进攻阶段, 与己方接壤, 不在占领中
]]
function GuildWar:ShouldHighLight(nodeId)
    if self:IsBaseCamp(nodeId) then
        return false
    end 
    if self:IsDefencePhase() then
        --高亮自己
        if self:IsMyNode(nodeId) then
            if self:IsBorderOn(nodeId) then
                return true
            end
        end
    elseif self:IsAttackPhase() then
        --高亮别人
        if not self:IsMyNode(nodeId) then            
            --不是"占领中"
            if not self:IsOccupy(nodeId) then
                if self:IsBorderOn(nodeId) then
                    return true
                end
            end
        end
    end
    return false
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function GuildWar:GetMapConfig(nodeId)
    return ConfigManager.Get(EConfigIndex.t_guild_war_map_info, nodeId)
end

function GuildWar:GetNodeConfig(nodeId)
    local mapConfig = self:GetMapConfig(nodeId)
    if mapConfig then
        return ConfigManager.Get(EConfigIndex.t_guild_war_node_type, mapConfig.node_type)
    end
    return nil
end

function GuildWar:GetMaxDefenceTeamCount(nodeId)
    local nodeConfig = self:GetNodeConfig(nodeId)
    if nodeConfig then
        return nodeConfig.defense_limit
    end 
    return 0
end

function GuildWar:GetMaxAttackTeamCount(nodeId)
    local nodeConfig = self:GetNodeConfig(nodeId)
    if nodeConfig then
        return nodeConfig.attack_limit
    end 
    return 0
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function GuildWar:GetTeamCount(nodeId)
    local data = self:GetTeamData(nodeId)
    return #data
end

function GuildWar:GetTeamDataByIndex(nodeId, index)
    local data = self:GetTeamData(nodeId)
    return data[index]
end

function GuildWar:GetTeamData(nodeId)
    return self.teamData[self.curPhase][nodeId]
end

function GuildWar:SetTeamData(phase, nodeId, teams, occupyStartTime, attackCount)
    --清理
    for phase = ENUM.GuildWarPhase.Normal, ENUM.GuildWarPhase.Max do
        self.teamData[phase] = {}
    end

    self.teamData[phase][nodeId] = teams
    --据点信息
    self.strongholdInfo[nodeId] = {
        occupyStartTime = occupyStartTime, 
        attackCount = attackCount,
    }

    --总战力计算
    for k, v in pairs(self.teamData[phase][nodeId]) do
        local _value = 0
        for _, hero in pairs(v.heros) do
            --未死亡
            if hero.curHp ~= 0 then
                _value = _value + hero.fightValue
            end
        end
        v.totalFightValue = _value
    end
    --排序(玩家自己排前面，然后按战斗力)
    local pId = g_dataCenter.player:GetGID()
    table.sort(self.teamData[phase][nodeId], function(a, b)         
        if a.playerid == pId and b.playerid ~= pId then
            return true
        elseif a.playerid ~= pId and b.playerid == pId then
            return false
        else
            return a.totalFightValue > b.totalFightValue 
        end
    end)
end

------------------------------------驻防阶段--------------------------------


------------------------------------进攻阶段--------------------------------

--[[当前全灭的驻防数量]]
function GuildWar:GetTeamAllDeadCount(nodeId)
    local cnt = 0
    local teamData = self:GetTeamData(nodeId)
    for k, v in pairs(teamData) do
        if v.heros and #v.heros ~= 0 then
            if self:IsTeamAllDead(v.heros) then
                cnt = cnt + 1
            end
        end
    end
    return cnt
end

--[[队伍是否全灭]]
function GuildWar:IsTeamAllDead(heros)
    local allDead = true
    for _, hero in pairs(heros) do
        if hero.curHp ~= 0 then
            allDead = false
            break
        end
    end
    return allDead
end

--[[获取进攻队伍]]
function GuildWar:GetAttackTeamCount(nodeId)
    return self.strongholdInfo[nodeId].attackCount
end

--[[获取占领时间]]
function GuildWar:GetOccupyStartTime(nodeId)
    return tonumber(self.strongholdInfo[nodeId].occupyStartTime)
end

--[[此据点是否已进攻]]
function GuildWar:IsAttackedStronghold(nodeId)
    for k, v in pairs(self.myTeamInfo) do
        if v.isAttack == 2 and v.nodeId == nodeId then
            return true
        end
    end
    return false
end


--[[
    临时保存进攻队伍
]]
function GuildWar:SetTempMyAttackTeamInfo(info)
    --增加血量值
    if info then
        for _, v in pairs(info) do        
            v.hp = -1
        end
    end
    self.tempMyAttackTeamInfo = info
end

function GuildWar:ClearTempMyAttackTeamInfo()
    self:SetTempMyAttackTeamInfo(nil)
end

function GuildWar:GetTempMyAttackTeamInfo()
    return self.tempMyAttackTeamInfo
end

function GuildWar:IsTempAttackData(teamType)
    if self:IsDefencePhase() then
        return false
    end
    return teamType == 0
end

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

--[[显示通用上阵]]
function GuildWar:ShowCommonFormationUI(nodeId, _teamType)
    if self.curPhase == ENUM.GuildWarPhase.Normal
         or self.curPhase == ENUM.GuildWarPhase.Interval then
        return
    end
    --我的队伍id
    local _guildWarTeam = {}
    for i = 1, 3 do
        local info = self:GetMyTeamInfo(i)
        for j = 1, 3 do
            local dataId = 0
            if info then
                local heros = info.heros
                if heros[j] then
                    dataId = heros[j].dataid
                end              
            end
            local index = (i - 1) * 3 + j
            _guildWarTeam[index] = dataId
        end
    end 
    --更新英雄列表
    local _initList = {}
    local _heroPosList = {}

    --进攻临时数据, teamType一直为0
    if _teamType ~= 0 or self:IsTempAttackData(_teamType) then
        local heros = self:GetMyTeamInfoHerosById(_teamType)
        if heros ~= nil then
            for k, v in pairs(heros) do
                _initList[k] = v.dataid
                _heroPosList[k] = v.pos
            end
        end
    end
    local data = {
        teamType = ENUM.ETeamType.guild_war,
        heroMaxNum = 3,
        initList = _initList,
        guildWar = {
            team = _guildWarTeam,
            phase = self.curPhase,
            nodeId = nodeId,
            --新增队伍 teamId = 0
            teamId = _teamType,
            heroPosList = _heroPosList
        }
        --showHPType = ENUM.RoleCardPlayMethodHPType.GuildWar
    }
    uiManager:PushUi(EUI.CommonFormationUI, data) 
end

--[[布阵界面]]
function GuildWar:ShowEmbattleUI()
    if not self.embattle.isShowUI then
        return
    end
    self.embattle.isShowUI = false
  
    local _team = {}
    local _pos = {} 
    local _myHeros = self:GetMyTeamInfoHerosById(self.embattle.teamType)
    for k, v in ipairs(_myHeros) do
        table.insert(_team, v.dataid)
        table.insert(_pos, v.pos)
    end
    -- local ui = uiManager:PushUi(EUI.GuildWarArrangeBattleUI)
    -- ui:SetTeam(_team, _pos, nil, nil)
end

function GuildWar:SetEmbattleInfo(isShowUI, teamType)
    self.embattle.isShowUI = isShowUI
    self.embattle.teamType = teamType
end

function GuildWar:GetEmbattleTeamType()
    return self.embattle.teamType
end

-- 获取社团战鼓励次数
-- { 
--      {curTimes=,maxTimes=,costNum=}, -- 金币
--      {curTimes=,maxTimes=,costNum=}, -- 钻石
-- }
function GuildWar:GetEncourageTimes()
    return self.encourageTimes;
end

-- 获得社团战双方鼓励次数
-- {
--     {times,times,times}, -- (己方)暴击，攻击，防御
--     {times,times,times}, -- (敌方)暴击，攻击，防御
-- }
function GuildWar:GetBuffLv()
    return self.encourageInfo;
end

function GuildWar:SetEncourageTimes(type, times)
    self.encourageTimes[type].curTimes = times;
end
function GuildWar:SetEncourageInfo(team, info)
    for k,v in pairs(info) do
        self.encourageInfo[team][v.prop] = v.againTimes;
    end
end
