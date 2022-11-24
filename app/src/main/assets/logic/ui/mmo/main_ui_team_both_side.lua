--[[
MainUITeamBothSide = Class('MainUITeamBothSide', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/new_fight_ui_jjc.assetbundle"

local sideNodeName = 
{
    "left_head_cont",
    "right_head_cont",
}

local campFalgs = 
{
    g_dataCenter.fight_info.single_friend_flag,
    g_dataCenter.fight_info.single_enemy_flag

}

local uiText = 
{
    [1] = "全能值:%d",
}

function MainUITeamBothSide:Init(data)
    self.pathRes = res
    UiBaseClass.Init(self, data);
end

function MainUITeamBothSide:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.listRole = {}
    self.hasSetHead = false
    for si = 1,2 do
        local sideInfo = {}
        self.listRole[si] = sideInfo
        sideInfo.sideRoot = self.ui:get_child_by_name(sideNodeName[si])
        for i = 1, 3 do
            local roleInfo = {}
            sideInfo[i] = roleInfo

            roleInfo.objRoot =sideInfo.sideRoot:get_child_by_name("big_card_item_80"..i)
            roleInfo.headParent = roleInfo.objRoot:get_child_by_name("big_card_item_80")
            roleInfo.progressBar = ngui.find_progress_bar(roleInfo.objRoot, "pro_xuetiao")

            roleInfo.smallCardItem = SmallCardUi:new({parent = roleInfo.headParent, stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Star, SmallCardUi.SType.Rarity}})
        end

        sideInfo.quannengNode = sideInfo.sideRoot:get_child_by_name("sp_bk")
        sideInfo.quannengLab = ngui.find_label(sideInfo.sideRoot, "sp_bk/lab")
    end

    self:SetSmallItem()
    self:UpdateHeadData()
end

function MainUITeamBothSide:DestroyUi()
    UiBaseClass.DestroyUi(self)

    if self.listRole then
        for si = 1, 2 do
            local sideInfo = self.listRole[si]
            for i = 1, 3 do
                sideInfo[i].smallCardItem:DestroyUi()
            end
        end
        self.listRole = nil
    end
end

function MainUITeamBothSide:TeamHeroProChanged()
    self.teamHeroProChanged = true
end

function MainUITeamBothSide:Update(dt)
    if self.teamHeroProChanged then
        self:UpdateHeadData()
    end
end

function MainUITeamBothSide:SetSmallItem()
    for si = 1, 2 do
        local heroList = g_dataCenter.fight_info:GetHeroList(campFalgs[si])
        local sideInfo = self.listRole[si]

        local index = 1
        local quanneng = 0
        for k,v in pairs(heroList) do
            local hero = GetObj(v)
            if hero then
                if not quanneng then
                    quanneng = hero:GetPropertyVal(ENUM.EHeroAttribute.quan_neng)
                end
                local roleInfo = sideInfo[index]
                roleInfo.smallCardItem:SetData(hero:GetCardInfo())
                index = index + 1

                sideInfo[hero:GetName()] = roleInfo
            end
        end

        -- if quanneng > 0 then
        --     sideInfo.quannengLab:set_text(tostring(quanneng))
        -- else
        --     sideInfo.quannengNode:set_active(false)
        -- end
        sideInfo.quannengLab:set_text(string.format(uiText[1], quanneng))

        for i = index, 3 do
            local roleInfo = sideInfo[i]
            roleInfo.progressBar:set_active(false)
        end
    end
end

function MainUITeamBothSide:UpdateHeadData()
    if self.ui == nil then return end

    for si = 1, 2 do
        local heroList = g_dataCenter.fight_info:GetHeroList(campFalgs[si])
        local sideInfo = self.listRole[si]

        local index = 1
        for k,v in pairs(heroList) do
            local hero = GetObj(v)
            if hero then
                local roleInfo = sideInfo[hero:GetName()]
                if roleInfo then
                    local curHp = hero:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
                    local maxHp = hero:GetPropertyVal('max_hp');
                    local value = curHp / maxHp;

                    roleInfo.progressBar:set_value(value)
                end
            end
        end
    end
end

function MainUITeamBothSide:RoleDead(name, relive_time)
    for si = 1, 2 do
        local sideInfo = self.listRole[si]
        local roleInfo = sideInfo[name]
        if roleInfo then
            roleInfo.smallCardItem:SetGray(true)
            break
        end
    end
end
]]