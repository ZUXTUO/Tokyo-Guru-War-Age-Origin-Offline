UiCountryMap = Class('UiCountryMap',UiBaseClass);


--------------------------------------------------
--初始化
function UiCountryMap:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/map/ui_3502_map_country.assetbundle";
    UiBaseClass.Init(self, data);
end

--重新开始
function UiCountryMap:Restart(data)
    self.parent = data.parent;
    UiBaseClass.Restart(self, data);
end

--初始化数据
function UiCountryMap:InitData(data)
    UiBaseClass.InitData(self, data);
end

--析构函数
function UiCountryMap:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

--显示ui
function UiCountryMap:Show()
    UiBaseClass.Show(self);
    self:UpdateUi();
end

--隐藏ui
function UiCountryMap:Hide()
    UiBaseClass.Hide(self);
end

--注册回调函数
function UiCountryMap:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_area"] = Utility.bind_callback(self, self.on_btn_area)
end

--注册消息分发回调函数
function UiCountryMap:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiCountryMap:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

--初始化UI
function UiCountryMap:InitUI(asset_obj)
    -- UiBaseClass.InitUI(self, asset_obj);
    if asset_obj then
        self.ui = asset_game_object.create(asset_obj);
    end
    self.ui:set_parent(self.parent.ui)
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_local_position(0,0,0); 
    self.ui:set_name('ui_country_map');
    -- do return end

    self.btn_area = {};
    self.sp_arrow = {};
    self.cont_build = {};
    for i=1,6 do
        self.cont_build[i] = self.ui:get_child_by_name("centre_other/animation/content/sp_map/cont_build"..i);
        self.btn_area[i] = ngui.find_button(self.ui, "centre_other/animation/content/sp_map/cont_build"..i.."/sp_bulid1");
        self.btn_area[i]:set_event_value("", i);
        self.btn_area[i]:set_on_click(self.bindfunc["on_btn_area"]);
        self.sp_arrow[i] = ngui.find_sprite(self.ui, "centre_other/animation/content/sp_map/cont_build"..i.."/sp_arrows");
        if self.sp_arrow[i] then
            self.sp_arrow[i]:set_active(false);
        end
    end
    
    self:UpdateUi();
end

function UiCountryMap:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end
    local cur_world_id = FightScene.GetWorldGID();  --当前地图id
    local cur_country_id = ConfigManager.Get(EConfigIndex.t_world_info,cur_world_id).country_id;  --当前国家id
    self.cont_build[1]:set_active(true);
    if cur_country_id == 0 then
        cur_country_id = g_dataCenter.player.country_id;  --在新手村或者中原地图，用自己的出生国id
    else
        if cur_country_id ~= g_dataCenter.player.country_id then
            --self.cont_build[1]:set_active(false);
        end
    end
    local country_name = ConfigManager.Get(EConfigIndex.t_country_info,cur_country_id).name;
    self.parent.lab_title:set_text(country_name);

    for i=1,6 do
        self.sp_arrow[i]:set_active(false);
    end
    -- for k,v in pairs(gd_country_map_info) do
    for k,v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_country_map_info)) do
        for k1,v1 in pairs(v) do
            if v1.world_id == cur_world_id then
                self.sp_arrow[k]:set_active(true);
                break;
            end
        end
    end
end

function UiCountryMap:on_btn_area(t)
    local index = t.float_value;
    -- if index == 1 then
    --     self.parent.btn[self.parent.cur_index]:set_enable(true);
    --     self.parent.cur_index = 1;
    --     self.parent:UpdateUi(10000);
    -- elseif index == 2 then
    --     self.parent.btn[self.parent.cur_index]:set_enable(true);
    --     self.parent.cur_index = 1;
    --     self.parent:UpdateUi(10001);
    -- end
    -- local country_id = g_dataCenter.player.country_id;
    -- local world_id = ConfigManager.Get(EConfigIndex.t_country_map_info,index)[country_id].world_id;
    -- if world_id then
    --     self.parent.btn[self.parent.cur_index]:set_enable(true);
    --     self.parent.cur_index = 1;
    --     self.parent:UpdateUi(world_id);
    -- end

    local cur_world_id = FightScene.GetWorldGID();  --当前地图id
    local cur_country_id = ConfigManager.Get(EConfigIndex.t_world_info,cur_world_id).country_id;  --当前国家id
    if cur_country_id == 0 then
        cur_country_id = g_dataCenter.player.country_id;  --在新手村或者中原地图，用自己的出生国id
    end
    local world_id = ConfigManager.Get(EConfigIndex.t_country_map_info,index)[cur_country_id].world_id;
    if world_id then
        self.parent.btn[self.parent.cur_index]:set_enable(true);
        self.parent.cur_index = 1;
        self.parent:UpdateUi(world_id);
    end
end

