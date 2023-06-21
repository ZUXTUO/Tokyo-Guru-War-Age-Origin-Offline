DragCycleGroup = Class("DragCycleGroup");

DragCycleGroupType = {
	Cycle = 1;
	List = 2;
	RList = 3;
}

function DragCycleGroup:Init(data)
	data = data or { };
	self.bindfunc = {};
	self:registFunc();
	self:initData(data)
	--self:initUI(data.obj);
end

function deg2rad( a )
    return (a%360)/360*2*math.pi
end

function DragCycleGroup:initData(data)
	self.type = data.type or DragCycleGroupType.Cycle;
	self.raid = data.raid or 0;
	self.showNum = data.showNum or 0;
	self.offsetAngle = data.offsetAngle or 0;
	self.itemClickCall = data.itemClickCall;
	self.updateItemCall = data.updateItemCall;
	self.stopMoveCall = data.stopMoveCall;
	self.startMoveCall = data.startMoveCall;
	self.maxNum = data.maxNum;
	self.baseItem = data.baseItem;
	self.touchSp = data.touchSp;
	self.farScale = data.farScale or 0.5;
	self.nearScale = data.nearScale or 1;
	self.canDrag = true;
	self.x = data.x or 0;
	self.y = data.y or 0;
	self.touchDir = 0;
	self.dragMult = data.dragMult or 0;
	local i = 0;
	self.itemList = {};
	if self.raid == 0 and self.showNum == 0 and self.type == DragCycleGroupType.List and self.baseItem ~= nil and self.touchSp ~= nil then 
		local obj = self.baseItem;
		local sp = ngui.find_widget(obj,self.baseItem:get_name())
		local sw,sh = sp:get_size();
		local lw,lh = self.touchSp:get_size();
		if self.touchDir == 0 then 
			self.showNum = math.ceil(lw/sw)+1;
			self.angleSpace = 360/self.showNum;
			local as = deg2rad(self.angleSpace);
			self.raid = sw/as * 2;
			self.offsetAngle = -(lw-sw)/self.raid/math.pi * 180; 
			self.angleMin = -self.angleSpace * (self.maxNum-lw/sw);
		end 
	--[[else
		app.log("圆圈循环列表收到了错误的初始化信息，所以初始化失败");
		do return end; --]]
	end 
	if data.itemList ~= nil then  
		self.angleSpace = 360/#data.itemList;
		self.showNum = #data.itemList;
		for i = 1,#data.itemList do 
			local clickSp = nil;
			clickSp = ngui.find_button(data.itemList[i],data.itemList[i]:get_name());
			clickSp:set_on_ngui_drag_start(self.bindfunc["on_drag_start"]);
			clickSp:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
			clickSp:set_on_ngui_drag_end(self.bindfunc["on_drag_end"]);
			table.insert(self.itemList,{obj = data.itemList[i],startAngle = (i-1)*self.angleSpace });
		end
	else
		self.baseItem = data.baseItem;
		self.baseItem:set_active(false);
		self.angleSpace = 360/self.showNum;
		for i = 1,self.showNum do 
			local obj = self.baseItem:clone();
			local clickSp = nil;
			clickSp = ngui.find_button(obj,obj:get_name());
			clickSp:set_on_ngui_drag_start(self.bindfunc["on_drag_start"]);
			clickSp:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
			clickSp:set_on_ngui_drag_end(self.bindfunc["on_drag_end"]);
			table.insert(self.itemList,{obj = obj,startAngle = (i-1)*self.angleSpace })
		end
	end 
	if self.type == DragCycleGroupType.Cycle then 
		self.angleMin = -self.angleSpace * (self.maxNum-1);
		self.angleMax = 0
	else
		self.angleMax = 0 
		
		if self.maxNum < self.showNum - 1 then 
			self.angleMin = self.angleMax;
		else 
			if self.angleMin == nil then 
				self.angleMin = -self.angleSpace * (self.maxNum - 1)
			end 
		end
	end 
	if self.touchSp ~= nil then 
		self.touchSp:set_on_ngui_drag_start(self.bindfunc["on_drag_start"]);
		self.touchSp:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
		self.touchSp:set_on_ngui_drag_end(self.bindfunc["on_drag_end"]);
		self.touchSp:set_on_ngui_click(self.bindfunc["on_click"]);
	end 
	
	self.angle = 0;
	self:set_angle(self.angle);
end

function DragCycleGroup:set_maxNum(maxNum)
	self.maxNum = maxNum;
	self.angleMin = -self.angleSpace * (self.maxNum-1);
	self.angleMax = 0
	local targetAngle;
	local function updateAngle()
		self:set_angle();
	end
	if maxNum <= 1 then
		self.canDrag = false;
	else
		self.canDrag = true;
	end
	if self.angle > self.angleMax then 
		targetAngle = self.angleMax;
		Tween.addTween(self,0.5,{ angle = targetAngle},Transitions.EASE_OUT,0,nil,updateAngle);
	elseif self.angle < self.angleMin then 
		targetAngle = self.angleMin;
		Tween.addTween(self,0.5,{ angle = targetAngle},Transitions.EASE_OUT,0,nil,updateAngle);
	else 
		self:set_angle();
	end
	--app.log("angle = "..tostring(targetAngle));
	--self:set_angle(self.angle);
end 

function DragCycleGroup:registFunc()
	self.bindfunc["on_drag_start"] = Utility.bind_callback(self, self.on_drag_start)
	self.bindfunc["on_drag_end"] = Utility.bind_callback(self, self.on_drag_end)
	self.bindfunc["on_drag_move"] = Utility.bind_callback(self, self.on_drag_move)
	self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click)
	self.bindfunc["drag_item"] = Utility.bind_callback(self, self.drag_item)
end

function DragCycleGroup:drag_item()
	return false;
end 

function DragCycleGroup:unregistFunc()
	for k, v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v);
		end
	end
end 

function DragCycleGroup:set_angle(a)
	a = a or self.angle;
	local curAngle = 0;
	local lastAngle = 0;
	local pos = 0;
	local px = 0;
	local gameObj = nil;
	local scaleZ = 0;
	local index;
	local len;
	local wg;
	local w,h;
	local depth;
	local color;
	local lineScale;
	local angleShift;
	local checkAngle;
	if self.type == DragCycleGroupType.Cycle then 
		for k,v in pairs(self.itemList) do 
			curAngle = v.startAngle + a;
			px = self.raid * math.sin(deg2rad(curAngle)) + self.x;
			scaleZ = (1+math.cos(deg2rad(curAngle))) / 2
			scale = (self.nearScale - self.farScale)* scaleZ + self.farScale;
			depth = math.floor(scale*100);
			color = math.max((scale - self.farScale)/(self.nearScale - self.farScale),0.01);
			if self.updateItemCall and _G[tostring(self.updateItemCall)] then 
				_G[self.updateItemCall](v.obj,0,px,depth,scale,color);
			end
		end 
	elseif self.type == DragCycleGroupType.List then 
		for k,v in pairs(self.itemList) do 
			curAngle = v.startAngle + a ;
			len = self.raid * deg2rad(curAngle + self.offsetAngle) ;
			if len < math.pi * self.raid then 
				px = len/2;
			else
				px = -(math.pi * self.raid * 2 - len)/2;
			end 
			index = -math.floor((curAngle + self.offsetAngle + 180)/360) * self.showNum + k;
			angleShift = 180 - self.offsetAngle;
			checkAngle = (curAngle) % 360;
			if checkAngle >= angleShift then 
				lineScale = (checkAngle - angleShift)/(360 - angleShift);
			else 
				lineScale = (angleShift - checkAngle)/angleShift;
			end 
			scale = (self.nearScale - self.farScale)* lineScale + self.farScale;
			depth = math.floor(lineScale * 100);
			color = math.max(lineScale,0.01);
			if self.updateItemCall and _G[tostring(self.updateItemCall)] then 
				_G[self.updateItemCall](v.obj,index,px,depth,scale,color,lineScale);
			end
		end
	elseif self.type == DragCycleGroupType.RList then 
		for k,v in pairs(self.itemList) do 
			curAngle = v.startAngle + a ;
			scaleZ = (1+math.cos(deg2rad(curAngle))) / 2
			index = -math.floor((curAngle + self.offsetAngle + 180)/360) * self.showNum + k;
			angleShift = 180 - self.offsetAngle;
			local sr = self.raid * deg2rad(angleShift);
			local sl = self.raid * deg2rad(360 - angleShift);
			checkAngle = (curAngle) % 360;
			if checkAngle >= angleShift then 
				lineScale = (checkAngle - angleShift)/(360 - angleShift);
				px = -sl/2.5 * (1 - math.pow(lineScale,2));
			else 
				lineScale = (angleShift - checkAngle)/angleShift;
				px = sr/2.5 * (1 - math.pow(lineScale,2));
			end 
			depth = math.floor(lineScale * 100);
			scale = (self.nearScale - self.farScale)* lineScale + self.farScale;
			color = math.max(lineScale,0.01);
			if self.updateItemCall and _G[tostring(self.updateItemCall)] then 
				_G[self.updateItemCall](v.obj,index,px,depth,scale,color,lineScale);
			end
		end
	end
	self.lastAngle = a;
end

function DragCycleGroup:set_type(type)
	self.type = type;
	self:set_angle(self.angle);
end 

function DragCycleGroup:set_offsetAngle(angle)
	self.offsetAngle = angle;
	app.log("set_offsetAngle"..tostring(angle)..",offsetAngle = "..tostring(self.offsetAngle));
	self:set_angle(self.angle);
end 

function DragCycleGroup:get_pid()
	self.pid = self.pid or "lua"..tostring(math.random(10000000,99999999));
	return self.pid;
end 

function DragCycleGroup:on_drag_start( name, x, y, go_obj )
	if not self.canDrag then return end;
	self.sAngle = self.angle;
	self.sx = x;
	Utility.CallFunc(self.startMoveCall);
end

function DragCycleGroup:on_drag_move( name, x, y, go_obj )
	if not self.canDrag then return end;
	local disAngle = (x - self.sx)/2 * (1+self.dragMult);
	local targetAngle = disAngle + self.sAngle;
	if targetAngle < self.angleMin then 
		targetAngle = (self.angleMin - 60*(1 - math.pow(0.95,(self.angleMin - targetAngle)/5)));
	end 
	if targetAngle > self.angleMax then 
		targetAngle = (self.angleMax + 60*(1 - math.pow(0.95,(targetAngle - self.angleMax)/5)));
	end 
	local function updateAngle()
		self:set_angle(self.angle);
	end
	Tween.addTween(self,0.5,{ angle = targetAngle},Transitions.EASE_OUT,0,nil,updateAngle);
end

function DragCycleGroup:on_drag_end( name, x, y, go_obj )
	if not self.canDrag then return end;
	local disAngle = (x - self.sx)/2 * (1+self.dragMult);
	local targetAngle = disAngle + self.sAngle;
	local index = 0;
	if disAngle < 0 then 
		targetAngle = math.floor(targetAngle/self.angleSpace) * self.angleSpace;
	else
		targetAngle = math.ceil(targetAngle/self.angleSpace) * self.angleSpace; 
	end 
	if index < 0 then 
		index = 0;
	end 
	if index > self.maxNum then 
		index = self.maxNum;
	end 
	if targetAngle < self.angleMin then 
		targetAngle = self.angleMin;
	end 
	if targetAngle > self.angleMax then 
		targetAngle = self.angleMax;
	end 
	index = math.floor(-targetAngle/self.angleSpace + 1);
	local flg = true;
	local function updateAngle(progress)
		self:set_angle(self.angle);
		if progress >= 0.8 and flg then
			if self.stopMoveCall ~= nil and _G[tostring(self.stopMoveCall)] ~= nil then 
				_G[self.stopMoveCall](index);
			end
			flg = false;
		end
	end
	--app.log("angle = "..tostring(targetAngle));
	Tween.addTween(self,0.5,{ angle = targetAngle},Transitions.EASE_OUT,0,nil,updateAngle);
end

function DragCycleGroup:set_index(index)
	if index > self.maxNum then 
		index = self.maxNum ;
	end 
	local targetAngle = -self.angleSpace * (index - 1);
	if targetAngle < self.angleMin then 
		targetAngle = self.angleMin;
	end 
	if targetAngle > self.angleMax then 
		targetAngle = self.angleMax;
	end 
	--app.log("index:"..tostring(index).."angleSpace:"..tostring(self.angleSpace)..",targetAngle:"..tostring(targetAngle)..",angleMin:"..tostring(self.angleMin)..",angleMax:"..tostring(self.angleMax));
	self:set_angle(targetAngle);
	self.angle = targetAngle;
end 

function DragCycleGroup:tweenToIndex(index)
	if index > self.maxNum then 
		index = self.maxNum ;
	end 
	local targetAngle = -self.angleSpace * (index - 1);
	if targetAngle < self.angleMin then 
		targetAngle = self.angleMin;
	end 
	if targetAngle > self.angleMax then 
		targetAngle = self.angleMax;
	end 
	--app.log("index:"..tostring(index).."angleSpace:"..tostring(self.angleSpace)..",targetAngle:"..tostring(targetAngle)..",angleMin:"..tostring(self.angleMin)..",angleMax:"..tostring(self.angleMax));
	local flg = true;
	local function updateAngle(progress)
		self:set_angle(self.angle);
		if progress >= 0.8 and flg then
			if self.stopMoveCall ~= nil and _G[tostring(self.stopMoveCall)] ~= nil then 
				_G[self.stopMoveCall](index);
			end
			flg = false;
		end
	end
	local time = math.abs(self.angle - targetAngle )/360 * 0.2;
	Tween.addTween(self,time,{ angle = targetAngle},Transitions.EASE_OUT,0,nil,updateAngle);
end 

function DragCycleGroup:on_click( name , x , y , go_obj )
	local str = "";
	for k,v in pairs(self.itemList) do 
		local wg = ngui.find_widget(v.obj,v.obj:get_name());
		local width,height = wg:get_size();
		local sx,sy,sz = v.obj:get_local_scale();
		str = str.."self.itemList["..tostring(k).."].obj:get_local_scale = "..tostring(sx)..","..tostring(sy)..","..tostring(sz).."\n";
		str = str.."self.itemList["..tostring(k).."].obj:get_size = "..tostring(width)..","..tostring(height).."\n";
	end
	app.log(str);
end 

function DragCycleGroup:destroy_object()
	self:unregistFunc();
	self.baseItem = nil;
	self.touchSp:set_on_ngui_drag_start("");
	self.touchSp:set_on_ngui_drag_move("");
	self.touchSp:set_on_ngui_drag_end("");
	self.touchSp = nil;
--[[	for k,v in pairs(self.itemList) do 
		v.obj:destroy_object();
		v.obj = nil;
	end--]]
	self.itemList = nil;
end