Fuzion2FightManager = Class("Fuzion2FightManager", FightManager)

EFuzionBuffIds =
{
    EKnown = 1230,
    EUnknown = 1231,
    EInternal = 1232,
}

function Fuzion2FightManager:InitData()
	FightManager.InitData(self)
    
    self.heroList = {}  -- UI界面统计血量用,使用gid做key值
    self.isFirst = true;
end

function Fuzion2FightManager.InitInstance()
	FightManager.InitInstance(Fuzion2FightManager)
	return Fuzion2FightManager
end

function Fuzion2FightManager:RegistFunc()
    FightManager.RegistFunc(self)
    self.bindfunc['CreateWorldItem'] = Utility.bind_callback(self, self.CreateWorldItem);
    self.bindfunc['DeleteWorldObject'] = Utility.bind_callback(self, self.DeleteWorldObject);
    self.bindfunc['on_update_fighter_data'] = Utility.bind_callback(self, self.on_update_fighter_data);
    self.bindfunc["onReliveWorldFighter"] = Utility.bind_callback(self, self.onReliveWorldFighter);

    NoticeManager.BeginListen(ENUM.NoticeType.CreateWorldItem, self.bindfunc['CreateWorldItem'])
    NoticeManager.BeginListen(ENUM.NoticeType.DeleteWorldObject, self.bindfunc['DeleteWorldObject'])
    NoticeManager.BeginListen(ENUM.NoticeType.FuzionFighterData, self.bindfunc['on_update_fighter_data'])
    NoticeManager.BeginListen(ENUM.NoticeType.ReliveWorldFighter, self.bindfunc["onReliveWorldFighter"])
end

function Fuzion2FightManager:UnRegistFunc()
    NoticeManager.EndListen(ENUM.NoticeType.CreateWorldItem, self.bindfunc['CreateWorldItem'])
    NoticeManager.EndListen(ENUM.NoticeType.DeleteWorldObject, self.bindfunc['DeleteWorldObject'])
    NoticeManager.EndListen(ENUM.NoticeType.FuzionFighterData, self.bindfunc['on_update_fighter_data'])
    NoticeManager.EndListen(ENUM.NoticeType.ReliveWorldFighter, self.bindfunc["onReliveWorldFighter"])
    FightManager.UnRegistFunc(self)

end

function Fuzion2FightManager:OnStart()
    self.canRecoverInFight = true
	FightManager.OnStart(self)
end

function Fuzion2FightManager:OnLoadHero(entity)
    self.heroList[entity.gid] = entity
    if entity.owner_player_name then
        entity.ui_hp:SetName(true, entity.owner_player_name);
    else
        entity.ui_hp:SetName(true, entity.config.name);
    end
    if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        -- if g_dataCenter.fight_info:GetCaptainIndex() == nil then
        --g_dataCenter.player:ChangeCaptain(1, nil, false, true)
        -- else
            -- entity:SetAI(ENUM.EAI.FollowHero)
            -- GetMainUI():UpdateHeadData();
        -- end
        local index = g_dataCenter.fight_info:GetAliveCaptaion()
        if index ~= nil then
            g_dataCenter.player:ChangeCaptain(index, true, nil, self.isFirst);
            self.isFirst = false;
        end
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
    else
        if g_dataCenter.fight_info.ai_agent_target_gid[entity.gid] then
            entity:EnableBehavior(true)
        else
            entity:SetAI(115)
        end

        if GetMainUI():GetMinimap() then
            GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGRedHero, true);
        end
    end
end

function Fuzion2FightManager:OnLoadItem(entity)

    -- local spName = {
    --     [EFuzionBuffIds.EKnown] = 'zd_buff_zengyi', 
    --     [EFuzionBuffIds.EUnknown] = 'zd_buff_weizhi'}

    -- local configId = entity:GetConfig('config_id')
    -- local item_data = ConfigManager.Get(EConfigIndex.t_world_item, configId)
    -- if item_data then
    --     local param = {spriteName = spName[item_data.buff_id]}
    --     GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EBuff, nil , param)
    -- end

end

function Fuzion2FightManager:DeleteWorldObject(entity)
    --移除buff
    if entity and entity:IsItem() then
        GetMainUI():GetMinimap():DeletePeople(entity)
    end
end

function Fuzion2FightManager:CreateWorldItem(entity)
    local spName = {
        [EFuzionBuffIds.EKnown] = 'zd_buff_zengyi', 
        [EFuzionBuffIds.EUnknown] = 'zd_buff_weizhi'}

    local item_data = ConfigManager.Get(EConfigIndex.t_world_item, entity:GetConfigId())
    if item_data then
        local param = {spriteName = spName[item_data.buff_id]}
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EBuff, nil , param)
    end
end

function Fuzion2FightManager:onReliveWorldFighter(fighter)
    if fighter and fighter:IsMonster() then
        GetMainUI():GetMinimap():AddPeople(fighter, EMapEntityType.ESoldier)
    end
end

function Fuzion2FightManager:AddToMiniMap(entity, isHero)

    if not entity then return end

    local captain = g_dataCenter.fight_info:GetCaptain()
    if captain then

        if #self.add2MapEntityCache > 0 then
            for k,v in ipairs(self.add2MapEntityCache) do
                self:_AddToMiniMap(captain, v.entity, v.isHero)
            end

            self.add2MapEntityCache = {}
        end

        self:_AddToMiniMap(captain, entity, isHero)
    else
        table.insert(self.add2MapEntityCache, {entity = entity, isHero = isHero})
    end
end

function Fuzion2FightManager:GetHeroAssetFileList(out_file_list)
    for i, v in ipairs(g_dataCenter.fuzion2.playerList) do
        for k, vv in ipairs(v.HeroList) do
            ObjectManager.GetHeroPreloadList(vv, out_file_list)
        end
    end
    out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function Fuzion2FightManager:GetNPCAssetFileList(out_file_list)
end

function Fuzion2FightManager:GetOtherAssetFileList(out_file_list)
    FightManager.GetOtherAssetFileList(self, out_file_list);
    local cfgEnum = EConfigIndex.t_daluandou2_monster_refresh_position
    local monsnterCfgNum = ConfigManager.GetDataCount(cfgEnum);
    for i=1,monsnterCfgNum do
        local cfg = ConfigManager.Get(cfgEnum,i);
        ObjectManager.GetMonterPreloadList(cfg.monsterid, out_file_list);
    end
end

function Fuzion2FightManager:GetUIAssetFileList(out_file_list)
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
    FightManager.AddPreLoadRes(MMOMainUI.GetFuzion2Res(), out_file_list);
    FightManager.AddPreLoadRes(NewFightUiCount.GetResList(), out_file_list);
    FightManager.AddPreLoadRes(ApertureManager.GetResList(), out_file_list);
end

-- 重写战斗结束逻辑
function Fuzion2FightManager:FightOver(is_set_exit, is_forced_exit)
    if is_set_exit then
        local str = "退出后将无法再次进入本战斗，是否继续退出?";
        local btn1 = {};
        btn1.str = "确定";
        btn1.func = function ()
            msg_fight.cg_cancel_daluandou_fight(g_dataCenter.fuzion2.roomid) 
            self.isSetExit = true;
        end
        local btn2 = {};
        btn2.str = "取消";
        HintUI.SetAndShowHybrid(2, "", str, nil, btn1, btn2);
        return;
    end
    FightScene.StopAIAgentKeepAlive()
    NewFightUiCount.OnEnd()
    -- nmsg_world_boss.cg_leave_world_boss(Socket.socketServer)
    --FightManager.FightOver(self, is_forced_exit)
    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end

function Fuzion2FightManager:OnFightOver()
    if not self.isSetExit then
        ObjectManager.OnFightOver(true);
    end
    if not ScreenPlay.IsRun() then
        self:OnShowFightResultUI();
    else
        ScreenPlay.SetCallback(function ()
        self:OnShowFightResultUI();
        end);
    end
end

function Fuzion2FightManager:OnLoadMonster(entity)
    if entity:IsMonster() then
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.ESoldier)
        return;
    end
    local name = entity.card.name;
    entity.ui_hp:SetName(true, string.format("[FF0000]%s[-]", name));
    -- if FightUI.GetMinimap() then
    --     FightUI.GetMinimap():AddPeople(entity);
    -- end
end

function Fuzion2FightManager:OnDead(entity)
end

--重载倒计时（倒计时时间同步是在创建fighter之后，同步消息来之前不显示倒计时）
function Fuzion2FightManager:_SetTickTick(syncEndTime)
    -- 同步结束时间
    if syncEndTime then
        local endTime = g_dataCenter.fuzion2.endTime
        self.tickCount = math.max(0, syncEndTime - system.time());
        self.tickEndTime = syncEndTime
        if self.tickTimer == nil then
            self.tickTimer = timer.create("FightManager.__ontick_callback", 1000, -1);
        end

        -- 显示倒计时，321开场倒计时会暂停timer导致时间显示不正确，等待结束后显示计时器
        -- timer.create("Fuzion2FightManager._ShowTimer", 1000, 1)
    end
end

function Fuzion2FightManager:onForcedExit()
    msg_fight.cg_cancel_daluandou_fight(g_dataCenter.fuzion2.roomid);
end

function Fuzion2FightManager:OnUiInitFinish()
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
    -- GetMainUI():InitDescription(str, time)
    GetMainUI():InitOptionTip(false, configIsAuto)
    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget)

    -- 大乱斗UI
    -- GetMainUI():InitFuzion2();
    GetMainUI():InitMMOFightUIClick();
    GetMainUI():InitFightFuzionRank();
    GetMainUI():InitTeamFuzion2()
    GetMainUI():GetTeamFuzion2():SetPlayerList(g_dataCenter.fuzion2.playerList);
    GetMainUI():GetTeamFuzion2():SetCurHeroInfo(g_dataCenter.fuzion2:GetMyPlayerData());
    -- GetMainUI():InitFightFuzionTop()
    GetMainUI():GetFightFuzionRank():SetData(g_dataCenter.fuzion2.playerList);
    self:StartTime();
    self.buffTimeUI = Fuzion2BuffTimesUI:new();

    local mapParam = 
    {
        uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_daluandou.assetbundle",
        uiMapBkTex = 'Texture',
        iconsParam = 
        {
            [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 180},
            [EMapEntityType.EGRedHero] = {nodeName = 'sp_red_arrows', adjustAngle = 180},
            [EMapEntityType.EBuff] = {nodeName = 'sp'},
            [EMapEntityType.ESoldier] = {nodeName = 'sp_red'},
        },
        adjustAngle = 180,        

        sceneMapSizeName = 'scene_minimap',

        bigMapParam = {
            uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_map_daluandou.assetbundle",
            uiMapBkTex = 'Texture',
            iconsParam = 
            {
                [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 180},
                [EMapEntityType.EGRedHero] = {nodeName = 'sp_red_arrows', adjustAngle = 180},
                [EMapEntityType.EBuff] = {nodeName = 'sp'},
                [EMapEntityType.ESoldier] = {nodeName = 'sp_red'},
            },
            adjustAngle = 180,        

            sceneMapSizeName = 'scene_minimap'
        }
    }
    GetMainUI():InitMinimap(mapParam);
end

function Fuzion2FightManager:IsOpenTimeAuto()
    return true, ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_timeAuto).data
end

function Fuzion2FightManager:GetMainHeroAutoFightAI()
    return ENUM.EAI.DaLuanDouAutoFight
end

function Fuzion2FightManager:OnEvent_ObjDead(killer, target)
    if target:IsMyControl() then
        local fighter = g_dataCenter.fuzion2:GetMyPlayerData();
        local list = fighter.HeroList;
        if #list > fighter.dead then 
            NewFightUiCount.Start({need_pause=false});
        end
    end
    FightManager.OnEvent_ObjDead(self, killer, target);
end

function Fuzion2FightManager:Update(deltaTime )
    FightManager.Update(self, deltaTime);
    if self.buffTimeUI then
        self.buffTimeUI:Update();
    end
end

function Fuzion2FightManager:Destroy()
    if self.buffTimeUI then
        self.buffTimeUI:DestroyUi();
        self.buffTimeUI = nil;
    end
    FightManager.Destroy(self);
end

-------------------------------------网络回调-------------------------------------
--战斗者数据变化
function Fuzion2FightManager:on_update_fighter_data()
    local fighter = g_dataCenter.fuzion2:GetMyPlayerData();
    GetMainUI():GetFightFuzionRank():SetKillNum(fighter.kill);
    GetMainUI():GetFightFuzionRank():SetDeadNum(fighter.dead);
    local playerList = g_dataCenter.fuzion2.playerList;
    local surviveNum = 0;
    local rank = 1;
    for k,v in pairs(playerList) do
        local heroList = v.HeroList;
        if #heroList ~= v.dead then
            surviveNum = surviveNum + 1;
        end

        local flg=false;
        repeat 
            if fighter.surviveTime == 0 and v.surviveTime ~= 0 then
                flg = true;
                break;
            elseif fighter.surviveTime ~= 0 and v.surviveTime == 0 then
                flg = false;
                break;
            end
            if fighter.surviveTime > v.surviveTime then
                flg = true;
                break;
            elseif fighter.surviveTime < v.surviveTime then
                flg = false;
                break;
            end
            if fighter.kill > v.kill then
                flg = true;
                break;
            elseif fighter.kill < v.kill then
                flg = false;
                break;
            end
            if fighter.dead < v.dead then
                flg = true;
                break;
            elseif fighter.dead > v.dead then
                flg = false;
                break;
            end
        until true
        if not flg and fighter.playerid ~= v.playerid then
            rank = rank + 1;
        end
    end
    GetMainUI():GetFightFuzionRank():SetSurviveNum(surviveNum, 10);
    GetMainUI():GetFightFuzionRank():SetRank(rank);

    GetMainUI():GetFightFuzionRank():SetData(playerList);
end
