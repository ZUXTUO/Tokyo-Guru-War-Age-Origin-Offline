--region guild_info_ui.lua
--author : zzc
--date   : 2016/07/20

-- 社团基础信息界面
GuildInfoUI = Class('GuildInfoUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.UIText = {
	[1] = "[00ff00]在线[-]",
	[2] = "等级 ",
	[3] = "确定",
	[4] = "取消",
	[5] = "是否解散社团？",
	[6] = "是否退出社团？",
	[7] = "您被移出了社团", -- 废弃
	[8] = "社团仅有您一人时，才能解散社团。",
	[9] = "解散社团",
	[10] = "退出社团",
	[11] = "未上榜",

}

_local.send_msg_quit = function()
	msg_guild.cg_quit_guild()
end

_local.send_msg_dissolve = function()
	msg_guild.cg_guild_operation(3)
end

-------------------------------------类方法-------------------------------------
function GuildInfoUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/ui_2805_guild_information.assetbundle"
	UiBaseClass.Init(self, data);
end

function GuildInfoUI:Restart(data)
	--每次打开界面获取一次最新数据
	msg_guild.cg_sync_guild_tech_level_info(1); --社团科技实验室等级
	UiBaseClass.Restart(self, data)
end

function GuildInfoUI:InitData(data)
	UiBaseClass.InitData(self, data);
	self.dataCenter = g_dataCenter.guild
	-- self.quiting = false

	-- local activityCount = 0
	-- for i, v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_guild_activity)) do
	-- 	activityCount = activityCount + 1
	-- end
	-- self.activityCount = activityCount
	-- self.todoActivityCount = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildActivityTodoNumber).data;
end

function GuildInfoUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_select_icon"] = Utility.bind_callback(self, self.on_select_icon)
	self.bindfunc["on_btn_mail"] = Utility.bind_callback(self, self.on_btn_mail)
	self.bindfunc["on_btn_quit_guild"] = Utility.bind_callback(self, self.on_btn_quit_guild)
	self.bindfunc["on_btn_modify_guild_name"] = Utility.bind_callback(self, self.on_btn_modify_guild_name)
	self.bindfunc["on_btn_modify_guild_icon"] = Utility.bind_callback(self, self.on_btn_modify_guild_icon)
	self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
	self.bindfunc["on_btn_member"] = Utility.bind_callback(self, self.on_btn_member)
	self.bindfunc["on_sync_my_guild_data"] = Utility.bind_callback(self, self.on_sync_my_guild_data)
	self.bindfunc["on_guild_operation"] = Utility.bind_callback(self, self.on_guild_operation)
	-- self.bindfunc["on_quit_guild"] = Utility.bind_callback(self, self.on_quit_guild)
	self.bindfunc["on_update_info"] = Utility.bind_callback(self, self.UpdateUi)
end

function GuildInfoUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_sync_my_guild_data, self.bindfunc["on_sync_my_guild_data"])
	PublicFunc.msg_regist(msg_guild.gc_guild_operation, self.bindfunc["on_guild_operation"])
	-- PublicFunc.msg_regist(msg_guild.gc_quit_guild, self.bindfunc["on_quit_guild"])
	PublicFunc.msg_regist(msg_guild.gc_update_guild_data, self.bindfunc["on_update_info"])		--社团数据变更
	PublicFunc.msg_regist(msg_guild.gc_update_member_data, self.bindfunc["on_update_info"])		--社团成员变更
	PublicFunc.msg_regist(msg_guild.gc_update_guild_config, self.bindfunc["on_update_info"])	--社团设置变更
	PublicFunc.msg_regist(msg_guild.gc_sync_guild_level_info, self.bindfunc["on_update_info"])	--社团升级
	PublicFunc.msg_regist(msg_guild.gc_change_guild_name, self.bindfunc["on_update_info"])		--社团改名
	PublicFunc.msg_regist(msg_guild.gc_sync_guild_tech_level_info, self.bindfunc["on_update_info"])		--社团改名
end

function GuildInfoUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_sync_my_guild_data, self.bindfunc["on_sync_my_guild_data"])
	PublicFunc.msg_unregist(msg_guild.gc_guild_operation, self.bindfunc["on_guild_operation"])
	-- PublicFunc.msg_unregist(msg_guild.gc_quit_guild, self.bindfunc["on_quit_guild"])
	PublicFunc.msg_unregist(msg_guild.gc_update_guild_data, self.bindfunc["on_update_info"])
	PublicFunc.msg_unregist(msg_guild.gc_update_member_data, self.bindfunc["on_update_info"])
	PublicFunc.msg_unregist(msg_guild.gc_update_guild_config, self.bindfunc["on_update_info"])
	PublicFunc.msg_unregist(msg_guild.gc_sync_guild_level_info, self.bindfunc["on_update_info"])
	PublicFunc.msg_unregist(msg_guild.gc_change_guild_name, self.bindfunc["on_update_info"])
	PublicFunc.msg_unregist(msg_guild.gc_sync_guild_tech_level_info, self.bindfunc["on_update_info"])
end

function GuildInfoUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_info");

	self.memberList = {}
	self.items = {}
	self.itemCnt = nil

	local path = "centre_other/animation/sp_di/"
	------------------------------ 顶部 -----------------------------
	self.spGuildNameBg = ngui.find_sprite(self.ui, path.."sp_tiao")
	self.labGuildName = ngui.find_label(self.ui, path.."lab_name")
	self.textureIcon = ngui.find_texture(self.ui, path.."new_big_card_item/texture")
	self.labLeaderCnt = ngui.find_label(self.ui, path.."txt1/lab_num")
	self.labMemberCnt = ngui.find_label(self.ui, path.."txt2/lab_num")
	self.labViceCnt = ngui.find_label(self.ui, path.."txt3/lab_num")
	self.labRank = ngui.find_label(self.ui, path.."txt4/lab_num")
	self.labEliteCnt = ngui.find_label(self.ui, path.."txt5/lab_num")
	-- self.labAreaName = ngui.find_label(self.ui, path.."txt8/lab_num")
	self.labGuildLevel = ngui.find_label(self.ui, path.."txt6/lab_num")
	self.labGuildId = ngui.find_label(self.ui, path.."txt7/lab_num")

	self.btnExit = ngui.find_button(self.ui, path.."btn1")
	self.btnMail = ngui.find_button(self.ui, path.."btn2")
	self.btnModifyGuildName = ngui.find_button(self.ui, path.."btn3")
	self.btnModifyGuildIcon = ngui.find_button(self.ui, path.."btn_huan_tu")
	self.labExit = ngui.find_label(self.ui, path.."btn1/animation/lab")
	
	self.btnExit:set_on_click(self.bindfunc["on_btn_quit_guild"])
	self.btnMail:set_on_click(self.bindfunc["on_btn_mail"])
	self.btnModifyGuildName:set_on_click(self.bindfunc["on_btn_modify_guild_name"])
	self.btnModifyGuildIcon:set_on_click(self.bindfunc["on_btn_modify_guild_icon"])


	path = "centre_other/animation/scro_view/"
	------------------------------ 列表 -----------------------------
	self.svList = ngui.find_scroll_view(self.ui, path.."panel")
	self.wcList = ngui.find_wrap_content(self.ui, path.."panel/wrap_content")
	self.wcList:set_on_initialize_item(self.bindfunc["on_init_item"])
	self.wcList:reset();

	-- 拉取社团数据
	if not self.dataCenter:IsPulledDetail() then
		self.loadingId = GLoading.Show(GLoading.EType.ui)
		msg_guild.cg_request_my_guild_data()
	end

	self:UpdateList()
	self:UpdateUi()
end

function GuildInfoUI:DestroyUi()
	if self.items then
		for i, v in pairs(self.items) do
			v.uiPlayer:DestroyUi()
		end
		self.items = nil
	end
	self.memberList = nil

	UiBaseClass.DestroyUi(self);
end

function GuildInfoUI:UpdateList()
	if not self.ui then return end
	-- 
	self.memberList = self.dataCenter:GetSortMemberData()
	
	if self.itemCnt == #self.memberList then
		for b, item in pairs(self.items) do
			self:LoadItem(item, item.index)
		end
	else
		self.itemCnt = #self.memberList
		self.wcList:set_min_index(1-#self.memberList)
		self.wcList:set_max_index(0)
		self.wcList:reset(0)
		self.svList:reset_position()
	end
end

--刷新界面
function GuildInfoUI:UpdateUi()
	if not self.ui then return end

	local data = self.dataCenter.detail
	if data then
		local config = ConfigManager.Get(EConfigIndex.t_guild_icon,data.icon)
		if config then
			self.textureIcon:set_texture(config.icon)
		end

		self.labGuildName:set_text(data.name)
		if data.rank < 1 then
			self.labRank:set_text(_local.UIText[11])
		else
			self.labRank:set_text(tostring(data.rank))
		end
		self.labGuildId:set_text(tostring(Guild.GetVisibleId(data.searchid)))
		self.labGuildLevel:set_text(tostring(data.level))
		
		self.labLeaderCnt:set_text( string.format( "%s/%s", 
				Guild.GetMemberJobCnt(data, ENUM.EGuildJob.President),
				Guild.GetMemberJobLimit(data, ENUM.EGuildJob.President) ) )
		self.labViceCnt:set_text( string.format( "%s/%s", 
				Guild.GetMemberJobCnt(data, ENUM.EGuildJob.VicePresident),
				Guild.GetMemberJobLimit(data, ENUM.EGuildJob.VicePresident) ) )
		self.labEliteCnt:set_text( string.format( "%s/%s", 
				Guild.GetMemberJobCnt(data, ENUM.EGuildJob.Minister),
				Guild.GetMemberJobLimit(data, ENUM.EGuildJob.Minister) ) )
		self.labMemberCnt:set_text( string.format( "%s/%s",
				Guild.GetMemberNumber(data),
				Guild.GetMemberLimit(data) ) )

		-- local config = ConfigManager.Get(EConfigIndex.t_country_info, data.countryid) or {}
		-- self.labAreaName:set_text( config.name or "" )

		self.btnModifyGuildName:set_active(false)
		self.btnModifyGuildIcon:set_active(false)
		self.btnMail:set_active(false)
		self.spGuildNameBg:set_active(false)

		local mydata = self.dataCenter:GetMyMemberData()
		if mydata then
			if mydata.job == ENUM.EGuildJob.President then
				self.labExit:set_text(_local.UIText[9])
				self.btnModifyGuildName:set_active(true)
				self.btnModifyGuildIcon:set_active(true)
				self.btnMail:set_active(true)
				self.spGuildNameBg:set_active(true)
			else
				self.labExit:set_text(_local.UIText[10])
			end
		end
	else
		-- 初始化默认显示
		self.labLeaderCnt:set_text("-/-")
		self.labViceCnt:set_text("-/-")
		self.labEliteCnt:set_text("-/-")
		self.labMemberCnt:set_text("-/-")
		-- self.labAreaName:set_text( "" )
		self.labGuildName:set_text( "" )
		self.labGuildId:set_text( "" )
		self.labExit:set_text(_local.UIText[10])
	end
end

-- --获取社团活动开启状态
-- function GuildInfoUI:GetActivityState(config)
-- 	local open = false	-- 是否达到开启等级
-- 	local times = 0		-- 今日可参与次数 -1表示无限制
-- 	local openTime = 0		-- 活动开启时间点

-- 	local level = self.dataCenter.detail and self.dataCenter.detail.level or 0
-- 	if config.openLevel <= level then
-- 		open = true
-- 		-- 活动可参与次数
-- 		local info = g_dataCenter.activity[config.play_id];
-- 		local activityConfig = ConfigManager.Get(EConfigIndex.t_activity_time,config.play_id)
-- 		-- 没有限制次数
-- 		if activityConfig and activityConfig.number_restriction == 0 then
-- 			times = -1
-- 		-- TODO: 每个玩法需要提供一个获取今日剩余次数的方法如：GetTimes()
-- 		elseif info and info.GetTimes then
-- 			times = info:GetTimes()
-- 		end
-- 	end

-- 	return open, times, openTime
-- end

function GuildInfoUI:LoadItem(item, index)
	item.index = index
	local data = self.memberList[index]
	if data then
		item.btnMemberItem:set_event_value(data.playerid, 0)
		item.labMemberName:set_text(data.name)
		item.labMemberLevel:set_text(_local.UIText[2]..PublicFunc.GetColorText(tostring(data.level), "orange_light"))
		item.labMemberJob:set_text(Guild.GetJobName(data.job))
		item.labTotalPoints:set_text(tostring(data.totalPoints))
		item.labTotayPoints:set_text(tostring(data.todayPoints))
		if data.playerid == g_dataCenter.player.playerid then
			item.spMyTag:set_active(true)
		else
			item.spMyTag:set_active(false)
		end

		item.uiPlayer:SetRoleId(data.imageId)
		item.uiPlayer:SetVipLevel(data.vipLevel)

		--在线状态
		if data.online then
			item.labMemberLogin:set_text(PublicFunc.GetColorText(_local.UIText[1], "green"))
		else
			local secs = 0
			if data.lastOffLineTime > 0 then
				secs = math.max(0, system.time() - data.lastOffLineTime)
			end
			local str = TimeAnalysis.analysisSec_fuzzy(secs, true)
			item.labMemberLogin:set_text(str)
		end
	end
end

-------------------------------------本地回调-------------------------------------
function GuildInfoUI:on_btn_mail(t)
	uiManager:PushUi(EUI.GuildSetMailUI)
end

--解散/退出 社团
function GuildInfoUI:on_btn_quit_guild(t)
	local mydata = self.dataCenter:GetMyMemberData()
	if mydata.job == ENUM.EGuildJob.President then
		--社团仅有1个成员才能提交解散
		if Guild.GetMemberNumber(self.dataCenter.detail) > 1 then
			FloatTip.Float(_local.UIText[8])
			return
		end

		HintUI.SetAndShow(EHintUiType.two, _local.UIText[5], 
			{str = _local.UIText[3], func = _local.send_msg_dissolve},
			{str = _local.UIText[4]});
	else
		HintUI.SetAndShow(EHintUiType.two, _local.UIText[6], 
			{str = _local.UIText[3], func = _local.send_msg_quit},
			{str = _local.UIText[4]});
	end
end

--修改社团名字
function GuildInfoUI:on_btn_modify_guild_name(t)
	uiManager:PushUi(EUI.GuildSetNameUI, data)
end

--修改徽章
function GuildInfoUI:on_btn_modify_guild_icon(t)
	local data = {}
	data.iconIndex = self.dataCenter.detail.icon
	data.callback = self.bindfunc["on_select_icon"]
	uiManager:PushUi(EUI.GuildSetIconUI, data)
end

--请求修改icon
function GuildInfoUI:on_select_icon(index)
	local detail = self.dataCenter.detail
	msg_guild.cg_update_guild_config(detail.applyLevel, detail.approvalRule, detail.declaration, index)
end

--社团成员列表项
function GuildInfoUI:on_init_item(obj, b, real_id)
	local index = math.abs(real_id) + 1;

	local item = self.items[b]
    if not item then
		item = {}
		item.self = obj 
		item.btnMemberItem = ngui.find_button(obj, obj:get_name())
		item.labMemberName = ngui.find_label(obj, "lab_name")
		item.labMemberLevel = ngui.find_label(obj, "lab_level")
		item.labMemberJob = ngui.find_label(obj, obj:get_name().."/lab_num")
		item.labMemberLogin = ngui.find_label(obj, "lab_time")
		item.labTotalPoints = ngui.find_label(obj, "lab_freedom1")
		item.labTotayPoints = ngui.find_label(obj, "lab_freedom2")
		item.spMyTag = ngui.find_sprite(obj, "sp_my_tg")

		item.btnMemberItem:set_on_click(self.bindfunc["on_btn_member"])
		local playerObj = obj:get_child_by_name("sp_head_di_item")
		item.uiPlayer = UiPlayerHead:new({parent=playerObj})

		self.items[b] = item
	end
	
	self:LoadItem(item, index)
end


--社员信息
function GuildInfoUI:on_btn_member(t)
	local data = self.dataCenter:GetMemberDataByPlayerId(t.string_value)
	uiManager:PushUi(EUI.GuildMemberInfoUI, data)
end

-------------------------------------网络回调-------------------------------------
--基础信息
function GuildInfoUI:on_sync_my_guild_data()
	GLoading.Hide(GLoading.EType.ui, self.loadingId)
	self:UpdateUi()
end

--社团权限变更（0,踢人，1继承，2职位变更，3解散）
function GuildInfoUI:on_guild_operation(ntype, playerid, param)
	if ntype < 3 then
		self:UpdateList()
	end
end

-- --社团权限变更（0,踢人，1继承，2职位变更，3解散）
-- function GuildInfoUI:on_guild_operation(ntype, playerid, param)
-- 	if ntype == 3 then
-- 		self.quiting = false

-- 		-- 退出当前界面到主界面
-- 		uiManager:ClearStack()
-- 		uiManager:PopUi()
-- 	end
-- end

-- --退出社团
-- function GuildInfoUI:on_quit_guild()
-- 	self.quiting = false

-- 	-- 退出当前界面到主界面
-- 	uiManager:ClearStack()
-- 	uiManager:PopUi()
-- end
