-- 玩法 gao su ju ji

BaoWeiCanChangFightManager = Class("BaoWeiCanChangFightManager", FightManager)
function BaoWeiCanChangFightManager:InitData()
	FightManager.InitData(self)
end

function BaoWeiCanChangFightManager.InitInstance()
	FightManager.InitInstance(BaoWeiCanChangFightManager)
	return BaoWeiCanChangFightManager
end

-- function BaoWeiCanChangFightManager:ClearUpInstance()
-- 	FightManager.ClearUpInstance(self)
-- 	--UiFightBaoWeiCanChang.DestroyFightUi()
-- end

function BaoWeiCanChangFightManager:LoadUI()
	FightManager.LoadUI(self)
--
	UiFightBaoWeiCanChang.Start()
end

function BaoWeiCanChangFightManager:OnStart()
	FightManager.OnStart(self)
	self:_Start()
end

-- function BaoWeiCanChangFightManager:OnFightOver()
-- 	FightManager.OnFightOver(self);
	
-- 	--UiFightBaoWeiCanChang.DestroyFightUi()
-- end

-- function BaoWeiCanChangFightManager:onForcedExit()
-- 	FightRecord.SetIsWin(self.passCondition.win.flag)
-- 	FightRecord.SetIsGood(self.passCondition.good.flag)
-- 	FightRecord.SetIsPerfect(self.passCondition.perfect.flag)
-- 	-- self:ClearAndEnterSettlementUI();
-- 	FightScene.OnFightOver()
-- 	--FightScene.ExitFightScene();
-- 	UiFightBaoWeiCanChang.DestroyFightUi();
-- 	--UiBaoWeiCanChangAward.ShowAwardUi({score=0})
-- 	-- 延迟操作。
-- 	timer.create(Utility.create_callback(self.ClearUpInstance, self), 1000, 1)
-- end

-- function BaoWeiCanChangFightManager:OnShowFightResultUI()
-- 	UiBaoWeiCanChangAward.ShowAwardUi({score = self.score})
-- end

function BaoWeiCanChangFightManager:GetUIAssetFileList(out_file_list)
	FightManager.GetUIAssetFileList(self, out_file_list)
	local file_list = {
		"assetbundles/prefabs/ui/wanfa/defense_house/ui_1003_bao_wei_can_chang.assetbundle",
	}
	for k, v in pairs(file_list) do
		out_file_list[v] = v
	end
end

function BaoWeiCanChangFightManager:OnEvent_ObjDead(killer, target)
	if target:GetCampFlag() == g_dataCenter.fight_info.single_enemy_flag and self.fightOver == false then
		local data = {};
		local script = self:GetFightScript()
		data.oldScore = self.score
		self.score = self.score + script.score[target.config.id];
		self.count_dead_monster = self.count_dead_monster + 1;
		data.score = self.score;
		data.killMonster = self.count_dead_monster;
		data.escapeMonster = self.count_run_away_monster;
		data.ObjName = target:GetName()
		--data.pos = {}
		--data.pos.x, data.pos.y, data.pos.z = target:GetPositionXYZ()
		UiFightBaoWeiCanChang.SetData(data)
	end
	FightManager.OnEvent_ObjDead(BaoWeiCanChangFightManager,killer, target);
end

function BaoWeiCanChangFightManager:OnRunAway(obj_name,time_delay)

	-- if time_delay and time_delay > 0 then
	-- 	timer.create(Utility.create_callback(BaoWeiCanChangFightManager.OnRunAway, self,obj_name, 0), time_delay, 1)
	-- 	return
	-- end
	
	-- if self.all_monster_table[obj_name] then
	-- 	self.all_monster_table[obj_name] = nil;
	-- 	self.count_run_away_monster = self.count_run_away_monster + 1;
	-- 	local data = {};
	-- 	data.score = self.score;
	-- 	data.killMonster = self.count_dead_monster;
	-- 	data.escapeMonster = self.count_run_away_monster;
	-- 	UiFightBaoWeiCanChang.SetData(data)
	-- end
end

function BaoWeiCanChangFightManager:_Start()
	self.count_dead_monster = 0;
	self.count_run_away_monster = 0;
	self.score = 0;
	self.all_monster_table = {};
end

function BaoWeiCanChangFightManager:OnLoadHero(entity)
	FightManager.OnLoadHero(self, entity)
	if not entity.navMeshAgent then
		return;
	end
	local layer_mask = PublicFunc.GetBitLShift({[1]=PublicStruct.NavigationAreas.walkable});
	entity.navMeshAgent:set_area_mask(layer_mask);
end

function BaoWeiCanChangFightManager:OnEntityModelChanged(entity)
	if not entity.navMeshAgent then
		return;
	end
	if entity:GetCampFlag() == 1 then
		local layer_mask = PublicFunc.GetBitLShift({[1]=PublicStruct.NavigationAreas.walkable});
		entity.navMeshAgent:set_area_mask(layer_mask);
	end
end

function BaoWeiCanChangFightManager:OnCreateMonster(obj)
	self.all_monster_table[obj:GetName()] = true;
	-- local hurdle_id = FightScene.GetCurHurdleID()
	-- local maoInfoID = FightScene.GetFightManager():GetFightMapInfoID()
	-- local way_point = LevelMapConfigHelper.GetWayPoint("wp_1");
	-- local length = #way_point;
	-- local path = {};
	-- for i=1,length do
	-- 	path[i] = {};
	-- 	local pos = {};
	-- 	pos.x,pos.y,pos.z = way_point[i].px,way_point[i].py,way_point[i].pz;
	-- 	local rot = {};
	-- 	rot.x,rot.y,rot.z = way_point[i].rx,way_point[i].ry,way_point[i].rz;
	-- 	local scale = {};
	-- 	scale.x,scale.y,scale.z = way_point[i].sx,way_point[i].sy,way_point[i].sz;
	-- 	path[i].x,path[i].y,path[i].z = self:_GetRandomPos(pos,rot,scale);
	-- end
	-- local item = ConfigHelper.GetMapInf(maoInfoID,EMapInfType.item)
	-- local destination = {};
	-- for k,v in pairs(item) do
	-- 	if v.obj_name == "destination" then
	-- 		table.insert(destination,v);
	-- 	end
	-- end
	-- if #destination == 0 then
	-- 	app.log("保卫喰场目的地名字不是叫destination");
	-- 	return
	-- end
	-- local n = math.random(1,#destination);
	-- path[length+1] = {};
	-- path[length+1].x,path[length+1].y,path[length+1].z = destination[n].px,destination[n].py,destination[n].pz;
	-- obj:SetPatrolMovePath(path);

	-- if not obj.navMeshAgent then
	-- 	return;
	-- end
	--local layer_mask = PublicFunc.GetBitLShift({[1]=PublicStruct.NavigationAreas.walkable,[2] = PublicStruct.NavigationAreas.monster_only});
	--obj.navMeshAgent:set_area_mask(layer_mask);
end

--获取一个位置周围的随机一个位置
function BaoWeiCanChangFightManager:_GetRandomPos(pos,rot,scale)
	local x0,y0,z0; --随机区域中心坐标
	local x1,y1,z1; --未旋转之前的坐标
	local x,y,z;    --旋转后的坐标
	x0 = pos.x;
	y0 = pos.y;
	z0 = pos.z;
	
	local x_offset = (math.random()-0.5)*scale.x;
	local z_offset = (math.random()-0.5)*scale.z;
	x1 = x0 + x_offset;
	y1 = y0;
	z1 = z0 + z_offset;
	
	local quaternion = {};
	quaternion.x, quaternion.y, quaternion.z, quaternion.w = util.quaternion_euler(rot.x,rot.y,rot.z);
	x,y,z = util.quaternion_multiply_v3(quaternion.x, quaternion.y, quaternion.z, quaternion.w, x_offset, 0, z_offset);
	x = x + x0;
	y = y + y0;
	z = z + z0;
	
	return x,y,z;
end


--设置战斗规则脚本
function BaoWeiCanChangFightManager:SetFightScript(script)
	local difficultLevel = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]:GetDifficultLevel();

	local fightScriptId = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi_difficult,difficultLevel).fight_script_id;
	-- self.fightScript = _G["gd_fight_script_"..fightScriptId];
	self.fightScript = ConfigHelper.GetFightScript(fightScriptId) 
	self.monsterLoader:SetScript(self:GetFightScript())	
end

--ui加载完成的回调
--做一些模块ui的初始化
function BaoWeiCanChangFightManager:OnUiInitFinish()
	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsShowStarTip = (cf.is_show_star_tip == 1)
	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)
	GetMainUI():InitProgressBar()
	GetMainUI():InitTriggerOperator()
	
	--fy加入点击事件
	GetMainUI():InitMMOFightUIClick();
    if true or pmi then
        GetMainUI():InitTeamCanChange()
    else
        GetMainUI():InitTeamCannotChange()
    end

	GetMainUI():InitTimer()


	FightStartUI.Show({need_pause=true})
	FightStartUI.SetEndCallback(self.CallFightStart, self)
end

function BaoWeiCanChangFightManager:Destroy()
	FightManager.Destroy(self)

	UiFightBaoWeiCanChang.DestroyFightUi()
end

function BaoWeiCanChangFightManager:FightOver(is_set_exit, is_forced_exit)
    
	if not is_set_exit and not is_forced_exit and self.score then
		local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang];
		self:SetConditionWinFlag(fs:GetGoldProb() * self.score > 0)
	end

    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end
