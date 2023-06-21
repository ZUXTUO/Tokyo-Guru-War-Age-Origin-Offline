algorthm = { }

----------------------------单纯数学运算----------------------------------------------

--判断tar点是否在src点的一个圆形范围内
function algorthm.AtRound(src_x, src_z, r, tar_x, tar_z)
	local dx = tar_x - src_x;
	local dz = tar_z - src_z;
	local squaredR = r * r;
	if dx * dx + dz * dz <= squaredR then
		return true;
	else
		return false;
	end
end
--判断tar点是否在src点的一个扇形范围内
function algorthm.AtSector(src_x, src_z, r, direct, angle, tar_x, tar_z)
	local dx = tar_x - src_x;
	local dz = tar_z - src_z;
	local squaredDis = dx * dx + dz * dz
	local squaredR = r * r;
	local cosAngle = math.cos(math.rad(angle * 0.5));
	if squaredDis <= squaredR then
		local dis = math.sqrt(squaredDis);
		if dx * direct.x + dz * direct.z >= dis * cosAngle then
			return true;
		end
	end
	return false;
end
--判断tar点是否在src点的一个矩形范围内
function algorthm.AtRectangle(src_x, src_z, direct, long, width, tar_x, tar_z)
	local dx = tar_x - src_x;
	local dz = tar_z - src_z;
	local projectionDis = dx * direct.x + dz * direct.z;

	--在同一方向且在范围内
	if projectionDis >= 0 and projectionDis <= long then
        local radAngle = math.rad(90)
		local newDirectX = direct.x * math.cos(radAngle) + direct.z * math.sin(radAngle);
		local newDirectZ = -direct.x * math.sin(radAngle) + direct.z * math.cos(radAngle);

		local newProjectionDis = dx * newDirectX + dz * newDirectZ;
		if math.abs(newProjectionDis) <= width * 0.5 then
			return true;
		end
	end
	return false;
end
--返回两个点的距离的平方
function algorthm.GetDistanceSquared(x1, z1, x2, z2)
	if nil == x1 or nil == z1 or nil == x2 or nil == z2 then
		app.log('GetDistanceSquared x1='..tostring(x1)..' z1='..tostring(z1)..' x2='..tostring(x2)..' z2='..tostring(z2)..' '..debug.traceback())
	end
	local dx = x2 - x1;
	local dz = z2 - z1;
	local squaredDis = dx * dx + dz * dz;
	return squaredDis
end
--返回两个点之间距离的平方
function algorthm.GetDistanceSquaredPt(pos1, pos2)
	return algorthm.GetDistanceSquared(pos1.x, pos1.z, pos2.x, pos2.z);
end
--返回两个点的距离
function algorthm.GetDistance(x1, z1, x2, z2)
    if nil == x1 or nil == z1 or nil == x2 or nil == z2 then
        app.log('algorthm.GetDistance' .. debug.traceback())
    end

    local dx = x2 - x1;
    local dz = z2 - z1;
    local squaredDis = dx * dx + dz * dz;
    return math.sqrt(squaredDis);
end

--返回两个点的夹角   以点1为中心点  x向左 z向下
function algorthm.GetAngle(x1, z1, x2, z2)
    -- if nil == x1 or nil == z1 or nil == x2 or nil == z2 then
    --     print('algorthm.GetAngle' .. debug.traceback())
    -- end
    -- local diffX = x2 - x1;
    -- local diffZ = z2 - z1;
    -- local r = math.abs(math.atan2(diffX, diffZ)*180/math.pi)
    -- if diffX >= 0 and diffZ >= 0 then
    --     return 180 - r;
    -- elseif diffX <= 0 and diffZ >= 0 then
    --     return -(180 - r);
    -- elseif diffX <= 0 and diffZ <= 0 then
    --     return -r;
    -- else
    --     return r;
    -- end
    if nil == x1 or nil == z1 or nil == x2 or nil == z2 then
        print('algorthm.GetAngle' .. debug.traceback())
    end
    local diffX = x2 - x1;
    local diffZ = z2 - z1;
    local r = math.abs(math.atan2(math.abs(diffX), math.abs(diffZ))*180/math.pi)
    if diffX >= 0 and diffZ >= 0 then
        return -r;
    elseif diffX <= 0 and diffZ >= 0 then
        return r;
    elseif diffX <= 0 and diffZ <= 0 then
        return 180-r;
    else
        return -(180 - r);
    end
end
--返回两个点连线中的相对于1点的固定距离的点
function algorthm.GetPointLine(x1, z1, diff, x2, z2)
    local xDiff = x2 - x1;
    local zDiff = z2 - z1;
    local l = math.sqrt(xDiff * xDiff + zDiff * zDiff);
    if x2 < x1 then
        l = -l;
        diff = -diff;
    end
    local bi = diff / l;
    local x = bi * xDiff + x1;
    local z = bi * zDiff + z1;
    return x, z;
end
--获取圆上指定角度的某一点坐标  
function algorthm.GetRoundPoint(x0, y0, r, ang)
    local x1 = x0 + r * math.cos(ang * math.pi / 180);
    local y1 = y0 + r * math.sin(ang * math.pi / 180);
    return x1, y1;
end


----------------------------------返回角色列表----------------------------------------------


--[[ 返回一个点中的所有对像，是否满足 距离 角度 ]]
function algorthm.GetOverlapSphere(pos, radius, dir, angle, layer, targetRadius)
    -- app.log("algorthm.GetOverlapSphere" .. debug.traceback())
    if pos == nil then
        app.log("OverlapSphere pos为nil stack=" .. debug.traceback())
        return nil
    end
    local new_radius = radius + PublicStruct.Const.SEARCH_OBJ_RADIUS_OFFSET
    local obj_list = util.overlap_sphere(pos.x, pos.y, pos.z, new_radius, layer);
    if not obj_list then return obj_list end
    local return_table = { };
    for k, v in pairs(obj_list) do
        local entity = ObjectManager.GetObjectByIid(v)
        if entity then
            
            -- local obj = entity:GetObject()
            local obj_local_pos = entity:GetPosition(true)
            -- local obj_x, obj_y, obj_z = obj:get_local_position();
            if dir==nil or angle == 360 or algorthm.AtSector(pos.x, pos.z, new_radius, dir, angle, obj_local_pos.x, obj_local_pos.z) then
                local disSQ = algorthm.GetDistanceSquared(pos.x, pos.z, obj_local_pos.x, obj_local_pos.z)

                local entityRadius
                if targetRadius then
                    entityRadius = targetRadius
                else
                    entityRadius = entity:GetRadius()
                end

                local checkDistance = radius + entityRadius
                if disSQ <= checkDistance * checkDistance then
                    table.insert(return_table, entity);
                end
            end
        else
            app.log_warning("algorthm.GetOverlapSphere" .. "找不到对象" .. tostring(v))
        end

        -- end
    end
    -- app.log("algorthm.GetOverlapSphere return:" .. table.tostring(type(return_table)))
    return return_table;
end
CT1 = 0;
CT2 = 0;
COUNT = 0;
--[[ 返回一个圆形中的所有对像 ]]
function algorthm.GetOverlapSphereRound(pos, radius, layer, targetRadius)
--[[	COUNT = COUNT + 1;
	t = app.get_real_time();
	if t - CT1 >= 0.03333 then 
		app.log("COUNT = "..COUNT);
		COUNT = 0;
		CT1 = t;
		if t - CT2 > 1 then 
			app.log("XXXXXXXX");
			CT2 = t;
		end
	end --]]
    local new_radius = radius + PublicStruct.Const.SEARCH_OBJ_RADIUS_OFFSET
    local obj_list = util.overlap_sphere(pos.x, pos.y, pos.z, new_radius, layer);
    if not obj_list then return obj_list end

    local return_table = { };

    for k, v in pairs(obj_list) do
        local entity = ObjectManager.GetObjectByIid(v)
        if entity then
            --            local obj = entity:GetObject()
            --            local obj_x, obj_y, obj_z = obj:get_local_position();
            local obj_local_pos = entity:GetPosition(true)
            if algorthm.AtRound(pos.x, pos.z, new_radius, obj_local_pos.x, obj_local_pos.z) then
                local entityRadius
                if targetRadius then
                    entityRadius = targetRadius
                else
                    entityRadius = entity:GetRadius()
                end
                local disSQ = algorthm.GetDistanceSquared(pos.x, pos.z, obj_local_pos.x, obj_local_pos.z)
                local checkDistance = radius + entityRadius
                if disSQ <= checkDistance * checkDistance then
                    table.insert(return_table, entity);
                end
            end
        end

        -- end
    end
    return return_table;
end

--[[ 返回一个矩形内的所有对象 ]]
function algorthm.GetOverlapRectangle(pos, direct, long, width, layer)
    local halfWidth = width * 0.5;
    local new_radius = long + PublicStruct.Const.SEARCH_OBJ_RADIUS_OFFSET
    local radius = math.sqrt(new_radius * new_radius + halfWidth * halfWidth);
    local real_radius = math.sqrt(long * long + halfWidth * halfWidth);
    local obj_list = util.overlap_sphere(pos.x, pos.y, pos.z, radius, layer);
    if not obj_list then return obj_list end
    local return_table = { };
    for k, v in pairs(obj_list) do
        local entity = ObjectManager.GetObjectByIid(v)
        if entity then
            --            local obj = entity:GetObject()
            --            local obj_x, obj_y, obj_z = obj:get_position();
            local obj_pos = entity:GetPosition(false)
            -- app.log("name="..v:get_name().." pos.x="..pos.x.." pos.z="..pos.z.." direct.x=".. direct.x.." direct.z="..direct.z.." long="..long.." width="..width.." obj_x="..obj_x.." obj_z="..obj_z)
            if algorthm.AtRectangle(pos.x, pos.z, direct, new_radius, width, obj_pos.x, obj_pos.z) then
                local dis = algorthm.GetDistance(pos.x, pos.z, obj_pos.x, obj_pos.z)
                dis = dis - entity:GetRadius()
                if dis <= real_radius then
                    table.insert(return_table, entity);
                end
            end
        end
        -- end
    end
    -- app.log("***********")
    -- for i=1, #return_table do
    --    app.log("name="..return_table[i]:get_name())
    -- end
    -- app.log("***********")
    return return_table;
end

function algorthm.NumberLerp(n1, n2, t)
    return n1 +(n2 - n1) * t
end

function algorthm.PointLerp(x1, y1, z1, x2, y2, z2, t)
    return x1 + (x2 - x1) * t, y1 + (y2 - y1) * t, z1 + (z2 - z1) * t
end

function algorthm.Normalized(x,y,z)
    local d = x*x + y*y + z*z
    local isSuc = false
    if d > 0.0000000001 then
        d = 1/math.sqrt(d)

        x = x * d
        y = y * d
        z = z * d
        isSuc = true
    end

    return x,y,z, isSuc
end

--二阶
function algorthm.QuadBezier(t, n0, n1, n2)
    t2 = t * t
    u = 1 - t
    u2 = u * u

    local p1 = n0 * u2
    local p2 = n1 * 2 * t * u
    local p3 = n2 * t2

    return p1 + p2 + p3
end