NewFightUiKill = Class('NewFightUiKill', UiBaseClass);
------------------------------------外部接口---------------------------------
-- 击杀动画
-- data 包含较多参数 主要一个地方调用 所以打包成一个表
-- data.killRole      击杀人的头像
-- data.killedRole    被击杀人的头像
-- data.killNum       规定时间内击杀次数
-- data.killAllNum    一次生命内击杀的总次数
-- data.killIsRole    是击杀的英雄还是塔
-- data.killFlag      是我方击杀还是地方击杀
-- data.killAll       是否团灭
function NewFightUiKill:ShowKillRole(data)
    if data then 
        table.insert(self.killTable, data); 
    end
    if self.killPlaying then 
        return; 
    end
    if not self.ui then
        return;
    end
    if table.getn(FightUI.killTable) == 0 then 
        return; 
    end
    local control = self.control;

    self.killPlaying = true;
    self.killData = self.killTable[1];
    if (self.killData.killIsRole == FightEnum.KILL_TYPE.TOWER) then
        control.sp_kill_bum:set_sprite_name('jishale');
    else
        control.sp_kill_bum:set_sprite_name('jishale');
    end
    if (self.killData.killFlag == 1) then
        control.sp_kill_role_bk:set_sprite_name('touxiangkuang_lan');
        control.sp_killed_role_bk:set_sprite_name('touxiangkuang_hong');
    else
        control.sp_kill_role_bk:set_sprite_name('touxiangkuang_hong');
        control.sp_killed_role_bk:set_sprite_name('touxiangkuang_lan');
    end
    control.sp_kill_role:set_sprite_name(self.killData.killRole);
    control.sp_killed_role:set_sprite_name(self.killData.killedRole);
    if self.ui then
        --app.log("显示");
        self.ui:set_active(true);
    end
    if control.go_killed_role then
        control.go_killed_role:set_active(true);
    end
    control.scaleTweener:play_foward();
    self.killTimer = timer.create(self.bindfunc['FirstCartoonOver'], 1000, 1);
end

-----------------------------------内部接口-------------------------------------
--初始化
function NewFightUiKill:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_kill.assetbundle";
    UiBaseClass.Init(self, data);
end

--初始化数据
function NewFightUiKill:InitData(data)
    UiBaseClass.InitData(self, data);
    self.data = data;
    self.killTable = {};
    self.killPlaying = false;
    self.killData = nil;
end

--注册回调函数
function NewFightUiKill:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['FirstCartoonOver'] = Utility.bind_callback(self, self.FirstCartoonOver);
    self.bindfunc['SecondCartoonOver'] = Utility.bind_callback(self, self.SecondCartoonOver);
    self.bindfunc['ThirdCartoonOver'] = Utility.bind_callback(self, self.ThirdCartoonOver);
    self.bindfunc['FourthCartoonOver'] = Utility.bind_callback(self, self.FourthCartoonOver);
end

--初始化UI
function NewFightUiKill:InitUI(asset_obj)
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

    local control = self.control;
    --[[ 击杀 连杀 毁塔相关显示 ]]
    control.objRoot = self.ui:get_child_by_name("bk");
    control.sp_kill_bum = ngui.find_sprite(control.objRoot, "kill_num");
    control.sp_kill_role = ngui.find_sprite(control.objRoot, "kill_head");
    control.sp_killed_role = ngui.find_sprite(control.objRoot, "killed_head");
    control.sp_kill_role_bk = ngui.find_sprite(control.objRoot, "kill_head_bk");
    control.sp_killed_role_bk = ngui.find_sprite(control.objRoot, "killed_head_bk");
    control.scaleTweener = ngui.find_uitweener(self.ui, self.ui:get_name());
    control.go_killed_role = control.objRoot:get_child_by_name("killed_head_bk");
end
--析构函数
function NewFightUiKill:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
end


-- 规定时间内击杀几个
function NewFightUiKill:FirstCartoonOver()
    if not self.killData or not self.ui then
        return;
    end
    if self.killData.killIsRole == FightEnum.KILL_TYPE.TOWER then
        self:KillReStart();
        return;
    end
    local control = self.control;
    if control.go_killed_role then
        control.go_killed_role:set_active(false);
    end
    control.scaleTweener:reset_to_begining();
    control.sp_kill_bum:set_sprite_name('sha' .. tostring(FightUI.killData.killNum));
    control.scaleTweener:play_foward();
    self.killTimer = timer.create(self.bindfunc['SecondCartoonOver'], 1000, 1);
end
-- 一次生命周期内击杀几个 大杀特杀
function NewFightUiKill:SecondCartoonOver()
    if not self.killData or not self.ui then
        return;
    end
    local control = self.control;
    control.scaleTweener:reset_to_begining();
    if (self.killData.killAllNum >= 4) then
        if (self.killData.killAllNum >= 8) then
            control.sp_kill_bum:set_sprite_name('sha8');
        else
            control.sp_kill_bum:set_sprite_name('sha' .. tostring(self.killData.killAllNum));
        end
        control.scaleTweener:play_foward();
        self.killTimer = timer.create(self.bindfunc['ThirdCartoonOver'], 1000, 1);
    elseif (self.killData.killAll == true) then
        control.sp_kill_bum:set_sprite_name('tuanmie');
        control.scaleTweener:play_foward();
        self.killTimer = timer.create(self.bindfunc['FourthCartoonOver'], 1000, 1);
    else
        self:KillReStart();
    end
end
-- 团灭
function NewFightUiKill:ThirdCartoonOver()
    if not self.killData or not self.ui then
        return;
    end
    local control = self.control;
    control.scaleTweener:reset_to_begining();
    if (self.killData.killAll == true) then
        control.sp_kill_bum:set_sprite_name('tuanmie');
        control.scaleTweener:play_foward();
        self.killTimer = timer.create(self.bindfunc['FourthCartoonOver'], 1000, 1);
    else
        self:KillReStart();
    end
end
-- 重新调用
function NewFightUiKill:FourthCartoonOver()
    self:KillReStart()
end

function NewFightUiKill:KillReStart()
    if not self.killData or not self.ui then
        return;
    end
    local control = self.control;
    for k, v in pairs(self.killTable) do
        if (v == self.killData) then
            table.remove(self.killTable, k);
        end
    end
    control.scaleTweener:reset_to_begining();
    if control.go_killed_role then
        control.go_killed_role:set_active(true);
    end
    if self.ui then
        --app.log("关闭222");
        self.ui:set_active(false);
    end
    self.killPlaying = false;
    self:ShowKillRole();
end