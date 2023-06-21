GuildBossRankUI = Class('GuildBossRankUI', UiBaseClass);

local _strCfg = 
{
	["title1"] = "社团",
	["title2"] = "首领",
	["title3"] = "击杀时间",
	["title4"] = "玩家名",
	["title5"] = "职位",
	["title6"] = "总伤害",
}

local ERANK_TYPE = 
{
	DAMAGE = 1,
	GUILD = 2,
	GUILD_WEEK = 3,
}

local _rankType = 20;
local _rankWeekType = 21;
local _rankNum = 10;

function GuildBossRankUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2824_guild_rank.assetbundle";
	UiBaseClass.Init(self, data);
end

function GuildBossRankUI:Restart(data)
	msg_guild_boss.cg_request_guild_boss_damage_rank_info();
	msg_rank.cg_rank(_rankType, _rankNum);
	msg_rank.cg_rank(_rankWeekType, _rankNum);
	self.curType = ERANK_TYPE.DAMAGE;
	self.infoDamageRank = {};
	self.listRankList = {};
	self.listRankWeekList = {};
	self.nMyDamageRank = 0;
	self.nMyDamage = 0;
    UiBaseClass.Restart(self, data);
end

function GuildBossRankUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_change_damage"] = Utility.bind_callback(self, self.on_change_damage);
    self.bindfunc["on_change_guild"] = Utility.bind_callback(self, self.on_change_guild);
    self.bindfunc["on_change_guild_week"] = Utility.bind_callback(self, self.on_change_guild_week);
    self.bindfunc["on_click_look"] = Utility.bind_callback(self, self.on_click_look);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["gc_sync_guild_boss_damage_rank_info"] = Utility.bind_callback(self, self.gc_sync_guild_boss_damage_rank_info);
    self.bindfunc["gc_rank"] = Utility.bind_callback(self, self.gc_rank);
end

function GuildBossRankUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_guild_boss.gc_sync_guild_boss_damage_rank_info,self.bindfunc["gc_sync_guild_boss_damage_rank_info"]);
    PublicFunc.msg_regist(msg_rank.gc_rank,self.bindfunc["gc_rank"]);
end

function GuildBossRankUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild_boss.gc_sync_guild_boss_damage_rank_info,self.bindfunc["gc_sync_guild_boss_damage_rank_info"]);
    PublicFunc.msg_unregist(msg_rank.gc_rank,self.bindfunc["gc_rank"]);
end

function GuildBossRankUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('GuildBossRankUI');

    local _togDamageRank = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka1");
    _togDamageRank:set_on_change(self.bindfunc["on_change_damage"]);

    local _togGuildRank = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka2");
    _togGuildRank:set_on_change(self.bindfunc["on_change_guild"]);

    local _togGuildRankWeek = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka3");
    _togGuildRankWeek:set_on_change(self.bindfunc["on_change_guild_week"]);

    self.scroll = ngui.find_scroll_view(self.ui,"right_other/animation/scroll_view/panel_list");
    self.cont = {};
    self.wrap = ngui.find_wrap_content(self.ui,"right_other/animation/scroll_view/panel_list/wrap_content");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self.title1 = ngui.find_label(self.ui,"right_other/animation/sp_title/txt_shetuan");
    self.title2 = ngui.find_label(self.ui,"right_other/animation/sp_title/txt_tuanzhang");
    self.title3 = ngui.find_label(self.ui,"right_other/animation/sp_title/txt_zongzhanli");

    local obj = self.ui:get_child_by_name("center_other/animation/texture_di/sp_head_di_item");
    self.objHead = UiPlayerHead:new({parent=obj,vip=false});
    self.texGuildIcon = ngui.find_texture(self.ui,"center_other/animation/texture_di/texture_guild");
    self.labPlayer = ngui.find_label(self.ui,"center_other/animation/texture_di/lab_name");
    self.labGuild = ngui.find_label(self.ui,"center_other/animation/texture_di/lab_guild");

    local btnLook = ngui.find_button(self.ui,"center_other/animation/texture_di/btn");
    btnLook:set_on_click(self.bindfunc["on_click_look"]);

    local obj = self.ui:get_child_by_name("right_other/animation/content");
    self.contSelf = self:init_item(obj);

	self:UpdateUi();
end

function GuildBossRankUI:DestroyUi()
	if self.objHead then
		self.objHead:DestroyUi();
		self.objHead = nil;
	end
    UiBaseClass.DestroyUi(self);
end

function GuildBossRankUI:on_change_damage(value)
	if not self.ui then return end;
	if value then
		self.curType = ERANK_TYPE.DAMAGE;
		self.title1:set_text(_strCfg["title4"]);
		self.title2:set_text(_strCfg["title5"]);
		self.title3:set_text(_strCfg["title6"]);
		self.texGuildIcon:set_active(false);
		self.contSelf.team.obj:set_active(true);
		self.contSelf.guild.obj:set_active(false);

		local cfg = self.infoDamageRank[1];
		if cfg then
			self.objHead:Show();

			self.objHead:SetRoleId(cfg.image);
			self.labPlayer:set_text(tostring(cfg.name).." 等级[FDE517FF]"..tostring(cfg.level));
			-- self.labGuild:set_text("社团  [00F6FFFF]"..g_dataCenter.guild:GetMyGuildName());
			self.labGuild:set_text("");
			self.clickData = cfg.player_gid;
		else
			self.objHead:Hide();
			self.labPlayer:set_text("");
			self.labGuild:set_text("");
			self.clickData = nil;
			-- FloatTip.Float("当前还没有排行榜数据");
		end
		self.wrap:set_min_index(1-#self.infoDamageRank);
		self.wrap:set_max_index(0);
		self.wrap:reset();
		self.scroll:reset_position();

		if self.nMyDamageRank == 0 then
			self.contSelf.spRank:set_active(false);
			self.contSelf.spRankBk:set_active(false);
			self.contSelf.labRank:set_active(true);
			self.contSelf.labRank:set_text("未上榜");
		elseif self.nMyDamageRank <= 3 then
			self.contSelf.spRank:set_active(true);
			self.contSelf.spRank:set_sprite_name("phb_paiming"..self.nMyDamageRank);
			self.contSelf.spRankBk:set_active(true);
			self.contSelf.spRankBk:set_sprite_name("phb_paiming"..self.nMyDamageRank.."_1");
			self.contSelf.labRank:set_active(false);
		else
			self.contSelf.spRank:set_active(false);
			self.contSelf.spRankBk:set_active(false);
			self.contSelf.labRank:set_active(true);
			self.contSelf.labRank:set_text(tostring(self.nMyDamageRank));
		end
		local myData = g_dataCenter.guild:GetMyMemberData();
		self.contSelf.team.labLv:set_text("");
		self.contSelf.team.labName:set_text(myData.name);
		self.contSelf.labInfo:set_text(Guild.GetJobName(myData.job));
		self.contSelf.labValue:set_text(tostring(self.nMyDamage));
	else
	end
end

function GuildBossRankUI:on_change_guild(value)
	if not self.ui then return end;
	if value then
		self.curType = ERANK_TYPE.GUILD;
		self.title1:set_text(_strCfg["title1"]);
		self.title2:set_text(_strCfg["title2"]);
		self.title3:set_text(_strCfg["title3"]);
		self.contSelf.team.obj:set_active(false);
		self.contSelf.guild.obj:set_active(true);
		self.objHead:Hide();

		local cfg = self.listRankList[1];
		if cfg then
			local iconCfg = ConfigManager.Get(EConfigIndex.t_guild_icon,cfg.iconsid[1]);
			if iconCfg then
				self.texGuildIcon:set_active(true);
				self.texGuildIcon:set_texture(iconCfg.icon);
			else
				self.texGuildIcon:set_active(false);
			end
			self.labPlayer:set_text("社长 "..tostring(cfg.addition_name));
			self.labGuild:set_text("[00F6FFFF]"..cfg.name .." 等级"..tostring(cfg.level));
			self.clickData = cfg.id;
		else
			self.texGuildIcon:set_active(false);
			self.labPlayer:set_text("");
			self.labGuild:set_text("");
			self.clickData = nil;
			FloatTip.Float("当前还没有排行榜数据");
		end

		if self.infoMyRank.ranking <= 0 then
			self.contSelf.spRank:set_active(false);
			self.contSelf.spRankBk:set_active(false);
			self.contSelf.labRank:set_active(true);
			self.contSelf.labRank:set_text("未上榜");
		elseif self.infoMyRank.ranking <= 3 then
			self.contSelf.spRank:set_active(true);
			self.contSelf.spRank:set_sprite_name("phb_paiming"..self.infoMyRank.ranking);
			self.contSelf.spRankBk:set_sprite_name("phb_paiming"..self.infoMyRank.ranking.."_1");
			self.contSelf.labRank:set_active(false);
		else
			self.contSelf.spRank:set_active(false);
			self.contSelf.spRankBk:set_active(false);
			self.contSelf.labRank:set_active(true);
			self.contSelf.labRank:set_text(tostring(self.infoMyRank.ranking));
		end
		if self.infoMyRank.param3 == 0 then
			self.contSelf.labValue:set_text("");
		else
			local year,month,day = TimeAnalysis.ConvertToYearMonDay(self.infoMyRank.param3);
			self.contSelf.labValue:set_text(year.."-"..month.."-"..day)
		end
		local id = bit.bit_and(self.infoMyRank.ranking_num,0xFFFF);
		local lv = bit.bit_rshift(self.infoMyRank.ranking_num,16);
		local cfg = ConfigManager.Get(EConfigIndex.t_guild_boss_monster,id);
		if cfg then
			local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property, cfg.boss_id);
			self.contSelf.labInfo:set_text(PublicFunc.GetItemName(monsterCfg.name,lv));
		else
			self.contSelf.labInfo:set_text("");
		end
		local name = g_dataCenter.guild:GetMyGuildName();
		self.contSelf.guild.labName:set_text(name);
		if self.infoMyRank.param2 == 0 then
			local data = g_dataCenter.guild:GetDetail();
			local curNum = Guild.GetMemberNumber(data);
			local MaxNum = Guild.GetMemberLimit(data);
			local level = data.level
			self.contSelf.guild.labLv:set_text("[FDE517FF]"..level.."[-]级"..curNum.."/"..MaxNum.."人");
		else
			local allnum = bit.bit_and(self.infoMyRank.param2,0xFFFF);
			local maxnum = bit.bit_rshift(self.infoMyRank.param2,16);
			self.contSelf.guild.labLv:set_text("[FDE517FF]"..self.infoMyRank.level.."[-]级"..allnum.."/"..maxnum.."人");
		end

		self.wrap:set_min_index(1-#self.listRankList);
		self.wrap:set_max_index(0);
		self.wrap:reset();
		self.scroll:reset_position();
	end
end

function GuildBossRankUI:on_change_guild_week(value)
	if not self.ui then return end;
	if value then
		self.curType = ERANK_TYPE.GUILD_WEEK;
		self.title1:set_text(_strCfg["title1"]);
		self.title2:set_text(_strCfg["title2"]);
		self.title3:set_text(_strCfg["title3"]);
		self.contSelf.team.obj:set_active(false);
		self.contSelf.guild.obj:set_active(true);
		self.objHead:Hide();

		local cfg = self.listRankWeekList[1];
		if cfg then
			local iconCfg = ConfigManager.Get(EConfigIndex.t_guild_icon,cfg.iconsid[1]);
			if iconCfg then
				self.texGuildIcon:set_active(true);
				self.texGuildIcon:set_texture(iconCfg.icon);
			else
				self.texGuildIcon:set_active(false);
			end
			self.labPlayer:set_text("社长 "..tostring(cfg.addition_name));
			self.labGuild:set_text("[00F6FFFF]"..cfg.name .." 等级"..tostring(cfg.level));
			self.clickData = cfg.id;
		else
			self.texGuildIcon:set_active(false);
			self.labPlayer:set_text("");
			self.labGuild:set_text("");
			self.clickData = nil;
			FloatTip.Float("当前还没有排行榜数据");
		end

		if self.infoMyRankWeek.ranking <= 0 then
			self.contSelf.spRank:set_active(false);
			self.contSelf.spRankBk:set_active(false);
			self.contSelf.labRank:set_active(true);
			self.contSelf.labRank:set_text("未上榜");
		elseif self.infoMyRankWeek.ranking <= 3 then
			self.contSelf.spRank:set_active(true);
			self.contSelf.spRank:set_sprite_name("phb_paiming"..self.infoMyRankWeek.ranking);
			self.contSelf.spRankBk:set_sprite_name("phb_paiming"..self.infoMyRankWeek.ranking.."_1");
			self.contSelf.labRank:set_active(false);
		else
			self.contSelf.spRank:set_active(false);
			self.contSelf.spRankBk:set_active(false);
			self.contSelf.labRank:set_active(true);
			self.contSelf.labRank:set_text(tostring(self.infoMyRankWeek.ranking));
		end
		if self.infoMyRankWeek.param3 == 0 then
			self.contSelf.labValue:set_text("");
		else
			local year,month,day = TimeAnalysis.ConvertToYearMonDay(self.infoMyRankWeek.param3);
			self.contSelf.labValue:set_text(year.."-"..month.."-"..day)
		end
		local id = bit.bit_and(self.infoMyRankWeek.ranking_num,0xFFFF);
		local lv = bit.bit_rshift(self.infoMyRankWeek.ranking_num,16);
		local cfg = ConfigManager.Get(EConfigIndex.t_guild_boss_monster,id);
		if cfg then
			local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property, cfg.boss_id);
			self.contSelf.labInfo:set_text(PublicFunc.GetItemName(monsterCfg.name,lv));
		else
			self.contSelf.labInfo:set_text("");
		end
		local name = g_dataCenter.guild:GetMyGuildName();
		self.contSelf.guild.labName:set_text(name);
		if self.infoMyRankWeek.param2 == 0 then
			local data = g_dataCenter.guild:GetDetail();
			local curNum = Guild.GetMemberNumber(data);
			local MaxNum = Guild.GetMemberLimit(data);
			local level = data.level
			self.contSelf.guild.labLv:set_text("[FDE517FF]"..level.."[-]级"..curNum.."/"..MaxNum.."人");
		else
			local allnum = bit.bit_and(self.infoMyRankWeek.param2,0xFFFF);
			local maxnum = bit.bit_rshift(self.infoMyRankWeek.param2,16);
			self.contSelf.guild.labLv:set_text("[FDE517FF]"..self.infoMyRankWeek.level.."[-]级"..allnum.."/"..maxnum.."人");
		end

		self.wrap:set_min_index(1-#self.listRankWeekList);
		self.wrap:set_max_index(0);
		self.wrap:reset();
		self.scroll:reset_position();
	end
end

function GuildBossRankUI:on_click_look()
	if self.clickData ~= nil then 
		if self.curType == ERANK_TYPE.GUILD then 
			OtherGuildPanel.ShowGuildbyId(self.clickData,1)
		else 
			OtherPlayerPanel.ShowPlayer(self.clickData,ENUM.ETeamType.normal);
		end 
	end
end 

function GuildBossRankUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    if Utility.isEmpty(self.cont[b]) then
        self.cont[b] = self:init_item(obj)
    end
    self:update_item(self.cont[b], index);
end

function GuildBossRankUI:init_item(obj)
    local cont = {}
    cont.obj = obj;
    cont.spRank = ngui.find_sprite(obj,"sp_bk/sp_rank");
    cont.spRankBk = ngui.find_sprite(obj,"sp_bk");
    cont.labRank = ngui.find_label(obj,"lab_rank");
    cont.labValue = ngui.find_label(obj,"lab_num");
    cont.labInfo = ngui.find_label(obj,"cont_tuanzhang/lab");
    cont.guild = {};
    cont.guild.obj = obj:get_child_by_name("cont_shetuan");
    cont.guild.labName = ngui.find_label(obj,"cont_shetuan/lab");
    cont.guild.labLv = ngui.find_label(obj,"cont_shetuan/lab_level");
    cont.team = {};
    cont.team.obj = obj:get_child_by_name("cont_zhandui");
    cont.team.labName = ngui.find_label(obj,"cont_zhandui/lab");
    cont.team.labLv = ngui.find_label(obj,"cont_zhandui/sp_v");
    return cont;
end

function GuildBossRankUI:update_item(cont, index)
	if self.curType == ERANK_TYPE.DAMAGE then
		local cfg = self.infoDamageRank[index];
		cont.guild.obj:set_active(false);
		cont.team.obj:set_active(true);
		if index <= 3 then
			cont.spRank:set_active(true);
			cont.spRank:set_sprite_name("phb_paiming"..index);
			cont.spRankBk:set_active(true);
			cont.spRankBk:set_sprite_name("phb_paiming"..index.."_1");
			cont.labRank:set_active(false);
		else
			cont.spRank:set_active(false);
			cont.spRankBk:set_active(false);
			cont.labRank:set_active(true);
			cont.labRank:set_text(tostring(index));
		end
		cont.team.labLv:set_text("");
		cont.team.labName:set_text(cfg.name);
		cont.labInfo:set_text(Guild.GetJobName(cfg.pos));
		cont.labValue:set_text(tostring(cfg.damage));
	else
		cont.guild.obj:set_active(true);
		cont.team.obj:set_active(false);
		local rankInfo;
		if self.curType == ERANK_TYPE.GUILD then
			rankInfo = self.listRankList[index];
		elseif self.curType == ERANK_TYPE.GUILD_WEEK then
			rankInfo = self.listRankWeekList[index];
		else
			app.log("error toggle type. self.curType:"..tostring(self.curType));
		end
		if rankInfo.ranking <= 3 then
			cont.spRank:set_active(true);
			cont.spRank:set_sprite_name("phb_paiming"..rankInfo.ranking);
			cont.spRankBk:set_active(true);
			cont.spRankBk:set_sprite_name("phb_paiming"..rankInfo.ranking.."_1");
			cont.labRank:set_active(false);
		else
			cont.spRank:set_active(false);
			cont.spRankBk:set_active(false);
			cont.labRank:set_active(true);
			cont.labRank:set_text(tostring(rankInfo.ranking));
		end
		if rankInfo.param3 == 0 then
			cont.labValue:set_text("未击杀")
		else
			local year,month,day = TimeAnalysis.ConvertToYearMonDay(rankInfo.param3);
			cont.labValue:set_text(year.."-"..month.."-"..day)
		end
		local id = bit.bit_and(rankInfo.ranking_num,0xFFFF);
		local lv = bit.bit_rshift(rankInfo.ranking_num,16);
		local cfg = ConfigManager.Get(EConfigIndex.t_guild_boss_monster,id);
		if cfg then
			local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property, cfg.boss_id);
			cont.labInfo:set_text(PublicFunc.GetItemName(monsterCfg.name,lv));
		else
			cont.labInfo:set_text("");
		end
		cont.guild.labName:set_text(rankInfo.name);
		local allnum = bit.bit_and(rankInfo.param2,0xFFFF);
		local maxnum = bit.bit_rshift(rankInfo.param2,16);
		cont.guild.labLv:set_text("[FDE517FF]"..rankInfo.level.."[-]级"..allnum.."/"..maxnum.."人");
	end
end

function GuildBossRankUI:gc_sync_guild_boss_damage_rank_info(rank_info, my_rank, my_damage)
	self.infoDamageRank = rank_info;
	self.nMyDamageRank = my_rank;
	self.nMyDamage = my_damage;
	if self.curType == ERANK_TYPE.DAMAGE then
		self:on_change_damage(true);
	end
end

function GuildBossRankUI:gc_rank(rank_type, my_rank, ranklist)
	if rank_type == _rankType then
		self.infoMyRank = my_rank;
		self.listRankList = ranklist;
		if self.curType == ERANK_TYPE.GUILD then
			self:on_change_guild(true);
		end
	elseif rank_type == _rankWeekType then
		self.infoMyRankWeek = my_rank;
		self.listRankWeekList = ranklist;
		if self.curType == ERANK_TYPE.GUILD_WEEK then
			self:on_change_guild_week(true);
		end
	end
end
