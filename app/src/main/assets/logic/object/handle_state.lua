--region handle_state.lua
--Author : zouyou
--Date   : 2015/7/3
--desc  :操作状态

local attackRange1 = 2;  --近战攻击距离
local attackRange2 = 5;  --远程攻击距离
local attackRange3 = 6;  --防御塔攻击距离
local detectRange = 10;  --检测范围

HandleState = 
{
	--操作状态
	Attack = 
	{
		OnBegin = function(obj)
            g_dataCenter.autoPathFinding:StopPathFind();
            HandleState.Attack.OnUpdate(obj);
		end,
		OnUpdate = function(obj)
			local retState, retDestination, retTarget, retNeedChangeTarget = obj:CheckAttackState()
            if retNeedChangeTarget then
                obj:SetAttackTarget(retTarget, true)
            end
            if retDestination then
                obj:SetDestination(retDestination.x, retDestination.y, retDestination.z)
            end
            if retState then
                obj:SetState(retState)
                if retState == ESTATE.Attack and obj.stopAttack and not obj._skillAfterCanChange then
				    obj:SetHandleState(EHandleState.Idle)
			    end
            else
                if obj.arrive_des_pos then
                    obj:SetHandleState(EHandleState.Manual)
                end
            end
        end,
        OnEnd = function(obj)
        end,
	},
	Move = 
	{
		OnBegin = function(obj)
            g_dataCenter.autoPathFinding:StopPathFind();
            obj:setLastMovePath(nil)
            obj.is_initiative_move = true
			--obj:SetState(ESTATE.Run);
            -- if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_openWorld and FightScene.GetPlayMethodType() ~= nil then
            --     obj:SetAttackTarget(nil);
            -- end
            if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
                obj:ClearFightStateTarget(true, false, "使用摇杆操作")
                --obj:SetAttackTarget(nil);
            end
		end,
		OnUpdate = function(obj)
            if not obj:CheckStateValid(EHandleState.Move) then
                if obj.canSkillRotate == true then
                    obj:Rotate2New()
                end
                return
            end
            obj._buffManager:CheckRemove(eBuffPropertyType.RemoveOnMove)
			--local forward = FightUI.RoleForward;
            local forward = PublicStruct.RoleForward
            -- if not forward then
            --     forward = PublicStruct.RoleForward;
            -- end
            local pos = obj:GetPosition();--当前的坐标点
            local targetPos = {};--移动的目标点
            if obj and forward and pos then
                local movelen = 1
                if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                    movelen = 5;
                end
                targetPos.x = pos.x + forward.x * movelen;
                targetPos.y = pos.y + forward.y * movelen;
                targetPos.z = pos.z + forward.z * movelen;
            else
                return;
            end
            --local x,y,z = GetTouchDownPoint();
            --这是用来屏蔽走到墙边后还在不停的设置跑动
            local lastMovePos = obj:GetExternalArea("lastMovePos");
            if lastMovePos and algorthm.GetDistance(lastMovePos.x, lastMovePos.z, targetPos.x, targetPos.z) <= 0.3 then
                return;
            end
            
            --如果有阻挡，得到有效的坐标
            -- local bRet, nx, ny, nz = obj.navMeshAgent:ray_cast(pos.x, pos.y, pos.z, targetPos.x, targetPos.y, targetPos.z)
            -- app.log(string.format("阻挡 %f,%f,%f,%f,%f,%f",targetPos.x, targetPos.y, targetPos.z,nx,ny,nz));
            -- --print("阻挡:",bRet,targetPos.x, targetPos.y, targetPos.z,nx,ny,nz);
            -- targetPos.x = nx; 
            -- targetPos.y = ny;
            -- targetPos.z = nz;

            --记录最新的移动点,之后实际的移动，由scene_entity中的updataChangeMovePos来做，实现固定频率发送
            obj:SetExternalArea("lastMovePos", targetPos);

            --设置目标坐标 
            obj:SetDestination(targetPos.x,targetPos.y,targetPos.z);
            obj:SetState(ESTATE.Run);
            --local now = app.get_time();

            
        end,
        OnEnd = function(obj)
        	obj:SetExternalArea("lastMovePos", nil);
        end,
	},
	ClickMove = 
	{
		OnBegin = function(obj)
            obj:setLastMovePath(nil)
            PublicStruct.RoleForward = nil
            g_dataCenter.autoPathFinding:StopPathFind();
			--obj:SetState(ESTATE.Run);
			--obj:SetAttackTarget(nil);
		end,
		OnUpdate = function(obj)
			local x,y,z = TouchManager.GetMovePos();
            local pos = obj:GetPosition(false);
            local dis = algorthm.GetDistance(pos.x, pos.z, x, z);
            if dis <= 0.01 then
                obj:SetState(ESTATE.Stand);
                if obj.aperture_manager then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.clickEffect, false);
                end
                return
            end
			--这是用来屏蔽走到到某店后还不停走
			local lastMovePos = obj:GetExternalArea("lastMovePos");
            if lastMovePos then
                local dis = algorthm.GetDistance(lastMovePos.x, lastMovePos.z, x, z);
    			if dis <= 0.01 then
                    return;
                end
            end
            

			obj:SetExternalArea("lastMovePos", {x=x,y=y,z=z});
			obj:SetDestination(x,y,z);
			obj:SetState(ESTATE.Run);
        end,
        OnEnd = function(obj)
        	obj:SetExternalArea("lastMovePos", nil);
            if obj.aperture_manager then
                obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.clickEffect, false);
            end
        end,
	},
    MapMove = 
    {
        OnBegin = function(obj)
            --obj:SetState(ESTATE.Run);
            obj:setLastMovePath(nil)
            PublicStruct.RoleForward = nil
            obj:SetAttackTarget(nil);
        end,
        OnUpdate = function(obj)
            -- local x,y,z = obj:GetDestination();
            -- if not x then
            --     -- app.log("ddddddddddd  "..debug.traceback());
            --     return
            -- end
            if g_dataCenter.autoPathFinding:Update() then
                obj:SetState(ESTATE.Run);
            else
                obj:SetState(ESTATE.Stand);
            end
            --[[local pos = obj:GetPosition(false);
            local dis = algorthm.GetDistance(pos.x, pos.z, x, z);
            if dis <=0.1 then
            app.log("ddddddddddd  x,y,z=="..table.tostring({x,y,z}));
                obj:SetState(ESTATE.Stand);
                return
            end]]
            
        end,
        OnEnd = function(obj)
            obj:SetExternalArea("lastMovePos", nil);
        end,
    },
	Idle = 
	{
		OnBegin = function(obj)
		end,
		OnUpdate = function(obj)
        end,
        OnEnd = function(obj)
        end,
	},
	Manual =
	{
		OnBegin = function(obj)
            if obj:CheckStateValid(EHandleState.Manual) then
                if obj.object then
                    local x, y, z = obj.object:get_local_position();
			        obj:SetDestination(x,y,z);
			        obj:SetState(ESTATE.Stand);
                end
            end
		end,
		OnUpdate = function(obj)
            if obj:GetState() ~= ESTATE.Stand and obj:CheckStateValid(EHandleState.Manual) then
                local x, y, z = obj.object:get_local_position();
			    obj:SetDestination(x,y,z);
			    obj:SetState(ESTATE.Stand);
            end
        end,
        OnEnd = function(obj)
        end,
	},
    MainCityMove = 
    {
        OnBegin = function(obj)
            --obj:SetState(ESTATE.Run);
            --obj:SetAttackTarget(nil);
        end,
        OnUpdate = function(obj)
            local x,y,z = mainCityScene:GetMovePos();
            local pos = obj:GetPosition(false);
            local dis = algorthm.GetDistance(pos.x, pos.z, x, z);
            if dis <=1 then
                obj:SetState(ESTATE.Stand);
                mainCityScene:TouchMainCityNpc();
                return
            end
            --这是用来屏蔽走到到某店后还不停走
            local lastMovePos = obj:GetExternalArea("lastMovePos");
            if lastMovePos then
                local dis = algorthm.GetDistance(lastMovePos.x, lastMovePos.z, x, z);
                if dis <= 0.01 then
                    return;
                end
            end

            obj:SetExternalArea("lastMovePos", {x=x,y=y,z=z});
            obj:SetDestination(x,y,z);
            obj:SetState(ESTATE.Run);
        end,
        OnEnd = function(obj)
            obj:SetExternalArea("lastMovePos", nil);
        end,
    },
    MMOMove = 
    {
        OnBegin = function(obj)
            g_dataCenter.autoPathFinding:StopPathFind();
            obj:setLastMovePath(nil)
            PublicStruct.RoleForward = nil
            --obj:SetState(ESTATE.Run);
            --obj:SetAttackTarget(nil);
        end,
        OnUpdate = function(obj)
            local x,y,z = FightScene.GetFightManager():GetMovePos();
            local pos = obj:GetPosition(false);
            local dis = algorthm.GetDistance(pos.x, pos.z, x, z);
            if dis <=2 then
                obj:SetState(ESTATE.Stand);
		        --if FightScene.GetFightManager():CanTouchNpc() then
                    FightScene.GetFightManager():TouchNpc();
		        --end
                return
            else
                FightScene.GetFightManager():SetTouchNpc( false );
            end
            --这是用来屏蔽走到到某店后还不停走
            local lastMovePos = obj:GetExternalArea("lastMovePos");
            if lastMovePos then
                local dis = algorthm.GetDistance(lastMovePos.x, lastMovePos.z, x, z);
                if dis <= 0.01 then
                    return;
                end
            end

            obj:SetExternalArea("lastMovePos", {x=x,y=y,z=z});
            obj:SetDestination(x,y,z);
            obj:SetState(ESTATE.Run);
        end,
        OnEnd = function(obj)
            obj:SetExternalArea("lastMovePos", nil);
        end,
    },
	
	
--	--AI状态
--	Patrol = 
--	{
--		OnBegin = function(obj)
--		end,
--		OnUpdate = function(obj)
--        end,
--        OnEnd = function(obj)
--        end,
--	},
	
--	AddHp = 
--	{
--		OnBegin = function(obj)			
--		end,
--		OnUpdate = function(obj)		
--        end,
--        OnEnd = function(obj)
--        end,
--	},
	
--	Escape = 
--	{
--		OnBegin = function(obj)
--		end,
--		OnUpdate = function(obj)
--        end,
--        OnEnd = function(obj)
--        end,
--	},

	TowerAttack = 
	{
		OnBegin = function(obj)
		end,
		OnUpdate = function(obj)
            local needTarget = nil
            local attackDistance = 5
            local skill = obj:GetCurSkill()
            if skill ~= nil then
                attackDistance = skill:GetDistance()
                needTarget = skill:GetTargetType()
            end
			local target = obj:GetAttackTarget()
			if(not target)then
                local arrTargets = {}
				obj:SearchAreaTarget(true, attackDistance, obj, arrTargets, 1, 360, nil, 3, false, nil, nil, {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster})
                target = arrTargets[1]
			end
			if(target)then
				obj:SetAttackTarget(target);
				local sx,sy,sz = obj.object:get_local_position();
				local dx,dy,dz = target.object:get_local_position();
				local dis = algorthm.GetDistance(sx, sz, dx, dz);
				if(dis <= attackDistance and target:GetHP() > 0)then
					obj:SetCurSkillIndex(obj.normalAttackIndex);
					obj.stopAttack = false;
					obj:SetState(ESTATE.Attack);
					return
				else
					obj:SetAttackTarget(nil);
					obj.stopAttack = true;
					obj:SetState(ESTATE.Stand);
					return
				end
            else
                obj:SetAttackTarget(nil);
				obj.stopAttack = true;
				obj:SetState(ESTATE.Stand);
			end
		end,
        OnEnd = function(obj)
        end,
    },
	Die = 
	{
		OnBegin = function(obj)
            g_dataCenter.autoPathFinding:StopPathFind();
			obj:SetState(ESTATE.Die)
		end,
		OnUpdate = function(obj)
			
        end,
        OnEnd = function(obj)
        end,
	}
}


EHandleState = EnumState(HandleState, 'HandleState')

--endregion
