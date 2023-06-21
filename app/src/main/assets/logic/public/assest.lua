--[[Asset = Class("Asset")

local bindID = 0
Asset.BindAssetCallBack = function( cb, key)
	bindID = bindID + 1	

	local name = 'on_asset_load_bin_'..bindID
	
	local fn = function(parm1, parm2, parm3, parm4, parm5, parm6)
		--_G[name] = nil
		if key then
			return cb(key,parm1, parm2, parm3, parm4, parm5, parm6)
		else
			return cb(parm1, parm2, parm3, parm4, parm5, parm6)
		end
    end;	
    
    _G[name] = fn
	return name
end
function Asset:Asset( name )
	self.loader = asset_loader.create( name or "asset_load")
end
function Asset:Finalize()
	self.loader = nil
end
function Asset:Load( res, cb, key )
	if type(cb) == 'function' then
		self.loader:set_callback(Asset.BindAssetCallBack(cb,key))
	else
		self.loader:set_callback(cb)
	end
	self.loader:load(res)
end

return Asset]]