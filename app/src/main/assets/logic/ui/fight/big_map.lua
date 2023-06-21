
--[[
BigMap = {}
local pathRes = "assetbundles/prefabs/ui/fight/fight_map.assetbundle";
-------------------外部接口-----------------------------
function BigMap.Show(minimapPool, sceneMap)
	if BigMap.ui == nil then
		BigMap.Init(minimapPool, sceneMap);
		BigMap.LoadAsset();
	end
end
--9宫格的情况下更新boss位置
function BigMap.UpdateBossPos(entityGid, bossid, x, y, state)
	if BigMap.ui == nil or not BigMap.ui:get_active() then
		return;
	end
	local cf = ConfigManager.Get(EConfigIndex.t_monster_property,bossid);
    if not cf then
        return;
    end
    local control = BigMap.uiControl;
    if state == 1 then
        BigMap.DestroyBigmapObj(entityGid);
    else
        local uiObj = BigMap.allObj[entityGid];
        --没有就创建一个
        if not uiObj then
        	uiObj = control.cloneHead:clone();
            if BigMap.allObjTexture[entityGid] then
                BigMap.allObjTexture[entityGid]:Destroy();
                BigMap.allObjTexture[entityGid] = nil;
            end
            BigMap.allObjTexture[entityGid] = ngui.find_texture(uiObj, "text_human");
		    BigMap.allObjTexture[entityGid]:set_texture(cf.icon46);
            uiObj:set_active(true);
            uiObj:set_name("bigmap_"..tostring(entityGid));
            BigMap.CreateBigmapObj(entityGid, uiObj)
        end
        local pos = {x=x, z=y};
        local newPosX = (pos.x - BigMap.xPosMap) * BigMap.xScaleMap;
        local newPosY = (pos.z - BigMap.zPosMap) * BigMap.zScaleMap;
        uiObj:set_local_position(newPosX, newPosY, 0);
    end
end
-------------------内部接口-----------------------------
function BigMap.Init(minimapPool, sceneMap)
	--外部数据相关
	BigMap.data = {};
	BigMap.data.minimapPool = minimapPool;
	BigMap.data.sceneMap = sceneMap;
	--ui相关
	BigMap.ui = nil;
	BigMap.uiControl = {};
	--内部变量
	BigMap.allObj = {};
	BigMap.allObjTexture = {};
	BigMap.tmUpdateMap = nil;
	BigMap.xScaleMap = 1;
	BigMap.zScaleMap = 1;
end
function BigMap.LoadAsset()
	ResourceLoader.LoadAsset(pathRes, BigMap.on_load);
end

function BigMap.on_load(pid, filepath, asset_obj, error_info)
	if filepath == pathRes then
		BigMap.InitUi(asset_obj)
	end
end

function BigMap.InitUi(asset)
	BigMap.ui = asset_game_object.create(asset);
	BigMap.ui:set_parent(Root.get_root_ui_2d_fight());
	BigMap.ui:set_local_scale(Utility.SetUIAdaptation());
	BigMap.ui:set_name("BigMap");

	local control = BigMap.uiControl;
	control.textureMap = ngui.find_texture(BigMap.ui, "Texture");
	control.textureMap:get_game_object():set_local_rotation(0, 0, 135);
	control.cloneHead = BigMap.ui:get_child_by_name("content");
	control.cloneHead:set_local_rotation(0, 0, -135);
	control.cloneHead:set_active(false);
	control.clonePot = BigMap.ui:get_child_by_name("sp");
	control.clonePot:set_active(false);

	local btn = ngui.find_button(BigMap.ui, "sp_mark");
	btn:set_on_click("BigMap.Destroy");

	BigMap.UpdateUi();
end

function BigMap.UpdateUi()
	if BigMap.ui == nil then
		return;
	end
	--app.log(table.tostring(BigMap));
	local data = BigMap.data;
	local control = BigMap.uiControl;

	--算比例
	local textW, textH = control.textureMap:get_size();
	local bkPosX, bkPosY, bkPosZ = data.sceneMap:get_local_position();
    local bkScaleX, bkScaleY, bkScaleZ = data.sceneMap:get_local_scale();
    BigMap.xPosMap = bkPosX;
    BigMap.zPosMap = bkPosZ;
    BigMap.xScaleMap = textW / bkScaleX;
    BigMap.zScaleMap = textH / bkScaleZ;
	--创建对象
	for k, v in pairs(data.minimapPool) do
		local entityObj = ObjectManager.GetObjectByGID(k);
        if entityObj then
        	local uiObj = nil;
			if entityObj:IsBoss() then
		        uiObj = control.cloneHead:clone();
		        BigMap.allObjTexture[k] = ngui.find_texture(uiObj, "text_human");
		        BigMap.allObjTexture[k]:set_texture(entityObj.config.icon46);
		    else
		        uiObj = control.clonePot:clone();
		        local spPot = ngui.find_sprite(uiObj, uiObj:get_name());
		        spPot:set_sprite_name("zhandou_dian1");
		    end
		    uiObj:set_active(true);
    		uiObj:set_name("bigmap_"..tostring(k));
    		local pos = entityObj:GetPosition(false);
            local newPosX = (pos.x - BigMap.xPosMap) * BigMap.xScaleMap;
            local newPosY = (pos.z - BigMap.zPosMap) * BigMap.zScaleMap;
            uiObj:set_local_position(newPosX, newPosY, 0);
        	BigMap.CreateBigmapObj(k, uiObj);
        end
	end

	BigMap.tmUpdateMap = timer.create("BigMap.UpdateMap", 300, -1);
end

function BigMap.Destroy()
	--外部数据相关
	if BigMap.data then
		for k, v in pairs(BigMap.data) do
			BigMap.data[k] = nil;
		end
		BigMap.data = nil;
	end
	--ui相关
	if BigMap.ui then
		BigMap.ui:set_active(false);
		BigMap.ui = nil;
	end
	BigMap.uiControl = nil;
	--内部变量相关
	for k, v in pairs(BigMap.allObj) do
		BigMap.allObj[k]:set_active(false);
		BigMap.allObj[k] = nil;
	end
	for k, v in pairs(BigMap.allObjTexture) do
		v:Destroy();
		BigMap.allObjTexture[k] = nil;
	end
	if BigMap.tmUpdateMap then
		timer.stop(BigMap.tmUpdateMap);
		BigMap.tmUpdateMap = nil;
	end
end

function BigMap.UpdateMap()
	if BigMap.ui == nil or not BigMap.ui:get_active() then
		return;
	end
	local data = BigMap.data;
	for k, v in pairs(BigMap.allObj) do
        local entityObj = ObjectManager.GetObjectByGID(k);
        if entityObj then
            local pos = entityObj:GetPosition(false);
            local newPosX = (pos.x - BigMap.xPosMap) * BigMap.xScaleMap;
            local newPosY = (pos.z - BigMap.zPosMap) * BigMap.zScaleMap;
            v:set_local_position(newPosX, newPosY, 0);
        else
        	--小地图上没有了  大地图上也应该消失
        	if not data.minimapPool[k] then
	            BigMap.DestroyBigmapObj(k);
	        end
        end
    end
end

function BigMap.DestroyBigmapObj(entityGid)
	if BigMap.allObj[entityGid] then
        BigMap.allObj[entityGid]:set_active(false);
        BigMap.allObj[entityGid] = nil;
    end
    --地图上的boss
    if BigMap.allObjTexture[entityGid] then
        BigMap.allObjTexture[entityGid]:Destroy();
        BigMap.allObjTexture[entityGid] = nil;
    end
end
--加入大地图更新池
function BigMap.CreateBigmapObj(entityGid, uiObj)
    BigMap.allObj[entityGid] = uiObj;
end

]]