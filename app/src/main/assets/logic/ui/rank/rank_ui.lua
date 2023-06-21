RankUI = Class('RankUI', UiBaseClass);
------------------
-- 该界面资源在guild_boss_rank_ui中也在使用
------------------

local _UIText = {
    [1] = "等级：%s"
}


--重新开始
function RankUI:Restart(data)
    UiBaseClass.Restart(self, data);
	self.startRank = data.startRank;
	self.rankDatas = {};
	if data.rankDatas ~= nil then 
		self.rankDatas[self.startRank] = data.rankDatas;
	end
end

function RankUI:InitData(data)
    UiBaseClass.InitData(self, data);
	self.startRank = data.startRank;
	self.rankDatas = {};
	if data.rankDatas ~= nil then 
		self.rankDatas[self.startRank] = data.rankDatas;
	end
end

function RankUI:RegistFunc()
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_toggle_change'] = Utility.bind_callback(self, self.on_toggle_change);
	self.bindfunc['on_rank_data_get'] = Utility.bind_callback(self, self.on_rank_data_get);
	self.bindfunc['on_click_first_button'] = Utility.bind_callback(self, self.on_click_first_button);
end

function RankUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('RankUI');
    self.vs = {};
	local bg = ngui.find_sprite(self.ui,"center_other/animation/sp_di");
	if bg then
		bg:set_active(true);
	end
	self.vs.topBar = ngui.find_grid(self.ui,"top_other/animation/cont_yeka");
	self.vs.tabPower = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka1");
	self.vs.tabLevel = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka2");
	self.vs.tabGroup = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka5");
	self.vs.tabRole = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka3");
	self.vs.tabHurdleStar = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka4");
	self.vs.tabKill = ngui.find_toggle(self.ui,"top_other/animation/cont_yeka/yeka6");
	self.vs.tabPowerLab = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka1/lab");
	self.vs.tabPowerLab1 = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka1/lab1");
	self.vs.tabLevelLab = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka2/lab");
	self.vs.tabLevelLab1 = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka2/lab1");
	self.vs.tabGroupLab = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka5/lab");
	self.vs.tabGroupLab1 = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka5/lab1");
	self.vs.tabRoleLab = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka3/lab");
	self.vs.tabRoleLab1 = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka3/lab1");
	self.vs.tabHurdleStarLab = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka4/lab");
	self.vs.tabHurdleStarLab1 = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka4/lab1");
	self.vs.tabKillLab = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka6/lab");
	self.vs.tabKillLab1 = ngui.find_label(self.ui,"top_other/animation/cont_yeka/yeka6/lab1");
	self.vs.first = ngui.find_sprite(self.ui,"center_other/animation/texture_di");
	self.vs.firstName = ngui.find_label(self.ui,"center_other/animation/texture_di/lab_name");
	self.vs.firstLevel = ngui.find_label(self.ui,"center_other/animation/texture_di/lab_level");
	self.vs.firstGroupName = ngui.find_label(self.ui,"center_other/animation/texture_di/lab_guild");
	self.vs.firstHeadRoom = self.ui:get_child_by_name("center_other/animation/texture_di/sp_head_di_item");
	self.vs.firstIconTexture = ngui.find_texture(self.ui,"center_other/animation/texture_di/texture_guild");
	self.vs.firstIconTexture:set_active(false);
	self.vs.btnLook = ngui.find_button(self.ui,"center_other/animation/texture_di/btn");
	self.vs.btnLook:set_on_click(self.bindfunc['on_click_first_button']);
	self.vs.tabPower:set_name("FIGHT");
	self.vs.tabLevel:set_name("LEVEL");
	self.vs.tabGroup:set_name("GROUP");
	self.vs.tabRole:set_name("ROLE");
	self.vs.tabHurdleStar:set_name("HURDLESTAR");
	self.vs.tabKill:set_name("KILL");
	self.vs.tabPowerLab:set_text(RANK_NAME[RANK_TYPE.FIGHT])
	self.vs.tabPowerLab1:set_text(RANK_NAME[RANK_TYPE.FIGHT])
	self.vs.tabLevelLab:set_text(RANK_NAME[RANK_TYPE.LEVEL])
	self.vs.tabLevelLab1:set_text(RANK_NAME[RANK_TYPE.LEVEL])
	self.vs.tabGroupLab:set_text(RANK_NAME[RANK_TYPE.GROUP])
	self.vs.tabGroupLab1:set_text(RANK_NAME[RANK_TYPE.GROUP])
	self.vs.tabRoleLab:set_text(RANK_NAME[RANK_TYPE.ROLE])
	self.vs.tabRoleLab1:set_text(RANK_NAME[RANK_TYPE.ROLE])
	self.vs.tabHurdleStarLab:set_text(RANK_NAME[RANK_TYPE.HURDLESTAR])
	self.vs.tabHurdleStarLab1:set_text(RANK_NAME[RANK_TYPE.HURDLESTAR])
	-- self.vs.tabKillLab:set_text(RANK_NAME[RANK_TYPE.KILL])
	-- self.vs.tabKillLab1:set_text(RANK_NAME[RANK_TYPE.KILL])
	self.vs.tabPower:set_on_change(self.bindfunc["on_toggle_change"]);
	self.vs.tabLevel:set_on_change(self.bindfunc["on_toggle_change"]);
	self.vs.tabGroup:set_on_change(self.bindfunc["on_toggle_change"]);
	self.vs.tabRole:set_on_change(self.bindfunc["on_toggle_change"]);
	self.vs.tabHurdleStar:set_on_change(self.bindfunc["on_toggle_change"]);
	self.vs.tabKill:set_on_change(self.bindfunc["on_toggle_change"]);
	if self.startRank ~= nil then 
		if self.startRank == RANK_TYPE.FIGHT then 
			self.vs.tabPower:set_value(true);
			self.vs.tabLevel:set_value(false);
			self.vs.tabGroup:set_value(false);
			self.vs.tabRole:set_value(false);
			self.vs.tabHurdleStar:set_value(false);
		elseif self.startRank == RANK_TYPE.LEVEL then 
			self.vs.tabPower:set_value(false);
			self.vs.tabLevel:set_value(true);
			self.vs.tabGroup:set_value(false);
			self.vs.tabRole:set_value(false);
			self.vs.tabHurdleStar:set_value(false);
		elseif self.startRank == RANK_TYPE.GROUP then 
			self.vs.tabPower:set_value(false);
			self.vs.tabLevel:set_value(false);
			self.vs.tabGroup:set_value(true);
			self.vs.tabRole:set_value(false);
			self.vs.tabHurdleStar:set_value(false);
		elseif self.startRank == RANK_TYPE.ROLE then 
			self.vs.tabPower:set_value(false);
			self.vs.tabLevel:set_value(false);
			self.vs.tabGroup:set_value(false);
			self.vs.tabRole:set_value(true);
			self.vs.tabHurdleStar:set_value(false);
		elseif self.startRank == RANK_TYPE.HURDLESTAR then 
			self.vs.tabPower:set_value(false);
			self.vs.tabLevel:set_value(false);
			self.vs.tabGroup:set_value(false);
			self.vs.tabRole:set_value(false);
			self.vs.tabHurdleStar:set_value(true);
		else 
			self.vs.tabPower:set_value(true);
			self.vs.tabLevel:set_value(false);
			self.vs.tabGroup:set_value(false);
			self.vs.tabRole:set_value(false);
			self.vs.tabHurdleStar:set_value(false);
			self.vs.tabPower:set_name(RANK_TYPE_NAME[self.startRank]);
			self.vs.tabLabel:set_text(RANK_NAME[self.startRank]);
			self.vs.tabLevel:set_active(false);
			self.vs.tabGroup:set_active(false);
			self.vs.tabRole:set_active(false);
			self.vs.tabHurdleStar:set_active(false);
		end
	end
	self.vs.tabKill:set_active(false);
	local spNormal = ngui.find_sprite(self.ui, "top_other/animation/cont_yeka/GROUP/sp");
	local spFocus = ngui.find_sprite(self.ui, "top_other/animation/cont_yeka/GROUP/sp1");
	spNormal:set_sprite_name("ty_anniu7")
	spFocus:set_sprite_name("ty_anniu6")

	self.vs.rankList = RankList:new({obj = self.ui:get_child_by_name("right_other")})
	
	self:UpdateUi();
end

function RankUI:on_toggle_change(value,name)
	if value == true then 
		if self.isFirst ==nil then
            self.isFirst = true;
        else
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
        end
		self.type = RANK_TYPE[name];
		--app.log("RANK_TYPE."..name);
		self:GetRankData();
	end
end 

function RankUI:GetRankData()
	if self.rankDatas == nil then 
		self.rankDatas = {};
	end 
	--app.log("RANKUI "..table.tostring(self.rankDatas[self.type]));
	if self.rankDatas[self.type] ~= nil then 
		local datas = self.rankDatas[self.type];
		if RANK_TYPE_NAME[self.type] ~= nil then 
			PublicFunc.msg_dispatch(RANK_MSG_TYPE,self.type,datas);
		end
	else 
		msg_rank.cg_rank(self.type, 100)
		local datas = {};
		datas.my_rank = self:DataCreator(2001);
		--[[for i = 1,10 do 
			table.insert(datas,self:DataCreator(i));
		end --]]
		if RANK_TYPE_NAME[self.type] ~= nil then 
			PublicFunc.msg_dispatch(RANK_MSG_TYPE,self.type,datas);
		end
	end 
	self:UpdateUi()
end 

function RankUI:DataCreator(index) 
	if index > 2001 then 
		do return end 
	end
	local data = {
		type = self.type;
		ranking = index;
		name = "";--tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
		ranking_num = 0;
		addition_name = "";--tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
		level = 0;
		iconsid = 0;
		--level = 30+math.floor(60/index);
	}
	return data;
end 

function RankUI:on_rank_data_get(rank_type, my_rank, ranklist)
	local datas = ranklist;
	datas.my_rank = my_rank;
	--app.log("datas:"..table.tostring(datas));
	self.rankDatas[rank_type] = datas;
	if self.type ~= rank_type then 
		return; 
	else 
		if RANK_TYPE_NAME[self.type] ~= nil then 
			PublicFunc.msg_dispatch(RANK_MSG_TYPE,self.type,datas);
		end
	end 
	self:UpdateUi();
end 

function RankUI:UpdateUi()
	--app.log("RankUI self.type = "..tostring(self.type));
	if self.rankDatas == nil then 
		self.rankDatas = {};
	end 
	if self.type ~= nil and self.rankDatas[self.type] ~= nil then 
		--app.log("RankUI self.rankDatas["..tostring(self.type).."] = "..tostring(table.tostring(self.rankDatas[self.type])));
		local data = self.rankDatas[self.type][1];
		--local data = self.rankDatas[self.type].my_rank;
		self.vs.btnLook:set_active(false);
		self.vs.btnLook:set_name("btnLook");
		if data == nil then 
			self.vs.firstName:set_text(" ");
			self.vs.firstGroupName:set_text(" ");
			self.vs.firstLevel:set_text(" ");
			self.vs.firstHeadRoom:set_active(false);
			self.vs.firstIconTexture:set_active(false);
			self.clickData = nil;
			do return end;
		end 
		--app.log(table.tostring(data));
		if g_dataCenter.player.playerid ~= data.id then
			--app.log("playid = "..tostring(g_dataCenter.player.playerid).." , data.playerid = "..tostring(data.playerid));
			self.vs.btnLook:set_active(true);
		end 
		self.vs.firstName:set_text(data.name);
		if data.addition_name == '' then 
			data.addition_name = nil;
		end
		self.vs.firstLevel:set_text("等级[E5AC40FF]"..tostring(data.level));
		self[RANK_TYPE_NAME[self.type]](self,data);
		self.clickData = data.id;
		self.clickPower = data.ranking_num;
	else 
		self.vs.firstName:set_text(" ");
		self.vs.firstGroupName:set_text(" ");
		self.vs.firstLevel:set_text(" ");
		self.clickData = nil;
		self.vs.firstHeadRoom:set_active(false);
		self.vs.firstIconTexture:set_active(false);
	end
end 

function RankUI:GROUP(data)
	--app.log("data : "..table.tostring(data));
	local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,data.iconsid[1]).icon;
	--app.log("iconPath = "..tostring(iconPath));
	self.vs.firstIconTexture:set_texture(iconPath);
	self.vs.firstIconTexture:set_active(true);
	self.vs.firstHeadRoom:set_active(false);
	self.vs.firstGroupName:set_text("[3A8FE0FF]"..tostring(data.name or "无").."[-] 等级[E5AC40FF]"..tostring(data.level));
	self.vs.firstName:set_text("社长 "..data.addition_name);
	self.vs.firstLevel:set_text("");
end 

function RankUI:GUILDBOSS(data)
	self:GROUP();
end 

function RankUI:FIGHT(data)
	if data.iconsid[2] ~= nil then 
		if self.vs.head ~= nil then 
			self.vs.head:SetRoleId(data.iconsid[2]);
		else 
			self.vs.head = UiPlayerHead:new({parent = self.vs.firstHeadRoom,roleId = data.iconsid[2]});
		end 
	else 
		if self.vs.head ~= nil then 
			self.vs.head:SetRoleId(data.iconsid[1]);
		else 
			self.vs.head = UiPlayerHead:new({parent = self.vs.firstHeadRoom,roleId = data.iconsid[1]});
		end 
	end 
	self.vs.firstGroupName:set_text("社团：[3A8FE0FF] "..tostring(data.addition_name or "未加入社团"));
	self.vs.firstHeadRoom:set_active(true);
	self.vs.firstIconTexture:set_active(false);
end 

function RankUI:ROLE(data)
	self:FIGHT(data);
end 

function RankUI:LEVEL(data)
	self:FIGHT(data);
end 

function RankUI:GOLD(data)
	self:FIGHT(data);
end 

function RankUI:KILL(data)
	self:FIGHT(data);
end 

function RankUI:ARENA(data)
	self:FIGHT(data);
end 

function RankUI:WORSHIP(data)
	self:FIGHT(data);
end 

function RankUI:HURDLESTAR(data)
	self:FIGHT(data);
end 

function RankUI:on_click_first_button()
	if self.clickData ~= nil then 
		if self.type == RANK_TYPE.GROUP then 
			OtherGuildPanel.ShowGuildbyId(self.clickData,1,self.clickPower)
		else 
			OtherPlayerPanel.ShowPlayer(self.clickData,ENUM.ETeamType.normal);
		end 
	end
end 

function RankUI:on_btn_close_click()
	--app.log("RankUI:Hide()");
	self:Hide();
	self:DestroyUi();
end

function RankUI:Init(data)
	--app.log("RankUI:Init");
    self.pathRes = "assetbundles/prefabs/ui/rank/ui_402_rank.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function RankUI:DestroyUi()
	self.rankDatas = nil;
	if self.vs ~= nil then 
		if self.vs.rankList ~= nil then 
			self.vs.rankList:DestroyUi();
		end 
		self.vs.rankList = nil;
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
end

--显示ui
function RankUI:Show()
    UiBaseClass.Show(self);
end

--隐藏ui
function RankUI:Hide()
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function RankUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_rank.gc_rank,self.bindfunc['on_rank_data_get']);
end

--注销消息分发回调函数
function RankUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_rank.gc_rank,self.bindfunc['on_rank_data_get']);
end