PursuitFightManager = Class("PursuitFightManager", FightManager)


function PursuitFightManager:InitData()
	FightManager.InitData(self)
end

function PursuitFightManager.InitInstance()
	FightManager.InitInstance(PursuitFightManager)
	return PursuitFightManager
end

function PursuitFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function PursuitFightManager:OnStart()
	FightManager.OnStart(self)
	self:_Start()
end

function PursuitFightManager:_Start()
	self.bossArrive = false;
end

function PursuitFightManager:OnLoadMonster(obj)
	if obj:IsBoss() then
		obj:SetAI(105);
		local hurdle_id = FightScene.GetCurHurdleID()
		local maoInfoID = FightScene.GetFightManager():GetFightMapInfoID()
		--local way_point = ConfigHelper.GetMapInf(maoInfoID,EMapInfType.pathpoint)
		local way_point = LevelMapConfigHelper.GetWayPoint("swp_1");
		local length = #way_point;
		local path = {};
		for i=1,length do
			path[i] = {};
			local pos = {};
			pos.x,pos.y,pos.z = way_point[i].px,way_point[i].py,way_point[i].pz;
			local rot = {};
			rot.x,rot.y,rot.z = way_point[i].rx,way_point[i].ry,way_point[i].rz;
			local scale = {};
			scale.x,scale.y,scale.z = way_point[i].sx,way_point[i].sy,way_point[i].sz;
			path[i].x,path[i].y,path[i].z = self:_GetRandomPos(pos,rot,scale);
		end
		local item = ConfigHelper.GetMapInf(maoInfoID,EMapInfType.item)
		local destination;
		for k,v in pairs(item) do
			if v.obj_name == "destination" then
				destination = v;
				break;
			end
		end
		if destination then
			path[length+1] = {};
			path[length+1].x,path[length+1].y,path[length+1].z = destination.px,destination.py,destination.pz;
		end
		
		obj:SetPatrolMovePath(path);
	end
end

function PursuitFightManager:on_target_arrive_desination(target_entity, cur_entity, param)
	if target_entity:IsBoss() then
		--app.log("boss到了，变ai");
		target_entity:SetAI(100);
		self:OnBossArriveDestination();
		self:CheckPassCondition();
	end
end

function PursuitFightManager:OnBossArriveDestination()

	self.bossArrive = true;
end

function PursuitFightManager:IsBossArriveDestination()
	--app.log("检查是否到达");
	return self.bossArrive == true;
end

--获取一个位置周围的随机一个位置
function PursuitFightManager:_GetRandomPos(pos,rot,scale)
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

