BezierPointBuffer = {};

BezierPointBuffer.bezier = nil;

BezierPointBuffer.pathList = nil;

BezierPointBuffer.bufferSize = 0;

function BezierPointBuffer:new()
	local o = {};
	setmetatable(o,{__index = self});
	o.bezier = Bezier:new();
	o.pathList = {};
	o.bufferSize = 0;
	return o;
end

function BezierPointBuffer:createPath(pathPoints,speed)
	local curIndex = 1;
	local len = table.maxn(pathPoints);
	table.insert(pathPoints,pathPoints[len]);
	table.insert(pathPoints,1,pathPoints[1]);
	len = table.maxn(pathPoints);
	local i = 1;
	local path = {};
	local p = nil;
	local pc1 = nil;
	local pc2 = nil;
	while curIndex < len-1 do
		pc1 = g_interpolate(pathPoints[curIndex],pathPoints[curIndex+1],0.5);
		pc2 = g_interpolate(pathPoints[curIndex+1],pathPoints[curIndex+2],0.5);
		self.bezier:init(pc1,pathPoints[curIndex+1],pc2,speed);
		local pi = 0;
		if curIndex ~= 1 then 
			pi = 1;
		end 
		local _x,_y,_deg = self.bezier:getAnchorPoint(pi);
		while _x ~= nil do
			p = {x = _x,y = _y,deg = _deg};
			path[i] = p;
			i = i + 1;
			pi = pi + 1;
			_x,_y,_deg = self.bezier:getAnchorPoint(pi);
		end 
		curIndex = curIndex + 1;
	end
	self.bufferSize = self.bufferSize + 1;
	self.pathList[self.bufferSize] = path;
	return path,self.bufferSize;
end

function BezierPointBuffer:createRandomPath(pointNum,speed)
	local sw,sh = app.get_screen_width(),app.get_screen_height();
	local i = 0;
	local points = {};
	for i = 1,pointNum do 
		local p = {x = math.random(sw),y = math.random(sh)};
		points[i] = p;
	end 
	return self:createPath(points,speed);
end

function BezierPointBuffer:loadBufferPath(index)
	if index ~= nil then 
		return self.pathList[index];
	else
		index = math.ceil(math.random(self.bufferSize));
		return self.pathList[index];
	end 
end
