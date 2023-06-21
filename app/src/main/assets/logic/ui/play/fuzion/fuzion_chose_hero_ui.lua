FuzionChoseHeroUI = Class("FuzionChoseHeroUI", HeroChoseUI)

function FuzionChoseHeroUI:SetTeam(team)
    self.team_ids = team;
	for i=1,1 do 
		self.teams[i] = {};
		self.teams[i].info = g_dataCenter.package:find_card(1,team[i]);
	end
    -- self:UpdatePackage(self.curShowType,true);
end

function FuzionChoseHeroUI:InitCard(small_card,info)
    small_card:SetTeamPosIcon(0);
    small_card:SetClick(info.index ~= 0);
    small_card:SetTranslucent(info.index == 0);
    for i=1,1 do
        if self.teams[i] then
            if self.teams[i].info and
                self.teams[i].info.index == info.index 
            then
                self.teams[i].obj = small_card;
                small_card:SetTeamPosIcon(i);
                if i ~= self.HeroPos then
                    small_card:SetClick(false);
                    small_card:SetTranslucent(true);
                end
                -- 初始选中
                if not self.choseItemInfo and i == self.HeroPos then
                    self:on_click_card(small_card,info);
                end
                break;
            end
        end
    end
    if self.choseItemInfo and self.choseItemInfo.number == info.number then
        self:on_click_card(small_card,info);
    end
end

function FuzionChoseHeroUI:on_chose_hero()
    local vecCardsRole={};
    for i=1,1 do
        if i == self.HeroPos then
            vecCardsRole[i] = self.choseItemInfo.index;
        elseif self.teams[i].info then
            vecCardsRole[i] = self.teams[i].info.index;
        else
            vecCardsRole[i] = "";
        end
    end
    local team = 
    {
        teamid = ENUM.ETeamType.fuzion,
        cards = vecCardsRole,
    }
    msg_team.cg_update_team_info(team);
    uiManager:PopUi();
end
