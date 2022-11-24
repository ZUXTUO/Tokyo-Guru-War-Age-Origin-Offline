FuzionRank = Class('FuzionRank')

function FuzionRank:Init(data)
	self.playerid 	= data.playerid or 0
	self.name		= data.name or ""
	self.point		= data.point or 0
	self.rank		= data.rankIndex or 0	--客户端按序号写入
	self.herocid	= data.heroIndex or 0
	return self
end

-------------------------------------接口-------------------------------------

