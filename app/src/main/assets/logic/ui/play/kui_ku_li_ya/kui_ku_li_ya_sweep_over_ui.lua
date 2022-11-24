KuiKuLiYaSweepOverUI = Class("KuiKuLiYaSweepOverUI", UiBaseClass);

function KuiKuLiYaSweepOverUI:SetData(data)
    self.callbackClose = data.closeCallback;
end

function KuiKuLiYaSweepOverUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4707_challenge.assetbundle";
    self.playCfg = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa];
    self.hurdleCfg = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaSweepOverUI:Restart(data)
    self.awards = {};
    self.awardsList = {};
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function KuiKuLiYaSweepOverUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
	self.bindfunc["on_btn_sure"] = Utility.bind_callback(self, self.on_btn_sure);
    self.bindfunc["on_item"] = Utility.bind_callback(self, self.on_item);
    self.bindfunc["gc_kuikuliya_Get_saodang_reward"] = Utility.bind_callback(self, self.gc_kuikuliya_Get_saodang_reward);
end

function KuiKuLiYaSweepOverUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_kuikuliya_Get_saodang_reward,self.bindfunc['gc_kuikuliya_Get_saodang_reward']);
end

function KuiKuLiYaSweepOverUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_kuikuliya_Get_saodang_reward,self.bindfunc['gc_kuikuliya_Get_saodang_reward']);
end

function KuiKuLiYaSweepOverUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_4707_challenge");

    local btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
    btnClose:set_on_click(self.bindfunc["on_btn_close"]);
    local btnSure = ngui.find_button(self.ui,"centre_other/animation/cont1/btn");
    btnSure:set_on_click(self.bindfunc["on_btn_sure"]);
    self.labDes = ngui.find_label(self.ui,"centre_other/animation/cont1/lab_cengshu1");
    self.cont = {};
    self.listScrollView = ngui.find_scroll_view(self.ui,"centre_other/animation/cont1/sp_down/panel_list");
    self.list = ngui.find_wrap_content(self.ui,"centre_other/animation/cont1/sp_down/panel_list/wrap_content");
    self.list:set_on_initialize_item(self.bindfunc["on_item"]);
    --每个道具均为概率获得不好做表现,临时处理
    self.list:set_active(false);

    self:UpdateUi();
end

function KuiKuLiYaSweepOverUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    self.labDes:set_text("扫荡至[FDE517FF] "..self.playCfg:GetOpenFloor().."层 [-]快去领取奖励吧！");
    self.awardsList = {};
    for i=1,self.playCfg:GetOpenFloor(),1 do
        local cfg = self.hurdleCfg[i];
        local itemList = ConfigManager.Get(EConfigIndex.t_drop_something, cfg.box_dropid);
        if itemList then
            for k,v in pairs(itemList) do
                if v.goods_id ~= 0 then
                    self.awardsList[v.goods_id] = (self.awardsList[v.goods_id] or 0) + v.goods_number;
                end
            end
        end
    end
    for k,v in pairs(self.awardsList) do
        table.insert(self.awards,k);
    end
    table.sort(self.awards);
    self.list:set_min_index(0);
    self.list:set_max_index(#self.awards-1);
    self.list:reset();
    self.listScrollView:reset_position();
end

function KuiKuLiYaSweepOverUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.awards = {};
    self.awardsList = {};
end

function KuiKuLiYaSweepOverUI:on_btn_close()
	uiManager:PopUi();
end

function KuiKuLiYaSweepOverUI:on_btn_sure()
    msg_activity.cg_kuikuliya_Get_saodang_reward();
end

function KuiKuLiYaSweepOverUI:on_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    if Utility.isEmpty(self.cont[b]) then
        self.cont[b] = self:init_item(obj)
    end
    self:update_item(self.cont[b], index);
end

function KuiKuLiYaSweepOverUI:init_item(obj)
    local cont = {}
    cont.obj = obj:get_child_by_name("");
    local data = 
    {
        parent = cont.obj,
        is_enable_goods_tip = true;
    }
    cont.item = UiSmallItem:new(data);
    return cont;
end

function KuiKuLiYaSweepOverUI:update_item(cont, index)
    local id = self.awards[index]
    if id == nil then
        cont.obj:set_active(false);
        return;
    end
    cont.obj:set_active(true);
    cont.item:SetDataNumber(id,self.awardsList[id]);
end

function KuiKuLiYaSweepOverUI:gc_kuikuliya_Get_saodang_reward(result,vecReward)
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
