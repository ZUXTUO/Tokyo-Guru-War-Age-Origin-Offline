--region guild_search_ui.lua
--author : zzc
--date   : 2016/07/20

-- 社团创建界面
GuildSearchUI = Class('GuildSearchUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.UIText = {
	[1] = "点击输入您想加入的社团名称或ID",
	[2] = "等级:",
	[3] = "需申请",
	[4] = "自由加入",
	[5] = "禁止加入",
	[6] = "%s级",
	[7] = "取消",
	[8] = "确定",
	[9] = "点击将取消之前已经提交的社团申请，是否继续？",
}

-------------------------------------类方法-------------------------------------
function GuildSearchUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/ui_2801_guild_search.assetbundle"
	UiBaseClass.Init(self, data);
end

function GuildSearchUI:Restart(data)
    UiBaseClass.Restart(self, data);
end

function GuildSearchUI:InitData(data)
	UiBaseClass.InitData(self, data);

	self.dataCenter = g_dataCenter.guild
	self.selectIcon = 0
end

function GuildSearchUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	
	self.bindfunc["on_focus_item"] = Utility.bind_callback(self, self.on_focus_item)
	self.bindfunc["on_btn_search"] = Utility.bind_callback(self, self.on_btn_search)
	self.bindfunc["on_btn_view"] = Utility.bind_callback(self, self.on_btn_view)
	self.bindfunc["on_btn_join"] = Utility.bind_callback(self, self.on_btn_join)
	self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
	self.bindfunc["on_look_for_guild"] = Utility.bind_callback(self, self.on_look_for_guild)
	self.bindfunc["on_apply_join"] = Utility.bind_callback(self, self.on_apply_join)
end

function GuildSearchUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_look_for_guild, self.bindfunc["on_look_for_guild"])
	PublicFunc.msg_regist(msg_guild.gc_apply_join, self.bindfunc["on_apply_join"])
end

function GuildSearchUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_look_for_guild, self.bindfunc["on_look_for_guild"])
	PublicFunc.msg_unregist(msg_guild.gc_apply_join, self.bindfunc["on_apply_join"])
end

function GuildSearchUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_search");

	self.items = {}
	self.pageData = {}
	

	local path = "centre_other/animation/"
	------------------------------ 顶部 -----------------------------
	local btnSearch = ngui.find_button(self.ui, path.."cont/btn")
	local labInputTips = ngui.find_label(self.ui, path.."cont/input_account/lab_name")
	self.inputName = ngui.find_input(self.ui, path.."cont/input_account")
	self.labNotFound = ngui.find_label(self.ui, path.."lab_lab")

	btnSearch:set_on_click(self.bindfunc["on_btn_search"])
	labInputTips:set_text(_local.UIText[1])
	self.labNotFound:set_active(false)
	

	path = "centre_other/animation/scro_view/"
	self.svList = ngui.find_scroll_view(self.ui, path.."panel")
	self.wcList = ngui.find_wrap_content(self.ui, path.."panel/wrap_content")
	self.wcList:set_on_initialize_item(self.bindfunc["on_init_item"])

	self.wcList:set_min_index(1 - 0);
	self.wcList:set_max_index(0);
	self.wcList:reset();
	
	self.UpdateUi()
end

function GuildSearchUI:DestroyUi()
	if self.items then
		for b, item in pairs(self.items) do
			item.textureIcon:Destroy()
		end
		self.items = nil
	end

	self.focusIndex = nil

	UiBaseClass.DestroyUi(self);
end

function GuildSearchUI:UpdateList()
	for b, item in pairs(self.items) do
		self:LoadItem(item, item.index)
	end
end

function GuildSearchUI:UpdateUi()
	
end

function GuildSearchUI:LoadItem(item, index)
	item.index = index
	local data = self.pageData[index]
	if data then
		local config = ConfigManager.Get(EConfigIndex.t_guild_level,data.level) or {}
		local maxMemberNumber = config.member_limit or 0
		config = ConfigManager.Get(EConfigIndex.t_guild_icon, data.icon)
		if config then
			item.textureIcon:set_texture(config.icon)
		end
		local id = Guild.GetVisibleId(data.searchid)
		item.labName:set_text(data.name)
		-- item.labGuildID:set_text("ID: "..id)
		item.labLimitLevel:set_text(string.format(_local.UIText[6], data.applyLevel))
		item.labGuildLevel:set_text(_local.UIText[2]..data.level)

		--未满员显示绿色
		if data.membersNum < maxMemberNumber then
			item.labMemberCnt:set_text(string.format("[ffffff]%s/%s[-]", data.membersNum, maxMemberNumber))
		--满员显示红色
		else
			item.labMemberCnt:set_text(string.format("[ff0000]%s/%s[-]", data.membersNum, maxMemberNumber))
		end

		item.btnItem:set_event_value("", index)
		item.btnJoin:set_event_value("", index)

		-- 聚焦项
		-- item.spFocus:set_active(self.focusIndex == index)

		-- 自由加入
		if data.approvalRule == 0 then
			item.labAutoApply:set_text(_local.UIText[3])
		-- 需要审核
		elseif data.approvalRule == 1 then
			item.labAutoApply:set_text(_local.UIText[4])
		-- 禁止加入
		elseif data.approvalRule == 2 then
			item.labAutoApply:set_text(_local.UIText[5])
		end

		-- 已申请
		if self.dataCenter.applyGuildId == data.id then
			item.btnJoin:set_active(false)
			item.spState:set_active(true)
			item.spState:set_sprite_name("hy_yishengqing")
		-- 已满员
		elseif data.membersNum >= maxMemberNumber then
			item.btnJoin:set_active(false)
			item.spState:set_active(true)
			item.spState:set_sprite_name("st_yimanyuan")
		-- 禁止加入
		elseif data.approvalRule == 2 then
			item.btnJoin:set_active(false)
			item.spState:set_active(true)
			item.spState:set_sprite_name("st_jinzhijiaru")
		-- 加入
		else
			item.btnJoin:set_active(true)
			item.spState:set_active(false)
		end
	end
end

-------------------------------------本地回调-------------------------------------
--列表项
function GuildSearchUI:on_init_item(obj, b, real_id)
	local index = math.abs(real_id) + 1

	local item = self.items[b]
    if not item then
		item = {}
		item.labMemberCnt = ngui.find_label(obj, obj:get_name().."/lab_num")
		item.btnJoin = ngui.find_button(obj, "btn_join")
		item.labName = ngui.find_label(obj, "lab_name")
		item.labAutoApply = ngui.find_label(obj, "lab_freedom")
		item.labLimitLevel = ngui.find_label(obj, "lab_level2")
		item.textureIcon = ngui.find_texture(obj, "guild_texture")
		item.labGuildLevel = ngui.find_label(obj, "lab_level1")
		item.spState = ngui.find_sprite(obj, "sp_art_font1")
		-- item.spFocus = ngui.find_sprite(obj, "sp_line")
		item.btnItem = ngui.find_button(obj, obj:get_name())

		item.btnItem:set_on_click(self.bindfunc["on_btn_view"]) -- on_focus_item
		item.btnJoin:set_on_click(self.bindfunc["on_btn_join"])

		self.items[b] = item
	end

	self:LoadItem(item, index)
end

--点击某项
function GuildSearchUI:on_focus_item(t)
	self.focusIndex = t.float_value
	self:UpdateList()
end

--查询
function GuildSearchUI:on_btn_search(t)
	local content = self.inputName:get_value();

	if content == _local.UIText[1] then
		self.labNotFound:set_active(true)
	else
		self.labNotFound:set_active(false)
		local number = tonumber(content)
		if number then -- 优先ID查询
			-- 查询社团
			msg_guild.cg_look_for_guild(number, content)
		else
			msg_guild.cg_look_for_guild(0, content)
		end
	end
end

--加入指定社团
function GuildSearchUI:on_btn_join(t)
	local data = self.pageData[t.float_value]
	if data then
		if self.dataCenter.applyGuildId ~= "0" then
			local cbfunc = function ()
				msg_guild.cg_apply_join(data.id)
			end
			HintUI.SetAndShow(EHintUiType.two, _local.UIText[9], 
				{str = _local.UIText[8], func = cbfunc},
				{str = _local.UIText[7]});
		else
			msg_guild.cg_apply_join(data.id)
		end
	end
end

--查看社团信息
function GuildSearchUI:on_btn_view(t)
	local data = self.pageData[t.float_value]
	OtherGuildPanel.ShowGuild(data)
end

-------------------------------------网络回调-------------------------------------
--申请指定社团（或快速申请）
function GuildSearchUI:on_apply_join(guildID)
	if not self:IsShow() then return end
	-- 已申请待审批
	if not self.dataCenter:IsJoinedGuild() then
		-- 首先关闭社团详情界面
		OtherGuildPanel.Destroy()
		self:UpdateUi()
	end
end

--返回ID查询社团
function GuildSearchUI:on_look_for_guild(result, data)
	if self.ui == nil then return end

	self.pageData = {}
	if result == 0 then
		table.insert(self.pageData, GuildSimple:new(data))
		self.labNotFound:set_active(false)
	else
		self.labNotFound:set_active(true)
	end

	self.wcList:set_min_index(1-#self.pageData)
	self.wcList:set_max_index(0)
	self.wcList:reset()
	self.svList:reset_position()
end
