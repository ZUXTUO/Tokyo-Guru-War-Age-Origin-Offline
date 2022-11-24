KuiKuLiYaSweepTimeUI = Class("KuiKuLiYaSweepTimeUI", UiBaseClass);

function KuiKuLiYaSweepTimeUI:SetData(data)
    self.callbackClose = data.closeCallback;
    self.callbackTimerOver = data.timerOverCallback;
end

function KuiKuLiYaSweepTimeUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4706_challenge.assetbundle";
    self.playCfg = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa];
    self.hurdleCfg = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaSweepTimeUI:Restart(data)
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function KuiKuLiYaSweepTimeUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
	self.bindfunc["on_btn_complete"] = Utility.bind_callback(self, self.on_btn_complete);
    self.bindfunc["gc_kuikuliya_saodang_immediately"] = Utility.bind_callback(self, self.gc_kuikuliya_saodang_immediately);
    self.bindfunc["UpdateShow"] = Utility.bind_callback(self, self.UpdateShow);
end

function KuiKuLiYaSweepTimeUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_kuikuliya_saodang_immediately,self.bindfunc["gc_kuikuliya_saodang_immediately"]);
end

function KuiKuLiYaSweepTimeUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_kuikuliya_saodang_immediately,self.bindfunc["gc_kuikuliya_saodang_immediately"]);
end

function KuiKuLiYaSweepTimeUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_4706_challenge");

    self.labTime = ngui.find_label(self.ui,"centre_other/animation/cont1/lab_time");
    self.labDes = ngui.find_label(self.ui,"centre_other/animation/cont1/lab_cengshu1");
    self.labCost = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_red/lab_num");
    self.labCurFloor = ngui.find_label(self.ui,"centre_other/animation/cont1/lab_cengshu2");
    local btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
    btnClose:set_on_click(self.bindfunc["on_btn_close"]);
    local btnComplete = ngui.find_button(self.ui,"centre_other/animation/cont1/btn");
    btnComplete:set_on_click(self.bindfunc["on_btn_complete"]);

    self:UpdateUi();
end

function KuiKuLiYaSweepTimeUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    if self.timerID then
        timer.stop(self.timerID);
        self.timerID = nil;
    end
    self:UpdateShow();
    self.timerID = timer.create(self.bindfunc["UpdateShow"],1000, -1);
end

function KuiKuLiYaSweepTimeUI:UpdateShow()
    local time = system.time()-self.playCfg:GetSweepStartTime();
    local nCurFloor = 1;
    local nCost = 0;
    for i=1,self.playCfg:GetOpenFloor(),1 do
        local cfg = self.hurdleCfg[i];
        if cfg.saodang_time >= time and time >= 0 then
            nCurFloor = i;
        end
        time = time - cfg.saodang_time;
        if time < 0 then
            nCost = nCost + cfg.saodang_cost;
        end
    end
    if -time <= 0 then
        time = 0;
        if self.timerID then
            timer.stop(self.timerID);
            self.timerID = nil;
        end
        Utility.CallFunc(self.callbackTimerOver);
        return;
    end
    local strTime = PublicFunc.FormatLeftSecondsEx(-time);
    self.labTime:set_text("扫荡倒计时:"..strTime);
    self.labDes:set_text("正在[FDE517FF] 第"..tostring(nCurFloor).."层 [-]战斗！");
    self.labCurFloor:set_text("本次扫荡至：[FDE517FF]第"..tostring(self.playCfg:GetOpenFloor()).."层[-]");
    self.labCost:set_text(tostring(nCost));
end

function KuiKuLiYaSweepTimeUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.timerID then
        timer.stop(self.timerID);
        self.timerID = nil;
    end
end

function KuiKuLiYaSweepTimeUI:on_btn_close()
	uiManager:PopUi();
end

function KuiKuLiYaSweepTimeUI:on_btn_complete()
    msg_activity.cg_kuikuliya_saodang_immediately();
end

function KuiKuLiYaSweepTimeUI:gc_kuikuliya_saodang_immediately(result, vecReward)
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
    if self.timerID then
        timer.stop(self.timerID);
        self.timerID = nil;
    end
    CommonAward.Start(vecReward);
    CommonAward.SetFinishCallback(
        function ()
            Utility.CallFunc(self.callbackClose);
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
