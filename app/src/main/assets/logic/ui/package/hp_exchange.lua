HpExchange = Class('HpExchange',UiBaseClass)

local _lab_txt = {
    [1] = "前%d次兑换[fed440]方糖双倍[-]",
	[2] = "使用少量钻石兑换大量方糖!",
}

function HpExchange.popPanel()
	-- HpExchange.instance = HpExchange:new();
	uiManager:PushUi(EUI.HpExchange);
end 

--重新开始
function HpExchange:Restart(data)
    ----app.log("HpExchange:Restart");
    UiBaseClass.Restart(self, data);
end

function HpExchange:InitData(data)
    ----app.log("HpExchange:InitData");
    UiBaseClass.InitData(self, data);
end

function HpExchange:RegistFunc()
	----app.log("HpExchange:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onCloseClick'] = Utility.bind_callback(self, self.onCloseClick);
	self.bindfunc['onExchangeClick'] = Utility.bind_callback(self, self.onExchangeClick);
	self.bindfunc['UpdateUi'] = Utility.bind_callback(self, self.UpdateUi);
end

function HpExchange:InitUI(asset_obj)
	--app.log("HpExchange:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('HpExchange');
	self.vs = {};
	self.vs.btnClose = ngui.find_button(self.ui,"btn_cha");
	self.vs.title = ngui.find_label(self.ui,"lab_title");
	self.vs.bgTexture = ngui.find_texture(self.ui,"centre_other/animation/texture");
	--self.vs.spLabel = ngui.find_sprite(self.ui,"centre_other/animation/texture/sp_art_font");

	self.vs.vipLevel = ngui.find_label(self.ui, "centre_other/animation/texture/sp_v/lab_v")
	self.vs.vipLevel_star = ngui.find_label(self.ui, "centre_other/animation/texture/sp_v/lab_v2")
	self.vs.bgLab1 = ngui.find_label(self.ui,"centre_other/animation/texture/txt_haogan");
	self.vs.bgLab2 = ngui.find_label(self.ui,"centre_other/animation/texture/lab2");
	self.vs.labNumPay = ngui.find_label(self.ui,"centre_other/animation/cont/sp_bk1/lab");
	self.vs.labNumGet = ngui.find_label(self.ui,"centre_other/animation/cont/sp_bk2/lab");
	-- self.vs.labDesc = ngui.find_label(self.ui,"centre_other/animation/cont/lab_name");
	self.vs.labTimes = ngui.find_label(self.ui,"centre_other/animation/cont/lab");
	self.vs.btnExchange = ngui.find_button(self.ui,"centre_other/animation/btn");
	self.vs.btnExchangeBg = ngui.find_sprite(self.ui,"centre_other/animation/btn/animation/sprite_background");
	self.vs.btnExchangeLab = ngui.find_label(self.ui,"centre_other/animation/btn/animation/lab");
	self.btnExchangeLabr,self.btnExchangeLabg,self.btnExchangeLabb,self.btnExchangeLaba = self.vs.btnExchangeLab:get_color();
	self.vs.icon = ngui.find_sprite(self.ui,"centre_other/animation/cont/sp_bk2/sp");
	self.vs.btnClose:set_on_click(self.bindfunc['onCloseClick']);
	self.vs.btnExchange:set_on_click(self.bindfunc['onExchangeClick']);
	self.vs.btnExchange:set_enable_tween_color(false);
	self.vs.double_ui = self.ui:get_child_by_name("centre_other/animation/sp_di2");
    self.vs.double_ui_lab = ngui.find_label(self.ui, "centre_other/animation/sp_di2/lab");
    self.vs.double_ui:set_active(false);

    local objDownPane = self.ui:get_child_by_name("centre_other/animation/sp_bk");
    objDownPane:set_active(false)

	self:UpdateUi();
end

function HpExchange:UpdateUi()
	if self.curAp ~= nil then 
		desAp = g_dataCenter.player.ap - self.curAp;
		FloatTip.Float("兑换获得方糖："..tostring(desAp));
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.ShopMoney)
	end 
	self.curAp = g_dataCenter.player.ap;
	local curTimes = g_dataCenter.player:GetFlagHelper():GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_apBuyTimes) or 0;
	self.curTimes = curTimes;
	local maxTimes = 0;
	local vip_data = g_dataCenter.player:GetVipData();
	if vip_data then
		maxTimes = vip_data.ex_can_buy_ap_times;
	end
	self.maxTimes = maxTimes;
	-- local cf = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip+1);
	local cf = g_dataCenter.player:GetNextVipData();
	if cf ~= nil then 
		local nextVipMaxTimes = cf.ex_can_buy_ap_times;
		-- self.vs.bgLab1:set_text("[FCD901FF]好感度"..tostring(cf.level).."[-]可购买[FCD901FF]"..tostring(nextVipMaxTimes).."次[-]");
		self.vs.vipLevel:set_text(tostring(cf.level));
		self.vs.vipLevel_star:set_text('-'..tostring(cf.level_star));
		self.vs.bgLab1:set_text("[-]可购买[FCD901FF]"..tostring(nextVipMaxTimes).."次[-]");
	else
		-- self.vs.bgLab1:set_text("[FCD901FF]好感度"..tostring(vip_data.level).."[-]可购买[FCD901FF]"..tostring(maxTimes).."次[-]");
		self.vs.vipLevel:set_text(tostring(vip_data.level));
		self.vs.vipLevel_star:set_text('-'..tostring(vip_data.level_star));
		self.vs.bgLab1:set_text("[-]可购买[FCD901FF]"..tostring(maxTimes).."次[-]");
	end 
	local cfList = ConfigManager._GetConfigTable(EConfigIndex.t_buy_cost);
	self.cost = 0;
	self.get = 0;
	for k,v in pairs(cfList) do 
		if v.times == curTimes then 
			self.cost = v.cost;
			self.get = v.get_ap;
		end
	end
	self.vs.icon:set_sprite_name("dh_tili");
	self.vs.labNumPay:set_text(tostring(self.cost));
	self.vs.labNumGet:set_text(tostring(self.get));
	if maxTimes - curTimes > 0 then 
		self.vs.labTimes:set_text("今日兑换次数：[FCC205FF]"..tostring(curTimes).."/"..tostring(maxTimes));
		self.vs.btnExchangeBg:set_color(1,1,1,1);
		self.vs.btnExchangeLab:set_color(self.btnExchangeLabr,self.btnExchangeLabg,self.btnExchangeLabb,self.btnExchangeLaba);
	else 
		self.vs.labTimes:set_text("今日兑换次数：[FCC205FF]"..tostring(curTimes).."/"..tostring(maxTimes));
		self.vs.btnExchangeBg:set_color(0,0,0,1);
		self.vs.btnExchangeLab:set_color(1,1,1,1);
	end
	-- self.vs.labDesc:set_text(_lab_txt[2]);
	--self.vs.spLabel:set_sprite_name("tldh_tili");
	self.vs.bgLab2:set_text("方糖！");
	self.vs.bgTexture:set_texture("assetbundles/prefabs/ui/image/backgroud/jin_bi_dui_huan/tldh_xuanchuantu.assetbundle");
	self.vs.title:set_text("方糖");

	local radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.buy_ap, 4);
    local limit = g_dataCenter.activityReward:GetDoubleLimitNum(ENUM.Double.buy_ap);
    app.log(radio_num .. "--" .. limit .. "--" .. curTimes);
    if radio_num > 1 and tonumber(curTimes) < limit then
        self.vs.double_ui:set_active(true);
        self.vs.double_ui_lab:set_text(string.format(_lab_txt[1], (limit - curTimes)));
    else
    	self.vs.double_ui:set_active(false);
    end
end 

function HpExchange:onExchangeClick()
	if self.curTimes < self.maxTimes then 
		local crystal = g_dataCenter.player.crystal;
		if crystal >= self.cost then 
			local curAp = g_dataCenter.player.ap;
			local radio_num = 1;
    		local limit = g_dataCenter.activityReward:GetDoubleLimitNum(ENUM.Double.buy_ap);
			if self.curTimes < limit then
				radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.buy_ap, 4);
			end
			local bc = ConfigManager.Get(EConfigIndex.t_buy_cost, self.curTimes);
			if PublicFunc.CheckApLimit(curAp + bc.get_ap * radio_num) then
                return
				--HintUI.SetAndShow(EHintUiType.one, "方糖将会超过上限，不能购买方糖。", {str = gs_misc['ok']});
			else
				player.cg_ap_buy();
			end
		else 
			--FloatTip.Float("钻石不足");
			HintUI.SetAndShowNew(EHintUiType.two,
			"充值",
			"您的剩余钻石数量不足\n是否前往充值？",
			nil,
			{str = "确定",func = function()
				self:Hide();
				self:DestroyUi();
				uiManager:PushUi(EUI.StoreUI);
			end },
			{str = "取消",func = function()
				self:Hide();
				self:DestroyUi();
			end});
		end
	else 
		if self.cost == 0 and self.get == 0 then 
			FloatTip.Float("今日兑换次数耗尽，请明日再进行兑换");
		else 
			FloatTip.Float("今日兑换次数耗尽，请明日再进行兑换");
		end 
	end
end 

function HpExchange:onCloseClick()
	-- self:Hide();
	-- self:DestroyUi();
	app.log("--------------")
	uiManager:PopUi();
end 

function HpExchange:Init(data)
	--app.log("HpExchange:Init");
    self.pathRes = "assetbundles/prefabs/ui/package/ui_3701_gold_exchange.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function HpExchange:DestroyUi()
	--app.log("HpExchange:DestroyUi");
	if self.vs ~= nil then 
		if self.vs.bgTexture then
			self.vs.bgTexture:Destroy()
		end
		self.vs = nil;
	end 
	self.curAp = nil;
	HpExchange.instance = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function HpExchange:Show()
	--app.log("HpExchange:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function HpExchange:Hide()
	--app.log("HpExchange:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function HpExchange:MsgRegist()
	--app.log("HpExchange:MsgRegist");
	PublicFunc.msg_regist("player.gc_ap_buy",self.bindfunc['UpdateUi']);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function HpExchange:MsgUnRegist()
	--app.log("HpExchange:MsgUnRegist");
	PublicFunc.msg_unregist("player.gc_ap_buy",self.bindfunc['UpdateUi']);
    UiBaseClass.MsgUnRegist(self);
end