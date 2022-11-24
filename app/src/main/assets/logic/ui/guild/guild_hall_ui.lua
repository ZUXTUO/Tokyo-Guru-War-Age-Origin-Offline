--region guild_hall_ui.lua
--author : zzc
--date   : 2016/07/22

-- 社团大厅界面
GuildHallUI = Class('GuildHallUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}

_local.UIText = {
	["tab_1"] = "基础信息",
	["tab_2"] = "社团审核",
	["tab_3"] = "社团日志",
}

-------------------------------------类方法-------------------------------------
--初始化
function GuildHallUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/ui_2800_guild_bg.assetbundle"
	UiBaseClass.Init(self, data);
end

function GuildHallUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
	end
end

function GuildHallUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function GuildHallUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_toggle_change"] = Utility.bind_callback(self, self.on_toggle_change)
	self.bindfunc["on_update_member_data"] = Utility.bind_callback(self, self.on_update_member_data)
end

function GuildHallUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_update_member_data, self.bindfunc["on_update_member_data"])
end

function GuildHallUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_update_member_data, self.bindfunc["on_update_member_data"])
end

function GuildHallUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_main");

	self.tabIndex = 0		-- 1.基础信息 2.社团审核 3.社团日志

	self.tabYeka = {}
	self.labYeka = {}
	self.labYekaHui = {}
	self.spRedDot = {}
	for i=1, 3 do
		local nodeObj = self.ui:get_child_by_name("center_other/animation/yeka/yeka"..i)
		self.spRedDot[i] = ngui.find_sprite(nodeObj, "sp_point")
		self.tabYeka[i] = ngui.find_toggle(nodeObj, nodeObj:get_name())
		self.labYeka[i] = ngui.find_label(nodeObj, "lab1")
		self.labYekaHui[i] = ngui.find_label(nodeObj, "lab_hui")
		self.tabYeka[i]:set_on_change(self.bindfunc["on_toggle_change"])
		if i == 2 then
			self.yeka2 = {
				spFocus = ngui.find_sprite(nodeObj, "sp1"),
				spNormal = ngui.find_sprite(nodeObj, "sp_hui")
			}
		end
		self.spRedDot[i]:set_active(false)
	end
	
	self.labYeka[1]:set_text(_local.UIText["tab_1"])
	self.labYekaHui[1]:set_text(_local.UIText["tab_1"])
	self.labYeka[2]:set_text(_local.UIText["tab_2"])
	self.labYekaHui[2]:set_text(_local.UIText["tab_2"])
	self.labYeka[3]:set_text(_local.UIText["tab_3"])
	self.labYekaHui[3]:set_text(_local.UIText["tab_3"])

	self:UpdateUi()
end

function GuildHallUI:DestroyUi()
	self.tabYeka = nil
	self.labYeka = nil
	self.spRedDot = nil
	if self.subUi then
		self.subUi:DestroyUi()
		self.subUi = nil
	end

	UiBaseClass.DestroyUi(self);
end

function GuildHallUI:SwitchView(index)
	if self.ui == nil then return end
	if self.tabIndex == index then return end

	self.tabIndex = index

	if self.subUi then
		self.subUi:DestroyUi()
	end
	--基础信息
	if self.tabIndex == 1 then
		self.subUi = GuildInfoUI:new({parent = self.ui})
	--社团审核
	elseif self.tabIndex == 2 then
		self.subUi = GuildApprovalUI:new({parent = self.ui})
	--社团日志
	elseif self.tabIndex == 3 then
		self.subUi = GuildLogUI:new({parent = self.ui})
	end
end

function GuildHallUI:UpdateUi()
	if self.ui == nil then return end

	--是否有管理权限，普通社员隐藏审核页签
	local mydata = g_dataCenter.guild:GetMyMemberData()
	if mydata.job == ENUM.EGuildJob.Member then
		self.tabYeka[3]:set_active(false)
		self.tabYeka[2]:set_name("yeka3")
		self.labYeka[2]:set_text(_local.UIText["tab_3"])
		self.labYekaHui[2]:set_text(_local.UIText["tab_3"])

		--最后一个
		self.yeka2.spFocus:set_sprite_name("ty_anniu6")
		self.yeka2.spNormal:set_sprite_name("ty_anniu7")
	else
		self.tabYeka[3]:set_active(true)
		self.tabYeka[2]:set_name("yeka2")
		self.labYeka[2]:set_text(_local.UIText["tab_2"])
		self.labYekaHui[2]:set_text(_local.UIText["tab_2"])

		--中间位置
		self.yeka2.spFocus:set_sprite_name("ty_anniu8")
		self.yeka2.spNormal:set_sprite_name("ty_anniu9")
	end
end

--点击页签按钮
function GuildHallUI:on_toggle_change(value, name)
	if value == true then
        local index = 1
        if name == "yeka1" then
            index = 1
        elseif name == "yeka2" then
            index = 2
        elseif name == "yeka3" then
            index = 3
        end
        self:SwitchView(index)
    end
end

--社团成员自己数据变更，刷新页签
function GuildHallUI:on_update_member_data(ntype, memberData)
	self:UpdateUi()
end