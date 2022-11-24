FuzionChampion = Class('FuzionChampion')

function FuzionChampion:Init(data)
	self.playerid 	= data.playerid or 0
	self.name		= data.name or ""
	self.point		= data.point or 0
	self.herocid	= data.heroIndex or 0
	self.seasonIndex= data.seasonIndex or 0
	return self
end

-------------------------------------接口-------------------------------------

