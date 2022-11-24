--[[
file	entity_state.lua
author	zouyou
time	2015.7.2
]]--

local bindID = 0
local BindAudioCallBack = function( callbackFunc, data)
	bindID = bindID + 1	
	local name = 'on_audio_load_bin_'..bindID
	
	local fn = function(parm1, parm2, parm3, parm4, parm5, parm6)
		--_G[name] = nil
		if data then
			return callbackFunc(data,parm1, parm2, parm3, parm4, parm5, parm6);
		else
			return callbackFunc(parm1, parm2, parm3, parm4, parm5, parm6);
		end
    end;	
    
    _G[name] = fn
	return name
end

EntityState = {
    Stand =
    {
        OnBegin = function(obj)
        -- if obj == g_dataCenter.fight_info:GetCaptain() then
        --     app.log("stand   "..debug.traceback());
        -- end
            obj:PlayAnimate(EANI.stand);
            obj:SetNavFlag(false, true);
			--obj.navMeshAgent:stop(true);
        end,
        OnUpdate = function(obj)
        end,
        OnEnd = function(obj)
        end,
    },

    Run =
    {
        OnBegin = function(obj)
            obj.lastPosX = nil;
			obj.lastPosZ = nil;
            obj.last_check_pos_time = nil
            obj.last_send_move_time = 0
            obj.send_move_msg = false
            obj.last_nav_dx = nil
            obj.last_nav_dz = nil
            obj.last_nav_dy = nil
            obj.arrive_des_pos = false;
            if obj:CheckStateValid(EHandleState.Move) then
                local aniId = obj:GetMoveAniId()
                local runCfg = nil
                if aniId == EANI.run then
                    runCfg = obj:GetRunActionEffectCfg();
                end
				obj:PlayAnimate(aniId,runCfg);
            else
                return
            end
            obj:SetNavFlag(true, false);
			obj:OnBeginMove()
            --obj:SetExternalArea("isReadyRun", true);
        end,
        OnUpdate = function(obj)
            local aniId = obj:GetMoveAniId()
            local navMeshObj = obj.navMeshAgent
            if  navMeshObj == nil then do return end end;
            if not obj:CheckStateValid(EHandleState.Move) then
                if obj:GetAniCtrler():getAni() == aniId then
                    obj:PlayAnimate(EANI.stand)
                end
                if obj.send_move_msg then
                    obj:TrySendStand()
                    obj.send_move_msg = false;
                end
                if obj:IsMyControl() then
                end
                do return end
            end
            
            if obj:GetAniCtrler():getAni() ~= aniId then
                local runCfg = nil
                if aniId == EANI.run then
                    runCfg = obj:GetRunActionEffectCfg();
                end
				obj:PlayAnimate(aniId,runCfg);
                obj:SetNavFlag(true, false);
                obj.last_nav_dx = nil
                obj.last_nav_dz = nil
                obj.last_nav_dy = nil
            end
			obj._buffManager:CheckRemove(eBuffPropertyType.RemoveOnMove)
            if obj:GetState() ~= ESTATE.Run then
                if obj.send_move_msg then
                    obj:TrySendStand()
                    obj.send_move_msg = false;
                end
                if obj:IsMyControl() then
                end
                return
            end
            if navMeshObj:get_enable() == false then
                if not obj:IsInPosMove() then
                    obj:SetNavFlag(true, false)
                    obj.last_nav_dx = nil
                    obj.last_nav_dz = nil
                    obj.last_nav_dy = nil
                else
                    if obj.send_move_msg then
                        obj:TrySendStand()
                        obj.send_move_msg = false;
                    end
                    return            
                end
            end
        	--local vx, vy, vz = obj.navMeshAgent:get_velocity();
        	-- if vx == 0 and vy == 0 and vz == 0 then
        		-- local readyRun = obj:GetExternalArea("isReadyRun");	
        		-- if readyRun == false then
	        		-- obj:SetState(ESTATE.Stand);
	        		-- return
        		-- end
        	-- else
        		-- obj:SetExternalArea("isReadyRun", false);
        	-- end
            local posX,posY,posZ = obj:GetDestination();
            --app.log_warning("目的地 x="..posX.." z="..posZ)
            
            if (obj.last_nav_dx == nil and obj.last_nav_dy == nil and obj.last_nav_dz == nil) or (obj.last_nav_dx ~= posX or obj.last_nav_dz ~= posZ or obj.last_nav_dy ~= posY) then
    	        if PublicFunc.CheckCanUseNavMeshOperation(obj, true) then
                    navMeshObj:set_destination(posX, posY, posZ);
                    obj.last_nav_dx = posX
                    obj.last_nav_dz = posZ
                    obj.last_nav_dy = posY
                end
            end
            --send msg;
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                local x,y,z = obj:GetLocalPosition3f()
                if not obj:IsMyControl() and not obj:IsAIAgent() and ((x-posX)*(x-posX) + (z-posZ)*(z-posZ) < 0.1) then
                    if obj.fix_move then
                        obj:SetDestination(obj.fix_move.x, 0, obj.fix_move.y)
                        obj.fix_move = nil
                        if obj.navMeshAgent then
                            obj.navMeshAgent:set_speed(obj.speed_from_server)
                        end
                    else
                        obj:SetState(ESTATE.Stand)
                    end
                    return
                else
                    
                    
                    --固定频率发送移动协议
                    if (PublicFunc.QueryDeltaTime(obj.last_send_move_time) >= 99) 
                        and ((obj:IsMyControl() or obj:IsAIAgent())) then
                        local path = navMeshObj:get_path()
                        --app.log(table.tostring(path))
                        local path_size = #path
                        local path_node = {}
                        if path_size < 2 then
                            return;
                        end
                        table.insert(path_node, {x=x*PublicStruct.Coordinate_Scale, y=z*PublicStruct.Coordinate_Scale})
                        for i=2, math.min(path_size, 4) do
                            table.insert(path_node, {x=path[i].x*PublicStruct.Coordinate_Scale, y=path[i].z*PublicStruct.Coordinate_Scale})
                        end
                        --如果操作杆向量没有变化，则只有快到目标点了再重新发
                        local last_move_path = obj:getLastMovePath()--得到上次目的坐标
                        local last_move_forward = obj.last_move_forward
                        obj:setLastMovePath(path_node)
                        if obj:IsMyControl() and PublicStruct.RoleForward then
                            obj.last_move_forward = PublicStruct.RoleForward;
                        end
                        if last_move_path then
                            --if obj:IsMyControl() then
                            --[[if obj:IsMyControl() and obj:checkSameForWard(PublicStruct.RoleForward, last_move_forward) then
                                if obj.last_move_obj_pos then
                                    local nNum = (x-obj.last_move_obj_pos.x)*(x-obj.last_move_obj_pos.x) + (z-obj.last_move_obj_pos.z)*(z-obj.last_move_obj_pos.z)
                                    if nNum < 4 then
                                        return
                                    end
                                end
                            end
                            obj.last_move_obj_pos.x = x;
                            obj.last_move_obj_pos.z = z;]]
                            if obj:checkLastMovePath(path_node, last_move_path) then
                                return
                            end
                        end

                        --记录上次发送移动时候的目标以及操作杆向量
                        
                        
                        
                        
--                        app.log(obj:GetGID().." 发送移动协议: "..table.tostring(path_node))

                        --实际发送协议
                        if #path_node == 2 then
                            msg_move.cg_move(obj:GetGID(), path_node[1].x,path_node[1].y,path_node[2].x,path_node[2].y)
                        elseif #path_node == 3 then
                            msg_move.cg_move_multi(obj:GetGID(), path_node[1].x,path_node[1].y,path_node[2].x,path_node[2].y,path_node[3].x,path_node[3].y)
                        elseif #path_node == 4 then
                            msg_move.cg_move_multi(obj:GetGID(), path_node[1].x,path_node[1].y,path_node[2].x,path_node[2].y,path_node[3].x,path_node[3].y,path_node[4].x,path_node[4].y)
                        end
                        --app.log_warning("len="..#path_node.." time="..PublicFunc.QueryCurTime())
                        
                        obj.send_move_msg = true;
                        --更新时间
                        obj.last_send_move_time = PublicFunc.QueryCurTime()
                    end
                end
            else
                local x,y,z = obj:GetLocalPosition3f()
                if ((x-posX)*(x-posX) + (z-posZ)*(z-posZ) > 0.1) then
                    if type(obj.Move) == "function" then
                        obj:Move(x, y, z)
                    end
                end
            end
            

			--如果卡住，就播放站立动画，临时
			local x,y,z = obj.object:get_local_position();
            local arrive_dis = algorthm.GetDistance(posX, posZ, x, z);
			--app.log(obj.object:get_name().."   速度===="..vx*vx+vy*vy+vz*vz);
			--app.log(obj.object:get_name().."   距离===="..(posX-x)*(posX-x)+(posZ-z)*(posZ-z));
			if(obj.lastPosX and obj.lastPosZ)then
				if(obj.last_check_pos_time and PublicFunc.QueryDeltaTime(obj.last_check_pos_time) > 500)then
                   
					--app.log(obj.object:get_name().."开始判断是否卡住  "..(obj.lastPosX-x)*(obj.lastPosX-x)+(obj.lastPosZ-z)*(obj.lastPosZ-z).."  "..(posX-x)*(posX-x)+(posZ-z)*(posZ-z));
                    local condition1 = ((obj.lastPosX-x)*(obj.lastPosX-x)+(obj.lastPosZ-z)*(obj.lastPosZ-z)<0.1)
                    local condition2 = (arrive_dis > 0.7)
                    if condition1 and condition2 then
                        if(not obj.isStand)then
							obj:PlayAnimate(EANI.stand);
							obj.isStand = true;
						end
					else
						if(obj.isStand == true)then
                            local runCfg = nil
                            if aniId == EANI.run then
                                runCfg = obj:GetRunActionEffectCfg();
                            end
							obj:PlayAnimate(aniId,runCfg);
							obj.isStand = false;
						end
					end
					obj.lastPosX = nil;
					obj.lastPosZ = nil;
                    obj.last_check_pos_time = nil
				end
			else
				obj.lastPosX = x;
				obj.lastPosZ = z;
                obj.last_check_pos_time = PublicFunc.QueryCurTime();
			end
            obj.arrive_des_pos = (arrive_dis < 0.1)
        end,
        OnEnd = function(obj)
            obj:SetDestination(nil,nil,nil, true)
            obj.last_check_pos_time = nil
            obj:GetAniCtrler():HideSingleActionEffect();
            obj.arrive_des_pos = false
            if obj.send_move_msg then
                obj:TrySendStand()
                obj.send_move_msg = false;
            end
            if obj.fix_move then
                obj.fix_move = nil
                if obj.navMeshAgent then
                    obj.navMeshAgent:set_speed(obj.speed_from_server)
                end
            end
            obj.last_nav_dx = nil
            obj.last_nav_dz = nil
            obj.last_nav_dy = nil
        end,
    },

    --BeRepel = 
    --{
       --OnBegin = function(obj)
            --
            --local param = obj:GetBeRepelParam()
--
            --obj:GetBuffManager():CheckRemove(eBuffPropertyType.RemoveOnRepel)
--
            --obj:PlayAnimate(EANI.repel)
            --local attacker = ObjectManager.GetObjectByName(param.attackName)
            --local attPos = attacker:GetPosition()
            --obj:LookAt(attPos)
--
            --local myPos = obj:GetPosition()
            --local nx, ny, nz = util.v3_normalized(myPos.x - attPos.x, 0, myPos.z - attPos.z)
            --local tx = myPos.x + nx * param.backMoveLen
            --local ty = myPos.y + ny * param.backMoveLen
            --local tz = myPos.z + nz * param.backMoveLen
            --obj:PosMoveToPos(tx, ty, tz, param.backMoveTime, nil, nil, false)
--
        --end,
--
        --OnUpdate = function(obj, deltaTime)
--
        --end,
        --OnEnd = function(obj)
        --end,
    --},

 
    Attack =
    {
        AttackUseSkill = function(obj)
			if(obj.stopAttack == true and not obj.isFirstAttack and obj.lastSkillComplete == true)then
				obj:SetState(ESTATE.Stand)
                return
			end
            local target = obj:GetAttackTarget()
			if(target ~= nil)then
				if(target:GetHP() < 1)then
					target:onAniBeHitedEnd();
					obj:SetAttackTarget(nil);
					obj:SetState(ESTATE.Stand)
                    return
				end
			end
			obj.isFirstAttack = false;
            obj.canSkillRotate = false
            if obj and obj:GetCurSkill() and obj:GetCurSkill():GetSkillType() == eSkillType.Normal and (obj:IsMyControl() or obj:IsAIAgent()) then
                obj:SetCurSkillIndex(obj.normalAttackIndex);
            end
			obj:PlaySkill()           
        end,

        OnBegin = function(obj)
            obj:SetNavFlag(false, true);
			--obj.navMeshAgent:stop(true);
            if ((not obj:IsSkillInWorking()) and not (obj.just_learn_skill)) or (not obj:IsMyControl() and not obj:IsAIAgent())then
			    obj.lastSkillComplete = true;
            end
			obj.isFirstAttack = true;
            obj.canSkillRotate = false
            obj.skillForceComplete = false 
            if obj:GetIsSkillUseByAIHFSM() then
               EntityState.Attack.AttackUseSkill(obj)
            end
            EntityState.Attack.OnUpdate(obj)

        end,

        OnUpdate = function(obj, deltaTime)
			if((obj.lastSkillComplete == true or obj:GetExternalArea("skillChange") == true) and obj:GetIsSkillUseByAIHFSM() ==  false) then
                --app.log("lastSkillComplete="..tostring(obj.lastSkillComplete).." skillChange="..tostring(obj:GetExternalArea("skillChange")))
                EntityState.Attack.AttackUseSkill(obj)
			end
        end,
        OnEnd = function(obj)
        end,
    },

    Die =
    {
        OnBegin = function(obj)

            NoticeManager.Notice(ENUM.NoticeType.EntityDead, obj)

            obj:SetIsObstacle(false, false)
            obj:SetNavFlag(false, false);
            obj:PlayAnimate(EANI.die)
            -- SetTimer(7, 1, ObjectManager.OnObjectDead, obj)
            FightEvent.OnDead(obj)
			--关闭碰撞器
			obj.object:set_collider_enable(false);
			obj.object:set_charactor_controller_enable(false);
            if obj:IsMyControl() then
                g_dataCenter.fight_info:CheckAllControlHeroDead()
            else
                obj.mmo_fight_state_begin_time = 0;
            end
            
            
            obj:SetAttackTarget(nil)
            obj:SetDetectedTarget(nil)
            obj:DestroyViewAngleEffects()
        end,
        OnUpdate = function(obj)
        end,
        OnEnd = function(obj)
        end,
    },
    Dead = 
    {
        OnBegin = function(obj)
            obj:SetIsObstacle(false, false)
            obj:SetNavFlag(false, false);
            obj:PlayAnimate(EANI.dead)
            obj.object:set_collider_enable(false);
            obj.object:set_charactor_controller_enable(false);
            if obj:IsMyControl() then
                g_dataCenter.fight_info:CheckAllControlHeroDead()
            else
                obj.mmo_fight_state_begin_time = 0;
            end
            obj:SetAttackTarget(nil)
            obj:SetDetectedTarget(nil)
            obj:DestroyViewAngleEffects()
        end,
        OnUpdate = function(obj)
        end,
        OnEnd = function(obj)
        end,
    },
}



ESTATE = EnumState(EntityState, 'EntityState')