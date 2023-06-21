--file:new_bosshp_heart_snyc_ui.lua
--desc:用于心跳同步显示boss血量的ui控件
--code by:fengyu
--date:2016-8-2

NewBossHPHeartSyncUI = Class( "NewBossHPHeartSyncUI", UiBaseClass );

function NewBossHPHeartSyncUI:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_bosshp.assetbundle";
    UiBaseClass.Init( self, data );
end

function NewBossHPHeartSyncUI:InitData( data )
    UiBaseClass.InitData( self, data );
    self.data = data;
    self.data.bossData = data.bossData;
    self.indexList = nil 
end

function NewBossHPHeartSyncUI:RegistFunc()
    UiBaseClass.RegistFunc( self );
end

function NewBossHPHeartSyncUI:InitUI( asset_obj )
    UiBaseClass.InitUI( self, asset_obj );
    if self.data.parent then
        self.ui:set_parent( self.data.parent );
        self.data.parent = nil;
    else
        self.ui:set_parent( Root.get_root_ui_2d_fight() );
    end
    
    self.ui:set_local_scale( 1, 1, 1 );
    self.ui:set_local_position( 0, 0, 0 );
    self.objRoot1 = self.ui:get_child_by_name("pro_di");
    self.objRoot1:set_active( false );
    
    self.objRoot2 = self.ui:get_child_by_name( "ui_frame" );
    self.pro_boss_blood = ngui.find_progress_bar( self.objRoot2, "sp_back" );
    self.sp_boss_blood = ngui.find_sprite( self.objRoot2, "sp_xuetiao" );
    self.text_boss_name = ngui.find_label( self.objRoot2, "lab_name" );
    self.text_boss_hp = ngui.find_label( self.objRoot2, "lab_num" );
    self.text_boss_hp:set_font_size( 17 );
    self.pro_boss_blood_bk = ngui.find_progress_bar( self.objRoot2, "sp_back1" );
    self.sp_boss_blood_bk = ngui.find_sprite( self.objRoot2, "sp_xuetiao1" );
    self.pro_boss_bk = ngui.find_progress_bar(self.objRoot2, "sp_back2");
    self.sp_boss_bk = ngui.find_sprite( self.objRoot2, "sp_xuetiao2" );
    self.lab_boss = ngui.find_label( self.objRoot2, "lab_freme" );
    self.lab_level = ngui.find_label( self.objRoot2, "lab_level" );
    -- self.lab_level:set_active( false );
    
    --self:UpdateBossBlood();
end

function NewBossHPHeartSyncUI:DestroyUi()
    UiBaseClass.DestroyUi( self );
end


function NewBossHPHeartSyncUI:UpdateBossBlood( bossInfo )
    if not self.ui then
        return;
    end
    
    if not self.data.bossData then
        self.objRoot2:set_active( false );
        return;
    else
        self.objRoot2:set_active( true );
    end
    
    local max_blood = self.data.bossData.max_hp or 10000;
    local cur_blood = self.data.bossData.cur_hp or 10000;
    
     --几管血
    local maxCount = self:GetMaxBloodCount(max_blood)
    local one_blood = max_blood / maxCount

    local cont, value = math.modf( ( cur_blood - 0.01 ) / one_blood );
    local cur_value = self.pro_boss_blood_bk:get_value();
    self.lab_boss:set_text( "x"..cont + 1 );

    --绿黄橙 - 绿黄橙 ... - 红
    local index, nextIndex = self:GetIndexByBloodCount(cont + 1, maxCount)
    self.sp_boss_blood:set_sprite_name( "zjm_xuetiao_xg_".. index);
    self.sp_boss_blood_bk:set_sprite_name( "zjm_xuetiao_xg_".. index)
    if nextIndex == nil then
        self.pro_boss_bk:set_value(0)
    else
        self.pro_boss_bk:set_value(1)
        self.sp_boss_bk:set_sprite_name("zjm_xuetiao_xg_" .. nextIndex)
    end

    self.text_boss_hp:set_text( ""..cur_blood.."/"..max_blood );
    -- if value > 0 and value <= 1 then
        self.pro_boss_blood:set_value( value );
        self.pro_boss_blood_bk:set_value(value);
    -- else
    --     self.pro_boss_blood:set_value( cur_value - 0.005 );
    --     self.pro_boss_blood_bk:set_value(cur_value - 0.005);
    -- end
    
    if type(self.data.bossData.name) == "string" then
        self.text_boss_name:set_text( self.data.bossData.name );
    end
    local cur_lvl = self.data.bossData.level;
    if cur_lvl then
        self.lab_level:set_text( "等级："..cur_lvl );
    else
        self.lab_level:set_text("");
    end
    
end

function NewBossHPHeartSyncUI:SetBossData( bossData )
    --self.data.bossData = bossData;
    --self:UpdateBossBlood();
end

function NewBossHPHeartSyncUI:UpdateBossInfo( bossInfo )
    if bossInfo == nil then
        self.data.bossData = nil;
    else
        self.data.bossData = self.data.bossData or {};
        self.data.bossData.cur_hp = bossInfo[1].cur_hp or self.data.bossData.cur_hp;
        self.data.bossData.max_hp = bossInfo[1].max_hp or self.data.bossData.max_hp;
        self.data.bossData.level = bossInfo[1].level or self.data.bossData.level;
        self.data.bossData.name = bossInfo[1].name or self.data.bossData.name;
    end
    self:UpdateBossBlood( bossInfo );
end

function NewBossHPHeartSyncUI:Update(dt)
    -- local max_blood = self.data.bossData.max_hp or 10000;
    -- local cur_blood = self.data.bossData.cur_hp or 10000;
    -- local one_blood = max_blood / 4;
    -- local cont, value = math.modf( ( cur_blood - 0.01 ) / one_blood );
    -- local cur_value = self.pro_boss_blood_bk:get_value();
    -- if value > cur_value then
    --     self.pro_boss_blood_bk:set_value(value);
    -- else
    --     self.pro_boss_blood_bk:set_value(cur_value - 0.01);
    -- end
end

--[[由最大血量来确定几管血]]
function NewBossHPHeartSyncUI:GetMaxBloodCount(maxHp)
    local config = ConfigManager._GetConfigTable(EConfigIndex.t_boss_hp_show)
    for _, v in ipairs(config) do
        if maxHp >= v.hp_start and maxHp <= v.hp_end then
            return v.hp_show_count 
        elseif maxHp >= v.hp_start and v.hp_end == 0 then
            return v.hp_show_count 
        end
    end
    app.log('t_boss_hp_show  ===> config error!')
end

--[[血条颜色循环]]
function NewBossHPHeartSyncUI:GetIndexByBloodCount(cont, maxCount)
    if cont > 1 then
        if self.indexList == nil then
            --绿黄橙
            self.indexList = {}
            for i = 1, 20 do 
                table.insert(self.indexList, 5)
                table.insert(self.indexList, 4)
                table.insert(self.indexList, 3)
            end
        end
        local index = self.indexList[maxCount - cont + 1]   -- (1 --> maxCount)
        if index == nil then
            app.log("index is nil. cont:"..tostring(cont).. " maxCount:"..tostring(maxCount).. debug.traceback());
            return 2,nil;
        end
        local nextIndex = nil
        if index == 3 then
            nextIndex = 5
        else
            nextIndex = index - 1 
        end
        return index, nextIndex
    --红
    elseif cont == 1 then
        return 2, nil
    end    
end
