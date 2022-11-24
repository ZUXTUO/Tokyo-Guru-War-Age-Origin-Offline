
InviteInfo = Class('InviteInfo')

local __DEFAUL_TIME = 60

function InviteInfo:Init()
    self.inviteData = {}
    self.coolingUpdateFunc = Utility.bind_callback(self, self.CoolingUpdate)
end

function InviteInfo:Finalize()
    if self.coolingUpdateFunc then
        if TimerManager then
            TimerManager.Remove(self.coolingUpdateFunc)
        end
        Utility.unbind_callback(self, self.coolingUpdateFunc)
    end
    self.inviteData = {}
end

local _UIText = {
    [3] = "邀请已发送，请耐心等待",
}

--[[发送邀请]]
function InviteInfo:SendInvite(data)
    if not self:CanInvite(data) then
        FloatTip.Float(_UIText[3])
        return
    end 
    CommonInviteUI.Start(data)
end

--[[是否可邀请]]
function InviteInfo:CanInvite(data)
    local key = self:GetKey(data)
    --app.log('key=' .. key .. ' ' .. table.tostring(self.inviteData[key]))
    return self.inviteData[key] == nil
end

--[[冷却中]]
function InviteInfo:SetInviteCooling(data)
    if not TimerManager.IsRunning(self.coolingUpdateFunc) then
        TimerManager.Add(self.coolingUpdateFunc, 1000, -1)
    end

    local key = self:GetKey(data)
    self.inviteData[key] = {time = system.time(), data = data}
    PublicFunc.msg_dispatch("msg_invite_colling_allback_" .. data.playName, data)
end

function InviteInfo:RemoveInvaiteData(playType)
    for k, v in pairs(self.inviteData) do
        if v.data and v.data.playName == playType then
            self.inviteData[k] = nil
        end
    end
end

function InviteInfo:CoolingUpdate()
    local currTime = system.time()
    local needUpdate = false
    for k, v in pairs(self.inviteData) do
        needUpdate = true
        --冷却结束
        if currTime > v.time + __DEFAUL_TIME then
            self.inviteData[k] = nil
            PublicFunc.msg_dispatch("msg_invite_colling_allback_" .. v.data.playName, v.data)         
        end
    end  
    if not needUpdate then
        TimerManager.Remove(self.coolingUpdateFunc)
    end
end

function InviteInfo:GetKey(data)
    local key = data.playName .. '_' .. data.source
    --好友邀请
    if data.source == ENUM.InviteSource.Friend then
        if data.ext and data.ext.playerId then
            key = key .. '_' .. data.ext.playerId
        end
    end
    return key
end

--[[构建邀请信息]]
function InviteInfo:BuildInviteInfo(data, channel, content)
    --通用参数
    local inviteInfo = {}
    inviteInfo.nType = data.playName
    inviteInfo.content = content
    inviteInfo.nChannel = channel
    
    if inviteInfo.nChannel == PublicStruct.Chat.whisper then
        inviteInfo.be_playerid = data.ext.playerId
    else
        inviteInfo.be_playerid = ""
    end 
    --发送者信息
    inviteInfo.inviter  = {
        playerid = g_dataCenter.player:GetPlayerID(),
        name = g_dataCenter.player:GetName(),
        vip = g_dataCenter.player:GetVip(),
        image = g_dataCenter.player:GetImage(),
        country_id = g_dataCenter.player:GetCountryId(),
    } 
    --各玩法参数 
    local playParam = {
        nParam1 = 0,
        nParam2 = 0, 
        strParam1 = "",
        strParam2 = "",
    }
    if data.playName == ENUM.InvitePlayName.CloneWar then
        local data = g_dataCenter.CloneBattle:GetTeamInfo()
        playParam.strParam1 = data.roomid

    elseif data.playName == ENUM.InvitePlayName.ThreeToThree then
        playParam.strParam1 = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]:GetRoomId()

    elseif data.playName == ENUM.InvitePlayName.GuildInvite then
        --
    end
    inviteInfo.info = playParam
    return inviteInfo
end

--[[构建聊天信息]]
function InviteInfo:BuildChatMsg(info)
    local chat = {}
    chat.type = info.nChannel
    chat.content = info.content
    chat.sender = info.inviter
    chat.time = system.time()
    
    chat.isInvite = true
    chat.inviteInfo = info
    return chat
end