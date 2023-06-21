local playerInfo = {
	--playerid 玩家唯一id
	--groupid 帮派id
	--name 名字
	--head 头像
	--image 形像
	--ap 体力
	--bp 精力
	--exp 经验
	--level 等级
	--vip vip等级
	--vipexp vip经验
	--gold 金币
	--crystal 钻石
	--red_crystal 红钻
	--online_state 在线状态 ENUM.EOnlineState
	--last_login_time 上次登录时间
	--create_time 创建时间
	--head 头像 (已废)
	--image 形象
	--defTeam 默认哪个队伍
	--teams = {
	--{"6167577387891490818","6167577387891474434","6169349534347444226"},{},{}
	--} 队伍列表
	--temp_teams = {
	--},临时用于查找某卡牌是否在编队中的表
	--verify_server 保存在登录后服务器发回来的验证码，重新登录时候用
    --verify_client 客户端的识别码，如果这个码和服务器那边保存的不一样，则表示不是我们支持的客户端。
    --oldData 上次状态的服务器数据
    --vip_reward_flag vip等级奖励标志
    --show_playerid 显示玩家id


    --其他玩家进行构造的特有数据
    --package  玩家背包（Package类）
    --otherData 特有数据结构
    --flagHelper 标记辅助类 (FlagHelper类)
    --is_get_bind_awards 领取绑定奖励
}

Player = Class("Player",nil,playerInfo)

--用户数据
function Player:Init()
	self.playerid = 0;
	self.groupid = 0;
	self.name = GameInfoForThis.UserName;
	self.image = 30005000;
	self.ap = 99999;
	self.bp = 99999;
	self.exp = GameInfoForThis.Exp;
	self.level = GameInfoForThis.Level;
	self.vip = GameInfoForThis.Vip;
	self.vipexp = 9999999;
	self.vipstar = 9999999;
	self.vipEveryGet = 9999999;
	self.gold = GameInfoForThis.Gold;
	self.crystal = GameInfoForThis.Crystal;
	self.red_crystal = GameInfoForThis.Red_crystal;
	self.online_state = ENUM.EOnlineState.online;
	self.last_login_time = 0;
	self.create_time = 0;
	self.defTeam = ENUM.ETeamType.normal;
	self.teams = GameInfoForThis.teams;
	self.teams_halo = {};
	self.teamPos = {};
	self.teamSoldierPos = {};
	self.temp_teams = {};
	self.backupTeams = {};
	self.verify_server = "";
	self.verify_client = "client_gh";
	self.oldData = {};
	self.badges_contingents = {};
	self.package = {};
	self.otherData = {};
	self.flagHelper = FlagHelper:new();
    self.friendship_value = 0;
    self.friendship_value_today = 0;
    self.buy_store_card = {}	--已购买的商城卡
    self.vip_reward_flag = 1;
    self.show_playerid = 1;
    self.camp_flag = g_dataCenter.fight_info.single_friend_flag;
    self.transform_cnt = 1;
    self.inviteList = {};
	self.IsYueKa = 1 -- 0为否 1为是
	self.IsYueKa1 = 1;
	self.get_friend_ap_times = 0
	self.fight_value = 0
	self.rollnamelist = {};
	self.IsRealNameAuth = 0; -- -1未请求 0已实名认证  1未实名认证
	self.IsRunGameTime = 0;  --当天的游戏运行时间
	self.is_get_bind_awards = 0;
	self.change_name_times = 1;  --改名次数
	self.peakshow = 0;
	self.churchVigor = 0; --教堂挂机精力
	self.gmSwitch = 1;
	self.heroTrialTicket = 1;
	self.allHeroOwnProperty = {}
	self.history_max_fight_value = 0;
end
function Player:GetGID()
	return self.playerid;
end

function Player:GetName()
	return self.name;
end

function Player:SetBindAwardsFlag()
	self.is_get_bind_awards = 1;	
end

function Player:ResetInviteList()
	self.inviteList = {};
end

--[[只会执行一次，或重新进游戏时全部刷新使用]]
function Player:UpdateData(info)
	self.oldData.exp = tonumber(info.exp) or 0;
	self.oldData.level = info.level or 0;
	self.oldData.gold = tonumber(info.gold) or 0;
	self.oldData.crystal = tonumber(info.crystal) or 0;
	self.oldData.red_crystal = tonumber(info.red_crystal) or 0;
	self.oldData.ap = info.ap or 0;
	self.oldData.bp = info.bp or 0;
	self.oldData.vip_reward_flag = info.vip_reward_flag or 0;
	self.oldData.vipexp = info.vipexp or 0;
	self.oldData.vipstar = info.vipstar or 0;
	self.oldData.vipEveryGet = info.vip_every_get or 0;
	self.oldData.vip = info.vip or 0;
	self.oldData.old_fight_value = self.fight_value or 0
	
	self.advOldLevel = info.level or 0;
	
	self.playerid = info.playerid or 0;
	self.show_playerid = info.show_playerid or 0;
	self.groupid = info.groupid or 0;
	self.name = info.name or 0;
	self.ap = info.ap or 0;
	self.exp = tonumber(info.exp) or 0;
	self.level = info.level or 0;
	self.vip = info.vip or 0;
	self.gold = tonumber(info.gold) or 0;
	self.crystal = tonumber(info.crystal) or 0;
	self.red_crystal = tonumber(info.red_crystal) or 0;
	self.online_state = info.online_state or 0;
	self.last_login_time = tonumber(info.last_login_time) or 0;
	self.create_time = tonumber(info.create_time) or 0;
	self.vipexp = info.vipexp or 0;
	self.vipstar = info.vipstar or 0;
	self.vipEveryGet = info.vip_every_get or 0;
	self.bp = info.bp or 0;
	self.head = info.head or 0;
	self.image = info.image or 0;
	self.skillPoint = info.skill_point or 0;
	self.skillPointCD = info.skill_point_cd or 300;
	self.beginGetCDTime = PublicFunc.QueryCurTime();
    self.friendship_value = info.friendship_value or 0;
    self.friendship_value_today = info.friendship_value_today or 0;
    self.vip_reward_flag = info.vip_reward_flag or 0;
    self.peakshow = info.peekshow or 0;
    
    -- if info.store_card_id1 and info.store_card_id1 > 0 then
    -- 	self.buy_store_card[info.store_card_id1] = info.store_card_last_day1
    -- end
    -- if info.store_card_id2 and info.store_card_id2 > 0 then
    -- 	self.buy_store_card[info.store_card_id2] = info.store_card_last_day2
    -- end
    self.store_card_id1 = info.store_card_id1;
    self.store_card_id2 = info.store_card_id2;
    self.country_id = info.country_id;
    self:SetFirstRechargeFlag(info.pay_flag);
    self.first_choose_role = info.first_choose_role or 0;
    self.transform_cnt = info.cur_transform_to_boss_num or 0
	if info.store_card_id1 and info.store_card_id1 > 0 then
		self.IsYueKa = 1;
	else
		self.IsYueKa = 0;
	end
	
	if info.store_card_id2 and info.store_card_id2 > 0 then
		self.IsYueKa1 = 1;
	else
		self.IsYueKa1 = 0;
	end
	self.get_friend_ap_times = (info.get_friend_ap_times or 0);
	self.fight_value = info.fight_value
	self.history_max_fight_value = info.history_max_fight_value or 0;
	self.is_get_bind_awards = info.is_get_bind_awards
	self.change_name_times = (info.change_name_times or 0);
	self.churchVigor = info.churchVigor or 0;
	self.gmSwitch = info.gmSwitch or 0;
	self.heroTrialTicket = info.heroTrialTicket or 0;
	self:CheckVipRedPoint();
end

--cj获取是否是月卡用户
function Player:GetIsYueKa()
	return self.IsYueKa
end

function Player:GetIsYueKa1()
	return self.IsYueKa1
end

--[[更新技能点和cd时间]]
function Player:UpdateSkillPointCD(point,cd)
	self.skillPoint = point or 0;
	self.skillPointCD = cd or 300;
	self.beginGetCDTime = PublicFunc.QueryCurTime();
end

--[[更新好友友情值]]
function Player:UpdateFSValue(fs)	
	self.friendship_value = fs;
end

--[[更新当天领取的好友友情值]]
function Player:UpdateFSValueToday(fs)	
	self.friendship_value_today = fs;
end

--[[更新经验与等级]]
function Player:UpdateExpLevel(exp, level)
	self.oldData.exp = tonumber(self.exp);
	self.oldData.level = self.level;
	if self.level ~= level then 
		self.advOldLevel = self.level;
	end 
	self.exp = tonumber(exp);
	self.level = level;
	--app.log("player oldLevel="..self.oldData.level.." oldExp="..self.oldData.exp.." level="..self.level.." exp="..self.exp);

	-- 玩家升级通知
	if self.oldData.level < self.level then

		--[[提交第三方SDK上报]]
		UserCenter.get_sdk_push_info("levelUp");

		NoticeManager.Notice(ENUM.NoticeType.PlayerLevelUp, self.level);
        PublicFunc.msg_dispatch('TeamUpgrade', self.oldData.level, self.level)
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Player_Levelup);
	end
end

--[[更新金币和钻石 + 红钻]]
function Player:UpdateGoldAndCrystal(gold, crystal, red_crystal)
	self.oldData.gold = tonumber(self.gold);
	self.oldData.crystal = tonumber(self.crystal);
	self.oldData.red_crystal = tonumber(self.red_crystal);
	self.gold = tonumber(gold);
	self.crystal = tonumber(crystal);
	self.red_crystal = tonumber(red_crystal);

	if self.oldData.crystal ~= self.crystal then
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Crystal)
	end
end

--[[更新体力精力]]
function Player:UpdateApAndBp(ap, bp)
	self.oldData.ap = tonumber(self.ap);
	self.oldData.bp = tonumber(self.bp);
	self.ap = tonumber(ap);
	self.bp = tonumber(bp);
end

--更新教堂挂机精力
function Player:UpdateChurchVigor(vigor)
	self.churchVigor = tonumber(vigor)
end

--更新商城卡数据
function Player:UpdateStoreCard(card1, card1_last_day, card2, card2_last_day)
	-- self.buy_store_card = {}
 --    if card1 > 0 then
	-- 	self.buy_store_card[card1] = card1_last_day
	-- end
	-- if card2 > 0 then
	-- 	self.buy_store_card[card2] = card2_last_day
	-- end
	if card1 > 0 then
		self.IsYueKa = 1;
	end
	if card2 > 0 then
		self.IsYueKa1 = 1;
	end
	self.store_card_id1 = card1;
	self.store_card_id2 = card2;
end

function Player:GetStoreCardLastDay(id)
    return g_dataCenter.player.buy_store_card[id] or 0
end

--更新VIP
function Player:UpdateVIP(vip, vipexp, vip_reward_flag, vipstar, vip_every_get)
	self.oldData.vip = self.vip;
	self.oldData.vipexp = self.vipexp;
	self.oldData.vip_reward_flag = self.vip_reward_flag;
	self.vip = vip or 0;
	self.vipexp = vipexp or 0;
	self.vipstar = vipstar or 0;
	self.vipEveryGet = vip_every_get or 0;
	self.vip_reward_flag = vip_reward_flag or 0;

	NoticeManager.Notice(ENUM.NoticeType.VipDataChange);
	if self.vip > self.oldData.vip then
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Vip_Level)
	end

	self:CheckVipRedPoint();
end

--显示购买体力的流程提示
function Player.ShowBuyAp()

	local curPlayer = g_dataCenter.player;
	local vipData = curPlayer:GetVipData();
	if not vipData then
		app.log("vip 配置错误 level="..tostring(curPlayer.vip));
		return;
	end
	local curTimes = curPlayer:GetFlagHelper():GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_apBuyTimes) or 0;
	local gbc = ConfigManager.Get(EConfigIndex.t_buy_cost,curTimes);
	if not gbc then
		app.log("buy_cost 配置错误 curTimes="..tostring(curTimes));
		return;
	end
	CommonBuy.Show(curTimes, vipData.ex_can_buy_ap_times, gbc.cost, gbc.get_ap, gs_misc['str_46'], gs_misc['str_40'], Player.OnSureBuyAp);
end

function Player.OnSureBuyAp()
	player.cg_ap_buy();
end

--获取今日可购买体力次数最大限制
function Player:GetMaxApBuyTimes()
	local basic_max_buy_ap_times = ConfigManager.Get(EConfigIndex.t_discrete,83000033).data;
	local extra_can_buy_ap_times = 0;
	if g_dataCenter.player:GetVipData() then
    	extra_can_buy_ap_times = g_dataCenter.player:GetVipData().ex_can_buy_ap_times;
	else
		extra_can_buy_ap_times = 0;
		app.log("当前vip=="..tostring(self.vip).."没有对应的额外购买体力次数配置表");
	end
	
	local max_buy_ap_times = basic_max_buy_ap_times + extra_can_buy_ap_times;
	return max_buy_ap_times;
end

--获取可以购买世界BOSS鼓舞的最大次数
function Player:GetMaxBuyInspireTimes()
    if g_dataCenter.player:GetVipData() then
        return g_dataCenter.player:GetVipData().world_boss_inspire_limit
    end
    return 0
end

--获取当前VIP初始世界BOSS鼓舞次数
function Player:GetStartInspireTimes()
    if g_dataCenter.player:GetVipData() then
        return g_dataCenter.player:GetVipData().world_boss_start_inspire
    end
    return 0
end


--获取今天已兑换通灵之魂数
function Player:GetChangeSouls()
	local flag = self.flagHelper:GetStringFlag(MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan);
	if flag then 
		for k, v in string.gmatch(flag,"d=(%d+)") do
			return tonumber(k);
		end
	end
	return 0;
end

function Player:AddInvite(inviteInfo)
	--可以重复邀请，相同的邀请者被替换掉
	for i, v in ipairs(self.inviteList) do
		if v.playerid == inviteInfo.playerid then
			self.inviteList[i] = inviteInfo;
			return;
		end
	end
	table.insert(self.inviteList, inviteInfo);
end

--[[队伍增加一个英雄]]
function Player:AddTeam(teamId, index, dataid)
	self.teams[teamId] = self.teams[teamId] or {};
    local heroID = self.teams[teamId][index]
	self.teams[teamId][index] = dataid;
	if heroID ~= dataid then
		GGuideTipForceRefresh(Gt_Enum.EMain_Heros);
	end
    if teamId == ENUM.ETeamType.normal and index == 1 and heroID ~= dataid and heroID and SceneManager.GetCurrentScene() == mainCityScene then
        mainCityScene:ChangeCaptain();
    end
end

function Player:AddBackupTeam(teamId, index, dataid)
	self.backupTeams[teamId] = self.backupTeams[teamId] or {};
	self.backupTeams[teamId][index] = dataid;
end

function Player:GetBackupTeam(teamId)
	return self.backupTeams[teamId] or {};
end

--清除队伍数据
function Player:ClearTeam(teamId)
	
	if self.teams[teamId] then
		self.teams[teamId] = {};	
	end
	
	if self.teamPos[teamId] then
		self.teamPos[teamId] = {};	
	end
	
	if self.teamSoldierPos[teamId] then
		self.teamSoldierPos[teamId] = {};	
	end
	
end

function Player:UpdateTeamHaloInfo(teamId, property, fight_value)
	self.teams_halo[teamId] = self.teams_halo[teamId] or {}
	self.teams_halo[teamId].halo_property = {}
 	for i=1, #property do
        self.teams_halo[teamId].halo_property[property[i].id + ENUM.min_property_id] = property[i].value
	end
	self.teams_halo[teamId].halo_fight_value = fight_value
end

function Player:GetTeamHaloInfo(teamId)
	return self.teams_halo[teamId]
end

function Player:GetInItemIndex(teamid, dataid)
    local ret = -1
    local team = self.teams[teamid]
    if team then
        for k,v in ipairs(team) do
            if v == dataid then
                ret = k
                break
            end
        end
    end
    return ret
end

function Player:AddTeam(teamId,index,pos)
	self.teams[teamId] = self.teams[teamId] or {};
	self.teams[teamId][index] = pos;
end

function Player:AddTeamPos(teamId,index,pos)
	self.teamPos[teamId] = self.teamPos[teamId] or {};
	self.teamPos[teamId][index] = pos;
end

function Player:AddSoldierPos(teamId,index,pos)
	self.teamSoldierPos[teamId] = self.teamSoldierPos[teamId] or {};
	self.teamSoldierPos[teamId][index] = pos;
end

--[[是否在队伍中（默认1号队伍）]]
function Player:IsAnyTeam(dataid)
	for k,v in pairs(self.teams[self.defTeam]) do
		if v == dataid then
			return true;
		end
	end
	return false;
end

--[[是否为队长（默认1号队伍）]]
function Player:IsLeader(dataid, teamNumber)
	teamNumber = teamNumber or self.defTeam
	if self.teams then
		local t_data = self.teams[teamNumber]
		if t_data then
			local id = t_data[1];
			return dataid == id;
		end
	end
	return false
end

--[[是否在队伍中（默认1号队伍）]]
function Player:IsTeam(dataid, teamNumber)
	teamNumber = teamNumber or self.defTeam
	if self.teams then
		local t_data = self.teams[teamNumber]
		if t_data then
			for k,v in pairs(t_data) do
				if dataid == v then
					return true	
				end
			end
		end
	end
	return false
end

--获取整个验证码
function Player:GetVerifyCode()
    return util.get_md5(self.verify_server..self.verify_client)
end
--设置名字
function Player:SetName(name)
	if name then
		self.oldData.name = self.name or name;
		self.name = name;
	end
end
--设置默认队伍
function Player:SetDefTeam(number)
	-- if number then
	-- 	self.defTeam = number;
	-- else
	-- 	app.log("设置默认队伍传入nil    "..debug.traceback());
	-- end
end
--获取默认队伍
function Player:GetDefTeam()
	--app.log("defteam="..tostring(self.defTeam).." teams="..table.tostring(self.teams))
	return self.teams[ENUM.ETeamType.normal];
end
--获取队伍
function Player:GetTeam(team_type)
	return self.teams[team_type] or {};
end
function Player:GetTeamPos(team_type)
	--阵位跟阵容里面的卡牌顺序保持一致
	local result = {}
	if self.teams[team_type] then
		for k, v in pairs_key(self.teams[team_type]) do
			if tonumber(v) ~= 0 then
				table.insert(result, k)
			end
		end 
	end
	return result
	-- return self.teamPos[team_type];
end
function Player:GetSoldierPos(team_type)
	return self.teamSoldierPos[team_type];
end
--设置验证码
function Player:SetVerifyServer(info)
	if info then
		self.verify_server = info;
	else
		app.log("设置服务器重连验证码传入nil    "..debug.traceback());
	end
end

--获取老的经验比
function Player:GetOldExpPro()
	local levelConfig = ConfigManager.Get(EConfigIndex.t_player_level,self.oldData.level);
	if levelConfig then
		return tonumber(self.oldData.exp) / levelConfig.exp;
	else
		app.log("获取玩家经验比失败   level="..tostring(self.oldData.level));
		return 0;
	end
end

--获取最新经验比
function Player:GetExpPro()
	local levelConfig = ConfigManager.Get(EConfigIndex.t_player_level,self.level);
	if levelConfig then
		return self.exp / levelConfig.exp;
	else
		app.log("获取玩家经验比失败   level="..tostring(self.level));
	end
end
--获取玩家上次状态等级与最新等级是否相等
function Player:IsLevelUp()
	return self.oldData.level ~= self.level;
end
--获取上次状态玩家与最新玩家经验之差
function Player:GetDiffExp()
	local diffExp = 0;
	local oldLevel = self.oldData.level;
	if self.level > oldLevel then
		local cf = ConfigManager.Get(EConfigIndex.t_player_level,oldLevel);
		diffExp = cf.exp - tonumber(self.oldData.exp)
		oldLevel = oldLevel + 1;
		while oldLevel < self.level do
			cf = ConfigManager.Get(EConfigIndex.t_player_level,oldLevel);
			if cf then
				diffExp = diffExp + cf.exp;
			end
            oldLevel = oldLevel + 1;
		end
		diffExp = diffExp + tonumber(self.exp);
	else
		diffExp = tonumber(self.exp) - tonumber(self.oldData.exp);
	end
	return diffExp;
end
--获取上一次英雄经验与这一次英雄经验之差
function Player:GetDiffHeroExp(param)
	if param == 0 or param == nil then
		param = 1;
	end
	local defTeam = self.teams[self.defTeam]
	if defTeam[param] then
		local obj = g_dataCenter.package:find_card(1, defTeam[param]);
		if obj then
			return obj:GetDiffHeroExp();
		else
			app.log("背包中未找到对应队伍中的英雄    "..tostring(defTeam[param]));
		end
	end
	return 0;
end

function Player:SetFightValue(value, historyMaxFv)
	self.oldData.old_fight_value = self.fight_value
	self.fight_value = value
	self.history_max_fight_value = historyMaxFv
end

function Player:GetHistoryFightValue()
	return self.history_max_fight_value
end

--获取战斗力
function Player:GetFightValue()
	if self.fight_value == 0 then
		local package = g_dataCenter.package;
		local value = 0;
		if self.teams[self.defTeam] then
			for k, v in pairs(self.teams[self.defTeam]) do
				local card = package:find_card(1, v);
				if card then
					value = value + card:GetFightValue(--[[ENUM.ETeamType.normal]]);
				end
			end
		end
		self.fight_value = PublicFunc.AttrInteger(value);
	end
	return self.fight_value
end

function Player:GetOldFightValue()
	return self.oldData.old_fight_value
end

function Player:SetOldFightValue(fv)
	self.oldData.old_fight_value = fv
end

--[[传送次数]]
function Player:GetTransformCnt()
    return self.transform_cnt   
end

function Player:SetTransformCnt(cnt)
    self.transform_cnt = cnt  
end

function Player:GetHeroTrialTicket()
	return self.heroTrialTicket
end

function Player:SetHeroTrialTicket(cnt)
	self.heroTrialTicket = cnt
end

function Player:GetLevel()
    return self.level
end

function Player:GetImage()
    return self.image
end

function Player:GetPlayerID()
    return self.playerid
end

function Player:GetShowPlayerID()
	return self.show_playerid;
end

function Player:SetPackage(package)
	self.package = package
end

function Player:SetOtherPlayerData(data)
	self.otherData = data
end

function Player:GetVip()
   return self.vip
end

--获取标识
function Player:GetFlagHelper()
	return self.flagHelper;
end

function Player:CaptionIsAutoFight()
	if not FightScene.GetFightManager() then
		return false
	end
    local autoFightAI = FightScene.GetFightManager():GetMainHeroAutoFightAI()
    local obj = FightManager.GetMyCaptain()
    if obj and obj:GetAI() == autoFightAI then
        return true
    end

    return false
end

function Player:CheckToManualWay()
    if self:CaptionIsAutoFight() then

        self:ChangeFightMode(false)
    end
end

function Player:ChangeFightMode(bool)
    ObjectManager.ChangeCaptainFightMode(bool);
    local mui = GetMainUI()
    if mui then
        mui:SetAutoBtn(bool)
    end
end

function Player:GetCaptionIndex()
    return self.captionIndex
end

function Player:ChangeCaptain(index, isMainHeroDead, ignoreCondition, isStart)
    if index == nil then
        return
    end
    --[[
    if ignoreCondition == nil then
        ignoreCondition = true;
    end
    if ignoreCondition then
        local will_captaion = g_dataCenter.fight_info:GetControlHero(index)
        if will_captaion and will_captaion:IsDead() and (not will_captaion.can_reborn_now or g_dataCenter.fight_info:IsInFight()) then
            return
        end
        if will_captaion and will_captaion:IsDead() and will_captaion.can_reborn_now and not g_dataCenter.fight_info:IsInFight() then
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                local captain_gid = 0
                local captain = g_dataCenter.fight_info:GetCaptain() 
                if captain then
                    captain_gid = captain:GetGID()
                end
                --msg_fight.cg_relive_hero(will_captaion:GetGID(), captain_gid)
            else
                will_captaion:Reborn()
            end
            return
        end
    end
    ]]

    if g_dataCenter.fight_info:GetControlHeroName(index) == nil then
        return
    end

    if g_dataCenter.fight_info:GetCaptainIndex() == index then
        return
    end
    
    local old_captain = g_dataCenter.fight_info:GetCaptain()
    if old_captain then
        if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
            old_captain:ClearFightStateTarget(true, false, "切换操作者")
        end
    end
    g_dataCenter.fight_info:SetCaptain(index)
    local new_captain = g_dataCenter.fight_info:GetCaptain()
    if new_captain then
        if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
            new_captain:ClearFightStateTarget(true, false, "切换操作者")
        end
    end

    if old_captain ~= new_captain then
        new_captain:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data,46), nil, nil, nil, nil, nil, nil, nil, false, nil)
    end
    self.captionIndex = index
    if old_captain then
        if old_captain.aperture_manager then
            old_captain.aperture_manager:SetOpenNotMove(old_captain.aperture_manager.curHeroFootEffect, false);
        end
        --old_captain.aperture_manager:PauseAllEffect();
        old_captain:UpdateBlood();
    end
    mini_map.set_main_player(new_captain.object);
    FightMap.set_main_player(new_captain.object);
    new_captain:UpdateBlood();
    if old_captain then
        if PublicStruct.Open_Follow == true then
            old_captain:SetAiEnable(true);
        else
            old_captain:SetHandleState(EHandleState.Manual);
        end
         old_captain:OpenGain(false);
    end

    new_captain:OpenGain(true);

    -- pvp 在创建英雄时，会自己设置ai
    --if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        new_captain:SetAiEnable(false);--不要动这个，序章白发金木会乱走
    --end

    --new_captain.aperture_manager:RecoverAllEffect();
    -- new_captain:OnBeCurrentRole(self.heros[old_index]);
    if isMainHeroDead ~= true then
--        FightUI.SetAutoBtn(true)
    end
    --填充cd

    local mainui = GetMainUI()

    mainui:SetSelectHead(index)
    mainui:ReFillCD(new_captain)
    mainui:ReFillRationEffect(new_captain)
    mainui:UpdateSkillIcon(new_captain)
    mainui:UpdateSkillOverlap(new_captain)
    
    mainui:UpdateHeadData();
    
    CameraManager.init_target(new_captain)
    if isStart ==  true then
        CameraManager.MoveToTargetImm()
    end

    --加上光圈
    --new_captain.aperture_manager:SetOpenNotMove(new_captain.aperture_manager.curHeroFootEffect, true, new_captain:GetBindObj(3));
    self:SetCurCtrlHero(new_captain:GetName())


    --开启audio listener 跟随主角
    --AudioManager.SetAudioListenerFollowObj(true,new_captain.object:get_child_by_name("point_root"))
	local camera = CameraManager.GetSceneCameraObj()
	AudioManager.SetAudioListenerFollowObj(true,camera)

	PublicFunc.msg_dispatch(Player.ChangeCaptain, old_captain, new_captain)
	local fm = FightScene.GetFightManager()
	if fm and fm.OnChangeCaptainUpdateMinimap then
		fm:OnChangeCaptainUpdateMinimap(old_captain, new_captain)
	else
		if old_captain and new_captain then
			local minimap = mainui:GetMinimap()
			if minimap then
				local odata = minimap:GetPeopleData(old_captain)
				local ndata = minimap:GetPeopleData(new_captain)
				
				if odata and odata.eType == EMapEntityType.EMy then
					minimap:AddPeople(old_captain, EMapEntityType.EGreenHero)
				end
				if ndata and ndata.eType ~= EMapEntityType.EMy then
					minimap:AddPeople(new_captain, EMapEntityType.EMy, true)
				end
			end
		end
	end
end

function Player:SetCurCtrlHero(hero_name)
    if hero_name == self.curCtrlHero then
        return
    end
    self.curCtrlHero = hero_name
    local ctrler = nil
    if self.curCtrlHero then
        ctrler = ObjectManager.GetObjectByName(self.curCtrlHero)
    end
    self:SetCtrlHeroEffect(ctrler)
end

function Player:GetCurCtrlHero()
    return self.curCtrlHero
end

function Player:SetCtrlHeroEffect(obj)
    --光圈
    if obj then
        if obj.aperture_manager then
            obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.curHeroFootEffect, true, obj:GetBindObj(3), 0, 0, 0, 1, 1, nil, nil, true, nil);
        else
            obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.curHeroFootEffect, false);
        end
    end
end

function Player:ShowAttackTargetEffects(obj, isChangeTargetEffect)
    if self.lastShowObj and self.lastShowObj ~= obj and self.lastShowObj.aperture_manager then
    	if self.lastShowObj.wait_can_attach_show_target_effect then
    		self.lastShowObj.wait_can_attach_show_target_effect = false
    	else
    		self.lastShowObj.aperture_manager:SetOpenNotMove(self.lastShowObj.aperture_manager.changeTargetHeadEffect, false);
        	self.lastShowObj.showChangeTargeEffect = nil;
    	end

        -- self.lastShowObj.aperture_manager:SetOpenNotMove(self.lastShowObj.aperture_manager.attackTargetFootEffect, false, nil, 0, 0, 0, 1, 1);
        
    end
    if obj and obj.aperture_manager and isChangeTargetEffect then
    	if obj:GetCanNotAttack() then
    		obj.wait_can_attach_show_target_effect = true
    	else
			local bindNode = obj:GetBindObj(3)
			local x, y, z = 0, 0, 0
			if bindNode then
				x, y, z = bindNode:get_position()
			end
    		obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.changeTargetHeadEffect, true, bindNode, x, y, z, 1, 1, obj, nil, true, nil);
        	obj.showChangeTargeEffect = os.clock();
    	end
        -- obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.attackTargetFootEffect, true, obj:GetBindObj(3), 0, 0, 0, 1, 1, obj);
        
    end
    self.lastShowObj = obj
end

function Player:ShowAttackEffect(obj, times)
	if not self.attackObj then
		self.attackObj = {};
	end
	if self.attackObjTime ~= times then
		for k,obj in pairs(self.attackObj) do
		    if obj and obj.aperture_manager then
	            obj.aperture_manager:SetAttackAperture(false);
	        end
		end
		self.attackObjTime = times;
	end
	table.insert(self.attackObj,obj);
    if obj and obj.aperture_manager then
    	obj.aperture_manager:SetAttackAperture(true);
    end
end

--设置首充标志
function Player:SetFirstRechargeFlag(flag)
	self.firstRechargeFlag = flag;
	self:AnalysisFlag(flag);
end

function Player:AnalysisFlag(flag)
	if not flag then return end
    local bit31 = bit.bit_and(flag, 2147483647);
    bit31 = bit.bit_rshift(bit31, 30);

    local bit30 = bit.bit_and(flag, 1073741823);
    bit30 = bit.bit_rshift(bit30, 29);
    local bit_low16 = bit.bit_and(flag, 65535);
    --充过值
    if bit31 == 1 then
        --领过奖
        if bit30 == 1 then
        	self.firstRechargeType = ENUM.ETypeFirstRecharge.haveGet;
        --没领过奖
        else
        	self.firstRechargeType = ENUM.ETypeFirstRecharge.noGet;
        end
    --没充过值
    else
    	self.firstRechargeType = ENUM.ETypeFirstRecharge.noRecharge;
    end
end

--得到首充标志
function Player:GetFirstRechargeFlag()
	return self.firstRechargeFlag;
end

--得到首充状态
function Player:GetFirstRechargeType()
	return self.firstRechargeType;
end

function Player:GetCountryId()
	return self.country_id
end

--获得技能cd时间
function Player:GetSkillPointCDInfo()
	local _deltaTime = PublicFunc.QueryDeltaTime(self.beginGetCDTime);
	local _curCD = self.skillPointCD - math.modf(_deltaTime/1000);
	if _curCD <= 0 then
		return self.skillPoint, 0;
	else
		return self.skillPoint, _curCD;
	end
end

function Player:UpdateGetFriendAPTimes(times)
	if self.get_friend_ap_times ~= times then
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Friend_GetApTimesChange);
	end
	self.get_friend_ap_times = (times or 0);
	
end

function Player:LastCanGetFriendAP()
	local curTims = (self.get_friend_ap_times or 0);
	local max_times = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_times_each_day).data
	local ap_value = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_each_time).data
	if curTims >= max_times then
		return 0
	else
		return (max_times-curTims)*ap_value
	end
end

--服务器来了一批名字后缓存下来
function Player:SetRollNameList( list )
	self.rollnamelist = list
end

function Player:getRollNameList()
	return self.rollnamelist	
end

function Player:GetAP()
    return self.ap
end

function Player:GetOldAP()
    return self.oldData.ap
end

function Player:GetMaxAP(level)
    if level == nil then
        level = self.level
    end
    local maxap = 0
    local levelConfig = ConfigManager.Get(EConfigIndex.t_player_level,level)
    if levelConfig then
        maxap = maxap + levelConfig.max_ap
    end

    local vipCfg = g_dataCenter.player:GetVipData();
    if vipCfg then
    	maxap = maxap + vipCfg.max_ap
    end

    return maxap
end

function Player:GetMaxSP(level)
	if level == nil then
		level = self.level
	end
	local maxsp = 0
	local levelConfig = ConfigManager.Get(EConfigIndex.t_player_level,level)
	if levelConfig then
	    maxsp = maxsp + levelConfig.max_sp
	end
    
	--local vipCfg = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip);
	--if vipCfg then
	--    maxap = maxap + vipCfg.max_ap
	--end
    
	return maxsp
end

--[设置实名认证]
function Player:SetIsRealNameAuth(isRealNameAuth)
	self.IsRealNameAuth =  isRealNameAuth
end

--[获取是否实名认证]
function Player:GetIsRealNameAuth()
	return self.IsRealNameAuth
end

function Player:SetIsWaitingPlayerData(is)
	self._isWaitingPlayerData = is
end

function Player:GetIsWaitingPlayerData(is)
	return self._isWaitingPlayerData
end

function Player:GetPlayerMaxLv()
	if self._maxLevel == nil then
		self._maxLevel = ConfigManager.GetDataCount(EConfigIndex.t_player_level);
	end
	return self._maxLevel;
end

function Player:SetRunGameTime(time)
	self.IsRunGameTime = math.floor(time/3600)
end

function Player:GetRUnGameTIme()
	return self.IsRunGameTime
end

function Player:WriteRealNameFile()
	
end

function Player:GetGmSwitch()
	return self.gmSwitch;
end

---------- vip ----------------------

function Player:GetVipData( )
	local cur_vip = g_dataCenter.player.vip;
	local max_vip = self:GetVipMax();
	if cur_vip < 0 then
		cur_vip = 0;
	elseif cur_vip > max_vip then
		cur_vip = max_vip;
	end
	
	return self:GetVipDataConfigByLevel(cur_vip);
end

function Player:GetNextVipData( )
	local vip_data = nil;
	local vip_config = self:GetVipDataConfigByLevel(g_dataCenter.player.vip);
	
	local next_vip = g_dataCenter.player.vip + 1;
	local max_vip = self:GetVipMax();
	if next_vip > max_vip then
		next_vip = max_vip;
	end
	
	vip_data = self:GetVipDataByLevel(next_vip);
	return vip_data;
end

function Player:GetUpVipData( )
	local vip_config = nil;	
	local vip_data = nil;
	local vip = g_dataCenter.player.vip;
	local up_vip = vip - 1;
	if up_vip < 0 then
		up_vip = 0;
	end
	
	return self:GetVipDataByLevel(up_vip);
end

function Player:GetVipDataConfigByLevel( level )
	local vip_config = ConfigManager.Get(EConfigIndex.t_vip_data, level);
	return vip_config;
end

function Player:GetVipDataByLevel( level, vipstar )
--	app.log("-------------------- level:" .. level .. ' vipstar:' .. tostring(vipstar));
	return self:GetVipDataConfigByLevel( level );
end

function Player:GetVipConfigByLevel( level )
	local vip_config = {};
	local vip_table = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
	for k,v in pairs(vip_table) do
		if v and v.level == level then
			table.insert(vip_config, v);
		end
	end
	return vip_config;
end

function Player:GetVipMax( )
	local vip_table = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
	-- app.log("GetVipMax:" .. #vip_table - 1)
	return #vip_table; -- 从0开始
end

function Player:GetVipMaxLevel(  )
	local max_level = 0;
	local vip_max = self:GetVipMax();
	local vip_max_data = self:GetVipDataConfigByLevel(vip_max);
	if vip_max_data then
		max_level = vip_max_data.level;
	end
	return max_level;

end

function Player:GetVipStarMax( level )
	local vip_config = g_dataCenter.player:GetVipDataConfigByLevel(level);
	local num = 0;
	if vip_config then
		for k,v in pairs(vip_config) do
			num = math.max(num, v.level_star);
		end
	end
	return num;
end

function Player:CheckVipRedPoint( )
	local state = false;

	----- 背包有礼包，能升一级
	state = self:GetVipIsLevel();

	-- 每日可领取
	if not state then
		state = g_dataCenter.player.vip > 0 and g_dataCenter.player.vipEveryGet == 0;
	end

	-- 等级礼包
	if not state and not VipPackingUI.is_open then
		for i=1, g_dataCenter.player.vip do
			local isGet = bit.bit_and(g_dataCenter.player.vip_reward_flag, bit.bit_lshift(1, i)) > 0;
			if not isGet then
				state = true;
				break;
			end
		end
	end 

	self:SetVipRedPoint(state);
end

function Player:GetVipIsLevel(  )
	local state = false;
	local check = true;
	if g_dataCenter.player.vip >= self:GetVipMax() then 
		check = false;
	end

	if not check then
		do return state; end
	end

	local need_exp = 0;
	local diff_exp = 0;
	local vip_data = self:GetVipDataByLevel(g_dataCenter.player.vip);
	if vip_data then
		diff_exp = vip_data.need_exp - g_dataCenter.player.vipexp;
	end
	local have_exp = 0;
	local dis_item_data = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_vip_up_item).data;
	if dis_item_data then
		for k,v in pairs(dis_item_data) do
			local cont = g_dataCenter.package:GetCountByNumber(v.item_id);
			have_exp = have_exp + cont * v.item_exp;
			if have_exp >= diff_exp then
				state = true;
				break;
			end
		end
	end

	do return state; end
end

function Player:SetVipRedPoint( state )
	if not self.m_vip_redPoint then
		self.m_vip_redPoint = state;
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_VipGiftPack);
	elseif self.m_vip_redPoint or self.m_vip_redPoint ~= state then
		self.m_vip_redPoint = state;
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_VipGiftPack);
	end
	
end

function Player:GetVipRedPoint( )
	if self.m_vip_redPoint then
		do return self.m_vip_redPoint; end
	end
	do return false; end
end

function Player:SetAllHeroOwnProperty(prop)
	local count = #prop
	for i=1, count do
		self.allHeroOwnProperty[ENUM.min_property_id+i] = prop[i]
	end
end

function Player:GetAllHeroOwnProperty()
	return self.allHeroOwnProperty
end

return Player
