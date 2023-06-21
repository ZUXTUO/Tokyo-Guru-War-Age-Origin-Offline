

EmbattleAutoFightManager = Class("EmbattleAutoFightManager", EmbattleFightManager)

function EmbattleAutoFightManager:InitInstance()


	EmbattleFightManager.InitInstance(self)
end

function EmbattleAutoFightManager:SetHeroTeamAI()
end

function EmbattleAutoFightManager:OnLoadHero(entity)
    EmbattleFightManager.OnLoadHero(self, entity)
    entity:SetDontReborn(true)

    entity:SetConfig("view_radius", 1000)
    entity:SetConfig("act_radius", 2000)

    entity:SetAI(100)
end


function EmbattleAutoFightManager:Destroy()
    
    EmbattleFightManager.Destroy(self)
end

function EmbattleAutoFightManager:SetCameraInitPos()
    local point = LevelMapConfigHelper.GetHeroBornPoint('cam_pos')
    CameraManager.LookToPos(Vector3d:new({x = point.px, y = point.py, z = point.pz}))
end

function EmbattleAutoFightManager:LoadHero()

    EmbattleFightManager.LoadHero(self)

    self:SetCameraInitPos()
end