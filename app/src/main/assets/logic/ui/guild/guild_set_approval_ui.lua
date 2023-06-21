--region guild_set_approval_ui.lua
--author : zzc
--date   : 2016/07/22

-- 社团审批设置界面
GuildSetApprovalUI = Class('GuildSetApprovalUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.uipath = "assetbundles/prefabs/ui/guild/ui_2813_guild_tc.assetbundle"

_local.UIText = {
	[1] = "招募设置",
	[2] = "招募类型",
	[3] = "等级限制",
	[4] = "允许任何人加入",
	[5] = "申请加入",
	[6] = "禁止加入",
	[7] = "无限制",
}

-------------------------------------类方法-------------------------------------
function GuildSetApprovalUI:Init(data)
    self.pathRes = _local.uipath;
	UiBaseClass.Init(self, data);
end

function GuildSetApprovalUI:Restart(data)
	UiBaseClass.Restart(self, data)
end

function GuildSetApprovalUI:InitData(data)
	self.maxLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_playerMaxLevel).data
	self.openLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data
	self.typeStrArray = {_local.UIText[4], _local.UIText[5], _local.UIText[6]} -- 对应approval 0,1,2
	UiBaseClass.InitData(self, data);
end

function GuildSetApprovalUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_btn_left1"] = Utility.bind_callback(self, self.on_btn_left1)
	self.bindfunc["on_btn_left2"] = Utility.bind_callback(self, self.on_btn_left2)
	self.bindfunc["on_btn_right1"] = Utility.bind_callback(self, self.on_btn_right1)
	self.bindfunc["on_btn_right2"] = Utility.bind_callback(self, self.on_btn_right2)
	self.bindfunc["on_btn_confirm"] = Utility.bind_callback(self, self.on_btn_confirm)
	self.bindfunc["on_update_guild_config"] = Utility.bind_callback(self, self.on_update_guild_config)
end

function GuildSetApprovalUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_update_guild_config, self.bindfunc["on_update_guild_config"])
end

function GuildSetApprovalUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_update_guild_config, self.bindfunc["on_update_guild_config"])
end

function GuildSetApprovalUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_set_approval");

	local data = g_dataCenter.guild.detail
	self.level = data.applyLevel
	self.approval = data.approvalRule

	local path = "centre_other/animation/cont/"
	local labHead1 = ngui.find_label(self.ui, path.."txt1")
	local labHead2 = ngui.find_label(self.ui, path.."txt2")
	self.labContent1 = ngui.find_label(self.ui, path.."txt1/cont/lab_name")
	self.labContent2 = ngui.find_label(self.ui, path.."txt2/cont/lab_name")

	local btnLeft1 = ngui.find_button(self.ui, path.."txt1/btn_left")
	local btnRight1 = ngui.find_button(self.ui, path.."txt1/btn_right")
	local btnLeft2 = ngui.find_button(self.ui, path.."txt2/btn_left")
	local btnRight2 = ngui.find_button(self.ui, path.."txt2/btn_right")

	local btnConfirm = ngui.find_button(self.ui, path.."btn_confirm")
	local btnClose = ngui.find_button(self.ui, "btn_cha")

	btnConfirm:set_on_click(self.bindfunc["on_btn_confirm"])
	btnClose:set_on_click(self.bindfunc["on_btn_close"])
	btnLeft1:set_on_click(self.bindfunc["on_btn_left1"])
	btnRight1:set_on_click(self.bindfunc["on_btn_right1"])
	btnLeft2:set_on_click(self.bindfunc["on_btn_left2"])
	btnRight2:set_on_click(self.bindfunc["on_btn_right2"])

	labHead1:set_text(_local.UIText[2])
	labHead2:set_text(_local.UIText[3])

    self:UpdateUi()
end

function GuildSetApprovalUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function GuildSetApprovalUI:UpdateUi()
	if self.ui == nil then return end

	self.labContent1:set_text(self:GetTypeStr())
	self.labContent2:set_text(self:GetLevelStr())
end

function GuildSetApprovalUI:GetTypeStr()
	return self.typeStrArray[self.approval + 1]
end

function GuildSetApprovalUI:GetLevelStr()
	if self.level >= self.openLevel then
		return tostring(self.level)
	else
		return _local.UIText[7]
	end
end

-------------------------------------本地回调-------------------------------------
function GuildSetApprovalUI:on_btn_close()
	uiManager:PopUi()
end

function GuildSetApprovalUI:on_btn_left1()
	self.approval = self.approval - 1
	if self.approval < 0 then
		self.approval = 2
	end
	self.labContent1:set_text(self:GetTypeStr())
end

function GuildSetApprovalUI:on_btn_right1()
	self.approval = self.approval + 1
	if self.approval > 2 then
		self.approval = 0
	end
	self.labContent1:set_text(self:GetTypeStr())
end

function GuildSetApprovalUI:on_btn_left2()
	if self.level < self.openLevel then
		self.level = self.maxLevel
	else
		self.level = self.level - 1
	end
	self.labContent2:set_text(self:GetLevelStr())
end

function GuildSetApprovalUI:on_btn_right2()
	if self.level == self.maxLevel then
		self.level = self.openLevel - 1
	else
		self.level = math.max(self.openLevel, self.level + 1)
	end
	self.labContent2:set_text(self:GetLevelStr())
end

function GuildSetApprovalUI:on_btn_confirm()
	local data = g_dataCenter.guild.detail
	msg_guild.cg_update_guild_config(self.level, self.approval, data.declaration, data.icon)
end

-------------------------------------网络回调-------------------------------------
--修改结果
function GuildSetApprovalUI:on_update_guild_config()
	uiManager:PopUi()
end
