CommonFriendListWindowUI = Class("CommonFriendListWindowUI", UiBaseClass)


function CommonFriendListWindowUI.Start(playName)
    if playName == nil then
        app.log('play name is nil !!')
    end
    if CommonFriendListWindowUI.instance == nil then
        CommonFriendListWindowUI.instance = CommonFriendListWindowUI:new({playName = playName}) 
    end
end

function CommonFriendListWindowUI.End()
	if CommonFriendListWindowUI.instance then
		CommonFriendListWindowUI.instance:DestroyUi()
		CommonFriendListWindowUI.instance = nil
	end
end

------------------------------------------------------------------------------

local _UIText = {
    [1] = "在线好友: ",
    [2] = "不能邀请离线好友",
    [3] = "邀请已发送，请耐心等待",
    [4] = "战力",
    [5] = "等级: ",
}

function CommonFriendListWindowUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/ui_common_friend_list_window.assetbundle"
    if data ~= nil then
        self.playName = data.playName
    end  
	UiBaseClass.Init(self, data);
end

function CommonFriendListWindowUI:InitData(data)
    UiBaseClass.InitData(self, data)      
    self.wrapContentMember = {}
end

function CommonFriendListWindowUI:DestroyUi()
    for _,v in pairs(self.wrapContentMember) do
        if v and v.playerHead then 
            v.playerHead:DestroyUi()
            v.playerHead = nil
        end
    end
    self.wrapContentMember = {}
    UiBaseClass.DestroyUi(self)   
end

function CommonFriendListWindowUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close) 
    self.bindfunc["gc_update_friend"] = Utility.bind_callback(self, self.gc_update_friend)   
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item) 
    self.bindfunc["on_invite"] = Utility.bind_callback(self, self.on_invite)
    self.bindfunc["handle_invite_cooling"] = Utility.bind_callback(self, self.handle_invite_cooling)
end

function CommonFriendListWindowUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_friend.gc_update_friend, self.bindfunc['gc_update_friend']);
    PublicFunc.msg_regist("msg_invite_colling_allback_" .. self.playName, self.bindfunc['handle_invite_cooling']);
end

function CommonFriendListWindowUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_friend.gc_update_friend, self.bindfunc['gc_update_friend']);
    PublicFunc.msg_unregist("msg_invite_colling_allback_" .. self.playName, self.bindfunc['handle_invite_cooling']);
end

function CommonFriendListWindowUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_common_friend_list_window')  

    local path = "center_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    self.lblOnlineNumber = ngui.find_label(self.ui, path .. "lab_down")
    self.spNoFriend = ngui.find_sprite(self.ui, path .. "sp_cat") 
   
    self.scrollView = ngui.find_scroll_view(self.ui, path .. "scro_view/panel")
    self.wrapContent = ngui.find_wrap_content(self.ui, "scro_view/panel/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])
    self:UpdateUi()
end

function CommonFriendListWindowUI:on_close(t)
    CommonFriendListWindowUI.End()
end

function CommonFriendListWindowUI:UpdateUi() 
    self.spNoFriend:set_active(false)
        
    self.lblOnlineNumber:set_text(self:GetFriendCntStr()) 
    local count = g_dataCenter.friend:GetFriendCnt()
    if count == 0 then
        self.spNoFriend:set_active(true)
    end
    self.wrapContent:set_min_index(- count + 1)
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position() 
end

function CommonFriendListWindowUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1  
    
    if self.wrapContentMember[row] == nil then
        local temp = {}        
        --玩家名称
        temp.lblName = ngui.find_label(obj, "lab_name")
        --level
        temp.lblLevel = ngui.find_label(obj, "lab_level")
        --战斗力
        temp.lblFightValue = ngui.find_label(obj, "lab_fight")
        --vip        
        temp.lblVip = ngui.find_label(obj, "sp_art_font/lab_num")
        --邀请
        temp.spInviteBg = ngui.find_sprite(obj, "btn1/animation/sp")
        temp.lblInvite = ngui.find_label(obj, "btn1/animation/lab")
        temp.btnInvite = ngui.find_button(obj, "btn1")
        temp.btnInvite:set_on_click(self.bindfunc["on_invite"])
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

function CommonFriendListWindowUI:UpdateItemData(item, data)        
    local online = 0
    if data.online then
        online = 1
    end    
    item.btnInvite:set_event_value(data.friend_gid, online)
   
    item.playerHead:SetRoleId(data.image)
    item.lblName:set_text(data.name)
    item.lblLevel:set_text(_UIText[5] .. data.level)
    item.lblFightValue:set_text(tostring(data.fight_value))
    item.lblVip:set_text(tostring(data.vip_level))

    --在线
    if data.online then
        item.playerHead:SetGray(false)     
        --可邀请
        local tData = {
            playName = self.playName,
            source = ENUM.InviteSource.Friend,
            ext = {
                playerId = data.friend_gid
            }
        }
        if g_dataCenter.invite:CanInvite(tData) then 
            self:InviteButtonTurnGray(item, false)
        else
            self:InviteButtonTurnGray(item, true)
        end
    else
        item.playerHead:SetGray(true)
        self:InviteButtonTurnGray(item, true)
    end
end

function CommonFriendListWindowUI:InviteButtonTurnGray(item, yes)
    if yes then
        item.spInviteBg:set_color(0, 0, 0, 1)
        PublicFunc.SetUILabelEffectGray(item.lblInvite)
    else
        item.spInviteBg:set_color(1, 1, 1, 1)
        PublicFunc.SetUILabelEffectRed(item.lblInvite)
    end
end

--[[更新好友列表]]
function CommonFriendListWindowUI:gc_update_friend()
    self:UpdateUi()    
end

function CommonFriendListWindowUI:GetFriendCntStr()
    local str = g_dataCenter.friend:GetOnlineFriendCnt() .. '/' .. g_dataCenter.friend:GetFriendCnt()
    return _UIText[1] .. PublicFunc.GetColorText(str, "orange_yellow")
end

--[[邀请冷却]]
function CommonFriendListWindowUI:handle_invite_cooling(callbackData)
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
function CommonFriendListWindowUI:on_invite(t) 
    local playerId = t.string_value
    local online = t.float_value == 1

    if not online then
        FloatTip.Float(_UIText[2])
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

