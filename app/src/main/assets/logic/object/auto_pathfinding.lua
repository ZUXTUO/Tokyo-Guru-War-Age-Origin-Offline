AutoPathFinding = Class('AutoPathFinding');

local checkArrivedDistSQ = 0.1 * 0.1

------------------------------外部接口------------------------------------
--设置NPC寻路
function AutoPathFinding:SetNpcFinding(npc_id)
    local captain = g_dataCenter.fight_info:GetCaptain();
    local npc_config = ConfigManager.Get(EConfigIndex.t_npc_data,npc_id);
    if captain and npc_config then
        local data = {}
        data.my_captain = captain;
        data.des_world_id = npc_config.world_id or FightScene.GetWorldGID();
        data.npc_id = npc_id;
        self:SetDestination(data);
    end
end

--设置任务目的地寻路
function AutoPathFinding:SetTaskDesFinding(task_des_id, des_type)
    local captain = g_dataCenter.fight_info:GetCaptain();
    local pos_config = ConfigManager.Get(EConfigIndex.t_task_destination,task_des_id);
    if captain and pos_config then
        local data = {}
        data.my_captain = captain;
        data.des_world_id = pos_config.world_id;
        data.des_x = pos_config.x;
        data.des_y = pos_config.y;
        data.des_z = pos_config.z;
        data.custom_data = des_type;
        self:SetDestination(data);
    end
end

function AutoPathFinding:GetMyCaptain()
    return self.my_captain
end

--data= 
-- {
--     my_captain = my_captain,
--     des_world_id = xxxx,
--     des_x = xxx,
--     des_y = yyy,
--     des_z = zzz,
--     npc_id = xxx,     --如果传了npc_id，就直接取npc的位置
--     custom_data = nil, -- 自定义数据，需要则传
-- }
function AutoPathFinding:SetDestination(data)
    self.lastToDisination = data

    if not FightScene.GetStartUpEnv() then return end
    if not FightScene.GetStartUpEnv().levelData then return end
    local cur_world_id = nil
    if data.cur_world_id then
        cur_world_id = data.cur_world_id
    else
        cur_world_id = FightScene.GetStartUpEnv().levelData.hurdleid;
    end
    self.my_captain = data.my_captain;
    self.des_world_id = data.des_world_id;
    self.des_x = data.des_x;
    self.des_y = data.des_y;
    self.des_z = data.des_z;
    self.npc_id = data.npc_id;
    self.custom_data = data.custom_data;
    if self.npc_id then
        local npc_info = ConfigManager.Get(EConfigIndex["t_"..self.des_world_id.."_npc"], self.npc_id)
        if not npc_info then return end
        self.des_x = npc_info.x - 0.5;
        self.des_y = 0;
        self.des_z = npc_info.y - 0.5;
    end
    self.isNear = false;
    self:StartPathFinding(self.my_captain, cur_world_id, self.des_world_id, self.des_x, self.des_y, self.des_z);
end

--先不寻路，切换场景后再寻路
function AutoPathFinding:SetDestinationNextScene(data)
    self.isFinding = true;
    self.des_world_id = data.des_world_id;
    self.des_x = data.des_x;
    self.des_y = data.des_y;
    self.des_z = data.des_z;
    self.npc_id = data.npc_id;
    self.custom_data = data.custom_data;
    if self.npc_id then
        local npc_info = ConfigManager.Get(EConfigIndex["t_"..self.des_world_id.."_npc"], self.npc_id)
        if not npc_info then return end
        self.des_x = npc_info.x - 0.5;
        self.des_y = 0;
        self.des_z = npc_info.y - 0.5;
    end
    self.isNear = false;
end

------------------------------内部接口-------------------------------------------
function AutoPathFinding:StartPathFinding(scene_entity, cur_world_id, des_world_id, des_x,des_y,des_z)
    if not FightScene.GetPlayMethodType() then return end
    --if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_openWorld then return end
    local path = self:FindPath(scene_entity, cur_world_id, des_world_id, des_x,des_y,des_z);
    --app.log("cur_world_id, des_world_id=="..cur_world_id.."    "..des_world_id.."   x,y,z="..table.tostring({des_x,des_y,des_z}));
    --app.log("path=="..table.tostring(path));
    self.my_captain = scene_entity;
    self.path = path;
    if not self.path or type(self.path) ~= "table" then return end
    local des = self.path[self.cur_world_id];
    self.world_id_count = 1;
    self.isPause = false;
    self:MoveToDes(des);
end

function AutoPathFinding:StopPathFind()
    self.isFinding = false;
    self.isPause = true;
    self.cur_world_id = nil;
    self.path = {};
    self.path_world_id = {};
    self.world_count = nil;
    PublicFunc.msg_dispatch("AutoPathFinding_Start_Find",false)
end

function AutoPathFinding:Init()
    self.isFinding = false;
    self.cur_world_id = nil;
    self.path = {};
    self.path_world_id = {};
    self.world_count = nil;
    self.isPause = true;

    self.OnChangeCaptionFunc = Utility.bind_callback(self, self.OnChangeCaption)
    PublicFunc.msg_regist(Player.ChangeCaptain,self.OnChangeCaptionFunc)
end

--跨地图寻路
function AutoPathFinding:FindPath(scene_entity, cur_world_id, des_world_id, des_x,des_y,des_z)
    local path = {};
    local country_id = g_dataCenter.player.country_id;
    if not country_id then
        app.log("没有国家id，无法寻路");
        return nil;
    end
    if cur_world_id == des_world_id then
        self.path_world_id = {}
        self.path_world_id[1] = cur_world_id
    else
        local ret1 = self:GetWorldMapPath(country_id, cur_world_id, des_world_id);
        --app.log("找到的路径=="..table.tostring(ret1));
        if not ret1 then
            app.log("没找到路径1，   country_id, cur_world_id, des_world_id=="..table.tostring({country_id, cur_world_id, des_world_id}));
            return
        end
        ret = self:GetMinPath(ret1);
        if not ret then
            app.log("没找到路径2，   country_id, cur_world_id, des_world_id=="..table.tostring({country_id, cur_world_id, des_world_id}).."  jieguo=="..table.tostring(ret1));
            return
        end
        self.path_world_id = ret;
    end
    self.world_count = #self.path_world_id;
    self.cur_world_id = cur_world_id;
    local length = self.world_count;   --间隔地图个数
    local cur_pos = scene_entity:GetPosition(false);
    for i=1,length-1 do
        local tp_id,tp_destination, tp_pos = self:FindPathToNextMap(cur_pos, ret[i], ret[i+1]);
        if tp_destination.x == nil then
            app.log("error path cannot from "..ret[i].." to "..ret[i+1]);
        end
        cur_pos = tp_destination;
        path[self.path_world_id[i]] = tp_pos;
    end
    path[self.path_world_id[length]] = {x=des_x, y=des_y, z=des_z};

    return path;
end

--得到2个地图的所有路径
function AutoPathFinding:GetWorldMapPath(country_id, begin_id, end_id)
    local cfg = ConfigManager.Get(EConfigIndex.t_world_map_path, country_id)
    if not country_id or not cfg then
        return nil
    end
    if cfg[begin_id] then
        if cfg[begin_id][end_id] then
            return cfg[begin_id][end_id];
        else
            return nil;
        end
    else
        return nil;
    end
end

--得到2个地图的所有路径中最短的一个
function AutoPathFinding:GetMinPath(all_path)
    if not all_path or type(all_path) ~= "table" then
        return nil
    end
    local min_path = nil;
    local min_len = 99999;
    for k,v in pairs(all_path) do
        local length = PublicFunc.GetTableLen(v);
        if length < min_len then
            min_len = length;
            min_path = v;
        end
    end
    return min_path;
end

--找到当前地图中能够到达下一个地图最近的传送点
function AutoPathFinding:FindPathToNextMap(cur_pos, cur_map_id, next_map_id)
    local all_tp = ConfigHelper.GetMapInf(cur_map_id, EMapInfType.translation_point)
    if not all_tp then return nil end;
    local min_dis = 9999999;
    local nearest_tp_id = nil;
    local tp_destination = {};
    local tp_pos = {};
    for m,tp_info in pairs(all_tp) do
        --这个传送点能到达的地图
        local end_world_info = ConfigManager.Get(EConfigIndex.t_translation_point,tp_info.translation_point_id).end_world_info;
        for k,v in pairs(end_world_info) do
            if v.world_id == next_map_id then
                if cur_pos.x then
                    local dis = algorthm.GetDistance(cur_pos.x, cur_pos.z, tp_info.x, tp_info.y);
                    if dis < min_dis then
                        min_dis = dis;
                        nearest_tp_id = tp_info.translation_point_id;
                        tp_destination.x = v.x;
                        tp_destination.y = 0;
                        tp_destination.z = v.y;
                        tp_pos.x = tp_info.x;
                        tp_pos.y = 0;
                        tp_pos.z = tp_info.y;
                    end
                end
            end
        end
    end
    return nearest_tp_id, tp_destination, tp_pos;
end


function AutoPathFinding:MoveToDes(des)
    if not self.my_captain then return end
    if not des then return end
    --app.log("fffffffffffffffffffff   "..table.tostring({des.x,des.y,des.z}));
    local _found, px, py, pz = util.get_navmesh_sampleposition(des.x,des.y,des.z,5);
    if not _found then
        app.log_warning("没找到导航网格上相近的点");
        return
    end
    self.my_captain:SetNavFlag(true, false);
    self.result_point = self.my_captain.navMeshAgent:calculate_path(px, py, pz);
    if not self.result_point or #self.result_point < 2 then
        self:on_arrive_destination();
        return
    end
    if self.my_captain then
        self.my_captain:SetAttackTarget(nil)
    end
    self.destination_count = 2;
    local des = self.result_point[self.destination_count];
    self.isFinding = true;
    self.temp_des = des;

    PublicFunc.msg_regist("SceneEntity_SetAI_AutoPathFinding",Utility.bind_callback(self, self.ChangeAICallback));

    g_dataCenter.player:ChangeFightMode(false)
end

function AutoPathFinding:GetCurrentMoveToPointIndex()
    return self.destination_count
end

function AutoPathFinding:IsMoving()
    return self.isFinding
end

function AutoPathFinding:ChangeAICallback(id)

    if self.my_captain.handleFsm == nil then return end

    PublicFunc.msg_unregist("SceneEntity_SetAI_AutoPathFinding",Utility.bind_callback(self, self.ChangeAICallback));
    Utility.unbind_callback(self, self.ChangeAICallback)
    if not self.my_captain then return end
    self.my_captain:SetDestination(self.temp_des.x, self.temp_des.y, self.temp_des.z);
    self.my_captain:SetHandleState(EHandleState.MapMove);
    PublicFunc.msg_dispatch("AutoPathFinding_Start_Find",true)
end

function AutoPathFinding:GetCurrentPosition()
    --local player_pos = self.my_captain:GetPosition(false);

    local x, y, z = 0, 0, 0
    if self.my_captain then
        x, y, z = self.my_captain:GetPositionXYZ()
    end

    return x, y, z
end

function AutoPathFinding:Update(dt)
    if not self.my_captain or not self.isFinding or self.isPause then 
        --app.log_warning("AutoPathFinding:Update1111111");
        return false 
    end
    local player_posX, player_posY, player_posZ = self:GetCurrentPosition()

    local des = self.result_point;
    if not des or not des[self.destination_count] or not des[self.destination_count].x then
        --app.log_warning("AutoPathFinding:Update3333333");
        return false
    end
    
    local disSQ = algorthm.GetDistanceSquared(player_posX, player_posZ, des[self.destination_count].x, des[self.destination_count].z);
    if disSQ < checkArrivedDistSQ then
        if self.destination_count >= #self.result_point then
            -- self.isFinding = false;
            self.destination_count = self.destination_count + 1;
            self:on_arrive_destination();
            --app.log_warning("AutoPathFinding:Update4444444444");
            return false
        else
            self.destination_count = self.destination_count + 1;
            self.my_captain:SetDestination(des[self.destination_count].x, des[self.destination_count].y, des[self.destination_count].z);
        end
    else
        self.my_captain:SetDestination(des[self.destination_count].x, des[self.destination_count].y, des[self.destination_count].z);
    end

    -- old is: dis < 5
    if disSQ < 25 then
        if self.world_id_count >= self.world_count and self.destination_count >= #self.result_point and not self.isNear then
            self.isNear = true;
        end
    end
    return true
end

function AutoPathFinding:on_arrive_destination()
    if self.world_id_count >= self.world_count then
        --app.log("到达目的地");
        self:StopPathFind();
        --触发NPC对话
        if self.npc_id then
            local fightManager = FightScene.GetFightManager();
            if fightManager and fightManager.SetTouchNpc then
                fightManager:SetTouchNpc(
                    self.my_captain, self.npc_id, 
                    self.des_x, self.des_y, self.des_z);
            end
        elseif self.custom_data then
            --自动杀怪
            if self.custom_data == "kill_monster" then
                app.log("到达杀怪点")
                g_dataCenter.player:ChangeFightMode(true)
            --自动采集
            elseif self.custom_data == "collect_xxx" then
                app.log("到达采集点")
            if GetMainUI():GetWorldTreasureBox() then
                GetMainUI():GetWorldTreasureBox():on_btn_open();
            end
            --寻路到目的地
            elseif self.custom_data == "special_des" then
                app.log("到达任务目的点")
            end
        end
    else
        -- app.log("到达传送点");
        -- --到达传送点
        -- self.world_id_count = self.world_id_count + 1;
        -- self.cur_world_id = self.path_world_id[self.world_id_count];
        -- local des = self.path[self.cur_world_id];
        -- self:MoveToDes(des);
    end
end

function AutoPathFinding:PausePathFind(isPause)
    self.isPause = isPause;
    if isPause then
        self.my_captain = nil;
    end
end

function AutoPathFinding:OnChangeCaption(oldCap, newCap)
    if not self.isFinding then return end

    self:StopPathFind()
    self.lastToDisination.my_captain = newCap
    self:SetDestination(self.lastToDisination)
end
