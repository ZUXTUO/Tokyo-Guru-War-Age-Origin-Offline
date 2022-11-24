time_flag = Class('time_flag')

function time_flag:Init()
    self.alltime = 60;
    self.Boundtime = 0;
    self.timeId = nil;
    --app.log("init time@#@#@#@#@#@#@#@#@#@#@#@#@#@#")
    return self
end

function time_flag:setData(time)
    if time then
        self.Boundtime = time
    else
        self.Boundtime = 0;
    end
    self:runtime()
end

function time_flag:runtime()
    
    if self.Boundtime > 0 then
        self.timeId = timer.create("time_flag.onWaitTime",1000,self.alltime);
    end        
end

function time_flag.onWaitTime()
    g_dataCenter.time_flag.Boundtime = g_dataCenter.time_flag.Boundtime+1;
    --app.log("time ########################"..tostring(g_dataCenter.time_flag.Boundtime))
    local time = g_dataCenter.time_flag.alltime-g_dataCenter.time_flag.Boundtime;
    if time <= 0 then
        if g_dataCenter.time_flag.timeId then
            timer.stop(g_dataCenter.time_flag.timeId);
            g_dataCenter.time_flag.timeId = nil;
            g_dataCenter.time_flag.Boundtime = 0;
        end
    end    
end

function time_flag:get_time()
   return  self.Boundtime
end
