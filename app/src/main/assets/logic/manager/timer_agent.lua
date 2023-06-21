--自定义定时器，封装一层
TimerAgent = {};

local timer_id = {};
local bindCallback = {};

--------------外部接口----------------------------------
--参数：callback: 回调函数,可以传一个字符串"xxxx"，也可以传一个表{func=xxx,user_data=yyy}
--		interval:间隔
--		loop：循环次数，-1为无限循环

--暂时未处理callback为table的情况
function TimerAgent.Create(callback,interval,loop)
	if type(callback) == "string" then
		bindCallback[callback] = Utility.bind_callback(callback, TimerAgent.Callback);
		local id = timer.create(bindCallback[callback],interval,loop);
		timer_id[id] = {};
		timer_id[id].callback = callback;
		timer_id[id].loop = loop;
		return id;
	end
end

function TimerAgent.Stop(id)
	if timer_id[id] then
		timer.stop(id);
		Utility.unbind_callback(timer_id[id].callback, bindCallback[timer_id[id].callback]);
		bindCallback[timer_id[id].callback] = nil;
		timer_id[id] = nil;
	end
end

function TimerAgent.StopAllTimer()
	for id,v in pairs(timer_id) do
		timer.stop(id);
		Utility.unbind_callback(v.callback, bindCallback[v.callback]);
		bindCallback[v.callback] = nil;
	end
	timer_id = {};
end

function TimerAgent.PauseAllTimer(is_pause)
	if is_pause then
		timer.pause_all();
	else
		timer.resume_all();
	end
end

function TimerAgent.Pause(id,is_pause)
	if is_pause then
		timer.pause(id);
	else
		timer.resume(id);
	end

end

-----------内部接口----------------------
--回调函数
function TimerAgent.Callback(callback,id)
	if type(callback) == "string" then
		if _G[callback] then
			_G[callback]();
			if timer_id[id].loop > 1 then
				timer_id[id].loop = timer_id[id].loop - 1;
			elseif timer_id[id].loop == 1 then
				timer.stop(id);
				Utility.unbind_callback(callback, bindCallback[callback]);
				bindCallback[callback] = nil;
				timer_id[id] = nil;
			end
		else
			app.log_warning("定时器回调函数"..tostring(callback).."已经不存在");
			timer.stop(id);
			Utility.unbind_callback(callback, bindCallback[callback]);
			bindCallback[callback] = nil;
			timer_id[id] = nil;
		end
	end
end