TongTianTaFightManager = Class("TongTianTaFightManager", EmbattleFightManager)

function TongTianTaFightManager.InitInstance()
	TongTianTaFightManager._super.InitInstance(TongTianTaFightManager)
	return TongTianTaFightManager;
end

function TongTianTaFightManager:EndGuideCallback()
	-- KuiKuLiYaFightBuffUI.Create(FightScene.GetCurHurdleID());
	EmbattleFightManager.EndGuideCallback(self)
end

function TongTianTaFightManager:InitData()
	EmbattleFightManager.InitData(self);

	self.add2MapEntityCache = {}
end

function TongTianTaFightManager:RegistFunc()
	EmbattleFightManager.RegistFunc(self);

	self.bindfunc['OnMiniMapLoaded'] = Utility.bind_callback(self, self.OnMiniMapLoaded);
end

function TongTianTaFightManager:ClearUpInstance()
	EmbattleFightManager.ClearUpInstance(self);
	self.specialHero = false;
	self.specialMonster = false;
end

function TongTianTaFightManager:GetNPCAssetFileList(out_file_list)
	EmbattleFightManager.GetNPCAssetFileList(self, out_file_list)

	local monsterList = ConfigManager.Get(EConfigIndex.t_hurdle_kuikuliya,FightScene.GetLevelID());

	for i=0,12,1 do
		local id = tonumber(monsterList["sbp_"..i]);
		if id ~= 0 then
			filepath = ObjectManager.GetMonsterModelFile(id);
			if filepath then
				out_file_list[filepath] = filepath
			end
		end
	end
end

function TongTianTaFightManager:LoadMonster()
	EmbattleFightManager.LoadMonster(self);
	
	local monsterList = ConfigManager.Get(EConfigIndex.t_hurdle_kuikuliya,FightScene.GetLevelID());
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.monster)
	local newmonster = nil
	if not config then
		return
	end

	for k, ml_v in pairs(config) do
		local id = tonumber(monsterList[ml_v.obj_name]);
		if id ~= nil and id ~= 0 then
			ml_v.id = id;
			newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(ml_v)
			ml_v.id = 0;
			if newmonster then
				self:OnLoadMonster(newmonster);
			end
		end
	end
end

function TongTianTaFightManager:OnLoadHero(entity)
	EmbattleFightManager.OnLoadHero(self, entity)
	-- entity:SetAiEnable(true);
	entity:SetAI(100);
	entity:SetConfig("view_radius", 50);
	entity:SetConfig("act_radius", 100);
	if self.specialHero then
		self:_AttackBuff(entity);
	end

	self:AddToMiniMap(entity)
end

function TongTianTaFightManager:GetAllEffectAssetFileList(out_file_list)
	EmbattleFightManager.GetAllEffectAssetFileList(self, out_file_list);
    local cfg = ConfigManager.Get(EConfigIndex.t_hurdle_kuikuliya,FightScene.GetLevelID())
    if not cfg then return end;
    local effectIdList = {};
    FightManager.GetEffectFileList(out_file_list,cfg.self_buff_id,cfg.self_buff_lv,effectIdList);
    FightManager.GetEffectFileList(out_file_list,cfg.enemy_buff_id,cfg.enemy_buff_lv,effectIdList);
end

function TongTianTaFightManager:OnLoadMonster(entity)
	EmbattleFightManager.OnLoadMonster(self,entity);
	entity:SetConfig("view_radius", 50);
	entity:SetConfig("act_radius", 100);
    local cfg = ConfigManager.Get(EConfigIndex.t_hurdle_kuikuliya,FightScene.GetLevelID())
	if self.specialMonster or (cfg and cfg.enemy_buff_num == -2) then
		self:_AttackBuff(entity);
	end

	self:AddToMiniMap(entity)
end

function TongTianTaFightManager:OnUiInitFinish()
	local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	local str = hurdle.tips_string;
	local time = hurdle.tips_last;

	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	--local configIsAuto = cf.is_auto > 0;
	local configIsAuto = 0;
	local vip_data = g_dataCenter.player:GetVipData();
	if vip_data then
		configIsAuto = vip_data.kuikuliya_can_auto_fight;
	end
	if configIsAuto and configIsAuto == 1 then
		configIsAuto = true;
	else
		configIsAuto = false;
	end
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsShowStarTip = (cf.is_show_star_tip == 1)

	self:StartTime();
	self:SetCameraInitPos();
	-- FightStartUI.Show({need_pause=true});
	-- FightStartUI.SetEndCallback(function ()
	    self:_SetBuff();

		self:CallFightStart()
	-- end)

	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	-- GetMainUI():InitDescription(str, time)
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)
	GetMainUI():InitProgressBar()
	-- GetMainUI():SetAutoBtn(true);
	--fy加入点击事件
	GetMainUI():InitMMOFightUIClick();
	-- local pmi = FightScene.GetStartUpEnv():GetPlayMethod();
	GetMainUI():InitTeamCanChange(true, false)
	GetMainUI():InitTimer()
	-- GetMainUI():InitTouchMoveCamera();
	GetMainUI():InitKuiKuLiYaFightBuffUI(FightScene.GetCurHurdleID())
	-- GetMainUI():InitHurdlePassTip();
	
	GetMainUI():HideBossBlood(true);

	local kkConfig = ConfigManager.Get(EConfigIndex.t_hurdle_kuikuliya,FightScene.GetLevelID());
	if kkConfig.mini_map and kkConfig.mini_map ~= 0 then
		local mapParam = 
		{
			uiPath = kkConfig.mini_map,
			uiMapBkTex = 'Texture',
			iconsParam = 
			{
				[EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = kkConfig.main_hero_adjust_angle},
				[EMapEntityType.EGreenHero] = {nodeName = 'sp_my_follow'},
				[EMapEntityType.EBoss] = {nodeName = 'sp_boss1'},
				[EMapEntityType.ESuper] = {nodeName = 'sp_boss2'},
				[EMapEntityType.ESoldier] = {nodeName = 'sp_red_arrows'},
			},
			adjustAngle = kkConfig.map_adjust_angle,        

			sceneMapSizeName = 'scene_minimap',

			loadedCallback = self.bindfunc['OnMiniMapLoaded'],

			bigMapParam = {
				uiPath = kkConfig.big_map,
				uiMapBkTex = 'Texture',
				iconsParam = 
				{
					[EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = kkConfig.main_hero_adjust_angle},
					[EMapEntityType.EGreenHero] = {nodeName = 'sp_my_follow'},
					[EMapEntityType.EBoss] = {nodeName = 'sp_boss1'},
					[EMapEntityType.ESuper] = {nodeName = 'sp_boss2'},
					[EMapEntityType.ESoldier] = {nodeName = 'sp_red_arrows'},
				},
				adjustAngle = kkConfig.map_adjust_angle,        

				sceneMapSizeName = 'scene_minimap',
			}
		}
		GetMainUI():InitMinimap(mapParam)
		for k,v in ipairs(self.add2MapEntityCache) do
			self:AddToMiniMap(v)
		end
		self.add2MapEntityCache = {}
	end
end

function TongTianTaFightManager:OnMiniMapLoaded(param, minimap)


	local ui = minimap.ui

	local txt = ''

	local _hurdleListCfg = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
	for floor,cfg in pairs(_hurdleListCfg) do
		if cfg.hurdle_id == FightScene.GetLevelID() then
			txt = string.format("%d层", cfg.floorIndex)
		end
	end

	local lab = ngui.find_label(ui, "lab_num")
	lab:set_text(txt)
end

function TongTianTaFightManager:AddToMiniMap(entity)
	local mainui = GetMainUI()
	local minimapui = nil
	if mainui then
		minimapui = mainui:GetMinimap()
	end

	if not mainui and not minimapui then
		table.insert(self.add2MapEntityCache, entity)
		return
	end

	if entity:IsHero() then
		if entity:GetName() == g_dataCenter.fight_info:GetCaptainName() then
			minimapui:AddPeople(entity, EMapEntityType.EMy, true)
		else
			minimapui:AddPeople(entity, EMapEntityType.EGreenHero)
		end
	elseif entity:IsMonster() then
		if entity:IsBoss() then
			minimapui:AddPeople(entity, EMapEntityType.EBoss)
		elseif entity:IsFarSuper() or entity:IsCloseSuper() then
			minimapui:AddPeople(entity, EMapEntityType.ESuper)
		else
			minimapui:AddPeople(entity, EMapEntityType.ESoldier)
		end
	end
end

-----------------------------------------------------------------------------
function TongTianTaFightManager:_SetBuff()
    local cfg = ConfigManager.Get(EConfigIndex.t_hurdle_kuikuliya,FightScene.GetLevelID())
    if not cfg then return end;

	local hero_list = g_dataCenter.fight_info.hero_list;
	local monster_list = g_dataCenter.fight_info.monster_list;
	local myObj = {};
	local enemyObj = {};

	for camp,list in pairs(hero_list) do
		for _,name in pairs(list) do
			local obj = ObjectManager.GetObjectByName(name);
			if camp == 1 then
				myObj[#myObj+1] = obj;
			else
				enemyObj[#enemyObj+1] = obj;
			end
		end
	end
	for camp,list in pairs(monster_list) do
		for _,name in pairs(list) do
			local obj = ObjectManager.GetObjectByName(name);
			if camp == 1 then
				myObj[#myObj+1] = obj;
			else
				enemyObj[#enemyObj+1] = obj;
			end
		end
	end
	if self.monsterTimerId then
		enemyObj[#enemyObj+1] = "special";
	end
	if self.heroTimerId then
		myObj[#myObj+1] = "special";
	end

	if cfg.self_buff_num == -1 then
		for _,obj in pairs(myObj) do
			if obj == "special" then
				self.specialHero =  true;
			else
				self:_AttackBuff(obj);
			end
		end
	else
		local i=1;
		local pos = {};
		while i<=cfg.self_buff_num do
			local rand = math.random(1,#myObj);
			if not pos[rand] then
				pos[rand] = true;
				i = i+1;
				if myObj[rand] == "special" then
					self.specialHero =  true;
				else
					self:_AttackBuff(myObj[rand]);
				end
			end
			if PublicFunc.GetTableLen(pos) == PublicFunc.GetTableLen(myObj) then
				break;
			end
		end
	end

	if cfg.enemy_buff_num == -1 then
		for _,obj in pairs(enemyObj) do
			if obj == "special" then
				self.specialMonster =  true;
			else
				self:_AttackBuff(obj);
			end
		end
	else
		local i=1;
		local pos = {};
		while i<=cfg.enemy_buff_num do
			local rand = math.random(1,#enemyObj);
			if not pos[rand] then
				pos[rand] = true;
				i = i+1;
				if enemyObj[rand] == "special" then
					self.specialMonster =  true;
				else
					self:_AttackBuff(enemyObj[rand]);
				end
			end
			if PublicFunc.GetTableLen(pos) == PublicFunc.GetTableLen(enemyObj) then
				break;
			end
		end
	end
	-------------- vip ----------------
	local cur_vip = g_dataCenter.player:GetVip();
	local vip_cfg = g_dataCenter.player:GetVipData();
	if vip_cfg.jxtz_add_attack and vip_cfg.jxtz_add_attack ~= 0 then
		local buff = vip_cfg.jxtz_add_attack;
		for _,obj in pairs(myObj) do
			obj:AttachBuff(buff.id,buff.lv,obj,obj);
		end
	end
end

function TongTianTaFightManager:_AttackBuff(obj)
    local cfg = ConfigManager.Get(EConfigIndex.t_hurdle_kuikuliya,FightScene.GetLevelID())
    if not cfg then return end;
    if not obj then return end;

	if obj:GetCampFlag() == 1 then
		if cfg.self_buff_id ~= 0 then
			obj:AttachBuff(cfg.self_buff_id,cfg.self_buff_lv,entity,entity);
		end
	else
		if cfg.enemy_buff_id ~= 0 then
			obj:AttachBuff(cfg.enemy_buff_id,cfg.enemy_buff_lv,entity,entity);
		end
	end
end

function TongTianTaFightManager:GetMainHeroAutoFightViewAndActRadius()
    return 50,1000
end

function TongTianTaFightManager:GetFollowHeroAIID()
	return 100;
end