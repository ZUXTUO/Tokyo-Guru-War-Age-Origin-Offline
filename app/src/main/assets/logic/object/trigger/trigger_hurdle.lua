
EnterHurdleFightTrigger = Class('EnterHurdleFightTrigger', TriggerBase);

HurdleFightOverTrigger = Class('HurdleFightOverTrigger', TriggerBase);

ThreeToThreeFightOverTrigger = Class('ThreeToThreeFightOverTrigger', TriggerBase);

MyHeroPropertyTrigger = Class('MyHeroPropertyTrigger', TriggerBase);

MonsterEnterFightTrigger = Class('MonsterEnterFightTrigger', TriggerBase);

MonsterDeadTrigger = Class('MonsterDeadTrigger', TriggerBase)

CutsceneEndTrigger = Class('CutsceneEndTrigger', TriggerBase)

PlayerUseItemTrigger = Class('PlayerUseItemTrigger', TriggerBase)

MonsterLoaderTrigger = Class('MonsterLoaderTrigger', TriggerBase)

AddBuffTrigger = Class('AddBuffTrigger', TriggerBase)

FinishClearingTrigger = Class('FinishClearingTrigger', TriggerBase)

function EnterHurdleFightTrigger:IsTrigger()
	return true;
end

--------------------------------------------------------------------------------------------------------

function HurdleFightOverTrigger:IsTrigger(hurdleid, isWin)
	if self.config.trigger_param == 0 then
		return true;
	end
	return isWin == (self.config.trigger_param == 1);
end

function ThreeToThreeFightOverTrigger:IsTrigger(hurdleid, isWin)
    return isWin == (self.config.trigger_param == 1);
end


---------------------------------------------------------------------------------------------------------

function MyHeroPropertyTrigger:IsTrigger(role,property_type,lastvalue)
	if not self.config.trigger_param then
		return false;
	end
	-- self.config.trigger_param = {{type,val},{type,val}}
	local bok = false;
	local bmyproperty = false;
	for k,v in pairs(self.config.trigger_param) do
		if ENUM.EHeroAttribute[v[1]] == property_type then
			bmyproperty = true;
			break;
		end
	end
	if SCREENPLAY_DEBUG then
		--app.log('huhu_screenplay_debug 英雄属性改变触发器 '..' bmyproperty:'..tostring(bmyproperty)..'\n'..table.tostring(self.config)..'\n'..tostring(property_type))
	end
	-- 如果这次改变没有改变到我要的属性，则不需要触发了。
	if not bmyproperty then
		return false;
	end
	for k,v in pairs(self.config.trigger_param) do
		-- local val = role:GetPropertyVal(v[1]);
		-- note:数量如果是负数，则表示是小于等于对应值；如果是正数则是大于等于
		-- note:当属性是当前血量时，特殊处理：如果数字是小数，则表示是属性比例。
		-- note:多个属性要求的话，要都满足才可以。
		if v[2] > 0 then
			if role:CheckPropertyMoreThen(v[1],v[2]) then
				bok = true;
			else
				bok = false;
				break;
			end
		else
			if role:CheckPropertyLessThen(v[1],math.abs(v[2])) then
				bok = true;
			else
				bok = false;
			end
		end
	end
	return bok;
end

---------------------------------------------------------------------------------
function MonsterEnterFightTrigger:MsgRegist()
	NoticeManager.BeginListen(ENUM.NoticeType.MonsterEnterFight, self.bindfunc["OnEntityEnterFight"])
end

function MonsterEnterFightTrigger:MsgUnRegist()
	NoticeManager.EndListen(ENUM.NoticeType.MonsterEnterFight, self.bindfunc["OnEntityEnterFight"])
end

function MonsterEnterFightTrigger:registFunc()
	TriggerBase.registFunc(self)
    self.bindfunc["OnEntityEnterFight"] = Utility.bind_callback(self,self.OnEntityEnterFight);
end

function MonsterEnterFightTrigger:OnEntityEnterFight(enterFightObj)

	--目前只有怪物需要
	if not enterFightObj or not enterFightObj:IsMonster() then
		return
	end

    local isTriggered = false
	local triggerRole = self.config.trigger_role;
	if type(triggerRole) == "table" then
        for k,v in ipairs(triggerRole) do
            local groupName = v.group_name
            if groupName then
                local group = ObjectManager.GetGroup(groupName)
                if group then
                    for entityName,isTrue in pairs(group) do
                        if entityName == enterFightObj:GetName() then
                            isTriggered = true
                            break
                        end
                    end
                end
            elseif v.objType == OBJECT_TYPE.MONSTER then
                if v.id then
                    if type(v.id) == "table" then
                        for k, v in pairs(v.id) do
                            if v == enterFightObj.card.number then
                                isTriggered = true
                                break;
                            end
                        end	
                    elseif v.id == enterFightObj.card.number then
                        isTriggered = true
                    end
                end
            end

            if isTriggered then
                break
            end
        end


		if isTriggered then
			self:TriggerEffect()
		end
	end
end

------------------------------------------------------------------------
function MonsterDeadTrigger:MsgRegist()
	NoticeManager.BeginListen(ENUM.NoticeType.EntityDead, self.bindfunc["OnEntityDead"])
end

function MonsterDeadTrigger:MsgUnRegist()
	NoticeManager.EndListen(ENUM.NoticeType.EntityDead, self.bindfunc["OnEntityDead"])
end

function MonsterDeadTrigger:registFunc()
	TriggerBase.registFunc(self)
    self.bindfunc["OnEntityDead"] = Utility.bind_callback(self,self.OnEntityDead);
end

function MonsterDeadTrigger:OnEntityDead(entity)

	--目前只有怪物需要
	if not entity or not entity:IsMonster() then
		return
	end

    local deadIsInGroup = false
	local triggerRole = self.config.trigger_role;
	if type(triggerRole) == "table" then
        --{{group_name = 'momnster1',id = {5,3,2,},},{group_name = 'monster2',id = {55,33,},},}
        local isTriggered = false;
        for k,v in ipairs(triggerRole) do

            isTriggered = false

            local ids = {}
            local checkAllGroupMember = false
            if type(v.id) == 'number'  then
                ids[v.id] = true
            elseif type(v.id) == 'table' then
                for idk,idv in ipairs(v.id) do
                    ids[idv] = true
                end
            elseif v.id == nil then
                checkAllGroupMember = true
            else
                return
            end

            local groupName = v.group_name
            if groupName then
                local group = ObjectManager.GetGroup(groupName)
                if group then
                    isTriggered = true
                    for entityName,isTrue in pairs(group) do
                        if isTrue then
                            local en = GetObj(entityName)

                            if entityName == entity:GetName() then
                                deadIsInGroup = true
                            end

                            if en and (checkAllGroupMember or ids[en:GetConfigNumber()]) and not en:IsDead() then
                                isTriggered = false
                                break
                            end
                        end
                    end
                end
            end

            if not isTriggered then
                break
            end

        end
        
        if isTriggered and deadIsInGroup then
            self:TriggerEffect(entity:GetName())
        end

	end
end

----------------------------------------------------------------------
function CutsceneEndTrigger:MsgRegist()
    NoticeManager.BeginListen(ENUM.NoticeType.ScreenPlayOver, self.bindfunc["OnCutsceneEnd"])
end

function CutsceneEndTrigger:MsgUnRegist()
    NoticeManager.EndListen(ENUM.NoticeType.ScreenPlayOver, self.bindfunc["OnCutsceneEnd"])
end

function CutsceneEndTrigger:registFunc()
	TriggerBase.registFunc(self)
    self.bindfunc["OnCutsceneEnd"] = Utility.bind_callback(self,self.OnCutsceneEnd);
end

function CutsceneEndTrigger:OnCutsceneEnd(cutsceneid)
    local triggerRole = self.config.trigger_role;

    --{id = {3,4,},}
    if type(triggerRole.id) == 'number' then
        if triggerRole.id == cutsceneid then
            self:TriggerEffect()
        end
    else
        for k,v in ipairs(triggerRole.id) do
            if v == cutsceneid then
                self:TriggerEffect()
                break
            end
        end
        
    end
end

----------------------------------------------------------------------
function PlayerUseItemTrigger:MsgRegist()
    NoticeManager.BeginListen(ENUM.NoticeType.PlayerUseItem, self.bindfunc["OnUseItem"])
end

function PlayerUseItemTrigger:MsgUnRegist()
    NoticeManager.EndListen(ENUM.NoticeType.PlayerUseItem, self.bindfunc["OnUseItem"])
end

function PlayerUseItemTrigger:registFunc()
	TriggerBase.registFunc(self)
    self.bindfunc["OnUseItem"] = Utility.bind_callback(self,self.OnUseItem);
end

function PlayerUseItemTrigger:OnUseItem(triggersID)
    if type(triggersID) ~= 'table' then
        return 
    end
    if table.index_of(triggersID, self.config.trigger_id) > 0 then
        self:TriggerEffect()
    end
end

----------------------------------------------------------------------
-- loader_type  1 开始一小波 2 结束一小波 3 击杀完一小波 4 结束一大波 5 开始一大波 6 击杀完一大波
function MonsterLoaderTrigger:IsTrigger(loader_type, cur_groud, cur_wave)
    self.curGroud = cur_groud or self.curGroud;
    self.curWave = cur_wave or self.curWave;
    local param = self.config.trigger_param;
    if type(param) ~= "table" then
        return false;
    end
    if loader_type ~= param.loader_type then
        return false;
    end
    if (self.curGroud or 1) == (param.groud or 1) 
        and (self.curWave or 1) == (param.wave or 1)
        then
        return true;
    end
    return false;
end


---------------------------------------------------------------------
function AddBuffTrigger:IsTrigger(buffid, bufflv)
    local buffList = self.config.trigger_param;
    if type(buffList) ~= "table" then
        return true;
    end
    for k,buffInfo in ipairs(buffList) do
        if type(buffInfo) == "table" then
            if buffInfo.id == buffid and buffInfo == bufflv then
                return true;
            end
        end
    end
    return false;
end

-----------------------------------------------------------------------
function FinishClearingTrigger:IsTrigger()
    return true;
end