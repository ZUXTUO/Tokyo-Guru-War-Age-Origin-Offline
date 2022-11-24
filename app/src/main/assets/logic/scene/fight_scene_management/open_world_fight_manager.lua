--[[
region centamap_fight_manager.lua
date: 2016-2-23
time: 17:31:11
author: Nation
]]
OpenWorldFightManager = Class("OpenWorldFightManager", FightManager)

function OpenWorldFightManager.InitInstance()
	FightManager.InitInstance(OpenWorldFightManager)
	return OpenWorldFightManager
end

function OpenWorldFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function OpenWorldFightManager:InitData()
	FightManager.InitData(self);
	self.loadComplete = false;
	self.worldGid = FightScene.GetWorldGID();
	self.npcMapInfo = ConfigHelper.GetMapInf(self.worldGid,EMapInfType.npc)
	self.npcObjName = {};	-- 保存npc对象名字，用于查找关联npc对象
	self.TransmitMapInfo = ConfigHelper.GetMapInf(self.worldGid,EMapInfType.translation_point)
	self.myCaptain = nil;
	self.TransmitList = {};
end

function OpenWorldFightManager:RegistFunc()
    FightManager.RegistFunc(self)

    --self.bindfunc['gc_click_npc'] = Utility.bind_callback(self, self.gc_click_npc);
    self.bindfunc['gc_play_screenplay'] = Utility.bind_callback(self, self.gc_play_screenplay);
    self.bindfunc['gc_show_task_detail_info'] = Utility.bind_callback(self, self.gc_show_task_detail_info);
    self.bindfunc['on_transmit'] = Utility.bind_callback(self, self.on_transmit);
    self.bindfunc['on_npc_transmit'] = Utility.bind_callback(self, self.on_npc_transmit);
    NoticeManager.BeginListen(ENUM.NoticeType.GcPlayScreenplay, self.bindfunc["gc_play_screenplay"])
    NoticeManager.BeginListen(ENUM.NoticeType.GcShowTaskDeTailInfo, self.bindfunc["gc_show_task_detail_info"])
end

function OpenWorldFightManager:UnRegistFunc()
	NoticeManager.EndListen(ENUM.NoticeType.GcPlayScreenplay, self.bindfunc["gc_play_screenplay"])
    NoticeManager.EndListen(ENUM.NoticeType.GcShowTaskDeTailInfo, self.bindfunc["gc_show_task_detail_info"])

	FightManager.UnRegistFunc(self)
end

function OpenWorldFightManager:MsgRegist()
	-- PublicFunc.msg_regist(world_msg.gc_click_npc,self.bindfunc['gc_click_npc']);
	-- PublicFunc.msg_regist(world_msg.gc_play_screenplay,self.bindfunc['gc_play_screenplay']);
	-- PublicFunc.msg_regist(world_msg.gc_show_task_detail_info,self.bindfunc['gc_show_task_detail_info']);
end

function OpenWorldFightManager:MsgUnRegist()
	-- PublicFunc.msg_unregist(world_msg.gc_click_npc,self.bindfunc['gc_click_npc']);
	-- PublicFunc.msg_unregist(world_msg.gc_play_screenplay,self.bindfunc['gc_play_screenplay']);
	-- PublicFunc.msg_unregist(world_msg.gc_show_task_detail_info,self.bindfunc['gc_show_task_detail_info']);
end

function OpenWorldFightManager:GetHeroAssetFileList(out_file_list)
    -- out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function OpenWorldFightManager:GetNPCAssetFileList(out_file_list)
	--使用异步加载
	do return end

	-- if not self.npcMapInfo then return end;
	-- for k,v in pairs(self.npcMapInfo) do 
	-- 	local id = v.id;
	-- 	local path = ObjectManager.GetMMONpcModelFile(id);
	-- 	if path then
	-- 		out_file_list[path] = path;
	-- 	end
	-- end
end

function OpenWorldFightManager:GetItemAssetFileList(out_file_list)
	FightManager.GetItemAssetFileList(self, out_file_list)
	if not self.TransmitMapInfo then return end;
	for k,v in pairs(self.TransmitMapInfo) do
		local modelID = v.item_modelid;
        if modelID == 0 then
			modelID = 80002002;
		end
		local path = ObjectManager.GetItemModelFile(modelID);
		if path then
			out_file_list[path] = path;
		end
	end
end




function OpenWorldFightManager:GetUIAssetFileList(out_file_list)
	out_file_list["assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle"] = "assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle";

    FightManager.AddPreLoadRes(MMOMainUI.GetPlayerMenuRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetJoystickRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetSkillInputRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetMMOTaskTrackUIRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetProgressBarRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetMMOFightUIClickRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetWorldChatRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTeamUpgradeRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetEnemyHpRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetAutoPathFindingUIRes(), out_file_list)
end

function OpenWorldFightManager:LoadSceneObject()
	self:LoadHero();
	self:LoadTransmit();
	self:LoadMonster();
	self:LoadItem();
	self:LoadNPC();
	self:LoadUI();
	self:LoadFinish();
	self:checkUpdateNpcTag();
end

function OpenWorldFightManager:LoadHero()
end

function OpenWorldFightManager:LoadTransmit()
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

function OpenWorldFightManager:LoadNPC()
	if not self.npcMapInfo then return end;
	for k,v in pairs(self.npcMapInfo) do 
		local id = v.id;
		local flag = 1;
		local obj = FightScene.CreateMMONPCAsync(id,flag);
		local pos = {};
		local cfg = ConfigManager.Get(EConfigIndex.t_npc_data,id);
		-- local npcID = ConfigManager.Get(EConfigIndex.t_npc_data,id).default_screenplay_id;
		pos.x = v.px;
		pos.y = v.py;
		pos.z = v.pz;
		obj:SetPosition(pos.x,pos.y,pos.z);
		obj:SetRotation(0,v.ry,0,false);
		self.npcObjName[id] = obj.name;
		obj.__npcId = id;
	end
end

--加载Npc任务状态
function OpenWorldFightManager:LoadNpcTask()
	if not self.npcMapInfo then return end;
	local task_list = g_dataCenter.task:GetList();
	local npc_array = {}
	for id,task in pairs(task_list) do
		local config = ConfigManager.Get(EConfigIndex.t_task_data,task.task_id)
		if config then
			if task.task_state == -1 and config.accept_npc_id > 0 then
				if npc_array[config.accept_npc_id] == nil then
					npc_array[config.accept_npc_id] = {}
				end
				npc_array[config.accept_npc_id][task.task_state] = true
			end
			if task.task_state ~= -1 and config.complete_npc_id > 0 then
				if npc_array[config.complete_npc_id] == nil then
					npc_array[config.complete_npc_id] = {}
				end
				npc_array[config.complete_npc_id][task.task_state] = true
			end
		end
	end
	for k,v in pairs(self.npcObjName) do 
		if npc_array[k] then
			local npc = ObjectManager.GetObjectByName(v);
			if npc then
				local task_state = nil
				-- 完成
				if npc_array[k][1] then
					task_state = 1;
				elseif npc_array[k][0] then
					task_state = 0;
				elseif npc_array[k][2] then
					task_state = 2;
				elseif npc_array[k][-1] then
					task_state = -1;
				end
				app.log('=============  load   npc_id: '..k.."  name:"..v.."  task_state:"..task_state)
				npc.ui_hp:SetNpcTaskState(task_state)
			end
		end
	end
end

--加载Npc任务状态
function OpenWorldFightManager:UpdateNpcTask(task)
	if not self.npcMapInfo then return end;
	local task_id = task.task_id
	local config = ConfigManager.Get(EConfigIndex.t_task_data,task_id)
	local accept_npc_id = config.accept_npc_id
	local complete_npc_id = config.complete_npc_id

	local task_list = g_dataCenter.task:GetList();
	local other_same_accept_npc_state = {}
	local other_same_complete_npc_state = {}
	for k,v in pairs(task_list) do
		config = ConfigManager.Get(EConfigIndex.t_task_data,k)
		if  (v.task_state == -1 and config.accept_npc_id == accept_npc_id and accept_npc_id > 0) or 
			(v.task_state ~= -1 and config.accept_npc_id == complete_npc_id and complete_npc_id > 0) then
			other_same_accept_npc_state[v.task_state] = true
		end
		if  (v.task_state == -1 and config.complete_npc_id == accept_npc_id and accept_npc_id > 0) or 
			(v.task_state ~= -1 and config.complete_npc_id == complete_npc_id and complete_npc_id > 0) then
			other_same_complete_npc_state[v.task_state] = true
		end
	end

	local npc_name = nil;
	local npc = nil;
	npc_name = self.npcObjName[accept_npc_id]
	npc = ObjectManager.GetObjectByName(npc_name or "");
	if npc then
		local task_state = nil
		-- 完成
		if other_same_accept_npc_state[1] then
			task_state = 1;
		elseif other_same_accept_npc_state[0] then
			task_state = 0;
		elseif other_same_accept_npc_state[2] then
			task_state = 2;
		elseif other_same_accept_npc_state[-1] then
			task_state = -1;
		end
		app.log('===========  update  accept_npc_id:'..accept_npc_id..'  name:'..npc_name..'  task_state: '..tostring(task_state))
		npc.ui_hp:SetNpcTaskState(task_state)
	end
	
	npc_name = self.npcObjName[complete_npc_id]
	npc = ObjectManager.GetObjectByName(npc_name or "");
	if npc then
		local task_state = nil
		-- 完成
		if other_same_complete_npc_state[1] then
			task_state = 1;
		elseif other_same_complete_npc_state[0] then
			task_state = 0;
		elseif other_same_complete_npc_state[2] then
			task_state = 2;
		elseif other_same_complete_npc_state[-1] then
			task_state = -1;
		end
		app.log('===========  update  complete_npc_id:'..complete_npc_id..'  name:'..npc_name..'  task_state: '..tostring(task_state))
		npc.ui_hp:SetNpcTaskState(task_state)
	end

end

--更新当前地图的npc是否显示
function OpenWorldFightManager:checkUpdateNpcTag()
	if not self.npcMapInfo then return end;
    app.log(table.tostring(g_dataCenter.player_flag))
	for k,v in pairs(self.npcMapInfo) do 
		local id = v.id;
		local tag = v.condition;
		local name = self.npcObjName[id];
        local npc = ObjectManager.GetObjectByName(name);
		
		--npc配置本身的值
		local isShow  = v.condition_value
		--玩家身上的值
		if g_dataCenter.player_flag[tag] then
			isShow = g_dataCenter.player_flag[tag].value
		end
		--此处根据npc本身的标签和玩家身上的标签，来控制npc是显示还是影藏
		if isShow == 0 then
			npc:set_active(false);
		else
			npc:set_active(true);
		end
        app.log("npc "..id.." "..tag.." "..name.." "..isShow.." "..v.condition_value)
	end
end

function OpenWorldFightManager:OnLoadHero(entity)
	entity:HideHP(true);
	entity:CreateHpNew();
    if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        if g_dataCenter.fight_info:GetCaptainIndex() == nil and entity:IsCaptain() then
            g_dataCenter.player:ChangeCaptain(1, nil, false, true)
            self.myCaptain = g_dataCenter.fight_info:GetCaptain()
        else
            entity:SetAI(ENUM.EAI.FollowHero)
            GetMainUI():UpdateHeadData()
        end
    else
        entity:SetAI(115)
    end
end

function OpenWorldFightManager:SetHeroTeamAI()
end

function OpenWorldFightManager:TransmitTrigger(obj,cur_obj,param)
   -- app.log("obj="..tostring(obj).."param="..tostring(param))
    --app.log('OpenWorldFightManager:TransmitTrigger========== ')
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
        world_msg.cg_leave_open_world()
        self:FightOver(true);
    else
	    if not all_list or #all_list == 0 then
		    return;
	    end
	    local list = {};
	    local country_id = g_dataCenter.player.country_id
	    -- app.log("my country_id:"..country_id);
	    -- app.log("all传送点："..#all_list.."个。:"..table.tostring(all_list));
	    for i=1,#all_list do
		    if all_list[i].country_id == nil or all_list[i].country_id == 0 or all_list[i].country_id == country_id then
			    table.insert(list,all_list[i]);
		    end
	    end
        app.log('OpenWorldFightManager:TransmitTrigger==========1111 ' .. table.tostring(list))
	    if #list == 1 then
		    -- app.log("1 找到传送点："..#list.."个。请选择...");
            local src_pos = self.myCaptain:GetPosition()
		    world_msg.cg_trigger_translation_point(self.myCaptain:GetGID(),id,list[1].target_index, src_pos.x*PublicStruct.Coordinate_Scale, src_pos.z*PublicStruct.Coordinate_Scale, FightScene.GetWorldGID());
		    -- app.log("1 send:"..table.tostring({self.myCaptain:GetGID(),id,list[1].target_index}));
	    else
		    -- TODO: 选择传送点
		    local ui = uiManager:PushUi(EUI.MMOChoiceUI);
    		    local cur_country_id = ConfigManager.Get(EConfigIndex.t_world_info,self.worldGid).country_id;
		    -- app.log("找到传送点："..#list.."个。请选择...");
		    local btnList = {};
		    for i=1,6 do
			    local info = list[i];
			    if info then
				    btnList[i] = {};
				    btnList[i].lab = list[i].des;
				    if param and type(param) == "table" and param.is_npc == true then
					    btnList[i].callback = self.bindfunc["on_npc_transmit"];
					    btnList[i].param = {id=id, target_index=list[i].target_index, npc_id = param.npc_id};
				    else
					    btnList[i].callback = self.bindfunc["on_transmit"];
					    btnList[i].param = {id=id, target_index=list[i].target_index};
				    end
			    end
		    end
		    local name;
		    if cur_country_id == 0 or cur_country_id == nil then
    			    name = ConfigManager.Get(EConfigIndex.t_world_info,self.worldGid).name;
		    else
    			    name = ConfigManager.Get(EConfigIndex.t_country_info,cur_country_id).name;
		    end
            if ui then
		        ui:SetInfo("","当前所在位置:"..tostring(name),btnList);
            end
	    end
    end
end

-----------------移动到npc的位置
-- function OpenWorldFightManager:MoveCaptainToNpcId(npc_id)
-- 	local name = self.npcObjName[npc_id] or "";
-- 	local npc = ObjectManager.GetObjectByName(name);
-- 	if npc then
-- 		self:MoveCaptainToNpc(npc)
-- 	end
-- end

-----------------移动到npc的位置
function OpenWorldFightManager:MoveCaptainToNpc(npc)
	local pos = npc:GetPosition();
	if not pos then return end
	self:SetMovePos(pos.x, pos.y, pos.z);
	self:SetNpcID(npc.__npcId);
	if not self.myCaptain then return end
	self.myCaptain:SetHandleState(EHandleState.MMOMove);
end

function OpenWorldFightManager:SetTouchNpc(captain, npc_id, x, y, z)
	self:SetMovePos(x, y, z);
	self:SetNpcID(npc_id);
	captain:SetHandleState(EHandleState.MMOMove);
end

function OpenWorldFightManager:SetNpcID(id)
	self.npcID = id;
end

function OpenWorldFightManager:GetNpcID()
	return self.npcID;
end

function OpenWorldFightManager:SetMovePos(x,y,z)
	self.move_x,self.move_y,self.move_z = x,y,z
end

function OpenWorldFightManager:GetMovePos()
	return self.move_x,self.move_y,self.move_z;
end

function OpenWorldFightManager:TouchNpc()
	if not self.npcID then return end
	
	world_msg.cg_click_npc(self.myCaptain:GetGID(),self.npcID);
    app.log("self.npcID="..self.npcID)
	self:SetNpcID(nil);
end
-------------------------------

-- function OpenWorldFightManager:gc_click_npc(npc_id)
	
-- end

function OpenWorldFightManager:gc_play_screenplay(screenplay_id)
	app.log("播放剧情对话:"..tostring(screenplay_id));
	ScreenPlay.Play(screenplay_id);
end

function OpenWorldFightManager:gc_show_task_detail_info(task_id)
	app.log("开启任务:"..tostring(task_id));
	MMOTaskDialogUI.ShowUi(task_id);
end

function OpenWorldFightManager:on_transmit(param)
    local src_pos = self.myCaptain:GetPosition()
	world_msg.cg_trigger_translation_point(self.myCaptain:GetGID(),param.id,param.target_index, src_pos.x*PublicStruct.Coordinate_Scale, src_pos.z*PublicStruct.Coordinate_Scale, FightScene.GetWorldGID());
end

function OpenWorldFightManager:on_npc_transmit(param)
	local src_pos = self.myCaptain:GetPosition()
	world_msg.cg_trigger_npc_translation(self.myCaptain:GetGID(),param.id,param.target_index, src_pos.x*PublicStruct.Coordinate_Scale, src_pos.z*PublicStruct.Coordinate_Scale, param.npc_id);
end

function OpenWorldFightManager:OnUiInitFinish()

    app.log("OpenWorldFightManager ui 初始化完成");

    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0;
    local configIsSwitchTarget = cf.is_switch_target > 0;
    --GetMainUI():InitPlayerHead()
    --GetMainUI():InitPlayerMenu()
    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget);
    GetMainUI():InitTeamCanChange()
    --GetMainUI():InitMMOTaskTrackUI()
    GetMainUI():InitProgressBar()
    GetMainUI():InitMMOFightUIClick()
    GetMainUI():InitWorldChat()
    GetMainUI():InitZouMaDeng()
    GetMainUI():InitTeamUpgrade()
    GetMainUI():InitEnemyHp()
    GetMainUI():InitMMOPosExp()
    --自动寻路动画
    GetMainUI():InitAutoPathFindingUI()

    self.loadComplete = true
    self:LoadNpcTask()
end

function OpenWorldFightManager:IsLoadComplete()
	return self.loadComplete
end

function OpenWorldFightManager:OnStart()
end

function OpenWorldFightManager:GetPreLoadPolicy()
	return {preload_hero=false, preload_npc=false}
end

function OpenWorldFightManager:GetPreLoadTextureFileList(texture_file_list)

end

function OpenWorldFightManager:OnLoadMonster(entity)
	if entity:IsCloseSuper() or entity:IsFarSuper() or entity:IsBoss() then
		--entity.ui_hp:SetName(true, "[ff0000]<精英>[-]");
	else
		entity:HideHP(true);
	end
end

function OpenWorldFightManager:EntityReborn(entity)
	if entity:IsHero() then
		
	else
		--精英、boss怪也要显示出来
		if entity:IsMonster() 
			and (entity:IsCloseSuper() or entity:IsFarSuper() or entity:IsBoss()) then
			if entity then
		        entity:HideHP(true);
		    end
		end
	end
end
function OpenWorldFightManager:MonsterLoadFinish(entity)
	if entity.ui_hp then
		if entity:IsCloseSuper() or entity:IsFarSuper() then
			-- local list = entity:GetMaterial();
			-- for k, v in pairs(list) do
			-- 	v:set_material_float_with_name("_RimInten", 1);
			-- 	v:set_material_float_with_name("_RimAtten", 3);
			-- 	v:set_material_float_with_name("_RimThres", 1);
			-- 	v:set_material_color_with_name("_RimColor", 241/255, 1, 0, 1);
			-- end
			entity.ui_hp:OnlyShowName(true, "[ff0000]<精英>[-]");
		elseif entity:IsBoss() then
			entity.ui_hp:OnlyShowName(true, "[ff0000]<BOSS>[-]"..tostring(entity.config.name));
		end
	end
end
function OpenWorldFightManager:MonsterBloodReduce(entity, attacker)
	--受伤者不是自己  同时攻击者是我方阵营  同时攻击者是主角 才进行血条显示
	-- if entity:IsMyControl() or 
	-- 	not attacker:IsMyControl() or
	-- 	not attacker:IsCaptain() or 
 --        (attacker:GetAttackTarget() ~= entity)
	-- 	then
	-- 	return;
	-- end
	-- if GetMainUI() and GetMainUI():GetEnemyHp() then
	-- 	GetMainUI():GetEnemyHp():SetShowEntityName(entity.name);
	-- end
end

function OpenWorldFightManager:GetCreateEntityPolicy()
	return true, 0.1
end
--[[endregion]]