core={};
function core.copy_1(t2, t1)
    if type(t1) == "table" then
    for k,v in pairs(t1) do
      local str = k .. "=";
      if type(v) == "table" then
        local d2 = {};
        core.copy_1(d2, v);
        t2[k] = d2;
      else
        t2[k] = v;
      end;
    end;
    end;
end;
--浅表拷贝
function corecopy(t1)
  local t2 = {};
  local temp = {};
  temp.t1 = t1;
  core.copy_1(t2, temp);
  return t2.t1;   
end
--深度拷贝
function core.deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end 
    return _copy(object);
end
core.print= function(data)
  if data == nil then 
    sprint("core.print data is nil");
  end 
  if(type(data)=="table") then
    for k, v in pairs(data) do
      sprint("k="..tostring(k).."\tv="..tostring(v));
      if(type(v) == "table") then
        core.print(v);
      end
    end
  else
    sprint(tostring(data));
  end
end
--在data里找value data可以不为table
core.find_value = function(data,value)
  --sprint("\n call core.find_value value : "..value.."! \n");
  if data == nil then
    return false;
  end
  if type(data) == "table" then
    --core.print(data);
    for k,v in pairs(data) do
      if type(v) == "table" then
        if core.find_value(v,value) == true then
          --sprint("\n call core.find_value find ! \n");
          return true;
        end
      else
        if v == value then
          --sprint("\n call core.find_value find ! \n");
          return true;
        end
      end

    end
  else
    if data == value then
      return true;
    end
  end
  return false;
end
--在data里找value value为table
core.find_table = function(data,value)
  if data == nil then
    return false;
  end
  if type(data) ~= "table" then
    return false;
  end
  if data == value then
    return true;
  end
  local find_next = {};
  for k,v in pairs(data) do
    if v == value then
      return true;
    elseif type(v) == "table" then
      for m,n in pairs(v) do
       if type(n) == "table" then
         table.insert(find_next,n);
       end
      end
    end
  end
  if table.getn(find_next) > 0 then
	core.find_table(find_next,value);
  end
  return false;
end

--call function util
core.call_func = function(func, args)
  if func then
    if args then
      if type(args) == "table" then
        local len = #args;
        if len == 0 then
          return func();
        elseif len == 1 then
          return func(args[1]);
        elseif len == 2 then
          return func(args[1], args[2]);
        elseif len == 3 then
          return func(args[1], args[2], args[3]);
        elseif len == 4 then
          return func(args[1], args[2], args[3], args[4]);
        elseif len == 5 then
          return func(args[1], args[2], args[3], args[4], args[5]);
        elseif len == 6 then
          return func(args[1], args[2], args[3], args[4], args[5], args[6]);
        elseif len == 7 then
          return func(args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
        elseif len == 8 then
          return func(args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
        end
      else
        return func(args);
      end
    else
      return func();
    end
  end
  return false;
end

core.p = function(data)
	-- 函数已废弃
end

core.tableprint = function(data,cstring)
	-- 函数已废弃
end

--monitor util
monitor_util = {};
--copy list
monitor_util.copy_func_lst = function(lst)
  local ary = {};
  for k_i, v_func in ipairs(lst) do
    table.insert(ary, v_func);
  end
  return ary;
end
monitor_util.call_func_lst = function(lst, a,b,c,d,e,f,g)
  if table.getn(lst) == 0 then
    return;
  end
  local ary = monitor_util.copy_func_lst(lst);
  for k_i, v_func in ipairs(ary) do
    if v_func then
      v_func(a,b,c,d,e,f,g);
    end
  end
end
monitor_util.add_func_to_lst = function(lst, func)
  if func then
    monitor_util.remove_func_from_lst(lst, func);
    table.insert(lst, func);
  end
end
monitor_util.remove_func_from_lst = function(lst, func)
  if func then
    for i, v_func in ipairs(lst) do
      if v_func == func then
        table.remove(lst, i);
        break;
      end
    end
  end
end
monitor_util.create_base_monitor = function(events)
  local monitor = {};
  for _i, v_str in ipairs(events) do
    local str_lst = v_str .. "_lst";
    monitor[str_lst] = {};
    monitor["add_on_" .. v_str] = function(func)
      local self = monitor;
      self.add_func_to_lst(self[str_lst], func);
    end
    monitor["remove_on_" .. v_str] = function(func)
      local self = monitor;
      self.remove_func_from_lst(self[str_lst], func);
    end
    monitor["on_" .. v_str] = function(a,b,c,d,e,f,g)
      local self = monitor;
      self.call_func_lst(self[str_lst], a,b,c,d,e,f,g);
    end
  end
  monitor = create_class(monitor, monitor_util);
  return monitor;
end


--class
local function search(k, plist)
  for i=1, table.getn(plist) do
    local v = plist[i][k]    -- try 'i'-th superclass
    if v then return v end
  end
end

function create_class(...)

  local c = {};

  setmetatable(c, {__index = function(t, k)
    local v = search(k, arg);
    t[k] = v;
    return v;
  end});
  c.__index = c;
  function c:new(o)
    o = o or {};
    setmetatable(o, c);
    return o;
  end

  return c;
end
--获取时间数值的时：分：秒字符串
function g_getTimeString(time,needSec)
	local hour = math.floor(time/3600);
	local minute = math.fmod(math.floor(time/60), 60)
	local second = math.fmod(time, 60)
	local hourStr;
	local minuteStr;
	local secondStr;
	hourStr = tostring(hour);
	if hour < 10 then 
		hourStr = "0"..tostring(hour);
	else 
		hourStr = tostring(hour);
	end
	if minute < 10 then 
		minuteStr = "0"..tostring(minute);
	else 
		minuteStr = tostring(minute);
	end
	if second < 10 then 
		secondStr = "0"..tostring(second);
	else 
		secondStr = tostring(second);
	end
	local rtTime = hourStr..":"..minuteStr..":"..secondStr;
	if needSec == false then 
		rtTime = hourStr..":"..minuteStr;
	end 
	return rtTime
end 
--获取时间数值的X时XX分XX秒字符串
function g_getTimeChString(time)
	local hour = math.floor(time/3600);
	local minute = math.fmod(math.floor(time/60), 60)
	local second = math.fmod(time, 60)
	local hourStr = "";
	local minuteStr = "";
	local secondStr = "";
	
	if hour > 0 then 
		hourStr = tostring(hour).."小时";
	end 
	if minute < 10 and minute > 0 then 
		minuteStr = "0"..tostring(minute).."分";
	elseif minute > 0 then  
		minuteStr = tostring(minute).."分";
	end 	
	if second < 10 then 
		secondStr = "0"..tostring(second).."秒";
	else 
		secondStr = tostring(second).."秒";
	end
	local rtTime = hourStr..minuteStr..secondStr;
	return rtTime
end 