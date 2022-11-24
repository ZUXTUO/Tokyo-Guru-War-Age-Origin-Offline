--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/8/12
-- Time: 14:15
-- To change this template use File | Settings | File Templates.
--

badges = {};

--[[是否使用本地数据]]
local isLocalData = true;
local call_bakc = nil;

--[[申请挑战队伍
-- 是否新申请
--cg_contingent(bool chang)
-- ]]
function badges.cg_contingent(change,call_back)
	call_bakc = call_back;
	if isLocalData then--[[使用本地数据]]
		badges_local.cg_contingent_time();
	else
		nbadges.cg_contingent(Socket.socketServer,change);
	end

end

--[[申请队伍返回
list_contingents = {
	player_info//玩家信息
	//背包信息
	package_info = {
		list<cards_role_net> hero
		list<cards_equip_net> equip
		list<cards_item_net> item
	}
	//独立的系统数据结构
	other_data = {
		reward_list ={
			reward_id //奖励物品ID
			reward_num //奖励物品个数
		}
	}
}

-
-- ]]
function badges.gc_contingent(list_contingents)
	if list_contingents == nil then return end;
	if not PublicFunc.check_type_table(list_contingents) then return end;
	--[[有新数据就要清空老的]]
	--g_dataCenter.otherPlayers:ClearSsystem(ENUM.ESystemId.Badges);

	for i=1,table.getn(list_contingents) do
		--[[构造player]]
		local temp_player = Player:new();
		temp_player:UpdateData(list_contingents[i].player_info);
		temp_player:AddTeam(1, 1, list_contingents[i].player_info.teams[1][1]);
		temp_player:AddTeam(1, 2, list_contingents[i].player_info.teams[1][2]);
		--[[构造背包]]
		local temp_package = Package:new();
		--[[加入角色卡]]
		for j=1,table.getn(list_contingents[i].package_info.hero) do
			temp_package:AddCard(ENUM.EPackageType.Hero,list_contingents[i].package_info.hero[j]);
		end
		--[[加入装备]]
		for j=1,table.getn(list_contingents[i].package_info.equip) do
			temp_package:AddCard(ENUM.EPackageType.Equipment,list_contingents[i].package_info.equip[j]);
		end
		--[[加入道具]]
		for j=1,table.getn(list_contingents[i].package_info.item) do
			temp_package:AddCard(ENUM.EPackageType.Item,list_contingents[i].package_info.item[j]);
		end

		-- temp_player.package = temp_package;
		-- temp_player.otherData = list_contingents[i].other_data;
		temp_player:SetPackage(temp_package)
		temp_player:SetOtherPlayerData(list_contingents[i].other_data)

		--g_dataCenter.otherPlayers:AddPlayer(ENUM.ESystemId.Badges,temp_player);
	end

	--[[回调]]
	if call_bakc ~= nil then
		_G[call_bakc]();
	end
end
