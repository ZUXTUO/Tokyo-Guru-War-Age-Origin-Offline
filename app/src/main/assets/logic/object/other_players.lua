OtherPlayers = Class('OtherPlayers');

function OtherPlayers:Init()
	self.playerList = {};
end

------------------------外部接口---------------------------------------

--[[增加一个角色，
--systemid 系统id 参见ENUM.ESystemId
--playerinfo 通过player类加上package生成的背包类：player.package(类)
-- ]]
function OtherPlayers:AddPlayer(systemid, playerinfo)
	if not self.playerList[systemid] then
		self.playerList[systemid] = {};
	end
	table.insert(self.playerList[systemid],playerinfo);
end

--查看某个功能数据是不否存在
--systemid 系统id 参见ENUM.ESystemId
--返回{}
function OtherPlayers:CheckSsystem(systemid)
	if self.playerList[systemid] then
		if table.getn(self.playerList[systemid]) > 0 then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

--返回某个功能的全部数据
--systemid 系统id 参见ENUM.ESystemId
--返回{}
function OtherPlayers:GetSsystem(systemid)
	if self.playerList[systemid] then
		return self.playerList[systemid];
	else
		return {};
	end
end

--清空某个功能的全部数据
--systemid 系统id 参见ENUM.ESystemId
--返回{}
function OtherPlayers:ClearSsystem(systemid)
	self.playerList[systemid]  = {};
end

--返回某个玩家数据
--systemid 系统id 参见ENUM.ESystemId
--playerid 玩家唯一id
--返回 Player类
function OtherPlayers:GetPlayer(systemid, playerid)
	if self.playerList[systemid] then
		return self.playerList[systemid][playerid];
	else
		return nil;
	end
end