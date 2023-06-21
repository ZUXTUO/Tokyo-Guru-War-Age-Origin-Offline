
---- discard

--NewFightUiChat = Class('NewFightUiChat', UiBaseClass);
----初始化
--function NewFightUiChat:Init(data)
--    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_chat.assetbundle";
--    UiBaseClass.Init(self, data);
--end

----初始化数据
--function NewFightUiChat:InitData(data)
--    UiBaseClass.InitData(self, data);
--    self.data = data;
--end

----注册回调函数
--function NewFightUiChat:RegistFunc()
--    UiBaseClass.RegistFunc(self);
--end

----初始化UI
--function NewFightUiChat:InitUI(asset_obj)
--    UiBaseClass.InitUI(self, asset_obj)
--    if self.data.parent then
--        self.ui:set_parent(self.data.parent);
--        self.ui:set_local_position(0,182,0);
--        --设置了父节点后需要马上将这个父节点去掉引用  不然会引起其他地方释放不到资源
--        self.data.parent = nil;
--    else
--        self.ui:set_parent(Root.get_root_ui_2d_fight());
--        self.ui:set_local_position(0,322,0);
--    end
--    self.ui:set_local_scale(1,1,1);

--    --ui初始化
--    self.control = {}
--end
----析构函数
--function NewFightUiChat:DestroyUi()
--    UiBaseClass.DestroyUi(self);
--    if type(self.control) == "table" then
--        for k, v in pairs(self.control) do
--            self.control[k] = nil;
--        end
--    end
--end