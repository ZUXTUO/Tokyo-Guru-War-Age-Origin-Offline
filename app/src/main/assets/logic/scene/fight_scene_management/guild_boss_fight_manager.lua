--[[
region guild_boss_fight_manager.lua
date: 2016-8-2
time: 20:51:1
author: Nation
]]
GuildBossFightManager = Class("GuildBossFightManager", FightManager)

function GuildBossFightManager:InitData()
    self.hero_index = 0
	FightManager.InitData(self)
end

function GuildBossFightManager.InitInstance()
	FightManager.InitInstance(GuildBossFightManager)
	return GuildBossFightManager
end

function GuildBossFightManager:RegistFunc()
    FightManager.RegistFunc(self)
    self.bindfunc["gc_guild_boss_fight_report"] = Utility.bind_callback(self, self.gc_guild_boss_fight_report);
    self.bindfunc["on_report_time"] = Utility.bind_callback(self, self.on_report_time);
    self.bindfunc["gc_sync_group_damage_scale_state"] = Utility.bind_callback(self, self.gc_sync_group_damage_scale_state);
end

function GuildBossFightManager:MsgRegist()
    FightManager.MsgRegist(self)
    PublicFunc.msg_regist(msg_fight.gc_guild_boss_fight_report,self.bindfunc["gc_guild_boss_fight_report"]);
    PublicFunc.msg_regist(msg_fight.gc_sync_group_damage_scale_state,self.bindfunc["gc_sync_group_damage_scale_state"]);
end

function GuildBossFightManager:MsgUnRegist()
    FightManager.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_fight.gc_guild_boss_fight_report,self.bindfunc["gc_guild_boss_fight_report"]);
    PublicFunc.msg_unregist(msg_fight.gc_sync_group_damage_scale_state,self.bindfunc["gc_sync_group_damage_scale_state"]);
end


function GuildBossFightManager:ClearUpInstance()
    if self.reportTimeId then
        timer.stop(self.reportTimeId);
        self.reportTimeId = nil;
    end
	FightManager.ClearUpInstance(self)
end

function GuildBossFightManager:LoadUI()
	FightManager.LoadUI(self)
end

function GuildBossFightManager:OnStart()
	FightManager.OnStart(self)

    Show3dText.SetShow(true);
end

function GuildBossFightManager:LoadHero()
    return true
end

--[[function PvPCommonFightManager:LoadMonster()
    return true
end]]

function GuildBossFightManager:OnLoadHero(entity)
    --世界boss跟mmo一样显示名字
    if not entity:IsMyControl() then
        entity:HideHP(true);
        entity:CreateHpNew();
    end
    -- entity:SetRebornTime(10)    -- 设置死亡立即复活
    if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        self.hero_index = self.hero_index + 1
        if g_dataCenter.fight_info:GetCaptainIndex() == nil and not entity:IsDead() then
            g_dataCenter.player:ChangeCaptain(self.hero_index, nil, false, true)
        else
            entity:SetAI(ENUM.EAI.FollowHero)
            GetMainUI():UpdateHeadData();
        end
        --[[if GetMainUI():GetMinimap() then
            --GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
	       GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
        end ]]
    else
        entity:SetAI(115)
    end
    -- if entity:IsDead() and not entity:IsNpc() then
    --     entity:CheckReborn(0)
    -- end
end

function GuildBossFightManager:GetUIAssetFileList(out_file_list)
    FightManager.GetUIAssetFileList(self, out_file_list)
    out_file_list["assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle"] = "assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle"
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_minimap_stboss.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_stboss.assetbundle"
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_map_stboss.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_map_stboss.assetbundle"
end

function GuildBossFightManager:GetHeroAssetFileList(out_file_list)
    out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function GuildBossFightManager:GetNPCAssetFileList(out_file_list)
end

function GuildBossFightManager:FightOver(is_set_exit, is_forced_exit)
    if is_set_exit then
        local str = "活动时间未结束，是否退出战斗?";
        local btn1 = {};
        btn1.str = "确定";
        btn1.func = function ()
        msg_guild_boss.cg_leave_guild_boss(true)
        end
        local btn2 = {};
        btn2.str = "取消";
        HintUI.SetAndShowHybrid(2, "", str, nil, btn1, btn2);
        return;
    end
    if is_forced_exit then
        msg_guild_boss.cg_leave_guild_boss(false)
    end
    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end

function GuildBossFightManager:OnLoadMonster(entity)
    local name = entity.card.name;
    entity.ui_hp:SetName(true, string.format("[FF0000]%s[-]", name));
    local bossInfo = 
    { {
        max_hp = entity:GetPropertyVal('max_hp'),
        cur_hp = entity:GetPropertyVal('cur_hp'),
        name = entity.config.name,
    } };
    if GetMainUI() and GetMainUI():GetBossHeartHP() then
        GetMainUI():GetBossHeartHP():UpdateBossInfo( bossInfo );
    end
    --[[if GetMainUI():GetMinimap() then
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EBoss, nil, {spriteNodeName = 'sp_human', spriteName = entity:GetConfig('small_icon')});
    end]]
end

function GuildBossFightManager:SetMainHeroAI(ai_id)
    FightManager.SetMainHeroAI(self, ai_id)
    if ai_id == self:GetMainHeroAutoFightAI() then
        local cfg = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1);
        local entity =  FightManager.GetMyCaptain();
        entity:SetPatrolMovePath({{x=cfg.boss_born_pos.x,y=0,z=cfg.boss_born_pos.y}, });
    end
end

function GuildBossFightManager:OnDead(entity)
    if entity:IsBoss() and  GetMainUI() and GetMainUI():GetBossHeartHP() then
        local bossInfo = { {cur_hp = 0 } };
        GetMainUI():GetBossHeartHP():UpdateBossInfo( bossInfo );
    end
end

--倒计时
--[[function GuildBossFightManager:_SetTickTick()
    self.tickCount = g_dataCenter.worldBoss.nextTime - os.time();
    if self.tickTimer == nil then
        self.tickTimer = timer.create("FightManager.__ontick_callback", 1000, -1);
    end
end]]

function GuildBossFightManager:OnUiInitFinish()
    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0;
    local configIsSwitchTarget = cf.is_switch_target > 0;
    GetMainUI():InitWorldChat()
    GetMainUI():InitZouMaDeng()
    GetMainUI():InitOptionTip(true, configIsAuto)
    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget)
    GetMainUI():InitProgressBar()
    GetMainUI():InitTriggerOperator()
    GetMainUI():InitMMOFightUIClick();
    GetMainUI():InitTeamCanChange(true,false)
    GetMainUI():InitTimer()

    -- 将游戏开始的触发器延后在这里触发
    -- 防止界面还未加载完毕，就被触发器里的行为隐藏界面，导致界面查找不到节点等一系列问题
    app.log("#lhf #OnUiInitFinish"..debug.traceback());
    ObjectManager.SnapshootForeachObj(function (objname,obj)
        obj:OnFightStart()
    end)
    self:StartTime();
    --显示剧情的时候 就需要先把条件设置好
    self:CheckPassCondition();
    --没得剧情的关卡只能放在这通知剧情结束
    if not ScreenPlay.IsRun() then
        NoticeManager.Notice(ENUM.NoticeType.ScreenPlayOver, 0, true)
        self:EndScreePlay();
    else    
        ScreenPlay.SetCallback(function ()
        self:EndScreePlay();
        end);
    end
    local data = g_dataCenter.guildBoss;
    
    --boss血条
    GetMainUI():InitBossHeartHP();
    --排行榜
    GetMainUI():InitRank( data.curRankInfo, data:IsHaveOwn(), data.damage );
    
    GetMainUI():InitGuildBoss();
    
    --[[local mapParam = 
    {
        uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_stboss.assetbundle",
        uiMapBkTex = 'Texture',
        iconsParam = 
        {
            [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 90},
            [EMapEntityType.EBoss] = {nodeName = 'content'},
        },
        adjustAngle = 90,        

        sceneMapSizeName = 'scene_minimap',

        bigMapParam = {
            uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_map_stboss.assetbundle",
            uiMapBkTex = 'Texture',
            iconsParam = 
            {
                [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 90},
                [EMapEntityType.EBoss] = {nodeName = 'content'},
            },
            adjustAngle = 90,        

            sceneMapSizeName = 'scene_minimap'
        }
    }
    GetMainUI():InitMinimap(mapParam);]]
    GetMainUI():InitEnemyHp()
end

function GuildBossFightManager:MonsterBloodReduce(entity, attacker)
    if attacker:IsMyControl() and entity:IsBoss() and GetMainUI() then
        --GetMainUI():InitBosshp(2, entity:GetName());
    	if GetMainUI() and GetMainUI():GetBossHeartHP() then
    	    local bossInfo = { {
            cur_hp = entity:GetPropertyVal('cur_hp'),
            max_hp = entity:GetPropertyVal('max_hp'),
            name = entity.config.name,
             } };
    	    GetMainUI():GetBossHeartHP():UpdateBossInfo( bossInfo );
    	end
    end

end

function GuildBossFightManager:EntityReborn(entity)
    if entity:IsHero() then
        if not entity:IsMyControl() then
            entity:HideHP(true);
            if entity.ui_hp_new then
                entity.ui_hp_new:SetIsShow(true);
            end
        else
            entity:HideHP(false);
            entity:ShowHP(true)
        end
    else
        --精英怪也要显示出来
        if not entity:IsMonster() or (entity:IsCloseSuper() or entity:IsFarSuper()) then
            if entity.ui_hp then
                entity.ui_hp:Show(true);
            end
        end
    end
end

function GuildBossFightManager:gc_guild_boss_fight_report(type, boss_index, is_first_pass, is_killer)
    local bossList = ConfigManager._GetConfigTable(EConfigIndex.t_guild_boss_monster);
    if type==1 and boss_index ~= #bossList then
        self.reportTimeId = timer.create(self.bindfunc["on_report_time"],1000,-1);
        self._time = 3;
    end
end

function GuildBossFightManager:on_report_time()
    FloatTip.Float("距下一个首领刷新剩余"..self._time.."秒");
    self._time = self._time - 1;
    if self._time <= 0 then
        timer.stop(self.reportTimeId);
        self.reportTimeId = nil;
    end
end

function GuildBossFightManager:gc_sync_group_damage_scale_state()
    local isShow = g_dataCenter.guildBoss:GetGroupDamageScaleState();
    if GetMainUI() and GetMainUI():GetRank() then
        GetMainUI():GetRank():UpdateBuffState(isShow);
    end
end

--[[endregion]]