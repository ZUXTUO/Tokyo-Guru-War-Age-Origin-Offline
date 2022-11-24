TrialMultMysteryBox = Class('TrialMultMysteryBox',UiBaseClass)

function TrialMultMysteryBox.popPanel(boxInfo)
	TrialMultMysteryBox.instance = TrialMultMysteryBox:new(boxInfo);
end 

--重新开始
function TrialMultMysteryBox:Restart(boxInfo)
    ----app.log("TrialMultMysteryBox:Restart");
    UiBaseClass.Restart(self, boxInfo);
	self.boxInfo = boxInfo;
end

function TrialMultMysteryBox:InitData(boxInfo)
    ----app.log("TrialMultMysteryBox:InitData");
    UiBaseClass.InitData(self, boxInfo);
	self.boxInfo = boxInfo;
end

function TrialMultMysteryBox:RegistFunc()
	----app.log("TrialMultMysteryBox:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickAllOpen1'] = Utility.bind_callback(self, self.onClickAllOpen1);
	self.bindfunc['onClickAllOpen2'] = Utility.bind_callback(self, self.onClickAllOpen2);
	self.bindfunc['onClickAllOpen3'] = Utility.bind_callback(self, self.onClickAllOpen3);
	self.bindfunc['onClickAllOpen4'] = Utility.bind_callback(self, self.onClickAllOpen4);
	self.bindfunc['onClickNext'] = Utility.bind_callback(self, self.onClickNext);
	self.bindfunc['initListItem'] = Utility.bind_callback(self, self.initListItem);
	self.bindfunc['onClickBox'] = Utility.bind_callback(self, self.onClickBox);
	self.bindfunc['onAllBuyRst'] = Utility.bind_callback(self, self.onAllBuyRst);
end

function TrialMultMysteryBox:InitUI(asset_obj)
	--app.log("TrialMultMysteryBox:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TrialMultMysteryBox');
	self.vs = {};
	self.vs.titlePass = ngui.find_label(self.ui,"centre_other/animation/lab_word");
	self.vs.btnAllOpen1 = ngui.find_button(self.ui,"centre_other/animation/btn1/btn");
	self.vs.btnAllOpen2 = ngui.find_button(self.ui,"centre_other/animation/btn2/btn");
	self.vs.btnAllOpen3 = ngui.find_button(self.ui,"centre_other/animation/btn3/btn");
	self.vs.btnAllOpen4 = ngui.find_button(self.ui,"centre_other/animation/btn4/btn");
	self.vs.allOpenBtnLab1 = ngui.find_label(self.ui,"centre_other/animation/btn1/btn/animation/lab");
	self.vs.allOpenBtnLab2 = ngui.find_label(self.ui,"centre_other/animation/btn2/btn/animation/lab");
	self.vs.allOpenBtnLab3 = ngui.find_label(self.ui,"centre_other/animation/btn3/btn/animation/lab");
	self.vs.allOpenBtnLab4 = ngui.find_label(self.ui,"centre_other/animation/btn4/btn/animation/lab");
	self.vs.allOpenCostLab1 = ngui.find_label(self.ui,"centre_other/animation/btn1/lab2");
	self.vs.allOpenCostLab2 = ngui.find_label(self.ui,"centre_other/animation/btn2/lab2");
	self.vs.allOpenCostLab3 = ngui.find_label(self.ui,"centre_other/animation/btn3/lab2");
	self.vs.allOpenCostLab4 = ngui.find_label(self.ui,"centre_other/animation/btn4/lab2");
	self.vs.btnAllOpen1:set_on_click(self.bindfunc['onClickAllOpen1']);
	self.vs.btnAllOpen2:set_on_click(self.bindfunc['onClickAllOpen2']);
	self.vs.btnAllOpen3:set_on_click(self.bindfunc['onClickAllOpen3']);
	self.vs.btnAllOpen4:set_on_click(self.bindfunc['onClickAllOpen4']);
	self.vs.boxList = ngui.find_scroll_view(self.ui,"centre_other/animation/panel");
	self.vs.boxWrapContent = ngui.find_wrap_content(self.ui,"centre_other/animation/panel/wrap_cont");
	self.vs.boxWrapContent:set_on_initialize_item(self.bindfunc['initListItem']);
	self.vs.boxList:reset_position();
	self.vs.title = ngui.find_label(self.ui,"centre_other/animation/lab_title");
	self.vs.btnNext = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha");
	self.vs.btnNext:set_on_click(self.bindfunc['onClickNext']);
	self.vs.boxWrapContent:set_min_index(0);
    self.vs.boxWrapContent:set_max_index(#self.boxInfo - 1);
    self.vs.boxWrapContent:reset() 
	self:UpdateUi();
end

function TrialMultMysteryBox:initListItem(obj,b,real_id)
	local index = math.abs(real_id)
	if self.vs.arrow then 
		if index+1 == #self.boxInfo then 
			self.vs.arrow:set_active(false);
		else 
			self.vs.arrow:set_active(true);
		end
	end 
    local col = math.abs(b) + 1
	self.boxItemList = self.boxItemList or {};
	local pid = obj:get_instance_id();
	self.boxItemList[pid] = self.boxItemList[pid] or self:createBoxItem(obj);
	self.boxItemList[pid]:setData(self.boxInfo[index+1],index+1);
end 

function TrialMultMysteryBox:createBoxItem(obj)
	local boxItem = {}
	boxItem.boxTitle = ngui.find_label(obj,"sp_top/lab_num1");
	boxItem.boxtxt = ngui.find_label(obj,"sp_top/txt");
	boxItem.boxSprite = ngui.find_sprite(obj,"box1/sp_box");
	boxItem.boxOpenedNumLab = ngui.find_label(obj,"sp_down/lab_num2");
	boxItem.boxBtn = ngui.find_button(obj,"box1");
	boxItem.boxSp1 = ngui.find_sprite(obj,"box1/sp_box1");
	boxItem.boxSp2 = ngui.find_sprite(obj,"box1/sp_box2");
	boxItem.boxSp3 = ngui.find_sprite(obj,"box1/sp_box3");
	boxItem.boxSp4 = ngui.find_sprite(obj,"box1/sp_box4");
	boxItem.boxSp5 = ngui.find_sprite(obj,"box1/sp_box5");
	boxItem.boxSp6 = ngui.find_sprite(obj,"box1/sp_box6");
	boxItem.boxSp7 = ngui.find_sprite(obj,"box1/sp_box7");
	boxItem.bgBtn = ngui.find_button(obj," sp_diban");
	boxItem.boxOpenedLab = ngui.find_label(obj,"sp_down/lab_open");
	
	boxItem.bgBtn:set_on_click(self.bindfunc['onClickBox']);
	boxItem.boxBtn:set_on_click(self.bindfunc['onClickBox']);
	function boxItem:setData(data,index)
		self.index = index;
		if data ~= nil then 
			--app.log("BoxIndex = "..tostring(self.index).." BoxData = "..tostring(data));
			for i = 1,7 do 
				if i ~= g_dataCenter.trial.allLevelConfig[data.levelid].page then 
					self["boxSp"..tostring(i)]:set_active(false);
				else
					self["boxSp"..tostring(i)]:set_active(true);
				end
			end 
			if data.levelid == #g_dataCenter.trial.allLevelConfig then 
				self.boxSp7:set_active(true);
			end
			self.bgBtn:set_event_value(tostring(data.levelid),data.buy_times)
			self.boxBtn:set_event_value(tostring(data.levelid),data.buy_times)
			local cf = g_dataCenter.trial.allLevelConfig[data.levelid];
			self.boxTitle:set_text(tostring(cf.challengeIndex));
			self.boxtxt:set_text("关");
			self.boxOpenedNumLab:set_text("[2FFF41FF]"..tostring(data.buy_times).."[-][2F3041FF]/"..tostring(cf.pay_treasure_box_num).."[-]");
			--self.boxSprite:set_sprite_name("klz_bao");
			self.boxOpenedLab:set_text("已开启");
			--obj:set_active(true);
		else
			--obj:set_active(false);
		end
	end 
	return boxItem;
end 

function TrialMultMysteryBox:onClickBox(data)
	local cf = g_dataCenter.trial.allLevelConfig[tonumber(data.string_value)];
	local function onConfirm()
		g_dataCenter.trial:openPayBox(tonumber(data.string_value),1);
	end 
	if cf.pay_treasure_box_num > data.float_value then 
		local price = cf.pay_treasure_box_price[data.float_value+1] or cf.pay_treasure_box_price[#cf.pay_treasure_box_price];
		HintUI.SetAndShowNew(EHintUiType.two,"开启宝箱","确定花费"..tostring(price).."个钻石\n开启一次神秘宝箱吗？",nil,{str = "确定",func = onConfirm},{str = "取消"})		
	else 
		FloatTip.Float("宝箱开启次数已用完");
	end
end 

function TrialMultMysteryBox:UpdateUi()
	local box = self.boxInfo[#self.boxInfo]
	local cf = g_dataCenter.trial.allLevelConfig[box.levelid];
	self.vs.titlePass:set_text("您已通过[f2ae1c]"..tostring(cf.challengeIndex).."[-]关，可以获得如下奖励")
	for k,v in pairs(self.boxItemList) do 
		v:setData(self.boxInfo[v.index],v.index);
	end
	if self:CalPrice(10) == 0 then 
		self:Hide();
		self:DestroyUi();
		if g_dataCenter.trial.buffInfo ~= nil and #g_dataCenter.trial.buffInfo > 0 then 
			TrialBuyBuff.PopPanel(g_dataCenter.trial.buffInfo);
		end
	else 
		self.vs.allOpenBtnLab1:set_text("全开一次");
		self.vs.allOpenBtnLab2:set_text("全开两次");
		self.vs.allOpenBtnLab3:set_text("全开五次");
		self.vs.allOpenBtnLab4:set_text("全开十次");
		self.vs.allOpenCostLab1:set_text(tostring(self:CalPrice(1)));
		self.vs.allOpenCostLab2:set_text(tostring(self:CalPrice(2)));
		self.vs.allOpenCostLab3:set_text(tostring(self:CalPrice(5)));
		self.vs.allOpenCostLab4:set_text(tostring(self:CalPrice(10)));
	end 
end 

function TrialMultMysteryBox:CalPrice(allOpenNum)
	local allPrice = 0;
	for k,v in pairs(self.boxInfo) do 
		local cf = g_dataCenter.trial.allLevelConfig[v.levelid];
		local maxOpenTimes = cf.pay_treasure_box_num;
		local priceList = cf.pay_treasure_box_price;
		local toIndex = math.min(v.buy_times+allOpenNum,maxOpenTimes);
		local boxTotalPrice = 0;
		for i = v.buy_times+1,toIndex do 
			local price = priceList[i] or priceList[#priceList];
			boxTotalPrice = boxTotalPrice + price;
		end
		allPrice = allPrice + boxTotalPrice;
	end
	return allPrice;
end 

function TrialMultMysteryBox:onClickAllOpen1()
	local function onConfirm()
		g_dataCenter.trial:openAllPayBox(1);
	end 
	local allPrice = self:CalPrice(1);
	if g_dataCenter.player.crystal < allPrice then 
		FloatTip.Float("钻石不足");
	else 
		HintUI.SetAndShowNew(EHintUiType.two,"开启所有宝箱","确定花费"..tostring(allPrice).."个钻石\n开启所有神秘宝箱1次吗？",nil,{str = "确定",func = onConfirm},{str = "取消"})		
	end
end 

function TrialMultMysteryBox:onClickAllOpen2()
	local function onConfirm()
		g_dataCenter.trial:openAllPayBox(2);
	end 
	local allPrice = self:CalPrice(2);
	if g_dataCenter.player.crystal < allPrice then 
		FloatTip.Float("钻石不足");
	else 
		HintUI.SetAndShowNew(EHintUiType.two,"开启所有宝箱","确定花费"..tostring(allPrice).."个钻石\n开启所有神秘宝箱2次吗？",nil,{str = "确定",func = onConfirm},{str = "取消"})		
	end
end 

function TrialMultMysteryBox:onClickAllOpen3()
	local function onConfirm()
		g_dataCenter.trial:openAllPayBox(5);
	end 
	local allPrice = self:CalPrice(5);
	if g_dataCenter.player.crystal < allPrice then 
		FloatTip.Float("钻石不足");
	else 
		HintUI.SetAndShowNew(EHintUiType.two,"开启所有宝箱","确定花费"..tostring(allPrice).."个钻石\n开启所有神秘宝箱5次吗？",nil,{str = "确定",func = onConfirm},{str = "取消"})		
	end
end 

function TrialMultMysteryBox:onClickAllOpen4()
	local function onConfirm()
		g_dataCenter.trial:openAllPayBox(10);
	end 
	local allPrice = self:CalPrice(10);
	if g_dataCenter.player.crystal < allPrice then 
		FloatTip.Float("钻石不足");
	else 
		HintUI.SetAndShowNew(EHintUiType.two,"开启所有宝箱","确定花费"..tostring(allPrice).."个钻石\n开启所有神秘宝箱10次吗？",nil,{str = "确定",func = onConfirm},{str = "取消"})		
	end
end 

function TrialMultMysteryBox:onClickNext()
	self:Hide();
	self:DestroyUi();
	if g_dataCenter.trial.buffInfo ~= nil and #g_dataCenter.trial.buffInfo > 0 then 
		TrialBuyBuff.PopPanel(g_dataCenter.trial.buffInfo,true);
	end
end 

function TrialMultMysteryBox:onAllBuyRst()
	self.boxInfo = g_dataCenter.trial.payBoxInfo;
	self:UpdateUi();
end 

function TrialMultMysteryBox:Init(data)
	--app.log("TrialMultMysteryBox:Init");
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4702_challenge.assetbundle";
	UiBaseClass.Init(self, data);
end

function TrialMultMysteryBox.Destroy()
	if TrialMultMysteryBox.instance ~= nil then 
		TrialMultMysteryBox.instance:Hide();
		TrialMultMysteryBox.instance:DestroyUi();
	end
end 

--析构函数
function TrialMultMysteryBox:DestroyUi()
	--app.log("TrialMultMysteryBox:DestroyUi");
	if self.boxItemList ~= nil then 
		for k,v in pairs(self.boxItemList) do 
			v.bgBtn:reset_on_click();
		end 
	end 
	self.boxItemList = nil;
	if self.vs ~= nil then 
		self.vs = nil;
	end 
	TrialMultMysteryBox.instance = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

function TrialMultMysteryBox.ShowInstance()
	if TrialMultMysteryBox.instance then 
		TrialMultMysteryBox.instance:Show();
	end
end 

function TrialMultMysteryBox.HideInstance()
	if TrialMultMysteryBox.instance then 
		TrialMultMysteryBox.instance:Hide();
	end
end 
--显示ui
function TrialMultMysteryBox:Show()
	--app.log("TrialMultMysteryBox:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function TrialMultMysteryBox:Hide()
	--app.log("TrialMultMysteryBox:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function TrialMultMysteryBox:MsgRegist()
	--app.log("TrialMultMysteryBox:MsgRegist");
	PublicFunc.msg_regist("trial.allBuyRst",self.bindfunc['onAllBuyRst']);
	PublicFunc.msg_regist("trial.serverOpenPayBox",self.bindfunc['onAllBuyRst']);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function TrialMultMysteryBox:MsgUnRegist()
	--app.log("TrialMultMysteryBox:MsgUnRegist");
	PublicFunc.msg_unregist("trial.allBuyRst",self.bindfunc['onAllBuyRst']);
	PublicFunc.msg_unregist("trial.serverOpenPayBox",self.bindfunc['onAllBuyRst']);
    UiBaseClass.MsgUnRegist(self);
end