--
-- Created by IntelliJ IDEA.
-- User: luohaofang 
-- Date: 2015/6/18
-- To change this template use File | Settings | File Templates.
--
local ResPath = "assetbundles/prefabs/ui/fight/fight_map.assetbundle";

FightMap = {};

FightMap.main_obj = nil;--[[主OBJ]]
FightMap.main_com = nil;--[[组件]]
FightMap.main_bk_sprite = nil;--[[背景sprite]]
FightMap.main_bk_load = "";--[[加载图片]]
FightMap.main_bk_name = "";--[[使用的图片]]
FightMap.main_bk_atlas = nil;--[[动态图集]]
FightMap.obj_list = {};
FightMap.main_player = nil;--[[当前地图主角]]
FightMap.EObj_type = 
{
	player = 1,
	monster = 2,
	small_tower = 3,
	big_tower = 4,
}

function FightMap.Destroy()
	FightMap.del_all_obj();
	FightMap.is_show_bk(false);
	FightMap.main_bk_sprite = nil;--[[背景sprite]]
	FightMap.main_bk_load = "";--[[加载图片]]
	FightMap.main_bk_name = "";--[[使用的图片]]
	FightMap.main_bk_atlas = nil;--[[动态图集]]
	FightMap.main_obj  = nil;
	FightMap.main_com = nil;
end

--[[初始化]]
function FightMap.init()
    ResourceLoader.LoadAsset(ResPath, FightMap.OnLoaded);
end

function FightMap.OnLoaded(pid, filepath, asset_obj, error_info)
	if filepath ~= ResPath then return end 
	FightMap.main = asset_game_object.create(asset_obj);
	FightMap.main:set_name("fight_map");
	FightMap.main:set_parent(Root.get_root_ui_2d_fight());
    FightMap.main:set_local_scale(1,1,1);

    local btn = ngui.find_button(FightMap.main,"panel_mark/sp_mark");
    btn:set_on_click("FightMap.onBack");

    FightMap.InitMiniMap();
end

function FightMap.InitMiniMap()
	FightMap.main_obj = asset_game_object.find("centre_other/MiniMapWin");
	if FightMap.main_obj ~= nil then
		FightMap.main_com = component.get_component_mini_map(FightMap.main_obj);
		FightMap.main_bk_sprite = ngui.find_sprite(FightMap.main_obj, "Win/Mask/Map");
		FightMap.main_com:set_rotate(false);
	end

	--[[例]]
	FightMap.set_scene_size(120,80);
	FightMap.set_mini_map_size(794,232);
	FightMap.set_scene_origin(0,0);
	FightMap.is_show_bk(false);

	FightMap.main:set_active(false);
end

function FightMap.onBack()
	FightMap.Show(false);
end

--[[地图显示]]
function FightMap.Show(isShow)
	if FightMap.main == nil then return end;
	FightMap.main:set_active(isShow);
end

--[[地图背景显示]]
function FightMap.is_show_bk(is_show)
	if FightMap.main_bk_sprite == nil then return end;
	FightMap.main_bk_sprite:set_active(is_show);
end

--[[更换地图背景
-- str_load  加载图片地址  assetbundles/prefabs/ui/image/minimap/xiaoditu.png
-- str_name 更换图集名
-- ]]
function FightMap.change_bk(str_load,str_name)
	if FightMap.main == nil then return end;
	if str_load == nil or str_load == "" or str_name == nil or str_name == "" then return end;
	if FightMap.main_bk_load == str_load then return end;
	FightMap.main_bk_load = str_load;
	FightMap.main_bk_name = str_name;
	ResourceLoader.LoadTexture(FightMap.main_bk_load, FightMap.png_load);
end
function FightMap.png_load(pid, filepath, texture_obj, error_info)
	ngui_atlas.add_texture(texture_obj);
	FightMap.main_bk_atlas = ngui_atlas.create_by_textures_with_shader(1,"Unlit/Transparent Colored");
	FightMap.main_bk_sprite:set_sprite_atlas(FightMap.main_bk_atlas);
	FightMap.main_bk_sprite:set_sprite_name(FightMap.main_bk_name);
	FightMap.is_show_bk(true);
end

--[[查看是否已经增加了对像]]
function FightMap.check_is_have(obj)
	for k,v in pairs(FightMap.obj_list) do
		if v.obj:get_name() == obj:get_name() then
			return true;
		end
	end
	return false;
end

--[[得到COM]]
function FightMap.get_com_by_obj(obj)
	for k,v in pairs(FightMap.obj_list) do
		if v.obj:get_name() == obj:get_name() then
			return v.com;
		end
	end
	return nil;
end

--[[非对外接口]]
function FightMap.add_obj(obj,com)
	local temp = {};
	temp.obj = obj;
	temp.com = com;
	table.insert(FightMap.obj_list,temp);
end

--[[删除对像]]
function FightMap.del_obj(obj)
	if FightMap.main_com == nil or obj == nil then return end;
	for i=1,table.getn(FightMap.obj_list) do
		if FightMap.obj_list[i].obj:get_name() == obj:get_name() then
			FightMap.main_com:delete_object(FightMap.obj_list[i].com);
			table.remove(FightMap.obj_list,i);
			return;
		end
	end
end

--[[删除所有对像]]
function FightMap.del_all_obj()
	if FightMap.main == nil then return end;
	for i=1,table.getn(FightMap.obj_list) do
		FightMap.main_com:delete_object(FightMap.obj_list[i].com);
	end
	FightMap.obj_list = {};
end

--[[设定是否旋转]]
function FightMap.set_rotate(is_rotate)
	if FightMap.main_com == nil then return end;
	FightMap.main_com:set_rotate(is_rotate);
 end

--[[设定UI大小]]
function FightMap.set_win_size(x,y)
	if FightMap.main_com == nil then return end;
	FightMap.main_com:set_win_size(x, y);
end

--[[设定游戏场景大小]]
function FightMap.set_scene_size(x,y)
	if FightMap.main_com == nil then return end;
	FightMap.main_com:set_scene_size(x, y);
end

--[[设定小地图大小]]
function FightMap.set_mini_map_size(x,y)
	if FightMap.main_com == nil then return end;
	FightMap.main_com:set_mini_map_size(x, y);
end

--[[设定原点 左下角为0,0点]]
function FightMap.set_scene_origin(x,y)
	if FightMap.main_com == nil then return end;
	FightMap.main_com:set_scene_origin(x, y);
end

--[[设定地图主角]]
function FightMap.set_main_player(obj)
	if FightMap.main_com == nil then return end;
	local com_obj;
	if FightMap.main_player then
		com_obj = FightMap.get_com_by_obj(FightMap.main_player):get_game_object();
		local bk = ngui.find_sprite(com_obj,"player/sp_yuan");
		bk:set_sprite_name("xuetiao3");
	end
	FightMap.main_player = obj;
	com_obj = FightMap.get_com_by_obj(obj):get_game_object()
	local bk = ngui.find_sprite(com_obj,"player/sp_yuan");
	bk:set_sprite_name("xuetiao2");
	FightMap.main_com:set_mini_map_player(FightMap.get_com_by_obj(obj));
 end

--[[增加角色]]
function FightMap.add_player(player_obj,player_type,flag)
	if FightMap.main_com == nil or player_obj == nil then return end;
	if FightMap.check_is_have(player_obj) then return end;
	local obj,FightMap_obj = FightMap.main_com:add_object("Player");
	FightMap.main_com:set_object(FightMap_obj, player_obj, "Player");
	FightMap.add_obj(player_obj,FightMap_obj);

	local big_tower = ngui.find_sprite(obj,"ta1");
	big_tower:set_active(false);
	local small_tower = ngui.find_sprite(obj,"ta2");
	small_tower:set_active(false);
	local monster = ngui.find_sprite(obj,"dian");
	monster:set_active(false);
	local player = ngui.find_sprite(obj,"player");
	player:set_active(false);
	local dead = ngui.find_sprite(obj,"kulou");
	dead:set_active(false);

	if player_type == FightMap.EObj_type.player then
		player:set_active(true);
		local bk = ngui.find_sprite(obj,"player/sp_yuan");
		if flag == g_dataCenter.fight_info.single_friend_flag then
			bk:set_sprite_name("xuetiao3");
		elseif flag == g_dataCenter.fight_info.single_enemy_flag then
			bk:set_sprite_name("xuetiao4");
		end
	elseif player_type == FightMap.EObj_type.small_tower then
		small_tower:set_active(true);
		local bk = ngui.find_sprite(obj,"ta1/sp_tower");
		if flag == g_dataCenter.fight_info.single_friend_flag then
			bk:set_sprite_name("data1");
		elseif flag == g_dataCenter.fight_info.single_enemy_flag then
			bk:set_sprite_name("data2");
		end
	elseif player_type == FightMap.EObj_type.big_tower then
		big_tower:set_active(true);
		local bk = ngui.find_sprite(obj,"ta2/sp_tower");
		if flag == g_dataCenter.fight_info.single_friend_flag then
			bk:set_sprite_name("data3");
		elseif flag == g_dataCenter.fight_info.single_enemy_flag then
			bk:set_sprite_name("data4");
		end
	elseif player_type == FightMap.EObj_type.monster then
		monster:set_active(true);
		local bk = ngui.find_sprite(obj,"dian/sp_dot");
		if flag == g_dataCenter.fight_info.single_friend_flag then
			bk:set_sprite_name("dadian1");
		elseif flag == g_dataCenter.fight_info.single_enemy_flag then
			bk:set_sprite_name("dadian2");
		end
	end

	return obj;
end

--[[更改头像]]
function FightMap.ChangeIcon(com_obj,pic_name,atlas)
	if FightMap.main == nil then return end;
	if com_obj == nil then return end;
	if pic_name == nil then return end;
	local com = ngui.find_sprite(com_obj,"player/sp_head");
	if atlas then
		com:set_sprite_atlas(atlas);
	end
	com:set_sprite_name(pic_name);
end

--[[显示死亡头像]]
function FightMap.ChangeDead(com_obj,flag)
	if FightMap.main == nil then return end;
	if com_obj == nil then return end;
	local big_tower = ngui.find_sprite(com_obj,"ta1");
	big_tower:set_active(false);
	local small_tower = ngui.find_sprite(com_obj,"ta2");
	small_tower:set_active(false);
	local monster = ngui.find_sprite(com_obj,"dian");
	monster:set_active(false);
	local player = ngui.find_sprite(com_obj,"player");
	player:set_active(false);
	local dead = ngui.find_sprite(com_obj,"kulou");
	dead:set_active(true);
	if flag == g_dataCenter.fight_info.single_friend_flag then
		dead:set_sprite_name("dead2");
	elseif flag == g_dataCenter.fight_info.single_enemy_flag then
		dead:set_sprite_name("dead");
	end
end