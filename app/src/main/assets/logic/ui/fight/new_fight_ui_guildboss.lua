--fileName:ui/fight/new_fight_ui_guildboss.lua
--desc:用于社团bossbuff加成的相关逻辑
--code by:fengyu
--date:2016-8-8

NewFightUiGuildBoss = Class( "NewFightUiGuildBoss", UiBaseClass );

function NewFightUiGuildBoss:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_guild_boss.assetbundle";
    UiBaseClass.Init( self, data );
end

function NewFightUiGuildBoss:InitData( data )
    UiBaseClass.InitData( self, data );
    self.data = data;
    self.control = {};
    self.objBuffAdd = {};
    self.uiBuyBuffer = nil;
end

function NewFightUiGuildBoss:RegistFunc()
    UiBaseClass.RegistFunc( self );
    self.bindfunc["OnBuyEncourage"] = Utility.bind_callback( self, NewFightUiGuildBoss.OnBuyEncourage );
    self.bindfunc["on_update_add_buff"] = Utility.bind_callback( self, NewFightUiGuildBoss.on_update_add_buff );
end

function NewFightUiGuildBoss:MsgRegist()
    UiBaseClass.MsgRegist( self );
    PublicFunc.msg_regist( msg_fight.gc_sync_guild_boss_buy_buff_property, self.bindfunc["on_update_add_buff"] );
end

function NewFightUiGuildBoss:MsgUnRegist()
    UiBaseClass.MsgUnRegist( self );
    PublicFunc.msg_unregist( msg_fight.gc_sync_guild_boss_buy_buff_property, self.bindfunc["on_update_add_buff"] );
end

function NewFightUiGuildBoss:DestroyUi()
    UiBaseClass.DestroyUi( self );
    if type( self.control ) == "table" then
        for k, v in pairs( self.control ) do
            self.control[k] = nil;
        end
    end
    if self.uiBuyBuffer then
        self.uiBuyBuffer:DestroyUi()
        self.uiBuyBuffer = nil;
    end
end

function NewFightUiGuildBoss:InitUI( asset_obj )
    UiBaseClass.InitUI( self, asset_obj );
    if self.data.parent then
        self.ui:set_parent( self.data.parent );
        self.data.parent = nil;
    else
        self.ui:set_parent( Root.get_root_ui_2d_fight() );
    end
    
    self.ui:set_local_scale( 1, 1, 1 );
    self.ui:set_local_position( 0, 0, 0 );
    
    self.control.objBuff = self.ui:get_child_by_name("content");
    self.control.labBuff = ngui.find_label(self.control.objBuff, "sp_di2/lab");
    self.control.btnBuff = ngui.find_button(self.control.objBuff, "sp_di");
    self.control.btnBuff:set_on_click(self.bindfunc['OnBuyEncourage']);
    for i = 1, 3 do
        self.objBuffAdd[i] = ngui.find_label(self.control.objBuff, "lab"..i );
    end
    self:UpdateEncourage();
end

function NewFightUiGuildBoss:UpdateEncourage()
    if self.control == nil then
        return;
    end
    local guildBossData = g_dataCenter.guildBoss;
    for i = 1, 3 do
        if self.objBuffAdd[i] then
            if g_dataCenter.guildBoss.curAddBuffList and g_dataCenter.guildBoss.curAddBuffList[i] then
                self.objBuffAdd[i]:set_active( true );
                local title = gs_string_property_name[g_dataCenter.guildBoss.curAddBuffList[i].property_id];
                local addValue = math.floor( g_dataCenter.guildBoss.curAddBuffList[i].value );
                self.objBuffAdd[i]:set_text( title..":+"..addValue );
            else
                self.objBuffAdd[i]:set_active( false );
            end
        end
    end
end

function NewFightUiGuildBoss:OnBuyEncourage()
    if self.uiBuyBuffer == nil then
        --self.uiBuyBuffer = UiGuildBossBuyBuff:new( { parent = self.ui:get_parent() } );
        self.uiBuyBuffer = UiGuildBossBuyBuff:new({ parent = self.ui:get_parent() });
    end
    self.uiBuyBuffer:Show();
end

function NewFightUiGuildBoss:on_update_add_buff()
    self:UpdateEncourage();
end
