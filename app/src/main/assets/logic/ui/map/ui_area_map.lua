UiAreaMap = Class('UiAreaMap',UiBaseClass);
--------------------------------------------------
local min_dis_green_point = 5;   --两个绿点之间的距离
--初始化
function UiAreaMap:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/map/ui_3501_map_area.assetbundle";
    UiBaseClass.Init(self, data);
end

--重新开始
function UiAreaMap:Restart(data)
    self.parent = data.parent;
    self.hurdle_id = data.hurdle_id;
    if not data.hurdle_id then
        if FightScene.GetStartUpEnv() and FightScene.GetStartUpEnv().levelData then
            self.hurdle_id = FightScene.GetStartUpEnv().levelData.hurdleid;
        end
    end
    UiBaseClass.Restart(self, data);
end

--初始化数据
function UiAreaMap:InitData(data)
    UiBaseClass.InitData(self, data);
    self.cont_npc_clone = {};
    self.cont_monster_clone = {};
    self.cont_transfer_clone = {};
    self.cont_special_clone = {}

    self.lab_npc_clone = {};
    self.lab_monster_clone = {};
    self.lab_transfer_clone = {};
    self.lab_special_clone = {}

    self.sp_blue_clone = {};
    self.sp_green_clone = {};
    self.green_count = {};
    self.is_moving = false;
    self.left_index = 1;    --默认显示npc
    self.cont_left_npc_clone = {};
    self.cont_left_monster_clone = {};
    self.cont_left_translation_point_clone = {};
    self.lab_left_npc_clone = {};
    self.lab_left_monster_clone = {};
    self.lab_left_translation_point_clone = {};
    self.btn_left_npc_clone = {};
    self.btn_left_monster_clone = {};
    self.btn_left_translation_point_clone = {};
    self.sp_shine_left_npc_clone = {};
    self.sp_shine_left_monster_clone = {};
    self.sp_shine_left_translation_point_clone = {};
    self.isFirst = {};
    for i=1,3 do
        self.isFirst[i] = true;
    end
end

--析构函数
function UiAreaMap:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.sp_bk then
        self.sp_bk:Destroy();
    end
    self.cont_npc_clone = {};
    self.cont_monster_clone = {};
    self.cont_transfer_clone = {};
    self.cont_special_clone = {}
    self.lab_npc_clone = {};
    self.lab_monster_clone = {};
    self.lab_transfer_clone = {};
    self.lab_special_clone = {}
    self.sp_blue_clone = {};
    self.sp_green_clone = {};
    self.green_count = {};
    self.is_moving = false;
    self.left_index = 1;    --默认显示npc
    self.cont_left_npc_clone = {};
    self.cont_left_monster_clone = {};
    self.cont_left_translation_point_clone = {};
    self.lab_left_npc_clone = {};
    self.lab_left_monster_clone = {};
    self.lab_left_translation_point_clone = {};
    self.btn_left_npc_clone = {};
    self.btn_left_monster_clone = {};
    self.btn_left_translation_point_clone = {};
    self.sp_shine_left_npc_clone = {};
    self.sp_shine_left_monster_clone = {};
    self.sp_shine_left_translation_point_clone = {};
    Root.DelUpdate(self.Update, self)
end

--显示ui
function UiAreaMap:Show(hurdle_id)
    --UiBaseClass.Show(self);
    for i=1,3 do
        self.isFirst[i] = true;
    end
    if hurdle_id then
        self.hurdle_id = hurdle_id;
        self:UpdateUi();
        self.ui:set_active(false);
        self.ui:set_active(true);
    end
    Root.AddUpdate(self.Update, self);
end

--隐藏ui
function UiAreaMap:Hide()
    UiBaseClass.Hide(self);
    Root.DelUpdate(self.Update, self)
end

--注册回调函数
function UiAreaMap:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_touch_map"] = Utility.bind_callback(self, self.on_touch_map)
    self.bindfunc["on_select_npc_left"] = Utility.bind_callback(self, self.on_select_npc_left)
    self.bindfunc["on_select_monster_left"] = Utility.bind_callback(self, self.on_select_monster_left)
    self.bindfunc["on_select_translation_point_left"] = Utility.bind_callback(self, self.on_select_translation_point_left)
    self.bindfunc["on_touch_left_cont1"] = Utility.bind_callback(self, self.on_touch_left_cont1)
    self.bindfunc["on_touch_left_cont2"] = Utility.bind_callback(self, self.on_touch_left_cont2)
    self.bindfunc["on_touch_left_cont3"] = Utility.bind_callback(self, self.on_touch_left_cont3)
    self.bindfunc["gc_sync_mysterious_treasure_box_info"] = Utility.bind_callback(self, self.gc_sync_mysterious_treasure_box_info)
end

--注册消息分发回调函数
function UiAreaMap:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_fight.gc_sync_mysterious_treasure_box_info, self.bindfunc['gc_sync_mysterious_treasure_box_info']);
end

--注销消息分发回调函数
function UiAreaMap:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_fight.gc_sync_mysterious_treasure_box_info, self.bindfunc['gc_sync_mysterious_treasure_box_info']);
end

--初始化UI
function UiAreaMap:InitUI(asset_obj)
    if asset_obj then
        self.ui = asset_game_object.create(asset_obj);
    end
    self.ui:set_parent(self.parent.ui)
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_local_position(0,0,0); 
    -- UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('ui_area_map');
    -- do return end

    ------------------------左边------------------------------
    self.lab_left = {};
    self.cont_left = {};
    self.btn_left = {};
    self.grid = {};
    for i=1,3 do
        self.lab_left[i] = ngui.find_label(self.ui, "left_other/animation/scroll_view/panel_list/table/content"..i.."/txt");
        self.cont_left[i] = asset_game_object.find("left_other/animation/scroll_view/panel_list/table/content"..i.."/tween/grid/cont1");
        self.cont_left[i]:set_active(false);
        self.btn_left[i] = ngui.find_toggle(self.ui, "left_other/animation/scroll_view/panel_list/table/content"..i.."/sp_di");
        self.btn_left[i]:set_on_change(self.bindfunc["on_touch_left_cont"..i]);
        self.grid[i] = ngui.find_grid(self.ui, "left_other/animation/scroll_view/panel_list/table/content"..i.."/tween/grid");
    end





    self.lab_left[1]:set_text("NPC");
    self.lab_left[2]:set_text("怪物");
    self.lab_left[3]:set_text("传送点");

    -- do return end
    --self.lab_coordinate = ngui.find_label(self.ui, "sp_bk/Label");
    self.cont_npc = ngui.find_sprite(self.ui, "right_other/animation/Texture/cont_npc");
    self.cont_npc:set_active(false);
    self.cont_npc_clone = {};
    self.lab_npc_clone = {};
    for i=1,10 do
        self.cont_npc_clone[i] = self.cont_npc:get_game_object():clone();
        self.lab_npc_clone[i] = ngui.find_label(self.cont_npc_clone[i], "lab");
    end

    self.cont_monster = ngui.find_sprite(self.ui, "right_other/animation/Texture/cont_monster");
    self.cont_monster:set_active(false);
    self.cont_monster_clone = {};
    self.lab_monster_clone = {};
    for i=1,10 do
        self.cont_monster_clone[i] = self.cont_monster:get_game_object():clone();
        self.lab_monster_clone[i] = ngui.find_label(self.cont_monster_clone[i], "lab");
    end

    self.cont_transfer = ngui.find_sprite(self.ui, "right_other/animation/Texture/cont_transfer");
    self.cont_transfer:set_active(false);
    self.cont_transfer_clone = {};
    self.lab_transfer_clone = {};
    for i=1,10 do
        self.cont_transfer_clone[i] = self.cont_transfer:get_game_object():clone();
        self.lab_transfer_clone[i] = ngui.find_label(self.cont_transfer_clone[i], "lab");
    end

    self.sp_self = ngui.find_sprite(self.ui, "right_other/animation/Texture/sp_arrows");

    self.sp_blue_origin = ngui.find_sprite(self.ui, "right_other/animation/Texture/sp_green");
    self.sp_blue_origin:set_active(false);
    self.sp_blue_clone = {};
    for i=1,10 do
        self.sp_blue_clone[i] = self.sp_blue_origin:get_game_object():clone();
    end
    self.sp_green_origin = ngui.find_sprite(self.ui, "right_other/animation/Texture/sp_yellow");
    self.sp_green_origin:set_active(false);
    self.sp_green_clone = {};
    for i=1,30 do
        self.sp_green_clone[i] = self.sp_green_origin:get_game_object():clone();
    end

    self.btn_bk = ngui.find_button(self.ui, "right_other/animation/Texture");
    self.sp_bk = ngui.find_texture(self.ui, "right_other/animation/Texture");
    self.btn_bk:set_on_ngui_click(self.bindfunc['on_touch_map']);

    self.pt_bk_x,self.pt_bk_y = PublicFunc.GetUiWorldPosition(self.btn_bk);
    self.size_bk_x,self.size_bk_y = self.sp_bk:get_size();
    
    Root.AddUpdate(self.Update, self);
    self:UpdateUi();
end

function UiAreaMap:Update(dt)
    if not UiBaseClass.Update(self, dt) then return end
    if not self.my_captain then return end

    if self.set_pos == true then
        self.set_pos = false;
        for i=1,3 do
            self.grid[i]:set_position(0,0,0);
        end
    end
    self:UpdateCaptainPos();

    if self.hurdle_id ~= FightScene.GetStartUpEnv().levelData.hurdleid then
        return
    end

    if not self.is_moving then return end

    local player_pos = self.my_captain:GetPosition(false);

    --self.destination_count = g_dataCenter.autoPathFinding.destination_count；
    --if self.destination_count ~= g_dataCenter.autoPathFinding.destination_count then
        self.destination_count = g_dataCenter.autoPathFinding.destination_count-1;
        if self.destination_count >= #self.result_point then
            self.is_moving = false;
        end
        if not self.green_count[self.destination_count] then return end
        for i=1,self.green_count[self.destination_count] do
            self.sp_green_clone[i]:set_active(false);
        end
        for i=1,self.destination_count do
            self.sp_blue_clone[i]:set_active(false);
        end
        
    --end
end

function UiAreaMap:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end
    local hurdle_id = self.hurdle_id;
    if not hurdle_id then
        app.log("没有得到当前关卡id");
        return
    end
    local area_map_path = ConfigManager.Get(EConfigIndex.t_world_info,hurdle_id).area_map_path;
    if area_map_path and area_map_path ~= 0 then
        self.sp_bk:set_texture(area_map_path);
        -- self.sp_bk:set_active(true);
    else
        app.log_warning("没有小地图资源");
        -- self.sp_bk:set_active(false);
    end

    local map_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.map_info)
    if not map_info or #map_info == 0 then
        --app.log("地图信息没有"..hurdle_id);
        return
    end
    map_info = map_info[1];
    self.map_back_center_x, self.map_back_center_y, self.map_back_center_z = map_info.px, map_info.py, map_info.pz;
    self.map_back_scale_x, self.map_back_scale_y, self.map_back_scale_z = map_info.sx, map_info.sy, map_info.sz;
    self.map_back_rot_x, self.map_back_rot_y, self.map_back_rot_z = map_info.rx, map_info.ry, map_info.rz;

    self:UpdateLeft();
    self.my_captain = FightScene.GetFightManager().GetMyCaptain();

    for k,v in pairs(self.cont_npc_clone) do
        self.cont_npc_clone[k]:set_active(false);
    end
    for k,v in pairs(self.cont_monster_clone) do
        self.cont_monster_clone[k]:set_active(false);
    end
    for k,v in pairs(self.cont_transfer_clone) do
        self.cont_transfer_clone[k]:set_active(false);
    end
    for k,v in pairs(self.cont_special_clone) do
        self.cont_special_clone[k]:set_active(false);
    end
    


    -- local npc_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.monster)
    if self.left_index == 1 then
        local npc_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.npc)
        if npc_info then
            local key = 0;
            for k,v in pairs(npc_info) do
                if v.is_show and v.is_show == 1 then
                    key = key + 1;
                    local x,y = self:RealToMap(v.px,v.py,v.pz);
                    if not self.cont_npc_clone[key] then
                        self.cont_npc_clone[key] = self.cont_npc:get_game_object():clone();
                        self.lab_npc_clone[key] = ngui.find_label(self.cont_npc_clone[key], "lab");
                    end
                    self.cont_npc_clone[key]:set_local_position(x,y,0);
                    self.cont_npc_clone[key]:set_active(true);
                    local cfg = ConfigManager.Get(EConfigIndex.t_npc_data,v.id);
                    if cfg then
                        local name = cfg.npc_name;
                        self.lab_npc_clone[key]:set_text(name);
                    else
                        -- app.log("id=="..v.id.."的npc没有配置");
                    end
                end
            end
        end
    elseif self.left_index == 2 then
        local monster_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.map_monster)
        if monster_info then
            for k,v in pairs(monster_info) do
                local x,y = self:RealToMap(v.px,v.py,v.pz);
                if not self.cont_monster_clone[k] then
                    self.cont_monster_clone[k] = self.cont_monster:get_game_object():clone();
                    self.lab_monster_clone[k] = ngui.find_label(self.cont_monster_clone[k], "lab");
                end
                self.cont_monster_clone[k]:set_local_position(x,y,0);
                self.cont_monster_clone[k]:set_active(true);
                local cfg = ConfigManager.Get(EConfigIndex.t_monster_property,v.id);
                if cfg then
                    local name = cfg.name;
                    self.lab_monster_clone[k]:set_text(name);
                    -- local level = cfg.level;
                    -- self.lab_monster_clone[k]:set_text(name.."(Lv."..level.."");
                else
                    app.log("id=="..v.id.."的monster没有配置");
                end
            end
        end
    end
    --elseif self.left_index == 3 then
        local translation_point_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.translation_point)
        if translation_point_info then
            for k,v in pairs(translation_point_info) do
                local x,y = self:RealToMap(v.px,v.py,v.pz);
                if not self.cont_transfer_clone[k] then
                    self.cont_transfer_clone[k] = self.cont_transfer:get_game_object():clone();
                    self.lab_transfer_clone[k] = ngui.find_label(self.cont_transfer_clone[k], "lab");
                end
                self.cont_transfer_clone[k]:set_local_position(x,y,0);
                self.cont_transfer_clone[k]:set_active(true);
                local cfg = ConfigManager.Get(EConfigIndex.t_translation_point,v.id);
                if cfg then
                    local name = cfg.name;
                    self.lab_transfer_clone[k]:set_text(name);
                else
                    app.log("id=="..v.id.."的monster没有配置");
                end
            end
        end
    --end

    --打开界面时，判断是否正在自动寻路中
    if self.hurdle_id == FightScene.GetStartUpEnv().levelData.hurdleid and g_dataCenter.autoPathFinding.isFinding then
        self.result_point = g_dataCenter.autoPathFinding.result_point;
        local des = self.result_point[#self.result_point];
        self:MoveToDestination(des.x,des.y,des.z);
    else
        --清除地图上的寻路点
        self:ClearPathPoint();
    end
    self:gc_sync_mysterious_treasure_box_info()
    --self:SetLeft(1);
end

function UiAreaMap:AddSpecialPoint(x, y, z, gid, name)
    local mx, my = self:RealToMap(x, y, z);
    if not self.cont_special_clone[gid] then
        self.cont_special_clone[gid] = self.cont_monster:get_game_object():clone();
        self.lab_special_clone[gid] = ngui.find_label(self.cont_special_clone[gid], "lab");
    end
    self.cont_special_clone[gid]:set_local_position(mx, my, 0);
    self.cont_special_clone[gid]:set_active(true);
    self.lab_special_clone[gid]:set_text(name);
end

function UiAreaMap:UpdateLeft()
    for k,v in pairs(self.cont_left_npc_clone) do
        self.cont_left_npc_clone[k]:set_active(false);
    end
    for k,v in pairs(self.cont_left_monster_clone) do
        self.cont_left_monster_clone[k]:set_active(false);
    end
    for k,v in pairs(self.cont_left_translation_point_clone) do
        self.cont_left_translation_point_clone[k]:set_active(false);
    end

    local hurdle_id = self.hurdle_id;
    local npc_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.npc)

    if npc_info then
        local key = 0;
        for k,v in pairs(npc_info) do
            if v.is_show and v.is_show == 1 then
                key = key + 1;
                if not self.cont_left_npc_clone[key] then
                    self.cont_left_npc_clone[key] = self.cont_left[1]:clone();
                    self.lab_left_npc_clone[key] = ngui.find_label(self.cont_left_npc_clone[key], "lab_task");
                    self.btn_left_npc_clone[key] = ngui.find_button(self.cont_left_npc_clone[key], "sp_bk");
                    self.btn_left_npc_clone[key]:reset_on_click();
                    self.btn_left_npc_clone[key]:set_event_value("", key)   
                    self.btn_left_npc_clone[key]:set_on_click(self.bindfunc["on_select_npc_left"]);
                    self.sp_shine_left_npc_clone[key] = ngui.find_sprite(self.cont_left_npc_clone[key], "sp_shine");
                    self.sp_shine_left_npc_clone[key]:set_active(false);
                end
                self.cont_left_npc_clone[key]:set_active(true);
                local cfg = ConfigManager.Get(EConfigIndex.t_npc_data,v.id);
                if cfg then
                    local name = cfg.npc_name;
                    self.lab_left_npc_clone[key]:set_text(name);
                else
                    -- app.log("id=="..v.id.."的npc没有配置");
                end
            end
        end
    end

    local monster_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.map_monster)

    if monster_info then
        for k,v in pairs(monster_info) do
            if not self.cont_left_monster_clone[k] then
                self.cont_left_monster_clone[k] = self.cont_left[2]:clone();
                self.lab_left_monster_clone[k] = ngui.find_label(self.cont_left_monster_clone[k], "lab_task");
                self.btn_left_monster_clone[k] = ngui.find_button(self.cont_left_monster_clone[k], "sp_bk");
                self.btn_left_monster_clone[k]:reset_on_click();
                self.btn_left_monster_clone[k]:set_event_value("", k)   
                self.btn_left_monster_clone[k]:set_on_click(self.bindfunc["on_select_monster_left"]);
                self.sp_shine_left_monster_clone[k] = ngui.find_sprite(self.cont_left_monster_clone[k], "sp_shine");
                self.sp_shine_left_monster_clone[k]:set_active(false);
            end
            self.cont_left_monster_clone[k]:set_active(true);
            local cfg = ConfigManager.Get(EConfigIndex.t_monster_property,v.id);
            if cfg then
                local name = cfg.name;
                -- self.lab_left_monster_clone[k]:set_text(name);
                local level = cfg.level;
                self.lab_left_monster_clone[k]:set_text(name.."Lv."..level);
            else
                app.log("id=="..v.id.."的怪物没有配置");
            end
        end
    end

    local translation_point_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.translation_point)

    if translation_point_info then
        for k,v in pairs(translation_point_info) do
            if not self.cont_left_translation_point_clone[k] then
                self.cont_left_translation_point_clone[k] = self.cont_left[3]:clone();
                self.lab_left_translation_point_clone[k] = ngui.find_label(self.cont_left_translation_point_clone[k], "lab_task");
                self.btn_left_translation_point_clone[k] = ngui.find_button(self.cont_left_translation_point_clone[k], "sp_bk");
                self.btn_left_translation_point_clone[k]:reset_on_click();
                self.btn_left_translation_point_clone[k]:set_event_value("", k)   
                self.btn_left_translation_point_clone[k]:set_on_click(self.bindfunc["on_select_translation_point_left"]);
                self.sp_shine_left_translation_point_clone[k] = ngui.find_sprite(self.cont_left_translation_point_clone[k], "sp_shine");
                self.sp_shine_left_translation_point_clone[k]:set_active(false);
            end
            self.cont_left_translation_point_clone[k]:set_active(true);
            local cfg = ConfigManager.Get(EConfigIndex.t_translation_point,v.id);
            if cfg then
                local name = cfg.name;
                self.lab_left_translation_point_clone[k]:set_text(name);
            else
                app.log("id=="..v.id.."的npc没有配置");
            end
        end
    end

    self.set_pos = true;
    for i=1,3 do
        self.grid[i]:set_position(0,0,0);
    end
end

function UiAreaMap:UpdateCaptainPos()
    if not self.my_captain then return end
    local area_name = ConfigManager.Get(EConfigIndex.t_world_info,self.hurdle_id).name;
    if self.hurdle_id ~= FightScene.GetStartUpEnv().levelData.hurdleid then
        self.sp_self:set_active(false);
        self.parent.lab_title:set_text(area_name);
    else
        local player_pos = self.my_captain:GetPosition(false);
        local x,y,tx,ty,tz = self:RealToMap(player_pos.x,player_pos.y,player_pos.z);
        self.sp_self:set_position(x,y,0);
        local player_rot = self.my_captain:GetRotation(false);
        if player_rot and type(player_rot.y) == "number" then
            self.sp_self:get_game_object():set_local_rotation(0,0,180-player_rot.y+self.map_back_rot_y);
            self.parent.lab_title:set_text(area_name.."("..math.floor(tx+self.map_back_scale_x/2)..","..math.floor(self.map_back_scale_z/2-tz)..")");
            self.sp_self:set_active(true);
        end
    end

    --self.lab_coordinate:set_text(math.floor(tx+self.map_back_scale_x/2)..","..math.floor(self.map_back_scale_z/2-tz));
end

function UiAreaMap:on_touch_map(name,x,y,game_obj)
    local ngui_x,ngui_y = PublicFunc.TouchPtToNguiPoint(x,y);

    local relative_x_2 = ngui_x - self.pt_bk_x;
    local relative_y_2 = ngui_y - self.pt_bk_y;

    if not self.map_back_scale_x then return end
    local des_pos_x,des_pos_y,des_pos_z = self:MapToReal(relative_x_2,relative_y_2);
    local data = 
    {
        my_captain = self.my_captain,
        des_world_id = self.hurdle_id,
        des_x = des_pos_x,
        des_y = des_pos_y,
        des_z = des_pos_z,
    }
    g_dataCenter.autoPathFinding:SetDestination(data);
    -- self:MoveToDestination(des_pos_x,des_pos_y,des_pos_z);
    self:UpdateUi();
end

function UiAreaMap:MoveToDestination(des_pos_x,des_pos_y,des_pos_z)
    

    -- local _found,px,py,pz;
    -- _found, px, py, pz = util.get_navmesh_sampleposition(des_pos_x,des_pos_y,des_pos_z,5);
    -- if not _found then return end
    -- self.my_captain:SetNavFlag(true, false);

    -- self.result_point = self.my_captain.navMeshAgent:calculate_path(px, py, pz);
    self.result_point = g_dataCenter.autoPathFinding.result_point;
    if not self.result_point or #self.result_point < 2 then return end
    for k,v in pairs(self.sp_green_clone) do
        self.sp_green_clone[k]:set_active(false);
    end
    for k,v in pairs(self.sp_blue_clone) do
        self.sp_blue_clone[k]:set_active(false);
    end
    local green_count = 0;
    self.green_count = {};
    for i=1,#self.result_point-1 do
        local nx_begin,ny_begin = self:RealToMap(self.result_point[i].x,self.result_point[i].y,self.result_point[i].z);
        local nx_end,ny_end = self:RealToMap(self.result_point[i+1].x,self.result_point[i+1].y,self.result_point[i+1].z);
        local pt_green_x,pt_green_y = self:SetGreenPoint(nx_begin, ny_begin, nx_end, ny_end);
        for j=1,#pt_green_x do
            if not self.sp_green_clone[green_count+j] then
                self.sp_green_clone[green_count+j] = self.sp_green_origin:get_game_object():clone();
            end
            self.sp_green_clone[green_count+j]:set_local_position(pt_green_x[j],pt_green_y[j],0);
            self.sp_green_clone[green_count+j]:set_active(true);
        end
        green_count = green_count + #pt_green_x;
        self.green_count[i+1] = green_count;
        if not self.sp_blue_clone[i+1] then
            self.sp_blue_clone[i+1] = self.sp_blue_origin:get_game_object():clone();
        end
        self.sp_blue_clone[i+1]:set_local_position(nx_end,ny_end,0);
        self.sp_blue_clone[i+1]:set_active(true);
    end
    self.destination_count = 2;
    -- local des = self.result_point[self.destination_count];
    --self.my_captain:SetDestination(des.x, des.y, des.z);
    --self.my_captain:SetHandleState(EHandleState.MapMove)
    self.is_moving = true;
end

--清楚寻路点显示
function UiAreaMap:ClearPathPoint()
    for k,v in pairs(self.sp_green_clone) do
        self.sp_green_clone[k]:set_active(false);
    end
    for k,v in pairs(self.sp_blue_clone) do
        self.sp_blue_clone[k]:set_active(false);
    end
end

--地图坐标转换为真实坐标
function UiAreaMap:MapToReal(x,y)
    local rx = self.map_back_scale_x/self.size_bk_x * x;
    local ry = self.map_back_center_y;
    local rz = self.map_back_scale_z/self.size_bk_y * y;

    local quaternion = {};
    quaternion.x, quaternion.y, quaternion.z, quaternion.w = util.quaternion_euler(0,self.map_back_rot_y,0);
    local tx,ty,tz = util.quaternion_multiply_v3(quaternion.x, quaternion.y, quaternion.z, quaternion.w, rx, 0, rz);
    local des_pos_x = tx + self.map_back_center_x;
    local des_pos_y = ry;
    local des_pos_z = tz + self.map_back_center_z;

    return des_pos_x,des_pos_y,des_pos_z;
end

--真实坐标转换为地图坐标
function UiAreaMap:RealToMap(x,y,z)
    x = x - self.map_back_center_x;
    z = z - self.map_back_center_z;
    local quaternion = {};
    quaternion.x, quaternion.y, quaternion.z, quaternion.w = util.quaternion_euler(0,-self.map_back_rot_y,0);
    local tx,ty,tz = util.quaternion_multiply_v3(quaternion.x, quaternion.y, quaternion.z, quaternion.w, x,y,z);
    local mx = tx * self.size_bk_x / self.map_back_scale_x;
    local my = tz * self.size_bk_y / self.map_back_scale_z;

    return mx,my,tx,ty,tz;
end

--计算两个蓝点之间所有绿点的位置
function UiAreaMap:SetGreenPoint(x1, y1, x2, y2)
    local dis = algorthm.GetDistance(x1, y1, x2, y2);
    local n = math.ceil(dis*self.map_back_scale_x/self.size_bk_x/min_dis_green_point) - 1;
    local pt_green_x = {};
    local pt_green_y = {};
    for i=1,n do
        pt_green_x[i] = (x2 - x1)*i/(n+1) + x1;
        pt_green_y[i] = (y2 - y1)*i/(n+1) + y1;
    end
    return pt_green_x,pt_green_y;
end

function UiAreaMap:on_touch_left_cont1(t)
    if self.isFirst[1] then
        self.isFirst[1] = false;
        return
    end
    local index = 1;
    if index == self.left_index then return end
    self.left_index = index;
    self:UpdateUi();
end

function UiAreaMap:on_touch_left_cont2(t)
    if self.isFirst[2] then
        self.isFirst[2] = false;
        return
    end
    local index = 2;
    if index == self.left_index then return end
    self.left_index = index;
    self:UpdateUi();
end

function UiAreaMap:on_touch_left_cont3(t)
    if self.isFirst[3] then
        self.isFirst[3] = false;
        return
    end
    local index = 3;
    if index == self.left_index then return end
    self.left_index = index;
    self:UpdateUi();
end

function UiAreaMap:on_select_npc_left(t)
    local index = t.float_value;
    if self.chose_npc_index then
        self.sp_shine_left_npc_clone[self.chose_npc_index]:set_active(false);
    end
    self.sp_shine_left_npc_clone[index]:set_active(true);
    self.chose_npc_index = index;

    local hurdle_id = self.hurdle_id;
    local npc_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.npc)
    local des_pos_x,des_pos_y,des_pos_z = npc_info[index].px,npc_info[index].py,npc_info[index].pz;
    local data = 
    {
        my_captain = self.my_captain,
        des_world_id = self.hurdle_id,
        -- des_x = des_pos_x,
        -- des_y = des_pos_y,
        -- des_z = des_pos_z,
        npc_id = npc_info[index].id,
    }
    g_dataCenter.autoPathFinding:SetDestination(data);
    -- self:MoveToDestination(des_pos_x,des_pos_y,des_pos_z);
    self:UpdateUi();
end

function UiAreaMap:on_select_monster_left(t)
    local index = t.float_value;
    if self.chose_monster_index then
        self.sp_shine_left_monster_clone[self.chose_monster_index]:set_active(false);
    end
    self.sp_shine_left_monster_clone[index]:set_active(true);
    self.chose_monster_index = index;
    
    local hurdle_id = self.hurdle_id;
    local monster_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.map_monster)
    -- app.log("monster_info   index=="..index.."     id=="..monster_info[index].id.."   name=="..ConfigManager.Get(EConfigIndex.t_monster_property,monster_info[index].id).name);
    local des_pos_x,des_pos_y,des_pos_z = monster_info[index].px,monster_info[index].py,monster_info[index].pz;
    local data = 
    {
        my_captain = self.my_captain,
        des_world_id = self.hurdle_id,
        des_x = des_pos_x,
        des_y = des_pos_y,
        des_z = des_pos_z,
    }
    g_dataCenter.autoPathFinding:SetDestination(data);
    -- self:MoveToDestination(des_pos_x,des_pos_y,des_pos_z);
    self:UpdateUi();
end

function UiAreaMap:on_select_translation_point_left(t)
    local index = t.float_value;
    if self.chose_translation_point_index then
        self.sp_shine_left_translation_point_clone[self.chose_translation_point_index]:set_active(false);
    end
    self.sp_shine_left_translation_point_clone[index]:set_active(true);
    self.chose_translation_point_index = index;

    local hurdle_id = self.hurdle_id;
    local translation_point_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.translation_point)
    local des_pos_x,des_pos_y,des_pos_z = translation_point_info[index].px,translation_point_info[index].py,translation_point_info[index].pz;
    -- self:MoveToDestination(des_pos_x,des_pos_y,des_pos_z);
    local data = 
    {
        my_captain = self.my_captain,
        des_world_id = self.hurdle_id,
        des_x = des_pos_x,
        des_y = des_pos_y,
        des_z = des_pos_z,
    }
    g_dataCenter.autoPathFinding:SetDestination(data);
    self:UpdateUi();
end


function UiAreaMap:gc_sync_mysterious_treasure_box_info()
    local dataCenter = g_dataCenter.worldTreasureBox
    if dataCenter and dataCenter.mysterious_treasure_box_info then
        local x = dataCenter.mysterious_treasure_box_info.x * PublicStruct.Coordinate_Scale_Decimal
        local y = 0
        local z = dataCenter.mysterious_treasure_box_info.y * PublicStruct.Coordinate_Scale_Decimal
        self:AddSpecialPoint(x, y, z, "mysterious_treasure_box", "神秘宝箱")
    end
end