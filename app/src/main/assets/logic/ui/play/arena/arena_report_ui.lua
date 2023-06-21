--	ArenaReportUI 竞技场战报界面
--	author: zzc
--	create: 2016-2-24

ArenaReportUI = Class('ArenaReportUI', UiBaseClass);

local _local = {}
_local.UIText = {
	[1] = "功能未开放",
}


function ArenaReportUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/arena/ui_4404_jjc_fight_report.assetbundle";
	UiBaseClass.Init(self, data);
end

function ArenaReportUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function ArenaReportUI:Restart(data)
	if data == "push" then
		self.reportList = nil
	end
	UiBaseClass.Restart(self, data);
end

function ArenaReportUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, ArenaReportUI.on_btn_close);
	self.bindfunc["on_player_view"] = Utility.bind_callback(self, ArenaReportUI.on_player_view);
	self.bindfunc["on_player_head"] = Utility.bind_callback(self, ArenaReportUI.on_player_head);
	self.bindfunc["on_init_item"] = Utility.bind_callback(self, ArenaReportUI.on_init_item);
	self.bindfunc["on_share"] = Utility.bind_callback(self, ArenaReportUI.on_share);
	self.bindfunc["on_replay"] = Utility.bind_callback(self, ArenaReportUI.on_replay);
	self.bindfunc["on_gc_arena_request_fight_report"] = Utility.bind_callback(self, ArenaReportUI.on_gc_arena_request_fight_report);
	self.bindfunc["gc_arena_add_fight_report"] = Utility.bind_callback(self, ArenaReportUI.gc_arena_add_fight_report);
end

--注册消息分发回调函数
function ArenaReportUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_activity.gc_arena_request_fight_report, self.bindfunc["on_gc_arena_request_fight_report"])
	PublicFunc.msg_regist(msg_activity.gc_arena_add_fight_report, self.bindfunc["gc_arena_add_fight_report"])
end

--注销消息分发回调函数
function ArenaReportUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_activity.gc_arena_request_fight_report, self.bindfunc["on_gc_arena_request_fight_report"])
	PublicFunc.msg_unregist(msg_activity.gc_arena_add_fight_report, self.bindfunc["gc_arena_add_fight_report"])
end

function ArenaReportUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_arena_report");

	self.items = {}

	local btnClose = ngui.find_button(self.ui, "btn_cha")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])

	local path = "center_other/animation/scroll_view/panel_list"
	self.enhanceSV = ngui.find_enchance_scroll_view(self.ui, path)
	self.enhanceSV:set_on_initialize_item(self.bindfunc['on_init_item']);

	-- 请求战报数据
	if self.reportList == nil then
		msg_activity.cg_arena_request_fight_report()
	end

	self:UpdateList()
end

function ArenaReportUI:DestroyUi()
	if self.items then
		self.items = nil;
	end
	if self.reportList then
		self.reportList = nil
	end
	UiBaseClass.DestroyUi(self);
end

function ArenaReportUI:SetReportList(reportList)
	self.reportList = {}
	if not reportList == nil then
		for i, v in ipairs(reportList) do
			table.insert(self.reportList, ArenaFightReport:new(v));
		end
	end
	self:SortReportData()
end

function ArenaReportUI:AddReportData(reportData)
	if self.reportList then
		table.insert(self.reportList, ArenaFightReport:new(reportData));
	end
	self:SortReportData()
end

function ArenaReportUI:SortReportData()
	if self.reportList then
		table.sort(self.reportList, function(A, B)
			if A == nil or B == nil then return false end
			return A.fightTime > B.fightTime;
		end)
	end
end

--刷新记录列表
function ArenaReportUI:UpdateList()
	if not self.ui then return end

	local count = #(self.reportList or table.empty())
	self.enhanceSV:set_maxNum(count);
	self.enhanceSV:refresh_list()
end

----------------------- 本地回调 ---------------------------
function ArenaReportUI:on_btn_close(t)
	uiManager:PopUi()
end

function ArenaReportUI:on_player_view(name, x, y, go_obj, str_value)
	OtherPlayerPanel.ShowPlayer(str_value, ENUM.ETeamType.arena, true)
end

function ArenaReportUI:on_player_head(value)
	OtherPlayerPanel.ShowPlayer(value, ENUM.ETeamType.arena)
end

function ArenaReportUI:on_share()
	-- TODO
	HintUI.SetAndShow(EHintUiType.zero, _local.UIText[1])
end

function ArenaReportUI:on_replay()
	-- TODO
	HintUI.SetAndShow(EHintUiType.zero, _local.UIText[1])
end

--初始列表项
function ArenaReportUI:on_init_item(obj, index)
	local item = self.items[obj:get_instance_id()]
	if not item then
		item = {}
		item.spBg = ngui.find_sprite(obj, "sp_di")
		item.spWin = ngui.find_sprite(obj, "sp_win")
		item.labTime = ngui.find_label(obj, "lab_time")
		item.labName = ngui.find_label(obj, "sp_lingxing/lab_name")
		item.labLevel = ngui.find_label(obj, "sp_lingxing/lab_level")
		item.labFight = ngui.find_label(obj, "sp_fight/lab_fight")
		item.btnShare = ngui.find_button(obj, "btn1")
		item.btnReplay = ngui.find_button(obj, "btn2")

		--屏蔽掉分享，回放按钮
		item.btnShare:set_active(false)
		item.btnReplay:set_active(false)
		
		local objHead = obj:get_child_by_name("sp_head_di_item")
		item.uiPlayerHead = UiPlayerHead:new({parent=objHead})

		item.nodeUpRank = obj:get_child_by_name("cont1")
		item.nodeDownRank = obj:get_child_by_name("cont2")
		item.labUpRank = ngui.find_label(item.nodeUpRank, "lab_top_ranging")
		item.labDownRank = ngui.find_label(item.nodeDownRank, "lab_top_ranging")

		self.items[obj:get_instance_id()] = item
	end

	local data = self.reportList and self.reportList[index] or nil
	if data then
		item.spBg:set_event_value(data.playerid);
		item.spBg:set_on_ngui_click(self.bindfunc["on_player_view"])

		--TODO  暂时隐藏分享、回放按钮
		-- local temp = true
		-- if temp then
		-- 	item.btnShare:set_enable(false)
		-- 	item.btnReplay:set_enable(false)
		-- end
		item.btnShare:reset_on_click()
		item.btnShare:set_event_value(data.fightReplay, 0);
		item.btnShare:set_on_click(self.bindfunc["on_share"])
		item.btnReplay:reset_on_click()
		item.btnReplay:set_event_value(data.fightReplay, 0);
		item.btnReplay:set_on_click(self.bindfunc["on_replay"])
		item.uiPlayerHead:SetRoleId(data.leaderId)
		item.uiPlayerHead:SetCallback(self.bindfunc["on_player_head"], data.playerid)

		if data.rankChange > 0 then
			item.nodeUpRank:set_active(true)
			item.nodeDownRank:set_active(false)
			item.labUpRank:set_text(""..math.abs(data.rankChange))
		elseif data.rankChange < 0 then
			item.nodeUpRank:set_active(false)
			item.nodeDownRank:set_active(true)
			item.labDownRank:set_text(""..math.abs(data.rankChange))
		else
			item.nodeUpRank:set_active(false)
			item.nodeDownRank:set_active(false)
		end

		if data.isWin then
			item.spWin:set_sprite_name("zb_win")
		else
			item.spWin:set_sprite_name("zb_lose")
		end

		item.labLevel:set_text(tostring(data.level))
		item.labName:set_text(data.name)
		item.labTime:set_text(TimeAnalysis.analysisSec_3(system.time() - data.fightTime, true))
		item.labFight:set_text(""..data.fightPoint)
	end
end

----------------------- 网络回调 ---------------------------
function ArenaReportUI:on_gc_arena_request_fight_report(reportList)
	self:SetReportList(reportList)
	self:UpdateList()
end

function ArenaReportUI:gc_arena_add_fight_report(reportData)
	self:AddReportData(reportData)
	self:UpdateList()
end