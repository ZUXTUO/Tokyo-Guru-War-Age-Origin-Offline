GuideTipFuncs = GuideTipFuncs or { }
-- 活动
function GuideTipFuncs.MainUIActivitybtnTip()
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Activity) then
		return false
	end
	--[[
	1、	升级奖励分页					达到等级后有奖励未领取	没有可领取的奖励
	2、充值福利（月卡）分页	没有月卡的玩家每次重新登陆时都出现；有月卡的不出现	玩家登陆后点击一次就消失
	3、登陆送礼分页	玩家有奖励未领取	没有可领取的奖励
    4、闯关活动分页	玩家有奖励未领取	没有可领取的奖励
    5、礼包兑换分页						不出现红点			不	出现红点
	6、消费有奖（不一定上）		
	7、饕餮盛宴分页（领体力）			有体力可领取（补领不出现）	无可领取的体力
	8、每日充值送豪礼分页（累计充值）	有可领取的奖励				没有可领取的奖励
]]


	return TimeAnalysis.checkMonthCanGetToday()
	or LevelUpReward.GetInstance():canGetLevelUpReward()
	or g_dataCenter.activityReward:canGetLoginReward()
	or g_dataCenter.activityReward:canGetHurdleReward()
	or GuideTipFuncs.Activity_RechargeWelfare()
end

-- 升级奖励分页
function GuideTipFuncs.GetLevelUpRewardTip()
	return LevelUpReward.GetInstance():canGetLevelUpReward()
end

-- 充值福利（月卡）分页
function GuideTipFuncs.GetRechargeWelfareTip()
	-- return TimeAnalysis.checkMonthCanGetToday()
    app.log("-------------MonthCardUI:" .. tostring(g_dataCenter.activityReward:GetMonthCard()));
    return g_dataCenter.activityReward:GetMonthCard();
end

-- 登陆送礼分页
function GuideTipFuncs.GetLoginRewardTip()
	return g_dataCenter.activityReward:canGetLoginReward()
end

-- 闯关活动分页
function GuideTipFuncs.GetHurdleRewardTip()
	return g_dataCenter.activityReward:canGetHurdleReward()
end

-- 每日充值送豪礼分页（累计充值）
function GuideTipFuncs.GetDailyRechargeRewardTip()
	return g_dataCenter.activityReward:isAllERCanGet()
end
 
function GuideTipFuncs.GetMMoTask( )
	local res = Gt_Enum_Wait_Notice.Forced;
	if g_dataCenter.daily_task:GetLineRedPointState() or g_dataCenter.daily_task:GetRedPointState() then
		res = Gt_Enum_Wait_Notice.Success;
	end
	return res;
end

-- 主线任务
function GuideTipFuncs.GetMainTasksTip()
	app.log("------------- GetMainTasksTip:" .. tostring(g_dataCenter.daily_task:GetLineRedPointState()))
	local res = Gt_Enum_Wait_Notice.Forced;
	if g_dataCenter.daily_task:GetLineRedPointState() then
		res = Gt_Enum_Wait_Notice.Success;
	end
	return res;
end

-- 日常任务
function GuideTipFuncs.GetDailyTasksTip()
--	app.log("------------- GetDailyTasksTip:" .. tostring(g_dataCenter.daily_task:GetRedPointState()))
	local res = Gt_Enum_Wait_Notice.Forced;
	if g_dataCenter.daily_task:GetRedPointState() then
		res = Gt_Enum_Wait_Notice.Success;
	end
	return res;
end

-- 招财猫
function GuideTipFuncs.LuckyCat( )
	local res = Gt_Enum_Wait_Notice.Forced;
	if g_dataCenter.activityReward:GetIsRedPointStateByActivityID( ENUM.Activity.activityType_lucky_cat ) then
		res = Gt_Enum_Wait_Notice.Success;
	end
	return res;
end

-- 贩卖机
function GuideTipFuncs.VendingMachineTips()
	return g_dataCenter.activityReward:GetVendingMachineRedPointState()
end

-- 战力排行
function GuideTipFuncs.PowerRank( )
	local res = Gt_Enum_Wait_Notice.Forced;
	if g_dataCenter.activityReward:GetIsRedPointStateByActivityID( ENUM.Activity.activityType_power_rank ) then
		res = Gt_Enum_Wait_Notice.Success;
	end
	return res;
end

function GuideTipFuncs.VipBag( )
	local res = Gt_Enum_Wait_Notice.Forced;
	if g_dataCenter.player:GetVipRedPoint() then
		res = Gt_Enum_Wait_Notice.Success;
	end
	return res;
end

-- region 主界面
-- 主界面-7日签到
-- function GuideTipFuncs.GetSignIn7Tip()
-- 	return TimeAnalysis.checkCanGetToday()
-- end
 
-- 30日签到

function GuideTipFuncs.GetSignIn30Tip( )
--    app.log("-----------Signin 30 :" .. tostring(g_dataCenter.activityReward:GetSignIn30RedPoint()));
    local ret = Gt_Enum_Wait_Notice.Forced;
    if g_dataCenter.activityReward:GetSignIn30RedPoint() then
    	ret = Gt_Enum_Wait_Notice.Success;
    end
    return ret;
end

-- 7日乐活动
function GuideTipFuncs.GetSignIn7Tip( )
--    app.log("-----------Signin 7 1:" .. tostring(g_dataCenter.signin:GetRedPoint()));
    local ret = Gt_Enum_Wait_Notice.Forced;
    if g_dataCenter.signin:GetRedPoint() then
    	ret = Gt_Enum_Wait_Notice.Success;
    end
    return ret;
end

-- 7日乐活动
function GuideTipFuncs.GetSignIn7Tip_back( )
--    app.log("-----------Signin 7 2:" .. tostring(g_dataCenter.signin:GetRedPoint_back()));
    local ret = Gt_Enum_Wait_Notice.Forced;
    if g_dataCenter.signin:GetRedPoint_back() then
    	ret = Gt_Enum_Wait_Notice.Success;
    end
    return ret;
end

-- 主界面-活动-充值奖励
function GuideTipFuncs.Activity_RechargeWelfare()
	local smallCardTaskCanGet = g_dataCenter.daily_task:TaskIsFinishAndNotGet(EMonthCardId2DailyTaskId[EMonthCardIds.smallCard])
	if smallCardTaskCanGet == true and PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Task) then
		return true
	end

	local hasEnterUI = PlayerEnterUITimesCurDay.HasEnterUI("MonthCardUI")
	if hasEnterUI == false
		and not g_dataCenter.daily_task:TaskHasGet(EMonthCardId2DailyTaskId[EMonthCardIds.smallCard])
	then
		if g_dataCenter.player:GetStoreCardLastDay(EMonthCardIds.smallCard) > 0 and not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Task) then
			return false
		else
			return true
		end
	end

	return false
end


-- 主界面-邮件
function GuideTipFuncs.GetMailTip()
	--[[
1、邮箱里有任意未读取邮件出现红点。
2、邮件读取但没领附件，红点出现。	"所有邮件为已读取状态且附件领取红点消失。
]]
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Mail) then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	if g_dataCenter.mail:GetSystemMailUnreadCount() > 0 or g_dataCenter.mail:GetSystemMailUnreceiveGiftCount() > 0 then
		return Gt_Enum_Wait_Notice.Success;
	else
		return Gt_Enum_Wait_Notice.Forced;
	end
end

function GuideTipFuncs.LeftCenterMenuBtnTip()
	local mainui = GetMainUI()
	if mainui then
		local menuCom = mainui:GetPlayerMenu()
		if menuCom then
			local isOpen = menuCom:GetLeftCenterMenuBtnIsOpen()
			if not isOpen then
				return GuideTipFuncs.GetMailTip() or GuideTipFuncs.GetFriendAPTip() or GuideTipFuncs.GetFriendApplyTip()
			end
		end
	end
	return false
end

-- 经验挂机-战报
function GuideTipFuncs.GetExpReportTip()
	return false;
end

-- 主界面-对战
function GuideTipFuncs.GetAthleticTip(msgid)
	if g_dataCenter.activity[msgid] == nil then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	if not PublicFunc.FuncIsOpen(msgid) then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
	return g_dataCenter.activity[msgid]:IsOpen();
end

-- 3V3攻防战
function GuideTipFuncs.Get3V3Tip()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_threeToThree

	if not PublicFunc.FuncIsOpen(activity_id) then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end
	if not GmCheat:getPlayLimit() then
		if not PublicFunc.InActivityTime(activity_id) then
			return Gt_Enum_Wait_Notice.Time
		end
	end
	
	if not g_dataCenter.activity[activity_id]:IsHaveTimes() then
		return Gt_Enum_Wait_Notice.Forced
	end

	return Gt_Enum_Wait_Notice.Success
end

-- 竞技场-战报
function GuideTipFuncs.GetArenaReportTip()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_arena

	if not PublicFunc.FuncIsOpen(activity_id) then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end
	if not g_dataCenter.activity[activity_id]:HaveNewReport() then
		return Gt_Enum_Wait_Notice.Forced
	end

	return Gt_Enum_Wait_Notice.Success
end

-- 竞技场-爬梯奖
function GuideTipFuncs.GetArenaNewTopTip()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_arena

	if not PublicFunc.FuncIsOpen(activity_id) then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end
	if not g_dataCenter.activity[activity_id]:GetNewTopReward() then
		return Gt_Enum_Wait_Notice.Forced
	end

	return Gt_Enum_Wait_Notice.Success
end

--研究所
function GuideTipFuncs.GetInstituteTip()
	--app.log("GetInstituteTip==================="..tostring( g_dataCenter.Institute:checkIsFinish()))
	if g_dataCenter.Institute:checkIsFinish() then
		return Gt_Enum_Wait_Notice.Success
	else
		local result = {}
		result[Gt_Enum_Wait_Notice.Player_Levelup] = 1;
		result[Gt_Enum_Wait_Notice.Hero_StarUp] = 1;
		result[Gt_Enum_Wait_Notice.Hero_RarityUp] = 1;
		result[Gt_Enum_Wait_Notice.Hurdle_StarChange] = 1;
		result[Gt_Enum_Wait_Notice.Hurdle_Pass] = 1;
		result[Gt_Enum_Wait_Notice.Hero_Add] = 1;
		return result
	end
end
--训练馆
function GuideTipFuncs.GetTrainningTip()
	--app.log("GetTrainningTip==================="..tostring(g_dataCenter.trainning:computlineMax()))
	if g_dataCenter.trainning:isTips() and  g_dataCenter.trainning:computlineMax() and g_dataCenter.trainning:needlvl() then
		return Gt_Enum_Wait_Notice.Success
	else
		return Gt_Enum_Wait_Notice.Item_Training_Hall
	end
	
end

function GuideTipFuncs.GetTrainningDaRenTip()
	--app.log("GetTrainningDaRenTip==111111111================="..tostring(g_dataCenter.trainning:isUpBattle()))
	--app.log("GetTrainningDaRenTip==222222222==============="..tostring(g_dataCenter.trainning:needlvl()))

	if g_dataCenter.trainning:isUpBattle() and g_dataCenter.trainning:needlvl() then
		return Gt_Enum_Wait_Notice.Success
	else
		return Gt_Enum_Wait_Notice.Forced
	end
end 

--教堂挂机
function GuideTipFuncs.GetChurchTip()
	--if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:CheckFininshTime() then
	--	return Gt_Enum_Wait_Notice.Success
	--else
	--	return Gt_Enum_Wait_Notice.Time	
	--end

	if not g_dataCenter.ChurchBot:needlvl() then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end
	
	local time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetFininshTime()
    
	--app.log("time ----------------"..tostring(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:CheckFininshTime()))


	if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:CheckFininshTime() or g_dataCenter.ChurchBot:CheckPosition() then
		--
		return Gt_Enum_Wait_Notice.Success;
	else
		if time > 0 then
			TimerManager.Add(JiaoTangQiDaoTimeOver, time);
			return Gt_Enum_Wait_Notice.Time;
		else
			return Gt_Enum_Wait_Notice.Time;
		end
	end
end

--教堂挂机战报
function GuideTipFuncs:GetChurchBattleTip()
	if g_dataCenter.ChurchBot:GetNewBattleTip() then
		return Gt_Enum_Wait_Notice.Success
	else
		return Gt_Enum_Wait_Notice.Forced
	end
end

--角色历练
function GuideTipFuncs.GetHeroTrialTip()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_heroTrial

	if not PublicFunc.FuncIsOpen(activity_id) then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end
	local hero_trial = g_dataCenter.activity[activity_id]
	if hero_trial:GetUnusedChanllengeCnt() == 0 and hero_trial:IsThereBoxUnTaken() == false then
		return Gt_Enum_Wait_Notice.Forced
	end

	return Gt_Enum_Wait_Notice.Success
end

--面具升级系统
function GuideTipFuncs.GetMaskLvlUpTip()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_Mask

	if not PublicFunc.FuncIsOpen(activity_id) then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end

	local isLvlUp = g_dataCenter.maskitem:checkLvlPoint()
	local isRarityup = g_dataCenter.maskitem:checkRarityPoint()
	local isStarUp = g_dataCenter.maskitem:CheckStarPoint()

	if isLvlUp == true  or isRarityup == true or isStarUp == true then
		--app.log("11111111111111111111111")
		return Gt_Enum_Wait_Notice.Success
	else
		--app.log("2222222222222222222222")
		return Gt_Enum_Wait_Notice.Item_Mask
	end 

end

-- 竞技场-积分奖
function GuideTipFuncs.GetArenaNewPointTip()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_arena

	if not PublicFunc.FuncIsOpen(activity_id) then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end
	if not g_dataCenter.activity[activity_id]:GetNewPointReward() then
		return Gt_Enum_Wait_Notice.Forced
	end

	return Gt_Enum_Wait_Notice.Success
end

-- 竞技场-当日有可挑战次数
function GuideTipFuncs.GetArenaChallengeTimes()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_arena

	if not PublicFunc.FuncIsOpen(activity_id) then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end
	if g_dataCenter.activity[activity_id]:GetTimes() < 1 then
		return Gt_Enum_Wait_Notice.Forced
	end
	if g_dataCenter.activity[activity_id]:IsInColding() then
		return Gt_Enum_Wait_Notice.Forced
	end

	return Gt_Enum_Wait_Notice.Success
end

-- 崩坏大乱斗
function GuideTipFuncs.Get4FightTip()
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_fuzion) then
		return false
	end
	if not PublicFunc.InActivityTime(MsgEnum.eactivity_time.eActivityTime_fuzion) or
		g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_fuzion]:GetTimes() <= 0 then
		return false
	end
	return true
end



  
-- 关卡
function GuideTipFuncs.GetHurdleTip()
	return g_dataCenter.hurdle:IsHurdleTypeNotGetBoxAwards();
end

-- 战队
function GuideTipFuncs.GetBattleTeamTip()
	local res = false
	--[[for k, v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_clan_list)) do
		local act = ClanUI.RedPointFunc[v.id]
		if act then
		app.log("********* id:"..v.id.." act:IsOpen() "..tostring(act()))
			res = res or act();
			if res then
				break
			end
		end
	end]]
	return res
	-- return g_dataCenter.talentSystem:IsShowTip()
end

--[[战队--天赋]]
function GuideTipFuncs.GetTalentySystemTip(treeId)  
    if treeId == nil then
        app.log('参数错误***********' .. debug.traceback())
        return false
    end
    return g_dataCenter.talentSystem:IsShowTipOfTalentTree(treeId)
end

local hero_funcs = 
{
	"CanLevelUpAnyEquip",
	"CanStarUpAnyEquip",
	"CanStarUp",
	"CanRarityUp",
	"CanUpRestrain",
	"CanSkillLevel",
    "CanLevelUp",
}
-- 角色
function GuideTipFuncs.GetHerosTip()
	local noticeList = {}
	local _teamInfo = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
	if _teamInfo then
		for k,v in pairs(_teamInfo) do	
			local hero = g_dataCenter.package:find_card(ENUM.EPackageType.Hero,v)
			for k, v in ipairs(hero_funcs) do
				local result = hero[v](hero)
				if result == Gt_Enum_Wait_Notice.Success then
					return Gt_Enum_Wait_Notice.Success
				end
				if type(result) == "number" then
					noticeList[result] = 1;
				elseif type(result) == "table" then
					for k, v in pairs(result) do
						noticeList[k] = 1;
					end
				end
			end
		end
	end

	for k, v in pairs(ConfigHelper.GetRoleDefaultRarityTable()) do
        local card = g_dataCenter.package:find_card_for_num(1, v.default_rarity);
        if card == nil then
            if v.is_show == 1 and v.id == v.default_rarity then
            	local hero = CardHuman:new( { number = v.id });
                if g_dataCenter.package:GetCountByNumber(hero.config.hero_soul_item_id) >= hero.config.get_soul then
                	return Gt_Enum_Wait_Notice.Success;
                end
            end
        end
    end
    noticeList[Gt_Enum_Wait_Notice.Hero_StarUp] = 1;
	return noticeList;
end

-- 招募
function GuideTipFuncs.GetEnlistTip()
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Recruit) then
		return false
	end

	return g_dataCenter.egg:HasFreeHero();
end

-- 主界面-公会
-- function GuideTipFuncs.GetGuildTip()
-- 	local result = g_dataCenter.guild:GetEntryTips()
-- 	return result
-- end

-- 社团-社团科技捐献次数
function GuideTipFuncs.IsDonateRemain()
	local result = g_dataCenter.guild:IsDonateRemain()
	return result
end

-- 好友体力
function GuideTipFuncs.GetFriendAPTip()
	return g_dataCenter.friend:IsAPCanGet();
end

-- 好友申请
function GuideTipFuncs.GetFriendApplyTip()
	return g_dataCenter.friend:IsHaveNewApply();
end

-- endregion

-- 商店-装备宝箱  (免费次数，装备宝箱钥匙)
function GuideTipFuncs.GetShopEquipBoxTip()
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Equip) then
		return Gt_Enum_Wait_Notice.Player_Levelup
	end

	if g_dataCenter.egg:HasFreeEquip() then
		return Gt_Enum_Wait_Notice.Success
	end

	if PropsEnum.GetValue(IdConfig.EquipBoxKey) == 0 then
		return Gt_Enum_Wait_Notice.Item_EquipBoxKey
	else
		return Gt_Enum_Wait_Notice.Success
	end
end 

-- 社团-入社审核页卡
function GuideTipFuncs.GuildApplayDataTips()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_Guild

	if not g_dataCenter.guild:GetDetail() then
		return Gt_Enum_Wait_Notice.Guild_Wait_Enter
	end
	if not g_dataCenter.guild:IsManagerJob() then
		return Gt_Enum_Wait_Notice.Guild_JobChange
	end
	if g_dataCenter.guild:GetApplayDataCount() == 0 then
		return Gt_Enum_Wait_Notice.Forced
	end

	return Gt_Enum_Wait_Notice.Success
end

-- 世界boss
function GuideTipFuncs.GetWorldBoss()
	do return false; end;
	local info = g_dataCenter.worldBoss:CanEnter();
	return info;

end

-- 大乱斗
function GuideTipFuncs.GetDaluandou()
	if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_fuzion2) then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	return g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_fuzion2]:IsOpen();
end

-- 首冲
function GuideTipFuncs.FirstRecharge()
	local res = Gt_Enum_Wait_Notice.Forced;
	if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_FirsetRecharge) == false then
		res = Gt_Enum_Wait_Notice.Forced;
	end
	local rechargeType = g_dataCenter.player:GetFirstRechargeType();
	if not rechargeType then return false end;
	if ENUM.ETypeFirstRecharge.noGet == rechargeType then
		res = Gt_Enum_Wait_Notice.Success;
	elseif ENUM.ETypeFirstRecharge.noRecharge == rechargeType then
		if UiFirstRecharge.isOpen == false then
			res = Gt_Enum_Wait_Notice.Success;
		else
			res = Gt_Enum_Wait_Notice.Forced;
		end
	else
		res = Gt_Enum_Wait_Notice.Forced;

	end
--	app.log("is_red_first:" .. tostring(res))
	return res;
end

function GuideTipFuncs.SevenLogin( )
	local res = Gt_Enum_Wait_Notice.Forced;
	if g_dataCenter.activityReward:GetIsRedPointStateByActivityID( ENUM.Activity.activityType_login_award ) then
		res = Gt_Enum_Wait_Notice.Success;
	end

	return res;
end

function GuideTipFuncs.HeroStarUp()
	return uiManager:GetCurScene().roleData:CanAdvance()
end

function GuideTipFuncs.GetIllumstrationTip()
    local noticeList = {};
    noticeList[Gt_Enum_Wait_Notice.Hero_Add] = 1;

    if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_RolePokedex) then

	    local list = g_dataCenter.package:GetCard(ENUM.EPackageType.Hero);
	    for k, v in pairs(list) do
	    	local result = v:CanUpdateIllumstration();
	    	if result == Gt_Enum_Wait_Notice.Success then
	    		return Gt_Enum_Wait_Notice.Success;
	    	end
				noticeList[result] = 1;
	    end
	    
	end

	return noticeList;
end

function GuideTipFuncs.GetIllumstrationTipToCCG()
	local noticeList = {};
    noticeList[Gt_Enum_Wait_Notice.Hero_Add] = 1;

    if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_RolePokedex) then

	    local list = g_dataCenter.package:GetCard(ENUM.EPackageType.Hero);
	    for k, v in pairs(list) do
	    	if v.ccgType == 1 then
	    		-- app.log("ccg========================")
		    	local result = v:CanUpdateIllumstration();
		    	if result == Gt_Enum_Wait_Notice.Success then
		    		return Gt_Enum_Wait_Notice.Success;
		    	end
					noticeList[result] = 1;
			end
	    end
	    
	end

	return noticeList;
end

function GuideTipFuncs.GetIllumstrationTipToSSG()
	local noticeList = {};
    noticeList[Gt_Enum_Wait_Notice.Hero_Add] = 1;

    if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_RolePokedex) then

	    local list = g_dataCenter.package:GetCard(ENUM.EPackageType.Hero);
	    for k, v in pairs(list) do
	    	if v.ccgType == 2 then
	    		-- app.log("ssg========================")
		    	local result = v:CanUpdateIllumstration();
		    	if result == Gt_Enum_Wait_Notice.Success then
		    		return Gt_Enum_Wait_Notice.Success;
		    	end
					noticeList[result] = 1;
			end
	    end
	    
	end

	return noticeList;
end

function GuideTipFuncs.GetMainActivityRedPoint(  )
	local is_red_point = Gt_Enum_Wait_Notice.Forced;
	local red_point_states = g_dataCenter.activityReward:GetRedPointStates();
	if red_point_states then
		for k,v in pairs(red_point_states) do
			if v.id == ENUM.Activity.activityType_login_award or v.id == ENUM.Activity.activityType_lucky_cat or v.id == ENUM.Activity.activityType_power_rank then

			else
				if v.state == 1 then
					is_red_point = Gt_Enum_Wait_Notice.Success;
					break;
				end
			end
		end
	end
--	app.log("---------- is_red_point:" .. table.tostring(red_point_states));
	return is_red_point;
end

function GuideTipFuncs.ReturnTrue1()
--	app.log("GuideTipMgr ReturnTrue1")
	return true
end

function GuideTipFuncs.GetActivityLevelTip(msgid)
	if g_dataCenter.activity[msgid] == nil then
		return Gt_Enum_Wait_Notice.Invalid;
	end
	return g_dataCenter.activity[msgid]:IsOpen();
end

function GuideTipFuncs.GetKuikuliyaTip()
	return g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]:IsOpen();
end
function GuideTipFuncs.GetKuikuliyaStartTip()
	return g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]:CheckStartState();
end
function GuideTipFuncs.GetKuikuliyaGoodsTip()
	return g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]:CheckGoodsState();
end

function GuideTipFuncs.CheckEggGold()
	local heroGoldCD = (g_dataCenter.egg.heroCdTimeGold or 0) - system.time();
	local freeGoldTimes = g_dataCenter.egg.freeHeroTimesGold
    if heroGoldCD > 0 then
    	return Gt_Enum_Wait_Notice.Forced;
    elseif freeGoldTimes > 0 then
    	return Gt_Enum_Wait_Notice.Success;
    else
    	return Gt_Enum_Wait_Notice.Forced;
    end
end
function GuideTipFuncs.CheckEggCrystal()
	local heroCrystalCD = (g_dataCenter.egg.heroCdTime or 0) - system.time();
	local freeCrystalTimes = g_dataCenter.egg.freeHeroTimes
    if heroCrystalCD > 0 then
    	return Gt_Enum_Wait_Notice.Forced;
    elseif freeCrystalTimes > 0 then
    	return Gt_Enum_Wait_Notice.Success;
    else
    	return Gt_Enum_Wait_Notice.Forced;
    end
end
function GuideTipFuncs.CheckGuideSTDonation(id)
	if not g_dataCenter.guild:GetDetail() then
		return Gt_Enum_Wait_Notice.Guild_Wait_Enter
	end
	return g_dataCenter.guild:GetDetail():CanScienceSubDonate(id, true);
end

function GuideTipFuncs.GetGuildBossAward()
	if not g_dataCenter.guild:GetDetail() then
		return Gt_Enum_Wait_Notice.Guild_Wait_Enter
	end
end

function GuideTipFuncs.GetGuildBossStart()
	local rst = g_dataCenter.guildBoss:IsOpen();
	if rst ~= Gt_Enum_Wait_Notice.Success then
		return rst;
	end
    local times = g_dataCenter.guildBoss:GetChallengeTimes();
    local total_times = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).every_day_times;
    if times < total_times then
		return Gt_Enum_Wait_Notice.Success
    else
		return Gt_Enum_Wait_Notice.Forced
    end
end

function GuideTipFuncs.GuildCheckFindLsTips()

	if not g_dataCenter.guild:GetDetail() then
		return Gt_Enum_Wait_Notice.Guild_Wait_Enter
	end

	local flag = g_dataCenter.GuildFindLs:checkNumber()

	--app.log("flag==========================="..tostring(flag))

	if flag then
		return Gt_Enum_Wait_Notice.Success;
	else
		return Gt_Enum_Wait_Notice.Forced;
	end
end

-- 主界面-对战--世界boss--助阵
function GuideTipFuncs.GetWorldBossBackupTip()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_WorldBoss
	local res = GuideTipFuncs.GetAthleticTip(activity_id);
	if res == Gt_Enum_Wait_Notice.Success then
		if g_dataCenter.activity[activity_id]:CheckBattle() then
			return {[Gt_Enum_Wait_Notice.Hero_RarityUp]=1,[Gt_Enum_Wait_Notice.Hero_Add]=1,[Gt_Enum_Wait_Notice.Forced]=1,};
		end
	end
	return res;
end
-- 主界面-对战--世界boss--奖励
function GuideTipFuncs.GetWorldBossAward()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_WorldBoss
	if not PublicFunc.FuncIsOpen(activity_id) then
		return Gt_Enum_Wait_Notice.Player_Levelup;
	end
    local _,curBossLv = g_dataCenter.worldBoss:GetBossInfo();
    local cfgEnum = EConfigIndex.t_world_boss_server_reward;
    local listNum = ConfigManager.GetDataCount(cfgEnum);
    for i=1,listNum do
        local cfg = ConfigManager.Get(cfgEnum,i);
        if cfg.need_boss_level < curBossLv then
        	if not g_dataCenter.worldBoss:GetRewardFlag(i) then
        		return Gt_Enum_Wait_Notice.Success;
        	end
        end
    end
    return Gt_Enum_Wait_Notice.Forced;
end
-- 主界面-对战--世界宝箱--助阵
function GuideTipFuncs.GetWorldTreasureBackupTip()
	local activity_id = MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox
	local res = GuideTipFuncs.GetAthleticTip(activity_id);
	if res == Gt_Enum_Wait_Notice.Success then
		if g_dataCenter.activity[activity_id]:CheckBattle() then
			return {[Gt_Enum_Wait_Notice.Hero_RarityUp]=1,[Gt_Enum_Wait_Notice.Hero_Add]=1,[Gt_Enum_Wait_Notice.Forced]=1,};
		end
	end
	return res;
end
function GuideTipFuncs.BagHasCareOpenBox()
	local items = g_dataCenter.package:GetCard(ENUM.EPackageType.Item)
	local showTip = nil
	for k,card in pairs(items) do
		if PublicFunc.BagNeedShowTipPoint(card.number) then
			showTip = Gt_Enum_Wait_Notice.Success
			break
		end
	end

	if showTip == nil then
		showTip = {}
		showTip[Gt_Enum_Wait_Notice.Item_ExchangeType] = 1
		showTip[Gt_Enum_Wait_Notice.Item_Add] = 1
	end

	return showTip
end

function GuideTipFuncs.GuardHeart()
	local tip = nil
	local dc = g_dataCenter.guardHeart
	local hasLockPos = false
	for pos = 1, 5 do
		
		if not hasUnlockPos and dc:GetPosData(pos) == nil and not dc:PosIsUnlock(pos) then
			hasLockPos = true
		end

		if (dc:GetPosData(pos) == nil and dc:PosIsUnlock(pos)) or dc:CanPromotion(pos) then
			tip = Gt_Enum_Wait_Notice.Success
			break
		end
	end
	if tip == nil then
		tip = {}
		if hasLockPos then
			tip[Gt_Enum_Wait_Notice.Hero_Add] = 1
			tip[Gt_Enum_Wait_Notice.Player_Levelup] = 1
			tip[Gt_Enum_Wait_Notice.Player_FightValue] = 1
		end

		tip[Gt_Enum_Wait_Notice.Hero_LevelUp] = 1
		tip[Gt_Enum_Wait_Notice.Hero_StarUp] = 1
		tip[Gt_Enum_Wait_Notice.Hero_RarityUp] = 1
		tip[Gt_Enum_Wait_Notice.Item_EquipLevelUp] = 1
		tip[Gt_Enum_Wait_Notice.Item_EquipStar] = 1
		tip[Gt_Enum_Wait_Notice.Item_EquipRarity] = 1
		tip[Gt_Enum_Wait_Notice.Guard_Heart] = 1
	end

	return tip
end

function GuideTipFuncs.ChatFightHaveRequest()
	if g_dataCenter.chatFight:HaveRequest(true) then
		return Gt_Enum_Wait_Notice.Success
	else
		return Gt_Enum_Wait_Notice.Chat_Fight_Request
	end
end

function GuideTipFuncs.ChatFightAwardFightTip()
	if g_dataCenter.chatFight:CanGetAward(ENUM.ChatFightAward.Fight) then
		return Gt_Enum_Wait_Notice.Success
	else
		return Gt_Enum_Wait_Notice.Chat_Fight_Award
	end
end

function GuideTipFuncs.ChatFightAwardWinTip()
	if g_dataCenter.chatFight:CanGetAward(ENUM.ChatFightAward.Win) then
		return Gt_Enum_Wait_Notice.Success
	else
		return Gt_Enum_Wait_Notice.Chat_Fight_Award
	end
end