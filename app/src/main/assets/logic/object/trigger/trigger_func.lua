TriggerFunc = {
	npcObj = {}
}
script.run("logic/object/trigger/trigger_func_drama_kit.lua");
script.run("logic/object/trigger/trigger_func_drama.lua");

function TriggerFunc.FallDownGangJia(callback)
	-- 找到一个对象，加载，然后创建起来就OK了。
	-- TODO 动画还没有，先直接走了。
	callback();
end

function TriggerFunc.RunTask(callback,param)
    local task_id = param[1];
	-- TODO 弹出任务面板
	app.log("剧情触发，弹出任务面板:"..tostring(task_id))

	MMOTaskDialogUI.ShowUi(task_id);
    
	callback();
end

--离开传送的NPC对话UI的显示和绑定
function TriggerFunc.MMOTranslateAction(callback,  param_table )
    local country_id = tonumber(param_table[2])
    local _show_cancel = true
    local _msg = ""
    if country_id ~= 0 then
        if country_id == g_dataCenter.player.country_id then
            _msg = param_table[3]
        else
            _msg = param_table[4]
            _show_cancel = false
        end
    end

	local data = { msg = _msg, icon_path = param_table[5], npcid = param_table[6], show_cancel = _show_cancel };
	ScreenPlayTranslate.ShowTalk( data );
end

-- TODO 剧情触发事件，创建npc
function TriggerFunc.CreateNpcCome(callback,param)
    local npc_id = param[2];
    local speed_num = param[3];
    local next_time = param[4];
    local init_pos_x = param[5];
    local init_pos_y = param[6];
    local target_pos_x = param[7];
    local target_pos_y = param[8];
	app.log("剧情触发，创建npc跑过来:"..tostring(npc_id).." "..tostring(speed_num).." "..tostring(next_time))

	local objNpc = FightScene.CreateMMONPCAsync(npc_id,1);
    TriggerFunc.npcObj[npc_id] = objNpc;

    local myObjPos = FightManager.GetMyCaptain():GetPosition();

    objNpc:SetPosition(init_pos_x, 0, init_pos_y)
    app.log("pos="..table.tostring(myObjPos));
    objNpc.navMeshAgent:set_speed(speed_num)
    objNpc:SetDestination(target_pos_x, 0,target_pos_y)
    objNpc:SetState(ESTATE.Run)

    local taskTimer = timer.create("TriggerFunc.TimeCallback", next_time, 1)
end

-- TODO 剧情触发事件，删除npc
function TriggerFunc.DeleteNpcCome(callback,param)
    local npc_id = param[2];
    local speed_num = param[3];
    local next_time = param[4];
    local delay_time = param[5];
    local target_pos_x = param[6];
    local target_pos_y = param[7];
	app.log("剧情触发，删除npc跑走:"..tostring(npc_id).." "..tostring(speed_num).." "..tostring(next_time).." "..tostring(delay_time).." "..tostring(target_pos_x).." "..tostring(target_pos_y))
    local objNpc = TriggerFunc.npcObj[npc_id];

    function DeleteNpcComeCallback2()
        FightScene.DeleteObjByObj(objNpc);
    end

    function DeleteNpcComeCallback()
        objNpc.navMeshAgent:set_speed(speed_num)
        objNpc:SetDestination(target_pos_x, 0,target_pos_y)
        objNpc:SetState(ESTATE.Run)
        timer.create("DeleteNpcComeCallback2", next_time, 1)
    end
    timer.create("DeleteNpcComeCallback", delay_time, 1)
end

function TriggerFunc.TimeCallback()
    ScreenPlay.NextAction();
end

function TriggerFunc.NpcTranslate(callback,param)
    local translate_point_id = param[2];
    local npc_id = param[3];
    if not translate_point_id then return end
    FightScene.GetFightManager():TransmitTrigger(nil,nil,{is_npc=true,translate_point_id = translate_point_id, npc_id=npc_id});
    callback();
end



