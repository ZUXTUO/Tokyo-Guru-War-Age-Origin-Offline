
ChatFightSendInfoUI = Class("ChatFightSendInfoUI", UiBaseClass)

local _UIText = {
    [1] = "现在的我已经不再像当初那般弱小了，你可敢一战?",
    [2] = "约战发布冷却中",
    [3] = "前往右上角的申请列表中，取消屏蔽申请",
    [4] = "请输入约战信息再进行发布",
}

local _FILE_NAME = "chat_fight"

function ChatFightSendInfoUI.Start()
    if g_dataCenter.chatFight:Ishield() then
        FloatTip.Float(_UIText[3])
        return
    end
    if g_dataCenter.chatFight:IsSendInfoCD() then
        FloatTip.Float(_UIText[2])
        return
    end
    if ChatFightSendInfoUI.cls == nil then
        ChatFightSendInfoUI.cls = ChatFightSendInfoUI:new()
    end
end

function ChatFightSendInfoUI.End()
    if ChatFightSendInfoUI.cls then
        ChatFightSendInfoUI.cls:DestroyUi()
        ChatFightSendInfoUI.cls = nil
    end
end

function ChatFightSendInfoUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/chat_fight/ui_5408_yuezhan.assetbundle"
    UiBaseClass.Init(self, data)
end

function ChatFightSendInfoUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightSendInfoUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightSendInfoUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_publish"] = Utility.bind_callback(self, self.on_publish)
    self.bindfunc["gc_send_notice"] = Utility.bind_callback(self, self.gc_send_notice)
end

function ChatFightSendInfoUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(player.gc_invite_friend, self.bindfunc['gc_send_notice'])
end

function ChatFightSendInfoUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(player.gc_invite_friend, self.bindfunc['gc_send_notice'])
end

function ChatFightSendInfoUI:DestroyUi()
    UiBaseClass.DestroyUi(self)
end

function ChatFightSendInfoUI:gc_send_notice()
    self.setting.content = self.publishStr
    self:SaveSetting()
    self:on_close()
end

function ChatFightSendInfoUI:on_close()
    ChatFightSendInfoUI.End()
end

function ChatFightSendInfoUI:on_publish()
    local str = self.inputMsg:get_value()
    if PublicFunc.trim(str) == "" then
        FloatTip.Float(_UIText[4])
        return
    end

    local valid, str = g_dataCenter.chat:CheckMessage(str)
    if not valid then
        return
    end

    --替换']', 处理如'[ff0000] ...'
    str = string.gsub(str, "]", "")
    self.publishStr = str

    local data = {
        playName = ENUM.InvitePlayName.ChatFight
    }
    local info = g_dataCenter.invite:BuildInviteInfo(data, PublicStruct.Chat.fight, str)
    player.cg_invite_friend(info)
end

function ChatFightSendInfoUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, "content_di_754_458/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    local btnPublish = ngui.find_button(self.ui, "btn_get")
    btnPublish:set_on_click(self.bindfunc["on_publish"])

    self:LoadSetting()
    self.inputMsg = ngui.find_input(self.ui, "input_cont")
    self.inputMsg:set_value(self.setting.content)
end

--[[加载配置]]
function ChatFightSendInfoUI:LoadSetting()
    self.setting = {}
    if file.exist(_FILE_NAME) == true then
        local fileHandle = file.open_read(_FILE_NAME)
        local content = fileHandle:read_all_text()
        fileHandle:close();
        if content then
            local t = loadstring("return " .. content);
            if t then
                self.setting = t();
            end
        end
    end
    --检查日期
    if self.setting.content == nil then
        self.setting = {
            content = _UIText[1],
        }
        self:SaveSetting()
    end
end

--[[保存配置]]
function ChatFightSendInfoUI:SaveSetting()
    local fileHandle = file.open(_FILE_NAME, 2);
    fileHandle:write_string(table.toLuaString(self.setting));
    fileHandle:close();
end

