--region guild_set_mail_ui.lua
--author : zzc
--date   : 2016/08/19

-- 社团邮件编辑界面
GuildSetMailUI = Class('GuildSetMailUI', InputConfirmUI)

-------------------------------------local声明-------------------------------------
local _UIText = {
	[1] = "全员邮件",
	[2] = "点击此处开始输入（最多输入200个字)",
	[3] = "邮件内容不能超过200个字",
	[4] = "内容包含敏感词汇",
}

-------------------------------------类方法-------------------------------------
function GuildSetMailUI:RegistFunc()
    InputConfirmUI.RegistFunc(self);
	self.bindfunc["on_callback_ok"] = Utility.bind_callback(self, self.on_callback_ok)
	self.bindfunc["gc_send_guild_mail"] = Utility.bind_callback(self, self.gc_send_guild_mail)
end

function GuildSetMailUI:MsgRegist()
	InputConfirmUI.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_send_guild_mail, self.bindfunc["gc_send_guild_mail"])
end

function GuildSetMailUI:MsgUnRegist()
	InputConfirmUI.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_send_guild_mail, self.bindfunc["gc_send_guild_mail"])
end

function GuildSetMailUI:InitUI(asset_obj)
	InputConfirmUI.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_set_mail");


	-- 设置各项参数
	self:SetOkCallback(self.bindfunc["on_callback_ok"])
	self:SetTitle(_UIText[1])
	self:SetInputTips(_UIText[2])
	self:SetCharLimit("200")
end

function GuildSetMailUI:on_callback_ok()
	local content = self.input:get_value()

	if PublicFunc.IllegalName(content) then
		FloatTip.Float(_UIText[4])
		return
	end

	if PublicFunc.GetUtf8Character(content) > 200 then
		FloatTip.Float(_UIText[3])
		return
	end

	msg_guild.cg_send_guild_mail("", content)
end


-------------------------------------网络回调-------------------------------------
--发送结果
function GuildSetMailUI:gc_send_guild_mail()
	uiManager:PopUi()
end
