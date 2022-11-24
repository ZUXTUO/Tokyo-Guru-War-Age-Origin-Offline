--region guild_look_ui.lua
--author : zzc
--date   : 2016/07/20

-- 公会浏览界面
GuildLookUI = Class('GuildLookUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}

_local.UIText = {
	["tab_1"] = "加入社团",
	["tab_2"] = "查找社团",
}

-------------------------------------类方法-------------------------------------
--初始化
function GuildLookUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/ui_2800_guild_bg.assetbundle"
	UiBaseClass.Init(self, data);
end

function GuildLookUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
	end
end

function GuildLookUI:Show()
	if UiBaseClass.Show(self) then
		-- 选区后回到公会列表界面，开始请求本区公会列表
		-- if self.tabIndex == 1 and self.subUi then
		-- 	self.subUi:RequestGuildList()
		-- end
	end
end

function GuildLookUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function GuildLookUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_toggle_change"] = Utility.bind_callback(self, self.on_toggle_change)
end

function GuildLookUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_look");

	self.tabIndex = 0		-- 1.社团列表 2.社团查询

	local tabYeka = {}
	local labYeka = {}
	local labYekaHui = {}
	self.spRedDot = {}
	for i=1, 3 do
		local nodeObj = self.ui:get_child_by_name("center_other/animation/yeka/yeka"..i)
		self.spRedDot[i] = ngui.find_sprite(nodeObj, "sp_point")
		tabYeka[i] = ngui.find_toggle(nodeObj, nodeObj:get_name())
		labYeka[i] = ngui.find_label(nodeObj, "lab1")
		labYekaHui[i] = ngui.find_label(nodeObj, "lab_hui")
		tabYeka[i]:set_on_change(self.bindfunc["on_toggle_change"])
		self.spRedDot[i]:set_active(false)
	end
	
	labYeka[1]:set_text(_local.UIText["tab_1"])
	labYekaHui[1]:set_text(_local.UIText["tab_1"])
	labYeka[2]:set_text(_local.UIText["tab_2"])
	labYekaHui[2]:set_text(_local.UIText["tab_2"])
	tabYeka[3]:set_active(false) -- 隐藏多余页签

	self:UpdateUi()

	self:SwitchView(1)

	-- 新手引导检查是否打开选区界面
	local data = self:GetInitData()
	if type(data) == "function" then
		data()
	end

	TimerManager.Add(GuildLookUI.OnTimeCheck, 1000, -1, self)
end

function GuildLookUI:DestroyUi()
	TimerManager.Remove(GuildLookUI.OnTimeCheck)
	if self.spRedDot then
		self.spRedDot = nil
	end
	if self.subUi then
		self.subUi:DestroyUi()
		self.subUi = nil
	end

	UiBaseClass.DestroyUi(self);
end

function GuildLookUI:SwitchView(index)
	if self.ui == nil then return end
	if self.tabIndex == index then return end

	self.tabIndex = index

	if self.subUi then
		self.subUi:DestroyUi()
	end
	--社团列表
	if self.tabIndex == 1 then
		self.subUi = GuildListUI:new({parent = self.ui})
	--查询社团
	elseif self.tabIndex == 2 then
		self.subUi = GuildSearchUI:new({parent = self.ui})
	end
end

function GuildLookUI:UpdateUi()
	if self.ui == nil then return end

	
end

--定时检测是否已经加入到公会
function GuildLookUI:OnTimeCheck()
	if g_dataCenter.guild:IsJoinedGuild() then
		-- 关闭当前界面
		uiManager:ClearStack()
		uiManager:PopUi()
		-- 前往社团
		local cbfunc = function() uiManager:PushUi(EUI.GuildMainUI) end
		local content = "您已经加入社团，赶紧去看看吧！"
		HintUI.SetAndShow(EHintUiType.one, content, {str="前往",func=cbfunc})
	end
end

--点击页签按钮
function GuildLookUI:on_toggle_change(value, name)
	if value == true then
		if self.isFirst ==nil then
			self.isFirst = true;
		else
			AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
		end
        local index = 1
        if name == "yeka1" then
            index = 1
        elseif name == "yeka2" then
            index = 2
        end
        self:SwitchView(index)
    end
end
