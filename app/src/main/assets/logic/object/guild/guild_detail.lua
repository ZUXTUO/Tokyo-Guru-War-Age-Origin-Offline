-- 详细社团信息，保存自己所在社团数据

GuildDetail = Class('GuildDetail')

-- 参考<SGuildDetailFullData>
function GuildDetail:Init(data)
	if not data.guildID or data.guildID == "" then
		data.guildID = "0"
	end
	self.id 			= data.guildID or "0"				-- 社团ID
	self.rank			= data.rankindex or 0 				-- 社团排名
	self.searchid		= data.searchID or 0				-- 查询id(4个字节，前2个服务器id，后2个显示用id)
	self.createTime 	= data.createTime or 0				-- 创建日期
	self.name 			= data.szName or ""					-- 社团名称
	self.icon 			= data.IconIndex or 0				-- 社团图标
	self.declaration 	= data.szDeclaration or ""			-- 公告（对内对外一套）
	self.level 			= data.guildLevel or 0				-- 社团等级
	self.leaderName 	= data.szLeaderName or ""			-- 社长名字
	self.membersNum 	= data.memberCnt or 0				-- 成员数
	self.countryid		= data.countryid or 0				-- 国家ID
	self.applyLevel		= data.limitJoinLevel or 0			-- 申请限制等级
	self.approvalRule 	= data.ApproveRule or 0				-- 审核规则 0自由加入 1需要审核 2禁止加入
	self.rank			= data.rankindex or 0				-- 社团排名
	self.totalFight 	= tonumber(data.fightValue) or 0	-- 社团总战力
	self.addMemberCntlevel = data.guildLabAddMemberCntlevel or 1 -- 社团科技增加人数等级

	self.exp			= data.guildExp or 0				-- 社团当前等级经验值
	self.todayGrowExp 	= data.todayGrowExp or 0 			-- 公会今日已捐献总经验
	self.activePoints	= data.activePoints					-- 社团当前活跃积分
	self.donateTimes	= 0									-- 今日剩余捐献次数
	-- self.logs			= {}								-- 社团日志
	self.members		= {}								-- 社团成员信息
	-- self.applyList		= {}								-- 社团申请列表
	self.scienceInfoList= {}								-- 公会科技信息列表
    self.guilBossLevel = data.guild_boss_level;                             --guild boss level
    self.todayGrowContribution = data.today_grow_contribution 
	for i, v in ipairs(data.vecMember or {}) do
		self.members[v.playerid] = GuildMember:new(v)
	end

	-- 申请信息存储结构{playerid=, name=, level=}
	-- for i, v in ipairs(data.vecApplyList or {}) do
	-- 	self:InsertApplyItem(v)
	-- end

	-- 社团日志记录
	-- for i, v in ipairs(data.vecLog or {}) do
	-- 	self:InsertLog(v)
	-- end


	return self
end

-------------------------------------接口-------------------------------------
-- 社团数据改变<SGuildDetailData>
function GuildDetail:UpdateData(data)
	if data == nil then return end

	if data.searchID then			self.searchid = data.searchID end
	if data.szName then				self.name = data.szName end
	if data.IconIndex then			self.icon = data.IconIndex end
	if data.szDeclaration then		self.declaration = data.szDeclaration end
	if data.guildLevel then			
		if self.level ~= data.guildLevel then
			GNoticeGuideTip(Gt_Enum_Wait_Notice.Guild_LevelChange);
		end
		self.level = data.guildLevel
		PublicFunc.msg_dispatch("UpdateGuildLevelInfo");

	end
	if data.szLeaderName then		self.leaderName = data.szLeaderName end
	if data.memberCnt then			self.membersNum = data.memberCnt end
	if data.countryid then			self.countryid = data.countryid end
	if data.limitJoinLevel then		self.applyLevel = data.limitJoinLevel end
	if data.ApproveRule then 		self.approvalRule = data.ApproveRule end
	if data.guildExp then			self.exp = data.guildExp end
	if data.activePoints then		self.activePoints = data.activePoints end
	if data.rankindex then 			self.rank = data.rankindex end
	if data.fightValue then 		self.totalFight = tonumber(data.fightValue) end
	if data.guildLabAddMemberCntlevel then 		self.addMemberCntlevel = data.guildLabAddMemberCntlevel end
	if data.guild_boss_level then	self.guilBossLevel = data.guild_boss_level end
	if data.today_grow_contribution then	
		self.todayGrowContribution = data.today_grow_contribution 
	end
end

-- 社团成员数据改变
function GuildDetail:UpdateMemberData(type, data)
	-- 添加
	if type == 0 then
		self.members[data.playerid] = GuildMember:new(data)
		self.membersNum = self.membersNum + 1;
	-- 删除
	elseif type == 1 then
		local result = self.members[data.playerid]
		self.members[data.playerid] = nil
		self.membersNum = math.max(self.membersNum - 1, 0);
		return result
	-- 更新
	elseif type == 2 then
		local member = self.members[data.playerid]
		local oldJob = ENUM.EGuildJob.Member
		if member then
			oldJob = member.job
			member:UpdateData(data)
		end

		-- 更新社长名字
		if member.job == ENUM.EGuildJob.President then
			self.leaderName = member.name
		end

		-- 职位变更
		if member.playerid == g_dataCenter.player.playerid and oldJob ~= member.job then
			GNoticeGuideTip(Gt_Enum_Wait_Notice.Guild_JobChange, Gt_Enum.EMain_Guild_Hall_Verify);
		end
	end
end

-- TODO: 查询活动开启状态
function GuildDetail:GetActivityState(type)
	return 0
end

-- 社团改名
function GuildDetail:SetName(name)
	self.name = name
end

-- 设置社团图标
function GuildDetail:SetIcon(icon)
	self.icon = icon
end

-- 修改社团公告
function GuildDetail:SetDeclaration(words)
	self.declaration = words
end

-- 修改入会限制等级
function GuildDetail:SetApplyLevel(level)
	self.applyLevel = level
end

-- 社团成员权限管理
function GuildDetail:SetMemberPower(type, playerid, param)
	-- 踢人
	if type == 0 then
		local result = self.members[playerid]
		self.members[data.playerid] = nil
		return result
	-- 继承
	elseif type == 1 then
		local a = self.members[g_dataCenter.player.playerid]
		local b = self.members[playerid]
		-- 交换职位
		if a and b then
			local temp = b.job
			b.job = a.job
			a.job = temp
		end
	-- 职位变更
	elseif type == 2 then
		local member = self.members[playerid]
		member.job = param
	-- 解散
	elseif type == 3 then
		g_dataCenter.guild.myGuild = nil
	end
end

-- 增加一条申请记录 <SApplyPlayerData>
-- function GuildDetail:InsertApplyItem(data)
-- 	if data then
-- 		local member = {}
-- 		member.playerid = data.playerid
-- 		member.imageId = data.image or 0 -- 玩家头像id
-- 		member.name = data.name
-- 		member.level = data.player_level
-- 		member.vipLevel = data.nVipLevel or 0
-- 		member.time = data.applyTime or 0 -- TODO 带服务器添加
-- 		table.insert(self.applyList, member)
-- 	end
-- end

-- 删除一条申请记录 <SApplyPlayerData>
-- function GuildDetail:RemoveApplyItem(data)
-- 	if data then
-- 		for i, v in pairs(self.applyList) do
-- 			if v.playerid == data.playerid then
-- 				return table.remove(self.applyList, i)
-- 			end
-- 		end
-- 	end
-- end

-- 增加一条日志记录
-- function GuildDetail:InsertLog(data)
-- 	if data then
-- 		local log = {}
-- 		log.time = tonumber(data.time) or 0
-- 		log.ntype = data.ntype
-- 		log.params = data.parms
-- 		table.insert(self.logs, log)
-- 		-- 按最近时间排序
-- 		table.sort(self.logs, function ( a, b )
-- 			if a == nil or b == nil then return false end
-- 			return a.time > b.time
-- 		end)
-- 	end
-- end

function GuildDetail:UpdateGuildLevelInfo(level, curExp, todayGrowExp, todayGrowContribution)
	if level then
		self.level = level;
	end
	if curExp then
		self.exp = curExp;
	end
	if todayGrowExp then
		self.todayGrowExp = todayGrowExp;
	end
	if todayGrowContribution then
		self.todayGrowContribution = todayGrowContribution;
	end
	PublicFunc.msg_dispatch("UpdateGuildLevelInfo");
end

-- 获取单项科技可捐献列表
function GuildDetail:GetDonateCfg(id)
	if not self.donateCfgList then
		self.donateCfgList = {};
	    for k,v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_guild_tech_donate)) do
	        self.donateCfgList[v.type] = self.donateCfgList[v.type] or {};
	        table.insert(self.donateCfgList[v.type], v);
	    end
	    for k,v in pairs(self.donateCfgList) do
	        table.sort(self.donateCfgList[k], function (a,b) return a.id < b.id end);
	    end
	end
	local donateCfg = {};
    for k,v in ipairs(self.donateCfgList[id]) do
        if v.open_level <= self.level then
            table.insert(donateCfg,v);
        end
    end
	return donateCfg;
end

-- 单项科技是否有可捐献项
function GuildDetail:CanDonateOneScience(id, isRedPoint)
	local gold = g_dataCenter.player.gold;
	local crystal = g_dataCenter.player.crystal;
	local cfgList = self:GetDonateCfg(id);
	if Utility.isEmpty(cfgList) then
		return Gt_Enum_Wait_Notice.Forced;
	end
	local flg = Gt_Enum_Wait_Notice.Forced;
	for k,cfg in pairs(cfgList) do
		local num = 0;
		if cfg.item_id == 2 then
			if gold >= cfg.item_num then
				self.flgIntoDonateUI = false;
				flg = Gt_Enum_Wait_Notice.Success;
				break;
			else
				flg = Gt_Enum_Wait_Notice.Gold;
			end
		elseif cfg.item_id == 3 then
			if isRedPoint and self.flgIntoDonateUI then
			else
				if crystal >= cfg.item_num then
					flg = Gt_Enum_Wait_Notice.Success;
					break;
				end
			end
		end
	end
	if self.donateTimes == 0 then
		flg = Gt_Enum_Wait_Notice.Forced;
	end
	return flg;
end

-- 某一科技是否可捐献
function GuildDetail:CanScienceSubDonate(id, isRedPoint)
	local flg = Gt_Enum_Wait_Notice.Forced;
	if id == 0 then
		flg = self:CanDonateOneScience(id, isRedPoint);
	else
		local subScienceCfg = ConfigManager.Get(EConfigIndex.t_guild_science,id);
		local subCfgList = ConfigManager._GetConfigTable(EConfigIndex["t_"..subScienceCfg.cfg]);
		for k,subCfg in pairs(subCfgList) do
			flg = self:CanDonateOneScience(subCfg.system_id, isRedPoint)
			if flg == Gt_Enum_Wait_Notice.Success then
				break;
			end
		end
	end
	return flg;
end

function GuildDetail:CanDonate(isRedPoint)
	local num = #ConfigManager._GetConfigTable(EConfigIndex.t_guild_science);
	local flg = false;
	for i=0,num do
		local ret = self:CanScienceSubDonate(i, isRedPoint);
		if ret then
			flg = true;
			break;
		end
	end
	return flg;
end

function GuildDetail:IntoDonateUIFlg(flg)
	if flg ~= self.flgIntoDonateUI then
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_ST_Donation);
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_ST_Donation1);
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_ST_Donation2);
	end
	self.flgIntoDonateUI = flg;
end

function GuildDetail:SetDonateTimes(times)
	self.donateTimes = times;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_ST_Donation);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_ST_Donation1);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_ST_Donation2);
end

function GuildDetail:UpdateScienceInfo(type, subitem_type, lv, curExp)
	if type == 0 then
		self.level = lv;
		self.exp = curExp;
		return
	end
	self.scienceInfoList[type] = self.scienceInfoList[type] or {};
	self.scienceInfoList[type][subitem_type] = {lv=lv, exp=curExp};
end

function GuildDetail:GetScienceInfo(type, subitem_type)
	if self.scienceInfoList[type] then
		return self.scienceInfoList[type][subitem_type] or {};
	end
	return {};
end
