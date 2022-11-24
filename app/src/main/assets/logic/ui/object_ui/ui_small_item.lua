UiSmallItem = Class('UiSmallItem');
--------------------------------------------------
UiSmallItem.EnumSType = {
	Equip = 1,
	Prop = 2,
	Role = 3,
}
-- 初始化
function UiSmallItem:Init(data)
	-- app.log("Init:"..table.tostring(data));
	self.res_group = self._className
	self.resPath = "assetbundles/prefabs/ui/public/new_small_card_item.assetbundle";
	self:InitData(data);
	self:Restart();
end

-- 重新开始
function UiSmallItem:Restart()
	self:RegistFunc();
	self:MsgRegist();
	self:InitUi()
end

-- 初始化数据
function UiSmallItem:InitData(data)
	data = data or { };
	self.ui = nil;
	self.bindfunc = { };
	self.point = { };
	-- 用于小红点使用
	self.eui_id = data.eui_id
	self.parent_path = data.parent_path

	self.is_enable_goods_tip = Utility.get_value(data.is_enable_goods_tip, false)

	-- 位置
	self.load_callback = data.load_callback or nil
	-- 通用UI

	self.isShine = Utility.get_value(data.isShine, false);
	-- 选中框
	self.isMark = Utility.get_value(data.isMark, false);
	-- 遮罩
	self.mask_click = Utility.get_value(data.mask_click, nil);
	-- 遮罩点击事件
	self.btn_add_show = Utility.get_value(data.btn_add_show, false)

	self.equip = data.equip or { }
	-- 装备可选项
	self.equip.new_point = Utility.get_value(self.equip.new_point, false);
	-- 装备小红点
	self.equip.quality = Utility.get_value(self.equip.quality, true)
	-- 装备品级显示
	self.equip.level_tip = Utility.get_value(self.equip.level_tip, false)
	-- 装备升级提示
	self.equip.level = Utility.get_value(self.equip.level, true)
	-- 装备等级显示
	self.equip.star = Utility.get_value(self.equip.star, true)
	-- 装备星级显示

	--使用扫荡图标
	self.use_sweep_icon = Utility.get_value(data.use_sweep_icon, false)

	self.prop = data.prop or { }
	-- 道具可选项
	self.prop.double = false --Utility.get_value(self.prop.double, false)
	-- 双倍图标
	-- self.prop.is_frag =  Utility.get_value(self.prop.is_frag, false)             -- 万能碎片
	self.prop.show_number = Utility.get_value(self.prop.show_number, true)
	-- 是否需要显示数量
	self.prop.number_type = Utility.get_value(self.prop.number_type, 1)
	-- 1(数量),2(拥有数量/需要数量)
	self.needCount = Utility.get_value(self.prop.need_count, 0)
    self.addDefaultCallback = data.add_default_call_back or nil

	-- number_type=2 必填
	-- self.prop.add_btn = self.prop.add_btn or   false            -- 遮罩上面+按钮
	-- self.prop.add_btn_click = self.prop.add_btn_click or nil    --添加按钮点击事件

	self.close_icon = Utility.get_value(data.close_icon, false);
	self.extra_shine = Utility.get_value(data.extra_shine, false);
	self.show_tip_point = Utility.get_value(data.show_tip_point, false);
    self.check = data.check or nil

	-- 数量显示的UILabel

	self.delay = data.delay or 0;
	-- 点下之后，延迟显示，默认为0毫秒
	self.cardInfo = data.cardInfo or data.info or nil;
	-- 传入的OBJ？必须保证节点一致性，不建议使用
	self.parent = data.parent;
	-- 父节点
	self.emptyBorder = data.emptyBorder
	-- 边框可见性
	self.isShow = Utility.get_value(data.isShow, true)
	-- 是否可见
	self.is_on_press = Utility.get_value(data.is_on_press, true)

	self.tuijianText = data.tuijianText;

	self._on_btn_clicked = nil
	self._on_btn_clicked_param = nil

	self._on_btn_add_clicked = nil
	self._on_btn_add_clicked_param = nil

	self._on_btn_press = nil

	-- 蒙版点击回调
	self._on_btn_mark_clicked = nil
	-- 蒙版点击回调参数
	self._on_btn_mark_clicked_param = nil
    -- 变灰
    self.gray = Utility.get_value(data.gray, false)
end


-- 注册回调函数
function UiSmallItem:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
	-- self.bindfunc['on_touch'] = Utility.bind_callback(self, self.on_touch);
	self.bindfunc['on_press'] = Utility.bind_callback(self, self.on_press);
	self.bindfunc['on_drag_move'] = Utility.bind_callback(self, self.on_drag_move);
	self.bindfunc['on_add'] = Utility.bind_callback(self, self.on_add);
	self.bindfunc["on_btn_mark_clicked"] = Utility.bind_callback(self.on_btn_mark_clicked);
	self.bindfunc["OnPressTips"] = Utility.bind_callback(self, self.OnPressTips)
	self.bindfunc["on_clicked"] = Utility.bind_callback(self, self.on_clicked)
	self.bindfunc["on_btn_add_clicked_default"] = Utility.bind_callback(self, self.on_btn_add_clicked_default)
    self.bindfunc["on_check_value_change"] = Utility.bind_callback(self, self.on_check_value_change)
end

-- 注销回调函数
function UiSmallItem:UnregistFunc()
	for k, v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v);
		end
	end
end

-- 注册消息分发回调函数
function UiSmallItem:MsgRegist()
	-- PublicFunc.msg_regist(msg_activity.gc_churchpray_quick,self.bindfunc['gc_speed_up']);
end

-- 注销消息分发回调函数
function UiSmallItem:MsgUnRegist()
	-- PublicFunc.msg_unregist(msg_activity.gc_churchpray_quick,self.bindfunc['gc_speed_up']);
end

function UiSmallItem:SetGray(value)
    if self.gray ~= value then
        self.gray = value
	    self:UpdateUi()
    end
end

function UiSmallItem:SetData(info)
	self.cardInfo = info;
	self:UpdateUi();
	return self
end

function UiSmallItem:GetCardInfo()
	return self.cardInfo
end

function UiSmallItem:SetDataNumber(number, count)
	-- app.log("UiSmallItem:SetDataNumber:"..tostring(number or "nil"))
	local info = nil;
	if number then
		if PropsEnum.IsEquip(number) then
			info = CardEquipment:new( { number = number, count = count });
		elseif PropsEnum.IsItem(number) or PropsEnum.IsVaria(number) then
			info = CardProp:new( { number = number, count = count });
		elseif PropsEnum.IsRole(number) then
			info = CardHuman:new( { number = number, count = count });
		end
	end
	
	self.count = count or nil
	self:SetData(info);
	return self
end

function UiSmallItem:SetShine(isShine)
	self.isShine = isShine;
	if self.sp_shine then
		self.sp_shine:set_active(self.isShine)
	end
	return self
end

function UiSmallItem:SetMark(isMark)
	self.isMark = isMark;
	if self.sp_mark then
		self.sp_mark:set_active(self.isMark)
	end
	-- if self.btn_add then
	--     self.btn_add:set_active(false)
	-- end
	return self
end

-- 设置蒙版点击事件
-- ex: UiSmallItem:SetMarkOnClicked(self.bindfunc["on_btn_mark"], str, number)
-- use: on_btn_mark({string_value=str,float_value=number})
function UiSmallItem:SetMarkOnClicked(callback, ...)
	if callback then
		self._on_btn_mark_clicked = func
		self._on_btn_mark_clicked_param = { ...}
	end
	return self
end

function UiSmallItem:ClearMarkClicked()
	self._on_btn_mark_clicked = nil
	self._on_btn_add_clicked_param = nil
end


function UiSmallItem:SetBtnAddShow(isShow)
	self.btn_add_show = isShow
	if self.btn_add then
		if isShow then
			self:SetMark(true)
		else
			self:SetMark(false)
		end
		self.btn_add:set_active(isShow)

		if isShow ~= self.gray then
			self.gray = isShow
			self:UpdateGrayUi()
		end
	end
	return self
end

function UiSmallItem:SetBtnAdd(isShow, callback, ...)
	return self:SetBtnAddShow(isShow):SetBtnAddOnClicked(callback, ...)
end

function UiSmallItem:SetBtnAddOnClicked(func, ...)
	if func then
		self._on_btn_add_clicked = func
		self._on_btn_add_clicked_param = { ...}
	end
	return self
end

function UiSmallItem:ClearBtnAddClicked()
	self._on_btn_add_clicked = nil
	self._on_btn_add_clicked_param = nil
end



function UiSmallItem:SetNumberType(number_type)
	if number_type then
		self.prop.number_type = number_type
		self:UpdateNumberUI()
	end
end

function UiSmallItem:SetCount(count)
	self.count = count;
	self:UpdateNumberUI();
end

function UiSmallItem:SetTuiJianLab(text)
	self.tuijianText = text;
	local slot_sp_tuijian = self:GetSlotUiData("sp_tuijian")
	if slot_sp_tuijian.labTuijian and slot_sp_tuijian.spTuijian then
		if text then
			slot_sp_tuijian.spTuijian:set_active(true);
			slot_sp_tuijian.labTuijian:set_text(self.tuijianText);
		else
			slot_sp_tuijian.spTuijian:set_active(false);
		end
	end
end

function UiSmallItem:SetNeedCount(count)
	self.needCount = count;
	self:UpdateNumberUI();
end

-- obsolete use SetShowNumber instead of this
function UiSmallItem:SetLabNum(isShow)
	return self:SetShowNumber(isShow)
end

function UiSmallItem:SetShowNumber(isShow)
	self.prop.show_number = isShow;
	if isShow then
		local slot_prop = self:GetSlotUiData("prop")
		slot_prop.lbl_prop_num:set_active(true)
		self:CheckPropNodeState(slot_prop)
	else
		if self:IsLoadSlotUiData("prop") then
			local slot_prop = self:GetSlotUiData("prop")
			slot_prop.lbl_prop_num:set_active(false)
		end
	end
	return self
end

function UiSmallItem:SetNumberStr(str)
	if str == "" then
		if self:IsLoadSlotUiData("prop") then
			local slot_prop = self:GetSlotUiData("prop")
			if slot_prop.lbl_prop_num then
				slot_prop.lbl_prop_num:set_text("")
			end
		end
	else
		local slot_prop = self:GetSlotUiData("prop")
		if slot_prop.lbl_prop_num then
			slot_prop.lbl_prop_num:set_text(tostring(str))
		end
		self:CheckPropNodeState(slot_prop)
	end
end

function UiSmallItem:SetCloseIcon(isShow)
	self.close_icon = isShow
	if self.sp_close_icon then
		self.sp_close_icon:set_active(self.close_icon)
	end
end

function UiSmallItem:SetExtraShine(isShow)
	self.extra_shine = isShow
	if self.sp_extra_shine then
		self.sp_extra_shine:set_active(self.extra_shine)
	end
end

function UiSmallItem:SetCallBack(callback, callback_obj)
	self.callback = callback;
	self.callback_obj = callback_obj;
	return self
end
 

function UiSmallItem:SetCallBackParam(param)
	self.callbackParam = param
	return self
end

function UiSmallItem:SetOnClicked(func, ...)
	if func then
		self._on_btn_clicked = func
		self._on_btn_clicked_param = { ...}
	end
	return self
end

function UiSmallItem:ClearOnClicked()
	self._on_btn_clicked = nil
	self._on_btn_clicked_param = nil
	return self
end

function UiSmallItem:on_clicked(t)
	if self._on_btn_clicked then
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn);
		-- app.log("UiSmallItem:on_clicked"..table.tostring(t))
		if type(self._on_btn_clicked) == "function" then
			self._on_btn_clicked( { string_value = self._on_btn_clicked_param[1], float_value = self._on_btn_clicked_param[2], ex_data = self._on_btn_clicked_param[3] })
		else
			local func = _G[self._on_btn_clicked]
			if func then
				func( { string_value = self._on_btn_clicked_param[1], float_value = self._on_btn_clicked_param[2], ex_data = self._on_btn_clicked_param[3] })
			end
		end
	end
end
 

function UiSmallItem:SetOnPress(callback)
	self._on_btn_press = callback
	return self
end


function UiSmallItem:SetIsOnPress(value)
	self.is_on_press = value
	return self
end

function UiSmallItem:ClearOnPress()
	-- self.is_on_press = false
	self:SetOnPress(nil)
end

-- 显示ui
function UiSmallItem:Show()
	self.isShow = true

	if not self.ui then
		return;
	end
	self.ui:set_active(true);
end

-- 隐藏ui
function UiSmallItem:Hide()
	self.isShow = false

	if not self.ui then
		return;
	end
	self.ui:set_active(false);
end



function UiSmallItem:GetItemType()
	local resultType = nil
	if not self.cardInfo then
		resultType = nil
	else
		if PropsEnum.IsEquip(self.cardInfo.number) then
			resultType = UiSmallItem.EnumSType.Equip
		elseif PropsEnum.IsItem(self.cardInfo.number) or PropsEnum.IsVaria(self.cardInfo.number) then
			resultType = UiSmallItem.EnumSType.Prop
		elseif PropsEnum.IsRole(self.cardInfo.number) then
			resultType = UiSmallItem.EnumSType.Role
		end
	end
	if resultType == nil then
		app.log("UiSmallItem:GetItemType error 没有找到正确到道具类型 " .. tostring(self.cardInfo.number))
	end
	-- app.log("UiSmallItem.GetItemType "..tostring(resultType).." number"..tostring(self.cardInfo.number))
	return resultType
end

-- 初始化UI
function UiSmallItem:InitUi()
	if self.ui == nil then
		if CommonUiObjectManager.IsEnable() then
			self.ui = CommonUiObjectManager.CreateObject( ECommonUi_Type.SmallItem )
			self:SetParent(self.parent);
			self:SetScale(self.scale);
			self:SetPosition(self.point.x, self.point.y, self.point.z);
			self.ui:set_name("small_item_ui")
			self:FindNguiObject(self.ui);
			
			if self.loadedCallBack then
				Utility.CallFunc(self.loadedCallBack, self.loadedCallParam)
				self.loadedCallBack = nil
				self.loadedCallParam = nil
			end
		else
			ResourceLoader.LoadAsset(self.resPath, self.bindfunc["on_loaded"], self.res_group)
		end
	end
end

function SmallCardUi.SetLoadedCallback(cb)
	self.loadedCallBack = cb
end

function UiSmallItem:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.resPath then
		self.ui = asset_game_object.create(asset_obj);
		self:SetParent(self.parent);
		self:SetScale(self.scale);
		self:SetPosition(self.point.x, self.point.y, self.point.z);
		self.ui:set_name("small_item_ui")
		self:FindNguiObject(self.ui);

		if self.loadedCallBack then
			Utility.CallFunc(self.loadedCallBack, self.loadedCallParam)
			self.loadedCallBack = nil
			self.loadedCallParam = nil
		end
	end
end

function UiSmallItem:SetLoadedCallback(cb, param)
	if self.ui then
		Utility.CallFunc(cb, param)
	else
		self.loadedCallBack = cb
		self.loadedCallParam = param
	end
end

function UiSmallItem:LoadSlotProp(obj)
	self.slot_data.prop.obj = obj

	self.slot_data.prop.lbl_prop_num = ngui.find_label(obj, "lab_num")
	self.slot_data.prop.lbl_prop_num:set_active(false)
	self.slot_data.prop.lbl_double = ngui.find_label(obj, "lab_beishu")
	self.slot_data.prop.lbl_double:set_active(false)
	self.slot_data.prop.sp_rarity = ngui.find_sprite(obj,"sp")
	self.slot_data.prop.lbl_rarity = ngui.find_label(obj,"sp/lab")
	self.slot_data.prop.sp_fight = ngui.find_sprite(obj, "sp_fight")
end

function UiSmallItem:LoadSlotEquip(obj)
	self.slot_data.equip.obj = obj
	
	self.slot_data.equip.lbl_equip_level = ngui.find_label(obj, "lab_level")
	local sp_level_animation = obj:get_child_by_name("animation")
	self.slot_data.equip.sp_level_animation = sp_level_animation
	self.slot_data.equip.sp_level_up = ngui.find_sprite(sp_level_animation, "sp")
	self.slot_data.equip.sp_level_up:set_active(false)
	local go_star = obj:get_child_by_name("contain_star")
	self.slot_data.equip.go_star = go_star
	self.slot_data.equip.grid_star = ngui.find_grid(go_star, "contain_star")
	local sp_stars = {}
	for i = 1, Const.EQUIP_MAX_STAR do
		sp_stars[i] = ngui.find_sprite(go_star, "sp_star" .. i)
	end
	self.slot_data.equip.sp_stars = sp_stars
	self.slot_data.equip.grid_equip_euality = ngui.find_grid(obj, "contail_qh")
	local go_equip_quality = obj:get_child_by_name("contail_qh")
	self.slot_data.equip.go_equip_quality = go_equip_quality
	local sp_qualitys = {}
	for i = 1, Const.EQUIP_MAX_QULITY_LEVEL do
		sp_qualitys[i] = ngui.find_sprite(go_equip_quality, "sp" .. i)
	end
	self.slot_data.equip.sp_qualitys = sp_qualitys
end

function UiSmallItem:LoadSlotSpCheck(obj)
	self.slot_data.sp_check.obj = obj
	self.slot_data.sp_check.toggle_check = ngui.find_toggle(obj, "sp_check")
end

function UiSmallItem:LoadSlotFxCheckinMonth(obj)
	self.slot_data.fx_checkin_month.obj = obj
	self.slot_data.fx_checkin_month.objCommonEffect = obj
	local commonEffect = obj:get_child_by_name("fx_checkin_month/fx_checkin_month")
	self.slot_data.fx_checkin_month.commonEffect = commonEffect
	self.slot_data.fx_checkin_month.isParentInitScale = false
end

function UiSmallItem:LoadSlotSpTishi(obj)
	self.slot_data.sp_tishi.obj = obj
	self.slot_data.sp_tishi.sp_new_point = ngui.find_sprite(obj, "sp_tishi")
end

function UiSmallItem:LoadSlotSpTuijian(obj)
	self.slot_data.sp_tuijian.obj = obj
	self.slot_data.sp_tuijian.spTuijian = ngui.find_sprite(obj, "sp_tuijian")
	self.slot_data.sp_tuijian.labTuijian = ngui.find_label(obj, "lab")
end

function UiSmallItem:InitSlotUiData()
	-- 按需加载的节点
	self.slot_data = {}
	self.slot_data.prop = {load_func=self.LoadSlotProp}
	self.slot_data.equip = {load_func=self.LoadSlotEquip}
	self.slot_data.sp_check = {load_func=self.LoadSlotSpCheck}
	self.slot_data.fx_checkin_month = {load_func=self.LoadSlotFxCheckinMonth}
	self.slot_data.sp_tishi = {load_func=self.LoadSlotSpTishi}
	self.slot_data.sp_tuijian = {load_func=self.LoadSlotSpTuijian}

	if not CommonUiObjectManager.IsEnable() then
		for name, data in pairs(self.slot_data) do
			local obj = self.ui:get_child_by_name(name)
			data.load_func(self, obj)
		end
	end
end

function UiSmallItem:DestroySlotUiData()
	self.slot_data = nil
end

function UiSmallItem:GetSlotUiData(name)
	local data = self.slot_data[name]
	if data and data.obj == nil then
		data.load_func(self, 
			CommonUiObjectManager.AddMaskComponent(self.ui, ECommonUi_Type.SmallItem, name))
	end
	return data
end

function UiSmallItem:IsLoadSlotUiData(name)
	local data = self.slot_data[name]
	return data.obj ~= nil
end

-- 寻找ngui对象
function UiSmallItem:FindNguiObject(obj)
	self:InitSlotUiData()

	self.btn = ngui.find_button(obj, obj:get_name() .. '/sp_back1');
	self.btn:reset_on_click();
	self.btn:set_on_click(self.bindfunc['on_clicked'], "MyButton.NoneAudio");
	self.btn:set_on_ngui_press(self.bindfunc['on_press']);
	self.btn:set_on_ngui_drag_move(self.bindfunc['on_drag_move']);

	-- 通用底板，不用变化
	self.sp_frame = ngui.find_sprite(obj,"sp_frame")
	self.sp_frame:set_active(true);
	self.sp_mark = ngui.find_sprite(obj, "sp_mark");
	self.sp_mark:set_active(false);

	local btnAdd1 = ngui.find_button(obj, "sp_mark/sp_kesaodang")
	local btnAdd2 = ngui.find_button(obj, "sp_mark/sp_add")
	if self.use_sweep_icon then
		btnAdd1:set_active(true)
		btnAdd2:set_active(false)
		self.btn_add = btnAdd1
	else
		btnAdd1:set_active(false)
		btnAdd2:set_active(true)
		self.btn_add = btnAdd2
	end
	if self.btn_add then
		self.btn_add:reset_on_click();
		self.btn_add:set_on_click(self.bindfunc["on_add"]);
	end

	self.sp_shine = ngui.find_sprite(obj, "icon/sp_shine");
	if self.sp_shine then
		self.sp_shine:set_active(self.isShine);
	end
	self.texture = ngui.find_texture(obj, "icon/texture");
	self.sp_human = ngui.find_sprite(obj, "icon/sp_human");

	-- 已加道具材料
	self.sp_close_icon = ngui.find_sprite(self.ui, "sp_x")
	self.sp_extra_shine = ngui.find_sprite(self.ui, "sp_shine_frame")

	-- 道具勾选状态
    if self.check then
        self.curr_check_value = self.check.default_value
        --默认状态
        self.is_first_default_check = true
		local slot_sp_check = self:GetSlotUiData("sp_check")
        slot_sp_check.toggle_check:set_active(true)
        slot_sp_check.toggle_check:set_value(self.check.default_value)
        slot_sp_check.toggle_check:set_on_change(self.bindfunc['on_check_value_change'])
    end

	obj:set_active(self.isShow)
	if self.isShow == false then return end
	self:SetOnPress(self.bindfunc["OnPressTips"])
	if self.load_callback and type(self.load_callback) == "function" then
		self.load_callback(self)
	end

	self:UpdateUi();
end

function UiSmallItem:AddRarityEffect(ef)
    self.objRarityEffect = ef
    if self.objRarityEffect == nil then
        return
    end
    local info = PublicFunc.GetRarityInfo(self.cardInfo.rarity + 1)
	if info then
		local slot_fx_checkin_month = self:GetSlotUiData("fx_checkin_month")
        if info.level == 0 then
            slot_fx_checkin_month.objCommonEffect:set_active(true)
        else
            slot_fx_checkin_month.objCommonEffect:set_active(false)
			local slot_equip = self:GetSlotUiData("equip")
            local sp_quality = slot_equip.sp_qualitys[info.level]
		    if sp_quality then
                self._rarityEffect = self.objRarityEffect:clone()
                self._rarityEffect:set_parent(sp_quality:get_game_object()) 
                self._rarityEffect:set_local_position(0, 0, 0)
                self._rarityEffect:set_active(false)
                self._rarityEffect:set_active(true)
		    end
        end
	end

	self:CheckParentInitScale()
end

function UiSmallItem:SetAsReward(v)
    if v ~= nil then
        self.asReward = v
    end
	local slot_fx_checkin_month = self:GetSlotUiData("fx_checkin_month")
    if slot_fx_checkin_month.objCommonEffect then
        if self.asReward then
            slot_fx_checkin_month.objCommonEffect:set_active(true)
        else
            slot_fx_checkin_month.objCommonEffect:set_active(false)
        end
    end	

	self:CheckParentInitScale()
end

function UiSmallItem:CheckParentInitScale()
	if self.parent == nil then return end

	local slot_fx_checkin_month = self:GetSlotUiData("fx_checkin_month")
	if slot_fx_checkin_month.commonEffect and not slot_fx_checkin_month.isParentInitScale then
		slot_fx_checkin_month.isParentInitScale = true
    	local x, y, z = slot_fx_checkin_month.commonEffect:get_local_scale();
    	local px, py, pz = self.parent:get_local_scale();
    	slot_fx_checkin_month.commonEffect:set_local_scale(px*x, py*y, py*z);
	end
end

function UiSmallItem:SetCommonEffectScale(x, y, z)
	local slot_fx_checkin_month = self:GetSlotUiData("fx_checkin_month")
    if slot_fx_checkin_month.commonEffect then
        slot_fx_checkin_month.commonEffect:set_local_scale(x, y, z)
    end
end

function UiSmallItem:SetExtFx(obj)
    self.objExtFx = obj
end

function UiSmallItem:GetExtFx(obj)
    return self.objExtFx
end

function UiSmallItem:UpdateExtraSp()
	if self.sp_close_icon then
		self.sp_close_icon:set_active(self.close_icon)
	end

	if self.sp_extra_shine then
		self.sp_extra_shine:set_active(self.extra_shine)
	end
end

function UiSmallItem:UpdateNumberUI()
	-- 显示数量消耗型、数量型
	if self.prop.show_number then
		local p_count = nil
		if self.prop.number_type == 1 then
			if not self.count then
				if not self.cardInfo.index then
					p_count = g_dataCenter.package:GetCountByNumber(self.cardInfo.number)
				else
					p_count = g_dataCenter.package:GetItemCountByDataId(self.cardInfo.index)
				end
			else
				p_count = self.count
			end
			self:SetNumberStr(tostring(p_count))
			-- self:SetBtnAdd(false)
		elseif self.prop.number_type == 2 then
			if not self.needCount then
				app.log("UiSmallItem:UpdatePropUi 没有设置需要的数量 SetNeedCount")
			end
			p_count = self.count or g_dataCenter.package:GetCountByNumber(self.cardInfo.number)
			self:SetNumberStr(PublicFunc.GetProgressColorStr(p_count, self.needCount or 0, true, 0))
			-- 如果设置了needCount
			if self.needCount then
				if p_count < self.needCount then
					self:SetBtnAdd(true, self.bindfunc["on_btn_add_clicked_default"], "", self.cardInfo.number)
				else
					self:SetBtnAdd(false, nil)
				end
			end

		elseif self.prop.number_type == 3 then
			--仅做展示
			local usedCount = self.needCount or 0
			p_count = self.count or g_dataCenter.package:GetCountByNumber(self.cardInfo.number)
			self:SetNumberStr(usedCount.."/"..p_count)
		end
	end
end

function UiSmallItem:UpdateIcon()
	if self.cardInfo then
		if PropsEnum.IsRoleSoul(self.cardInfo.number) then
			self.texture:set_active(false)
			self.sp_human:set_active(true)
			self.sp_human:set_sprite_name(self.cardInfo.small_icon)
		else
			self.texture:set_active(true)
			self.sp_human:set_active(false)

			if self.cardInfo.small_icon and self.cardInfo.small_icon ~= 0 then
				self.texture:set_texture(self.cardInfo.small_icon);
			end
		end

	else
		self.texture:set_active(false)
		self.sp_human:set_active(false)
	end

end

--[[装备小红点，及升级动画]]
function UiSmallItem:SetEquipTips()
    -- TODO:装备小提示逻辑
	local slot_equip = self:GetSlotUiData("equip")
	local slot_sp_tishi = self:GetSlotUiData("sp_tishi")
	if self.equip.new_point then
		self.show_tip_point = PublicFunc.ToBoolTip(self.cardInfo:CanStarUp()) or PublicFunc.ToBoolTip(self.cardInfo:CanRarityUp())
		slot_sp_tishi.sp_new_point:set_active(self.show_tip_point)
		slot_equip.sp_level_up:set_active(PublicFunc.ToBoolTip(self.cardInfo:CanLevelUp()))
	end
end

function UiSmallItem:SetTipPoint(b)
	self.show_tip_point = Utility.get_value(b, false)
	local sp = self:GetSlotUiData("sp_tishi").sp_new_point
	if sp then
		sp:set_active(self.show_tip_point)
	end
end

-- 刷新装备UI
function UiSmallItem:UpdateEquipUi()

	if self.cardInfo and PropsEnum.IsEquip(self.cardInfo.number) then
		local slot_equip = self:GetSlotUiData("equip")
		slot_equip.obj:set_active(true)
		if self:IsLoadSlotUiData("prop") then
			self:GetSlotUiData("prop").obj:set_active(false)
		end

		-- self.sp_new_point:set_active(self.equip.new_point)
		slot_equip.go_equip_quality:set_active(self.equip.quality)

		slot_equip.sp_level_animation:set_active(self.equip.level_tip)
		slot_equip.lbl_equip_level:set_active(self.equip.level)

		slot_equip.go_star:set_active(self.equip.star)
		
        self:SetEquipTips()

		-- 装备等级
		if self.equip.level then
			slot_equip.lbl_equip_level:set_text(tostring(self.cardInfo.level))
		end
		-- 装备品质
		-- TODO:装备品质数据
		if self.equip.quality then
			local info = PublicFunc.GetRarityInfo(self.cardInfo.rarity + 1)
			if info then
				self.sp_frame:set_sprite_name(info.boxName)
	 
		 		self.btn:set_sprite_names(info.frameName,"","","")
				for i, sp_quality in ipairs(slot_equip.sp_qualitys) do
					sp_quality:set_sprite_name(info.rarityName)
					sp_quality:set_active(i <= info.level)
				end
			end
			slot_equip.grid_equip_euality:reposition_now()
		end

		-- 装备星级
		if self.equip.star then
			for i = 1, #slot_equip.sp_stars do
				slot_equip.sp_stars[i]:set_active(i <= self.cardInfo.star)
			end
			slot_equip.grid_star:reposition_now()
		end
		-- if self.equip.star or self.equip.quality then
		-- 	util.refresh_all_panel()
		-- end
	end
end
 
-- 刷新道具UI PropsEnum.IsItem & PropsEnum.IsVaria
function UiSmallItem:UpdatePropUi()
	if not self.cardInfo then return end
	
	local id = self.cardInfo.number
	if not id then
		app.log("UiSmallItem:UpdatePropUi 没有正确的道具ID:" .. table.tostring(self.cardInfo))
		return
	end	

	if PropsEnum.IsItem(id) or PropsEnum.IsVaria(id) or PropsEnum.IsRole(id) then
		local slot_prop = self:GetSlotUiData("prop")
		slot_prop.obj:set_active(true)
		if self:IsLoadSlotUiData("equip") then
			self:GetSlotUiData("equip").obj:set_active(false)
		end
       
		local item_cfg = ConfigManager.Get(EConfigIndex.t_item, self.cardInfo.number)
		if not item_cfg then
			app.log_warning("not found item "..tostring(self.cardInfo.number))
			return
		end

    	if PropsEnum.IsItem(id) then		    
    		-- local rarity_info = {
    		-- 	[1] = { sprite_name = "tx_pz_lvse", rgb= {r=138/255,g=1,b=0}},
    		-- 	[2] = { sprite_name = "tx_pz_lanse", rgb= {r=0,g=246/255,b=1}},
    		-- 	[3] = { sprite_name = "tx_pz_zise", rgb= {r=1,g=0,b=252/255}},
    		-- 	[4] = { sprite_name = "tx_pz_chengse", rgb= {r=1,g=156/255,b=0}},
    		-- 	[5] = { sprite_name = "tx_pz_hongse",rgb= {r=1,g=35/255,b=35/255} },    			
    		-- }
			local rarity_sprite_name = {
    			"tx_pz_lvse", 
				"tx_pz_lanse", 
				"tx_pz_zise", 
				"tx_pz_chengse", 
				"tx_pz_hongse",  			
    		}
	        if item_cfg.right_flag == nil or item_cfg.right_flag == 0 or item_cfg.rarity == 0  then	        	
	            slot_prop.sp_rarity:set_active(false)
	        else
	        	local sprite_name = rarity_sprite_name[item_cfg.rarity-1]
	            slot_prop.sp_rarity:set_active(true)
	            slot_prop.sp_rarity:set_sprite_name(sprite_name)
	            slot_prop.lbl_rarity:set_text("+" .. item_cfg.right_flag)
	        end
	    else
	        slot_prop.sp_rarity:set_active(false)
	    end


		slot_prop.sp_fight:set_active((item_cfg and item_cfg.category == 6) or false)

		self:SetShowNumber(self.prop.show_number):SetMark(self.isMark):SetBtnAddShow(self.btn_add_show)

		self.sp_frame:set_sprite_name(PublicFunc.GetIconFrame(self.cardInfo.number).."k")


		local btn_stat_name = PublicFunc.GetIconFrame(self.cardInfo.number)
		self.btn:set_sprite_names(btn_stat_name,"","","")
	else
		if self:IsLoadSlotUiData("prop") then
			self:GetSlotUiData("prop").obj:set_active(false)
		end
	end
end

-- 刷新界面
function UiSmallItem:UpdateUi()
	if not self.ui then
		return
	end
	if self.cardInfo then
		-- self:SetOnPress(self.bindfunc["OnPressTips"])
		self:UpdatePropUi()
		self:UpdateEquipUi()
		self:UpdateNumberUI()
		self:UpdateExtraSp()
		if self.frameName then
			self:SetFrame(self.frameName)
		else
			-- PublicFunc.SetIconFrameSprite(self.sp_frame,self.cardInfo.rarity);
		end
		if self.tuijianText then
			self:SetTuiJianLab(self.tuijianText);
		end
		-- self.texture:set_active(true)
	else
		PublicFunc.SetIconFrameSpritek(self.sp_frame, 1)
		self:SetMark(false)
		self:SetShine(false)

		if self:IsLoadSlotUiData("prop") then
			self:GetSlotUiData("equip").obj:set_active(false)
		end
		if self:IsLoadSlotUiData("equip") then
			self:GetSlotUiData("equip").obj:set_active(false)
		end
		self.texture:set_active(false)

		self:ClearOnPress()
	end
	self:UpdateIcon()
	self:SetAsReward()
	self:SetDouble(self.double_num)
	if true == self.is_enable_goods_tip then
		self:SetEnablePressGoodsTips(true)
	end

    --变灰
    self:UpdateGrayUi()
	self:SetTipPoint(self.show_tip_point)
end

function UiSmallItem:UpdateGrayUi()
	if not self.ui then		
		return
	end
    if self.cardInfo == nil then
        return
    end

    if self.gray then
        --PublicFunc.SetUISpriteGray(self.sp_frame)
        PublicFunc.SetUISpriteGray(self.sp_shine)
        if self.texture then
            self.texture:set_color(0, 0, 0, 1)
        end
        PublicFunc.SetUISpriteGray(self.sp_human)

		if self:IsLoadSlotUiData("sp_tishi") then
        	PublicFunc.SetUISpriteGray(self:GetSlotUiData("sp_tishi").sp_new_point)
		end
		if self:IsLoadSlotUiData("equip") then
			local slot_equip = self:GetSlotUiData("equip")
        	PublicFunc.SetUISpriteGray(slot_equip.sp_level_up)

			for _v in pairs(slot_equip.sp_stars) do
                PublicFunc.SetUISpriteGray(v)
            end
			 for _, v in pairs(slot_equip.sp_qualitys) do
                PublicFunc.SetUISpriteGray(v)
            end
		end

		if self:IsLoadSlotUiData("prop") then
			local slot_prop = self:GetSlotUiData("prop")
			if slot_prop.obj:get_active() then
				PublicFunc.SetUISpriteGray(slot_prop.sp_rarity)
				PublicFunc.SetUISpriteGray(slot_prop.sp_fight)
			end
		end
    else
        --PublicFunc.SetUISpriteWhite(self.sp_frame)
        PublicFunc.SetUISpriteWhite(self.sp_shine)
        if self.texture then
            self.texture:set_color(1, 1, 1, 1)
        end
        PublicFunc.SetUISpriteWhite(self.sp_human)

		if self:IsLoadSlotUiData("sp_tishi") then
        	PublicFunc.SetUISpriteWhite(self:GetSlotUiData("sp_tishi").sp_new_point)
		end
		if self:IsLoadSlotUiData("equip") then
			local slot_equip = self:GetSlotUiData("equip")
        	PublicFunc.SetUISpriteWhite(self:GetSlotUiData("equip").sp_level_up)
			
			for _v in pairs(slot_equip.sp_stars) do
                PublicFunc.SetUISpriteWhite(v)
            end
			for _v in pairs(slot_equip.sp_qualitys) do
                PublicFunc.SetUISpriteWhite(v)
            end
		end 

		if self:IsLoadSlotUiData("prop") then
			local slot_prop = self:GetSlotUiData("prop")
			if slot_prop.obj:get_active() then
				PublicFunc.SetUISpriteWhite(slot_prop.sp_rarity)
				PublicFunc.SetUISpriteWhite(slot_prop.sp_fight)
			end
		end
    end
end



function UiSmallItem:on_touch()
	if self.callback then
		self.callback(self.callback_obj, self, self.callbackParam);
	end
end

function UiSmallItem:on_add()
	if self._on_btn_add_clicked then
		_G[self._on_btn_add_clicked]( {
			string_value = self._on_btn_add_clicked_param[1],
			float_value = self._on_btn_add_clicked_param[2]
		} )

	end
end

function UiSmallItem:on_btn_mark_clicked()
	if self._on_btn_mark_clicked then
		_G[self._on_btn_add_clicked]( {
			string_value = self._on_btn_mark_clicked_param[1],
			float_value = self._on_btn_mark_clicked_param[2]
		} )
	end
end


function UiSmallItem:on_press(name, state, x, y, gameObj)
	--app.log("self.is_on_press=" .. tostring(self.is_on_press) .. "self._on_btn_press:" .. tostring(self._on_btn_press))
	local curWidth = app.get_screen_width();
	local curHeight = app.get_screen_height();
	self.pressX = x / curWidth * 1280;
	self.pressY = y / curHeight * 720;
	if true == self.is_on_press and nil ~= self._on_btn_press then
		if type(self._on_btn_press) == "function" then
			self._on_btn_press(name, state, x, y, gameObj, self)
		else
			_G[self._on_btn_press](name, state, x, y, gameObj,self)
		end
	end
end

function UiSmallItem:OnPressTips(name, state, x, y, gameobj)
	if self.delay and self.delay < 0 then
		return
	end
	if state == true then
		if self.cardInfo then
			local worldX, worldY, worldZ = gameobj:get_position();
			local uiCamera = Root.get_ui_camera();
			local screenX,screenY = uiCamera:world_to_screen_point(worldX, worldY, worldZ);
			local sizeX, sizeY = gameobj:get_box_collider_size();
			--app.log("name="..tostring(gameobj:get_name()).." x="..tostring(screenX).." y="..tostring(screenY));
			--默认都是上边缘
			GoodsTips.EnableGoodsTips(true, self.cardInfo.number, self.cardInfo.count, screenX, screenY, sizeY, self.cardInfo.level, self.delay)
		end
	else
		GoodsTips.EnableGoodsTips(false)
	end
end


function UiSmallItem:SetEnablePressGoodsTips(value)
	self.is_enable_goods_tip = value
	if type(value) == "boolean" and value == true then
		self._on_btn_press = self.bindfunc["OnPressTips"]
	else
		self._on_btn_press = nil
	end
	return self
end


function UiSmallItem:on_drag_move(name, x, y)
	local curWidth = app.get_screen_width();
	local curHeight = app.get_screen_height();
	local curX = x / curWidth * 1280;
	local curY = y / curHeight * 720;
	local diffX = curX - self.pressX;
	local diffY = curY - self.pressY;
	local diff = math.sqrt(diffX * diffX + diffY * diffY);
	if diff > 20 then
		GoodsTips.EnableGoodsTips(false)
	end
end

function UiSmallItem:SetPosition(x, y, z)
	x = x or 0;
	y = y or 0;
	z = z or 0;
	if self.ui ~= nil then
		self.ui:set_local_position(x, y, z);
	else
		self.point = { x = x, y = y, z = z };
	end
	return self
end

function UiSmallItem:SetParent(parent)
	if parent then
		if self.ui ~= nil then
			self.ui:set_parent(parent);
			self.scale = self.scale or 1;
			self.ui:set_local_scale(self.scale, self.scale, self.scale);
			self.ui:set_local_position(0, 0, 0);
		else
			self.parent = parent;
		end
	end
	return self
end

function UiSmallItem:SetScale(scale)
	self.scale = scale or 1;
	if self.ui then
		self.ui:set_local_scale(self.scale, self.scale, self.scale);
	end
	return self
end

function UiSmallItem:SetFrame(name)
	self.frameName = name
	if self.sp_frame then
		self.sp_frame:set_sprite_name(name)
	end
	return self
end

function UiSmallItem:on_btn_add_clicked_default(t)
	local id = self.cardInfo.number;
	if PropsEnum.IsItem(id) or PropsEnum.IsVaria(id) or PropsEnum.IsRoleSoul(id) then
		if self.needCount then
			local count = self.count or self.cardInfo.count;
			if count < self.needCount then
				local data = { };
				data.item_id = id;
				data.number = self.needCount;
				AcquiringWayUi.Start(data)

                if self.addDefaultCallback then
                    Utility.CallFunc(self.addDefaultCallback)
                end
			end
		end
	end
end

function UiSmallItem:on_check_value_change(value, name)
	if self.check then
        if self.is_first_default_check then
            self.is_first_default_check = false
            return
        end
        self.curr_check_value = value
        Utility.CallFunc(self.check.callback, self.check.callback_para, value, name)
    end
end

function UiSmallItem:GetCheckValue()
    if self.check then
        return self.curr_check_value
    end
    return nil
end

function UiSmallItem:CheckPropNodeState(slot_prop)
	if self.cardInfo then
		if PropsEnum.IsEquip(self.cardInfo.number) then
			slot_prop.sp_rarity:set_active(false)
			slot_prop.sp_fight:set_active(false)
		else
			local item_cfg = ConfigManager.Get(EConfigIndex.t_item, self.cardInfo.number)
			if item_cfg and PropsEnum.IsItem(self.cardInfo.number) then
				if item_cfg.right_flag == nil or item_cfg.right_flag == 0 or item_cfg.rarity == 0  then	        	
					slot_prop.sp_rarity:set_active(false)
				else
					slot_prop.sp_rarity:set_active(true)
				end
				slot_prop.sp_fight:set_active(item_cfg.category == 6)
			else
				slot_prop.sp_rarity:set_active(false)
				slot_prop.sp_fight:set_active(false)
			end
		end
	else
		slot_prop.sp_rarity:set_active(false)
		slot_prop.sp_fight:set_active(false)
	end
end

function UiSmallItem:SetDouble( doubleNum )
	if doubleNum and doubleNum > 1 then
		local slot_prop = self:GetSlotUiData("prop")
		slot_prop.lbl_double:set_active(true);
		slot_prop.lbl_double:set_text("x" .. doubleNum);
		self:CheckPropNodeState(slot_prop)

		self.double_num = doubleNum
	else
		if self:IsLoadSlotUiData("prop") then
			self:GetSlotUiData("prop").lbl_double:set_active(false);
		end
	end
end

function UiSmallItem:SetStyleByTask( )
	self:SetShowNumber(false);
	self:SetEnablePressGoodsTips(false);
	if self.sp_frame then
		self.sp_frame:set_active(false);
	end
end

function UiSmallItem:DestroyUi()
	self:DestroySlotUiData()

	if self.ui then
		if CommonUiObjectManager.IsEnable() then
			CommonUiObjectManager.RemoveObject( ECommonUi_Type.SmallItem, self.ui )
		else
			self.ui:set_active(false)
		end
		self.ui = nil
	end
	self:MsgUnRegist();
	self:UnregistFunc();
	if self.texture then
		self.texture:Destroy();
		self.texture = nil;
	end
	
	PublicFunc.ClearUserDataRef(self, 2)
	-- delete(self)
end
