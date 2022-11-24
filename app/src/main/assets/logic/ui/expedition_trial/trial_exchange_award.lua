TrialExchangeAward = Class('TrialExchangeAward',UiBaseClass)

function TrialExchangeAward.popPanel()
	TrialExchangeAward.instance = TrialExchangeAward:new();
end 

--重新开始
function TrialExchangeAward:Restart(data)
    --app.log("TrialExchangeAward:Restart");
    UiBaseClass.Restart(self, data);
	if TrialExchangeAward.allCf == nil then 
		local cf = ConfigManager._GetConfigTable(EConfigIndex.t_expedition_trial_points_reward);
		TrialExchangeAward.allCf = cf;
	end 
	self.awardItemList = {};
end

function TrialExchangeAward:InitData(data)
    --app.log("TrialExchangeAward:InitData");
    UiBaseClass.InitData(self, data);
	if TrialExchangeAward.allCf == nil then 
		local cf = ConfigManager._GetConfigTable(EConfigIndex.t_expedition_trial_points_reward);
		TrialExchangeAward.allCf = cf;
	end 
	self.awardItemList = {};
end

function TrialExchangeAward.GetMaxRewardNum()
	local allScore = math.floor(g_dataCenter.trial.allInfo.today_point+g_dataCenter.trial.allInfo.total_point*g_dataCenter.trial.scoreRate/100);
	if TrialExchangeAward.allCf == nil then 
		local cf = ConfigManager._GetConfigTable(EConfigIndex.t_expedition_trial_points_reward);
		TrialExchangeAward.allCf = cf;
	end 
	local count = 0;
	for i = 1,#TrialExchangeAward.allCf do 
		if TrialExchangeAward.allCf[i].need_points > allScore then 
			break;
		else 
			count = count+1;
		end
	end
	return count;
end 

function TrialExchangeAward:RegistFunc()
	--app.log("TrialExchangeAward:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onCloseClick'] = Utility.bind_callback(self, self.onCloseClick);
	self.bindfunc['onServerGiveAward'] = Utility.bind_callback(self, self.onServerGiveAward);
	self.bindfunc['initAllAwardItem'] = Utility.bind_callback(self, self.initAllAwardItem);
	self.bindfunc['initAwardListItem'] = Utility.bind_callback(self, self.initAwardListItem);
	self.bindfunc['onPressBtnGuize'] = Utility.bind_callback(self, self.onPressBtnGuize);
end

function TrialExchangeAward:InitUI(asset_obj)
	app.log("TrialExchangeAward:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TrialExchangeAward');
	self.vs = {};
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['onCloseClick']);
	self.vs.labScore = ngui.find_label(self.ui,"centre_other/animation/content/lab_title1/lab_num");
	self.vs.spExplian = ngui.find_sprite(self.ui,"centre_other/animation/content/sp_item");
	self.vs.labExplainScore = ngui.find_label(self.ui,"centre_other/animation/content/sp_item/txt1");
	self.vs.labExplainScore:set_overflow(2);
	self.vs.labExplainScore:set_text("积分=历史总积分×"..tostring(g_dataCenter.trial.scoreRate).."%+今日积分");
	self.vs.labExplain = ngui.find_label(self.ui,"centre_other/animation/content/sp_item/txt2");
	self.vs.labExplain:set_text("积分=历史总积分×"..tostring(g_dataCenter.trial.scoreRate).."%+今日积分");
	self.vs.labExplain:set_overflow(2);
	self.vs.btnGuize = ngui.find_button(self.ui,"centre_other/animation/content/btn_guize");
	self.vs.btnGuize:set_on_ngui_press(self.bindfunc['onPressBtnGuize']);
	self.vs.spExplian:set_active(false);
	self.vs.scrollAllAward = ngui.find_scroll_view(self.ui,"centre_other/animation/content/sco_view/panel");
	self.vs.scrollAwardList = ngui.find_scroll_view(self.ui,"centre_other/animation/panel");
	self.vs.wrapContentAllAward = ngui.find_wrap_content(self.ui,"centre_other/animation/content/sco_view/panel/wrap_cont");
	self.vs.wrapContentAwardList = ngui.find_wrap_content(self.ui,"centre_other/animation/sco_view/panel/wrap_content");
	self.vs.wrapContentAllAward:set_on_initialize_item(self.bindfunc['initAllAwardItem']);
	self.vs.wrapContentAwardList:set_on_initialize_item(self.bindfunc['initAwardListItem']);
	self.vs.wrapContentAllAward:reset();
	self.vs.wrapContentAwardList:reset();
	self.vs.scrollAwardList:reset_position();
	self.vs.scrollAllAward:reset_position();
	self:UpdateUi();
end

function TrialExchangeAward:initAllAwardItem(obj,b,real_id)
	local index = math.abs(real_id)
    local col = math.abs(b) + 1
	self.gotAwardList = self.gotAwardList or {};
	self.gotAwardItemList = self.gotAwardItemList or {};
	local pid = obj:get_instance_id();
	self.gotAwardItemList[pid] = self.gotAwardItemList[pid] or self:createGotAwardItem(obj);
	local data = self.gotAwardList[index+1];
	if data ~= nil then 
		self.gotAwardItemList[pid]:setData(data.id,data.num);
	end
end 

function TrialExchangeAward:createGotAwardItem(obj)
	local gotAwardItem = {};
	gotAwardItem.item = UiSmallItem:new({parent = obj,is_enable_goods_tip = true});
	function gotAwardItem:setData(id,num)
		self.item:SetDataNumber(id,num);
	end
	return gotAwardItem;
end 

function TrialExchangeAward:onPressBtnGuize(name,state)
	if state == true then 
		self.vs.spExplian:set_active(true);
		self.vs.labExplainScore:set_text(tostring(TrialExchangeAward.score).."="..tostring(self.totalScore).."×"..tostring(g_dataCenter.trial.scoreRate).."%+"..tostring(self.todayScore));
	else 
		self.vs.spExplian:set_active(false);
	end
end 

function TrialExchangeAward:initAwardListItem(obj,b,real_id)
	self.indexOffset = self.indexOffset or 1
	local index = math.abs(real_id - self.indexOffset + 1)
    local row = math.abs(b) + 1
	local pid = obj:get_instance_id();
	self.awardItemList[pid] = self.awardItemList[pid] or self:createAwardItem(obj);
	local cf = TrialExchangeAward.allCf[index + 1];
	if cf ~= nil then 
		self.awardItemList[pid]:setData(cf,index+1);
	end 
end 

function TrialExchangeAward:createAwardItem(obj)
	local awardItem = {};
	awardItem.itemPos1 = obj:get_child_by_name("grid/small_card_item1");
	awardItem.itemPos2 = obj:get_child_by_name("grid/small_card_item2");
	awardItem.itemPos3 = obj:get_child_by_name("grid/small_card_item3");
	awardItem.itemPos4 = obj:get_child_by_name("grid/small_card_item4");
	awardItem.labScoreNum = ngui.find_label(obj,"sp_ban_tou/lab_num");
	awardItem.labScoreNum:set_overflow(2);
	awardItem.btnGet = ngui.find_button(obj,"btn1");
	awardItem.GotIcon = ngui.find_sprite(obj,"sp_get");
	awardItem.item1 = UiSmallItem:new({parent = awardItem.itemPos1,is_enable_goods_tip = true});
	awardItem.item2 = UiSmallItem:new({parent = awardItem.itemPos2,is_enable_goods_tip = true});
	awardItem.item3 = UiSmallItem:new({parent = awardItem.itemPos3,is_enable_goods_tip = true});
	awardItem.item4 = UiSmallItem:new({parent = awardItem.itemPos4,is_enable_goods_tip = true});
	function awardItem:setData(data,index)
		for k,v in pairs(data.reward) do 
			if tonumber(k) < 5 then 
				self["item"..tostring(k)]:SetDataNumber(v.id,v.num);
			end
		end 
		self.labScoreNum:set_text(tostring(data.need_points));
		self.isGet = g_dataCenter.trial.pointRewardFlags[index];
		if self.isGet == 1 then 
			self.btnGet:set_active(false);
			self.GotIcon:set_active(true);
		elseif self.isGet == 0 then 
			if TrialExchangeAward.score ~= nil then 
				if TrialExchangeAward.score < data.need_points then 
					self.btnGet:set_active(false);
					self.GotIcon:set_active(false);
				else 
					self.btnGet:set_active(true);
					self.GotIcon:set_active(false);
				end
			end 
		else 
			app.log("pointRewardFlag error");
			self.btnGet:set_active(false);
			self.GotIcon:set_active(false);
		end
		self.data = data;
		self.index = index;
	end
	function awardItem:clickGet()
		self.loadingId = GLoading.Show(GLoading.EType.ui);
		g_dataCenter.trial:getPointReward(self.index-1);
	end
	awardItem.bindfunc = {};
	awardItem.bindfunc['clickGet'] = Utility.bind_callback(awardItem,awardItem.clickGet);
	awardItem.btnGet:set_on_click(awardItem.bindfunc['clickGet']);
	return awardItem;
end 

function TrialExchangeAward:UpdateUi()
	--app.log("TrialExchangeAward:UpdateUi");
	self.totalScore = g_dataCenter.trial.allInfo.total_point;
	self.todayScore = g_dataCenter.trial.allInfo.today_point;
	TrialExchangeAward.score = math.floor(self.todayScore+self.totalScore*g_dataCenter.trial.scoreRate/100);
	self.vs.labExplainScore:set_text(tostring(TrialExchangeAward.score).."="..tostring(self.totalScore).."×"..tostring(g_dataCenter.trial.scoreRate).."%+"..tostring(self.todayScore));
	self.vs.labScore:set_text(tostring(TrialExchangeAward.score))
	if self.isInitWrapConent == nil then 
		local len = #TrialExchangeAward.allCf;
		for i = 1,len do 
			if g_dataCenter.trial.pointRewardFlags[i] == 0 then 
				if i > len - 4 then 
					self.indexOffset = len - 5;
				else 
					self.indexOffset = i - 1;	
				end
				if self.indexOffset < 1 then 
					self.indexOffset = 1;
				end
				break;
			end  
		end 
		self.vs.wrapContentAwardList:set_min_index(-#TrialExchangeAward.allCf + self.indexOffset)
		self.vs.wrapContentAwardList:set_max_index(self.indexOffset - 1)
	end 
	local len = #TrialExchangeAward.allCf;
	local idList = {};
	local gotAwardList = {};
	for i = 1,len do 
		local cf = TrialExchangeAward.allCf[i];
		if g_dataCenter.trial.pointRewardFlags[i] == 1 then 
			for k,v in pairs(cf.reward) do 
				idList[v.id] = idList[v.id] or 0;
				idList[v.id] = idList[v.id] + v.num;
			end
		end
	end
	for k,v in pairs(idList) do 
		table.insert(gotAwardList,{id = tonumber(k),num = v});
	end
	self.gotAwardList = gotAwardList;
	self.vs.wrapContentAllAward:set_min_index(0);
	self.vs.wrapContentAllAward:set_max_index(#self.gotAwardList-1);
	self.vs.wrapContentAllAward:reset();
	self.vs.wrapContentAwardList:reset();
	self.vs.scrollAwardList:update_position();
	self.isInitWrapConent = 1;
	--for k,v in pairs(self.awardItemList) do 
	--	v:setData(v.data,v.index);
	--end
end 

function TrialExchangeAward:onServerGiveAward()
	--app.log("@@@@ onServerGiveAward UI");
	GLoading.Hide(GLoading.EType.ui, self.loadingId);
	self:UpdateUi();
end 

function TrialExchangeAward:onCloseClick()
	self:Hide();
	self:DestroyUi();
end 

function TrialExchangeAward:Init(data)
	--app.log("TrialExchangeAward:Init");
    self.pathRes = "assetbundles/prefabs/ui/expedition_trial/ui_6005_yuan_zheng.assetbundle";
	UiBaseClass.Init(self, data);
end

function TrialExchangeAward.Destroy()
	if TrialExchangeAward.instance ~= nil then 
		TrialExchangeAward.instance:Hide();
		TrialExchangeAward.instance:DestroyUi();
	end
end 

--析构函数
function TrialExchangeAward:DestroyUi()
	--app.log("TrialExchangeAward:DestroyUi");
	if self.vs ~= nil then 
		self.vs = nil;
	end 
	for k,v in pairs(self.awardItemList) do 
		Utility.del_callback(v.bindfunc['clickGet'])
		v.btnGet:reset_on_click();
	end
	self.awardItemList = nil;
    UiBaseClass.DestroyUi(self);
	TrialExchangeAward.instance = nil;
    --Root.DelUpdate(self.Update, self)
end

function TrialExchangeAward.ShowInstance()
	if TrialExchangeAward.instance then 
		TrialExchangeAward.instance:Show();
	end
end 

function TrialExchangeAward.HideInstance()
	if TrialExchangeAward.instance then 
		TrialExchangeAward.instance:Hide();
	end
end 
--显示ui
function TrialExchangeAward:Show()
	--app.log("TrialExchangeAward:Show");
    UiBaseClass.Show(self);
	self:UpdateUi();
end

--隐藏ui
function TrialExchangeAward:Hide()
	--app.log("TrialExchangeAward:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function TrialExchangeAward:MsgRegist()
	--app.log("TrialExchangeAward:MsgRegist");
	PublicFunc.msg_regist("trial.serverGiveAward",self.bindfunc["onServerGiveAward"]);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function TrialExchangeAward:MsgUnRegist()
	--app.log("TrialExchangeAward:MsgUnRegist");
	PublicFunc.msg_unregist("trial.serverGiveAward",self.bindfunc["onServerGiveAward"]);
    UiBaseClass.MsgUnRegist(self);
end