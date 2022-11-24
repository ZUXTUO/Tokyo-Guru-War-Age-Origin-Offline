KuiKuLiYaOpenBoxUI = Class("KuiKuLiYaOpenBoxUI", UiBaseClass);

function KuiKuLiYaOpenBoxUI:SetFloor(floor)
    self.curFloor = floor;
    self:UpdateUi();
end

function KuiKuLiYaOpenBoxUI:SetCallback(callback)
    self.callback = callback;
end

function KuiKuLiYaOpenBoxUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4703_challenge.assetbundle";
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaOpenBoxUI:InitData(data)
	UiBaseClass.InitData(self, data);
    self.msgEnumId = MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa;
    self.playCfg = g_dataCenter.activity[self.msgEnumId];
    self.hurdleCfg = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
end

function KuiKuLiYaOpenBoxUI:Restart(data)
	if UiBaseClass.Restart(self, data) then
    end
end

function KuiKuLiYaOpenBoxUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_open"] = Utility.bind_callback(self, self.on_open);
    self.bindfunc["gc_kuikuliya_get_box_reward"] = Utility.bind_callback(self, self.gc_kuikuliya_get_box_reward);
end

function KuiKuLiYaOpenBoxUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_kuikuliya_get_box_reward,self.bindfunc['gc_kuikuliya_get_box_reward']);
end

function KuiKuLiYaOpenBoxUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_kuikuliya_get_box_reward,self.bindfunc['gc_kuikuliya_get_box_reward']);
end

function KuiKuLiYaOpenBoxUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    local spZheKou = ngui.find_sprite(self.ui,"centre_other/animation/cont1/sp_zhekou");
    spZheKou:set_active(false);
    local labZheKou = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_down/lab_cishu");
    labZheKou:set_active(false);
    local labZheKouCost = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_bar/lab_zhekou");
    labZheKouCost:set_active(false);
    local spZheKouLine = ngui.find_sprite(self.ui,"centre_other/animation/cont1/sp_bar/sp_line");
    spZheKouLine:set_active(false);

    self.labOpenTimes = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_down/lab_num2");
    self.labOpenCost = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_bar/lab_num");
    local btnFork = ngui.find_button(self.ui,"btn_cha");
    btnFork:set_on_click(self.bindfunc["on_close"]);
    local btnOpen = ngui.find_button(self.ui,"centre_other/animation/btn_you_ke");
    btnOpen:set_on_click(self.bindfunc["on_open"]);

    self:UpdateUi();
end

function KuiKuLiYaOpenBoxUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) or not self.curFloor then
        return;
    end
    local costList = ConfigManager.Get(EConfigIndex.t_discrete,83000091).data; 
    local maxOpen = ConfigManager.Get(EConfigIndex.t_discrete,83000090).data; 
    local curOpenTimes = self.playCfg:GetFloorData(self.curFloor).payForBoxTimes;
    self.labOpenTimes:set_text("[00FF73FF]"..curOpenTimes.."/"..maxOpen);
    local cost = costList[curOpenTimes+1];
    if not cost then
        cost = costList[#costList];
    end
    self.labOpenCost:set_text(tostring(cost));
end

function KuiKuLiYaOpenBoxUI:UpdateSceneInfo(info_type)
end

function KuiKuLiYaOpenBoxUI:on_close()
    if self.callback then
        Utility.CallFunc(self.callback);
    end
end

function KuiKuLiYaOpenBoxUI:on_open()
    local maxOpen = ConfigManager.Get(EConfigIndex.t_discrete,83000090).data; 
    local curOpenTimes = self.playCfg:GetFloorData(self.curFloor).payForBoxTimes;
    if maxOpen > curOpenTimes then
        msg_activity.cg_kuikuliya_get_box_reward(1,self.curFloor,1);
    end
end

function KuiKuLiYaOpenBoxUI:gc_kuikuliya_get_box_reward(result,ntype,nfloor,openTimes,reward)
    if ntype == 1 then
        self:UpdateUi();
        CommonAward.Start(reward);

        local maxOpen = ConfigManager.Get(EConfigIndex.t_discrete,83000090).data; 
        local curOpenTimes = self.playCfg:GetFloorData(self.curFloor).payForBoxTimes;
        if maxOpen == curOpenTimes then
            CommonAward.SetFinishCallback(KuiKuLiYaOpenBoxUI.on_close,self);
        end
    end
end

function KuiKuLiYaOpenBoxUI:DestroyUi()
    self.curFloor = nil;
    self.callback = nil;
    UiBaseClass.DestroyUi(self)
end
