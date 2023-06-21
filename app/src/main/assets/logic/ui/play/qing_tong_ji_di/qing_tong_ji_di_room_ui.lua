QingTongJiDiRoomUI = Class("QingTongJiDiRoomUI", UiBaseClass);

local _local = {}
_local.UIText = {
    [1] = "[FF0000]您已经邀请过该玩家，请过一会再邀请。[-]",
    [2] = "您的队友%s离开队伍，请重新匹配",
    [3] = "在线",
    [4] = "离线",
    [5] = "已邀请",
    [6] = "[6BF728FF]%d[-]/%d",
    [7] = "由于您拒绝重新进入3V3攻防战，将在%s内不能再次进入", --废弃
    [8] = "您邀请的玩家[6BF728FF]%s[-]处于不能进入3V3攻防战状态",
    [9] = "您已被移除队伍",
    [10] = "匹配中...",
    [11] = "积分 [00FF73]%s[-]",
}

function QingTongJiDiRoomUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_4302_ghoul_3v3.assetbundle";
    UiBaseClass.Init(self, data);
end

function QingTongJiDiRoomUI:Restart(data)
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]
    
    UiBaseClass.Restart(self, data);
end

function QingTongJiDiRoomUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function QingTongJiDiRoomUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_exit_room"] = Utility.bind_callback(self, self.on_exit_room)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_invite_btn"] = Utility.bind_callback(self, self.on_invite_btn)
    self.bindfunc["on_kick_btn"] = Utility.bind_callback(self, self.on_kick_btn)
    self.bindfunc["on_start_btn"] = Utility.bind_callback(self, self.on_start_btn)
    self.bindfunc["gc_cancel_match"] = Utility.bind_callback(self, self.gc_cancel_match)
    self.bindfunc["gc_del_from_room"] = Utility.bind_callback(self, self.gc_del_from_room)
    self.bindfunc["gc_exit_not_enter_game"] = Utility.bind_callback(self, self.gc_exit_not_enter_game)
    self.bindfunc["gc_update_room_state"] = Utility.bind_callback(self, self.gc_update_room_state)
    self.bindfunc["gc_start_match"] = Utility.bind_callback(self, self.gc_start_match)
    
    self.bindfunc["gc_invite_friend"] = Utility.bind_callback(self, self.gc_invite_friend)

    -- self.bindfunc["MatchHandle"] = Utility.bind_callback(self, self.MatchHandle)
end

function QingTongJiDiRoomUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function QingTongJiDiRoomUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_three_to_three.gc_cancel_match, self.bindfunc["gc_cancel_match"])
    PublicFunc.msg_regist(msg_three_to_three.gc_update_room_state, self.bindfunc["gc_update_room_state"])
    PublicFunc.msg_regist(msg_three_to_three.gc_del_from_room, self.bindfunc["gc_del_from_room"])
    PublicFunc.msg_regist(msg_three_to_three.gc_exit_not_enter_game, self.bindfunc["gc_exit_not_enter_game"])
    PublicFunc.msg_regist(msg_three_to_three.gc_start_match, self.bindfunc["gc_start_match"])
    --PublicFunc.msg_regist(player.gc_invite_friend, self.bindfunc["gc_invite_friend"])
end

function QingTongJiDiRoomUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_three_to_three.gc_cancel_match, self.bindfunc["gc_cancel_match"])
    PublicFunc.msg_unregist(msg_three_to_three.gc_update_room_state, self.bindfunc["gc_update_room_state"])
    PublicFunc.msg_unregist(msg_three_to_three.gc_del_from_room, self.bindfunc["gc_del_from_room"])
    PublicFunc.msg_unregist(msg_three_to_three.gc_exit_not_enter_game, self.bindfunc["gc_exit_not_enter_game"])
    PublicFunc.msg_unregist(msg_three_to_three.gc_start_match, self.bindfunc["gc_start_match"])
    --PublicFunc.msg_unregist(player.gc_invite_friend, self.bindfunc["gc_invite_friend"])
end

function QingTongJiDiRoomUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("qtjd_room_ui");


    self.inviteItem = {}
    self.playerInvite = {}
    self.playerRoom = {}

    if not self.dataCenter:GetPlayerRoom() then
        -- error
    end

    self.oldPlayerInvite = self.playerInvite

    local path = "centre_other/animation/right_content/"
    ----------------------- 右侧 ----------------------
    self.btnMatch = ngui.find_button(self.ui, "down_other/animation/btn")
    self.btnMatch:set_on_click(self.bindfunc["on_start_btn"])
    -- self.labWaitTips = ngui.find_label(self.ui, path.."txt")
    self.roomItem = {}
    for i=1, 3 do
        local objNode = self.ui:get_child_by_name(path.."grid/sp_di"..i)
        self.roomItem[i] = {}
        self.roomItem[i].spHost = ngui.find_sprite(objNode, "sp_arrows")
        self.roomItem[i].spOther = ngui.find_sprite(objNode, "sp_yellow_point")
        self.roomItem[i].spMyself = ngui.find_sprite(objNode, "sp_ziji")
        self.roomItem[i].labPoint = ngui.find_label(objNode, "lab_score")
        self.roomItem[i].labName = ngui.find_label(objNode, "lab_name")
        self.roomItem[i].kick = ngui.find_button(objNode, "btn_close")
        self.roomItem[i].kick:set_on_click(self.bindfunc["on_kick_btn"])
        self.roomItem[i].kick:set_event_value("", i)
        local objCard = objNode:get_child_by_name("sp_head_di_item")
        self.roomItem[i].uiPlayerCard = UiPlayerHead:new({parent=objCard})
    end

    path = "centre_other/animation/left_content/"
    ----------------------- 左侧 ----------------------
    -- 重置已邀请状态
    g_dataCenter.invite:RemoveInvaiteData(ENUM.InvitePlayName.ThreeToThree)
    local data = {
        parent = self.ui:get_child_by_name(path),
        playName = ENUM.InvitePlayName.ThreeToThree,
    }
    self.friendList = CommonFriendListUI:new(data)

    self:UpdateUi()
end

function QingTongJiDiRoomUI:DestroyUi()
    if self.ui and self.dataCenter:GetStage() == 1 and not self.clearData then
        msg_three_to_three.cg_team_room(1) --退出房间
    end
    if self.clearData then
        self.clearData = nil
        self.dataCenter:ClearPlayerRoom() --清除房间数据
    end
    if self.inviteItem then
        for k, v in pairs(self.inviteItem) do
            v.cardItem:DestroyUi()
        end
        self.inviteItem = nil
    end
    if self.roomItem then
        for k, v in pairs(self.roomItem) do
            v.uiPlayerCard:DestroyUi()
        end
        self.roomItem = nil
    end
    self.playerRoom = nil
    self.playerInvite = nil
    self.oldPlayerInvite = nil
    self.inviteData = nil

    self.friendList:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function QingTongJiDiRoomUI:ResetWrapContent()
    self.wcPlayer:set_min_index(1-#self.playerInvite);
    self.wcPlayer:set_max_index(0)
    self.wcPlayer:reset()
    self.svPlayer:reset_position()
end

function QingTongJiDiRoomUI:UpdateInvite()
    if not self.ui then return end;

    if #self.oldPlayerInvite ~= #self.playerInvite then
        self:ResetWrapContent()
    end

    local totalNumber = #self.playerInvite
    local onlineNumber = 0
    --更新好友状态
    for b, inviteItem in pairs(self.inviteItem) do
        local player = self.playerInvite[b + 1]
        if player then
            inviteItem.online:set_active(player.online)
            inviteItem.offline:set_active(not player.online)
            if player.online then
                inviteItem.online:set_active(true)
                inviteItem.offline:set_active(false)
                inviteItem.spBtn:set_color(1,1,1,1)
                inviteItem.labBtn:set_color(1,1,1,1)
                onlineNumber = onlineNumber + 1
            else
                inviteItem.online:set_active(false)
                inviteItem.offline:set_active(true)
                inviteItem.spBtn:set_color(0,0,0,1)
                inviteItem.labBtn:set_color(0,0,0,1)
            end
            if player.invited then
                inviteItem.online:set_text(_local.UIText[5])
            else
                inviteItem.online:set_text(_local.UIText[3])
            end
        end
    end
    self.labNumber:set_text(string.format(_local.UIText[6], onlineNumber, totalNumber))
end

function QingTongJiDiRoomUI:UpdateUi()
    if not self.ui then return end;
    
    self.playerRoom = self.dataCenter:GetPlayerRoom() or {}
    if #self.playerRoom == 0 then
        app.log("qtjd_get_player_room == 0")
    end

    local myplayerid = g_dataCenter.player.playerid
    local isOwner = false
    for i, player in pairs(self.playerRoom) do
        if player.leader and player.playerid == myplayerid then
            isOwner = true
        end
    end

    --更新房间数据
    for i, roomItem in pairs(self.roomItem) do
        local player = self.playerRoom[i]
        if player then
            -- local cardInfo = PublicFunc.CreateCardInfo(player.roleId)
            local cf = ConfigHelper.GetRole(tonumber(player.roleId));
            roomItem.labName:set_text(player.name)
            roomItem.uiPlayerCard:Show()
            roomItem.uiPlayerCard:SetRoleId(player.roleId)
            roomItem.uiPlayerCard:SetVipLevel(player.vipLevel)
            roomItem.labPoint:set_text(string.format(_local.UIText[11], player.integral))
            
            if isOwner and player.playerid ~= myplayerid then
                roomItem.kick:set_active(true)
            else
                roomItem.kick:set_active(false)
            end

            roomItem.spMyself:set_active(player.playerid == myplayerid)

            if player.leader then
                roomItem.spHost:set_active(true)
                roomItem.spOther:set_active(false)
            else
                roomItem.spHost:set_active(false)
                roomItem.spOther:set_active(true)
            end
        else
            roomItem.uiPlayerCard:Hide()
            roomItem.labName:set_text("")
            roomItem.spMyself:set_active(false)
            roomItem.spOther:set_active(false)
            roomItem.spHost:set_active(false)
            roomItem.kick:set_active(false)
            roomItem.labPoint:set_text("")
        end
    end

    --房主才能开始匹配
    if isOwner then
        self.btnMatch:set_active(true)
        -- self.labWaitTips:set_active(false)
    else
        self.btnMatch:set_active(false)
        -- self.labWaitTips:set_active(true)
    end
end

function QingTongJiDiRoomUI:UpdatePlayerInviteInfo(inviteInfo)
    self.playerInvite = self.playerInvite or {}
    for i, v in pairs(self.playerInvite) do
        if v.playerid == inviteInfo.playerid then
            self.playerInvite[i] = QTJDInvitePlayer:new(inviteInfo);
            return;
        end
    end
    table.insert(self.playerInvite, QTJDInvitePlayer:new(inviteInfo))
end

function QingTongJiDiRoomUI:GetPlayerInviteById(playerid)
    for i, v in pairs(self.playerInvite) do
        if v.playerid == playerid then
            return v;
        end
    end
end

function QingTongJiDiRoomUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local inviteItem = self.inviteItem[b]
    if not inviteItem then
        inviteItem = {}
        inviteItem.name = ngui.find_label(obj, "lab_name")
        inviteItem.btn = ngui.find_button(obj, "btn1")
        inviteItem.spBtn = ngui.find_sprite(obj, "sprite_background")
        inviteItem.labBtn = ngui.find_label(obj, "lab")
        inviteItem.online = ngui.find_label(obj, "txt1")
        inviteItem.offline = ngui.find_label(obj, "txt2")
        inviteItem.cardItem = SmallCardUi:new(
            {parent=obj:get_child_by_name("sp_head_di_item"), sgroup=2})
        self.inviteItem[b] = inviteItem
    end

    local player = self.playerInvite[index]
    if player then
        local cardInfo = PublicFunc.CreateCardInfo(player.roleId)
        inviteItem.name:set_text(player.name)
        inviteItem.cardItem:SetData(cardInfo)
        inviteItem.btn:reset_on_click()
        inviteItem.btn:set_on_click(self.bindfunc["on_invite_btn"])
        inviteItem.btn:set_event_value("", index)
        if player.online then
            inviteItem.online:set_active(true)
            inviteItem.offline:set_active(false)
            inviteItem.spBtn:set_color(1,1,1,1)
            inviteItem.labBtn:set_color(1,1,1,1)
        else
            inviteItem.online:set_active(false)
            inviteItem.offline:set_active(true)
            inviteItem.spBtn:set_color(0,0,0,1)
            inviteItem.labBtn:set_color(0,0,0,1)
        end
        
        if player.invited then
            inviteItem.online:set_text(_local.UIText[5])
        else
            inviteItem.online:set_text(_local.UIText[3])
        end
    end
end

function QingTongJiDiRoomUI:on_invite_btn(t)  
    local invite_player = self.playerInvite[t.float_value]
    if invite_player then
        if not invite_player.online then
            --玩家离线
        elseif invite_player.click_time and invite_player.click_time + 5 > system.time() then
            FloatTip.Float(_local.UIText[1])
        else
            local inviteData = {
                nType = 0,
                room_id = self.dataCenter:GetRoomId(),
                playerid = g_dataCenter.player.playerid,
                name = g_dataCenter.player.name,
                be_playerid = invite_player.playerid,
            }
            --发送邀请
            player.cg_invite_friend(inviteData)
            invite_player.click_time = system.time()
        end
    end
end

function QingTongJiDiRoomUI:on_kick_btn(t)
    local player = self.playerRoom[t.float_value]
    if player then
        msg_three_to_three.cg_del_from_room(player.playerid)
    end
end

function QingTongJiDiRoomUI:on_start_btn()
    msg_three_to_three.cg_start_match(1)
end

function QingTongJiDiRoomUI:GetPlayerVsData()
    local playerVs = {}
    for i, v in pairs(self.playerRoom) do
        table.insert(playerVs, {image=v.roleId, playerid=v.playerid, name=v.name, state=0, robot=false})
    end
    return playerVs
end

function QingTongJiDiRoomUI:gc_start_match(result, ntype, param)
    if ntype == 1 then
        uiManager:PushUi(EUI.MobaMatchingUI)
    end
end

function QingTongJiDiRoomUI:gc_exit_not_enter_game(playeridList, restartMatch)
    if self.dataCenter:GetEnterType() ~= 1 then return end
    
    if restartMatch == 1 then
        uiManager:RemoveUi(EUI.MobaReadyEnterUI)
        uiManager:PushUi(EUI.MobaMatchingUI)
    
    else
        uiManager:RemoveUi(EUI.MobaReadyEnterUI)
        uiManager:RemoveUi(EUI.MobaMatchingUI)
        --自己未准备退出房间并且被惩罚
        local playerid = g_dataCenter.player.playerid
        for k, v in pairs(playeridList) do
            if playerid == v then
                self:on_exit_room()
            end
        end
    end
end

function QingTongJiDiRoomUI:gc_cancel_match(result, playerid)
    if self.dataCenter:GetEnterType() ~= 1 then return end

    -- --主动退出, 回到主界面
    -- if playerid == g_dataCenter.player.playerid then
    --     self:on_exit_room()
    -- else
    --     --提示退出匹配的玩家
    --     local exitPlayer = nil
    --     local oldPlayerRoom = self.playerRoom
    --     for i, v in ipairs(oldPlayerRoom) do
    --         if v.playerid == playerid then
    --             exitPlayer = v
    --             break;
    --         end
    --     end 

    --     if exitPlayer then
    --         FloatTip.Float(string.format(_local.UIText[2], exitPlayer.name))
    --     end

    --     self:UpdateUi()
    -- end

    --修改为不退出房间
    self:UpdateUi()
end

function QingTongJiDiRoomUI:on_exit_room()
    self.clearData = true
    
    if self.ui then
        uiManager:RemoveUi(EUI.QingTongJiDiRoomUI)
    end
end

function QingTongJiDiRoomUI:gc_del_from_room(result, playerid)
    if playerid == g_dataCenter.player.playerid then
        HintUI.SetAndShow(EHintUiType.one, _local.UIText[9], 
            {str = "确定", func = self.bindfunc["on_exit_room"]}, nil, nil, nil, true);
    end
end

function QingTongJiDiRoomUI:gc_invite_friend(result, infoInvite)
    local playerInfo = self:GetPlayerInviteById(infoInvite.playerid)
    if not playerInfo then return end;
    if result == 0 then
        playerInfo.invited = true
    --拒绝邀请
    else
        playerInfo.invited = false
    end
    self:UpdateInvite()
end

function QingTongJiDiRoomUI:gc_update_room_state(result, info)
    self:UpdateUi()
end
