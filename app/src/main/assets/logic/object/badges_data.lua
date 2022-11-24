--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/8/13
-- Time: 14:27
-- To change this template use File | Settings | File Templates.
--

--[[徽章抢夺队伍信息]]
BadgesData = Class("BadgesData");

function BadgesData:Init()
	self.data = {};--[[徽章抢夺队伍信息，list<OtherPlayers>]]
end

--[[查看是否有队伍信息]]
function BadgesData:chaeckHaveData()
	if table.getn(self.data) > 0 then
		return true;
	else
		return false;
	end
end

--[[清除队伍信息]]
function BadgesData:delContingent()
	self.data = {};
end

--[[更新队伍信息]]
function BadgesData:upContingent(list_contingents)
	if list_contingents == nil then return end;
	if not PublicFunc.check_type_table(list_contingents) then return end;
	self.data = list_contingents;
end

--[[得到队伍信息]]
function BadgesData:getContingent()
	return self.data;
end