-- UiEquipStarUp = Class('UiEquipStarUp', UiBaseClass);
-- -------------------外部接口-----------------------
-- --设置数据--
-- --param:data = {cardInfo = xx}
-- function UiEquipStarUp:SetData(data)
-- 	self.cardInfo = data.cardInfo;
-- 	if data.func then
-- 		self.back_callback = data.func;
-- 	end
-- 	--self.oldCardInfo = Utility.clone(self.cardInfo);
-- 	self:UpdateUi();
-- end
-- --------------------------------------------------

-- --初始化
-- function UiEquipStarUp:Init(data)
-- 	self.pathRes = 'assetbundles/prefabs/ui/equip_star_up/ui_609_equip_star_up.assetbundle';
--     UiBaseClass.Init(self, data);
-- end


-- --初始化数据
-- function UiEquipStarUp:InitData(data)
-- 	UiBaseClass.InitData(self, data);
-- 	--self.cardInfo = nil;
-- 	self.diff = {};
-- 	--self.can_use_concentration = false;
-- 	self.use_concentration = false;
-- 	self.lab_nature = {};
-- 	self.lab_preview = {};
-- end

-- function UiEquipStarUp:Restart(data)
-- 	if data then
-- 		self.cardInfo = data.cardInfo;
-- 	end
-- 	self.isFirst = true;
-- 	if UiBaseClass.Restart(self, data) then
-- 	--todo 各自额外的逻辑
		
-- 	end
-- end

-- function UiEquipStarUp:DestroyUi()
-- 	UiBaseClass.DestroyUi(self);
-- 	-- if self.texture_concentration_left then
-- 	-- 	self.texture_concentration_left:Destroy();
-- 	-- 	self.texture_concentration_left = nil;
-- 	-- end
-- 	-- if self.texture_concentration_right then
-- 	-- 	self.texture_concentration_right:Destroy();
-- 	-- 	self.texture_concentration_right = nil;
-- 	-- end
-- 	if self.texture_qianghuashi then
-- 		self.texture_qianghuashi:Destroy();
-- 		self.texture_qianghuashi = nil;
-- 	end
-- 	if self.sim1 then
-- 		self.sim1:DestroyUi();
-- 		self.sim1 = nil;
-- 	end
-- 	if self.sim2 then
-- 		self.sim2:DestroyUi();
-- 		self.sim2 = nil;
-- 	end
-- 	self.isFirst = true;
-- 	self.lab_nature = {};
-- 	self.lab_preview = {};
-- end

-- --注册回调函数
-- function UiEquipStarUp:RegistFunc()
--     UiBaseClass.RegistFunc(self);
--     self.bindfunc['on_btn_sure'] = Utility.bind_callback(self,UiEquipStarUp.on_btn_sure);
--     self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self,UiEquipStarUp.init_item_wrap_content);
-- 	-- self.bindfunc['on_btn_cost_concentration'] = Utility.bind_callback(self,UiEquipStarUp.on_btn_cost_concentration);
-- 	self.bindfunc['Back'] = Utility.bind_callback(self,UiEquipStarUp.Back);
-- 	self.bindfunc['StarUp'] = Utility.bind_callback(self,UiEquipStarUp.StarUp);
-- 	--self.bindfunc['SetToggleFalse'] = Utility.bind_callback(self,UiEquipStarUp.SetToggleFalse);
-- 	self.bindfunc['on_btn_close'] = Utility.bind_callback(self,UiEquipStarUp.on_btn_close);
-- 	self.bindfunc['gc_star_up'] = Utility.bind_callback(self,UiEquipStarUp.gc_star_up);
-- 	self.bindfunc['on_rule'] = Utility.bind_callback(self,UiEquipStarUp.on_rule);
-- end

-- --注册消息分发回调函数
-- function UiEquipStarUp:MsgRegist()
-- 	UiBaseClass.MsgRegist(self);
--     PublicFunc.msg_regist(msg_cards.gc_equip_star_up,self.bindfunc['gc_star_up']);
-- end

-- --注销消息分发回调函数
-- function UiEquipStarUp:MsgUnRegist()
-- 	UiBaseClass.MsgUnRegist(self);
--     PublicFunc.msg_unregist(msg_cards.gc_equip_star_up,self.bindfunc['gc_star_up']);
-- end

-- --寻找ngui对象
-- function UiEquipStarUp:InitUI(asset_obj)
--     UiBaseClass.InitUI(self, asset_obj)
--     self.ui:set_parent(Root.get_root_ui_2d());
--     self.ui:set_local_scale(Utility.SetUIAdaptation());
--     self.ui:set_name('ui_609_equip_star_up');
--     -- do return end
--     -----------------
--     self.obj_equip_left = ngui.find_sprite(self.ui, "centre_other/animation/left/cont/sp_touxiangkuang"):get_game_object();
--     self.obj_equip_right = ngui.find_sprite(self.ui, "centre_other/animation/right/content/sp_bk1"):get_game_object();
--     self.fx = asset_game_object.find("ui_609_equip_star_up/centre_other/animation/right/content/fx");
-- 	self.fx:set_active(false);
-- 	--寻找sprite
-- 	self.sp_star = {};
-- 	self.sp_star_left = {};
-- 	self.sp_star_right = {};
-- 	for i=1,5 do
-- 		self.sp_star[i] = ngui.find_sprite(self.ui, 'centre_other/animation/left/cont/star/star_di'..i..'/sp_star');
-- 		self.sp_star_left[i] = ngui.find_sprite(self.ui, 'centre_other/animation/right/content/left_star/star_di'..i..'/sp_star');
-- 		self.sp_star_right[i] = ngui.find_sprite(self.ui, 'centre_other/animation/right/content/right_star/star_di'..i..'/sp_star');
-- 	end
-- 	self.sp_letter = ngui.find_sprite(self.ui, "centre_other/animation/left/cont/sp_letter");
-- 	--寻找texture
-- 	--self.texture_concentration_left = ngui.find_texture(self.ui,"centre_other/animation/content1/Texture");
-- 	--self.texture_concentration_right = ngui.find_texture(self.ui,"centre_other/animation/content2/sp_red_gem");
-- 	self.texture_qianghuashi = ngui.find_texture(self.ui,"centre_other/animation/right/sp_bk/content2/Texture");
-- 	--寻找content
-- 	--self.cont_concentration = ngui.find_sprite(self.ui, "centre_other/animation/content2");
	
--     --寻找button
--     self.btn_sure = ngui.find_button(self.ui, 'centre_other/animation/right/btn_star_up');
--     self.btn_sure:set_on_click(self.bindfunc['on_btn_sure']);
-- 	--self.btn_cost_concentration = ngui.find_button(self.ui,"centre_other/animation/content2/yeka/btn_cost_concentration");
-- 	--self.btn_cost_concentration:set_on_click(self.bindfunc['on_btn_cost_concentration']);
-- 	self.btn_close = ngui.find_button(self.ui,"centre_other/animation/btn_close");
-- 	self.btn_close:set_on_click(self.bindfunc['on_btn_close']);
--     --寻找label
-- 	self.lab_name = ngui.find_label(self.ui, 'centre_other/animation/left/cont/lab_equip_name');
-- 	--self.lab_gouxuan = ngui.find_label(self.ui,"centre_other/animation/content2/yeka/lab");
--     self.lab_level = ngui.find_label(self.ui, 'centre_other/animation/left/cont/lab_level');
--     self.lab_succeed = ngui.find_label(self.ui, 'centre_other/animation/right/succeed');
--     --self.lab_all_focus = ngui.find_label(self.ui, 'centre_other/animation/content1/lab');
--     --self.lab_cost_focus = ngui.find_label(self.ui, 'centre_other/animation/content2/lab_cost_focus');
--     self.lab_cost_item = ngui.find_label(self.ui, 'centre_other/animation/right/sp_bk/content2/lab');
--     self.lab_cost_gold = ngui.find_label(self.ui, 'centre_other/animation/right/sp_bk/content1/lab');
--     --寻找wrap_content
--     self.wrap_content = ngui.find_wrap_content(self.ui, 'centre_other/animation/left/scroview/scrollview_nature/wrap_content');
--     self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
--     --寻找progress_bar
-- 	--寻找toggle
-- 	--self.toggle_concentration = ngui.find_toggle(self.ui,"centre_other/animation/content2/yeka/btn_cost_concentration");

-- 	self.btn_rule = ngui.find_button(self.ui, "centre_other/animation/btn_prompt")
-- 	self.btn_rule:set_on_click(self.bindfunc['on_rule']);
	
-- 	self:UpdateUi();
-- end

-- function UiEquipStarUp:UpdateUi()
-- 	if not UiBaseClass.UpdateUi(self) then
-- 		return
-- 	end
-- 	if self.ui then
-- 		if self.cardInfo ~= nil then
-- 			--self.lab_gouxuan:set_active(true);
-- 			PublicFunc.SetEquipRaritySprite(self.sp_letter,self.cardInfo.rarity)
-- 			self.lab_succeed:set_text(tostring(self.cardInfo.starup_success_rate).."%");
-- 			self.lab_level:set_text("Lv."..tostring(self.cardInfo.level));
-- 			-- self.lab_cost_gold:set_text(PublicFunc.NumberToStringByCfg(self.cardInfo.starup_gold).."/"..PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold));
-- 			PublicFunc.SetLeftAndRightNumber(self.lab_cost_gold,g_dataCenter.player.gold,self.cardInfo.starup_gold);
-- 			--self.lab_cost_focus:set_text(tostring(self.cardInfo.starup_success_concentration));
-- 			self:SetStar(self.cardInfo.star);
-- 			self.lab_name:set_text(self.cardInfo.name);
-- 			local data = {};
-- 			data.number = self.cardInfo.star_up_number;
-- 			if data.number == 0 then
-- 				data.number = self.cardInfo.number;
-- 			end
-- 			data.level = self.cardInfo.level;
-- 			local cardinfo_starup = CardEquipment:new(data);
-- 			self.t_origin,self.t_end,self.t_diff = self.cardInfo:GetDiffProperty(self.cardInfo, cardinfo_starup);

-- 			self.wrap_content:set_min_index(-#self.t_origin+1);
-- 			self.wrap_content:set_max_index(0);
-- 			self.wrap_content:reset();

-- 			--寻找升星所用强化石和集中度
-- 			local jewel = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item,self.cardInfo.starup_material_id);
-- 			if jewel then
-- 				self.jewel_count = jewel.count;
-- 			else
-- 				self.jewel_count = 0;
-- 			end
-- 			-- self.lab_cost_item:set_text(tostring(self.cardInfo.starup_material_num)..'/'..tostring(self.jewel_count));
-- 			PublicFunc.SetLeftAndRightNumber(self.lab_cost_item,self.jewel_count,self.cardInfo.starup_material_num);
-- 			-- local concentration_id;
-- 			-- if self.cardInfo.rarity == ENUM.EEquipRarity.Blue then
-- 			-- 	concentration_id = 20000001;
-- 			-- elseif self.cardInfo.rarity == ENUM.EEquipRarity.Purple then
-- 			-- 	concentration_id = 20000002;
-- 			-- elseif self.cardInfo.rarity == ENUM.EEquipRarity.Gold then
-- 			-- 	concentration_id = 20000003;
-- 			-- elseif self.cardInfo.rarity == ENUM.EEquipRarity.Orange then
-- 			-- 	concentration_id = 20000003;
-- 			-- else
-- 			-- 	concentration_id = nil;
-- 			-- end
-- 			-- if concentration_id then
-- 			-- 	self.concentration = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item,concentration_id);
-- 			-- end
-- 			-- if not self.concentration then
-- 			-- 	self.concentration = {};
-- 			-- 	self.concentration.count = 0;
-- 			-- end
-- 			--self.lab_all_focus:set_text("x"..tostring(self.concentration.count));
-- 			self.use_concentration = false;
-- 			--self.toggle_concentration:set_value(false);
			
-- 			if self.cardInfo.star >= 5 then                           --星级已达到最大
-- 				self.btn_sure:set_active(false);
-- 				--self.can_use_concentration = false;
-- 				--self.cont_concentration:set_active(false);
-- 			else
-- 				self.btn_sure:set_active(true);
-- 				-- if self.cardInfo.starup_success_rate >= 100 then          --成功率为100%
-- 				-- 	self.can_use_concentration = false;
-- 				-- 	self.cont_concentration:set_active(false);
-- 				-- else
-- 				-- 	self.can_use_concentration = true;
-- 				-- 	self.cont_concentration:set_active(true);
-- 				-- end
-- 			end
-- 			if not self.sim1 then
-- 				self.sim1 = UiSmallItem:new({obj = self.obj_equip_left, cardInfo = self.cardInfo});
-- 			else
-- 				self.sim1:SetData(self.cardInfo);
-- 			end
--             self.sim1:SetLabNum(false);

--             if not self.sim2 then
-- 				self.sim2 = UiSmallItem:new({obj = self.obj_equip_right, cardInfo = self.cardInfo});
-- 			else
-- 				self.sim2:SetData(self.cardInfo);
-- 			end
--             self.sim2:SetLabNum(false);
            
--             local path = ConfigManager.Get(EConfigIndex.t_item,self.cardInfo.starup_material_id).small_icon;
--             self.texture_qianghuashi:set_texture(path);
--             --item_manager.texturePadding(self.texture_qianghuashi,path)

--             --path = ConfigManager.Get(EConfigIndex.t_item,concentration_id).small_icon;
--             --self.texture_concentration_left:set_texture(path);
--             --self.texture_concentration_right:set_texture(path);
--             --item_manager.texturePadding(self.texture_concentration_left,path)
--             --item_manager.texturePadding(self.texture_concentration_right,path)
-- 		end
-- 	end
-- end

-- --
-- function UiEquipStarUp:init_item_wrap_content(obj,b,real_id)
-- 	local index = math.abs(real_id)+1;
-- 	if not self.lab_nature[b] then
-- 		self.lab_nature[b] = ngui.find_label(obj, "lab_nature");
-- 	end
-- 	if not self.lab_preview[b] then
-- 		self.lab_preview[b] = ngui.find_label(obj, "lab_preview");
-- 	end
-- 	local zhengfu;
-- 	local property_value = self.t_origin[index].value;
-- 	if property_value >= 0 then
-- 		zhengfu = "+";
-- 	else
-- 		zhengfu = "";
-- 	end
-- 	self.lab_nature[b]:set_text(zhengfu..property_value..self.t_origin[index].showUnit.." "..gs_string_property_name[self.t_origin[index].key]);
-- 	local property_diff = self.t_diff[index].value;
-- 	if property_diff then
-- 		if property_diff > 0 then
-- 			zhengfu = "+";
-- 			self.lab_preview[b]:set_text(zhengfu..self.t_diff[index].value..self.t_diff[index].showUnit);
-- 		elseif property_diff == 0 then
-- 			self.lab_preview[b]:set_text("");
-- 		else
-- 			zhengfu = "";
-- 			self.lab_preview[b]:set_text(zhengfu..self.t_diff[index].value..self.t_diff[index].showUnit);
-- 		end
-- 	else
-- 		self.lab_preview[b]:set_text("");
-- 	end
-- end

-- function UiEquipStarUp:SetStar(num)
-- 	if num >=0 and num <=5 then
-- 		for i=1,5 do
-- 			if i > num then
-- 				self.sp_star[i]:set_active(false);
-- 				self.sp_star_left[i]:set_active(false);
-- 			else
-- 				self.sp_star[i]:set_active(true);
-- 				self.sp_star_left[i]:set_active(true);
-- 			end

-- 			if i > num + 1 then
-- 				self.sp_star_right[i]:set_active(false);
-- 			else
-- 				self.sp_star_right[i]:set_active(true);
-- 			end
-- 		end
-- 	else
-- 		app.log("星星等级不对");
-- 	end
-- end

-- function UiEquipStarUp:StarUp()
-- 	GLoading.Show();
-- 	msg_cards.cg_equip_star_up(Socket.socketServer,self.cardInfo.index,self.use_concentration);
-- end

-- -- function UiEquipStarUp:SetToggleFalse()
-- -- 	self.lab_gouxuan:set_active(true);
-- -- 	self.toggle_concentration:set_value(false);
-- -- end

-- function UiEquipStarUp:gc_star_up(result, awards)
-- 	GLoading.Hide();
-- 	if result == MsgEnum.error_code.error_code_success or result == MsgEnum.error_code.error_code_fail then
-- 		local cardinfo1 = CardEquipment:new({level=self.cardInfo.oldLevel,number = self.cardInfo.oldNumber});
-- 		local cardinfo2 = self.cardInfo;
-- 		local t_origin,t_end,t_diff = self.cardInfo:GetDiffProperty3(cardinfo1, cardinfo2);
-- 		local data = {};
-- 		data.str_left = {};
-- 		data.str_right = {};
-- 		data.cardinfo = self.cardInfo;
-- 		for i=1,#t_diff do
-- 			data.str_left[i] = gs_string_property_name[t_diff[i].key];
-- 			local zhengfu1;
-- 			local zhengfu2;
-- 			if t_end[i].value >= 0 then
-- 				zhengfu1 = "+";
-- 			else
-- 				zhengfu1 = "";
-- 			end
-- 			if t_diff[i].value >= 0 then
-- 				zhengfu2 = "+";
-- 			else
-- 				zhengfu2 = "";
-- 			end
-- 			data.str_right[i] = zhengfu1..t_end[i].value..t_end[i].showUnit.."("..zhengfu2..t_diff[i].value..t_origin[i].showUnit..")";
-- 		end
-- 		if result == MsgEnum.error_code.error_code_success then
-- 			data.type = 2;
-- 			-- CommonEquipAward.Start(data)
-- 		else
-- 			-- data.callback = CommonAward.Start;
-- 			-- data.param1 = awards;
-- 			-- data.param2 = 1;
-- 			CommonEquipLose.Start(data)
-- 		end
-- 		self:SetData({cardInfo = self.cardInfo});
-- 	else
-- 		PublicFunc.GetErrorString(result, true);
-- 	end
-- end