MaskMainInfo = Class("MaskMainInfo", UiBaseClass);

local ECultivate = 
{
    RarityUp = 62007001, --强化
    LevelUp = 62007002, --打磨
    StarUp = 62007003,  -- 升星
}

local ECultivateOpentype = 
{
    PlayerLevel = 1,--战队等级 
    HeroLevel = 2,  --英雄等级 
    HeroStar = 3,   --英雄星级 
    HeroRarity = 4, --英雄品质
    HeroBreakthrough = 5, --英雄突破
}

function MaskMainInfo:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/mask/ui_901_mask.assetbundle";
    UiBaseClass.Init(self, data);
end

function MaskMainInfo:InitData(data)

	self.masklist = ConfigManager._GetConfigTable(EConfigIndex.t_mask_sort);

    UiBaseClass.InitData(self, data);

    self.currentMaskItem = nil;
    
    self.timefxlist = {}

    self.lastrarity = 0;
    --app.log("MaskMainInfo........"..table.tostring(self.maskinfo))

    self.itemlistobj = {};

    self.currentExp = 0;
    self.currentRarity = 0;
end

function MaskMainInfo:Restart(data)
	self.maskinfo = data or self.maskinfo
    
    self.currentMaskItemIndex = self.maskinfo.index;

    if not UiBaseClass.Restart(self, data) then

    end
end

function MaskMainInfo:RegistFunc()
	UiBaseClass.RegistFunc(self)
 	self.bindfunc["on_value_change_up_star"] = Utility.bind_callback(self, MaskMainInfo.on_value_change_up_star);
    self.bindfunc["on_value_change_up_rarity"] = Utility.bind_callback(self, MaskMainInfo.on_value_change_up_rarity);
    self.bindfunc["on_value_change_level_up"] = Utility.bind_callback(self, MaskMainInfo.on_value_change_level_up)

    self.bindfunc["on_cultivate_lock_click"] = Utility.bind_callback(self, MaskMainInfo.on_cultivate_lock_click);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, MaskMainInfo.on_init_item);

    self.bindfunc["on_chose_item"] = Utility.bind_callback(self, MaskMainInfo.on_chose_item);

    self.bindfunc["upmaskinfo"] = Utility.bind_callback(self, MaskMainInfo.upmaskinfo);

    self.bindfunc["open_mask"] = Utility.bind_callback(self, MaskMainInfo.open_mask);

    self.bindfunc["on_play_fx"] = Utility.bind_callback(self, self.on_play_fx)
end

--注册消息分发回调函数
function MaskMainInfo:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_mask.gc_update_mask_info, self.bindfunc["upmaskinfo"])   
end

--注销消息分发回调函数
function MaskMainInfo:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_mask.gc_update_mask_info, self.bindfunc["upmaskinfo"])
end


function MaskMainInfo:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("MaskMainInfo");

    self.objRightRoot = self.ui:get_child_by_name("animation/right_other");

    self.toggle = {};
   	self.toggle[ECultivate.RarityUp] =  {};
    self.toggle[ECultivate.RarityUp].toggle = ngui.find_toggle(self.ui, "animation/right_other/yeka/yeka1");
    self.toggle[ECultivate.RarityUp].toggle:set_on_change(self.bindfunc["on_value_change_up_rarity"]);
    self.toggle[ECultivate.RarityUp].spLock = ngui.find_sprite(self.ui, "animation/right_other/yeka/yeka1/sp_clock");
    self.toggle[ECultivate.RarityUp].btn = ngui.find_button(self.ui, "animation/right_other/yeka/yeka1");
    self.toggle[ECultivate.RarityUp].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"],"MyButton.Flag");
    self.toggle[ECultivate.RarityUp].btn:set_event_value(tostring(ECultivate.RarityUp),0);
    self.toggle[ECultivate.RarityUp].spPoint = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka1/sp_point");
    self.toggle[ECultivate.RarityUp].sp = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka1/sp1");
    self.toggle[ECultivate.RarityUp].sp:set_active(true);
    self.toggle[ECultivate.RarityUp].lab = ngui.find_label(self.ui,"animation/right_other/yeka/yeka1/lab");

    self.toggle[ECultivate.LevelUp] =  {};
    self.toggle[ECultivate.LevelUp].toggle = ngui.find_toggle(self.ui, "animation/right_other/yeka/yeka2");
    self.toggle[ECultivate.LevelUp].toggle:set_on_change(self.bindfunc["on_value_change_level_up"]);
    self.toggle[ECultivate.LevelUp].spLock = ngui.find_sprite(self.ui, "animation/right_other/yeka/yeka2/sp_clock");
    self.toggle[ECultivate.LevelUp].btn = ngui.find_button(self.ui, "animation/right_other/yeka/yeka2");
    self.toggle[ECultivate.LevelUp].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"],"MyButton.Flag");
    self.toggle[ECultivate.LevelUp].btn:set_event_value(tostring(ECultivate.LevelUp), 0);
    self.toggle[ECultivate.LevelUp].spPoint = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka2/sp_point");
    self.toggle[ECultivate.LevelUp].sp = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka2/sp1");
    self.toggle[ECultivate.LevelUp].sp:set_active(true);
    self.toggle[ECultivate.LevelUp].lab = ngui.find_label(self.ui,"animation/right_other/yeka/yeka2/lab");

    self.toggle[ECultivate.StarUp] =  {};
    self.toggle[ECultivate.StarUp].toggle = ngui.find_toggle(self.ui, "animation/right_other/yeka/yeka3");
    self.toggle[ECultivate.StarUp].toggle:set_on_change(self.bindfunc["on_value_change_up_star"]);
    self.toggle[ECultivate.StarUp].spLock = ngui.find_sprite(self.ui, "animation/right_other/yeka/yeka3/sp_clock");
    self.toggle[ECultivate.StarUp].btn = ngui.find_button(self.ui, "animation/right_other/yeka/yeka3");
    self.toggle[ECultivate.StarUp].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"],"MyButton.Flag");
    self.toggle[ECultivate.StarUp].btn:set_event_value(tostring(ECultivate.StarUp), 0);
    self.toggle[ECultivate.StarUp].spPoint = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka3/sp_point");
    self.toggle[ECultivate.StarUp].sp = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka3/sp1");
    self.toggle[ECultivate.StarUp].sp:set_active(true);
    self.toggle[ECultivate.StarUp].lab = ngui.find_label(self.ui,"animation/right_other/yeka/yeka3/lab");

 	self.scroll_view = ngui.find_scroll_view(self.ui,"animation/down_other/sco_view/panel");
    self.wrap = ngui.find_wrap_content(self.ui,"animation/down_other/sco_view/panel/wrap_cont");
    --app.log("#####################################")
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self.infoBtn = ngui.find_button(self.ui,"animation/left_other/btn_blue")
    self.infoBtn:set_active(false)
    self.infoBtn:set_on_click(self.bindfunc["open_mask"])

    --面具星级
    self.mask_star = {}
    for i=1,7 do
    	self.mask_star[i] = ngui.find_sprite(self.ui,"animation/left_other/grid/sp_prop"..i)
    	self.mask_star[i]:set_sprite_name("mjd_yanjing2")
    end

    --面具等阶（小）
    self.mask_rarity_tiao = {}
    self.mask_rarity_star = {}
    self.mask_rarity_fx = {}
    for i=1,5 do
    	self.mask_rarity_tiao[i] = ngui.find_sprite(self.ui,"animation/left_other/cont_effect/sp"..i.."/sp_di")
    	self.mask_rarity_fx[i] = self.ui:get_child_by_name("animation/left_other/cont_effect/sp"..i.."/fx_ui_901_glow"..i)
    	self.mask_rarity_star[i] = ngui.find_sprite(self.ui,"animation/left_other/cont_effect/sp"..i.."/sp_effect")
    end

    --面具图片
    self.mask_pic = ngui.find_texture(self.ui,"animation/left_other/texture_mask")
    self.mask_mote = ngui.find_sprite(self.ui,"animation/left_other/sp_mote")
    
    --面具等阶
    self.mask_rarity = ngui.find_sprite(self.ui,"animation/left_other/sp_decoration")

    --面具等级
    self.mask_lvl_ui = ngui.find_sprite(self.ui,"animation/left_other/sp_decoration/sp_level")

    --面具名称
    self.mask_name = ngui.find_label(self.ui,"animation/left_other/sp_di/lab_name")
    --面具等级
    self.mask_lvl_lab = ngui.find_label(self.ui,"animation/left_other/sp_di/lab_level")

    --昆克
    self.mask_kunke_ui = self.ui:get_child_by_name("animation/left_other/texture_open")
    self.mask_kunke_ui:set_active(false)

    self.mask_kunke_sp = ngui.find_texture(self.ui,"animation/left_other/texture_open/texture_weapon")

    self.mask_kunke_rarity = ngui.find_sprite(self.ui,"animation/left_other/texture_open/sp_decoration")
    self.mask_kunke_lvl = ngui.find_sprite(self.ui,"animation/left_other/texture_open/sp_decoration/sp_level")

    -- 红点
    self.lvl_point = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka1/sp_point")
    self.rarity_point = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka2/sp_point")
    self.star_point = ngui.find_sprite(self.ui,"animation/right_other/yeka/yeka3/sp_point")

    self:UpdateUi()

    local masknum = #self.masklist
    --app.log("MaskMainInfo..masknum"..tostring(masknum))
    self.wrap:set_min_index(-masknum+1);
    self.wrap:set_max_index(0);
    self.wrap:reset();
    self.scroll_view:reset_position(); 

end

function MaskMainInfo:UpdateUi()

    --物品类型  1面具  2昆克
    local item_type = g_dataCenter.maskitem:get_item_type(self.maskinfo.index)

	local mask_sprite = g_dataCenter.maskitem:get_mask_sprite(self.maskinfo.number)

    if item_type == 1 then
        self:hide_kunke_ui()
        self:show_mask_ui()
    else
        self:hide_mask_ui()
        self:show_kunke_ui()
    end

    if item_type == 1 then
        
        self.mask_pic:set_texture(mask_sprite)
    else
        
        self.mask_kunke_sp:set_texture(mask_sprite)
    end

	local mask_name = g_dataCenter.maskitem:get_mask_name(self.maskinfo.number)
	self.mask_name:set_text(mask_name)

 	local config = g_dataCenter.maskitem:get_mask_config(self.maskinfo.number)
	local rarity = config.rarity

	for i=1,7 do
    	self.mask_star[i]:set_sprite_name("mjd_yanjing2")
    end

    for i=1,rarity do
        self.mask_star[i]:set_sprite_name("mjd_yanjing1")
    end

    local lvl = self.maskinfo.level

    local show_lvl = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo.number,lvl)

    local maxlvl = g_dataCenter.maskitem:get_Max_lvl(self.maskinfo.number)
    self.mask_lvl_lab:set_text(tostring(show_lvl[1]).."/"..tostring(maxlvl))

    --品质
    local maskid = self.maskinfo.number
    local real_rarity = g_dataCenter.maskitem:get_real_rarity(maskid)
    --app.log("real_rarity......"..tostring(real_rarity))
    local real_rarity_ui = g_dataCenter.maskitem:get_ui_real_rarity(real_rarity)

    if item_type == 1 then
        --app.log("real_rarity_ui..."..table.tostring(real_rarity_ui))
        self.mask_rarity:set_sprite_name(real_rarity_ui[1])
        if real_rarity_ui[2] == "0" then
            self.mask_lvl_ui:set_sprite_name("")
        else
            self.mask_lvl_ui:set_sprite_name(real_rarity_ui[2])
        end
    else
        self.mask_kunke_rarity:set_sprite_name(real_rarity_ui[1])
        if real_rarity_ui[2] == "0" then
            self.mask_kunke_lvl:set_sprite_name("")
        else
            self.mask_kunke_lvl:set_sprite_name(real_rarity_ui[2])
        end
    end

    self:set_fx_level_init()

    self:set_red_point()

end

function MaskMainInfo:set_red_point()
     --红点控制
    local lvl_flag = g_dataCenter.maskitem:checkLvlPoint_mask(self.maskinfo.index)

    if lvl_flag then
        self.lvl_point:set_active(true)
    else
        self.lvl_point:set_active(false)
    end

    local rarity_flag = g_dataCenter.maskitem:checkRarityPoint_mask(self.maskinfo)

    if rarity_flag then
        self.rarity_point:set_active(true)
    else
        self.rarity_point:set_active(false)
    end

    local star_flag = g_dataCenter.maskitem:CheckStarPoint_mask(self.maskinfo.number)

    if star_flag then
        self.star_point:set_active(true)
    else
        self.star_point:set_active(false)
    end
end

function MaskMainInfo:hide_mask_ui()
    self.mask_pic:set_active(false)
    self.mask_mote:set_active(false)
    self.mask_rarity:set_active(false)
end

function MaskMainInfo:show_mask_ui()
    self.mask_pic:set_active(true)
    self.mask_mote:set_active(true)
    self.mask_rarity:set_active(true)
end

function MaskMainInfo:hide_kunke_ui()
    self.mask_kunke_ui:set_active(false)
end

function MaskMainInfo:show_kunke_ui()
    self.mask_kunke_ui:set_active(true)
end

function MaskMainInfo:on_value_change_up_rarity(value)
	--app.log("on_value_change_up_rarity.."..tostring(value))
    if value then
        self.curToggle = ECultivate.RarityUp;
        if self.upRarity then
            self.upRarity:Show()
            self.upRarity:SetInfo(self.maskinfo)
        else
            local data = 
            {
                parent = self.objRightRoot,
                info = self.maskinfo,
                -- isPlayer = self.isPlayer,
            }
            self.upRarity = MaskRarityUp:new(data);
        end
        --self:on_value_change_attr();        
    else
        if self.upRarity then
            self.upRarity:Hide();
        end
    end
end

function MaskMainInfo:on_value_change_up_star(value)
	--app.log("on_value_change_up_star.."..tostring(value))
	if value then
        self.curToggle = ECultivate.StarUp;
        if self.upStar then
            self.upStar:Show()
            self.upStar:SetInfo(self.maskinfo)
        else
            local data = 
            {
                parent = self.objRightRoot,
                info = self.maskinfo,
                -- isPlayer = self.isPlayer,
            }
            self.upStar = MaskStarUp:new(data);
        end
        --self:on_value_change_attr();        
    else
        if self.upStar then
            self.upStar:Hide();
        end
    end
end

function MaskMainInfo:on_value_change_level_up(value)
	--app.log("on_value_change_level_up.."..tostring(value))
	if value then
        self.curToggle = ECultivate.LevelUp;
        if self.upLvl then
            self.upLvl:Show()
            self.upLvl:SetInfo(self.maskinfo)
        else
            local data = 
            {
                parent = self.objRightRoot,
                info = self.maskinfo,
                -- isPlayer = self.isPlayer,
            }
            self.upLvl = MaskLvlUp:new(data);
        end
        --self:on_value_change_attr();        
    else
        if self.upLvl then
            self.upLvl:Hide();
        end
    end
end

function MaskMainInfo:on_cultivate_lock_click(t)
    -- local tipStr = nil
    -- local index = tonumber(t.string_value);
    -- if self.roleData then
    --     --app.log("...."..tostring(t.string_value)..debug.traceback())
    --     local cfg = self.HeroCultivateCfg[index];
    --     if cfg.open_type == ECultivateOpentype.PlayerLevel then
    --         local isLock = CultivateFunc[cfg.open_type](cfg.param, self.player, self.roleData);
    --         if isLock then
    --             tipStr = self.HeroCultivateCfg[index].unlock_des;
    --         end
    --     end
    -- end
    -- if tipStr then
    --     FloatTip.Float(tipStr)
    -- end
    -- if index == 7 then
    --     local itemList = {};
    --     for i = 1, 4 do
    --         local id = i;
    --         local num = i * 3;
    --         table.insert( itemList, {item_id = id, item_num = num} );
    --     end
    --     msg_cards.cg_breakthrough(Socket.socketServer, self.roleData.index, itemList, 1);
    -- end
end

function MaskMainInfo:on_init_item(obj, b, real_index)
	local index = math.abs(real_index)+1;

	local pare = obj:get_child_by_name("mask_item")

	local heisediban = ngui.find_sprite(obj,"sp_frame")
	local weihao = ngui.find_sprite(obj,"sp_mark/sp_wenhao")
	local bantoudiban = ngui.find_sprite(obj,"sp_mark")

	--local data = g_dataCenter.maskitem:getmaskgroup(index)
	local allmaskdata = g_dataCenter.maskitem:get_masklist()
	app.log("index......."..tostring(index))

	local maskid = self.maskinfo.number

 	local unlocklist = g_dataCenter.maskitem:getunlocklist()

    local unlocknum = #unlocklist

    if unlocklist[index] then
    	heisediban:set_active(false)
    	bantoudiban:set_active(false)
    	local maskinfo = allmaskdata[index]
    	if self.itemlistobj[index] then
    		self.itemlistobj[index]:SetData(maskinfo)
            self.itemlistobj[index]:Show_Rarity()
    	else
			self.itemlistobj[index] =  UiMaskItem:new({parent = pare, maskinfo = maskinfo});
            self.itemlistobj[index]:Show_Rarity()
			self.itemlistobj[index]:SetOnClicked(self.bindfunc["on_chose_item"],maskinfo,self.itemlistobj[index])
		end
	else
		heisediban:set_active(true)
		bantoudiban:set_active(true)
		weihao:set_active(true)
	end

	if index == unlocknum + 1 then
		heisediban:set_active(false)
		bantoudiban:set_active(true)
		weihao:set_active(false)

		--local data = g_dataCenter.maskitem:getmaskgroup(index)
		local maskid = g_dataCenter.maskitem:getmaskgroup(index)
	
		local configData = g_dataCenter.maskitem:get_mask_config(maskid)
		local nextmaskid = configData.default_rarity

		--app.log("nextmaskid--------------"..tostring(nextmaskid))

		local maskinfo = {
			number=nextmaskid,
		    cur_exp=0,
		    index=index,
		    level=1,
		}
		if self.itemlistobj[index] then
			self.itemlistobj[index]:SetData(maskinfo)
            self.itemlistobj[index]:Hide_Rarity()
		else
			self.itemlistobj[index] =  UiMaskItem:new({parent = pare, maskinfo = maskinfo});--,
            self.itemlistobj[index]:Hide_Rarity()
			self.itemlistobj[index]:SetOnClicked(self.bindfunc["on_chose_item"],maskinfo,self.itemlistobj[index])
		end
	end

	if 	index == self.currentMaskItemIndex then

		app.log("self.currentMaskItemIndex======="..tostring(self.currentMaskItemIndex))
		self.currentMaskItem = self.itemlistobj[index]
		self.itemlistobj[index]:set_select(true)
	end

end

function MaskMainInfo:rush_lvl(index,level,exp)
	if self.itemlistobj[index] then
		self.itemlistobj[index]:SetNumber(self.maskinfo.number,level)
	end

	local show_lvl = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo.number,level)

    local maxlvl = g_dataCenter.maskitem:get_Max_lvl(self.maskinfo.number)
    self.mask_lvl_lab:set_text(tostring(show_lvl[1]).."/"..tostring(maxlvl))

    self:set_fx_level(level,exp)
end

function MaskMainInfo:set_fx_level_init()
	local lvldata = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo.number,self.maskinfo.level)
	local rarity = lvldata[2]

	app.log("MaskMainInfo:set_fx_level_init...rarity.."..tostring(rarity))

    for i=1,5 do
        self.mask_rarity_tiao[i]:set_fill_amout(0)
        if i < 5 then
            self.mask_rarity_star[i]:set_sprite_name("mjd_yuanxing_jd12")
        end
    end

    local curExp = self.maskinfo.cur_exp

    local Allexp = lvldata[3]

    local index = rarity + 1

    if Allexp == 0 then
        for i=1,5 do
            self.mask_rarity_tiao[i]:set_fill_amout(1)
            if i< 5 then
                self.mask_rarity_star[i]:set_sprite_name("mjd_yuanxing_jd11")
            end
        end
    else
    	if rarity > 0 then
    		for i=1,rarity do
    			self.mask_rarity_tiao[i]:set_fill_amout(1)
    			
                if i< 5 then
                    self.mask_rarity_star[i]:set_sprite_name("mjd_yuanxing_jd11")
                end

                if curExp > 0 then
                    self.mask_rarity_tiao[index]:set_fill_amout(curExp/Allexp)
                end
    		end
    	else
    		if curExp > 0 then
                self.mask_rarity_tiao[index]:set_fill_amout(curExp/Allexp)
            end
    	end
    end
end


function MaskMainInfo:set_fx_level(level,exp)
	local lvldata = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo.number,level)
	local rarity = lvldata[2]

    local curExp = exp

    local Allexp = lvldata[3]

    app.log("MaskMainInfo.........set_fx_level...."..tostring(rarity))
    app.log("MaskMainInfo.........curExp...."..tostring(curExp)..".........Allexp...."..tostring(Allexp))

    local index = rarity + 1

    if Allexp == 0 then
        for i=1,5 do
            self.mask_rarity_tiao[i]:set_fill_amout(1)
            if i< 5 then
                self.mask_rarity_star[i]:set_sprite_name("mjd_yuanxing_jd11")
            end
        end
    else
        if rarity > 0 then
            for i=1,rarity do
                self.mask_rarity_tiao[i]:set_fill_amout(1)
                
                if i< 5 then
                    self.mask_rarity_star[i]:set_sprite_name("mjd_yuanxing_jd11")
                end

                if curExp > 0 then
                    self.mask_rarity_tiao[index]:set_fill_amout(curExp/Allexp)
                end

            end

            -- if curExp > Allexp or curExp == 0 then
            --     self:on_play_fx(index)
            -- end
        else
            for i=1,5 do
                self.mask_rarity_tiao[i]:set_fill_amout(0)
                if i < 5 then
                    self.mask_rarity_star[i]:set_sprite_name("mjd_yuanxing_jd12")
                end
            end

            if curExp > 0 then
                self.mask_rarity_tiao[index]:set_fill_amout(curExp/Allexp)
                -- if self.currentExp > curExp or curExp == 0 then
                --     self:on_play_fx(5)
                -- end
            end
        end

        -- if curExp > Allexp or curExp == 0 then
        --     self:on_play_fx(index)
        -- end
    end

    if self.currentExp > curExp or curExp == 0 then
        if rarity > 0 then
            self:on_play_fx(rarity)
        else
            self:on_play_fx(5)
        end
    end

    self.currentExp = curExp

    -- if rarity == 0 then

    --     self.mask_rarity_tiao[5]:set_sprite_name("mjd_yuanxing_jd10")

    --     for i=1,5 do

    --         if i< 5 then
    --             self.mask_rarity_star[i]:set_sprite_name("mjd_yuanxing_jd12")
    --         end

    --         if i == 1 then
    --             self.mask_rarity_tiao[i]:set_sprite_name("mjd_yuanxing_jd1")
    --         elseif i == 2 then
    --             self.mask_rarity_tiao[i]:set_sprite_name("mjd_yuanxing_jd2")
    --         elseif i == 3 then
    --             self.mask_rarity_tiao[i]:set_sprite_name("mjd_yuanxing_jd3")
    --         elseif i == 4 then
    --             self.mask_rarity_tiao[i]:set_sprite_name("mjd_yuanxing_jd4")
    --         elseif i == 5 then
    --              self.mask_rarity_tiao[i]:set_sprite_name("mjd_yuanxing_jd5")
    --         end
    --     end
    -- else
    --     if rarity == 1 then
    --         self.mask_rarity_tiao[rarity]:set_sprite_name("mjd_yuanxing_jd6")
    --     elseif rarity == 2 then
    --         self.mask_rarity_tiao[rarity]:set_sprite_name("mjd_yuanxing_jd7")
    --     elseif rarity == 3 then
    --         self.mask_rarity_tiao[rarity]:set_sprite_name("mjd_yuanxing_jd8")
    --     elseif rarity == 4 then
    --         self.mask_rarity_tiao[rarity]:set_sprite_name("mjd_yuanxing_jd9")
    --         if exp > 0 then
    --             self.mask_rarity_tiao[5]:set_sprite_name("mjd_yuanxing_jd10")
    --         end
    --     end
        
    --     self.mask_rarity_star[rarity]:set_sprite_name("mjd_yuanxing_jd11")

    -- end

end

function MaskMainInfo:on_play_fx(index)
    app.log("on_play_fx.....index.."..tostring(index))
    self.mask_rarity_fx[index]:set_active(false)
	self.mask_rarity_fx[index]:set_active(true)
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUpEquip)
end

function MaskMainInfo:one_play_fx()
    local lvldata = g_dataCenter.maskitem:get_show_lvl_exp(self.maskinfo.number,self.maskinfo.level)
    local rarity = lvldata[2]
    if rarity > 0 then
        self:on_play_fx(rarity)
    else
        self:on_play_fx(5)
    end
end

function MaskMainInfo:open_mask()
	--uiManager:PushUi(EUI.MaskRarityUpWnd);
end

function MaskMainInfo:on_chose_item(t)
	--app.log("tttttttttt...."..table.tostring(t))
	local chose_item_data = t.string_value

	app.log("chose_item_data...."..table.tostring(chose_item_data))

	if chose_item_data.number == self.maskinfo.number then
		do return end
	end

	local flag = false
	local all_maskinfo = g_dataCenter.maskitem:get_masklist()
	
	for k,v in pairs(all_maskinfo) do
		if v.number == chose_item_data.number then
			flag = true
			break
		end
	end

	if flag then

		if self.currentMaskItem then
			self.currentMaskItem:set_select(false)
		end

		self.currentMaskItem = t.float_value
		self.currentMaskItem:set_select(true)
		self.currentMaskItemIndex = chose_item_data.index

		self:upmaskinfo(chose_item_data)
		self:rush_maskinfo_ui(chose_item_data)
	else
		FloatTip.Float( "面具还未解锁!" );
	end

end

function MaskMainInfo:upmaskinfo(maskinfo)
	self.maskinfo =maskinfo
	
	local masknum = #self.masklist
    --app.log("MaskMainInfo..masknum"..tostring(masknum))
    self.wrap:set_min_index(-masknum+1);
    self.wrap:set_max_index(0);
    self.wrap:reset();
    self.scroll_view:reset_position(); 

    self:UpdateUi()
end

function MaskMainInfo:rush_maskinfo_ui(chose_item_data)

	app.log("chose_item_data...."..table.tostring(chose_item_data))

	if self.curToggle == ECultivate.RarityUp then
		if self.upRarity then
			--app.log("111111111111111111111")
			self.upRarity:SetInfo(chose_item_data)
		end
	elseif self.curToggle == ECultivate.StarUp then
		if self.upStar then
			--app.log("222222222222222222222")
			self.upStar:SetInfo(chose_item_data)
		end
	elseif self.curToggle == ECultivate.LevelUp then
		if self.upLvl then
			--app.log("333333333333333333333")
			self.upLvl:SetInfo(chose_item_data)
		end
	end
end

function MaskMainInfo:DestroyUi()
	UiBaseClass.DestroyUi(self); 

	if self.upStar then
        self.upStar:DestroyUi();
        self.upStar = nil
    end

    if self.upRarity then
        self.upRarity:DestroyUi();
        self.upRarity= nil
    end

    if self.upLvl then
        self.upLvl:DestroyUi();
        self.upLvl = nil
    end

    for k,v in pairs(self.itemlistobj) do
    	v:DestroyUi()
    end

    self.itemlistobj = {}

    self.currentMaskItem = nil;
    self.currentMaskItemIndex = 1;
end