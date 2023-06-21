--region guild_set_name_ui.lua
--author : zzc
--date   : 2016/07/22

-- 修改社团名字界面
GuildSetNameUI = Class('GuildSetNameUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.uipath = "assetbundles/prefabs/ui/guild/ui_2811_guild_tc.assetbundle"

_local.UIText = {
	[1] = "社团名字",
	[2] = "名字不能超过6个字",
	[3] = "名字包含敏感词汇",
	[4] = "请输入名字",
}

_local.send_msg_change_name = function(name)
    msg_guild.cg_change_guild_name(name)
end

-------------------------------------类方法-------------------------------------
function GuildSetNameUI:Init(data)
    self.pathRes = _local.uipath;
	--改名消耗
	self.needCost = 
		ConfigManager.Get(EConfigIndex.t_discrete, 
			MsgEnum.ediscrete_id.eDiscreteId_guildChangeNameCost).data
	UiBaseClass.Init(self, data);
end

function GuildSetNameUI:Restart(data)
	UiBaseClass.Restart(self, data)
end

function GuildSetNameUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function GuildSetNameUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_btn_ok"] = Utility.bind_callback(self, self.on_btn_ok)
	self.bindfunc["on_change_guild_name"] = Utility.bind_callback(self, self.on_change_guild_name)
end

function GuildSetNameUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_change_guild_name, self.bindfunc["on_change_guild_name"])
end

function GuildSetNameUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_change_guild_name, self.bindfunc["on_change_guild_name"])
end

function GuildSetNameUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_set_name");

	
	local path = "centre_other/animation/"
	------------------------------ 中部 -----------------------------
	local btnClose = ngui.find_button(self.ui, "btn_cha")
	local btnOk = ngui.find_button(self.ui, path.."cont/btn_confirm")
	self.input = ngui.find_input(self.ui, path.."cont/input_cont")
	self.labInputTips = ngui.find_label(self.ui, path.."cont/input_cont/lab_name")
	self.labCost = ngui.find_label(self.ui, path.."cont/sp_bk_bar/lab_num")

	btnClose:set_on_click(self.bindfunc["on_btn_close"])
	btnOk:set_on_click(self.bindfunc["on_btn_ok"])
	self.labInputTips:set_text(_local.UIText[1])

	self.labCost:set_text(tostring(self.needCost))
end

function GuildSetNameUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function GuildSetNameUI:on_btn_close()
	uiManager:PopUi()
end

function GuildSetNameUI:on_btn_ok()
	local name = self.input:get_value()

	if PublicFunc.IllegalName(name) then
		FloatTip.Float(_local.UIText[3])
		self.input:set_value("")
		return
	end

	local num = PublicFunc.GetUtf8Character(name)
	if num == 0 then
		FloatTip.Float(_local.UIText[4])
		return
	end

	if num > 6 then
		FloatTip.Float(_local.UIText[2])
		return
	end

	if self.needCost > g_dataCenter.player.crystal then
		PublicFunc.BuyCheck(_local.send_msg_change_name, name, self.needCost, IdConfig.Crystal)
	else
		_local.send_msg_change_name(name)
	end
end
-------------------------------------网络回调-------------------------------------
function GuildSetNameUI:on_change_guild_name()
	uiManager:PopUi()
end
