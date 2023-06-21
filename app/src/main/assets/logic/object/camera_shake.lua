CameraShake = { }
local curDir = { x = nil, y = nil, z = nil };     -- 记录抖动前的距离
local beginPos = { x = nil, y = nil, z = nil };     -- 记录抖动前的位置
local shakeCD = 0.002;                  -- 抖动的频率
local shakeCount = -1;                  -- 设置抖动次数
local shakeMaxCount = -1;
local shakeTime = 0;
local shakeDis = 10;
local scale = 0.5;
local callback = nil;
local follObj = nil;
local shakeType = 0;

-- data = {
-- type 0/1 非特效/特效
-- obj 跟随目标/路径
-- callback 结束回调
-- count 抖动次数
-- cd  抖动cd时间，单位s
-- dis 抖动距离
-- scale （0~1） 从百分之多少后开始衰减
-- }
function CameraShake.shake(data)
    --app.log(string.format("shake: %s", table.tostring(data)))

    local transform = CameraManager.GetCameraObj();
    if transform == nil then return end;
    scale = data.scale or 0.5;
    shakeCount = data.count or math.random(50, 60);
    shakeMaxCount = shakeCount;
    -- 设置抖动次数
    shakeCD = data.cd or 0.2;
    shakeDis = data.dis or 10;
    callback = data.callback;
    follObj = data.obj;
    shakeType = data.type or 0;

    if shakeType == 0 then
        local curCamPos = {};
        curCamPos.x, curCamPos.y, curCamPos.z = transform:get_position();
        local curObjPos = {};
        curObjPos.x, curObjPos.y, curObjPos.z = data.obj:get_position();
        -- 记录跟随对象与摄像机的距离
        curDir = 
        {
            x = curCamPos.x-curObjPos.x,
            y = curCamPos.y-curObjPos.y,
            z = curCamPos.z-curObjPos.z,
        };
    else
        curDir={x=0,y=0,z=0};
        beginPos.x,beginPos.y,beginPos.z = data.obj:get_position();

        app.log(beginPos.x..">>"..beginPos.y..">>"..beginPos.z);

    end


    Root.AddUpdate(CameraShake.Update);
end

function CameraShake.Update()
    local transform = CameraManager.GetCameraObj();
    if transform == nil then
        app.log("@$$$$$ trans == nil ");
        Root.DelUpdate(CameraShake.Update)
        if callback then
            callback();
        end
        return;
    end

    if shakeCount <= 0 then
        app.log("@$$$$$ DelUpdate ");
        Root.DelUpdate(CameraShake.Update);
        if callback then
            callback();
        end
        return;
    end 

    --app.log("camera shake update per frame")

    if shakeCount > 0 and shakeTime + shakeCD < app.get_time() then
        local curObjPos = {};
        curObjPos.x, curObjPos.y, curObjPos.z = follObj:get_position();

        shakeCount = shakeCount - 1;
        if shakeCount <= shakeMaxCount - shakeMaxCount*scale then
            shakeDis = shakeDis - shakeDis/(shakeMaxCount - shakeMaxCount*scale);
            app.log("dis"..tostring(shakeDis));
        end
        local radio = (math.random()*2-1)* shakeDis;
        if shakeCount == 1 then
            -- 抖动最后一次时设置为都动前记录的位置
            shakeCount = 0
            if shakeType == 0 then
                transform:set_position(curObjPos.x+curDir.x, curObjPos.y+curDir.y, curObjPos.z+curDir.z);
            else
                follObj:set_position(beginPos.x,beginPos.y,beginPos.z);
            end
            return;
        end
        shakeTime = app.get_time();
        local x = curObjPos.x+curDir.x;
        local y = curObjPos.y+curDir.y+radio;
        local z = curObjPos.z+curDir.z;

--        app.log(string.format("shake name:%s, %f, %f, %f",transform:get_name(), x, y, z))

        if shakeType == 0 then
            transform:set_position(x, y, z);
        else
            follObj:set_position(x, y, z);
        end
    end
end

return CameraShake
