ActivityWelfareboxBoxShowUI = Class("ActivityWelfareboxBoxShowUI", UiBaseClass);

function ActivityWelfareboxBoxShowUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1123_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function ActivityWelfareboxBoxShowUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function ActivityWelfareboxBoxShowUI:Restart(data)
	self.nBoxId = data.id;
    local boxList = g_dataCenter.store:GetWelfareBoxBoxList();
    self.boxCfg = boxList[self.nBoxId];
    self.curScore = g_dataCenter.store:GetWelfareBoxScore();
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function ActivityWelfareboxBoxShowUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["gc_welfare_treasure_box_open_box"] = Utility.bind_callback(self, self.gc_welfare_treasure_box_open_box);
    self.bindfunc["onClose"] = Utility.bind_callback(self, self.onClose);
    self.bindfunc["onGetBox"] = Utility.bind_callback(self, self.onGetBox);
end

function ActivityWelfareboxBoxShowUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_welfare_treasure_box_open_box,self.bindfunc["gc_welfare_treasure_box_open_box"]);
end

function ActivityWelfareboxBoxShowUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_welfare_treasure_box_open_box,self.bindfunc["gc_welfare_treasure_box_open_box"]);
end

function ActivityWelfareboxBoxShowUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ActivityWelfareboxBoxShowUI");

    self.btnGet = ngui.find_button(self.ui,"center_other/animation/btn_yellow");
    self.btnGet:set_on_click(self.bindfunc["onGetBox"]);
    self.labBtnGet = ngui.find_label(self.ui,"center_other/animation/btn_yellow/animation/lab");
    self.btnClose = ngui.find_button(self.ui,"center_other/animation/btn_cha");
    self.btnClose:set_on_click(self.bindfunc["onClose"]);
    self.objGet = self.ui:get_child_by_name("center_other/animation/sp_art_font");

    self.listAward = {};
    for i=1,4 do
    	self.listAward[i] = {};
    	local obj = self.ui:get_child_by_name("center_other/animation/cont1/new_small_card_item"..i);
    	self.listAward[i].obj = obj;
    	self.listAward[i].card = UiSmallItem:new({parent=obj});
    end

    self:UpdateUi();
end

function ActivityWelfareboxBoxShowUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    if self.curScore >= self.boxCfg.needScore then
    	if self.boxCfg.buyNum >= 1 then
    		self.btnGet:set_active(false);
    		self.objGet:set_active(true);
    	else
    		self.btnGet:set_active(true);
    		self.labBtnGet:set_text("领取");
    		self.objGet:set_active(false);
    	end
    else
    	self.btnGet:set_active(true);
    	self.labBtnGet:set_text("确定");
    	self.objGet:set_active(false);
    end
    for i=1,4 do
    	if self.boxCfg.items[i] then
    		self.listAward[i].obj:set_active(true);
    		self.listAward[i].card:SetDataNumber(self.boxCfg.items[i].id);
    		self.listAward[i].card:SetCount(self.boxCfg.items[i].count);
    	else
    		self.listAward[i].obj:set_active(false);
    	end
    end
end

function ActivityWelfareboxBoxShowUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.listAward then
    	for k,v in pairs(self.listAward) do
    		v.card:DestroyUi();
    	end
    	self.listAward = nil;
    end
end

function ActivityWelfareboxBoxShowUI:onGetBox()
	if self.curScore >= self.boxCfg.needScore then
		if self.boxCfg.buyNum < 1 then
			msg_activity.cg_welfare_treasure_box_open_box(self.boxCfg.id)
		end
	else
		self:onClose();
	end
end

function ActivityWelfareboxBoxShowUI:onClose()
	uiManager:PopUi();
end

function ActivityWelfareboxBoxShowUI:gc_welfare_treasure_box_open_box(boxState, gainItems)
	-- app.log("#lhf#gainItems:"..table.tostring(gainItems));
	CommonAward.Start(gainItems);
	CommonAward.SetFinishCallback(self.onClose, self);
end
