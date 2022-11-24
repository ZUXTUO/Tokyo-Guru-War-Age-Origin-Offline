--fileName:message/guild_boss_message.lua
--desc:社团boss的协议通信定义
--code by:fengyu
--date:2016-8-5

msg_guild_boss = msg_guild_boss or {};

ENUM.EGuildBossErrorCode = 
{
    Success                             = 0,
    Invalid                             = 1,--非法操作
    NoGuild                             = 2,--还未加入社团
    NotOpen                             = 3,--社团BOSS未开启
    NotFoundMap                         = 4,--社团BOSS没找到地图
    BuffNotEnoughGold                   = 5,--社团BOSS购买BUFF金币不足
    BuffNotEnoughCrystal                = 6,--社团BOSS购买BUFF钻石不足
    BuffMaxTimes                        = 7,--社团BOSS购买BUFF次数达到上限    
    ReliveImmediatelyCrystalNotEnough   = 8,--社团BOSS原地复活钻石不足
    IsEnterCD                           = 9,--进入CD
};

-------------------------------------客户端到服务器通信-----------------------------
function msg_guild_boss.cg_enter_guild_boss()
    --if not Socket.socketServer then return end
    nmsg_guild_boss.cg_enter_guild_boss(Socket.socketServer);
end

function msg_guild_boss.cg_leave_guild_boss(is_need_report)
    --if not Socket.socketServer then return end
    nmsg_guild_boss.cg_leave_guild_boss(Socket.socketServer, is_need_report);
end

--购买加成buff
function msg_guild_boss.cg_buy_guild_boss_buff(type)
    --if not Socket.socketServer then return end
    nmsg_guild_boss.cg_buy_guild_boss_buff( Socket.socketServer, type );
end

--领取社团BOSS首通奖励
function msg_guild_boss.cg_get_guild_boss_first_pass_reward(boss_index)
    --if not Socket.socketServer then return end
    nmsg_guild_boss.cg_get_guild_boss_first_pass_reward( Socket.socketServer, boss_index );
end

-- 请求社团BOSS信息
function msg_guild_boss.cg_request_guild_boss_detail_info()
    --if not Socket.socketServer then return end
    nmsg_guild_boss.cg_request_guild_boss_detail_info( Socket.socketServer);
end

-- 请求社团BOSS伤害排行榜
function msg_guild_boss.cg_request_guild_boss_damage_rank_info()
    --if not Socket.socketServer then return end
    nmsg_guild_boss.cg_request_guild_boss_damage_rank_info( Socket.socketServer);
end

-------------------------------服务器到客户端-------------------------------
--对应cg_enter_guild_boss
function msg_guild_boss.gc_enter_guild_boss_rst( rst, seconds )
    if rst == ENUM.EGuildBossErrorCode.IsEnterCD then
        HintUI.SetAndShow(EHintUiType.two, "进入CD中，请等待恢复时间", {str = "确定", time=seconds+1, func =  msg_guild_boss.cg_enter_guild_boss;},{str = "取消"})
    elseif rst ~= ENUM.EGuildBossErrorCode.Success then
        PublicFunc.FloatErrorCode(rst, gs_string_guild_boss, "guild_boss")
    end
    g_dataCenter.guildBoss:SetIsJoin( true );
end

function msg_guild_boss.gc_create_hero_complete()
    if g_dataCenter.fight_info:GetCaptainIndex() == nil then
        g_dataCenter.player:ChangeCaptain(1, nil, false, true)
    end
end

--同步社团BOSS首通奖励领取标志
function msg_guild_boss.gc_update_guild_boss_first_pass_reward_flag(flag)
    g_dataCenter.guildBoss:UpdateFirstPassReward(flag);
    PublicFunc.msg_dispatch(msg_guild_boss.gc_update_guild_boss_first_pass_reward_flag, flag)
end

--同步社团BOSS参与次数
function msg_guild_boss.gc_update_guild_boss_play_times(times)
    g_dataCenter.guildBoss:UpdateChallengeTimes(times);
    PublicFunc.msg_dispatch(msg_guild_boss.gc_update_guild_boss_play_times, times)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_Boss_Start);
end

--领取社团BOSS首通奖励
function msg_guild_boss.gc_get_guild_boss_first_pass_reward_rst(rst, reward)
    if rst ~= ENUM.EGuildBossErrorCode.Success then
        PublicFunc.FloatErrorCode(rst, gs_string_guild_boss, "guild_boss");
    else
        PublicFunc.msg_dispatch(msg_guild_boss.gc_get_guild_boss_first_pass_reward_rst, ret, reward)
    end
end

--购买BUFF
function msg_guild_boss.gc_buy_guild_boss_buff_rst(rst)
    if rst ~= ENUM.EGuildBossErrorCode.Success then
        PublicFunc.FloatErrorCode(rst, gs_string_guild_boss, "guild_boss");
    else
        PublicFunc.msg_dispatch(msg_guild_boss.gc_buy_guild_boss_buff_rst, ret)
    end
end

--同步购买BUFF次数
function msg_guild_boss.gc_sync_guild_boss_buy_buff_times(gold_times, crystal_times)
    g_dataCenter.guildBoss:SetCurBuffBuyTimes(gold_times, crystal_times);
    PublicFunc.msg_dispatch(msg_guild_boss.gc_buy_guild_boss_buff_rst, gold_times, crystal_times)
end

-- //同步社团BOSS信息
function msg_guild_boss.gc_sync_guild_boss_detail_info(info)
    g_dataCenter.guildBoss:SetCurGuildBossInfo(info.boss_index, info.boss_level, info.cur_hp);
    PublicFunc.msg_dispatch(msg_guild_boss.gc_sync_guild_boss_detail_info, info)
end
-- //同步社团BOSS伤害排行榜
function msg_guild_boss.gc_sync_guild_boss_damage_rank_info(rank_info, my_rank, my_damage)
    PublicFunc.msg_dispatch(msg_guild_boss.gc_sync_guild_boss_damage_rank_info, rank_info, my_rank, my_damage)
end
