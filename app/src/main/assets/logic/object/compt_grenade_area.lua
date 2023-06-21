
ComptGrenadeArea = Class("ComptGrenadeArea")

function ComptGrenadeArea:ComptGrenadeArea(entity)
    self.sc = entity
end

function ComptGrenadeArea:Finalize()
    if self.createGrenadeFunc then
        Utility.unbind_callback(self, self.createGrenadeFunc)
        self.createGrenadeFunc = nil
    end
    if TRIGGER_DEBUG then
        app.log('ComptGrenadeArea:Finalize() ')
    end
end

--[[区域手雷]]
function ComptGrenadeArea:Start(param)
    if self.sc.triggerObj == nil then
        app.log('triggerObj == nil' .. debug.traceback())
        return
    end

    --{model_id = 80002047,count = 3,radius = 3, delay_time = {0,1,2,}}
    self.triggerPara = self.sc.triggerObj.config.trigger_param   
    local _areaSize = self.sc:GetCapsuleColliderRadius() * 2

    --立方体数量
    self.cubeCnt = math.ceil(math.sqrt(self.triggerPara.count))
    local _allCubeSize = self.cubeCnt * (self.triggerPara.radius * 2)
    if _areaSize < _allCubeSize then
        app.log('当前区域太小, 请调整区域大小, 或者生成手雷数量! trigger id = ' .. tostring(self.sc.triggerObj.config.trigger_id))
        return
    end

    --先更新次数(正常逻辑要等效果触发完才会调用)
    --否则不能删除entity(只有一个手雷时，效果触发完就会删除)
    self.sc.triggerObj:UpdateCount()

    if TRIGGER_DEBUG then
        self.__randomCnt = 0
        app.log('trigger_debug Start param = ' .. tostring(param) .. '  ' .. self.sc:GetName())
    end
    self.param = param
    self.triggerTime = self.param.delayTime + self.param.aniTime
    self.grenadeCnt = 0
    
    self.totalCubeCnt = self.cubeCnt * self.cubeCnt
    --立方体实际大小
    self.cubeSize = _areaSize / self.cubeCnt

    --随机点最大半径
    self.maxLen = self.cubeSize / 2  - self.triggerPara.radius
    if TRIGGER_DEBUG then
        app.log('trigger_debug maxLen = ' .. tostring(self.maxLen))
    end
   
    --生成小的区域, 在小区域内随机位置
    self:GenerateSmallArea()
    self:CreateAllGrenade()
end

function ComptGrenadeArea:CreateAllGrenade()
    self.__index = 0
    if self.triggerPara.count == 1 then
         self:create_grenade()
    else
        for i = 1, self.triggerPara.count do
            local delay = self.triggerPara.delay_time[i]
            if delay > 0 then
                if self.createGrenadeFunc == nil then
                    self.createGrenadeFunc = Utility.bind_callback(self, self.create_grenade)
                end
                timer.create(self.createGrenadeFunc, delay * 1000, 1)
            else
                self:create_grenade()
            end
        end
    end
end

function ComptGrenadeArea:create_grenade()
    local pos =  self:GetGrenadePos()
    if pos == nil then
        return
    end
    --trigger_id 设为0(此处为特殊item, 手动触发)
    local item = FightScene.CreateItem(nil, self.sc:GetModelID(), 0, 0)
	item:SetPosition(pos:GetX(), pos:GetY(), pos:GetZ())
    ComptItem.AddGrenade(item)
    ComptItem.Start(item, self.param)

    --检查是否创建完
    self.grenadeCnt = self.grenadeCnt + 1
    if self.grenadeCnt == self.triggerPara.count then
        if self.sc.triggerObj then
            self.sc.triggerObj:RemoveTrigger()
        end
    end
end

function ComptGrenadeArea:GenerateSmallArea()
    --圆心位置
    local centerPos = self.sc:GetPositionV3d()
    --左上角初始点
    local initX = centerPos:GetX() - (self.cubeCnt / 2 - 0.5) * self.cubeSize
    local initZ = centerPos:GetZ() - (self.cubeCnt / 2 - 0.5) * self.cubeSize

    self.smallArea = {}
    for i = 1, self.cubeCnt do
         for j = 1, self.cubeCnt do
            local _x = initX + (i - 1) * self.cubeSize
            local _z = initZ + (j - 1) * self.cubeSize
            local _pos = Vector3d:new({x = _x, y = centerPos:GetY(), z = _z})
            table.insert(self.smallArea, {pos = _pos, time = nil})
         end
    end
end

function ComptGrenadeArea:GetGrenadePos()
    local _index = math.random(1, self.totalCubeCnt)
    local info = self.smallArea[_index]
    if info.time ~= nil then
        --地雷正在爆炸中, 查找下一个
        if system.time() - info.time <= self.triggerTime then
            local loopCnt = 0
            while true do
                loopCnt = loopCnt + 1
                _index = _index + 1
                if _index >  self.totalCubeCnt then
                    _index = 1
                end
                info = self.smallArea[_index]
                if info.time == nil or (system.time() - info.time > self.triggerTime) then
                    break
                end
                if loopCnt > self.totalCubeCnt then
                    app.log('未找到合适的地雷区域 ！！！')
                    break
                end
            end
        end
    end 
    --更新时间戳
    info.time = system.time()

    return self:__GenerateRandomPosition2(info.pos, self.maxLen)
    --return self:__GenerateRandomPosition(info.pos, self.maxLen, 360)
end

function ComptGrenadeArea:__GenerateRandomPosition2(initPos, len)
    local targetPos = initPos:Clone()
    local randomLen = math.random(-100, 100) / 100 * len
    targetPos:SetX(targetPos:GetX() + randomLen)

    randomLen = math.random(-100, 100) / 100 * len
    targetPos:SetZ(targetPos:GetZ() + randomLen)
    return targetPos
end

function ComptGrenadeArea:__GenerateRandomPosition(initPos, len, maxRandomAngle)
    local myPos = initPos:Clone()
    local randomineLen = math.random(0, 100) / 100 * len
    local angle = 0
    if maxRandomAngle > 0 then
        angle = math.random(0, maxRandomAngle)
    end
    if TRIGGER_DEBUG then
        self.__randomCnt = self.__randomCnt + 1
        app.log('trigger_debug __GenerateRandomPosition self.__randomCnt = ' .. tostring(self.__randomCnt) .. '  randomineLen = ' .. randomineLen .. ' angle = ' .. angle)
    end
    local angleDir = nil
    if math.random() <= 0.5 then
        angleDir = -1
    else
        angleDir = 1
    end
    local targetPos = nil
    local addAngle = 0;
    local dir = Vector3d:new({x = 1, y = 0, z = 0})

    while true do
        local offset = dir:CScale(randomineLen)  --dir为1， 不用归一化

        local qx,qy,qz,qw = util.quaternion_euler(0, angle + addAngle, 0)
        local nx,ny,nz = util.quaternion_multiply_v3(qx,qy,qz,qw, offset:GetX(), offset:GetY(), offset:GetZ())
        offset:SetX(nx)
        offset:SetY(ny)
        offset:SetZ(nz)

        local caltargetPos = myPos:CAdd(offset)
        local isSuc,sx,sy,sz = util.get_navmesh_sampleposition(caltargetPos:GetX(), 
                                    caltargetPos:GetY(), caltargetPos:GetZ(), 1)
        
        if isSuc then
            caltargetPos:SetX(sx)
            caltargetPos:SetY(sy)
            caltargetPos:SetZ(sz)
            targetPos = caltargetPos
            break;
        else
            addAngle = addAngle + 30;
            if addAngle >= 360 then
                break;
            end
        end
    end
    return targetPos
end