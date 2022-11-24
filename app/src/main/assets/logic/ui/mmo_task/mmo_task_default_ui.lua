--任务列表面板
MMOTaskDefaultUI = Class('MMOTaskDefaultUI',UiBaseClass);
--------------------------------------------------

--初始化
function MMOTaskDefaultUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/mmo_task/mmo_task_track.assetbundle';
    UiBaseClass.Init(self, data);
end

--初始化数据
function MMOTaskDefaultUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

--重新开始
function MMOTaskDefaultUI:Restart(data)
    UiBaseClass.Restart(self, data);
end

--析构函数
function MMOTaskDefaultUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

--注册回调函数
function MMOTaskDefaultUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_init_item'] = Utility.bind_callback(self, self.on_init_item);
end

--注册消息分发回调函数
function MMOTaskDefaultUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function MMOTaskDefaultUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

--寻找ngui对象
function MMOTaskDefaultUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name('mmo_task_default_ui');
    
	-- TODO

	self:UpdateUi();
end

--刷新界面
function MMOTaskDefaultUI:UpdateUi()
	if self.ui == nil then return end
end

--初始化列表项
function MMOTaskDefaultUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1;
    
end
