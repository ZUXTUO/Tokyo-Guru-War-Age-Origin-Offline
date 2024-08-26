
g_checkin = {};
g_checkin.countTimer = nil;
g_checkin.isWeekDataInit = false
g_checkin.isMonthDataInit = false

function g_checkin.SetData(check_week,check_month)
	if check_week then
		g_checkin.week  = {};
		g_checkin.week.type 		   = check_week.check_type;
		g_checkin.week.checkLastTime   = check_week.last_check_date;
		if check_week.check_day == 7 and TimeAnalysis.checkCanGetToday() == true then
			g_checkin.week.checkDay    = 0;
			check_week.check_periodic  = check_week.check_periodic + 1;
		else
			g_checkin.week.checkDay    = check_week.check_day; 
		end
		if check_week.check_periodic  == 0 then 
			g_checkin.week.checkWeek   = 1;
		elseif check_week.check_periodic >= 2 then 
			g_checkin.week.checkWeek   = 2;
		else   
			g_checkin.week.checkWeek   = check_week.check_periodic; 
		end
		g_checkin.isWeekDataInit = true
		--g_activity.activity[1] = TimeAnalysis.checkCanGetToday();
	end
	if check_month then
		local sysTime  = os.date("*t",system.time() - ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_chechinMonthFreshtime).data*3600);
		
		g_checkin.month = {};
		g_checkin.month.type 		   = check_month.check_type;
		g_checkin.month.checkLastTime  = check_month.last_check_date;
		
		if sysTime.day == 1 and TimeAnalysis.checkMonthCanGetToday() == true then
			g_checkin.month.signDay    = 0;
			g_checkin.month.checkDay   = 0;
			--check_week.check_periodic  = check_week.check_periodic + 1;
		else
			g_checkin.month.signDay    = check_month.latesign_times;
			g_checkin.month.checkDay   = check_month.check_day;
		end
		if ConfigManager.Get(EConfigIndex.t_checkin_month,check_month.check_periodic) then
			g_checkin.month.checkMonth     = check_month.check_periodic;
		else
			g_checkin.month.checkMonth     = 1;
		end

        --g_activity.activity[2] = TimeAnalysis.checkMonthCanGetToday();
        g_checkin.isMonthDataInit = true
	end
	
	--每次上限会触发一个timer 这个timer会在次日3点时通知
	if g_checkin.countTimer then
		timer.stop(g_checkin.countTimer);
		g_checkin.countTimer = nil;
	end

    local freshTimeId = MsgEnum.ediscrete_id.eDiscreteId_checkin7Freshtime
    if check_month then
        freshTimeId = MsgEnum.ediscrete_id.eDiscreteId_chechinMonthFreshtime
    end
	
	local sysTime   = os.date("*t",system.time() - ConfigManager.Get(EConfigIndex.t_discrete,freshTimeId).data*3600);
	local ntime     = os.time({year=sysTime.year,month=sysTime.month,day=sysTime.day,hour=0,min=0,sec=0});
	local times     = ntime + 24*3600 - (os.time() - ConfigManager.Get(EConfigIndex.t_discrete,freshTimeId).data*3600);
	g_checkin.countTimer = timer.create("g_checkin.timerCount",times*1000 ,1);
    
end

function g_checkin.timerCount()
	if g_checkin.countTimer then
		timer.stop(g_checkin.countTimer);
		g_checkin.countTimer = nil;
	end
 	msg_checkin.cg_get_checkin_info();
end

function g_checkin.Destroy()
	if g_checkin.countTimer then
		timer.stop(g_checkin.countTimer);
		g_checkin.countTimer = nil;
	end
	g_checkin.isWeekDataInit = false
    g_checkin.isMonthDataInit = false
end