BattleSkillUI = Class('BattleSkillUI',UiBaseClass);
--------------------------------------------------

local _UIText = {
	[1] = "剩余技能点数: %s",
	[2] = "剩余技能点数: %s %s",
	[3] = "%s后获得1点技能点",
	[4] = "购买至%s点技能点，需要|item:%s|%s",
	[5] = "购买技能点",
	[6] = "%s",
	[7] = "角色未解锁",
	[8] = "技能等级不可高于角色等级",
	[9] = "技能等级已经达到最高",
	[10] = "角色达到%s星后可升级",
}

local CountSkillPointMax = 20;
local _PressLvUpDelayTime = 0.3;
local _PressLvUpInterTime = 0.09;

--初始化
function BattleSkillUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_3.assetbundle";
    UiBaseClass.Init(self, data);
end

function BattleSkillUI:SetInfo(info,is_player,package)
	self.roleData = info;
	self.isPlayer = is_player;
	self.package = package;
	self:UpdateUi();
end

--重新开始
function BattleSkillUI:Restart(data)
	UiBaseClass.Restart(self,data);
	self.curIndex = 1;
end

--初始化数据
function BattleSkillUI:InitData(data)
	UiBaseClass.InitData(self,data);
	-- 预处理
	self.skillStar,self.passiveSkillStar,self.haloSkill = PublicFunc.GetSkillOpenLearnInfo();
	self.oneKeyLvUpCfg = ConfigManager.Get(EConfigIndex.t_discrete,83000156);
	-------------------------------

	self.roleData = data.info;
	self.isPlayer = data.isPlayer;
	self.package = data.package;
	self.skillCont = {};
	self.skillInfo = {};
end

--析构函数
function BattleSkillUI:DestroyUi()
	for k,v in pairs(self.skillCont) do
		v.tex:Destroy();
		v.btnPress:Finalize();
		v.btnTip:Finalize();
		delete(v.btnPress);
		delete(v.btnTip);
	end
	if self.timeID then
		timer.stop(self.timeID);
		self.timeID = nil;
	end
	self.skillCont = {};
	self.skillInfo = {};
	self.curIndex = 1;
	UiBaseClass.DestroyUi(self);
end

--注册回调函数
function BattleSkillUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc['on_init_skill_item'] = Utility.bind_callback(self, self.on_init_skill_item);
    self.bindfunc['on_skill_level_up'] = Utility.bind_callback(self, self.on_skill_level_up);
    self.bindfunc['on_skill_press_level_up'] = Utility.bind_callback(self, self.on_skill_press_level_up);
    self.bindfunc['on_press_skill'] = Utility.bind_callback(self, self.on_press_skill);
    self.bindfunc['gc_skill_level_up_rst'] = Utility.bind_callback(self, self.gc_skill_level_up_rst);
    self.bindfunc['gc_update_role_cards'] = Utility.bind_callback(self, self.gc_update_role_cards);
    self.bindfunc["OnBtnLevelUp"] = Utility.bind_callback(self, self.OnBtnLevelUp);
    self.bindfunc["gc_one_key_skill_level"] = Utility.bind_callback(self, self.gc_one_key_skill_level);
    self.bindfunc["on_stop_move_item"] = Utility.bind_callback(self, self.on_stop_move_item);
    self.bindfunc["onClickArrow"] = Utility.bind_callback(self, self.onClickArrow);
end

--注册消息分发回调函数
function BattleSkillUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_skill_level_up_rst, self.bindfunc["gc_skill_level_up_rst"])
    PublicFunc.msg_regist(msg_cards.gc_update_role_cards, self.bindfunc["gc_update_role_cards"])
    PublicFunc.msg_regist(msg_cards.gc_one_key_skill_level, self.bindfunc["gc_one_key_skill_level"])
end

--注销消息分发回调函数
function BattleSkillUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_skill_level_up_rst, self.bindfunc["gc_skill_level_up_rst"])
    PublicFunc.msg_unregist(msg_cards.gc_update_role_cards, self.bindfunc["gc_update_role_cards"])
    PublicFunc.msg_unregist(msg_cards.gc_one_key_skill_level, self.bindfunc["gc_one_key_skill_level"])
end

--初始化UI
function BattleSkillUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self,asset_obj);
	self.ui:set_name("battle_skill");

	path = "centre_other/animation/"
    self.wrap = ngui.find_enchance_scroll_view(self.ui,path.."panel_list");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_skill_item"]);
    self.wrap:set_on_stop_move(self.bindfunc["on_stop_move_item"]);

	self.btnSkill = ngui.find_button(self.ui,"centre_other/animation/sp_diban/btn");
	self.btnSkill:set_on_click(self.bindfunc["OnBtnLevelUp"],"MyButton.NoneAudio");

	self.btnArrow = ngui.find_button(self.ui,"centre_other/animation/panel_btn_arrows/btn");
	self.btnArrow:set_on_click(self.bindfunc["onClickArrow"]);
	self.btnArrowRedPoint = self.ui:get_child_by_name("centre_other/animation/panel_btn_arrows/btn/animation/sp_point");

    self:UpdateUi();
end

function BattleSkillUI:UpdateUi()
	if not self.ui or not self.roleData then
		return;
	end

	self:UpdateSceneInfo();

	self.wrap:set_maxNum(#self.skillInfo);
	self.wrap:refresh_list();
	self.wrap:set_index(1);
	self:on_stop_move_item(1);
end

function BattleSkillUI:UpdateSceneInfo()
	if not self.ui or not self.roleData then
		return;
	end

	self:initSkillInfo();

	local isOpen = self.roleData.rarity >= self.oneKeyLvUpCfg.data;
	if isOpen then
		self.btnSkill:set_active(true);
	else
		self.btnSkill:set_active(false);
	end

	local info = self:CheckOneKeyLvUp();
	if Utility.getTableEntityCnt(info) <= 0 then
		self.btnSkill:set_enable(false);
		PublicFunc.SetButtonShowMode(self.btnSkill, 3, "sprite_background", "lab");
	else
		self.btnSkill:set_enable(true);
		PublicFunc.SetButtonShowMode(self.btnSkill, 1, "sprite_background", "lab");
	end

	for k,v in pairs(self.skillCont or {}) do
		self:update_skill_item(v,v.real_id);
	end
end

function BattleSkillUI:Hide()
	UiBaseClass.Hide(self);
	PopLabMgr.ClearMsg();
	for k,v in pairs(self.skillCont or {}) do
		v.objFx:set_active(false);
	end
end

function BattleSkillUI:CheckOneKeyLvUp()
	local CanLvUpSkillList = {};
	local playerLv = g_dataCenter.player:GetLevel();
	for k,cfg in ipairs(self.skillInfo) do
		if cfg.is_learn and cfg.level < playerLv and cfg.level_up_star <= self.roleData.rarity then
			table.insert(CanLvUpSkillList, {level=cfg.level,skillType=cfg.skillType,id=cfg.id});
		end
	end
	local roleDefRarity = self.roleData.config.default_rarity;
	local roleLv = self.roleData.level;
	local curGold = g_dataCenter.player.gold
	local LvUpList = {};
	local oldSkillInfo = {};

	repeat
		local lvUpSkill = nil;
		local lvUpK = nil;
		local lvUpSkillGold = 0;
		for k,cfg in ipairs(CanLvUpSkillList) do
			repeat 
				if lvUpSkill and lvUpSkill.level <= cfg.level then
					-- app.log("#lhf#有更低等级技能需要升级");
					break;
				end
				if cfg.level >= playerLv then
					-- app.log("#lhf#等级超过玩家等级");
					break;
				end
				if cfg.level >= roleLv then
					-- app.log("#lhf#等级超过卡牌等级");
					break;
				end
				local _, SkillLevelData = PublicFunc.GetSkillCfg(roleDefRarity, cfg.skillType, cfg.id);
				if not SkillLevelData[cfg.level+1] then
					-- app.log("#lhf#找不到配置");
					break;
				end
				local costGold = SkillLevelData[cfg.level+1].levelup_need_gold;
				if costGold > curGold then
					-- app.log("#lhf#金币不足");
					break;
				end
				lvUpSkill = cfg;
				lvUpK = k;
				lvUpSkillGold = costGold;
			until true;
		end
		if lvUpSkill then
			if not oldSkillInfo[lvUpK] then
				oldSkillInfo[lvUpK] = {level=lvUpSkill.level,id=lvUpSkill.id};
			end
			lvUpSkill.level = lvUpSkill.level+1;
			LvUpList[lvUpK]=lvUpSkill;
			curGold = curGold - lvUpSkillGold
		else
			break;
		end
	until false;
	local info = {};
	for k,v in pairs(LvUpList) do
		table.insert(info,{ntype=v.skillType+1,id=v.id,level=v.level});
	end
	return info,oldSkillInfo
end

function BattleSkillUI:OnBtnLevelUp()
	local info,oldSkillInfo = self:CheckOneKeyLvUp();
	if Utility.getTableEntityCnt(info) <= 0 then
		return;
	end
	table.sort(info, function (a,b)
		if a.ntype > b.ntype then
			return false
		elseif a.ntype < b.ntype then
			return true;
		end
		if a.id > b.id then
			return false
		elseif a.id < b.id then
			return true;
		end
		return false;
	end)
	AllSkillLevelUpUI.InitInfo(oldSkillInfo, info,
		self.roleData:GetFightValue(),nil,
		self.roleData.config.default_rarity);
	msg_cards.cg_one_key_skill_level(self.roleData.index,info);
end

function BattleSkillUI:onClickArrow()
	self.curIndex = self.curIndex + 3;
	self.wrap:tween_to_index(self.curIndex);
end

function BattleSkillUI:on_init_skill_item(obj, index)
    local b = obj:get_instance_id();
    if Utility.isEmpty(self.skillCont[b]) then
        self.skillCont[b] = self:init_skill_item(obj)
	end
	obj:set_name("child"..tostring(index))
	self.skillCont[b].real_id = index;
	self.skillCont[b].b = b;
    self:update_skill_item(self.skillCont[b], index);
end

function BattleSkillUI:init_skill_item(obj)
    local cont = {}
    cont.root = obj;
    cont.labName = ngui.find_label(obj,"lab_name");
    cont.labLevel = ngui.find_label(obj,"lab_level");
    cont.spRank = ngui.find_sprite(obj,"texture/sp_art_font");
    cont.tex = ngui.find_texture(obj,"texture");
    cont.labGold = ngui.find_label(obj,"cont/lab");
    cont.labLockDes = ngui.find_label(obj,"txt");
    cont.nodeGold = obj:get_child_by_name("cont");
    cont.btnLvUp = ngui.find_button(obj,"btn");
    cont.btnLvUp:set_on_click(self.bindfunc["on_skill_level_up"], "MyButton.NoneAudio");
    cont.btnPress = ButtonClick:new({obj=cont.btnLvUp, isUpdatePress=true});
    cont.labLock = ngui.find_label(obj,obj:get_name().."/lab_num");
    cont.spBk = ngui.find_sprite(obj,"sp_di");
    cont.spSkillType = ngui.find_sprite(obj,"texture/sp_shine");
    cont.spSkillType:set_active(true);
    cont.objMaxLv = obj:get_child_by_name("sp_effect");
    cont.objFx = obj:get_child_by_name("texture/fx_ui_602_3_sj");
    cont.objFx:set_active(false);
    local btn = ngui.find_button(obj,"texture");
    cont.btnTip = ButtonClick:new({obj=btn});
    return cont;
end

function BattleSkillUI:update_skill_item(cont, index)
    local learnSkill = self.skillInfo[index];
    if not learnSkill then
    	app.log("没有找到技能:"..index.." skill_info:"..table.tostring(self.skillInfo).. debug.traceback());
    	return ;
    end
    local skill_id = learnSkill.id;
    local skill_level = learnSkill.level;
    local skillData, skillLevelData = PublicFunc.GetSkillCfg(self.roleData.config.default_rarity, learnSkill.skillType, skill_id);
	if skillData == nil then
		return 
	end
	cont.labName:set_text(skillData.name);
	cont.tex:set_texture(skillData.small_icon);
	if skillData.rank then
		cont.spRank:set_sprite_name(PublicFunc.GetPassiveSkillRankText(skillData.rank));
	else
		cont.spRank:set_sprite_name("");
	end
	cont.btnTip:SetPress(self.bindfunc["on_press_skill"],index);

	if learnSkill.is_learn then
		if g_dataCenter.player:GetPlayerMaxLv() <= skill_level then
			cont.objMaxLv:set_active(true);
			cont.btnLvUp:set_active(false);
			cont.nodeGold:set_active(false);
		else
			cont.objMaxLv:set_active(false);
			cont.btnLvUp:set_active(true);
			cont.nodeGold:set_active(true);
		end
		-- cont.labLevel:set_active(true);
		cont.tex:set_color(1,1,1,1);
		cont.spBk:set_color(1,1,1,1);
		cont.spSkillType:set_color(1,1,1,1);
	else
		cont.objMaxLv:set_active(false);
		cont.btnLvUp:set_active(false);
		cont.spBk:set_color(0,0,0,1);
		-- cont.labLevel:set_active(false);
		cont.nodeGold:set_active(false);
		cont.tex:set_color(0.5,0.5,0.5,1);
		cont.spSkillType:set_color(0,0,0,1);
	end

	local canLevelUp = false;
	if self.roleData.index ~= 0 then
		if learnSkill.skillType == 1 then
			str = PublicFunc.FormatPassiveSkillString(skillData.simple_describe,learnSkill.id,self.roleData.config.default_rarity,nil,learnSkill.level);
			cont.spSkillType:set_sprite_name("yx_jineng_beidong");
		elseif learnSkill.skillType == 2 then
			str = PublicFunc.FormatHaloSkillString(skillData.simple_describe,learnSkill.id,self.roleData.config.default_rarity,nil,learnSkill.level);
			cont.spSkillType:set_sprite_name("yx_jineng_beidong");
		else
			str = PublicFunc.FormatSkillString(skillData.simple_describe, learnSkill.id, nil, learnSkill.level, self.roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power, false))
			cont.spSkillType:set_sprite_name("yx_jineng_zhudong");
		end
		cont.labLockDes:set_text(str);
		if learnSkill.is_learn then
			local str;
			if learnSkill.level_up_star <= self.roleData.rarity then
				canLevelUp = true;
			end
			cont.labLevel:set_text("[fcd901]"..tostring(skill_level).."[-]级");
			cont.labLock:set_active(false);
		else
			-- cont.labLockDes:set_text(string.format(_UIText[6], tostring(learnSkill.learn_star)));
			cont.labLock:set_active(true);
			cont.labLock:set_text(string.format(_UIText[6], tostring(learnSkill.learn_star)));
			cont.labLevel:set_text("");
		end
	else
		cont.labLockDes:set_text(_UIText[7]);
	end

	local skillnextLevelData = skillLevelData[skill_level+1];
	cont.btnLvUp:set_event_value(""..cont.b,cont.real_id);
	cont.btnPress:SetPress(self.bindfunc["on_skill_press_level_up"], {float_value=cont.real_id,string_value=cont.b});
	if skillnextLevelData then
	    if skill_level >= self.roleData.level or not canLevelUp then
	    	-- cont.btnLvUp:set_event_value("level_max",index);
	    	PublicFunc.SetButtonShowMode(cont.btnLvUp, 3, "sprite_background", "lab");
	    else
	    	-- cont.labBtnLvUp:set_active(true);
			-- cont.btnLvUp:set_event_value("",index);
	    	PublicFunc.SetButtonShowMode(cont.btnLvUp, 1, "sprite_background", "lab");
		end
		local gold = skillnextLevelData.levelup_need_gold;
		if gold <= g_dataCenter.player.gold then
			cont.labGold:set_text(PublicFunc.NumberToStringByCfg(gold));
		else
			cont.labGold:set_text(PublicFunc.GetColorText(PublicFunc.NumberToStringByCfg(gold),"red"));
		end
	else
		-- cont.btnLvUp:set_event_value("skill_level_max",index);
		cont.labGold:set_text("0");
    	PublicFunc.SetButtonShowMode(cont.btnLvUp, 3, "sprite_background", "lab");
	end
end

function BattleSkillUI:on_stop_move_item(index)
	self.curIndex = index;
	self:CheckArrowPoint();
	if self.curIndex+3 > #self.skillInfo then
		self.btnArrow:set_active(false);
	else
		self.btnArrow:set_active(true);
	end
end

function BattleSkillUI:CheckArrowPoint()
	local bCanLvUp = false;
	for index=self.curIndex+3,#self.skillInfo do
		local learnSkill = self.skillInfo[index];
	    if not learnSkill then
	    	app.log("没有找到技能:"..index.." skill_info:"..table.tostring(self.skillInfo).. debug.traceback());
	    	break;
	    end
	    local canLevelUp = false;
		if self.roleData.index ~= 0 then
			if learnSkill.is_learn then
				if learnSkill.level_up_star <= self.roleData.rarity then
					canLevelUp = true;
				end
			end
		end
	    local skill_id = learnSkill.id;
	    local skill_level = learnSkill.level;
	    local _,skillLevelData = PublicFunc.GetSkillCfg(self.roleData.config.default_rarity, learnSkill.skillType, skill_id);
		local skillnextLevelData = skillLevelData[skill_level+1];
		if skillnextLevelData then
		    if skill_level < self.roleData.level and canLevelUp then
				local gold = skillnextLevelData.levelup_need_gold;
				if gold <= g_dataCenter.player.gold then
					bCanLvUp = true;
					break;
				end
			end
		end
	end
	self.btnArrowRedPoint:set_active(bCanLvUp);
end

function BattleSkillUI:on_skill_press_level_up(x, y, state, t)
	if state then
		if not self.bPress then
			-- 刚按下，记录数据
			self._pressTimes = 0;
			self._curGold = g_dataCenter.player.gold;
			self._curTime = app.get_time();
			self._maxSkillLevel = 99;
			local max_skill_level_cfg = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_skill_max_level)
			if max_skill_level_cfg then
				self._maxSkillLevel = max_skill_level_cfg.data
			end
			self.press_begin_time = app.get_time()
			self.levelUpItem = t.string_value;
			self.levelUpIndex = t.float_value;
			self._learnSkill = self.skillInfo[self.levelUpIndex];
		end
		self.bPress = true;
		if app.get_time() - self.press_begin_time < _PressLvUpDelayTime then
			return
		end
		if app.get_time() - self._curTime < _PressLvUpInterTime then
			return;
		end
		self._curTime = app.get_time();
		if not self._learnSkill then
			app.log("没有找到技能:"..self.levelUpIndex.." skill_info:"..table.tostring(self.skillInfo)..debug.traceback());
			return ;
		end
		local skill_id = self._learnSkill.id;
		local skill_level = self._learnSkill.level;
		local _,skillLevelData = PublicFunc.GetSkillCfg(self.roleData.config.default_rarity, self._learnSkill.skillType, skill_id);
		local skillnextLevelData = skillLevelData[skill_level+1];
		if self._learnSkill.level_up_star > self.roleData.rarity then
			-- FloatTip.Float(PublicFunc.GetColorText(string.format(_UIText[10],self._learnSkill.level_up_star), "red"));
			return;
		end
		if skill_level < self._maxSkillLevel and skillnextLevelData then
			if skill_level >= self.roleData.level then
				-- FloatTip.Float(PublicFunc.GetColorText(_UIText[8], "red"))
				return ;
			end
		else
			-- FloatTip.Float(PublicFunc.GetColorText(_UIText[9], "red"))
			return ;
		end
		if skillnextLevelData.levelup_need_gold > self._curGold then
			-- PublicFunc.GetErrorString(MsgEnum.error_code.error_code_money_shortage)
			return ;
		end
		self._learnSkill.level = self._learnSkill.level + 1;
		self._pressTimes = self._pressTimes + 1;
		self._curGold = self._curGold - skillnextLevelData.levelup_need_gold;
		if self.skillCont[tonumber(self.levelUpItem)] then
			self.skillCont[tonumber(self.levelUpItem)].objFx:set_active(false);
		end
		-- 模拟升级成功
		self:gc_skill_level_up_rst();
	else
		local info = {
			{ntype=self._learnSkill.skillType+1,id=self._learnSkill.id,level=self._learnSkill.level},
		};
		if self._pressTimes > 0 then
			msg_cards.cg_one_key_skill_level(self.roleData.index,info);
		else
			self:initSkillInfo();
			for k,v in pairs(self.skillCont or {}) do
				self:update_skill_item(v,v.real_id);
			end
			self.bPress = false;
		end
		self._pressTimes = 0;
	end
end

function BattleSkillUI:on_skill_level_up(t)
	self.levelUpItem = t.string_value;
	self.levelUpIndex = t.float_value;
	if self.skillCont[tonumber(self.levelUpItem)] then
		self.skillCont[tonumber(self.levelUpItem)].objFx:set_active(false);
	end
    local learnSkill = self.skillInfo[self.levelUpIndex];
    if not learnSkill then
    	app.log("没有找到技能:"..self.levelUpIndex.." skill_info:"..table.tostring(self.skillInfo)..debug.traceback());
    	return ;
    end
    local skill_id = learnSkill.id;
    local skill_level = learnSkill.level;
    local _,skillLevelData = PublicFunc.GetSkillCfg(self.roleData.config.default_rarity, learnSkill.skillType, skill_id);
	local skillnextLevelData = skillLevelData[skill_level+1];
    local maxSkillLevel = 99;
    local max_skill_level_cfg = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_skill_max_level)
    if max_skill_level_cfg then
        maxSkillLevel = max_skill_level_cfg.data
    end
    if learnSkill.level_up_star > self.roleData.rarity then
    	FloatTip.Float(PublicFunc.GetColorText(string.format(_UIText[10],learnSkill.level_up_star), "red"));
    	return;
    end
	if skill_level < maxSkillLevel and skillnextLevelData then
	    if skill_level >= self.roleData.level then
			FloatTip.Float(PublicFunc.GetColorText(_UIText[8], "red"))
			return ;
		end
	else
		FloatTip.Float(PublicFunc.GetColorText(_UIText[9], "red"))
		return ;
	end
	if skillnextLevelData.levelup_need_gold > g_dataCenter.player.gold then
		PublicFunc.GetErrorString(MsgEnum.error_code.error_code_money_shortage)
		return ;
	end

	if learnSkill.skillType == 1 then
		msg_cards.cg_passive_property_level_up(self.roleData.index, skill_id);
	elseif learnSkill.skillType == 2 then
		msg_cards.cg_halo_property_level_up(self.roleData.index);
	else
		msg_cards.cg_skill_level_up(self.roleData.index, skill_id);
	end
end

function BattleSkillUI:on_press_skill(x, y, state, param)
	if SkillTips.isShow ~= state then
		if state then
			local learnSkill = self.skillInfo[param];
			if not learnSkill then
				app.log("没有找到技能:"..index.." skill_info:"..table.tostring(self.skillInfo)..debug.traceback());
				return ;
			end
			local skill_id = learnSkill.id;
			local skill_level = learnSkill.level;
			local atk_power = self.roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power, false);
			if learnSkill.skillType == 1 then
				SkillTips.EnableSkillTips(state, skill_id, skill_level, atk_power, x, y, 500, self.roleData.config.default_rarity, 1);
			elseif learnSkill.skillType == 2 then
				SkillTips.EnableSkillTips(state, skill_id, skill_level, atk_power, x, y, 500, self.roleData.config.default_rarity, 2);
			else
				SkillTips.EnableSkillTips(state, skill_id, skill_level, atk_power, x, y, 500);
			end
		else
			SkillTips.EnableSkillTips(state);
		end
	end
end

function BattleSkillUI:initSkillInfo()
	local learnSkillList = {};
	local noLearnSkillList = {};
	self.skillInfo = {};
	--  主动技能
	for i, v in ipairs(self.roleData.config.spe_skill) do

		-- 如果learn_skill为nil，初始化为一个空表
		if self.roleData.learn_skill == nil then
			self.roleData.learn_skill = {};
			for i, v in ipairs(self.roleData.config.spe_skill) do
				-- 根据技能配置初始化learn_skill
				local skill_id = v[1];
				self.roleData.learn_skill[i] = {
					id = skill_id,
					level = 1  -- 默认等级为1
				};
			end
		end

		local learnSkill = self.roleData.learn_skill[i];
		local skill_id = v[1];
		local data = {};
		data.level=1;
		data.skillType=0;
		if learnSkill ~= nil then
			data.id=learnSkill.id;
			data.level = learnSkill.level;
			data.is_learn = true;
			data.level_up_star = self.skillStar[i].level_up;
			table.insert(learnSkillList, data );
		else
			data.is_learn = false;
			data.learn_star = self.skillStar[i].open;
			data.id = skill_id;
			table.insert(noLearnSkillList, data);
		end
	end
	-- 被动技能
		--学习了的被动技能
	local learnlist = {};
	if not self.roleData.learn_passivity_property then
		self.roleData.learn_passivity_property = {};  -- 初始化为空表
		
		-- 根据配置初始化learn_passivity_property
		local cfg = ConfigManager.Get(EConfigIndex.t_role_passive_info, self.roleData.config.default_rarity);
		if cfg then
			for i = 1, 5 do  -- 假设有5个被动技能
				if cfg[i] then
					local data = {
						id = i,  -- 假设id为索引
						level = 1  -- 默认等级为1
					};
					table.insert(self.roleData.learn_passivity_property, data);
				end
			end
		end
	end
		
	for k, learnSkill in ipairs(self.roleData.learn_passivity_property) do
		local cfg = ConfigManager.Get(EConfigIndex.t_role_passive_info, self.roleData.config.default_rarity);
		if cfg and cfg[learnSkill.id] then
			local data = {};
			data.skillType = 1;
			data.id = learnSkill.id;
			data.level = learnSkill.level;
			data.level_up_star = self.passiveSkillStar[data.id].level_up;
			data.is_learn = true;
			learnlist[data.id] = 1;
			table.insert(learnSkillList, data);
		end
	end		
		
		--未学习了的被动技能
	for i=1,5 do
		if learnlist[i] == nil then
			local cfg = ConfigManager.Get(EConfigIndex.t_role_passive_info,self.roleData.config.default_rarity);
			if cfg and cfg[i] then
				local data = {};
				data.skillType = 1;
				data.is_learn = false;
				data.level = 1;
				data.id = i;
				data.learn_star = self.passiveSkillStar[i].open;
				table.insert(noLearnSkillList, data);
			end
		end
	end

	--  光环技能
	local cfg_name = EConfigIndex["t_halo_property_"..self.roleData.config.default_rarity];
	if cfg_name then
		local skillLevelData = ConfigManager._GetConfigTable(cfg_name);
		if skillLevelData then
			local data = {};
			data.skillType = 2;
			data.id = 1;
			data.learn_star = self.haloSkill;
			data.level_up_star = self.haloSkill;
			if not self.roleData.halo_level or self.roleData.halo_level == 0 then
				data.level = 1;
				data.is_learn = false;
				table.insert(noLearnSkillList, data);
			else
				data.level = self.roleData.halo_level;
				data.is_learn = true;
				table.insert(learnSkillList, data );
			end
		end
	end

	-- 合并learnSkill和noLearnSkill
	for i=1,#learnSkillList do
		table.insert(self.skillInfo, learnSkillList[i]);
	end
	for i=1,#noLearnSkillList do
		table.insert(self.skillInfo, noLearnSkillList[i]);
	end
end

function BattleSkillUI:gc_skill_level_up_rst(result)
	local item = self.skillCont[tonumber(self.levelUpItem)];
    local learnSkill = self.skillInfo[self.levelUpIndex];
    if not learnSkill then
    	app.log("没有找到技能:"..tostring(self.levelUpIndex).." skill_info:"..table.tostring(self.skillInfo)..debug.traceback());
    	return ;
    end
    item.objFx:set_active(true);

    local skill_id = learnSkill.id;
    local skill_level = learnSkill.level;
    local skill_info, skillLevelData = PublicFunc.GetSkillCfg(self.roleData.config.default_rarity, learnSkill.skillType, skill_id);
	local attrList;
    if learnSkill.skillType == 1 then
	    attrList = self:_FormatPassiveAttr(skill_info.levelup_info, skill_id, skill_level-1, skill_level);
    elseif learnSkill.skillType == 2 then
	    attrList = self:_FormatHaloAttr(skill_info.levelup_info, skill_id, skill_level-1, skill_level);
    else
	    attrList = self:_FormatAttr(skill_info.levelup_info, skill_id, skill_level-1, skill_level);
	end
	local x,y,z = item.root:get_position();
	PopLabMgr.ClearMsg();
	for k,v in ipairs(attrList) do
		local data = {};
		data.world_pos = {x=x,y=y,z=z};
		data.str = v;
		PopLabMgr.PushMsg(data);
	end

	if not self.bPress then
		self:initSkillInfo();
	end
	self:update_skill_item(item,self.levelUpIndex)

	AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUpNormal)
end

function BattleSkillUI:gc_one_key_skill_level(result, role_dataid, skills)
    local show = PublicFunc.GetErrorString(result);
    if not show then
		self.bPress = false;
		return;
    end
	if self.bPress then
		self.bPress = false;
		return ;
	end
	AllSkillLevelUpUI.Start(nil, nil, nil, self.roleData:GetFightValue(), nil);
end

function BattleSkillUI:gc_update_role_cards()
	self:initSkillInfo();
end

function BattleSkillUI:_FormatAttr(str, skill_id, old_lv, new_lv)
	local list = {};
	local items = Utility.lua_string_split(str,"|");
	for k,v in ipairs(items) do
		local str,value = PublicFunc.FormatSkillString(v, skill_id, old_lv, new_lv, self.roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power, false))
		if str ~= "" and value ~= 0 then
			table.insert(list,str);
		end
	end
	return list;
end

function BattleSkillUI:_FormatPassiveAttr(str, skill_id, old_lv, new_lv)
	local list = {};
	local items = Utility.lua_string_split(str,"|");
	for k,v in ipairs(items) do
		local str,value = PublicFunc.FormatPassiveSkillString(v, skill_id, self.roleData.config.default_rarity, old_lv, new_lv)
		if str ~= "" and value ~= 0 then
			table.insert(list,str);
		end
	end
	return list;
end

function BattleSkillUI:_FormatHaloAttr(str, skill_id, old_lv, new_lv)
	local list = {};
	local items = Utility.lua_string_split(str,"|");
	for k,v in ipairs(items) do
		local str,value = PublicFunc.FormatHaloSkillString(v, skill_id, self.roleData.config.default_rarity, old_lv, new_lv)
		if str ~= "" and value ~= 0 then
			table.insert(list,str);
		end
	end
	return list;
end
