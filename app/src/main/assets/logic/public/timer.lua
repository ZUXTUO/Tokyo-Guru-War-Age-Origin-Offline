script.run "logic/public/heap.lua"

g_currentTime = 0
local h = Heap:new(function(a,b)
						return a and b and a.time>b.time
					end)

function SetTimer( t, n, fun, p1,p2 )
	local o ={}
	o.num = n
	o.fun = fun
	o.dt = t
	o.time = t+os.clock()
	o.p1 = p1
	o.p2 = p2
	h:push(o)
end

function UpdateTimer(t)
	for i=1,100 do
		x = h:top()
		if not x or x.time>os.clock() then
			break
		end
		h:pop()
		if x.fun then
			if x.p1 and x.p2 then x.fun(x.p1,x.p2,x.time)
			elseif x.p1 then x.fun(x.p1,x.time)
			else x.fun(x.time) end
		end
		if x.num>1 then
			x.num = x.num - 1
			x.time = x.dt + os.clock()
			h:push(x)
		elseif x.num<0 then
			x.time = x.dt + os.clock()
			h:push(x)
		end
	end
end
