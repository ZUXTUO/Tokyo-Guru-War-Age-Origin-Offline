
TriggerEffect = 
{

}

function TriggerEffect.HandleEffect(triggerid, effect, otherObj, curObj, param)

	-- huhu 触发一下剧情的东西
	-- ScreenPlay.TriggerPlay(triggerid);


	-- app.log(string.format("trigger:%s, otherobj:%s, curObj:%s, parm: %s", effect, tostring(otherObj), tostring(curObj), tostring(param)))
	if effect ~= 0 then
        if TriggerEffect[effect] == nil  then
            app.log("trigger effect error! effectName=" .. tostring(effect))   
            return     
        end
		TriggerEffect[effect](otherObj, curObj, param); 
	end
end


function TriggerEffect.scene_entity_collide_trigger(target_entity, cur_entity)
	-- app.log("碰撞出发相应:"..table.tostring({obj=target_entity:GetName(), curObj=curObj:GetName()}))
    FightScene.GetFightManager():OnEvent_SceneEntityCollide(target_entity, cur_entity)
end

function TriggerEffect.add_buff_2_all_monster(target_entity, cur_entity, parm)
	FightScene.GetFightManager():AddBuff2AllMonster(parm[1], parm[2], parm[3])	
end

function TriggerEffect.delete_obj(target_entity, cur_entity, parm)
	-- app.log("移除对象："..table.tostring({target_entity, cur_entity, parm}))

	-- FightScene.DeleteObj(cur_entity:GetName(), parm[1])
	FightScene.DeleteObj(cur_entity:GetName(), 50)
end

function TriggerEffect.delete_target(target_entity, cur_entity, parm)
	if type(parm) == "table" then
		if parm[1] then
			FightScene.DeleteObj(target_entity:GetName(), parm[1])
			if FightScene.GetFightManager().OnRunAway then
				FightScene.GetFightManager():OnRunAway(target_entity:GetName(),parm[1]);
			end
		else
			FightScene.DeleteObj(target_entity:GetName(), 50)
			if FightScene.GetFightManager().OnRunAway then
				FightScene.GetFightManager():OnRunAway(target_entity:GetName(),50);
			end
		end
	else
		FightScene.DeleteObj(target_entity:GetName(), 50)
		if FightScene.GetFightManager().OnRunAway then
			FightScene.GetFightManager():OnRunAway(target_entity:GetName(),50);
		end
	end
end

-- function TriggerEffect.hide(target_entity, cur_entity, param)
-- 	cur_entity:GetObject():set_active(false)
-- end


function TriggerEffect.addHp(obj, curObj, param)
	if obj == nil or curObj == nil then
		return;
	end
	local max_hp = obj:GetPropertyVal('max_hp');
	local cur_hp = obj:GetHP();
	cur_hp = cur_hp + param[1] * max_hp + param[2];
	obj:SetProperty('cur_hp', cur_hp);
end
function TriggerEffect.addMaxHp(obj, curObj, param)
	if obj == nil or curObj == nil then
		return;
	end
	local max_hp = obj:GetPropertyVal('max_hp');
	max_hp = max_hp + param[1] * max_hp + param[2];
	obj:SetProperty('max_hp', max_hp);
end

function TriggerEffect.cameraHandle(obj, curObj, param)
	app.log('huhu_trigger_debug cameraHandle '..tostring(obj)..' '..tostring(curObj))
	if obj == nil or curObj == nil then
		return;
	end
	local objName = obj:GetName();
	if FightManager.GetMyCaptain() == nil then return; end;
	local playerName = FightManager.GetMyCaptain():GetName();
	if objName ~=  playerName then return; end;
	if not ConfigManager.Get(EConfigIndex.t_camera_angel,param[1]) then return; end;
	local t = ConfigManager.Get(EConfigIndex.t_camera_angel,param[1]);
	CameraManager.rotate_Camera(t.angleX,t.angleY,t.disZ,t.speedX,t.speedY,t.speedZ);
end

function TriggerEffect.cameraMove(obj, curObj, param)
	local objName = obj:GetName();
	if FightManager.GetMyCaptain() == nil then return; end;
	local playerName = FightManager.GetMyCaptain():GetName();
	if objName ~=  playerName then return; end;
	CameraManager.CameraMove(param[1])
end

function TriggerEffect.cameraMoveX(obj, curObj, param)
	local objName = obj:GetName();
	if FightManager.GetMyCaptain() == nil then return; end;
	local playerName = FightManager.GetMyCaptain():GetName();
	if objName ~=  playerName then return; end;
	CameraManager.CameraMoveX(param[1])
end

function TriggerEffect.changeToCamera(obj, curObj, param)
    CameraManager.TriggerChangeCamera(param)
end

function TriggerEffect.ChangeViewRadius(obj, curObj, param)
    --app.log('ChangeViewRadius ' .. table.tostring(param))

    for i = 1,#param,2 do
        if param[i + 1] == nil then
            break
        end

        local tid = param[i]
        local tViewRadius  = param[2]

        --app.log('xx ' .. tid .. ' ' .. tViewRadius)

        local objId = obj:GetConfig('id')
        if objId == tid then
            obj:SetConfig('view_radius', tViewRadius)

            --app.log('xx11 ' .. tid .. ' ' .. tViewRadius)
        end
    end
    
end

function TriggerEffect.RecordObjectFirstEnterTime(obj, curObj, param)
    FightScene.GetFightManager():OnEvent_ObjectEnterRecordTrigger(obj, curObj)
end

function TriggerEffect.frezon_monster(obj, curObj, parm)
    g_dataCenter.fight_info:foreach_obj(
        parm.flag,
        parm.monster_type,
        function (obj)
            obj:add_buff(buff_id )
        end
    )
end

-- TODO: (kevin) 技能系统相关。。。。。。带血条的‘冰箱’ 技能
function TriggerEffect.pub_obj_into_fridge(obj, target)
	-- TODO: (kevin) 预加载相关问题：
	if target == nil then
		app.log("TriggerEffect.pub_obj_into_fridge target == nil")
		return
	end

	local fridge = FightScene.CreateMonster(nil, 31000006, obj:GetCampFlag())	
	if nil == fridge then
		app.log("TriggerEffect.pub_obj_into_fridge fridge == nil")
		return
	end

	fridge:SetLocalPosition3f(target:GetLocalPosition3f())
	fridge:AttachBuff(1002, 1, nil, nil, nil, 0, nil, 0, 0, 0, nil, nil, false, nil)	
	target:AttachBuff(1001, 2, nil, nil, nil, 0, nil, 0, 0, 0, nil, nil, false, nil)	
	fridge:AddFrozenTarget(target:GetName())
end

function TriggerEffect.ShowHookBtn(target_entity, cur_entity, parm)
	--app.log("进入触发器target_entity=="..target_entity:GetName().."   cur_entity=="..cur_entity:GetName());
	-- local triggerName = cur_entity:GetName();
	-- local pos = string.sub(triggerName,string.find(triggerName,"_",string.find(triggerName,"_")+1)+1,string.len(triggerName));
	
	-- pos = tonumber(pos);
	-- local ui = FightScene.GetFightManager().jiaotangqidao_fightui;
	-- if ui then
	-- 	local index = info:GetCurIndex();
	-- 	local isPray = info:GetIsPray(index);
	-- 	local enterStar = info:GetEnterJiaoTangIndex();
	-- 	if not isPray then
	-- 		local enemy = info:GetHeroInfo(enterStar,pos);
	-- 		if not enemy then
	-- 			local btn = ui.btn_hook_clone[pos];
	-- 			btn:set_active(true);
	-- 		end
	-- 	end
	-- end
end

function TriggerEffect.HideHookBtn(target_entity, cur_entity, parm)
	--app.log("出触发器target_entity=="..target_entity:GetName().."   cur_entity=="..cur_entity:GetName());
	-- local ui = FightScene.GetFightManager().jiaotangqidao_fightui;
	-- local triggerName = cur_entity:GetName();
	-- local pos = string.sub(triggerName,string.find(triggerName,"_",string.find(triggerName,"_")+1)+1,string.len(triggerName));
	-- pos = tonumber(pos);
	-- if ui then
	-- 	local btn = ui.btn_hook_clone[pos];
	-- 	btn:set_active(false);
	-- end
end

--眩晕
function TriggerEffect.Dizziness(target_entity, cur_entity, parm)
	--app.log("眩晕");
	cur_entity:GetObject():set_active(false);
	target_entity:AttachBuff(1000,4);
end

--降低移动速度
function TriggerEffect.SlowDown(target_entity, cur_entity, parm)
	--app.log("减速");
	cur_entity:GetObject():set_active(false);
	target_entity:AttachBuff(1001,1);
end

--降低防御力
function TriggerEffect.ReduceDefense(target_entity, cur_entity, parm)
	--app.log("减防");
	cur_entity:GetObject():set_active(false);
	target_entity:AttachBuff(1003,1);
end

--新手关卡引导光圈
function TriggerEffect.EnterGuideRegion(target_entity, cur_entity, parm)
	if FightScene.GetFightManager().OnEvent_EnterGuideRegion then
		FightScene.GetFightManager():OnEvent_EnterGuideRegion(target_entity, cur_entity, parm)
	end
end

function TriggerEffect.on_target_arrive_desination(target_entity, cur_entity, parm)
	if FightScene.GetFightManager().on_target_arrive_desination then
		FightScene.GetFightManager():on_target_arrive_desination(target_entity, cur_entity, parm)
	end
end

function TriggerEffect.on_touch_screen_play(target_entity, cur_entity, parm)
	--app.log("碰到了");
end

function TriggerEffect.send_trigger_msg(obj, curObj, param)
    if obj:IsMyControl() or obj:IsAIAgent() then
    	msg_fight.cg_trigger_world_item(curObj:GetGID(), obj:GetGID(), (param==1))
    end
end

function TriggerEffect.treasure_box_triger_enter(obj, curObj, param)
	local myobj = FightManager.GetMyCaptain();
	if myobj:GetGID() ~= obj:GetGID() then
		return
	end
	--app.log("进入范围"..curObj:GetGID().." "..obj:GetGID());
    local mainui = GetMainUI()
    if mainui then
	    mainui:GetWorldTreasureBox():on_enter_treasure_box(curObj);
    end
end
function TriggerEffect.treasure_box_triger_out(obj, curObj, param)
	local myobj = FightManager.GetMyCaptain();
	if myobj:GetGID() ~= obj:GetGID() then
		return
	end
	--app.log("出范围"..curObj:GetGID().." "..obj:GetGID());
    local mainui = GetMainUI()
    if mainui then
	    mainui:GetWorldTreasureBox():on_out_treasure_box(curObj);
    end
end

-- 战斗中开启技能
function TriggerEffect.OpenSkill(obj, param)
	if type(param) ~= "table" then return end
	for i, skill in ipairs(param) do
		if skill > 0 then
			if i == 1 then
            	obj:LearnSkill(skill, 1)
	        end
	        if i == 2 then
            	obj:LearnSkill(skill, 1)
	        end
	        if i == 3 then
            	obj:LearnSkill(skill, 1)
	        end
	        if i == 4 then
            	obj:LearnSkill(skill, 1)
	        end
	        if i == 5 then
            	obj:LearnSkill(skill, 1)
	        end
	        if i == 6 then
	            obj:LearnSkill(skill, 1)
	        end
		end
	end
end

function TriggerEffect.Transmit(obj,cur_obj,param)
	FightScene.GetFightManager():TransmitTrigger(obj,cur_obj,param);
end

-- 任务寻路到指定地点条件达成
function TriggerEffect.ArriveAt(obj, cur_obj, task_pos_id)
	local myobj = FightManager.GetMyCaptain();
	if myobj == nil or myobj:GetGID() ~= obj:GetGID() then
		return
	end

	local config = ConfigManager.Get(EConfigIndex.t_task_destination,task_pos_id);
	-- TODO: 检查当前任务是否有该类型任务
	if config then
		app.log("到达任务地点 task_pos:"..task_pos_id.." world_id:"..config.world_id.." x:"..config.x.." y:"..config.z)
		world_msg.cg_update_task_condition(10, tostring(task_pos_id));
	end
end

local function triggerCreateMonsterFunc(entity)
	if entity then
		NoticeManager.Notice(ENUM.NoticeType.TriggerCreateMonster, entity)
	end
end

function TriggerEffect.create_monster(obj, cur_obj, param)
    --app.log("create_monster param " .. table.tostring(param))

	if type(param) == 'table' then

		local curIndex = 1

		while true do
			local name = param[curIndex]
			local delayTime = param[curIndex + 1]
			-- local is_dead = param[curIndex + 2]

			if	name == nil then
				break
			end

			if type(delayTime) == 'number' then
				curIndex = curIndex + 2
			else
				curIndex = curIndex + 1

				delayTime = 0
			end

			--delayTime = 2000

			if delayTime > 0 then
				--app.log("#create#create_monster ======= 1")
				local config = LevelMapConfigHelper._GetMonsterBornPoint(name)
				if config then
					ObjectManager.DelayCreateMonsterFromMapinfoConfig(config, nil, delayTime/1000, triggerCreateMonsterFunc)
				else
					app.log("create_monster: read mapinfo node config error! name:" .. tostring(name))
				end
			else
				--app.log("#create#create_monster ======= 2")
				local config = LevelMapConfigHelper._GetMonsterBornPoint(name)
				if	config then
					local newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(config)
					triggerCreateMonsterFunc(newmonster)
				else
					app.log("create_monster: read mapinfo node config error! name:" .. tostring(name))
				end
			end
		end
	else
		--app.log("#create#create_monster ======= 3")
		local configName = param
		local config = LevelMapConfigHelper._GetMonsterBornPoint(configName)
		if config then
			local newmonster = PublicFunc.CreateMonsterFromMapinfoConfig(config)
			triggerCreateMonsterFunc(newmonster)
		else
			app.log("create_monster: read mapinfo node config error! name:" .. tostring(name))
		end
	end
end

function TriggerEffect.create_monster_around_target(target, selfObj, param)

	local createMonsterAround = function (target, mapInfoName)
		local config = LevelMapConfigHelper._GetMonsterBornPoint(mapInfoName)
		if config then
			local monster = PublicFunc.CreateMonsterFromMapinfoConfig(config)
			local pos = target:GetPositionV3d()
			local randomPos = AIC_GenerateRandomPosition(pos, monster:GetFaceDirV3d(), 1, 2, 360)
			monster:SetPosition(randomPos:GetX(), randomPos:GetY(), randomPos:GetZ())
		else
			app.log("create_obstacle: read mapinfo node config error! name:" .. tostring(mapInfoName))
		end
	end

	if type(param) == 'table' then
		for k,name in ipairs(param) do
			createMonsterAround(target, name)
		end
	else
		createMonsterAround(target, param)
	end
end

function TriggerEffect.create_obstacle(obj, cur_obj, param)

    --do return end
    
    local curIndex = 1;
    local is_dead = param[curIndex]
    local createObstacle = function (name)
		local poinits = LevelMapConfigHelper.GetAllMonsterBornPoints(name)

		if #poinits == 0 then
			app.log("create_obstacle: read mapinfo node config error! name:" .. tostring(name))
		end

		for k,config in ipairs(poinits) do
			local monster = PublicFunc.CreateMonsterFromMapinfoConfig(config)
			if monster then
				if is_dead == 1 then
					--app.log("#create# dead")
					monster:SetState(ESTATE.Dead)
				end
				monster:SetIsObstacle(true)
				--app.log("create_obstacle " .. table.tostring(monster:GetName()))
			end
		end
    end
    
	if type(param) == 'table' then
		for k,name in ipairs(param) do
			if type(name) == "string" then
				createObstacle(name)
			end
		end
	else
		createObstacle(param)
	end
end

function TriggerEffect.disable_obstacle(obj, cur_obj, param)
    if param == nil then return  end

    local instancesName = {}

    if type(param) == 'table' then
        for k,v in ipairs(param) do
            instancesName[v] = true
        end
    else
        instancesName[param] = true
    end

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and instancesName[obj:GetInstanceName()] then
                obj:PlayAnimate(EANI.die)
				obj:SetNavFlag(false, false)
            end
        end
    )
end

function TriggerEffect.show_monster(obj, cur_obj, param)
    local ids = {}
	if type(param) == 'table' then
		for k,id in ipairs(param) do
            ids[id] = true
		end
	else
        ids[param] = true
	end

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and ids[obj:GetConfigNumber()] then
                obj:Show(true)
            end
        end
    )
end

function TriggerEffect.hide_monster(obj, cur_obj, param)
    local ids = {}
	if type(param) == 'table' then
		for k,id in ipairs(param) do
            ids[id] = true
		end
	else
        ids[param] = true
	end

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and ids[obj:GetConfigNumber()] then
                obj:Show(false)
            end
        end
    )
end

-- param{instanceName, instanceName}
function TriggerEffect.can_be_attack(obj, cur_obj, param)
    local instanceName = {}
	if type(param) == 'table' then
		for k,v in ipairs(param) do
            instanceName[v] = true
		end
	else
        instanceName[param] = true
	end

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and instanceName[obj:GetInstanceName()] then
                obj:SetCanBeAttack(true)

                return false
            end
        end
    )
end

function TriggerEffect.can_not_be_attack(obj, cur_obj, param)
    local instanceName = {}
	if type(param) == 'table' then
		for k,v in ipairs(param) do
            instanceName[v] = true
		end
	else
        instanceName[param] = true
	end

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and instanceName[obj:GetInstanceName()] then
                obj:SetCanBeAttack(false)

                return false
            end
        end
    )
end

function TriggerEffect.hide_area_entity(obj, cur_obj, param)
    --hide_area_entity=类型(1英雄，2怪物)，半径,最大数量
    if cur_obj == nil or type(param)~= 'table' or #param < 2 then
        return
    end


    local layerMask = {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster};
    local pos = cur_obj:GetPosition()
    local searchtargets = algorthm.GetOverlapSphereRound(pos, param[2], PublicFunc.GetBitLShift(layerMask))

    if searchtargets then
        local count = 1
        for k,entity in ipairs(searchtargets) do
            if count > param[3] then
                break
            end
            if entity and entity:GetCampFlag() == param[1] then
                entity:Show(false)
                count = count + 1
            end
        end
        
    end
end

function TriggerEffect.kill_instance(obj, cur_obj, param)
    if param == nil then return  end

    local instancesName = {}

    if type(param) == 'table' then
        for k,v in ipairs(param) do
            instancesName[v] = true
        end
    else
        instancesName[param] = true
    end

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and instancesName[obj:GetInstanceName()] then
                
                obj:SetHP(0)
                obj:SetState(ESTATE.Die)
            end
        end
    )
end

-- param = {instanceName, animationName}
function TriggerEffect.play_aniamtion(obj, cur_obj, param)
    if type(param) ~= 'table' then return end

    local instanceName = param[1]
    local aniName = param[2]
    
	local names = PublicFunc.GetObjectNameByInstanceName(instanceName)
	for k,name in ipairs(names) do
		local obj = GetObj(name)
		if obj then
			obj:AnimationPlay(aniName)
		end
	end
end

-- param = {instanceName, animationName}
function TriggerEffect.play_animator(obj, cur_obj, param)
    if type(param) ~= 'table' then return end

    local instanceName = param[1]
    local aniName = param[2]
    
	local names = PublicFunc.GetObjectNameByInstanceName(instanceName)
	for k,name in ipairs(names) do
		local obj = GetObj(name)
		if obj then
			obj:AnimatorPlay(aniName)
		end
	end
end


local deleteInstance = function(instanceName)
	local objs = PublicFunc.GetObjectByInstanceName(instanceName)
	for k,v in ipairs(objs) do
		ObjectManager.DeleteObjByObj(v)
	end 
end
--param {instanceName, delayTime}
function TriggerEffect.delete_instance(obj, cur_obj, param)
    if type(param) ~= 'table' or type(param[1]) ~= 'string' then return end

	local index = 1
	local inc = 1
	while true do
		
		local instanceName = param[index]

		if instanceName == nil then
			break
		end

		local delayTime = param[index + 1]

		inc = 2

		if type(delayTime) ~= 'number' then
			delayTime = 0
			inc = 1
		end

		if delayTime > 0 then
			TimerManager.Add(deleteInstance, delayTime, 1, instanceName)
		else
			deleteInstance(instanceName)
		end

		index = index + inc
	end
end

function TriggerEffect.delete_trigger_by_ids(obj, curObj, param)
	local deleteIds = param
	if type(param) ~= 'table' then
		deleteIds = {param}
	end

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and obj:HasIdsTrigger(deleteIds) then
                ObjectManager.DeleteObj(obj:GetName())
            end
        end
    )

end

function TriggerEffect.hurdleDropSomething(other_obj, selfObj, param)
    if type(param) ~= 'number' or selfObj == nil then
        app.log('TriggerEffect.hurdleDropSomething param error')
        return        
    end

    local drop = ConfigManager.Get(EConfigIndex.t_drop_something,param);

    if drop == nil or #drop < 1 then
        app.log('TriggerEffect.hurdleDropSomething drop id error:' .. tostring(param))
        return  
    end

    local item = drop[1]
    local item = ConfigManager.Get(EConfigIndex.t_item,item.goods_id);
    if item == nil then
        app.log('TriggerEffect.hurdleDropSomething item id error:' .. tostring())
        return
    end

    FloatTip.Float("获得物品[" .. tostring(item.name) .. ']')

    FightScene.GetFightManager():AddOpenedBoxDropID(param)
end

-- param{buffid, bufflevel}
function TriggerEffect.AddBuff(target, selfObj, param)
    if not target then return end

    if type(param) == 'table' then

		local buffStartIndex = 1
		if type(param[1]) == 'string' then
			local objs = PublicFunc.GetObjectByInstanceName(param[1])
			if #objs > 0 then
				target = objs[1]
			end
			buffStartIndex = 2
		end

    	for i = buffStartIndex, #param, 2 do
    		if param[i] and param[i+1] then
    			target:AttachBuff(param[i],param[i+1], target:GetName(), target:GetName());
    		end
    	end
	elseif param == 0 then
		local cfg_id = selfObj:GetConfigId();
		if cfg_id then
			local cfg = ConfigManager.Get(EConfigIndex.t_world_item,cfg_id);
			if cfg then
				for k,buff in pairs(cfg.trigger_buff) do
					target:AttachBuff(buff.id,buff.lv, target:GetName(), target:GetName());
				end
			end
		end
    end
end

function TriggerEffect.DelBuff(target, selfObj, param)
    if not target then return end

    if type(param) == "table" then

		local buffStartIndex = 1
		if type(param[1]) == 'string' then
			local objs = PublicFunc.GetObjectByInstanceName(param[1])
			if #objs > 0 then
				target = objs[1]
			end
			buffStartIndex = 2
		end

    	for i = buffStartIndex, #param, 2 do
    		if param[i] and param[i+1] then
    			target:DetachBuff(param[i],param[i+1])
    		end
    	end
	elseif param == 0 then
		local cfg_id = selfObj:GetConfigId();
		if cfg_id then
			local cfg = ConfigManager.Get(EConfigIndex.t_world_item,cfg_id);
			if cfg then
				for k,buff in pairs(cfg.trigger_buff) do
					target:DetachBuff(buff.id,buff.lv);
				end
			end
		end
    end
end

function TriggerEffect.RemoveTeamMember(target, selfObj, param)
    local controlList = table.copy(g_dataCenter.fight_info:GetControlHeroList())

    for i = 2,3 do
        if controlList[i] then
            FightScene.DeleteObj(controlList[i])
        end
    end
    
    local mainui = GetMainUI()
    if mainui then
        mainui:UpdateHeadData()
    end
end

--param=instanceName
function TriggerEffect.AddInstanceToPlayerTeam(target, selfObj, param)
    local objs = PublicFunc.GetObjectByInstanceName(param)
    if #objs < 1 then
        return
    end
    --app.log("AddInstanceToPlayerTeam " .. objs[1]:GetName() )
    objs[1]:SetOwnerPlayerGID(g_dataCenter.player:GetGID())
    g_dataCenter.fight_info:AddHero(objs[1])

    local mainui = GetMainUI()
    if mainui then
        mainui:UpdateHeadData()
    end
    --app.log('1111111111')
end

-- param = {modelid, campflag, triggerid, effectid,instancename}
function TriggerEffect.create_item(target, selfObj, param)
	local item = FightScene.CreateItem(nil, param[1], param[2], param[3], param[4])
	local pos = target:GetPositionV3d()
	local randomPos = AIC_GenerateRandomPosition(pos, item:GetFaceDirV3d(), 1, 2, 360)
	item:SetPosition(randomPos:GetX(), randomPos:GetY(), randomPos:GetZ())

	if param[5] then
		item:SetInstanceName(tostring(param[5]))
	end
end

-- function TriggerEffect.take_item(target, selfObj, param)

-- 	local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
-- 	if com then
-- 		com:ShowOperatorUI()
-- 	else
-- 		app.log('missed triger operator ui!')
-- 	end
-- end

-- param = useTriggerTriggerID,useTriggerTriggerID...
function TriggerEffect.enter_use_position(target, selfObj, param)

	local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
	if com then
		if type(param) ~= 'table' then
			param = {param}
		end
		com:EnableOperatorUI(param, ETriggeUIOperatorType.UseItem)
	else
		app.log('missed triger operator ui!')
	end
end

function TriggerEffect.leave_use_position(target, selfObj, param)

	local com = GetMainUI():GetComponent(EMMOMainUICOM.MainUITriggerOperator)
	if com then
		com:DisableOperatorUI()
	else
		app.log('missed triger operator ui!')
	end
end

-- param=instanceName,param1,param2...
function TriggerEffect.player_enter(target, selfObj, param)
    local objs = PublicFunc.GetObjectByInstanceName(param[1])

	local newParam = {}
	local count = #param
	for i = 2,count do
		table.insert(newParam, param[i])
	end

	for k,obj in ipairs(objs) do
		obj:PostEvent(AIEvent.PlayerEnter, newParam)
	end
end

-- param=instanceName
function TriggerEffect.player_leave(target, selfObj, param)
    local objs = PublicFunc.GetObjectByInstanceName(param)

	for k,obj in ipairs(objs) do
		obj:PostEvent(AIEvent.PlayerLeave)
	end
end

-- param=instanceName1,instanceName2....
function TriggerEffect.show_instance(target, selfobj, param)

    local instanceNames = {}
	if type(param) == 'table' then
		for k,name in ipairs(param) do
            instanceNames[name] = true
		end
	else
        instanceNames[param] = true
	end
	
	local showObjs = {}
	local tipItemName = nil
    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and instanceNames[obj:GetInstanceName()] then
                obj:Show(true)

				table.insert(showObjs, obj)
				local has, effects = obj:HasTriggerEffect("player_enter")
				if has then
					tipItemName = obj:GetName()
					--g_dataCenter.fight_info:SetCurrentTipEntity(obj:GetName())


					effects = effects.player_enter
					if type(effects) == 'table' and effects[2] then
						local instacneName = effects[2]
						local objs = PublicFunc.GetObjectByInstanceName(instacneName)
						local obstacles = {}

						for k,obj in ipairs(objs) do
							if obj:GetIsObstacle() then
								table.insert(obstacles, obj:GetName())
							end
						end

						if #obstacles > 0 then
							g_dataCenter.fight_info:SetCurrentObstacle(obstacles)
						end
					end
				end

                NoticeManager.Notice(ENUM.NoticeType.TriggerShowInstance, obj)
            end
        end
    )

	if tipItemName then
		local showCount = #showObjs
		if showCount == 1 then
			g_dataCenter.fight_info:SetCurrentTipEntity(tipItemName)
		elseif showCount == 2 then
			for k,v in ipairs(showObjs) do
				local name = v:GetName()
				if name ~= tipItemName then
					g_dataCenter.fight_info:SetCurrentTipEntity(name)
					break
				end
			end
		else
			app.log("tip item exception case.............")
		end
	end
end

-- param=instanceName1,instanceName2....
function TriggerEffect.hide_instance(target, selfobj, param)
    local instanceNames = {}
	if type(param) == 'table' then
		for k,name in ipairs(param) do
            instanceNames[name] = true
		end
	else
        instanceNames[param] = true
	end

    ObjectManager.ForEachObj(
        function (name, obj)
            if obj and instanceNames[obj:GetInstanceName()] then
                obj:Show(false)
            end
        end
    )
end

--param = instanceName1, instanceName2 ..
function TriggerEffect.send_switch_open_msg(target, selfobj, param)

	local postfunc = function(name)
		local objs = PublicFunc.GetObjectByInstanceName(name)
		for k,v in ipairs(objs) do
			v:PostEvent(AIEvent.PlayerOpen, '__virtual_switch__')
		end
	end

	if type(param) == 'table' then
		for k,name in ipairs(param) do
            postfunc(name)
		end
	else
        postfunc(param)
	end	
end	

function TriggerEffect.look_at_pos(target, selfobj, param)
	local point = LevelMapConfigHelper.GetConfigByObjName(param)

	if point and point.px and point.py and point.pz then
		CameraManager.LookToPos(Vector3d:new({x = point.px, y = point.py, z = point.pz}))
	else
		app.log("TriggerEffect.LookAtPos config error! " .. tostring(param))
	end
end

function TriggerEffect.look_at_captain(target, selfobj, param)
	local new_captain = g_dataCenter.fight_info:GetCaptain()
	CameraManager.init_target(new_captain)
end


--[[
    id=1001,lv=3定时炸弹
    id=1001,lv=5手雷
    id=1001,lv=7液体/积水
    id=1001,lv=9井盖
    id=1001,lv=11油桶
    id=1001,lv=13电网
]]

--[[定时炸弹]]
function TriggerEffect.time_bomb(target, selfobj, param)
    ComptItem.SetBuffPara(selfobj, 1001, 3)
    ComptItem.Start(selfobj, {delayTime = param, aniTime = 1.21})
end

--[[区域手雷]]
function TriggerEffect.area_grenade(target, selfobj, param)
    ComptItem.Start(selfobj, {delayTime = param, aniTime = 1})
end

--[[液体/积水]]
--function TriggerEffect.liquid_water(target, selfobj, param)
--   selfobj:AttachBuff(1001, 7, selfobj:GetName(), selfobj:GetName())
--end

--[[井盖]]
--function TriggerEffect.well_lid(target, selfobj, param)
--    ComptItem.SetBuffPara(selfobj, 1001, 9)
--    ComptItem.Start(selfobj, 0, 0.84)
--end

--[[油桶]]
function TriggerEffect.oil_drum(target, selfobj, param)
    selfobj:AttachBuff(1001, 11, selfobj:GetName(), selfobj:GetName())
end

--[[电网]]
function TriggerEffect.power_grid(target, selfobj, param)
    selfobj:AttachBuff(1001, 13, selfobj:GetName(), selfobj:GetName())
end

--[[显示采集按钮]]
-- param[1]=是否显示 1显示2不显示
function TriggerEffect.show_collect_btn(target, selfObj, param)
	if GetMainUI() and GetMainUI():GetHurdleCollectBoxUi() then
		if type(param) == "number" then
			GetMainUI():GetHurdleCollectBoxUi():ShowBtn(param==1,selfObj);
		else
			GetMainUI():GetHurdleCollectBoxUi():ShowBtn(param[1]==1,selfObj);
		end
	end
end

function TriggerEffect.record_times_by_have_buff(target, selfObj, param)
	if type(param) ~= "table" then
		return;
	end
	if not target then
		return;
	end
	local buffManager = target:GetBuffManager();
	if not buffManager then
		return;
	end
	if buffManager:GetBuff(param[1], param[2]) then
		FightRecord.RecordTimes(target:GetCampFlag());
	end
end

function TriggerEffect.record_times_by_is_move(target, selfObj, param)
	if not target then
		return;
	end
	if target:IsInPosMove() then
		FightRecord.RecordTimes(target:GetCampFlag());
	end
end

--[[气泡]]
function TriggerEffect.speak_bubble( obj, cur_obj, param )
	app.log("TriggerEffect.speak_bubble:" .. table.tostring(param));

	if type(param) ~= 'table' then return end
	local createFun = function (configName)					    
						local names = PublicFunc.GetObjectNameByInstanceName(configName)
						for k,name in ipairs(names) do
							local obj = GetObj(name)
							if obj then
								obj:PlaySpeakByid(param[1]);
							end
						end
					end

	if tonumber(param[2]) and tonumber(param[2]) ~= 0 then
		TimerManager.Add(createFun, tonumber(param[2]), 1, param[3]);	
	else
		createFun(nil, param[3])
	end
end


-- {npc实例名,进入战斗多少秒之后返回逃跑,血量低于多少过后逃跑,刷出来的怪物分组,刷出来怪物数量少于多少的时候继续逃跑}
function TriggerEffect.post_enter_fight_event(target, selfobj, param)

	if type(param) ~= 'table' then 
		app.log('post_enter_fight_event param error,need table')
		return
	end

	local objs = PublicFunc.GetObjectByInstanceName(param[1])
	for k,obj in ipairs(objs) do
		obj:PostEvent(AIEvent.EnterFight)
		if type(param[2]) == 'number' and param[2] > 0 then
			obj:SetHFSMKeyValue("return_escape_time", param[2]/1000)
		else
			obj:SetHFSMKeyValue("return_escape_time", nil)
		end
		if type(param[3]) == 'number' and param[3] > 0 then
			obj:SetHFSMKeyValue("return_escape_hp_percent", param[3])
		else
			obj:SetHFSMKeyValue("return_escape_hp_percent", nil)
		end
		obj:SetHFSMKeyValue("refresh_monster_group", param[4])
		obj:SetHFSMKeyValue("refresh_has_dead_count_escape", param[5])
	end	
end

-- {npc实例名, 战斗结果过后等待多少时间(ms)继续前进}
function TriggerEffect.post_dangerous_event(target, selfObj, param)

	if type(param) ~= 'table' then 
		app.log('post_enter_fight_event param error,need table')
		return
	end

	local objs = PublicFunc.GetObjectByInstanceName(param[1])
	for k,obj in ipairs(objs) do
		obj:PostEvent(AIEvent.Dangerous)
		if param[2] and param[2] > 0 then
			obj:SetHFSMKeyValue("fight_end_wait_time", param[2]/1000)
		else
			obj:SetHFSMKeyValue("fight_end_wait_time", nil)
		end
		if param[3] and param[3] > 0 then
			obj:SetHFSMKeyValue("dangerous_wait_time", param[3]/1000)
		else
			obj:SetHFSMKeyValue("dangerous_wait_time", nil)
		end
	end	
end

-- param = {instance_name, 暂停多少时间}
function TriggerEffect.pause_time(target, selfObj, param)
	if type(param) ~= 'table' then 
		app.log('pause_time param error,need table')
		return
	end

	local objs = PublicFunc.GetObjectByInstanceName(param[1])
	local delayTime = param[2]
	if #objs < 1 or delayTime < 1  then return end

	local obj = objs[1]
	obj:PostEvent(AIEvent.PAUSE)

	local objName = obj:GetName()
	local resumeFunc = function ()
			local obj = GetObj(objName)
			if obj then
				obj:PostEvent(AIEvent.RESUME)
			end
		end

	TimerManager.Add(createFun, delayTime, 1)
end

--播一个ui音效
function TriggerEffect.PlayUiAudio(target, selfObj, param)
	if type(param) == 'table' then 
		AudioManager.PlayUiAudio(param[1])
	elseif type(param) == 'number' then
		AudioManager.PlayUiAudio(param)
	else
		app.log("TriggerEffect.PlayUiAudio param error")
	end
end

--播一个3d音效
function TriggerEffect.Play3dAudio(target, selfObj, param)
	local volScale = AudioManager.GetVolScaleBySceneEntity(target);
	local bind_pos = ConfigManager.Get(EConfigIndex.t_model_bind_pos,3)
    bind_pos = target.object:get_child_by_name(bind_pos.bind_pos_name)
	if type(param) == 'table' then 
		AudioManager.Play3dAudio(param[1], bind_pos, nil,nil,nil,nil,nil,nil,volScale)
	elseif type(param) == 'number' then
		AudioManager.Play3dAudio(param, bind_pos, nil,nil,nil,nil,nil,nil,volScale)
	else
		app.log("TriggerEffect.Play3dAudio param error")
	end
end

--param {站立多少时间(ms), 问号或者感叹号特效id, 对话id}
function TriggerEffect.patrol_stand_time(target, selfObj, param)

	if type(param) ~= 'table' then
		app.log("patrol_stand_time param error!")
		return
	end
	--app.log("#hyg#patrol_stand_time = " .. target:GetName() .. ' ' .. selfObj:GetName())
	local time = param[1]
	local fxid = param[2]
	local speakid = param[3]

	target:PostEvent(AIEvent.StandTime, time / 1000)

	local fxTime = nil
	if fxid and fxid ~= 0 then
		local cfg = ConfigManager.Get(EConfigIndex.t_effect_data, fxid)
		if cfg then
			target:SetEffect(nil, cfg)
			fxTime = 800
			local effCfg = ConfigManager.Get(EConfigIndex.t_all_effect, cfg.id[1])
			if effCfg and effCfg.time > 0 then
				fxTime = effCfg.time
			end
		else
			app.log("effect id error" .. tostring(fxid))
		end
	end

	if speakid and speakid ~= 0 then
		if fxTime and fxTime > 0 then
			local name = target:GetName()
			local callFunc = function()
				local obj = GetObj(name)
				if not obj then return end
				obj:PlaySpeakByid(speakid)		
			end

			TimerManager.Add(callFunc, fxTime, 1)
		else
			obj:PlaySpeakByid(speakid)	
		end
	end
end