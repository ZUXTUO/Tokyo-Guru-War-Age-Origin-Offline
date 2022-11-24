
ColliderEnterTrigger = Class('ColliderEnterTrigger', TriggerBase);

ColliderStayTrigger = Class('ColliderStayTrigger', TriggerBase);

ColliderExitTrigger = Class('ColliderExitTrigger', TriggerBase);

ColliderEnterTimerTrigger = Class('ColliderEnterTimerTrigger', TriggerBase);

ColliderEnterAreaRandomItemTrigger = Class('ColliderEnterAreaRandomItemTrigger', TriggerBase)


-- 基类调用。
function ColliderEnterTrigger:registFunc()
    self.bindfunc = {};
    self.bindfunc["trigger"] = Utility.bind_callback(self,ColliderEnterTrigger.Trigger);
end

--[[初始化]]
function ColliderEnterTrigger:Init(c)
	-- 基类
	TriggerBase.Init(self,c);

	local gameobj = c.roleEntity;
	if gameobj == nil then
	--app.log_warning('huhu_trigger_debug ColliderEnterTrigger init 4 '..table.tostring(self))
		return;
	end
	gameobj = gameobj:GetObject();
	if gameobj == nil then
		--app.log_warning('huhu_trigger_debug ColliderEnterTrigger init 5'..table.tostring(c))
		return;
	end

	gameobj:set_on_trigger_enter(self.bindfunc["trigger"]);
	if type(self.config.trigger_param) == 'table' and self.config.trigger_param.distance > 0 then
		gameobj:set_capsule_collider_radius(self.config.trigger_param.distance);
	end


	-- app.log("create collide trigger......")
end

function ColliderEnterTrigger:Trigger(other, cur)
	if self:TriggerCollision(ENUM.E_TRIGGER_TYPE.TriggerEnter, other, cur) then
		 -- app.log(other:get_name().."222碰到:"..cur:get_name())
		-- 调用基类的，计数相关
		TriggerBase.Trigger(self)
	end
end

--------------------------------------------------------------------------------------------------------

-- 基类管理。
function ColliderStayTrigger:registFunc()
    self.bindfunc = {};
    self.bindfunc["trigger"] = Utility.bind_callback(self,ColliderStayTrigger.Trigger);
end

--[[初始化]]
function ColliderStayTrigger:Init(c)
	-- 基类
	TriggerBase.Init(self,c);

	local gameobj = c.roleEntity;
	if gameobj == nil then
		return;
	end
	gameobj = gameobj:GetObject();
	if gameobj == nil then
		return;
	end

	gameobj:set_on_trigger_stay(self.bindfunc["trigger"]);
	if type(self.config.trigger_param) == 'table' and self.config.trigger_param.distance > 0 then
		gameobj:set_capsule_collider_radius(self.config.trigger_param.distance);
	end
end

function ColliderStayTrigger:Trigger(other, cur)
	if self:TriggerCollision(ENUM.E_TRIGGER_TYPE.TriggerStay, other, cur) then
		-- 调用基类的，计数相关
		TriggerBase.Trigger(self)
	end
end

--------------------------------------------------------------------------------------------------------
-- 基类管理
function ColliderExitTrigger:registFunc()
    self.bindfunc = {};
    self.bindfunc["trigger"] = Utility.bind_callback(self,ColliderExitTrigger.Trigger);
end

--[[初始化]]
function ColliderExitTrigger:Init(c)
	-- 基类
	TriggerBase.Init(self,c);

	local gameobj = c.roleEntity;
	if gameobj == nil then
		return;
	end
	gameobj = gameobj:GetObject();
	if gameobj == nil then
		return;
	end

	gameobj:set_on_trigger_exit(self.bindfunc["trigger"]);
	if type(self.config.trigger_param) == 'table' and self.config.trigger_param.distance > 0 then
		gameobj:set_capsule_collider_radius(self.config.trigger_param.distance);
	end
end

function ColliderExitTrigger:Trigger(other, cur)
	if self:TriggerCollision(ENUM.E_TRIGGER_TYPE.TriggerExit, other, cur) then
		-- 调用基类的，计数相关
		TriggerBase.Trigger(self)
	end
end

--------------------------------------------------------------------------------------------------------

function ColliderEnterTimerTrigger:registFunc()
    self.bindfunc = {};
    self.bindfunc["trigger"] = Utility.bind_callback(self, self.Trigger);
end

--[[初始化]]
function ColliderEnterTimerTrigger:Init(c)
	-- 基类
	TriggerBase.Init(self,c);

	local gameobj = c.roleEntity;
	if gameobj == nil then
	--app.log_warning('huhu_trigger_debug ColliderEnterTimerTrigger init 4 '..table.tostring(self))
		return;
	end
	gameobj = gameobj:GetObject();
	if gameobj == nil then
		--app.log_warning('huhu_trigger_debug ColliderEnterTimerTrigger init 5'..table.tostring(c))
		return;
	end

	gameobj:set_on_trigger_enter(self.bindfunc["trigger"]);
	if type(self.config.trigger_param) == 'table' and self.config.trigger_param.distance > 0 then
		gameobj:set_capsule_collider_radius(self.config.trigger_param.distance);
	end
	-- app.log("create collide trigger......")

    self.isStartTimer = false
end

--屏蔽其它触发方式 
function ColliderEnterTimerTrigger:TriggerEffect(other_name)

end

function ColliderEnterTimerTrigger:Trigger(other, cur)
    if self.isStartTimer then
        return
    end 
	if self:TriggerCollision(ENUM.E_TRIGGER_TYPE.TriggerEnterTimer, other, cur) then
        self.isStartTimer = true
        --后面手动删除
        TriggerBase.Trigger(self, false)
	end
end

--------------------------------------------------------------------------------------------------------

function ColliderEnterAreaRandomItemTrigger:registFunc()
    self.bindfunc = {};
    self.bindfunc["trigger"] = Utility.bind_callback(self, self.Trigger);
end

--[[初始化]]
function ColliderEnterAreaRandomItemTrigger:Init(c)
    --随机item配置
    --{count = 3,radius = 3,height = 2,delay_time = {0,1,2,}}
    local para = c.config.trigger_param
    if type(para) ~= 'table' or para.count <= 0 then
        app.log('trigger param  配置错误! trigger id = ' .. c.trigger_id)
        return
    end
    if para.count > 1 then
        if type(para.delay_time) == 'table' and para.count == #para.delay_time then
        else
            app.log('triggerPara.delay_time 配置错误! trigger id = ' .. c.trigger_id)
            return
        end
    end
    local gameobj = c.roleEntity;
    if gameobj == nil or gameobj:GetModelID() == 80002002 then
        app.log('需要配置item_modelid ! trigger id = ' .. c.trigger_id)
        return
    end

    --先隐藏手雷(资源预加载)
    para.hideMesh = 1

	-- 基类
	TriggerBase.Init(self,c);	

	gameobj = gameobj:GetObject();
	if gameobj == nil then
		--app.log_warning('huhu_trigger_debug ColliderEnterAreaRandomItemTrigger init 5'..table.tostring(c))
		return;
	end

	gameobj:set_on_trigger_enter(self.bindfunc["trigger"]);
	--if type(self.config.trigger_param) == 'table' and self.config.trigger_param.distance > 0 then
	--	gameobj:set_capsule_collider_radius(self.config.trigger_param.distance);
	--end
	-- app.log("create collide trigger......")
    
    self.isStartTimer = false
end

--屏蔽其它触发方式 
function ColliderEnterAreaRandomItemTrigger:TriggerEffect(other_name)

end

function ColliderEnterAreaRandomItemTrigger:Trigger(other, cur)
    if self.isStartTimer then
        return
    end 
	if self:TriggerCollision(ENUM.E_TRIGGER_TYPE.TriggerEnterAreaRandomItem, other, cur) then
        self.isStartTimer = true
        --后面手动删除
        --TriggerBase.Trigger(self, false)
	end
end

function ColliderEnterAreaRandomItemTrigger:UpdateCount()
    --后面手动删除
    TriggerBase.Trigger(self, false)
end