NewFightUiTip = Class('NewFightUiTip', UiBaseClass);
-----------------外部接口--------------------------------
function NewFightUiTip:ShowTips(str, time)
    self.data.str = str;
    self.data.time = time;
    self:UpdateUi();
end
-----------------内部接口----------------------
--初始化
function NewFightUiTip:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/new_fight_ui_tip.assetbundle";
    UiBaseClass.Init(self, data);
end

--初始化数据
function NewFightUiTip:InitData(data)
    UiBaseClass.InitData(self, data);
    self.data = data;
    self.startTime = nil;
end

--注册回调函数
function NewFightUiTip:RegistFunc()
    UiBaseClass.RegistFunc(self);
end

--初始化UI
function NewFightUiTip:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    if self.data.parent then
        self.ui:set_parent(self.data.parent);
        --设置了父节点后需要马上将这个父节点去掉引用  不然会引起其他地方释放不到资源
        self.data.parent = nil;
    else
        self.ui:set_parent(Root.get_root_ui_2d_fight());
    end
    self.ui:set_local_position(0,0,0);
    self.ui:set_local_scale(1,1,1);
    
    --ui初始化
    self.control = {}
    self.control.lab = ngui.find_label(self.ui, "lab");
    self:UpdateUi(); 
end
function NewFightUiTip:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    if self.data.str then
        self.control.lab:set_text(self.data.str);
    end
    self.startTime = os.time();
    self:Show();
end
--析构函数
function NewFightUiTip:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
end
--帧更新
function NewFightUiTip:Update(dt)
    if not UiBaseClass.Update(self, dt) then
        return;
    end
    if self:IsShow() then
        self.data.time = self.data.time or 0;
        if os.time() - self.startTime > self.data.time then
            self:Hide();
        end
    end
end