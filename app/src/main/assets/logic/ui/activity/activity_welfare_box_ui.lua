ActivityWelfareBoxUI = Class("ActivityWelfareBoxUI", UiBaseClass);

local EBoxStateSpriteName = 
{
	[1] = {"gq_baoxiang1","gq_baoxiang1_2"},
	[2] = {"gq_baoxiang1","gq_baoxiang1_2"},
	[3] = {"gq_baoxiang1","gq_baoxiang1_2"},
	[4] = {"gq_baoxiang1","gq_baoxiang1_2"},
	[5] = {"gq_baoxiang1","gq_baoxiang1_2"},
	[6] = {"gq_baoxiang3","gq_baoxiang3_2"},
}

function ActivityWelfareBoxUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1122_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function ActivityWelfareBoxUI:InitData(data)
	self.activityid = data.id;
	g_dataCenter.store:RequestActive(data.id);
	msg_activity.cg_welfare_treasure_box_get_state();
    UiBaseClass.InitData(self, data);
end

function ActivityWelfareBoxUI:Restart(data)
	self.curIndex = 1;
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function ActivityWelfareBoxUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["onStopMove"] = Utility.bind_callback(self, self.onStopMove);
	self.bindfunc["onStartPos"] = Utility.bind_callback(self, self.onStartPos);
	self.bindfunc["onEndPos"] = Utility.bind_callback(self, self.onEndPos);
	self.bindfunc["on_get_box"] = Utility.bind_callback(self, self.on_get_box);
	self.bindfunc["onBtnLeft"] = Utility.bind_callback(self, self.onBtnLeft);
	self.bindfunc["onBtnRight"] = Utility.bind_callback(self, self.onBtnRight);
	self.bindfunc["onBuyItem"] = Utility.bind_callback(self, self.onBuyItem);
    self.bindfunc["gc_welfare_treasure_box_get_config"] = Utility.bind_callback(self, self.gc_welfare_treasure_box_get_config);
    self.bindfunc["gc_welfare_treasure_box_get_state"] = Utility.bind_callback(self, self.gc_welfare_treasure_box_get_state);
    self.bindfunc["gc_welfare_treasure_box_buy_item"] = Utility.bind_callback(self, self.gc_welfare_treasure_box_buy_item);
end

function ActivityWelfareBoxUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_welfare_treasure_box_get_config,self.bindfunc["gc_welfare_treasure_box_get_config"]);
    PublicFunc.msg_regist(msg_activity.gc_welfare_treasure_box_get_state,self.bindfunc["gc_welfare_treasure_box_get_state"]);
    PublicFunc.msg_regist(msg_activity.gc_welfare_treasure_box_buy_item,self.bindfunc["gc_welfare_treasure_box_buy_item"]);
end

function ActivityWelfareBoxUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_welfare_treasure_box_get_config,self.bindfunc["gc_welfare_treasure_box_get_config"]);
    PublicFunc.msg_unregist(msg_activity.gc_welfare_treasure_box_get_state,self.bindfunc["gc_welfare_treasure_box_get_state"]);
    PublicFunc.msg_unregist(msg_activity.gc_welfare_treasure_box_buy_item,self.bindfunc["gc_welfare_treasure_box_buy_item"]);
end

function ActivityWelfareBoxUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ActivityWelfareBoxUI");
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));

	self.labTitle = ngui.find_label(self.ui,"center_other/animation/texture_bk/lab_big");
	self.labDes = ngui.find_label(self.ui,"center_other/animation/texture_bk/lab_1");
	self.labTime = ngui.find_label(self.ui,"center_other/animation/texture_bk/txt_time");

    self.dragCycleGroup = ngui.find_enchance_scroll_view(self.ui,"center_other/animation/panel_scoll_view");
    self.dragCycleGroup:set_on_stop_move(self.bindfunc["onStopMove"]);
    self.dragCycleGroup:set_on_initialize_item(self.bindfunc["on_init_item"]);
    self.dragCycleGroup:set_on_outstart(self.bindfunc["onStartPos"]);
    self.dragCycleGroup:set_on_outend(self.bindfunc["onEndPos"]);

    self.btnArrowL = ngui.find_button(self.ui,"center_other/animation/btn_left");
	self.btnArrowL:set_on_click(self.bindfunc["onBtnLeft"],"MyButton.NoneAudio");
	self.btnArrowR = ngui.find_button(self.ui,"center_other/animation/btn_right");
	self.btnArrowR:set_on_click(self.bindfunc["onBtnRight"],"MyButton.NoneAudio");

	self.labScore = ngui.find_label(self.ui,"center_other/animation/down/txt/lab_num");
	self.contBox = {};
	for i=1,6 do
		self.contBox[i] = {};
		self.contBox[i].obj = self.ui:get_child_by_name("center_other/animation/down/cont_box/btn_box"..i);
		self.contBox[i].btn = ngui.find_button(self.ui,"center_other/animation/down/cont_box/btn_box"..i);
		self.contBox[i].btn:set_on_click(self.bindfunc["on_get_box"]);
		self.contBox[i].btn:set_event_value("",i);
		self.contBox[i].sp = ngui.find_sprite(self.ui,"center_other/animation/down/cont_box/btn_box"..i.."/sp");
		self.contBox[i].lab = ngui.find_label(self.ui,"center_other/animation/down/cont_box/btn_box"..i.."/lab_num");
		self.contBox[i].spPoint = ngui.find_sprite(self.ui,"center_other/animation/down/cont_box/btn_box"..i.."/sp_point");
		self.contBox[i].spPoint:set_active(false);
        self.contBox[i].pro = ngui.find_progress_bar(self.ui,"center_other/animation/down/cont_box/btn_box"..i.."/pro_di");
	end

    self:UpdateUi();
end

function ActivityWelfareBoxUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end

    local cfg = ConfigManager.Get(EConfigIndex.t_activity_play,self.activityid);
    self.labTitle:set_text(cfg.name);
    if cfg.des == 0 then
    	self.labDes:set_text("");
    else
    	self.labDes:set_text(cfg.des);
    end
    self:UpdateTime();

    self.contItem = {};
    local itemList = g_dataCenter.store:GetWelfareBoxItemList();
    self.dragCycleGroup:set_maxNum(#itemList);
    self.dragCycleGroup:refresh_list();

    self:UpdateBoxUI();
end

function ActivityWelfareBoxUI:Update()
	self:UpdateTime();
end

function ActivityWelfareBoxUI:UpdateTime()
	if not self.ui then return end;
    local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(self.activityid);
    local endTime = activityTime.e_time;
    local curTime = system.time();
    if endTime <= 0 then
        self.labTime:set_text("");
        return;
    end
    local day, hours, min, sec = TimeAnalysis.ConvertSecToDayHourMin(endTime-curTime)
    if day == 0 then
    	self.labTime:set_text(string.format("活动倒计时:[FDE517FF]%02d:%02d:%02d[-]",hours,min,sec));
    else
    	self.labTime:set_text(string.format("活动倒计时:[FDE517FF]%d天%02d:%02d:%02d[-]",day,hours,min,sec));
    end
end

function ActivityWelfareBoxUI:UpdateBoxUI()
	if not self.ui then
		return;
	end
    local boxList = g_dataCenter.store:GetWelfareBoxBoxList();
    local maxScore = 0;
    local curScore = g_dataCenter.store:GetWelfareBoxScore();
    local laseScore = 0;
    for i=1,6 do
    	if boxList[i] then
	    	if maxScore < boxList[i].needScore then
	    		maxScore = boxList[i].needScore;
	    	end
	    	if curScore >= boxList[i].needScore then
	    		if boxList[i].buyNum >= 1 then
		    		self.contBox[i].obj:animated_stop("ui_701_level_down_btnbox_sp");
		    		self.contBox[i].sp:set_sprite_name(EBoxStateSpriteName[i][2]);
		    	else
		    		self.contBox[i].obj:animated_play("ui_701_level_down_btnbox_sp");
		    		self.contBox[i].sp:set_sprite_name(EBoxStateSpriteName[i][1]);
		    	end
	    	else
	    		self.contBox[i].obj:animated_stop("ui_701_level_down_btnbox_sp");
	    		self.contBox[i].sp:set_sprite_name(EBoxStateSpriteName[i][1]);
	    	end
            self.contBox[i].pro:set_value((curScore-laseScore)/(boxList[i].needScore-laseScore))
	    	self.contBox[i].lab:set_text(tostring(boxList[i].needScore));
            laseScore = boxList[i].needScore;
	    end
    end
    self.labScore:set_text(tostring(curScore));
end

function ActivityWelfareBoxUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function ActivityWelfareBoxUI:onStartPos(isStart)
    self.btnArrowL:set_active(not isStart);
end

function ActivityWelfareBoxUI:onEndPos(isEnd)
    self.btnArrowR:set_active(not isEnd);
end

function ActivityWelfareBoxUI:onBtnRight()
    self.dragCycleGroup:tween_to_index(self.curIndex+1);
end

function ActivityWelfareBoxUI:onBtnLeft()
    self.dragCycleGroup:tween_to_index(self.curIndex-1);
end

function ActivityWelfareBoxUI:onStopMove(index)
    if self.curIndex and self.curIndex ~= index then
        MyButton.DragMenu();
    end
    self.curIndex = index;
end

function ActivityWelfareBoxUI:on_get_box(t)
	local openId = t.float_value;
    uiManager:PushUi(EUI.ActivityWelfareboxBoxShowUI, {id=openId});
end

function ActivityWelfareBoxUI:on_init_item(obj, index)
    local b = obj:get_instance_id();
    if Utility.isEmpty(self.contItem[b]) then
        self.contItem[b] = self:init_item(obj)
    end
    self:update_init_item(self.contItem[b], index);
end

function ActivityWelfareBoxUI:init_item(obj)
    local cont = {}
    cont.obj = obj;
    cont.labName = ngui.find_label(obj,"texture1/lab_num");
    cont.labScore = ngui.find_label(obj,"texture1/lab_zengsong");
    cont.labTimes = ngui.find_label(obj,"texture1/lab_cishu");
    cont.labCost = ngui.find_label(obj,"texture1/sp_gem/lab_num");
    local o = obj:get_child_by_name("texture1/new_small_card_item");
    cont.objCard = UiSmallItem:new({parent=o});
    cont.spCost = ngui.find_sprite(obj,"texture1/sp_gem");
    cont.objSellOver = obj:get_child_by_name("texture1/sp_art_font");
    cont.btn = ngui.find_button(obj,"texture1/ui_button_left");
	cont.btn:reset_on_click()
    cont.btn:set_on_click(self.bindfunc["onBuyItem"]);
    return cont;
end

function ActivityWelfareBoxUI:update_init_item(cont, index)
    local itemList = g_dataCenter.store:GetWelfareBoxItemList();
    local cfg = itemList[index];
    if cfg then
    	cont.obj:set_active(true);
    else
    	cont.obj:set_active(false);
    	return;
    end
	cont.index = index;
	local cardInfo = CardProp:new({number=cfg.itemID,count=itemNum});
	cont.objCard:SetData(cardInfo);
	cont.objCard:SetCount(cfg.itemNum);
	cont.labName:set_text(cardInfo.name);
	cont.labScore:set_text("赠送[FFF000FF]"..tostring(cfg.awardScore).."[-]积分");
	if cfg.dayLimitNum == 0 then
		cont.labTimes:set_text("");
	else
		cont.labTimes:set_text("今日剩余次数:"..tostring(cfg.dayLimitNum-cfg.buyNum));
	end
	if cfg.dayLimitNum-cfg.buyNum <= 0 and cfg.dayLimitNum ~= 0 then
		cont.objSellOver:set_active(true);
		cont.btn:set_active(false);
	else
		cont.objSellOver:set_active(false);
		cont.btn:set_active(true);
	end
	cont.labCost:set_text(tostring(cfg.costItemNum));
	cont.btn:set_event_value("",index);
end

function ActivityWelfareBoxUI:onBuyItem(t)
	local index = t.float_value;
    local itemList = g_dataCenter.store:GetWelfareBoxItemList();
    local cfg = itemList[index];
	local num = cfg.dayLimitNum - cfg.buyNum;
	if cfg.dayLimitNum == 0 then
		num = 100;
	end
	if num > 10 then
		BatchBuyAction.ShowAction({info=CardProp:new({number = cfg.itemID, count = cfg.itemNum}),
			max_number=num,
			callback=function (info, num)
			self:BuyGoods(index, num);
			end
		});
	else
		self:BuyGoods(index, 1);
	end
end

function ActivityWelfareBoxUI:BuyGoods(index, num)
    local itemList = g_dataCenter.store:GetWelfareBoxItemList();
    local cfg = itemList[index];
    msg_activity.cg_welfare_treasure_box_buy_item(cfg.id, num)
end
----------------message
function ActivityWelfareBoxUI:gc_welfare_treasure_box_get_config()
	self:UpdateUi();
end

function ActivityWelfareBoxUI:gc_welfare_treasure_box_get_state()
	for k,v in pairs(self.contItem or {}) do
		self:update_init_item(v, v.index);
	end
    self:UpdateBoxUI();
end

function ActivityWelfareBoxUI:gc_welfare_treasure_box_buy_item(newScore, itemState, gainItem)
	-- app.log("#lhf#gainItem:"..table.tostring(gainItem));
	CommonAward.Start({gainItem});
    self:UpdateBoxUI();
	for k,v in pairs(self.contItem or {}) do
		self:update_init_item(v, v.index);
	end
end
