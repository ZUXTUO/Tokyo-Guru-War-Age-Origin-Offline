

--MainCityScene = Class("MainCityScene")

--local pathRes = {};
--pathRes.main_city_scene = "assetbundles/prefabs/fight_scene.assetbundle";

--MainCityScene.isInherit = true
--local npc_pos = {};

--local MAX_ROBOT_COUNT = 10;

--function MainCityScene:Start(stratUpEvn)
--	ResourceManager.SetAutoGC(true)
--	PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single;
--    ObjectManager.Init();
--    self.loadData = stratUpEvn;
--	self.npc_info = {};
--    Root.get_root_ui_2d_fight():set_active(false);
--    self.robot_info = {};
--    self.npc_name = {};
--	self.robots_count = 0;
--	self.hero_born_pos = {};
--	self:GetHeroBornPosList(g_dataCenter.fight_info.single_enemy_flag, self.hero_born_pos)

--	Show3dText.Start()
--    ResourceLoader.LoadAsset(pathRes.main_city_scene, {func=self.OnStageLoaded, user_data=self}, nil)
--end

--function MainCityScene:Pause()
--	ResourceManager.SetAutoGC(false)
--    local levelData = self.loadData
--    self:Destroy()
--    self.loadData = levelData
--end

--function MainCityScene:Update(dt)
--   ObjectManager.Update(dt)
--end

--function MainCityScene:Resume()
--	ResourceManager.SetAutoGC(true)
--    if self.loadData == nil then
--        app.log('self.loadData == nil resume failed')
--    else
--    	self.is_resume = true;
--        self:Start(self.loadData)
--    end
--end

--function MainCityScene:Destroy()
--	if self.my_captain then
--    	self.oldPos = self.my_captain:GetPosition();
--    	self.my_captain = nil;
--    end

--	self:MsgUnRegist();
--	self:UnRegistFunc();
--	--Root.DelUpdate(self.Update)
--	uiManager:DestroyAll()
--    ObjectManager.Destroy()
--    CameraManager.Destroy()
--    ResourceManager.SetAutoGC(false)
--    g_dataCenter.fight_info:ClearUp()
--    ApertureManager.DestroyEffect()    	
--    if self.fightScene ~= nil then
--    	self.fightScene:set_active(false)
--    end
--    self.fightScene = nil
--    self.loadData = nil
--    self.obj_temp_model = nil;
--    self.my_captain = nil;
--end

--function MainCityScene:GetUIMgr()
--	return uiManager;
--end

--function MainCityScene:OnStageLoaded(pid, filepath, asset_obj, error_info)
--	if filepath ~= pathRes.main_city_scene then
--		app.log("load mainCityScene node error");
--		return
--	end

--	self.fightScene = asset_game_object.create(asset_obj);
--	asset_game_object.dont_destroy_onload(self.fightScene);
--	self.fightScene:set_name("mainCityScene")
--    self:LoadAll()
--end

--function MainCityScene:LoadAll()

--    local ld = self.loadData.levelData

--	local scene_file = ld.scene_file;
--    local scene_name = ld.scene_name;
--	local scene_asset_list = {} 

--	local misc_asset_file_list = {}
--    self:GetPreLoadAssetFileList(scene_asset_list)
--	for k, v in pairs(scene_asset_list) do
--		table.insert(misc_asset_file_list, k)
--	end
--    local group_loader_index = ResourceLoader.CreateGroupLoader()
--	ResourceLoader.AddCamera(group_loader_index)
--    ResourceLoader.AddScene(group_loader_index, {scene_file, scene_name})
--    ResourceLoader.AddAsset(group_loader_index, misc_asset_file_list)
--    self:AddSubLoadStep(group_loader_index)
--    if self.is_resume then
--    	LoadMainCityScene(self.onResume, self, nil, nil, group_loader_index);
--    else
--		LoadMainCityScene(self.OnLoadSceneAssetsComplete, self, nil, nil, group_loader_index);
--	end
--end

--function MainCityScene:AddSubLoadStep()

--end

--function MainCityScene:GetPreLoadAssetFileList(out_file_list)


--	-- TODO: kevin 异步加载屏蔽
--		-- self:GetHeroPreloadList(out_file_list)
--		out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
--		-- self:GetNPCAssetFileList(out_file_list)

--	self:GetUIAssetFileList(out_file_list)
--	self:GetItemAssetFileList(out_file_list)
--end

--function MainCityScene:GetHeroPreloadList(out_file_list)
--	out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File

--	local env = self.loadData;
--	local card_human = nil;
--	for k, v in pairs(env.fightTeamInfo) do
--		for kk, vv in pairs(v.players) do
--			for kkk, vvv in pairs(vv.hero_card_list) do
--				card_human = vv.package_source:find_card(1, vvv)
--				if nil ~= card_human then
--                    ObjectManager.GetHeroPreloadList(card_human.number, out_file_list)
--				else
--					app.log("FightManager:GetHeroAssetFileList nil card :"..vvv)
--				end
--			end
--		end
--	end
--end

--function MainCityScene:GetNPCAssetFileList(out_file_list)
--	local hurdle_id = self:GetCurHurdleID();
--	local config = ConfigHelper.GetMapInf(tostring(hurdle_id),EMapInfType.npc)
--	local filepath = nil;
--	if not config then
--		return
--	end
--	for k, ml_v in pairs(config) do
--		if ml_v.id ~= nil and ml_v.id ~= 0 then
--			filepath = ObjectManager.GetNpcModelFile(ml_v.id)
--            if filepath then
--                local monsterData = ConfigManager.Get(EConfigIndex.t_npc,ml_v.id)
--                if monsterData and monsterData.all_skill_effect then
--                    for eid, edata in pairs(monsterData.all_skill_effect) do
--                        out_file_list[eid] = eid
--                    end
--                end
--			    out_file_list[filepath] = filepath
--            end
--		end
--	end
--end

--function MainCityScene:GetItemAssetFileList(out_file_list)
--	local config = ConfigHelper.GetMapInf(tostring(self:GetCurHurdleID()),EMapInfType.item)
--	local filepath = nil;
--	if not config then
--		return
--	end
--	for k, ml_v in pairs(config) do
--		if ml_v.item_modelid == 0 then
--			ml_v.item_modelid = 80002002;
--			--ml_v.item_modelid = 80002000;
--		end
--		if ml_v.item_modelid ~= nil and ml_v.item_modelid > 0 then
--			filepath = ObjectManager.GetItemModelFile(ml_v.item_modelid)
--			out_file_list[filepath] = filepath
--		end
--	end
--end

--function MainCityScene:GetUIAssetFileList(out_file_list)
--	local file_list = {
--	 --    "assetbundles/prefabs/ui/fight/sp_bighp_di.assetbundle",
--	 --    "assetbundles/prefabs/ui/fight/sp_bighp_boss_di.assetbundle",
--	 --    "assetbundles/prefabs/ui/fight/sp_smallhp_di.assetbundle",
--		-- "assetbundles/prefabs/ui/fight/new_fight_ui.assetbundle",
--		-- "assetbundles/prefabs/ui/set_ui/ui_fight_set.assetbundle",
--		-- "assetbundles/prefabs/ui/fight/new_fight_ui_count_down.assetbundle",
--	}
--	for k, v in pairs(file_list) do
--		out_file_list[v] = v
--	end
--end

--function MainCityScene:OnLoadSceneAssetsComplete()
--    -- need to impl in sub class
--    --Root.AddUpdate(self.Update);
--    --TouchManager.Init()
--    self.obj_temp_model = Root.temp_model_file;
--    AudioManager.Stop();
--	AudioManager.Destroy();
--	uiManager:Begin();
--    uiManager:PushUi(EUI.MainUi)
--    ApertureManager.CreateEffect()
--    AudioManager.Play2dAudioList({[1]={id=81000003,loop=-1}})
----	login_bg.Destroy();
--	--self:LoadHero();
--	self:ChangeCaptain();
--	self:LoadNPC();
--	self:LoadItem();
--	-- g_dataCenter.fight_info:SetCaptain(1)
--	-- self.my_captain = g_dataCenter.fight_info:GetCaptain()
--	-- self.my_captain:SetAI(ENUM.EAI.MainHero)
--	-- CameraManager.init_target(self.my_captain)

--	self:RegistFunc();
--    self:MsgRegist();
--	if self.robots_count < MAX_ROBOT_COUNT then
--		local n = MAX_ROBOT_COUNT - self.robots_count;
--		world_msg.cg_request_hall_mock_player(n)
--	end
--end

--function MainCityScene:onResume()
--	--Root.AddUpdate(self.Update);
--	self.obj_temp_model = Root.temp_model_file;
--    ApertureManager.CreateEffect()
--    self:ChangeCaptain();
--	--self:LoadHero();
--	self:LoadNPC();
--	self:LoadItem();
--	-- g_dataCenter.fight_info:SetCaptain(1)
--	-- self.my_captain = g_dataCenter.fight_info:GetCaptain()
--	-- self.my_captain:SetAI(ENUM.EAI.MainHero)
--	-- CameraManager.init_target(self.my_captain)
--	AudioManager.Stop();
--	AudioManager.Destroy();
--    AudioManager.Play2dAudioList({[1]={id=81000003,loop=-1}})

--    self:RegistFunc();
--    self:MsgRegist();
--	if self.robots_count < MAX_ROBOT_COUNT then
--		local n = MAX_ROBOT_COUNT - self.robots_count;
--		world_msg.cg_request_hall_mock_player(n)
--	end
--end

--function MainCityScene:RegistFunc()
--	self.bindfunc = {};
--	self.bindfunc['AddHero'] = Utility.bind_callback(self, self.AddHero);
--	self.bindfunc['DeleteHero'] = Utility.bind_callback(self, self.DeleteHero);
--end


--function MainCityScene:UnRegistFunc()
--    if self.bindfunc then
--	    for k,v in pairs(self.bindfunc) do
--            if v ~= nil then
--                Utility.unbind_callback(self, v);
--            end
--        end
--    end
--end

--function MainCityScene:MsgRegist()
--	PublicFunc.msg_regist(world_msg.gc_request_hall_mock_player,self.bindfunc['AddHero']);
--	PublicFunc.msg_regist('mainCityVirtualHeroExit',self.bindfunc['DeleteHero']);
--end

--function MainCityScene:MsgUnRegist()
--    if self.bindfunc then
--	    PublicFunc.msg_unregist(world_msg.gc_request_hall_mock_player,self.bindfunc['AddHero']);
--	    PublicFunc.msg_unregist('mainCityVirtualHeroExit',self.bindfunc['DeleteHero']);
--    end
--end

--function MainCityScene:OnStart()

--end

--function MainCityScene:GetHeroBornPosList(camp_flag, out_pos_list, make_default_when_empty)
--	local cfgFile = "ConfigManager.Get(EConfigIndex.t_hurdle_"..tostring(self:GetCurHurdleID()).."_burchhero",--	local cfgFile = "gd_hurdle_"..tostring(self:GetCurHurdleID()).."_burchhero")--	local cfgFile = "gd_hurdle_"..tostring(self:GetCurHurdleID()).."_burchhero"
--	local cfg = _G[cfgFile]
--	if nil == cfg then
--		--app.log("can't find config file:"..cfgFile)
--		return false 
--	end

--	local bornPos = {};
--	for k, v in pairs(cfg) do
--		 if v.flag == camp_flag then
--		 	local index = PublicFunc.string_rfind(v.obj_name,"_");
--			local num = string.sub(v.obj_name,index+1,-1);
--            num = tonumber(num);
--            --app.log("num=="..num);
--            out_pos_list[num] = v;
--		 	--table.insert(out_pos_list, v)
--		 end
--	end

--	if make_default_when_empty and #out_pos_list == 0 then
--		out_pos_list[1] = {px=0, py=0, pz=0, rx=0, ry = 0, rz = 0, sx=1, sy=1, sz=1}
--	end

--	return true
--end

--function MainCityScene:LoadNPC()
--	local hurdle_id = self:GetCurHurdleID();
--	local config = ConfigHelper.GetMapInf(tostring(hurdle_id),EMapInfType.npc)
--	local newnpc = nil
--	if not config then
--		return
--	end

--	for k, ml_v in pairs(config) do
--		if ml_v.id ~= nil and ml_v.id ~= 0 then
--			newnpc = FightScene.CreateNPCAsync(ml_v.id, ml_v.flag)
--			if newnpc then
--				newnpc:SetPosition(ml_v.px,0,ml_v.pz)
--				npc_pos[tonumber(ml_v.obj_name)] = {};
--				npc_pos[tonumber(ml_v.obj_name)].x,npc_pos[tonumber(ml_v.obj_name)].y,npc_pos[tonumber(ml_v.obj_name)].z = ml_v.px,0,ml_v.pz;
--	            self.npc_info[newnpc:GetName()] = {};
--	            self.npc_info[newnpc:GetName()].system_id = tonumber(ml_v.obj_name);
--	            --TODO: kevin 临时设置怪物出生点
--	            newnpc:SetHomePosition(newnpc:GetPosition())
--				newnpc:SetRotation(ml_v.rx,ml_v.ry,ml_v.rz)
--				newnpc:SetScale(ml_v.sx,ml_v.sy,ml_v.sz)

--                --self:SetParam(newnpc, ml_v.param)
--				local name = ConfigManager.Get(EConfigIndex.t_npc,ml_v.id).name;


--				newnpc:GetHpUi():Show(false);

--				newnpc:InitMainNameUi({type = 1, name = name});

--				self:OnLoadNPC(newnpc);
--			end
--		end
--	end
--end

--function MainCityScene:OnLoadNPC(entity)
--	entity:SetAI(104);
--	--entity:GetHpUi():Show(false);
--end

--function MainCityScene:LoadHero()
--	local player_id = g_dataCenter.player:GetGID()
--    --local hero_id = {30001045}
--    local hero_index = 1
--    local env = self.loadData;
--    local cfg = env.levelData;
--    local hero_limit;
--    if not cfg.hero_limit or cfg.hero_limit == 0 then
--		hero_limit = 3;
--	else
--		hero_limit = cfg.hero_limit;
--    end
--    for camp_flag, teamData in pairs(env.fightTeamInfo) do
--        local heroBPList = {}
--        local heroBPPos_index = 1
--        heroBPList[1] = ConfigHelper.GetMapInf(self:GetCurHurdleID(,EMapInfType.burchhero)
--        if #heroBPList ~= 0 then
--		    for gid, player in pairs(teamData.players) do
--		    	local hero_num = 0;
--		       	for k, heroid in pairs(player.hero_card_list) do
--		       		hero_num = hero_num + 1;
--		       		if hero_num > hero_limit then
--		       			return true;
--		       		end
--				    card = player.package_source:find_card(ENUM.EPackageType.Hero, heroid)
--		            if hero_id then
--                        if hero_id[hero_index] then
--                            local hero = FightScene.CreateHeroAsync(player_id, hero_id[hero_index], g_dataCenter.fight_info.single_friend_flag, 0, 1, heroid, g_dataCenter.package)
--		                    hero:SetPosition(heroBPList[heroBPPos_index].px, heroBPList[heroBPPos_index].py, heroBPList[heroBPPos_index].pz)
--		                    hero:SetBornPoint(heroBPList[heroBPPos_index].px, heroBPList[heroBPPos_index].py, heroBPList[heroBPPos_index].pz)
--                            hero_index = hero_index+1
--                        end
--                    else
--                        if card then
--	    	                self:LoadSingleHero(camp_flag, gid, player.package_source, heroid, heroBPList[heroBPPos_index])
--                        end
--                    end
--		            heroBPPos_index = Utility.getNextIndexLoop(heroBPPos_index, 1, #heroBPList, true)
--			    end 
--		    end
--        end
--	end
--	return true;
--end

--function MainCityScene:LoadSingleHero(camp_flag, player_id, package_source, cardHuman_id, pos_inf)

--    if pos_inf == nil then
--        app.log('xxx  ' .. debug.traceback())
--    end

--	if cardHuman_id ~= nil and 0 ~= cardHuman_id then
--		-- local cardHuman = v.package_source:find_card(1, v)
--		--TODO: (kevin) 背包。。。。。
--		local hero_id = 0
--		local hero_level = 1

--		local cardHuman = package_source:find_card(ENUM.EPackageType.Hero, cardHuman_id)
--		if lua_assert(cardHuman ~= nil, "FightManager:_LoadHero nil hero.") then
--			return false
--		end
--		if cardHuman == nil then return end;
--		hero_id = cardHuman.number
--		hero_level = cardHuman.level
--		--hero是sceneEntity的一个对象
--		local hero = FightScene.CreateHeroAsync(player_id, hero_id, camp_flag, 0, hero_level, cardHuman_id, package_source)
--        hero:SetPosition(pos_inf.px, pos_inf.py, pos_inf.pz)
--		hero:SetBornPoint(pos_inf.px, pos_inf.py, pos_inf.pz)
--		self:OnLoadHero(hero);


--		hero:GetHpUi():Show(false);

--		hero:InitMainNameUi({type=2,name=g_dataCenter.player.name, vip_level = g_dataCenter.player.vip});

--        g_dataCenter.fight_info:DelDelayLoadHero(camp_flag, cardHuman_id)
--	end
--end

--function MainCityScene:OnLoadHero(entity)

--end

--function MainCityScene:LoadItem()
--	-- 先找配置ConfigManager.Get(EConfigIndex.t_hurdle_id_entity,--	-- 先找配置gd_hurdle_id_entity)--	-- 先找配置gd_hurdle_id_entity
--	local hurdle_id = self:GetCurHurdleID();
--	local config = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.item)
--	local new_item = nil
--	if not config then
--		return
--	end
--	-- 按顺序初始化(以便于查找对应Item)
--	for k, ml_v in ipairs(config) do
--		new_item = FightScene.CreateItem(nil, ml_v.item_modelid, ml_v.flag, ml_v.id, ml_v.item_effectid)
--		if new_item then
--			new_item:SetPosition(ml_v.px,ml_v.py,ml_v.pz)
--			new_item:SetRotation(ml_v.rx,ml_v.ry,ml_v.rz)
--			new_item:SetScale(ml_v.sx,ml_v.sy,ml_v.sz)
--			--new_item:CreateEffect();
--			self:OnLoadItem(new_item);
--		end
--	end	
--end

--function MainCityScene:OnLoadItem(new_item)

--end

--function MainCityScene:GetCurHurdleID()
--    return self.loadData.levelData.hurdleid
--end

--function MainCityScene:GetStartUpEnv()
--    return self.loadData
--end

---- function MainCityScene:ChangeCaptain()

---- 	local cardHuman_id = g_dataCenter.player:GetDefTeam()[1];
---- 	local cardHuman = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero, cardHuman_id)
---- 	local file_name = ObjectManager.GetHeroModelFile(cardHuman.number);
---- 	ResourceLoader.LoadAsset(file_name, {func=self.on_load_model, user_data = self})
---- end

--function MainCityScene:ChangeCaptain()
--	if self.my_captain then
--		self.oldPos = self.my_captain:GetPosition();
--		FightScene.DeleteObj(self.my_captain:GetName(), 0);
--	else
--		if not self.oldPos then
--			self.oldPos = {};
--			local pos = ConfigHelper.GetMapInf(self:GetCurHurdleID(,EMapInfType.burchhero)
--			self.oldPos.x,self.oldPos.y,self.oldPos.z = pos.px,pos.py,pos.pz;
--		end
--	end


--	local hero_id = g_dataCenter.player:GetDefTeam()[1]
--	local card_number = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero, hero_id).number;
--	if not self.obj_temp_model then return end
--	local hero = FightScene.CreateNoPreLoadHero(g_dataCenter.player:GetGID(), card_number, g_dataCenter.fight_info.single_friend_flag, 0, 1, hero_id, g_dataCenter.player.package)
--	if not hero then return end
--	hero:SetPosition(self.oldPos.x,self.oldPos.y,self.oldPos.z)
--	hero:GetHpUi():Show(false);
--	local guild_name = nil;
--	if g_dataCenter.guild.detail then
--		guild_name = g_dataCenter.guild.detail.name;
--	end
--	hero:InitMainNameUi({type=2,name=g_dataCenter.player.name, vip_level = g_dataCenter.player.vip, guild = guild_name});
--	g_dataCenter.fight_info:SetCaptain(1)
--    local oldCaptain = self.my_captain
--	self.my_captain = g_dataCenter.fight_info:GetCaptain()
--    if oldCaptain ~= self.my_captain and self.my_captain then
--        FightUI.SetCtrlHeroEffect(self.my_captain)
--    end
--	self.my_captain:SetAI(ENUM.EAI.MainHero)
--	CameraManager.init_target(self.my_captain, CameraState.syncFollowHero)
--	CameraManager.MoveToTargetImm()

--end

--function MainCityScene:SetEnterSystemID(id)
--	self.system_id = id;
--end

--function MainCityScene:TouchMainCityNpc()
--	if not self.system_id then return end

--	SystemEnterFunc[self.system_id]();
--	self:SetEnterSystemID(nil);
--end

--function MainCityScene:MoveCaptainToNpc(system_id)
--	local pos = npc_pos[system_id];
--	if not pos then return end
--	self:SetEnterSystemID(system_id)
--	self:SetMovePos(pos.x, pos.y, pos.z)
--	if not self.my_captain then return end
--	self.my_captain:SetHandleState(EHandleState.MainCityMove)
--end

--function MainCityScene:SetMovePos(x,y,z)
--	self.move_x,self.move_y,self.move_z = x,y,z
--end

--function MainCityScene:GetMovePos()
--	return self.move_x,self.move_y,self.move_z;
--end

--function MainCityScene:GetNpcInfoByName(name)
--	if not self.npc_info then return nil end
--	return self.npc_info[name]
--end

--function MainCityScene:StopCaptain()
--	if not self.system_id then return end
--	self:SetEnterSystemID(nil)
--	if not self.my_captain then return end
--	self.my_captain:SetHandleState(EHandleState.Manual)
--end

----在场景上添加一个机器人
--function MainCityScene:AddHero(vecMockPlayer)
--	for k,v in pairs(vecMockPlayer) do
--        local hero_name = ObjectManager.GetObjectName(OBJECT_TYPE.HERO, g_dataCenter.fight_info.single_enemy_flag, v.cardgid);
--        if self.robot_info[hero_name] then
--            world_msg.cg_request_hall_mock_player(1)
--        else
--            local temp_package = Package:new();
--		    temp_package:AddCard(ENUM.EPackageType.Hero, {dataid = v.cardgid,number = v.heroID});
--		    if self.robots_count >= MAX_ROBOT_COUNT then return end
--		    if not self.obj_temp_model then return end
--		    local hero = FightScene.CreateNoPreLoadHero(v.player_gid, v.heroID, g_dataCenter.fight_info.single_enemy_flag, 0, 1, v.cardgid, temp_package)
--		    if not hero then return end
--		    self.robot_info[hero:GetName()] = hero;
--		    local hbp = self.hero_born_pos;
--		    if #hbp == 0 then return end
--		    local n = math.random(1,#hbp);
--		    local p = {};
--		    p.x,p.y,p.z = hbp[n].px,hbp[n].py,hbp[n].pz;
--		    local x,y,z = self:_GetRandomPos(p, {x=hbp[n].rx,y=hbp[n].ry,z=hbp[n].rz}, {x=hbp[n].sx,y=hbp[n].sy,z=hbp[n].sz});
--		    self.robot_info[hero:GetName()]:SetPosition(x,y,z)
--		    local name = v.playerName;
--		    local vip_level;
--		    if v.viplevel then
--		    	vip_level = v.viplevel;
--		    end
--		    --self.robot_info[hero:GetName()]:GetHpUi():OnlyShowName(true,"[ffffff]"..name.."[-]");


--		    self.robot_info[hero:GetName()]:GetHpUi():Show(false);

--		    self.robot_info[hero:GetName()]:InitMainNameUi({type = 2,name=name, vip_level = vip_level});

--		    local path = {};
--            for k,v in pairs(npc_pos) do
--                table.insert(path, v)
--            end

--		    self.robot_info[hero:GetName()]:SetAI(119);
--		    self.robot_info[hero:GetName()]:SetPatrolMovePath(path);
--    --		self.robot_info[#self.robot_info]:SetAlongPathLoop(true);
--		    self.robots_count = self.robots_count + 1;
--        end

--	end
--end

----删除场景上一个机器人
--function MainCityScene:DeleteHero(name)
--	FightScene.DeleteObj(name, 10);
--    --ObjectManager.DeleteObj(name)
--	if self.robot_info[name] then
--		self.robot_info[name] = nil;
--	end
--	self.robots_count = self.robots_count - 1;
--	world_msg.cg_request_hall_mock_player(1)
--end

----获取一个位置周围的随机一个位置
--function MainCityScene:_GetRandomPos(pos,rot,scale)
--	local x0,y0,z0; --随机区域中心坐标
--	local x1,y1,z1; --未旋转之前的坐标
--	local x,y,z;    --旋转后的坐标
--	x0 = pos.x;
--	y0 = pos.y;
--	z0 = pos.z;

--	local x_offset = (math.random()-0.5)*scale.x;
--	local z_offset = (math.random()-0.5)*scale.z;
--	x1 = x0 + x_offset;
--	y1 = y0;
--	z1 = z0 + z_offset;

--	local quaternion = {};
--	quaternion.x, quaternion.y, quaternion.z, quaternion.w = util.quaternion_euler(rot.x,rot.y,rot.z);
--	x,y,z = util.quaternion_multiply_v3(quaternion.x, quaternion.y, quaternion.z, quaternion.w, x_offset, 0, z_offset);
--	x = x + x0;
--	y = y + y0;
--	z = z + z0;

--	return x,y,z;
--end