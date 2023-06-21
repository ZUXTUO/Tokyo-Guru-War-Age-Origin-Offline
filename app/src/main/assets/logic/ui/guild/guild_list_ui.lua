--region guild_list_ui.lua
--author : zzc
--date   : 2016/07/20

-- 公会列表界面
GuildListUI = Class('GuildListUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.PageMaxCount = 10	-- 当前一页最大显示个数

_local.UIText = {
	[1] = "%s级",
	[3] = "自由加入",
	[4] = "需申请",
	[5] = "[ff0000]禁止加入[-]",
	[6] = "取消",
	[7] = "确定",
	[8] = "点击将取消之前已经提交的社团申请，是否继续？",
	[9] = "无等级限制",
	[10] = "·社团",
	[11] = "等级 ",
}

_local.send_msg_apply = function(id)
	msg_guild.cg_apply_join(id)
end

-------------------------------------类方法-------------------------------------
function GuildListUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/ui_2804_guild_join.assetbundle"
	UiBaseClass.Init(self, data);
end

function GuildListUI:Restart(data)
    UiBaseClass.Restart(self, data)
end

function GuildListUI:InitData(data)
	UiBaseClass.InitData(self, data);

	self.dataCenter = g_dataCenter.guild
	self.simpleList = {}	-- 公会列表数据
	self.togglePage	= 0		-- 准备切换状态（-1前翻，0不变，1后翻）
	self.pageData   = {}	-- 当前页数据
	self.pageIndex  = 1		-- 当前页索引
	self.openLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data
end

function GuildListUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_focus_item"] = Utility.bind_callback(self, self.on_focus_item)
	self.bindfunc["on_btn_create"] = Utility.bind_callback(self, self.on_btn_create)
	self.bindfunc["on_btn_quick"] = Utility.bind_callback(self, self.on_btn_quick)
	self.bindfunc["on_btn_left"] = Utility.bind_callback(self, self.on_btn_left)
	self.bindfunc["on_btn_right"] = Utility.bind_callback(self, self.on_btn_right)
	self.bindfunc["on_btn_view"] = Utility.bind_callback(self, self.on_btn_view)
	self.bindfunc["on_btn_join"] = Utility.bind_callback(self, self.on_btn_join)
	self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
	self.bindfunc["on_request_guild_list"] = Utility.bind_callback(self, self.on_request_guild_list)
	self.bindfunc["on_apply_join"] = Utility.bind_callback(self, self.on_apply_join)
end

function GuildListUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_request_guild_list, self.bindfunc["on_request_guild_list"])
	PublicFunc.msg_regist(msg_guild.gc_apply_join, self.bindfunc["on_apply_join"])
end

function GuildListUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_request_guild_list, self.bindfunc["on_request_guild_list"])
	PublicFunc.msg_unregist(msg_guild.gc_apply_join, self.bindfunc["on_apply_join"])
end

function GuildListUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_list");

	self.items = {}

	local path = "centre_other/animation/scroll_view/"
	self.svList = ngui.find_scroll_view(self.ui, path.."panel_list")
    self.wcList = ngui.find_wrap_content(self.ui, path.."panel_list/wrap_content")
	self.wcList:set_on_initialize_item(self.bindfunc["on_init_item"])

	path = "centre_other/animation/sp_title/"
	--修改的标题
	self.labAreaTitle = ngui.find_label(self.ui, path.."txt2")
	-- local config = ConfigManager.Get(EConfigIndex.t_country_info, g_dataCenter.player.country_id) or {}
	-- self.labAreaTitle:set_text( (config.name or "") .. _local.UIText[10] )

	path = "centre_other/animation/sp_down_di/"
	local btnQuickApplay = ngui.find_button(self.ui, path.."btn_manage")
	local btnCreate = ngui.find_button(self.ui, path.."btn_gread")
	local btnLeft = ngui.find_button(self.ui, path.."btn1")
	local btnRight = ngui.find_button(self.ui, path.."btn2")
	self.labPage = ngui.find_label(self.ui, path.."lab_num")
	self.spLeft = ngui.find_sprite(self.ui, path.."btn1/animation/sp")
	self.spRight = ngui.find_sprite(self.ui, path.."btn2/animation/sp")

	btnCreate:set_on_click(self.bindfunc["on_btn_create"])
	btnQuickApplay:set_on_click(self.bindfunc["on_btn_quick"])
	btnLeft:set_on_click(self.bindfunc["on_btn_left"])
	btnRight:set_on_click(self.bindfunc["on_btn_right"])

	-- 已有缓存数据
	if self.dataCenter.simpleList then
		self.simpleList = self.dataCenter.simpleList
		self.pageData = self:GetPageGuildData(self.pageIndex, true)
	else
		self.pageIndex = 1
		self.togglePage = 0

		self:RequestGuildList()
	end

	self:ResetList()
	self:UpdateUi()
end

function GuildListUI:DestroyUi()
	-- 释放texture
	if self.items then
		for i, item in pairs(self.items) do
			item.textureIcon:Destroy()
		end
		self.items = nil
	end

	self.focusIndex = nil

	UiBaseClass.DestroyUi(self);
end

function GuildListUI:RequestGuildList()
	if #self.simpleList == 0 then
		-- local ownCountryId = tonumber(g_dataCenter.player.country_id) or 0
		-- if ownCountryId ~= 0 then
			msg_guild.cg_request_guild_list(1)
		-- end
	end

	local config = ConfigManager.Get(EConfigIndex.t_country_info, g_dataCenter.player.country_id) or {}
	self.labAreaTitle:set_text( (config.name or "") .. _local.UIText[10] )
end

--返回当前页列表数据
--参数
--  index  查询页索引
function GuildListUI:GetPageGuildData(index)
	local result = {}

	index = math.mod(index - 1, 4) + 1 -- 1组数据为4页, 得到分组页索引

	local pageStart = (index - 1) * _local.PageMaxCount + 1
	local pageEnd = index * _local.PageMaxCount
	for i = pageStart, pageEnd do
		local data = self.simpleList[i]
		if data then
			table.insert(result, data)
		else
			break
		end
	end

	return result
end

--返回当前页列表数据, index
--参数
--  index  查询页索引（默认为pageIndex）
function GuildListUI:GetPageGuildDataById(guildID)
	local result = {}

	local index = 1

	for i, v in ipairs(self.simpleList) do
		if v.id == guildID then
			index = i
			break;
		end
	end

	local pageIndex = math.max(1, math.ceil(index / _local.PageMaxCount))

	local pageStart = (pageIndex - 1) * _local.PageMaxCount + 1
	local pageEnd = pageIndex * _local.PageMaxCount
	for i = pageStart, pageEnd do
		local data = self.simpleList[i]
		if data then
			table.insert(result, data)
		else
			break
		end
	end

	return result, pageIndex
end

function GuildListUI:ResetList()
	local count = math.min(#self.pageData, _local.PageMaxCount)
	self.wcList:set_min_index(1 - count);
    self.wcList:set_max_index(0);
	self.wcList:reset();
	self.svList:reset_position()
end

function GuildListUI:UpdateList()
	for b, item in pairs(self.items) do
		self:LoadItem(item, item.index)
	end
end

function GuildListUI:UpdateUi()
	if self.ui == nil then return end

	self:UpdateList()

	local totalPage = math.max(1, math.ceil(self.dataCenter.simpleCount/_local.PageMaxCount))
	if self.dataCenter.simpleList then
		self.labPage:set_text(string.format("%s/%s", self.pageIndex, totalPage))
	else
		self.labPage:set_text("-/-")
	end

	PublicFunc.SetPageArrowSprite(self.spLeft, self.pageIndex > 1)
	PublicFunc.SetPageArrowSprite(self.spRight, self.pageIndex < totalPage)
end

function GuildListUI:LoadItem(item, index)
	item.index = index
	local data = self.pageData[index]
	if data then
		local config = ConfigManager.Get(EConfigIndex.t_guild_level,data.level) or {}
		config = ConfigManager.Get(EConfigIndex.t_guild_icon, data.icon)
		if config then
			item.textureIcon:set_texture(config.icon)
		end
		local id = Guild.GetVisibleId(data.searchid)
		item.labName:set_text(data.name)
		-- item.labGuildID:set_text("ID: "..id)
		local str = _local.UIText[9]
		if data.applyLevel >= self.openLevel then
			str = string.format(_local.UIText[1], data.applyLevel)
		end
		item.labLimitLevel:set_text(str)
		item.labGuildLevel:set_text(_local.UIText[11]..PublicFunc.GetColorText(tostring(data.level), "orange_light"))

		local ownMemberNumber = Guild.GetMemberNumber(data)
		local maxMemberNumber = Guild.GetMemberLimit(data)
		--未满员显示绿色
		if ownMemberNumber < maxMemberNumber then
			item.labMemberCnt:set_text(string.format("[ffffff]%s/%s[-]", ownMemberNumber, maxMemberNumber))
		--满员显示红色
		else
			item.labMemberCnt:set_text(string.format("[ff0000]%s/%s[-]", ownMemberNumber, maxMemberNumber))
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

		if data.rank > 0 and data.rank <= 3 then
			item.spRank123:set_active(true)
			item.spRank123Bg:set_active(true)
			item.spRankOther:set_active(false)
			item.labRankOther:set_active(false)
			PublicFunc.SetRank123Sprite(item.spRank123, data.rank)
			PublicFunc.SetRank123SpriteBg(item.spRank123Bg, data.rank)
		else
			item.spRank123:set_active(false)
			item.spRank123Bg:set_active(false)
			item.spRankOther:set_active(true)
			item.labRankOther:set_active(true)
			item.labRankOther:set_text(tostring(data.rank))
		end
		-- PublicFunc.SetRank123ItemBg(item.spItemBg, data.rank)
	end
end

function GuildListUI:GotoPage(index)
	local groupIndex = math.ceil(index / 4)
	msg_guild.cg_request_guild_list(groupIndex)
end

-------------------------------------本地回调-------------------------------------
function GuildListUI:on_init_item(obj, b, real_id)
	local index = math.abs(real_id) + 1

	local item = self.items[b]
    if not item then
		item = {}
		item.labMemberCnt = ngui.find_label(obj, obj:get_name().."/lab_num")
		item.btnJoin = ngui.find_button(obj, "btn_manage")
		item.labJoin = ngui.find_label(obj, "btn_manage/animation/lab")
		item.labName = ngui.find_label(obj, "lab_name")
		item.labAutoApply = ngui.find_label(obj, "lab_freedom")
		item.labLimitLevel = ngui.find_label(obj, "lab_level2")
		item.textureIcon = ngui.find_texture(obj, "guild_texture")
		item.labGuildLevel = ngui.find_label(obj, "lab_level1")
		item.spState = ngui.find_sprite(obj, "sp_art_font")
		-- item.spItemBg = ngui.find_sprite(obj, "sp_di")
		item.spRank123Bg = ngui.find_sprite(obj, "sp_bk")
		item.spRank123 = ngui.find_sprite(obj, "sp_rank")
		item.spRankOther = ngui.find_sprite(obj, "sp_bb")
		item.labRankOther = ngui.find_label(obj, "lab_rank")
		-- item.spFocus = ngui.find_sprite(obj, "sp_line")
		item.btnItem = ngui.find_button(obj, obj:get_name())

		item.btnItem:set_on_click(self.bindfunc["on_btn_view"]) -- on_focus_item
		item.btnJoin:set_on_click(self.bindfunc["on_btn_join"])

		self.items[b] = item
	end
	
	self:LoadItem(item, index)
end

--点击某项
function GuildListUI:on_focus_item(t)
	self.focusIndex = t.float_value
	self:UpdateList()
end

--创建社团
function GuildListUI:on_btn_create(t)
	uiManager:PushUi(EUI.GuildCreateUI)
end

--快速加入
function GuildListUI:on_btn_quick(t)
	-- HintUI.SetAndShow(EHintUiType.two, "系统将自动帮您选择一个社团尝试申请或者加入，是否继续？", 
	-- 	{str = _local.UIText[7], func = _local.send_msg_apply, param = 0},
	-- 	{str = _local.UIText[6]});
	_local.send_msg_apply("0")
end

--向左翻页
function GuildListUI:on_btn_left(t)
	local index = math.max(1, self.pageIndex - 1)
	if index == self.pageIndex then return end

	if self.dataCenter.simpleIndex > math.ceil(index / 4) then
		self.togglePage = -1
		self:GotoPage(index)
	else
		local data = self:GetPageGuildData(index)
		if #data > 0 then
			self.pageIndex = index
			self.pageData = data
			self:ResetList()
			self:UpdateUi()
		end
	end
end

--向右翻页
function GuildListUI:on_btn_right(t)
	local maxCount = math.ceil(self.dataCenter.simpleCount/_local.PageMaxCount)
	local index = math.min(self.pageIndex + 1, maxCount)
	if index == self.pageIndex then return end

	if self.dataCenter.simpleIndex < math.ceil(index / 4) then
		self.togglePage = 1
		self:GotoPage(index)
	else
		local data = self:GetPageGuildData(index)
		if #data > 0 then
			self.pageIndex = index
			self.pageData = data
			self:ResetList()
			self:UpdateUi()
		end
	end
end

--查看公会信息
function GuildListUI:on_btn_view(t)
	local data = self.pageData[t.float_value]
	OtherGuildPanel.ShowGuild(data)
end

--加入公会
function GuildListUI:on_btn_join(t)
	local data = self.pageData[t.float_value]
	if data then
		if self.dataCenter.applyGuildId ~= "0" then
			HintUI.SetAndShow(EHintUiType.two, _local.UIText[8], 
				{str = _local.UIText[7], func = _local.send_msg_apply, param = data.id},
				{str = _local.UIText[6]});
		else
			_local.send_msg_apply(data.id)
		end
	end
end


-------------------------------------网络回调-------------------------------------
--申请指定公会（或快速申请）
function GuildListUI:on_apply_join(guildID)
	if not self:IsShow() then return end
	-- 已申请待审批
	if not self.dataCenter:IsJoinedGuild() then
		-- 首先关闭公会详情界面
		uiManager:UpdateMsgData(EUI.GuildShortInfoUI, "on_btn_close")
		-- 切换到申请的公会处
		self.pageData, self.pageIndex = self:GetPageGuildDataById(guildID)
		self:UpdateUi()
	end
end

--返回公会列表数据
function GuildListUI:on_request_guild_list()
	if self.ui == nil then return end

	self.simpleList = self.dataCenter.simpleList
	local index = self.pageIndex + self.togglePage
	self.pageIndex = index
	self.pageData = self:GetPageGuildData(index)
	self:ResetList()
	self:UpdateUi()

	self.togglePage = 0
end
