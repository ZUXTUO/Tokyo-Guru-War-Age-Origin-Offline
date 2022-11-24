NewFightUiWorldBoss = Class('NewFightUiWorldBoss', UiBaseClass);
--初始化
function NewFightUiWorldBoss:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_worldboss.assetbundle";
    UiBaseClass.Init(self, data);
end

--初始化数据
function NewFightUiWorldBoss:InitData(data)
    UiBaseClass.InitData(self, data);
    self.data = data;
    self.showLock = false;
end

--注册回调函数
function NewFightUiWorldBoss:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['OnBuyEncourage'] = Utility.bind_callback(self, self.OnBuyEncourage);
    self.bindfunc['OnSureBuyEncourage'] = Utility.bind_callback(self, self.OnSureBuyEncourage);
end

--初始化UI
function NewFightUiWorldBoss:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    if self.data.parent then
        self.ui:set_parent(self.data.parent);
        --设置了父节点后需要马上将这个父节点去掉引用  不然会引起其他地方释放不到资源
        self.data.parent = nil;
    else
        self.ui:set_parent(Root.get_root_ui_2d_fight());
    end
    self.ui:set_local_scale(1,1,1);
    self.ui:set_local_position(0,0,0); 
    --ui初始化
    self.control = {}
    leftTopOther = self.control;
    leftTopOther.objBuff = self.ui:get_child_by_name("content");
    leftTopOther.labBuff = ngui.find_label(leftTopOther.objBuff, "lab");
    leftTopOther.btnBuff = ngui.find_button(leftTopOther.objBuff, "sp_di");
    leftTopOther.btnBuff:set_on_click(self.bindfunc['OnBuyEncourage']);
    --boss血条
    -- leftTopOther.objBoss = self.ui:get_child_by_name("content1");
    -- for i = 1, 3 do
    --     leftTopOther["objBossHp"..i] = leftTopOther.objBoss:get_child_by_name("pro_di"..i);
    --     leftTopOther["proBossHp"..i] = ngui.find_progress_bar(leftTopOther["objBossHp"..i], "pro_di"..i)
    --     leftTopOther["labBossHp"..i] = ngui.find_label(leftTopOther["objBossHp"..i], "lab_name");
    -- end

    self:UpdateEncourage();
end
--析构函数
function NewFightUiWorldBoss:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
end
---------------------鼓励-------------------------
function NewFightUiWorldBoss:OnBuyEncourage()
    local worldBossData = g_dataCenter.worldBoss;
    local cf = ConfigManager.Get(EConfigIndex.t_world_boss_system,worldBossData:GetBossInfo());
    local vipData = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip)
    if cf then
        if worldBossData.insprireTimes >= g_dataCenter.player:GetMaxBuyInspireTimes() then
            HintUI.SetAndShow(EHintUiType.zero, "当前鼓舞次数已经达到最大值。");
            return;
        end
        local startInsprireTimes = g_dataCenter.player:GetStartInspireTimes()
        local costCry = cf.inspire_cost[worldBossData.insprireTimes-startInsprireTimes+1] or cf.inspire_cost[#cf.inspire_cost];
        local btn1Data = {str="确定", func = self.bindfunc['OnSureBuyEncourage']};
        local btn2Data = {str="取消"};
        local str = string.format("是否花费%d钻石使攻击提升%d%%？", costCry, cf.inspire_add);
        HintUI.SetAndShow(EHintUiType.two, str, btn1Data, btn2Data);
    else
        app.log_warning("世界boss id错误  id="..tostring(worldBossData:GetBossInfo()));
    end
end
function NewFightUiWorldBoss:OnSureBuyEncourage()
    local worldBossData = g_dataCenter.worldBoss;
    local cf = ConfigManager.Get(EConfigIndex.t_world_boss_system,worldBossData:GetBossInfo());
    if cf then
        local crystal = PropsEnum.GetValue(IdConfig.Crystal);
        if crystal < cf.inspire_add then
            HintUI.SetAndShow(EHintUiType.zero, "您的钻石不足!");
        else
            msg_world_boss.cg_world_boss_buy_inspire(0);
        end
    end
end
function NewFightUiWorldBoss:UpdateEncourage()
    if self.control == nil then
        return
    end
    local leftTopOther = self.control;
    local worldBossData = g_dataCenter.worldBoss;
    local cf = ConfigManager.Get(EConfigIndex.t_world_boss_system,worldBossData:GetBossInfo());
    if cf then
        local str = string.format("攻击加成%d%%", worldBossData.insprireTimes * cf.inspire_add);
        leftTopOther.labBuff:set_text(str);
    end
end
--------------世界boss血条----------
-- function NewFightUiWorldBoss:UpdateWorldBossBlood()
--     local rightTopOther = self.control;
--     if not rightTopOther or not rightTopOther.objBoss:get_active() then
--         return;
--     end
--     local npcList = g_dataCenter.fight_info.npc_list[ENUM.ECamp.Enemy];
--     local index = 1;
--     if npcList then
--         for k, v in pairs(npcList) do
--             if index > 3 then
--                 break;
--             end
--             local npc = ObjectManager.GetObjectByName(v);
--             if npc and npc:IsBoss() then
--                 rightTopOther["objBossHp"..index]:set_active(true);
--                 local maxBlood = npc:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
--                 local curBlood = npc:GetPropertyVal(ENUM.EHeroAttribute.cur_hp);
--                 rightTopOther["proBossHp"..index]:set_value(curBlood / maxBlood);
--                 rightTopOther["labBossHp"..index]:set_text(tostring(npc.config.name));
--                 index = index + 1;
--             end
--         end
--         while index <= 3 do
--             rightTopOther["objBossHp"..index]:set_active(false);
--             index = index + 1;
--         end
--     end
-- end