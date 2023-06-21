Queue = Class("Queue")
function Queue:Init()
	self.first = 0
	self.last = -1
end

function Queue.push(self, value)
	local last = self.last + 1
	self.last = last
	self[last] = value
end

function Queue.pop(self)
	local first = self.first
	if first > self.last then
		app.log("self is empty")
	end
	local ret = self[first]
	self[first] = nil
	if self.first == self.last then
		self.first = 0
		self.last = -1
	else
		self.first = first + 1
	end
	return ret
end

function Queue.len(self)
	return self.last - self.first + 1
end

function Queue.clear(self)
	for i = self.first, self.last do
		self[i] = nil
	end
	self.first = 0
	self.last = -1
end