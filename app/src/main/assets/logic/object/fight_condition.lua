-- 战斗统计数据表
g_fightData = {}


EFightEvent = {
	timeOut = 1,
	objDead = 2,
}

-- 关卡条件
local condition = {
}
	--平均生命低于多少
	condition.average_hp =
	{
		check=function( param )
			local hpCount = 0;
			local maxHpCount = 0;
			local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
            local p = 0
            local count = 3
			for k,v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v);
				if obj then
                    p = p + obj:GetPropertyVal('cur_hp')/obj:GetPropertyVal('max_hp')
                    count = count + 1
				end
			end
			return p/count >= param
		end,
	};
	--在%d秒内完成过关
	condition.pass_time =
	{
		check=function( param )
			local curTime = FightScene.GetFightManager():GetFightUseTime()
			return curTime <= param
		end,
	};
	--指定对象被杀死
    --{flag, heroOrMonster, numberid,  flag, heroOrMonster, numberid ...}
	condition.object_is_dead =
	{
		check=function( param )

            local objIndex = 0

            while true do
                local flag = param[objIndex + 1]
                local heroOrMonster = param[objIndex + 2]
                local number = param[objIndex + 3]
                if flag and heroOrMonster and number then
                    local list = heroOrMonster > 0 and g_dataCenter.fight_info:GetHeroList(flag) or g_dataCenter.fight_info:GetMonsterList(flag);
                    for k,v in pairs(list) do
                        local entity = GetObj(v)
                        if entity and not entity:IsDead() and entity.card and entity.card.number == number then
                            return false
                        end
                    end
                else
                    break
                end

                objIndex = objIndex + 3
            end

			return true;
		end,
	};
	--指定对象存活
	condition.object_is_alive =
	{
		check=function( param )
			local result = condition["object_is_dead"].check(param);
			return not result;
		end,
	};
	--boss被杀死
	condition.boss_killed =
	{
		check = function(param)
			local boss = g_dataCenter.fight_info:GetBoss(param)
			return boss == nil or boss:IsDead()
		end
	};
	--基地被毁
	condition.base_killed =
	{
		check=function( param )
			local base = g_dataCenter.fight_info:GetBase(param)

			if base == nil then
				app.log_warning("基地不在了？")
			end

			return base == nil or base:IsDead()
		end,
	};
	--时间到了
	condition.time_up = {
		check = function (param)
			return FightScene.GetFightManager():IsTimeUp();
		end
	};
	--胜利回合数
	condition.win_round_count = {
		check = function (param)
			if FightRecord.killingBillBoard[g_dataCenter.fight_info.single_friend_flag].winNum >= param or
			   FightRecord.killingBillBoard[g_dataCenter.fight_info.single_enemy_flag].winNum >= param then
				return true;
			else
				return false;
			end
		end
	};
	--所有英雄死亡
	condition.all_hero_dead = {
		check = function(param)
			local hero_list = g_dataCenter.fight_info:GetHeroList(param)

			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				if obj ~= nil and not obj:IsDead() then
					return false
				end
			end
            local delayHeroList = g_dataCenter.fight_info:GetDelayLoadHeroList(param)
            if #delayHeroList > 0 then
                return false;
            end

			return true
		end
	};
	--至少有一个英雄活着（param :flag）
	condition.at_least_one_hero_alive = {
		check = function(param)
			local result = condition["all_hero_dead"].check(param);
			return not result;
		end
	};
	--所有英雄存活（param：flag）
	condition.all_hero_alive = {
		check = function(param)
			local hero_list = g_dataCenter.fight_info:GetHeroList(param)
			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				if obj == nil or obj:IsDead() then
					return false
				end
			end

			return true;
		end
	};
	--击杀一定数量的某种敌人
	condition.kill_monster_num = {
		get_progress = function (param)
			return  FightRecord.GetKillTotalNumberById(param[1],param[2]), param[3]
		end,

		check = function (param)
			local kill_num = FightRecord.GetKillTotalNumberById(param[1],param[2]);
			if kill_num >= param[3] then
				return true;
			else
				return false;
			end
		end
	};

    --在一定时间内击杀一定数量的怪物
    -- 阵营,怪物id,数量,时间(s)
    condition.kill_monster_num_in_time ={   
        check = function(param)

            local monsterid = param[2]

            local result = FightRecord.GetInTimeKillMonsterResult(monsterid)
            if result == nil then
                result = false
                local hasUseTime = FightScene.GetFightManager():GetFightUseTime()
                if hasUseTime <= param[4] then
                    local killedNum = FightRecord.GetKillTotalNumberById(param[1],monsterid)
                    if killedNum >= param[3] then
                        result = true
                        FightRecord.SetInTimeKillMonsterResult(monsterid, result)
                    end
                else
                    FightRecord.SetInTimeKillMonsterResult(monsterid, result)
                end
            end

            return result
        end
    }

	--清除所有怪
	condition.clean =
	{
		check = function (param)
			if param > 0 then
				local kill_num = FightRecord.GetKillTotalNumber(g_dataCenter.fight_info.single_friend_flag);
				if kill_num >= param then
					return true;
				end
			elseif param <= 0 then
                --app.log("1......"..tostring(g_dataCenter.fight_info:IsHaveMonster(g_dataCenter.fight_info.single_enemy_flag)));
				return g_dataCenter.fight_info:IsHaveMonster(g_dataCenter.fight_info.single_enemy_flag)
			end
			return false;
		end
	};
	--刷怪器
	condition.monster_loader =
	{
		check = function(param)
			if param > 0 then
				local result = FightScene.GetFightManager():GetLoaderWaveCount();
				return result >= param;
			else
				local result = FightScene.GetFightManager():MonsterLoaderCanLoader();
                --app.log("2......"..tostring(result));
				return result == false;
			end
		end
	};
    -- 时间到或清怪
    condition.clean_or_time_up =
    {
        check = function (param)
            if type(param) == "table" then
                return FightCondition.Check(time_up)
                or FightCondition.Check(clean,param[1] or 0)
                or FightCondition.Check(monster_loader,param[2] or 0);
            else
                return FightCondition.Check(time_up)
                or FightCondition.Check(clean, 0)
                or FightCondition.Check(monster_loader, 0);
            end
        end
    }
    -- 被陷阱杀死次数少于
    condition.trap_kill_times =
    {
        check = function (param)
            if type(param) == "number" then
                return false;
            end
            local flag = param[1];
            local times = param[2];
            return (FightRecord.abnormalDead[flag] or 0) < times;
        end
    }
    --敌方或我方 英雄全部死亡
    condition.either_side_all_dead =
    {
        check = function(param)
            local isEnd = true;
            local flag = g_dataCenter.fight_info.single_friend_flag;
            local delayHeroList = g_dataCenter.fight_info:GetDelayLoadHeroList(flag)
            local hero_list = g_dataCenter.fight_info:GetHeroList(flag)
			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				if obj ~= nil and not obj:IsDead() then
					isEnd = false
                    break
				end
			end

            if isEnd and #delayHeroList <= 0 then
                return true
            end

            isEnd = true;
            flag = g_dataCenter.fight_info.single_enemy_flag
            delayHeroList = g_dataCenter.fight_info:GetDelayLoadHeroList(flag)
            hero_list = g_dataCenter.fight_info:GetHeroList(flag)
			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				if obj ~= nil and not obj:IsDead() then
					isEnd = false
                    break
				end
			end

            return isEnd and #delayHeroList <= 0
        end
    };
    --NPC（或英雄）到达指定区域
    condition.arrive_destination =
    {
    	check = function(param)
    		return FightScene.GetFightManager():IsArriveDestination();
		end
	};

	condition.boss_not_arrive_destination =
	{
		check = function(param)
    		return not FightScene.GetFightManager():IsBossArriveDestination();
		end
	};

    condition.boss_arrive_destination =
    {
        check = function(param)
            return FightScene.GetFightManager():IsBossArriveDestination();
        end
    };

	--使用加血后等待几秒钟完成（新手关卡）
	condition.wait_use_skill_hp =
	{
		check = function(param)
			if FightScene.GetFightManager().IsWaitUseSkillHp then
				return FightScene.GetFightManager():IsWaitUseSkillHp();
			end
    		return false
		end
	};

    -- 到达指定区域
    -- param = {heroOrNpcID, TriggerID}
    condition.obj_reached_dst_area =
    {
        check = function(param)
            local heroOrNpcId = param[1]
            if heroOrNpcId >= 0 and heroOrNpcId <= 3 then
                local ids = FightCondition.HeroIndexToID(heroOrNpcId)
                for k,id in ipairs(ids) do
                    local res = FightRecord.GetTriggerRecord(param[2], id) ~=  nil
                    if res then
                        return true
                    end
                end
                return false
            else
                return FightRecord.GetTriggerRecord(param[2], param[1]) ~=  nil
            end
        end
    }

    -- 未到达指定区域
    -- param = {heroOrNpcID, TriggerID}
    condition.obj_not_reached_dst_area =
    {
        check = function(param)
            --return FightRecord.GetTriggerRecord(param[2], param[1]) ==  nil
            local heroOrNpcId = param[1]
            if heroOrNpcId >= 0 and heroOrNpcId <= 3 then
                local ids = FightCondition.HeroIndexToID(heroOrNpcId)
                for k,id in ipairs(ids) do
                    local res = FightRecord.GetTriggerRecord(param[2], id) ~=  nil
                    if res then
                        return false
                    end
                end
                return true
            else
                return FightRecord.GetTriggerRecord(param[2], param[1]) ==  nil
            end
        end
    }

    --指定ID的英雄或NPC血量低于x
    --param={id, 比例}
    condition.obj_hp_less_than =
    {
        check = function(param)
            local less = false
            ObjectManager.ForEachObj(function (k, obj)
                if FightCondition.GetHeroOrNPCID(obj) == param[1] then
                    if obj:GetHP()/obj:GetMaxHP() < param[2] then
                        less = true
                        return false
                    end
                end
                return true
            end)

            return less
        end
    }

    --指定ID的英雄或NPC血量大于等于x
    --param={id, 比例}
    condition.obj_hp_more_than =
    {
        check = function(param)
            local more = false
            ObjectManager.ForEachObj(function (k, obj)
                if FightCondition.GetHeroOrNPCID(obj) == param[1] then
                    if obj:GetHP()/obj:GetMaxHP() >= param[2] then
                        more = true
                        return false
                    end
                end
                return true
            end)

            return more
        end
    }

    --主角先于指定怪物到达指定区域
    -- param = {怪物id, 区域id}
    condition.main_hero_before_monster_reached_dst_area =
    {
        check = function(param)

            local monsterid = param[1]
            local triggerid = param[2]

            local caption = FightManager.GetMyCaptain()
            if caption ~= nil then
                local captionID = FightCondition.GetHeroOrNPCID(caption)
                local captionTirggerRecord = FightRecord.GetTriggerRecord(triggerid, captionID)
                local monsterTriggerRecord = FightRecord.GetTriggerRecord(triggerid, monsterid)

                if captionTirggerRecord ~= nil then
                    if monsterTriggerRecord == nil then
                        return true
                    else
                        return captionTirggerRecord.firstEnterTime < monsterTriggerRecord.firstEnterTime
                    end
                end
            end

            return false
        end
    }

    -- 使用指定的英雄 param = {heroid, ..}
    -- 只要使用了 param 中一个英雄条件就为真
    condition.use_heros =
    {
        check = function(param)
            local useHeros = false
            local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				local isContent = table.index_of(param, FightCondition.GetHeroOrNPCID(obj)) > 0
                if isContent then
                    useHeros = true;
                    break;
                end
			end

            return useHeros;
        end
    };

    -- 不使用指定的英雄 param = {heroid, ..}
    condition.not_use_heros =
    {
        check = function(param)
            local notUseHeros = true
            local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				local isContent = table.index_of(param,FightCondition.GetHeroOrNPCID(obj)) > 0
                if isContent then
                    notUseHeros = false;
                    break;
                end
			end

            return notUseHeros;
        end
    }

    -- 不使用指定的技能 param = {skillid, ...}
    condition.not_use_skills =
    {
        check = function(param)
            local notUseSkills = true

            local caption = FightManager.GetMyCaptain()
            if caption then
                local hasUsedSkills = FightRecord.GetUseSkills(caption:GetName())
                if hasUsedSkills then
                    for k,skillid in ipairs(param) do
                        local isContent = table.index_of(hasUsedSkills, skillid) > 0
                        if isContent then
                            notUseSkills = false
                            break;
                        end
                    end
                end
            end
            return notUseSkills
        end
    }

    -- 不使用指定的性别 param = 1|2   (1男2女)
    condition.not_use_gender =
    {
        check = function(param)
            local notUseGender = true
            local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)

			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				--if obj ~= nil then
					if obj:GetConfig("sex") == param then
					    notUseGender = false
                        break
					end
				--end
			end

            return notUseGender
        end
    }

    -- 使用了指定数量的指定性别的英雄 param = {性别, 数量}
    condition.use_gender_heros =
    {
        check = function(param)

            local num = 0;

            local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)

			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				--if obj ~= nil then
					if obj:GetConfig("sex") == param[1] then
					    num = num + 1
					end
				--end
			end

            return num >= param[2]
        end
    }

    -- 使用指定属性的英雄（疾坚锐特）的英雄X名
    -- param = {属性, 数量}
    condition.use_restraint_heros =
    {
        check = function(param)

            local num = 0;

            local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)

			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				--if obj ~= nil then
					if obj:GetConfig("restraint") == param[1] then
					    num = num + 1
					end
				--end
			end

            return num >= param[2]
        end
    }

    -- 不使用指定属性（疾坚锐特）的英雄
    -- param = {属性id, ...}
    condition.not_use_restraint_heros =
    {
        check = function(param)

            local notUse = true;

            local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)

			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				--if obj ~= nil then
					if table.index_of(param, obj:GetConfig("restraint")) > 0 then
					    notUse = false
                        break
					end
				--end
			end

            return notUse
        end
    }

    --使用x名指定类型的英雄
    -- param = {类型,数量}
    condition.use_type_heros =
    {
        check = function(param)

            local num = 0;

            local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)

			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				--if obj ~= nil then
					if obj:GetConfig("pro_type") == param[1] then
					    num = num + 1
					end
				--end
			end

            return num >= param[2]
        end
    }

    --不使用指定类型的英雄
    -- param = {type, ...}
    condition.not_use_type_heros =
    {
        check = function(param)

            local notUse = true;

            local hero_list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)

			for k, v in pairs(hero_list) do
				local obj = ObjectManager.GetObjectByName(v)
				--if obj ~= nil then
					if table.index_of(param, obj:GetConfig("pro_type")) > 0 then
					    notUse = false
                        break
					end
				--end
			end

            return notUse
        end
    }

    -- 指定英雄或者NPC血量高于x
    -- param = {id, 比例}
    condition.obj_hp_percentage_higher_than =
    {
        check = function(param)
            --使用全局临时变量，避免反复创建
            _g_temp_var_t = _g_temp_var_t or {}

            local list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
            -- local targetObj = nil
            for k,v in pairs(list) do
                local obj = ObjectManager.GetObjectByName(v)
                if obj ~= nil and FightCondition.GetHeroOrNPCID(obj, param[1]) == param[1]  then
                    -- targetObj = obj
                    -- break
                    table.insert(_g_temp_var_t, obj)
                end
            end

            -- if targetObj == nil then
                list = g_dataCenter.fight_info:GetMonsterList(g_dataCenter.fight_info.single_friend_flag)
                for k,v in pairs(list) do
                    local obj = ObjectManager.GetObjectByName(v)
                    if obj ~= nil and FightCondition.GetHeroOrNPCID(obj) == param[1]  then
                        -- targetObj = obj
                        -- break
                        table.insert(_g_temp_var_t, obj)
                    end
                end
            -- end

            local result = false
            -- if targetObj ~= nil then
            --     result = targetObj:GetMinHP()/targetObj:GetMaxHP() > param[2]
            -- end

            for i=#_g_temp_var_t, 1, -1 do
                if not result then
                    local targetObj = _g_temp_var_t[i]
                    result = targetObj:GetHP()/targetObj:GetMaxHP() >= param[2]
                end
                --清空临时变量
                table.remove(_g_temp_var_t, i)
            end

            return result
        end
    }

    --己方英雄死亡数不大于X
    --param = num
    condition.my_side_hero_dead_not_more_than =
    {
        check = function(param)
            local deadCount = 0
            local list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
            for k,v in pairs(list) do
                local obj = ObjectManager.GetObjectByName(v)
                if obj ~= nil then
					local a = FightRecord.GetDeadCount(obj:GetConfig("id"),obj.card.index);
                    deadCount = deadCount + a;
                end
            end

            return deadCount <= param
        end
    }

    --己方英雄血量不曾低于x
    --param = 比例
    condition.my_side_hero_hp_not_less_than =
    {
        check = function(param)
            local notLessThan = true
            local list = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)
            for k,v in pairs(list) do
                local obj = ObjectManager.GetObjectByName(v)
                if obj ~= nil then
                    notLessThan = obj:GetMinHP()/obj:GetMaxHP() >= param
                    if not notLessThan then
                        break
                    end
                end
            end

            return notLessThan
        end
    }
    --巡逻怪是否发现过主角
    --param = 发现次数
    condition.patrol_not_discover_capatin =
    {
        check = function(param)
            return not FightRecord.PatrolDiscoveredCaptain(param)
        end
    }

----------------------------大乱斗条件----------------
    -- 己方所有英雄死亡（关卡10人大乱斗）
    condition.all_hero_dead_fuzion =
    {
        check = function(param)
            if FightScene.GetFightManager().AllHeroDead then
                return FightScene.GetFightManager():AllHeroDead();
            else
                return false;
            end
        end
    };
    --存活到最后或时间到
    condition.fuzion_time_up_or_survive_end = {
        check = function (param)
            local isTimeUp = FightScene.GetFightManager():IsTimeUp();
            if isTimeUp then
                return true;
            else
                return FightScene.GetFightManager():IsClearOtherEnemy();
            end
        end
    };
    --击杀数量 param数量
    condition.fuzion_kill_num = {
        check = function (param)
            return FightScene.GetFightManager():GetKillNum()>=tonumber(param);
        end
    };
    --  时间到并且击杀少于param
    condition.fuzion_kill_num_less_and_time_up = {
        check = function (param)
            local isTimeUp = FightScene.GetFightManager():IsTimeUp();
            if isTimeUp then
                return FightScene.GetFightManager():GetKillNum()<tonumber(param);
            else
                return false;
            end
        end
    };
    --  时间到并且击杀大于param
    condition.fuzion_kill_num_more_and_time_up = {
        check = function (param)
            local isTimeUp = FightScene.GetFightManager():IsTimeUp();
            if isTimeUp then
                return FightScene.GetFightManager():GetKillNum()>tonumber(param);
            else
                return false;
            end
        end
    };
    --  排名高于等于param
    condition.fuzion_rank_above = {
        check = function (param)
            return FightScene.GetFightManager():GetRank()<=tonumber(param);
        end
    };
    --  时间到并且排名低于等于param
    condition.fuzion_rank_below_and_time_up = {
        check = function (param)
            local isTimeUp = FightScene.GetFightManager():IsTimeUp();
            if isTimeUp then
                return FightScene.GetFightManager():GetRank()>=tonumber(param);
            else
                return false;
            end
        end
    };
    --  时间到并且排名高于等于param
    condition.fuzion_rank_above_and_time_up = {
        check = function (param)
            local isTimeUp = FightScene.GetFightManager():IsTimeUp();
            if isTimeUp then
                return FightScene.GetFightManager():GetRank()<=tonumber(param);
            else
                return false;
            end
        end
    };
	-- 死亡数量低于param
	condition.fuzion_dead_num_below = {
		check = function  (param)
			return FightScene.GetFightManager():GetDeadNum()<tonumber(param);
		end
	}
	-- 死亡数量高于param
	condition.fuzion_dead_num_above = {
		check = function  (param)
			return FightScene.GetFightManager():GetDeadNum()>tonumber(param);
		end
	}
    -- 记录数据大于param
    condition.record_greater = {
        check = function ( param )
            return FightRecord.GetRecordTimes() > tonumber(param);
        end
    }
    -- 记录数据小于param
    condition.record_less = {
        check = function ( param )
            return FightRecord.GetRecordTimes() < tonumber(param);
        end
    }
    ------------------------收集关卡-------------------
    condition.collect_num = {
        check = function (param)
            if GetMainUI() then
                local ui = GetMainUI():GetHurdleCollectBoxUi();
                if ui then
                    return ui:GetOpenNum(param[1]) >= param[2];
                end
            else
                return false;
            end
        end
    }
    condition.collect_score = {
        check = function (param)
            if GetMainUI() then
                local ui = GetMainUI():GetHurdleCollectBoxUi();
                if ui then
                    return ui:GetScore() > param;
                end
            else
                return false;
            end
        end
    }

----------------------------MOBA得星条件----------------
    --没有精英塔被摧毁（关卡MOBA）
    condition.moba_no_elite_killed =
    {
        check = function(param)
            if FightScene.GetFightManager().IsNoEliteKilled then
                return FightScene.GetFightManager():IsNoEliteKilled(param);
            else
                return false;
            end
        end
    };
    --成功击败敌方英雄（关卡MOBA）
    condition.moba_kill_enemy_hero =
    {
        check = function(param)
            if FightScene.GetFightManager().IsKillEnemyHero then
                return FightScene.GetFightManager():IsKillEnemyHero(param);
            else
                return false;
            end
        end
    }
    --造成敌方英雄团灭N次（关卡MOBA）
    condition.moba_enemy_team_dead =
    {
        check = function(param)
            if FightScene.GetFightManager().IsEnemyTeamDead then
                return FightScene.GetFightManager():IsEnemyTeamDead(param);
            else
                return false;
            end
        end
    }
    --击杀敌方N个精英（关卡MOBA）
    condition.moba_kill_elite_count =
    {
        check = function(param)
            if FightScene.GetFightManager().GetKillEliteTowerCnt then
                return FightScene.GetFightManager():GetKillEliteTowerCnt(EFightInfoFlag.flag_a) >= param;
            else
                return false;
            end
        end
    }
    --击杀敌方N个守卫（关卡MOBA）
    condition.moba_kill_guard_count =
    {
        check = function(param)
            if FightScene.GetFightManager().GetKillGuardTowerCnt then
                return FightScene.GetFightManager():GetKillGuardTowerCnt(EFightInfoFlag.flag_a) >= param;
            else
                return false;
            end
        end
    }
    --N秒内击杀任意敌方精英（关卡MOBA）
    condition.moba_kill_elite_in_time =
    {
        check = function(param)
            if FightScene.GetFightManager().IsKillEliteTowerInTime then
                return FightScene.GetFightManager():IsKillEliteTowerInTime(param);
            else
                return false;
            end
        end
    }
    --完成N次双杀（关卡MOBA）
    condition.moba_kill_2 =
    {
        check = function(param)
            if FightScene.GetFightManager().GetKill_N_Cnt then
                return FightScene.GetFightManager():GetKill_N_Cnt(2) >= param;
            else
                return false;
            end
        end
    }
    --完成N次三杀（关卡MOBA）
    condition.moba_kill_3 =
    {
        check = function(param)
            if FightScene.GetFightManager().GetKill_N_Cnt then
                return FightScene.GetFightManager():GetKill_N_Cnt(3) >= param;
            else
                return false;
            end
        end
    }
    --敌方死亡N个精英（关卡MOBA）
    condition.moba_elite_dead_count =
    {
        check = function(param)
            if FightScene.GetFightManager().GetEliteTowerDeadCnt then
                return FightScene.GetFightManager():GetEliteTowerDeadCnt(EFightInfoFlag.flag_b) >= param;
            else
                return false;
            end
        end
    }
    --敌方死亡N个守卫（关卡MOBA）
    condition.moba_guard_dead_count =
    {
        check = function(param)
            if FightScene.GetFightManager().GetGuardTowerDeadCnt then
                return FightScene.GetFightManager():GetGuardTowerDeadCnt(EFightInfoFlag.flag_b) >= param;
            else
                return false;
            end
        end
    }
    --己方英雄杀死英雄总数量（关卡MOBA）
    condition.moba_kill_all_enemy_hero =
    {
        check = function(param)
            if FightScene.GetFightManager().IsKillEnemyHero then
                return FightScene.GetFightManager():IsKillEnemyHero(param, false);
            else
                return false;
            end
        end
    }

    condition.score_gt_and_eq =
    {
        check = function( param )
            if FightScene.GetFightManager().GetScore then
                return FightScene.GetFightManager():GetScore() >= param
            else
                return false
            end
        end
    }
    condition.score_lt =
    {
        check = function( param )
           if FightScene.GetFightManager().GetScore then
                return FightScene.GetFightManager():GetScore() < param
            else
                return false
            end
        end
    }
    condition.end_score_lt = 
    {
        check = function(param)
            local isFailed = false;
            local canLoad = FightScene.GetFightManager():MonsterLoaderCanLoader();
            if canLoad then
                return false;
            end
            --app.log("不能刷怪了")
            local notHave = g_dataCenter.fight_info:IsHaveMonster(g_dataCenter.fight_info.single_enemy_flag)
            if not notHave then
                return false;
            end
            --app.log("没怪了")
            if FightScene.GetFightManager().GetScore then
                isFailed = FightScene.GetFightManager():GetScore() < param
                --app.log("分数=="..tostring(FightScene.GetFightManager():GetScore()));
            end
            return isFailed;
        end
    }
    condition.is_attack = 
    {
        check = function ( param )
            local ret = FightRecord.GetIsAttack(param);
            -- app.log("is_attack:" .. tostring(ret));
            return ret;
        end
    }
    --（己方/敌方）击杀了boss（远征争夺首领战）
    condition.camp_kill_boss =
    {
        check = function(param)
            if FightScene.GetFightManager().GetCampFlagKillBoss then
                return FightScene.GetFightManager():GetCampFlagKillBoss(param) == true;
            else
                return false;
            end
        end
    }

------------------------------------------------------

-- 战斗星数计算条件表
FightCondition = {}
-- function FightCondition.Check( k, v, flag )
-- 	if condition[k] then
-- 		return condition[k].check(v,flag)
-- 	else
-- 		return false
-- 	end
-- end

-- checkid == 0 表示上阵英雄中任意一个英雄
function FightCondition.GetHeroOrNPCID(obj, checkid)

    if type(checkid) == 'number' and checkid >=0 and checkid <= 3 then
        local fi = g_dataCenter.fight_info
        if checkid == 0 then
            if fi:IsInControlHero(obj:GetName()) then
                return checkid
            else
                return -1
            end
        elseif fi:GetControlHeroName(checkid) == obj:GetName() then
            return checkid;
        else
            return -1
        end
    end

    local id = nil
    if obj:IsHero() then
        id = obj:GetConfig("default_rarity")
    else
        id = obj:GetConfig("id")
    end
    return id
end

function FightCondition.HeroIndexToID(index)

    local id = {}
    local fi = g_dataCenter.fight_info
    if index == 0 then
        local heroList = fi:GetControlHeroList()
        for k,name in ipairs(heroList) do
            local hero = GetObj(name)
            if hero then
                table.insert(id, hero:GetConfig("default_rarity"))
            end
        end
    elseif index >= 1 or index <= 3 then  
        local hero = GetObj(fi:GetControlHeroName(index))
        if hero then
            table.insert(id, hero:GetConfig("default_rarity"))
        end
    end

    return id
end

function FightCondition.Check( k, parm )
	if condition[k] then
		return condition[k].check(parm)
	else
		return false
	end
end

--有计数类型的条件
function FightCondition.HasProgress(k)
	local cond = condition[k]
	if cond and cond.get_progress then
		return true
	else
		return false
	end
end

--获取当前进度。
--返回: return 85,100
function FightCondition.GetProgress(k, parm)
	local cond = condition[k]
	if cond and cond.get_progress then
		return cond.get_progress(parm)
	else
		return nil
	end
end

--[[获取某关的条件说明，返回一个表，分别是三条条件]]
function FightCondition.GetHurdleCondiDes(hurdleid)

	local copyData = ConfigHelper.GetHurdleConfig(hurdleid);
	if not copyData then return; end;
	local c_str = {}
    for i=1,3 do
		local conditionStr = "";
		if i == 1 then
			conditionStr = copyData.win_describe;
		elseif i == 2 then
			conditionStr = copyData.good_describe;
		elseif i == 3 then
			conditionStr = copyData.perfact_describe;
		end
		c_str[i] = conditionStr
    end
    return c_str
end


