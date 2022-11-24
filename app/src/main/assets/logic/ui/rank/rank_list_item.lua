RankListItem = Class("RankListItem", UiBaseClass)

function RankListItem:InitData(data)
    UiBaseClass.InitData(self, data);
	self.ui = data;
	self.instanceID = self.ui:get_instance_id();
	self.vs = {};
end

function RankListItem:Restart(data)
	UiBaseClass.Restart(self,data);
	self:RegistFunc();
	self:InitUI();
end 

function RankListItem:RegistFunc()
    self.bindfunc['on_item_click'] = Utility.bind_callback(self, self.on_item_click);
end

function RankListItem:InitUI()
	self.vs.infoBg = ngui.find_sprite(self.ui, self.ui:get_name());
	self.vs.infoNumRankBg = ngui.find_sprite(self.ui,"sp_bb");
	self.vs.infoNumRank = ngui.find_label(self.ui,"lab_rank");
	self.vs.infoFirstRankBg = ngui.find_sprite(self.ui,"sp_bk");
	self.vs.infoFirstRank = ngui.find_sprite(self.ui,"sp_bk/sp_rank");
	-- self.vs.artFontSelf = ngui.find_sprite(self.ui,"sp_art_font");
	-- self.vs.artFontSelf:set_active(false);
	self.vs.groupPanel = self.ui:get_child_by_name("cont_shetuan");
	self.vs.groupPanel2 = self.ui:get_child_by_name("cont_tuanzhang");
	self.vs.infoPanel = self.ui:get_child_by_name("cont_zhandui");
	self.vs.roleRoom = self.ui:get_child_by_name("big_card_item_80");
	self.vs.name = ngui.find_label(self.ui,"cont_zhandui/lab_chenghao");
	-- self.vs.guildName = ngui.find_label(self.ui,"container1/lab_guild_name");
	self.vs.guildName = ngui.find_label(self.ui, "cont_zhandui/lab");
	self.vs.spVip = ngui.find_label(self.ui,"cont_zhandui/sp_v");
	-- self.vs.vipNum = ngui.find_label(self.ui,"cont_zhandui/sp_v/lab_vip");
	self.vs.spVip:set_active(false);
	-- self.vs.chengHao = ngui.find_label(self.ui,"cont_zhandui/lab");
	self.vs.fightValue = ngui.find_label(self.ui,"lab_num");
	self.vs.groupName = ngui.find_label(self.ui,"cont_shetuan/lab");
	self.vs.groupLevel = ngui.find_label(self.ui,"cont_shetuan/lab_level");
	self.vs.groupLeader = ngui.find_label(self.ui,"cont_tuanzhang/lab");
	self.vs.spVip2 = ngui.find_label(self.ui,"cont_tuanzhang/sp_v");
	-- self.vs.vipNum2 = ngui.find_label(self.ui,"cont_tuanzhang/sp_v/lab_vip");
	self.vs.spVip2:set_active(false);
	-- self.vs.groupIconTexture = ngui.find_texture(self.ui,"cont_shetuan/Texture");
	self.vs.infoBg:set_on_ngui_click(self.bindfunc['on_item_click']);
	self.vs.infoBg2 = ngui.find_sprite(self.ui,"sp_bk")
end

function RankListItem:updateUI()
	if self.data == nil then 
		do return end;
	end 
	self.vs.spVip:set_active(false)
	self.vs.guildName:set_active(false);
	self[RANK_TYPE_NAME[self.type]](self);
	self:SetRankNum(self.data.ranking);
end

function RankListItem:FIGHT()
	self.vs.groupPanel:set_active(false);
	self.vs.groupPanel2:set_active(false);
	self.vs.infoPanel:set_active(true);
	self.vs.roleRoom:set_active(false);
	self.vs.name:set_text(self.data.name);
	-- self.vs.chengHao:set_text("");
	if self.type == RANK_TYPE.LEVEL then 
		self.vs.fightValue:set_color(1,1,0,1);
	else
		self.vs.fightValue:set_color(1,0.5,0.5,1);
	end 
	self.vs.fightValue:set_text(tostring(self.data.ranking_num));
	if self.data.param2 == 0 then 
		if self.vs.spVip then
			self.vs.spVip:set_active(false)
		end
	else 
		-- self.vs.spVip:set_active(true);
		-- PublicFunc.SetImageVipLevel(self.vs.spVip, self.data.param2);
		if self.vs.spVip then
			self.vs.spVip:set_active(false)
		end
	end 

	self.vs.guildName:set_active(true);
	if self.data.addition_name == "" then 
		self.data.addition_name = nil;
	end 
	self.vs.guildName:set_text(self.data.addition_name or "[C0C0C0]未加入社团[-]");
end 

function RankListItem:LEVEL()
	self:FIGHT();
end 

function RankListItem:GROUP()
	self.vs.groupPanel:set_active(true);
	self.vs.groupPanel2:set_active(true);
	self.vs.infoPanel:set_active(false);
	self.vs.roleRoom:set_active(false);
	self.vs.name:set_text(self.data.addition_name);
	-- self.vs.chengHao:set_text("");
	self.vs.fightValue:set_color(1,0.1,0.1,1);
	self.vs.fightValue:set_text(tostring(self.data.ranking_num));
	if self.data.iconsid ~= 0 then 
		local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,self.data.iconsid[1]).icon;
		-- self.vs.groupIconTexture:set_texture(iconPath);
		-- self.vs.groupIconTexture:set_active(true);
	else 
		-- self.vs.groupIconTexture:set_active(false);
	end  
	self.vs.groupLeader:set_text(self.data.addition_name);
	self.vs.groupName:set_text(self.data.name);
	local allnum = bit.bit_and(self.data.param3,0xFFFF);
	local maxnum = bit.bit_rshift(self.data.param3,16);
	self.vs.groupLevel:set_text("[FFFF00FF]"..tostring(self.data.level).."[-]级 "..tostring(allnum).."/"..tostring(maxnum).."人") 
	if self.data.param2 == 0 then 
		if self.vs.spVip2 then
			self.vs.spVip2:set_active(false)
		end
	else 
		if self.vs.spVip2 then
			self.vs.spVip2:set_active(false)
		end
		-- self.vs.spVip2:set_active(true);
		-- PublicFunc.SetImageVipLevel(self.vs.spVip2, self.data.param2);
		-- self.vs.vipNum2:set_text(tostring(self.data.param2));
	end 
	--app.log("allnum / maxnum = "..tostring(allnum).." / "..tostring(maxnum));
	self.vs.guildName:set_active(true);
	if self.data.addition_name == "" then 
		self.data.addition_name = nil;
	end 
	self.vs.guildName:set_text(self.data.addition_name or "[C0C0C0]未加入社团[-]");
end 

function RankListItem:GUILDBOSS()
	self:GROUP();
end 

function RankListItem:ROLE()
	--self.vs.roleRoom:set_local_position(115,0,0);
	self.vs.groupPanel:set_active(false);
	self.vs.groupPanel2:set_active(false);
	self.vs.infoPanel:set_active(true);
	self.vs.roleRoom:set_active(true);
	self.vs.roleRoom:set_local_position(84,-2,0);
	self.vs.name:set_text(self.data.name);
	self.vs.fightValue:set_color(1,0.5,0.5,1);
	-- self.vs.chengHao:set_text("");
	self.vs.fightValue:set_text(tostring(self.data.ranking_num));
	--app.log("当前数据：index = "..tostring(self.index)..",data = \n"..table.tostring(self.data));
	local iconSid = 0;
	if type(self.data.iconsid) == "table" then 
		iconSid = self.data.iconsid[1];
	else 
		iconSid = self.data.iconsid;
	end 
	cf = ConfigHelper.GetRole(iconSid);
	if self.vs.playerHead ~= nil then 
		self.vs.playerHead.ui:set_active(false);
		self.vs.playerHead:DestroyUi();
		self.vs.playerHead = nil;
	end 
	if cf ~= nil then 
		--self.vs.firstHeadRoom:set_sprite_name(cf.small_icon);
		if self.vs.roleCard == nil then 
			self.vs.roleCard = SmallCardUi:new({
				parent = self.vs.roleRoom,
				info = CardHuman:new({number=iconSid,level = self.data.param3}),
				stypes = SmallCardUi.SGroupTyps[5]
			})
		else 
			self.vs.roleCard:SetDataNumber(iconSid);
			self.vs.roleCard:SetLevel(self.data.param3);
		end 
	end 
	if self.data.param2 == 0 then 
		if self.vs.spVip then
			self.vs.spVip:set_active(false)
		end
	else 
		-- self.vs.spVip:set_active(true);
		-- PublicFunc.SetImageVipLevel(self.vs.spVip, self.data.param2);
		if self.vs.spVip then
			self.vs.spVip:set_active(false)
		end
	end 
	self.vs.guildName:set_active(true);
	if self.data.addition_name == "" then 
		self.data.addition_name = nil;
	end 
	self.vs.guildName:set_text(self.data.addition_name or "[C0C0C0]未加入社团[-]");
end 

function RankListItem:ARENA()
	self.vs.groupPanel:set_active(false);
	self.vs.infoPanel:set_active(true);
	self.vs.roleRoom:set_active(false);
	self.vs.name:set_text(self.data.name);
	-- self.vs.chengHao:set_text("");
	self.vs.fightValue:set_text(tostring(self.data.ranking_num));
	self.vs.guildName:set_active(true);
	if self.data.addition_name == "" then 
		self.data.addition_name = nil;
	end 
	self.vs.guildName:set_text(self.data.addition_name or "[C0C0C0]未加入社团[-]");
	-- self.vs.guildName:set_text(self.data.addition_name or "");
	self.vs.roleRoom:set_local_position(-266,0,0);
	local iconSid = 0;
	if type(self.data.iconsid) == "table" then 
		iconSid = self.data.iconsid[1];
	else 
		iconSid = self.data.iconsid;
	end 
	if self.vs.roleCard ~= nil then 
		self.vs.roleCard.ui:set_active(false);
		self.vs.roleCard:DestroyUi();
		self.vs.roleCard = nil;
	end
	if self.vs.playerHead == nil then 
		self.vs.playerHead = UiPlayerHead:new({parent = self.vs.roleRoom , roleId = iconSid});
	else 
		self.vs.playerHead:SetRoleId(iconSid);
	end 
	if self.data.param2 == 0 then 
		if self.vs.spVip then
			self.vs.spVip:set_active(false)
		end
	else 
		-- self.vs.spVip:set_active(true);
		-- PublicFunc.SetImageVipLevel(self.vs.spVip, self.data.param2);
		if self.vs.spVip then
			self.vs.spVip:set_active(false)
		end
	end 
end 

function RankListItem:WORSHIP()
	self:FIGHT();
end 

function RankListItem:HURDLESTAR()
	self:FIGHT();
end 

function RankListItem:SetData(type,index,row,data)
	self.type = type;
	self.data = data;
	if data ~= nil then 
		self.clickData = data.id;
	else 
		self.clickData = nil;
	end
	self.index = index;
	self.row = row;
	self:updateUI();
end 

function RankListItem:on_item_click()
	if self.clickData ~= nil then 
		if self.type == RANK_TYPE.GROUP then 
			OtherGuildPanel.ShowGuildbyId(self.data.id,self.data.ranking,self.data.ranking_num)
		else 
			OtherPlayerPanel.ShowPlayer(self.clickData,ENUM.ETeamType.normal)
		end 
	end 
end 

function RankListItem:SetRankNum(rankNum)
	if rankNum == nil or rankNum == 0 or rankNum > 2000 then 
		-- self.vs.infoNumRankBg:set_active(false);
		self.vs.infoNumRank:set_text("");
		self.vs.infoFirstRankBg:set_active(false);
		do return end;
	end 
	if rankNum == 1 then 
		-- self.vs.infoNumRankBg:set_active(false);
		self.vs.infoNumRank:set_text("");
		self.vs.infoFirstRankBg:set_active(true);
		self.vs.infoFirstRankBg:set_sprite_name("phb_paiming1_1")
		self.vs.infoFirstRank:set_sprite_name("phb_paiming1")
		-- self.vs.infoBg:set_sprite_name("phb_diban1")
	elseif rankNum == 2 then 
		-- self.vs.infoNumRankBg:set_active(false);
		self.vs.infoNumRank:set_text("");
		self.vs.infoFirstRankBg:set_active(true);
		self.vs.infoFirstRankBg:set_sprite_name("phb_paiming2_1")
		self.vs.infoFirstRank:set_sprite_name("phb_paiming2")
		-- self.vs.infoBg:set_sprite_name("phb_diban2")
	elseif rankNum == 3 then 
		-- self.vs.infoNumRankBg:set_active(false);
		self.vs.infoNumRank:set_text("");
		self.vs.infoFirstRankBg:set_active(true);
		self.vs.infoFirstRankBg:set_sprite_name("phb_paiming3_1")
		self.vs.infoFirstRank:set_sprite_name("phb_paiming3")
		-- self.vs.infoBg:set_sprite_name("phb_diban3")
	else
		self.vs.infoFirstRankBg:set_active(false);
		-- self.vs.infoNumRankBg:set_active(true);
		self.vs.infoNumRank:set_text(tostring(rankNum));
		self.vs.infoFirstRank:set_sprite_name("phb_paiming4")
		-- self.vs.infoBg:set_sprite_name("phb_diban4")
	end
end 

--析构函数
function RankListItem:DestroyUi()
	if self.vs.roleCard ~= nil then 
		self.vs.roleCard:DestroyUi();
	end
    self.vs = nil;
	self.data = nil;
	self.ui = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end
