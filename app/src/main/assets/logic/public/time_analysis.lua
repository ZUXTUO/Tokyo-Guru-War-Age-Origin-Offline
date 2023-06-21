TimeAnalysis = {};
local secondsTimes = 0;
local minuteTimes  = 0;
local hourTimes    = 0;
local dayTimes     = 0;
local weekTimes    = 0;
local monthTimes   = 0;
local yearTimes    = 0;

local getPrewTime  = 0;
local isFree       = false;
local times        = 0;
--[[
	@param判断7日今天是否可以领取
]]--
function TimeAnalysis.checkCanGetToday()
    -- 无数据
    if not g_checkin.isWeekDataInit then
        return false
    end
	--没有值说明从未领取过 直接可以领取
	if g_checkin.week.checkLastTime == '' or g_checkin.week.checkLastTime == '0'  or g_checkin.week.checkLastTime == ' ' then return true; end;
	--服务器当前时间 
	local sysTime  = os.date("*t",system.time() - ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_checkin7Freshtime).data*3600);
	--上次领取的时候
	local lastTime = os.date("*t",g_checkin.week.checkLastTime - ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_checkin7Freshtime).data*3600);
	if sysTime.year ~= lastTime.year or sysTime.month ~= lastTime.month or sysTime.day ~= lastTime.day then
		return true;
	end
	return false;
end

--[[
	@param判断月签到今天是否可以领取
]]--
function TimeAnalysis.checkMonthCanGetToday()
    -- 无数据
    if not g_checkin.isMonthDataInit then
        return false
    end
	--没有值说明从未领取过 直接可以领取
	if g_checkin.month.checkLastTime == '' or g_checkin.month.checkLastTime == '0' or g_checkin.month.checkLastTime == ' ' then return true; end;
	--服务器当前时间 
	local sysTime  = os.date("*t",system.time() - ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_chechinMonthFreshtime).data*3600);
	--上次领取的时候
	local lastTime = os.date("*t",g_checkin.month.checkLastTime - ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_chechinMonthFreshtime).data*3600);
	if sysTime.year ~= lastTime.year or sysTime.month ~= lastTime.month or sysTime.day ~= lastTime.day then
		return true;
	end
	return false;
end

function TimeAnalysis.getMonthDay()
	local sysTime  = os.date("*t",system.time() - ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_chechinMonthFreshtime).data*3600);
	local year  = sysTime.year;
	local month = sysTime.month;
	local day   = CheckinEnum.MONTH_DAY[month];
	if month == 2 then
		if (year%4 == 0 and year%100 ~= 0) or (year%400 == 0) then
			day = 29;
		end
	end
	if day then return day;
	else return 0;end;
end

function TimeAnalysis.getMonthText()
	local sysTime  = os.date("*t",system.time() - ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_chechinMonthFreshtime).data*3600);
    	local month = sysTime.month;
	return CheckinEnum.MONTH_DAY_TEXT[month];    
end

--[[
	@param getFreeData 取得免费领取的相关信息 返回已经领过最大次数,当前是否可以免费领取,以及上次领取时间
	@param infostr   服务器发来的字符串 t=xxx;d=xxx;w=xx 顺序可能颠倒
	@param configstr 客户端自己的配置 {d = 1,w = 3}
	@param coolTime  冷却时间 客户端自己去配置表读取  一般以s为单位
]]--
function TimeAnalysis.getFreeData(infostr,configstr,coolTime)
	isFree 			= true;
	local infoStr   = Utility.lua_string_split(infostr,';');
	--infoStr数据为空,表示登陆游戏以来第一次领取
	if(infoStr == null) then
		isFree = true;
	else
		TimeAnalysis.setFreeTimes(infostr);
		--相差时间 用于算冷却
		local timeDistance = system.time() - getPrewTime;
		--服务器时间 
		local sysTime = os.date("*t",system.time());
		--上次领取时间
		local getTime = os.date("*t",getPrewTime);
		--转化出来的数据没有week  这里需要计算下
		local day      = os.time({year=sysTime.year,month=sysTime.month,day=0});
		local firstday = os.date("*t",day);	
		local sysWeek = math.ceil((sysTime.day + firstday.wday)/7); 
		local getWeek = math.ceil((getTime.day + firstday.wday)/7); 	
		local configData = configstr;
		for k,v in pairs(configData) do
			if(k == 's') then
				--如果系统(秒)与上次领取(秒)不一致,则进入下个判断
				if(getTime.sec ~= sysTime.sec) then
					secondsTimes = 0;
				else
					--如果系统(秒)与上次领取(秒)一致,就判断分,时,日,周,月,年,全部相同则判定周期次数
					if(    getTime.min   == sysTime.min 
					   and getTime.hour  == sysTime.hour  
					   and getTime.day   == sysTime.day 
					   and getWeek       == sysWeek 
					   and getTime.month == sysTime.month
					   and getTime.year  == sysTime.year
					  ) then
						--如果在同一周期里则判断这个周期里是否达到最大次数
						if(secondsTimes >= v) then isFree = false; end
						--判断是否冷却
						if(timeDistance < coolTime) then isFree = false end
					else
						secondsTimes = 0;
					end
				end
			elseif(k == 'i') then
				--如果系统(分)与上次领取(分)不一致,则进入下个判断
				if(getTime.min ~= sysTime.min) then
					minuteTimes = 0;
				else
					--如果系统(分)与上次领取(分)一致,就判断时,日,周,月,年,全部相同则判定周期次数
					if(    getTime.hour  == sysTime.hour  
					   and getTime.day   == sysTime.day 
					   and getWeek       == sysWeek 
					   and getTime.month == sysTime.month
					   and getTime.year  == sysTime.year
					  ) then
						--如果在同一周期里则判断这个周期里是否达到最大次数
						if(minuteTimes >= v) then isFree = false end
						if(timeDistance < coolTime) then isFree = false end
					else
						minuteTimes = 0;
					end
				end
			elseif(k == 'h') then			
				if(getTime.hour ~= sysTime.hour) then
					hourTimes = 0;
				else
					--如果系统(时)与上次领取(时)一致,就判断日,周,月,年,全部相同则判定周期次数
					if(    getTime.day   == sysTime.day 
					   and getWeek       == sysWeek 
					   and getTime.month == sysTime.month
					   and getTime.year  == sysTime.year
					) then
						--如果在同一周期里则判断这个周期里是否达到最大次数
						if(hourTimes >= v) then isFree = false; end
						if(timeDistance < coolTime) then isFree = false; end
					else
						hourTimes = 0;
					end
				end
			elseif(k == 'd') then
				if(getTime.day ~= sysTime.day) then
					dayTimes = 0;
				else
					if(    getWeek       == sysWeek 
					   and getTime.month == sysTime.month
					   and getTime.year  == sysTime.year
					) then
						if(dayTimes >= v) then isFree = false; end
						if(timeDistance < coolTime) then isFree = false; end
					else
						dayTimes = 0;
					end
				end
			elseif(k == 'w') then
				if(sysWeek ~= getWeek) then
					weekTimes = 0;
				else
					if( getTime.month == sysTime.month and getTime.year  == sysTime.year) then
						if(weekTimes >= v) then isFree = false; end
						if(timeDistance < coolTime) then isFree = false; end
					else
						weekTimes = 0;
					end
				end
			elseif(k == 'm') then
				if(getTime.month ~= sysTime.month) then
					monthTimes = 0;
				else
					if(getTime.year  == sysTime.year) then
						if(monthTimes >= v) then isFree = false; end
						if(timeDistance < coolTime) then isFree = false end
					else
						monthTimes = 0;
					end
				end
			elseif(k == 'y') then
				if(getTime.year ~= sysTime.year) then
					yearTimes = 0;
				else
					if(yearTimes >= v) then isFree = false; end
					if(timeDistance < coolTime) then isFree = false; end
				end
			end
		end
		times = math.max(secondsTimes,minuteTimes,hourTimes,dayTimes,weekTimes,monthTimes,yearTimes);
		
		local freeTable = {};
		freeTable.isFree 	  = isFree;
		freeTable.freeTimes   = times;
		freeTable.getPrewTime = getPrewTime;
		
		return freeTable;
	end
end

function TimeAnalysis.activeIsOpen(cycle,coolTime)
	do return end;
	local isOpen = true;
	--服务器时间 
	local sysTime= os.date("*t",system.time());
	local nYear  = sysTime.year;
	local nMonth = sysTime.month;
	local nWeek  = 0;
	local nDay   = sysTime.day;
	local nHour  = sysTime.hour;
	local nMin   = sysTime.min;
	local nSec   = sysTime.sec;
	
	if(nil == cycle) then return nil; end;
	
	if(nil == sysTime) then return nil; end;
	local combinationTime = 0;

	--cycle[1]为nil说明有几张表嵌入在cycleTable中
	if(nil == cycle[1]) then
		if(nil ~= cycle.y)  then nYear  = cycle.y;   end
		if(nil ~= cycle.m)  then nMonth = cycle.m;   end
		if(nil ~= cycle.h)  then nHour  = cycle.h;   end
		if(nil ~= cycle.i)  then nMin   = cycle.i;   end
		if(nil ~= cycle.s)  then nSec   = cycle.s;   end
		if(nil ~= cycle.md) then nDay   = cycle.md;  end
		if(nil ~= cycle.w)  then nWeek  = cycle.w;   end
		if(nil ~= cycle.wd) then
			--计算出当前wd是当月第几天
			local firstday = os.date("*t",os.time({year=nYear,month=nMonth,day=0}));
			if(nWeek == 0) then
				nDay = (math.floor(sysTime.day/7))*7+(cycle.wd+1)-firstday.wday;
			else
				nDay = (cycle.wd+1) +(nWeek - 1)*7 -firstday.wday;
			end
			
		end
		combinationTime = os.time({year=nYear,month=nMonth,day=nDay, hour=nHour, min=nMin, sec=nSec}); 
		combinationTime = combinationTime - system.time_d;	
		disTime  = system.time() - combinationTime;
		if(disTime >= 0  and disTime < coolTime) then isOpen = true;
		else isOpen = false;
		end
	else
		local length = #cycle;
		for i = 1,length do
			if(nil ~= cycle[i].y)  then nYear  = cycle[i].y;   end
			if(nil ~= cycle[i].m)  then nMonth = cycle[i].m;   end
			if(nil ~= cycle[i].h)  then nHour  = cycle[i].h;   end
			if(nil ~= cycle[i].i)  then nMin   = cycle[i].i;   end
			if(nil ~= cycle[i].s)  then nSec   = cycle[i].s;   end
			if(nil ~= cycle[i].md) then nDay   = cycle[i].md;  end
			if(nil ~= cycle[i].w)  then nWeek  = cycle[i].w;   end
			if(nil ~= cycle[i].wd) then
				local firstday = os.date("*t",os.time({year=nYear,month=nMonth,day=0}));
				if(nWeek == 0) then
					nDay = (math.floor(sysTime.day/7))*7+(cycle[i].wd+1)-firstday.wday;
				else
					nDay = (cycle[i].wd+1) +(nWeek - 1)*7 -firstday.wday;
				end
			end
			combinationTime = os.time({year=nYear,month=nMonth,day=nDay, hour=nHour, min=nMin, sec=nSec}); 
			combinationTime = combinationTime - system.time_d;	
			disTime  = system.time() - combinationTime;
			if(disTime >= 0  and disTime < coolTime) then 
			else isOpen = false;
			end
		end
	end
	
	local data = {};
	data.isOpen = isOpen;
	data.sec    = combinationTime + coolTime - system.time();

	return data;
end

function TimeAnalysis.analysisSec(sec)
	if(sec >= 24*60*60) then
		return '[ffffff]剩余'..math.floor(sec/(24*60*60))..'天'..'[-]';
	elseif(sec > 60*60) then
		return '[ffffff]剩余'..math.floor(sec/(60*60))..'小时'..'[-]';
	elseif(sec > 60) then
		return '[ff0000]剩余'..math.floor(sec/60)..'分'..'[-]';
	else
		return '[ff0000]剩余'..sec..'秒'..'[-]';
	end
end

--传入秒，分解成天，时，分，秒
function TimeAnalysis.ConvertSecToDayHourMin(sec)
	local day,hour,min = 0,0,0;
	if sec >= 24 * 60 * 60 then
		day = math.floor(sec / (24 * 60 * 60))
		sec = sec - day * 24 * 60 * 60;
	end
	if sec >= 60 * 60 then
		hour = math.floor(sec / 60 / 60);
		sec = sec - hour * 60 * 60;
	end
	if sec >= 60 then
		min = math.floor(sec/60);
		sec = sec - min * 60;
	end
	return day,hour,min,sec;

end

--将格林威治时间转换成年月日
function TimeAnalysis.ConvertToYearMonDay(time)
	local tab = os.date("*t",time);
	local year,month,day,hour,min,sec;
	year = tab.year;
	month = tab.month;
	day = tab.day;
	hour = tab.hour;
	min = tab.min;
	sec = tab.sec;
	return year,month,day,hour,min,sec;
end

--[[0-6 = Sunday-Saturday  ==> 0--7]]
function TimeAnalysis.ConvertToWeekday(time)
	local wDay = tonumber(os.date("%w", time))
    if wDay == 0 then
        return 7
    end
    return wDay
end

function TimeAnalysis.analysisSec_2(seconds, isNotHaveHour)
	local str 	 = '';
	local hour   = 0;
	local minite = 0;
	local sec    = 0;
	sec = seconds;

	hour   = math.floor(sec/(60*60));
	sec    = (sec - hour*60*60);
	minite = math.floor(sec/60);
	sec    = (sec - minite*60);

	if not isNotHaveHour then
		if(hour >= 10) then str =  hour..':';
		elseif(hour > 0) then str =  '0'..hour..':';
		else  str =  '00:';
		end
	end
	
	if(minite >= 10) then str = str..minite..':';
	elseif(minite > 0) then str =  str..'0'..minite..':';
	else str =  str..'00:';
	end
	
	if(sec >= 10) then str = str..sec;
	elseif(sec > 0) then str =  str..'0'..sec;
	else str =  str..'00';
	end
	
	return str;
end

--精确到秒
function TimeAnalysis.analysisSec_3(sec, showBefore, vague)
	local beforeStr = ""
	if showBefore then 
		beforeStr = "前"
	end
	if(sec >= 24*60*60) then
		return ''..math.floor(sec/(24*60*60))..'天'..beforeStr;
	elseif(sec > 60*60) then
		return ''..math.floor(sec/(60*60))..'小时'..beforeStr;
	elseif(sec > 60) then
		return ''..math.floor(sec/60)..'分钟'..beforeStr;
	else
		return ''..sec..'秒'..beforeStr;
	end
end

--精确到分钟
function TimeAnalysis.analysisSec_4(sec, showBefore, showExact)
	local timeStr = {}
	if(sec >= 24*60*60) then
		local day = math.floor(sec/(24*3600))
		sec = sec - day*24*3600
		table.insert(timeStr, day..'天')
	end
	if(sec > 60*60) then
		local hour = math.floor(sec/(3600))
		sec = sec - hour*3600
		table.insert(timeStr, hour..'小时')
	end
	if(sec > 60) then
		local min = math.floor(sec/(60))
		sec = sec - min*60
		table.insert(timeStr, min..'分钟')
	end
	--不到1分钟的
	if #timeStr == 0 then
		if showExact then
			table.insert(timeStr, '1分钟')
		else
			-- 模糊处理
			table.insert(timeStr, '刚刚')
		end
	elseif showBefore then
		table.insert(timeStr, '前')
	end
	
	return table.concat(timeStr, "")
end

--精确到小时
function TimeAnalysis.analysisSec_5(sec, showBefore, showExact)
	local timeStr = {}
	if(sec >= 24*60*60) then
		local day = math.floor(sec/(24*3600))
		sec = sec - day*24*3600
		table.insert(timeStr, day..'天')
	end
	if(sec > 60*60) then
		local hour = math.floor(sec/(3600))
		sec = sec - hour*3600
		table.insert(timeStr, hour..'小时')
	end
	--不到1小时的
	if #timeStr == 0 then
		if showExact then
			table.insert(timeStr, '1小时')
		else
			-- 模糊处理
			table.insert(timeStr, '刚刚')
		end
	elseif showBefore then
		table.insert(timeStr, '前')
	end
	return table.concat(timeStr, "")
end

--模糊显示时间
function TimeAnalysis.analysisSec_fuzzy(sec, showBefore, showExact)
	local timeStr = {}
	if(sec >= 24*60*60) then
		local day = math.floor(sec/(24*3600))
		sec = sec - day*24*3600
		table.insert(timeStr, day..'天')
	elseif(sec > 60*60) then
		local hour = math.floor(sec/(3600))
		sec = sec - hour*3600
		table.insert(timeStr, hour..'小时')
	elseif(sec > 60) then
		local min = math.floor(sec/(60))
		sec = sec - min*60
		table.insert(timeStr, min..'分钟')
	end
	--不到1分钟的
	if #timeStr == 0 then
		if showExact then
			table.insert(timeStr, '1分钟')
		else
			-- 模糊处理
			table.insert(timeStr, '刚刚')
		end
	elseif showBefore then
		table.insert(timeStr, '前')
	end
	
	return table.concat(timeStr, "")
end

function TimeAnalysis.setFreeTimes(infostr)	
	local infoStr = Utility.lua_string_split(infostr,';');
	if(nil == infoStr) then
		return nil;
	end
	getPrewTime  = 0;
	secondsTimes = 0;
	minuteTimes  = 0;
	hourTimes    = 0;
	dayTimes     = 0;
	weekTimes    = 0;
	monthTimes   = 0;
	yearTimes    = 0;
	
	for k,v in pairs(infoStr) do
		--发送来的数据可能是t=xxx;d=xxx;w=xxx,也可能是其他顺序 这里判断下
		if(string.sub(v,1,1) == 't') then
			getPrewTime = string.sub(v,3,-1);
		elseif(string.sub(v,1,1) == 's') then
			secondsTimes = tonumber(string.sub(v,3,-1));
		elseif(string.sub(v,1,1) == 'i') then
			minuteTimes = tonumber(string.sub(v,3,-1));
		elseif(string.sub(v,1,1) == 'h') then
			hourTimes = tonumber(string.sub(v,3,-1));
		elseif(string.sub(v,1,1) == 'd') then
			dayTimes = tonumber(string.sub(v,3,-1));
		elseif(string.sub(v,1,1) == 'w') then
			weekTimes = tonumber(string.sub(v,3,-1));
		elseif(string.sub(v,1,1) == 'm') then
			monthTimes = tonumber(string.sub(v,3,-1));
		elseif(string.sub(v,1,1) == 'y') then
			yearTimes = tonumber(string.sub(v,3,-1));
		end
	end
end

function TimeAnalysis.GetMaxFreeTimes(configstr)
	if(nil == configstr) then 
		return nil 
	end
	local MaxTimes = 0;
	if(nil ~= configstr.s) then
		MaxTimes = math.max(0,configstr.s);
	end
	if(nil ~= configstr.i) then
		MaxTimes = math.max(MaxTimes,configstr.i);
	end
	if(nil ~= configstr.h) then
		MaxTimes = math.max(MaxTimes,configstr.h);
	end
	if(nil ~= configstr.d) then
		MaxTimes = math.max(MaxTimes,configstr.d);
	end
	if(nil ~= configstr.w) then
		MaxTimes = math.max(MaxTimes,configstr.w);
	end
	if(nil ~= configstr.m) then
		MaxTimes = math.max(MaxTimes,configstr.m);
	end
	if(nil ~= configstr.y) then
		MaxTimes = math.max(MaxTimes,configstr.y);
	end
	return MaxTimes;
end

--[[
    格式化时间
    传入141213, 转为14:12:13
]]
function TimeAnalysis.FormatTime(time)
    local time_str = time .. ""
    if string.len(time_str) ~= 6 then
        return time_str
    end
    return string.sub(time_str, 1, 2) .. ":" .. string.sub(time_str, 3, 4) .. ":" .. string.sub(time_str, 5, 6)
end

--[[
    格式化日期
    传入20160103, 转为2016*1*1 (其中*为分隔符，默认为'-')
--]]
function TimeAnalysis.FormatDate(date, sepChar)
    local date_str = date .. ""
    if string.len(date_str) ~= 8 then
        return date_str
    end
    sepChar = sepChar or "-"
    return string.sub(date_str, 1, 4) 
    	.. sepChar .. tonumber( string.sub(time_str, 5, 6) ) 
    	.. sepChar .. tonumber( string.sub(time_str, 7, 8) )
end

--[[
    将table数据转为秒数
    传入{y = 2016,m = 5,md = 20,h = 0,i = 0,s = 0,}
]]
function TimeAnalysis.TableToTimeSecond(t)
    if type(t) ~= "table" then
        return 0
    end
    local tTime = {year = t.y, month = t.m, day = t.md, hour = t.h, min = t.i, sec = t.s}
    return os.time(tTime)
end