
------------------------- 数据对象 ---------------------------
MaskItem = Class("MaskItem");

function MaskItem:Init()
    self.masklist = {};   --所有数据
    self.maskinfolist = {};
    self.configdata = {}
    self.updataitemlist = {}
    self.unlocklist = {}
    self.maskgroup = {}
    self.maxlvllist = {}  -- 解锁等级
    self.item_type = {}
    self.pro_list1 = {}
    self.pro_list2 = {}

    self.isfirst = true;

    --app.log("smaskgroup....."..table.tostring(self.maskgroup))

    return self
end

function MaskItem:InitMaskInfo(data)

    local maskconfigSort = ConfigManager._GetConfigTable(EConfigIndex.t_mask_sort);

    for k,v in pairs(maskconfigSort) do
        self.updataitemlist[v.sort] = {cost_exp_id1 = v.cost_exp_id1,cost_exp_id2 = v.cost_exp_id2,cost_exp_id3 = v.cost_exp_id3,cost_exp_id4 = v.cost_exp_id4}
        self.maskgroup[v.sort] = v.def_number
        self.maxlvllist[v.sort] = v.unlocal_level
        self.item_type[v.sort] = v.type
        local name = "t_"..v.cfg
        local config = ConfigManager._GetConfigTable(EConfigIndex[name])
        for kk,vv in pairs(config) do
            if self.configdata[vv.id] then
                app.log("重复id为..."..tostring(vv.id))
            else
                self.configdata[vv.id] = vv
            end
        end
    end

    for k,v in pairs(data) do

        self.masklist[v.index] = v
        self.unlocklist[v.index] = v.index
    end

    self:count_pro()
    
    self.isfirst = false;
    --app.log("self.unlocklist.."..table.tostring(self.unlocklist))
end

function MaskItem:isFirstOpen()

    return self.isfirst
end

function MaskItem:count_pro()
    
    --app.log("MaskItem:count_pro.........")
    local hp = 0;
    local atk = 0;
    local def = 0;
    local crit_rate = 0;
    local anti_crite = 0;
    local crit_hurt = 0;
    local broken_rate = 0;
    local parry_rate = 0;
    local parry_plus = 0;

    for k,v in pairs(self.masklist) do
        local number = v.number
        local lvl = v.level
        local nowdataconfig = self.configdata[number]
        local lastlvl = lvl-1

        addhp = PublicFunc.AttrInteger(nowdataconfig.default_max_hp+(nowdataconfig.max_hp_level_factor*lastlvl))
        addatk = PublicFunc.AttrInteger(nowdataconfig.default_atk_power+(nowdataconfig.atk_power_level_factor*lastlvl))
        adddef = PublicFunc.AttrInteger(nowdataconfig.default_def_power + (nowdataconfig.def_power_level_factor*lastlvl))

        addcrit_rate = PublicFunc.AttrInteger(nowdataconfig.crit_rate)
        addanti_crite = PublicFunc.AttrInteger(nowdataconfig.anti_crite)
        addcrit_hurt = PublicFunc.AttrInteger(nowdataconfig.crit_hurt)
        addbroken_rate = PublicFunc.AttrInteger(nowdataconfig.broken_rate)
        addparry_rate = PublicFunc.AttrInteger(nowdataconfig.parry_rate)
        addparry_plus = PublicFunc.AttrInteger(nowdataconfig.parry_plus)

        hp = hp + addhp
        atk = atk + addatk
        def = def + adddef
        crit_rate = crit_rate + addcrit_rate
        anti_crite = anti_crite+ addanti_crite
        crit_hurt = crit_hurt +addcrit_hurt
        broken_rate = broken_rate + addbroken_rate
        parry_rate = parry_rate +addparry_rate
        parry_plus = parry_plus + addparry_plus

        app.log("crit_rate.."..tostring(crit_rate))
    end

    self.pro_list1 = {}
    self.pro_list2 = {}

    table.insert(self.pro_list1,{add_tit = "生 命",now_value = hp})
    table.insert(self.pro_list1,{add_tit = "攻 击",now_value = atk})
    table.insert(self.pro_list1,{add_tit = "防 御",now_value = def})
    table.insert(self.pro_list1,{add_tit = "暴击率",now_value = crit_rate})
    table.insert(self.pro_list1,{add_tit = "免爆率",now_value = anti_crite})
    table.insert(self.pro_list2,{add_tit = "暴击伤害",now_value = crit_hurt})
    table.insert(self.pro_list2,{add_tit = "破击率",now_value = broken_rate})
    table.insert(self.pro_list2,{add_tit = "格挡率",now_value = parry_rate})
    table.insert(self.pro_list2,{add_tit = "格挡伤害",now_value = parry_plus})
  
end

function MaskItem:get_all_pro_list()
    return {self.pro_list1,self.pro_list2}
end

function MaskItem:updata_mask_info(maskinfo)

    if self.isfirst then
        local maskconfigSort = ConfigManager._GetConfigTable(EConfigIndex.t_mask_sort);

        for k,v in pairs(maskconfigSort) do
            self.updataitemlist[v.sort] = {cost_exp_id1 = v.cost_exp_id1,cost_exp_id2 = v.cost_exp_id2,cost_exp_id3 = v.cost_exp_id3,cost_exp_id4 = v.cost_exp_id4}
            self.maskgroup[v.sort] = v.def_number
            self.maxlvllist[v.sort] = v.unlocal_level
            self.item_type[v.sort] = v.type
            local name = "t_"..v.cfg
            local config = ConfigManager._GetConfigTable(EConfigIndex[name])
            for kk,vv in pairs(config) do
                if self.configdata[vv.id] then
                    app.log("重复id为..."..tostring(vv.id))
                else
                    self.configdata[vv.id] = vv
                end
            end
        end

        self.isfirst = false;
    end

    if self.masklist[maskinfo.index] then
        self.masklist[maskinfo.index] = maskinfo
    else
        self.masklist[maskinfo.index] = maskinfo
        self.unlocklist[maskinfo.index] = maskinfo.index
    end

    self:count_pro()
end

function MaskItem:getcastlist(index)
    return self.updataitemlist[index]
end

function MaskItem:getunlocklist()
    return self.unlocklist
end

function MaskItem:getmaskgroup(index)
    if self.maskgroup[index] then
        return self.maskgroup[index]
    else
        return 0
    end
end

function MaskItem:get_mask_config(id)
    if self.configdata[id] then
        return self.configdata[id]
    else    
        app.log("配置错误")
    end
end

function MaskItem:get_masklist()
    return self.masklist
end

--反查上一阶的id
function MaskItem:get_lastMaskData_Rarity(number)

    local flag = 0

    for k,v in pairs(self.configdata) do
        if v.rarity_up_number == number then
            flag = v.id
            break;
        end
    end

    return flag
end

--反查上一星的id
function MaskItem:get_lastMaskData_Rarity(number)

    local flag = 0

    for k,v in pairs(self.configdata) do
        if v.star_up_number == number then
            flag = v.id
            break;
        end
    end

    return flag
end

function MaskItem:get_max_unlock_lvl(index)
    if self.maxlvllist[index] then
        return self.maxlvllist[index]
    else
        return 0
    end
end

function MaskItem:get_item_type(index)
    if self.item_type[index] then
        return self.item_type[index]
    end
end


function MaskItem:get_show_lvl_exp(number,lvl)
    if self.configdata[number] then
        local name = "t_mask_upgrade_exp_"..tostring(self.configdata[number].upgrade_exp_cfg)
        local config = ConfigManager.Get(EConfigIndex[name],lvl)
        if config then
            return {config.show_big_level,config.show_lowwer_level,config.up_exp}
        end
    end
end

function MaskItem:get_show_lvl(number,lvl)

    if self.configdata[number] then
        local name = "t_mask_upgrade_exp_"..tostring(self.configdata[number].upgrade_exp_cfg)
        local config = ConfigManager.Get(EConfigIndex[name],lvl)
        if config then
            return config.show_big_level
        end
    end
end

function MaskItem:get_Max_lvl(number)
    if self.configdata[number] then
        local name = "t_mask_upgrade_exp_"..tostring(self.configdata[number].upgrade_exp_cfg)
        local configlist = ConfigManager._GetConfigTable(EConfigIndex[name])
        app.log("configlist........"..tostring(#configlist))
        local config = ConfigManager.Get(EConfigIndex[name],#configlist)
        if config then
            return config.show_big_level
        else
            return 0
        end
    else
        return 0
    end
end

function MaskItem:get_Need_exp(number,lvl)
    if self.configdata[number] then
        local name = "t_mask_upgrade_exp_"..tostring(self.configdata[number].upgrade_exp_cfg)
        local config = ConfigManager.Get(EConfigIndex[name],lvl)
        if config then
            return config.up_exp
        end
    end
end

function MaskItem:get_real_rarity(number)
    if self.configdata[number] then
        return self.configdata[number].real_rarity
    end
end

function MaskItem:get_mask_sprite(number)
    if self.configdata[number] then
        return self.configdata[number].make_pic_type
    end
end

function MaskItem:get_mask_name(number)
    if self.configdata[number] then
        return self.configdata[number].name
    end
end

local sp_decoration = {
    [1] = "mjd_diaopai_lv",
    [2] = "mjd_diaopai_lan",
    [3] = "mjd_diaopai_zi",
    [4] = "mjd_diaopai_hong",
}

local sp_decoration_pz = {
    [1] = "tx_pz_lvse",
    [2] = "tx_pz_lanse",
    [3] = "tx_pz_zise",
    [4] = "tx_pz_hongse",

}

local sp_level = {
    [1] = "mjd_1",
    [2] = "mjd_2",
    [3] = "mjd_3",
    [4] = "mjd_4",
    [5] = "mjd_5",
    [6] = "mjd_6",
    [7] = "mjd_7",
}

function MaskItem:get_ui_real_rarity(lvl)
    if lvl == 1 then
        return {sp_decoration[1],sp_level[1]}
    elseif lvl == 2 then
        return {sp_decoration[1],sp_level[2]}
    elseif lvl ==3 then
        return {sp_decoration[1],sp_level[3]}
    elseif lvl == 4 then
        return {sp_decoration[1],sp_level[4]}
    elseif lvl == 5 then
        return {sp_decoration[1],sp_level[5]}
    elseif lvl == 6 then
        return {sp_decoration[1],sp_level[6]}
    elseif lvl == 7 then
        return {sp_decoration[2],sp_level[1]}
    elseif lvl == 8 then
        return {sp_decoration[2],sp_level[2]}
    elseif lvl == 9 then
        return {sp_decoration[2],sp_level[3]}
    elseif lvl == 10 then
        return {sp_decoration[2],sp_level[4]}
    elseif lvl == 11 then
        return {sp_decoration[2],sp_level[5]}
    elseif lvl == 12 then
        return {sp_decoration[2],sp_level[6]}
    elseif lvl == 13 then
        return {sp_decoration[3],sp_level[1]}
    elseif lvl == 14 then
        return {sp_decoration[3],sp_level[2]}
    elseif lvl == 15 then
        return {sp_decoration[3],sp_level[3]}
    elseif lvl == 16 then
        return {sp_decoration[3],sp_level[4]}
    elseif lvl == 17 then
        return {sp_decoration[3],sp_level[5]}
    elseif lvl == 18 then
        return {sp_decoration[3],sp_level[6]}
    elseif lvl == 19 then
        return {sp_decoration[4],sp_level[1]}
    end
end

function MaskItem:get_ui_real_rarity_pz(lvl)
    if lvl == 1 then
        return {sp_decoration_pz[1],sp_level[1]}
    elseif lvl == 2 then
        return {sp_decoration_pz[1],sp_level[2]}
    elseif lvl ==3 then
        return {sp_decoration_pz[1],sp_level[3]}
    elseif lvl == 4 then
        return {sp_decoration_pz[1],sp_level[4]}
    elseif lvl == 5 then
        return {sp_decoration_pz[1],sp_level[5]}
    elseif lvl == 6 then
        return {sp_decoration_pz[1],sp_level[6]}
    elseif lvl == 7 then
        return {sp_decoration_pz[2],sp_level[1]}
    elseif lvl == 8 then
        return {sp_decoration_pz[2],sp_level[2]}
    elseif lvl == 9 then
        return {sp_decoration_pz[2],sp_level[3]}
    elseif lvl == 10 then
        return {sp_decoration_pz[2],sp_level[4]}
    elseif lvl == 11 then
        return {sp_decoration_pz[2],sp_level[5]}
    elseif lvl == 12 then
        return {sp_decoration_pz[2],sp_level[6]}
    elseif lvl == 13 then
        return {sp_decoration_pz[3],sp_level[1]}
    elseif lvl == 14 then
        return {sp_decoration_pz[3],sp_level[2]}
    elseif lvl == 15 then
        return {sp_decoration_pz[3],sp_level[3]}
    elseif lvl == 16 then
        return {sp_decoration_pz[3],sp_level[4]}
    elseif lvl == 17 then
        return {sp_decoration_pz[3],sp_level[5]}
    elseif lvl == 18 then
        return {sp_decoration_pz[3],sp_level[6]}
    elseif lvl == 19 then
        return {sp_decoration_pz[4],sp_level[1]}
    end
end

local sp_level_text = {
    [1] = "Ⅰ".."[-]",
    [2] = "Ⅱ".."[-]",
    [3] = "Ⅲ".."[-]",
    [4] = "Ⅳ".."[-]",
    [5] = "Ⅴ".."[-]",
    [6] = "Ⅵ".."[-]",
    [7] = "Ⅶ".."[-]",  
}

local sp_decoration_pz_text = {
    [1] = "[00ff73]".."优质",
    [2] = "[02c0ff]".."精良",
    [3] = "[ad4bff]".."稀有",
    [4] = "[FF0000]".."完美",

}

function MaskItem:get_ui_real_rarity_pz_text(lvl)
    if lvl == 1 then
        return {sp_decoration[1],sp_decoration_pz_text[1],sp_level_text[1]}
    elseif lvl == 2 then
        return {sp_decoration[1],sp_decoration_pz_text[1],sp_level_text[2]}
    elseif lvl ==3 then
        return {sp_decoration[1],sp_decoration_pz_text[1],sp_level_text[3]}
    elseif lvl == 4 then
        return {sp_decoration[1],sp_decoration_pz_text[1],sp_level_text[4]}
    elseif lvl == 5 then
        return {sp_decoration[1],sp_decoration_pz_text[1],sp_level_text[5]}
    elseif lvl == 6 then
        return {sp_decoration[1],sp_decoration_pz_text[1],sp_level_text[6]}
    elseif lvl == 7 then
        return {sp_decoration[2],sp_decoration_pz_text[2],sp_level_text[1]}
    elseif lvl == 8 then
        return {sp_decoration[2],sp_decoration_pz_text[2],sp_level_text[2]}
    elseif lvl == 9 then
        return {sp_decoration[2],sp_decoration_pz_text[2],sp_level_text[3]}
    elseif lvl == 10 then
        return {sp_decoration[2],sp_decoration_pz_text[2],sp_level_text[4]}
    elseif lvl == 11 then
        return {sp_decoration[2],sp_decoration_pz_text[2],sp_level_text[5]}
    elseif lvl == 12 then
        return {sp_decoration[2],sp_decoration_pz_text[2],sp_level_text[6]}
    elseif lvl == 13 then
        return {sp_decoration[3],sp_decoration_pz_text[3],sp_level_text[1]}
    elseif lvl == 14 then
        return {sp_decoration[3],sp_decoration_pz_text[3],sp_level_text[2]}
    elseif lvl == 15 then
        return {sp_decoration[3],sp_decoration_pz_text[3],sp_level_text[3]}
    elseif lvl == 16 then
        return {sp_decoration[3],sp_decoration_pz_text[3],sp_level_text[4]}
    elseif lvl == 17 then
        return {sp_decoration[3],sp_decoration_pz_text[3],sp_level_text[5]}
    elseif lvl == 18 then
        return {sp_decoration[3],sp_decoration_pz_text[3],sp_level_text[6]}
    elseif lvl == 19 then
        return {sp_decoration[4],sp_decoration_pz_text[4],sp_level_text[1]}
    end
end

function MaskItem:get_now_pro_lvl_value(number,lvl)

    


end

function MaskItem:get_now_pro_value(number,lvl)

    local nowdataconfig = self.configdata[number]

    local lastlvl = lvl-1

    local hp = PublicFunc.AttrInteger(nowdataconfig.default_max_hp+(nowdataconfig.max_hp_level_factor*lastlvl))
    local atk = PublicFunc.AttrInteger(nowdataconfig.default_atk_power+(nowdataconfig.atk_power_level_factor*lastlvl))
    local def = PublicFunc.AttrInteger(nowdataconfig.default_def_power + (nowdataconfig.def_power_level_factor*lastlvl))
    local crit_rate = PublicFunc.AttrInteger(nowdataconfig.crit_rate)
    local anti_crite = PublicFunc.AttrInteger(nowdataconfig.anti_crite)
    local crit_hurt = PublicFunc.AttrInteger(nowdataconfig.crit_hurt)
    local broken_rate = PublicFunc.AttrInteger(nowdataconfig.broken_rate)
    local parry_rate = PublicFunc.AttrInteger(nowdataconfig.parry_rate)
    local parry_plus = PublicFunc.AttrInteger(nowdataconfig.parry_plus)

    local next_rarity_number = nowdataconfig.rarity_up_number
    
    --app.log("get_now_pro_value     next_rarity_number=========="..tostring(next_rarity_number))

    if next_rarity_number == 0 then
        local pro_list = {}
        if hp > 0 then
            table.insert(pro_list,{add_tit = "生命",now_value = hp,isMax = true})
        end

        if atk > 0 then
            table.insert(pro_list,{add_tit = "攻击",now_value = atk,isMax = true})
        end

        if def > 0 then
            table.insert(pro_list,{add_tit = "防御",now_value = def,isMax = true})
        end

        if crit_rate > 0 then
            table.insert(pro_list,{add_tit = "暴击率",now_value = crit_rate,isMax = true})
        end

        if anti_crite > 0 then
            table.insert(pro_list,{add_tit = "免爆率",now_value = anti_crite,isMax = true})
        end

        if crit_hurt > 0 then
            table.insert(pro_list,{add_tit = "暴击伤害",now_value = crit_hurt,isMax = true})
        end

        if broken_rate > 0 then
            table.insert(pro_list,{add_tit = "破击率",now_value = broken_rate,isMax = true})
        end

        if parry_rate > 0 then
            table.insert(pro_list,{add_tit = "格挡率",now_value = parry_rate,isMax = true})
        end

        if parry_plus > 0 then
            table.insert(pro_list,{add_tit = "格挡伤害",now_value = parry_plus,isMax = true})
        end

        return pro_list
    else
        local nextdataconfig = self.configdata[next_rarity_number]
        local nexthp = PublicFunc.AttrInteger(nextdataconfig.default_max_hp+(nextdataconfig.max_hp_level_factor*lastlvl))
        local nextatk = PublicFunc.AttrInteger(nextdataconfig.default_atk_power+(nextdataconfig.atk_power_level_factor*lastlvl))
        local nextdef = PublicFunc.AttrInteger(nextdataconfig.default_def_power + (nextdataconfig.def_power_level_factor*lastlvl))
        local next_crit_rate = PublicFunc.AttrInteger(nextdataconfig.crit_rate)
        local next_anti_crite = PublicFunc.AttrInteger(nextdataconfig.anti_crite)
        local next_crit_hurt = PublicFunc.AttrInteger(nextdataconfig.crit_hurt)
        local next_broken_rate = PublicFunc.AttrInteger(nextdataconfig.broken_rate)
        local next_parry_rate = PublicFunc.AttrInteger(nextdataconfig.parry_rate)
        local next_parry_plus = PublicFunc.AttrInteger(nextdataconfig.parry_plus)

        local addhp = nexthp - hp
        local addatk = nextatk - atk
        local adddef = nextdef - def
        local add_crit_rate = next_crit_rate - crit_rate
        local add_anti_crite = next_anti_crite - anti_crite
        local add_crit_hurt = next_crit_hurt - crit_hurt
        local add_broken_rate = next_broken_rate - broken_rate
        local add_parry_rate = next_parry_rate - parry_rate
        local add_parry_plus = next_parry_plus - parry_plus

        local pro_list = {}

        if addhp > 0 then
            table.insert(pro_list,{add_tit = "生命",now_value = hp,add_value = nexthp})
        end

        if addatk > 0 then
            table.insert(pro_list,{add_tit = "攻击",now_value = atk,add_value = nextatk})
        end

        if adddef > 0 then
            table.insert(pro_list,{add_tit = "防御",now_value = def,add_value = nextdef})
        end

        if add_crit_rate > 0 then
            table.insert(pro_list,{add_tit = "暴击率",now_value = crit_rate,add_value = next_crit_rate})
        end

        if add_anti_crite > 0 then
            table.insert(pro_list,{add_tit = "免爆率",now_value = anti_crite,add_value = next_anti_crite})
        end

        if add_crit_hurt > 0 then
            table.insert(pro_list,{add_tit = "暴击伤害",now_value = crit_hurt,add_value = next_crit_hurt})
        end

        if add_broken_rate > 0 then
            table.insert(pro_list,{add_tit = "破击率",now_value = broken_rate,add_value = next_broken_rate})
        end

        if add_parry_rate > 0 then
            table.insert(pro_list,{add_tit = "格挡率",now_value = parry_rate,add_value = next_parry_rate})
        end

        if add_parry_plus > 0 then
            table.insert(pro_list,{add_tit = "格挡伤害",now_value = parry_plus,add_value = next_parry_plus})
        end

        return pro_list
    end
end

function MaskItem:get_now_pro_star_value(number,lvl)

    local nowdataconfig = self.configdata[number]

    local lastlvl = lvl-1

    local hp = PublicFunc.AttrInteger(nowdataconfig.default_max_hp+(nowdataconfig.max_hp_level_factor*lastlvl))
    local atk = PublicFunc.AttrInteger(nowdataconfig.default_atk_power+(nowdataconfig.atk_power_level_factor*lastlvl))
    local def = PublicFunc.AttrInteger(nowdataconfig.default_def_power + (nowdataconfig.def_power_level_factor*lastlvl))
    local crit_rate = PublicFunc.AttrInteger(nowdataconfig.crit_rate)
    local anti_crite = PublicFunc.AttrInteger(nowdataconfig.anti_crite)
    local crit_hurt = PublicFunc.AttrInteger(nowdataconfig.crit_hurt)
    local broken_rate = PublicFunc.AttrInteger(nowdataconfig.broken_rate)
    local parry_rate = PublicFunc.AttrInteger(nowdataconfig.parry_rate)
    local parry_plus = PublicFunc.AttrInteger(nowdataconfig.parry_plus)

    local next_rarity_number = nowdataconfig.star_up_number
    
    --app.log("get_now_pro_star_value        next_rarity_number=========="..tostring(next_rarity_number))

    if next_rarity_number == 0 then
        local pro_list = {}
        if hp > 0 then
            table.insert(pro_list,{add_tit = "生命",now_value = hp,isMax = true})
        end

        if atk > 0 then
            table.insert(pro_list,{add_tit = "攻击",now_value = atk,isMax = true})
        end

        if def > 0 then
            table.insert(pro_list,{add_tit = "防御",now_value = def,isMax = true})
        end

        if crit_rate > 0 then
            table.insert(pro_list,{add_tit = "暴击率",now_value = crit_rate,isMax = true})
        end

        if anti_crite > 0 then
            table.insert(pro_list,{add_tit = "免爆率",now_value = anti_crite,isMax = true})
        end

        if crit_hurt > 0 then
            table.insert(pro_list,{add_tit = "暴击伤害",now_value = crit_hurt,isMax = true})
        end

        if broken_rate > 0 then
            table.insert(pro_list,{add_tit = "破击率",now_value = broken_rate,isMax = true})
        end

        if parry_rate > 0 then
            table.insert(pro_list,{add_tit = "格挡率",now_value = parry_rate,isMax = true})
        end

        if parry_plus > 0 then
            table.insert(pro_list,{add_tit = "格挡伤害",now_value = parry_plus,isMax = true})
        end

        return pro_list
    else

        local nextdataconfig = self.configdata[next_rarity_number]
        if nextdataconfig then
            local nexthp = PublicFunc.AttrInteger(nextdataconfig.default_max_hp+(nextdataconfig.max_hp_level_factor*lastlvl))
            local nextatk = PublicFunc.AttrInteger(nextdataconfig.default_atk_power+(nextdataconfig.atk_power_level_factor*lastlvl))
            local nextdef = PublicFunc.AttrInteger(nextdataconfig.default_def_power + (nextdataconfig.def_power_level_factor*lastlvl))
            local next_crit_rate = PublicFunc.AttrInteger(nextdataconfig.crit_rate)
            local next_anti_crite = PublicFunc.AttrInteger(nextdataconfig.anti_crite)
            local next_crit_hurt = PublicFunc.AttrInteger(nextdataconfig.crit_hurt)
            local next_broken_rate = PublicFunc.AttrInteger(nextdataconfig.broken_rate)
            local next_parry_rate = PublicFunc.AttrInteger(nextdataconfig.parry_rate)
            local next_parry_plus = PublicFunc.AttrInteger(nextdataconfig.parry_plus)

            local addhp = nexthp - hp
            local addatk = nextatk - atk
            local adddef = nextdef - def
            local add_crit_rate = next_crit_rate - crit_rate
            local add_anti_crite = next_anti_crite - anti_crite
            local add_crit_hurt = next_crit_hurt - crit_hurt
            local add_broken_rate = next_broken_rate - broken_rate
            local add_parry_rate = next_parry_rate - parry_rate
            local add_parry_plus = next_parry_plus - parry_plus

            local pro_list = {}

            if addhp > 0 then
                table.insert(pro_list,{add_tit = "生命",now_value = hp,add_value = nexthp})
            end

            if addatk > 0 then
                table.insert(pro_list,{add_tit = "攻击",now_value = atk,add_value = nextatk})
            end

            if adddef > 0 then
                table.insert(pro_list,{add_tit = "防御",now_value = def,add_value = nextdef})
            end

            if add_crit_rate > 0 then
                table.insert(pro_list,{add_tit = "暴击率",now_value = crit_rate,add_value = next_crit_rate})
            end

            if add_anti_crite > 0 then
                table.insert(pro_list,{add_tit = "免爆率",now_value = anti_crite,add_value = next_anti_crite})
            end

            if add_crit_hurt > 0 then
                table.insert(pro_list,{add_tit = "暴击伤害",now_value = crit_hurt,add_value = next_crit_hurt})
            end

            if add_broken_rate > 0 then
                table.insert(pro_list,{add_tit = "破击率",now_value = broken_rate,add_value = next_broken_rate})
            end

            if add_parry_rate > 0 then
                table.insert(pro_list,{add_tit = "格挡率",now_value = parry_rate,add_value = next_parry_rate})
            end

            if add_parry_plus > 0 then
                table.insert(pro_list,{add_tit = "格挡伤害",now_value = parry_plus,add_value = next_parry_plus})
            end

            return pro_list
        else
            local pro_list = {}
            if hp > 0 then
                table.insert(pro_list,{add_tit = "生命",now_value = hp,isMax = true})
            end

            if atk > 0 then
                table.insert(pro_list,{add_tit = "攻击",now_value = atk,isMax = true})
            end

            if def > 0 then
                table.insert(pro_list,{add_tit = "防御",now_value = def,isMax = true})
            end

            if crit_rate > 0 then
                table.insert(pro_list,{add_tit = "暴击率",now_value = crit_rate,isMax = true})
            end

            if anti_crite > 0 then
                table.insert(pro_list,{add_tit = "免爆率",now_value = anti_crite,isMax = true})
            end

            if crit_hurt > 0 then
                table.insert(pro_list,{add_tit = "暴击伤害",now_value = crit_hurt,isMax = true})
            end

            if broken_rate > 0 then
                table.insert(pro_list,{add_tit = "破击率",now_value = broken_rate,isMax = true})
            end

            if parry_rate > 0 then
                table.insert(pro_list,{add_tit = "格挡率",now_value = parry_rate,isMax = true})
            end

            if parry_plus > 0 then
                table.insert(pro_list,{add_tit = "格挡伤害",now_value = parry_plus,isMax = true})
            end

            return pro_list
        end
    end
end

function MaskItem:checkLvlPoint()

    local flag = false

    --app.log("checkLvlPoint....self.masklist"..table.tostring(self.masklist))

    for k,v in pairs(self.masklist) do
        local castlist = g_dataCenter.maskitem:getcastlist(v.index)

        for i=1,4 do
            local itemname = "cost_exp_id"..tostring(i)
            local card_id = castlist[itemname]
            local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,card_id);
            local lvldata = self:get_show_lvl_exp(v.number,v.level)
            if lvldata then
                local maxexp = lvldata[3]

                if maxexp ~= 0 then
                    if number > 0 then       
                        return true
                    end
                end
            end
        end

    end

    return flag

end

function MaskItem:checkLvlPoint_mask(index)

    local flag = false

    local castlist = g_dataCenter.maskitem:getcastlist(index)

    for i=1,4 do
        local itemname = "cost_exp_id"..tostring(i)
        local card_id = castlist[itemname]
        local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,card_id);

        local lvldata = self:get_show_lvl_exp(self.masklist[index].number,self.masklist[index].level)

        local maxexp = lvldata[3]

        if maxexp == 0 then
            return false
        end

        if number > 0 then       
            return true
        end
    end

    return flag
end

function MaskItem:checkRarityPoint()

    local flag = false

    for k,v in pairs(self.masklist) do
        local up_rarity_data = self:get_mask_config(v.number)
       
        local up_rarity_lvl = up_rarity_data.rarity_up_level
        local up_rarity_gold = up_rarity_data.rarity_up_gold
        local itemlist = up_rarity_data.rarity_up_material

        local index = 0;

        if itemlist ~= 0 then
            for i=1,#itemlist do
                local itemid = itemlist[i][1]
                local count = itemlist[i][2]
                local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,itemid);

                if number >= count then
                    index = index + 1
                end

            end
        end

        if index == 3 then
            return true
        end

    end
        
    return flag

end

function MaskItem:checkRarityPoint_mask(info)

    local flag = false

    local havegold = g_dataCenter.player.gold
    local currlvl = info.level

    local up_rarity_data = self:get_mask_config(info.number)
       
    local up_rarity_lvl = up_rarity_data.rarity_up_level
    local up_rarity_gold = up_rarity_data.rarity_up_gold
    local itemlist = up_rarity_data.rarity_up_material

    if havegold < up_rarity_gold then
        return false
    end

    if currlvl < up_rarity_lvl then
        return false
    end

    local index = 0;

    --app.log("itemlist..........."..table.tostring(itemlist))

    if itemlist == 0 then
        return false
    end

    for i=1,#itemlist do
        local itemid = itemlist[i][1]
        local count = itemlist[i][2]
        local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,itemid);

        if number >= count then
            index = index + 1
        end

    end

    if index == 3 then
        return true
    end

    return flag

end

function MaskItem:CheckStarPoint()
    local flag = false
    for k,v in pairs(self.masklist) do

        local itemid = g_dataCenter.maskitem:get_mask_config(v.number).hero_soul_item_id
        local count = g_dataCenter.maskitem:get_mask_config(v.number).soul_count
        local up_star_itemid = g_dataCenter.maskitem:get_mask_config(v.number).star_up_number
        if up_star_itemid ~= 0 then

            local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,itemid);

            if number >= count then
                return true
            end
        end
    end
    
    return flag
end

function MaskItem:CheckStarPoint_mask(maskid)

    local flag = false

    local itemid = g_dataCenter.maskitem:get_mask_config(maskid).hero_soul_item_id
    local count = g_dataCenter.maskitem:get_mask_config(maskid).soul_count
    local up_star_itemid = g_dataCenter.maskitem:get_mask_config(maskid).star_up_number
    if up_star_itemid == 0 then
        return false
    end

    local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,itemid);

    if number >= count then
        return true
    end

    return flag
end
