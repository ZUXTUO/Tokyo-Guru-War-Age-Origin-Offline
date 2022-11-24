LevelMapConfigHelper = Class("LevelMapConfigHelper")


--
--@return
--{name = {pos}, name = {pos}}

local function _getLevelID()
	return FightScene.GetLevelID()
end

local function _getMapInfoID()
	if FightScene.GetFightManager()  then
		return FightScene.GetFightManager():GetFightMapInfoID()
	else
		app.log("#lhf#FightManager is nil."..debug.traceback());
		return 0;
	end
end

function LevelMapConfigHelper.GetHeroBornPosList(camp_flag, out_pos_list, make_default_when_empty)

	local cfg = ConfigHelper.GetMapInf(_getMapInfoID(), EMapInfType.burchhero)
	if nil == cfg then
		--app.log("can't find config file:"..cfgFile)
		return false 
	end

	local bornPos = {};
	for k, v in pairs(cfg) do
		 if v.flag == camp_flag then
		 	local index = PublicFunc.string_rfind(v.obj_name,"_");
			local num = string.sub(v.obj_name,index+1,-1);
            num = tonumber(num);
            --app.log("num=="..num);
            if num then
            	out_pos_list[num] = v;
            end
		 	--table.insert(out_pos_list, v)
		 end
	end

	if make_default_when_empty and #out_pos_list == 0 then
		out_pos_list[1] = {px=0, py=0, pz=0, rx=0, ry = 0, rz = 0, sx=1, sy=1, sz=1}
	end
	
	return true
end

function LevelMapConfigHelper.GetWayPoint(way_head,xyzMode)
	local config = ConfigHelper.GetMapInf(tostring(_getMapInfoID()),EMapInfType.pathpoint)
	local path = {};

    local pathName = nil
    if config ~= nil then
	    for i=1,#config do
		    if string.find(config[i].obj_name,way_head.."_", 1, true) then
			    local index = PublicFunc.string_rfind(config[i].obj_name,"_");
                if pathName == nil then
                    pathName = string.sub(config[i].obj_name, 1, index-1)
                end
			    local num = string.sub(config[i].obj_name,index+1,-1);
                num = tonumber(num);
                --app.log("num=="..num);
                --path[num] = config[i];
                local pos = config[i]
                if xyzMode == true then 
                    pos = {x = pos.px, y = pos.py, z = pos.pz}
                end

			    -- table.insert(path,pos);
			    path[num] = pos;

		    end
	    end
    end
	return path, pathName
end

function LevelMapConfigHelper._GetMonsterBornPoint(name)
	local config = ConfigHelper.GetMapInf(tostring(_getMapInfoID()),EMapInfType.burchmonster)
	local point;
	for k,v in pairs(config) do
		if v.obj_name == name then
			point = v;
			break;
		end
	end
	return point;
end

function LevelMapConfigHelper.GetAllMonsterBornPoints(name)
	local config = ConfigHelper.GetMapInf(tostring(_getMapInfoID()),EMapInfType.burchmonster)
	local points = {};
	for k,v in pairs(config) do
		if v.obj_name == name then
			table.insert(points, v)
		end
	end
	return points;
end

function LevelMapConfigHelper.GetHeroBornPoint(name)
	local config = ConfigHelper.GetMapInf(tostring(_getMapInfoID()),EMapInfType.burchhero)
    if config == nil then
        return nil
    end
	local point;
	for k,v in pairs(config) do
		if v.obj_name == name then
			point = v;
			break;
		end
	end
	return point;
end

function LevelMapConfigHelper.GetHeroPosePoint(name)
	local config = ConfigHelper.GetMapInf(tostring(_getMapInfoID()),EMapInfType.burchhero)
    if config == nil then
        return nil
    end
	for k,v in pairs(config) do
		if v.obj_name == name then
			return v;
		end
	end
	return nil;
end

function LevelMapConfigHelper.GetConfigByObjName(name)

	local ret = nil

	local config = nil
	for k, type in pairs(EMapInfType) do
		config = ConfigHelper.GetMapInf(tostring(_getMapInfoID()), type)
		if config then
			for k,v in pairs(config) do
				if v.obj_name == name then
					ret = v
				end
			end
		end
		if ret then
			break;
		end
	end

	return ret;
end
