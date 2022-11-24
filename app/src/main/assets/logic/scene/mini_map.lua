--
-- Created by IntelliJ IDEA.
-- User: PoKong_GH
-- Date: 2015/5/28
-- Time: 15:58
-- To change this template use File | Settings | File Templates.
--
local ResPath = "assetbundles/prefabs/ui/fight/map.assetbundle";

mini_map = {};

mini_map.main_obj = nil;--[[主OBJ]]
mini_map.main_com = nil;--[[组件]]
mini_map.main_bk_sprite = nil;--[[背景sprite]]
mini_map.main_bk_load = "";--[[加载图片]]
mini_map.main_bk_name = "";--[[使用的图片]]
mini_map.main_bk_atlas = nil;--[[动态图集]]
mini_map.obj_list = {};
mini_map.main_player = nil;--[[当前小地图主角]]

function mini_map.Destroy()
	mini_map.del_all_obj();
	mini_map.is_show(false);
	mini_map.main_bk_sprite = nil;--[[背景sprite]]
	mini_map.main_bk_load = "";--[[加载图片]]
	mini_map.main_bk_name = "";--[[使用的图片]]
	mini_map.main_bk_atlas = nil;--[[动态图集]]
	mini_map.main_obj  = nil;
	mini_map.main_com = nil;
	mini_map.main_player = nil;--[[当前小地图主角]]
end

--[[初始化]]
function mini_map.init()
    ResourceLoader.LoadAsset(ResPath, mini_map.OnLoaded, nil)
end

function mini_map.OnLoaded(pid, filepath, asset_obj, error_info)
	if filepath ~= ResPath then return end;
	mini_map.main_obj = asset_game_object.create(asset_obj);
	mini_map.main_obj:set_name("mini_map");
	mini_map.main_obj:set_parent(Root.get_root_ui_2d_fight());
    mini_map.main_obj:set_local_scale(1,1,1);

    local  btn = ngui.find_button(mini_map.main_obj,"btn");
    btn:set_on_click("mini_map.onBack");

    local map = asset_game_object.find("mini_map/MiniMapWin");
    mini_map.main_com = component.get_component_mini_map(map);
    mini_map.main_bk_sprite = ngui.find_sprite(mini_map.main_obj, "Win/Mask/Map");
    --mini_map.main_com:set_rotate(false);

    --[[例]]
	mini_map.set_win_size(300,200);
	mini_map.set_scene_size(120,80);
	mini_map.set_mini_map_size(300,200);
	mini_map.set_scene_origin(0,0);
	mini_map.is_show_bk(false);
end

function mini_map.onBack()
	if FightMap.main then
		FightMap.change_bk("assetbundles/prefabs/ui/image/minimap/bk_003.png","bk_003");
		FightMap.Show(true);
	end
end

--[[小地图显示]]
function mini_map.is_show(is_show)
	if mini_map.main_obj == nil then return end;
	mini_map.main_obj:set_active(is_show);
end

--[[小地图背景显示]]
function mini_map.is_show_bk(is_show)
	if mini_map.main_bk_sprite == nil then return end;
	mini_map.main_bk_sprite:set_active(is_show);
end

--[[更换地图背景
-- str_load  加载图片地址  assetbundles/prefabs/ui/image/minimap/xiaoditu.png
-- str_name 更换图集名
-- ]]
function mini_map.change_bk(str_load,str_name)
	if mini_map.main_obj == nil then return end;
	if str_load == nil or str_load == "" or str_name == nil or str_name == "" then return end;
	mini_map.main_bk_load = str_load;
	mini_map.main_bk_name = str_name;
	ResourceLoader.LoadTexture(mini_map.main_bk_load, mini_map.png_load);
end
function mini_map.png_load(pid, filepath, texture_obj, error_info)
	ngui_atlas.add_texture(texture_obj);
	mini_map.main_bk_atlas = ngui_atlas.create_by_textures_with_shader(1,"Unlit/Transparent Colored");
	mini_map.main_bk_sprite:set_sprite_atlas(mini_map.main_bk_atlas);
	mini_map.main_bk_sprite:set_sprite_name(mini_map.main_bk_name);
	mini_map.is_show_bk(true);
end

--[[查看是否已经增加了对像]]
function mini_map.check_is_have(obj)
	if mini_map.main_obj == nil then return end;
	for k,v in pairs(mini_map.obj_list) do
		if v.obj:get_name() == obj:get_name() then
			return true;
		end
	end
	return false;
end

--[[得到COM]]
function mini_map.get_com_by_obj(obj)
	for k,v in pairs(mini_map.obj_list) do
		if v.obj:get_name() == obj:get_name() then
			return v.com;
		end
	end
	return nil;
end

--[[非对外接口]]
function mini_map.add_obj(obj,com)
	local temp = {};
	temp.obj = obj;
	temp.com = com;
	table.insert(mini_map.obj_list,temp);
end

--[[删除对像]]
function mini_map.del_obj(obj)
	if mini_map.main_com == nil or obj == nil then return end;
	for i=1,table.getn(mini_map.obj_list) do
		if mini_map.obj_list[i].obj:get_name() == obj:get_name() then
			mini_map.main_com:delete_object(mini_map.obj_list[i].com);
			table.remove(mini_map.obj_list,i);
			return;
		end
	end
end

--[[删除所有对像]]
function mini_map.del_all_obj()
	if mini_map.main_obj == nil then return end;
	for i=1,table.getn(mini_map.obj_list) do
		mini_map.main_com:delete_object(mini_map.obj_list[i].com);
	end
	mini_map.obj_list = {};
end

--[[设定是否旋转]]
function mini_map.set_rotate(is_rotate)
	if mini_map.main_com == nil then return end;
	mini_map.main_com:set_rotate(is_rotate);
 end

--[[设定UI大小]]
function mini_map.set_win_size(x,y)
	if mini_map.main_com == nil then return end;
	mini_map.main_com:set_win_size(x, y);
end

--[[设定游戏场景大小]]
function mini_map.set_scene_size(x,y)
	if mini_map.main_com == nil then return end;
	mini_map.main_com:set_scene_size(x, y);
end

--[[设定小地图大小]]
function mini_map.set_mini_map_size(x,y)
	if mini_map.main_com == nil then return end;
	mini_map.main_com:set_mini_map_size(x, y);
end

--[[设定原点 左下角为0,0点]]
function mini_map.set_scene_origin(x,y)
	if mini_map.main_com == nil then return end;
	mini_map.main_com:set_scene_origin(x, y);
end

--[[设定小地图主角]]
function mini_map.set_main_player(obj)
	if mini_map.main_com == nil then return end;
	if mini_map.main_player then
		mini_map.del_obj(mini_map.main_player);
		mini_map.add_partner(mini_map.main_player);
	end
	mini_map.del_obj(obj);
	mini_map.add_player(obj);
	mini_map.main_player = obj;
	mini_map.main_com:set_mini_map_player(mini_map.get_com_by_obj(obj));
 end

--[[增加主角]]
function mini_map.add_player(player_obj)
	if mini_map.main_com == nil or player_obj == nil then return end;
	if mini_map.check_is_have(player_obj) then return end;
	local obj,mini_map_obj = mini_map.main_com:add_object("Player");
	mini_map.main_com:set_object(mini_map_obj, player_obj, "Player");
	mini_map_obj:set_inner_sprite("sanjiao");
	mini_map.add_obj(player_obj,mini_map_obj);
	return obj;
end

--[[增加队友]]
function mini_map.add_partner(parther_obj)
	if mini_map.main_com == nil or parther_obj == nil then return end;
	if mini_map.check_is_have(parther_obj) then return end;
	local obj,mini_map_obj = mini_map.main_com:add_object("Partner");
	mini_map.main_com:set_object(mini_map_obj, parther_obj, "Partner");
	mini_map.add_obj(parther_obj,mini_map_obj);
	return obj;
end

--[[增加敌人]]
function mini_map.add_enemy(enemy_obj)
	if mini_map.main_com == nil or enemy_obj == nil then return end;
	if mini_map.check_is_have(enemy_obj) then return end;
	local obj,mini_map_obj = mini_map.main_com:add_object("Enemy");
	mini_map.main_com:set_object(mini_map_obj, enemy_obj, "Enemy");
	mini_map.add_obj(enemy_obj,mini_map_obj);
	return obj;
end



