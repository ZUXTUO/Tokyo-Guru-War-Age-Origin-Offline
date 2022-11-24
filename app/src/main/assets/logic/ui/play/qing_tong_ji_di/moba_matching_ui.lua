
MobaMatchingUI = Class('MobaMatchingUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.resPath = "assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_4305_ghoul_3v3.assetbundle"

-------------------------------------类方法-------------------------------------
function MobaMatchingUI:Init(data)
	self.pathRes = _local.resPath
	UiBaseClass.Init(self, data);
end

function MobaMatchingUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function MobaMatchingUI:DestroyUi()
	TimerManager.Remove(self.UpdateUi)
    UiBaseClass.DestroyUi(self);
end

function MobaMatchingUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
	self.bindfunc["on_cancel_btn"] = Utility.bind_callback(self, self.on_cancel_btn);
	self.bindfunc["gc_ready_finish"] = Utility.bind_callback(self, self.gc_ready_finish);
	self.bindfunc["gc_cancel_match"] = Utility.bind_callback(self, self.gc_cancel_match);
end 

function MobaMatchingUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function MobaMatchingUI:MsgRegist()
	PublicFunc.msg_regist(msg_three_to_three.gc_ready_finish, self.bindfunc["gc_ready_finish"]);
	PublicFunc.msg_regist(msg_three_to_three.gc_cancel_match, self.bindfunc["gc_cancel_match"]);
end

--注销消息分发回调函数
function MobaMatchingUI:MsgUnRegist()
	PublicFunc.msg_unregist(msg_three_to_three.gc_ready_finish, self.bindfunc["gc_ready_finish"]);
	PublicFunc.msg_unregist(msg_three_to_three.gc_cancel_match, self.bindfunc["gc_cancel_match"]);
end

function MobaMatchingUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_moba_matching");

	self.timeCount = system.time()

    self.labMatchTime = ngui.find_label(self.ui, "lab_matching_time")
	self.btnCancel = ngui.find_button(self.ui, "btn_fork")

	self.btnCancel:set_on_click(self.bindfunc["on_cancel_btn"])

	-- 更换BGM
	-- AudioManager.Stop(ENUM.EAudioType._2d, false)
	-- AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.VsWaitingBgm, loop=-1}});
	-- AudioManager.Set2dAudioFilter(ENUM.EUiAudioBGM.VsWaitingBgm, nil, {enable=true,cutoff=450,resq=1}, {enable=true,cutoff=2800,resq=1})

	TimerManager.Add(self.UpdateUi, 1000, -1, self) --正计时

	self:UpdateUi()
end

function MobaMatchingUI:UpdateUi()
	if self.ui == nil then return end

	local sec = math.max(0, system.time() - self.timeCount)
	self.labMatchTime:set_text( TimeAnalysis.analysisSec_2(sec, true) )
end

function MobaMatchingUI:gc_cancel_match()
	uiManager:RemoveUi(EUI.MobaMatchingUI)

	--退出匹配，恢复主城BGM
	-- AudioManager.Stop(ENUM.EAudioType._2d, false)
	-- AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.MainCityBgm, loop=-1}});
end

function MobaMatchingUI:gc_ready_finish()
	uiManager:RemoveUi(EUI.MobaMatchingUI)
	uiManager:PushUi(EUI.MobaReadyEnterUI)
end

-------------------------------------本地回调-------------------------------------
--取消匹配按钮
function MobaMatchingUI:on_cancel_btn(t)
	msg_three_to_three.cg_cancel_match()
end

