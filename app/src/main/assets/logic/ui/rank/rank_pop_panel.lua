RankPopPanel = Class('RankPopPanel', UiBaseClass);

local _UIText = {
    [1] = "未上榜",
    [2] = "等级",
    [3] = "战队"
}

function RankPopPanel.popPanel(rankDatas,type)
	if rankDatas == nil then 
		rankDatas = {};
		for i = 1,40 do 
			table.insert(rankDatas,RankPopPanel.DataCreator(i,type));
		end
		rankDatas.my_rank = rankDatas[math.random(1,40)];
	else 
		for k,v in pairs(rankDatas) do 
			if v.playerid == nil then 
				v.playerid = v.id;
			end
		end
		if rankDatas.my_rank.playerid == nil then 
			rankDatas.my_rank.playerid = g_dataCenter.player.playerid;
		end
	end
	RankPopPanel.instance = RankPopPanel:new({rankDatas = rankDatas,type = type});
end 

--重新开始
function RankPopPanel:Restart(data)
    --app.log("RankPopPanel:Restart");
    UiBaseClass.Restart(self, data);
	self.rankDatas = data.rankDatas;
	self.type = data.type;
	RankPopPanel.curType = self.type;
end

function RankPopPanel:InitData(data)
    --app.log("RankPopPanel:InitData");
    UiBaseClass.InitData(self, data);
	self.rankDatas = data.rankDatas;
	self.type = data.type;
	RankPopPanel.curType = self.type;
end

function RankPopPanel:RegistFunc()
	--app.log("RankPopPanel:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_click_close_btn'] = Utility.bind_callback(self, self.on_click_close_btn);
	self.bindfunc['on_rank_data_get'] = Utility.bind_callback(self, self.on_rank_data_get);
	self.bindfunc['on_click_first_button'] = Utility.bind_callback(self, self.on_click_first_button);
	self.bindfunc['init_item'] = Utility.bind_callback(self, self.init_item);
	self.bindfunc['on_click_item'] = Utility.bind_callback(self, self.on_click_item);
end

function RankPopPanel:InitUI(asset_obj)
	--app.log("RankPopPanel:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_name('RankPopPanel');
	--local uiPanel = ngui.find_panel(self.ui,"RankPopPanel");
	--uiPanel:set_depth(3201);
    self.vs = {};
	self.vs.title = ngui.find_label(self.ui,"centre_other/animation/content_di_1004_564/lab_title");	
	self.vs.title2 = ngui.find_label(self.ui,"centre_other/animation/content_di_1004_564/lab_title/lab_title2");
	self.vs.title2:set_text("排行榜");
	self.vs.firstHeadRoom = self.ui:get_child_by_name("centre_other/animation/texture_di/sp_head_di_item");
	self.vs.firstName = ngui.find_label(self.ui,"centre_other/animation/texture_di/lab_name");
	self.vs.firstLevel = ngui.find_label(self.ui,"centre_other/animation/texture_di/lab_level");
	self.vs.firstGuildName = ngui.find_label(self.ui,"centre_other/animation/texture_di/lab_guild");
	self.vs.firstGuildTexture = ngui.find_texture(self.ui,"centre_other/animation/texture_di/texture_guild");
	self.vs.btnLookFirst = ngui.find_button(self.ui,"centre_other/animation/texture_di/btn");
	local labBtn = ngui.find_label(self.ui,"centre_other/animation/texture_di/btn/animation/lab");
	labBtn:set_text("查 看");
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['on_click_close_btn'])
	self.vs.btnLookFirst:set_on_click(self.bindfunc['on_click_first_button']);

    local conPath = "centre_other/animation/content_di/"
    self.vs.selfBg = ngui.find_sprite(self.ui, "centre_other/animation/content_di");
    --self.vs.selfBg:set_sprite_name("phb_liebiao_zj")

    self.vs.selfInfoNumRankBg = self.ui:get_child_by_name(conPath .. "sp_bb");
	self.vs.selfInfoNumRank = ngui.find_label(self.ui, conPath .. "sp_bb/lab_rank");
	self.vs.selfInfoFirstRank = ngui.find_sprite(self.ui, conPath .. "sp_bk");
    self.vs.selfInfoFirstRankNumber = ngui.find_sprite(self.ui, conPath .. "sp_bk/sp_rank");

	self.vs.selfName = ngui.find_label(self.ui, conPath  .. "cont_zhandui/lab");
	self.vs.selfChenghao = ngui.find_label(self.ui, conPath .. "cont_zhandui/lab_chenghao");
    self.vs.selfVip = ngui.find_label(self.ui, conPath  .. "cont_zhandui/sp_v");
	--self.vs.selfVipLab = ngui.find_label(self.ui, conPath .. "cont_zhandui/sp_v/lab_vip");
	self.vs.selfVip:set_active(false);
	self.vs.selfScore = ngui.find_label(self.ui, conPath .. "lab_jifen");
	self.vs.selfNum = ngui.find_label(self.ui, conPath .. "lab_num");

	self.vs.selfTexture = ngui.find_texture(self.ui, conPath .. "cont_shetuan/Texture");
	self.vs.selfGuildName = ngui.find_label(self.ui, conPath .. "cont_shetuan/lab");
	self.vs.selfGuildLevel = ngui.find_label(self.ui, conPath .. "cont_shetuan/lab_level");

	--self.vs.selfGuildLeaderName = ngui.find_label(self.ui,"centre_other/animation/content/sp_di/container2/lab_zhandui_name");
	--self.vs.selfGuildLeaderVip = ngui.find_sprite(self.ui,"centre_other/animation/content/sp_di/container2/sp_art_font");
	--self.vs.selfGuildLeaderVipNum = ngui.find_label(self.ui,"centre_other/animation/content/sp_di/container2/sp_art_font/lab_num");

	self.vs.scrollView = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view/panel_list");
	self.vs.wrapContent = ngui.find_wrap_content(self.ui,"centre_other/animation/scroll_view/panel_list/wrap_content");
	self.vs.title1 = ngui.find_label(self.ui,"centre_other/animation/cont_title/txt1");
	self.vs.title2 = ngui.find_label(self.ui,"centre_other/animation/cont_title/txt2");
	self.t2px,self.t2py = self.vs.title2:get_position();
	self.vs.title3 = ngui.find_label(self.ui,"centre_other/animation/cont_title/txt3");
	self.vs.title4 = ngui.find_label(self.ui,"centre_other/animation/cont_title/txt4");
	local title5 = ngui.find_label(self.ui,"centre_other/animation/cont_title/txt5");
	if title5 ~= nil then 
		title5:set_active(false);
	end 
	self.vs.scrollView:reset_position();
	self.vs.wrapContent:set_on_initialize_item(self.bindfunc["init_item"]);
	self.vs.wrapContent:reset();
	self.vs.btnLookFirst:set_active(false); 
	if self.rankDatas ~= nil then 
		self:UpdateUi();
	end 
end

function RankPopPanel:init_item(obj,b,real_id)
	local index = math.abs(real_id)+1;
	local data = self.rankDatas[index];
	if data == nil then 
		do return end;
	end
	self.rankItemList = self.rankItemList or {};
	local pid = obj:get_instance_id();
	self.rankItemList[pid] = self.rankItemList[pid] or self["createRankListItem"..RANK_TYPE_NAME[self.type]](self,obj);
	local rankItem = self.rankItemList[pid];
	if data == nil then 
		return;
	end
	rankItem:setData(data,index); 
end 

--[[创建远征试炼排行榜循环列表对象]]
function RankPopPanel:createRankListItemTRIAL(obj)
	local rankItem = {};
	rankItem.touchSp = ngui.find_sprite(obj, obj:get_name());
	rankItem.touchSp:set_on_ngui_click(self.bindfunc['on_click_item']);
    rankItem.infoNumRankBg = obj:get_child_by_name("sp_bb");
	rankItem.infoNumRank = ngui.find_label(obj, "sp_bb/lab_rank");

	rankItem.infoFirstRank = ngui.find_sprite(obj,"sp_bk");
    rankItem.infoFirstRankNumber = ngui.find_sprite(obj,"sp_bk/sp_rank");

	--rankItem.infoNoRank = ngui.find_sprite(obj,"cont1/sp_art_font2");
	--rankItem.infoNoRank:set_active(false);
	rankItem.container1 = obj:get_child_by_name("cont_zhandui");
	rankItem.container2 = obj:get_child_by_name("cont_shetuan");
	rankItem.labName = ngui.find_label(obj,"cont_zhandui/lab");
	rankItem.vip = ngui.find_label(obj,"cont_zhandui/sp_v");
	--rankItem.vipLab = ngui.find_label(obj,"cont_zhandui/sp_v/lab_vip")
	rankItem.labChenghao = ngui.find_label(obj,"cont_zhandui/lab_chenghao");

	rankItem.labScore = ngui.find_label(obj,"lab_jifen");
	rankItem.labNum = ngui.find_label(obj,"lab_num");
	rankItem.labChenghao:set_active(false);
	rankItem.container2:set_active(false);
	--rankItem.headRoom = UiPlayerHead:new({parent = rankItem.touchSp:get_game_object(),initPos = {-210,0,0}})
	function rankItem:setData(data,index)
		self.data = data;
		self.touchSp:set_name(tostring(index));
		--app.log("RankData:"..table.tostring(data));
		RankPopPanel.initRankItemRanking(self,self.data.ranking);
		if data.param2 == nil or data.param2 == 0 then 
			self.vip:set_active(false);
		else 
			self.vip:set_active(false);
			--PublicFunc.SetImageVipLevel(self.vip, data.param2);
		end
		if data.guildName == nil then 
			data.guildName = data.addition_name;
		end 
		if data.guildName ~= nil then 
			self.labChenghao:set_active(true);
			if data.guildName == "" then 
				self.labChenghao:set_text("[1FA9DFFF]未加入社团");
			else 
				self.labChenghao:set_text("[1FA9DFFF]"..data.guildName);
			end 
		else
			self.labChenghao:set_active(false);
		end 
		self.labName:set_text(data.name);
		self.labScore:set_text(tostring(data.score));
		self.labNum:set_text(tostring(data.num));
		--[[if RankPopPanel.curType == RANK_TYPE.VS3TO3 then 
			if type(data.iconsid) == "table" then 
				if data.iconsid[1] ~= nil then 
					self.headRoom:Show();
					self.headRoom:SetRoleId(data.iconsid[1]);
				else 
					self.headRoom:Hide();
				end
			else 
				if tonumber(data.iconsid) ~= nil then 
					self.headRoom:Show();
					self.headRoom:SetRoleId(data.iconsid);
				else 
					self.headRoom:Hide();
				end
			end
		else 
			self.headRoom:Hide();
		end--]]
	end
	return rankItem;
end 

function RankPopPanel:on_click_item(name, x, y, go_obj)
	local index = tonumber(name);
	if self.rankDatas[index] then
		if self.type == RANK_TYPE.GUILDBOSS then 
			if self.rankDatas[index].search_id then 
				OtherGuildPanel.ShowGuildbyId(self.rankDatas[index].search_id,self.rankDatas[index].ranking);
			else
				FloatTip.Float("无法获取到社团信息");
			end
		else  
			OtherPlayerPanel.ShowPlayer(self.rankDatas[index].playerid,true);
		end 
	end
end 
--[[创建3VS3排行榜循环列表对象]]
function RankPopPanel:createRankListItemVS3TO3(obj)
	return self:createRankListItemTRIAL(obj);
end 
--[[创建极限挑战排行榜循环列表对象]]
function RankPopPanel:createRankListItemKUIKULIYA(obj)
	local rankItem = {};
	rankItem.touchSp = ngui.find_sprite(obj, obj:get_name());
	rankItem.touchSp:set_on_ngui_click(self.bindfunc['on_click_item']);
    rankItem.infoNumRankBg = obj:get_child_by_name("sp_bb");
	rankItem.infoNumRank = ngui.find_label(obj, "sp_bb/lab_rank");

	rankItem.infoFirstRank = ngui.find_sprite(obj,"sp_bk");
    rankItem.infoFirstRankNumber = ngui.find_sprite(obj,"sp_bk/sp_rank");

	--rankItem.infoNoRank = ngui.find_sprite(obj,"cont1/sp_art_font2");
	--rankItem.infoNoRank:set_active(false);
	rankItem.container1 = obj:get_child_by_name("cont_zhandui");
	rankItem.container2 = obj:get_child_by_name("cont_shetuan");
    rankItem.labName = ngui.find_label(obj,"cont_zhandui/lab");
	rankItem.vip = ngui.find_label(obj,"cont_zhandui/sp_v");
	if rankItem.vip ~= nil then 
		rankItem.vip:set_active(false);
	end 
	--rankItem.vipLab = ngui.find_label(obj,"cont_zhandui/sp_v/lab_vip")
	rankItem.labChenghao = ngui.find_label(obj,"cont_zhandui/lab_chenghao");

	rankItem.labScore = ngui.find_label(obj,"lab_jifen");
	rankItem.labScore:set_active(false);
	rankItem.labNum = ngui.find_label(obj,"lab_num");
	rankItem.labChenghao:set_active(false);
	rankItem.container2:set_active(false);
	--rankItem.headRoom = UiPlayerHead:new({parent = rankItem.touchSp:get_game_object(),initPos = {110,0,0}})
	function rankItem:setData(data,index)
		self.data = data;
		self.touchSp:set_name(tostring(index));
		--app.log("RankData:"..table.tostring(data));
		RankPopPanel.initRankItemRanking(self,self.data.ranking);
		if data.param2 == nil or data.param2 == 0 then 
			self.vip:set_active(false);
		else 
			self.vip:set_active(false);
			--PublicFunc.SetImageVipLevel(self.vip, data.param2);
		end
		if data.guildName == nil then 
			data.guildName = data.addition_name;
		end 
		if data.guildName ~= nil then 
			self.labChenghao:set_active(true);
			if data.guildName == "" then 
				self.labChenghao:set_text("[1FA9DFFF]未加入社团");
			else 
				self.labChenghao:set_text("[1FA9DFFF]"..data.guildName);
			end 
		else 
			self.labChenghao:set_active(false)
		end 
		self.labName:set_text(data.name);
		self.labNum:set_text(tostring(data.num or data.ranking_num));
		--[[if type(data.iconsid) == "table" then 
			if data.iconsid[1] ~= nil then 
				self.headRoom:Show();
				self.headRoom:SetRoleId(data.iconsid[1]);
			else 
				self.headRoom:Hide();
			end
		else 
			if tonumber(data.iconsid) ~= nil then 
				self.headRoom:Show();
				self.headRoom:SetRoleId(data.iconsid);
			else 
				self.headRoom:Hide();
			end
		end --]]
	end
	return rankItem;
end 

function RankPopPanel:createRankListItemWORLDBOSS(obj)
	return self:createRankListItemKUIKULIYA(obj);
end 

function RankPopPanel:createRankListItemWORSHIP(obj)
	return self:createRankListItemKUIKULIYA(obj);
end 

function RankPopPanel:createRankListItemARENA(obj)
	return self:createRankListItemKUIKULIYA(obj);
end 

function RankPopPanel:createRankListItemGUILDBOSS(obj)
	local rankItem = {};
	rankItem.touchSp = ngui.find_sprite(obj, obj:get_name());
	rankItem.touchSp:set_on_ngui_click(self.bindfunc['on_click_item']);
    rankItem.infoNumRankBg = obj:get_child_by_name("sp_bb");
	rankItem.infoNumRank = ngui.find_label(obj, "sp_bb/lab_rank");

	rankItem.infoFirstRank = ngui.find_sprite(obj,"sp_bk");
    rankItem.infoFirstRankNumber = ngui.find_sprite(obj,"sp_bk/sp_rank");

	--rankItem.infoNoRank = ngui.find_sprite(obj,"cont1/sp_art_font2");
	--rankItem.infoNoRank:set_active(false);
	rankItem.container1 = obj:get_child_by_name("cont_zhandui");
	rankItem.container2 = obj:get_child_by_name("cont_shetuan");
	rankItem.texture = ngui.find_texture(obj,"cont_shetuan/Texture");
	rankItem.guildName = ngui.find_label(obj,"cont_shetuan/lab");
	rankItem.guildLevel = ngui.find_label(obj,"cont_shetuan/lab_level");
	--rankItem.leaderName = ngui.find_label(obj,"cont_shetuan/lab_zhandui_name");
	--rankItem.leaderVip = ngui.find_sprite(obj,"cont_shetuan/sp_art_font");
	--rankItem.leaderVipNum = ngui.find_label(obj,"cont_shetuan/sp_art_font/lab_num");
	--rankItem.leaderVip:set_active(false);
	rankItem.labScore = ngui.find_label(obj,"lab_jifen");
	rankItem.labNum = ngui.find_label(obj,"lab_num");
	rankItem.container1:set_active(false);
	function rankItem:setData(data,index)
		self.data = data;
		self.touchSp:set_name(tostring(index));
		--app.log("RankData:"..table.tostring(data));
		RankPopPanel.initRankItemRanking(self,self.data.ranking);
		self.guildName:set_text("[1FA9DFFF]"..data.guild_name);
		self.labScore:set_text("");
		self.labNum:set_text(tostring(data.boss_level));
		self.guildLevel:set_text(_UIText[2] .. tostring(data.level));
		local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,self.data.iconsid).icon;
		self.texture:set_texture(iconPath);

		--[[if data.leaderName ~= nil then 
			self.leaderName:set_text(data.leaderName);
			if self.leaderVip and self.leaderVip > 0 then 
				self.leaderVip:set_active(true);
				self.leaderVipNum:set_text(tostring(data.leaderVip));
			else
				self.leaderVip:set_active(false);
			end
		else
			self.leaderName:set_active(false);
			self.leaderVip:set_active(false);
		end]]
	end
	return rankItem;
end 

function RankPopPanel.initRankItemRanking(rankItem, rankNum)
	if rankNum == nil or rankNum == 0 or rankNum > 2000 then 
		rankItem.infoNumRankBg:set_active(false);
		rankItem.infoFirstRank:set_active(false);
        rankItem.touchSp:set_sprite_name("ty_liebiaokuang3")
		do return end;
	end 
	if rankNum == 1 then 
		rankItem.infoNumRankBg:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming1_1")
        rankItem.infoFirstRankNumber:set_sprite_name("phb_paiming1")
        rankItem.touchSp:set_sprite_name("ty_liebiaokuang3")
	elseif rankNum == 2 then 
		rankItem.infoNumRankBg:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming2_1")
        rankItem.infoFirstRankNumber:set_sprite_name("phb_paiming2")
        rankItem.touchSp:set_sprite_name("ty_liebiaokuang3")
	elseif rankNum == 3 then 
		rankItem.infoNumRankBg:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming3_1")
        rankItem.infoFirstRankNumber:set_sprite_name("phb_paiming3")
        rankItem.touchSp:set_sprite_name("ty_liebiaokuang3")
	else
		rankItem.infoFirstRank:set_active(false);
		rankItem.infoNumRankBg:set_active(true);
		rankItem.infoNumRank:set_text(tostring(rankNum));
        rankItem.touchSp:set_sprite_name("ty_liebiaokuang3")
	end
end 

function RankPopPanel:on_click_close_btn()
	self:Hide();
	self:DestroyUi();
end 

function RankPopPanel.DataCreator(index,type) 
	if index > 2001 then 
		do return end 
	end
	local allHead = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
	local allHeadList = {};
	for k,v in pairs(allHead) do
		table.insert(allHeadList,v.number);
	end 
	local len = #allHeadList;
	if type == RANK_TYPE.TRIAL then 
		local data = {
			ranking = index;
			playerid = math.random(10000,99999);
			name = tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
			score = 40-index;
			num = 24;
			param2 = math.random(0,8);
			level = 100-math.floor(index/2);
			iconsid = allHeadList[math.random(1,len)];
		}
		return data;
	elseif type == RANK_TYPE.VS3TO3 then 
		local data = {
			ranking = index;
			playerid = math.random(10000,99999);
			name = tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
			score = 40-index;
			num = 999 - index*5 + math.random(0,4);
			param2 = math.random(0,8);
			level = 100-math.floor(index/2);
			iconsid = allHeadList[math.random(1,len)];
		}
		return data;
	elseif type == RANK_TYPE.KUIKULIYA then 
		local data = {
			ranking = index;
			playerid = math.random(10000,99999);
			name = tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
			--score = 40-index;
			num = 999 - index*5 + math.random(0,4);
			param2 = math.random(0,8);
			level = 100-math.floor(index/2);
			iconsid = allHeadList[math.random(1,len)];
		}
		return data;
	elseif type == RANK_TYPE.WORSHIP then 
		local data = {
			ranking = index;
			playerid = math.random(10000,99999);
			name = tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
			--score = 40-index;
			num = 999 - index*5 + math.random(0,4);
			param2 = math.random(0,8);
			level = 100-math.floor(index/2);
			iconsid = allHeadList[math.random(1,len)];
		}
		return data;
	end
end 

function RankPopPanel:on_rank_data_get(rankDatas)
	--self.rankDatas = rankDatas;
	--self:UpdateUi();
end 

function RankPopPanel:UpdateUi()
	self.vs.title:set_text(RANK_NAME[self.type]);
	self.vs.wrapContent:set_min_index(-#self.rankDatas + 1)
    self.vs.wrapContent:set_max_index(0)
    self.vs.wrapContent:reset() 
	self.vs.scrollView:reset_position();
	local firstData = self.rankDatas[1];
	if firstData == nil then 
		self.vs.firstGuildName:set_text("");
		self.vs.firstHead = UiPlayerHead:new({parent = self.vs.firstHeadRoom})
		self.vs.firstName:set_text("");
		self.vs.firstLevel:set_text("");
		self.vs.selfName:set_text("");
		self.vs.selfScore:set_text("");
		self.vs.selfNum:set_text("");
        self.vs.title2:set_text(_UIText[3]);
		if self.type == RANK_TYPE.TRIAL then 
			self.vs.title3:set_text("积分");
			self.vs.title4:set_text("关卡数");
		elseif self.type == RANK_TYPE.VS3TO3 then 
			self.vs.title3:set_text("积分");
			self.vs.title4:set_text("击杀数");
		elseif self.type == RANK_TYPE.KUIKULIYA then 
			self.vs.title3:set_text("");
			self.vs.title4:set_text("最高层数");
		elseif self.type == RANK_TYPE.GUILDBOSS then 
			self.vs.title2:set_text("社团");
			self.vs.title3:set_text("");
			self.vs.title4:set_text("BOSS等级");
		elseif self.type == RANK_TYPE.WORLDBOSS then 
			self.vs.title2:set_text("战队");
			self.vs.title3:set_text("");
			self.vs.title4:set_text("伤害");
		end 
		return
	end 
	self.firstData = firstData;
	self.firstData.id = self.firstData.id or self.firstData.playerid;
	if self.firstData ~= nil and self.firstData.id ~= nil and g_dataCenter.player.playerid ~= self.firstData.id then 
		self.vs.btnLookFirst:set_active(true);
	else
		self.vs.btnLookFirst:set_active(false); 
	end 
	local my_rank = self.rankDatas.my_rank;
	self:SetSelfRankNum(my_rank.ranking);
	if self.type == RANK_TYPE.GUILDBOSS then 
		self.vs.firstGuildTexture:set_active(true);
		self.vs.firstHeadRoom:set_active(false);
		local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,self.firstData.iconsid).icon;
		self.vs.firstGuildTexture:set_texture(iconPath);
		self.vs.firstName:set_text("社团 [1BA8E5FF]"..self.firstData.guild_name);
		self.vs.firstLevel:set_text(_UIText[2] .. tostring(self.firstData.level));
		self.vs.firstGuildName:set_text("Boss等级[E6B341FF]"..self.firstData.boss_level);
	else 
		self.vs.firstGuildTexture:set_active(false);
		self.vs.firstHeadRoom:set_active(true);
		local guildName = "";
		if firstData.guildName == nil then 
			if firstData.addition_name == nil then 
				guildName = "未加入社团";
			else 
				guildName = firstData.addition_name;
			end
		else 
			guildName = firstData.guildName;
		end 
		if guildName == "" then 
			guildName = "未加入社团";
		end 
		self.vs.firstGuildName:set_text("社团 [1BA8E5FF]"..guildName);
		if type(firstData.iconsid) == "table" then 
			firstData.iconsid = firstData.iconsid[1];
		end 
		self.vs.firstHead = UiPlayerHead:new({parent = self.vs.firstHeadRoom,roleId = firstData.iconsid})
		self.vs.firstName:set_text(firstData.name);
		self.vs.firstLevel:set_text(_UIText[2] .. "[E6B341FF]"..tostring(firstData.level));
	end 
	
	self.vs.selfChenghao:set_active(false);
	if my_rank.param2 == nil or my_rank.param2 == 0 then 
		self.vs.selfVip:set_active(false);
	else
		self.vs.selfVip:set_active(false);
		--PublicFunc.SetImageVipLevel(self.vs.selfVip, my_rank.param2);
	end 
	if my_rank.guildName == nil then 
		my_rank.guildName = my_rank.addition_name;
	end 
	if my_rank.guildName ~= nil then 
		self.vs.selfChenghao:set_active(true);
		if my_rank.guildName == "" then 
			self.vs.selfChenghao:set_text("[1FA9DFFF]未加入社团");
		else 
			self.vs.selfChenghao:set_text("[1FA9DFFF]"..my_rank.guildName);
		end 
	else 
		self.vs.selfChenghao:set_active(true);
		self.vs.selfChenghao:set_text("[1FA9DFFF]未加入社团");
	end 
	--self.vs.myInfoBg = ngui.find_sprite(self.ui,"centre_other/animation/content/sp_di")
	--self.vs.myHead = UiPlayerHead:new({parent = self.vs.myInfoBg:get_game_object(),initPos = {110,0,0}});
	self.vs.container1 = self.ui:get_child_by_name("centre_other/animation/content_di/cont_zhandui");
	self.vs.container2 = self.ui:get_child_by_name("centre_other/animation/content_di/cont_shetuan");
    self.vs.title2:set_text(_UIText[3]);
    self.vs.container1:set_active(false);
	self.vs.container2:set_active(false);

	if self.type == RANK_TYPE.TRIAL then 
		self.vs.container1:set_active(true);
		self.vs.title3:set_text("积分");
		self.vs.title4:set_text("关卡数");
		self.vs.selfName:set_text(my_rank.name);
		self.vs.selfScore:set_text(tostring(my_rank.score));
		self.vs.selfNum:set_text(tostring(my_rank.num or my_rank.ranking_num));
		self.vs.selfScore:set_active(true);
		--self.vs.myHead:Hide();
	elseif self.type == RANK_TYPE.VS3TO3 then 
        self.vs.container1:set_active(true);
		self.vs.title3:set_text("积分");
		self.vs.title4:set_text("击杀数");
		self.vs.selfName:set_text(my_rank.name);
		self.vs.selfScore:set_text(tostring(my_rank.score));
		self.vs.selfScore:set_active(true);
		self.vs.selfNum:set_text(tostring(my_rank.num or my_rank.ranking_num));
		--[[if type(my_rank.iconsid) == "table" then 
			if my_rank.iconsid[1] ~= nil then 
				self.vs.myHead:SetRoleId(my_rank.iconsid[1])
			else 
				self.vs.myHead:Hide();
			end 
		else 
			if my_rank.iconsid ~= nil then 
				self.vs.myHead:SetRoleId(my_rank.iconsid)
			else 
				self.vs.myHead:Hide();
			end 
		end --]]
	elseif self.type == RANK_TYPE.KUIKULIYA then 
        self.vs.container1:set_active(true);
		self.vs.title3:set_text("");
		self.vs.title4:set_text("最高层数");
		self.vs.selfScore:set_active(false);
		self.vs.selfName:set_text(my_rank.name);
		self.vs.selfNum:set_text(tostring(my_rank.num or my_rank.ranking_num));
		--[[if type(my_rank.iconsid) == "table" then 
			if my_rank.iconsid[1] ~= nil then 
				self.vs.myHead:SetRoleId(my_rank.iconsid[1])
			else 
				self.vs.myHead:Hide();
			end 
		else 
			if my_rank.iconsid ~= nil then 
				self.vs.myHead:SetRoleId(my_rank.iconsid)
			else 
				self.vs.myHead:Hide();
			end 
		end --]]
	elseif self.type == RANK_TYPE.WORSHIP then 
        self.vs.container1:set_active(true);
		self.vs.title3:set_text("");
		self.vs.title4:set_text("被膜拜次数");
		self.vs.selfScore:set_active(false);
		self.vs.selfName:set_text(my_rank.name);
		self.vs.selfNum:set_text(tostring(my_rank.num or my_rank.ranking_num));
		--self.vs.myHead:Hide();
	elseif self.type == RANK_TYPE.GUILDBOSS then 
		self.vs.title2:set_text("社团");
		self.vs.title3:set_text("");
		self.vs.title4:set_text("BOSS等级");
		self.vs.container2:set_active(true);
        self.vs.selfScore:set_active(false);
		--self.vs.myHead:Hide();
		self.vs.selfGuildName:set_text("[1FA9DFFF]"..my_rank.guild_name);
		self.vs.selfGuildLevel:set_text(_UIText[2] .. tostring(my_rank.level));
		self.vs.selfNum:set_text(tostring(my_rank.boss_level));
		local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,my_rank.iconsid).icon;
		self.vs.selfTexture:set_texture(iconPath);
		--[[if my_rank.leaderName ~= nil then 
			self.leaderName:set_text(my_rank.leaderName);
			if my_rank.leaderVip and my_rank.leaderVip > 0 then 
				self.vs.selfGuildLeaderVip:set_active(true);
				self.vs.selfGuildLeaderVipNum:set_text(tostring(my_rank.leaderVip));
			else
				self.vs.selfGuildLeaderVip:set_active(false);
			end
		else
			self.vs.selfGuildLeaderName:set_active(false);
			self.vs.selfGuildLeaderVip:set_active(false);
		end]]
	elseif self.type == RANK_TYPE.ARENA then 
        self.vs.container1:set_active(true);
		--self.vs.title2:set_position(self.t2px+50,self.t2py,0);
		self.vs.title3:set_text("");
		self.vs.title4:set_text("战斗力");
		self.vs.selfScore:set_active(false);
		self.vs.selfName:set_text(my_rank.name);
		self.vs.selfNum:set_text(tostring(my_rank.num or my_rank.ranking_num));
		--[[if type(my_rank.iconsid) == "table" then 
			if my_rank.iconsid[1] ~= nil then 
				self.vs.myHead:SetRoleId(my_rank.iconsid[1])
			else 
				self.vs.myHead:Hide();
			end 
		else 
			if my_rank.iconsid ~= nil then 
				self.vs.myHead:SetRoleId(my_rank.iconsid)
			else 
				self.vs.myHead:Hide();
			end 
		end --]]
	elseif self.type == RANK_TYPE.WORLDBOSS then 
		self.vs.title2:set_text("战队");
		self.vs.title3:set_text("");
		self.vs.title4:set_text("伤害");
        self.vs.container1:set_active(true);
		self.vs.selfScore:set_active(false);
		self.vs.selfName:set_text(my_rank.name);
		self.vs.selfNum:set_text(tostring(my_rank.num or my_rank.ranking_num));
	end
end 

function RankPopPanel:SetSelfRankNum(rankNum)
	if rankNum == nil or rankNum == 0 or rankNum > 2000 then 
		self.vs.selfInfoNumRankBg:set_active(true);
        self.vs.selfInfoNumRank:set_text(_UIText[1])
		self.vs.selfInfoFirstRank:set_active(false);
	elseif rankNum <= 3 then 
		self.vs.selfInfoNumRankBg:set_active(false); 
		self.vs.selfInfoFirstRank:set_active(true);
		if rankNum == 1 then 
			--self.vs.selfInfoFirstRank:set_sprite_name("ty_liebiaokuang3")
            self.vs.selfInfoFirstRankNumber:set_sprite_name("phb_paiming1")
		elseif rankNum == 2 then 
			--self.vs.selfInfoFirstRank:set_sprite_name("ty_liebiaokuang3")
            self.vs.selfInfoFirstRankNumber:set_sprite_name("phb_paiming2")
		elseif rankNum == 3 then 
			--self.vs.selfInfoFirstRank:set_sprite_name("ty_liebiaokuang3")
            self.vs.selfInfoFirstRankNumber:set_sprite_name("phb_paiming3")
		end
	else
		self.vs.selfInfoNumRankBg:set_active(true);
		self.vs.selfInfoNumRank:set_text(tostring(rankNum));
		self.vs.selfInfoFirstRank:set_active(false);
	end
end 

function RankPopPanel:on_click_first_button()
	if self.type == RANK_TYPE.GUILDBOSS then
		if self.firstData.search_id then 
			OtherGuildPanel.ShowGuildbyId(self.firstData.search_id,1);
		else
			FloatTip.Float("无法获取到社团信息");
		end 
	else 
		if self.firstData.playerid == g_dataCenter.player.playerid then 
			FloatTip.Float("冠军就是你！");
			do return end;
		end
		OtherPlayerPanel.ShowPlayer(self.firstData.playerid,true);
	end 
end 

function RankPopPanel:on_btn_close_click()
	--app.log("RankPopPanel:Hide()");
	self:Hide();
	self:DestroyUi();
end

function RankPopPanel:Init(data)
	--app.log("RankPopPanel:Init");
    self.pathRes = "assetbundles/prefabs/ui/rank/ui_405_rank.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function RankPopPanel:DestroyUi()
	--app.log("RankPopPanel:DestroyUi");
	RankPopPanel.instance = nil;
	self.rankDatas = nil;
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function RankPopPanel:Show()
	--app.log("RankPopPanel:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function RankPopPanel:Hide()
	--app.log("RankPopPanel:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function RankPopPanel:MsgRegist()
	--app.log("RankPopPanel:MsgRegist");
    UiBaseClass.MsgRegist(self);
	--PublicFunc.msg_regist(msg_rank.gc_rank,self.bindfunc['on_rank_data_get']);
end

--注销消息分发回调函数
function RankPopPanel:MsgUnRegist()
	--app.log("RankPopPanel:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
	--PublicFunc.msg_unregist(msg_rank.gc_rank,self.bindfunc['on_rank_data_get']);
end
