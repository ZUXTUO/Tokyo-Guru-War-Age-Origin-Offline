CameraTouchMoveManager = {}

local this = CameraTouchMoveManager
this.CameraWallLayerMask = PublicFunc.GetBitLShift({PublicStruct.UnityLayer.camera_wall})

function CameraTouchMoveManager.Destroy()
    Utility.unbind_callback(this, this.TouchBeginCallback)
    Utility.unbind_callback(this, this.TouchMoveCallback)
end

function CameraTouchMoveManager.LoadedCallBack()
    this.TouchBeginCallback = Utility.bind_callback(this, this.TouchBegin)
    this.TouchMoveCallback = Utility.bind_callback(this, this.TouchMove)
end

function CameraTouchMoveManager.TouchBegin(self, name, state, x, y, goObj)
    if state == true then
        this.last_touch_x = x
        this.last_touch_y = y

        this.lastTouchMoveDir = nil
    else
        this.last_touch_x = nil
        this.last_touch_y = nil

        this.touchMoveX = nil
        this.touchMoveY = nil
    end
end

function CameraTouchMoveManager.TouchMove(self, name, x, y, goObj)
    if this.last_touch_x == nil then
        return
    end    

    this.touchMoveX = x - this.last_touch_x;
    this.touchMoveY = y - this.last_touch_y;

    if this.touchMoveLockX == true then
        this.touchMoveX = 0
    end
    if this.touchMoveLockY == true then
        this.touchMoveY = 0
    end

    this.last_touch_x = x
    this.last_touch_y = y
end


function CameraTouchMoveManager.EnterTouchMoveMode(initPosV3d, mark, lockX, lockY, cameraObj, speed, manager)
    this.cameraObj = cameraObj
    this.speed = speed
    if initPosV3d then
        local lastPos = manager.lastCameraPosition or initPosV3d
        local camPos = initPosV3d:CAdd(manager.CameraOffsetRelativeTarget)
        local move = camPos:RSub(lastPos)
        local adjusMove = this.AdjustCurrentFrameMoveByCameraWall(lastPos, move)

        this.SetPositionV3d(lastPos:RAdd(adjusMove))
    end    
    if mark ~= nil then
        mark:set_on_ngui_press(CameraTouchMoveManager.TouchBeginCallback)
        mark:set_on_ngui_drag_move(CameraTouchMoveManager.TouchMoveCallback)
    end
    if lockX ~= nil then
        this.touchMoveLockX = lockX
    end
    if lockY ~= nil then
        this.touchMoveLockY = lockY
    end
end

function CameraTouchMoveManager.Update(dt)
    if this.cameraObj == nil or this.speed == nil then
        return
    end

    local moveDir = nil
    if this.touchMoveX ~= nil then
        moveDir = Vector3d:new({x = this.touchMoveX, y = 0, z = this.touchMoveY})
        this.lastTouchMoveDir = moveDir:RScale(0.15):Clone()
        moveDir:RScale(dt)

        this.touchMoveX = nil
    elseif this.last_touch_x == nil and this.lastTouchMoveDir ~= nil then
        local lastSpeed = this.lastTouchMoveDir
        local lenSQ = lastSpeed:GetLengthSQ()
        if lenSQ > 0.00001 then
            local decAcc = this.speed
            local len = math.sqrt(lenSQ)
            len = len - decAcc * dt
            if len < 0 or this.rayCaseHit then
                len = 0
            end
            this.lastTouchMoveDir = lastSpeed:RNormalize():RScale(len)
            moveDir = this.lastTouchMoveDir:CScale(dt)
        else
            this.lastTouchMoveDir = nil
        end
    end

    if moveDir ~= nil and moveDir:GetLengthSQ() > 0.00001 then
        local ex,ey,ez = this.cameraObj:get_local_rotation()
        if ex ~= nil then
            local qx,qy,qz,qw = util.quaternion_euler(0, ey + 180, 0)
            local nx,nr,nz = util.quaternion_multiply_v3(qx,qy,qz,qw,moveDir:GetX(),moveDir:GetY(),moveDir:GetZ())
            moveDir:SetX(nx)
            moveDir:SetY(nr)
            moveDir:SetZ(nz)
            local cameraPos = this.GetPositionV3d()
            local adjustPos, result = this.AdjustCurrentFrameMoveByCameraWall(cameraPos, moveDir)
            cameraPos:RAdd(adjustPos)

            this.SetPositionV3d(cameraPos)
            this.rayCaseHit = result
        else
            app.log('can not get camera rotate')
        end
    end
end

function CameraTouchMoveManager.SetPositionV3d(pos)
    if pos == nil or this.cameraObj == nil then
        app.log('pos == nil or  this.cameraObj == nil' .. debug.traceback())
    end
    this.cameraObj:set_position(pos:GetX(), pos:GetY(), pos:GetZ())
end

function CameraTouchMoveManager.GetPositionV3d()
    if this.cameraObj == nil then
        app.log('this.cameraObj == nil' .. debug.traceback())
    end
    local cameraX, cameraY, cameraZ = this.cameraObj:get_position();
    return Vector3d:new({x = cameraX, y = cameraY , z = cameraZ})
end

function CameraTouchMoveManager.AdjustCurrentFrameMoveByCameraWall(lastPos, move)
    local cameraMoveDir = move:CNormalize()    
    --app.log('==============>' .. table.tostring(move) .. ' cameraMoveDir = ' ..  table.tostring(cameraMoveDir))
    local result, hit = util.raycase_out4(lastPos:GetX(), lastPos:GetY(), lastPos:GetZ(),
            cameraMoveDir:GetX(), cameraMoveDir:GetY(), cameraMoveDir:GetZ(),
            move:GetLength(), this.CameraWallLayerMask)
    local ret = Vector3d:new({x = 0, y =0 , z = 0})
    if result then
		--app.log("AdjustCurrentFrameMoveByCameraWall 1")
        local hitNormal = Vector3d:new({x = hit.normal.x, y = hit.normal.y, z = hit.normal.z})
        local parallelMove = move:RAdd(hitNormal:RScale(hitNormal:Dot(move:CScale(-1))))

        local parallelMoveLenSQ = parallelMove:GetLengthSQ()
        if parallelMoveLenSQ > 0.00001 then
            local parallelMoveDir = parallelMove:CNormalize()
            if util.raycast_valid(lastPos:GetX(), lastPos:GetY(), lastPos:GetZ(),
                parallelMoveDir:GetX(), parallelMoveDir:GetY(), parallelMoveDir:GetZ(), 
                parallelMove:GetLength(), this.CameraWallLayerMask) then

            else
                ret = parallelMove
            end
        end
    else		
		--app.log("AdjustCurrentFrameMoveByCameraWall 2")
        ret = move
    end
    return ret, result
end