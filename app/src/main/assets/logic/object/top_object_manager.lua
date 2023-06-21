--[[
region head_info_controler.lua
date: 2015-8-21
time: 21:5:56
author: Nation
]]
local head_info_res =
{
    "assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle",
}
TopObjectManager = Class("TopObjectManager")

TopObjectManager.ObjPool = { }
TopObjectManager.ShowingObj = { }
TopObjectManager.MaxShowCount = 10
------------------------------全局删除函数--------------------------- 
function TopObjectManager.ClearObjPool()
    for k, v in pairs(TopObjectManager.ObjPool) do
        if v.obj then
            v.obj:set_active(false)
            v.obj = nil;
        end
    end
    TopObjectManager.ObjPool = {};
end


---------------------------------------成员函数---------------------------------------
function TopObjectManager:TopObjectManager(entity)
    self.obj = entity
    -- 飙血对象
    self.hud_obj = nil
    --消息注册
    self.bindfunc = {};
    self.bindfunc["on_info_change"] = Utility.bind_callback(self, TopObjectManager.on_info_change)
end


function TopObjectManager:CreateFightNumObj()
    -- 生成一个放在频幕外的资源,资源中就设定好
    -- 避免同时生成多个，调用逻辑中处理
    local asset = ResourceManager.GetRes(head_info_res[1]);
    if not asset then
        app.log("资源没有预加载");
        return nil, false;
    end
    local obj = asset_game_object.create(asset);
    if not obj then
        return nil,false
    end
    --obj:set_parent(Root.get_root_ui_2d_fight());
    obj:set_parent(Show3dText.GetCameraObj());
    obj:set_local_scale(4, 4, 4)
    obj:set_layer(PublicStruct.UnityLayer.ui3d,true);
    local huds = {};
    for i = 1, 5 do
        huds[i] = {};
        huds[i].objRoot = obj:get_child_by_name("cont"..i);
        huds[i].objRoot:set_active(false);
        huds[i].labArea = ngui.find_label(huds[i].objRoot, "sp_area/lab");
        huds[i].labName = ngui.find_label(huds[i].objRoot, "lab_name");
        huds[i].labGuild = ngui.find_label(huds[i].objRoot, "lab_guild");
        huds[i].labGuild:set_active(false);
        huds[i].spVip = ngui.find_sprite(huds[i].objRoot, "sp_vip");
        huds[i].spVip:set_active(false);
        huds[i].labVip = ngui.find_label(huds[i].objRoot, "lab_vip");
        huds[i].labVip:set_active(false);

        table.insert(TopObjectManager.ObjPool, { hud = huds[i], obj=obj});
    end
    --[[
        huds =
        {
            [1] =
            {
                hud = userdata,
                used = false
            }
        }
    ]]

    if huds and type(huds) == type { } then
        return huds, true
    end
    return nil, false
end


function TopObjectManager:GetFightNumObj()
    -- 检查与创建资源
    local num = table.get_num(TopObjectManager.ObjPool)
    local result = nil
    if TopObjectManager.ObjPool and num > 0 then
        -- 倒着拿，此处应当有一个快速查找算法
        for i = num, 1, -1 do
            result = TopObjectManager.ObjPool[num]
            if result then
                table.remove(TopObjectManager.ObjPool, num)
                return result
            end
        end
    end
    -- 创建一坨
    --local old_num = table.get_num(TopObjectManager.ObjPool)
    local f_nums, suc = self:CreateFightNumObj();
    -- 新创建直接拿第一个
    if true == suc then
        local num = table.get_num(TopObjectManager.ObjPool);
        result = TopObjectManager.ObjPool[num]
        TopObjectManager.ObjPool[num] = nil
        return result
    else
        app.log_warning("TopObjectManager:GetFightNumObj error")
    end

end

function TopObjectManager:OnTick()
    if self.hud_obj and self.hud_obj.hud then
        local tb = self.hud_obj.hud;
        local x, y, z = self:GetRolePos()
        tb.objRoot:set_position(x, y, z)
    end
        --面对摄像机
    local fightCameraObj = CameraManager.GetSceneCameraObj();
    if self.hud_obj and fightCameraObj then
        local rx,ry,rz = fightCameraObj:get_local_rotation();
        self.hud_obj.obj:set_local_rotation(rx,ry,rz);
    end
end

function TopObjectManager:on_info_change()
    if self.hud_obj and self.hud_obj.hud then
        local tb = self.hud_obj.hud;
        if self.obj:IsMyControl() and self.obj:IsCaptain() then
            if g_dataCenter.guild:IsJoinedGuild() then
                tb.labGuild:set_active(true);
                tb.labGuild:set_text("<"..tostring(g_dataCenter.guild:GetMyGuildName())..">");
            else
                tb.labGuild:set_active(false);
            end
            tb.labVip:set_text(tostring(g_dataCenter.player.vip));
            tb.labName:set_text(tostring(g_dataCenter.player.name));
        end
    end
end

---------------------------------------外部接口---------------------------------------
function TopObjectManager:ShowTopInfo()
    if not self.hud_obj then
        local result = self:GetFightNumObj()
        if result then
            self.hud_obj = result
            --面对摄像机
            local fightCameraObj = CameraManager.GetSceneCameraObj();
            if fightCameraObj then
                local rx,ry,rz = fightCameraObj:get_local_rotation();
                self.hud_obj.obj:set_local_rotation(rx,ry,rz);
            end
            --设置内容
            if self.hud_obj and self.hud_obj.hud then
                local tb = self.hud_obj.hud;
                tb.objRoot:set_active(true);
                tb.objRoot:set_name(self.obj.object:get_name())
                local country_name = ""
                local player_name = ""
                local vip_level = 0
                local guild_name = "";
                -- local info = ConfigManager.Get(EConfigIndex.t_country_info,self.obj:GetCountryID());
                -- if info then
                --     country_name = info.name
                -- end
                if self.obj.owner_player_name then
                    player_name = self.obj.owner_player_name
                else
                    player_name = self.obj.config.name
                end
                vip_level = self.obj.vip_level
                guild_name = self.obj.guild_name
                --NoticeManager.BeginListen(ENUM.NoticeType.VipDataChange, self.bindfunc["on_info_change"]);
                    --NoticeManager.BeginListen(ENUM.NoticeType.GuildDataChange, self.bindfunc["on_info_change"]);
                    --NoticeManager.BeginListen(ENUM.NoticeType.PlayerNameChange, self.bindfunc["on_info_change"])
                if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss then
                    if country_name then
                        tb.labArea:set_active(true);
                        tb.labArea:set_text("["..country_name.."]");
                    else
                        tb.labArea:set_active(false);
                    end
                    if player_name then
                        tb.labName:set_active(true);
                        tb.labName:set_text(player_name);
                    else
                        tb.labName:set_active(false);
                    end
                    
                    if vip_level and vip_level > 0 then
                        tb.spVip:set_active(true);
                        tb.labVip:set_active(true);
                        tb.labVip:set_text(tostring(vip_level));
                    else
                        tb.spVip:set_active(false);
                        tb.labVip:set_active(false);
                    end
                    if guild_name and guild_name ~= "" then
                        tb.labGuild:set_active(true);
                        tb.labGuild:set_text("<"..tostring(guild_name)..">");
                    else
                        tb.labGuild:set_active(false);
                    end
                elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss then
                    tb.labArea:set_active(false);
                    if player_name then
                        tb.labName:set_active(true);
                        tb.labName:set_text(player_name);
                    else
                        tb.labName:set_active(false);
                    end
                    
                    if vip_level and vip_level > 0 then
                        tb.spVip:set_active(true);
                        tb.labVip:set_active(true);
                        tb.labVip:set_text(tostring(vip_level));
                    else
                        tb.spVip:set_active(false);
                        tb.labVip:set_active(false);
                    end
                    tb.labGuild:set_active(false);
                elseif FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox then
                    local isEnemy = self.obj:IsEnemy()
                    if country_name then
                        tb.labArea:set_active(true);
                        if isEnemy then
                            tb.labArea:set_text("[FF0000]["..country_name.."][-]");
                        else
                            tb.labArea:set_text(country_name);
                        end
                    else
                        tb.labArea:set_active(false);
                    end
                    if player_name then
                        tb.labName:set_active(true);
                        if isEnemy then
                            tb.labName:set_text("[FF0000]"..player_name.."[-]");
                        else
                            tb.labName:set_text(player_name);
                        end
                    else
                        tb.labName:set_active(false);
                    end
                    if vip_level and vip_level > 0 then
                        tb.spVip:set_active(true);
                        tb.labVip:set_active(true);
                        tb.labVip:set_text(tostring(vip_level));
                    else
                        tb.spVip:set_active(false);
                        tb.labVip:set_active(false);
                    end
                    if guild_name and guild_name ~= "" then
                        tb.labGuild:set_active(true);
                        if isEnemy then
                            tb.labGuild:set_text("[FF0000]<"..tostring(guild_name)..">[-]");
                        else
                            tb.labGuild:set_text("<"..tostring(guild_name)..">");
                        end
                    else
                        tb.labGuild:set_active(false);
                    end
                end

                
                
            end
        end
    end
    if self.hud_obj then
        
    else
        app.log("头顶对象生成失败")
    end 

end

function TopObjectManager:Finalize()
    if self.hud_obj and self.hud_obj.hud then
        local tb = self.hud_obj.hud;
        tb.objRoot:set_active(false);
        tb.objRoot:set_name("none");
        tb.labGuild:set_active(false);
        tb.spVip:set_active(false);
        tb.labVip:set_active(false);
        table.insert(TopObjectManager.ObjPool, self.hud_obj)
    end
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
    self.bindfunc = nil;
end

function TopObjectManager:GetRolePos()
    local fight_camera = CameraManager.GetSceneCamera();
    if fight_camera == nil then
        return 0, 0, 0;
    end
    local ui_camera = Root.get_ui_camera(); 
    local pos = self.obj:GetBindPosition(10)
    local x, y, z = pos.x, pos.y, pos.z
    if self.obj.ui_hp and self.obj.ui_hp:IsShow() then
        y = y + 0.5;
    end
    -- local view_x, view_y, view_z = fight_camera:world_to_screen_point(x, y, z);
    -- view_y = view_y;
    -- local ui_x, ui_y, ui_z = ui_camera:screen_to_world_point(view_x, view_y, view_z);
    -- return ui_x, ui_y, ui_z;
    return x,y+0.1,z;
end

function TopObjectManager:SetIsShow(isShow)
    if self.hud_obj and self.hud_obj.hud then
        local tb = self.hud_obj.hud;
        tb.objRoot:set_active(isShow);
    end
end

function TopObjectManager:OpenScale()

end




--[[ endregion ]]