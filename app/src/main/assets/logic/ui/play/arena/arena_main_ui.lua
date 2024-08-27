-- ArenaMainUI 竞技场界面
-- author: zzc
-- create: 2016-6-6

ArenaMainUI = Class('ArenaMainUI', UiBaseClass);

local _UIText = {
	[1] = "",
	[2] = "排名",
	[3] = "玩家",
	[4] = "英雄",
	[5] = "兑换",
	[6] = "挑战次数[00F6FF]%s[-]/%s", --"挑战次数: [FF9800FF]%s/%s[-]",
	[7] = "购买次数",
	[8] = "换对手",
	[9] = "战斗记录",
	[10] = "挑战",
	[11] = "钻石不足",
	[12] = "倒计时 ",
	[13] = "战力 ",
	[14] = "布阵",
	[15] = "购买成功",
	[16] = "今日挑战次数已达到上限！",
	[17] = "今日购买次数已达到上限！",
	[18] = "之后可再次挑战",
	[19] = "是否花费[00F6FF]%s[-]钻石，重置挑战冷却时间？",
	[20] = "挑战冷却中",
}

local _EPlaneBg2Name = {
	[1] = "jjc_kuang1_2",
	[2] = "jjc_kuang2_2",
	[3] = "jjc_kuang3_2",
	[4] = "jjc_kuang4_2",
}

local _TimerSecs = 0
local _TimerRefreshCdFunc = function(self)
	if _TimerSecs == 0 then return end
	_TimerSecs = _TimerSecs - 1
	if self and self.labRefresh and self.dataCenter then
		if _TimerSecs > 0 then
			self.labRefresh:set_text(tostring(_TimerSecs))
		else
			self.labRefresh:set_text(_UIText[8])
		end
	end
end

function ArenaMainUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/arena/ui_4401_jjc.assetbundle";
	UiBaseClass.Init(self, data);
end

function ArenaMainUI:InitData(data)
	self.pnIndex = 0;
	UiBaseClass.InitData(self, data);
end

function ArenaMainUI:OnLoadUI()
	UiBaseClass.PreLoadUIRes(Show3dJJC, Root.empty_func)
end

function ArenaMainUI:Show()
	if UiBaseClass.Show(self) then
		if self.updateTeamData then
			self.updateTeamData = nil
			msg_activity.cg_arena_request_player_list(1);
		end
	end
end

function ArenaMainUI:Restart(data)
	self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
	if data == "push" then
		self.updateTeamData = nil
		self.topPlayerList = nil
		self.curPlayerList = nil
		self.playerList = nil
	end
	UiBaseClass.Restart(self, data);
end

function ArenaMainUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_rank"] = Utility.bind_callback(self, self.on_btn_rank);
	self.bindfunc["on_btn_shop"] = Utility.bind_callback(self, self.on_btn_shop);
	self.bindfunc["on_btn_award"] = Utility.bind_callback(self, self.on_btn_award);
	self.bindfunc["on_btn_point"] = Utility.bind_callback(self, self.on_btn_point);
	self.bindfunc["on_btn_report"] = Utility.bind_callback(self, self.on_btn_report);
	self.bindfunc["on_btn_arrange"] = Utility.bind_callback(self, self.on_btn_arrange);
	self.bindfunc["on_btn_refresh"] = Utility.bind_callback(self, self.on_btn_refresh);
	self.bindfunc["on_btn_reset_cd"] = Utility.bind_callback(self, self.on_btn_reset_cd);
	self.bindfunc["on_btn_buy_times"] = Utility.bind_callback(self, self.on_btn_buy_times);
	self.bindfunc["on_player_view"] = Utility.bind_callback(self, self.on_player_view);
	self.bindfunc["on_fight_player"] = Utility.bind_callback(self, self.on_fight_player);
	self.bindfunc["UpdateCdTimer"] = Utility.bind_callback(self, self.UpdateCdTimer);
	self.bindfunc["on_arena_rank_list"] = Utility.bind_callback(self, self.on_arena_rank_list);

	self.bindfunc["on_update_team"] = Utility.bind_callback(self, self.on_update_team);
	self.bindfunc["on_vip_change"] = Utility.bind_callback(self, self.on_vip_change);
	self.bindfunc["on_item_data_change"] = Utility.bind_callback(self, self.on_item_data_change);
	self.bindfunc["on_gc_arena_sync_myself_info"] = Utility.bind_callback(self, self.on_gc_arena_sync_myself_info);
	self.bindfunc["on_gc_arena_sync_player_list"] = Utility.bind_callback(self, self.on_gc_arena_sync_player_list);
	self.bindfunc["on_gc_arena_buy_challenge_times"] = Utility.bind_callback(self, self.on_gc_arena_buy_challenge_times);
	self.bindfunc["on_gc_arena_refresh_challenge_list"] = Utility.bind_callback(self, self.on_gc_arena_refresh_challenge_list);
	self.bindfunc["on_btn_share"] = Utility.bind_callback(self,self.on_btn_share);
end

function ArenaMainUI:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self)
end

-- 注册消息分发回调函数
function ArenaMainUI:MsgRegist()
	NoticeManager.BeginListen(ENUM.NoticeType.ChangeTeamSuccess, self.bindfunc["on_update_team"])
	NoticeManager.BeginListen(ENUM.NoticeType.VipDataChange, self.bindfunc["on_vip_change"])
	NoticeManager.BeginListen(ENUM.NoticeType.CardItemChange, self.bindfunc["on_item_data_change"]);

	PublicFunc.msg_regist(msg_activity.gc_arena_sync_myself_info, self.bindfunc["on_gc_arena_sync_myself_info"])
	PublicFunc.msg_regist(msg_activity.gc_arena_sync_player_list, self.bindfunc["on_gc_arena_sync_player_list"])
	PublicFunc.msg_regist(msg_activity.gc_arena_top_50, self.bindfunc["on_arena_rank_list"])
	PublicFunc.msg_regist(msg_activity.gc_arena_buy_challenge_times, self.bindfunc["on_gc_arena_buy_challenge_times"])
	PublicFunc.msg_regist(msg_activity.gc_arena_refresh_challenge_list, self.bindfunc["on_gc_arena_refresh_challenge_list"])
end

-- 注销消息分发回调函数
function ArenaMainUI:MsgUnRegist()
	NoticeManager.EndListen(ENUM.NoticeType.ChangeTeamSuccess, self.bindfunc["on_update_team"])
	NoticeManager.EndListen(ENUM.NoticeType.VipDataChange, self.bindfunc["on_vip_change"])
	NoticeManager.EndListen(ENUM.NoticeType.CardItemChange, self.bindfunc["on_item_data_change"]);

	PublicFunc.msg_unregist(msg_activity.gc_arena_sync_myself_info, self.bindfunc["on_gc_arena_sync_myself_info"])
	PublicFunc.msg_unregist(msg_activity.gc_arena_sync_player_list, self.bindfunc["on_gc_arena_sync_player_list"])
	PublicFunc.msg_unregist(msg_activity.gc_arena_top_50, self.bindfunc["on_arena_rank_list"]);
	PublicFunc.msg_unregist(msg_activity.gc_arena_buy_challenge_times, self.bindfunc["on_gc_arena_buy_challenge_times"])
	PublicFunc.msg_unregist(msg_activity.gc_arena_refresh_challenge_list, self.bindfunc["on_gc_arena_refresh_challenge_list"])
end

function ArenaMainUI:InitUI(asset_obj)
	camera.set_bloomfactor(1.5);
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_arena_main");

	self.itemPlayer = {}
	self.pnIndex = 0;

	local path = "right_top_other/animation/"
	------------------------------ 顶部 -----------------------------
	local btnRank = ngui.find_button(self.ui, path .. "btn_ranklist")
	local btnShop = ngui.find_button(self.ui, path .. "btn_shop")
	local btnReport = ngui.find_button(self.ui, path .. "btn_zhanbao")
	local btnAward = ngui.find_button(self.ui, path .. "btn_award")
	local btnPoint = ngui.find_button(self.ui, path .. "btn_jifen")

	btnRank:set_on_click(self.bindfunc["on_btn_rank"])
	btnShop:set_on_click(self.bindfunc["on_btn_shop"])
	btnAward:set_on_click(self.bindfunc["on_btn_award"])
	btnPoint:set_on_click(self.bindfunc["on_btn_point"])
	btnReport:set_on_click(self.bindfunc["on_btn_report"])


	path = "centre_other/animation/scroll_view/"
	------------------------------ 中部 -----------------------------
	self.scrollView = ngui.find_scroll_view(self.ui, path .. "panel_list")
	self.grid = ngui.find_grid(self.ui, path .. "panel_list/grid")
	self.baseItem = self.ui:get_child_by_name(path .. "panel_list/grid/cont1")
	self.baseItem:set_active(false)
	
	self.itemWidth = self.grid:get_cell_width()
	local w,h,cw,ch = ngui.find_panel(self.ui, path .. "panel_list"):get_size()
	self.pnListWidth = cw
	local x,y,z = self.scrollView:get_position()
	self.pnListInitX = x

	path = "left_other/animation/cont/"
	------------------------------ 左部 -----------------------------
	self.labFightPoint = ngui.find_label(self.ui, path .. "sp_fight/lab_fight")
	self.labMyRank = ngui.find_label(self.ui, path .. "lab_rank")


	path = "down_other/animation/"
	------------------------------ 底部 -----------------------------
	self.labRefresh = ngui.find_label(self.ui, path .. "btn2/animation/lab")
	self.labFightTimes = ngui.find_label(self.ui, path .. "sp_title/lab")
	-- self.labCostNumber = ngui.find_label(self.ui, path .. "sp_bk/lab")
	-- self.nodeCost = self.ui:get_child_by_name(path .. "sp_bk")
	self.btnArrange = ngui.find_button(self.ui, path .. "btn1")
	self.btnRefresh = ngui.find_button(self.ui, path .. "btn2")
	self.btnResetCD = ngui.find_button(self.ui, path .. "btn3")
	self.labFightCD = ngui.find_label(self.ui, path .. "lab_time")
	self.labResetCdNum = ngui.find_label(self.btnResetCD:get_game_object(), "lab_num")
	self.btnArrange:set_on_click(self.bindfunc["on_btn_arrange"])
	self.btnRefresh:set_on_click(self.bindfunc["on_btn_refresh"])
	self.btnResetCD:set_on_click(self.bindfunc["on_btn_reset_cd"])

	local btnBuyTimes = ngui.find_button(self.ui, path .. "sp_title/btn_add")
	btnBuyTimes:set_on_click(self.bindfunc["on_btn_buy_times"])

	--chenjia add 分享按钮
	local btnShare = ngui.find_button(self.ui,"animation/btn_flaunt")
	btnShare:set_on_click(self.bindfunc["on_btn_share"])

	-- 请求竞技场数据
	if self.playerList == nil then
		msg_activity.cg_arena_request_myslef_info();
		msg_activity.cg_arena_request_player_list(0);
		msg_activity.cg_arena_request_player_list(1);
	end

	self:UpdateUi()
	self:UpdateList()
	self:UpdatePlayer3D()

	if _TimerSecs > 0 then
		self:StartRefreshTimer(_TimerSecs)
	end
end

function ArenaMainUI:ClearItemPlayer(is_remove)
	if self.itemPlayer then
		for k, v in pairs(self.itemPlayer) do
			if v.textureRole then
				v.textureRole:Destroy()
			end
			if is_remove then
				v.self:set_active(false)
				v.self:set_parent(nil)
			end
		end
		self.itemPlayer = nil
	end
end


function ArenaMainUI:DestroyUi()
	self.dataCenter = nil
	self.arenaTeam = nil

	self:StopFightCdTimer()

	if self.clsBuyTimes then
		self.clsBuyTimes:DestroyUi()
		self.clsBuyTimes = nil
	end
	if self.clsPlayerView then
		self.clsPlayerView:DestroyUi()
		self.clsPlayerView = nil
	end
	self:ClearItemPlayer()
	Show3dJJC.Destroy()

	self.topPlayerList = nil
	self.curPlayerList = nil
	self.playerList = nil
	self.canFightPlayer = nil
	self.fightPlayerid = nil
	self.updateTeamData = nil
	self.myPos = nil

	UiBaseClass.DestroyUi(self);
end

function ArenaMainUI:SetPlayerList(ntype, playerList)
	if ntype == 0 then
		self.topPlayerList = { }
		for i, v in ipairs(playerList) do
			table.insert(self.topPlayerList, ArenaPlayer:new(v));
		end
	elseif ntype == 1 then
		self.curPlayerList = { }
		self.canFightPlayer = { }
		for i, v in ipairs(playerList) do
			local arenaPlayer = ArenaPlayer:new(v)
			table.insert(self.curPlayerList, arenaPlayer);
			self.canFightPlayer[arenaPlayer.playerid] = arenaPlayer;
		end
	end

	-- 合并列表
	local tempList = { }
	if self.topPlayerList then
		for i, v in ipairs(self.topPlayerList) do
			tempList[v.playerid] = v
		end
	end
	if self.curPlayerList then
		for i, v in ipairs(self.curPlayerList) do
			tempList[v.playerid] = v
		end
	end

	-- 列表排序
	self.playerList = { }
	for k, v in pairs(tempList) do
		table.insert(self.playerList, v)
	end

	table.sort(self.playerList, function(A, B)
		if A == nil or B == nil then return false end
		return A.rank < B.rank;
	end )
end

function ArenaMainUI:UpdatePlayer(data)
	if data == nil or self.playerList == nil then return end
	
	local index = nil
	for i, v in ipairs(self.playerList) do
		if v.playerid == data.playerGid then
			v:UpdateData(data)
			index = i
			break;
		end			
	end

	if index then
		for b, itemPlayer in pairs(self.itemPlayer) do
			if itemPlayer.index == index then
				self:LoadItem(itemPlayer, itemPlayer.index)
			end
		end

		return self.playerList[ index ];
	end
end

function ArenaMainUI:UpdatePlayer3D()
	local data =
	{
		roleData = PublicFunc.CreateCardInfo(g_dataCenter.player:GetImage()),
	}
	Show3dJJC.SetAndShow(data)
end

function ArenaMainUI:UpdateUi()
	if self.ui == nil then return end

	if self.arenaTeam == nil then
		local team = self.dataCenter:UpdateTeam()
		self.arenaTeam = {}
		for i, v in pairs(team) do
			if tonumber(v) ~= 0 then
				table.insert(self.arenaTeam, v)
			end
		end
	end	
	-- 队伍战斗力计算
	local fightPoint = 0
	local cardInfo = nil
	for i, v in pairs(self.arenaTeam) do
		cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, v)
		if cardInfo == nil then
			fightPoint = 9999999
		else
		fightPoint = fightPoint + cardInfo:GetFightValue(--[[ENUM.ETeamType.arena]])
	end
	end
	self.labFightPoint:set_text("" .. fightPoint)

	-- 我的排名
	--[[
	local showRank = self.dataCenter.rank
	-- 特殊规则说明：20000以后都显示假排名
	if showRank > 20000 or showRank == nil then
		showRank = self.dataCenter.maskRank
	end
	]]
	
	local showRank = 1
	self.dataCenter.rank = 1

	self.labMyRank:set_text("" .. showRank)

	-- 剩余挑战次数
	local leftCnt = self.dataCenter:GetTimes()
	local vipBuyTimes, vipFreeTimes = self.dataCenter:GetVipTimes()
	self.labFightTimes:set_text(string.format(_UIText[6], leftCnt, vipFreeTimes))
	-- 奖牌数量
	local medalNum = g_dataCenter.package:find_count(ENUM.EPackageType.Item, IdConfig.Medal)

	-- 刷新对手按钮状态
	if _TimerSecs > 0 then
		self.labRefresh:set_text(tostring(_TimerSecs))
	else
		self.labRefresh:set_text(_UIText[8])
	end

	self:CheckFightCD()
end

-- 刷新活动列表
function ArenaMainUI:UpdateList()
	if self.ui == nil then return end

	local count = #(self.playerList or { })
	-- 保证排行列表数据完整
	if self.topPlayerList and self.curPlayerList then
		local myPos = 1
		local offset = 0
		local count = #self.playerList
		if #self.curPlayerList > 0 then
			local myplayerid = g_dataCenter.player.playerid
			for i, v in ipairs(self.playerList) do
				if v.playerid == myplayerid then
					myPos = i
				elseif offset == 0 and self.canFightPlayer[v.playerid] then
					offset = i
				end
			end
		end
		
		
		-- 位置没改变，仅刷新数据
		if myPos == self.myPos then
			for b, itemPlayer in pairs(self.itemPlayer) do
				self:LoadItem(itemPlayer, itemPlayer.index)
			end
		else
			self.totalCount = count

			self:ClearItemPlayer(true)
			self.itemPlayer = {}

			local itemPlayer = nil
			for i=1, count do
				self.itemPlayer[i] = self:CreateItemPlayer(self.baseItem:clone(), i)
				self:LoadItem(self.itemPlayer[i], i)
			end

			self.grid:reposition_now()

			-- 新手引导保证显示出最后一个挑战对手
			if GuideManager and GuideManager.IsGuideRuning() then
				if offset > 0 then
					local offset_px = self.pnListInitX + (self.totalCount - 2) * self.itemWidth - self.pnListWidth
					self.scrollView:move_relative(0-offset_px, 0, 0)
				end
			else
				if offset > 0 then
					self.scrollView:move_relative((1-offset)*self.itemWidth, 0, 0)
				end
			end

		end

		self.myPos = myPos
	end
end

function ArenaMainUI:BuyChallengeTimes(enterFight)
	local cost = self.dataCenter:GetChallengeCost()
	local curTimes = self.dataCenter.buyTimes
	local maxTimes = self.dataCenter:GetVipTimes()
	if curTimes < maxTimes then
		local cbFunc = function(enterFightParam, data)
			msg_activity.cg_arena_buy_challenge_times(enterFightParam, data.totalCount)
		end
		if not self.clsBuyTimes then
			self.clsBuyTimes = BuyFightTimesUi:new()
		end
		self.clsBuyTimes:SetData({costCount=cost, useCount=curTimes, maxCount=maxTimes-curTimes})
		self.clsBuyTimes:SetCallback(cbFunc, enterFight)
		-- CommonBuy.Show(curTimes, maxTimes, cost, 1, gs_misc['str_42'], gs_misc['str_43'], cbFunc)
	else
		if enterFight == 0 then
			FloatTip.Float(_UIText[17])
		elseif enterFight == 1 then
			FloatTip.Float(_UIText[16])
		end
	end
end

----------------------- 本地回调 ---------------------------
function ArenaMainUI:on_btn_rank(t)
	self.loadingId = GLoading.Show(GLoading.EType.ui);
	msg_activity.cg_arena_request_player_list(2);
end

function ArenaMainUI:on_arena_rank_list(rankData)
	GLoading.Hide(GLoading.EType.ui, self.loadingId);
	local data = {
		startRank = RANK_TYPE.ARENA;
		rankDatas = rankData;
	}
	--uiManager:PushUi(EUI.RankUI,data);
	RankPopPanel.popPanel(rankData,RANK_TYPE.ARENA)
end

function ArenaMainUI:on_btn_shop(t)
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.ARENA)
end

function ArenaMainUI:on_btn_award(t)
	uiManager:PushUi(EUI.ArenaTopRankAwardUI)
end

function ArenaMainUI:on_btn_point(t)
	uiManager:PushUi(EUI.ArenaPointAwardUI)
end

function ArenaMainUI:on_btn_report(t)
	uiManager:PushUi(EUI.ArenaReportUI)
end

function ArenaMainUI:on_btn_arrange()
	local data = {
		teamType = ENUM.ETeamType.arena,
		heroMaxNum = 3,
	}
	uiManager:PushUi(EUI.CommonFormationUI, data)	
end

function ArenaMainUI:on_btn_share()
	uiManager:PushUi(EUI.ShareUIActivity,4);
end

function ArenaMainUI:on_btn_refresh()
	-- 刷新对手
	if _TimerSecs == 0 then
		msg_activity.cg_arena_refresh_challenge_list()
	end
end

function ArenaMainUI:on_btn_reset_cd()
	local haveCost = PropsEnum.GetValue(IdConfig.Crystal)
	local needCost = self.dataCenter:GetCleanCdCost()
	if haveCost >= needCost then
		HintUI.SetAndShow(EHintUiType.two, string.format(_UIText[19], needCost),
			{str = "确定", func = msg_activity.cg_arena_clean_cd}, {str = "取消", func = nil} )
	else
		FloatTip.Float(_UIText[11])
	end
end

function ArenaMainUI:on_btn_buy_times()
	self:BuyChallengeTimes(0)
end

function ArenaMainUI:on_player_view(name, x, y, go_obj, playerid)
	-- 查看其它玩家信息
	OtherPlayerPanel.ShowPlayer(playerid, ENUM.ETeamType.arena, true)
end

function ArenaMainUI:on_fight_player(t)
	local playerid = t.string_value

	-- 查看自己
	if playerid == g_dataCenter.player.playerid then
		local data = {
			teamType = ENUM.ETeamType.arena,
			heroMaxNum = 3,
		}
		uiManager:PushUi(EUI.CommonFormationUI, data)
	-- 挑战对手
	else
		if g_dataCenter.chatFight:CheckMyRequest() then
			return
		end

		self.fightPlayerid = playerid

		if self.dataCenter.coldTime - system.time() > 0 then
			FloatTip.Float(_UIText[20])
			return
		end

		-- 检查剩余挑战次数
		if self.dataCenter:GetTimes() <= 0 then
			self:BuyChallengeTimes(1)
			return;
		end

		-- 开始挑战
		local player = self.canFightPlayer[self.fightPlayerid]
		if player then
			self.dataCenter:StartBattle(player)
		end
	end
end

function ArenaMainUI:LoadItem(itemPlayer, index)
	local playerList = self.playerList or table.empty()
	local canFightPlayer = self.canFightPlayer or table.empty()
	local myplayerid = g_dataCenter.player.playerid
	local data = playerList[index]

	itemPlayer.index = index
	if data and data.playerid ~= myplayerid then
		itemPlayer.self:set_active(true)
		local spItem = ngui.find_sprite(itemPlayer.self, itemPlayer.self:get_name())
		spItem:set_on_ngui_click(self.bindfunc["on_player_view"])
		spItem:set_event_value(data.playerid)

		local backIndex = 5
		if data.rank > 0 and data.rank <= 3 then
			itemPlayer.spRank123:set_active(true)
			itemPlayer.nodeTxtRank:set_active(false)
			PublicFunc.SetRank123Sprite(itemPlayer.spRank123, data.rank)
			backIndex = data.rank

		elseif data.rank <= 10 then
			itemPlayer.spRank123:set_active(false)
			itemPlayer.nodeTxtRank:set_active(true)
			backIndex = 4

		else
			itemPlayer.spRank123:set_active(false)
			itemPlayer.nodeTxtRank:set_active(true)
			backIndex = 4

		end

		itemPlayer.labRank:set_text(tostring(data.rank))
		itemPlayer.labName:set_text(data.name)
		itemPlayer.labFightValue:set_text(tostring(data.fightPoint))
		itemPlayer.spRankBg:set_sprite_name(_EPlaneBg2Name[backIndex])
		if ConfigHelper.GetRole(data.leaderId) ~= nil then
			itemPlayer.textureRole:set_texture(ConfigHelper.GetRole(data.leaderId).icon300)
		else
			app.log("角色未找到，leaderId: " .. data.leaderId)
		end

		if canFightPlayer[data.playerid] and data.playerid ~= myplayerid then
			itemPlayer.btnChallenge:set_event_value(data.playerid, 0);
		else
			itemPlayer.btnChallenge:set_active(false)
		end
	else
		itemPlayer.self:set_active(false)
	end
end

-- 初始化成员列表项
function ArenaMainUI:CreateItemPlayer(obj, index)
	local objName = obj:get_name()
	itemPlayer = { }
	itemPlayer.self = obj

	itemPlayer.labName = ngui.find_label(obj, "lab_name")
	itemPlayer.labFightValue = ngui.find_label(obj, "sp_fight/lab_fight")

	itemPlayer.spRank123 =  ngui.find_sprite(obj, "sp_rank")
	itemPlayer.nodeTxtRank = obj:get_child_by_name("sp_rank_di")
	itemPlayer.labRank =  ngui.find_label(itemPlayer.nodeTxtRank, "lab_rank")
	itemPlayer.spRankBg = ngui.find_sprite(obj, "sp_di")
	itemPlayer.spTxtChallenge = ngui.find_sprite(obj, "sp_challenge")
	itemPlayer.labChallengeNum = ngui.find_label(obj, "sp_challenge/lab_num")

	--目前只能挑战1次
	itemPlayer.spTxtChallenge:set_sprite_name("jjc_tiaozhan1")
	itemPlayer.labChallengeNum:set_text("")

	itemPlayer.textureRole = ngui.find_texture(obj, "Texture")
	itemPlayer.btnChallenge = ngui.find_button(obj, "sp_challenge")

	itemPlayer.btnChallenge:set_on_click(self.bindfunc["on_fight_player"])

	return itemPlayer
end

function ArenaMainUI:StartRefreshTimer(time)
	_TimerSecs = time or 3
	TimerManager.Add(_TimerRefreshCdFunc, 1000, _TimerSecs, self)
end

function ArenaMainUI:CheckFightCD()
	local sec = self.dataCenter.coldTime - system.time()
	if sec > 0 then
		TimerManager.Add(self.StartFightCdTimer, 1000, -1, self)
		self:SetFightCdShow(true)
		self.labFightCD:set_text(TimeAnalysis.analysisSec_2(sec, true).._UIText[18])
	else
		self:SetFightCdShow(false)
	end
end

function ArenaMainUI:StartFightCdTimer()
	if self.ui then
		local sec = self.dataCenter.coldTime - system.time()
		if sec >= 0 then
			self.labFightCD:set_text(TimeAnalysis.analysisSec_2(sec, true).._UIText[18])
		else
			self:StopFightCdTimer()
		end
	end
end

function ArenaMainUI:StopFightCdTimer()
	if self.ui then
		self:SetFightCdShow(false)
	end
	TimerManager.Remove(self.StartFightCdTimer)
end

function ArenaMainUI:SetFightCdShow(bool)
	if bool then
		-- self.btnArrange:set_active(false)
		self.btnRefresh:set_active(false)
		self.btnResetCD:set_active(true)
		self.labFightCD:set_active(true)

		self.labResetCdNum:set_text(tostring(self.dataCenter:GetCleanCdCost()))
	else
		-- self.btnArrange:set_active(true)
		self.btnRefresh:set_active(true)
		self.btnResetCD:set_active(false)
		self.labFightCD:set_active(false)
	end
end

----------------------- 网络回调 ---------------------------
--ntype  0:top 10,1:和自己关联的10名,2:前50名,3:用于更新挑战对手数据刷新
function ArenaMainUI:on_gc_arena_sync_player_list(ntype, playerList)
	if ntype < 2 then
		if not self:IsShow() then return end

		self:SetPlayerList(ntype, playerList)
		self:UpdateList()
		self:UpdateUi()
	end
end

function ArenaMainUI:on_gc_arena_sync_myself_info()
	self:UpdateUi()
end

function ArenaMainUI:on_gc_arena_buy_challenge_times(buyEnterFight)
	if buyEnterFight == 1 then
		self:UpdateUi()
		-- 立即进入挑战
		local player = self.canFightPlayer[self.fightPlayerid]
		if player then
			self.dataCenter:StartBattle(player)
		end

	elseif buyEnterFight == 0 then
		UiRollMsg.PushMsg( { str = _UIText[15], priority = 1 })
		self:UpdateUi()
	end
end

function ArenaMainUI:on_gc_arena_refresh_challenge_list()
	self:StartRefreshTimer()
	self:UpdateUi()
end

-- 玩家自身的队伍阵型发生改变
function ArenaMainUI:on_update_team(teamid)
	if teamid ~= ENUM.ETeamType.arena then return end
	self.arenaTeam = g_dataCenter.player:GetTeam(teamid)
	if self:IsShow() then
		msg_activity.cg_arena_request_player_list(1);
	else
		self.updateTeamData = true
	end
end

function ArenaMainUI:on_vip_change()
	self:UpdateUi()
end

function ArenaMainUI:on_item_data_change(cid)
	if cid == IdConfig.Medal or cid == IdConfig.Crystal then
		self:UpdateUi()
	end
end

-------------------------- 新手引导用 ----------------------------
--自己前面那个可挑战对手的按钮
function ArenaMainUI:GetPlayerAheadFightBtnUi()
	if self.myPos and self.myPos > 1 then
		for b, itemPlayer in pairs(self.itemPlayer) do
			if itemPlayer.index == self.myPos - 1 then
				return itemPlayer.btnChallenge:get_game_object()
			end
		end
	end
end
