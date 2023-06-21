
UiClownPlanFightShow = Class('UiClownPlanFightShow', UiBaseClass)

UiClownPlanFightShow.UITEXT = {

}
 
function UiClownPlanFightShow.ShowUi(data)
	if UiClownPlanFightShow.Inst == nil then
		UiClownPlanFightShow.Inst = UiClownPlanFightShow:new(data)
	else
		UiClownPlanFightShow.Inst:Show(data)
	end
end

function UiClownPlanFightShow.HideUi()
	if UiClownPlanFightShow.Inst then
		UiClownPlanFightShow.Inst:Hide()
	end
end

function UiClownPlanFightShow.DestroyUi()
	if UiClownPlanFightShow.Inst then
		UiBaseClass.DestroyUi(UiClownPlanFightShow.Inst)
		UiClownPlanFightShow.Inst = nil
		-- UiClownPlanFightShow.Inst:DestoryUi()
	end
end

function UiClownPlanFightShow.SetDamageNumber(number)
	if UiClownPlanFightShow.Inst then
		UiClownPlanFightShow.Inst:_SetDamageNumber(number)
	end
end

-- function UiClownPlanFightShow.SetBoxNumber(number)
-- 	if UiClownPlanFightShow.Inst then
-- 		UiClownPlanFightShow.Inst:_SetBoxNumber(number)
-- 	end
-- end

-- function UiClownPlanFightShow.SetStudyPointNumber(number)
-- 	if UiClownPlanFightShow.Inst then
-- 		UiClownPlanFightShow.Inst:_SetStudyPoint(number)
-- 	end
-- end

function UiClownPlanFightShow.SetGoldNumber(number)
	if UiClownPlanFightShow.Inst then
		UiClownPlanFightShow.Inst:_SetGoldNumber(number)
	end
end

function UiClownPlanFightShow.PlayGainAni()
	if UiClownPlanFightShow.Inst then
		UiClownPlanFightShow.Inst:_PlayGainAni()
	end
end

function UiClownPlanFightShow:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/clown_plan/new_fight_ui_xiao_chou1.assetbundle"
	UiBaseClass.Init(self, data)
end

function UiClownPlanFightShow:InitData(data)
	UiBaseClass.InitData(self, data)
end


function UiClownPlanFightShow:RegistFunc()
	UiBaseClass.RegistFunc(self)

end

function UiClownPlanFightShow:MsgRegist()
	UiBaseClass.MsgRegist(self)
	-- PublicFunc.msg_regist(msg_cards.gc_item_sell, self.bindfunc['gc_item_sell']);

end

function UiClownPlanFightShow:MsgUnRegist()
	UiBaseClass.MsgRegist(self)
	-- PublicFunc.msg_unregist(msg_cards.gc_item_sell, self.bindfunc['gc_item_sell']);	
end

function UiClownPlanFightShow:Restart(data)
	UiBaseClass.Restart(self, data)
end


function UiClownPlanFightShow:InitUI(obj)
	UiBaseClass.InitUI(self, obj);

	local mainui = GetMainUI()
	if mainui then
		self.ui:set_parent(mainui.leftTopNode)
	end
	self.ui:set_local_position(0, 0, 0)

	self.aniObj = self.ui:get_child_by_name("animation")
	-- self.studyBox = ngui.find_sprite(self.ui, "sp_yanjiudian")
	-- self.studyBox:set_active(false)
	self.lbl_damage_number = ngui.find_label(self.ui, "txt/lab_num")
	self.lbl_damage_number:set_name("lab_damage")
	--self.lbl_study_point_number = ngui.find_label(self.ui, "sp_yanjiudian/lab_num")
	self.lbl_gold_number = ngui.find_label(self.ui, "lab_num")
	self.sp_gold = ngui.find_sprite(self.ui, "sp_gold")
	local x, y, z = self.sp_gold:get_position()
	-- app.log(string.format("UiClownPlanFightShow:aInitUI x=%s,y=%s,z=%s", tostring(x), tostring(y), tostring(z)))
	-- _, x, y, z = PublicFunc.SceneWorldPosToUIWorldPos(x, y, z)
	-- app.log(string.format("UiClownPlanFightShow:bInitUI x=%s,y=%s,z=%s", tostring(x), tostring(y), tostring(z)))
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan]:SetGoldTargetPosition(x, y, z)
	-- g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan]:SetGoldParent(self.lbl_gold_number:get_parent())
	self:UpdateUi()
end

function UiClownPlanFightShow:UpdateUi()
	if self.ui then
		self:_SetDamageNumber(0)
		-- self:_SetBoxNumber(0)
		-- self:_SetStudyPoint(0)
		self:_SetGoldNumber(0)
	end
end

function UiClownPlanFightShow:Show()
	UiBaseClass.Show(self)
	self:UpdateUi()
end

function UiClownPlanFightShow:_SetDamageNumber(number)
	if self.lbl_damage_number then
		self.lbl_damage_number:set_text(tostring(number))
	end
end

-- function UiClownPlanFightShow:_SetBoxNumber(number)
-- 	if self.lbl_box_number then
-- 		self.lbl_box_number:set_text(tostring(number))
-- 	end
-- end
-- function UiClownPlanFightShow:_SetStudyPoint(number)
-- 	if self.lbl_study_point_number then
-- 		self.lbl_study_point_number:set_text(tostring(number))
-- 	end
-- end

function UiClownPlanFightShow:_SetGoldNumber(number)
	if self.lbl_gold_number then
		self.lbl_gold_number:set_text(tostring(number))
	end
end

function UiClownPlanFightShow:_PlayGainAni()
	self.aniObj:animated_stop("new_fight_ui_xiao_chou1")
	self.aniObj:animated_play("new_fight_ui_xiao_chou1")
end

 