KuiKuLiYaAwardUI = Class("KuiKuLiYaAwardUI", UiBaseClass);

function KuiKuLiYaAwardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4705_challenge.assetbundle";
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaAwardUI:InitData(data)
	UiBaseClass.InitData(self, data);
    self.msgEnumId = MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa;
    self.playCfg = g_dataCenter.activity[self.msgEnumId];
    self.AwardCfgList = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);

    self.allAwardList = {};
    for floor_id,v in pairs(self.AwardCfgList) do
        local drop_id = v.climb_dropid;
        if drop_id ~= 0 then
            local drop_cfg = ConfigManager.Get(EConfigIndex.t_drop_something, drop_id);
            local data = {};
            data.floor = floor_id;
            data.list = {};
            for kk,cfg in ipairs(drop_cfg) do
                if cfg.goods_show_number > 0 then
                    table.insert(data.list,cfg);
                end
            end
            table.sort(data.list,function (a,b)
                if a.goods_show_number > b.goods_show_number then
                    return false
                end
                return true;
            end)
            table.insert(self.allAwardList,data);
        end
    end
end

function KuiKuLiYaAwardUI:Restart(data)
    self.awardItem = {};
    self.awardList = {};
    self:ReflashRecentAward();
	if UiBaseClass.Restart(self, data) then
    end
end

function KuiKuLiYaAwardUI:ReflashRecentAward()
    self.RecentAward = nil;
    for id,v in ipairs(self.allAwardList) do
        local floor_id = v.floor;
        local floorData = self.playCfg:GetFloorData(floor_id);
        if floorData and floorData.isGetClimbReward then
        else
            if not self.RecentAward or self.RecentAward > floor_id then
                self.RecentAward = floor_id;
            end
        end
    end
    if not self.RecentAward then
        self.RecentAward = 0;
    else
        self.RecentAward = self.RecentAward - 1;
    end
end

function KuiKuLiYaAwardUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_init_get_list"] = Utility.bind_callback(self, self.on_init_get_list);
    self.bindfunc["on_get"] = Utility.bind_callback(self, self.on_get);
    self.bindfunc["gc_kuikuliya_get_climb_reward"] = Utility.bind_callback(self, self.gc_kuikuliya_get_climb_reward);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
end

function KuiKuLiYaAwardUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_kuikuliya_get_climb_reward,self.bindfunc['gc_kuikuliya_get_climb_reward']);
end

function KuiKuLiYaAwardUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_kuikuliya_get_climb_reward,self.bindfunc['gc_kuikuliya_get_climb_reward']);
end

function KuiKuLiYaAwardUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.labCurFloor = ngui.find_label(self.ui,"centre_other/animation/content/lab_title1/lab_num");

    self.wrap = ngui.find_enchance_scroll_view(self.ui,"centre_other/animation/panel");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self.scrollGetList = ngui.find_scroll_view(self.ui,"centre_other/animation/content/sco_view/panel");
    self.wrapGetList = ngui.find_wrap_content(self.ui,"centre_other/animation/content/sco_view/panel/wrap_cont");
    self.wrapGetList:set_on_initialize_item(self.bindfunc["on_init_get_list"]);

    local btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha");
    if btnClose then
        btnClose:set_on_click(self.bindfunc["on_close"]);
    end

    self:UpdateUi();

    table.sort(self.allAwardList,function (a,b)
        -- if not a.isGet and b.isGet then
        --     return true;
        -- elseif a.isGet and not b.isGet then
        --     return false;
        -- end
        if a.floor < b.floor then
            return true;
        end
        return false;
    end)

    self.wrap:set_maxNum(#self.allAwardList);
    self.wrap:refresh_list();
    self.wrap:set_index(self.RecentAward+1);
end

function KuiKuLiYaAwardUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
        return;
    end
    self.awardGetList = {};
    local getList = {};
    local curFloor = #(self.playCfg.floorData or {});
    self.labCurFloor:set_text(tostring(curFloor));
    for id,v in ipairs(self.allAwardList) do
        local floor_id = v.floor;
        local floorData = self.playCfg:GetFloorData(floor_id);
        if floorData and floorData.isGetClimbReward then
            for k,cfg in ipairs(v.list) do
                if getList[cfg.goods_show_number] == nil then
                    getList[cfg.goods_show_number] = 0;
                end
                getList[cfg.goods_show_number] = getList[cfg.goods_show_number] + cfg.goods_number;
            end
            v.isGet = true;
        else
            v.isGet = false;
        end
    end

    for k,v in pairs(getList) do
        table.insert(self.awardGetList,{id=k,num=v});
    end
    table.sort(self.awardGetList,function (a,b)
        if a.id > b.id then
            return false
        end
        return true;
    end)

    self.wrapGetList:set_min_index(0);
    self.wrapGetList:set_max_index(#self.awardGetList-1);
    self.wrapGetList:reset();
    self.scrollGetList:reset_position();

end

function KuiKuLiYaAwardUI:UpdateAwardItem()
    for k,v in pairs(self.awardItem) do
        local data = self.allAwardList[v.index];
        self:SetAwardItem(data, v);
    end
end

function KuiKuLiYaAwardUI:SetAwardItemIndex()
    self:ReflashRecentAward();
    if #self.allAwardList >= self.RecentAward + 1 + 2 then
        self.wrap:tween_to_index(self.RecentAward+1);
    end
end

function KuiKuLiYaAwardUI:on_init_item(obj, real_id)
    local floor = real_id;
    local b = obj:get_instance_id();
    obj:set_name("itme"..real_id);
    if not self.awardItem[b] then
        self.awardItem[b] = {};
        self.awardItem[b].labFloor = ngui.find_label(obj,"sp_ban_tou/lab_num");
        self.awardItem[b].sp = ngui.find_sprite(obj,"sp_get");
        self.awardItem[b].btn = ngui.find_button(obj,"btn1");
        self.awardItem[b].btn:set_on_click(self.bindfunc["on_get"]);
        self.awardItem[b].obj1 = obj:get_child_by_name("grid/small_card_item1");
        self.awardItem[b].goods1 = UiSmallItem:new({parent=self.awardItem[b].obj1,is_enable_goods_tip=true});
        self.awardItem[b].obj2 = obj:get_child_by_name("grid/small_card_item2");
        self.awardItem[b].goods2 = UiSmallItem:new({parent=self.awardItem[b].obj2,is_enable_goods_tip=true});
        self.awardItem[b].obj3 = obj:get_child_by_name("grid/small_card_item3");
        self.awardItem[b].goods3 = UiSmallItem:new({parent=self.awardItem[b].obj3,is_enable_goods_tip=true});
        self.awardItem[b].obj4 = obj:get_child_by_name("grid/small_card_item4");
        self.awardItem[b].goods4 = UiSmallItem:new({parent=self.awardItem[b].obj4,is_enable_goods_tip=true});
    end
    local cfg = self.allAwardList[floor];
    self.awardItem[b].index = floor;
    self:SetAwardItem(cfg, self.awardItem[b]);
end

function KuiKuLiYaAwardUI:SetAwardItem(cfg, cont)
    cont.labFloor:set_text(cfg.floor.."层");
    cont.btn:set_event_value("",cfg.floor);
    for i=1,4 do
        if cfg.list[i] then
            cont["goods"..i]:SetDataNumber(cfg.list[i].goods_show_number,cfg.list[i].goods_number);
            cont["goods"..i]:Show();
            cont["obj"..i]:set_active(true);
        else
            cont["goods"..i]:Hide();
            cont["obj"..i]:set_active(false);
        end
    end
    -- local curFloor = self.playCfg:GetOpenFloor();
    -- cont.btn:set_enable(curFloor>=cfg.floor);
    local floorData = self.playCfg:GetFloorData(cfg.floor);
    if floorData then
        cont.btn:set_enable(true);
        PublicFunc.SetButtonShowMode(cont.btn, 1);
    else
        cont.btn:set_enable(false);
        PublicFunc.SetButtonShowMode(cont.btn, 3);
    end
    cont.btn:set_active(not cfg.isGet);
    cont.sp:set_active(cfg.isGet);
end

function KuiKuLiYaAwardUI:on_init_get_list(obj, b, real_id)
    local index = math.abs(real_id)+1;
    local data = self.awardGetList[index];
    if not self.awardList[b] then
        self.awardList[b] = {};
        self.awardList[b].root = UiSmallItem:new({parent=obj,is_enable_goods_tip=true});
    end
    self.awardList[b].root:SetDataNumber(data.id,data.num);
end

function KuiKuLiYaAwardUI:on_get(t)
    local floor = t.float_value;
    msg_activity.cg_kuikuliya_get_climb_reward(floor);
    self.loadingId = GLoading.Show(GLoading.EType.ui);
end

function KuiKuLiYaAwardUI:gc_kuikuliya_get_climb_reward(result,nfloor,vecreward)
    GLoading.Hide(GLoading.EType.ui, self.loadingId);
    self:UpdateUi();
    self:UpdateAwardItem();
    CommonAward.Start(vecreward);
    CommonAward.SetFinishCallback(function ()
        self:SetAwardItemIndex();
    end);
end

function KuiKuLiYaAwardUI:on_close()
    uiManager:PopUi();
end

function KuiKuLiYaAwardUI:DestroyUi()
    if self.awardItem then
        for k,v in pairs(self.awardItem) do
            v.goods1:DestroyUi();
            v.goods2:DestroyUi();
            v.goods3:DestroyUi();
            v.goods4:DestroyUi();
        end
        self.awardItem = nil;
    end
    if self.awardList then
        for k,v in pairs(self.awardList) do
            v.root:DestroyUi();
        end
        self.awardList = nil;
    end
    self.RecentAward = nil;
    UiBaseClass.DestroyUi(self)
end
