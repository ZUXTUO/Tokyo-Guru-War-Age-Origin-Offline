local p = {};

Bezier = p;

p.p0 = {};
p.p1 = {};
p.p2 = {};
p.ax = 0;
p.ay = 0;
p.bx = 0;
p.by = 0;
p.A = 0;
p.B = 0;
p.C = 0;
p.total_length = 0;

p.isLine = false;
p.isHline = false;
p.direction = 0;
p.lineDegree = 0;

function p:new()
	local o = {};
	setmetatable(o,{__index = self});
	return o;
end

function p:s(t)
	return math.sqrt(self.A * t * t + self.B * t + self.C);
end

function p:L(t)
	local temp1 = math.sqrt(self.C + t * (self.B + self.A * t));
	local temp2 = (2 * self.A * t * temp1 + self.B *(temp1 - math.sqrt(self.C)));
	local temp3 = math.log(self.B + 2 * math.sqrt(self.A) * math.sqrt(self.C));
	local temp4 = math.log(self.B + 2 * self.A * t + 2 * math.sqrt(self.A) * temp1);
	local temp5 = 2 * math.sqrt(self.A) * temp2;
	local temp6 = (math.pow(self.B,2) - 4 * self.A * self.C) * (temp3 - temp4);
	return (temp5 + temp6) / (8 * math.pow(self.A, 1.5));
end

function p:getTotalLength()
	local temp1 = math.sqrt(self.C + (self.B + self.A));
	local temp2 = (2 * self.A * temp1 + self.B *(temp1 - math.sqrt(self.C)));
	local temp3 = math.log(self.B + 2 * math.sqrt(self.A) * math.sqrt(self.C));
	local temp4 = math.log(self.B + 2 * self.A + 2 * math.sqrt(self.A) * temp1);
	local temp5 = 2 * math.sqrt(self.A) * temp2;
	local temp6 = (math.pow(self.B,2) - 4 * self.A * self.C) * (temp3 - temp4);
	return (temp5 + temp6) / (8 * math.pow(self.A, 1.5));
end

function p:InvertL(t,l)
	if t == nil then do return 1 end end;
	if l == nil then do return 1 end end;
	local t1 = t;
	local t2 = 0;
	t2 = t1 - (self:L(t1) - l)/self:s(t1);
	local i = 0;
	while math.abs(t1-t2) > 0.01 do
		t1 = t2;
		t2 = t1 - (self:L(t1) - l)/self:s(t1);
		i = i + 1;
		if i > 10 then 
			app.log("break Invert");
			app.log("total_length",self.total_length);
			app.log("step",self.step);
			app.log("A ",self.A);
			app.log("B ",self.B);
			app.log("C ",self.C);
			app.log("t ",t);
			app.log("l ",l);
			app.log("points : "..table.tostring({self.p0,self.p1,self.p2}));
			local temp1 = math.sqrt(self.C + (self.B + self.A));
			local temp2 = (2 * self.A * temp1 + self.B *(temp1 - math.sqrt(self.C)));
			local temp3 = math.log(self.B + 2 * math.sqrt(self.A) * math.sqrt(self.C));
			local temp4 = math.log(self.B + 2 * self.A + 2 * math.sqrt(self.A) * temp1);
			local temp5 = 2 * math.sqrt(self.A) * temp2;
			local temp6 = (math.pow(self.B,2) - 4 * self.A * self.C) * (temp3 - temp4);
			app.log("temp1 ",temp1)
			app.log("temp2 ",temp2)
			app.log("temp3 ",temp3)
			app.log("temp4 ",temp4)
			app.log("temp5 ",temp5)
			app.log("temp6 ",temp6)
			app.log("returnL ",(temp5 + temp6) / (8 * math.pow(self.A, 1.5)))
			app.log("returns ",math.sqrt(self.A * t * t + self.B * t + self.C))
			app.log("t1 ",t1)
			app.log("t2 ",t2)
			break;
		end
	end 
	return t2;
end

function p:init(p0,p1,p2,speed)
	self.p0 = p0;
	self.p1 = p1;
	self.p2 = p2;
	self.isLine = false;
	if math.abs(p0.x - p1.x)<1 and math.abs(p1.x - p2.x)<1 then 
		self.isLine = true;
		self.isHline = false;
		if p0.y < p2.y then 
			self.direction = 2;
		else
			self.direction = 4;
		end 
	elseif math.abs(p0.y - p1.y)<1 and math.abs(p1.y - p2.y)<1 then 
		self.isLine = true;
		self.isHline = true;
		if p0.x < p2.x then 
			self.direction = 1;
		else
			self.direction = 3;
		end 
	else
		local ax = (p1.x - p0.x);
		local ay = (p1.y - p0.y);
		local bx = (p2.x - p1.x);
		local by = (p2.y - p1.y);
		if math.abs(ax*by - ay*bx) < 0.01 then
			self.isLine = true;
			if p1.y > p0.y then 
				if g_distance(p2,p1) == 0 then 
					self.direction = 11;
					self.lineDegree = math.deg(math.acos(((p2.x-p0.x)/g_distance(p2,p0))));
				elseif g_distance(p2,p0) == 0 then 
					self.direction = 12;
				    self.lineDegree = math.deg(math.acos(((p2.x-p1.x)/g_distance(p2,p1))));
				else
					self.direction = 13;
				    self.lineDegree = math.deg(math.acos(((p2.x-p0.x)/g_distance(p2,p0))));
				end
			elseif p1.y < p0.y then 
				if g_distance(p1,p0) == 0 then 
					self.direction = 21;
					self.lineDegree = -math.deg(math.acos(((p2.x-p0.x)/g_distance(p2,p0))));
				elseif g_distance(p2,p1) == 0 then 
					self.direction = 22;
					self.lineDegree = -math.deg(math.acos(((p2.x-p0.x)/g_distance(p2,p0))));
				elseif g_distance(p2,p0) == 0 then 
					self.direction = 23;
				    self.lineDegree = -math.deg(math.acos(((p2.x-p1.x)/g_distance(p2,p1))));
				else
					self.direction = 24;
				    self.lineDegree = -math.deg(math.acos(((p2.x-p0.x)/g_distance(p2,p0))));
				end
			else
			    if g_distance(p2,p0) == 0 then 
					self.direction = 30;
					self.lineDegree = 0;
				else
					if p2.y >= p0.y then 
						self.direction = 31;
						self.lineDegree = math.deg(math.acos(((p2.x-p0.x)/g_distance(p2,p0))));
					else
					    self.direction = 32;
						self.lineDegree = -math.deg(math.acos(((p2.x-p0.x)/g_distance(p2,p0))));
					end
				end 
			end
		end
	end 
	if self.isLine == false then
		self.ax = p0.x - 2 * p1.x + p2.x;
		self.ay = p0.y - 2 * p1.y + p2.y;
		self.bx = 2 * p1.x - 2 * p0.x;
		self.by = 2 * p1.y - 2 * p0.y;
		self.A = 4*(math.pow(self.ax,2) + math.pow(self.ay,2));
		self.B = 4*(self.ax * self.bx + self.ay * self.by);
		self.C = math.pow(self.bx,2) + math.pow(self.by,2);
		--  計算長度
		self.total_length = self:getTotalLength();
	else
		self.total_length = g_distance(p0,p2);
	end
	--  計算步數
	self.step = math.floor(self.total_length / speed);
	if self.total_length % speed > speed / 2 then 
		self.step = self.step + 1 
	end;
	return self.step;
end

function p:getAnchorPoint(nIndex)
	local p0 = self.p0;
	local p1 = self.p1;
	local p2 = self.p2;
	local degrees = 0;
	if nIndex >= 0 and nIndex <= self.step then
		if self.step == 0 then 
			do return nil end;
		end 
		local t = nIndex/self.step;
		local l = t * self.total_length;
		if self.isLine then 
			local tp = g_interpolate(p0,p2,t);
			if self.direction == 1 then 
				degrees = 0;
			elseif self.direction == 2 then
				degrees = 90;
			elseif self.direction == 3 then 
				degrees = 180;
			elseif self.direction == 4 then 
				degrees = 270;
			else
				degrees = self.lineDegree;
			end
			return tp.x,tp.y,degrees;
		else
			t = self:InvertL(t, l);
			local xx = (1 - t) * (1 - t) * p0.x + 2 * (1 - t) * t * p1.x + t * t * p2.x;
			local yy = (1 - t) * (1 - t) * p0.y + 2 * (1 - t) * t * p1.y + t * t * p2.y;
			local Q0 = { 
						x = (1 - t) * p0.x + t * p1.x,
						y = (1 - t) * p0.y + t * p1.y
					   }
			local Q1 = {
						x = (1 - t) * p1.x + t * p2.x, 
						y = (1 - t) * p1.y + t * p2.y
					   }
			
			--  計算角度
			local dx = Q1.x - Q0.x;
			local dy = Q1.y - Q0.y;
			local radians = math.atan2(dy, dx);
			degrees = radians * 180 / math.pi;
			return xx,yy,degrees;
		end 
	else
		return nil;
	end 
end
