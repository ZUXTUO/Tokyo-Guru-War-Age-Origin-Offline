MonsterLoaderBase = Class("MonsterLoaderBase");

function MonsterLoaderBase:OnStart()
end

function MonsterLoaderBase:IsFinish()
	return true;
end

function MonsterLoaderBase:Destroy()
end

function MonsterLoaderBase:Pause()
end

function MonsterLoaderBase:Resume()
end

function MonsterLoaderBase:OnEvent_DeadMonster()
end

function MonsterLoaderBase:SetCallback(callback_table)
end

function MonsterLoaderBase:_GetMonsterWayPoint(way_head)
	local point_list = LevelMapConfigHelper.GetWayPoint(way_head);
	for k,v in pairs(point_list) do
		point_list[k] = MonsterLoader._GetRandomPos(v);
	end
	return point_list;
end

function MonsterLoaderBase:_GetMonsterBornPoint(name)
	local point = LevelMapConfigHelper._GetMonsterBornPoint(name);
	return MonsterLoader._GetRandomPos(point),point;
end