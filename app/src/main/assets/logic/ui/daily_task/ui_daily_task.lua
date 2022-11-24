--日常任务ui
UiDailyTask = Class('UiDailyTask',UiBaseClass);

local _get_ap_lab = {
    -- [1] = "明日:[FFCC00]7:00-11:59[-]";
    [1] = "";
    [22] = "体力可领取时间:[FFCC00]7:00-11:59[-]";
    [23] = "体力可领取时间:[FFCC00]12:00-17:59[-]";
    [24] = "体力可领取时间:[FFCC00]18:00-20:59[-]";
    [25] = "体力可领取时间:[FFCC00]20:00-23:59[-]";
}

local _enter_id = {
    [1] = MsgEnum.eactivity_time.eActivityTime_Adventure;
    [5] = MsgEnum.eactivity_time.eActivityTime_Guild;
}

--------------------------------------------------
--初始化
function UiDailyTask:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/mmo_task/ui_3306_task.assetbundle';
    UiBaseClass.Init(self, data);
    --self:InitData();
    --self:Restart();
end

--初始化数据
function UiDailyTask:InitData(data)
    UiBaseClass.InitData(self, data);
    self.sim_prop = {};
    self.listItems = {};
    self.lab_task_name = {};
    self.lab_task_describe = {};
    self.lab_progress = {};
    self.btn_get = {};
    self.btn_goto = {};
    self.sp_new = {};
    --self.btn_prop = {};
    self.sp_small_item = {};
    self.sp_star = {};
    self.small_items = {};
    self.small_items_parent = {};
    self.m_sp_di_color = {};
    self.small_award_items = {};

    self.current_level = 0;
    self.m_player_oldData = nil;
end

--重新开始
function UiDailyTask:Restart(data)
    UiBaseClass.Restart(self, data);
    -- msg_dailytask.cg_request_dailytask_list();
    -- msg_dailytask.cg_request_my_dailytask_info();
end

--析构函数
function UiDailyTask:DestroyUi()
    for i=1,3 do
        if self["sim"..i] then
            self["sim"..i]:DestroyUi();
            self["sim"..i] = nil;
        end
    end

    for k,v in pairs(self.sim_prop) do
        for kk,vv in pairs(v) do
            vv:DestroyUi();
            vv = nil;
        end
    end
    self.sim_prop = {};

    for k,v in pairs(self.small_items) do
        if v then
            v:clear_texture();
            v = nil;
        end
    end
    self.small_items = {};

    for k,v in pairs(self.small_award_items) do
        if v then
            for k,v2 in pairs(v) do
                if v2 then
                    v2:DestroyUi();
                    v2 = nil;
                end
            end
            v = nil;
        end
    end
    self.small_award_items = {};
    

    self.lab_task_name = {};
    self.lab_task_describe = {};
    self.lab_progress = {};
    self.btn_get = {};
    self.btn_goto = {};
    self.sp_new = {};
    --self.btn_prop = {};
    self.sp_small_item = {};
    self.sp_star = {};

    self.back_data_list = {};
    self.m_toggle_index = 1;
    self.upperLayersCount = 0;

    self.m_is_daily_open = 0;
    self.send_cg_finish_task = false;
    UiBaseClass.DestroyUi(self);
end

function UiDailyTask:Show()
    UiBaseClass.Show(self);
    self:on_toggle_change();
end

--注册回调函数
function UiDailyTask:RegistFunc()
    UiBaseClass.RegistFunc(self);
    --self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc['on_btn_get'] = Utility.bind_callback(self, self.on_btn_get);
    self.bindfunc['on_btn_goto'] = Utility.bind_callback(self, self.on_btn_goto);
    self.bindfunc['on_btn_reward'] = Utility.bind_callback(self, self.on_btn_reward);
    self.bindfunc['on_btn_can_not_get'] = Utility.bind_callback(self, self.on_btn_can_not_get);
    self.bindfunc['on_btn_close_reward_ui'] = Utility.bind_callback(self, self.on_btn_close_reward_ui);
    self.bindfunc['on_btn_close'] = Utility.bind_callback(self, self.on_btn_close);

    self.bindfunc["on_toggle_change"] = Utility.bind_callback(self, self.on_toggle_change);
    self.bindfunc["on_yijian_get"] = Utility.bind_callback(self, self.on_yijian_get);

    self.bindfunc["on_line_go"] = Utility.bind_callback(self, self.on_line_go);
    self.bindfunc["on_line_get_award"] = Utility.bind_callback(self, self.on_line_get_award);

    self.bindfunc['gc_btn_get'] = Utility.bind_callback(self, self.gc_btn_get);
    self.bindfunc['gc_btn_reward'] = Utility.bind_callback(self, self.gc_btn_reward);
    self.bindfunc['gc_sync_my_dailytask_info'] = Utility.bind_callback(self, self.gc_sync_my_dailytask_info);
    self.bindfunc['gc_on_line_task_state'] = Utility.bind_callback(self, self.gc_on_line_task_state);
    self.bindfunc['gc_line_btn_get'] = Utility.bind_callback(self, self. gc_line_btn_get);

    self.bindfunc['on_no_get'] = Utility.bind_callback(self, self.on_no_get);
end

--注册消息分发回调函数
function UiDailyTask:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_dailytask.gc_finish_task,self.bindfunc['gc_btn_get']);
    PublicFunc.msg_regist(msg_dailytask.gc_line_finish_task, self.bindfunc['gc_line_btn_get']);

    PublicFunc.msg_regist(msg_dailytask.gc_get_star_reward,self.bindfunc['gc_btn_reward']);
    PublicFunc.msg_regist(msg_dailytask.gc_sync_my_dailytask_info,self.bindfunc['gc_sync_my_dailytask_info']);
    PublicFunc.msg_regist(msg_dailytask.gc_sync_dailytask_list,self.bindfunc['gc_sync_my_dailytask_info']);
    PublicFunc.msg_regist(msg_dailytask.gc_update_dailytask_data,self.bindfunc['gc_sync_my_dailytask_info']);
    PublicFunc.msg_regist(msg_dailytask.gc_on_line_task_state, self.bindfunc['gc_on_line_task_state']);
end

--注销消息分发回调函数
function UiDailyTask:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_dailytask.gc_finish_task,self.bindfunc['gc_btn_get']);
    PublicFunc.msg_unregist(msg_dailytask.gc_line_finish_task, self.bindfunc['gc_line_btn_get']);

    PublicFunc.msg_unregist(msg_dailytask.gc_get_star_reward,self.bindfunc['gc_btn_reward']);
    PublicFunc.msg_unregist(msg_dailytask.gc_sync_my_dailytask_info,self.bindfunc['gc_sync_my_dailytask_info']);
    PublicFunc.msg_unregist(msg_dailytask.gc_sync_dailytask_list,self.bindfunc['gc_sync_my_dailytask_info']);
    PublicFunc.msg_unregist(msg_dailytask.gc_update_dailytask_data,self.bindfunc['gc_sync_my_dailytask_info']);
    PublicFunc.msg_unregist(msg_dailytask.gc_on_line_task_state, self.bindfunc["gc_on_line_task_state"]);
end

--初始化UI
function UiDailyTask:LoadUI()
    UiBaseClass.LoadUI(self);
end

function UiDailyTask:on_toggle_change( )
    if self.isFirst ==nil then
        self.isFirst = true;
    else
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
    end
    self.btn_yijian:set_active(false);
    self.m_task_data = {};
    self.m_toggle_index = 0;
    if self.ui_toggle_1:get_value() then
        self.m_toggle_index = 1;
    end
    
    -- 请求服务器切换数据
    if self.m_toggle_index == 0 then -- 刷主线任务
        -- self:UpdateUi();--。。。。。
        -- app.log("----- 149")
        -- app.log("GetLineTaskData:" .. table.tostring(g_dataCenter.daily_task:GetLineTaskData()))
        if not g_dataCenter.daily_task:GetLineTaskData() or #g_dataCenter.daily_task:GetLineTaskData() < 1 then
            msg_dailytask.cg_on_line_task_state();
        else
            self:gc_on_line_task_state(1, g_dataCenter.daily_task:GetLineTaskData());
        end
        -- msg_dailytask.cg_on_line_task_state();
    else
        app.log("---------- 171")
        if not g_dataCenter.daily_task:GetTaskData() or #g_dataCenter.daily_task:GetTaskData() < 1 then
            msg_dailytask.cg_request_dailytask_list();
        else
            self:gc_sync_my_dailytask_info();
        end
    end
    
end

--寻找ngui对象
function UiDailyTask:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name('ui_daily_task');

    self.upperLayersCount = 0 -- 新手引导用

    self.ui_toggle_normal = ngui.find_button(self.ui, "center_other/animation/btn_zhuxian");

    self.ui_toggle_1 = ngui.find_toggle(self.ui, "center_other/animation/yeka1");
    self.ui_toggle_1:set_on_change(self.bindfunc["on_toggle_change"]);
    self.ui_toggle_2 = ngui.find_toggle(self.ui, "center_other/animation/yeka2");
    -- self.ui_toggle_2:set_on_change(self.bindfunc["on_toggle_change"]);


    self.scroll_view = ngui.find_scroll_view(self.ui, 'center_other/animation/cont1/scroll_view/panel_list');

    self.wrap_content = ngui.find_wrap_content(self.ui, 'center_other/animation/cont1/scroll_view/panel_list/wrap_content');
    self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    self.wrap_content:set_min_index(0);
    self.wrap_content:set_max_index(-1);
    self.wrap_content:reset();

    -- 一键领取
    self.btn_yijian = ngui.find_button(self.ui, 'center_other/animation/cont1/btn1');
    self.btn_yijian:reset_on_click();
    self.btn_yijian:set_on_click(self.bindfunc["on_yijian_get"]);
    self.btn_yijian:set_active(false);

    self.cont1 = self.ui:get_child_by_name("center_other/animation/cont1");

    self.cont2_cat = self.ui:get_child_by_name("center_other/animation/cont2");
    self.cont2_cat:set_active(false);

    self.m_toggle_index = 1;

    self.sp_point1 = ngui.find_sprite(self.ui, "center_other/animation/yeka1/sp_point");
    self.sp_point2 = ngui.find_sprite(self.ui, "center_other/animation/yeka2/sp_point");
    self.sp_point3 = ngui.find_sprite(self.ui, "center_other/animation/btn_zhuxian/sp_point");

    -- self.down_lab = ngui.find_label(self.ui, "center_other/animation/sp_down_di/lab");
    -- self.down_lab:set_text("");

    -- msg_dailytask.cg_request_dailytask_list();
    app.log("-- request")
    -- msg_dailytask.cg_request_my_dailytask_info();
    -- self:UpdateUi();

    local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_daily_task_open);
    if cf and g_dataCenter.player.level >= tonumber(cf.data) then
        self.ui_toggle_1:set_enable(true);
        self.ui_toggle_1:set_value(true);
        self.ui_toggle_2:set_value(false);    
        self.m_is_daily_open = 1;
        g_dataCenter.daily_task:SetIsDailytaskOpen(true);

        self.ui_toggle_normal:set_active(false);
    else
        
        self.ui_toggle_1:set_enable(false);
        self.ui_toggle_1:set_value(false);
        self.ui_toggle_2:set_value(true);
        g_dataCenter.daily_task:SetIsDailytaskOpen(false);

        self.ui_toggle_1:set_active(false);
        self.ui_toggle_2:set_active(false);
        self.ui_toggle_normal:set_active(true);
        self.m_toggle_index = 1;
        self:on_toggle_change();
        app.log("------------- set_enable")
    end
   
end

local on_line_data = {
    [1] = {id = 1, type = 1, state = 1, progress = 0},
    [2] = {id = 1, type = 2, state = 1, progress = 5},
    [3] = {id = 1, type = 3, state = 1, progress = 3},
    [4] = {id = 1, type = 4, state = 0, progress = 1},
    [5] = {id = 1, type = 5, state = 0, progress = 8}   

}
--刷新界面
function UiDailyTask:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end
    SystemEnterFunc.SetClearStack(false)
    self.m_task_data = {};
    
    local index_num = 0;
    if self.m_toggle_index == 0 then -- 主线任务
        self.sp_point3:set_active(g_dataCenter.daily_task:GetLineRedPointState());
        -- local line_task_data = g_dataCenter.daily_task:GetLineTaskData();
        if self.back_data_list then
            local is_finish_state = 1;
            local m_level_data = ConfigManager.Get(EConfigIndex.t_play_vs_data, MsgEnum.eactivity_time.eActivityTime_Guild);
            for k,v in pairs(self.back_data_list) do
                if (v.type == 5 and g_dataCenter.player.level < m_level_data.open_level) or v.id == 0 then

                elseif v.state == 2 then
                    
                else
                    index_num = index_num + 1;
                    if v.state == 0 then
                        table.insert(self.m_task_data, is_finish_state, v);
                    elseif v.state == 1 then
                        is_finish_state = is_finish_state + 1;
                        table.insert(self.m_task_data, 1, v);
                    -- elseif v.state == 2 then
                        -- table.insert(self.m_task_data, v);
                    end
                    -- table.insert(self.m_task_data, v);
                end
            end
        end
    else -- 每日任务
        -- do return end
        local taskdata = g_dataCenter.daily_task:GetTaskData();
        -- 分组
        local state_1 = {};
        local state_2 = {};
        local every_day_v = nil;
        for k,v in pairs(taskdata) do
            if v.state == 1 then
                if v.taskIndex == 28 then
                    -- table.insert(state_2, 1, v);
                    every_day_v = v;
                else
                    table.insert(state_1, 1, v);
                end
            elseif v.state == 2 then
                if self:IsCubeSugarTask(v.taskIndex) then
                    table.insert(state_2, v);
                end
            elseif v.state == 0 then
                table.insert(state_1, v);
            end
        end

        for k,v in pairs(state_2) do
             table.insert(state_1, v);
        end
        -- self.down_lab:set_text(_get_ap_lab[1]);
        for k,v in pairs(state_1) do
            if self:IsCubeSugarTask(v.taskIndex) then
                -- local sysTime = os.date("*t",system.time());
                -- local currentTime = tonumber(sysTime.hour .. string.format("%02d",sysTime.min) .. string.format("%02d",sysTime.sec));
                -- local item_data_config = ConfigManager.Get(EConfigIndex.t_dailytask, v.taskIndex);
                -- -- app.log("timecurrentTime:" .. currentTime .. "------" .. item_data_config.unlock_parm1 .. "----" .. item_data_config.unlock_parm2);

                -- if currentTime > item_data_config.unlock_parm1 and currentTime < item_data_config.unlock_parm2 then
                --     if v.state == 2 then
                --         local next_index = v.taskIndex + 1;
                --         if next_index < 25 then
                --             self.down_lab:set_text(_get_ap_lab[next_index]);
                --         else
                --             self.down_lab:set_text(_get_ap_lab[1]);
                --         end
                --     else
                --         index_num = index_num + 1;
                --         self.m_task_data[index_num] = v;

                --         self.down_lab:set_text(_get_ap_lab[v.taskIndex]);
                --     end
                -- end
            elseif v.taskIndex == 17 or v.taskIndex == 18 then

            else
                index_num = index_num + 1;
                self.m_task_data[index_num] = v;
            end
        end

        if every_day_v ~= nil then
            table.insert(self.m_task_data, 1, every_day_v);
        end
    end
    -- app.log("------" .. currentTime);
    -- app.log("---------- 来了275" .. table.tostring(self.m_task_data));
    -- self.m_task_data = taskdata;
    
    -- self.small_items = {};
   

    -- for i=1,5 do
    --     if self.small_items[i] == nil then
    --         self.small_items[i] = UiSmallItem:new({});
    --     end
    -- end

    -- for k,v in pairs(self.small_items) do
    --     if v then
    --         v:DestroyUi();
    --         v = nil;
    --     end
    -- end
    -- self.small_items = {};

    self.btn_yijian:set_active(false);
    if #self.m_task_data > 0 then
        self.listItems = {}
        self.wrap_content:set_min_index(-index_num + 1);
        self.wrap_content:set_max_index(0);
        self.wrap_content:reset();
        self.scroll_view:reset_position();
        self.cont1:set_active(true);
        self.cont2_cat:set_active(false);
    else
        self.cont1:set_active(false);
        self.cont2_cat:set_active(true);
    end

end

function UiDailyTask:init_item_wrap_content( obj,b,real_id )
   if self.m_toggle_index == 0 then -- 主线
        
        self:update_on_line_task(obj, b, real_id);
        -- self.sp_point3:set_active(g_dataCenter.daily_task:GetLineRedPointState());
   else
        self:update_daily_task(obj, b, real_id);
        --self.sp_point1:set_active(g_dataCenter.daily_task:GetRedPointState());
   end
end

function UiDailyTask:update_on_line_task( obj, b, real_id )
    local index = math.abs(real_id) + 1;
    local index_b = math.abs(b) + 1;
    if not self.m_task_data then
        return;
    end
    -- local obj_name = "item_list_" .. b;
    -- obj:set_name(obj_name);
    -- app.log("------" .. b .. "------" .. index);

    if self.listItems[index] == nil then
        self.listItems[index] = obj;
    end

    local item_data = self.m_task_data[index];
    -- app.log("395-- item_data" .. table.tostring(self.m_task_data) .. index);
    if item_data == nil then
        do return end
    end 
    local item_data_config = ConfigManager.Get(EConfigIndex.t_line_task, item_data.id);
    -- app.log("------------" .. table.tostring(item_data_config));

    -- do return end
    local lab = ngui.find_label(obj, "lab");
    lab:set_text(item_data_config.task_name);
    local lab_miaoshu = ngui.find_label(obj, "lab_miaoshu");
    lab_miaoshu:set_text(item_data_config.task_describe);

    -- self.small_items_parent[index_b] = obj:get_child_by_name("big_card_item_80");
    -- local carditem = CardProp:new({number = item_data_config.task_item_id});
    -- if not self.small_items[index_b] then
    --     self.small_items[index_b] = UiSmallItem:new({parent = self.small_items_parent[index_b], cardInfo = carditem});
    -- else
    --     self.small_items[index_b]:SetData(carditem); 
    -- end    
    -- self.small_items[index_b]:SetShowNumber(false);

    if not self.small_items[index_b] then
        self.small_items[index_b] = ngui.find_texture(obj, "texture");
    end
    self.small_items[index_b]:set_texture(tostring(item_data_config.task_item_id));

    local sp_art_font = ngui.find_sprite(obj, "sp_art_font");
    sp_art_font:set_active(false);

    local btn1 = ngui.find_button(obj, "btn1");

    local btn2 = ngui.find_button(obj, "btn2");
    local btn2_lab = ngui.find_label(obj, "btn2/animation/lab");
    local sp_di = ngui.find_sprite(obj, "sp_di");
    --sp_di:set_sprite_name("ty_liebiao1");
    -- sp_di:reset_event_propagation();
    -- if #self.m_sp_di_color ~= 0 then
    --     sp_di:set_color(self.m_sp_di_color[1], self.m_sp_di_color[2], self.m_sp_di_color[3], self.m_sp_di_color[4]);
    -- end

    local lab_plan = ngui.find_label(obj, "lab_plan");
    local need_times = 1;
    local progress = 0;
    if item_data_config.type == 1 then
        need_times = 1;
        progress = 0;
    else
        need_times = item_data_config.unlock_param1;
        progress = item_data.progress;
    end

    if progress > need_times then
        progress = need_times;
    end
    
    local rw_shuzi_di = ngui.find_sprite(obj, "sp_shuzi_di");
    rw_shuzi_di:set_sprite_name("rw_shuzi_di1");


    lab_plan:set_text( progress .. "/" .. need_times );
    lab_plan:set_active(true);
    if item_data.state == 0 then
        if item_data_config.type == 1 or item_data_config.type == 5 then
            btn1:set_active(true);
            btn1:reset_on_click();
            btn1:set_event_value(tostring(_enter_id[item_data_config.type]), 0);
            btn1:set_on_click(self.bindfunc["on_line_go"]);
            -- btn1_lab:set_text("前往");
            -- btn1_lab:set_effect_color(29/255, 85/255, 160/255, 1);
            -- btn1:set_sprite_names("ty_anniu4");
            btn2:set_active(false);
        else
            btn1:set_active(false);
            -- btn1:reset_on_click();
            btn2:set_active(false);
        end
        -- sp_di:set_event_value(tostring(item_data.id))
        -- sp_di:set_on_ngui_click(self.bindfunc["on_no_get"]);
    elseif item_data.state == 1 then
        btn2:set_active(true);
        btn2:reset_on_click();
        btn2:set_event_value(tostring(item_data.id), item_data.id);
        btn2:set_on_click(self.bindfunc["on_line_get_award"]);
        -- btn1_lab:set_text("领取");
        -- btn1_lab:set_effect_color(174/255, 65/255, 40/255, 1);
        -- btn1:set_sprite_names("ty_anniu3");
        -- sp_art_font:set_active(true);
        -- sp_art_font:set_sprite_name("hd_mr_lingqu");
        -- sp_di:set_event_value(tostring(item_data.id));
        -- sp_di:set_on_ngui_click(self.bindfunc["on_line_get_award"]);

        -- lab_plan:set_active(false);
        -- sp_di:set_color(1, 0.9, 0.6, 1);
        -- sp_di:set_sprite_name("ty_liebiao2");
        btn1:set_active(false);
        local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_line_task);
        if cf and g_dataCenter.player.level >= cf.data then
            self.btn_yijian:set_active(true);
        end
        rw_shuzi_di:set_sprite_name("rw_shuzi_di2");
        lab_plan:set_text( need_times .. "/" .. need_times );
    elseif item_data.state == 2 then
        btn1:set_active(false);
        sp_art_font:set_active(true);
        -- sp_di:set_sprite_name("mrrw_diban1");
        -- lab_plan:set_active(false);
        btn2:set_active(false);
        rw_shuzi_di:set_sprite_name("rw_shuzi_di2");
        lab_plan:set_text( need_times .. "/" .. need_times );
    end

    

    -- app.log("-----" .. #item_data_config.task_award_item .. table.tostring(item_data_config.task_award_item));
    -- do return end
    -- 奖励
    local display_awards = {};
    if item_data_config and item_data_config.task_award_item ~= "0" then
        if #item_data_config.task_award_item == 0 then
            table.insert(display_awards, {item_id = item_data_config.task_award_item.id, num = item_data_config.task_award_item.num});
        else
            for k, v in pairs(item_data_config.task_award_item) do
                table.insert(display_awards, {item_id = v.id, num = v.num});
            end
        end
    end

    if self.small_award_items[index_b] == nil then
        self.small_award_items[index_b] = {};
    end

    local display_award_num = #display_awards;
    local container = nil;
    for i=1,3 do
        local c_res = "container" .. i .. "/";
        container = obj:get_child_by_name("container"..i);
        if container then
            if i <= display_award_num then
                container:set_active(true);                 
                local award_data = display_awards[i];
                local carditem = CardProp:new({number = award_data.item_id, count=award_data.num});
                local small_card_item = obj:get_child_by_name("container"..i.."/new_small_card_item");
                if self.small_award_items[index_b][i] == nil then
                    self.small_award_items[index_b][i] = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
                else
                    self.small_award_items[index_b][i]:SetData(carditem);
                end
                self.small_award_items[index_b][i]:SetStyleByTask();
                local txt = ngui.find_label(obj, "container"..i.."/lab");
                txt:set_text("X"..award_data.num); 
            else
                container:set_active(false);
            end
       end
    end
end

function UiDailyTask:update_daily_task(obj,b,real_id)
    local index = math.abs(real_id) + 1;
    local index_b = math.abs(b) + 1;
    if not self.m_task_data then
        return;
    end
    -- local obj_name = "item_list_" .. b;
    -- obj:set_name(obj_name);
    -- app.log("------" .. b .. "------" .. index);

    if self.listItems[index] == nil then
        self.listItems[index] = obj;
    end
    
    -- do return end;
    local item_data = self.m_task_data[index];
    if item_data == nil then
        return;
    end
    
    local item_data_config = ConfigManager.Get(EConfigIndex.t_dailytask,item_data.taskIndex);
    local item_get_award_config = ConfigManager.Get(EConfigIndex.t_dailytask_reward, item_data.taskIndex);
    if not item_get_award_config then
        return;
    end
    item_get_award_config = item_get_award_config[1];

    -- self.small_items_parent[index_b] = obj:get_child_by_name("big_card_item_80");
    -- local carditem = CardProp:new({number = item_data_config.task_item_id});
    -- if not self.small_items[index_b] then
    --     self.small_items[index_b] = UiSmallItem:new({parent = self.small_items_parent[index_b], cardInfo = carditem});
    -- else
    --     self.small_items[index_b]:SetData(carditem); 
    -- end    
    -- self.small_items[index_b]:SetShowNumber(false);

    if not self.small_items[index_b] then
        self.small_items[index_b] = ngui.find_texture(obj, "texture");
    end
    self.small_items[index_b]:set_texture(tostring(item_data_config.task_item_id));
    
    local task_name = ngui.find_label(obj, "lab");
    task_name:set_text(item_data_config.task_name);
    local lab_miaoshu = ngui.find_label(obj, "lab_miaoshu");
    lab_miaoshu:set_text(item_data_config.task_describe);

    local lab_plan = ngui.find_label(obj, "lab_plan");
    local curr_times = item_data.finishTimes;
    if curr_times > item_data_config.need_times then
        curr_times = item_data_config.need_times;
    end
    lab_plan:set_text( curr_times .. "/" .. item_data_config.need_times );

    local rw_shuzi_di = ngui.find_sprite(obj, "sp_shuzi_di");
    rw_shuzi_di:set_sprite_name("rw_shuzi_di1");
    -- if item_data.taskIndex == 21 or item_data.taskIndex == 43 then
    --     app.log("------------ " .. table.tostring(item_data_config));
    --     lab_plan:set_text( curr_times .. "/" .. item_data_config.need_times );
    -- else
    --     lab_plan:set_text( curr_times .. "/" .. item_data_config.need_times );
    -- end

    local sp_art_font = ngui.find_sprite(obj, "sp_art_font");
    sp_art_font:set_active(false);

    local btn1 = ngui.find_button(obj, "btn1");
    local go_btn = ngui.find_button(obj, "btn2");
    local go_btn_lab = ngui.find_label(obj, "btn2/animation/lab");

    -- local obj_parent = obj:get_parent();
    -- local item_button = ngui.find_button(obj_parent, obj_name);
    -- item_button:reset_on_click();

    local sp_di = ngui.find_sprite(obj, "sp_di");
    --sp_di:set_sprite_name("ty_liebiao1");
    -- if #self.m_sp_di_color == 0 then
    --     local  r, g, b, a = sp_di:get_color();
    --     self.m_sp_di_color[1] = r;
    --     self.m_sp_di_color[2] = g;
    --     self.m_sp_di_color[3] = b;
    --     self.m_sp_di_color[4] = a;
    -- end
    -- sp_di:set_color(self.m_sp_di_color[1], self.m_sp_di_color[2], self.m_sp_di_color[3], self.m_sp_di_color[4]);
    sp_di:reset_event_propagation();
    -- PublicFunc.SetColorByRGBStr(sp_di, "E2CF32", 1);

    -- self.btn_yijian:set_active(false);
    if item_data.state == 0 then
        -- go_btn_lab:set_text("前往");
        -- go_btn_lab:set_effect_color(29/255, 85/255, 160/255, 1);
        -- go_btn_lab:set_active(true);
        go_btn:set_active(false);
        lab_plan:set_active(true);
        if item_data.taskIndex == 21 or item_data.taskIndex == 43 then
            go_btn:set_active(false);
            app.log("------------ " .. table.tostring(item_data_config));
            btn1:set_active(false);
        else
            -- go_btn:set_active(true);
            btn1:set_active(true)
        end
        -- btn1:set_sprite_names("ty_anniu4");
        btn1:reset_on_click();
        btn1:set_event_value(tostring(item_data_config.system_enter_id), tonumber(item_data.taskIndex));
        btn1:set_on_click(self.bindfunc["on_btn_goto"]);
        -- sp_di:set_event_value(tostring(item_data.taskIndex));
        -- sp_di:set_on_ngui_click(self.bindfunc["on_no_get"]);
    elseif item_data.state == 1 then
        go_btn:set_active(true);
        go_btn:reset_on_click();
        go_btn:set_event_value("", item_data.taskIndex);
        go_btn:set_on_click(self.bindfunc["on_btn_get"]);

        -- go_btn_lab:set_active(true);
        -- go_btn_lab:set_text("领取");
        -- go_btn_lab:set_effect_color(174/255, 65/255, 40/255, 1);
        -- go_btn:set_sprite_names("ty_anniu3");

        -- sp_art_font:set_sprite_name("hd_mr_lingqu");
        sp_art_font:set_active(false);
        -- lab_plan:set_active(false);
        btn1:set_active(false);
       
       local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_task_yijian_openLevel);
        if cf and g_dataCenter.player.level >= cf.data then
            self.btn_yijian:set_active(true);
        end
        -- sp_di:set_event_value(tostring(item_data.taskIndex));
        -- sp_di:set_on_ngui_click(self.bindfunc["on_no_get"]);

        -- sp_di:set_event_value(tostring(item_data.taskIndex));
        -- sp_di:set_on_ngui_click(self.bindfunc["on_btn_get"]);
        -- sp_di:set_color(1, 0.9, 0.6, 1);
        -- sp_di:set_sprite_name("ty_liebiao2");
        rw_shuzi_di:set_sprite_name("rw_shuzi_di2");
        lab_plan:set_text( item_data_config.need_times  .. "/" .. item_data_config.need_times );
    elseif item_data.state == 2 then
        go_btn:set_active(false);
        sp_art_font:set_active(true);
        -- sp_art_font:set_sprite_name("gk_yilingqu");
        -- lab_plan:set_active(false);
        -- PublicFunc.SetColorByRGBStr(sp_di, "E2CF32", 1);
        -- sp_di:set_color(255, 245, 163, 255);

        -- sp_di:set_event_value(tostring(item_data.taskIndex));
        -- sp_di:set_on_ngui_click(self.bindfunc["on_no_get"]);
        btn1:set_active(false);
        rw_shuzi_di:set_sprite_name("rw_shuzi_di2");
        lab_plan:set_text( item_data_config.need_times  .. "/" .. item_data_config.need_times );
    end

    
    -- 奖励
    local display_awards = {};
    if tonumber(item_get_award_config.exp) ~= 0 then
        table.insert(display_awards, {type = 1, item_id = 1, num = item_get_award_config.exp});
    end
    if tonumber(item_get_award_config.gold) ~= 0 then
        table.insert(display_awards, {type = 2, item_id = 2, num = item_get_award_config.gold});
    end
    if tonumber(item_get_award_config.crystal) ~= 0 then
        table.insert(display_awards, {type = 3, item_id = 3, num = item_get_award_config.crystal});
    end

    if item_get_award_config.item and tonumber(item_get_award_config.item) ~= 0 then
        app.log("------" .. table.tostring(item_get_award_config.item));
        for k,v in pairs(item_get_award_config.item) do
            table.insert(display_awards, {type = 4, item_id = v.id, num = v.num});
        end
    end
    if self.small_award_items == nil then
        self.small_award_items = {};
    end
    if self.small_award_items[index_b] == nil then
        self.small_award_items[index_b] = {};
    end
    local display_award_num = #display_awards;
    local container = nil;
    for i=1,3 do
        local c_res = "container" .. i .. "/";
        container = obj:get_child_by_name("container"..i);
        if container then
            if i <= display_award_num then
                container:set_active(true);                 
                local award_data = display_awards[i];
                local carditem = CardProp:new({number = award_data.item_id, count=award_data.num});
                local small_card_item = obj:get_child_by_name("container"..i.."/new_small_card_item");
                if self.small_award_items[index_b][i] == nil then
                    self.small_award_items[index_b][i] = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
                else
                    self.small_award_items[index_b][i]:SetData(carditem);
                end
                self.small_award_items[index_b][i]:SetStyleByTask();
                local txt = ngui.find_label(obj, "container"..i.."/lab");
                txt:set_text("X"..award_data.num);
                
            else
                container:set_active(false);
            end
       end
    end


    do return end

    
end


function UiDailyTask:on_line_go( t )
    local system_id = t.string_value;
    --local taskcfg = ConfigManager.Get(EConfigIndex.t_dailytask,tonumber(t.string_value))
    -- if taskcfg and taskcfg.unlock_type == 2 then
    --     --app.log("taskcfg.unlock_parm1 --> " .. taskcfg.unlock_parm1)
    --     local level = g_dataCenter.player.level
    --     if level < taskcfg.unlock_parm1 then
    --         HintUI.SetAndShow(EHintUiType.zero, "等级不足, 达到" .. taskcfg.unlock_parm1 .. "级开启")
    --         return
    --     end
    -- end
    -- uiManager:PopUi();
    app.log("------- 820-----" .. system_id)
    if tonumber(system_id) > 0 then
        SystemEnterFunc.SetClearStack(false);
        SystemEnterFunc[tonumber(system_id)]();
        -- SystemEnterFunc.ActivityEnter(system_id);
    end
   
end

-- 主线任务单个领取
function UiDailyTask:on_line_get_award( t )
    local taskIndex = tonumber(t.string_value);
    app.log("主线任务领取--" .. taskIndex);
    -- app.log(table.tostring(self.m_task_data));
    -- do return end
    self.current_level = g_dataCenter.player.level;
    self.m_player_oldData = g_dataCenter.player.oldData;
    for k,v in pairs(self.m_task_data) do
        if v.id == taskIndex and v.state == 1 then
            if not self.send_cg_finish_task then
                self.send_cg_finish_task = true;
                msg_dailytask.cg_line_finish_task({taskIndex});
            end
            break;
        end
    end

    
end

-- 单个领取
-- function UiDailyTask:on_btn_get(name, x, y, go_obj, str_value)  
function UiDailyTask:on_btn_get( t )  
    local taskIndex = tonumber(t.float_value);
    -- app.log("日常任务领取--" .. taskIndex);
    -- app.log("self.m_task_data:" .. table.tostring(self.m_task_data));
    -- do return end;
    self.current_level = g_dataCenter.player.level;
    self.m_player_oldData = g_dataCenter.player.oldData;
    for k,v in pairs(self.m_task_data) do
        if v.taskIndex == taskIndex and v.state == 1 then
            --体力领取判断
            if self:CheckCubeSugarTaskLimit(taskIndex) then
                return
            end
            if not self.send_cg_finish_task then
                self.send_cg_finish_task = true;
                msg_dailytask.cg_finish_task({taskIndex});
            end
        end

    end    
end

function UiDailyTask:CheckCubeSugarTaskLimit(taskIndex, showTip) 
    if self:IsCubeSugarTask(taskIndex) then
        local config = ConfigManager.Get(EConfigIndex.t_dailytask_reward, taskIndex)[1];
        if config and type(config.item) == 'table' then
            local addApp = 0
            for _, v in pairs(config.item) do
                if v.id == IdConfig.Ap then
                    addApp = v.num
                    break
                end
            end
            if PublicFunc.CheckApLimit(g_dataCenter.player:GetAP() + addApp, showTip) then
                return true
            end
        end   
    end
    return false
end

function UiDailyTask:IsCubeSugarTask(taskIndex) 
    return taskIndex == 22 or taskIndex == 23 or taskIndex == 24 or taskIndex == 25
end

--一键领取
function UiDailyTask:on_yijian_get( )
    app.log("一键领取发送协议--" .. self.m_toggle_index);
    local taskIndexs = {};
    local isHave = false
    local __index = nil
    self.current_level = g_dataCenter.player.level;
    self.m_player_oldData = g_dataCenter.player.oldData;
    
    for k,v in pairs(self.m_task_data) do
        if tonumber(v.state) == 1 then
            if v.taskIndex then
                if self:IsCubeSugarTask(v.taskIndex) then
                    isHave = true
                    __index = v.taskIndex
                end
                table.insert(taskIndexs, v.taskIndex);
            elseif v.id then
                table.insert(taskIndexs, v.id);
            end
        end
    end

    if isHave then
        if #taskIndexs == 1 then
            --提示
            if self:CheckCubeSugarTaskLimit(__index) then
                return
            end
        else
            --不能领取
            if self:CheckCubeSugarTaskLimit(__index, false) then
                for k, v in pairs(taskIndexs) do 
                    if v == __index then
                        table.remove(taskIndexs, k)
                        break
                    end
                end
            end
        end
    end

    if #taskIndexs > 0 then
        if not self.send_cg_finish_task then
            
            if self.m_toggle_index == 0 then -- 主线
                -- msg_dailytask.cg_line_finish_task(taskIndexs);
                self.send_cg_finish_task = true;
                msg_dailytask.cg_line_finish_task_all(taskIndexs);
                
            else
                msg_dailytask.cg_finish_task(taskIndexs);
            end
        end
    end
end

-- 主线任务领取返回
function UiDailyTask:gc_line_btn_get(result, vecItem)
    
    -- self:UpdateUi();
    app.log("825");
    msg_dailytask.cg_on_line_task_state();
    self.send_cg_finish_task = false;

    local isExp = false;
    for k,v in pairs(vecItem) do
        if v.id == 1 then
            isExp = true;
            break;
        end
    end
    if isExp then
        local oldLevel = self.current_level;
        local newLevel = g_dataCenter.player.level;
        local diff = newLevel - oldLevel;
        if diff > 0 then
            self.m_level_up_panel = true;
            -- self.upperLayersCount = self.upperLayersCount + 1
            -- CommonPlayerLevelup.Start(g_dataCenter.player);
            -- CommonPlayerLevelup.SetFinishCallback(self.back_upper_layer, self)
        end
    end

    self.upperLayersCount = self.upperLayersCount + 1
    CommonAward.Start(vecItem, 1);
    CommonAward.SetFinishCallback(self.back_upper_layer, self)
end

-- 领取返回
function UiDailyTask:gc_btn_get(result, vecItem)
    
    -- self:UpdateUi();
    msg_dailytask.cg_request_dailytask_list();

    local isExp = false;
    for k,v in pairs(vecItem) do
        if v.id == 1 then
            isExp = true;
            break;
        end
    end

    if isExp then
        app.log("g_dataCenter.player.level:" .. g_dataCenter.player.level .. "self.current_level:" .. self.current_level);
        app.log("self.m_player_oldData:" .. self.m_player_oldData.level)
        if g_dataCenter.player.level > self.current_level then
            self.m_level_up_panel = true;
        end        
    end
    
    self.upperLayersCount = self.upperLayersCount + 1
    CommonAward.Start(vecItem, 1);
    CommonAward.SetFinishCallback(self.back_upper_layer, self)
end

function UiDailyTask:on_btn_goto(t)
    local system_id = tonumber(t.string_value);

    --增加等级判断
    local taskcfg = ConfigManager.Get(EConfigIndex.t_dailytask,tonumber(t.float_value))
    if taskcfg and taskcfg.unlock_type == 2 then
        --app.log("taskcfg.unlock_parm1 --> " .. taskcfg.unlock_parm1)
        local level = g_dataCenter.player.level
        if level < taskcfg.unlock_parm1 then
            HintUI.SetAndShow(EHintUiType.zero, "等级不足, 达到" .. taskcfg.unlock_parm1 .. "级开启")
            return
        end
    end
    -- uiManager:PopUi();
    -- app.log(tostring(system_id));
    -- system_id = 2000048;
    app.log("----------- 959 system_enter_id:" .. system_id);
    
    if system_id ~= 0 then
        SystemEnterFunc.SetClearStack(false);
        -- SystemEnterFunc[system_id]();
        SystemEnterFunc.ActivityEnter(system_id);
    end
end

function UiDailyTask:ShowRewardUi(starIndex)
    local level = g_dataCenter.daily_task:GetTaskLevel();
    local drop_id = ConfigManager.Get(EConfigIndex.t_dailytask_star_reward,level)['star_reward_'..tostring(starIndex)];
    local drop_cfg = ConfigManager.Get(EConfigIndex.t_drop_something,drop_id);
    local item_count = 0;
    local item_id = {};
    local item_number = {};
    for k,v in pairs(drop_cfg) do
        item_count = item_count + 1;
        item_id[item_count] = v.goods_id;
        item_number[item_count] = v.goods_number;
    end
    if item_count == 1 then
        self.btn_reward_item[1]:set_active(false);
        self.btn_reward_item[2]:set_active(true);
        self.btn_reward_item[3]:set_active(false);
        local card_prop = CardProp:new({number = item_id[1],count = item_number[1]});
        self.lab_reward_item[2]:set_text(card_prop.name);
        if not self.sim2 then
            self.sim2 = UiSmallItem:new({obj = self.obj_reward_item[2], cardInfo = card_prop});
        else
            self.sim2:SetData(card_prop);
        end
    elseif item_count == 2 then
        self.btn_reward_item[1]:set_active(true);
        self.btn_reward_item[2]:set_active(false);
        self.btn_reward_item[3]:set_active(true);
        local card_prop = CardProp:new({number = item_id[1],count = item_number[1]});
        self.lab_reward_item[1]:set_text(card_prop.name);
        if not self.sim1 then
            self.sim1 = UiSmallItem:new({obj = self.obj_reward_item[1], cardInfo = card_prop});
        else
            self.sim1:SetData(card_prop);
        end
        card_prop = CardProp:new({number = item_id[2],count = item_number[2]});
        self.lab_reward_item[3]:set_text(card_prop.name);
        if not self.sim3 then
            self.sim3 = UiSmallItem:new({obj = self.obj_reward_item[3], cardInfo = card_prop});
        else
            self.sim3:SetData(card_prop);
        end
    elseif item_count == 3 then
        for i=1,3 do
            if i > item_count then
                self.btn_reward_item[i]:set_active(false);
            else
                local card_prop = CardProp:new({number = item_id[i],count = item_number[i]});
                self.lab_reward_item[i]:set_text(card_prop.name);
                if not self["sim"..i] then
                    self["sim"..i] = UiSmallItem:new({obj = self.obj_reward_item[i], cardInfo = card_prop});
                else
                    self["sim"..i]:SetData(card_prop);
                end
                self.btn_reward_item[i]:set_active(true);
            end
        end
    else
        for i=1,3 do
            self.btn_reward_item[i]:set_active(false);
        end
    end
    self.panel_reward:set_active(true);
end

function UiDailyTask:HideRewardUi()
    self.panel_reward:set_active(false);
end

function UiDailyTask:on_btn_reward(t)
    local starIndex = t.float_value;
    msg_dailytask.cg_get_star_reward(starIndex)
end

function UiDailyTask:gc_btn_reward(result, vecItem)
    self.upperLayersCount = self.upperLayersCount + 1
    CommonAward.Start(vecItem, 1);
    CommonAward.SetFinishCallback(self.back_upper_layer, self)
    self:UpdateUi();
end

function UiDailyTask:on_btn_can_not_get(t)
    local starIndex = t.float_value;
    self:ShowRewardUi(starIndex);
end

function UiDailyTask:on_btn_close_reward_ui()
    self:HideRewardUi();
end

function UiDailyTask:gc_sync_my_dailytask_info()
    self:UpdateUi();
end

function UiDailyTask:gc_on_line_task_state( result, vecItem )
    app.log("----------------------" .. table.tostring(vecItem));
    self.back_data_list = vecItem;
    table.sort(self.back_data_list, function ( a, b )
        return a.id > b.id
    end)
    self:UpdateUi();
end

function UiDailyTask:on_btn_close()
    -- self:Hide();
    uiManager:PopUi();
end

function UiDailyTask:ShowNavigationBar()
    return true;
end

function UiDailyTask:on_no_get( name, x, y, go_obj, str_value )
    for k,v in pairs(self.m_task_data) do

        if v.taskIndex and v.taskIndex == tonumber(str_value) and v.state == 0 then
            FloatTip.Float("任务尚未完成");
            break;
        elseif v.id and v.id == tonumber(str_value) and v.state == 0 then
            FloatTip.Float("任务尚未完成");
            break;
        end
    end
    
end

------------------------ 新手引导接口函数 -----------------------
function UiDailyTask:GetItemBtnByIndex(index)
    if not self.listItems then return nil end
    local obj = self.listItems[index];
    if obj then
        local btn_get = ngui.find_button(obj, 'btn2');
        if btn_get then
            return btn_get:get_game_object();
        end
    end
end

function UiDailyTask:GetItemBtnById(id)
    if not self.m_task_data then return nil end
    local index = nil
    for k, v in pairs(self.m_task_data) do
        if v.taskIndex == id then
            index = k
            break;
        end
    end
    if index then
        return self:GetItemBtnByIndex(index)
    end
end

function UiDailyTask:back_upper_layer()
    self.upperLayersCount = self.upperLayersCount - 1

    if self.m_level_up_panel then
        self.m_level_up_panel = false;
        
        g_dataCenter.player.oldData.level = self.current_level
        g_dataCenter.player.oldData.exp = self.m_player_oldData.exp;
        g_dataCenter.player.oldData.ap = self.m_player_oldData.ap;
        g_dataCenter.player.oldData.old_fight_value = self.m_player_oldData.old_fight_value;
        
        self.upperLayersCount = 1;
        CommonPlayerLevelup.Start(g_dataCenter.player);
        CommonPlayerLevelup.SetFinishCallback(self.back_upper_layer, self)
    else
        if self.upperLayersCount == 0 then
            self.send_cg_finish_task = false;
            NoticeManager.Notice(ENUM.NoticeType.BackToUiDailyTask)
        end
    end    
end