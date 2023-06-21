--region guild_approval_ui.lua
--author : zzc
--date   : 2016/07/22

-- 社团审批界面
GuildApprovalUI = Class('GuildApprovalUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.uipath = "assetbundles/prefabs/ui/guild/ui_2807_guild_audit.assetbundle"

_local.UIText = {
	[1]	 = 	"限制设置",
	[2]	 = 	"招募社员",
	[3]	 = 	"一键拒绝",
	[4]	 = 	"申请条件：%s%s",
	[5]	 = 	"无限制",
	[6]	 = 	"%s级",
	[7]	 = 	"[0cec06](自由加入)[-]",
	[8]	 = 	"[0cec06](需申请)[-]",
	[9]	 = 	"[ff0000](禁止加入)[-]",
	[10] = 	"您没有招募权限！",
	[11] = 	"等级[fde517ff]%s[-]",
}

-------------------------------------类方法-------------------------------------

local __tData = {
    playName = ENUM.InvitePlayName.GuildInvite,
    source = ENUM.InviteSource.JoinGuild,
}

function GuildApprovalUI:Init(data)
    self.pathRes = _local.uipath;
	UiBaseClass.Init(self, data);
end

function GuildApprovalUI:Restart(data)
	if UiBaseClass.Restart(self, data) then
		if not g_dataCenter.guild:IsLoadApplyData() then
			msg_guild.cg_request_all_apply_data()
		end
	end
end

function GuildApprovalUI:InitData(data)
	self.openLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data
	UiBaseClass.InitData(self, data);
end

function GuildApprovalUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_btn_recruit_set"] = Utility.bind_callback(self, self.on_btn_recruit_set)
    self.bindfunc["on_btn_recruit_release"] = Utility.bind_callback(self, self.on_btn_recruit_release)
    self.bindfunc["on_btn_one_key_refuse"] = Utility.bind_callback(self, self.on_btn_one_key_refuse)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
	self.bindfunc["on_btn_player"] = Utility.bind_callback(self, self.on_btn_player)
	self.bindfunc["on_btn_dealwith_apply"] = Utility.bind_callback(self, self.on_btn_dealwith_apply)
	self.bindfunc["on_update_guild_config"] = Utility.bind_callback(self, self.on_update_guild_config)
	self.bindfunc["on_dealwith_apply_join"] = Utility.bind_callback(self, self.on_dealwith_apply_join)
    self.bindfunc["handle_invite_cooling"] = Utility.bind_callback(self, self.handle_invite_cooling)
end

function GuildApprovalUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_update_guild_config, self.bindfunc["on_update_guild_config"])
	PublicFunc.msg_regist(msg_guild.gc_request_all_apply_data, self.bindfunc["on_dealwith_apply_join"])
	PublicFunc.msg_regist(msg_guild.gc_update_apply_data, self.bindfunc["on_dealwith_apply_join"])
	-- PublicFunc.msg_regist(msg_guild.gc_dealwith_apply_join, self.bindfunc["on_dealwith_apply_join"])
    PublicFunc.msg_regist("msg_invite_colling_allback_" .. __tData.playName, self.bindfunc['handle_invite_cooling']);
end

function GuildApprovalUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_update_guild_config, self.bindfunc["on_update_guild_config"])
	PublicFunc.msg_unregist(msg_guild.gc_request_all_apply_data, self.bindfunc["on_dealwith_apply_join"])
	PublicFunc.msg_unregist(msg_guild.gc_update_apply_data, self.bindfunc["on_dealwith_apply_join"])
	-- PublicFunc.msg_unregist(msg_guild.gc_dealwith_apply_join, self.bindfunc["on_dealwith_apply_join"])
    PublicFunc.msg_unregist("msg_invite_colling_allback_" .. __tData.playName, self.bindfunc['handle_invite_cooling'])
end

function GuildApprovalUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_approval");

	self.items = {}

	local path = "center_other/animation/scro_view/"
	------------------------------ 中部 -----------------------------
	self.scrollView = ngui.find_scroll_view(self.ui, path.."panel")
	self.wrapContent = ngui.find_wrap_content(self.ui, path.."panel/wrap_content")
	self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

	path = "sp_down_di/"
	self.labApplyCondition = ngui.find_label(self.ui, path.."lab_num") 
	self.btnRecruitSet = ngui.find_button(self.ui, path.."btn1")
	self.labRecruitSet = ngui.find_label(self.ui, path.."btn1/animation/lab")
	self.btnRecruitRelease = ngui.find_button(self.ui, path.."btn2")
	self.labRecruitRelease = ngui.find_label(self.ui, path.."btn2/animation/lab")
	self.spRecruitRelease = ngui.find_sprite(self.ui, path.."btn2/animation/sp")
	self.btnOneKeyRefuse = ngui.find_button(self.ui, path.."btn3")
	self.labOneKeyRefuse = ngui.find_label(self.ui, path.."btn3/animation/lab")
	self.spOneKeyRefuse = ngui.find_sprite(self.ui, path.."btn3/animation/sp")

	self.btnRecruitSet:set_on_click(self.bindfunc["on_btn_recruit_set"])
	self.btnRecruitRelease:set_on_click(self.bindfunc["on_btn_recruit_release"])
	self.btnOneKeyRefuse:set_on_click(self.bindfunc["on_btn_one_key_refuse"])
	self.labRecruitSet:set_text(_local.UIText[1])
	self.labRecruitRelease:set_text(_local.UIText[2])
	self.labOneKeyRefuse:set_text(_local.UIText[3])

	self.btnPos = {{},{},{}}
	local x,y,z = self.btnRecruitSet:get_position()
	table.insert(self.btnPos[1], x)
	table.insert(self.btnPos[1], y)
	table.insert(self.btnPos[1], z)
	x,y,z = self.btnRecruitRelease:get_position()
	table.insert(self.btnPos[2], x)
	table.insert(self.btnPos[2], y)
	table.insert(self.btnPos[2], z)
	x,y,z = self.btnOneKeyRefuse:get_position()
	table.insert(self.btnPos[3], x)
	table.insert(self.btnPos[3], y)
	table.insert(self.btnPos[3], z)

	self:handle_invite_cooling()

	self.nodeNoTips = self.ui:get_child_by_name("center_other/animation/content1")

    self:UpdateList()
	self:UpdateUi()
end

function GuildApprovalUI:DestroyUi()
	if self.btnPos then
		self.btnPos = nil
	end
	if self.items then
		for i, item in pairs(self.items) do
			item.uiPlayerHead:DestroyUi()
		end
		self.items = nil
	end

    UiBaseClass.DestroyUi(self);
end

function GuildApprovalUI:UpdateList()
	if self.ui == nil then return end

	local listData = g_dataCenter.guild:GetApplyData()
	self.wrapContent:set_min_index(1 - #listData);
	self.wrapContent:set_max_index(0);
	self.wrapContent:reset()
	self.scrollView:reset_position()

	if #listData == 0 then
		self.nodeNoTips:set_active(true)
		-- PublicFunc:SetUISpriteGray(self.spOneKeyRefuse)
		self.btnRecruitSet:set_position(self.btnPos[2][1],self.btnPos[2][2],self.btnPos[2][3])
		self.btnRecruitRelease:set_position(self.btnPos[3][1],self.btnPos[3][2],self.btnPos[3][3])
		self.btnOneKeyRefuse:set_active(false)
	else
		self.nodeNoTips:set_active(false)
		-- PublicFunc:SetUISpriteWhite(self.spOneKeyRefuse)
		self.btnRecruitSet:set_position(self.btnPos[1][1],self.btnPos[1][2],self.btnPos[1][3])
		self.btnRecruitRelease:set_position(self.btnPos[2][1],self.btnPos[2][2],self.btnPos[2][3])
		self.btnOneKeyRefuse:set_active(true)
	end
end

function GuildApprovalUI:UpdateUi()
	if self.ui == nil then return end
	--TODO 更新招募状态显示 待聊天功能完成后接入


	local detail = g_dataCenter.guild.detail
	if detail then
		local str1 = (detail.applyLevel < self.openLevel) 
			and _local.UIText[5] or string.format(_local.UIText[6], detail.applyLevel)
		local str2 = _local.UIText[7 + detail.approvalRule] or ""
		local str = string.format(_local.UIText[4], str1, str2)
		self.labApplyCondition:set_text(str);
	end
end

-------------------------------------本地回调-------------------------------------
--招募设置
function GuildApprovalUI:on_btn_recruit_set(t)
	uiManager:PushUi(EUI.GuildSetApprovalUI)
end

--发布招募
function GuildApprovalUI:on_btn_recruit_release(t)
    local myData =  g_dataCenter.guild:GetMyMemberData()
    if myData and myData.job >= ENUM.EGuildJob.Minister then
        FloatTip.Float(_local.UIText[10])
        return
    end
    g_dataCenter.invite:SendInvite(__tData)
end

--[[邀请冷却]]
function GuildApprovalUI:handle_invite_cooling(callbackData)
    if g_dataCenter.invite:CanInvite(__tData) then 
        -- PublicFunc.SetUISpriteWhite(self.spRecruitRelease)
		PublicFunc.SetButtonShowMode(self.btnRecruitRelease, 1, "sp", "lab")
    else
        -- PublicFunc.SetUISpriteGray(self.spRecruitRelease)
		PublicFunc.SetButtonShowMode(self.btnRecruitRelease, 3, "sp", "lab")
    end
end

--一键拒绝
function GuildApprovalUI:on_btn_one_key_refuse(t)
	msg_guild.cg_dealwith_apply_join("0", 1)
end

--查看玩家
function GuildApprovalUI:on_btn_player(t)
	local playerid = t.string_value
	if playerid == g_dataCenter.player.playerid then
	-- 查看其它玩家信息
	else
		OtherPlayerPanel.ShowPlayer(playerid, ENUM.ETeamType.normal)
	end
end

--处理玩家申请 同意/拒绝
function GuildApprovalUI:on_btn_dealwith_apply(t)
	msg_guild.cg_dealwith_apply_join(t.string_value, t.float_value)
end

function GuildApprovalUI:on_init_item(obj, b, real_id)
	local index = math.abs(real_id) + 1;

	local item = self.items[b]
    if not item then
		item = {}
		item.btnPlayerName = ngui.find_button(obj, obj:get_name())
		item.labPlayerName = ngui.find_label(obj, "lab_name")
		item.labPlayerLevel = ngui.find_label(obj, "lab_level")
		item.labApplyTime = ngui.find_label(obj, "lab_time")
		item.btnRefuse = ngui.find_button(obj, "btn1")
		item.btnAgree = ngui.find_button(obj, "btn2")
		item.btnPlayerName:set_on_click(self.bindfunc["on_btn_player"])
		item.btnRefuse:set_on_click(self.bindfunc["on_btn_dealwith_apply"])
		item.btnAgree:set_on_click(self.bindfunc["on_btn_dealwith_apply"])

		local cardObj = obj:get_child_by_name("sp_head_di_item")
		item.uiPlayerHead = UiPlayerHead:new({parent=cardObj})
		
		self.items[b] = item
	end

	local data = g_dataCenter.guild:GetPlayerApplyByIndex(index)
	if data then
		item.labPlayerName:set_text(data.name)
		item.labPlayerLevel:set_text(string.format(_local.UIText[11], data.level))

		local secs = math.max(0, system.time() - data.time)
		local str = string.format(TimeAnalysis.analysisSec_4(secs, true))
		item.labApplyTime:set_text(str)

		item.uiPlayerHead:SetRoleId(data.imageId)
		item.uiPlayerHead:SetVipLevel(data.vipLevel)

		item.btnPlayerName:set_event_value(data.playerid, 0)
		item.btnRefuse:set_event_value(data.playerid, 1)
		item.btnAgree:set_event_value(data.playerid, 0)
	end
end

-------------------------------------网络回调-------------------------------------
--审核权限修改结果
function GuildApprovalUI:on_update_guild_config()
	self:UpdateUi()
end

-- 处理玩家申请结果
function GuildApprovalUI:on_dealwith_apply_join()
	self:UpdateList()
	self:UpdateUi()
end
