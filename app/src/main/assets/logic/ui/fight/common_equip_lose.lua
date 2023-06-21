-- CommonEquipLose = Class("CommonEquipLose", UiBaseClass);

-- --------------------外部接口-------------------------
-- function CommonEquipLose.Start(data)
-- 	if CommonEquipLose.instance then
--         CommonEquipLose.instance:SetData(data);
--         CommonEquipLose.instance:UpdateUi();
--         CommonEquipLose.instance:Show();
--     else
--         CommonEquipLose.instance = CommonEquipLose:new(data);
--     end
-- end

-- function CommonEquipLose.Destroy()
--     if CommonEquipLose.instance then
--         CommonEquipLose.instance:Hide();
--         CommonEquipLose.instance:DestroyUi();
--         CommonEquipLose.instance = nil;
--     end
-- end

-- --------------------内部接口-------------------------
-- --设置数据
-- function CommonEquipLose:SetData(data)
--     self.cardinfo = data.cardinfo;
-- 	if data.callback then
-- 		self.callback = data.callback;
-- 		self.obj = data.obj;
--         self.param1 = data.param1;
--         self.param2 = data.param2;
--         self.param3 = data.param3;
-- 		self.param4 = data.param4;
-- 	end
-- end

-- --初始化
-- function CommonEquipLose:Init(data)
-- 	self.pathRes = "assetbundles/prefabs/ui/fight/ui_824_fight_lose.assetbundle";
--     self:SetData(data);
-- 	UiBaseClass.Init(self, data);
-- end

-- --初始化数据
-- function CommonEquipLose:InitData()
--     UiBaseClass.InitData(self, data);
-- end

-- --析构函数
-- function CommonEquipLose:DestroyUi()
--     UiBaseClass.DestroyUi(self);
--     -- if self.texture then
--     --     self.texture:Destroy();
--     --     self.texture = nil;
--     -- end
-- end

-- --显示ui
-- function CommonEquipLose:Show()
--     if UiBaseClass.Show(self) then
-- 	end
-- end

-- --隐藏ui
-- function CommonEquipLose:Hide()
-- 	if UiBaseClass.Hide(self) then
-- 	end
-- end

-- --注册回调函数
-- function CommonEquipLose:RegistFunc()
--     UiBaseClass.RegistFunc(self);
--     self.bindfunc['on_touch_mark'] = Utility.bind_callback(self, self.on_touch_mark);
--     self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
-- end

-- --加载UI
-- function CommonEquipLose:LoadUI()
-- 	if UiBaseClass.LoadUI(self) then
-- 	end
-- end

-- --寻找ngui对象
-- function CommonEquipLose:InitUI(asset_obj)
-- 	UiBaseClass.InitUI(self, asset_obj)
--     self.ui:set_parent(Root.get_root_ui_2d());
--     self.ui:set_local_scale(Utility.SetUIAdaptation());
--     self.ui:set_name('ui_824_fight_lose');

--     self.btn_mark = ngui.find_button(self.ui, "mark");
--     self.btn_mark:set_on_click(self.bindfunc['on_touch_mark']);

--     self.sp_left = ngui.find_sprite(self.ui, "top_other/animation/cont1/sp_left");
--     self.sp_right = ngui.find_sprite(self.ui, "top_other/animation/cont1/sp_right");

--     self.content = ngui.find_sprite(self.ui, "centre_other/animation/content");
--     self.content:set_active(false);
--  --    self.texture = ngui.find_texture(self.ui, "centre_other/animation/content/sp_touxiangkuang/sp_equip");
--  --    self.sp_frame = ngui.find_sprite(self.ui, "centre_other/animation/content/sp_touxiangkuang/sp_frame");
--  --    self.lab_name = ngui.find_label(self.ui, "centre_other/animation/content/cont/lab_equip_name");
--  --    self.txt = ngui.find_label(self.ui, "centre_other/animation/content/cont/txt");
--  --    self.lab_level = ngui.find_label(self.ui, "centre_other/animation/content/cont/lab_level");
--  --    self.cont_star = ngui.find_sprite(self.ui, "centre_other/animation/content/cont/star");
--  --    self.sp_star = {};
--  --    for i=1,5 do
--  --        self.sp_star[i] = ngui.find_sprite(self.ui, "centre_other/animation/content/cont//star/star_di"..i.."/sp_star");
--  --    end

-- 	self:UpdateUi();
-- end

-- --刷新界面
-- function CommonEquipLose:UpdateUi(dt)
-- 	if self.ui then
--         -- self.txt:set_text("装备星级");
--         -- self.cont_star:set_active(false);
--         -- self.lab_level:set_active(true);
--         -- self.lab_level:set_text("-1");
--         -- local path = self.cardinfo.small_icon;
--         -- self.texture:set_texture(path);
--         -- --item_manager.texturePadding(self.texture, path);
--         -- self.lab_name:set_text(self.cardinfo.name);
--         -- PublicFunc.SetIconFrameSprite(self.sp_frame,self.cardinfo.rarity)
-- 	end
-- end

-- function CommonEquipLose:on_touch_mark()
-- 	CommonEquipLose.Destroy();

-- 	if self.callback then
--         if self.obj then
-- 		    self.callback(self.obj,self.param1,self.param2,self.param3,self.param4)
--         else
--             self.callback(self.param1,self.param2,self.param3,self.param4)
--         end
-- 	end
-- end