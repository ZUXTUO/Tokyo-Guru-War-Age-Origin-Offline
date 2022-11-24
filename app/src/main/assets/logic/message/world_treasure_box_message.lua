--[[
region world_treasure_box_messsage.lua
date: 2016-7-15
time: 19:30:21
author: Nation
]]
msg_world_treasure_box = msg_world_treasure_box or {}
ENUM.EWorldTreasureBoxErrorCode = 
{
	Success 				= 0,
	NotFoundCard 			= 1,--找不到卡片
	NotOpen 				= 2,--世界宝箱未开启
	NotFoundMap 			= 3,--世界宝箱地图未找到
	IsInMap 				= 4,--已经在世界宝箱地图
	IsEnterCD 				= 5,--正在进入CD
	Invalid 				= 6,--非法操作
	ReliveNotEnoughCrystal 	= 7,--完美复活钻石不够
};

function msg_world_treasure_box.cg_enter_world_treasure_box()
    --if not Socket.socketServer then return end
    nmsg_world_treasure_box.cg_enter_world_treasure_box(Socket.socketServer);
end

function msg_world_treasure_box.cg_leave_world_treasure_box()
    --if not Socket.socketServer then return end
    nmsg_world_treasure_box.cg_leave_world_treasure_box(Socket.socketServer);
end

--请求积分排名
function msg_world_treasure_box.cg_request_point_rank()
    --if not Socket.socketServer then return end
    nmsg_world_treasure_box.cg_request_point_rank(Socket.socketServer);
end

--请求宝箱数量
function msg_world_treasure_box.cg_request_world_treasure_box_num()
    --if not Socket.socketServer then return end
    nmsg_world_treasure_box.cg_request_world_treasure_box_num(Socket.socketServer);
end

--完美复活
function msg_world_treasure_box.cg_world_treasure_box_hero_relive_immediately()
    --if not Socket.socketServer then return end
    nmsg_world_treasure_box.cg_world_treasure_box_hero_relive_immediately(Socket.socketServer);
end
---------------------------------------------------

function msg_world_treasure_box.gc_enter_world_treasure_box_rst(rst, seconds)
	if rst ~= 0 then
		if rst == ENUM.EWorldTreasureBoxErrorCode.IsEnterCD then
			HintUI.SetAndShow(EHintUiType.two, "进入CD中，请等待恢复时间", {str = "确定", time=seconds+1, func =  msg_world_treasure_box.cg_enter_world_treasure_box},{str = "取消"})
		else
			PublicFunc.FloatErrorCode(rst, gs_string_world_treasure_box, "world_treasure_box")
		end
	end
end

--同步结束信息
function msg_world_treasure_box.gc_sync_fight_result(mysterious_box_info, rank_info, mysterious_country_reward)
	g_dataCenter.worldTreasureBox:SetFightResult(mysterious_box_info, rank_info, mysterious_country_reward)
	--PublicFunc.msg_dispatch(msg_world_treasure_box.gc_sync_fight_result)
	if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox then
		FightScene.GetFightManager():FightOver();
		uiManager:PushUi(EUI.WorldTreasureBoxResultUI);
	end
end

--同步世界宝箱的状态	state:EWorldTreasureBoxState, left_time:秒
function msg_world_treasure_box.gc_sync_world_treasure_box_state(state, left_time, round_index)
	g_dataCenter.worldTreasureBox:SetSystemState(state, left_time, round_index)
	PublicFunc.msg_dispatch(msg_world_treasure_box.gc_sync_world_treasure_box_state)
end

--完美复活回复
function msg_world_treasure_box.gc_world_treasure_box_hero_relive_immediately_rst(rst)
	if rst ~= ENUM.EWorldTreasureBoxErrorCode.Success then
		PublicFunc.FloatErrorCode(rst, gs_string_world_treasure_box, "world_treasure_box")
	else
		CommonDead.Destroy()
	end
end

--[[endregion]]