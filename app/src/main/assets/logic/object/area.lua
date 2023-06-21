Area = Class("Area");

ID_AREA_EXPLOIT	= 20000126

function Area:Init()
    self.data = { }
	
end

function Area:Finalize()
    self.data = { }
end
--���������ȡ��ҵ�������Ϣ
function Area:getAllAreaData()
	msg_area.cg_request_area_data()
end 

function Area:toUpgradeMilitaryRank()
	msg_area.cg_upgrade_military_rank();
end 

function Area:getTop3()
	msg_area.cg_request_area_fight_value_top3()
end 

--�����������������������Ϣ
function Area:recvAllAreaData(todayWorshipTimes,todayExploit,totalExploit,curMilitaryRank,bGetDayReward)
	self.todayWorshipTimes = todayWorshipTimes;
	self.todayExploit = todayExploit;
	self.totalExploit = totalExploit;
	self.curExploit = g_dataCenter.package:find_count(ENUM.EPackageType.Item,ID_AREA_EXPLOIT);
	self.curMilitaryRank = curMilitaryRank;
	self.bGetDayReward = bGetDayReward;
	PublicFunc.msg_dispatch("recvAllAreaData")
end 
--Ĥ��ĳ�����
function Area:worship(index)
	msg_area.cg_worship(index)
end
--����������Ĥ����ҵĽ��
function Area:recvWorshipReward(result,rankIndex,rewardVec)
	if result == 0 then 
		app.log(table.tostring({rewardVec}));
		CommonAward.Start(rewardVec,1);
		local function onRewardShowOver() 
			
		end
		CommonAward.SetFinishCallback(onRewardShowOver);
		PublicFunc.msg_dispatch("onWorshipOk");
	else 
		PublicFunc.GetErrorString(result);
	end
end 
--��ȡĤ�����а�����
function Area:getWorshipRank()
	
end
--����������Ĥ�ݴ���
function Area:updateWorshipTimes()
	PublicFunc.msg_dispatch("worshipTimesChange");
end 
--�����������¹�ѫֵ
function Area:updateExploit()
	PublicFunc.msg_dispatch(Area.updateExploit);
end
--������������������
function Area:upgradeMilitaryRank(result,curMilitaryRank)
	if result == 0 then 
		self.curMilitaryRank = curMilitaryRank;
		if AreaMilitaryRank.cfMilitaryRank ~= nil then 
			local cf = AreaMilitaryRank.cfMilitaryRank[self.curMilitaryRank];
			FloatTip.Float("��������Ϊ��"..cf.military_rank_name);
		else 
			FloatTip.Float("��������");
		end 
		PublicFunc.msg_dispatch(Area.upgradeMilitaryRank);
	else 
		PublicFunc.GetErrorString(result);
	end
end
--��ȡ���ν���
function Area:getMilitaryRankReward()
	msg_area.cg_get_military_rank_reward()
end
--��ȡս��ǰ�������
function Area:getTopThreePowerfulPlayer(vecTop3)
	self.vecTop3 = vecTop3;
	PublicFunc.msg_dispatch("getTopThreePowerfulPlayer")
end
--���������;��߽�������
function Area:receiveMilitaryRankReward(result,vecReward)
	if result == 0 then 
		self.bGetDayReward = 1;
		CommonAward.Start(vecReward,1);
		local function onRewardShowOver() 
			
		end
		CommonAward.SetFinishCallback(onRewardShowOver);
		PublicFunc.msg_dispatch("gotMilitaryRankReward");
	else 
		PublicFunc.GetErrorString(result);
	end 
end

