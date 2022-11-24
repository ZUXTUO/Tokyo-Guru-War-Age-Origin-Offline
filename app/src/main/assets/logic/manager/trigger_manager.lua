
TriggerManager = Class("TriggerManager");

--data = 
--{
--	必须参数
--	roleEntity							拥有者entity
--	可选参数
--	trigger_finish_callback				碰撞完成触发
--}
function TriggerManager:TriggerManager(data)
	--角色entity
	self.roleEntityName = data.roleEntity:GetName();
	--触发回调
	self.trigger_finish_callback = data.trigger_finish_callback;
	--触发器列表
	self.trigger_list = {};
	self.deleteTriggerList = {}
	--触发器更新
	--Root.AddUpdate(TriggerManager.UpdateTrigger, self);
end

function TriggerManager:Finalize()

    self:RemoveAllTrigger()

	self.roleEntityName = nil;
	--Root.DelUpdate(TriggerManager.UpdateTrigger);

end

--创建一个触发器
--id触发器id
function TriggerManager:AddTrigger(id,roleEntity)
	if ConfigManager.Get(EConfigIndex.t_trigger_config,id) == nil then
		return;
	end
	local gameobj = roleEntity:GetObject();
	if gameobj == nil then
		return;
	end

	self.trigger_list[id] = self.trigger_list[id] or {}

	local new_trigger = nil;
	for k, v in pairs(ConfigManager.Get(EConfigIndex.t_trigger_config,id)) do
		if v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerEnter then
			new_trigger = ColliderEnterTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id});
		elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerStay then
			new_trigger = ColliderStayTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id});
		elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerExit then
			new_trigger = ColliderExitTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id});
		elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerEnterHurdleFight then
			new_trigger = EnterHurdleFightTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id});
		elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerHurdleFightOver then
			new_trigger = HurdleFightOverTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id});
		elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerThreeToThreeFightOver then
			new_trigger = ThreeToThreeFightOverTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id});
		elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerMyHeroPropertyChange then
			new_trigger = MyHeroPropertyTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id});
		elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerMonsterEnterFight then
			new_trigger = MonsterEnterFightTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
        elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerMonsterDead then
			new_trigger = MonsterDeadTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
        elseif v.trigger_type == ENUM.E_TRIGGER_TYPE.TriggerCutsceneEnd then
			new_trigger = CutsceneEndTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
		elseif v.trigger_type ==  ENUM.E_TRIGGER_TYPE.TriggerPlayerUseItem then
			new_trigger = PlayerUseItemTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
		elseif v.trigger_type ==  ENUM.E_TRIGGER_TYPE.MonsterLoaderTrigger then
			new_trigger = MonsterLoaderTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
		elseif v.trigger_type ==  ENUM.E_TRIGGER_TYPE.AddBuffTrigger then
			new_trigger = AddBuffTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
        elseif v.trigger_type ==  ENUM.E_TRIGGER_TYPE.TriggerEnterTimer then
			new_trigger = ColliderEnterTimerTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
            --动画回调
            roleEntity:SetTrigger(new_trigger)
        elseif v.trigger_type ==  ENUM.E_TRIGGER_TYPE.TriggerEnterAreaRandomItem then
			new_trigger = ColliderEnterAreaRandomItemTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
            --回调
            roleEntity:SetTrigger(new_trigger)
        elseif v.trigger_type ==  ENUM.E_TRIGGER_TYPE.FinishClearingTrigger then
			new_trigger = FinishClearingTrigger:new({config = v, roleEntity = roleEntity, trigger_id = id})
		end

		if new_trigger then
			table.insert(self.trigger_list[id], new_trigger)
		else
			app.log_warning("trigger type error")
		end

	end
	-- if new_trigger then
	-- 	self.trigger_list[id] = new_trigger;
	-- else
	-- 	app.log_warning("trigger type error")
	-- end
end

function TriggerManager:HasTriggerEffect(effectName)
	for id, triggers in pairs(self.trigger_list) do
		for k, tri in ipairs(triggers) do
			local has, effects = tri:HasTriggerEffect(effectName)
			if has then
				return has, effects
			end
		end
	end

	return false
end

function TriggerManager:HasIdsTrigger(ids)
	for k,id in ipairs(ids) do 
		if self.trigger_list[id] then
			return true
		end
	end
	return false
end

function TriggerManager:ForeachTriggerType(typeid, func)
	for k,v in pairs(self.trigger_list) do
		-- if v:GetTriggerType() == typeid then
		-- 	if func(v) == false then
		-- 		break;
		-- 	end
		-- end
		local isBreak = false
		for i,trigger in ipairs(v) do
			if trigger:GetTriggerType() == typeid then
				if func(trigger) == false then
					isBreak = true
					break
				end
			end
		end

		if isBreak then
			break
		end
	end
end

function TriggerManager:RemoveAllTrigger()
    for k,v in pairs(self.trigger_list) do
        -- if v then
        --     delete(v)
        -- end
		for index, trigger in ipairs(v) do
			if trigger then
				delete(trigger)
			end
		end
    end
    self.trigger_list = {}
end

--TRIGGER_DEBUG = true;
function TriggerManager:RemoveTrigger(trigger)
	if TRIGGER_DEBUG then
		app.log('huhu_trigger_debug 要删除一个触发器了 '..tostring(trigger:GetTriggerOwnerEntityName())..'\n'..tostring(trigger:GetTriggerType()));
	end

	for k,v in pairs(self.trigger_list) do
		local isBreak = false
		for index, tri in ipairs(v) do
			if tri == trigger then
				-- delete(trigger)
				-- table.remove(v, index)
				self.deleteTriggerList[k] = self.deleteTriggerList[k] or {}
				table.insert(self.deleteTriggerList[k], index)
				isBreak = true
				break
			end
		end

		if isBreak then
			break
		end
	end

	-- if table.get_num(self.trigger_list)	< 1 then
	-- 	local roleEntity = ObjectManager.GetObjectByName(self.roleEntityName);
	-- 	if roleEntity:IsItem() then
	-- 		ObjectManager.RemoveObject(roleEntity);
	-- 	end
	-- end
end

function TriggerManager:Update(deltaTime)
	

	-- 删除trigger
	for id, indexs in pairs(self.deleteTriggerList) do
		local triggers = self.trigger_list[id]
		if triggers == nil then
			app.log("#lhf#TriggerManager:Update id:"..tostring(id));
		else
			local count = #indexs
			for i = count,1,-1 do
				local deleteIndex = indexs[i]
				delete(triggers[deleteIndex])
				table.remove(triggers, deleteIndex)
			end

			if #triggers < 1 then
				self.trigger_list[id] = nil
			end
		end
	end
	if table.get_num(self.trigger_list) < 1 then
		local roleEntity = ObjectManager.GetObjectByName(self.roleEntityName);
		if roleEntity:IsItem() then
			ObjectManager.RemoveObject(roleEntity);
		end
	end
end

function TriggerManager:OnPropertyChange(role, property_type, lastvalue)
	if role:IsHero() then
		self:ForeachTriggerType(ENUM.E_TRIGGER_TYPE.TriggerMyHeroPropertyChange, function (trigger)
			--阵营判断
			if trigger.config.trigger_camp == OBJECT_TYPE_FLAG.ALL or role:GetCampFlag() == trigger.config.trigger_camp then
				
				--指定角色判断
				local triggerRole = trigger.config.trigger_role;
				--没有配置 或者是所有类型都直接触发 不做判断
				if type(triggerRole) == "table" then
					local roleCfg = triggerRole[1];
					-- 检查类型是否相同
					if roleCfg.objType and roleCfg.objType == OBJECT_TYPE.HERO then
						--配置了当前角色的话  不是当前角色直接退出
						if roleCfg.isCaptain == 1 and 
							role:GetName() ~= FightScene.GetFightManager():GetMyCaptainName() then
							return;
						end

						local isJump = true;
						--检查配置了id的话 当前id不在范围内直接退出
						if roleCfg.id then
							if type(roleCfg.id) == "table" then
								for k, v in pairs(roleCfg.id) do
									if v == role.card.number then
										isJump = false;
										break;
									end
								end	
							elseif roleCfg.id == role.card.number then
								isJump = false;
							end
							if isJump then
								return;
							end
						end
					end
				end

				if trigger:IsTrigger(role,property_type,lastvalue) then
					trigger:Trigger();
				end
			end
		end);
	elseif role:IsMonster() then
		self:ForeachTriggerType(ENUM.E_TRIGGER_TYPE.TriggerMyHeroPropertyChange, function (trigger)

			--指定怪物配置
			local triggerRole = trigger.config.trigger_role;
			--没有配置 或者是所有类型都直接触发 不做判断
			if type(triggerRole) == "table" then
				local roleCfg = triggerRole[1];
				-- 检查类型是否相同
				if roleCfg.objType and roleCfg.objType == OBJECT_TYPE.MONSTER then
					local isJump = true;
					--检查配置了id的话 当前id不在范围内直接退出
					if roleCfg.id then
						if type(roleCfg.id) == "table" then
							for k, v in pairs(roleCfg.id) do
								if v == role.card.number then
									isJump = false;
									break;
								end
							end	
						elseif roleCfg.id == role.card.number then
							isJump = false;
						end
						if isJump then
							return;
						end	
					end
				end
			end

			if trigger:IsTrigger(role,property_type,lastvalue) then
				-- 效果触发
--				if type(trigger.config.trigger_effect) == "table" then
--					for e, param in pairs(trigger.config.trigger_effect) do
--						if TriggerEffect[e] then
--							TriggerEffect[e](role, param);
--						end
--					end
--				end

--				trigger:Trigger();
                trigger:TriggerEffect(role:GetName())
			end
		end);
	end
end

-- 进入某个关卡的战斗时调用
function TriggerManager:OnEnterHurdleFight(hurdleid)
	--检查该关卡是否播放新手引导剧情，是则不触发该剧情
	if GuideManager.IsUseGuideHurdleScreenplay(hurdleid) then return false end

	local isTrigger = false;
	self:ForeachTriggerType(ENUM.E_TRIGGER_TYPE.TriggerEnterHurdleFight, function (trigger)
		
	    if TRIGGER_DEBUG then
	        app.log('huhu_trigger_debug OnEnterHurdleFight '..table.tostring(trigger.config)..'\n'..tostring(self.roleEntityName)..'\n'..table.tostring(self.trigger_list));
	    end


		if trigger:IsTrigger(hurdleid) then
			trigger:TriggerEffect()
			isTrigger = true;
		end
	end);
	return isTrigger;
end

-- 战斗结束调用。
function TriggerManager:OnHurdleFightOver(hurdleid,isWin)
	--检查该关卡是否播放新手引导剧情，是则不触发该剧情
	if GuideManager.IsUseGuideHurdleScreenplay(hurdleid) then return false end

    if TRIGGER_DEBUG then
        app.log('huhu_trigger_debug OnHurdleFightOver '..tostring(hurdleid)..'\n'..tostring(self.roleEntityName));
    end

	local trigger_type = ENUM.E_TRIGGER_TYPE.TriggerHurdleFightOver;

	local startUpInf = FightScene.GetStartUpEnv();
	local fight_type = startUpInf.levelData.fight_type;
	if fight_type == EFightType.threetothree then
		trigger_type = ENUM.E_TRIGGER_TYPE.TriggerThreeToThreeFightOver;
	end

	self:ForeachTriggerType(trigger_type, function (trigger)
		if trigger:IsTrigger(hurdleid, isWin) then
			trigger:Trigger(isWin);
		end
	end);
end

-- 刷怪器调用
-- loader_type  1 开始一小波 2 结束一小波 3 击杀完一小波 4 结束一大波 5 开始一大波 6 击杀完一大波
function TriggerManager:OnMonsterLoader(type, cur_groud, cur_wave)
	local trigger_type = ENUM.E_TRIGGER_TYPE.MonsterLoaderTrigger;
	self:ForeachTriggerType(trigger_type, function (trigger)
		if trigger:IsTrigger(type, cur_groud, cur_wave) then
			trigger:Trigger();
		end
	end);
end

-- 添加buff调用
function TriggerManager:OnAddBuff(buffid, bufflv)
	local trigger_type = ENUM.E_TRIGGER_TYPE.AddBuffTrigger;
	self:ForeachTriggerType(trigger_type, function (trigger)
		if trigger:IsTrigger(buffid, bufflv) then
			trigger:Trigger();
		end
	end);
end

function TriggerManager:OnFinishClearingTrigger()
	local trigger_type = ENUM.E_TRIGGER_TYPE.FinishClearingTrigger;
	self:ForeachTriggerType(trigger_type, function (trigger)
		if trigger:IsTrigger() then
			trigger:Trigger();
		end
	end);
end