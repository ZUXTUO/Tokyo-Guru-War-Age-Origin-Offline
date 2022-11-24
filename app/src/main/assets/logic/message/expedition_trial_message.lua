--[[struct expedition_trial_hero_info
{
	int hero_id;
	int hero_level;
	list<int> skill_level;
	list<float> property;
}

struct expedition_trial_player_info
{
	int fight_value;
	string name;
	int icon;
	list<expedition_trial_hero_info> hero_info;
}

struct expedition_trial_challenge_info
{
	int level_id;
	int hurdle_id;
	int select_difficulty;
	int hero1_hp;
	int hero2_hp;
	int hero3_hp;
	int pass_stars;
	list<expedition_trial_player_info> player_info;
}

struct expedition_trial_full_info
{
	list<expedition_trial_challenge_info> challenge_info;
	int total_point;
	int today_point;
	int stars;
	int cur_expedition_trial_level;
	int last_pass_expedition_trial_level;
	int decide_expedition_trial_sweep;
	bool finish;
	list<int> buff_info;
	string points_reward_flag1;
	string points_reward_flag2;
	string points_reward_flag3;
}

struct expedition_trial_buff
{
	int buffid;
	bool sell;
}

struct expedition_trial_buff_sell_info
{
	int levelid;
	list<expedition_trial_buff> buff_data;
}

struct expedition_trial_pay_treasure_box_info
{
	int levelid;
	int buy_times;
}

struct expedition_trial_challenge_result_info
{
	int pass_stars;
	int enemy_hero1_hp;
	int enemy_hero2_hp;
	int enemy_hero3_hp;
}--]]

msg_expedition_trial = {};

ENUM.EExpeditionTrialErrorCode = 
{
	Success 				= 0,
	Invalid 				= 1,	--非法操作
	CrystalNotEnough 		= 2,	--钻石不够
	BuffSold 				= 3,	--BUFF已经购买
	StarsNotEnough 			= 4,	--星数不够
	NotSelectHero 			= 5,	--/未指定英雄
	SelectHeroNotFound 		= 6,	--指定的英雄不存在
	SelectHeroIsDead 		= 7,	--指定的英雄死亡
	SelectHeroIsFullHP 		= 8,	--指定的英雄满血
	NoHeroCanRecoverHP 		= 9,	--没有英雄可以恢复血量
	PointsRewardGot			= 10,	--积分奖励已经领取过
	PointsRewardNotEnough	= 11,	--积分不够
};

--------------------------------------------------
-----------------Client To Server-----------------
--------------------------------------------------

--请求一次远征试炼数据，单次登录只调一次
function msg_expedition_trial.cg_request_expedition_trial_info()
	if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_expedition_trial.cg_request_expedition_trial_info(robot_s)")
    end
	nmsg_expedition_trial.cg_request_expedition_trial_info(Socket.socketServer);
end
--未知的情况下请求远征某个关卡的数据
function msg_expedition_trial.cg_trigger_expedition_trial_level(level)
	if AppConfig.script_recording then
		PublicFunc.RecordingScript("nmsg_expedition_trial.cg_trigger_expedition_trial_level(robot_s, "..tostring(level)..")")
    end
	nmsg_expedition_trial.cg_trigger_expedition_trial_level(Socket.socketServer,level);
end
--购买付费宝箱
function msg_expedition_trial.cg_buy_expedition_trial_treasure_box(level,times)
	nmsg_expedition_trial.cg_buy_expedition_trial_treasure_box(Socket.socketServer,level,times);
end
--购买BUFF
function msg_expedition_trial.cg_buy_expedition_trial_buff(level,index,dataid)
	nmsg_expedition_trial.cg_buy_expedition_trial_buff(Socket.socketServer,level,index,dataid);
end
--挑战某一个关卡
function msg_expedition_trial.cg_challenge_expedition_trial(level,difficulty, is_auto_fight)
	--app.log("挑战关卡："..tostring(level).."，难度："..tostring(difficulty));
	if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_expedition_trial.cg_challenge_expedition_trial(robot_s, "..tostring(level)..", "..tostring(difficulty)..", "..tostring(is_auto_fight)..")")
    end
	nmsg_expedition_trial.cg_challenge_expedition_trial(Socket.socketServer,level,difficulty, is_auto_fight);
end
--关卡挑战结果
function msg_expedition_trial.cg_expedition_trial_challenge_result(info)				--<expedition_trial_challenge_result_info> info
	if AppConfig.script_recording then
		local _info = "local info = {}\n"
        for k, v in pairs(info) do
            _info = _info.."info["..k.."] = "..tostring(v).."\n"
        end
        PublicFunc.RecordingScript(_info.."nmsg_expedition_trial.cg_expedition_trial_challenge_result(robot_s, info)")
    end
	nmsg_expedition_trial.cg_expedition_trial_challenge_result(Socket.socketServer,info);
end
--决定是否扫荡
function msg_expedition_trial.cg_decide_expedition_trial_sweep(is_sweep)
	nmsg_expedition_trial.cg_decide_expedition_trial_sweep(Socket.socketServer,is_sweep);
end
--批量购买付费宝箱
function msg_expedition_trial.cg_batch_buy_expedition_trial_treasure_box(times)
	nmsg_expedition_trial.cg_batch_buy_expedition_trial_treasure_box(Socket.socketServer,times);
end 
--领取积分奖励
function msg_expedition_trial.cg_get_expedition_trial_points_reward(index)
	if AppConfig.script_recording then
		PublicFunc.RecordingScript("nmsg_expedition_trial.cg_get_expedition_trial_points_reward(robot_s, "..tostring(index)..")")
    end
	nmsg_expedition_trial.cg_get_expedition_trial_points_reward(Socket.socketServer,index);
end 
--------------------------------------------------
-----------------Server To Client-----------------
--------------------------------------------------
--同步远征试炼数据
function msg_expedition_trial.gc_sync_all_expedition_trial_info(info)
	--app.log("同步远征试炼数据.gc_sync_all_expedition_trial_info:"..table.tostring(info))
	g_dataCenter.trial:set_all_expedition_trial_info(info);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial);
end
--未知的情况下请求远征某个关卡的数据回复
function msg_expedition_trial.gc_trigger_expedition_trial_level_rst(rst,level)
	--app.log("未知的情况下请求远征某个关卡的数据回复.gc_trigger_expedition_trial_level_rst:");
	if rst == ENUM.EExpeditionTrialErrorCode.Success then 
		g_dataCenter.trial:serverRstTrialLevel(level)
	else
		PublicFunc.FloatErrorCode(rst, gs_string_expedition_trial, "expedition_trial")
	end
end
--打开普通宝箱得到的奖励
function msg_expedition_trial.gc_open_normal_treasure_box_reward(reward)	--list<net_summary_item> reward
	--app.log("打开普通宝箱得到的奖励.gc_open_normal_treasure_box_reward:");
	g_dataCenter.trial:serverOpenNormalBox(reward);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial);
end

--扫荡后普通宝箱得到的奖励
function msg_expedition_trial.gc_sweep_normal_treasure_box_reward(reward)	--list<net_summary_item> reward
	--app.log("扫荡后普通宝箱得到的奖励.gc_sweep_normal_treasure_box_reward:");
	g_dataCenter.trial:serverSweepOpenNormalBox(reward);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial);
end

--打开付费宝箱得到的奖励
function msg_expedition_trial.gc_open_pay_treasure_box_reward(reward)		--list<net_summary_item> reward
	--app.log("打开付费宝箱得到的奖励.gc_open_pay_treasure_box_reward:");
	g_dataCenter.trial:serverOpenPayBoxReward(reward);
end

--更新付费宝箱的数据
function msg_expedition_trial.gc_update_pay_treasure_box_info(discount,discountTimes, info)			--list<expedition_trial_pay_treasure_box_info> info
	--app.log("更新付费宝箱的数据.gc_update_pay_treasure_box_info:");
	g_dataCenter.trial:serverPayBoxInfo(discount,discountTimes,info);
end

--增加一条关卡挑战数据
function msg_expedition_trial.gc_add_expedition_trial_challenge_info(info)	--expedition_trial_challenge_info info
	--app.log("增加一条关卡挑战数据.gc_add_expedition_trial_challenge_info:");
	g_dataCenter.trial:updateChallengeInfo(info);
end

--更新关卡挑战数据
function msg_expedition_trial.gc_update_expedition_trial_challenge_info(info)--expedition_trial_challenge_info info
	--app.log("更新关卡挑战数据.gc_update_expedition_trial_challenge_info:");
	g_dataCenter.trial:updateChallengeInfo(info);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial);
end

--更新正在出售的BUFF数据
function msg_expedition_trial.gc_update_sell_buff_info(info)				--list<expedition_trial_buff_sell_info> info
	--app.log("更新正在出售的BUFF数据.gc_update_sell_buff_info:");
	g_dataCenter.trial:serverBuffList(info);
end

--购买付费宝箱回复
function msg_expedition_trial.gc_buy_expedition_trial_treasure_box_rst(rst)
	--app.log("购买付费宝箱回复.gc_buy_expedition_trial_treasure_box_rst:");
	if rst == ENUM.EExpeditionTrialErrorCode.Success then 
		g_dataCenter.trial:serverOpenPayBox();
	else
		PublicFunc.FloatErrorCode(rst, gs_string_expedition_trial, "expedition_trial")
	end
end

--购买buff回复
function msg_expedition_trial.gc_buy_expedition_trial_buff_rst(rst)
	--app.log("购买buff回复.gc_buy_expedition_trial_buff_rst:");
	if rst ~= ENUM.EExpeditionTrialErrorCode.Success then 
		PublicFunc.FloatErrorCode(rst, gs_string_expedition_trial, "expedition_trial")
	end
end

--同步远征试炼星数
function msg_expedition_trial.gc_update_expedition_trial_stars(stars)
	--app.log("同步远征试炼星数.gc_update_expedition_trial_stars:");
	g_dataCenter.trial:set_StarNum(stars);
end

--清除本地的所有远征试炼数据，恢复本地的所有英雄血量
function msg_expedition_trial.gc_expedition_trial_reset()
	g_dataCenter.trial:Reset();
	PublicFunc.msg_dispatch(msg_expedition_trial.gc_expedition_trial_reset);
	--app.log("清除本地的所有远征试炼数据，恢复本地的所有英雄血量.gc_expedition_trial_reset:");
end

--挑战某一个关卡回复
function msg_expedition_trial.gc_challenge_expedition_trial_rst(level,rst)
	--app.log("挑战某一个关卡回复.gc_challenge_expedition_trial_rst:");
	if rst ~= ENUM.EExpeditionTrialErrorCode.Success then 
		PublicFunc.FloatErrorCode(rst, gs_string_expedition_trial, "expedition_trial")
	else 
		--app.log("挑战关卡");
		PublicFunc.msg_dispatch("trial.challenge_expedition_trial");
	end
end

--同步当前关卡
function msg_expedition_trial.gc_update_cur_expedition_trial_level(level)
	--app.log("同步当前关卡.gc_update_cur_expedition_trial_level:");
	g_dataCenter.trial:serverChangeCurLevel(level);
end

--关卡挑战结果回复
function msg_expedition_trial.gc_expedition_trial_challenge_result_rst(rst)
	--app.log("关卡挑战结果回复.gc_expedition_trial_challenge_result_rst:");
	if rst ~= ENUM.EExpeditionTrialErrorCode.Success then 
		PublicFunc.FloatErrorCode(rst, gs_string_expedition_trial, "expedition_trial")
	end
end

--增加一条拥有的BUFF
function msg_expedition_trial.gc_add_expedition_trial_buff(buffid)
	--app.log("增加一条拥有的BUFF.gc_add_expedition_trial_buff:");
	g_dataCenter.trial:serverAddBuff(buffid);
end

--同步当前关卡
function msg_expedition_trial.gc_decide_expedition_trial_sweep(rst)
	--app.log("同步当前关卡.gc_decide_expedition_trial_sweep:");
	if rst ~= ENUM.EExpeditionTrialErrorCode.Success then 
		PublicFunc.FloatErrorCode(rst, gs_string_expedition_trial, "expedition_trial")
	else 
		g_dataCenter.trial:onServerSweepOver();
	end
end

--同步今日积分
function msg_expedition_trial.gc_update_today_expedition_trial_points(points)
	--app.log("同步今日积分.gc_update_today_expedition_trial_points");
	g_dataCenter.trial:set_todayPoints(points);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial);
end

--批量购买付费宝箱回复
function msg_expedition_trial.gc_batch_buy_expedition_trial_treasure_box_rst(rst)
	--app.log("批量购买付费宝箱回复.gc_batch_buy_expedition_trial_treasure_box_rst");
	if rst ~= ENUM.EExpeditionTrialErrorCode.Success then 
		PublicFunc.FloatErrorCode(rst, gs_string_expedition_trial, "expedition_trial")
	else 
		g_dataCenter.trial:allBuyRst()	
	end 
end

--领取积分奖励回复
function msg_expedition_trial.gc_get_expedition_trial_points_reward_rst(rst,reward)
	if rst ~= ENUM.EExpeditionTrialErrorCode.Success then 
		PublicFunc.FloatErrorCode(rst, gs_string_expedition_trial, "expedition_trial")
	else 
		g_dataCenter.trial:serverRstPointsReward(reward);
		PublicFunc.msg_dispatch("trial.serverGiveAward");
		--PublicFunc.msg_dispatch("trial.serverGiveAward");
	end 
end
--同步积分奖励标志
function msg_expedition_trial.gc_sync_expedition_trial_points_reward_flag(points_reward_flag1,points_reward_flag2,points_reward_flag3)
	--app.log("同步积分奖励标志.gc_sync_expedition_trial_points_reward_flag");
	g_dataCenter.trial:onPointsRewardFlagGet(points_reward_flag1,points_reward_flag2,points_reward_flag3);
	--app.log("@@@@ onServerGiveAward MSG0");
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial);
end
--数据尚未准备好
function msg_expedition_trial.gc_expedition_trial_data_is_preparing()
	FloatTip.Float("服务器数据尚未准备好，请稍后重试");
end
--远征完成
function msg_expedition_trial.gc_finish_expedition_trial()
	--app.log("今日远征试炼已完成");
	g_dataCenter.trial.allInfo.finish = true;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial);
end