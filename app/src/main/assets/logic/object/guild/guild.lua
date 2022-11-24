Guild = Class('Guild')

function Guild:Init()
	self.simpleList = nil			-- 公会简表 <GuildSimple> 用来暂存
	self.simpleIndex = 0			-- 公会列表请求次数索引（每次取24条）
	self.simpleCount = 0			-- 当前公会数量
	self.memberActivityRecord = {}	-- 公会成员活动记录 <SMemberActivityRecord> 用来暂存
	self.detail	= nil				-- 自己所在公会信息 <GuildDetail>
	self.applyGuildId = "0"			-- 自己申请公会Id (申请冻结由服务器做判断)
	self.myGuildId = "0"				-- 自己所在公会Id
	self.lastQuitTime = 0			-- 上次退出公会的时间点

	self.base_apply_count = 0
	self.base_job = 0

	return self
end

local _EGuildJobName ={
	[1] = "社长",
	[2] = "副社长",
	[3] = "精英",
	[4] = "社员",
}

local _Item = {
    EditNotice = 0,
    GuildShop = 1,
    GuildNotice = 2,
    GuildWar = 3,
    GuildTech = 4, 
    GuildRank = 5, 
    GuildHall = 6, 
    GuildBoss = 7,
    GuildLS = 8,
    GuildRedPacket = 9,
    GuildTasks = 10,
}

-------------------------------------接口-------------------------------------
-- 得到职务名字
function Guild.GetJobName(job)
	local result = ""

	if job == ENUM.EGuildJob.President then
		result = PublicFunc.GetColorText(_EGuildJobName[1], "orange_light")
	elseif job == ENUM.EGuildJob.VicePresident then
		result = PublicFunc.GetColorText(_EGuildJobName[2], "orange_light")
	elseif job == ENUM.EGuildJob.Minister then
		result = PublicFunc.GetColorText(_EGuildJobName[3], "orange_light")
	elseif job == ENUM.EGuildJob.Member then
		result = PublicFunc.GetColorText(_EGuildJobName[4], "white")
	end

	return result
end

-- 取得显示查找id(取后2个字节)
function Guild.GetVisibleId(id)
	if id == nil then return 0 end
	return bit.bit_and(id, 65535)
end


-- 返回社团玩家数量
function Guild.GetMemberNumber(data)
	if not data then return 0 end

	return data.membersNum
end

-- 取得社团职位已有人数
function Guild.GetMemberJobCnt(data, job)
	if not data then return 0 end

	local result = 0
	for i, member in pairs(data.members) do
		if member.job == job then
			result = result + 1
		end
	end
	return result
end

-- 取得社团职位人数上限
function Guild.GetMemberJobLimit(data, job)
	if not data then return 0 end
	
	local base, extra = 0, 0
	local config = ConfigManager.Get(EConfigIndex.t_guild_level, data.level)
	if job == ENUM.EGuildJob.President then
		base = config.leader_base_limit
	elseif job == ENUM.EGuildJob.VicePresident then
		base = config.vice_leader_base_limit
	elseif job == ENUM.EGuildJob.Minister then
		base = config.elite_base_limit

		-- 社团科技额外增加
		if data.GetScienceInfo then
			local eliteLab =  data:GetScienceInfo(1,2)
			config = ConfigManager.Get(EConfigIndex.t_guild_lab_elite_num_add_level, eliteLab.lv or 1) or {}
			extra = config.param1 or 0
		end
	end

	return base + extra
end

-- 取得社团总人数上限
function Guild.GetMemberLimit(data)
	if not data then return 0 end

	local config = ConfigManager.Get(EConfigIndex.t_guild_level, data.level)
	local base = config.member_limit

	-- 社团科技额外增加
	local extra = 0
	config = ConfigManager.Get(EConfigIndex.t_guild_science, 1) -- 社团实验室开启等级配置
	if config and config.guild_level <= data.level then
		if data.GetScienceInfo then
			local memberLab =  data:GetScienceInfo(1,1)
			config = ConfigManager.Get(EConfigIndex.t_guild_lab_num_add_level, memberLab.lv or 1) or {}
			extra = config.param1 or 0
		elseif data.addMemberCntlevel then
			config = ConfigManager.Get(EConfigIndex.t_guild_lab_num_add_level, data.addMemberCntlevel) or {}
			extra = config.param1 or 0
		end
	end
	-- config = ConfigManager.Get(EConfigIndex.t_guild_lab_num_add_level, data.addMemberCntlevel) or {}
	-- local extra = config.param1 or 0

	return base + extra
end




-- 是否已经拉取了公会数据
function Guild:IsPulledDetail()
	return (self.detail ~= nil)
end

-- 检查是否社团数据有变化，重拉数据
function Guild:CheckDataChange()
	local detail = self.detail
	if detail then
		local dataCenterPlayer = g_dataCenter.player
		local myData = detail.members[dataCenterPlayer.playerid]
		if myData then
			if  myData.name ~= dataCenterPlayer:GetName() or 
				myData.level ~= dataCenterPlayer:GetLevel() or
				myData.vipLevel ~= dataCenterPlayer:GetVip() or
				myData.totalFight ~= dataCenterPlayer:GetFightValue() then
				return true
			end
		end
	end
	return false
end

-- 是否已经已有公会
function Guild:IsJoinedGuild()
	return tonumber(self.myGuildId) > 0
end

-- 保存公会列表数据
function Guild:SetSimpleListData(index, totalCnt, data)
	self.simpleIndex = index
	self.simpleCount = totalCnt
	self.simpleList = {}
	for i, v in ipairs(data) do
		table.insert(self.simpleList, GuildSimple:new(v))
	end
end

-- 获取公会完整数据
function Guild:GetDetail()
	return self.detail;
end

--[[是否是社长]]
function Guild:IsPresident()
    if self.detail and self.detail.leaderName then
        return self.detail.leaderName == g_dataCenter.player:GetName()
	end
    return false
end

function Guild:IsManagerJob()
	local myData = self:GetMyMemberData()
	if myData then
		return myData.job < ENUM.EGuildJob.Member
	elseif self.base_job and self.base_job > 0 then
		return self.base_job < ENUM.EGuildJob.Member
	end
	return false
end

-- 返回玩家数据列表
function Guild:GetMemberData()
	if self.detail then
		return self.detail.members
	end
	return {}
end

--得到排序后的成员数 (职位->在线->等级)
function Guild:GetSortMemberData()
	local result = {}
	if self.detail then
		for i, v in pairs(self.detail.members) do
			table.insert(result, v)
		end
		table.sort(result, function (a, b)
			if a == nil or b == nil then return false end

			if a.job ~= b.job then
				return a.job < b.job
			elseif a.online ~= b.online then
				return (a.online == true)
			else
				return a.level > b.level
			end
		end)
	end
	return result
end

-- 返回指定索引的玩家数据
function Guild:GetMemberDataByIndex(index)
	if self.detail then
		return self.detail.members[index]
	end
end

-- 返回我的玩家数据
function Guild:GetMyMemberData()
	local myplayerid = g_dataCenter.player.playerid
	if self.detail then
		for i, v in pairs(self.detail.members) do
			if v.playerid == myplayerid then
				return v
			end
		end
	end
end

-- 返回指定成员的玩家数据
function Guild:GetMemberDataByPlayerId(playerid)
	if self.detail then
		for i, v in pairs(self.detail.members) do
			if v.playerid == playerid then
				return v
			end
		end
	end
end

-- 返回指定索引的公会玩家申请数据
function Guild:GetPlayerApplyByIndex(index)
	if self.applyList then
		return self.applyList[index]
	end
end

-- 设置玩家对象活动记录
-- {
-- 	{
-- 		playerid = 10000,
-- 		points = {
-- 			{times = 1, addValue = 0},
-- 			{times = 1, addValue = 0},
-- 			{times = 1, addValue = 0},
-- 		},
-- 	},
-- 	{
-- 		playerid = 10001,
-- 		points = {
-- 			{times = 1, addValue = 0},
-- 			{times = 1, addValue = 0},
-- 			{times = 1, addValue = 0},
-- 		},
-- 	},
-- }
function Guild:SetMemberActivityData(ntype, data)
	local totalRecord = {}
	for i, v in ipairs(data) do
		local memberRecord = {}
		memberRecord.playerid = v.playerid
		memberRecord.points = {}
		for j, n in ipairs(v.vecActiveData or {}) do
			local record = {}
			record.times = n.times or 0
			record.addValue = n.pointValue or 0
			table.insert(memberRecord.points, record)
		end
		table.insert(totalRecord, memberRecord)
	end
	-- 本日
	if ntype == 1 then
		self.memberActivityRecord[1] = totalRecord
	-- 本周
	elseif ntype == 2 then
		self.memberActivityRecord[2] = totalRecord
	-- 本月
	elseif ntype == 3 then
		self.memberActivityRecord[3] = totalRecord
	end
end

-- 获取玩家对象活动记录
function Guild:GetMemberActivityData(ntype)
	return self.memberActivityRecord[ntype]
end

-- 设置申请的公会id
function Guild:SetApplyGuildId(guildid)
	self.applyGuildId = guildid
end

-- 设置上次离开公会时间
function Guild:SetLastQuitTime(time)
	self.lastQuitTime = tonumber(time) or 0
end

-- 设置自己公会id
function Guild:SetMyGuildId(guildid)
	if tonumber(guildid) then
		self.myGuildId = guildid
	else
		self.myGuildId = "0"
	end
	if self.myGuildId == "0" then
		self.detail = nil
		self.guildLog = nil
		self.applyList = nil
	 	g_dataCenter.guildBoss = GuildBossData:new();
	 	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_GuildBoss] = g_dataCenter.guildBoss
	end
end

-- 清除我的公会信息
function Guild:ClearMyGuild()
	self.myGuildId = "0"
	self.detail = nil
	self.guildLog = nil
	self.applyList = nil

	self.base_detail = nil
	self.base_apply_count = 0
	self.base_job = 0
end

-- 是否有入会申请提示
function Guild:GetApplayDataCount()
	return self.base_apply_count

    -- if self:CheckLevelLimit(_Item.GuildHall) then
    --     return false
    -- end

	-- local count = 0

	-- if self.detail then
	-- 	count = #self.detail.applyList
	-- else
	-- 	count = self.base_apply_count
	-- end

	-- return count;
end

-- 社团科技捐献次数是否有剩余
function Guild:IsDonateRemain()
    if self:CheckLevelLimit(_Item.GuildTech) then
        return false
    end
	local result = false

	if self.detail then
		result = self.detail.donateTimes > 0
	end

	return result
end

-- 社团boss是否处于激活（可挑战）状态
function Guild:IsBossActive()
    if self:CheckLevelLimit(_Item.GuildBoss) then
        return false
    end

	local result = false
	if g_dataCenter.guildBoss then
		repeat
			local config = ConfigManager.Get( EConfigIndex.t_guild_boss, g_dataCenter.guildBoss.curRoundIndex );
			if not config then
				break;
			end

			--1.活动时间内
			local nowTime = system.time()
			local nowDate = os.date('*t', nowTime)
			local beginTime = os.time(
				{ year=nowDate.year, month=nowDate.month, day=nowDate.day, 
				hour=config.hour, min=config.min, sec=config.sec })
			local endTime = beginTime + tonumber(config.last_time);
			if beginTime > nowTime or endTime < nowTime then
				break;
			end

			--2.boss未死亡
			if g_dataCenter.guildBoss.bossDeadTime and g_dataCenter.guildBoss.bossDeadTime > beginTime then
				break;
			end

			result = true

		until true;
	end

	return result;
end

-- 社团入口提示
-- function Guild:GetEntryTips()
-- 	if self.detail then
-- 		return self:IsApplayDataTips() or self:IsBossActive() or self:IsDonateRemain()
-- 	end
-- 	return false
-- end

function Guild:CheckLevelLimit(index)
    if self.detail and self.detail.level then
        local levelLimit = self:GetLimitLevel(index)
        if levelLimit ~= nil and self.detail.level < levelLimit then
            return true
        end
    end
    return false
end

function Guild:GetLimitLevel(index)
	local config = ConfigManager.Get(EConfigIndex.t_guild_scene, index)
	if config.actity_id ~= 0 then
		local cfAct = ConfigManager.Get(EConfigIndex.t_guild_activity, config.actity_id)
		return cfAct.openLevel
	end
    return nil
end

--获取自己所在的公会ID
function Guild:GetMyGuildId()
	return self.myGuildId
end

--获取自己公会名字
function Guild:GetMyGuildName()
	if self.detail then
		return self.detail.name;
	elseif self.base_detail then
		return self.base_detail.name;
	else
		return ""
	end
end

function Guild:LoadGuildDetail(data)
	self.detail = GuildDetail:new(data)
end

function Guild:UpdateGuildBaseData(data, applyCount, job)
	self.base_detail = GuildDetail:new(data)
	self.base_apply_count = applyCount
	self.base_job = job
end

function Guild:UpdateGuildLevelInfo(level, curExp, todayGrowExp, todayGrowContribution)
	if self.detail then
		self.detail:UpdateGuildLevelInfo(level, curExp, todayGrowExp, todayGrowContribution)
	end
end

function Guild:SetDonateTimes(times)
	if self.detail then
		self.detail:SetDonateTimes(times);
	end
end

function Guild:UpdateScienceInfo(type, subitem_type, lv, curExp)
	if self.detail then
		self.detail:UpdateScienceInfo(type, subitem_type, lv, curExp)
	end
end

-- 增加一条日志记录
function Guild:InsertLog(data, isInit)
	if self.guildLog == nil then return end

	if data then
		local log = {}
		log.time = tonumber(data.time) or 0
		log.ntype = data.ntype
		log.params = data.parms
		table.insert(self.guildLog, log)

		-- 按最近时间排序
		if not isInit then
			table.sort(self.guildLog, function ( a, b )
				if a == nil or b == nil then return false end
				return a.time > b.time
			end)
		end
	end
end

function Guild:LoadLogData(vecdata)
	self.guildLog = {}

	for i, v in ipairs(vecdata or table.empty()) do
		self:InsertLog(v, true)
	end

	-- 按最近时间排序
	table.sort(self.guildLog, function ( a, b )
		if a == nil or b == nil then return false end
		return a.time > b.time
	end)
end

function Guild:IsLoadLogData()
	return self.guildLog ~= nil
end

function Guild:GetLogData()
	return self.guildLog or table.empty()
end

-- 增加一条申请记录 <SApplyPlayerData>
function Guild:InsertApplyItem(data)
	self.base_apply_count = self.base_apply_count + 1
	if self.applyList == nil then return end

	if data then
		local member = {}
		member.playerid = data.playerid
		member.imageId = data.image or 0 -- 玩家头像id
		member.name = data.name
		member.level = data.player_level
		member.vipLevel = data.nVipLevel or 0
		member.time = data.applyTime or 0 -- TODO 带服务器添加
		table.insert(self.applyList, member)
	end
end

-- 删除一条申请记录 <SApplyPlayerData>
function Guild:RemoveApplyItem(data)
	self.base_apply_count = math.max(0, self.base_apply_count - 1)
	if self.applyList == nil then return end

	if data then
		for i, v in pairs(self.applyList) do
			if v.playerid == data.playerid then
				return table.remove(self.applyList, i)
			end
		end
	end
end

function Guild:LoadApplyData(vecdata)
	self.applyList = {}

	self.base_apply_count = 0
	for i, v in ipairs(vecdata or table.empty()) do
		self:InsertApplyItem(v)
	end
end

function Guild:IsLoadApplyData()
	return self.applyList ~= nil
end

function Guild:GetApplyData()
	return self.applyList or table.empty()
end
