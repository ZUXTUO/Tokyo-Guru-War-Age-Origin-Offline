
TriggerBase = Class('TriggerBase');

function TriggerBase:TriggerBase()
	self.config = {};
	self.triggerCount = 0;
    self.last_trigger_info = {}
end

function TriggerBase:Init(c)
	self:SetConfig(c.config, c.trigger_id);
	self.roleEntityName = c.roleEntity:GetName();

	self.bindfunc = {}
	self:registFunc();

	self:MsgRegist();

    if type(c.config.trigger_param) == 'table' and c.config.trigger_param.hideMesh==1 then
        local entity = c.roleEntity
        if entity ~= nil then
            local gameobj = entity:GetObject()
            gameobj:set_render_enable(false, true)
        end
    end

	-- if TRIGGER_DEBUG then
	-- 	app.log('huhu_trigger_debug 生成一个新的触发器 '..tostring(self:GetTriggerOwnerEntityName())..'\n'..tostring(self:GetTriggerType()));
	-- end
end

function TriggerBase:registFunc()
end

function TriggerBase:unregistFunc()
	if not self.bindfunc then
		return
	end

    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function TriggerBase:MsgRegist()
end

function TriggerBase:MsgUnRegist()
end

function TriggerBase:Finalize()
	if TRIGGER_DEBUG then
		app.log('huhu_trigger_debug TriggerBase:Finalize '..tostring(self:GetTriggerOwnerEntityName())..'\n'..tostring(self:GetTriggerType()));
	end
	self:MsgUnRegist()
	self:unregistFunc();
	self.roleEntityName = nil;
	self.config = nil;
	self.triggerCount = nil;
end
-- gd_hurdle_10001_trigger = {{p_type = '3',obj_name = 'Cube' , px = 0, py = 0, pz = 3.12,rx = 0, ry = 0, rz = 0,sx = 1, sy = 1, sz = 1,
-- p_code = {r = 3, funcname = 'TriggerFuncTest',trigger_camp = 3,rc = 1,tc = 1} },}
-- p_code = {r = 3, funcname = 'TriggerFuncTest'} },
function TriggerBase:SetConfig(c, trigger_id)
	self.config.trigger_id = trigger_id;
	self.config.trigger_des = c.panning_remark;
	self.config.trigger_camp = c.trigger_camp;
	self.config.trigger_role = c.trigger_role;
	self.config.trigger_type = c.trigger_type;
	self.config.trigger_count = c.trigger_count;
	self.config.trigger_param = c.trigger_param;
	self.config.trigger_effect = c.trigger_effect;

	-- if TRIGGER_DEBUG then
	-- 	app.log('huhu_map_debug '..tostring(FightScene.GetCurHurdleID())..' 设置一个触发器.'..table.tostring(c))
	-- end
end

-- 返回触发器的类型
function TriggerBase:GetTriggerType()
    if self.config then
	    return self.config.trigger_type
    end
    return nil
end

function TriggerBase:GetTriggerOwnerEntity()
	if not self.roleEntityName then
		return
	end

	return ObjectManager.GetObjectByName(self.roleEntityName)
end

function TriggerBase:GetTriggerOwnerEntityName()
	return self.roleEntityName;
end

-- 检查有没有玩家英雄进入范围触发了这个触发器
function TriggerBase:IsTrigger()
	return false;
end

-- 触发 返回值决定删除不删除。
function TriggerBase:Trigger(isRemove)
	if TRIGGER_DEBUG then
		app.log('huhu_trigger_debug TriggerBase:Trigger '..tostring(self:GetTriggerOwnerEntityName())..'\n'..tostring(self:GetTriggerType())..'\n'..table.tostring(self.config));
	end
	self.triggerCount = self.triggerCount + 1

	-- 触发剧情
	ScreenPlay.TriggerPlay(self.config.trigger_id);

    --后面手动删除
    if isRemove == false then
        return
    end
    self:RemoveTrigger()	
end

function TriggerBase:RemoveTrigger()
    if TRIGGER_DEBUG then
		app.log('huhu_trigger_debug 触发器计数 '..tostring(self.config.trigger_count)..'\n'..tostring(self.triggerCount));
	end
	if not self.config.trigger_count or self.config.trigger_count < 1 or self.triggerCount < self.config.trigger_count then
	else		
		local owner = self:GetTriggerOwnerEntity();
		-- TODO 删除自己
		if not owner then
			app.log('触发完成后要删除触发器时，触发器找不到自己的拥有者！'..tostring(self:GetTriggerType()))
		end

		if owner == nil then
			app.log('TriggerBase:Trigger ' .. debug.traceback())
		end

		local triggermanager = owner:GetTriggerManager();
		if not triggermanager then
			app.log('触发完成后要删除触发器时，触发器找不到自己的manager！'..tostring(self:GetTriggerType()))
		end
		triggermanager:RemoveTrigger(self);
	end
end

--[[碰撞的统一处理]]
function TriggerBase:TriggerCollision(trType, other, cur)
	-- 如果已经超过次数直接跳过（当同一帧有两个物体碰撞时可能触发两次）
	if not self.config.trigger_count or self.config.trigger_count < 1 or self.triggerCount < self.config.trigger_count then
	else
		return false;
	end
    local other_name = other:get_name()
    if self.last_trigger_info[other_name] and self.last_trigger_info[other_name] == Root.GetFrameCount() then
        return false
    end
    for k,v in pairs(self.last_trigger_info) do
        if v ~= Root.GetFrameCount() then
            self.last_trigger_info[k] = nil
        end
    end
	local otherEntity = ObjectManager.GetObjectByName(other_name);
	local selfEntity = ObjectManager.GetObjectByName(self.roleEntityName)
	if otherEntity == nil or otherEntity:IsItem()  or otherEntity:IsDead() then
		return false;
	end
	--满足阵营
	if self.config.trigger_camp == OBJECT_TYPE_FLAG.ALL or otherEntity:GetCampFlag() == self.config.trigger_camp then
		--满足类型
		if self.config.trigger_type == trType then
			--指定角色判断
			local allTriggerRole = self.config.trigger_role;
			local canTrigger = true;
			local flg = true;
			if allTriggerRole ~= 0 then
				for k,triggerRole in pairs(allTriggerRole) do
					--没有配置 或者是所有类型都直接触发 不做判断
					flg = true;
					if triggerRole ~= 0 and triggerRole.objType and triggerRole.objType ~= OBJECT_TYPE.ALL then
						--类型不一致 直接退出
						if not otherEntity:IsObjType(triggerRole.objType) then
							flg = false;
						end
						--配置了当前角色的话  不是当前角色直接退出
						if triggerRole.isCaptain and triggerRole.isCaptain == 1 then
							if otherEntity:GetName() ~= FightScene.GetFightManager():GetMyCaptainName() then
								flg = false;
							end
						end
						--配置了id的话 当前id不在范围内直接退出
						if triggerRole.id then
							local isJump = true;
							if otherEntity.card.number == 5 then
							end
							if type(triggerRole.id) == 'table' then
								for k, v in pairs(triggerRole.id) do
									if v == otherEntity.card.number then
										isJump = false;
										break;
									end
								end	
							else
								if triggerRole.id == otherEntity.card.number then
									isJump = false;
								end
							end
							if isJump then
								flg = false;
							end
						end	
					end
					if triggerRole ~= 0 and triggerRole.cfgType and triggerRole.cfgType ~= ENUM.EMonsterType.Empty then
						if bit.bit_and(triggerRole.cfgType, otherEntity:GetType()) == 0 then
							flg = false;
						end
						--配置了当前角色的话  不是当前角色直接退出
						if triggerRole.isCaptain and triggerRole.isCaptain == 1 then
							if otherEntity:GetName() ~= FightScene.GetFightManager():GetMyCaptainName() then
								flg = false;
							end
						end
						--配置了id的话 当前id不在范围内直接退出
						if triggerRole.id then
							local isJump = true;
							if otherEntity.card.number == 5 then
							end
							if type(triggerRole.id) == 'table' then
								for k, v in pairs(triggerRole.id) do
									if v == otherEntity.card.number then
										isJump = false;
										break;
									end
								end	
							else
								if triggerRole.id == otherEntity.card.number then
									isJump = false;
								end
							end
							if isJump then
								flg = false;
							end
						end	
					end
					if flg then
						break;
					end
				end
			end

			if not flg then
				canTrigger = false;
			end

			if not canTrigger then
				return false;
			end
			--效果触发
			if type(self.config.trigger_effect) == "table" then
				for e,param in pairs(self.config.trigger_effect) do
					TriggerEffect.HandleEffect(self.config.trigger_id, e, otherEntity, selfEntity, param);
				end
			end
			--包括空的触发效果，都通知一下
			if self.config.trigger_id then
				NoticeManager.Notice(ENUM.NoticeType.TriggerEffect, self.config.trigger_id)
			end
            self.last_trigger_info[other_name] = Root.GetFrameCount()
			return true;
		-- else
			-- app.log("trigger failed 01 cur:"..cur:get_name())
		end
	-- else
		-- app.log("trigger failed 02 cur:"..cur:get_name())
	end
end

function TriggerBase:TriggerEffect(other_name)

	if self.triggerCount >= self.config.trigger_count then return end

	local otherEntity = ObjectManager.GetObjectByName(other_name);
	local selfEntity = ObjectManager.GetObjectByName(self.roleEntityName)

	if type(self.config.trigger_effect) == "table" then
		for e,param in pairs(self.config.trigger_effect) do
			TriggerEffect.HandleEffect(self.config.trigger_id, e, otherEntity, selfEntity, param);
		end
	end
	--包括空的触发效果，都通知一下
	if self.config.trigger_id then
		NoticeManager.Notice(ENUM.NoticeType.TriggerEffect, self.config.trigger_id)
	end

	self:TriggerFinished()
end

function TriggerBase:TriggerFinished()
	self:Trigger()
end

function TriggerBase:HasTriggerEffect(effectName)
	local effects = self.config.trigger_effect
	if type(effects) == "table" and effects[effectName] then
		return true, effects
	end
	return false
end