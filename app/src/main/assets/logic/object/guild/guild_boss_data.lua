--fileName:logic/object/guild/guild_boss_data.lua
--desc:社团boss的数据缓存类
--code by:fengyu
--date:2016-8-5

GuildBossData = Class( "GuildBossData" );

function GuildBossData:Init( data )
    self.initState = false;
    self.damage = 0;
    self.curMyMyRank = 0;
    self.lastGuildRankInfo = nil;  --社团排行信息
    self.lastBossRankInfo = nil;    --本社团boss排行伤害排行数据
    self.reliveTime = nil;
    self.initReqGuildRank = false;
    self.initReqPlayerRank = false;
    self.isJoined = false;
    self.curRoundIndex = 1;
    self.curBossRank = 0;
    self.curBossLevel = 0;
    self.last_killer_gid = "0";
    self.last_boss_contribute = 0;
    self.last_boss_level = 0;
    self.curRankInfo = nil;         --战斗中的社团玩家排行数据
    self.curKillInfo = nil;         --社团boss击杀数据
    self.curGoldBuffBuyTimes = 0;
    self.curCrystalBuffBuyTimes = 0;
    self.curAddBuffList = nil;
    self.isAutoFight = false;
    self.curBossConfigID = 0;
    self.curPosX = 0;
    self.curPosY = 0;
    self.curFreeReliveCountLevel = 1;
    self.isAutoRelive = false;
    self.haveReliveTimes = 0;   --原地复活的次数
    self.bossLevel = nil;
end

function GuildBossData:Reset()
    self.damage = 0;
    self.lastGuildRankInfo = nil;  --社团排行信息
    self.lastBossRankInfo = nil;    --本社团boss排行伤害排行数据
    self.curRankInfo = nil;         --战斗中的社团玩家排行数据
    self.curKillInfo = nil;         --社团boss击杀数据
    self.bossLevel = nil;
end

function GuildBossData:IsInitState()
    return self.initState;
end

--初始化状态，以及状态改变都会推送该消息，能进不能进的变化
function GuildBossData:UpdateState( state, left_time, is_join, round_index, boss_killed, system_over)
    self.initState = true;
    self.curState = state;
    self.isJoined = is_join;
    self.curRoundIndex = round_index;
    self.boss_killed = boss_killed
    self.system_over = system_over
    if round_index == 0 then
        self.curRoundIndex = 1
    else
        self.curRoundIndex = round_index
    end
    self.nextTime = os.time() + left_time;
    -- GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_Boss);
end

function GuildBossData:SetInitState( bInitState )
    self.initState = bInitState;
end


function GuildBossData:FightResult( damage, rank, listJoinReward)
    self.bossDeadTime = system.time()
    self.isJoined = false;
    if FightScene.GetFightManager() and not FightScene.GetFightManager():IsFightOver() then
        FightScene.GetFightManager():FightOver();
        CommonAwardGuildBoss.Start(1, damage, rank+1, listJoinReward);
        CommonAwardGuildBoss.SetFinishCallback( function ()
                                                    FightScene.OnFightOver()
                                                    FightScene.ExitFightScene();
                                                end );
    end
end

function GuildBossData:IsOpen()
    if not g_dataCenter.guild:GetDetail() then
        return Gt_Enum_Wait_Notice.Guild_Wait_Enter
    end
    if g_dataCenter.guild:CheckLevelLimit(7) then
        return Gt_Enum_Wait_Notice.Guild_LevelChange;
    end
    local total_times = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).every_day_times;
    if self:GetChallengeTimes() < total_times then
        return Gt_Enum_Wait_Notice.Success;
    end
    return Gt_Enum_Wait_Notice.Forced;
end

function GuildBossData:SetLastGuildBossRank( listBossRank, myRank, myBossLevel )
    self.lastGuildRankInfo = listBossRank;
    self.curBossRank = myRank;
    self.curBossLevel = myBossLevel;
    self.initReqGuildRank = true;
    self:OpenLastGuildBossRankCallback();
end

function GuildBossData:SetLastGuildBossPlayerRank( listGuildBossDamageRankinfo, killer_gid, contribute, boss_level )
    self.lastBossRankInfo = listGuildBossDamageRankinfo;
    self.last_killer_gid = killer_gid;
    self.last_boss_contribute = contribute;
    self.last_boss_level = boss_level;
    self.initReqPlayerRank = true;
    self:OpenLastPlayerRankCallback();
end

--查看所有社团boss排行数据
function GuildBossData:OpenLastGuildBossRank()
    if self.initReqGuildRank then
        self:OpenLastGuildBossRankCallback();
    else
        GLoading.Show(GLoading.EType.msg);
        msg_guild_boss.cg_request_guild_boss_rank();
    end
end

--查看本社团的boss伤害排行数据
function GuildBossData:OpenLastPlayerRank()
    if self.initReqPlayerRank then
        self:OpenLastPlayerRankCallback();
    else
        GLoading.Show(GLoading.EType.msg);
        msg_guild_boss.cg_request_guild_boss_damage_rank();
    end
end

function GuildBossData:OpenLastGuildBossRankCallback()
    if self.lastGuildRankInfo ~= nil and #self.lastGuildRankInfo > 0 then
		local data = {};
		local my_rank = {};
		local guildDetail = g_dataCenter.guild:GetDetail();
		my_rank.id = guildDetail.id;
		my_rank.guild_name = guildDetail.name;
		my_rank.iconsid = guildDetail.icon;
		my_rank.level = guildDetail.level;
		my_rank.ranking = 0;
		my_rank.boss_level = guildDetail.guilBossLevel;
        my_rank.search_id = guildDetail.searchid
		for i = 1,#self.lastGuildRankInfo do 
			local v = self.lastGuildRankInfo[i];
			local t = {};
			t.id = v.guidl_id;
			t.guild_name = v.guild_name;
			t.boss_level = v.boss_level;
			t.level = v.guild_level;
			t.iconsid = v.icon;
            t.search_id = v.search_id;
			t.ranking = i;
			if v.guidl_id == my_rank.id then 
				my_rank.boss_level = v.boss_level;
				my_rank.ranking = i;
			end
			table.insert(data,t);
		end
		data.my_rank = my_rank;
		--RankGuildBoss.popPanel(data);
		RankPopPanel.popPanel(data,RANK_TYPE.GUILDBOSS);
    else
        local text = "当前暂无排名";
        FloatTip.Float( text );
    end
end

function GuildBossData:OpenLastPlayerRankCallback()
    if self.lastBossRankInfo ~= nil and #self.lastBossRankInfo > 0 then
		uiManager:PushUi( EUI.UiGuildBossRank );
    else
        local text = "当前暂无成员排名";
        FloatTip.Float( text );
    end
end

function GuildBossData:SetIsJoin( flag )
    self.isJoined = flag;
end

function GuildBossData:SetReliveUi( left_time )
    self.reliveTime = left_time;
    if GetMainUI() and GetMainUI():IsShow() then
        self:OpenReliveUi();
    end
end

function GuildBossData:OpenReliveUi()
    local curTime = system.time();
    if self.reliveTime and self.reliveTime > 0 then
        local cf = ConfigManager.Get( EConfigIndex.t_guild_boss, self.curRoundIndex );
        if cf then
            local info =
            {
                reliveTime = self.reliveTime,
                relive = cf.crystal_relive_cost,
                title = "你已被社团BOSS击败!",
                reliveCount = 0,
                fightType = 1,
            }
            CommonDead.Start( info );
            CommonDead.SetRelive( GuildBossData.OnRelive, self );
            CommonDead.SetLeave( GuildBossData.OnLeave, self );
        end
    end
end

function GuildBossData:OnRelive()
    local cf = ConfigManager.Get( EConfigIndex.t_guild_boss, self.curRoundIndex );
    if cf then
        local num = PropsEnum.GetValue( IdConfig.Crystal );
        if not self:GetIsCanFreeRelive() and num < cf.crystal_relive_cost then
            local txt = "你的钻石不足";
            FloatTip.Float( txt );
        else
            CommonDead.Destroy();
            msg_guild_boss.cg_guild_boss_hero_relive_immediately();
        end
    end
end

function GuildBossData:OnLeave()
    FightScene.GetFightManager():FightOver( true );
end

function GuildBossData:SetBossSyncInfo( gid, boss_id, x, y, state, level )
    self.bossLevel = level;
    if state ~= 1 then
        if self.curBossConfigID == 0 then
            self.curBossConfigID = boss_id;
        end
        if self.curBossConfigID > 0 and self.curBossConfigID == boss_id then
            self.curPosX = x;
            self.curPosY = y;
        end
    else
        self.curBossConfigID = 0;
    end
    
    if self.curBossConfigID > 0 and g_dataCenter.player:CaptionIsAutoFight() then
        local entity =  FightManager.GetMyCaptain();
        entity:SetPatrolMovePath({{x=self.curPosX,y=0,z=self.curPosY}, });
        entity:SetAI(ENUM.EAI.MainHeroAutoFight);
    end
end

function GuildBossData:SetRequestDataFlag( type )
    if type == 0 then
        self.initReqGuildRank = false;
    end
    
    if type == 1 then
        self.initReqPlayerRank = false;
    end
end

function GuildBossData:SetAutoRelive( value )
    self.isAutoRelive = value;
end

function GuildBossData:SetHaveReliveCount( times )
    self.haveReliveTimes = times;
end

function GuildBossData:GetIsCanFreeRelive()
    local result = true;
    local freeReliveCount = ConfigManager.Get( EConfigIndex.t_guild_boss_free_relive_times, self.curFreeReliveCountLevel ).param1 or 1;
    if self.haveReliveTimes >= freeReliveCount then
        result = false;
    end
    
    return result;
end

------------------------------------------
function GuildBossData:UpdateFirstPassReward(flag)
    self.bitFirstPassReward = flag;
end
function GuildBossData:GetFirstPassReward(index)
    if self.bitFirstPassReward then
        return bit.bit_and(self.bitFirstPassReward, bit.bit_lshift(1, index-1)) > 0;
    else
        return false;
    end
end

function GuildBossData:UpdateChallengeTimes(times)
    self.times = times;
end
function GuildBossData:GetChallengeTimes()
    return self.times or 0;
end

function GuildBossData:KilledBoss(index)
    return (index < (self.curBossIndex or 1)) or (index == self.curBossIndex and self.curBossHp == 0);
end

function GuildBossData:SetCurBuffBuyTimes(goldTimes, crystalTimes)
    self.curGoldBuffBuyTimes = goldTimes;
    self.curCrystalBuffBuyTimes = crystalTimes;
end

function GuildBossData:SetCurrentAddBuff(listBossBuff)
    self.curAddBuffList = listBossBuff;
end

function GuildBossData:IsHaveOwn()
    local player = g_dataCenter.player;
    if self.curRankInfo then
        for k , v in pairs( self.curRankInfo ) do
            if  v.name == player.name then
                return k;
            end
        end
    end
    return 0;
end

--同步战斗中的玩家排行数据
function GuildBossData:SetCurGuildBossRank(palyerRankInfo)
    self.curRankInfo = palyerRankInfo;
    if GetMainUI() and GetMainUI():GetRank() then
        GetMainUI():GetRank():UpdateRank(self.curRankInfo, self.damage, self:IsHaveOwn());
    end
end

function GuildBossData:SetDamage(damage, rank)
    self.damage = damage;
    self.curMyMyRank = rank;
    if GetMainUI() and GetMainUI():GetRank() then
        GetMainUI():GetRank():UpdateRank(self.curRankInfo, self.damage, self:IsHaveOwn());
    end
end

function GuildBossData:SetGroupDamageScaleState(isActive)
    self.groupDamageScaleState = isActive;
end
function GuildBossData:GetGroupDamageScaleState()
    return self.groupDamageScaleState;
end

function GuildBossData:SetCurGuildBossInfo(id, lv, cur_hp)
    self.curBossIndex = id;
    self.curBossLv = lv;
    self.curBossHp = cur_hp;
end
function GuildBossData:GetCurBossInfo()
    return self.curBossIndex or 1, self.curBossLv or 1, self.curBossHp or 0;
end

function GuildBossData:EndGame()
    
end