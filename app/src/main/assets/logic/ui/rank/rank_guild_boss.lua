RankGuildBoss = Class('RankGuildBoss', UiBaseClass);

function RankGuildBoss.popPanel(rankDatas)
	if rankDatas == nil then 
		rankDatas = {};
		for i = 1,40 do 
			table.insert(rankDatas,RankGuildBoss.DataCreator(i));
		end
		rankDatas.my_rank = rankDatas[math.random(1,40)];
	end
	RankGuildBoss.instance = RankGuildBoss:new(rankDatas);
end 

--重新开始
function RankGuildBoss:Restart(data)
    --app.log("RankGuildBoss:Restart");
    UiBaseClass.Restart(self, data);
	self.rankDatas = data;
end

function RankGuildBoss:InitData(data)
    --app.log("RankGuildBoss:InitData");
    UiBaseClass.InitData(self, data);
	self.rankDatas = data;
end

function RankGuildBoss:RegistFunc()
	--app.log("RankGuildBoss:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_click_close_btn'] = Utility.bind_callback(self, self.on_click_close_btn);
	self.bindfunc['on_rank_data_get'] = Utility.bind_callback(self, self.on_rank_data_get);
	self.bindfunc['on_click_first_button'] = Utility.bind_callback(self, self.on_click_first_button);
	self.bindfunc['init_item'] = Utility.bind_callback(self, self.init_item);
end

function RankGuildBoss:InitUI(asset_obj)
	app.log("RankGuildBoss:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_name('RankGuildBoss');
    self.vs = {};
	self.vs.title = ngui.find_label(self.ui,"centre_other/animation/cont_Bg/lbl_title");
	self.vs.firstGuildIcon = ngui.find_texture(self.ui,"centre_other/animation/cont_left/sp_guild_icon");
	self.vs.firstGuildName = ngui.find_label(self.ui,"centre_other/animation/cont_left/lbl_guild_name");
	self.vs.firstGuildLevel = ngui.find_label(self.ui,"centre_other/animation/cont_left/lbl_guild_level");
	self.vs.firstGuildLeader = ngui.find_label(self.ui,"centre_other/animation/cont_left/lbl_guild_master_name");
	self.vs.btnLookFirst = ngui.find_button(self.ui,"centre_other/animation/cont_left/btn");
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_close");
	self.vs.btnClose:set_on_click(self.bindfunc['on_click_close_btn'])
	self.vs.btnLookFirst:set_on_click(self.bindfunc['on_click_first_button']);
	self.vs.selfInfoNumRank = ngui.find_label(self.ui,"centre_other/animation/cont1/cont1/lbl_rank");
	self.vs.selfInfoFirstRank = ngui.find_sprite(self.ui,"centre_other/animation/cont1/cont1/sp_rank_icon");
	self.vs.selfInfoNoRank = ngui.find_sprite(self.ui,"centre_other/animation/cont1/cont1/sp_norl");
	self.vs.myGuildIcon = ngui.find_texture(self.ui,"centre_other/animation/cont1/cont1/sp_guild_icon");
	self.vs.myGuildName = ngui.find_label(self.ui,"centre_other/animation/cont1/cont2/lbl_name");
	self.vs.myGuildLevel = ngui.find_label(self.ui,"centre_other/animation/cont1/cont2/lbl_damage_value");
	self.vs.myGuildBossLevel = ngui.find_label(self.ui,"centre_other/animation/cont1/cont2/lbl_level");
	self.vs.scrollView = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view");
	self.vs.wrapContent = ngui.find_wrap_content(self.ui,"centre_other/animation/scroll_view/wrap_content");
	self.vs.scrollView:reset_position();
	self.vs.wrapContent:set_on_initialize_item(self.bindfunc["init_item"]);
	self.vs.wrapContent:reset();
	if self.rankDatas ~= nil then 
		self:UpdateUi();
	end 
end

function RankGuildBoss:init_item(obj,b,real_id)
	local index = math.abs(real_id)+1;
	local data = self.rankDatas[index];
	if data == nil then 
		do return end;
	end
	self.rankItemList = self.rankItemList or {};
	local pid = obj:get_instance_id();
	self.rankItemList[pid] = self.rankItemList[pid] or self:createRankListItem(obj);
	local rankItem = self.rankItemList[pid];
	if data == nil then 
		return;
	end
	rankItem:setData(data,index); 
end 

function RankGuildBoss:createRankListItem(obj)
	local rankItem = {};
	rankItem.infoBg = ngui.find_sprite(obj,"sp_bg");
	rankItem.infoNumRank = ngui.find_label(obj,"cont1/lbl_rank");
	rankItem.infoFirstRank = ngui.find_sprite(obj,"cont1/sp_rank_icon");
	rankItem.infoSpSelf = ngui.find_sprite(obj,"cont1/sp_self");
	rankItem.guildIcon = ngui.find_texture(obj,"cont1/sp_guild_icon");
	rankItem.guildName = ngui.find_label(obj,"cont2/lbl_name");
	rankItem.guildLevel = ngui.find_label(obj,"cont2/lbl_damage_value");
	rankItem.guildBossLevel = ngui.find_label(obj,"cont2/lbl_level");
	rankItem.my_guild_id = g_dataCenter.guild:GetDetail().id;	--玩家自己的社团id
	function rankItem:setData(data,index)
		if data.id ~= self.my_guild_id then 
			self.infoSpSelf:set_active(false);
		else 
			self.infoSpSelf:set_active(true);
		end
		self.data = data;
		app.log("data : "..table.tostring(data));
		RankGuildBoss.initRankItemRanking(self,self.data.ranking);
		local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,self.data.iconsid).icon;
		self.guildIcon:set_texture(iconPath);
		self.guildName:set_text(self.data.guild_name);
		self.guildLevel:set_text("LV."..tostring(self.data.level));
		self.guildBossLevel:set_text("LV."..tostring(self.data.boss_level));
	end
	return rankItem;
end 

function RankGuildBoss.initRankItemRanking(rankItem,rankNum)
	if rankNum == nil or rankNum == 0 or rankNum > 2000 then 
		rankItem.infoNumRank:set_active(false);
		rankItem.infoFirstRank:set_active(false);
		do return end;
	end 
	if rankNum == 1 then 
		rankItem.infoNumRank:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming1")
	elseif rankNum == 2 then 
		rankItem.infoNumRank:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming2")
	elseif rankNum == 3 then 
		rankItem.infoNumRank:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming3")
	else
		rankItem.infoFirstRank:set_active(false);
		rankItem.infoNumRank:set_active(true);
		rankItem.infoNumRank:set_text(tostring(rankNum));
		rankItem.infoFirstRank:set_sprite_name("phb_paiming4")
	end
end 

function RankGuildBoss:on_click_close_btn()
	self:Hide();
	self:DestroyUi();
end 

function RankGuildBoss.DataCreator(index) 
	if index > 2001 then 
		do return end 
	end
	local data = {
		ranking = index;
		id = math.random(1000,9999);
		guild_name = tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
		boss_level = 40-index;
		leader_name = tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
		level = 1+40-index;
		iconsid = math.random(1,10);
	}
	return data;
end 

function RankGuildBoss:on_rank_data_get(rankDatas)
	--self.rankDatas = rankDatas;
	--self:UpdateUi();
end 

function RankGuildBoss:UpdateUi()
	self.vs.wrapContent:set_min_index(-#self.rankDatas + 1)
    self.vs.wrapContent:set_max_index(0)
    self.vs.wrapContent:reset() 
	self.vs.scrollView:reset_position();
	self.firstData = self.rankDatas[1];
	local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,self.firstData.iconsid).icon;
	self.vs.firstGuildIcon:set_texture(iconPath);
	self.vs.firstGuildLeader:set_text(tostring(self.firstData.leader_name or ""));
	self.vs.firstGuildName:set_text(tostring(self.firstData.guild_name));
	self.vs.firstGuildLevel:set_text("等级："..tostring(self.firstData.level));
	local my_rank = self.rankDatas.my_rank;
	self:SetSelfRankNum(my_rank.ranking);
	local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,my_rank.iconsid).icon;
	self.vs.myGuildIcon:set_texture(iconPath);
	self.vs.myGuildLevel:set_text("等级："..tostring(my_rank.level));
	self.vs.myGuildBossLevel:set_text("等级："..tostring(my_rank.boss_level));
	self.vs.myGuildName:set_text(tostring(my_rank.guild_name));
end 

function RankGuildBoss:SetSelfRankNum(rankNum)
	if rankNum == nil or rankNum == 0 or rankNum > 2000 then 
		self.vs.selfInfoNumRank:set_active(false);
		self.vs.selfInfoFirstRank:set_active(false);
		self.vs.selfInfoNoRank:set_active(true);
	elseif rankNum <= 3 then 
		self.vs.selfInfoNoRank:set_active(false);
		self.vs.selfInfoNumRank:set_active(false); 
		self.vs.selfInfoFirstRank:set_active(true);
		if rankNum == 1 then 
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming1")
		elseif rankNum == 2 then 
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming2")
		elseif rankNum == 3 then 
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming3")
		end
	else
		self.vs.selfInfoNoRank:set_active(false);
		self.vs.selfInfoNumRank:set_active(true);
		self.vs.selfInfoNumRank:set_text(tostring(rankNum));
		self.vs.selfInfoFirstRank:set_active(false);
	end
end 

function RankGuildBoss:on_click_first_button()
	if self.firstData then
		OtherGuildPanel.ShowGuildbyId(self.firstData.search_id,1,0)
	end
end 

function RankGuildBoss:on_btn_close_click()
	app.log("RankGuildBoss:Hide()");
	self:Hide();
	self:DestroyUi();
end

function RankGuildBoss:Init(data)
	app.log("RankGuildBoss:Init");
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2822_guild_boss_rank.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function RankGuildBoss:DestroyUi()
	app.log("RankGuildBoss:DestroyUi");
	RankGuildBoss.instance = nil;
	self.rankDatas = nil;
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function RankGuildBoss:Show()
	app.log("RankGuildBoss:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function RankGuildBoss:Hide()
	app.log("RankGuildBoss:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function RankGuildBoss:MsgRegist()
	app.log("RankGuildBoss:MsgRegist");
    UiBaseClass.MsgRegist(self);
	--PublicFunc.msg_regist(msg_rank.gc_rank,self.bindfunc['on_rank_data_get']);
end

--注销消息分发回调函数
function RankGuildBoss:MsgUnRegist()
	app.log("RankGuildBoss:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
	--PublicFunc.msg_unregist(msg_rank.gc_rank,self.bindfunc['on_rank_data_get']);
end
