RankList = Class('RankList', UiBaseClass);

RankList.tempName = {
	'*我*','饥荒','巨人','神羽','天','地','人','日','月','星','光芒','万丈','圣域','一刀','赌博','明媚','瀑布','地震','机智','极限','挑战','自我','萝莉','巨乳','战士','大将','巨灵','风骚','欧美','无码','白痴','智障','妈的','天赋','异秉','神圣','二娃'
}

local _local = {}
_local.resPath = ""--"assetbundles/prefabs/ui/rank/ui_403_rank.assetbundle" --废弃，已合并到402

_local.UIText = {
	[1] = "战队",
	[2] = "战力",
	[3] = "等级",
	[4] = "社团",
	[5] = "总战力",
	[6] = "社长",
	[7] = "最强角色",
	[8] = "膜拜数",
	[9] = "关卡星数"
}

--重新开始
function RankList:Restart(data)
    --app.log("RankList:Restart");
    UiBaseClass.Restart(self, data);
	self.data = data;
	self.ui = data and data.obj
	self:InitUI();
end

function RankList:InitData(data)
    UiBaseClass.InitData(self, data);
	self.data = data;
	self.type = RANK_TYPE.FIGHT;
end

function RankList:RegistFunc()
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['init_item'] = Utility.bind_callback(self, self.init_item);
	self.bindfunc['on_rank_data_change'] = Utility.bind_callback(self, self.on_rank_data_change);
	self.bindfunc['resetScrollPosition'] = Utility.bind_callback(self, self.resetScrollPosition);
end

function RankList:InitUI(asset_obj)
	-- UiBaseClass.InitUI(self, asset_obj); 
	-- self.ui:set_name('RankList');

	if self.ui == nil then return end

    self.vs = {};
	-- self.vs.outPanel = ngui.find_sprite(self.ui,"cont_top");
	self.vs.titlePM = ngui.find_label(self.ui,"sp_title/txt_paiming");
	self.vs.titleZD = ngui.find_label(self.ui,"sp_title/txt_shetuan");
	self.vs.titleJS = ngui.find_label(self.ui,"sp_title/txt_tuanzhang");
	self.vs.titleZL = ngui.find_label(self.ui,"sp_title/txt_zongzhanli");
	-- self.vs.selfInfoBg = ngui.find_sprite(self.ui,"content/sp_di");
	--self.vs.selfInfoBg2 = ngui.find_sprite(self.ui,"content/sp_bk");
	self.vs.selfInfoBg = ngui.find_sprite(self.ui,"content");
	-- self.vs.selfInfoNumRankBg = ngui.find_sprite(self.ui,"content/sp_bb");
	self.vs.selfInfoNumRank = ngui.find_label(self.ui,"content/lab_rank");
	self.vs.selfInfoNoGuild = ngui.find_label(self.ui,"content/lab_name");
	self.vs.selfInfoFirstRankBg = ngui.find_sprite(self.ui,"content/sp_bk");
	self.vs.selfInfoFirstRank = ngui.find_sprite(self.ui,"content/sp_bk/sp_rank");
	self.vs.selfGroupPanel = self.ui:get_child_by_name("content/cont_shetuan");
	self.vs.selfGroupPanel2 = self.ui:get_child_by_name("content/cont_tuanzhang")
	self.vs.selfInfoPanel = self.ui:get_child_by_name("content/cont_zhandui");
	self.vs.selfRoleRoom = self.ui:get_child_by_name("content/big_card_item_80");
	self.vs.selfName = ngui.find_label(self.ui,"content/cont_zhandui/lab_chenghao");
	-- self.vs.selfGuildName = ngui.find_label(self.ui,"content/container1/lab_guild_name");
	self.vs.selfGuildName = ngui.find_label(self.ui,"content/cont_zhandui/lab");
	self.vs.selfSpVip = ngui.find_label(self.ui,"content/cont_zhandui/sp_v");
	-- self.vs.selfVipNum = ngui.find_label(self.ui,"content/cont_zhandui/sp_v/lab_vip");
	self.vs.selfSpVip:set_active(false);
	-- self.vs.selfChengHao = ngui.find_label(self.ui,"content/cont_zhandui/lab");
	self.vs.selfFightValue = ngui.find_label(self.ui,"content/lab_num");
	self.vs.selfGroupName = ngui.find_label(self.ui,"content/cont_shetuan/lab");
	self.vs.selfGroupLevel = ngui.find_label(self.ui,"content/cont_shetuan/lab_level");
	self.vs.selfGroupLeader = ngui.find_label(self.ui,"content/cont_tuanzhang/lab");
	self.vs.selfSpVip2 = ngui.find_label(self.ui,"content/cont_tuanzhang/sp_v");
	-- self.vs.selfVipNum2 = ngui.find_label(self.ui,"content/cont_tuanzhang/sp_v/lab_vip");
	self.vs.selfSpVip2:set_active(false);
	-- self.vs.selfGroupIconTexture = ngui.find_texture(self.ui,"content/cont_shetuan/Texture");
	self.vs.gridScrollView = ngui.find_scroll_view(self.ui,"scroll_view/panel_list");
	self.vs.wrapContentList = ngui.find_wrap_content(self.ui,"scroll_view/panel_list/wrap_content");
	self.vs.wrapContentList:set_on_initialize_item(self.bindfunc["init_item"]);
	self.vs.wrapContentList:reset();
	if self.datas ~= nil then 
		self:UpdateUi();
	else 
		self.vs.selfGroupPanel:set_active(false);
		self.vs.selfGroupPanel2:set_active(false)
		self.vs.selfName:set_text(""); 
		self.vs.selfGuildName:set_text(""); 
		-- self.vs.selfChengHao:set_text("");
		self.vs.selfFightValue:set_text("");
		self:SetSelfRankNum(9999);
	end
end

function RankList:init_item(obj,b,real_id)
	local index = math.abs(real_id)
    local row = math.abs(b) + 1
	local data = self:getListData(index);
	if data == nil then 
		do return end;
	end
	self.vs.itemList = self.vs.itemList or {}
	local id = obj:get_instance_id()
	if self.vs.itemList[id] == nil then 
		local item = RankListItem:new(obj);
		self.vs.itemList[id] = item;
	end 
	self.vs.itemList[id]:SetData(self.type,index,row,data);
end 

function RankList:on_rank_data_change(type , datas)
	app.log("RankList:on_rank_data_change");
	self.type = type;
	self.datas = datas;
	if self.ui ~= nil then 
		self:UpdateUi();
	end 
end 

function RankList:getListData(index)
	if self.datas ~= nil then 
		return self.datas[index+1];
	end 
end 

function RankList:SetSelfRankNum(rankNum)
	self.vs.selfInfoBg:set_sprite_name("phb_liebiao_zj")
	if rankNum == nil or rankNum == 0 or rankNum > 2000 then 
		-- self.vs.selfInfoNumRankBg:set_active(true);
		self.vs.selfInfoFirstRankBg:set_active(false);
		self.vs.selfInfoNumRank:set_text("未上榜")
	elseif rankNum <= 3 then 
		self.vs.selfInfoNumRank:set_text("")
		self.vs.selfInfoFirstRankBg:set_active(true);
		if rankNum == 1 then 
			self.vs.selfInfoFirstRankBg:set_sprite_name("phb_paiming1_1")
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming1")
			--self.vs.selfInfoBg:set_sprite_name("phb_diban1")
		elseif rankNum == 2 then 
			self.vs.selfInfoFirstRankBg:set_sprite_name("phb_paiming2_1")
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming2")
			--self.vs.selfInfoBg:set_sprite_name("phb_diban2")
		elseif rankNum == 3 then 
			self.vs.selfInfoFirstRankBg:set_sprite_name("phb_paiming3_1")
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming3")
			--self.vs.selfInfoBg:set_sprite_name("phb_diban3")
		end
	else
		-- self.vs.selfInfoNumRankBg:set_active(true);
		self.vs.selfInfoNumRank:set_text(tostring(rankNum));
		self.vs.selfInfoFirstRankBg:set_active(false);
	end
end 

function RankList:resetScrollPosition()
	if self.vs ~= nil then 
		self.vs.gridScrollView:reset_position();
	end
end 

function RankList:UpdateUi()
	self.vs.wrapContentList:set_min_index(-#self.datas + 1)
    self.vs.wrapContentList:set_max_index(0)
    self.vs.wrapContentList:reset() 
	self.vs.gridScrollView:reset_position();
	timer.create(self.bindfunc['resetScrollPosition'],100,1);
	local mydata = self.datas.my_rank;
	if self.type ~= RANK_TYPE.GROUP then 
		if g_dataCenter.guild.detail ~= nil and g_dataCenter.guild.detail.id ~= "0" then
			mydata.addition_name = g_dataCenter.guild.detail.name;
		end
	end 
	if mydata.param2 == 0 then 
		if self.vs.selfSpVip then
			self.vs.selfSpVip:set_active(false)
		end
	else 
		if self.vs.selfSpVip then
			self.vs.selfSpVip:set_active(false)
		end
		-- PublicFunc.SetImageVipLevel(self.vs.selfSpVip, mydata.param2);
	end 
	self.vs.selfName:set_text(mydata.name); 
	self.vs.selfGuildName:set_active(false);
	-- self.vs.selfChengHao:set_text("");
	--self.vs.selfFightValue:set_text("[FFF600]"..tostring(mydata.ranking_num));
	self.vs.selfFightValue:set_text("[D379B4FF]"..tostring(mydata.ranking_num));
	self:SetSelfRankNum(mydata.ranking);
	--self.vs.selfInfoBg2:set_active(true);
	--self.vs.selfGroupName:set_font_size(24);
	self[RANK_TYPE_NAME[self.type]](self,mydata);
	if mydata.ranking_num ~= 0 then 
		self.vs.selfFightValue:set_text(tostring(mydata.ranking_num));
	else 
		self.vs.selfFightValue:set_text("");
	end
end 

function RankList:FIGHT(mydata)
	self.vs.selfGroupPanel:set_active(false);
	self.vs.selfGroupPanel2:set_active(false)
	self.vs.selfInfoPanel:set_active(true);
	self.vs.selfRoleRoom:set_active(false);
	self.vs.titlePM:set_active(true);
	self.vs.titleZD:set_active(true);
	self.vs.titleJS:set_active(false);
	self.vs.titleZL:set_active(true);
	self.vs.titleZD:set_text(_local.UIText[1]);
	self.vs.titleZL:set_text(_local.UIText[2]);		
	self.vs.selfInfoNoGuild:set_active(false);
	self.vs.selfGuildName:set_active(true);
	if mydata.addition_name == "" then 
		mydata.addition_name = nil;
	end 
	self.vs.selfGuildName:set_text(mydata.addition_name or "未加入社团");
	self.vs.selfFightValue:set_color(1,0.5,0.5,1);
end 

function RankList:LEVEL(mydata)
	self.vs.selfGroupPanel:set_active(false);
	self.vs.selfGroupPanel2:set_active(false)
	self.vs.selfInfoPanel:set_active(true);
	self.vs.selfRoleRoom:set_active(false);
	self.vs.titlePM:set_active(true);
	self.vs.titleZD:set_active(true);
	self.vs.titleJS:set_active(false);
	self.vs.titleZL:set_active(true);
	self.vs.titleZD:set_text(_local.UIText[1]);
	self.vs.titleZL:set_text(_local.UIText[3]);
	self.vs.selfInfoNoGuild:set_active(false);
	self.vs.selfGuildName:set_active(true);
	if mydata.addition_name == "" then 
		mydata.addition_name = nil;
	end 
	self.vs.selfGuildName:set_text(mydata.addition_name or "未加入社团");
	self.vs.selfFightValue:set_color(1,1,0,1);
end 

function RankList:HURDLESTAR(mydata)
	self.vs.selfGroupPanel:set_active(false);
	self.vs.selfGroupPanel2:set_active(false)
	self.vs.selfInfoPanel:set_active(true);
	self.vs.selfRoleRoom:set_active(false);
	self.vs.titlePM:set_active(true);
	self.vs.titleZD:set_active(true);
	self.vs.titleJS:set_active(false);
	self.vs.titleZL:set_active(true);
	self.vs.titleZD:set_text(_local.UIText[1]);
	self.vs.titleZL:set_text(_local.UIText[9]);
	self.vs.selfInfoNoGuild:set_active(false);
	self.vs.selfGuildName:set_active(true);
	if mydata.addition_name == "" then 
		mydata.addition_name = nil;
	end 
	self.vs.selfGuildName:set_text(mydata.addition_name or "未加入社团");
	self.vs.selfFightValue:set_color(1,0.5,0.5,1);
end 

function RankList:GROUP(mydata)
	self.vs.selfGroupPanel:set_active(true);
	self.vs.selfGroupPanel2:set_active(true)
	self.vs.selfInfoPanel:set_active(false);
	self.vs.selfRoleRoom:set_active(false);
	self.vs.titlePM:set_active(true);
	self.vs.titleZD:set_active(true);
	self.vs.titleJS:set_active(true);
	self.vs.titleZL:set_active(true);
	self.vs.titleZD:set_text(_local.UIText[4]);
	self.vs.titleZL:set_text(_local.UIText[5]);		
	self.vs.titleJS:set_text(_local.UIText[6]);		
	self.vs.titleJS:set_position(57,211,0);	
	local haveGuildData = false;
	self.vs.selfSpVip2:set_active(false);
	if mydata.level ~= 0 then 
		local allnum = bit.bit_and(mydata.param3,0xFFFF);
		local maxnum = bit.bit_rshift(mydata.param3,16);
		self.vs.selfGroupLevel:set_text("[FFFF00FF]"..tostring(mydata.level).."[-]级 "..tostring(allnum).."/"..tostring(maxnum).."人") 
		if mydata.param2 ~= nil and mydata.param2 ~= "" then 
			-- self.vs.selfSpVip2:set_active(true);
			-- PublicFunc.SetImageVipLevel(self.vs.selfSpVip2, mydata.param2);
			if self.vs.selfSpVip2 then
				self.vs.selfSpVip2:set_active(false);
			end
		end 
		haveGuildData = true;
	else
		if g_dataCenter.guild.detail ~= nil and g_dataCenter.guild.detail.id ~= "0" then 
			haveGuildData = true;
			mydata.iconsid = {};
			mydata.iconsid[1] = g_dataCenter.guild.detail.icon;
			mydata.addition_name = g_dataCenter.guild.detail.leaderName;
			mydata.name = g_dataCenter.guild.detail.name;
			if g_dataCenter.guild.detail.totalFight == 0 then 
				g_dataCenter.guild.detail.totalFight = g_dataCenter.player.fight_value;
			end
			mydata.ranking_num = g_dataCenter.guild.detail.totalFight;
		else
			self.vs.selfGroupLevel:set_text("");
			self.vs.selfInfoNoGuild:set_active(true);
			self.vs.selfFightValue:set_text("");
			self.vs.selfGroupName:set_text("");
			self.vs.selfGroupLevel:set_text("");
			self.vs.selfGroupLeader:set_text("");
			-- self.vs.selfGroupIconTexture:clear_texture();
		end 
		--self.vs.selfInfoBg2:set_active(false);
	end 
	if haveGuildData == true then
		self.vs.selfName:set_text(mydata.addition_name);
		--self.vs.selfFightValue:set_text("[FFF600]"..tostring(mydata.ranking_num));
		if mydata.ranking_num == 0 then 
			if tostring(g_dataCenter.guild.detail.totalFight) == "0" then 
				g_dataCenter.guild.detail.totalFight = g_dataCenter.player.fight_value;
			end
			mydata.ranking_num = g_dataCenter.guild.detail.totalFight;
		end 
		self.vs.selfFightValue:set_color(1,0.1,0.1,1);
		self.vs.selfFightValue:set_text(tostring(mydata.ranking_num));
		if mydata.iconsid ~= 0 then 
			local cf = ConfigManager.Get(EConfigIndex.t_guild_icon,mydata.iconsid[1]);
			if cf ~= nil then 
				local iconPath = cf.icon;
				-- self.vs.selfGroupIconTexture:set_texture(iconPath);
				-- self.vs.selfGroupIconTexture:set_active(true);
			else 
				-- self.vs.selfGroupIconTexture:set_active(false);
			end
		else 
			-- self.vs.selfGroupIconTexture:set_active(false);
		end   
		self.vs.selfGroupLeader:set_text(mydata.addition_name);
		self.vs.selfGroupName:set_text(mydata.name);
		self.vs.selfInfoNoGuild:set_active(false);
	else
		self.vs.selfFightValue:set_color(1,0.1,0.1,1);
		self.vs.selfFightValue:set_text("");
	end
	self.vs.selfGuildName:set_active(true);
	if mydata.addition_name == "" then 
		mydata.addition_name = nil;
	end 
	self.vs.selfGuildName:set_text(mydata.addition_name or "未加入社团");
end 

function RankList:GUILDBOSS(mydata)
	self:GROUP(mydata);
end 

function RankList:ROLE(mydata)
	self.vs.selfGroupPanel:set_active(false);
	self.vs.selfGroupPanel2:set_active(false)
	self.vs.selfInfoPanel:set_active(true);
	self.vs.selfRoleRoom:set_active(true);
	self.vs.selfInfoNoGuild:set_active(false);
	self.vs.titlePM:set_active(true);
	self.vs.titleZD:set_active(true);
	self.vs.titleJS:set_active(true);
	self.vs.titleZL:set_active(true);
	self.vs.titleZD:set_text(_local.UIText[1]);
	self.vs.titleZL:set_text(_local.UIText[2]);	
	self.vs.titleJS:set_text(_local.UIText[7]);	
	self.vs.titleJS:set_position(85,211,0);
	self.vs.selfRoleRoom:set_local_position(89,-4,0);
	if self.vs.playerHead ~= nil then 
		self.vs.playerHead.ui:set_active(false);
		self.vs.playerHead:DestroyUi();
		self.vs.playerHead = nil;
	end 
	local iconSid = 0;
	if type(mydata.iconsid) == "table" then 
		iconSid = mydata.iconsid[1];
	else 
		iconSid = mydata.iconsid;
	end 
	cf = ConfigHelper.GetRole(iconSid);
	if cf ~= nil then 
		--self.vs.firstHeadRoom:set_sprite_name(cf.small_icon);
		if self.vs.roleCard == nil then 
			self.vs.roleCard = SmallCardUi:new({
				parent = self.vs.selfRoleRoom,
				info = CardHuman:new({number=iconSid,level = mydata.param3}),
				stypes = SmallCardUi.SGroupTyps[5]
			})
		else 
			self.vs.roleCard:SetDataNumber(iconSid);
			self.vs.roleCard:SetLevel(mydata.param3);
		end 
	end 
	self.vs.selfGuildName:set_active(true);
	if mydata.addition_name == "" then 
		mydata.addition_name = nil;
	end 
	self.vs.selfFightValue:set_color(1,0.5,0.5,1);
	self.vs.selfGuildName:set_text(mydata.addition_name or "未加入社团");
end 

function RankList:ARENA(mydata)
	self.vs.selfGroupPanel:set_active(false);
	self.vs.selfGroupPanel2:set_active(false)
	self.vs.selfInfoPanel:set_active(true);
	self.vs.selfRoleRoom:set_active(false);
	self.vs.selfInfoNoGuild:set_active(false);
	self.vs.titlePM:set_active(true);
	self.vs.titleZD:set_active(true);
	self.vs.titleJS:set_active(true);
	self.vs.titleZL:set_active(true);
	self.vs.titleZD:set_text(_local.UIText[1]);
	self.vs.titleZL:set_text(_local.UIText[2]);		
	self.vs.titleJS:set_text(_local.UIText[4]);		
	self.vs.titleJS:set_position(57,211,0);	
	self.vs.selfGuildName:set_active(true);
	if mydata.addition_name == "" then 
		mydata.addition_name = nil;
	end 
	self.vs.selfGuildName:set_text(mydata.addition_name or "未加入社团");
	self.vs.selfRoleRoom:set_local_position(-266,0,0);
	local iconSid = 0;
	if type(mydata.iconsid) == "table" then 
		iconSid = mydata.iconsid[1];
	else 
		iconSid = mydata.iconsid;
	end 
	if self.vs.roleCard ~= nil then 
		self.vs.roleCard.ui:set_active(false);
		self.vs.roleCard:DestroyUi();
		self.vs.roleCard = nil;
	end
	if self.vs.playerHead == nil then 
		self.vs.playerHead = UiPlayerHead:new({parent = self.vs.selfRoleRoom , roleId = iconSid});
	else 
		self.vs.playerHead:SetRoleId(iconSid);
	end 
end 

function RankList:WORSHIP()
	self.vs.selfGroupPanel:set_active(false);
	self.vs.selfGroupPanel2:set_active(false)
	self.vs.selfInfoPanel:set_active(true);
	self.vs.selfRoleRoom:set_active(false);
	self.vs.selfInfoNoGuild:set_active(false);
	self.vs.titlePM:set_active(true);
	self.vs.titleZD:set_active(true);
	self.vs.titleJS:set_active(false);
	self.vs.titleZL:set_active(true);
	self.vs.titleZD:set_text(_local.UIText[1]);
	self.vs.titleZL:set_text(_local.UIText[8]);	
end 

-- function RankList:Init(data)
-- 	--app.log("RankList:Init");
--     self.pathRes = _local.resPath;
-- 	UiBaseClass.Init(self, data);
-- end

--析构函数
function RankList:DestroyUi()
	--app.log("RankList:DestroyUi");
	if self.vs.itemList ~= nil then 
		for k,v in pairs(self.vs.itemList) do 
			v:DestroyUi();
		end
	end 
	if self.vs.roleCard ~= nil then 
		self.vs.roleCard:DestroyUi();
	end
    self.vs = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function RankList:Show()
	--app.log("RankList:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function RankList:Hide()
	--app.log("RankList:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function RankList:MsgRegist()
	--app.log("RankList:MsgRegist");
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(RANK_MSG_TYPE,self.bindfunc['on_rank_data_change']);
end

--注销消息分发回调函数
function RankList:MsgUnRegist()
	--app.log("RankList:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(RANK_MSG_TYPE,self.bindfunc['on_rank_data_change']);
end