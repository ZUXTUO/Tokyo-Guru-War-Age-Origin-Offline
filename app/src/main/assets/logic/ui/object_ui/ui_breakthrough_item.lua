--fileName:ui_breakthrough_item.lua
--desc:用于专用的突破界限使用的itemicon
--code by:fengyu
--date:2016-7-21

UiBreakThroughItem = Class( "UiBreakThroughItem" );

UiBreakThroughItem.EnumType =
{
    Equip = 1,
    Prop = 2,
    Role = 3,
};

UiBreakThroughItem.PRESS_TIME = 80;

function UiBreakThroughItem:Init( data )

    self.res_group = self._className
    self.resPath = "assetbundles/prefabs/ui/public/new_small_card_item.assetbundle";
    self:InitData(data);
    self:Restart();
end

function UiBreakThroughItem:Restart()
    self:RegistFunc();
    self:InitUi();
end

function UiBreakThroughItem:InitData( data )
    data = data or {};
    self.ui = nil;
    self.bindfunc = {};
    self.addPressTimerID = 0;
   
    self.addPressFxTimerID = nil;
    self.fx = nil;
   
    self.checkAddStart = false;
    self.checkSubStart = false;
    self.subPressTimerID = 0;
    
    self.equip = data.equip or {};
    self.point = {};
    self.load_callback = data.load_callback or nil;
    
    self.cardInfo = data.cardInfo or data.info or nil;
    self.parent = data.parent
    self.addNum = data.addNum or 0;
    self.itemIndex = data.itemIndex or 0;
    
    self.addCallback = data.addCallback or nil;
    self.subCallback = data.subCallback or nil;
    
    self.equip.quality = Utility.get_value( self.equip.quality, true );
    self.equip.star = Utility.get_value( self.equip.star, true );
end

function UiBreakThroughItem:RegistFunc()
    self.bindfunc["on_loaded"] = Utility.bind_callback( self, UiBreakThroughItem.on_loaded);
    self.bindfunc["on_press"] = Utility.bind_callback( self, UiBreakThroughItem.on_press );
    self.bindfunc["on_drag_move"] = Utility.bind_callback( self, UiBreakThroughItem.on_drag_move );
    self.bindfunc["on_press_sub"] = Utility.bind_callback( self, UiBreakThroughItem.on_press_sub );
    self.bindfunc["on_drag_move_sub"] = Utility.bind_callback( self, UiBreakThroughItem.on_drag_move_sub );
    self.bindfunc["on_add_press_timer"] = Utility.bind_callback( self, UiBreakThroughItem.on_add_press_timer );
    self.bindfunc["on_sub_press_timer"] = Utility.bind_callback( self, UiBreakThroughItem.on_sub_press_timer );
    self.bindfunc["on_play_fx"] = Utility.bind_callback( self,UiBreakThroughItem.on_play_fx );
end

function UiBreakThroughItem:UnregistFunc()
    for k, v in pairs( self.bindfunc ) do
        if v ~= nil then
            Utility.unbind_callback( self, v );
        end
    end
end

function UiBreakThroughItem:Show()
    self.isShow = true;
    if not self.ui then
        return;
    end
    self.ui:set_active( true );
end

function UiBreakThroughItem:Hide()
    self.isShow = false;
    
    if not self.ui then
        return;
    end
    
    self.ui:set_active( false );
end

function UiBreakThroughItem:InitUi()
    if self.ui then
        self:InitUiElement( self.ui );
    else
        ResourceLoader.LoadAsset(self.resPath, self.bindfunc["on_loaded"], self.res_group );
    end
end

function UiBreakThroughItem:on_loaded( pid, filepath, asset_obj, error_info )
    if filepath == self.resPath then
        self.ui = asset_game_object.create(asset_obj);
        self:SetParent( self.parent );
        self:SetScale(self.scale);
        self:SetPosition( self.point.x, self.point.y, self.point.z );
        self:InitUiElement( self.ui );
    end
end

function UiBreakThroughItem:InitUiElement( obj )
    self.btn = ngui.find_button( obj, obj:get_name().."/sp_back1");
    self.btn:set_on_ngui_press(self.bindfunc["on_press"]);
    self.btn:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
    
    self.subBtn = ngui.find_sprite( obj, obj:get_name().."/sp_reduce");
    self.subBtn:set_active( true );
    self.subBtn:set_on_ngui_press(self.bindfunc["on_press_sub"]);
    self.subBtn:set_on_ngui_drag_move(self.bindfunc["on_drag_move_sub"]);
    
    self.sp_frame = ngui.find_sprite( obj, "sp_back" );
    self.sp_frame:set_sprite_name( "touxiangbeijing1k" );
    
    self.sp_back = ngui.find_sprite(obj,"sp_frame")
    
    self.sp_mark = ngui.find_sprite( obj, "sp_mark" );
    self.sp_mark:set_active( false );
    self.sp_rarity = ngui.find_sprite(obj,"prop/sp")
    self.lbl_rarity = ngui.find_label(obj,"prop/sp/lab")
    self.sp_shine = ngui.find_sprite( obj, "icon/sp_shine" );
    self.sp_shine:set_active( false );
    self.texture = ngui.find_texture( obj, "icon/texture" );
    self.sp_human = ngui.find_sprite( obj, "icon/sp_human" );
    --self.sp_human_bk = ngui.find_sprite( obj, "icon/sp_human/sp_bk" );
    
    self.go_prop = obj:get_child_by_name( "prop" );
    
    self.lbl_prop_num = ngui.find_label( self.go_prop, "lab_num" );
    self.lbl_prop_num:set_color( 0, 1, 0, 1 );
    
    self.lbl_double = ngui.find_label( self.go_prop, "lab_beishu" );
    self.lbl_double:set_active( false );
    self.sp_fight = ngui.find_sprite( self.go_prop, "sp_fight" );
    
    self.go_equip = obj:get_child_by_name( "equip" );
    self.lbl_equip_level = ngui.find_label( self.go_equip, "lab_level" );
    self.lbl_equip_level:set_active( false );
    
    self.grid_equip_euality = ngui.find_grid( obj, "contail_qh" );
    self.go_equip_quality = obj:get_child_by_name( "equip/contail_qh" );
    self.sp_qualitys = {};
    for i = 1, Const.EQUIP_MAX_QULITY_LEVEL do
        self.sp_qualitys[i] = ngui.find_sprite( self.go_equip_quality, "sp"..i );
    end
    self.sp_new_point = ngui.find_sprite( self.go_equip, "sp_tishi" );
    self.sp_new_point:set_active( false );
    self.sp_level_animation = self.go_equip:get_child_by_name( "animation" );
    self.sp_level_animation:set_active( false );
    
    self.go_star = self.go_equip:get_child_by_name( "contain_star" );
    self.grid_star = ngui.find_grid( self.go_star, "contain_star" );
    self.sp_stars = {};
    for i = 1, Const.EQUIP_MAX_STAR do
        self.sp_stars[i] = ngui.find_sprite( self.go_star, "sp_star"..i );
    end
    
    self:UpdateUi();
end

function UiBreakThroughItem:UpdateUi()
    if not self.ui then
        return;
    end
    
    if self.cardInfo then
        self:UpdatePropUi();
        self:UpdateEquipUi();
        self:UpdateNumberUi();
        if PropsEnum.IsRoleSoul( self.cardInfo.number ) then
            self.texture:set_active( false );
            self.sp_human:set_active( true );
            self.sp_human:set_sprite_name( self.cardInfo.small_icon );
            --self.sp_human_bk:set_sprite_name( PublicFunc.GetHumanRarityBgName( self.cardInfo.rarity ) );
        else
            self.texture:set_active( true );
            self.sp_human:set_active( false );
            if self.cardInfo.small_icon and self.cardInfo.small_icon ~= 0 then
                self.texture:set_texture( self.cardInfo.small_icon );
            end
        end
    else
        
    end
    
    
end

function UiBreakThroughItem:UpdatePropUi()
    local itemID = self.cardInfo.number;
    
    if PropsEnum.IsItem( itemID ) or PropsEnum.IsVaria( itemID ) or PropsEnum.IsRole( itemID ) then
        self.go_equip:set_active( false );
        self.go_prop:set_active( true );
        
        local item_cfg = ConfigManager.Get( EConfigIndex.t_item, self.cardInfo.number );
        self.sp_fight:set_active( ( item_cfg and item_cfg.category == 6 ) or false );
        if PropsEnum.IsItem(itemID) then            
            local rarity_info = {
                [1] = { sprite_name = "tx_pz_lvse", rgb= {r=138/255,g=1,b=0}},
                [2] = { sprite_name = "tx_pz_lanse", rgb= {r=0,g=246/255,b=1}},
                [3] = { sprite_name = "tx_pz_zise", rgb= {r=1,g=0,b=252/255}},
                [4] = { sprite_name = "tx_pz_chengse", rgb= {r=1,g=156/255,b=0}},
                [5] = { sprite_name = "tx_pz_hongse",rgb= {r=1,g=35/255,b=35/255} },                
            }
            if item_cfg.right_flag == nil or item_cfg.right_flag == 0 or item_cfg.rarity == 0 or item_cfg.rarity == 6 then              
                self.sp_rarity:set_active(false)
            else
                local u = rarity_info[item_cfg.rarity-1]
                self.sp_rarity:set_active(true)
                self.sp_rarity:set_sprite_name(u.sprite_name)
                self.lbl_rarity:set_text("+" .. item_cfg.right_flag)
                self.lbl_rarity:set_color(u.rgb.r,u.rgb.g,u.rgb.b,1)
            end
        else
            self.sp_rarity:set_active(false)
        end
        --app.log("rarity###############"..tostring(self.cardInfo.rarity))
        PublicFunc.SetIconFrameSprite( self.sp_frame, self.cardInfo.rarity );
        --local info = PublicFunc.GetRarityInfo( self.cardInfo.rarity + 1);
        --self.sp_back:set_sprite_name(info.boxName)
        PublicFunc.SetIconFrameSpritek( self.sp_back, self.cardInfo.rarity );
    end
end

function UiBreakThroughItem:UpdateEquipUi()
    if PropsEnum.IsEquip( self.cardInfo.number ) then
        self.go_equip:set_active( true );
        self.go_prop:set_active( false );
        
        self.go_equip_quality:set_active( self.equip.quality );
        self.go_start:set_active( self.equip.star );
        
        if self.equip.quality then
            local info = PublicFunc.GetRarityInfo( self.cardInfo.rarity + 1 );
            if info then
                self.sp_frame:set_sprite_name( info.frameName );
                for i = 1, 5 do
                    local sp_quality = self.sp_qualitys[i];
                    spquality:set_sprite_name( info.rarityName );
                    if sp_quality then
                        sp_quality:set_active( i < info.level );
                    end
                end
            end
            self.grid_equip_euality:reposition_now();
        end
        
        if self.equip.star then
            for i = 1, Const.EQUIP_MAX_STAR do
                local sp_star = self.sp_stars[i];
                if sp_star then
                    sp_star:set_active( i < self.cardInfo.star );
                end
            end
            self.grid_star:reposition_now();
        end
        
        -- if self.equip.star or self.equip.quality then
        --     util.refresh_all_panel();
        -- end
    end
end

function UiBreakThroughItem:UpdateNumberUi()
    local p_count = nil;
    if not self.cardInfo.index then
        p_count = g_dataCenter.package:GetCountByNumber(self.cardInfo.number);
    else
        p_count = g_dataCenter.package:GetItemCountByDataId(self.cardInfo.index);
    end
    local text = tostring(self.addNum).."/"..tostring(p_count);
    self:SetNumberStr( text );
    if self.addNum == 0 then
        if self.subPressTimerID > 0 then
            timer.stop( self.subPressTimerID );
            self.subPressTimerID = 0;
        end
        self.subBtn:set_active( false );
    else
        self.subBtn:set_active( true );
    end
end

function UiBreakThroughItem:SetParent( parent )
    if parent then
        if self.ui ~= nil then
            self.ui:set_parent(parent);
            self.scale = self.scale or 1;
            self.ui:set_local_scale( self.scale, self.scale, self.scale );
        else
            self.parent = parent;
        end
    end
end

function UiBreakThroughItem:SetScale( scale )
    self.scale = scale or 1;
    if self.ui then
        self.ui:set_local_scale( self.scale, self.scale, self.scale );
    end
end

function UiBreakThroughItem:SetNumberStr( str )
    if self.lbl_prop_num and type( str ) == "string" then
        self.lbl_prop_num:set_text( str );
    end
end

function UiBreakThroughItem:on_play_fx()
    app.log("playfx--------------------")
    local parent = self.ui:get_parent()
    self.fx = parent:get_child_by_name("usefx")
    --
    if self.fx then
        self.fx:set_active(false)
        self.fx:set_active(true)
    end
end

function UiBreakThroughItem:on_press( name, state, x, y, gameObject )
    if self.addPressTimerID > 0 then
        timer.stop( self.addPressTimerID );
        self.addPressTimerID = 0;
    end
    
    if self.addPressFxTimerID then
        timer.stop(self.addPressFxTimerID);
        self.addPressFxTimerID = nil;
    end
    
    if state then
        self:on_play_fx()
        self.checkAddStart = false;
        self.addPressTimerID = timer.create( self.bindfunc["on_add_press_timer"], UiBreakThroughItem.PRESS_TIME, -1 );
        self.addPressFxTimerID = timer.create( self.bindfunc["on_play_fx"], 1000, -1 );
    else
        
        --if self.fx then
        --    self.fx:set_active(false)
        --end
        
       -- app.log("###################=================")
        if not self.checkAddStart then
            if self.addCallback then
                self.addCallback( self.itemIndex, self );
            end
        end
        
        if self.addPressFxTimerID then
            timer.stop(self.addPressFxTimerID);
            self.addPressFxTimerID = nil;
        end
    end
end

function UiBreakThroughItem:on_drag_move( name, x, y )
    if self.addPressTimerID > 0 then
        timer.stop( self.addPressTimerID );
        self.addPressTimerID = 0;
    end
    
    if self.fx then
        self.fx:set_active(false)
    end
    
    if self.addPressFxTimerID then
        timer.stop(self.addPressFxTimerID);
        self.addPressFxTimerID = nil;
    end
end

function UiBreakThroughItem:on_press_sub( name, state, x, y, gameObject )
    if self.subPressTimerID > 0 then
        timer.stop( self.subPressTimerID );
        self.subPressTimerID = 0;
    end
    
    if state then
        self.checkSubStart = false;
        self.subPressTimerID = timer.create( self.bindfunc["on_sub_press_timer"], UiBreakThroughItem.PRESS_TIME, -1 );
    else
        if not self.checkSubStart then
            if self.subCallback then
                self.subCallback( self.itemIndex, self );
            end
        end
    end
end

function UiBreakThroughItem:on_drag_move_sub( name, x, y )
    if self.subPressTimerID > 0 then
        timer.stop( self.subPressTimerID );
        self.subPressTimerID = 0;
    end
end

function UiBreakThroughItem:DestroyUi()
    if self.ui then
        self.ui:set_active( false );
        self.ui = nil;
    end
    self:UnregistFunc();
    if self.texture then
        self.texture:Destroy();
        self.texture = nil;
    end
    if self.addPressTimerID  > 0 then
        timer.stop( self.addPressTimerID );
        self.addPressTimerID = 0;
    end
    if self.subPressTimerID > 0 then
        timer.stop( self.subPressTimerID );
        self.subPressTimerID = 0;
    end
    
    if self.fx then
        self.fx = nil
    end
    
    if self.addPressFxTimerID then
        timer.stop(self.addPressFxTimerID);
        self.addPressFxTimerID = nil;
    end
    
    PublicFunc.ClearUserDataRef( self, 2 );
end

function UiBreakThroughItem:SetData( data )
    if data then
        self.cardInfo = data.cardInfo or data.info or nil;
        self.addNum = data.addNum or 0;
        self.itemIndex = data.itemIndex or 0;
        
        self.addCallback = data.addCallback or nil;
        self.subCallback = data.subCallback or nil;
        self:UpdateUi();
    end
end

function UiBreakThroughItem:SetPosition( x, y, z )
    x = x or 0;
    y = y or 0;
    z = z or 0;
    if self.ui ~= nil then
        self.ui:set_local_position( x, y, z );
    else
        self.point = { x = x, y = y, z = z };
    end
end


function UiBreakThroughItem:on_add_press_timer( tiemrID )
    self.checkAddStart = true;
    if self.addCallback then
        self.addCallback( self.itemIndex, self );
    end
end

function UiBreakThroughItem:on_sub_press_timer( timerID )
    self.checkSubStart = true;
    if self.subCallback then
        self.subCallback( self.itemIndex, self );         
    end
end

function UiBreakThroughItem:SetAddNumber( num )

    self.addNum = num or 0;
    self:UpdateNumberUi();
    --self:UpdateUi();
end

function UiBreakThroughItem:AddFx( obj )
    app.log("addfx===================")
    self.fx = obj
end

function UiBreakThroughItem:CancelSubTimer()
    
end

function UiBreakThroughItem:CancelAddTimer()

end

