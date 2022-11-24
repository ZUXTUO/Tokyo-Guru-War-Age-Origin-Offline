--region fuzion_hero_ui.lua
--Author : zzc
--Date   : 2016/1/13

--endregion

-------------------------------- 已废弃 -----------------------------

FuzionHeroUI = Class('FuzionHeroUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.resPath = "assetbundles/prefabs/ui/fuzion/ui_2904_fuzion.assetbundle"

-- 抽取本地的文本，需要替换到配置表
_local.UIText = {
	[1] = "角色设置",
	[2] = "请添加角色",
	[3] = "",
	[4] = "开始匹配",
}

_local.CountDown = 20 -- 倒计时匹配时间

local function _GetFuzionTeam()
	return g_dataCenter.player.teams[ENUM.ETeamType.fuzion]
end

local function _GetFuzionTeamHeroId()
	local team = g_dataCenter.player.teams[ENUM.ETeamType.fuzion]
	return team[1]
end

local function _GetFuzionTeamHeroCard()
	local heroid = _GetFuzionTeamHeroId()
	if heroid then
		return g_dataCenter.package:find_card(ENUM.EPackageType.Hero, heroid)
	end
end

-------------------------------------类方法-------------------------------------
--初始化
function FuzionHeroUI:Init(data)
	self.pathRes = _local.resPath
	UiBaseClass.Init(self, data);
end

--重新开始
function FuzionHeroUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    	self.vsMatchUI = VsMatchUI:new()
		self.vsMatchUI:SetData({callback=self.bindfunc["on_vs_match_exit"], countDown=_local.CountDown})
		self.vsMatchUI:Hide()
	end
end

--初始化数据
function FuzionHeroUI:InitData(data)
	UiBaseClass.InitData(self, data);

	-- 检查是否有初始阵容，默认情况取普通阵容第一个英雄
	local team = _GetFuzionTeam()
	if team == nil then 
		team = {}
		g_dataCenter.player.teams[ENUM.ETeamType.fuzion] = team
	end
	if team[1] == nil then
		for i, v in ipairs(g_dataCenter.player.teams[ENUM.ETeamType.normal]) do
			team[1] = v
			break;
		end
	end
end

--释放界面
function FuzionHeroUI:DestroyUi()
    if self.vsMatchUI then
    	self.vsMatchUI:DestroyUi()
    	self.vsMatchUI = nil
    end

    if self.smallCard then
    	self.smallCard:DestroyUi()
    	self.smallCard = nil
    end

    UiBaseClass.DestroyUi(self);
end

--注册方法
function FuzionHeroUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
	self.bindfunc["on_close_btn"] = Utility.bind_callback(self, self.on_close_btn);
	self.bindfunc["on_start_btn"] = Utility.bind_callback(self, self.on_start_btn);
	self.bindfunc["on_start_match"] = Utility.bind_callback(self, self.on_start_match);
	self.bindfunc["on_select_hero_btn"] = Utility.bind_callback(self, self.on_select_hero_btn);
	self.bindfunc["on_cancel_match"] = Utility.bind_callback(self, self.on_cancel_match);
	self.bindfunc["on_match_finish"] = Utility.bind_callback(self, self.on_match_finish);
	self.bindfunc["on_vs_match_exit"] = Utility.bind_callback(self, self.on_vs_match_exit);
	self.bindfunc["on_update_team_info"] = Utility.bind_callback(self, self.on_update_team_info);
end 

--撤销注册方法
function FuzionHeroUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function FuzionHeroUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_daluandou.gc_start_match, self.bindfunc["on_start_match"]) 
	PublicFunc.msg_regist(msg_daluandou.gc_cancel_match, self.bindfunc["on_cancel_match"]) 
	PublicFunc.msg_regist(msg_daluandou.gc_match_finish, self.bindfunc["on_match_finish"]) 

	NoticeManager.BeginListen(ENUM.NoticeType.ChangeTeamSuccess, self.bindfunc["on_update_team_info"])
end

--注销消息分发回调函数
function FuzionHeroUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_daluandou.gc_start_match, self.bindfunc["on_start_match"])
	PublicFunc.msg_unregist(msg_daluandou.gc_cancel_match, self.bindfunc["on_cancel_match"])
	PublicFunc.msg_unregist(msg_daluandou.gc_match_finish, self.bindfunc["on_match_finish"])

	NoticeManager.EndListen(ENUM.NoticeType.ChangeTeamSuccess, self.bindfunc["on_update_team_info"])
end

--初始化UI
function FuzionHeroUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("fuzion_hero_ui");

	local path = "centre_other/animation/"
	local objMask = self.ui:get_child_by_name("fuzion_hero_ui/sp_mark")
	local labTitle = ngui.find_label(self.ui, path.."lab_title")
	local btnClose = ngui.find_button(self.ui, path.."btn_fork")
	local btnMatch = ngui.find_button(self.ui, path.."btn2")
	local labMatch = ngui.find_label(self.ui, path.."btn2/animation/lab")
	self.spMatch = ngui.find_sprite(self.ui, path.."btn2/animation/sprite_background")
	self.labNoHeroTips = ngui.find_label(self.ui, path.."txt")
	self.labHeroName = ngui.find_label(self.ui, path.."lab_name")
	self.spFightValue = ngui.find_sprite(self.ui, path.."sp_finghting")
	self.labFightValue = ngui.find_label(self.ui, path.."sp_finghting/lab")

	local ui_card = self.ui:get_child_by_name("new_small_card_item")
	self.smallCard = SmallCardUi:new({parent=ui_card, sgroup=3})
	self.smallCard:SetCallback(self.bindfunc["on_select_hero_btn"])

	objMask:set_on_click(self.bindfunc["on_close_btn"])
	btnMatch:set_on_click(self.bindfunc["on_start_btn"])
	btnClose:set_on_click(self.bindfunc["on_close_btn"])
	labTitle:set_text(_local.UIText[1])
	labMatch:set_text(_local.UIText[4])
	self.labNoHeroTips:set_text(_local.UIText[2])

	self:UpdateUi()
end

--刷新界面
function FuzionHeroUI:UpdateUi()
	if self.ui == nil then return end

	local hero = _GetFuzionTeamHeroCard()
	if hero then
		self.labNoHeroTips:set_active(false)
		self.labHeroName:set_active(true)
		self.spFightValue:set_active(true)

		self.labHeroName:set_text(hero.name)
		self.labFightValue:set_text(tostring(hero:GetFightValue()))
		self.smallCard:SetData(hero)
	else
		self.labNoHeroTips:set_active(true)
		self.labHeroName:set_active(false)
		self.spFightValue:set_active(false)

		self.smallCard:SetData(nil)
	end
end

function FuzionHeroUI:OnEnterFight()
	uiManager:PopUi(nil, true)
end

-------------------------------------本地回调-------------------------------------
--关闭按钮
function FuzionHeroUI:on_close_btn(t)
	uiManager:PopUi()
end

--请求匹配
function FuzionHeroUI:on_start_btn(t)
	local team = g_dataCenter.player.teams[ENUM.ETeamType.fuzion]
	if team and team[1] then
		msg_daluandou.cg_start_match(team[1])
	end
end

--选择英雄按钮
function FuzionHeroUI:on_select_hero_btn(t)
	-- 已废弃
	-- uiManager:PushUi(EUI.FuzionChoseHeroUI);
	-- uiManager:GetCurScene():SetParam(1);	-- 设置hero位置
	-- local team = g_dataCenter.player.teams[ENUM.ETeamType.fuzion]
	-- uiManager:GetCurScene():SetTeam(team);

	local ui = uiManager:PushUi(EUI.FormationUi)
	ui:SetPlayerGID(g_dataCenter.player.playerid, ENUM.ETeamType.fuzion, nil, nil, 1);
end

--匹配界面退出
function FuzionHeroUI:on_vs_match_exit(result)
	if result then
		-- 自动切换到战斗场景
		--uiManager:PopUi()		
	else
		msg_daluandou.cg_cancel_match(g_dataCenter.fuzion.roomid)
	end
end

-------------------------------------网络回调-------------------------------------
-- 匹配开始确认（回调成功才打开匹配界面原因：有匹配惩罚的不一定能打开匹配界面）
function FuzionHeroUI:on_start_match()
	self:Hide()
	self.vsMatchUI:Show()
end

--取消匹配成功
function FuzionHeroUI:on_cancel_match()
	self:Show()
	self.vsMatchUI:Hide()
end

--锁定匹配，进入就绪模式
function FuzionHeroUI:on_match_finish()
	self.vsMatchUI:SetReady(true)
end

--更新了队伍信息
function FuzionHeroUI:on_update_team_info()
	self:UpdateUi()
end

