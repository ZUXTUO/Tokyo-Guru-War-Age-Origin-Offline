--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/8/14
-- Time: 12:04
-- To change this template use File | Settings | File Templates.
--

--[[物品操作方法集]]

item_manager = {
	imgPadding_list = {}; --[[图片加载填充缓存]]
	imgTemp_list = {}; --[[图片加载回调缓存]]

};
local texture_obj_list = {};  --[[图片对象弱引用表]]
local find_texture_obj = {};
setmetatable(texture_obj_list, {__mode = "k"});

--[[加载图片后进行自动更换纹理]]
function item_manager.texturePadding(texture_obj, file_path, group_name)
	if texture_obj == nil or file_path == nil or file_path == "" then return end;
	local callback = Utility.create_callback_ex(item_manager.textureLoaded,true,4,texture_obj);
	ResourceLoader.LoadTexture(file_path, callback, group_name)
end

--[[图片加载器回调]]
function item_manager.Loaded(pid, filepath, texture_obj, error_info)
	for k,v in pairs(item_manager.imgTemp_list) do
		if v.file_path == filepath then
			local temp = v.callback_list;
			for i=1,table.getn(temp) do
				local callback = temp[i];
				Utility.CallFunc(callback,pid,filepath,texture_obj,error_info)
			end
			table.remove(item_manager.imgTemp_list,k);
			return;
		end
	end
end

--[[图片加载循环]]
function item_manager.textureLoaded(pid, filepath, texture_obj, error_info,obj)
	local game_obj = obj:get_game_object();
    -- game_obj and game_obj.is_nil and
    -- game_obj.is_nil(game_obj)
	if  not game_obj:is_nil() then
		obj:set_texture(texture_obj);
		-- texture_obj_list[obj] = texture_obj;
	end
end

function item_manager.GC()
    -- texture_obj_list = {}
end

-- function item_manager.AddFindTexture(texture,name)
-- 	find_texture_obj[game_obj] = find_texture_obj[game_obj] or {};
-- 	find_texture_obj[game_obj][texture:get_pid()] = texture;
-- end

-- function item_manager.DeleteTextureByGameObj(game_obj)
-- 	if find_texture_obj[game_obj] then
-- 		for k,v in pairs(find_texture_obj[game_obj]) do
-- 			texture_obj_list[v] = nil;
-- 		end
-- 	end
-- end

-- function item_manager.DeleteTextureByFindTexture(texture)
-- 	texture_obj_list[texture] = nil;
-- end