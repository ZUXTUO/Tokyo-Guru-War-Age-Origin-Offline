Area = Class("Area");

ID_AREA_EXPLOIT	= 20000126

function Area:Init()
    self.data = { }
	
end

function Area:Finalize()
    self.data = { }
end
--向服务器获取玩家的区域信息
function Area:getAllAreaData()
	msg_area.cg_request_area_data()
end 

function Area:toUpgradeMilitaryRank()
	msg_area.cg_upgrade_military_rank();
end 

function Area:getTop3()
	msg_area.cg_request_area_fight_value_top3()
end 

--服务器推送玩家所有区域信息
function Area:recvAllAreaData(todayWorshipTimes,todayExploit,totalExploit,curMilitaryRank,bGetDayReward)
	self.todayWorshipTimes = todayWorshipTimes;
	self.todayExploit = todayExploit;
	self.totalExploit = totalExploit;
	self.curExploit = g_dataCenter.package:find_count(ENUM.EPackageType.Item,ID_AREA_EXPLOIT);
	self.curMilitaryRank = curMilitaryRank;
	self.bGetDayReward = bGetDayReward;
	PublicFunc.msg_dispatch("recvAllAreaData")
end 
--膜拜某个玩家
function Area:worship(index)
	msg_area.cg_worship(index)
end
--服务器推送膜拜玩家的结果
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
--获取膜拜排行榜数据
function Area:getWorshipRank()
	
end
--服务器推送膜拜次数
function Area:updateWorshipTimes()
	PublicFunc.msg_dispatch("worshipTimesChange");
end 
--服务器推送新功勋值
function Area:updateExploit()
	PublicFunc.msg_dispatch(Area.updateExploit);
end
--服务器推送提升军衔
function Area:upgradeMilitaryRank(result,curMilitaryRank)
	if result == 0 then 
		self.curMilitaryRank = curMilitaryRank;
		if AreaMilitaryRank.cfMilitaryRank ~= nil then 
			local cf = AreaMilitaryRank.cfMilitaryRank[self.curMilitaryRank];
			FloatTip.Float("军衔提升为："..cf.military_rank_name);
		else 
			FloatTip.Float("军衔提升");
		end 
		PublicFunc.msg_dispatch(Area.upgradeMilitaryRank);
	else 
		PublicFunc.GetErrorString(result);
	end
end
--获取军衔奖励
function Area:getMilitaryRankReward()
	msg_area.cg_get_military_rank_reward()
end
--获取战力前三的玩家
function Area:getTopThreePowerfulPlayer(vecTop3)
	self.vecTop3 = vecTop3;
	PublicFunc.msg_dispatch("getTopThreePowerfulPlayer")
end
--服务器推送均线奖励数据
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

