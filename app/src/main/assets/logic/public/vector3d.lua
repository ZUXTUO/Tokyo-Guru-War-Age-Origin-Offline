


Vector3d = Class("Vector3d")

function Vector3d:Vector3d(param)

    if type(param) ~= 'table' then
        app.log("Vector3d new error: " .. debug.traceback())
    end

    self._x = param.x
    self._y = param.y
    self._z = param.z
end

function Vector3d:Clone()
    return Vector3d:new({x = self._x, y = self._y, z = self._z})
end

function Vector3d:GetX()
    return self._x
end

function Vector3d:GetY()
    return self._y
end

function Vector3d:GetZ()
    return self._z
end

function Vector3d:SetX(x)
    self._x = x
    return self
end

function Vector3d:SetY(y)
    self._y = y
    return self
end

function Vector3d:SetZ(z)
    self._z = z
    return self
end

function Vector3d:RAdd(b)
    if b == nil then
        app.log('RAdd error b == nil ' .. debug.traceback())
    end

    self._x = self._x + b._x
    self._y = self._y + b._y
    self._z = self._z + b._z
    return self
end

function Vector3d:CAdd(b)
    return self:Clone():RAdd(b)
end

function Vector3d:RSub(b)
    --if b._className ~= 'Vector3d' then
        --return 
    --end
    if self._x == nil then
        app.log('self._x==nil' .. debug.traceback())
    end
    if b._x == nil then
        app.log('b._x==nil' .. debug.traceback())
    end
    --app.log("V3dSub :" .. self._x .. " " .. self._y .. " " .. self._z)
    self._x = self._x - b._x
    self._y = self._y - b._y
    self._z = self._z - b._z
    return self
end

function Vector3d:CSub(b)
    return self:Clone():RSub(b)
end

function Vector3d:RScale(s)
    if s == nil then
        app.log('Scale error s == nil ' .. debug.traceback())
    end
    self._x = self._x * s
    self._y = self._y * s
    self._z = self._z * s
    return self
end

function Vector3d:CScale(b)
    return self:Clone():RScale(b)
end

function Vector3d:GetLengthSQ()
    return self._x*self._x + self._y*self._y + self._z*self._z
end

function Vector3d:GetLength()
    return math.sqrt(self._x*self._x + self._y*self._y + self._z*self._z)
end

function Vector3d:RNormalize()
    --app.log("V3dSub :" .. self._x .. " " .. self._y .. " " .. self._z)
    local d = self._x*self._x + self._y*self._y + self._z*self._z
    if d < 0.0000000001 then
        return nil
    end
    d = 1/math.sqrt(d)
    self._x = self._x * d
    self._y = self._y * d
    self._z = self._z * d
    return self
end

function Vector3d:CNormalize()
    return self:Clone():RNormalize()
end

function Vector3d:RCross(b)

    if b == nil then
        app.log('Cross error b == nil ' .. debug.traceback())
    end

    local x = self._y * b._z - self._z * b._y
    local y = self._z * b._x - self._x * b._z
    local z = self._x * b._y - self._y * b._x

    self._x = x
    self._y = y
    self._z = z
    return self
end

function Vector3d:CCross(b)
    return self:Clone():RCross(b)
end

function Vector3d:Dot(b)
    if b == nil then
        app.log('Dot error b == nil ' .. debug.traceback())
    end
    return self._x * b._x + self._y * b._y + self._z * b._z
end

function Vector3d:Assignment(b)
    if b == nil then
        app.log('Assignment error b == nil ' .. debug.traceback())
    end
    self._x = b._x
    self._y = b._y
    self._z = b._z
end

function Vector3d:Print(tag)
    tag = tag or 'v3d:Print'
    app.log(tag .. ' x: ' .. tostring(self._x) .. ' y: ' .. tostring(self._y) .. ' z: ' .. tostring(self._z))
end


function V3dLerp(v1, v2, t)

    if type(v1) ~= 'table' or type(v2) ~= 'table' or v1._x == nil or v2._x == nil then
        app.log('V3dLerp ERROR ' .. debug.traceback())
    end

    if t < 0 then
        t = 0
    end

    if t > 1 then
        t = 1
    end

    local x = v1._x + (v2._x - v1._x) * t
    local y = v1._y + (v2._y - v1._y) * t
    local z = v1._z + (v2._z - v1._z) * t

    return Vector3d:new({x = x, y = y, z = z})
end