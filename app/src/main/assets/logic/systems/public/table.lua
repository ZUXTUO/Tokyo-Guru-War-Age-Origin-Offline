local _empty_read_only = {}
local _mt = {
	__newindex = function(t, k, v) app.log("试图写入table.empty "..debug.traceback()) end
}
setmetatable(_empty_read_only, _mt)

-- 只读用
function table.empty()
	return _empty_read_only;
end
-- 浅拷贝表结构
function table.copy( t )
	if type(t) ~= "table" then return t end
	local o = {}
	for k,v in pairs(t) do
		o[k] = v
	end
	return o
end
-- 深拷贝表结构
function table.deepcopy( t )
	local lookup_table = {}
    local function _copy(t)
        if type(t) ~= "table" then
            return t
        elseif lookup_table[t] then
            return lookup_table[t]
        end
        local new_table = {}
        lookup_table[t] = new_table
        for index, value in pairs(t) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, _copy(getmetatable(t)))
    end
	
    return _copy(t);
end
-- 浅拷贝表结构数组部分
function table.copyarray( t )
	if type(t) ~= "table" then return t end
	local o = {}
	for k, v in ipairs(t) do
		table.insert(o, v)
	end
	return o
end
-- _n nil 全打
function table.tostring(t,_n)
	if AppConfig.is_format_log == true then 
		return "";
	end 
	if t == nil then return 'table:nil' end
	if type(t) ~= 'table' then return 'table:'..tostring(t) end
	local _t = {}
	--_n = _n or 0
	function _t:_tostring(t,n)
		if _n and n > _n then
			return ''
		end

		self[t] = n
		local str = {}
		local fmt = {}
		n = n or 0
		for i=1,n do
			fmt[#fmt+1] = '  '
		end
		local fmt_str = table.concat(fmt)

		str[#str+1] = tostring(t) ..'{\n'
		if type(t) ~= 'table' then
			app.log('打印表传入的不是表。。'..debug.traceback())
		end
		for k,v in pairs(t) do
			if type(v) == 'table' and not self[v] then
				str[#str+1] = string.format('  %s%s=',fmt_str,tostring(k))
				str[#str+1] = self:_tostring(v,n+1)
			elseif type(v) == 'string' then
				str[#str+1] = string.format("  %s%s='%s'\n",fmt_str,tostring(k),tostring(v))
			else
				str[#str+1] = string.format('  %s%s=%s\n',fmt_str,tostring(k),tostring(v))
			end
		end

		str[#str+1] = fmt_str..'}\n'
		return table.concat(str)
	end
	return _t:_tostring(t,0)
end

function table.tostringEx(t,_n)
	if t == nil then return 'return nil' end
	if type(t) ~= 'table' then return 'return '..tostring(t) end
	local _t = {}
	--_n = _n or 0
	function _t:_tostring(t,n)
		if _n and n > _n then
			return ''
		end

		self[t] = n
		local str = {}
		local fmt = {}
		n = n or 0
		for i=1,n do
			fmt[#fmt+1] = '  '
		end
		local fmt_str = table.concat(fmt)
		if n == 0 then
			str[#str+1] = string.format("return \n{\n",fmt_str)
		else
			str[#str+1] = string.format("\n%s{\n",fmt_str)
		end
		if type(t) ~= 'table' then
			app.log('打印表传入的不是表。。'..debug.traceback())
		end
		for k,v in pairs(t) do
			if type(v) == 'table' and not self[v] then
				if type(k) == 'number' then
					str[#str+1] = string.format('  %s%s=',fmt_str,"["..tostring(k).."]")
				else
					str[#str+1] = string.format('  %s%s=',fmt_str,"['"..tostring(k).."']")
				end
				str[#str+1] = self:_tostring(v,n+1)
			elseif type(v) == 'string' then
				if type(k) == 'number' then
					str[#str+1] = string.format("  %s[%s]='%s',\n",fmt_str,tostring(k),tostring(v))
				else
					str[#str+1] = string.format("  %s%s='%s',\n",fmt_str,tostring(k),tostring(v))
				end
			else
				if type(k) == 'number' then
					str[#str+1] = string.format("  %s[%s]=%s,\n",fmt_str,tostring(k),tostring(v))
				else
					str[#str+1] = string.format("  %s%s=%s,\n",fmt_str,tostring(k),tostring(v))
				end
			end
		end
		if n == 0 then
			str[#str+1] = fmt_str..'}\n'
		else
			str[#str+1] = fmt_str..'},\n'
		end
		return table.concat(str)
	end
	return _t:_tostring(t,0)
end

function table.toLuaString( Data )
	local result = "";
	if Data ~= nil and type( Data ) == "table" then
		local Type = "";
		result = result .. "{";
		for Key, Value in pairs( Data ) do
			Type = type( Value );
			-- 排查方法和
			if Type ~= "function" and Type ~= "userdata" then
				if type( Key ) == "number" then
					result = result .. "[".. Key .. "]";
				else
                    if type(Key) == "string" and Type == "table" then
                        result = result .. "[\'".. Key .. "\']";
                    else
					    result = result .. Key;
                    end
				end
				result = result .. " = ";
				if Type == "string" then
					result = result .. "\'".. Value .. "\'";
				elseif Type == "table" then
					result = result .. table.toLuaString( Value );
				elseif Type == "boolean" then
					if Value == true then
						result = result .. "true";
					else
						result = result .. "false";
					end
				else
					result = result .. Value;
				end
				result = result .. ", ";
			end
		end
		result = result .. "}";
	end
	return result;
end

function table.toFileString( Data )
	local result = "";
	if Data ~= nil and type( Data ) == "table" then
		local Type = "";
		result = result .. "{\n";
		for Key, Value in pairs( Data ) do
			Type = type( Value );
			-- 排查方法和
			if Type ~= "function" and Type ~= "userdata" then
				if type( Key ) == "number" then
					result = result .. "[".. Key .. "]";
				else
                    result = result .. "[\'".. Key .. "\']";
				end
				result = result .. " = ";
				if Type == "string" then
					result = result .. "\'".. Value .. "\'";
				elseif Type == "table" then
					result = result .. table.toFileString( Value );
				elseif Type == "boolean" then
					if Value == true then
						result = result .. "true";
					else
						result = result .. "false";
					end
				else
					result = result .. Value;
				end
				result = result .. ", ";
			end
		end
		result = result .. "\n}";
	end
	return result;
end

-- 删除数组中的nil项, 将后面的数据向前移动
function table.collate(t,k,n)
	k = k or 1
	n = n or #t
	local x = k
	local i = k
	while i<=n do
		if t[i] == nil then
			while i<=n do
				if t[i]~=nil then
					break
				end
				i = i+1
			end
		end
		--print(string.format('t[%d]=t[%d/%d]',x,i,n))
		t[x] = t[i]
		x = x+1
		i = i+1
	end
	for i=x,n do
		t[i] = nil
	end
	
	return t
end

function table.splice(t_out, t_add)
    for k, v in pairs(t_add) do
        if t_out[k] then
            app.log_warning("连接表时出现已存在项,k="..k.." "..debug.traceback())
            -- app.log_warning("连接表时出现已存在项,k="..k.." t_out="..table.tostring(t_out))
        else
            t_out[k] = v
        end
    end
end

function table.getall(data)
	if data == nil 
		then 
		sprint("table.getall data is nil");
	end 
	if(type(data)=="table")
		then
		local num = 0;
		for k, v in pairs(data)
			do
			num = num+1;
		end
		return num;
	else
		sprint("table.getall data is not table");
	end
	return 0;
end

function table.is_contains(t, val)
	if val == nil then
		return true;
	end
	if t == nil then
		return false;
	end
	for _, v_val in pairs(t) do
		if v_val == val then
			return true;
		end
	end
	return false;
end
function table.index_of(t, val)
	if t == nil or val == nil then
		return -1;
	end
	for i, v in ipairs(t) do
		if v == val then
			return i;
		end
	end
	return -1;
end

function table.get_num(t)
    if type(t) ~= 'table' then
        return 0
    end
    local num = 0
    for k,v in pairs(t) do
        num = num + 1
    end
    return num
end

function table.compare_value(t, t1)
    local result = true

    for k, v in pairs(t) do
		if t1[k] ~= v then
			result = false
			break;
		end
	end

	return result;
end

function table.clear_all(t)
	for k, v in pairs(t) do
		t[k] = nil
	end
end

-- 按key大小排序的迭代函数
function pairs_key( t, f )
	local a = {};
	for n in pairs( t ) do a[#a + 1] = n end;
	table.sort( a, f );
	local i = 0;
	return function()
		i = i + 1;
		return a[i], t[a[i]];
	end
end

function table.placeholder_insert_number(t, v)
	table.insert(t, (v or 0))
end

function table.placeholder_insert_string(t, v)
	table.insert(t, (v or ""))
end