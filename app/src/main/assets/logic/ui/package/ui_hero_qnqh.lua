UiHeroQnqh = Class("UiHeroQnqh", UiBaseClass);

local neidan_cfg_data = {
	[0] = { name = "体能强化", sprite_name = "tinengqianghuazi", bg_sprite_name = "tinengqianghua", property_name = "neidan_physical_level" },
	[1] = { name = "攻击强化", sprite_name = "gongjiqianghuazi", bg_sprite_name = "gongjiqianghua", property_name = "neidan_attack_level" },
	[2] = { name = "防御强化", sprite_name = "fangyuqianghuazi", bg_sprite_name = "fangyuqianghua", property_name = "neidan_defense_level" },
}


function UiHeroQnqh.Star(data)
	if nil == UiHeroQnqh.Inst then
		UiHeroQnqh.Inst = UiHeroQnqh:new(data)
	else
		UiHeroQnqh.Inst:Show(data)
	end
end

function UiHeroQnqh.Destroy()
	if UiHeroQnqh.Inst then
		UiHeroQnqh.Inst:DestoryUi()
		UiHeroQnqh.Inst = nil
	end
end


function UiHeroQnqh:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/package/ui_602_2.assetbundle"
	UiBaseClass.Init(self, data);
end

function UiHeroQnqh:Restart(data)
	if UiBaseClass.Restart(self, data) then

	end
end

--function UiHeroQnqh:RestartData(data)
--	UiBaseClass.RestartData(data)

--end

function UiHeroQnqh:InitData(data)
	UiBaseClass.InitData(self, data);
	self.roleData = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, data.index)
	self.go_qh_items = { }
	self.is_open_qh = false
	self.need_soul_id = PublicFunc.GetRoleIdByHeroNumber(self.roleData.config.default_rarity)
end

function UiHeroQnqh:DestroyUi()
	UiBaseClass.DestroyUi(self);
	 
	if self.qh_press_propertyListShow then
		self.qh_press_propertyListShow:Destroy()
	end
end

function UiHeroQnqh:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
	self.bindfunc["on_btn_shard_exchange"] = Utility.bind_callback(self, self.on_btn_shard_exchange)
	self.bindfunc["gc_change_souls"] = Utility.bind_callback(self, self.UpdateUi)
	self.bindfunc["gc_neidan_upgrade"] = Utility.bind_callback(self, self.gc_neidan_upgrade)
	self.bindfunc["on_initialize_item"] = Utility.bind_callback(self, self.on_initialize_item)
	self.bindfunc["btn_act_qh"] = Utility.bind_callback(self, self.on_btn_act_qh)
	self.bindfunc["on_btn_qh_ico_press"] = Utility.bind_callback(self, self.on_btn_qh_ico_press)
	self.bindfunc["OnBtnBack"] = Utility.bind_callback(self, self.OnBtnBack)
end

function UiHeroQnqh:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

-- 注册消息分发回调函数
function UiHeroQnqh:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_cards.gc_change_souls, self.bindfunc['gc_change_souls']);
	PublicFunc.msg_regist(msg_cards.gc_neidan_upgrade, self.bindfunc["gc_neidan_upgrade"])
end

-- 注销消息分发回调函数
function UiHeroQnqh:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_cards.gc_change_souls, self.bindfunc['gc_change_souls']);
	PublicFunc.msg_unregist(msg_cards.gc_neidan_upgrade, self.bindfunc["gc_neidan_upgrade"])
end

function UiHeroQnqh:InitUI(obj)
	UiBaseClass.InitUI(self, obj);

	self.ui:set_name('ui_battle_star_qnqh');

	-- 潜能强化相关
	self.btn_star_exchange = ngui.find_button(self.ui, "centre_other/animation/content/btn1")
	self.btn_star_exchange:set_on_click(self.bindfunc["on_btn_shard_exchange"])

	self.btn_show_property = ngui.find_button(self.ui, "centre_other/animation/content/btn2");
	self.btn_show_property:set_on_click(self.bindfunc["OnBtnBack"]);
	-- TODO:返回

	-- 强化列表WrapContent
	self.neidan_wrap_content = ngui.find_wrap_content(self.ui, "centre_other/animation/content/scroll_view/scrollview_data/wrap_content")
	self.neidan_wrap_content:set_on_initialize_item(self.bindfunc["on_initialize_item"])



	-- 潜能强化属性面板
	self.sp_di_item = self.ui:get_child_by_name("centre_other/animation/cont/sp_di_item")
	self.sp_di_itembg = ngui.find_sprite(self.sp_di_item, "sp")
	self.lbl_sp_item = ngui.find_label(self.sp_di_item, "txt")
	self.grid_qh_property = ngui.find_grid(self.sp_di_item, "grid")
	self.go_qh_property_grid_item = self.sp_di_item:get_child_by_name("grid/cont1")
	self.sp_di_item:set_active(false)
	self:NotifyBattleUiActivityState(false)
	self:UpdateUi();
end


function UiHeroQnqh:on_initialize_item(obj, b, real_id)
	-- app.log(string.format("UiHeroQnqh:on_initialize_item ojb=%s,b=%s,real_id=%s",tostring(obj),tostring(b),tostring(real_id)))
	if not self.is_open_qh then return end
	if not self.go_qh_items[b] then
		self.go_qh_items[b] = {
			btn_ico_qh = ngui.find_button(obj,"sp_bk"),
			sp_qh_bg = ngui.find_sprite(obj,"sp_bk"),
			lbl_qh_name = ngui.find_label(obj,"txt"),
			-- sp_qh_font = ngui.find_sprite(obj,"sp_bk/sp_art_font"),
			lbl_chip_number = ngui.find_label(obj,"content/pro_di/lab"),
			go_content = obj:get_child_by_name("content"),
			lbl_gold_number = ngui.find_label(obj,"go_content/sp_bk/lab"),
			lbl_level = ngui.find_label(obj,"content/lab_level"),
			go_content_btn = obj:get_child_by_name("go_content"),
			btn_act_qh = ngui.find_button(obj,"go_content/btn"),
			sp_top_level = ngui.find_sprite(obj,"sp_top_level"),
			progressbar = ngui.find_progress_bar(obj,"content/pro_di"),
			lbl_btn = ngui.find_label(obj,"go_content/btn/animation/lab"),
		}
	end
	local go_item = self.go_qh_items[b]
	if go_item then
		local _row_data = neidan_cfg_data[b]

		local neidan_cfg = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(self.roleData.config.neidan))
		if neidan_cfg then
			local group_neidan_cfg = neidan_cfg[b]
			if not group_neidan_cfg then
				app.log("not found neidan_cfg,category=" .. tostring(b))
				return
			end

			local _curr_level = self.roleData[_row_data.property_name]
			local neidan_current_level_cfg = group_neidan_cfg[_curr_level]
			local neidan_next_level_cfg = group_neidan_cfg[_curr_level + 1]
			-- 是否拥有下一级配置，用来判断是否显示LevelMax
			local has_next_level = neidan_next_level_cfg ~= nil
			-- app.log(string.format("xxxx: has_next_level [%s],level=%s,group=%s",tostring(has_next_level),table.tostring(neidan_next_level_cfg),table.tostring(group_neidan_cfg)))
			if has_next_level then
				go_item.go_content:set_active(true)
				go_item.sp_top_level:set_active(false)
				--go_item.go_content_btn:set_active(true)
				go_item.btn_act_qh:set_enable(true)
				go_item.lbl_btn:set_effect_color(174/255,65/255,40/255,1)
				go_item.lbl_level:set_text("LV." .. tostring(self.roleData[_row_data.property_name] or 1))

				go_item.btn_act_qh:set_on_click(self.bindfunc["btn_act_qh"])
				go_item.btn_act_qh:set_event_value("", b)

				go_item.progressbar:set_value(g_dataCenter.package:GetCountByNumber(self.need_soul_id)/neidan_current_level_cfg.upgrade_chip)
				go_item.lbl_chip_number:set_text(PublicFunc.GetProgressColorStr(g_dataCenter.package:GetCountByNumber(self.need_soul_id), neidan_current_level_cfg.upgrade_chip))
				go_item.lbl_gold_number:set_text(PublicFunc.GetProgressColorStr(g_dataCenter.player.gold, neidan_current_level_cfg.upgrade_gold, false))
			else
				go_item.go_content:set_active(false)
				go_item.lbl_gold_number:set_text("0")
				--go_item.go_content_btn:set_active(true)
				go_item.sp_top_level:set_active(true)
				go_item.lbl_level:set_text("LV.MAX")
				go_item.btn_act_qh:set_enable(false)
				go_item.lbl_btn:set_effect_color(139/255,139/255,139/255,1)
				
			end

			go_item.sp_qh_bg:set_sprite_name(_row_data.bg_sprite_name)
			-- go_item.sp_qh_font:set_sprite_name(_row_data.sprite_name)
			go_item.lbl_qh_name:set_text(_row_data.name)
		end

		go_item.btn_ico_qh:set_on_ngui_press(self.bindfunc["on_btn_qh_ico_press"])
		go_item.btn_ico_qh:get_parent():set_name(tostring(b))
	end
end

function UiHeroQnqh:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then return end
	if not self.roleData then return end
	self.is_open_qh = self.roleData.rarity >= Const.HERO_MAX_STAR
	if not self.is_open_qh then
		self:Hide()
		--显示升星界面
		local battle_ui = uiManager:FindUI(EUI.BattleUI)
		if battle_ui and battle_ui.upStar and not battle_ui.upStar:IsShow() then
			 battle_ui.upStar:Show()
			 battle_ui:SetToggleScrollViewActive(true)
		end
	else

	end
	self.neidan_wrap_content:set_max_index(0)
	self.neidan_wrap_content:set_min_index(- #neidan_cfg_data)
	self.neidan_wrap_content:reset();
end
 

function UiHeroQnqh:on_btn_shard_exchange(t)
	-- if nil == self.shard_exchange_ui then
	-- 	self.shard_exchange_ui = ShardExchange:new( { info = self.roleData, number_type = t.float_value })
	-- else
	-- 	self.shard_exchange_ui:Show( { info = self.roleData, number_type = t.float_value })
	-- end
		ShardExchange.Start({ info = self.roleData, number_type = t.float_value })
end

function UiHeroQnqh:on_btn_act_qh(t)
	local point = t.float_value

	local neidan_cfg = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(self.roleData.config.neidan))
	local current_level = self.roleData[neidan_cfg_data[point].property_name]
	local neidan_current_level_cfg = neidan_cfg[point][current_level]
	if neidan_current_level_cfg then
		if g_dataCenter.package:GetCountByNumber(self.need_soul_id) < neidan_current_level_cfg.upgrade_chip then
			FloatTip.Float("碎片不足")
			return
		end

		if g_dataCenter.player.gold < neidan_current_level_cfg.upgrade_gold then
			FloatTip.Float("金币不足 ")
			return
		end
		-- 保存当前战斗力
		self.roleData.old_fight_value = self.roleData:GetFightValue()

		msg_cards.cg_neidan_upgrade(self.roleData.index, point)
		self.last_neidan_index = point
	end
	-- g_dataCenter.player.package:find_count(ENUM.EPackageType.Item, self.need_soul_id);

end


function UiHeroQnqh:on_btn_qh_ico_press(name, state, x, y, goObj)
	app.log(string.format("name=%s,state=%s,x=%s,y=%s,goObj=%s", name, tostring(state), tostring(x), tostring(y), tostring(goObj:get_name())))

	self.sp_di_item:set_active(state)
	if (state) then
		local p_name = goObj:get_parent():get_name()
		local index = tonumber(p_name)
		local local_neidan_cfg = neidan_cfg_data[index]
		if neidan_cfg_data then
			self.sp_di_itembg:set_sprite_name(local_neidan_cfg.bg_sprite_name)
			self.lbl_sp_item:set_text(local_neidan_cfg.name)

			-- 获取内丹配置数据

			local neidan_cfg = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(self.roleData.config.neidan))
			if neidan_cfg then
				local _level = self.roleData[local_neidan_cfg.property_name]
				-- app.log(string.format("xxxxxxxxxxx :_level=%s,index=%s,property_name=%s",tostring(_level),tostring(index),local_neidan_cfg.property_name))
				local neidan_level_cfg = neidan_cfg[index][_level]

				local props = { }
				for k, v in pairs(CardHuman.GetDefaultSHowPropertyNames()) do
					local p_data = neidan_level_cfg[v]
					if p_data and p_data > 0 then
						props[v] = p_data
					end
				end

				-- app.log("xxxxxxxxxxxxxxx:"..table.tostring(props))

				if not self.qh_press_propertyListShow then
					self.qh_press_propertyListShow = PropertyListShow:new( {
						info = props,
						pro_item = self.go_qh_property_grid_item,
						format_type = 1,
						pro_grid = self.grid_qh_property
					} )
				else
					self.qh_press_propertyListShow:UpdateUi(props)
				end
			end

		else
			app.log("获取本地潜能强化数据失败")
		end
	end
end

function UiHeroQnqh:on_btn_show_property(t)
	self.go_container1:set_active(true)
	self.go_container2:set_active(false)
end

function UiHeroQnqh:gc_hero_star_up(result)
	UiHeroStarUpAnimation.SetAndShow( { roleData = self.roleData });
	self:UpdateUi();
end

function UiHeroQnqh:gc_neidan_upgrade(result)
	app.log("UiHeroQnqh:on_gc_neidan_upgrade " .. tostring(result))
	if result ~= 0 then
		return
	end
	-- local old_fight_value = self.roleData:GetFightValue()
	AudioManager.Play3dAudio(ENUM.EUiAudioType.LvUpNormal, AudioManager.GetUiAudioSourceNode(), true)
	self.roleData = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, self.roleData.number)
	self:UpdateUi()
	app.log(string.format("new=%s,old=%s", tostring(self.roleData:GetFightValue()), tostring(self.roleData.old_fight_value)))
	--FightValueChangeUI.ShowChange(ENUM.FightingType.Role, self.roleData:GetFightValue(), self.roleData.old_fight_value)
	local neidan_cfg = ConfigManager._GetConfigTable(ConfigManager.SpliceIndexName(self.roleData.config.neidan))

	local current_level = self.roleData[neidan_cfg_data[self.last_neidan_index].property_name]
	local neidan_last_level_cfg = neidan_cfg[self.last_neidan_index][current_level - 1]
	local neidan_current_level_cfg = neidan_cfg[self.last_neidan_index][current_level]
	if nil == neidan_last_level_cfg or nil == neidan_current_level_cfg then
		app.log("error for qnqh config , rolenumber="..tostring(self.roleData.number).." current_level="..tostring(current_level))
		return
	end
	local props = { }
	for k, v in pairs(CardHuman.GetDefaultSHowPropertyNames()) do
		local l_data = neidan_last_level_cfg[v]
		local c_data = neidan_current_level_cfg[v]
		if c_data and l_data then
			if c_data - l_data > 0 then
				props[v] = c_data - l_data
			end
		end
	end
	PopLabMgr.ClearMsg()
	for k, v in pairs(props) do
		local p_name = gs_string_property_name[ENUM.EHeroAttribute[k]]
		local x, y, z = self.go_qh_items[self.last_neidan_index].go_content:get_position()
		-- app.log(string.format("xxxxxxxxxxxxxx:x=%s,y=%s,z=%s",tostring(x),tostring(y),tostring(z)))
		PopLabMgr.PushMsg( { str = string.format("%s +%.0f", p_name,PublicFunc.AttrInteger(v)), world_pos = { x = x, y = y, z = z } })
	end
	
	-- app.log("xxxxxxxxxxxxxxxxxxxxxxx:"..table.tostring(props))
end

function UiHeroQnqh:SetInfo(roleData)
	self.roleData = roleData;
	self.need_soul_id = PublicFunc.GetRoleIdByHeroNumber(self.roleData.config.default_rarity)
	self:UpdateUi();
end

function UiHeroQnqh:OnBtnBack()
	self:Hide()
	self:NotifyBattleUiActivityState(true)
end

function UiHeroQnqh:Show()
	if UiBaseClass.Show(self) then
		-- self:PlayLevelUp(false)
		self:UpdateUi()
		self:NotifyBattleUiActivityState(false)		 
	end
end

  
function UiHeroQnqh:Hide()
	if UiBaseClass.Hide(self) then
		-- self:PlayLevelUp(false)
		-- self.hero_upe_level_log:clear()
		--self:NotifyBattleUiActivityState(true)		 
		PopLabMgr.ClearMsg()
	end
end

function UiHeroQnqh:DestoryUi()
	UiBaseClass.DestroyUi(self)
	self:NotifyBattleUiActivityState(false)
	PopLabMgr.ClearMsg()
end

--隐藏 功能选择栏和升星界面
function UiHeroQnqh:NotifyBattleUiActivityState(state)
	local battle_ui = uiManager:FindUI(EUI.BattleUI)
	if battle_ui then
		battle_ui:SetToggleScrollViewActive(state)
		battle_ui:NotifyStarUpState(state)
	end
end