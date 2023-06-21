MaskMain = Class("MaskMain", UiBaseClass);

function MaskMain:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/mask/ui_905_mask.assetbundle";
    UiBaseClass.Init(self, data);
end

function MaskMain:InitData(data)

    UiBaseClass.InitData(self, data);

    self.masklist = ConfigManager._GetConfigTable(EConfigIndex.t_mask_sort);

end

function MaskMain:Restart(data)

    if not UiBaseClass.Restart(self, data) then

    end
end

function MaskMain:RegistFunc()
	UiBaseClass.RegistFunc(self)
    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc["on_chose_item"] = Utility.bind_callback(self, self.on_chose_item);
    self.bindfunc["UpdateUi"] = Utility.bind_callback(self, self.UpdateUi);
    self.bindfunc["animated_play_mask"] = Utility.bind_callback(self, self.animated_play_mask);
    self.bindfunc["animated_play_label"] = Utility.bind_callback(self, self.animated_play_label);
    self.bindfunc["animated_play_left"] = Utility.bind_callback(self,self.animated_play_left)
    
end

--注册消息分发回调函数
function MaskMain:MsgRegist()
    UiBaseClass.MsgRegist(self)
    --PublicFunc.msg_regist(msg_mask.gc_get_mask_info, self.bindfunc["UpdateUi"])

    
end

--注销消息分发回调函数
function MaskMain:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    --PublicFunc.msg_unregist(msg_mask.gc_get_mask_info, self.bindfunc["UpdateUi"])
end


function MaskMain:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("MaskMain");

    self.scroll_view = ngui.find_scroll_view(self.ui,"down_other/animation/scroll_view/panel_list")
    self.scroll_view:set_active(false)
    self.wrap_content = ngui.find_wrap_content(self.ui,"down_other/animation/scroll_view/panel_list/wrap_content")
    self.wrap_content:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);

    self.pro_lab1 = {}
    self.pro_lab2 = {}
    for i=1,5 do
        self.pro_lab1[i] = ngui.find_label(self.ui,"down_other/animation/panel_nature/grid_nature1/lab"..i)
        self.pro_lab1[i]:set_text("")
        self.pro_lab2[i] = ngui.find_label(self.ui,"down_other/animation/panel_nature/grid_nature2/lab"..i)
        self.pro_lab2[i]:set_text("")
    end

    self.mask_label_anmation = self.ui:get_child_by_name("down_other/animation")
    
    
    local flag = g_dataCenter.maskitem:isFirstOpen()

    self:UpdateUi()
 
    --self.scroll_view:reset_position();
    self.time_id1 = timer.create(self.bindfunc["animated_play_mask"],100,1);
    
    
end

function MaskMain:animated_play_mask()
    self.scroll_view:set_active(true)

    self:animated_play_left()
    
end

function MaskMain:animated_play_left()
    self.mask_label_anmation:animated_play("ui_905_mask_mianju")
    self.time_id2 = timer.create(self.bindfunc["animated_play_label"],500,1);
end

function MaskMain:animated_play_label()
    self.mask_label_anmation:animated_play("ui_905_mask")
end

function MaskMain:UpdateUi()

    self.maskinfo = g_dataCenter.maskitem:get_masklist()

    local masknum = #self.masklist

    self.wrap_content:set_min_index(0);
    self.wrap_content:set_max_index(masknum-1);
    self.wrap_content:reset();

    local all_pro = g_dataCenter.maskitem:get_all_pro_list()

    for k,v in pairs(all_pro[1]) do
        self.pro_lab1[k]:set_text("[F39998FF]"..v.add_tit.."[-][00FF73FF]+"..tostring(v.now_value).."[-]")
    end

    for k,v in pairs(all_pro[2]) do
        self.pro_lab2[k]:set_text("[F39998FF]"..v.add_tit.."[-][00FF73FF]+"..tostring(v.now_value).."[-]")
    end


    
end

function MaskMain:init_item_wrap_content(obj, b, real_id)

    local index = math.abs(real_id) + 1;
    --local index_b = math.abs(b) + 1;

    --app.log("index..."..tostring(index))
    --app.log("index_b..."..tostring(index_b))
    self.masklist[index] = {}
    self.masklist[index].obj = obj
    self.masklist[index].white2 = ngui.find_sprite(obj,"sp_dizuo/sp_white_cloth1")  --半露
    self.masklist[index].white2:set_active(false)
    self.masklist[index].white1 = ngui.find_sprite(obj,"sp_dizuo/sp_white_cloth2")  --不露
    self.masklist[index].white1:set_active(false)

    self.masklist[index].sp_mote = ngui.find_sprite(obj,"sp_dizuo/sp_mote")        --底座
    self.masklist[index].sp_mote:set_active(false)

    self.masklist[index].white3 = ngui.find_sprite(obj,"sp_dizuo/sp_white_cloth3")  -- 昆克全挡
    self.masklist[index].white3:set_active(false)

    self.masklist[index].kunkeitem = obj:get_child_by_name("sp_dizuo/cont_kunke")   -- 箱子
    self.masklist[index].kunkeitem:set_active(false)

    self.masklist[index].kunkeitem_open = ngui.find_texture(obj,"sp_dizuo/cont_kunke/texture_open") --打开
    self.masklist[index].kunkeitem_close = ngui.find_texture(obj,"sp_dizuo/cont_kunke/texture_close") --关闭
    self.masklist[index].kunkeitem_sp = ngui.find_texture(obj,"sp_dizuo/cont_kunke/texture_open/texture_weapon")
    self.masklist[index].kunkeitem_pingzi = ngui.find_sprite(obj,"sp_dizuo/cont_kunke/texture_open/sp_decoration")  --品质
    self.masklist[index].kunkeitem_lvl = ngui.find_sprite(obj,"sp_dizuo/cont_kunke/texture_open/sp_decoration/sp_level") --等级


    self.masklist[index].mask_sprite = ngui.find_texture(obj,"sp_dizuo/texture_mask")     --面具
    self.masklist[index].mask_sprite:set_active(false)

    self.masklist[index].pingzi = ngui.find_sprite(obj,"sp_dizuo/sp_decoration")    --品质
    self.masklist[index].pingzi:set_active(false)

    self.masklist[index].lvl = ngui.find_sprite(obj,"sp_dizuo/sp_decoration/sp_level")  --等级
    self.masklist[index].di = obj:get_child_by_name("sp_dizuo/sp_di1")                  --开启
    self.masklist[index].di_lab_name = ngui.find_label(obj,"sp_dizuo/sp_di1/lab_name")             --面具名称
    self.masklist[index].di_lab_level = ngui.find_label(obj,"sp_dizuo/sp_di1/lab_level")           --等级

    self.masklist[index].di2 = obj:get_child_by_name("sp_dizuo/sp_di2")                 --未开启
    self.masklist[index].di2_lab_name = ngui.find_label(obj,"sp_dizuo/sp_di2/lab_name") -- 名子
    self.masklist[index].di2_lab_describe = ngui.find_label(obj,"sp_dizuo/sp_di2/lab_describe") -- 开启条件
    
    self.masklist[index].star_ui = obj:get_child_by_name("sp_dizuo/grid")
    self.masklist[index].star = {}
    for i=1,7 do
        self.masklist[index].star[i] = ngui.find_sprite(obj,"sp_dizuo/grid/sp_prop"..i) -- 星
        self.masklist[index].star[i]:set_sprite_name("mjd_yanjing2")
    end

    self.masklist[index].skillinfobtn = ngui.find_button(obj,"sp_dizuo/btn_blue")           --技能详情
    self.masklist[index].skillinfobtn:set_active(false)

    self.masklist[index].infobtn = ngui.find_button(obj,"sp_dizuo/btn_empty")           --详情
    self.masklist[index].infobtn:set_on_click(self.bindfunc["on_chose_item"])
    self.masklist[index].infobtn:set_event_value("",index)

    local unlocklist = g_dataCenter.maskitem:getunlocklist()
    local unlocknum = #unlocklist


    self.point = ngui.find_sprite(obj,"sp_dizuo/sp_point")

    if self.maskinfo[index] then
        if g_dataCenter.maskitem:checkLvlPoint_mask(index) or g_dataCenter.maskitem:checkRarityPoint_mask(self.maskinfo[index]) or g_dataCenter.maskitem:CheckStarPoint_mask(self.maskinfo[index].number) then
            self.point:set_active(true)
        else
            self.point:set_active(false)
        end
    else
        self.point:set_active(false)
    end

    -- if self.maskinfo[index] then
    --     local property = self.maskinfo[index].property
    --     app.log("maskinfo......"..table.tostring(property))
    -- end
    --物品类型  1面具  2昆克
    local item_type = g_dataCenter.maskitem:get_item_type(index)

    app.log("item_type================"..tostring(item_type))

    if unlocklist[index] then
        if item_type == 1 then
            self:set_maskui_data(index)
        else
            self:set_kunkeui_data(index)
        end
    end

    if index == unlocknum + 1 then
        self:set_next_item_data(index)
    end

    if index > unlocknum+1 then
        local item_type = g_dataCenter.maskitem:get_item_type(index)
        self:hide_maskui(index)
        self.masklist[index].star_ui:set_active(false)
        self.masklist[index].di:set_active(false)
        self.masklist[index].di2:set_active(false)
        if item_type == 1 then
            self.masklist[index].white2:set_active(true)
        else
            self.masklist[index].white3:set_active(true)
        end
    end

    -- do return end

    -- if unlocklist[index] then
    --     self.masklist[index].white1:set_active(false)
    --     self.masklist[index].white2:set_active(false)
    --     self.masklist[index].di:set_active(true)
    --     self.masklist[index].di2:set_active(false)
    --     self.masklist[index].infobtn:set_active(true)
    --     self.masklist[index].star_ui:set_active(true)
    -- else
    --     self.masklist[index].di:set_active(false)
    --     self.masklist[index].di2:set_active(true)
    --     self.masklist[index].infobtn:set_active(false)
    --     self.masklist[index].star_ui:set_active(false)
    -- end

    -- if index == unlocknum + 1 then
    --     self.masklist[index].white2:set_active(false)
    --     self.masklist[index].white1:set_active(true)

    --     local nextnumber = g_dataCenter.maskitem:getmaskgroup(index)

    --     app.log("index..........."..tostring(index))
    --     app.log("nextnumber..........."..tostring(nextnumber))

    --     if nextnumber then
    --         local config = g_dataCenter.maskitem:get_mask_config(nextnumber)

    --         if config then
    --             self.masklist[index].mask_sprite:set_texture(config.make_pic_type)
    --             self.masklist[index].di_lab_name:set_text(config.name)
    --             self.masklist[index].di2_lab_name:set_text(config.name)
    --             local maxlvl = g_dataCenter.maskitem:get_max_unlock_lvl(index)
    --             --self.masklist[index].di_lab_level:set_text(tostring(self.maskinfo[index].level).."/"..tostring(maxlvl))
    --             self.masklist[index].di2_lab_describe:set_text("[FF0000FF]"..tostring(maxlvl).."[-]级解锁")
    --         end

    --     end

    -- else
    --     self.masklist[index].di2:set_active(false)
    --     self.masklist[index].white1:set_active(false)
    -- end

    -- if self.maskinfo[index] then 
    --     local config = g_dataCenter.maskitem:get_mask_config(self.maskinfo[index].number)
    --     if config then
    --         self.masklist[index].mask_sprite:set_texture(config.make_pic_type)
    --         self.masklist[index].di_lab_name :set_text(config.name)
    --         self.masklist[index].di2_lab_name:set_text(config.name)
    --         local maskid = self.maskinfo[index].number
    --         local show_lvl = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo[index].number,self.maskinfo[index].level)
    --         local lvl = self.maskinfo[index].level
    --         local maxlvl = g_dataCenter.maskitem:get_Max_lvl(maskid)
    --         --app.log("maxlvl=============="..tostring(maxlvl))
    --         if maxlvl == 0 then
    --             maxlvl = self.maskinfo[index].level
    --         end
    --         self.masklist[index].di_lab_level:set_text(tostring(show_lvl[1]).."/"..tostring(maxlvl))

    --         local rarity = config.rarity

    --         for i=1,rarity do
    --             self.masklist[index].star[i]:set_sprite_name("mjd_yanjing1")
    --         end

    --         --品质
    --         local real_rarity = g_dataCenter.maskitem:get_real_rarity(maskid)
    --         app.log("real_rarity......"..tostring(real_rarity))
    --         local real_rarity_ui = g_dataCenter.maskitem:get_ui_real_rarity(real_rarity)

    --         app.log("real_rarity_ui..."..table.tostring(real_rarity_ui))
    --         self.masklist[index].pingzi:set_sprite_name(real_rarity_ui[1])
    --         if real_rarity_ui[2] == "0" then
    --             self.masklist[index].lvl:set_sprite_name("")
    --         else
    --             self.masklist[index].lvl:set_sprite_name(real_rarity_ui[2])
    --         end
    --     end
    -- end
    
end

function MaskMain:set_next_item_data(index)
    local item_type = g_dataCenter.maskitem:get_item_type(index)

    if item_type == 1 then
        self:hide_kunkeui(index)
        self:show_maskui(index)
        self.masklist[index].white2:set_active(false)
        self.masklist[index].white1:set_active(true)
        self.masklist[index].di:set_active(false)
        self.masklist[index].di2:set_active(true)
        self.masklist[index].star_ui:set_active(false)

        local nextnumber = g_dataCenter.maskitem:getmaskgroup(index)

        if nextnumber then
            local config = g_dataCenter.maskitem:get_mask_config(nextnumber)

            if config then
                self.masklist[index].mask_sprite:set_texture(config.make_pic_type)
                self.masklist[index].di_lab_name:set_text(config.name)
                self.masklist[index].di2_lab_name:set_text(config.name)
                local needlvl = g_dataCenter.maskitem:get_max_unlock_lvl(index)
                --self.masklist[index].di_lab_level:set_text(tostring(self.maskinfo[index].level).."/"..tostring(maxlvl))
                local maxlvl = g_dataCenter.maskitem:get_Max_lvl(nextnumber,needlvl)
                self.masklist[index].di2_lab_describe:set_text("前藏品[FF0000FF]"..tostring(maxlvl).."[-]级解锁")
            end

        end

    else
        self:show_kunkeui(index)
        self:hide_maskui(index)
        self.masklist[index].white3:set_active(false)

        local nextnumber = g_dataCenter.maskitem:getmaskgroup(index)

        self.masklist[index].kunkeitem_open:set_active(false)
        self.masklist[index].kunkeitem_close:set_active(true)
        self.masklist[index].di:set_active(false)
        self.masklist[index].star_ui:set_active(false)
        self.masklist[index].di2:set_active(true)

        if nextnumber then
            local config = g_dataCenter.maskitem:get_mask_config(nextnumber)

            if config then
                self.masklist[index].di_lab_name:set_text(config.name)
                self.masklist[index].di2_lab_name:set_text(config.name)
                local needlvl = g_dataCenter.maskitem:get_max_unlock_lvl(index)
                local maxlvl = g_dataCenter.maskitem:get_show_lvl(nextnumber,needlvl)
                --self.masklist[index].di_lab_level:set_text(tostring(self.maskinfo[index].level).."/"..tostring(maxlvl))
                self.masklist[index].di2_lab_describe:set_text("前藏品[FF0000FF]"..tostring(maxlvl).."[-]级解锁")
            end

        end
    end
end

function MaskMain:set_maskui_data(index)
    local unlocklist = g_dataCenter.maskitem:getunlocklist()
    local unlocknum = #unlocklist

    self:show_maskui(index)

    if unlocklist[index] then
        self.masklist[index].white1:set_active(false)
        self.masklist[index].white2:set_active(false)
        self.masklist[index].di:set_active(true)
        self.masklist[index].di2:set_active(false)
        self.masklist[index].infobtn:set_active(true)
        self.masklist[index].star_ui:set_active(true)
        
        if self.maskinfo[index] then 
            local config = g_dataCenter.maskitem:get_mask_config(self.maskinfo[index].number)
            if config then
                self.masklist[index].mask_sprite:set_texture(config.make_pic_type)
                self.masklist[index].di_lab_name :set_text(config.name)
                self.masklist[index].di2_lab_name:set_text(config.name)
                local maskid = self.maskinfo[index].number
                local show_lvl = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo[index].number,self.maskinfo[index].level)
                local lvl = self.maskinfo[index].level
                local maxlvl = g_dataCenter.maskitem:get_Max_lvl(maskid)
                --app.log("maxlvl=============="..tostring(maxlvl))
                if maxlvl == 0 then
                    maxlvl = self.maskinfo[index].level
                end
                self.masklist[index].di_lab_level:set_text(tostring(show_lvl[1]).."/"..tostring(maxlvl))

                local rarity = config.rarity

                for i=1,rarity do
                    self.masklist[index].star[i]:set_sprite_name("mjd_yanjing1")
                end

                --品质
                local real_rarity = g_dataCenter.maskitem:get_real_rarity(maskid)
                app.log("real_rarity......"..tostring(real_rarity))
                local real_rarity_ui = g_dataCenter.maskitem:get_ui_real_rarity(real_rarity)

                app.log("real_rarity_ui..."..table.tostring(real_rarity_ui))
                self.masklist[index].pingzi:set_sprite_name(real_rarity_ui[1])
                if real_rarity_ui[2] == "0" then
                    self.masklist[index].lvl:set_sprite_name("")
                else
                    self.masklist[index].lvl:set_sprite_name(real_rarity_ui[2])
                end
            end
        end
    end
    --     if index == unlocknum + 1 then
    --         self.masklist[index].white2:set_active(false)
    --         self.masklist[index].white1:set_active(true)
    --         self.masklist[index].di:set_active(false)
    --         self.masklist[index].di2:set_active(false)
    --         self.masklist[index].star_ui:set_active(false)

    --         local nextnumber = g_dataCenter.maskitem:getmaskgroup(index)

    --         app.log("index..........."..tostring(index))
    --         app.log("nextnumber..........."..tostring(nextnumber))

    --         if nextnumber then
    --             local config = g_dataCenter.maskitem:get_mask_config(nextnumber)

    --             if config then
    --                 self.masklist[index].mask_sprite:set_texture(config.make_pic_type)
    --                 self.masklist[index].di_lab_name:set_text(config.name)
    --                 self.masklist[index].di2_lab_name:set_text(config.name)
    --                 local maxlvl = g_dataCenter.maskitem:get_max_unlock_lvl(index)
    --                 --self.masklist[index].di_lab_level:set_text(tostring(self.maskinfo[index].level).."/"..tostring(maxlvl))
    --                 self.masklist[index].di2_lab_describe:set_text("[FF0000FF]"..tostring(maxlvl).."[-]级解锁")
    --             end

    --         end
    --     else
    --         local item_type = g_dataCenter.maskitem:get_item_type(index)
    --         self:hide_maskui(index)
    --         self.masklist[index].star_ui:set_active(false)
    --         self.masklist[index].di:set_active(false)
    --         self.masklist[index].di2:set_active(false)
    --         if item_type == 1 then
    --             self.masklist[index].white2:set_active(true)
    --         else
    --             self.masklist[index].white3:set_active(true)
    --         end
    --     end

    -- end

end

function MaskMain:set_kunkeui_data(index)
    local unlocklist = g_dataCenter.maskitem:getunlocklist()
    local unlocknum = #unlocklist

    self:show_kunkeui(index)

    if unlocklist[index] then
        self.masklist[index].white3:set_active(false)
        self.masklist[index].di:set_active(true)
        self.masklist[index].di2:set_active(false)
        self.masklist[index].infobtn:set_active(true)
        self.masklist[index].star_ui:set_active(true)

        self.masklist[index].kunkeitem_open:set_active(true)
        self.masklist[index].kunkeitem_close:set_active(false)
        
        if self.maskinfo[index] then 
            local config = g_dataCenter.maskitem:get_mask_config(self.maskinfo[index].number)
            if config then
                self.masklist[index].kunkeitem_sp:set_texture(config.make_pic_type)
                self.masklist[index].di_lab_name :set_text(config.name)
                self.masklist[index].di2_lab_name:set_text(config.name)
                local maskid = self.maskinfo[index].number
                local show_lvl = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo[index].number,self.maskinfo[index].level)
                local lvl = self.maskinfo[index].level
                local maxlvl = g_dataCenter.maskitem:get_Max_lvl(maskid)
                --app.log("maxlvl=============="..tostring(maxlvl))
                if maxlvl == 0 then
                    maxlvl = self.maskinfo[index].level
                end
                self.masklist[index].di_lab_level:set_text(tostring(show_lvl[1]).."/"..tostring(maxlvl))

                local rarity = config.rarity

                for i=1,rarity do
                    self.masklist[index].star[i]:set_sprite_name("mjd_yanjing1")
                end

                --品质
                local real_rarity = g_dataCenter.maskitem:get_real_rarity(maskid)
                app.log("real_rarity......"..tostring(real_rarity))
                local real_rarity_ui = g_dataCenter.maskitem:get_ui_real_rarity(real_rarity)

                app.log("real_rarity_ui..."..table.tostring(real_rarity_ui))
                self.masklist[index].kunkeitem_pingzi:set_sprite_name(real_rarity_ui[1])
                if real_rarity_ui[2] == "0" then
                    self.masklist[index].kunkeitem_lvl:set_sprite_name("")
                else
                    self.masklist[index].kunkeitem_lvl:set_sprite_name(real_rarity_ui[2])
                end
            end
        end
    end
    --     if index == unlocknum + 1 then
    --         self.masklist[index].white3:set_active(false)

    --         local nextnumber = g_dataCenter.maskitem:getmaskgroup(index)

    --         self.masklist[index].kunkeitem_open:set_active(false)
    --         self.masklist[index].kunkeitem_close:set_active(true)
    --         self.masklist[index].di:set_active(false)
    --         self.masklist[index].star_ui:set_active(false)
    --         self.masklist[index].di2:set_active(true)

    --         if nextnumber then
    --             local config = g_dataCenter.maskitem:get_mask_config(nextnumber)

    --             if config then
    --                 self.masklist[index].di_lab_name:set_text(config.name)
    --                 self.masklist[index].di2_lab_name:set_text(config.name)
    --                 local maxlvl = g_dataCenter.maskitem:get_max_unlock_lvl(index)
    --                 --self.masklist[index].di_lab_level:set_text(tostring(self.maskinfo[index].level).."/"..tostring(maxlvl))
    --                 self.masklist[index].di2_lab_describe:set_text("[FF0000FF]"..tostring(maxlvl).."[-]级解锁")
    --             end

    --         end
    --     else
    --         local item_type = g_dataCenter.maskitem:get_item_type(index)
    --         self:hide_kunkeui(index)
    --         self.masklist[index].star_ui:set_active(false)
    --         self.masklist[index].di:set_active(false)
    --         self.masklist[index].di2:set_active(false)
    --         if item_type == 1 then
    --             self.masklist[index].white2:set_active(true)
    --         else
    --             self.masklist[index].white3:set_active(true)
    --         end
    --     end

    -- end
end

function MaskMain:hide_maskui(index)
    self.masklist[index].white1:set_active(false)
    self.masklist[index].white2:set_active(false)
    self.masklist[index].sp_mote:set_active(false)
    self.masklist[index].mask_sprite:set_active(false)
    self.masklist[index].pingzi:set_active(false)
end

function MaskMain:show_maskui(index)
    self.masklist[index].white1:set_active(true)
    self.masklist[index].white2:set_active(true)
    self.masklist[index].sp_mote:set_active(true)
    self.masklist[index].mask_sprite:set_active(true)
    self.masklist[index].pingzi:set_active(true)
end

function MaskMain:hide_kunkeui(index)
    self.masklist[index].white3:set_active(false)
    self.masklist[index].kunkeitem:set_active(false)
end

function MaskMain:show_kunkeui(index)
    self.masklist[index].white3:set_active(true)
    self.masklist[index].kunkeitem:set_active(true)
end

function MaskMain:on_chose_item(t)
    local numb = tonumber(t.float_value)
    local maskinfo = self.maskinfo[numb]
    app.log("MaskMain.....maskinfo...."..table.tostring(maskinfo))

    local unlocklist = g_dataCenter.maskitem:getunlocklist()
    local unlocknum = #unlocklist
    if numb > unlocknum then
        FloatTip.Float( "面具还未解锁!" );
    else
        uiManager:PushUi(EUI.MaskMainInfo,maskinfo);
    end
end

function MaskMain:DestroyUi()
	UiBaseClass.DestroyUi(self); 

    if self.time_id1 then
        timer.stop(self.time_id1)
        self.time_id1 = nil;
    end

    if self.time_id2 then
        timer.stop(self.time_id2)
        self.time_id2 = nil;
    end

    if self.time_id3 then
        timer.stop(self.time_id3)
        self.time_id3 = nil;
    end
end

function MaskMain:Show()
    if UiBaseClass.Show(self) then
        if self.mask_label_anmation then
            self.mask_label_anmation:animated_play("ui_905_mask")
        end
    end
end