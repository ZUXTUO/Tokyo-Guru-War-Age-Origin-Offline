NewFightUiTimer = Class('NewFightUiTimer', UiBaseClass);

local resPath =
{
    countUp = "assetbundles/prefabs/ui/new_fight/new_fight_ui_timer.assetbundle",
    countDown = "assetbundles/prefabs/ui/new_fight/new_fight_left_time.assetbundle",
}

function NewFightUiTimer.GetResList()
    return resPath
end

--初始化
function NewFightUiTimer:Init(data)
    local isCountDown = FightScene.GetFightManager():IsCountDown()
    if isCountDown then
        self.pathRes = resPath.countDown
    else
        self.pathRes = resPath.countUp
    end

    UiBaseClass.Init(self, data);
end

--初始化数据
function NewFightUiTimer:InitData(data)
    UiBaseClass.InitData(self, data);
    self.data = data;
    self.showLock = false;
end

--注册回调函数
function NewFightUiTimer:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['CountTime'] = Utility.bind_callback(self, self.CountTime);
end

--初始化UI
function NewFightUiTimer:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_name("NewFightUiTimer")

    if self.data.parent then
        self.ui:set_parent(self.data.parent);
        --设置了父节点后需要马上将这个父节点去掉引用  不然会引起其他地方释放不到资源
        self.data.parent = nil;
    else
        self.ui:set_parent(Root.get_root_ui_2d_fight());
    end
    self.ui:set_local_scale(1,1,1);
    self.ui:set_local_position(0,0,0); 

    -- local ct = GetMainUI():GetComponent(EMMOMainUICOM.MainUITeamCanChange);
    -- if ct then
    --     local backsp = ngui.find_sprite(self.ui, 'sp_di')
    --     local h = backsp:get_height() or 0
    --     ct:SetLocalPosition(0, -h, 0);
    -- end
    --ui初始化
    self.control = {}
    local control = self.control;
    control.labTime = ngui.find_label(self.ui, "lab_time");

    local time = FightManager.GetFightTime();
    local str = TimeAnalysis.analysisSec_2(time, true);
    control.labTime:set_text(str);
    --self.timerUpdate = timer.create(self.bindfunc['CountTime'], 1000, -1);
end
--析构函数
function NewFightUiTimer:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
    -- if self.timerUpdate then
    --     timer.stop(self.timerUpdate);
    --     self.timerUpdate = nil;
    -- end
end

-- -- 一秒更新一次
-- function NewFightUiTimer:CountTime()
--     if not self.ui then
--         return;
--     end
--     local control = self.control;
--     local time = FightManager.GetFightTime();
--     local str = TimeAnalysis.analysisSec_2(time, true);
--     control.labTime:set_text(str);
-- end

function NewFightUiTimer:Update()
    if not self.ui then
        return;
    end
    local time = FightManager.GetFightTime();
    if time == self.hasShowTime then return end
    self.hasShowTime = time

    local control = self.control;
    local str = TimeAnalysis.analysisSec_2(time, true);
    control.labTime:set_text(str);
end
