PackageCompoundAction = Class('PackageCompoundAction')

PackageCompoundAction.UITEXT = {
	["str_compound"] = "合成",
	["str_get_way"] = "获取途径",
}

PackageCompoundAction.pathRes = "assetbundles/prefabs/ui/bag/ui_3203_bag.assetbundle"
function PackageCompoundAction:Init(data)
	self:InitData(data)
	self:RegistFunc()
	self:LoadAsset()
end

function PackageCompoundAction:LoadAsset()
	if (self.ui == nil) then
		self._asset_loader = systems_func.loader_create("PackageCompoundActionUI_loader")
		self._asset_loader:set_callback(self.bindfunc["on_loaded"])
		self._asset_loader:load(PackageCompoundAction.pathRes);
		self._asset_loader = nil;
	end
end

function PackageCompoundAction:on_loaded(pid, filepath, asset_obj, error_info)
	if (filepath == PackageCompoundAction.pathRes) then
		self:InitUI(asset_obj);
	end
end

function PackageCompoundAction:InitData(data)
	self.bindfunc = { }
	self:SetData(data)
end

function PackageCompoundAction:SetData(data)
	self.info = data.info
end

function PackageCompoundAction:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, self.on_loaded)
	self.bindfunc["OnBtnCloseClicked"] = Utility.bind_callback(self, self.OnBtnCloseClicked)
	self.bindfunc["OnBtnActionClicked"] = Utility.bind_callback(self, self.OnBtnActionClicked)
end

function PackageCompoundAction:MsgRegist()
	-- PublicFunc.msg_regist(msg_cards.gc_item_sell,self.bindfunc['gc_item_sell']);
end

function PackageCompoundAction:MsgUnRegist()
	-- PublicFunc.msg_unregist(msg_cards.gc_item_sell,self.bindfunc['gc_item_sell']);
end

 

function PackageCompoundAction:InitUI(obj)
	self.ui = systems_func.game_object_create(obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("package_compound_action");


	self.go_item_info = self.ui:get_child_by_name("centre_other/animation/texture/new_small_card_item")
	self.lbl_name = ngui.find_label(self.ui, "centre_other/animation/texture/lab_name")
	self.lbl_have_number = ngui.find_label(self.ui, "centre_other/animation/texture/lab_num1")
	self.lbl_progress_number = ngui.find_label(self.ui, "centre_other/animation/texture/lab_num2")
	self.progress_bar = ngui.find_progress_bar(self.ui, "centre_other/animation/texture/pro_di")
	self.lab_word = ngui.find_label(self.ui, "centre_other/animation/texture/lab_word")
	self.btn_action = ngui.find_button(self.ui, "centre_other/animation/texture/btn1")
	self.lbl_btn_action = ngui.find_label(self.ui, "centre_other/animation/texture/btn1/animation/lab")
	self.btn_close = ngui.find_button(self.ui, "centre_other/animation/texture/btn_cha")

	self.btn_close:set_on_click(self.bindfunc["OnBtnCloseClicked"])
	self.btn_action:set_on_click(self.bindfunc["OnBtnActionClicked"])

	self:UpdateUi()
end


function PackageCompoundAction.ShowAction(data)
	if PackageCompoundAction.Instance == nil then
		PackageCompoundAction.Instance = PackageCompoundAction:new(data)
	else
		PackageCompoundAction.Instance:SetData(data)
	end

	-- self.info = data.info or nil
	-- self.action_type =  data.action_type or PackageCompoundAction.EnumActionType.Sell
	if nil == PackageCompoundAction.Instance.info then
		if PackageCompoundAction.Instance then
			app.log("PackageCompoundAction.ShowAction:data error")
			PackageCompoundAction.Instance:OnBtnCloseClicked()
		end
		return
	end

	if PackageCompoundAction.Instance.ui ~= nil then
		PackageCompoundAction.Instance:UpdateUi()
		PackageCompoundAction.Instance:Show()
	end
end

function PackageCompoundAction:UpdateActionTypeUi()
	local exchange_data = self.info.exchange_data
	if exchange_data then
		if self.info.count < exchange_data.num then
			self.lbl_btn_action:set_text(PackageCompoundAction.UITEXT["str_get_way"])
		else
			self.lbl_btn_action:set_text(PackageCompoundAction.UITEXT["str_compound"])
		end
	end
end

function PackageCompoundAction:UpdateUi()
	self:UpdateActionTypeUi()

	if not self.item_info then
		self.item_info = UiSmallItem:new({parent = self.go_item_info,info = self.info})
	else
		self.item_info:SetData(self.info)
	end
	self.lbl_name:set_text(self.info.color_name)
	self.lbl_have_number:set_text(PublicFunc.GetProgressColorStr(self.info.count,self.info.exchange_data.num))		
	self.progress_bar:set_value(self.info.count/self.info.exchange_data.num)
	if self.info.exchange_data.desc ~= 0 then
		self.lab_word:set_text(tostring(self.info.exchange_data.desc))
	end
end


function PackageCompoundAction:OnBtnActionClicked(t)
	local exchange_data = self.info.exchange_data
	if exchange_data then
		if exchange_data.num < self.info.count then
				--TODO:合成
			msg_cards.cg_item_exchange(self.info.index)
		else
			--TODO：获取途径

		end
	end

 
	self:Hide()
end


function PackageCompoundAction:Show()
	if self.ui then
		self.ui:set_active(true)
	end
end

function PackageCompoundAction:Hide()
	if self.ui then
		self.ui:set_active(false)
	end
end

function PackageCompoundAction:OnBtnCloseClicked()
	 self:Hide()
end

 

 

function PackageCompoundAction:DestroyUi()
	self.ui = nil
	if self.item_info then
		self.item_info:DestroyUi()
	end
end