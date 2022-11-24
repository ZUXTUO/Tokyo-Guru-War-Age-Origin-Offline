

EquipRecommendAction = Class("EquipRecommendAction")

function EquipRecommendAction:Init(data)

    self.heroTeamIndex = data.teamIndex
    self.heroDataid = data.heroDataid
    self.equipDataid = data.equipDataid
    self.equipPos = data.equipPos
    self.uiClass = data.uiClass
    self.checker = data.checker

end

function EquipRecommendAction:GetHeroTeamIndex()
    return self.heroTeamIndex
end

function EquipRecommendAction:GetEquipPos()
    return self.equipPos
end

function EquipRecommendAction:GetEquipDataid()
    return self.equipDataid
end

function EquipRecommendAction:GetHeroDataid()
    return self.heroDataid
end

function EquipRecommendAction:Start()
    self.uiInst = self.uiClass:new()
    self.uiInst:SetRecommendAction(self)
end

function EquipRecommendAction:Stop()

    self.checker:RecommandActionEnd(self)

    self.uiInst:DestroyUi()
    self.uiInst = nil
end

function EquipRecommendAction:IsEnd()
    return self.uiInst:IsEnd()
end

function EquipRecommendAction:Update(dt)
    if self.uiInst then
        self.uiInst:Update(dt)
    end
end
