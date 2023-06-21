--fileName:ui/play/associations_boss/ui_associations_boss.lua
--desc:社团boss主UI
--code by:fengyu
--date:2016-8-2

UiGuildBoss = Class( "UiGuildBoss", UiBaseClass );

local BossLevelSp =
{
    [1] = "stboss_bianhao_di",
    [2] = "stboss_bianhao_di2",
    [3] = "stboss_bianhao_di3",
}

function UiGuildBoss:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2820_guild_boss.assetbundle";
    UiBaseClass.Init( self, data );
end

function UiGuildBoss:InitData( data )
    UiBaseClass.InitData( self, data );
end

function UiGuildBoss:Restart( data )
    msg_guild_boss.cg_request_guild_boss_detail_info();
    self.curIndex = nil;
    UiBaseClass.Restart( self, data );
end

function UiGuildBoss:DestroyUi()
    if self.timerId then
        timer.stop(self.timerId);
        self.timerId = nil;
    end
    if self.cont then
        for k,cont in pairs(self.cont) do
            cont.tex:Destroy();
        end
        self.cont = nil;
    end
    -- if self.texBoss then
    --     self.texBoss:Destroy();
    --     self.texBoss = nil;
    -- end
    if self.objBoss then
        self.objBoss:DestroyUi();
        self.objBoss = nil;
    end
    if self.listAward then
        for k,v in pairs(self.listAward) do
            v.card:DestroyUi();
        end
        self.listAward = nil;
    end
    if self.team1 then
        for k,v in pairs(self.team1) do
            v.card:DestroyUi();
        end
        self.team1 = nil;
    end
    if self.team2 then
        for k,v in pairs(self.team2) do
            v.card:DestroyUi();
        end
        self.team2 = nil;
    end
    UiBaseClass.DestroyUi( self );
end

function UiGuildBoss:RegistFunc()
    UiBaseClass.RegistFunc( self );
    self.bindfunc["on_rank_click"] = Utility.bind_callback( self, UiGuildBoss.on_rank_click );
    self.bindfunc["on_reward_click"] = Utility.bind_callback( self, UiGuildBoss.on_reward_click );
    self.bindfunc["on_fight_click"] = Utility.bind_callback( self, UiGuildBoss.on_fight_click );
    self.bindfunc["on_btn_change_team"] = Utility.bind_callback( self, UiGuildBoss.on_btn_change_team );
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_change_boss"] = Utility.bind_callback(self, self.on_change_boss);
    self.bindfunc["on_get_award"] = Utility.bind_callback(self, self.on_get_award);
    self.bindfunc["gc_get_guild_boss_first_pass_reward_rst"] = Utility.bind_callback(self, self.gc_get_guild_boss_first_pass_reward_rst);
    self.bindfunc["gc_update_guild_boss_first_pass_reward_flag"] = Utility.bind_callback(self, self.gc_update_guild_boss_first_pass_reward_flag);
    self.bindfunc["UpdateBossInfoMsg"] = Utility.bind_callback(self, self.UpdateBossInfoMsg);
    self.bindfunc["gc_sync_guild_boss_detail_info"] = Utility.bind_callback(self, self.gc_sync_guild_boss_detail_info);
    self.bindfunc["gc_update_team_info"] = Utility.bind_callback(self, self.gc_update_team_info);
end

function UiGuildBoss:MsgRegist()
    UiBaseClass.MsgRegist( self );
    PublicFunc.msg_regist(msg_guild_boss.gc_get_guild_boss_first_pass_reward_rst,self.bindfunc["gc_get_guild_boss_first_pass_reward_rst"]);
    PublicFunc.msg_regist(msg_guild_boss.gc_update_guild_boss_first_pass_reward_flag,self.bindfunc["gc_update_guild_boss_first_pass_reward_flag"]);
    PublicFunc.msg_regist(msg_guild_boss.gc_sync_guild_boss_detail_info,self.bindfunc["gc_sync_guild_boss_detail_info"]);
    PublicFunc.msg_regist(msg_team.gc_update_team_info,self.bindfunc["gc_update_team_info"]);
end

function UiGuildBoss:MsgUnRegist()
    UiBaseClass.MsgUnRegist( self );
    PublicFunc.msg_unregist(msg_guild_boss.gc_get_guild_boss_first_pass_reward_rst,self.bindfunc["gc_get_guild_boss_first_pass_reward_rst"]);
    PublicFunc.msg_unregist(msg_guild_boss.gc_update_guild_boss_first_pass_reward_flag,self.bindfunc["gc_update_guild_boss_first_pass_reward_flag"]);
    PublicFunc.msg_unregist(msg_guild_boss.gc_sync_guild_boss_detail_info,self.bindfunc["gc_sync_guild_boss_detail_info"]);
    PublicFunc.msg_unregist(msg_team.gc_update_team_info,self.bindfunc["gc_update_team_info"]);
end

function UiGuildBoss:InitUI( asset_obj )
    UiBaseClass.InitUI( self, asset_obj );
    self.ui:set_name( "UiAssociationBoss" );

    local btnRank = ngui.find_button(self.ui,"top_right_other/animation/btn_rank");
    btnRank:set_on_click(self.bindfunc["on_rank_click"]);
    local btnAward = ngui.find_button(self.ui,"top_right_other/animation/btn_award");
    btnAward:set_on_click(self.bindfunc["on_reward_click"]);

    self.dragCycleGroup = ngui.find_enchance_scroll_view(self.ui,"centre_other/animation/cont_left/panel_list");
    self.dragCycleGroup:set_on_initialize_item(self.bindfunc["on_init_item"]);
    -- self.texBoss = ngui.find_texture(self.ui,"centre_other/animation/cont_right/Texture");
    local obj = self.ui:get_child_by_name("centre_other/animation/cont_right/big_card_item_80");
    self.objBoss = SmallCardUi:new({parent=obj,stypes={1,5,6,7}});

    self.labBossName = ngui.find_label(self.ui,"centre_other/animation/cont_right/lab_name");
    self.proBossHp = ngui.find_progress_bar(self.ui,"centre_other/animation/cont_right/progress_bar");
    self.labTimes = ngui.find_label(self.ui,"centre_other/animation/cont_right/sp_title_di/lab_challenge");
    self.listAward = {};
    for i=1,4 do
        self.listAward[i] = {};
        local obj = self.ui:get_child_by_name("centre_other/animation/cont_right/txt/grid/new_small_card_item"..i);
        self.listAward[i].obj = obj
        self.listAward[i].card = UiSmallItem:new({parent=obj});
    end
    self.btnGetAward = ngui.find_button(self.ui,"centre_other/animation/cont_right/btn_get");
    self.btnGetAward:set_on_click(self.bindfunc["on_get_award"]);
    self.objGet = self.ui:get_child_by_name("centre_other/animation/cont_right/sp_art_font");

    self.labMyRank = ngui.find_label(self.ui,"down_other/animation/lab_open_time");
    self.team1 = {};
    self.team2 = {};
    for i=1,3 do
        self.team1[i] = {};
        local obj = self.ui:get_child_by_name("down_other/animation/lab_one/big_card_item_80"..i);
        self.team1[i].obj = obj;
        self.team1[i].card = SmallCardUi:new({parent=obj,stypes={1,2,5,6,7,9,}});

        self.team2[i] = {};
        local obj = self.ui:get_child_by_name("down_other/animation/lab_two/big_card_item_80"..i);
        self.team2[i].obj = obj;
        self.team2[i].card = SmallCardUi:new({parent=obj,stypes={1,2,5,6,7,9,}});
    end

    local btnChangeTeam = ngui.find_button(self.ui,"down_other/animation/btn_team");
    btnChangeTeam:set_on_click(self.bindfunc["on_btn_change_team"]);
    self.btnStart = ngui.find_button(self.ui,"down_other/animation/btn_fight");
    self.btnStart:set_on_click(self.bindfunc["on_fight_click"]);

    self.timerId = timer.create(self.bindfunc["UpdateBossInfoMsg"],1000,-1);

    self:UpdateUi();
end

function UiGuildBoss:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end

    self:CheckTeamInfo();

    local listCfg = ConfigManager._GetConfigTable(EConfigIndex.t_guild_boss_monster);
    self.cont = {};
    self.dragCycleGroup:set_maxNum(#listCfg);
    self.dragCycleGroup:refresh_list();

    local team1 = g_dataCenter.player:GetTeam(ENUM.ETeamType.guild_boss1);
    local team2 = g_dataCenter.player:GetTeam(ENUM.ETeamType.guild_boss2);
    for i=1,3 do
        if team1[i] and team1[i] ~= 0 then
            self.team1[i].card:SetData(g_dataCenter.package:find_card(1, team1[i]))
        else
            self.team1[i].card:SetData();
        end
        if team2[i] and team2[i] ~= 0 then
            self.team2[i].card:SetData(g_dataCenter.package:find_card(1, team2[i]))
        else
            self.team2[i].card:SetData();
        end
    end
    self:on_change_boss({float_value=self.curIndex or 1,game_object=self.curCont});
end

function UiGuildBoss:UpdateBossInfo()
    if not self.ui then return end;
    local cfg = ConfigManager.Get(EConfigIndex.t_guild_boss_monster, self.curIndex or 1);
    local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property, cfg.boss_id);
    self.labBossName:set_text(tostring(monsterCfg.name));
    local curIndex,curBossLv,curBossHp = g_dataCenter.guildBoss:GetCurBossInfo();
    if (self.curIndex or 1) < curIndex then
        self.proBossHp:set_value(0);
        PublicFunc.SetButtonShowMode(self.btnStart, 3);
    elseif (self.curIndex or 1) > curIndex then
        self.proBossHp:set_value(1);
    else
        PublicFunc.SetButtonShowMode(self.btnStart, 1);
        local lvCfg = CardHuman.GetLevelConfig(cfg.boss_id, curBossLv, monsterCfg);
        local maxHp = monsterCfg.max_hp+lvCfg.max_hp;
        self.proBossHp:set_value(curBossHp/maxHp);
    end
    local times = g_dataCenter.guildBoss:GetChallengeTimes();
    local total_times = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).every_day_times;
    self.labTimes:set_text(tostring(total_times-times));
    self.objBoss:SetDataNumber(cfg.boss_id);
    -- if cfg.big_icon and cfg.big_icon ~= 0 then
    --     self.texBoss:set_active(true);
    --     self.texBoss:set_texture(cfg.big_icon);
    -- else
    --     self.texBoss:set_active(false);
    -- end
    if self.myRank and self.myRank ~= 0 then
        self.labMyRank:set_text("我的伤害排名[FFE400FF]"..self.myRank.."[-]");
    else
        self.labMyRank:set_text("我的伤害排名[FFE400FF]未上榜[-]");
    end
    for i=1,4 do
        local award = cfg.first_pass_reward[i];
        if award then
            self.listAward[i].obj:set_active(true);
            self.listAward[i].card:SetDataNumber(award.id, award.num);
        else
            self.listAward[i].obj:set_active(false);
        end
    end
    if g_dataCenter.guildBoss:GetFirstPassReward(self.curIndex or 1) then
        self.btnGetAward:set_active(false);
        self.objGet:set_active(true);
    else
        self.btnGetAward:set_active(true);
        self.objGet:set_active(false);
        if g_dataCenter.guildBoss:KilledBoss(self.curIndex or 1) then
            PublicFunc.SetButtonShowMode(self.btnGetAward, 1);
            self.btnGetAward:set_enable(true);
        else
            PublicFunc.SetButtonShowMode(self.btnGetAward, 3);
            self.btnGetAward:set_enable(false);
        end
    end
end

function UiGuildBoss:CheckTeamInfo()
    local flg1=false;
    local flg2=false
    local team1 = g_dataCenter.player:GetTeam(ENUM.ETeamType.guild_boss1);
    local team2 = g_dataCenter.player:GetTeam(ENUM.ETeamType.guild_boss2);
    for i=1,3 do
        if team1[i] and team1[i] ~= 0 then
            flg1 = true;
        end
        if team2[i] and team2[i] ~= 0 then
            flg2 = true;
        end
    end
    if flg1 or flg2 then
        return;
    end

    --local showType = ENUM.EShowHeroType.Have;
    local showType = ENUM.EShowHeroType.All;
    local list = PublicFunc.GetAllHero(showType,nil,{});
    local cardsInfo1 = {};
    local cardsInfo2 = {};
    for j=1,3 do
        if list[j] then
            cardsInfo1[j] = list[j].index;
        end
    end
    for j=1,3 do
        if list[j+3] then
            cardsInfo2[j] = list[j+3].index;
        end
    end
    local team1 = 
    {
        teamid = ENUM.ETeamType.guild_boss1,
        cards = cardsInfo1,
    }
    local team2 = 
    {
        teamid = ENUM.ETeamType.guild_boss2,
        cards = cardsInfo2,
    }
    msg_team.cg_update_team_info(team1);
    msg_team.cg_update_team_info(team2);
end

function UiGuildBoss:on_btn_change_team()
    uiManager:PushUi(EUI.GuildBossFormationUI)
end

function UiGuildBoss:on_rank_click()
    uiManager:PushUi(EUI.GuildBossRankUI);
end

function UiGuildBoss:on_reward_click()
    uiManager:PushUi(EUI.GuildBossAwardUI);
end

function UiGuildBoss:on_fight_click()
    if g_dataCenter.chatFight:CheckMyRequest() then
        return
    end

    local team1 = g_dataCenter.player:GetTeam(ENUM.ETeamType.guild_boss1);
    local team2 = g_dataCenter.player:GetTeam(ENUM.ETeamType.guild_boss2);
    if (team1 == nil or #team1 == 0) and (team2 == nil or #team2 == 0) then
        HintUI.SetAndShow(EHintUiType.zero, "未选择出战角色，请点击队伍调整按钮选择出战角色。")
        return;
    end
    local curIndex = g_dataCenter.guildBoss:GetCurBossInfo();
    if curIndex ~= (self.curIndex or 1) then
        return;
    end
    msg_guild_boss.cg_enter_guild_boss();
end

function UiGuildBoss:on_init_item(obj, index)
    local b = obj:get_instance_id();
    if Utility.isEmpty(self.cont[b]) then
        self.cont[b] = self:init_item(obj)
    end
    self.cont[b].b = b;
    self.cont[b].index = index;
    self:update_init_item(self.cont[b], index);
end

function UiGuildBoss:init_item(obj)
    local cont = {}
    cont.obj = obj;
    cont.labName = ngui.find_label(obj,"lab_boss_name");
    cont.labId = ngui.find_label(obj,"sp_lab_di/lab_num");
    cont.spBk = ngui.find_sprite(obj,"sp_di");
    cont.spId = ngui.find_sprite(obj,"sp_lab_di");
    cont.objKill = obj:get_child_by_name("sp_art_font");
    cont.tex = ngui.find_texture(obj,"Texture");
    cont.btn = ngui.find_button(obj,obj:get_name());
    cont.btn:set_on_click(self.bindfunc["on_change_boss"]);
    return cont;
end

function UiGuildBoss:update_init_item(cont, index)
    local cfg = ConfigManager.Get(EConfigIndex.t_guild_boss_monster,index);
    if not cfg then
        return;
    end
    local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property, cfg.boss_id);
    cont.labName:set_text(tostring(monsterCfg.name));
    cont.labId:set_text(tostring(index));
    cont.btn:set_event_value("",index);
    if cfg.small_icon and cfg.small_icon ~= 0 then
        cont.tex:set_active(true);
        cont.tex:set_texture(cfg.small_icon);
    else
        cont.tex:set_active(false);
    end
    if index == (self.curIndex or 1) then
        cont.spBk:set_sprite_name("stboss_liebiao2");
        self.curCont = cont.obj;
    else
        cont.spBk:set_sprite_name("stboss_liebiao1");
    end
    local boss_id,lv,hp = g_dataCenter.guildBoss:GetCurBossInfo();
    if #BossLevelSp > lv then
        cont.spId:set_sprite_name(BossLevelSp[lv]);
    else
        cont.spId:set_sprite_name(BossLevelSp[#BossLevelSp]);
    end
    if not g_dataCenter.guildBoss:KilledBoss(index) and index ~= boss_id then
        if index == (self.curIndex or 1) then
            cont.tex:set_color(1,1,1,1);
            cont.spBk:set_color(1,1,1,1);
            cont.spId:set_color(1,1,1,1);
        else
            cont.tex:set_color(0,0,0,1);
            cont.spBk:set_color(0,0,0,1);
            cont.spId:set_color(0,0,0,1);
        end
        cont.objKill:set_active(false);
    else
        cont.tex:set_color(1,1,1,1);
        cont.spBk:set_color(1,1,1,1);
        cont.spId:set_color(1,1,1,1);
        if index == boss_id and hp > 0 then
            cont.objKill:set_active(false);
        else
            cont.objKill:set_active(true);
        end
    end
end

function UiGuildBoss:on_change_boss(t)
    if t.float_value > g_dataCenter.guildBoss:GetCurBossInfo() then
        FloatTip.Float("请先击败前置首领")
        return;
    end
    if self.curIndex ~= nil then
        self.curIndex = t.float_value;
    end
    local obj = t.game_object;
    if self.curCont then
        local b = self.curCont:get_instance_id();
        self:update_init_item(self.cont[b],self.cont[b].index);
    end
    if obj then
        local b = obj:get_instance_id();
        if self.cont[b] then
            self:update_init_item(self.cont[b],self.cont[b].index);
        end
        self.curCont = obj;
    end
    self:UpdateBossInfo();
end

function UiGuildBoss:on_get_award()
    if self.curIndex == nil then
        return;
    end
    msg_guild_boss.cg_get_guild_boss_first_pass_reward(self.curIndex);
end

function UiGuildBoss:gc_get_guild_boss_first_pass_reward_rst(rst, reward)
    CommonAward.Start(reward);
end

function UiGuildBoss:gc_update_guild_boss_first_pass_reward_flag()
    self:UpdateBossInfo();
end

function UiGuildBoss:gc_sync_guild_boss_detail_info(info)
    if self.curIndex ~= nil and self.curIndex ~= g_dataCenter.guildBoss:GetCurBossInfo() then
        self.myRank = info.rank;
        for k,v in pairs(self.cont or {}) do
            self:update_init_item(v,v.index);
        end
        self:UpdateBossInfo();
        return;
    end
    self.curIndex = g_dataCenter.guildBoss:GetCurBossInfo();
    self.myRank = info.rank;
    for k,v in pairs(self.cont or {}) do
        self:update_init_item(v,v.index);
    end
    self:on_change_boss({float_value=self.curIndex or 1,game_object=self.curCont});
end

function UiGuildBoss:UpdateBossInfoMsg()
    msg_guild_boss.cg_request_guild_boss_detail_info();
end

function UiGuildBoss:gc_update_team_info()
    self:UpdateUi();
end
