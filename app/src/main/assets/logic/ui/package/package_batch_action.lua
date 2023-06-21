PackageBatchAction = Class('PackageBatchAction')
-----------------------------
--BatchBuyAction继承该类
-----------------------------

local _UIText = {
	["str_title"] = "批量",
	["str_batch_sell"] = "出售",
	["str_sell"] = "出售",
	["str_batch_use"] = "使用",
	["str_use"] = "使用",
	["str_count"] = "[FCD901FF]数量[-] ",
}
 
PackageBatchAction.EnumActionType = {
	Sell = 1,
	Use = 2,
}

PackageBatchAction.pathRes = "assetbundles/prefabs/ui/bag/ui_3202_bag.assetbundle"

-------------------------- 外部接口 --------------------------
function PackageBatchAction.ShowAction(data)
	if PackageBatchAction.Instance == nil then
		PackageBatchAction.Instance = PackageBatchAction:new(data)
	else
		PackageBatchAction.Instance:SetData(data)
	end
	
	--self.info = data.info or nil
	--self.action_type =  data.action_type or PackageBatchAction.EnumActionType.Sell
	if nil == PackageBatchAction.Instance.info or nil == PackageBatchAction.Instance.action_type then
		if  PackageBatchAction.Instance  then
			app.log("PackageBatchAction.ShowAction:data error")
			PackageBatchAction.Instance:OnBtnCloseClicked()
		end
		return
	end

	if PackageBatchAction.Instance.ui ~=nil then
		PackageBatchAction.Instance:UpdateUi()		
		PackageBatchAction.Instance:Show()
	end
end



function PackageBatchAction:Init(data)	
	self:InitData(data)
	self:RegistFunc()
	self:LoadAsset()
end

function PackageBatchAction:LoadAsset()
	if(self.ui == nil)then
		self._asset_loader = systems_func.loader_create("PackageBatchActionUI_loader")
		self._asset_loader:set_callback(self.bindfunc["on_loaded"])
		self._asset_loader:load(PackageBatchAction.pathRes);
		self._asset_loader = nil;
	end
end

function PackageBatchAction:on_loaded(pid, filepath, asset_obj, error_info)
	if(filepath == PackageBatchAction.pathRes) then
		self:InitUI(asset_obj);
	end
end

function PackageBatchAction:InitData(data)
	self.bindfunc = {}
	self.current_number = 1
	self:SetData(data)
end

function PackageBatchAction:SetData(data)
	self.info = data.info 
	self.action_type = data.action_type or PackageBatchAction.EnumActionType.Sell
	self.current_number = 1
	self.max_number = self.info.count
	if self.action_type == PackageBatchAction.EnumActionType.Use then
		if self.max_number > Const.PACKAGE_MAX_USE then
			self.max_number = Const.PACKAGE_MAX_USE
		end
	end
	
end

function PackageBatchAction:RegistFunc()
	UiBaseClass.RegistFunc(self) 
	self.bindfunc["on_loaded"] =  Utility.bind_callback(self,self.on_loaded)
	self.bindfunc["OnBtnCloseClicked"] = Utility.bind_callback(self,self.OnBtnCloseClicked)
	self.bindfunc["OnBtnActionClicked"] = Utility.bind_callback(self,self.OnBtnActionClicked)
	self.bindfunc["OnSliderValueChange"] = Utility.bind_callback(self,self.OnSliderValueChange)
	self.bindfunc["OnBtnMinClicked"] = Utility.bind_callback(self,self.OnBtnMinClicked)
	self.bindfunc["OnBtnMaxClicked"] = Utility.bind_callback(self,self.OnBtnMaxClicked)
	
end

function PackageBatchAction:MsgRegist()
	 
	--PublicFunc.msg_regist(msg_cards.gc_item_sell,self.bindfunc['gc_item_sell']);
end

function PackageBatchAction:MsgUnRegist()
 
	--PublicFunc.msg_unregist(msg_cards.gc_item_sell,self.bindfunc['gc_item_sell']);
end

 

function PackageBatchAction:InitUI(obj)
	self.ui = systems_func.game_object_create(obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("package_batch_action");

	self.lbl_title = ngui.find_label(self.ui,"centre_other/animation/content_di_754_458/lab_title")
	self.lbl_title2 = ngui.find_label(self.ui,"centre_other/animation/content_di_754_458/lab_title2")
	self.btn_close = ngui.find_button(self.ui,"centre_other/animation/content_di_754_458/btn_cha")

	self.go_item_info = self.ui:get_child_by_name("centre_other/animation/sp_bk1/new_small_card_item")
	self.lbl_name = ngui.find_label(self.ui,"centre_other/animation/sp_bk1/lab_name")
	self.lbl_have_number = ngui.find_label(self.ui,"centre_other/animation/sp_bk1/txt_have_num/lab_have_num")

	self.nodeSaleCont = self.ui:get_child_by_name("centre_other/animation/sp_bk2/cont1")
	self.labSaleCount = ngui.find_label(self.nodeSaleCont, "lab_num")
	self.labSalePrice = ngui.find_label(self.nodeSaleCont, "txt/lab")

	self.nodeUseCont = self.ui:get_child_by_name("centre_other/animation/sp_bk2/cont2")
	self.labUseCount = ngui.find_label(self.nodeUseCont, "lab_num")

	self.slider = ngui.find_slider(self.ui,"centre_other/animation/sp_bk2/act/pro_back")

	self.btn_min = ngui.find_button(self.ui,"centre_other/animation/sp_bk2/act/btn_red")		
	self.lbl_btn_min = ngui.find_label(self.ui,"centre_other/animation/sp_bk2/act/btn_red/animation/lab_min")
	self.sp_btn_min = ngui.find_sprite(self.ui,"centre_other/animation/sp_bk2/act/btn_red/animation/sp_red")

	self.btn_max = ngui.find_button(self.ui,"centre_other/animation/sp_bk2/act/btn_blue")
	self.lbl_btn_max = ngui.find_label(self.ui,"centre_other/animation/sp_bk2/act/btn_blue/animation/lab_max")
	self.sp_btn_max = ngui.find_sprite(self.ui,"centre_other/animation/sp_bk2/act/btn_blue/animation/sp_red")
	
	self.btn_action = ngui.find_button(self.ui,"centre_other/animation/btn")
	self.lbl_btn_action = ngui.find_label(self.ui,"centre_other/animation/btn/animation/lab")

	self.btn_close:set_on_click(self.bindfunc["OnBtnCloseClicked"])
	self.btn_action:set_on_click(self.bindfunc["OnBtnActionClicked"])
	self.slider:set_on_change(self.bindfunc["OnSliderValueChange"])
	self.btn_min:set_on_click(self.bindfunc["OnBtnMinClicked"])	
	self.btn_max:set_on_click(self.bindfunc["OnBtnMaxClicked"])

	self:UpdateUi()
end

function PackageBatchAction:UpdateActionTypeUi()
	local str_title = _UIText["str_batch_sell"]
	local str_btn_action = _UIText["str_sell"]
	if self.action_type == PackageBatchAction.EnumActionType.Sell then
		str_title = _UIText["str_batch_sell"]
		str_btn_action = _UIText["str_sell"]
		self.nodeSaleCont:set_active(true)
		self.nodeUseCont:set_active(false)
	elseif self.action_type == PackageBatchAction.EnumActionType.Use then
		str_title = _UIText["str_batch_use"]
		str_btn_action = _UIText["str_use"]
		self.nodeSaleCont:set_active(false)
		self.nodeUseCont:set_active(true)
	end
	self.lbl_title:set_text(_UIText["str_title"])
	self.lbl_title2:set_text(str_title)
	self.lbl_btn_action:set_text(str_btn_action)
end

function PackageBatchAction:UpdateUi()
	self:UpdateActionTypeUi()

	if not self.item_info then
		self.item_info = UiSmallItem:new({parent = self.go_item_info,info = self.info,prop={show_number=false}})
	else
		self.item_info:SetData(self.info)
	end
	self.lbl_name:set_text(self.info.color_name)
	--self.lbl_have_number:set_text("[f2ae1c]"..tostring(self.info.count).."[-]  件")	
	self.lbl_have_number:set_text(tostring(self.info.count))
	local strCount = _UIText["str_count"]..tostring(self.current_number)
	if self.action_type == PackageBatchAction.EnumActionType.Use then
		strCount = strCount.."/"..tostring(self.max_number)
	end
	self.labSaleCount:set_text(strCount)
	self.labUseCount:set_text(strCount)
	self.slider:set_steps(self.max_number)
	self.slider:set_value(1)
	self:UpdateSliderUI(1)

end


function PackageBatchAction:OnBtnActionClicked(t)
	if self.action_type == PackageBatchAction.EnumActionType.Sell then
		msg_cards.cg_item_sell(self.info.index,self.current_number)
	elseif self.action_type==PackageBatchAction.EnumActionType.Use then
        --体力存储上限
        if self:CheckCubeSugarLimit(self.info) then
            return
        end
		msg_cards.cg_item_exchange(self.info.index,self.current_number)		
	end
	self:Hide()
end

function PackageBatchAction:CheckCubeSugarLimit(data)
    if self:IsCubeSugarItem(data.number) then
        if PublicFunc.CheckApLimit(g_dataCenter.player:GetAP() + data.exchange_data.exchange_num * self.current_number) then
            return true
        end
    end
    return false
end

function PackageBatchAction:IsCubeSugarItem(number)
    return number == 20000306 or number == 20000307 or number == 20000308
end

function PackageBatchAction:Show()
	if self.ui then
		self.ui:set_active(true)
	end
end

function PackageBatchAction:Hide()
	if self.ui then
		self.ui:set_active(false)
	end
end

function PackageBatchAction:OnBtnCloseClicked()
	 self:Hide()
end

function PackageBatchAction:UpdateSliderUI(value)
	self.current_number = math.ceil(value*self.max_number)
	if self.current_number == 0 then
		self.current_number = 1
	end
	if self.current_number >= self.max_number then
		self.current_number = self.max_number
		--self.sp_btn_max:set_sprite_name("sc_anniu2")	
		self.sp_btn_max:set_color(0,0,0,1)
		PublicFunc.SetUILabelEffectGray(self.lbl_btn_max)
	else
		--self.sp_btn_max:set_sprite_name("sc_anniu_jia")
		self.sp_btn_max:set_color(1,1,1,1)
		PublicFunc.SetUILabelEffectRed(self.lbl_btn_max)
	end 
			
	if self.current_number <= 1 then
		self.current_number  = 1
		--self.sp_btn_min:set_sprite_name("sc_anniu2")
		self.sp_btn_min:set_color(0,0,0,1)
		PublicFunc.SetUILabelEffectGray(self.lbl_btn_min)
	else	
		--self.sp_btn_min:set_sprite_name("sc_anniu_jian")
		self.sp_btn_min:set_color(1,1,1,1)
		PublicFunc.SetUILabelEffectBlue(self.lbl_btn_min)
	end

	local strCount = _UIText["str_count"]..tostring(self.current_number)
	if self.action_type == PackageBatchAction.EnumActionType.Use then
		strCount = strCount.."/"..tostring(self.max_number)
	end
	self.labSaleCount:set_text(strCount)
	self.labUseCount:set_text(strCount)
	self.labSalePrice:set_text(tostring(self.current_number*self.info.sell_price))
end 

function PackageBatchAction:OnSliderValueChange(value)
	self:UpdateSliderUI(value)
end

function PackageBatchAction:OnBtnMinClicked()

	local value = self.slider:get_value()
	if value <= 0 then return end

	value = value - 1/(self.max_number - 1)
	--self:OnSliderValueChange(0)
	self.slider:set_value(value)
end

function PackageBatchAction:OnBtnMaxClicked()

	local value = self.slider:get_value()
	if value >= 1 then return end

	value = value + 1/(self.max_number - 1)
	self.slider:set_value(value)
	--self:OnSliderValueChange(1)
end

function PackageBatchAction:DestroyUi()
	self.ui = nil
	if self.item_info then
		self.item_info:DestroyUi()
	end
end