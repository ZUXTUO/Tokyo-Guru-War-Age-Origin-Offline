UiGiftExchange = Class("UiGiftExchange", UiBaseClass)

function UiGiftExchange:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1105_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function UiGiftExchange:InitData(data)
    UiBaseClass.InitData(self, data);
end

function UiGiftExchange:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_exchange"] = Utility.bind_callback(self, self.on_btn_exchange);
    self.bindfunc["gc_btn_exchange"] = Utility.bind_callback(self, self.gc_btn_exchange);
    self.bindfunc["on_input_change"] = Utility.bind_callback(self, self.on_input_change);
end

--注册消息分发回调函数
function UiGiftExchange:MsgRegist()
    UiBaseClass.MsgRegist(self)
    PublicFunc.msg_regist(msg_store.gc_redeem_item_ret,self.bindfunc['gc_btn_exchange']);
end

--注销消息分发回调函数
function UiGiftExchange:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_store.gc_redeem_item_ret,self.bindfunc['gc_btn_exchange']);
end

function UiGiftExchange:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("ui_gift_exchange");
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));

    self.btn_exchange = ngui.find_button(self.ui, "center_other/animation/btn_exchange");
    self.btn_exchange:set_enable(false);
    self.btn_exchange:set_on_click(self.bindfunc["on_btn_exchange"]);

    self.input = ngui.find_input(self.ui, "center_other/animation/sp_di");
    self.input:set_default_text("请输入兑换码");
    self.input:set_characterlimit("12");
    self.input:set_on_change(self.bindfunc['on_input_change']);

    self.lab_tip = ngui.find_label(self.ui, "center_other/animation/txt2");
end

--刷新界面
function UiGiftExchange:UpdateUi()
    UiBaseClass.UpdateUi(self)
    if not self.ui then
        return
    end
end

function UiGiftExchange:on_btn_exchange()
    local cdkey = self.input:get_value();
    if cdkey == nil or cdkey == "" then
        HintUI.SetAndShow(EHintUiType.zero, "兑换码为空");
        return
    end
    cdkey = tostring(cdkey);

    if string.len(cdkey) ~= 12 then
        HintUI.SetAndShow(EHintUiType.zero, "兑换码错误");
    end

    msg_store.cg_redeem_item(cdkey);
end

function UiGiftExchange:gc_btn_exchange(result, redeem_code, items, redeem_name)
    if tonumber(result) ~= 0 then return end
    self.redeem_name = redeem_name;
    CommonAward.Start(items, 1);
    CommonAward.SetFinishCallback(self.on_success, self);
end

function UiGiftExchange:on_success()
    HintUI.SetAndShow(EHintUiType.zero, "领取"..tostring(self.redeem_name).."成功");
end

function UiGiftExchange:on_input_change()
    local cdkey = self.input:get_value();
    local size = string.len(cdkey);
    if size == 12 then
        self.btn_exchange:set_enable(true);
        self.lab_tip:set_active(false);
    else
        self.btn_exchange:set_enable(false);
        self.lab_tip:set_active(true);
    end
end

return UiGiftExchange


