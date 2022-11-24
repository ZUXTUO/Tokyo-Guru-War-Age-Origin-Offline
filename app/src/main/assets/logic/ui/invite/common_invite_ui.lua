CommonInviteUI = Class("CommonInviteUI", UiBaseClass)


function CommonInviteUI.Start(data)
    if CommonInviteUI.cls == nil then
		CommonInviteUI.cls = CommonInviteUI:new(data);
	end
end

function CommonInviteUI.End()
    if CommonInviteUI.cls ~= nil then
        CommonInviteUI.cls:DestroyUi()
		CommonInviteUI.cls = nil
	end
end

-------------------------------内部接口-----------------------------

local _UIText = {
    [1] = "世界",
    [2] = "社团",
    [3] = "好友",

    [4] = "组队邀请",
    [5] = "邀请",    

    [30] = "快来加入讨伐[%s]%s[-]的队伍吧！",   
    [31] = "快来加入我的[e9a437]3v3攻防战[-]队伍吧！", 
    [32] = "社团[e9a437]%s[-]邀请各位玩家加入",

    [100] = "点击编辑备注, 备注最多15字",
    [101] = "邀请已发出",
}

local __localConfig = {
    [ENUM.InvitePlayName.CloneWar]  = {    
        [ENUM.InviteSource.World] = {title = _UIText[1], title2 = _UIText[4], desc = _UIText[30], channel = PublicStruct.Chat.world},
        [ENUM.InviteSource.Guild] = {title = _UIText[2], title2 = _UIText[4], desc = _UIText[30], channel = PublicStruct.Chat.guild},
        [ENUM.InviteSource.Friend] = {title = _UIText[3], title2 = _UIText[4], desc = _UIText[30], channel = PublicStruct.Chat.whisper},
    },
    [ENUM.InvitePlayName.ThreeToThree]  = {
        [ENUM.InviteSource.Friend] = {title = _UIText[3], title2 = _UIText[4], desc = _UIText[31], channel = PublicStruct.Chat.whisper},  
    },
    [ENUM.InvitePlayName.GuildInvite]   = {
        [ENUM.InviteSource.JoinGuild] = {title = _UIText[2], title2 = _UIText[5], desc = _UIText[32], channel = PublicStruct.Chat.area},  
    }
}

function CommonInviteUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/ui_invate_window.assetbundle"
    self.data = data
	UiBaseClass.Init(self, data);
end

function CommonInviteUI:InitData(data)
    UiBaseClass.InitData(self, data)      
end

function CommonInviteUI:DestroyUi()
    UiBaseClass.DestroyUi(self)   
end

function CommonInviteUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_send"] = Utility.bind_callback(self, self.on_send)
    self.bindfunc["on_send_success"] = Utility.bind_callback(self, self.on_send_success)    
end

function CommonInviteUI:MsgRegist()
    UiBaseClass.MsgRegist(self);  
    PublicFunc.msg_regist(player.gc_invite_friend, self.bindfunc["on_send_success"])
end

function CommonInviteUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(player.gc_invite_friend, self.bindfunc["on_send_success"])
end

function CommonInviteUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('common_invite_ui')  

    local path = "centre_other/animation/" 

    local btnClose = ngui.find_button(self.ui, path .. "content_di_754_458/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])
    local lblTitle = ngui.find_label(self.ui, path .. "content_di_754_458/lab_title")
    lblTitle:set_text(__localConfig[self.data.playName][self.data.source].title)
    local lblTitle2 = ngui.find_label(self.ui, path .. "content_di_754_458/lab_title/lab_title2")
    lblTitle2:set_text(__localConfig[self.data.playName][self.data.source].title2)

    local lblDesc = ngui.find_label(self.ui, path .. "lab")
    lblDesc:set_text(self:GetPlayDesc(self.data))

    self.inputContent = ngui.find_input(self.ui, path .. "input_cont")
    self.inputContent:set_default_text(_UIText[100])
    self.inputContent:set_characterlimit(tostring(15))

    local btnSend = ngui.find_button(self.ui, path .. "btn_confirm")
    btnSend:set_on_click(self.bindfunc["on_send"])  
end

function CommonInviteUI:on_close()
    CommonInviteUI.End()
end

function CommonInviteUI:GetPlayDesc()
    local __desc = __localConfig[self.data.playName][self.data.source].desc
    if self.data.playName == ENUM.InvitePlayName.CloneWar then    
        local data = g_dataCenter.CloneBattle:GetTeamInfo()
        local role = PublicFunc.IdToConfig(data.heroid)
        if role and role.name then
            local color = PublicFunc.GetHeroRarity(role.rarity)
            if color == nil or color == '' then
                color = 'fffff1'
            end
            __desc = string.format(__desc, color, role.name)
        end

    elseif self.data.playName == ENUM.InvitePlayName.GuildInvite then
        local detail = g_dataCenter.guild:GetDetail()
        if detail and detail.name then
            __desc = string.format(__desc, detail.name)
        end
    end
    return __desc
end

function CommonInviteUI:on_send()
    local str = self.inputContent:get_value()
    --发送内容处理
    local content = self:GetPlayDesc(self.data)
    if PublicFunc.trim(str) ~= "" then
        local valid, msg = g_dataCenter.chat:CheckMessage(str) 
        if not valid then
            return
        end
        content = content .. "\n[0bbdf9]" .. msg .. "[-]"
    end
    local channel = __localConfig[self.data.playName][self.data.source].channel
    local info = g_dataCenter.invite:BuildInviteInfo(self.data, channel, content)
    player.cg_invite_friend(info)
end

function CommonInviteUI:on_send_success(info)
    --自己加聊天消息
    if info.nChannel == PublicStruct.Chat.whisper then
        local chat = g_dataCenter.invite:BuildChatMsg(info)
        msg_chat.gc_add_player_chat(chat)
    end
    --冷却
    g_dataCenter.invite:SetInviteCooling(self.data)
    FloatTip.Float(_UIText[101])
    self:on_close()
end