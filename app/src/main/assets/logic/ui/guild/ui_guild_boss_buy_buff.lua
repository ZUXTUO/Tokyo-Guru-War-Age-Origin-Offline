--fileName:ui/guild/ui_guild_boss_buy_buff.lua
--desc:购买社团boss战buff的购买界面
--code by:fengyu
--date:2016-8-8

UiGuildBossBuyBuff = Class( "UiGuildBossBuyBuff", UiBaseClass );

local countGuildScienceGuildBossID = 2;

function UiGuildBossBuyBuff:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2823_guild_war_buff.assetbundle";
    UiBaseClass.Init( self, data );
end

function UiGuildBossBuyBuff:InitData( data )
    self.parent = data.parent;
    self.data = data;
    self.control = {};
    self.labBuffAddInfo = {};
    UiBaseClass.InitData( self, data );
end

function UiGuildBossBuyBuff:RegistFunc()
    UiBaseClass.RegistFunc( self );
    self.bindfunc["on_close"] = Utility.bind_callback( self, UiGuildBossBuyBuff.on_close );
    self.bindfunc["on_gold_buy_buff"] = Utility.bind_callback( self, UiGuildBossBuyBuff.on_gold_buy_buff );
    self.bindfunc["on_crystal_buy_buff"] = Utility.bind_callback( self, UiGuildBossBuyBuff.on_crystal_buy_buff );
    self.bindfunc["update_buy_buff_times"] = Utility.bind_callback( self, UiGuildBossBuyBuff.update_buy_buff_times );
    self.bindfunc["on_update_add_buff"] = Utility.bind_callback( self, UiGuildBossBuyBuff.on_update_add_buff );
    self.bindfunc["gc_sync_guild_tech_level_info"] = Utility.bind_callback(self, self.gc_sync_guild_tech_level_info);
end

function UiGuildBossBuyBuff:MsgRegist()
    UiBaseClass.MsgRegist( self );
    PublicFunc.msg_regist( msg_guild_boss.gc_sync_guild_boss_buy_buff_times, self.bindfunc["update_buy_buff_times"] );
    PublicFunc.msg_regist( msg_fight.gc_sync_guild_boss_buy_buff_property, self.bindfunc["on_update_add_buff"] );
    PublicFunc.msg_regist(msg_guild.gc_sync_guild_tech_level_info,self.bindfunc["gc_sync_guild_tech_level_info"]);
end

function UiGuildBossBuyBuff:MsgUnRegist()
    UiBaseClass.MsgUnRegist( self );
    PublicFunc.msg_unregist( msg_guild_boss.gc_sync_guild_boss_buy_buff_times, self.bindfunc["update_buy_buff_times"] );
    PublicFunc.msg_unregist( msg_fight.gc_sync_guild_boss_buy_buff_property, self.bindfunc["on_update_add_buff"] );
    PublicFunc.msg_unregist(msg_guild.gc_sync_guild_tech_level_info,self.bindfunc["gc_sync_guild_tech_level_info"]);
end

function UiGuildBossBuyBuff:InitUI( obj )
    UiBaseClass.InitUI( self, obj );
    self.ui:set_name( "ui_guild_boss_buy_buff" );
    
    self.control.btnClose = ngui.find_button( self.ui, "centre_other/animation/content_di_1004_564/btn_cha" );
    self.control.btnClose:set_on_click( self.bindfunc["on_close"] );
    
    self.control.btnGoldBuyBuff = ngui.find_button( self.ui, "centre_other/animation/cont3/cont1/btn1" );
    self.control.btnGoldBuyBuff:set_on_click( self.bindfunc["on_gold_buy_buff"] );

    local labBtn = ngui.find_label(self.ui, "centre_other/animation/cont3/cont2/btn1/animation/lab");
    labBtn:set_text("鼓舞")
    labBtn = ngui.find_label(self.ui, "centre_other/animation/cont3/cont1/btn1/animation/lab");
    labBtn:set_text("鼓舞")

    self.control.btnCrystalBuyBuff = ngui.find_button( self.ui, "centre_other/animation/cont3/cont2/btn1" );
    self.control.btnCrystalBuyBuff:set_on_click( self.bindfunc["on_crystal_buy_buff"] );

    self.control.labGoldNum = ngui.find_label( self.ui, "centre_other/animation/cont3/cont1/sp_bg1/lbl_v" );
    self.control.labCrystalNum = ngui.find_label( self.ui, "centre_other/animation/cont3/cont2/sp_bg1/lbl_v" );
    self.control.labGoldBuyNum = ngui.find_label( self.ui, "centre_other/animation/cont3/cont1/lab" );
    self.control.labCrystalBuyNum = ngui.find_label( self.ui, "centre_other/animation/cont3/cont2/lab" );
    
    --self.control.labBuffAddInfo1 = ngui.find_label( self.ui, "centre_other/animation/texture/sp1/lab_word" );
    --self.control.labBuffAddInfo2 = ngui.find_label( self.ui, "centre_other/animation/texture/sp2/lab_word" );
    --self.control.labBuffAddInfo3 = ngui.find_label( self.ui, "centre_other/animation/texture/sp3/lab_word" );
    for i = 1, 3 do
        local info = {}
        info.lab_buff = ngui.find_label( self.ui, "centre_other/animation/cont2/cont"..i.."/sp_bg/lbl_v" )
        info.lab_propery_num = ngui.find_label( self.ui, "centre_other/animation/cont2/cont"..i.."/sp_bg/lbl_num" )
        info.sp_buff = ngui.find_sprite( self.ui, "centre_other/animation/cont2/cont"..i.."/sp_buff_ico" );
        table.insert( self.labBuffAddInfo,  info);
    end
    
    local bossCfg = ConfigManager.Get( EConfigIndex.t_guild_boss_system, 1);
    self.control.labGoldNum:set_text( "x"..bossCfg.buff_gold_cost );
    self.control.labCrystalNum:set_text( "x"..bossCfg.buff_crystal_cost );
    
    self:UpdateUi();
    
end

function UiGuildBossBuyBuff:UpdateUi()
    if not self.ui then
        return;
    end
    local scienceCfg = g_dataCenter.guild:GetDetail():GetScienceInfo(countGuildScienceGuildBossID,3);
    --购买次数显示
    local maxCount = ConfigManager.Get( EConfigIndex.t_guild_boss_buy_count, scienceCfg.lv or 1).param1 or 1;
    self.control.labGoldBuyNum:set_text(tostring( g_dataCenter.guildBoss.curGoldBuffBuyTimes ).."/"..tostring(maxCount) );
    self.control.labCrystalBuyNum:set_text(tostring( g_dataCenter.guildBoss.curCrystalBuffBuyTimes ).."/"..tostring(maxCount) );
    --金币和钻石显示是否变红
    
    local scienceCfg = g_dataCenter.guild:GetDetail():GetScienceInfo(countGuildScienceGuildBossID,4);
    --显示buff的加成数据
    local buffAddCfg = ConfigManager.Get( EConfigIndex.t_guild_boss_buff_add, scienceCfg.lv or 1);
    for i = 1, 3 do
        local found = false
        if g_dataCenter.guildBoss.curAddBuffList then
            for j=1, #g_dataCenter.guildBoss.curAddBuffList do
                if g_dataCenter.guildBoss.curAddBuffList[j].property_id == buffAddCfg.property[i] then
                    self.labBuffAddInfo[i].lab_buff:set_active( true );
                    local title = gs_string_property_name[g_dataCenter.guildBoss.curAddBuffList[j].property_id];
                    local addValue = math.floor( g_dataCenter.guildBoss.curAddBuffList[j].value );
                    self.labBuffAddInfo[i].lab_buff:set_text(title);
                    self.labBuffAddInfo[i].lab_propery_num:set_text("+"..addValue);
                    local sprite_name = self:GetBuffSpriteName(g_dataCenter.guildBoss.curAddBuffList[j].property_id)
                    if sprite_name then
                        self.labBuffAddInfo[i].sp_buff:set_sprite_name(sprite_name)
                    end
                    found = true
                    break
                end
            end
        end
        if not found then
            --self.labBuffAddInfo[i]:set_active( false );
            local title = gs_string_property_name[buffAddCfg.property[i]];
            self.labBuffAddInfo[i].lab_buff:set_text(title);
            self.labBuffAddInfo[i].lab_propery_num:set_text("+0");
            local sprite_name = self:GetBuffSpriteName(buffAddCfg.property[i])
            if sprite_name then
                self.labBuffAddInfo[i].sp_buff:set_sprite_name(sprite_name)
            end
        end
    end
end

function UiGuildBossBuyBuff:GetBuffSpriteName(id)
    if id == ENUM.EHeroAttribute.atk_power then
        return "yzsl_gongjitu"
    elseif id == ENUM.EHeroAttribute.def_power then
        return "yzsl_fangyutu"
    elseif id == ENUM.EHeroAttribute.crit_rate then
        return "yzsl_baoji"
    elseif id == ENUM.EHeroAttribute.parry_rate then
        return "yzsl_gedangtu"
    end
    app.log("社团BOSS出现未知鼓舞BUFF id="..id)
end

function UiGuildBossBuyBuff:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function UiGuildBossBuyBuff:Show()
    UiBaseClass.Show(self);
    msg_guild.cg_sync_guild_tech_level_info(countGuildScienceGuildBossID);
end

function UiGuildBossBuyBuff:on_close()
    self:Hide();
end

function UiGuildBossBuyBuff:on_gold_buy_buff()
    local scienceCfg = g_dataCenter.guild:GetDetail():GetScienceInfo(countGuildScienceGuildBossID,3);
    local maxCount = ConfigManager.Get( EConfigIndex.t_guild_boss_buy_count, scienceCfg.lv or 1).param1 or 1;
    if g_dataCenter.guildBoss.curGoldBuffBuyTimes < maxCount then
        local bossCfg = ConfigManager.Get( EConfigIndex.t_guild_boss_system, 1);
        if bossCfg.buff_gold_cost > g_dataCenter.player.gold then
            FloatTip.Float( "你的金币已不足" );
        else
            msg_guild_boss.cg_buy_guild_boss_buff(0);
        end
    else
        FloatTip.Float( "金币购买次数已用完" );
    end
end

function UiGuildBossBuyBuff:on_crystal_buy_buff()
    local scienceCfg = g_dataCenter.guild:GetDetail():GetScienceInfo(countGuildScienceGuildBossID,3);
    local maxCount = ConfigManager.Get( EConfigIndex.t_guild_boss_buy_count, scienceCfg.lv or 1).param1 or 1;
    if g_dataCenter.guildBoss.curCrystalBuffBuyTimes < maxCount then
        local bossCfg = ConfigManager.Get( EConfigIndex.t_guild_boss_system, 1);
        if bossCfg.buff_crystal_cost > g_dataCenter.player.crystal then
            FloatTip.Float( "你的钻石已不足" );
        else
            msg_guild_boss.cg_buy_guild_boss_buff(1);
        end
    else
        FloatTip.Float( "钻石购买次数已用完" );
    end    
end


function UiGuildBossBuyBuff:update_buy_buff_times( goldTimes, crystalTimes )
    if self.ui and self.ui:get_active() then
        self:UpdateUi();
    end
end

function UiGuildBossBuyBuff:on_update_add_buff( bufferList )
    if self.ui and self.ui:get_active() then
        self:UpdateUi();
    end
end

function UiGuildBossBuyBuff:gc_sync_guild_tech_level_info()
    if self.ui and self.ui:get_active() then
        self:UpdateUi();
    end
end
