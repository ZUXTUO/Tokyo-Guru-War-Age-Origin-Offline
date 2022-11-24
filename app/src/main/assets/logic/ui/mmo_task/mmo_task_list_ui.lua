--任务列表面板
MMOTaskListUI = Class('MMOTaskListUI',UiBaseClass);
--------------------------------------------------

local _MaxTaskTypeCount = 8    -- 任务大类个数

local _TaskTypeName = {
    [0] = "主线",
    [1] = "活动",
    [2] = "支线",
    [3] = "每日",
    [4] = "跑环",
}

local _local = {}

_local.UIText = {
    [1] = "接任务",
    [2] = "自动寻路",
    [3] = "交任务",
    [4] = "放弃任务",
}

--初始化
function MMOTaskListUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/mmo_task/ui_3304_task.assetbundle';
    UiBaseClass.Init(self, data);
end

--初始化数据
function MMOTaskListUI:InitData(data)
    UiBaseClass.InitData(self, data);

    -- 
    self.taskList = nil     -- 左侧任务列表，动态插入
    self.curTaskId = 0      -- 当前选中的任务id

end

function MMOTaskListUI:Restart(data)
    UiBaseClass.Restart(self, data)
end

--显示函数
function MMOTaskListUI:Show()
    UiBaseClass.Show(self)
end

--隐藏函数
function MMOTaskListUI:Hide()
    UiBaseClass.Hide(self);
end

--销毁函数
function MMOTaskListUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.taskList = nil
    self.awardList = nil
    self.listData = nil

    self:ClearAwardItems()

    if self.taskTimer then
        timer.stop(self.taskTimer)
        self.taskTimer = nil
    end
    self:StopTimerCheck();
end

--回收奖励列表资源
function MMOTaskListUI:ClearAwardItems()
    if self.awardItems then
        for k, v in pairs(self.awardItems) do
            v:DestroyUi()
        end
        self.awardItems = nil
    end
end

--注册回调函数
function MMOTaskListUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_task_item'] = Utility.bind_callback(self, self.on_click_task_item);
    self.bindfunc['on_click_btn_task'] = Utility.bind_callback(self, self.on_click_btn_task);
    self.bindfunc['on_click_btn_close'] = Utility.bind_callback(self, self.on_click_btn_close);
    self.bindfunc['on_task_change'] = Utility.bind_callback(self, self.on_task_change);
    self.bindfunc['on_cd_timer'] = Utility.bind_callback(self, self.on_cd_timer);
    self.bindfunc['TimerCheck'] = Utility.bind_callback(self, self.TimerCheck);
end

--注册消息分发回调函数
function MMOTaskListUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(world_msg.gc_sync_single_task, self.bindfunc["on_task_change"])
    PublicFunc.msg_regist(world_msg.gc_add_referrer_task, self.bindfunc["on_task_change"])
end

--注销消息分发回调函数
function MMOTaskListUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(world_msg.gc_sync_single_task, self.bindfunc["on_task_change"])
    PublicFunc.msg_unregist(world_msg.gc_add_referrer_task, self.bindfunc["on_task_change"])
end

function MMOTaskListUI:ShowNavigationBar()
    return false
end

--寻找ngui对象
function MMOTaskListUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('mmo_task_list_ui');

    -- 启动定时器
    self.taskTimer = timer.create(self.bindfunc["on_cd_timer"], 1000, -1)
    
    local path = "left_other/animation/scroll_view/panel_list"
    local item = nil
    self.taskList = {}
    self.table = ngui.find_table(self.ui, path.."/table")
    for i=1, _MaxTaskTypeCount do
        self.taskList[i] = {}

        if item == nil then
            item = self.ui:get_child_by_name("content (1)")
            -- 保存grid item，用来动态创建clone列表项
            self.tempGridItem = item:get_child_by_name("cont1")
            self.tempGridItem:set_parent(nil)
            self.tempGridItem:set_active(false)
        else
            item = item:clone()
        end

        item:set_name("task_item_"..i)
        self.taskList[i].self = item
        self.taskList[i].name = ngui.find_label(item, "txt")
        self.taskList[i].grid = {}
        self.taskList[i].grid.items = {}
        self.taskList[i].grid.self = ngui.find_grid(item, "grid")
    end

    path = "centre_other/animation/content/scroll_view/panel_list"
    self.pnTaskDes = ngui.find_panel(self.ui, path)
    -- 任务描述
    self.labDesContent = ngui.find_label(self.ui, path.."/lab")
    -- 跑环任务进度
    self.labLoopProgress = ngui.find_label(self.ui, path.."/txt3")

    -- 完成条件
    self.conditionList = ngui.find_grid(self.ui, path.."/grid1")
    self.conditionItems = {}
    for i=1, 10 do
        self.conditionItems[i] = ngui.find_label(self.ui, path.."/grid1/cont"..i.."/txt")
        if self.conditionItems[i] == nil then
            break;
        end
    end
    -- 限时完成
    self.labCdTime = ngui.find_label(self.ui, path.."/content/txt")
    -- 任务有效期
    self.labDuration = ngui.find_label(self.ui, path.."/content/lab")

    -- 任务奖励列表
    self.awardList = ngui.find_grid(self.ui, path.."/grid2")
    self.awardItems = {}
    for i=1, 10 do
        local smallItem = ngui.find_sprite(self.ui, path.."/grid2/new_small_card_item"..i)
        if smallItem == nil then
            break;
        end
        self.awardItems[i] = UiSmallItem:new({obj=smallItem:get_game_object()})
    end

    -- 任务按钮
    path = "centre_other/animation/content"
    local btnTask = ngui.find_button(self.ui, path.."/btn_task")
    btnTask:set_on_click(self.bindfunc["on_click_btn_task"])
    self.labBtnTask = ngui.find_label(self.ui, path.."/btn_task/txt")

    -- 关闭按钮
    local btnClose = ngui.find_button(self.ui, path.."/btn_fork")
    btnClose:set_on_click(self.bindfunc["on_click_btn_close"])

    -- 

    -- 
	self:UpdateUi();
end

-- 获取任务大类名称
function MMOTaskListUI:GetTaskTypeName(type)
    return _TaskTypeName[type] or ""
end

-- 更新一条任务列表
function MMOTaskListUI:UpdateTaskItem(i, j, task)
    if self.ui == nil or self.listData == nil then return end

    if task and (i == nil or j == nil) then
        for i1=1, _MaxTaskTypeCount do
            local itemData = self.listData[i1]
            if itemData ~= nil then
                for j1, t in pairs(itemData.data) do
                    if t.task_id == task.task_id then
                        i = i1;
                        j = j1;
                        break;
                    end
                end
            end
        end
    end
    
    if i == nil or j == nil then return end

    local gridItem = nil
    if self.taskList[i].grid.items[j] == nil then
        gridItem = self.tempGridItem:clone()
        gridItem:set_parent(self.taskList[i].grid.self:get_game_object())
        gridItem:set_active(true)
        gridItem:set_local_scale(1, 1, 1)
        self.taskList[i].grid.items[j] = {self=gridItem, select=nil}
    else
        gridItem = self.taskList[i].grid.items[j].self
    end

    -- 刷新任务列表项
    local labName = ngui.find_label(gridItem, "lab_task")
    local spTaskState = ngui.find_sprite(gridItem, "sp1")
    local spComplete = ngui.find_sprite(gridItem, "sp_2")
    local spBoxClider = ngui.find_sprite(gridItem, "sp_bk")
    local spSelect = ngui.find_sprite(gridItem, "sp_shine")
    self.taskList[i].grid.items[j].select = spSelect;

    spBoxClider:set_on_ngui_click(self.bindfunc["on_click_task_item"])
    spBoxClider:set_event_value(tostring(task.task_id))
    
    -- 任务名称
    local config = ConfigManager.Get(EConfigIndex.t_task_data,task.task_id)
    labName:set_text(config.task_name)

    -- 选中效果
    if self.curTaskId == task.task_id then
        spSelect:set_active(true)
    else
        spSelect:set_active(false)
    end
    
    -- 金色!-'r_tanhao1'
    -- 灰色!-'r_tanhao2'
    -- 金色?-'r_wenhao1'
    -- 灰色?-'r_wenhao2'
    -- 失败-'r_shibai' 
    -- 完成-'r_wancheng' 

    -- 未接
    if task.task_state == -1 then
        spTaskState:set_sprite_name("r_tanhao1")
        spComplete:set_sprite_name("")
    -- 未完成
    elseif task.task_state == 0 then
        spTaskState:set_sprite_name("r_wenhao2")
        spComplete:set_sprite_name("")
    -- 已完成
    elseif task.task_state == 1 then
        spTaskState:set_sprite_name("r_wenhao1")
        spComplete:set_sprite_name("r_wancheng")
    -- 失败
    elseif task.task_state == 2 then
        spTaskState:set_sprite_name("r_wenhao2")
        spComplete:set_sprite_name("r_shibai")
    end
    
end

function MMOTaskListUI:StartTimerCheck()
    self:StopTimerCheck()
    self.timerid = timer.create(self.bindfunc['TimerCheck'], 60, 50)
end

function MMOTaskListUI:StopTimerCheck()
    if self.timerid then
        timer.stop(self.timerid)
        self.timerid = nil
    end
end

-- 检查修正任务子列表坐标
function MMOTaskListUI:TimerCheck()
    if self.ui == nil then return end

    local need_fix = false
    for i=1, _MaxTaskTypeCount do
        local itemData = self.listData[i]
        if itemData ~= nil then
            local x, y, z = self.taskList[i].grid.self:get_position()
            if y ~= 0 then
                self.taskList[i].grid.self:set_position(0,0,0)
                need_fix = true
            end
        end
    end
    if need_fix then
        self.table:reposition_now()
    end
end

-- 任务列表面板
function MMOTaskListUI:UpdateTaskList()
    if self.ui == nil then return end

    -- 重新加载任务列表
    if not g_dataCenter.task:GetTaskById(self.curTaskId) then
        self.curTaskId = 0
    end

    self.listData = g_dataCenter.task:GetListByType()
    for i=1, _MaxTaskTypeCount do
        local itemData = self.listData[i]
        if itemData ~= nil then
            self.taskList[i].self:set_active(true)
            self.taskList[i].name:set_text(self:GetTaskTypeName(itemData.task_type))
            for j, task in pairs(itemData.data) do
                -- 指定一个当前任务
                if self.curTaskId == 0 then
                    self.curTaskId = task.task_id
                end

                self:UpdateTaskItem(i, j, task);
            end
            -- 去掉多余项
            for j=#itemData.data + 1, #self.taskList[i].grid.items do
                local gridItem = self.taskList[i].grid.items[j].self
                gridItem:set_parent(nil)
                gridItem:set_active(false)
            end

            self.taskList[i].grid.self:set_max_line(#itemData)
            self.taskList[i].grid.self:reposition_now()
        else
            self.taskList[i].self:set_active(false)
        end
    end

    self.table:reposition_now()
end

-- 任务详情面板
function MMOTaskListUI:UpdateTaskInfo()
    if self.ui == nil then return end
    if self.curTaskId == 0 then 
        self.pnTaskDes:set_active(false)
        return;
    else
        self.pnTaskDes:set_active(true)
    end

    local task = g_dataCenter.task:GetTaskById(self.curTaskId)
    local config = ConfigManager.Get(EConfigIndex.t_task_data,self.curTaskId)
    if config and task then
        -- 任务描述
        self.labDesContent:set_text(task:GetAcceptTaskDes())
        -- 跑环进度
        self.labLoopProgress:set_text(task:GetLoopMainValueStr())

        -- 任务倒计时
        if task:IsCountdownTask() then
            self.labCdTime:set_text(task:GetCountdownTimeStr());
        else
            self.labCdTime:set_text("");
        end
        -- TODO 有效时间
        -- self.labDuration:set_text("有效时间-有效时间")
        self.labDuration:set_text("")

        -- 完成条件
        local strArray = task:GetConditionStrArray()
        for i, v in ipairs(self.conditionItems) do
            if strArray[i] then
                v:set_text(strArray[i])
            else
                v:set_text("")
            end
        end

        --奖励物品
        local awards = {}
        -- 初始英雄差异奖励
        local init_hero_index = nil
        local first_choose_role = g_dataCenter.player.first_choose_role
        -- for i, v in pairs(gd_player_select_role) do
        for i, v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_player_select_role)) do
            if v.role_id == first_choose_role then
                init_hero_index = i
                break;
            end
        end
        if init_hero_index then
            local config_init_reward = config["complete_profession_reward_"..init_hero_index]
            if config_init_reward and config_init_reward ~= 0 then
                local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,config_init_reward);
                for i, v in pairs(drop_list) do
                    if v.goods_show_number > 0 then
                        table.insert(awards, {id=v.goods_show_number, num=v.goods_number})
                    end
                end
            end
        end
        
        -- 跑环奖励
        if task:IsLoopMainTask() then
            local loop_sub_task = g_dataCenter.task:GetTaskById(task:GetLoopRelatedId())
            -- 当前有子任务
            if loop_sub_task then
                -- 子任务完成 阶段奖励检查
                if loop_sub_task.task_state == 1 then
                    local complete_value = task.condition_list[1].complete_value
                    local player_level = g_dataCenter.player.level
                    local drop_id = nil
                    complete_value = complete_value + 1
                    for i, v in pairs(ConfigManager.Get(EConfigIndex.t_task_loop_reward,task.task_id)) do
                        if complete_value == v.time then
                            if player_level >= v.min_level and player_level <= v.max_level then
                                drop_id = v.reward_drop;
                            end
                            break;
                        end
                    end
                    if drop_id then
                        local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,drop_id);
                        for i, v in pairs(drop_list) do
                            if v.goods_show_number > 0 then
                                table.insert(awards, {id=v.goods_show_number, num=v.goods_number})
                            end
                        end
                    end
                end         

                -- 子任务完成奖励
                local sub_config = ConfigManager.Get(EConfigIndex.t_task_data,loop_sub_task.task_id)
                if sub_config.complete_reward > 0 then
                    local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,sub_config.complete_reward);
                    for i, v in pairs(drop_list) do
                        if v.goods_show_number > 0 then
                            table.insert(awards, {id=v.goods_show_number, num=v.goods_number})
                        end
                    end
                end
            -- 主任务完成奖励（子任务已全部提交）
            else
                if config.complete_reward > 0 then
                    local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,config.complete_reward);
                    for i, v in pairs(drop_list) do
                        if v.goods_show_number > 0 then
                            table.insert(awards, {id=v.goods_show_number, num=v.goods_number})
                        end
                    end
                end
            end
        -- 其他类型
        else
            -- 完成奖励
            if config.complete_reward > 0 then
                local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,config.complete_reward);
                for i, v in pairs(drop_list) do
                    if v.goods_show_number > 0 then
                        table.insert(awards, {id=v.goods_show_number, num=v.goods_number})
                    end
                end
            end
        end

        local merge = {}
        local temp = {}
        -- 奖励合并
        for i, v in pairs(awards) do
            if PropsEnum.IsItem(v.id) or PropsEnum.IsVaria(v.id) then
                if merge[v.id] == nil then
                    table.insert(temp, v)
                    merge[v.id] = #temp
                else
                    local idx = merge[v.id]
                    temp[idx].num = temp[idx].num + v.num;
                end
            else
                table.insert(temp, v)
            end
        end
        awards = temp

        -- 任务奖励
        for i, v in ipairs(self.awardItems) do
            local award = awards[i]
            if awards[i] then
                local cardInfo, cardType = PublicFunc.CreateCardInfo(awards[i].id, awards[i].num)
                v:SetData(cardInfo)
            else
                v:SetData(nil)
            end
        end

        -- 未接
        if task.task_state == -1 then
            self.labBtnTask:set_text(_local.UIText[1])
        -- 未完成
        elseif task.task_state == 0 then
            self.labBtnTask:set_text(_local.UIText[2])
        -- 已完成
        elseif task.task_state == 1 then
            self.labBtnTask:set_text(_local.UIText[3])
        -- 失败
        elseif task.task_state == 2 then
            self.labBtnTask:set_text(_local.UIText[4])
        end
    end
end

--刷新界面
function MMOTaskListUI:UpdateUi()
	if self.ui == nil then return end

    -- 任务列表
    self:UpdateTaskList()
    -- 任务详情
    self:UpdateTaskInfo()

    self:StartTimerCheck()
end

-------------------------------------本地回调-------------------------------------
--点击任务列表项
function MMOTaskListUI:on_click_task_item(name, x, y, go_obj, value)
    local task_id = tonumber(value) or 0;
    self.curTaskId = task_id;

    -- 改变选中效果
    for i=1, _MaxTaskTypeCount do
        if self.listData[i] then
            for j, task in pairs(self.listData[i].data) do
                 -- 选中效果
                if task_id == task.task_id then
                    self.taskList[i].grid.items[j].select:set_active(true)
                else
                    self.taskList[i].grid.items[j].select:set_active(false)
                end
                
            end
        end
    end
    self:UpdateTaskInfo()
end

--任务按钮
function MMOTaskListUI:on_click_btn_task(t)
    if self.curTaskId == 0 then return end
    local task = g_dataCenter.task:GetTaskById(self.curTaskId)
    task:TriggerAction()
    -- MMOUiMgr:HideUi("MMOTaskListUI");
    -- uiManager:PopUi()
    uiManager:RemoveUi(EUI.MMOTaskListUI);
end

--关闭按钮
function MMOTaskListUI:on_click_btn_close(t)
    -- MMOUiMgr:HideUi("MMOTaskListUI");
    -- uiManager:PopUi()
    uiManager:RemoveUi(EUI.MMOTaskListUI)
end

--定时器每秒回调
function MMOTaskListUI:on_cd_timer()
    if self.curTaskId > 0 and self:IsShow() then
        local task = g_dataCenter.task:GetTaskById(self.curTaskId);
        if task then
            self.labCdTime:set_text(task:GetCountdownTimeStr());
        end
    end
end

-------------------------------------网络回调-------------------------------------
--任务变化
function MMOTaskListUI:on_task_change(ntype, task)
    if ntype == 2 then
        if task.state == 1 then
            self:UpdateUi()
        else
            if task:IsLoopSubTask() then
                task = g_dataCenter.task:GetTaskById(task:GetLoopRelatedId())
            end
            self:UpdateTaskItem(nil, nil, task)
            self:UpdateTaskInfo()
        end
    else
        self:UpdateUi()
    end
end
