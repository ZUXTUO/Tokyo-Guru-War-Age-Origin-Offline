--概率测试开关
g_probabilityTest = false;

if g_probabilityTest then
    --世界boss幸运一击
    g_worldBossAttack = 0;
    g_worldBossLuckAttack = 0;
end


function GInitWorldBossLuckAttack()
    if not g_probabilityTest then
        return;
    end
    g_worldBossAttack = 0;
    g_worldBossLuckAttack = 0;
end
function GAddWorldBossLuckAttack()
    if not g_probabilityTest then
        return;
    end
    g_worldBossLuckAttack = g_worldBossLuckAttack + 1;
end
function GAddWorldBossAttack()
    if not g_probabilityTest then
        return;
    end
    g_worldBossAttack = g_worldBossAttack + 1;
end
function GWriteWorldBossLuckAttack()
    if not g_probabilityTest then
        return;
    end
    local file = file.open("world_boss_luck_attack.txt", 6);
    if not file then
        return;
    end
    file:write_string(tostring(g_worldBossAttack).."\t"..tostring(g_worldBossLuckAttack).."\n");
    file:close();
end


function GWriteGoldExchange(goldCnt)
   if not g_probabilityTest then
        return;
    end
    local file = file.open("gold_exchange.txt", 6);
    if not file then
        return;
    end
    file:write_string(tostring(goldCnt));
    file:close(); 
end

local TEXT_CONTENT = 
{
    [0] = "英雄",
    [1] = "装备",
    [2] = "金币",
    [3] = "魂匣活动",
    [4] = "积分英雄",
}
local TYPE_VAR = 
{
    [0] = {[0]="useOnceHeroTimes", [1]="useTenHeroTimes"},
    [1] = {[0]="useOnceEquipTimes", [1]="useTenEquipTimes"},
    [2] = {[0]="useOnceHeroTimesGold", [1]="useTenHeroTimesGold"},
}
function GWriteEgg(type, bTen, reward)
    if not g_probabilityTest then
        return;
    end
    if TYPE_VAR[type] == nil then
        return;
    end
    local nTen = 0;
    if bTen then
        nTen = 1;
    end
    local file = file.open("egg_use.txt", 6);
    if not file then
        return;
    end
    local str = tostring(g_dataCenter.egg[TYPE_VAR[type][nTen]]).."\t"..tostring(TEXT_CONTENT[type])
    .."\t"..tostring(nTen).."\t";
    for k, v in pairs(reward) do
        local cf = PropsEnum.GetConfig(v.id);
        if cf then
            str = str..tostring(cf.name).."\t"..tostring(v.count).."\t";
        else
            app.log("not find config id="..tostring(v.id));
        end
    end
    file:write_string(str);
    file:close(); 
end






---------------[[内存优化选项]]----------------
g_open_memory_reference_info = false;
g_open_bind_callback = false;
g_open_msg_regist = false;
g_memory_reference_info = require("logic.memory_reference_info");
g_memory_reference_info.m_cConfig.m_bAllMemoryRefFileAddTime = false;
g_memory_reference_info.m_cConfig.m_bSingleMemoryRefFileAddTime = false;
g_memory_reference_info.m_cConfig.m_bComparedMemoryRefFileAddTime = false;