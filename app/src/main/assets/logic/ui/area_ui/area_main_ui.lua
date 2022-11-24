AreaMainUI = Class('AreaMainUI', UiBaseClass);

--重新开始
function AreaMainUI:Restart(data)
    --app.log("AreaMainUI:Restart");
    UiBaseClass.Restart(self, data);
end

function AreaMainUI:InitData(data)
    --app.log("AreaMainUI:InitData");
    UiBaseClass.InitData(self, data);
end

function AreaMainUI:RegistFunc()
	--app.log("AreaMainUI:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickMask'] = Utility.bind_callback(self, self.onClickMask);
	self.bindfunc['onClickBtnWorshipRank'] = Utility.bind_callback(self, self.onClickBtnWorshipRank);
	self.bindfunc['onClickBtnMilitaryRank'] = Utility.bind_callback(self, self.onClickBtnMilitaryRank);
	self.bindfunc['onClickBtnAreaWar'] = Utility.bind_callback(self, self.onClickBtnAreaWar);
	self.bindfunc['onRecvAllAreaData'] = Utility.bind_callback(self, self.onRecvAllAreaData);
	self.bindfunc['onGetTopThree'] = Utility.bind_callback(self, self.onGetTopThree);
	self.bindfunc['worship1'] = Utility.bind_callback(self, self.worship1);
	self.bindfunc['worship2'] = Utility.bind_callback(self, self.worship2);
	self.bindfunc['worship3'] = Utility.bind_callback(self, self.worship3);
	self.bindfunc['onWorshipOk'] = Utility.bind_callback(self, self.onWorshipOk);
	self.bindfunc['onGetRankOk'] = Utility.bind_callback(self, self.onGetRankOk);
	self.bindfunc['onClickChangeArea'] = Utility.bind_callback(self, self.onClickChangeArea);
end

function AreaMainUI:InitUI(asset_obj)
	app.log("AreaMainUI:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('AreaMainUI');
    self.vs = {};
	self.vs.btnWorshipRank = ngui.find_button(self.ui,"centre_other/animation/sp_di_down/btn1");
	self.vs.btnWorshipRank:set_on_click(self.bindfunc['onClickBtnWorshipRank']);
	self.vs.btnMilitaryRank = ngui.find_button(self.ui,"centre_other/animation/sp_di_down/btn2");
	self.vs.btnAreaWar = ngui.find_toggle(self.ui,"centre_other/animation/sp_di_down/btn3");
	self.vs.btnMilitaryRank:set_on_click(self.bindfunc['onClickBtnMilitaryRank']);
	self.vs.btnChangeArea = ngui.find_button(self.ui,"centre_other/animation/btn");
	self.vs.btnChangeArea:set_on_click(self.bindfunc["onClickChangeArea"]);
	self.vs.btnChangeArea:set_enable(false);
	self.vs.btnWorship1 = ngui.find_button(self.ui,"centre_other/animation/cont2/btn");
	self.vs.btnWorship2 = ngui.find_button(self.ui,"centre_other/animation/cont1/btn");
	self.vs.btnWorship3 = ngui.find_button(self.ui,"centre_other/animation/cont3/btn");
	self.vs.btnWorship1:set_on_click(self.bindfunc['worship1']);
	self.vs.btnWorship2:set_on_click(self.bindfunc['worship2']);
	self.vs.btnWorship3:set_on_click(self.bindfunc['worship3']);
	self.vs.labName1 = ngui.find_label(self.ui,"centre_other/animation/cont2/lab_name");
	self.vs.labName2 = ngui.find_label(self.ui,"centre_other/animation/cont1/lab_name");
	self.vs.labName3 = ngui.find_label(self.ui,"centre_other/animation/cont3/lab_name");
	self.vs.labWorshipNum1 = ngui.find_label(self.ui,"centre_other/animation/cont2/lab_mobai");
	self.vs.labWorshipNum2 = ngui.find_label(self.ui,"centre_other/animation/cont1/lab_mobai");
	self.vs.labWorshipNum3 = ngui.find_label(self.ui,"centre_other/animation/cont3/lab_mobai");
	self.vs.labFightValue1 = ngui.find_label(self.ui,"centre_other/animation/cont2/lab_fight");
	self.vs.labFightValue2 = ngui.find_label(self.ui,"centre_other/animation/cont1/lab_fight");
	self.vs.labFightValue3 = ngui.find_label(self.ui,"centre_other/animation/cont3/lab_fight");
	self.vs.show3dTexture = ngui.find_texture(self.ui,"centre_other/animation/texture_human");
	self.vs.labTodayExploit = ngui.find_label(self.ui,"centre_other/animation/sp_di_down/sp_bar1/lab");
	self.vs.labWorshipTime = ngui.find_label(self.ui,"centre_other/animation/sp_di_down/sp_bar2/lab");
	self.vs.labArea = ngui.find_label(self.ui,"centre_other/animation/lab_area");
	local areaDesc = {
		[1] = "1区";
		[2] = "11区";
		[3] = "20区";
	}
	self.vs.labArea:set_text(areaDesc[g_dataCenter.player.country_id]);
	self.loadingId = GLoading.Show(GLoading.EType.ui);
	g_dataCenter.area:getAllAreaData();
end

function AreaMainUI:onClickChangeArea()
	ChangeAreaUi.PopPanel();
end 

function AreaMainUI:updateUI()
	GLoading.Hide(GLoading.EType.ui, self.loadingId);
	local data = 
    {
		showTexture = self.vs.show3dTexture;
        roleData = {{vecCardNum = {g_dataCenter.area.vecTop3[1].vecCardNum[1],g_dataCenter.area.vecTop3[1].vecCardNum[2],g_dataCenter.area.vecTop3[1].vecCardNum[3]}},
		{vecCardNum = {g_dataCenter.area.vecTop3[2].vecCardNum[1],g_dataCenter.area.vecTop3[2].vecCardNum[2],g_dataCenter.area.vecTop3[2].vecCardNum[3]}},
		{vecCardNum = {g_dataCenter.area.vecTop3[3].vecCardNum[1],g_dataCenter.area.vecTop3[3].vecCardNum[2],g_dataCenter.area.vecTop3[3].vecCardNum[3]}}},
    }
    AreaWorshipShow3d.SetAndShow(data)
	self.vs.labName1:set_text(g_dataCenter.area.vecTop3[1].name);
	self.vs.labName2:set_text(g_dataCenter.area.vecTop3[2].name);
	self.vs.labName3:set_text(g_dataCenter.area.vecTop3[3].name);
	self.vs.labFightValue1:set_text("战斗力:"..g_dataCenter.area.vecTop3[1].fightValue);
	self.vs.labFightValue2:set_text("战斗力:"..g_dataCenter.area.vecTop3[2].fightValue);
	self.vs.labFightValue3:set_text("战斗力:"..g_dataCenter.area.vecTop3[3].fightValue);
	self.vs.labWorshipNum1:set_text("膜拜数:"..tostring(g_dataCenter.area.vecTop3[1].worshipTimes));
	self.vs.labWorshipNum2:set_text("膜拜数:"..tostring(g_dataCenter.area.vecTop3[2].worshipTimes));
	self.vs.labWorshipNum3:set_text("膜拜数:"..tostring(g_dataCenter.area.vecTop3[3].worshipTimes));
	local cfMilitaryRank = ConfigManager._GetConfigTable(EConfigIndex.t_military_rank);
	local cf = ConfigManager.Get(EConfigIndex.t_military_rank,g_dataCenter.area.curMilitaryRank);
	self.vs.labTodayExploit:set_text("今日功勋：[05ED3FFF]"..tostring(g_dataCenter.area.todayExploit).."/"..tostring(cf.one_day_max_exploit));
	self.vs.labWorshipTime:set_text("膜拜次数：[05ED3FFF]"..tostring(g_dataCenter.area.todayWorshipTimes).."/3");
end 

function AreaMainUI:worship1()
	g_dataCenter.area:worship(1)
end 

function AreaMainUI:worship2()
	g_dataCenter.area:worship(2)
end 

function AreaMainUI:worship3()
	g_dataCenter.area:worship(3)
end 

function AreaMainUI:onWorshipOk()
	g_dataCenter.area:getAllAreaData();
end 

function AreaMainUI:onRecvAllAreaData()
	app.log("areaData : "..table.tostring({todayWorshipTimes = g_dataCenter.area.todayWorshipTimes,
	todayExploit = g_dataCenter.area.todayExploit,
	totalExploit = g_dataCenter.area.totalExploit,
	curExploit = g_dataCenter.area.curExploit,
	curMilitaryRank = g_dataCenter.area.curMilitaryRank,
	bGetDayReward = g_dataCenter.area.bGetDayReward}));
	g_dataCenter.area:getTop3();
end 

function AreaMainUI:onGetTopThree()
	app.log("top3 : "..table.tostring(g_dataCenter.area.vecTop3));
	self:updateUI();
end 

function AreaMainUI:Init(data)
	app.log("AreaMainUI:Init");
    self.pathRes = "assetbundles/prefabs/ui/area/ui_8002_xuan_ze_quyu.assetbundle";
	UiBaseClass.Init(self, data);
end

function AreaMainUI:onClickBtnWorshipRank()
	--HintUI.SetAndShowHybrid(2, "重新寻找","本次重新寻找需花费：|item:2|,9871487547",nil,{str = "确定",func = function()end},{str = "取消" ,func = function()end});
	--RankPopPanel.popPanel(nil,RANK_TYPE.WORSHIP)
	msg_rank.cg_rank(RANK_TYPE.WORSHIP, 11)
end 

function AreaMainUI:onClickBtnMilitaryRank()
	msg_rank.cg_rank(RANK_TYPE.MILITARY, 11)
end 

function AreaMainUI:onGetRankOk(rank_type, my_rank, ranklist)
	if rank_type == RANK_TYPE.MILITARY then 
		ranklist.my_rank = my_rank;
		AreaMilitaryRank.popPanel(ranklist);
	elseif rank_type == RANK_TYPE.WORSHIP then 
		ranklist.my_rank = my_rank;
		RankPopPanel.popPanel(ranklist,RANK_TYPE.WORSHIP);
	end
end 

function AreaMainUI:onClickBtnAreaWar()
	
end 

--析构函数
function AreaMainUI:DestroyUi()
	app.log("AreaMainUI:DestroyUi");
	if self.vs ~= nil then 
		self.vs = nil;
	end 
	AreaWorshipShow3d.Destroy();
    UiBaseClass.DestroyUi(self);
end

--显示ui
function AreaMainUI:Show()
	app.log("AreaMainUI:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function AreaMainUI:Hide()
	app.log("AreaMainUI:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function AreaMainUI:MsgRegist()
	app.log("AreaMainUI:MsgRegist");
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist("recvAllAreaData",self.bindfunc['onRecvAllAreaData']);
	PublicFunc.msg_regist("getTopThreePowerfulPlayer",self.bindfunc['onGetTopThree']);
	PublicFunc.msg_regist("onWorshipOk",self.bindfunc['onWorshipOk']);
	PublicFunc.msg_regist(msg_rank.gc_rank,self.bindfunc['onGetRankOk']);
end

--注销消息分发回调函数
function AreaMainUI:MsgUnRegist()
	app.log("AreaMainUI:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist("recvAllAreaData",self.bindfunc['onRecvAllAreaData']);
	PublicFunc.msg_unregist("getTopThreePowerfulPlayer",self.bindfunc['onGetTopThree']);
	PublicFunc.msg_unregist("onWorshipOk",self.bindfunc['onWorshipOk']);
	PublicFunc.msg_unregist(msg_rank.gc_rank,self.bindfunc['onGetRankOk']);
end