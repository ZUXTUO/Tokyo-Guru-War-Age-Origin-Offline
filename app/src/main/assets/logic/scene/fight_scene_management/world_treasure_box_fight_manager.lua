--[[
region world_treasure_box_fight_manager.lua
date: 2016-7-15
time: 19:21:53
author: Nation
]]
WorldTreasureBoxFightManager = Class("WorldTreasureBoxFightManager", FightManager)

function WorldTreasureBoxFightManager:InitData()
	FightManager.InitData(self)
	self.npcObjName = {};
	self.TransmitList = {}
end

function WorldTreasureBoxFightManager.InitInstance()
	FightManager.InitInstance(WorldTreasureBoxFightManager)
	return WorldTreasureBoxFightManager
end

function WorldTreasureBoxFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function WorldTreasureBoxFightManager:LoadHero()
    return true
end

function WorldTreasureBoxFightManager:OnLoadMonster(entity)
    FightManager.OnLoadMonster(self, entity)
    if not entity:IsBoss() then
        entity:HideHP(true);
    end
    return true
end

function WorldTreasureBoxFightManager:GetUIAssetFileList(out_file_list)
    --FightManager.GetUIAssetFileList(self, out_file_list)
    out_file_list["assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle"] = "assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle";
    out_file_list["assetbundles/prefabs/ui/new_fight/fight_ui_map_boss.assetbundle"] = "assetbundles/prefabs/ui/new_fight/fight_ui_map_boss.assetbundle"
    FightManager.AddPreLoadRes(MMOMainUI.GetWorldTreasureBoxRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetOptionTipRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTimerRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetWorldChatRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetSkillInputRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetJoystickRes(), out_file_list)
   	FightManager.AddPreLoadRes(MMOMainUI.GetProgressBarRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetEnemyHpRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetMMOPosExpRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetMMOFightUIClickRes(), out_file_list)
end

function WorldTreasureBoxFightManager:OnUiInitFinish()
	--FightManager.OnUiInitFinish(self);
    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0;
    local configIsSwitchTarget = cf.is_switch_target > 0;
    --GetMainUI():InitTimer()
    GetMainUI():InitOptionTip(true, false)
    GetMainUI():InitWorldChat()
    GetMainUI():InitWorldTreasureBox();

    -- local data = 
    -- {
    --     mapParam = {
    --         uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_map_boss.assetbundle",
    --         uiMapBkTex = 'Texture',
    --         iconsParam = 
    --         {
    --             [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 0},
    --             [EMapEntityType.EGreenHero] = {nodeName = 'sp_my_follow'},
    --             [EMapEntityType.EBoss] = {nodeName = 'content'},
    --             [EMapEntityType.ETranslationPoint] = {nodeName = 'sp_chuansongdian'},
    --         },
    --         adjustAngle = 0,        

    --         sceneMapSizeName = 'scene_minimap'
    --     }
    -- }
    -- GetMainUI():InitMMOPosExp(data);
    --小地图
    local mapParam = 
    {
        uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_minimap_boss.assetbundle",
        uiMapBkTex = 'Texture',
        iconsParam = 
        {
            [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 0},
            [EMapEntityType.EBoss] = {nodeName = 'content'},
            [EMapEntityType.EGreenHero] = {nodeName = 'sp_my_follow'},
            [EMapEntityType.ETranslationPoint] = {nodeName = 'sp_chuansongdian'},
        },
        adjustAngle = 0,        

        sceneMapSizeName = 'scene_minimap',

        bigMapParam = {
            uiPath = "assetbundles/prefabs/ui/new_fight/fight_ui_map_boss.assetbundle",
            uiMapBkTex = 'Texture',
            iconsParam = 
            {
                [EMapEntityType.EMy] = {nodeName = 'sp_arrows', adjustAngle = 0},
                [EMapEntityType.EBoss] = {nodeName = 'content'},
                [EMapEntityType.EGreenHero] = {nodeName = 'sp_my_follow'},
                [EMapEntityType.ETranslationPoint] = {nodeName = 'sp_chuansongdian'},
            },
            adjustAngle = 0,        
            clickMove = true,
            sceneMapSizeName = 'scene_minimap'
        }
    }
    GetMainUI():InitMinimap(mapParam);
    local miniMap = GetMainUI():GetMinimap()
    local npc_list = g_dataCenter.fight_info:GetNPCList(1)
    if npc_list then
        for k,v in pairs(npc_list) do
            local npc = ObjectManager.GetObjectByName(v)
            if npc and npc.config.country == g_dataCenter.player.country_id then
                miniMap:AddPeople(npc, EMapEntityType.ETranslationPoint, false)
            end
        end
    end

    --GetMainUI():InitPlayerHead()
    GetMainUI():InitSkillInput(configIsSwitchTarget)
    GetMainUI():InitZouMaDeng()
    GetMainUI():InitJoystick()
    GetMainUI():InitTeamCanChange(true, false)
    GetMainUI():InitProgressBar()
    GetMainUI():InitEnemyHp()
    GetMainUI():GetWorldTreasureBox():UpdateUi();
    GetMainUI():InitTimer()
    --fy加入点击事件
    GetMainUI():InitMMOFightUIClick();
    self:RealStartFight();
end

function WorldTreasureBoxFightManager:LoadSceneObject()
    self.TransmitMapInfo = ConfigHelper.GetMapInf(self:GetFightMapInfoID(), EMapInfType.translation_point)
    self.npcMapInfo = ConfigHelper.GetMapInf(self:GetFightMapInfoID(), EMapInfType.npc)
	self:LoadHero()
	self:LoadTransmit();
	self:LoadMonster()
	self:LoadItem()
	self:LoadNPC();
	self:LoadUI()
	self:LoadFinish();
end

function WorldTreasureBoxFightManager:StandardUILayout()
    local pos_exp_ui = GetMainUI():GetComponent(EMMOMainUICOM.MainUIMMOPosExp)
    if pos_exp_ui then
        local sp = ngui.find_sprite(pos_exp_ui.ui, 'left_top/animation/cont/sp_bk')
        local w = sp:get_width() or 0
        local h = sp:get_height() or 0
        local x, y, z = sp:get_position()
        local option_tip_ui = GetMainUI():GetComponent(EMMOMainUICOM.MainUIOptionTip);
        if option_tip_ui then
            --local sp = ngui.find_sprite(option_tip_ui.ui, 'left_top/left_top_other/btn_left_sp/left_sp1')
            --local _h = sp:get_height() or 0
            option_tip_ui:SetLocalPosition(0, -h + y - 5, 0);
        end
    end
end


function WorldTreasureBoxFightManager:LoadTransmit()
	if not self.TransmitMapInfo then return end;
	for k,v in pairs(self.TransmitMapInfo) do 
		local id = v.id;
		local triggerID = v.trigger_id;
		local modelID = v.item_modelid;
		local effectID = v.item_effectid;
		local obj = FightScene.CreateItem(nil,modelID,3,triggerID,effectID,nil,id);
		local pos = {};
		pos.x = v.px;
		pos.y = v.py;
		pos.z = v.pz;
		obj:SetPosition(pos.x,pos.y,pos.z, true, true);
		local info = ConfigManager.Get(EConfigIndex.t_translation_point,id);
		if info then
			self.TransmitList[id] = info.end_world_info;
		else
			app.log("没找到传送点配置，id："..id);
		end
		-- table.insert(self.TransmitList[triggerID],v);
	end
end

--fy:放到FightManager去了
--function WorldTreasureBoxFightManager:LoadNPC()
--	if not self.npcMapInfo then return end;
--	for k,v in pairs(self.npcMapInfo) do 
--		local id = v.id;
--		local flag = 1;
--		local obj = FightScene.CreateMMONPCAsync(id,flag);
--		local pos = {};
--		local cfg = ConfigManager.Get(EConfigIndex.t_npc_data,id);
--		-- local npcID = ConfigManager.Get(EConfigIndex.t_npc_data,id).default_screenplay_id;
--		pos.x = v.px;
--		pos.y = v.py;
--		pos.z = v.pz;
--		obj:SetPosition(pos.x,pos.y,pos.z);
--		obj:SetRotation(0,v.ry,0,false);
--		self.npcObjName[id] = obj.name;
--		obj.__npcId = id;
--	end
--end

function WorldTreasureBoxFightManager:GetHeroAssetFileList(out_file_list)
    out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function WorldTreasureBoxFightManager:GetNPCAssetFileList(out_file_list)
end

function WorldTreasureBoxFightManager:FightOver(is_set_exit, is_forced_exit)
    if is_set_exit or is_forced_exit then
        msg_world_treasure_box.cg_leave_world_treasure_box();
    end
    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end

function WorldTreasureBoxFightManager:EntityReborn(entity)
    if not entity:IsMyControl() then
        entity:HideHP(true);
        if entity.ui_hp_new then
            entity.ui_hp_new:SetIsShow(true);
        end
    else
        entity:HideHP(false);
        entity:ShowHP(true)
    end

end

function WorldTreasureBoxFightManager:OnLoadHero(entity)
    --世界boss跟mmo一样显示名字
    if not entity:IsMyControl() then
        entity:HideHP(true);
        entity:CreateHpNew();
    end
    if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        if g_dataCenter.fight_info:GetCaptainIndex() == nil and entity:IsCaptain() then
            g_dataCenter.player:ChangeCaptain(1, nil, false, true)
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
end

function WorldTreasureBoxFightManager:TransmitTrigger(obj,cur_obj,param)
   -- app.log("obj="..tostring(obj).."param="..tostring(param))
	local id, all_list;
	if param and type(param) == "table" and param.is_npc == true then
		id = param.translate_point_id;
		all_list = ConfigManager.Get(EConfigIndex.t_translation_point,id).end_world_info;
	else
		id = cur_obj.config.config_id;
		all_list = self.TransmitList[id];
		if not obj or g_dataCenter.fight_info:GetCaptainName() ~= obj:GetName() then
			return;
		end
	end
    if all_list == 0 then
        msg_world_treasure_box.cg_leave_world_treasure_box()
        self:FightOver(true);
    else
    end
end

function WorldTreasureBoxFightManager:MonsterBloodReduce(entity, attacker)
	--受伤者不是自己  同时攻击者是我方阵营  同时攻击者是主角 才进行血条显示
	if entity:IsMyControl() or 
		not attacker:IsMyControl() or
		not attacker:IsCaptain() or 
	 	(attacker:GetAttackTarget() ~= entity)
		then
		return;
	end
    if not entity:IsBoss() then
        entity:HideHP(false)
        entity:ShowHP(true)
    end
	if GetMainUI() and GetMainUI():GetEnemyHp() and not entity:IsHero() then
		GetMainUI():GetEnemyHp():SetShowEntityName(entity.name);
	end
end

function WorldTreasureBoxFightManager:OnStart()
    FightManager.OnStart(self)
    Show3dText.SetShow(true);
end
--[[endregion]]