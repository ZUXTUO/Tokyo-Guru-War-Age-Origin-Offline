msg_friend = msg_friend or {}
ENUM.EFriendErrorCode = 
{
	Success 					= 0,
	NotSearhedPlayer 			= 1, --没有搜索到玩家
	NotFoundRecommendFriend 	= 2, --没有找到推荐好友
	CannotApplyByMaxFriend 		= 3, --自己好友已满，不能发送申请
	CannotAddBySelfMaxFriend 	= 4, --自己好友已满,不能添加
	CannotAddByAllreadyFriend 	= 5, --已经是,不能添加
	GiveAPNotFriend 			= 6, --不是好友无法赠送体力
	GiveAPAllreadyGive 			= 7, --已经赠送过体力
	GetAPNotFriend 				= 8, --不是好友无法领取体力
	GetAPNotGive 				= 9, --没有赠送无法领取
	GetAPAllreadyGet 			= 10,--已经获取过
	GetAPMaxTimes 				= 11,--已经达到最大领取数
	CannotAddByTargetIsBlacklist= 12,--对方为黑名单玩家，无法添加好友
	CannotAddBySelfIsBlacklist 	= 13,--自己为黑名单玩家，无法添加好友
	CannotAddByTargetMaxFriend 	= 14,--对方好友已满，不能添加好友
	CannotAddByNotSameCountry 	= 15,--不是本区玩家不可添加为好友
	TargetPlayLevelNotEnough	= 16,--对方未达到好友开放等级
}
--请求好友列表
function msg_friend.cg_request_friend_list()
	--if not Socket.socketServer then return end
    nmsg_friend.cg_request_friend_list(Socket.socketServer)
end
	
--查找添加好友
--search_info: 为空时推荐10个
function msg_friend.cg_search_add_friend_list(search_info)
	--if not Socket.socketServer then return end
    nmsg_friend.cg_search_add_friend_list(Socket.socketServer, search_info)
end

--请求好友申请列表
function msg_friend.cg_request_friend_apply_list()
	--if not Socket.socketServer then return end
    nmsg_friend.cg_request_friend_apply_list(Socket.socketServer)
end

--删除好友
function msg_friend.cg_del_friend(vecDel)
	--if not Socket.socketServer then return end
    nmsg_friend.cg_del_friend(Socket.socketServer, vecDel)
end

--申请添加好友
function msg_friend.cg_apply_friend(vecApply)
	--if not Socket.socketServer then return end
    nmsg_friend.cg_apply_friend(Socket.socketServer, vecApply)
end

--处理好友申请
function msg_friend.cg_handle_friend_apply(vecHandle, agree)
	--if not Socket.socketServer then return end
    nmsg_friend.cg_handle_friend_apply(Socket.socketServer, vecHandle, agree)
end

--添加黑名单
function msg_friend.cg_add_black_list(player_gid)
	--if not Socket.socketServer then return end
    nmsg_friend.cg_add_black_list(Socket.socketServer, player_gid)
end

--删除黑名单
function msg_friend.cg_del_black_list(vecPlayerGID)
	--if not Socket.socketServer then return end
    nmsg_friend.cg_del_black_list(Socket.socketServer, vecPlayerGID)
end

--请求黑名单列表
function msg_friend.cg_request_blacklist_list()
	--if not Socket.socketServer then return end
    nmsg_friend.cg_request_blacklist_list(Socket.socketServer)
end

--赠送体力
function msg_friend.cg_give_friend_ap(playerGID)
	--if not Socket.socketServer then return end
    nmsg_friend.cg_give_friend_ap(Socket.socketServer, playerGID)
end

--领取体力
function msg_friend.cg_get_friend_ap(playerGID)
	--if not Socket.socketServer then return end
    nmsg_friend.cg_get_friend_ap(Socket.socketServer, playerGID)
end

--一键赠送体力
function msg_friend.cg_give_all_friend_ap()
	--if not Socket.socketServer then return end
    nmsg_friend.cg_give_all_friend_ap(Socket.socketServer)
end

--一键领取体力
function msg_friend.cg_get_all_friend_ap()
	--if not Socket.socketServer then return end
    nmsg_friend.cg_get_all_friend_ap(Socket.socketServer)
end

--请求刷新好友战力
function msg_friend.cg_request_update_friend_fight_value()
	--if not Socket.socketServer then return end
    nmsg_friend.cg_request_update_friend_fight_value(Socket.socketServer)
end
---------------------------------------------------------------------------------

--同步好友列表
--sync_state 最低位:开始 倒数第二位:结束
function msg_friend.gc_sync_friend_list(vecFriends, sync_state)
	if bit.bit_and(sync_state, 1) ~= 0 then
		g_dataCenter.friend:ClearFriendList()
	end
	g_dataCenter.friend:AddFriendList(vecFriends)
	if bit.bit_and(sync_state, 2) ~= 0 then
		g_dataCenter.friend:SortFriendList()
		PublicFunc.msg_dispatch("sync_all_friend")
	end
end

--查找添加好友返回
function msg_friend.gc_search_add_friend_list_rst(rst)
	PublicFunc.FloatErrorCode(rst, gs_string_friend, "friend")
end

--同步查找添加好友列表
function msg_friend.gc_sync_search_add_friend_list(vecSearchData, type)
	g_dataCenter.friend:SetSearchAddFriendInfo(vecSearchData)
	g_dataCenter.friend:SortSearchAddFriendInfo()
	PublicFunc.msg_dispatch(msg_friend.gc_sync_search_add_friend_list, type)
end

--同步好友申请列表
--sync_state 最低位:开始 倒数第二位:结束
function msg_friend.gc_sync_friend_apply_list(vecApplys, sync_state)
	if bit.bit_and(sync_state, 1) ~= 0 then
		g_dataCenter.friend:ClearApplyList()
	end
	g_dataCenter.friend:AddFriendApply(vecApplys)
	if bit.bit_and(sync_state, 2) ~= 0 then
		g_dataCenter.friend:SortFriendApply()
		PublicFunc.msg_dispatch("sync_all_apply")
	end
end

--删除好友回复
function msg_friend.gc_del_friend_rst(rst)
	FloatTip.Float(gs_string_friend["success_del_friend"])
	PublicFunc.msg_dispatch(msg_friend.gc_del_friend_rst);
end

--申请添加好友回复
function msg_friend.gc_apply_friend_rst(vecApply, rst)
	if rst == ENUM.EFriendErrorCode.Success then
		FloatTip.Float(gs_string_friend["apply_is_send"])
		g_dataCenter.friend:ApplySearchFriend(vecApply)
		PublicFunc.msg_dispatch(msg_friend.gc_apply_friend_rst)
	else
		PublicFunc.FloatErrorCode(rst, gs_string_friend, "friend")
	end
end

--新增好友申请
function msg_friend.gc_add_friend_apply(apply_data)
	local vecApply = {}
	vecApply[1] = apply_data
	g_dataCenter.friend:AddFriendApply(vecApply)
	g_dataCenter.friend:SortFriendApply()
	PublicFunc.msg_dispatch(msg_friend.gc_add_friend_apply)
end

--删除好友申请
function msg_friend.gc_del_friend_apply(vecApplyPlayer)
	g_dataCenter.friend:DelApply(vecApplyPlayer)
	PublicFunc.msg_dispatch(msg_friend.gc_del_friend_apply)
end

--处理好友申请返回
function msg_friend.gc_handle_friend_apply_rst(agree, rst)
	if rst == ENUM.EFriendErrorCode.Success then
		if agree then
			FloatTip.Float(gs_string_friend["success_add_friend"])
		else
			FloatTip.Float(gs_string_friend["success_refuse_apply"])
		end
	else
		PublicFunc.FloatErrorCode(rst, gs_string_friend, "friend")
	end
end

--新增好友
function msg_friend.gc_add_friend(vecFriendData)
	g_dataCenter.friend:AddFriendList(vecFriendData)
	g_dataCenter.friend:SortFriendList()
	if g_dataCenter.friend:DelSearchAddFriendInfo(vecFriendData) then
		g_dataCenter.friend:SortSearchAddFriendInfo()
	end
	PublicFunc.msg_dispatch(msg_friend.gc_add_friend)
end

--删除好友
function msg_friend.gc_del_friend(vecDelFriend)
	g_dataCenter.friend:DelFriend(vecDelFriend)
	PublicFunc.msg_dispatch(msg_friend.gc_del_friend)
end

--同步黑名单列表
--sync_state 最低位:开始 倒数第二位:结束
function msg_friend.gc_sync_blacklist_list(vecBlacklists, sync_state)
	if bit.bit_and(sync_state, 1) ~= 0 then
		g_dataCenter.friend:ClearBlacklist()
	end
	g_dataCenter.friend:AddBlacklist(vecBlacklists)
	if bit.bit_and(sync_state, 2) ~= 0 then
		g_dataCenter.friend:SortBlacklist()
		PublicFunc.msg_dispatch("sync_all_blacklist")
	end
end

--新增黑名单
function msg_friend.gc_add_blacklist(blacklist_data)
	local vecBlacklists = {}
	vecBlacklists[1] = blacklist_data
	g_dataCenter.friend:AddBlacklist(vecBlacklists)
	g_dataCenter.friend:SortBlacklist()
	PublicFunc.msg_dispatch(msg_friend.gc_add_blacklist)
end

--删除黑名单
function msg_friend.gc_del_blacklist(vecBlacklists)
	g_dataCenter.friend:DelBlacklist(vecBlacklists)
	PublicFunc.msg_dispatch(msg_friend.gc_del_blacklist)
end

--添加黑名单返回
function msg_friend.gc_add_black_list_rst(rst)
	FloatTip.Float(gs_string_friend["success_add_blacklist"])
end

--删除黑名单返回
function msg_friend.gc_del_black_list_rst(rst)
	FloatTip.Float(gs_string_friend["success_remove_blacklist"])
end

--赠送体力返回
function msg_friend.gc_give_friend_ap_rst(rst)
	if rst == ENUM.EFriendErrorCode.Success then
		FloatTip.Float(gs_string_friend["success_give_ap"])
	else
		PublicFunc.FloatErrorCode(rst, gs_string_friend, "friend")
	end
end

--领取体力返回
function msg_friend.gc_get_friend_ap_rst(times, rst)
	if rst == ENUM.EFriendErrorCode.Success then
		local max_can_get_ap_times = 0
        local max_can_get_ap_times_cfg = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_times_each_day)
        if max_can_get_ap_times_cfg then
            max_can_get_ap_times = max_can_get_ap_times_cfg.data
        end
        local each_get_ap_value = 0
        local each_get_ap_value_cfg = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_each_time)
        if each_get_ap_value_cfg then
            each_get_ap_value = each_get_ap_value_cfg.data
        end
        if g_dataCenter.player.get_friend_ap_times < max_can_get_ap_times then
			FloatTip.Float(string.format(gs_string_friend["success_get_ap"], times*each_get_ap_value, (max_can_get_ap_times-g_dataCenter.player.get_friend_ap_times)*each_get_ap_value))
		else
			FloatTip.Float(gs_string_friend["get_ap_max_times"])
		end
		PublicFunc.msg_dispatch(msg_friend.gc_get_friend_ap_rst)
	elseif rst == ENUM.EFriendErrorCode.GetAPMaxTimes then
		FloatTip.Float(gs_string_friend["get_ap_max_times"])
	else
		PublicFunc.FloatErrorCode(rst, gs_string_friend, "friend")
	end
end

--领取体力返回
function msg_friend.gc_update_friend(vecfriendData)
	g_dataCenter.friend:UpdateFriendData(vecfriendData)
	PublicFunc.msg_dispatch(msg_friend.gc_update_friend)
end

function msg_friend.gc_clear_friend_oper_state()
	g_dataCenter.friend:ClearFriendOperState()
	PublicFunc.msg_dispatch(msg_friend.gc_clear_friend_oper_state)
end

function msg_friend.gc_give_all_friend_ap_rst(rst)
	if rst == ENUM.EFriendErrorCode.Success then
		FloatTip.Float(gs_string_friend["success_give_ap"])
		g_dataCenter.friend:GiveAllFriendAP()
		PublicFunc.msg_dispatch(msg_friend.gc_give_all_friend_ap_rst)
	else
		PublicFunc.FloatErrorCode(rst, gs_string_friend, "friend")
	end
end

function msg_friend.gc_update_friend_fight_value(vecFightValue, is_end)
	g_dataCenter.friend:UpdateFriendFightValue(vecFightValue)
	if is_end then
		PublicFunc.msg_dispatch(msg_friend.gc_update_friend_fight_value)
	end
end
return msg_friends;













