--fileName:logic/ui/guild/ui_guild_boss_rank.lua
--desc:社团boss伤害排行查看UI,社团所有玩家的排行
--code by:fengyu
--date:2016-8-4

UiGuildBossRank = Class( "UiGuildBossRank", UiBaseClass );

function UiGuildBossRank:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2821_guild_award.assetbundle";
    UiBaseClass.Init( self, data );
end

function UiGuildBossRank:Restart( data )
    UiBaseClass.Restart( self, data );
end

function UiGuildBossRank:InitData( data )
    UiBaseClass.InitData( self, data );
    self.itemIconList = {};
    self.control = {};
    self.bindfunc = {};
end

function UiGuildBossRank:Show()
    UiBaseClass.Show( self );
end

function UiGuildBossRank:Hide()
    UiBaseClass.Hide( self );
end

function UiGuildBossRank:DestroyUi()
    UiBaseClass.DestroyUi( self );
    self:DestroyItemIcon();
end

function UiGuildBossRank:RegistFunc()
    UiBaseClass.RegistFunc( self );
    self.bindfunc["on_close"] = Utility.bind_callback( self, UiGuildBossRank.on_close );
    self.bindfunc["init_item"] = Utility.bind_callback( self, UiGuildBossRank.init_item );
end

function UiGuildBossRank:InitUI( asset_obj )
    UiBaseClass.InitUI( self, asset_obj );
    self.ui:set_parent( Root.get_root_ui_2d() );
    self.ui:set_name( "ui_guild_boss_rank" );
    self.ui:set_local_scale( Utility.SetUIAdaptation() );
    self.ui:set_local_position( 0, 0, 0 );

    self.control.btnClose = ngui.find_button( self.ui, "centre_other/animation/content_di_1004_564/btn_cha" );
    self.control.btnClose:set_on_click( self.bindfunc["on_close"] );
    self.control.sprFinishType = ngui.find_sprite(self.ui, "centre_other/animation/scroll_view/cont1/sp_t");
    self.control.scrollViewRank = ngui.find_scroll_view( self.ui, "centre_other/animation/scroll_view" );
    self.control.wrapperRank = ngui.find_wrap_content( self.ui, "centre_other/animation/scroll_view/wrap_content" );
    self.control.wrapperRank:set_on_initialize_item( self.bindfunc["init_item"] );
    self.control.objMyReward = {}
    for i = 1, 3 do
        self.control.objMyReward[i] = self.ui:get_child_by_name( "centre_other/animation/scroll_view/cont1/cont_prop/new_small_card_item"..i);
    end
            

    --local labDesc = ngui.find_label( self.ui, "centre_other/animation/scroll_view/lab_t" );
    --labDesc:set_text( "伤害前20可获得排行奖励" );
    --labDesc:set_color( 1, 0, 0, 1 );
    
    self:UpdateUi();
    
end

function UiGuildBossRank:UpdateUi()
    UiBaseClass.UpdateUi( self );
    
    self.control.wrapperRank:set_min_index( -#g_dataCenter.guildBoss.lastBossRankInfo + 1 );
    self.control.wrapperRank:set_max_index( 0 );
    self.control.wrapperRank:reset();
    self.control.scrollViewRank:reset_position();
    local killReward = nil
    local joinReward = nil
    local play_reward_cfg = ConfigManager._GetConfigTable(EConfigIndex.t_guild_boss_play_reward)
    if play_reward_cfg then
        for k, v in pairs(play_reward_cfg) do
            if (v.min_level == 0 or v.min_level <= g_dataCenter.guildBoss.last_boss_level) and
                (v.max_level == 0 or v.max_level >= g_dataCenter.guildBoss.last_boss_level) then
                killReward = v.kill_reward
                joinReward = v.join_reward
                break
            end
        end
    end
    if g_dataCenter.guildBoss.last_killer_gid ~= "0" then
        self.control.sprFinishType:set_sprite_name("sjboss_jisha")
        if killReward then
            local killRewardRatio = 1.0;
            local kill_reward_ratio = ConfigManager._GetConfigTable(EConfigIndex.t_guild_boss_kill_reward_ratio)
            if kill_reward_ratio then
                for k, v in pairs(kill_reward_ratio) do
                    if g_dataCenter.guildBoss.last_boss_contribute >= v.contribute then
                        killRewardRatio = v.ratio
                    end
                end

                for i = 1, 3 do
                    if killReward[i] then
                        local itemID = killReward[i].id;
                        local itemNum = math.ceil(killReward[i].num*killRewardRatio);
                        local card_prop = CardProp:new( { number = itemID, count = itemNum } );
                        local smallItemIcon = UiSmallItem:new( {obj = nil, parent = self.control.objMyReward[i], cardInfo = card_prop, delay = 200, load_callback = function(cls)
                        cls:SetCount(cls.cardInfo.count) end} );
                        table.insert( self.itemIconList, smallItemIcon );
                    else
                        self.control.objMyReward[i]:set_active( false );
                    end
                end
            end
        end
    else
        self.control.sprFinishType:set_sprite_name("sjboss_canyu")

        if joinReward then
            for i = 1, 3 do
                if joinReward[i] then
                    local itemID = joinReward[i].id;
                    local itemNum = joinReward[i].num;
                    local card_prop = CardProp:new( { number = itemID, count = itemNum } );
                    local smallItemIcon = UiSmallItem:new( {obj = nil, parent = self.control.objMyReward[i], cardInfo = card_prop, delay = 200, load_callback = function(cls)
                    cls:SetCount(cls.cardInfo.count) end} );
                    table.insert( self.itemIconList, smallItemIcon );
                else
                    self.control.objMyReward[i]:set_active( false );
                end
            end
        end
    end
    
end

function UiGuildBossRank:DestroyItemIcon()
    for k, item in pairs( self.itemIconList ) do
        item:DestroyUi();
    end
    self.itemIconList = {};
end

function UiGuildBossRank:on_close()
    uiManager:PopUi();
end

function UiGuildBossRank:init_item( obj, b, realID )
    local dataIndex = math.abs( realID ) + 1;
    local data = g_dataCenter.guildBoss.lastBossRankInfo[dataIndex];
    local labAfterThird = ngui.find_label( obj, "lab_level" );
    local spRankBG = ngui.find_sprite( obj, "sp" );
    local labDamageNum = ngui.find_label( obj, "cont2/label" );
    local btnName = ngui.find_label( obj, "cont2/lab_name" );
    local labName = ngui.find_sprite( obj, "cont1/sp_self" );
	local rankIcon = ngui.find_sprite( obj, "cont1/sp_rank_icon" );
	local rankNumLab = ngui.find_label( obj, "cont1/lbl_rank" );
    local sprVip = ngui.find_label( obj, "cont2/sp_vip" );

	if dataIndex == 1 then 
		rankNumLab:set_active(false);
		rankIcon:set_active(true);
		rankIcon:set_sprite_name("phb_paiming1")
	elseif dataIndex == 2 then 
		rankNumLab:set_active(false);
		rankIcon:set_active(true);
		rankIcon:set_sprite_name("phb_paiming2")
	elseif dataIndex == 3 then 
		rankNumLab:set_active(false);
		rankIcon:set_active(true);
		rankIcon:set_sprite_name("phb_paiming3")
	else
		rankIcon:set_active(false);
		rankNumLab:set_active(true);
		rankNumLab:set_text(tostring(dataIndex));
	end

    if data then
        PublicFunc.SetImageVipLevel(sprVip, data.vip_level)
		btnName:set_text(data.name);
        if data.playerid == g_dataCenter.player.playerid then
			labName:set_active(true);
        else
			labName:set_active(false); 
		end 
        local damageTxt = "伤害值:"..tostring( data.damage );
        labDamageNum:set_text( damageTxt );
        local rewardCfg = ConfigManager.Get( EConfigIndex.t_guild_boss_rank_reward, dataIndex );
        if rewardCfg then
            for i = 1, 3 do
                --先隐藏不需要的控件
                local parentObj = obj:get_child_by_name( "cont_prop/new_small_card_item"..tostring( i ) );
                if rewardCfg.reward[i] then
                    local itemID = rewardCfg.reward[i].id;
                    local itemNum = rewardCfg.reward[i].num;
                    local card_prop = CardProp:new( { number = itemID, count = itemNum } );
                    local smallItemIcon = UiSmallItem:new( {obj = nil, parent = parentObj, cardInfo = card_prop, delay = 200, load_callback = function(cls)
                    cls:SetCount(cls.cardInfo.count) end} );
                    table.insert( self.itemIconList, smallItemIcon );
                else
                    parentObj:set_active( false );
                end
            end
        end
    end
end
