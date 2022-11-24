--任务列表面板
MMOTaskDialogUI = Class('MMOTaskDialogUI',UiBaseClass);
--------------------------------------------------

local _local = {}
_local.UIText = {
    [1] = "(限时%s)"
}

---------------------------- 外部接口 ---------------------------
-- 带检查的ShowUi方法
function MMOTaskDialogUI.ShowUi(task_id)
    -- 不可接可接任务不弹出面板

    if not GuideManager.IsGuideRuning() then
    --[[ 开关
    if g_dataCenter.task:CanAcceptTaskById(task_id) then
    --]]
        g_dataCenter.task:SetCurTask(task_id);
        -- MMOUiMgr:ShowUi("MMOTaskDialogUI");
        uiManager:PushUi(EUI.MMOTaskDialogUI);
        return true;
    else
        return false;
    end
end


---------------------------- 类 ---------------------------
--初始化
function MMOTaskDialogUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/mmo_task/ui_3301_task.assetbundle';
    UiBaseClass.Init(self, data);
end

--初始化数据
function MMOTaskDialogUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.fightManager = FightScene.GetFightManager();
end

--重新开始
function MMOTaskDialogUI:Restart(data)
    UiBaseClass.Restart(self, data);
end

--析构函数
function MMOTaskDialogUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

--注册回调函数
function MMOTaskDialogUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_btn_accept_task'] = Utility.bind_callback(self, self.on_btn_accept_task);
    --self.bindfunc['on_btn_close'] = Utility.bind_callback(self, self.on_btn_close);
end

--注册消息分发回调函数
function MMOTaskDialogUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function MMOTaskDialogUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function MMOTaskDialogUI:ShowNavigationBar()
    return false
end

--寻找ngui对象
function MMOTaskDialogUI:InitUI(asset_obj)
    app.log("MMOTaskDialogUI:InitUI");
    local task_id = g_dataCenter.task:GetCurTask();
    local config = ConfigManager.Get(EConfigIndex.t_task_data,task_id);

    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('mmo_task_dialog_ui');

    -- TODO: 
    path = "animation/content"

    --self.btn_close = ngui.find_button(self.ui, path.."/btn_fork");--关闭按钮
    --self.btn_close:set_on_click(self.bindfunc["on_btn_close"]);

    --接受按钮
    self.btn_accept_task = ngui.find_button(self.ui, path.."/btn_task");
    self.btn_accept_task:set_on_click(self.bindfunc["on_btn_accept_task"]);
    self.btn_accept_task_lab = ngui.find_label(self.ui, path.."/btn_task/lab");

    --左侧人物头像sp
    self.spIcon = ngui.find_texture(self.ui,path.."/texture_human");
    self.spIcon:set_active(false)
    --人物名字lab
    self.labName = ngui.find_label(self.ui,"animation/content/lab_name");
    self.labName:set_active(false)

    --任务名字lab
    self.labTaskName = ngui.find_label(self.ui,path.."/txt1");
    self.labTaskName:set_active(false)

    --任务介绍lab
    self.task_content = ngui.find_label(self.ui,path.."/txt_describe");
    self.task_content:set_active(false)

    self.effect = ngui.find_panel(self.ui, path.."/panel");
    self.effect = self.effect:get_game_object()
    self.effect:set_active(false);
  
	self:UpdateUi();
    app.log("MMOTaskDialogUI:InitUI ok");

end

--显示

function MMOTaskDialogUI:Show()
    if UiBaseClass.Show(self) then
        self:UpdateUi();

    end
end

--隐藏
function MMOTaskDialogUI:Hide()
    if UiBaseClass.Hide(self) then
    end
end

--是否显示特效
function MMOTaskDialogUI:EnableShowEffect(bool)
    self.isShowEffect = bool;
    if self.effect == nil then return end
    if self.saveEffectShow ~= nil then return end
    if GuideManager.IsGuideRuning() then return end
    
    self.effect:set_active(bool)
end

--保存特效显示，供还原使用
function MMOTaskDialogUI:SaveShowEffect()
    self.saveEffectShow = self.isShowEffect
   if self.effect then
        self.effect:set_active(false)
    end
end

--还原特效显示
function MMOTaskDialogUI:RestoreShowEffect()
    if self.saveEffectShow == nil then return end
    self.saveEffectShow = nil
    self:EnableShowEffect(self.isShowEffect)
end

--刷新界面
function MMOTaskDialogUI:UpdateUi()
	if self.ui == nil then return end


    local task_id = g_dataCenter.task:GetCurTask();
    local taskData = g_dataCenter.task:GetTaskById(task_id);
    local config = ConfigManager.Get(EConfigIndex.t_task_data,task_id);
    local npc_config = {}

    showEffect = false
    if taskData == nil then 
       npc_config = ConfigManager.Get(EConfigIndex.t_npc_data,config.accept_npc_id) or {}
       app.log_warning("任务不在推荐列表中:"..config.accept_npc_id..", "..table.tostring(npc_config))
       --self.ui:set_active(false)
       --return 
    else
         if taskData.task_state == 1 then
            npc_config = ConfigManager.Get(EConfigIndex.t_npc_data,config.complete_npc_id) or {}
            self.btn_accept_task_lab:set_text("交任务")

            if not GuideManager.IsGuideRuning() then
                showEffect = true
            end
        elseif taskData.task_state == -1 then 
            npc_config = ConfigManager.Get(EConfigIndex.t_npc_data,config.accept_npc_id) or {}
            self.btn_accept_task_lab:set_text("接任务")
            
            if not GuideManager.IsGuideRuning() then
                showEffect = true
            end
        elseif taskData.task_state == 2 then 
            self.btn_accept_task_lab:set_text("放弃任务")
        else
            self.btn_accept_task_lab:set_text("未完成")
            app.log_warning("----任务状态出问题，没有完成，不该收到该协议。")
        end
    end

    if showEffect then
        self:EnableShowEffect(showEffect)

        local mainUi = uiManager:FindUI(EUI.MMOMainUI)
        if mainUi and mainUi:GetMMOTaskTrackUI() then
            mainUi:GetMMOTaskTrackUI():SaveShowEffect()
            -- mainUi:GetMMOTaskTrackUI():EnableShowEffect(false)
        end
    end

    --npc名称
    local title_name = npc_config.npc_name or ""
    self.labName:set_text(title_name);
    self.labName:set_active(true)

    --npc头像
    local icon_path = npc_config.icon_path or ""
    if icon_path == "" or icon_path == 0 then
        self.spIcon:set_active(false)
    else
        app.log_warning("icon_path="..icon_path)
        self.spIcon:set_texture(icon_path);
        self.spIcon:set_active(true)
    end
    
    
    --任务描述
    local task_des =  g_dataCenter.task:GetAcceptTaskDesById(task_id);
    self.task_content:set_text(task_des);
    self.task_content:set_active(true)

    --任务名称
    local task_name = config.task_name;
    self.labTaskName:set_text(task_name);
    self.labTaskName:set_active(true)

    --app.log("npc名称:"..title_name..",任务描述:"..task_des..",任务名称:"..task_name)


      --奖励物品
    local reward = {}
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
                    table.insert(reward, {id=v.goods_show_number, num=v.goods_number})
                end
            end
        end
    end
    if config.complete_reward > 0 then
        local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,config.complete_reward);
        for i, v in pairs(drop_list) do
            if v.goods_show_number > 0 then
                table.insert(reward, {id=v.goods_show_number, num=v.goods_number})
            end
        end
    end
    --app.log("奖励物品="..table.tostring(reward))

    for i=1,3 do
        --app.log("i="..i)
        local btn_prop = ngui.find_sprite(self.ui, path..'/scroll_view2/panel_list/grid/new_small_card_item'..i);
        if i > #reward then
            btn_prop:set_active(false);
        else
            local sp_small_item = btn_prop:get_game_object()
            local cardInfo, cardType = PublicFunc.CreateCardInfo(reward[i].id, reward[i].num)

            UiSmallItem:new({obj = sp_small_item, cardInfo = cardInfo, delay = 400});
            btn_prop:set_active(true);
        end
    end
end

--接受任务
function MMOTaskDialogUI:on_btn_accept_task()
    if self.isShowEffect then
        self.isShowEffect = false
        local mainUi = uiManager:FindUI(EUI.MMOMainUI)
        if mainUi and mainUi:GetMMOTaskTrackUI() then
            mainUi:GetMMOTaskTrackUI():RestoreShowEffect()
        end
    end

    --self:Hide();
    local task_id = g_dataCenter.task:GetCurTask();
    --app.log("on_btn_accept_task"..task_id)
    local taskData = g_dataCenter.task:GetTaskById(task_id) 
    if taskData == nil then  --没有这个任务在身上
        world_msg.cg_accept_task(task_id)    --接受任务
    else
        if taskData.task_state == 1 then 
            world_msg.cg_complete_task(task_id)  --完成任务 
        elseif taskData.task_state == -1 then 
            world_msg.cg_accept_task(task_id)    --接受任务
        elseif taskData.task_state == 2 then 
            world_msg.cg_giveup_task(task_id)    --放弃任务
        else
            app.log_warning("----非法任务状态，拒绝发送协议")
        end
    end
    
    -- MMOUiMgr:HideUi("MMOTaskDialogUI");
    -- uiManager:PopUi()
    uiManager:RemoveUi(EUI.MMOTaskDialogUI);
end


--关闭
function MMOTaskDialogUI:on_btn_close()
    if self.isShowEffect then
        self.isShowEffect = false
        local mainUi = uiManager:FindUI(EUI.MMOMainUI)
        if mainUi and mainUi:GetMMOTaskTrackUI() then
            mainUi:GetMMOTaskTrackUI():RestoreShowEffect()
        end
    end

    --self:Hide();
    app.log("on_btn_close")
    -- MMOUiMgr:HideUi("MMOTaskDialogUI");
    -- uiManager:PopUi()
    uiManager:RemoveUi(EUI.MMOTaskDialogUI);
end
