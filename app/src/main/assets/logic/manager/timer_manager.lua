--[[----------------------------------------------------------------------
定时器管理者单件对象 TimerManager.lua
-------------------------------------------------------------------------]]

TimerManager = {
	Caption			= "定时器管理者";	-- 管理者名称
	ScriptName		= "TimerManager";	-- 脚本名称
	Timers			= {};				-- 定时器集合
	SerialNumberMax	= 0;				-- 最大流水号
	NextUpdateTime	= 0;				-- 下次更新时间
};

-- 内部可以用this指向TimerManager，简化代码书写
local this = TimerManager;

-- 查询指定的Timer回调是否在运行中
function TimerManager.IsRunning( Callback )
	if Callback == nil then return false end;
	
	return this.Timers[ Callback ] ~= nil;
end

--[[ 增加定时回调
参数：	Callback	回调方法对象
		Interval	间隔时间，单位毫秒，默认为1000
		Times		执行次数，默认为1次，-1为无限
		Data		回调参数
		Weight		优先权重，值越大越优先被调用，默认为0
说明：执行指定次数后会自动移除，中途中止需调用移除方法。
如果方法相同，则会覆盖并使用新参数。回调方法及其参数，
Callback( 回调参数, 当前次数 ）。
--]]
function TimerManager.Add( Callback, Interval, Times, Data, Weight )
	if Callback == nil then return end;
	
	Interval= Interval 	or 1000;
	Times 	= Times    	or 1;
	Weight	= Weight	or 0;
	
	local Timer = this.Timers[ Callback ];
	if Timer == nil then
		Timer = {}; this.Timers[ Callback ] = Timer;
	end
	Timer.Interval 	= Interval;
	Timer.Times		= Times;
	Timer.Data		= Data;
	Timer.BeginTime	= app.get_time() * 1000;
	Timer.NextTime	= Timer.BeginTime + Interval;
	Timer.Count		= 0;
	Timer.Weight	= Weight;
	Timer.Valid		= true;
	Timer.Serial	= this.SerialNumberMax;

	-- 调试数据
	if not AppConfig.get_enable_on_line() then
		Timer.DebugMsg 	= debug.traceback();
	end
	
	-- 序号累加
	this.SerialNumberMax	= this.SerialNumberMax + 1;
	
	-- 刷新下次需要检查回调的最近时间
	this.NextUpdateTime = math.min( this.NextUpdateTime, Timer.NextTime );
end

--[[ 移除定时回调
参数：	Callback	回调方法
--]]
function TimerManager.Remove( Callback )
	if Callback == nil then return end;
	this.Timers[ Callback ] = nil;
end

-- 清除所有定时回调
function TimerManager.ClearAll()
	this.Timers 			= {};
	this.SerialNumberMax	= 0;
end

--[[ 执行定时回调检查
说明：触发满足条件的定时调用，并计算下次回调时间或移除掉；重新计算
下一次执行回调检查的时间；
--]]
function TimerManager.Execute()
	local Now = app.get_time() * 1000;
	if this.NextUpdateTime > Now then return end;
	
	local NextUpdateTime, Timer = Now + 1000, nil;
	local Removes, Calles = {}, {};
	
	-- 1、检查需要调用和移除的定时器
	for Callback, Timer in pairs( this.Timers ) do
		if Timer ~= nil then
			if Timer.NextTime <= Now then
				Timer.Count = Timer.Count + 1;
				if Timer.Times > 0 and Timer.Times <= Timer.Count then
					table.insert( Removes, Callback );
					Timer.Valid = false;
				else
					Timer.NextTime = Now + Timer.Interval;
				end
				table.insert( Calles, { 
					Callback= Callback, 
					Weight	= Timer.Weight, Serial = Timer.Serial,
					Count 	= Timer.Count, 	Data   = Timer.Data,
				} );
			end
			if Timer.Valid == true then
				NextUpdateTime = math.min( NextUpdateTime, Timer.NextTime );
			end
		end
	end
	this.NextUpdateTime = NextUpdateTime;
	
	-- 2、根据权重和序号顺序执行调用
	-- 回调中触发移除或添加回调，会造成迭代器错误
	if Calles ~= nil and #Calles > 0 then
		table.sort( Calles, this.SortCallback );
		for Index, Timer in pairs( Calles ) do
			if Timer.Callback ~= nil then
				local func = Utility.GetRealFunc(Timer.Callback)
				if func == nil then
					table.insert( Removes, Timer.Callback )
					
					if Timer.DebugMsg then
						app.log("timer callback被移除掉但未清除定时器: "..tostring(Timer.DebugMsg))
					end
				else
					func(Timer.Data, Timer.Count)
				end
			end
			Timer.Callback = nil; Timer.Data = nil;
		end
	end
	
	-- 3、移除时仍需要判断是否为有效，排除在回调时又重新创建的情况。
	for Index, Callback in pairs( Removes ) do
		Timer = this.Timers[ Callback ];
		if Timer ~= nil and Timer.Valid == false then
			this.Timers[ Callback ] = nil;
		end
		Timer = nil;
	end
	Removes = nil;
end

-- 排序调用（内部调用）
function TimerManager.SortCallback( A, B )
	if 	A.Weight == nil or A.Serial == nil or
		B.Weight == nil or B.Serial == nil then return false end;
	return ( A.Weight >  B.Weight or 
			 A.Weight == B.Weight and A.Serial > B.Serial );
end

-- 更新操作
function TimerManager.Update()
	this.Execute();
end