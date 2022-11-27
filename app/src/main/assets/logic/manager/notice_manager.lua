--[[----------------------------------------------------------------------
通知管理器 NoticeManager.lua
-------------------------------------------------------------------------]]

NoticeManager = {
	NoticeListener		= {};					-- 通知侦听者
	SerialNumberMax		= 0;					-- 最大流水号
};

-- 内部可以用this指向NoticeManager，简化代码书写
local this = NoticeManager;

--有新手教程
function NoticeManager.GetTeach()
	GameInfoForThis.IsTeach = true;
end
--无新手教程
function NoticeManager.NoTeach()
	GameInfoForThis.IsTeach = false;
end

--[[ 广播通知
参数：	Type		通知类型
		...			传递的参数
--]]
function NoticeManager.Notice( Type, ... )
	if Type == nil then return end;
	if GameInfoForThis.IsTeach == true then --检测是否进行
		local Listener = this.NoticeListener[ Type ];
		if Listener ~= nil then
			local Callbacker, Success, Error, Func = nil, true, "", nil;
			for Index = 1, #Listener do
				Callbacker = Listener[ Index ];
				if Callbacker ~= nil and Callbacker.callback ~= nil then
					Func = nil
					if type( Callbacker.callback ) == "string" then
						Func = _G[Callbacker.callback];
					elseif type( Callbacker.callback ) == "function" then
						Func = Callbacker.callback;
					end
					if Func then
						Success, Error = pcall( Func, ... );
						if Success == false then app.log( Error ) end;
						if Callbacker.times > 0 then
							Callbacker.times = Callbacker.times - 1;
						end
					end
				end
				Callbacker = nil;
			end
			-- 移除次数用完的回调
			for Index = #Listener, 1, -1 do
				if Listener[ Index ].times == 0 then
					table.remove( Listener, Index );
				end
			end
		end
	end
end

--[[ 收听一次
参数：	Type		通知类型
		Callback	回调函数
说明：触发一次后，自动删除收听
--]]
function NoticeManager.ListenOnce( Type, Callback )
	this.BeginListen( Type, Callback, 1 );
end

--[[ 开始收听
参数：	Type		通知类型
		Callback	回调函数
		Times		收听次数，默认为-1
		Priority	优先级，默认为0，值越大越优先被调用，参见NoticePriority定义
说明：已经存在的监听，更新次数、优先级、时间戳。优先级相同的，以流水号早的先通知。
--]]
function NoticeManager.BeginListen( Type, Callback, Times, Priority )
	if Type == nil or Callback == nil then return end;

	if Times == nil 	then Times = -1   end;
	if Priority == nil 	then Priority = 0 end;

	local bExist 	= false;
	if GameInfoForThis.IsTeach == true then --检测是否进行
		local Listener 	= this.NoticeListener[ Type ];
		if Listener ~= nil then
			for Index, Callbacker in pairs( Listener ) do
				if Callbacker.callback == Callback then
					this.SerialNumberMax	= this.SerialNumberMax + 1;
					Callbacker.times 		= Times;
					Callbacker.priority 	= Priority;
					Callbacker.serial_number= this.SerialNumberMax;
					bExist = true; break;
				end
			end
		else
			Listener = {}; bExist = false;
			this.NoticeListener[ Type ] = Listener;
		end
		if bExist == false then
			this.SerialNumberMax = this.SerialNumberMax + 1;
			table.insert( Listener, {
				callback = Callback,
				times = Times, priority = Priority,
				serial_number = this.SerialNumberMax } );
		end

		-- 根据优先级排序
		if #Listener > 1 then
			table.sort( Listener, this.SortCallback );
		end
	end
end

--[[ 结束收听
参数：	Type		通知类型
		Callback	回调函数
--]]
function NoticeManager.EndListen( Type, Callback )
	if Type == nil or Callback == nil then return end;
	if GameInfoForThis.IsTeach == true then --检测是否进行
		local Listener = this.NoticeListener[ Type ];
		if Listener ~= nil then
			for Index = #Listener, 1, -1 do
				if  Listener[ Index ].callback == Callback then
					Listener[ Index ].callback = nil;
					table.remove( Listener, Index ); break;
				end
			end
		end
	end
end

--[[ 清除收听
参数：	Type	通知类型，不传递参数或nil为清除所有收听
--]]
function NoticeManager.ClearListen( Type )
	if GameInfoForThis.IsTeach == true then --检测是否进行
		if Type == nil then
			for Type, Listener in pairs( this.NoticeListener ) do
				for Index, Callbacker in pairs( Listener ) do
					Callbacker.callback = nil;
				end
			end
			this.NoticeListener = {};
		else
			local Listener = this.NoticeListener[ Type ];
			if Listener ~= nil then
				for Index, Callbacker in pairs( Listener ) do
					Callbacker.callback = nil;
				end
				this.NoticeListener[ Type ] = nil;
			end
		end
	end
end

--[[ 通知回调排序（内部调用）
参数：A、B	参与排序的回调数据
说明：按优先级越高、创建时间越早排序
--]]
function NoticeManager.SortCallback( A, B )
	if  A == nil or B == nil or
		A.priority == nil or B.priority == nil or
		A.serial_number == nil or B.serial_number == nil
		then return false end;

	local Result = false;
	if  A.priority 		>  B.priority or (
		A.priority 		== B.priority and
		A.serial_number <  B.serial_number ) then
		Result = true;
	end

	return Result;
end