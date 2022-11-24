




---------------------  废弃 -------------------------------





UiRevive = Class("UiRevive", UiBaseClass);
--初始化
function UiRevive:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/fight/ui_823_fight_resurgence.assetbundle';
    UiBaseClass.Init(self, data);
end

--重新开始
function UiRevive:Restart(data)
    self.stop_update = false;
    UiBaseClass.Restart(self, data);
end

--初始化数据
function UiRevive:InitData(data)
    UiBaseClass.InitData(self, data);
end

--析构函数
function UiRevive:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.begin_time = nil;
end

--注册回调函数
function UiRevive:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_btn_maincity_revive'] = Utility.bind_callback(self,self.on_btn_maincity_revive);
    self.bindfunc['on_btn_immediate_revive'] = Utility.bind_callback(self,self.on_btn_immediate_revive);
    self.bindfunc['gc_btn_immediate_revive'] = Utility.bind_callback(self,self.gc_btn_immediate_revive);
end

--注册消息分发回调函数
function UiRevive:MsgRegist()
    UiBaseClass.RegistFunc(self);
    PublicFunc.msg_regist(msg_fight.gc_hero_relive_immediately,self.bindfunc['gc_btn_immediate_revive']);
end

--注销消息分发回调函数
function UiRevive:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_fight.gc_hero_relive_immediately,self.bindfunc['gc_btn_immediate_revive']);
end

--寻找ngui对象
function UiRevive:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name('ui_revive');
    self.cont = {};
    self.btn = {};
    --安全复活
    self.cont[1] = self.ui:get_child_by_name("centre_other/cont1");
    self.lab_time = ngui.find_label(self.ui, "centre_other/cont1/lab_time");
    self.btn[1] = ngui.find_button(self.ui, "centre_other/cont1/sp_safety");
    self.btn[1]:set_on_click(self.bindfunc["on_btn_maincity_revive"]);
    --玩法复活
    self.cont[2] = self.ui:get_child_by_name('centre_other/cont2');
    self.cont[2]:set_active(false);
    --完美复活
    self.cont[3] = self.ui:get_child_by_name('centre_other/cont3');
    self.lab1 = ngui.find_label(self.ui, "centre_other/cont3/txt");
    self.lab2 = ngui.find_label(self.ui, "centre_other/cont3/lab");
    self.sp_crystal = ngui.find_sprite(self.ui, "centre_other/cont3/sp_crystal");
    self.btn[3] = ngui.find_button(self.ui, "centre_other/cont3/sp_safety");
    self.btn[3]:set_on_click(self.bindfunc["on_btn_immediate_revive"]);
    self:UpdateUi();
    self.begin_time = system.time();
end

function UiRevive:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return
    end
    self.max_time = 10;
    self.lab_time:set_text("[FFB400FF]"..self.max_time.."秒[-]后自动执行");

    local vip_level = g_dataCenter.player.vip;
    local free_times = 0;
    local vip_data = g_dataCenter.player:GetVipData();
    if vip_data then
        free_times = vip_data.free_relive_num;
    end
    local used_times = g_dataCenter.player_flag[GuideManager.EventTag.immediatelyReliveTimes].value;
    self.remain_free_times = free_times - used_times;
    if self.remain_free_times > 0 then
        self.lab1:set_text("剩余免费次数"..tostring(self.remain_free_times));
        self.lab2:set_active(false);
        self.sp_crystal:set_active(false);
    else
        local times = 1 - self.remain_free_times;
        local len = ConfigManager.GetDataCount(EConfigIndex.t_relive_cost)
        if times > len then
            times = len;
        end
        self.need_crystal = ConfigManager.Get(EConfigIndex.t_relive_cost,times).relive_cost;
        self.lab1:set_text("原地满血复活");
        self.lab2:set_text("消耗[FFB400FF]"..tostring(self.need_crystal).."[-]");
        self.lab2:set_active(true);
        self.sp_crystal:set_active(true);
    end
end

function UiRevive:Update(dt)
    if not UiBaseClass.Update(self,dt) then return end
    if self.stop_update then return end
    if not self.begin_time then return end
    local cur_time = system.time();
    if cur_time == self.begin_time then return end
    local use_time = cur_time - self.begin_time;
    if use_time >= self.max_time then
        self.stop_update = true;
        -- uiManager:PopUi();
        return
    end
    self.lab_time:set_text("[FFB400FF]"..(self.max_time - use_time).."秒[-]后自动执行");
end

--主城复活
function UiRevive:on_btn_maincity_revive()

end

--原地复活
function UiRevive:on_btn_immediate_revive()
    msg_fight.cg_hero_relive_immediately()
    --uiManager:PopUi();
end

function UiRevive:gc_btn_immediate_revive(result)
    if PublicFunc.GetErrorString( result, true ) then
        self.stop_update = true;
    end
end

function UiRevive:ShowNavigationBar()
    return false
end

function UiRevive:Close()
    if uiManager:GetCurScene() == self then
        uiManager:PopUi()
    end
end