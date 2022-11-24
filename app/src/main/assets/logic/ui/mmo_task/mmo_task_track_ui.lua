--任务追踪面板
MMOTaskTrackUI = Class('MMOTaskTrackUI',UiBaseClass);
--------------------------------------------------

local _TaskTypeName = {
    [0] = "[主]",
    [1] = "[活]",
    [2] = "[支]",
    [3] = "[日]",
    [4] = "[环]",
}

local _local = {}
_local.UIText = {
    [1] = "(%s)"
}

--初始化
function MMOTaskTrackUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/mmo_task/ui_3305_task.assetbundle';
    UiBaseClass.Init(self, data);
end

--初始化数据
function MMOTaskTrackUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.taskTimer = nil    -- 任务的倒计时计数器
    self.timerText = nil    -- 任务的倒计时文本对象
    self.taskList = nil
    self.taskItems = nil
    self.boss_list = g_dataCenter.bossList
end

--显示函数
function MMOTaskTrackUI:Show()
    if UiBaseClass.Show(self) then
        self:UpdateUi()
    end
end

--隐藏函数
function MMOTaskTrackUI:Hide()
    UiBaseClass.Hide(self);
end

--析构函数
function MMOTaskTrackUI:DestroyUi()
    UiBaseClass.DestroyUi(self);

    if self.taskTimer then
        timer.stop(self.taskTimer)
        self.taskTimer = nil
    end
    self.taskList = nil
    self.timerText = nil
    self.taskItems = nil
end

--注册回调函数
function MMOTaskTrackUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_btn_task'] = Utility.bind_callback(self, self.on_btn_task);
    self.bindfunc['on_item_click'] = Utility.bind_callback(self, self.on_item_click);
    self.bindfunc['on_init_item'] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc['on_cd_timer'] = Utility.bind_callback(self, self.on_cd_timer);
    self.bindfunc['on_task_change'] = Utility.bind_callback(self, self.on_task_change);
    self.bindfunc['on_click_open_list'] = Utility.bind_callback(self, self.on_click_open_list);
    self.bindfunc['on_click_close_list'] = Utility.bind_callback(self, self.on_click_close_list);

    self.bindfunc['on_btn_boss'] = Utility.bind_callback(self, self.on_btn_boss);
    self.bindfunc['on_init_item_boss'] = Utility.bind_callback(self, self.on_init_item_boss);
    self.bindfunc['on_boss_change'] = Utility.bind_callback(self, self.on_boss_change);
    self.bindfunc['open_boss_list_ui'] = Utility.bind_callback(self, self.open_boss_list_ui);  
    self.bindfunc['show_boss_yeka'] = Utility.bind_callback(self, self.show_boss_yeka);  
end

--注册消息分发回调函数
function MMOTaskTrackUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(world_msg.gc_sync_single_task, self.bindfunc["on_task_change"])
    PublicFunc.msg_regist(world_msg.gc_add_referrer_task, self.bindfunc["on_task_change"])
    PublicFunc.msg_regist(world_msg.gc_mmo_boss_update, self.bindfunc["on_boss_change"])
    PublicFunc.msg_regist(player.gc_update_player_exp_level, self.bindfunc["show_boss_yeka"])    
end

--注销消息分发回调函数
function MMOTaskTrackUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(world_msg.gc_sync_single_task, self.bindfunc["on_task_change"])
    PublicFunc.msg_unregist(world_msg.gc_add_referrer_task, self.bindfunc["on_task_change"])
    PublicFunc.msg_unregist(world_msg.gc_mmo_boss_update, self.bindfunc["on_boss_change"])
    PublicFunc.msg_unregist(player.gc_update_player_exp_level, self.bindfunc["show_boss_yeka"]) 
end

--初始化UI
function MMOTaskTrackUI:LoadUI()
    UiBaseClass.LoadUI(self);
end

--寻找ngui对象
function MMOTaskTrackUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('ui_mmo_task_track');

    self.taskItems = {}
    -- 启动定时器
    self.taskTimer = timer.create(self.bindfunc["on_cd_timer"], 1000, -1)

    local path = "centre_other/animation/scroll_view"
    self.scrollView = ngui.find_scroll_view(self.ui, path.."/tween/animation/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path.."/tween/animation/panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self.scrollViewBoss = ngui.find_scroll_view(self.ui, path.."/tween/animation/panel_list1")
    self.wrapContentBoss = ngui.find_wrap_content(self.ui, path.."/tween/animation/panel_list1/wrap_content")
    self.wrapContentBoss:set_on_initialize_item(self.bindfunc["on_init_item_boss"])
    self.scrollViewBoss:set_active(false)

    -- 收缩箭头按钮
    self.btnSpToOpen = ngui.find_button(self.ui, path.."/content/sp1")
    self.btnSpToClose = ngui.find_button(self.ui, path.."/content/sp")

    self.btnSpToOpen:set_on_click(self.bindfunc["on_click_open_list"])
    self.btnSpToClose:set_on_click(self.bindfunc["on_click_close_list"])

    -- 收缩动画
    self.tween = ngui.find_tween_position(self.ui, path.."/tween")

    -- 第一项选中特效
    self.effect = ngui.find_panel(self.ui, path.."/tween/animation/panel")
    self.effect:set_active(false)

    -- 任务按钮
    local btn = ngui.find_button(self.ui, path.."/tween/animation/yeka_activity/sp")
    btn:set_on_click(self.bindfunc["on_btn_task"])
    self.sp_task = ngui.find_sprite(self.ui, path.."/tween/animation/yeka_activity/sp1")
    self.obj_task = self.sp_task:get_game_object()
    self.sp_task:set_active(true)

    -- boss列表
    local btn_boss = ngui.find_button(self.ui, path.."/tween/animation/yeka_boss/sp")
    btn_boss:set_on_click(self.bindfunc["on_btn_boss"])
    self.sp_boss = ngui.find_sprite(self.ui, path.."/tween/animation/yeka_boss/sp1")
    self.obj_boss = self.sp_boss:get_game_object()
    self.sp_boss:set_active(false)
    --等级限制
    self.yeka_boss = self.ui:get_child_by_name(path .."/tween/animation/yeka_boss")
    self.yeka_boss:set_active(false)
    self:show_boss_yeka()

    self:on_click_open_list();
    self:ResetTaskList();
    self:ResetBossList();

    self:UpdateUi();
end

--[[显示boss页卡]]
function MMOTaskTrackUI:show_boss_yeka()
    if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_BossList) then
        if self.ui and self.yeka_boss then
            self.yeka_boss:set_active(true)
        end
    end
end

--隐藏
function MMOTaskTrackUI:Hide()
    if UiBaseClass.Hide(self) then
    end
end

--是否显示特效
function MMOTaskTrackUI:EnableShowEffect(bool)
    self.isShowEffect = bool;
    if self.effect == nil then return end
    if self.saveEffectShow ~= nil then return end
    if GuideManager.IsGuideRuning() then return end
    
    self.effect:set_active(bool)
end

--保存特效显示状态，供还原使用
function MMOTaskTrackUI:SaveShowEffect()
    self.saveEffectShow = self.isShowEffect
    if self.effect then
        self.effect:set_active(false)
    end
end

function MMOTaskTrackUI:RestoreShowEffect()
    if self.saveEffectShow == nil then return end
    self.saveEffectShow = nil
    self:EnableShowEffect(self.isShowEffect)
end

--刷新列表
function MMOTaskTrackUI:ResetTaskList()
    if self.ui == nil then return end

    self.timerText = {}
    self.taskList = g_dataCenter.task:GetListByOrder()
    local count = #self.taskList
    self.wrapContent:set_min_index(1 - count);
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position()
end

--[[刷新boss列表]]
function MMOTaskTrackUI:ResetBossList()
    if self.ui == nil then return end
    local cnt = self.boss_list:get_boss_brief_count()
    --显示无boss可击杀
    if cnt == 0 then
        cnt = 1
    end
    self.wrapContentBoss:set_min_index(-cnt + 1);
    self.wrapContentBoss:set_max_index(0)
    self.wrapContentBoss:reset()
    self.scrollViewBoss:reset_position()
end

-- 获取任务大类简字
function MMOTaskTrackUI:GetTaskTypeName(type)
    return _TaskTypeName[type] or ""
end

--刷新界面
function MMOTaskTrackUI:UpdateUi()
    if self.ui == nil then return end
    
end

--刷新某个任务进度
function MMOTaskTrackUI:UpdateTask(task)
    if self.ui == nil then return end
    for b, v in pairs(self.taskItems) do
        if v.task_id == task.task_id then
            self:UpdateTaskItem(b, task);
            break;
        end
    end
end

--刷新任务列表项
function MMOTaskTrackUI:UpdateTaskItem(b, data)
    local item = self.taskItems[b]
    local config = ConfigManager.Get(EConfigIndex.t_task_data,data.task_id)

    -- 未接
    if data.task_state == -1 then
        item.cont1:set_active(false)
        item.cont2:set_active(false)
        item.cont3:set_active(true)

        -- 金色!-'r_tanhao1'
        -- 灰色!-'r_tanhao2'
        -- 金色?-'r_wenhao1'
        -- 灰色?-'r_wenhao2'
        item.cont3_spSymbol:set_sprite_name("r_tanhao1")
        item.cont3_labName:set_text(config.task_name)
        item.cont3_labAccept:set_text("点击接受任务")

        item.cont3_spBoxCllider:set_on_ngui_click(self.bindfunc["on_item_click"])
        item.cont3_spBoxCllider:set_event_value(tostring(data.task_id))
    -- 已接
    else
        -- 倒计时任务
        if data:IsCountdownTask() and data.task_state == 0 then
            item.cont1:set_active(false)
            item.cont2:set_active(true)
            item.cont3:set_active(false)

            item.cont2_labName:set_text(config.task_name)
            item.cont2_labContent:set_text(data:GetNextConditionStr())
            item.cont2_labTime:set_text(string.format(_local.UIText[1], data:GetCountdownTimeStr()))

            -- 记录任务定时器显示的UI组件
            self.timerText[b] = {task=data, lab=item.cont2_labTime};

            item.cont2_spBoxCllider:set_on_ngui_click(self.bindfunc["on_item_click"])
            item.cont2_spBoxCllider:set_event_value(tostring(data.task_id))
        else
            item.cont1:set_active(true)
            item.cont2:set_active(false)
            item.cont3:set_active(false)

            -- 失败-'r_shibai' 
            -- 完成-'r_wancheng' 

            -- 待完成
            if data.task_state == 0 then
                item.cont1_spState:set_sprite_name("")
                item.cont1_labContent:set_text(data:GetNextConditionStr())
            -- 已完成
            elseif data.task_state == 1 then
                item.cont1_spState:set_sprite_name("r_wancheng")
                item.cont1_labContent:set_text(data:GetLastConditionStr())
            -- 失败
            elseif data.task_state == 2 then
                item.cont1_spState:set_sprite_name("r_shibai")
                item.cont1_labContent:set_text(data:GetNextConditionStr())
            end
            -- 名字格式: [环]跑环任务(5/20)
            local nameStr = self:GetTaskTypeName(data.task_type)..config.task_name
            if data:IsLoopMainTask() then
                nameStr = nameStr..data:GetLoopMainValueStr(true);
            end
            item.cont1_spBoxCllider:set_on_ngui_click(self.bindfunc["on_item_click"])
            item.cont1_spBoxCllider:set_event_value(tostring(data.task_id))
            item.cont1_labName:set_text(nameStr)
        end
    end
end

-------------------------------------本地回调-------------------------------------

--任务按钮
function MMOTaskTrackUI:on_btn_task(t)
    -- MMOUiMgr:ShowUi("MMOTaskListUI")
    if self.obj_task:get_active() then
        uiManager:PushUi(EUI.MMOTaskListUI);
    else 
        self:change_tab("task")        
    end
end

--boss列表
function MMOTaskTrackUI:on_btn_boss(t)
    if self.obj_boss:get_active() then
        -- uiManager:PushUi(EUI.BossListUI)
    else 
        self:change_tab("boss")
    end
end

function MMOTaskTrackUI:open_boss_list_ui(t)
    -- uiManager:PushUi(EUI.BossListUI)    
end

--[[切换界面]]
function MMOTaskTrackUI:change_tab(name)
    if name == "task" then
        self.sp_task:set_active(true)
        self.sp_boss:set_active(false)
        self.scrollView:set_active(true)
        self.scrollViewBoss:set_active(false)
    elseif name == "boss" then
        self.sp_task:set_active(false)
        self.sp_boss:set_active(true)
        self.scrollView:set_active(false)
        self.scrollViewBoss:set_active(true)
    end
end

--放弃任务
function MMOTaskTrackUI:on_item_click(name, x, y, go_obj, value)
    local task = g_dataCenter.task:GetTaskById(tonumber(value))
    app.log("任务追踪："..table.tostring(task))
    self:EnableShowEffect(false)
    task:TriggerAction()
end

--初始化列表项
function MMOTaskTrackUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1;

    self.timerText[b] = nil
    if self.taskItems[b] == nil then
        self.taskItems[b] = {}
        self.taskItems[b].self = obj
        self.taskItems[b].cont1 = obj:get_child_by_name("cont1")
        self.taskItems[b].cont2 = obj:get_child_by_name("cont2")
        self.taskItems[b].cont3 = obj:get_child_by_name("cont3")

        self.taskItems[b].cont1_labName      = ngui.find_label(obj, "cont1/lab_task")
        self.taskItems[b].cont1_labContent   = ngui.find_label(obj, "cont1/lab")
        self.taskItems[b].cont1_spState      = ngui.find_sprite(obj, "cont1/sp")        -- 任务状态
        self.taskItems[b].cont1_spBoxCllider = ngui.find_sprite(obj, "cont1/sp_di")     -- 任务状态

        self.taskItems[b].cont2_labName      = ngui.find_label(obj, "cont2/txt")
        self.taskItems[b].cont2_labTime      = ngui.find_label(obj, "cont2/lab_time")
        self.taskItems[b].cont2_labContent   = ngui.find_label(obj, "cont2/lab")
        self.taskItems[b].cont2_spBoxCllider = ngui.find_sprite(obj, "cont2/sp_di")     -- 任务状态

        self.taskItems[b].cont3_labName      = ngui.find_label(obj, "cont3/txt")
        self.taskItems[b].cont3_labAccept    = ngui.find_label(obj, "cont3/lab")
        self.taskItems[b].cont3_spSymbol     = ngui.find_sprite(obj, "cont3/sp_symbol") -- 任务符号
        self.taskItems[b].cont3_spBoxCllider = ngui.find_sprite(obj, "cont3/sp_di")     -- 任务状态
    end

    local item = self.taskItems[b]
	local data = self.taskList[index]
	if data then
        item.task_id = data.task_id
        item.self:set_active(true)
        self:UpdateTaskItem(b, data)
    else
        item.task_id = 0;
    end
end

function MMOTaskTrackUI:on_init_item_boss(obj, b, real_id)
    local index = math.abs(real_id) + 1;
    local cont1 = obj:get_child_by_name("cont1")
    cont1:set_active(false)
    local cont2 = obj:get_child_by_name("cont2")
    cont2:set_active(false)
    --显示无可击杀boss
    if self.boss_list:no_boss_brief() then
        cont1:set_active(true)
        local sp_di = ngui.find_sprite(obj, "cont1/sp_di")
        sp_di:set_on_ngui_click(self.bindfunc["open_boss_list_ui"])
    else
        cont2:set_active(true)
        local sp_di = ngui.find_sprite(obj, "cont2/sp_di")
        sp_di:set_on_ngui_click(self.bindfunc["open_boss_list_ui"])

        local boss_id = self.boss_list:get_boss_brief_data(index) 
        local _config = ConfigManager.Get(EConfigIndex.t_monster_property,boss_id) 
        --等级
        local lbl_level = ngui.find_label(obj, "lab_level")
        lbl_level:set_text("LV." .. _config.level)
        --boss name
        local lbl_name = ngui.find_label(obj, "lab_name")
        lbl_name:set_text(_config.name)
    end        
end

--定时器每秒回调
function MMOTaskTrackUI:on_cd_timer()
    if self:IsShow() then
        for b, data in pairs(self.timerText) do
            data.lab:set_text(string.format(_local.UIText[1], data.task:GetCountdownTimeStr()));
        end
    end
end

function MMOTaskTrackUI:on_click_open_list()
    if self.tween then
        self.tween:play_reverse()
        self.btnSpToOpen:set_active(false)
        self.btnSpToClose:set_active(true)
    end
end

function MMOTaskTrackUI:on_click_close_list()
    if self.tween then
        self.tween:play_foward()
        self.btnSpToOpen:set_active(true)
        self.btnSpToClose:set_active(false)
    end
end

-------------------------------------网络回调-------------------------------------
--任务改变
function MMOTaskTrackUI:on_task_change(ntype, task)
    -- 更新一条单个任务
    if ntype == 2 and task.task_state ~= 1 then
        if task:IsLoopSubTask() then
            self:UpdateTask(task:GetLoopRelatedTask())
        else
            self:UpdateTask(task)
        end
    else
        self:ResetTaskList()
    end
end

function MMOTaskTrackUI:on_boss_change()
    self:ResetBossList()
end
