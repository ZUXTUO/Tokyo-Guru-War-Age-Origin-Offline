Fuzion2Fighter = Class('Fuzion2Fighter')

-- struct fight_base_data
-- {
--   string owner_gid;
--   string owner_name;
--   uint player_gid;
--   int config_id;
--   int max_hp;
--   int cur_hp;
--   short x;
--   short y;
--   float move_speed;
--   short des_x;
--   short des_y;
--   int8 camp_flag; //0友方 1敌方
-- };
-- struct daluandou_kill_data
-- {
--   string playerid;
--   int fighter_gid;
--   int deadTimes;
--   int killPlayerCnt;
--   int continuousKillPlayerCnt;
-- }
function Fuzion2Fighter:Init(data)
	self.playerid 	= data.owner_gid or 0
  self.name     = data.owner_name or ""
  self.herocid  = data.config_id or 0;
  self.herogid  = data.player_gid or 0
	self.heroLevel	= data.level or 1

  --------------- 玩法更新的数据 -------------
  self.kill   = data.kill or 0
	self.dead 	= data.dead or 0
  self.countinuesKill = data.continuousKillPlayerCnt or 0
  self.oldcountinueskill = 0

  self.reliveTime = 0

	return self
end

-------------------------------------接口-------------------------------------
-- 设置基础数据（来自mmo系统）
function Fuzion2Fighter:SetBaseData(data)
  if self.herogid == data.player_gid then
    if data.owner_gid then self.playerid = data.owner_gid end
    if data.owner_name then self.name = data.owner_name end
    if data.config_id then self.herocid = data.config_id end
    if data.level then self.heroLevel = data.level end
  end
end
-- 设置玩法数据
function Fuzion2Fighter:UpdateKillData(data)
	if self.herogid == data.fighter_gid then
		if data.deadTimes     then self.dead = data.deadTimes end
		if data.killPlayerCnt then self.kill = data.killPlayerCnt end
		if data.continuousKillPlayerCnt then
			self.oldcountinueskill = self.countinuesKill
			self.countinuesKill = data.continuousKillPlayerCnt
		end
		if data.surviveTime then self.surviveTime = data.surviveTime end
	end
end
-- 复活时间点
function Fuzion2Fighter:SetReliveTime(time)
  self.reliveTime = tonumber(time) or 0
end
