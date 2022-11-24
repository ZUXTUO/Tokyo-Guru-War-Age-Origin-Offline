PerfMon = {
	enabled = false
}


local counters = {}
local names = {}

local function hook()
	local f = debug.getinfo(2, "f").func
	local c = counters[f]
	if c == nil then
		counters[f] = 1
		names[f] = debug.getinfo(2, "Sn")
	else
		counters[f] = c + 1
	end
end

function get_name(f)
	local n = names[f]
	if n.what  == "C" then
		return n.name
	end	

	local lc = string.format("[%s]:%s", n.short_src, n.linedefined)
	if n.namewhat  ~= " " then
		local _name = n.name
		if nil == _name then _name = "_nil_" end
		return string.format("%s (%s)", lc, _name)
	else
		return lc
	end
end

function PerfMon.Show()
	local fileName = os.time()
	local f = io.open("e:\\"..tostring(fileName)..".txt", "w")

	local sorted = {}

	local i = 1
	for k, v in pairs(counters) do
		if v > 1 then --只记录大于一次的
			sorted[i] = {name = k, count = v}
			if sorted[i] == nil then
				app.log(string.foramt("fk:%s:%s", tostring(k), tostring(v)))
			end
			i = i + 1
		end
	end



	table.sort(sorted, function(a,b) 
			return a.count > b.count
		end
	)

	for k, v in ipairs(sorted) do
		if v == nil or v.name == nil or v.count == nil then
			app.log("erro:" .. k)
		else
			local _n = get_name(v.name)
			if nil ~= _n then
				f:write(_n .. ":" ..tostring(v.count))
				f:write("\n")
			else
				-- app.log("nil func: " .. tostring(k))
			end
		end
	end


	f:close()
end

function PerfMon.Start()
	if PerfMon.enabled then
		return false
	end
	counters = {}
	names = {}
	debug.sethook(hook, "c")
	return true
end

function PerfMon.End()
	if not PerfMon.enabled then
		return false
	end 
	debug.sethook() 
	return true
end
