
local _UIText = {
    [1] = "布防剩余: %s", 
    [2] = "进攻剩余: %s", 

    [3] = "布防中...",
    [4] = "布防结束",
    [5] = "进攻中...",
    [6] = "进攻结束",

    [7] = "布防阶段：",
    [8] = "进攻阶段：",
    [9] = "周%s至周%s 每日%s:00 - %s:00",
    [10] = "日",
}
local _FILE_NAME = "guild_war_setting"

--[[
{
    [playerId] = {
        date = xx
        showPhase = xx
        shouldShowSeasonUI = xx
    },
    [playerId] = {
        date = xx
        showPhase = xx
        shouldShowSeasonUI = xx
    }
    ...
}
]]
--[[加载配置]]
function GuildWarMapUI:LoadSetting()    
    self.setting = {}
    if file.exist(_FILE_NAME) == true then
		local fileHandle = file.open_read(_FILE_NAME)
		local content = fileHandle:read_all_text()
		fileHandle:close();
		if content then
			local t = loadstring("return " ..content);
			if t then
				self.setting = t();
			end
		end
	end
    local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(system.time())
    self:ResetSetting(year, month, day)
end

function GuildWarMapUI:ResetSetting(year, month, day)
    local date = year .. ''.. month .. '' .. day
    local _pID = tostring(g_dataCenter.player:GetGID())
    self.setting = self.setting or {}
    self.setting[_pID] = self.setting[_pID] or {}
    self.settingOfPlayer = self.setting[_pID] 

    --检查时间，初始化
    if self.settingOfPlayer.date ~=  date then
        self.setting[_pID] = {
            date = date,
            showPhase = nil,
            shouldShowSeasonUI = 1,    
        }
        self:SaveSetting()
        return true
    end
    return false
end

--[[保存配置]]
function GuildWarMapUI:SaveSetting()
	local fileHandle = file.open(_FILE_NAME, 2);
	fileHandle:write_string(table.toLuaString(self.setting));
	fileHandle:close();
end

function GuildWarMapUI:on_handle_phase_tip()
    --先显示赛季
    if self.settingOfPlayer.shouldShowSeasonUI == 1 then
        return
    end
    local phase = self.dc:GetCurPhase()
    if self.settingOfPlayer.showPhase ~= phase then
        self:ShowPhaseTip() 
        self.settingOfPlayer.showPhase = phase
        self:SaveSetting()
    end   
end

function GuildWarMapUI:ShowPhaseTip()
    local _str = nil
    --驻防开始
    if self.dc:IsDefencePhase() then    
        _str = _UIText[3]

    --驻防结束
    elseif self.dc:IsIntervalPhase()        
        and self.settingOfPlayer.showPhase == ENUM.GuildWarPhase.Defence then
        _str = _UIText[4]

    --进攻开始
    elseif self.dc:IsAttackPhase() then  
        _str = _UIText[5]

    --进攻结束
    elseif self.dc:IsNormalPhase() 
        and self.settingOfPlayer.showPhase == ENUM.GuildWarPhase.Attack then
        _str = _UIText[6]    

    end
    if _str ~= nil then
        GuildWarTipUI.Start({
            isShowMask = false,
            str = _str,
            closeTime = 3,
        })
    end
end

------------------------------------------------------------

function GuildWarMapUI:StartTimer()
    --初始化(curPhase == nil)
    self.dc:ResetCurPhase()
    self:on_update()
    if not TimerManager.IsRunning(self.bindfunc["on_update"]) then
        TimerManager.Add(self.bindfunc["on_update"], 1000, -1)
    end
end

function GuildWarMapUI:StopTimer()
    TimerManager.Remove(self.bindfunc["on_update"])
end

function GuildWarMapUI:on_update()
    self:UpdatePhase()
    self:UpdateTime()
    --地图刷新
    self:UpdateRefreshTime()
end

function GuildWarMapUI:UpdatePhase()    
    local oldPhase = self.dc:GetCurPhase()
    local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(system.time())
    local weekday = TimeAnalysis.ConvertToWeekday(system.time())

    local newPhase, endHour = self.dc:GetConfigPhase(weekday, hour)
    self.endHour = endHour
    --已经到第二天
    local needReset = self:ResetSetting(year, month, day)

    if newPhase ~= oldPhase or needReset then
        self.dc:SetCurPhase(newPhase)
        app.log('=========================>newPhase = ' .. newPhase .. '  needReset = ' .. tostring(needReset))

        --xx阶段：周x至周x 每日xx:xx-xx:xx
        self:SetPhaseTimeDesc()

        --关闭所有弹窗
        self:CloseAllPopup()
        self:RequestDataByPhase()
    end
end

--[[数据加载后才显示提示，有可能玩家未匹配]]
function GuildWarMapUI:ShowTipAfterRequestData()
    self:on_handle_phase_tip()
    --赛季数据，每次都请求
    msg_guild_war.cg_get_season_info()
end

function GuildWarMapUI:RequestDataByPhase()
    if self.dc:IsDefenceOrIntervalPhase() then
        msg_guild_war.cg_get_guard_info(true)
    else
        msg_guild_war.cg_get_attack_info(true)
    end
    msg_guild_war.cg_get_my_team()
    --
    self.startRefreshTime = system.time()
end

function GuildWarMapUI:UpdateTime()
    --倒计时
    if self.dc:IsDefencePhase() or self.dc:IsAttackPhase() then
        local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(system.time())
        local endTime = os.time({year = year, month = month, day = day, hour = self.endHour, min = 0, sec = 0})
        local diffSec = endTime - system.time()

        if diffSec > 0 then
            local day, hour, min, sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
            local timeStr = string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec)
            local _txt = nil
            if self.dc:IsDefencePhase()  then
                _txt = _UIText[1]
            else
                _txt = _UIText[2]
            end
            self.lblPhaseContent:set_text(string.format(_txt, timeStr))
        end
    end
end

function GuildWarMapUI:CloseAllPopup()
    --布阵界面关闭
    local ui = uiManager:GetCurScene()
	if ui and ui.on_guild_war_arrange_battle_ui_close then
		ui:on_guild_war_arrange_battle_ui_close()
	end

    GuildWarAwardUI.End()
    GuildWarBuffUI.End()
    GuildWarChooseTeamUI.End()
    GuildWarLeaderboardUI.End()

    GuildWarMemberProgressUI.End()
    GuildWarSeasonUI.End()
    GuildWarStrongholdUI.End()
end

function GuildWarMapUI:SetPhaseTimeDesc()
    if self.dc:IsIntervalPhase() or self.dc:IsNormalPhase() then        
        local config = ConfigManager.Get(EConfigIndex.t_guild_war_everyday_round_time, 1)
        local _txt = ""
        local beginHourStr, endHourStr = "", ""
        --显示进攻时间
        if self.dc:IsIntervalPhase() then
            _txt = _UIText[8] 
            beginHourStr, endHourStr = string.format("%02d", config.atack_begin), string.format("%02d", config.attack_end)            
        --显示驻防时间
        else
            _txt = _UIText[7] 
            beginHourStr, endHourStr = string.format("%02d", config.guard_begin), string.format("%02d", config.guard_end)
        end

        local wConfig  = self.dc:GetWeekdayConfig()  
        local wDayStartStr, wDayEndStr = self:GetDayOfWeekStr(wConfig._start), self:GetDayOfWeekStr(wConfig._end)

        local _txt = _txt .. string.format(_UIText[9], wDayStartStr, wDayEndStr, beginHourStr, endHourStr)
        self.lblPhaseContent:set_text(_txt)
    end
end

function GuildWarMapUI:GetDayOfWeekStr(wDay)
    if wDay == 7 then
        return _UIText[10]
    end
    return wDay
end

--[[
    驻防阶段 -- 20秒刷新一下
    进攻队段 -- 10秒刷新一下
]]

local _DEFENCE_TIME_INTERVAL = 20
local _ATTACK_TIME_INTERVAL = 10

function GuildWarMapUI:UpdateRefreshTime()
    if self.startRefreshTime == nil then
        self.startRefreshTime = system.time()
    end
    if self.dc:IsDefencePhase() then
        local currTime = system.time()
        if currTime - self.startRefreshTime >= _DEFENCE_TIME_INTERVAL then
            self.startRefreshTime = currTime
            self.onlyUpdateNodes  = true
            msg_guild_war.cg_get_guard_info(false)
        end 
    elseif self.dc:IsAttackPhase() then
        local currTime = system.time()
        if currTime - self.startRefreshTime >= _ATTACK_TIME_INTERVAL then
            self.startRefreshTime = currTime
            self.onlyUpdateNodes  = true
            msg_guild_war.cg_get_attack_info(false)
        end
    end 
end

------------------------------------------------------------

local _Amount ={
    ["1_1"] = {x = -(-640 - (-390)) / 1280, y = (480 - (335)) / 960},
    ["1_2"] = {x = -(-640 - (-66)) / 1280, y = (480 - (271)) / 960},
    ["1_3"] = {x = -(-640 - (-217)) / 1280, y = (480 - (99)) / 960},

    ["2_1"] = {x = (640 + (462)) / 1280, y = (480 - (389)) / 960},
    ["2_2"] = {x = (640 + (640)) / 1280, y = (480 - (225)) / 960},

    ["3_1"] = {x = (640 + (60)) / 1280, y = (480 - (-175)) / 960},
    ["3_2"] = {x = (640 + (501)) / 1280, y = (480 - (-206)) / 960},
}

local _nodeDragAmount = 
{
    [1] = {x = 0.145, y = 0.11},
    [2] = _Amount["1_1"],
    [3] = _Amount["1_1"],
    [4] = _Amount["1_1"],
    [5] = _Amount["1_1"],
    [6] = _Amount["1_3"],
    [7] = _Amount["1_1"],
    [8] = _Amount["1_2"],
    [9] = _Amount["1_2"],
    [10] = _Amount["1_3"],
    [11] = _Amount["1_2"],
    [12] = _Amount["1_2"],

    [13] = {x = 0.855, y = 0.144},
    [14] = _Amount["2_1"],
    [15] = _Amount["2_2"],
    [16] = _Amount["2_2"],
    [17] = _Amount["2_1"],
    [18] = _Amount["2_1"],
    [19] = _Amount["2_1"],
    [20] = _Amount["2_1"],
    [21] = _Amount["2_2"],
    [22] = _Amount["2_1"],
    [23] = _Amount["2_1"],
    [24] = _Amount["2_2"],

    [25] = {x = 0.25, y = 0.77},
    [26] = _Amount["3_1"],
    [27] = _Amount["3_1"],
    [28] = _Amount["3_2"],
    [29] = _Amount["3_1"],
    [30] = _Amount["3_1"],
    [31] = _Amount["3_1"],
    [32] = _Amount["3_2"],
    [33] = _Amount["3_2"],
    [34] = _Amount["3_1"],
    [35] = _Amount["3_1"],
    [36] = _Amount["3_2"],
}

local _GuildWarMapStatus = {
    Big = 1,          --放大版
    Small = 2,        --缩小版
}

function GuildWarMapUI:GetNodeDragAmount(_nodeId)
    if _nodeDragAmount[_nodeId] == nil then
        app.log("error! _nodeId = " .. _nodeId) 
    end
    return _nodeDragAmount[_nodeId]
end

function GuildWarMapUI:on_show_member_progress(t)
    GuildWarMemberProgressUI.Start()
end

function GuildWarMapUI:on_show_leaderboard(t)
    GuildWarLeaderboardUI.Start()
end

function GuildWarMapUI:on_show_award(t)
    GuildWarAwardUI.Start()
end

function GuildWarMapUI:on_show_buff(t)
    GuildWarBuffUI.Start()
end

--[[点击队伍放大显示到相应接点]]
function GuildWarMapUI:show_node_positioin_zoom_in(nodeId)   
    if self.mapStatus ~= _GuildWarMapStatus.Big then
        self:on_map_status_change()
    end 
    local pos = self:GetNodeDragAmount(nodeId)
    self.scrollView:set_drag_amount(pos.x, pos.y, 0)
    --此节点显示光效
    self:ShowChooseEffect(nodeId)
end

function GuildWarMapUI:ShowChooseEffect(nodeId)
    if self.uiMap == nil or self.uiMap[self.mapStatus] == nil then
        return
    end
    local item = self.uiMap[self.mapStatus][nodeId]
    if item == nil then
        return
    end
    if item.cont.objChooseEffect then
        item.cont.objChooseEffect:set_active(false)
        item.cont.objChooseEffect:set_active(true)
    end
end

function GuildWarMapUI:gc_get_my_team_ret()
    if self.uiMap == nil or self.uiMap[self.mapStatus] == nil then
        return
    end
    --先隐藏所有
    for nodeId, item in pairs(self.uiMap[self.mapStatus]) do
        for k, v in pairs(item.cont.team) do 
            v.sp:set_active(false)
        end
    end
    local data = self.dc:GetMyTeamNumber()
    for nodeId, _ in pairs(data) do
        local item = self.uiMap[self.mapStatus][nodeId]
        if item == nil then
            return
        end
        self:UpdateMyTeamFlag(nodeId, item.cont)
    end
end

function GuildWarMapUI:gc_set_node_is_key_result(nodeId)
    if self.uiMap == nil or self.uiMap[self.mapStatus] == nil then
        return
    end
    local item = self.uiMap[self.mapStatus][nodeId]
    if item == nil then
        return
    end
    self:UpdateMassOrder(nodeId, item.cont)
end

function GuildWarMapUI:gc_direct_occupy(result, nodeId)
    if result ~= 0 then
        return
    end
    if self.uiMap == nil or self.uiMap[self.mapStatus] == nil then
        return
    end
    local item = self.uiMap[self.mapStatus][nodeId]
    if item == nil then
        return
    end
    self:UpdateOccupyInfo(nodeId, item.cont)
end

--[[更新地图驻防队伍数量]]
function GuildWarMapUI:UpdateMapSummaryCnt(nodeId)
    if self.uiMap == nil or self.uiMap[self.mapStatus] == nil then
        return
    end
    local item = self.uiMap[self.mapStatus][nodeId]
    if item == nil then
        return
    end
    self:UpdateTeamCnt(nodeId, item.cont)
end

--[[驻防或进攻数据返回]]
function GuildWarMapUI:get_teams_ret(nodeId)
    if self.dc:IsDefencePhase() then
        self:UpdateMapSummaryCnt(nodeId)
    end 
    GuildWarStrongholdUI.Start(nodeId)
end

--[[正常返回/保存队伍数据后返回]]
function GuildWarMapUI:on_close_common_formation_ui(phase)
    --阶段已改变
    if self.dc:IsHavePhaseLimit(phase) then
        return
    end
    if self.dc:IsDefencePhase() then
        self:ShowStrongholdUI()
    elseif self.dc:IsAttackPhase() then
        if self.clickNodeId then
            GuildWarChooseTeamUI.Start(self.clickNodeId, true)
        end
    end
end

--[[关闭/取消/占领失败]]
function GuildWarMapUI:on_open_stronghold_ui()
    --阶段已改变
    if self.dc:IsHavePhaseLimit(ENUM.GuildWarPhase.Attack) then
        return
    end
    self:ShowStrongholdUI()
end

function GuildWarMapUI:on_open_season_ui()
    if self.settingOfPlayer.shouldShowSeasonUI == 1 then
        self.settingOfPlayer.shouldShowSeasonUI = 0
        self:SaveSetting()
        GuildWarSeasonUI.Start()        
    end
end
