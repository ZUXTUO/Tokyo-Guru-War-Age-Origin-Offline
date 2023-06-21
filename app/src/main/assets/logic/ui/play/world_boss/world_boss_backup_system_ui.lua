WorldBossBackupSystemUI = Class("WorldBossBackupSystemUI", UiBaseClass);

local EToggleType = { }
local EBackTeamCfg = {};
local countRowNum = 4;
local countHeroAttr = 2;
local countMaxShowAttr = 4;
local countMaxBackupNum = 6;

function WorldBossBackupSystemUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/world_boss/ui_3002_world_boss.assetbundle";
    UiBaseClass.Init(self, data);
end

function WorldBossBackupSystemUI:InitData(data)
	EToggleType = 
	{
		[1] = ENUM.EProType.All,
		[2] = ENUM.EProType.Fang,
		[3] = ENUM.EProType.Gong,
		[4] = ENUM.EProType.Ji,
	}
	EBackTeamCfg = 
	{
		[ENUM.ETeamType.world_boss] = EConfigIndex.t_world_boss_backup,
		[ENUM.ETeamType.world_treasure_box] = EConfigIndex.t_world_treasure_box_backup,
	},
    UiBaseClass.InitData(self, data);
end

function WorldBossBackupSystemUI:Restart(data)
	--local showType = ENUM.EShowHeroType.Have;
	local showType = ENUM.EShowHeroType.All;
	self.teamId = data.teamType;
	local team = g_dataCenter.player:GetTeam(self.teamId);
	self.listAllHero = PublicFunc.GetAllHero(showType, nil, team);
	self.listBackupHero = {};
	local _backupTeam = g_dataCenter.player:GetBackupTeam(self.teamId);
	for index=1,countMaxBackupNum do
		self.listBackupHero[index] = self.listBackupHero[index] or {};
		if tonumber(_backupTeam[index]) ~= 0 then
			self.listBackupHero[index].uuid = _backupTeam[index];
		end
	end
	self.backupCfg = ConfigManager._GetConfigTable(EBackTeamCfg[self.teamId]);
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function WorldBossBackupSystemUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_click_toggle"] = Utility.bind_callback(self, self.on_click_toggle);
    self.bindfunc["on_click_list_hero"] = Utility.bind_callback(self, self.on_click_list_hero);
    self.bindfunc["on_drag_hero_begin"] = Utility.bind_callback(self, self.on_drag_hero_begin);
    self.bindfunc["on_drag_hero_end"] = Utility.bind_callback(self, self.on_drag_hero_end);
    self.bindfunc["on_click_cancel_hero"] = Utility.bind_callback(self, self.on_click_cancel_hero);
    self.bindfunc["on_save"] = Utility.bind_callback(self, self.on_save);
	self.bindfunc["on_battle"] = Utility.bind_callback(self, self.on_battle);
	self.bindfunc["gc_update_team_backup_cards"] = Utility.bind_callback(self, self.gc_update_team_backup_cards);
end

function WorldBossBackupSystemUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_team.gc_update_team_backup_cards,self.bindfunc["gc_update_team_backup_cards"]);
end

function WorldBossBackupSystemUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_team.gc_update_team_backup_cards,self.bindfunc["gc_update_team_backup_cards"]);
end

function WorldBossBackupSystemUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_3002_world_boss");

    self.scroll = ngui.find_scroll_view(self.ui,"left_other/animation/scroll_view/panel_list");
    self.wrap = ngui.find_wrap_content(self.ui,"left_other/animation/scroll_view/panel_list/wrap_content");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self.toggle = {};
    for i=1,#EToggleType do
    	self.toggle[i] = {};
    	self.toggle[i].btn = ngui.find_button(self.ui,"left_other/animation/cont/yeka"..i);
    	self.toggle[i].btn:set_on_click(self.bindfunc["on_click_toggle"]);
    	self.toggle[i].btn:set_event_value("", EToggleType[i]);
    end

    self.contBackupHero = {};
    for j=1,2 do
	    for i=1,3 do
	    	local index = (j-1)*3+i
	    	local cont = {};
	    	cont.obj = self.ui:get_child_by_name("right_other/animation/cont"..j.."/big_card_item_80"..i);
	    	cont.card = SmallCardUi:new({parent=cont.obj,stypes = {1,5,6,7,9}});
	    	cont.card:setName(""..index);
	    	cont.card:SetDragStart(self.bindfunc["on_drag_hero_begin"]);
	    	cont.card:SetDragRelease(self.bindfunc["on_drag_hero_end"]);
	    	cont.card:SetDragRestriction(4);
	    	cont.card:SetDragIsClone(true);
	    	cont.btnCancel = ngui.find_button(cont.obj,"btn_cha");
	    	cont.btnCancel:set_on_click(self.bindfunc["on_click_cancel_hero"]);
	    	cont.btnCancel:set_event_value("",index);
	    	cont.objLock = cont.obj:get_child_by_name("sp_suo");
	    	cont.labLock = ngui.find_label(cont.obj,"sp_suo/lab");
	    	for index=1,countHeroAttr do
		    	cont["labAttr"..index] = ngui.find_label(cont.obj,"cont1/txt"..index);
		    	cont["labAttrValue"..index] = ngui.find_label(cont.obj,"cont1/txt"..index.."/lab"..index);
		    end
	    	cont.labCondition = ngui.find_label(cont.obj,"lab_pinzhi");
	    	self.contBackupHero[index] = cont;
	    end
	end

	local _btnSave = ngui.find_button(self.ui,"down_other/animation/btn");
	_btnSave:set_on_click(self.bindfunc["on_save"]);

	local _btnBattle = ngui.find_button(self.ui,"down_other/animation/btn_buleda");
	_btnBattle:set_on_click(self.bindfunc["on_battle"]);

	--[[暂时屏蔽战力显示，避免不同地方显示不同战力有歧义，其他方案未定]]
	local objFightValue = self.ui:get_child_by_name("down_other/animation/sp_fight");
	objFightValue:set_active(false);
	self.labFightValue = ngui.find_label(self.ui,"down_other/animation/sp_fight/lab_fight");
	self.labAttr = {};
	for i=1,countMaxShowAttr do
		self.labAttr[i] = {};
		self.labAttr[i].name = ngui.find_label(self.ui,"right_other/animation/sp_bar/txt"..i);
		self.labAttr[i].name:set_text("");
		self.labAttr[i].value = ngui.find_label(self.ui,"right_other/animation/sp_bar/txt"..i.."/lab1");
		self.labAttr[i].value:set_text("");
	end
	self.labBattleNum = ngui.find_label(self.ui,"right_other/animation/sp_bar/txt_zhuzhen");

	self.cont = {};
    self:on_click_toggle({float_value=EToggleType[1]});
    self:UpdateUi();
end

function WorldBossBackupSystemUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
	for i=1,countMaxShowAttr do
		self.labAttr[i].name:set_text("");
		self.labAttr[i].value:set_text("");
	end

    local level = g_dataCenter.player.level;
    local backupNum = 0;
    local attrList = {};
    for i=1,countMaxBackupNum do
    	local str = PublicFunc.GetHeroRarityStr(self.backupCfg[i].min_rarity);
    	local cont = self.contBackupHero[i];
    	cont.labCondition:set_text(str);
    	if self.listBackupHero[i].uuid then
    		local info = g_dataCenter.package:find_card(1, self.listBackupHero[i].uuid);
    		cont.card:SetData(info);
    		cont.btnCancel:set_active(true);
    		cont.labCondition:set_active(false);
    	else
    		cont.card:SetData();
    		cont.btnCancel:set_active(false);
    		cont.labCondition:set_active(true);
    	end
    	if self.backupCfg[i].open_level > level then
    		cont.objLock:set_active(true);
    		for index=1,countHeroAttr do
		    	cont["labAttr"..index]:set_text("");
		    	cont["labAttrValue"..index]:set_text("");
		    end
    		cont.labCondition:set_active(false);
    		cont.labLock:set_text(self.backupCfg[i].open_level.."级\n解锁");
    	else
    		cont.objLock:set_active(false);
    		local cardInfo = cont.card:GetCardInfo();
    		for index=1,countHeroAttr do
    			local info = self.backupCfg[i].add_property[index];
    			if info then
    				local name = tostring(gs_string_property_name[info.id])
			    	cont["labAttr"..index]:set_text(name);
			    	if cardInfo then
			    		local value = info.add;
			    		if cardInfo:GetFightValue() >= self.backupCfg[i].base_fight_value then
			    			value = value + cardInfo:GetFightValue() * info.ratio;
			    		end
			    		value = PublicFunc.AttrInteger(value);
				    	cont["labAttrValue"..index]:set_text("[00ffa8]+"..value);
				    	attrList[info.id] = (attrList[info.id] or 0) + value;
				    else
				    	cont["labAttrValue"..index]:set_text("+"..info.add);
				    end
				else
					cont["labAttr"..index]:set_text("");
					cont["labAttrValue"..index]:set_text("");
			    end
			end
			if cardInfo then
				backupNum = backupNum + 1;
			end
    	end
    end

	local team = g_dataCenter.player:GetTeam(self.teamId);
    local fightValue = 0;
    for k,uuid in pairs(team) do
    	local card = g_dataCenter.package:find_card(1, uuid);
    	fightValue = fightValue + card:GetFightValue(self.teamId);
    end
    local index = 1;
    for k,v in pairs(ENUM.EHeroAttribute) do
    	local value = attrList[v];
    	if value then
    		value = PublicFunc.AttrInteger(value);
    		local name = tostring(gs_string_property_name[v])
	    	if self.labAttr[index] then
	    		self.labAttr[index].name:set_text(name);
	    		self.labAttr[index].value:set_text(tostring(value));
	    	end
	    	index = index + 1;
	    	local coefficient = ConfigManager.Get(EConfigIndex.t_fight_value, 2)[k];
			if coefficient then
				fightValue = fightValue + value * coefficient
			end
	    end
    end
    self.labFightValue:set_text(tostring(PublicFunc.AttrInteger(fightValue)));
    self.labBattleNum:set_text("助阵"..backupNum.."人");
end

function WorldBossBackupSystemUI:DestroyUi()
	for k,v in pairs(self.contBackupHero) do
		v.card:DestroyUi();
	end
	self.contBackupHero = {};
	for k,v in pairs(self.cont) do
		for kk,vv in pairs(v.item) do
			vv.card:DestroyUi();
		end
	end
	self.cont = {};
    UiBaseClass.DestroyUi(self);
end

function WorldBossBackupSystemUI:ChangePos(begin_pos, end_pos)
	if end_pos == nil then
		return;
	end
	if end_pos == begin_pos then
		return
	end
	local level = g_dataCenter.player.level;
	if self.backupCfg[end_pos].open_level > level then
		return;
	end
	local data = self.listBackupHero[begin_pos].obj:GetCardInfo();
	if not self:CheckBattleConditions(data, end_pos) then
		FloatTip.Float("该英雄不符合最低助阵条件，请重新选择")
		return;
	end
	if self.listBackupHero[end_pos].obj then
		data = self.listBackupHero[end_pos].obj:GetCardInfo();
		if not self:CheckBattleConditions(data, begin_pos) then
			FloatTip.Float("该英雄不符合最低助阵条件，请重新选择")
			return;
		end
	end
	local buff = self.listBackupHero[begin_pos];
	self.listBackupHero[begin_pos] = self.listBackupHero[end_pos];
	self.listBackupHero[end_pos] = buff;
	self:UpdateUi();
end

function WorldBossBackupSystemUI:CheckBattleConditions(info, pos)
	local level = g_dataCenter.player.level;
	if self.backupCfg[pos].open_level > level then
		return false;
	end
	if info == nil then
		return false;
	end
	if info.team_pos < 4 then
		return false;
	end
	if info.realRarity < self.backupCfg[pos].min_rarity then
		return false;
	end
	return true;
end
-----------------------------------------------------
function WorldBossBackupSystemUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    if Utility.isEmpty(self.cont[b]) then
        self.cont[b] = self:init_item(obj)
    end
    self:update_item(self.cont[b], index);
end

function WorldBossBackupSystemUI:init_item(obj)
    local cont = {}
    cont.obj = obj;
    cont.item = {};
    for i=1,countRowNum do
    	local item = {};
	    item.node = obj:get_child_by_name("item"..i.."/big_card_item_80");
	    item.card = SmallCardUi:new({parent=item.node,stypes = {1,5,6,7,9}});
	    item.card:SetCallback(self.bindfunc["on_click_list_hero"]);
	    cont.item[i] = item;
	end
    return cont;
end

function WorldBossBackupSystemUI:update_item(cont, index)
	for i=1,countRowNum do
		local data = self.listShow[countRowNum*(index-1)+i];
		local item = cont.item[i];
		if data then
			item.node:set_active(true);
			item.card:SetData(data);
			if data.team_pos < 4 then
				item.card:SetBattleSpEx(true);
				item.card:SetGray(true, true, false);
				-- item.card:SetClick(false);
			else
				item.card:SetBattleSpEx(false);
				item.card:SetGray(false, true, true);
				-- item.card:SetClick(true);
				for i=1,countMaxBackupNum do
					if self.listBackupHero[i].uuid == data.index then
						self.listBackupHero[i].obj = item.card;
						item.card:SetBattleSpEx(true);
						item.card:SetGray(true, true, false);
						-- item.card:SetClick(false);
					end
				end
			end
		else
			item.node:set_active(false);
		end
	end
end

function WorldBossBackupSystemUI:on_click_toggle(t)
	self.curHeroType = t.float_value;
	self.listShow = {};
    for i=1,#self.listAllHero do
    	local info = self.listAllHero[i];
        if self.curHeroType == ENUM.EProType.All or self.curHeroType == info.pro_type then
        	table.insert(self.listShow, info);
        end
    end
    self.wrap:set_min_index(1-math.ceil(#self.listShow/countRowNum));
    self.wrap:set_max_index(0);
    self.wrap:reset();
    self.scroll:reset_position();
end

function WorldBossBackupSystemUI:on_click_list_hero(obj, info)
	for i=1,countMaxBackupNum do
		if obj:IsGray() then
			if self.listBackupHero[i].uuid == info.index then
				obj:SetBattleSpEx(false);
				obj:SetGray(false, true, true);
				self.listBackupHero[i].uuid = nil;
				self.listBackupHero[i].obj = nil;
				break;
			end
		else
			if not self:CheckBattleConditions(info, i) then
				FloatTip.Float("该英雄不符合最低助阵条件，请重新选择")
				break;
			end
			if self.listBackupHero[i].uuid == nil then
				self.listBackupHero[i].uuid = info.index;
				self.listBackupHero[i].obj = obj;
				obj:SetBattleSpEx(true);
				obj:SetGray(true, true, false);
				-- obj:SetClick(false);
				break;
			end
		end
	end
	self:UpdateUi();
end

function WorldBossBackupSystemUI:on_click_cancel_hero(t)
	local index = t.float_value;
	self.listBackupHero[index].uuid = nil;
	self.listBackupHero[index].obj:SetBattleSpEx(false);
	self.listBackupHero[index].obj:SetGray(false, true, true);
	-- self.listBackupHero[index].obj:SetClick(true);
	self.listBackupHero[index].obj = nil;
	self:UpdateUi();
end

function WorldBossBackupSystemUI:on_drag_hero_begin(src,obj,info)
	-- local begin_pos;
	-- for k,v in pairs(self.listBackupHero) do
	-- 	if v.uuid == info.index then
	-- 		begin_pos = k;
	-- 		break;
	-- 	end
	-- end
end

function WorldBossBackupSystemUI:on_drag_hero_end(src,tar,obj,info)
	if info == nil then
		return;
	end
	local begin_pos,end_pos;
	for k,v in pairs(self.listBackupHero) do
		if v.uuid == info.index then
			begin_pos = k;
			break;
		end
	end
	if begin_pos == nil then
		return;
	end
	if tar and tar:get_parent() then
		end_pos = tonumber(tar:get_parent():get_name());
	end
	self:ChangePos(begin_pos, end_pos);
end

function WorldBossBackupSystemUI:on_save()
	local cards = {};
	for i=1,countMaxBackupNum do
		cards[i] = self.listBackupHero[i].uuid or 0;
	end
	msg_team.cg_update_team_backup_cards(self.teamId, cards);
end

function WorldBossBackupSystemUI:gc_update_team_backup_cards(ret)
	if ret ~= 0 then
		return;
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_WorldBoss_Backup);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Athletic_WorldBox_Backup);
	uiManager:PopUi();
end

function WorldBossBackupSystemUI:on_battle()
	--local showType = ENUM.EShowHeroType.Have;
	local showType = ENUM.EShowHeroType.All;
	local team = g_dataCenter.player:GetTeam(self.teamId);
	local listAllHero = PublicFunc.GetAllHero(showType, nil, team);
	local sort_func = function (a,b)
        if a.team_pos < 4 and b.team_pos == 4 then
            return false;
        elseif b.team_pos < 4 and a.team_pos == 4 then
            return true;
        end
        if a.realRarity > b.realRarity then
            return true;
        elseif a.realRarity < b.realRarity then
            return false;
        end
		if a:GetFightValue() > b:GetFightValue() then
            return true;
        elseif a:GetFightValue() < b:GetFightValue() then
            return false;
        end
        if a.number < b.number then
            return true;
        elseif a.number > b.number then
            return false;
        end
        return false;
	end
    table.sort(listAllHero, sort_func);
    local index = 1;
    for i=countMaxBackupNum,1,-1 do
    	if self:CheckBattleConditions(listAllHero[index], i) then
    		self.listBackupHero[i].uuid = listAllHero[index].index;
    		index = index + 1;
    	else
    		self.listBackupHero[i].uuid = nil;
    	end
    end
    self:UpdateUi();
    self:on_click_toggle({float_value=self.curHeroType});
end
