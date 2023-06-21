CommonFriendListUI = Class("CommonFriendListUI", UiBaseClass)

local _UIText = {
    [1] = "[00FF73]%s[-]/%s",
    [2] = "不能邀请离线好友",
    [3] = "邀请已发送，请耐心等待",
    [4] = "邀请",
    [5] = "已邀请",
    [6] = "在线",
    [7] = "离线",

    [8] = "好友未开启该玩法",
    [9] = "等级 ",
    [10] = "积分 [00FF73]%s[-]",
}

--[[    
    local data = {
        parent, -->  挂载的父接点
        playName --> 邀请玩法名, 详见ENUM.InvitePlayName
    }
]]
function CommonFriendListUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/ui_common_friend_list.assetbundle"
    if data ~= nil then
        self.parent = data.parent
        self.playName = data.playName
    end  
	UiBaseClass.Init(self, data);
end

function CommonFriendListUI:InitData(data)
    UiBaseClass.InitData(self, data)      
    self.wrapContentMember = {}
end

function CommonFriendListUI:DestroyUi()
    for _,v in pairs(self.wrapContentMember) do
        if v and v.playerHead then 
            v.playerHead:DestroyUi()
            v.playerHead = nil
        end
    end
    self.wrapContentMember = {}
    UiBaseClass.DestroyUi(self)   
end

function CommonFriendListUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["gc_update_friend"] = Utility.bind_callback(self, self.gc_update_friend)   
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item) 
    self.bindfunc["on_invite"] = Utility.bind_callback(self, self.on_invite)
    self.bindfunc["on_btn_add_friend"] = Utility.bind_callback(self, self.on_btn_add_friend)
    self.bindfunc["handle_invite_cooling"] = Utility.bind_callback(self, self.handle_invite_cooling)
end

function CommonFriendListUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_friend.gc_update_friend, self.bindfunc['gc_update_friend']);
    PublicFunc.msg_regist("msg_invite_colling_allback_" .. self.playName, self.bindfunc['handle_invite_cooling']);
end

function CommonFriendListUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_friend.gc_update_friend, self.bindfunc['gc_update_friend']);
    PublicFunc.msg_unregist("msg_invite_colling_allback_" .. self.playName, self.bindfunc['handle_invite_cooling']);
end

function CommonFriendListUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_common_friend_list')  

    self.btnAddFriend = ngui.find_button(self.ui, "btn_add")
    self.btnAddFriend:set_on_click(self.bindfunc["on_btn_add_friend"])

    self.lblOnlineNumber = ngui.find_label(self.ui, "sp_title/lab2")
    self.spNoFriend = ngui.find_sprite(self.ui, "sp_cat") 
   
    self.scrollView = ngui.find_scroll_view(self.ui, "scroll_view/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, "scroll_view/panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])
    self:UpdateUi()
end

function CommonFriendListUI:UpdateUi()         
    self.lblOnlineNumber:set_text(self:GetFriendCntStr()) 
    local count = g_dataCenter.friend:GetFriendCnt()
    if count == 0 then
        self.spNoFriend:set_active(true)
        self.btnAddFriend:set_active(true)
    else
        self.spNoFriend:set_active(false)
        self.btnAddFriend:set_active(false)
    end
    self.wrapContent:set_min_index(- count + 1)
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position() 
end

function CommonFriendListUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1  
    
    if self.wrapContentMember[row] == nil then
        local temp = {}        
        --玩家名称
        temp.lblName = ngui.find_label(obj, "lab_name")
        --level
        temp.lblLevel = ngui.find_label(obj, "lab_level")
        --战斗力
        -- temp.lblFightValue = ngui.find_label(obj, "sp_fight/lab_fight")
        --vip        
        -- temp.lblVip = ngui.find_label(obj, "sp_art_font/lab_num")
        --功能相关内容
        temp.lblInfo = ngui.find_label(obj, "lab_score")
        --邀请
        temp.spInviteBg = ngui.find_sprite(obj, "btn/animation/sprite_background")
        temp.lblInvite = ngui.find_label(obj, "btn/animation/lab")
        temp.btnInvite = ngui.find_button(obj, "btn")
        temp.btnInvite:set_on_click(self.bindfunc["on_invite"])

        --temp.spOnline = ngui.find_sprite(obj, "sp_arrows")
        temp.lblOnline = ngui.find_label(obj, "sp_di/lab")

        --头像
        local objItem = obj:get_child_by_name("sp_head_di_item");
        temp.playerHead = UiPlayerHead:new({parent = objItem})
        self.wrapContentMember[row] = temp
    end

    local item = self.wrapContentMember[row]
    local data = g_dataCenter.friend:GetFriendDataByIndex(index)
    if data == nil then return end

    --保存玩家id
    item.playerId = data.friend_gid
    self:UpdateItemData(item, data)    
end

function CommonFriendListUI:UpdateItemData(item, data)        
    local online = 0
    if data.online then
        online = 1
    end    
    item.btnInvite:set_event_value(data.friend_gid, online)
   
    item.playerHead:SetRoleId(data.image)
    item.playerHead:SetVipLevel(data.vip_level)
    item.lblName:set_text(data.name)
    item.lblLevel:set_text(_UIText[9] .. data.level)
    -- item.lblFightValue:set_text(tostring(data.fight_value))
    -- item.lblVip:set_text(tostring(data.vip_level))

    if self.playName == ENUM.InvitePlayName.ThreeToThree then
        item.lblInfo:set_text(string.format(_UIText[10], data.integral_3v3 or 0))
    else
        item.lblInfo:set_text("")
    end

    --在线
    if data.online then   
        --PublicFunc.SetUISpriteWhite(item.spOnline)
        item.lblOnline:set_text(_UIText[6])

        --可邀请
        local tData = {
            playName = self.playName,
            source = ENUM.InviteSource.Friend,
            ext = {
                playerId = data.friend_gid
            }
        }
        --item.lblInvite:set_active(true)
        if g_dataCenter.invite:CanInvite(tData) then 
            item.lblInvite:set_text(_UIText[4])
            self:InviteButtonTurnGray(item, false)
        else
            item.lblInvite:set_text(_UIText[5])
            self:InviteButtonTurnGray(item, true)
        end
    else
        --PublicFunc.SetUISpriteGray(item.spOnline)
        item.lblOnline:set_text(_UIText[7])
        self:InviteButtonTurnGray(item, true)

        --item.lblInvite:set_active(false)
    end
end

function CommonFriendListUI:InviteButtonTurnGray(item, yes)
    if yes then
        item.spInviteBg:set_color(0, 0, 0, 1)
        PublicFunc.SetUILabelEffectGray(item.lblInvite)
    else
        item.spInviteBg:set_color(1, 1, 1, 1)
        PublicFunc.SetUILabelEffectBlue(item.lblInvite)
    end
end

--[[更新好友列表]]
function CommonFriendListUI:gc_update_friend()
    self:UpdateUi()    
end

function CommonFriendListUI:GetFriendCntStr()
    return string.format(_UIText[1], g_dataCenter.friend:GetOnlineFriendCnt(), g_dataCenter.friend:GetFriendCnt())
end

--[[邀请冷却]]
function CommonFriendListUI:handle_invite_cooling(callbackData)
    if callbackData.source ~= ENUM.InviteSource.Friend then
        return
    end
    for _, item in pairs(self.wrapContentMember) do
        if item.playerId == callbackData.ext.playerId then
            local data = g_dataCenter.friend:GetFriendDataByPlayerGID(item.playerId)
            self:UpdateItemData(item, data)
        end        
    end
end

--[[邀请]]
function CommonFriendListUI:on_invite(t) 
    local playerId = t.string_value
    local data = g_dataCenter.friend:GetFriendDataByPlayerGID(t.string_value)
    if not data.online then
        FloatTip.Float(_UIText[2])
        return
    end

    local funcId = nil
    if self.playName == ENUM.InvitePlayName.CloneWar then
        funcId = MsgEnum.eactivity_time.eActivityTime_CloneFight
    elseif self.playName == ENUM.InvitePlayName.ThreeToThree then
        funcId = MsgEnum.eactivity_time.eActivityTime_threeToThree
    elseif self.playName == ENUM.InvitePlayName.GuildInvite then
        funcId = MsgEnum.eactivity_time.eActivityTime_Guild
    end

    if funcId and not PublicFunc.FuncIsOpen(funcId, data.level) then
        FloatTip.Float(_UIText[8])
        return
    end

    local tData = {
        playName = self.playName,
        source = ENUM.InviteSource.Friend,
        ext = {
            playerId = playerId
        }        
    }
    g_dataCenter.invite:SendInvite(tData)
end


--[[打开 好友界面-添加好友页签]]
function CommonFriendListUI:on_btn_add_friend()
    uiManager:PushUi(EUI.FriendUi, {invite=true});
end
