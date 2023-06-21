-- region Utility.lua
-- Author : kevin
-- Date   : 2014/11/13

Utility = {
    callback_list = { },
    counter = 0,
    last_gaussianBlur_in_progress = false,

    guid = 0,

    msg_callback_list = {};
}

-- 内部可以用this指向，简化代码
local this = Utility;

function Utility.GenNextGUID()
    Utility.guid = Utility.guid + 1
    return Utility.guid
end

function Utility.create_callback(func, parm1, parm2)
    if func == nil then
        return nil
    end

    Utility.counter = Utility.counter + 1
    local name_ = '_create_callback' .. tostring(Utility.counter);

    local fn = function(parm3, parm4, parm5, parm6)
        func(parm1, parm2, parm3, parm4, parm5, parm6);
        _G[name_] = nil
        Utility.callback_list[name_] = nil
    end;

    _G[name_] = fn
    Utility.callback_list[name_] = fn

    return name_; 
end

function Utility.create_callback_ex(func, autodel, func_param_num, parm1, parm2, parm3, parm4, parm5, parm6)
    if func == nil then
        return nil
    end

    Utility.counter = Utility.counter + 1
    local name_ = '_create_callback' .. tostring(Utility.counter);
    local fn;
    if func_param_num == nil or func_param_num == 0 then
        fn = function()
            func(parm1, parm2, parm3, parm4, parm5, parm6);
            if autodel then
                _G[name_] = nil
                Utility.callback_list[name_] = nil
            end
        end;
    elseif func_param_num == 1 then
        fn = function(func_p1)
            func(func_p1, parm1, parm2, parm3, parm4, parm5, parm6);
            if autodel then
                _G[name_] = nil
                Utility.callback_list[name_] = nil
            end
        end;
    elseif func_param_num == 2 then
        fn = function(func_p1, func_p2)
            func(fun_p1, func_p2, parm1, parm2, parm3, parm4, parm5, parm6);
            if autodel then
                _G[name_] = nil
                Utility.callback_list[name_] = nil
            end
        end;
    elseif func_param_num == 3 then
        fn = function(func_p1, func_p2, func_p3)
            func(fun_p1, func_p2, func_p3, parm1, parm2, parm3, parm4, parm5, parm6);
            if autodel then
                _G[name_] = nil
                Utility.callback_list[name_] = nil
            end
        end;
    elseif func_param_num == 4 then
        fn = function(func_p1, func_p2, func_p3, func_p4)
            func(fun_p1, func_p2, func_p3, func_p4, parm1, parm2, parm3, parm4, parm5, parm6);
            if autodel then
                _G[name_] = nil
                Utility.callback_list[name_] = nil
            end
        end
    end
    _G[name_] = fn
    Utility.callback_list[name_] = fn
    return name_; 
end

function Utility.create_obj_callback(obj, func, func_param_num, parm1, parm2, parm3, parm4, parm5, parm6)
    if obj == nil or func == nil then
        return nil
    end

    Utility.counter = Utility.counter + 1
    local name_ = '_obj_callback' .. tostring(Utility.counter) .. "_" .. type(parm1);
    app.log(name_);
    -- .."-"..tostring(data)
    local fn;
    if func_param_num == nil or func_param_num == 0 then
        fn = function()
            func(obj, parm1, parm2, parm3, parm4, parm5, parm6);
            _G[name_] = nil
            Utility.callback_list[name_] = nil
        end;
    elseif func_param_num == 1 then
        fn = function(func_p1)
            func(obj, func_p1, parm1, parm2, parm3, parm4, parm5, parm6);
            _G[name_] = nil
            Utility.callback_list[name_] = nil
        end;
    elseif func_param_num == 2 then
        fn = function(func_p1, func_p2)
            func(obj, fun_p1, func_p2, parm1, parm2, parm3, parm4, parm5, parm6);
            _G[name_] = nil
            Utility.callback_list[name_] = nil
        end;
    elseif func_param_num == 3 then
        fn = function(func_p1, func_p2, func_p3)
            func(obj, fun_p1, func_p2, func_p3, parm1, parm2, parm3, parm4, parm5, parm6);
            _G[name_] = nil
            Utility.callback_list[name_] = nil
        end;
    elseif func_param_num == 4 then
        fn = function(func_p1, func_p2, func_p3, func_p4)
            func(obj, fun_p1, func_p2, func_p3, func_p4, parm1, parm2, parm3, parm4, parm5, parm6);
            _G[name_] = nil
            Utility.callback_list[name_] = nil
        end
    end

    _G[name_] = fn
    Utility.callback_list[name_] = fn

    return name_;
end

function Utility.gen_bind_callback_name(obj, func)
    if g_open_msg_regist then
        return '_bind_'..tostring(obj._className) .. '_' .. tostring(obj) .. '-' .. tostring(func)
    else
        return '_bind' .. '_' .. tostring(obj) .. '-' .. tostring(func)
    end
end

--替换已存在的bind回调
function Utility.replace_bind_callback(name, fn)
    local result = false
    if Utility.callback_list[name] then
        _G[name] = fn
        Utility.callback_list[name] = fn
        result = true
    end
    return result
end
if g_open_bind_callback then
    g_bind_callback = {}
    g_bind_callback_name = {}
end
function Utility.bind_callback(obj, func)
    if obj == nil or func == nil then
        return nil
    end
    local name_ = Utility.gen_bind_callback_name(obj, func)
    local fn = function(parm1, parm2, parm3, parm4, parm5, parm6, param7, param8, param9, param10)
        return func(obj, parm1, parm2, parm3, parm4, parm5, parm6, param7, param8, param9, param10);
    end;

    _G[name_] = fn
    Utility.callback_list[name_] = fn
    if g_open_bind_callback then
        g_bind_callback[name_] = tostring(debug.traceback());
        if not g_bind_callback_name[obj._className] then
            if obj._className == "" then
                app.log("..."..tostring(debug.traceback()))
            end
            g_bind_callback_name[obj._className] = {}
        end
        table.insert(g_bind_callback_name[obj._className], name_);
    end
    return name_;
end

function Utility.unbind_callback(obj, func_name)
    if obj == nil or func_name == nil then
        return false
    end

    if _G[func_name] == nil then
        return false
    end

    _G[func_name] = nil
    Utility.callback_list[func_name] = nil
    if g_open_bind_callback then
        g_bind_callback[func_name] = nil;
        for k, v in pairs(g_bind_callback_name[obj._className]) do
            if v == func_name then
                table.remove(g_bind_callback_name[obj._className], k);
                break;
            end
        end
        if table.get_num(g_bind_callback_name[obj._className]) <= 0 then
            g_bind_callback_name[obj._className] = nil;
        end
    end
end


function Utility.call_func(func_name, p1, p2, p3, p4, p5, p6, p7, p8)
    if func_name ~= nil and type(_G[func_name]) == 'function' then
        return true, _G[func_name](p1, p2, p3, p4, p5, p5, p6, p7, p8)
    end
    return false
end

-- huhu 直接在G表里放一个函数调用一个闭包
function Utility.gen_callback(func,param,param2) 
    if func == nil then
        return nil
    end

    Utility.counter = Utility.counter + 1
    local funcname = '_gen_callback' .. tostring(Utility.counter);

    if _G[funcname] then
        return funcname;
    end

    local fn = function()
        func(param,param2);
    end;

    _G[funcname] = fn

    return funcname; 
end

-- huhu 在G表里删除一个函数
function Utility.del_callback(funcname) 
    if _G[funcname] then
        _G[funcname] = nil;
    end
    if Utility.callback_list[funcname] then
        Utility.callback_list[funcname] = nil;
        --Utility.counter = Utility.counter - 1
    end
end

function Utility.mergeFrom(dst, src)
    for k, v in pairs(src) do
        if type(v) == 'table' then
            if dst[k] == nil then
                dst[k] = Utility.clone(v)
            else
                mergeFrom(dst[k], src[k])
            end
        else
            dst[k] = v
        end
    end
end



function Utility.clone(src)
    if src == nil then
        app.log("Utility.clone--nil "..debug.traceback())
    end
    local dst = { }
    for k, v in pairs(src) do
        if type(v) == 'table' then
            dst[k] = Utility.clone(v)
        elseif type(v) == 'function' then
            local i = 123;
            dst[k] = v
        else
            dst[k] = v
        end
    end
    local o = getmetatable(src);
    setmetatable(dst,o);

    return dst
end

function Utility.isEmpty(table)
    if table == nil then
        return true;
    end
    for k, v in pairs(table) do
        return false
    end

    return true
end

function Utility.getTableEntityCnt(t)
    local c = 0
    for k, v in pairs(t) do
        c = c + 1
    end
    return c
end

-- 获得下一个循环序号，比如：1,2,3,4,1,2,3,4
function Utility.getNextIndexLoop(cur_num, begin_num, end_num, is_add)
    -- 如果是增加
    if (is_add == true) then
        if (cur_num == end_num) then
            cur_num = begin_num;
        else
            cur_num = cur_num + 1;
        end
        -- 如果是减少
    else
        if (cur_num == begin_num) then
            cur_num = end_num;
        else
            cur_num = cur_num - 1;
        end
    end
    return cur_num;
end

--[[比较两个时间，返回相差多少时间]]
--begin_time 开始时间 格林威治时间 1900到现在秒数
--end_time 结束时间 格林威治时间 1900到现在秒数
function Utility.timediff(begin_time,end_time)
	local e_time,b_time,carry,diff = os.date('*t',tonumber(end_time)),os.date('*t',tostring(begin_time)),false,{}
	local colMax = {60,60,24,os.date('*t',os.time{year=e_time.year,month=e_time.month+1,day=0}).day,12,0}
	b_time.hour = b_time.hour - (b_time.isdst and 1 or 0) + (e_time.isdst and 1 or 0) -- handle dst
	for i,v in ipairs({'sec','min','hour','day','month','year'}) do
		diff[v] = e_time[v] - b_time[v] + (carry and -1 or 0)
		carry = diff[v] < 0
		if carry then
			diff[v] = diff[v] + colMax[i]
		end
	end
	return diff
end

--[[
	@param time 传入时间
	@param match 字段方式：%Y(年)%m(月)%d(日)%H(时)%M(分)%S(秒),如"%Y.%m.%d %H:%M:%S"
	@param type 1：正常时间，2：倒计时
]]--
function Utility.getUsualTime(time,match,type)
	if type == nil then type = 1; end
	local str = "";
	if type == 1 then
		str = os.date(match,time);
	elseif type == 2 then
		str = os.date(match,time-os.time()-8*60*60);
	end
	return str;
end
--[[
	@param str 传入字符串
	@param split_char 分割符 , plain text.
]]--
function Utility.lua_string_split(str, split_char)
    if not str or not split_char then
        app.log('Utility.lua_string_split bad str/spliter'..debug.traceback())
    end

    local sub_str_tab = {}; 
    local str_len = string.len(str)
    local start_pos = 1
    local pos = 1

    while true do
        pos = string.find(str, split_char, start_pos, true);
        if nil == pos then
            break;
        end

        table.insert(sub_str_tab, string.sub(str, start_pos, pos-1))
        start_pos = pos + 1;
    end

    table.insert(sub_str_tab, string.sub(str, start_pos, str_len))

    return sub_str_tab;
end

--[[
    获取汉字字符数（ASCII字母计为半个中文字）
--]]
function Utility.getCnFormatLength(str)
    if type(str) ~= "string" then
        app.log('Utility.getCNcharNumber bad str:'..debug.traceback())
        return 0 
    end

    local cnLength = 0
    local b = nil
    local n = 1

    b = str:byte(1)
    while (b) do
        -- 0xxxxxxx                       一个字符占1个字节
        if b < 128 then
            cnLength = cnLength + 0.5;
            n = n + 1
        -- 110xxxxx 10xxxxxxx             一个字符占2个字节
        elseif b < 224 then
            cnLength = cnLength + 1;
            n = n + 2
        -- 1110xxxx 10xxxxxxx 10xxxxxx   一个字符占3个字节
        elseif b < 240 then
            cnLength = cnLength + 1;
            n = n + 3
        -- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx 一个字符占4个字节
        else
            cnLength = cnLength + 1;
            n = n + 4
        end
        b = str:byte(n);
    end

    return cnLength
end


--截取中英混合的UTF8字符串，endIndex可缺省
function Utility.SubStringUTF8(str, startIndex, endIndex)
    if startIndex < 0 then
        startIndex = Utility.SubStringGetTotalIndex(str) + startIndex + 1;
    end

    if endIndex ~= nil and endIndex < 0 then
        endIndex = Utility.SubStringGetTotalIndex(str) + endIndex + 1;
    end

    if endIndex == nil then 
        return str:sub(Utility.SubStringGetTrueIndex(str, startIndex));
    else
        return str:sub(Utility.SubStringGetTrueIndex(str, startIndex), Utility.SubStringGetTrueIndex(str, endIndex + 1) - 1);
    end
end

--获取中英混合UTF8字符串的真实字符数量
function Utility.SubStringGetTotalIndex(str)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat 
        lastCount = Utility.SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(lastCount == 0);
    return curIndex - 1;
end

function Utility.SubStringGetTrueIndex(str, index)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat 
        lastCount = Utility.SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(curIndex >= index);
    return i - lastCount;
end

--返回当前字符实际占用的字符数
function Utility.SubStringGetByteCount(str, index)
    local curByte = str:byte(index)
    local byteCount = 1;
    if curByte == nil then
        byteCount = 0
    elseif curByte > 0 and curByte <= 127 then
        byteCount = 1
    elseif curByte>=192 and curByte<=223 then
        byteCount = 2
    elseif curByte>=224 and curByte<=239 then
        byteCount = 3
    elseif curByte>=240 and curByte<=247 then
        byteCount = 4
    end
    return byteCount;
end

--[[
    将0,1转换为对应的bool型false,true
--]]
function Utility.to_bool(n)
    if n == 0 then
        return false
    elseif n == 1 then
        return true
    else
        return nil
    end
end

-- endregion

function Utility.GetRealFunc(func)
    if type(func) == "string" then
        local sections = Utility.lua_string_split(func, ".")
        if #sections ~= 0 then
            local obj = nil
            for k, v in ipairs(sections) do
                if obj == nil then
                    obj = _G[v]
                else
                    obj = obj[v]
                end
            end
            func = obj;
        else
            func = _G[func];
        end
        return func
    elseif type(func) == "function" then
        return func
    end
end

function Utility.GetRootObjByString(str)
    if type(str) == "string" then
        local sections = Utility.lua_string_split(str, ".")
        if #sections ~= 0 then
            local obj = nil
            for k, v in ipairs(sections) do
                if obj == nil then
                    obj = _G[v]
                else
                    obj = obj[v]
                end
            end
            str = obj;
        else
            str = _G[str];
        end
        return str;
    end
    return str;
end

function Utility.CallFunc(func, parm1, parm2,parm3,parm4,parm5,parm6,parm7,parm8)
    if func == nil then
         app.log("Utility.CallFunc: func is nil."..debug.traceback())
        return
    end

    func = Utility.GetRealFunc(func)

    if func then
        --app.log("Utility.CallFunc"..tostring(func))
        func(parm1, parm2,parm3,parm4,parm5,parm6,parm7,parm8)
    else
        app.log_warning("Utility.CallFunc: "..tostring(func).." is not a function."..debug.traceback())
    end
end


function lua_assert(condition, msg)
    if not condition then
        -- TODO: __asm int 3
        if nil ~= msg then
            app.log(msg)
        end
    end
end

function Utility.ClearObj(t)
     for k, v in pairs(t) do 
         if type(v) == "table" then
             Utility.ClearObj(v)
         end
         
         if type(v) ~= "function" then
             t[k] = nil
         end
     end
end

function Utility.SetUIAdaptation()
    --[[local screen_width = app.get_screen_width();
    local screen_height = app.get_screen_height();
    local x = screen_width/screen_height;
    if 16/9 > x and x > 4/3 then
        y = 0.225 * x + 0.6;
    elseif x <= 4/3 then
        y = 0.9;
    elseif x >= 16/9 then
        y = 1;
    end
    local size = 1/y;--]]
    return 1,1,1;
end

function Utility.Set3dUIAdaptaion()
    local screen_width = app.get_screen_width();
    local screen_height = app.get_screen_height();
    local x = screen_width/screen_height;
    local scale = x * 9 / 16;
    return scale,scale,1;
end

--条件表达式获取默认值 修正获取不到false的问题
function Utility.get_value(val, default_val)
    if val == nil then
        return default_val
    else
        return val
    end
end

--范围内取值（left左边界最小值，right右边界最大值）
function Utility.get_in_range_number(val, left, right)
    if left == nil and right == nil then return val end

    if left == nil then
        return math.min(val, right)
    elseif right == nil then
        return math.max(val, left)
    else
        return math.min(right, math.max(val, left))
    end
end
