UiMap = Class('UiMap',UiBaseClass);

--------------------------------------------------
--初始化
function UiMap:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/map/ui_3501_map.assetbundle";
    UiBaseClass.Init(self, data);
end

--重新开始
function UiMap:Restart(data)
    self.cur_index = 1;
    UiBaseClass.Restart(self, data);
end

--初始化数据
function UiMap:InitData(data)
    UiBaseClass.InitData(self, data);
    self.childMap = {};
end

--析构函数
function UiMap:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.cur_index = 1;
    for k,v in pairs(self.childMap) do
        v:DestroyUi();
    end
    self.childMap = {};
    if self.currentPage then
        self.currentPage:DestroyUi();
        self.currentPage = nil;
    end
end

--显示ui
function UiMap:Show()
    UiBaseClass.Show(self);
end

--隐藏ui
function UiMap:Hide()
    UiBaseClass.Hide(self);
end

--注册回调函数
function UiMap:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_btn_change"] = Utility.bind_callback(self, self.on_btn_change)
end

--注册消息分发回调函数
function UiMap:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiMap:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

--初始化UI
function UiMap:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('ui_map');

    self.btn_close = ngui.find_button(self.ui, "centre_other/animation/content/btn_fork");
	if self.btn_close ~= nil then 
		self.btn_close:set_on_click(self.bindfunc['on_close']);
	end

    self.lab_title = ngui.find_label(self.ui, "centre_other/animation/content/txt");

    self:UpdateUi();
end

function UiMap:UpdateUi(hurdle_id)
    if not UiBaseClass.UpdateUi(self) then return end

    if self.currentPage then
        self.currentPage:DestroyUi();
    end
    self.currentPage = UiAreaMap:new({parent = self, hurdle_id = hurdle_id});
end

function UiMap:on_close()
    uiManager:PopUi();
end

function UiMap:AddSpecialPoint(x, y, z, gid, name)
    if self.currentPage then
        self.currentPage:AddSpecialPoint(x, y, z, gid, name)
    end
end

function UiMap:ShowNavigationBar()
    return false;
end

