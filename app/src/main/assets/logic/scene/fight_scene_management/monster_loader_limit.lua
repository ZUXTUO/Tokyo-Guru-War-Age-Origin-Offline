-- fight_script中limit_loader项刷怪
-- 每项一个该刷怪器实例
-- 该刷怪器在monster_loader中创建
MonsterLoaderLimit = Class("MonsterLoaderLimit", MonsterLoaderBase);

function MonsterLoaderLimit:Init(cfg)
	self.list = cfg.list;
	self.maxNum = cfg.top;
	self.minNum = cfg.down;
	self.delayTime = cfg.delay;
	self.monsterDelay = cfg.monster_delay or 1;
	self.MonsterList = {};
	self.beginTimer = nil;
	self.monsterTimer = nil;
	self.monsterGID = {};
	self.updateBrushMonsterList = {};
	self.curNum = 1;
	self.curIndex = 1;
	self.Lock = false;
end

function MonsterLoaderLimit:SetMonsterLevel(monsterLevel)
	self.monsterLevel = monsterLevel
end

function MonsterLoaderLimit:OnStart()
	MonsterLoaderBase.OnStart(self);
	if type(self.delayTime) == "number" and self.delayTime ~= 0 then
		self.beginTimer = timer.create(
			Utility.create_obj_callback(self,self.NextMonster),
			self.delayTime*1000,1);
	else
		self:NextMonster();
	end
end

function MonsterLoaderLimit:NextMonster()
	self.beginTimer = nil;
	if self.Lock then
		return;
	end
	local cfg = self.list[self.curIndex];
	if cfg == nil then
		return;
	end
	if cfg.count < self.curNum then
		self.curIndex = self.curIndex + 1;
		cfg = self.list[self.curIndex];
		self.curNum = 1;
	end
	if cfg == nil then
		return;
	end
	local delay = cfg.delta_time_s or self.monsterDelay;
	local func = function (cfg)
		self.monsterTimer = nil;
		if self.Lock then
			return;
		end
		self.curNum = self.curNum + 1;
		table.insert(self.updateBrushMonsterList,cfg);
		self:NextMonster();
	end
	if delay == 0 then
		func(cfg);
	else
		self.monsterTimer = timer.create(
			Utility.create_callback(func,cfg),delay*1000,1);
	end
end

function MonsterLoaderLimit:Update(deltaTime)
	if self.Lock then
		return;
	end
	local info = self.updateBrushMonsterList[1];
	if info then
		table.remove(self.updateBrushMonsterList,1);
		self:SetMonster(info);
	end
end

function MonsterLoaderLimit:SetMonster(cfg)
	local camp_flag = cfg.flag or g_dataCenter.fight_info.single_enemy_flag;
	local level = self.monsterLevel;
	local obj = FightScene.CreateMonsterAsync(nil,cfg.monster_id, camp_flag, nil,level, nil, cfg.anim_id);
	if cfg.ai_id then
		obj:SetAI(cfg.ai_id);
	end
	if cfg.target_type then
		obj:SetAttackType(cfg.target_type);
	end
	if cfg.way_point_alias then
		local path = self:_GetMonsterWayPoint(cfg.way_point_alias);
		if #path ~= 0 then
			obj:SetPatrolMovePath(path);
		end
	end
	local point,m_point = self:_GetMonsterBornPoint(cfg.pos_alias);
	obj:SetInstanceName(m_point.obj_name);
	obj:SetPosition(point.x, point.y, point.z);
	if type(cfg.rot) == "table" then
		obj:SetRotation(cfg.rot[1] or 0, cfg.rot[2] or 0, cfg.rot[3] or 0);
	end
	PublicFunc.UnifiedScale(obj, cfg.scale, cfg.scale, cfg.scale);

	self.monsterGID[obj:GetGID()] = 1;

	if self:GetNum() >= self.maxNum then
		self.Lock = true;
		if self.monsterTimer then
			timer.stop(self.monsterTimer);
			self.monsterTimer = nil;
		end
	end
		--[[创建一个怪后回调]]
	if self.createMonsterCallback then
		self.createMonsterCallback[1](self.createMonsterCallback[2],obj);
	end
end

function MonsterLoaderLimit:OnEvent_DeadMonster()
	for gid,v in pairs(self.monsterGID) do
		local obj =  ObjectManager.GetObjectByGID(gid)
		if obj == nil or obj:IsDead() then
			self.monsterGID[gid] = nil;
			break;
		end
	end
	if self:GetNum() < self.minNum and self.Lock then
		self.Lock = false;
		self:NextMonster();
	end
end

function MonsterLoaderLimit:GetNum()
	return table.get_num(self.monsterGID);
end

function MonsterLoaderLimit:Destroy()
	if self.monsterTimer then
		timer.stop(self.monsterTimer);
	end
	if self.beginTimer then
		timer.stop(self.beginTimer);
	end
end

function MonsterLoaderLimit:Pause()
	if self.monsterTimer then
		timer.pause(self.monsterTimer);
	end
	if self.beginTimer then
		timer.pause(self.beginTimer);
	end
	self.Lock = true;
end

function MonsterLoaderLimit:Resume()
	if self.monsterTimer then
		timer.resume(self.monsterTimer);
	end
	if self.beginTimer then
		timer.resume(self.beginTimer);
	end
	self.Lock = false;
end

function MonsterLoaderLimit:IsFinish()
	if self.curIndex <= #self.list then
		return false;
	end
	if self:GetNum() > 0 then
		return false;
	end
	return true;
end
function MonsterLoaderLimit:SetCallback(callback_table)
	self.createMonsterCallback = callback_table.create_monster or self.createMonsterCallback;
end