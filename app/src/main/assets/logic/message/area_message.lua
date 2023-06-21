--[[//�����Ϣ
struct areaFightValueTop3
{	
	string playerid;			//���Ψһid
	string name;				//�����
	string fightValue;			//ս��
	int worshipTimes;			//�ۼ�Ĥ�ݴ���
	list<int> vecCardNum;		//��������
};

struct net_summary_item
{
	string dataid;
	int id;
	int count;
}
--]]

msg_area = msg_area or {}
--����ս��top3
function msg_area.cg_request_area_fight_value_top3()
	app.log("GET Top 3");
	nmsg_area.cg_request_area_fight_value_top3(Socket.socketServer);
end
--�����Լ���ص�������Ϣ
function msg_area.cg_request_area_data()
	app.log("GET Area Info");
	nmsg_area.cg_request_area_data(Socket.socketServer);
end
--Ĥ��
function msg_area.cg_worship(index)
	nmsg_area.cg_worship(Socket.socketServer,index);
end
--��������
function msg_area.cg_upgrade_military_rank()
	nmsg_area.cg_upgrade_military_rank(Socket.socketServer);
end
--��ȡÿ�վ��ν���
function msg_area.cg_get_military_rank_reward()
	nmsg_area.cg_get_military_rank_reward(Socket.socketServer);
end

--����ս��top3�ķ�����Ϣ
function msg_area.gc_request_area_fight_value_top3(vecTop3)
	app.log("Recv Top 3");
	g_dataCenter.area:getTopThreePowerfulPlayer(vecTop3);
end 
--�����Լ���ص�������Ϣ�ķ�����Ϣ
function msg_area.gc_request_area_data(todayWorshipTimes, todayExploit, totalExploit, curMilitaryRank, bGetDayReward)
	app.log("Recv Area Info bGetDayReward = "..tostring(bGetDayReward));
	g_dataCenter.area:recvAllAreaData(todayWorshipTimes,todayExploit,totalExploit,curMilitaryRank,bGetDayReward);
end 
--Ĥ�ݵķ�����Ϣ
function msg_area.gc_worship(result, rankIndex, vecReward)
	g_dataCenter.area:recvWorshipReward(result,rankIndex,vecReward);
end 
--�������εķ�����Ϣ
function msg_area.gc_upgrade_military_rank(result, curMilitaryRank)
	g_dataCenter.area:upgradeMilitaryRank(result,curMilitaryRank);
end 	
--��ȡÿ�վ��ν����ķ�����Ϣ
function msg_area.gc_get_military_rank_reward(result, vecReward)
	g_dataCenter.area:receiveMilitaryRankReward(result,vecReward);
end