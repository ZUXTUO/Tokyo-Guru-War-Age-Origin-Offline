
------------------------- 数据对象 ---------------------------
CloneBattle = Class("CloneBattle");

local hurdlesid = {60123000, 60123001, 60123002, 60123003, 60123004}

function CloneBattle:Init()
    self.herolist = { };   --每天的英雄列表
    self.teaminfo = {};    --队伍信息
    self.isCanQuickJoin = true; --是否能快速加入
    self.currentHeroData = 0;
    self.rewardlist = {};
    self.roleDataid = 0;
    self.allrewardlist = {};
    self.leftTime = 0       --剩余次数
    return self
end

function CloneBattle:setHerolist( data )
    self.herolist = data
    
end

function CloneBattle:EndGame(flag)
    self.isForce = flag
end

function CloneBattle:GetIsForce()
    return  self.isForce
end

function CloneBattle:EndGame1(flag)
    self.isForce1 = flag
end

function CloneBattle:GetIsForce1()
    return  self.isForce1
end

function CloneBattle:IsOpen()
    
    --当天是否进入过这个功能
    self.hasEnterUI = PlayerEnterUITimesCurDay.HasEnterUI("CloneBattleUI")
    
    
    local cf = ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_CloneFight);
    local lvl = g_dataCenter.player.level;
    
    if cf.open_level > lvl then
        return false 
    end
    
    --app.log("hasEnterUI###############"..tostring(self.hasEnterUI))
    
    if self.hasEnterUI then
        if self.FinishTimes == 3 then  --本人打完3次
            return false 
        else
            if self.teamMemberCount == 3 then  --三个队友
                return true
            else
                return false 
            end
        end
    else
        return true 
    end
end

function CloneBattle:SetTeamInfo( data)
    self.teaminfo = data
    -- for i,v in pairs(data.SCloneFightMemberInfo) do
    --     if (v.playerid).tonumber == g_dataCenter.player.playerid then
    --         self.leftTime = 3 - v.finishTimes
    --     end
    -- end
    self:setQuickJoin(data.refuseQuickJoin)
    
    local number = 0;
        
    for k,v in pairs(data.members) do
        local id = v.playerid
	local dataid = v.roleCard.dataid
        if id == g_dataCenter.player.playerid then
            self.FinishTimes = v.finishTimes
        end
        
        number = number+1
    end
    
    self.teamMemberCount = number
    
end

function CloneBattle:GetHerolist( )
    return self.herolist
end

function CloneBattle:GetTeamInfo( )
    return self.teaminfo
end

function CloneBattle:setQuickJoin( value )
    self.isCanQuickJoin = value
end

function CloneBattle:GetQuickJoin( )
   return  self.isCanQuickJoin
end

function CloneBattle:Finalize()
    self.herolist = { };
    self.teaminfo = {};
end

function CloneBattle:setCurrentHeroData(data)
    self.currentHeroData = data
end

function CloneBattle:getCurrentHeroData()
   return self.currentHeroData
end

function CloneBattle:setroleDataId(id)
    --self.teaminfo[1]
end

function CloneBattle:setrewardlist(data)
    
    self.rewardlist = data;
    
    for k,v in pairs(data)do
        table.insert(self.allrewardlist ,v)   
    end
  
end

function CloneBattle:getallrewardlist()
   return  self.allrewardlist
end

function  CloneBattle:getrewardlist()
    return self.rewardlist
end

function CloneBattle:SetAllrewardlist()
    self.allrewardlist = {};
end

function  CloneBattle:setroleDataid( id )
    self.roleDataid = id;
    for k,v in pairs(self.teaminfo.members)do
        --app.log("teaminfo#########"..table.tostring(v))
        if v then 
            if v.playerid == g_dataCenter.player.playerid then
                v.roleCard.dataid = id
            end
        end
    end
end

function CloneBattle:setFristBoxReward(data)
    
end

function  CloneBattle:getroleDataid( )
    return self.roleDataid ;
end

function CloneBattle:GetCaptainIndex()
    return self.captainIndex
end

function CloneBattle:BeginFight(monstersid,otherRoles)
    self.challengeMonstersId = monstersid

    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    local fs = FightStartUpInf:new()
    fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_CloneFight)
    fs:SetLevelIndex(hurdlesid[math.random(1, #hurdlesid)])

    --app.log('------------ ' .. table.tostring(self.teaminfo));
    local memPlayer = Player:new()
    memPlayer:UpdateData({playerid = g_dataCenter.player:GetGID()})
    local pkg = Package:new()
    memPlayer:SetPackage(pkg)
    local team = {}
    for i=1,3 do
        local mem = self.teaminfo.members[i]
        
        if mem ~= nil and mem.playerid ~= nil and string.len(mem.playerid) > 1 then
            local memPlayer = Player:new()
            if mem.playerid == g_dataCenter.player:GetGID() then
                pkg:AddCardInst(ENUM.EPackageType.Hero, g_dataCenter.package:find_card(ENUM.EPackageType.Hero, mem.roleCard.dataid))
                self.captainIndex = i
            else
                -- for k,v in pairs(mem.equipData) do
                --     pkg:AddCard(ENUM.EPackageType.Equipment, v)
                -- end
                --pkg:AddCard(ENUM.EPackageType.Hero, mem.roleCard)                
            end
            table.insert(team, mem.roleCard.dataid)
            -- fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, memPlayer, nil,EFightPlayerType.human, {mem.roleCard.dataid} )
        else
            break;
        end
    end
    
    for k,v in pairs(otherRoles)do
        pkg:AddCard(ENUM.EPackageType.Hero, v)
    end
    
    fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, memPlayer, nil,EFightPlayerType.human, team)

    SceneManager.PushScene(FightScene,fs)
end

function CloneBattle:GetChallengeMonstersId()
    return self.challengeMonstersId
end

function CloneBattle:GetMemberAverageLevel()
    local avgLevel = 1
    if self.teaminfo then

        local sum = 0
        local count = 0

        for k,v in ipairs(self.teaminfo.members) do 
            if string.len(v.playerid) > 1 then
                sum = sum + v.level
                count = count + 1
            end
        end

        avgLevel = math.floor( sum / count )
    end

    return avgLevel
end

function CloneBattle:CloneFristData(FinishTimes,teamMemberCount)
    if FinishTimes > 0 then   --FinishTimes 为-1 则为还没有开始克隆战
        self.FinishTimes =  FinishTimes
        self.teamMemberCount = teamMemberCount
    end
end

--判断能否加入
function CloneBattle:IsJoinThisGame()
    --t_play_vs_data  60054028
    local Lvl = g_dataCenter.player.level
    local Data = ConfigManager.Get(EConfigIndex.t_play_vs_data,60054028);
    if Data.open_level <= Lvl then
        return true
    else
        return false 
    end
end
