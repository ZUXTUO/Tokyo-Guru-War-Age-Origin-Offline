Fuzion2Player = Class('Fuzion2Player')

function Fuzion2Player:Init(data)
	self.playerid 	= data.playerid or 0
	self.name 		= data.name or data.owner_name or ""
	self.HeroList 	= data.cardConfigID or {};
	self.heroLevel	= data.heroLevel or 1
	self.playerImage = data.image or 1;
	self.isRobot = data.bRobot == 1;
	self.area = data.countryid or 1;
	self.percent = 0;

	self.ready		= false	-- 房间玩家准备就绪状态
	self.loadPercent= 0		-- 加载进度
	self.reliveTime = 0
	self.kill   = data.kill or 0
	self.dead 	= data.dead or 0
	self.countinuesKill = data.continuousKillPlayerCnt or 0
	self.oldcountinueskill = 0
	self.surviveTime = 0;
    --app.log("##############"..table.tostring(data))
	return self
end

-------------------------------------接口-------------------------------------

function Fuzion2Player:SetReady(bool)
	self.ready = bool
end

function Fuzion2Player:SetLoadPercent(percent)
	self.loadPercent = percent
end
-- 设置基础数据（来自mmo系统）
function Fuzion2Player:SetBaseData(data)
  if self.name == data.owner_name then
  	if data.player_gid then self.herogid = data.player_gid end
    if data.owner_name then self.name = data.owner_name end
    if data.config_id then self.herocid = data.config_id end
    --if data.level then self.heroLevel = data.level end
  end
end
function Fuzion2Player:UpdateKillData(data)
	if self.playerid == data.playerid then
		if data.deadTimes     then self.dead = data.deadTimes end
		if data.fighter_gid     then self.herogid = data.fighter_gid end
		if data.killPlayerCnt then self.kill = data.killPlayerCnt end
		if data.surviveTime then self.surviveTime = data.surviveTime end
		if data.continuousKillPlayerCnt then
			self.oldcountinueskill = self.countinuesKill
			self.countinuesKill = data.continuousKillPlayerCnt
		end
	end
end
-- 复活时间点
function FuzionFighter:SetReliveTime(time)
  self.reliveTime = tonumber(time) or 0
end