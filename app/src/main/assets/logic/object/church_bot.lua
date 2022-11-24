ChurchBot = Class("ChurchBot");

--local hurdlesid = {60123000, 60123001, 60123002, 60123003, 60123004}

function ChurchBot:Init()
    --self.RefreshTimes = 0;
    self.myPoslist = {};
    --self.findData = {};
    self.myprayIndex = 1;
    self.FightReport = {};
    self.nstar = 1;  --星级
    self.number = 1; --战斗场次
    
    self.MyBattleNum = 2;
    self.OtherBattle = 2;
    self.setfindnumb = 0;
    self.NewBattleTop = false;
    self.isShow = false;

    self.ChurchState = false;  --区域占领状态
    self.guideteam = {};
    
    return self
end

function ChurchBot:setfindnumber(RefreshTimes)
    -- if RefreshTimes > 8 then
    --     RefreshTimes = 8
    -- end

    local cfg = ConfigManager._GetConfigTable(EConfigIndex.t_church_pray_refresh_cost);
    local maxnumb = #cfg

    if RefreshTimes > maxnumb then
        RefreshTimes = maxnumb
    end
    
    self.setfindnumb = RefreshTimes
end

function ChurchBot:set_guideteam(data)
    self.guideteam = data
end

function ChurchBot:get_guideteam()
    return self.guideteam
end

function ChurchBot:getfindnumber()
   return  self.setfindnumb
end

function ChurchBot:getRefreshTimes()
   return  self.RefreshTimes
end


function ChurchBot:getMyPoslistData()
   return self.myPoslist
end

function ChurchBot:SetNewBattle(value)
    self.NewBattleTop = value 
end

function ChurchBot:GetNewBattleTip()
    return self.NewBattleTop
end

function ChurchBot:setMymyPoslist(myPoslist)
    self.myPoslist = myPoslist
end

function ChurchBot:setChurchState( value )
    self.ChurchState = value
end

function ChurchBot:getChurchState()
    return self.ChurchState
end

function ChurchBot:updataMyposlist(myPoslist)
    for k,v in pairs( self.myPoslist ) do
        if v.indexID == myPoslist.indexID then
            v.bUnlock = myPoslist.bUnlock
            v.indexID = myPoslist.indexID
            v.churchStar = myPoslist.churchStar
            v.posIndex = myPoslist.posIndex
            v.prayStartTime = myPoslist.prayStartTime
            v.vecCardGIDTeam1 = myPoslist.vecCardGIDTeam1
            v.vecCardGIDTeam2 =  myPoslist.vecCardGIDTeam2
        end
    end
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_QYZL);
end

function ChurchBot:getAwardUIData(index)
    self.myPoslist[index].churchStar = 0;
end

function ChurchBot:setUnlockPoslistData(index)
    self.myPoslist[index].bUnlock = true
end

function ChurchBot:setRefreshTimes(RefreshTimes)
    self.RefreshTimes = RefreshTimes
end

function ChurchBot:setmyprayIndex( myprayIndex )
   self.myprayIndex = myprayIndex
end

function ChurchBot:getmyprayIndex()
    return self.myprayIndex
end

function ChurchBot:SetFightReport(vecFightRecordData)
    --self.FightReport = vecFightRecordData
    local i = 0;
    for k,v in pairs(vecFightRecordData) do
        local dataid = v.dataid;
        self.FightReport[dataid] = v;
        if not v.bGetVigor then
            i = i+1
        end
    end
    if i > 0 then
        self:SetNewBattle(true)
    else
        self:SetNewBattle(false)
    end
end

function ChurchBot:UpdataFightReport(ntype,FightRecordData)
    if ntype == 0 then --添加
        self.FightReport[FightRecordData.dataid] = FightRecordData;
    elseif ntype == 1 then
        self.FightReport[FightRecordData.dataid] = nil;
    elseif ntype == 2 then
        self.FightReport[FightRecordData.dataid] = FightRecordData
    end

    local i = 0;

    for k,v in pairs(self.FightReport) do
        if not v.bGetVigor then
            i = i+1
        end
    end

    if i > 0 then
        self:SetNewBattle(true)
    else
        self:SetNewBattle(false)
    end
end

function ChurchBot:UpdataFightReportjl(dataid)
    
    --app.log("dataid##########"..table.tostring(dataid));
    for k,v in pairs(dataid) do
        --app.log("vv##########"..tostring(v))
        if self.FightReport[v] then
            self.FightReport[v].bGetVigor = true
        end
    end

    local i = 0;

    for k,v in pairs(self.FightReport) do
        if not v.bGetVigor then
            i = i+1
        end
    end

    if i > 0 then
        self:SetNewBattle(true)
    else
        self:SetNewBattle(false)
    end
    
end
--判断是否解锁 是否已经挂机
function ChurchBot:CheckPosition()
    --判断空位
    local flag = false
    for k,v in pairs(self.myPoslist) do
        if v.bUnlock and v.churchStar == 0 then
            flag = true;
            break;
        end
    end

    if flag then
        local NeedvigorData = ConfigManager.Get(EConfigIndex.t_church_pos_data,1)
        local cos_vigor = NeedvigorData.cos_vigor
        local Havevigor = PropsEnum.GetValue(10)
        if Havevigor >= cos_vigor then
            return true
        else
            return false
        end
    else
        return false
    end
end

function ChurchBot:getFightReport()
   return  self.FightReport
end

function ChurchBot:setnstar(nstar)
    self.nstar = nstar
end

function ChurchBot:setFinishUI(value)
    self.isShow = value
end

function ChurchBot:getFinishUI()
    return self.isShow
end

function ChurchBot:getnstar()
    return  self.nstar
end

function ChurchBot:needlvl()
    local cf = ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao);
    local lvl = g_dataCenter.player.level;
    
    if cf.open_level > lvl then
        return false 
    else
        return true
    end
end

function ChurchBot:setFindRoleData( data )
    self.findData = data
end

function ChurchBot:getFindRoleData()
   return self.findData
end

function ChurchBot:getMyTeam1()
    
    local HeroId = nil

    self.isguide = GuideManager.IsGuideRuning();

    if self.isguide then
        if #self.guideteam > 0 then
            HeroId = self.guideteam
            return HeroId
        end
    end
    
    app.log("myprayIndex--------------1"..tostring(self.myprayIndex))
    
    if self.myprayIndex == 1 then
        HeroId = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_1)
    elseif self.myprayIndex == 2 then
        HeroId = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_1)
    elseif self.myprayIndex == 3 then
        HeroId = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_1)
    elseif self.myprayIndex == 4 then
        HeroId = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_1)
    end
    
    app.log("Team1--------------"..table.tostring(HeroId))
    
    return HeroId
end

function ChurchBot:getMyTeam2()
    local HeroId = nil
    
    app.log("myprayIndex--------------2"..tostring(self.myprayIndex))
    
    if self.myprayIndex == 1 then
        HeroId = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_2)
    elseif self.myprayIndex == 2 then
        HeroId = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_2)
    elseif self.myprayIndex == 3 then
        HeroId = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_2)
    elseif self.myprayIndex == 4 then
        HeroId = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_2)
    end
    
    app.log("Team2--------------"..table.tostring(HeroId))
    
    return HeroId
    
end

function ChurchBot:setMyCurrentTeam(heroid)
    self.MyCurrentTeam = heroid
end

function ChurchBot:getMyCurrentTeam()
    return self.MyCurrentTeam
end

function ChurchBot:setOtherCurrentTeam(heroid)
    self.OtherCurrentTeam = heroid
end

function ChurchBot:getOtherCurrentTeam()
    return self.OtherCurrentTeam
end

function ChurchBot:setBattleNumber( num )
    self.currentBattleNum =  num
end

function ChurchBot:getBattleNumber()
    return self.currentBattleNum
end

function ChurchBot:SavePlayerInfo( info1 , info2)  --如果myplayerinfo 为空 则取下一队
    self.myplayerinfo = info1
    self.otherplayinfo = info2
end

function ChurchBot:getteamtype(index)
    
    local teamtype = nil;
    
    if index == 1 then
        teamtype = ENUM.ETeamType.churchpray1_1
    elseif index == 2 then
        teamtype = ENUM.ETeamType.churchpray2_1
    elseif index == 3 then
        teamtype = ENUM.ETeamType.churchpray3_1
    elseif index == 4 then
        teamtype = ENUM.ETeamType.churchpray4_1
    end
    
    return teamtype
end

function ChurchBot:getteam2type(index)
    
    local teamtype = nil;
    
    if index == 1 then
        teamtype = ENUM.ETeamType.churchpray1_2
    elseif index == 2 then
        teamtype = ENUM.ETeamType.churchpray2_2
    elseif index == 3 then
        teamtype = ENUM.ETeamType.churchpray3_2
    elseif index == 4 then
        teamtype = ENUM.ETeamType.churchpray4_2
    end
    
    return teamtype
end


function ChurchBot:BeginFight()
    
    local HeroId = self:getMyTeam1();
    --app.log("HeroId#################"..table.tostring(HeroId))
    local HeroId2 = self:getMyTeam2();
    --app.log("nstar#################"..tostring(self.nstar))
    if HeroId then
        local tempHeroId = ""
            
        for k,v in pairs(HeroId) do
            if tempHeroId == "" then
                tempHeroId = v
            else
                tempHeroId = tempHeroId..";"..v
            end
        end
        
        
        
        if #HeroId == 1 then
            tempHeroId = tempHeroId..";".."0;0"
        elseif #HeroId == 2 then
            tempHeroId = tempHeroId..";".."0"
        end
        
        if HeroId2 then
        
            for k,v in pairs(HeroId2) do
                tempHeroId = tempHeroId..";"..v    
            end
            
        end
        app.log("#########tempHeroId##########"..table.tostring(tempHeroId))
        
        --do return end
        
        local targetplayerid = self.findData.playerGid--g_dataCenter.player.playerid
        
        local param = { };
        param[1] = tostring(tempHeroID);       --自身队伍 list  playerid
        param[2] = tostring(targetplayerid);   --对手id
        param[3] = tostring(self.nstar);   --几星教堂
        param[4] = tostring(self.findData.posIndex);  --服务器返回的教堂位置
        param[5] = self.myprayIndex       --教堂位置
        param[6] = self:GetIsAutoFight()
        
        --self:setParam(param)
        
        msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, param)
    end
        
end

function ChurchBot:GetIsAutoFight()
	return PublicFunc.GetIsAuto(self:GetHurdleId())
end

function ChurchBot:GetHurdleId()
    return 60108005
end

function ChurchBot:setMyNextPlayInfo(Myherolist)
    
    self.MyNextCardinfo = {}
    self.MyNextCardIndex = {}
    self.MyNextCardHead = {}
    
    for k,v in pairs(Myherolist) do
        local obj = ObjectManager.GetObjectByName(v)
        local hp = obj:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
        if hp > 0 then
        --app.log("setMyNextPlayInfo#####################"..tostring(hp))
            local cardinfo = obj:GetCardInfo()
            local index = cardinfo.index
            --app.log("setMyNextPlayInfo#####################"..tostring(index))
            table.insert(self.MyNextCardinfo,cardinfo)
            table.insert(self.MyNextCardIndex,index)
            self.MyNextCardHead[index] = hp
        end
    end
    
    
end

function ChurchBot:setreward(data)
    self.rewardlist = data 
end

function ChurchBot:getreward()
    return self.rewardlist
end

function ChurchBot:getMyNextCardIndex()
    return self.MyNextCardIndex
end

function ChurchBot:getMyNextCardHead(index)
    return self.MyNextCardHead[index]
end

function ChurchBot:setOtherNextPlayInfo(otherherolist)
    
    self.OtherNextCardinfo = {}
    self.OtherNextCardIndex = {}
    self.OtherNextCardHead = {}
    
    for k,v in pairs(otherherolist) do
        local obj = ObjectManager.GetObjectByName(v)
        local hp = obj:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
        
        --app.log("hp###################"..tostring(hp))
        
        if hp > 0 then
            local cardinfo = obj:GetCardInfo()
            --app.log("setOtherNextPlayInfo#####################"..tostring(hp))
            local index = cardinfo.index
            --app.log("setOtherNextPlayInfo#####################"..tostring(index))
            table.insert(self.OtherNextCardinfo,cardinfo)
            table.insert(self.OtherNextCardIndex,index)
            self.OtherNextCardHead[index] = hp
        end
    end
    
end

function ChurchBot:getOtherNextCardIndex()
   return  self.OtherNextCardIndex
end

function ChurchBot:getOtherNextCardHead(index)
    return self.OtherNextCardHead[index]
end

function ChurchBot:getMyNextCardInfo()
    return self.MyNextCardinfo
end

function ChurchBot:getOtherNextPlayInfo()
    return self.OtherNextCardinfo
end

function ChurchBot:setWinOrLast(data)
    if data == true then
        self.winorlast =  1
    else
        self.winorlast =  2
    end
end

function ChurchBot:getWinOrLast()
   return  self.winorlast
end

function ChurchBot:ClearWinOrLast()
    self.winorlast = nil
    self.MyBattleNum = 2;
    self.OtherBattle = 2;
end

function ChurchBot:setBattleNum( data )
    
    if data == 1 then
        self.OtherBattle = self.OtherBattle - 1
    else
        self.MyBattleNum = self.MyBattleNum - 1
    end
    
    --table.insert(self.BattleNum , data )
end

function ChurchBot:getOtherBattle()
   return  self.OtherBattle
end

function ChurchBot:getMyBattle()
    return self.MyBattleNum
end

function ChurchBot:set_buy_vigor_number(number)
    self.buy_vigor_number = number
end

function ChurchBot:get_buy_vigor_number()
   return  self.buy_vigor_number
end

function ChurchBot:set_last_vigor_time(time)
    self.vigor_time =  time
end

function ChurchBot:get_last_vigor_time()
    return  self.vigor_time
end

function ChurchBot:isBattleNext()
    local myteam = self:getMyTeam2()
    
    if self.nstar > 2 then
        if myteam then
            if #myteam > 0 then
                if #self.findData.vecRoleDataTeam2 > 0 then
                    if self.OtherBattle == 0 or self.MyBattleNum == 0 then
                        return 0
                    else
                        return 1
                    end
                else
                    if self.OtherBattle == 1 or self.MyBattleNum == 0 then
                        return 0
                    else
                        return 1
                    end
                end
            else
                if #self.findData.vecRoleDataTeam2 > 0 then
                    if self.OtherBattle == 0 or self.MyBattleNum == 1 then
                        return 0
                    else
                        return 1
                    end
                else
                    if self.OtherBattle == 1 or self.MyBattleNum == 1 then
                        return 0
                    else
                        return 1
                    end
                end
            end
        else
            if #self.findData.vecRoleDataTeam2 > 0 then
                if self.OtherBattle == 0 or self.MyBattleNum == 1 then
                    return 0
                else
                    return 1
                end
            else
                if self.OtherBattle == 1 or self.MyBattleNum == 1 then
                    return 0
                else
                    return 1
                end
            end
        end
    else
       return 0 
    end
        
       
end
