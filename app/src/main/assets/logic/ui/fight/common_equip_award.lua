-- CommonEquipAward = Class("CommonEquipAward", UiBaseClass);

-- local pathRes = {};
-- pathRes.bk = "assetbundles/prefabs/ui/fight/panel_fight_bg_purple.assetbundle";
-- --------------------外部接口-------------------------
-- -- type=1,“升级成功”，2“升星成功”，3“升星失败”
-- --data = {type = 1, str_left= {}, str_right = {}, callback = func, obj = self, param1 = param1,param2 = param2}
-- function CommonEquipAward.Start(data)

--     app.log('CommonEquipAward.Start  discard')
-- 	if CommonEquipAward.instance then
--         CommonEquipAward.instance:SetData(data);
--         CommonEquipAward.instance:UpdateUi();
--         CommonEquipAward.instance:Show();
--     else
--         CommonEquipAward.instance = CommonEquipAward:new(data);
--     end
-- end

-- function CommonEquipAward.Destroy()
--     if CommonEquipAward.instance then
--         CommonEquipAward.instance:Hide();
--         CommonEquipAward.instance:DestroyUi();
--         CommonEquipAward.instance = nil;
--     end
-- end

-- --------------------内部接口-------------------------
-- --设置数据
-- function CommonEquipAward:SetData(data)
-- 	self.str_left = data.str_left;
-- 	self.str_right = data.str_right;
--     self.cardinfo = data.cardinfo;
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
-- function CommonEquipAward:Init(data)
-- 	self.pathRes = "assetbundles/prefabs/ui/fight/ui_824_fight.assetbundle";
--     self:SetData(data);
-- 	UiBaseClass.Init(self, data);
-- end

-- --初始化数据
-- function CommonEquipAward:InitData()
--     self.bk = nil;
--     UiBaseClass.InitData(self, data);
-- end

-- --析构函数
-- function CommonEquipAward:DestroyUi()
--     UiBaseClass.DestroyUi(self);
--     self.bk = nil;
--     if self.texture then
--         self.texture:Destroy();
--         self.texture = nil;
--     end
-- end

-- --显示ui
-- function CommonEquipAward:Show()
--     if UiBaseClass.Show(self) then
-- 	    if not self.bk then
--     	    return
--         end
--         self.bk:set_active(true);
-- 	end
-- end

-- --隐藏ui
-- function CommonEquipAward:Hide()
-- 	if UiBaseClass.Hide(self) then
-- 	    if not self.bk then
--     	    return
--         end
--         self.bk:set_active(false);
-- 	end
-- end

-- --注册回调函数
-- function CommonEquipAward:RegistFunc()
--     UiBaseClass.RegistFunc(self);
--     self.bindfunc['on_touch_mark'] = Utility.bind_callback(self, self.on_touch_mark);
--     self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
-- end

-- --加载UI
-- function CommonEquipAward:LoadUI()
-- 	if UiBaseClass.LoadUI(self) then
-- 	    --ResourceLoader.LoadAsset(pathRes.bk, self.bindfunc['on_loaded'], self.panel_name);
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
-- function CommonEquipAward:InitUI(asset_obj)
-- 	UiBaseClass.InitUI(self, asset_obj)
--     self.ui:set_parent(Root.get_root_ui_2d());
--     self.ui:set_local_scale(Utility.SetUIAdaptation());
--     self.ui:set_name('commom_equip_award');

--     self.btn_mark = ngui.find_button(self.ui, "mark");
--     self.btn_mark:set_on_click(self.bindfunc['on_touch_mark']);

--     self.wrap_content = ngui.find_wrap_content(self.ui, 'centre_other/animation/scrollview_nature/wrap_content');
--     self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);

--     self.sp_left = ngui.find_sprite(self.ui, "top_other/animation/cont1/sp_left");
--     self.sp_right = ngui.find_sprite(self.ui, "top_other/animation/cont1/sp_right");

--     self.texture = ngui.find_texture(self.ui, "centre_other/animation/content/sp_touxiangkuang/sp_equip");
--     self.sp_frame = ngui.find_sprite(self.ui, "centre_other/animation/content/sp_touxiangkuang/sp_frame");
--     self.lab_name = ngui.find_label(self.ui, "centre_other/animation/content/lab_equip_name");
--     self.txt = ngui.find_label(self.ui, "centre_other/animation/content/txt");
--     self.lab_level = ngui.find_label(self.ui, "centre_other/animation/content/lab_level");
--     self.cont_star = ngui.find_sprite(self.ui, "centre_other/animation/content/star");
--     self.sp_star = {};
--     for i=1,5 do
--         self.sp_star[i] = ngui.find_sprite(self.ui, "centre_other/animation/content/star/star_di"..i.."/sp_star");
--     end

-- 	self:UpdateUi();
-- end

-- --刷新界面
-- function CommonEquipAward:UpdateUi(dt)
-- 	if self.ui then
-- 	    if self.type == 1 then
--             self.sp_left:set_sprite_name("shengji");
--             self.sp_right:set_sprite_name("chenggong");
--             self.txt:set_text("已升级至");
--             self.cont_star:set_active(false);
--             self.lab_level:set_active(true);
--             self.lab_level:set_text("Lv"..tostring(self.cardinfo.level));
--             AudioManager.PlayUiAudio(ENUM.EUiAudioType.ComReward);
--         elseif self.type == 2 then
--             self.sp_left:set_sprite_name("shengxing");
--             self.sp_right:set_sprite_name("chenggong");
--             self.txt:set_text("已升星至");
--             self.cont_star:set_active(true);
--             self.lab_level:set_active(false);
--             for i=1,5 do
--                 self.sp_star[i]:set_active(i <= self.cardinfo.star);
--             end
--             AudioManager.PlayUiAudio(ENUM.EUiAudioType.ComReward);
--         end
--         local path = self.cardinfo.small_icon;
--         self.texture:set_texture(path);
--         --item_manager.texturePadding(self.texture, path);
--         self.lab_name:set_text(self.cardinfo.name);
--         PublicFunc.SetIconFrameSprite(self.sp_frame,self.cardinfo.rarity)


--         self.wrap_content:set_min_index(-#self.str_left+1);
--         self.wrap_content:set_max_index(0);
--         self.wrap_content:reset();
-- 	end
-- end

-- function CommonEquipAward:init_item_wrap_content(obj,b,real_id)
--     local index = math.abs(real_id)+1;

--     local str_left = ngui.find_label(obj, "lab_nature");
--     local str_right = ngui.find_label(obj, "lab_preview");

--     str_left:set_text(self.str_left[index]);
--     str_right:set_text(self.str_right[index]);
-- end

-- function CommonEquipAward:on_touch_mark()
-- 	CommonEquipAward.Destroy();

-- 	if self.callback then
--         if self.obj then
-- 		    self.callback(self.obj,self.param1,self.param2,self.param3,self.param4)
--         else
--             self.callback(self.param1,self.param2,self.param3,self.param4)
--         end
-- 	end
-- end