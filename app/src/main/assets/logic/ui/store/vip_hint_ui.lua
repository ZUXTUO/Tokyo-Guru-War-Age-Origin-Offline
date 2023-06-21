VipHintUI = Class("VipHintUI", UiBaseClass);

function VipHintUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1144_award_tc.assetbundle";
    UiBaseClass.Init(self, data);
end

function VipHintUI:Restart(data)
	self.needVip = data.vip or 1;
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function VipHintUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["onClose"] = Utility.bind_callback(self, self.onClose);
    self.bindfunc["onGo"] = Utility.bind_callback(self, self.onGo);
end

function VipHintUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("VipHintUI");

    self.labVip1 = ngui.find_label(self.ui,"centre_other/animation/sp_v/lab_v");
    self.labVip2 = ngui.find_label(self.ui,"centre_other/animation/sp_v/lab_v2");

    local btnGo = ngui.find_button(self.ui,"centre_other/animation/btn");
    btnGo:set_on_click(self.bindfunc["onGo"]);
    local btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_754_458/btn_cha");
    btnClose:set_on_click(self.bindfunc["onClose"]);

    self:UpdateUi();
end

function VipHintUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local vipCfg = g_dataCenter.player:GetVipDataConfigByLevel(self.needVip);
    self.labVip1:set_text(tostring(vipCfg.level));
    self.labVip2:set_text("-"..tostring(vipCfg.level_star));
end

function VipHintUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function VipHintUI:onClose()
	uiManager:PopUi();
end

function VipHintUI:onGo()
	uiManager:ReplaceUi(EUI.VipPackingUI)
end
