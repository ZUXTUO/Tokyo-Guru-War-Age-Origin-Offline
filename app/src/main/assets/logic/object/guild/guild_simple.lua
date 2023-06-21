-- 简单社团信息，用于浏览的社团列表数据

GuildSimple = Class('GuildSimple')

-- 参考<SGuildSimpleData>
function GuildSimple:Init(data)
	self.id 			= data.guildID or 0					-- 社团ID
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
	self.totalFight		= data.fightValue or 0				-- 社团总战力
	self.addMemberCntlevel = data.guildLabAddMemberCntlevel or 1 -- 社团科技增加人数等级

	return self
end

-------------------------------------接口-------------------------------------
-- 社团数据改变<SGuildSimpleData>
function GuildSimple:UpdateData(data)
	if data == nil then return end
	
	if data.searchID then			self.searchid = data.searchID end
	if data.szName then				self.name = data.szName end
	if data.IconIndex then			self.icon = data.IconIndex end
	if data.szDeclaration then		self.declaration = data.szDeclaration end
	if data.guildLevel then			self.level = data.guildLevel end
	if data.szLeaderName then		self.leaderName = data.szLeaderName end
	if data.memberCnt then			self.membersNum = data.memberCnt end
	if data.countryid then			self.countryid = data.countryid end
	if data.limitJoinLevel then		self.applyLevel = data.limitJoinLevel end
	if data.ApproveRule then 		self.approvalRule = data.ApproveRule end
	if data.rankindex then 			self.rank = data.rankindex end
	if data.fightValue then 		self.totalFight = data.fightValue end
	if data.guildLabAddMemberCntlevel then 		self.addMemberCntlevel = data.guildLabAddMemberCntlevel end
end