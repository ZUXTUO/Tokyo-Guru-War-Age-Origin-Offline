Friend = Class('Friend');

function Friend:Init()
	self.is_request_data = false
	self.friend_list = {}
	self.friend_apply = {}
	self.unique_friend_apply = {}
	self.search_add_friend_info = {}
	self.blacklist = {}
	self.have_new_apply = false
end

function Friend:ClearFriendList()
	self.friend_list = {}
end

function Friend:AddFriendList(vecFriends)
	local len = #vecFriends
	for i=1, len do
		vecFriends[i].update_time = PublicFunc.QueryCurTime()
		table.insert(self.friend_list, vecFriends[i])
	end
end

function Friend:SortFriendList()
	table.sort(self.friend_list, 
		function(a, b)
			if a.online and not b.online then
				return true
			elseif not a.online and b.online then
				return false
			else
				return a.level > b.level 
			end
		end
	)
end

function Friend:GetOnlineFriendCnt()
    local cnt = 0
	for _, v in ipairs(self.friend_list) do 
        if v.online then
            cnt = cnt + 1
        else
            break    
        end
    end
    return cnt
end

function Friend:GetFriendCnt()
	return #self.friend_list
end

function Friend:GetFriendDataByIndex(index)
	return self.friend_list[index]
end

function Friend:GetFriendDataByPlayerGID(player_gid)
	local len = #self.friend_list
	for i=1, len do
		if self.friend_list[i].friend_gid == player_gid then
			return self.friend_list[i]
		end
	end
	return nil
end

function Friend:ClearFriendOperState()
	local len = #self.friend_list
	for i=1, len do
		if bit.bit_and(self.friend_list[i].oper_state, ENUM.FriendOperState.BeGive) ~= 0 then
			self.friend_list[i].oper_state = ENUM.FriendOperState.BeGive
		else
			self.friend_list[i].oper_state = 0
		end
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Friend_GetApApplyChange);
end


function Friend:UpdateFriendData(vecfriendData)
	local bHandle = false;
	local update_len = #vecfriendData
	for i=1, update_len do
		local len = #self.friend_list
		for j=1, len do
			if self.friend_list[j].friend_gid == vecfriendData[i].friend_gid then
				if self.friend_list[j].oper_state ~= vecfriendData[i].oper_state then
					bHandle = true;
				end
				self.friend_list[j] = vecfriendData[i]
				self.friend_list[j].update_time = PublicFunc.QueryCurTime()
				break
			end
		end
	end
	self:SortFriendList()
	if bHandle then
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Friend_GetApApplyChange);
	end
end

function Friend:DelFriend(vecDelFriend)
	local del_len = #vecDelFriend
	for i=1, del_len do
		local len = #self.friend_list
		for j=1, len do
			if self.friend_list[j].friend_gid == vecDelFriend[i] then
				table.remove(self.friend_list, j)
				break
			end
		end
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Friend_GetApApplyChange);
end

function Friend:GetFriendIndex(friend_gid)
	local len = #self.friend_list
	for i=1, len do
		if self.friend_list[i].friend_gid == friend_gid then
			return i
		end
	end
	return 0
end

function Friend:SetSearchAddFriendInfo(vecSearchData)
	self.search_add_friend_info = {}
	local len = #vecSearchData
	for i=1, len do
		vecSearchData[i].is_send = false
		table.insert(self.search_add_friend_info, vecSearchData[i])
	end
end

function Friend:DelSearchAddFriendInfo(vecFriendData)
	local ret = false
	for i=1, #vecFriendData do
		local player_gid = vecFriendData[i].friend_gid
		local search_len = #self.search_add_friend_info
		for j=1, search_len do
			if self.search_add_friend_info[j].player_gid == player_gid then
				table.remove(self.search_add_friend_info, j)
				ret = true
				break
			end
		end
	end
	return ret
end

function Friend:SortSearchAddFriendInfo()
	table.sort(self.search_add_friend_info, 
		function(a, b)
			return a.level > b.level 
		end
	)
end


function Friend:GetSearchAddFriendCnt()
	return #self.search_add_friend_info
end

function Friend:GetSearchAddFriendByPlayerGID(player_gid)
	local search_len = #self.search_add_friend_info
	for i=1, search_len do
		if self.search_add_friend_info[i].player_gid == player_gid then
			return self.search_add_friend_info[i]
		end
	end
	return nil
end

function Friend:GetSearchAddFriendByIndex(index)
	return self.search_add_friend_info[index]
end

function Friend:GetAllSearchAddFriendPlayerGID(vecApply)
	local search_len = #self.search_add_friend_info
	for i=1, search_len do
		table.insert(vecApply, self.search_add_friend_info[i].player_gid)
	end
end

function Friend:ApplySearchFriend(vecApply)
	local ret_len = #vecApply
	local search_len = #self.search_add_friend_info
	for i=1, ret_len do
		for j=1, search_len do
			if self.search_add_friend_info[j].player_gid == vecApply[i] then
				self.search_add_friend_info[j].is_send = true
				break
			end
		end
	end
end

function Friend:ClearSearchFriendData()
	self.search_add_friend_info = {}
end

function Friend:GetAllCanGiveAPFriend(vecPlayerGID)
	local len = #self.friend_list
	for i=1, len do
		if bit.bit_and(self.friend_list[i].oper_state, ENUM.FriendOperState.Give) == 0 then
			table.insert(vecPlayerGID, self.friend_list[i].friend_gid)
		end
	end
end

function Friend:GetAllCanGetAPFriend(vecPlayerGID)
	local len = #self.friend_list
	for i=1, len do
		local oper_state = self.friend_list[i].oper_state
		if (bit.bit_and(oper_state, ENUM.FriendOperState.BeGive) ~= 0) and (bit.bit_and(oper_state, ENUM.FriendOperState.Get) == 0) then
			table.insert(vecPlayerGID, self.friend_list[i].friend_gid)
		end
	end
end

function Friend:ClearApplyList()
	self.friend_apply = {}
	self.unique_friend_apply = {}
end

function Friend:AddFriendApply(vecApplys)
	local len = #vecApplys
	for i=1, len do
		local player_gid = vecApplys[i].player_gid
		if self.unique_friend_apply[player_gid] == nil then
			table.insert(self.friend_apply, vecApplys[i])
			self.unique_friend_apply[player_gid] = player_gid
		end
	end
	if len > 0 then
		self:SetHaveNewApplay(true);
	end
end

function Friend:SetHaveNewApplay(have)
	if self.have_new_apply ~= have then
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Friend_ApplyChange);
	end
	self.have_new_apply = have;
end

function Friend:SortFriendApply()
	table.sort(self.friend_apply, 
		function(a, b)
			return a.time > b.time 
		end
	)
end

function Friend:GetFriendApplyCnt()
	return #self.friend_apply
end

function Friend:GetFriendApplyIndex(player_gid)
	local len = #self.friend_apply
	for i=1, len do
		if self.friend_apply[i].player_gid == player_gid then
			return i
		end
	end
	return 0
end

function Friend:GetFriendApplyByIndex(index)
	return self.friend_apply[index]
end

function Friend:GetFriendApplyByPlayerGID(player_gid)
	local apply_len = #self.friend_apply
	for i=1, apply_len do
		if self.friend_apply[i].player_gid == player_gid then
			return self.friend_apply[i]
		end
	end
	return nil
end

function Friend:GetAllApplyPlayerGID(vecPlayerGID)
	local apply_len = #self.friend_apply
	for i=1, apply_len do
		table.insert(vecPlayerGID, self.friend_apply[i].player_gid)
	end
end

function Friend:DelApply(vecApplyPlayer)
	local del_len = #vecApplyPlayer
	for i=1, del_len do
		local len = #self.friend_apply
		for j=1, len do
			if self.friend_apply[j].player_gid == vecApplyPlayer[i] then
				self.unique_friend_apply[self.friend_apply[j].player_gid] = nil
				table.remove(self.friend_apply, j)
				break
			end
		end
	end
end


function Friend:ClearBlacklist()
	self.blacklist = {}
end

function Friend:AddBlacklist(vecBlacklists)
	local len = #vecBlacklists
	for i=1, len do
		table.insert(self.blacklist, vecBlacklists[i])
	end
end

function Friend:SortBlacklist()
	table.sort(self.blacklist, 
		function(a, b)
			return a.time > b.time 
		end
	)
end

function Friend:GetBlacklistCnt()
	return #self.blacklist
end

function Friend:GetBlacklistByIndex(index)
	return self.blacklist[index]
end

function Friend:GetBlacklistByPlayerGID(player_gid)
	local blacklist_len = #self.blacklist
	for i=1, blacklist_len do
		if self.blacklist[i].player_gid == player_gid then
			return self.blacklist[i]
		end
	end
	return nil
end

function Friend:GetBlacklistIndex(player_gid)
	local len = #self.blacklist
	for i=1, len do
		if self.blacklist[i].player_gid == player_gid then
			return i
		end
	end
	return 0
end

function Friend:GetAllBlacklistPlayerGID(vecPlayerGID)
	local apply_len = #self.blacklist
	for i=1, apply_len do
		table.insert(vecPlayerGID, self.blacklist[i].player_gid)
	end
end

function Friend:DelBlacklist(vecBlacklists)
	local del_len = #vecBlacklists
	for i=1, del_len do
		local len = #self.blacklist
		for j=1, len do
			if self.blacklist[j].player_gid == vecBlacklists[i] then
				table.remove(self.blacklist, j)
				break
			end
		end
	end
end

function Friend:GiveAllFriendAP()
	local len = #self.friend_list
	for i=1, len do
		local oper_state = self.friend_list[i].oper_state
		if (bit.bit_and(oper_state, ENUM.FriendOperState.Give) == 0) then
			self.friend_list[i].oper_state = self.friend_list[i].oper_state + ENUM.FriendOperState.Give
		end
	end
	return nil
end


function Friend:IsAPCanGet()
  	local max_can_get_ap_times = 0
    local max_can_get_ap_times_cfg = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_times_each_day)
    if max_can_get_ap_times_cfg then
        max_can_get_ap_times = max_can_get_ap_times_cfg.data
    end
    if g_dataCenter.player.get_friend_ap_times >= max_can_get_ap_times then
        return Gt_Enum_Wait_Notice.Friend_GetApTimesChange;
 	end
	local len = #self.friend_list
	for i=1, len do
		local oper_state = self.friend_list[i].oper_state
		if (bit.bit_and(oper_state, ENUM.FriendOperState.BeGive) ~= 0) and (bit.bit_and(oper_state, ENUM.FriendOperState.Get) == 0) then
			return Gt_Enum_Wait_Notice.Success;
		end
	end
	return Gt_Enum_Wait_Notice.Friend_GetApApplyChange;
end

function Friend:IsHaveNewApply()
	if self.have_new_apply then
		return Gt_Enum_Wait_Notice.Success;
	else
		return Gt_Enum_Wait_Notice.Friend_ApplyChange;
	end
end

function Friend:UpdateFriendFightValue(vecFightValue)
	for i=1, #vecFightValue do
		local player_gid = vecFightValue[i].player_gid
		local friend_len = #self.friend_list
		for j=1, friend_len do
			if self.friend_list[j].friend_gid == player_gid then
				self.friend_list[j].fight_value = vecFightValue[i].fight_value
				break
			end
		end
	end
end