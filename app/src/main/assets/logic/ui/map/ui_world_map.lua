UiWorldMap = Class('UiWorldMap',UiBaseClass);

local ECountryID =
{
    [10001] = 1,  --中央公园
    [6] = 2,  --8区
    [5] = 3,  --22区
    [4] = 4,  --21区
    [1] = 5,  --20区
    [2] = 6,  --12区
    [3] = 7,  --11区
}
--------------------------------------------------
--初始化
function UiWorldMap:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/map/ui_3503_map_world.assetbundle";
    UiBaseClass.Init(self, data);
end

--重新开始
function UiWorldMap:Restart(data)
    self.parent = data.parent;
    UiBaseClass.Restart(self, data);
end

--初始化数据
function UiWorldMap:InitData(data)
    UiBaseClass.InitData(self, data);
end

--析构函数
function UiWorldMap:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

--显示ui
function UiWorldMap:Show()
    UiBaseClass.Show(self);
    self:UpdateUi();
end

--隐藏ui
function UiWorldMap:Hide()
    UiBaseClass.Hide(self);
end

--注册回调函数
function UiWorldMap:RegistFunc()
    UiBaseClass.RegistFunc(self);
end

--注册消息分发回调函数
function UiWorldMap:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiWorldMap:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

--初始化UI
function UiWorldMap:InitUI(asset_obj)
    -- UiBaseClass.InitUI(self, asset_obj);
    if asset_obj then
        self.ui = asset_game_object.create(asset_obj);
    end
    self.ui:set_parent(self.parent.ui)
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_local_position(0,0,0); 
    self.ui:set_name('ui_world_map');
    -- do return end

    self.lab_my_country = {};
    self.sp_arrow = {};
    for i=1,7 do
        if i > 1 then
            self.lab_my_country[i] = ngui.find_label(self.ui, "centre_other/animation/sp_map/cont"..i.."/lab2");
            self.lab_my_country[i]:set_active(false);
        end
        self.sp_arrow[i] = ngui.find_sprite(self.ui, "centre_other/animation/sp_map/cont"..i.."/sp_arrows");
        self.sp_arrow[i]:set_active(false);
    end
    
    self:UpdateUi();
end

function UiWorldMap:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end
    self.parent.lab_title:set_text("世界地图");
    local country_id = g_dataCenter.player.country_id;
    for i=2,7 do
        if i == ECountryID[country_id] then
            self.lab_my_country[i]:set_text("(本区)");
            self.lab_my_country[i]:set_active(true);
        else
            self.lab_my_country[i]:set_active(false);
        end
    end
    local cur_world_id = FightScene.GetWorldGID();
    local cur_country_id = ConfigManager.Get(EConfigIndex.t_world_info,cur_world_id).country_id;
    if cur_country_id == 0 then
        cur_country_id = cur_world_id;
    end
    for i=1,7 do
        if ECountryID[cur_country_id] and i == ECountryID[cur_country_id] then
            self.sp_arrow[i]:set_active(true);
        else
            self.sp_arrow[i]:set_active(false);
        end
    end

    if cur_world_id == 10000 then
        self.sp_arrow[ECountryID[country_id]]:set_active(true);
    end

end

