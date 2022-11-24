TrialSingleMysteryBox = Class('TrialSingleMysteryBox',UiBaseClass)

function TrialSingleMysteryBox.popUp(levelid)
	TrialSingleMysteryBox.instance = TrialSingleMysteryBox:new(levelid);
end 

--重新开始
function TrialSingleMysteryBox:Restart(levelid)
    ----app.log("TrialSingleMysteryBox:Restart");
    UiBaseClass.Restart(self, levelid);
	self.levelid = levelid;
end

function TrialSingleMysteryBox:InitData(levelid)
    ----app.log("TrialSingleMysteryBox:InitData");
    UiBaseClass.InitData(self, levelid);
	self.levelid = levelid;
end

function TrialSingleMysteryBox:RegistFunc()
	----app.log("TrialSingleMysteryBox:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onCloseClick'] = Utility.bind_callback(self, self.onCloseClick);
	self.bindfunc['onClickOpen'] = Utility.bind_callback(self, self.onClickOpen);
	self.bindfunc['onServerOpenPayBox'] = Utility.bind_callback(self, self.onServerOpenPayBox);
end

function TrialSingleMysteryBox:InitUI(asset_obj)
	--app.log("TrialSingleMysteryBox:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TrialSingleMysteryBox');
	self.vs = {};
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_754_458/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['onCloseClick']);
	self.vs.labOpenNum = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_down/lab_num2");
	self.vs.labPrice = ngui.find_label(self.ui,"centre_other/animation/lab_num");
	self.vs.btnOpen = ngui.find_button(self.ui,"centre_other/animation/btn_you_ke");
	self.vs.spline = ngui.find_sprite(self.ui,"centre_other/animation/cont1/sp_bar/sp_line");
	self.vs.labZhekou = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_bar/lab_zhekou");
	self.vs.boxSp1 = ngui.find_sprite(self.ui,"centre_other/animation/cont1/box1/sp_box1");
	self.vs.boxSp2 = ngui.find_sprite(self.ui,"centre_other/animation/cont1/box1/sp_box2");
	self.vs.boxSp3 = ngui.find_sprite(self.ui,"centre_other/animation/cont1/box1/sp_box3");
	self.vs.boxSp4 = ngui.find_sprite(self.ui,"centre_other/animation/cont1/box1/sp_box4");
	self.vs.boxSp5 = ngui.find_sprite(self.ui,"centre_other/animation/cont1/box1/sp_box5");
	self.vs.boxSp6 = ngui.find_sprite(self.ui,"centre_other/animation/cont1/box1/sp_box6");
	self.vs.boxSp7 = ngui.find_sprite(self.ui,"centre_other/animation/cont1/box1/sp_box7");
	self.vs.spline:set_active(false);
	self.vs.labZhekou:set_active(false);
	self.vs.labZhekouTimes = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_down/lab_cishu");
	self.vs.labZhekouTimes:set_active(false);
	self.vs.spZhekou = ngui.find_sprite(self.ui,"centre_other/animation/cont1/sp_zhekou");
	self.vs.spZhekou:set_active(false);
	--self.vs.btnCancel = ngui.find_button(self.ui,"centre_other/animation/btn_lan");
	--self.vs.btnCancel:set_on_click(self.bindfunc['onCloseClick']);
	self.vs.btnOpen:set_on_click(self.bindfunc['onClickOpen']);
	self.buy_times = 0;
	self:UpdateUi();
end

function TrialSingleMysteryBox:UpdateUi()
	self.levelData = g_dataCenter.trial.allLevelConfig[self.levelid];
	for i = 1,7 do 
		if i ~= g_dataCenter.trial.allLevelConfig[self.levelid].page then 
			self.vs["boxSp"..tostring(i)]:set_active(false);
		else
			self.vs["boxSp"..tostring(i)]:set_active(true);
		end
	end 
	if self.levelid == #g_dataCenter.trial.allLevelConfig then 
		self.vs.boxSp7:set_active(true);
	end
	self.maxNum = self.levelData.pay_treasure_box_num;
	self.payPrice = self.levelData.pay_treasure_box_price;
	self.vs.labOpenNum:set_text(tostring(self.buy_times).."/"..tostring(self.maxNum));
	self.price = self.payPrice[self.buy_times+1] or self.payPrice[#self.payPrice];
	self.vs.labPrice:set_text(tostring(self.price));
end 

function TrialSingleMysteryBox:onServerOpenPayBox()
	GLoading.Hide(GLoading.EType.ui, self.loadingId);
	local payBoxInfo = g_dataCenter.trial.payBoxInfo;
	if payBoxInfo.buy_times == nil then 
		for k,v in pairs(payBoxInfo) do 
			if v.levelid == self.levelid then 
				----app.log("付费宝箱购买次数:"..tostring(v.buy_times));
				self.buy_times = v.buy_times;
				self:UpdateUi();
			end 
		end 
	else 
		----app.log("付费宝箱购买次数:"..tostring(g_dataCenter.trial.payBoxInfo.buy_times));
		self.buy_times = g_dataCenter.trial.payBoxInfo.buy_times;
		self:UpdateUi();
	end 
end 

function TrialSingleMysteryBox:onCloseClick()
	self:Hide();
	self:DestroyUi();
end 

function TrialSingleMysteryBox:onClickOpen()
	if self.buy_times >= self.maxNum then 
		FloatTip.Float("购买次数已用完");
	else 
		if self.price ~= nil then 
			if self.price > g_dataCenter.player.crystal then 
				FloatTip.Float("钻石不足");
			else 
				self.loadingId = GLoading.Show(GLoading.EType.ui);
				g_dataCenter.trial:openPayBox(self.levelid,1);
			end 
		else 
			FloatTip.Float("配置出错");
		end
	end
end 

function TrialSingleMysteryBox:Init(data)
	--app.log("TrialSingleMysteryBox:Init");
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4703_challenge.assetbundle";
	UiBaseClass.Init(self, data);
end

function TrialSingleMysteryBox.Destroy()
	if TrialSingleMysteryBox.instance ~= nil then 
		TrialSingleMysteryBox.instance:Hide();
		TrialSingleMysteryBox.instance:DestroyUi();
	end
end 

--析构函数
function TrialSingleMysteryBox:DestroyUi()
	--app.log("TrialSingleMysteryBox:DestroyUi");
	TrialSingleMysteryBox.instance = nil;
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

function TrialSingleMysteryBox.ShowInstance()
	if TrialSingleMysteryBox.instance then 
		TrialSingleMysteryBox.instance:Show();
	end
end 

function TrialSingleMysteryBox.HideInstance()
	if TrialSingleMysteryBox.instance then 
		TrialSingleMysteryBox.instance:Hide();
	end
end 
--显示ui
function TrialSingleMysteryBox:Show()
	--app.log("TrialSingleMysteryBox:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function TrialSingleMysteryBox:Hide()
	--app.log("TrialSingleMysteryBox:Hide");
    UiBaseClass.Hide(self);
	
	if TrialScene.instance ~= nil then 
		Tween.continue(TrialScene.instance.modelPlayer);
	end 
end

--注册消息分发回调函数
function TrialSingleMysteryBox:MsgRegist()
	--app.log("TrialSingleMysteryBox:MsgRegist");
	PublicFunc.msg_regist("trial.serverOpenPayBox",self.bindfunc["onServerOpenPayBox"]);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function TrialSingleMysteryBox:MsgUnRegist()
	--app.log("TrialSingleMysteryBox:MsgUnRegist");
	PublicFunc.msg_unregist("trial.serverOpenPayBox",self.bindfunc["onServerOpenPayBox"]);
    UiBaseClass.MsgUnRegist(self);
end