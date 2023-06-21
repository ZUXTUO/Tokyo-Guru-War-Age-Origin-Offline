UiMaskItem = Class('UiMaskItem',UiBaseClass);
--------------------------------------------------

-- 初始化
function UiMaskItem:Init(data)
	
	self.pathRes = "assetbundles/prefabs/ui/public/mask_item.assetbundle";
	UiBaseClass.Init(self, data);
end


function UiMaskItem:InitData(data)

    UiBaseClass.InitData(self, data);
    --app.log("UiMaskItem:InitData.."..table.tostring(data))
    self._on_btn_clicked = nil
	self._on_btn_clicked_param = nil
    
    self.maskinfo = data.maskinfo
    self.isShow = true
 	self.isSelect = false
 	self.isHideRarity = false;
end

function UiMaskItem:Restart(data)

    if not UiBaseClass.Restart(self, data) then

    end
end

function UiMaskItem:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_clicked"] = Utility.bind_callback(self, UiMaskItem.on_clicked);

end

-- 初始化UI
function UiMaskItem:InitUI(asset_obj)
	 UiBaseClass.InitUI(self, asset_obj);
	--self:InitSlotUiData()
	self.ui:set_name("small_item_ui")
	self.btn = ngui.find_button(self.ui, 'sp_frame');
	self.btn:reset_on_click();
	self.btn:set_on_click(self.bindfunc['on_clicked'], "MyButton.NoneAudio");
	-- self.btn:set_on_ngui_press(self.bindfunc['on_press']);
	-- --self.btn:set_on_ngui_drag_move(self.bindfunc['on_drag_move']);

	--选中
	self.sp_shine = ngui.find_sprite(self.ui, "icon/sp_shine");

	--面具图标
	self.texture = ngui.find_texture(self.ui, "icon/texture_mask");
	
	--是否装备
	self.isEquipped = ngui.find_sprite(self.ui,"sp_tick")
	self.isEquipped:set_active(false)
	self.masklvllab = ngui.find_label(self.ui,"lab_level")
	--星级
	self.sp_star = {}
	for i=1,7 do
		self.sp_star[i] = ngui.find_sprite(self.ui,"grid/sp"..i)
		self.sp_star[i]:set_active(false)
	end

	--品级
	self.sp_rarity = ngui.find_sprite(self.ui,"sp_bk")

	--等级
	self.sp_lvl = ngui.find_sprite(self.ui,"sp_bk/sp_score")

	--

	self.sp_shine:set_active(self.isSelect)
	if self.isShow == false then return end
	
	self:UpdateUi();
end

function UiMaskItem:SetNumber(number,value)
	if not self.ui then
		return 
	end

	local show_lvl = g_dataCenter.maskitem:get_show_lvl_exp(number,value)

	self.masklvllab:set_text(tostring(show_lvl[1]))

end

function UiMaskItem:SetData(info)
	if not self.ui then
		return
	end

	self.maskinfo = info

	if self._on_btn_clicked_param[1] then
		self._on_btn_clicked_param[1] = self.maskinfo
	end	

	self:UpdateUi()

end

function UiMaskItem:Hide_Rarity()
	self.isHideRarity = true;
	self:UpdateUi()
end

function UiMaskItem:Show_Rarity()
	self.isHideRarity = false;
	self:UpdateUi()
end

-- 刷新界面
function UiMaskItem:UpdateUi()
	if not self.ui then
		return
	end

	--app.log("maskinfo------"..table.tostring(self.maskinfo))

	local show_lvl = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo.number,self.maskinfo.level)

	self.masklvllab:set_text(tostring(show_lvl[1]))

	local config = g_dataCenter.maskitem:get_mask_config(self.maskinfo.number)
	local rarity = config.rarity

    for i=1,rarity do
        self.sp_star[i]:set_active(true)
    end

    self.texture:set_texture(config.make_pic_type)

    --品质
    local maskid = self.maskinfo.number
    local real_rarity = g_dataCenter.maskitem:get_real_rarity(maskid)
    --app.log("real_rarity......"..tostring(real_rarity))
    local real_rarity_ui = g_dataCenter.maskitem:get_ui_real_rarity_pz(real_rarity)

    --app.log("real_rarity_ui..."..table.tostring(real_rarity_ui))

    self.sp_rarity:set_sprite_name(real_rarity_ui[1])
    if real_rarity_ui[2] == "0" then
        self.sp_lvl:set_sprite_name("")
    else
        self.sp_lvl:set_sprite_name(real_rarity_ui[2])
    end


    if self.isHideRarity then
    	self.sp_rarity:set_active(false)
    	self.sp_lvl:set_active(false)
    	self.masklvllab:set_active(false)
    else
    	self.sp_rarity:set_active(true)
    	self.sp_lvl:set_active(true)
    	self.masklvllab:set_active(true)
    end

    self.sp_shine:set_active(self.isSelect)

end

function UiMaskItem:set_select(value)
	self.isSelect = value
	self:UpdateUi()
end

function UiMaskItem:SetOnClicked(func, ...)
	if func then
		self._on_btn_clicked = func
		self._on_btn_clicked_param = { ...}
	end
	return self
end

function UiMaskItem:on_clicked(t)
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

function UiMaskItem:DestroyUi()
	--self:DestroySlotUiData()

	if self.ui then
		-- if CommonUiObjectManager.IsEnable() then
		-- 	CommonUiObjectManager.RemoveObject( ECommonUi_Type.MaskItem, self.ui )
		-- else
			self.ui:set_active(false)
		--end
		self.ui = nil
	end
	self:MsgUnRegist();
	--self:UnregistFunc();
	if self.texture then
		--self.texture:Destroy();
		self.texture = nil;
	end
	
	PublicFunc.ClearUserDataRef(self, 2)
	-- delete(self)
end
