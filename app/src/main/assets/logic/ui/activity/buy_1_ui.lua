--region buy_1_ui.lua
--Author : dwj
--Date   : 2016/8/25

local _item_data = {
	[1] = {item_id=1, item_num=100};
	[2] = {item_id=2, item_num=2};
	[3] = {item_id=3, item_num=3333};
	[4] = {item_id=1, item_num=444};
}

UiBuy1 = Class('UiBuy1', UiBaseClass)

function UiBuy1:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/award/ui_1120_award.assetbundle";
	UiBaseClass.Init(self, data);
end

--重新加载
function UiBuy1:Restart(data)
	UiBaseClass.Restart(self, data);
end

--初始化数据
function UiBuy1:InitData()
	UiBaseClass.InitData(self, data);

	self.m_item_ui = {};
	self.m_card_item = {};

	self.start_time = 0;
	self.end_time = 0;
	self.state = 0;
	self.vecAward = {};
	self.storeData = {};

	self.updateTimer = 0;
end

function UiBuy1:DestroyUi()
	for k,v in pairs(self.m_card_item) do
		if v then
			v:DestroyUi();
			v = nil;
		end
	end
	self.m_card_item = {};

	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end

	UiBaseClass.DestroyUi(self);
end

--注册方法
function UiBuy1:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
	self.bindfunc["on_get"] = Utility.bind_callback(self, self.on_get);
	self.bindfunc["pay_back"] = Utility.bind_callback(self, self.pay_back);

	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);

	self.bindfunc["buy_1_state"] = Utility.bind_callback(self, self.buy_1_state);
	self.bindfunc["gc_get_buy_1_back"] = Utility.bind_callback(self, self.gc_get_buy_1_back);
end

--取消注册
function UiBuy1:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function UiBuy1:MsgRegist()
	UiBaseClass.MsgRegist(self);

	PublicFunc.msg_regist("msg_activity.gc_buy_1_state", self.bindfunc["buy_1_state"]);
	PublicFunc.msg_regist("msg_activity.gc_get_buy_1_back", self.bindfunc["gc_get_buy_1_back"]);
	
end

--注销消息分发回调函数
function UiBuy1:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);

	PublicFunc.msg_unregist("msg_activity.gc_buy_1_state", self.bindfunc["buy_1_state"]);
	PublicFunc.msg_unregist("msg_activity.gc_get_buy_1_back", self.bindfunc["gc_get_buy_1_back"]);
	
end

--初始化UI
function UiBuy1:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_buy_1")

	self.btn_close = ngui.find_button(self.ui, "center_other/animation/btn_cha");
	self.btn_close:set_on_click(self.bindfunc["on_close"]);

	self.btn_get = ngui.find_button(self.ui, "ui_buy_1/center_other/animation/btn_get");
	self.lab1 = ngui.find_label(self.ui, "ui_buy_1/center_other/animation/btn_get/animation/lab1");
	
	local lab2 = ngui.find_label(self.ui, "ui_buy_1/center_other/animation/btn_get/animation/lab2");
	lab2:set_active(false);

	self.lab_time = ngui.find_label(self.ui, "center_other/animation/texture_bk/lab_time");

	for i=1,4 do
		self.m_item_ui[i] = self.ui:get_child_by_name("ui_buy_1/center_other/animation/cont/new_small_card_item" .. i);
	end

	msg_activity.cg_get_buy_1_state();
end

function UiBuy1:UpdateUIForBackData(  )
	
	self.btn_get:reset_on_click();
	self.btn_get:set_on_click(self.bindfunc["on_get"]);
	if self.state == 0 then
		self.btn_get:set_enable(true);
		self.btn_get:set_event_value("", 0);
		self.lab1:set_text("购买");
	elseif self.state == 1 then
		self.btn_get:set_enable(false);
		self.lab1:set_text("购买");
	elseif self.state == 2 then
		self.btn_get:set_enable(true);
		self.btn_get:set_event_value("", 1);
		self.lab1:set_text("领取");
	elseif self.state == 3 then
		self.btn_get:set_enable(false);
		self.lab1:set_text("已领取");
	end

	local carditem = nil;
	local num = #self.vecAward;
	local c_item_data = nil;
	for i=1,4 do
		if i <= num then
			self.m_item_ui[i]:set_active(true);
			c_item_data = self.vecAward[i];
			carditem = CardProp:new({number = c_item_data.id, count = c_item_data.count});
			if self.m_card_item[i] == nil then
				self.m_card_item[i] = UiSmallItem:new({parent = self.m_item_ui[i], cardInfo = carditem});
			else
				self.m_card_item[i]:SetData(carditem);
			end
			self.m_card_item[i]:SetCount(c_item_data.count);
			
		else
			self.m_item_ui[i]:set_active(false);
		end
		
	end
end

function UiBuy1:set_deff_time( )
	local diffSec = self.end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
	self.lab_time:set_text("活动倒计时 " .. day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
	if diffSec <= 0 then
	    g_dataCenter.activityReward:SetBuy1State(0);
    	PublicFunc.msg_dispatch(msg_activity.gc_check_is_buy_1);
	end
end

function UiBuy1:on_close( )
	uiManager:RemoveUi(EUI.UiBuy1);
end

function UiBuy1:on_get( t )
	-- self.btn_get:set_enable(false);
	if t.float_value == 0 then
		app.log("申请PAY");
	-- 	UserCenter.pay(
	-- 		_local.click_data.index,
	-- 		_local.click_data.id,
	-- 		_local.click_data.num,
	-- 		_local.click_data.price,
	-- 		_local.click_data.name,
	-- 		_local.click_data.discount,
	-- 		self.bindfunc["pay_back"]);
		app.log("self.storeData:" .. table.tostring(self.storeData))
		UserCenter.pay(
			self.storeData.index,
			self.storeData.id,
			self.storeData.num,
			self.storeData.price,
			self.storeData.name or "yiyuangou",
			self.storeData.discount,
			self.bindfunc["pay_back"]
			);
	elseif t.float_value == 1 then
		msg_activity.cg_get_award();
	end
end

function UiBuy1:pay_back(state)
	g_ScreenLockUI.Hide();
	GLoading.Hide(GLoading.EType.msg);

	if state == "0" then
		HintUI.SetAndShow(EHintUiType.zero, "充值成功");
	elseif state == "-1" then
        HintUI.SetAndShow(EHintUiType.zero, "充值失败");
	end
end


function UiBuy1:buy_1_state( start_time, end_time, state, vecAward, storeData )
	app.log("--------------")
	self.start_time = start_time;
	self.end_time = end_time;
	self.state = state;
	self.vecAward = vecAward;
	self.storeData = storeData;
	self:UpdateUIForBackData();

	self:set_deff_time();
	if self.updateTimer == 0 then
        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
    end
end

function UiBuy1:gc_get_buy_1_back( vecAward )
	CommonAward.Start(vecAward);

	self.btn_get:set_enable(false);
	self.lab1:set_text("已领取");

	uiManager:RemoveUi(EUI.UiBuy1);
	g_dataCenter.activityReward:SetBuy1State(0);
    PublicFunc.msg_dispatch(msg_activity.gc_check_is_buy_1);

end