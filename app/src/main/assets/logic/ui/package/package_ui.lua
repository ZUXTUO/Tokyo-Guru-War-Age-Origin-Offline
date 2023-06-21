PackageUI = Class('PackageUI', UiBaseClass)

local _UIText = {
	["str_all"] = "全部",
	["str_equipment"] = "装备",
	["str_martiral"] = "材料",
	["str_debris"] = "碎片",
	["str_comsumables"] = "消耗品",
	["str_banned_sell"] = "此物品禁止出售",
	["str_format_have_number"] = "拥有  [f5b403]%s[-]  件",
	["str_use"] = "使用",
	["str_forge"] = "合成",
	["str_chests"] = "宝箱",
	["str_item_cant_use"] = "道具无法使用",
	["str_comfirm_sell"] = "确定要出售[%s]吗？",
	["str_ok"] = "出售",
	["str_title"] = "重要提示",
}

local _package_category_data = {
	[ENUM.EPackageItemCategory.All] = { name = _UIText["str_all"], sort = 1, node_name="yeka_all", },
	[ENUM.EPackageItemCategory.Euipment] = { name = _UIText["str_equipment"], sort = 2, node_name="yeka_equip", },
	[ENUM.EPackageItemCategory.Martiral] = { name = _UIText["str_martiral"], sort = 3, node_name="yeka_cailiao", },
	[ENUM.EPackageItemCategory.Debris] = { name = _UIText["str_debris"], sort = 4, node_name="yeka_suipian", },
	[ENUM.EPackageItemCategory.Comsumables] = { name = _UIText["str_comsumables"], sort = 5, node_name="yeka_level", },
}

PackageUI.COL_NUMBER = 4
PackageUI.MIN_ROW_NUMBER = 1



function PackageUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/bag/ui_3201_bag.assetbundle"
	UiBaseClass.Init(self, data)
end

function PackageUI:InitData(data)
	UiBaseClass.InitData(self, data)

	self.selection_category = ENUM.EPackageItemCategory.All
end


function PackageUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["OnCategoryTabBarChanged"] = Utility.bind_callback(self, self.OnCategoryTabBarChanged)
	self.bindfunc["OnInitializePackageItem"] = Utility.bind_callback(self, self.OnInitializePackageItem)
	self.bindfunc["OnItemClicked"] = Utility.bind_callback(self, self.OnItemClicked)
	self.bindfunc["OnBtnSellClicked"] = Utility.bind_callback(self, self.OnBtnSellClicked)
	self.bindfunc["OnBtnUseClicked"] = Utility.bind_callback(self, self.OnBtnUseClicked)
	self.bindfunc["gc_item_sell"] = Utility.bind_callback(self, self.gc_item_sell)
	self.bindfunc["gc_update_item_cards"] = Utility.bind_callback(self,self.gc_update_item_cards)
	self.bindfunc["gc_add_item_cards"] = Utility.bind_callback(self,self.gc_add_item_cards)
	self.bindfunc["gc_delete_item_cards"] = Utility.bind_callback(self,self.gc_delete_item_cards)
end

function PackageUI:MsgRegist()
	UiBaseClass.MsgRegist(self)
	PublicFunc.msg_regist(msg_cards.gc_item_sell, self.bindfunc['gc_item_sell']);
	PublicFunc.msg_regist(msg_cards.gc_item_exchange, self.bindfunc["gc_item_sell"])
	PublicFunc.msg_regist(msg_cards.gc_update_item_cards,self.bindfunc["gc_update_item_cards"])
	PublicFunc.msg_regist(msg_cards.gc_add_item_cards,self.bindfunc["gc_add_item_cards"])
	PublicFunc.msg_regist(msg_cards.gc_delete_item_cards,self.bindfunc["gc_delete_item_cards"])
end

function PackageUI:MsgUnRegist()
	UiBaseClass.MsgRegist(self)
	PublicFunc.msg_unregist(msg_cards.gc_item_sell, self.bindfunc['gc_item_sell']);
	PublicFunc.msg_unregist(msg_cards.gc_item_exchange, self.bindfunc['gc_item_sell']);
	PublicFunc.msg_unregist(msg_cards.gc_update_item_cards,self.bindfunc["gc_update_item_cards"])
	PublicFunc.msg_unregist(msg_cards.gc_add_item_cards,self.bindfunc["gc_add_item_cards"])
	PublicFunc.msg_unregist(msg_cards.gc_delete_item_cards,self.bindfunc["gc_delete_item_cards"])
end

function PackageUI:Restart(data)
	UiBaseClass.Restart(self, data)
end


function PackageUI:InitUI(obj)
	UiBaseClass.InitUI(self, obj);
	self.ui:set_name("package_ui")

	self.nodeYekaArray = { }
	self.go_items = { }

	self.nodeContentNoTip = self.ui:get_child_by_name("centre_other/animation/sp_bk")
	self.nodeContentDetail = self.ui:get_child_by_name("centre_other/animation/content")
	self.wrapContent = ngui.find_wrap_content(self.ui, "centre_other/animation/content/sco_view/panel/wrap_content")
	self.wrapContent:set_on_initialize_item(self.bindfunc["OnInitializePackageItem"])
	self.scrollView = ngui.find_scroll_view(self.ui, "centre_other/animation/content/sco_view/panel")

	-------------------------------- 物品详情 --------------------------------
	self.nodePanelDetail = self.ui:get_child_by_name("centre_other/animation/content")
	self.nodeDetailItemIcon = self.nodePanelDetail:get_child_by_name("sp_title_di/new_small_card_item")
	self.labDetailItemName = ngui.find_label(self.nodePanelDetail, "sp_title_di/lab_name")
	self.labDetailItemCount = ngui.find_label(self.nodePanelDetail, "sp_bk/txt_have_num/lab_have_num")
	self.labDetailItemDesc = ngui.find_label(self.nodePanelDetail, "sp_bk/sco_view/panel/lab")
	self.nodeSaleGold = self.nodePanelDetail:get_child_by_name("sp_bk/txt_cost")
	self.labSaleGoldNum = ngui.find_label(self.nodePanelDetail, "sp_bk/lbl_num")
	-- self.labForbidSale = ngui.find_label(self.nodePanelDetail, "txt")

	self.btnSale = ngui.find_button(self.nodePanelDetail, "sp_bk/btn_sale")
	self.btnSale:set_on_click(self.bindfunc["OnBtnSellClicked"])

	self.btnUse = ngui.find_button(self.nodePanelDetail, "sp_bk/btn_use")
	self.btnUse:set_on_click(self.bindfunc["OnBtnUseClicked"])
	self.labBtnUse = ngui.find_label(self.nodePanelDetail, "sp_bk/btn_use/animation/lab")


	local nodeYekaItem = self.ui:get_child_by_name("centre_other/animation/yeka")
	self:InitCategoryTabBar(nodeYekaItem)
	self:InitializePackageItem()

end



-- 初始化分类bar
function PackageUI:InitCategoryTabBar(baseItem)
	local sort_func = function(t, a, b)
		return t[b].sort > t[a].sort
	end
	for k, v in spairs(_package_category_data, sort_func) do
		local _go_item = baseItem:get_child_by_name(""..v.node_name);
		local _toggle = ngui.find_toggle(_go_item, _go_item:get_name())
		local _lbl_name = ngui.find_label(_go_item, "lab")
		local _lbl_name1 = ngui.find_label(_go_item, "lab1")
		self.nodeYekaArray[k] = { go = _go_item }
		_toggle:set_on_change(self.bindfunc["OnCategoryTabBarChanged"])
		_lbl_name:set_text(v.name)
		_lbl_name1:set_text(v.name)
		_go_item:set_name(tostring(k))
		_go_item:set_active(true)
		if k == ENUM.EPackageItemCategory.All then
			_toggle:set_value(true)
		end
	end
end

function PackageUI:InitializePackageItem()
	self.selection_data = self:GetSelectionData() or { }
	local _min_index = - PackageUI.MIN_ROW_NUMBER
	local selection_data_count = #self.selection_data
	local _row_count = nil
	if selection_data_count > 0 then
		_row_count = math.floor(selection_data_count / PackageUI.COL_NUMBER)
		if _row_count > PackageUI.MIN_ROW_NUMBER then
			_min_index = - _row_count
		end
	end
	self:ShowContentNode()

	self.wrapContent:set_max_index(0)
	self.wrapContent:set_min_index(_min_index)
	self.wrapContent:reset()
	self.scrollView:reset_position()

	if selection_data_count > 0 then
		self:SetSelectedItem(1, 1, 1)
	end
end

function PackageUI:ShowContentNode()
	if #self.selection_data > 0 then
		self.nodeContentNoTip:set_active(false)
		self.nodeContentDetail:set_active(true)
	else
		self.nodeContentNoTip:set_active(true)
		self.nodeContentDetail:set_active(false)
	end
end

function PackageUI:ReInitializePackageItem()
	if true == self.re_init then return end
	self.re_init = true
	self.selection_data = self:GetSelectionData() or { }
	self:ShowContentNode()
	if self.selection_data and #self.selection_data > 0 then
		local max_data_index = 0;
		local max_wrap_index = 0;
		local max_col_index = 0;
		local last_info = self.last_select_item_info
		local t_infos = { }
		if self.go_items then
			for wrapIndex, cols in pairs(self.go_items) do
				for col_index, data in pairs(cols) do
					local item = self.go_items[wrapIndex][col_index]
					local item_info = item.item_info
					local show_fx = item.show_fx
					local row_index = item.row_index
					local data_index =(row_index - 1) * PackageUI.COL_NUMBER + col_index
					local _data = self.selection_data[data_index]
					if _data then
						item_info:SetData(_data.value):SetIsOnPress(false):SetOnClicked(self.bindfunc["OnItemClicked"], nil, nil, { wrapIndex = wrapIndex, row_index = row_index, col_index = col_index })
						max_data_index = math.max(max_data_index, data_index)
						t_infos[data_index] = { wrapIndex = wrapIndex, row_index = row_index, col_index = col_index }
						item_info:Show()
						item_info:SetTipPoint(PublicFunc.BagNeedShowTipPoint(_data.value.number))
						show_fx:set_active(_data.value.config.show_effect == 1)
					else
						item_info:SetData(nil):SetIsOnPress(false):ClearOnClicked()
						item_info:Hide()
						show_fx:set_active(false)
					end

					-- 设置选中框
					if self.last_select_item_info then
						if self.last_select_item_info.wrapIndex ~= wrapIndex or self.last_select_item_info.row_index ~= row_index or self.last_select_item_info.col_index ~= col_index then
							item_info:SetShine(false)
						else
							if _data ~= nil then
								self:SetSelectedItem(self.last_select_item_info.wrapIndex, self.last_select_item_info.row_index, self.last_select_item_info.col_index)
							else
								self.last_select_item_info = nil;
							end
						end
					end
				end
			end
			if self.last_select_item_info == nil then
				local data_index = max_data_index
				while
					(data_index > 0)
				do
					local info = t_infos[data_index]
					if info then
						self:SetSelectedItem(info.wrapIndex, info.row_index, info.col_index)
						break
					end
					data_index = data_index - 1
				end
			end
		end
	else
		self:InitializePackageItem()
	end
	self.re_init = false
end

function PackageUI:OnInitializePackageItem(obj, wrapIndex, realIndex)
	local row_index = math.abs(realIndex) + 1
	wrapIndex = math.abs(wrapIndex + 1)
	-- app.log("PackageUI:OnInitializePackageItem wrapIndex="..tostring(wrapIndex).." realIndex="..tostring(realIndex))
	local _grid = ngui.find_grid(obj, obj:get_name())
	local childs = obj:get_childs()

	for i = 1, PackageUI.COL_NUMBER do
		local col_index = i
		if self.go_items[wrapIndex] == nil or self.go_items[wrapIndex][col_index] == nil then
			if self.go_items[wrapIndex] == nil then
				self.go_items[wrapIndex] = { }
			end
			local fx_checkin_month_right = childs[i]:get_child_by_name("fx_checkin_month_right")
			self.go_items[wrapIndex][col_index] = { item_info = UiSmallItem:new( { parent = childs[i] }), grid = _grid, row_index = row_index, show_fx = fx_checkin_month_right }
		end
		self.go_items[wrapIndex][col_index].row_index = row_index

		local item_info = self.go_items[wrapIndex][col_index].item_info
		local show_fx = self.go_items[wrapIndex][col_index].show_fx

		local data_index =(row_index - 1) * PackageUI.COL_NUMBER + i
		local _data = self.selection_data[data_index]
		-- app.log("OnInitializePackageItem index ="..tostring(index).."data = "..tostring(_data==nil))
		if _data then
			item_info:SetData(_data.value):SetIsOnPress(false):SetOnClicked(self.bindfunc["OnItemClicked"], nil, nil, { wrapIndex = wrapIndex, row_index = row_index, col_index = col_index })
			item_info:Show()
			item_info:SetTipPoint(PublicFunc.BagNeedShowTipPoint(_data.value.number))
			show_fx:set_active(_data.value.config.show_effect == 1)
		else
			item_info:SetData(nil):SetIsOnPress(false):ClearOnClicked()
			item_info:Hide()
			show_fx:set_active(false)
		end

		-- 设置选中框
		if self.last_select_item_info then
			if self.last_select_item_info.wrapIndex ~= wrapIndex or self.last_select_item_info.row_index ~= row_index or self.last_select_item_info.col_index ~= col_index then
				item_info:SetShine(false)
			else
				item_info:SetShine(true)
			end
		end
		-- app.log(string.format("row=%s,col=%s",tostring(realIndex),tostring(i)))
		-- app.log("index="..tostring(index))
	end
end


-- 更新详细按钮
function PackageUI:UpdateDetailBtnInfo()
	-- 出售按钮
	if self:IsAllowSellOfSelectionData() then
		PublicFunc.SetButtonShowMode(self.btnSale, 1)
	else
		PublicFunc.SetButtonShowMode(self.btnSale, 3)
	end
	if self.last_select_item_info then
		local str = _UIText["str_use"]
		local exchange_data = self.last_select_item_info.data.exchange_data
		if exchange_data then
			local _eType = exchange_data.type
			if _eType == 1 then
				str = _UIText["str_forge"]
			elseif _eType == 2 then
				str = _UIText["str_use"]
			elseif _eType == 3 or _eType == 4 then
				str = _UIText["str_use"]
			end
			PublicFunc.SetButtonShowMode(self.btnUse, 2)
		else
			PublicFunc.SetButtonShowMode(self.btnUse, 3)
		end
		self.labBtnUse:set_text(str)
	end
end

function PackageUI:UpdateSellInfo()
	if self:IsAllowSellOfSelectionData() then
		self.nodeSaleGold:set_active(true)
		-- self.labForbidSale:set_active(false)
		self.labSaleGoldNum:set_text(tostring(self.last_select_item_info.data.sell_price))
	else
		self.nodeSaleGold:set_active(false)
		-- self.labForbidSale:set_active(true)
	end
end

-- 标签切换事件
function PackageUI:OnCategoryTabBarChanged(value, name)
	if value then
		if self.isFirst ==nil then
			self.isFirst = true;
		else
			AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
		end
		self.selection_category = tonumber(name)
		self:InitializePackageItem()
		-- app.log(string.format("PackageUI:OnCategoryTabBarChanged value=%s,name=%s,selection_category=%s",tostring(value),name,tostring(self.selection_category)))
		-- app.log(table.tostring(self:GetSelectionData()))
	end
end

function PackageUI:OnItemClicked(t)
	-- app.log("PackageUI:OnItemClicked:"..table.tostring(t.ex_data))
	self:SetSelectedItem(t.ex_data.wrapIndex, t.ex_data.row_index, t.ex_data.col_index)
end

function PackageUI:SetSelectedItem(wrapIndex, row_index, col_index)
	-- app.log(string.format("PackageUI:SetSelectedItem(wrapIndex=%s,row_index=%s,col_index=%s)",tostring(wrapIndex),tostring(row_index),tostring(col_index)))
	if self.selection_data and #self.selection_data > 0 then
		-- self.nodePanelDetail:set_active(true)
	else
		-- self.nodePanelDetail:set_active(false)
		self.last_select_item_info = nil
		return
	end

	local index =(row_index - 1) * PackageUI.COL_NUMBER + col_index
	local select_item = self.go_items[wrapIndex][col_index]
	local select_data = self.selection_data[index].value
	if not self.select_item_info then
		self.select_item_info = UiSmallItem:new( { parent = self.nodeDetailItemIcon ,prop={show_number=false}})
	end
	self.select_item_info:SetData(select_data)
	self.labDetailItemName:set_text(select_data.color_name)
	self.labDetailItemCount:set_text(tostring(select_data.count))
	local desc_ex = ""
	if select_data.description_ex ~= 0 then
		desc_ex = select_data.description_ex
	end

	if desc_ex == "" then
		self.labDetailItemDesc:set_text(select_data.description)
	else
		self.labDetailItemDesc:set_text(select_data.description.."\n"..desc_ex)
	end
	-- TODO：使用限制条件

	-- 设置选中框
	if self.last_select_item_info then
		self.last_select_item_info.item_info:SetShine(false)
	end
	-- app.log(string.format("PackageUI:SetSelectedItem(wrapIndex=%s,row_index=%s,col_index=%s,number=%s)",tostring(wrapIndex),tostring(row_index),tostring(col_index),tostring(select_data.number)))
	select_item.item_info:SetShine(true)
	self.last_select_item_info = { wrapIndex = wrapIndex, row_index = row_index, col_index = col_index, item_info = select_item.item_info, data = select_data, data_index = index }


	self:UpdateSellInfo()
	self:UpdateDetailBtnInfo()

	if PublicFunc.IsBagShowTipItem(select_data.number) then
		local ret = PlayerEnterUITimesCurDay.EnterUI(PublicFunc.GetBagItemSaveKey(select_data.number))
		if ret then
			GNoticeGuideTip(Gt_Enum_Wait_Notice.Item_ExchangeType)

			select_item.item_info:SetTipPoint(PublicFunc.BagNeedShowTipPoint(select_data.number))
		end
	end
end


function PackageUI:OnBtnSellClicked(t)
	if self:IsAllowSellOfSelectionData() then
		-- 极品提示,批量检测
		local sell_func = function()
			msg_cards.cg_item_sell(self.last_select_item_info.data.index, self.last_select_item_info.data.count)
		end
		local batch_sell_func = function()
			PackageBatchAction.ShowAction( { info = self.last_select_item_info.data, action_type = PackageBatchAction.EnumActionType.Sell })
		end
		-- 贵重物品提示
		if self.last_select_item_info.data.config.sale_warn == 1 then
			HintUI.SetAndShowNew(EHintUiType.one,
			_UIText["str_title"], 
			string.format(_UIText["str_comfirm_sell"], self.last_select_item_info.data.color_name),nil,
			{
				str = _UIText["str_ok"],
				func = function()
					-- 批量出售
					if self.last_select_item_info.data.count > 1 then
						batch_sell_func()
					else
						sell_func()
					end
				end
			} )
		else
			if self.last_select_item_info.data.count > 1 then
				batch_sell_func()
			else
				sell_func()
			end
		end
	else
		FloatTip.Float(_UIText["str_banned_sell"])
	end
end



-- TODO:使用规则
function PackageUI:OnBtnUseClicked(t)
	app.log("PackageUI:OnBtnUseClicked")
	if self.last_select_item_info then
		local exchange_data = self.last_select_item_info.data.exchange_data

		if exchange_data then
			if exchange_data.type == 1 then
				-- TODO:合成
				PackageCompoundAction.ShowAction( { info = self.last_select_item_info.data })
			--elseif exchange_data.type == 2 then
				-- TODO：使用
				--PacakgeUse.Use(self.last_select_item_info.data.number)
			elseif exchange_data.type == 2 or exchange_data.type == 3 or exchange_data.type == 5 then
				-- TODO：宝箱				
				if self.last_select_item_info.data.count > 1 then
					PackageBatchAction.ShowAction( { info = self.last_select_item_info.data, action_type = PackageBatchAction.EnumActionType.Use })
				else
                    --体力存储上限
                    if self:CheckCubeSugarLimit(self.last_select_item_info.data) then
                        return
                    end
					msg_cards.cg_item_exchange(self.last_select_item_info.data.index, 1)
				end
			elseif exchange_data.type == 4 then
				--使用(跳转)
				PacakgeUse.Use(self.last_select_item_info.data.number)
			end

		else
			FloatTip.Float(_UIText["str_item_cant_use"])
		end
	end
end

function PackageUI:CheckCubeSugarLimit(data)
    if self:IsCubeSugarItem(data.number) then
        if PublicFunc.CheckApLimit(g_dataCenter.player:GetAP() + data.exchange_data.exchange_num) then
            return true
        end
    end
    return false
end

function PackageUI:IsCubeSugarItem(number)
    return number == 20000306 or number == 20000307 or number == 20000308
end

function PackageUI:IsAllowSellOfSelectionData()
	if self.last_select_item_info then
		return self.last_select_item_info.data.sell_price ~= 0
	end
	return false
end

function PackageUI:GetSelectionData()
	-- app.log("PackageUI:GetSelectionData:"..tostring(self.selection_category))
	local data = { }
	if self.selection_category == ENUM.EPackageItemCategory.All then
		data = g_dataCenter.package:GetAllItemDataExceptZero()
	else
		data = g_dataCenter.package:GetItemData(self.selection_category)
	end

	return data
end
 
function PackageUI:gc_item_sell(result, info)
	if type(info) == "table" then
		-- for k, v in pairs(info) do
			-- UiRollMsg.PushMsg({str="+"..tostring(info),priority=1,number=v.id,count=v.count})
		-- end
		CommonAward.Start(info)
	else
		UiRollMsg.PushMsg( { str = "+" .. tostring(info), priority = 1, number = IdConfig.Gold, count = info })
	end
	self:ReInitializePackageItem()
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ShopMoney);
end

function PackageUI:gc_update_item_cards(info)
	--app.log("PackageUI:gc_update_item_cards"..table.tostring(info))
	self:ReInitializePackageItem()
end

function PackageUI:gc_add_item_cards(info)
	self:ReInitializePackageItem()
end

function PackageUI:gc_delete_item_cards(uuid)
	self:ReInitializePackageItem()
end

function PackageUI:DestroyUi()
	if self.go_items then
		for k, v in pairs(self.go_items) do
			for k1, v1 in pairs(v) do
				if v1.item_info then
					v1.item_info:DestroyUi()
				end
			end
		end
		self.go_items = nil
	end
	if self.select_item_info then
		self.select_item_info:DestroyUi()
		self.select_item_info = nil
	end
	self.nodeYekaArray = nil
	self.last_select_item_info = nil
	UiBaseClass.DestroyUi(self)
	-- self.ui = nil
end
