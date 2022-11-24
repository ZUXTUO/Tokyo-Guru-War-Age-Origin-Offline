
BossList = Class('BossList');


function BossList:Init()    
    self:init_data()
end

function BossList:init_data()    
    self.boss_data = {}

    local _map_boss = ConfigManager._GetConfigTable(EConfigIndex.t_map_boss)
    -- for k, v in pairs(gd_map_boss) do
     for k, v in pairs(_map_boss) do
        --怪物配置
        local _config = ConfigManager.Get(EConfigIndex.t_monster_property,v.boss_id)  

        table.insert(self.boss_data, {local_data = v, 
            status = ENUM.BossStatus.Killed, 
            config = _config})
    end
    --主mmo显示(保存boss_id)
    self.boss_data_brief = {}
end

function BossList:get_boss_count()    
    return #self.boss_data;
end

function BossList:get_boss_data(index)   
    return self.boss_data[index];
end

--[[主mmo显示]]
function BossList:get_boss_brief_count()    
    return #self.boss_data_brief;
end

function BossList:no_boss_brief()    
    return #self.boss_data_brief == 0
end

function BossList:get_boss_brief_data(index)   
    return self.boss_data_brief[index];
end

--[[发送跑马灯]]
function BossList:send_kill_boss_marquee(boss_list) 
    --发送可以击杀的跑马灯
    for _, v in pairs(boss_list) do
        if v.update_type == ENUM.BossStatus.CanKill then
            local dd = self:get_boss_data_by_id(v.id)
            if dd ~= nil then
                local data = {}
                data.ntype = MsgEnum.emarquee_msg_type.eRollMessage_type_go_to_kill_boss
                data.loopTimes = 1
                data.interval = 0
                data.content = ""
                data.vecParm = {tostring(dd.local_data.id), tostring(dd.local_data.map_id)}
                g_dataCenter.marquee:addMarquee(data)
            end            
        end
    end
end

--[[
struct boss_data
{
	int id;
	int update_type; //0:默认，可以杀  1:可以杀 2:已击杀
}
]]
function BossList:update_boss_status(boss_list) 
    for _, v in pairs(boss_list) do
        --更新数据
        local data = self:get_boss_data_by_id(v.id)
        if data ~= nil then
            if v.update_type == 0 then
                data.status = ENUM.BossStatus.CanKill
            else
                data.status = v.update_type 
            end            
        end
    end    
    --按时间, 等级及状态排序
    local curr_time_value = self:get_curr_time_value()
	table.sort(self.boss_data, function(a, b)  
        if a.status == b.status then
            local a_update_time = self:get_boss_update_time(a.local_data.update_time, curr_time_value)
            local b_update_time = self:get_boss_update_time(b.local_data.update_time, curr_time_value)
            if a_update_time == b_update_time then
                return a.config.level < b.config.level
            else                
                return a_update_time < b_update_time
            end
        else 
            return a.status < b.status
        end     
    end)
    --主mmo界面数据
    self.boss_data_brief = {}
    for k, v in pairs(self.boss_data) do
        if v.status == ENUM.BossStatus.CanKill then
            table.insert(self.boss_data_brief, v.local_data.boss_id)
        end
    end
end

function BossList:get_boss_data_by_id(id)   
    for _, v in pairs(self.boss_data) do
        if v.local_data.id == id then
            return v
        end 
    end
    return nil
end

--[[boss配置]]
function BossList:get_monster_config(local_data)
    return ConfigManager.Get(EConfigIndex.t_monster_property,local_data.boss_id)
end

function BossList:get_total_transform_cnt()    
     
    local vip_data = g_dataCenter.player:GetVipData();
    if vip_data then
        do return vip_data.free_tranform_to_boss_num; end
    end
end 

--[[获取剩余传送次数]]
function BossList:get_remain_transform_cnt()
    --已使用次数
    local used_cnt = g_dataCenter.player:GetTransformCnt()
    --还剩次数
    local remain_cnt = self:get_total_transform_cnt() - used_cnt
    if remain_cnt < 0 then
        remain_cnt = 0
    end
    return remain_cnt
end 

function BossList:save_curr_index(index)  
    self.curr_index = index
end

function BossList:get_boss_data_by_curr_index()
    return self:get_boss_data(self.curr_index)
end

--[[获取刷新时间字符串]]
function BossList:get_boss_update_time_str(index) 
    local data = self:get_boss_data(index)
    local time = self:get_boss_update_time(data.local_data.update_time, self:get_curr_time_value())
    return TimeAnalysis.FormatTime(time)
end

--[[获取刷新时间]]
function BossList:get_boss_update_time(update_time, curr_time_value)
    for k, v in pairs(update_time) do
        if tonumber(v) > curr_time_value then
            return v
        end
    end
    return update_time[1]
end

--[[当前时间]]
function BossList:get_curr_time_value()    
    local year,month,day,hour,min,sec = TimeAnalysis.ConvertToYearMonDay(system.time())
    return tonumber(hour) * 10000 +  tonumber(min) * 100 + tonumber(sec)    
end

--[[寻路]]
function BossList:path_finding(changeScene)
    local data = self:get_boss_data_by_curr_index() 
    local _my_captain = FightScene.GetFightManager().GetMyCaptain()
    local dd = 
    {
        my_captain = _my_captain,
        des_world_id = data.local_data.map_id,
        des_x = data.local_data.pos_x,
        des_y = 0,
        des_z = data.local_data.pos_y,
        custom_data = "kill_monster"
    }
    if changeScene then
        g_dataCenter.autoPathFinding:SetDestinationNextScene(dd)
    else
        g_dataCenter.autoPathFinding:SetDestination(dd)
    end
end