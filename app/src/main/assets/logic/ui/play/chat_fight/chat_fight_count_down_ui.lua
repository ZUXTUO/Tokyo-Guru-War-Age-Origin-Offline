
ChatFightCountDownUI = Class("ChatFightCountDownUI", UiBaseClass)


function ChatFightCountDownUI.Start()
    if ChatFightCountDownUI.cls == nil then
        ChatFightCountDownUI.cls = ChatFightCountDownUI:new()
    end
end

function ChatFightCountDownUI.End()
    if ChatFightCountDownUI.cls then
        ChatFightCountDownUI.cls:DestroyUi()
        ChatFightCountDownUI.cls = nil
    end
end


local _UIText = {
    [1] = "倒计时[FFF000FF]%s[-]秒",
    [2] = "对方已取消对决"
}

local _CountDown = 5

function ChatFightCountDownUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/chat_fight/ui_5404_yuezhan.assetbundle"
    UiBaseClass.Init(self, data)
end

function ChatFightCountDownUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightCountDownUI:Restart(data)
    self.startSec = _CountDown
    self.isMyCancel = false

    self.fightData = g_dataCenter.chatFight:GetStartFightData()
    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightCountDownUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self,self.on_close)
    self.bindfunc["update_time"] = Utility.bind_callback(self,self.update_time)
    self.bindfunc["gc_cancel_fight_count_down"] = Utility.bind_callback(self, self.gc_cancel_fight_count_down)
end

--注册消息分发回调函数
function ChatFightCountDownUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_1v1.gc_cancel_fight_count_down, self.bindfunc["gc_cancel_fight_count_down"]);
end

--注销消息分发回调函数
function ChatFightCountDownUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_1v1.gc_cancel_fight_count_down, self.bindfunc["gc_cancel_fight_count_down"]);
end

function ChatFightCountDownUI:DestroyUi()
    if self.playerUI then
        for _, v in pairs(self.playerUI) do
            if v.texture then
                v.texture:Destroy()
                v.texture = nil
            end
        end
    end
    TimerManager.Remove(self.bindfunc["update_time"])
    UiBaseClass.DestroyUi(self)
end

function ChatFightCountDownUI:on_close()
    self.isMyCancel = true
    msg_1v1.cg_cancel_fight_count_down(self.fightData.roomId)
end

function ChatFightCountDownUI:gc_cancel_fight_count_down()
    ChatFightCountDownUI.End()
    if not self.isMyCancel then
        FloatTip.Float(_UIText[2])
    end
end

function ChatFightCountDownUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "center_other/animation/"

    self.btnClose = ngui.find_button(self.ui, "content_di_754_458/btn_cha")
    self.btnClose:set_on_click(self.bindfunc["on_close"])

    self.lblCountDownTime = ngui.find_label(self.ui, path .. "txt1")
    self.lblCountDownTime:set_text(tostring(self.startSec))


    self.playerUI = {}
    for i = 1, 2 do
        self.playerUI[i] = {
            texture = ngui.find_texture(self.ui, path .. 'panel/texture' .. i),
            lblName = ngui.find_label(self.ui, path .. 'panel/sp_bar' .. i .. '/lab_name'),
            spIsFirst = ngui.find_sprite(self.ui, path .. 'panel/sp_bar' .. i .. '/sp_art_font'),
        }
    end

    self:UpdateUI()
    --倒计时
    TimerManager.Add(self.bindfunc["update_time"], 1000, _CountDown + 1)
end

function ChatFightCountDownUI:UpdateUI()
    for k, v in pairs(self.fightData.playerData) do
        local ui = self.playerUI[k]
        --playerImage
        local cfg = PublicFunc.GetHeroHeadCfg(v.playerImage)
        if cfg and cfg.screen_icon then
            ui.texture:set_texture(cfg.screen_icon)
        end
        ui.lblName:set_text(v.playerName)
        ui.spIsFirst:set_active(false)
    end
end

function ChatFightCountDownUI:update_time()
    self.startSec = self.startSec - 1
    if self.startSec > 0 then
        self.lblCountDownTime:set_text(tostring(self.startSec))
    elseif self.startSec == 0 then
        --关闭按钮和倒计文字隐藏，出现“先手”标记动画表现
        self.lblCountDownTime:set_active(false)
        self.btnClose:set_active(false)
        for k, v in pairs(self.fightData.playerData) do
            local ui = self.playerUI[k]
            ui.spIsFirst:set_active(v.bFirst)
        end
    elseif self.startSec == -1 then
        local state = g_dataCenter.chatFight:GetSyncState()
        if state == ENUM.ChatFightSelectState.FirstOne then
            ChatFightCountDownUI.End()
            uiManager:PushUi(EUI.ChatFightSelectHeroUI)
        end
    end
end