--[[//玩家信息
struct areaFightValueTop3
{	
	string playerid;			//玩家唯一id
	string name;				//玩家名
	string fightValue;			//战力
	int worshipTimes;			//累计膜拜次数
	list<int> vecCardNum;		//卡组阵容
};

struct net_summary_item
{
	string dataid;
	int id;
	int count;
}
--]]

msg_area = msg_area or {}
--申请战力top3
function msg_area.cg_request_area_fight_value_top3()
	app.log("GET Top 3");
	nmsg_area.cg_request_area_fight_value_top3(Socket.socketServer);
end
--申请自己相关的区域信息
function msg_area.cg_request_area_data()
	app.log("GET Area Info");
	nmsg_area.cg_request_area_data(Socket.socketServer);
end
--膜拜
function msg_area.cg_worship(index)
	nmsg_area.cg_worship(Socket.socketServer,index);
end
--提升军衔
function msg_area.cg_upgrade_military_rank()
	nmsg_area.cg_upgrade_military_rank(Socket.socketServer);
end
--领取每日军衔奖励
function msg_area.cg_get_military_rank_reward()
	nmsg_area.cg_get_military_rank_reward(Socket.socketServer);
end

--申请战力top3的返回消息
function msg_area.gc_request_area_fight_value_top3(vecTop3)
	app.log("Recv Top 3");
	g_dataCenter.area:getTopThreePowerfulPlayer(vecTop3);
end 
--申请自己相关的区域信息的返回消息
function msg_area.gc_request_area_data(todayWorshipTimes, todayExploit, totalExploit, curMilitaryRank, bGetDayReward)
	app.log("Recv Area Info bGetDayReward = "..tostring(bGetDayReward));
	g_dataCenter.area:recvAllAreaData(todayWorshipTimes,todayExploit,totalExploit,curMilitaryRank,bGetDayReward);
end 
--膜拜的返回消息
function msg_area.gc_worship(result, rankIndex, vecReward)
	g_dataCenter.area:recvWorshipReward(result,rankIndex,vecReward);
end 
--提升军衔的返回消息
function msg_area.gc_upgrade_military_rank(result, curMilitaryRank)
	g_dataCenter.area:upgradeMilitaryRank(result,curMilitaryRank);
end 	
--领取每日军衔奖励的返回消息
function msg_area.gc_get_military_rank_reward(result, vecReward)
	g_dataCenter.area:receiveMilitaryRankReward(result,vecReward);
end