GaoSuJuJi = Class("GaoSuJuJi",PlayMethodBase);

function GaoSuJuJi:Init(data)
	PlayMethodBase.Init(self,data);
	self.systemId = data;
end

function GaoSuJuJi:ClearData(data)
	PlayMethodBase.ClearData(self,data);
	self.heroList = {
	-- 	[1] = {index=xxxx,hp=xxx,isDead=false},
	-- 	[2] = {index=xxxx,hp=xxx,isDead=false},
	};
	self.is_open = false;
	self.bigWave = 0;
	self.isGetFirstPass = false;
	self.isSave = false;
	self.cur_groud = 0;
	self.max_groud = 1;
end

function GaoSuJuJi:IsFirstPass()
	return g_dataCenter.player:GetFlagHelper():GetNumberFlag(self.systemId);
end

function GaoSuJuJi:GetHeroList()
	return self.heroList;
end

function GaoSuJuJi:SetActivityStruct(ag)
	self.fightResult = ag.fight_result;
	self.bigWave = ag.bigWave;
	self.bossHP = ag.statueHp;
	-- if tonumber(self.bigWave) == 0 then
	-- 	return;
	-- end
	local num = 1;
	self.heroList = {};
	if ag.battleRole1 ~= "" and tonumber(ag.battleRole1) ~= 0  then
		self.heroList[num] = {index=ag.battleRole1,hp=ag.battleRole1Hp,isDead=false};
		num = num + 1
	end
	if ag.battleRole2 ~= "" and tonumber(ag.battleRole2) ~= 0  then
		self.heroList[num] = {index=ag.battleRole2,hp=ag.battleRole2Hp,isDead=false};
		num = num + 1
	end
	if ag.battleRole3 ~= "" and tonumber(ag.battleRole3) ~= 0 then
		self.heroList[num] = {index=ag.battleRole3,hp=ag.battleRole3Hp,isDead=false};
		num = num + 1
	end
	local role_list = ag.roles;
	for i=1,#role_list do
		self.heroList[num] = {index=role_list[i],hp=-1,isDead=false};
		num = num + 1;
	end
	local dead_list = ag.deadRoles;
	for i=1,#dead_list do
		self.heroList[num] = {index=dead_list[i],hp=0,isDead=true};
		num = num + 1;
	end
	if self.bigWave == 0 then
		self.isSave = false;
	else
		self.isSave = true;
	end
end

function GaoSuJuJi:GetActivityStruct()
	local tb = {};
	tb.fight_result = self.fightResult;
	tb.bigWave = self.bigWave;
	tb.roles = {};
	tb.deadRoles = {};
	tb.statueHp = self.bossHP;
	local role_num = 1;
	for i,v in ipairs(self.heroList) do
		if v.isDead then
			table.insert(tb.deadRoles,v.index);
		else
			if v.hp ~= 0 and role_num <= 3 then
				tb["battleRole"..tostring(role_num)] = v.index;
				tb["battleRole"..tostring(role_num).."Hp"] = v.hp;
				role_num = role_num + 1;
			else
				table.insert(tb.roles,v.index);
			end
		end
	end
	return tb;
end

function GaoSuJuJi:SetHero(index,hp,isDead)
	for k,v in pairs(self.heroList) do
		if v.index == index then
			self.heroList[k].hp = hp;
			self.heroList[k].isDead = isDead;
		end
	end
end

function GaoSuJuJi:GetHeroHp(index)
	for k,v in pairs(self.heroList) do
		if v.index == index then
			return v.hp;
		end
	end
end

function GaoSuJuJi:GetBossHP()
	return self.bossHP;
end

function GaoSuJuJi:SetBossHP(hp)
	self.bossHP = hp;
end

function GaoSuJuJi:SetExtParm(param)
	PlayMethodBase.SetExtParm(self,param);
	self.heroList = param.team;
end

function GaoSuJuJi:UpdateWave(cur_groud,cur_wave)
	self.cur_groud = cur_groud;
	self.cur_wave = cur_wave;
end

function GaoSuJuJi:EndGroud(cur_groud,cur_wave,max_groud)
	self.cur_groud = cur_groud;
	self.max_groud = max_groud;
	self.cur_wave = cur_wave;
end

function GaoSuJuJi:SetAwards(awards)
	--app.log("GaoSuJuJi Awards:"..table.tostring(awards));
	if self.cur_groud >= self.max_groud then
		-- local data = self:_GameResult(true, awards );
		-- CommonClearing.SetFinishCallback(FightScene.ExitFightScene);
		-- CommonClearing.Start(data);
		-- 缓存奖励等leave消息回来后，再显示奖励
		self.awards = awards;
	else
		GaoSuJuJiFightUI.Show(true,false,awards,self.cur_groud,self.cur_wave);
	end
end

function GaoSuJuJi:GameResult(isWin, awards,  param)
	-- app.log("GaoSuJuJi Awards:"..table.tostring(awards));
	if isWin then
		GaoSuJuJiFightUI.Show(true,true,self.awards,self.cur_groud,self.cur_wave)
	else
		if #awards ~= 0 then
			GaoSuJuJiFightUI.Show(false,false,awards,self.cur_groud,self.cur_wave);
		else
			local data = {};
			data.jump = 
			{
				jumpFunctionList = {ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipLevelUp},
			}
			CommonClearing.SetFinishCallback(FightScene.ExitFightScene);
			CommonClearing.Start(data);
		end
	    -- local data = self:_GameResult(isWin, awards,  param);
	    -- CommonClearing.SetFinishCallback(FightScene.ExitFightScene);
	    -- CommonClearing.Start(data);
	end
end

function GaoSuJuJi:GetFightResult()
	local number = g_dataCenter.player:GetFlagHelper():GetStringFlag(self.systemId);
	number = number or "3";
	self.fightResult = self.fightResult or (tonumber(number) or 3);
	return self.fightResult;
end

function GaoSuJuJi:IsOpen()
	local last_hurdle_data = g_dataCenter.activity[self.systemId-1];
	if last_hurdle_data and last_hurdle_data:GetFightResult() ~= nil then
		if last_hurdle_data:GetFightResult() == 0 then
			if self:GetFightResult() <= 1 then
				self.is_open = false;
			else
				self.is_open = true;
			end
		else
			self.is_open = false;
		end
	else
		if self:GetFightResult() <= 1 then
			self.is_open = false;
		else
			self.is_open = true;
		end
	end
	local is_open = ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi).open_level <= g_dataCenter.player.level
	if not is_open then
		self.is_open = false;
	end
    return self.is_open;
end

GaoSuJuJiAll = Class("GaoSuJuJiAll");
function GaoSuJuJiAll:IsOpen()
	for i=1,4 do
		if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiB-1+i]:IsOpen() then
			return true;
		end
	end
	return false;
end
