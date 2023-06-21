
UiGuardHeartRole3DScene = Class("UiGuardHeartRole3DScene")

local rePath = "assetbundles/prefabs/map/059_huahai/P_shouhuzhixing_001.assetbundle"

g_guardHeartFlowerAniName = 
{
    open = "fx_shouhuzhixin001",
    white = "fx_shouhuzhixin002",
    red = "fx_shouhuzhixin003",
    close = "fx_shouhuzhixin004",
}

function UiGuardHeartRole3DScene:Init(data)
    self:InitData(data)
    self:RegistFunc()
    self:LoadAsset()
end

function UiGuardHeartRole3DScene:InitData(data)
    self.initData = data
    self.bindfunc = {}
end

function UiGuardHeartRole3DScene:Destroy()
    self:UnRegistFunc()

    if self.ui3d then
        self.ui3d:set_active(false)
        self.ui3d = nil
    end
    if self.roleInst then
        for k,v in pairs(self.roleInst) do
            v:Destroy()
        end
        self.roleInst = nil
    end
end

function UiGuardHeartRole3DScene:LoadAsset()
    ResourceLoader.LoadAsset(rePath, self.bindfunc['OnLoadedBackground'], self._className);
end

function UiGuardHeartRole3DScene:RegistFunc()
	self.bindfunc['OnLoadedBackground'] = Utility.bind_callback(self, self.OnLoadedBackground)
    self.bindfunc['LoadOkCallback'] = Utility.bind_callback(self, self.LoadOkCallback)
end

function UiGuardHeartRole3DScene:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end

    self.bindfunc = nil
end

function UiGuardHeartRole3DScene:LoadOkCallback(obj)
    obj:SetPosition(0, 0, 0, true, false)
    obj:SetScale(1, 1, 1)
end

function UiGuardHeartRole3DScene:OnLoadedBackground(pid, filepath, asset_obj, error_info)
    if filepath == rePath then
        self:InitUi(asset_obj)
    end
end

function UiGuardHeartRole3DScene:InitUi(obj)
    self.ui3d = asset_game_object.create(obj);
    self.ui3d:set_name("role_3d_show");

    self.aniMationNode = {}
    self.roleParentNode = {}
    for i = 1, 5 do
        self.aniMationNode[i] = self.ui3d:get_child_by_name("F_shouhuzhixing002_00" .. i)
        self.aniMationNode[i]:animated_play(g_guardHeartFlowerAniName.white)

        self.roleParentNode[i] = self.ui3d:get_child_by_name("pos00" .. i)
        self.roleParentNode[i]:set_active(false)
    end

    self.roleInst = {}

    if self._delayShow then
        for k,v in ipairs(self._delayShow) do
            self:SetRoleCard(v.index, v.cardInfo)
        end
        self._delayShow = nil
    end
end

function UiGuardHeartRole3DScene:SetRoleCard(index, card)
    if self.ui3d == nil then

        self._delayShow = self._delayShow or {}

        table.insert(self._delayShow, { index = index, cardInfo = card })

        return
    end

    local parent = self.roleParentNode[index]
    if card then
        parent:set_active(true)
        if not self.roleInst[index] then
            self.roleInst[index]  = Role3d:new({parent = parent, role_id = card.number, no_cfg_pos = true, no_cfg_scale = true, load_call_back = self.bindfunc['LoadOkCallback'] })
        else
            if card.number ~= self.roleInst[index]:GetRoleID() then
                self.roleInst[index]:ChangeObj(card.number)
            end
        end
        self.aniMationNode[index]:animated_play(g_guardHeartFlowerAniName.red)

        --app.log("#hyg# SetRoleCard " .. index .. ' ' .. g_guardHeartFlowerAniName.red)
    else
        parent:set_active(false)
        self.aniMationNode[index]:animated_play(g_guardHeartFlowerAniName.white)
    end
end

function UiGuardHeartRole3DScene:PlayeEffect(index, effectid)
    local role = self.roleInst[index]
    if role then
        role:player_effect(effectid)
    end
end

function UiGuardHeartRole3DScene:PlayeAnimation(index, ani)
    if self.ui3d == nil then return end
    --app.log("#hyg# PlayeAnimation " .. index .. ' ' .. ani)
    self.aniMationNode[index]:animated_play(ani)
end
