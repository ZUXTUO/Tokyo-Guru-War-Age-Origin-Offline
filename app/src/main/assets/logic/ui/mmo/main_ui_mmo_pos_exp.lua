
MainUIMMOPosExp = Class('MainUIMMOPosExp', UiBaseClass)


local res = "assetbundles/prefabs/ui/new_fight/right_top.assetbundle"

function MainUIMMOPosExp.GetResList()
    return {res}
end

function MainUIMMOPosExp:Init(data)
    self.pathRes = res

    UiBaseClass.Init(self, data);
end

function MainUIMMOPosExp:DestroyUi()
    UiBaseClass.DestroyUi(self)
end

function MainUIMMOPosExp:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['UpdateUi'] = Utility.bind_callback(self, self.UpdateUi);
    self.bindfunc['OnClickMapBtn'] = Utility.bind_callback(self, self.OnClickMapBtn);
end

function MainUIMMOPosExp:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(player.gc_update_player_exp_level, self.bindfunc['UpdateUi'])
end

function MainUIMMOPosExp:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(player.gc_update_player_exp_level, self.bindfunc['UpdateUi'])
end

function MainUIMMOPosExp:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    local btn = ngui.find_button(self.ui, 'sp_bk')
    btn:set_on_click(self.bindfunc['OnClickMapBtn'])

    local mapNameLabel = ngui.find_label(self.ui, 'lab_level')
    local hurdle_id;
    if FightScene.GetStartUpEnv() and FightScene.GetStartUpEnv().levelData then
        hurdle_id = FightScene.GetStartUpEnv().levelData.hurdleid;
    else
        return
    end

    local worldInfo = ConfigManager.Get(EConfigIndex.t_world_info,hurdle_id)
    local area_name = "主城";
    if worldInfo then
        area_name = ConfigManager.Get(EConfigIndex.t_world_info,hurdle_id).name;
    end

    local cur_world_id = FightScene.GetWorldGID();  --当前地图id
    local cur_country_id = 0
    if cur_world_id then
        local cfg = ConfigManager.Get(EConfigIndex.t_world_info,cur_world_id)
        if cfg then
            cur_country_id = cfg.country_id
        else
            cur_country_id = 0
        end
    end
    if cur_country_id == 0 then
        cur_country_id = g_dataCenter.player.country_id;  --在新手村或者中原地图，用自己的出生国id
    end
    if not cur_country_id then return end
    local country_name = ConfigManager.Get(EConfigIndex.t_country_info,cur_country_id).name;
    if nil == country_name then return end

    mapNameLabel:set_text(area_name);


    self.lab_coord = ngui.find_label(self.ui, 'lab_name')
    --self.expProgressBar = ngui.find_progress_bar(self.ui, 'background')

    local obj = self.ui:get_child_by_name("yeka_auto");
    obj:set_active(false);
    self:UpdateUi()
end

function MainUIMMOPosExp:Update(dt)
    if not self.ui then return end

    if FightScene.GetStartUpEnv() and FightScene.GetStartUpEnv().levelData then
        hurdle_id = FightScene.GetStartUpEnv().levelData.hurdleid;
    else
        return
    end

    local map_info = ConfigHelper.GetMapInf(hurdle_id,EMapInfType.map_info)
    if not map_info or #map_info == 0 then
        return
    end
    map_info = map_info[1];
    self.map_back_center_x, self.map_back_center_y, self.map_back_center_z = map_info.px, map_info.py, map_info.pz;
    self.map_back_scale_x, self.map_back_scale_y, self.map_back_scale_z = map_info.sx, map_info.sy, map_info.sz;
    self.map_back_rot_x, self.map_back_rot_y, self.map_back_rot_z = map_info.rx, map_info.ry, map_info.rz;
    self.my_captain = FightScene.GetFightManager().GetMyCaptain();
    if not self.my_captain then return end
    local player_pos = self.my_captain:GetPosition(false);
    local tx,ty,tz = self:RealToMap(player_pos.x,player_pos.y,player_pos.z);
    self.lab_coord:set_text(math.floor(tx+self.map_back_scale_x/2)..","..math.floor(self.map_back_scale_z/2-tz));
end

function MainUIMMOPosExp:RealToMap(x,y,z)
    x = x - self.map_back_center_x;
    z = z - self.map_back_center_z;
    local quaternion = {};
    quaternion.x, quaternion.y, quaternion.z, quaternion.w = util.quaternion_euler(0,-self.map_back_rot_y,0);
    local tx,ty,tz = util.quaternion_multiply_v3(quaternion.x, quaternion.y, quaternion.z, quaternion.w, x,y,z);
    -- local mx = tx * self.size_bk_x / self.map_back_scale_x;
    -- local my = tz * self.size_bk_y / self.map_back_scale_z;

    return tx,ty,tz;
end

function MainUIMMOPosExp:UpdateUi()
    if not self.ui then return end

    local level = g_dataCenter.player.level;
    local exp = g_dataCenter.player.exp;
    local curNeedExp = ConfigManager.Get(EConfigIndex.t_player_level,level).exp;
    --self.expProgressBar:set_value(exp/curNeedExp)
end

function MainUIMMOPosExp:OnClickMapBtn()
    --uiManager:PushUi(EUI.UiMap);

    local data = self:GetInitData().mapParam
    data.isBigMap = true
    data.clickMove = true
    data.parent = GetMainUI().centerNode
    -- data.mapEntityInfo = {
    --                         commonEntity = self.mapEntityInfo,
    --                         syncPosEntity = self.mapSyncPosEntityInfo
    --                     }

    local ui = uiManager:PushUi(EUI.NewFightUiMinimap, data);

    local caption =  g_dataCenter.fight_info:GetCaptain()
    ui:AddPeople(caption, EMapEntityType.EMy, true)
    local npc_list = g_dataCenter.fight_info:GetNPCList(1)
    if npc_list then
        for k,v in pairs(npc_list) do
            local npc = ObjectManager.GetObjectByName(v)
            if npc and npc.config.country == g_dataCenter.player.country_id then
                ui:AddPeople(npc, EMapEntityType.ETranslationPoint, false)
            end
        end
    end
end