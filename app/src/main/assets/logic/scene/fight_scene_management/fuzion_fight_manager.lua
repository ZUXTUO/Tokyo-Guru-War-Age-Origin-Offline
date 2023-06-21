-- region fuzion_fight_manager.lua
-- author: zzc
-- date: 2016-1-19

FuzionFightManager = Class("FuzionFightManager", FightManager)

EFuzionBuffIds =
{
    EKnown = 1230,
    EUnknown = 1231,
    EInternal = 1232,
}

function FuzionFightManager:InitData()
	FightManager.InitData(self)
    
    self.heroList = {}  -- UI界面统计血量用,使用gid做key值
end

function FuzionFightManager.InitInstance()
	FightManager.InitInstance(FuzionFightManager)
	return FuzionFightManager
end

function FuzionFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function FuzionFightManager:LoadUI()
	FightManager.LoadUI(self)
end

function FuzionFightManager:OnStart()
    self.canRecoverInFight = true
	FightManager.OnStart(self)
end

-- function FuzionFightManager:LoadHero()
--     return true
-- end

--[[function PvPCommonFightManager:LoadMonster()
    return true
end]]

function FuzionFightManager:OnLoadHero(entity)
    self.heroList[entity.gid] = entity
    if entity.owner_player_name then
        entity.ui_hp:SetName(true, entity.owner_player_name);
    else
        entity.ui_hp:SetName(true, entity.config.name);
    end
    if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        if g_dataCenter.fight_info:GetCaptainIndex() == nil then
            g_dataCenter.player:ChangeCaptain(1, nil, false, true)
        else
            entity:SetAI(ENUM.EAI.FollowHero)
            GetMainUI():UpdateHeadData();
        end

        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
    else
        entity:SetAI(115)

        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGRedHero);
    end
end

function FuzionFightManager:OnLoadItem(entity)

    local spName = {
        [EFuzionBuffIds.EKnown] = 'zd_buff_zengyi', 
        [EFuzionBuffIds.EUnknown] = 'zd_buff_weizhi'}

    local configId = entity:GetConfig('config_id')
    local item_data = ConfigManager.Get(EConfigIndex.t_world_item, configId)
    if item_data then
        local param = {spriteName = spName[item_data.buff_id]}
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EBuff, nil , param)
    end

end

-- 预加载战斗UI的玩家英雄头像texture
function FuzionFightManager:GetPreLoadTextureFileList(out_file_list)
    FightManager.GetPreLoadTextureFileList(self, out_file_list)

--     for i, v in ipairs(g_dataCenter.fuzion.showFighter) do
--         local config = ConfigHelper.GetRole(v.hero_id)
--         if config and config.small_icon then
--             out_file_list[config.small_icon] = config.small_icon;
--         end
--     end
end

function FuzionFightManager:GetHeroAssetFileList(out_file_list)
    for i, v in ipairs(g_dataCenter.fuzion.showFighter) do
        ObjectManager.GetHeroPreloadList(v.hero_id, out_file_list)
    end
    out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function FuzionFightManager:GetNPCAssetFileList(out_file_list)
end

function FuzionFightManager:GetUIAssetFileList(out_file_list)
    FightManager.GetUIAssetFileList(self, out_file_list)
    -- -- 加载倒计时UI资源
    -- local file1 = "assetbundles/prefabs/ui/fight/new_fight_ui_timer.assetbundle";
    -- local file2 = "assetbundles/prefabs/ui/fight/new_fight_ui_count_down.assetbundle";
    -- out_file_list[file1] = file1;
    -- out_file_list[file2] = file2;
    -- 大乱斗UI
    -- GetMainUI():InitFuzion();
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_minimap_daluandou.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_daluandou.assetbundle"
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_map_daluandou.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_map_daluandou.assetbundle"
    FightManager.AddPreLoadRes(MMOMainUI.GetTimerRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetWorldChatRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetDescriptionRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetOptionTipRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetJoystickRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetSkillInputRes(), out_file_list);
    FightManager.AddPreLoadRes(MMOMainUI.GetFuzionRes(), out_file_list);
    FightManager.AddPreLoadRes(NewFightUiCount.GetResList(), out_file_list);
    FightManager.AddPreLoadRes(ApertureManager.GetResList(), out_file_list);
end

-- 重写战斗结束逻辑
function FuzionFightManager:FightOver(is_set_exit, is_forced_exit)
    FightScene.StopAIAgentKeepAlive()
    -- nmsg_world_boss.cg_leave_world_boss(Socket.socketServer)
    --FightManager.FightOver(self, is_forced_exit)
    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end

function FuzionFightManager:OnFightOver()
    FightManager.OnFightOver(self)
end

function FuzionFightManager:LoadSceneObject()
    FightManager.LoadSceneObject(self)
end

function FuzionFightManager:OnLoadMonster(entity)
    local name = entity.card.name;
    entity.ui_hp:SetName(true, string.format("[FF0000]%s[-]", name));
    -- if FightUI.GetMinimap() then
    --     FightUI.GetMinimap():AddPeople(entity);
    -- end
end

function FuzionFightManager:OnDead(entity)

end

--重载倒计时（倒计时时间同步是在创建fighter之后，同步消息来之前不显示倒计时）
function FuzionFightManager:_SetTickTick(syncEndTime)
    -- 同步结束时间
    if syncEndTime then
        local endTime = g_dataCenter.fuzion.endTime
        self.tickCount = math.max(0, syncEndTime - system.time());
        self.tickEndTime = syncEndTime
        if self.tickTimer == nil then
            self.tickTimer = timer.create("FightManager.__ontick_callback", 1000, -1);
        end

        -- 显示倒计时，321开场倒计时会暂停timer导致时间显示不正确，等待结束后显示计时器
        -- timer.create("FuzionFightManager._ShowTimer", 1000, 1)
    end
end

-- function FuzionFightManager._ShowTimer()
--     if FightUI.GetTimer() then
--         FightUI.GetTimer():Show()
--     end
-- end

function FuzionFightManager:OnUiInitFinish()
    --FightManager.OnUiInitFinish(self);

	local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	local str = hurdle.tips_string;
	local time = hurdle.tips_last;

    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0
    local configIsSwitchTarget = cf.is_switch_target > 0;

    GetMainUI():InitTimer()
    GetMainUI():InitWorldChat()
    GetMainUI():InitZouMaDeng()
    GetMainUI():InitDescription(str, time)
    GetMainUI():InitOptionTip(true, configIsAuto)
    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget)
    GetMainUI():InitMMOFightUIClick();
    -- 大乱斗UI
    GetMainUI():InitFuzion();
    
    self:StartTime();


    local mapParam = 
    {
        uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_daluandou.assetbundle",
        uiMapBkTex = 'Texture',
        iconsParam = 
        {
            [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 180},
            [EMapEntityType.EGRedHero] = {nodeName = 'sp_red'},
            [EMapEntityType.EBuff] = {nodeName = 'sp'},
        },
        adjustAngle = 180,        

        sceneMapSizeName = 'scene_minimap',

        bigMapParam = {
            uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_map_daluandou.assetbundle",
            uiMapBkTex = 'Texture',
            iconsParam = 
            {
                [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 180},
                [EMapEntityType.EGRedHero] = {nodeName = 'sp_red'},
                [EMapEntityType.EBuff] = {nodeName = 'sp'},
            },
            adjustAngle = 180,        

            sceneMapSizeName = 'scene_minimap'
        }
    }
    GetMainUI():InitMinimap(mapParam);
end

function FuzionFightManager:IsOpenTimeAuto()
    return true, ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_timeAuto).data
end

function FuzionFightManager:GetMainHeroAutoFightAI()
    return ENUM.EAI.DaLuanDouAutoFight
end
--[[endregion]]