--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/6
-- Time: 16:34
-- To change this template use File | Settings | File Templates.
--

PublicFunc = { }

--[[ 得到delta time ]]
function PublicFunc.getDeltaTime()
    return app.get_delta_time();
end

--[[ 主动GC ]]
function PublicFunc.lua_gc()
    -- util.begin_sample("lua_gc.collect");
    -- util.uwa_push_sample("lua_gc");
    collectgarbage("collect");
    -- util.uwa_pop_sample();
    -- util.end_sample();
end

function PublicFunc.GetCostItemSprite(id)
    local data = {
        [IdConfig.Gold]             = "dh_jinbi",  
        [IdConfig.Crystal]          = "dh_hongshuijing",  
        [IdConfig.RedCrystal]       = "dh_hongshuijing1",
        [IdConfig.FightSoul]        = "dh_zhanhun",
        [IdConfig.BronzeCoin]       = "dh_qingtongyinbi",
        [IdConfig.Medal]            = "dh_jiangpai",
        [IdConfig.ChallengeCoin]    = "dh_jixiantiaozhandaibi",
        [IdConfig.GuildContribution] = "dh_gongxian",
        [IdConfig.StudyPoint]       = "dh_yanjiudian",
        [IdConfig.ExpeditionCoin]   = "dh_zhanhun",
        [IdConfig.EquipDebris]      = "sc_shengxingsuipian",
    }
    return data[id] or ""
end

--[[ 输出日志 ]]
function PublicFunc.show_log(str)
    app.log(tostring(str));
end

--[[ 参数验证 nil ]]
function PublicFunc.check_type_nil(target)
    if type(target) == "nil" then
        return true;
    else
        return false;
    end
end

--[[ 参数验证 number ]]
function PublicFunc.check_type_number(target)
    if type(target) == "number" then
        return true;
    else
        return false;
    end
end

--[[ 参数验证 string ]]
function PublicFunc.check_type_string(target)
    if type(target) == "string" then
        return true;
    else
        return false;
    end
end

--[[ 参数验证 string == "" ]]
function PublicFunc.check_type_string_nil(target)
    if PublicFunc.check_type_string(target) then
        if type(target) == "" then
            return true;
        else
            return false;
        end
    else
        return false;
    end
end

--[[ 参数验证 table ]]
function PublicFunc.check_type_table(target)
    if type(target) == "table" then
        return true;
    else
        return false;
    end
end

--[[ 参数验证 function ]]
function PublicFunc.check_type_function(target)
    if type(target) == "function" then
        return true;
    else
        return false;
    end
end

-- 参数:待分割的字符串,分割字符
-- 返回:子串表.(含有空串)
function PublicFunc.string_split(str, split_char)
    local sub_str_tab = { };

    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    return sub_str_tab;
end

function PublicFunc.getAngleByPos(p1_x, p1_y, p1_z, p2_x, p2_y, p2_z)
    local p = { }
    p.x = p2_x - p1_x;
    p.z = p2_z - p1_z;
    local r = math.atan2(p.z, p.x) * 180 / math.pi + 180;
    -- app.log("夹角[-180 - 180]:"..r)
    return r
end

function PublicFunc.GetBitLShift(InfoList)
    if InfoList == nil then return end;

    if table.getn(InfoList) == 1 then
        return bit.bit_lshift(1, InfoList[1]);
    end

    local temp = bit.bit_lshift(1, InfoList[1]);
    for i = 2, table.getn(InfoList) do
        local value = bit.bit_lshift(1, InfoList[i]);
        temp = bit.bit_or(temp, value)
    end
    return temp;
end

function PublicFunc.BitOr(bit_mask)
    local value = 0;
    for k, v in pairs(bit_mask) do
        value = bit.bit_or(value, v)
    end
    return value
end

function PublicFunc.GetBitValue(info, index)
    local temp = bit.bit_lshift(1, index - 1); 
    local value = bit.bit_and(info, temp);
    return value;
end

function PublicFunc.obj_init(obj, pos)
    if obj == nil then return end;
    if pos then
        if not pos.x or not pos.y or not pos.z then
            app.log('调用公共函数PublicFunc.obj_init出错了，提供了pos参数但是内容是错的。' .. debug.traceback())
        end
        obj:set_local_position(pos.x, pos.y, pos.z);
    else
        obj:set_local_position(0, 0, 0);
    end
    obj:set_local_rotation(0, 0, 0);
    obj:set_local_scale(1, 1, 1);
end



-- info = {px = 0, py = 0.06, pz = 0,rx = 0, ry = 0, rz = 0,sx = 1, sy = 1, sz = 1}
function PublicFunc.SetGameObjPos3(obj, info)
    obj:set_local_position(info.px, info.py, info.pz);
    obj:set_local_rotation(info.rx, info.ry, info.rz);
    obj:set_local_scale(info.sx, info.sy, info.sz);
end

--[[ 暂停Unity的所有东西，包括计时器 ]]
function PublicFunc.UnityPause()
    app.set_time_scale(0);
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        local frame_info = {}
        frame_info.type = ENUM.FightKeyFrameType.FightPause
        frame_info.integer_params = {}
        frame_info.string_params = {}
        frame_info.float_params = {}
        FightKeyFrameInfo.AddKeyInfo(frame_info)
    end
    if PublicFunc._lastIsLockScreen ~= true then
        PublicFunc._lastIsLockScreen = g_ScreenLockUI.IsShow()

        if PublicFunc._lastIsLockScreen == true then
            g_ScreenLockUI.Hide()
        end
    end
end

--[[ 恢复Unity的所有东西，包括计时器 ]]
function PublicFunc.UnityResume()
    app.set_time_scale(1);
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        local frame_info = {}
        frame_info.type = ENUM.FightKeyFrameType.FightResume
        frame_info.integer_params = {}
        frame_info.string_params = {}
        frame_info.float_params = {}
        FightKeyFrameInfo.AddKeyInfo(frame_info)
    end
    if PublicFunc._lastIsLockScreen == true then
        --g_ScreenLockUI.Show()
        PublicFunc._lastIsLockScreen = false
    end
end

--[[ 获取字符串中标示的lua对象 ]]
function PublicFunc.GetStringObj(str, s_sep)
    if str == "" or str == nil or s_sep == "" or s_sep == nil then return nil end;
    local temp_table = Utility.lua_string_split(str, s_sep);
    local temp = "";
    if temp_table and temp_table[1] and temp_table[2] and _G[temp_table[1]] and _G[temp_table[1]][temp_table[2]] then
        temp = _G[temp_table[1]][temp_table[2]];
    end
    return temp;
end

--[[ 运行配置表中的string方法  xxxx@xxxxx ]]
function PublicFunc.RunStringFuns(s_funs, s_sep)
    local temp = PublicFunc.GetStringObj(s_funs, s_sep)
    if type(temp) == "function" then
        return temp();
    end
end

--[[ 请求当前时间 ]]
-- 返回值根据同步方式
function PublicFunc.QueryCurTime()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.FrameSync then
        return PublicStruct.Cur_Logic_Frame
    else
        return app.get_time()
    end
end

--[[ 请求时间差 ]]
-- lastTime 上次计时 源于PublicFunc.QueryCurTime()
-- 返回ms
function PublicFunc.QueryDeltaTime(lastTime)
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.FrameSync then
        return(math.abs(PublicStruct.Cur_Logic_Frame - lastTime) * PublicStruct.MS_Each_Frame)
    else
        local time = app.get_time()
        return(math.abs(time - lastTime) * 1000)
    end
end

function PublicFunc.QueryCurRealTime()
    return app.get_real_time()
end

function PublicFunc.QueryDeltaRealTime(lastTime)
    local time = app.get_real_time()
    return(math.abs(time - lastTime) * 1000)
end

--[[ 请求未来时间 ]]
-- passTime 经过的时间[ms]
-- 返回值根据同步方式
function PublicFunc.QueryFutureTime(passTime)
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.FrameSync then
        return(PublicStruct.Cur_Logic_Frame + passTime / PublicStruct.MS_Each_Frame)
    else
        local time = app.get_time()
        return time + passTime * 0.001
    end
end

--[[ 现实时间转换为逻辑时间 ]]
function PublicFunc.Time2LogicTime(time)
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.FrameSync then
        return math.floor(time / PublicStruct.MS_Each_Frame)
    else
        return time
    end
end

--[[ 返回ui的全局坐标 ]]
function PublicFunc.GetUiWorldPosition(uiObj, endName)
    local x, y, z = uiObj:get_position();

    endName = endName or "uiroot";
    while uiObj:get_name() ~= endName do
        local parentObj = uiObj:get_parent();
        if parentObj == nil then
            break;
        end
        local parentX, parentY, parentZ = parentObj:get_local_position();
        x = x + parentX;
        y = y + parentY;
        z = z + parentZ;
        uiObj = parentObj;
    end
    return x, y, z;
end

function PublicFunc.GetHourMinuteSecond(totalSecond)
    local hour;
    local minute;
    local second;
    local yushu = totalSecond % 3600;
    hour = math.modf(totalSecond / 3600);
    minute = math.modf(yushu / 60);
    second = yushu % 60;
    return hour, minute, second
end

function PublicFunc.ToBoolTip(ret)
    if type(ret) == "number" then
        return ret == Gt_Enum_Wait_Notice.Success
    else
        return ret == true
    end
end

--[[ 根据id找到对应的配置表 ]]
function PublicFunc.IdToConfig(id)
    local info = nil;
    if PropsEnum.IsRole(id) then
        info = ConfigHelper.GetRole(id);
    elseif PropsEnum.IsEquip(id) then
        info = ConfigManager.Get(EConfigIndex.t_equipment,id);
    elseif PropsEnum.IsItem(id) then
        info = ConfigManager.Get(EConfigIndex.t_item,id);
    elseif PropsEnum.IsMonster(id) then
        info = ConfigManager.Get(EConfigIndex.t_monster_property,id);
    elseif PropsEnum.IsVaria(id) then
        info = ConfigManager.Get(EConfigIndex.t_item,id);
    else
        app.log("id:" .. tostring(id) .. "没有对应的配置表可读");
    end
    return info;
end

--[[ 技能枚举记数 ]]
function PublicFunc.EnumCreator(begin_num)
    if begin_num ~= nil then
        PublicFunc._enumIndex = begin_num
    else
        PublicFunc._enumIndex = PublicFunc._enumIndex + 1
    end
    return PublicFunc._enumIndex
end

--[[获取英雄图鉴的英雄显示列表]]

function PublicFunc.GetIllumstrationAllHero()
    local souls_asc = true;
    local have_asc = true;
    local start_asc = false;
    local level_asc = false;
    local package = g_dataCenter.package;
    local show_type = ENUM.EShowHeroType.All;
    
    local sort_func = function(a, b)
        if a.index ~= 0 and b.index == 0 then
            return have_asc;
        elseif a.index == 0 and b.index ~= 0 then
            return not have_asc;
        end
        if a.rarity < b.rarity then
            return start_asc;
        elseif a.rarity > b.rarity then
            return not start_asc;
        end
        if a.level < b.level then
            return level_asc;
        elseif a.level > b.level then
            return not level_asc;
        end
        if a.number > b.number then
            return true;
        end
        return false;
    end
    
    local herolist = { };
    local haveList = { };
    for k, v in pairs(ConfigHelper.GetRoleDefaultRarityTable()) do
        local card = package:find_card_for_num(1, v.default_rarity);
        if card then
            if (show_type == ENUM.EShowHeroType.All or show_type == ENUM.EShowHeroType.Have) and not haveList[v.default_rarity] then
                table.insert(herolist, card);
                haveList[card.default_rarity] = 1;
                haveList[card.is_show] = 1;
            end
        else
            if not haveList[v.id]
                and v.is_show == 1
                and v.id == v.default_rarity
                and(show_type == ENUM.EShowHeroType.All or show_type == ENUM.EShowHeroType.DontHave)
            then
                table.insert(herolist, CardHuman:new( { number = v.id }));
            end
        end
    end
    --for k, v in pairs( herolist ) do
    --    if v == nil then
    --        app.log( "===排序还会有空值？？" );
    --    else
    --        app.log( "====排序不是空值，打印下index:"..v.index );
    --    end
    --end
    table.sort(herolist, sort_func);
    return herolist;    
end

--[[ 获得英雄列表 ]]
-- show_type 参见ENUM.EShowHeroType
function PublicFunc.GetAllHero(show_type, package, team, souls_asc)
    --if souls_asc == nil then
        souls_asc = true;
    --end
    package = package or g_dataCenter.package;
    team = team or g_dataCenter.player:GetDefTeam();
    --show_type = show_type or ENUM.EShowHeroType.All;
    show_type = ENUM.EShowHeroType.All;
    
    local function getCardWeight(card)
        if card.index == 0 then
            card.index = 1
            if g_dataCenter.package:GetCountByNumber(card.config.hero_soul_item_id) >= card.config.get_soul then
                if souls_asc then
                    return 3
                else
                    return 2;
                end
            else
                return 1;
            end
        end
        if souls_asc then
            return 2;
        else
            return 3;
        end
    end
    local function getCardSoul(card)
        if card.index == 0 then
            card.index = 1
            local soulNum = g_dataCenter.package:GetCountByNumber(card.config.hero_soul_item_id);
            if soulNum > 0 then
                return 1/soulNum;
            else
                return 2;
            end
        end
        return 0;
    end
    local sort_func = function(a, b)
        if getCardWeight(a) < getCardWeight(b) then
            return false;
        elseif getCardWeight(a) > getCardWeight(b) then
            return true;
        end
        if a.team_pos < 4 and b.team_pos == 4 then
            return true;
        elseif b.team_pos < 4 and a.team_pos == 4 then
            return false;
        end
        if getCardSoul(a) < getCardSoul(b) then
            return true;
        elseif getCardSoul(a) > getCardSoul(b) then
            return false;
        end
        if a:GetFightValue() > b:GetFightValue() then
            return true;
        elseif a:GetFightValue() < b:GetFightValue() then
            return false;
        end
        if a.rarity > b.rarity then
            return true;
        elseif a.rarity < b.rarity then
            return false;
        end
        if a.number < b.number then
            return true;
        elseif a.number > b.number then
            return false;
        end
        return false;
    end

    local herolist = { };
    local haveList = { };
    for k, v in pairs(ConfigHelper.GetRoleDefaultRarityTable()) do
        local card = package:find_card_for_num(1, v.default_rarity);
        if card then
            card.index = 1
            if (show_type == ENUM.EShowHeroType.All or show_type == ENUM.EShowHeroType.Have) and not haveList[v.default_rarity] then
                card.team_pos = 4;
                table.insert(herolist, card);
                local def_team = team;
                if def_team then
                    for i = 1, 3 do
                        if def_team[i] == card.index then
                            herolist[#herolist].team_pos = i;
                            break;
                        end
                    end
                end
                haveList[card.default_rarity] = 1;
            end
        else
            if not haveList[v.id]
                and v.is_show == 1
                and v.id == v.default_rarity
                and(show_type == ENUM.EShowHeroType.All or show_type == ENUM.EShowHeroType.DontHave)
            then
                table.insert(herolist, CardHuman:new( { number = v.id }));
                herolist[#herolist].team_pos = 4;
            end
        end
    end
    table.sort(herolist, sort_func);
    return herolist;
end

--[[ 获得装备列表 ]]
-- pos_id，为空则为获得全部装备
-- 若sort_func为空则为默认排序 人物拥有>rarity>star>level>number
-- role_pri 人物拥有优先
-- rarity_pri 稀有度优先
-- star_pri 星级优先
-- lv_pri 等级优先
-- pri_list 强制优先
-- rarity, 指定某个品质
-- remove_list, 排除指定的uuid的装备
function PublicFunc.GetEquipment(pos_id, sort_func, role_pri, rarity_pri, star_pri, lv_pri, pri_list, rarity, remove_list)
    if role_pri == nil then
        role_pri = true;
    end
    if rarity_pri == nil then
        rarity_pri = true;
    end
    if star_pri == nil then
        star_pri = true;
    end
    if lv_pri == nil then
        lv_pri = true;
    end
    sort_func = sort_func or function(a, b)
        if pri_list then
            for k, v in ipairs(pri_list) do
                if a.index == v then
                    return true;
                end
                if b.index == v then
                    return false;
                end
            end
        end
        if tonumber(a.roleid) == 0 and tonumber(b.roleid) ~= 0 then
            return not role_pri;
        elseif tonumber(a.roleid) ~= 0 and tonumber(b.roleid) == 0 then
            return role_pri;
        end
        if a.rarity > b.rarity then
            return rarity_pri;
        elseif a.rarity < b.rarity then
            return not rarity_pri;
        end
        if a.star > b.star then
            return star_pri;
        elseif a.star < b.star then
            return not star_pri;
        end
        if a.level > b.level then
            return lv_pri;
        elseif a.level < b.level then
            return not lv_pri;
        end
        if a.number > b.number then
            return true;
        end
        return false;
    end
    local equipList = { };
    for k, v in pairs(g_dataCenter.package.list[2]) do
        if not pos_id or pos_id == 0 or v.position == pos_id then
            if not rarity or v.rarity == rarity then
                local remove = false
                if remove_list and type(remove_list) == "table" then
                    for m, n in pairs(remove_list) do
                        if n == v.index then
                            remove = true;
                            break;
                        end
                    end
                end
                if not remove then
                    table.insert(equipList, v);
                end
            end
        end
    end
    table.sort(equipList, sort_func);
    return equipList;
end

function PublicFunc.GenerateSkillTargetIndex(info, skill_id, buff_id, trigger_index, action_index, action_ref)
    if info then
        info.skill_id = skill_id;
        info.buff_id = buff_id;
        info.trigger_index = trigger_index;
        info.action_index = action_index;
        info.action_ref = action_ref;
    end
    if skill_id == nil or buff_id == nil or trigger_index == nil or action_index == nil or action_ref == nil then
        app.log("组合targets_inde出现问题".." skill_id="..tostring(skill_id).." buff_id="..tostring(buff_id).." trigger_index="..tostring(trigger_index).." action_index="..tostring(action_index).." action_ref="..action_ref.." "..debug.traceback())
    end
    local local_targets_index = "" .. tostring(skill_id) .. tostring(buff_id) .. tostring(trigger_index) .. tostring(action_index) .. tostring(action_ref)
    return local_targets_index
end

-- 设置下沉混排文本：2字以上文本头数量为2，少于2字文本头数量为1
function PublicFunc.SetSinkText(str, lab1, lab2)
    if str == nil then return end

    local str1, str2 = nil, nil
    if Utility.SubStringGetTotalIndex(str) > 2 then
        str1 = Utility.SubStringUTF8(str, 1, 2)
        str2 = Utility.SubStringUTF8(str, 3)
    else
        str1 = Utility.SubStringUTF8(str, 1, 1)
        str2 = Utility.SubStringUTF8(str, 2)
    end

    if lab1 then lab1:set_text(str1 or "") end
    if lab2 then lab2:set_text(str2 or "") end
end

local ERank123NameBg = 
{
    "phb_paiming1_1",
    "phb_paiming2_1",
    "phb_paiming3_1",
}
function PublicFunc.SetRank123SpriteBg(sprite, rank)
    local rankName = ""
    if rank > 0 and rank < 4 then
        rankName = ERank123NameBg[rank]
    else
        rankName = ""
    end
    sprite:set_sprite_name(rankName);
end

local ERank123Name = 
{
    "phb_paiming1",
    "phb_paiming2",
    "phb_paiming3",
    "phb_paiming4", -- 其他
}
function PublicFunc.SetRank123Sprite(sprite, rank)
    local rankName = ""
    if rank > 0 and rank < 4 then
        rankName = ERank123Name[rank]
    else
        rankName = ERank123Name[4]
    end
    sprite:set_sprite_name(rankName);
end

local ERank123ItemBg = 
{
    "phb_diban1",
    "phb_diban2",
    "phb_diban3",
    "phb_diban4", -- 其他
}
function PublicFunc.SetRank123ItemBg(sprite, rank)
    local rankName = ""
    if rank > 0 and rank < 4 then
        rankName = ERank123ItemBg[rank]
    else
        rankName = ERank123ItemBg[4]
    end
    sprite:set_sprite_name(rankName);
end

local EPassiveSkillRank =
{
        -- [1] = "[8aff00]初[-]",
    -- [2] = "[00f6ff]中[-]",
    -- [3] = "[ff00fc]高[-]",
    -- [4] = "[ff2323]特[-]",
    -- [5] = "[ff9c00]究[-]",
    [1] = "yx_chu",
    [2] = "yx_zhong",
    [3] = "yx_gao",
    [4] = "yx_te",
    [5] = "yx_jiu",
}
function PublicFunc.GetPassiveSkillRankText(skill_rank)
    if skill_rank then
        local text = EPassiveSkillRank[skill_rank];
        if text then
            return text;
        else
            return "";
        end
    else
        return "";
    end
end

local EEquipRarityName =
{
    [0] = "",
    [1] = "jibie4",
    [2] = "jibie3",
    [3] = "jibie2",
    [4] = "jibie1",
    [5] = "jibie5",
    [6] = "jibie6",
}
function PublicFunc.SetEquipRaritySprite(sprite, rarity_num)
    sprite:set_sprite_name(EEquipRarityName[rarity_num]);
end

local EIconFrameName =
{
    [0] = "touxiangbeijing1",
    -- 0星未获得的英雄，默认为1星边框
    [1] = "touxiangbeijing1",
    [2] = "touxiangbeijing2",
    [3] = "touxiangbeijing3",
    [4] = "touxiangbeijing4",
    [5] = "touxiangbeijing5",
    [6] = "touxiangbeijing6",
}

 
-- 设置品质框图片
function PublicFunc.SetIconFrameSprite(sprite, rarity_num)
    if sprite == nil or type(rarity_num) ~= "number" or rarity_num > 6 or rarity_num < 0 then
        -- app.log('SetIconFrameSprite sprite == nil' .. debug.traceback())
        return
    end
    sprite:set_sprite_name(EIconFrameName[rarity_num]);
end

-- 设置品质框图片
function PublicFunc.SetIconFrameSpritek(sprite, rarity_num)
    if sprite == nil or type(rarity_num) ~= "number" or rarity_num > 6 or rarity_num < 0 then
        -- app.log('SetIconFrameSprite sprite == nil' .. debug.traceback())
        return
    end
    sprite:set_sprite_name(EIconFrameName[rarity_num].."k");
end

-- 资质图片
local EAptitudeName =
{
    [1] = "tx_b",
    [2] = "tx_a",
    [3] = "tx_a_jia",
    [4] = "tx_s",
    [5] = "tx_s_jia",
    [6] = "tx_ss",
    [7] = "tx_ss",
    [8] = "tx_ss",
    [9] = "tx_sss",
    [10] = "tx_sss",
    [11] = "tx_sss",
}
-- 上阵资质图片
local EAptitudeNameFormation =
{
    [1] = "sz_b",
    [2] = "sz_a",
    [3] = "sz_a_jia",
    [4] = "sz_s",
    [5] = "sz_s_jia",
    [6] = "sz_ss",
    [7] = "sz_ss",
    [8] = "sz_ss",
    [9] = "sz_sss",
    [10] = "sz_sss",
    [11] = "sz_sss",
}
-- 设置资质图片
function PublicFunc.SetAptitudeSprite(sprite, aptitude, isFormationUi)
    if sprite == nil then
        return;
    end
    if type(aptitude) ~= "number" then
        sprite:set_active(false);
        return;
    end
--    app.log("PublicFunc.SetAptitudeSprite:"..sprite:get_name().."  "..tostring(aptitude))
    local eAname =  EAptitudeName[aptitude]
    if isFormationUi then
        eAname = EAptitudeNameFormation[aptitude]
    end
    if eAname then
        sprite:set_sprite_name(eAname);
        sprite:set_active(true);
    end
    
end

-- 资质文本
local EAptitudeText =
{
    [1] = "B",
    [2] = "A",
    [3] = "A+",
    [4] = "S",
    [5] = "S+",
    [6] = "SS",
    [7] = "SS",
    [8] = "SS",
    [9] = "SSS",
    [10] = "SSS",
    [11] = "SSS",
}

function PublicFunc.GetAptitudeText(aptitude)
    local txt = EAptitudeText[aptitude]
    txt = txt or ''
    return txt
end

-- 根据id, num设置icon外框
function PublicFunc.SetIconFrame(frame, id, num)
    local frameName = PublicFunc.GetIconFrame(id, num)

    frame:set_sprite_name(frameName);
end

-- 根据id, num设置icon外框
function PublicFunc.GetIconFrame(id, num)
    local v = 1
    -- 英雄根据英雄资质
    if PropsEnum.IsRole(id) then
        local info = ConfigHelper.GetRole(id)
        if info ~= nil and info.aptitude then
            -- 头像框 + 1
            v = info.aptitude + 1
        end
    else
        local info = PublicFunc.IdToConfig(id)
        if info ~= nil and info.rarity then
            v = info.rarity
        end
    end
    return EIconFrameName[v]
end

local ERestraintStr =
{
    [ENUM.ERestraint.Edge] = '锐',
    [ENUM.ERestraint.Solid] = '坚',
    [ENUM.ERestraint.Fast] = '疾',
    [ENUM.ERestraint.Unusual] = '特',
}

function PublicFunc.GetRestraintStr(restrain)
    return ERestraintStr[restrain] or ''
end

local ERestraintDamagePlus = 
{
    [ENUM.ERestraint.Edge] = ENUM.ERestraint.Solid,
    [ENUM.ERestraint.Solid] = ENUM.ERestraint.Fast,
    [ENUM.ERestraint.Fast] = ENUM.ERestraint.Unusual,
    [ENUM.ERestraint.Unusual] = ENUM.ERestraint.Edge,
}

local ERestraintDamageReduce = 
{
    [ENUM.ERestraint.Edge] = ENUM.ERestraint.Unusual,
    [ENUM.ERestraint.Solid] = ENUM.ERestraint.Edge,
    [ENUM.ERestraint.Fast] = ENUM.ERestraint.Solid,
    [ENUM.ERestraint.Unusual] = ENUM.ERestraint.Fast,
}

--获得克制属性的克制
function PublicFunc.GetRestraintDamagePlus(restrain)
    return ERestraintDamagePlus[restrain]
end
--获得克制属性的减免
function PublicFunc.GetRestraintDamageReduce(restrain)
    return ERestraintDamageReduce[restrain]
end

local ERestraint =
{
    [0] = { "", "", "" , '', ''},
    [1] = { "rui", "shuxing_rui", "jineng_rui1", 'js_rui' ,"tx_rui"},
    [2] = { "jian", "shuxing_jian", "jineng_jian1" , 'js_jian',"tx_jian"},
    [3] = { "ji", "shuxing_ji", "jineng_ji1" , 'js_ji',"tx_ji"},
    [4] = { "te", "shuxing_te", "jineng_te1", 'js_te',"tx_te" },
}
-- 设置克制属性对应图片
function PublicFunc.SetRestraintSprite(sprite, restraint_num, index)
    index = index or 3
    sprite:set_sprite_name(ERestraint[restraint_num][index]);
end
--
function PublicFunc.SetRestraintSpriteForSmallCard(sprite,restraint_num)
    sprite:set_sprite_name(ERestraint[restraint_num][5])
end

-- 设置克制属性对应底图
function PublicFunc.SetRestraintSpriteBk(sprite, restraint_num, nameIndex)
    --app.log_warning('PublicFunc.SetRestraintSpriteBk   discard!!! , use SetRestraintTextureBk')
    nameIndex = nameIndex or 1
    sprite:set_sprite_name(ERestraint[restraint_num][nameIndex]);
end

function PublicFunc.SetSkillRestraintSprite(sprite, restraint_num)
    sprite:set_sprite_name(ERestraint[restraint_num][3]);
end


local ERestraintDi =
{
    [1] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_rui.assetbundle",
    [2] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_jian.assetbundle",
    [3] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_ji.assetbundle",
    [4] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_te.assetbundle",
}
-- 升星结算 设置克制属性对应底图
function PublicFunc.SetRestraintTextureBk(texture, restraint_num)
    if texture and ERestraintDi[restraint_num] then
        texture:set_texture(ERestraintDi[restraint_num]);
    else
        app.log_warning(tostring(texture) .. " 克制属性不对 restraint_num=" .. tostring(restraint_num) .. " debug=" .. debug.traceback());
    end
end

-- 设置获取途径列表项背景图246x104
local EGetWayPicture =
{
    ["hero_trial"] = "ditu1",
    ["equip_comp"] = "ditu1",
    ["toy"] = "ditu1",
}
function PublicFunc.SetGetWaySprite(sprite, name)
    sprite:set_sprite_name(EGetWayPicture[name] or "");
end

-- 设置排行前三名美术字
local ERankName123 =
{
    [1] = "sjb_diyi1",
    [2] = "sjb_dier1",
    [3] = "sjb_disan1",
}
function PublicFunc.SetRankNameSprite(sprite, index)
    sprite:set_sprite_name(ERankName123[index] or "");
end

local EPageArrow = 
{
    normal = "st_fanye1",
    gray = "st_fanye2",
}
function PublicFunc.SetPageArrowSprite(sprite, enable)
    local name = enable and EPageArrow.normal or EPageArrow.gray
    sprite:set_sprite_name(name)
end

-- 设置卡片星星图片（正常，灰色）
local ECardStar = {
    normal = "xingxing1",
    gray = "xingxing3",
}
function PublicFunc.SetCardStarSprite(sprite, enable)
    local name = enable and ECardStar.normal or ECardStar.gray
    sprite:set_sprite_name(name)
end

local EItemBorderHead = {
    normal = "ty_liebiaokuang6",
    gray = "ty_liebiaokuang4",
}
function PublicFunc.SetItemBorderHead(sprite, enable)
    -- local name = enable and EItemBorderHead.normal or EItemBorderHead.gray
    -- sprite:set_sprite_name(name)
    if enable then
        sprite:set_color(1,1,1,1)
    else
        sprite:set_color(0,0,0,1)
    end
end

local EItemBorderContent = {
    normal = "ty_liebiaokuang1",
    gray = "ty_liebiaokuang3",
}
function PublicFunc.SetItemBorderContent(sprite, enable)
    local name = enable and EItemBorderContent.normal or EItemBorderContent.gray
    sprite:set_sprite_name(name)
end

local EAcquireIcon = {
    [1] = "ty_liebiaokuanghuoyan",
    --TODO 其他图标还没有出来
}
function PublicFunc.SetAcquireIcon(sprite, index)
    local name = EAcquireIcon[index] or ""
    sprite:set_sprite_name(name)
end

--设置图文混排VIP
function PublicFunc.SetImageVipLevel(image_label, vip_level, need_show_v0)
    if image_label then
        image_label:set_text(tostring(vip_level or 0))
        --v0需要隐藏
        if not need_show_v0 then
            image_label:set_active(tonumber(vip_level or 0) > 0)
        end
    end
end

----------------- 封装锁定消息接口（超时自动解锁） ----------------
local _lockSendMsg = { };
local _LockTimeOut = function(msg, key)
    if _lockSendMsg[msg] ~= nil and
        _lockSendMsg[msg][key] ~= nil then
        _lockSendMsg[msg][key]["cbfunc"] = nil;
        _lockSendMsg[msg][key]["cbtimer"] = nil;
        _lockSendMsg[msg][key] = nil;
    end
end

-- 消息加锁，msg为nil，表示锁定整条消息
-- 返回：（true/false 成功/失败 锁定失败表示尚未解锁）
function PublicFunc.lock_send_msg(msg, key)
    if _lockSendMsg[msg] == nil then
        _lockSendMsg[msg] = { };
    end

    local result = false;
    key = tostring(key);
    if _lockSendMsg[msg][key] == nil then
        -- 生成计时器
        _lockSendMsg[msg][key] = { }
        local cbfuncName = Utility.gen_callback(_LockTimeOut, msg, key);
        _lockSendMsg[msg][key]["cbfunc"] = cbfuncName;
        _lockSendMsg[msg][key]["cbtimer"] = timer.create(cbfuncName, 3000, 1);

        result = true;
    end

    return result;
end

-- 去锁定，默认fun为nil时去所有锁定
function PublicFunc.unlock_send_msg(msg, key)
    if msg == nil then
        for msg, data1 in pairs(_lockSendMsg) do
            for key, data2 in pairs(data1) do
                timer.stop(_lockSendMsg[msg][key]["cbtimer"]);
                _lockSendMsg[msg][key]["cbfunc"] = nil;
                _lockSendMsg[msg][key]["cbtimer"] = nil;
                _lockSendMsg[msg][key] = nil;
            end
        end
        _lockSendMsg = { }
    else
        key = tostring(key);
        if _lockSendMsg[msg] and _lockSendMsg[msg][key] then
            timer.stop(_lockSendMsg[msg][key]["cbtimer"]);
            _lockSendMsg[msg][key]["cbfunc"] = nil;
            _lockSendMsg[msg][key]["cbtimer"] = nil;
            _lockSendMsg[msg][key] = nil;
        end
    end
end

function PublicFunc.is_lock_msg(msg, key)
    local result = false
    if msg then 
        local data = _lockSendMsg[msg]
        if data and data[tostring(key)] ~= nil then
            result = true
        end
    end
    return result;
end

----------------- 封装消息注册回调 ----------------
PublicFunc.msg_dispatch_callback_list = { };
PublicFunc.msg_dispatch_callback_list_ex = { };--用于小红点分发，必须在逻辑层处理之后，就不在逻辑层加排序了。
PublicFunc.wait_unregist_list = { };
if g_open_msg_regist then
    g_msg_regist = {};
end
function PublicFunc.msg_regist(msg, callback)
    if msg == nil then
        app.log(debug.traceback())
    end
    if not PublicFunc.msg_dispatch_callback_list[msg] then
        PublicFunc.msg_dispatch_callback_list[msg] = { };
    end
    if callback == nil then
        app.log(debug.traceback())
    end
    if g_open_msg_regist then
        if not g_msg_regist[msg] then
            g_msg_regist[msg] = {}
        end
        g_msg_regist[msg][callback] = tostring(debug.traceback());
        -- if msg == "stop_skill_cd" then
        --     app.log("1...."..tostring(callback))
        -- end
    end
    PublicFunc.msg_dispatch_callback_list[msg][callback] = callback;
end



function PublicFunc.msg_unregist(msg, callback)
    if not PublicFunc.msg_dispatch_callback_list[msg] then
        return;
    end
    -- PublicFunc.msg_dispatch_callback_list[msg][callback] = nil;
    -- app.log("注销"..#PublicFunc.wait_unregist_list);
    PublicFunc.wait_unregist_list[#PublicFunc.wait_unregist_list + 1] = { };
    PublicFunc.wait_unregist_list[#PublicFunc.wait_unregist_list].msg = msg;
    PublicFunc.wait_unregist_list[#PublicFunc.wait_unregist_list].callback = callback;
end

function PublicFunc.msg_regist_ex(msg,callback)
    if not PublicFunc.msg_dispatch_callback_list_ex[msg] then
        PublicFunc.msg_dispatch_callback_list_ex[msg] = {}
    end
    if callback  == nil then
        app.log(debug.traceback())
    end
    PublicFunc.msg_dispatch_callback_list_ex[msg][callback] = callback
end

function PublicFunc.msg_unregist_ex(msg, callback)
    if not PublicFunc.msg_dispatch_callback_list_ex[msg] then
        return;
    end
    -- PublicFunc.msg_dispatch_callback_list[msg][callback] = nil;
    -- app.log("注销"..#PublicFunc.wait_unregist_list);
    PublicFunc.wait_unregist_list[#PublicFunc.wait_unregist_list + 1] = { };
    PublicFunc.wait_unregist_list[#PublicFunc.wait_unregist_list].msg = msg;
    PublicFunc.wait_unregist_list[#PublicFunc.wait_unregist_list].callback = callback;
end

function PublicFunc.UnregistAllMsg()
    if PublicFunc.wait_unregist_list then
        for k, v in pairs(PublicFunc.wait_unregist_list) do
            local msg = v.msg;
            local callback = v.callback;
            -- app.log("清空");
            PublicFunc.wait_unregist_list[k] = nil;
            PublicFunc.msg_dispatch_callback_list[msg][callback] = nil;
            if g_open_msg_regist then
                -- if msg == "stop_skill_cd" then
                --     app.log("2...."..tostring(callback))
                -- end
                g_msg_regist[msg][callback] = nil;
                if table.get_num(g_msg_regist[msg]) <= 0 then
                    g_msg_regist[msg] = nil;
                end
            end
            -- if PublicFunc.msg_dispatch_callback_list_ex[msg] then
            --     PublicFunc.msg_dispatch_callback_list_ex[msg][callback] = nil
            --      PublicFunc.msg_dispatch_callback_list_ex[msg] = nil
            -- end
        end
        
    end
end

function PublicFunc.msg_dispatch(msg_name, ...)
    if PublicFunc.msg_dispatch_callback_list[msg_name] then
        local i = 0;
        for k, v in pairs(PublicFunc.msg_dispatch_callback_list[msg_name]) do
            local p = { };
            for i = 1, arg['n'] do
                p[i] = arg[i];
            end
            i = i + 1;
            if type(v) == "string" then
                Utility.CallFunc(v, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
            elseif type(v) == "function" then
                v(p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
            end
        end
    end
    --......
    if PublicFunc.msg_dispatch_callback_list_ex[msg_name] then
        local i = 0;
        for k, v in pairs(PublicFunc.msg_dispatch_callback_list_ex[msg_name]) do
            local p = { };
            for i = 1, arg['n'] do
                p[i] = arg[i];
            end
            i = i + 1;
            if type(v) == "string" then
                Utility.CallFunc(v, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
            elseif type(v) == "function" then
                v(p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
            end
        end
    end
end

--[[ 活动string解析 ]]
-- str 源字符串
-- k 取那一部分 传字符串 m、d、h、i、s、
function PublicFunc.GetActivityCont(str, k)
    local id = k .. "=(%d+)";
    for k, v in string.gmatch(str, id) do
        return tonumber(k);
    end
    --app.log_warning("没有找到对应的关键字。k=" .. tostring(k) .. ",str=" .. tostring(k) .. debug.traceback());
    return 0;
end

--[[ 获取错误码的文本内容 ]]
-- error_code 错误码
-- isPrint 是否使用通用面板输出
-- 返回 一个bool值加一个字符串值   bool值为当前是否成功（现在非0错误码都代表不成功）字符串为配置错误显示字符串
function PublicFunc.GetErrorString(error_code, isPrint)
    if isPrint == nil then
        isPrint = true;
    end
    local num = tonumber(error_code);
    local isSuccess = true;
    local str = "";
    if error_code == MsgEnum.error_code.error_code_success then
        isSuccess = true;
    else
        str = ConfigManager.Get(EConfigIndex.t_error_code_cn,num);
        if str == nil then
            str = ConfigManager.Get(EConfigIndex.t_error_code_cn,1).tip .. tostring(error_code);
        else
            str = str.tip;
        end
        -- 如果设定了要输出就输出
        if isPrint then
            --HintUI.SetAndShow(EHintUiType.zero, str);
            -- 飘字提示
            FloatTip.Float(str)
            -- UiRollMsg.PushMsg({str=str})
        end
        isSuccess = false;
    end
    return isSuccess, str;
end

-- 场景坐标到ui坐标转换
function PublicFunc.SceneWorldPosToUIWorldPos(x, y, z)
    local sceneCamera = CameraManager.GetSceneCamera();
    local uiCamera = Root.get_ui_camera();
    local isSuc, ux, uy, uz = false, 0, 0, 0
    if sceneCamera ~= nil and uiCamera ~= nil then
        local sx, sy, sz = sceneCamera:world_to_screen_point(x, y, z)
        ux, uy, uz = uiCamera:screen_to_world_point(sx, sy, 0);
        isSuc = true
    else
        app.log('SceneWorldPosToUIWorldPos camera == nil or ui_camera == nil')
    end
    return isSuc, ux, uy, uz
end

 

-- 场景坐标到UI屏幕坐标
function PublicFunc.SceneWorldPosToUIScreenPos(x, y, z)
    local uiCamera = Root.get_ui_camera();
    local isSuc, sx, sy, sz = false, 0, 0, 0
    if uiCamera ~= nil then
        sx, sy, sz = uiCamera:world_to_screen_point(x, y, z)
        isSuc = true
    else
        app.log('SceneWorldPosToScreenPos camera == nil')
    end
    return isSuc, sx, sy, sz
end


--[[ 将总经验换算成相对应经验道具的个数 ]]
function PublicFunc.Exp2ExpItem(exp, item_list)
    if not exp or exp == 0 then
        return { }, 0;
    end
    local num = #item_list;
    if num == 0 then
        return { }, exp;
    end
    local list = { };
    table.sort(item_list, function(a, b)
        local a_cfg = PublicFunc.IdToConfig(a);
        local b_cfg = PublicFunc.IdToConfig(b);
        if a_cfg and b_cfg then
            return a_cfg.exp > b_cfg.exp;
        end
        return false;
    end )
    for i = 1, num do
        local cont = 0;
        local cfg = PublicFunc.IdToConfig(item_list[i]);
        if cfg and cfg.exp then
            cont = math.modf(exp / cfg.exp);
            if cont ~= 0 then
                table.insert(list, { id = item_list[i], num = cont });
                exp = exp - cfg.exp * cont;
            end
        end
    end
    return list, exp
end

-- 反向查找字符串:str为字符串，c为要查找的字符
function PublicFunc.string_rfind(str, c)
    return #str - str:reverse():find(c) + 1
end

-- 获取utf8字节的个数
function PublicFunc.GetUtf8Charbyte(info)
    local count = 0;
    local i = 1;
    local len = 0;
    local total = string.len(info);
    while i <= total do
        local bByte = string.byte(info, i);
        if bByte >= 252 then
            len = 6;
        elseif bByte >= 248 then
            len = 5;
        elseif bByte >= 240 then
            len = 4;
        elseif bByte >= 224 then
            len = 3;
        elseif bByte >= 192 then
            len = 2;
        else
            len = 1;
        end
        if len > 1 then
            count = count + 2;
        else
            count = count + 1;
        end
        i = i + len;
    end
    return count;
end

-- 获取utf8字符的个数
function PublicFunc.GetUtf8Character(info)
    local count = 0;
    local i = 1;
    local len = 0;
    local total = string.len(info);
    while i <= total do
        local bByte = string.byte(info, i);
        if bByte >= 252 then
            len = 6;
        elseif bByte >= 248 then
            len = 5;
        elseif bByte >= 240 then
            len = 4;
        elseif bByte >= 224 then
            len = 3;
        elseif bByte >= 192 then
            len = 2;
        else
            len = 1;
        end
        count = count + 1;
        i = i + len;
    end
    return count;
end
-- 取字符串的count个字符
function PublicFunc.SubUtf8Character(info, count)
    local i = 1;
    local len = 0;
    local total = string.len(info);
    local charTable = "";
    while i <= total and count > 0 do
        local bByte = string.byte(info, i);
        if bByte >= 252 then
            len = 6;
        elseif bByte >= 248 then
            len = 5;
        elseif bByte >= 240 then
            len = 4;
        elseif bByte >= 224 then
            len = 3;
        elseif bByte >= 192 then
            len = 2;
        else
            len = 1;
        end
        count = count - 1;
        charTable = charTable .. string.sub(info, i, i + len - 1);
        i = i + len;
    end
    return charTable;
end

-- 敏感词检查
function PublicFunc.IllegalName(name)
    local _illegal = ConfigManager._GetConfigTable(EConfigIndex.t_illegal)
    -- for i, v in pairs(gd_illegal or { }) do
    for i, v in pairs(_illegal or { }) do
        if string.find(name, tostring(v.name)) then
            return true
        end
    end
    return false
end
-- 保留几位小数且四舍五入函数
-- num 实际数
-- decimal 小数位数
function PublicFunc.Round(num, decimal)
    decimal = decimal or 0;
    local powNum = math.pow(10, decimal);
    num = num * powNum;
    num = math.floor(num + 0.5);
    num = num / powNum;
    return num;
end

local proTypeText =
{
    "防",
    "攻",
    "技",
}
-- 设置职业类型
function PublicFunc.SetProType(lab, proType)
    if lab == nil or proType == nil or proTypeText[proType] == nil then
        return;
    end
    lab:set_text("[" .. proTypeText[proType] .. "]");
end

-- 设置职业类型
function PublicFunc.SetProTypeTJ(lab, proType)
    if lab == nil or proType == nil or proTypeText[proType] == nil then
        return;
    end
    lab:set_text(proTypeText[proType]);
end

function PublicFunc.GetProTypeTxt(proType)
    return proTypeText[proType]
end

local proTypePic =
{
    [1] = "zr_fang",
    [2] = "zr_gong",
	[3] = "zr_ji",	 
}
-- 设置职业类型图片
function PublicFunc.SetProTypePic(sp, proType)
    if sp == nil or proType == nil or proTypePic[proType] == nil then
        return;
    end
    sp:set_sprite_name(proTypePic[proType]);
end

local proTypePic =
{
    [1] = "js_yeqian_fang2",
    [2] = "zjs_yeqian_gong2",
    [3] = "js_yeqian_ji2",   
}

function PublicFunc.SetProTypePicTJ(sp, proType)
    if sp == nil or proType == nil or proTypePic[proType] == nil then
        return;
    end
    sp:set_sprite_name(proTypePic[proType]);
end

local proTypeFont =
{
    [1] = "tx_fang",
    [2] = "tx_gong",
	[3] = "tx_ji",	 
}
-- 设置职业类型图片(文字图片)
function PublicFunc.SetProTypeFont(sp, proType)
    if sp == nil or proType == nil or proTypeFont[proType] == nil then
        return;
    end
    sp:set_sprite_name(proTypeFont[proType]);
end

function PublicFunc.SetCardInfoForUi(tCls,cardInfo)
    if type(tCls) ~= "table" or nil == cardInfo then
        app.log("PublicFunc.SetCardInfoForUi 参数类型错误,"..type(tCls).."  "..type(cardInfo))        
        return
    end
    --名称
    if tCls.lbl_name then
        tCls.lbl_name:set_text(cardInfo.name)
    end
    --
    if tCls.sp_nature then
        PublicFunc.SetAptitudeSprite(tCls.sp_nature, cardInfo.config.aptitude);
    end
    if tCls.sp_restraint_bg then
        PublicFunc.SetRestraintSpriteBk(tCls.sp_restraint_bg, cardInfo.config.restraint);
    end
    if tCls.sp_restraint then
        PublicFunc.SetRestraintSprite(tCls.sp_restraint, cardInfo.config.restraint);
    end
    if tCls.sp_pro_type then
        PublicFunc.SetProTypePic(tCls.sp_pro_type,cardInfo.pro_type,3)
    end
    if tCls.lbl_pro_type then
        PublicFunc.SetProType(tCls.lbl_pro_type, cardInfo.pro_type);
    end
   
end


--[[ 敏感字检查 ]]
function PublicFunc.Check_illegal(str)
    if str == nil or str == "" then return "" end;
    local i, j;

    local _illegal = ConfigManager._GetConfigTable(EConfigIndex.t_illegal)
    for k, v in pairs(_illegal) do
        i, j = string.find(str, tostring(v.name))
        if i ~= nil or j ~= nil then
            return v.name;
        end
    end
    return "";
end

-- 程序取名非法检测
function PublicFunc.CheckNameIllegal(str)
    local rstr = PublicFunc.Check_illegal(str);
    if rstr == "" then
        local i, j = string.find(str, " ");
        if i ~= nil or j ~= nil then
            return " "
        end
    end
    return "";
end

--[[ 处理敏感安为* ]]
function PublicFunc.SetIllegal(str)
    if str == nil or str == "" then return false end;

    local _illegal = ConfigManager._GetConfigTable(EConfigIndex.t_illegal)
    for k, v in pairs(_illegal) do
        str = string.gsub(str, tostring(v.name), "*");
    end
    return str;
end

--[[ 如去除字符串首尾的空格 ]]
function PublicFunc.trim(s)
    if s == nil or s == "" then return "" end;
    return(string.gsub(s, "^%s*(.-)%s*$", "%1"));
end


-- 技能屏蔽
-- cardHuman 英雄类对象
-- obj 显示锁的图标
-- index 当前第几个技能 4一技能 5二技能 6大招
function PublicFunc.SetSkillLock(cardHuman, obj, index)
    -- app.log(tostring(cardHuman.learn_skill[index])..".."..index.."..."..tostring(cardHuman.rarity).."..."..tostring(obj));
    local show = false;
    if cardHuman and index and cardHuman.learn_skill[index - 3] == nil then
        show = true;

        -- if cardHuman and index and cardHuman.rarity then
        -- 	if index == 4 then
        -- 		if cardHuman.rarity < 3 then
        -- 			show = true;
        -- 		end
        -- 	elseif index == 5 then
        -- 		if cardHuman.rarity < 2 then
        -- 			show = true;
        -- 		end
        -- 	elseif index == 6 then
        -- 		if cardHuman.rarity < 1 then
        -- 			show = true;
        -- 		end
        -- 	end
        -- 	if obj then
        -- 		obj:set_active(show);
        -- 	end
    end
    if obj then
        obj:set_active(show);
    end
    return show;
end

-- 将大于1万的数字转换成中文显示形式
function PublicFunc.NumberToCn(number, MinNumber, decimals_min, unit)
    -------看策划需求，是否要采用配置表，暂时写死------
    MinNumber = MinNumber or 10000;
    -- 当大于这个数时，采用+万
    unit = unit or 10000;
    -- 最小单元，万
    decimals_min = decimals_min or 100;
    -- 当除以1万以后，还大于这个数，就不用小数，否则使用1位小数
    -----------------------------------------

    local str = "";
    if number == nil then
        return str;
    end
    number = tonumber(number);
    if number >= MinNumber then
        number = number / unit;
        if number > decimals_min then
            number = math.floor(number);
            str = tostring(number) .. "万";
        else
            number = math.floor(number * 10);
            number = number / 10;
            if number == math.floor(number) then
                str = tostring(number) .. "万";
            else
                str = string.format("%0.1f", number) .. "万";
            end
        end
    else
        str = tostring(number);
    end
    return str;
end

function PublicFunc.NumberToString(number, min_number, unit, unit_value)
    local str = "";
    if number == nil then
        return str, true;
    end
    local num = tonumber(number);
    if num >= min_number then
        num = num / unit_value;
        if math.floor(num) ~= 0 then
            str = string.format(unit, num);
            return str, true;
        end
    end
    return tostring(number), false
end
function PublicFunc.NumberToStringByCfg(number)
    local str;
    local flg;
    local cfg = ConfigManager.Get(EConfigIndex.t_number_to_str, AppConfig.get_update_region());
    for k,v in ipairs(cfg or {}) do
        str,flg = PublicFunc.NumberToString(number, v.min_number, v.unit, v.unit_value);
        if flg then
            return str;
        end
    end
    return tostring(number)
end

-- 构造一个基本的卡牌数据
function PublicFunc.CreateCardInfo(id, count)
    local cardInfo = nil
    local carType = ENUM.EPackageType.Empty

    if PropsEnum.IsRole(id) then
        cardInfo = CardHuman:new( { number = id })
        carType = ENUM.EPackageType.Hero
    elseif PropsEnum.IsEquip(id) then
        cardInfo = CardEquipment:new( { number = id })
        carType = ENUM.EPackageType.Equipment
    elseif PropsEnum.IsItem(id) then
        cardInfo = CardProp:new( { number = id, count = count })
        carType = ENUM.EPackageType.Item
    else
        cardInfo = CardProp:new( { number = id, count = count or 0 })
        carType = ENUM.EPackageType.Other
    end

    return cardInfo, carType;
end

--加载配置属性表到hero对象
function PublicFunc.UpdateConfigHeroInfo(info, config, config_scale)
    --检查标记，更新过则跳过
    local update_config_mark = tostring(config)
    if info.update_config_mark == update_config_mark then
        return
    end

    info.update_config_mark = update_config_mark

    local data = {}
    data.property = {}
    data.learn_skill = {}

    for k, v in pairs(ENUM.EHeroAttribute) do
        data.property[v] = config[k] or 0
        --有属性缩放配置的
        if config_scale then
            data.property[v] = data.property[v] * (config_scale[k] or 1)
        end
    end
    
    local cardConfig = info.config
    table.insert(data.learn_skill, {id=cardConfig.spe_skill[1][1], level=config.skill4_level})
    table.insert(data.learn_skill, {id=cardConfig.spe_skill[2][1], level=config.skill5_level})
    table.insert(data.learn_skill, {id=cardConfig.spe_skill[3][1], level=config.skill6_level})

    local passiveConfig = ConfigManager.Get(EConfigIndex.t_role_passive_info, info.config.default_rarity);
    if passiveConfig and #passiveConfig >= 3 then
        data.passivity_property_info = {}
        table.insert(data.passivity_property_info, {id=passiveConfig[1].skill, level=config.skill4_level})
        table.insert(data.passivity_property_info, {id=passiveConfig[2].skill, level=config.skill5_level})
        table.insert(data.passivity_property_info, {id=passiveConfig[3].skill, level=config.skill6_level})
    end

    info:UpdateFightValueByExData(data)
end

function PublicFunc.GetDurationByEndTime(endTime)
    local nowTime = system.time()
    return math.max(0, math.ceil(endTime - nowTime))
end

--[[ 用户登录 帐号验证是不是手机号 ]]
function PublicFunc.check_str_is_phone(str)
    -- local temp_user_name = tonumber(str);
    -- if temp_user_name ~= nil then
    --  if string.len(temp_user_name) == 11 then
    --      return true;
    --  end
    -- end
    -- local b, e = string.find(str, "^1[34578][0-9]+$");
    local b, e = string.find(str, "^1[0-9]+$");
    if e == 11 then
        return true;
    end
    return false;
end

--[[ 用户登录 帐号验证是不是邮箱 ]]
function PublicFunc.check_str_is_email(str)
    --[[ 确认邮箱 ]]
    local check1 = string.find(str, '@', 1, true);
    if nil == check1 or check1 == 1 then
        return false;
    end

    -- local check1 = string.find(str, '^%w[-%w.+]*@%w[-%w]+%.%w[-%w%.]?%w$');

    local check2 = string.find(str, '.', check1, true);
    if nil == check2 or check2 == #str then
        return false;
    end

    return true
end
--[[ 用户登录 帐号验证 仅为字母+数字 ]]
function PublicFunc.check_str_is_num_or_letter(str)
    
    local check2 = string.find(str, "^[0-9]+$");
    
    if check2 then
        return false
    end
    
    local check1 = string.find(str, "^[a-zA-Z0-9]+$");
    if check1 then
        return true;
    end
    
    
    
    return false;
end
-- 弹出一个读条为0的load界面
function PublicFunc.ShowLoading()
    UiLevelLoadingNew.SetAndShow( { type_loading = ETypeLoading.normal });
    -- UiLevelLoadingNew.SetProgressBar(0);
end
--[[ 通过路径得到文件名 ]]
function PublicFunc.PathToName(path)
    local str_tab = Utility.lua_string_split(path, "/");
    local name = Utility.lua_string_split(str_tab[#str_tab], ".");
    return name[1];
end
--[[ 设置120头像 ]]
function PublicFunc.Set120Icon(sprite, path)
    sprite:set_sprite_atlas(SmallCardUi.humanAtlas120);
    sprite:set_sprite_name(PublicFunc.PathToName(path));
end

local spBkName =
{
    [ENUM.EHeroRarity.White] = "touxiangbeijing_bai",
    [ENUM.EHeroRarity.Green] = "touxiangbeijing_lv",
    [ENUM.EHeroRarity.Green1] = "touxiangbeijing_lv",
    [ENUM.EHeroRarity.Green2] = "touxiangbeijing_lv",
    [ENUM.EHeroRarity.Blue] = "touxiangbeijing_lan",
    [ENUM.EHeroRarity.Blue1] = "touxiangbeijing_lan",
    [ENUM.EHeroRarity.Blue2] = "touxiangbeijing_lan",
    [ENUM.EHeroRarity.Blue3] = "touxiangbeijing_lan",
    [ENUM.EHeroRarity.Purple] = "touxiangbeijing_zi",
    [ENUM.EHeroRarity.Purple1] = "touxiangbeijing_zi",
    [ENUM.EHeroRarity.Purple2] = "touxiangbeijing_zi",
    [ENUM.EHeroRarity.Purple3] = "touxiangbeijing_zi",
    [ENUM.EHeroRarity.Purple4] = "touxiangbeijing_zi",
    [ENUM.EHeroRarity.Orange] = "touxiangbeijing_cheng",
    [ENUM.EHeroRarity.Orange1] = "touxiangbeijing_cheng",
    [ENUM.EHeroRarity.Orange2] = "touxiangbeijing_cheng",
    [ENUM.EHeroRarity.Orange3] = "touxiangbeijing_cheng",
    [ENUM.EHeroRarity.Orange4] = "touxiangbeijing_cheng",
    [ENUM.EHeroRarity.Orange5] = "touxiangbeijing_cheng",
    [ENUM.EHeroRarity.Red] = "touxiangbeijing_hong",
    [ENUM.EHeroRarity.Red1] = "touxiangbeijing_hong",
}
--[[ 设置120头像底图 ]]
function PublicFunc.Set120BackSprite(sprite, star)
    sprite:set_sprite_atlas(SmallCardUi.humanAtlas120);
    sprite:set_sprite_name(spBkName[star]);
end

function PublicFunc.GetHumanRarityBgName(rarity)
    return spBkName[rarity]
end

function PublicFunc.computitemlevlsprite(heroid,lvl)

    local tablename = "t_training_hall_"..tostring(heroid)
    local level = ConfigManager.Get(EConfigIndex[tablename],lvl).adv_level;

    app.log("levle=================="..tostring(level))
    local colorStr = ""

    if level == 0 then
        colorStr = "touxiangbeijing2k"
    elseif level == 1 then
        colorStr = "touxiangbeijing3k"
    elseif level == 2 then
        colorStr = "touxiangbeijing4k"
    elseif level == 3 then
        colorStr = "touxiangbeijing5k"
    elseif level == 4 then
        colorStr  = "touxiangbeijing6k"
    end

    return colorStr

end

function PublicFunc.computitemlevelName(heroid,lvl,name)

    local tablename = "t_training_hall_"..tostring(heroid)
    local level = ConfigManager.Get(EConfigIndex[tablename],lvl).adv_level;

    --app.log("levle=================="..tostring(level))
    local colorStr = ""

    if level == 0 then
        colorStr = "[00ffa8]"..name.."[-]"
    elseif level == 1 then
        colorStr = "[10f1ff]"..name.."[-]"
    elseif level == 2 then
        colorStr = "[fa84ff]"..name.."[-]"
    elseif level == 3 then
        colorStr = "[ff571c]"..name.."[-]"
    elseif level == 4 then
        colorStr  = "[ffae00]"..name.."[-]"
    end

    return colorStr

end 

--[[ 通用，得到文字 ]]
function PublicFunc.GetWord(key)
    if AppConfig.get_update_region() == 1 then
        return tostring(gs_all_string_cn[key])
    else
        return tostring(gs_all_string_cn[key])
    end
end

-- set_on_ngui_click返回的点坐标，转换成ngui坐标（屏幕中心为0，0）
function PublicFunc.TouchPtToNguiPoint(x, y)
    local screen_width = app.get_screen_width();
    local screen_height = app.get_screen_height();
    local scale = 1280 / screen_width
    local x1 = x * scale;
    local y1 = y * scale;
    local ngui_x = x1 - 640;
    local ngui_y = y1 - 640 * screen_height / screen_width;
    return PublicFunc.Round(ngui_x), PublicFunc.Round(ngui_y);
end

function PublicFunc.GetTableLen(t)
    local a = 0;
    for k, v in ipairs(t) do
        a = a + 1;
    end
    return a;
end
function string.split(str, split_char)
    local sub_str_tab = { };
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    return sub_str_tab;
end

-- 数字连接 eg:123->w1w2w3
function PublicFunc.NumberToArtString(num, c)
    local str = tostring(num)
    local result = { }
    for i = 1, string.len(str) do
        local temp = string.sub(str, i, i)
        if temp ~= "-" then
            table.insert(result, temp)
        end
    end
    return c .. table.concat(result, c)
end

function PublicFunc.SetLeftAndRightNumber(label, num1, num2)
    num1 = tonumber(num1);
    num2 = tonumber(num2);
    if num1 >= num2 then
        label:set_text("[00FF2B]" .. PublicFunc.NumberToStringByCfg(num1) .. "[-]/" .. PublicFunc.NumberToStringByCfg(num2));
        -- label:set_text("[00FF2B]"..PublicFunc.NumberToStringByCfg(num2).."/"..PublicFunc.NumberToStringByCfg(num1).."[-]");
    else
        label:set_text("[FF0000]" .. PublicFunc.NumberToStringByCfg(num1) .. "[-]/" .. PublicFunc.NumberToStringByCfg(num2));
        -- label:set_text("[FF0000]"..PublicFunc.NumberToStringByCfg(num2).."/"..PublicFunc.NumberToStringByCfg(num1).."[-]");
    end
end

function PublicFunc.FuncIsOpen(id, in_level)
	--app.log("PublicFunc.FuncIsOpen:"..tostring(id))
    local unlockData = ConfigManager.Get(EConfigIndex.t_play_vs_data,id)
    if unlockData then
        local level = in_level or g_dataCenter.player.level
        if level >= unlockData.open_level then
            return true
        end
    else
        app.log_warning('open level not config,default is open:' .. tostring(id) )
        return true
    end
    return false
end

-- 格式化字符串根据#d?#中？的顺序格式化
function PublicFunc.FormatString(str, param)
    local i = 1;
    while (true) do
        if string.find(str, "#d" .. i .. "#") ~= nil then
            if param[i] then
                local temp = str;
                str = string.gsub(temp, "#d" .. i .. "#", tostring(param[i]))
            end
            i = i + 1;
        else
            break;
        end
    end
    return str;
end

-- 得到格式化图文字符串
function PublicFunc.GetImgTxtString(str)
    str = tostring(str) or ""

    if string.find(str, ',') then
        local temp = Utility.lua_string_split(str, ',')
        return "/" .. table.concat(temp, "/")
    else
        local temp = { }
        for i = 1, #str do
            table.insert(temp, string.sub(str, i, i))
        end
        return "/" .. table.concat(temp, "/")
    end
end

function PublicFunc.SetNodeActive(root, nodePath, is)
    if root then
        local node = root:get_child_by_name(nodePath)
        if node then
            node:set_active(false)
        end
    end
    
end

function PublicFunc.ClearUserDataRef(data, deepth)
    deepth = deepth or 1
    -- 检查深度上限，防止溢出
    if deepth > 10 then return end
    if type(data) == "table" then
        for k, v in pairs(data) do
            if type(v) == "userdata" then
                data[k] = nil
                -- 引用对象排除在外: 其中UI对象有其清理接口，不在这里清除；非UI对象不用清理
            elseif type(v) == "table" and v._className == nil then
                PublicFunc.ClearUserDataRef(v, deepth + 1)
            end
        end
    end
end

function PublicFunc.GetProgressColorStr(number_a, number_b,need_sep, decimals_min)
   -- app.log(string.format("PublicFunc.GetProgressColorStr number_a=%s,number_b=%s,need_sep=%s",tostring(number_a),tostring(number_b),tostring(need_sep)))
    local result = ""  
    local color_str = "[FF0000]"  
    if number_a >= number_b then
        color_str = "[FFFFFF]"
    end
    if nil == need_sep or  true == need_sep then
        local _num = PublicFunc.NumberToCn(number_a, nil, decimals_min, nil)
        if number_a >= number_b then
            _num = PublicFunc.GetColorText(_num .. "/", "new_green")
            result = color_str .. _num  .. PublicFunc.NumberToCn(number_b) .. "[-]";
        else
            result = color_str .. _num .. "/" .. PublicFunc.NumberToCn(number_b) .. "[-]";
        end
    else
        result = color_str .. PublicFunc.NumberToCn(number_b) .. "[-]" ;
    end
    return result
end

function PublicFunc.GetRoleIdByHeroNumber(role_number)
    --app.log("PublicFunc.GetRoleIdByHeroNumber:"..role_number)
    local role_index_cfg = ConfigManager.Get(EConfigIndex.t_role_index,role_number)
    if role_index_cfg then
        for k, v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_item)) do
            --app.log("k="..tostring(k).." v="..tostring(v.hero_number).."   dd:"..tostring(role_index_cfg.default_rarity))
            if v.hero_number == role_index_cfg.default_rarity then     
                ---app.log("PublicFunc.GetRoleIdByHeroNumber got:"..tostring(k) .."  "..table.tostring(v))
                return k
            end
        end
    else
        app.log("PublicFunc.GetRoleIdByHeroNumber role_index_cfg:  "..role_number)
    end
    return nil
end

--预定义颜色code
local _EPreColor = {
    ["gray"]            = "c6c6c6",
    ["red"]             = "ff0000",
    ["green"]           = "5aff00",
    ["yellow"]          = "ffe400",
    ["orange_yellow"]   = "ffa127",
    ["orange_light"]    = "fde517",
    ["blue_gray"]       = "808db7",
    ["purple"]          = "ad4bff",
    ["white"]           = "ffffff",

    ["new_green"]       = "00FF73",
    ["new_purple"]      = "E54F4D",
}
--返回预定义颜色值
function PublicFunc.GetPreColor(pre_color_code)
    return _EPreColor[pre_color_code] or _EPreColor.white
end
--生成指定含颜色code的文本内容
function PublicFunc.GetColorText(str, pre_color_code, str_color)
    if pre_color_code then
        return string.format("[%s]%s[-]", PublicFunc.GetPreColor(pre_color_code), str)
    elseif str_color then
        return string.format("[%s]%s[-]", str_color, str)
    else
        return str
    end
end

-------------------------- 文本描边颜色 --------------------------
--[[8b8b8b]]
function PublicFunc.SetUILabelEffectGray(uilabel)
    PublicFunc.SetUiLabelEffectColor(uilabel, 139/255, 139/255, 139/255, 1)
end

--[[973900]]
function PublicFunc.SetUILabelEffectRed(uilabel)
    PublicFunc.SetUiLabelEffectColor(uilabel, 151/255, 57/255, 0, 1)
end

--[[005997]]
function PublicFunc.SetUILabelEffectBlue(uilabel)
    PublicFunc.SetUiLabelEffectColor(uilabel, 0, 89/255, 151/255, 1)
end

-------------------------- 文本内容颜色 --------------------------
--[[c6c6c6 灰色.未开启 未激活 弱提示]] 
function PublicFunc.SetUILabelGray(uilabel)
    PublicFunc.SetUiSpriteColor(uilabel, 198/255, 198/255, 198/255, 1)
end

--[[ff0000 红色.禁用 错误]] 
function PublicFunc.SetUILabelRed(uilabel)
    PublicFunc.SetUiSpriteColor(uilabel, 255/255, 0/255, 0/255, 1)
end

--[[5aff00 绿色.条件达成]] 
function PublicFunc.SetUILabelGreen(uilabel)
    PublicFunc.SetUiSpriteColor(uilabel, 90/255, 255/255, 0/255, 1)
end

--[[FFE400 黄色.突出玩家]] 
function PublicFunc.SetUILabelYellow(uilabel)
    PublicFunc.SetUiSpriteColor(uilabel, 255/255, 228/255, 0/255, 1)
end

--[[FFA127 橙黄色.突出显示内容]] 
function PublicFunc.SetUILabelOrangeYellow(uilabel)
    PublicFunc.SetUiSpriteColor(uilabel, 255/255, 161/255, 39/255, 1)
end

--[[808db7 蓝灰色.大面积文字描述]] 
function PublicFunc.SetUILabelBlueGray(uilabel)
    PublicFunc.SetUiSpriteColor(uilabel, 128/255, 141/255, 183/255, 1)
end

--[[ad4bff 紫色.品质用]] 
function PublicFunc.SetUILabelPurple(uilabel)
    PublicFunc.SetUiSpriteColor(uilabel, 173/255, 75/255, 255/255, 1)
end

--[[ffffff 白色.正常文本]] 
function PublicFunc.SetUILabelWhite(uilabel)
    PublicFunc.SetUiSpriteColor(uilabel, 1, 1, 1, 1)
end


function PublicFunc.SetUiLabelEffectColor(uilabel,r,g,b,a)
    if uilabel and type(uilabel.set_effect_color) == "function" then
		uilabel:set_effect_color(r,g,b,a)
    end
end

--设置UISprite Color为灰色
function PublicFunc.SetUISpriteGray(uisprite)
    PublicFunc.SetUiSpriteColor(uisprite,0,0,0,1)
end
--设置UISprite Color为白色
function PublicFunc.SetUISpriteWhite(uisprite)
    PublicFunc.SetUiSpriteColor(uisprite,1,1,1,1)
end

--设置UISprite 颜色
function PublicFunc.SetUiSpriteColor(uisprite,r,g,b,a)
    if uisprite and type(uisprite.set_color) == "function" then
		uisprite:set_color(r,g,b,a)
    end
end

--[[设置sprite颜色]]
function PublicFunc.SetColorByRGBStr(uisprite, rgbStr, a)
    if type(rgbStr) ~= "string" then
        return
    end
    if string.len(rgbStr) ~= 6 then
        return
    end
    local r = tonumber(string.format("%d", "0x" .. string.sub(rgbStr, 1, 2)))
    local g = tonumber(string.format("%d", "0x" .. string.sub(rgbStr, 3, 4)))
    local b = tonumber(string.format("%d", "0x" .. string.sub(rgbStr, 5, 6)))
    if r == nil or g == nil or b == nil then
        app.log('rgb值错误!')
        return
    end
    PublicFunc.SetUiSpriteColor(uisprite, r/255, g/255, b/255, a) 
end


local EButtonData = {
    [1] = {nameSprite="ty_anniu3", colorTxt={151,57,0}},        --黄色
    [2] = {nameSprite="ty_anniu4", colorTxt={60,75,143}},       --蓝色
    [3] = {nameSprite="ty_anniu5", colorTxt={198,198,198}},     --灰色
}
--设置通用按钮显示模式 1:黄色 2:蓝色 3:灰色
function PublicFunc.SetButtonShowMode(btn, mode, spName, labName)
    local objBtn = btn:get_game_object(btn:get_name())
    local eData = EButtonData[mode]
    if objBtn and eData then
        local sp = ngui.find_sprite(objBtn, spName or "sp")
        if sp then
            sp:set_sprite_name(eData.nameSprite)
        end

        local lab = ngui.find_label(objBtn, labName or "lab")
        if lab then
            lab:set_color(eData.colorTxt[1]/255, eData.colorTxt[2]/255, eData.colorTxt[3]/255, 1)
        end
    end
end

function PublicFunc.GetButtonShowData(mode)
    return EButtonData[mode]
end

--[[设置item贴图]]
function PublicFunc.SetItemTexture(texture, itemId)
    if texture == nil or itemId == nil then
        return
    end 
    local info = PublicFunc.IdToConfig(itemId)
    if not info then
        return
    end
    if type(info.small_icon) == "string" then
        texture:set_texture(info.small_icon)
    end
end

--[[获取带颜色的金币]]
function PublicFunc.GetGoldStrWidthColor(gold, _flag)
    if gold == nil then
        return ""
    end
    if type(gold) ~= "number" then
        app.log("金币不为数值！")
        return ""
    end
    local flag = ""
    if _flag ~= nil then
        flag = _flag
    end
    if gold > PropsEnum.GetValue(IdConfig.Gold) then
        return "[ff0000]" .. flag .. PublicFunc.NumberToStringByCfg(gold) .. "[-]"
    else
        return "[ffffff]" .. flag .. PublicFunc.NumberToStringByCfg(gold) .. "[-]"
    end
end

-- 返回 {{id=,level=,enable=,passive=},...}
function PublicFunc.GetHeroSkillData(info)
    local result = {}
    --主动技能
    for i,v in ipairs(info.config.spe_skill) do
        local skill_id = v[1]
        local skill_level = 1
        local skill_enable = false

        if info.learn_skill and info.learn_skill[i] then
            local skill_data = info.learn_skill[i]
            skill_id = skill_data.id
            skill_level = skill_data.level
            skill_enable = true
        end
        
        table.insert(result, {id=skill_id, level=skill_level, enable=skill_enable, skillType=0});
    end
    --被动技能
    for i=1, 5 do
        local cfg = ConfigManager.Get(EConfigIndex.t_role_passive_info,info.config.default_rarity);
        if cfg and cfg[i] then
            if info.learn_passivity_property and info.learn_passivity_property[i] then
                local skill = info.learn_passivity_property[i]
                table.insert(result, {id=skill.id, level=skill.level, enable=true, skillType=1});
            else
                table.insert(result, {id=i, level=1, enable=false, skillType=1});
            end
        end
    end
    -- 光环技能
    local cfg_name = EConfigIndex["t_halo_property_"..info.config.default_rarity];
    if cfg_name then
        local skillLevelData = ConfigManager._GetConfigTable(cfg_name);
        if skillLevelData then
            if not info.halo_level or info.halo_level == 0 then
                table.insert(result, {id=1, level=info.halo_level or 1, enable=false, skillType=2});
            else
                table.insert(result, {id=1, level=info.halo_level, enable=true, skillType=2});
            end
        end
    end

    return result
end

function PublicFunc.FormatSkillString(str, skill_id, old_lv, new_lv, atk_power)
    local source_str = str
    local old_data, new_data
    if old_lv and skill_id then
        local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info, skill_id);
        if skillInfo and skillInfo[old_lv] then
            old_data = skillInfo[old_lv]
        end
    end
    if skill_id and new_lv then
        local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_level_info, skill_id);
        if source_str == nil then
            local skill_data = ConfigManager.Get(EConfigIndex.t_skill_info, skill_id);
            if skill_data then
                source_str = skill_data.base_describe
            end
        end
        if skillInfo and skillInfo[new_lv] then
            new_data = skillInfo[new_lv]
        end
    end
    if not source_str then
        app.log("找不到技能字符串。skillid："..skill_id);
        return "",0;
    end
    local _,_,attr_type,param = string.find(source_str, "#([defs])%-([%w_]+)#");
    local value = 1;
    while attr_type do
        if attr_type == "d" then
            local new_attr = nil;
            local new_atkscale = 0;
            local new_fixeddamage = 0;
            if type(new_data.damage) == "table" then
                new_attr = new_data.damage[tonumber(param)] or {};
                new_atkscale = new_attr.atkscale or 0;
                new_fixeddamage = new_attr.fixeddamage or 0;
            end
            local old_attr = nil;
            local old_atkscale = 0;
            local old_fixeddamage = 0;
            if old_data and type(old_data.damage) == "table" then
                old_attr = old_data.damage[tonumber(param)] or {};
                old_atkscale = old_attr.atkscale or 0;
                old_fixeddamage = old_attr.fixeddamage or 0;
            end
            local old_value = old_fixeddamage + atk_power * old_atkscale
            local new_value = new_fixeddamage + atk_power * new_atkscale
            value = new_value - old_value;
        elseif attr_type == "s" then
            local new_attr = 0;
            local old_attr = 0;
            if type(new_data.self_ability_change) == "table" then
                new_attr = new_data.self_ability_change[param] or 0;
            end
            if old_data and type(old_data.self_ability_change) == "table" then
                old_attr = old_data.self_ability_change[param] or 0;
            end
            value = new_attr - old_attr;
        elseif attr_type == "e" then
            local new_attr = 0;
            local old_attr = 0;
            if type(new_data.enemy_ability_change) == "table" then
                new_attr = new_data.enemy_ability_change[param] or 0;
            end
            if old_data and type(old_data.enemy_ability_change) == "table" then
                old_attr = old_data.enemy_ability_change[param] or 0;
            end
            value = new_attr - old_attr;
        elseif attr_type == "f" then
            local new_attr = 0;
            local old_attr = 0;
            if type(new_data.friend_ability_change) == "table" then
                new_attr = new_data.friend_ability_change[param] or 0;
            end
            if type(old_data.friend_ability_change) == "table" then
                old_attr = old_data.friend_ability_change[param] or 0;
            end
            value = new_attr - old_attr;
        end
        value = math.abs(value);
        source_str = string.gsub(source_str, "#"..attr_type.."%-"..param.."#",PublicFunc.AttrInteger(value))
        _,_,attr_type,param = string.find(source_str, "#([defs])%-([%w_]+)#");
    end
    return source_str,value;
end
function PublicFunc.FormatPassiveSkillString(str, skill_id, role_id, old_lv, new_lv)
    local source_str = str
    local old_data, new_data
    if old_lv and skill_id then
        local cfg_name = EConfigIndex["t_passive_property_"..role_id];
        local skillInfo = ConfigManager.Get(cfg_name,skill_id);
        if skillInfo and skillInfo[old_lv] then
            old_data = skillInfo[old_lv]
        end
    end
    if skill_id and new_lv then
        local cfg_name = EConfigIndex["t_passive_property_"..role_id];
        local skillInfo = ConfigManager.Get(cfg_name,skill_id);
        if source_str == nil then
            local role_data = ConfigManager.Get(EConfigIndex.t_role_passive_info, role_id);
            if role_data then
                local skill_data = role_data[skill_id];
                if skill_data then
                    source_str = skill_data.base_describe
                end
            end
        end
        if skillInfo and skillInfo[new_lv] then
            new_data = skillInfo[new_lv]
        end
    end
    if not source_str then
        app.log("找不到技能字符串。skillid："..skill_id.." role_id:"..role_id);
        return "",0;
    end
    local _,_,attr_type,param = string.find(source_str, "#([defs])%-([%w_]+)#");
    local value = 1;
    while attr_type do
        if attr_type == "s" then
            local new_attr = 0;
            local old_attr = 0;
            if new_data[param] ~= 0 then
                new_attr = new_data[param] or 0;
            end
            if old_data and old_data[param] ~= 0 then
                old_attr = old_data[param] or 0;
            end
            value = new_attr - old_attr;
        end
        value = math.abs(value);
        source_str = string.gsub(source_str, "#"..attr_type.."%-"..param.."#",PublicFunc.AttrInteger(value))
        _,_,attr_type,param = string.find(source_str, "#([defs])%-([%w_]+)#");
    end
    return source_str,value;
end
function PublicFunc.FormatHaloSkillString(str, skill_id, role_id, old_lv, new_lv)
    local source_str = str
    local old_data, new_data
    --app.log("找不到技能字符串。skillid："..skill_id.." role_id:"..role_id.. " lv:"..new_lv);
    if old_lv and skill_id then
        local cfg_name = EConfigIndex["t_halo_property_"..role_id];
        local skillInfo = ConfigManager._GetConfigTable(cfg_name);
        if skillInfo and skillInfo[old_lv] then
            old_data = skillInfo[old_lv]
        end
    end
    if skill_id and new_lv then
        local cfg_name = EConfigIndex["t_halo_property_"..role_id];
        local skillInfo = ConfigManager._GetConfigTable(cfg_name);
        if source_str == nil then
            local role_data = ConfigManager.Get(EConfigIndex.t_role_halo_info, role_id);
            if role_data then
                local skill_data = role_data[skill_id];
                if skill_data then
                    source_str = skill_data.base_describe
                end
            end
        end
        if skillInfo and skillInfo[new_lv] then
            new_data = skillInfo[new_lv]
        end
    end
    if not source_str then
        app.log("找不到技能字符串。skillid："..skill_id.." role_id:"..role_id);
        return "",0;
    end
    local _,_,attr_type,param = string.find(source_str, "#([defs])%-([%w_]+)#");
    local value = 1;
    while attr_type do
        if attr_type == "s" then
            local new_attr = 0;
            local old_attr = 0;
            if new_data[param] ~= 0 then
                new_attr = new_data[param] or 0;
            end
            if old_data and old_data[param] ~= 0 then
                old_attr = old_data[param] or 0;
            end
            value = new_attr - old_attr;
        end
        value = math.abs(value);
        source_str = string.gsub(source_str, "#"..attr_type.."%-"..param.."#",PublicFunc.AttrInteger(value))
        _,_,attr_type,param = string.find(source_str, "#([defs])%-([%w_]+)#");
    end
    return source_str,value;
end

local _HeroPropertyShowIdName = nil
local _HeroPropertyAllIdName = nil
-- 返回 {propert_id=propert_name, ...}
function PublicFunc.GetPropertyIdNamePair(isShow)    

    if isShow and _HeroPropertyShowIdName then 
        return _HeroPropertyShowIdName
    else
        _HeroPropertyShowIdName = {}
    end

    if not isShow and _HeroPropertyAllIdName then
        return _HeroPropertyAllIdName
    else
        _HeroPropertyAllIdName = {}
    end

    local result = nil
    if isShow then
        result = _HeroPropertyShowIdName
    else
        result = _HeroPropertyAllIdName
    end

    local propertId = nil
    local config = ConfigManager._GetConfigTable(EConfigIndex.t_property_show)
    local propert_id_name = {}
    for name, id in pairs(ENUM.EHeroAttribute) do
        propert_id_name[id] = name
    end

    -- app.log("=== config "..table.tostring(config))
    for k, v in pairs_key(config) do
        if not isShow or v.is_show == 1 then
            result[v.property_id] = propert_id_name[v.property_id]
        end
    end

    return result
end

-- 返回 {{show_name,show_value}, ...}
function PublicFunc.GetPropertyShowValue(info)
    local result = {}

    if info then
        local show_name, show_value = nil, nil
        for propert_id, propert_name in pairs_key(PublicFunc.GetPropertyIdNamePair(true)) do
            show_name = gs_string_property_name[ propert_id ]
            local add_property = 0
            -- if g_dataCenter.player:IsTeam(info.index, ENUM.ETeamType.normal) then
            --     local halo_info = g_dataCenter.player:GetTeamHaloInfo(ENUM.ETeamType.normal)
            --     if halo_info and halo_info.halo_property and halo_info.halo_property[ENUM.EHeroAttribute[propert_name]] then
            --         add_property = halo_info.halo_property[ENUM.EHeroAttribute[propert_name]]
            --     end
            -- end
            show_value = PublicFunc.GetPropertyValueForamt(propert_id, info:GetPropertyVal(propert_name)+add_property)
            table.insert(result, { show_name, show_value })
        end
    end

    return result
end

function PublicFunc.GetPropertyValueForamt(propert_id, value)
    local eValueType = ENUM.EAttributeValueType[propert_id]
    if  eValueType then
        if eValueType == 1 then
            value = math.floor(value)
        elseif eValueType == 2 then
            value = PublicFunc.Round(value,2)
        elseif eValueType == 3 then
            value = PublicFunc.Round(value,2).."%"
        end    
    end
    return tostring(value)
end

------------------ 钻石数量检查，不足跳转到充值界面 -----------------
-- 参数说明：
-- cbFunc 购买执行回调函数
-- cbParam 回调函数参数
-- costCount 消耗货币数量
-- costType  使用货币类型（当前仅默认钻石，后续可根据需要扩展）
function PublicFunc.BuyCheck(cbFunc, cbParam, costCount, costType)
    if cbFunc == nil or costCount == nil then 
		app.log("*** PublicFunc.BuyCheck 参数错误"..debug.traceback())
		return;
	end

	local costType = costType or IdConfig.Crystal
	local ownCount = g_dataCenter.player.crystal or 0
	if costCount > ownCount then
        if costType == IdConfig.Crystal then
            PublicFunc.GotoRecharge()
        else
            -- 根据需要添加其他类型货币获取方式
            local config = ConfigManager.Get(EConfigIndex.t_item, costType)
            if config then
                FloatTip.Float(tostring(config.name).."不足！");
            end
        end
	else
		Utility.CallFunc(cbFunc, cbParam)
	end
end

function PublicFunc.GotoRecharge()
    HintUI.SetAndShowNew(EHintUiType.two, 
        "钻石不足", "钻石不足！是否前往充值？", 
        nil,
        {func=function() uiManager:PushUi(EUI.StoreUI) end, str="立即前往"},
        {str="取消"} );
end

function PublicFunc.ExchangeGold(needGold)
    if needGold == nil then
        app.log("*** PublicFunc.ExchangeGold 参数错误"..debug.traceback())
        return
    end
    if needGold > PropsEnum.GetValue(IdConfig.Gold) then
        PublicFunc.GotoExchangeGold()
        return true
    end
    return false
end

function PublicFunc.GotoExchangeGold()
    HintUI.SetAndShowNew(EHintUiType.two, 
        "金币不足", "金币不足！是否前往兑换？", 
        nil,
        {func=function() uiManager:PushUi(EUI.GoldExchangeUI) end, str="立即兑换"},
        {str="取消"} )
end

--打印表
--tb 所需要打印的表
--perfix 打印的前綴，用於區分打印信息
--keys 為需要打印的字段名稱表
function PublicFunc.printTable(tb,perfix,keys)
    if keys ~= nil then 
        for k,v in pairs(keys) do 
            keys[v] = v;
        end 
    end 
    if perfix == nil then
        perfix = "";
    end
    for k,v in pairs(tb or {}) do
        if type(v) == "table" then
            app.log(perfix..tostring(k).." = "..tostring(v));
            PublicFunc.printTable(v,perfix.."  ",keys);
        else
            if keys ~= nil then 
                if keys[k] ~= nil then 
                    app.log(perfix..tostring(k).." = "..tostring(v));
                end 
            else
                app.log(perfix..tostring(k).." = "..tostring(v));
            end
        end
    end
end

local _RGB = {
    White = { r=1,g=1,b=1,a=1},                      --ffffff
    Green = { r=90/255,g=255/255,b=0/255,a=1},       --5aff00
    Blue = { r=0/255,g=192/255,b=255/255,a=1},       --00c0ff
    Purple = { r=173/255,g=75/255,b=255/255,a=1},    --ad4bff
    Orange = { r=255/255,g=161/255,b=39/255,a=1},    --ffa127
    Red = { r=1,g=0,b=0,a=1},                        --ff0000
}

function PublicFunc.GetBlueRgb()
    return _RGB.Blue
end

function PublicFunc.GetRedRgb()
    return _RGB.Red
end

function PublicFunc.GetRarityInfo(level)
    --app.log("#PublicFunc.GetRarityInfo# level ="..tostring(level))
    local level2key = function(level)
        for k,v in pairs(ENUM.EHeroRarity) do
            if level == v then
                return k
            end
        end
    end
    local rarity_name = level2key(level)
    local data = {
            ["White"] ={ level = 0, frameName = EIconFrameName[1],boxName=EIconFrameName[1].."k",rarityName = "",headBg = EIconFrameName[1],Rgb = _RGB.White},
            ["Green"] = { frameName = EIconFrameName[2],boxName=EIconFrameName[2].."k", rarityName = "pinzhi2",headBg = EIconFrameName[2],Rgb = _RGB.Green},
            ["Blue"]  = { frameName = EIconFrameName[3],boxName=EIconFrameName[3].."k",rarityName = "pinzhi3",headBg = EIconFrameName[3],Rgb = _RGB.Blue},
            ["Purple"] = { frameName = EIconFrameName[4],boxName=EIconFrameName[4].."k",rarityName = "pinzhi4",headBg = EIconFrameName[4],Rgb = _RGB.Purple},
            ["Orange"]   = { frameName = EIconFrameName[5],boxName=EIconFrameName[5].."k",rarityName = "pinzhi5",headBg = EIconFrameName[5],Rgb = _RGB.Orange},
            ["Red"] ={ frameName = EIconFrameName[6],boxName=EIconFrameName[6].."k",rarityName = "pinzhi6",headBg = EIconFrameName[6],Rgb = _RGB.Red}
    }
    if rarity_name then
        local _,_,name = string.find(tostring(rarity_name),"(%a+)")
        local _,_,level = string.find(tostring(rarity_name),"(%d+)")
       
        local _dd = data[name]
        if _dd then
            _dd.level = tonumber(level) or 0
        else
            app.log(string.format("#PublicFunc.GetRarityInfo# rarity_name=%s name=%s level=%s",tostring(rarity_name),tostring(name),tostring(level)))
        end
        --app.log(string.format("#PublicFunc.GetRarityInfo# rarity_name=%s name=%s level=%s",tostring(rarity_name),tostring(name),tostring(level)))
        return _dd
    else
        --app.log("PublicFunc.GetRarityInfo failed "..tostring(level))         
        return data["White"] 
    end
end

local __ColorString = 
{
    white = "ffffff";
    green = "00ffa8";--"5aff00";
    blue = "10f1ff";--"00c0ff";
    purple = "ff67fd";--"ad4bff";
    orange = "ffba26";--"ffa127";
    red = "ff194f"--"ff0000";
}

--[[升品的文本及颜色]]
local __heroRarityString = {
    [ENUM.EHeroRarity.White] = "[" .. __ColorString.white .. "]白色[-]",
    [ENUM.EHeroRarity.Green] = "[" .. __ColorString.green .. "]绿色[-]",
    [ENUM.EHeroRarity.Green1] = "[" .. __ColorString.green .. "]绿色+1[-]",   
    [ENUM.EHeroRarity.Green2] = "[" .. __ColorString.green .. "]绿色+2[-]",     
    [ENUM.EHeroRarity.Blue] = "[" .. __ColorString.blue .. "]蓝色[-]",  
    [ENUM.EHeroRarity.Blue1] = "[" .. __ColorString.blue .. "]蓝色+1[-]",  
    [ENUM.EHeroRarity.Blue2] = "[" .. __ColorString.blue .. "]蓝色+2[-]",  
    [ENUM.EHeroRarity.Blue3] = "[" .. __ColorString.blue .. "]蓝色+3[-]", 
    [ENUM.EHeroRarity.Purple] = "[" .. __ColorString.purple .. "]紫色[-]",  
    [ENUM.EHeroRarity.Purple1] = "[" .. __ColorString.purple .. "]紫色+1[-]",  
    [ENUM.EHeroRarity.Purple2] = "[" .. __ColorString.purple .. "]紫色+2[-]",  
    [ENUM.EHeroRarity.Purple3] = "[" .. __ColorString.purple .. "]紫色+3[-]",  
    [ENUM.EHeroRarity.Purple4] = "[" .. __ColorString.purple .. "]紫色+4[-]", 
    [ENUM.EHeroRarity.Orange] = "[" .. __ColorString.orange .. "]橙色[-]",  
    [ENUM.EHeroRarity.Orange1] = "[" .. __ColorString.orange .. "]橙色+1[-]",  
    [ENUM.EHeroRarity.Orange2] = "[" .. __ColorString.orange .. "]橙色+2[-]",  
    [ENUM.EHeroRarity.Orange3] = "[" .. __ColorString.orange .. "]橙色+3[-]",  
    [ENUM.EHeroRarity.Orange4] = "[" .. __ColorString.orange .. "]橙色+4[-]",
    [ENUM.EHeroRarity.Orange5] = "[" .. __ColorString.orange .. "]橙色+5[-]",
    [ENUM.EHeroRarity.Red] = "[" .. __ColorString.red .. "]红色[-]",
    [ENUM.EHeroRarity.Red1] = "[" .. __ColorString.red .. "]红色+1[-]",
}

--[[升品的文本及颜色]]
local __heroRarityStringnocolor = {
    [ENUM.EHeroRarity.White] = "白色",
    [ENUM.EHeroRarity.Green] = "绿色",
    [ENUM.EHeroRarity.Green1] = "绿色+1",   
    [ENUM.EHeroRarity.Green2] = "绿色+2",     
    [ENUM.EHeroRarity.Blue] = "蓝色",  
    [ENUM.EHeroRarity.Blue1] = "蓝色+1",  
    [ENUM.EHeroRarity.Blue2] = "蓝色+2",  
    [ENUM.EHeroRarity.Blue3] = "蓝色+3", 
    [ENUM.EHeroRarity.Purple] = "紫色",  
    [ENUM.EHeroRarity.Purple1] = "紫色+1",  
    [ENUM.EHeroRarity.Purple2] = "紫色+2",  
    [ENUM.EHeroRarity.Purple3] = "紫色+3",  
    [ENUM.EHeroRarity.Purple4] = "紫色+4", 
    [ENUM.EHeroRarity.Orange] = "橙色",  
    [ENUM.EHeroRarity.Orange1] = "橙色+1",  
    [ENUM.EHeroRarity.Orange2] = "橙色+2",  
    [ENUM.EHeroRarity.Orange3] = "橙色+3",  
    [ENUM.EHeroRarity.Orange4] = "橙色+4",
    [ENUM.EHeroRarity.Orange5] = "橙色+5",
    [ENUM.EHeroRarity.Red] = "红色[-]",
    [ENUM.EHeroRarity.Red1] = "红色+1[-]",
}


function PublicFunc.GetHeroRarityStr(rarity)
    if rarity == nil then
        return ""
    end
    return __heroRarityString[rarity]
end

function PublicFunc.GetHeroRarityStrnocolor(rarity)
    if rarity == nil then
        return ""
    end
    return __heroRarityStringnocolor[rarity]
end

function PublicFunc.GetEquipRarityStr(rarity)
    if rarity == nil then
        return ""
    end
    return __heroRarityString[rarity + 1]
end

local __heroRarity = {
    [ENUM.EHeroRarity.White] = __ColorString.white,
    [ENUM.EHeroRarity.Green] = __ColorString.green,
    [ENUM.EHeroRarity.Green1] = __ColorString.green,   
    [ENUM.EHeroRarity.Green2] = __ColorString.green,     
    [ENUM.EHeroRarity.Blue] = __ColorString.blue,  
    [ENUM.EHeroRarity.Blue1] = __ColorString.blue,  
    [ENUM.EHeroRarity.Blue2] = __ColorString.blue,  
    [ENUM.EHeroRarity.Blue3] = __ColorString.blue, 
    [ENUM.EHeroRarity.Purple] = __ColorString.purple,  
    [ENUM.EHeroRarity.Purple1] = __ColorString.purple,  
    [ENUM.EHeroRarity.Purple2] = __ColorString.purple,  
    [ENUM.EHeroRarity.Purple3] = __ColorString.purple,  
    [ENUM.EHeroRarity.Purple4] = __ColorString.purple, 
    [ENUM.EHeroRarity.Orange] = __ColorString.orange,  
    [ENUM.EHeroRarity.Orange1] = __ColorString.orange,  
    [ENUM.EHeroRarity.Orange2] = __ColorString.orange,  
    [ENUM.EHeroRarity.Orange3] = __ColorString.orange,  
    [ENUM.EHeroRarity.Orange4] = __ColorString.orange,
    [ENUM.EHeroRarity.Orange5] = __ColorString.orange,
    [ENUM.EHeroRarity.Red] = __ColorString.red,
    [ENUM.EHeroRarity.Red1] = __ColorString.red,
}

function PublicFunc.GetHeroRarity(rarity)
    if rarity == nil then
        return ""
    end
    return __heroRarity[rarity]
end

local __itemRarityColor = 
{
    [ENUM.EItemRarity.White] = __ColorString.white,
    [ENUM.EItemRarity.Green] = __ColorString.green,
    [ENUM.EItemRarity.Blue] = __ColorString.blue,
    [ENUM.EItemRarity.Purple] = __ColorString.purple,
    [ENUM.EItemRarity.Orange] = __ColorString.orange,
    [ENUM.EItemRarity.Red] = __ColorString.red,
}

function PublicFunc.GetItemRarityColor(rarity)
    local color = __itemRarityColor[rarity]
    if color == nil then
        color = __itemRarityColor[ENUM.EItemRarity.White]
    end
    return color
end

function PublicFunc.GetItemColorName(itemid)
    local name = ''
    local itemConfig = ConfigManager.Get(EConfigIndex.t_item,itemid)
    if itemConfig then
        name = "[" .. PublicFunc.GetItemRarityColor(itemConfig.rarity) "]" .. itemConfig.name .. "[-]"
    end
    return name
end

--[[装备名称]]
local __equipRarityString = {
    [ENUM.EEquipRarity.White] = "[" .. __ColorString.white .. "]%s[-]",
    [ENUM.EEquipRarity.Green] = "[" .. __ColorString.green .. "]%s[-]",
    [ENUM.EEquipRarity.Green1] = "[" .. __ColorString.green .. "]%s+1[-]",   
    [ENUM.EEquipRarity.Green2] = "[" .. __ColorString.green .. "]%s+2[-]",     
    [ENUM.EEquipRarity.Blue] = "[" .. __ColorString.blue .. "]%s[-]",  
    [ENUM.EEquipRarity.Blue1] = "[" .. __ColorString.blue .. "]%s+1[-]",  
    [ENUM.EEquipRarity.Blue2] = "[" .. __ColorString.blue .. "]%s+2[-]",  
    [ENUM.EEquipRarity.Blue3] = "[" .. __ColorString.blue .. "]%s+3[-]", 
    [ENUM.EEquipRarity.Purple] = "[" .. __ColorString.purple .. "]%s[-]",  
    [ENUM.EEquipRarity.Purple1] = "[" .. __ColorString.purple .. "]%s+1[-]",  
    [ENUM.EEquipRarity.Purple2] = "[" .. __ColorString.purple .. "]%s+2[-]",  
    [ENUM.EEquipRarity.Purple3] = "[" .. __ColorString.purple .. "]%s+3[-]",  
    [ENUM.EEquipRarity.Purple4] = "[" .. __ColorString.purple .. "]%s+4[-]", 
    [ENUM.EEquipRarity.Orange] = "[" .. __ColorString.orange .. "]%s[-]",  
    [ENUM.EEquipRarity.Orange1] = "[" .. __ColorString.orange .. "]%s+1[-]",  
    [ENUM.EEquipRarity.Orange2] = "[" .. __ColorString.orange .. "]%s+2[-]",  
    [ENUM.EEquipRarity.Orange3] = "[" .. __ColorString.orange .. "]%s+3[-]",  
    [ENUM.EEquipRarity.Orange4] = "[" .. __ColorString.orange .. "]%s+4[-]",
    [ENUM.EEquipRarity.Orange5] = "[" .. __ColorString.orange .. "]%s+5[-]",
    [ENUM.EEquipRarity.Red] = "[" .. __ColorString.red .. "]%s[-]",
    [ENUM.EEquipRarity.Red1] = "[" .. __ColorString.red .. "]%s+1[-]",
}
function PublicFunc.GetEquipName(name, rarity)
    if __equipRarityString[rarity] ~= nil then
        return string.format(__equipRarityString[rarity], name)
    end
    return ""
end

--[[道具名称]]
local __itemRarityString = {
    [ENUM.EItemRarity.White] = "[" .. __ColorString.white .. "]%s[-]",
    [ENUM.EItemRarity.Green] = "[" .. __ColorString.green .. "]%s[-]",   
    [ENUM.EItemRarity.Blue] = "[" .. __ColorString.blue .. "]%s[-]",      
    [ENUM.EItemRarity.Purple] = "[" .. __ColorString.purple .. "]%s[-]",     
    [ENUM.EItemRarity.Orange] = "[" .. __ColorString.orange .. "]%s[-]",      
    [ENUM.EItemRarity.Red] = "[" .. __ColorString.red .. "]%s[-]",
   
}
function PublicFunc.GetItemName(name, rarity)
    if __itemRarityString[rarity] ~= nil then
        return string.format(__itemRarityString[rarity], name)
    end
    return ""
end

local __equipRarityColor = {
    [ENUM.EEquipRarity.White] =  __ColorString.white,
    [ENUM.EEquipRarity.Green] = __ColorString.green,
    [ENUM.EEquipRarity.Green1] = __ColorString.green,   
    [ENUM.EEquipRarity.Green2] = __ColorString.green,     
    [ENUM.EEquipRarity.Blue] = __ColorString.blue,  
    [ENUM.EEquipRarity.Blue1] = __ColorString.blue,  
    [ENUM.EEquipRarity.Blue2] = __ColorString.blue,  
    [ENUM.EEquipRarity.Blue3] = __ColorString.blue, 
    [ENUM.EEquipRarity.Purple] = __ColorString.purple,  
    [ENUM.EEquipRarity.Purple1] = __ColorString.purple,  
    [ENUM.EEquipRarity.Purple2] = __ColorString.purple,  
    [ENUM.EEquipRarity.Purple3] = __ColorString.purple,  
    [ENUM.EEquipRarity.Purple4] = __ColorString.purple, 
    [ENUM.EEquipRarity.Orange] = __ColorString.orange,  
    [ENUM.EEquipRarity.Orange1] =  __ColorString.orange,  
    [ENUM.EEquipRarity.Orange2] = __ColorString.orange,  
    [ENUM.EEquipRarity.Orange3] = __ColorString.orange,  
    [ENUM.EEquipRarity.Orange4] =  __ColorString.orange,
    [ENUM.EEquipRarity.Orange5] = __ColorString.orange,
    [ENUM.EEquipRarity.Red] = __ColorString.red,
    [ENUM.EEquipRarity.Red1] = __ColorString.red,
}
function PublicFunc.GetEquipRarityColor(rarity)
    local color = __equipRarityColor[rarity]
    if color == nil then
        color = __equipRarityColor[ENUM.EEquipRarity.White]
    end

    return color
end


--击杀
local _MobaKillContentArray = {
    [1] = "击败",
    [2] = "双杀",
    [3] = "三杀！",
    [4] = "四杀超凡！",
    [5] = "五杀绝世！",
    [6] = "杀人如麻",
    [7] = "大杀特杀",
    [8] = "超神",
}
--团灭
local _MobaDeadContentArray = {
    [1] = "敌方团灭",
    [2] = "我方团灭",
    [3] = "击败敌方精英",
    [4] = "击败我方精英",
    [5] = "击败敌方守卫",
    [6] = "击败我方守卫",
    [7] = "击败领主",
    [8] = "领主死亡",
}
function PublicFunc.GetMobaKillMsgData(data, leftSide)
    local result = ""
    --击杀英雄
    if data.type == 1 then
        local content = _MobaKillContentArray[ math.min(data.kill_count, 8) ]
        result = {content=content, left_rid=data.left_rid, right_rid=data.right_rid, camp=data.camp, kill_count=data.kill_count}
    --团灭 精英/守卫被杀
    elseif data.type == 2 then
        local index = data.camp
        if data.tower_type == nil then
            
        elseif data.tower_type == 1 then
            index = index + 2
        elseif data.tower_type == 2 then
            index = index + 4
        elseif data.tower_type == 3 then
            index = index + 6
        end
        -- 己方阵营在右，交换位置
        if not leftSide then
            if index % 2 == 1 then
                index = index + 1
            else
                index = index - 1
            end
        end
        local content = _MobaDeadContentArray[ index ] or ""
		result = {content=content, camp=data.camp, left_rid=data.left_rid, right_rid=data.right_rid, dead_tower=data.tower_type}
    end
    return result;
end

--[[连协描述]]
function PublicFunc.GetContactDescData(roleData)
    if roleData == nil then
        app.log("role data is nil!")
        return
    end
    local contactConfig = ConfigManager.Get(EConfigIndex.t_role_contact, roleData.default_rarity)
    local retData = {}
    if contactConfig == nil then
        return retData        
    end
    app.log("roleData.default_rarity"..tostring(roleData.default_rarity))
    --拥有角色信息
    local info = roleData:GetHeroDefaultRarityCardInfo()
    for _, v in ipairs(contactConfig) do        
        local names = ""
        local isActive = true
        if v.contact_type == ENUM.ContactType.Hero then
            if v.contact_role ~= 0 then
                for index, number in pairs(v.contact_role) do
                    if index ~= 1 then
                        names = names .. "、"
                    end
                    --有此角色(金色)                    
                    if info[number] ~= nil then
                        local useName, addNum = PublicFunc.ProcessNameSplit(info[number].name)
                        names = names .."[FCD901FF]" .. useName .. "[-]"                        
                    --无此角色(灰色)
                    else
                        local roleConfig = ConfigHelper.GetRole(number)
                        local useName, addNum = PublicFunc.ProcessNameSplit(roleConfig.name)
                        names = names .. "[A2A2E2FF]" .. useName .. "[-]"
                        isActive = false
                    end
                end
            end
        else
            local equipConfig = ConfigManager.Get(EConfigIndex.t_equipment, v.equip_number)
            --获取相应的装备
            local dataid = roleData.equipment[equipConfig.position] 
            if tonumber(dataid) ~= 0 then
                local card = roleData.dataSource:find_card(ENUM.EPackageType.Equipment, dataid)
                if card then
                    --有此装备(金色)
                    if card.star >= equipConfig.star then 
                        local useName, addNum = PublicFunc.ProcessNameSplit(card.name)
                        names = "[FCD901FF]" .. useName .. "[-]"
                    --无此装备(灰色)
                    else
                        --取默认品级0
                        --local equipName = PublicFunc.GetEquipName(equipConfig.equip_name, ENUM.EEquipRarity.White)                        
                        names = "[A2A2E2FF]" .. equipConfig.equip_name .. "[-]"
                        isActive = false
                    end
                end            
            end
        end

        app.log("des============="..v.des)
        app.log("names=========="..names)
        local _desc = string.format(v.des, names)

        local _name = ""
        if isActive then
            _name = "[FCD901FF]" .. v.name .. "[-]"
        else
            _name = "[A2A2E2FF]" .. v.name .. "[-]"
        end
        table.insert(retData, {name = _name, desc = _desc})
    end
    return retData 
end

function PublicFunc.InActivityTime(eActivityId)
    local result = true
    local config = ConfigManager.Get(EConfigIndex.t_activity_time, eActivityId)
    local startime = PublicFunc.GetConfigDataValue(config.start_time)
    if type(startime) == "table" then
        result = false
        local nowTime = system.time()
        local nowDate = os.date('*t', nowTime)
        local duration = config.continue_time;
        for i, v in ipairs(startime) do
            local beginTime = os.time({year=nowDate.year, month=nowDate.month, day=nowDate.day, hour=v.h, min=v.i})
            local endTime = beginTime + duration
            if beginTime <= nowTime and endTime >= nowTime then
                result = true
                break;
            end
        end
    end

    return result;
end

-- 返回活动开启状态true/false，下一时间点（开启中->结束时间，未开启->开始时间，未限制时间->默认0）
function PublicFunc.InActivityTimeEx(eActivityId)
    local result = true
    local intervalTime = 0
    local config = ConfigManager.Get(EConfigIndex.t_activity_time, eActivityId)
    local startime = PublicFunc.GetConfigDataValue(config.start_time)
    if type(startime) == "table" then
        result = false
        local nowTime = system.time()
        local nowDate = os.date('*t', nowTime)
        local duration = config.continue_time;
        local nextDayTime = 0
        local timeType = 0 -- 1,2,3 -> 
        for i, v in ipairs(startime) do
            local beginTime = os.time({year=nowDate.year, month=nowDate.month, day=nowDate.day, hour=v.h, min=v.i})
            local endTime = beginTime + duration

            if i == 1 then
                nextDayTime = beginTime + 24 * 3600
            end

            if beginTime <= nowTime and endTime >= nowTime then
                result = true
            end

            if intervalTime == 0 then
                if result then
                    intervalTime = endTime - nowTime
                elseif nowTime < beginTime then
                    intervalTime = beginTime - nowTime
                elseif i == #startime then
                    --隔天开启下一次
                    intervalTime = nextDayTime - nowTime
                end
            end

            if result then
                break
            end
        end
    end

    return result, intervalTime;
end

function PublicFunc.GetActivityTimeSegment(eActivityId)
    local result = {}
    local config = ConfigManager.Get(EConfigIndex.t_activity_time, eActivityId)
    local startime = PublicFunc.GetConfigDataValue(config.start_time)

    if type(startime) == "table" then
        local begin_time = nil
        local end_time = nil
        for i, v in ipairs(startime) do
            begin_time = {h=v.h, i=v.i}
            local add_h = math.floor(config.continue_time / 3600)
            local add_i = math.floor((config.continue_time - add_h * 3600) / 60)
            end_time = {}
            end_time.h = begin_time.h + add_h
            end_time.i = begin_time.i + add_i
            table.insert(result, {begin_time,end_time})
        end
    end

    return result;
end

function PublicFunc.CreateSendTeamData(teamid, teamData)
    local team = {}
	local cardsList = {}

    if teamData == nil then
        app.log("重新配备队伍");
        local player = g_dataCenter.player;
        local teamid = ENUM.ETeamType.arena;
    
        local result = player:GetTeam(teamid)
        if Utility.isEmpty(result) then
            --local heroList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
            local heroList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
            table.sort(heroList, function (a,b)
                if a:GetFightValue() > b:GetFightValue() then
                    return true;
                end
                return false;
            end)
    
            local teamData = {}
            for k, v in pairs(heroList) do
                teamData[k] = v.index
                app.log("PublicFunc.CreateSendTeamData 英雄："..tostring(v.index));
            end
            --取战斗力最强的三个
            local team = PublicFunc.CreateSendTeamData(teamid, teamData)
            result = team.cards
        end
        teamData = result
    end

	for i=1, 3 do 
		cardsList[i] = teamData[i] or "0" -- 服务器记录了空位置信息
	end

	team.teamid = teamid or 0
	team.cards = cardsList
	-- 无用的部分
	-- team.heroLineup = nil
	-- team.soldierLineup = nil

	return team
end

function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end 
    
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

table.contains = function(t, v)
    if t == nil then
        app.log("table is nil")
    else
        if type(t) == type { } then
            for tk, tv in pairs(t) do
                if tv == v then
                    return true
                end
            end
        end
    end

    return false
end

--fy:获取英雄number对应的加成数据
function PublicFunc.getIllumstrationValue( number, star )
    local starNum = 1;
    local addHP = 0;
    local addAtk = 0;
    local addDef = 0;
    
    local cardInfo = ConfigHelper.GetRole(number);
    --app.log( "获取满星id后计算其加成属性11111:"..number );
    if cardInfo and star < 8 then
        --app.log( "获取满星id后计算其加成属性22222222" );
        local defaultNumber = cardInfo.default_rarity;
        --starNum = cardInfo.rarity;
        --app.log( "获取满星id后计算其加成属性33333:"..starNum );
        local illCfg = ConfigManager.Get( EConfigIndex.t_role_illumstration,defaultNumber );
        if illCfg then
            --app.log( "获取满星id后计算其加成属性4444444:"..defaultNumber );
            addHP = illCfg.max_hp_per_star * star;
            addAtk = illCfg.atk_power_per_star * star;
            addDef = illCfg.def_power_per_star * star;
        end
    end
    
    return addHP, addAtk, addDef;
end

--fy:获取对应number的下一级星级的number
function PublicFunc.getNextStarUpNumber( number )
    local cardInfo = ConfigHelper.GetRole( number );
    
    if cardInfo then
        return cardInfo.star_up_number;
    else
        return 0;
    end
end

function PublicFunc.getFullStarNumber( number )
    local resultNum = number;
    local function nextStarUpNumber( n )
        local cardInfo = ConfigHelper.GetRole( n );
        if cardInfo then
            if cardInfo.star_up_number == 0 then
                resultNum = cardInfo.id;
            end
            return cardInfo.star_up_number;
        else
            return 0;
        end
    end
    local judage = nextStarUpNumber( number );
    while judage ~= 0 do
        judage = nextStarUpNumber( judage );
    end
    return resultNum;
end

--fy：获取图鉴总加成数值
function PublicFunc.getTotalIllumstration()
    local totalHPAdd = 0;
    local totalAtkAdd = 0;
    local totalDefAdd = 0;
    local illumAddHP = 0;
    local illumAddAtk = 0;
    local illumAddDef = 0;
    for k, v in pairs( g_dataCenter.package:get_hero_card_table() ) do
        if v.index ~= 0 then
            illumAddHP, illumAddAtk, illumAddDef = PublicFunc.getIllumstrationValue( v.number, v.rarity );
            totalHPAdd = totalHPAdd + illumAddHP;
            totalAtkAdd = totalAtkAdd + illumAddAtk;
            totalDefAdd = totalDefAdd + illumAddDef;
        end
    end
    
    return totalHPAdd, totalAtkAdd, totalDefAdd;
end
--lxj: 获取图鉴总的激活加成数值
function PublicFunc.getTotalActiveIllumstration()
	local totalHPAdd = 0;
    local totalAtkAdd = 0;
    local totalDefAdd = 0;
    local illumAddHP = 0;
    local illumAddAtk = 0;
    local illumAddDef = 0;
    for k, v in pairs( g_dataCenter.package:get_hero_card_table() ) do
        if v.index ~= 0 then
            illumAddHP, illumAddAtk, illumAddDef = PublicFunc.getIllumstrationValue( v.number, v.illumstration_number );
            totalHPAdd = totalHPAdd + illumAddHP;
            totalAtkAdd = totalAtkAdd + illumAddAtk;
            totalDefAdd = totalDefAdd + illumAddDef;
        end
    end
    
    return totalHPAdd, totalAtkAdd, totalDefAdd;
end 

function PublicFunc.FormatTime(hour, min, sec)
    local str = ""
    local begin = true
    if hour then
        hour = math.floor(hour)
        begin = false
        if hour > 9 then
            str = str..hour
        else
            str = str.."0"..hour
        end
    end
    if min then
        min = math.floor(min)
        if not begin then
            str = str..":"
        end
        begin = false
        if min > 9 then
            str = str..min
        else
            str = str.."0"..min
        end
    end
    if sec then
        sec = math.floor(sec)
        if not begin then
            str = str..":"
        end
        begin = false
        if sec > 9 then
            str = str..sec
        else
            str = str.."0"..sec
        end
    end
    return str
end

function PublicFunc.FormatLeftSecondsEx(sec_time,auto_hour,auto_min)
    local hour,min,sec;
    hour = math.floor(sec_time/3600)
    if auto_hour and hour <= 0 then
        hour = nil;
    end
    local h = hour or 0;
    min = math.floor((sec_time - h*3600)/60)
    if auto_min and min <= 0 then
        min = nil;
    end
    local m = min or 0;
    sec = math.floor(sec_time - h*3600 - m*60)
    return PublicFunc.FormatTime(hour, min, sec)
end

function PublicFunc.FormatLeftSeconds(sec_time,show_hour,show_min,show_sec)
    local hour,min,sec;
    if show_hour == nil or show_hour then
        hour = math.floor(sec_time/3600)
    end
    local h = hour or 0;
    if show_min == nil or show_min then
        min = math.floor((sec_time - h*3600)/60)
    end
    local m = min or 0;
    if show_sec == nil or show_sec then
        sec = math.floor(sec_time - h*3600 - m*60)
    end
    return PublicFunc.FormatTime(hour, min, sec)
end

function PublicFunc.getRoleCardCurStar( number )
    local info = ConfigHelper.GetRole(number);
    if info then
        return info.rarity;
    else
        return 0;
    end
end


function PublicFunc.FloatErrorCode(rst, error_table, table_name)
    local str = error_table[rst]
    if str == nil then
        app.log("rst="..tostring(rst).." error_table="..table.tostring(error_table))
        SystemHintUI.SetAndShow(ESystemHintUIType.one, "errorcode["..tostring(table_name).."]-["..tostring(rst).."]", {str = "确定"});
        return
    end
    FloatTip.Float(str)
end


function PublicFunc.GetDiscreteConfig(id, default_value)
    local data = ConfigManager.Get(EConfigIndex.t_discrete, id)
    if data then
        return ConfigManager.Get(EConfigIndex.t_discrete, id).data
    else
        app.log("error discrete_id:"..tostring(id))
        return default_value
    end
end


local EFunctionOpentype = 
{
    PlayerLevel = 1,    --战队等级 
    HeroLevel   = 2,    --英雄等级 
    HeroStar    = 3,    --英雄星级 
    HeroRarity  = 4,    --英雄品质
    HeroBreakthrough = 5, --英雄突破
}

local fCheckFunctionOpen = 
{
    [EFunctionOpentype.PlayerLevel] = function (param, player) return player.level >= param end,
    [EFunctionOpentype.HeroLevel]   = function (param, roleData) return roleData.level >= param end,
    [EFunctionOpentype.HeroStar]    = function (param, roleData) return roleData.config.rarity >= param end,
    [EFunctionOpentype.HeroRarity]  = function (param, roleData) return roleData.config.real_rarity >= param end,
    [EFunctionOpentype.HeroBreakthrough] = function (param, player, roleData) return true end, -- TODO
}

-- 返回功能真正开启状态
function PublicFunc.IsOpenRealFunction(id, roleData, noTips)
    local result = true
    local config = ConfigManager._GetConfigTable(EConfigIndex.t_play_vs_data)[id]
    if config then
        if config.open_type == EFunctionOpentype.PlayerLevel then
            result = fCheckFunctionOpen[config.open_type](config.param[1], g_dataCenter.player)
        elseif config.open_type > EFunctionOpentype.PlayerLevel then
            result = fCheckFunctionOpen[config.open_type](config.param[1], roleData)
        end
    end

    if not result and not noTips then
        FloatTip.Float(tostring(config.unlock_des))
    end

    return result
end

function PublicFunc.CreateItemFromMapinfoConfig(config)
    local new_item = FightScene.CreateItem(nil, config.item_modelid, config.flag, config.id, config.item_effectid)
    if new_item then
        new_item:SetPosition(config.px,config.py,config.pz)
        new_item:SetRotation(config.rx,config.ry,config.rz)
        new_item:SetScale(config.sx,config.sy,config.sz)
        new_item:SetInstanceName(config.obj_name);

        if config.box_collider ~= nil then
            local size = config.box_collider.size
            new_item:SetBoxColliderParam(size.x, size.y, size.z)
        elseif config.capsule_collider ~= nil then
            local radius = config.capsule_collider.radius
            local height = config.capsule_collider.height
            new_item:SetCapsuleColliderParam(radius, height)
        end
    end

    return new_item
end

function PublicFunc.CreateMonsterFromMapinfoConfig(config, level)
    if not config then return end

    if level == nil then
        local fm = FightScene.GetFightManager()
        if fm then
            level = fm:GetMonsterLevel()
        end
    end

    local newmonster = FightScene.CreateMonsterAsync(nil, config.id, config.flag, nil, level, config.group_name, config.anim_id)
    if newmonster then
        newmonster:SetPosition(config.px,config.py,config.pz)
        newmonster:SetRotation(config.rx,config.ry,config.rz)
		--newmonster:SetScale(config.sx,config.sy,config.sz)
        PublicFunc.UnifiedScale(newmonster, config.sx,config.sy,config.sz)
        newmonster:SetInstanceName(config.obj_name);
        
        newmonster:SetHomePosition(newmonster:GetPosition(true, true))	

        local param = config.param

        local showName = false
        if param then

            if param.ai ~= nil then
                local aiid = tonumber(param.ai)
                if ConfigManager.Get(EConfigIndex.t_hfsm,aiid) == nil then
                    app.log("mapinfo config ai id error! id = " .. tostring(aiid))
                else
                    newmonster:SetAI(aiid)
                end
            end

            if param.path ~= nil then
                local path = LevelMapConfigHelper.GetWayPoint(param.path, true)
                if path ~= nil and #path > 0 then 
                    newmonster:SetPatrolMovePath(path)

                    if param.loop == '1' then 
                        newmonster:SetAlongPathLoop(true)
                    end

                end
            end

            if param.show_name ~= nil then
                showName = true
            end

            if param.be_attack_order ~= nil then
                newmonster:SetBeAttackOrder(tonumber(param.be_attack_order))
            end

            newmonster:SetHFSMMultiKeyValue(param)

            if param.speak_id then
                newmonster:PlaySpeakByid(param.speak_id);
            end
        end

        if not showName and newmonster.config and type(newmonster.config.ai_param) == 'table' then
            showName = newmonster.config.ai_param.show_name ~= nil
        end

        if showName then
            newmonster:GetHpUi():SetName(true, newmonster:GetConfig("name"), 2)
        end
    end

    return newmonster
end

function PublicFunc.GetUnifiedScale(entity)
    if entity:IsSpecMonster() then
        return 1
    else
        if entity:IsHero() then
            return PublicStruct.Const.HERO_SCALE
        elseif entity:IsMonster() then
            if entity:IsBoss() then
                return PublicStruct.Const.BOSS_SCALE
            else
                return PublicStruct.Const.MONSTER_SCALE
            end
        else
            return 1
        end
    end
end

function PublicFunc.UnifiedScale(entity, osx, osy, osz)
    --if entity:IsSpecMonster() then return end
    osx = osx or 1
    osy = osy or 1
    osz = osz or 1
    local unified = PublicFunc.GetUnifiedScale(entity)
    entity:SetScale(osx * unified , osy * unified, osz * unified)
end

function PublicFunc.GetObjectNameByInstanceName(instanceName)

    local ret = {}

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and obj:GetInstanceName() == instanceName then
                
                table.insert(ret, name)
            end
        end
    )
    
    return ret
end

function PublicFunc.GetObjectByInstanceName(instanceName)

    local ret = {}

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and obj:GetInstanceName() == instanceName then
                
                table.insert(ret, obj)
            end
        end
    )
    
    return ret
end

function PublicFunc.MergeNetSummeryNetList(items)
    if type(items) ~= 'table' then
        return items
    end

    local ret = {}
    local hasItems = {}
    for k,item in ipairs(items) do
        if hasItems[item.id] then
            local index = hasItems[item.id]
            ret[index].count =  ret[index].count + item.count
        else
            local index = #ret + 1
            ret[index] = item
            hasItems[item.id] = index
        end
    end
    return ret
end

-- 给传入的table按照类型，品质，sort_number和id排序，会修改传入的参数
function PublicFunc.ConstructCardAndSort(items)
    for k,item in ipairs(items) do
        if PropsEnum.IsRole(item.id) then
            item.cardinfo = CardHuman:new( { number = item.id, count = item.count });
            item.type = 1
        elseif PropsEnum.IsItem(item.id) or PropsEnum.IsVaria(item.id) then
            item.cardinfo = CardProp:new( { number = item.id, count = item.count });
            item.type = 3
        else
            app.log("dont support equipment!")
            return items
        end
    end

    table.sort(items, function(a, b)
        local ar = a.cardinfo.realRarity or a.cardinfo.rarity
        local br = b.cardinfo.realRarity or b.cardinfo.rarity
        if a.type ~= b.type then
            return a.type < b.type
        elseif ar  ~= br then
            return ar > br
        else
            if a.cardinfo.sort_number and a.cardinfo.sort_number ~= b.cardinfo.sort_number then
                return a.cardinfo.sort_number > b.cardinfo.sort_number
            else
                return a.id < b.id
            end
        end
    end
    )

    return items
end

function PublicFunc.ProcessNameSplit(name)
    if name == nil then
        app.log("nil name from PublicFunc.ProcessNameSplit "..debug.traceback())
        return
    end
    local resultName = name;
    local addNum = 0;
    local index1, index2 = string.find( name, "[-]" );
    local tempName;
    local colorStr = nil   --'[00ff73]'

    --app.log( "=====看看位置:"..tostring(index1)..":"..tostring(index2) );
    if index1 == nil then
        tempName = name;
    else
        tempName = string.sub( name, 1, index1 - 2 );
        index1, index2 = string.find( tempName,  "\[[.^%[%]]*\]" );
        if index1 then
            tempName = string.sub( tempName, index1+1, string.len( tempName ) );
            colorStr = string.sub(name, 1, index1)
            --app.log( "=====看看内容:"..tempName );
        end
    end
    tempName = string.split( tempName, "+" );
    resultName = tempName[1];
    if tempName[2] then
        addNum = tonumber( tempName[2] );
    end
    --app.log( "=====看看内容:"..resultName .."   ==============addNum"..tostring(addNum) .. '   ' .. tostring(colorStr));
    return resultName, addNum, colorStr;
end

function PublicFunc.GetNoColorName(name)
    local str = string.gsub(name,"(%[%-%])","")
    str = string.gsub(str,"(%[.*%])","")
    return str
end

function PublicFunc.GetHeroRarityNextProperyDiff(roleData, nextNumber, pList)   
    local propertyDiff = {} 
    local currHeroProperty = PublicFunc._GetHeroProperyTotal(roleData.number, roleData.level, pList)
    local nextHeroProperty = PublicFunc._GetHeroProperyTotal(nextNumber, roleData.level, pList)
    local _activeProperty = ConfigHelper.GetBreakthroughStageActiveProperty(nextNumber)

    for k, v in pairs(pList) do 
        if _activeProperty[v] == nil then
            _activeProperty[v] = 0
        end
        propertyDiff[v] = nextHeroProperty[v] + _activeProperty[v] - currHeroProperty[v]
    end
    return propertyDiff
end

function PublicFunc.GetHeroRarityPreProperyDiff(roleData, preNumber, pList)   
    local propertyDiff = {} 
    local currHeroProperty = PublicFunc._GetHeroProperyTotal(roleData.number, roleData.level, pList)
    local preHeroProperty = PublicFunc._GetHeroProperyTotal(preNumber, roleData.level, pList)
    local _activeProperty = ConfigHelper.GetBreakthroughStageActiveProperty(roleData.number)

    for k, v in pairs(pList) do 
        if _activeProperty[v] == nil then
            _activeProperty[v] = 0
        end
        propertyDiff[v] = currHeroProperty[v] + _activeProperty[v]  - preHeroProperty[v]
    end
    return propertyDiff
end 

function PublicFunc._GetHeroProperyTotal(number, level, pList)   
    local roleConfig = ConfigHelper.GetRole(number)
    local roleLevelConfig = CardHuman.GetLevelConfig(number, level, roleConfig)
    local propertyValue = {} 
    for k, v in pairs(pList) do 
        if roleConfig[v] == nil then
            roleConfig[v] = 0
        end
        propertyValue[v] = roleConfig[v] + roleLevelConfig[v]
    end
    return propertyValue
end

function PublicFunc.IsBuffItem(obj)
    if obj then
        local cfg = ConfigManager.Get(EConfigIndex.t_world_item, obj:GetConfigId())
        --app.log('IsBuffItem ============ ' .. tostring(obj:GetConfigId()))
        if cfg and type(cfg.trigger_buff) == 'table' then
            return true
        end
    end

    return false
end
--获取UI对象在屏幕上的位置
function PublicFunc.GetUiScreenPos(obj)
	local uiList = {};
	if obj.get_game_object ~= nil then 
		obj = obj:get_game_object();
	end 
	while obj:get_parent()~= nil and obj:get_parent() ~= Root.get_root_ui() do 
		table.insert(uiList,obj);
		obj = obj:get_parent();
	end
	local len = #uiList;
	local sx,sy,sz = 0,0,0;
	for i = 1,len do 
		local px,py,pz = uiList[i]:get_local_position();
		local scx,scy,scz = 1,1,1;
		if i < len then 
			scx,scy,scz = uiList[i+1]:get_local_scale();
		end
		sx = (sx + px)*scx;
		sy = (sy + py)*scy;
		sz = (sz + pz)*scz;
	end
	return sx,sy,sz;
end
--获取UI上某个点在屏幕上的位置
function PublicFunc.GetLocalPosToScreen(obj,px,py,pz)
	if px == nil then 
		px = 0;
		py = 0;
		pz = 0;
	end
	local uiList = {};
	if obj.get_game_object ~= nil then 
		obj = obj:get_game_object();
	end 
	while obj:get_parent()~= nil and obj:get_parent() ~= Root.get_root_ui() do 
		table.insert(uiList,obj);
		obj = obj:get_parent();
	end
	local len = #uiList;
	local sx,sy,sz = 0,0,0;
	local lcx,lcy,lcz = uiList[1]:get_local_scale();
	sx = px * lcx;
	sy = py * lcy;
	sz = pz * lcz;
	for i = 1,len do 
		local lx,ly,lz = uiList[i]:get_local_position();
		local scx,scy,scz = 1,1,1;
		if i < len then 
			scx,scy,scz = uiList[i+1]:get_local_scale();
		end
		sx = (sx + lx)*scx;
		sy = (sy + ly)*scy;
		sz = (sz + lz)*scz;
	end
	return sx,sy,sz;
end 
--获取屏幕上的点在ui的哪个位置
function PublicFunc.GetScreenPosToLocal(obj,px,py,pz)
	if px == nil then 
		px = 0;
		py = 0;
		pz = 0;
	end
	local uiList = {};
	if obj.get_game_object ~= nil then 
		obj = obj:get_game_object();
	end 
	while obj:get_parent()~= nil and obj:get_parent() ~= Root.get_root_ui() do 
		table.insert(uiList,obj);
		obj = obj:get_parent();
	end
	local len = #uiList;
	local sx,sy,sz = px,py,pz;
	for i = len,1,-1 do 
		local lx,ly,lz = uiList[i]:get_local_position();
		local scx,scy,scz = uiList[i]:get_local_scale();
		sx = (sx - lx)/scx;
		sy = (sy - ly)/scy;
		sz = (sz - lz)/scz;
	end
	return sx,sy,sz;
end
--获取随机名字
function PublicFunc.GetRandomName(exclude_name)
    if not PublicFunc.nameTable then
        PublicFunc.nameTable = ConfigManager._GetConfigTable(EConfigIndex.t_name);
    end
    if not PublicFunc.nameNum then
        PublicFunc.nameNum = #PublicFunc.nameTable ;
    end
    if not PublicFunc.surnameTable then
        PublicFunc.surnameTable = ConfigManager._GetConfigTable(EConfigIndex.t_surname);
    end
    if not PublicFunc.surnameNum then
        PublicFunc.surnameNum = #PublicFunc.surnameTable;
    end
    local name = "";
    repeat
        local index1 = math.random(1,PublicFunc.nameNum);
        local index2 = math.random(1,PublicFunc.surnameNum);
        name = PublicFunc.surnameTable[index2].name_surname..PublicFunc.nameTable[index1].name_name;
        if not exclude_name[name] then
            break;
        end
    until true;
    return name;
end

function PublicFunc.CheckCanUseNavMeshOperation(obj, logError)
    local canUse = obj:IsShow()

    if canUse then
        local x, y, z = obj:GetPositionXYZ(false, true)
        local canUse, _x, _y, _z = util.get_navmesh_sampleposition(x, y, z, 1);
        if canUse and (math.abs(x - _x) > 0.01 or math.abs(y - _y) > 0.01 or math.abs(z - _z) > 0.01) then
            canUse = false
        end
    end

    if logError and not canUse then
        app.log_warning("CheckCanUseNavMeshOperation is false " .. obj:GetName() .. ' ' .. tostring(obj:IsShow()) .. ' State:[' .. obj:GetObjHFSMState() .. ']' .. debug.traceback())
    end

    return canUse
end
-- 英雄客户端属性取整
function PublicFunc.AttrInteger(value)
    return math.floor(value);
end

function PublicFunc.GetSkillOpenLearnInfo()
    --if PublicFunc.skillStar then
    --    return PublicFunc.skillStar,PublicFunc.passiveSkillStar,PublicFunc.haloSkill;
    --end
    PublicFunc.skillStar = {}; --[序列] =｛level_up=星级，open=星级｝
    PublicFunc.passiveSkillStar = {};--[序列] =｛level_up=星级，open=星级｝
    PublicFunc.haloSkill = nil; -- 开启学习星级
    local cfg = ConfigManager._GetConfigTable(EConfigIndex.t_role_skill);
    for star, cfg in ipairs(cfg) do
        -- 主动
        if cfg.skill ~= 0 then
            for k,index in pairs(cfg.skill) do
                if PublicFunc.skillStar[index] == nil then
                    PublicFunc.skillStar[index] = {open=star};
                end
            end
        end
        if cfg.skill_level_up ~= 0 then
            for k,index in pairs(cfg.skill_level_up) do
                if PublicFunc.skillStar[index] and not PublicFunc.skillStar[index].level_up then
                    PublicFunc.skillStar[index].level_up = star;
                end
            end
        end
        -- 被动
        if cfg.passive_property ~= 0 then
            for k,skill_id in pairs(cfg.passive_property) do
                if PublicFunc.passiveSkillStar[skill_id] == nil then
                    PublicFunc.passiveSkillStar[skill_id] = {open=star};
                end
            end
        end
        if cfg.passive_property_level_up ~= 0 then
            for k,skill_id in pairs(cfg.passive_property_level_up) do
                if PublicFunc.passiveSkillStar[skill_id] and not PublicFunc.passiveSkillStar[skill_id].level_up then
                    PublicFunc.passiveSkillStar[skill_id].level_up = star;
                end
            end
        end
        if cfg.halo_open == 1 and not PublicFunc.haloSkill then
            PublicFunc.haloSkill = star;
        end
    end
    return PublicFunc.skillStar,PublicFunc.passiveSkillStar,PublicFunc.haloSkill;
end

-- 获得技能配置 
-- def_rarity  英雄默认星级
-- skill_type  技能类型 0主动1被动2光环
-- skill_id    技能id
-- @return 技能显示配置，技能等级配置
function PublicFunc.GetSkillCfg(def_rarity, skill_type, skill_id)
    local skillData = nil;
    local skillLevelData = nil;
    if skill_type == 1 then
        local cfg = ConfigManager.Get(EConfigIndex.t_role_passive_info,def_rarity);
        if cfg then
            skillData = cfg[skill_id];
        end
        local cfg_name = EConfigIndex["t_passive_property_"..def_rarity];
        skillLevelData = ConfigManager.Get(cfg_name,skill_id);
    elseif skill_type == 2 then
        local cfg = ConfigManager.Get(EConfigIndex.t_role_halo_info,def_rarity);
        if cfg then
            skillData = cfg[skill_id];
        end
        local cfg_name = EConfigIndex["t_halo_property_"..def_rarity];
        skillLevelData = ConfigManager._GetConfigTable(cfg_name);
    else
        skillData = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id); 
        skillLevelData = ConfigManager.Get(EConfigIndex.t_skill_level_info,skill_id);
    end
    return skillData,skillLevelData;
end

-------------------- 视频接口调用 ----------------------
--[[
参数说明:
    file_path       视频路径
    finish_func     视频播放结束回调
    ready_func      视频准备完成回调
    is_pause_ready  视频准备完成需要暂停
    is_skip         是否显示跳过按钮
    stop_audio_delay   播放前停止音乐播放（true逐渐停止音乐 false立即停止 nil默认情况-播放前暂停音乐视频结束后恢复音乐）
    is_part         是否连播视频中间的一个（非最后1个）
--]]
function PublicFunc.MediaPlay(file_path, finish_func, ready_func, is_pause_ready, is_skip, stop_audio_delay, is_part)
    app.log("PublicFunc.MediaPlay="..file_path);
    is_pause_ready = Utility.get_value(is_pause_ready, false)

    local _init_func = function()
        util.media_player_init()
        g_ScreenLockUI.Show()

        if stop_audio_delay ~= nil then
            AudioManager.Stop(ENUM.EAudioType._2d, stop_audio_delay)
        end
    end
    local _ready_func = function()

        CameraManager.SetUICameraShow(false)
        CameraManager.SetSceneCameraActive(false)  
        if stop_audio_delay == nil then
            AudioManager.Pause(ENUM.EAudioType._2d, true)
        end      

        if nil ~= ready_func and "" ~= ready_func then            
            Utility.CallFunc(ready_func)
        end

        if is_pause_ready then
            -- 调用者决定何时恢复
            -- util.media_player_resume()
        end
    end
    local _finish_func = function()
        if not is_part then
            util.media_player_destory()
        end

        g_ScreenLockUI.Hide()
        CameraManager.SetUICameraShow(true)
        CameraManager.SetSceneCameraActive(true)

        if stop_audio_delay == nil then
            AudioManager.Pause(ENUM.EAudioType._2d, false)
        end

        Utility.CallFunc(finish_func)
    end
    local _error_func = function()
        app.log("视频播放失败："..tostring(file_path))
    end

    _init_func()

    if is_skip then
        util.media_player_play(false, file_path, 
            Utility.create_callback(_finish_func), 
            Utility.create_callback(_error_func), 
            Utility.create_callback(_ready_func), 
            is_pause_ready,
            true, "assetbundles/prefabs/ui/image/skip/jqdh_diban1.assetbundle", 485, 320)
    else
        util.media_player_play(false, file_path, 
            Utility.create_callback(_finish_func), 
            Utility.create_callback(_error_func), 
            Utility.create_callback(_ready_func), 
            is_pause_ready)
    end
    -- public bool Play(
    --                 playDirectly, fileName, onFinishCallback, onErrorCallback, onFirstFrameReadyCallBack, pauseOnFirstFrameReady,
    --                 showSkipBtn, skipBtFileName, skipBtnPosX, skipBtnPosY
    --                 ); 
end


function PublicFunc.RecordingScript(script_info)
    if AppConfig.script_recording then
        if PublicStruct.Start_RecordScript_Time == 0 then
            PublicStruct.Start_RecordScript_Time = PublicFunc.QueryCurTime()
        end
        app.write_script_recording(math.ceil(PublicFunc.QueryDeltaTime(PublicStruct.Start_RecordScript_Time)), script_info.."\n")
        PublicStruct.Start_RecordScript_Time = PublicFunc.QueryCurTime()
    end
end

function PublicFunc.OptimizingWeekday(str_weekday)
    if str_weekday == "一、二、三、四、五" then
        return true, "一至五"
    end
    return false
end

--返回星期几 (1 ~ 7 对应 星期一 ~ 星期天)
function PublicFunc.GetWhatDayIsToday()
    --星期天是1
	local wday = os.date('*t', system.time())['wday']
	return wday == 1 and 7 or wday - 1;
end
--[[
**************************************************************    
*           战斗专属随机函数,其他人不能调用      nation     ***                        
**************************************************************]]
local key_random_seed = 0                                --***
local key_random_times = 0                               --***
function PublicFunc.Key_Random_Seed(seed)                --***
    key_random_seed = seed;                              --***
    key_random_times = 0;                                --***
end                                                      --***
function PublicFunc.Key_Random_Int(min, max)             --***
    key_random_times = key_random_times + 1              --***
    key_random_seed = ((214013 * key_random_seed + 2531011)%0xffffffff);--***
    if max <= min then                                   --***
        return min;                                      --***
    end                                                  --***
    local rshift = bit.bit_rshift(key_random_seed,15)    --***
    local xor = bit.bit_xor(key_random_seed, rshift)     --***
    return min + (xor % (max - min + 1));                --***
end                                                      --***
--[[                                                       ***
**************************************************************]]

--防止ui2dfight下的资源在主场景中被看见。。。。Destroy有延迟
function PublicFunc.HideAllUiFightChild()
    local ui_fight = Root.get_root_ui_2d_fight()
    if ui_fight then
        local childs = ui_fight:get_childs()
        if childs then
             for _,v in pairs(childs) do
                v:set_active(false)
             end
        end
    end
end

-- 通过动作枚举获取动画名字
function PublicFunc.GetAniFSMName(ani, model_id)
    if ani == nil then
        app.log("......." .. debug.traceback());
    end
    -- app.log("ani======"..ani);
    if ani < EANI._min or ani > EANI._max then
        return ""
    end

    local k = ConfigManager.Get(EConfigIndex.t_action_list,ani).name;
    local name = k;
    local index = 1;

    if model_id then
        local model_config = ConfigManager.Get(EConfigIndex.t_model_list,model_id)
        if model_config then
            if type(model_config[k]) == "string" then
                name = model_config[k];
            elseif type(model_config[k]) == "table" then
                index = math.random(1,#model_config[k]);
                name = model_config[index];
            end
        end
    end
    return name,index;
end

function PublicFunc.GetModelAnimFilePath(model_id)
    local path = "assetbundles/prefabs/character/animator_common/";
    if model_id then
        local model_config = ConfigManager.Get(EConfigIndex.t_model_list,model_id)
        if model_config and type(model_config.anim_file) == "string" then
            local name = model_config.anim_file;
            path = path .. name .. ".assetbundle";
            return path;
        end
    end
end

-------------------------------------------------------------------------------------------------

-- local __paraCheck = 
-- {
--     [2] = 1,
--     [3] = 1,
--     [4] = 2,
--     [5] = 2,
--     [6] = 2,
-- }

-- function PublicFunc.GetSkillUpInfo(roleData, star, getDesc)
--     if roleData == nil or __paraCheck[star] ~= 1 then
--         app.log('参数错误！')
--         return
--     end

--     local star2SkillIndex = {[2] = 2, [3] = 3}
--     if star2SkillIndex[star] == nil then return end

--     local skillid = roleData.config.spe_skill[star2SkillIndex[star]][1]
--     local skillConfig = ConfigManager.Get(EConfigIndex.t_skill_info, skillid)
--     if skillConfig == nil then return end
--     if getDesc == false then
--         return {icon = skillConfig.small_icon, name = skillConfig.name}
--     end

--     local learnSKill = roleData.learn_skill[star2SkillIndex[star]]
--     local des = PublicFunc.FormatSkillString(skillConfig.simple_describe, skillid, nil, learnSKill.level, roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power))

--     return {icon = skillConfig.small_icon, name = skillConfig.name, des = des}
-- end

function PublicFunc.GetUnlockSkillInfo(roleData, star, getDesc)
    if roleData == nil or star < 3 then
        return
    end

    local skillIndex = star - 2
    local isHaloSKill = false
    local skillConfig = PublicFunc.GetSkillCfg(roleData.default_rarity, 1, skillIndex)
    if skillConfig == nil then
        isHaloSKill = true
        skillIndex = 1
        skillConfig = PublicFunc.GetSkillCfg(roleData.default_rarity, 2, skillIndex)
    end
    
    if skillConfig == nil then return end
    if getDesc == false then
        return {icon = skillConfig.small_icon, name = skillConfig.name}
    end

    local des = skillConfig.simple_describe

    if isHaloSKill then
        des = PublicFunc.FormatHaloSkillString(des, skillConfig.skill, roleData.default_rarity, nil, roleData.halo_level)
    else
        local skillData = roleData.learn_passivity_property[skillIndex]
        des = PublicFunc.FormatPassiveSkillString(des, skillConfig.skill, roleData.default_rarity, nil, skillData.level)
    end
    return {icon = skillConfig.small_icon, name = skillConfig.name, des = des}
end

function PublicFunc.GetQuanNengRatio(quan_neng_dif)
    local _property_ratio = ConfigManager.Get(EConfigIndex.t_property_ratio, 1)
    if type(_property_ratio.quan_neng_ratio) == "table" then
        for k,v in pairs(_property_ratio.quan_neng_ratio) do
            if quan_neng_dif >= v.min and quan_neng_dif <= v.max then
                return v.ratio
            end
        end
    end
    return 0
end


function PublicFunc.Trans2ServerPos(value)
    return math.floor(value * PublicStruct.Coordinate_Scale)
end
-------------------------------------------------------------------------------------------------

--[[通过屏幕比例设置缩放]]
function PublicFunc.SetScaleByScreenRate(obj)
    if obj == nil then
        app.log('obj == nil' .. debug.traceback())
        return
    end
    local scrate = app.get_screen_width() / app.get_screen_height();
	local scaleModel = scrate / 16 * 9;
	scaleModel = math.floor(scaleModel * 1000)/1000;

    local sx, sy, sz = obj:get_local_scale()
	obj:set_local_scale(scaleModel * sx, scaleModel * sy, scaleModel * sz);
    return scaleModel
end

function PublicFunc.SetHurdleHeroViewRadius(obj)
    if obj == nil then return end

    local vr = nil
    local fm = FightScene.GetFightManager()
    if fm then
        local heroFightAI = fm:GetHurdleHeroFightAI()
        if type(heroFightAI) == 'table' and type(heroFightAI.view_radius) == 'number' then
            vr = heroFightAI.view_radius
        end
    end
    if vr then
        obj:SetConfig("view_radius", vr)
    end
end


function PublicFunc.CheckApLimit(ap, showTip)
    if ap and ap > ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_max_ap_save).data then
        if showTip == nil then
            FloatTip.Float(gs_all_string_cn['tili_1'])
        end
        return true
    end
    return false
end

--递增序列，需要用到唯一性的地方随意使用
PublicFunc.Increment_Sequence = 1
function PublicFunc.GetIncrementSequence()
    local ret = PublicFunc.Increment_Sequence
    PublicFunc.Increment_Sequence = PublicFunc.Increment_Sequence + 1
    if PublicFunc.Increment_Sequence > 0xffffffff then
        PublicFunc.Increment_Sequence = 1
    end
    return ret
end

function PublicFunc.GetShengyouName(model_id)
    if model_id == nil then
        return ''
    end
    local config = ConfigManager.Get(EConfigIndex.t_role_shengyou, model_id)
    if config then
        return gs_string_name[config.shengyou_name]
    end
    return ''
end

function PublicFunc.GetShengyouSound(model_id)
    if model_id == nil then
        return 0
    end

    local config = ConfigManager.Get(EConfigIndex.t_role_shengyou, model_id)
    if config then
        return config.shengyou_sound
    end
    return 0
end

function PublicFunc.GetShengyouTalk(model_id)
    if model_id == nil then
        return 0
    end

    local config = ConfigManager.Get(EConfigIndex.t_role_shengyou, model_id)
    if config then
        return config.talk_id
    end
    return 0
end

function PublicFunc.FormatHeroNameAndNumber(heroName)
    local name, add_num, colorStr = PublicFunc.ProcessNameSplit(heroName)
    local numStr = ''

    if colorStr == nil then
        if add_num ~= 0 then
            numStr = '+' .. add_num
        end
        return name, numStr
    else
        colorStr = colorStr .. '%s[-]'
        if add_num ~= 0 then
            numStr = string.format(colorStr, '+' .. add_num)
        end
        return string.format(colorStr, name), numStr
    end
end

function PublicFunc.GetEquipExpertLevel(type, roleData)
    local propMap = {
        [ENUM.EquipExpertType.Level] = "equip_expert_normal_rarity_level",
        [ENUM.EquipExpertType.Star] = "equip_expert_normal_star_level",
        [ENUM.EquipExpertType.SpecLevel] = "equip_expert_exclusive_rarity_level",
        [ENUM.EquipExpertType.SpecStar] = "equip_expert_exclusive_star_level",
    }
    return roleData[propMap[type]]
end

function PublicFunc.GetEquipExpertProps(heroId, level, type)
    local cfgData = nil
    local config = ConfigManager.Get(EConfigIndex.t_equipment_expert, heroId)
    if config then
        for _, v in pairs(config) do
            if v.level == level then
                cfgData = v
            end
        end
    end
    if not cfgData then
        app.log('无英雄配置数据！ heroId = ' .. tostring(heroId) .. '  level = ' .. tostring(level))
        return
    end

    local prefixCfg = {
        [ENUM.EquipExpertType.Level] = 'NR_',
        [ENUM.EquipExpertType.Star] = 'NS_',
        [ENUM.EquipExpertType.SpecLevel] = 'SR_',
        [ENUM.EquipExpertType.SpecStar] = 'SS_',
    }
    local prefix = prefixCfg[type]
    local propConfig = PublicFunc.GetAllHeroProperty()
    local retProps = {}

    for _, v in pairs(propConfig) do
        local prop = prefixCfg[type] .. v.key
        if cfgData[prop] and cfgData[prop] ~= 0 then
            table.insert(retProps, {key = v.key, value = PublicFunc.AttrInteger(cfgData[prop])})
        end
    end
    return retProps
end


--英雄属性名称
local _heroPropertyConfig = {
    [1] = {key = "cur_hp", name = "当前生命值"},
    [2] = {key = "max_hp", name = "生命"},
    [3] = {key = "atk_power", name = "攻击"},
    [4] = {key = "def_power", name = "防御"},
    [5] = {key = "crit_rate", name = "暴击率"},
    [6] = {key = "anti_crite", name = "免爆率"},
    [7] = {key = "crit_hurt", name = "暴击伤害加成"},
    [8] = {key = "broken_rate", name = "破击率"},
    [9] = {key = "parry_rate", name = "格挡率"},
    [10] = {key = "parry_plus", name = "格挡伤害加成"},
    [11] = {key = "move_speed", name = "移动速度"},
    [12] = {key = "move_speed_plus", name = "移动速度加成"},
    [13] = {key = "bloodsuck_rate", name = "吸血率"},
    [14] = {key = "rally_rate", name = "反弹率"},
    [15] = {key = "attack_speed", name = "攻击速度加成"},
    [16] = {key = "dodge_rate", name = "闪避率"},
    [17] = {key = "res_hp", name = "生命恢复率"},
    [18] = {key = "cool_down_dec", name = "技能冷却缩减"},
    [19] = {key = "treat_plus", name = "治疗效果加成"},
    [20] = {key = "restraint1_damage_plus", name = "对锐属性英雄伤害加成"},
    [21] = {key = "restraint2_damage_plus", name = "对坚属性英雄伤害加成"},
    [22] = {key = "restraint3_damage_plus", name = "对疾属性英雄伤害加成"},
    [23] = {key = "restraint4_damage_plus", name = "对特属性英雄伤害加成"},
    [24] = {key = "restraint_all_damage_plus", name = "对全属性英雄伤害加成"},
    [25] = {key = "restraint1_damage_reduct", name = "对锐属性英雄伤害减免"},
    [26] = {key = "restraint2_damage_reduct", name = "对坚属性英雄伤害减免"},
    [27] = {key = "restraint3_damage_reduct", name = "对疾属性英雄伤害减免"},
    [28] = {key = "restraint4_damage_reduct", name = "对特属性英雄伤害减免"},
    [29] = {key = "restraint_all_damage_reduct", name = "对全属性英雄伤害减免"},
    [30] = {key = "normal_attack_1", name = "普通攻击1段"},
    [31] = {key = "normal_attack_2", name = "普通攻击2段"},
    [32] = {key = "normal_attack_3", name = "普通攻击3段"},
    [33] = {key = "quan_neng", name = "全能"},
    [34] = {key = "normal_attack_4", name = "普通攻击4段"},
    [35] = {key = "normal_attack_5", name = "普通攻击5段"},
}

function PublicFunc.GetAllHeroProperty()
    return _heroPropertyConfig
end

function PublicFunc.GetHeroPropertyName(prop)
    if prop == nil then
        app.log("prop == nil")
        return ""
    end
    for k, v in pairs(_heroPropertyConfig) do
        if v.key == prop then
            return v.name
        end
    end
    return ""
end

function PublicFunc.NeedAttributeVerify(play_method_type)
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single and play_method_type ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
        return true
    end
    return false
end

function PublicFunc.GetIsAuto(hurdleid)
    local isAuto = false
    if hurdleid and hurdleid == FightScene.GetLevelID() then
        isAuto = g_dataCenter.player:CaptionIsAutoFight()
    else
        isAuto = FightManager.CalcIsAutoFight(hurdleid)
    end

    if isAuto then
        isAuto = 1
    else
        isAuto = 0
    end

    return isAuto
end

function PublicFunc.IsSpecEquipLevelLock(position)
    local id = nil
    if  position == ENUM.EEquipPosition.Helmet then
        id = MsgEnum.ediscrete_id.eDiscreteID_equip_level_up_helmet_unlock_player_level
    elseif position == ENUM.EEquipPosition.Accessories then
        id = MsgEnum.ediscrete_id.eDiscreteID_equip_level_up_accessories_unlock_player_level
    end
    if id ~= nil then
        local level = ConfigManager.Get(EConfigIndex.t_discrete, id).data
        return g_dataCenter.player:GetLevel() < level, level
    end
    return false
end

local BagShowTipExchangeType = {
	2,		-- 使用
	3,		-- 宝箱
	5,		-- 等级约束宝箱
}

function PublicFunc.IsBagShowTipItem(itemid)
    local res = false
    if itemid then
        local exchangeData = ConfigManager.Get(EConfigIndex.t_item_exchange,itemid)
        if exchangeData and table.index_of(BagShowTipExchangeType, exchangeData.type) > 0 then
            res = true
        end
    end
    return res
end

function PublicFunc.GetBagItemSaveKey(id)
	return "PackageUI_" .. id
end

function PublicFunc.BagNeedShowTipPoint(itemid)
	local ret = false
	if PublicFunc.IsBagShowTipItem(itemid) then
		if not PlayerEnterUITimesCurDay.HasEnterUI(PublicFunc.GetBagItemSaveKey(itemid)) then
			ret = true
		end
	end
	return ret
end

function PublicFunc.GetHeroHeadCfg(roleid)
    if roleid then
        local t1, t2 = math.modf(roleid / 1000)
        local config = ConfigManager.Get(EConfigIndex.t_role_head_info, t1 * 1000)
        if config then
            return config
        else
            return ConfigManager.Get(EConfigIndex.t_role_head_info, roleid)
        end
    end
    return nil
end

local __teamNameStr = 
{
    [ENUM.ETeamType.normal] = gs_misc['team_normal'],
    [ENUM.ETeamType.kuikuliya] = gs_misc['team_jixiantiaozhan'],
    [ENUM.ETeamType.arena] = gs_misc['team_arena'],
    [ENUM.ETeamType.world_boss] = gs_misc['team_world_boss'],
    [ENUM.ETeamType.world_treasure_box] = gs_misc['team_treasure_box'],
    [ENUM.ETeamType.guild_gaosujuji] = gs_misc['team_gaosujuji'],
    [ENUM.ETeamType.guild_Defend_war] = gs_misc['team_defend_war'],
    [ENUM.ETeamType.Clown_plan] = gs_misc['team_clown_plan'],
}

function PublicFunc.TeamIDToName(teamid)
    return __teamNameStr[teamid] or ''
end

--不确定配置表导出是{{xx=xx},...} 还是{xx=xx}, 均返回{{xx=xx},...}形式
function PublicFunc.GetConfigDataValue(config)
    if type(config) ~= "table" then
        return config
    end
    
    local key, val = next(config)
    if type(val) ~= "table" then
        return {config}
    else
        return config
    end
end
