TrialChooseDifficult = Class('TrialChooseDifficult', UiBaseClass);


local uiText = 
{
	[1] = "VIP加成:[5AFF00FF]%d%%[-]",	
}

function TrialChooseDifficult.PopPanel(startX,startY)
	if TrialChooseDifficult.instance ~= nil then 
		do return end;
	end 
	local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
	if challengeInfo and challengeInfo.select_difficulty ~= nil and challengeInfo.select_difficulty ~= 0 then 
		if challengeInfo.hero1_hp ~= 0 or challengeInfo.hero2_hp ~= 0 or challengeInfo.hero3_hp ~= 0 then 
			TrialChooseRole.PopPanel(0,0);
		else 
			TrialChooseDifficult.instance = TrialChooseDifficult:new({startX = startX,startY = startY})
		end
	else 
		TrialChooseDifficult.instance = TrialChooseDifficult:new({startX = startX,startY = startY})
	end

	NoticeManager.Notice(ENUM.NoticeType.FarTrialChooseDiff)
end 

--重新开始
function TrialChooseDifficult:Restart(data)
    --app.log("TrialChooseDifficult:Restart");
    UiBaseClass.Restart(self, data);
end

function TrialChooseDifficult:InitData(data)
    --app.log("TrialChooseDifficult:InitData");
	self.levelData,self.challengeInfo = g_dataCenter.trial:get_levelData();
	if self.challengeInfo == nil then 
		
	else 
		self.startX = data.startX;
		self.startY = data.startY
		UiBaseClass.InitData(self, data);
	end 
end

function TrialChooseDifficult:RegistFunc()
	--app.log("TrialChooseDifficult:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickClose'] = Utility.bind_callback(self, self.onClickClose);
	self.bindfunc['onClickDiff1'] = Utility.bind_callback(self, self.onClickDiff1);
	self.bindfunc['onClickDiff2'] = Utility.bind_callback(self, self.onClickDiff2);
	self.bindfunc['onClickDiff3'] = Utility.bind_callback(self, self.onClickDiff3);
	self.bindfunc['onChallengeInfoUpdate'] = Utility.bind_callback(self, self.onChallengeInfoUpdate);
	self.bindfunc['onClickConfirm'] = Utility.bind_callback(self, self.onClickConfirm);
	self.bindfunc['onPressCard'] = Utility.bind_callback(self, self.onPressCard);
end

function TrialChooseDifficult:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TrialChooseDifficult');
	self.vs = {};
	self.vs.mask = ngui.find_sprite(self.ui,"sp_mark");
	self.vs.ani = self.ui:get_child_by_name("centre_other/animation");
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['onClickClose']);
	self.vs.card1 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk1");
	self.vs.card2 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk2");
	self.vs.card3 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk3");
	if self.vs.card1 == nil then 
		self.vs.card1 = ngui.find_texture(self.ui,"centre_other/animation/sp_big_bk1");
		self.vs.card2 = ngui.find_texture(self.ui,"centre_other/animation/sp_big_bk2");
		self.vs.card3 = ngui.find_texture(self.ui,"centre_other/animation/sp_big_bk3");
	end 
	self.vs.card1:set_name("1");	
	self.vs.card2:set_name("2");
	self.vs.card3:set_name("3");
	self.vs.numBase1 = ngui.find_label(self.vs.card1:get_game_object(),"sp_jifen/lab_num");
	self.vs.numStar1 = ngui.find_label(self.vs.card1:get_game_object(),"sp_star/lab_num");
	self.vs.numFight1 = ngui.find_label(self.vs.card1:get_game_object(),"sp_fight/lab_fight");
	self.vs.numBase2 = ngui.find_label(self.vs.card2:get_game_object(),"sp_jifen/lab_num");
	self.vs.numStar2 = ngui.find_label(self.vs.card2:get_game_object(),"sp_star/lab_num");
	self.vs.numFight2 = ngui.find_label(self.vs.card2:get_game_object(),"sp_fight/lab_fight");
	self.vs.numBase3 = ngui.find_label(self.vs.card3:get_game_object(),"sp_jifen/lab_num");
	self.vs.numStar3 = ngui.find_label(self.vs.card3:get_game_object(),"sp_star/lab_num");
	self.vs.numFight3 = ngui.find_label(self.vs.card3:get_game_object(),"sp_fight/lab_fight");
	--self.vs.vipAdditionScoreRateNode = self.ui:get_child_by_name("sp_tips")
	--self.vs.vipAdditionScoreRate = ngui.find_label(self.ui,"sp_tips/lab");
	self.vs.headRoom1 = ngui.find_texture(self.ui,"centre_other/animation/1/texture_huamn");
	self.vs.headRoom2 = ngui.find_texture(self.ui,"centre_other/animation/2/texture_huamn");
	self.vs.headRoom3 = ngui.find_texture(self.ui,"centre_other/animation/3/texture_huamn");
	--self.vs.btnConfirm = ngui.find_button(self.ui,"center_other/animation/btn");
	--self.vs.card1:set_on_ngui_click(self.bindfunc['onClickConfirm'])	
	--self.vs.card2:set_on_ngui_click(self.bindfunc['onClickConfirm'])
	--self.vs.card3:set_on_ngui_click(self.bindfunc['onClickConfirm'])

	self.power1 = 0;
	self.power2 = 0;
	self.power3 = 0;
	self:InitCard(self.vs.card1:get_game_object(),1);
	self:InitCard(self.vs.card2:get_game_object(),2);
	self:InitCard(self.vs.card3:get_game_object(),3);
	if self.startX ~= nil then 
		self.vs.ani:set_local_scale(0.05,0.05,0.05);
		self.vs.ani:set_local_position(self.startX,self.startY,0);
		self.vs.mask:set_color(1,1,1,0);
		Tween.addTween(self.vs.ani,0.3,{["local_scale"] = {1,1,1},["local_position"] = {0,0,0}},Transitions.EASE_IN_OUT_BACK);
		Tween.addTween(self.vs.mask,0.3,{["color"] = {1,1,1,1}},Transitions.EASE_IN);
	end
	self:setSelect(1);
end

function TrialChooseDifficult:InitCard(obj,index)
	self.vs["cardTitle"..tostring(index)] = ngui.find_sprite(obj,"sp_title");
	self.vs["cardPower"..tostring(index)] = ngui.find_label(obj,"lab_fight");
	self.vs["cardBtn"..tostring(index)] = ngui.find_sprite(obj,obj:get_name());
	if self.vs["cardBtn"..tostring(index)] == nil then 
		self.vs["cardBtn"..tostring(index)] = ngui.find_texture(obj,obj:get_name());
	end 
	self.vs["cardName"..tostring(index)] = ngui.find_label(obj,"lab_name");
	--self.vs["cardSelectFrame"..tostring(index)] = ngui.find_sprite(obj,"sp_kuang");
	local player_info = self.challengeInfo.player_info[index];
	self.vs["cardPower"..tostring(index)]:set_text(tostring(player_info.fight_value) or 0);
	self.vs["cardName"..tostring(index)]:set_text(player_info.name);
	local basePoints = self.levelData.normal_points[index]
	local addPoints,rate = g_dataCenter.trial:GetVipAddPointsAndRate(basePoints);
	local pointsScale = g_dataCenter.trial.allChallengeLevel[self.levelData.id].stars_scale_points[1];
	local totalPoints = math.floor((basePoints + addPoints) * pointsScale);
	self.vs["numBase"..tostring(index)]:set_text(tostring(totalPoints));
	self.vs["numStar"..tostring(index)]:set_text(tostring(self.levelData.get_stars_scale[index]));
	self.vs["numFight"..tostring(index)]:set_text(tostring(player_info.fight_value));
	app.log("icon = "..player_info.icon);
	if player_info.icon < 1000 then 
		player_info.icon = player_info.hero_info[1].hero_id;
	end 
	--self.vs["roleHead"..tostring(index)] = UiPlayerHead:new({parent = self.vs["headRoom"..tostring(index)],roleId = player_info.icon});
	local config = ConfigHelper.GetRole(player_info.icon) or table.empty()
	self.vs["headRoom"..tostring(index)]:set_texture(config.icon300);
	--self.vs["cardBtn"..tostring(index)]:set_on_ngui_click(self.bindfunc['onClickDiff'..tostring(index)]);
	self.vs["cardBtn"..tostring(index)]:set_on_ngui_press(self.bindfunc['onPressCard']);
end 

function TrialChooseDifficult:setSelect(index)
	--self.vs.cardSelectFrame1:set_active(false);
	--self.vs.cardSelectFrame2:set_active(false);
	--self.vs.cardSelectFrame3:set_active(false);
	self.selectIndex = index;
	--self.vs["cardSelectFrame"..tostring(index)]:set_active(true);
	if self.vs ~= nil then 
		local basePoints = self.levelData.normal_points[index]
		local addPoints,rate = g_dataCenter.trial:GetVipAddPointsAndRate(basePoints);
		if rate > 0 then
			--self.vs.vipAdditionScoreRate:set_text(tostring(rate * 100).."%");
		else
			--self.vs.vipAdditionScoreRateNode:set_active(false)
		end
	end 
end 

function TrialChooseDifficult:onPressCard(name,isStart,x,y,obj)
	if isStart then 
		obj:set_local_scale(1.05,1.05,1.05);--Tween.addTween(obj,0.2,{["local_scale"] = {1.05,1.05,1.05}},Transitions.EASE_OUT);
		self:setSelect(tonumber(name));
	else 
		--obj:set_local_scale(1,1,1);--Tween.addTween(obj,0.2,{["local_scale"] = {1,1,1}},Transitions.EASE_IN);
		local function tover()
			self:onClickConfirm(name);
		end
		Tween.addTween(obj,0.2,{["local_scale"] = {1,1,1}},Transitions.EASE_OUT,0,nil,nil,tover);
	end
end 

--创建远征敌人的cardhuman
function TrialChooseDifficult.createTrialCard(hero_info)
	local data =
	{
		number = hero_info.hero_id,
		level = hero_info.hero_level,
		trialLevel = trialLevel,
		trialDiff = trialDiff,
		skill_info = {};
		property = {},
	}
	local obj_config = ConfigHelper.GetRole(hero_info.hero_id)
	if obj_config then
		local role_skill_cfg = ConfigManager.Get(EConfigIndex.t_role_skill, obj_config.rarity)
		if role_skill_cfg then
			if role_skill_cfg.skill ~= 0 then
				for i=1, #role_skill_cfg.skill do
					if obj_config.spe_skill ~= 0 and obj_config.spe_skill[i] then
						data.skill_info[i] = {id = obj_config.spe_skill[i][1],level = 1};
					end
				end
			end
		end
	end
	local tb = {};
	for k,v in pairs(ENUM.EHeroAttribute) do 
		value = hero_info.property[v-ENUM.min_property_id] or 0; 
		table.insert(tb,{key = tonumber(v),value = value});
	end 
	ExpeditionTrialMap.sortMax(tb,"key");
	for i = 1,#tb do 			
		data.property[i] = tb[i].value;
	end 
	local card = CardHuman:new(data);
	return card;
end 

function TrialChooseDifficult:onChallengeInfoUpdate()
	local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
	if challengeInfo ~= nil and challengeInfo.select_difficulty ~= 0 then 
		GLoading.Hide(GLoading.EType.ui, self.loadingId);
		self:Hide();
		self:DestroyUi();
		TrialChooseRole.PopPanel(0,0);
	end
end 

function TrialChooseDifficult:onClickConfirm(name)
	self:setSelect(tonumber(name));
	local levelData,challengeInfo = g_dataCenter.trial:get_levelData();
	if challengeInfo ~= nil then 
		g_dataCenter.trial:set_diff(self.selectIndex)
		self:Hide();
		self:DestroyUi();
		TrialChooseRole.PopPanel(0,0);
	else 
		g_dataCenter.trial:set_diff(self.selectIndex)
		self.loadingId = GLoading.Show(GLoading.EType.ui);
	end
end 

function TrialChooseDifficult:onClickDiff1()
	self:setSelect(1);
end 

function TrialChooseDifficult:onClickDiff2()
	self:setSelect(2);
end 

function TrialChooseDifficult:onClickDiff3()
	self:setSelect(3);
end 

function TrialChooseDifficult:onClickClose()
	self:Hide();
	self:DestroyUi();
	if TrialScene.instance ~= nil then 
		TrialScene.instance:ActiveLevel(true);
	end
end 

function TrialChooseDifficult:Init(data)
	app.log("TrialChooseDifficult:Init");
    self.pathRes = "assetbundles/prefabs/ui/expedition_trial/ui_6002_yuan_zheng.assetbundle";
	UiBaseClass.Init(self, data);
end

function TrialChooseDifficult.Destroy()
	if TrialChooseDifficult.instance ~= nil then 
		TrialChooseDifficult.instance:Hide();
		TrialChooseDifficult.instance:DestroyUi();
		TrialChooseDifficult.instance = nil;
	end
end 

--析构函数
function TrialChooseDifficult:DestroyUi()
	app.log("TrialChooseDifficult:DestroyUi");
	TrialChooseDifficult.instance = nil;
	if self.vs ~= nil then 
		if self.vs.roleHead1 then 
			self.vs.roleHead1:DestroyUi();
		end 
		if self.vs.roleHead2 then 
			self.vs.roleHead2:DestroyUi();
		end 
		if self.vs.roleHead3 then 
			self.vs.roleHead3:DestroyUi();
		end 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

function TrialChooseDifficult.ShowInstance()
	if TrialChooseDifficult.instance then 
		TrialChooseDifficult.instance:Show();
	end
end 

function TrialChooseDifficult.HideInstance()
	if TrialChooseDifficult.instance then 
		TrialChooseDifficult.instance:Hide();
	end
end 

--显示ui
function TrialChooseDifficult:Show()
	app.log("TrialChooseDifficult:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function TrialChooseDifficult:Hide()
	app.log("TrialChooseDifficult:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function TrialChooseDifficult:MsgRegist()
	app.log("TrialChooseDifficult:MsgRegist");
	PublicFunc.msg_regist("trial.updateChallengeInfo",self.bindfunc['onChallengeInfoUpdate']);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function TrialChooseDifficult:MsgUnRegist()
	app.log("TrialChooseDifficult:MsgUnRegist");
	PublicFunc.msg_unregist("trial.updateChallengeInfo",self.bindfunc['onChallengeInfoUpdate']);
    UiBaseClass.MsgUnRegist(self);
end