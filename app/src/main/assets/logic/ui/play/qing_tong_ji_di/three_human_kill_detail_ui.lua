
ThreeHumanKillDetailUi = Class("ThreeHumanKillDetailUi",UiBaseClass)

local resPath = "assetbundles/prefabs/ui/new_fight/new_fight_ui_fuzion.assetbundle"

local sideRootNodeName = 
{
    "cont_left",
    "cont_right",
}

local sideRootChildPrex = 
{
    "sp_bk",
    "big_card_item_80"
}

function ThreeHumanKillDetailUi:Init(data)
    self.pathRes = resPath
	UiBaseClass.Init(self, data);
end

function ThreeHumanKillDetailUi:InitData(data)
    UiBaseClass.InitData(self,data);

    self.systemId = MsgEnum.eactivity_time.eActivityTime_threeToThree;
    self.dataCenter = g_dataCenter.activity[self.systemId];

    self.playLowHpEct = 30
    local boundary = ConfigManager.Get(EConfigIndex.t_discrete,83000119)
    if boundary then
        self.playLowHpEct = tostring(boundary.data)
    end
    self.playLowHpEct = self.playLowHpEct/100

end

function ThreeHumanKillDetailUi:InitUI(obj)
    UiBaseClass.InitUI(self, obj)

    self.rolesInfo = {}
    for si = 1, 2 do
        local sideInfo = {}
        self.rolesInfo[si] = sideInfo

        sideInfo.rootNode = self.ui:get_child_by_name(sideRootNodeName[si])

        for i = 1, 3 do
            local roleInfo = {}
            sideInfo[i] = roleInfo
            roleInfo.node = sideInfo.rootNode:get_child_by_name(sideRootChildPrex[si] .. tostring(i))
            roleInfo.parent = roleInfo.node:get_child_by_name('big_card_item_80')
            roleInfo.smallCardUi = SmallCardUi:new({stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Star, SmallCardUi.SType.Rarity }, parent = roleInfo.parent})
            roleInfo.hpProgress = ngui.find_progress_bar(roleInfo.node, 'pro_xuetiao')
            roleInfo.killLab = ngui.find_label(roleInfo.node, 'content1/lab')
            roleInfo.beKilledlab = ngui.find_label(roleInfo.node, 'content2/lab')
            roleInfo.reliveTimeLab = ngui.find_label(roleInfo.node, 'lab_time')

            if i == 1 and si == 1 then
                roleInfo.beAttackedTipSp = ngui.find_sprite(roleInfo.node, "sp_shine")
                roleInfo.beAttackedTipSp:set_active(false)
            end
        end
    end
end

function ThreeHumanKillDetailUi:DestroyUi()
    UiBaseClass.DestroyUi(self)

    if self.rolesInfo then

        for si = 1, 2 do
            local sideInfo = self.rolesInfo[si]
            for i = 1, 3 do
                local roleInfo = sideInfo[i]
                roleInfo.smallCardUi:DestroyUi()
            end
        end

        self.rolesInfo = nil
    end
end

function ThreeHumanKillDetailUi:SetHeadData()
    if self.playList then return end

    local captain = g_dataCenter.fight_info:GetCaptain()
    if captain == nil then return end

    local heroList = {}
    heroList[1] = g_dataCenter.fight_info:GetHeroList(captain:GetCampFlag())
    if table.get_num(heroList[1]) < 3 then return end

    local enemyFlag = g_dataCenter.fight_info.single_friend_flag
    if captain:GetCampFlag() == enemyFlag then
        enemyFlag = g_dataCenter.fight_info.single_enemy_flag
    end
    heroList[2] = g_dataCenter.fight_info:GetHeroList(enemyFlag)
    if table.get_num(heroList[2]) < 3 then return end

    self.captainName = g_dataCenter.fight_info:GetCaptainName()

    self.playList = {}

    for si = 1, 2 do
        local sideList = {}
        self.playList[si] = sideList

        local noCaptains = {}
        for k,name in pairs(heroList[si]) do
            local obj = GetObj(name)
            if obj then
                local listRole = {}

                if obj:GetName() == captain:GetName() then
                    table.insert(sideList, listRole)
                else
                    table.insert(noCaptains, listRole)
                end

                listRole.heroName = name
                listRole.number = obj:GetConfigNumber()
            end
        end

        local vsPlayer = self.dataCenter:GetPlayerVs()
        if vsPlayer then
            table.sort(noCaptains, function(a, b)
                local aIndex = 1
                local bIndex = 1

                for k,v in pairs(vsPlayer) do
                    if v.roleId == a.number then
                        aIndex = k
                    else
                        bIndex = k
                    end
                end

                return aIndex < bIndex
            end
            )
        end
        for k,v in ipairs(noCaptains) do
            table.insert(sideList, v)
        end

        local roleSideList = self.rolesInfo[si]
        for i = 1, #sideList do
            local listRole = sideList[i]
            listRole.roleInfo = roleSideList[i]
            local obj = GetObj(listRole.heroName)
            local cardInfo = CardHuman:new({number=listRole.number, level = obj.level})
            listRole.roleInfo.smallCardUi:SetData(cardInfo)
        end
    end
end

function ThreeHumanKillDetailUi:UpdateHeadDta()

    if self.playList == nil then return end

    local reliveTimes = self.dataCenter:GetReliveTime()
    local killInfos = self.dataCenter:GetKillInfo()
    
    for si = 1, 2 do
        local sideList = self.playList[si]

        for i = 1, #sideList do
            local listRole = sideList[i]
            local obj = GetObj(listRole.heroName)
            local gid = obj:GetGID()
            local killNum = 0
            local beKill = 0
            if killInfos then
                local ki = killInfos[gid]
                if ki then
                    killNum = ki.kill
                    beKill = ki.dead
                end
            end
            if listRole.roleInfo.killLab then
                listRole.roleInfo.killLab:set_text(tostring(killNum))
            end
            if listRole.roleInfo.beKilledlab then
                listRole.roleInfo.beKilledlab:set_text(tostring(beKill))
            end

            local max_blood = obj:GetPropertyVal('max_hp');
            local cur_blood = obj:GetPropertyVal('cur_hp');

            local value = cur_blood / max_blood
            listRole.roleInfo.hpProgress:set_value(value)

            if i == 1 and value < self.playLowHpEct and listRole.lastShowHpValue ~= cur_blood then

                listRole.roleInfo.node:animated_stop("new_fight_ui_fuzion_cont_left")
                listRole.roleInfo.node:animated_play("new_fight_ui_fuzion_cont_left")

                listRole.lastShowHpValue = cur_blood
            end

            if cur_blood > 0 then
                listRole.roleInfo.smallCardUi:SetGray(false)
            else
                listRole.roleInfo.smallCardUi:SetGray(true)
            end

            local rt = reliveTimes[obj:GetGID()]
            if rt and rt > system.time() then
                listRole.roleInfo.reliveTimeLab:set_active(true)
                listRole.roleInfo.reliveTimeLab:set_text(tostring( rt - system.time() ) )
            else
                listRole.roleInfo.reliveTimeLab:set_active(false)
            end
        end
    end
end

function ThreeHumanKillDetailUi:Update(dt)  
    if self.ui == nil then return  end

    self:SetHeadData()
    self:UpdateHeadDta()
end