--[[
region world_boss_message.lua
date: 2015-11-18
time: 19:35:1
author: Nation
]]
msg_world_boss = msg_world_boss or {}

ENUM.EWorldBossErrorCode = 
{
	Success								= 0,
	Invalid								= 1, --非法操作
	NotOpen								= 2, --世界BOSS未开启
	NotFoundMap							= 3, --找不到BOSS地图
	BuyInspireMaxTimes					= 4, --购买鼓舞次数最大值
	BuyInspireCrystalNotEnough			= 5, --购买鼓舞水晶不够
	NoTimes								= 6, --没有参与次数	
	ServerRewardGot						= 7, --服务器奖励已经领取过
	CrystalNotEnough					= 8, --红水晶不够
	BossLevelLess						= 9, --BOSS等级不够
	NoTeam								= 10,--未选择出战角色
}
---------------服务器到客户端---------------------------------
function msg_world_boss.gc_enter_world_boss_rst(rst)
    GLoading.Hide(GLoading.EType.msg);
    if rst == ENUM.EWorldBossErrorCode.Success then
    	PublicFunc.msg_dispatch(msg_world_boss.gc_enter_world_boss_rst, rst);
    else
    	PublicFunc.FloatErrorCode(rst, gs_string_world_boss, "world_boss")
    end
end

function msg_world_boss.gc_world_boss_buy_inspire_rst(rst)
    if rst == ENUM.EWorldBossErrorCode.Success then
    	PublicFunc.msg_dispatch(msg_world_boss.gc_world_boss_buy_inspire_rst, rst);
    else
        PublicFunc.FloatErrorCode(rst, gs_string_world_boss, "world_boss")
    end
end

function msg_world_boss.gc_update_world_boss_last_times(times)
	g_dataCenter.worldBoss:SetChallengeTimes(times);
	PublicFunc.msg_dispatch(msg_world_boss.gc_update_world_boss_last_times, times);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_WorldBoss_Start);
end

function msg_world_boss.gc_sync_world_boss_fight_report(info)
	PublicFunc.msg_dispatch(msg_world_boss.gc_sync_world_boss_fight_report, info);
end

function msg_world_boss.gc_sync_world_boss_detail_info(info)
	g_dataCenter.worldBoss:SetBossInfo(info);
	PublicFunc.msg_dispatch(msg_world_boss.gc_sync_world_boss_detail_info, info);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_WorldBoss_Award);
end
function msg_world_boss.gc_sync_world_boss_rank_info(rank_info)
	PublicFunc.msg_dispatch(msg_world_boss.gc_sync_world_boss_rank_info, rank_info);
end
function msg_world_boss.gc_sync_world_boss_rt_rank_info(rank_info)
	PublicFunc.msg_dispatch(msg_world_boss.gc_sync_world_boss_rt_rank_info, rank_info);
end
function msg_world_boss.gc_sync_world_boss_server_reward_flag(flag1, flag2)
	g_dataCenter.worldBoss:SetRewardFlag(flag1, flag2);
	PublicFunc.msg_dispatch(msg_world_boss.gc_sync_world_boss_server_reward_flag, flag1, flag2);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_WorldBoss_Award);
end
function msg_world_boss.gc_sync_world_boss_buy_times(times)
	g_dataCenter.worldBoss:SetBuyTimes(times);
	PublicFunc.msg_dispatch(msg_world_boss.gc_sync_world_boss_buy_times, times);
end
function msg_world_boss.gc_buy_world_boss_times(rst)
	if rst == ENUM.EWorldBossErrorCode.Success then
		PublicFunc.msg_dispatch(msg_world_boss.gc_buy_world_boss_times, rst);
    else
        PublicFunc.FloatErrorCode(rst, gs_string_world_boss, "world_boss")
    end
end
function msg_world_boss.gc_get_world_boss_server_reward(rst, reward)
	if rst == ENUM.EWorldBossErrorCode.Success then
		PublicFunc.msg_dispatch(msg_world_boss.gc_get_world_boss_server_reward, rst, reward);
    else
        PublicFunc.FloatErrorCode(rst, gs_string_world_boss, "world_boss")
    end
end

-----------------------客户端到服务器------------------------
function msg_world_boss.cg_enter_world_boss()
	--if not Socket.socketServer then return end
	nmsg_world_boss.cg_enter_world_boss(Socket.socketServer);
end
function msg_world_boss.cg_leave_world_boss()
	--if not Socket.socketServer then return end
	GWriteWorldBossLuckAttack();
	nmsg_world_boss.cg_leave_world_boss(Socket.socketServer);
end
function msg_world_boss.cg_world_boss_buy_inspire(nType)
	--if not Socket.socketServer then return end
	nmsg_world_boss.cg_world_boss_buy_inspire(Socket.socketServer, nType);
end
function msg_world_boss.cg_world_boss_request_fight_report()
	--if not Socket.socketServer then return end
	nmsg_world_boss.cg_world_boss_request_fight_report(Socket.socketServer);
end
function msg_world_boss.cg_request_world_boss_detail_info()
	--if not Socket.socketServer then return end
	nmsg_world_boss.cg_request_world_boss_detail_info(Socket.socketServer);
end
function msg_world_boss.cg_request_world_boss_rank_info()
	--if not Socket.socketServer then return end
	nmsg_world_boss.cg_request_world_boss_rank_info(Socket.socketServer);
end
function msg_world_boss.cg_request_world_boss_rt_rank_info()
	--if not Socket.socketServer then return end
	nmsg_world_boss.cg_request_world_boss_rt_rank_info(Socket.socketServer);
end
function msg_world_boss.cg_get_world_boss_server_reward(index, is_get_all)
	--if not Socket.socketServer then return end
	nmsg_world_boss.cg_get_world_boss_server_reward(Socket.socketServer, index, is_get_all);
end
function msg_world_boss.cg_buy_world_boss_times(times)
	--if not Socket.socketServer then return end
	nmsg_world_boss.cg_buy_world_boss_times(Socket.socketServer, times);
end

--[[endregion]]