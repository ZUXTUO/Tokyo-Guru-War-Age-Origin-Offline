RunawayFightManager = Class("RunawayFightManager", FightManager)


function RunawayFightManager:InitData()
	FightManager.InitData(self)
end

function RunawayFightManager.InitInstance()
	FightManager.InitInstance(RunawayFightManager)
	return RunawayFightManager
end

function RunawayFightManager:OnStart()
	FightManager.OnStart(self)
	self:_Start()
end

function RunawayFightManager:_Start()
	self.isArriveDestination = false;
end


function RunawayFightManager:OnLoadMonster(obj)
	obj:SetAI(100);
	if obj:IsBoss() then
		obj:AttachBuff(1207,1);
	end
end

function RunawayFightManager:on_target_arrive_desination(target_entity, cur_entity, param)
	--app.log("到了");
	local target_name = target_entity:GetName();
	local captain_name = g_dataCenter.fight_info:GetCaptainName();
	if target_name == captain_name then
		self:OnArriveDestination();
		self:CheckPassCondition();
	end
end


