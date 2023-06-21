NewFightUiDescription = Class('NewFightUiDescription', UiBaseClass);
------------------------------外部接口-------------------------
--  str=""  字符串
--  time=0  显示时间
function NewFightUiDescription:ShowTipLab(str,time)
    self.data.str = str;
    self.data.time = time;
    if not self.ui then
        return;
    end
    local centerControl = self.control;
    if str and str ~= 0 then
        centerControl.labCenterLab:set_text(tostring(str));
        centerControl.objRoot:set_active(true);
        timer.create(self.bindfunc['HideTipLab'],time*1000,1);
    end
end
---------------------------------内部接口-----------------------------------
--初始化
--data = 
--{
--  parent=nil 父节点
--  str=""  字符串
--  time=0  显示时间
--}
function NewFightUiDescription:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_description.assetbundle";
    UiBaseClass.Init(self, data);
end

--初始化数据
function NewFightUiDescription:InitData(data)
    UiBaseClass.InitData(self, data);
    self.data = data;
    self.showLock = false;
end
--注册回调函数
function NewFightUiDescription:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['HideTipLab'] = Utility.bind_callback(self, self.HideTipLab);
end
--初始化UI
function NewFightUiDescription:InitUI(asset_obj)
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
    local centerControl = self.control;
    centerControl.objRoot = self.ui:get_child_by_name("cont_gao_su_zu_ji");
    centerControl.objRoot:set_active(false);
    centerControl.labCenterLab = ngui.find_label(centerControl.objRoot,"txt2");

    self:ShowTipLab(self.data.str, self.data.time);
end
--析构函数
function NewFightUiDescription:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
end

function NewFightUiDescription:HideTipLab()
    if not self.ui then
        return;
    end
    local centerControl = self.control;
    centerControl.objRoot:set_active(false);
end