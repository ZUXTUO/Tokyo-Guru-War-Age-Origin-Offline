--region guild_member_info_ui.lua
--author : zzc
--date   : 2016/07/22

-- 管理社团成员界面
GuildMemberInfoUI = Class('GuildMemberInfoUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.uipath = "assetbundles/prefabs/ui/guild/ui_2812_guild_tc.assetbundle"

_local.UIText = {
	[1] = "移出社团",
	[2] = "传职",
	[3] = "升职",
	[4] = "降职",
	[5] = "确定",
	[6] = "取消",
	[7] = "移出成功",
	[8] = "传职成功",
	[9] = "任命成功",
	[10] = "确定让出[f2ae1c]%s[-]职位，您的职位将与对方互换？",
	[11] = "确定移出社团？",
	[12] = "%s区",
	[13] = "[00ff00]在线[-]",
	[14] = "[ff0000]%s[-]",
	[15] = "不能进行此操作",
}

_local.send_msg_operation = function(data)
	if type(data) == "table" then
		msg_guild.cg_guild_operation(unpack(data))
	end
end

-------------------------------------类方法-------------------------------------
function GuildMemberInfoUI:Init(data)
    self.pathRes = _local.uipath;
	UiBaseClass.Init(self, data);
end

function GuildMemberInfoUI:Restart(data)
	if data then
		self.memberData = data
		self.myData = g_dataCenter.guild:GetMyMemberData()
		player.cg_look_other_player(self.memberData.playerid, ENUM.ETeamType.normal);
	end
	UiBaseClass.Restart(self, data)
end

function GuildMemberInfoUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function GuildMemberInfoUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

	self.bindfunc["on_btn_private_chat"] = Utility.bind_callback(self, self.on_btn_private_chat)
	self.bindfunc["on_btn_add_friend"] = Utility.bind_callback(self, self.on_btn_add_friend)
	self.bindfunc["on_btn_fight"] = Utility.bind_callback(self, self.on_btn_fight)

	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_btn_kickout"] = Utility.bind_callback(self, self.on_btn_kickout)
	self.bindfunc["on_btn_transfer"] = Utility.bind_callback(self, self.on_btn_transfer)
	self.bindfunc["on_btn_change"] = Utility.bind_callback(self, self.on_btn_change)

	self.bindfunc["on_guild_operation"] = Utility.bind_callback(self, self.on_guild_operation)
	self.bindfunc["on_look_other_player"] = Utility.bind_callback(self, self.on_look_other_player)
end

function GuildMemberInfoUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_guild_operation, self.bindfunc["on_guild_operation"])
	PublicFunc.msg_regist(player.gc_look_other_player,self.bindfunc["on_look_other_player"]);
end

function GuildMemberInfoUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_guild_operation, self.bindfunc["on_guild_operation"])
	PublicFunc.msg_unregist(player.gc_look_other_player,self.bindfunc["on_look_other_player"]);
end

function GuildMemberInfoUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_member_info");
	
	local path = "centre_other/animation/"
	------------------------------ 中部 -----------------------------
	local btnClose = ngui.find_button(self.ui, "btn_cha")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])

	self:LoadMemberData()
	self:LoadMemberBtn()
    self:UpdateUi()
end

function GuildMemberInfoUI:DestroyUi()
	self.memberData = nil
	self.nodeContObj = nil 
	if self.uiHeroCards then
		for i, v in pairs(self.uiHeroCards) do
			v:DestroyUi()
		end
		self.uiHeroCards = nil
	end
	if self.uiPlayer then
		self.uiPlayer:DestroyUi()
		self.uiPlayer = nil
	end
	self.player = nil
    self.package = nil
	self.teamInfo = nil

    UiBaseClass.DestroyUi(self);
end

function GuildMemberInfoUI:GetChangeJob(job, up)
	if up then
		return math.max(job - 1, ENUM.EGuildJob.President)
	else
		return math.min(job + 1, ENUM.EGuildJob.Member)
	end
end

function GuildMemberInfoUI:LoadMemberData()
	local nodeContObj = self.ui:get_child_by_name("centre_other/animation/content")
	local btnPrivateChat = ngui.find_button(nodeContObj, "btn_chat")
	local btnAddFriend = ngui.find_button(nodeContObj, "btn_add_friend")
	local btnFight = ngui.find_button(nodeContObj, "btn_fight")

	local labMemberName = ngui.find_label(nodeContObj, "cont_com/lab_name")
	local labMemberLevel = ngui.find_label(nodeContObj, "cont_level/lab")
	local labMemberJob = ngui.find_label(nodeContObj, "cont_job/lab")
	local labTotalFight = ngui.find_label(nodeContObj, "sp_fight/lab_fight")

	btnPrivateChat:set_on_click(self.bindfunc["on_btn_private_chat"])
	btnAddFriend:set_on_click(self.bindfunc["on_btn_add_friend"])
	btnFight:set_on_click(self.bindfunc["on_btn_fight"])
	local isOpen = SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_1v1)
	btnFight:set_active(isOpen)

	--查看到自己
	if self.memberData.playerid == g_dataCenter.player.playerid then
		btnPrivateChat:set_active(false)
		btnAddFriend:set_active(false)
		btnFight:set_active(false)

	--已经是好友
	elseif g_dataCenter.friend:GetFriendDataByPlayerGID(self.memberData.playerid) then
		btnAddFriend:set_active(false)
	end

	labMemberName:set_text(tostring(self.memberData.name))
	labMemberLevel:set_text(tostring(self.memberData.level))
	labMemberJob:set_text(Guild.GetJobName(self.memberData.job))
	labTotalFight:set_text(tostring(self.memberData.totalFight))

	--在线状态
	-- if self.memberData.online then
	-- 	labLastLogin:set_text(_local.UIText[13])
	-- else
	-- 	local secs = math.max(0, system.time() - self.memberData.lastOffLineTime)
	-- 	local str = string.format(_local.UIText[14], TimeAnalysis.analysisSec_fuzzy(secs, true))
	-- 	labLastLogin:set_text(str)
	-- end

	local playerObj = nodeContObj:get_child_by_name("sp_head_di_item")
	self.uiPlayer = UiPlayerHead:new(
		{parent=playerObj, roleId=self.memberData.imageId, vip=self.memberData.vipLevel})
	self.nodeContObj = nodeContObj
end

function GuildMemberInfoUI:LoadMemberBtn()
	local objNode1 = self.ui:get_child_by_name("centre_other/animation/cont_one")
	local objNode2 = self.ui:get_child_by_name("centre_other/animation/cont_two")
	local objNode3 = self.ui:get_child_by_name("centre_other/animation/cont_three")
	local objNode4 = self.ui:get_child_by_name("centre_other/animation/cont_four")

	--4个按钮
	local control4 = {}
	control4.btn = {}	--移出社团，传职，升职，降职
	for i=1,4 do
		control4.btn[i] = ngui.find_button(objNode4, "btn_"..i)
	end

	--3个按钮
	local control3 = {}
	control3.btn = {}	--移出社团，传职，升职/降职
	for i=1,3 do
		control3.btn[i] = ngui.find_button(objNode3, "btn_"..i)
	end

	--2个按钮
	local control2 = {}
	control2.btn = {}	--移出社团，传职
	for i=1,2 do
		control2.btn[i] = ngui.find_button(objNode2, "btn_"..i)
	end

	--1个按钮
	local control1 = {}
	control1.btn = {}	--确定
	control1.btn[1] = ngui.find_button(objNode1, "btn_1")

	local count = 0
	local upPower = true
	if self.myData.job >= self.memberData.job then
		count = 1
	else
		if self.myData.job == ENUM.EGuildJob.President then
			count = 4
		elseif self.myData.job == ENUM.EGuildJob.VicePresident then
			count = 3
			if self.memberData.job == ENUM.EGuildJob.Minister then
				upPower = false
			end
		elseif self.myData.job == ENUM.EGuildJob.Minister then
			count = 2
		end
	end

	if count == 4 then
		objNode1:set_active(false)
		objNode2:set_active(false)
		objNode3:set_active(false)
		objNode4:set_active(true)

		--移出社团，传职，升职，降职
		control4.btn[1]:set_on_click(self.bindfunc["on_btn_kickout"])
		control4.btn[2]:set_on_click(self.bindfunc["on_btn_transfer"])
		control4.btn[3]:set_on_click(self.bindfunc["on_btn_change"])
		control4.btn[4]:set_on_click(self.bindfunc["on_btn_change"])

		local canUp, canDown = false, false
		if self.myData.job ~= self.memberData.job - 1 then
			canUp = true
		else
			local objControl = objNode4:get_child_by_name("btn_3")
			local spBtn = ngui.find_sprite(objControl, "sp")
			local labBtn = ngui.find_label(objControl, "lab")
			-- PublicFunc.SetUISpriteGray(spBtn)
			spBtn:set_sprite_name("ty_anniu5")
			labBtn:set_color(1,1,1,1)
		end
		if self.memberData.job ~= ENUM.EGuildJob.Member then
			canDown = true
		else
			local objControl = objNode4:get_child_by_name("btn_4")
			local spBtn = ngui.find_sprite(objControl, "sp")
			local labBtn = ngui.find_label(objControl, "lab")
			-- PublicFunc.SetUISpriteGray(spBtn)
			spBtn:set_sprite_name("ty_anniu5")
			labBtn:set_color(1,1,1,1)
		end

		control4.btn[3]:set_event_value(tostring(canUp), 1)
		control4.btn[4]:set_event_value(tostring(canDown), 0)

	elseif count == 3 then
		objNode1:set_active(false)
		objNode2:set_active(false)
		objNode3:set_active(true)
		objNode4:set_active(false)

		--移出社团，传职，升职/降职
		control3.btn[1]:set_on_click(self.bindfunc["on_btn_kickout"])
		control3.btn[2]:set_on_click(self.bindfunc["on_btn_transfer"])
		control3.btn[3]:set_on_click(self.bindfunc["on_btn_change"])
		control3.btn[3]:set_event_value("true", upPower and 1 or 0)

		local labChange = ngui.find_label(control3.btn[3]:get_game_object(), "lab")
		if upPower then
			labChange:set_text(_local.UIText[3])
		else
			labChange:set_text(_local.UIText[4])
		end

	elseif count == 2 then
		objNode1:set_active(false)
		objNode2:set_active(true)
		objNode3:set_active(false)
		objNode4:set_active(false)

		--移出社团，传职
		control2.btn[1]:set_on_click(self.bindfunc["on_btn_kickout"])
		control2.btn[2]:set_on_click(self.bindfunc["on_btn_transfer"])

	elseif count == 1 then
		objNode1:set_active(true)
		objNode2:set_active(false)
		objNode3:set_active(false)
		objNode4:set_active(false)

		control1.btn[1]:set_on_click(self.bindfunc["on_btn_close"])
	end
end

function GuildMemberInfoUI:UpdateUi()
	if self.ui == nil then return end

	if self.package and self.teamInfo then
		self.uiHeroCards = {}
		for i = 1, 3 do
			self.uiHeroCards[i] = SmallCardUi:new({
				parent=self.nodeContObj:get_child_by_name("head"..i), 
				sgroup=4});

			local teamInfo = self.teamInfo[i]
			if teamInfo then
				self.uiHeroCards[i]:SetData(self.package:find_card(1, teamInfo))
			end
		end
	end
end

-------------------------------------本地回调-------------------------------------
-- 私聊
function GuildMemberInfoUI:on_btn_private_chat()
	local data = {
		playerId = self.memberData.playerid, 
		playerName = self.memberData.name, 
		showType = PublicStruct.Chat.whisper,
        vip = self.memberData.vipLevel, image = self.memberData.imageId,
	}
	uiManager:PopUi()
    ChatUI.SetAndShow(data)
end

-- 加好友
function GuildMemberInfoUI:on_btn_add_friend()
	msg_friend.cg_apply_friend({self.memberData.playerid})
end

--[[聊天约战]]
function GuildMemberInfoUI:on_btn_fight()
	if self.chatFightTime ~= nil then
		if app.get_time() - self.chatFightTime < 1 then
			return
		end
	end
	self.chatFightTime = app.get_time()
	msg_1v1.cg_challenge_player(self.memberData.playerid)
end

-- 确定
function GuildMemberInfoUI:on_btn_close(t)
	uiManager:PopUi()
end

-- 踢出社团
function GuildMemberInfoUI:on_btn_kickout(t)
	HintUI.SetAndShow(EHintUiType.two, _local.UIText[11], 
		{str = _local.UIText[6]},
		{str = _local.UIText[5], func = _local.send_msg_operation, param = {0, self.memberData.playerid}});
end

-- 继承职位
function GuildMemberInfoUI:on_btn_transfer(t)
	HintUI.SetAndShow(EHintUiType.two, string.format(_local.UIText[10], Guild.GetJobName(self.myData.job)), 
		{str = _local.UIText[6]},
		{str = _local.UIText[5], func = _local.send_msg_operation, param = {1, self.memberData.playerid}});
end

-- 变更职位
function GuildMemberInfoUI:on_btn_change(t)
	if t.string_value ~= "true" then
		FloatTip.Float(_local.UIText[15])
		return
	end
	local up = t.float_value
	msg_guild.cg_guild_operation(2, self.memberData.playerid, up)
end

-------------------------------------网络回调-------------------------------------
-- 权限变更（0,踢人，1继承，2职位变更）
function GuildMemberInfoUI:on_guild_operation(ntype, playerid, param)
	if ntype == 0 then
		uiManager:PopUi();
		FloatTip.Float(_local.UIText[7])
	elseif ntype == 1 then
		uiManager:PopUi();
		FloatTip.Float(_local.UIText[8])
	elseif ntype == 2 then
		uiManager:PopUi();
		FloatTip.Float(_local.UIText[9])
	end
end

-- 玩家队伍数据
function GuildMemberInfoUI:on_look_other_player(result, playerid, teamType, otherPlayerData)
	if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        uiManager:PopUi();
        return;
    end
	if self.memberData.playerid ~= playerid then return end

	local team = otherPlayerData.teamData;
	local role_cards = otherPlayerData.vecRoleData;
	local player = Player:new();
    local package = Package:new();
	player:UpdateData(otherPlayerData);
	for k,v in pairs(role_cards) do
        if tonumber(v) ~= 0 then
            package:AddCard(ENUM.EPackageType.Hero,v);
        end
    end
	-- package:CalAllHeroProperty();
	local teamid = 0;
    for k,v in pairs(team.cards) do
        if tonumber(v) ~= 0 then
            player:AddTeam(teamid, k, v)
        end
    end
	self.player = player;
    self.package = package;
	self.teamInfo = team.cards;
	
	self:UpdateUi()
end
