-- region class.lua
-- Author : kevin
-- Date   : 2014/11/12
-- Change : dc
--[[
function: Class
@className: debug info.
@base: base class
@data: extra field of new class.
]]--

function Class(className, base, data)
	c = data or { }
	if base then
		setmetatable(c, { __index = base} )
	end
    c._className = className or 'class-' .. tostring(c)
	c._super = base
    --
    --function c:new
    --@o:
    --@p: parm
    --
	function c:__super( )
		local m = getmetatable(self)
		return m.__index
	end
	function c:new_with(o,p)
		setmetatable(o, { __index = self}  )
        
		if rawget(self,'_constructor') == nil then			
			
			self._constructor = {}
			local base_table = { }
			local c = self
			while(c) do
				table.insert(base_table,c)
				c = c._super
			end

			for k=#base_table,1,-1 do
				local cc = base_table[k]
				if cc[cc._className] then
					table.insert(self._constructor,cc[cc._className])
				end
			end
		end

		for k,v in pairs(self._constructor) do
			v(o,p)
		end

		--TODO: 每一级的init执行问题。
        if type(o.Init) == "function" then
        	o:Init(p)
        end

        return o
    end
	function c:new(p)
		if not self.new_with then
			app.log('new_with is empty!'..debug.traceback())
		end
		return self:new_with({},p)
	end
    return c
end
function new(C,param)
	return C:new(param)
end
function new_with(C,t,param)
	return C:new_with(t,param)
end
function delete( obj )
	local mt = getmetatable(obj)
	if mt == nil then
		return app.log_warning('delete '..table.tostring(obj))
	end
	local c = mt.__index
	while c do
		if type(c.Finalize) == "function" then
			c.Finalize(obj)
		end
		c = c._super
	end
	obj = nil
end