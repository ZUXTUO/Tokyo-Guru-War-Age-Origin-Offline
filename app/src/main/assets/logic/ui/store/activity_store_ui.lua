ActivityStoreUI = Class("ActivityStoreUI", MultiResUiBaseClass);

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = "assetbundles/prefabs/ui/award/ui_1144_award.assetbundle";
    [resType.Back] = 'assetbundles/prefabs/ui/award/ui_1104_award.assetbundle';
}

function ActivityStoreUI:Init(data)
    self.pathRes = resPaths;
    g_dataCenter.store:RequestActive(ENUM.Activity.activityType_limit_buy)
    msg_activity.cg_get_time_limit_gift_bag_state()
    MultiResUiBaseClass.Init(self, data);
end

function ActivityStoreUI:InitData(data)
    MultiResUiBaseClass.InitData(self, data);
end

function ActivityStoreUI:Restart(data)
	self.goodsList = {};
    self.tabList = {};
    self.curTab = 1;
    self.curIndex = 1;
    if not MultiResUiBaseClass.Restart(self, data) then
        return;
    end
end

function ActivityStoreUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
	self.bindfunc["on_init_goods"] = Utility.bind_callback(self, self.on_init_goods);
	self.bindfunc["onStartPos"] = Utility.bind_callback(self, self.onStartPos);
	self.bindfunc["onEndPos"] = Utility.bind_callback(self, self.onEndPos);
	self.bindfunc["onStopMove"] = Utility.bind_callback(self, self.onStopMove);
	self.bindfunc["onBtnRight"] = Utility.bind_callback(self, self.onBtnRight);
	self.bindfunc["onBtnLeft"] = Utility.bind_callback(self, self.onBtnLeft);
	self.bindfunc["onChangeTab"] = Utility.bind_callback(self, self.onChangeTab);
	self.bindfunc["onBuyGoods"] = Utility.bind_callback(self, self.onBuyGoods);
	self.bindfunc["gc_get_time_limit_gift_bag_config"] = Utility.bind_callback(self, self.gc_get_time_limit_gift_bag_config);
	self.bindfunc["gc_get_time_limit_gift_bag_state"] = Utility.bind_callback(self, self.gc_get_time_limit_gift_bag_state);
	self.bindfunc["gc_buy_time_limit_gift_bag_item"] = Utility.bind_callback(self, self.gc_buy_time_limit_gift_bag_item);
	self.bindfunc["gc_time_limit_gift_bag_rmb_buy_suc"] = Utility.bind_callback(self, self.gc_time_limit_gift_bag_rmb_buy_suc);
	self.bindfunc["BuyGoods"] = Utility.bind_callback(self, self.BuyGoods);
end

function ActivityStoreUI:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_get_time_limit_gift_bag_config,self.bindfunc["gc_get_time_limit_gift_bag_config"]);
    PublicFunc.msg_regist(msg_activity.gc_get_time_limit_gift_bag_state,self.bindfunc["gc_get_time_limit_gift_bag_state"]);
    PublicFunc.msg_regist(msg_activity.gc_buy_time_limit_gift_bag_item,self.bindfunc["gc_buy_time_limit_gift_bag_item"]);
    PublicFunc.msg_regist(msg_activity.gc_time_limit_gift_bag_rmb_buy_suc,self.bindfunc["gc_time_limit_gift_bag_rmb_buy_suc"]);
end

function ActivityStoreUI:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_get_time_limit_gift_bag_config,self.bindfunc["gc_get_time_limit_gift_bag_config"]);
    PublicFunc.msg_unregist(msg_activity.gc_get_time_limit_gift_bag_state,self.bindfunc["gc_get_time_limit_gift_bag_state"]);
    PublicFunc.msg_unregist(msg_activity.gc_buy_time_limit_gift_bag_item,self.bindfunc["gc_buy_time_limit_gift_bag_item"]);
    PublicFunc.msg_unregist(msg_activity.gc_time_limit_gift_bag_rmb_buy_suc,self.bindfunc["gc_time_limit_gift_bag_rmb_buy_suc"]);
end

function ActivityStoreUI:InitedAllUI()
    MultiResUiBaseClass.InitedAllUI(self);

    self.ui = self.uis[resPaths[resType.Back]]
    local frontParentNode = self.ui:get_child_by_name("center_other/animation")
    local frontui = self.uis[resPaths[resType.Front]]
    frontui:set_parent(frontParentNode)
    frontui:set_name("ui_1144_award");

    self.warpTab = ngui.find_wrap_content(self.ui,"center_other/animation/sco_view/panel_list/wrap_content");
    self.warpTab:set_on_initialize_item(self.bindfunc["on_init_item"]);
    self.scoViewTab = ngui.find_scroll_view(self.ui,"center_other/animation/sco_view/panel_list");

    self.btnArrowR = ngui.find_button(self.ui,"center_other/animation/ui_1144_award/panel_btn_arrows/btn_right");
    self.btnArrowR:set_on_click(self.bindfunc["onBtnRight"],"MyButton.NoneAudio");
    self.btnArrowL = ngui.find_button(self.ui,"center_other/animation/ui_1144_award/panel_btn_arrows/btn_left");
    self.btnArrowL:set_on_click(self.bindfunc["onBtnLeft"],"MyButton.NoneAudio");

    self.warpItem = ngui.find_enchance_scroll_view(self.ui,"center_other/animation/ui_1144_award/panel_scoll_view");
    self.warpItem:set_on_initialize_item(self.bindfunc["on_init_goods"]);
    self.warpItem:set_on_outstart(self.bindfunc["onStartPos"]);
    self.warpItem:set_on_outend(self.bindfunc["onEndPos"]);
    self.warpItem:set_on_stop_move(self.bindfunc["onStopMove"]);

    self:UpdateUi();
end

function ActivityStoreUI:UpdateUi()
    if not MultiResUiBaseClass.UpdateUi(self) then
        return;
    end
    self.warpTab:set_min_index(1-g_dataCenter.store:GetPageInfoNum());
    self.warpTab:set_max_index(0);
    self.warpTab:reset();
    self.scoViewTab:reset_position();
    self:onChangeTab({float_value=self.curTab})
end

function ActivityStoreUI:DestroyUi()
    MultiResUiBaseClass.DestroyUi(self);
    self.curTab = 1;
    if self.goodslist then
	    for k,cont in pairs(self.goodsList) do
	    	cont.objCard:DestroyUi();
	    end
	    self.goodsList = nil;
	end
end

function ActivityStoreUI:onStartPos(isStart)
    self.btnArrowL:set_active(not isStart);
end

function ActivityStoreUI:onEndPos(isEnd)
    self.btnArrowR:set_active(not isEnd);
end

function ActivityStoreUI:onStopMove(index)
	self.curIndex = index;
end

function ActivityStoreUI:onBtnRight()
	self.warpItem:tween_to_index(self.curIndex+1);
end

function ActivityStoreUI:onBtnLeft()
	self.warpItem:tween_to_index(self.curIndex-1);
end

function ActivityStoreUI:Update()
	for k,cont in pairs(self.goodsList) do
		self:update_init_goods(cont, cont.index);
	end
end
------------------道具列表-------------------------
function ActivityStoreUI:on_init_goods(obj, index)
    local b = obj:get_instance_id();
    if Utility.isEmpty(self.goodsList[b]) then
        self.goodsList[b] = self:init_goods(obj)
    end
    self.goodsList[b].index = index;
    self:update_init_goods(self.goodsList[b], index);
end

function ActivityStoreUI:init_goods(obj)
    local cont = {}
    cont.root = obj;
    cont.labName = ngui.find_label(obj,"sp_di/lab_title");
    cont.labTime = ngui.find_label(obj,"sp_di/sp_xiangou/lab_time");
    cont.labNum = ngui.find_label(obj,"sp_di/lab_xiangou/lab_num");
    cont.txtNum = ngui.find_label(obj,"sp_di/lab_xiangou");
    cont.spOver = obj:get_child_by_name("sp_di/sp_yishouqing");
    cont.objVip = obj:get_child_by_name("sp_bk");
    cont.labVip1 = ngui.find_label(obj,"sp_bk/sp_v/lab_v");
    cont.labVip2 = ngui.find_label(obj,"sp_bk/sp_v/lab_v2");
    local o = obj:get_child_by_name("sp_di/new_small_card_item");
    cont.objCard = UiSmallItem:new({parent=o, is_enable_goods_tip=true});

    local o = obj:get_child_by_name("sp_di/cont1");
    cont.cont1root = o
    cont.cont1 = {};
    cont.cont1.labZhekou = ngui.find_label(o,"sp_zhekou/lab");
    cont.cont1.objZhekou = o:get_child_by_name("sp_zhekou");
    cont.cont1.labCost = ngui.find_label(o,"sp_gem/lab");
    cont.cont1.spCost = ngui.find_sprite(o,"sp_gem");
    cont.cont1.objRMB = o:get_child_by_name("txt_renmingbi");
    cont.cont1.btnCost = ngui.find_button(o,"btn1");
    cont.cont1.btnCost:set_on_click(self.bindfunc["onBuyGoods"]);

    local o = obj:get_child_by_name("sp_di/cont2");
    cont.cont2root = o
    cont.cont2 = {};
    cont.cont2.labZhekou = ngui.find_label(o,"sp_zhekou1/lab");
    cont.cont2.objZhekou = o:get_child_by_name("sp_zhekou1");
    cont.cont2.labCost = ngui.find_label(o,"sp_gem1/lab");
    cont.cont2.spCost = ngui.find_sprite(o,"sp_gem1");
    cont.cont2.objRMB = o:get_child_by_name("txt_renmingbi1");
    cont.cont2.btnCost = ngui.find_button(o,"btn1");
    cont.cont2.btnCost:set_on_click(self.bindfunc["onBuyGoods"]);

    cont.cont3 = {};
    cont.cont3.labZhekou = ngui.find_label(o,"sp_zhekou2/lab");
    cont.cont3.objZhekou = o:get_child_by_name("sp_zhekou2");
    cont.cont3.labCost = ngui.find_label(o,"sp_gem2/lab");
    cont.cont3.spCost = ngui.find_sprite(o,"sp_gem2");
    cont.cont3.objRMB = o:get_child_by_name("txt_renmingbi2");
    cont.cont3.btnCost = ngui.find_button(o,"btn2");
    cont.cont3.btnCost:set_on_click(self.bindfunc["onBuyGoods"]);
    return cont;
end

function ActivityStoreUI:update_init_goods(cont, index)
	local cfgList = g_dataCenter.store:GetGoodsList(self.curTabPagID);
	if #cfgList < index then
		cont.root:set_active(false);
		return;
	end
	cont.root:set_active(true);
	local goodsCfg = cfgList[index];
	local vipLv = goodsCfg.limitVipLevel;
	if vipLv == 0 then
		cont.objVip:set_active(false);
	else
		cont.objVip:set_active(true);
		local cfg = g_dataCenter.player:GetVipDataConfigByLevel(vipLv);
		cont.labVip1:set_text(tostring(cfg.level));
		cont.labVip2:set_text("-"..tostring(cfg.level_star));
	end
	local itemCfg = CardProp:new({number = goodsCfg.itemID, count = goodsCfg.itemNum});
	cont.labName:set_text(itemCfg.name);
	local time = Utility.timediff(system.time(),goodsCfg.endTime);
	local strTime = "限购";
	if time.year > 0 then
		strTime = strTime..(time.year+1).."年";
	elseif time.month > 0 then
		strTime = strTime..(time.month+1).."月";
	elseif time.day > 0 then
		strTime = strTime..(time.day+1).."天";
	elseif time.hour > 0 then
		strTime = strTime..(time.hour+1).."小时";
	elseif time.min > 0 then
		strTime = strTime..(time.min+1).."分钟";
	elseif time.sec > 0 then
		strTime = strTime..(time.sec).."秒";
	end
	cont.labTime:set_text(strTime);
	cont.objCard:SetData(itemCfg);
	cont.objCard:SetCount(goodsCfg.itemNum);
	if goodsCfg.dayLimit == 0 then
		cont.txtNum:set_text("限购");
	else
		cont.txtNum:set_text("每日限购");
	end
	if goodsCfg.limitNum == -1 then
		cont.txtNum:set_active(false);
	else
		cont.txtNum:set_active(true);
	end
	cont.labNum:set_text(goodsCfg.buyNum.."/"..goodsCfg.limitNum);
	if goodsCfg.limitNum <= goodsCfg.buyNum and goodsCfg.limitNum ~= -1 then
		cont.spOver:set_active(true);
		cont.cont1root:set_active(false);
		cont.cont2root:set_active(false);
	else
		cont.spOver:set_active(false);
		if #goodsCfg.prices == 1 then
			local priceInfo = goodsCfg.prices[1];
			cont.cont1root:set_active(true);
			cont.cont2root:set_active(false);
			self:_setPriceInfo(cont.cont1,priceInfo);
			cont.cont1.btnCost:set_event_value(""..priceInfo.type,index);
		elseif #goodsCfg.prices == 2 then
			cont.cont1root:set_active(false);
			cont.cont2root:set_active(true);
			local priceInfo = goodsCfg.prices[1];
			self:_setPriceInfo(cont.cont2,priceInfo);
			cont.cont2.btnCost:set_event_value(""..priceInfo.type,index);
			local priceInfo = goodsCfg.prices[2];
			self:_setPriceInfo(cont.cont3,priceInfo);
			cont.cont3.btnCost:set_event_value(""..priceInfo.type,index);
		end
	end
end

function ActivityStoreUI:_setPriceInfo(cont, priceInfo)
	if priceInfo.discount <= 0 then
		cont.objZhekou:set_active(false);
	else
		cont.labZhekou:set_text(priceInfo.discount.."折");
		cont.objZhekou:set_active(true);
	end
	cont.labCost:set_text(tostring(priceInfo.costNum));
	if priceInfo.type == 1 then
		cont.spCost:set_sprite_name("dh_jinbi");
		cont.objRMB:set_active(false);
	elseif priceInfo.type == 2 then
		cont.spCost:set_sprite_name("dh_hongshuijing");
		cont.objRMB:set_active(false);
	elseif priceInfo.type == 3 then
		cont.spCost:set_sprite_name("");
		cont.objRMB:set_active(true);
		local cfg = ConfigManager.Get(EConfigIndex.t_store_data, priceInfo.costNum);
		if cfg then
			cont.labCost:set_text(tostring(cfg.price/100));
		else
			app.log("找不到商品.id:"..tostring(priceInfo.costNum));
		end
	end
end

function ActivityStoreUI:onBuyGoods(t)
	local priceType = tonumber(t.string_value);
	local index = t.float_value;
	local cfgList = g_dataCenter.store:GetGoodsList(self.curTabPagID);
	local cfg = cfgList[index];
	if cfg.limitVipLevel > g_dataCenter.player:GetVip() then
		uiManager:PushUi(EUI.VipHintUI, {vip=cfg.limitVipLevel});
		return;
	end
	local num = cfg.limitNum - cfg.buyNum;
	if num > 10 then
		BatchBuyAction.ShowAction({info=CardProp:new({number = cfg.itemID, count = cfg.itemNum}),
			max_number=num,
			callback=function (info, num)
			self:BuyGoods(index, num, priceType);
			end
		});
	else
		self:BuyGoods(index, 1, priceType);
	end
end

function ActivityStoreUI:BuyGoods(index, num, priceType)
	local cfgList = g_dataCenter.store:GetGoodsList(self.curTabPagID);
	local cfg = cfgList[index];
	if priceType == 3 then
		for k,v in pairs(cfg.prices) do
			if v.type == 3 then
				app.log("刘佳加下人民币支付的接口. id:"..tostring(v.costNum));
				break;
			end
		end
	else
		msg_activity.cg_buy_time_limit_gift_bag_item(cfg.id, num, priceType)
	end
end
------------------道具列表end-------------------------
------------------分页-------------------------
function ActivityStoreUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    if Utility.isEmpty(self.tabList[b]) then
        self.tabList[b] = self:init_item(b, obj)
        self.tabList[b].index = index;
    end
    self:update_item(self.tabList[b], index);
end

function ActivityStoreUI:init_item(b, obj)
    local cont = {}
    cont.b = b;
    cont.btn = ngui.find_button(obj,obj:get_name());
    cont.btn:set_on_click(self.bindfunc["onChangeTab"]);
    cont.labName = ngui.find_label(obj,"lab");
    cont.labName2 = ngui.find_label(obj,"lab1");
    cont.spBk = ngui.find_sprite(obj,"sp");
    cont.objPoint = obj:get_child_by_name("sp_point");
    return cont;
end

function ActivityStoreUI:update_item(cont, index)
	local cfg = g_dataCenter.store:GetPageInfo(index);
	if cfg == nil then
		cont.btn:set_active(false);
		return;
	end
	cont.btn:set_active(true);
	cont.btn:set_event_value(""..cont.b,cfg.tabPageID);
	cont.labName:set_text(tostring(cfg.name));
	cont.labName2:set_text(tostring(cfg.name));
	if index == self.curTab then
		self:_setTabState(cont, true);
	else
		self:_setTabState(cont, false);
	end
end

function ActivityStoreUI:_setTabState(cont, isSelect)
	if nil == cont then return end
	cont.labName:set_active(not isSelect);
	cont.labName2:set_active(isSelect);
	if isSelect then
		cont.spBk:set_sprite_name("hd_yeqian5")
		self.curTab = cont.index;
		self.selectItem = cont;
	else
		cont.spBk:set_sprite_name("hd_yeqian6")
	end
end

function ActivityStoreUI:onChangeTab(t)
	local tabPageID = t.float_value;
	local curB = tonumber(t.string_value);
	local cont = self.tabList[curB];
	if cont ~= nil then
		if self.selectItem then
			self:_setTabState(self.selectItem, false);
		end
		self:_setTabState(cont, true);
	end
	self.curTabPagID = tabPageID;
	local num = #g_dataCenter.store:GetGoodsList(tabPageID);
    self.warpItem:set_maxNum(num);
	self.warpItem:refresh_list();
	self.warpItem:set_index(1);
end
------------------分页end-------------------------

function ActivityStoreUI:gc_get_time_limit_gift_bag_config()
	self:UpdateUi();
end

function ActivityStoreUI:gc_get_time_limit_gift_bag_state()
	for k,cont in pairs(self.goodsList) do
		self:update_init_goods(cont, cont.index);
	end
end

function ActivityStoreUI:gc_buy_time_limit_gift_bag_item(gainItems)
	-- app.log("#lhf#gc_buy_time_limit_gift_bag_item gainItems:"..table.tostring(gainItems));
	CommonAward.Start(gainItems);
end

function ActivityStoreUI:gc_time_limit_gift_bag_rmb_buy_suc(gainItems)
	-- app.log("#lhf#gc_time_limit_gift_bag_rmb_buy_suc gainItems:"..table.tostring(gainItems));
	CommonAward.Start(gainItems);
end
