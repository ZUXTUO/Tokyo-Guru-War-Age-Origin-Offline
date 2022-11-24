-- CommonSuccess = Class("CommonSuccess", UiBaseClass);

-- local pathRes = {};
-- pathRes.bk = "assetbundles/prefabs/ui/fight/panel_fight_bg_purple.assetbundle";
-- --------------------外部接口-------------------------
-- -- type=1,“升级成功”，2“升级失败”，3“升星成功”，4“升星失败”
-- --data = {type = 1, str_left= {}, str_right = {}, callback = func, obj = self, param1 = param1,param2 = param2}
-- function CommonSuccess.Start(data)
-- 	if CommonSuccess.instance then
--         CommonSuccess.instance:SetData(data);
--         CommonSuccess.instance:UpdateUi();
--         CommonSuccess.instance:Show();
--     else
--         CommonSuccess.instance = CommonSuccess:new(data);
--     end
-- end

-- function CommonSuccess.Destroy()
--     if CommonSuccess.instance then
--         CommonSuccess.instance:Hide();
--         CommonSuccess.instance:DestroyUi();
--         CommonSuccess.instance = nil;
--     end
-- end

-- --------------------内部接口-------------------------
-- --设置数据
-- function CommonSuccess:SetData(data)
-- 	self.str_left = data.str_left;
-- 	self.str_right = data.str_right;
--     if data.type then
--         self.type = data.type;
--     else
--         self.type = 1;
--     end
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
-- function CommonSuccess:Init(data)
-- 	self.pathRes = "assetbundles/prefabs/ui/fight/ui_825_fight.assetbundle";
--     self:SetData(data);
-- 	UiBaseClass.Init(self, data);
-- end

-- --初始化数据
-- function CommonSuccess:InitData()
--     self.bk = nil;
--     UiBaseClass.InitData(self, data);
-- end

-- --析构函数
-- function CommonSuccess:DestroyUi()
--     UiBaseClass.DestroyUi(self);
--     self.bk = nil;
-- end

-- --显示ui
-- function CommonSuccess:Show()
--     if UiBaseClass.Show(self) then
-- 	    if not self.bk then
--     	    return
--         end
--         self.bk:set_active(true);
-- 	end
-- end

-- --隐藏ui
-- function CommonSuccess:Hide()
-- 	if UiBaseClass.Hide(self) then
-- 	    if not self.bk then
--     	    return
--         end
--         self.bk:set_active(false);
-- 	end
-- end

-- --注册回调函数
-- function CommonSuccess:RegistFunc()
--     UiBaseClass.RegistFunc(self);
--     self.bindfunc['on_touch_mark'] = Utility.bind_callback(self, self.on_touch_mark);
--     self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
-- end

-- --加载UI
-- function CommonSuccess:LoadUI()
-- 	if UiBaseClass.LoadUI(self) then
-- 	end
-- end

-- -- --资源加载回调
-- -- function CommonSuccess:on_loaded(pid, filepath, asset_obj, error_info)
-- --     if filepath == pathRes.bk then
-- --     	self.bk = asset_game_object.create(asset_obj);
-- --         self.bk:set_parent(Root.get_root_ui_2d());
-- --         self.bk:set_local_scale(1,1,1);
-- --     end
-- -- end

-- --寻找ngui对象
-- function CommonSuccess:InitUI(asset_obj)
-- 	UiBaseClass.InitUI(self, asset_obj)
--     self.ui:set_parent(Root.get_root_ui_2d());
--     self.ui:set_local_scale(Utility.SetUIAdaptation());
--     self.ui:set_name('commom_success');

--     self.btn_mark = ngui.find_button(self.ui, "mark");
--     self.btn_mark:set_on_click(self.bindfunc['on_touch_mark']);

--     self.wrap_content = ngui.find_wrap_content(self.ui, 'wrap_content');
--     self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);

--     -- self.sp1_1 = ngui.find_sprite(self.ui, "fight_font_animation1/animation/cont_animation_item1/sp_sheng");
--     -- self.sp1_2 = ngui.find_sprite(self.ui, "fight_font_animation1/animation/cont_animation_item1/sp_ji");
--     -- self.sp1_3 = ngui.find_sprite(self.ui, "fight_font_animation1/animation/cont_animation_item1/sp_cheng");
--     -- self.sp1_4 = ngui.find_sprite(self.ui, "fight_font_animation1/animation/cont_animation_item1/sp_gong");
--     -- self.sp2_1 = ngui.find_sprite(self.ui, "fight_font_animation1/animation/cont_animation_item 2/sp_sheng");
--     -- self.sp2_2 = ngui.find_sprite(self.ui, "fight_font_animation1/animation/cont_animation_item 2/sp_ji");
--     -- self.sp2_3 = ngui.find_sprite(self.ui, "fight_font_animation1/animation/cont_animation_item 2/sp_cheng");
--     -- self.sp2_4 = ngui.find_sprite(self.ui, "fight_font_animation1/animation/cont_animation_item 2/sp_gong");
-- 	self:UpdateUi();
-- end

-- --刷新界面
-- function CommonSuccess:UpdateUi(dt)
-- 	if self.ui then
--         self.wrap_content:set_min_index(-#self.str_left+1);
--         self.wrap_content:set_max_index(0);
--         self.wrap_content:reset();
-- 	end
-- end

-- function CommonSuccess:init_item_wrap_content(obj,b,real_id)
--     local index = math.abs(real_id)+1;

--     local str_left = ngui.find_label(obj, "lab_nature");
--     local str_right = ngui.find_label(obj, "lab_preview");

--     str_left:set_text(self.str_left[index]);
--     str_right:set_text(self.str_right[index]);
-- end

-- function CommonSuccess:on_touch_mark()
-- 	CommonSuccess.Destroy();

-- 	if self.callback then
--         if self.obj then
-- 		    self.callback(self.obj,self.param1,self.param2,self.param3,self.param4)
--         else
--             self.callback(self.param1,self.param2,self.param3,self.param4)
--         end
-- 	end
-- end