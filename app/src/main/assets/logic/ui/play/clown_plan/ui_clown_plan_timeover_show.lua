UiClownPlanTimeOver = Class('UiClownPlanTimeOver', UiBaseClass)

UiClownPlanTimeOver.UITEXT = {

}

function UiClownPlanTimeOver.Show(data)
	if UiClownPlanTimeOver.Inst == nil then
		UiClownPlanTimeOver.Inst = UiClownPlanTimeOver:new(data)
	else
		UiClownPlanFightShow.Inst:Show()
	end
end

function UiClownPlanTimeOver.Destroy()
	if UiClownPlanTimeOver.Inst then
		UiClownPlanTimeOver.Inst:DestroyUi()
		UiClownPlanTimeOver.Inst = nil
	end
end

function UiClownPlanTimeOver:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/clown_plan/new_fight_ui_xiao_chou2.assetbundle"
	UiBaseClass.Init(self, data)
end

function UiClownPlanTimeOver:InitData(data)
	UiBaseClass.InitData(self, data)
end


function UiClownPlanTimeOver:RegistFunc()
	UiBaseClass.RegistFunc(self)

end

function UiClownPlanTimeOver:MsgRegist()
	UiBaseClass.MsgRegist(self)
	-- PublicFunc.msg_regist(msg_cards.gc_item_sell, self.bindfunc['gc_item_sell']);

end

function UiClownPlanTimeOver:MsgUnRegist()
	UiBaseClass.MsgRegist(self)
	-- PublicFunc.msg_unregist(msg_cards.gc_item_sell, self.bindfunc['gc_item_sell']);	
end

function UiClownPlanTimeOver:Restart(data)
	UiBaseClass.Restart(self, data)
end

function UiClownPlanTimeOver:_Hide()
	UiBaseClass.Hide(self)
end

function UiClownPlanTimeOver:InitUI(obj)
	UiBaseClass.InitUI(self, obj);
	--timer.create(Utility.create_callback(self.DestroyUi, self), 2000, 1)
end

function UiClownPlanTimeOver:DestroyUi()
	UiBaseClass.DestroyUi(self)
	-- self.ui = nil
end