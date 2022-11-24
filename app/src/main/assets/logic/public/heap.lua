Heap = Class('Heap',nil,{p = {}})
function Heap:Heap( greater )
	self.push = Heap.push
	self.pop = Heap.pop
	self.erase = Heap.erase
	self.shift_up_ = Heap.shift_up_
	self.shift_down_ = Heap.shift_down_
	self.elem_greater = greater
end
function Heap.elem_greater( a, b) return a and b and a>b end
function Heap:elem_init( e) e.min_heap_idx = -1 end
function Heap:empty() return 0 == #self.p end
function Heap:size() return #self.p end
function Heap:pp() 
	io.write('size:'..#self.p..'--')
	for k,v in pairs(self.p) do 
		if type(v) =='table' then 
			io.write(v.t,',') 
		end 
	end 
	io.write('\n')
end
function Heap:top() return self.p[1] end
function Heap:at( i )
	return self.p[i]
end
function Heap:push(e)
	self:elem_init(e)
	self:erase(e)
	
	self.p[#self.p+1] = e
	self:shift_up_(#self.p, e)
	
	return 0
end
function Heap:pop()
	--print( 'pop ' )
	if #self.p>0 then
		local e = self.p[1]
		self:shift_down_(1, self.p[#self.p])
		e.min_heap_idx = -1
		self.p[#self.p] = nil
		return e
	end
	return nil
end
function Heap:erase(e)
	if e.min_heap_idx>=#self.p or self.p[e.min_heap_idx]~=e then
		return -1
	end
	print( 'erase ' )
	-- n = n-1
	last = self.p[#self.p]
	self.p[#self.p] = nil
	parent = math.floor(e.min_heap_idx / 2)
	--[[
	  we replace e with the last element in the Heap.  We might need to
	shift it upward if it is less than its parent, or downward if it is
	greater than one or both its children. Since the children are known
	to be less than the parent, it can't need to shift both up and
	down.
	]]--
	if e.min_heap_idx > 0 and self.elem_greater(self.p[parent], last) then
		self:shift_up_(e.min_heap_idx, last)
	else
		self:shift_down_(e.min_heap_idx, last)
	end
	e.min_heap_idx = -1
	return 0
end
function Heap:shift_up_(hole_index, e)
	--print( 'shift_up_ '..hole_index )
	parent = math.floor(hole_index/2)
	while hole_index>1 and self.elem_greater(self.p[parent], e) do
		--print( 'shift_up_ '..parent )
		self.p[hole_index] = self.p[parent]
		self.p[hole_index].min_heap_idx = hole_index
		hole_index = parent
		parent = math.floor(hole_index/2)
	end
	--print( string.format('%d = %s',hole_index, tostring(e.t)) )
	self.p[hole_index] = e
	self.p[hole_index].min_heap_idx = hole_index
end
function Heap:shift_down_( hole_index, e)
	min_child = 2*hole_index+1
	while min_child <= #self.p do
		if min_child == #self.p or self.elem_greater(self.p[min_child], self.p[min_child - 1]) then
			min_child = min_child-1
		end

		if (not (self.elem_greater(e, self.p[min_child]))) then
			break
		end
		self.p[hole_index] = self.p[min_child]
		self.p[hole_index].min_heap_idx = hole_index
		hole_index = min_child
		min_child = 2*hole_index+1
	end
	self:shift_up_(hole_index,  e)
end
function Heap:clear()
	local n = #self.p
	for i=1,n do
		self.p[i] = nil
	end
	n = 0
end

return Heap