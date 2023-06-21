KuiKuLiYaSweepDlgUI = Class("KuiKuLiYaSweepDlgUI", UiBaseClass);

function KuiKuLiYaSweepDlgUI:SetData(data)
    self.nFloor = data.floor;
    self.callbackClose = data.closeCallback;
    self.callbackComplete = data.completeCallback;
    self:UpdateUi();
end

function KuiKuLiYaSweepDlgUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4708_challenge.assetbundle";
    self.hurdleCfg = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
    self.msgEnumId = MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa;
    self.playCfg = g_dataCenter.activity[self.msgEnumId];
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaSweepDlgUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_sweep"] = Utility.bind_callback(self, self.on_btn_sweep);
    self.bindfunc["on_btn_complete"] = Utility.bind_callback(self, self.on_btn_complete);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
    self.bindfunc["gc_saodang_kuikuliya"] = Utility.bind_callback(self, self.gc_saodang_kuikuliya);
end

function KuiKuLiYaSweepDlgUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_saodang_kuikuliya,self.bindfunc['gc_saodang_kuikuliya']);
end

function KuiKuLiYaSweepDlgUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_saodang_kuikuliya,self.bindfunc["gc_saodang_kuikuliya"]);
end

function KuiKuLiYaSweepDlgUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_4708_challenge");

    self.labDes = ngui.find_label(self.ui,"centre_other/animation/cont1/txt");
    self.labCost = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_bar/lab_num");
    local btnSweep = ngui.find_button(self.ui,"centre_other/animation/cont1/btn1");
    btnSweep:set_on_click(self.bindfunc["on_btn_sweep"]);
    local btnComplete = ngui.find_button(self.ui,"centre_other/animation/cont1/btn2");
    btnComplete:set_on_click(self.bindfunc["on_btn_complete"]);
    local btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
    btnClose:set_on_click(self.bindfunc["on_btn_close"]);

    self:UpdateUi();
end

function KuiKuLiYaSweepDlgUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local cost = 0;
    if self.nFloor then
        for i,cfg in ipairs(self.hurdleCfg) do
            if i > self.nFloor then
                break;
            end
            cost = cost + cfg.saodang_cost;
        end
    end
    local str = "扫荡前"..tostring(self.nFloor).."层可以立即获得奖励";
    self.labDes:set_text(str);
    self.labCost:set_text(tostring(cost));
end

function KuiKuLiYaSweepDlgUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function KuiKuLiYaSweepDlgUI:on_btn_sweep()
	msg_activity.cg_saodang_kuikuliya(false);
end

function KuiKuLiYaSweepDlgUI:on_btn_complete()
	msg_activity.cg_saodang_kuikuliya(true);
end

function KuiKuLiYaSweepDlgUI:on_btn_close()
	Utility.CallFunc(self.callbackClose);
end

function KuiKuLiYaSweepDlgUI:gc_saodang_kuikuliya(result,bfast, vecReward)
    if not bfast then
        Utility.CallFunc(self.callbackClose);
        return;
    end
    local reward = {};
    for k,v in pairs(vecReward) do
        reward[v.id] = (reward[v.id] or 0) + v.count;
    end
    vecReward = {};
    local ratio_num = 1;
    for id,count in pairs(reward) do
        ratio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.kuikuliya, id);         
        vecReward[#vecReward+1] = {id=id,count=count,double_radio=ratio_num};
    end
    CommonAward.Start(vecReward);
    CommonAward.SetFinishCallback(
        function ()
            Utility.CallFunc(self.callbackComplete);
            local sweepBoxFloor = {};
            for i=1,self.playCfg:GetOpenFloor() do
                local cfg = self.hurdleCfg[i];
                if cfg.byCanPayOpenBox == nil or cfg.byCanPayOpenBox == 1 then
                    sweepBoxFloor[#sweepBoxFloor+1] = i;
                end
            end
            if #sweepBoxFloor ~= 0 then
                local ui = uiManager:PushUi(EUI.KuiKuLiYaSweepUI);
            end
        end
        )
end