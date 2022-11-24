local ui_area_show = {
    pathRes = "assetbundles/prefabs/ui/area_show/ui_main_area.assetbundle",
    ui = nil,
    go_animation = nil,
    lblInfo = nil,
}
local this = ui_area_show

function ui_area_show.init(isshow)
    if ui_area_show.ui == nil then
        ResourceManager.AddReservedRes(this.pathRes)
        local callback = function(pid, fpath, asset_obj, error_info)
            ui_area_show.load_callback(pid, fpath, asset_obj, error_info, isshow)
        end

        ResourceLoader.LoadAsset(this.pathRes, callback)
    end
    --  app.log("ui_area_show.init:" .. tostring(isshow))
end

function ui_area_show.load_callback(pid, fpath, asset_obj, error_info, isshow)
    this.ui = asset_game_object.create(asset_obj);
    this.ui:set_parent(Root.get_root_ui_2d());
    this.ui:set_local_scale(1, 1, 1);
    this.go_animation = this.ui:get_child_by_name("animation")
    this.lblInfo = ngui.find_label(this.ui, "animation/txt")
    if isshow == true then
        ui_area_show.show()
    else
        this.ui:set_active(false)
    end
    -- app.log("xxxxxxxxxxxxxxxxxxxxxxxxx")
end
function ui_area_show.show()
    this.ui:set_active(true)
    local rel, world_info = FightScene.GetAreaRel()

    local hurdle_id;
    if FightScene.GetStartUpEnv() and FightScene.GetStartUpEnv().levelData then
        hurdle_id = FightScene.GetStartUpEnv().levelData.hurdleid;
    else
        return
    end
    local area_name = ConfigManager.Get(EConfigIndex.t_world_info,hurdle_id).name;

    local cur_world_id = FightScene.GetWorldGID();
    -- 当前地图id
    local cur_country_id = ConfigManager.Get(EConfigIndex.t_world_info,cur_world_id).country_id;
    -- 当前国家id
    if cur_country_id == 0 then
        cur_country_id = g_dataCenter.player.country_id;
        -- 在新手村或者中原地图，用自己的出生国id
    end
    if not cur_country_id then return end
    local country_name = ConfigManager.Get(EConfigIndex.t_country_info,cur_country_id).name;
    if nil == country_name then return end
    local str_area = country_name .. "." .. area_name


    if rel == ENUM.AreaRel.Enemy then
        str_area = "敌区 " .. str_area
        this.lblInfo:set_color(1, 0, 0, 1)
    elseif rel == ENUM.AreaRel.Friend then
        str_area = "盟区 " .. str_area
        this.lblInfo:set_color(0, 198 / 255, 1, 1)
    else
        str_area = "己方 " .. str_area
        this.lblInfo:set_color(1, 1, 1, 1)
    end
    this.lblInfo:set_text(str_area);
    this.go_animation:animated_play("ui_main_area")
end

UIAreaShow = { }
function UIAreaShow.Show()
    --- app.log("UIAreaShow.Show" .. debug.traceback())
    if this.ui == nil then
        ui_area_show.init(true)
    else
        ui_area_show.show()
    end
end
