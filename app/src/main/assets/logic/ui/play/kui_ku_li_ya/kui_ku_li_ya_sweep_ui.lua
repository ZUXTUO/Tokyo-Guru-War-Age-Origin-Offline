KuiKuLiYaSweepUI = Class("KuiKuLiYaSweepUI", UiBaseClass);

function KuiKuLiYaSweepUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4702_challenge.assetbundle";
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaSweepUI:InitData(data)
	UiBaseClass.InitData(self, data);
    self.msgEnumId = MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa;
    self.playCfg = g_dataCenter.activity[self.msgEnumId];
    self.hurdleCfg = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
end

function KuiKuLiYaSweepUI:Restart(data)
	self.sweepFloor = self.playCfg:GetOpenFloor();
    self.sweepBoxFloor = {};
    for i=1,self.sweepFloor do
        local cfg = self.hurdleCfg[i];
        if cfg.byCanPayOpenBox == nil or cfg.byCanPayOpenBox == 1 then
            self.sweepBoxFloor[#self.sweepBoxFloor+1] = i;
        end
    end
	self.boxList = {};
	if UiBaseClass.Restart(self, data) then
    end
end

function KuiKuLiYaSweepUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_btn_open_times"] = Utility.bind_callback(self, self.on_btn_open_times);
    self.bindfunc["on_btn_open_box"] = Utility.bind_callback(self, self.on_btn_open_box);
    self.bindfunc["on_init_box"] = Utility.bind_callback(self, self.on_init_box);
    self.bindfunc["gc_kuikuliya_get_box_reward"] = Utility.bind_callback(self, self.gc_kuikuliya_get_box_reward);
end

function KuiKuLiYaSweepUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_kuikuliya_get_box_reward,self.bindfunc['gc_kuikuliya_get_box_reward']);
end

function KuiKuLiYaSweepUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_kuikuliya_get_box_reward,self.bindfunc['gc_kuikuliya_get_box_reward']);
end

function KuiKuLiYaSweepUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.labTitle = ngui.find_label(self.ui, "centre_other/animation/lab_word");

    self.objOpenCost1 = self.ui:get_child_by_name("centre_other/animation/btn1");
    local btn = ngui.find_button(self.ui, "centre_other/animation/btn1/btn");
    local lab = ngui.find_label(self.ui,"centre_other/animation/btn1/btn/animation/lab");
    self.labOpenCost1 = ngui.find_label(self.ui,"centre_other/animation/btn1/lab2");
    btn:set_on_click(self.bindfunc["on_btn_open_times"]);
    lab:set_text("全开1次");
    btn:set_event_value("",1);

    self.objOpenCost2 = self.ui:get_child_by_name("centre_other/animation/btn2");
    btn = ngui.find_button(self.ui, "centre_other/animation/btn2/btn");
    lab = ngui.find_label(self.ui,"centre_other/animation/btn2/btn/animation/lab");
    self.labOpenCost2 = ngui.find_label(self.ui,"centre_other/animation/btn2/lab2");
    btn:set_on_click(self.bindfunc["on_btn_open_times"]);
    lab:set_text("全开2次");
    btn:set_event_value("",2);

    self.objOpenCost3 = self.ui:get_child_by_name("centre_other/animation/btn3");
    btn = ngui.find_button(self.ui, "centre_other/animation/btn3/btn");
    lab = ngui.find_label(self.ui,"centre_other/animation/btn3/btn/animation/lab");
    self.labOpenCost3 = ngui.find_label(self.ui,"centre_other/animation/btn3/lab2");
    btn:set_on_click(self.bindfunc["on_btn_open_times"]);
    lab:set_text("全开5次");
    btn:set_event_value("",5);

    self.objOpenCost4 = self.ui:get_child_by_name("centre_other/animation/btn4");
    btn = ngui.find_button(self.ui, "centre_other/animation/btn4/btn");
    lab = ngui.find_label(self.ui,"centre_other/animation/btn4/btn/animation/lab");
    self.labOpenCost4 = ngui.find_label(self.ui,"centre_other/animation/btn4/lab2");
    btn:set_on_click(self.bindfunc["on_btn_open_times"]);
    lab:set_text("全开10次");
    btn:set_event_value("",10);

    self.objArrow = self.ui:get_child_by_name("centre_other/animation/btn_arrows");

    self.scroll = ngui.find_scroll_view(self.ui,"centre_other/animation/panel");
    self.wrap = ngui.find_wrap_content(self.ui,"centre_other/animation/panel/wrap_cont");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_box"]);

    local btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
    btnClose:set_on_click(self.bindfunc["on_close"]);

    self:UpdateUi();
end

function KuiKuLiYaSweepUI:_CalCost(times)
    local total_cost = 0;
    local costList = ConfigManager.Get(EConfigIndex.t_discrete,83000091).data; 
    for index=1,#self.sweepBoxFloor do
        local info = self.playCfg:GetFloorData(self.sweepBoxFloor[index]);
        local curFloor = info.payForBoxTimes;
        for i=1,times do
            local cost = costList[i+curFloor];
            if not cost then
                cost = costList[#costList];
            end
            total_cost = total_cost + cost;
        end
    end
    local player_vip = g_dataCenter.player:GetVip();
    local vip_cfg = g_dataCenter.player:GetVipData();
    if vip_cfg.kuikuliya_ten_discount ~= 0 and times == 10 then
        return math.floor(total_cost*vip_cfg.kuikuliya_ten_discount);
    else
        return total_cost;
    end
end

function KuiKuLiYaSweepUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local player_vip = g_dataCenter.player:GetVip();
    local vip_cfg = g_dataCenter.player:GetVipData();
    if vip_cfg.open_kuikuliya_open_box_ten == 1 then
        self.objOpenCost4:set_active(true);
    else
        self.objOpenCost4:set_active(false);
    end
    self.labTitle:set_text("您已通过[f2ae1c]"..self.sweepFloor.."[-]层，可以获得如下奖励")
    self:UpdateSceneInfo();
end

function KuiKuLiYaSweepUI:UpdateSceneInfo(info_type)
    self.labOpenCost1:set_text("x"..tostring(self:_CalCost(1)));
    self.labOpenCost2:set_text("x"..tostring(self:_CalCost(2)));
    self.labOpenCost3:set_text("x"..tostring(self:_CalCost(5)));
    self.labOpenCost4:set_text("x"..tostring(self:_CalCost(10)));
    
	self.wrap:set_min_index(0);
	self.wrap:set_max_index(#self.sweepBoxFloor-1);
	self.wrap:reset();
	self.scroll:reset_position();
end

function KuiKuLiYaSweepUI:on_close()
    local maxOpen = ConfigManager.Get(EConfigIndex.t_discrete,83000090).data; 
    for index=1,#self.sweepBoxFloor do
        local info = self.playCfg:GetFloorData(self.sweepBoxFloor[index]);
        if 0 < (maxOpen - info.payForBoxTimes) then
            local str = "有宝箱还未开启是否离开?";
            local btn1 = {};
            btn1.str = "确定";
            btn1.func = function ()
                uiManager:PopUi();
            end
            local btn2 = {};
            btn2.str = "取消";
            HintUI.SetAndShowHybrid(2, "", str, nil, btn1, btn2);
            return;
        end
    end
    uiManager:PopUi();
end

function KuiKuLiYaSweepUI:on_btn_open_times(t)
    local times = t.float_value;
    local cfg = self.playCfg.floorData;
    local maxOpen = ConfigManager.Get(EConfigIndex.t_discrete,83000090).data; 
    for k,v in pairs(cfg) do
        if times > (maxOpen - v.payForBoxTimes) then
            FloatTip.Float("开启次数已达上限");
            return;
        end
    end
    msg_activity.cg_kuikuliya_get_box_reward(2,1,times);
end

function KuiKuLiYaSweepUI:on_btn_open_box(t)
    local floor = t.float_value;
    local callback = function ()
        uiManager:ReplaceUi(EUI.KuiKuLiYaSweepUI);
    end
    local ui = uiManager:ReplaceUi(EUI.KuiKuLiYaOpenBoxUI);
    ui:SetFloor(floor);
    ui:SetCallback(callback);
end

function KuiKuLiYaSweepUI:on_init_box(obj, b, real_id)
    local index = math.abs(real_id) + 1;
	if self.boxList[b] == nil then 
		self.boxList[b] = {};
		self.boxList[b].labTitle = ngui.find_label(obj,"sp_top/lab_num1");
		self.boxList[b].labOpenTimes = ngui.find_label(obj,"sp_down/lab_num2");
        self.boxList[b].btnBox = ngui.find_button(obj, "box1");
        self.boxList[b].btnBox:set_on_click(self.bindfunc["on_btn_open_box"]);
        self.boxList[b].objFx = obj:get_child_by_name("fx_ui_4702_star");
	end
    local floor = self.sweepBoxFloor[index];
    local cfg = self.playCfg:GetFloorData(floor);
    self.boxList[b].btnBox:set_event_value("",cfg.floorIndex);
    self.boxList[b].labTitle:set_text(cfg.floorIndex.."F");
    local maxOpen = ConfigManager.Get(EConfigIndex.t_discrete,83000090).data; 
    self.boxList[b].labOpenTimes:set_text("[19dd20]"..cfg.payForBoxTimes.."/"..maxOpen.."[-]次");
    if self.boxList[b].objFx then
        if cfg.payForBoxTimes == maxOpen then
            self.boxList[b].objFx:set_active(false);
        else
            self.boxList[b].objFx:set_active(true);
        end
    end
end

function KuiKuLiYaSweepUI:gc_kuikuliya_get_box_reward(result,ntype,nfloor,openTimes,vecReward)
    if ntype == 2 then
        self:UpdateSceneInfo();
        if #vecReward == 0 then
            FloatTip.Float("开启次数已达上限");
            return;
        end
        local reward = {};
        for k,v in pairs(vecReward) do
            reward[v.id] = (reward[v.id] or 0) + v.count;
        end
        vecReward = {};
        for id,count in pairs(reward) do
            vecReward[#vecReward+1] = {id=id,count=count};
        end
        CommonAward.Start(vecReward);
        CommonAward.SetFinishCallback(KuiKuLiYaSweepUI.on_close,self);
        local maxOpen = ConfigManager.Get(EConfigIndex.t_discrete,83000090).data; 
        local cfg = self.playCfg.floorData;
        for k,v in pairs(cfg) do
            if 0 < (maxOpen - v.payForBoxTimes) then
                CommonAward.SetFinishCallback();
                return;
            end
        end
    end
end

function KuiKuLiYaSweepUI:DestroyUi()
    UiBaseClass.DestroyUi(self)
end
