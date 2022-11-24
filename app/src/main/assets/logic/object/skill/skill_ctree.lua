--[[
region skill_ctree.lua
date: 2015-8-3
time: 11:51:52
author: Nation
技能条件树
]]

SkillCTree = {}
function SkillCTree.CheckCondition( condition, srcobj, desobj, thirdobj )
    SkillCTree.retCode = eSkillConditionRst.OK
    SkillCTree.retMsg = ""
    SkillCTree.srcObj = srcobj
    SkillCTree.desObj = desobj
    SkillCTree.thirdobj = thirdobj
    local checkRet = {}
    SkillCTree.CheckNode( condition.node[1], checkRet )
	return checkRet[1]
end

function SkillCTree.CheckNode( node, checkRet )
    if node.node == nil then
        local lvalue = SkillCTree.GetValue(node, true)
        local rvalue = SkillCTree.GetValue(node, false)
        if node.calc == "or" then
            table.insert(checkRet, (lvalu or rvalue))
        elseif node.calc == "equal" then
            table.insert(checkRet, (lvalue == rvalue))
        elseif node.calc == "and" then
            table.insert(checkRet, (lvalue and rvalue))
        elseif node.calc == "greater" then
            table.insert(checkRet, (lvalue > rvalue))
        elseif node.calc == "less" then
            table.insert(checkRet, (lvalue < rvalue))
        elseif node.calc == "greater_equal" then
            table.insert(checkRet, (lvalue >= rvalue))
        elseif node.calc == "less_equal" then
            table.insert(checkRet, (lvalue <= rvalue))
        end
    else
        local _checkRet = {}
        local len = #node.node
        for i=1, len do
            SkillCTree.CheckNode( node.node[i], _checkRet )
        end
        local retLen = #_checkRet
        local ret = nil
        if node.calc == "or" then
            for i=1, retLen do
                ret = (ret or _checkRet[i])
            end
        elseif node.calc == "equal" then
            if retLen == 1 then
                ret = _checkRet[1]
            else
                ret = (_checkRet[1] == _checkRet[2])
            end
        elseif node.calc == "and" then
            if retLen == 1 then
                ret = _checkRet[1]
            else
                ret = _checkRet[1]
                for i=2, retLen do
                    ret = (ret and _checkRet[i])
                end
                --ret = (_checkRet[1] and _checkRet[2])
            end
        elseif node.calc == "greater" then
            if retLen == 1 then
                ret = (_checkRet[1] > 0)
            else
                ret = (_checkRet[1] > _checkRet[2])
            end
        elseif node.calc == "less" then
            if retLen == 1 then
                ret = (_checkRet[1] < 0)
            else
                ret = (_checkRet[1] < _checkRet[2])
            end
        elseif node.calc == "greater_equal" then
            if retLen == 1 then
                ret = (_checkRet[1] >= 0)
            else
                ret = (_checkRet[1] >= _checkRet[2])
            end
        elseif node.calc == "less_equal" then
            if retLen == 1 then
                ret = (_checkRet[1] <= 0)
            else
                ret = (_checkRet[1] <= _checkRet[2])
            end
        end
        table.insert(checkRet, ret)
    end
end

function SkillCTree.GetValue(node, bleft)
    if bleft == true and node.ltype == nil then
        return nil
    elseif bleft == false and node.rtype == nil then
        return nil
    else
		if bleft then
			return SkillCTree.WAF[node.ltype](node, bleft)
		else
			return SkillCTree.WAF[node.rtype](node, bleft)
		end

    end
end

SkillCTree.WAF = {
    [1] = function(node, bleft) --1 直接取值
        if bleft then
            return node.lparam1
        else
            return node.rparam1
        end

    end,
	[2] = function(node, bleft) --2 检查是否存在BUFF
        local obj = nil
        local buffid = nil
        local bufflevel = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            end
            buffid = node.lparam2
            bufflevel = node.lparam3
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            end
            buffid = node.rparam2
            bufflevel = node.rparam3
        end
        if obj ~= nil then
		    return obj:IsBuffExist(buffid, bufflevel)
        else
            return false
        end
	end,
    [3] = function(node, bleft)
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            end
        end
        return obj:IsHide()
    end,
    [4] = function(node, bleft) --4 周围玩家是否存在BUFF
        local obj = nil
        local buffid = nil
        local bufflevel = nil
        local radius = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            end
            buffid = node.lparam2
            bufflevel = node.lparam3
            radius = node.lparam4
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            end
            buffid = node.rparam2
            bufflevel = node.rparam3
            radius = node.rparam4
        end
        if obj ~= nil then
		    return obj:IsAreaTargetExistBuff(radius, buffid, bufflevel)
        else
            return false
        end
	end,
    [5] = function(node, bleft) --5 前方是否存在敌人
        local obj = nil
        local angle = nil
        local radius = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            end
            angle = node.lparam2
            radius = node.lparam3
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            end
            angle = node.rparam2
            radius = node.rparam3
        end
        if obj ~= nil then
            local target = {}
            obj:SearchAreaTarget(true, radius, obj, target, nil, angle, nil, nil, false, nil, nil, nil)
            return #target
        else
            return 0
        end
	end,
    [6] = function(node, bleft) --6. 获取玩家BUFF层数
        local obj = nil
        local buffid = nil
        local bufflevel = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            end
            buffid = node.lparam2
            bufflevel = node.lparam3
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            end
            buffid = node.rparam2
            bufflevel = node.rparam3
        end
        if obj ~= nil then
		    return obj:GetBuffOverlap(buffid, bufflevel)
        else
            return 0
        end
	end,
    [7] = function(node, bleft) --7 检测周围友方数量
        local obj = nil
        local radius = nil
        local type = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            end
            radius = node.lparam2
            type = node.lparam3
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            end
            radius = node.rparam2
            type = node.rparam3
        end
        if obj ~= nil then
            local arrTarget = {}
            obj:SearchAreaTarget(true, radius, obj, arrTarget, nil, 360, nil, nil, false, nil, nil, nil)
            for i=1, #arrTarget do
                if bit.bit_and(arrTarget[i]:GetObjType(), type) ~= 0 then
                    return true
                end
            end
        else
            return false
        end
	end,
    [8] = function(node, bleft) --8 检测玩家属性值
        local obj = nil
        local radius = nil
        local abilityType = nil
        local valueType = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            end
            abilityType = node.lparam2
            valueType = node.lparam3
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            end
            abilityType = node.rparam2
            valueType = node.rparam3
        end
        if obj ~= nil then
		    local value = obj:GetPropertyVal(abilityType)
            if valueType == 0 then
                return value
            else
                if abilityType == "cur_hp" then
                    local maxValue = obj:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
                    return value/maxValue
                end
                return 0
            end
        else
            return 0
        end
	end,
    [9] = function(node, bleft) --9 检测玩家前方单位数量
        local obj = nil
        local witdh = nil
        local length = nil
        local enemy = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            end
            witdh = node.lparam2
            length = node.lparam3
            enemy = node.lparam4
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            end
            witdh = node.rparam2
            length = node.rparam3
            enemy = node.rparam4
        end
        if obj ~= nil then
            local arrTarget = {}
		    obj:SearchRectangleTarget(enemy, length, witdh, obj, arrTarget, nil, nil, false, nil, nil, nil)
            return #arrTarget
        else
            return 0
        end
	end,
    [11] = function(node, bleft) --11 检测_arrThirdTarget结果数量
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj:GetBuffManager()
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj:GetBuffManager()
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        local num = 0;
        if obj ~= nil then
            if obj._arrThirdTarget then
                num = #obj._arrThirdTarget
            else
                num =0
            end
        else
            num =0
        end
        return num
	end,
    [12] = function(node, bleft) --12 检测玩家是否在战斗状态
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        if obj ~= nil then
            if obj:IsMyControl() then
                return g_dataCenter.fight_info:IsInFight()
            else
                return (obj.fight_state_targets_cnt ~= 0)
            end 
        else
            return false
        end
	end,
    [13] = function(node, bleft) --13 检测_arrCallBackTarget结果数量
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        local num = 0;
        if obj ~= nil then
            if obj._arrCallBackTarget then
                num = #obj._arrCallBackTarget
            end
        end
        return num
    end,
    [14] = function(node, bleft) --14 检测是否特殊状态
        local obj = nil
        local special_effect_type = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
            special_effect_type = node.lparam2
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
            special_effect_type = node.rparam2
        end
        if obj ~= nil then
            return obj:GetBuffManager():IsInSpecialEffect(special_effect_type)
        end
        return nil
    end,
    [15] = function(node, bleft) --15 检测_arrThirdTarget具体下标单位是否存活
        local obj = nil
        local target_index = 1
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
            target_index = node.lparam2
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
            target_index = node.rparam2
        end
        local num = 0;
        if obj ~= nil then
            if obj._arrThirdTarget then
                if obj._arrThirdTarget[target_index] ~= nil then
                    return (obj._arrThirdTarget[target_index]:IsDead() == false)
                else
                    local len = #obj._arrThirdTarget
                    local index = (target_index%len)+1
                    if obj._arrThirdTarget[index] then
                        return (obj._arrThirdTarget[index]:IsDead() == false)
                    end
                end
            else
                return false
            end
        else
            return false
        end
        return false
	end,
    [16] = function(node, bleft) --14 检测阵容是是否有某英雄
        local obj = nil
        local default_rarity = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
            default_rarity = node.lparam2
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
            default_rarity = node.rparam2
        end
        if obj ~= nil then
            return g_dataCenter.fight_info:IsHeroExist(obj.owner_player_gid, default_rarity)
        end
        return nil
    end,
    [17] = function(node, bleft) --17 检测职业
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        if obj ~= nil then
            return obj:GetProfession()
        end
        return nil
    end,
    [18] = function(node, bleft) --12 检测角色是否为自己控制的
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        if obj ~= nil then
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
                return (obj:IsMyControl() or obj:IsAIAgent())
            else
                return true
            end
        else
            return false
        end
    end,
    [19] = function(node, bleft) --19 检测_arrThirdTarget第一个结果和srcobj的距离
        local target_obj = nil
        local src_obj = nil
        if bleft then
            src_obj = SkillCTree.srcObj
            if node.lparam1 == 0 then
                target_obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                target_obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                target_obj = SkillCTree.thirdobj._arrThirdTarget[1]
            end
        else
            src_obj = SkillCTree.srcObj
            if node.rparam1 == 0 then
                target_obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                target_obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                target_obj = SkillCTree.thirdobj._arrThirdTarget[1]
            end
        end
        if target_obj and src_obj then
            local target_pos = target_obj:GetPosition()
            local src_pos = src_obj:GetPosition()
            return algorthm.GetDistance(target_pos.x, target_pos.z, src_pos.x, src_pos.z)
        end
        return 9999
    end,
    [20] = function(node, bleft) --20 检测obj.buff_manager._arrThirdTarget结果数量
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        local num = 0;
        if obj ~= nil then
            if obj:GetBuffManager() then
                num = #obj:GetBuffManager()._arrThirdTarget
            else
                num =0
            end
        else
            num =0
        end
        return num
    end,
    [21] = function(node, bleft) --21 检测obj._buff._arrThirdTarget结果数量
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        local num = 0;
        if obj ~= nil then
            if obj._buff then
                num = #obj._buff._arrThirdTarget
            else
                num =0
            end
        else
            num =0
        end
        return num
    end,
    [22] = function(node, bleft) --22 检测obj召唤怪物数量 param1=目标(0源头 1目标 2第三方)
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        local num = 0;
        if obj ~= nil then
            if obj and obj.summon_monster_list then
                num = table.getall(obj.summon_monster_list)
            else
                num =0
            end
        else
            num =0
        end
        return num
    end,
    [23] = function(node, bleft) --23 检测obj存储的伤害值 param1=目标(0源头 1目标 2第三方)
        local obj = nil
        if bleft then
            if node.lparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.lparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        else
            if node.rparam1 == 0 then
                obj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                obj = SkillCTree.desObj
            elseif node.rparam1 == 2 then
                obj = SkillCTree.thirdobj
            end
        end
        local num = 0;
        if obj ~= nil then
            num = obj:GetBuffManager()._nRecordDamage
        end
        return num
    end,
    [24] = function(node, bleft) --检测英雄死亡数量 param1=目标(0源头 1目标）
        local targetObj = nil
        if bleft then
            if node.lparam1 == 0 then
                targetObj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                targetObj = SkillCTree.desObj
            end
        else
            if node.rparam1 == 0 then
                targetObj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                targetObj = SkillCTree.desObj
            end
        end
        local num = 0;
        if targetObj ~= nil then
            g_dataCenter.fight_info:foreach_obj(targetObj:GetCampFlag(),true
                , function (obj_name)
                    if obj_name == targetObj:GetName() then
                        return;
                    end
                    local obj = ObjectManager.GetObjectByName(obj_name);
                    if obj:GetOwnerPlayerGID() ~= targetObj:GetOwnerPlayerGID() then
                        return;
                    end
                    if obj:IsDead() then
                        num = num + 1;
                    end
                end)
        end
        return num
    end,
    [25] = function(node, bleft) --检测记录的数据与属性比 param1=目标(0源头 1目标）param2=记录名字 param3=属性类型
        local targetObj = nil
        if bleft then
            if node.lparam1 == 0 then
                targetObj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                targetObj = SkillCTree.desObj
            end
        else
            if node.rparam1 == 0 then
                targetObj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                targetObj = SkillCTree.desObj
            end
        end
        local num = 0;
        if targetObj ~= nil then
            local ability = targetObj:GetPropertyVal(node.lparam3);
            local record = targetObj:GetExternalArea(node.lparam2) or 0;
            num = record/ability;
        end
        return num
    end,
    [26] = function(node, bleft) --检测是否在技能创建者前面 param1=目标(0源头 1目标）
        local targetObj = nil
        if bleft then
            if node.lparam1 == 0 then
                targetObj = SkillCTree.srcObj
            elseif node.lparam1 == 1 then
                targetObj = SkillCTree.desObj
            end
        else
            if node.rparam1 == 0 then
                targetObj = SkillCTree.srcObj
            elseif node.rparam1 == 1 then
                targetObj = SkillCTree.desObj
            end
        end
        local isFront = false;
        if targetObj ~= nil then
            local skillCreator = ObjectManager.GetObjectByName(SkillCTree.thirdobj._buff._skillCreator)
            if skillCreator then
                local pos = targetObj:GetPosition()
                local direct = targetObj:GetForWard()
                local target_pos = skillCreator:GetPosition()
                if algorthm.AtSector(pos.x, pos.z, 100, direct, 180, target_pos.x, target_pos.z) then
                    isFront = true;
                end 
            end
        end
        return isFront
    end,
}
--[[endregion]]