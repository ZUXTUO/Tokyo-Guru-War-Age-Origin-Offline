--[[
	签到单机数据
]]
--声明timer, 延迟返回使用
local _timerId = nil

-------------------------------------返回签到列表-------------------------------------
local g_checkinLocal = {};
g_checkinLocal.check_seven = 
{
	check_type = 1,
	last_check_date = 1437643003,
	check_day  = 1,
	check_periodic = 1,
	latesign_times = 0,
}

g_checkinLocal.check_month = 
{
	check_type = 2,
	last_check_date = 1437643003,
	check_day  = 1,
	check_periodic = 1,
	latesign_times = 0,
}

g_checkinLocal.checkin_ret = 
{
	{
		check_type = 1,
		last_check_date = system.time(),
		check_day  = 1,
		check_periodic = 1,
		latesign_times = 0,
	},
	
	{
		check_type = 2,
		last_check_date = system.time(),
		check_day  = 2,
		check_periodic = 2,
		latesign_times = 1,
	},
}

gc_checkin_info = {};
function gc_checkin_info.cg()
	_timerId = timer.create("gc_checkin_info.gc", 50, 1);
end

function gc_checkin_info.gc()
	msg_checkin.gc_checkin_info(g_checkinLocal.check_seven,g_checkinLocal.check_month);
	timer.stop(_timerId);
end

gc_checkin_ret = {};
local signType;
function gc_checkin_ret.cg(signyype)
	signType = signyype;
	_timerId = timer.create("gc_checkin_ret.gc", 50, 1);
end

function gc_checkin_ret.gc()
	msg_checkin.gc_checkin_ret(signType, 0,g_checkinLocal.checkin_ret);
	timer.stop(_timerId);
end

return g_checkinLocal;