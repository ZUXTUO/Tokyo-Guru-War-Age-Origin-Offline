TrialChooseRole = Class('TrialChooseRole', UiBaseClass);

function TrialChooseRole.PopPanel(startX,startY)
	if TrialChooseRole.instance == nil then 
		TrialChooseRole.instance = TrialChooseRole:new({startX = startX,startY = startY})
	else 
		TrialChooseRole.instance.startX = startX;
		TrialChooseRole.instance.startY = startY;
		TrialChooseRole.instance:Show();
	end

	NoticeManager.Notice(ENUM.NoticeType.FarTrialChooseRole)
end 

--重新开始
function TrialChooseRole:Restart(data)
    ----app.log("TrialChooseRole:Restart");
    UiBaseClass.Restart(self, data);
end

function TrialChooseRole:InitData(data)
    ----app.log("TrialChooseRole:InitData");
	self.levelData,self.changeInfo = g_dataCenter.trial:get_levelData();
	self.startX = data.startX;
	self.startY = data.startY
	self.index = self.changeInfo.select_difficulty;
    UiBaseClass.InitData(self, data);
end

function TrialChooseRole:RegistFunc()
	----app.log("TrialChooseRole:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickClose'] = Utility.bind_callback(self, self.onClickClose);
	self.bindfunc['onClickRoleCard'] = Utility.bind_callback(self, self.onClickRoleCard);
	self.bindfunc['onClickChallenge'] = Utility.bind_callback(self, self.onClickChallenge);
	self.bindfunc['oneKeySetTeam'] = Utility.bind_callback(self, self.oneKeySetTeam);
	self.bindfunc['on_team_change'] = Utility.bind_callback(self, self.on_team_change);
	self.bindfunc['onChallengeInfoUpdate'] = Utility.bind_callback(self, self.onChallengeInfoUpdate);
	self.bindfunc['onServerEnterFight'] = Utility.bind_callback(self, self.onServerEnterFight);
end

function TrialChooseRole:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TrialChooseRole');
	self.vs = {};
	self.vs.btnClose = ngui.find_button(self.ui,"center_other/animation/content_di_754_458/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['onClickClose']);
	self.vs.btnOneKeyTeam = ngui.find_button(self.ui,"center_other/animation/cont/btn2");
	self.vs.btnTeamChange = ngui.find_button(self.ui,"center_other/animation/cont/btn3");
	self.vs.btnOneKeyTeam:set_on_click(self.bindfunc['oneKeySetTeam']);
	self.vs.btnTeamChange:set_on_click(self.bindfunc['onClickRoleCard']);
	--self.vs.title = ngui.find_label(self.ui,"center_other/animation/cont/lab_title");
	self.vs.powerE = ngui.find_label(self.ui,"center_other/animation/sp_bk_frame2/sp_fight/lab_fight");
	self.vs.powerM = ngui.find_label(self.ui,"center_other/animation/sp_bk_frame1/sp_fight/lab_fight");
	self.vs.title1 = ngui.find_label(self.ui,"center_other/animation/content_di_754_458/lab_title");
	self.vs.title2 = ngui.find_label(self.ui,"center_other/animation/content_di_754_458/lab_title/lab_title2");
	if self.levelData == nil then 
		self.levelData,self.challengeInfo = g_dataCenter.trial:get_levelData();
	end 
	if self.levelData ~= nil then 
		if self.levelData.fight_type == 1 then 
			self.vs.title1:set_text("对决");
			self.vs.title2:set_text("");
		elseif self.levelData.fight_type == 2 then 
			self.vs.title1:set_text("3V3");
			self.vs.title2:set_text("");
		elseif self.levelData.fight_type == 3 then 
			self.vs.title1:set_text("首领");
			self.vs.title2:set_text("争夺");
		end
	end 
	--self.vs.vs = ngui.find_sprite(self.ui,"center_other/animation/sp_vs");
	self.vs.roomE1 = self.ui:get_child_by_name("center_other/animation/sp_bk_frame2/big_card_item_801");
	self.vs.roomE2 = self.ui:get_child_by_name("center_other/animation/sp_bk_frame2/big_card_item_802");
	self.vs.roomE3 = self.ui:get_child_by_name("center_other/animation/sp_bk_frame2/big_card_item_803");
	self.vs.roomM1 = self.ui:get_child_by_name("center_other/animation/sp_bk_frame1/big_card_item_801");
	self.vs.roomM2 = self.ui:get_child_by_name("center_other/animation/sp_bk_frame1/big_card_item_802");
	self.vs.roomM3 = self.ui:get_child_by_name("center_other/animation/sp_bk_frame1/big_card_item_803");
	self.vs.lifeBarM1 = ngui.find_progress_bar(self.ui,"center_other/animation/cont/sp_bk_frame1/big_card_item_801/pro_xuetiao");
	self.vs.lifeBarM2 = ngui.find_progress_bar(self.ui,"center_other/animation/cont/sp_bk_frame1/big_card_item_802/pro_xuetiao");
	self.vs.lifeBarM3 = ngui.find_progress_bar(self.ui,"center_other/animation/cont/sp_bk_frame1/big_card_item_803/pro_xuetiao");
	self.vs.lifeBarE1 = ngui.find_progress_bar(self.ui,"center_other/animation/cont/sp_bk_frame2/big_card_item_801/pro_xuetiao");
	self.vs.lifeBarE2 = ngui.find_progress_bar(self.ui,"center_other/animation/cont/sp_bk_frame2/big_card_item_802/pro_xuetiao");
	self.vs.lifeBarE3 = ngui.find_progress_bar(self.ui,"center_other/animation/cont/sp_bk_frame2/big_card_item_803/pro_xuetiao");
	self.cardE1 = SmallCardUi:new({parent = self.vs.roomE1,stypes = SmallCardUi.SGroupTyps[6]});
	self.cardE2 = SmallCardUi:new({parent = self.vs.roomE2,stypes = SmallCardUi.SGroupTyps[6]});
	self.cardE3 = SmallCardUi:new({parent = self.vs.roomE3,stypes = SmallCardUi.SGroupTyps[6]});
	self.cardM1 = SmallCardUi:new({parent = self.vs.roomM1,stypes = SmallCardUi.SGroupTyps[6]});
	self.cardM2 = SmallCardUi:new({parent = self.vs.roomM2,stypes = SmallCardUi.SGroupTyps[6]}); 
	self.cardM3 = SmallCardUi:new({parent = self.vs.roomM3,stypes = SmallCardUi.SGroupTyps[6]});
	self.cardE1:replaceLifeBar(self.vs.lifeBarE1);
	self.cardE2:replaceLifeBar(self.vs.lifeBarE2);
	self.cardE3:replaceLifeBar(self.vs.lifeBarE3);
	self.cardM1:replaceLifeBar(self.vs.lifeBarM1);
	self.cardM2:replaceLifeBar(self.vs.lifeBarM2);
	self.cardM3:replaceLifeBar(self.vs.lifeBarM3);
	self.vs.btnStart = ngui.find_button(self.ui,"center_other/animation/cont/btn1");
	self.vs.btnStart:set_on_click(self.bindfunc['onClickChallenge']);
	if self.index and self.levelData then 
		local team = g_dataCenter.trial:get_Team();
		if team and team.cards and #team.cards ~= 0 then 
			self:UpdateUI();
		else 
			self:oneKeySetTeam();
		end
	end
	
end

function TrialChooseRole:UpdateUI()
	g_dataCenter.trial:set_diff(g_dataCenter.trial:getChangeInfoByLevelId(g_dataCenter.trial.allInfo.cur_expedition_trial_level).select_difficulty);
	if self.vs == nil then 
		return;
	end 
	self.vs.btnStart:set_enable(false);
	local level = g_dataCenter.player.level
	local team = g_dataCenter.trial:get_Team();
	local pkg = g_dataCenter.package;
	if team and team.cards and #team.cards ~= 0 then 
		if team.cards[1] then self.cardhumanM1 = pkg:find_card(1,team.cards[1]) end 
		if team.cards[2] then self.cardhumanM2 = pkg:find_card(1,team.cards[2]) end 
		if team.cards[3] then self.cardhumanM3 = pkg:find_card(1,team.cards[3]) end 
	end 
	--app.log("choose role : "..tostring(self.index));
	for i = 1,3 do
		local card = TrialChooseDifficult.createTrialCard(self.changeInfo.player_info[self.index].hero_info[i]);
		--app.log("TrialChooseRole ,i : "..tostring(i)..",power : "..tostring(card:GetFightValue()));
		card:UpdateFightValueByExData(card)
		self["cardhumanE"..tostring(i)] = card;
		self["cardhumanE"..tostring(i)].trialPos = i;
	end 
	
	local powerEnemy = self.changeInfo.player_info[self.index].fight_value;
	local powerEnemyLocal = self.cardhumanE1.fight_value + self.cardhumanE2.fight_value + self.cardhumanE3.fight_value;
	--app.log("ServerPower = "..tostring(powerEnemy).." | ".."localPower"..tostring(powerEnemyLocal));
	local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
	local isShowHpBar = nil
	if levelData.fight_type == 1 then
		isShowHpBar = true
	else
		isShowHpBar = false
	end
	if self.cardhumanE1 ~= nil then 
		--powerEnemy = powerEnemy + self.cardhumanE1:GetFightValue();
		self.cardE1:SetData(self.cardhumanE1);
		
		local hp = challengeInfo.hero1_hp;
		if hp == nil or hp == 0 then 
			self.cardE1:SetLifeBar(isShowHpBar,1,true);
			self.cardE1:SetDead(false)
		elseif hp ~= -1 then 
			self.cardE1:SetLifeBar(isShowHpBar,hp/self.cardhumanE1:GetPropertyVal("max_hp"),true);
			self.cardE1:SetDead(false)
		else 
			self.cardE1:SetLifeBar(isShowHpBar,0,true);
			self.cardE1:SetDead(true)
		end		
	else
		self.cardE1:SetData();
		self.cardE1:SetLifeBar(false,0,true);
		self.cardE1:SetDead(false)
	end 
	if self.cardhumanE2 ~= nil then 
		self.cardE2:SetData(self.cardhumanE2);
		--powerEnemy = powerEnemy + self.cardhumanE2:GetFightValue();
		local hp = challengeInfo.hero2_hp;
		if hp == nil or hp == 0 then 
			self.cardE2:SetLifeBar(isShowHpBar,1,true);
			self.cardE2:SetDead(false)
		elseif hp ~= -1 then 
			self.cardE2:SetLifeBar(isShowHpBar,hp/self.cardhumanE2:GetPropertyVal("max_hp"),true);
			self.cardE2:SetDead(false)
		else 
			self.cardE2:SetLifeBar(isShowHpBar,0,true);
			self.cardE2:SetDead(true)
		end		
	else
		self.cardE2:SetData();
		self.cardE2:SetLifeBar(false,0,true);
		self.cardE2:SetDead(false)
	end 
	if self.cardhumanE3 ~= nil then 
		self.cardE3:SetData(self.cardhumanE3);
		--powerEnemy = powerEnemy + self.cardhumanE3:GetFightValue();
		local hp = challengeInfo.hero3_hp;
		if hp == nil or hp == 0 then 
			self.cardE3:SetLifeBar(isShowHpBar,1,true);
			self.cardE3:SetDead(false)
		elseif hp ~= -1 then 
			self.cardE3:SetLifeBar(isShowHpBar,hp/self.cardhumanE3:GetPropertyVal("max_hp"),true);
			self.cardE3:SetDead(false)
		else 
			self.cardE3:SetLifeBar(isShowHpBar,0,true);
			self.cardE3:SetDead(true)
		end		
	else
		self.cardE3:SetData();
		self.cardE3:SetLifeBar(false,0,true);
		self.cardE3:SetDead(false)
	end 
	self.vs.powerE:set_text(tostring(powerEnemy));
	--app.log("team:"..table.tostring(team));		
	local id1,id2,id3;
	if team then 
		id1 = team.cards[1];
		id2 = team.cards[2];
		id3 = team.cards[3];
	end 
	self.allHeroDead = true;
	local powerSelf = 0;
	if id1 then 
		local role = g_dataCenter.package:find_card(1,id1);
		if role ~= nil then
			local hp = role:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial)
			if hp == 0 then 
				fightValue = 0;
				addFightValue = 0;
			else 
				fightValue = role:GetFightValue(--[[ENUM.ETeamType.trial]]);
				addFightValue = TrialChooseRole.getAddFightValue(role);
			end 
			--app.log("1:fightValue = "..tostring(fightValue).." addFightValue = "..tostring(addFightValue));
			powerSelf = powerSelf + fightValue + addFightValue;
			self.cardM1:SetData(role); 
			--app.log("role1 hp = "..tostring(hp));
			if hp == nil then 
				self.cardM1:SetLifeBar(isShowHpBar,1,true);
				self.cardM1:SetDead(false);
				self.allHeroDead = false;
			elseif hp ~= 0 then 
				self.cardM1:SetLifeBar(isShowHpBar,hp/role:GetPropertyVal("max_hp"),true);
				self.cardM1:SetDead(false);
				self.allHeroDead = false;
			else 
				self.cardM1:SetLifeBar(isShowHpBar,0,true);
				self.cardM1:SetDead(true);
			end
		else 
			self.cardM1:SetData();
			self.cardM1:SetLifeBar(false,0,true);
			self.cardM1:SetDead(false);
		end
	else
		self.cardM1:SetData();
		self.cardM1:SetLifeBar(false,0,true);
		self.cardM1:SetDead(false);
	end 
	if id2 then 
		local role = g_dataCenter.package:find_card(1,id2);
		if role ~= nil then 
			local hp = role:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial)
			if hp == 0 then 
				fightValue = 0;
				addFightValue = 0;
			else 
				fightValue = role:GetFightValue(--[[ENUM.ETeamType.trial]]);
				addFightValue = TrialChooseRole.getAddFightValue(role);
			end 
			--app.log("2:fightValue = "..tostring(fightValue).." addFightValue = "..tostring(addFightValue));
			powerSelf = powerSelf + fightValue + addFightValue;
			self.cardM2:SetData(role);
			--app.log("role2 hp = "..tostring(hp));
			if hp == nil then 
				self.cardM2:SetLifeBar(isShowHpBar,1,true);
				self.cardM2:SetDead(false);
				self.allHeroDead = false;
			elseif hp ~= 0 then 
				self.cardM2:SetLifeBar(isShowHpBar,hp/role:GetPropertyVal("max_hp"),true);
				self.cardM2:SetDead(false);
				self.allHeroDead = false;
			else 
				self.cardM2:SetLifeBar(isShowHpBar,0,true);
				self.cardM2:SetDead(true);
			end
		else 
			self.cardM2:SetData();
			self.cardM2:SetLifeBar(false,0,true);
			self.cardM2:SetDead(false);
		end
	else
		self.cardM2:SetData();
		self.cardM2:SetLifeBar(false,0,true);
		self.cardM2:SetDead(false);
	end 
	if id3 then 
		local role = g_dataCenter.package:find_card(1,id3);
		if role ~= nil then 
			local hp = role:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial)
			if hp == 0 then 
				fightValue = 0;
				addFightValue = 0;
			else 
				fightValue = role:GetFightValue(--[[ENUM.ETeamType.trial]]);
				addFightValue = TrialChooseRole.getAddFightValue(role);
			end 
			--app.log("3:fightValue = "..tostring(fightValue).." addFightValue = "..tostring(addFightValue));
			powerSelf = powerSelf + fightValue + addFightValue;
			self.cardM3:SetData(role);
			--app.log("role3 hp = "..tostring(hp));
			if hp == nil then 
				self.cardM3:SetLifeBar(isShowHpBar,1,true);
				self.cardM3:SetDead(false);
				self.allHeroDead = false;
			elseif hp ~= 0 then 
				self.cardM3:SetLifeBar(isShowHpBar,hp/role:GetPropertyVal("max_hp"),true);
				self.cardM3:SetDead(false);
				self.allHeroDead = false;
			else 
				self.cardM3:SetLifeBar(isShowHpBar,0,true);
				self.cardM3:SetDead(true);
			end
		else 
			self.cardM3:SetData();
			self.cardM3:SetLifeBar(false,0,true);
			self.cardM3:SetDead(false);
		end
	else
		self.cardM3:SetData();
		self.cardM3:SetLifeBar(false,0,true);
		self.cardM3:SetDead(false);
	end 
	self.vs.powerM:set_text(tostring(powerSelf));
	self.cardM1:SetCallback(self.bindfunc['onClickRoleCard']);
	self.cardM1:SetAddIcon(false);
	self.cardM2:SetCallback(self.bindfunc['onClickRoleCard']);
	self.cardM2:SetAddIcon(false);
	self.cardM3:SetCallback(self.bindfunc['onClickRoleCard']);
	self.cardM3:SetAddIcon(false);
	local trial = g_dataCenter.trial;
	if trial.allLevelConfig[trial.allInfo.cur_expedition_trial_level].difficult ~= nil and trial.allLevelConfig[trial.allInfo.cur_expedition_trial_level].difficult ~= 0 then 
		self:onChallengeInfoUpdate();
	end 
end 

function TrialChooseRole.getAddFightValue(card)
	local buffIdList = g_dataCenter.trial.allInfo.buff_info;
	--buffIdList = {206,206,206,206,206,206,206,206,206,206,206,206,207,207,207,207,207,207,207,207,207,207,207,207,207,207,207,207};
	local len = #buffIdList;
	local buffEffectNumList = {};
	for i = 1,len do 
		local id = buffIdList[i];
		local cf = ConfigManager.Get(EConfigIndex.t_expedition_trial_buff,id);
		buffEffectNumList[cf.type] = buffEffectNumList[cf.type] or 0;
		buffEffectNumList[cf.type] = buffEffectNumList[cf.type] + cf.effect;
	end
	local fightValue = 0;
	for k, v in pairs(ENUM.EHeroAttribute) do
		if buffEffectNumList[v] ~= nil then 
			local value = card:GetPropertyVal(k);
			local newValue = value * buffEffectNumList[v];
			if ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k] then
                fightValue = fightValue + newValue * ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k];
            end
		end
	end
	return math.floor(fightValue);
end 

function TrialChooseRole.SortRoleByPowerAndHp(tb)
	local tmp = nil;
	for i = 1,#tb do 
		for j = i,#tb do 
			local a = tb[i];
			local b = tb[j];
			local pa = a:GetFightValue();
			local pb = b:GetFightValue();
			local maxhpa = a:GetPropertyVal("max_hp");
			local maxhpb = b:GetPropertyVal("max_hp");
			local hpType = ENUM.RoleCardPlayMethodHPType.ExpeditionTrial;
			local curhpa = a:GetPlayMethodCurHP(hpType);
			local curhpb = b:GetPlayMethodCurHP(hpType);
			local curhpb = b.expedition_trial_hp;
			if curhpa == nil then 
				curhpa = maxhpa;
			end
			if curhpb == nil then 
				curhpb = maxhpb;
			end
			pa = pa * curhpa/maxhpa;
			pb = pb * curhpb/maxhpb;
			if pa < pb then 
				tmp = tb[i];
				tb[i] = tb[j];
				tb[j] = tmp;
			end
		end
	end
end 

function TrialChooseRole.SortRoleByPower(tb)
	local tmp = nil;
	for i = 1,#tb do 
		for j = i,#tb do 
			local a = tb[i];
			local b = tb[j];
			local pa = a:GetFightValue();
			local pb = b:GetFightValue();
			if pa < pb then 
				tmp = tb[i];
				tb[i] = tb[j];
				tb[j] = tmp;
			end
		end
	end
end 

function TrialChooseRole:oneKeySetTeam()
	local teamInfo = g_dataCenter.trial:get_Team()
	if teamInfo and teamInfo.cards ~= nil then 
		teamInfo = teamInfo.cards;
	else 
		teamInfo = {};
	end 
	local maskList = {};
	if teamInfo ~= nil then 
		local temp = {};
		for k,v in pairs(teamInfo) do 
			local card = g_dataCenter.package:find_card(1,v);
			if card and card:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial) ~= 0 then 
				temp[k] = v;
				maskList[v] = 1;
			end 
		end
		teamInfo = temp;
	end
	--local roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have)
	local roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All)
	local tmp = {};
	for k,v in pairs(roleStatesList) do 
		if maskList[v.index] == nil and v:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial) ~= 0 then 
			table.insert(tmp,v);
		end
	end 
	TrialChooseRole.SortRoleByPower(tmp);
	for i = 1,3 do 
		if teamInfo[i] == nil then 
			if #tmp > 0 then 
				teamInfo[i] = table.remove(tmp,1).index;
			end
		else 
			local card = g_dataCenter.package:find_card(1,teamInfo[i]);
			local hp = card:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial);
			if hp ~= nil then 
				if hp == 0 then 
					teamInfo[i] = nil;
					if #tmp > 0 then 
						teamInfo[i] = table.remove(tmp,1).index;
					end
				end
			end
		end
	end
    local _curTeam = teamInfo or {};
	if table.getall(_curTeam) == 0 then 
		FloatTip.Float("您已没有可以上阵的角色了");
	else 
		local _team = PublicFunc.CreateSendTeamData(ENUM.ETeamType.trial, _curTeam)
		msg_team.cg_update_team_info(_team);
		g_dataCenter.trial:set_Team(_team,g_dataCenter.player:GetTeamPos(_team.teamid));
	end 
	self:UpdateUI();
end 

local teamPosList = 
{
	0,1,2,3,4,5,6,7,8,9,10,11,12
}

function TrialChooseRole:onClickRoleCard(card,cardInfo,levelData)
	local teamInfo = g_dataCenter.trial:get_Team()
	if teamInfo and teamInfo.cards ~= nil then 
		teamInfo = teamInfo.cards;
	else 
		teamInfo = {};
	end 
	local maskList = {};
	if teamInfo ~= nil then 
		local temp = {};
		for k,v in pairs(teamInfo) do 
			local card = g_dataCenter.package:find_card(1,v);
			if card and card:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial) ~= 0 then 
				temp[k] = v;
				maskList[v] = 1;
			end 
		end
		teamInfo = temp;
		local _team = PublicFunc.CreateSendTeamData(ENUM.ETeamType.trial, teamInfo)
		g_dataCenter.trial:set_Team(_team,g_dataCenter.player:GetTeamPos(_team.teamid));
	end
    local data = {
        teamType = ENUM.ETeamType.trial,
        heroMaxNum = 3,
        showHPType = ENUM.RoleCardPlayMethodHPType.ExpeditionTrial,
        saveCallback = self.bindfunc['on_team_change']
    }
    uiManager:PushUi(EUI.CommonFormationUI, data)
end 

function TrialChooseRole:on_team_change()
    local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.trial);
    local tmp = {};
    tmp.cards = team;
    g_dataCenter.trial:set_Team(tmp,g_dataCenter.player:GetTeamPos(ENUM.ETeamType.trial));
    self:UpdateUI();
end

function TrialChooseRole:onClickChallenge()
	if g_dataCenter.chatFight:CheckMyRequest() then
		return
	end

	--[[local info = {
		pass_stars = 3;
		enemy_hero1_hp = -1;
		enemy_hero2_hp = -1;
		enemy_hero3_hp = -1;
		my_hero1_hp  = 5000;
		my_hero2_hp  = 5000;
		my_hero3_hp  = 5000;
	}
	msg_expedition_trial.cg_expedition_trial_challenge_result(info)
	self:Hide();
	self:DestroyUi();
	g_dataCenter.trial:challengeNext();
	do return end;--]]
	local team = g_dataCenter.trial:get_Team();
	local pkg = g_dataCenter.package;
	if #team.cards ~= 0 and self.allHeroDead == false then 
		if team.cards[1] then self.cardhumanM1 = pkg:find_card(1,team.cards[1]) end 
		if team.cards[2] then self.cardhumanM2 = pkg:find_card(1,team.cards[2]) end 
		if team.cards[3] then self.cardhumanM3 = pkg:find_card(1,team.cards[3]) end 

		g_dataCenter.trial:set_battleData(self.cardhumanE1,self.cardhumanE2,self.cardhumanE3,self.cardhumanM1,self.cardhumanM2,self.cardhumanM3)
		local fs = g_dataCenter.trial;
		local defTeam = g_dataCenter.player:GetTeam(ENUM.ETeamType.trial);
		if defTeam then
			for i = 1,3 do 
				if defTeam[i] ~= nil then 
					local card = g_dataCenter.package:find_card(1,defTeam[i]);
					if card ~= nil then 
						local hp = card:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial);
						if hp == 0 then 
							defTeam[i] = 0;
						end 
					end 
				end 
			end 
			local team_info = {};
			for k,v in pairs(defTeam) do
				team_info[k] = {};
				team_info[k].index = v;
				team_info[k].pos = k;
			end
			--local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
			--local cfHurdel = ConfigManager.Get(EConfigIndex.t_play_method_hurdle,challengeInfo.hurdle_id);
			--fs:SetLevelIndex(challengeInfo.hurdle_id);
			--fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam,{teamPos =team_info})
			--fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_trial);
			--SceneManager.PushScene(FightScene,fs.fs);
			local trial = g_dataCenter.trial;
			local diff = trial.allLevelConfig[trial.allInfo.cur_expedition_trial_level].difficult;
			msg_expedition_trial.cg_challenge_expedition_trial(trial.allInfo.cur_expedition_trial_level,diff, trial:GetIsAutoFight())
			--msg_activity.cg_enter_activity(self.msgEnumId,fs:Tostring());

		else
			FloatTip.Float("请编辑上阵队伍");
		end
	else 
		FloatTip.Float("还未上阵英雄");
	end
end 

function TrialChooseRole:onServerEnterFight()
	local team = g_dataCenter.trial:get_Team();
	local pkg = g_dataCenter.package;
	--msg_expedition_trial.cg_challenge_expedition_trial(self.allInfo.cur_expedition_trial_level,diff)
	if team.cards[1] then self.cardhumanM1 = pkg:find_card(1,team.cards[1]) end 
	if team.cards[2] then self.cardhumanM2 = pkg:find_card(1,team.cards[2]) end 
	if team.cards[3] then self.cardhumanM3 = pkg:find_card(1,team.cards[3]) end 

	g_dataCenter.trial:set_battleData(self.cardhumanE1,self.cardhumanE2,self.cardhumanE3,self.cardhumanM1,self.cardhumanM2,self.cardhumanM3)
	local fs = g_dataCenter.trial;
	local defTeam = g_dataCenter.player:GetTeam(ENUM.ETeamType.trial);
	if defTeam then
		for i = 1,3 do 
			if defTeam[i] ~= nil then 
				local card = g_dataCenter.package:find_card(1,defTeam[i]);
				if card ~= nil then 
					local hp = card:GetPlayMethodCurHP(ENUM.RoleCardPlayMethodHPType.ExpeditionTrial);
					if hp == 0 then 
						defTeam[i] = 0;
					end 
				end 
			end 
		end 
		local team_info = {};
		for k,v in pairs(defTeam) do
			team_info[k] = {};
			team_info[k].index = v;
			team_info[k].pos = k;
		end
		local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
		fs:SetLevelIndex(levelData.hurdle_id);
		fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam,{teamPos =team_info})
		fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_trial);
		SceneManager.PushScene(FightScene,fs.fs);
		
		-- local info = {
		-- 		pass_stars = 3;
		-- 		enemy_hero1_hp = 0;
		-- 		enemy_hero2_hp = 0;
		-- 		enemy_hero3_hp = 0;
		-- 		is_force_exit = 0;
		-- 		use_time = 30;
		-- 	}
		-- msg_expedition_trial.cg_expedition_trial_challenge_result(info)
		-- TrialChooseRole.Destroy();
		
	end
end 

function TrialChooseRole:onClickClose()
	self:Hide();
	self:DestroyUi();
	if TrialScene.instance ~= nil then 
		TrialScene.instance:ActiveLevel(true);
	end
end 

function TrialChooseRole:Init(data)
	--app.log("TrialChooseRole:Init");
    self.pathRes = "assetbundles/prefabs/ui/expedition_trial/ui_6003_yuan_zheng.assetbundle";
	UiBaseClass.Init(self, data);
end

function TrialChooseRole.Destroy()
	if TrialChooseRole.instance ~= nil then 
		TrialChooseRole.instance:Hide();
		TrialChooseRole.instance:DestroyUi();
		TrialChooseRole.instance = nil;
	end
end 

--析构函数
function TrialChooseRole:DestroyUi()
	--app.log("TrialChooseRole:DestroyUi");
	TrialChooseRole.instance = nil;
	for i = 1,3 do 
		if self["cardM"..tostring(i)] then 
			self["cardM"..tostring(i)]:DestroyUi();
			self["cardM"..tostring(i)] = nil;
		end
		if self["cardE"..tostring(i)] then 
			self["cardE"..tostring(i)]:DestroyUi();
			self["cardE"..tostring(i)] = nil;
		end
	end 
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);	
    --Root.DelUpdate(self.Update, self)
end

function TrialChooseRole.ShowInstance()
	if TrialChooseRole.instance then 
		TrialChooseRole.instance:Show();
	end
end 

function TrialChooseRole.HideInstance()
	if TrialChooseRole.instance then 
		TrialChooseRole.instance:Hide();
	end
end 

--显示ui
function TrialChooseRole:Show(data)
	--app.log("TrialChooseRole:Show");
    UiBaseClass.Show(self);
	self:UpdateUI()
end

--隐藏ui
function TrialChooseRole:Hide()
	--app.log("TrialChooseRole:Hide");
    UiBaseClass.Hide(self);
end

function TrialChooseRole:onChallengeInfoUpdate()
	if self.vs ~= nil then 
		local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
		if challengeInfo ~= nil and challengeInfo.select_difficulty ~= 0 then 
			self.vs.btnStart:set_enable(true);
		end
	end 
end 

--注册消息分发回调函数
function TrialChooseRole:MsgRegist()
	--app.log("TrialChooseRole:MsgRegist");
	PublicFunc.msg_regist("trial.updateChallengeInfo",self.bindfunc['onChallengeInfoUpdate']);
	PublicFunc.msg_regist("trial.challenge_expedition_trial",self.bindfunc['onServerEnterFight']);
	PublicFunc.msg_regist(msg_team.gc_update_team_info, self.bindfunc['on_team_change']);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function TrialChooseRole:MsgUnRegist()
	--app.log("TrialChooseRole:MsgUnRegist");
	PublicFunc.msg_unregist("trial.updateChallengeInfo",self.bindfunc['onChallengeInfoUpdate']);
	PublicFunc.msg_unregist("trial.challenge_expedition_trial",self.bindfunc['onServerEnterFight']);
	PublicFunc.msg_unregist(msg_team.gc_update_team_info, self.bindfunc['on_team_change']);
    UiBaseClass.MsgUnRegist(self);
end