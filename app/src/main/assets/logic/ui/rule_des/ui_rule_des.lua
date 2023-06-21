-- 规则说明UI
UiRuleDes = Class("UiRuleDes", UiBaseClass)


function UiRuleDes.Start(ruleId)
    if ruleId == nil then
        app.log("ruleId = nil " .. debug.traceback())
        return
    end
    if UiRuleDes.cls == nil then
        UiRuleDes.cls = UiRuleDes:new({ruleId = ruleId})
    end
end

function UiRuleDes.End()
    if UiRuleDes.cls then
        UiRuleDes.cls:DestroyUi()
        UiRuleDes.cls = nil
    end
end

-- 要根据类型加载
local pathRes = {
	ui1 = "assetbundles/prefabs/ui/public/ui_rule_books1.assetbundle";-- 文本、怪物、参与奖励
	ui2 = "assetbundles/prefabs/ui/public/ui_rule_books2.assetbundle";-- 文本、排名奖励
}
local tInsert = table.insert;

function UiRuleDes.GetRes(rType)

	local result = ""

	if rType == 1 then
		result = pathRes.ui1
	elseif rType == 2 then
		result = pathRes.ui2
	end

	return result
end

function UiRuleDes:Init(data)

	UiBaseClass.Init(self, data);
end

function UiRuleDes:Restart(data)
	self.id = data.ruleId
	self.monster_data = { }
	self.monster_desc_data = { }
	self.info_data = { }
	self.temp_data = { }
		self.data = ConfigManager.Get(EConfigIndex.t_rules_des, data.ruleId)

	self.monster_wrap_content = nil
	self.info_wrap_content = nil

	if self:hasData() then
		if self:hasInfoData() then
			self.info_data = self:getInfoData()
		end

		if self:hasMonsterData() then
			self.monster_data = self:getMonsterData()
		end

		if self:hasMonsterDesData() then
			self.monster_desc_data = self:getMonsterDescData()
		end
	end

	-- 竞技场排行榜特殊处理
	if self.id == ENUM.ERuleDesType.JingJiChang then
		-- app.log("当前排名奖励1") --and self.info_data[1] and self.info_data[1].des ~= "JingJiChang"
		if self.info_data ~= nil then
			-- app.log("当前排名奖励2")
			gs_string_rule_des["JingJiChang"] = "当前排名奖励："
			-- 构造数据
			 local step = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena].step
			-- 当前段位
			local rank = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena].rank
						local reward = ConfigManager._GetConfigTable(EConfigIndex.t_arena_day_reward)

			-- 段位奖励
			-- 获取排名奖励
			local i = 1
			local temp_reward = nil
			while i <= table.get_num(reward) do
				if rank >= reward[i].rank_index_max and rank <= reward[i].rank_index_min then
					temp_reward = reward[i]
					break
				end
				i = i + 1
			end

			if temp_reward then
				local temp_drop = { };
				local drop_id = -10000;
				for j = 1, 4 do
					local t = { drop_id = drop_id, goods_id = temp_reward["reward_ID" .. j], goods_show_number = temp_reward["reward_ID" .. j], goods_number = temp_reward["reward_cnt" .. j] }
					table.insert(temp_drop, t)
				end

								ConfigManager._AppendRow(EConfigIndex.t_drop_something, drop_id, temp_drop, false)
				self.info_data[drop_id] = { des = 'JingJiChang', drop_id, }

				-- app.log(table.tostring(self.info_data))
				-- app.log("#########################" .. tostring(rank) .. "##" .. tostring(reward) .. table.tostring(temp_drop))
			end
		end


		-- {goods_id = 3,drop_id = 12000,b = '竞技场钻石组排名第1奖励',goods_show_number = 3,awards_pool = 0,all_random = 0,param = 0,goods_number = 140,probability = 1,}
	end
	-- app.log("Xxxxxxxxxxxxxxxxx" .. table.tostring(self.info_data))
	-- 获取对应的UI资源
	if self.data then
		self.pathRes = UiRuleDes.GetRes(self.data.rtype)
	else
		app.log_warning("没有找到规则说明配置。id：" .. tostring(self.id));
	end
	UiBaseClass.Restart(self, data)
end

function UiRuleDes:InitData(data)
	UiBaseClass.InitData(self, data);
	self.smallItemUIs = { }
end

function UiRuleDes:hasData()
	if self.data ~= nil and type(self.data) == type { } then
		return true
	else
		return false
	end
end
-- 是否有怪物配置信息
function UiRuleDes:hasMonsterData()
	if self:hasData() then
		if self.data.monster ~= nil and type(self.data.monster) == type { } then
			return true
		end
	end
	return false
end

-- 是否有怪物描述信息
function UiRuleDes:hasMonsterDesData()
	if self:hasData() then
		if self.data.monster_desc ~= nil and type(self.data.monster_desc) == type { } then
			return true
		end
	end
	return false
end
-- 是否有排名或者伤害类数据
function UiRuleDes:hasInfoData()
	if self:hasData() then
		if self.data.data ~= nil and type(self.data.data) == type { } then
			return true
		end
	end
	return false
end

-- 获取怪物信息
function UiRuleDes:getMonsterData()
	if self:hasMonsterData() then
		return self.data.monster
	else
		-- app.log("getMonsterData error")
		return nil
	end
end
-- 获取怪物描述信息
function UiRuleDes:getMonsterDescData()
	if self:hasMonsterDesData() then
		return self.data.monster_desc
	end
end
-- 获取排名或者伤害类数据
function UiRuleDes:getInfoData()
	if self:hasInfoData() then
		return self.data.data
	end
end
-- 获取奖励道具信息
function UiRuleDes:getProps(info)

	if info then
		local t = { }
		for k, v in pairs(info) do
			if type(k) == type(0) and type(v) == type(0) then
				table.insert(t, { id = v })
			end
		end

		if t and table.get_num(t) > 0 then
			return self:GetDrops(t[1].id)
		end
	end
	return nil
end
function UiRuleDes:GetDrops(id)
		local drops = ConfigManager.Get(EConfigIndex.t_drop_something, id)
	if drops then
		local t = { }
		for k, v in pairs(drops) do
			if v.goods_show_number and v.goods_show_number ~= 0 then
				table.insert(t, { id = v.goods_show_number, num = v.goods_number })
			end
		end
		return t
	end
	return nil
end

function UiRuleDes:checkData()

end

function UiRuleDes:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_btn_black_mask"] = Utility.bind_callback(self, self.on_btn_black_mask)
	self.bindfunc["init_monster_item_wrap_content"] = Utility.bind_callback(self, self.init_monster_item_wrap_content)
	self.bindfunc["init_info_item_wrap_content"] = Utility.bind_callback(self, self.init_info_item_wrap_content)

end

function UiRuleDes:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

function UiRuleDes:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)

	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(1, 1, 1);
	ngui.find_button(self.ui, "centre_other/animation/content_di_754_458/btn_cha"):set_on_click(self.bindfunc["on_btn_black_mask"])

	self.titletxt = ngui.find_label(self.ui,"centre_other/animation/content_di_754_458/lab_title")
	if self.id == 43 then
		self.titletxt:set_text("全能值")
	else
		self.titletxt:set_text("规则")
	end

	self.lblDesc = ngui.find_label(self.ui, "centre_other/animation/content/panel/cont2/lab")

	if not self.data.desc then
		self.data.desc = ""
	end
	if PublicFunc.check_type_string(self.data.desc) then
		self.lblDesc:set_text(self.data.desc)
	end
	self:InitMonsterUi()
	self:InitInfoUi()
end

function UiRuleDes:InitMonsterUi()
	local item = asset_game_object.find("centre_other/animation/content/panel/cont3/grid/kug1")
	do return end
	local sp_di = ngui.find_sprite(self.ui, "centre_other/content/panel/cont3")
	local m_mons_data = self.monster_data
	local m_desc_infos = self.monster_desc_data
	if m_mons_data and type(m_mons_data) == type { } and table.get_num(m_mons_data) > 0 then
		local height = ngui.find_sprite(item, "kug1"):get_height()
		local index = 1
		for k, v in pairs(m_mons_data) do
			local go = item:clone()
			tInsert(self.temp_data, go)
			local lbl_name = ngui.find_label(go, "lab_name")
			local go_info = go:get_child_by_name("new_small_card_item" .. index)

			local m_info = ConfigManager.Get(EConfigIndex.t_monster_property, v)
			if m_info ~= nil then
				local monster_info = SmallCardUi:new( { parent = go_info, info = CardHuman:new( { number = m_info.id, isNotCalProperty = false }) })
				table.insert(self.temp_data, monster_info)
			end
			if m_desc_infos then
				local lbl_word = ngui.find_label(go, "lab_word")
				local str = gs_string_rule_des[m_desc_infos[k]]
				if str then
					lbl_word:set_text(str)
				end
			end
		end

		sp_di:set_height(height * table.get_num(m_mons_data) + 50)

		local grid = ngui.find_grid(self.ui, "centre_other/animation/content/panel/cont3/grid")
		grid:reposition_now()
		index = index + 1
	else
		local cont3 = self.ui:get_child_by_name("centre_other/animation/content/panel/cont3")
		if cont3 then
			cont3:set_active(false)
		end
	end
	if item then
		item:set_active(false)
	end
end

function UiRuleDes:InitInfoUi()
	local item = self.ui:get_child_by_name("centre_other/animation/content/panel/cont3/grid/kug1")
	-- local sp_di = ngui.find_sprite(self.ui, "centre_other/contents/panel/cont3/sp_di3")
	local data = self.info_data
	-- app.log("xxxxInitInfoUixxx:" .. table.tostring(data))
	local index = 1
	if data and type(data) == type { } and table.get_num(data) > 0 then
		local height = ngui.find_sprite(item, "kug1"):get_height()
		for k, v in pairs(data) do
			local go = nil
			if k == -10000 then
				go = self.ui:get_child_by_name("centre_other/animation/content/panel/cont1/grid/kug1")
			else
				go = item:clone()
			end

			go:set_active(true)
			go:set_name("item" .. k)

			tInsert(self.temp_data, go)

			local lab_title = ngui.find_label(go, "lab_word");
			if lab_title then
				if v.des then
					local str = gs_string_rule_des[v.des]
					if nil ~= str then
						lab_title:set_text(tostring(gs_string_rule_des[v.des]))
					else
						app.log_warning("rule_des not found string_rule." .. tostring(v.des))
						lab_title:set_text("not found string_rule." .. tostring(v.des))
					end
				else
					lab_title:set_text("")
				end
			end


			local items = { }
			local pathPre = "new_small_card_item"
			local props = self:getProps(v)
			-- app.log("xx:" .. table.tostring(props))
			local neenCnt = table.get_num(props)
			for i = 1, 4 do
				items[i] = go:get_child_by_name(pathPre .. i)
				if i <= neenCnt then
					items[i]:set_active(true)
					local prop = props[i]
					local id = prop.id
					local num = prop.num
					local smallItemUI = UiSmallItem:new( { parent = items[i], cardInfo = nil })
					table.insert(self.smallItemUIs, smallItemUI)
					smallItemUI:SetDataNumber(id, num)
				else
					items[i]:set_active(false)
				end

			end
			index = index + 1
		end
		-- sp_di:set_height(height * (table.get_num(data)-1) +60 )
		local grid = ngui.find_grid(self.ui, "centre_other/animation/content/panel/cont3/grid")
		grid:reposition_now()

	else
		local cont3 = self.ui:get_child_by_name("centre_other/animation/content/panel/cont3")
		if cont3 then
			cont3:set_active(false)
		end
	end
	if item then
		item:set_active(false)
	end
end 
 
function DumpTable(t)
	for k, v in pairs(t) do
		if v ~= nil then
			app.log(string.format("Key: %s, Value: %s", tostring(k), tostring(v)))
		else
			app.log(string.format("Key: %s, Value nil", tostring(k)))
		end
	end
end
function UiRuleDes:Show()
	UiBaseClass.Show(self)
end

function UiRuleDes:Hide()
	UiBaseClass.Hide(self)
end

function UiRuleDes:DestroyUi()
	UiBaseClass.DestroyUi(self);

	self.id = data
	self.monster_data = { }
	self.monster_desc_data = { }
	self.info_data = { }
	self.temp_data = { }
end

function UiRuleDes:on_btn_black_mask()
	UiRuleDes.End()
end

UiRuleDesNoNavBar = Class("UiRuleDesNoNavBar", UiRuleDes)
function UiRuleDesNoNavBar:ShowNavigationBar()
	return false
end

UiRuleDesWithoutUiMgr = Class("UiRuleDesWithoutUiMgr", UiRuleDes)
function UiRuleDesWithoutUiMgr:on_btn_black_mask()
	self:DestroyUi();
end