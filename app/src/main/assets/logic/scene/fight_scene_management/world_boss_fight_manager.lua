--[[
region world_boss_fight_manager.lua
date: 2015-11-12
time: 19:50:6
author: Nation
]]
WorldBossFightManager = Class("WorldBossFightManager", FightManager)

function WorldBossFightManager:InitData()
    self.hero_index = 0
    self.ai_changed_call_back = Utility.bind_callback(self, self.AIChangedCallback)
    
    PublicFunc.msg_regist("SceneEntity_SetAI_AutoPathFinding", self.ai_changed_call_back);
	FightManager.InitData(self)
end

function WorldBossFightManager.InitInstance()
	FightManager.InitInstance(WorldBossFightManager)
	return WorldBossFightManager
end

function WorldBossFightManager:ClearUpInstance()
    PublicFunc.msg_unregist("SceneEntity_SetAI_AutoPathFinding", self.ai_changed_call_back);
	FightManager.ClearUpInstance(self)
end

function WorldBossFightManager:LoadUI()
	FightManager.LoadUI(self)
end

function WorldBossFightManager:OnStart()
	FightManager.OnStart(self)
    Show3dText.SetShow(true);
    GInitWorldBossLuckAttack();
end



function WorldBossFightManager:LoadHero()
    return true
end

function WorldBossFightManager:SetMainHeroAI(ai_id)
    FightManager.SetMainHeroAI(self, ai_id)
    if ai_id == self:GetMainHeroAutoFightAI() then
        if g_dataCenter.worldBoss.curPosX and g_dataCenter.worldBoss.curPosY then
            local entity =  FightManager.GetMyCaptain();
            entity:SetPatrolMovePath({{x=g_dataCenter.worldBoss.curPosX,y=0,z=g_dataCenter.worldBoss.curPosY}, });
        end
    end
end
--[[function PvPCommonFightManager:LoadMonster()
    return true
end]]
function WorldBossFightManager:AIChangedCallback(id)
    if id == ENUM.EAI.MainHero then
        if self.npc_wait_captain then
            FightScene.GetFightManager():MoveCaptainToNpc(self.npc_wait_captain)
        end
    end
end

function WorldBossFightManager:OnLoadHero(entity)
    --世界boss跟mmo一样显示名字
    if not entity:IsMyControl() then
        entity:HideHP(true);
        entity:CreateHpNew();
    end
    entity:SetRebornTime(10);
    if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        self.hero_index = self.hero_index + 1
        if g_dataCenter.fight_info:GetCaptainIndex() == nil and not entity:IsDead() then
            g_dataCenter.player:ChangeCaptain(self.hero_index, nil, false, true)
        else
            entity:SetAI(ENUM.EAI.FollowHero)
            GetMainUI():UpdateHeadData();
        end

        local miniMap = GetMainUI():GetMinimap()
        if miniMap then
            local captainName = g_dataCenter.fight_info:GetCaptainName()
            if captainName == entity:GetName() then
                miniMap:AddPeople(entity, EMapEntityType.EMy, true);
            else
                miniMap:AddPeople(entity, EMapEntityType.EGreenHero, true);
            end
        end
    else
        entity:SetAI(115)
    end
    -- if entity:IsDead() and not entity:IsNpc() then
    --     entity:CheckReborn(0)
    -- end
end

function WorldBossFightManager:GetUIAssetFileList(out_file_list)
    FightManager.GetUIAssetFileList(self, out_file_list)
    out_file_list["assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle"] = "assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle";
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_minimap_boss.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_boss.assetbundle";
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_map_boss.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_map_boss.assetbundle"
    FightManager.AddPreLoadRes(MMOMainUI.GetWorldBossRankRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetWorldBossRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetMinimapRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetEnemyHpRes(), out_file_list)

end

function WorldBossFightManager:GetHeroAssetFileList(out_file_list)
    out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function WorldBossFightManager:GetNPCAssetFileList(out_file_list)
end

function WorldBossFightManager:FightOver(is_set_exit, is_forced_exit)
    if is_set_exit then
        local str = "退出后再次进入，将会再次消耗挑战次数，请确认是否退出？";
        local btn1 = {};
        btn1.str = "确定";
        btn1.func = function ()
            msg_world_boss.cg_leave_world_boss()
        end
        local btn2 = {};
        btn2.str = "取消";
        HintUI.SetAndShowHybrid(2, "", str, nil, btn1, btn2);
        return;
    end
    if is_set_exit or is_forced_exit then
        msg_world_boss.cg_leave_world_boss()
    end
    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end

function WorldBossFightManager:OnLoadMonster(entity)
    local name = entity.card.name;
    entity.ui_hp:SetName(true, string.format("[FF0000]%s[-]", name));
    if GetMainUI():GetMinimap() then
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EBoss, nil, {spriteNodeName = 'sp_human', spriteName = entity:GetConfig('small_icon')});
    end
    if GetMainUI() and GetMainUI():GetBossHeartHP() then
        local cfgId,bossLv = g_dataCenter.worldBoss:GetBossInfo();
        local bossInfo = {{
            cur_hp = entity:GetPropertyVal('cur_hp'), 
            max_hp = entity:GetPropertyVal('max_hp'), 
            name=name,
            level=bossLv,
        }};
        GetMainUI():GetBossHeartHP():UpdateBossInfo( bossInfo );
    end
    if GetMainUI() and GetMainUI():GetWorldBossRank() then
        GetMainUI():GetWorldBossRank():SetReviveUI(0);
    end
end

function WorldBossFightManager:OnDead(entity)
    if GetMainUI():GetMinimap() and entity:IsBoss() then
        GetMainUI():GetMinimap():DeletePeople(entity);
        GetMainUI():GetMinimap():DelSyncPosEntity(entity:GetGID())
    end 
end

--倒计时
--[[function WorldBossFightManager:_SetTickTick()
    self.tickCount = g_dataCenter.worldBoss.nextTime - os.time();
    if self.tickTimer == nil then
        self.tickTimer = timer.create("FightManager.__ontick_callback", 1000, -1);
    end
end]]

function WorldBossFightManager:OnUiInitFinish()
    GetMainUI():InitTeamCanChange(true, false)
    FightManager.OnUiInitFinish(self);
    local data = g_dataCenter.worldBoss;
    local cfgId,bossLv = data:GetBossInfo();
    
    local cfg = ConfigManager.Get(EConfigIndex.t_world_boss_system,cfgId);
    local bossConfigID = 0;
    if cfg then
	   bossConfigID = cfg.boss_info.id;
    end
    GetMainUI():InitBossHeartHP( bossConfigID, bossLv );
    --排行榜
    GetMainUI():InitWorldBossRank(data.rankInfo, data:IsHaveOwn(), data.demage, 0);
    --世界boss
    GetMainUI():InitWorldBoss();
    --小地图
    local mapParam = 
    {
        uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_boss.assetbundle",
        uiMapBkTex = 'Texture',
        iconsParam = 
        {
            [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 0},
            [EMapEntityType.EBoss] = {nodeName = 'sp_boss'},
            [EMapEntityType.EGreenHero] = {nodeName = 'sp_my_follow'},
            [EMapEntityType.ETranslationPoint] = {nodeName = 'sp_chuansongdian'},
        },
        adjustAngle = 0,        

        sceneMapSizeName = 'scene_minimap',

        loadedCallback = function (param, minimap)
            local ui = minimap.ui
            local lab = ngui.find_label(ui, "lab_num")
            lab:set_active(false)
        end,

        bigMapParam = {
            uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_map_boss.assetbundle",
            uiMapBkTex = 'Texture',
            iconsParam = 
            {
                [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 0},
                [EMapEntityType.EBoss] = {nodeName = 'sp_boss'},
                [EMapEntityType.EGreenHero] = {nodeName = 'sp_green'},
                [EMapEntityType.ETranslationPoint] = {nodeName = 'sp_chuansongdian'},
            },
            adjustAngle = 0,        
            clickMove = true,
            sceneMapSizeName = 'scene_minimap',
            loadedCallback = function (param, minimap)
            local ui = minimap.ui
            local node = ui:get_child_by_name("sp_red")
            node:set_active(false)
        end,
        }
    }
    GetMainUI():InitMinimap(mapParam);
    --
    GetMainUI():InitEnemyHp()
    local npc_list = g_dataCenter.fight_info:GetNPCList(1)
    if npc_list then
        for k,v in pairs(npc_list) do
            local npc = ObjectManager.GetObjectByName(v)
            if npc and npc.config.country == g_dataCenter.player.country_id then
                GetMainUI():GetMinimap():AddPeople(npc, EMapEntityType.ETranslationPoint, false)
            end
        end
    end
    local cf = ConfigManager.Get(EConfigIndex.t_world_boss_system,g_dataCenter.worldBoss:GetBossInfo());
    self:SynFightLastTime(cf.player_time_limit);
end

function WorldBossFightManager:MonsterBloodReduce(entity, attacker)
    --攻击者如果是自己 同时被攻击方是boss显示原有血条
    if attacker:IsMyControl() and entity:IsBoss() and GetMainUI() then
        --GetMainUI():InitBosshp(2, entity:GetName());
    	if GetMainUI() and GetMainUI():GetBossHeartHP() then
            local curHP = entity:GetPropertyVal('cur_hp');
            if curHP > 0 then
        	    local bossInfo = { {cur_hp =  curHP} };
        	    GetMainUI():GetBossHeartHP():UpdateBossInfo( bossInfo );
            end
    	end
    end
    -- --受伤者不是自己  同时攻击者是我方阵营  同时攻击者是主角 才进行血条显示
    -- if entity:IsMyControl() or 
    --     not attacker:IsMyControl() or
    --     not attacker:IsCaptain() or
    --     entity:IsBoss() 
    --     then
    --     return;
    -- end
    -- if GetMainUI() and GetMainUI():GetEnemyHp() then
    --     GetMainUI():GetEnemyHp():SetShowEntityName(entity.name);
    -- end
end

function WorldBossFightManager:EntityReborn(entity)
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
            entity:HideHP(false);
        end
    end
end

--[[endregion]]