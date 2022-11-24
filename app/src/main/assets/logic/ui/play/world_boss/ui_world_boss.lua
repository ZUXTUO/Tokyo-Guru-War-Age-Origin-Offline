UiWorldBoss = Class("UiWorldBoss", UiBaseClass);

local countUpdateBossInfo = 1;
local countUpdateRankInfo = 5;

function UiWorldBoss:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/world_boss/ui_3001_world_boss.assetbundle"
	UiBaseClass.Init(self, data);
end

function UiWorldBoss:Restart(data)
    self._rankInfo = {};
    msg_world_boss.cg_request_world_boss_detail_info();
    msg_world_boss.cg_request_world_boss_rt_rank_info();
    UiBaseClass.Restart(self, data);
end

function UiWorldBoss:DestroyUi()
    if self.clsBuyTimes then
        self.clsBuyTimes:DestroyUi()
        self.clsBuyTimes = nil
    end
    if self.rankCont then
        for k,v in pairs(self.rankCont) do
            v.head:DestroyUi();
        end
        self.rankCont = nil;
    end
    if self.teamCont then
        for k,v in pairs(self.teamCont) do
            v:DestroyUi();
        end
        self.teamCont = nil;
    end
    if self.timerId1 then
        timer.stop(self.timerId1);
        self.timerId1 = ni;
    end
    if self.timerId2 then
        timer.stop(self.timerId2);
        self.timerId2 = ni;
    end
    if self.bossHead then
        self.bossHead:DestroyUi();
        self.bossHead = nil;
    end
    UiBaseClass.DestroyUi(self);
end

function UiWorldBoss:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["onFightStart"] = Utility.bind_callback(self,self.onFightStart);
    self.bindfunc["onChangeTeam"] = Utility.bind_callback( self, self.onChangeTeam );
    self.bindfunc["onReport"] = Utility.bind_callback( self, self.onReport );
    self.bindfunc["onRank"] = Utility.bind_callback( self, self.onRank );
    self.bindfunc["onAward"] = Utility.bind_callback( self, self.onAward );
    self.bindfunc["onClickBuyTimes"] = Utility.bind_callback(self, self.onClickBuyTimes);
    self.bindfunc["gc_update_world_boss_last_times"] = Utility.bind_callback(self, self.gc_update_world_boss_last_times);
    self.bindfunc["UpdateBossInfoMsg"] = Utility.bind_callback(self, self.UpdateBossInfoMsg);
    self.bindfunc["UpdateRankInfoMsg"] = Utility.bind_callback(self, self.UpdateRankInfoMsg);
    self.bindfunc["gc_sync_world_boss_detail_info"] = Utility.bind_callback(self, self.gc_sync_world_boss_detail_info);
    self.bindfunc["gc_sync_world_boss_rt_rank_info"] = Utility.bind_callback(self, self.gc_sync_world_boss_rt_rank_info);
    self.bindfunc["onBuyTimes"] = Utility.bind_callback(self, self.onBuyTimes);
    self.bindfunc["gc_sync_world_boss_rank_info"] = Utility.bind_callback(self, self.gc_sync_world_boss_rank_info);
end

function UiWorldBoss:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_world_boss.gc_update_world_boss_last_times,self.bindfunc["gc_update_world_boss_last_times"]);
    PublicFunc.msg_regist(msg_world_boss.gc_sync_world_boss_detail_info,self.bindfunc["gc_sync_world_boss_detail_info"]);
    PublicFunc.msg_regist(msg_world_boss.gc_sync_world_boss_rt_rank_info,self.bindfunc["gc_sync_world_boss_rt_rank_info"]);
    PublicFunc.msg_regist(msg_world_boss.gc_sync_world_boss_rank_info,self.bindfunc["gc_sync_world_boss_rank_info"]);
end

function UiWorldBoss:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_world_boss.gc_update_world_boss_last_times,self.bindfunc["gc_update_world_boss_last_times"]);
    PublicFunc.msg_unregist(msg_world_boss.gc_sync_world_boss_detail_info,self.bindfunc["gc_sync_world_boss_detail_info"]);
    PublicFunc.msg_unregist(msg_world_boss.gc_sync_world_boss_rt_rank_info,self.bindfunc["gc_sync_world_boss_rt_rank_info"]);
    PublicFunc.msg_unregist(msg_world_boss.gc_sync_world_boss_rank_info,self.bindfunc["gc_sync_world_boss_rank_info"]);
end

function UiWorldBoss:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("UiWorldBoss");

    local btnReport = ngui.find_button(self.ui,"animation/right_top_other/animation/btn_report");
    btnReport:set_on_click(self.bindfunc["onReport"]);
    local btnRank = ngui.find_button(self.ui,"animation/right_top_other/animation/btn_rank");
    btnRank:set_on_click(self.bindfunc["onRank"]);
    local btnAward = ngui.find_button(self.ui,"animation/right_top_other/animation/btn_award");
    btnAward:set_on_click(self.bindfunc["onAward"]);

    self.rankCont = {};
    for i=1,3 do
        self.rankCont[i] = {};
        local obj = self.ui:get_child_by_name("animation/left_other/animation/content"..i);
        self.rankCont[i].obj = obj;
        self.rankCont[i].spRank = ngui.find_sprite(obj,"sp_rank");
        self.rankCont[i].labName = ngui.find_label(obj,"lab_name");
        self.rankCont[i].labDamage = ngui.find_label(obj,"lab_level");
        local node = obj:get_child_by_name("sp_head_di_item");
        self.rankCont[i].head = UiPlayerHead:new({parent=node});
    end
    self.labMyRank = ngui.find_label(self.ui,"animation/left_other/animation/lab_rank");
    self.labMyDamage = ngui.find_label(self.ui,"animation/left_other/animation/lab_harm");

    self.nodeKill = self.ui:get_child_by_name("animation/right_other/sp_bk");
    self.labKill = ngui.find_label(self.ui,"animation/right_other/sp_bk/lab_name");
    self.labTime = ngui.find_label(self.ui,"animation/right_other/sp_bk/lab_describe");
    local obj = self.ui:get_child_by_name("animation/right_other/sp_bk/big_card_item_80");
    self.bossHead = SmallCardUi:new({parent=obj,stypes = 
        {
            SmallCardUi.SType.Texture,
            SmallCardUi.SType.Star,
            SmallCardUi.SType.Rarity,
            SmallCardUi.SType.Qh,
            SmallCardUi.SType.Leader,
        }});

    self.nodebossInfo = self.ui:get_child_by_name("animation/right_other/cont1");
    self.labBossName = ngui.find_label(self.ui,"animation/right_other/cont1/lab_name");
    self.labBossLv = ngui.find_label(self.ui,"animation/right_other/cont1/lab_level");
    self.labTimes = ngui.find_label(self.ui,"animation/right_other/cont1/sp_title_di/lab_challenge");
    local btnBuyTimes = ngui.find_button(self.ui,"animation/right_other/cont1/btn_add");
    btnBuyTimes:set_on_click(self.bindfunc["onClickBuyTimes"]);
    self.proHp = ngui.find_progress_bar(self.ui,"animation/right_other/cont1/progress_bar");

    self.nodeActiveOver = self.ui:get_child_by_name("animation/right_other/cont2");
    self.labOverBossName = ngui.find_label(self.ui,"animation/right_other/cont2/lab_name");
    self.labOverBossLv = ngui.find_label(self.ui,"animation/right_other/cont2/lab_level");

    self.labBeginTime = ngui.find_label(self.ui,"animation/right_other/lab_time");

    self.teamCont = {};
    for i=1,3 do
        local obj = self.ui:get_child_by_name("animation/down_other/panel/animation/lab_one/big_card_item_80"..i);
        self.teamCont[i] = SmallCardUi:new({parent=obj,stypes = {1,5,6,7,9}});
    end
    local btnChangeTeam = ngui.find_button(self.ui,"animation/down_other/panel/animation/btn_team");
    btnChangeTeam:set_on_click(self.bindfunc["onChangeTeam"]);
    local btnStart = ngui.find_button(self.ui,"animation/down_other/panel/animation/btn_fight");
    btnStart:set_on_click(self.bindfunc["onFightStart"]);

    self.texBossBg = ngui.find_texture(self.ui,"animation/Texture");
    self.spDes = ngui.find_sprite(self.ui,"animation/right_other/sp_art_font");
    self.spInfoBg = ngui.find_sprite(self.ui,"animation/right_other/sp_di");

    self.timerId1 = timer.create(self.bindfunc["UpdateBossInfoMsg"], 1000*countUpdateBossInfo, -1);
    self.timerId2 = timer.create(self.bindfunc["UpdateRankInfoMsg"], 1000*countUpdateRankInfo, -1);
    self:UpdateUi();
end

function UiWorldBoss:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return
    end
    self:UpdateRankUI();
    self:UpdateBossInfoUi();
    self:UpdateTeamUI();
end

function UiWorldBoss:UpdateRankUI()
    if not self.ui then return end;
    for i=1,3 do
        local cfg = self._rankInfo[i];
        if cfg then
            self.rankCont[i].obj:set_active(true);
            self.rankCont[i].spRank:set_sprite_name("phb_paiming"..i);
            self.rankCont[i].labName:set_text(cfg.player_name);
            self.rankCont[i].labDamage:set_text("伤害:[FCD901FF]"..cfg.damage);
            self.rankCont[i].head:SetRoleId(cfg.image);
        else
            self.rankCont[i].obj:set_active(false);
        end
    end
    if self._myRank and self._myRank > 0 then
        self.labMyRank:set_text("我的排名  [FFCC01FF]"..self._myRank.."[-]");
    else
        self.labMyRank:set_text("我的排名  [FFCC01FF]未上榜[-]");
    end
    if self._myDamage then
        self.labMyDamage:set_text("我的伤害 [FFCC01FF]"..self._myDamage.."[-]");
    else
        self.labMyDamage:set_text("我的伤害 ");
    end
end

function UiWorldBoss:UpdateBossInfoUi()
    if not self.ui then return end;
    local cfgId, bossLv, bossHp = g_dataCenter.worldBoss:GetBossInfo();
    local cfg = ConfigManager.Get(EConfigIndex.t_world_boss_system, cfgId);
    local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property, cfg.boss_info.id);
    if cfg.big_icon and cfg.big_icon ~= 0 then
        self.texBossBg:set_texture(cfg.big_icon);
        self.texBossBg:set_active(true);
    else
        self.texBossBg:set_active(false);
    end
    self.spDes:set_sprite_name(tostring(cfg.boss_type_name));
    local state = g_dataCenter.worldBoss:GetState();
    if state == 0 then
        local time = g_dataCenter.worldBoss:GetLastTime();
        local str = PublicFunc.FormatLeftSecondsEx(time);
        self.labBeginTime:set_text("开启倒计时[FFE400FF]"..str.."[-]");
        self.nodebossInfo:set_active(false);
        self.nodeActiveOver:set_active(false);
        self.nodeKill:set_active(false);
        self.spInfoBg:set_color(0,0,0,1);
    elseif state == 1 then
        local times = g_dataCenter.worldBoss:GetChallengeTimes();
        local lvCfg = CardHuman.GetLevelConfig(cfg.boss_info.id, bossLv, monsterCfg);
        local maxHp = monsterCfg.max_hp+lvCfg.max_hp;
        self.labBeginTime:set_text("");
        self.labBossName:set_text(monsterCfg.name);
        if bossHp == 0 then
            bossHp = maxHp;
        end
        local rst = self:UpdateReviveUi();
        if rst then
            self.labBossLv:set_text(tostring(bossLv-1).."级");
            self.proHp:set_value(0);
            self.texBossBg:set_color(0,0,0,1);
        else
            self.labBossLv:set_text(tostring(bossLv).."级");
            self.proHp:set_value(bossHp/maxHp);
            self.texBossBg:set_color(1,1,1,1);
        end
        self.labTimes:set_text(tostring(times));
        self.nodebossInfo:set_active(true);
        self.nodeActiveOver:set_active(false);
        self.spInfoBg:set_color(1,1,1,1);
    elseif state == 2 then
        self.labBeginTime:set_text("");
        self.nodebossInfo:set_active(false);
        self.nodeActiveOver:set_active(true);
        self.labOverBossName:set_text("最高首领: "..monsterCfg.name);
        self.labOverBossLv:set_text(bossLv.."级")
        self.nodeKill:set_active(false);
        self.spInfoBg:set_color(0,0,0,1);
    else
        app.log("世界boss状态错误。state:"..tostring(state));
    end
end

function UiWorldBoss:UpdateTeamUI()
    local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.world_boss);
    for i=1,3 do
        if team[i] and team[i] ~= 0 then
            local card = g_dataCenter.package:find_card(1,team[i]);
            self.teamCont[i]:SetData(card);
        else
            self.teamCont[i]:SetData();
        end
    end
end

function UiWorldBoss:UpdateReviveUi()
    local bossReviveTime = g_dataCenter.worldBoss:GetLastTime();
    if bossReviveTime <= 0 then
        self.nodeKill:set_active(false);
        return false;
    else
        local cfgId = g_dataCenter.worldBoss:GetBossInfo();
        local cfg = ConfigManager.Get(EConfigIndex.t_world_boss_system, cfgId);
        self.nodeKill:set_active(true);
        local name = g_dataCenter.worldBoss:GetKillerName();
        self.labKill:set_text("由[FFE400FF]"..tostring(name).."[-]击杀");
        self.labTime:set_text("[FF0000FF]"..bossReviveTime.."[-]秒后BOSS将复活来袭！");
        self.bossHead:SetDataNumber(cfg.boss_info.id);
        return true;
    end
end

function UiWorldBoss:onChangeTeam()
    local data = {
        teamType = ENUM.ETeamType.world_boss,
        heroMaxNum = 3,
    }
    uiManager:PushUi(EUI.CommonFormationUI, data)
end

function UiWorldBoss:onFightStart(t)
    if g_dataCenter.chatFight:CheckMyRequest() then
        return
    end
    --开始挑战 直接进入游戏或者选英雄
    local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.world_boss);
    if team == nil or #team == 0 then
        HintUI.SetAndShow(EHintUiType.zero, "未选择出战角色，请点击队伍调整按钮选择出战角色。")
        return
    end
    msg_world_boss.cg_enter_world_boss();
    GLoading.Show(GLoading.EType.msg);
end

function UiWorldBoss:onReport()
    uiManager:PushUi(EUI.WorldBossReportUI);
end

function UiWorldBoss:onRank()
    msg_world_boss.cg_request_world_boss_rank_info();
end

function UiWorldBoss:onAward()
    uiManager:PushUi(EUI.UiWorldBossReward);
end

function UiWorldBoss:onClickBuyTimes()
    local curVipLv = g_dataCenter.player:GetVip();
    local curTimes = g_dataCenter.worldBoss:GetBuyTimes();
    local maxTimes = g_dataCenter.worldBoss:GetMaxBuyTimes(); 
    if maxTimes-curTimes <= 0 then
        local num = ConfigManager.GetDataCount(EConfigIndex.t_vip_data);
        if curVipLv >= num then
            FloatTip.Float("今日购买次数已达上限");
        else
            FloatTip.Float("今日购买次数已达上限！充值提高好感度可提高购买次数。");
        end
    else
        if not self.clsBuyTimes then
            self.clsBuyTimes = WorldBossBuyTimesUI:new()
        end
        self.clsBuyTimes:SetData( {
                useCount=curTimes, 
                maxCount=maxTimes-curTimes
            })
        self.clsBuyTimes:SetCallback(self.bindfunc["onBuyTimes"]);
    end
end

function UiWorldBoss:onBuyTimes(param, data)
    msg_world_boss.cg_buy_world_boss_times(data.totalCount);
end

function UiWorldBoss:UpdateBossInfoMsg()
    msg_world_boss.cg_request_world_boss_detail_info();
end

function UiWorldBoss:UpdateRankInfoMsg()
    msg_world_boss.cg_request_world_boss_rt_rank_info();
end

function UiWorldBoss:gc_sync_world_boss_detail_info(info)
    self:UpdateBossInfoUi();
end

function UiWorldBoss:gc_sync_world_boss_rt_rank_info(info)
    self._rankInfo = info.rank_info;
    self._myRank = info.rank;
    self._myDamage = info.damage;
    self:UpdateRankUI();
end

function UiWorldBoss:gc_update_world_boss_last_times()
    self:UpdateBossInfoUi();
end

function UiWorldBoss:gc_sync_world_boss_rank_info(rank_info)
    if #rank_info == 0 then 
        GLoading.Hide(GLoading.EType.ui, self.loadingId);
        FloatTip.Float("当前还没有排行榜数据");
        return;
    end 
    local viewData = {}
    local my_rank = 
    {
        ranking = self._myRank,
        playerid = g_dataCenter.player.playerid,
        name = g_dataCenter.player.name,
        param2 = g_dataCenter.player.vip,
        level = g_dataCenter.player.level,
        iconsid = g_dataCenter.player.image,
        num = self._myDamage,
        guildName = g_dataCenter.guild:GetMyGuildName(),
    };
    for i, v in ipairs(rank_info) do
        local rankPlayer = 
        {
            playerid = v.player_gid,
            name = v.player_name,
            num = v.damage,
            ranking = i,
            param2 = v.vip_level,
            guildName = v.guild_name,
            iconsid = v.image or 0,
            level = v.player_level or 0,
        }
        table.insert(viewData, rankPlayer)
    end
    viewData.my_rank = my_rank;
    RankPopPanel.popPanel(viewData,RANK_TYPE.WORLDBOSS);
end
