GObject = Class("GObject")
GObject._id = 0;
function GObject.__CreateID()
	GObject._id = GObject._id + 1
	--app.log("GObject.__CreateID:" .. tostring(GObject._id))
	return GObject._id
end

function GObject:Init(data)
	--	app.log("GObject.new:" .. table.tostring(data))
	self.id = GObject.__CreateID()
	self.go = data.go
	self.resPath = data.resPath
	self.parent = data.parent
	self.last_use_time = app.get_time()
	--app.log(" GObject:Init:new id=" .. tostring(self.id) .. " go=" .. tostring(data.go == nil) .. " resPath=" .. tostring(data.resPath))
end

function GObject:GetId()
	return self.id
end

function GObject:GetGameObject()
	return self.go
end

function GObject:GetParent()
	return self.parent
end

function GObject:SetName(name)
	self.go:set_name(name)
end

function GObject:UpdateUseTime()
	self.last_use_time = app.get_time()
end

function GObject:GetResPath()
	return self.resPath
end

function GObject:SetActive(value)
	if self.go then
		self.go:set_active(value)
	end
end


ObjectGroupManager = { }

ObjectGroupManager._AssetPool = {
--[[
[resPath] = asset_game_obj
]]
}-- 资源存放
ObjectGroupManager._GameObjectPool = {
--[[
[resPath] = {
[id] = go
}
]]
}-- GameObject对象
ObjectGroupManager._UsedGameObject = {
--[[
[resPath] = {
[id] = {
go = nil,
time = nil,
p_go = nil,
}
}
]]
}
ObjectGroupManager._GameObjectTemplete = 
{
--[[
[resPath] = go 
]]	
}
ObjectGroupManager._CallBack = { }
ObjectGroupManager._ResType = {}


function ObjectGroupManager.__AddToUse(gObject)
	if ObjectGroupManager._UsedGameObject[gObject.resPath] == nil then
		ObjectGroupManager._UsedGameObject[gObject.resPath] = { }
	end
	ObjectGroupManager._UsedGameObject[gObject.resPath][gObject.id] = gObject
	ObjectGroupManager._GameObjectPool[gObject.resPath][gObject.id] = nil
end


function ObjectGroupManager.__AddToGameObjectPool(fpath, go, parent)
	if ObjectGroupManager._GameObjectPool[fpath] == nil then
		ObjectGroupManager._GameObjectPool[fpath] = { }
	end
	-- app.log(string.format("ObjectGroupManager:__AddToGameObjectPool：fpath=%s,gameObject=%s",fpath,go==nil))
	local gObject = GObject:new( { resPath = fpath, go = go, parent = parent })
	ObjectGroupManager._GameObjectPool[fpath][gObject:GetId()] = gObject

	if ObjectGroupManager._GameObjectTemplete[fpath] == nil then
		ObjectGroupManager._GameObjectTemplete[fpath] = {go, parent}
	end
end

function ObjectGroupManager.__GetGameObject(resPath)
	if ObjectGroupManager._GameObjectPool[resPath] then
		local _, gObject = next(ObjectGroupManager._GameObjectPool[resPath])
		return gObject
	end
	-- app.log(" ObjectGroupManager.__GetGameObject:nil " .. resPath)
	return nil
end

function ObjectGroupManager.Init()
	if nil == ObjectGroupManager._CallBack then
		ObjectGroupManager._CallBack = { }
	end
	Root.AddUpdate(ObjectGroupManager.Update)
end

function ObjectGroupManager.CreateChilds(resPath)
	local asset_obj = ObjectGroupManager._AssetPool[resPath]
	local obj = asset_game_object.create(asset_obj)
   --app.log("ObjectGroupManager.CreateChilds resPath=" .. resPath .. " obj=" .. tostring(obj))

	local type = ObjectGroupManager._ResType[resPath]
	if type ~= 1 then -- 场景中的物体不能放在ui下
		obj:set_parent(Root.get_root_ui_2d_fight())
	end
	obj:set_local_scale(1, 1, 1);
	local child_objs = obj:get_childs()
	local count = 0;
	if child_objs then
		for _, go in pairs(child_objs) do
			count = count + 1
			 --app.log("ObjectGroupManager.GetGameObject CreateChilds resPath=" .. resPath .. " go=" .. tostring(go == nil))
			go:set_active(false)
			ObjectGroupManager.__AddToGameObjectPool(resPath, go, obj)
		end
	end 
	 --app.log("ObjectGroupManager.GetGameObject create_objs " .. table.tostring(ObjectGroupManager._GameObjectPool))
	return count
end

-- 创建一个资源分组
-- @param resPath assetbundle path
-- @param create_obj_callback 创建回调 function(resPath,id,gameobject)
-- @param 1 sence, other ui type
function ObjectGroupManager.GetGameObject(resPath, create_obj_callback, resType)
	if resPath == nil then
		--app.log_warning("ObjectGroupManager.GetGameObject resPath is nil")
		return
	else
		--app.log("ObjectGroupManager.GetGameObject resPath" .. resPath)
	end
	
	if ObjectGroupManager._CallBack[resPath] == nil then
		ObjectGroupManager._CallBack[resPath] = Queue:new()
	end
	--app.log("ObjectGroupManager._CallBack "..tostring(ObjectGroupManager._CallBack[resPath]:len()))
	ObjectGroupManager._CallBack[resPath]:push( { resPath = resPath, func = create_obj_callback })
	ObjectGroupManager._ResType[resPath] = resType
end

function ObjectGroupManager.ExcuteFunc(resPath, gObject)
	if ObjectGroupManager.HasNextFunc(resPath) then
		local nData = ObjectGroupManager._CallBack[resPath]:pop()
		ObjectGroupManager.__AddToUse(gObject)
		-- gObject:SetName(tostring(gObject.id))
		gObject:SetActive(true)
		nData.func(gObject)
		gObject:UpdateUseTime()
		return true
	end
	return false
end


function ObjectGroupManager.HasNextFunc(resPath)
	if not resPath then
		return false
	end
	local funcs = ObjectGroupManager._CallBack[resPath]
	if not funcs then
		ObjectGroupManager._CallBack[resPath] = Queue:new()
		return false
	end
	return ObjectGroupManager._CallBack[resPath]:len() > 0
end

function ObjectGroupManager.GetNextPath()
	local resPath, funcs = next(ObjectGroupManager._CallBack)
	if funcs and funcs:len() <= 0 then
		ObjectGroupManager._CallBack[resPath] = nil
		return nil
	end
	return resPath
end

function ObjectGroupManager.Update()
	local resPath = ObjectGroupManager.GetNextPath()
	if  resPath == nil or not ObjectGroupManager.HasNextFunc(resPath)  then
		--app.log("ObjectGroupManager.Update not next func "..tostring(resPath))
		return
	end
	--app.log("next Update "..resPath)
	local gObject = ObjectGroupManager.__GetGameObject(resPath)
	if gObject then
		ObjectGroupManager.ExcuteFunc(resPath, gObject)
	else
		local asset_obj = ObjectGroupManager._AssetPool[resPath]
		if asset_obj then
			local suc = false
			local template = ObjectGroupManager._GameObjectTemplete[resPath]
			if template then
				suc = true
				for i=1, 5 do
					local go = template[1]:clone()
					local parent = template[2]
					go:set_active(false)
					--app.log("#hyg#ObjectGroupManager.Update template " .. go:get_name() .. ' ' .. parent:get_name())
					ObjectGroupManager.__AddToGameObjectPool(resPath, go, parent)
				end
			else
				local create_count = ObjectGroupManager.CreateChilds(resPath, asset_obj)
				suc = create_count > 0
			end

			
			if suc then
				local gObject = ObjectGroupManager.__GetGameObject(resPath)
				if gObject then
					ObjectGroupManager.ExcuteFunc(resPath, gObject)
				end
			end
		else
			if not ResourceManager.IsLoading(resPath) then
				ResourceLoader.LoadAsset(resPath, function(pid, fpath, asset_obj, error_info)
				    --app.log(string.format("#ObjectGroupManager.GetGameObject# load_callback fpath=%s error_info=%s", fpath, tostring(error_info)))
					if fpath == resPath then
						-- local obj = asset_game_object.create(asset_obj)
						ObjectGroupManager._AssetPool[resPath] = asset_obj
					end
				end )
			end
		end
	end
end

function ObjectGroupManager.GetGObject(id)
	
	for k,v in pairs(ObjectGroupManager._GameObjectPool) do
		for kk,vv in pairs(v) do
			if vv:GetId()== id then
				return vv
			end
		end
	end
	for k,v in pairs(ObjectGroupManager._UsedGameObject) do
		for kk,vv in pairs(v) do
			if vv:GetId()== id then
				return vv
			end
		end
	end
end

function ObjectGroupManager.UnUse(gObject)
	-- app.log("ObjectGroupManager.UnUse:"..table.tostring(gObject))
	local doUnUse = function(gObject)
		ObjectGroupManager._GameObjectPool[gObject.resPath][gObject:GetId()] = gObject
		ObjectGroupManager._UsedGameObject[gObject.resPath][gObject:GetId()] = nil
		gObject:SetActive(false)
	end
	if type(gObject) == "number" then
		local obj = ObjectGroupManager.GetGObject(gObject)
		if obj then
			doUnUse(obj)
		end
		
	else
		if gObject then
			doUnUse(gObject)
		end
	end
end


function ObjectGroupManager.Clear(resPath) 
	ObjectGroupManager._AssetPool[resPath] = nil
	local gameObjects = ObjectGroupManager._GameObjectPool[resPath] 
	if gameObjects then
		for k,v in pairs(gameObjects) do
			v.parent:set_active(false)
		end
	end
	ObjectGroupManager._GameObjectPool[resPath] = nil
	gameObjects = ObjectGroupManager._UsedGameObject[resPath]
	if gameObjects then
		for k,v in pairs(gameObjects) do
			if v.parent then
				v.parent:set_active(false)
			end
		end
	end
	ObjectGroupManager._UsedGameObject[resPath] = nil
	if ObjectGroupManager._CallBack[resPath] then
		ObjectGroupManager._CallBack[resPath]:clear()
	end
end

function ObjectGroupManager.ClearAll()
	local all_paths = {}
	local _AssetPool = ObjectGroupManager._AssetPool
	local contain_key = function(t,key)
		if nil == t or type(t)~="table" then return false end
		for k,v in pairs(t) do
			if k == key then
				return true
			end
		end
		return false
	end
	for k,v in pairs(_AssetPool) do
		if not contain_key(all_paths) then
			all_paths[k]  = true
		end
	end
	for k,v in pairs(all_paths) do
		ObjectGroupManager.Clear(k)
	end

	ObjectGroupManager._GameObjectTemplete = {}
end


OGM = ObjectGroupManager