
msg_guild_war = {}

local isLocalData = true

local _DEFENCE = ENUM.GuildWarPhase.Defence
local _ATTACK = ENUM.GuildWarPhase.Attack
local _Interval = ENUM.GuildWarPhase.Interval
local _Normal = ENUM.GuildWarPhase.Normal

local EGuildWarPrivateErrorCode_NotRoom = -100
local EGuildWarPrivateErrorCode_HasOccupy = -101

--[[获取赛季信息]]
function msg_guild_war.cg_get_season_info()
	--if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_get_season_info(Socket.socketServer)
end

--[[获取驻防信息]]
function msg_guild_war.cg_get_guard_info(showLoading)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_DEFENCE, _Interval) then
        return
    end
	--if not Socket.socketServer then return end
    if showLoading then
        GLoading.Show(GLoading.EType.msg)
    end
    nmsg_guild_war.cg_get_guard_info(Socket.socketServer)
end

--[[获得节点防御]]
function msg_guild_war.cg_get_guard_teams(nodeId)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_DEFENCE, _Interval) then
        return
    end
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_get_guard_teams(Socket.socketServer, nodeId)
end

--[[设置防守队伍]]
function msg_guild_war.cg_set_guard_team(nodeId, teamType, herosDataid)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_DEFENCE) then
        return
    end
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_set_guard_team(Socket.socketServer, nodeId, teamType, herosDataid)
end

	
--[[撤销驻防]]
function msg_guild_war.cg_cancel_guard_team(nodeId, teamType)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_DEFENCE) then
        return
    end
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_cancel_guard_team(Socket.socketServer, nodeId, teamType)
end

-----------------------------服务器返回-----------------------------------------------

function msg_guild_war.gc_get_season_info_ret(season, beginTime, endTime, dan, danRanking)
    GLoading.Hide(GLoading.EType.msg)
    g_dataCenter.guildWar:SetSeasonInfo(season, beginTime, endTime, dan, danRanking)
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_season_info_ret)
end

function msg_guild_war.gc_get_guard_info_ret(result, nodeInfo, guildInfo)	
    GLoading.Hide(GLoading.EType.msg)
    --无房间, 匹配轮空
    if tonumber(result) == EGuildWarPrivateErrorCode_NotRoom then
        PublicFunc.msg_dispatch(msg_guild_war.gc_get_guard_info_ret, false)
        return
    end
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    if g_dataCenter.guildWar:IsHavePhaseLimit(_DEFENCE, _Interval) then
        return
    end
    if g_dataCenter.guildWar:IsDefencePhase() then
        g_dataCenter.guildWar:SetNodeSummary(_DEFENCE, nodeInfo, guildInfo)
    else
        g_dataCenter.guildWar:SetNodeSummary(_Interval, nodeInfo, guildInfo)
    end
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_guard_info_ret, true)
end

--[[驻防队伍信息]]
function msg_guild_war.gc_get_guard_teams_ret(result, nodeId, teams, occupyStartTime)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    if g_dataCenter.guildWar:IsHavePhaseLimit(_DEFENCE, _Interval) then
        return
    end
    
    if g_dataCenter.guildWar:IsDefencePhase() then
        g_dataCenter.guildWar:SetTeamData(_DEFENCE, nodeId, teams, occupyStartTime)
    else
        g_dataCenter.guildWar:SetTeamData(_Interval, nodeId, teams, occupyStartTime)
    end

    --更新地图驻防队伍数量
    g_dataCenter.guildWar:UpdateNodeSummaryDefenceTeamCnt(nodeId, #teams)
    --app.log('------------------>gc_get_guard_teams_ret nodeId = ' .. nodeId .. ' ' .. table.tostring(teams))
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_guard_teams_ret, nodeId)
end

--[[设置驻防]]
function msg_guild_war.gc_set_guard_team_ret(result, nodeId, teamType, teams)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    if g_dataCenter.guildWar:IsHavePhaseLimit(_DEFENCE) then
        return
    end
    --更新我的队伍
    msg_guild_war.gc_get_my_team_ret(result, teams, teamType)
    PublicFunc.msg_dispatch(msg_guild_war.gc_set_guard_team_ret)
end

--[[撤销驻防]]
--[[
    change --> team type变化
    struct GuiuldWarTeamIDChange
    {
	    int8 oldTeamId;
	    int8 newTeamId;
    }
]]
function msg_guild_war.gc_cancel_guard_team_ret(result, nodeId, teamType, change)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    if g_dataCenter.guildWar:IsHavePhaseLimit(_DEFENCE) then
        return
    end

    --更新队伍信息
    msg_guild_war.cg_get_guard_teams(nodeId)

    local teamTypeChange = {}
    for k, v in pairs(change) do
        teamTypeChange[v.oldTeamId] = v.newTeamId
    end
    --删除我的队伍
    local teams = g_dataCenter.guildWar:RemoveMyTeamInfo(teamType, teamTypeChange)
    msg_guild_war.gc_get_my_team_ret(result, teams, teamType)
end

--------------------------------------------------------------------------------------

--[[获取我的队伍]]
function msg_guild_war.cg_get_my_team()
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_get_my_team(Socket.socketServer)
end

--[[设置驻防及进攻令]]
function msg_guild_war.cg_set_node_is_key(nodeId, isKey)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_set_node_is_key(Socket.socketServer, nodeId, isKey)
end

function msg_guild_war.gc_get_my_team_ret(result, teams, teamType)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        --PublicFunc.GetErrorString(result)        
        return
    end
    --app.log('------------------>gc_get_my_team_ret teams = ' .. table.tostring(teams))
    g_dataCenter.guildWar:SetMyTeamInfo(teams)
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_my_team_ret, teamType)
end

function msg_guild_war.gc_set_node_is_key_result(result, nodeId, isKey)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    g_dataCenter.guildWar:SetMassOrder(nodeId, isKey)
    PublicFunc.msg_dispatch(msg_guild_war.gc_set_node_is_key_result, nodeId)
end

--------------------------------------------------------------------------------------

--[[获取进攻信息]]
function msg_guild_war.cg_get_attack_info(showLoading)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK, _Normal) then
        return
    end
    --if not Socket.socketServer then return end
    if showLoading then
        GLoading.Show(GLoading.EType.msg)
    end
    nmsg_guild_war.cg_get_attack_info(Socket.socketServer)
end

--[[获取节点的进攻信息]]
function msg_guild_war.cg_get_attack_guard_teams(nodeId)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK, _Normal) then
        return
    end
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_get_attack_guard_teams(Socket.socketServer, nodeId)
end

--[[开始进攻]]
function msg_guild_war.cg_begin_attack(nodeId, attackTeamId, guardPlayerId, guardTeamId, heros)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK) then
        return
    end
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_begin_attack(Socket.socketServer, nodeId, attackTeamId, guardPlayerId, guardTeamId, heros )
end

--[[进攻结算]]
--int isWin, list<GuildWarHerosHP> mySideHerosHp, list<GuildWarHerosHP> otherSideHerosHp
function msg_guild_war.cg_end_attack(isWin, mySideHerosHp, otherSideHerosHp)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK) then
        return
    end
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_end_attack(Socket.socketServer, isWin, mySideHerosHp, otherSideHerosHp)
end

--[[沒有防守，直接占领]]
function msg_guild_war.cg_direct_occupy(nodeId, teamType, heros)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK) then
        return
    end
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_direct_occupy(Socket.socketServer, nodeId, teamType, heros)
end

--[[修改队伍阵型]]
function msg_guild_war.cg_change_team_pos(teamType, herosDataid)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_guild_war.cg_change_team_pos(Socket.socketServer, teamType, herosDataid)
end

-----------------------------服务器返回-----------------------------------------------

function msg_guild_war.gc_get_attack_info_ret(result, nodeInfo, guildInfo)
    GLoading.Hide(GLoading.EType.msg)
    --无房间, 匹配轮空
    if tonumber(result) == EGuildWarPrivateErrorCode_NotRoom then
        PublicFunc.msg_dispatch(msg_guild_war.gc_get_attack_info_ret, false)
        return
    end
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK, _Normal) then
        return
    end
    --app.log('------------->gc_get_attack_info_ret = ' .. table.tostring(nodeInfo))
    if g_dataCenter.guildWar:IsAttackPhase() then
        g_dataCenter.guildWar:SetNodeSummary(_ATTACK, nodeInfo, guildInfo)
    else
        g_dataCenter.guildWar:SetNodeSummary(_Normal, nodeInfo, guildInfo)
    end
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_attack_info_ret, true)
end

function msg_guild_war.gc_get_attack_guard_teams_ret(result, nodeId, teams, attackCount, occupyStartTime)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK, _Normal) then
        return
    end
    --app.log('------------------>gc_get_attack_guard_teams_ret nodeId = ' .. nodeId .. ' ' .. table.tostring(teams) .. ' ' .. attackCount)
    if g_dataCenter.guildWar:IsAttackPhase() then
        g_dataCenter.guildWar:SetTeamData(_ATTACK, nodeId, teams, occupyStartTime, attackCount)
    else
        g_dataCenter.guildWar:SetTeamData(_Normal, nodeId, teams, occupyStartTime, attackCount)
    end
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_attack_guard_teams_ret, nodeId)
end

function msg_guild_war.gc_begin_attack_ret(result, attackTeamId, guardFightHeros, herosPos, GuardAgainProps)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        if result ~= EGuildWarPrivateErrorCode_HasOccupy then
            PublicFunc.GetErrorString(result)
        end   
        PublicFunc.msg_dispatch(msg_guild_war.gc_begin_attack_ret, result)     
        return
    end
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK) then
        return
    end
    g_dataCenter.guildWar:SetEncourageInfo(2,GuardAgainProps);
    g_dataCenter.guildWar:SetAndBeginGame(attackTeamId, guardFightHeros, herosPos)
    PublicFunc.msg_dispatch(msg_guild_war.gc_begin_attack_ret, result)
end
	
function msg_guild_war.gc_end_attack_ret(result)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
end

function msg_guild_war.gc_direct_occupy(result, nodeId, myTeam, nodeSummary)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        if result ~= EGuildWarPrivateErrorCode_HasOccupy then
            PublicFunc.GetErrorString(result)
        end
        PublicFunc.msg_dispatch(msg_guild_war.gc_direct_occupy, result)     
        return
    end
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK) then
        return
    end

    --更新接点
    g_dataCenter.guildWar:UpdateNodeSummary(_ATTACK, nodeId, nodeSummary)

    --更新队伍
    local teams = g_dataCenter.guildWar:AddAttackTeamInfo(myTeam)
    msg_guild_war.gc_get_my_team_ret(result, teams)

    PublicFunc.msg_dispatch(msg_guild_war.gc_direct_occupy, result, nodeId)
end
	
--[[据点已被占领]]
function msg_guild_war.gc_notice_node_has_be_occupy(nodeId, nodeSummary)
    if g_dataCenter.guildWar:IsHavePhaseLimit(_ATTACK) then
        return
    end
    g_dataCenter.guildWar:UpdateNodeSummary(_ATTACK, nodeId, nodeSummary)
end

function msg_guild_war.gc_change_team_pos(result, teamType, herosDataid)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)      
        return
    end
    --app.log("==========> gc_change_team_pos " .. teamType .. ' ' .. table.tostring(herosDataid))
    g_dataCenter.guildWar:UpdateMyTeamPos(teamType, herosDataid)
    PublicFunc.msg_dispatch(msg_guild_war.gc_change_team_pos)
end

function msg_guild_war.cg_awards()
   nmsg_guild_war.cg_awards(Socket.socketServer)
end

function msg_guild_war.gc_awards(info)

    PublicFunc.msg_dispatch(msg_guild_war.gc_awards,info)
end

--[[战斗日志]]
function msg_guild_war.cg_get_node_fight_log(nodeId)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        guild_war_local.cg_get_node_fight_log(nodeId)
    else
        nmsg_guild_war.cg_get_node_fight_log(Socket.socketServer, nodeId)
    end
end

function msg_guild_war.gc_get_node_fight_log(result, nodeId, logs)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)      
        return
    end
    g_dataCenter.guildWar:ProcessFightLogs(nodeId, logs)
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_node_fight_log)
end

function msg_guild_war.cg_get_guild_deployment_info()
     --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        guild_war_local.cg_get_guild_deployment_info()
    else
        nmsg_guild_war.cg_get_guild_deployment_info(Socket.socketServer)
    end
end

function msg_guild_war.gc_get_guild_deployment_info(result, info)
    app.log("msg_guild_war.gc_get_guild_deployment_info".." result="..tostring(result).. "info="..table.tostring(info))
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)      
        return
    end 
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_guild_deployment_info,result,info)
end

function msg_guild_war.cg_buy_buff(type)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
    else
        nmsg_guild_war.cg_buy_buff(Socket.socketServer, type)
    end
end
function msg_guild_war.cg_get_buy_buff_times()
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
    else
        nmsg_guild_war.cg_get_buy_buff_times(Socket.socketServer)
    end
end
function msg_guild_war.gc_buy_buff_ret(ret, type, buyTimes)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(ret) ~= 0 then
        PublicFunc.GetErrorString(ret)      
        return
    end 
    -- app.log("#lhf #gc_buy_buff_ret"..table.tostring({ret, type, buyTimes}));
    g_dataCenter.guildWar:SetEncourageTimes(type, buyTimes);
    PublicFunc.msg_dispatch(msg_guild_war.gc_buy_buff_ret,ret, type, buyTimes)
end
function msg_guild_war.gc_get_buy_buff_times(goldBuyTimes, crystalBuyTimes)
    GLoading.Hide(GLoading.EType.msg)
    -- app.log("#lhf #gc_get_buy_buff_times"..table.tostring({goldBuyTimes, crystalBuyTimes}));
    g_dataCenter.guildWar:SetEncourageTimes(1, goldBuyTimes);
    g_dataCenter.guildWar:SetEncourageTimes(2, crystalBuyTimes);
    PublicFunc.msg_dispatch(msg_guild_war.gc_get_buy_buff_times,goldBuyTimes, crystalBuyTimes)
end
function msg_guild_war.gc_sync_buff_info(againProps)
    -- app.log("#lhf #gc_sync_buff_info"..table.tostring(againProps));
    g_dataCenter.guildWar:SetEncourageInfo(1,againProps);
    PublicFunc.msg_dispatch(msg_guild_war.gc_sync_buff_info,againProps)
end
