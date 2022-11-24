--管理频繁加载删除的小对象
ObjectPool = Class("ObjectPool")

-- data = 
-- {
-- 	obj=管理的对象（gameobject）
-- 	class=对象包装类
-- }
function ObjectPool:Init(data)
	self.base = data.obj;
	self.class = data.class;
	self.base:set_active(false);
	self.totalNum = 0;
	self.usePool = {};
	self.freePool = {};
	local obj = self.base;
	if self.class then
		obj = self.class:new(self.base);
	end
	obj:set_active(false);
	-- table.insert(self.freePool, obj);
end

function ObjectPool:GetBase()
	return self.base;
end

function ObjectPool:GetObject()
	if self.freePool[1] then		 
		local obj = self.freePool[1];
		table.remove(self.freePool,1);
		table.insert(self.usePool,obj);
		obj:set_active(true);
		return obj;
	else
		--TODO:opt
		local clone_obj = self.base:clone();
		self.totalNum = self.totalNum + 1;
		clone_obj:set_name(self.base:get_name()..self.totalNum);
		local obj;
		if self.class then
			obj = self.class:new(clone_obj);
		else
			obj = clone_obj;
		end
		table.insert(self.usePool,obj);
		obj:set_active(true);
		return obj;
	end
end

function ObjectPool:DestroyObject(obj)
	local k = 0;
	obj:set_active(false);
	for key,object in pairs(self.usePool) do
		if obj == object then
			k = key;
			break;
		end
	end
	if k == 0 then
		app.log("ObjectPool 找不到删除对象"..debug.traceback());
		return;
	end
	table.remove(self.usePool,k);
	table.insert(self.freePool,obj);
end

function ObjectPool:Destroy()
	if self.class then
		for k,v in pairs(self.usePool) do
			v:DestroyUi();
		end
		for k,v in pairs(self.freePool) do
			v:DestroyUi();
		end
	end
	self.usePool = nil;
	self.freePool = nil;
end
