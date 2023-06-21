FuzionPlayer = Class('FuzionPlayer')

function FuzionPlayer:Init(data)
	self.playerid 	= data.playerid or 0
	self.name 		= data.name or ""
	self.herocid 	= data.cardConfigID or 0;
	self.herolevel	= data.level or 1

	self.ready		= false	-- 房间玩家准备就绪状态
	self.loadPercent= 0		-- 加载进度

	return self
end

-------------------------------------接口-------------------------------------

function FuzionPlayer:SetReady(bool)
	self.ready = bool
end

function FuzionPlayer:SetLoadPercent(percent)
	self.loadPercent = percent
end
