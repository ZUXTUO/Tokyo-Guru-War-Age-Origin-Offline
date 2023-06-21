
SLGMainCityFightManager = Class('SLGMainCityFightManager', FightManager)

function SLGMainCityFightManager:InitInstance()

    SLGMainCityFightManager._super.InitInstance(SLGMainCityFightManager)
    return SLGMainCityFightManager
end

function SLGMainCityFightManager:Start()

    local point = LevelMapConfigHelper.GetHeroBornPoint('cam_pos')
    CameraManager.LookToPos(Vector3d:new({x = point.px, y = point.py, z = point.pz}))

    SLGMainCityFightManager._super.Start(self)

end

function SLGMainCityFightManager:LoadSceneObject()
    self:LoadItem()
    self:LoadUI()
end

function SLGMainCityFightManager:LoadItem()

    local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.item)

    if not config then
        return
    end
    for k,ml_v in pairs(config) do
        local item =  ObjectManager.CreateItem(ml_v.id, 0, ml_v.item_modelid, ml_v.item_effectid)
        item:SetPosition(ml_v.px,ml_v.py,ml_v.pz, false, false)
        item:SetRotation(ml_v.rx,ml_v.ry,ml_v.rz)
        item:SetScale(ml_v.sx,ml_v.sy,ml_v.sz)
        item:SetAI(ENUM.EAI.SLG_DianZhang)
    end
end

function SLGMainCityFightManager:LoadUI()

    if FightScene.isResume ~= true then
        uiManager:PushUi(EUI.MyBuildingSceneUI2)
    else
        --uiManager:Restart()
    end
end

function SLGMainCityFightManager:Destroy()
    SLGMainCityFightManager._super.Destroy(self)
    ObjectManager.Destroy()
    uiManager:DestroyAll()
    AudioManager.Stop(nil, true);
    --AudioManager.Destroy();
end

function SLGMainCityFightManager:Update(dt)
    CityBuildingMgr.GetInst():Update(dt)
end
