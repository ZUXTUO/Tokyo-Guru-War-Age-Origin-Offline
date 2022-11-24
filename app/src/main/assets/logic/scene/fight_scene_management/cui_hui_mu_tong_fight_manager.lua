

CuiHuiMuTongFightManager = Class("CuiHuiMuTongFightManager", FightManager)

function CuiHuiMuTongFightManager:InitData()
	FightManager.InitData(self)
	--<region: member field >
	self.waveIndex = 1
	self.maxMonsterCount = 0;
	self.curMonsterCount = 0;
	self.nextWaveTimer = nil		
	self.monsterBronPoint = {};
	--</region:member field>
end

function CuiHuiMuTongFightManager.InitInstance()
	CuiHuiMuTongFightManager._super.InitInstance(CuiHuiMuTongFightManager)
	return CuiHuiMuTongFightManager;
end


function CuiHuiMuTongFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)

	CuiHuiMuTongFightUI.Destroy()
	---
	if self.nextWaveTimer ~= nil then
		timer.stop(self.nextWaveTimer)	
	end
end

function CuiHuiMuTongFightManager:Start()
	FightManager.Start(self)

	self:_OnStart()
end

function CuiHuiMuTongFightManager:OnStart()
end

function CuiHuiMuTongFightManager:GetHeroAssetFileList(out_file_list)
	FightManager.GetHeroAssetFileList(self, out_file_list)
end

function CuiHuiMuTongFightManager:GetNPCAssetFileList(out_file_list)
	FightManager.GetNPCAssetFileList(self, out_file_list)

	--1. load hero.
	--2. load towners and triggers.
	--3. load all monsters TODO: (kevin) load most earlier monsters.
	local config = FightScene.GetStartUpEnv()
	local fightScript = self:GetFightScript()
	if nil == fightScript then
		return
	end

	if lua_assert(fightScript.name == "CuiHuiMuTong", "CuiHuiMuTong bad script name.") then
		return		
	end

	local monster_id_list = {}
	for k, v in pairs(fightScript.monster_wave) do
		for kk, vv in pairs(v.monsters) do
			local monster_id = vv.monster_id
			if nil ~= monster_id or 0 ~= monster_id then
				monster_id_list[monster_id] = true
			end
		end
	end

	for k, v in pairs(monster_id_list) do
		local filePath = ObjectManager.GetMonsterModelFile(k)
		out_file_list[filePath] = filePath
	end

	----------------load item.
	-- for k, v in ipairs(fightScript.buff_point) do
	-- 	for kk, vv in ipairs(v) do
	-- 		for kkk, vvv in ipairs(vv) do
	-- 			if nil ~= vvv.model_id or 0 ~= vvv.model_id then
	-- 				local model_name = ConfigManager.Get(EConfigIndex.t_model_list,vvv.model_id).file
	-- 				local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle',model_name,model_name)
	-- 				--app.log("file:"..filePath)
	-- 				out_file_list[filePath] = filePath
	-- 			end
	-- 		end
	-- 	end
	-- end
end

function CuiHuiMuTongFightManager:GetItemAssetFileList(out_file_list)
	FightManager.GetItemAssetFileList(self, out_file_list)
end

function CuiHuiMuTongFightManager:GetUIAssetFileList(out_file_list)
	FightManager.GetUIAssetFileList(self, out_file_list)

	--TODO: @haofang 关卡内UI加载。。。。
end

function CuiHuiMuTongFightManager:Update()
	FightManager.Update(self)
end

function CuiHuiMuTongFightManager:LoadHero()
	FightManager.LoadHero(self)
end

function CuiHuiMuTongFightManager:LoadMonster()
	FightManager.LoadMonster(self)
end

function CuiHuiMuTongFightManager:LoadUI()
	FightManager.LoadUI(self)

	--TODO: @haofang 显示关卡内UI
	CuiHuiMuTongFightUI.Start();
end

------------------------------------------------------------------------------
function CuiHuiMuTongFightManager:OnEvent_TimeOut()
	FightManager.OnEvent_TimeOut(self)	

	--------------------
end

function CuiHuiMuTongFightManager:OnEvent_ObjDead(killer, target)
	FightManager.OnEvent_ObjDead(self, killer, target)
	CuiHuiMuTongFightUI.UpdateUI();
	local name = target:GetName();
	for k,v in pairs(self.monsterBronPoint) do
		if v == name then
			self.monsterBronPoint[k] = -1;
			break;
		end
	end
end


-----------------------------------------------------------------------------
function CuiHuiMuTongFightManager:_OnStart( )
	--[[初始化出生点]]
	self:InitBronPoint();
	self.rangeTime = self:_GetWaveData(1).delta_time_range;
	local delta_time = math.random(self.rangeTime[1],self.rangeTime[2]);
	self.nextWaveTimer = timer.create(Utility.create_callback(CuiHuiMuTongFightManager._NextWave, self),delta_time*1000,1);
end

function CuiHuiMuTongFightManager:_NextWave()
	self.nextWaveTimer = nil;
	local wave_data = self:_GetWaveData(1);

	for k,v in pairs(wave_data.monsters) do
		local range_count = v.count_range;
		local number = math.random(range_count[1],range_count[2]);
		for i=1,number do
			local point,index = self:_GetMonsterBronPoint(v.pos_alias);
			if point then
				local obj = FightScene.CreateMonsterAsync(nil,v.monster_id,2);
				obj:SetAI(v.ai_id);
				obj:SetPosition(point.px, point.py, point.pz);
				obj:SetRotation(point.rx, point.ry, point.pz);
				PublicFunc.UnifiedScale(obj, point.sx, point.sy, point.sz)
				self.monsterBronPoint[index] = obj:GetName();
				local rand = math.random();
				for k,v in pairs(v.on_dead_callback) do
					if v[2] > rand then
						obj:SetOnDeadCallBack("TriggerEffect."..v[1]);
						break;
					end
					rand = rand - v[2];
				end
			end
		end
	end

	self.waveIndex = self.waveIndex + 1;
	local delta_time = math.random(self.rangeTime[1],self.rangeTime[2]);
	self.nextWaveTimer = timer.create(Utility.create_obj_callback(self,CuiHuiMuTongFightManager._NextWave,1),delta_time*1000,1);
end

function CuiHuiMuTongFightManager:_GetMonsterBronPoint(name)
	local point_list = {};
	for k,v in pairs(self.monsterBronPoint) do
		if v == -1 then
			table.insert(point_list,k);
		end
	end
	local max = #point_list;
	if max > 0 then
		local rand = math.random(1,max);
		local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.burchmonster)
		local index = point_list[rand];
		local point = config[index];
		if point.sx * point.sy * point.sz ~= 1 then
			local x = point.sx/2;
			local z = point.sz/2;
			point.px = point.px + (math.random()-0.5)*x;
			point.pz = point.pz + (math.random()-0.5)*z;
			point.py = 0.5;
		end
		return point,point_list[rand];
	else
		return nil;
	end
end

function CuiHuiMuTongFightManager:_GetWaveData(wave_index)
	local wave_data = self:GetFightScript().monster_wave;
	if nil == wave_data then
		return nil
	end

	return wave_data[wave_index]
end

function CuiHuiMuTongFightManager:InitBronPoint()
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.burchmonster)
	for k,v in pairs(config) do
		if string.find(v.obj_name,"sbp_",1,true) then
			self.monsterBronPoint[k] = -1;
		end
	end
end
