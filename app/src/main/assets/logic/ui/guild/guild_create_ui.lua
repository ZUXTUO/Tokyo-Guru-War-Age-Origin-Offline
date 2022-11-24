--region guild_create_ui.lua
--author : zzc
--date   : 2016/07/20

-- 社团创建界面
GuildCreateUI = Class('GuildCreateUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.UIText = {
	[1] = "恭喜你，创建社团成功。",
	[2] = "前往",
	[3] = "当前钻石不足%d，是否前往充值？",
	[4] = "需要战队等级达到[f2ae1c]%s[-]级", --废弃
	[5] = "点击此处输入社团名字",
	[6] = "名字包含敏感词汇，请重新输入",
	[7] = "请选择社团徽章",
	[8] = "社团名字最多6个字",
	[9] = "请输入社团名称",
	[10] = "战队等级不足",
}

_local.send_msg_create = function(data)
	msg_guild.cg_create_guild(data.name, data.icon, data.level, false, "")
end

-------------------------------------类方法-------------------------------------
function GuildCreateUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/ui_2802_guild_gread.assetbundle"
	UiBaseClass.Init(self, data);
end

function GuildCreateUI:Restart(data)
    UiBaseClass.Restart(self, data);
end

function GuildCreateUI:InitData(data)
	UiBaseClass.InitData(self, data);
	self.selectIcon = 0
	--创建消耗
	self.needCost = 
		ConfigManager.Get(EConfigIndex.t_discrete,
			MsgEnum.ediscrete_id.eDiscreteId_guildCreateCost).data
	self.needLevel = 
		ConfigManager.Get(EConfigIndex.t_discrete,
			MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data
end

function GuildCreateUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_btn_icon"] = Utility.bind_callback(self, self.on_btn_icon)
	self.bindfunc["on_btn_create"] = Utility.bind_callback(self, self.on_btn_create)
	self.bindfunc["on_create_guild"] = Utility.bind_callback(self, self.on_create_guild)
	self.bindfunc["on_select_icon"] = Utility.bind_callback(self, self.SetIcon)
end

function GuildCreateUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_create_guild, self.bindfunc["on_create_guild"])
end

function GuildCreateUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_create_guild, self.bindfunc["on_create_guild"])
end

function GuildCreateUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_create");

	-- local mask = self.ui:get_child_by_name("ui_guild_create/sp_mark")
	-- mask:set_on_click(self.bindfunc["on_btn_close"])

	local path = "centre_other/animation/"
	------------------------------ 设置信息 -----------------------------
	local btnClose = ngui.find_button(self.ui, "btn_cha")
	local btnCreate = ngui.find_button(self.ui, path.."btn_gread")
	local iconNode = self.ui:get_child_by_name(path.."texture_guide") 
	self.textureIcon = ngui.find_texture(iconNode, "texture_guide")
	self.labFillIcon = ngui.find_label(iconNode, "lab_xuan_ze")
	self.nameInput = ngui.find_input(self.ui, "input_account")
	local labInputTips = ngui.find_label(self.ui, "input_account/lab_name")
	local labNeedLv = ngui.find_label(self.ui, path.."txt2/lab_num")
	local labNeedCost = ngui.find_label(self.ui, path.."txt4/lab_num")

	btnClose:set_on_click(self.bindfunc["on_btn_close"])
	iconNode:set_on_click(self.bindfunc["on_btn_icon"])
	btnCreate:set_on_click(self.bindfunc["on_btn_create"])
	
	labInputTips:set_text(_local.UIText[9])	
	labNeedLv:set_text(tostring(self.needLevel))
	labNeedCost:set_text(tostring(self.needCost))

	-- 默认选中第一个图标
	-- self:SetIcon(1)
end

function GuildCreateUI:DestroyUi()
	self.selectIcon = 0
	self.nameInput = nil
	-- 释放texture
	if self.textureIcon then
		self.textureIcon:Destroy()
		self.textureIcon = nil
	end

	UiBaseClass.DestroyUi(self);
end

function GuildCreateUI:SetIcon(index)
	self.labFillIcon:set_active(false) -- 隐藏提示文字
	self.selectIcon = index
	if self.selectIcon > 0 then
		local config = ConfigManager.Get(EConfigIndex.t_guild_icon,index)
		if config then
			self.textureIcon:set_texture(config.icon);
		end
	end
end

-------------------------------------本地回调-------------------------------------
function GuildCreateUI:on_btn_close()
	uiManager:PopUi()
end

--徽章
function GuildCreateUI:on_btn_icon()
	local data = {}
	data.iconIndex = self.selectIcon
	data.callback = self.bindfunc["on_select_icon"]
	uiManager:PushUi(EUI.GuildSetIconUI, data)
end

--创建
function GuildCreateUI:on_btn_create(t)
	-- 检查必填值
	local name = self.nameInput:get_value();
	local icon = self.selectIcon

	--社团等级不足
	if self.needLevel > g_dataCenter.player.level then
		FloatTip.Float(_local.UIText[10])
		return;
	-- 选择徽章
	elseif icon == 0 then
		FloatTip.Float(_local.UIText[7])
		return;
	--社团名字必需
	elseif name == "" or name == _local.UIText[9] then 
		FloatTip.Float(_local.UIText[5])
		return;
	--非法名检查
	elseif PublicFunc.IllegalName(name) then
		FloatTip.Float(_local.UIText[6])
		self.nameInput:set_value("")
		return;
	--社团名字最多6个字
	elseif PublicFunc.GetUtf8Character(name) > 6 then
		FloatTip.Float(_local.UIText[8])
		return;
	end

	local data = {name=name, icon=self.selectIcon, level=self.needLevel}
	PublicFunc.BuyCheck(_local.send_msg_create, data, self.needCost, IdConfig.Crystal)
end

-------------------------------------网络回调-------------------------------------
-- 创建社团成功
function GuildCreateUI:on_create_guild()
	-- 关闭当前界面
	uiManager:ClearStack()
	uiManager:PopUi()

	-- 创建成功提示
	HintUI.SetAndShow(EHintUiType.one, _local.UIText[1], {str=_local.UIText[2],func=function()
		-- 进入社团主界面
		uiManager:PushUi(EUI.GuildMainUI)
	end})
end
