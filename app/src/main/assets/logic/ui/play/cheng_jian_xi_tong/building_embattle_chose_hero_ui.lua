
--[[
BuildingEmbattleChoseHeroUI = Class("BuildingEmbattleChoseHeroUI", HeroChoseUI);

function BuildingEmbattleChoseHeroUI:HasSelect(index)

    if self._buildingEmbattle == nil then
        return false
    end

    for k,v in ipairs(self._buildingEmbattle) do 
        if v[2] == index then
            return true
        end
    end
    

    return false
end

function BuildingEmbattleChoseHeroUI:InitCard(small_card, info)

--    if self.choseItemInfo == nil then
--        self:on_click_card(small_card,info);
--    end


    small_card:SetTeamPosIcon(0);
    --small_card:SetClick(true);
    --small_card:SetTranslucent(false);
    --self:on_click_card(small_card,info);
    if self:HasSelect(info.index) then 
        small_card:SetClick(false);
        small_card:SetTranslucent(true);
    else
        small_card:SetClick(true);
        small_card:SetTranslucent(false);
    end

    if self._buildingEmbattle and self._buildingEmbattle[self._selectIndex][2] == info.index  then 
        self:on_click_card(small_card,info);
        --app.log('xx ' .. info.index .. ' ' .. tostring(self._selectIndex) .. ' ' .. table.tostring(self._buildingEmbattle))
    end
end

function BuildingEmbattleChoseHeroUI:on_chose_hero()
    
    if self.choseItemInfo == nil then
        return
    end

    self._buildingEmbattle[self._selectIndex][2] = self.choseItemInfo.index
    --app.log('on_chose_item ' .. tostring(self.choseItemInfo.index) .. ' ' .. tostring(self._buildingEmbattle))
    self:save_chose_hero()
    self._buildingEmbattle = nil
    self._selectIndex = nil

    uiManager:PopUi()
end

function BuildingEmbattleChoseHeroUI:save_chose_hero()
    CityBuildingMgr.GetInst():SetBuildingGuardHero(self._buildingEmbattle)
end

function BuildingEmbattleChoseHeroUI:SetHasEmbattleTeam(embattle, selectIndex)
    --app.log('SetHasEmbattleTeam ' .. selectIndex .. ' ' .. table.tostring(embattle))
    self._buildingEmbattle = embattle
    self._selectIndex = selectIndex

    BuildingEmbattleChoseHeroUI.GbuildingEmbattleSave = self._buildingEmbattle
end
]]