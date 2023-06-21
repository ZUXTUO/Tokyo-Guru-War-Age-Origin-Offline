
EquipRecommendChecker = Class("EquipRecommendChecker")

function EquipRecommendChecker:Init()
    self.InRecommendingPosSet = {}
    self.InRecommendingEquipSet = {}

end

function EquipRecommendChecker:Start()

    if self.started == true then
        return
    end

    self.started = true

    self.checkfun = Utility.bind_callback(self, self.Update)
    PublicFunc.msg_regist(msg_cards.gc_add_equip_cards, self.checkfun)
end

function EquipRecommendChecker:Stop()
    if self.started == false then
        return
    end
    self.started = false

    PublicFunc.msg_unregist(msg_cards.gc_add_equip_cards, self.checkfun)
    Utility.unbind_callback(self, self.Update)
end

function EquipRecommendChecker:Update()

    if self.started == false and self.started == false then
        return
    end

    local defaultTeam = g_dataCenter.player:GetDefTeam()

    local heroEmptyEquipPos = {}
    local needTypeEquips = {}
    for rolek, roledataid in pairs(defaultTeam) do
        if roledataid then
            local role = g_dataCenter.package:find_card(ENUM.EPackageType.Hero,roledataid);

            if role then
                local emptyPos = role:GetEmptyEquipPos()
                if #emptyPos > 0 then
                    --app.log('t1 ' .. table.tostring(self.InRecommendingPosSet))
                    if self.InRecommendingPosSet[rolek] ~= nil then
                        for i=#emptyPos,1,-1 do
                            if self.InRecommendingPosSet[rolek][emptyPos[i]] == true then
                                table.remove(emptyPos, i)
                            end
                        end
                    end
                    --app.log('t2 ' .. table.tostring(emptyPos))
                end

                if #emptyPos > 0 then
                   local heroType = role.config.hero_type

                   heroEmptyEquipPos[rolek] = {ht = heroType, pos = emptyPos, index = rolek, dataid = roledataid}
                   needTypeEquips[heroType] = needTypeEquips[heroType] or {}
                   for index,pos in ipairs(emptyPos) do
                        if pos == ENUM.EEquipPosition.Accessories2 then
                            pos = ENUM.EEquipPosition.Accessories1
                        end
                        needTypeEquips[heroType][pos] = needTypeEquips[heroType][pos] or {}
                   end
                end
            end

        end
    end
    if table.get_num(needTypeEquips) > 0 then
        local equips = g_dataCenter.package:GetCard(ENUM.EPackageType.Equipment)
        for dataid, equip in pairs(equips) do
            if self.InRecommendingEquipSet[dataid] ~= true and not equip:HasEquiped() then
                local isUsed = false
                for t,posValue in pairs(needTypeEquips) do
                    local typeConfig = g_preprocessed_eqip_recommend[t]
                    if typeConfig then
                          for pos,posNeedEquips in pairs(posValue) do
                            if equip.position == pos then
                                local index = typeConfig[equip.default_rarity]
                                --app.log('did ' .. tostring(dataid) .. ' number ' .. tostring(equip.default_rarity))
                                if index ~= nil then
                                    table.insert(posNeedEquips, {did = dataid, ind = index})
                                    isUsed = true

                                    break
                                else
                                    --app.log('this type not config this equip')
                                end
                            end
                          end
                    end

                    if isUsed then
                        break
                    end
                end
            end
        end
    else
        return
    end
    for type,posValue in pairs(needTypeEquips) do
        for pos,equips in pairs(posValue) do
            table.sort(equips, function (a, b)
                if a.ind > b.ind then
                    return true
                end
                return false
            end
            )
        end
    end
    --app.log('x1 ' .. table.tostring(needTypeEquips))
    for k,v in pairs(heroEmptyEquipPos) do
        local typeEquips = needTypeEquips[v.ht]
        for kp,pos in ipairs(v.pos) do
            local equips = typeEquips[pos]

            if pos == ENUM.EEquipPosition.Accessories2 then
                equips = typeEquips[ENUM.EEquipPosition.Accessories1]
            end

            if #equips > 0 then
                local dataid = equips[#equips].did
                table.remove(equips, #equips)
                --app.log('xxxx1 ' .. tostring(pos))
                RecommendMgr.Inst():AddRecommendAction(EquipRecommendAction:new({teamIndex = k, heroDataid = v.dataid, equipDataid = dataid, equipPos = pos, 
                    uiClass = EquipRecommandAndEquipUI, checker = self}))
                self.InRecommendingEquipSet[dataid] = true
                self.InRecommendingPosSet[k] = self.InRecommendingPosSet[k] or {}
                self.InRecommendingPosSet[k][pos] = true
            end
        end
        
    end
    
end

function EquipRecommendChecker:RecommandActionEnd(action)
    if type(action) == 'table' then
        self.InRecommendingEquipSet[action:GetEquipDataid()] = nil
        self.InRecommendingPosSet[action:GetHeroTeamIndex()][action:GetEquipPos()] = nil

        --app.log('RecommandActionEnd ')
    end
end