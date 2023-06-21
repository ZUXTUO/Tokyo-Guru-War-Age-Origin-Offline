--[[
region world_boss_fight_manager.lua
date: 2015-11-12
time: 19:50:6
author: Nation
]]
ThreeToThreeFightManager = Class("ThreeToThreeFightManager", FightManager)

function ThreeToThreeFightManager.InitInstance()
	FightManager.InitInstance(ThreeToThreeFightManager)
	return ThreeToThreeFightManager
end

function ThreeToThreeFightManager:InitData()
    FightManager.InitData(self);

    self.canRecoverInFight = true
    self.add2MapEntityCache = {}
    self.teamSoulDataList = {}
    self.teamSoulDataList[g_dataCenter.fight_info.left_3v3_flag] = {--[[baseProperty={},--]] soulValue=0}
    self.teamSoulDataList[g_dataCenter.fight_info.right_3v3_flag] = {--[[baseProperty={},--]] soulValue=0}
    self.monsterGenSouls = {}
    self.towerConfig = {{},{}}
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree];
    self.maxVal = self.dataCenter:GetMaxSoul()
    local config = ConfigManager.Get(EConfigIndex.t_three_to_three_fight, 1)
    for i, data in pairs(config.left_boss_info) do
        self.monsterGenSouls[data.id] = data.val or 0
        self.towerConfig[1][data.id] = data.type
    end
    for i, data in pairs(config.right_boss_info) do
        self.monsterGenSouls[data.id] = data.val or 0
        self.towerConfig[2][data.id] = data.type
    end
    for i, data in pairs(config.left_monster_info) do
        self.monsterGenSouls[data.id] = data.val or 0
    end
    for i, data in pairs(config.right_monster_info) do
        self.monsterGenSouls[data.id] = data.val or 0
    end
    self.heroGenSoul = config.hero_soul or 0

    self.fighterCount = 0 --已初始化战斗英雄个数
    -- heroGid = 
    -- {
    --     newGid = 最后一次被击杀的entity gid编号
    --     newTime = 最后一次击杀时间
    --     continueCount = 当前连续击杀数
    -- }
    self.heroInfo = {{}, {}}
	--双方塔怪状态
    -- {
    --     type = 怪物id类型
    --     gid = entity gid编号
    --     dead = true/false
    -- }
	self.towerInfo = {{}, {}}
	self.tipsData = {}
	self.tipsTimer = nil

    self.loadedMainHero = false
    self.autoTime = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_timeAuto).data
end

function ThreeToThreeFightManager:RegistFunc()
	FightManager.RegistFunc(self)
    self.bindfunc['TipsTimerCallback'] = Utility.bind_callback(self, self.TipsTimerCallback);
    self.bindfunc['CreateWorldItem'] = Utility.bind_callback(self, self.CreateWorldItem);
    self.bindfunc['DeleteWorldObject'] = Utility.bind_callback(self, self.DeleteWorldObject);
	self.bindfunc['HeroEntityReborn'] = Utility.bind_callback(self, self.HeroEntityReborn);
	self.bindfunc['EntityUseSkill'] = Utility.bind_callback(self, self.EntityUseSkill);

    NoticeManager.BeginListen(ENUM.NoticeType.CreateWorldItem, self.bindfunc['CreateWorldItem'])
    NoticeManager.BeginListen(ENUM.NoticeType.DeleteWorldObject, self.bindfunc['DeleteWorldObject'])
    NoticeManager.BeginListen(ENUM.NoticeType.HeroEntityReborn, self.bindfunc['HeroEntityReborn'])
    NoticeManager.BeginListen(ENUM.NoticeType.EntityUseSkill, self.bindfunc['EntityUseSkill'])
end

function ThreeToThreeFightManager:UnRegistFunc()
    NoticeManager.EndListen(ENUM.NoticeType.CreateWorldItem, self.bindfunc['CreateWorldItem'])
    NoticeManager.EndListen(ENUM.NoticeType.DeleteWorldObject, self.bindfunc['DeleteWorldObject'])
    NoticeManager.EndListen(ENUM.NoticeType.HeroEntityReborn, self.bindfunc['HeroEntityReborn'])
    NoticeManager.EndListen(ENUM.NoticeType.EntityUseSkill, self.bindfunc['EntityUseSkill'])
    FightManager.UnRegistFunc(self)
end


function ThreeToThreeFightManager:OnLoadHero(entity)
    if entity.owner_player_name then
        entity.ui_hp:SetName(true, entity.owner_player_name);
    else
        entity.ui_hp:SetName(true, entity.config.name);
    end
    --设置ai路径
    --玩法ID修改后需要注意
    local cf = gd_hurdle_60103000_pathpoint;
    local path = {}
    for k, v in pairs(cf) do
        local n = tonumber(string.sub(v.obj_name, 5, 5));
        if n == entity:GetCampFlag() then
            table.insert(path, {x=v.px, y=v.py, z=v.pz});
            break;
        end
    end
    -- app.log("OnLoadHero..campFlag="..tostring(entity:GetCampFlag()).."..name="..tostring(entity:GetName()).."..path="..table.tostring(path));
    entity:SetPatrolMovePath(path);
    --设置操作玩家
    if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        if g_dataCenter.fight_info:GetCaptainIndex() == nil then
            g_dataCenter.player:ChangeCaptain(1, nil, false, true)
        else
            entity:SetAI(ENUM.EAI.FollowHero)
            GetMainUI():UpdateHeadData();
        end

        -- 重连时处于死亡状态
        if entity:IsDead() then
            if GetMainUI():GetTouchMoveCamera() then
                GetMainUI():GetTouchMoveCamera():SetTouchMoveEnable()
            end
        end

        self.loadedMainHero = true
    else
        entity:SetAI(115)
    end

    self.heroInfo[entity:GetCampFlag()][entity:GetGID()] = {newKilledId=0, newTime=0, continueCount=0, configId=entity:GetConfigNumber()}

    self:AddToMiniMap(entity, true)

    self:SaveHeroSoulProperty(entity)


    self.fighterCount = self.fighterCount + 1
    --加载完毕，战斗重连情况初始数据
    if self.fighterCount >= 6 and FightScene.is_loading_reconnect then
        local heroConfigIdInfo = {}
        for k, v in pairs(self.heroInfo) do
            for kk, vv in pairs(v) do
                heroConfigIdInfo[vv.configId] = vv
            end
        end
        local heroInfo = nil
        for i, data in pairs(self.dataCenter:GetKillInfoList()) do
            heroInfo = heroConfigIdInfo[data.roleId]
            if heroInfo then
                heroInfo.continueCount = data.continueKill or 0
            end
        end
    end
end

function ThreeToThreeFightManager:OnLoadMonster(entity)
    --app.log_warning('OnLoadMonster ' .. entity:GetName() .. ' ' .. entity:GetCampFlag())

    if entity:GetHP() <= 0 then return end

    if entity.type ~= ENUM.EMonsterType.BloodPool 
        and entity.type ~= ENUM.EMonsterType.Tower
        and entity.type ~= ENUM.EMonsterType.Basis then
        local cf = ConfigManager.Get(EConfigIndex.t_three_to_three_fight,1);
        if entity:GetCampFlag() == 1 then
            entity:SetPatrolMovePath({
                {x=cf.left_monster_position.end_x, y=0, z=cf.left_monster_position.end_y},
                });
        else 
            entity:SetPatrolMovePath({
                {x=cf.right_monster_position.end_x, y=0, z=cf.right_monster_position.end_y},
                });
        end
    end

    if entity:IsTower() then
        local camp = entity:GetCampFlag()
        local configId = entity:GetConfigNumber()
        local towerType = self.towerConfig[camp][configId]
        local skillDistance = entity:GetSkill(1):GetDistance()
        local pos = entity:GetPosition()
        table.insert(self.towerInfo[camp], {type=towerType or 0, gid=entity:GetGID(), dis=skillDistance, pos=pos, dead=false})
        
        -- PVP monster 创建后替换临时模型放到OnLoadMonster之后，下一帧创建
        local nextFrameFunc = function ()
            if not entity:IsDead() then
                entity:InitTowerAreaEffect()
            end
        end
        TimerManager.Add(nextFrameFunc, 1)

        if towerType == 1 then
            entity.ui_hp:SetName(true, "[E1B741FF]守卫[-]", 2)
        elseif towerType == 2 then
            entity.ui_hp:SetName(true, "[E95F3BFF]精英[-]", 2)
        end
    else
        if entity:IsBasis() then
            entity.ui_hp:SetName(true, "[EA0256FF]领主[-]", 2)
        end 
    end

    self:AddToMiniMap(entity, false)

    -- 隐藏泉水名字血条
    if entity:GetSubType() == ENUM.EMonsterType.BloodPool then
        entity.ui_hp:Show(false);
    end
end

function ThreeToThreeFightManager:DeleteWorldObject(entity)
    --移除buff
    if entity and entity:IsItem() and GetMainUI():GetMinimap() then
        GetMainUI():GetMinimap():DeletePeople(entity)
    end
end

function ThreeToThreeFightManager:CreateWorldItem(entity)
    local cfg_id = entity:GetConfigId()
    local cfg = ConfigManager.Get(EConfigIndex.t_world_item, cfg_id);
    if cfg and cfg.item_type == 1 then
        GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EAddHPBuff)
    end
end

function ThreeToThreeFightManager:HeroEntityReborn(entity)
    if entity == g_dataCenter.fight_info:GetCaptain() then
        CameraManager.init_target(entity)
    end
end

function ThreeToThreeFightManager:EntityUseSkill(entity, skillId, targetGID)
    if entity:IsTower() then
        local target = ObjectManager.GetObjectByGID(targetGID)
        if target then
            entity:ShowTowerLockTarget(target, true)
        else
            --app.log("防御塔没有找到target: "..tostring(targetGID))
        end
    end
end

function ThreeToThreeFightManager:AddToMiniMap(entity, isHero)

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

function ThreeToThreeFightManager:_AddToMiniMap(captain, entity, isHero)

    if isHero then

        if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
            GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EMy, true);
        else
            if captain:GetCampFlag() == entity:GetCampFlag() then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGreenHero)
            else
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGRedHero)
            end
        end
    else
        if captain:GetCampFlag() == entity:GetCampFlag() then
            if entity:GetType() == ENUM.EMonsterType.Tower then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGreenTower)
            elseif entity:GetType() == ENUM.EMonsterType.Basis then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EGreenBase)
            end
        else
            if entity:GetType() == ENUM.EMonsterType.Tower then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.ERedTower)
            elseif entity:GetType() == ENUM.EMonsterType.Basis then
                GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.ERedBase)
            end
        end
    end
end

function ThreeToThreeFightManager:OnLoadItem(entity)
    --app.log_warning('OnLoadItem ' .. entity:GetName() .. ' ' .. entity:GetCampFlag())
    -- GetMainUI():GetMinimap():AddPeople(entity, EMapEntityType.EAddHPBuff)
end

function ThreeToThreeFightManager:EntityReborn(entity)
    FightManager.EntityReborn(self, entity)
    if GetMainUI():GetMinimap() and entity:IsHero() then
        self:AddToMiniMap(entity, true)
    end
end

function ThreeToThreeFightManager:OnDead(entity)
    --app.log_warning('WorldBossFightManager: ' .. entity:GetName())
    if GetMainUI():GetMinimap() and (entity:IsMonster() or entity:IsHero()) then
        GetMainUI():GetMinimap():DeletePeople(entity);
    end
    -- 进入自由移动模式 
    if entity:IsHero() and entity == g_dataCenter.fight_info:GetCaptain() then
        -- local point = entity:GetPosition()
        -- CameraManager.LookToPos(Vector3d:new({x = point.x, y = point.y, z = point.z}))
        if GetMainUI():GetTouchMoveCamera() then
            GetMainUI():GetTouchMoveCamera():SetTouchMoveEnable()
        end
    end
end

function ThreeToThreeFightManager:OnEvent_ObjDead(killer, target)
    -- 记录基地死亡信息，剧情用到
	if target:IsBasis() then
		self.curDeadList["basis"] = target:GetName();

        --触发剧情表现镜头移动
        local obj = g_dataCenter.fight_info:GetCaptain();
        if obj then
            --胜利
            local flag = (target:GetCampFlag() ~= obj:GetCampFlag())
        
            self:SetConditionWinFlag(flag)
            self:PlaySuccessEffect();
        end
	end

    --魂值
    if killer and target then
        --英雄击杀，英雄被杀都要计算魂值
        if killer:IsHero() or target:IsHero() then
            local killerCamp = killer:GetCampFlag()

            -- 掉落魂值
            local dropSoulValue = nil
            if target:IsHero() then
                dropSoulValue = self.heroGenSoul
            else
                local id = target:GetConfigNumber()
                dropSoulValue = self.monsterGenSouls[id]
            end

            if dropSoulValue and dropSoulValue > 0 then
                self:AddTeamHeroSoulProperty(killerCamp, dropSoulValue, target)
            else
                app.log("配置掉落魂值为0：id="..tostring(target:GetConfigNumber()))
            end
        end
    end

    if killer and target and killer:IsHero() then
        local killerCamp = killer:GetCampFlag()
        local targetCamp = target:GetCampFlag()

        local newContinueKillCount = 0
        local towerKilledType = nil
        
        if killer:IsHero() then

            local heroInfo = self.heroInfo[killerCamp][killer:GetGID()]

            --击杀英雄
            if target:IsHero() then
                -- 终止目标的连续击杀计数
                local targetInfo = self.heroInfo[targetCamp][target:GetGID()]
                targetInfo.continueCount = 0

                heroInfo.newGid = target:GetGID()
                heroInfo.newTime = system.time()
                heroInfo.continueCount = heroInfo.continueCount + 1

                newContinueKillCount = heroInfo.continueCount
            elseif target:IsTower() then

                heroInfo.newGid = target:GetGID()
                heroInfo.newTime = system.time()

                for i, data in ipairs(self.towerInfo[targetCamp]) do
                    if data.gid == target:GetGID() then
                        towerKilledType = data.type
                        data.dead = true
                        break;
                    end
                end
            end

        else
            --击杀英雄
            if target:IsHero() then
                -- 终止目标的连续击杀计数
                local targetInfo = self.heroInfo[targetCamp][target:GetGID()]
                targetInfo.continueCount = 0

            elseif target:IsTower() then
                for i, data in ipairs(self.towerInfo[targetCamp]) do
                    if data.gid == target:GetGID() then
                        towerKilledType = data.type
                        data.dead = true
                        break;
                    end
                end
            end
        end


        -- 团灭状态更新
        local teamDead = false
        if target:IsHero() then
            teamDead = true
            for gid, targetInfo in pairs(self.heroInfo[targetCamp]) do
                local heroEntity = ObjectManager.GetObjectByGID(gid)
                if heroEntity and not heroEntity:IsDead() then
                    teamDead = false
                    break
                end
            end
        end

        if newContinueKillCount > 0 then
            local data = {type=1, left_rid=killer:GetConfigNumber(), right_rid=target:GetConfigNumber(), camp=killerCamp, kill_count=newContinueKillCount, killer_gid=killer:GetGID()}
            table.insert(self.tipsData, data)
        elseif towerKilledType then
            local data = {type=2, camp=killerCamp, tower_type=towerKilledType, left_rid=killer:GetConfigNumber(), right_rid=target:GetConfigNumber()}
            table.insert(self.tipsData, data)
        end

        if teamDead then
            local data = {type=2, camp=killerCamp}
            table.insert(self.tipsData, data)
        end

        if #self.tipsData > 0 then
            if self.tipsTimer then timer.stop(self.tipsTimer) end
            self.tipsTimer = timer.create(self.bindfunc["TipsTimerCallback"], 60, 1)
        end
    end
end

function ThreeToThreeFightManager:TipsTimerCallback()
	if self:IsFightOver() then return end

	local mergeIndex = {}
	--合并击杀数据, 连杀时不单独显示单杀
	local killer_gid = nil
	for i=#self.tipsData, 1, -1 do
		local data = self.tipsData[i]
		if data.killer_gid == nil then
			killer_gid = nil
		elseif data.killer_gid == killer_gid then
			table.insert(mergeIndex, i)
		else
			killer_gid = data.killer_gid
		end
	end

	for i, removeIndex in ipairs(mergeIndex) do
		table.remove(self.tipsData, removeIndex)
	end

	for i, data in ipairs(self.tipsData) do
		GetMainUI():GetMobaFightTips():AddMsg( PublicFunc.GetMobaKillMsgData(data, self.dataCenter:IsPlayerLeftSide()) )
	end

	self.tipsData = {}
	self.tipsTimer = nil
end

function ThreeToThreeFightManager:GetHeroAssetFileList(out_file_list)
    for i, v in ipairs(self.dataCenter:GetShowFighter()) do
        ObjectManager.GetHeroPreloadList(v.hero_id, out_file_list)
        self:_GetHeroEffectAssetFileList(out_file_list, v.hero_id)
    end
    out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function ThreeToThreeFightManager:GetNPCAssetFileList(out_file_list)
    local filepath = nil
    local effectIdList = {}
    for camp, cfg in pairs(self.towerConfig) do
        for id, tp in pairs(cfg) do
            filepath = ObjectManager.GetMonsterModelFile(id)
            if filepath then
                out_file_list[filepath] = filepath
            end
            --加载特效资源
            FightManager.GetMonsterEffectFileList(out_file_list, id, effectIdList);
        end
    end

    for id, val in pairs(self.monsterGenSouls) do
        filepath = ObjectManager.GetMonsterModelFile(id)
        if filepath then
            out_file_list[filepath] = filepath
        end
        --加载特效资源
        FightManager.GetMonsterEffectFileList(out_file_list, id, effectIdList);
    end
end

function ThreeToThreeFightManager:_GetHeroEffectAssetFileList(out_file_list, hero_id)
    --预加载技能特效
    local config = ConfigHelper.GetRole(hero_id)
    if config and config.spe_skill ~= 0 then
        local file_path = nil
        local skill_data = nil
        local effectIdList = {}
        for k,v in pairs(config.spe_skill) do 
            local skillInfo = ConfigManager.Get(EConfigIndex.t_skill_info, v[1])
            if skillInfo then
                if skillInfo.dlg_audio ~= 0 then
                    for kk, vv in pairs(skillInfo.dlg_audio) do
                        file_path = ConfigHelper.GetAudioPath(vv.id)
                        out_file_list[file_path] = file_path;
                    end
                end
                skillData = g_SkillData[v[1]]
                if skillData then
                    FightManager.GetEffectFileList(out_file_list,skillData.effect[1].buffid,skillData.effect[1].bufflv,effectIdList)
                end
            end
        end
    end
end

function ThreeToThreeFightManager:Update(deltaTime)
    FightManager.Update(self,deltaTime);

    if self.update_seq then
		self.update_seq = self.update_seq + 1
	else
		self.update_seq = 1
	end
	
	if self.update_seq % 2 == 1 then
		return
	end
    
    local captain = g_dataCenter.fight_info:GetCaptain()
	if captain == nil then return end

	local tower = nil
	local target = nil
    local pos = nil
    local real_dis = nil
	local is_enemy = nil
    local into_value = 0    --0/1/2 预警区外/预警区中/攻击区中
    for camp, info in pairs(self.towerInfo) do
		is_enemy = captain:GetCampFlag() ~= camp
        for i, v in pairs(info) do
            tower = ObjectManager.GetObjectByGID(v.gid)
            if tower and tower:IsTower() then
                --检查主控英雄是否进入预警范围(攻击范围+1)
                if is_enemy then
                    pos = captain:GetPosition()
                    real_dis = algorthm.GetDistance(v.pos.x, v.pos.z, pos.x, pos.z)
                    into_value = 0
                    if v.dis > real_dis - 2 and not captain:IsDead() then
                        if v.dis < real_dis then
                            into_value = 1
                        else
                            into_value = 2
                        end
                    end
                    tower:IntoTowerShowArea(captain, into_value)
                end

                --检查受击对象是否脱离攻击范围
				target = tower:GetTowerAttackTarget()
                if target and not target:IsDead() then
                    pos = target:GetPosition()
                    real_dis = algorthm.GetDistance(v.pos.x, v.pos.z, pos.x, pos.z)
                    if v.dis > real_dis then
                        tower:ShowTowerLockTarget(target, true)
                    else
                        tower:ShowTowerLockTarget(target, false)
                    end
                end
            end
        end
    end
end

function ThreeToThreeFightManager:LoadHero()
    return true
end

function ThreeToThreeFightManager:GetUIAssetFileList(out_file_list)
    FightManager.GetUIAssetFileList(self, out_file_list)

    FightManager.AddPreLoadRes(MMOMainUI.GetThreeToThreeRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTouchMoveCameraRes(), out_file_list)
    FightManager.AddPreLoadRes(FightStartUI.GetResList(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetMobaFightTipsRes(), out_file_list)
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_minimap_3v3.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_3v3.assetbundle"
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_map_3v3.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_map_3v3.assetbundle"
end

function ThreeToThreeFightManager:OnUiInitFinish()

	local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	local str = hurdle.tips_string;
	local time = hurdle.tips_last;

    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0;
    local configIsSwitchTarget = cf.is_switch_target > 0;
    local configIsShowStarTip = (cf.is_show_star_tip == 1)

    GetMainUI():InitTimer()
    GetMainUI():InitWorldChat()
    GetMainUI():InitZouMaDeng()
    GetMainUI():InitTouchMoveCamera()
    GetMainUI():InitDescription(str, time)
    GetMainUI():InitOptionTip(false, configIsAuto)
    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget)
    GetMainUI():InitProgressBar()
    GetMainUI():InitMobaFightTips()
    GetMainUI():InitCaptainRebornTip()
    
    local killCnt, deadCnt = self.dataCenter:GetScoreData()
    local getSoul, lostSoul = self.dataCenter:GetTeamSoulValue()
    GetMainUI():InitThreeToThree(killCnt, deadCnt, getSoul, lostSoul);
    GetMainUI():InitThreeHumanKillDetail()
    GetMainUI():InitMMOFightUIClick();
    local mapParam = 
    {
        uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_3v3.assetbundle",
        uiMapBkTex = 'Texture',
        iconsParam = 
        {
            [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = -90},
            [EMapEntityType.EGreenBase] = {nodeName = 'sp_huangguan1'},
            [EMapEntityType.ERedBase] = {nodeName = 'sp_huangguan2'},
            [EMapEntityType.EGreenHero] = {nodeName = 'sp_green'},
            [EMapEntityType.EGRedHero] = {nodeName = 'sp_red'},
            [EMapEntityType.EAddHPBuff] = {nodeName = 'sp_add'},
            [EMapEntityType.EGreenTower] = {nodeName = 'sp_green_buff'},
            [EMapEntityType.ERedTower] = {nodeName = 'sp_red_buff'},
        },
        adjustAngle = -90,        

        sceneMapSizeName = 'scene_minimap',

        bigMapParam = {
            uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_map_3v3.assetbundle",
            uiMapBkTex = 'Texture',
            iconsParam = 
            {
                [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = -90},
                [EMapEntityType.EGreenBase] = {nodeName = 'sp_huangguan1'},
                [EMapEntityType.ERedBase] = {nodeName = 'sp_huangguan2'},
                [EMapEntityType.EGreenHero] = {nodeName = 'sp_green'},
                [EMapEntityType.EGRedHero] = {nodeName = 'sp_red'},
                [EMapEntityType.EAddHPBuff] = {nodeName = 'sp_add'},
                [EMapEntityType.EGreenTower] = {nodeName = 'sp_green_buff'},
                [EMapEntityType.ERedTower] = {nodeName = 'sp_red_buff'},
            },
            adjustAngle = -90,        

            sceneMapSizeName = 'scene_minimap'
        }
    }
    GetMainUI():InitMinimap(mapParam);
    self:StartTime();
    self:RealStartFight();
    GetMainUI():GetMobaFightTips():SetLeftSide( self.dataCenter:IsPlayerLeftSide() )
end

function ThreeToThreeFightManager:FightOver(is_set_exit, is_forced_exit)
    UiLevelLoadingNew.Destroy() -- 强制退出loading
    FightManager.FightOver(self, is_set_exit, is_forced_exit) 
end

function ThreeToThreeFightManager:IsOpenTimeAuto()
    return self.loadedMainHero, self.autoTime;
end

--tType 0血池 1第一排塔 2第二排塔 以此类推
--campFlag 代表是左边还是有右边 entity:GetCampFlag()
function ThreeToThreeFightManager:GetNpcPos(tType, campFlag)
    local cf = ConfigManager.Get(EConfigIndex.t_three_to_three_fight,1);
    local info;
    if campFlag == g_dataCenter.fight_info.left_3v3_flag then
        info = cf.left_boss_info;
    else
        info = cf.right_boss_info;
    end
    local pos = {};
    if tType == 0 then
        for k, v in pairs(info) do
            local monster = ConfigManager.Get(EConfigIndex.t_monster_property,v.id);
            if monster.type == ENUM.EMonsterType.BloodPool then
                table.insert(pos, {x = v.x, y = v.y});
            end
        end
    else

        for k, v in pairs(info) do
            if v.type == tType then
                table.insert(pos, {x = v.x, y = v.y});
            end 
        end
    end
    return pos;
end

function ThreeToThreeFightManager:IsAutoSetPath()
    return false;
end

function ThreeToThreeFightManager:GetMainHeroAutoFightAI()
    return ENUM.EAI.ThreeVThreeAutoFight
end

function ThreeToThreeFightManager:GetMainHeroAutoFightViewAndActRadius()
    return 8,100
end

function ThreeToThreeFightManager:SaveHeroSoulProperty(entity)
    local campFlag = entity:GetCampFlag()
    local teamSoulData = self.teamSoulDataList[campFlag]
    if teamSoulData and not teamSoulData.init then
        teamSoulData.init = true
        teamSoulData.soulValue = self.dataCenter:GetTeamSoulValue(campFlag) or 0
    end
    -- self.teamSoulDataList[campFlag]["baseProperty"][entity:GetName()] = table.copy( entity:GetProperty() )
end

function ThreeToThreeFightManager:AddTeamHeroSoulProperty(campFlag, value, target)
    local teamSoulData = self.teamSoulDataList[campFlag]
    if teamSoulData then
        teamSoulData.soulValue = math.min(teamSoulData.soulValue + value, self.maxVal)
        self.dataCenter:SetTeamSoulValue(campFlag, teamSoulData.soulValue)
        -- local config = ConfigManager.Get(EConfigIndex.t_soul_value_property, teamSoulData.soulValue)
        -- for name, data in pairs(teamSoulData)  do
        --     local obj = ObjectManager.GetObjectByName(name)
        --     if obj then
        --         for k, v in pairs(data.baseProperty) do
        --             obj:SetProperty(k, v * (100 + config[k]) / 100)
        --         end
        --     end
        -- end

        -- 表现魂值获取效果
        if GetMainUI() and GetMainUI():GetThreeToThree() then
            OGM.GetGameObject("assetbundles/prefabs/fx/prefab/fx_ui/fx_hunzhi.assetbundle", function(gObject)
                local go = gObject:GetGameObject()
				local obj_Id = gObject:GetId()
				if not target.object then
					OGM.UnUse(obj_Id)
                    return
				end
				
                go:set_active(true)

				local x, y, z = target.object:get_position()
				local fight_camera = CameraManager.GetSceneCamera();
				local ui_camera = Root.get_ui_camera();
				local view_x, view_y, view_z = fight_camera:world_to_screen_point(x, y, z);
				view_z = 0;
				local ui_x, ui_y, ui_z = ui_camera:screen_to_world_point(view_x, view_y, view_z);
				go:set_position(ui_x, ui_y, ui_z)
				local fm_x,fm_y,fm_z = go:get_local_position()
				local t_x,t_y,t_z = GetMainUI():GetThreeToThree():GetProbarPos(campFlag)
				local tween = ngui.find_tween_position(go, go:get_name())
				tween:set_bezier(true,fm_x-math.random(30,100),fm_y+math.random(30,100),0,t_x+math.random(30,100),t_y-math.random(30,100),0)
				tween:set_from_postion(fm_x,fm_y,fm_z)
				tween:set_to_postion(t_x,t_y,t_z)
				tween:reset_to_begining()
				tween:play_foward()
				tween:clear_on_finished()
				
				tween:set_on_finished(Utility.create_callback( function()
					OGM.UnUse(obj_Id)
                    if GetMainUI() and GetMainUI():GetThreeToThree() then
    					local getSoul = self.teamSoulDataList[g_dataCenter.fight_info.left_3v3_flag].soulValue
                        local loseSoul = self.teamSoulDataList[g_dataCenter.fight_info.right_3v3_flag].soulValue
                        GetMainUI():GetThreeToThree():UpdateSoulData(getSoul, loseSoul)
                    end
				end ))
            end)            
		end
    end
end

--[[endregion]]