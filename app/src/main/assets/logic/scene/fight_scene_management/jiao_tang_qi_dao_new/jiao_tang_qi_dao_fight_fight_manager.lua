JiaoTangQiDaoFightFightManager = Class("JiaoTangQiDaoFightFightManager", FightManager)

function JiaoTangQiDaoFightFightManager:InitData()
	FightManager.InitData(self)
end

function JiaoTangQiDaoFightFightManager.InitInstance()
	FightManager.InitInstance(JiaoTangQiDaoFightFightManager)
	return JiaoTangQiDaoFightFightManager
end

function JiaoTangQiDaoFightFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function JiaoTangQiDaoFightFightManager:GetUIAssetFileList(out_file_list)
	FightManager.GetUIAssetFileList(self, out_file_list)
	
	FightManager.AddPreLoadRes(NewFightUiCount.GetResList(), out_file_list)
end

function JiaoTangQiDaoFightFightManager:LoadUI()
	FightManager.LoadUI(self)
--


	--self.jiaotangqidao_fightui = UiJiaoTangQiDao2:new();
end

function JiaoTangQiDaoFightFightManager:OnLoadHero(entity, camp_flag)
	
        --local hp = entity:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
        --app.log("hp###################"..tostring(hp))
        local flag = g_dataCenter.ChurchBot:getWinOrLast()
                
        if flag then
            
            local campflag = entity:GetCampFlag()
            
            if flag == 1 then
                --设置玩家卡牌的血
                --app.log("setMyHead###################")
                                
                if campflag == g_dataCenter.fight_info.single_friend_flag then
                    local cardinfo = entity:GetCardInfo()
                    
                    local index = cardinfo.index
                    local cur_hp = g_dataCenter.ChurchBot:getMyNextCardHead(index)
                    
                    app.log("cur_hp #####################"..tostring(cur_hp))
                    
                    entity:SetProperty(ENUM.EHeroAttribute.cur_hp, cur_hp)
                end
            else
               --设置机器人卡牌的血
                --app.log("setOtherHead###################")
                if campflag ~= g_dataCenter.fight_info.single_friend_flag then
                    local cardinfo = entity:GetCardInfo()
                    
                    local index = cardinfo.index
                    local cur_hp = g_dataCenter.ChurchBot:getOtherNextCardHead(index)
                    
                    app.log("setOtherHead cur_hp #####################"..tostring(cur_hp))
                    
                    entity:SetProperty(ENUM.EHeroAttribute.cur_hp, cur_hp)
                end
            end
        end
        
        if camp_flag == g_dataCenter.fight_info.single_friend_flag then
            entity:SetDontReborn(true)
            entity:SetAI(104)
	else
	    entity:SetDontReborn(true)

            entity:SetConfig("view_radius", 1000)
            entity:SetConfig("act_radius", 2000)
	    entity:SetAI(100);
	end
end

function JiaoTangQiDaoFightFightManager:OnStart()
	--改变刷怪g表
	FightManager.OnStart(self)
	self:_Start()
end

function JiaoTangQiDaoFightFightManager:popScene()
	self:_UnregistFunc();

	local index = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurIndex();
	local star = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetEnterJiaoTangIndex(index);
	local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero(index);
	local pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurChanllengePos();
	local param = {};
	param[1] = tostring(heroid);
	param[2] = tostring(star);
	param[3] = tostring(pos);
	param[4] = tostring(1);
	local isWin = 1;
	if self.isWin then
		isWin = 0;
	end
        --app.log("333333333333333333333333333333")
	
	SceneManager.PopScene(FightScene)
end

function JiaoTangQiDaoFightFightManager:OnShowFightResultUI()
	--UiBaoWeiCanChangAward.ShowAwardUi({score = self.score})
    self.isWin = FightRecord.IsWin();
    --app.log("isWinisWinisWinisWinisWinisWinisWinisWin"..tostring(self.isWin))
    --local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()
    
    local heroid = g_dataCenter.ChurchBot:getMyCurrentTeam()
        
    --local heroid = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_1);
    
    local findData = g_dataCenter.ChurchBot:getFindRoleData()
    
    local cardhuman = {};
        
    for k,v in pairs(heroid) do
        local cardinfo = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,v);
        table.insert(cardhuman,cardinfo)
    end
    
    local left = {player = g_dataCenter.player, cards = cardhuman};
    
    local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTarPlayerEnemy(findData)
    local enemyid =  findData.playerNumber;
    
    --app.log("enemy_player###########"..table.tostring(enemy_player))
    
    local cardhuman2 = {};
    
    if self.isWin then
        cardhuman2 = findData.vecRoleDataTeam2;
    else
        cardhuman2 = findData.vecRoleDataTeam1;
    end
    
    local otherhuman = {};
    
    --for k,v in pairs(cardhuman2)do
    --    local temphuman = CardHuman:new({number = v.number})
    --    --temphuman:
    --    table.insert(otherhuman,temphuman)
    --end
    
    local temp_package = Package:new();
    
    for k,v in pairs(cardhuman2) do
    
        temp_package:AddCard(ENUM.EPackageType.Hero,v)
    
    end
    
    local tempcardhuman = {}
    
    for k,v in pairs(temp_package.list[ENUM.EPackageType.Hero]) do
        table.insert(tempcardhuman,v)    
    end

    --    
    --app.log("temp_package###########"..table.tostring(temp_package.list))
    local right = {player = enemy_player, cards = tempcardhuman};--cardhuman2};
   
    local settlementData = {left = left,right = right}; 
    
    local fightResult;
    if self.isWin == true then
            fightResult = {isWin = self.isWin,leftCount=1,rightCount=0};
    else
            fightResult = {isWin = self.isWin,leftCount=0,rightCount=1};
    end
    
    g_dataCenter.ChurchBot:setWinOrLast(self.isWin)
    
    local Myherolist = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
    local otherherolist = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_enemy_flag)
    
    if self.isWin then
        g_dataCenter.ChurchBot:setMyNextPlayInfo(Myherolist)
        g_dataCenter.ChurchBot:setBattleNum(1)
    else
        g_dataCenter.ChurchBot:setOtherNextPlayInfo(otherherolist)
        g_dataCenter.ChurchBot:setBattleNum(0)        
    end
    
    local flag = g_dataCenter.ChurchBot:isBattleNext()
    
    --app.log("flag################"..tostring(flag))
    
    if flag > 0 then
            
        local callback = function()
            g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:RestBattle()
        end
        CommonBattle.Start("教堂祈祷", settlementData, fightResult)
        CommonBattle.SetFinishCallback(callback, self);
    else
        local HeroId = g_dataCenter.ChurchBot:getMyTeam1()--g_dataCenter.player:GetTeam(g_dataCenter.ChurchBot:getteamtype(g_dataCenter.ChurchBot:getmyprayIndex()))
        --app.log()
        local HeroId2 = g_dataCenter.ChurchBot:getMyTeam2();--g_dataCenter.player:GetTeam(g_dataCenter.ChurchBot:getteam2type(g_dataCenter.ChurchBot:getmyprayIndex()))
        local tempHeroId = ""
        
        local nstar = g_dataCenter.ChurchBot:getnstar()
                
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
        
        app.log("........tempHeroId##########"..table.tostring(tempHeroId))
        
        local targetplayerinfo = g_dataCenter.ChurchBot:getFindRoleData()
        local posIndex = targetplayerinfo.posIndex
        local myprayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
        
        local param = {}
        param[1] = tempHeroId
        param[2] = tostring(targetplayerinfo.playerGid)
        param[3] = tostring(nstar)
        param[4] = tostring(posIndex)
        param[5] = myprayIndex
        param[6] = tostring(FightScene.GetFightManager():GetFightUseTime())
        param[7] = g_dataCenter.ChurchBot:GetIsAutoFight()
        
        local WinOrLose = 0;
        
        if self.isWin == true then
            WinOrLose = 0
        else
            WinOrLose = 1
        end
               
        msg_activity.cg_leave_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, WinOrLose , param);
    
    end
    
end

function JiaoTangQiDaoFightFightManager:_Start()
	self:_RegistFunc();
	--NewFightUiCount.Start();
        local data = {};
        data.need_pause = true
        FightStartUI.Show(data)

end

function JiaoTangQiDaoFightFightManager:onForcedExit()
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:EndGame(true);    
end

function JiaoTangQiDaoFightFightManager:_RegistFunc()
	self.bindfunc = {};
	self.bindfunc['FightOver'] = Utility.bind_callback(self, self.FightOver);
end

function JiaoTangQiDaoFightFightManager:_UnregistFunc()
	for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end


function JiaoTangQiDaoFightFightManager:OnUiInitFinish()

	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
    local configIsShowStarTip = (cf.is_show_star_tip == 1)
	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)


    GetMainUI():InitTeamCanChange(true,false)

	GetMainUI():InitTimer()

    self:CallFightStart()
end