FightRecord = {
	levelID = 0,
	isWin = false,
	isGood = false, 
	isPerfect = false,

	killingBillBoard = {
		[g_dataCenter.fight_info.single_friend_flag] = {
			winNum = 0;--[[胜利次数]]
		};
		[g_dataCenter.fight_info.single_enemy_flag] = {
			winNum = 0;--[[胜利次数]]
		};
	},

	-- killingBillBoard = {
	-- 	[g_dataCenter.fight_info.single_friend_flag] = {
	--		winNum = 0;
	--  	killer_list = {
	--			[player_id] = {
	--				killCount = 1,
	--				deadTimes = 1,
	--				kill_list = {
	--					[类型] = 数量
	--				}
	--			}
	-- 		}
	-- 	}
}

function FightRecord.Clear()
	FightRecord.levelID = 0
	FightRecord.isWin = false
	FightRecord.isGood = false 
	FightRecord.isPerfect = false
	FightRecord.killingBillBoard = {}
	FightRecord.killBossNum = {}
    FightRecord.usedSkills = {}
    FightRecord.deadRecord = {}
    FightRecord.abnormalDead = {}
    FightRecord.triggerRecord = {}
	FightRecord.conditionKillMonsterNumInTimeRecord = {}
	FightRecord.Times = {} -- 目前用于记录推入陷阱次数；
	FightRecord.isAttack = {} -- 记录是否被攻击
	FightRecord.groupDeadNumRecord = {}
	FightRecord.patrolMonsterDiscoveredCaptain = 0
end

function FightRecord.SetLevelID(level_id)
	FightRecord.levelID = level_id
end

function FightRecord.GetLevelID()
	return FightRecord.levelID
end

function FightRecord.IsWin()
	return FightRecord.isWin;
end

function FightRecord.SetIsWin(flag)
	FightRecord.isWin = flag
end


function FightRecord.IsGood()
	return FightRecord.isGood;
end

function FightRecord.SetIsGood(flag)
	FightRecord.isGood = flag
end


function FightRecord.IsPerfect()
	return FightRecord.isPerfect;
end

function FightRecord.SetIsPerfect(flag)
	FightRecord.isPerfect = flag
end

function FightRecord.RecordKillingInfo(killer_team, killer, target_team, target_team)

end

function FightRecord.GetStar()
	local star = 0;
	if FightRecord.isWin then
		star = star + 1;
		if FightRecord.isGood then
			star = star + 1;
		end
		if FightRecord.isPerfect then
			star = star + 1;
		end
	end
	return star;
end

function FightRecord.onDead(killer,target)
    if killer then
        local team = FightRecord.killingBillBoard[killer:GetCampFlag()] or {};
	    FightRecord.killingBillBoard[killer:GetCampFlag()] = team;

        if killer.card and killer.card.index then
	        team.killer_list = team.killer_list or {};
	        local killer_list = team.killer_list;
	        killer_list[killer.card.index] = killer_list[killer.card.index] or {};

	        local kill_list = killer_list[killer.card.index].kill_list or {};
	        killer_list[killer.card.index].kill_list = kill_list;

            kill_list[target.config.id] = kill_list[target.config.id] or 0;
	        kill_list[target.config.id] = kill_list[target.config.id] + 1;
        end

        local num = FightRecord.killBossNum[target:GetCampFlag()] or 0;
        -- app.log("camp_flag:"..tostring(killer:GetCampFlag()));
        if target:IsBoss() or target:IsHero() then
    	    num = num + 1;
    	    -- app.log("camp_flag:"..tostring(killer:GetCampFlag()).." num:"..tostring(num));
    	    FightRecord.killBossNum[target:GetCampFlag()] = num;
        end
    end



    --根据英雄或者怪物id记录各自的死亡次数
    local id = target:GetConfig("id")
	local idIndex = id
	if target.card then
		idIndex = idIndex+target.card.index;
	end
    FightRecord.deadRecord[idIndex] = FightRecord.deadRecord[idIndex] or 0
    FightRecord.deadRecord[idIndex] = FightRecord.deadRecord[idIndex] + 1

    --记录非敌对阵营造成的死亡次数---
    -- 击杀者不存在  击杀者是道具 击杀者不是敌对的
    if not killer or (killer:IsItem() or not killer:IsEnemy(target)) then
    	local num = FightRecord.abnormalDead[target:GetCampFlag()] or 0;
    	FightRecord.abnormalDead[target:GetCampFlag()] = num + 1;
    end

	local groupName = target:GetGroupName()
	if groupName then
		local gDeadNum = FightRecord.groupDeadNumRecord[groupName]
		if gDeadNum == nil then
			FightRecord.groupDeadNumRecord[groupName] = 1
		else
			FightRecord.groupDeadNumRecord[groupName] = gDeadNum + 1
		end

	end
end

function FightRecord.GetGroupDeadNum(groupName)
	return FightRecord.groupDeadNumRecord[groupName] or 0
end

function FightRecord.RecordDiscoverEnemy(selfObj, enemy)

	if not selfObj or not enemy then return end

	if selfObj:GetType() == ENUM.EMonsterType.Patrol then
		FightRecord.patrolMonsterDiscoveredCaptain = FightRecord.patrolMonsterDiscoveredCaptain + 1
	end

end

function FightRecord.PatrolDiscoveredCaptain(times)
	return FightRecord.patrolMonsterDiscoveredCaptain >= times
end

function FightRecord.GetDeadCount(id,cardIndex)
	cardIndex = cardIndex or 0;
    return FightRecord.deadRecord[id+cardIndex] or 0
end

function FightRecord.GetKillTotalNumberById(camp_flag,monster_id)
	local total_num = 0;
	if camp_flag == g_dataCenter.fight_info.single_friend_flag then
		camp_flag = g_dataCenter.fight_info.single_enemy_flag;
	else
		camp_flag = g_dataCenter.fight_info.single_friend_flag;
	end
	local teamBoard = FightRecord.killingBillBoard[camp_flag] or {};
	local killer_list = teamBoard.killer_list or {};
	for k,v in pairs(killer_list) do
		for kk,vv in pairs(v.kill_list) do
			if kk == monster_id then
				total_num = total_num + vv;
			end
		end
	end
	return total_num;
end
--camp_flag 阵营
function FightRecord.GetKillTotalNumber(camp_flag)
	local total_num = 0;
	local teamBoard = FightRecord.killingBillBoard[camp_flag] or {};
	local killer_list = teamBoard.killer_list or {};
	for k,v in pairs(killer_list) do
		for kk,vv in pairs(v.kill_list) do
			total_num = total_num + vv;
		end
	end
	return total_num;
end

function FightRecord.RecordUseSkill(user, skillid)
    if user == nil or skillid == nil then
        return
    end
    local userName = user:GetName()
    if FightRecord.usedSkills[userName] == nil then
        FightRecord.usedSkills[userName] = {}
    end
    if table.index_of(FightRecord.usedSkills[userName], skillid) <= 0 then
        table.insert(FightRecord.usedSkills[userName], skillid)
    end

end

function FightRecord.GetUseSkills(name)
    return FightRecord.usedSkills[name]
end

function FightRecord.RecordTrigger(obj, trigger)

    local triggerID = trigger:GetConfig("trigger_id")
    local objID = obj:GetConfig("id")
    if obj:IsHero() then
        objID = obj:GetConfig("default_rarity")
    end
    if triggerID ~= nil and objID ~= nil then
        if FightRecord.triggerRecord[triggerID] == nil then
            FightRecord.triggerRecord[triggerID] = {}
        end

        if FightRecord.triggerRecord[triggerID][objID] == nil then
            FightRecord.triggerRecord[triggerID][objID] = {}
        end

        if FightRecord.triggerRecord[triggerID][objID].firstEnterTime == nil then
            FightRecord.triggerRecord[triggerID][objID].firstEnterTime = system.time()
        end
    end
end

function FightRecord.GetTriggerRecord(triggerid, objID)
    if FightRecord.triggerRecord[triggerid] ~= nil then
        return FightRecord.triggerRecord[triggerid][objID]
    end
    return nil
end

function FightRecord.GetKillBossNum(camp_flag)
	return FightRecord.killBossNum[camp_flag] or 0;
end

function FightRecord.SetInTimeKillMonsterResult(monsterid, result)
	FightRecord.conditionKillMonsterNumInTimeRecord[monsterid] = result
end

function FightRecord.GetInTimeKillMonsterResult(monsterid)
	return FightRecord.conditionKillMonsterNumInTimeRecord[monsterid]
end

function FightRecord.RecordTimes(camp_flag)	
	FightRecord.Times[camp_flag] = (FightRecord.Times[camp_flag] or 0) + 1;
end

function FightRecord.GetRecordTimes(camp_flag)
	return FightRecord.Times[camp_flag] or 0;
end

function FightRecord.SetIsAttack( cid )
	if cid then
		--app.log("FightRecord.SetIsAttack:" .. tostring(cid));
		FightRecord.isAttack[cid] = 1;
	end
	-- app.log("FightRecord:name:" .. FightRecord.isAttack[name]);
end

function FightRecord.GetIsAttack( cid )
	if FightRecord.isAttack[cid] and FightRecord.isAttack[cid] == 1 then
		return false;
	else
		return true;
	end
end