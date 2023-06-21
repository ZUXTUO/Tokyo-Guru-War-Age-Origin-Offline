------------------------- 排行榜玩家对象 ---------------------------
RankPlayer = Class('RankPlayer')

function RankPlayer:Init(data)
	self.playerid	= data.playerid or 0
	self.playerName	= data.player_name or 0
	self.value		= data.score or 0
	self.ranking 	= data.ranking or 0
	self.heroCids 	= data.herosid or {}

	return self
end


------------------------- 排行榜数据对象 ---------------------------
Rank = Class("Rank");

-- 数据结构参考 ranking_list_item
    -- playerid
    -- player_name
    -- score
    -- ranking
    -- herosid

function Rank:SetData(group, data)
    self.data[group] = data
end

function Rank:GetData(group)
   if self.data then
        return self.data[group]
    end
end

function Rank:Init()
    self.data = { }
end

function Rank:Finalize()
    self.data = { }
end
