OtherPlayerPanel = Class('OtherPlayerPanel',UiBaseClass);

local _local = {}
_local.resPath = "assetbundles/prefabs/ui/other_player_panel/ui_team_information.assetbundle"

_local.UIText = {
	[1] = "[f2ae1c][-]",
	[2] = "[f2ae1c]ID:[-]",
	[3] = "[f2ae1c]战队总战力:[-]",
	[4] = "[f2ae1c]区域:[-]%s区",
	[5] = "[f2ae1c]社团:[-]",
	[6] = "无",
}

------------外部接口--------------
--[[弹出其他玩家信息面板的外部接口]]
--[[teamType可以不传默认ENUM.ETeamType.normal]]
function OtherPlayerPanel.ShowPlayer(playerId,teamType,isArena,isChat)
	if playerId == g_dataCenter.player.playerid then 
		do return end;
	end
	OtherPlayerPanel.instance = OtherPlayerPanel:new({isArena = isArena,isChat = isChat});
	if OtherPlayerPanel.instance.ui ~= nil then 
		OtherPlayerPanel.instance.vs.cont_info:set_active(false);
	end
	player.cg_look_other_player(playerId,teamType or ENUM.ETeamType.normal);
	OtherPlayerPanel.instance.loadingId = GLoading.Show(GLoading.EType.ui)
end

function OtherPlayerPanel.End()
	if OtherPlayerPanel.instance then
		OtherPlayerPanel.instance:Hide()
		OtherPlayerPanel.instance:DestroyUi()
		OtherPlayerPanel.instance = nil
	end
end

OtherPlayerPanel.dispatchChatMsg = "OtherPlayerPanelDispatchMsg";

--重新开始
function OtherPlayerPanel:Restart(data)
    --app.log("FloatTip:Restart");
    UiBaseClass.Restart(self, data);
	self.isArena = data.isArena;
	self.isChat  = data.isChat;
end

function OtherPlayerPanel:InitData(data)
    --app.log("FloatTip:InitData");
    UiBaseClass.InitData(self, data);
	self.isArena = data.isArena;
	self.isChat  = data.isChat;
    self.msg = nil;
end

function OtherPlayerPanel:RegistFunc()
	--app.log("FloatTip:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_other_player_info_receive'] = Utility.bind_callback(self, self.on_other_player_info_receive);
	self.bindfunc['on_btn_close_click'] = Utility.bind_callback(self,self.on_btn_close_click);
	self.bindfunc['on_chat_btn_click'] = Utility.bind_callback(self,self.on_chat_btn_click);
	self.bindfunc['on_friend_btn_click'] = Utility.bind_callback(self,self.on_friend_btn_click);
	self.bindfunc['on_shield_btn_click'] = Utility.bind_callback(self,self.on_shield_btn_click);
	self.bindfunc['on_sync_all_blacklist'] = Utility.bind_callback(self,self.on_sync_all_blacklist);
	self.bindfunc['on_delete_friend_btn_click'] = Utility.bind_callback(self,self.on_delete_friend);
	self.bindfunc['on_sync_all_friendlist'] = Utility.bind_callback(self,self.on_sync_all_friendlist);
	self.bindfunc["on_btn_fight"] = Utility.bind_callback(self, self.on_btn_fight)
end

--player.cg_look_other_player(player_gid,team_type);

function OtherPlayerPanel:on_other_player_info_receive(result,playerid,teamType,otherPlayerData)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        uiManager:PopUi();
        return;
    end
	local self = OtherPlayerPanel.instance;
    local guild = otherPlayerData.guilddata;
    local team = otherPlayerData.teamData;
    local role_cards = otherPlayerData.vecRoleData;
--    local equip_cards = otherPlayerData.vecEquipData; 
    local player = Player:new();
    local package = Package:new();
    player:UpdateData(otherPlayerData);
    --[[for k,v in pairs(equip_cards) do
        if tonumber(v) ~= 0 then
            package:AddCard(ENUM.EPackageType.Equipment,v);
        end
    end--]]
	self.fightValue = 0;
    for k,v in pairs(role_cards) do
        if tonumber(v) ~= 0 then
			self.fightValue = self.fightValue + v.fight_value;
            package:AddCard(ENUM.EPackageType.Hero,v);
        end
    end
    package:CalAllHeroProperty();
    local teamid = 0;
    for k,v in pairs(team.cards) do
        if tonumber(v) ~= 0 then
            player:AddTeam(teamid, k, v)
        end
    end
    self.player = player;
    self.package = package;
    self.teamInfo = team.cards;
    if guild and guild.szName ~= "" then
        --app.log_warning("guild:"..table.tostring(guild))
        self.guild = GuildDetail:new(guild);
    end
	if self.vs ~= nil then 
		self:UpdateUi();
	end 
end

function OtherPlayerPanel:UpdateUi()
	self.vs.cont_info:set_active(true);
	local player = self.player;
	local roleCf = ConfigHelper.GetRole(player.image);

    local package = self.package;
    local teamInfo = self.teamInfo;
	if self.isChat == true then 
		-- self.vs.cont1:set_active(false);
		-- self.vs.labName = self.vs.labChatName;
		-- self.vs.labLevel = self.vs.labChatLevel;
		-- self.vs.labID = self.vs.labChatID;
		-- self.vs.labTeamPower = self.vs.labChatTeamPower;
		-- self.vs.labArea = self.vs.labChatArea;
		-- self.vs.labClub = self.vs.labChatClub;
		-- self.vs.vip = self.vs.chatVip;
		-- self.vs.labVip = self.vs.labChatVip;
	else 
		-- self.vs.cont_chat:set_active(false);
	end 
	if self.player.vip == 0 then 
		--self.vs.labVip:set_active(false);
		--self.vs.vip:set_active(false);
	else 
		--self.vs.vip:set_active(true);
		--self.vs.labVip:set_text(tostring(self.player.vip));
	end 
	self.vs.labName:set_text(tostring(self.player.name));
	self.vs.labLevel:set_text(tostring(self.player.level));
	--self.vs.labID:set_text(tostring(self.player.show_playerid));
	self.vs.labTeamPower:set_text(tostring(self.fightValue));
	
	if self.isArena == true then  
		self.vs.btnShield:set_active(false);
		-- local x,y,z = self.vs.btnShield:get_position()
		-- self.vs.btnChat:set_position(x,y,z)
		-- self.vs.btnChatBg:set_sprite_name("ty_anniu4");
	end 
	
	self.isShield = g_dataCenter.friend:GetBlacklistByPlayerGID(self.player.playerid);
	
	local area = nil;
	if self.player.country_id == 1 then 
		area = 1;
	elseif self.player.country_id == 2 then 
		area = 11;
	elseif self.player.country_id == 3 then 
		area = 20;
	end 
	if area ~= nil then 
		-- self.vs.labArea:set_text(tostring(area).."区");
	else 	
		-- self.vs.labArea:set_text("无");
	end 
	if self.guild ~= nil and self.guild.name ~= nil then 
		self.vs.labClub:set_text(tostring(self.guild.name));
	else 
		self.vs.labClub:set_text(_local.UIText[6]);
	end 
	self.uiPlayer = UiPlayerHead:new({parent = self.vs.playerHeadRoom, roleId = self.player.image})
	self.uiPlayer:SetVipLevel(self.player.vip);
	self.uiCards = {}
	-- 仅上阵1人，放到2号位
	local teamPosId = {}
	if #teamInfo == 1 then
		local info = self.package:find_card(1,teamInfo[1]);
		if info and info.number and info.number ~= 0 then
			self.uiCards[1] = SmallCardUi:new({
							parent = self.vs.playerHeadRoom2,
							info = info,
							stypes = SmallCardUi.SGroupTyps[5]
						});
		end
	else
		for i = 1, #teamInfo do 
			local info = self.package:find_card(1,teamInfo[i]);
			if info and info.number and info.number ~= 0 then
				self.uiCards[i] = SmallCardUi:new({
							parent = self.vs["playerHeadRoom"..i],
							info = info,
							stypes = SmallCardUi.SGroupTyps[5]
						});
			end 
		end
	end
	GLoading.Hide(GLoading.EType.ui, self.loadingId);
	self.ui:set_active(true);
	if self.player.playerid == g_dataCenter.player.playerid then 
		self.vs.btnChatBg:set_color(0,0,0,1);
		self.vs.btnChat:set_enable(false);
	end
	local isFriend = g_dataCenter.friend:GetFriendDataByPlayerGID(self.player.playerid);
	if self.isShield == nil and isFriend then 
		self.vs.btnFriendLab:set_text("发起私聊");
		self.vs.btnFriend:set_enable(true);
		self.vs.btnFriend:reset_on_click();
		self.vs.btnFriend:set_on_click(self.bindfunc['on_chat_btn_click']);
		self.vs.btnShield:reset_on_click();
		self.vs.btnShield:set_on_click(self.bindfunc['on_delete_friend_btn_click']);
		self.vs.btnShieldLab:set_text("删除好友");
		self.vs.btnChat:reset_on_click();
		self.vs.btnChat:set_on_click(self.bindfunc['on_shield_btn_click']);
		self.vs.btnChatLab:set_text("屏蔽好友");
		if self.isShield then 
			self.vs.btnChatLab:set_text("取消屏蔽");
		end
	else
		self.vs.btnFriendLab:set_text("加为好友");
		self.vs.btnFriend:set_enable(true);
		self.vs.btnFriend:reset_on_click();
		self.vs.btnFriend:set_on_click(self.bindfunc['on_friend_btn_click']);
		self.vs.btnShield:reset_on_click();
		self.vs.btnShield:set_on_click(self.bindfunc['on_shield_btn_click']);
		self.vs.btnShieldLab:set_text("屏蔽");
		self.vs.btnChat:reset_on_click();
		self.vs.btnChat:set_on_click(self.bindfunc['on_chat_btn_click']);
		self.vs.btnChatLab:set_text("私聊");
		if self.isShield then 
			self.vs.btnShieldLab:set_text("取消屏蔽");
		end
	end
	self.ui:set_active(true);
end 

function OtherPlayerPanel:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_active(false);
    self.ui:set_name('other_player_panel');
    self.vs = {};
    self.vs.sp_mark = ngui.find_texture(self.ui,"sp_mark");
	self.vs.btnClose = ngui.find_button(self.ui,"content_di_754_458/btn_cha");
	local obj_content = self.ui:get_child_by_name("content")
	self.vs.cont_info = obj_content
	self.vs.cont_info:set_active(false);
	self.vs.btnFriend = ngui.find_button(obj_content,"cont/btn3");
	self.vs.btnFriendBg = ngui.find_sprite(obj_content,"cont/btn3/animation/sprite_background");
	self.vs.btnFriendLab = ngui.find_label(obj_content,"cont/btn3/animation/sprite_background/lab")
	self.vs.btnChat = ngui.find_button(obj_content,"cont/btn2");
	self.vs.btnChatBg = ngui.find_sprite(obj_content,"cont/btn2/animation/sprite_background");
	self.vs.btnChatLab = ngui.find_label(obj_content,"cont/btn2/animation/sprite_background/lab"); 
	self.vs.btnShield = ngui.find_button(obj_content,"cont/btn1");
	self.vs.btnShieldBg = ngui.find_sprite(obj_content,"cont/btn1/animation/sprite_background");
	self.vs.btnShieldLab = ngui.find_label(obj_content,"cont/btn1/animation/sprite_background/lab");
	--self.vs.btnFriendBg:set_color(0,0,0,1);
	--self.vs.btnFriend:set_enable(false);
	-- self.vs.cont_chat = self.ui:get_child_by_name("cont_info/cont_chat");
	local obj_cont_com = self.ui:get_child_by_name("content/cont_com");
	self.vs.cont_com = obj_cont_com;
	
	self.vs.labName = ngui.find_label(obj_cont_com,"lab_name");
	--self.vs.labID = ngui.find_label(obj_cont_com,"cont_id/lab");
	self.vs.labLevel = ngui.find_label(obj_cont_com,"cont_level/lab");
	self.vs.labTeamPower = ngui.find_label(self.ui,"content/sp_fight/lab_fight");
	-- self.vs.labArea = ngui.find_label(obj_cont_com,"cont_area/lab");
	self.vs.labClub = ngui.find_label(obj_cont_com,"cont_guild/lab");
	--self.vs.labVip = ngui.find_label(obj_cont_com,"sp_v/lbl_vip_level");
	--self.vs.vip = ngui.find_sprite(obj_cont_com,"sp_v");
	-- self.vs.labTitle = ngui.find_label(obj_cont_com,"cont_info/lbl_title");
	self.vs.playerHeadRoom = obj_content:get_child_by_name("sp_head_di_item");
	self.vs.playerHeadRoom1 = obj_content:get_child_by_name("head/head1");
	self.vs.playerHeadRoom2 = obj_content:get_child_by_name("head/head2");
	self.vs.playerHeadRoom3 = obj_content:get_child_by_name("head/head3");
	self.vs.btnFriend:set_on_click(self.bindfunc['on_friend_btn_click']);
	self.vs.btnClose:set_on_click(self.bindfunc['on_btn_close_click']);
	self.vs.btnChat:set_on_click(self.bindfunc['on_chat_btn_click']);
	self.vs.btnShield:set_on_click(self.bindfunc['on_shield_btn_click']);
	self.vs.labName:set_text("");
	--self.vs.labID:set_text("");
	self.vs.labLevel:set_text("");
	self.vs.labTeamPower:set_text("");
	-- self.vs.labArea:set_text("");
	self.vs.labClub:set_text("");
	--self.vs.labVip:set_text("/0");
	-- self.vs.labTitle:set_text("玩家信息");
	if self.player ~= nil then 
		self:UpdateUi();
	end

	local btnFight = ngui.find_button(obj_content, "btn_fight")
	local isOpen = SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_1v1)
	btnFight:set_active(isOpen)
	btnFight:set_on_click(self.bindfunc["on_btn_fight"])
end

function OtherPlayerPanel:on_sync_all_blacklist()
	self:UpdateUi();
end 

function OtherPlayerPanel:on_sync_all_friendlist()
	self:UpdateUi();
end 

function OtherPlayerPanel:on_delete_friend()
	msg_friend.cg_del_friend({self.player.playerid});
end 

function OtherPlayerPanel:on_btn_close_click()
	--app.log("OtherPlayerPanel:Hide()");
	OtherPlayerPanel.End()
end

function OtherPlayerPanel:on_friend_btn_click()
	if self.isShield then 
		FloatTip.Float("请先取消屏蔽再加为好友");
	else 
		local isFriend = g_dataCenter.friend:GetFriendDataByPlayerGID(self.player.playerid);
		if not isFriend then 
			msg_friend.cg_apply_friend({self.player.playerid})
		else
			FloatTip.Float("你们已经是好友了");
		end
	end 
end 

function OtherPlayerPanel:on_shield_btn_click()
	if self.isShield == nil then 
		msg_friend.cg_add_black_list(self.player.playerid);
	else 
		msg_friend.cg_del_black_list({self.player.playerid});
	end
end 

function OtherPlayerPanel:on_chat_btn_click()
	if RankPopPanel.instance ~= nil then
		RankPopPanel.instance:Hide();
		RankPopPanel.instance:DestroyUi();
	end
	--if self.isArena ~= true then
	--	uiManager:SetStackSize(1)
	--end
	--uiManager:ClearStack();
    local data = {
        playerId = self.player.playerid, playerName = self.player.name, showType = PublicStruct.Chat.whisper,
        vip = self.player.vip, image = self.player.image,
    }
    ChatUI.SetAndShow(data)
	OtherPlayerPanel.End()
end

--[[聊天约战]]
function OtherPlayerPanel:on_btn_fight()
	if self.chatFightTime ~= nil then
		if system.time() - self.chatFightTime < 1 then
			return
		end
	end
	self.chatFightTime = system.time()
	msg_1v1.cg_challenge_player(self.player.playerid)
end

function OtherPlayerPanel:Init(data)
    self.pathRes = _local.resPath;
	UiBaseClass.Init(self, data);
end

--析构函数
function OtherPlayerPanel:DestroyUi()
	if self.uiPlayer then
		self.uiPlayer:DestroyUi()
		self.uiPlayer = nil
	end
	if self.uiCards then
		for i, uiCard in pairs(self.uiCards) do
			uiCard:DestroyUi()
		end
		self.uiCards = nil
	end
    self.vs = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function OtherPlayerPanel:Show()
    UiBaseClass.Show(self);
end

--隐藏ui
function OtherPlayerPanel:Hide()
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function OtherPlayerPanel:MsgRegist()
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(player.gc_look_other_player,self.bindfunc["on_other_player_info_receive"]);
	PublicFunc.msg_regist(msg_friend.gc_del_blacklist,self.bindfunc["on_sync_all_blacklist"]);
	PublicFunc.msg_regist(msg_friend.gc_add_blacklist,self.bindfunc["on_sync_all_blacklist"]);	
	PublicFunc.msg_regist(msg_friend.gc_del_friend_rst,self.bindfunc["on_sync_all_friendlist"]);

end

--注销消息分发回调函数
function OtherPlayerPanel:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(player.gc_look_other_player,self.bindfunc["on_other_player_info_receive"]);
	PublicFunc.msg_unregist(msg_friend.gc_del_blacklist,self.bindfunc["on_sync_all_blacklist"]);
	PublicFunc.msg_unregist(msg_friend.gc_add_blacklist,self.bindfunc["on_sync_all_blacklist"]);
	PublicFunc.msg_unregist(msg_friend.gc_del_friend_rst,self.bindfunc["on_sync_all_friendlist"]);
end