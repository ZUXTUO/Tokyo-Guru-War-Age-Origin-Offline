

--SystemTime = {}

--SystemTime.curTime = os.time()
--SystemTime.timeScale = 1

--function SystemTime.Update(deltaTime)
--    --app.log("Update   "..tostring(deltaTime).."   "..tostring(app.get_time()));
--    SystemTime.currentFrameDeltaTime = deltaTime
--    SystemTime.curTime = SystemTime.curTime + deltaTime * SystemTime.timeScale
--end

--function SystemTime.Time()
--    return math.ceil(SystemTime.curTime)
--end

--function SystemTime.TimeFloat()
--    return SystemTime.curTime
--end

--function SystemTime.DeltaTime()
--    return SystemTime.currentFrameDeltaTime
--end

--function SystemTime.SyncTime(time, scale)

--    local diff = time - SystemTime.curTime
--    if math.abs(diff) > 1 then
--        app.log('serverTime - clientTime=' .. diff)
--    end
--    --[[if tonumber(SystemTime.curTime) > tonumber(time) then
--        app.log_warning("SystemTime.curTime="..tostring(SystemTime.curTime).." time="..tostring(time));
--        return;
--    end]]
--    SystemTime.curTime = time
--    SystemTime.timeScale = scale
--end