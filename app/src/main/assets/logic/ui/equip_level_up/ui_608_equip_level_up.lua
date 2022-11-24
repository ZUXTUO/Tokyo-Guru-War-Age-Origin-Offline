UiEquipLevelUp = Class('UiEquipLevelUp', UiBaseClass);

-------------------外部接口-----------------------
--设置数据--
--param:data = {cardInfo = xx}
function UiEquipLevelUp:SetData(data)
	self.cardInfo = data.cardInfo;
	if data.func then
		self.back_callback = data.func;
	end
	self:UpdateUi()
end
--------------------------------------------------



--初始化
function UiEquipLevelUp:Init(data)
	self.pathRes = 'assetbundles/prefabs/ui/equip_level_up/ui_608_equip_level_up.assetbundle';
    UiBaseClass.Init(self, data);
end

--重新开始
function UiEquipLevelUp:Restart(data)
	if data then
		self.cardInfo = data.cardInfo;
	end
    if UiBaseClass.Restart(self, data) then
	--todo 各自额外的逻辑
	end
end

--初始化数据
function UiEquipLevelUp:InitData(data)
    UiBaseClass.InitData(self, data);
	--self.cardInfo = nil;
	self.sitem = {};
	self.lab_nature = {};
	self.lab_preview = {};
end

--析构函数
function UiEquipLevelUp:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.sim1 then
	    self.sim1:DestroyUi();
	    self.sim1 = nil;
	end
	if self.sim2 then
	    self.sim2:DestroyUi();
	    self.sim2 = nil;
	end
	self.lab_nature = {};
	self.lab_preview = {};
end

--注册回调函数
function UiEquipLevelUp:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc['on_btn_upgrade'] = Utility.bind_callback(self,self.on_btn_upgrade);
    self.bindfunc['on_btn_max_level'] = Utility.bind_callback(self,self.on_btn_max_level);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self,self.init_item_wrap_content);
	self.bindfunc['Back'] = Utility.bind_callback(self,self.Back);
	self.bindfunc['LevelUp'] = Utility.bind_callback(self,self.LevelUp);
	self.bindfunc['on_btn_close'] = Utility.bind_callback(self,self.on_btn_close);
	self.bindfunc['on_btn_advance'] = Utility.bind_callback(self,self.on_btn_advance);

	self.bindfunc['gc_level_up'] = Utility.bind_callback(self,self.gc_level_up);
	self.bindfunc['on_rule'] = Utility.bind_callback(self,self.on_rule);
	self.bindfunc['GoldExchangeUI'] = Utility.bind_callback(self,self.GoldExchangeUI);
	self.bindfunc['ShengJie'] = Utility.bind_callback(self,self.ShengJie);
	self.bindfunc['goto_recharge'] = Utility.bind_callback(self,self.goto_recharge);
end

--注册消息分发回调函数
function UiEquipLevelUp:MsgRegist()
	UiBaseClass.RegistFunc(self);
    PublicFunc.msg_regist(msg_cards.gc_equip_level_up,self.bindfunc['gc_level_up']);
end

--注销消息分发回调函数
function UiEquipLevelUp:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_equip_level_up,self.bindfunc['gc_level_up']);
end

--寻找ngui对象
function UiEquipLevelUp:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name('ui_608_equip_level_up');

    -- do return end
    self.btn_rule = ngui.find_button(self.ui, "centre_other/animation/btn_prompt");
    self.btn_rule:set_on_click(self.bindfunc['on_rule']);
    -----------------
    --寻找sprite
    self.obj_equip_left = self.ui:get_child_by_name("centre_other/animation/left/cont/sp_touxiangkuang");
    self.obj_equip_right = self.ui:get_child_by_name("centre_other/animation/right/content/sp_bk1");
    self.fx = self.ui:get_child_by_name("centre_other/animation/right/content/fx");
    self.fx:set_active(false);
 --    self.texture_equip_left = ngui.find_sprite(self.ui, 'centre_other/animation/di/left/di/sp_bk1/texture_equip_left');
 --    self.texture_equip_right = ngui.find_sprite(self.ui, 'centre_other/animation/di/left/di/sp_bk2/texture_equip_left');
 --    self.sp_frame_left = ngui.find_sprite(self.ui, 'centre_other/animation/di/left/di/sp_bk1/sp_frame');
 --    self.sp_frame_right = ngui.find_sprite(self.ui, 'centre_other/animation/di/left/di/sp_bk2/sp_frame');
 --    self.sp_cost_gold = ngui.find_sprite(self.ui, 'centre_other/animation/di/right/sp_bk1/sp_item_left');
	self.sp_star = {};
	for i=1,5 do
		self.sp_star[i] = ngui.find_sprite(self.ui, 'centre_other/animation/left/cont/star/star_di'..i.."/sp_star");
	end
	self.sp_letter = ngui.find_sprite(self.ui, "centre_other/animation/left/cont/sp_letter");
    --寻找button
    self.btn_upgrade = ngui.find_button(self.ui, 'centre_other/animation/right/cont1/btn_level_up');
    self.btn_upgrade:set_on_click(self.bindfunc['on_btn_upgrade']);
    self.btn_max_level = ngui.find_button(self.ui, 'centre_other/animation/right/cont1/btn_level_up_tall');
    self.btn_max_level:set_on_click(self.bindfunc['on_btn_max_level']);
    self.btn_close = ngui.find_button(self.ui,"centre_other/animation/btn_close");
	self.btn_close:set_on_click(self.bindfunc['on_btn_close']);
	--寻找label
	self.lab_title = ngui.find_label(self.ui, "centre_other/animation/lab_title");
    self.lab_name = ngui.find_label(self.ui, 'centre_other/animation/left/cont/lab_equip_name');
    self.lab_level = ngui.find_label(self.ui, 'centre_other/animation/left/cont/lab_level');
    self.lab_level_left = ngui.find_label(self.ui, 'centre_other/animation/right/lab_left_lv');
    self.lab_level_right = ngui.find_label(self.ui, 'centre_other/animation/right/lab_right_lv');
    self.lab_cost_gold = ngui.find_label(self.ui, 'centre_other/animation/right/cont1/sp_bk/lab');
    --寻找wrap_content
    self.wrap_content = ngui.find_wrap_content(self.ui, 'centre_other/animation/left/scroview/scrollview_nature/wrap_content');
    self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    --寻找progress_bar

    self.cont_level_up = ngui.find_sprite(self.ui, "centre_other/animation/right/cont1");
    self.cont_advance = ngui.find_sprite(self.ui, "centre_other/animation/right/cont2");

    -----------------------进阶部分-----------------------------------------------------------
	self.btn_adv = ngui.find_button(self.ui, "centre_other/animation/right/cont2/btn_level_up");
	self.btn_adv:set_on_click(self.bindfunc['on_btn_advance']);
	self.lab_adv_gold = ngui.find_label(self.ui, "centre_other/animation/right/cont2/sp_bk/lab");

	self.cont_odd = ngui.find_sprite(self.ui, "centre_other/animation/right/cont2/odd");
	self.cont_even = ngui.find_sprite(self.ui, "centre_other/animation/right/cont2/even");
	self.lab_odd_num = {};
	--self.lab_odd_name = {};
	self.obj_odd = {};
	self.sp_frame_odd = {};
	for i=1,5 do
		self.lab_odd_num[i] = ngui.find_label(self.ui, "centre_other/animation/right/cont2/odd/frame"..i.."/lab_num");
		--self.lab_odd_name[i] = ngui.find_label(self.ui, "centre_other/animation/right/cont2/odd/frame"..i.."/lab_name");
		self.obj_odd[i] = self.ui:get_child_by_name("centre_other/animation/right/cont2/odd/frame"..i.."/new_small_card_item");
		self.sp_frame_odd[i] = self.ui:get_child_by_name("centre_other/animation/right/cont2/odd/frame"..i);
	end

	self.lab_even_num = {};
	--self.lab_even_name = {};
	self.obj_even = {};
	self.sp_frame_even = {};
	for i=1,4 do
		self.lab_even_num[i] = ngui.find_label(self.ui, "centre_other/animation/right/cont2/even/frame"..i.."/lab_num");
		--self.lab_even_name[i] = ngui.find_label(self.ui, "centre_other/animation/right/cont2/even/frame"..i.."/lab_name");
		self.obj_even[i] = self.ui:get_child_by_name("centre_other/animation/right/cont2/even/frame"..i.."/new_small_card_item");
		self.sp_frame_even[i] = self.ui:get_child_by_name("centre_other/animation/right/cont2/even/frame"..i);
	end

	if self.cardInfo then
		self:UpdateUi()
	end
end

function UiEquipLevelUp:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return
	end
	if self.ui then
		if self.cardInfo ~= nil then
			local level = self.cardInfo.level;
			local level_cfg = CardHuman.GetLevelConfig(self.cardInfo.number, level, self.config)
			PublicFunc.SetEquipRaritySprite(self.sp_letter,self.cardInfo.rarity)
			self.lab_name:set_text(self.cardInfo.name);
			self.lab_level:set_text("LV."..tostring(level));
			self.lab_level_left:set_text("LV."..tostring(level));
			self.lab_level_right:set_text("LV."..tostring(level+1));
			self:SetStar(self.cardInfo.star);
			self.t_origin,self.t_end,self.t_diff = self.cardInfo:GetDiffPropertyLevel(level, level+1);
			
			self.wrap_content:set_min_index(-#self.t_origin+1);
			self.wrap_content:set_max_index(0);
			self.wrap_content:reset();
			if not self.sim1 then
	  			self.sim1 = UiSmallItem:new({parent = self.obj_equip_left, cardInfo = self.cardInfo});
			else
				self.sim1:SetData(self.cardInfo);
			end
            self.sim1:SetLabNum(false);
            if not self.sim2 then
	  			self.sim2 = UiSmallItem:new({parent = self.obj_equip_right, cardInfo = self.cardInfo});
			else
				self.sim2:SetData(self.cardInfo);
			end
            self.sim2:SetLabNum(false);
            local adv_materials = level_cfg.adv_materials;
			if not adv_materials or adv_materials == 0 then
				self.cont_level_up:set_active(true);
				self.cont_advance:set_active(false);
				--self.lab_cost_gold:set_text(PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold).."/"..PublicFunc.NumberToStringByCfg(level_cfg.cost_gold));
				-- if g_dataCenter.player.gold >= level_cfg.cost_gold then
				-- 	self.lab_cost_gold:set_text("[00FF2B]"..PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold).."[-]/"..PublicFunc.NumberToStringByCfg(level_cfg.cost_gold));
				-- else
				-- 	self.lab_cost_gold:set_text("[FF0000]"..PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold).."[-]/"..PublicFunc.NumberToStringByCfg(level_cfg.cost_gold));
				-- end
				PublicFunc.SetLeftAndRightNumber(self.lab_cost_gold,g_dataCenter.player.gold,level_cfg.cost_gold)
	        else
	        	self.materials_enough = true;
	        	self.cont_level_up:set_active(false);
				self.cont_advance:set_active(true);
				--self.lab_adv_gold:set_text(PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold).."/"..PublicFunc.NumberToStringByCfg(level_cfg.cost_gold));
				-- if g_dataCenter.player.gold >= level_cfg.cost_gold then
				-- 	self.lab_adv_gold:set_text("[00FF2B]"..PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold).."[-]/"..PublicFunc.NumberToStringByCfg(level_cfg.cost_gold));
				-- else
				-- 	self.lab_adv_gold:set_text("[FF0000]"..PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold).."[-]/"..PublicFunc.NumberToStringByCfg(level_cfg.cost_gold));
				-- end
				PublicFunc.SetLeftAndRightNumber(self.lab_adv_gold,g_dataCenter.player.gold,level_cfg.cost_gold)
				self.need_crystal = 0;
				local num = #adv_materials;
				if num%2 == 0 then
					self.cont_odd:set_active(false);
					self.cont_even:set_active(true);
					for i=1,4 do
						self.sp_frame_even[i]:set_active(false);
					end
					for i=1,num do
						if self.sitem[i] then
							self.sitem[i]:DestroyUi();
						end
						local count = PropsEnum.GetValue(adv_materials[i].id);
						local item_info = CardProp:new({number = adv_materials[i].id, count = count});
						self.sitem[i] = UiSmallItem:new({cardInfo=item_info, parent=self.obj_even[i]});
						self.sitem[i]:SetNeedCount(adv_materials[i].count);
						self.sitem[i]:SetLabNum(false);
						self.sp_frame_even[i]:set_active(true);
						if count < adv_materials[i].count then
							local diff_count = adv_materials[i].count-count;
							local need_crystal = ConfigManager.Get(EConfigIndex.t_item,adv_materials[i].id).need_crystal;
							self.need_crystal = self.need_crystal + diff_count * need_crystal;
							self.materials_enough = false;
						end
						PublicFunc.SetLeftAndRightNumber(self.lab_even_num[i],count,adv_materials[i].count)
						--self.lab_even_name[i]:set_text(item_info.name);
					end
				else
					self.cont_odd:set_active(true);
					self.cont_even:set_active(false);
					for i=1,5 do
						self.sp_frame_odd[i]:set_active(false);
					end
					for i=1,num do
						if self.sitem[i] then
							self.sitem[i]:DestroyUi();
						end
						local count = PropsEnum.GetValue(adv_materials[i].id);
						local item_info = CardProp:new({number = adv_materials[i].id, count = count});
						self.sitem[i] = UiSmallItem:new({cardInfo=item_info, parent=self.obj_odd[i]});
						self.sitem[i]:SetNeedCount(adv_materials[i].count);
						self.sitem[i]:SetLabNum(false);
						self.sp_frame_odd[i]:set_active(true);
						if count < adv_materials[i].count then
							local diff_count = adv_materials[i].count-count;
							local need_crystal = ConfigManager.Get(EConfigIndex.t_item,adv_materials[i].id).need_crystal;
							self.need_crystal = self.need_crystal + diff_count * need_crystal;
							self.materials_enough = false;
						end
						PublicFunc.SetLeftAndRightNumber(self.lab_odd_num[i],count,adv_materials[i].count)
						--self.lab_odd_name[i]:set_text(item_info.name);
					end
				end
	        end
		end
	end
end

--
function UiEquipLevelUp:init_item_wrap_content(obj,b,real_id)
	if not self.cardInfo then return end;
	local index = math.abs(real_id)+1;
	if not self.lab_nature[b] then
		self.lab_nature[b] = ngui.find_label(obj, "lab_nature");
	end
	if not self.lab_preview[b] then
		self.lab_preview[b] = ngui.find_label(obj, "lab_preview");
	end
	-- local lab_preview = ngui.find_label(obj, "lab_preview");
	local zhengfu;
	local property_value = self.t_origin[index].value;
	if property_value >= 0 then
		zhengfu = "+";
	else
		zhengfu = "";
	end
	self.lab_nature[b]:set_text(zhengfu..property_value..self.t_origin[index].showUnit.." "..gs_string_property_name[self.t_origin[index].key]);
	local property_diff = self.t_diff[index].value;
	if property_diff then
		if property_diff > 0 then
			zhengfu = "+";
			self.lab_preview[b]:set_text(zhengfu..self.t_diff[index].value..self.t_diff[index].showUnit);
		elseif property_diff == 0 then
			self.lab_preview[b]:set_text("");
		else
			zhengfu = "";
			self.lab_preview[b]:set_text(zhengfu..self.t_diff[index].value..self.t_diff[index].showUnit);
		end
		
	else
		self.lab_preview[b]:set_text("");
	end
end


function UiEquipLevelUp:SetStar(num)
	if num >=0 and num <=5 then
		for i=1,5 do
			if i > num then
				self.sp_star[i]:set_active(false);
			else
				self.sp_star[i]:set_active(true);
			end
		end
	else
		app.log("星星等级不对");
	end
end

function UiEquipLevelUp:LevelUp()
	self.loadingId = GLoading.Show(GLoading.EType.ui);
	msg_cards.cg_equip_level_up(Socket.socketServer,self.cardInfo.index,self.level_count);
end

function UiEquipLevelUp:Back()
	uiManager:PopUi();
end

function UiEquipLevelUp:gc_level_up(result)
	GLoading.Hide(GLoading.EType.ui, self.loadingId);
	if result == MsgEnum.error_code.error_code_success or result == MsgEnum.error_code.error_code_fail then
		local level1 = self.cardInfo.oldLevel;
		local level2 = self.cardInfo.level;
		local t_origin,t_end,t_diff = self.cardInfo:GetDiffPropertyLevel2(level1, level2);
		local data = {};
		data.str_left = {};
		data.str_right = {};
		for i=1,#t_diff do
			data.str_left[i] = gs_string_property_name[t_diff[i].key];
			local zhengfu1;
			local zhengfu2;
			if t_end[i].value >= 0 then
				zhengfu1 = "+";
			else
				zhengfu1 = "";
			end
			if t_diff[i].value >= 0 then
				zhengfu2 = "+";
			else
				zhengfu2 = "";
			end
			data.str_right[i] = zhengfu1..t_end[i].value..t_end[i].showUnit.."("..zhengfu2..t_diff[i].value..t_origin[i].showUnit..")";
		end
		if result == MsgEnum.error_code.error_code_success then
			--EquipAccount.SetAndShow("装备升级成功",data);
			data.type = 1;
			data.cardinfo = self.cardInfo;
			-- CommonEquipAward.Start(data)
			--self.fx:set_active(true);
		else
			--EquipAccount.SetAndShow("装备升级失败",data);
		end
		self:SetData({cardInfo = self.cardInfo});
	else
		PublicFunc.GetErrorString(result, true);
	end
end




