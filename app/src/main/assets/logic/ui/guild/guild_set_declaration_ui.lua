--region guild_set_declaration_ui.lua
--author : zzc
--date   : 2016/08/19

-- 设置社团公告界面
GuildSetDeclarationUI = Class('GuildSetDeclarationUI', InputConfirmUI)

-------------------------------------local声明-------------------------------------
local _UIText = {
	[1] = "修改公告",
	[2] = "社长很懒，什么都没有写。",
	[3] = "社团公告不能超过50个字",
	[4] = "内容包含敏感词汇",
}

-------------------------------------类方法-------------------------------------
function GuildSetDeclarationUI:RegistFunc()
    InputConfirmUI.RegistFunc(self);
	self.bindfunc["on_callback_ok"] = Utility.bind_callback(self, self.on_callback_ok)
	self.bindfunc["on_update_guild_config"] = Utility.bind_callback(self, self.on_update_guild_config)
end

function GuildSetDeclarationUI:MsgRegist()
	InputConfirmUI.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_update_guild_config, self.bindfunc["on_update_guild_config"])
end

function GuildSetDeclarationUI:MsgUnRegist()
	InputConfirmUI.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_update_guild_config, self.bindfunc["on_update_guild_config"])
end

function GuildSetDeclarationUI:InitUI(asset_obj)
	InputConfirmUI.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_set_declaration");


	-- 设置各项参数
	self:SetOkCallback(self.bindfunc["on_callback_ok"])
	self:SetTitle(_UIText[1])
	self:SetInputTips(_UIText[2])
	self:SetCharLimit("50")
	local detail = g_dataCenter.guild:GetDetail()
	self.input:set_value(detail.declaration)
end

function GuildSetDeclarationUI:on_callback_ok()
	local detail = g_dataCenter.guild:GetDetail()
	local declaration = self.input:get_value()

	if PublicFunc.IllegalName(declaration) then
		FloatTip.Float(_UIText[4])
		return
	end

	if PublicFunc.GetUtf8Character(declaration) > 50 then
		FloatTip.Float(_UIText[3])
		return
	end

	msg_guild.cg_update_guild_config(detail.level, detail.approvalRule, declaration, detail.icon)
end


-------------------------------------网络回调-------------------------------------
--修改结果
function GuildSetDeclarationUI:on_update_guild_config()
	uiManager:PopUi()
    PublicFunc.msg_dispatch("guild_set_declaration_success", true)
end
