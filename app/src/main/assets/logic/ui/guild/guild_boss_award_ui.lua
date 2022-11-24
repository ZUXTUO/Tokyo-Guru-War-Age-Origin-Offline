GuildBossAwardUI = Class("GuildBossAwardUI", UiBaseClass);
local countAwardNum = 4;

function GuildBossAwardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2822_guild_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function GuildBossAwardUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function GuildBossAwardUI:Restart(data)
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function GuildBossAwardUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_rankItem"] = Utility.bind_callback(self, self.on_init_rankItem);
    self.bindfunc["on_init_guildAwardItem"] = Utility.bind_callback(self, self.on_init_guildAwardItem);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
end

function GuildBossAwardUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("GuildBossAwardUI");

    self.guildAwardCont = {};
    self.guildAwardScroll = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view1/panel_list");
    self.guildAwardWrap = ngui.find_wrap_content(self.ui,"centre_other/animation/scroll_view1/panel_list/wrap_content");
    self.guildAwardWrap:set_on_initialize_item(self.bindfunc["on_init_guildAwardItem"]);
    self.joinAward = {};
    for i=1,countAwardNum do
    	local obj = self.ui:get_child_by_name("centre_other/animation/scroll_view1/panel_list/cont1/cont_prop/new_small_card_item"..i);
    	self.joinAward[i] = UiSmallItem:new({parent=obj});
    end
	self.killAward = {};
    for i=1,countAwardNum do
    	local obj = self.ui:get_child_by_name("centre_other/animation/scroll_view1/panel_list/cont2/cont_prop/new_small_card_item"..i);
    	self.killAward[i] = UiSmallItem:new({parent=obj});
    end

    self.rankCont = {};
    self.rankScroll = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view2/panel_list");
    self.rankWrap = ngui.find_wrap_content(self.ui,"centre_other/animation/scroll_view2/panel_list/wrap_content");
    self.rankWrap:set_on_initialize_item(self.bindfunc["on_init_rankItem"]);

    local btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha");
    btnClose:set_on_click(self.bindfunc["on_close"]);

    self:UpdateUi();
end

function GuildBossAwardUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local killReward = ConfigManager.Get(EConfigIndex.t_guild_boss_monster,1).kill_reward;
    for i=1,countAwardNum do
    	local cfg = killReward[i];
    	if cfg then
    		self.killAward[i]:Show();
    		self.killAward[i]:SetDataNumber(cfg.id, cfg.num);
    	else
    		self.killAward[i]:Hide();
    	end
    end
    local joinReward = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).play_reward;
    for i=1,countAwardNum do
    	local cfg = joinReward[i];
    	if cfg then
    		self.joinAward[i]:Show();
    		self.joinAward[i]:SetDataNumber(cfg.id, cfg.num);
    	else
    		self.joinAward[i]:Hide();
    	end
    end
    local guildAwardList = ConfigManager._GetConfigTable(EConfigIndex.t_guild_boss_damage_rank_reward);
    self.guildAwardWrap:set_min_index(1-#guildAwardList);
    self.guildAwardWrap:set_max_index(0);
    self.guildAwardWrap:reset();
    self.guildAwardScroll:reset_position();

    local rankAwardList = ConfigManager._GetConfigTable(EConfigIndex.t_guild_boss_guild_rank_reward);
    self.rankWrap:set_min_index(1-#rankAwardList);
    self.rankWrap:set_max_index(0);
    self.rankWrap:reset();
	self.rankScroll:reset_position();
end

function GuildBossAwardUI:DestroyUi()
    if self.joinAward then
    	for k,v in pairs(self.joinAward) do
			v:DestroyUi();
    	end
	    self.joinAward = nil;
	end
	if self.killAward then
		for k,v in pairs(self.killAward) do
			v:DestroyUi();
		end
		self.killAward = nil;
	end
	if self.rankCont then
		for k,v in pairs(self.rankCont) do
			for kk,vv in pairs(v.items) do
				vv:DestroyUi();
			end
		end
		self.rankCont = nil;
	end
	if self.guildAwardCont then
		for k,v in pairs(self.guildAwardCont) do
			for kk,vv in pairs(v.items) do
				vv:DestroyUi();
			end
		end
		self.guildAwardCont = nil;
	end
    UiBaseClass.DestroyUi(self);
end

function GuildBossAwardUI:on_init_rankItem(obj, b, real_id)
    local index = math.abs(real_id)+1;
    if Utility.isEmpty(self.rankCont[b]) then
        self.rankCont[b] = self:init_rankItem(obj)
    end
    self:update_rankItem(self.rankCont[b], index);
end

function GuildBossAwardUI:init_rankItem(obj)
    local cont = {}
    cont.labRank = ngui.find_label(obj,"lab_rank");
    cont.spRank = ngui.find_sprite(obj,"sp_rank_icon");
    cont.objSelf = obj:get_child_by_name("sp_ziji");
    cont.objSelf:set_active(false);
    cont.items = {};
    for i=1,countAwardNum do
    	local o = obj:get_child_by_name("grid/small_card_item"..i);
    	cont.items[i] = UiSmallItem:new({parent=o});
    end
    return cont;
end

function GuildBossAwardUI:update_rankItem(cont, index)
	local cfg = ConfigManager.Get(EConfigIndex.t_guild_boss_damage_rank_reward,index);
	if cfg.rank_begin >= 1 and cfg.rank_begin <= 3 then
		cont.spRank:set_active(true);
		cont.spRank:set_sprite_name("phb_paiming"..cfg.rank_begin)
		cont.labRank:set_text("");
	else
		cont.spRank:set_active(false);
		if cfg.rank_begin ~= cfg.rank_end then
            if cfg.rank_end == 9999 then
                cont.labRank:set_text(cfg.rank_begin.."及以后");
            else
                cont.labRank:set_text(cfg.rank_begin.."-"..cfg.rank_end);
            end
		else
			cont.labRank:set_text(tostring(cfg.rank_begin));
		end
	end
	for k=1,countAwardNum do
		if cfg.rank_reward[k] then
			if cont.items[k] then
				cont.items[k]:SetDataNumber(cfg.rank_reward[k].id,cfg.rank_reward[k].num);
				cont.items[k]:Show();
			end
		else
			cont.items[k]:Hide();
		end
	end
end

function GuildBossAwardUI:on_init_guildAwardItem(obj, b, real_id)
    local index = math.abs(real_id)+1;
    if Utility.isEmpty(self.guildAwardCont[b]) then
        self.guildAwardCont[b] = self:init_guildAwardItem(obj)
    end
    self:update_guildAwardItem(self.guildAwardCont[b], index);
end

function GuildBossAwardUI:init_guildAwardItem(obj)
    local cont = {}
    cont.labRank = ngui.find_label(obj,"lbl_rank");
    cont.spRank = ngui.find_sprite(obj,"sp_rank_icon");
    cont.objSelf = obj:get_child_by_name("sp_self");
    cont.objSelf:set_active(false);
    cont.items = {};
    for i=1,countAwardNum do
    	local o = obj:get_child_by_name("cont_prop/new_small_card_item"..i);
    	cont.items[i] = UiSmallItem:new({parent=o});
    end
    return cont;
end

function GuildBossAwardUI:update_guildAwardItem(cont, index)
	local cfg = ConfigManager.Get(EConfigIndex.t_guild_boss_guild_rank_reward,index);
	if cfg.rank_begin >= 1 and cfg.rank_begin <= 3 then
		cont.spRank:set_active(true);
		cont.spRank:set_sprite_name("phb_paiming"..cfg.rank_begin)
		cont.labRank:set_text("");
	else
		cont.spRank:set_active(false);
		if cfg.rank_begin ~= cfg.rank_end then
            if cfg.rank_end == 9999 then
                cont.labRank:set_text(cfg.rank_begin.."及以后");
            else
    			cont.labRank:set_text(cfg.rank_begin.."-"..cfg.rank_end);
            end
		else
			cont.labRank:set_text(tostring(cfg.rank_begin));
		end
	end
	for k=1,countAwardNum do
		if cfg.rank_reward[k] then
			if cont.items[k] then
				cont.items[k]:SetDataNumber(cfg.rank_reward[k].id,cfg.rank_reward[k].num);
				cont.items[k]:Show();
			end
		else
			cont.items[k]:Hide();
		end
	end
end

function GuildBossAwardUI:on_close()
	uiManager:PopUi();
end