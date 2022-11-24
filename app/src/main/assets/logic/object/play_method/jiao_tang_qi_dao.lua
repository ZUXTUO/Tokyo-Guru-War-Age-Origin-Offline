JiaoTangQiDao = Class("JiaoTangQiDao",PlayMethodBase)

function JiaoTangQiDao:Init(data)
	self:ClearData(data);
	self:initData(data);
end

function JiaoTangQiDao:initData(data)
	self.posInfo = {};
	for i=1,5 do
		self.posInfo[i] = {};
	end

	self.heroID = {};       --当前正在祈祷的英雄id
	self.heroID[1] = nil;
	self.heroID[2] = nil;

	self.curJiaoTangIndex = {};   --正在祈祷哪一个教堂
	self.curJiaoTangIndex[1] = nil;
	self.curJiaoTangIndex[2] = nil;
        self.curJiaoTangIndex[3] = nil;
        self.curJiaoTangIndex[4] = nil;

	self.enterJiaoTangIndex = nil;   --当前进入的教堂index

	self.openLevel = {};
	self.openLevel[1] = ConfigManager.Get(EConfigIndex.t_church_pray_open,1).level;
	self.openLevel[2] = ConfigManager.Get(EConfigIndex.t_church_pray_open,2).level;
        
        self.openLevel[3] = ConfigManager.Get(EConfigIndex.t_church_pray_open,1).level;
        
        self.openLevel[4] = ConfigManager.Get(EConfigIndex.t_church_pray_open,1).level;

	self.isPray = {};
	self.isPray[1] = false;
	self.isPray[2] = false;

	self.curIndex = 1;     --当前选择的栏位

	self.leftTime = {};
	self.yesterdayExp = {};
	self.churchPosIndex = {};

	self.buyChallengeTimes = 0;
	self.thirdPartChallengeTimes = 0;

	self.prayKeepTime = {};

	self.nameAndPos = {};
	self.fightReport = {};

	self.have_people = {};
	for i=1,5 do
		self.have_people[i] = 0;
	end
end

--设置所有教堂人数现状
function JiaoTangQiDao:SetAllChurchInfo(vecPrayCnt)
	for k,v in pairs(vecPrayCnt) do
		self.have_people[k] = v;
	end
end

--得到star教堂当前有多少个人
function JiaoTangQiDao:GetAllChurchInfo(star)
	return self.have_people[star];
end

--得到n星教堂所有玩家信息
function JiaoTangQiDao:GetAllPositionInfo(n)
    return self.posInfo[n];
end

--得到n星教堂某一个位置玩家信息
function JiaoTangQiDao:GetHeroInfo(n,pos)
	if not self.posInfo or not self.posInfo[n] then
		return nil;
	end
	return self.posInfo[n][pos];
end

--设置n星教堂所有玩家信息
function JiaoTangQiDao:SetAllPositionInfo(n,info)
	self.posInfo = {};
	for i=1,5 do
		self.posInfo[i] = {};
	end
	local i = 0;
	for k,v in pairs(info) do
		if v.roleData.number ~= 0 then
			local inf = v;
			--app.log("v=="..table.tostring(v));
			if n == 1 then
				i = i + 1;
			else
				i = inf.posIndex;
			end
			local temp_player = Player:new();
			local player_info = {};
			player_info.playerid = inf.playerGid;
			player_info.name = inf.szPlayerName;
			player_info.vip = inf.vipLevel;
			player_info.level = inf.playerLevel or 1;
			player_info.country_id = inf.countryid  or 1;
			-- app.log("country_id==="..inf.countryid.."  name=="..inf.szPlayerName);
			local hero_id = inf.cardGID;
			local card_number = inf.cardIndex;
			temp_player:UpdateData(player_info);
			temp_player:AddTeam(0,1,hero_id);
			local temp_package = Package:new();
			temp_package:AddCard(ENUM.EPackageType.Hero, inf.roleData);
			for m,n in pairs(inf.vecCardsEquip) do
		        temp_package:AddCard(ENUM.EPackageType.Equipment,n);
			end
			temp_package:CalAllHeroProperty();
			temp_player:SetPackage(temp_package);
			local other_data = {};
			other_data.protectTime = inf.protectTime;
			other_data.leftTime = inf.leftTime;
			other_data.isFighting = inf.isFighting;
			other_data.isDetailInfo = true;
			other_data.guildName = inf.guildName;   --公会名字
			temp_player:SetOtherPlayerData(other_data);
			self.posInfo[n][i] = temp_player;
		else
			app.log("JiaoTangQiDao:SetAllPositionInfo    k=="..k.."英雄编号为0，请检查机器人配置");
		end
	end
end

--检测教堂是否有空位
function JiaoTangQiDao:CheckVacancy(star)
	local have_Vacancy = false;
	local levelIndex = ConfigManager.Get(EConfigIndex.t_jiao_tang_qi_dao_hurdle,star).level;
	local cfg = ConfigHelper.GetMapInf(levelIndex,EMapInfType.burchhero)
	local length = #cfg - 2;
	if star == 1 then
		have_Vacancy = true;
	else
		for i=0,length do
			if not self.posInfo[star][i] then
				have_Vacancy = true;
				break;
			end
		end
	end
	return have_Vacancy;
end

--寻找教堂中最好的挂机位置
function JiaoTangQiDao:FindBestPosition(star)
	local pos;
	if star == 1 then
		pos = 1;
	else
		if not self.posInfo[star][0] then
			pos = 0;
		else
			local levelIndex = ConfigManager.Get(EConfigIndex.t_jiao_tang_qi_dao_hurdle,star).level;
			local cfg = ConfigHelper.GetMapInf(levelIndex,EMapInfType.burchhero)
			local length = #cfg - 2;
			for i=1,length do
				if not self.posInfo[star][i] then
					pos = i;
					break;
				end
			end
		end
	end
	return pos;
end

--设置n星教堂某一个位置玩家信息
function JiaoTangQiDao:SetHeroInfo(star,pos,roleData, equipData)
	local temp_player = self.posInfo[star][pos];
	local temp_package = Package:new();
	temp_package:AddCard(ENUM.EPackageType.Hero, roleData);
	for k,v in pairs(equipData) do
        temp_package:AddCard(ENUM.EPackageType.Equipment,v);
	end
	temp_package:CalAllHeroProperty();
	temp_player:SetPackage(temp_package);
	temp_player.otherData.isDetailInfo = true;
	self.posInfo[star][pos] = temp_player;
end

--删除n星教堂某一位置玩家
function JiaoTangQiDao:DelHeroInfo(nstar, posIndex, cardgid)
	self.posInfo[nstar][posIndex] = nil;
end

--增加n星教堂某一位置玩家
function JiaoTangQiDao:AddHeroInfo(nstar, posIndex, roledata)
	local n = nstar;
	if nstar == 1 then
		app.log("1星教堂不添加人")
		return
	end
	--app.log("roledata=="..table.tostring(roledata));
	local inf = roledata;
	local pos = posIndex;
	local temp_player = Player:new();
	local player_info = {};
	player_info.playerid = inf.playerGid;
	player_info.name = inf.szPlayerName;
	player_info.vip = inf.vipLevel;
	player_info.level = inf.playerLevel or 1;
	player_info.country_id = inf.countryid or 1;
	local hero_id = inf.cardGID;
	local card_number = inf.cardIndex;
	temp_player:UpdateData(player_info);
	temp_player:AddTeam(0,1,hero_id);
	--local temp_package = Package:new();
	--temp_package:AddCard(ENUM.EPackageType.Hero, {dataid = hero_id,number = card_number});
	local temp_package = Package:new();
	temp_package:AddCard(ENUM.EPackageType.Hero, inf.roleData);
	for m,n in pairs(inf.vecCardsEquip) do
        temp_package:AddCard(ENUM.EPackageType.Equipment,n);
	end
	temp_package:CalAllHeroProperty();

	temp_player:SetPackage(temp_package);
	local other_data = {};
	other_data.protectTime = inf.protectTime;
	other_data.leftTime = inf.leftTime;
	other_data.isFighting = inf.isFighting;
	other_data.guildName = inf.guildName;
	other_data.isDetailInfo = true;
	temp_player:SetOtherPlayerData(other_data);
	self.posInfo[n][pos] = temp_player;
end

function JiaoTangQiDao:SetInfoByName(star,pos,name)
	self.nameAndPos[name] = {};
	self.nameAndPos[name].star = star;
	self.nameAndPos[name].pos = pos;
	--app.log("star=="..star.."pos=="..pos.."name=="..name);
	if self.posInfo[star][pos] then
		self.posInfo[star][pos].otherData.heroName = name;
	end
end

function JiaoTangQiDao:GetInfoByName(name)
	return self.nameAndPos[name];
end

--设置当前祈祷英雄id
function JiaoTangQiDao:SetQidaoHero(index,id)
	self.heroID[index] = id;
end

--得到当前祈祷英雄id
function JiaoTangQiDao:GetQidaoHero(index)
	return self.heroID[index];
end

--设置临时选择的祈祷英雄
function JiaoTangQiDao:SetTempChoseHero(id)
	self.tempHeroID = id;
end

--得到临时选择的祈祷英雄
function JiaoTangQiDao:GetTempChoseHero()
	return self.tempHeroID;
end

--设置当前祈祷教堂index
function JiaoTangQiDao:SetCurJiaoTangIndex(heroIndex,jiaotangIndex)
	self.curJiaoTangIndex[heroIndex] = jiaotangIndex;
end

function JiaoTangQiDao:GetCurJiaoTangIndex(heroIndex)
	return self.curJiaoTangIndex[heroIndex];
end

--设置进入的教堂index
function JiaoTangQiDao:SetEnterJiaoTangIndex(jiaotangIndex)
	self.enterJiaoTangIndex = jiaotangIndex;
end

function JiaoTangQiDao:GetEnterJiaoTangIndex()
	return self.enterJiaoTangIndex;
end

-- function JiaoTangQiDao:IsOpen(index)
--     -- 玩法限制作弊 (教堂挂机 -- 等级)
--     if g_dataCenter.gmCheat:noPlayLimit() then
--         return true
--     end

-- 	if g_dataCenter.player.level < self.openLevel[index] then
-- 		return false;
-- 	else
-- 		return true;
-- 	end
-- end

--function JiaoTangQiDao:IsOpen()
	--do return false; end;
	--
	--local level = g_dataCenter.player.level;
	--local activity_id = MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao;
	--local open_level = ConfigManager.Get(EConfigIndex.t_play_vs_data,activity_id).open_level;
	--if level < open_level then
	--	return false;
	--end
	--if self.isPray[1] == true then
	--	return false;
	--else
	--	if self.leftTime[1] == nil or self.leftTime[1] <= 0 then
	--		return false;
	--	else
	--		return true
	--	end
	--end
--        self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
--        
--        if self.PoslistData then
--        
--            for i=1,4 do
--                local lasttime = self.PoslistData[i].prayStartTime
--                local nstar = self.PoslistData[i].churchStar
--                local nowtime = system.time()
--                local casttime = nowtime - lasttime
--                if nstar > 0 then
--                    local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nstar).canPrayTime;
--                    local shengyutime = needtime - casttime
--                    if shengyutime < 0 then
--                        return true
--                    end
--                end          
--            end
--            
--            return false
--        else
--            return false 
--        end
--end

function JiaoTangQiDao:checkIsFinish()
    
    local level = g_dataCenter.player.level;
    local activity_id = MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao;
    local open_level = ConfigManager.Get(EConfigIndex.t_play_vs_data,activity_id).open_level;
    if level < open_level then
            return false;
    end
    
    self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    
    if self.PoslistData then
    
        for i=1,4 do
            local lasttime = self.PoslistData[i].prayStartTime
            local nstar = self.PoslistData[i].churchStar
            local nowtime = system.time()
            local casttime = nowtime - lasttime
            if nstar > 0 then
                local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nstar).canPrayTime;
                local shengyutime = needtime - casttime
                if shengyutime < 0 then
                    return true
                end
            end          
        end
        
        return false
    else
        return false 
    end
end

function JiaoTangQiDao:CheckFininshTime()
    
    local time = self:GetFininshTime()
    
    if self:checkIsFinish() then
    		--app.log("finish------------------------------")
            return true;
    else
            return false;
    end
end

function JiaoTangQiDaoTimeOver()
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Time,Gt_Enum.EMain_Challenge_QYZL);
end

function JiaoTangQiDao:GetFininshTime()
    
    local shengyutimelist = {};
    
    local minitime = 0;
    
    self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    	
    if self.PoslistData then
        for i=1,4 do
        	if self.PoslistData[i] then
	            local lasttime = self.PoslistData[i].prayStartTime
	            local nstar = self.PoslistData[i].churchStar
	            local nowtime = system.time()
	            local casttime = nowtime - lasttime
	            if nstar > 0 then
	                local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nstar).canPrayTime;
	                local shengyutime = needtime - casttime
	                table.insert(shengyutimelist,shengyutime)
	            end
	        end     
        end
    end
        
    local sortFunc = function(a,b)
        if a < b then
            return true
        else
            return false 
        end
    end
        
    --排序处理
    table.sort(shengyutimelist,sortFunc);
    
    if #shengyutimelist > 0 then
        minitime = shengyutimelist[1]
    end
    
    return minitime
end

function JiaoTangQiDao:SetOpenLevel(index,level)
	self.openLevel[index] = level;
end

function JiaoTangQiDao:GetOpenLevel(index)
	return self.openLevel[index];
end

function JiaoTangQiDao:SetIsPray(index,isPray)
	self.isPray[index] = isPray;
end

function JiaoTangQiDao:GetIsPray(index)
	return self.isPray[index];
end

function JiaoTangQiDao:SetCurIndex(index)
	self.curIndex = index;
end

function JiaoTangQiDao:GetCurIndex()
	return self.curIndex;
end

function JiaoTangQiDao:SetBaseInfo(myPoslist)
	self.expPool = {};
	self.heroID = {};
	self.curJiaoTangIndex = {};
	self.leftTime = {};
	self.yesterdayExp = {};
	self.churchPosIndex = {};
	self.prayKeepTime = {};
	self.expPool = {};
	for k,v in pairs(myPoslist) do
		--app.log("................."..table.tostring(v));
		local indexID = v.indexID;
		self.heroID[indexID] = v.cardGID;
		self.curJiaoTangIndex[indexID] = v.churchStar;
		if v.churchStar and v.churchStar ~= 0 then
			self.isPray[indexID] = true;
		else
			self.isPray[indexID] = false;
		end
		self.leftTime[indexID] = v.leftTime or 0;
		self.yesterdayExp[indexID] = 0;
		self.churchPosIndex[indexID] = v.churchPosIndex;
		self.prayKeepTime[indexID] = tonumber(v.prayKeepTime);
		self.expPool[indexID] = tonumber(v.expPool);
	end
end

function JiaoTangQiDao:GetChurchPosIndex(indexID)
	if self.churchPosIndex[indexID] == nil then
		app.log("indexID=="..tostring(indexID).."栏位没有祈祷的位置");
	end
	return self.churchPosIndex[indexID];
end

function JiaoTangQiDao:GetPrayKeepTime(index)
	return self.prayKeepTime[index];
end

function JiaoTangQiDao:GetLeftTime(index)
	return self.leftTime[index];
end

function JiaoTangQiDao:GetTotalExp(index)
	local star = self:GetCurJiaoTangIndex(index);
	local level = g_dataCenter.player.level;
	local exp_boos;
	if star ~= 1 then
		exp_boos = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["boss_exp_reward"..tostring(star)];
	end
	local exp_normal = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(star)];
	local exp = nil;
	--boss位置
	if star == 0 then
		exp = self.expPool[index] + self.yesterdayExp[index];
	elseif star ~= 1 and self.churchPosIndex[index] == 0 then
		local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(self.prayKeepTime[index])
		exp = math.floor(tonumber(self.yesterdayExp[index]) + self.prayKeepTime[index]*(exp_boos)/3600);
	--其他位置
	else
		exp = math.floor(tonumber(self.yesterdayExp[index]) + self.prayKeepTime[index]*exp_normal/3600);
	end
	return exp;
end

function JiaoTangQiDao:SetBuyChallengeTimes(buyChallengeTimes)
	self.buyChallengeTimes = buyChallengeTimes;
end

function JiaoTangQiDao:GetBuyChallengeTimes()
	return self.buyChallengeTimes;
end

function JiaoTangQiDao:SetThirdPartChallengeTimes(thirdPartChallengeTimes)
	self.thirdPartChallengeTimes = thirdPartChallengeTimes;
end

--设置自己教堂祈祷数据
function JiaoTangQiDao:SetMychurchpraydata()
    
end

function JiaoTangQiDao:GetThirdPartChallengeTimes()
	return self.thirdPartChallengeTimes;
end

function JiaoTangQiDao:GetNumber()
	local number = g_dataCenter.player:GetFlagHelper():GetStringFlag(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao);
	number = number or "d=0";
	self.challengeNumber = PublicFunc.GetActivityCont(number,"d");

    -- 玩法限制作弊 (教堂挂机 -- 最大开启次数)
    if g_dataCenter.gmCheat:noPlayLimit() then
        return 0
    end

	return self.challengeNumber;
end

--设置当前操作的角色的名字
function JiaoTangQiDao:SetSelfName(name)
	self.selfName = name;
end

function JiaoTangQiDao:GetSelfName()
	return self.selfName;
end

function JiaoTangQiDao:SetCurChanllengePos(pos)
	self.curChanllengePos = pos;
end

function JiaoTangQiDao:GetCurChanllengePos()
	return self.curChanllengePos;
end

--设置战报信息
function JiaoTangQiDao:SetFightReport(vecFightRecordData)
	self.fightReport = {};
	for k,v in pairs(vecFightRecordData) do
		local dataid = v.dataid;
		self.fightReport[dataid] = v;
	end
end

function JiaoTangQiDao:GetFightReport()
	return self.fightReport
end

--增加一条战报0添加，1删除
function JiaoTangQiDao:UpdateFightReport(ntype, FightRecordData)
	if ntype == 0 then --添加
		self.fightReport[FightRecordData.dataid] = FightRecordData;
	else
		self.fightReport[FightRecordData.dataid] = nil;
	end
end

function JiaoTangQiDao:EndGame(flag)
	--app.log("EndGame============="..tostring(flag))
    self.isForce = flag

    local targetplayerinfo = g_dataCenter.ChurchBot:getFindRoleData()
    local posIndex = targetplayerinfo.posIndex
    local myprayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
    local nstar = g_dataCenter.ChurchBot:getnstar()

    local param = {}
    param[1] = tempHeroId
    param[2] = tostring(targetplayerinfo.playerGid)
    param[3] = tostring(nstar)
    param[4] = tostring(posIndex)
    param[5] = myprayIndex
    param[6] = tostring(FightScene.GetFightManager():GetFightUseTime())
    param[7] = g_dataCenter.ChurchBot:GetIsAutoFight()
    
    local WinOrLose = 1;
    
    
       
    msg_activity.cg_leave_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, WinOrLose , param);

end

--------------------------继承函数--------------------------------
function JiaoTangQiDao:GameResult(isWin,awards,param)
		g_dataCenter.ChurchBot:setChurchState(false)
        --清除战斗标签
        g_dataCenter.ChurchBot:ClearWinOrLast()
        
        if self.isForce then
        	--app.log("ExitFightScene")
	    	FightScene.ExitFightScene()
            self.isForce = false
        else
            local callback = function()
                SceneManager.PopScene()
                --ChurchBotTip:DestroyUi()
            end 
            
            local callback1 = function()
                --app.log("CommonAward#################")
                CommonAward.Start(awards,CommonAwardEType.occupySuc)
                CommonAward.SetFinishCallback(callback,nil)    
            end
                  
            if isWin == 1 then
                --app.log("11111111111111111111111111111")
                CommonLeave.Start({ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipLevelUp, ENUM.ELeaveType.HeroEgg})
                CommonLeave.SetFinishCallback(callback,nil)
            else
                --app.log("22222222222222222222222222222")
                CommonKuikuliyaWinUI.Start();
                CommonKuikuliyaWinUI.SetEndCallback(callback1,nil)
            end
        end
end

function JiaoTangQiDao:BeginGame(result,cf)
	PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single;
	local findData = g_dataCenter.ChurchBot:getFindRoleData()

	local nStar = g_dataCenter.ChurchBot:getnstar();--self:GetEnterJiaoTangIndex(index);
	
        local prayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
        
        local heroid1 = {}
        
        --app.log("prayIndex###############"..tostring(prayIndex))
        
        if prayIndex == 1 then
            --app.log("11111111111111111111111111111111111111111111111111111111")
            heroid1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_1);
        elseif prayIndex == 2 then
            --app.log("22222222222222222222222222222222222222222222222222222222")
            heroid1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_1);
        elseif prayIndex == 3 then
            --app.log("33333333333333333333333333333333333333333333333333333333")
            heroid1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_1);
        elseif prayIndex == 4 then
            --app.log("44444444444444444444444444444444444444444444444444444444")
            heroid1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_1);
        end
        
        local heroid2 = {}
        
        if prayIndex == 1 then
            heroid2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_2);
        elseif prayIndex == 2 then
            heroid2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_2);
        elseif prayIndex == 3 then
            heroid2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_2);
        elseif prayIndex == 4 then
            heroid2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_2);
        end
        
        
        --app.log("heroid##############"..table.tostring(heroid1))
        
	if result == MsgEnum.error_code.error_code_success then
            
            --self:set_fs(fs)
                        
            local hurdle_id = g_dataCenter.ChurchBot:GetHurdleId()--ConfigManager.Get(EConfigIndex.t_jiao_tang_qi_dao_hurdle,0).level;
            self:SetLevelIndex(hurdle_id);
            
            --app.log("heroid1################"..table.tostring(heroid1))

            --引导
            -- self.isguide = GuideManager.IsGuideRuning();
            -- if self.isguide then
            -- 	heroid1 = g_dataCenter.ChurchBot:get_guideteam()
            -- end 
                        
            self:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, heroid1);
            
            g_dataCenter.ChurchBot:setMyCurrentTeam(heroid1)
            --local enemy_player = g_dataCenter.player--self:GetHeroInfo(star,pos);
            local enemy_player = self:GetTarPlayerEnemy(findData)

            local defTeam1 = findData.vecRoleDataTeam1
            
            local defTeam2 = findData.vecRoleDataTeam2
            
            local defTeam = {}
            
            for k,v in pairs(defTeam1) do
                table.insert(defTeam,v.dataid)
            end
                        
            self:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, enemy_player, enemy_player.package, EFightPlayerType.human, defTeam);
            
            g_dataCenter.ChurchBot:setOtherCurrentTeam(defTeam)
            
            self:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao);
            --self:SetCurChanllengePos(pos);
            SceneManager.PushScene(FightScene,self.fs);
            AudioManager.Stop(nil, true);
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight)

            --end
	else
	    PublicFunc.GetErrorString( result, true );
	end
end

function JiaoTangQiDao:RestBattle()
	
        PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single;
        
        local fs = FightStartUpInf:new()
        
	local findData = g_dataCenter.ChurchBot:getFindRoleData()

	local nStar = g_dataCenter.ChurchBot:getnstar();--self:GetEnterJiaoTangIndex(index);
	
        local prayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
        
        local heroid1 = {}
                
        if prayIndex == 1 then
            --app.log("11111111111111111111111111111111111111111111111111111111")
            heroid1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_1);
        elseif prayIndex == 2 then
            --app.log("22222222222222222222222222222222222222222222222222222222")
            heroid1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_1);
        elseif prayIndex == 3 then
            --app.log("33333333333333333333333333333333333333333333333333333333")
            heroid1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_1);
        elseif prayIndex == 4 then
            --app.log("44444444444444444444444444444444444444444444444444444444")
            heroid1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_1);
        end
        
        local heroid2 = {}
        
        if prayIndex == 1 then
            heroid2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_2);
        elseif prayIndex == 2 then
            heroid2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_2);
        elseif prayIndex == 3 then
            heroid2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_2);
        elseif prayIndex == 4 then
            heroid2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_2);
        end
        
        
        --app.log("heroid##############"..table.tostring(heroid1))
                                
        local hurdle_id = g_dataCenter.ChurchBot:GetHurdleId()--ConfigManager.Get(EConfigIndex.t_jiao_tang_qi_dao_hurdle,0).level;
        fs:SetLevelIndex(hurdle_id);
        
        local isWin = g_dataCenter.ChurchBot:getWinOrLast()
        
        if isWin == 1 then
            
            local heroid11 = g_dataCenter.ChurchBot:getMyNextCardIndex()
            --app.log("heroid11!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"..table.tostring(heroid11))--
            fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, heroid11);
            g_dataCenter.ChurchBot:setMyCurrentTeam(heroid11)
        else
            fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, heroid2);
            g_dataCenter.ChurchBot:setMyCurrentTeam(heroid2)
        end
        
        --local enemy_player = g_dataCenter.player--self:GetHeroInfo(star,pos);
        --local enemy_player = self:GetTarPlayerEnemy2(findData)
        
        local defTeam1 = findData.vecRoleDataTeam1
        
        local defTeam2 = findData.vecRoleDataTeam2
        
        local defTeam = {}
        
        if isWin == 1 then
            for k,v in pairs(defTeam2) do
                table.insert(defTeam,v.dataid)
            end
            local enemy_player = self:GetTarPlayerEnemy2(findData)
            fs:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, enemy_player, enemy_player.package, EFightPlayerType.human, defTeam);
            g_dataCenter.ChurchBot:setOtherCurrentTeam(defTeam)
        else
            --for k,v in pairs(defTeam1) do
            --    table.insert(defTeam,v.dataid)
            --end
            --
            --self:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, enemy_player, enemy_player.package, EFightPlayerType.human, defTeam);\
            local Otherplayerinfo = g_dataCenter.ChurchBot:getOtherNextCardIndex()
            local enemy_player = self:GetTarPlayerEnemy(findData)
            fs:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, enemy_player, enemy_player.package, EFightPlayerType.human, Otherplayerinfo)            
            --app.log("OTHER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            g_dataCenter.ChurchBot:setOtherCurrentTeam(Otherplayerinfo)
        end
        
        fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao);
        --app.log("########################"..table.tostring(self.fs))
        SceneManager.ReplaceScene(FightScene,fs);
        AudioManager.Stop(nil, true);
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight)
end

function JiaoTangQiDao:GetTarPlayerEnemy(data)
    
    local temp_player = Player:new();
    local player_info = {};
    player_info.playerid = data.playerGid;
    player_info.name = data.szPlayerName;
    player_info.vip = data.vipLevel;
    player_info.level = data.playerLevel or 1;
    player_info.country_id = data.countryid  or 1;
    player_info.image = data.playerNumber or 0;
    -- app.log("country_id==="..inf.countryid.."  name=="..inf.szPlayerName);
    ---player_info.image = data.playerNumber or 0;
    
    temp_player:UpdateData(player_info);
    
    local temp_package = Package:new();
    temp_player:SetPackage(temp_package);
    
    
    local mem = data.vecRoleDataTeam1
    
    for k,v in pairs(mem) do
    
        temp_package:AddCard(ENUM.EPackageType.Hero,v)

    end
    
        
    local other_data = {};
    
    other_data.guildName = data.guildName;   --公会名字
    temp_player:SetOtherPlayerData(other_data);
        
    return temp_player
end

function JiaoTangQiDao:GetTarPlayerEnemy2(data)
    
    local temp_player = Player:new();
    local player_info = {};
    player_info.playerid = data.playerGid;
    player_info.name = data.szPlayerName;
    player_info.vip = data.vipLevel;
    player_info.level = data.playerLevel or 1;
    player_info.country_id = data.countryid  or 1;
    player_info.image = data.playerNumber or 0;
    -- app.log("country_id==="..inf.countryid.."  name=="..inf.szPlayerName);
    player_info.image = data.playerNumber or 0;
    
    temp_player:UpdateData(player_info);
    
    local temp_package = Package:new();
    temp_player:SetPackage(temp_package);
    
    
    local mem = data.vecRoleDataTeam2
    
    for k,v in pairs(mem) do
    
        temp_package:AddCard(ENUM.EPackageType.Hero,v)

    end
    
        
    local other_data = {};
    
    other_data.guildName = data.guildName;   --公会名字
    temp_player:SetOtherPlayerData(other_data);
        
    return temp_player
end

function JiaoTangQiDao:IsOpen()
    
    self.PoslistData =  g_dataCenter.ChurchBot:getMyPoslistData()
    
    --app.log("self.PoslistData############"..table.tostring(self.PoslistData))
    
    for k,v in pairs(self.PoslistData) do
    
        local lasttime = v.prayStartTime
        local nstar = v.churchStar
        local nowtime = system.time()
        local casttime = nowtime - lasttime
        
        if nstar > 0 then
            local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nstar).canPrayTime;
            local shengyutime = needtime - casttime
            
            if shengyutime > 0 then
                return false
            else
                return true 
            end
        end    
    end
    
   return false 
end
