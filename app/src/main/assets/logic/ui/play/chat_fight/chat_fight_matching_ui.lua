
ChatFightMatchingUI = Class('ChatFightMatchingUI', UiBaseClass)


function ChatFightMatchingUI.Start()
    if ChatFightMatchingUI.cls == nil then
        ChatFightMatchingUI.cls = ChatFightMatchingUI:new()
    end
end

function ChatFightMatchingUI.End()
    if ChatFightMatchingUI.cls then
        ChatFightMatchingUI.cls:DestroyUi()
        ChatFightMatchingUI.cls = nil
    end
end

function ChatFightMatchingUI.Instance()
    return ChatFightMatchingUI.cls
end


-------------------------------------类方法-------------------------------------
function ChatFightMatchingUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_4305_ghoul_3v3.assetbundle"
    UiBaseClass.Init(self, data);
end

function ChatFightMatchingUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function ChatFightMatchingUI:DestroyUi()
    TimerManager.Remove(self.UpdateUi)
    UiBaseClass.DestroyUi(self);
end

function ChatFightMatchingUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_cancel_btn"] = Utility.bind_callback(self, self.on_cancel_btn);
    self.bindfunc["gc_random_match"] = Utility.bind_callback(self, self.gc_random_match);
    self.bindfunc["gc_cancel_match"] = Utility.bind_callback(self, self.gc_cancel_match);
end

--注册消息分发回调函数
function ChatFightMatchingUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_1v1.gc_random_match, self.bindfunc["gc_random_match"]);
    PublicFunc.msg_regist(msg_1v1.gc_cancel_match, self.bindfunc["gc_cancel_match"]);
end

--注销消息分发回调函数
function ChatFightMatchingUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_1v1.gc_random_match, self.bindfunc["gc_random_match"]);
    PublicFunc.msg_unregist(msg_1v1.gc_cancel_match, self.bindfunc["gc_cancel_match"]);
end

function ChatFightMatchingUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("chat_fight_matching_ui");

    self.timeCount = system.time()

    self.labMatchTime = ngui.find_label(self.ui, "lab_matching_time")
    self.btnCancel = ngui.find_button(self.ui, "btn_fork")

    self.btnCancel:set_on_click(self.bindfunc["on_cancel_btn"])

    -- 更换BGM
    AudioManager.Stop(ENUM.EAudioType._2d, false)
    AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.VsWaitingBgm, loop=-1}});
    AudioManager.Set2dAudioFilter(ENUM.EUiAudioBGM.VsWaitingBgm, nil, {enable=true,cutoff=450,resq=1}, {enable=true,cutoff=2800,resq=1})

    TimerManager.Add(self.UpdateUi, 1000, -1, self) --正计时
    self:UpdateUi()

    msg_1v1.cg_random_match()
end

function ChatFightMatchingUI:on_cancel_btn(t)
    msg_1v1.cg_cancel_match()
end

function ChatFightMatchingUI:UpdateUi()
    if self.ui == nil then return end

    local sec = math.max(0, system.time() - self.timeCount)
    self.labMatchTime:set_text( TimeAnalysis.analysisSec_2(sec, true) )
end

function ChatFightMatchingUI:gc_cancel_match()
    ChatFightMatchingUI.End()
    --退出匹配，恢复主城BGM
    AudioManager.Stop(ENUM.EAudioType._2d, false)
    AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.MainCityBgm, loop=-1}});
end

function ChatFightMatchingUI:gc_random_match()

end