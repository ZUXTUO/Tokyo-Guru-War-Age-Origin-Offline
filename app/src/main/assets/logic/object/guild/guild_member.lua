-- 社团成员数据

GuildMember = Class('GuildMember')

-- 参考<SGuildMemberData>
function GuildMember:Init(data)
	self.playerid			= data.playerid or 0		-- 玩家唯一id <Player>
	self.name				= data.szName or ""			-- 玩家名
	self.level				= data.nLevel or 0			-- 玩家等级
	self.vipLevel			= data.nVipLevel or 0		-- 玩家VIP等级
	self.imageId			= data.nImage or 0			-- 玩家头像Id
	self.job				= data.job or ENUM.EGuildJob.Member		-- 玩家职位
	self.online				= data.bOnline				-- 玩家在线状态
	self.activePoints		= data.activePoints or 0		-- 玩家可用活跃积分
	self.totalPoints		= data.activeTotalPoints or 0	-- 玩家贡献总活跃积分
	self.todayPoints		= data.todayPoints or 0			-- 玩家当天活跃节分
	self.guildCurreny		= data.guildMoney or 0			-- 玩家拥有的社团货币
	self.lastOffLineTime	= tonumber(data.lastOffLineTimes) or 0  -- 玩家上次离开游戏时间
	self.totalFight			= tonumber(data.fightValue) or 0			-- 玩家战队总战力

	-- 社团活动参与统计不用保存，需要用时及时拉取<SMemberActivityRecord>

	return self
end

-------------------------------------接口-------------------------------------
-- 成员数据改变<SGuildMemberData>
function GuildMember:UpdateData(data)
	if data == nil then return end

	if data.szName then				self.name = data.szName end
	if data.nLevel then				self.level = data.nLevel end
	if data.nVipLevel then			self.vipLevel = data.nVipLevel end
	if data.job then				self.job = data.job end
	if data.nImage then				self.imageId = data.nImage end
	if data.bOnline ~= nil then		self.online = data.bOnline end
	if data.activePoints then		self.activePoints = data.activePoints end
	if data.activeTotalPoints then	self.totalPoints = data.activeTotalPoints end
	if data.todayPoints then		self.todayPoints = data.todayPoints end
	if data.guildMoney then			self.guildCurreny = data.guildMoney end
	if data.fightValue then			self.totalFight = tonumber(data.fightValue) end
end