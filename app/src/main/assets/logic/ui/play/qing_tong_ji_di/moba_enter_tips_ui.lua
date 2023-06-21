
MobaEnterTipsUI = Class('MobaEnterTipsUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.resPath = "assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_4307_ghoul_3v3.assetbundle"


-------------------------------------类方法-------------------------------------
function MobaEnterTipsUI:Init(data)
	self.pathRes = _local.resPath
	UiBaseClass.Init(self, data);
end

function MobaEnterTipsUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function MobaEnterTipsUI:DestroyUi()
	TimerManager.Remove(self.UpdateTime)
    UiBaseClass.DestroyUi(self);
end

function MobaEnterTipsUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
	self.bindfunc["on_btn_re_enter"] = Utility.bind_callback(self, self.on_btn_re_enter);
	self.bindfunc["on_btn_return_back"] = Utility.bind_callback(self, self.on_btn_return_back);
end 

function MobaEnterTipsUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_moba_enter_tips");

	local btnEnter = ngui.find_button(self.ui, "btn")
	local btnClose = ngui.find_button(self.ui, "btn_cha")

	local labReEnterTip = ngui.find_label(self.ui, "centre_other/animation/content/lab_describe")
	local nodePunishTip = self.ui:get_child_by_name("centre_other/animation/content/cont")
	self.labPunishTime = ngui.find_label(nodePunishTip, "lab_time")
	self.labPunishTip = ngui.find_label(nodePunishTip, "lab_describe")
	self.labBtnEnter = ngui.find_label(self.ui, "btn/animation/lab")

	self.labPunishTip:set_text("因为你最近多次拒绝游戏，倒计时结束才能继续进入")

	btnClose:set_active(false)

	local initData = self:GetInitData()
	if initData.name == "re_enter_tip" then
		btnEnter:set_on_click(self.bindfunc['on_btn_re_enter'])
		nodePunishTip:set_active(false)
		self.callback = initData.callback
		self.labBtnEnter:set_text("进入")
		PublicFunc.SetButtonShowMode(btnEnter, 1, "sprite_background", "lab")
	elseif initData.name == "punish_tip" then
		btnEnter:set_on_click(self.bindfunc['on_btn_return_back'])
		labReEnterTip:set_active(false)
		self.punishTime = initData.time or 1
		self.labBtnEnter:set_text("返回")
		PublicFunc.SetButtonShowMode(btnEnter, 2, "sprite_background", "lab")
	end

	if self.punishTime and self.punishTime > 0 then
		self:UpdateTime()
		TimerManager.Add(self.UpdateTime, 1000, self.punishTime, self)
	end
end

function MobaEnterTipsUI:UpdateTime()
	if self.labPunishTime == nil or self.punishTime == nil then return end

	self.punishTime = math.max(0, self.punishTime - 1)
	self.labPunishTime:set_text( TimeAnalysis.analysisSec_2(self.punishTime) )
end

function MobaEnterTipsUI:on_btn_re_enter()
	if self.callback then
		self.callback()
		self.callback = nil
	end
	uiManager:RemoveUi(EUI.MobaEnterTipsUI)
end

function MobaEnterTipsUI:on_btn_return_back()
	uiManager:RemoveUi(EUI.MobaEnterTipsUI)
end

