--	ArenaRankChangeUI 竞技场排名提升界面
--	author: zzc
--	create: 2016-2-24

ArenaRankChangeUI = Class('ArenaRankChangeUI', UiBaseClass);

local _local = {}
_local.UIText = {
	[1] = "",
	[2] = "您的排名不变",
	[3] = "您的排名上升为：",
	[4] = "对方排名下降为：",
}

function ArenaRankChangeUI:SetData(data)
	if data then
		self.player1 = data.player1	-- 自己
		self.player2 = data.player2	-- 对手
	end
	self:UpdateUi()
end

function ArenaRankChangeUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/arena/ui_4405_jjc.assetbundle";
	UiBaseClass.Init(self, data);
end

function ArenaRankChangeUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function ArenaRankChangeUI:Restart(data)
	-- data = {
	-- 	player1 = {...},	-- {rank=,rankChange=,roleId=,name=}
	-- 	player2 = {...},	-- {rank=,rankChange=,roleId=,name=}
	-- }
	-- 传入对战参数
	if data then
		self.player1 = data.player1	-- 自己
		self.player2 = data.player2	-- 对手
	end
	UiBaseClass.Restart(self, data);
end

function ArenaRankChangeUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_mask"] = Utility.bind_callback(self, ArenaRankChangeUI.on_mask);
end

function ArenaRankChangeUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_arena_rank_change");

	local objCard = nil

	local mask = ngui.find_button(self.ui, "ui_arena_rank_change/mark")
	mask:set_on_click(self.bindfunc["on_mask"])


	local leftCtr = {}
	local path = "center_other/animation/left_cont"
	leftCtr.self = self.ui:get_child_by_name(path)
	leftCtr.rankChange = ngui.find_label(leftCtr.self, "lab_title") -- UI命名不一致
	leftCtr.name = ngui.find_label(leftCtr.self, "lab_name")
	leftCtr.rank = ngui.find_label(leftCtr.self, "lab_level")
	objCard = leftCtr.self:get_child_by_name("sp_head_di_item")
	leftCtr.card = UiPlayerHead:new({parent=objCard})
	self.leftCtr = leftCtr

	path = "center_other/animation/right_cont"
	local rightCtr = {}
	rightCtr.self = self.ui:get_child_by_name(path)
	rightCtr.rankChange = ngui.find_label(rightCtr.self, "lab_num")
	rightCtr.name = ngui.find_label(rightCtr.self, "lab_name")
	rightCtr.rank = ngui.find_label(rightCtr.self, "lab_level")
	objCard = rightCtr.self:get_child_by_name("sp_head_di_item")
	rightCtr.card = UiPlayerHead:new({parent=objCard})
	self.rightCtr = rightCtr


	path = "center_other/animation/centre"
	local centerCtr = {}
	centerCtr.self = self.ui:get_child_by_name(path)
	centerCtr.rank = ngui.find_label(rightCtr.self, "lab_level")
	objCard = centerCtr.self:get_child_by_name("sp_head_di_item")
	centerCtr.card = UiPlayerHead:new({parent=objCard})
	self.centerCtr = centerCtr

	self:UpdateUi()
end

function ArenaRankChangeUI:DestroyUi()
	if self.leftCtr then
		self.leftCtr.card:DestroyUi()
		self.leftCtr = nil
	end
	if self.rightCtr then
		self.rightCtr.card:DestroyUi()
		self.rightCtr = nil
	end
	if self.centerCtr then
		self.centerCtr.card:DestroyUi()
		self.centerCtr = nil
	end
	self.player1 = nil
	self.player2 = nil
	
	UiBaseClass.DestroyUi(self);
end

function ArenaRankChangeUI:UpdateUi()
	if self.ui == nil then return end
	if self.player1 == nil or self.player2 == nil then return end

	if self.player1.rankChange == 0 and self.player2.rankChange == 0 then
		self.leftCtr.self:set_active(false)
		self.rightCtr.self:set_active(false)
		self.centerCtr.self:set_active(true)

		self.centerCtr.rank:set_text(_local.UIText[2]..self.player1.rank)
		self.centerCtr.card:SetRoleId(self.player1.roleId)
	else 
		self.leftCtr.self:set_active(true)
		self.rightCtr.self:set_active(true)
		self.centerCtr.self:set_active(false)

		self.leftCtr.rankChange:set_text(
			string.format("+"..math.abs(self.player1.rankChange)))
		self.rightCtr.rankChange:set_text(
			string.format("-"..math.abs(self.player2.rankChange)))
		
		self.leftCtr.rank:set_text(_local.UIText[3]..self.player1.rank)
		self.leftCtr.name:set_text(self.player1.name)
		self.leftCtr.card:SetRoleId(self.player1.roleId)

		self.rightCtr.rank:set_text(_local.UIText[4]..self.player2.rank)
		self.rightCtr.name:set_text(self.player2.name)
		self.rightCtr.card:SetRoleId(self.player2.roleId)

		AudioManager.Play3dAudio(ENUM.EUiAudioType.LvUpNormal, AudioManager.GetUiAudioSourceNode(), true)
	end
end

----------------------- 本地回调 ---------------------------
function ArenaRankChangeUI:on_mask()
	self:Hide();
	local arena = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
	if arena.topRankResult then
		local result = arena.topRankResult
		local content = string.format(
				"英勇的你凭借完美表现，又一次刷新在竞技场中的最好成绩！现在的你排名为第%s名，历史排名提升了%s名！", 
				arena.rank, result.upTopRank);
		HintUI.SetAndShow(EHintUiType.one, content, { str = "确定", --[[func = function ()
			if #result.awards > 0 then
				CommonAward.Start(result.awards)
			end
		end--]] })

		arena.topRankResult = nil
	end
end
