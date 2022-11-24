--故事冒险
local gmCmd = 
{
    lv = "gm_set_level",
    tj = "gm_set_illustrations",
    tf = "gm_set_talent",
    yjs = "gm_set_laboratory",
    xlg = "gm_set_training_hall",
    yxlv = "gm_set_role_level",
    ylxj = "gm_set_role_star",
    qnqhl = "gm_set_neidan_level",
    jnlv = "gm_set_skill_level",
    yxpz = "gm_set_role_rarity",
    jxtp = "gm_set_breakthrough",
    zblv = "gm_set_equip_level",
    zbxj = "gm_set_equip_star",
    kkly = "gm_set_kuikuliya",
    bwz = "gm_set_battle_war",
    gsjj = "gm_set_gaosujuji",
    xcjh = "gm_set_clown_plan",
    viplv = "gm_set_vip_level",
    stlv = "gm_set_guild_level",
    stgx = "gm_add_guild_contribution",
    clear = "gm_clear",
    wboss = "gm_set_world_boss_hp",
    jf3v3 = "gm_add_three_to_three_integral",
    yzgs = "gm_set_trial",
    yzcz = "gm_reset_trial",
    jjcpm = "gm_set_arena_ranking",
    stlq = "gm_join_guild_cooldown",
    sboss = "gm_set_guild_boss_hp",
    stpp = "gm_guild_war",
    scwt = "gm_set_clone_war",
    prolog = "protol_log",
    mail = "gm_systemmail",
    xlgherolv = "gm_set_training_hall_default_star_hero_lv",
    xlgteam = "gm_set_training_hall_group_lv",
    masklv = "gm_set_mask_level",
    maskrarity = "gm_set_mask_rarity",
    maskstar = "gm_set_mask_star",
}
function UiGm:on_btn_click(t)
	local string_cmd = "";
	if self.id_change or self.num_change then 
        local inputValue = self.input_id:get_value()
        local number = tonumber(inputValue)
        if inputValue == "fhrai" then
            local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
            local cap = FightManager.GetMyCaptain()
            if cap then
                for k, v in pairs(hero_list) do
                    local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= cap then
                        obj:SetAI(118)
                    end
                end
            end
            FloatTip.Float("success")
            return
        end
        if inputValue == "fhoai" then
            local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
            local cap = FightManager.GetMyCaptain()
            if cap then
                for k, v in pairs(hero_list) do
                    local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= cap then
                        obj:SetAiEnable(true)
                    end
                end
            end
            FloatTip.Float("success")
            return
        end
        if inputValue == "fhcai" then
            local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
            local cap = FightManager.GetMyCaptain()
            if cap then
                for k, v in pairs(hero_list) do
                    local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= cap then
                        obj:CloseAI()
                    end
                end
            end
            FloatTip.Float("success")
            return
        end

        if inputValue == "fhcani" then
            local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
            local cap = FightManager.GetMyCaptain()
            if cap then
                for k, v in pairs(hero_list) do
                    local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= cap then
                        obj:CloseAI()
                        if obj.object then
                            obj.object:set_animator_enable(false)
                        end
                    end

                end
            end
            FloatTip.Float("success")
            return
        end

        if inputValue == "fhcc" then
            local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
            local cap = FightManager.GetMyCaptain()
            if cap then
                for k, v in pairs(hero_list) do
                    local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= cap then
                        obj:CloseAI()
                        if obj.object then
                            obj.object:set_collider_enable(false, true)
                        end
                    end

                end
            end
            FloatTip.Float("success")
            return
        end

        if inputValue == "fhcr" then
            local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
            local cap = FightManager.GetMyCaptain()
            if cap then
                for k, v in pairs(hero_list) do
                    local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= cap then
                        --obj:CloseAI()
                        if obj.object then
                            --obj.object:set_animator_enable(false)
                            obj.object:set_render_enable(false, true)
                        end
                    end
                end
            end
            FloatTip.Float("success")
            return
        end

        if inputValue == "fhchp" then
            local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
            local cap = FightManager.GetMyCaptain()
            if cap then
                for k, v in pairs(hero_list) do
                    local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= cap then
                        obj:CloseAI()
                        obj:ShowHP(false)
                    end
                end
            end
            FloatTip.Float("success")
            return
        end

--[[
        if inputValue == "fhcup" then
            local hero_list = g_dataCenter.fight_info:GetControlHeroList(g_dataCenter.fight_info.single_friend_flag)
            local cap = FightManager.GetMyCaptain()
            if cap then
                for k, v in pairs(hero_list) do
                    local teamIndex = g_dataCenter.fight_info:GetControlIndex(v)
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= cap then
                        obj._colosed_update = true
                    end
                end
            end
            FloatTip.Float("success")
            return
        end
]]
        if inputValue == "all hero" then 
            local star = self.input_num:get_value(); 
            for k,role in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_role_index)) do 
                if star == "0" then 
                    if role.id == role.default_rarity then
                        system.cg_gm_cmd("gm_add_item "..role.id.." 1");
                    end
                else 
                    if role.id%1000 == (tonumber(star)-1)*100 then
                        system.cg_gm_cmd("gm_add_item "..role.id.." 1");
                    end
                end
            end
            return;
        end
        if inputValue == "all show hero" then 
            local star = self.input_num:get_value();
            for k,role in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_role_index)) do
                if star == "0" then 
                    if role.id == role.default_rarity and role.is_show == 1 then
                        system.cg_gm_cmd("gm_add_item "..role.id.." 1");
                    end
                else
                    if role.id%1000 == (tonumber(star)-1)*100 and role.is_show == 1 then
                        system.cg_gm_cmd("gm_add_item "..role.id.." 1");
                    end
                end
            end
            return;
        end
        if inputValue == "store" then
            local store_index = self.input_num:get_value();
            system.cg_gm_cmd("gm_set_store_success "..store_index);
            return;
        end
        if inputValue == "send chat" then
            local count = self.input_num:get_value();
            for i = 1, count do
                msg_chat.cg_player_chat(PublicStruct.Chat.world, tostring(i), 0, 0);
            end
            return;
        end
        if inputValue == "guide tip" then
            local count = self.input_num:get_value();
            Guide_PrintAll(tonumber(count));
            return;
        end
        if inputValue == "gmdrop" then
            local count = self.input_num:get_value();
            system.cg_gm_cmd("gm_test_drop "..tostring(count));
            return;
        end

        if inputValue == "config" then
            local count = tonumber(self.input_num:get_value());
            local cf = ConfigManager.Get(EConfigIndex.t_gm_cmd, count);
            if not cf then
                FloatTip.Float("未找到此配置id  "..tostring(count))
                return;
            end
            system.cg_gm_cmd("gm_set_level "..tostring(cf.player_level));
            system.cg_gm_cmd("gm_set_role_level 0 "..tostring(cf.role_level));
            system.cg_gm_cmd("gm_set_role_rarity 0 "..tostring(cf.role_rarity));
            system.cg_gm_cmd("gm_set_role_star 0 "..tostring(cf.role_star));
            system.cg_gm_cmd("gm_set_skill_level 0 "..tostring(cf.role_skill_level));
            for i = 1, 6 do
                local temp = cf["role_breakthrough_"..i];
                if temp ~= 0 and temp ~= nil then
                    system.cg_gm_cmd("gm_set_breakthrough 0 "..i.." "..temp);
                end
            end
            system.cg_gm_cmd("gm_set_equip_level 0 "..tostring(cf.equip_level));
            system.cg_gm_cmd("gm_set_equip_star 0 "..tostring(cf.equip_star));
            system.cg_gm_cmd("gm_set_illustrations "..tostring(cf.illumstration));   
            
            if type(cf.talent) == "table" then
                for k, v in pairs(cf.talent) do
                    system.cg_gm_cmd("gm_set_talent "..tostring(v[1]).." "..tostring(v[2]));
                end
            end
            if type(cf.laboratory) == "table" then
                for k, v in pairs(cf.laboratory) do
                    system.cg_gm_cmd("gm_set_laboratory "..tostring(v[1]).." "..tostring(v[2]).." "..tostring(v[3]));
                end
            end
            if type(cf.training_hall_level) == "table" then
                for k, v in pairs(cf.training_hall_level) do
                    system.cg_gm_cmd("gm_set_training_hall_default_star_hero_lv "..tostring(v[1]).." "..tostring(v[2]));
                end
            end
            if type(cf.training_hall_up) == "table" then
                for k, v in pairs(cf.training_hall_up) do
                    system.cg_gm_cmd("gm_set_training_hall_group_lv "..tostring(v[1]).." "..tostring(v[2]));
                end
            end
            if type(cf.mask_level) == "table" then
                for k, v in pairs(cf.mask_level) do
                    system.cg_gm_cmd("gm_set_mask_level "..tostring(v[1]).." "..tostring(v[2]));
                end
            end
            if type(cf.mask_rarity) == "table" then    
                for k, v in pairs(cf.mask_rarity) do
                    system.cg_gm_cmd("gm_set_mask_rarity "..tostring(v[1]).." "..tostring(v[2]));
                end
            end
            if type(cf.mask_star) == "table" then
                for k, v in pairs(cf.mask_star) do
                    system.cg_gm_cmd("gm_set_mask_star "..tostring(v[1]).." "..tostring(v[2]));
                end
            end    
            
            return;
        end
        if number ~= nil then
		    if inputValue == "999" then
			    local list = g_dataCenter.hurdle:GetSortSection();
			    for i=1,self.input_num:get_value() do
                    if list[i] then
				        local str = string.format("gm_passgroup %d 3", list[i].id);
				        app.log(".."..str)
				        system.cg_gm_cmd( str);
                    end
			    end
			    return
		    end
            if inputValue == "1999" then
                local list = g_dataCenter.hurdle:GetSortSection(EHurdleType.eHurdleType_elite);
                for i=1,self.input_num:get_value() do
                    if list[i] then
                        local str = string.format("gm_passgroup %d 3", list[i].id);
                        app.log(".."..str)
                        system.cg_gm_cmd( str);
                    end
                end
                return
            end
            if inputValue == "123321" then              
                for k,v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_item)) do
                    if v.name then
                        local _,_,str = string.find(v.name,"(%(废%))")
                        -- app.log("#v.name#"..tostring(v.name))
                        if nil == str then       
                        --app.log("#v.name#"..tostring(v.name))
                        --app.log("gm_add_item "..tostring(k).." "..self.input_num:get_value())
                        system.cg_gm_cmd("gm_add_item "..tostring(k).." "..self.input_num:get_value())
                        end
                    end
                end
            end
		    string_cmd = "gm_add_item "..tostring(inputValue).." "..tostring(self.input_num:get_value())
		    system.cg_gm_cmd(string_cmd);
        elseif string.len(inputValue) > 0 then
            local tempValue = self.input_num:get_value();
            local cmd = inputValue.." "..tempValue;
            if gmCmd[inputValue] then
                cmd = gmCmd[inputValue].." "..tempValue;
                system.cg_gm_cmd(cmd);
            else
                FloatTip.Float("不可识别的gm命令  "..cmd);
            end
        end
	else
		app.log("没输入id或者个数");
	end
end