MonsterLoader = Class("MonsterLoader");

function MonsterLoader:Init()
	self.fightScript = nil;
	self.timer_id = nil;
	self.monsterWaveIndex = 1;   --[[怪物波次id]]
	self.monsterWaveCount = 1;	 --[[当前波次已刷次数]]
	self.waveCount = 1;			 --[[总刷怪次数]]
	self.waveGroudIndex = 1;  	 --[[大波次]]
	self.waveGroudCount = 1;	 --[[当前大波次总次数]]
	self.curMonsterCount = 0;
	self.needClear = false;
	self.isEnd = false;
	self.isGroudEnd = false;
	self.monster_time_id = {};	
	self.monster_gid = {};
	self.monsterLevel = nil;
	self.updateBrushMonsterList = {};
	--[[ 各种回调 ]]
	self.createMonsterCallback = nil;
	self.beginWaveCallback = nil;
	self.endWaveCallback = nil;
	self.beginGroudCallback = nil;
	self.endGroudCallback = nil;
	-- [[子刷怪器管理]]
	self.childLoader = {};
end

function MonsterLoader:SetCallback(callback_table)
	self.createMonsterCallback = callback_table.create_monster or self.createMonsterCallback;
	self.beginWaveCallback = callback_table.begin_wave or self.beginWaveCallback;
	self.endWaveCallback = callback_table.end_wave or self.endWaveCallback;
	self.beginGroudCallback = callback_table.begin_groud or self.beginGroudCallback;
	self.endGroudCallback = callback_table.end_groud or self.endGroudCallback;
	self.killWaveCallback = callback_table.kill_wave or self.killWaveCallback;
	self.killGroudCallback = callback_table.kill_groud or self.killGroudCallback;
end

function MonsterLoader:SetScript(script)
	self.fightScript = script;
    if self.fightScript then
	    self.maxMonsterCount = self.fightScript.max_monster_count
		if self.fightScript.is_match_player_level == true then
			self.monsterLevel = g_dataCenter.fight_info:GetAvgLevel(g_dataCenter.fight_info.single_friend_flag)
		else
			local fm = FightScene.GetFightManager()
			if fm then
				self.monsterLevel = fm:GetMonsterLevel()
			end
		end
    end
end

function MonsterLoader:OnEvent_DeadMonster()
	if not self.fightScript then
		return;
	end
	for k,v in pairs(self.childLoader) do
		v:OnEvent_DeadMonster();
	end
	local fight_mgr = FightScene.GetFightManager();
    local npc_list = g_dataCenter.fight_info:GetMonsterList(g_dataCenter.fight_info.single_enemy_flag);
	local num = 0;
	for k,v in pairs(npc_list) do
		local obj = ObjectManager.GetObjectByName(v);
		if not obj or not obj:IsDead() then
			num = num + 1;
		end
	end
	if num < 1 then
		--[[一小波刷怪击杀完]]
		if not self.fightScript.monster_wave and not self.fightScript.monster_wave_groud then
			return;
		end
		local callfunc1 = nil
		local callfunc2 = nil
		local cur_wave;
		local max_wave;
		if self.killWaveCallback then
			cur_wave = self.waveCount-1;
			if self.fightScript.monster_wave then
				max_wave = self:GetMaxWaveCnt(self.fightScript.monster_wave);
			else
				local wave = self:_GetWaveGroud(self.waveGroudIndex);
				if not wave then
					wave = self:_GetWaveGroud(self.waveGroudIndex-1);
				end
				max_wave = self:GetMaxWaveCnt(wave);
			end
			if max_wave == 0 then
				max_wave = self:GetMaxWaveCnt(self:_GetWaveGroud(self.waveGroudIndex-1));
				cur_wave = max_wave;
			end
			-- self.killWaveCallback[1](self.killWaveCallback[2],cur_wave,max_wave);
			callfunc1 = function ()
				self.killWaveCallback[1](self.killWaveCallback[2],cur_wave,max_wave);
			end
		end
		--[[一大波杀完回调]]
		if self.killGroudCallback and self.isGroudEnd then
			local cur_groud = self.waveGroudIndex-1;
			local cur_wave = #self.fightScript.monster_wave_groud[cur_groud];
			local max_groud = #self.fightScript.monster_wave_groud;
			-- self.killGroudCallback[1](self.killGroudCallback[2],cur_groud,cur_wave,max_groud);
			self.isGroudEnd = false;
			callfunc2 = function ()
				self.killGroudCallback[1](self.killGroudCallback[2],cur_groud,cur_wave,max_groud);
			end
		end

		local clear = true
		if cur_wave and self.monster_gid[cur_wave] then
			for i, gid in pairs(self.monster_gid[cur_wave]) do
				local obj =  ObjectManager.GetObjectByGID(gid)
				if obj and not obj:IsDead() then
					clear = false
					break;
				end
			end
		end
		if clear then
			if callfunc1 then
				callfunc1()
			end
			if callfunc2 then
				callfunc2()
			end

			if self.needClear then
				self.needClear = false;
				-- self.waveCount = self.waveCount - 1;
				-- self.monsterWaveCount = self.monsterWaveCount - 1;
				if self:_GetWaveData(self.monsterWaveIndex) then
					self:_NextWave();
				else
					self:_NextGroudWave();
				end
			end
		end
	end
end

function MonsterLoader:OnStart()
    if self.fightScript == nil then
    	self.isEnd = true;
        return
    end
    if self.fightScript.limit_loader then
    	local list = self.fightScript.limit_loader;
    	for k,cfg in pairs(list) do
			local loader = MonsterLoaderLimit:new(cfg);
			loader:SetMonsterLevel(self.monsterLevel);
    		loader:OnStart();
    		loader:SetCallback({create_monster=self.createMonsterCallback});
    		table.insert(self.childLoader, loader);
    	end
    end
	local config = self:_GetWaveData(self.monsterWaveIndex);
	if config then
		local delta_time = self:_GetDeltaTime(config);
		if delta_time ~= 0 then
			self.timer_id = timer.create(Utility.create_callback(MonsterLoader._NextWave, self),delta_time*1000,1);
		else
			self:_NextWave();
		end
	else
		local groud = self:_GetWaveGroud(self.waveGroudIndex);
		if groud then
			config = groud[self.monsterWaveIndex];
			local delta_time = self:_GetDeltaTime(config);
			if delta_time ~= 0 then
				self.timer_id = timer.create(Utility.create_callback(MonsterLoader._NextGroudWave, self),delta_time*1000,1);
			else
				self:_NextGroudWave();
			end
			--[[开始一大波回调]]
			if self.beginGroudCallback then
				local cur_groud = self.waveGroudIndex;
				local max_groud = #self.fightScript.monster_wave_groud;
				self.beginGroudCallback[1](self.beginGroudCallback[2],cur_groud,max_groud);
			end
		else
			self.isEnd = true;
		end
	end
end

function MonsterLoader:GetNPCAssetFileList(out_file_list)
	local monster_id_list = {}
	local fightScript = self.fightScript;
    if fightScript == nil then
        return
    end
	if fightScript.monster_wave then
		for k, v in pairs(fightScript.monster_wave) do
			for kk, vv in pairs(v.monsters) do
				local monster_id = vv.monster_id
				if nil ~= monster_id or 0 ~= monster_id then
					monster_id_list[monster_id] = true
				end
			end
		end
	end
	if fightScript.monster_wave_groud then
		for k, v in pairs(fightScript.monster_wave_groud) do
			for k,v in pairs(v) do
				for kk, vv in pairs(v.monsters) do
					local monster_id = vv.monster_id
					if nil ~= monster_id or 0 ~= monster_id then
						monster_id_list[monster_id] = true
					end
				end
			end
		end
	end

	for k, v in pairs(monster_id_list) do
		local filePath = ObjectManager.GetMonsterModelFile(k)
		out_file_list[filePath] = filePath
	end
end

function MonsterLoader:Destroy()
	for k,v in pairs(self.childLoader) do
		v:Destroy();
	end
	self.createMonsterCallback = nil;
	self.beginWaveCallback = nil;
	self.endWaveCallback = nil;
	self.beginGroudCallback = nil;
	self.endGroudCallback = nil;
	self.updateBrushMonsterList = nil;
	if self.timer_id then
		timer.stop(self.timer_id);
	end
	if self.monster_time_id and type(self.monster_time_id) == "table" then
		for k,v in pairs(self.monster_time_id) do
			timer.stop(v);
		end
		self.monster_time_id = nil;
	end
end

function MonsterLoader:Pause()
	self.isPause = true;
	for k,v in pairs(self.childLoader) do
		v:Pause();
	end
	if self.timer_id then
		timer.pause(self.timer_id);
	end
	if self.monster_time_id and type(self.monster_time_id) == "table" then
		for k,v in pairs(self.monster_time_id) do
			timer.pause(v);
		end
	end
end

function MonsterLoader:Resume()
	self.isPause = false;
	for k,v in pairs(self.childLoader) do
		v:Resume();
	end
	if self.timer_id then
		timer.resume(self.timer_id);
	end
	if self.monster_time_id and type(self.monster_time_id) == "table" then
		for k,v in pairs(self.monster_time_id) do
			timer.resume(v);
		end
	end
end

function MonsterLoader:_NextWave()
	self.timer_id = nil;
	
	local wave_data = self:_GetWaveData(self.monsterWaveIndex);
	if wave_data == nil then return end;

	--[[开始一小波刷怪回调]]
	if self.beginWaveCallback then
		local cur_wave = self.waveCount;
		local max_wave = self:GetMaxWaveCnt(self.fightScript.monster_wave);
		self.beginWaveCallback[1](self.beginWaveCallback[2],cur_wave,max_wave);
	end

	self:BrushMonster(wave_data.monsters);

	self.waveCount = self.waveCount + 1;
	self.monsterWaveCount = self.monsterWaveCount + 1;
	local config = self:_GetWaveData(self.monsterWaveIndex);
	local count = config.count or 1;
	if count < self.monsterWaveCount and count ~= -1 then
		self.monsterWaveCount = 1;
		self.monsterWaveIndex = self.monsterWaveIndex + 1;
	end
	local config = self:_GetWaveData(self.monsterWaveIndex);
	if not config then
		--[[一小波刷怪结束回调]]
		if self.endWaveCallback then
			local next_wave = self.waveCount;
			local max_wave = self:GetMaxWaveCnt(self.fightScript.monster_wave);
			self.endWaveCallback[1](self.endWaveCallback[2],next_wave,max_wave);
		end
		self.isEnd = true;
		return;
	end
	local delta_time = self:_GetDeltaTime(config);
	if delta_time and delta_time > 0 then
		self.timer_id = timer.create(Utility.create_callback(MonsterLoader._NextWave, self),delta_time*1000,1);
	elseif delta_time and delta_time == 0 then
		self:_NextWave();
	else
		self.needClear = true;
	end
	--[[一小波刷怪结束回调]]
	if self.endWaveCallback then
		local next_wave = self.waveCount;
		local max_wave = self:GetMaxWaveCnt(self.fightScript.monster_wave);
		self.endWaveCallback[1](self.endWaveCallback[2],next_wave,max_wave);
	end
end

function MonsterLoader:_NextGroudWave()
	self.timer_id = nil;
	local groud = self:_GetWaveGroud(self.waveGroudIndex);
	local wave_data = groud[self.monsterWaveIndex];
	--[[开始一小波刷怪回调]]
	if self.beginWaveCallback then
		local cur_wave = self.waveGroudCount;
		local max_wave = self:GetMaxWaveCnt(groud);
		self.beginWaveCallback[1](self.beginWaveCallback[2],cur_wave,max_wave);
	end

	self.monster_gid = {} --刷下一大波次怪清空怪物gid索引
	self:BrushMonster(wave_data.monsters);

	self.waveCount = self.waveCount + 1;
	self.monsterWaveCount = self.monsterWaveCount + 1;
	self.waveGroudCount = self.waveGroudCount + 1;
	local config = groud[self.monsterWaveIndex];
	local count = config.count or 1;
	-- app.log_warning("count:"..tostring(count));
	-- app.log_warning("wave count:"..tostring(self.monsterWaveCount));
	if count < self.monsterWaveCount and count ~= -1 then
		self.monsterWaveCount = 1;
		self.monsterWaveIndex = self.monsterWaveIndex + 1;
	end
	local config = groud[self.monsterWaveIndex];
	if not config then
		self.waveGroudIndex = self.waveGroudIndex + 1;
		self.monsterWaveIndex = 1;
		--[[临时：1秒后立即开始下一大波刷怪]]
		-- timer.create(Utility.create_callback(MonsterLoader.OnStart,self),5000,1);
		--[[一小波刷怪结束回调]]
		if self.endWaveCallback then
			local next_wave = self.waveGroudCount
			local max_wave = self:GetMaxWaveCnt(groud);
			self.endWaveCallback[1](self.endWaveCallback[2],next_wave,max_wave);
		end
		--[[一大波刷怪结束回调]]
		if self.endGroudCallback then
			local cur_groud = self.waveGroudIndex;
			local max_groud = #self.fightScript.monster_wave_groud;
			self.endGroudCallback[1](self.endGroudCallback[2],cur_groud,max_groud);
		end
		self.isGroudEnd = true;
		self.isEnd = #self.fightScript.monster_wave_groud < self.waveGroudIndex;
		self.waveGroudCount = 1;
		return;
	end
	local delta_time = self:_GetDeltaTime(config);
	if delta_time and delta_time > 0 then
		self.timer_id = timer.create(Utility.create_callback(MonsterLoader._NextGroudWave, self),delta_time*1000,1);
	elseif delta_time and delta_time == 0 then
		self:_NextGroudWave();
	else
		self.needClear = true;
	end
	--[[一小波刷怪结束回调]]
	if self.endWaveCallback then
		local next_wave = self.waveGroudCount;
		local max_wave = self:GetMaxWaveCnt(groud);
		self.endWaveCallback[1](self.endWaveCallback[2],next_wave,max_wave);
	end
end

--[[刷怪]]
function MonsterLoader:BrushMonster(monster_list)
	for k,v in pairs(monster_list) do
		local number;
		local range_count = v.count_range;
		if range_count then
			number = math.random(range_count[1],range_count[2]);
		else
			number = v.count or 1;
		end
		local delta_time = self:_GetDeltaTime(v);
		for i=1,number do
			if not self.maxMonsterCount 
				or self.curMonsterCount < self.maxMonsterCount 
			then
				if delta_time and delta_time > 0 then
					local name = tostring(v)..tostring(i)
					self.monster_time_id[name] = timer.create(
						Utility.create_obj_callback(self,MonsterLoader.PushMonsterList,0,v,name, self.monsterWaveIndex),
						delta_time*1000*i,1);
				else
					-- self:SetMonster(v, nil, self.monsterWaveIndex);
					table.insert(self.updateBrushMonsterList, {v,self.monsterWaveIndex});
				end
			end
		end
	end
end

function MonsterLoader:PushMonsterList(v, name, waveIndex)
	if name and self.monster_time_id then
		self.monster_time_id[name] = nil;
	end
	if self.updateBrushMonsterList then
		table.insert(self.updateBrushMonsterList, {v,waveIndex});
	end
end

function MonsterLoader:SetMonster(v, waveIndex)
	local camp_flag = v.flag or g_dataCenter.fight_info.single_enemy_flag;
	local level = self.monsterLevel;
	local obj = FightScene.CreateMonsterAsync(nil,v.monster_id, camp_flag, nil,level, nil, v.anim_id);
	if v.ai_id then
		obj:SetAI(v.ai_id);
	end
	if v.target_type then
		obj:SetAttackType(v.target_type);
	end
	if v.way_point_alias then
		local path = self:_GetMonsterWayPoint(v.way_point_alias);
		if #path ~= 0 then
			obj:SetPatrolMovePath(path);
		end
	end
	local point,m_point = self:_GetMonsterBornPoint(v.pos_alias);
	obj:SetPosition(point.x, point.y, point.z);
	obj:SetInstanceName(m_point.obj_name);
	if type(v.rot) == "table" then
		obj:SetRotation(v.rot[1] or 0, v.rot[2] or 0, v.rot[3] or 0);
	end
	PublicFunc.UnifiedScale(obj, v.scalex, v.scaley, v.scalez);
	local rand = math.random();
	if v.on_dead_callback then
		for kk,vv in pairs(v.on_dead_callback) do
			if vv[2] > rand then
				obj:SetOnDeadCallBack("TriggerEffect."..vv[1]);
				break;
			end
			rand = rand - vv[2];
		end
	end

	if self.monster_gid[waveIndex] == nil then
		self.monster_gid[waveIndex] = {}
	end
	table.insert(self.monster_gid[waveIndex], obj:GetGID())

	--[[创建一个怪后回调]]
	if self.createMonsterCallback then
		self.createMonsterCallback[1](self.createMonsterCallback[2],obj);
	end
	self.curMonsterCount = self.curMonsterCount + 1;
end

function MonsterLoader:Update(deltaTime)
	if self.isPause then return end;
	for k,v in pairs(self.childLoader) do
		v:Update(deltaTime);
	end
	local info = self.updateBrushMonsterList[1];
	if info then
		table.remove(self.updateBrushMonsterList,1);
		self:SetMonster(info[1], info[2]);
	end
end

function MonsterLoader:_GetWaveData(wave_index)
	local wave_data = self.fightScript.monster_wave;
	if nil == wave_data then
		return nil;
	end
	return wave_data[wave_index]
end

function MonsterLoader:_GetWaveGroud(wave_groud_id)
	local wave_data = self.fightScript.monster_wave_groud;
	if nil == wave_data then
		return nil;
	end
	return wave_data[wave_groud_id]
end

function MonsterLoader:_GetMonsterBornPoint(name)
	local point = LevelMapConfigHelper._GetMonsterBornPoint(name);
	return MonsterLoader._GetRandomPos(point), point;
end

function MonsterLoader:_GetMonsterWayPoint(way_head)
	local point_list = LevelMapConfigHelper.GetWayPoint(way_head);
	for k,v in pairs(point_list) do
		point_list[k] = MonsterLoader._GetRandomPos(v);
	end
	return point_list;
end

--获取一个位置周围的随机一个位置
function MonsterLoader._GetRandomPos(point)
	if not point then return end;
	local x0,y0,z0; --随机区域中心坐标
	local x1,y1,z1; --未旋转之前的坐标
	local x,y,z;    --旋转后的坐标
	x0 = point.px;
	y0 = point.py;
	z0 = point.pz;
	
	local x_offset = (math.random()-0.5)*point.sx;
	local z_offset = (math.random()-0.5)*point.sz;
	x1 = x0 + x_offset;
	y1 = y0;
	z1 = z0 + z_offset;
	
	local quaternion = {};
	quaternion.x, quaternion.y, quaternion.z, quaternion.w = util.quaternion_euler(point.rx,point.ry,point.rz);
	x,y,z = util.quaternion_multiply_v3(quaternion.x, quaternion.y, quaternion.z, quaternion.w, x_offset, 0, z_offset);
	x = x + x0;
	y = y + y0;
	z = z + z0;
	
	return {x=x,y=y,z=z};
end

function MonsterLoader:_GetDeltaTime(config)
	local delta_time = config.delta_time_s;
	if not delta_time then
		local t = config.delta_time_range;
		if t then
			delta_time = math.random(t[1],t[2]);
		end
	end
	return delta_time;
end

function MonsterLoader:GetMaxWaveCnt(wave)
	local num = 0;
	if type(wave) ~= "table" then
		return num;
	end
	for k,v in pairs(wave) do
		local cnt = v.count or 1;
		num = num + cnt;
	end
	return num;
end

function MonsterLoader:GetMonsterWaveMaxWaveCnt()

	local cnt = 0
	if self.fightScript.monster_wave then
		cnt = self:GetMaxWaveCnt(self.fightScript.monster_wave)
	end

	return cnt
end

function MonsterLoader:IsFinish()
	for k,v in pairs(self.childLoader) do
		if not v:IsFinish() then
			return false;
		end
	end
	if not self.isEnd then
		return false;
	end
	if #self.updateBrushMonsterList ~= 0 then
		return false;
	end
	if not Utility.isEmpty(self.monster_time_id) then
		return false;
	end
	return true;
end
