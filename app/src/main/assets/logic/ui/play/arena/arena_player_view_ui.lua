--	ArenaPlayerViewUI 竞技场对手信息查看界面
--	author: zzc
--	create: 2016-2-24

ArenaPlayerViewUI = Class('ArenaPlayerViewUI', UiBaseClass);

local _local = {}
_local.UIText = {
	[1] = "[FFB400FF]等级:[-]",
	[2] = "[FFB400FF]胜利场数:[-]",
	[3] = "[FFB400FF]排名:[-]",
	[4] = "[FFB400FF]战斗力:[-]",
	[5] = "没有加入公会",
}

function ArenaPlayerViewUI:SetData(player, guildDetail)
	self.player = player
	self.guildDetail = guildDetail
	self:UpdateUi()
end

function ArenaPlayerViewUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/arena/ui_4402_jjc.assetbundle";
	UiBaseClass.Init(self, data);
end

function ArenaPlayerViewUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function ArenaPlayerViewUI:Restart(data)
	UiBaseClass.Restart(self, data);
end

function ArenaPlayerViewUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, ArenaPlayerViewUI.on_btn_close);
	self.bindfunc["gc_look_other_player"] = Utility.bind_callback(self, ArenaPlayerViewUI.gc_look_other_player);
end

function ArenaPlayerViewUI:MsgRegist()
    PublicFunc.msg_regist(player.gc_look_other_player,self.bindfunc['gc_look_other_player']);
end

--注销消息分发回调函数
function ArenaPlayerViewUI:MsgUnRegist()
    PublicFunc.msg_unregist(player.gc_look_other_player,self.bindfunc['gc_look_other_player']);
end

function ArenaPlayerViewUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_arena_player_view");

	local path = "centre_other/animation/sp_di1/"
	---------------------------- 玩家信息 -----------------------------
	self.labPlayerName = ngui.find_label(self.ui, path.."sp_bk/lab_equip_name")
	self.labPlayerLevel = ngui.find_label(self.ui, path.."sp_bk/lab_level")
	self.labPlayerWinNum = ngui.find_label(self.ui, path.."sp_bk/lab_life")
	self.labPlayerRank = ngui.find_label(self.ui, path.."sp_bk/lab_defense")
	self.labPlayerAttack = ngui.find_label(self.ui, path.."sp_bk/lab_attack")
	local objCard = self.ui:get_child_by_name(path.."big_card_item_80")
	self.playerCard = SmallCardUi:new({parent=objCard})
	self.playerCard:ShowOnlyPic()

	self.labPlayerWinNum:set_active(false) --不显示胜场
	

	path = "centre_other/animation/sp_di2/"
	---------------------------- 玩家阵容 -----------------------------
	self.heroCard = {}
	for i=1, 3 do 
		objCard = self.ui:get_child_by_name(path.."sp_left_back"..i.."/big_card_item_80")
		self.heroCard[i] = SmallCardUi:new({parent=objCard, sgroup=1})
	end

	path = "centre_other/animation/sp_di3/"
	---------------------------- 玩家社团 -----------------------------
	self.guildIcon = ngui.find_texture(self.ui, "sp_di1/texture")
	self.guildName = ngui.find_label(self.ui, "sp_di1/lab")

	local btnClose = ngui.find_button(self.ui, "centre_other/animation/btn_cha")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])

	self:UpdateUi()
end

function ArenaPlayerViewUI:UpdateUi()
	if not self.ui then return end

	if self.player then
		self.labPlayerName:set_text(self.player.name)
		self.labPlayerLevel:set_text(_local.UIText[1]..self.player.level)
		self.labPlayerRank:set_text(_local.UIText[3]..self.player.rank)
		self.labPlayerAttack:set_text(_local.UIText[4]..self.player.fightPoint)

		-- TODO 显示队长头像
		local heroNumber = nil
		local info = nil
		if self.player.heroCards[1] then
			heroNumber = self.player.heroCards[1].number
		end
		if heroNumber then
			info = PublicFunc.CreateCardInfo(heroNumber)
		end
		self.playerCard:SetData(info)

		for i = 1, 3 do
			if self.player.heroCards[i] then
				heroNumber = self.player.heroCards[i].number
			else
				heroNumber = nil
			end
			if heroNumber then
				info = PublicFunc.CreateCardInfo(heroNumber)
			else
				info = nil
			end
			self.heroCard[i]:SetData(info)
		end
	else
		self.labPlayerName:set_text("--")
		self.labPlayerLevel:set_text(_local.UIText[1].."--")
		self.labPlayerRank:set_text(_local.UIText[3].."--")
		self.labPlayerAttack:set_text(_local.UIText[4].."--")
		self.playerCard:SetData(nil)
		for i = 1, 3 do
			self.heroCard[i]:SetData(nil)
		end
	end

	if self.guildDetail then
		--尚未加入公会
		if tonumber(self.guildDetail.id) == 0 then
			self.guildIcon:clear_texture()
			self.guildName:set_text(_local.UIText[5])
		else
			local config = ConfigManager.Get(EConfigIndex.t_guild_icon, self.guildDetail.icon)
			self.guildIcon:set_texture(config.icon)
			self.guildName:set_text(self.guildDetail.name)
		end
	else
		self.guildIcon:clear_texture()
		self.guildName:set_text("")

		--取玩家公会数据
		if self.player then
			player.cg_look_other_player(self.player.playerid, ENUM.ETeamType.arena);
		end
	end
end

function ArenaPlayerViewUI:DestroyUi()
	if self.player then
		self.player = nil
	end

	if self.guildDetail then
		self.guildDetail = nil
	end

	if self.playerCard then
		self.playerCard:DestroyUi()
		self.playerCard = nil
	end

	if self.heroCard then
		for k, heroCard in pairs(self.heroCard) do
			heroCard:DestroyUi()
		end
		self.heroCard = nil
	end

	if self.guildIcon then
		self.guildIcon:Destroy()
		self.guildIcon = nil

	end

	UiBaseClass.DestroyUi(self);
end

function ArenaPlayerViewUI:on_btn_close()
	self:Hide()
end

--
function ArenaPlayerViewUI:gc_look_other_player(result,playerid,teamType,otherPlayerData)
    if self.ui == nil then return end
	if self.player == nil or self.player.playerid ~= playerid then return end

    local guild = otherPlayerData.guilddata;
	self.guildDetail = GuildDetail:new(guild);
    
    self:UpdateUi();
end
