--用于记录玩法进入时间进入次数等信息
LevelActivityData = Class("LevelActivityData");
function LevelActivityData:Init()
	self.data = {};
	if LevelActivityData.allCf == nil then
		self:initAllCf();
	end 
	self.activityData = {};
	-- local vipData = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip)
	local vipData = g_dataCenter.player:GetVipData();
	for k,v in pairs(LevelActivityData.allCf) do 
		local cfplayvs = ConfigManager.Get(EConfigIndex.t_play_vs_data,v.id);
		--if cfplayvs.open_level <= g_dataCenter.player.level then 
			v.open_level = cfplayvs.open_level;
			--table.insert(self.activityData,v);
			self.activityData[v.id] = v;
			if v.id == 60054001 then 
				if vipData then
					v.relative = vipData.gsjj_cool_time;
				end
			end
		--end
	end
end

function LevelActivityData:IsOpen()
	local haveRed = false;
	for k, v in pairs(self.activityData) do 
		if self:CheckRedPoint(k) then 
			haveRed = true;
			break;
		end
	end
	return haveRed;
end 

function LevelActivityData:CheckRedPoint(index)
	local data = self.activityData[index];
	if data ~= nil then 
		if data.open_level <= g_dataCenter.player.level then 
			local dataCenter = g_dataCenter.activity[data.id]
			if dataCenter.GetFightTimes ~= nil then 
				local enterTimes,totalTimes = dataCenter:GetFightTimes();
				if enterTimes < totalTimes then 
					return true;
				else 
					return false;
				end
			else 
				return false;
			end
		else 
			return false;
		end
	else
		return false;
	end
end 

function LevelActivityData.initAllCf()
	local cfList = ConfigManager._GetConfigTable(EConfigIndex.t_activity_time);
	local allCf = {};
	for k,v in pairs_key(cfList) do 
		if v.open == 1 then 
			table.insert(allCf,v);
		end
	end
	LevelActivityData.allCf = allCf;
end 