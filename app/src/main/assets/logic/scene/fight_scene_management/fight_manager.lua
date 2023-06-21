-- region fight_manager.lua
-- Author : kevin
-- Date   : 2015/8.18
-- fight manager.



FightManager = Class("FightManager")

--FightManager Base
--[[
FightManager = {
	--members:
	fightCommonConfig = nil, --FightCommonConfig
	fightTeams = nil, --<list<class: FightTeam>。 如果是RPG闯关， 则定义对手Team为ghost


	--<functions>
	--1. 对象asset资源管理, TODO: (kevin)如果有超级多种类的怪物的塔防，考虑逐步加载创建的方式。。。。
	--配置文件中的初始对象列表
	GetDefaultNPCFileList = nil,
	GetDefaultItemFileList = nil,
	GetDefaultHeroFileList = nil,

	OnUpdate = nil,
	Start = nil,	
	CheckOver = nil,

	--重生管理
	GetObjDeadPolicy = nil,
	GetObjRelivePolicy = nil,	
	CheckObjRelive = nil, 

	--event: TODO: (kevin) functions or callback ?
	OnEvent_TimeUP = nil,
	OnEvent_ObjDead = nil,

	--启动/结果接口
	--startup inf 来自 FightScene

	-- CurDeadList
	-- curDeadList["boss"] = name
	-- curDeadList["monster"] = name
	-- curDeadList["base"] = name
}
--]]
function FightManager.AddPreLoadRes(res, out_file_list)
	local t = type(res)

	if t == 'string' then
		out_file_list[res] = res;
	elseif t == 'table' then
		for k, v in pairs(res) do
			out_file_list[v] = v
		end
	end
end

function FightManager:InitData()
	-- TODO: kevin 要给默认的关卡FightManger重新定义一个类
	-- self.runAsDefaultFightManager = false;

	self.fightScript = nil
	self.timeStamp_s = 0
	self.countDownTimer = 0 -- 赋初值，避免某些情况进战斗未立即初始化就失败的bug
	self.fightRecord = nil
    self.cur_value = 0.12
    self.curDeadList = {};
	--self.fightTeams = {}

	--TODO: (kevin) 如果是一场录像的话,切换玩家涉及到localplayer的切换
	-- self.localPlayer = nil
	self.localPlayerTeamFlag = nil

	local cfg = FightScene.GetStartUpEnv().levelData
 
	self.passCondition = {
		win = {check = cfg.win_condition, flag = false},
		lose = {check = cfg.lose_condition, flag = false},
		good = {check = cfg.good_condition, flag = false},
		perfect = {check = cfg.perfact_condition, flag = false},
	}


	self.tickCount = 0;
	self.last_seconds = 0;
	self.tickTimer = nil
	----self.countDownSec = 0;
	local hurdleConfig = FightScene.GetHurdleConfig()
	self.isCountDown = hurdleConfig.is_count_down ~= 0
	--self.isCountDown = 1 ~= 0
	self.heroFightAI = hurdleConfig.hero_fight_ai or hurdleConfig.auto_fight_ai
	--self.heroFightAI = nil

	self.monsterLoader = MonsterLoader:new()
	self.buffLoader = BufferLoader:new()
	local data = {};
	data.create_monster = {self.OnCreateMonster,self};
	data.begin_wave = {self.OnBeginWave,self};
	data.end_wave = {self.OnEndWave,self};
	data.begin_groud = {self.OnBeginGroud,self};
	data.end_groud = {self.OnEndGroud,self};
	data.kill_wave = {self.OnKillWave,self};
	data.kill_groud = {self.OnKillGroud,self};
	self.monsterLoader:SetCallback(data);
	self.npcObjName = {};
    self.fightOver = false 
    self.mainHeroAI = nil

	self.isOpenNPC = false;
    self.firstTriggerRecord = {}
    if FightRecord then
    	FightRecord.Clear()
    end
	local env = FightScene.GetStartUpEnv();
	--self.dataCenter = g_dataCenter.activity[env:GetPlayMethod()];
	self.dataCenter = nil;
    self.canRecoverInFight = false

    self.openedBoxDropID = {}

    self.bindfunc = {};
    self:RegistFunc();
	self:MsgRegist();
end

-- function FightManager:RunAsDefaultFightManager(flag)
-- 	self.runAsDefaultFightManager = flag
-- end

function FightManager:RegistFunc()
    self.bindfunc['CheckUILoadIsComplete'] = Utility.bind_callback(self, self.CheckUILoadIsComplete);
    self.bindfunc['OnScreenPlayOver'] = Utility.bind_callback(self, self.OnScreenPlayOver);
    NoticeManager.BeginListen(ENUM.NoticeType.ScreenPlayOver, self.bindfunc["OnScreenPlayOver"])
end

function FightManager:UnRegistFunc()
	NoticeManager.EndListen(ENUM.NoticeType.ScreenPlayOver, self.bindfunc["OnScreenPlayOver"])
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function FightManager:MsgRegist()
end
function FightManager:MsgUnRegist()
end

function FightManager:InitInstance()
	app.log("进入关卡:"..FightScene.GetLevelID())

	self:InitData()
end

function FightManager:ClearUpInstance()
	--for k, v in pairs(self.fightTeams) do
	--	delete(v)
	--end
	--self.fightTeams = nil

	self:MsgUnRegist();
	self:UnRegistFunc();

	if self.dataCenter and self.dataCenter.ClearData then
		self.dataCenter:ClearData();
		self.dataCenter = nil;
	end
    g_dataCenter.fight_info:ClearUp()
	self.passCondition = nil
	self.fightScript = nil
	if self.monsterLoader then
		self.monsterLoader:Destroy();
	end
	self.monsterLoader = nil;
	if self.buffLoader then
		self.buffLoader:Destroy();
	end
	self.buffLoader = nil;

	self:StopCountTimer()

	self:_StopTickTimer()
end

function FightManager:StopCountTimer()
	if self.countDownTimer ~= nil then
		timer.stop(self.countDownTimer)
		self.countDownTimer = nil
	end 
end

--设置战斗规则脚本
function FightManager:SetFightScript(script)
	self.fightScript = script
	-- TODO: (kevin) 修改npcloader和LoadSceneObject
	if self.monsterLoader then
		self.monsterLoader:SetScript(self:GetFightScript())	
	end
	self.buffLoader:SetScript(self:GetFightScript());
end

function FightManager:GetFightScript()
	return self.fightScript;
end

function FightManager:GetBuffLoader()
	return self.buffLoader
end

--设置战斗地图配置
function FightManager:SetFightMapInfoID(id)
	self.mapInfoId = id;
end

function FightManager:GetFightMapInfoID()
	return self.mapInfoId;
end

function FightManager:GetFollowHeroAIID()
    return self.followHeroUsedAI
end

function FightManager:SetMainHeroAI(id)
    self.mainHeroAI = id

end

function FightManager:GetMainHeroAI()
    return self.mainHeroAI
end


function FightManager:Start()
    FxClicked.SetEnable(false)
    NoticeManager.Notice(ENUM.NoticeType.FightStartBegin, FightScene:GetCurHurdleID());
    if PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
    	msg_hurdle.cg_attribute_verify_start(FightScene.GetPlayMethodType(), FightScene.GetCurHurdleID())
	end
    --非战斗场景隐藏
    if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
    	Root.get_root_ui_2d_fight():set_active(true);
    	Root.uicamera:set_uicamera_multi_touch(true)
    else
    	Root.get_root_ui_2d_fight():set_active(false);
    	Root.uicamera:set_uicamera_multi_touch(false)
	end
	self.lastRelaxAudioTime = system.time();
	local t = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_relaxAudioIntervalTime).data
	self.RelaxAudioIntervalTime = math.random(t[1],t[2])
	
	self.ser_no = Utility.GenNextGUID()
	FightRecord.SetLevelID(FightScene.GetLevelID())

	--self:LoadFightPlayer()
	FightKeyFrameInfo.Init()
	self:LoadSceneObject()

	self.fightOver = false
	
	self:OnStart()
	if system.check_time_id == nil and FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
		system.check_time_id = timer.create('system.check_cheater', 3000, -1)
	end
end

function FightManager:GetHurdleTime()
	return app.get_time() - self.timeStamp_s;
end

function FightManager.CalcIsAutoFight(hurdleid)

	if hurdleid == nil then return false end

	local isAuto = false
	--是否自动战斗
	local hurdle = ConfigHelper.GetHurdleConfig(hurdleid);
	if hurdle == nil then return false end
	--app.log("hurdle is auto==========="..hurdle.is_auto)
	local hurdle_isAuto = hurdle.is_auto
	local groupid = hurdle.groupid
	local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_hurdleAutoFightOpenHurdleId);
    if cf then
    	if g_dataCenter.player.level >= cf.data then
			--只对关卡有效
			if groupid > 0 and hurdle_isAuto == 1 then
				
				isAuto = g_dataCenter.setting:GetFightAutoFile()
				--引导自动战斗时，初始不开启
				if GuideManager.GetConfigFunctionId() == MsgEnum.eactivity_time.eActivityTime_AutoFight then
					isAuto = false
				end
				
				-- if isAuto then
			   	-- 	g_dataCenter.player:ChangeFightMode(true)
			    -- else
			    -- 	g_dataCenter.player:ChangeFightMode(false)
			    -- end
			else
				if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
					--local startUpInf = FightScene.GetStartUpEnv()
	            	local typeid = hurdle.fight_type
					--local typeid = hurdle.hurdleid
					
					if FightManager.IsMethodEnableAutoFight(typeid, hurdleid, hurdle_isAuto) then
						local method_name = "method"..tostring(typeid)
						if g_dataCenter.setting == nil then
							g_dataCenter.setting = SettingDataCenter:new()
						end
						isAuto = g_dataCenter.setting:GetFightMethodAutoFile(method_name)
					end
	            	
	            	-- if isAuto then
	            	-- 	g_dataCenter.player:ChangeFightMode(true)
	            	-- else
	            	-- 	g_dataCenter.player:ChangeFightMode(false)
	            	-- end
				end
			end
		end
	end

	return isAuto
end

function FightManager.IsMethodEnableAutoFight(fight_type, hurdleid, hurdle_isAuto)
	local result = true

	local config = ConfigManager.Get(EConfigIndex.t_fight_type, fight_type)
	if config then
		if config.type_name == 'HeroTrial' then
			if hurdle_isAuto == 0 then
				result = false
			end
			-- config = ConfigManager.Get(EConfigIndex.t_hero_trial_hurdle_info, hurdleid)
			-- if config and config.forbid_auto == 1 then
			-- 	result = false
			-- end
		end
	end

	return result;
end

function FightManager:EndScreePlay()
    local startUpInf = FightScene.GetStartUpEnv()
	-- 是否开启技能UI
	if startUpInf.levelData.openSkillShow == 1 then
		SkillShowUI.Create();
	end

	--g_dataCenter.player:ChangeFightMode(self.CalcIsAutoFight(FightScene.GetLevelID()))

    self:EndGuideCallback();
end

function FightManager:EndGuideCallback()
	if self.countDownTimer then
		timer.resume(self.countDownTimer);
	end
	if self.tickTimer then
		timer.resume(self.tickTimer);
	end
	if self.monsterLoader then
		self.monsterLoader:OnStart()
	end
	if self.buffLoader then
		self.buffLoader:OnStart();
	end
	self.timeStamp_s = app.get_time()
	self:RealStartFight();
	local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
	for k,v in pairs(hero_list) do
		local obj = ObjectManager.GetObjectByName(v);
		if obj then
			obj:HandleInitSkillCD()
		end
	end
	hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_enemy_flag)
	for k,v in pairs(hero_list) do
		local obj = ObjectManager.GetObjectByName(v);
		if obj then
            obj:HandleInitSkillCD()
		end
	end
end

function FightManager:OnStart()
	if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
		ObjectManager.last_attribute_verify_time = 0
	end
end

--一般在多个回合的关卡中存在。。。
function FightManager:Restart()
	-- TODO: (kevin) UI的重新设置
	self:ReLoadSceneObject()
	self:_SetTickTick()
end

function FightManager:GetCreateEntityPolicy()
	return false, nil
end

function FightManager:ReLoadSceneObject()
	self:ClearHero()
	self:ClearNPC()
	self:ClearMonster()
	self:LoadSceneObject()
end

function FightManager:ClearAllObject()
	self:ClearHero()
end

function FightManager:ClearHero()
    for i=EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        local hero_list = g_dataCenter.fight_info:GetHeroList(i)
	    for k, v in pairs(hero_list) do
		    FightScene.DeleteObj(v,0);
	    end
    end
	g_dataCenter.fight_info:ClearHeroList()
end

function FightManager:ClearMonster()
    for i=EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        local monster_list = g_dataCenter.fight_info:GetMonsterList(i)
	    for k, v in pairs(monster_list) do
		    FightScene.DeleteObj(v,0);
	    end
    end
    g_dataCenter.fight_info:ClearMonsterList()
end

function FightManager:ClearNPC()
    for i=EFightInfoFlag.flag_a, EFightInfoFlag.flag_max do
        local npc_list = g_dataCenter.fight_info:GetNPCList(i)
	    for k, v in pairs(npc_list) do
		    FightScene.DeleteObj(v,0);
	    end
    end
    g_dataCenter.fight_info:ClearNPCList()
end


function FightManager:LoadSceneObject()
	self:LoadHero()
	self:LoadMonster()
	self:LoadItem()
	self:LoadUI()
	self:LoadNPC();
	self:LoadFinish();
end

function FightManager:LoadHero()
    local player_id = g_dataCenter.player:GetGID()
    --local hero_id = {30001045}
    local hero_index = 1
    local env = FightScene.GetStartUpEnv()
    local cfg = env.levelData;
    local hero_limit;
    if not cfg.hero_limit or cfg.hero_limit == 0 then
		hero_limit = 3;
	else
		hero_limit = cfg.hero_limit;
    end
    for camp_flag, teamData in pairs(env.fightTeamInfo) do
        local heroBPList = {}
        local heroBPPos_index = 1
        LevelMapConfigHelper.GetHeroBornPosList(camp_flag, heroBPList)
        app.log('pos = ' .. camp_flag .."  hero_limit="..tostring(hero_limit).. '  ' .. table.tostring(heroBPList))
        if #heroBPList ~= 0 then
		    for gid, player in pairs(teamData.players) do
		    	local hero_num = 0;
		       	for k, heroid in pairs(player.hero_card_list) do
		       		hero_num = hero_num + 1;
		       		if hero_num > hero_limit then
		       			return true;
		       		end
				    card = player.package_source:find_card(ENUM.EPackageType.Hero, heroid)
		            if hero_id then
                        if hero_id[hero_index] then
                            local hero = FightScene.CreateHeroAsync(player_id, hero_id[hero_index], g_dataCenter.fight_info.single_friend_flag, 0, 1, heroid, g_dataCenter.package)
		                    hero:SetPosition(heroBPList[heroBPPos_index].px, heroBPList[heroBPPos_index].py, heroBPList[heroBPPos_index].pz)
		                    hero:SetBornPoint(heroBPList[heroBPPos_index].px, heroBPList[heroBPPos_index].py, heroBPList[heroBPPos_index].pz)
                            PublicFunc.UnifiedScale(hero)
							hero_index = hero_index+1
                        end
                    else
                        if card then
	    	                self:LoadSingleHero(camp_flag, gid, player.package_source, heroid, heroBPList[heroBPPos_index])
                        end
                    end
		            heroBPPos_index = Utility.getNextIndexLoop(heroBPPos_index, 1, #heroBPList, true)
			    end 
		    end
        end
	end

	return true;
end

function FightManager:LoadSingleHero(camp_flag, player_id, package_source, cardHuman_id, pos_inf)

    if pos_inf == nil then
        app.log('xxx  ' .. debug.traceback())
    end

	if cardHuman_id ~= nil and 0 ~= cardHuman_id then
		-- local cardHuman = v.package_source:find_card(1, v)
		--TODO: (kevin) 背包。。。。。
		local hero_id = 0
		local hero_level = 1

		local cardHuman = package_source:find_card(ENUM.EPackageType.Hero, cardHuman_id)
		if lua_assert(cardHuman ~= nil, "FightManager:_LoadHero nil hero. hur="..tostring(FightScene.GetCurHurdleID())) then
			return false
		end
		if cardHuman == nil then return end;
		hero_id = cardHuman.number
		hero_level = cardHuman.level
		--hero是sceneEntity的一个对象
		local hero = FightScene.CreateHeroAsync(player_id, hero_id, camp_flag, 0, hero_level, cardHuman_id, package_source)
	    hero:SetPosition(pos_inf.px, pos_inf.py, pos_inf.pz)
		hero:SetBornPoint(pos_inf.px, pos_inf.py, pos_inf.pz)
		PublicFunc.UnifiedScale(hero)
        hero:SetRotation(0, pos_inf.ry, 0)
		self:OnLoadHero(hero);

        g_dataCenter.fight_info:DelDelayLoadHero(camp_flag, cardHuman_id)

        return hero
	end
end

--使用package中原始card，适用于远征玩法这种临时构建的含不同属性，buff加成的card数据
function FightManager:LoadSingleHeroByCardData(camp_flag, player_id, card_data, pos_inf)
	if pos_inf == nil then
        app.log('xxx  ' .. debug.traceback())
    end

	if card_data and card_data.number ~= 0 then
		local hero = FightScene.CreateTrialHeroAsync(player_id, card_data, camp_flag, card_data.number)
	    hero:SetPosition(pos_inf.px, pos_inf.py, pos_inf.pz)
		hero:SetBornPoint(pos_inf.px, pos_inf.py, pos_inf.pz)
		PublicFunc.UnifiedScale(hero)
        hero:SetRotation(0, pos_inf.ry, 0)
		self:OnLoadHero(hero);

        g_dataCenter.fight_info:DelDelayLoadHero(camp_flag, card_data.number)

        return hero
	end
end

function FightManager:OnLoadHero(entity)
	if entity:IsMyControl() and PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) and entity:GetCardInfo() then
		msg_hurdle.cg_attribute_verify_create_hero(FightScene.GetPlayMethodType(), entity:GetCardInfo().index, entity:GetGID())
		entity:CheckAttribute()
	end
end

function FightManager:OnEntityModelChanged(entity)
end

--function FightManager:SetParam(obj, param)
--    if obj == nil or param == nil then 
--        return
--    end    

--    if param.path ~= nil then
--        local path = LevelMapConfigHelper.GetWayPoint(param.path, true)
--        if path ~= nil and #path > 0 then 
--            obj:SetPatrolMovePath(path)

--            if param.loop == '1' then 
--                obj:SetAlongPathLoop(true)
--            end

--        end
--    end

--    if param.be_attack_order ~= nil then
--        obj:SetBeAttackOrder(tonumber(param.be_attack_order))
--    end
--end

-- 各玩法战斗管理器重新改方法
function FightManager:GetMonsterLevel()
	return 1
end

function FightManager:LoadMonster()
	--1. 场景配置中的
	--2. 其他的由各个派生系统各自加载

	-- 先找配置ConfigManager.Get(EConfigIndex.t_hurdle_id_entity,	-- 先找配置gd_hurdle_id_entity)	-- 先找配置gd_hurdle_id_entity
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.monster)
	local newmonster = nil
	if not config then
		return
	end

	for k, ml_v in pairs(config) do
		if ml_v.id ~= nil and ml_v.id ~= 0 then
			newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(ml_v)
			if newmonster then
				self:OnLoadMonster(newmonster);
			end
		end
	end

	--TODO: (kevin) 默认怪物刷新需要完善
	--[[
	-- 注册timer
	config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.burchmonster)
	if not config then
		return
	end
	for k,ml_v in pairs(config) do
		if ml_v.at then
			local func = Utility.create_callback(FightScene.BurchAt, ml_v, FightScene.CreateNPC);
			timer.create(func, ml_v.at, 1);
		else
			local funcname = Utility.gen_callback(FightScene.BurchInterval,nil, ml_v,FightScene.CreateNPC)
			table.insert(FightScene.burchFunc,funcname);
			local timerid = timer.create(funcname,ml_v.i,ml_v.c);
			table.insert(FightScene.burchMonsterTimer,timerid); 
		end
	end
	--]]
end

function FightManager:OnLoadMonster(entity)
	-- app.log("FightManager:OnLoadMonster base")
	local boss_id;
	local hurdleID = FightScene.GetCurHurdleID();
	local config = ConfigManager.Get(EConfigIndex.t_screenplay_config,hurdleID);
	self.screenPlay_audio_count = {};
	if not config then
		return
	end
	for k,v in pairs(config) do
		local play_id = v.playid;
		if play_id == nil then
 			app.log("剧情对话g_get_screenplay_config的playid为空");
			return
		end
		local content = ConfigManager.Get(EConfigIndex.t_screenplay_content,play_id);
		if content == nil then
			app.log("剧情对话g_get_screenplay_config的playid对应的g_get_screenplay_content为空");
		end
		if v.triggerid == 0 then
--			app.log_warning("剧情对话触发器为 0！"..table.tostring(v));
		else
			for k1,v1 in pairs(content) do
				if v1.actiontype == "func" and type(v1.action) == "table"  then
					if v1.action.boss then
						if entity:GetCardInfo().number == v1.action.boss then
							TriggerFunc.FightBossEntity = entity;
							entity:PostEvent(AIEvent.PAUSE);
							entity:Show(false);
							entity:HideHP(true);
						end
						break;
					end
				end
			end
		end
	end
end

function FightManager:LoadItem()
	if MAP_RESTORE_DEBUG then
		app.log('map_debug'..tostring(FightScene.GetCurHurdleID())..' 场上道具')
	end

	-- 先找配置ConfigManager.Get(EConfigIndex.t_hurdle_id_entity,	-- 先找配置gd_hurdle_id_entity)	-- 先找配置gd_hurdle_id_entity
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.item)
	-- 创建对象	
	if MAP_RESTORE_DEBUG then
		--app.log('huhu_map_debug'..tostring(FightScene.GetCurHurdleID())..' 创建对象'..table.tostring(config))
	end
	local new_item = nil
	if not config then
		return
	end
	-- 按顺序初始化(以便于查找对应Item)
	for k, ml_v in ipairs(config) do
		new_item = PublicFunc.CreateItemFromMapinfoConfig(ml_v)
		if new_item then
			self:OnLoadItem(new_item);
		end
	end	
end

function FightManager:OnLoadItem(entity)
end

function FightManager:LoadUI()

    if FightScene.isResume ~= true then 
	    uiManager:PushUi(EUI.MMOMainUI)
        self.checkUILoadingTimerID = timer.create(self.bindfunc['CheckUILoadIsComplete'], 50, -1)
    end

    self:SetHeroTeamAI()
	self:SetCameraInitPos();
end

function FightManager:StopCheckUILoadingTimer()
    if self.checkUILoadingTimerID then
	    timer.stop(self.checkUILoadingTimerID)
	    self.checkUILoadingTimerID = nil
	end
end

function FightManager:CheckUILoadIsComplete()
    local mainui = GetMainUI()
    if mainui then
        if mainui:IsLoaded() then
        	self:StopCheckUILoadingTimer()

            app.opt_enable_net_dispatch(true);
            --Socket.StartPingPong()

            -- 战斗UI加载完成，通知一下
		    NoticeManager.Notice(ENUM.NoticeType.FightUiLoadComplete, FightScene:GetCurHurdleID());
        end
    else
        app.log_warning('CheckUILoadIsComplete maini == nil')
    end
end

function FightManager:SetHeroTeamAI()

    if g_dataCenter.fight_info:GetControlHero(1) == nil then
        return
    end

    g_dataCenter.player:ChangeCaptain(1, nil, nil, true)

    local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
    for k, v in pairs(hero_list) do
        local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
        if teamIndex ~= 1 then
            local obj = ObjectManager.GetObjectByName(v)
            obj:SetAiEnable(true)
        end
    end
end

function FightManager:SetCameraInitPos()
    local point = LevelMapConfigHelper.GetHeroBornPoint('cam_pos')
    if point then
	    CameraManager.LookToPos(Vector3d:new({x = point.px, y = point.py, z = point.pz}))
	end
end

function FightManager:LoadFinish()
	
end

function FightManager:GetPreLoadPolicy()
	return {preload_hero=true, preload_npc=true}
end

function FightManager:GetPreLoadAssetFileList(out_file_list)

	local preload_policy = self:GetPreLoadPolicy()
	
	if preload_policy.preload_hero then
		self:GetHeroAssetFileList(out_file_list)
	end

	if preload_policy.preload_npc then
		self:GetNPCAssetFileList(out_file_list)
	end

	self:GetItemAssetFileList(out_file_list)
	self:GetBasicUIAssetFileList(out_file_list);
	self:GetUIAssetFileList(out_file_list)
	self:GetScreenPlayAssetFileList(out_file_list);
	self:GetOtherAssetFileList(out_file_list)
	self:GetAllEffectAssetFileList(out_file_list);

	local effect_list = {1700009,1700005,1700011,1700013,1700008 }
	for k, v in pairs(effect_list) do
		local cfg = ConfigManager.Get(EConfigIndex.t_all_effect, v)
		if nil ~= cfg and nil ~= cfg.file then
			out_file_list[cfg.file] = file
		end
	end
end

function FightManager:GetPreLoadTextureFileList(out_file_list)
	local file_list = {};
	local hurdleID = FightScene.GetCurHurdleID();
	local config = ConfigManager.Get(EConfigIndex.t_screenplay_config,hurdleID);
	self.screenPlay_texture_count = {};
	if not config then
		return
	end
	for k,v in pairs(config) do
		local play_id = v.playid;
		local content = ConfigManager.Get(EConfigIndex.t_screenplay_content,play_id);
		for k1,v1 in pairs(content) do
			if v1.icon_path and v1.icon_path ~= 0 then
				if not self.screenPlay_texture_count[v1.icon_path] then
					self.screenPlay_texture_count[v1.icon_path] = 1;
					table.insert(file_list,v1.icon_path);
				else
					self.screenPlay_texture_count[v1.icon_path] = self.screenPlay_texture_count[v1.icon_path] + 1;
				end
			end
		end
	end


	for k, v in pairs(file_list) do
		out_file_list[v] = v
	end

end

function FightManager:GetHeroAssetFileList(out_file_list)
	local env = FightScene.GetStartUpEnv()

	local card_human = nil;


	--app.log(">>>"..table.tostring(env));

	for k, v in pairs(env.fightTeamInfo) do
		for kk, vv in pairs(v.players) do
			for kkk, vvv in pairs(vv.hero_card_list) do
				card_human = vv.package_source:find_card(1, vvv)
				if nil ~= card_human then
                    ObjectManager.GetHeroPreloadList(card_human.number, out_file_list)
				else
					app.log("FightManager:GetHeroAssetFileList nil card :"..tostring(vvv).." playmethod="..tostring(FightScene.GetPlayMethodType()).." worldid="..tostring(FightScene.GetWorldGID()))
				end
			end
		end
	end
end

function FightManager:GetNPCAssetFileList(out_file_list)
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.monster)
	local filepath = nil;
	if not config then
		return
	end
	for k, ml_v in pairs(config) do
		if ml_v.id ~= nil and ml_v.id ~= 0 then
			filepath = ObjectManager.GetMonsterModelFile(ml_v.id)
            if filepath then
                local monsterData = ConfigManager.Get(EConfigIndex.t_monster_property,ml_v.id)
                if monsterData and monsterData.all_skill_effect then
                    for eid, edata in pairs(monsterData.all_skill_effect) do
                        out_file_list[eid] = eid
                    end
                end
                if monsterData and monsterData.dead_voice_id and monsterData.dead_voice_id ~= 0 then
                	local cfg = ConfigManager.Get(EConfigIndex.t_audio,monsterData.dead_voice_id)
                	if cfg then
	                	local path = ConfigHelper.UpdateAudioPath(cfg)
	                	if path then
	                		out_file_list[path] = path
	                	end
	                end
                end
			    out_file_list[filepath] = filepath
            end
		end
	end
	config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.burchmonster)
	if not config then
		return
	end
	local filepath = nil;
	for k, ml_v in pairs(config) do
		if ml_v.id ~= nil and ml_v.id ~= 0 then
			filepath = ObjectManager.GetMonsterModelFile(ml_v.id)
			if filepath then
				out_file_list[filepath] = filepath
			end
		end
	end
	self.monsterLoader:GetNPCAssetFileList(out_file_list);
end

function FightManager:GetItemAssetFileList(out_file_list)
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.item)
	local filepath = nil;
	if not config then
		return
	end
	for k, ml_v in pairs(config) do
		if ml_v.item_modelid == 0 then
			ml_v.item_modelid = 80002002;
			--ml_v.item_modelid = 80002000;
		end
		if ml_v.item_modelid ~= nil and ml_v.item_modelid > 0 then
			filepath = ObjectManager.GetItemModelFile(ml_v.item_modelid)
			out_file_list[filepath] = filepath
		end
	end

	self.buffLoader:GetItemAssetFileList(out_file_list);
end

function FightManager:GetBasicUIAssetFileList(out_file_list)
	local file_list = {
		-- "assetbundles/prefabs/ui/fight/new_fight_ui_count_down.assetbundle",
        "assetbundles/prefabs/ui/new_fight/xin_main.assetbundle",
        -- 预加载倒计时资源，避免设置timescale为0时，卡住
        "assetbundles/prefabs/ui/level/panel_start_fight.assetbundle",
	}
	for k, v in pairs(file_list) do
		out_file_list[v] = v
	end	
end

function FightManager:InitMainUiComponent()
	self:OnUiInitFinish()
	g_dataCenter.player:ChangeFightMode(self.CalcIsAutoFight(FightScene.GetLevelID()))
end

--ui加载完成的回调
--做一些模块ui的初始化
function FightManager:OnUiInitFinish()
	local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	local str = hurdle.tips_string;
	local time = hurdle.tips_last;

	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsClickMove = (cf.is_click_move == 1)
	local configIsShowStarTip = (cf.is_show_star_tip == 1)
	local configIsMonsterGuide = (cf.monster_guide == 1);
	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	-- 整合到fightstartui里了。。。。
	-- GetMainUI():InitDescription(str, time)
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)
	GetMainUI():InitProgressBar()
	GetMainUI():InitTriggerOperator()
	if configIsMonsterGuide then
		GetMainUI():InitFightMonsterGuide();
	end
	--fy加入点击事件
	GetMainUI():InitMMOFightUIClick();
    local pmi = FightScene.GetStartUpEnv():GetPlayMethod();

	local canReborn = true
	if pmi == nil and not FightScene.IsMobaHurdle() then
		canReborn = false
	end

    GetMainUI():InitTeamCanChange(true,canReborn)

	GetMainUI():InitTimer()

	self:CallFightStart()
end

function FightManager:CallFightStart()
	-- 将游戏开始的触发器延后在这里触发
    -- 防止界面还未加载完毕，就被触发器里的行为隐藏界面，导致界面查找不到节点等一系列问题
    app.log("#lhf #OnUiInitFinish"..debug.traceback());
    ObjectManager.SnapshootForeachObj(function (objname,obj)
    	obj:OnFightStart()
	end)
    self:StartTime();
    --显示剧情的时候 就需要先把条件设置好
    self:CheckPassCondition();
    --没得剧情的关卡只能放在这通知剧情结束
    if not ScreenPlay.IsRun() then
    	NoticeManager.Notice(ENUM.NoticeType.ScreenPlayOver, 0, true)
    	self:EndScreePlay();
    else	
    	ScreenPlay.SetCallback(function ()
    	self:EndScreePlay();
    	end);
    end
end

function FightManager:StartTime()
	local time = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID()).time_limit;
	self:SetCountDown(time)
	self:_SetTickTick()
end

function FightManager:GetUIAssetFileList(out_file_list)
	-- if self.runAsDefaultFightManager then
		FightManager.AddPreLoadRes(MMOMainUI.GetTimerRes(), out_file_list)
	    FightManager.AddPreLoadRes(MMOMainUI.GetWorldChatRes(), out_file_list)
	    FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list)
	    FightManager.AddPreLoadRes(MMOMainUI.GetDescriptionRes(), out_file_list)
	    FightManager.AddPreLoadRes(MMOMainUI.GetOptionTipRes(), out_file_list)
	    FightManager.AddPreLoadRes(MMOMainUI.GetJoystickRes(), out_file_list)
	    FightManager.AddPreLoadRes(MMOMainUI.GetSkillInputRes(), out_file_list)
	    FightManager.AddPreLoadRes(MMOMainUI.GetProgressBarRes(), out_file_list)
	    FightManager.AddPreLoadRes(MMOMainUI.GetMMOFightUIClickRes(), out_file_list)
	-- end
end

function FightManager:GetScreenPlayAssetFileList(out_file_list)
	local file_list = {};
	local hurdleID = FightScene.GetCurHurdleID();
	local config = ConfigManager.Get(EConfigIndex.t_screenplay_config,hurdleID);
	self.screenPlay_audio_count = {};
	if not config then
		return
	end
	for k,v in pairs(config) do
		repeat
			local play_id = v.playid;
			if play_id == nil then
	 			app.log("剧情对话g_get_screenplay_config的playid为空..hurdle="..hurdleID);
	 			break;
			end
			local content = ConfigManager.Get(EConfigIndex.t_screenplay_content,play_id);
			if content == nil then
				app.log("剧情对话g_get_screenplay_config的playid对应的g_get_screenplay_content为空 hurdle="..hurdleID.." play_id="..play_id);
				break;
			end
			if v.triggerid == 0 then
--				app.log_warning("剧情对话触发器为 0！"..table.tostring(v));
				break;
			end
			for k1,v1 in pairs(content or {}) do
				if v1.audio_id and v1.audio_id ~= 0 then
					local audio_path = ConfigHelper.GetAudioPath(v1.audio_id)
					if audio_path == nil then
						app.log("v1.audio_id=="..tostring(v1.audio_id).."的剧情对话音效为空");
					end
					if not self.screenPlay_audio_count[audio_path] then
						self.screenPlay_audio_count[audio_path] = 1;
						table.insert(file_list,audio_path);
					else
						self.screenPlay_audio_count[audio_path] = self.screenPlay_audio_count[audio_path] + 1;
					end
				end
				if v1.actiontype == "func" and type(v1.action) == "table"  then
					if v1.action.boss then
						local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property,v1.action.boss);
						if monsterCfg then
							local model_id = monsterCfg.model_id;
							local filepath = ObjectManager.GetHighItemModelFile(model_id);
							if filepath then
								table.insert(file_list,filepath);
							end
						else
							app.log("v1.action.boss=="..tostring(v1.action.boss).."的怪物配置表未找到")
						end
					end
					if type(v1.action.obj) == "table" then
						local list = v1.action.obj;
						for k,name in pairs(list) do
							table.insert(file_list, ObjectManager.GetScreenPlayModelFile(name));
						end
					elseif type(v1.action.obj) == "string" then
						table.insert(file_list, ObjectManager.GetScreenPlayModelFile(v1.action.obj));
					end
					if v1.action.audio_id then
						if v1.action.audio_id > 0 then
							local audio_path = ConfigHelper.GetAudioPath(v1.action.audio_id);
							if audio_path then
								table.insert(file_list,audio_path);
							else
								app.log("v1.action.audio_id=="..tostring(v1.action.audio_id).."的剧情2对话音效为空");
							end
						end
					end
					if v1.action.asset_id then
						table.insert(file_list, "assetbundles/prefabs/ui/loading/" .. v1.action.asset_id .. ".assetbundle" );
					end
				end
			end
		until true;
	end

	table.insert(file_list,"assetbundles/prefabs/sound/prefab/ui/ui_slide_3.assetbundle");
	table.insert(file_list,"assetbundles/prefabs/ui/drama/ui_701_drama.assetbundle");


	teamList = FightScene.GetStartUpEnv().fightTeamInfo;
	for k, v in pairs(teamList) do
		for gid,info in pairs(v.players) do
			if gid == g_dataCenter.player:GetGID() then
				for k, gid in pairs(info.hero_card_list) do
					local card_info = info.package_source:find_card(1, gid);
					if nil ~= card_info then
						-- ObjectManager.GetHeroPreloadList(card_info.number, out_file_list)
						local model_id = card_info.model_id;
						local filepath = ObjectManager.GetHighItemModelFile(model_id);
						if filepath then
							table.insert(file_list,filepath);
						end
					else
						app.log("FightManager:GetScreenPlayAssetFileList nil card :"..tostring(gid).." playmethod="..tostring(FightScene.GetPlayMethodType()).." worldid="..tostring(FightScene.GetWorldGID()))
					end
				end
			end
		end
	end

	for k, v in pairs(file_list) do
		out_file_list[v] = v
	end

end

function FightManager:GetOtherAssetFileList(out_file_list)
	local file_list = {
        "assetbundles/prefabs/sound/prefab/ui/ui_dazhao_slide.assetbundle",
	}
	for k, v in pairs(file_list) do
		out_file_list[v] = v
	end	
end

function FightManager:Update(deltaTime )
    if self.monsterLoader then
        self.monsterLoader:Update(deltaTime);
    end

	if self.__needCheckPassCondition then
		self:CheckPassConditionImpl()
	end
	FightKeyFrameInfo.Update();
end 

function FightManager:PauseLoader(isPause)
    if self.monsterLoader then
    	if isPause then
    		self.monsterLoader:Pause();
    	else
    		self.monsterLoader:Resume();
    	end
    end
    if self.buffLoader then
    	if isPause then
    		self.buffLoader:Pause();
    	else
    		self.buffLoader:Resume();
    	end
    end
end 

function FightManager:GetAllEffectAssetFileList(out_file_list)
	local fileList = {};
	local effectIdList = {};

	local audio_id_list = {
		81100000, 
		81100001,
		81100002,
		81100003,
		81100004,
		ENUM.EUiAudioType.Thunder,
		ENUM.EUiAudioType.BeginFight,
		ENUM.EUiAudioType.ChangeRole,
		ENUM.EUiAudioType.SkillComplete,
		ENUM.EUiAudioType.VicStar, 
	}

	for k, v in pairs(audio_id_list) do
		out_file_list[ConfigHelper.GetAudioPath(v)] = 1	
	end

	local levelData = FightScene.GetStartUpEnv().levelData;
	local footStepEffectId = ConfigManager.Get(EConfigIndex.t_scene_config,levelData.scene_id).footstep_effect;
	if footStepEffectId and footStepEffectId ~= 0 then
		local cf = ConfigManager.Get(EConfigIndex.t_effect_data,footStepEffectId);
		if cf and cf.id ~= 0 then 
			for i = 1,#cf.id do 
				out_file_list[ConfigManager.Get(EConfigIndex.t_all_effect,cf.id[i]).file] = 1;
			end 
		end 
	end 
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(), EMapInfType.monster);
	if config then
		for i = 1,#config do 
			FightManager.GetMonsterEffectFileList(fileList,config[i].id,effectIdList);
		end
	end
	config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(), EMapInfType.burchmonster);
	if config then
		for i = 1,#config do 
			FightManager.GetMonsterEffectFileList(fileList,config[i].id,effectIdList);
		end
	end
	
	--[[config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(), EMapInfType.item);
	if config then 
		for i = 1,#config do 
			local tid = config[i].triggerid;
			local triggerCfg = ConfigManager.Get(EConfigIndex.t_trigger_config,tid);
			for j = 1,#triggerCfg.trigger_effect do 
				local eff = triggerCfg.trigger_effect[j];
				if string.find(eff,"AddBuff") ~= nil then 
					local id = string.split(eff,"=")[2];
					
				end
			end
		end
	end --]]
	if self.fightScript ~= nil then 
		if self.fightScript.monster_wave then
			for k, v in pairs(self.fightScript.monster_wave) do
				for kk, vv in pairs(v.monsters) do
					local monster_id = vv.monster_id
					FightManager.GetMonsterEffectFileList(fileList,monster_id,effectIdList);
				end
			end
		end
		if self.fightScript.monster_wave_groud then
			for k, v in pairs(self.fightScript.monster_wave_groud) do
				for k,v in pairs(v) do
					for kk, vv in pairs(v.monsters) do
						local monster_id = vv.monster_id
						FightManager.GetMonsterEffectFileList(fileList,monster_id,effectIdList);
					end
				end
			end
		end
	end 
	
	local env = FightScene.GetStartUpEnv()
	for k, v in pairs(env.fightTeamInfo) do
		for kk, vv in pairs(v.players) do
			for kkk, vvv in pairs(vv.hero_card_list) do
				local card_human = vv.package_source:find_card(1, vvv)
				if card_human then
					for k,v in pairs(card_human.learn_skill) do 
						local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_info,v.id);
						if skillInfo ~= nil then 
							cf = skillInfo.dlg_audio;
							if cf ~= nil and cf ~= 0 then 
								--app.log("voice skill id = "..v.id);
								for i = 1,#cf do 
									local file_path = ConfigHelper.GetAudioPath(cf[i].id);
									out_file_list[file_path] = 1;
								end
							end
						end 
						local skillData = g_SkillData[v.id]
						FightManager.GetEffectFileList(fileList,skillData.effect[1].buffid,skillData.effect[1].bufflv,effectIdList)
					end
				end
			end
		end
	end
	--app.log("[][][][][]File"..table.tostring(fileList));
	--app.log("[][][][][]EFID"..table.tostring(effectIdList));
	for k,v in pairs(fileList) do 
		if out_file_list[k] == nil then 
			--app.log("GetMissingAsset:"..k);
			out_file_list[k] = 1;
		end 
	end



	--TODO: 暂时不预先创建，可能的导致u3d错误(AABB 类error), 当前版本5.3.5f1
	-- for k,v in pairs(effectIdList) do 
	-- 	for i = 1,v do 
	-- 		local effectObj = EffectManager.createEffect(k,0);
	-- 		effectObj:set_active(false);
	-- 	end
	-- end


end 

function FightManager.GetMonsterEffectFileList(out_file_list,monsterId,effectIdList)
	if monsterId == 0 then 
		return;
	end 
	local config = ConfigManager.Get(EConfigIndex.t_monster_property,monsterId);
	
	if config == nil then return end

	local voice_appear_path = ConfigHelper.GetAudioPath(config.appear_voice_id);
	local voice_dead_path = ConfigHelper.GetAudioPath(config.dead_voice_id);
	
	if voice_appear then 
		out_file_list[voice_appear_path] = 1;
	end 
	if voice_dead then 
		out_file_list[voice_dead_path] = 1;
	end
	if config.dead_effect and config.dead_effect ~= 0 then
		for k, v in pairs(config.dead_effect) do
			local deadEffect = ConfigManager.Get(EConfigIndex.t_effect_data, v)
			if deadEffect ~= nil then 
				local cf = deadEffect.id 
				if cf ~= nil and cf ~= 0 then 
					for i = 1,#cf do 
						local file_path = ConfigManager.Get(EConfigIndex.t_all_effect,cf[i]).file;
						if effectIdList[cf[i]] == nil then 
							effectIdList[cf[i]] = 1;
						end 
						out_file_list[file_path] = 1;
					end
				end 
			end
		end
	end
	local all_skill_id = {}
	if config.normal_skill ~= 0 then
		for k,v in ipairs(config.normal_skill) do
			table.insert(all_skill_id, v[1])
		end
	end
	--app.log("config id......"..tostring(config.id))
	--app.log("config.spe_skill"..tostring(config.spe_skill))
	if config.spe_skill ~= 0 then
		for k,v in ipairs(config.spe_skill) do
			table.insert(all_skill_id, v[1])
		end
	end
	for i=1, #all_skill_id do
		local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_info, all_skill_id[i]);
		if skillInfo ~= nil then 
			local cf = skillInfo.dlg_audio;
			if cf ~= nil and cf ~= 0 then 
				--app.log("voice skill id = "..config["skill"..i]);
				for i = 1,#cf do 
					local file_path = ConfigHelper.GetAudioPath(cf[i].id);
					out_file_list[file_path] = 1;
				end
			end
		end 
		local skillData = g_SkillData[all_skill_id[i]];
		if skillData ~= nil then 
			FightManager.GetEffectFileList(out_file_list,skillData.effect[1].buffid,skillData.effect[1].bufflv,effectIdList)
		end 
	end
end 

function FightManager.GetEffectFileList(out_file_list,id,lv,effectIdList)
	if id == nil or id == 0 then 
		return;
	end

	if not g_BuffData[id] then
		app.log("在buffdata中找不到id:"..tostring(id));
		return;
	end
	if not g_BuffData[id].level[lv] then
		app.log("在buffdata中找不到id:"..tostring(id).." lv:"..tostring(lv));
		return;
	end
	
	local trigger = g_BuffData[id].level[lv].trigger;
	if trigger == nil or trigger == 0 then 
		return;
	end 
	for kk,vv in pairs(trigger) do 
		for k,v in pairs(vv.action) do 
			if v.atype == 1 then 
				local skillCfg = ConfigManager.Get(EConfigIndex.t_skill_effect,v.animid);
				if skillCfg ~= nil then 
					local cf = skillCfg.attack_effect_seq; 
					if cf ~= nil and cf ~= 0 then 
						for i = 1,#cf do
							local effect_cfg = ConfigManager.Get(EConfigIndex.t_all_effect,cf[i].id)
							effectIdList[cf[i].id] = 1;
							if effect_cfg then
								local file_path = effect_cfg.file;
								out_file_list[file_path] = 1;
							end
						end
					end 
					cf = skillCfg.emit_effect_seq;
					if cf ~= nil and cf ~= 0 then 
						for i = 1,#cf do 
							local effect_cfg = ConfigManager.Get(EConfigIndex.t_all_effect,cf[i].id)
							effectIdList[cf[i].id] = 6;
							if effect_cfg then
								local file_path = effect_cfg.file;
								out_file_list[file_path] = 1;
							end
						end
					end 
					cf = skillCfg.hited_effect_seq;
					if cf ~= nil and cf ~= 0 then 
						for i = 1,#cf do 
							local effect_cfg = ConfigManager.Get(EConfigIndex.t_all_effect,cf[i].id)
							effectIdList[cf[i].id] = 6;
							if effect_cfg then
								local file_path = effect_cfg.file;
								out_file_list[file_path] = 1;
							end
						end
					end 
					cf = skillCfg.attack_audio_seq;
					if cf ~= nil and cf ~= 0 then 
						for i = 1,#cf do 
							local file_path = ConfigHelper.GetAudioPath(cf[i].id);
							out_file_list[file_path] = 1;
						end
					end 
					cf = skillCfg.hited_audio_seq;
					if cf ~= nil and cf ~= 0 then 
						for i = 1,#cf do 
							local file_path = ConfigHelper.GetAudioPath(cf[i].id);
							out_file_list[file_path] = 1;
						end
					end 
				end 
			elseif v.atype == 6 or v.atype == 17 or  v.atype == 49 or v.atype == 51 then 
				local effectCfg = ConfigManager.Get(EConfigIndex.t_effect_data,v.effectid);
				if effectCfg ~= nil then 
					local cf = effectCfg.id 
					if cf ~= nil and cf ~= 0 then 
						for i = 1,#cf do 
							if ConfigManager.Get(EConfigIndex.t_all_effect,cf[i]) then
								local effect_cfg = ConfigManager.Get(EConfigIndex.t_all_effect,cf[i])
								if effectIdList[cf[i]] == nil then 
									effectIdList[cf[i]] = 1;
								end 
								if effect_cfg then
									local file_path = effect_cfg.file;
									out_file_list[file_path] = 1;
								end
							else
								app.log("id==  "..tostring(cf[i]).."  的all_effect配置找不到");
							end
						end
					end 
				end 
				FightManager.GetEffectFileList(out_file_list,v.abuffid,v.abufflv,effectIdList);
			end 
			if v.atype == 2 or 
				v.atype == 5 or 
				v.atype == 11 or 
				v.atype == 13 or 
				v.atype == 17 or 
				v.atype == 34 or
				v.atype == 39 or
				v.atype == 47 or
				v.atype == 66 then 
				FightManager.GetEffectFileList(out_file_list,v.buffid,v.bufflv,effectIdList)
			end
		end
	end
end 

function FightManager:SetCountDown(seconds)
	if nil == seconds then
		local levelData = FightScene.GetStartUpEnv().levelData		
		if nil == levelData or levelData.time_limit == 0 or levelData.time_limit == nil then
			return
		end

		seconds = levelData.time_limit
	end

	if self.countDownTimer ~= nil then
		timer.stop(self.countDownTimer)
		self.countDownTimer = nil
	end
	self.time_limit = seconds;
	self.countDownTimer = timer.create(Utility.create_callback(self.OnEvent_TimeOut, self), seconds*1000, 1, true)
	-- timer.pause(self.countDownTimer);
end

function FightManager:__checkConditionAnd(cond)
	if cond == 0 or cond == nil then
		return false
	end

	for k, v in pairs(cond) do
		if not FightCondition.Check(k, v) then
			return false
		end
	end

	return true
end

function FightManager:__checkConditionOr(cond)
	if cond == 0 or cond == nil then
		return false
	end

	for k, v in pairs(cond) do
		if FightCondition.Check(k, v) then
			return true 
		end
	end

	return false; 
end

--增加一个外部设置接口
function FightManager:SetConditionWinFlag(flag)
	if flag then
		self.passCondition.win.flag = true
	else
		self.passCondition.lose.flag = true
	end
end

function FightManager:CheckPassCondition()
	-- 防止在一帧中间多次执行check条件
	self.__needCheckPassCondition = true
end

function FightManager:CheckPassConditionImpl()
	-- TODO: (kevin) 冻结一切对象行为。
	if self:IsFightOver() then
		return 
	end
	--app.log("FightManager:CheckPassCondition")
	self.passCondition.good.flag = self:__checkConditionAnd(self.passCondition.good.check)
	self.passCondition.perfect.flag = self:__checkConditionAnd(self.passCondition.perfect.check)
	local flag = false
	if nil ~= self.passCondition.lose then
		flag = self:__checkConditionOr(self.passCondition.lose.check)
		--app.log("fail  "..tostring(flag).."  "..table.tostring(self.passCondition.lose.check));
		if flag then
			self.passCondition.lose.flag = true
			self:FightOver()
			return
		end	
	end


	--app.log("win condition:"..self.passCondition.win)

	self.passCondition.win.flag = self:__checkConditionAnd(self.passCondition.win.check)
	--app.log("win  "..tostring(self.passCondition.win.flag).."  "..table.tostring(self.passCondition.win.check));
	if self.passCondition.win.flag then
		self:FightOver()
	end 

    local mainui = GetMainUI()
    if mainui then
        mainui:setTaskComplete(1, self.passCondition.win.flag);
        mainui:setTaskComplete(2, self.passCondition.good.flag);
        mainui:setTaskComplete(3, self.passCondition.perfect.flag);
    end
end

--[[创建一个怪后的回调。obj为怪的scene_entity]]
function FightManager:OnCreateMonster(obj)
	-- app.log("create monster"..obj:GetName())
end

--[[开始一小波刷怪回调]]
--返回当前是第几小波(cur_wave),一共多少波(max_wave)
function FightManager:OnBeginWave(cur_wave,max_wave)
	app.log("begin wave:"..tostring(cur_wave).." max:"..tostring(max_wave))
	ObjectManager.ForEachObj(function (objname,obj)
		obj:OnMonsterLoader(1, nil, cur_wave);
		end)
end

--[[一小波刷怪结束回调]]
--返回下一波是第几小波(next_wave),一共多少波(max_wave)
--当next_wave大于max_wave时，没有下一波了
function FightManager:OnEndWave(next_wave,max_wave)
	app.log("next wave:"..tostring(next_wave).." max:"..tostring(max_wave))
	self:CheckPassCondition();
	ObjectManager.ForEachObj(function (objname,obj)
		obj:OnMonsterLoader(2, nil, next_wave-1);
		end)
end

--[[开始一大波回调]]
--返回当前是第几大波(cur_groud),一共多少波(max_groud)
function FightManager:OnBeginGroud(cur_groud,max_groud)
	app.log("begin groud:"..tostring(cur_groud).." max:"..tostring(max_groud))
	ObjectManager.ForEachObj(function (objname,obj)
		obj:OnMonsterLoader(5, cur_groud);
		end)
end

--[[一大波刷怪结束回调]]
--返回下一波是第几大波(next_groud),一共多少波(max_groud)
--当next_groud大于max_groud时，没有下一波了
function FightManager:OnEndGroud(next_groud,max_groud)
	app.log("next groud:"..tostring(next_groud).." max:"..tostring(max_groud))
	ObjectManager.ForEachObj(function (objname,obj)
		obj:OnMonsterLoader(4, next_groud-1);
		end)
end

--[[一小波怪杀完后回调]]
--返回当前是第几波(cur_wave)，和一共多少波(max_wave)
function FightManager:OnKillWave(cur_wave,max_wave)
	app.log("kill wave over:"..tostring(cur_wave).." max:"..tostring(max_wave))
	ObjectManager.ForEachObj(function (objname,obj)
		obj:OnMonsterLoader(3, nil, cur_wave);
		end)
end

--[[一大波怪杀完后回调]]
--返回当前是第几大波(cur_wave)，当前第几小波(cur_wave)，一共多少大波(max_wave)
function FightManager:OnKillGroud(cur_groud,cur_wave,max_groud)
	app.log("kill groud over:"..tostring(cur_groud).." max:"..tostring(max_groud))
	ObjectManager.ForEachObj(function (objname,obj)
		obj:OnMonsterLoader(6, cur_groud, cur_wave);
		end)
end

function FightManager:StandardUILayout()
end

function FightManager:OnEvent_TimeOut()
	self.countDownTimer = nil
	self:CheckPassCondition()
end

function FightManager:OnEvent_ObjDead(killer, target)
	if nil == target then
		app.log("FightManager:OnEvent_ObjDead target is nil.")
		return;
	end

	FightRecord.onDead(killer,target);
    if self.monsterLoader then
	    self.monsterLoader:OnEvent_DeadMonster();
    end
    -- 记录最后死亡的信息
	if target:IsBoss() then
		self.curDeadList["boss"] = target:GetName();
	end
	if target:IsBasis() then
		self.curDeadList["basis"] = target:GetName();
	end
	if target:IsMonster() then
		self.curDeadList["monster"] = target:GetName();
	end
	if target:IsHero() then
		self.curDeadList["hero"] = target:GetName();
	end
	---------------------
	self:CheckPassCondition();
end

function FightManager:OnEvent_UseSkill(user, skillid)
    FightRecord.RecordUseSkill(user, skillid)
end

function FightManager:OnEvent_ObjectEnterRecordTrigger(obj, trigger)
    FightRecord.RecordTrigger(obj, trigger)

    self:CheckPassCondition();
end

function FightManager:OnEvent_OnInjured(obj, attack,hp)
    self:CheckPassCondition();
end

function FightManager:OnSceneEntityTiggerRecord(entity)
    if entity == nil then
        return
    end

    local name = entity:GetName()
    
    --记录第一次触发触发
    if self.firstTriggerRecord[name] == nil then
        self.firstTriggerRecord[name] = {}
        local record = self.firstTriggerRecord[name]
        record.time = system.time()
        record.objType = entity:GetObjType()
        record.configid = entity:GetConfigNumber()
    end
end

function FightManager:OnEvent_SceneEntityCollide(obj, target)
	--app.log(obj:GetName() .. "在战场中碰到了:"..target:GetName() )
end

function FightManager:OnEvent_OnDeleteObj(obj_name)
	-- app.log(tostring(obj_name).."将要从场景中移除了...")
	if self.buffLoader then
		self.buffLoader:OnEvent_DeleteObj(obj_name);
	end
end

--到达目的地
function FightManager:OnArriveDestination(target_entity, cur_entity, parm)
	self.isArriveDestination = true;
end

--是否到达目的地
function FightManager:IsArriveDestination()
	return self.isArriveDestination == true;
end

function FightManager:IsFightOver()
	return self.fightOver;
end

-- is_set_exit:  通过设置界面退出时，该值为true，进入 onForcedExit 函数
function FightManager:FightOver(is_set_exit, is_forced_exit)
	if system.check_time_id then
		timer.stop(system.check_time_id)
		system.check_time_id = nil
	end
	if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
	    Socket.Pvp3v3 = false
	end

	--app.log("FightManager:FightOver")
	Show3dText.SetShow(false);
	if self:IsFightOver() then
		return
	end
	--清除当前场景所有的怪
	local cf = FightScene.GetHurdleConfig();
	if cf.win_clear_monster > 0 then
		ObjectManager.ClearAllMonster();
	end
	

	self:RealEndFight();
	
	local is_win = false
	local win_stars = 0
	if self.passCondition.win.flag then
		is_win = true
		win_stars = win_stars + 1
	end
	if self.passCondition.perfect.flag then
		win_stars = win_stars + 1
	end
	if self.passCondition.good.flag then
		win_stars = win_stars + 1
	end
	FightKeyFrameInfo.Destory(is_win, win_stars)
	self.npc_wait_captain = nil
	NoticeManager.Notice(ENUM.NoticeType.FightOverBegin, FightScene:GetCurHurdleID());
	g_dataCenter.player:ResetInviteList()
	g_dataCenter.player:SetCurCtrlHero(nil)
    FxClicked.SetEnable(true)
    Root.uicamera:set_uicamera_multi_touch(false)
    Root.get_root_ui_2d_fight():set_active(false);


	self.fightOver = true;
	
	-- 清空加载回调函数
    ResourceLoader.ClearGroupCallBack(ResourceLoader.fight_group)

    -- ResourceLoader.loaded_call_back_func = {};
    ResourceLoader.ClearAllGroupCallback();

	if PublicFunc.NeedAttributeVerify(FightScene.GetPlayMethodType()) then
		ObjectManager.last_attribute_verify_time = nil
		msg_hurdle.cg_attribute_verify_over()
	end
	---
	ObjectManager.EnableAllAi(false)

	if GetMainUI() then
	    GetMainUI():OnFightOver()
	end
	
	AudioManager.SetAudioListenerFollowObj(false);
	AudioManager.Stop(ENUM.EAudioType._2d, true);
	AudioManager.Stop(ENUM.EAudioType._3d, true);
	if is_set_exit or is_forced_exit then
		self:onForcedExit();
		return;
	end
	if not self.passCondition then
		return
	end
	FightRecord.SetIsWin(self.passCondition.win.flag)
	FightRecord.SetIsGood(self.passCondition.good.flag)
	FightRecord.SetIsPerfect(self.passCondition.perfect.flag)
    
    if self.passCondition.win.flag then
        self:PlaySuccessEffect();
    else
        self:ClearAndEnterSettlementUI();
    end

	if self.monsterLoader then
		self.monsterLoader:Destroy();
	end
	self.monsterLoader = nil;
	if self.buffLoader then
		self.buffLoader:Destroy();
	end
	self.buffLoader = nil;

	self:_StopTickTimer()
end

function FightManager:onForcedExit()
	if self.passCondition then
		FightRecord.SetIsWin(self.passCondition.win.flag)
		FightRecord.SetIsGood(self.passCondition.good.flag)
		FightRecord.SetIsPerfect(self.passCondition.perfect.flag)
	end
	-- self:ClearAndEnterSettlementUI();
	FightScene.OnFightOver()
	FightScene.ExitFightScene();
	-- 延迟操作。
	--timer.create(Utility.create_callback(self.ClearUpInstance, self), 1000, 1)
end

function FightManager:ClearAndEnterSettlementUI()
	--AudioManager.SetAudioListenerFollowObj(false);
	--AudioManager.Stop(nil, true);
	self:OnFightOver()
	FightScene.OnFightOver()
	-- 延迟操作。
	--timer.create(Utility.create_callback(self.ClearUpInstance, self), 1000, 1)
end

function FightManager:PlaySuccessEffect(camp_flag)
	-- camp_flag = camp_flag or g_dataCenter.fight_info.single_enemy_flag;
 --    -- 基地被摧毁
	-- local obj = g_dataCenter.fight_info:GetBase(camp_flag)
    
 --    --boss被杀死
 --    if obj == nil then
 --        obj = g_dataCenter.fight_info:GetBoss(camp_flag)
 --    end

 --    if obj ~= nil then
 --        local targetPos = obj:GetPositionV3d() 
 --        targetPos:SetY(targetPos:GetY() + 1)
 --        CameraManager.MoveToPos(targetPos, function ()
 --            self:PlaySlowMotion()
 --        end) 
 --        return;
 --    end

    --不是上述条件结束直接进入战斗结算
    self:ClearAndEnterSettlementUI();

end

-- function FightManager:PlaySlowMotion()
--     CameraManager.ZoomInAndVignetting() 
--     local time = 350;
--     app.set_time_scale(0.2)
--     timer.create(Utility.create_callback(FightManager.PlaySuccessEffectEndCallback, self),time, 1)
--     local camera = CameraManager.SetFihgtCameraBlurEffect(true)
--     if camera then
--         camera:begin_blur_tween(2.242268,0,time*5)--:begin_tc_tween(0.2,1,time)
--     end
--     --镜头模糊   
-- end



function FightManager:PlaySuccessEffectEndCallback()
    app.set_time_scale(1)    
    timer.create(Utility.create_callback(FightManager.WaitEffectEnd, self), 1000, 1)
end
  
 
function FightManager:WaitEffectEnd()
    
    self:ClearAndEnterSettlementUI();
end

function FightManager:OnFightOver()
	--先通知对象over
	-- if self.passCondition and self.passCondition.win then
		local flag = nil
		if self.passCondition.win.flag == true then
			flag = true
		elseif self.passCondition.lose.flag == true then
			flag = false
		end
		ObjectManager.OnFightOver(flag);
	-- end
	--然后通知uiover
	if not ScreenPlay.IsRun() then
    	self:OnShowFightResultUI();
    else
    	ScreenPlay.SetCallback(function ()
    	self:OnShowFightResultUI();
    	end);
    end
end

function FightManager:OnShowFightResultUI()
	local _PlayMethod = FightScene.GetStartUpEnv():GetPlayMethod();
	local star = FightRecord.GetStar();
	if _PlayMethod then
		-- if _PlayMethod == 60054009 then
		-- 	local data = {};
		-- 	if star > 0 then
		-- 		data.star = 3;
		-- 	else
		-- 		data.star = 0;
		-- 	end
		-- 	data.copyId = FightScene.GetCurHurdleID();
		-- 	data.callback = FightScene.ExitFightScene;
		-- 	FightResultUi.Init(data);
		-- 	return;
		-- end
		if g_dataCenter.activity[_PlayMethod] then
			g_dataCenter.activity[_PlayMethod]:EndGame();
		end	
	else
		--app.log("11..............."..tostring(star));
		local hurdleid = FightScene.GetCurHurdleID()
		local isAuto = PublicFunc.GetIsAuto(hurdleid)
		if star > 0 then
			local flags = {};
			table.insert(flags, FightRecord.IsWin() and 1 or 0);
			table.insert(flags, FightRecord.IsGood() and 1 or 0);
			table.insert(flags, FightRecord.IsPerfect() and 1 or 0);
			msg_hurdle.cg_hurdle_fight_result(hurdleid, self:GetFightUseTime(), isAuto, star, flags, self.openedBoxDropID);
		else
			msg_hurdle.cg_hurdle_fight_result(hurdleid, self:GetFightUseTime(), isAuto, 0);
		end
	end
end

function FightManager:IsTimeUp()
	return self.countDownTimer == nil
end

--返回当前刷怪器是否有怪可刷
function FightManager:MonsterLoaderCanLoader()
	if self.monsterLoader then
		return not self.monsterLoader:IsFinish();
	else
		return false;
	end
end
--返回小波数
function FightManager:GetLoaderWaveCount()
	if self.monsterLoader then
		return self.monsterLoader.waveCount;
	end
end

-------
--scenes functions.
function FightManager:AddBuff2AllMonster(camp_flag, buff_id, buff_level)
    g_dataCenter.fight_info:foreach_obj(
        camp_flag, 
        false, 
        function(obj_name)
		    local obj = ObjectManager.GetObjectByName(obj_name)
		    if nil ~= obj then
			    obj:AttachBuff(buff_id, buff_level, nil, nil, nil, 0, nil, 0, 0, 0, nil, nil, false, nil)
		    end
	    end
    )
end



--<private region>
function FightManager:GetFightTickCount()
	if self.last_seconds > 0 then
		local passTime = PublicFunc.QueryDeltaRealTime(self.record_last_seconds)
		passTime = math.floor(passTime * 0.001)
		if passTime >= self.last_seconds then
			return 0
		else
			return self.last_seconds-passTime
		end
		--return math.max(0, self.last_seconds - system.time())
	end
	return self.tickCount
end

function FightManager:GetFightUseTime()
	local useTime = self.tickCount
	if self.isCountDown then
		if self.time_limit == nil then self.time_limit = 0 end
		useTime = self.time_limit - useTime
	end

	return useTime
end

function FightManager:GetFightRemainTime()
	local useTime = self.tickCount
	return useTime
end

function FightManager:IsCountDown()
	return self.isCountDown
end

function FightManager:_SetTickTick()
	if not self.isCountDown then
		self.tickCount = 0
		if self.tickTimer == nil then
			self.tickTimer = timer.create("FightManager.__ontick_callback", 1000, -1, true);
			-- timer.pause(self.tickTimer);
		end
	else
		self.tickCount = self.time_limit;
		if self.tickTimer == nil then
			self.tickTimer = timer.create("FightManager.__ontick_callback", 1000, -1, true);
			-- timer.pause(self.tickTimer);
		end
	end
end

function FightManager:_OnTick()
	if not self.isCountDown then
		self.tickCount = self.tickCount + 1
	else
		self.tickCount = self.tickCount - 1
		if self.tickCount < 0 then
			self.tickCount = 0;
		end
	end
	--时间检测
	self:CheckPassCondition();

	local curtime = system.time();
	if curtime - self.lastRelaxAudioTime > self.RelaxAudioIntervalTime then
		self:PlayRelaxAudio();
	end
end

function FightManager.__ontick_callback()
	FightScene.GetFightManager():_OnTick()
end

--播放休闲语音
function FightManager:PlayRelaxAudio()
	local captain = FightManager.GetMyCaptain()
    if captain == nil then
        return
    end
	local modelConfig = ConfigManager.Get(EConfigIndex.t_model_list,captain.config.model_id);
	local relax_audio = modelConfig.relax_audio;
	if relax_audio and relax_audio ~= 0 and type(relax_audio) == "table" and #relax_audio > 0 then
		local n = math.random(1,#relax_audio);
		if relax_audio[n] and type(relax_audio[n])=="table" and relax_audio[n].id then
			local id = relax_audio[n].id;
	        local bind_pos = captain:GetBindObj(3)
	        if not AudioManager.cur3dAudioId then
				AudioManager.Play3dAudio(id, bind_pos,true,true,true)
			end
		end
	end
	self.lastRelaxAudioTime = system.time();
	local t = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_relaxAudioIntervalTime).data
	self.RelaxAudioIntervalTime = math.random(t[1],t[2]);
end

--</private region>

-------------------------
--<static func area>
--	<quick access of local-player>
function FightManager.GetMyCaptain()
	return g_dataCenter.fight_info:GetCaptain()
end

function FightManager.GetMyCaptainName()
	local obj = FightManager.GetMyCaptain()
	if nil ~= obj then
		return obj:GetName()
	end

	return nil
end

function FightManager.GetFightTime()
	return FightScene.GetFightManager():GetFightTickCount()
end

function FightManager:OnBeginDestroy()
end

function FightManager:_StopTickTimer()
	if self.tickTimer then
		timer.stop(self.tickTimer)
		self.tickTimer = nil;
	end
end

function FightManager:Destroy()
	self:_StopTickTimer()

    self.followHeroUsedAI = nil

	PlayGuideUI.Destroy()
	SkillShowUI.Destroy();

	self.curDeadList = {};

    self:ClearUpInstance()
    self:StopCheckUILoadingTimer()
end

function FightManager:SetAutoReborn(bool)
    self.autoReborn = bool
end

function FightManager:GetAutoReborn()
    return Utility.get_value(self.autoReborn, true)
end

function FightManager:OnDead(entity)
end

function FightManager:IsAutoSetPath()
	return true;
end

function FightManager:SynFightLastTime(t)
    self.last_seconds = t;
    self.record_last_seconds = PublicFunc.QueryCurRealTime()
end

function FightManager:GetMainHeroAutoFightAI()

	--[[
	local id = nil
	local hurdleConfig = FightScene.GetHurdleConfig()
	if hurdleConfig and type(hurdleConfig.auto_fight_ai) == 'number' and hurdleConfig.auto_fight_ai > 0 then
		id = hurdleConfig.auto_fight_ai
	else
		id = ENUM.EAI.MainHeroAutoFight
	end
	]]

	local id = ENUM.EAI.MainHeroAutoFight
	if self.heroFightAI then
		if type(self.heroFightAI) == 'number' and self.heroFightAI > 0 then
			id = self.heroFightAI
		elseif type(self.heroFightAI) == 'table' and type(self.heroFightAI.mh_ai_id) == 'number' then
			id = self.heroFightAI.mh_ai_id
		end
	end

    return id
end

function FightManager:GetHurdleHeroFightAI()
	return self.heroFightAI
end

function FightManager:GetMainHeroAutoFightViewAndActRadius()
    return 7,1000
end

function FightManager:TransmitTrigger(obj,cur_obj,param)
end

function FightManager:IsOpenTimeAuto()
    return false,0
end

function FightManager:EntityReborn(entity)
	entity:HideHP(false)
	entity:ShowHP(true)
end

function FightManager:MonsterLoadFinish(entity)
	
end

function FightManager:MonsterBloodReduce(entity, attacker)
	if not entity or not attacker then
		return;
	end
	if attacker:IsMyControl() and entity:IsBoss() and GetMainUI() then
        GetMainUI():InitBosshp(2, entity:GetName());
    end
end

function FightManager:OnScreenPlayOver()
	-- if FightScene.GetPlayMethodType() == nil then
	-- 	if GetMainUI() then
	-- 		GetMainUI():SetAutoBtn(false);
	-- 	end
	-- end
end

function FightManager:MoveCaptainToNpc(npc)
	--app.log( "======fy:设置自动寻路移动的NPCFightManager:" );
	local pos = npc:GetPosition();
	if not pos then return end
	self:SetMovePos(pos.x, pos.y, pos.z);
	self:SetNpcID(npc.__npcId);
	local myCaptain = FightManager.GetMyCaptain();
	if not myCaptain then return end
	myCaptain:SetHandleState(EHandleState.MMOMove);
	self:SetTouchNpc( false );
end

function FightManager:SetMovePos(x,y,z)
	self.move_x,self.move_y,self.move_z = x,y,z
end

function FightManager:GetMovePos()
	return self.move_x,self.move_y,self.move_z;
end

function FightManager:SetNpcID(id)
	self.npcID = id;
end

function FightManager:GetNpcID()
	return self.npcID;
end

function FightManager:TouchNpc()
	--app.log( "====fy点击NPC的方法调用:FightManager:TouchNpc" )
	if not self.isOpenNPC then
		self.isOpenNPC = true;
		--打开对应的对话框内容
		--app.log( "====fy点击NPC的方法调用:FightManager:TouchNpc:"..self.npcID );
		if self.npcID then
			local cfg = ConfigManager.Get( EConfigIndex.t_npc_data,self.npcID );
			if cfg then
				local screenplay_id = cfg.default_screenplay_id;
				ScreenPlay.Play(screenplay_id);
			end
		end
	end
end

function FightManager:CanTouchNpc()
	return self.isOpenNPC;
end

function FightManager:SetTouchNpc( flag )
	self.isOpenNPC = flag;
end

function FightManager:OnLoadNPC(entity)

end

function FightManager:LoadNPC()
	self.npcMapInfo = ConfigHelper.GetMapInf(self:GetFightMapInfoID(), EMapInfType.npc);
	app.log( "加载战斗方面的NPC数据是:"..table.tostring( self.npcMapInfo ) );
	if not self.npcMapInfo then return end;
	for k,v in pairs(self.npcMapInfo) do 
		local id = v.id;
		local flag = 1;
		local obj = FightScene.CreateMMONPCAsync(id,flag);
		local pos = {};
		local cfg = ConfigManager.Get(EConfigIndex.t_npc_data,id);
		-- local npcID = ConfigManager.Get(EConfigIndex.t_npc_data,id).default_screenplay_id;
		pos.x = v.px;
		pos.y = v.py;
		pos.z = v.pz;
		obj:SetPosition(pos.x,pos.y,pos.z);
		obj:SetRotation(0,v.ry,0,false);
		self.npcObjName[id] = obj.name;
		obj.__npcId = id;
	end
end

function FightManager:AddOpenedBoxDropID(id)
    table.insert(self.openedBoxDropID, id)
end

function FightManager:AddHurldleBuffByConfig()
	local hurdleID = FightScene.GetCurHurdleID();
	local cfg = ConfigManager.Get(EConfigIndex.t_hero_type_add_prop, hurdleID);
	if not cfg then
		return
	end
	local _AttackBuff = function (obj, cfg)
		if type(cfg.buffs) ~= "table" then
			return;
		end
		for k,buff in pairs(cfg.buffs) do
			obj:AttachBuff(buff.id, buff.lv);
		end
	end
	local camp = 1;
	local list = g_dataCenter.fight_info:GetHeroList(camp);
	for _,name in pairs(list) do
		local obj = ObjectManager.GetObjectByName(name);
		for k,info in pairs(cfg) do
			if obj:GetConfig(info.prop_type) == info.prop_value then
				_AttackBuff(obj,info);
			end
		end
	end
end

--所有战斗初始化完全完成的回调
function FightManager:RealStartFight()
	if g_dataCenter.autoQualitySet == nil then
		g_dataCenter.autoQualitySet = AutoQualitySet:new()
	end
	--开启自动设置特效
	if FightScene.GetPlayMethodType() == nil then
		g_dataCenter.autoQualitySet:SetEnable(true, EFightType.rgp);
	else
		g_dataCenter.autoQualitySet:SetEnable(true, FightScene.GetPlayMethodType());
	end
	-- 关卡属性buff添加
	-- DJZJ-4388 删除需求
	--self:AddHurldleBuffByConfig();
end
--所有战斗的真实结束回调
function FightManager:RealEndFight()
	if g_dataCenter.autoQualitySet == nil then
		g_dataCenter.autoQualitySet = AutoQualitySet:new()
	end
	if FightScene.GetPlayMethodType() == nil then
		g_dataCenter.autoQualitySet:SetEnable(false, EFightType.rgp);
	else
		g_dataCenter.autoQualitySet:SetEnable(false, FightScene.GetPlayMethodType());
	end
end
