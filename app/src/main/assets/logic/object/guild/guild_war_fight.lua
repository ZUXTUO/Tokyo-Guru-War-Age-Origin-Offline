
local _UIText = {
    [1] = "此据点无人驻守，[ffa127]%s[-]轻松进入, [ffa127]%s[-]成功占领此据点！",            --玩家名1,  社团名
    [2] = "[ffa127]%s[-]成功击败[0bbdf9]%s[-]",                                              --玩家名1， 玩家名2 
    [3] = "[0bbdf9]%s[-]成功抵挡住了[ffa127]%s[-]的进攻",                                    --玩家名1， 玩家名2 
    [4] = "[ffa127]%s[-]完成最后一击，击败所有守卫, [ffa127]%s[-]成功占领此据点！",          --玩家名1,  社团名
    [5] = "[0bbdf9]%s[-][7acf0f]成功防守住据点[-]",                                          --社团名
    [6] = "%s月%s日",
    [7] = "[[ffa127]%s[-] 对战 [0bbdf9]%s[-]]",
    [8] = "(已解散)",

    [100] = "此据点已经被占领！",
}

function GuildWar:GenerateFightLogString(logs)
    local strs = {}
    local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(system.time())
    local today = year .. month .. day
    local fightGuildsStr = nil

    for _, log in ipairs(logs) do
        local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(log.time)
        local currDay = year .. month .. day
        if log.guardGuildName == "" then
            log.guardGuildName = _UIText[8]
        end
        if log.attackerGuildName == "" then
            log.attackerGuildName = _UIText[8]
        end

        --显示一条
        if fightGuildsStr == nil and currDay == today then
            fightGuildsStr = string.format(_UIText[7], log.attackerGuildName, log.guardGuildName)
            table.insert(strs, fightGuildsStr)
        end
        local tempStr = ""
        if log.guardName == nil or log.guardName == '' then
            tempStr = string.format(_UIText[1], log.attackerName, log.attackerGuildName)
        else 
            if log.isLast == 0 then
                if log.isWin == 1 then
                    tempStr = string.format(_UIText[2], log.attackerName, log.guardName)
                else
                    tempStr = string.format(_UIText[3], log.guardName, log.attackerName)
                end
            --最后一次
            else
                if log.isWin == 1 then
                    tempStr = string.format(_UIText[4], log.attackerName, log.attackerGuildName)
                else
                    tempStr = string.format(_UIText[5], log.guardGuildName)
                end
            end
        end
        local timeStr = string.format("%02d", hour) .. ": " .. string.format("%02d", min)
        table.insert(strs, timeStr .. '  ' .. tempStr)  
    end 
    return table.concat(strs, "\n\n")
end

--[[
    {
        [11-20] = {
            [社团A--社团B] = {},
            [社团C--社团B] = {},
        },
        [11-21] = {
            [社团A--社团B] = {},
            [社团C--社团B] = {},
        },
    }
}]]
function GuildWar:ProcessFightLogs(nodeId, logs)
    table.sort(logs, function(a, b)         
        return a.time > b.time
    end)
    local dateFightLogs = {}
    local dIndex, nIndex = 0, 0
    local logsMap = {}

    for _, log in ipairs(logs) do
        local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(log.time)
        --[10-22]
        local _date = month ..'-' .. day
        --[社团A-社团B]
        local _names = log.attackerGuildName .. '-' .. log.guardGuildName

        if logsMap[_date] == nil then
            logsMap[_date] = {}
            dIndex = dIndex + 1
            --归零
            nIndex = 0
            dateFightLogs[dIndex] = logsMap[_date]
        end       
        if logsMap[_date][_names] == nil then
            logsMap[_date][_names] = {}
            nIndex = nIndex + 1
            dateFightLogs[dIndex][nIndex]= logsMap[_date][_names]
        end        
        table.insert(logsMap[_date][_names], log)
    end

    self.fightLogs = {}
    for _, v in ipairs(dateFightLogs) do 
        local _allContent = {}
        local _title = ""
        --两组对战数据
        for _, _logs in ipairs(v) do
            if _title == "" then
                local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(_logs[1].time)
                _title = string.format(_UIText[6], month, day)
            end
            table.insert(_allContent, self:GenerateFightLogString(_logs))
        end
        table.insert(self.fightLogs, {title = _title, content = table.concat(_allContent, "\n\n")})
    end
end

function GuildWar:GetFightLogCnt()
    return #self.fightLogs
end

function GuildWar:ClearFightLog()
    self.fightLogs = {}
end

function GuildWar:GetFightLogByIndex(index)
    return self.fightLogs[index]
end

----------------------------------------------------------------------------------------------


--[[
    attackNodeId --> 攻打的接点
    myTeamType --> 自己队伍
    defenceTeamInfo -- 据点驻防信息
    fightHeros --> 敌方英雄
]]
local _FightInfoKeys ={
    attackNodeId = 1,
    myTeamType = 2,
    defenceTeamInfo = 3,
    fightHeros = 4,
}

function GuildWar:ClearFightInfo()
    for key, _ in pairs(_FightInfoKeys) do
        self.fightInfo[key] = nil
    end
end

function GuildWar:SetFightInfo(data)
    for key, _ in pairs(_FightInfoKeys) do  
        if data[key] ~= nil then
            self.fightInfo[key] = data[key]
        end
    end
end

function GuildWar:GetFightInfo()
    return self.fightInfo
end

function GuildWar:GetEnemyPlayerInfo()    
    local info = self.fightInfo.defenceTeamInfo
    local temp = {}   
    temp.playerid = info.playerid
	temp.name = info.playerName
	temp.level = info.level
    temp.image = info.image
    return temp
end

--[[战斗开始设置血量]]
function GuildWar:SetFightHeroHp(guardFightHeros)
    self.fightHeroHp = {
        [g_dataCenter.fight_info.single_friend_flag] = {},
        [g_dataCenter.fight_info.single_enemy_flag] = {},    
    }
    --自己
    local myHeros = self:GetMyTeamInfoHerosById(self.fightInfo.myTeamType) 
    local myHeroHp = self.fightHeroHp[g_dataCenter.fight_info.single_friend_flag]
    for k, v in pairs(myHeros) do
        if v.hp == -1 then
            local cardData = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, v.dataid)
            v.hp = cardData:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
        end
        myHeroHp[v.dataid] = v.hp
    end

    --敌人
    local otherHeroHp = self.fightHeroHp[g_dataCenter.fight_info.single_enemy_flag]
    for _, hero in pairs(guardFightHeros) do
        --使用服务器最新hp
        local cardData = CardHuman:new(hero)
        local _hp = cardData:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
        if _hp == -1 then
            _hp = cardData:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
        end
		otherHeroHp[hero.dataid] = _hp
	end
    app.log('===================>self.fightHeroHp = ' .. table.tostring(self.fightHeroHp))
end

--[[获取血量]]
function GuildWar:GetFightHeroHP(flag, index) 
    if self.fightHeroHp[flag] ~= nil then
        return self.fightHeroHp[flag][index]
    end
    return 0
end

--[[游戏中初始血量]]
function GuildWar:GetInitFightHeroHP(index) 
    for k, v in pairs(self.fightHeroHp) do
        if v[index] ~= nil then
            return v[index]
        end
    end
    return nil
end

--[[战斗结束更新血量]]
function GuildWar:SetFightOverHp(_heroHp)
    --app.log('===============>SetFightOverHp ' .. table.tostring(_heroHp))
    for flag, v in pairs(self.fightHeroHp) do
        for kk, vv in pairs(_heroHp[flag] ) do
            v[kk] = vv
        end
    end
end

function GuildWar:GetHeroHpList(flag)
    local list = {}
    for k, v in pairs(self.fightHeroHp[flag]) do
        table.insert(list, {dataid = k, hp = v})
    end
    return list
end

function GuildWar:SetAndBeginGame(attackTeamId, guardFightHeros, _herosPos)    
    --主动清除已有玩家数据
	self:ClearFightPlayer()

	--添加对战玩家
	local temp_player = Player:new()
	local player_info = self:GetEnemyPlayerInfo()	
	temp_player:UpdateData(player_info);

	local temp_package = Package:new();

    local defTeam = {}
    local _teamPos = {}
	for k, hero in ipairs(guardFightHeros) do
		temp_package:AddCard(ENUM.EPackageType.Hero, hero)
        defTeam[k] = hero.dataid
        --布阵位置
        _teamPos[k] = {
            index = hero.dataid,
            pos = _herosPos[k],
        }
	end
	temp_player:SetPackage(temp_package)
    self:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, temp_player, temp_package, EFightPlayerType.human, defTeam, {teamPos = _teamPos, monsterTeamPos = nil}) 
    
    --设置hp
    self:SetFightHeroHp(guardFightHeros)  
    
    --保存敌方英雄数据
    self:SetFightInfo({fightHeros = guardFightHeros})

    --玩家自己
    defTeam = {} 
    _teamPos = {}
    local _myHeros = self:GetMyTeamInfoHerosById(attackTeamId)
    for k, v in pairs(_myHeros) do
        defTeam[k] = v.dataid
        --布阵位置
        _teamPos[k] = {
            index = v.dataid,
            pos = v.pos,
        }
    end
    self:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam, {teamPos = _teamPos, monsterTeamPos = nil})

    local _hurdleId = 60125000
    self:SetLevelIndex(_hurdleId)
    self:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_GuildWar)
    self:BeginGame(nil, {_hurdleId})
end

function GuildWar:EndGame()
	local isWin = 0 
    if FightRecord.IsWin() then
        isWin = 1
    end
    --发送战斗结果
    local myHeroHpList = self:GetHeroHpList(g_dataCenter.fight_info.single_friend_flag)
    local otherHeroHpList = self:GetHeroHpList(g_dataCenter.fight_info.single_enemy_flag)
    app.log('=======================>isWin = ' .. isWin)
    app.log('=======================>myHeroHpList = ' .. table.tostring(myHeroHpList))
    app.log('=======================>otherHeroHpList = ' .. table.tostring(otherHeroHpList))
    msg_guild_war.cg_end_attack(isWin, myHeroHpList, otherHeroHpList)

    --显示结算界面
    self:ShowFightResult()
end

function GuildWar:ShowFightResult()
    local isWin = FightRecord.IsWin()

    local cardHumans = {}  
    local myHeros = self:GetMyTeamInfoHerosById(self.fightInfo.myTeamType) 
    for _, v in pairs(myHeros) do
        local cardData = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, v.dataid)
    local hp = self:GetFightHeroHP(g_dataCenter.fight_info.single_friend_flag, v.dataid)
        cardData:SetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.GuildWar, hp, false)
        table.insert(cardHumans, cardData)
    end
    local left = 
    {
        player = g_dataCenter.player, 
        cards = cardHumans,
        names = {}, 
        hasHp = true,
        hpType = ENUM.RoleCardPlayMethodHPType.GuildWar,
        --teamFight = true
    }
    --敌方
    cardHumans = {} 
    for _, hero in pairs(self.fightInfo.fightHeros) do
        local cardData = CardHuman:new(hero)
        local hp = self:GetFightHeroHP(g_dataCenter.fight_info.single_enemy_flag, hero.index)
        cardData:SetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.GuildWar, hp, false)
        table.insert(cardHumans, cardData)
    end
    local right = 
    {
        player = Player:new(), 
        cards = cardHumans, 
        names = {}, 
        hasHp = true,
        hpType = ENUM.RoleCardPlayMethodHPType.GuildWar,
        --teamFight = true
    }
	right.player:UpdateData(self:GetEnemyPlayerInfo())

    local players = {left = left, right = right}
    local fightResult = {}
    fightResult.isWin = isWin

    CommonBattle.Start("Guild War", players, fightResult, false)
	CommonBattle.SetFinishCallback(FightScene.ExitFightScene);

    --据点被占领, 飘字提示
    local info = self:GetFightInfo()
    if info.attackNodeId then
        if self:IsOccupy(info.attackNodeId) then
            FloatTip.Float(_UIText[100])
        end
    end

    --清理数据
    self:ClearTempMyAttackTeamInfo()
end

function GuildWar:ClearHistoryData()
    --清除战斗数据
    self:ClearFightInfo()
    --进攻临时数据
    self:ClearTempMyAttackTeamInfo()
end