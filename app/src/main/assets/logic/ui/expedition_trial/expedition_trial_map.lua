ExpeditionTrialMap = Class('ExpeditionTrialMap', UiBaseClass);

--重新开始
function ExpeditionTrialMap:Restart(data)
    ----app.log("ExpeditionTrialMap:Restart");
    -- g_dataCenter.trial:initServerData();
    UiBaseClass.Restart(self, data);
	TrialScene.GetInstance(self);
end

function ExpeditionTrialMap:InitData(data)
    ----app.log("ExpeditionTrialMap:InitData");
    UiBaseClass.InitData(self, data);
end

function ExpeditionTrialMap:LoadUI()
	
end 
 
function ExpeditionTrialMap:RegistFunc()
	----app.log("ExpeditionTrialMap:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickRank'] = Utility.bind_callback(self, self.onClickRank);
	self.bindfunc['onClickAward'] = Utility.bind_callback(self, self.onClickAward);
	self.bindfunc['onClickShop'] = Utility.bind_callback(self, self.onClickShop);
	self.bindfunc['onClickBuff'] = Utility.bind_callback(self, self.onClickBuff);
	self.bindfunc['on_get_all_info'] = Utility.bind_callback(self, self.on_get_all_info);
	self.bindfunc['onTrialInfoUpdate'] = Utility.bind_callback(self, self.onTrialInfoUpdate);
	self.bindfunc['setStarNum'] = Utility.bind_callback(self, self.setStarNum);
	self.bindfunc['setTodayPoints'] = Utility.bind_callback(self, self.setTodayPoints);
	self.bindfunc['on_rank_data_get'] = Utility.bind_callback(self, self.onGetRankData);
	self.bindfunc['onServerDataReset'] = Utility.bind_callback(self, self.onServerDataReset);
	self.bindfunc['onServerGiveAward'] = Utility.bind_callback(self, self.onServerGiveAward);
	self.bindfunc['touchStart'] = Utility.bind_callback(self, self.touchStart);
	self.bindfunc['touchMove'] = Utility.bind_callback(self, self.touchMove);
	self.bindfunc['touchEnd'] = Utility.bind_callback(self, self.touchEnd);
	self.bindfunc['touchClick'] = Utility.bind_callback(self, self.touchClick);
	self.bindfunc['btnArrowLeftClick'] = Utility.bind_callback(self, self.btnArrowLeftClick);
	self.bindfunc['btnArrowRightClick'] = Utility.bind_callback(self, self.btnArrowRightClick);
	self.bindfunc['on_my_ranking_get'] = Utility.bind_callback(self, self.on_my_ranking_get);
end

function ExpeditionTrialMap:on_my_ranking_get(rank_type,ranking)
	if rank_type == RANK_TYPE.TRIAL and self.vs ~= nil and self.vs.txtRankNum ~= nil then 
		self.isUiRankData = false;
		if ranking == -1 then 
			--FloatTip.Float("当前暂无捕食场排行榜数据");
			self.vs.txtRankNum:set_text("未上榜");
		elseif ranking > 2000 then 
			self.vs.txtRankNum:set_text("未上榜");
		else 
			self.vs.txtRankNum:set_text("No."..tostring(ranking));
		end 
	end
end 

function ExpeditionTrialMap:InitUI(asset_obj)
	--app.log("ExpeditionTrialMap:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_name("ExpeditionTrialMap");

    local topPath = "top_other/animation/"
    local centerPath = "down_other/animation/"
 
	self.vs = {};
	self.vs.starNumLab = ngui.find_label(self.ui, centerPath .. "sp_bar1/txt1/lab_num");
	self.vs.starNumLab:set_overflow(2);
	self.vs.trialScoreLab = ngui.find_label(self.ui, centerPath .. "sp_bar1/txt2/lab_num");
	self.vs.trialScoreLab:set_overflow(2);
	self.vs.btnRank = ngui.find_button(self.ui, topPath .. "cont_down/btn_rank");
	self.vs.btnRankShow = ngui.find_button(self.ui, centerPath .. "btn_rank");
	self.vs.txtRankNum = ngui.find_label(self.ui, centerPath .. "btn_rank/animation/sp_bar2/txt1/lab_num");
	self.vs.btnAward = ngui.find_button(self.ui, topPath .. "cont_down/btn_award");
	self.vs.spAwardRedPoint = ngui.find_sprite(self.ui, topPath .. "cont_down/btn_award/animation/sp");
	self.vs.spAwardRedPoint:set_active(false);
	self.vs.btnShop = ngui.find_button(self.ui, topPath .. "cont_down/btn_shop");
	self.vs.touchsp = ngui.find_sprite(self.ui, "center_touch");
	self.vs.touchsp:set_on_ngui_drag_start(self.bindfunc["touchStart"]);
	self.vs.touchsp:set_on_ngui_drag_move(self.bindfunc["touchMove"]);
	self.vs.touchsp:set_on_ngui_drag_end(self.bindfunc["touchEnd"]);
	self.vs.touchsp:set_on_ngui_click(self.bindfunc["touchClick"]);
	self.vs.spTouchTip1 = ngui.find_sprite(self.ui,"center_touch/sp_tips1");
	self.vs.spTouchTip2 = ngui.find_sprite(self.ui,"center_touch/sp_tips2");
	self.vs.spTouchTip1:set_active(false);
	self.vs.spTouchTip2:set_active(false);
	self.vs.btnArrowLeft = ngui.find_button(self.ui,"panel_btn_arrows/btn_left");
	self.vs.btnArrowRight = ngui.find_button(self.ui,"panel_btn_arrows/btn_right");
		
	self.vs.btnArrowLeft:set_on_click(self.bindfunc["btnArrowLeftClick"]);
	self.vs.btnArrowRight:set_on_click(self.bindfunc["btnArrowRightClick"]);
	
	self.vs.btnBuff = ngui.find_button(self.ui, topPath .. "btn_buff");
	self.vs.buffCalendar = ngui.find_sprite(self.ui, topPath .. "sp_buff_bk");
	self.vs.buffCalendarTitle = ngui.find_label(self.ui, topPath .. "sp_buff_bk/txt");
	self.vs.bufflabDef = ngui.find_label(self.ui, topPath .. "sp_buff_bk/lab_num1");
	self.vs.bufflabAtk = ngui.find_label(self.ui, topPath .. "sp_buff_bk/lab_num2");
	self.vs.bufflabBlock = ngui.find_label(self.ui, topPath .. "sp_buff_bk/lab_num3");
	self.vs.bufflabCrit = ngui.find_label(self.ui, topPath .. "sp_buff_bk/lab_num4");
	self.buffCalenderX,self.buffCalenderY,self.buffCalenderZ = self.vs.buffCalendar:get_position();
	self.buffCalenderWidth = self.vs.buffCalendar:get_width();
	self.buffCalenderHeight = self.vs.buffCalendar:get_height();
	self.initBuffLabX,self.initBuffLabY,self.initBuffLabZ = self.vs.bufflabCrit:get_position();
	self.vs.buffCalendar:set_active(false);
	self.vs.btnRankShow:set_on_click(self.bindfunc['onClickRank']);
	self.vs.btnRank:set_on_click(self.bindfunc['onClickRank']);
	self.vs.btnAward:set_on_click(self.bindfunc['onClickAward']);
	self.vs.btnShop:set_on_click(self.bindfunc['onClickShop']);
	self.vs.btnBuff:set_on_ngui_press(self.bindfunc['onClickBuff']);
	self.boxPositions = {};
	local team = g_dataCenter.player:GetDefTeam();
	g_dataCenter.trial:initServerData();
	--if g_dataCenter.trial.allInfo.cur_expedition_trial_level == 1 then 
		g_dataCenter.trial:SaveEnterInfo();
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial);
	--end
	self:SetArrowBtnState(0);
	--msg_rank.cg_rank(RANK_TYPE.TRIAL,1);
	msg_rank.cg_my_rank(RANK_TYPE.TRIAL)
	self.isUiRankData = true;
	if self.isTrialSceneNeedActiveLevel then 
		self.isTrialSceneNeedActiveLevel = nil;
		if TrialScene.instance ~= nil then 
			TrialScene.instance:ActiveLevel();
		end 
	end
end

function ExpeditionTrialMap:onTrialSceneLoadok()
	UiBaseClass.LoadUI(self);
	if self.vs ~= nil then 
		if TrialScene.instance ~= nil then 
			TrialScene.instance:ActiveLevel();
		end 
	else 
		self.isTrialSceneNeedActiveLevel = true;
	end
end 

function ExpeditionTrialMap:touchStart(name,x,y,obj)
	if self.disable_move then return end
	if TrialScene.instance ~= nil then 
		TrialScene.instance:DragStart(x);
	end
end 

function ExpeditionTrialMap:touchMove(name,x,y,obj)
	if self.disable_move then return end
	if TrialScene.instance ~= nil then 
		TrialScene.instance:DragMove(x);
	end
end 

function ExpeditionTrialMap:touchEnd(name,x,y,obj)
	if self.disable_move then return end
	if TrialScene.instance ~= nil then 
		TrialScene.instance:DragEnd(x);
	end
end 

function ExpeditionTrialMap:touchClick(name,x,y,obj)
	if TrialScene.instance ~= nil then 
		TrialScene.instance:Click(x,y);
	end
end 

function ExpeditionTrialMap:btnArrowLeftClick()
	if TrialScene.instance ~= nil then 
		TrialScene.instance:CameraFollow();
	end
	self:SetArrowBtnState(0);
end 

function ExpeditionTrialMap:btnArrowRightClick()
	if TrialScene.instance ~= nil then 
		TrialScene.instance:CameraFollow();
	end
	self:SetArrowBtnState(0);
end 

function ExpeditionTrialMap:SetArrowBtnState(state)
	if self.vs ~= nil then 
		if state == 0 then 
			self.vs.btnArrowLeft:set_active(false);
			self.vs.btnArrowRight:set_active(false);
		elseif state == 1 then 
			self.vs.btnArrowLeft:set_active(true);
			self.vs.btnArrowRight:set_active(false);
		elseif state == 2 then 
			self.vs.btnArrowLeft:set_active(false);
			self.vs.btnArrowRight:set_active(true);
		end
	end 
end 

function ExpeditionTrialMap:refreshRedPoint()
	local pointAwardNum = TrialExchangeAward.GetMaxRewardNum();
	if pointAwardNum > g_dataCenter.trial.RewardGotNum then 
		self.vs.spAwardRedPoint:set_active(true);
	else
		self.vs.spAwardRedPoint:set_active(false);
	end
end 

function ExpeditionTrialMap:onServerGiveAward()
	self:refreshRedPoint();
end 

function ExpeditionTrialMap:onServerDataReset()
	if self.changeIconTimerId ~= nil then 
		timer.stop(self.changeIconTimerId);
		self.changeIconTimerId = nil;
	end 
	if self.changeIconHuman ~= nil then 
		Tween.removeTween(self.changeIconHuman.headIcon);
	end 
	if TrialScene.instance ~= nil then 
		TrialScene.instance:DataReset();
	end
	TrialChooseRole.Destroy();
	TrialChooseDifficult.Destroy();
	TrialBuffList.Destroy();
	TrialBuyBuff.Destroy();
	TrialSingleMysteryBox.Destroy();
	TrialMultMysteryBox.Destroy();
	TrialExchangeAward.Destroy();
	--g_dataCenter.trial:initServerData();
end 

function ExpeditionTrialMap:setStarNum()
	self.vs.starNumLab:set_text(tostring(g_dataCenter.trial:get_star()));
end 

function ExpeditionTrialMap:setTodayPoints()
	self.vs.trialScoreLab:set_text(tostring(g_dataCenter.trial:get_todayScore()));
end 

function ExpeditionTrialMap:on_get_all_info()
	--app.log("on_get_all_info");
	--self:createData();
	self:refreshRedPoint();
	if TrialScene.instance ~= nil then 
		TrialScene.instance:toUpdateTrailAllLevel();
	end 
	self:setStarNum();
	self:setTodayPoints();
	if g_dataCenter.trial.allInfo.decide_expedition_trial_sweep == 0 and g_dataCenter.trial.allInfo.cur_expedition_trial_level == 1 and g_dataCenter.trial.canSweepLevel > 0 then 
		local function doSweep()
			g_dataCenter.trial:sweepTrial(true);
		end
		local function notdoSweep()
			g_dataCenter.trial:sweepTrial(false);
		end
		HintUI.SetAndShowNew(EHintUiType.two,"扫荡远征试炼","当前可以扫荡远征试炼前"..tostring(g_dataCenter.trial.canSweepLevel).."关\n是否扫荡？",nil,{str = "确定",func = doSweep},{str = "取消",func = notdoSweep});
	end
end 

function ExpeditionTrialMap:Init(data)
	--app.log("ExpeditionTrialMap:Init");
    self.pathRes = "assetbundles/prefabs/ui/expedition_trial/ui_6001_yuan_zheng.assetbundle";
	UiBaseClass.Init(self, data);
end

function ExpeditionTrialMap:onTrialInfoUpdate()
	if TrialScene.instance ~= nil then 
		TrialScene.instance:ActiveLevel();
	end 
end 

--析构函数
function ExpeditionTrialMap:DestroyUi()
	if self.vs == nil then 
		do return end;
	end 
	if self.changeIconTimerId ~= nil then 
		timer.stop(self.changeIconTimerId);
		self.changeIconTimerId = nil;
	end 
	TrialChooseRole.Destroy();
	TrialChooseDifficult.Destroy();
	TrialBuyBuff.Destroy();
	TrialSingleMysteryBox.Destroy();
	TrialMultMysteryBox.Destroy();
	TrialExchangeAward.Destroy();
	TrialScene.Destroy();
	self.vs = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function ExpeditionTrialMap:Show()
	--app.log("ExpeditionTrialMap:Show");
	TrialChooseRole.ShowInstance();
	TrialChooseDifficult.ShowInstance();
	TrialBuyBuff.ShowInstance();
	TrialSingleMysteryBox.ShowInstance();
	TrialMultMysteryBox.ShowInstance();
	TrialExchangeAward.ShowInstance();
    UiBaseClass.Show(self);
end

--隐藏ui
function ExpeditionTrialMap:Hide()
	--app.log("ExpeditionTrialMap:Hide");
	TrialChooseRole.HideInstance();
	TrialChooseDifficult.HideInstance();
	TrialBuyBuff.HideInstance();
	TrialSingleMysteryBox.HideInstance();
	TrialMultMysteryBox.HideInstance();
	TrialExchangeAward.HideInstance();
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function ExpeditionTrialMap:MsgRegist()
	--app.log("ExpeditionTrialMap:MsgRegist");
	PublicFunc.msg_regist("trial.set_all_expedition_trial_info",self.bindfunc['on_get_all_info']);
	PublicFunc.msg_regist("trial.updateChallengeInfo",self.bindfunc['onTrialInfoUpdate']);
	PublicFunc.msg_regist("trial.setStarNum",self.bindfunc['setStarNum']);
	PublicFunc.msg_regist("trial.setTodayPoints",self.bindfunc['setTodayPoints']);
	PublicFunc.msg_regist("trial.serverGiveAward",self.bindfunc["onServerGiveAward"]);
	PublicFunc.msg_regist(msg_rank.gc_rank,self.bindfunc['on_rank_data_get']);	
	PublicFunc.msg_regist(msg_rank.gc_my_rank,self.bindfunc['on_my_ranking_get']);
	PublicFunc.msg_regist(msg_expedition_trial.gc_expedition_trial_reset,self.bindfunc['onServerDataReset']);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function ExpeditionTrialMap:MsgUnRegist()
	--app.log("ExpeditionTrialMap:MsgUnRegist");
	PublicFunc.msg_unregist("trial.set_all_expedition_trial_info",self.bindfunc['on_get_all_info']);
	PublicFunc.msg_unregist("trial.updateChallengeInfo",self.bindfunc['onTrialInfoUpdate']);
	PublicFunc.msg_unregist("trial.setStarNum",self.bindfunc['setStarNum']);
	PublicFunc.msg_unregist("trial.setTodayPoints",self.bindfunc['setTodayPoints']);
	PublicFunc.msg_unregist("trial.serverGiveAward",self.bindfunc["onServerGiveAward"]);
	PublicFunc.msg_unregist("trial.refreshRedPoint",self.bindfunc["onServerGiveAward"]);
	PublicFunc.msg_unregist(msg_rank.gc_rank,self.bindfunc['on_rank_data_get']);
	PublicFunc.msg_unregist(msg_rank.gc_my_rank,self.bindfunc['on_my_ranking_get']);
	PublicFunc.msg_unregist(msg_expedition_trial.gc_expedition_trial_reset,self.bindfunc['onServerDataReset']);
    UiBaseClass.MsgUnRegist(self);
end

-------------------------- 新手引导添加接口 ------------------------
function ExpeditionTrialMap:SetDisableMove(bool)
	self.disable_move = bool
end

function ExpeditionTrialMap:GetSpTouchTip1()
	if self.vs and self.vs.spTouchTip1 then
		return self.vs.spTouchTip1:get_game_object()
	end
end
