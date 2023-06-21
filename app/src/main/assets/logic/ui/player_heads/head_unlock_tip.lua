HeadUnlockTip = Class('HeadUnlockTip',UiBaseClass);
------------外部接口--------------
--[[弹出更换玩家头像面板]]
function HeadUnlockTip.ShowUI(roleId)
	HeadUnlockTip.roleId = roleId;
	HeadUnlockTip.instance = HeadUnlockTip:new();
end

--重新开始
function HeadUnlockTip:Restart(data)
    app.log("HeadUnlockTip:Restart");
    UiBaseClass.Restart(self, data);
end

function HeadUnlockTip:InitData(data)
    app.log("HeadUnlockTip:InitData");
    UiBaseClass.InitData(self, data);
    self.msg = nil;
end

function HeadUnlockTip:RegistFunc()
	app.log("HeadUnlockTip:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_btn_close_click'] = Utility.bind_callback(self,self.on_btn_close_click);
end

function HeadUnlockTip:UpdateUi()
	local roleId = HeadUnlockTip.roleId;
	local cardInfo = PublicFunc.CreateCardInfo(roleId)
	local card = UiPlayerHead:new({parent = self.playerHead, roleId = roleId,})
	card:SetParent(self.vs.room);
	self.vs.labDesc:set_overflow(2);
	self.vs.labDesc:set_text("获得"..tostring(cardInfo.name).."后解锁该头像");
end 

function HeadUnlockTip:InitUI(asset_obj)
	app.log("HeadUnlockTip:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('HeadUnlockTip');
    self.vs = {};
	self.vs.panel = ngui.find_panel(self.ui,self.ui:get_name());
	self.vs.panel:set_depth(4000);
	self.vs.mask = ngui.find_button(self.ui,"sp_mark");
	self.vs.closeBtn = ngui.find_button(self.ui,"centre_other/animation/content_di_754_458/btn_cha");
	self.vs.mask:set_on_click(self.bindfunc['on_btn_close_click']);
	self.vs.closeBtn:set_on_click(self.bindfunc['on_btn_close_click']);
	self.vs.room = self.ui:get_child_by_name("centre_other/animation/new_small_card_item");
	self.vs.labDesc = ngui.find_label(self.ui,"centre_other/animation/lab_word");
	self:UpdateUi();
end

function HeadUnlockTip:on_btn_close_click()
	app.log("HeadUnlockTip:Hide()");
	self:Hide();
	self:DestroyUi();
	HeadUnlockTip.instance = nil;
end

function HeadUnlockTip:Init(data)
	app.log("HeadUnlockTip:Init");
    self.pathRes = "assetbundles/prefabs/ui/playerhead/ui_min_head_tc.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function HeadUnlockTip:DestroyUi()
	app.log("HeadUnlockTip:DestroyUi");
    self.vs = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function HeadUnlockTip:Show()
	app.log("HeadUnlockTip:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function HeadUnlockTip:Hide()
	app.log("HeadUnlockTip:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function HeadUnlockTip:MsgRegist()
	app.log("HeadUnlockTip:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function HeadUnlockTip:MsgUnRegist()
	app.log("HeadUnlockTip:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end