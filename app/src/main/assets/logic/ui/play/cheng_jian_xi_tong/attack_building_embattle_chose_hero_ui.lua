
AttackBuildingEmbattleChoseHeroUI = Class("AttackBuildingEmbattleChoseHeroUI", FormationUi)

--[[
    self.currentTeam = 
    {
        team = {dataid, dataid, dataid},
        pos = {pos, pos, pos},
    }
]]
function AttackBuildingEmbattleChoseHeroUI:SetTeamAndPos(teamAndPosInAndOut)
    self.teamAndArrangePos = teamAndPosInAndOut

    self.teamInfo = teamAndPosInAndOut.team
    self.pos = teamAndPosInAndOut.pos
    self:UpdateUi();
end

function AttackBuildingEmbattleChoseHeroUI:on_arrange()
    -- local ui = uiManager:PushUi(EUI.ArrangeBattleUI);
    -- ui:SetTeam(self.teamInfo,self.pos,nil,nil);
    -- ui:SetResultCallback(self.bindfunc["on_set_team_pos"]); 
end

function AttackBuildingEmbattleChoseHeroUI:on_set_team_pos(team_pos, monster_pos)
    for k,v in pairs(team_pos) do
        self.pos[k] = v
    end
    
end

function AttackBuildingEmbattleChoseHeroUI:on_save()
    
end

function AttackBuildingEmbattleChoseHeroUI:on_init_item(obj, b, real_index)
    FormationUi.on_init_item(self, obj, b, real_index)

    local hasDeadHero = CityRobberyMgr.GetInst():GetHasDeadHeros()
    if hasDeadHero[ self.heroObj[b].obj:GetCardInfo().index ] == true then
        self.heroObj[b].obj:SetGray(true)
    else
        self.heroObj[b].obj:SetGray(false)
    end
end

function AttackBuildingEmbattleChoseHeroUI:on_chose_hero(obj,info)
    local hasDeadHero = CityRobberyMgr.GetInst():GetHasDeadHeros()
    if hasDeadHero[ info.index ] then
        HintUI.SetAndShow(EHintUiType.zero, gs_misc['str_36']);
    else    
        FormationUi.on_chose_hero(self, obj, info)
    end
end

function AttackBuildingEmbattleChoseHeroUI:CheckChangeTeam()
    return false
end

--[[
AttackBuildingEmbattleChoseHeroUI = Class("AttackBuildingEmbattleChoseHeroUI", BuildingEmbattleChoseHeroUI);

function AttackBuildingEmbattleChoseHeroUI:InitCard(small_card, info)

    small_card:SetTeamPosIcon(0);

    local hasDeadHero = CityRobberyMgr.GetInst():GetHasDeadHeros() --CityRobberyMgr.GetInst():GetPlayerHasUsedHero()
    if hasDeadHero[info.index] == true or self:HasSelect(info.index) then
        small_card:SetTranslucent(true);

        if hasDeadHero[info.index] == true then
            small_card:SetClick(true);
            small_card:SetLock(true, gs_misc['str_35'])
        else
            small_card:SetClick(false);
        end
    else
        small_card:SetClick(true);
        small_card:SetTranslucent(false);
    end


    if self._buildingEmbattle and self._buildingEmbattle[self._selectIndex][2] == info.index  then 
        self:on_click_card(small_card,info);
    end
end

function AttackBuildingEmbattleChoseHeroUI:save_chose_hero()

end

function AttackBuildingEmbattleChoseHeroUI:on_click_card(obj, cardinfo)

    local hasDeadHero = CityRobberyMgr.GetInst():GetHasDeadHeros()
    if hasDeadHero[cardinfo.index] == true then
        HintUI.SetAndShow(EHintUiType.zero, gs_misc['str_36']);
        return
    end

    HeroChoseUI.on_click_card(self, obj, cardinfo)
end

]]