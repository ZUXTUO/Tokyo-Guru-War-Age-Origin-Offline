GuildBossFormationUI = Class("GuildBossFormationUI", UiBaseClass);

local EToggleType = { }
local countRowNum = 4;

function GuildBossFormationUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2821_guild_boss.assetbundle";
    UiBaseClass.Init(self, data);
end

function GuildBossFormationUI:InitData(data)
	EToggleType = 
	{
		[1] = ENUM.EProType.All,
		[2] = ENUM.EProType.Gong,
		[3] = ENUM.EProType.Fang,
		[4] = ENUM.EProType.Ji,
	}
    UiBaseClass.InitData(self, data);
end

function GuildBossFormationUI:Restart(data)
	--local showType = ENUM.EShowHeroType.Have;
	local showType = ENUM.EShowHeroType.All;
	self.listAllHero = PublicFunc.GetAllHero(showType,nil,{});
	self.listTeam = 
	{
		[1] = {
			[1] = {uuid=nil,},
			[2] = {uuid=nil,},
			[3] = {uuid=nil,},
		},
		[2] = {
			[1] = {uuid=nil,},
			[2] = {uuid=nil,},
			[3] = {uuid=nil,},
		}
	};
	self.listUUid = {};
	local team1 = g_dataCenter.player:GetTeam(ENUM.ETeamType.guild_boss1);
	local team2 = g_dataCenter.player:GetTeam(ENUM.ETeamType.guild_boss2);
	for i=1,3 do
		self.listTeam[1][i].uuid = team1[i];
		if team1[i] and team1[i] ~= 0 then
			self.listUUid[team1[i]] = 1;
		end
		self.listTeam[2][i].uuid = team2[i];
		if team2[i] and team2[i] ~= 0 then
			self.listUUid[team2[i]] = 2;
		end
	end
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function GuildBossFormationUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_click_toggle"] = Utility.bind_callback(self, self.on_click_toggle);
    self.bindfunc["on_click_list_hero"] = Utility.bind_callback(self, self.on_click_list_hero);
    self.bindfunc["on_click_cancel_hero"] = Utility.bind_callback(self, self.on_click_cancel_hero);
    self.bindfunc["on_click_clear_battle"] = Utility.bind_callback(self, self.on_click_clear_battle);
    self.bindfunc["on_click_battle"] = Utility.bind_callback(self, self.on_click_battle);
    self.bindfunc["on_save"] = Utility.bind_callback(self, self.on_save);
    self.bindfunc["onDragStartHero"] = Utility.bind_callback(self, self.onDragStartHero);
	self.bindfunc["onDragReleaseHero"] = Utility.bind_callback(self, self.onDragReleaseHero);
	self.bindfunc["onDragMoveHero"] = Utility.bind_callback(self, self.onDragMoveHero);
	self.bindfunc["gc_update_team_info"] = Utility.bind_callback(self, self.gc_update_team_info);
end

function GuildBossFormationUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_team.gc_update_team_info,self.bindfunc["gc_update_team_info"]);
end

function GuildBossFormationUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_team.gc_update_team_info,self.bindfunc["gc_update_team_info"]);
end

function GuildBossFormationUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_2824_guild_boss");

    self.scroll = ngui.find_scroll_view(self.ui,"left_other/animation/scroll_view/panel_list");
    self.wrap = ngui.find_wrap_content(self.ui,"left_other/animation/scroll_view/panel_list/wrap_content");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self.panel = self.ui:get_child_by_name("panel_empty");
	self.dragCard = SmallCardUi:new({parent=self.panel,stypes = {1,5,6,9}});
	self.dragCard:EnableButtonFunc(false);

    self.toggle = {};
    for i=1,#EToggleType do
    	self.toggle[i] = {};
    	self.toggle[i].btn = ngui.find_button(self.ui,"left_other/animation/cont/yeka"..i);
    	self.toggle[i].btn:set_on_click(self.bindfunc["on_click_toggle"]);
    	self.toggle[i].btn:set_event_value("", EToggleType[i]);
    end

    self.contTeam = {};
    for j=1,2 do
	    self.contTeam[j] = {};
	    local obj = self.ui:get_child_by_name("right_other/animation/cont"..j);
	    for i=1,3 do
	    	local cont = {};
	    	cont.obj = obj:get_child_by_name("big_card_item_80"..i);
	    	cont.card = SmallCardUi:new({parent=cont.obj,stypes = {1,5,6,9}});
	    	cont.card:SetDragStart(self.bindfunc["onDragStartHero"]);
	    	cont.card:SetDragRelease(self.bindfunc["onDragReleaseHero"]);
	    	cont.card:SetDragMove(self.bindfunc["onDragMoveHero"]);
	    	cont.card:SetDragRestriction(1);
	    	cont.card:SetDragIsClone(true);
	    	cont.card:setName("team["..j.."]pos["..i.."]");
	    	cont.btnCancel = ngui.find_button(cont.obj,"btn_cha");
	    	cont.btnCancel:set_on_click(self.bindfunc["on_click_cancel_hero"]);
	    	cont.btnCancel:set_event_value(""..j,i);
	    	cont.objTeam = cont.obj:get_child_by_name("sp_duizhang");
	    	if i == 1 then
	    		cont.objTeam:set_active(true);
	    	else
	    		cont.objTeam:set_active(false);
	    	end
	    	self.contTeam[j][i] = cont;
	    end
	    self.contTeam[j].labFightValue = ngui.find_label(obj,"sp_line/txt/lab");
	    self.contTeam[j].labBtn = ngui.find_label(obj,"sp_line/btn/animation/lab");
	    local btnClearTeam = ngui.find_button(obj,"sp_line/btn");
	    btnClearTeam:set_on_click(self.bindfunc["on_click_clear_battle"]);
	    btnClearTeam:set_event_value("",j);
	end

	self.labFightValue = ngui.find_label(self.ui,"down_other/animation/sp_fight/lab_fight");
	local btnBattle = ngui.find_button(self.ui,"down_other/animation/btn_buleda");
	btnBattle:set_on_click(self.bindfunc["on_click_battle"]);
	local btnSave = ngui.find_button(self.ui,"down_other/animation/btn");
	btnSave:set_on_click(self.bindfunc["on_save"]);

	self.cont = {};
    self:on_click_toggle({float_value=EToggleType[1]});
    self:UpdateUi();
    self:UpdateItemList();
end

function GuildBossFormationUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local totalFightValue = 0;
    for j=1,2 do
	    local numFightValue = 0;
	    for i=1,3 do
	    	if self.listTeam[j][i].uuid then
	    		local info = g_dataCenter.package:find_card(1, self.listTeam[j][i].uuid);
	    		self.contTeam[j][i].card:SetData(info);
	    		self.contTeam[j][i].btnCancel:set_active(true);
	    		numFightValue = numFightValue + info:GetFightValue();
	    	else
	    		self.contTeam[j][i].card:SetData();
	    		self.contTeam[j][i].btnCancel:set_active(false);
	    	end
	    end
	    totalFightValue = totalFightValue + numFightValue;
	    self.contTeam[j].labFightValue:set_text(tostring(numFightValue));
	end
	self.labFightValue:set_text(tostring(totalFightValue));
end

function GuildBossFormationUI:DestroyUi()
	for k,v in pairs(self.contTeam) do
		for kk,vv in ipairs(v) do
			vv.card:DestroyUi();
		end
	end
	self.contTeam = {};
	for k,v in pairs(self.cont) do
		for kk,vv in pairs(v.item) do
			vv.card:DestroyUi();
		end
	end
	self.cont = {};
    UiBaseClass.DestroyUi(self);
end

function GuildBossFormationUI:GetTeamIDAndPos(uuid)
	if not self.listUUid[uuid] then
		return;
	end
	local team_id = self.listUUid[uuid];
	for i=1,3 do
		if self.listTeam[team_id][i].uuid == uuid then
			return team_id, i;
		end
	end
end

function GuildBossFormationUI:ChangeHeroPos(new_team, new_pos, info)
	local old_team,old_pos = self:GetTeamIDAndPos(info.index);
	if old_team and old_pos then
		local old_info = self.listTeam[old_team][old_pos];
		local new_info = self.listTeam[new_team][new_pos];
		self.listTeam[old_team][old_pos] = new_info;
		self.listTeam[new_team][new_pos] = old_info;
		if new_info.uuid then
			self.listUUid[new_info.uuid] = old_team;
		end
		if old_info.uuid then
			self.listUUid[old_info.uuid] = new_team;
		end
	else
		self.listTeam[new_team][new_pos].uuid = info.index;
		self.listUUid[info.index] = new_team;
	end
	self:UpdateItemList();
	self:UpdateUi();
end

function GuildBossFormationUI:UpdateItemList()
	self:AutoFinishingTeam();
	self:UpdateTeamBtn();
	for k,v in pairs(self.cont) do
		self:update_item(v, v.index);
	end
end

function GuildBossFormationUI:CheckSingleTeam(id)
	local num = 0;
	for i=1,3 do
		if self.listTeam[id][i].uuid then
			num = num + 1;
		end
	end
	return num;
end

function GuildBossFormationUI:UpdateTeamBtn()
	for i=1,2 do
		local num = self:CheckSingleTeam(i);
		if num < 3 then
			self.contTeam[i].labBtn:set_text("一键上阵")
		else
			self.contTeam[i].labBtn:set_text("一键下阵")
		end
	end
end

function GuildBossFormationUI:AutoFinishingTeam()
	local newList = 
	{
		[1] = {
			[1] = {uuid=nil,},
			[2] = {uuid=nil,},
			[3] = {uuid=nil,},
		},
		[2] = {
			[1] = {uuid=nil,},
			[2] = {uuid=nil,},
			[3] = {uuid=nil,},
		}
	};
	local i1=1;
	local i2=1;
	for i=1,3 do
		if self.listTeam[1][i].uuid then
			newList[1][i1].uuid = self.listTeam[1][i].uuid;
			i1 = i1 + 1;
		end
		if self.listTeam[2][i].uuid then
			newList[2][i2].uuid = self.listTeam[2][i].uuid;
			i2 = i2 + 1;
		end
	end
	self.listTeam = newList;
end

-----------------------------------------------------
function GuildBossFormationUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
	if index > math.ceil(#self.listShow/countRowNum) then
		return;
	end
    if Utility.isEmpty(self.cont[b]) then
        self.cont[b] = self:init_item(obj)
    end
    self:update_item(self.cont[b], index);
end

function GuildBossFormationUI:init_item(obj)
    local cont = {}
    cont.obj = obj;
    cont.item = {};
    for i=1,countRowNum do
    	local item = {};
	    item.node = obj:get_child_by_name("item"..i.."/big_card_item_80");
	    item.card = SmallCardUi:new({parent=item.node,stypes = {1,5,6,9}});
	    item.card:SetCallback(self.bindfunc["on_click_list_hero"]);
	    item.card:SetDragStart(self.bindfunc["onDragStartHero"]);
	    item.card:SetDragRelease(self.bindfunc["onDragReleaseHero"]);
	    item.card:SetDragMove(self.bindfunc["onDragMoveHero"]);
	    item.card:SetDragRestriction(2);
	    item.card:SetDragIsClone(true);
	    item.objTeam = item.node:get_child_by_name("sp_duiwu");
	    item.labTeam = ngui.find_label(item.objTeam,"lab");
	    cont.item[i] = item;
	end
    return cont;
end

function GuildBossFormationUI:update_item(cont, index)
	cont.index = index;
	for i=1,countRowNum do
		local data = self.listShow[countRowNum*(index-1)+i];
		local item = cont.item[i];
		if data then
			item.node:set_active(true);
			item.card:SetData(data);
			if self.listUUid[data.index] == 1 then
				-- item.card:SetBattleSpEx(true);
				item.card:SetGray(true, true, false);
				item.card:SetClick(false);
				item.objTeam:set_active(true);
				item.labTeam:set_text("队伍1");
			elseif self.listUUid[data.index] == 2 then
				-- item.card:SetBattleSpEx(true);
				item.card:SetGray(true, true, false);
				item.card:SetClick(false);
				item.objTeam:set_active(true);
				item.labTeam:set_text("队伍2");
			else
				-- item.card:SetBattleSpEx(false);
				item.card:SetGray(false, true, true);
				item.card:SetClick(true);
				item.objTeam:set_active(false);
			end
		else
			item.node:set_active(false);
		end
	end
end

function GuildBossFormationUI:on_click_toggle(t)
	local hero_type = t.float_value;
	self.curHeroType = hero_type;
	self.listShow = {};
    for i=1,#self.listAllHero do
    	local info = self.listAllHero[i];
        if hero_type == ENUM.EProType.All or hero_type == info.pro_type then
        	table.insert(self.listShow, info);
        end
    end
    self.wrap:set_min_index(1-math.ceil(#self.listShow/countRowNum));
    self.wrap:set_max_index(0);
    self.wrap:reset();
    self.scroll:reset_position();
end

function GuildBossFormationUI:on_click_list_hero(obj, info, param)
	if self.listUUid[info.index] then
		return;
	end
	for j=1,2 do
		for i=1,3 do
			if self.listTeam[j][i].uuid == nil then
				self.listUUid[info.index] = j;
				self.listTeam[j][i].uuid = info.index;
				self:UpdateUi();
				self:UpdateItemList();
				return;
			end
		end
	end
end

function GuildBossFormationUI:on_click_cancel_hero(t)
	local teamPos = tonumber(t.string_value);
	local index = t.float_value;
	if self.listTeam[teamPos] == nil or self.listTeam[teamPos][index] == nil then
		return;
	end
	local uuid = self.listTeam[teamPos][index].uuid;
	self.listUUid[uuid] = nil;
	self.listTeam[teamPos][index].uuid = nil;
	self:UpdateItemList();
	self:UpdateUi();
end

function GuildBossFormationUI:on_click_clear_battle(t)
	local teamPos = t.float_value;
	local num = self:CheckSingleTeam(teamPos);
	if num == 3 then
		for i=1,3 do
			local uuid = self.listTeam[teamPos][i].uuid;
			if uuid then
				self.listUUid[uuid] = nil;
			end
			self.listTeam[teamPos][i].uuid = nil;
		end
	else
		--local showType = ENUM.EShowHeroType.Have;
		local showType = ENUM.EShowHeroType.All;
		local team = {};
		if teamPos == 2 then
			for i=1,3 do
				table.insert(team,self.listTeam[1][i].uuid);
			end
		else
			for i=1,3 do
				table.insert(team,self.listTeam[2][i].uuid);
			end
		end
		local list = PublicFunc.GetAllHero(showType,nil,team);
		for j=1,3 do
			if self.listTeam[teamPos][j].uuid then
				self.listUUid[self.listTeam[teamPos][j].uuid] = nil;
			end
			if list[#team+j] then
				self.listTeam[teamPos][j].uuid = list[#team+j].index;
				self.listUUid[list[#team+j].index] = teamPos;
			end
		end
	end
	self:UpdateItemList();
	self:UpdateUi();
end

function GuildBossFormationUI:on_click_battle()
	--local showType = ENUM.EShowHeroType.Have;
	local showType = ENUM.EShowHeroType.All;
	local list = PublicFunc.GetAllHero(showType,nil,{});
	self.listUUid = {};
	for i=1,2 do
		for j=1,3 do
			if list[3*(i-1)+j] then
				self.listTeam[i][j].uuid = list[3*(i-1)+j].index;
				self.listUUid[list[3*(i-1)+j].index] = i;
			end
		end
	end
	self:UpdateItemList();
	self:UpdateUi();
end

function GuildBossFormationUI:onDragStartHero(src,obj,info)
	if info then
		self.panel:set_active(true);
		self.dragCard:SetData(info);
	end
end

function GuildBossFormationUI:onDragMoveHero(name, x, y, go_obj)
    local screen_width = app.get_screen_width();
    local screen_height = app.get_screen_height();
    local _x = (x-screen_width/2)*1280/screen_width;
    local _y = (y-screen_height/2)*720*(screen_height/screen_width*16/9)/screen_height;
	self.dragCard:SetPosition(_x,_y,0);
end

function GuildBossFormationUI:onDragReleaseHero(src,tar,obj,info)
	local tarParent = tar:get_parent();
	self.panel:set_active(false);
	if tarParent == nil then
		return;
	end
	if info == nil then
		return;
	end
	local tarName = tarParent:get_name();
	if tarName == "small_card_ui" or tarName == "scroll_view" then
		-- release
		local team_id,pos = self:GetTeamIDAndPos(info.index);
		self:on_click_cancel_hero({string_value=tostring(team_id),float_value=pos});
	else
	    local _,_,team_id,pos = string.find(tarName, "team%[([0-9]+)%]pos%[([0-9]+)%]");
	    team_id = tonumber(team_id);
	    pos = tonumber(pos);
	    if team_id and pos then
	    	-- set team
	    	self:ChangeHeroPos(team_id, pos, info);
	    end
	end
end

function GuildBossFormationUI:on_save()
	self.msgNum = 0;
	local flg1 = true;
	local flg2 = true;
	-- team1
	local cardsInfo1 = {};
	for i=1,3 do
		cardsInfo1[i] = self.listTeam[1][i].uuid or 0;
		if cardsInfo1[i] ~= 0 then
			flg1 = false;
		end
	end
	local team1 = 
	{
		teamid = ENUM.ETeamType.guild_boss1,
		cards = cardsInfo1,
	}
	-- team2
	local cardsInfo2 = {};
	for i=1,3 do
		cardsInfo2[i] = self.listTeam[2][i].uuid or 0;
		if cardsInfo2[i] ~= 0 then
			flg2 = false;
		end
	end
	local team2 = 
	{
		teamid = ENUM.ETeamType.guild_boss2,
		cards = cardsInfo2,
	}
	-- check
	if flg1 and flg2 then
		FloatTip.Float("队伍不能为空")
		return;
	end
	-- send
	msg_team.cg_update_team_info(team1);
	msg_team.cg_update_team_info(team2);
end

function GuildBossFormationUI:gc_update_team_info()
	if self.msgNum >= 1 then
		uiManager:PopUi();
	else
		self.msgNum = self.msgNum + 1;
	end
end
