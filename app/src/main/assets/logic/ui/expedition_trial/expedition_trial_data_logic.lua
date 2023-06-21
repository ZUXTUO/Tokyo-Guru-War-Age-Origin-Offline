
function ExpeditionTrialMap.sortMaxY(tb)
	local tmp = nil;
	for i = 1,#tb do 
		for j = i,#tb do 
			if tb[i].y > tb[j].y then 
				tmp = tb[i];
				tb[i] = tb[j];
				tb[j] = tmp; 
			end
		end
	end
end 

function ExpeditionTrialMap.sortMax(tb,key)
	local tmp = nil;
	for i = 1,#tb do 
		for j = i,#tb do 
			if tb[i][key] > tb[j][key] then 
				tmp = tb[i];
				tb[i] = tb[j];
				tb[j] = tmp;
			end
		end
	end
end 

function ExpeditionTrialMap.sortMin(tb,key)
	local tmp = nil;
	for i = 1,#tb do 
		for j = i,#tb do 
			if tb[i][key] < tb[j][key] then 
				tmp = tb[i];
				tb[i] = tb[j];
				tb[j] = tmp;
			end
		end
	end
end 

function ExpeditionTrialMap.sortMinY(tb)
	local tmp = nil;
	for i = 1,#tb do 
		for j = i,#tb do 
			if tb[i].y < tb[j].y then 
				tmp = tb[i];
				tb[i] = tb[j];
				tb[j] = tmp;
			end
		end
	end
end 

--[[点击排行榜]]
function ExpeditionTrialMap:onClickRank()
	--TrialRecoverRole.PopPanel();
	msg_rank.cg_rank(RANK_TYPE.TRIAL,100);
end 

function ExpeditionTrialMap:onGetRankData(rank_type, my_rank, ranklist)
	--app.log("ExpeditionTrialMap:onGetRankData "..tostring(rank_type));
	if rank_type == RANK_TYPE.TRIAL then 
		if #ranklist == 0 then 
			if self.isUiRankData == true then 
				self.isUiRankData = nil;
				self.vs.txtRankNum:set_text("未上榜");
			else 
				FloatTip.Float("当前暂无排行榜数据");
			end 
			do return end;
		end 
		ranklist.my_rank = my_rank;
		--app.log(table.tostring(ranklist));
		for k,v in pairs(ranklist) do 
			local cf = g_dataCenter.trial.allLevelConfig[v.param3];
			if cf ~= nil then 
				v.num = cf.challengeIndex;
			else 
				v.num = math.floor(v.param3 / 2);
			end
			v.score = v.ranking_num;
		end
		if g_dataCenter.trial.allInfo ~= nil then 
			my_rank.score = g_dataCenter.trial.allInfo.today_point;
		end 
		--app.log("Rank: "..table.tostring(ranklist));
		if self.isUiRankData ~= true then 
			RankPopPanel.popPanel(ranklist,RANK_TYPE.TRIAL);
		else
			self.isUiRankData = nil;
			if my_rank.ranking == nil or my_rank.ranking > 2000 or my_rank.ranking == 0 then 
				self.vs.txtRankNum:set_text("未上榜");
			else 
				self.vs.txtRankNum:set_text("No."..tostring(my_rank.ranking));
			end 
		end 
	end
end 
--[[点击奖励]]
function ExpeditionTrialMap:onClickAward()
	TrialExchangeAward.popPanel();
end 
local clickCount = 0;
--[[点击buff]]
function ExpeditionTrialMap:onClickBuff(name,state)
	if state == true then 
		--TrialBuffList.popPanel();
		local buffIdList = g_dataCenter.trial.allInfo.buff_info;
		--[[local gbuffIdList = {1011000,1011100,1011200,1031109,1031207,1032009,1051009,1051109,1071109,1071208,1083009};
		buffIdList = {};
		if clickCount > 0 then 
			for i = 1,clickCount do 
				buffIdList[i] = gbuffIdList[i];
			end 
		end 
		clickCount = clickCount + 1;
		if clickCount > #gbuffIdList then 
			clickCount = 0;
		end --]]
		local len = #buffIdList;
		local buffEffectNums = {};
		for i = 1,len do 
			local id = buffIdList[i];
			local cf = ConfigManager.Get(EConfigIndex.t_expedition_trial_buff,id);
			buffEffectNums[cf.type] = buffEffectNums[cf.type] or 0;
			buffEffectNums[cf.type] = buffEffectNums[cf.type] + cf.effect;
		end
		self.vs.buffCalendar:set_active(true);
		self.vs.bufflabDef:set_text("");
		self.vs.bufflabAtk:set_text("");
		self.vs.bufflabBlock:set_text("");
		self.vs.bufflabCrit:set_text("");
		local allNum = table.getall(buffEffectNums);
		local maxY = self.initBuffLabY + math.max(allNum,1) * 30;
		local allHight = math.max(allNum,1) * 30 + 70;
		local buffCalendarY = self.buffCalenderY + allHight/2;
		if buffCalendarY > -allHight/2 then 
			buffCalendarY = -allHight/2;
		end 
		local maxWidth = self.vs.buffCalendarTitle:get_size();
		self.vs.buffCalendarTitle:set_position(self.initBuffLabX,maxY - allHight/2 + self.buffCalenderHeight/2,self.initBuffLabZ);
		self.vs.buffCalendarTitle:set_text("肉包效果加成");
		local index = 0;
		if allNum == 0 then 
			if self.vs.bufflab1 == nil then 
				self.vs.bufflab1 = self.vs.bufflabCrit:clone();
			else 
				self.vs.bufflab1:set_active(true);
			end 
			self.vs.bufflab1:set_text("还没有属性加成哦");
			self.vs.bufflab1:set_position(self.initBuffLabX,maxY - 30 - allHight/2 + self.buffCalenderHeight/2,self.initBuffLabZ)
			self.vs.buffCalendar:set_width(260);
			self.vs.buffCalendar:set_height(allHight);
		else 
			if self.vs.bufflab1 ~= nil then 
				self.vs.bufflab1:set_active(false);
			end 
			self.buffShowLabList = {};
			for k,v in pairs(buffEffectNums) do 
				index = index + 1;
				local lab = self.vs.bufflabCrit:clone();
				table.insert(self.buffShowLabList,lab);
				local name = gs_string_property_name[k];
				lab:set_text(name.."+"..tostring(v*100).."%");
				local sx,sy,sz = lab:get_size();
				if sx > maxWidth then 
					maxWidth = sx;
				end
				lab:set_position(self.initBuffLabX,maxY - index * 30 - allHight/2 + self.buffCalenderHeight/2,self.initBuffLabZ);
			end
			self.vs.buffCalendar:set_width(maxWidth + 40);
			self.vs.buffCalendar:set_height(allHight);
		end 
		self.vs.buffCalendar:set_position(self.buffCalenderX,buffCalendarY,self.buffCalenderZ);
		--[[self.vs.bufflabDef:set_text("防御力+"..tostring(numDef*100).."%");
		self.vs.bufflabAtk:set_text("攻击力+"..tostring(numAtk*100).."%");
		self.vs.bufflabBlock:set_text("格挡率+"..tostring(numBlock*100).."%");
		self.vs.bufflabCrit:set_text("暴击率+"..tostring(numCrit*100).."%");--]]
	else 
		self.vs.buffCalendar:set_active(false);
		if self.buffShowLabList then 
			for i = 1,100 do 
				if self.buffShowLabList[i] ~= nil then 
					self.buffShowLabList[i]:set_active(false);
					self.buffShowLabList[i] = nil;
				else 
					break;
				end 
			end
			self.buffShowLabList = nil;
		end 
	end
end 
--[[点击商店]]
function ExpeditionTrialMap:onClickShop()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.Trial)
end 