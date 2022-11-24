ShardExchange = Class("ShardExchange", UiBaseClass)

function ShardExchange.Start(data)
	if nil ==  ShardExchange.Instance  then
		ShardExchange.Instance = ShardExchange:new(data)
	end
end

function ShardExchange.SDestroy(  )
	if ShardExchange.Instance then
		ShardExchange.Instance:DestroyUi()
		ShardExchange.Instance = nil
	end
end

function ShardExchange:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/package/ui_602_6.assetbundle"
	UiBaseClass.Init(self, data);

end

function ShardExchange:Restart(data)
	if UiBaseClass.Restart(self, data) then
		self.need_soul_id = PublicFunc.GetRoleIdByHeroNumber(self.data.config.default_rarity)
		Root.AddUpdate(self.Update,self)
	end
end

function ShardExchange:InitData(data)
	UiBaseClass.InitData(self, data);
	self.data = data.info
	self.number_type = data.number_type
	self.fx_count = 0
	self.last_ex_count = 0
	self.last_play_time  = 0	
	self.need_soul_id = PublicFunc.GetRoleIdByHeroNumber(self.data.config.default_rarity)
end

function ShardExchange:DestroyUi()
	self:ClearFx()
	self.fx_timer_id = nil
    if self.small_card_item_trans_soul_ico then
        self.small_card_item_trans_soul_ico:DestroyUi()
        self.small_card_item_trans_soul_ico = nil
    end
    if self.small_card_item_need_soul_ico then
        self.small_card_item_need_soul_ico:DestroyUi()
        self.small_card_item_need_soul_ico = nil
    end
	UiBaseClass.DestroyUi(self);
end

function ShardExchange:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
	self.bindfunc["on_btn_exchange_once"] = Utility.bind_callback(self, self.on_btn_exchange_once);
	self.bindfunc["on_btn_exchange_ten_times"] = Utility.bind_callback(self, self.on_btn_exchange_ten_times);
	self.bindfunc["gc_change_souls"] = Utility.bind_callback(self, self.gc_change_souls)
	self.bindfunc["Update"] = Utility.bind_callback(self,self.Update)
end
function ShardExchange:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

-- 注册消息分发回调函数
function ShardExchange:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_cards.gc_change_souls, self.bindfunc['gc_change_souls']);
end

-- 注销消息分发回调函数
function ShardExchange:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_cards.gc_change_souls, self.bindfunc['gc_change_souls']);
end

function ShardExchange:InitUI(obj)
	UiBaseClass.InitUI(self, obj);
	self.btn_close = ngui.find_button(self.ui, "centre_other/btn_cha")
	self.btn_close:set_on_click(self.bindfunc["on_btn_close"])
	self.btn_ex_once = ngui.find_button(self.ui, "centre_other/animation/btn1")
	self.btn_ex_once:set_on_click(self.bindfunc["on_btn_exchange_once"])
	self.btn_ex_ten_times = ngui.find_button(self.ui, "centre_other/animation/btn2")
	self.btn_ex_ten_times:set_on_click(self.bindfunc["on_btn_exchange_ten_times"])

	self.pro = ngui.find_progress_bar(self.ui,"centre_other/animation/sp_bk/pro_di")
	self.lbl_pro =ngui.find_label(self.ui,"centre_other/animation/sp_bk/pro_di/lab_num")
	self.trans_soul_ico = self.ui:get_child_by_name("centre_other/animation/sp_bk/new_small_card_item1")
	self.lblSoulName1 = ngui.find_label(self.trans_soul_ico, "lab")
	self.need_soul_ico = self.ui:get_child_by_name("centre_other/animation/sp_bk/new_small_card_item2")
	self.lblSoulName2  = ngui.find_label(self.need_soul_ico, "lab")

	self.go_animation = self.ui:get_child_by_name("centre_other/animation")
	self.fx_success = self.ui:get_child_by_name("centre_other/animation/sp_bk/new_small_card_item2/fx_ui_602_6_zhuanhuan")
	self.fx_success:set_active(false)
	
	self:UpdateUi()
end


function ShardExchange:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then return end

	if not self.small_card_item_trans_soul_ico then
		local _info =  CardProp:new( { number = IdConfig.ShardSoul })
		self.small_card_item_trans_soul_ico = UiSmallItem:new( {
			parent = self.trans_soul_ico,
			info = _info,
			--[[uis =
			{
				prop =
				{
					lbl_prop_num = self.lbl_trans_soul_count
				}
			}]]
		} );
		self.lblSoulName1:set_text(_info.color_name)
	end
	-- self.small_card_item_trans_soul_ico:SetDataNumber(IdConfig.ShardSoul)
	if not self.need_card_info then
		self.need_card_info = CardProp:new( { number = self.need_soul_id })
		self.lblSoulName2:set_text(self.need_card_info.color_name)
	end

	if not self.small_card_item_need_soul_ico then
		self.small_card_item_need_soul_ico = UiSmallItem:new(
		{
			parent = self.need_soul_ico,
			cardInfo = self.need_card_info,
			--[[prop =
			{
				number_type = self.number_type,
				need_count = 0
			},]]
			uis =
			{
				prop =
				{
					lbl_prop_num = self.lbl_pro
				}
			},
            add_default_call_back = self.bindfunc["on_btn_close"]
		} );
	end
	--self.small_card_item_need_soul_ico:SetDataNumber(self.need_soul_id)
	local need_soul_count = self.data.config.soul_count
	--self.small_card_item_need_soul_ico:SetNeedCount(need_soul_count)
	if self.data.rarity >= Const.HERO_MAX_STAR then
		self.number_type = 1
	end
	--self.small_card_item_need_soul_ico:SetNumberType(self.number_type)
	local need_count = g_dataCenter.package:GetCountByNumber(self.need_soul_id)
	local hav_count = g_dataCenter.package:GetCountByNumber(IdConfig.ShardSoul)

	self.small_card_item_need_soul_ico:SetCount(need_count)
	self.small_card_item_trans_soul_ico:SetCount(hav_count)

	--self.lbl_need_soul_count:set_text(tostring(need_count))
	self.pro:set_value(need_count/need_soul_count)
	if hav_count > 0 then
		self.go_animation:animated_play("ui_602_6")
	else
		self.go_animation:animated_stop("ui_602_6")
	end
    --self.lbl_pro:set_text(PublicFunc.GetProgressColorStr(need_count, need_soul_count, true, 0))
	self.lbl_pro:set_text("[973900]" .. need_count .. "[-][000000]/" .. need_soul_count .. "[-]")

--self.small_card_item_need_soul_ico:UpdateUi()
end

function ShardExchange:on_btn_close()
	ShardExchange.SDestroy()
end

function ShardExchange:ClearFx()
	self.fx_count = 0;
	Root.DelUpdate(self.Update,self)
end

function ShardExchange:Show(data)	 
	self.data = data.info
	self.number_type = data.number_type
	self.need_soul_id = PublicFunc.GetRoleIdByHeroNumber(self.data.config.default_rarity)
	app.log("xxxxxxxxxxxxxxxx:" .. tostring(self.need_soul_id))
	self:UpdateUi()	 
	UiBaseClass.Show(self) 	 
end

function ShardExchange:Hide()

	self:ClearFx()
	self.fx_success:set_active(true)
	UiBaseClass.Hide(self)
end

function ShardExchange:on_btn_exchange_once()
	self:do_cg_change_souls(self.data.number, 1)
end
function ShardExchange:on_btn_exchange_ten_times()
	self:do_cg_change_souls(self.data.number, 10)
end

function ShardExchange:do_cg_change_souls(role_dataid, count)
	-- app.log("ShardExchange:do_cg_change_souls:" .. tostring(role_dataid) .. " " .. tostring(count))
	local own_count = PropsEnum.GetValue(IdConfig.PsychicSoul)
	if own_count >= count then
		msg_cards.cg_change_souls(Socket.socketServer, role_dataid, count);
		self.last_ex_count  = count
	else
		FloatTip.Float("材料不足")
	end
end

function ShardExchange:gc_change_souls(result, awards)
	
	--app.log("xxx:ShardExchange:gc_change_souls" .. tostring(result) .. table.tostring(awards))
	if result == 0 then
		--self.fx_count = self.fx_count + self.last_ex_count
		local fx = self.fx_success:clone()
		fx:set_active(true)
		timer.create(Utility.create_callback(function()fx:set_active(false) fx=nil end),500,1)
		FloatTip.Float("兑换成功")
		self:UpdateUi()
	end
end

function ShardExchange:Update(dt)
	--app.log("xxxxxxxxxxxxxxxx"..tostring(dt))
	-- local time = app.get_time()	
	-- if self.fx_count > 0 and  time - self.last_play_time > 0.5  then
	-- 	self.last_play_time = time
	-- 	app.log("xxxxxxxxxxxxxxxx"..tostring(time).."  ".. tostring(self.fx_count))
	-- 	self.fx_success:set_active(true)
	-- 	self.fx_success:opt_replay_effect()
		
		
		

	-- 	self.fx_count = self.fx_count - 1		
	-- end
end